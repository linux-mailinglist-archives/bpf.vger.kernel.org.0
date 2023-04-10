Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68BE6DCB4A
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 21:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDJTI4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 15:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDJTIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 15:08:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA833171C
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:52 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AGZVfN011994
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=NB7CX+Nr2o2abkxK47GhRZhGzJzGSVXdv+C1+jojzvg=;
 b=YTSrEJbper0kfUxnqxy5F1t4lqyRLuAsaDadeZTHNZKGg3swHdIkEAGmtrcs5bFHunYR
 JIyJ411o6UlXCHwzeaKXhGqfZ5I+9fOo6Kg7Tg6pUWu0vJQjSN6GFP6h49Sgfeeqbjcp
 RmU0smK83ds4qXlwdDaQdo7FYiItBGwnYMM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pu4an31gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:52 -0700
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:08:50 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 7BA021BB3FCCE; Mon, 10 Apr 2023 12:08:39 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 0/9] Shared ownership for local kptrs
Date:   Mon, 10 Apr 2023 12:07:44 -0700
Message-ID: <20230410190753.2012798-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xRX3Wna2SyUtehXSGVT22AM76EGiVeMN
X-Proofpoint-GUID: xRX3Wna2SyUtehXSGVT22AM76EGiVeMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support for refcounted local kptrs to the verifier. A lo=
cal
kptr is 'refcounted' if its type contains a struct bpf_refcount field:

  struct refcounted_node {
    long data;
    struct bpf_list_node ll;
    struct bpf_refcount ref;
  };

bpf_refcount is used to implement shared ownership for local kptrs.

Motivating usecase
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If a struct has two collection node fields, e.g.:

  struct node {
    long key;
    long val;
    struct bpf_rb_node rb;
    struct bpf_list_node ll;
  };

It's not currently possible to add a node to both the list and rbtree:

  long bpf_prog(void *ctx)
  {
    struct node *n =3D bpf_obj_new(typeof(*n));
    if (!n) { /* ... */ }

    bpf_spin_lock(&lock);

    bpf_list_push_back(&head, &n->ll);
    bpf_rbtree_add(&root, &n->rb, less); /* Assume a resonable less() */
    bpf_spin_unlock(&lock);
  }

The above program will fail verification due to current owning / non-owni=
ng ref
logic: after bpf_list_push_back, n is a non-owning reference and thus can=
not be
passed to bpf_rbtree_add. The only way to get an owning reference for the=
 node
that was added is to bpf_list_pop_{front,back} it.

More generally, verifier ownership semantics expect that a node has one
owner (program, collection, or stashed in map) with exclusive ownership
of the node's lifetime. The owner free's the node's underlying memory whe=
n it
itself goes away.

Without a shared ownership concept it's impossible to express many real-w=
orld
usecases such that they pass verification.

Semantic Changes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Before this series, the verifier could make this statement: "whoever has =
the
owning reference has exclusive ownership of the referent's lifetime". As
demonstrated in the previous section, this implies that a BPF program can=
't
have an owning reference to some node if that node is in a collection. If
such a state were possible, the node would have multiple owners, each thi=
nking
they have exclusive ownership. In order to support shared ownership it's
necessary to modify the exclusive ownership semantic.

