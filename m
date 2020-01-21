Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0631C1435E3
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2020 04:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgAUDWo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 20 Jan 2020 22:22:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727009AbgAUDWo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Jan 2020 22:22:44 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00L3MFE2009329
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2020 19:22:43 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2xkxd4hjhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2020 19:22:43 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Jan 2020 19:22:42 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id DAB1E760BA4; Mon, 20 Jan 2020 19:22:31 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jannh@google.com>, <paulmck@kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: Fix trampoline usage in preempt
Date:   Mon, 20 Jan 2020 19:22:31 -0800
Message-ID: <20200121032231.3292185-1-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_10:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=750
 clxscore=1015 suspectscore=3 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210027
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Though the second half of trampoline page is unused a task could be
preempted in the middle of the first half of trampoline and two
updates to trampoline would change the code from underneath the
preempted task. Hence wait for tasks to voluntarily schedule or go
to userspace.
Add similar wait before freeing the trampoline.

Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/trampoline.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 79a04417050d..7657ede7aee2 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -160,6 +160,14 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	if (fexit_cnt)
 		flags = BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
 
+	/* Though the second half of trampoline page is unused a task could be
+	 * preempted in the middle of the first half of trampoline and two
+	 * updates to trampoline would change the code from underneath the
+	 * preempted task. Hence wait for tasks to voluntarily schedule or go
+	 * to userspace.
+	 */
+	synchronize_rcu_tasks();
+
 	err = arch_prepare_bpf_trampoline(new_image, new_image + PAGE_SIZE / 2,
 					  &tr->func.model, flags,
 					  fentry, fentry_cnt,
@@ -251,6 +259,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 		goto out;
 	if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[BPF_TRAMP_FEXIT])))
 		goto out;
+	/* wait for tasks to get out of trampoline before freeing it */
+	synchronize_rcu_tasks();
 	bpf_jit_free_exec(tr->image);
 	hlist_del(&tr->hlist);
 	kfree(tr);
-- 
2.23.0

