Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F21314A68
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 09:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBIIgm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 03:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhBIIg1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 03:36:27 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039C7C061786
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 00:35:46 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id sa23so30029508ejb.0
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 00:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qNQM0XtlIh5xlzxu7vulllKdB4/6H1gCCdkgHmtKYNA=;
        b=Ow4zNOPiRUWOxEnUm9B+6NHyUWFZu7kSJvnGfejGKmTDk6WK3qsyCABh6FcnbxtENB
         hpnegQRyH7sWylJxS+w60LI5G3ZvR+KdRL8i7WpJnS0dObVvddxJOw9l7qHiKaBjTzND
         67k9ZRMpN6LL209QqQW/rthCJ/4sjXHWXcNs6SWZKAsbZWHyCGkK3TUzBB52cuaHeL7/
         TcvGtcP+XR1NlBWSO/FlOQF1qaksly3kdCBoWgkNPJmvr5e4y8m48Kkq6/u8x54rDUhN
         H8JMZCH4FvLjm5shZKAGCUKyTKv0NuprOi+AHChzY+8Z7i/vm4Y52Fd8+DrtZ1O4E1+K
         9GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qNQM0XtlIh5xlzxu7vulllKdB4/6H1gCCdkgHmtKYNA=;
        b=rWkg+A6iMUTnFkaul+hQAbxmRPWvJ+zATy5TXTeQGv7sBExoiQqgfHsl6CCL9+Sa5z
         1Ooar7PwkbUbDQIT5lwvNmcS4/EIjzLmVeQiLW7f1f3AyiLJweYOgZEueAwGzp0lrO3D
         cbAcmWMfD5GqHJTj1NmD3R8nGVgRjGReEvDT4SK5Zy05+6E+zHf/r8IkfRm61Beup+yN
         f9PyWbRmsZn2HfkAjOZB/mUHHdepV8ZoZTagsftaGMN0PlWK8XNckVdtrtGBciz6EWLD
         fMZLS/WXbSoqnD0XghakKtJZdudnj1tTcivW4oP2qw3SoretW2i6fUupkm43uSCqmEQ3
         odCA==
X-Gm-Message-State: AOAM533MDxBayfO4VLvBt69d8Ra9HruxOa61/UZ9mC3mcVc7pDeYE5MF
        rN950VepMCvdTr9Y+tCFUWSRDWkbybQOI+pJkVqF1IAa3mM=
X-Google-Smtp-Source: ABdhPJzU51Nj8fjRz83JiwWyV3ADWYIt21KBnFilnBYzb8CwpvqilKinD0FVJZ7NYjpCGckDhNDHTFriJ5/W6DikV5w=
X-Received: by 2002:a17:906:c081:: with SMTP id f1mr13436442ejz.97.1612859744621;
 Tue, 09 Feb 2021 00:35:44 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk> <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
 <87mtwetz04.fsf@toke.dk> <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
 <87blcutx3v.fsf@toke.dk> <CANaYP3FEheoxSp86sFair0CAQz1-fkdmGp0_zvgGqQr_3P+qdg@mail.gmail.com>
 <875z32tpel.fsf@toke.dk> <CANaYP3EUOLf=8+ZuKFr4ozPueqgjvzxkEK+O8WEamwY01yATaA@mail.gmail.com>
 <87zh0es73x.fsf@toke.dk>
In-Reply-To: <87zh0es73x.fsf@toke.dk>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Tue, 9 Feb 2021 10:35:08 +0200
Message-ID: <CANaYP3G+rtJuMAaTvdxSZCEtA9tSqh00OCkJ0LoeL7L030w0VQ@mail.gmail.com>
Subject: Re: libbpf: pinning multiple progs from the same section
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 9:16 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Gilad Reti <gilad.reti@gmail.com> writes:
>
> > On Mon, Feb 8, 2021 at 7:55 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >>
> >> > On Mon, Feb 8, 2021 at 5:09 PM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> >> >>
> >> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >> >>
> >> >> > On Mon, Feb 8, 2021 at 4:28 PM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
> >> >> >>
> >> >> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >> >> >>
> >> >> >> > On Mon, Feb 8, 2021 at 1:42 PM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >> >> >> >>
> >> >> >> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >> >> >> >>
> >> >> >> >> > Also, is there a way to set the pin path to all maps/progra=
ms at once?
> >> >> >> >> > For example, bpf_object__pin_maps pins all maps at a specif=
ic path,
> >> >> >> >> > but as far as I was able to find there is no similar functi=
on to set
> >> >> >> >> > the pin path for all maps only (without pinning) so that at=
 loading
> >> >> >> >> > time libbpf will try to reuse all maps. The only way to ach=
ieve a
> >> >> >> >> > complete reuse of all maps that I could find is to "reverse=
 engineer"
> >> >> >> >> > libbpf's pin path generation algorithm (i.e. <path>/<map_na=
me>) and
> >> >> >> >> > set the pin path on each map before load.
> >> >> >> >>
> >> >> >> >> You can set the 'pinning' attribute in the map definition - a=
dd
> >> >> >> >> '__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By =
default
> >> >> >> >> this will pin beneath /sys/fs/bpf, but you can customise that=
 by setting
