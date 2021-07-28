Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A663D942D
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhG1RXQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:23:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhG1RXQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jul 2021 13:23:16 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SHDGNT018327
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:23:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=T27utM/zPFZAT6o0yE5+NYbVS0uSkV+QDl8gjijWliA=;
 b=ZBbWE0uiL2lWVMgziSQdQoJip3iVFzoEFdXRnd0fbGWrpId2Jy6ZuVm6tXh7gWNmvXWS
 hEUrnASSZZg4YxPvV9YXi1/OqlT4Bg83hSlmxxHuvgg80waDut2HyVSyJGZY+WMTAX7d
 MOpi+xvfNtnpVv74xLdTUjWK7RNFbnLs/UI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a2bfcb9g7-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:23:14 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 10:23:09 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 4990D559B38F; Wed, 28 Jul 2021 10:23:07 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com>
Subject: [PATCH bpf] bpf: fix rcu warning in bpf_prog_run_pin_on_cpu()
Date:   Wed, 28 Jul 2021 10:23:07 -0700
Message-ID: <20210728172307.1030271-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: C6zvAiob9YrXA67weP94zbLURfYpdmc_
X-Proofpoint-ORIG-GUID: C6zvAiob9YrXA67weP94zbLURfYpdmc_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=860
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot reported a RCU warning like below:
  WARNING: suspicious RCU usage
  ...
  Call Trace:
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
   task_css_set include/linux/cgroup.h:481 [inline]
   task_dfl_cgroup include/linux/cgroup.h:550 [inline]
   ____bpf_get_current_cgroup_id kernel/bpf/helpers.c:356 [inline]
   bpf_get_current_cgroup_id+0x1ce/0x210 kernel/bpf/helpers.c:354
   bpf_prog_08c4887f705f20b8+0x10/0x824
   bpf_dispatcher_nop_func include/linux/bpf.h:687 [inline]
   bpf_prog_run_pin_on_cpu include/linux/filter.h:624 [inline]
   bpf_prog_test_run_syscall+0x2cf/0x5f0 net/bpf/test_run.c:954
   bpf_prog_test_run kernel/bpf/syscall.c:3207 [inline]
   __sys_bpf+0x1993/0x53b0 kernel/bpf/syscall.c:4487

The warning is introduced by Commit 79a7f8bdb159d
("bpf: Introduce bpf_sys_bpf() helper and program type.").
The rcu_read_lock/unlock() is missing when calling
bpf_prog_run_pin_on_cpu().

Previously, bpf_prog_run_pin_on_cpu() is simply BPF_PROG_RUN
macro and if necessary functions using BPF_PROG_RUN all have proper
rcu_read_lock/unlock() protections.
Commit 3c58482a382ba ("bpf: Provide bpf_prog_run_pin_on_cpu() helper")
added bpf_prog_run_pin_on_cpu() helper in order to add
migrate_disable/enable() support.
Commit 79a7f8bdb159d later called bpf_prog_run_pin_on_cpu()
but didn't have rcu_read_lock/unlock() at the callsite which
triggered the reason.

I added rcu lock protection in bpf_prog_test_run_syscall()
which fixed the issue. Alternatively, rcu lock protection
could be added in bpf_prog_test_run_syscall() and some rcu
lock protection in bpf_prog_test_run_syscall() callers
can be removed. I feel the later is a bigger change for
bpf tree. So I picked the simpler solution.

Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
Fixes: 79a7f8bdb159d ("bpf: Introduce bpf_sys_bpf() helper and program ty=
pe.")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 net/bpf/test_run.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 1cc75c811e24..a350b185d9d2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -951,7 +951,10 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 			goto out;
 		}
 	}
+
+	rcu_read_lock();
 	retval =3D bpf_prog_run_pin_on_cpu(prog, ctx);
+	rcu_read_unlock();
=20
 	if (copy_to_user(&uattr->test.retval, &retval, sizeof(u32))) {
 		err =3D -EFAULT;
--=20
2.30.2

