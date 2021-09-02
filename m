Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29543FF6DB
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 00:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhIBWJZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 18:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238860AbhIBWJQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 18:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630620495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRTtehvrGs5Rp+1LGzW7dE6SWDgidcOvl2SASfYQ/Ug=;
        b=UBpGcj4VcEIKcRE213p3qWRojcQ6JzetfF3FmlJjWCF8amTDaCeoWeJr6tIW22MnZoYUak
        CP/pHh2znjNN2Hj/EFpGCEvFMy7FdoQdcL1W/ZJ3OXz/hq+4AjgSH0LJI4g6neHOFu0jMV
        QURH/87i+GzqqYu1phpjduqzyE8SWsI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-qWc6tQenOQm4a7u4xX3F1w-1; Thu, 02 Sep 2021 18:08:14 -0400
X-MC-Unique: qWc6tQenOQm4a7u4xX3F1w-1
Received: by mail-ed1-f69.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so1720401edd.22
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 15:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LRTtehvrGs5Rp+1LGzW7dE6SWDgidcOvl2SASfYQ/Ug=;
        b=lLwuWG2DgSAUImh1gG7lViNACfPt+ntNrBwBPqL4IOfber3C3i1ei75HWjJytuxkBw
         6CVEXllR4WcM91atfv68u6VD8bF692i57b4A5p1xsGS16d7u0M072/KlV3HEyloiTFuk
         Cma/ypprmHKauNiwoHbV7DBH531MW2lCv2wh1veAkAz8QHRstK2qmHwnIv0WkkJz150p
         qA2QmiJ6HlmXp63a9EOP3uYoLgxYOsVJFO8CvTSo7L3wUYu+8rykcXecR5aRA392Tfy2
         5k4t5u1zqLcPwE3vIzUR3dDB5O7JPYmpbX7Q+malFBzt+37e/COMal/nXHUUsEi6Og0o
         NSfw==
X-Gm-Message-State: AOAM532pfnzKnY2QoZEscdOzfRDugqV9swIlJZmVT8xQvacxwwuxQzO4
        d8JkqO5T6TtWSVoM3aUg1QHD8b7wi1LDhGHnam+Axec9+WdGTXIC5I9jiD4S0CO6L0BuVhK9uFr
        5FXw+OKj4Wnp0
X-Received: by 2002:a50:ec10:: with SMTP id g16mr540334edr.35.1630620493227;
        Thu, 02 Sep 2021 15:08:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynK4Qt4Imm4P1DIMKdzPtf7rgY/jtp+BRN3m2cS/zx23pF+T8VL2d1a53z+0j6KNl4sWaeWg==
X-Received: by 2002:a50:ec10:: with SMTP id g16mr540317edr.35.1630620492952;
        Thu, 02 Sep 2021 15:08:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gz22sm1757129ejb.15.2021.09.02.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 15:08:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6FB4F1800EB; Fri,  3 Sep 2021 00:08:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
In-Reply-To: <095f116b-7399-25a5-dca2-145cbd093326@fb.com>
References: <20210826120953.11041-1-toke@redhat.com>
 <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
 <87lf4hvrgc.fsf@toke.dk> <a65e20f9-d554-761e-9a9e-8a9dfcf13919@fb.com>
 <87wnnysy6k.fsf@toke.dk>
 <CAADnVQKYdjFR+LvnQFdKF=TJ2fSRdG7B0L+Au9KchBsV+dCr5w@mail.gmail.com>
 <095f116b-7399-25a5-dca2-145cbd093326@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 03 Sep 2021 00:08:11 +0200
Message-ID: <87czpqskac.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 9/2/21 12:32 PM, Alexei Starovoitov wrote:
>> On Thu, Sep 2, 2021 at 10:08 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>>
>>> Yonghong Song <yhs@fb.com> writes:
>>>
>>>> On 8/31/21 3:28 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>>>>
>>>>>> On Thu, Aug 26, 2021 at 5:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>>>>>>>
>>>>>>> When .eh_frame and .rel.eh_frame sections are present in BPF object=
 files,
