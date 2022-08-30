Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F55A6B2E
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiH3RtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiH3Rsk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:48:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFE0A6C45
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:45:36 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UG2DWZ009515
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:28:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=zrM7KTVrr+QPlaR/93gSe6NgQlu4pzIF5BpYHRQGPuQ=;
 b=VugUntD7sicmM9qnY7vJNN6HM3KhYeZ4gi20P/6irefOp70mlOQPjnDdE86HXGL6jyu6
 XF8GZ952Uh8nyCoL2bKgLAeXkQJVbeMUC/TygujVBS6bKp/X6HIiHYLT9A1NUYsCwfi6
 QyP44vzLztdvuV6t/zxvBpP1L+1I0eaqOvc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j94gye1jk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:28:16 -0700
Received: from twshared8288.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:28:15 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 2FF45CAD0729; Tue, 30 Aug 2022 10:28:03 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 00/18] bpf: Introduce rbtree map
Date:   Tue, 30 Aug 2022 10:27:41 -0700
Message-ID: <20220830172759.4069786-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: scoNdbSwlw4qIcJNwrTWMW35_JnCwOLp
X-Proofpoint-GUID: scoNdbSwlw4qIcJNwrTWMW35_JnCwOLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ RFCv2: This RFC focuses on locking improvements. Some feedback from RFC=
v1
feedback and other discussions is not yet applied e.g. conversion to kfun=
cs,
dropping open-coded iter. This isn't meant to imply that I disagree with =
this
feedback, but rather want to make it easier to compare locking changes to
RFCv1. Please see changelog at end of this cover letter for a list of
newly-added patches and major changes worth looking at ]

Introduce a new map type, bpf_rbtree_map, allowing BPF programs to
create and manipulate rbtree data structures. bpf_rbtree_map differs
from 'classic' BPF map patterns in a few important ways:

  * The map does not allocate its own elements. Instead,
    BPF programs must call bpf_rbtree_alloc_node helper to allocate and
    bpf_rbtree_add to add map elem - referred to as 'node' from now on -
    to the rbtree. This means that rbtree maps can grow dynamically, do
    not preallocate, and that 'max_entries' has no meaning for rbtree
    maps.
    * Separating allocation and insertion allows alloc_node call to
      occur in contexts where it's safe to allocate.

  * It's possible to remove a node from a rbtree map with
    bpf_rbtree_remove helper.
    * Goal here is to allow a node to be removed from one rbtree and
      added to another
      [ NOTE: This functionality is still in progress ]

Helpers are added to manipulate nodes and trees:
  * bpf_rbtree_{alloc,free}_node: Allocate / free node structs
  * bpf_rbtree_{add,remove}: Add / remove nodes from rbtree maps
    * A comparator function is passed to bpf_rbtree_add in order to
      find the correct place to add the node.
  * bpf_rbtree_find: Find a node matching some condition in the rbtree
    * A comparator function is passed in order to determine whether a
      node matches what's being searched for.

bpf_rbtree_add is very similar to the 'map_push_elem' builtin, but since
verifier needs special logic to setup the comparator callback a new
helper is added. Same for bpf_rbtree_find and 'map_lookup_elem' builtin.

In order to safely support separate allocation / insertion and passing
nodes between rbtrees, some invariants must hold:

  * A node that is not in a rbtree map must either be free'd or added to
    a rbtree map before the program terminates
    * Nodes are in this state when returned from bpf_rbtree_alloc_node
      or bpf_rbtree_remove.

If a node is in a rbtree map it is 'owned' by the map, otherwise it is
owned by the BPF program which holds a reference to it. Owner is
responsible for the lifetime of the node.

This matches existing acquire / release semantics well. node_alloc and
remove operations 'acquire' a node while add and node_free operations
'release' the node. The verifier enforces that acquired nodes are
released before program terminates.

Some other implementation details:

  * The value type of an rbtree map is expected to be a struct which
    contains 'struct rb_node' at offset 0.
  * BPF programs may not modify the node struct's rb_node field.
    * Otherwise the tree could be left in corrupted state
  * Rbtree map is value-only. Keys have no meaning
  * Since the value type is not known until the rbtree map is
    instantiated, helper protos have input and return type
    'struct rb_node *' which verifier replaces with actual
    map value type.
  * [ TODO: Existing logic prevents any writes to PTR_TO_BTF_ID. This
    broadly turned off in this patch and replaced with "no writes to
    struct rb_node is PTR_TO_BTF_ID struct has one". This is a hack and
    needs to be replaced. ]

