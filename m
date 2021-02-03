Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1056A30E3F1
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhBCUPu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 15:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBCUPm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 15:15:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164AFC061788
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=X5LjoJIq3DNJncJyKUjhizm/AKBzMpQPsOpPbGw6810=; b=zxgSSLiMb7jHQew+lneWqIY5le
        oMOIOD1eKwIiIM5hGiUBsGWxnHla35RgczPcn5HYhmQtD/FlAUAzCec6XRiYbFvRFyefJnhMUqMpJ
        FxtN56fkGRITBse+9u0DnAfMn77e6t1KHHkQ2/KWYtboMv3+r8fbZlEB+iDd3R4qJANrAsDt120r9
        BmN3wThXQL6pu/0vNCXx8Ou9xheAxt1+2g+jpJnqwkRwDxH+oRpFseNRBCDFicod3SXEE1BKFhGtM
        592EpgZ5ESPv+x/bcxydJmeboLhw68WxuiUiWZVgi4XQicZYW0WgTzG96+9nvd7wOuJ+np3ubfW1e
        gwSyaUNQ==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7OYF-0004tG-VJ; Wed, 03 Feb 2021 20:15:00 +0000
Subject: Re: finding libelf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk> <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
 <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
 <44e6edc6-736e-dadb-c523-eabff8de89c0@infradead.org>
 <CAEf4BzbZNwHFYRtQZbEZrzqYF+8TenhZA8==N1wLO0nnbmi8Vw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <93a6f6b6-167a-a2c6-f0dc-621d5a7bfc20@infradead.org>
Date:   Wed, 3 Feb 2021 12:14:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbZNwHFYRtQZbEZrzqYF+8TenhZA8==N1wLO0nnbmi8Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/3/21 12:12 PM, Andrii Nakryiko wrote:
> On Wed, Feb 3, 2021 at 12:09 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 2/3/21 11:39 AM, Andrii Nakryiko wrote:
>>> On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>> On 2/3/21 2:57 AM, Toke Høiland-Jørgensen wrote:
>>>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I see this sometimes when building a kernel: (on x86_64,
>>>>>> with today's linux-next 20210202):
>>>>>>
>>>>>>
>>>>>> CONFIG_CGROUP_BPF=y
>>>>>> CONFIG_BPF=y
>>>>>> CONFIG_BPF_SYSCALL=y
>>>>>> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
>>>>>> CONFIG_BPF_PRELOAD=y
>>>>>> CONFIG_BPF_PRELOAD_UMD=m
>>>>>> CONFIG_HAVE_EBPF_JIT=y
>>>>>>
>>>>>>
>>>>>> Auto-detecting system features:
>>>>>> ...                        libelf: [ [31mOFF[m ]
>>>>>> ...                          zlib: [ [31mOFF[m ]
>>>>>> ...                           bpf: [ [31mOFF[m ]
>>>>>>
>>>>>> No libelf found
>>>>>> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
>>>>>> No zlib found
>>>>>> make[5]: [Makefile:290: zdep] Error 1 (ignored)
>>>>>> BPF API too old
>>>>>> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
>>>>>>
>>>>>>
>>>>>> but pkg-config tells me:
>>>>>>
>>>>>> $ pkg-config --modversion  libelf
>>>>>> 0.168
>>>>>> $ pkg-config --libs  libelf
>>>>>> -lelf
>>>>>>
>>>>>>
>>>>>> Any ideas?
>>>>>
>>>>> This usually happens because there's a stale cache of the feature
>>>>> detection tests lying around somewhere. Look for a 'feature' directory
>>>>> in whatever subdir you got that error. Just removing the feature
>>>>> directory usually fixes this; I've fixed a couple of places where this
>>>>> is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/preload:
>>>>> Make sure Makefile cleans up after itself, and add .gitignore")) but I
>>>>> wouldn't be surprised if there are still some that are broken.
>>>>
>>>> Hi,
>>>>
>>>> Thanks for replying.
>>>>
>>>> I removed the feature subdir and still got this build error, so I
>>>> removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
>>>> and still got the same libelf build error.
>>>
>>> I hate the complexity of feature detection framework to the point that
>>> I'm willing to rip it out from libbpf's Makefile completely. I just
>>> spent an hour trying to understand what's going on in a very similar
>>> situation. Extremely frustrating.
>>>
>>> In your case, it might be feature detection triggered from
>>> resolve_btfids, so try removing
>>> $(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}.
>>>
>>> It seems like we don't do proper cleanup in resolve_btfids (it should
>>> probably call libbpf's clean as well). And it's beyond me why `make -C
>>> tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-case>
>>> file as well.
>>
>>
>> I don't think it's related to improper cleanup or old files/dirs
>> laying around. I say that because I did a full build in a new output dir.
>> and it still failed in the same way.
> 
> If you cd tools/lib/bpf and run make there, does it detect those libraries?

Yes:

Auto-detecting system features:
...                        libelf: [ on  ]
...                          zlib: [ on  ]
...                           bpf: [ on  ]


-- 
~Randy

