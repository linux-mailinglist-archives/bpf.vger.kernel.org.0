Return-Path: <bpf+bounces-27438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9903A8AD07F
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E965428A601
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED611534EA;
	Mon, 22 Apr 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4Y9gaGb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFBE152180;
	Mon, 22 Apr 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799361; cv=none; b=BVuc+cTNms2lOpHRe1TjvFAzobvCXMtvCANZMQ99pMuUR8/hoyGGFVqOLmRh2252kGJ0ZCJIONIfgIQBIJk90NExcQlLyqOjQcuQDi0JBGTDXoj994eWCwrAqopi0ZLubaSNpZWgSnVllruqcwfW8Kb6Ca/p4YplDTahyO2o1cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799361; c=relaxed/simple;
	bh=//8KcpjpbvYDgi/6QOo9g1ClZ/5OAjmHm3CIAJSIR9w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Jv1HrTsSu3nCVhbKnfkoMG0tYiPWOv+S+Ih19fQlyoo/Xt8as2ZB9jvqRWOqGvOPIC2Q7QmLVrT/foytkrk1b8j1rluK9sRseKxPIxN5AsgEAYih7nctWiRmDUMnQWv99ysXQ6kXjTvgi9/42D5oQn2KdCgzauFcLGz9jeiYgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4Y9gaGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE60CC113CC;
	Mon, 22 Apr 2024 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799360;
	bh=//8KcpjpbvYDgi/6QOo9g1ClZ/5OAjmHm3CIAJSIR9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t4Y9gaGbcPig7Mdz+LEqNoPlC4cnjArOJwRu5PaTXNJM863eIgFwMZcNkZH2wD+xf
	 kANHiNvsMwpyRee3B8kJFco0aLqPEj9cnwQ7bvQnl+Onc9cuuTAlN0EBqoYqG4GD1K
	 Uq06fxqySyGqrw4bTCBBz3lxoCwSwvQ+w/Moka8jk6OisDm8TCmV1HFjPVLnqP3mM2
	 m4DDvLwuDzyNTM3J4scNNiWJPH+u8HOSTYu7nSEa5MMiqTWBXnRO0Jt6kvr5vllvh8
	 IiXT6yl9ZpmaE5gviSwAwoRJg9AYQFB9plw4gCzSY3pG/zlcO4UnIqAWMR7XdTop3i
	 7X6EKYTKe0ZfQ==
Date: Tue, 23 Apr 2024 00:22:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jonathan Haslam <jonathan.haslam@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, rostedt@goodmis.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uprobes: reduce contention on uprobes_tree access
Message-Id: <20240423002234.6104df82cb3f96c9d485d5b1@kernel.org>
In-Reply-To: <20240422102306.6026-1-jonathan.haslam@gmail.com>
References: <20240422102306.6026-1-jonathan.haslam@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 03:23:05 -0700
Jonathan Haslam <jonathan.haslam@gmail.com> wrote:

