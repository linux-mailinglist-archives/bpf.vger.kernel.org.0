Return-Path: <bpf+bounces-8172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42D7830EF
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 21:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303A11C20994
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2056C11707;
	Mon, 21 Aug 2023 19:33:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3B5684
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 19:33:34 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57241123
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:33 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LJ9tgY016647
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=FdIRfHNoqbALaI5bfc5upM0efQK6E2UQRb0y6HOWQ4c=;
 b=ZXUhAUtg0ro/8deZz5aAlfftcF/SeMl2GpeXeqXQoQD8+dWPEiPBCeT8Afd4jOBr1hYA
 nkmj5USE/zMbj5GVzkFIf5R23T26bC/eARSByWRDC9eCTsWtqEsJVawnrdCh/Q18f3Po
 HLq77HUZ3uIA4yqvEfalib3Cm2SkKdwdVqk= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sjujxxmxp-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:32 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 21 Aug 2023 12:33:21 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 28C2423023EFD; Mon, 21 Aug 2023 12:33:12 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 0/7] BPF Refcount followups 3: bpf_mem_free_rcu refcounted nodes
Date: Mon, 21 Aug 2023 12:33:04 -0700
Message-ID: <20230821193311.3290257-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: s13ztusikXievncy09fkG7KdOsaKPhMn
X-Proofpoint-ORIG-GUID: s13ztusikXievncy09fkG7KdOsaKPhMn
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_08,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series is the third of three (or more) followups to address issues
in the bpf_refcount shared ownership implementation discovered by Kumar.
This series addresses the use-after-free scenario described in [0]. The
first followup series ([1]) also attempted to address the same
use-after-free, but only got rid of the splat without addressing the
underlying issue. After this series the underyling issue is fixed and
bpf_refcount_acquire can be re-enabled.

The main fix here is migration of bpf_obj_drop to use
bpf_mem_free_rcu. To understand why this fixes the issue, let us consider
the example interleaving provided by Kumar in [0]:

CPU 0                                   CPU 1
n =3D bpf_obj_new
lock(lock1)
bpf_rbtree_add(rbtree1, n)
m =3D bpf_rbtree_acquire(n)
unlock(lock1)

kptr_xchg(map, m) // move to map
// at this point, refcount =3D 2
					m =3D kptr_xchg(map, NULL)
					lock(lock2)
lock(lock1)				bpf_rbtree_add(rbtree2, m)
p =3D bpf_rbtree_first(rbtree1)			if (!RB_EMPTY_NODE) bpf_obj_drop_impl(m) =
// A
bpf_rbtree_remove(rbtree1, p)
unlock(lock1)
bpf_obj_drop(p) // B
					bpf_refcount_acquire(m) // use-after-free
					...

Before this series, bpf_obj_drop returns memory to the allocator using
bpf_mem_free. At this point (B in the example) there might be some
non-owning references to that memory which the verifier believes are valid,
but where the underlying memory was reused for some other allocation.
Commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
non-owning refs") attempted to fix this by doing refcount_inc_non_zero
on refcount_acquire in instead of refcount_inc under the assumption that
preventing erroneous incr-on-0 would be sufficient. This isn't true,
though: refcount_inc_non_zero must *check* if the refcount is zero, and
the memory it's checking could have been reused, so the check may look
at and incr random reused bytes.

If we wait to reuse this memory until all non-owning refs that could
point to it are gone, there is no possibility of this scenario
happening. Migrating bpf_obj_drop to use bpf_mem_free_rcu for refcounted
nodes accomplishes this.

For such nodes, the validity of their underlying memory is now tied to
RCU critical section. This matches MEM_RCU trustedness
expectations, so the series takes the opportunity to more explicitly=20
mark this trustedness state.

The functional effects of trustedness changes here are rather small.
This is largely due to local kptrs having separate verifier handling -
with implicit trustedness assumptions - than arbitrary kptrs.
Regardless, let's take the opportunity to move towards a world where
trustedness is more explicitly handled.

Changelog:

v1 -> v2: https://lore.kernel.org/bpf/20230801203630.3581291-1-davemarchevs=
ky@fb.com/

