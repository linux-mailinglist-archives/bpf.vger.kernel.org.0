Return-Path: <bpf+bounces-15297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B27EFD8F
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 04:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CA81F23614
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 03:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082DD6AD9;
	Sat, 18 Nov 2023 03:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C275BD72
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:46:51 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI2r5ST003655
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:46:51 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uemvd856k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:46:51 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 19:46:50 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E855C3BB2FF89; Fri, 17 Nov 2023 19:46:36 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v3 bpf-next 1/8] bpf: move verbose_linfo() into kernel/bpf/log.c
Date: Fri, 17 Nov 2023 19:46:16 -0800
Message-ID: <20231118034623.3320920-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118034623.3320920-1-andrii@kernel.org>
References: <20231118034623.3320920-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Pw33M0MaIEKzSLRVMpoI_ecNZwxI0vbW
X-Proofpoint-ORIG-GUID: Pw33M0MaIEKzSLRVMpoI_ecNZwxI0vbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_01,2023-11-17_01,2023-05-22_02

verifier.c is huge. Let's try to move out parts that are logging-related
into log.c, as we previously did with bpf_log() and other related stuff.
This patch moves line info verbose output routines: it's pretty
self-contained and isolated code, so there is no problem with this.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  4 +++
 kernel/bpf/log.c             | 59 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 57 ----------------------------------
 3 files changed, 63 insertions(+), 57 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 52a4012b8255..d896f3db6a22 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -680,6 +680,10 @@ int bpf_vlog_init(struct bpf_verifier_log *log, u32 =
log_level,
 void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
 int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual=
);
=20
+__printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
+				  u32 insn_off,
+				  const char *prefix_fmt, ...);
+
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *e=
nv)
 {
 	struct bpf_verifier_state *cur =3D env->cur_state;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 850494423530..f20e1449c882 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -10,6 +10,8 @@
 #include <linux/bpf_verifier.h>
 #include <linux/math64.h>
=20
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
+
 static bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *l=
og)
 {
 	/* ubuf and len_total should both be specified (or not) together */
@@ -325,3 +327,60 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log =
*log,
 	va_end(args);
 }
 EXPORT_SYMBOL_GPL(bpf_log);
+
+static const struct bpf_line_info *
+find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
+{
+	const struct bpf_line_info *linfo;
+	const struct bpf_prog *prog;
+	u32 i, nr_linfo;
+
+	prog =3D env->prog;
+	nr_linfo =3D prog->aux->nr_linfo;
+
+	if (!nr_linfo || insn_off >=3D prog->len)
+		return NULL;
+
+	linfo =3D prog->aux->linfo;
+	for (i =3D 1; i < nr_linfo; i++)
+		if (insn_off < linfo[i].insn_off)
+			break;
+
+	return &linfo[i - 1];
+}
+
+static const char *ltrim(const char *s)
+{
+	while (isspace(*s))
+		s++;
+
+	return s;
+}
+
+__printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
+				  u32 insn_off,
+				  const char *prefix_fmt, ...)
+{
+	const struct bpf_line_info *linfo;
+
+	if (!bpf_verifier_log_needed(&env->log))
+		return;
+
+	linfo =3D find_linfo(env, insn_off);
+	if (!linfo || linfo =3D=3D env->prev_linfo)
+		return;
+
+	if (prefix_fmt) {
+		va_list args;
+
+		va_start(args, prefix_fmt);
+		bpf_verifier_vlog(&env->log, prefix_fmt, args);
+		va_end(args);
+	}
+
+	verbose(env, "%s\n",
+		ltrim(btf_name_by_offset(env->prog->aux->btf,
+					 linfo->line_off)));
+
+	env->prev_linfo =3D linfo;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7c3461b89513..683fdda25c13 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -337,27 +337,6 @@ struct btf *btf_vmlinux;
=20
 static DEFINE_MUTEX(bpf_verifier_lock);
=20
-static const struct bpf_line_info *
-find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
-{
-	const struct bpf_line_info *linfo;
-	const struct bpf_prog *prog;
-	u32 i, nr_linfo;
-
-	prog =3D env->prog;
-	nr_linfo =3D prog->aux->nr_linfo;
-
-	if (!nr_linfo || insn_off >=3D prog->len)
-		return NULL;
-
-	linfo =3D prog->aux->linfo;
-	for (i =3D 1; i < nr_linfo; i++)
-		if (insn_off < linfo[i].insn_off)
-			break;
-
-	return &linfo[i - 1];
-}
-
 __printf(2, 3) static void verbose(void *private_data, const char *fmt, =
...)
 {
 	struct bpf_verifier_env *env =3D private_data;
@@ -371,42 +350,6 @@ __printf(2, 3) static void verbose(void *private_dat=
a, const char *fmt, ...)
 	va_end(args);
 }
=20
-static const char *ltrim(const char *s)
-{
-	while (isspace(*s))
-		s++;
-
-	return s;
-}
-
-__printf(3, 4) static void verbose_linfo(struct bpf_verifier_env *env,
-					 u32 insn_off,
-					 const char *prefix_fmt, ...)
-{
-	const struct bpf_line_info *linfo;
-
-	if (!bpf_verifier_log_needed(&env->log))
-		return;
-
-	linfo =3D find_linfo(env, insn_off);
-	if (!linfo || linfo =3D=3D env->prev_linfo)
-		return;
-
-	if (prefix_fmt) {
-		va_list args;
-
-		va_start(args, prefix_fmt);
-		bpf_verifier_vlog(&env->log, prefix_fmt, args);
-		va_end(args);
-	}
-
-	verbose(env, "%s\n",
-		ltrim(btf_name_by_offset(env->prog->aux->btf,
-					 linfo->line_off)));
-
-	env->prev_linfo =3D linfo;
-}
-
 static void verbose_invalid_scalar(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg,
 				   struct tnum *range, const char *ctx,
--=20
2.34.1


