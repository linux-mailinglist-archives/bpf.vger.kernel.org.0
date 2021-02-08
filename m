Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA336313EB6
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 20:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhBHTSE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 14:18:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236163AbhBHTRw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Feb 2021 14:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612811785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZBywksuULFi8z+dyfRLqt0Zx67rcucpw2q+jk2voXw=;
        b=MnpRFVrl1bqtv0y5z1IEvfgSMC4i/f1FDMxM2vx7OFqf9XIJ2GA1p0Nc17gv43440ZLw8u
        VQpmWrUkk0nrdilZAeXT5STopVDhb4g8Joq9CgBnv5xa18TLgUGtEZvrTNk5vS0NJwSJOk
        P/RKadAwUPa44wXAS0N/GhjwzWSHwDw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-yLmbWWcPOJGDLdCpSUm7CQ-1; Mon, 08 Feb 2021 14:16:21 -0500
X-MC-Unique: yLmbWWcPOJGDLdCpSUm7CQ-1
Received: by mail-ed1-f70.google.com with SMTP id g6so15006740edy.9
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 11:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9ZBywksuULFi8z+dyfRLqt0Zx67rcucpw2q+jk2voXw=;
        b=YXkW+E0r6WUYsWJKzXsqlZAzKAErIBWKqprc47GGcFtHUiSC37ZwKbIdB19iMirbtH
         UQNqyXi+ELCltK3vvKty8/cSR+HB9XayRSIhc5l+HSRVWYCraF6xCg0DT7O8J9gnpyNx
         PkxO/QuC571FqhsZtPGf1FgQPi8o6EA8DC2WbQ1bdcfzdzrOByk9HxikbJde0i/biUei
         Jt9A4L1lQqp2MK4AeXqKnkOesmd4WJM+qg/6d5E2YOBYM9XywaCFLdd/qajWywtTtAeH
         Vy3NWJhMgdQnqsdoLMnX9wk6mSogGpuKZtU+Iak1Y4Xkiad8wr4xKmcSLxvtMV5D5mMh
         aMvg==
X-Gm-Message-State: AOAM531SQ6MWfw6AxobDvwjXzLDX2mUHLpq6UvWZd386x1HX8hzCuEo6
        GQEGTZjT2g2aTxqd0dsfstmlZstOwARL1gE5bqZl07YzMxehQcw9d0xA7LllrkmQLY30fSp+jGQ
        g0j5oAqBP9ahw
X-Received: by 2002:a17:906:c081:: with SMTP id f1mr10683309ejz.97.1612811779910;
        Mon, 08 Feb 2021 11:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTTNZYdvN0HOpQ3cmVH7lq/nOhdAgXbCDsVW0qgBYoxqOevS+/8nzIsA1ZG+l0UIf7PeUleA==
X-Received: by 2002:a17:906:c081:: with SMTP id f1mr10683286ejz.97.1612811779622;
        Mon, 08 Feb 2021 11:16:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id zg22sm4965839ejb.0.2021.02.08.11.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:16:19 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A34D31804EE; Mon,  8 Feb 2021 20:16:18 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: libbpf: pinning multiple progs from the same section
In-Reply-To: <CANaYP3EUOLf=8+ZuKFr4ozPueqgjvzxkEK+O8WEamwY01yATaA@mail.gmail.com>
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk>
 <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
 <87mtwetz04.fsf@toke.dk>
 <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
 <87blcutx3v.fsf@toke.dk>
 <CANaYP3FEheoxSp86sFair0CAQz1-fkdmGp0_zvgGqQr_3P+qdg@mail.gmail.com>
 <875z32tpel.fsf@toke.dk>
 <CANaYP3EUOLf=8+ZuKFr4ozPueqgjvzxkEK+O8WEamwY01yATaA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Feb 2021 20:16:18 +0100
Message-ID: <87zh0es73x.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Gilad Reti <gilad.reti@gmail.com> writes:

> On Mon, Feb 8, 2021 at 7:55 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Gilad Reti <gilad.reti@gmail.com> writes:
>>
>> > On Mon, Feb 8, 2021 at 5:09 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Gilad Reti <gilad.reti@gmail.com> writes:
>> >>
>> >> > On Mon, Feb 8, 2021 at 4:28 PM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>> >> >>
>> >> >> Gilad Reti <gilad.reti@gmail.com> writes:
>> >> >>
>> >> >> > On Mon, Feb 8, 2021 at 1:42 PM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>> >> >> >>
>> >> >> >> Gilad Reti <gilad.reti@gmail.com> writes:
>> >> >> >>
>> >> >> >> > Also, is there a way to set the pin path to all maps/programs=
 at once?
>> >> >> >> > For example, bpf_object__pin_maps pins all maps at a specific=
 path,
