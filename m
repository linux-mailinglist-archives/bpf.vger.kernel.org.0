Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FEF69708C
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjBNWRc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBNWRb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB07B2821B
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:30 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGsFvY002403
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=rBjfJ2eehvl1uMUvIR/7g9tnnqs54kMjdvKrFqr/mOo=;
 b=Pr1MzvSUZcAYdtlDNp4V/ufDsiWPmfT1ig/dBUmfrqvx+BM3WiVlKDh6WIKJq8ZA1sNY
 uYrJINTMcqP54nlLqVfi32ypZ3v8GAt308Mh1+m8Y3hIpbaUONq1zzSUOhflr5sKxevD
 7Bf3Pj+cqCFAFqLe1lp/EsVYoMIqW9hQGmyL+uwOb0uKSAG/Wg6aVk/yaJPJb5orNteG
 RqSStqw5BH33MffMpLTDXtnBzqp7bE50dl4jbxqq892xaIVvsef5EFE81DqbhpN9rKj5
 Sg0lIFnR5YUWPt88JobbXrJAweQ+n/ElGsL3XemME/ZUfryD7Tpx2ZMnzPC3EvJDuDzT ng== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nrc3b39s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:30 -0800
Received: from twshared25601.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 14:17:29 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 273C2514307B; Tue, 14 Feb 2023 14:17:20 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 0/7] Transit between BPF TCP congestion controls.
Date:   Tue, 14 Feb 2023 14:17:11 -0800
Message-ID: <20230214221718.503964-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: orHAmn-n1f9_477XUGVdMUrKjRkSdC2_
X-Proofpoint-GUID: orHAmn-n1f9_477XUGVdMUrKjRkSdC2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
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

Kui-Feng Lee (7):
  bpf: Create links for BPF struct_ops maps.
  net: Update an existing TCP congestion control algorithm.
  bpf: Register and unregister a struct_ops by their bpf_links.
  libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
  bpf: Update the struct_ops of a bpf_link.
  libbpf: Update a bpf_link with another struct_ops.
  selftests/bpf: Test switching TCP Congestion Control algorithms.

 include/linux/bpf.h                           |   8 +-
 include/net/tcp.h                             |   2 +
 include/uapi/linux/bpf.h                      |  15 +-
 kernel/bpf/bpf_struct_ops.c                   | 176 +++++++++++++++++-
 kernel/bpf/syscall.c                          |  60 +++++-
 net/bpf/bpf_dummy_struct_ops.c                |   6 +
 net/ipv4/bpf_tcp_ca.c                         |   8 +-
 net/ipv4/tcp_cong.c                           |  39 ++++
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/libbpf.c                        | 109 +++++++++--
 tools/lib/bpf/libbpf.h                        |   1 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  48 +++++
 .../selftests/bpf/progs/tcp_ca_update.c       |  75 ++++++++
 15 files changed, 526 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c

--=20
2.30.2

