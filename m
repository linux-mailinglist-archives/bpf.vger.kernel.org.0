Return-Path: <bpf+bounces-77-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B06F7B06
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 04:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978101C21622
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105B1376;
	Fri,  5 May 2023 02:34:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD0EDE
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 02:34:36 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1D11D93
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:34:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64115e652eeso16727895b3a.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 19:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683254071; x=1685846071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25rkrn34KHrA/if1bOzlpHJ6lQ0YdW/P+GESLFE5Ug0=;
        b=cDPfIOd+ciz1/yUGHE6eMCIXj0/uMocXICa/gd6D4OvP1LWczzuujDTakRH2l5VK/n
         6lN6hH2r+hDUmkKkdWQP7uYDxoueN8FlPCy61dc+Ty3TDAEmmr3sgYgeLR5Em9DMWqxB
         1pSyku5eoqGS+b/VflDrsoJqPewenyE+8zWzSOk47T4dvGegbIkW9ucNUesCS+FyfgFm
         q+wvnmA+M+R/wGkIyqHAVVaPkPqbeqcNCSSCVDBuJbaHWcCrHmZdmuciBZbd2H6SbG0S
         HtFyV4j9puSOF1TvGVaj7PwksbEqy/r0PaCapZWtkrY/7GlHHdr9d7mvIz3jp/7Dk//z
         i/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683254071; x=1685846071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25rkrn34KHrA/if1bOzlpHJ6lQ0YdW/P+GESLFE5Ug0=;
        b=WTjOnAYG/oMcHxnrvfOvzOaw8ZJJFtzim5bU/wwFfRg960LebXIfnTt1bGvpjG3lWy
         zuHYYy2pL5vmEzTcsP0ZhXW/hnX9uIj1J6VGRE5jy0SjR7R5KHJLA6LW/ohINI6WuyO5
         IJpdkIzRJra5EKXtkwCpE1pQo/kupGfgS8B8JZl01bOVjDLnz3Efnsx/FBS95MFnIEZ5
         FPYazcgjG2nkFRJXl5wFWcFrS0QdDWFIjJzVNwfvdxyOEBwnweuQ3bbBIPaKdz3DlcAo
         IjLdgCHpcy3tyaHrkI3ENk5e4GwIPXFmTnN7swGpR+O8xGySYPeqzXtcDH8/hJMdIKDz
         g2OA==
X-Gm-Message-State: AC+VfDxtKCJ2PtM9IqTRdHPDDpEY7dlYrcQuEnt6OC4yEcHjR1ilEevs
	u8iDnEv1EQaeynKF+9PBOgg=
X-Google-Smtp-Source: ACHHUZ5PUeG8cAHrlnHo6mQWsySflTfPiGUht+0LRRbvP7uHMJkM3MN4AZV7ygqtdcEfkjNTWJb9uQ==
X-Received: by 2002:a17:903:230b:b0:1a9:6a10:70e9 with SMTP id d11-20020a170903230b00b001a96a1070e9mr49908plh.33.1683254071014;
        Thu, 04 May 2023 19:34:31 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:cce7])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902b11800b001a6ed2d0ef8sm311148plr.273.2023.05.04.19.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 19:34:29 -0700 (PDT)
Date: Thu, 4 May 2023 19:34:26 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v1 bpf-next 7/9] selftests/bpf: Add test exercising
 bpf_refcount_acquire race condition
Message-ID: <20230505023426.wneskblqiha3agio@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230504053338.1778690-1-davemarchevsky@fb.com>
 <20230504053338.1778690-8-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504053338.1778690-8-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 03, 2023 at 10:33:36PM -0700, Dave Marchevsky wrote:
