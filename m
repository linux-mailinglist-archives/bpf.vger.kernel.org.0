Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523E04A8C57
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 20:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiBCTRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 14:17:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353735AbiBCTRv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 14:17:51 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213I6SWI028624
        for <bpf@vger.kernel.org>; Thu, 3 Feb 2022 11:17:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=1zDoyto5r9tUT/qLII9tIiZWdfx7W4erbMhveSkt7Uc=;
 b=YJw1exKM+AazQdFyJZ3YL20Hf7kDltwQLt6jwP8/xBr64Ux5nk/cQFE2845X+Jdqva8I
 Ikia9A3D/lYXMKnOovOqLAhZNsTffHbssiWEBpJHPjWGkl/rTetIQa5mumF/CBsrPbYS
 Bq96rb7bjulPRklZ8/SGzdgOLbFH+e47O3g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e0cvcup49-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 11:17:51 -0800
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 11:17:34 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5C96D5EED8E1; Thu,  3 Feb 2022 11:17:27 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <syzbot+53619be9444215e785ed@syzkaller.appspotmail.com>
Subject: [PATCH bpf 1/2] bpf: fix a btf decl_tag bug when tagging a function
Date:   Thu, 3 Feb 2022 11:17:27 -0800
Message-ID: <20220203191727.741862-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0AYq3yAdyNkmdWWvPEAT0ssGWpyoaO3w
X-Proofpoint-ORIG-GUID: 0AYq3yAdyNkmdWWvPEAT0ssGWpyoaO3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 adultscore=0 mlxlogscore=676 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot reported a btf decl_tag bug with stack trace below:

  general protection fault, probably for non-canonical address 0xdffffc00=
00000000: 0000 [#1] PREEMPT SMP KASAN
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  CPU: 0 PID: 3592 Comm: syz-executor914 Not tainted 5.16.0-syzkaller-114=
24-gb7892f7d5cb2 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/01/2011
  RIP: 0010:btf_type_vlen include/linux/btf.h:231 [inline]
  RIP: 0010:btf_decl_tag_resolve+0x83e/0xaa0 kernel/bpf/btf.c:3910
  ...
  Call Trace:
   <TASK>
   btf_resolve+0x251/0x1020 kernel/bpf/btf.c:4198
   btf_check_all_types kernel/bpf/btf.c:4239 [inline]
   btf_parse_type_sec kernel/bpf/btf.c:4280 [inline]
   btf_parse kernel/bpf/btf.c:4513 [inline]
   btf_new_fd+0x19fe/0x2370 kernel/bpf/btf.c:6047
   bpf_btf_load kernel/bpf/syscall.c:4039 [inline]
   __sys_bpf+0x1cbb/0x5970 kernel/bpf/syscall.c:4679
   __do_sys_bpf kernel/bpf/syscall.c:4738 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:4736 [inline]
   __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4736
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

The kasan error is triggered with an illegal BTF like below:
   type 0: void
   type 1: int
   type 2: decl_tag to func type 3
   type 3: func to func_proto type 8
The total number of types is 4 and the type 3 is illegal
since its func_proto type is out of range.

Currently, the target type of decl_tag can be struct/union, var or func.
Both struct/union and var implemented their own 'resolve' callback functi=
ons
and hence handled properly in kernel.
But func type doesn't have 'resolve' callback function. When
btf_decl_tag_resolve() tries to check func type, it tries to get
vlen of its func_proto type, which triggered the above kasan error.

To fix the issue, btf_decl_tag_resolve() needs to do btf_func_check()
before trying to accessing func_proto type.
In the current implementation, func type is checked with
btf_func_check() in the main checking function btf_check_all_types().
To fix the above kasan issue, let us implement 'resolve' callback
func type properly. The 'resolve' callback will be also called
in btf_check_all_types() for func types.

Reported-by: syzbot+53619be9444215e785ed@syzkaller.appspotmail.com
Fixes: b5ea834dde6b ("bpf: Support for new btf kind BTF_KIND_TAG")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e16dafeb2450..cf76e32a00da 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -403,6 +403,9 @@ static struct btf_type btf_void;
 static int btf_resolve(struct btf_verifier_env *env,
 		       const struct btf_type *t, u32 type_id);
=20
+static int btf_func_check(struct btf_verifier_env *env,
+			  const struct btf_type *t);
+
 static bool btf_type_is_modifier(const struct btf_type *t)
 {
 	/* Some of them is not strictly a C modifier
@@ -579,6 +582,7 @@ static bool btf_type_needs_resolve(const struct btf_t=
ype *t)
 	       btf_type_is_struct(t) ||
 	       btf_type_is_array(t) ||
 	       btf_type_is_var(t) ||
+	       btf_type_is_func(t) ||
 	       btf_type_is_decl_tag(t) ||
 	       btf_type_is_datasec(t);
 }
@@ -3533,9 +3537,24 @@ static s32 btf_func_check_meta(struct btf_verifier=
_env *env,
 	return 0;
 }
=20
+static int btf_func_resolve(struct btf_verifier_env *env,
+			    const struct resolve_vertex *v)
+{
+	const struct btf_type *t =3D v->t;
+	u32 next_type_id =3D t->type;
+	int err;
+
+	err =3D btf_func_check(env, t);
+	if (err)
+		return err;
+
+	env_stack_pop_resolved(env, next_type_id, 0);
+	return 0;
+}
+
 static struct btf_kind_operations func_ops =3D {
 	.check_meta =3D btf_func_check_meta,
-	.resolve =3D btf_df_resolve,
+	.resolve =3D btf_func_resolve,
 	.check_member =3D btf_df_check_member,
 	.check_kflag_member =3D btf_df_check_kflag_member,
 	.log_details =3D btf_ref_type_log,
@@ -4156,7 +4175,7 @@ static bool btf_resolve_valid(struct btf_verifier_e=
nv *env,
 		return !btf_resolved_type_id(btf, type_id) &&
 		       !btf_resolved_type_size(btf, type_id);
=20
-	if (btf_type_is_decl_tag(t))
+	if (btf_type_is_decl_tag(t) || btf_type_is_func(t))
 		return btf_resolved_type_id(btf, type_id) &&
 		       !btf_resolved_type_size(btf, type_id);
=20
@@ -4246,12 +4265,6 @@ static int btf_check_all_types(struct btf_verifier=
_env *env)
 			if (err)
 				return err;
 		}
-
-		if (btf_type_is_func(t)) {
-			err =3D btf_func_check(env, t);
-			if (err)
-				return err;
-		}
 	}
=20
 	return 0;
--=20
2.30.2

