Return-Path: <bpf+bounces-72419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84618C121DE
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 067274FBE80
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC2133031C;
	Mon, 27 Oct 2025 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ/KUmyJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1BE2E7F29;
	Mon, 27 Oct 2025 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609443; cv=none; b=TT/3IGYfA5aMC2J0wRfzbHEmv+XFLKMlzPoCd7hfwJC2CiwvWnQvJbkwvK58RFoJLoZ9Y/SbrBb+zrQxqzimvBcS9nIn0u7us1a9jefyPHatKUW/XBc9C9GnpZd61VZTT36Y7dJLUiT/P1jTnjXY2W0rlylXVn4H0SPCmo0Dv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609443; c=relaxed/simple;
	bh=jXLAtIGL3t3Eeivlb10T/oIzaKMtHVUOwyi8U5Ge+jA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ntO0xGY0f2rDTgJzWMvsZeHfa4BVadM/WoXT9dQe7AHwJznRFzNSyMuEhiluSSA98QHvetceZxtpM2g+jsKMdPt7nVljbzI+aLmMeecC9RO2RmDKV0CNCP7993Sctc5WasPEMVpN2GypHNB9SpFsms7wxMSbdKf6pwlsfgkE0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ/KUmyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1076EC4CEFB;
	Mon, 27 Oct 2025 23:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761609442;
	bh=jXLAtIGL3t3Eeivlb10T/oIzaKMtHVUOwyi8U5Ge+jA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lJ/KUmyJsclpDQQ2M+QMnXvOZZC6krQiFKX8sOxfOpoaqG4LjkXXRw347U0yA/XVL
	 Rey0uasO7GpRSs56MfV8SO/NJ2mhK21qIXIQDLmbdzJ2+MjYXzmAD2ySoASlOgr5WZ
	 qI6vVen1gQRkaKqCiQHBrMuinOcBpybHtrxPdFPBA5k84RpmR84/2G2c3NfktLDXQj
	 fL5lj8pzXbT6Q5LPKIkdl4K4tCUYoR3e3CDY/Sukgi/Pg7WcUvXpgtx3WwcOAY7S9H
	 Gl8/cAJIBIOuHsiYgiz1WYIYG0ofPZnG52T6c3hXqIEUHthM1bXhSA6SkrY2an/ZhX
	 IoAhcgPK/opuw==
Content-Type: multipart/mixed; boundary="===============5693088593246735983=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2b04ce21d82f2118c291c49ace22d685bcbbd45d203b2f676556d3e5a90eebd1@mail.kernel.org>
In-Reply-To: <20251027232206.473085-3-roman.gushchin@linux.dev>
References: <20251027232206.473085-3-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 13/23] mm: introduce bpf_out_of_memory() BPF kfunc
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:57:21 +0000 (UTC)

--===============5693088593246735983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit bce57b9b96e05731a14c7e10a364fdd9b733cda2
Author: Roman Gushchin <roman.gushchin@linux.dev>

mm: introduce bpf_out_of_memory() BPF kfunc

This patch introduces bpf_out_of_memory() BPF kfunc to allow BPF programs
to declare OOM events and trigger the kernel OOM handling mechanism. The
function accepts a nullable memcg pointer for system-wide or memcg-scoped
OOMs.

> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 721087952..3cbdcd013 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -21,6 +21,11 @@ enum oom_constraint {
>  	CONSTRAINT_MEMCG,
>  };
>
> +enum bpf_oom_flags {
> +	BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK = 1 << 0,
> +	BPF_OOM_FLAGS_LAST = 1 << 1,
> +};
> +
>  /*
>   * Details of the page allocation that triggered the oom killer that are used to
>   * determine what should be killed.
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 3c86cd755..d7fca4bf5 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c

[ ... ]

> +/**
> + * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
> + * @memcg__nullable: memcg or NULL for system-wide OOMs
> + * @order: order of page which wasn't allocated
> + * @flags: flags
> + * @constraint_text__nullable: custom constraint description for the OOM report
> + *
> + * Declares the Out Of Memory state and invokes the OOM killer.
> + *
> + * OOM handlers are synchronized using the oom_lock mutex. If wait_on_oom_lock
> + * is true, the function will wait on it. Otherwise it bails out with -EBUSY
> + * if oom_lock is contended.
> + *
> + * Generally it's advised to pass wait_on_oom_lock=false for global OOMs
> + * and wait_on_oom_lock=true for memcg-scoped OOMs.
> + *
> + * Returns 1 if the forward progress was achieved and some memory was freed.
> + * Returns a negative value if an error occurred.
> + */
> +__bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
> +				  int order, u64 flags)
> +{
> +	struct oom_control oc = {
> +		.memcg = memcg__nullable,
> +		.order = order,
> +	};

Can bpf_out_of_memory() work correctly for system-wide OOMs with
uninitialized gfp_mask?

Looking at out_of_memory():

    if (!(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
        return true;

With gfp_mask=0 and memcg=NULL (system-wide OOM), this evaluates to:
!(0 & __GFP_FS) && !false = true, causing an early return without
invoking the OOM killer. The comment in out_of_memory() explains this
check is about allocation context: "The OOM killer does not compensate
for IO-less reclaim."

All other callers of out_of_memory() initialize gfp_mask:
- mm/page_alloc.c: .gfp_mask = gfp_mask
- mm/memcontrol.c: .gfp_mask = gfp_mask

For memcg OOMs, the code works because is_memcg_oom(oc) is true,
bypassing the check. But for system-wide OOMs (NULL memcg), won't this
cause the function to return immediately without killing any process?

> +	int ret;
> +
> +	if (flags & ~(BPF_OOM_FLAGS_LAST - 1))
> +		return -EINVAL;
> +
> +	if (oc.order < 0 || oc.order > MAX_PAGE_ORDER)
> +		return -EINVAL;
> +
> +	if (flags & BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK) {
> +		ret = mutex_lock_killable(&oom_lock);
> +		if (ret)
> +			return ret;
> +	} else if (!mutex_trylock(&oom_lock))
> +		return -EBUSY;
> +
> +	ret = out_of_memory(&oc);
> +
> +	mutex_unlock(&oom_lock);
> +	return ret;
> +}

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `mm: introduce bpf_out_of_memory() BPF kfunc`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============5693088593246735983==--

