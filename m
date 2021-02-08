Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924AF313C00
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 19:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhBHR7n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 12:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233728AbhBHR5Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Feb 2021 12:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612806950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idEu13PxDx0qJxTDrQQKTOOyjxQAmtB8ZanhypfxJYc=;
        b=QX8Cr9FY/FQ+IQYVo3SoAGODjab0agh7jkk8TdKAhPtivBJ5MJ9VW7/bi58Es37GPSpMm4
        46LYzeAGimg1RGC6PxGbYnYFR1U15ruiJQY4IG/1B9U9EpQiKuGi/JiQLE50C7w8GPVNdL
        BdZF02A7L8AQRJOevKefdQB269+lLKE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211--eFx5l1aPv2OYM2uC3odUQ-1; Mon, 08 Feb 2021 12:55:49 -0500
X-MC-Unique: -eFx5l1aPv2OYM2uC3odUQ-1
Received: by mail-ed1-f71.google.com with SMTP id bd22so14313556edb.4
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 09:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=idEu13PxDx0qJxTDrQQKTOOyjxQAmtB8ZanhypfxJYc=;
        b=f+etS9PvDjoTlheCiogjFiHW7G0gMpbPLK/Y12xXS1DUIWdL6pwMd47QZe8LUtZhUs
         1KiuL5K7rUVoiPkeJdDgy4QgT+QEafC3Af4BTn/7oC2E50BtPNUqjg88pcimgj3D46AS
         XcFNkjuZLQ7O7Xi20c4EJLvCamJfpxrTaR+I2F9tepkOohp8630GyO3qjV9nuh2zG6Bo
         sQ1CMX4JQzV8VsXLiiQsSSPUqld+g+lqx2tYO6aRGJDkKreKJpBSMNsz5o7prL0WOcBc
         Ees2XI66hFbaPYZe7GFT4FkKgpR/9pjHhYpi3Tswc886oaiXiwp0CE5stLBXAyjOB+N0
         bsdw==
X-Gm-Message-State: AOAM5323qntpIpowvpek63kAwb7lGyrPw8Cr/xC8fQEin95SN8M1pUSk
        yj80uPubqkhosvvloQTSbdOQ7r4/R7WK/SCHndosOd+7uaQHZ2nKaweGsInWVEEtSnQ/pJv9wg1
        yCOrB/0Ejzmer
X-Received: by 2002:a17:906:3c1:: with SMTP id c1mr8332771eja.428.1612806947543;
        Mon, 08 Feb 2021 09:55:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjJFyKhKEdpsAVcmBegRXHP3XQDbKOYkgayNiyvxABovMr8h+3/93rRdZxMrfh35a4ZqHMSg==
X-Received: by 2002:a17:906:3c1:: with SMTP id c1mr8332746eja.428.1612806947134;
        Mon, 08 Feb 2021 09:55:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u17sm10053574edr.0.2021.02.08.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:55:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 37C321804EE; Mon,  8 Feb 2021 18:55:46 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: libbpf: pinning multiple progs from the same section
In-Reply-To: <CANaYP3FEheoxSp86sFair0CAQz1-fkdmGp0_zvgGqQr_3P+qdg@mail.gmail.com>
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk>
 <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
 <87mtwetz04.fsf@toke.dk>
 <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
 <87blcutx3v.fsf@toke.dk>
 <CANaYP3FEheoxSp86sFair0CAQz1-fkdmGp0_zvgGqQr_3P+qdg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Feb 2021 18:55:46 +0100
Message-ID: <875z32tpel.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Gilad Reti <gilad.reti@gmail.com> writes:

> On Mon, Feb 8, 2021 at 5:09 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Gilad Reti <gilad.reti@gmail.com> writes:
>>
>> > On Mon, Feb 8, 2021 at 4:28 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Gilad Reti <gilad.reti@gmail.com> writes:
>> >>
>> >> > On Mon, Feb 8, 2021 at 1:42 PM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>> >> >>
>> >> >> Gilad Reti <gilad.reti@gmail.com> writes:
>> >> >>
>> >> >> > Also, is there a way to set the pin path to all maps/programs at=
 once?
