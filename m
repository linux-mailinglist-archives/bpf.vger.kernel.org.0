Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B593064ABB8
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 00:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiLLXrS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 18:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiLLXqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 18:46:53 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA051D0CB
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 15:46:22 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCMc4CO029036
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 15:46:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=boUxM9EsDtDBAnvZ0mZEMN7T3FEyvB18oLMpxSitfew=;
 b=cdV0K0LkAE+cLg4jessg0N63ynTHzULiqgwkbrZ8UkYZAzbgD56eg4Q2iGmHgcG3Nt1N
 csbyAacZ1BnU7K4krNTcW9dFfH91+rFe60hng/QSXXuCPfNLhW43C5nJVst5sQv4joJ2
 Uv4A2PZO9RaBLuwpUX+EysseL2k9slhWpio= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me4bke284-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 15:46:22 -0800
Received: from twshared0705.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 15:46:20 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6A51E139BAD1C; Mon, 12 Dec 2022 15:46:17 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf] selftests/bpf: Fix a selftest compilation error with CONFIG_SMP=n
Date:   Mon, 12 Dec 2022 15:46:17 -0800
Message-ID: <20221212234617.4058942-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HPq2PoYEn33t209Lp2GjwcycGpxBL1WW
X-Proofpoint-GUID: HPq2PoYEn33t209Lp2GjwcycGpxBL1WW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kernel test robot reported bpf selftest build failure when CONFIG_SMP
is not set. The error message looks below:

  >> progs/rcu_read_lock.c:256:34: error: no member named 'last_wakee' in=
 'struct task_struct'
             last_wakee =3D task->real_parent->last_wakee;
                          ~~~~~~~~~~~~~~~~~  ^
     1 error generated.

When CONFIG_SMP is not set, the field 'last_wakee' is not available in st=
ruct
'task_struct'. Hence the above compilation failure. To fix the issue, let=
 us
choose another field 'group_leader' which is available regardless of
CONDFIG_SMP set or not.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/rcu_read_lock.c      | 8 ++++----
 tools/testing/selftests/bpf/progs/task_kfunc_failure.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
index 125f908024d3..5cecbdbbb16e 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -288,13 +288,13 @@ int nested_rcu_region(void *ctx)
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 int task_untrusted_non_rcuptr(void *ctx)
 {
-	struct task_struct *task, *last_wakee;
+	struct task_struct *task, *group_leader;
=20
 	task =3D bpf_get_current_task_btf();
 	bpf_rcu_read_lock();
-	/* the pointer last_wakee marked as untrusted */
-	last_wakee =3D task->real_parent->last_wakee;
-	(void)bpf_task_storage_get(&map_a, last_wakee, 0, 0);
+	/* the pointer group_leader marked as untrusted */
+	group_leader =3D task->real_parent->group_leader;
+	(void)bpf_task_storage_get(&map_a, group_leader, 0, 0);
 	bpf_rcu_read_unlock();
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_failure.c
index 87fa1db9d9b5..1b47b94dbca0 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -73,7 +73,7 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct =
task_struct *task, u64 cl
 	struct task_struct *acquired;
=20
 	/* Can't invoke bpf_task_acquire() on a trusted pointer obtained from w=
alking a struct. */
-	acquired =3D bpf_task_acquire(task->last_wakee);
+	acquired =3D bpf_task_acquire(task->group_leader);
 	bpf_task_release(acquired);
=20
 	return 0;
--=20
2.30.2

