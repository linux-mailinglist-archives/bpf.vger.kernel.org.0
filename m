Return-Path: <bpf+bounces-76004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E56CA2020
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 00:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFB7301A1DC
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5108E2F0686;
	Wed,  3 Dec 2025 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Irj3TlIt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4C186E40;
	Wed,  3 Dec 2025 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806263; cv=none; b=EHYWAF/zcLLJ5S6twBmAuMB4X7LOtTacYAy+bZrSCl3cemvwjmmCFjGtRXeM0zDH5miZ4mE/elmQjSxj9d6dymlcaBiuLNrgKUY7y2J8IPmW13OW3UMKG2gokdhzCMnlMslaDWV/MK9f4Dps3FJZz1Fv+BimKKQ3wvrneVV8rBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806263; c=relaxed/simple;
	bh=/5qfMQO53L6uBBFKCLTsSpKNvGGLjyAbYIkOjAsY+Gk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nLAuUtP3KuGgCC5DjefF1xBO+jvffVN3dEpBFuC7ImuwBZsQzo6R3OKv1v4q3aCWEcZokkSdHwN8BP1qPCzHzDyW47YOzMHunjqtu3sBnK4ODG40mJa87mXLiJspYUBKghwFW7P/Ez1ixsRFASOQqJpEEcYOEyCTP4ymttSQDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Irj3TlIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328F2C4CEF5;
	Wed,  3 Dec 2025 23:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764806263;
	bh=/5qfMQO53L6uBBFKCLTsSpKNvGGLjyAbYIkOjAsY+Gk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Irj3TlItR4a6zHCuWfhVFsMNGSvggVivrcyl9fQCz7gC+NHn8W2OtnqmyqZkjAjjc
	 huovApSX43wBEWBiGVmipSxOWOAKvLm7n+UWHvLhq+cie1y/xQePoQvlUph84n0stv
	 IlRnfbH5NMtHShiT0aJ6z9PRC80sByjqxXwFiZUGSzWjLJ6qHQrlWrnQqLEhjxrcxq
	 JOK5eQFF5wRhpKnqmt+R1lYfMyFi/iShK565BNnKfSWJFbCq6IxEK4+4ka6GDGyk9e
	 dYhhXXaF3kdAcGW798V8HI8RxHV2aj/GGe+hBW9T58gnDHq0CiATn/RU+w6fBCVZo5
	 OO08MOm3Tn5rw==
Content-Type: multipart/mixed; boundary="===============3410881854585358566=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f7f5948f0c7e228f5c60b0fa8817185626861892c6189957e3d0219deb6035e@mail.kernel.org>
In-Reply-To: <20251203233748.668365-2-ameryhung@gmail.com>
References: <20251203233748.668365-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v8 1/6] bpf: Allow verifier to fixup kernel module kfuncs
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,tj@kernel.org,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Dec 2025 23:57:42 +0000 (UTC)

--===============3410881854585358566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f0ca69f88..bb7eca102 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22493,8 +22493,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>
>  	if (!bpf_jit_supports_far_kfunc_call())
>  		insn->imm = BPF_CALL_IMM(desc->addr);
> -	if (insn->off)
> -		return 0;
> +

Can module kfuncs incorrectly match special_kfunc_list[] entries? The
removed early return allowed module kfuncs (insn->off != 0) to reach the
special kfunc checks below without verifying desc->offset == 0.

Looking at the code after this change, fixup_kfunc_call() compares
desc->func_id against special_kfunc_list[] entries:

>  	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
>  	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
> [ ... ]
>  	} else if (desc->func_id == special_kfunc_list[KF_bpf_obj_drop_impl] ||
>  		   desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl] ||
>  		   desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl]) {
> [ ... ]

The special_kfunc_list[] array contains BTF IDs from btf_vmlinux. Module
kfuncs have their own BTF ID namespace, so a module kfunc with BTF ID 5
is different from a kernel kfunc with BTF ID 5. However, the comparison
desc->func_id == special_kfunc_list[...] doesn't check desc->offset,
which distinguishes kernel kfuncs (offset 0) from module kfuncs (offset
!= 0).

Other code already follows the pattern of checking offset before
comparing against special_kfunc_list[]:

  is_bpf_throw_kfunc() (line 12910):
    return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
           insn->imm == special_kfunc_list[KF_bpf_throw];

  is_sleepable_insn() (line 556):
    if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
        (is_bpf_wq_set_callback_impl_kfunc(insn->imm) || ...))

  check_kfunc_call() (line 13974):
    } else if (!insn->off && insn->imm == special_kfunc_list[KF___bpf_trap]) {

If a module kfunc happens to have the same BTF ID as one of the ~50
special kernel kfuncs, won't it be incorrectly treated as that special
kfunc and have the wrong fixup applied?

The intended fix appears to be allowing module kfuncs to reach the
__prog argument fixup code (lines 22564-22573), but removing the early
return also exposes them to the special kfunc checks. Should the special
kfunc comparisons also verify desc->offset == 0?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19912520845

--===============3410881854585358566==--

