Return-Path: <bpf+bounces-58457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB80ABABCB
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 20:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189AD9E5C3F
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4201F2144DA;
	Sat, 17 May 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pVgoW+Ph"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD54204097
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747505649; cv=none; b=UVwBFXFnH1QnUUkEQ+NYhWg5DkTC7Ii2ZbznIqQjeiNCO58YfylSO58rSdyoro8/30SZmCkTh+JNsjwsKlXd5DNSLk9CO+xiTDOfudr80rWfzB4/zQDOh3YK51BPvn20yWQvaLLiaR6JMIDkmfsf33JbJ4VS8Nnbap8OOsfBDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747505649; c=relaxed/simple;
	bh=PASblY76/bWsj0Er7bPimPhMgaQZpZW1KZmX84PPwLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7NG68dyhtNAxuYMWPKiCbFyJq+aVntWd+LJwb2QhmXy+57MV6XGzPJWHykI2dWhbtxs08PV6tVBQgdC5DwDklISepKmpG/aRFc/gDDxDRWL6UbYHHtCzETA3a3RSeOyY2J6Lq0pA5Is84qbqiZzJkqAindOWnTHysO6YU6McLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pVgoW+Ph; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b32cd638-5ba1-4af5-80e6-3103786a7c8e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747505643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5dNnFA9yBlkgpdX/CtbhVO/p0pBG/seasbIH6EsmAs=;
	b=pVgoW+Ph+/orDYSC/Ygb9wHIbqyPQSXPS3WgP3/YA1axRds13vr2jTPikAOeoF2dcsTcnE
	kWLw6dUT2Y/9OIYORXnslEUG51jg7QBzRBkkVJd/Ow+I3/QQBczMqBqW+A02gbh3q/n3vC
	uRY1dVXEKWhIa4crpShj0nWdWbeAZDk=
Date: Sat, 17 May 2025 11:13:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Warn with new bpf_unreachable()
 kfunc maybe due to uninitialized var
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250515200635.3427478-1-yonghong.song@linux.dev>
 <CAADnVQL9A8vB-yRjnZn8bgMrfDSO17FFBtS_xOs5w-LSq+p74g@mail.gmail.com>
 <1742bbe7-7f7a-4eef-a0a9-feb2cda50bbd@linux.dev>
 <CAADnVQJurPs_e3Lx9O7qZ+=HPk7XarXoGXeTiARbw8bW+-txGA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJurPs_e3Lx9O7qZ+=HPk7XarXoGXeTiARbw8bW+-txGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/16/25 5:31 AM, Alexei Starovoitov wrote:
> On Fri, May 16, 2025 at 2:17 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> So I then decided to add an 'exit' insn after bpf_unreachable() in llvm.
>> See latest https://github.com/llvm/llvm-project/pull/131731 (commit #2).
>> So we won't have any control flow issues in code. With newer llvm change,
> That's a good idea. Certainly better than special case this 'noreturn'
> semantic in the verifier.

Current latest llvm21 will cause kernel build failure:
   https://patchew.org/linux/20250506-default-const-init-clang-v2-1-fcfb69703264@kernel.org/
I will wait for the fix in bpf-next and then submit v3.