>> >> >> > For example, bpf_object__pin_maps pins all maps at a specific pa=
th,
>> >> >> > but as far as I was able to find there is no similar function to=
 set
>> >> >> > the pin path for all maps only (without pinning) so that at load=
ing
>> >> >> > time libbpf will try to reuse all maps. The only way to achieve a
>> >> >> > complete reuse of all maps that I could find is to "reverse engi=
neer"
>> >> >> > libbpf's pin path generation algorithm (i.e. <path>/<map_name>) =
and
>> >> >> > set the pin path on each map before load.
>> >> >>
>> >> >> You can set the 'pinning' attribute in the map definition - add
>> >> >> '__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By defau=
lt
>> >> >> this will pin beneath /sys/fs/bpf, but you can customise that by s=
etting
>> >> >> the pin_root_path attribute in bpf_object_open_opts.
>> >> >
>> >> > Yes, I am familiar with that feature, but it has some downsides:
>> >> > 1. I need to set it manually on every map (and in cases that I have
>> >> > only the compiled object file that would be hard).
>> >> > 2. It only works for bpf maps and not bpf programs.
>> >> > 3. It only works for bpf maps that are defined explicitly in the bpf
>> >> > code and not for implicit (inner) bpf maps (bss, rodata, etc).
>> >>
>> >> Ah, right. Well, other than that I don't think there's a way to set p=
in
>> >> paths in bulk, other than by manually iterating and setting them one =
at
>> >> a time. But, erm, can't you just do that? :)
>> >>
>> >
>> > Sure, I can, but I think we should avoid that. As I said this forces
>> > the user to know libbpf's pin path naming algorithm, which is not part
>> > of the libbpf api afaik.
>>
>> Why? If you set the pin path from your application, libbpf will also try
>> to reuse the map from that path. So you don't need to know libbpf's
>> algorithm if you just override it with your own paths?
>>
>
> If I do bpf_object__pin_maps then libbpf decides where it wants to pin
> them. I can set each path by my own, but then why do we need this
> function?

Erm, what do you mean, "libbpf decides". bpf_object__pin_maps(obj, path)
does exactly what you're asking for: If you supply the path, all maps
are going to be pinned by name underneath that directory...

> All It does is pinning all the maps at paths that are not part of the
> api. In this libbpf version it is here, in the next it is there, and
> user code will need to change accordingly.

Why would you assume the paths would change? That would be an API break?

> For example, libbpf today uses <path>/<map_name> as the pin path, but
> it is also doing sanitize_pin_path on each path. This means that after
> if use bpf_object__pin_maps I also need to know how libbpf sanitizes
> its paths and mimic that behavior on my side.

The paths are sanitised so the kernel will accept them. If you're using
invalid paths your pinning is not going to work at all. If you just want
the paths that the maps are pinned under, use bpf_map__get_pin_path().

>> > I think that if we have a method to pin all maps at a specific path
>> > there should also be a method for reusing them all from this path,
>> > either by exposing the function that builds the pin path, or a
>> > function that sets all the paths from a root path.
>>
>> What you're asking for is basically a function
>> bpf_object__set_all_pin_paths(obj, path)
>>
>> instead of having to do
>>
>> bpf_object__for_each_map(map, obj) {
>>   sprintf(path, "path/%s", bpf_map__name(map));
>>   bpf_map__set_pin_path(map, path);
>> }
>>
>> or? Is that really needed?
>>
>
> Yes, that is what I am asking for. Either that or a
> bpf_map__build_pin_path(path, map) That will return a pin path that is
> compatible with libbpf's one, and then I can iterate over all maps.

See above; this is what bpf_object__pin_maps() does today?

-Toke

