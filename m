Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8257E693
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiGVSey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiGVSex (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:34:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53917D1D0
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:34:48 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26MHogxu021195
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:34:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=mdd5Xn0uLBaLKg6VZ7JFWAfAh5tcsdt3/j1CX60x5c8=;
 b=IuzNxsJpZPRklIY21vO0Coy4K1qipxAIP+LWzsJ3NcOyawO0mkOzV4GN5H1Bu6yzQpNs
 Nl5SW2h77KBPWxI6mC032Di6bY3hv5gstih1ahmvojqTUqiwRY6x5xGpZhsBImpPa9fd
 qIvB/lEP+sSyLRXDy3bRw/2vMCNbAfAk1E4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hg0n708y0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:34:47 -0700
Received: from twshared1866.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:34:46 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 76D97AB6F176; Fri, 22 Jul 2022 11:34:42 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 00/11] bpf: Introduce rbtree map
Date:   Fri, 22 Jul 2022 11:34:27 -0700
Message-ID: <20220722183438.3319790-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7LWILJ2q7-aR6S_9Cf4hKfVpTtx5tnpa
X-Proofpoint-GUID: 7LWILJ2q7-aR6S_9Cf4hKfVpTtx5tnpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce bpf_rbtree map data structure. As the name implies, rbtree map
allows bpf programs to use red-black trees similarly to kernel code.
Programs interact with rbtree maps in a much more open-coded way than
more classic map implementations. Some example code to demonstrate:

  node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
  if (!node)
    return 0;

  node->one =3D calls;
  node->two =3D 6;
  bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));

  ret =3D (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
  if (!ret) {
    bpf_rbtree_free_node(&rbtree, node);
    goto unlock_ret;
  }

unlock_ret:
  bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
  return 0;


This series is in a heavy RFC state, with some added verifier semantics
needing improvement before they can be considered safe. I am sending
early to gather feedback on approach:

  * Does the API seem reasonable and might it be useful for others?

  * Do new verifier semantics added in this series make logical sense?
    Are there any glaring safety holes aside from those called out in
    individual patches?

Please see individual patches for more in-depth explanation. A quick
summary of patches follows:


Patches 1-3 extend verifier and BTF searching logic in minor ways to
prepare for rbtree implementation patch.
  bpf: Pull repeated reg access bounds check into helper fn
  bpf: Add verifier support for custom callback return range
  bpf: Add rb_node_off to bpf_map


Patch 4 adds basic rbtree map implementation.
  bpf: Add rbtree map

Note that 'complete' implementation requires concepts and changes
introduced in further patches in the series. The series is currently
arranged in this way to ease RFC review.


Patches 5-7 add a spinlock to the rbtree map, with some differing
semantics from existing verifier spinlock handling.
  bpf: Add bpf_spin_lock member to rbtree
  bpf: Add bpf_rbtree_{lock,unlock} helpers
  bpf: Enforce spinlock hold for bpf_rbtree_{add,remove,find}

Notably, rbtree's bpf_spin_lock must be held while manipulating the tree=20
via helpers, while existing spinlock verifier logic prevents any helper
calls while lock is held. In current state this is worked around by not
having the verifier treat rbtree's lock specially in any way. This=20
needs to be improved before leaving RFC state as it's unsafe.


Patch 8 adds the concept of non-owning references, firming up the
semantics of helpers that return a ptr to node which is owned by
a rbtree. See patch 4's summary for additional discussion of node
ownership.


Patch 9 adds a 'conditional release' concept: helpers which release a
resource, but may fail to do so and need to enforce that the BPF program
handles this failure appropriately, namely by freeing the resource
another way.


Path 10 adds 'iter' type flags which teach the verifier to understand
open-coded iteration of a data structure. Specifically, with such flags
the verifier can understand that this loop eventually ends:

  struct node_data *iter =3D (struct node_data *)bpf_rbtree_first(&rbtree=
);

  while (iter) {
    node_ct++;
    iter =3D (struct node_data *)bpf_rbtree_next(&rbtree, iter);
  }

NOTE: Patch 10's logic is currently very unsafe and it's unclear whether
there's a safe path forward that isn't too complex. It's the most RFC-ey
of all the patches.


Patch 11 adds tests. Best to start here to see BPF programs using rbtree
map as intended.


This series is based ontop of "bpf: Cleanup check_refcount_ok" patch,
which was submitted separately [0] and therefore is not included here. Th=
at
patch is likely to be applied before this is out of RFC state, so will
just rebase on newer bpf-next/master.

  [0]: lore.kernel.org/bpf/20220719215536.2787530-1-davemarchevsky@fb.com=
/

Dave Marchevsky (11):
  bpf: Pull repeated reg access bounds check into helper fn
  bpf: Add verifier support for custom callback return range
  bpf: Add rb_node_off to bpf_map
  bpf: Add rbtree map
  bpf: Add bpf_spin_lock member to rbtree
  bpf: Add bpf_rbtree_{lock,unlock} helpers
  bpf: Enforce spinlock hold for bpf_rbtree_{add,remove,find}
  bpf: Add OBJ_NON_OWNING_REF type flag
  bpf: Add CONDITIONAL_RELEASE type flag
  bpf: Introduce PTR_ITER and PTR_ITER_END type flags
  selftests/bpf: Add rbtree map tests

 include/linux/bpf.h                           |  13 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |   2 +
 include/linux/btf.h                           |   1 +
 include/uapi/linux/bpf.h                      | 121 ++++++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/btf.c                              |  21 +
 kernel/bpf/helpers.c                          |  42 +-
 kernel/bpf/rbtree.c                           | 401 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +
 kernel/bpf/verifier.c                         | 382 +++++++++++++++--
 tools/include/uapi/linux/bpf.h                | 121 ++++++
 .../selftests/bpf/prog_tests/rbtree_map.c     | 164 +++++++
 .../testing/selftests/bpf/progs/rbtree_map.c  | 108 +++++
 .../selftests/bpf/progs/rbtree_map_fail.c     | 236 +++++++++++
 .../bpf/progs/rbtree_map_load_fail.c          |  24 ++
 16 files changed, 1605 insertions(+), 37 deletions(-)
 create mode 100644 kernel/bpf/rbtree.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_load_fai=
l.c

--=20
2.30.2

