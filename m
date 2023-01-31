Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37C68348A
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjAaSBP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjAaSAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:00:48 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3B04859E
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:00:24 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGcVHm005671
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:00:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=QC+5PKpMWljBkHFgc8FLCd93o+BgTq03FD8Yye4LrVs=;
 b=EhRG9wUIqcMl1cCYtvY1mcbpq4HN4X01W+HyW2Jpj4tFyy+n6KV3GfC2zS9KokfyYmNp
 46xObOQJ3HgGOFZjTmMGsuMVpSeNyKK6mIg2Rzy59IUrqi+qSwNVneNU0Fv5uwdoUZi6
 kwVKpDQCpf0anoI9Ebr7rw06pk5EwXNjUO8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nepsg5fm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:00:24 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 31 Jan 2023 10:00:23 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id BA0C515D5BB5F; Tue, 31 Jan 2023 10:00:17 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 00/11] BPF rbtree next-gen datastructure
Date:   Tue, 31 Jan 2023 10:00:05 -0800
Message-ID: <20230131180016.3368305-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: f383FI9YntR_JLHiO1yT75GT85YZjkf3
X-Proofpoint-ORIG-GUID: f383FI9YntR_JLHiO1yT75GT85YZjkf3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
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

First, the series refactors and extends linked_list's release_on_unlock
logic. The concept of "reference to node that was added to data
structure" is formalized as "non-owning reference". From linked_list's
perspective this non-owning reference after
linked_list_push_{front,back} has same semantics as release_on_unlock,
with the addition of writes to such references being valid in the
critical section. Such references are no longer marked PTR_UNTRUSTED.
Patches 2 and 13 go into more detail.

The series then adds rbtree API kfuncs and necessary verifier support
for them - namely support for callback args to kfuncs and some
non-owning reference interactions that linked_list didn't need.

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
  * bpf_rbtree_first is the first graph API function to return a
    non-owning reference instead of convering an arg from own->non-own
  * Because all references to nodes already added to the rbtree are
    non-owning, bpf_rbtree_remove must accept such a reference in order
    to remove it from the tree

Summary of patches:
  Patch 1 lays groundwork for release_on_unlock -> non-owning ref
  changes

  Patches 2 and 3 do release_on_unlock -> non-owning ref migration and
  update linked_list tests

  Patch 4 is a nonfunctional rename

  Patches 5 - 9 implement the meat of rbtree support in this series,
  gradually building up to implemented kfuncs that verify as expected.

  Patch 10 adds the bpf_rbtree_{add,first,remove} to bpf_experimental.h.

  Patch 12 adds tests, Patch 13 adds documentation.

  [0]: lore.kernel.org/bpf/20221118015614.2013203-1-memxor@gmail.com
  [1]: lore.kernel.org/bpf/20220830172759.4069786-1-davemarchevsky@fb.com
  [2]: lore.kernel.org/bpf/20221130082313.3241517-1-tj@kernel.org

Changelog:

v2 -> v3: lore.kernel.org/bpf/20221217082506.1570898-1-davemarchevsky@fb.co=
m/

Patch #'s below refer to the patch's number in v2 unless otherwise stated.

* Patch 1 - "bpf: Support multiple arg regs w/ ref_obj_id for kfuncs"
  * No longer needed as v3 doesn't have multiple ref_obj_id arg regs
  * The refactoring pieces were submitted separately
    (https://lore.kernel.org/bpf/20230121002417.1684602-1-davemarchevsky@fb=
.com/)

* Patch 2 - "bpf: Migrate release_on_unlock logic to non-owning ref semanti=
cs"
  * Remove KF_RELEASE_NON_OWN flag from list API push methods, just match
    against specific kfuncs for now (Alexei, David)
  * Separate "release non owning reference" logic from KF_RELEASE logic
    (Alexei, David)
  * reg_find_field_offset now correctly tests 'rec' instead of 'reg' after
    calling reg_btf_record (Dan Carpenter)

* New patch added after Patch 2 - "bpf: Improve bpf_reg_state space usage f=
or non-owning ref lock"
  * Eliminates extra bpf_reg_state memory usage by using a bool instead of
    copying lock identity

* Patch 4 - "bpf: rename list_head -> graph_root in field info types"
  * v2's version was applied to bpf-next, not including in respins

