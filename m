Return-Path: <bpf+bounces-66576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 846C7B370C3
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC928E184B
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229D92D7D2A;
	Tue, 26 Aug 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5dMcm4l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBF2D5426;
	Tue, 26 Aug 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227419; cv=none; b=t3WTqw//EX5K4Dr7A0Xiptfo+hGrQokXa4/6AM/xhtaT+pBXFy05WqqXciFy0czdaJnez7b68+bFPu9EujhYtWkBOVazhHAXEnBxY1ZoDoE9ZhKolv4KDZEFKjZR+QfAjZQV/+0GnHmA4oJJ8lzzQ9KDthnA7LZ/sIg5Kckumbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227419; c=relaxed/simple;
	bh=f7lSSzleVic+Snncx1ZxfyrtQ91K6XEfqz0SZkNXuUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgFKCjV4ojp+T2Sll3yMwQ8lYVNj7AoLwa6+QGcdJdeqGt11axjf4xXaMAxk+5Koxg/Tkh4s5xfGS4PtQtnU9IaWAWuoNBXH34FmUsz8og0hCjG9kHM5ZsizPD9qSEjY1Pj8zlJO1QCCP1PDAS/cbXKeIWWOGvIL1c22xeCF71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5dMcm4l; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so3180706a12.1;
        Tue, 26 Aug 2025 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756227417; x=1756832217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+KB6d2ii43Z2jE4Sy0ThtTdO5RYn89XqD3QKRElsfk=;
        b=I5dMcm4lLpFeZNxr+bFD9XzCtc3G6XdND30eJYrWSzymrV0BMzeRpuyPjpPRzEBjOg
         vKTg7v7jlWZ4G67dAWTB8FU8OQc3W+BEp5xT0TIQNm9/VDqI0FVCx/37AvxwxV6pXFQp
         VApZnoZvkzYLF2R4E7SZTYxjj9KE530RluxB/zTl5OCpGGNtZIFTSrgiFoQGRTaxtKPX
         oMnf2mxmGCRwqIqsLVBCq9R0SvBx8lmD5Ny6sbX46rFdwPxm7qbhCnIZIz5ze2Wd4pxE
         +FPuJQ8XDuWU3W2dU2V1TxD2MF+37r0PHx50vqeTe9Sl38pOqARW/m7R1HqAcaimF9jM
         OfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227417; x=1756832217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+KB6d2ii43Z2jE4Sy0ThtTdO5RYn89XqD3QKRElsfk=;
        b=tUih1qpq83hjfkhoRAL30y+ymFJdslA7HKEjsimJ5xTEkEvSEzAC3SjE6UPis8CLNd
         tNMbxgjs73u8tR+tWY9lugCTZXXh3PbVWKqDenhixU8MANQFhU4UOahLirLDrD1K4li8
         Y8ZVjNfaIJroeIZR2G1+AvMfQlzvhjG6tkIsPykeS27YvdFmTep1gb0UrPJPOfL7YOxZ
         gSREwtBX1xPlkyeOSnQPRGPnHuoyw3Uy7+Wb+3h38BJ+4xBuCEPdN+1NKYwS8N1Zkp4s
         XkVmQBa7+gu66Y5popHBqmdBMX/km2L5tkaD8wH1mopalNPqxQV5bSJyGVmhP87a3i64
         lyPg==
X-Forwarded-Encrypted: i=1; AJvYcCUSqPfAqpxRPH5iHqfhQPbq6vt1HN2+yaN1sbMfIY5UvJLE4FvMjKtKAN920jWsqxpSdCWmuPJtIYiCr9iR@vger.kernel.org, AJvYcCXHM4Csbm/Re6ks7etWCn1NItj8MV5PJaTgvC+xngbuY7ESRMnVGlxEtolsTKHTPBTbnws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhruEC8vzrEv+kw3oKAtsOCtgvs/7gy2WjwdkFZJHhnw36yhC
	Yr6DvKF4P9e3+g8wnKcV+IHasDeBRgt+sRvjdNpwUnQ1OxSepZKEthLp
