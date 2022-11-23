Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B5D634F35
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 05:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiKWEyK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 23:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiKWEyG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 23:54:06 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B83E068F
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 20:54:05 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN1erEH001413
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 20:54:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=5U4vNOl1oJ8DX+nXijmYW5cbn9jSxcCAmadQPIxOLjY=;
 b=J5z8YTp3J9Y0EK+yfm2qVmaLoGhlfA/cRWglBb7f0KtxynWtyYyz6fEevWfTgImbbXCb
 f9LXNWESDCrqX2z2xEY5MguIgsmZ9757DIp63Bb15y7yKk/I6ubQtf6vaku5gdFA2APV
 v7wYF0CEqekkwZK2Q7UbeQAnLWts0hNBdlI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m0m19sqff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 20:54:04 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 20:54:03 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id F272912967A87; Tue, 22 Nov 2022 20:53:50 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v9 0/4] bpf: Add bpf_rcu_read_lock() support
Date:   Tue, 22 Nov 2022 20:53:50 -0800
Message-ID: <20221123045350.2322811-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6_uQ4mOXp6GoBQMSTTW_qHO4iUIhwd7q
X-Proofpoint-GUID: 6_uQ4mOXp6GoBQMSTTW_qHO4iUIhwd7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_02,2022-11-18_01,2022-06-22_01
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
attribute. Patche 2 added might_sleep in bpf_func_proto. Patch 3 added ne=
w
bpf_rcu_read_lock/unlock() kfuncs and verifier support.
Patch 4 added some tests for these two new kfuncs.

Changelogs:
  v8 -> v9:
    . remove sleepable prog check for ld_abs/ind checking in rcu read
      lock region.
    . fix a test failure with gcc-compiled kernel.
    . a couple of other minor fixes.
  v7 -> v8:
    . add might_sleep in bpf_func_proto so we can easily identify whether
      a helper is sleepable or not.              =20
    . do not enforce rcu rules for sleepable, e.g., rcu dereference must
      be in a bpf_rcu_read_lock region. This is to keep old code working
      fine.
    . Mark 'b' in 'b =3D a->b' (b is tagged with __rcu) as MEM_RCU only i=
f
      'b =3D a->b' in rcu read region and 'a' is trusted. This adds safet=
y
      guarantee for 'b' inside the rcu read region.
  v6 -> v7:
    . rebase on top of bpf-next.
    . remove the patch which enables sleepable program using
      cgrp_local_storage map. This is orthogonal to this patch set
      and will be addressed separately.
    . mark the rcu pointer dereference result as UNTRUSTED if inside
      a bpf_rcu_read_lock() region.
  v5 -> v6:
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
  bpf: Introduce might_sleep field in bpf_func_proto
  bpf: Add kfunc bpf_rcu_read_lock/unlock()
  selftests/bpf: Add tests for bpf_rcu_read_lock()

 include/linux/bpf.h                           |   4 +
 include/linux/bpf_verifier.h                  |   4 +-
 include/linux/compiler_types.h                |   3 +-
 kernel/bpf/bpf_lsm.c                          |   6 +-
 kernel/bpf/btf.c                              |   3 +
 kernel/bpf/helpers.c                          |  14 +
 kernel/bpf/verifier.c                         | 160 +++++++--
 kernel/trace/bpf_trace.c                      |   4 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 168 ++++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 305 ++++++++++++++++++
 12 files changed, 638 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c

--=20
2.30.2