> Active uprobes are stored in an RB tree and accesses to this tree are
> dominated by read operations. Currently these accesses are serialized by
> a spinlock but this leads to enormous contention when large numbers of
> threads are executing active probes.
> 
> This patch converts the spinlock used to serialize access to the
> uprobes_tree RB tree into a reader-writer spinlock. This lock type
> aligns naturally with the overwhelmingly read-only nature of the tree
> usage here. Although the addition of reader-writer spinlocks are
> discouraged [0], this fix is proposed as an interim solution while an
> RCU based approach is implemented (that work is in a nascent form). This
> fix also has the benefit of being trivial, self contained and therefore
> simple to backport.
> 
> We have used a uprobe benchmark from the BPF selftests [1] to estimate
> the improvements. Each block of results below show 1 line per execution
> of the benchmark ("the "Summary" line) and each line is a run with one
> more thread added - a thread is a "producer". The lines are edited to
> remove extraneous output.
> 
> The tests were executed with this driver script:
> 
> for num_threads in {1..20}
> do
>   sudo ./bench -a -p $num_threads trig-uprobe-nop | grep Summary
> done
> 
> SPINLOCK (BEFORE)
> ==================
> Summary: hits    1.396 ± 0.007M/s (  1.396M/prod)
> Summary: hits    1.656 ± 0.016M/s (  0.828M/prod)
> Summary: hits    2.246 ± 0.008M/s (  0.749M/prod)
> Summary: hits    2.114 ± 0.010M/s (  0.529M/prod)
> Summary: hits    2.013 ± 0.009M/s (  0.403M/prod)
> Summary: hits    1.753 ± 0.008M/s (  0.292M/prod)
> Summary: hits    1.847 ± 0.001M/s (  0.264M/prod)
> Summary: hits    1.889 ± 0.001M/s (  0.236M/prod)
> Summary: hits    1.833 ± 0.006M/s (  0.204M/prod)
> Summary: hits    1.900 ± 0.003M/s (  0.190M/prod)
> Summary: hits    1.918 ± 0.006M/s (  0.174M/prod)
> Summary: hits    1.925 ± 0.002M/s (  0.160M/prod)
> Summary: hits    1.837 ± 0.001M/s (  0.141M/prod)
> Summary: hits    1.898 ± 0.001M/s (  0.136M/prod)
> Summary: hits    1.799 ± 0.016M/s (  0.120M/prod)
> Summary: hits    1.850 ± 0.005M/s (  0.109M/prod)
> Summary: hits    1.816 ± 0.002M/s (  0.101M/prod)
> Summary: hits    1.787 ± 0.001M/s (  0.094M/prod)
> Summary: hits    1.764 ± 0.002M/s (  0.088M/prod)
> 
> RW SPINLOCK (AFTER)
> ===================
> Summary: hits    1.444 ± 0.020M/s (  1.444M/prod)
> Summary: hits    2.279 ± 0.011M/s (  1.139M/prod)
> Summary: hits    3.422 ± 0.014M/s (  1.141M/prod)
> Summary: hits    3.565 ± 0.017M/s (  0.891M/prod)
> Summary: hits    2.671 ± 0.013M/s (  0.534M/prod)
> Summary: hits    2.409 ± 0.005M/s (  0.401M/prod)
> Summary: hits    2.485 ± 0.008M/s (  0.355M/prod)
> Summary: hits    2.496 ± 0.003M/s (  0.312M/prod)
> Summary: hits    2.585 ± 0.002M/s (  0.287M/prod)
> Summary: hits    2.908 ± 0.011M/s (  0.291M/prod)
> Summary: hits    2.346 ± 0.016M/s (  0.213M/prod)
> Summary: hits    2.804 ± 0.004M/s (  0.234M/prod)
> Summary: hits    2.556 ± 0.001M/s (  0.197M/prod)
> Summary: hits    2.754 ± 0.004M/s (  0.197M/prod)
> Summary: hits    2.482 ± 0.002M/s (  0.165M/prod)
> Summary: hits    2.412 ± 0.005M/s (  0.151M/prod)
> Summary: hits    2.710 ± 0.003M/s (  0.159M/prod)
> Summary: hits    2.826 ± 0.005M/s (  0.157M/prod)
> Summary: hits    2.718 ± 0.001M/s (  0.143M/prod)
> Summary: hits    2.844 ± 0.006M/s (  0.142M/prod)
> 
> The numbers in parenthesis give averaged throughput per thread which is
> of greatest interest here as a measure of scalability. Improvements are
> in the order of 22 - 68% with this particular benchmark (mean = 43%).
> 
> V2:
>  - Updated commit message to include benchmark results.
> 
> [0] https://docs.kernel.org/locking/spinlocks.html
> [1] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/benchs/bench_trigger.c

Thanks for update! This looks good to me.
Let me pick this for probes/for-next.

Thank you,

> 
> Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> ---
>  kernel/events/uprobes.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index e4834d23e1d1..8ae0eefc3a34 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
>   */
>  #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
>  
> -static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
> +static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
>  
>  #define UPROBES_HASH_SZ	13
>  /* serialize uprobe->pending_list */
> @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
>  {
>  	struct uprobe *uprobe;
>  
> -	spin_lock(&uprobes_treelock);
> +	read_lock(&uprobes_treelock);
>  	uprobe = __find_uprobe(inode, offset);
> -	spin_unlock(&uprobes_treelock);
> +	read_unlock(&uprobes_treelock);
>  
>  	return uprobe;
>  }
> @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>  {
>  	struct uprobe *u;
>  
> -	spin_lock(&uprobes_treelock);
> +	write_lock(&uprobes_treelock);
>  	u = __insert_uprobe(uprobe);
> -	spin_unlock(&uprobes_treelock);
> +	write_unlock(&uprobes_treelock);
>  
>  	return u;
>  }
> @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
>  	if (WARN_ON(!uprobe_is_active(uprobe)))
>  		return;
>  
> -	spin_lock(&uprobes_treelock);
> +	write_lock(&uprobes_treelock);
>  	rb_erase(&uprobe->rb_node, &uprobes_tree);
> -	spin_unlock(&uprobes_treelock);
> +	write_unlock(&uprobes_treelock);
>  	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
>  	put_uprobe(uprobe);
>  }
> @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
>  	min = vaddr_to_offset(vma, start);
>  	max = min + (end - start) - 1;
>  
> -	spin_lock(&uprobes_treelock);
> +	read_lock(&uprobes_treelock);
>  	n = find_node_in_range(inode, min, max);
>  	if (n) {
>  		for (t = n; t; t = rb_prev(t)) {
> @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
>  			get_uprobe(u);
>  		}
>  	}
> -	spin_unlock(&uprobes_treelock);
> +	read_unlock(&uprobes_treelock);
>  }
>  
>  /* @vma contains reference counter, not the probed instruction. */
> @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
>  	min = vaddr_to_offset(vma, start);
>  	max = min + (end - start) - 1;
>  
> -	spin_lock(&uprobes_treelock);
> +	read_lock(&uprobes_treelock);
>  	n = find_node_in_range(inode, min, max);
> -	spin_unlock(&uprobes_treelock);
> +	read_unlock(&uprobes_treelock);
>  
>  	return !!n;
>  }
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

