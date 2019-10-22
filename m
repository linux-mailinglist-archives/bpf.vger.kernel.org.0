Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17CE0BA8
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 20:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbfJVSpG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 22 Oct 2019 14:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732316AbfJVSpG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 14:45:06 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 869C2C057E9F
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 18:45:05 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id q185so3148749ljb.20
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 11:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fK6KU9+jt/PI0Yf4JBx3TAHMCuwyZftBgg3z8f1NuQY=;
        b=S7kQp6WW25GvmLATE/HulHsuwXHCau9ilbZu//qhiyP8f7Hjj5mbiyIBJKfq5ziyUJ
         Dry3Ea/KRqbPpR0S92HItmIgxWqLH0QM5wQ1+LQ5RUYaKG8lRJATSmFOfruygNCthZz2
         93hSAJ5JpAGFydjGbP+a3y3oU1Xifq/hffaCoxpJG5M5B+931Bbd2xYuZgW4fJGBiljQ
         TVydIrNIlRQ6oW8nkR3FI37b8hzHAzYrzU3Bqyv0R+OY7KCbzLHslb4LCr4BKxtDabpo
         /HIEM9S07wl5xCCKaeXadASvaogTnAN3xY6qquuRWlNBf4WGF5TNZrrlrrndSgZ+aPe7
         j2FA==
X-Gm-Message-State: APjAAAXZF1GmGgLasDTGRgh/3JQdLbFHlFs94QPvUj3GaCAqQ3772MrA
        e6DG7Pe+6AHf4QTSto0TD3iA8RPCCBf1a9JxRI2fEdfLQ5d6QSV6rnDetxl7r5M6uCI9nZfV3VP
        7vqYupvhBWB7E
X-Received: by 2002:ac2:4345:: with SMTP id o5mr4937511lfl.60.1571769903946;
        Tue, 22 Oct 2019 11:45:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxuZB+ANgre+Jh5lJtS8meRgdKB+C/D2sofJQ2kVK1GbnNjJoJM12jifrAkyuA6FduKQs5xLA==
X-Received: by 2002:ac2:4345:: with SMTP id o5mr4937493lfl.60.1571769903646;
        Tue, 22 Oct 2019 11:45:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id m6sm8074879ljj.3.2019.10.22.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 11:45:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DE1F01804B1; Tue, 22 Oct 2019 20:45:01 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] libbpf: Store map pin path in struct bpf_map
In-Reply-To: <CAEf4BzapbVb=u_GPLSv-KEctwZz=K3FUb_B6p2HmWnqz06n4Rg@mail.gmail.com>
References: <157175668770.112621.17344362302386223623.stgit@toke.dk> <157175668879.112621.10917994557478417780.stgit@toke.dk> <CAEf4BzatAgkOiS2+EpauWsUWymmjM4YRBJcSqYj15Ywk8aP6Lw@mail.gmail.com> <87blu8odhf.fsf@toke.dk> <CAEf4BzapbVb=u_GPLSv-KEctwZz=K3FUb_B6p2HmWnqz06n4Rg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 20:45:01 +0200
Message-ID: <878spcoc0i.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Oct 22, 2019 at 11:13 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Tue, Oct 22, 2019 at 9:08 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>> >>
>> >> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> >>
>> >> When pinning a map, store the pin path in struct bpf_map so it can be
>> >> re-used later for un-pinning. This simplifies the later addition of per-map
>> >> pin paths.
>> >>
>> >> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> >> ---
>> >>  tools/lib/bpf/libbpf.c |   19 ++++++++++---------
>> >>  1 file changed, 10 insertions(+), 9 deletions(-)
>> >>
>> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> >> index cccfd9355134..b4fdd8ee3bbd 100644
>> >> --- a/tools/lib/bpf/libbpf.c
>> >> +++ b/tools/lib/bpf/libbpf.c
>> >> @@ -226,6 +226,7 @@ struct bpf_map {
>> >>         void *priv;
>> >>         bpf_map_clear_priv_t clear_priv;
>> >>         enum libbpf_map_type libbpf_type;
>> >> +       char *pin_path;
>> >>  };
>> >>
>> >>  struct bpf_secdata {
>> >> @@ -1929,6 +1930,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>> >>         if (err)
>> >>                 goto err_close_new_fd;
>> >>         free(map->name);
>> >> +       zfree(&map->pin_path);
>> >>
>> >
>> > While you are touching this function, can you please also fix error
>> > handling in it? We should store -errno locally on error, before we
>> > call close() which might change errno.
>>
>> Didn't actually look much at the surrounding function, TBH. I do expect
>> that I will need to go poke into this for the follow-on "automatic reuse
>> of pinned maps" series anyway. But sure, I can do a bit of cleanup in a
>> standalone patch first :)
>>
>> >>         map->fd = new_fd;
>> >>         map->name = new_name;
>> >> @@ -4022,6 +4024,7 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
>> >>                 return -errno;
>> >>         }
>> >>
>> >> +       map->pin_path = strdup(path);
>> >
>> > if (!map->pin_path) {
>> >     err = -errno;
>> >     goto err_close_new_fd;
>> > }
>>
>> Right.
>>
>> >>         pr_debug("pinned map '%s'\n", path);
>> >>
>> >>         return 0;
>> >> @@ -4031,6 +4034,9 @@ int bpf_map__unpin(struct bpf_map *map, const char *path)
>> >>  {
>> >>         int err;
>> >>
>> >> +       if (!path)
>> >> +               path = map->pin_path;
>> >
>> > This semantics is kind of weird. Given we now remember pin_path,
>> > should we instead check that user-provided path is actually correct
>> > and matches what we stored? Alternatively, bpf_map__unpin() w/o path
>> > argument looks like a cleaner API.
>>
>> Yeah, I guess the function without a path argument would make the most
>> sense. However, we can't really change the API of bpf_map__unpin()
>> (unless you're proposing a symbol-versioned new version?). Dunno if it's
>> worth it to include a new, somewhat oddly-named, function to achieve
>> this? For the internal libbpf uses at least it's easy enough for the
>> caller to just go bpf_map__unpin(map, map->pin_path), so I could also
>> just drop this change? WDYT?
>
> I'd probably do strcmp(map->pin_path, path), if path is specified.
> This will support existing use cases, will allow NULL if we don't want
> to bother remembering pin_path, will prevent weird use case of pinning
> to one path, but unpinning another one.

So something like

if (path && map->pin_path && strcmp(path, map->pin_path))
 return -EINVAL
else if (!path)
 path = map->pin_path;

?

> Ideally, all this pinning will just be done declaratively and will
> happen automatically, so users won't even have to know about this API
> :)

Yeah, that's where I'm hoping to get to. But, well, the pin/unpin
functions already exist so we do need to keep them working...

-Toke