* Patch 6 - "bpf: Add bpf_rbtree_{add,remove,first} kfuncs"
  * Remove KF_RELEASE_NON_OWN flag from rbtree_add, just add it to specific
    kfunc matching (Alexei, David)

* Patch 9 - "bpf: Special verifier handling for bpf_rbtree_{remove, first}"
  * Remove KF_INVALIDATE_NON_OWN kfunc flag, just match against specific kf=
unc
    for now (Alexei, David)

* Patch 11 - "libbpf: Make BTF mandatory if program BTF has spin_lock or al=
loc_obj type"
  * Drop for now, will submit separately

* Patch 12 - "selftests/bpf: Add rbtree selftests"
  * Some expected-failure tests have different error messages due to "relea=
se
    non-owning reference logic" being separated from KF_RELEASE logic in Pa=
tch
    2 changes

* Patch 13 - "bpf, documentation: Add graph documentation for non-owning re=
fs"
  * Fix documentation formatting and improve content (David)


v1 -> v2: lore.kernel.org/bpf/20221206231000.3180914-1-davemarchevsky@fb.co=
m/

Series-wide changes:
  * Rename datastructure_{head,node,api} -> graph_{root,node,api} (Alexei)
  * "graph datastructure" in patch summaries to refer to linked_list + rbtr=
ee
    instead of "next-gen datastructure" (Alexei)
  * Move from hacky marking of non-owning references as PTR_UNTRUSTED to
    cleaner implementation (Alexei)
  * Add invalidation of non-owning refs to rbtree_remove (Kumar, Alexei)

Patch #'s below refer to the patch's number in v1 unless otherwise stated.

Note that in v1 most of the meaty verifier changes were in the latter half
of the series. Here, about half of that complexity has been moved to
"bpf: Migrate release_on_unlock logic to non-owning ref semantics" - was Pa=
tch
3 in v1.

* Patch 1 - "bpf: Loosen alloc obj test in verifier's reg_btf_record"
  * Was applied, dropped from further iterations

* Patch 2 - "bpf: map_check_btf should fail if btf_parse_fields fails"
  * Dropped in favor of verifier check-on-use: when some normal verifier
    checking expects the map to have btf_fields correctly parsed, it won't
    find any and verification will fail

* New patch added before Patch 3 - "bpf: Support multiple arg regs w/ ref_o=
bj_id for kfuncs"
  * Addition of KF_RELEASE_NON_OWN flag, which requires KF_RELEASE, and tag=
ging
    of bpf_list_push_{front,back} KF_RELEASE | KF_RELEASE_NON_OWN, means th=
at
    list-in-list push_{front,back} will trigger "only one ref_obj_id arg re=
g"
    logic. This is because "head" arg to those functions can be a list-in-l=
ist,
    which itself can be an owning reference with ref_obj_id. So need to
    support multiple ref_obj_id for release kfuncs.

* Patch 3 - "bpf: Minor refactor of ref_set_release_on_unlock"
  * Now a major refactor w/ a rename to reflect this
    * "bpf: Migrate release_on_unlock logic to non-owning ref semantics"
  * Replaces release_on_unlock with active_lock logic as discussed in v1

* New patch added after Patch 3 - "selftests/bpf: Update linked_list tests =
for non_owning_ref logic"
  * Removes "write after push" linked_list failure tests - no longer failure
    scenarios.

* Patch 4 - "bpf: rename list_head -> datastructure_head in field info type=
s"
  * rename to graph_root instead. Similar renamings across the series - see
    series-wide changes.

* Patch 5 - "bpf: Add basic bpf_rb_{root,node} support"
  * OWNER_FIELD_MASK -> GRAPH_ROOT_MASK, OWNEE_FIELD_MASK -> GRAPH_NODE_MAS=
K,
    and change of "owner"/"ownee" in big btf_check_and_fixup_fields comment=
 to
    "root"/"node" (Alexei)

* Patch 6 - "bpf: Add bpf_rbtree_{add,remove,first} kfuncs"
  * bpf_rbtree_remove can no longer return NULL. v2 continues v1's "use type
    system to prevent remove of node that isn't in a datastructure" approac=
