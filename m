Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8A8151053
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2020 20:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgBCTeg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Feb 2020 14:34:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26920 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725372AbgBCTef (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Feb 2020 14:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580758474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QF3eY81eOKEDcjexNJ0roCys8uGG1rPDFto6tgn48Aw=;
        b=BZBXTUoKjZ6HJUiMrLcyaX60yZU/I3/5ox3KYB8YVg6xquTPILP/aYuYcBOPGrnoolJCF3
        WQX3H2NpvbcP52BjKcJG/lerE8e8tVd9YyXSV4fU4Bpz9LeLm9jZUm46LHAcHVRna054N3
        srKgUBDCKVDpOwvYaGUKSh8zqArCSw4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-aHGtpJN5PFaOVachemK8hg-1; Mon, 03 Feb 2020 14:34:32 -0500
X-MC-Unique: aHGtpJN5PFaOVachemK8hg-1
Received: by mail-lj1-f197.google.com with SMTP id h26so4362269ljj.0
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2020 11:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QF3eY81eOKEDcjexNJ0roCys8uGG1rPDFto6tgn48Aw=;
        b=ga76XWh1NAp5WIWvNHfQULQx+GYQO/76Hfb4CFQFA5FtHl/HSbGiOjB7ihURyTpqJu
         HSE1G77FBPGjLb7Fa+wS/fBE1E4HMm9Pn5bAc0hkEKwu13pqxSwpZg3gLUPDitBx8hs9
         cfpXy78h+4Pw3MzWRkAOok1zUsymxPYvlhx1ULO68ycuwMIJYoDu6OLHinx8sRmxXUnx
         sXVrc3sMGw2AP8DL21OD4a8se3F90ZtEHFhFEsd39BNxpJ3/3FtEpmk7dwqmfb9w5m5C
         DZ93k/1zZr/1se4v5F9ZCcXUaO5KKguACD4+g7golsIasZi0iH49vf3/5X1spNrQsW//
         v1bA==
X-Gm-Message-State: APjAAAWpjyIYYr+tBItjLgSMhfurRVY+vVzocEpKtEj13n2QpCwbv6FI
        6tSsPUSQlHAsyo8CWrNeE5P98j45ZJplNfuiQVwGmlWk15PyTBmDt83uDHhmBUWhuc2jTW0hJl9
        cLRJ5rBqF99V5
X-Received: by 2002:a19:4f57:: with SMTP id a23mr12570107lfk.145.1580758470414;
        Mon, 03 Feb 2020 11:34:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfRm3ilaiQGI0UPbzdKXQHgfZ/xxEdb5Mjm5obeL7A9IdUiejM0nhLFKfOimskrPSE80TmGA==
X-Received: by 2002:a19:4f57:: with SMTP id a23mr12570088lfk.145.1580758470131;
        Mon, 03 Feb 2020 11:34:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id l7sm9348914lfc.80.2020.02.03.11.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 11:34:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 44CF91800A2; Mon,  3 Feb 2020 20:34:28 +0100 (CET)
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
In-Reply-To: <CAEf4BzZOAukJZzo4J5q3F2v4MswQ6nJh6G1_c0H0fOJCdc7t0A@mail.gmail.com>
References: <20190820114706.18546-1-toke@redhat.com> <CAEf4BzZxb7qZabw6aDVaTqnhr3AGtwEo+DbuBR9U9tJr+qVuyg@mail.gmail.com> <87blwiqlc8.fsf@toke.dk> <CAEf4BzYMKPbfOu4a4UDEfJVcNW1-KvRwJ7PVo+Mf_1YUJgE4Qw@mail.gmail.com> <43e8c177-cc9c-ca0b-1622-e30a7a1281b7@iogearbox.net> <CAEf4Bzab_w0AXy5P9mG14mcyJVgUCzuuNda5FpU5wSEwUciGfg@mail.gmail.com> <87tva8m85t.fsf@toke.dk> <CAEf4BzbzQwLn87G046ZbkLtTbY6WF6o8JkygcPLPGUSezgs9Tw@mail.gmail.com> <CAEf4BzZOAukJZzo4J5q3F2v4MswQ6nJh6G1_c0H0fOJCdc7t0A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 03 Feb 2020 20:34:28 +0100
Message-ID: <87blqfcvnf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Aug 28, 2019 at 1:40 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Fri, Aug 23, 2019 at 4:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> >
>> > [ ... snip ...]
>> >
>> > > E.g., today's API is essentially three steps:
>> > >
>> > > 1. open and parse ELF: collect relos, programs, map definitions
>> > > 2. load: create maps from collected defs, do program/global data/CO-=
RE
>> > > relocs, load and verify BPF programs
>> > > 3. attach programs one by one.
>> > >
>> > > Between step 1 and 2 user has flexibility to create more maps, set up
>> > > map-in-map, etc. Between 2 and 3 you can fill in global data, fill in
>> > > tail call maps, etc. That's already pretty flexible. But we can tune
>> > > and break apart those steps even further, if necessary.
>> >
>> > Today, steps 1 and 2 can be collapsed into a single call to
>> > bpf_prog_load_xattr(). As Jesper's mail explains, for XDP we don't
>> > generally want to do all the fancy rewriting stuff, we just want a
>> > simple way to load a program and get reusable pinning of maps.
>>
>> I agree. See my response to Jesper's message. Note also my view of
>> bpf_prog_load_xattr() existence.
>>
>> > Preferably in a way that is compatible with the iproute2 loader.
>> >
>
> Hi Toke,
>
> I was wondering what's the state of converting iproute2 to use libbpf?
> Is this still something you (or someone else) interested to do?

Yeah, it's still on my list; planning to circle back to it once I have
finished an RFC implementation for XDP multiprog loading based on the
new function-replacing in the kernel.

(Not that this should keep anyone else from giving the conversion a go
and beating me to it :)).

