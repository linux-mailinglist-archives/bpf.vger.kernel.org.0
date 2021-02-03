Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62C430E48F
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 22:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhBCVCU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 16:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhBCU6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 15:58:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716ADC061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 12:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nCkaK1SAMcKH5nVtadPcioAbScHFE2GvoJpakZKD3To=; b=O1acJBGC2p/dZdOKwEBZTnCE7R
        cgIU8Ki8PtBDb7l/HVpinUtTIyzq49tc87iGVikLW0KLQZ6mG5zdJrYUkmCLFqTi9RcHqJhzoKfK0
        KUt3j3XLuxUDOwwwQR3XPQRQR6S8WDM31soNXvtRG4prcWr5fa35HywZd7uC146aRdTMwIMpgRVf2
        6jnvSwyVyG5TWPd99wCR9T7MPK2AlvFFGPvNvu4omfntd4J5j5V8M0BXIpkBNI4FT3YaZ6+fIkpp5
        bn485W8pmx7IDKx1x2Kx3EY1ED+g/nA4lNjXEDYfEoZs3yV7Ix+nz+9SnQxYq3oAD1j5GF5PO++/b
        9Phj1nmQ==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7PDj-0006iJ-Be; Wed, 03 Feb 2021 20:57:51 +0000
Subject: Re: finding libelf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk> <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
 <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
 <44e6edc6-736e-dadb-c523-eabff8de89c0@infradead.org>
 <CAEf4BzbZNwHFYRtQZbEZrzqYF+8TenhZA8==N1wLO0nnbmi8Vw@mail.gmail.com>
 <93a6f6b6-167a-a2c6-f0dc-621d5a7bfc20@infradead.org>
 <CAEf4BzYMbu6X1kpx-oVuwsdrFAF9--_M5KGfFkiZomBPsuYHng@mail.gmail.com>
 <01ffaa2e-c0fd-95a1-a60a-eb90cbf868ad@infradead.org>
 <CAEf4BzaW-6_xFzD1tfyiU6vTa_02_0As+2RpRix+QpM2rWzUPQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8c900f52-5fc7-c34d-b045-db6d23c07abf@infradead.org>
Date:   Wed, 3 Feb 2021 12:57:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaW-6_xFzD1tfyiU6vTa_02_0As+2RpRix+QpM2rWzUPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/3/21 12:41 PM, Andrii Nakryiko wrote:
> On Wed, Feb 3, 2021 at 12:36 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 2/3/21 12:33 PM, Andrii Nakryiko wrote:
>>> On Wed, Feb 3, 2021 at 12:15 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>> On 2/3/21 12:12 PM, Andrii Nakryiko wrote:
>>>>> On Wed, Feb 3, 2021 at 12:09 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>>>
>>>>>> On 2/3/21 11:39 AM, Andrii Nakryiko wrote:
>>>>>>> On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>>>>>
>>>>>>>> On 2/3/21 2:57 AM, Toke Høiland-Jørgensen wrote:
>>>>>>>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> I see this sometimes when building a kernel: (on x86_64,
>>>>>>>>>> with today's linux-next 20210202):
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> CONFIG_CGROUP_BPF=y
>>>>>>>>>> CONFIG_BPF=y
>>>>>>>>>> CONFIG_BPF_SYSCALL=y
>>>>>>>>>> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
>>>>>>>>>> CONFIG_BPF_PRELOAD=y
>>>>>>>>>> CONFIG_BPF_PRELOAD_UMD=m
>>>>>>>>>> CONFIG_HAVE_EBPF_JIT=y
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Auto-detecting system features:
>>>>>>>>>> ...                        libelf: [ [31mOFF[m ]
>>>>>>>>>> ...                          zlib: [ [31mOFF[m ]
>>>>>>>>>> ...                           bpf: [ [31mOFF[m ]
>>>>>>>>>>
>>>>>>>>>> No libelf found
>>>>>>>>>> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
>>>>>>>>>> No zlib found
>>>>>>>>>> make[5]: [Makefile:290: zdep] Error 1 (ignored)
>>>>>>>>>> BPF API too old
>>>>>>>>>> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> but pkg-config tells me:
>>>>>>>>>>
>>>>>>>>>> $ pkg-config --modversion  libelf
>>>>>>>>>> 0.168
>>>>>>>>>> $ pkg-config --libs  libelf
>>>>>>>>>> -lelf
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Any ideas?
>>>>>>>>>
>>>>>>>>> This usually happens because there's a stale cache of the feature
>>>>>>>>> detection tests lying around somewhere. Look for a 'feature' directory
>>>>>>>>> in whatever subdir you got that error. Just removing the feature
>>>>>>>>> directory usually fixes this; I've fixed a couple of places where this
>>>>>>>>> is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/preload:
>>>>>>>>> Make sure Makefile cleans up after itself, and add .gitignore")) but I
>>>>>>>>> wouldn't be surprised if there are still some that are broken.
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Thanks for replying.
>>>>>>>>
>>>>>>>> I removed the feature subdir and still got this build error, so I
>>>>>>>> removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
>>>>>>>> and still got the same libelf build error.
>>>>>>>
>>>>>>> I hate the complexity of feature detection framework to the point that
>>>>>>> I'm willing to rip it out from libbpf's Makefile completely. I just
>>>>>>> spent an hour trying to understand what's going on in a very similar
>>>>>>> situation. Extremely frustrating.
>>>>>>>
>>>>>>> In your case, it might be feature detection triggered from
>>>>>>> resolve_btfids, so try removing
>>>>>>> $(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}.
>>>>>>>
>>>>>>> It seems like we don't do proper cleanup in resolve_btfids (it should
>>>>>>> probably call libbpf's clean as well). And it's beyond me why `make -C
>>>>>>> tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-case>
>>>>>>> file as well.
>>>>>>
>>>>>>
>>>>>> I don't think it's related to improper cleanup or old files/dirs
>>>>>> laying around. I say that because I did a full build in a new output dir.
>>>>>> and it still failed in the same way.
>>>>>
>>>>> If you cd tools/lib/bpf and run make there, does it detect those libraries?
>>>>
>>>> Yes:
>>>>
>>>> Auto-detecting system features:
>>>> ...                        libelf: [ on  ]
>>>> ...                          zlib: [ on  ]
>>>> ...                           bpf: [ on  ]
>>>>
>>>>
>>>
>>> Sounds exactly like my case. I removed
>>> $(O)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf} and it
>>> started working.
>>
>> I already tried that with no success.
>>
>> I suppose that it could be related to how I do builds:
>>
>> make ARCH=x86_64 O=subdir -j4 all
>>
>> so subdir is a relative path, not an absolute path.
> 
> so can you confirm this by specifying the absolute path to subdir?

Yes, absolute output path works for libelf, zlib, and bpf:

Auto-detecting system features:
...                        libelf: [ [32mon[m  ]
...                          zlib: [ [32mon[m  ]
...                           bpf: [ [32mon[m  ]


Are {feature,FEATURE-DUMP} created in multiple places?
I don't see them in $(OUTDIR)/tools -- there is no /bpf/ subdir there
at all.
I do see them in $(OUTDIR)/kernel/bpf/preload/ -- are those different
feature files?


thanks.
-- 
~Randy

