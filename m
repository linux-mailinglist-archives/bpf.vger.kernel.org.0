Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC7644F54
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLFXKJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLFXKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:09 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDBE42990
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:07 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhKOw020816
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=wfxnHkqNHn/3/1si8yzPfSWKfKX/d5k5FyRfB4cYt5Q=;
 b=LTv8N9UMEIlwE6tNcHUme8td9Xcfl/lR6DioYbLaGX6nYnOYtDLjrX6ewN+VOeFCwTEl
 5sf1F6gj542SVNA+XLWQhba7O4JFGtXIF1VocMHIIn0LiwyQbfbRt7yVhSRKwQ6Vnc6W
 LgO7azN+rqIiEVCo2w0YrUs2y+S3GTCXykA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3m9g8cdf80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:07 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 15:10:06 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id D6D74120B375D; Tue,  6 Dec 2022 15:10:01 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Date:   Tue, 6 Dec 2022 15:09:47 -0800
Message-ID: <20221206231000.3180914-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: T8j2h4qgt1T5-xPD9GJk0EIujU6Es1h2
X-Proofpoint-ORIG-GUID: T8j2h4qgt1T5-xPD9GJk0EIujU6Es1h2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds a rbtree datastructure following the "next-gen
datastructure" precedent set by recently-added linked-list [0]. This is
a reimplementation of previous rbtree RFC [1] to use kfunc + kptr
instead of adding a new map type. This series adds a smaller set of API
functions than that RFC - just the minimum needed to support current
cgfifo example scheduler in ongoing sched_ext effort [2], namely:

  bpf_rbtree_add
  bpf_rbtree_remove
  bpf_rbtree_first

The meat of this series is bugfixes and verifier infra work to support
these API functions. Adding more rbtree kfuncs in future patches should
be straightforward as a result.

BPF rbtree uses struct rb_root_cached + existing rbtree lib under the
hood. From the BPF program writer's perspective, a BPF rbtree is very
similar to existing linked list. Consider the following example:

  struct node_data {
    long key;
    long data;
    struct bpf_rb_node node;
  }

  static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
  {
    struct node_data *node_a;
    struct node_data *node_b;

    node_a =3D container_of(a, struct node_data, node);
    node_b =3D container_of(b, struct node_data, node);

    return node_a->key < node_b->key;
  }

  private(A) struct bpf_spin_lock glock;
  private(A) struct bpf_rb_root groot __contains(node_data, node);

  /* ... in BPF program */
  struct node_data *n, *m;
  struct bpf_rb_node *res;

  n =3D bpf_obj_new(typeof(*n));
  if (!n)
    /* skip */
  n->key =3D 5;
  n->data =3D 10;

  bpf_spin_lock(&glock);
  bpf_rbtree_add(&groot, &n->node, less);
  bpf_spin_unlock(&glock);

  bpf_spin_lock(&glock);
  res =3D bpf_rbtree_first(&groot);
  if (!res)
    /* skip */
  res =3D bpf_rbtree_remove(&groot, res);
  if (!res)
    /* skip */
  bpf_spin_unlock(&glock);

  m =3D container_of(res, struct node_data, node);
  bpf_obj_drop(m);

Some obvious similarities:

  * Special bpf_rb_root and bpf_rb_node types have same semantics
    as bpf_list_head and bpf_list_node, respectively
  * __contains is used to associated node type with root
  * The spin_lock associated with a rbtree must be held when using
    rbtree API kfuncs
  * Nodes are allocated via bpf_obj_new and dropped via bpf_obj_drop
  * Rbtree takes ownership of node lifetime when a node is added.
    Removing a node gives ownership back to the program, requiring a
    bpf_obj_drop before program exit

Some new additions as well:

  * Support for callbacks in kfunc args is added to enable 'less'
    callback use above
  * bpf_rbtree_first's release_on_unlock handling is a bit novel, as
    it's the first next-gen ds API function to release_on_unlock its
    return reg instead of nonexistent node arg
  * Because all references to nodes already added to the rbtree are
    'non-owning', i.e. release_on_unlock and PTR_UNTRUSTED,
    bpf_rbtree_remove must accept such a reference in order to remove it
    from the tree

