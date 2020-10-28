Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB6929D30A
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 22:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgJ1VkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 17:40:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28736 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727180AbgJ1Vj4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 17:39:56 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 09S6AYmp023114
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 23:10:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=U6BoXiWMHGAsm1rlC5G8Hk5JeD1n0A1ivodTLVeGgpU=;
 b=co5mwPz4yk4YgWVuxB5ibUrKqrc6sRh+gkKrXuLoa77IranYoYOSG5u77b2tTfQM2zCg
 Gq60M75kZ7Z7QN+IwVJ2pQuhXk6MW+MiLRJ6shSD6UCpvzyRr0raLlghsZt1Nc5uRRNf
 Ff0ykf5vQweJxBsfzT0rdFdT2ATQE8e5ZHY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34ejk25e5p-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 23:10:56 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 23:10:55 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 679FF37059B3; Tue, 27 Oct 2020 23:10:54 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] bpf: permit cond_resched for some iterators
Date:   Tue, 27 Oct 2020 23:10:54 -0700
Message-ID: <20201028061054.1411116-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_01:2020-10-26,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 suspectscore=13 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit e679654a704e ("bpf: Fix a rcu_sched stall issue with
bpf task/task_file iterator") tries to fix rcu stalls warning
which is caused by bpf task_file iterator when running
"bpftool prog".

      rcu: INFO: rcu_sched self-detected stall on CPU
      rcu: \x097-....: (20999 ticks this GP) idle=3D302/1/0x4000000000000=
000 softirq=3D1508852/1508852 fqs=3D4913
      \x09(t=3D21031 jiffies g=3D2534773 q=3D179750)
      NMI backtrace for cpu 7
      CPU: 7 PID: 184195 Comm: bpftool Kdump: loaded Tainted: G        W =
        5.8.0-00004-g68bfc7f8c1b4 #6
      Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09=
_3A17 05/03/2019
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
      ...
      task_file_seq_next+0x52/0xa0
      bpf_seq_read+0xb9/0x320
      vfs_read+0x9d/0x180
      ksys_read+0x5f/0xe0
      do_syscall_64+0x38/0x60
      entry_SYSCALL_64_after_hwframe+0x44/0xa9

The fix is to limit the number of bpf program runs to be
one million. This fixed the program in most cases. But
we also found under heavy load, which can increase the wallclock
time for bpf_seq_read(), the warning may still be possible.

For example, calling bpf_delay() in the "while" loop of
bpf_seq_read(), which will introduce artificial delay,
the warning will show up in my qemu run.

  static unsigned q;
  volatile unsigned *p =3D &q;
  volatile unsigned long long ll;
  static void bpf_delay(void)
  {
         int i, j;

         for (i =3D 0; i < 10000; i++)
                 for (j =3D 0; j < 10000; j++)
                         ll +=3D *p;
  }

There are two ways to fix this issue. One is to reduce the above
one million threshold to say 100,000 and hopefully rcu warning will
not show up any more. Another is to introduce a target feature
which enables bpf_seq_read() calling cond_resched().

This patch took second approach as the first approach may cause
more -EAGAIN failures for read() syscalls. Note that not all bpf_iter
targets can permit cond_resched() in bpf_seq_read() as some, e.g.,
netlink seq iterator, rcu read lock critical section spans through
seq_ops->next() -> seq_ops->show() -> seq_ops->next().

For the kernel code with the above hack, "bpftool p" roughly takes
38 seconds to finish on my VM with 184 bpf program runs.
Using the following command, I am able to collect the number of
context switches:
   perf stat -e context-switches -- ./bpftool p >& log
Without this patch,
   69      context-switches
With this patch,
   75      context-switches
This patch added additional 6 context switches, roughly every 6 seconds
to reschedule, to avoid lengthy no-rescheduling which may cause the
above RCU warnings.

Signed-off-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h    |  5 +++++
 kernel/bpf/bpf_iter.c  | 14 ++++++++++++++
 kernel/bpf/task_iter.c |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b16bf48aab6..2fffd30e13ac 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1294,6 +1294,10 @@ typedef void (*bpf_iter_show_fdinfo_t) (const stru=
ct bpf_iter_aux_info *aux,
 typedef int (*bpf_iter_fill_link_info_t)(const struct bpf_iter_aux_info =
*aux,
 					 struct bpf_link_info *info);
=20
+enum bpf_iter_feature {
+	BPF_ITER_RESCHED	=3D BIT(0),
+};
+
 #define BPF_ITER_CTX_ARG_MAX 2
 struct bpf_iter_reg {
 	const char *target;
@@ -1302,6 +1306,7 @@ struct bpf_iter_reg {
 	bpf_iter_show_fdinfo_t show_fdinfo;
 	bpf_iter_fill_link_info_t fill_link_info;
 	u32 ctx_arg_info_size;
+	u32 feature;
 	struct bpf_ctx_arg_aux ctx_arg_info[BPF_ITER_CTX_ARG_MAX];
 	const struct bpf_iter_seq_info *seq_info;
 };
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 8f10e30ea0b0..5454161407f1 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -67,6 +67,15 @@ static void bpf_iter_done_stop(struct seq_file *seq)
 	iter_priv->done_stop =3D true;
 }
=20
+static bool bpf_iter_support_resched(struct seq_file *seq)
+{
+	struct bpf_iter_priv_data *iter_priv;
+
+	iter_priv =3D container_of(seq->private, struct bpf_iter_priv_data,
+				 target_private);
+	return iter_priv->tinfo->reg_info->feature & BPF_ITER_RESCHED;
+}
+
 /* maximum visited objects before bailing out */
 #define MAX_ITER_OBJECTS	1000000
=20
@@ -83,6 +92,7 @@ static ssize_t bpf_seq_read(struct file *file, char __u=
ser *buf, size_t size,
 	struct seq_file *seq =3D file->private_data;
 	size_t n, offs, copied =3D 0;
 	int err =3D 0, num_objs =3D 0;
+	bool can_resched;
 	void *p;
=20
 	mutex_lock(&seq->lock);
@@ -135,6 +145,7 @@ static ssize_t bpf_seq_read(struct file *file, char _=
_user *buf, size_t size,
 		goto done;
 	}
=20
+	can_resched =3D bpf_iter_support_resched(seq);
 	while (1) {
 		loff_t pos =3D seq->index;
=20
@@ -180,6 +191,9 @@ static ssize_t bpf_seq_read(struct file *file, char _=
_user *buf, size_t size,
 			}
 			break;
 		}
+
+		if (can_resched)
+			cond_resched();
 	}
 stop:
 	offs =3D seq->count;
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 5b6af30bfbcd..1fdb2fc196cd 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -337,6 +337,7 @@ static const struct bpf_iter_seq_info task_seq_info =3D=
 {
=20
 static struct bpf_iter_reg task_reg_info =3D {
 	.target			=3D "task",
+	.feature		=3D BPF_ITER_RESCHED,
 	.ctx_arg_info_size	=3D 1,
 	.ctx_arg_info		=3D {
 		{ offsetof(struct bpf_iter__task, task),
@@ -354,6 +355,7 @@ static const struct bpf_iter_seq_info task_file_seq_i=
nfo =3D {
=20
 static struct bpf_iter_reg task_file_reg_info =3D {
 	.target			=3D "task_file",
+	.feature		=3D BPF_ITER_RESCHED,
 	.ctx_arg_info_size	=3D 2,
 	.ctx_arg_info		=3D {
 		{ offsetof(struct bpf_iter__task_file, task),
--=20
2.24.1

