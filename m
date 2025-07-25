Return-Path: <bpf+bounces-64385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382B8B1225E
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8973172AAA
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3B2EF2B7;
	Fri, 25 Jul 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PlnIlURi"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854012EF2BE
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462489; cv=none; b=kzzaek8qPx6wVMF6zYXeOWQOi9sKFqQaSj3lGezAKpOYWMR+mBw3WrwAlbiAO2KibRPXwjMGE8V0ags+O+Y8UF0pW+m8fPqvEghj3lw98eqBG3OHXBYbMYCk40uKRUBGTJvh/RJEA58RIGPkOliBWvpq6jg5aPjwOsvNpSMeQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462489; c=relaxed/simple;
	bh=yWFdsW8nIY9vjP9SUMvRtjs0qZhk/YnNMPCKHTzwGuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpOw/MdAc/odU/nm2QLYUOp71IoYfxgYYYHZxmN04G2THM+33+hm7DDDKMBsfV6xI+EVpf5xl2NDG6ouHk1Rt4knmmWyc3jtEu+EyTV33nsWj8pTXzlHkEjuguB9JYczB8bi5atY0RskFTIHw/3bty6XHpgN7S67DShEW8FJT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PlnIlURi; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f82341df-bf2a-4913-a58c-e0acdfb245d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753462475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUzItPFAYG6DXH6G2RYS1Q8z+uDV9jjAO+KY6thJZik=;
	b=PlnIlURiEIDoMjU/giGbhBufbLFDqrO7KRg9qRL5dmwl0LadEnqHHyCXZ4FIe/J1t7y6Pn
	LxKa9tXNS7lPlvPDTIHzeBT4IRGbL/39WLBAkOQuXNwKkSmd3w6VPHoTpuur/wnRxenkMR
	ANuvHjZvU2w1iCjtR3Fafwlkmdh4U04=
Date: Fri, 25 Jul 2025 09:54:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] Use correct destructor kfunc types
Content-Language: en-GB
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250724223225.1481960-6-samitolvanen@google.com>
 <c7241cc9-2b20-4f32-8ae2-93f40d12fc85@linux.dev>
 <CABCJKud8u_AF6=gWvvYqMeP71kWG3k88jjozEBmXpW9r4YxGKQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CABCJKud8u_AF6=gWvvYqMeP71kWG3k88jjozEBmXpW9r4YxGKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/25/25 9:22 AM, Sami Tolvanen wrote:
> Hi,
>
> On Fri, Jul 25, 2025 at 9:05 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> I tried your patch set on top of latest bpf-next. The problem
>> still exists with the following error:
>>
>> [   71.976265] CFI failure at bpf_obj_free_fields+0x298/0x620 (target: __bpf_crypto_ctx_release+0x0/0x10; expected type: 0xc1113566)
>> [   71.980134] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>> ...
>>
>>
>> The following is the CFI related config items:
>>
>> $ grep CFI .config
>> CONFIG_CFI_AUTO_DEFAULT=y
>> CONFIG_FUNCTION_PADDING_CFI=11
>> CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
>> CONFIG_ARCH_USES_CFI_TRAPS=y
>> CONFIG_CFI_CLANG=y
>> # CONFIG_CFI_ICALL_NORMALIZE_INTEGERS is not set
>> CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG=y
>> CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC=y
>> # CONFIG_CFI_PERMISSIVE is not set
>>
>> Did I miss anything?
> Interesting. I tested this on arm64 and confirmed that the issue is
> fixed there, so I wonder if we need to use KCFI_REFERENCE() here to
> make sure objtool / x86 runtime patching knows this function actually
> indirectly called. I'll test this on x86 and see what's going on.

I just tried arm64 with your patch set. CFI crash still happened:

CFI failure at tcp_ack+0xe74/0x13cc (target: bpf__tcp_congestion_ops_in_ack_event+0x0/0x78; expected type: 0x64424
87a)
Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)]
CPU: 0 UID: 0 PID: 152 Comm: test_progs Tainted: G           OE       6.16.0-rc6-g95993dc3039e-dirty #162 NONE
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: linux,dummy-virt (DT)
pstate: 33400005 (nzCV daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : tcp_ack+0xe74/0x13cc
lr : tcp_ack+0xe34/0x13cc

The arm64 CFI related config:
$ cat .config | grep CFI
CONFIG_AS_HAS_CFI_NEGATE_RA_STATE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_CFI_CLANG=y
# CONFIG_CFI_ICALL_NORMALIZE_INTEGERS is not set
CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG=y
# CONFIG_CFI_PERMISSIVE is not set

>
> Thanks for taking a look!
>
> Sami


