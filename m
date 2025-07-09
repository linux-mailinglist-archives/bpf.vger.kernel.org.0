Return-Path: <bpf+bounces-62864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BACAFF589
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39EE54677C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023123B637;
	Wed,  9 Jul 2025 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gUEgfUOc"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8B15A8
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752105462; cv=none; b=X3M17ujmM0kOAzftDpMFOUr0yRp2BKgFpwafIo9o4XBSNxF0FdGRtpaB/O/U7ZQbQslcARTKLcnfZRXgpTzwCx65QF7kpuhpPF7bqV4FtVI3XvNlhjo7IYXNUVhIphtKFyArUS3GVUHKIpw1rsm2UndnsCjOPwalDLLmyrrHWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752105462; c=relaxed/simple;
	bh=dSn0wvcg+OQmbOHbx5umlc80DGFFeYUp+IlUEH0+FcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFugsp/tMbOSKcys/1fPLgLc26eJ7GRHLop8EyE1jjfQfBImaxFZM+d22Uf/kV86Rv3bgoftQtPuwioReZycMY5VxcyFMFOvKClmei/HS3gbyQDD4w+ApJDcCrKVz4B2MFG/sK/wDr7+mnp5t525BE6knY6Qn9XsljCZ3+wq4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gUEgfUOc; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba1b52e3-a938-4ead-943c-267e4c06b1ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752105455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JoUjeXKOHFNcyI8FSDsJmLGJOueZBWmnwkw7FuzBik=;
	b=gUEgfUOcJBBx2pUeTTRh8qWy8OTlTkCpsqNgpU/OwYUjB0CfPq8n7JVsPPR/cUue/oHE2T
	ZlwMTDhwCJNHklnkXVlQ6JzlDmbyv3gl6eNOK2L1fWtVdoosyS54SrXNSsUi6sphG4d+OY
	tvxN4+XJWAI3Zl/ZdnlVMjDajT9f2rA=
Date: Wed, 9 Jul 2025 16:57:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Forget ranges when refining tnum after
 JSET
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
References: <75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/9/25 3:26 PM, Paul Chaignon wrote:
> Syzbot reported a kernel warning due to a range invariant violation on
> the following BPF program.
>
>    0: call bpf_get_netns_cookie
>    1: if r0 == 0 goto <exit>
>    2: if r0 & Oxffffffff goto <exit>
>
> The issue is on the path where we fall through both jumps.
>
> That path is unreachable at runtime: after insn 1, we know r0 != 0, but
> with the sign extension on the jset, we would only fallthrough insn 2
> if r0 == 0. Unfortunately, is_branch_taken() isn't currently able to
> figure this out, so the verifier walks all branches. The verifier then
> refines the register bounds using the second condition and we end
> up with inconsistent bounds on this unreachable path:
>
>    1: if r0 == 0 goto <exit>
>      r0: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0xffffffffffffffff)
>    2: if r0 & 0xffffffff goto <exit>
>      r0 before reg_bounds_sync: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0)
>      r0 after reg_bounds_sync:  u64=[0x1, 0] var_off=(0, 0)
>
> Improving the range refinement for JSET to cover all cases is tricky. We
> also don't expect many users to rely on JSET given LLVM doesn't generate
> those instructions. So instead of reducing false positives due to JSETs,
> Eduard suggested we forget the ranges whenever we're narrowing tnums
> after a JSET. This patch implements that approach.
>
> Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>   kernel/bpf/verifier.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53007182b46b..e2fcea860755 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16208,6 +16208,10 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>   		if (!is_reg_const(reg2, is_jmp32))
>   			break;
>   		val = reg_const_value(reg2, is_jmp32);
> +		/* Forget the ranges before narrowing tnums, to avoid invariant
> +		 * violations if we're on a dead branch.
> +		 */
> +		__mark_reg_unbounded(reg1);
>   		if (is_jmp32) {
>   			t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
>   			reg1->var_off = tnum_with_subreg(reg1->var_off, t);

The CI reports some invariant violation:
   https://github.com/kernel-patches/bpf/actions/runs/16182458904/job/45681940946?pr=9283

[ 283.030177] ------------[ cut here ]------------ [ 283.030517] 
verifier bug: REG INVARIANTS VIOLATION (false_reg2): range bounds 
violation u64=[0x8000000000000010, 0x800000000000000f] 
s64=[0x8000000000000010, 0x800000000000000f] u32=[0x10, 0xf] s32=[0x10, 
0xf] var_off=(0x8000000000000000, 0x1f)(1)
[ 283.032139] WARNING: CPU: 0 PID: 103 at kernel/bpf/verifier.c:2689 
reg_bounds_sanity_check+0x1dd/0x1f0 ... Probably this change triggered 
some other violations. Please take a look.


