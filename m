Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0465830E0C5
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhBCRVg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhBCRVf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 12:21:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E72C0613ED
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 09:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=YYVKkQ04NXHmPPt6gyavDzAoDyRwJzchdnbmrPLP+KQ=; b=ZMCvDg8IHPYTDfqtpKLnmEL1QA
        qgyFSo6LIqu9D+raKyyaLwIHkELkTRxQQ1nA/dwqoK8U2erayYucFGxTIhtzIP53GfgOgY1Y2yAiV
        P3pDqF7vx3PMaOEANzbWaLRkPn1xShhKxsHswuL5c3msQiFc8aSpD6O7OXIlFikenoDIgy1kTItzu
        7sYVOCgVm/iwbIDsv9s1GBIyY7TZxrGaKKKqf4m0pXD5vsZNX/u20T7LyQn3wUEinggqURzENZ2yp
        bjIhxS5ySnm8oMyoSIwPRhvjLAAldcpjAeybM8utKcKCVninhLzjSkwQ6vvkRB7aoMb3gTxJQ7lSk
        NwwpDrMA==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7Lpm-0008Rk-Dh; Wed, 03 Feb 2021 17:20:54 +0000
Subject: Re: finding libelf
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
Date:   Wed, 3 Feb 2021 09:20:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87eehxa06v.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/3/21 2:57 AM, Toke Høiland-Jørgensen wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Hi,
>>
>> I see this sometimes when building a kernel: (on x86_64,
>> with today's linux-next 20210202):
>>
>>
>> CONFIG_CGROUP_BPF=y
>> CONFIG_BPF=y
>> CONFIG_BPF_SYSCALL=y
>> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
>> CONFIG_BPF_PRELOAD=y
>> CONFIG_BPF_PRELOAD_UMD=m
>> CONFIG_HAVE_EBPF_JIT=y
>>
>>
>> Auto-detecting system features:
>> ...                        libelf: [ [31mOFF[m ]
>> ...                          zlib: [ [31mOFF[m ]
>> ...                           bpf: [ [31mOFF[m ]
>>
>> No libelf found
>> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
>> No zlib found
>> make[5]: [Makefile:290: zdep] Error 1 (ignored)
>> BPF API too old
>> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
>>
>>
>> but pkg-config tells me:
>>
>> $ pkg-config --modversion  libelf
>> 0.168
>> $ pkg-config --libs  libelf
>> -lelf
>>
>>
>> Any ideas?
> 
> This usually happens because there's a stale cache of the feature
> detection tests lying around somewhere. Look for a 'feature' directory
> in whatever subdir you got that error. Just removing the feature
> directory usually fixes this; I've fixed a couple of places where this
> is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/preload:
> Make sure Makefile cleans up after itself, and add .gitignore")) but I
> wouldn't be surprised if there are still some that are broken.

Hi,

Thanks for replying.

I removed the feature subdir and still got this build error, so I
removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
and still got the same libelf build error.


-- 
~Randy

