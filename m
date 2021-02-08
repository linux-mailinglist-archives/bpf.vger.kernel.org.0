Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B073C313888
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 16:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhBHPvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 10:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbhBHPvn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 10:51:43 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA9C06178A
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 07:51:03 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id l25so8271471eja.9
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J6EbGQERP8fj73dyzJJ72eeYoESE909I3834GkrucOg=;
        b=grbdIIXd+NTIW5VU+aanhwSob/3XCV8724dFHbl1QYdXZV6x1nKOvWGB0K71Zxac+U
         vOsF/E2vAnA/oXw593NXsJ8LgoEbuHfbNiF+0G1kGZd21N5SMAaYKm7XPf6QimIvt6kX
         Ok1WSWxmN6SUDP/9ZcA+vVvi0bE2m3JeMdfhMGyydRTXhKznaSmzdDJOtLjdCYdw/J6M
         EwdCMKo80wrAhtWmPRCkBQIJB6jub8kzUfEpz8jvVtgaDsyhK9l2QJ6BBnQq47Yg5NCP
         VjOQ+hoJvSeo9ArwbMiHfwj5Xgq7p/DamkHM29hWZXM+FmSVtllgiDVFKoCt4nhIbtcP
         zACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J6EbGQERP8fj73dyzJJ72eeYoESE909I3834GkrucOg=;
        b=hyMAwRtav6M05v4FkmWvvQrb2P5DJReaYfrHwLuq0lfpXmg5KPZ9cVior9dIjSXk14
         V+/ptptkxa/bBM1yscW6K8/eaVroNkpg0Oz+mf3/qEownusjuBxiH4nV0qBXiivxOz2K
         Mlx3x4YtgWaH0OrcReDRl82TY+KJxVz09x3kd5GkpzDjX9faFc0sdiwNFWpRlrCmprn4
         rHYywCTUWmAlBCIGic1KKk50Yaaxua266DMQmdugm0m8H8/9ApYw99FBRN70uXF1ZDhe
         FGIUp2AA2zHRWsQHnmd89F7FHxeHKF/Tfum3opgYDJq/RkEpTuJikMaJiWUM2JKvN8SJ
         h/GA==
X-Gm-Message-State: AOAM532XWkpfi/oME3N80dmNxeyLEqtwONu7DxrkGoUGKkSj2mWVkkaa
        0x0gwTVKX6cDaXgfHJjSe8Yy6TRGHaLjwVRJpa4=
X-Google-Smtp-Source: ABdhPJz+EBgWhfDlpr068kkcItiU3PI7nlu3GdeE/e7VsSC2Qi3BlYDa0wTBoCIYLYPLfb6qXqAiH9FuSrMfEpmjZVM=
X-Received: by 2002:a17:907:2705:: with SMTP id w5mr7073331ejk.136.1612799461977;
 Mon, 08 Feb 2021 07:51:01 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk> <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
 <87mtwetz04.fsf@toke.dk> <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
 <87blcutx3v.fsf@toke.dk>
In-Reply-To: <87blcutx3v.fsf@toke.dk>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Mon, 8 Feb 2021 17:50:25 +0200
Message-ID: <CANaYP3FEheoxSp86sFair0CAQz1-fkdmGp0_zvgGqQr_3P+qdg@mail.gmail.com>
Subject: Re: libbpf: pinning multiple progs from the same section
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 5:09 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Gilad Reti <gilad.reti@gmail.com> writes:
>
> > On Mon, Feb 8, 2021 at 4:28 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >>
> >> > On Mon, Feb 8, 2021 at 1:42 PM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> >> >>
> >> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >> >>
> >> >> > Also, is there a way to set the pin path to all maps/programs at =
once?
> >> >> > For example, bpf_object__pin_maps pins all maps at a specific pat=
h,
> >> >> > but as far as I was able to find there is no similar function to =
set
> >> >> > the pin path for all maps only (without pinning) so that at loadi=
ng
> >> >> > time libbpf will try to reuse all maps. The only way to achieve a
> >> >> > complete reuse of all maps that I could find is to "reverse engin=
eer"
> >> >> > libbpf's pin path generation algorithm (i.e. <path>/<map_name>) a=
nd
> >> >> > set the pin path on each map before load.
> >> >>
> >> >> You can set the 'pinning' attribute in the map definition - add
> >> >> '__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By defaul=
t
> >> >> this will pin beneath /sys/fs/bpf, but you can customise that by se=
tting
> >> >> the pin_root_path attribute in bpf_object_open_opts.
> >> >
> >> > Yes, I am familiar with that feature, but it has some downsides:
> >> > 1. I need to set it manually on every map (and in cases that I have
> >> > only the compiled object file that would be hard).
> >> > 2. It only works for bpf maps and not bpf programs.
> >> > 3. It only works for bpf maps that are defined explicitly in the bpf
> >> > code and not for implicit (inner) bpf maps (bss, rodata, etc).
> >>
> >> Ah, right. Well, other than that I don't think there's a way to set pi=
n
> >> paths in bulk, other than by manually iterating and setting them one a=
t
> >> a time. But, erm, can't you just do that? :)
> >>
> >
> > Sure, I can, but I think we should avoid that. As I said this forces
> > the user to know libbpf's pin path naming algorithm, which is not part
> > of the libbpf api afaik.
>
> Why? If you set the pin path from your application, libbpf will also try
> to reuse the map from that path. So you don't need to know libbpf's
> algorithm if you just override it with your own paths?
>

If I do bpf_object__pin_maps then libbpf decides where it wants to pin them=
.
I can set each path by my own, but then why do we need this function? All
It does is pinning all the maps at paths that are not part of the api. In t=
his
libbpf version it is here, in the next it is there, and user code will need=
 to
change accordingly. For example, libbpf today uses <path>/<map_name> as
the pin path, but it is also doing sanitize_pin_pathon each path. This mean=
s
that after if use bpf_object__pin_maps I also need to know how libbpf sanit=
izes
its paths and mimic that behavior on my side.

> > I think that if we have a method to pin all maps at a specific path
> > there should also be a method for reusing them all from this path,
> > either by exposing the function that builds the pin path, or a
> > function that sets all the paths from a root path.
>
> What you're asking for is basically a function
> bpf_object__set_all_pin_paths(obj, path)
>
> instead of having to do
>
> bpf_object__for_each_map(map, obj) {
>   sprintf(path, "path/%s", bpf_map__name(map));
>   bpf_map__set_pin_path(map, path);
> }
>
> or? Is that really needed?
>

Yes, that is what I am asking for. Either that or a
bpf_map__build_pin_path(path, map)
That will return a pin path that is compatible with libbpf's one, and
then I can iterate
over all maps.

> -Toke
>
