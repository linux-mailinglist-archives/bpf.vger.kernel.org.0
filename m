Return-Path: <bpf+bounces-52803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3D0A489D4
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 21:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEE87A78D4
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4926FA5D;
	Thu, 27 Feb 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+Oz6+As"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B6222576;
	Thu, 27 Feb 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687947; cv=none; b=O7xjvKv+Pj4Vp0Fw6+KH2Io4eOGNkEQsj6FQA3jB+6WG3Gdge8BYHtxnBcrnD3FlzhyyYp584Rjl6gtNdf5FuAQ/yUxIHvgVH6L3JWTZ7fE23ynfuXrCPc8L/wbamLj7+LguMpOiaJVvfW6zQsiakmeBHjWUIeQBCoeNEs6+IV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687947; c=relaxed/simple;
	bh=x+G/99/fJ4f7EM+mYbQrbRa/jVYXxNecjlYrsSVoDQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRN6Eb1rZoc/YH5UqJ9bigrop4b5U6X+j18xo/AaIUl8bQ2n6Uml0OUKtAN9cuyagGILCfPep8iIGB/TJvtpJ1KY0kI3k8yY0JnAx+F2g9Q1hRqbynVrjLhQ9D1mNz4m8bZ5uqhO2Jt3/AKUuTOv1jQxcVcqu8RpFg2y9ZAiXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+Oz6+As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2826BC4CEDD;
	Thu, 27 Feb 2025 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740687947;
	bh=x+G/99/fJ4f7EM+mYbQrbRa/jVYXxNecjlYrsSVoDQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+Oz6+AsQ8m63ZZ4+bHMWSJEtKlDFtbIL8UE/MXvJbzE0rDw1a0/fzri/Ly/+eqTW
	 W4+nJSFunAXSklKMlhks72H/U9x4iUm4PrmCiOhZb7TeKMdWPx6HGc+WujwIuZ54ct
	 uxb8tSp/FT2VXZwBRl1woMB+N0KiODGRs7ytO3/kWoxY/TEX3s5ngVu+Qq5qZtZyPp
	 9SpxUUks0YECzzUuKlpC13Bu6IOASORL/vMsIm+euCpHVghiV9d/Fl/aX4przFcbUP
	 nVE6kdC72kPb3bZVcyRU97oE/H/vc5T6BeMGH5kfYTERsfKIyizCRnfV8CRLvFwVer
	 1Oy6NIaX4MLGA==
Date: Thu, 27 Feb 2025 10:25:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	memxor@gmail.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context_sensitive for unified filtering of
 context-sensitive SCX kfuncs
Message-ID: <Z8DKSgzZB5HZgYN8@slm.duckdns.org>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>

Hello,

On Wed, Feb 26, 2025 at 07:28:18PM +0000, Juntong Deng wrote:
> +BTF_KFUNCS_START(scx_kfunc_ids_ops_context_sensitive)
> +/* scx_kfunc_ids_select_cpu */
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
> +/* scx_kfunc_ids_enqueue_dispatch */
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
> +/* scx_kfunc_ids_dispatch */
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
> +BTF_ID_FLAGS(func, scx_bpf_consume)
> +/* scx_kfunc_ids_cpu_release */
> +BTF_ID_FLAGS(func, scx_bpf_reenqueue_local)
> +/* scx_kfunc_ids_unlocked */
> +BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
> +/* Intersection of scx_kfunc_ids_dispatch and scx_kfunc_ids_unlocked */
> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
> +BTF_KFUNCS_END(scx_kfunc_ids_ops_context_sensitive)

I'm not a big fan of repeating the kfuncs. This is going to be error-prone.
Can't it register and test the existing sets in the filter function instead?
If that's too cumbersome, maybe we can put these in a macro so that we don't
have to repeat the functions?

> +static int scx_kfunc_ids_ops_context_sensitive_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	u32 moff, flags;
> +
> +	if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context_sensitive, kfunc_id))
> +		return 0;
> +
> +	if (prog->type == BPF_PROG_TYPE_SYSCALL &&
> +	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
> +		return 0;

Not from this change but these can probably be allowed from TRACING too.

> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
> +	    prog->aux->st_ops != &bpf_sched_ext_ops)
> +		return 0;

Why can't other struct_ops progs call scx_kfunc_ids_unlocked kfuncs?

> +	/* prog->type == BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_ops == &bpf_sched_ext_ops*/
> +
> +	moff = prog->aux->attach_st_ops_member_off;
> +	flags = scx_ops_context_flags[SCX_MOFF_IDX(moff)];
> +
> +	if ((flags & SCX_OPS_KF_UNLOCKED) &&
> +	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
> +		return 0;

Wouldn't this disallow e.g. ops.dispatch() from calling scx_dsq_move()?

Have you tested that the before and after behaviors match?

Thanks.

-- 
tejun