>>>>>>> libbpf produces errors like this when loading the file:
>>>>>>>
>>>>>>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>>>>>>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32=
) .eh_frame
>>>>>>>
>>>>>>> It is possible to get rid of the .eh_frame section by adding
>>>>>>> -fno-asynchronous-unwind-tables to the compilation, but we have seen
>>>>>>> multiple examples of these sections appearing in BPF files in the w=
ild,
>>>>>>> most recently in samples/bpf, fixed by:
>>>>>>> 5a0ae9872d5c ("bpf, samples: Add -fno-
>> /to BPF Clang invocation")
>>>>>>>
>>>>>>> While the errors are technically harmless, they look odd and confus=
e users.
>>>>>>
>>>>>> These warnings point out invalid set of compiler flags used for
>>>>>> compiling BPF object files, though. Which is a good thing and should
>>>>>> incentivize anyone getting those warnings to check and fix how they =
do
>>>>>> BPF compilation. Those .eh_frame sections shouldn't be present in BPF
>>>>>> object files at all, and that's what libbpf is trying to say.
>>>>>
>>>>> Apart from triggering that warning, what effect does this have, thoug=
h?
>>>>> The programs seem to work just fine (as evidenced by the fact that
>>>>> samples/bpf has been built this way for years, for instance)...
>>>>>
>>>>> Also, how is a user supposed to go from that cryptic error message to
>>>>> figuring out that it has something to do with compiler flags?
>>>>>
>>>>>> I don't know exactly in which situations that .eh_frame section is
>>>>>> added, but looking at our selftests (and now samples/bpf as well),
>>>>>> where we use -target bpf, we don't need
>>>>>> -fno-asynchronous-unwind-tables at all.
>>>>>
>>>>> This seems to at least be compiler-dependent. We ran into this with
>>>>> bpftool as well (for the internal BPF programs it loads whenever it
>>>>> runs), which already had '-target bpf' in the Makefile. We're carrying
>>>>> an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
>>>>> bpftool build to fix this...
>>>>
>>>> I haven't seen an instance of .eh_frame as well with -target bpf.
>>>> Do you have a reproducible test case? I would like to investigate
>>>> what is the possible cause and whether we could do something in llvm
>>>> to prevent its generatin. Thanks!
>>>
>>> We found this in the RHEL builds of bpftool. I don't think we're doing
>>> anything special, other than maybe building with a clang version that's
>>> a few versions behind:
>>>
>>> # clang --version
>>> clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+8598+a071fcd5)
>>> Target: x86_64-unknown-linux-gnu
>>> Thread model: posix
>>> InstalledDir: /usr/bin
>>>
>>> So I suppose it may resolve itself once we upgrade LLVM?
>>=20
>> That's odd. I don't think I've seen this issue even with clang 11
>> (but I built it myself).
>
> I cannot reproduce it by self with self built llvm (11, 12, 13, 14).
> But I can reproduce it with an upstream built llvm12.
>
> /bin/clang \
>          -I. \
>          -I/home/yhs/work/bpf-next/tools/include/uapi/ \
>          -I/home/yhs/work/bpf-next/tools/lib/bpf/ \
>          -I/home/yhs/work/bpf-next/tools/lib \
>          -g -O2 -Wall -target bpf -c skeleton/pid_iter.bpf.c -o=20
> pid_iter.bpf.o && llvm-strip -g pid_iter.bpf.o
>    GEN     pid_iter.skel.h
> libbpf: elf: skipping unrecognized data section(11) .eh_frame
> libbpf: elf: skipping relo section(12) .rel.eh_frame for section(11)=20
> .eh_frame

Ah, that's interesting!

>> If there is a fix indeed let's backport it to llvm 11. The user
>> experience matters.
>> It could be llvm configuration too.
>> I'm guessing some build flags might influence default settings
>> for unwind tables.
>>=20
>> Yonghong, can we make bpf backend to ignore needsUnwindTableEntry ?
>
> Sure. I will try to get upstream build flags, reproduce and fix it
> in llvm.

Awesome, thanks for looking at this! :)

-Toke

