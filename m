Return-Path: <bpf+bounces-14816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3B77E87B5
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5701F20F4F
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 01:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496DB28F3;
	Sat, 11 Nov 2023 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1723A7
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:39:46 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD8448C
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 17:39:43 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D517C29A91CE0; Fri, 10 Nov 2023 17:39:28 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH bpf-next v3] bpf: Do not allocate percpu memory at init stage
Date: Fri, 10 Nov 2023 17:39:28 -0800
Message-Id: <20231111013928.948838-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Kirill Shutemov reported significant percpu memory consumption increase a=
fter
booting in 288-cpu VM ([1]) due to commit 41a5db8d8161 ("bpf: Add support=
 for
non-fix-size percpu mem allocation"). The percpu memory consumption is
increased from 111MB to 969MB. The number is from /proc/meminfo.

I tried to reproduce the issue with my local VM which at most supports up=
to
255 cpus. With 252 cpus, without the above commit, the percpu memory
consumption immediately after boot is 57MB while with the above commit th=
e
percpu memory consumption is 231MB.

This is not good since so far percpu memory from bpf memory allocator is =
not
widely used yet. Let us change pre-allocation in init stage to on-demand
allocation when verifier detects there is a need of percpu memory for bpf
program. With this change, percpu memory consumption after boot can be re=
duced
signicantly.

  [1] https://lore.kernel.org/lkml/20231109154934.4saimljtqx625l3v@box.sh=
utemov.name/

Fixes: 41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem alloca=
tion")
Reported-and-tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.c=
om>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/core.c     |  8 +++-----
 kernel/bpf/verifier.c | 20 ++++++++++++++++++--
 3 files changed, 22 insertions(+), 8 deletions(-)

Changelog:
  v2 -> v3:
    - Use dedicated mutex lock (bpf_percpu_ma_lock)
  v1 -> v2:
    - Add proper Reported-and-tested-by tag.
    - Do a check of !bpf_global_percpu_ma_set before acquiring verifier_l=
ock.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 35bff17396c0..6762dac3ef76 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -56,7 +56,7 @@ extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
 extern struct kobject *btf_kobj;
 extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
-extern bool bpf_global_ma_set, bpf_global_percpu_ma_set;
+extern bool bpf_global_ma_set;
=20
 typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 08626b519ce2..cd3afe57ece3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -64,8 +64,8 @@
 #define OFF	insn->off
 #define IMM	insn->imm
=20
-struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
-bool bpf_global_ma_set, bpf_global_percpu_ma_set;
+struct bpf_mem_alloc bpf_global_ma;
+bool bpf_global_ma_set;
=20
 /* No hurry in this branch
  *
@@ -2934,9 +2934,7 @@ static int __init bpf_global_ma_init(void)
=20
 	ret =3D bpf_mem_alloc_init(&bpf_global_ma, 0, false);
 	bpf_global_ma_set =3D !ret;
-	ret =3D bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
-	bpf_global_percpu_ma_set =3D !ret;
-	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
+	return ret;
 }
 late_initcall(bpf_global_ma_init);
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a2267d5ed14e..6da370a047fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -26,6 +26,7 @@
 #include <linux/poison.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
=20
 #include "disasm.h"
@@ -41,6 +42,9 @@ static const struct bpf_verifier_ops * const bpf_verifi=
er_ops[] =3D {
 #undef BPF_LINK_TYPE
 };
=20
+struct bpf_mem_alloc bpf_global_percpu_ma;
+static bool bpf_global_percpu_ma_set;
+
 /* bpf_check() is a static code analyzer that walks eBPF program
  * instruction by instruction and updates register/stack state.
  * All paths of conditional branches are analyzed until 'bpf_exit' insn.
@@ -336,6 +340,7 @@ struct bpf_kfunc_call_arg_meta {
 struct btf *btf_vmlinux;
=20
 static DEFINE_MUTEX(bpf_verifier_lock);
+static DEFINE_MUTEX(bpf_percpu_ma_lock);
=20
 static const struct bpf_line_info *
 find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
@@ -12091,8 +12096,19 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] && !=
bpf_global_ma_set)
 					return -ENOMEM;
=20
-				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l] && !bpf_global_percpu_ma_set)
-					return -ENOMEM;
+				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l]) {
+					if (!bpf_global_percpu_ma_set) {
+						mutex_lock(&bpf_percpu_ma_lock);
+						if (!bpf_global_percpu_ma_set) {
+							err =3D bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
+							if (!err)
+								bpf_global_percpu_ma_set =3D true;
+						}
+						mutex_unlock(&bpf_percpu_ma_lock);
+						if (err)
+							return err;
+					}
+				}
=20
 				if (((u64)(u32)meta.arg_constant.value) !=3D meta.arg_constant.value=
) {
 					verbose(env, "local type ID argument must be in range [0, U32_MAX]\=
n");
--=20
2.34.1