>> >> >> >> > but as far as I was able to find there is no similar function=
 to set
>> >> >> >> > the pin path for all maps only (without pinning) so that at l=
oading
>> >> >> >> > time libbpf will try to reuse all maps. The only way to achie=
ve a
>> >> >> >> > complete reuse of all maps that I could find is to "reverse e=
ngineer"
>> >> >> >> > libbpf's pin path generation algorithm (i.e. <path>/<map_name=
>) and
>> >> >> >> > set the pin path on each map before load.
>> >> >> >>
>> >> >> >> You can set the 'pinning' attribute in the map definition - add
>> >> >> >> '__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By de=
fault
>> >> >> >> this will pin beneath /sys/fs/bpf, but you can customise that b=
y setting
>> >> >> >> the pin_root_path attribute in bpf_object_open_opts.
>> >> >> >
>> >> >> > Yes, I am familiar with that feature, but it has some downsides:
>> >> >> > 1. I need to set it manually on every map (and in cases that I h=
ave
>> >> >> > only the compiled object file that would be hard).
>> >> >> > 2. It only works for bpf maps and not bpf programs.
>> >> >> > 3. It only works for bpf maps that are defined explicitly in the=
 bpf
>> >> >> > code and not for implicit (inner) bpf maps (bss, rodata, etc).
>> >> >>
>> >> >> Ah, right. Well, other than that I don't think there's a way to se=
t pin
>> >> >> paths in bulk, other than by manually iterating and setting them o=
ne at
>> >> >> a time. But, erm, can't you just do that? :)
>> >> >>
>> >> >
>> >> > Sure, I can, but I think we should avoid that. As I said this forces
>> >> > the user to know libbpf's pin path naming algorithm, which is not p=
art
>> >> > of the libbpf api afaik.
>> >>
>> >> Why? If you set the pin path from your application, libbpf will also =
try
>> >> to reuse the map from that path. So you don't need to know libbpf's
>> >> algorithm if you just override it with your own paths?
>> >>
>> >
>> > If I do bpf_object__pin_maps then libbpf decides where it wants to pin
>> > them. I can set each path by my own, but then why do we need this
>> > function?
>>
>> Erm, what do you mean, "libbpf decides". bpf_object__pin_maps(obj, path)
>> does exactly what you're asking for: If you supply the path, all maps
>> are going to be pinned by name underneath that directory...
>
> They are pinned under this directory, but with which filename? Today
> libbpf builds the filename by taking the map name and escaping it, but
> what will happen if this will have to change?

Then that would have to be done in a way that was backwards-compatible
so as not to break user code :)

>> > For example, libbpf today uses <path>/<map_name> as the pin path, but
>> > it is also doing sanitize_pin_path on each path. This means that after
>> > if use bpf_object__pin_maps I also need to know how libbpf sanitizes
>> > its paths and mimic that behavior on my side.
>>
>> The paths are sanitised so the kernel will accept them. If you're using
>> invalid paths your pinning is not going to work at all. If you just want
>> the paths that the maps are pinned under, use bpf_map__get_pin_path().
>>
>
> I am not saying that sanitization is redundant, but rather that it
> needs to be properly defined (i.e. all dots will always be replaced
> with underscores), so either expose it in the api or document it so
> that users don't have to look after the specific implementation.

Lack of documentation is a perennial problem, and patches are always
welcome. But it is API: libbpf does things a certain way today, and if
it changes in a way that will break user programs, that is an API break.

>> >> > I think that if we have a method to pin all maps at a specific path
>> >> > there should also be a method for reusing them all from this path,
>> >> > either by exposing the function that builds the pin path, or a
>> >> > function that sets all the paths from a root path.
>> >>
>> >> What you're asking for is basically a function
>> >> bpf_object__set_all_pin_paths(obj, path)
>> >>
>> >> instead of having to do
>> >>
>> >> bpf_object__for_each_map(map, obj) {
>> >>   sprintf(path, "path/%s", bpf_map__name(map));
>> >>   bpf_map__set_pin_path(map, path);
>> >> }
>> >>
>> >> or? Is that really needed?
>> >>
>> >
>> > Yes, that is what I am asking for. Either that or a
>> > bpf_map__build_pin_path(path, map) That will return a pin path that is
>> > compatible with libbpf's one, and then I can iterate over all maps.
>>
>> See above; this is what bpf_object__pin_maps() does today?
>
> I didn't get this last comment. What I meant is that I want something
> like the bpf_object__pin_maps but that doesn't pin the maps, just
> exposing its naming part.

Right, OK. Why, though? I can kinda see how it could be convenient to
(basically )make libbpf behave as if all maps has the 'pinning'
attribute set, for map reuse. But I'm not sure I can think any concrete
use cases where this would be needed. What's yours?

-Toke

