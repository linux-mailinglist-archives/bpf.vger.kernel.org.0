Return-Path: <bpf+bounces-36928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C294F6C9
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520622836C7
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F8A18C337;
	Mon, 12 Aug 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AIEM6wo9"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147B18951F
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487822; cv=none; b=b+SapUFQIxc9l4JulzxlGRInbIV57PMbYona6zKyL6AkJbVqGeeCjQC/ekM3rM9+ddYhQS8ORTtNNrgk95+/FzT407Sg47C1ibsUJFyhpKd7tHhezyQKB2W7XVMgIrGWNfRRC3JYE5W7JN0H46xiBCvr2aa4rDeA/2y8b/ATcG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487822; c=relaxed/simple;
	bh=EJuCwN31mt72hSiCdAfYA4+PGAvbv9uy9DMHY/13eVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ma2u39Qhx1+UofZ6ZZpFgywpa1hVHM+nOgzMdJ17XgRe+mVz2cknTYpcGJ6skDd3sTlUtVr8t3/oXV0u/eEOpNei4cMxOBKY2rt+VId/7IpUaSaRrolfPWtGoPzwLKmXxURljCUI6sEfuhCSjenc9NKmpfRQBkkuCP8ZWf9tyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AIEM6wo9; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69654617-c97e-48cb-8317-15567a46365a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723487818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7+LVe2hwU0i0an7bBhTAxRpIHuK9h2T7ibAPxRHauw=;
	b=AIEM6wo95DSwXgxLtbhB5wtZoWcx5Tr5db9E71opfS/OuxyKq1sf2GxtOjtC0upT0a7aUc
	FyeVDiTsv6zwtCgUAZRsralW35JDXytLL4iP8T3JuHfZh3j1m1V0xmbDzedR4jd6lvbTQ/
	dmml3MPTC6kLiUMlzAhznorhWCMC7eA=
Date: Mon, 12 Aug 2024 11:36:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Hodges <hodgesd@meta.com>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
 <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
 <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
 <a4af06f9-5ea7-4541-90fd-1241043d5659@linux.dev>
 <0b305ca5045a1adceec313b20f912f9666c1705c.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0b305ca5045a1adceec313b20f912f9666c1705c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/12/24 11:30 AM, Eduard Zingerman wrote:
> On Mon, 2024-08-12 at 11:26 -0700, Yonghong Song wrote:
>
> [...]
>
>> We could do the following to avoid double comparison: diff --git
>> a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c index
>> df3be12096cf..1906798f1a3d 100644 --- a/kernel/bpf/verifier.c +++
>> b/kernel/bpf/verifier.c @@ -17338,10 +17338,13 @@ static bool
>> stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old, */
>> for (i = 0; i < old->allocated_stack; i++) { struct bpf_reg_state
>> *old_reg, *cur_reg; + bool cur_exceed_bound; spi = i / BPF_REG_SIZE; -
>> if (exact != NOT_EXACT && + cur_exceed_bound = i >=
>> cur->allocated_stack; + + if (exact != NOT_EXACT && !cur_exceed_bound &&
>> old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
>> cur->stack[spi].slot_type[i % BPF_REG_SIZE]) return false; @@ -17363,7
>> +17366,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct
>> bpf_func_state *old, /* explored stack has more populated slots than
>> current stack * and these slots were used */ - if (i >=
>> cur->allocated_stack) + if (cur_exceed_bound) return false; /* 64-bit
>> scalar spill vs all slots MISC and vice versa. WDYT?
>>
> Yonghong, something went wrong with formatting of the above email,
> could you please resend?

Sorry, I copy-paste from 'git diff' result to my email window. Not sure
why it caused the format issue after I sent out. Anyway, the following
is the patch I suggested:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3be12096cf..1906798f1a3d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17338,10 +17338,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
          */
         for (i = 0; i < old->allocated_stack; i++) {
                 struct bpf_reg_state *old_reg, *cur_reg;
+               bool cur_exceed_bound;
  
                 spi = i / BPF_REG_SIZE;
  
-               if (exact != NOT_EXACT &&
+               cur_exceed_bound = i >= cur->allocated_stack;
+
+               if (exact != NOT_EXACT && !cur_exceed_bound &&
                     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
                     cur->stack[spi].slot_type[i % BPF_REG_SIZE])
                         return false;
@@ -17363,7 +17366,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
                 /* explored stack has more populated slots than current stack
                  * and these slots were used
                  */
-               if (i >= cur->allocated_stack)
+               if (cur_exceed_bound)
                         return false;
  
                 /* 64-bit scalar spill vs all slots MISC and vice versa.


