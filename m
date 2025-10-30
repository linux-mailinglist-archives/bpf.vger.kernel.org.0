Return-Path: <bpf+bounces-73033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58E1C20E77
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2DA1889EBC
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A4835BDC6;
	Thu, 30 Oct 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tr1Of0Hs"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6F157A72
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837544; cv=none; b=QnFHtGhimXwIE0Qv6zQUCUlvkJNfPrMaFmFA2hRiPtUnloKNzzIIkAPK8Rd2cEX0XickINW9OuHgt9iXMhSRtwUuLhp2JAvK7Vxb6mlZDw9Ha4gsag1iq7FB9JWwta8btcoSmSBxP4FhjVqzmi1y+VrW1xpAQgl1ANQONkd6f6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837544; c=relaxed/simple;
	bh=3FIJl9mveDWptbQKjHjJEmwaODWR/AGMjlfjqnulFw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbfLLsnHC668V8v05lD/pn98QYcsYBhMCbXefcddyvzC9v2x2SDVsH2A1HwHqLIA0uK7GFW1KHFEoHw0fBGoR0ixawM6FuLwN6DgC+0SX9qUSCPzxiMOdS89IW6wpVqLZe1dlQKFlyR0k9H+krv1A8kjlOWQcflflnaXiq7fyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tr1Of0Hs; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff3cb8dc-ef02-4e83-8a58-ad9b561e5213@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761837540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/5WEphAD3bGSAX4FXdQkWzt6V9PNMYJmpKFuVQ+R38=;
	b=tr1Of0HsVVBnq+cNIyPsA7wU4PvKjxWvVvpfXBXDtA9YOTraToDgCwz1YL6b93+kF/szuM
	fsCcTJfSRmaeXeuY9zJX7UvFFsDh9DfMWXNm9LaWhkyyAQ5IPquVWYd1/2wbJYcVJOz7mu
	SirRnZ18NAKQvS9nQqhCk/UVP+HAgFc=
Date: Thu, 30 Oct 2025 08:18:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Make migrate_{disable,enable} always inline if
 in header file
Content-Language: en-GB
To: Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20251029183646.3811774-1-yonghong.song@linux.dev>
 <CAADnVQJbat5mwSoDUUf9yNheTe6h58f3JFM=UMpgOSytnCCWuw@mail.gmail.com>
 <20251030105318.GK4067720@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251030105318.GK4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/30/25 3:53 AM, Peter Zijlstra wrote:
> On Wed, Oct 29, 2025 at 06:13:21PM -0700, Alexei Starovoitov wrote:
>> On Wed, Oct 29, 2025 at 11:37 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> With latest bpf/bpf-next tree and latest pahole master, I got the following
>>> build failure:
>>>
>>>    $ make LLVM=1 -j
>>>      ...
>>>      LD      vmlinux.o
>>>      GEN     .vmlinux.objs
>>>      ...
>>>      BTF     .tmp_vmlinux1.btf.o
>>>      ...
>>>      AS      .tmp_vmlinux2.kallsyms.o
>>>      LD      vmlinux.unstripped
>>>      BTFIDS  vmlinux.unstripped
>>>    WARN: resolve_btfids: unresolved symbol migrate_enable
>>>    WARN: resolve_btfids: unresolved symbol migrate_disable
>>>    make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>>>    make[2]: *** Deleting file 'vmlinux.unstripped'
>>>    make[1]: *** [/home/yhs/work/bpf-next/Makefile:1242: vmlinux] Error 2
>>>    make: *** [/home/yhs/work/bpf-next/Makefile:248: __sub-make] Error 2
>>>
>>> In pahole patch [1], if two functions having identical names but different
>>> addresses, then this function name is considered ambiguous and later on
>>> this function will not be added to vmlinux/module BTF.
>>>
>>> Commit 378b7708194f ("sched: Make migrate_{en,dis}able() inline") changed
>>> original global funcitons migrate_{enable,disable} to
>>>    - in kernel/sched/core.c, migrate_{enable,disable} are global funcitons.
>>>    - in other places, migrate_{enable,disable} may survive as static functions
>>>      since they are marked as 'inline' in include/linux/sched.h and the
>>>      'inline' attribute does not garantee inlining.
>>>
>>> If I build with clang compiler (make LLVM=1 -j) (llvm21 and llvm22), I found
>>> there are four symbols for migrate_{enable,disable} respectively, three
>>> static functions and one global function. With the above pahole patch [1],
>>> migrate_{enable,disable} are not in vmlinux BTF and this will cause
>>> later resolve_btfids failure.
>>>
>>> Making migrate_{enable,disable} always inline in include/linux/sched.h
>>> can fix the problem.
>>>
>>>    [1] https://lore.kernel.org/dwarves/79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com/
>>>
>>> Fixes: 378b7708194f ("sched: Make migrate_{en,dis}able() inline")
>>> Cc: Menglong Dong <menglong8.dong@gmail.com>
>>> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   include/linux/sched.h | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>> index cbb7340c5866..b469878de25c 100644
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -2407,12 +2407,12 @@ static inline void __migrate_enable(void) { }
>>>    * be defined in kernel/sched/core.c.
>>>    */
>>>   #ifndef INSTANTIATE_EXPORTED_MIGRATE_DISABLE
>>> -static inline void migrate_disable(void)
>>> +static __always_inline void migrate_disable(void)
>>>   {
>>>          __migrate_disable();
>>>   }
>>>
>>> -static inline void migrate_enable(void)
>>> +static __always_inline void migrate_enable(void)
>>>   {
>>>          __migrate_enable();
>>>   }
>> Peter,
>>
>> Are you ok if we take this?
> Yes, but WTH would clang not inline this trivial function to begin with?

I checked asm codes with migrate_disable(). In the above cases, 
__migrate_disable() is inlined and the function body of 
migrate_disable() then becomes reasonably big. The caller of 
migrate_disable() are ring_buffer_resize()*/*range_tree_set()/... which 
are pretty big too.