h,
    so rbtree_remove should never have been able to return NULL

* Patch 7 - "bpf: Add support for bpf_rb_root and bpf_rb_node in kfunc args"
  * is_bpf_datastructure_api_kfunc -> is_bpf_graph_api_kfunc (Alexei)

* Patch 8 - "bpf: Add callback validation to kfunc verifier logic"
  * Explicitly disallow rbtree_remove in rbtree callback
  * Explicitly disallow bpf_spin_{lock,unlock} call in rbtree callback,
    preventing possibility of "unbalanced" unlock (Alexei)

* Patch 10 - "bpf, x86: BPF_PROBE_MEM handling for insn->off < 0"
  * Now that non-owning refs aren't marked PTR_UNTRUSTED it's not necessary=
 to
    include this patch as part of the series
  * After conversation w/ Alexei, did another pass and submitted as an
    independent series (lore.kernel.org/bpf/20221213182726.325137-1-davemar=
chevsky@fb.com/)

* Patch 13 - "selftests/bpf: Add rbtree selftests"
  * Since bpf_rbtree_remove can no longer return null, remove null checks
  * Remove test confirming that rbtree_first isn't allowed in callback. We =
want
    this to be possible
  * Add failure test confirming that rbtree_remove's new non-owning referen=
ce
    invalidation behavior behaves as expected
  * Add SEC("license") to rbtree_btf_fail__* progs. They were previously
    failing due to lack of this section. Now they're failing for correct
    reasons.
  * rbtree_btf_fail__add_wrong_type.c - add locking around rbtree_add, rena=
me
    the bpf prog to something reasonable

* New patch added after patch 13 - "bpf, documentation: Add graph documenta=
tion for non-owning refs"
  * Summarizes details of owning and non-owning refs which we hashed out in
    v1


Dave Marchevsky (13):
  bpf: Support multiple arg regs w/ ref_obj_id for kfuncs
  bpf: Migrate release_on_unlock logic to non-owning ref semantics
  selftests/bpf: Update linked_list tests for non-owning ref semantics
  bpf: rename list_head -> graph_root in field info types
  bpf: Add basic bpf_rb_{root,node} support
  bpf: Add bpf_rbtree_{add,remove,first} kfuncs
  bpf: Add support for bpf_rb_root and bpf_rb_node in kfunc args
  bpf: Add callback validation to kfunc verifier logic
  bpf: Special verifier handling for bpf_rbtree_{remove, first}
  bpf: Add bpf_rbtree_{add,remove,first} decls to bpf_experimental.h
  libbpf: Make BTF mandatory if program BTF has spin_lock or alloc_obj
    type
  selftests/bpf: Add rbtree selftests
  bpf, documentation: Add graph documentation for non-owning refs

 Documentation/bpf/graph_ds_impl.rst           | 208 +++++
 Documentation/bpf/other.rst                   |   3 +-
 include/linux/bpf.h                           |  23 +-
 include/linux/bpf_verifier.h                  |  39 +-
 include/linux/btf.h                           |  18 +-
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/btf.c                              | 181 ++--
 kernel/bpf/helpers.c                          |  76 +-
 kernel/bpf/syscall.c                          |  28 +-
 kernel/bpf/verifier.c                         | 800 ++++++++++++++----
 tools/include/uapi/linux/bpf.h                |  11 +
 tools/lib/bpf/libbpf.c                        |  50 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  24 +
 .../selftests/bpf/prog_tests/linked_list.c    |  22 +-
 .../testing/selftests/bpf/prog_tests/rbtree.c | 186 ++++
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 .../selftests/bpf/progs/linked_list_fail.c    | 100 ++-
 tools/testing/selftests/bpf/progs/rbtree.c    | 176 ++++
 .../progs/rbtree_btf_fail__add_wrong_type.c   |  52 ++
 .../progs/rbtree_btf_fail__wrong_node_type.c  |  49 ++
 .../testing/selftests/bpf/progs/rbtree_fail.c | 296 +++++++
 21 files changed, 2018 insertions(+), 337 deletions(-)
 create mode 100644 Documentation/bpf/graph_ds_impl.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_btf_fail__add_=
wrong_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_btf_fail__wron=
g_node_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_fail.c

--=20
2.30.2
