Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CEA3BDF6A
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 00:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhGFWea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 18:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhGFWea (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Jul 2021 18:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625610710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0plHiQ4O41AKsmEuL/XnCXDWSUFNIAxxxolasTABxc=;
        b=FtJFRz5Fpu3MGKUL7/ZgL6Zxh9WoEs5RBEMfIHu/ePAU/DHKfaxVyXrpuSIaBGPR9TiKpr
        oVMdgnhJZJV4SMnFEcqBWWzQt2FQ7bkw7EB+ChNXql4VUEqrBQ25vTI7rgr5ggKOvAkVtt
        plMStl19IG3gKa1EaLdG3Xjd9ZOB6+4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-3-GQ9sCtM_ym7HZPj8ZI_A-1; Tue, 06 Jul 2021 18:31:49 -0400
X-MC-Unique: 3-GQ9sCtM_ym7HZPj8ZI_A-1
Received: by mail-ed1-f70.google.com with SMTP id d17-20020a05640208d1b0290399de3a0eecso306640edz.0
        for <bpf@vger.kernel.org>; Tue, 06 Jul 2021 15:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=T0plHiQ4O41AKsmEuL/XnCXDWSUFNIAxxxolasTABxc=;
        b=SgE40bhEFYNCxZNQ7exXsSA35bYvxnoOCLkCA9o9YMjsq8KFwUoa6Mp3jPVQ3/rGqJ
         0nwyTYlqRu9pt0Cn8jHhvZKK9m6is/aPlI1e98zOS3xCs7c1i3wSINA+KMhE/e9xq2S+
         7u67Q3gSv3vZuYux4+8PUl7RRs8fq+OAamFR0NhPDv563b00ulxMZW7S7EfSZYAn1M7/
         AzT9eHQasO0JciYGKBhzQN3rl0dR7DRWqXb0szFVHwSsNrWOxFO5jpX8lj9k/bGbwM3l
         6c9M/AS6G0tcsEk3c7KcShBQbZ3aIlhXU85wmeyErpw2xbidDkBBMFSPriNJzs2CSVoB
         nUhg==
X-Gm-Message-State: AOAM530kqrSFZYJsN1HkpJbOCmcVDNF6YW18sX3GJOxpHa/9SiGiI0Rg
        2N+A687o0dTpt2HtY2qygH37JuE4YttezdWDxFbMo2MLYUYOBXZnZeViGlM+WGPRLubNmAr6uXk
        zVK7XR0KBojeE
X-Received: by 2002:a17:906:3cc:: with SMTP id c12mr19769886eja.268.1625610707675;
        Tue, 06 Jul 2021 15:31:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFKPmZcY6nr9NFeulH9OTeDDMpn5Ktq/7aZiFIn6UDvn51ui/4/6eRoqDsisDJkkjI5vDOKQ==
X-Received: by 2002:a17:906:3cc:: with SMTP id c12mr19769871eja.268.1625610707321;
        Tue, 06 Jul 2021 15:31:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g8sm7888206edv.84.2021.07.06.15.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 15:31:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 01C6818072E; Wed,  7 Jul 2021 00:31:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: ignore .eh_frame sections when parsing
 elf files
In-Reply-To: <ebd98acb-1b54-cf8f-19cf-13ba3d575c27@fb.com>
References: <20210629110923.580029-1-toke@redhat.com>
 <ac14ef3c-ccd5-5f74-dda5-1d9366883813@iogearbox.net>
 <87czrxyrru.fsf@toke.dk>
 <e8385d06-ac0a-de99-de92-c91d5970b7e8@iogearbox.net>
 <87k0m3y815.fsf@toke.dk> <ebd98acb-1b54-cf8f-19cf-13ba3d575c27@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 07 Jul 2021 00:31:45 +0200
Message-ID: <87mtqzvzu6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 7/6/21 4:51 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>=20
>>> On 7/5/21 12:33 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>> On 6/29/21 1:09 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> The .eh_frame and .rel.eh_frame sections will be present in BPF obje=
ct
>>>>>> files when compiled using a multi-stage compile pipe like in samples=
/bpf.
>>>>>> This produces errors when loading such a file with libbpf. While the=
 errors
>>>>>> are technically harmless, they look odd and confuse users. So add .e=
h_frame
>>>>>> sections to is_sec_name_dwarf() so they will also be ignored by libb=
pf
>>>>>> processing. This gets rid of output like this from samples/bpf:
>>>>>>
>>>>>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>>>>>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32)=
 .eh_frame
>>>>>>
>>>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>>>
>>>>> For the samples/bpf case, could we instead just add a -fno-asynchrono=
us-unwind-tables
>>>>> to clang as cflags to avoid .eh_frame generation in the first place?
>>>>
>>>> Ah, great suggestion! Was trying, but failed, to figure out how to do
>>>> that. Just tested it, and yeah, that does fix samples; will send a
>>>> separate patch to add that.
>>>
>>> Sounds good, just applied.
>>=20
>> Awesome, thanks!
>>=20
>>>> I still think filtering this section name in libbpf is worthwhile,
>>>> though, as the error message is really just noise... WDYT?
>>>
>>> No strong opinion from my side, I can also see the argument that
>>> Andrii made some time ago [0] in that normally you should never see
>>> these in a BPF object file. But then ... there's BPF samples giving a
>>> wrong sample. ;( And I bet some users might have copied from there,
>>> and it's generally confusing from a user experience in libbpf on
>>> whether it's harmless or not.
>>=20
>> Yeah, they "shouldn't" be there, but they clearly can be. So given that
>> it's pretty trivial to filter it, IMO, that would be the friendly thing
>> to do. Let's see what Andrii thinks.
>>=20
>>> Side-question: Did you check if it is still necessary in general to
>>> have this multi-stage compile pipe in samples with the native clang
>>> frontend invocation (instead of bpf target one)? (Maybe it's time to
>>> get rid of it in general.)
>>=20
>> I started looking into this, but chickened out of actually changing it.
>> The comment above the rule mentions LLVM 12, so it seems like it has
>> been updated fairly recently, specifically in:
>> 9618bde489b2 ("samples/bpf: Change Makefile to cope with latest llvm")
>>=20
>> OTOH, that change does seem to be a fix to the native-compilation mode;
>> so maybe it would be viable to just change it to straight bpf-target
>> clang compilation? Yonghong, any opinion?
>
> Right, the fix is to fix a native-compilation for frontend with using=20
> bpf target as the backend.
>
> I think it is possible to use bpf-target clang compilation. You need
> to generate vmlinux.h (similar to selftests/bpf) and change Makefile
> etc.

Alright, cool. Probably won't get around to looking further at that
before my vacation, but possibly sometime after unless someone beats me
to it :)

-Toke

