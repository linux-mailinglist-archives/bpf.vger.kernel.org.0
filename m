Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716092D7C8B
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 18:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394408AbgLKRMl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 11 Dec 2020 12:12:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35590 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394874AbgLKRM3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Dec 2020 12:12:29 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BBH93qP030658
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 09:11:48 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35cacsrwqh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 09:11:48 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 11 Dec 2020 09:11:46 -0800
Received: by devvm2494.atn0.facebook.com (Postfix, from userid 172786)
        id B7F445283264; Fri, 11 Dec 2020 09:11:38 -0800 (PST)
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
To:     <netdev@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <yhs@fb.com>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>
Subject: [PATCH 1/1 v3 bpf-next] bpf: increment and use correct thread iterator
Date:   Fri, 11 Dec 2020 09:11:38 -0800
Message-ID: <20201211171138.63819-2-jonathan.lemon@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201211171138.63819-1-jonathan.lemon@gmail.com>
References: <20201211171138.63819-1-jonathan.lemon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_05:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1034 mlxlogscore=974
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jonathan Lemon <bsd@fb.com>

On some systems, some variant of the following splat is
repeatedly seen.  The common factor in all traces seems
to be the entry point to task_file_seq_next().  With the
patch, all warnings go away.

    rcu: INFO: rcu_sched self-detected stall on CPU
    rcu: \x0926-....: (20992 ticks this GP) idle=d7e/1/0x4000000000000002 softirq=81556231/81556231 fqs=4876
    \x09(t=21033 jiffies g=159148529 q=223125)
    NMI backtrace for cpu 26
    CPU: 26 PID: 2015853 Comm: bpftool Kdump: loaded Not tainted 5.6.13-0_fbk4_3876_gd8d1f9bf80bb #1
    Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A12 10/08/2018
    Call Trace:
     <IRQ>
     dump_stack+0x50/0x70
     nmi_cpu_backtrace.cold.6+0x13/0x50
     ? lapic_can_unplug_cpu.cold.30+0x40/0x40
     nmi_trigger_cpumask_backtrace+0xba/0xca
     rcu_dump_cpu_stacks+0x99/0xc7
     rcu_sched_clock_irq.cold.90+0x1b4/0x3aa
     ? tick_sched_do_timer+0x60/0x60
     update_process_times+0x24/0x50
     tick_sched_timer+0x37/0x70
     __hrtimer_run_queues+0xfe/0x270
     hrtimer_interrupt+0xf4/0x210
     smp_apic_timer_interrupt+0x5e/0x120
     apic_timer_interrupt+0xf/0x20
     </IRQ>
    RIP: 0010:get_pid_task+0x38/0x80
    Code: 89 f6 48 8d 44 f7 08 48 8b 00 48 85 c0 74 2b 48 83 c6 55 48 c1 e6 04 48 29 f0 74 19 48 8d 78 20 ba 01 00 00 00 f0 0f c1 50 20 <85> d2 74 27 78 11 83 c2 01 78 0c 48 83 c4 08 c3 31 c0 48 83 c4 08
    RSP: 0018:ffffc9000d293dc8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
    RAX: ffff888637c05600 RBX: ffffc9000d293e0c RCX: 0000000000000000
    RDX: 0000000000000001 RSI: 0000000000000550 RDI: ffff888637c05620
    RBP: ffffffff8284eb80 R08: ffff88831341d300 R09: ffff88822ffd8248
    R10: ffff88822ffd82d0 R11: 00000000003a93c0 R12: 0000000000000001
    R13: 00000000ffffffff R14: ffff88831341d300 R15: 0000000000000000
     ? find_ge_pid+0x1b/0x20
     task_seq_get_next+0x52/0xc0
     task_file_seq_get_next+0x159/0x220
     task_file_seq_next+0x4f/0xa0
     bpf_seq_read+0x159/0x390
     vfs_read+0x8a/0x140
     ksys_read+0x59/0xd0
     do_syscall_64+0x42/0x110
     entry_SYSCALL_64_after_hwframe+0x44/0xa9
    RIP: 0033:0x7f95ae73e76e
    Code: Bad RIP value.
    RSP: 002b:00007ffc02c1dbf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
    RAX: ffffffffffffffda RBX: 000000000170faa0 RCX: 00007f95ae73e76e
    RDX: 0000000000001000 RSI: 00007ffc02c1dc30 RDI: 0000000000000007
    RBP: 00007ffc02c1ec70 R08: 0000000000000005 R09: 0000000000000006
    R10: fffffffffffff20b R11: 0000000000000246 R12: 00000000019112a0
    R13: 0000000000000000 R14: 0000000000000007 R15: 00000000004283c0

The attached patch does 3 things:

1) If unable to obtain the file structure for the current task,
   proceed to the next task number after the one returned from
   task_seq_get_next(), instead of the next task number from the
   original iterator.

2) Use thread_group_leader() instead of the open-coded comparision
   of tgid vs pid.

3) Only obtain the task reference count at the end of the RCU section
   instead of repeatedly obtaining/releasing it when iterathing though
   a thread group.

Fixes: a650da2ee52a ("bpf: Add task and task/file iterator targets")
Fixes: 67b6b863e6ab ("bpf: Avoid iterating duplicated files for task_file iterator")

Signed-off-by: Jonathan Lemon <jonathan.lemon@gmail.com>
---
 kernel/bpf/task_iter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 0458a40edf10..66a52fcf589a 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -33,17 +33,17 @@ static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
 	pid = find_ge_pid(*tid, ns);
 	if (pid) {
 		*tid = pid_nr_ns(pid, ns);
-		task = get_pid_task(pid, PIDTYPE_PID);
+		task = pid_task(pid, PIDTYPE_PID);
 		if (!task) {
 			++*tid;
 			goto retry;
-		} else if (skip_if_dup_files && task->tgid != task->pid &&
+		} else if (skip_if_dup_files && !thread_group_leader(task) &&
 			   task->files == task->group_leader->files) {
-			put_task_struct(task);
 			task = NULL;
 			++*tid;
 			goto retry;
 		}
+		get_task_struct(task);
 	}
 	rcu_read_unlock();
 
@@ -164,7 +164,7 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 		curr_files = get_files_struct(curr_task);
 		if (!curr_files) {
 			put_task_struct(curr_task);
-			curr_tid = ++(info->tid);
+			curr_tid = curr_tid + 1;
 			info->fd = 0;
 			goto again;
 		}
-- 
2.24.1

