Return-Path: <bpf+bounces-14383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9117E3705
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 09:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942BD1F2151B
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC399DF56;
	Tue,  7 Nov 2023 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WzLYWlaC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF67CA4E
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 08:56:56 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEAE10A
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 00:56:53 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A77FrmV012082
	for <bpf@vger.kernel.org>; Tue, 7 Nov 2023 00:56:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=WBRmMCWM3g0FwVbmvJsSNNXGgagOShwruUKVg2TOPfo=;
 b=WzLYWlaCx8dw8gUOBLKptcqt9UhUAsogRyJCBuGa2w96Z4yAsYlFBKEXIqh0Ouhr6afA
 pfiaJdBDJRNQ0cY6T6v8SmZidz0Wwm0ZJyt5nTEK0f1c0KFBeg4uvHUCJQ0k+hYSucn4
 9K+ptkXGbkOkhNOdq9p0D0xoUF356qN5HLI= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7gpbrfhc-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 00:56:52 -0800
Received: from twshared16118.09.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 00:56:50 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 4880B26E3B6F1; Tue,  7 Nov 2023 00:56:40 -0800 (PST)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 0/6] Allow bpf_refcount_acquire of mapval obtained via direct LD
Date: Tue, 7 Nov 2023 00:56:33 -0800
Message-ID: <20231107085639.3016113-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YhmMVE9syS2xmuy04OmYqeJZKBcZ1X_x
X-Proofpoint-GUID: YhmMVE9syS2xmuy04OmYqeJZKBcZ1X_x
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02

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


Changelog:

v1 -> v2: https://lore.kernel.org/bpf/20231025214007.2920506-1-davemarchevs=
ky@fb.com/

Series title changed to "Allow bpf_refcount_acquire of mapval obtained via
direct LD". V1's title was mistakenly truncated.

  * Patch 5 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owni=
ng ref")
    * Direct LD of percpu kptr should not have MEM_ALLOC flag (Yonghong)
  * Patch 6 ("selftests/bpf: Test bpf_refcount_acquire of node obtained via=
 direct ld")
    * Test read from stashed value as well

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
 .../selftests/bpf/progs/local_kptr_stash.c    | 71 +++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 19 +++++
 7 files changed, 162 insertions(+), 19 deletions(-)

--=20
2.34.1