> >> >> >> >> the pin_root_path attribute in bpf_object_open_opts.
> >> >> >> >
> >> >> >> > Yes, I am familiar with that feature, but it has some downside=
s:
> >> >> >> > 1. I need to set it manually on every map (and in cases that I=
 have
> >> >> >> > only the compiled object file that would be hard).
> >> >> >> > 2. It only works for bpf maps and not bpf programs.
> >> >> >> > 3. It only works for bpf maps that are defined explicitly in t=
he bpf
> >> >> >> > code and not for implicit (inner) bpf maps (bss, rodata, etc).
> >> >> >>
> >> >> >> Ah, right. Well, other than that I don't think there's a way to =
set pin
> >> >> >> paths in bulk, other than by manually iterating and setting them=
 one at
> >> >> >> a time. But, erm, can't you just do that? :)
> >> >> >>
> >> >> >
> >> >> > Sure, I can, but I think we should avoid that. As I said this for=
ces
> >> >> > the user to know libbpf's pin path naming algorithm, which is not=
 part
> >> >> > of the libbpf api afaik.
> >> >>
> >> >> Why? If you set the pin path from your application, libbpf will als=
o try
> >> >> to reuse the map from that path. So you don't need to know libbpf's
> >> >> algorithm if you just override it with your own paths?
> >> >>
> >> >
> >> > If I do bpf_object__pin_maps then libbpf decides where it wants to p=
in
> >> > them. I can set each path by my own, but then why do we need this
> >> > function?
> >>
> >> Erm, what do you mean, "libbpf decides". bpf_object__pin_maps(obj, pat=
h)
> >> does exactly what you're asking for: If you supply the path, all maps
> >> are going to be pinned by name underneath that directory...
> >
> > They are pinned under this directory, but with which filename? Today
> > libbpf builds the filename by taking the map name and escaping it, but
> > what will happen if this will have to change?
>
> Then that would have to be done in a way that was backwards-compatible
> so as not to break user code :)
>
> >> > For example, libbpf today uses <path>/<map_name> as the pin path, bu=
t
> >> > it is also doing sanitize_pin_path on each path. This means that aft=
er
> >> > if use bpf_object__pin_maps I also need to know how libbpf sanitizes
> >> > its paths and mimic that behavior on my side.
> >>
> >> The paths are sanitised so the kernel will accept them. If you're usin=
g
> >> invalid paths your pinning is not going to work at all. If you just wa=
nt
> >> the paths that the maps are pinned under, use bpf_map__get_pin_path().
> >>
> >
> > I am not saying that sanitization is redundant, but rather that it
> > needs to be properly defined (i.e. all dots will always be replaced
> > with underscores), so either expose it in the api or document it so
> > that users don't have to look after the specific implementation.
>
> Lack of documentation is a perennial problem, and patches are always
> welcome. But it is API: libbpf does things a certain way today, and if
> it changes in a way that will break user programs, that is an API break.
>

Okay than, you got me convinced. If we agree that sanitization etc is
all part of the api then I am fine with the current state. I am still
somewhat uncomfortable with forcing the user to read libbpf's source
code just to find out the implementation details, but it may be that
we only need more documentation.

> >> >> > I think that if we have a method to pin all maps at a specific pa=
th
> >> >> > there should also be a method for reusing them all from this path=
,
> >> >> > either by exposing the function that builds the pin path, or a
> >> >> > function that sets all the paths from a root path.
> >> >>
> >> >> What you're asking for is basically a function
> >> >> bpf_object__set_all_pin_paths(obj, path)
> >> >>
> >> >> instead of having to do
> >> >>
> >> >> bpf_object__for_each_map(map, obj) {
> >> >>   sprintf(path, "path/%s", bpf_map__name(map));
> >> >>   bpf_map__set_pin_path(map, path);
> >> >> }
> >> >>
> >> >> or? Is that really needed?
> >> >>
> >> >
> >> > Yes, that is what I am asking for. Either that or a
> >> > bpf_map__build_pin_path(path, map) That will return a pin path that =
is
> >> > compatible with libbpf's one, and then I can iterate over all maps.
> >>
> >> See above; this is what bpf_object__pin_maps() does today?
> >
> > I didn't get this last comment. What I meant is that I want something
> > like the bpf_object__pin_maps but that doesn't pin the maps, just
> > exposing its naming part.
>
> Right, OK. Why, though? I can kinda see how it could be convenient to
> (basically )make libbpf behave as if all maps has the 'pinning'
> attribute set, for map reuse. But I'm not sure I can think any concrete
> use cases where this would be needed. What's yours?
>

I am using the same bpf objects (more specifically, the new skeleton
feature) in two different processes that need access to the same
maps/programs (for example, they both need access to shared maps).
Thus, I want to reuse the entire object in both. Since we already have
a way to pin an entire bpf object, I thought it would be convenient to
have a way of reusing it entirely (though I am fine with pinning and
reusing each one manually).
(I cannot set the __uint(pinning, LIBBPF_PIN_BY_NAME) on each since I
want to share the bss map too)

> -Toke
>
