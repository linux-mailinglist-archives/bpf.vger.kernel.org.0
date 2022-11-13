Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4F3627168
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 19:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiKMSFo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 13:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMSFn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 13:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C157DFF0
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668362688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N9OJ0x8MrvaJl/DjUU16mVrSN9xb8A083xpJrrJNsVE=;
        b=HDCvDBldFWlqrfw8d89dF2C+CY6n+yyaIObB3Ji7GO/KhfKgx+yyzcRpy1COd9Q3iwn1De
        +Yap8+qDLaSmXIa9AU0LL8cNzLdwVjGZ9dKjMYMT6pSfmfxQ5E8cIWlRUYpUF317EhtvIB
        fJGptcyWn1+urxHt0AESkM6ToTr9qJU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-4LB6Zjo7MZu9tM0uWrHf8Q-1; Sun, 13 Nov 2022 13:04:46 -0500
X-MC-Unique: 4LB6Zjo7MZu9tM0uWrHf8Q-1
Received: by mail-ed1-f71.google.com with SMTP id e15-20020a056402190f00b00461b0576620so6726730edz.2
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 10:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9OJ0x8MrvaJl/DjUU16mVrSN9xb8A083xpJrrJNsVE=;
        b=NsWmq8Hx9+n935UkVparujR0wk7cLxGioaNnPtmNc6n3rIsTe7Zgl48W0xJEA95AcY
         xgbPCbD8ZMhuw86Qq2CB5JlkJOgktkWs56+JDfbTHMkJqbcCxh6eoyZYBfn9yTMT7dD0
         FvOnyhcjht8aJTIGywJRJHjmO5MaGZHc7gQSxrJMGNk49a/Mfs6hv0KnN0cCP2kplGye
         hwKR6BmLCRbOD8L5CIC5xpcyvvQAr6FqCUXUFP8xOlaSBvCxShfPdr/tqnHrtqopwNfh
         nCsECsrY8trKsxEtbMDaaDr7J0dLf221JW6Ow60EkATuB0eGwoek/WpfAcGyqROUxDyH
         Mtxg==
X-Gm-Message-State: ANoB5plwcqAhE2WNm8uMlP2GmQRqXZW5wuSh4BbM+djxA1sfeCiMxwKp
        r9w3plRa7u0yOkckklAVCBOIvwe7Ptu616vK23fPXLhhPPSPm90wZp44KasDwsI+Nc70SLvfngc
        3i9H8BzYCiG6k
X-Received: by 2002:a17:907:110d:b0:7a9:6107:572a with SMTP id qu13-20020a170907110d00b007a96107572amr8226464ejb.729.1668362685407;
        Sun, 13 Nov 2022 10:04:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Ji+2YF7kB9se3JOD6xPVfmmyu67Ta+P9TMJpdu6H3Gdkb6L9SxUewxV/1odjQTvBWFgzR2Q==
X-Received: by 2002:a17:907:110d:b0:7a9:6107:572a with SMTP id qu13-20020a170907110d00b007a96107572amr8226449ejb.729.1668362684975;
        Sun, 13 Nov 2022 10:04:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0073dc5bb7c32sm3226700eja.64.2022.11.13.10.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 10:04:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0C6627A69E0; Sun, 13 Nov 2022 19:04:43 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: Calling kfuncs in modules - BTF mismatch?
In-Reply-To: <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
References: <87leoh372s.fsf@toke.dk>
 <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 13 Nov 2022 19:04:43 +0100
Message-ID: <875yfiwx1g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>>
>> Hi everyone
>>
>> There seems to be some issue with BTF mismatch when trying to run the
>> bpf_ct_set_nat_info() kfunc from a module. I was under the impression
>> that this is supposed to work, so is there some kind of BTF dedup issue
>> here or something?
>>
>> Steps to reproduce:
>>
>> 1. Compile kernel with nf_conntrack built-in and run selftests;
>>    './test_progs -a bpf_nf' works
>>
>> 2. Change the kernel config so nf_conntrack is build as a module
>>
>> 3. Start the test kernel and manually modprobe nf_conntrack and nf_nat
>>
>> 4. Run ./test_progs -a bpf_nf; this now fails with an error like:
>>
>> kernel function bpf_ct_set_nat_info args#0 expected pointer to STRUCT nf_conn___init but R1 has a pointer to STRUCT nf_conn___init
>
> This week Kumar and I took a look at this issue and we ended up
> identifying a duplication of nf_conn___init structure. In particular:
>
> [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> net/netfilter/nf_conntrack.ko format raw | grep nf_conn__
> [110941] STRUCT 'nf_conn___init' size=248 vlen=1
> [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> net/netfilter/nf_nat.ko format raw | grep nf_conn__
> [107488] STRUCT 'nf_conn___init' size=248 vlen=1
>
> Is it the root cause of the problem?

It certainly seems to be related to it, at least. Amending the log
message to include the BTF object IDs of the two versions shows that the
register has a reference to nf_conn__init in nf_conntrack.ko, while the kernel
expects it to point to nf_nat.ko.

Not sure what's the right fix for this? Should libbpf be smart enough to
pull the kfunc arg ID from the same BTF ID as the function itself? Or
should the kernel compare structs and allow things if they're identical?
Andrii, WDYT?

-Toke

