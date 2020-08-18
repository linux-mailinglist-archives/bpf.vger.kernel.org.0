Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEDF248B76
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHRQYe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Aug 2020 12:24:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65436 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgHRQYU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Aug 2020 12:24:20 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07IGKgLX005812
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 09:24:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ZXDtoE/e2HiU16gMlnOpPpWEahlTH+2I3M0wYbKf60g=;
 b=VojjPVyAmFIRQQiM3fBWCEVdLdeiTPaN+1RI9oBWeqWJ+FznAhm6Gi2iOpwV+LnSMSGJ
 I2CnZ5pCr5QN33g1O4yoO3xOnrCFszLahCqXCdocR8kCeW2aTbEh2uSj+jnK84DKp3gC
 544a2llbDc2iRBaSCRnWAWDZsbInFpsOehU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p3bknj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 09:24:14 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 09:24:11 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 6F0C53704C6F; Tue, 18 Aug 2020 09:24:08 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 1/2] bpf: fix a rcu_sched stall issue with bpf task/task_file iterator
Date:   Tue, 18 Aug 2020 09:24:08 -0700
Message-ID: <20200818162408.836816-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200818162408.836759-1-yhs@fb.com>
References: <20200818162408.836759-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_11:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=8 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180116
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In our production system, we observed rcu stalls when
'bpftool prog` is running.
  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu: \x097-....: (20999 ticks this GP) idle=3D302/1/0x4000000000000000 =
softirq=3D1508852/1508852 fqs=3D4913
  \x09(t=3D21031 jiffies g=3D2534773 q=3D179750)
  NMI backtrace for cpu 7
  CPU: 7 PID: 184195 Comm: bpftool Kdump: loaded Tainted: G        W     =
    5.8.0-00004-g68bfc7f8c1b4 #6
  Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A1=
7 05/03/2019
  Call Trace:
  <IRQ>
  dump_stack+0x57/0x70
  nmi_cpu_backtrace.cold+0x14/0x53
  ? lapic_can_unplug_cpu.cold+0x39/0x39
  nmi_trigger_cpumask_backtrace+0xb7/0xc7
  rcu_dump_cpu_stacks+0xa2/0xd0
  rcu_sched_clock_irq.cold+0x1ff/0x3d9
  ? tick_nohz_handler+0x100/0x100
  update_process_times+0x5b/0x90
  tick_sched_timer+0x5e/0xf0
  __hrtimer_run_queues+0x12a/0x2a0
  hrtimer_interrupt+0x10e/0x280
  __sysvec_apic_timer_interrupt+0x51/0xe0
  asm_call_on_stack+0xf/0x20
  </IRQ>
  sysvec_apic_timer_interrupt+0x6f/0x80
  asm_sysvec_apic_timer_interrupt+0x12/0x20
  RIP: 0010:task_file_seq_get_next+0x71/0x220
  Code: 00 00 8b 53 1c 49 8b 7d 00 89 d6 48 8b 47 20 44 8b 18 41 39 d3 76=
 75 48 8b 4f 20 8b 01 39 d0 76 61 41 89 d1 49 39 c1 48 19 c0 <48> 8b 49 0=
8 21 d0 48 8d 04 c1 4c 8b 08 4d 85 c9 74 46 49 8b 41 38
  RSP: 0018:ffffc90006223e10 EFLAGS: 00000297
  RAX: ffffffffffffffff RBX: ffff888f0d172388 RCX: ffff888c8c07c1c0
  RDX: 00000000000f017b RSI: 00000000000f017b RDI: ffff888c254702c0
  RBP: ffffc90006223e68 R08: ffff888be2a1c140 R09: 00000000000f017b
  R10: 0000000000000002 R11: 0000000000100000 R12: ffff888f23c24118
  R13: ffffc90006223e60 R14: ffffffff828509a0 R15: 00000000ffffffff
  task_file_seq_next+0x52/0xa0
  bpf_seq_read+0xb9/0x320
  vfs_read+0x9d/0x180
  ksys_read+0x5f/0xe0
  do_syscall_64+0x38/0x60
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7f8815f4f76e
  Code: c0 e9 f6 fe ff ff 55 48 8d 3d 76 70 0a 00 48 89 e5 e8 36 06 02 00=
 66 0f 1f 44 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f=
0 ff ff 77 52 c3 66 0f 1f 84 00 00 00 00 00 55 48 89 e5
  RSP: 002b:00007fff8f9df578 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
  RAX: ffffffffffffffda RBX: 000000000170b9c0 RCX: 00007f8815f4f76e
  RDX: 0000000000001000 RSI: 00007fff8f9df5b0 RDI: 0000000000000007
  RBP: 00007fff8f9e05f0 R08: 0000000000000049 R09: 0000000000000010
  R10: 00007f881601fa40 R11: 0000000000000246 R12: 00007fff8f9e05a8
  R13: 00007fff8f9e05a8 R14: 0000000001917f90 R15: 000000000000e22e

Note that `bpftool prog` actually calls a task_file bpf iterator
program to establish an association between prog/map/link/btf anon
files and processes.

In the case where the above rcu stall occured, we had a process
having 1587 tasks and each task having roughly 81305 files.
This implied 129 million bpf prog invocations. Unfortunwtely none of
these files are prog/map/link/btf files so bpf iterator/prog needs
to traverse all these files and not able to return to user space
since there are no seq_file buffer overflow.

The fix is to add cond_resched() during traversing tasks
and files. So voluntarily releasing cpu gives other tasks, e.g.,
rcu resched kthread, a chance to run.

Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/task_iter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index f21b5e1e4540..885b14cab2c0 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -27,6 +27,8 @@ static struct task_struct *task_seq_get_next(struct pid=
_namespace *ns,
 	struct task_struct *task =3D NULL;
 	struct pid *pid;
=20
+	cond_resched();
+
 	rcu_read_lock();
 retry:
 	pid =3D idr_get_next(&ns->idr, tid);
@@ -137,6 +139,8 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_=
info *info,
 	struct task_struct *curr_task;
 	int curr_fd =3D info->fd;
=20
+	cond_resched();
+
 	/* If this function returns a non-NULL file object,
 	 * it held a reference to the task/files_struct/file.
 	 * Otherwise, it does not hold any reference.
--=20
2.24.1