Patch 1 ("bpf: Ensure kptr_struct_meta is non-NULL for collection insert an=
d refcount_acquire")
  * Spent some time experimenting with a better approach as per convo w/
    Yonghong on v1's patch. It started getting too complex, so left unchang=
ed
    for now. Yonghong was fine with this approach being shipped.

Patch 2 ("bpf: Consider non-owning refs trusted")
  * Add Yonghong ack
Patch 3 ("bpf: Use bpf_mem_free_rcu when bpf_obj_dropping refcounted nodes")
  * Add Yonghong ack
Patch 4 ("bpf: Reenable bpf_refcount_acquire")
  * Add Yonghong ack

Patch 5 ("bpf: Consider non-owning refs to refcounted nodes RCU protected")
  * Undo a nonfunctional whitespace change that shouldn't have been included
    (Yonghong)
  * Better logging message when complaining about rcu_read_{lock,unlock} in
    rbtree cb (Alexei)
  * Don't invalidate_non_owning_refs when processing bpf_rcu_read_unlock
    (Yonghong, Alexei)

Patch 6 ("[RFC] bpf: Allow bpf_spin_{lock,unlock} in sleepable prog's RCU C=
S")
  * preempt_{disable,enable} in __bpf_spin_{lock,unlock} (Alexei)
    * Due to this we can consider spin_lock CS an RCU-sched read-side CS (p=
er
      RCU/Design/Requirements/Requirements.rst). Modify in_rcu_cs according=
ly.
  * no need to check for !in_rcu_cs before allowing bpf_spin_{lock,unlock}
    (Alexei)
  * RFC tag removed and renamed to "bpf: Allow bpf_spin_{lock,unlock} in
    sleepable progs"

Patch 7 ("selftests/bpf: Add tests for rbtree API interaction in sleepable =
progs")
  * Remove "no explicit bpf_rcu_read_lock" failure test, add similar success
    test (Alexei)

Summary of patch contents, with sub-bullets being leading questions and
comments I think are worth reviewer attention:

  * Patches 1 and 2 are moreso documententation - and
    enforcement, in patch 1's case - of existing semantics / expectations

  * Patch 3 changes bpf_obj_drop behavior for refcounted nodes such that
    their underlying memory is not reused until RCU grace period elapses
    * Perhaps it makes sense to move to mem_free_rcu for _all_
      non-owning refs in the future, not just refcounted. This might
      allow custom non-owning ref lifetime + invalidation logic to be
      entirely subsumed by MEM_RCU handling. IMO this needs a bit more
      thought and should be tackled outside of a fix series, so it's not
      attempted here.

  * Patch 4 re-enables bpf_refcount_acquire as changes in patch 3 fix
    the remaining use-after-free
    * One might expect this patch to be last in the series, or last
      before selftest changes. Patches 5 and 6 don't change
      verification or runtime behavior for existing BPF progs, though.

  * Patch 5 brings the verifier's understanding of refcounted node
    trustedness in line with Patch 4's changes

  * Patch 6 allows some bpf_spin_{lock, unlock} calls in sleepable
    progs. Marked RFC for a few reasons:
    * bpf_spin_{lock,unlock} haven't been usable in sleepable progs
      since before the introduction of bpf linked list and rbtree. As
      such this feels more like a new feature that may not belong in
      this fixes series.

  * Patch 7 adds tests

  [0]: https://lore.kernel.org/bpf/atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd=
7tnwft34e3@xktodqeqevir/
  [1]: https://lore.kernel.org/bpf/20230602022647.1571784-1-davemarchevsky@=
fb.com/

Dave Marchevsky (7):
  bpf: Ensure kptr_struct_meta is non-NULL for collection insert and
    refcount_acquire
  bpf: Consider non-owning refs trusted
  bpf: Use bpf_mem_free_rcu when bpf_obj_dropping refcounted nodes
  bpf: Reenable bpf_refcount_acquire
  bpf: Consider non-owning refs to refcounted nodes RCU protected
  bpf: Allow bpf_spin_{lock,unlock} in sleepable progs
  selftests/bpf: Add tests for rbtree API interaction in sleepable progs

 include/linux/bpf.h                           |  3 +-
 include/linux/bpf_verifier.h                  |  2 +-
 kernel/bpf/helpers.c                          |  8 ++-
 kernel/bpf/verifier.c                         | 41 ++++++++---
 .../bpf/prog_tests/refcounted_kptr.c          | 26 +++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 71 +++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 28 ++++++++
 7 files changed, 165 insertions(+), 14 deletions(-)

--=20
2.34.1

