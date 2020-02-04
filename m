Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641EB151705
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2020 09:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBDI10 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Feb 2020 03:27:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727097AbgBDI10 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Feb 2020 03:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580804845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SylG+xSSNl/r+S0VWufSWtGGQ88neS8K395cbSM4FdM=;
        b=PQZfHZrUjIKibal3X3B4NF/xR4orQitVGEzd8sC7ifdtk0nPNuWM47zA4SHJsB6QACBjD8
        hxg0UtOyVP4d/v+FPI2qmxUjaOELIVSujn/x61UNn/Pt+wQJIuB+xqJrevB9OWQNuz4Sg6
        2L9sJDbV2opE80RRI9ANnhsnCw+WJug=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-kSaXkeEROiCKsD6IravzNA-1; Tue, 04 Feb 2020 03:27:23 -0500
X-MC-Unique: kSaXkeEROiCKsD6IravzNA-1
Received: by mail-lj1-f197.google.com with SMTP id m1so4999812lji.5
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2020 00:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SylG+xSSNl/r+S0VWufSWtGGQ88neS8K395cbSM4FdM=;
        b=pEpfEmIJgeSoR8GaSTv5kdwQvyjxS4ZN6qw3wilyzl2sKFvYnv2RZkDLlaUqDiU/sC
         yP1kdU1r2F7ANEEM1MEDZdBGIk7ZrVX2E6vZfSOzKm7qaUlVkZqRLTt57NC93t6CHKl2
         TH6kNpn7QvNJAizR682nCFOlNj4HXBureNqTt1ciVL3z2MhxFQymyTu7iXnxN+fcNDTX
         brNQ1bBLgoQnTxHaqP+CRi7TJWbNt5qbYicdwHXGqU51LHS5WBDl0pS+4fKWfoyaIuLn
         JO3JYksp3tzJTyGs2hTuzHzS3EnbkBG1Gpc8k03E16swCp24B1URzof8PH2K2V9I+/6R
         izxQ==
X-Gm-Message-State: APjAAAU6arQd0See/fw+Xs7vDUBZBuGR0YlLgF2bgTpMA28m9DTu2UE8
        lxogREOpjT1vs1zpcMS4iO0I66nwK+TR5UnYi3MH+S5H+2sKsOQ4CYZ7v1YyLtfhqXMA7uBfioc
        hf4VsstA9ci4e
X-Received: by 2002:a2e:9705:: with SMTP id r5mr16573921lji.114.1580804842067;
        Tue, 04 Feb 2020 00:27:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkO8ZbEzK4We052yDNv9DHV2v8PFoznNtXBdho12ZsRaqVrcwCFIBNaJ0cJG1HTo38smCacQ==
X-Received: by 2002:a2e:9705:: with SMTP id r5mr16573903lji.114.1580804841796;
        Tue, 04 Feb 2020 00:27:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b17sm10963188ljd.5.2020.02.04.00.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:27:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3E3921802CA; Tue,  4 Feb 2020 09:27:20 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC bpf-next 0/5] Convert iproute2 to use libbpf (WIP)
