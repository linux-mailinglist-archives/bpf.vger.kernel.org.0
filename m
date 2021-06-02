Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C193994B4
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhFBUlV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 16:41:21 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:34509 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhFBUlV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 16:41:21 -0400
Received: by mail-yb1-f178.google.com with SMTP id 207so5694602ybd.1;
        Wed, 02 Jun 2021 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jH9Km0sW+e85jIkcVlCUV9nNpCoyqzLfRUfOX89o950=;
        b=kA7YD/U6qqYY+oS6qeSA5xGolI9ulECh8h7zIOBm7R6ptQ0FJQNo8gx6Yi1gRFNRu6
         zd0HiKgfW8sSht7L7e2RJ5eSjW0XwQVIPgLYkrk+ncLAEEy1pvrq/iMYi/rW74CKfopu
         H8BncgD+EoR5462qisDIP8S77FOdkBL8hqiW07kAKE4Skidy9+vy3um6aQz/MQbV3mEO
         crHvzSKXBHYjG/OFiSnnJEL9JNNHsI4kysXQNtBH3ISb2T6dZHY59RIjXMme/g1lYvHa
         y7s6Td8kvw559Y5TNu9AlQcR9Qrm+wU9LTtz6rPklKU0BRhQDsCMFWouTEr1CzSd5k9h
         n0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jH9Km0sW+e85jIkcVlCUV9nNpCoyqzLfRUfOX89o950=;
        b=AqP8iaxKIzX452Mt5Axr1NDt+FFtVNWCqENQG89gdU2uxHGWGkSI2jevoDWkzsUzpW
         3sqE/vXLv6RPvqf2SThv2THcM7WgTuJSP/vb1Gnw4HyAWpCwIpTVpY3w7AnmK90YvJpm
         3Zhx1bgsfE3s4hEJkgthB05dL//Ru6WdI4sRLwkfP5BRBwoAMQwFZG5CwKDiU+IZ6R9/
         ZqvKoAN8mGWkBgfhuDKkWEIqyCIuPp/6i+NRKOKWO2g6h7tCPoylt0y9kwQxD1rW3t50
         vay+JZvD5U3bC0R8yL7mfUBSZPg88f3MWzFj9IrXnpXDijqXEEVe+CBVj7y5xgiEGLgx
         x9CA==
X-Gm-Message-State: AOAM532xrVy1wRJhTX8Fgd5dFek198vRg9qRdk1HZ8vzpxyeuris7/iw
        HFXrUQv5faV1WEEYufHCU3R2Vz1wCl91ZzNvkRSw1oQTkwI=
X-Google-Smtp-Source: ABdhPJxd7/KqsFsQRVJxGd9d6D5FF2i8zzcP9oxHtND3qNVgPq5hztTiqlMl4SjeJbu0brXJ7jgfcZxnH9kwNZYoKS4=
X-Received: by 2002:a25:6612:: with SMTP id a18mr14916915ybc.347.1622666317263;
 Wed, 02 Jun 2021 13:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210531195553.168298-1-grantseltzer@gmail.com> <20210531195553.168298-3-grantseltzer@gmail.com>
In-Reply-To: <20210531195553.168298-3-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Jun 2021 13:38:26 -0700
Message-ID: <CAEf4BzbpgEVq0f=A4=qOYfOaP_L8z3044GVYQoFcyW-044q-vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] Remove duplicate README doc from libbpf
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 31, 2021 at 12:56 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> This removes the README.rst file from libbpf code which is moved into
> Documentation/bpf/libbpf in the previous commit
>
> Signed-off-by: grantseltzer <grantseltzer@gmail.com>
> ---

Let's keep this removal together with the previous patch, that way git
should be able to detect the file move and minimize the diff.

>  tools/lib/bpf/README.rst | 168 ---------------------------------------
>  1 file changed, 168 deletions(-)
>  delete mode 100644 tools/lib/bpf/README.rst
>

[...]
