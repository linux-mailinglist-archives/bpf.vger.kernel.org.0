Return-Path: <bpf+bounces-64750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7CDB1692D
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F183B18C73BB
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 23:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F22264D3;
	Wed, 30 Jul 2025 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQF2hJ7s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C1156678;
	Wed, 30 Jul 2025 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916533; cv=none; b=E1SSDc3lhYkCvjppIl+gKSlWDEaFfXSyr4GwlapY60snSvotxqmhySQ+HFUXutm8Vs9XpxFSbabp+84VNnb6OoeuCKt3nKGLEJDWcyvmj6G2cg4tM7cBtBRAG4OSnQwE6IU4zGT8QTpD9fGKN/94i7dDU+SaU+InwTobxscA+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916533; c=relaxed/simple;
	bh=10+Qm5+XBos4qcIIKiIdcMPoPp8hRP0zHbhFwida9CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyLmrsfL7oRNz7qxgh+QWFhEQWftaVUnLuuxWLLlGNOJROXqMf8yx+whkgWWTRJT5Ewu81BUlya9bwpvAxzcWobeAxOK5RdMu5Wa4BUhSkUikfTDz28mCMi0+KiGBRwoNBHdBv3irByJEUSZCPwKrYsV1qZKvsPAyn7Wt2QVWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQF2hJ7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5066C4CEE3;
	Wed, 30 Jul 2025 23:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753916532;
	bh=10+Qm5+XBos4qcIIKiIdcMPoPp8hRP0zHbhFwida9CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQF2hJ7sjoSIL2i0JKeLhwTwlIhaILqfp9agIN71m8zeJr0umNcZdzBxKOYMlK9jJ
	 YKq4E85TD0kVHxgx9fBwfRx6/iqhbxlgDm+rfyblCylPh6gRpRYgnAq2A8LqeV07Qn
	 a3x8GFnWB/l+SnUhJX8ATBz6r/Ihk0JxbiOT7a68V+jOqrTN32aAIGniy598SA4975
	 rhs4Et47vum0IbseVM+xngja/MyihJfOQ0C+1gvv2x9bHFCxzGi7b454y4ruRyz4Uy
	 yTGc2KV6pYFvns/1VoERoLjzD5WFhOkvYvl520bcdisWgXVMtmHcgMvQleNeE92bQ3
	 fKD6lVtOBIwpg==
Date: Wed, 30 Jul 2025 16:02:12 -0700
From: Kees Cook <kees@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com,
	kernel-team@meta.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 08/12] bpf: Report rqspinlock
 deadlocks/timeout to BPF stderr
Message-ID: <202507301559.C832A9C@keescook>
References: <20250703204818.925464-1-memxor@gmail.com>
 <20250703204818.925464-9-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703204818.925464-9-memxor@gmail.com>

On Thu, Jul 03, 2025 at 01:48:14PM -0700, Kumar Kartikeya Dwivedi wrote:
> +static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bool irqsave)
> +{
> +	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> +	struct bpf_stream_stage ss;
> +	struct bpf_prog *prog;
> +
> +	prog = bpf_prog_find_from_stack();
> +	if (!prog)
> +		return;
> +	bpf_stream_stage(ss, prog, BPF_STDERR, ({
> +		bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
> +		bpf_stream_printk(ss, "Attempted lock   = 0x%px\n", lock);
> +		bpf_stream_printk(ss, "Total held locks = %d\n", rqh->cnt);
> +		for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
> +			bpf_stream_printk(ss, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
> +		bpf_stream_dump_stack(ss);

Please don't include %px in stuff going back to userspace in standard
error reporting. That's a kernel address leak:
https://docs.kernel.org/process/deprecated.html#p-format-specifier

I don't see any justification here, please remove the lock address or
use regular %p to get a hashed value.

-- 
Kees Cook

