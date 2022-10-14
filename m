Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23C5FE83F
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 06:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJNE4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 00:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJNE43 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 00:56:29 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549C12E9D2
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:56:28 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DNsR0k021596
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:56:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JPZpePSVm2wDRFyJEwkn+rypRixOX2bFMHvGcI8kuRI=;
 b=gMRMlyYzq6tNdvH/imfOIThtsVHnutTlTKOnYyhzxa8dcLOFp3f07Rd4UeqvadzjUnd0
 Aj9OqHAqeI2ET9+42L98A30ztD2iRjS7kbsze4+gFvr4oBkdhU4YJpmZAOs4gFNzd/T4
 ltQxRb0gUAdExKnwwKeiMevnLok0l0HGnpE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k6jce0c2f-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:56:27 -0700
Received: from twshared8247.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:56:24 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 96DAF10A7A50F; Thu, 13 Oct 2022 21:56:19 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 0/5] bpf: Implement cgroup local storage available to non-cgroup-attached bpf progs
Date:   Thu, 13 Oct 2022 21:56:19 -0700
Message-ID: <20221014045619.3309899-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dSHgUgGsQj1Qd3RxmYLYMXwuhpa78PBO
X-Proofpoint-ORIG-GUID: dSHgUgGsQj1Qd3RxmYLYMXwuhpa78PBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There already exists a local storage implementation for cgroup-attached
bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
bpf_get_local_storage(). But there are use cases such that non-cgroup
attached bpf progs wants to access cgroup local storage data. For example=
,
tc egress prog has access to sk and cgroup. It is possible to use
sk local storage to emulate cgroup local storage by storing data in socke=
t.
But this is a waste as it could be lots of sockets belonging to a particu=
lar
cgroup. Alternatively, a separate map can be created with cgroup id as th=
e key.
But this will introduce additional overhead to manipulate the new map.
A cgroup local storage, similar to existing sk/inode/task storage,
should help for this use case.

This patch implemented new cgroup local storage available to
non-cgroup-attached bpf programs. In the patch series, Patch 1
is a preparation patch. Patch 2 implemented new cgroup local storage
kernel support. Patches 3 and 4 implemented libbpf and bpftool support.
Patch 5 added two tests to validate kernel/libbpf implementations.

Yonghong Song (5):
  bpf: Make struct cgroup btf id global
  bpf: Implement cgroup storage available to non-cgroup-attached bpf
    progs
  libbpf: Support new cgroup local storage
  bpftool: Support new cgroup local storage
  selftests/bpf: Add selftests for cgroup local storage

 include/linux/bpf.h                           |   3 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/btf_ids.h                       |   1 +
 include/linux/cgroup-defs.h                   |   4 +
 include/uapi/linux/bpf.h                      |  39 +++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_cgroup_storage.c               | 280 ++++++++++++++++++
 kernel/bpf/cgroup_iter.c                      |   2 +-
 kernel/bpf/helpers.c                          |   6 +
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  14 +-
 kernel/cgroup/cgroup.c                        |   4 +
 kernel/trace/bpf_trace.c                      |   4 +
 scripts/bpf_doc.py                            |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/map.c                       |   2 +-
 tools/include/uapi/linux/bpf.h                |  39 +++
 tools/lib/bpf/libbpf.c                        |   1 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../bpf/prog_tests/cgroup_local_storage.c     |  92 ++++++
 .../bpf/progs/cgroup_local_storage.c          |  88 ++++++
 .../selftests/bpf/progs/cgroup_ls_recursion.c |  70 +++++
 22 files changed, 654 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/bpf_cgroup_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_local_s=
torage.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_local_storag=
e.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_ls_recursion=
.c

--=20
2.30.2

