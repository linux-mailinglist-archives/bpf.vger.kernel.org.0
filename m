Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904A66248FA
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 19:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiKJSCt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 13:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiKJSC0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 13:02:26 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DACC47314
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:02:06 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAFQv2G014500
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:02:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=F2A6plehrPUA6Hy5MqYis1yg9Ub+V3rmUI5gFYvjk+w=;
 b=T2q2X5SCivGeZSPkfd7yG0mlcKkdtbdZ8pUbs2EEXes9PayQ8Llpm9KXr/0ycruA1Lps
 QAacEFVhd2peNHugcF9miK1CELpC4TQIjGlcdMBMLWKnwEjahrYmYCiOAEGzyeG4KT6S
 wCLTv5m89wAVPeHE4byTFnWmeonDeMnopQA= 
Received: from maileast.thefacebook.com ([163.114.130.3])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3krnrhesfd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:02:06 -0800
Received: from twshared6758.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:02:03 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 94BD411F22E1C; Thu, 10 Nov 2022 10:02:01 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 7/7] selftests/bpf: Add rcu_read_lock test to s390x deny list
Date:   Thu, 10 Nov 2022 10:02:01 -0800
Message-ID: <20221110180201.917531-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110180124.913882-1-yhs@fb.com>
References: <20221110180124.913882-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eqXi3Sue_bapVRBkD_F1sAdiE7S1elAN
X-Proofpoint-ORIG-GUID: eqXi3Sue_bapVRBkD_F1sAdiE7S1elAN
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

The new rcu_read_lock test will fail on s390x with the following error me=
ssage:

  ...
  test_rcu_read_lock:PASS:join_cgroup /rcu_read_lock 0 nsec
  test_local_storage:PASS:skel_open 0 nsec
  libbpf: prog 'cgrp_succ': failed to find kernel BTF type ID of '__s390x=
_sys_getpgid': -3
  libbpf: prog 'cgrp_succ': failed to prepare load attributes: -3
  libbpf: prog 'cgrp_succ': failed to load: -3
  libbpf: failed to load object 'rcu_read_lock'
  libbpf: failed to load BPF skeleton 'rcu_read_lock': -3
  test_local_storage:FAIL:skel_load unexpected error: -3 (errno 3)
  ...

So add it to the s390x deny list.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
index be4e3d47ea3e..dd5db40b5a09 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -41,6 +41,7 @@ module_attach                            # skel_attach =
skeleton attach failed: -
 mptcp
 netcnt                                   # failed to load BPF skeleton '=
netcnt_prog': -7                               (?)
 probe_user                               # check_kprobe_res wrong kprobe=
 res from probe read                           (?)
+rcu_read_lock                            # failed to find kernel BTF typ=
e ID of '__x64_sys_getpgid': -3                (?)
 recursion                                # skel_attach unexpected error:=
 -524                                          (trampoline)
 ringbuf                                  # skel_load skeleton load faile=
d                                              (?)
 select_reuseport                         # intermittently fails on new s=
390x setup
--=20
2.30.2

