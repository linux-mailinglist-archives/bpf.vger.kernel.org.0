Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA97313D31
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhBHSVq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 13:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbhBHSUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 13:20:39 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A8C06178A
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 10:19:58 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hs11so26611300ejc.1
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 10:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BrV4jSS1TM+JW8+vekj8Ma6BSA+Njb6a/FvQvgRw5AY=;
        b=f/zI69afYLsSDC1NZV465ewx46fo385kUxkvYSMkPuZ86FW59Z+ScUrjtiGjadJY5D
         ynhseDIcZpnpgnFj/tztBwHWRIQQjOXWyt8iHyLOIYBABQLIEoZLTLv92IJy84E/nvgk
         Jh8zNbMPx0qkp/KISb87ItU0ujhYHUzL1Xdwq73UOqSbZpa4U7h8OlA+SsWdPsarZYMD
         uZIUttjIhPf5oO+bnyI/pIsNwhfzayusaXmWzgjmTqwiAATE4kBSTViUCJlCpyeRs7nz
         ltjiDd9xlvaUkEPeb2Va6T/TvU7nJPlpHY9ClE0SVsJ1JEIBBZGqfLPj2ypioyh+wlB9
         nO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BrV4jSS1TM+JW8+vekj8Ma6BSA+Njb6a/FvQvgRw5AY=;
        b=eBV5cB70HAiRjk8nkB52kVXPIDHXS3RH+zUIR/YQHsHmanOAhRv+bFWFh+wCBPe18S
         enUfkYyCs9CjFsk2dxLd76/BszyR680ZjQmHagNixA+WD258XS0rJ3QBYIH7+UYZdtrs
         teNmFKVQ5elhVEM9ISzrg47ddBz/VEUWReQ7wqZLqn0Hkc0NTrPBxVZNb/gvvetxjM6S
         zsLjZvyP0Hir1iIg40nXuZPjyhEzKUv7A5uZv5v83dLPn5+lCbdutSkvOQEWsV0aOrlW
         nMtU6i1EJAHgatScO9RkUNzSWlOIV6EMQEuvzXrKBub4IXulkNYkb5TdjmUaFKsM3eyx
         jJ5w==
X-Gm-Message-State: AOAM53275wYIoeo42dm3fvd5qp7puqwPezfwVBao/14p/XJOWngqqscX
        lcDWERhS/rCWo5TxgdJl+yCgXZ6OOczox2ALu+s=
X-Google-Smtp-Source: ABdhPJxYQWw5n+NgN1iZ38fz1tFWxbgvlg2i/lyZM142+iMFJW6L/cszrsi9r1lxvxxbyxFwMMstYoV3CUMi5xbWeGg=
X-Received: by 2002:a17:906:c081:: with SMTP id f1mr10417434ejz.97.1612808396625;
 Mon, 08 Feb 2021 10:19:56 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk> <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
 <87mtwetz04.fsf@toke.dk> <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
 <87blcutx3v.fsf@toke.dk> <CANaYP3FEheoxSp86sFair0CAQz1-fkdmGp0_zvgGqQr_3P+qdg@mail.gmail.com>
 <875z32tpel.fsf@toke.dk>
In-Reply-To: <875z32tpel.fsf@toke.dk>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Mon, 8 Feb 2021 20:19:21 +0200
Message-ID: <CANaYP3EUOLf=8+ZuKFr4ozPueqgjvzxkEK+O8WEamwY01yATaA@mail.gmail.com>
Subject: Re: libbpf: pinning multiple progs from the same section
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 7:55 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Gilad Reti <gilad.reti@gmail.com> writes:
>
> > On Mon, Feb 8, 2021 at 5:09 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >>
> >> > On Mon, Feb 8, 2021 at 4:28 PM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> >> >>
> >> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >> >>
> >> >> > On Mon, Feb 8, 2021 at 1:42 PM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
> >> >> >>
> >> >> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >> >> >>
> >> >> >> > Also, is there a way to set the pin path to all maps/programs =
at once?
> >> >> >> > For example, bpf_object__pin_maps pins all maps at a specific =
path,
> >> >> >> > but as far as I was able to find there is no similar function =
to set
> >> >> >> > the pin path for all maps only (without pinning) so that at lo=
ading
> >> >> >> > time libbpf will try to reuse all maps. The only way to achiev=
e a
> >> >> >> > complete reuse of all maps that I could find is to "reverse en=
gineer"
> >> >> >> > libbpf's pin path generation algorithm (i.e. <path>/<map_name>=
) and
> >> >> >> > set the pin path on each map before load.
> >> >> >>
> >> >> >> You can set the 'pinning' attribute in the map definition - add
> >> >> >> '__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By def=
ault
> >> >> >> this will pin beneath /sys/fs/bpf, but you can customise that by=
 setting
