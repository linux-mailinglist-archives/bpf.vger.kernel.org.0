Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F462225DC9
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgGTLsa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 07:48:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21253 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728540AbgGTLsa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Jul 2020 07:48:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KBWFT5013621;
        Mon, 20 Jul 2020 07:48:16 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32d7b7xd8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 07:48:16 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KBfgWx027342;
        Mon, 20 Jul 2020 11:48:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 32brq7jm21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 11:48:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06KBmBZa23855608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 11:48:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FDFF4C040;
        Mon, 20 Jul 2020 11:48:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ECD94C046;
        Mon, 20 Jul 2020 11:48:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.6.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 11:48:10 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] samples/bpf, selftests/bpf: use bpf_probe_read_kernel
Date:   Mon, 20 Jul 2020 13:48:06 +0200
Message-Id: <20200720114806.88823-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_06:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200079
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A handful of samples and selftests fail to build on s390, because
after commit 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}()
only to archs where they work") bpf_probe_read is not available
anymore.

Fix by using bpf_probe_read_kernel.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 samples/bpf/offwaketime_kern.c                       |  7 ++++++-
 samples/bpf/test_overhead_kprobe_kern.c              | 12 +++++++++---
 samples/bpf/tracex1_kern.c                           |  9 +++++++--
 samples/bpf/tracex5_kern.c                           |  4 ++--
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c            |  3 ++-
 tools/testing/selftests/bpf/progs/bpf_iter_netlink.c |  6 +++---
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c    |  2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c    |  2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c    |  2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c    |  2 +-
 10 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/samples/bpf/offwaketime_kern.c b/samples/bpf/offwaketime_kern.c
index d459f73412a4..e74ee1cd4b9c 100644
--- a/samples/bpf/offwaketime_kern.c
+++ b/samples/bpf/offwaketime_kern.c
@@ -12,7 +12,12 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-#define _(P) ({typeof(P) val; bpf_probe_read(&val, sizeof(val), &P); val;})
+#define _(P)                                                                   \
+	({                                                                     \
+		typeof(P) val;                                                 \
+		bpf_probe_read_kernel(&val, sizeof(val), &(P));                \
+		val;                                                           \
+	})
 
 #define MINBLOCK_US	1
 
diff --git a/samples/bpf/test_overhead_kprobe_kern.c b/samples/bpf/test_overhead_kprobe_kern.c
index 8b811c29dc79..f6d593e47037 100644
--- a/samples/bpf/test_overhead_kprobe_kern.c
+++ b/samples/bpf/test_overhead_kprobe_kern.c
@@ -10,7 +10,12 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-#define _(P) ({typeof(P) val = 0; bpf_probe_read(&val, sizeof(val), &P); val;})
+#define _(P)                                                                   \
+	({                                                                     \
+		typeof(P) val = 0;                                             \
+		bpf_probe_read_kernel(&val, sizeof(val), &(P));                \
+		val;                                                           \
+	})
 
 SEC("kprobe/__set_task_comm")
 int prog(struct pt_regs *ctx)
@@ -25,8 +30,9 @@ int prog(struct pt_regs *ctx)
 	tsk = (void *)PT_REGS_PARM1(ctx);
 
 	pid = _(tsk->pid);
-	bpf_probe_read(oldcomm, sizeof(oldcomm), &tsk->comm);
-	bpf_probe_read(newcomm, sizeof(newcomm), (void *)PT_REGS_PARM2(ctx));
+	bpf_probe_read_kernel(oldcomm, sizeof(oldcomm), &tsk->comm);
+	bpf_probe_read_kernel(newcomm, sizeof(newcomm),
+			      (void *)PT_REGS_PARM2(ctx));
 	signal = _(tsk->signal);
 	oom_score_adj = _(signal->oom_score_adj);
 	return 0;
