Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEBC3E864E
	for <lists+bpf@lfdr.de>; Wed, 11 Aug 2021 01:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhHJXGF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 19:06:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52594 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235196AbhHJXGE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Aug 2021 19:06:04 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AN4qsW001311
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 16:05:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=cRLN2SCUIpI92oa0bqAiVwsv2LhB6vz9N2CKM95wEL0=;
 b=d6J5+ycELWdtkINXAKxiqmN7UDDreq8AB5nM5anVt3yxOTgakO5gUeKCBuwrp5WI8gQZ
 Jxzj5+/43TQ2pGkQYEiuGmmiSNy7cfNf+IwTuuiJ2y6dXo0UjCaDFgRb3thWR9lPKejQ
 dob6fo2xm/E25JVfTl4u+rFCCADr3/5dGAg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3abyfm1ag7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 16:05:41 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 16:05:39 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3CEE85DB0538; Tue, 10 Aug 2021 16:05:37 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com>
Subject: [PATCH bpf v4] bpf: add rcu read_lock in bpf_get_current_[ancestor_]cgroup_id() helpers
Date:   Tue, 10 Aug 2021 16:05:37 -0700
Message-ID: <20210810230537.2864668-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: fphMA-Y3oAteh5qx9q6TVBatYF-P1acO
X-Proofpoint-GUID: fphMA-Y3oAteh5qx9q6TVBatYF-P1acO
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_08:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100152
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, if bpf_get_current_cgroup_id() or
bpf_get_current_ancestor_cgroup_id() helper is
called with sleepable programs e.g., sleepable
fentry/fmod_ret/fexit/lsm programs, a rcu warning
may appear. For example, if I added the following
hack to test_progs/test_lsm sleepable fentry program
test_sys_setdomainname:

  --- a/tools/testing/selftests/bpf/progs/lsm.c
  +++ b/tools/testing/selftests/bpf/progs/lsm.c
  @@ -168,6 +168,10 @@ int BPF_PROG(test_sys_setdomainname, struct pt_regs =
*regs)
          int buf =3D 0;
          long ret;

  +       __u64 cg_id =3D bpf_get_current_cgroup_id();
  +       if (cg_id =3D=3D 1000)
  +               copy_test++;
  +
          ret =3D bpf_copy_from_user(&buf, sizeof(buf), ptr);
          if (len =3D=3D -2 && ret =3D=3D 0 && buf =3D=3D 1234)
                  copy_test++;

I will hit the following rcu warning:

  include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
  other info that might help us debug this:
    rcu_scheduler_active =3D 2, debug_locks =3D 1
    1 lock held by test_progs/260:
      #0: ffffffffa5173360 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_pro=
g_enter_sleepable+0x0/0xa0
    stack backtrace:
    CPU: 1 PID: 260 Comm: test_progs Tainted: G           O      5.14.0-rc2=
+ #176
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-=
0-g155821a1990b-prebuilt.qemu.org 04/01/2014
    Call Trace:
      dump_stack_lvl+0x56/0x7b
      bpf_get_current_cgroup_id+0x9c/0xb1
      bpf_prog_a29888d1c6706e09_test_sys_setdomainname+0x3e/0x89c
      bpf_trampoline_6442469132_0+0x2d/0x1000
      __x64_sys_setdomainname+0x5/0x110
      do_syscall_64+0x3a/0x80
      entry_SYSCALL_64_after_hwframe+0x44/0xae

I can get similar warning using bpf_get_current_ancestor_cgroup_id() helper.
syzbot reported a similar issue in [1] for syscall program. Helper
bpf_get_current_cgroup_id() or bpf_get_current_ancestor_cgroup_id()
has the following callchain:
   task_dfl_cgroup
     task_css_set
       task_css_set_check
and we have
   #define task_css_set_check(task, __c)                                   \
           rcu_dereference_check((task)->cgroups,                          \
                   lockdep_is_held(&cgroup_mutex) ||                       \
                   lockdep_is_held(&css_set_lock) ||                       \
                   ((task)->flags & PF_EXITING) || (__c))
Since cgroup_mutex/css_set_lock is not held and the task
is not existing and rcu read_lock is not held, a warning
will be issued. Note that bpf sleepable program is protected by
rcu_read_lock_trace().

The above sleepable bpf programs are already protected
by migrate_disable(). Adding rcu_read_lock() in these
two helpers will silence the above warning.
I marked the patch fixing 95b861a7935b
("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
which added bpf_get_current_ancestor_cgroup_id() to tracing programs
in 5.14. I think backporting 5.14 is probably good enough as sleepable
progrems are not widely used.

This patch should fix [1] as well since syscall program is a sleepable
program protected with migrate_disable().

 [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/

Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
Fixes: 95b861a7935b ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tra=
cing")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/helpers.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

Changelog:
  v3 -> v4:
    - ensure rcu_read_lock() region enclosing all accesses to cgroup.
  v2 -> v3:
    - use rcu_read_lock() protection for
      bpf_get_current_[ancestor_]cgroup_id() helper.
  v1 -> v2:
    - disallow bpf_get_current_[ancestor_]cgroup_id() helper.

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7a97b2f4747d..55f83ea09dae 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -353,9 +353,15 @@ const struct bpf_func_proto bpf_jiffies64_proto =3D {
 #ifdef CONFIG_CGROUPS
 BPF_CALL_0(bpf_get_current_cgroup_id)
 {
-	struct cgroup *cgrp =3D task_dfl_cgroup(current);
+	struct cgroup *cgrp;
+	u64 cgrp_id;
=20
-	return cgroup_id(cgrp);
+	rcu_read_lock();
+	cgrp =3D task_dfl_cgroup(current);
+	cgrp_id =3D cgroup_id(cgrp);
+	rcu_read_unlock();
+
+	return cgrp_id;
 }
=20
 const struct bpf_func_proto bpf_get_current_cgroup_id_proto =3D {
@@ -366,13 +372,17 @@ const struct bpf_func_proto bpf_get_current_cgroup_id=
_proto =3D {
=20
 BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
 {
-	struct cgroup *cgrp =3D task_dfl_cgroup(current);
+	struct cgroup *cgrp;
 	struct cgroup *ancestor;
+	u64 cgrp_id;
=20
+	rcu_read_lock();
+	cgrp =3D task_dfl_cgroup(current);
 	ancestor =3D cgroup_ancestor(cgrp, ancestor_level);
-	if (!ancestor)
-		return 0;
-	return cgroup_id(ancestor);
+	cgrp_id =3D ancestor ? cgroup_id(ancestor) : 0;
+	rcu_read_unlock();
+
+	return cgrp_id;
 }
=20
 const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto =3D {
--=20
2.30.2