> Briefly re-reading the thread, I think libbpf already has almost
> everything to be used by iproute2. You've added map pinning, so with
> bpf_map__set_pin_path() iproute2 should be able to specify pinning
> path, according to its own logic. The only thing missing that I can
> see is ability to specify numa_node, which we should add both to
> BTF-defined map definitions (trivial change), as well as probably
> expose a method like bpf_map__set_numa_node(struct bpf_map *map, int
> numa_node) for non-declarative and non-BTF legacy cases.

Yes, adding this to libbpf would be good.

> There was concern about supporting "extended" bpf_map_def format of
> iproute2 (bpf_elf_map, actually) with extra fields. I think it's
> actually easy to handle as is without any extra new APIs.
> bpf_object__open() w/ .relaxed_maps =3D true option will process
> compatible 5 fields of bpf_map_def (type, key/value sizes,
> max_entries, and map_flags) and will set up corresponding struct
> bpf_map entries (but won't create BPF maps in kernel yet). Then
> iproute2 can iterate over "maps" ELF section on its own, and see which
> maps need to get some more adjustments before load phase: map-in-map
> set up, numa node, pinning, etc. All those adjustments can be done
> (except for numa yet) through existing libbpf APIs, as far as I can
> tell. Once that is taken care of, proceed to bpf_object__load() and
> other standard steps. No callbacks, no extra cruft.
>
> Is there anything else that can block iproute2 conversion to libbpf?

I haven't looked into the details since my last RFC conversion series,
but from what I recall from that, and what we've been changing in libbpf
since, I was basically planning to do what you explained. So while there
are some details to work out, I believe it's basically straight forward,
and I can't think of anything that should block it.

> BTW, I have a draft patches for declarative (BTF-based) map-in-map set
> up and initialization the way I described it at Plumbers last year. So
> while I'm finalizing that, thought I'll resurrect iproute2 thread and
> see if we can get iproute2 migration to libbpf started.

Great! FWIW, as long as we have the legacy compatibility code in
iproute2, I don't think it'll be a problem (or a blocker for the
conversion) if BTF-defined maps can't express all the same things as the
legacy maps. The missing bits will come automatically as libbpf is
updated. But great to hear that you're working on this :)

-Toke

