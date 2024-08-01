Return-Path: <bpf+bounces-36224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A12944B2F
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 14:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF3928515A
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81B19FA7B;
	Thu,  1 Aug 2024 12:23:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0017084F;
	Thu,  1 Aug 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515005; cv=none; b=EaH2qJteNwTkk+hz+wcwMf2mh0Ttae2FU2w2gNauQ8l+BaeGNtjkPj4K2heMdUUXRMC6F0CAyMztavR8hxOjfo2vqNzGQm5mHltuw6Oq4p2CHynG2GYIFXam/TnwWXKWqWghm2xbnWxl4d74dN0ioYQ/VDpWugGGdubLVwL5hMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515005; c=relaxed/simple;
	bh=l0eLHzPxT1YwLiSkUcWOVh4i1X5x+NsdGhOM2SEb9Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WX6xdWap0CJaNfttbV6W8JyCeh+Sy8EKdXHBCPNffjpr7XhqP43vNDEAEJcBXQZJGctoi8Bw+7cDvLuGySzOb54e/yGMPVOIGkP2uJ/Mre+33vq5UlU6/n/HmvpTyPAK0n7GB51MOGJVc61mtGo936I7hedI3ZtNYbsMbejA6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZSfh1dmqzyPSc;
	Thu,  1 Aug 2024 20:18:20 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id B742214041B;
	Thu,  1 Aug 2024 20:23:19 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 1 Aug 2024 20:23:18 +0800
Message-ID: <5cf9866c-28bc-8654-07c2-269a95219ada@huawei.com>
Date: Thu, 1 Aug 2024 20:23:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/8] uprobes: protected uprobe lifetime with SRCU
To: Andrii Nakryiko <andrii@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <oleg@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <jolsa@kernel.org>,
	<paulmck@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-4-andrii@kernel.org>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240731214256.3588718-4-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/1 5:42, Andrii Nakryiko 写道:
