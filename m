Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEA042732A
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 23:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhJHVqV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 17:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243348AbhJHVqV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 17:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633729465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfWt5U8+v0qPRonUQSA8hBy5taga+Zye67hLn9kVB7U=;
        b=EnHWRgkGWuuhUnLH5MXa8OUk9XsefrjshgLW4vdJXTwE8z6/sZVHoN/X0KNqT3ysE2sb8t
        0FXF+5UzVHQa5xw/IpN5mpISN1A3F4xzTFGFZgBoK89PDtJimWO7F2YdNY+ywKKlN7rcV9
        O0/JgYprbmMOEQBhf6lTOSlwjs3cksI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-gw1dvHopN4yWRyy36ZGPFw-1; Fri, 08 Oct 2021 17:44:24 -0400
X-MC-Unique: gw1dvHopN4yWRyy36ZGPFw-1
Received: by mail-ed1-f70.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso10395654edj.20
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 14:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PfWt5U8+v0qPRonUQSA8hBy5taga+Zye67hLn9kVB7U=;
        b=32A8fy7feagoEmqt2Gu8fJ4Y6trpJZSiw4nIz1P3gaM220JgWhPBNnQrZtfinM3rFR
         pyAeGu+c/zUis9CeSoF0s66RB7vjtUTt61dgptp5cO3kp0ZSP4gl2wGFzD0Uw+b2yEXO
         s37anChrrMC3q56f16dMOtLid+PR1K7FU2aZZMm+6q+dck1fIFcu4103QBIWaAb3QFVl
         DoK9Bs7O7Zmv0ZDeCJeGItSUo7vk7DyOzq7h1/5/032JVuuhCPHRoNiFoi0Ye4yNg4Fl
         /d5uI//7nZEk1xwcIYMdLIgKZOOoL+H0ymK8cSDDf1vWFhTHiPIgcs8f8xfJNKF2Xcal
         Cxaw==
X-Gm-Message-State: AOAM5328q1TtRnG3NpbrkDQIqenp9QhRKob3suboqMV0OaXTrp7XvFWP
        klIPRyWviNZllrYuQTBQEGyksOmrtGc8r8Dog+ZMFmR7G7N6Fs1O5dTFbhBLYiKaHcGmQemqZe2
        JR+XthXGNHg1+
X-Received: by 2002:a17:906:25d4:: with SMTP id n20mr7311428ejb.399.1633729462768;
        Fri, 08 Oct 2021 14:44:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSEFQpABO86GRoaZa8uGGfPEeuUwvqObArwYXaKmYumykq4xiIIJv8zuQtdzb0swUjM5ptIw==
X-Received: by 2002:a17:906:25d4:: with SMTP id n20mr7311395ejb.399.1633729462424;
        Fri, 08 Oct 2021 14:44:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n6sm226154eds.10.2021.10.08.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:44:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2DDEB180151; Fri,  8 Oct 2021 23:44:21 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
In-Reply-To: <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
References: <20211008000309.43274-1-andrii@kernel.org>
 <20211008000309.43274-10-andrii@kernel.org> <87pmsfl8z0.fsf@toke.dk>
 <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Oct 2021 23:44:21 +0200
Message-ID: <87r1cvjioa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Oct 8, 2021 at 10:31 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> andrii.nakryiko@gmail.com writes:
>>
>> > From: Andrii Nakryiko <andrii@kernel.org>
>> >
>> > Map name that's assigned to internal maps (.rodata, .data, .bss, etc)
>> > consist of a small prefix of bpf_object's name and ELF section name as
>> > a suffix. This makes it hard for users to "guess" the name to use for
>> > looking up by name with bpf_object__find_map_by_name() API.
>> >
>> > One proposal was to drop object name prefix from the map name and just
>> > use ".rodata", ".data", etc, names. One downside called out was that
>> > when multiple BPF applications are active on the host, it will be hard
>> > to distinguish between multiple instances of .rodata and know which BPF
>> > object (app) they belong to. Having few first characters, while quite
>> > limiting, still can give a bit of a clue, in general.
>> >
>> > Another downside of such approach is that it is not backwards compatib=
le
>> > and, among direct use of bpf_object__find_map_by_name() API, will break
>> > any BPF skeleton generated using bpftool that was compiled with older
>> > libbpf version.
>> >
>> > Instead of causing all this pain, libbpf will still generate map name
>> > using a combination of object name and ELF section name, but it will
>> > allow looking such maps up by their natural names, which correspond to
>> > their respective ELF section names. This means non-truncated ELF secti=
on
>> > names longer than 15 characters are going to be expected and supported.
>> >
>> > With such set up, we get the best of both worlds: leave small bits of
>> > a clue about BPF application that instantiated such maps, as well as
>> > making it easy for user apps to lookup such maps at runtime. In this
>> > sense it closes corresponding libbpf 1.0 issue ([0]).
>>
>> I like this approach. Only possible problem I can see is that it might
>> be confusing that a map can be looked up with one name, but that it
>> disappears once it's loaded into the kernel (and the BPF object is
>> closed).
>>
>> Hmm, couldn't we just extend the kernel to accept longer names? Kinda
>> like with the netdev name aliases: support a secondary label that can be
>> longer, and have bpftool display both?
>
> Yes, this discrepancy can be confusing. I'd like all those internal
> maps to be named after their corresponding ELF sections, tbh. We have
> a mechanism now to make this transition (libbpf_set_strict_mode()),
> but people have complained before that just seeing ".data" won't give
> them enough information.

Yeah, I do also sympathise with that complaint :)

> But if we are going to extend the kernel with longer map names, then
> I'd rather stick to clean ".data.custom" naming from the very
> beginning, and then switch all existing .data/.rodata/.bss/.kconfig
> map naming to the same convention as well (guarded by opt-in flag in
> libbpf_set_strict_mode() until libbpf 1.0). In the kernel, though,
> instead of having two names (i.e., one is alias), I'd just allow to
> provide one long name and then all existing UAPIs that have char[16]
> everywhere would just be a potentially truncated prefix of such a
> longer name. All the tooling can be updated to use long name when
> available, of course. WDYT?

Hmm, so introduce a new 'map_name_long' field, and on query the kernel
will fill in the old map_name with a truncated version, and put the full
name in the new field? Yeah, I guess that would work too!

-Toke

