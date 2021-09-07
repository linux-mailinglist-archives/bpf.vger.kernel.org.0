Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC426402F04
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhIGThu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 15:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhIGThu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 15:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631043402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wh0PxmxgwX08syHYz2ZnmPIrMpxbVha7fs1h1Pr8gP8=;
        b=UETLABgXY34VZMAUgRcnMLoI5SiNXIBrvKEKTZLsmOj+vHAZhG2bf0A9Qe7PEVLap2NOu1
        yRqzfSpiOYrh2I3JAjQSi8FMgYh9yx/ouTzt1vEF1ePKmW0GkQI+YBCoup00Sz+uoP0djz
        NbWS26NNoWffBnlBdOiyZCeiAC6GiDM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-n0e4IsRlONW0FtH66yeUig-1; Tue, 07 Sep 2021 15:36:40 -0400
X-MC-Unique: n0e4IsRlONW0FtH66yeUig-1
Received: by mail-ed1-f72.google.com with SMTP id j13-20020aa7ca4d000000b003c44c679d73so5886669edt.8
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 12:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Wh0PxmxgwX08syHYz2ZnmPIrMpxbVha7fs1h1Pr8gP8=;
        b=VW2FGPvz7AJQpxO+e87MyFAuBOsWpq5DOCcgvVw2Vh1o6XY0xRSKz2IPY/HVu4QJ8m
         y2sxY3Pffd1Q8BZ6yEuJqzKCcralnzK7FBH7n8FKlZ3YD6NDaEsfdwrhVvXZLNYBdAFD
         VDZmUcIeLw6vDmdL5Xfp0rzCPtV3qRoEx+sNyw1p+rm/KhD3GwgE8NAlbiF05a86Qto0
         AENrewr1N2RVyuHuM6z4nhc4nTqz6HwbkhZ7HrANXEf7UyTfs4B7qYaWiPIWHMU9tZvd
         D65e4HaSBDcq1knjVlGF+EBbDVEboI+iw0DjfR6Ri6O0OgHyojIADyQ9w7MWcs+sFiRG
         +kcQ==
X-Gm-Message-State: AOAM533aPb2l7Hpsb83qicYFo60nDG1NSZyklsIabktqoJEiEp+qz+ma
        K+1FSq3qPRdf4g3d+S1fboc6gT4Pxfz0o532ggbgZuzp60PW/iexnu/YmaSRo+bbqmBgDhyMkio
        AEFg2fTp4UnWZ
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr19980863eje.104.1631043399523;
        Tue, 07 Sep 2021 12:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkvJ+Zeud45W4mo6NYz2XAj0wbccYGntoiDGNW/ZAY9Scn70JS2A17PenbYrFeJs9dfaq5QQ==
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr19980833eje.104.1631043399204;
        Tue, 07 Sep 2021 12:36:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id qq16sm5881386ejb.120.2021.09.07.12.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:36:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D3B3718022B; Tue,  7 Sep 2021 21:36:37 +0200 (CEST)
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
In-Reply-To: <0426a8fb-ee42-cbcc-65e9-45654adf5948@fb.com>
References: <20210826120953.11041-1-toke@redhat.com>
 <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
 <87lf4hvrgc.fsf@toke.dk> <a65e20f9-d554-761e-9a9e-8a9dfcf13919@fb.com>
 <87wnnysy6k.fsf@toke.dk>
 <CAADnVQKYdjFR+LvnQFdKF=TJ2fSRdG7B0L+Au9KchBsV+dCr5w@mail.gmail.com>
 <095f116b-7399-25a5-dca2-145cbd093326@fb.com> <87czpqskac.fsf@toke.dk>
 <0426a8fb-ee42-cbcc-65e9-45654adf5948@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 Sep 2021 21:36:37 +0200
Message-ID: <87fsugp48q.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 9/2/21 3:08 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yonghong Song <yhs@fb.com> writes:
>>=20
>>> On 9/2/21 12:32 PM, Alexei Starovoitov wrote:
>>>> On Thu, Sep 2, 2021 at 10:08 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
>>>>>
>>>>> Yonghong Song <yhs@fb.com> writes:
>>>>>
>>>>>> On 8/31/21 3:28 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>>>>>>
>>>>>>>> On Thu, Aug 26, 2021 at 5:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> When .eh_frame and .rel.eh_frame sections are present in BPF obje=
ct files,
>>>>>>>>> libbpf produces errors like this when loading the file:
>>>>>>>>>
>>>>>>>>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>>>>>>>>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(=
32) .eh_frame
>>>>>>>>>
>>>>>>>>> It is possible to get rid of the .eh_frame section by adding
>>>>>>>>> -fno-asynchronous-unwind-tables to the compilation, but we have s=
een
>>>>>>>>> multiple examples of these sections appearing in BPF files in the=
 wild,
