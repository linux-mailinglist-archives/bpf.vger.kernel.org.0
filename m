Return-Path: <bpf+bounces-13655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9B07DC492
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 03:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 309E3B20DFC
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36699468C;
	Tue, 31 Oct 2023 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b/o1OrZs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507D20E0
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 02:38:54 +0000 (UTC)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF55103
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:38:36 -0700 (PDT)
Message-ID: <9e8834b4-bad3-4f92-b699-6780b5410a6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698719914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWA+jPKwKB2RT9+QKVglM2FakZnjYEBpcYtRwKIMCeI=;
	b=b/o1OrZsajfb/2CFx9Yhb5sgSNBMNUTLGtpDGnIGv3mTFxzYbCqSPXUfoVGN7EnFHRteUc
	Q2QHMUdVuxsgDh8wMGkvywxMPJIpIOwsHoEWgnb3+vExQyl31Uy7OtloY+fhpQh1nFjCYk
	XSrXv4FHe+bEsAF/LJRX9JtCR7VHqYI=
Date: Mon, 30 Oct 2023 19:38:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 0/6] Allow bpf_refcount_acquire of mapval
Content-Language: en-GB
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231025214007.2920506-1-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231025214007.2920506-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/25/23 2:40 PM, Dave Marchevsky wrote:
> Consider this BPF program:
>
>    struct cgv_node {
>      int d;
>      struct bpf_refcount r;
>      struct bpf_rb_node rb;
>    };
>
>    struct val_stash {
>      struct cgv_node __kptr *v;
>    };
>
>    struct {
>      __uint(type, BPF_MAP_TYPE_ARRAY);
>      __type(key, int);
>      __type(value, struct val_stash);
>      __uint(max_entries, 10);
>    } array_map SEC(".maps");
>
>    long bpf_program(void *ctx)
>    {
>      struct val_stash *mapval;
>      struct cgv_node *p;
>      int idx = 0;
>
>      mapval = bpf_map_lookup_elem(&array_map, &idx);
>      if (!mapval || !mapval->v) { /* omitted */ }
>
>      p = bpf_refcount_acquire(mapval->v); /* Verification FAILs here */
>
>      /* Add p to some tree */
>      return 0;
>    }
>
> Verification fails on the refcount_acquire:
>
>    160: (79) r1 = *(u64 *)(r8 +8)        ; R1_w=untrusted_ptr_or_null_cgv_node(id=11,off=0,imm=0) R8_w=map_value(id=10,off=0,ks=8,vs=16,imm=0) refs=6
>    161: (b7) r2 = 0                      ; R2_w=0 refs=6
>    162: (85) call bpf_refcount_acquire_impl#117824
>    arg#0 is neither owning or non-owning ref
>
> The above verifier dump is actually from sched_ext's scx_flatcg [0],
> which is the motivating usecase for this series' changes. Specifically,
> scx_flatcg stashes a rb_node type w/ cgroup-specific info (struct
> cgv_node) in a map when the cgroup is created, then later puts that
> cgroup's node in a rbtree in .enqueue . Making struct cgv_node
> refcounted would simplify the code a bit by virtue of allowing us to
> remove the kptr_xchg's, but "later puts that cgroups node in a rbtree"
> is not possible without a refcount_acquire, which suffers from the above
> verification failure.
>
> If we get rid of PTR_UNTRUSTED flag, and add MEM_ALLOC | NON_OWN_REF,
> mapval->v would be a non-owning ref and verification would succeed. Due
> to the most recent set of refcount changes [1], which modified
> bpf_obj_drop behavior to not reuse refcounted graph node's underlying
> memory until after RCU grace period, this is safe to do. Once mapval->v
> has the correct flags it _is_ a non-owning reference and verification of
> the motivating example will succeed.
>
>    [0]: https://github.com/sched-ext/sched_ext/blob/52911e1040a0f94b9c426dddcc00be5364a7ae9f/tools/sched_ext/scx_flatcg.bpf.c#L275
>    [1]: https://lore.kernel.org/bpf/20230821193311.3290257-1-davemarchevsky@fb.com/
>
> Summary of patches:
>    * Patch 1 fixes an issue with bpf_refcount_acquire verification
>      letting MAYBE_NULL ptrs through
>      * Patch 2 tests Patch 1's fix
>    * Patch 3 broadens the use of "free only after RCU GP" to all
>      user-allocated types
>    * Patch 4 is a small nonfunctional refactoring
>    * Patch 5 changes verifier to mark direct LD of stashed graph node
>      kptr as non-owning ref
>      * Patch 6 tests Patch 5's verifier changes
>
> Dave Marchevsky (6):
>    bpf: Add KF_RCU flag to bpf_refcount_acquire_impl
>    selftests/bpf: Add test passing MAYBE_NULL reg to bpf_refcount_acquire
>    bpf: Use bpf_mem_free_rcu when bpf_obj_dropping non-refcounted nodes
>    bpf: Move GRAPH_{ROOT,NODE}_MASK macros into btf_field_type enum
>    bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref
>    selftests/bpf: Test bpf_refcount_acquire of node obtained via direct
>      ld
>
>   include/linux/bpf.h                           |  4 +-
>   kernel/bpf/btf.c                              | 11 ++-
>   kernel/bpf/helpers.c                          |  7 +-
>   kernel/bpf/verifier.c                         | 36 ++++++++--
>   .../bpf/prog_tests/local_kptr_stash.c         | 33 +++++++++
>   .../selftests/bpf/progs/local_kptr_stash.c    | 68 +++++++++++++++++++
>   .../bpf/progs/refcounted_kptr_fail.c          | 19 ++++++
>   7 files changed, 159 insertions(+), 19 deletions(-)
>
The patch looks good to me from high level.

There is a test failure and I added some comment in Patch 5.

Please take a look and address the test failure. Thanks!


