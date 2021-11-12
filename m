Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3944E979
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 16:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhKLPGh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 10:06:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19608 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233894AbhKLPGh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 10:06:37 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACEvpO2013382
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 07:03:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JmVH4GD6sUTxR/dJfK/zemiSK3SWDbgoDIamqDzUy34=;
 b=VW+uU1D92toHYSTPpbubua42N9XJV3s8dtINXEsv8q/nyiulpK1sOj1IeWyhYTIiyF99
 hpPrXAC9zTbqEiabS1kbb5Trx164ZS4aZB58wD9z8m66RQxwQySQxXr1d4e0RM+05X6Z
 iy2pC6Dp9JO7CYzWvpmi2bVdyhdMaMiHxsI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9tg7r2ew-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 07:03:46 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 12 Nov 2021 07:02:52 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E1E6F1FA8FBF4; Fri, 12 Nov 2021 07:02:49 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        <syzbot+e0d81ec552a21d9071aa@syzkaller.appspotmail.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 bpf-next 1/2] bpf: extend BTF_ID_LIST_GLOBAL with parameter for number of IDs
Date:   Fri, 12 Nov 2021 07:02:42 -0800
Message-ID: <20211112150243.1270987-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112150243.1270987-1-songliubraving@fb.com>
References: <20211112150243.1270987-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: FLG95U-U5Flm2vJ5q8UjFdAE2Bj25Xfq
X-Proofpoint-GUID: FLG95U-U5Flm2vJ5q8UjFdAE2Bj25Xfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111120086
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot reported the following BUG w/o CONFIG_DEBUG_INFO_BTF

BUG: KASAN: global-out-of-bounds in task_iter_init+0x212/0x2e7 kernel/bpf=
/task_iter.c:661
Read of size 4 at addr ffffffff90297404 by task swapper/0/1

CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.15.0-syzkaller #0
Hardware name: ... Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description.constprop.0.cold+0xf/0x309 mm/kasan/report.c:25=
6
__kasan_report mm/kasan/report.c:442 [inline]
kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
task_iter_init+0x212/0x2e7 kernel/bpf/task_iter.c:661
do_one_initcall+0x103/0x650 init/main.c:1295
do_initcall_level init/main.c:1368 [inline]
do_initcalls init/main.c:1384 [inline]
do_basic_setup init/main.c:1403 [inline]
kernel_init_freeable+0x6b1/0x73a init/main.c:1606
kernel_init+0x1a/0x1d0 init/main.c:1497
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
</TASK>

This is caused by hard-coded name[1] in BTF_ID_LIST_GLOBAL (w/o
CONFIG_DEBUG_INFO_BTF). Fix this by adding a parameter n to
BTF_ID_LIST_GLOBAL. This avoids ifdef CONFIG_DEBUG_INFO_BTF in btf.c and
filter.c.

Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
Reported-by: syzbot+e0d81ec552a21d9071aa@syzkaller.appspotmail.com
Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/btf_ids.h | 6 +++---
 kernel/bpf/btf.c        | 2 +-
 net/core/filter.c       | 6 +-----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 47d9abfbdb556..6bb42b785293a 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -73,7 +73,7 @@ asm(							\
 __BTF_ID_LIST(name, local)				\
 extern u32 name[];
=20
-#define BTF_ID_LIST_GLOBAL(name)			\
+#define BTF_ID_LIST_GLOBAL(name, n)			\
 __BTF_ID_LIST(name, globl)
=20
 /* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
@@ -83,7 +83,7 @@ __BTF_ID_LIST(name, globl)
 	BTF_ID_LIST(name) \
 	BTF_ID(prefix, typename)
 #define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) \
-	BTF_ID_LIST_GLOBAL(name) \
+	BTF_ID_LIST_GLOBAL(name, 1)			  \
 	BTF_ID(prefix, typename)
=20
 /*
@@ -149,7 +149,7 @@ extern struct btf_id_set name;
 #define BTF_ID_LIST(name) static u32 name[5];
 #define BTF_ID(prefix, name)
 #define BTF_ID_UNUSED
-#define BTF_ID_LIST_GLOBAL(name) u32 name[1];
+#define BTF_ID_LIST_GLOBAL(name, n) u32 name[n];
 #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
 #define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) u32 name[1];
 #define BTF_SET_START(name) static struct btf_id_set name =3D { 0 };
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1dd9ba82da1e0..2a9d8a1fee1de 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6354,7 +6354,7 @@ const struct bpf_func_proto bpf_btf_find_by_name_ki=
nd_proto =3D {
 	.arg4_type	=3D ARG_ANYTHING,
 };
=20
-BTF_ID_LIST_GLOBAL(btf_task_struct_ids)
+BTF_ID_LIST_GLOBAL(btf_task_struct_ids, 3)
 BTF_ID(struct, task_struct)
 BTF_ID(struct, file)
 BTF_ID(struct, vm_area_struct)
diff --git a/net/core/filter.c b/net/core/filter.c
index 315a58466fc93..46f09a8fba20b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10611,14 +10611,10 @@ void bpf_prog_change_xdp(struct bpf_prog *prev_=
prog, struct bpf_prog *prog)
 	bpf_dispatcher_change_prog(BPF_DISPATCHER_PTR(xdp), prev_prog, prog);
 }
=20
-#ifdef CONFIG_DEBUG_INFO_BTF
-BTF_ID_LIST_GLOBAL(btf_sock_ids)
+BTF_ID_LIST_GLOBAL(btf_sock_ids, MAX_BTF_SOCK_TYPE)
 #define BTF_SOCK_TYPE(name, type) BTF_ID(struct, type)
 BTF_SOCK_TYPE_xxx
 #undef BTF_SOCK_TYPE
-#else
-u32 btf_sock_ids[MAX_BTF_SOCK_TYPE];
-#endif
=20
 BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
 {
--=20
2.30.2

