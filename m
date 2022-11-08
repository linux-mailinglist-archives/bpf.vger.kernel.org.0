Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FE1620A77
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiKHHla (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiKHHlE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:04 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0057BEF
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:40:54 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A85q3Zm017275
        for <bpf@vger.kernel.org>; Mon, 7 Nov 2022 23:40:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=pd0arNR95VOK/awekiE0yD4Gbd4lamiz20GEU5Sf0T4=;
 b=mSFAhTz0Q7MFSv1KfJgzV0wy8gC9ykzP1M5RKLB6A/kfyoKmpAauIHDeaJ4C+zHTVWZq
 L2mqTa1M8vBDQ8yPZxD6QjC1URI3VSE+GLh8e8ZGbaVh9vyOI/iu14aZ9KkODETHgceI
 XcHPtYiopSeRV9rdnkBNw4xb5dHXXatLzmE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqhba0hb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:40:54 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 23:40:53 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id F394011D23313; Mon,  7 Nov 2022 23:40:47 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/8] bpf: Add bpf_rcu_read_lock() support
Date:   Mon, 7 Nov 2022 23:40:47 -0800
Message-ID: <20221108074047.261848-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: P63mcR5aynEIo3qQrCL8HIXfMj9uitFv
X-Proofpoint-GUID: P63mcR5aynEIo3qQrCL8HIXfMj9uitFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, without rcu attribute info in BTF, the verifier treats
rcu tagged pointer as a normal pointer. This might be a problem
for sleepable program where rcu_read_lock()/unlock() is not available.
For example, for a sleepable fentry program, if rcu protected memory
access is interleaved with a sleepable helper/kfunc, it is possible
the memory access after the sleepable helper/kfunc might be invalid
since the object might have been freed then. Even without
a sleepable helper/kfunc, without rcu_read_lock() protection,
it is possible that the rcu protected object might be release
in the middle of bpf program execution which may cause incorrect
result.

To prevent above cases, enable btf_type_tag("rcu") attributes,
introduce new bpf_rcu_read_lock/unlock() kfuncs and add verifier support.

In the rest of patch set, Patch 1 enabled btf_type_tag for __rcu
attribute. Patches 2 and 3 are refactoring patches. Patch 4 added new
bpf_rcu_read_lock/unlock() kfuncs. Patch 5 added verifier support
and Patch 6 enabled sleepable program support for cgrp local storage.
Patch 7 added some tests for new helpers and verifier support and
Patch 8 added new test to the deny list for s390x arch.

Changelogs:
  v1 -> v2:
    . use kfunc instead of helper for bpf_rcu_read_lock/unlock.
    . not use MEM_RCU bpf_type_flag, instead use active_rcu_lock
      in reg state to identify rcu ptr's.
    . Add more self tests.
    . add new test to s390x deny list.

Yonghong Song (8):
  compiler_types: Define __rcu as __attribute__((btf_type_tag("rcu")))
  bpf: Refactor btf_struct_access callback interface
  bpf: Abstract out functions to check sleepable helpers
  bpf: Add kfunc bpf_rcu_read_lock/unlock()
  bpf: Add bpf_rcu_read_lock() verifier support
  bpf: Enable sleeptable support for cgrp local storage
  selftests/bpf: Add tests for bpf_rcu_read_lock()
  selftests/bpf: Add rcu_read_lock test to s390x deny list

 include/linux/bpf.h                           |  15 +-
 include/linux/bpf_lsm.h                       |   6 +
 include/linux/bpf_verifier.h                  |   7 +
 include/linux/btf.h                           |   2 +
 include/linux/compiler_types.h                |   3 +-
 include/linux/filter.h                        |   4 +-
 include/linux/trace_events.h                  |   8 +
 kernel/bpf/bpf_lsm.c                          |  20 +-
 kernel/bpf/btf.c                              |  65 +++-
 kernel/bpf/helpers.c                          |  25 +-
 kernel/bpf/verifier.c                         | 111 +++++-
 kernel/trace/bpf_trace.c                      |  22 +-
 net/bpf/bpf_dummy_struct_ops.c                |   6 +-
 net/core/filter.c                             |  20 +-
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 net/netfilter/nf_conntrack_bpf.c              |   3 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 127 +++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 353 ++++++++++++++++++
 19 files changed, 733 insertions(+), 71 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c

--=20
2.30.2

