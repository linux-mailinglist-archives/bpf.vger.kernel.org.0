Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77CC6BF802
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 06:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCRFcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Mar 2023 01:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCRFcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Mar 2023 01:32:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8642410A6
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:32:01 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32I0F5ow025744
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:32:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=mS+o7GwRV6Ge3qsA4TElm/l6tRK+q2aAxoKXC2NH+qc=;
 b=D5gIaNL9ZFxt43wsTWEgADwbHxfA0vsgz8JE7eRvUd43kGFYG+X04aJg60JThVLJefKg
 fQEEpphrvS3lafqahNQzVM8A4ClW0d9pe8g/+eyHjdrs7hWEx5DgvF8Vg+LD4fiNTEbF
 L+P3FJ4xYI4qwitj4EorK1ANQU1/NzZ4jLfqrYZsdg4ZXPwpIdVLulR7X7mlsdiGAZtl
 cTDa2ldjFXMwwAFsea5jHaosXDtFfWpubC5b4Jzdf9kObgiZnFtdxhjKkooYuJbydrYw
 6TpxmmBGbKAYGZ0aVLLSMFkctH0BsF4wHKq8kNzYLB67SFAPukK7098a4jPxKf4aAm1/ NQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pcndedug3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:32:00 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Mar 2023 22:31:59 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id C6F4279EB00A; Fri, 17 Mar 2023 22:31:48 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v8 0/8] Transit between BPF TCP congestion controls.
Date:   Fri, 17 Mar 2023 22:31:36 -0700
Message-ID: <20230318053144.1180301-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PIDpdsN5-hSXGQqIyZE1Nk_Z0KnBSRyw
X-Proofpoint-ORIG-GUID: PIDpdsN5-hSXGQqIyZE1Nk_Z0KnBSRyw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-18_02,2023-03-16_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Major changes:

 - Create bpf_links in the kernel for BPF struct_ops to register and
   unregister it.

 - Enables switching between implementations of bpf-tcp-cc under a
   name instantly by replacing the backing struct_ops map of a
   bpf_link.

Previously, BPF struct_ops didn't go off, as even when the user
program creating it was terminated, none of these ever were pinned.
For instance, the TCP congestion control subsystem indirectly
maintains a reference count on the struct_ops of any registered BPF
implemented algorithm. Thus, the algorithm won't be deactivated until
someone deliberately unregisters it.  For compatibility with other BPF
programs, bpf_links have been created to work in coordination with
struct_ops maps. This ensures that the registration and unregistration
of these respective maps is carried out at the start and end of the
bpf_link.

We also faced complications when attempting to replace an existing TCP
congestion control algorithm with a new implementation on the fly. A
struct_ops map was used to register a TCP congestion control algorithm
with a unique name.  We had to either register the alternative
implementation with a new name and move over or unregister the current
one before being able to reregistration with the same name.  To fix
this problem, we can an option to migrate the registration of the
algorithm from struct_ops maps to bpf_links. By modifying the backing
map of a bpf_link, it suddenly becomes possible to replace an existing
TCP congestion control algorithm with ease.

---

The major differences from v7:

 - Use synchronize_rcu_mult(call_rcu, call_rcu_tasks) to replace
   synchronize_rcu() & synchronize_rcu_tasks().

 - Call synchronize_rcu() in tcp_update_congestion_control().

 - Handle -EBUSY in bpf_map__attach_struct_ops() to allow a struct_ops
   can be used to create links more than once.  Include a test case.

 - Add old_map_fd to bpf_attr and handle BPF_F_REPLACE in
   bpf_struct_ops_map_link_update().

 - Remove changes in bpf_dummy_struct_ops.c and add a check of .update
   function pointer of bpf_struct_ops.

The major differences from v6:

 - Reword commit logs of the patch 1, 2, and 8.

 - Call syncrhonize_rcu_tasks() as well in bpf_struct_ops_map_free().

 - Refactor bpf_struct_ops_map_free() so that
   bpf_struct_ops_map_alloc() can free a struct_ops without waiting
   for a RCU grace period.

The major differences from v5:

 - Add a new step to bpf_object__load() to prepare vdata.

 - Accept BPF_F_REPLACE.

 - Check section IDs in find_struct_ops_map_by_offset()

 - Add a test case to check mixing w/ and w/o link struct_ops.

 - Add a test case of using struct_ops w/o link to update a link.

 - Improve bpf_link__detach_struct_ops() to handle the w/ link case.

The major differences from v4:

 - Rebase.

 - Reorder patches and merge part 4 to part 2 of the v4.

The major differences from v3:

 - Remove bpf_struct_ops_map_free_rcu(), and use synchronize_rcu().

 - Improve the commit log of the part 1.

 - Before transitioning to the READY state, we conduct a value check
   to ensure that struct_ops can be successfully utilized and links
   created later.

The major differences from v2:

 - Simplify states

   - Remove TOBEUNREG.

   - Rename UNREG to READY.

 - Stop using the refcnt of the kvalue of a struct_ops. Explicitly
   increase and decrease the refcount of struct_ops.

 - Prepare kernel vdata during the load phase of libbpf.

The major differences from v1:

 - Added bpf_struct_ops_link to replace the previous union-based
   approach.

 - Added UNREG and TOBEUNREG to the state of bpf_struct_ops_map.

   - bpf_struct_ops_transit_state() maintains state transitions.

 - Fixed synchronization issue.

 - Prepare kernel vdata of struct_ops during the loading phase of
   bpf_object.

 - Merged previous patch 3 to patch 1.

v7: https://lore.kernel.org/all/20230316023641.2092778-1-kuifeng@meta.com/
v6: https://lore.kernel.org/all/20230310043812.3087672-1-kuifeng@meta.com/
v5: https://lore.kernel.org/all/20230308005050.255859-1-kuifeng@meta.com/
v4: https://lore.kernel.org/all/20230307232913.576893-1-andrii@kernel.org/
v3: https://lore.kernel.org/all/20230303012122.852654-1-kuifeng@meta.com/
v2: https://lore.kernel.org/bpf/20230223011238.12313-1-kuifeng@meta.com/
v1: https://lore.kernel.org/bpf/20230214221718.503964-1-kuifeng@meta.com/

Kui-Feng Lee (8):
  bpf: Retire the struct_ops map kvalue->refcnt.
  net: Update an existing TCP congestion control algorithm.
  bpf: Create links for BPF struct_ops maps.
  libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
  bpf: Update the struct_ops of a bpf_link.
  libbpf: Update a bpf_link with another struct_ops.
  libbpf: Use .struct_ops.link section to indicate a struct_ops with a
    link.
  selftests/bpf: Test switching TCP Congestion Control algorithms.

 include/linux/bpf.h                           |  11 +
 include/net/tcp.h                             |   3 +
 include/uapi/linux/bpf.h                      |  33 ++-
 kernel/bpf/bpf_struct_ops.c                   | 252 +++++++++++++++---
 kernel/bpf/syscall.c                          |  63 ++++-
 net/ipv4/bpf_tcp_ca.c                         |  14 +-
 net/ipv4/tcp_cong.c                           |  65 ++++-
 tools/include/uapi/linux/bpf.h                |  33 ++-
 tools/lib/bpf/libbpf.c                        | 190 ++++++++++---
 tools/lib/bpf/libbpf.h                        |   1 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 116 ++++++++
 .../selftests/bpf/progs/tcp_ca_update.c       |  80 ++++++
 13 files changed, 761 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c

--=20
2.34.1

