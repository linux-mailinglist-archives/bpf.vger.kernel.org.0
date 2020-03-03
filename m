Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7E178632
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 00:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgCCXQE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 18:16:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29084 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727199AbgCCXQE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Mar 2020 18:16:04 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023NAo2g028073
        for <bpf@vger.kernel.org>; Tue, 3 Mar 2020 15:16:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ExfCMgF1BShdb9/Ewg/f0dfTVTc2Ayan0TNC7Ai3nXI=;
 b=JgdvLrwlclPBqgqcZiULc7H6TDqJuKl0qXpbci4bkij+ork6YMyFLJGDyc/o+XfVjaZ+
 oCVGNlt6Eqoa27C2QjiIZO2V81sCRDJQ+Ny8EPNhjuM9XNb/Wz4IU0KHssSqR7XW1ffO
 nEl8cNCoANICEvG5XBnyzBjfjpOcT9xvPv4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yht6y2hkx-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 15:16:03 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 3 Mar 2020 15:15:56 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id D912A37010D2; Tue,  3 Mar 2020 15:15:54 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 1/2] bpf: fix bpf_send_signal()/bpf_send_signal_thread() helper in NMI mode
Date:   Tue, 3 Mar 2020 15:15:54 -0800
Message-ID: <20200303231554.2553178-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303231554.2553105-1-yhs@fb.com>
References: <20200303231554.2553105-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_08:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 suspectscore=13 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003030151
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When experimenting with bpf_send_signal() helper in our production environment,
we experienced a deadlock in NMI mode:
   #0 [fffffe000046be58] crash_nmi_callback at ffffffff8103f48b
   #1 [fffffe000046be60] nmi_handle at ffffffff8101feed
   #2 [fffffe000046beb8] default_do_nmi at ffffffff8102027e
   #3 [fffffe000046bed8] do_nmi at ffffffff81020434
   #4 [fffffe000046bef0] end_repeat_nmi at ffffffff81c01093
      [exception RIP: queued_spin_lock_slowpath+68]
      RIP: ffffffff8110be24  RSP: ffffc9002219f770  RFLAGS: 00000002
      RAX: 0000000000000101  RBX: 0000000000000046  RCX: 000000000000002a
      RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffff88871c96c044
      RBP: 0000000000000000   R8: ffff88870f11f040   R9: 0000000000000000
      R10: 0000000000000008  R11: 00000000acd93e4d  R12: ffff88871c96c044
      R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000001
      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
  --- <NMI exception stack> ---
   #5 [ffffc9002219f770] queued_spin_lock_slowpath at ffffffff8110be24
   #6 [ffffc9002219f770] _raw_spin_lock_irqsave at ffffffff81a43012
   #7 [ffffc9002219f780] try_to_wake_up at ffffffff810e7ecd
   #8 [ffffc9002219f7e0] signal_wake_up_state at ffffffff810c7b55
   #9 [ffffc9002219f7f0] __send_signal at ffffffff810c8602
  #10 [ffffc9002219f830] do_send_sig_info at ffffffff810ca31a
  #11 [ffffc9002219f868] bpf_send_signal at ffffffff8119d227
  #12 [ffffc9002219f988] bpf_overflow_handler at ffffffff811d4140
  #13 [ffffc9002219f9e0] __perf_event_overflow at ffffffff811d68cf
  #14 [ffffc9002219fa10] perf_swevent_overflow at ffffffff811d6a09
  #15 [ffffc9002219fa38] ___perf_sw_event at ffffffff811e0f47
  #16 [ffffc9002219fc30] __schedule at ffffffff81a3e04d
  #17 [ffffc9002219fc90] schedule at ffffffff81a3e219
  #18 [ffffc9002219fca0] futex_wait_queue_me at ffffffff8113d1b9
  #19 [ffffc9002219fcd8] futex_wait at ffffffff8113e529
  #20 [ffffc9002219fdf0] do_futex at ffffffff8113ffbc
  #21 [ffffc9002219fec0] __x64_sys_futex at ffffffff81140d1c
  #22 [ffffc9002219ff38] do_syscall_64 at ffffffff81002602
  #23 [ffffc9002219ff50] entry_SYSCALL_64_after_hwframe at ffffffff81c00068

Basically, when task->pi_lock is taken, a NMI happens, bpf program executes,
which calls bpf program. The bpf program calls bpf_send_signal() helper,
which will call group_send_sig_info() in irq_work, which will try to
grab task->pi_lock again and failed due to deadlock.

To break the deadlock, group_send_sig_info() call should be delayed
until it is safe to do.

This patch registers a task_work callback inside the irq_work so
group_send_sig_info() in the task_work can be called later safely.

This patch also fixed a potential issue where the "current"
task in nmi context is gone when the actual irq_work is triggered.
Hold a reference to the task and drop the reference inside
the irq_work to ensure the task is not gone.

Fixes: 8482941f0906 ("bpf: Add bpf_send_signal_thread() helper")
Fixes: 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
Cc: Rik van Riel <riel@surriel.com>
Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 07764c761073..db7b6194e38a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -12,6 +12,7 @@
 #include <linux/ctype.h>
 #include <linux/kprobes.h>
 #include <linux/syscalls.h>
+#include <linux/task_work.h>
 #include <linux/error-injection.h>
 
 #include <asm/tlb.h>
@@ -697,6 +698,36 @@ static const struct bpf_func_proto bpf_current_task_under_cgroup_proto = {
 	.arg2_type      = ARG_ANYTHING,
 };
 
+struct send_signal_work_cb {
+	struct callback_head twork;
+	u32 sig;
+	enum pid_type type;
+};
+
+static void do_send_signal_work(struct callback_head *twork)
+{
+	struct send_signal_work_cb *twcb = container_of(twork,
+			struct send_signal_work_cb, twork);
+
+	group_send_sig_info(twcb->sig, SEND_SIG_PRIV, current, twcb->type);
+	kfree(twcb);
+}
+
+static void add_send_signal_task_work(u32 sig, enum pid_type type)
+{
+	struct send_signal_work_cb *twcb;
+
+	twcb = kzalloc(sizeof(*twcb), GFP_ATOMIC);
+	if (!twcb)
+		return;
+
+	twcb->sig = sig;
+	twcb->type = type;
+	init_task_work(&twcb->twork, do_send_signal_work);
+	if (task_work_add(current, &twcb->twork, true))
+		kfree(twcb);
+}
+
 struct send_signal_irq_work {
 	struct irq_work irq_work;
 	struct task_struct *task;
@@ -711,7 +742,10 @@ static void do_bpf_send_signal(struct irq_work *entry)
 	struct send_signal_irq_work *work;
 
 	work = container_of(entry, struct send_signal_irq_work, irq_work);
-	group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->type);
+	if (work->task == current && !(current->flags & PF_EXITING))
+		add_send_signal_task_work(work->sig, work->type);
+
+	put_task_struct(work->task);
 }
 
 static int bpf_send_signal_common(u32 sig, enum pid_type type)
@@ -745,7 +779,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 		 * to the irq_work. The current task may change when queued
 		 * irq works get executed.
 		 */
-		work->task = current;
+		work->task = get_task_struct(current);
 		work->sig = sig;
 		work->type = type;
 		irq_work_queue(&work->irq_work);
-- 
2.17.1

