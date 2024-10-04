Return-Path: <bpf+bounces-40914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094598FCF9
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 07:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB10B1F21FBC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 05:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB117E574;
	Fri,  4 Oct 2024 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R5UqaS2J"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115195336B
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 05:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019380; cv=none; b=a+9/DjqXroc1VWNfJdcBP4bWtoPoRpvJMSPUt23wwkIAjRAMncru92mA0IgvVMGCFcEqJ+BqUHyDGxLgGaAn7aFQDOWv7NiWfniaegWZ452bl/IuVAfZJ1coCmVArjWNhEeGdrxyd2Z843XguWoGZfHHCwgIc6fw1ptTc/LQdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019380; c=relaxed/simple;
	bh=h2KOwXGuTl8YL616M034HB2Af84RJl0wNEM+e6ELGpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UX+hQkThEUK00mtBY2cMMVXlDCbEd4OhWJdEDrQxbhSiO58ayXEJfXi3Reu+NOZN6lcMbPFFA2psywlrdn6ZiQV1LArtx+sEeekcnLodJY/OcChGEI7iYBqtE8qM8KNdAryrXmEfiN2BE09BhenP59WheWq78L1zHUTymgq9BAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R5UqaS2J; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d8ff2878-c53b-48d7-b624-93aeb2087113@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728019375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrfQ1i8tmMnvMbKBi8z6qLedVp5+8gOVmXGH6LKyfxY=;
	b=R5UqaS2JO180imhgB488/5NX0x4SzMGXAd8rVnZf+Frak3WNNqs1WUw6ufnQyv1s3W0tB7
	kyIM71IMZ/VgkfMjP9zGoIDid0xzEiewVSeFFMlLG3B2KyMfqtlNNmA3oXV7M0UOm6rdrt
	XU5BnsFLBEXGJf2aGYTJthENB4ZAWYo=
Date: Thu, 3 Oct 2024 22:22:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
 <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
 <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
 <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
 <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev>
 <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
 <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com>
 <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev>
 <CAADnVQKO1=ywkfULmSE=15dFU4Ovn3OMVbnGpkah5noeDnwtgw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKO1=ywkfULmSE=15dFU4Ovn3OMVbnGpkah5noeDnwtgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/3/24 3:32 PM, Alexei Starovoitov wrote:
> On Thu, Oct 3, 2024 at 1:44 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> Looks like the idea needs more thought.
>>>
>>> in_task_stack() won't recognize the private stack,
>>> so it will look like stack overflow and double fault.
>>>
>>> do you have CONFIG_VMAP_STACK ?
>> Yes, my above test runs fine withCONFIG_VMAP_STACK. Let me guard private stack support with
>> CONFIG_VMAP_STACK for now. Not sure whether distributions enable
>> CONFIG_VMAP_STACK or not.
> Good! but I'm surprised it makes a difference.

That only for the test case I tried. Now I tried the whole bpf selftests
with CONFIG_VMAP_STACK on. There are still some failures. Some of them
due to stack protector. I disabled stack protector and then those stack
protector error gone. But some other errors show up like below:

[   27.186581] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[   27.187480] BUG: unable to handle page fault for address: ffff888109572800
[   27.188299] #PF: supervisor instruction fetch in kernel mode
[   27.189085] #PF: error_code(0x0011) - permissions violation

or

[   27.736844] BUG: unable to handle page fault for address: 0000000080000000
[   27.737759] #PF: supervisor instruction fetch in kernel mode
[   27.738631] #PF: error_code(0x0010) - not-present page
[   27.739455] PGD 0 P4D 0
[   27.739818] Oops: Oops: 0010 [#1] PREEMPT SMP PTI

...

Some further investigations are needed.

> Please still root cause the crash without VMAP_STACK.

Sure. Let me investigate cases with VMAP_STACK first and
then will try to look at it without VMAP_STACK.

>
> We need to do a lot more homework here before proceeding.
> Look at arch/x86/kernel/dumpstack_64.c
> At least we need new stack_type for priv stack.
> stack_type_unknown doesn't inspire confidence.
> Need to make sure stack trace is still reliable with priv stack.
> Though it may look appealing from performance pov.
> We may need to go back to r9 approach with push/pop around calls,
> since that is surely keeping unwinder happy
> while this approach will have to teach unwinder.

Good point.


