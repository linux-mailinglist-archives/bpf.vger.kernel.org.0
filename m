Return-Path: <bpf+bounces-38410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73CA9649DE
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6751F23850
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A90A1B1506;
	Thu, 29 Aug 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iJUZ7Cri"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6931487F1
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944841; cv=none; b=bftmw2b7RP1Pxv4P7/2+VGY6k4xFHH1CpS+ftK9usyc86kdjSPQm75+4fMnLsIxe537BMUARVAAp4UGec/UTZYi6hCZF71hMS4Lc7ajk4mkve9HDkB2vSGdtWH8vMwZw9Lz8zBs4AQCaA1coIZu1tx8woZQuA+fYGKnnLdGFrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944841; c=relaxed/simple;
	bh=bZnIzJBi+cRZ7HrXxs4vgBsO/fZGrGw8GK0IjbcdiQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiP2kN9N4nPtBKxWAeQSAwlbEjFo/IYkBTQibFLLzA32EOllaaO4MiNHFuQn4XrHS2zMDtQOnCBVrh1ADRWQuwHvX/ir7ez6KBzVUIOUqB5JM88EjykNa844RNFajgMBnWx1QezzVrsr5tR6O0AHIUMCbNUZ6K+WHMKSQd/m/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iJUZ7Cri; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bff92d52-344e-46bf-ac0c-f03e1b22d22b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724944838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iykTAGh2dNQJXG1tOpdsNmtpY5Q3OpaIT3Q7TtjXHZw=;
	b=iJUZ7Cri76pztNhr77Dm5oqaThgspeiS6q0oN7UuS+3SQNf8o6aoV20NiraZpv5Y9QxzeZ
	maZB6KPwYUdleFwxYTlncFcnR0fDseKg6uZWaclkc85q5xqN906zTlgt70ceykj9wLnSnG
	3vsQPD2BplZyCDezo8krQvtjA2ReXw8=
Date: Thu, 29 Aug 2024 08:20:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 1/9] bpf: Move insn_buf[16] to
 bpf_verifier_env
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 Kernel Team <kernel-team@meta.com>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827194834.1423815-2-martin.lau@linux.dev>
 <9bcfc97f011f4b4d5dc312e26074d0c1d744af02.camel@gmail.com>
 <CAADnVQKfuWjpDxL=0OYMe_u37tTpPgPUW3-5L7X-QVUGh5x1gw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQKfuWjpDxL=0OYMe_u37tTpPgPUW3-5L7X-QVUGh5x1gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/28/24 6:46 PM, Alexei Starovoitov wrote:
> On Wed, Aug 28, 2024 at 5:41 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
>>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>>
>>> This patch moves the 'struct bpf_insn insn_buf[16]' stack usage
>>> to the bpf_verifier_env. A '#define INSN_BUF_SIZE 16' is also added
>>> to replace the ARRAY_SIZE(insn_buf) usages.
>>>
>>> Both convert_ctx_accesses() and do_misc_fixup() are changed
>>> to use the env->insn_buf.
>>>
>>> It is a prep work for adding the epilogue_buf[16] in a later patch.
>>>
>>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>>> ---
>>
>> Not sure if this refactoring is worth it but code looks correct.
>> Note that there is also inline_bpf_loop()
>> (it needs a slightly bigger buffer).
> 
> Probably worth it in the follow up, since people complain that
> this or that function in verifier.c reaches stack size limit
> when compiled with sanitizers.
> These buffers on stack are the biggest consumers.

ok. I will drop this patch for now. Redo it again as a followup and will 
consider inline_bpf_loop() together at that time.

Regarding the stack size, I did notice the compilation warning difference on the 
stack size which I should have put in the commit message.

Before:
./kernel/bpf/verifier.c:22133:5: warning: stack frame size (2584) exceeds limit 
(2048) in 'bpf_check' [-Wframe-larger-than]

After:
./kernel/bpf/verifier.c:22184:5: warning: stack frame size (2264) exceeds limit 
(2048) in 'bpf_check' [-Wframe-larger-than]