Changelog:

RFCv1 -> RFCv2: lore.kernel.org/bpf/20220722183438.3319790-1-davemarchevs=
ky@fb.com
Major changes:
  * Add new patch ("bpf: Add verifier check for BPF_PTR_POISON retval and=
 arg"),
    use BPF_PTR_POISON as placeholder btf_id for helpers which return or
    manipulate structs which contain rbtree node. (Alexei)
    * Migrate all rbtree helpers to use BPF_PTR_POISON
    * Testing this patch uncovered that rbtree_find was not in
      function_returns_rbtree_node check, add it. Rbtree_add was not
      setting a return btf_id type, fix that as well.

  * Add new patch ("libbpf: Add support for private BSS map section")
    allowing struct bpf_spin_lock declaration in special internal map

  * Add new patches improving ergonomics of associating lock with rbtree(=
1),
    teaching verifier to track rbtree locks(2), and teaching verifier to =
reject
    programs calling rbtree helpers without holding the necessary lock
    * (1): "bpf: Support declarative association of lock with rbtree map"=
 (3)
    * (2): "bpf: Verifier tracking of rbtree_spin_lock held"
    * (3): "bpf: Check rbtree lock held during verification"
    * These are the changes most worth a look. Each commit has associated=
 test
      change patch also added at the end of the series. Test patches are =
left
      unsquashed to ease RFC review.

Minor changes:
  * patch "bpf: Add rbtree map"
    * Alloc nodes w/ GFP_NOWAIT instead of GFP_KERNEL (Yonghong, Alexei)
    * Rename access_may_touch_field -> access_can_write_field (Alexei)
  * patch "bpf: Add CONDITIONAL_RELEASE type flag"
    * No need to return int from mark_ptr_or_null_regs, go back to return=
ing
      void (Alexei)

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Dave Marchevsky (18):
  bpf: Add verifier support for custom callback return range
  bpf: Add verifier check for BPF_PTR_POISON retval and arg
  bpf: Add rb_node_off to bpf_map
  bpf: Add rbtree map
  libbpf: Add support for private BSS map section
  bpf: Add bpf_spin_lock member to rbtree
  bpf: Add bpf_rbtree_{lock,unlock} helpers
  bpf: Enforce spinlock hold for bpf_rbtree_{add,remove,find}
  bpf: Support declarative association of lock with rbtree map
  bpf: Verifier tracking of rbtree_spin_lock held
  bpf: Check rbtree lock held during verification
  bpf: Add OBJ_NON_OWNING_REF type flag
  bpf: Add CONDITIONAL_RELEASE type flag
  bpf: Introduce PTR_ITER and PTR_ITER_END type flags
  selftests/bpf: Add rbtree map tests
  selftests/bpf: Declarative lock definition test changes
  selftests/bpf: Lock tracking test changes
  selftests/bpf: Rbtree static lock verification test changes

 include/linux/bpf.h                           |  17 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |   3 +
 include/linux/btf.h                           |   1 +
 include/linux/poison.h                        |   3 +
 include/uapi/linux/bpf.h                      | 120 ++++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/btf.c                              |  21 +
 kernel/bpf/helpers.c                          |  48 +-
 kernel/bpf/rbtree.c                           | 442 ++++++++++++++
 kernel/bpf/syscall.c                          |  11 +-
 kernel/bpf/verifier.c                         | 546 ++++++++++++++++--
 tools/include/uapi/linux/bpf.h                | 120 ++++
 tools/lib/bpf/libbpf.c                        | 164 +++++-
 .../selftests/bpf/prog_tests/rbtree_map.c     | 134 +++++
 .../testing/selftests/bpf/progs/rbtree_map.c  | 119 ++++
 .../selftests/bpf/progs/rbtree_map_fail.c     | 243 ++++++++
 .../bpf/progs/rbtree_map_load_fail.c          |  31 +
 18 files changed, 1951 insertions(+), 75 deletions(-)
 create mode 100644 kernel/bpf/rbtree.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_load_fai=
l.c

--=20
2.30.2

