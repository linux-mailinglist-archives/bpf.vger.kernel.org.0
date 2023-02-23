Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687086A0075
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjBWBMw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjBWBMv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:12:51 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15E52D49
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:12:49 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31MNCGDP021473
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:12:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=6dp+H8QeJ2FCxBdv/XLTvuXE6qCRGKERcoMIoKDJeJQ=;
 b=HsfECR6EFQXjIEKfFrPQDq5R1fAt2QdjsVRRJJJBfZNp/5dLxOsv7ofihFGidl/EL4LN
 uR1XiJ3atJiAUGG0bn2jyAZWqCc752IoD8DI8860iI61ElycTGgro5q6Bs/oH6WUqhYt
 +qm3Lm4dldQk1I5pYBN35QHobmC2cNyJs9stEsmbhVWWcgYrQBaxqVWugSC6Wv/5SgA4
 iQXnXqYfhETzZNgBrmSO73wXrLHBlI9N85Nrpv+wt94tCwTK1P02x6rJJK+4WLAHaOaW
 W5qOm3i2gY4z8QBQ0NQlH8QPVzPTVPhksKN7f9J/om/hJeNy/CjvIrTRv5K30lo68lQd tw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nw5n4sd5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:12:48 -0800
Received: from twshared1992.22.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Feb 2023 17:12:47 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 702BC5BD8CBB; Wed, 22 Feb 2023 17:12:40 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 0/6] Transit between BPF TCP congestion controls.
Date:   Wed, 22 Feb 2023 17:12:32 -0800
Message-ID: <20230223011238.12313-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yLRmF_DujIrYdSFOiSgSw16wqPLGF7JF
X-Proofpoint-GUID: yLRmF_DujIrYdSFOiSgSw16wqPLGF7JF
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_12,2023-02-22_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

The major differences from v1:

 - Added bpf_struct_ops_link to replace the previous union-based
   approach.

 - Added UNREG and TOBEUNREG to the state of bpf_struct_ops_map.

   - bpf_struct_ops_transit_state() maintains state transitions.

 - Fixed synchronization issue.

 - Prepare kernel vdata of struct_ops during the loading phase of
   bpf_object.

 - Merged previous patch 3 to patch 1.

v1: https://lore.kernel.org/bpf/20230214221718.503964-1-kuifeng@meta.com/

Kui-Feng Lee (6):
  bpf: Create links for BPF struct_ops maps.
  net: Update an existing TCP congestion control algorithm.
  libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
  bpf: Update the struct_ops of a bpf_link.
  libbpf: Update a bpf_link with another struct_ops.
  selftests/bpf: Test switching TCP Congestion Control algorithms.

 include/linux/bpf.h                           |  13 +
 include/net/tcp.h                             |   2 +
 include/uapi/linux/bpf.h                      |  20 +-
 kernel/bpf/bpf_struct_ops.c                   | 445 +++++++++++++++++-
 kernel/bpf/syscall.c                          |  58 ++-
 net/bpf/bpf_dummy_struct_ops.c                |   6 +
 net/ipv4/bpf_tcp_ca.c                         |   8 +-
 net/ipv4/tcp_cong.c                           |  58 ++-
 tools/include/uapi/linux/bpf.h                |  12 +-
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/libbpf.c                        | 120 ++++-
 tools/lib/bpf/libbpf.h                        |   1 +
 tools/lib/bpf/libbpf.map                      |   2 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  48 ++
 .../selftests/bpf/progs/tcp_ca_update.c       |  62 +++
 15 files changed, 791 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c

--=20
2.30.2

