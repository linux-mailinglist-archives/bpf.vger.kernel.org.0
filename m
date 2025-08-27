Return-Path: <bpf+bounces-66734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86677B38DF4
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1A91897DAD
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550C231E0EA;
	Wed, 27 Aug 2025 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SIIzS/BM"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E8235CEDE
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332658; cv=none; b=NW+n3NJonhxJKjZtFzm3uB5N4nwQmEJb9il/GLPrZGCr3m+nnrsQr/ncTMnLCQN0kBqN0eQLzg7L9qQ3QcoA6ZsqCMSKLp+CBGpfCHyj1ikiY5vTQIs/24JpzHsytcd9XABJ0dGRsN0jUCQRLLM1Tg0dFD6vzF/GNJauimM+k60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332658; c=relaxed/simple;
	bh=evoc7gdcyPrc/Ie0TDe1eAiLfXUiEcTzOigU5YfvG/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyhFTQU5KW226yKjSRNGgQi1IoMwKF+ykTy7q5HFsLrqTHvkNbF3vX55gUlidIG+Cvx565tnHWxcBvDUJ0bStTXLCMbaIq8HgTnUpefzScwOEB7LEbF+3kpdJh5JvEKB+505bWZ1A3w1LPGYDnwbaZa9nUSoGom0KN83i4ieeV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SIIzS/BM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4690bebe-0ff6-4258-9cab-3dfe2d00fa15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756332653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0Gx8ALySI3X0w8oV2nNtG9pan3UPn8x700zl5Yl6lU=;
	b=SIIzS/BMkEut1Feu7PLceeGygEs6Ca7bvqaaLt6e/2CNGE6YSz3bjFenXPV9sFhAW3xwxG
	oDKcsZSSsOWr0VELv5RkdSQxBMhGujuD+wcJlFHm7F5Nbi739NO7L5VBlTeHmgTX2ar0A7
	lKcGiJ4VYM5HvoUBVZJDbxOgB5cxNEY=
Date: Wed, 27 Aug 2025 15:10:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, alan.maguire@oracle.com
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822140553.46273-1-arighi@nvidia.com>
 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
 <a3dabb42-efb5-4aea-8bf8-b3d5ae26dfa1@linux.dev>
 <a7bcc333d54501d544821b5feeb82588d3bc06cb.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a7bcc333d54501d544821b5feeb82588d3bc06cb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/27/25 12:13 PM, Eduard Zingerman wrote:
> On Wed, 2025-08-27 at 10:00 -0700, Yonghong Song wrote:
>> On 8/26/25 10:02 PM, Eduard Zingerman wrote:
>>> On Tue, 2025-08-26 at 13:17 -0700, Yonghong Song wrote:
>>>
>>> [...]
>>>
>>>> I tried with gcc14 and can reproduced the issue described in the above.
>>>> I build the kernel like below with gcc14
>>>>      make KCFLAGS='-O3' -j
>>>> and get the following build error
>>>>      WARN: resolve_btfids: unresolved symbol bpf_strnchr
>>>>      make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:91: vmlinux] Error 255
>>>>      make[2]: *** Deleting file 'vmlinux'
>>>> Checking the symbol table:
>>>>       22276: ffffffff81b15260   249 FUNC    LOCAL  DEFAULT    1 bpf_strnchr.cons[...]
>>>>      235128: ffffffff81b1f540   296 FUNC    GLOBAL DEFAULT    1 bpf_strnchr
>>>> and the disasm code:
>>>>      bpf_strnchr:
>>>>        ...
>>>>
>>>>      bpf_strchr:
>>>>        ...
>>>>        bpf_strnchr.constprop.0
>>>>        ...
>>>>
>>>> So in symbol table, we have both bpf_strnchr.constprop.0 and bpf_strnchr.
>>>> For such case, pahole will skip func bpf_strnchr hence the above resolve_btfids
>>>> failure.
>>>>
>>>> The solution in this patch can indeed resolve this issue.
>>> It looks like instead of adding __noclone there is an option to
>>> improve pahole's filtering of ambiguous functions.
>>> Abstractly, there is nothing wrong with having a clone of a global
>>> function that has undergone additional optimizations. As long as the
>>> original symbol exists, everything should be fine.
>> Right. The generated code itself is totally fine. The problem is
>> currently pahole will filter out bpf_strnchr since in the symbol table
>> having both bpf_strnchr and bpf_strnchr.constprop.0. It there is
>> no explicit dwarf-level signature in dwarf for bpf_strnchr.constprop.0.
>> (For this particular .constprop.0 case, it is possible to derive the
>>    signature. but it will be hard for other suffixes like .isra).
>> The current pahole will have strip out suffixes so the function
>> name is 'bpf_strnchr' which covers bpf_strnchr and bpf_strnchr.constprop.0.
>> Since two underlying signature is different, the 'bpf_strnchr'
>> will be filtered out.
> Yes, I understand the mechanics. My question is: is it really
> necessary for pahole to go through this process?
>
> It sees two functions: 'bpf_strnchr', 'bpf_strnchr.constprop.0',
> first global, second local, first with DWARF signature, second w/o
> DWARF signature. So, why conflating the two?

In this particular case, I think what you describe the correct.
For *Global* symbol 'bpf_strnchr', the signature should be in
the dwarf. But for *Local* symbol 'bpf_strnchr.constprop.0', the
signature is not clear. I suspect that pahole may not
distinguish between *Global* and *Local* symbols where they have
the same prefix.

The case like this patch to have a clone for a kfunc global
func should be very rare. That is another reason I think
__noclone should be good enough and it can reduce the
complexity in pahole. But I will be okay as well if the
consensus is to implement the support in pahole.

>
> For non-lto build the function being global guarantees signature
> correctness, and below you confirm that it is the case for lto builds
> as well. So, it looks like we are just loosing 'bpf_strnchr' for no
> good reason.
>
>> I am actually working to improve such cases in llvm to address
>> like foo() and foo.<...>() functions and they will have their
>> own respective functions. We will discuss with gcc folks
>> about how to implement similar approaches in gcc.
>>
>>> Since kfuncs are global, this should guarantee that the compiler does not
>>> change their signature, correct? Does this also hold for LTO builds?
>> Yes, the original signature will not changed. This holds for LTO build
>> and global variables/functions will not be renamed.
>>
>>> If so, when pahole sees a set of symbols like [foo, foo.1, foo.2, ...],
>> The compiler needs to emit the signature in dwarf for foo.1, foo.2, etc. and this
>> is something I am working on.
>>
>>> with 'foo' being global and the rest local, then there is no real need
>>> to filter out 'foo'.
>> I think the current __noclone approach is okay as the full implementation
>> for signature changes (foo, foo.1, ...) might takes a while for both llvm
>> and gcc.
>>
>>> Wdyt?
>>>
>>> [...]


