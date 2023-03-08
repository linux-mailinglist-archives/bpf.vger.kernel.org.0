Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC86AFB8A
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCHAvK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCHAvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:51:09 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DC0A8C48
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:51:08 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328059SB001519
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 16:51:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=HZFJng1STi7DwE91xNJzbBN8dWt9OwFj39sOdYk1MBs=;
 b=Zzq9c2/VTXEFtvqeLtWOo8WeB4lzp1vGGIjWi6ew4UaEVVyN0VvaQq4SC5VZ40qGRZju
 NF3sPdNYy9rDKVakb5jlf+fgWNcWF3HDraCM2IXyJG6PMIXk7CqKIFHov/zcnEcWFGah
 of1uNbQ8FJpERAz1OrziQkuu/c6huLWMbRP5iM3I9GTYPEYFMTtBFaaHIsigx29IcDcZ
 RZW9u/pgIfiv8Ldg18mqxqmunCGPltWvHTcH/b4AARJrCDunkefbGjTYlB6KXidmYQw2
 aRNuvWpyGWw4mbiCstsMDdgVMnLSvYlA4380hDGq/usQ1HX+BpHVztIx1DMI0FR13QKT aQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6fgp071g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:51:07 -0800
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 16:51:05 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 6A0EA6C92E12; Tue,  7 Mar 2023 16:50:54 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v5 0/8] Transit between BPF TCP congestion controls.
Date:   Tue, 7 Mar 2023 16:50:42 -0800
Message-ID: <20230308005050.255859-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: b7Iy8CT-uZxmKtJpasyVs_VJxZuVckhp
X-Proofpoint-ORIG-GUID: b7Iy8CT-uZxmKtJpasyVs_VJxZuVckhp
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
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

 include/linux/bpf.h                           |  16 ++
 include/net/tcp.h                             |   3 +
 include/uapi/linux/bpf.h                      |  20 +-
 kernel/bpf/bpf_struct_ops.c                   | 218 +++++++++++++++---
 kernel/bpf/syscall.c                          |  68 ++++--
 net/bpf/bpf_dummy_struct_ops.c                |   6 +
 net/ipv4/bpf_tcp_ca.c                         |  14 +-
 net/ipv4/tcp_cong.c                           |  57 ++++-
 tools/include/uapi/linux/bpf.h                |  19 +-
 tools/lib/bpf/libbpf.c                        | 184 ++++++++++++---
 tools/lib/bpf/libbpf.h                        |   1 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  38 +++
 .../selftests/bpf/progs/tcp_ca_update.c       |  62 +++++
 14 files changed, 615 insertions(+), 92 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c

--=20
2.34.1