In-Reply-To: <CAEf4Bza4bSAzjFp2WDiPAM7hbKcKgAX4A8_TUN8V38gXV9GbTg@mail.gmail.com>
References: <20190820114706.18546-1-toke@redhat.com> <CAEf4BzZxb7qZabw6aDVaTqnhr3AGtwEo+DbuBR9U9tJr+qVuyg@mail.gmail.com> <87blwiqlc8.fsf@toke.dk> <CAEf4BzYMKPbfOu4a4UDEfJVcNW1-KvRwJ7PVo+Mf_1YUJgE4Qw@mail.gmail.com> <43e8c177-cc9c-ca0b-1622-e30a7a1281b7@iogearbox.net> <CAEf4Bzab_w0AXy5P9mG14mcyJVgUCzuuNda5FpU5wSEwUciGfg@mail.gmail.com> <87tva8m85t.fsf@toke.dk> <CAEf4BzbzQwLn87G046ZbkLtTbY6WF6o8JkygcPLPGUSezgs9Tw@mail.gmail.com> <CAEf4BzZOAukJZzo4J5q3F2v4MswQ6nJh6G1_c0H0fOJCdc7t0A@mail.gmail.com> <87blqfcvnf.fsf@toke.dk> <CAEf4Bza4bSAzjFp2WDiPAM7hbKcKgAX4A8_TUN8V38gXV9GbTg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 04 Feb 2020 09:27:20 +0100
Message-ID: <87eeva69lj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Feb 3, 2020 at 11:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Wed, Aug 28, 2019 at 1:40 PM Andrii Nakryiko
>> > <andrii.nakryiko@gmail.com> wrote:
>> >>
>> >> On Fri, Aug 23, 2019 at 4:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
>> >> >
>> >> > [ ... snip ...]
>> >> >
>> >> > > E.g., today's API is essentially three steps:
>> >> > >
>> >> > > 1. open and parse ELF: collect relos, programs, map definitions
>> >> > > 2. load: create maps from collected defs, do program/global data/=
CO-RE
>> >> > > relocs, load and verify BPF programs
>> >> > > 3. attach programs one by one.
>> >> > >
>> >> > > Between step 1 and 2 user has flexibility to create more maps, se=
t up
>> >> > > map-in-map, etc. Between 2 and 3 you can fill in global data, fil=
l in
>> >> > > tail call maps, etc. That's already pretty flexible. But we can t=
une
>> >> > > and break apart those steps even further, if necessary.
>> >> >
>> >> > Today, steps 1 and 2 can be collapsed into a single call to
>> >> > bpf_prog_load_xattr(). As Jesper's mail explains, for XDP we don't
>> >> > generally want to do all the fancy rewriting stuff, we just want a
>> >> > simple way to load a program and get reusable pinning of maps.
>> >>
>> >> I agree. See my response to Jesper's message. Note also my view of
>> >> bpf_prog_load_xattr() existence.
>> >>
>> >> > Preferably in a way that is compatible with the iproute2 loader.
>> >> >
>> >
>> > Hi Toke,
>> >
>> > I was wondering what's the state of converting iproute2 to use libbpf?
>> > Is this still something you (or someone else) interested to do?
>>
>> Yeah, it's still on my list; planning to circle back to it once I have
>> finished an RFC implementation for XDP multiprog loading based on the
>> new function-replacing in the kernel.
>>
>> (Not that this should keep anyone else from giving the conversion a go
>> and beating me to it :)).
>>
>> > Briefly re-reading the thread, I think libbpf already has almost
>> > everything to be used by iproute2. You've added map pinning, so with
>> > bpf_map__set_pin_path() iproute2 should be able to specify pinning
>> > path, according to its own logic. The only thing missing that I can
>> > see is ability to specify numa_node, which we should add both to
>> > BTF-defined map definitions (trivial change), as well as probably
>> > expose a method like bpf_map__set_numa_node(struct bpf_map *map, int
>> > numa_node) for non-declarative and non-BTF legacy cases.
>>
>> Yes, adding this to libbpf would be good.
>>
>> > There was concern about supporting "extended" bpf_map_def format of
>> > iproute2 (bpf_elf_map, actually) with extra fields. I think it's
>> > actually easy to handle as is without any extra new APIs.
>> > bpf_object__open() w/ .relaxed_maps =3D true option will process
>> > compatible 5 fields of bpf_map_def (type, key/value sizes,
>> > max_entries, and map_flags) and will set up corresponding struct
>> > bpf_map entries (but won't create BPF maps in kernel yet). Then
>> > iproute2 can iterate over "maps" ELF section on its own, and see which
>> > maps need to get some more adjustments before load phase: map-in-map
>> > set up, numa node, pinning, etc. All those adjustments can be done
>> > (except for numa yet) through existing libbpf APIs, as far as I can
>> > tell. Once that is taken care of, proceed to bpf_object__load() and
>> > other standard steps. No callbacks, no extra cruft.
>> >
>> > Is there anything else that can block iproute2 conversion to libbpf?
>>
>> I haven't looked into the details since my last RFC conversion series,
>> but from what I recall from that, and what we've been changing in libbpf
>> since, I was basically planning to do what you explained. So while there
>> are some details to work out, I believe it's basically straight forward,
>> and I can't think of anything that should block it.
>>
>
> Great! Just to disambiguate and make sure we are in agreement, my hope
> here is that iproute2 can completely delegate to libbpf all the ELF
> parsing, map creation, program loading, etc (including all the new
> stuff like global variables, etc). And only for legacy maps in
> SEC("maps"), it would have to parse that *single* ELF section (again,
> on its own) and see if there are any extra features of struct
> bpf_elf_map requested (i.e., numa, map-in-map, pinning), and if yes,
> it would use programmatic libbpf APIs to set this up. It might need to
> do additional BPF_PROG_ARRAY set up after BPF programs are loaded
> (because iproute2 has its custom naming-based convention). But
> hopefully we'll encourage people to gradually migrate to BTF-defined
> maps with declarative ways of doing all that.

Yup, that is my hope as well. Let's see how it goes :)

-Toke

