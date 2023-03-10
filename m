Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6FA6B5551
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 00:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCJXIA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 18:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCJXH6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 18:07:58 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4199630E1
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:07:54 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AMgNlT006306
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:07:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=hh+6xHqi+GicsMNlWPArXlEEo3/p5Na8v3goKIivDys=;
 b=Rremg+4I3MEhWgC6aFcFz2utETUewdS2MWGD+8Z6lREM7UDWSsZ6eA3y1BIQHs23PXnI
 kDVcbaPYAnXH7lKtPpcG2ZDl8pBMQSuWZ7bJDxlMKzwqB5kgyiJ8RnIQRr8YaVpZgaMp
 0Ln5lHel8UgwRO/l+gB8IBmYPH0/QfQuPh8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p8ajx1fnd-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:07:54 -0800
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Mar 2023 15:07:52 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 3769D1902A1FA; Fri, 10 Mar 2023 15:07:44 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 0/3] Support stashing local kptrs with bpf_kptr_xchg
Date:   Fri, 10 Mar 2023 15:07:40 -0800
Message-ID: <20230310230743.2320707-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nlL2Ex4kjT6cVDbYNUuu5NzihO76YL1j
X-Proofpoint-GUID: nlL2Ex4kjT6cVDbYNUuu5NzihO76YL1j
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Local kptrs are kptrs allocated via bpf_obj_new with a type specified in pr=
ogram
BTF. A BPF program which creates a local kptr has exclusive control of the
lifetime of the kptr, and, prior to terminating, must:

  * free the kptr via bpf_obj_drop
  * If the kptr is a {list,rbtree} node, add the node to a {list, rbtree},
    thereby passing control of the lifetime to the collection

This series adds a third option:

  * stash the kptr in a map value using bpf_kptr_xchg

As indicated by the use of "stash" to describe this behavior, the intended =
use
of this feature is temporary storage of local kptrs. For example, a sched_e=
xt
([0]) scheduler may want to create an rbtree node for each new cgroup on cg=
roup
init, but to add that node to the rbtree as part of a separate program which
runs on enqueue. Stashing the node in a map_value allows its lifetime to ou=
tlive
the execution of the cgroup_init program.

Behavior:

There is no semantic difference between adding a kptr to a graph collection=
 and
"stashing" it in a map. In both cases exclusive ownership of the kptr's lif=
etime
is passed to some containing data structure, which is responsible for
bpf_obj_drop'ing it when the container goes away.

Since graph collections also expect exclusive ownership of the nodes they
contain, graph nodes cannot be both stashed in a map_value and contained by
their corresponding collection.

Implementation:

Two observations simplify the verifier changes for this feature. First, kpt=
rs
("referenced kptrs" until a recent renaming) require registration of a
dtor function as part of their acquire/release semantics, so that a referen=
ced
kptr which is placed in a map_value is properly released when the map goes =
away.
We want this exact behavior for local kptrs, but with bpf_obj_drop as the d=
tor
instead of a per-btf_id dtor.

The second observation is that, in terms of identification, "referenced kpt=
r"
and "local kptr" already don't interfere with one another. Consider the
following example:

  struct node_data {
          long key;
          long data;
          struct bpf_rb_node node;
  };

  struct map_value {
          struct node_data __kptr *node;
  };

  struct {
          __uint(type, BPF_MAP_TYPE_ARRAY);
          __type(key, int);
          __type(value, struct map_value);
          __uint(max_entries, 1);
  } some_nodes SEC(".maps");

  struct map_value *mapval;
  struct node_data *res;
  int key =3D 0;

  res =3D bpf_obj_new(typeof(*res));
  if (!res) { /* err handling */ }

  mapval =3D bpf_map_lookup_elem(&some_nodes, &key);
  if (!mapval) { /* err handling */ }

  res =3D bpf_kptr_xchg(&mapval->node, res);
  if (res)
          bpf_obj_drop(res);

The __kptr tag identifies map_value's node as a referenced kptr, while the
PTR_TO_BTF_ID which bpf_obj_new returns - a type in some non-vmlinux,
non-module BTF - identifies res as a local kptr. Type tag on the pointer
indicates referenced kptr, while the type of the pointee indicates local kp=
tr.
So using existing facilities we can tell the verifier about a "referenced k=
ptr"
pointer to a "local kptr" pointee.

When kptr_xchg'ing a kptr into a map_value, the verifier can recognize local
kptr types and treat them like referenced kptrs with a properly-typed
bpf_obj_drop as a dtor.

Other implementation notes:
  * We don't need to do anything special to enforce "graph nodes cannot be
    both stashed in a map_value and contained by their corresponding collec=
tion"
    * bpf_kptr_xchg both returns and takes as input a (possibly-null) owning
      reference. It does not accept non-owning references as input by virtue
      of requiring a ref_obj_id. By definition, if a program has an owning
      ref to a node, the node isn't in a collection, so it's safe to pass
      ownership via bpf_kptr_xchg.

Summary of patches:

  * Patch 1 modifies BTF plumbing to support using bpf_obj_drop as a dtor
  * Patch 2 adds verifier plumbing to support MEM_ALLOC-flagged param for
    bpf_kptr_xchg
  * Patch 3 adds selftests exercising the new behavior


Changelog:

v1 -> v2: https://lore.kernel.org/bpf/20230309180111.1618459-1-davemarchevs=
ky@fb.com/

Patch #s used below refer to the patch's position in v1 unless otherwise
specified.

Patches 1-3 were applied and are not included in v2.
Rebase onto latest bpf-next: "libbpf: Revert poisoning of strlcpy"

Patch 4: "bpf: Support __kptr to local kptrs"
  * Remove !btf_is_kernel(btf) check, WARN_ON_ONCE instead (Alexei)

Patch 6: "selftests/bpf: Add local kptr stashing test"
  * Add test which stashes 2 nodes and later unstashes one of them using a
    separate BPF program (Alexei)
  * Fix incorrect runner subtest name for original test (was
    "rbtree_add_nodes")


Dave Marchevsky (3):
  bpf: Support __kptr to local kptrs
  bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg
  selftests/bpf: Add local kptr stashing test

 include/linux/bpf.h                           |  11 +-
 include/linux/btf.h                           |   2 -
 kernel/bpf/btf.c                              |  37 ++++--
 kernel/bpf/helpers.c                          |  11 +-
 kernel/bpf/syscall.c                          |  14 ++-
 kernel/bpf/verifier.c                         |   8 +-
 .../bpf/prog_tests/local_kptr_stash.c         |  60 ++++++++++
 .../selftests/bpf/progs/local_kptr_stash.c    | 108 ++++++++++++++++++
 8 files changed, 234 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/local_kptr_stash=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_kptr_stash.c

--=20
2.34.1


