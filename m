Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64E4313685
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhBHPLy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 10:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233238AbhBHPK4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Feb 2021 10:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612796970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8zPINd0y7ah+a9lAf9PN9eHszd7wGJnxR29WbkxBQ4=;
        b=aN+TXnpD9z2eFOpAL8L2B+/qhUvdjjXtAF1SSITsd59d+DglNMtk/xXqQjgX0Yg4qqdblN
        4PM/MxS8ciOrqKmYkjljcTJcLmK7ibHn7NB3P/vYyYKVOnKZkYmcLFl7thRAoV4HP+zgTG
        ofNATNBKewewASQqh8JBk7DmXXhjX/c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-Vq7rwPsAOHmwswkEXnyE6g-1; Mon, 08 Feb 2021 10:09:26 -0500
X-MC-Unique: Vq7rwPsAOHmwswkEXnyE6g-1
Received: by mail-ej1-f71.google.com with SMTP id jl9so7489821ejc.18
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 07:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=v8zPINd0y7ah+a9lAf9PN9eHszd7wGJnxR29WbkxBQ4=;
        b=V5fcxFfvZ2oALNucavAcnAU96jjZ/xPrmMSCnM1Z6YG7u9u48XVeto2zRPmWgCdkyz
         fpo8u8N5MsodrHki6NZ+gGB/FR191mJTyN2p3GIxILqo/lqFzCdNVPorE/M48Mr/b4TE
         j6a3oaRKxlZtqAPBe+Xen08dqOhx8fF2smqTbMntklDxbiSyBDKdbX3e0APlA20UXqO0
         Vqta2Lz6/22mJrFmRkMfKZZZ7xQjBG48Aqh36EWdorB9J72AODKwR6LGaqRB+hGofkKg
         pgcMktOFn3tLslx2I+CCOLS/+7vQc2+jLgGy9EZecrJf9YPLlA4XmNSJTe18Dd0Bz/et
         Ugdw==
X-Gm-Message-State: AOAM531jVHTQqyz18UWNZ4QZ4Hl3S2RcBoNDxQVA8XozQ+rcxkaHfRHx
        cOijvTUhFwWnV5INPVXZTYAD+nwlCAgYSKVoJ+zACX3OOBvaNslZtVNmUBXadlicSkMPa0h8lc7
        6LdG8sMqKGqck
X-Received: by 2002:a17:907:2d93:: with SMTP id gt19mr17078021ejc.246.1612796965503;
        Mon, 08 Feb 2021 07:09:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwR3TDM9M6nw0QfrYqC+GxPn3VtVm0dN+h3FhocrTI4xhhvqE9HjNxpqJ/T9T+0igjD6jfE/w==
X-Received: by 2002:a17:907:2d93:: with SMTP id gt19mr17077998ejc.246.1612796965217;
        Mon, 08 Feb 2021 07:09:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q14sm9634623edw.52.2021.02.08.07.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 07:09:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 535E81804EE; Mon,  8 Feb 2021 16:09:24 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: libbpf: pinning multiple progs from the same section
In-Reply-To: <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk>
 <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
 <87mtwetz04.fsf@toke.dk>
 <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Feb 2021 16:09:24 +0100
Message-ID: <87blcutx3v.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Gilad Reti <gilad.reti@gmail.com> writes:

> On Mon, Feb 8, 2021 at 4:28 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Gilad Reti <gilad.reti@gmail.com> writes:
>>
>> > On Mon, Feb 8, 2021 at 1:42 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Gilad Reti <gilad.reti@gmail.com> writes:
>> >>
>> >> > Also, is there a way to set the pin path to all maps/programs at on=
ce?
>> >> > For example, bpf_object__pin_maps pins all maps at a specific path,
>> >> > but as far as I was able to find there is no similar function to set
>> >> > the pin path for all maps only (without pinning) so that at loading
>> >> > time libbpf will try to reuse all maps. The only way to achieve a
>> >> > complete reuse of all maps that I could find is to "reverse enginee=
r"
>> >> > libbpf's pin path generation algorithm (i.e. <path>/<map_name>) and
>> >> > set the pin path on each map before load.
>> >>
>> >> You can set the 'pinning' attribute in the map definition - add
>> >> '__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By default
>> >> this will pin beneath /sys/fs/bpf, but you can customise that by sett=
ing
>> >> the pin_root_path attribute in bpf_object_open_opts.
>> >
>> > Yes, I am familiar with that feature, but it has some downsides:
>> > 1. I need to set it manually on every map (and in cases that I have
>> > only the compiled object file that would be hard).
>> > 2. It only works for bpf maps and not bpf programs.
>> > 3. It only works for bpf maps that are defined explicitly in the bpf
>> > code and not for implicit (inner) bpf maps (bss, rodata, etc).
>>
>> Ah, right. Well, other than that I don't think there's a way to set pin
>> paths in bulk, other than by manually iterating and setting them one at
>> a time. But, erm, can't you just do that? :)
>>
>
> Sure, I can, but I think we should avoid that. As I said this forces
> the user to know libbpf's pin path naming algorithm, which is not part
> of the libbpf api afaik.

Why? If you set the pin path from your application, libbpf will also try
to reuse the map from that path. So you don't need to know libbpf's
algorithm if you just override it with your own paths?

> I think that if we have a method to pin all maps at a specific path
> there should also be a method for reusing them all from this path,
> either by exposing the function that builds the pin path, or a
> function that sets all the paths from a root path.

What you're asking for is basically a function
bpf_object__set_all_pin_paths(obj, path)

instead of having to do

bpf_object__for_each_map(map, obj) {
  sprintf(path, "path/%s", bpf_map__name(map));
  bpf_map__set_pin_path(map, path);
}

or? Is that really needed?

-Toke

