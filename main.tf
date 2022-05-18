terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.6"
      source  = "conradludgate/spotify"
    }
  }
}

provider "spotify" {
  api_key = var.spotify_api_key
}
#Adding song to the Playlist by Artist and Album
data "spotify_search_track" "ed-sheeran" {
  artist = "Ed Sheeran"
    album = "No.6 Collaborations Project"
    #limit = 1
}
data "spotify_search_track" "david-guetta" {
  artist = "David Guetta"
    album = "Family"
}

#Adding song to the Playlist by ID
data "spotify_track" "stand_strong" {
  spotify_id = "1XUf5lpeTQbrohZWdx6Sbz"
}

data "spotify_track" "leave_a_light_on" {
  spotify_id = "6lOWoTqVnAWXchddtTH31W"
}
#Adding song to the Playlist by URL
 data "spotify_track" "tears" {
   url = "https://open.spotify.com/track/1jVAfsSceuAQx7zgY76qDA?si=b1f4f946f7b04751"
 }

resource "spotify_playlist" "playlist" {
  name        = "About Me Playlist"
  description = "This playlist was created by Israel Effiong"
  public      = true

  tracks = flatten([
    data.spotify_search_track.ed-sheeran.tracks[2].id,
    data.spotify_search_track.david-guetta.tracks[0].id,
    data.spotify_track.stand_strong.spotify_id,
    data.spotify_track.leave_a_light_on.spotify_id,
    data.spotify_track.tears.id
  ])
}
