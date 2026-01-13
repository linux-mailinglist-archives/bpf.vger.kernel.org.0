Return-Path: <bpf+bounces-78703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A4D18B71
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF3C130393DC
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DDC38F24F;
	Tue, 13 Jan 2026 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGTlrd6A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F77389DE6
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307382; cv=none; b=jk+k1tLYJkDXw5P4Fl949G5lyL70aKMgV4ZuG0BE/lzA3QIuCtrLd4qT90fbo3+pjQoRe+2sP47+WgWhaX9f5xt1s+mv9uab3aW41+yoEEJXw/Lp+EFId7m0hMApbwGjYvb3FdxGMMGVAhufbXm8W37KkuXMjVraFmSYX1MePls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307382; c=relaxed/simple;
	bh=kC3MjEISpEzsYvzzprWTIDLtUFgYrWXfBkjrFKiQZYM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E8OA3EcMjHZ3vUTQnkylMarU7yw83idLQzND3z7t5VrAIcIvktUAxjxCETtRg/e6MlIWzk74VjvK/X0SeDjyrzb5Q3nLvEfG4/9gPXSeuN/qxQhVAVB7XNLQ+fopTe/V1PfiiLBm452k8zF6cTYV4FTVQMVOZMDieucoRUCRzww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGTlrd6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B1EC116C6;
	Tue, 13 Jan 2026 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768307382;
	bh=kC3MjEISpEzsYvzzprWTIDLtUFgYrWXfBkjrFKiQZYM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FGTlrd6AiRMNXJkJkMRvDLXsTAbNJr/+rq1Wkd9hb7Ood0dmsmk97ZsSEgl+A+V60
	 pyBLKtgSYTZuz6b2yatgVMN9tvckhhs4ayGsONVHEhEdgbNQW7AjigIJk3dc1RVdId
	 r027mPsspOoHHacKxwrPr58tAEJGBm/QMMVKFTs4Mnxs+DV3xpfL/fW2Ukg5SwGlBg
	 CR3E0gX1DIJiSuXytU7+f13iYZZBdqw5Xs2c6V2MVSkMoqTTdmg8tcDvdNNgxxgfeQ
	 mvFGGOsSQNEurEa8rTI6hVvRtkkNEmDvG2Lhgg/Ms/mzapuDtKg5ggoLiWJtWGhwnz
	 XDWTtqGn6VLwA==
Content-Type: multipart/mixed; boundary="===============8699615455370949168=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <be08950549a97cf3a2efd077cffc767395c208807f5f65af081db9a9a9623944@mail.kernel.org>
In-Reply-To: <20260113121238.11300-3-laoar.shao@gmail.com>
References: <20260113121238.11300-3-laoar.shao@gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] mm: add support for bpf based numa balancing
From: bot+bpf-ci@kernel.org
To: laoar.shao@gmail.com,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,mkoutny@suse.com,yu.c.chen@intel.com,zhao1.liu@intel.com
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,laoar.shao@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 13 Jan 2026 12:29:42 +0000 (UTC)

--===============8699615455370949168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/Makefile b/mm/Makefile
> index bf46fe31dc14..c2b887491f09 100644

[ ... ]

> @@ -107,8 +107,13 @@ ifdef CONFIG_SWAP
>  obj-$(CONFIG_MEMCG) += swap_cgroup.o
>  endif
>  ifdef CONFIG_BPF_SYSCALL
> +ifdef CONFIG_NUMA_BALANCING
>  obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
>  endif
> +endif
> +ifdef CONFIG_BPF_SYSCALL
> +obj-$(CONFIG_MEMCG) += bpf_numa_balancing.o
> +endif

Should bpf_numa_balancing.o also require CONFIG_SHRINKER_DEBUG? The code
calls mem_cgroup_get_from_ino() which is only defined when
CONFIG_SHRINKER_DEBUG is enabled. Without it, compilation will fail due to
an undefined reference.

