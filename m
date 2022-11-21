Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0E632A43
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKURFZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 12:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKURFY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 12:05:24 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F88C67E5
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:05:23 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALDmkpo006243
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:05:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=kz+VZhpHCF78jJbRnLgP/DT8adAIQT6AE/RN6h3wVUw=;
 b=eXUnLglqvC0CH+39/STBx1Oau2pAHO5X1R0qQ8VIoM+VVT8FyQXEOBfIXetMTV7yF2IY
 4WrmKkiT1Z3Q6mkh9m+h/UQpS0ZKnT9jJBK3nVJWYlkDhu5deFQ0/TR84j8yzm0/WEw2
 Aac1qIg+l+/zqwWo3iNwg+cBhvnVQlnRcYM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxws6xcpt-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:05:22 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 09:05:19 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 306D81282A53B; Mon, 21 Nov 2022 09:05:15 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v7 0/4] bpf: Add bpf_rcu_read_lock() support
Date:   Mon, 21 Nov 2022 09:05:15 -0800
Message-ID: <20221121170515.1193967-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nGWGI7bATalJMRqEquDC8zi8lJrY9uwy
X-Proofpoint-ORIG-GUID: nGWGI7bATalJMRqEquDC8zi8lJrY9uwy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
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
attribute. Patche 2 is a refactoring patch. Patch 3 added new
bpf_rcu_read_lock/unlock() kfuncs and verifier support.
Patch 4 added some tests for these two new kfuncs.

Changelogs:
  v6 -> v7:
    . rebase on top of bpf-next.
    . remove the patch which enables sleepable program using
      cgrp_local_storage map. This is orthogonal to this patch set
      and will be addressed separately.
    . mark the rcu pointer dereference result as UNTRUSTED if inside
      a bpf_rcu_read_lock() region.
  v5 -> v6:=20
    . fix selftest prog miss_unlock which tested nested locking.
    . add comments in selftest prog cgrp_succ to explain how to handle
      nested memory access after rcu memory load.
  v4 -> v5:
    . add new test to aarch64 deny list.
  v3 -> v4:
    . fix selftest failures when built with gcc. gcc doesn't support
      btf_type_tag yet and some tests relies on that. skip these
      tests if vmlinux BTF does not have btf_type_tag("rcu").
  v2 -> v3:
    . went back to MEM_RCU approach with invalidate rcu ptr registers
      at bpf_rcu_read_unlock() place.
    . remove KF_RCU_LOCK/UNLOCK flag and compare btf_id at verification
      time instead.
  v1 -> v2:
    . use kfunc instead of helper for bpf_rcu_read_lock/unlock.
    . not use MEM_RCU bpf_type_flag, instead use active_rcu_lock
      in reg state to identify rcu ptr's.
    . Add more self tests.
    . add new test to s390x deny list.

Yonghong Song (4):
  compiler_types: Define __rcu as __attribute__((btf_type_tag("rcu")))
  bpf: Abstract out functions to check sleepable helpers
  bpf: Add kfunc bpf_rcu_read_lock/unlock()
  selftests/bpf: Add tests for bpf_rcu_read_lock()

 include/linux/bpf.h                           |   3 +
 include/linux/bpf_lsm.h                       |   6 +
 include/linux/bpf_verifier.h                  |   2 +
 include/linux/compiler_types.h                |   3 +-
 include/linux/trace_events.h                  |   8 +
 kernel/bpf/bpf_lsm.c                          |  20 +-
 kernel/bpf/btf.c                              |   3 +
 kernel/bpf/helpers.c                          |  12 +
 kernel/bpf/verifier.c                         | 156 ++++++++-
 kernel/trace/bpf_trace.c                      |  22 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 153 +++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 325 ++++++++++++++++++
 14 files changed, 695 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c

--=20
2.30.2