>>>>>>>>> most recently in samples/bpf, fixed by:
>>>>>>>>> 5a0ae9872d5c ("bpf, samples: Add -fno-
>>>> /to BPF Clang invocation")
>>>>>>>>>
>>>>>>>>> While the errors are technically harmless, they look odd and conf=
use users.
>>>>>>>>
>>>>>>>> These warnings point out invalid set of compiler flags used for
>>>>>>>> compiling BPF object files, though. Which is a good thing and shou=
ld
>>>>>>>> incentivize anyone getting those warnings to check and fix how the=
y do
>>>>>>>> BPF compilation. Those .eh_frame sections shouldn't be present in =
BPF
>>>>>>>> object files at all, and that's what libbpf is trying to say.
>>>>>>>
>>>>>>> Apart from triggering that warning, what effect does this have, tho=
ugh?
>>>>>>> The programs seem to work just fine (as evidenced by the fact that
>>>>>>> samples/bpf has been built this way for years, for instance)...
>>>>>>>
>>>>>>> Also, how is a user supposed to go from that cryptic error message =
to
>>>>>>> figuring out that it has something to do with compiler flags?
>>>>>>>
>>>>>>>> I don't know exactly in which situations that .eh_frame section is
>>>>>>>> added, but looking at our selftests (and now samples/bpf as well),
>>>>>>>> where we use -target bpf, we don't need
>>>>>>>> -fno-asynchronous-unwind-tables at all.
>>>>>>>
>>>>>>> This seems to at least be compiler-dependent. We ran into this with
>>>>>>> bpftool as well (for the internal BPF programs it loads whenever it
>>>>>>> runs), which already had '-target bpf' in the Makefile. We're carry=
ing
>>>>>>> an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
>>>>>>> bpftool build to fix this...
>>>>>>
>>>>>> I haven't seen an instance of .eh_frame as well with -target bpf.
>>>>>> Do you have a reproducible test case? I would like to investigate
>>>>>> what is the possible cause and whether we could do something in llvm
>>>>>> to prevent its generatin. Thanks!
>>>>>
>>>>> We found this in the RHEL builds of bpftool. I don't think we're doing
>>>>> anything special, other than maybe building with a clang version that=
's
>>>>> a few versions behind:
>>>>>
>>>>> # clang --version
>>>>> clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+8598+a071fcd5)
>>>>> Target: x86_64-unknown-linux-gnu
>>>>> Thread model: posix
>>>>> InstalledDir: /usr/bin
>>>>>
>>>>> So I suppose it may resolve itself once we upgrade LLVM?
>>>>
>>>> That's odd. I don't think I've seen this issue even with clang 11
>>>> (but I built it myself).
>>>
>>> I cannot reproduce it by self with self built llvm (11, 12, 13, 14).
>>> But I can reproduce it with an upstream built llvm12.
>>>
>>> /bin/clang \
>>>           -I. \
>>>           -I/home/yhs/work/bpf-next/tools/include/uapi/ \
>>>           -I/home/yhs/work/bpf-next/tools/lib/bpf/ \
>>>           -I/home/yhs/work/bpf-next/tools/lib \
>>>           -g -O2 -Wall -target bpf -c skeleton/pid_iter.bpf.c -o
>>> pid_iter.bpf.o && llvm-strip -g pid_iter.bpf.o
>>>     GEN     pid_iter.skel.h
>>> libbpf: elf: skipping unrecognized data section(11) .eh_frame
>>> libbpf: elf: skipping relo section(12) .rel.eh_frame for section(11)
>>> .eh_frame
>>=20
>> Ah, that's interesting!
>>=20
>>>> If there is a fix indeed let's backport it to llvm 11. The user
>>>> experience matters.
>>>> It could be llvm configuration too.
>>>> I'm guessing some build flags might influence default settings
>>>> for unwind tables.
>>>>
>>>> Yonghong, can we make bpf backend to ignore needsUnwindTableEntry ?
>>>
>>> Sure. I will try to get upstream build flags, reproduce and fix it
>>> in llvm.
>
> I did some investigation and this is due to centos private patch:
> https://git.centos.org/rpms/clang/blob/b99d8d4a38320329e10570f308c3e2d8cf=
295c78/f/SOURCES/0002-PATCH-clang-Make-funwind-tables-the-default-on-all-a.=
patch
>
> In upstream, the original llvm-project source is patched with
> several private patches before building the rpm.
> https://koji.mbox.centos.org/pkgs/packages/clang/12.0.1/1.module_el8.5.0+=
892+54d791e1/data/logs/x86_64/build.log
>
> The above private patch enables unwind-table (.eh_frame section)
> by default for ALL architectures and bpf is a victim of this.

Ah, doh! I had no idea we were doing this :/

> I filed a redhat bugzilla bug to fix their private patch.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2002024
>
> Hopefully future newer compiler build won't have this issue.

Thank you for finding the root cause of this! I'll follow up internally
and make sure we get this fixed...

-Toke