diff --git a/samples/bpf/tracex1_kern.c b/samples/bpf/tracex1_kern.c
index 8e2610e14475..3f4599c9a202 100644
--- a/samples/bpf/tracex1_kern.c
+++ b/samples/bpf/tracex1_kern.c
@@ -11,7 +11,12 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-#define _(P) ({typeof(P) val = 0; bpf_probe_read(&val, sizeof(val), &P); val;})
+#define _(P)                                                                   \
+	({                                                                     \
+		typeof(P) val = 0;                                             \
+		bpf_probe_read_kernel(&val, sizeof(val), &(P));                \
+		val;                                                           \
+	})
 
 /* kprobe is NOT a stable ABI
  * kernel functions can be removed, renamed or completely change semantics.
@@ -34,7 +39,7 @@ int bpf_prog1(struct pt_regs *ctx)
 	dev = _(skb->dev);
 	len = _(skb->len);
 
-	bpf_probe_read(devname, sizeof(devname), dev->name);
+	bpf_probe_read_kernel(devname, sizeof(devname), dev->name);
 
 	if (devname[0] == 'l' && devname[1] == 'o') {
 		char fmt[] = "skb %p len %d\n";
diff --git a/samples/bpf/tracex5_kern.c b/samples/bpf/tracex5_kern.c
index 32b49e8ab6bd..64a1f7550d7e 100644
--- a/samples/bpf/tracex5_kern.c
+++ b/samples/bpf/tracex5_kern.c
@@ -47,7 +47,7 @@ PROG(SYS__NR_write)(struct pt_regs *ctx)
 {
 	struct seccomp_data sd;
 
-	bpf_probe_read(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
+	bpf_probe_read_kernel(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
 	if (sd.args[2] == 512) {
 		char fmt[] = "write(fd=%d, buf=%p, size=%d)\n";
 		bpf_trace_printk(fmt, sizeof(fmt),
@@ -60,7 +60,7 @@ PROG(SYS__NR_read)(struct pt_regs *ctx)
 {
 	struct seccomp_data sd;
 
-	bpf_probe_read(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
+	bpf_probe_read_kernel(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
 	if (sd.args[2] > 128 && sd.args[2] <= 1024) {
 		char fmt[] = "read(fd=%d, buf=%p, size=%d)\n";
 		bpf_trace_printk(fmt, sizeof(fmt),
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index 8468a608911e..d9b420972934 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -71,7 +71,8 @@ int iter(struct bpf_iter__task_file *ctx)
 
 	e.pid = task->tgid;
 	e.id = get_obj_id(file->private_data, obj_type);
-	bpf_probe_read(&e.comm, sizeof(e.comm), task->group_leader->comm);
+	bpf_probe_read_kernel(&e.comm, sizeof(e.comm),
+			      task->group_leader->comm);
 	bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
index 7de98a68599a..95989f4c99b5 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
@@ -36,10 +36,10 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
 	if (!nlk->groups)  {
 		group = 0;
 	} else {
-		/* FIXME: temporary use bpf_probe_read here, needs
+		/* FIXME: temporary use bpf_probe_read_kernel here, needs
 		 * verifier support to do direct access.
 		 */
-		bpf_probe_read(&group, sizeof(group), &nlk->groups[0]);
+		bpf_probe_read_kernel(&group, sizeof(group), &nlk->groups[0]);
 	}
 	BPF_SEQ_PRINTF(seq, "%-10u %08x %-8d %-8d %-5d %-8d ",
 		       nlk->portid, (u32)group,
@@ -56,7 +56,7 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
 		 * with current verifier.
 		 */
 		inode = SOCK_INODE(sk);
-		bpf_probe_read(&ino, sizeof(ino), &inode->i_ino);
+		bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
 	}
 	BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n", s->sk_drops.counter, ino);
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index 30fd587cb325..54380c5e1069 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -57,7 +57,7 @@ static long sock_i_ino(const struct sock *sk)
 		return 0;
 
 	inode = &container_of(sk_socket, struct socket_alloc, socket)->vfs_inode;
-	bpf_probe_read(&ino, sizeof(ino), &inode->i_ino);
+	bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
 	return ino;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index 10dec4392031..b4fbddfa4e10 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -57,7 +57,7 @@ static long sock_i_ino(const struct sock *sk)
 		return 0;
 
 	inode = &container_of(sk_socket, struct socket_alloc, socket)->vfs_inode;
-	bpf_probe_read(&ino, sizeof(ino), &inode->i_ino);
+	bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
 	return ino;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
index 7053784575e4..f258583afbbd 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
@@ -18,7 +18,7 @@ static long sock_i_ino(const struct sock *sk)
 		return 0;
 
 	inode = &container_of(sk_socket, struct socket_alloc, socket)->vfs_inode;
-	bpf_probe_read(&ino, sizeof(ino), &inode->i_ino);
+	bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
 	return ino;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
index c1175a6ecf43..65f93bb03f0f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
@@ -25,7 +25,7 @@ static long sock_i_ino(const struct sock *sk)
 		return 0;
 
 	inode = &container_of(sk_socket, struct socket_alloc, socket)->vfs_inode;
-	bpf_probe_read(&ino, sizeof(ino), &inode->i_ino);
+	bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
 	return ino;
 }
 
-- 
2.25.4

