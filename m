Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDD350B10
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 02:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhDAAI6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 20:08:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62444 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhDAAIW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 20:08:22 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13105UtZ005493
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 17:08:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Olg6XMi32ieavYB+jWfj1NdlzbCHsmIiF6+WmF8V+3U=;
 b=GxNDxusQJq0mklaGzQ/UzP6Xq93sv/LWqxnXdD9BU9gNaLl7lFfz/3ImJucn3pQFDolA
 Xe8GuxLS+g/PfygkS4qzzr//beJpjrZ5fQ9jN4TR+3mjBEXkEhKdlnympWMhm3Zl9CXQ
 0jiO5730SLcRyiuBFbXEaiOO7RnSyAyFXaw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37n2810am2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 17:08:21 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 17:08:20 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 6FF3F192A25; Wed, 31 Mar 2021 17:08:17 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf] bpf: refcount task stack in bpf_get_task_stack
Date:   Wed, 31 Mar 2021 17:07:47 -0700
Message-ID: <20210401000747.3648767-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ny9J8_VT2mO1pB1LcidEDoKvi6kkgvGI
X-Proofpoint-ORIG-GUID: Ny9J8_VT2mO1pB1LcidEDoKvi6kkgvGI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_11:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2103310167
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On x86 the struct pt_regs * grabbed by task_pt_regs() points to an
offset of task->stack. The pt_regs are later dereferenced in
__bpf_get_stack (e.g. by user_mode() check). This can cause a fault if
the task in question exits while bpf_get_task_stack is executing, as
warned by task_stack_page's comment:

* When accessing the stack of a non-current task that might exit, use
* try_get_task_stack() instead.  task_stack_page will return a pointer
* that could get freed out from under you.

Taking the comment's advice and using try_get_task_stack() and
put_task_stack() to hold task->stack refcount, or bail early if it's
already 0. Incrementing stack_refcount will ensure the task's stack
sticks around while we're using its data.

I noticed this bug while testing a bpf task iter similar to
bpf_iter_task_stack in selftests, except mine grabbed user stack, and
getting intermittent crashes, which resulted in dumps like:

  BUG: unable to handle page fault for address: 0000000000003fe0
  \#PF: supervisor read access in kernel mode
  \#PF: error_code(0x0000) - not-present page
  RIP: 0010:__bpf_get_stack+0xd0/0x230
  <snip...>
  Call Trace:
  bpf_prog_0a2be35c092cb190_get_task_stacks+0x5d/0x3ec
  bpf_iter_run_prog+0x24/0x81
  __task_seq_show+0x58/0x80
  bpf_seq_read+0xf7/0x3d0
  vfs_read+0x91/0x140
  ksys_read+0x59/0xd0
  do_syscall_64+0x48/0x120
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/stackmap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index be35bfb7fb13..6fbc2abe9c91 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -517,9 +517,17 @@ const struct bpf_func_proto bpf_get_stack_proto =3D =
{
 BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
 	   u32, size, u64, flags)
 {
-	struct pt_regs *regs =3D task_pt_regs(task);
+	struct pt_regs *regs;
+	long res;
=20
-	return __bpf_get_stack(regs, task, NULL, buf, size, flags);
+	if (!try_get_task_stack(task))
+		return -EFAULT;
+
+	regs =3D task_pt_regs(task);
+	res =3D __bpf_get_stack(regs, task, NULL, buf, size, flags);
+	put_task_stack(task);
+
+	return res;
 }
=20
 BTF_ID_LIST_SINGLE(bpf_get_task_stack_btf_ids, struct, task_struct)
--=20
2.30.2

