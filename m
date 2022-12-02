Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28296411C3
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 00:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiLBX6q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 18:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiLBX6p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 18:58:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D69D2F8
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 15:58:44 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2Nr9ui008327
        for <bpf@vger.kernel.org>; Fri, 2 Dec 2022 15:58:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=/iWhi1S5TNINUO4tJ6UzVXl5bS+E5eKx7ywceHOYyOE=;
 b=FfNurG2R2H1KB53JQaJYX4yg8l0nvJa6KcdVHCpt10sogMXRJ84NHYrGP43XkM1pU5eW
 HWoCjxBL+7inQ6X70QuZAftodqazXtpL4JWw2ep+ZxcxgDZ0IK6SXbCp2T+LZw1uMXdK
 IACQSmLiARYUb+keqZeLGa0d2CC3CsYx8yg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m7tna0ew6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 02 Dec 2022 15:58:43 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 15:58:42 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 78D33C0290C6; Fri,  2 Dec 2022 15:58:37 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix DENYLIST for a name change.
Date:   Fri, 2 Dec 2022 15:58:32 -0800
Message-ID: <20221202235832.3020558-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qCPVCn_eHSQzFhgWsqWoMzqxEAshqRFn
X-Proofpoint-GUID: qCPVCn_eHSQzFhgWsqWoMzqxEAshqRFn
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_12,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After making test_bench_attach serial [0], DENYLIST for aarch64 &
s390x should be updated to filter out this test case.  This test
doesn't work for both platforms at the monent.

[0] https://lore.kernel.org/bpf/20221116100228.2064612-2-jolsa@kernel.org/

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 1 +
 tools/testing/selftests/bpf/DENYLIST.s390x   | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.aarch64

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/s=
elftests/bpf/DENYLIST.aarch64
new file mode 100644
index 000000000000..c1169bfd4f0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -0,0 +1 @@
+kprobe_multi_bench_attach                # bpf_program__attach_kprobe_mult=
i_opts unexpected error: -95
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/sel=
ftests/bpf/DENYLIST.s390x
index 17e074eb42b8..91bd6ef40c7a 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -20,6 +20,7 @@ get_func_ip_test                         # get_func_ip_te=
st__attach unexpected e
 get_stack_raw_tp                         # user_stack corrupted user stack=
                                             (no backchain userspace)
 kfree_skb                                # attach fentry unexpected error:=
 -524                                        (trampoline)
 kfunc_call                               # 'bpf_prog_active': not found in=
 kernel BTF                                  (?)
+kprobe_multi_bench_attach                # bpf_program__attach_kprobe_mult=
i_opts unexpected error: -95
 ksyms_module                             # test_ksyms_module__open_and_loa=
d unexpected error: -9                       (?)
 ksyms_module_libbpf                      # JIT does not support calling ke=
rnel function                                (kfunc)
 ksyms_module_lskel                       # test_ksyms_module_lskel__open_a=
nd_load unexpected error: -9                 (?)
--=20
2.30.2

