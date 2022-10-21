Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88741608220
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJUXoa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJUXoZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:44:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4514315A15
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:44:24 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29LMHkk7025357
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:44:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Z/14a5fxwJccRpjVyx4fNON2da/BhBjE8DVG/4Q5Nl0=;
 b=J2WKvECo5TOcOc76+K0mcXMy4G8LqManOihGCGUDp5SLJ5aXt6H9Y7sO/yocFvLEFvfA
 YpcENGtaGkya+3DyqCm+PT1BE3mpJMOLo0ge3wQxVcp+jlQExz4PxNVZ7MoWLt18m1/z
 OHjNQrdhD8Oy0UHPZEXE1Ay6M/yVSoj6mAY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kbs51792j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:44:23 -0700
Received: from twshared19720.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:44:22 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A310111011289; Fri, 21 Oct 2022 16:44:16 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v3 0/7] bpf: Implement cgroup local storage available to non-cgroup-attached bpf progs
Date:   Fri, 21 Oct 2022 16:44:16 -0700
Message-ID: <20221021234416.2328241-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 98tfNQ7pSYnV4TQDdBjaFySQT0D5jnY7
X-Proofpoint-ORIG-GUID: 98tfNQ7pSYnV4TQDdBjaFySQT0D5jnY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There already exists a local storage implementation for cgroup-attached
bpf programs. See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
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
should help for this use case. =20

This patch implemented new cgroup local storage available to
non-cgroup-attached bpf programs. In the patch series, Patches 1 and 2
are preparation patches. Patch 3 implemented new cgroup local storage
kernel support. Patches 4 and 5 implemented libbpf and bpftool support.
Patch 6 added two tests to validate kernel/libbpf implementations.
Patch 7 added documentation for new BPF_MAP_TYPE_CGRP_STORAGE map type
and comparison of the old and new cgroup local storage maps.

Changelogs:
  v2 -> v3:
    . fix a config caused kernel test complaint.
    . better description/comments in uapi bpf.h and bpf_cgrp_storage.c.
    . factor code for better resue for map_alloc/map_free.
    . improved explanation in map documentation.
  v1 -> v2:
    . change map name from BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE to
      BPF_MAP_TYPE_CGRP_STORAGE.
    . removed support of sleepable programs.
    . changed the place of freeing cgrp local storage from put_css_set_lo=
cked()
      to css_free_rwork_fn().
    . added map documentation.

Yonghong Song (7):
  bpf: Make struct cgroup btf id global
  bpf: Refactor inode/task/sk storage map_{alloc,free}() for reuse
  bpf: Implement cgroup storage available to non-cgroup-attached bpf
    progs
  libbpf: Support new cgroup local storage
  bpftool: Support new cgroup local storage
  selftests/bpf: Add selftests for cgroup local storage
  docs/bpf: Add documentation for map type BPF_MAP_TYPE_CGRP_STROAGE

 Documentation/bpf/map_cgrp_storage.rst        | 109 +++++++
 include/linux/bpf.h                           |   3 +
 include/linux/bpf_local_storage.h             |  11 +-
 include/linux/bpf_types.h                     |   1 +
 include/linux/btf_ids.h                       |   1 +
 include/linux/cgroup-defs.h                   |   4 +
 include/uapi/linux/bpf.h                      |  50 +++-
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_cgrp_storage.c                 | 268 ++++++++++++++++++
 kernel/bpf/bpf_inode_storage.c                |  15 +-
 kernel/bpf/bpf_local_storage.c                |  39 ++-
 kernel/bpf/bpf_task_storage.c                 |  15 +-
 kernel/bpf/cgroup_iter.c                      |   2 +-
 kernel/bpf/helpers.c                          |   6 +
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  13 +-
 kernel/cgroup/cgroup.c                        |   4 +
 kernel/trace/bpf_trace.c                      |   4 +
 net/core/bpf_sk_storage.c                     |  15 +-
 scripts/bpf_doc.py                            |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/map.c                       |   2 +-
 tools/include/uapi/linux/bpf.h                |  50 +++-
 tools/lib/bpf/libbpf.c                        |   1 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../bpf/prog_tests/cgroup_local_storage.c     |  92 ++++++
 .../bpf/progs/cgroup_local_storage.c          |  88 ++++++
 .../selftests/bpf/progs/cgroup_ls_recursion.c |  70 +++++
 28 files changed, 813 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/bpf/map_cgrp_storage.rst
 create mode 100644 kernel/bpf/bpf_cgrp_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_local_s=
torage.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_local_storag=
e.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_ls_recursion=
.c

--=20
2.30.2

