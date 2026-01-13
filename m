Return-Path: <bpf+bounces-78707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206BD18F5F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4844B307D16D
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5716E3921C1;
	Tue, 13 Jan 2026 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsPwlrXZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9338FEFB
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308161; cv=none; b=sjMBKYjZYdoIEF3yumSAwU2Ey3WJItbU+oeKw8e0NJ1JsbvlcM6poqaM5IdpkdFPDSPxP4Kgsr82b8VPfiYwo9FedP3j6imhREX6EK7i3acuhprHd5YPp+JNV15Y7hMXqCibxQ6PnDIQc6H9P5QlgbSTQ3fZT9lMo9ABMHllh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308161; c=relaxed/simple;
	bh=/rhdd0wg985rvZA9gm6N7N3iXKw1yrmZh8uRIqjK0qo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X3uxxVccmtnGK/y9j63BoVM6LcT2smasx4vM0yd88gvZa7172553sDhf9nfJD5adgFQJWogkQ4/I7E98z5ki5vzkyRI/vw7sN/MpyFI0PC9fTISdKb/at51bzHJJ+ACdsCXEQJCrI0whnY9/3gxBEL7phJySxfdwbyTsz4+v4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsPwlrXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B28C116C6;
	Tue, 13 Jan 2026 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768308161;
	bh=/rhdd0wg985rvZA9gm6N7N3iXKw1yrmZh8uRIqjK0qo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=SsPwlrXZcHLRfd87zRrnL+Q21oqGj51gsGYWaR52R/vOCEaLJfgENJEQiEn3DO7WS
	 S4yQCnT/jsxWr80b+rpcgHtDmuloJ4sePU1DLwEsMllM01BVOYCpTbe4Lki9yozr+j
	 4AhMXgP6IUBOZ7IkTIZzPErwQx1RVjGkDJZnOUKrgvesq+2u76+ejE/EFrgN9VCje3
	 0UNXkRW+nMdY6gskOYLPYwnWn2Yt/lK9wIl4iyt0QkyW3pO/YDue3cE41R/FSNY+XC
	 XuT9OrN3+apsA1n2ctlWm9EPeTqeVUmRpuxaJ7QAxLd/O4tdwJvpsWhc+zZiBojR8b
	 epVhr8xC9APWg==
Content-Type: multipart/mixed; boundary="===============4672709832961997223=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8496feb711aed72644504926d9ff358550c011e3144dea088833ad723f4fe852@mail.kernel.org>
In-Reply-To: <20260113121238.11300-2-laoar.shao@gmail.com>
References: <20260113121238.11300-2-laoar.shao@gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/3] sched: add helpers for numa balancing
From: bot+bpf-ci@kernel.org
To: laoar.shao@gmail.com,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,mkoutny@suse.com,yu.c.chen@intel.com,zhao1.liu@intel.com
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,laoar.shao@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 13 Jan 2026 12:42:41 +0000 (UTC)

--===============4672709832961997223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
> index 52b22c5c396d..792b6665f476 100644
> --- a/include/linux/sched/numa_balancing.h
> +++ b/include/linux/sched/numa_balancing.h

[ ... ]

> @@ -32,6 +33,28 @@ extern void set_numabalancing_state(bool enabled);
> extern void task_numa_free(struct task_struct *p, bool final);
> bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
> 				int src_nid, int dst_cpu);
> +
> +extern struct static_key_false sched_numa_balancing;
> +static inline bool task_numab_enabled(struct task_struct *p)
> +{
> +	if (static_branch_unlikely(&sched_numa_balancing))
> +		return true;
> +	return false;
> +}
> +
> +static inline bool task_numab_mode_normal(void)
> +{
> +	if (sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL)
> +		return true;
> +	return false;
> +}
> +
> +static inline bool task_numab_mode_tiering(void)
> +{
> +	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> +		return true;
> +	return false;
> +}
>  #else
>  static inline void task_numa_fault(int last_node, int node, int pages,
> 				   int flags)

[ ... ]

> @@ -52,6 +75,10 @@ static inline bool should_numa_migrate_memory(struct task_struct *p,
>  {
>  	return true;
>  }
> +static inline bool task_numab_enabled(struct task_struct *p)
> +{
> +	return false;
> +}
>  #endif

The #else block adds a stub for task_numab_enabled(), but task_numab_mode_normal()
and task_numab_mode_tiering() are missing from this section. These helpers are
defined when CONFIG_NUMA_BALANCING is enabled, but have no stubs when it is
disabled.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 670fe9fae5ba..7ee5695326e3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c

[ ... ]

> @@ -4843,9 +4844,7 @@ static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
>  	if (!current_is_kswapd() || sc->order)
>  		return false;
>
> -	mark = sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ?
> -	       WMARK_PROMO : WMARK_HIGH;
> -
> +	mark = task_numab_mode_tiering() ? WMARK_PROMO : WMARK_HIGH;

[ ... ]

> @@ -6774,7 +6773,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>  		enum zone_stat_item item;
>  		unsigned long free_pages;
>
> -		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> +		if (task_numab_mode_tiering())
>  			mark = promo_wmark_pages(zone);

The original sysctl_numa_balancing_mode is defined to 0 when CONFIG_NUMA_BALANCING
is disabled (see include/linux/sched/sysctl.h), allowing this code to compile and
work correctly in both configurations. The new task_numab_mode_tiering() helper
lacks a stub in the #else block, so should_abort_scan() and pgdat_balanced() in
mm/vmscan.c will fail to compile when CONFIG_NUMA_BALANCING is not enabled.

Would it make sense to add stubs for task_numab_mode_normal() and
task_numab_mode_tiering() to the #else block, returning false to match the
original behavior when sysctl_numa_balancing_mode is defined as 0?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20956455529

--===============4672709832961997223==--