X-Gm-Gg: ASbGnct78j0f/i7H9jltCJfPpiWEf/6ukhuawm8xOlAskfv84EpQzX/o6cWLMvwkypa
	qyrrbQnGP4l7SthT+l5Z433C1qR3E/NBdxm24LD2U9V613taw4zgA6VkCdetYzf8l40Alu+L/nx
	xDADYoproBysnpdqECkkAEDR2dRYAi7RqDADYimnWR2ZapHbD8+q2YVWWY/HY/Zb/uTlhsmGyiK
	B2w4W8e0AkGJQhVFCPKgmkdDESF6x5yeznv26F0pZS4DYb0US9wsHJ0toN0DmCoLpP++T5zioQs
	WllEZX8+r2SYtkuWpZttLPBVIhdxgNkGbKWerO4+mHr9kI54JkOzLwGX0oDDv78qxbOuLmn7Uas
	gkYz9JZzls5C4no0Rdz2mi1jKZR6QfcWaAkc6j4U+7JHmOxVDtNSJe06cSDDoigeOMg==
X-Google-Smtp-Source: AGHT+IEF6Usdfy5vPYS1NMsAOkGzxJUPb0MrhLayywZFySl5xloZmchFdDhutAG5JdegKlPdv7BI2g==
X-Received: by 2002:a17:90a:e704:b0:325:6598:30fe with SMTP id 98e67ed59e1d1-32565983334mr16069137a91.4.1756227416807;
        Tue, 26 Aug 2025 09:56:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:a:14b0:ff2b:98c1:659? ([2620:10d:c090:500::4:9299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3274572be3bsm1357878a91.2.2025.08.26.09.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:56:56 -0700 (PDT)
Message-ID: <4b715bdf-4f2a-4e82-94a0-3846526f8d59@gmail.com>
Date: Tue, 26 Aug 2025 09:56:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 bpf@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <20250818170136.209169-2-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/18/25 10:01 AM, Roman Gushchin wrote:
> Introduce a bpf struct ops for implementing custom OOM handling policies.
>
> The struct ops provides the bpf_handle_out_of_memory() callback,
> which expected to return 1 if it was able to free some memory and 0
> otherwise.
>
> In the latter case it's guaranteed that the in-kernel OOM killer will
> be invoked. Otherwise the kernel also checks the bpf_memory_freed
> field of the oom_control structure, which is expected to be set by
> kfuncs suitable for releasing memory. It's a safety mechanism which
> prevents a bpf program to claim forward progress without actually
> releasing memory. The callback program is sleepable to enable using
> iterators, e.g. cgroup iterators.
>
> The callback receives struct oom_control as an argument, so it can
> easily filter out OOM's it doesn't want to handle, e.g. global vs
> memcg OOM's.
>
> The callback is executed just before the kernel victim task selection
> algorithm, so all heuristics and sysctls like panic on oom,
> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> are respected.
>
> The struct ops also has the name field, which allows to define a
> custom name for the implemented policy. It's printed in the OOM report
> in the oom_policy=<policy> format. "default" is printed if bpf is not
> used or policy name is not specified.
>
> [  112.696676] test_progs invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
>                 oom_policy=bpf_test_policy
> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> [  112.698167] Call Trace:
> [  112.698177]  <TASK>
> [  112.698182]  dump_stack_lvl+0x4d/0x70
> [  112.698192]  dump_header+0x59/0x1c6
> [  112.698199]  oom_kill_process.cold+0x8/0xef
> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x313
> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
> [  112.698250]  out_of_memory+0xab/0x5c0
> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
> [  112.698288]  charge_memcg+0x2f/0xc0
> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
> [  112.698299]  do_anonymous_page+0x40f/0xa50
> [  112.698311]  __handle_mm_fault+0xbba/0x1140
> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698335]  handle_mm_fault+0xe6/0x370
> [  112.698343]  do_user_addr_fault+0x211/0x6a0
> [  112.698354]  exc_page_fault+0x75/0x1d0
> [  112.698363]  asm_exc_page_fault+0x26/0x30
> [  112.698366] RIP: 0033:0x7fa97236db00
>
> It's possible to load multiple bpf struct programs. In the case of
> oom, they will be executed one by one in the same order they been
> loaded until one of them returns 1 and bpf_memory_freed is set to 1
> - an indication that the memory was freed. This allows to have
> multiple bpf programs to focus on different types of OOM's - e.g.
> one program can only handle memcg OOM's in one memory cgroup.
> But the filtering is done in bpf - so it's fully flexible.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>   include/linux/bpf_oom.h |  49 +++++++++++++
>   include/linux/oom.h     |   8 ++
>   mm/Makefile             |   3 +
>   mm/bpf_oom.c            | 157 ++++++++++++++++++++++++++++++++++++++++
>   mm/oom_kill.c           |  22 +++++-
>   5 files changed, 237 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/bpf_oom.h
>   create mode 100644 mm/bpf_oom.c
>
> diff --git a/include/linux/bpf_oom.h b/include/linux/bpf_oom.h
> new file mode 100644
> index 000000000000..29cb5ea41d97
> --- /dev/null
> +++ b/include/linux/bpf_oom.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __BPF_OOM_H
> +#define __BPF_OOM_H
> +
> +struct bpf_oom;
> +struct oom_control;
> +
> +#define BPF_OOM_NAME_MAX_LEN 64
> +
> +struct bpf_oom_ops {
> +	/**
> +	 * @handle_out_of_memory: Out of memory bpf handler, called before
> +	 * the in-kernel OOM killer.
> +	 * @oc: OOM control structure
> +	 *
> +	 * Should return 1 if some memory was freed up, otherwise
> +	 * the in-kernel OOM killer is invoked.
> +	 */
> +	int (*handle_out_of_memory)(struct oom_control *oc);

I suggest adding "struct bpf_oom *" as the first argument to all 
bpf_oom_ops to future-proof. It will allow an bpf_oom kfunc or prog to 
refer to the struct_ops instance itself.

Since bpf_oom_ops allows multiple attachment, if a bpf_prog is shared 
between two bpf_oom, it will be able to infer which bpf_oom_ops is 
calling by this extra argument.


> +
> +	/**
> +	 * @name: BPF OOM policy name
> +	 */
> +	char name[BPF_OOM_NAME_MAX_LEN];
> +
> +	/* Private */
> +	struct bpf_oom *bpf_oom;
> +};
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +/**
> + * @bpf_handle_oom: handle out of memory using bpf programs
> + * @oc: OOM control structure
> + *
> + * Returns true if a bpf oom program was executed, returned 1
> + * and some memory was actually freed.
> + */
> +bool bpf_handle_oom(struct oom_control *oc);
> +
> +#else /* CONFIG_BPF_SYSCALL */
> +static inline bool bpf_handle_oom(struct oom_control *oc)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +
> +#endif /* __BPF_OOM_H */
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 1e0fc6931ce9..ef453309b7ea 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -51,6 +51,14 @@ struct oom_control {
>   
>   	/* Used to print the constraint info. */
>   	enum oom_constraint constraint;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +	/* Used by the bpf oom implementation to mark the forward progress */
> +	bool bpf_memory_freed;
> +
> +	/* Policy name */
> +	const char *bpf_policy_name;
> +#endif
>   };
>   
>   extern struct mutex oom_lock;
> diff --git a/mm/Makefile b/mm/Makefile
> index 1a7a11d4933d..a714aba03759 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -105,6 +105,9 @@ obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
>   ifdef CONFIG_SWAP
>   obj-$(CONFIG_MEMCG) += swap_cgroup.o
>   endif
> +ifdef CONFIG_BPF_SYSCALL
> +obj-y += bpf_oom.o
> +endif
>   obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>   obj-$(CONFIG_GUP_TEST) += gup_test.o
>   obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
> diff --git a/mm/bpf_oom.c b/mm/bpf_oom.c
> new file mode 100644
> index 000000000000..47633046819c
> --- /dev/null
> +++ b/mm/bpf_oom.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * BPF-driven OOM killer customization
> + *
> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/oom.h>
> +#include <linux/bpf_oom.h>
> +#include <linux/srcu.h>
> +
> +DEFINE_STATIC_SRCU(bpf_oom_srcu);
> +static DEFINE_SPINLOCK(bpf_oom_lock);
> +static LIST_HEAD(bpf_oom_handlers);
> +
> +struct bpf_oom {
> +	struct bpf_oom_ops *ops;
> +	struct list_head node;
> +	struct srcu_struct srcu;
> +};
> +
> +bool bpf_handle_oom(struct oom_control *oc)
> +{
> +	struct bpf_oom_ops *ops;
> +	struct bpf_oom *bpf_oom;
> +	int list_idx, idx, ret = 0;
> +
> +	oc->bpf_memory_freed = false;
> +
> +	list_idx = srcu_read_lock(&bpf_oom_srcu);
> +	list_for_each_entry_srcu(bpf_oom, &bpf_oom_handlers, node, false) {
> +		ops = READ_ONCE(bpf_oom->ops);
> +		if (!ops || !ops->handle_out_of_memory)
> +			continue;
> +		idx = srcu_read_lock(&bpf_oom->srcu);
> +		oc->bpf_policy_name = ops->name[0] ? &ops->name[0] :
> +			"bpf_defined_policy";
> +		ret = ops->handle_out_of_memory(oc);
> +		oc->bpf_policy_name = NULL;
> +		srcu_read_unlock(&bpf_oom->srcu, idx);
> +
> +		if (ret && oc->bpf_memory_freed)
> +			break;
> +	}
> +	srcu_read_unlock(&bpf_oom_srcu, list_idx);
> +
> +	return ret && oc->bpf_memory_freed;
> +}
> +
> +static int __handle_out_of_memory(struct oom_control *oc)
> +{
> +	return 0;
> +}
> +
> +static struct bpf_oom_ops __bpf_oom_ops = {
> +	.handle_out_of_memory = __handle_out_of_memory,
> +};
> +
> +static const struct bpf_func_proto *
> +bpf_oom_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	return tracing_prog_func_proto(func_id, prog);
> +}
> +
> +static bool bpf_oom_ops_is_valid_access(int off, int size,
> +					enum bpf_access_type type,
> +					const struct bpf_prog *prog,
> +					struct bpf_insn_access_aux *info)
> +{
> +	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static const struct bpf_verifier_ops bpf_oom_verifier_ops = {
> +	.get_func_proto = bpf_oom_func_proto,
> +	.is_valid_access = bpf_oom_ops_is_valid_access,
> +};
> +
> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_oom_ops *ops = kdata;
> +	struct bpf_oom *bpf_oom;
> +	int ret;
> +
> +	bpf_oom = kmalloc(sizeof(*bpf_oom), GFP_KERNEL_ACCOUNT);
> +	if (!bpf_oom)
> +		return -ENOMEM;
> +
> +	ret = init_srcu_struct(&bpf_oom->srcu);
> +	if (ret) {
> +		kfree(bpf_oom);
> +		return ret;
> +	}
> +
> +	WRITE_ONCE(bpf_oom->ops, ops);
> +	ops->bpf_oom = bpf_oom;
> +
> +	spin_lock(&bpf_oom_lock);
> +	list_add_rcu(&bpf_oom->node, &bpf_oom_handlers);
> +	spin_unlock(&bpf_oom_lock);
> +
> +	return 0;
> +}
> +
> +static void bpf_oom_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_oom_ops *ops = kdata;
> +	struct bpf_oom *bpf_oom = ops->bpf_oom;
> +
> +	WRITE_ONCE(bpf_oom->ops, NULL);
> +
> +	spin_lock(&bpf_oom_lock);
> +	list_del_rcu(&bpf_oom->node);
> +	spin_unlock(&bpf_oom_lock);
> +
> +	synchronize_srcu(&bpf_oom->srcu);
> +
> +	kfree(bpf_oom);
> +}
> +
> +static int bpf_oom_ops_init_member(const struct btf_type *t,
> +				   const struct btf_member *member,
> +				   void *kdata, const void *udata)
> +{
> +	const struct bpf_oom_ops *uops = (const struct bpf_oom_ops *)udata;
> +	struct bpf_oom_ops *ops = (struct bpf_oom_ops *)kdata;
> +	u32 moff = __btf_member_bit_offset(t, member) / 8;
> +
> +	switch (moff) {
> +	case offsetof(struct bpf_oom_ops, name):
> +		strscpy_pad(ops->name, uops->name, sizeof(ops->name));
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static int bpf_oom_ops_init(struct btf *btf)
> +{
> +	return 0;
> +}
> +
> +static struct bpf_struct_ops bpf_oom_bpf_ops = {
> +	.verifier_ops = &bpf_oom_verifier_ops,
> +	.reg = bpf_oom_ops_reg,
> +	.unreg = bpf_oom_ops_unreg,
> +	.init_member = bpf_oom_ops_init_member,
> +	.init = bpf_oom_ops_init,
> +	.name = "bpf_oom_ops",
> +	.owner = THIS_MODULE,
> +	.cfi_stubs = &__bpf_oom_ops
> +};
> +
> +static int __init bpf_oom_struct_ops_init(void)
> +{
> +	return register_bpf_struct_ops(&bpf_oom_bpf_ops, bpf_oom_ops);
> +}
> +late_initcall(bpf_oom_struct_ops_init);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..ad7bd65061d6 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -45,6 +45,7 @@
>   #include <linux/mmu_notifier.h>
>   #include <linux/cred.h>
>   #include <linux/nmi.h>
> +#include <linux/bpf_oom.h>
>   
>   #include <asm/tlb.h>
>   #include "internal.h"
> @@ -246,6 +247,15 @@ static const char * const oom_constraint_text[] = {
>   	[CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
>   };
>   
> +static const char *oom_policy_name(struct oom_control *oc)
> +{
> +#ifdef CONFIG_BPF_SYSCALL
> +	if (oc->bpf_policy_name)
> +		return oc->bpf_policy_name;
> +#endif
> +	return "default";
> +}
> +
>   /*
>    * Determine the type of allocation constraint.
>    */
> @@ -458,9 +468,10 @@ static void dump_oom_victim(struct oom_control *oc, struct task_struct *victim)
>   
>   static void dump_header(struct oom_control *oc)
>   {
> -	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
> +	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\noom_policy=%s\n",
>   		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
> -			current->signal->oom_score_adj);
> +		current->signal->oom_score_adj,
> +		oom_policy_name(oc));
>   	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
>   		pr_warn("COMPACTION is disabled!!!\n");
>   
> @@ -1161,6 +1172,13 @@ bool out_of_memory(struct oom_control *oc)
>   		return true;
>   	}
>   
> +	/*
> +	 * Let bpf handle the OOM first. If it was able to free up some memory,
> +	 * bail out. Otherwise fall back to the kernel OOM killer.
> +	 */
> +	if (bpf_handle_oom(oc))
> +		return true;
> +
>   	select_bad_process(oc);
>   	/* Found nothing?!?! */
>   	if (!oc->chosen) {


