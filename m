Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306716B35A3
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 05:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjCJEid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 23:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJEic (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 23:38:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B01559D9
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 20:38:29 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329LqwR2025223
        for <bpf@vger.kernel.org>; Thu, 9 Mar 2023 20:38:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=BMM+BOpt9MnM/2H11a6+ECZ/Si3mqoYF/u6Xo6sYf5w=;
 b=ft26FFWzs8u8Z7/+nAGNkH8NVczbx1jrQwJBwvF8FcuNPF46+RI67cBwR61Y0rvM4wuG
 rJugujR5rrfGU1IajsEuZEQTryj5j6r+AQXGdh/CSCEiQp1hpDwnt1W1KxZZ/ijszwYa
 AVumbzOjsEZmUQJcyrVtpPhYpiAR174kwGPxw29bv+/f3Piu/zbOrYDU3RmnW3oyMfT3
 0zMbUlNiBun7SQc78QwHdm/vCn2dIuMyTgDjcxWkmTH8WxbLZGyqPKcfKr0c0qMD0YA4
 h/Ag1VHEFQedjJffiuJB8S0TnU5hWe9oo4NGJzV0q9ZoVzamWsegiBwisR0MbCBPqAqT TQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p783m09ea-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 20:38:29 -0800
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 20:38:28 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 42AC66F6BD21; Thu,  9 Mar 2023 20:38:17 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v6 0/8] Transit between BPF TCP congestion controls.
Date:   Thu, 9 Mar 2023 20:38:04 -0800
Message-ID: <20230310043812.3087672-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zdpBTZlvQtXwhrHx-_fpseZQT-LZ1wEd
X-Proofpoint-ORIG-GUID: zdpBTZlvQtXwhrHx-_fpseZQT-LZ1wEd
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_02,2023-03-09_01,2023-02-09_01
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

 include/linux/bpf.h                           |  10 +
 include/net/tcp.h                             |   3 +
 include/uapi/linux/bpf.h                      |  20 +-
 kernel/bpf/bpf_struct_ops.c                   | 229 +++++++++++++++---
 kernel/bpf/syscall.c                          |  49 +++-
 net/bpf/bpf_dummy_struct_ops.c                |   6 +
 net/ipv4/bpf_tcp_ca.c                         |  14 +-
 net/ipv4/tcp_cong.c                           |  60 ++++-
 tools/include/uapi/linux/bpf.h                |  20 +-
 tools/lib/bpf/libbpf.c                        | 180 +++++++++++---
 tools/lib/bpf/libbpf.h                        |   1 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  91 +++++++
 .../selftests/bpf/progs/tcp_ca_update.c       |  80 ++++++
 14 files changed, 671 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c

--=20
2.34.1