After this series' changes, an owning reference has ownership of the refe=
rent's
lifetime, but it's not necessarily exclusive. The referent's underlying m=
emory
is guaranteed to be valid (i.e. not free'd) until the reference is droppe=
d or
used for collection insert.

This change doesn't affect UX of owning or non-owning references much:

  * insert kfuncs (bpf_rbtree_add, bpf_list_push_{front,back}) still requ=
ire
    an owning reference arg, as ownership still must be passed to the
    collection in a shared-ownership world.

  * non-owning references still refer to valid memory without claiming
    any ownership.

One important conclusion that followed from "exclusive ownership" stateme=
nt
is no longer valid, though. In exclusive-ownership world, if a BPF prog h=
as
an owning reference to a node, the verifier can conclude that no collecti=
on has
ownership of it. This conclusion was used to avoid runtime checking in th=
e
implementations of insert and remove operations (""has the node already b=
een
{inserted, removed}?").

In a shared-ownership world the aforementioned conclusion is no longer va=
lid,
which necessitates doing runtime checking in insert and remove operation
kfuncs, and those functions possibly failing to insert or remove anything=
.

Luckily the verifier changes necessary to go from exclusive to shared own=
ership
were fairly minimal. Patches in this series which do change verifier sema=
ntics
generally have some summary dedicated to explaining why certain usecases
Just Work for shared ownership without verifier changes.

Implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The changes in this series can be categorized as follows:

  * struct bpf_refcount opaque field + plumbing
  * support for refcounted kptrs in bpf_obj_new and bpf_obj_drop
  * bpf_refcount_acquire kfunc
    * enables shared ownershp by bumping refcount + acquiring owning ref
  * support for possibly-failing collection insertion and removal
    * insertion changes are more complex

If a patch's changes have some nuance to their effect - or lack of effect=
 - on
verifier behavior, the patch summary talks about it at length.

Patch contents:
  * Patch 1 removes btf_field_offs struct
  * Patch 2 adds struct bpf_refcount and associated plumbing
  * Patch 3 modifies semantics of bpf_obj_drop and bpf_obj_new to handle
    refcounted kptrs
  * Patch 4 adds bpf_refcount_acquire
  * Patches 5-7 add support for possibly-failing collection insert and re=
move
  * Patch 8 centralizes constructor-like functionality for local kptr typ=
es
  * Patch 9 adds tests for new functionality

base-commit: c4d3b488a90be95f4f9413dc7eae5fc113d15fe9

Dave Marchevsky (9):
  bpf: Remove btf_field_offs, use btf_record's fields instead
  bpf: Introduce opaque bpf_refcount struct and add btf_record plumbing
  bpf: Support refcounted local kptrs in existing semantics
  bpf: Add bpf_refcount_acquire kfunc
  bpf: Migrate bpf_rbtree_add and bpf_list_push_{front,back} to possibly
    fail
  selftests/bpf: Modify linked_list tests to work with macro-ified
    inserts
  bpf: Migrate bpf_rbtree_remove to possibly fail
  bpf: Centralize btf_field-specific initialization logic
  selftests/bpf: Add refcounted_kptr tests

 include/linux/bpf.h                           |  85 ++--
 include/linux/bpf_verifier.h                  |   7 +-
 include/linux/btf.h                           |   2 -
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/btf.c                              | 126 ++----
 kernel/bpf/helpers.c                          | 116 +++--
 kernel/bpf/map_in_map.c                       |  15 -
 kernel/bpf/syscall.c                          |  23 +-
 kernel/bpf/verifier.c                         | 153 +++++--
 tools/include/uapi/linux/bpf.h                |   4 +
 .../testing/selftests/bpf/bpf_experimental.h  |  60 ++-
 .../selftests/bpf/prog_tests/linked_list.c    |   8 +-
 .../testing/selftests/bpf/prog_tests/rbtree.c |  25 ++
 .../bpf/prog_tests/refcounted_kptr.c          |  18 +
 .../testing/selftests/bpf/progs/linked_list.c |  34 +-
 .../testing/selftests/bpf/progs/linked_list.h |   4 +-
 .../selftests/bpf/progs/linked_list_fail.c    |  96 ++--
 tools/testing/selftests/bpf/progs/rbtree.c    |  74 +++-
 .../testing/selftests/bpf/progs/rbtree_fail.c |  77 ++--
 .../selftests/bpf/progs/refcounted_kptr.c     | 410 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          |  72 +++
 21 files changed, 1066 insertions(+), 347 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/refcounted_kpt=
r.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_fai=
l.c

--=20
2.34.1
