Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67A11C81BC
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 07:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgEGFkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 01:40:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17344 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbgEGFjv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 01:39:51 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0475dk1L007958
        for <bpf@vger.kernel.org>; Wed, 6 May 2020 22:39:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=os5BdaB2LIAIWH6vrxfv8dhAkuMHvSzAdfITrOvV8Zw=;
 b=i/qvQIPvhrkGHy21uD0HRjsaHYTP4KG5lkZFBNJbA2aCH2LSl25WbrcWPDktvZzV3+0q
 EHCpUktfNl5/9f7a8EKP9QmzMyZV0+e6SvZqBjU9/O4HY447PoOnn6GxrS6dAZUHhiG8
 rg3CoNwqAayuVVm8F7/WkQhPSHxsw5Hhe5Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30v0hp3gwd-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 22:39:51 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 6 May 2020 22:39:41 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 36C5F3701B99; Wed,  6 May 2020 22:39:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v3 20/21] tools/bpf: selftests: add iter progs for bpf_map/task/task_file
Date:   Wed, 6 May 2020 22:39:39 -0700
Message-ID: <20200507053939.1545455-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200507053915.1542140-1-yhs@fb.com>
References: <20200507053915.1542140-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_02:2020-05-05,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070044
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The implementation is arbitrary, just to show how the bpf programs
can be written for bpf_map/task/task_file. They can be costomized
for specific needs.

For example, for bpf_map, the iterator prints out:
  $ cat /sys/fs/bpf/my_bpf_map
      id   refcnt  usercnt  locked_vm
       3        2        0         20
       6        2        0         20
       9        2        0         20
      12        2        0         20
      13        2        0         20
      16        2        0         20
      19        2        0         20
      %%% END %%%

For task, the iterator prints out:
  $ cat /sys/fs/bpf/my_task
    tgid      gid
       1        1
       2        2
    ....
    1944     1944
    1948     1948
    1949     1949
    1953     1953
    =3D=3D=3D END =3D=3D=3D

For task/file, the iterator prints out:
  $ cat /sys/fs/bpf/my_task_file
    tgid      gid       fd      file
       1        1        0 ffffffff95c97600
       1        1        1 ffffffff95c97600
       1        1        2 ffffffff95c97600
    ....
    1895     1895      255 ffffffff95c8fe00
    1932     1932        0 ffffffff95c8fe00
    1932     1932        1 ffffffff95c8fe00
    1932     1932        2 ffffffff95c8fe00
    1932     1932        3 ffffffff95c185c0

This is able to print out all open files (fd and file->f_op), so user can=
 compare
f_op against a particular kernel file operations to find what it is.
For example, from /proc/kallsyms, we can find
  ffffffff95c185c0 r eventfd_fops
so we will know tgid 1932 fd 3 is an eventfd file descriptor.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/progs/bpf_iter_bpf_map.c    | 28 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_task.c       | 25 +++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_task_file.c  | 26 +++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_file.=
c

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c b/tools=
/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
new file mode 100644
index 000000000000..4867cd3445c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("iter/bpf_map")
+int dump_bpf_map(struct bpf_iter__bpf_map *ctx)
+{
+	struct seq_file *seq =3D ctx->meta->seq;
+	__u64 seq_num =3D ctx->meta->seq_num;
+	struct bpf_map *map =3D ctx->map;
+
+	if (map =3D=3D (void *)0) {
+		BPF_SEQ_PRINTF(seq, "      %%%%%% END %%%%%%\n");
+		return 0;
+	}
+
+	if (seq_num =3D=3D 0)
+		BPF_SEQ_PRINTF(seq, "      id   refcnt  usercnt  locked_vm\n");
+
+	BPF_SEQ_PRINTF(seq, "%8u %8ld %8ld %10lu\n", map->id, map->refcnt.count=
er,
+		       map->usercnt.counter,
+		       map->memory.user->locked_vm.counter);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_task.c
new file mode 100644
index 000000000000..90f9011c57ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("iter/task")
+int dump_task(struct bpf_iter__task *ctx)
+{
+	struct seq_file *seq =3D ctx->meta->seq;
+	struct task_struct *task =3D ctx->task;
+
+	if (task =3D=3D (void *)0) {
+		BPF_SEQ_PRINTF(seq, "    =3D=3D=3D END =3D=3D=3D\n");
+		return 0;
+	}
+
+	if (ctx->meta->seq_num =3D=3D 0)
+		BPF_SEQ_PRINTF(seq, "    tgid      gid\n");
+
+	BPF_SEQ_PRINTF(seq, "%8d %8d\n", task->tgid, task->pid);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c b/too=
ls/testing/selftests/bpf/progs/bpf_iter_task_file.c
new file mode 100644
index 000000000000..c6ced38f0880
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("iter/task_file")
+int dump_task_file(struct bpf_iter__task_file *ctx)
+{
+	struct seq_file *seq =3D ctx->meta->seq;
+	struct task_struct *task =3D ctx->task;
+	__u32 fd =3D ctx->fd;
+	struct file *file =3D ctx->file;
+
+	if (task =3D=3D (void *)0 || file =3D=3D (void *)0)
+		return 0;
+
+	if (ctx->meta->seq_num =3D=3D 0)
+		BPF_SEQ_PRINTF(seq, "    tgid      gid       fd      file\n");
+
+	BPF_SEQ_PRINTF(seq, "%8d %8d %8d %lx\n", task->tgid, task->pid, fd,
+		       (long)file->f_op);
+	return 0;
+}
--=20
2.24.1