It seemed better to special-case some 'new additions' verifier logic for
now instead of adding new type flags and concepts, as some of the concept=
s
(e.g. PTR_UNTRUSTED + release_on_unlock) need a refactoring pass before
we pile more on. Regardless, the net-new verifier logic added in this
patchset is minimal. Verifier changes are mostly generaliztion of
existing linked-list logic and some bugfixes.

A note on naming:=20

Some existing list-specific helpers are renamed to 'datastructure_head',
'datastructure_node', etc. Probably a more concise and accurate naming
would be something like 'ng_ds_head' for 'next-gen datastructure'.

For folks who weren't following the conversations over past few months,=20
though, such a naming scheme might seem to indicate that _all_ next-gen
datastructures must have certain semantics, like release_on_unlock,
which aren't necessarily required. For this reason I'd like some
feedback on how to name things.

Summary of patches:

  Patches 1, 2, and 10 are bugfixes which are likely worth applying
  independently of rbtree implementation. Patch 12 is somewhere between
  nice-to-have and bugfix.

  Patches 3 and 4 are nonfunctional refactor/rename.

  Patches 5 - 9 implement the meat of rbtree support in this series,
  gradually building up to implemented kfuncs that verify as expected.
  Patch 11 adds the bpf_rbtree_{add,first,remove} to bpf_experimental.h.

  Patch 13 adds tests.

  [0]: lore.kernel.org/bpf/20221118015614.2013203-1-memxor@gmail.com
  [1]: lore.kernel.org/bpf/20220830172759.4069786-1-davemarchevsky@fb.com
  [2]: lore.kernel.org/bpf/20221130082313.3241517-1-tj@kernel.org

Future work:
  Enabling writes to release_on_unlock refs should be done before the
  functionality of BPF rbtree can truly be considered complete.
  Implementing this proved more complex than expected so it's been
  pushed off to a future patch.

Dave Marchevsky (13):
  bpf: Loosen alloc obj test in verifier's reg_btf_record
  bpf: map_check_btf should fail if btf_parse_fields fails
  bpf: Minor refactor of ref_set_release_on_unlock
  bpf: rename list_head -> datastructure_head in field info types
  bpf: Add basic bpf_rb_{root,node} support
  bpf: Add bpf_rbtree_{add,remove,first} kfuncs
  bpf: Add support for bpf_rb_root and bpf_rb_node in kfunc args
  bpf: Add callback validation to kfunc verifier logic
  bpf: Special verifier handling for bpf_rbtree_{remove, first}
  bpf, x86: BPF_PROBE_MEM handling for insn->off < 0
  bpf: Add bpf_rbtree_{add,remove,first} decls to bpf_experimental.h
  libbpf: Make BTF mandatory if program BTF has spin_lock or alloc_obj
    type
  selftests/bpf: Add rbtree selftests

 arch/x86/net/bpf_jit_comp.c                   | 123 +++--
 include/linux/bpf.h                           |  21 +-
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/btf.c                              | 181 ++++---
 kernel/bpf/helpers.c                          |  75 ++-
 kernel/bpf/syscall.c                          |  33 +-
 kernel/bpf/verifier.c                         | 506 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |  11 +
 tools/lib/bpf/libbpf.c                        |  50 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  24 +
 .../selftests/bpf/prog_tests/linked_list.c    |  12 +-
 .../testing/selftests/bpf/prog_tests/rbtree.c | 184 +++++++
 tools/testing/selftests/bpf/progs/rbtree.c    | 180 +++++++
 .../progs/rbtree_btf_fail__add_wrong_type.c   |  48 ++
 .../progs/rbtree_btf_fail__wrong_node_type.c  |  21 +
 .../testing/selftests/bpf/progs/rbtree_fail.c | 263 +++++++++
 16 files changed, 1549 insertions(+), 194 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_btf_fail__ad=
d_wrong_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_btf_fail__wr=
ong_node_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_fail.c

--=20
2.30.2

