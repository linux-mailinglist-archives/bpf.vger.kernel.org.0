Return-Path: <bpf+bounces-6673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D76C76C352
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 05:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07145280C11
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 03:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5FA4C;
	Wed,  2 Aug 2023 03:07:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD763EA5
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 03:07:21 +0000 (UTC)
Received: from out-66.mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175BFAC
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:07:18 -0700 (PDT)
Message-ID: <7b99d323-711a-9971-3138-186461fbd245@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690945634; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJt2gIhUr6aV0/XSwzSrKWvC8aXk23/c0YJRkqkiTCc=;
	b=crPT/eY9pVJEZ4eQ6QkgN0plsyRBAGx0YeQDIO0vUeR3W4hBYUimdmW2fMY83fk8XmC1a/
	oS0TdpFg25poIPHZPct7PrMSpmwqnUYUPwC86vB6OSXw9xZoT/UyczEOLnneod8R3Be9ll
	baNQyq92idVBbPMy6C+d+YBUcsf62DA=
Date: Tue, 1 Aug 2023 20:07:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v1 bpf-next 0/7] BPF Refcount followups 3:
 bpf_mem_free_rcu refcounted nodes
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801203630.3581291-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 1:36 PM, Dave Marchevsky wrote:
> This series is the third of three (or more) followups to address issues
> in the bpf_refcount shared ownership implementation discovered by Kumar.
> This series addresses the use-after-free scenario described in [0]. The
> first followup series ([1]) also attempted to address the same
> use-after-free, but only got rid of the splat without addressing the
> underlying issue. After this series the underyling issue is fixed and
> bpf_refcount_acquire can be re-enabled.
> 
> The main fix here is migration of bpf_obj_drop to use
> bpf_mem_free_rcu. To understand why this fixes the issue, let us consider
> the example interleaving provided by Kumar in [0]:
> 
> CPU 0                                   CPU 1
> n = bpf_obj_new
> lock(lock1)
> bpf_rbtree_add(rbtree1, n)
> m = bpf_rbtree_acquire(n)
> unlock(lock1)
> 
> kptr_xchg(map, m) // move to map
> // at this point, refcount = 2
> 					m = kptr_xchg(map, NULL)
> 					lock(lock2)
> lock(lock1)				bpf_rbtree_add(rbtree2, m)

On the right column: bpf_rbtree_add(rbtree1, m) ?

> p = bpf_rbtree_first(rbtree1)			if (!RB_EMPTY_NODE) bpf_obj_drop_impl(m) // A
> bpf_rbtree_remove(rbtree1, p)
> unlock(lock1)
> bpf_obj_drop(p) // B
> 					bpf_refcount_acquire(m) // use-after-free
> 					...
> 
> Before this series, bpf_obj_drop returns memory to the allocator using
> bpf_mem_free. At this point (B in the example) there might be some
> non-owning references to that memory which the verifier believes are valid,
> but where the underlying memory was reused for some other allocation.
> Commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
> non-owning refs") attempted to fix this by doing refcount_inc_non_zero
> on refcount_acquire in instead of refcount_inc under the assumption that
> preventing erroneous incr-on-0 would be sufficient. This isn't true,
> though: refcount_inc_non_zero must *check* if the refcount is zero, and
> the memory it's checking could have been reused, so the check may look
> at and incr random reused bytes.
> 
> If we wait to reuse this memory until all non-owning refs that could
> point to it are gone, there is no possibility of this scenario
> happening. Migrating bpf_obj_drop to use bpf_mem_free_rcu for refcounted
> nodes accomplishes this.
> 
> For such nodes, the validity of their underlying memory is now tied to
> RCU Tasks Trace critical section. This matches MEM_RCU trustedness
> expectations, so the series takes the opportunity to more explicitly
> mark this trustedness state.
> 
> The functional effects of trustedness changes here are rather small.
> This is largely due to local kptrs having separate verifier handling -
> with implicit trustedness assumptions - than arbitrary kptrs.
> Regardless, let's take the opportunity to move towards a world where
> trustedness is more explictly handled.
> 
> Summary of patch contents, with sub-bullets being leading questions and
> comments I think are worth reviewer attention:
> 
>    * Patches 1 and 2 are moreso documententation - and
>      enforcement, in patch 1's case - of existing semantics / expectations
> 
>    * Patch 3 changes bpf_obj_drop behavior for refcounted nodes such that
>      their underlying memory is not reused until RCU grace period elapses
>      * Perhaps it makes sense to move to mem_free_rcu for _all_
>        non-owning refs in the future, not just refcounted. This might
>        allow custom non-owning ref lifetime + invalidation logic to be
>        entirely subsumed by MEM_RCU handling. IMO this needs a bit more
>        thought and should be tackled outside of a fix series, so it's not
>        attempted here.
> 
>    * Patch 4 re-enables bpf_refcount_acquire as changes in patch 3 fix
>      the remaining use-after-free
>      * One might expect this patch to be last in the series, or last
>        before selftest changes. Patches 5 and 6 don't change
>        verification or runtime behavior for existing BPF progs, though.
> 
>    * Patch 5 brings the verifier's understanding of refcounted node
>      trustedness in line with Patch 4's changes
> 
>    * Patch 6 allows some bpf_spin_{lock, unlock} calls in sleepable
>      progs. Marked RFC for a few reasons:
>      * bpf_spin_{lock,unlock} haven't been usable in sleepable progs
>        since before the introduction of bpf linked list and rbtree. As
>        such this feels more like a new feature that may not belong in
>        this fixes series.
>      * If we do want to allow bpf_spin_{lock,unlock} in sleepable progs,
>        Alexei has expressed a preference for that do be done as part of a
>        broader set of changes to verifier determination of where those
>        helpers can be called, and what can be called inside the spin_lock
>        CS.
>      * I'm unsure whether preemption needs to be disabled in this patch
>        as well.
> 
>    * Patch 7 adds tests
> 
>    [0]: https://lore.kernel.org/bpf/atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd7tnwft34e3@xktodqeqevir/
>    [1]: https://lore.kernel.org/bpf/20230602022647.1571784-1-davemarchevsky@fb.com/
> 
> Dave Marchevsky (7):
>    bpf: Ensure kptr_struct_meta is non-NULL for collection insert and
>      refcount_acquire
>    bpf: Consider non-owning refs trusted
>    bpf: Use bpf_mem_free_rcu when bpf_obj_dropping refcounted nodes
>    bpf: Reenable bpf_refcount_acquire
>    bpf: Consider non-owning refs to refcounted nodes RCU protected
>    [RFC] bpf: Allow bpf_spin_{lock,unlock} in sleepable prog's RCU CS
>    selftests/bpf: Add tests for rbtree API interaction in sleepable progs
> 
>   include/linux/bpf.h                           |  3 +-
>   include/linux/bpf_verifier.h                  |  2 +-
>   kernel/bpf/helpers.c                          |  6 ++-
>   kernel/bpf/verifier.c                         | 45 ++++++++++++-----
>   .../bpf/prog_tests/refcounted_kptr.c          | 26 ++++++++++
>   .../selftests/bpf/progs/refcounted_kptr.c     | 37 ++++++++++++++
>   .../bpf/progs/refcounted_kptr_fail.c          | 48 +++++++++++++++++++
>   7 files changed, 153 insertions(+), 14 deletions(-)
> 