Also, should it require CONFIG_NUMA_BALANCING? Without that config option,
task_numab_enabled() returns false unconditionally, so the BPF hook would
never be invoked even if a program is attached.

> diff --git a/mm/bpf_numa_balancing.c b/mm/bpf_numa_balancing.c
> new file mode 100644
> index 000000000000..aac4eec7c6ba
> --- /dev/null
> +++ b/mm/bpf_numa_balancing.c

[ ... ]

> +static int bpf_numab_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_numab_ops *ops = kdata;
> +	struct mem_cgroup *memcg;
> +	int err = 0;
> +
> +	/* Only the link mode is supported. */
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	/* Depends on CONFIG_SHRINKER_DEBUG */
> +	memcg = mem_cgroup_get_from_ino(ops->cgroup_id);
> +	if (!memcg || IS_ERR(memcg))
> +		return -ENOENT;
> +
> +	spin_lock(&numab_ops_lock);
> +	/* Each memory cgroup can have at most one attached BPF program to ensure
> +	 * exclusive control and avoid interference between different BPF policies.
> +	 */
> +	if (rcu_access_pointer(memcg->bpf_numab)) {
> +		err = -EBUSY;
> +		goto out;
> +	}
> +	rcu_assign_pointer(memcg->bpf_numab, ops);
> +	spin_unlock(&numab_ops_lock);
> +	static_branch_inc(&bpf_numab_enabled_key);
> +
> +out:
> +	mem_cgroup_put(memcg);
> +	return err;
> +}

When rcu_access_pointer(memcg->bpf_numab) is non-NULL, the code sets err
to -EBUSY and jumps to out:, but this bypasses the spin_unlock(). Is the
spinlock left held when returning -EBUSY?

> +static void bpf_numab_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_numab_ops *ops = kdata;
> +	struct mem_cgroup *memcg;
> +
> +	memcg = mem_cgroup_get_from_ino(ops->cgroup_id);
> +	if (!memcg)
> +		return;

mem_cgroup_get_from_ino() returns ERR_PTR() on failure, not NULL. If the
cgroup was deleted between reg and unreg, this function would get an
ERR_PTR value, the if (!memcg) check would pass, and then
rcu_access_pointer(memcg->bpf_numab) would dereference an invalid pointer.
Should this check be if (!memcg || IS_ERR(memcg)) like in bpf_numab_reg()?

Also, mem_cgroup_get_from_ino() takes a reference on the memcg via
cgroup_get_e_css(). Where is the corresponding mem_cgroup_put() call?
The function appears to leak the memcg reference on all paths.

> +	spin_lock(&numab_ops_lock);
> +	if (!rcu_access_pointer(memcg->bpf_numab)) {
> +		spin_unlock(&numab_ops_lock);
> +		return;
> +	}
> +	rcu_replace_pointer(memcg->bpf_numab, NULL, lockdep_is_held(&numab_ops_lock));
> +	spin_unlock(&numab_ops_lock);
> +	static_branch_dec(&bpf_numab_enabled_key);
> +	synchronize_rcu();
> +}
> +
> +static int bpf_numab_update(void *kdata, void *old_kdata, struct bpf_link *link)
> +{
> +	struct bpf_numab_ops *ops = kdata;
> +	struct mem_cgroup *memcg;
> +
> +	memcg = mem_cgroup_get_from_ino(ops->cgroup_id);
> +	if (!memcg)
> +		return -EINVAL;

Same two issues as bpf_numab_unreg(): the check should handle ERR_PTR()
values, and there appears to be no mem_cgroup_put() to release the
reference taken by mem_cgroup_get_from_ino().

> +	spin_lock(&numab_ops_lock);
> +	/* The update can proceed regardless of whether memcg->bpf_numab has been previously set. */
> +	rcu_replace_pointer(memcg->bpf_numab, ops, lockdep_is_held(&numab_ops_lock));
> +	spin_unlock(&numab_ops_lock);
> +	synchronize_rcu();
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20956455529

--===============8699615455370949168==--