> The selftest added in this patch is the exact scenario described by
> Kumar in [0] and fixed by earlier patches in this series. The long
> comment added in progs/refcounted_kptr.c restates the use-after-free
> scenario.
> 
> The added test uses bpf__unsafe_spin_{lock, unlock} to force the
> specific problematic interleaving we're interested in testing, and
> bpf_refcount_read to confirm refcount incr/decr work as expected.
> 
>   [0]: https://lore.kernel.org/bpf/atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd7tnwft34e3@xktodqeqevir/
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../bpf/prog_tests/refcounted_kptr.c          | 104 +++++++++++-
>  .../selftests/bpf/progs/refcounted_kptr.c     | 158 ++++++++++++++++++
>  2 files changed, 261 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> index 2ab23832062d..e7fcc1dd8864 100644
> --- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> -
> +#define _GNU_SOURCE
>  #include <test_progs.h>
>  #include <network_helpers.h>
> +#include <pthread.h>
> +#include <sched.h>
>  
>  #include "refcounted_kptr.skel.h"
>  #include "refcounted_kptr_fail.skel.h"
> @@ -16,3 +18,103 @@ void test_refcounted_kptr_fail(void)
>  {
>  	RUN_TESTS(refcounted_kptr_fail);
>  }
> +
> +static void force_cpu(pthread_t thread, int cpunum)
> +{
> +	cpu_set_t cpuset;
> +	int err;
> +
> +	CPU_ZERO(&cpuset);
> +	CPU_SET(cpunum, &cpuset);
> +	err = pthread_setaffinity_np(thread, sizeof(cpuset), &cpuset);
> +	if (!ASSERT_OK(err, "pthread_setaffinity_np"))
> +		return;
> +}
> +
> +struct refcounted_kptr *skel;
> +
> +static void *run_unstash_acq_ref(void *unused)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.data_in = &pkt_v4,
> +		.data_size_in = sizeof(pkt_v4),
> +		.repeat = 1,
> +	);
> +	long ret, unstash_acq_ref_fd;
> +	force_cpu(pthread_self(), 1);
> +
> +	unstash_acq_ref_fd = bpf_program__fd(skel->progs.unstash_add_and_acquire_refcount);
> +
> +	ret = bpf_prog_test_run_opts(unstash_acq_ref_fd, &opts);
> +	ASSERT_EQ(opts.retval, 0, "unstash_add_and_acquire_refcount retval");
> +	ASSERT_EQ(skel->bss->ref_check_3, 2, "ref_check_3");
> +	ASSERT_EQ(skel->bss->ref_check_4, 1, "ref_check_4");
> +	ASSERT_EQ(skel->bss->ref_check_5, 0, "ref_check_5");
> +	pthread_exit((void *)ret);
> +}
> +
> +void test_refcounted_kptr_races(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.data_in = &pkt_v4,
> +		.data_size_in = sizeof(pkt_v4),
> +		.repeat = 1,
> +	);
> +	int ref_acq_lock_fd, ref_acq_unlock_fd, rem_node_lock_fd;
> +	int add_stash_fd, remove_tree_fd;
> +	pthread_t thread_id;
> +	int ret;
> +
> +	force_cpu(pthread_self(), 0);
> +	skel = refcounted_kptr__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
> +		return;
> +
> +	add_stash_fd = bpf_program__fd(skel->progs.add_refcounted_node_to_tree_and_stash);
> +	remove_tree_fd = bpf_program__fd(skel->progs.remove_refcounted_node_from_tree);
> +	ref_acq_lock_fd = bpf_program__fd(skel->progs.unsafe_ref_acq_lock);
> +	ref_acq_unlock_fd = bpf_program__fd(skel->progs.unsafe_ref_acq_unlock);
> +	rem_node_lock_fd = bpf_program__fd(skel->progs.unsafe_rem_node_lock);
> +
> +	ret = bpf_prog_test_run_opts(rem_node_lock_fd, &opts);
> +	if (!ASSERT_OK(ret, "rem_node_lock"))
> +		return;
> +
> +	ret = bpf_prog_test_run_opts(ref_acq_lock_fd, &opts);
> +	if (!ASSERT_OK(ret, "ref_acq_lock"))
> +		return;
> +
> +	ret = bpf_prog_test_run_opts(add_stash_fd, &opts);
> +	if (!ASSERT_OK(ret, "add_stash"))
> +		return;
> +	if (!ASSERT_OK(opts.retval, "add_stash retval"))
> +		return;
> +
> +	ret = pthread_create(&thread_id, NULL, &run_unstash_acq_ref, NULL);
> +	if (!ASSERT_OK(ret, "pthread_create"))
> +		goto cleanup;
> +
> +	force_cpu(thread_id, 1);
> +
> +	/* This program will execute before unstash_acq_ref's refcount_acquire, then
> +	 * unstash_acq_ref can proceed after unsafe_unlock
> +	 */
> +	ret = bpf_prog_test_run_opts(remove_tree_fd, &opts);
> +	if (!ASSERT_OK(ret, "remove_tree"))
> +		goto cleanup;
> +
> +	ret = bpf_prog_test_run_opts(ref_acq_unlock_fd, &opts);
> +	if (!ASSERT_OK(ret, "ref_acq_unlock"))
> +		goto cleanup;
> +
> +	ret = pthread_join(thread_id, NULL);
> +	if (!ASSERT_OK(ret, "pthread_join"))
> +		goto cleanup;
> +
> +	refcounted_kptr__destroy(skel);
> +	return;
> +cleanup:
> +	bpf_prog_test_run_opts(ref_acq_unlock_fd, &opts);
> +	refcounted_kptr__destroy(skel);
> +	return;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index a3da610b1e6b..2951f45291c1 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -39,9 +39,20 @@ private(A) struct bpf_spin_lock lock;
>  private(A) struct bpf_rb_root root __contains(node_data, r);
>  private(A) struct bpf_list_head head __contains(node_data, l);
>  
> +private(C) struct bpf_spin_lock lock2;
> +private(C) struct bpf_rb_root root2 __contains(node_data, r);
> +
>  private(B) struct bpf_spin_lock alock;
>  private(B) struct bpf_rb_root aroot __contains(node_acquire, node);
>  
> +private(D) struct bpf_spin_lock ref_acq_lock;
> +private(E) struct bpf_spin_lock rem_node_lock;
> +
> +/* Provided by bpf_testmod */
> +extern void bpf__unsafe_spin_lock(void *lock__ign) __ksym;
> +extern void bpf__unsafe_spin_unlock(void *lock__ign) __ksym;
> +extern volatile int bpf_refcount_read(void *refcount__ign) __ksym;
> +
>  static bool less(struct bpf_rb_node *node_a, const struct bpf_rb_node *node_b)
>  {
>  	struct node_data *a;
> @@ -405,4 +416,151 @@ long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
>  	return 0;
>  }
>  
> +SEC("tc")
> +long unsafe_ref_acq_lock(void *ctx)
> +{
> +	bpf__unsafe_spin_lock(&ref_acq_lock);
> +	return 0;
> +}
> +
> +SEC("tc")
> +long unsafe_ref_acq_unlock(void *ctx)
> +{
> +	bpf__unsafe_spin_unlock(&ref_acq_lock);
> +	return 0;
> +}
> +
> +SEC("tc")
> +long unsafe_rem_node_lock(void *ctx)
> +{
> +	bpf__unsafe_spin_lock(&rem_node_lock);
> +	return 0;
> +}
> +
> +/* The following 3 progs are used in concert to test a bpf_refcount-related
> + * race. Consider the following pseudocode interleaving of rbtree operations:
> + *
> + * (Assumptions: n, m, o, p, q are pointers to nodes, t1 and t2 are different
> + * rbtrees, l1 and l2 are locks accompanying the trees, mapval is some
> + * kptr_xchg'able ptr_to_map_value. A single node is being manipulated by both
> + * programs. Irrelevant error-checking and casting is omitted.)
> + *
> + *               CPU O                               CPU 1
> + *     ----------------------------------|---------------------------
> + *     n = bpf_obj_new  [0]              |
> + *     lock(l1)                          |
> + *     bpf_rbtree_add(t1, &n->r, less)   |
> + *     m = bpf_refcount_acquire(n)  [1]  |
> + *     unlock(l1)                        |
> + *     kptr_xchg(mapval, m)         [2]  |
> + *     --------------------------------------------------------------
> + *                                       |    o = kptr_xchg(mapval, NULL)  [3]
> + *                                       |    lock(l2)
> + *                                       |    rbtree_add(t2, &o->r, less)  [4]
> + *     --------------------------------------------------------------
> + *     lock(l1)                          |
> + *     p = rbtree_first(t1)              |
> + *     p = rbtree_remove(t1, p)          |
> + *     unlock(l1)                        |
> + *     if (p)                            |
> + *       bpf_obj_drop(p)  [5]            |
> + *     --------------------------------------------------------------
> + *                                       |    q = bpf_refcount_acquire(o)  [6]
> + *                                       |    unlock(l2)
> + *
> + * If bpf_refcount_acquire can't fail, the sequence of operations on the node's
> + * refcount is:
> + *    [0] - refcount initialized to 1
> + *    [1] - refcount bumped to 2
> + *    [2] - refcount is still 2, but m's ownership passed to mapval
> + *    [3] - refcount is still 2, mapval's ownership passed to o
> + *    [4] - refcount is decr'd to 1, rbtree_add fails, node is already in t1
> + *          o is converted to non-owning reference
> + *    [5] - refcount is decr'd to 0, node free'd
> + *    [6] - refcount is incr'd to 1 from 0, ERROR
> + *
> + * To prevent [6] bpf_refcount_acquire was made failable. This interleaving is
> + * used to test failable refcount_acquire.
> + *
> + * The two halves of CPU 0's operations are implemented by
> + * add_refcounted_node_to_tree_and_stash and remove_refcounted_node_from_tree.
> + * We can't do the same for CPU 1's operations due to l2 critical section.
> + * Instead, bpf__unsafe_spin_{lock, unlock} are used to ensure the expected
> + * order of operations.
> + */
> +
> +SEC("tc")
> +long add_refcounted_node_to_tree_and_stash(void *ctx)
> +{
> +	long err;
> +
> +	err = __stash_map_insert_tree(0, 42, &root, &lock);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +SEC("tc")
> +long remove_refcounted_node_from_tree(void *ctx)
> +{
> +	long ret = 0;
> +
> +	/* rem_node_lock is held by another program to force race */
> +	bpf__unsafe_spin_lock(&rem_node_lock);
> +	ret = __read_from_tree(&root, &lock, true);
> +	if (ret != 42)
> +		return ret;
> +
> +	bpf__unsafe_spin_unlock(&rem_node_lock);
> +	return 0;
> +}
> +
> +/* ref_check_n numbers correspond to refcount operation points in comment above */
> +int ref_check_3, ref_check_4, ref_check_5;
> +
> +SEC("tc")
> +long unstash_add_and_acquire_refcount(void *ctx)
> +{
> +	struct map_value *mapval;
> +	struct node_data *n, *m;
> +	int idx = 0;
> +
> +	mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
> +	if (!mapval)
> +		return -1;
> +
> +	n = bpf_kptr_xchg(&mapval->node, NULL);
> +	if (!n)
> +		return -2;
> +	ref_check_3 = bpf_refcount_read(&n->ref);
> +
> +	bpf_spin_lock(&lock2);
> +	bpf_rbtree_add(&root2, &n->r, less);
> +	ref_check_4 = bpf_refcount_read(&n->ref);
> +
> +	/* Let CPU 0 do first->remove->drop */
> +	bpf__unsafe_spin_unlock(&rem_node_lock);
> +
> +	/* ref_acq_lock is held by another program to force race
> +	 * when this program holds the lock, remove_refcounted_node_from_tree
> +	 * has finished
> +	 */
> +	bpf__unsafe_spin_lock(&ref_acq_lock);
> +	ref_check_5 = bpf_refcount_read(&n->ref);
> +
> +	/* Error-causing use-after-free incr ([6] in long comment above) */
> +	m = bpf_refcount_acquire(n);
> +	bpf__unsafe_spin_unlock(&ref_acq_lock);
> +
> +	bpf_spin_unlock(&lock2);
> +
> +	if (m) {
> +		bpf_obj_drop(m);
> +		return -3;
> +	}
> +
> +	return !!m;

This is truly impressive, but we cannot land it. I'd like to salvage it, but I don't see how.
It has to stay of out tree.
Also I don't think we have to craft test cases for races where we manually control CPU execution
with spin_lock-s like here or potentially with semaphores and sleepable bpf progs.
Surely we need a test for the path where bpf_refcount_acquire_impl() does refcount_inc_not_zero()
and returns NULL, but I suspect it can be crafted as normal test without races.

