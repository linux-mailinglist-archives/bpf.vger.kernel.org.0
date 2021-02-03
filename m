Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAA30E3DD
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 21:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBCUJl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 15:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBCUJi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 15:09:38 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FE9C061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 12:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=//k02uieVOfhoffjBzKL5LS02hSZCBP8MVUDuAA87S4=; b=mikM6z2QBMcPe5UXzcWlTg57cM
        mgtuDSjLoAnDoJ3OyMrtPEerFOgiUURemsyI+Wy+Yq+sJXTtYUFPNo9jo8xOhno2xQrPFiacOaAHY
        sfd4xwsLDpcc2QIdWdg25BQtYvxFDj9wGSVMNnwQI3zg1/KLBXz34B5YpKX6hdCKkzE9+slDzd/T9
        xL6oJ0KkrMBbEABFkAcp4Gi1ArRT2uGNmoRKQm58GMYtyGOKICWW161PRaKkBWyq8EAjy5RJEYR3s
        DJyhsebB0Izyp1sexKyY42baAEz5GVOFAag+RIhP6c6AmIScLZ1z+Y18ZUyN6lHcvLr0MwLQs/k2P
        fDq0u62Q==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7OSm-0004ba-CT; Wed, 03 Feb 2021 20:09:20 +0000
Subject: Re: finding libelf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk> <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
 <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <44e6edc6-736e-dadb-c523-eabff8de89c0@infradead.org>
Date:   Wed, 3 Feb 2021 12:09:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/3/21 11:39 AM, Andrii Nakryiko wrote:
> On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 2/3/21 2:57 AM, Toke Høiland-Jørgensen wrote:
>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>
>>>> Hi,
>>>>
>>>> I see this sometimes when building a kernel: (on x86_64,
>>>> with today's linux-next 20210202):
>>>>
>>>>
>>>> CONFIG_CGROUP_BPF=y
>>>> CONFIG_BPF=y
>>>> CONFIG_BPF_SYSCALL=y
>>>> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
>>>> CONFIG_BPF_PRELOAD=y
>>>> CONFIG_BPF_PRELOAD_UMD=m
>>>> CONFIG_HAVE_EBPF_JIT=y
>>>>
>>>>
>>>> Auto-detecting system features:
>>>> ...                        libelf: [ [31mOFF[m ]
>>>> ...                          zlib: [ [31mOFF[m ]
>>>> ...                           bpf: [ [31mOFF[m ]
>>>>
>>>> No libelf found
>>>> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
>>>> No zlib found
>>>> make[5]: [Makefile:290: zdep] Error 1 (ignored)
>>>> BPF API too old
>>>> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
>>>>
>>>>
>>>> but pkg-config tells me:
>>>>
>>>> $ pkg-config --modversion  libelf
>>>> 0.168
>>>> $ pkg-config --libs  libelf
>>>> -lelf
>>>>
>>>>
>>>> Any ideas?
>>>
>>> This usually happens because there's a stale cache of the feature
>>> detection tests lying around somewhere. Look for a 'feature' directory
>>> in whatever subdir you got that error. Just removing the feature
>>> directory usually fixes this; I've fixed a couple of places where this
>>> is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/preload:
>>> Make sure Makefile cleans up after itself, and add .gitignore")) but I
>>> wouldn't be surprised if there are still some that are broken.
>>
>> Hi,
>>
>> Thanks for replying.
>>
>> I removed the feature subdir and still got this build error, so I
>> removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
>> and still got the same libelf build error.
> 
> I hate the complexity of feature detection framework to the point that
> I'm willing to rip it out from libbpf's Makefile completely. I just
> spent an hour trying to understand what's going on in a very similar
> situation. Extremely frustrating.
> 
> In your case, it might be feature detection triggered from
> resolve_btfids, so try removing
> $(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}.
> 
> It seems like we don't do proper cleanup in resolve_btfids (it should
> probably call libbpf's clean as well). And it's beyond me why `make -C
> tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-case>
> file as well.


I don't think it's related to improper cleanup or old files/dirs
laying around. I say that because I did a full build in a new output dir.
and it still failed in the same way.

-- 
~Randy

