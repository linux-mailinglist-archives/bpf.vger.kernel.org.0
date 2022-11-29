Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2863C904
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 21:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiK2UNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 15:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiK2UNj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 15:13:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE416584
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 12:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669752763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+KWwfKI9nvQmiuA6D2+Xcg1Vcrs8/Iy6EXPSx/Uh4c=;
        b=PHlyepbgJvSRugCNsQFx6vwyYtVp3HuQ3lerwpe9Xn9O6eknysfykM/asfO8AvagCW6u7L
        WS4EYrQCv3xJYhcy3W4FBlNy01wnYlQijQt3QTATVrTuYxoxt1mLzN4WuZCuUuBEN2TuiI
        i7DaiVjuJiNYQIhQwtdAqFegdpgwO6M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-yYsYKh93Mc-FK3i-8k-PCw-1; Tue, 29 Nov 2022 15:12:41 -0500
X-MC-Unique: yYsYKh93Mc-FK3i-8k-PCw-1
Received: by mail-ed1-f69.google.com with SMTP id v18-20020a056402349200b004622e273bbbso8734180edc.14
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 12:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+KWwfKI9nvQmiuA6D2+Xcg1Vcrs8/Iy6EXPSx/Uh4c=;
        b=OTaBkidpPdRPaanoF3G4RIw4/lVY9lo2DLv1fht1RzTrur8gwLjnwTfYP7VFNyTzPd
         5zECnRsV7wZvf1GIol06OxPULiOli6WdjoEiA7VDf8OeBsg2EggbEUDz3NLZJoAbMx9d
         7sWfR5HKPr5x9vrDIJz6tDM6lb7Njo7dtnh4K3Rc5e4+PlQ5ov18O/scWvZUepfHazgJ
         FmmWHKNb4A5iwC75hHCFNqLreXiQ1RbRRH4eVfX1c8cVrYsW1Z0R3dh0R57ErH6M92VM
         dbtWJe5UH0Q74WBNUcn1gfyagf1cD/VuAgQARfoHd+mUxe1TEOo3tRSHsTsXliumBbHp
         Jlmw==
X-Gm-Message-State: ANoB5pmqaQt7UaggSqv0UqMOuiuWVHG9ItiskIUKoLR0yFM2x8mPs2+q
        WFLxrTOQ6BmVKAC19s2XaAH/G1QCE0DUCqm22W7z8Em+bbflMJoFh0BJPx2uN10ejrJvUzUeTNj
        A91jlbCoSxVuB
X-Received: by 2002:aa7:d2d5:0:b0:469:9951:ac3a with SMTP id k21-20020aa7d2d5000000b004699951ac3amr38692017edr.339.1669752760344;
        Tue, 29 Nov 2022 12:12:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5X7D6OdWsi4kHo8TprpBa+9rsLHGNOn6yhWH2p/SR614h5VPjvkM9Rq67HKYUqQyfJuiFokA==
X-Received: by 2002:aa7:d2d5:0:b0:469:9951:ac3a with SMTP id k21-20020aa7d2d5000000b004699951ac3amr38691996edr.339.1669752759872;
        Tue, 29 Nov 2022 12:12:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gv39-20020a1709072be700b0073d9a0d0cbcsm6532143ejc.72.2022.11.29.12.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:12:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 61C7480AC42; Tue, 29 Nov 2022 21:12:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alan Maguire <alan.maguire@oracle.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: Calling kfuncs in modules - BTF mismatch?
In-Reply-To: <08fa5e85-4d7b-4725-f340-bcb8525036f1@oracle.com>
References: <87leoh372s.fsf@toke.dk>
 <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
 <875yfiwx1g.fsf@toke.dk> <08fa5e85-4d7b-4725-f340-bcb8525036f1@oracle.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 29 Nov 2022 21:12:38 +0100
Message-ID: <878rjtzfih.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alan Maguire <alan.maguire@oracle.com> writes:

> On 13/11/2022 18:04, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
>>=20
>>>>
>>>> Hi everyone
>>>>
>>>> There seems to be some issue with BTF mismatch when trying to run the
>>>> bpf_ct_set_nat_info() kfunc from a module. I was under the impression
>>>> that this is supposed to work, so is there some kind of BTF dedup issue
>>>> here or something?
>>>>
>>>> Steps to reproduce:
>>>>
>>>> 1. Compile kernel with nf_conntrack built-in and run selftests;
>>>>    './test_progs -a bpf_nf' works
>>>>
>>>> 2. Change the kernel config so nf_conntrack is build as a module
>>>>
>>>> 3. Start the test kernel and manually modprobe nf_conntrack and nf_nat
>>>>
>>>> 4. Run ./test_progs -a bpf_nf; this now fails with an error like:
>>>>
>>>> kernel function bpf_ct_set_nat_info args#0 expected pointer to STRUCT =
nf_conn___init but R1 has a pointer to STRUCT nf_conn___init
>>>
>>> This week Kumar and I took a look at this issue and we ended up
>>> identifying a duplication of nf_conn___init structure. In particular:
>>>
>>> [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
>>> net/netfilter/nf_conntrack.ko format raw | grep nf_conn__
>>> [110941] STRUCT 'nf_conn___init' size=3D248 vlen=3D1
>>> [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
>>> net/netfilter/nf_nat.ko format raw | grep nf_conn__
>>> [107488] STRUCT 'nf_conn___init' size=3D248 vlen=3D1
>>>
>>> Is it the root cause of the problem?
>>=20
>> It certainly seems to be related to it, at least. Amending the log
>> message to include the BTF object IDs of the two versions shows that the
>> register has a reference to nf_conn__init in nf_conntrack.ko, while the =
kernel
>> expects it to point to nf_nat.ko.
>>=20
>> Not sure what's the right fix for this? Should libbpf be smart enough to
>> pull the kfunc arg ID from the same BTF ID as the function itself? Or
>> should the kernel compare structs and allow things if they're identical?
>> Andrii, WDYT?
>>=20
>
> There were some dedup issues fixed recently in pahole
> and libbpf; since dwarves libbpf hasn't been synced with
> libbpf recently as far as I can see it won't have the fix=20
> for [1]; I suspect it may help with dedup-ing here. Would=20
> probably be worth trying rebuilding dwarves with a libbpf=20
> with [1] applied and seeing if the dedup issue goes away
> before we go any further. If it fixes the issue, would it
> be worth updating the libbpf that dwarves uses Arnaldo?
> I saw some pretty large improvements in removing
> redundant definitions.

I don't think it's a deduplication issue; the type is simply not defined
in vmlinux, so each module has its own "version" of it. And since each
module's BTF is semantically independent of other modules the
duplication is expected in this case.

-Toke

