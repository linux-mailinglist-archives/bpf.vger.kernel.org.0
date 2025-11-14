Return-Path: <bpf+bounces-74594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 575EEC5F8F3
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F4C1345B54
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B6130596B;
	Fri, 14 Nov 2025 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaH5msNO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0B1B983F;
	Fri, 14 Nov 2025 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763161578; cv=none; b=Rrt3k+yImfB+/Q5A/+ijTvUNZAfN76utBzmF0XVYzecLbob6bkZ9hV4MduW0789QOPhVhV7H2RrD9jI/i4JBaGrU0v+Ia1LllrgJB5mUTVvvMUwP1hNQh6DiQs5S9HEq3oZ0EkNdzN/UxPDtP3lgBdVqbP10jt4ysX/6xQXdrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763161578; c=relaxed/simple;
	bh=hEDuyAiDrTdxoKB/4W6+M34yHjsrvyXle5Kktqo/mUk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TckwOk8dk+FayVoRGbgoS0Ojhdgt8DShrirPTJR9gS5bC+5iIKBUfn0y6ryDB733mMMMDX/eLZcc8U1N0m9LGmzSueH1J8UKs2ojbwn+FBwtO6UwFdcBpkE8EpgpnDAUQMrq7Invx8ZoIh8jf5S44w6NHqlaX1rcXqRz5OHrWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaH5msNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27069C4CEF5;
	Fri, 14 Nov 2025 23:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763161577;
	bh=hEDuyAiDrTdxoKB/4W6+M34yHjsrvyXle5Kktqo/mUk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TaH5msNOFGWjM7rudpfM8YVoBYFENvZwNzHNUBEAgzRowD0QwbKsT6jH02FAaBEM1
	 YIqY2U9DqUGbUj1Oy0I3o3LqQ7JLrmdQpeBSFUnH+JNYcyk8OFsMwrIvjL/sIFxQsx
	 uhyVhZp9mpy/KOVzKQM3jFxr+smazKlPP65IGjdqfupkwKQxsL85WAtPKaBWIXdhnG
	 bFMZ1JSMcHw9LWYEvl0Lh6n00eMd8NJuvkJLNanMzH1i+HdPBVnAx7S7LlPOZ5xGzC
	 ONnG5JB57RWsJzAHDXOS8V6FK90nRiiRxu1+5hs2/chCIPI0D7NN5oKYF2451TILf7
	 RM2o9UUAmTMow==
Content-Type: multipart/mixed; boundary="===============8752093551188557916=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ea0d6de3aa0a0370e1ac7328db2b09ead3f8ce1effa9a04f37fb09e1f87a5643@mail.kernel.org>
In-Reply-To: <20251114221741.317631-2-ameryhung@gmail.com>
References: <20251114221741.317631-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/6] bpf: Allow verifier to fixup kernel module kfuncs
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,tj@kernel.org,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 23:06:17 +0000 (UTC)

--===============8752093551188557916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 99d62d765..d7702b9c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22416,8 +22416,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>
>  	if (!bpf_jit_supports_far_kfunc_call())
>  		insn->imm = BPF_CALL_IMM(desc->addr);
> -	if (insn->off)
> -		return 0;
> +

Are the special kfunc comparisons below safe for module kfuncs?

The code after this change compares desc->func_id against
special_kfunc_list[] entries without checking desc->offset. Since
special_kfunc_list[] contains BTF IDs from kernel BTF, and module kfuncs
have BTF IDs from their own module BTF, could a module kfunc with a BTF
ID that happens to match a special kernel kfunc ID be incorrectly
processed?

In fixup_kfunc_call():
  desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
  [...]
  if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] || ...)

The desc->func_id contains a BTF-local ID (set at line 3373), while
special_kfunc_list[] contains kernel BTF IDs. Module BTF IDs start from
1 independently, so collision is architecturally possible.

During verification, check_special_kfunc() at line 13691 checks "if
(meta->btf != btf_vmlinux) return 0;" which prevents aux_data fields
like kptr_struct_meta from being set for module kfuncs. But at fixup
time, if a module kfunc's BTF ID collides with a special kernel kfunc
ID, won't it enter these paths and read uninitialized aux_data fields?

Would adding "desc->offset == 0 &&" or "insn->off == 0 &&" to the
comparisons at lines 22420, 22437, 22460, 22481 ensure we only match
kernel kfuncs?

>  	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
>  	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19379369447

--===============8752093551188557916==--

