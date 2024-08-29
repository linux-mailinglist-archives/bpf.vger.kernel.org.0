Return-Path: <bpf+bounces-38413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02954964A20
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE871F23A86
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6352A4084E;
	Thu, 29 Aug 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UA70EtxD"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B284643B
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945600; cv=none; b=cQTUQ1VGPk2d1nQFbMGefDavD2d9wH+TIBEaWnp81H1YaiEjMWwt2us+5Y7vH6BSIKy3ZtJNXVW3c7owr5V0Yk3SWUv3ur7SqLAO1Sp9/pUx4StMWYjh0mm1m6H0wjF5EziHFf0r2jzqiruRChILuGAPLSMGyufJhniX8GQFuVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945600; c=relaxed/simple;
	bh=PK+9eH9ffaXSJ2PtZ02NfDUuvv60KXOq0lQgG85idao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nxf2v3ZMsz4xChkjqQrS8SuHLu71h7+HCrxtd6/6lrC++Gjs/zmiMzTwWtvLv23uGnoi3Q870Mx4Zuyj6dKwVqbBdvu4GQAGNxUQMO9ccrLwxAgF4WbvQqbtjFScuDFGCmopVabExO10LjJsSrYw1bmvuX1Q8eLfqpY/kFiownE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UA70EtxD; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <502fa523-2901-4271-9c89-f8c47e124055@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724945593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7iRS58yMk+jHRGDLgT6MgLCwKyqNScc9IEGFBv7k1E=;
	b=UA70EtxDWBR8qBni3k70mdQQtcEe3XL8q5fGiYcpMR12Ifnd3P9+Hjvh/qge4XPgcAW20b
	Pxo71CHfHEQM0l8eIZAU3Dz/PF+k+N6UocMVFcWBPGMyCgQBS+f6rrVkJbp4pvyDQy8c1m
	X12nG+/6+7hUSUG28juC94u3FkB1LuM=
Date: Thu, 29 Aug 2024 08:33:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 1/9] bpf: Move insn_buf[16] to
 bpf_verifier_env
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 Kernel Team <kernel-team@meta.com>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827194834.1423815-2-martin.lau@linux.dev>
 <9bcfc97f011f4b4d5dc312e26074d0c1d744af02.camel@gmail.com>
 <CAADnVQKfuWjpDxL=0OYMe_u37tTpPgPUW3-5L7X-QVUGh5x1gw@mail.gmail.com>
 <bff92d52-344e-46bf-ac0c-f03e1b22d22b@linux.dev>
 <CAADnVQ+jBwKQGR3LpRwZJT0G7pB+Xzf+L0gJkZdjL7UTrZeg_Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQ+jBwKQGR3LpRwZJT0G7pB+Xzf+L0gJkZdjL7UTrZeg_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/29/24 8:26 AM, Alexei Starovoitov wrote:
> On Thu, Aug 29, 2024 at 8:20 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 8/28/24 6:46 PM, Alexei Starovoitov wrote:
>>> On Wed, Aug 28, 2024 at 5:41 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>
>>>> On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
>>>>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>>>>
>>>>> This patch moves the 'struct bpf_insn insn_buf[16]' stack usage
>>>>> to the bpf_verifier_env. A '#define INSN_BUF_SIZE 16' is also added
>>>>> to replace the ARRAY_SIZE(insn_buf) usages.
>>>>>
>>>>> Both convert_ctx_accesses() and do_misc_fixup() are changed
>>>>> to use the env->insn_buf.
>>>>>
>>>>> It is a prep work for adding the epilogue_buf[16] in a later patch.
>>>>>
>>>>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>>>>> ---
>>>>
>>>> Not sure if this refactoring is worth it but code looks correct.
>>>> Note that there is also inline_bpf_loop()
>>>> (it needs a slightly bigger buffer).
>>>
>>> Probably worth it in the follow up, since people complain that

I read it and Eduard's earlier comment together as the whole patch 1 as a follow 
up. :)

yep. I will keep this one and follow up with the insn_buf in the inline_bpf_loop().

I will update the commit message with the stack usage in the next respin.

>>> this or that function in verifier.c reaches stack size limit
>>> when compiled with sanitizers.
>>> These buffers on stack are the biggest consumers.
>>
>> ok. I will drop this patch for now. Redo it again as a followup and will
>> consider inline_bpf_loop() together at that time.
> 
> why? Keep it. It's an improvement already.



