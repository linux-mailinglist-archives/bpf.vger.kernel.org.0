Return-Path: <bpf+bounces-8210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FCD783868
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA661C209F5
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 03:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013A015AD;
	Tue, 22 Aug 2023 03:18:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD67F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 03:18:23 +0000 (UTC)
Received: from out-52.mta0.migadu.com (out-52.mta0.migadu.com [IPv6:2001:41d0:1004:224b::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19AA13E
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:18:21 -0700 (PDT)
Message-ID: <7aaa5d24-1377-48c4-1ace-b6a2fc79a2d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692674300; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkCw57nJzUmh8KDrnOIyEZOTCYkPrek+oRh9SHBZEdk=;
	b=NCYQZT22t8GrpMel9wHaLauWo1+YbNbc0Ltggk9iQQWpvmD9R6t+pTRfGHiHJhKtpCDeXq
	DyoUdP/a3OKMRi8S0oq49bHhgL2fE8bHetNm0a4wlcgWx1ir0T1jN6wZZNIXj08hYkV6J0
	oeJuIqO6E/vUjjFIY+v7fFWKwAkstUo=
Date: Mon, 21 Aug 2023 20:18:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: Add tests for rbtree API
 interaction in sleepable progs
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-8-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230821193311.3290257-8-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> Confirm that the following sleepable prog states fail verification:
>    * bpf_rcu_read_unlock before bpf_spin_unlock
>       * RCU CS will last at least as long as spin_lock CS

I think the reason is bpf_spin_lock() does not allow any functions
in spin lock region except some graph api kfunc's.

> 
> Also confirm that correct usage passes verification, specifically:
>    * Explicit use of bpf_rcu_read_{lock, unlock} in sleepable test prog
>    * Implied RCU CS due to spin_lock CS
> 
> None of the selftest progs actually attach to bpf_testmod's
> bpf_testmod_test_read.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   .../selftests/bpf/progs/refcounted_kptr.c     | 71 +++++++++++++++++++
>   .../bpf/progs/refcounted_kptr_fail.c          | 28 ++++++++
>   2 files changed, 99 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index c55652fdc63a..893a4fdb4b6e 100644
[...]
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index 0b09e5c915b1..1ef07f6ee580 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> @@ -13,6 +13,9 @@ struct node_acquire {
>   	struct bpf_refcount refcount;
>   };
>   
> +extern void bpf_rcu_read_lock(void) __ksym;
> +extern void bpf_rcu_read_unlock(void) __ksym;
> +
>   #define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
>   private(A) struct bpf_spin_lock glock;
>   private(A) struct bpf_rb_root groot __contains(node_acquire, node);
> @@ -71,4 +74,29 @@ long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
>   	return 0;
>   }
>   
> +SEC("?fentry.s/bpf_testmod_test_read")
> +__failure __msg("function calls are not allowed while holding a lock")
> +int BPF_PROG(rbtree_fail_sleepable_lock_across_rcu,
> +	     struct file *file, struct kobject *kobj,
> +	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
> +{
> +	struct node_acquire *n;
> +
> +	n = bpf_obj_new(typeof(*n));
> +	if (!n)
> +		return 0;
> +
> +	/* spin_{lock,unlock} are in different RCU CS */
> +	bpf_rcu_read_lock();
> +	bpf_spin_lock(&glock);
> +	bpf_rbtree_add(&groot, &n->node, less);
> +	bpf_rcu_read_unlock();
> +
> +	bpf_rcu_read_lock();
> +	bpf_spin_unlock(&glock);
> +	bpf_rcu_read_unlock();
> +
> +	return 0;
> +}
> +
>   char _license[] SEC("license") = "GPL";

