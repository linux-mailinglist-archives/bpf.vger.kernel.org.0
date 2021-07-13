Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB06C3C7585
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhGMRKl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 13:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhGMRKk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Jul 2021 13:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626196070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ionxxLJP+uSFDPajUVpEpY9G+XEot0E9PEb32IhyWQY=;
        b=QG30y+QZFb2zXi7M57JdrWdFWPvDIrQ0PpbNSEzEtQYJgMuKjVlC2hqtPRGmBrI0qtphVO
        g8UzegMz0K2vvq8llrEz87AVlof/zIC9050Er1UQBKhJyC8TlSY95X9aiYVCdXI37YeUE5
        MIxtQ02RDXZJ7gR0pw4mjZpskMA4n10=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-O1H534MHOKCTpUdDxU0Niw-1; Tue, 13 Jul 2021 13:07:48 -0400
X-MC-Unique: O1H534MHOKCTpUdDxU0Niw-1
Received: by mail-ed1-f72.google.com with SMTP id f20-20020a0564020054b0290395573bbc17so12234646edu.19
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 10:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ionxxLJP+uSFDPajUVpEpY9G+XEot0E9PEb32IhyWQY=;
        b=RwsMEa/OA/pK6u8RKtQsrprWcLzn0i3sF981MPTUuZPLg7Ucw3v0OHUtsti7VAQElI
         O3qTGfgbZCJrOElKLxWQcYdYYcJKoIfTwJNrZ5HtyoqNGYCQgGOjt/jtrVaX1TD8jo1l
         oeBWMFVLexwnHs0V6tK5vmAOjxnyILr8WkpHZRUOJ6RsQKPbmqJzq00aeg08mO7T3KOj
         EfKpWFj25QNKVpuO0V+t3ZPxiNIPjajjMEw9+wJsvOooA9PhhVBorXBVBo80R7p5i9g5
         p0wuH5ww7VdyXF93CVszIO1nN9n/noCm8Yi/RHIIojlxNOeUm9WSrNl87ymjLQ091iZu
         huLg==
X-Gm-Message-State: AOAM530Ls9URgtD8VkpQfWUom0Bv69hndykrApdGHV1GfR1to8KzpKNW
        5K6xGvufMMb+2OSr5h3Ub3qBxNrQ5fbVZhyktS1Z02eUYkxHaJPklVI0YrjvKJ06b+kzinWGFtl
        gi8tcaE0dK9S7
X-Received: by 2002:aa7:d942:: with SMTP id l2mr6327083eds.235.1626196067659;
        Tue, 13 Jul 2021 10:07:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweAwx1M0p7Csk29oHTHdowr3Tu/FQ3euKOopaSX6uSU9IPkGBHCBBSrIikg7pWPT1zDcB6hg==
X-Received: by 2002:aa7:d942:: with SMTP id l2mr6327055eds.235.1626196067455;
        Tue, 13 Jul 2021 10:07:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q23sm9915123edt.22.2021.07.13.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:07:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CC6CD1804B7; Tue, 13 Jul 2021 19:07:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "luwei (O)" <luwei32@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        David Ahern <dahern@digitalocean.com>
Subject: Re: Ask for help about bpf map
In-Reply-To: <CAEf4BzZpSo8Kqz8mgPdbWTTVLqJ1AgE429_KHTiXgEVpbT97Yw@mail.gmail.com>
References: <5aebe6f4-ca0d-4f64-8ee6-b68c58675271@huawei.com>
 <CAEf4BzZpSo8Kqz8mgPdbWTTVLqJ1AgE429_KHTiXgEVpbT97Yw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 13 Jul 2021 19:07:45 +0200
Message-ID: <8735sidtwe.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Jul 12, 2021 at 11:35 PM luwei (O) <luwei32@huawei.com> wrote:
>>
>> Hi, List:
>>
>>        I am a beginner about bpf and working on XDP now. I meet a
>> problem and feel difficult to figure it out.
>>
>>        In my following codes, I use two ways to define my_map: in SEC
>> maps and SEC .maps respectively. When I load the xdp_kern.o file,
>>
>> It has different results. The way I load is: ip link set dev ens3 xdp
>> obj xdp1_kern.o sec xdp1.
>>
>>        when I define my_map using SEC maps, it loads successfully but
>> fails to load using SEC .maps, it reports:
>>
>> "
>>
>> [12] TYPEDEF __u32 type_id=13
>> [13] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> [14] FUNC_PROTO (anon) return=2 args=(10 ctx)
>> [15] FUNC xdp_prog1 type_id=14
>> [16] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>> [17] ARRAY (anon) type_id=16 index_type_id=4 nr_elems=4
>> [18] VAR _license type_id=17 linkage=1
>> [19] DATASEC .maps size=0 vlen=1 size == 0
>>
>>
>> Prog section 'xdp1' rejected: Permission denied (13)!
>>   - Type:         6
>>   - Instructions: 9 (0 over limit)
>>   - License:      GPL
>>
>> Verifier analysis:
>>
>> 0: (b7) r1 = 0
>> 1: (63) *(u32 *)(r10 -4) = r1
>> last_idx 1 first_idx 0
>> regs=2 stack=0 before 0: (b7) r1 = 0
>> 2: (bf) r2 = r10
>> 3: (07) r2 += -4
>> 4: (18) r1 = 0x0
>
> this shouldn't be 0x0.
>
> I suspect you have an old iproute2 which doesn't yet use libbpf to
> load BPF programs, so .maps definition is not yet supported. cc'ing
> netdev@vger, David and Toke

That would be my guess as well; what's the output of 'ip -V'?

-Toke