> To avoid unnecessarily taking a (brief) refcount on uprobe during
> breakpoint handling in handle_swbp for entry uprobes, make find_uprobe()
> not take refcount, but protect the lifetime of a uprobe instance with
> RCU. This improves scalability, as refcount gets quite expensive due to
> cache line bouncing between multiple CPUs.
> 
> Specifically, we utilize our own uprobe-specific SRCU instance for this
> RCU protection. put_uprobe() will delay actual kfree() using call_srcu().
> 
> For now, uretprobe and single-stepping handling will still acquire
> refcount as necessary. We'll address these issues in follow up patches
> by making them use SRCU with timeout.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 93 ++++++++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 38 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 23dde3ec5b09..6d5c3f4b210f 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -41,6 +41,8 @@ static struct rb_root uprobes_tree = RB_ROOT;
>  
>  static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
>  
> +DEFINE_STATIC_SRCU(uprobes_srcu);
> +
>  #define UPROBES_HASH_SZ	13
>  /* serialize uprobe->pending_list */
>  static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
> @@ -59,6 +61,7 @@ struct uprobe {
>  	struct list_head	pending_list;
>  	struct uprobe_consumer	*consumers;
>  	struct inode		*inode;		/* Also hold a ref to inode */
> +	struct rcu_head		rcu;
>  	loff_t			offset;
>  	loff_t			ref_ctr_offset;
>  	unsigned long		flags;
> @@ -612,6 +615,13 @@ static inline bool uprobe_is_active(struct uprobe *uprobe)
>  	return !RB_EMPTY_NODE(&uprobe->rb_node);
>  }
>  
> +static void uprobe_free_rcu(struct rcu_head *rcu)
> +{
> +	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
> +
> +	kfree(uprobe);
> +}
> +
>  static void put_uprobe(struct uprobe *uprobe)
>  {
>  	if (!refcount_dec_and_test(&uprobe->ref))
> @@ -632,6 +642,8 @@ static void put_uprobe(struct uprobe *uprobe)
>  	mutex_lock(&delayed_uprobe_lock);
>  	delayed_uprobe_remove(uprobe, NULL);
>  	mutex_unlock(&delayed_uprobe_lock);
> +
> +	call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
>  }
>  
>  static __always_inline
> @@ -673,33 +685,25 @@ static inline int __uprobe_cmp(struct rb_node *a, const struct rb_node *b)
>  	return uprobe_cmp(u->inode, u->offset, __node_2_uprobe(b));
>  }
>  
> -static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
> +/*
> + * Assumes being inside RCU protected region.
> + * No refcount is taken on returned uprobe.
> + */
> +static struct uprobe *find_uprobe_rcu(struct inode *inode, loff_t offset)
>  {
>  	struct __uprobe_key key = {
>  		.inode = inode,
>  		.offset = offset,
>  	};
> -	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
> -
> -	if (node)
> -		return try_get_uprobe(__node_2_uprobe(node));
> +	struct rb_node *node;
>  
> -	return NULL;
> -}
> -
> -/*
> - * Find a uprobe corresponding to a given inode:offset
> - * Acquires uprobes_treelock
> - */
> -static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> -{
> -	struct uprobe *uprobe;
> +	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
>  
>  	read_lock(&uprobes_treelock);
> -	uprobe = __find_uprobe(inode, offset);
> +	node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
>  	read_unlock(&uprobes_treelock);
>  
> -	return uprobe;
> +	return node ? __node_2_uprobe(node) : NULL;
>  }
>  
>  /*
> @@ -1073,10 +1077,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>  			goto free;
>  		/*
>  		 * We take mmap_lock for writing to avoid the race with
> -		 * find_active_uprobe() which takes mmap_lock for reading.
> +		 * find_active_uprobe_rcu() which takes mmap_lock for reading.
>  		 * Thus this install_breakpoint() can not make
> -		 * is_trap_at_addr() true right after find_uprobe()
> -		 * returns NULL in find_active_uprobe().
> +		 * is_trap_at_addr() true right after find_uprobe_rcu()
> +		 * returns NULL in find_active_uprobe_rcu().
>  		 */
>  		mmap_write_lock(mm);
>  		vma = find_vma(mm, info->vaddr);
> @@ -1885,9 +1889,13 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
>  		return;
>  	}
>  
> +	/* we need to bump refcount to store uprobe in utask */
> +	if (!try_get_uprobe(uprobe))
> +		return;
> +
>  	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
>  	if (!ri)
> -		return;
> +		goto fail;
>  
>  	trampoline_vaddr = uprobe_get_trampoline_vaddr();
>  	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
> @@ -1914,11 +1922,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
>  		}
>  		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
>  	}
> -	 /*
> -	  * uprobe's refcnt is positive, held by caller, so it's safe to
> -	  * unconditionally bump it one more time here
> -	  */
> -	ri->uprobe = get_uprobe(uprobe);
> +	ri->uprobe = uprobe;
>  	ri->func = instruction_pointer(regs);
>  	ri->stack = user_stack_pointer(regs);
>  	ri->orig_ret_vaddr = orig_ret_vaddr;
> @@ -1929,8 +1933,9 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
>  	utask->return_instances = ri;
>  
>  	return;
> - fail:
> +fail:
>  	kfree(ri);
> +	put_uprobe(uprobe);
>  }
>  
>  /* Prepare to single-step probed instruction out of line. */
> @@ -1945,9 +1950,14 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
>  	if (!utask)
>  		return -ENOMEM;
>  
> +	if (!try_get_uprobe(uprobe))
> +		return -EINVAL;
> +
>  	xol_vaddr = xol_get_insn_slot(uprobe);
> -	if (!xol_vaddr)
> -		return -ENOMEM;
> +	if (!xol_vaddr) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
>  
>  	utask->xol_vaddr = xol_vaddr;
>  	utask->vaddr = bp_vaddr;
> @@ -1955,12 +1965,15 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
>  	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
>  	if (unlikely(err)) {
>  		xol_free_insn_slot(current);
> -		return err;
> +		goto err_out;
>  	}
>  
>  	utask->active_uprobe = uprobe;
>  	utask->state = UTASK_SSTEP;
>  	return 0;
> +err_out:
> +	put_uprobe(uprobe);
> +	return err;
>  }
>  
>  /*
> @@ -2044,7 +2057,8 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
>  	return is_trap_insn(&opcode);
>  }
>  
> -static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
> +/* assumes being inside RCU protected region */
> +static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swbp)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct uprobe *uprobe = NULL;
> @@ -2057,7 +2071,7 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
>  			struct inode *inode = file_inode(vma->vm_file);
>  			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
>  
> -			uprobe = find_uprobe(inode, offset);
> +			uprobe = find_uprobe_rcu(inode, offset);
>  		}
>  
>  		if (!uprobe)
> @@ -2201,13 +2215,15 @@ static void handle_swbp(struct pt_regs *regs)
>  {
>  	struct uprobe *uprobe;
>  	unsigned long bp_vaddr;
> -	int is_swbp;
> +	int is_swbp, srcu_idx;
>  
>  	bp_vaddr = uprobe_get_swbp_addr(regs);
>  	if (bp_vaddr == uprobe_get_trampoline_vaddr())
>  		return uprobe_handle_trampoline(regs);
>  
> -	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
> +	srcu_idx = srcu_read_lock(&uprobes_srcu);
> +
> +	uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
>  	if (!uprobe) {
>  		if (is_swbp > 0) {
>  			/* No matching uprobe; signal SIGTRAP. */
> @@ -2223,6 +2239,7 @@ static void handle_swbp(struct pt_regs *regs)
>  			 */
>  			instruction_pointer_set(regs, bp_vaddr);
>  		}
> +		srcu_read_unlock(&uprobes_srcu, srcu_idx);
>  		return;
>  	}
>  
> @@ -2258,12 +2275,12 @@ static void handle_swbp(struct pt_regs *regs)
>  	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>  		goto out;
>  
> -	if (!pre_ssout(uprobe, regs, bp_vaddr))
> -		return;
> +	if (pre_ssout(uprobe, regs, bp_vaddr))
> +		goto out;
>  

Regardless what pre_ssout() returns, it always reach the label 'out', so the
if block is unnecessary.


> -	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
>  out:
> -	put_uprobe(uprobe);
> +	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
> +	srcu_read_unlock(&uprobes_srcu, srcu_idx);
>  }
>  
>  /*

-- 
BR
Liao, Chang