> >> >> >> the pin_root_path attribute in bpf_object_open_opts.
> >> >> >
> >> >> > Yes, I am familiar with that feature, but it has some downsides:
> >> >> > 1. I need to set it manually on every map (and in cases that I ha=
ve
> >> >> > only the compiled object file that would be hard).
> >> >> > 2. It only works for bpf maps and not bpf programs.
> >> >> > 3. It only works for bpf maps that are defined explicitly in the =
bpf
> >> >> > code and not for implicit (inner) bpf maps (bss, rodata, etc).
> >> >>
> >> >> Ah, right. Well, other than that I don't think there's a way to set=
 pin
> >> >> paths in bulk, other than by manually iterating and setting them on=
e at
> >> >> a time. But, erm, can't you just do that? :)
> >> >>
> >> >
> >> > Sure, I can, but I think we should avoid that. As I said this forces
> >> > the user to know libbpf's pin path naming algorithm, which is not pa=
rt
> >> > of the libbpf api afaik.
> >>
> >> Why? If you set the pin path from your application, libbpf will also t=
ry
> >> to reuse the map from that path. So you don't need to know libbpf's
> >> algorithm if you just override it with your own paths?
> >>
> >
> > If I do bpf_object__pin_maps then libbpf decides where it wants to pin
> > them. I can set each path by my own, but then why do we need this
> > function?
>
> Erm, what do you mean, "libbpf decides". bpf_object__pin_maps(obj, path)
> does exactly what you're asking for: If you supply the path, all maps
> are going to be pinned by name underneath that directory...

They are pinned under this directory, but with which filename? Today
libbpf builds the filename by taking the map name and escaping it, but
what will happen if this will have to change?
For example, libbpf pins programs by thier section name, but as I
mentioned in the first message in this thread this causes failures
when multiple programs reside in one section, so we may need to change
the naming and this can break user code.

>
> > All It does is pinning all the maps at paths that are not part of the
> > api. In this libbpf version it is here, in the next it is there, and
> > user code will need to change accordingly.
>
> Why would you assume the paths would change? That would be an API break?

The point that I am trying to make is that this naming convention is
libbpf internal, so either it should be defined as a part of the api
and each user will need to implement the same naming logic on his side
(escaping etc), relying on libbpf implementation to remain consistent
(this may be the case right now) but for in cases like the program
pinning for example api will have to break, or just expose the pinning
path as another api and then libbpf will need to make no guarantees
about his naming convention.

>
> > For example, libbpf today uses <path>/<map_name> as the pin path, but
> > it is also doing sanitize_pin_path on each path. This means that after
> > if use bpf_object__pin_maps I also need to know how libbpf sanitizes
> > its paths and mimic that behavior on my side.
>
> The paths are sanitised so the kernel will accept them. If you're using
> invalid paths your pinning is not going to work at all. If you just want
> the paths that the maps are pinned under, use bpf_map__get_pin_path().
>

I am not saying that sanitization is redundant, but rather that it
needs to be properly defined (i.e. all dots will always be replaced
with underscores), so either expose it in the api or document it so
that users don't have to look after the specific implementation.
Of course I can retrieve that paths after pinning, but this is sounds
like sort of a workaround to me, though I am okay with staying this
way. The problem that I have with this approach is that if other
processes want to reuse the same map they will have to share the
pinning path somehow instead of each one retreiving it from the map
directly.

> >> > I think that if we have a method to pin all maps at a specific path
> >> > there should also be a method for reusing them all from this path,
> >> > either by exposing the function that builds the pin path, or a
> >> > function that sets all the paths from a root path.
> >>
> >> What you're asking for is basically a function
> >> bpf_object__set_all_pin_paths(obj, path)
> >>
> >> instead of having to do
> >>
> >> bpf_object__for_each_map(map, obj) {
> >>   sprintf(path, "path/%s", bpf_map__name(map));
> >>   bpf_map__set_pin_path(map, path);
> >> }
> >>
> >> or? Is that really needed?
> >>
> >
> > Yes, that is what I am asking for. Either that or a
> > bpf_map__build_pin_path(path, map) That will return a pin path that is
> > compatible with libbpf's one, and then I can iterate over all maps.
>
> See above; this is what bpf_object__pin_maps() does today?

I didn't get this last comment. What I meant is that I want something
like the bpf_object__pin_maps but that doesn't pin the maps, just
exposing its naming part.

>
> -Toke
>
