Return-Path: <bpf+bounces-13274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9863C7D76ED
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C7B1C20EEF
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E90234CC0;
	Wed, 25 Oct 2023 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HpjWgAOX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6FF341BD
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 21:41:30 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3D3133
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:29 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39PLfN7Z016371
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=BKz7K5nf0T3MNGGgrsJu9rWvUzOUBfsAtfKJSETIQx8=;
 b=HpjWgAOXfNJjHyUbaPiVUG0TFZaDqTsV5HMDU2A4W8rOzjRDBmEyMKsyylUp8UnY1reg
 pFMKNPQXPUFLCsAnoayYOuSiupdSCSAXTwEBnQreeHTr52+gQUana4eDA94KBWx1NFPb
 +ee0N3zC0jDQOHeCdYMYj63HYt35ZeTQ7To= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ty54a3685-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:28 -0700
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 14:40:19 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id C86AF264D46B6; Wed, 25 Oct 2023 14:40:08 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 0/6] Allow bpf_refcount_acquire of mapval
Date: Wed, 25 Oct 2023 14:40:01 -0700
Message-ID: <20231025214007.2920506-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 74QOejBGZ6idYVbCNxDJlMPyGTKwQIQc
X-Proofpoint-GUID: 74QOejBGZ6idYVbCNxDJlMPyGTKwQIQc
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_11,2023-10-25_01,2023-05-22_02

Consider this BPF program:

  struct cgv_node {
    int d;
    struct bpf_refcount r;
    struct bpf_rb_node rb;
  };=20

  struct val_stash {
    struct cgv_node __kptr *v;
  };

  struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, int);
    __type(value, struct val_stash);
    __uint(max_entries, 10);
  } array_map SEC(".maps");

  long bpf_program(void *ctx)
  {
    struct val_stash *mapval;
    struct cgv_node *p;
    int idx =3D 0;

    mapval =3D bpf_map_lookup_elem(&array_map, &idx);
    if (!mapval || !mapval->v) { /* omitted */ }

    p =3D bpf_refcount_acquire(mapval->v); /* Verification FAILs here */

    /* Add p to some tree */
    return 0;
  }

Verification fails on the refcount_acquire:

  160: (79) r1 =3D *(u64 *)(r8 +8)        ; R1_w=3Duntrusted_ptr_or_null_cg=
v_node(id=3D11,off=3D0,imm=3D0) R8_w=3Dmap_value(id=3D10,off=3D0,ks=3D8,vs=
=3D16,imm=3D0) refs=3D6
  161: (b7) r2 =3D 0                      ; R2_w=3D0 refs=3D6
  162: (85) call bpf_refcount_acquire_impl#117824
  arg#0 is neither owning or non-owning ref

The above verifier dump is actually from sched_ext's scx_flatcg [0],
which is the motivating usecase for this series' changes. Specifically,
scx_flatcg stashes a rb_node type w/ cgroup-specific info (struct
cgv_node) in a map when the cgroup is created, then later puts that
cgroup's node in a rbtree in .enqueue . Making struct cgv_node
refcounted would simplify the code a bit by virtue of allowing us to
remove the kptr_xchg's, but "later puts that cgroups node in a rbtree"
is not possible without a refcount_acquire, which suffers from the above
verification failure.

If we get rid of PTR_UNTRUSTED flag, and add MEM_ALLOC | NON_OWN_REF,
mapval->v would be a non-owning ref and verification would succeed. Due
to the most recent set of refcount changes [1], which modified
bpf_obj_drop behavior to not reuse refcounted graph node's underlying
memory until after RCU grace period, this is safe to do. Once mapval->v
has the correct flags it _is_ a non-owning reference and verification of
the motivating example will succeed.

  [0]: https://github.com/sched-ext/sched_ext/blob/52911e1040a0f94b9c426ddd=
cc00be5364a7ae9f/tools/sched_ext/scx_flatcg.bpf.c#L275
  [1]: https://lore.kernel.org/bpf/20230821193311.3290257-1-davemarchevsky@=
fb.com/

Summary of patches:
  * Patch 1 fixes an issue with bpf_refcount_acquire verification
    letting MAYBE_NULL ptrs through
    * Patch 2 tests Patch 1's fix
  * Patch 3 broadens the use of "free only after RCU GP" to all
    user-allocated types
  * Patch 4 is a small nonfunctional refactoring
  * Patch 5 changes verifier to mark direct LD of stashed graph node
    kptr as non-owning ref
    * Patch 6 tests Patch 5's verifier changes

Dave Marchevsky (6):
  bpf: Add KF_RCU flag to bpf_refcount_acquire_impl
  selftests/bpf: Add test passing MAYBE_NULL reg to bpf_refcount_acquire
  bpf: Use bpf_mem_free_rcu when bpf_obj_dropping non-refcounted nodes
  bpf: Move GRAPH_{ROOT,NODE}_MASK macros into btf_field_type enum
  bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref
  selftests/bpf: Test bpf_refcount_acquire of node obtained via direct
    ld

 include/linux/bpf.h                           |  4 +-
 kernel/bpf/btf.c                              | 11 ++-
 kernel/bpf/helpers.c                          |  7 +-
 kernel/bpf/verifier.c                         | 36 ++++++++--
 .../bpf/prog_tests/local_kptr_stash.c         | 33 +++++++++
 .../selftests/bpf/progs/local_kptr_stash.c    | 68 +++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 19 ++++++
 7 files changed, 159 insertions(+), 19 deletions(-)

--=20
2.34.1


