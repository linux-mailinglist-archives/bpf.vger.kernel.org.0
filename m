Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455EA617787
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 08:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiKCHVS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 03:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCHVP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 03:21:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B36B24
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 00:21:14 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2NVq5d008259
        for <bpf@vger.kernel.org>; Thu, 3 Nov 2022 00:21:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=mQeDA4CpKaxQ+4HJKD9z4V1U5NBDskcCsr8i1H2Z5lA=;
 b=em2o/k9GQEDCuWxjrvSg9RZsYMJhlAPMlsS+3eXuSPFtpA0dfd+U8BzkyEqIuOR1pOZm
 L7uIq0uf6TdwuRgoAc/GxQSuiII9UAMGk5M+hkV13PYp+yOrswNgYsvqXWel039zoIil
 OPXGIagbeTB3jAI3U7MHH6wkCc2yPLwA7SY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkrv50q5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 00:21:13 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:21:12 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D21F31192D020; Thu,  3 Nov 2022 00:21:02 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 0/5] bpf: Add bpf_rcu_read_lock() support
Date:   Thu, 3 Nov 2022 00:21:02 -0700
Message-ID: <20221103072102.2320490-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vYLihwqwPsPdUXBrFaK0Aqo9nDY6336u
X-Proofpoint-GUID: vYLihwqwPsPdUXBrFaK0Aqo9nDY6336u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
introduce new bpf_rcu_read_lock/unlock() helpers and add verifier support=
.
In the rest of patch set, Patch 1 enabled btf_type_tag for __rcu
attribute. Patch 2 added new bpf_rcu_read_lock/unlock() helpers.
Patch 3 added verifier support and Patch 4 enabled sleepable
program support for cgrp local storage. Patch 5 added some tests
for new helpers and verifier support.

Yonghong Song (5):
  compiler_types: Define __rcu as __attribute__((btf_type_tag("rcu")))
  bpf: Add bpf_rcu_read_lock/unlock helper
  bpf: Add rcu btf_type_tag verifier support
  bpf: Enable sleeptable support for cgrp local storage
  selftests/bpf: Add tests for bpf_rcu_read_lock()

 include/linux/bpf.h                           |   5 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/compiler_types.h                |   3 +-
 include/uapi/linux/bpf.h                      |  14 +
 kernel/bpf/btf.c                              |  11 +
 kernel/bpf/core.c                             |   2 +
 kernel/bpf/helpers.c                          |  26 ++
 kernel/bpf/verifier.c                         | 129 +++++++++-
 tools/include/uapi/linux/bpf.h                |  14 +
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 101 ++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 241 ++++++++++++++++++
 11 files changed, 537 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c

--=20
2.30.2

