Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E216248F0
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 19:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKJSCN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 13:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiKJSBd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 13:01:33 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441FE45EF7
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:01:30 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAF8WPp013987
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:01:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=qz3a3fcPTbGQ425kaLAkRyl639NdRJb+6h0/Se832Hs=;
 b=aaYHOqkQVeXFDTz10keDyjSAnOVqM63M1KuamoIziwFxaqS6HhdVunDuVNTun2sFAop4
 9oQk+iCzCojpNFzf+bbaUEe+izAW0mafdD6P2pq3BQlHryS0WMypQXz00u3KOUxDUgGy
 AetL2bk+sy7iJa9b76918mSOBRYoUdhDc+I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3krnrhes7r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:01:29 -0800
Received: from twshared6758.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:01:28 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D416E11F22DA7; Thu, 10 Nov 2022 10:01:24 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 0/7] bpf: Add bpf_rcu_read_lock() support
Date:   Thu, 10 Nov 2022 10:01:24 -0800
Message-ID: <20221110180124.913882-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2m_LmoCahhVqMpTHs35Pf2Io3bY53VWG
X-Proofpoint-ORIG-GUID: 2m_LmoCahhVqMpTHs35Pf2Io3bY53VWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
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
bpf_rcu_read_lock/unlock() kfuncs. Patch 4 added verifier support
and Patch 5 enabled sleepable program support for cgrp local storage.
Patch 6 added some tests for new helpers and verifier support and
Patch 7 added new test to the deny list for s390x arch.

Changelogs:
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

Yonghong Song (7):
  compiler_types: Define __rcu as __attribute__((btf_type_tag("rcu")))
  bpf: Abstract out functions to check sleepable helpers
  bpf: Add kfunc bpf_rcu_read_lock/unlock()
  bpf: Add bpf_rcu_read_lock() verifier support
  bpf: Enable sleeptable support for cgrp local storage
  selftests/bpf: Add tests for bpf_rcu_read_lock()
  selftests/bpf: Add rcu_read_lock test to s390x deny list

 include/linux/bpf.h                           |   6 +
 include/linux/bpf_lsm.h                       |   6 +
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/compiler_types.h                |   3 +-
 include/linux/trace_events.h                  |   8 +
 kernel/bpf/bpf_lsm.c                          |  20 +-
 kernel/bpf/btf.c                              |  39 +-
 kernel/bpf/helpers.c                          |  25 +-
 kernel/bpf/verifier.c                         | 125 +++++-
 kernel/trace/bpf_trace.c                      |  22 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 166 ++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 355 ++++++++++++++++++
 13 files changed, 758 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c

--=20
2.30.2

