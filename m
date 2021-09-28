Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D683541B490
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbhI1Q6T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Sep 2021 12:58:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11176 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241925AbhI1Q6P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 12:58:15 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18SD7wlK010727
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3bc3nj1vu4-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:35 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:56:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D3BC450F9F27; Tue, 28 Sep 2021 09:20:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 06/10] libbpf: reduce reliance of attach_fns on sec_def internals
Date:   Tue, 28 Sep 2021 09:19:42 -0700
Message-ID: <20210928161946.2512801-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928161946.2512801-1-andrii@kernel.org>
References: <20210928161946.2512801-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Hi5tLn80g-XJk288OPU-tfGxm-HJbzy3
X-Proofpoint-GUID: Hi5tLn80g-XJk288OPU-tfGxm-HJbzy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move closer to not relying on bpf_sec_def internals that won't be part
of public API, when pluggable SEC() handlers will be allowed. Drop
pre-calculated prefix length, and in various helpers don't rely on this
prefix length availability. Also minimize reliance on knowing
bpf_sec_def's prefix for few places where section prefix shortcuts are
supported (e.g., tp vs tracepoint, raw_tp vs raw_tracepoint).

Given checking some string for having a given string-constant prefix is
such a common operation and so annoying to be done with pure C code, add
a small macro helper, str_has_pfx(), and reuse it throughout libbpf.c
where prefix comparison is performed. With __builtin_constant_p() it's
possible to have a convenient helper that checks some string for having
a given prefix, where prefix is either string literal (or compile-time
known string due to compiler optimization) or just a runtime string
pointer, which is quite convenient and saves a lot of typing and string
literal duplication.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 41 ++++++++++++++++++---------------
 tools/lib/bpf/libbpf_internal.h |  7 ++++++
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d4d56536dc4b..f87ffd4d7eab 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -226,7 +226,6 @@ typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog, long coo
 
 struct bpf_sec_def {
 	const char *sec;
-	size_t len;
 	enum bpf_prog_type prog_type;
 	enum bpf_attach_type expected_attach_type;
 	bool is_exp_attach_type_optional;
@@ -1671,7 +1670,7 @@ static int bpf_object__process_kconfig_line(struct bpf_object *obj,
 	void *ext_val;
 	__u64 num;
 
-	if (strncmp(buf, "CONFIG_", 7))
+	if (!str_has_pfx(buf, "CONFIG_"))
 		return 0;
 
 	sep = strchr(buf, '=');
@@ -2920,7 +2919,7 @@ static Elf_Data *elf_sec_data(const struct bpf_object *obj, Elf_Scn *scn)
 static bool is_sec_name_dwarf(const char *name)
 {
 	/* approximation, but the actual list is too long */
-	return strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0;
+	return str_has_pfx(name, ".debug_");
 }
 
 static bool ignore_elf_section(GElf_Shdr *hdr, const char *name)
@@ -2942,7 +2941,7 @@ static bool ignore_elf_section(GElf_Shdr *hdr, const char *name)
 	if (is_sec_name_dwarf(name))
 		return true;
 
-	if (strncmp(name, ".rel", sizeof(".rel") - 1) == 0) {
+	if (str_has_pfx(name, ".rel")) {
 		name += sizeof(".rel") - 1;
 		/* DWARF section relocations */
 		if (is_sec_name_dwarf(name))
@@ -6891,8 +6890,7 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 			if (err)
 				return err;
 			pr_debug("extern (kcfg) %s=0x%x\n", ext->name, kver);
-		} else if (ext->type == EXT_KCFG &&
-			   strncmp(ext->name, "CONFIG_", 7) == 0) {
+		} else if (ext->type == EXT_KCFG && str_has_pfx(ext->name, "CONFIG_")) {
 			need_config = true;
 		} else if (ext->type == EXT_KSYM) {
 			if (ext->ksym.type_id)
@@ -7956,7 +7954,6 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 			  attachable, attach_btf)			    \
 	{								    \
 		.sec = string,						    \
-		.len = sizeof(string) - 1,				    \
 		.prog_type = ptype,					    \
 		.expected_attach_type = eatype,				    \
 		.is_exp_attach_type_optional = eatype_optional,		    \
@@ -7987,7 +7984,6 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 
 #define SEC_DEF(sec_pfx, ptype, ...) {					    \
 	.sec = sec_pfx,							    \
-	.len = sizeof(sec_pfx) - 1,					    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
 	.preload_fn = libbpf_preload_prog,				    \
 	__VA_ARGS__							    \
@@ -8162,10 +8158,8 @@ static const struct bpf_sec_def *find_sec_def(const char *sec_name)
 	int i, n = ARRAY_SIZE(section_defs);
 
 	for (i = 0; i < n; i++) {
-		if (strncmp(sec_name,
-			    section_defs[i].sec, section_defs[i].len))
-			continue;
-		return &section_defs[i];
+		if (str_has_pfx(sec_name, section_defs[i].sec))
+			return &section_defs[i];
 	}
 	return NULL;
 }
@@ -8519,7 +8513,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd,
 			prog->sec_name);
 		return -ESRCH;
 	}
-	attach_name = prog->sec_name + prog->sec_def->len;
+	attach_name = prog->sec_name + strlen(prog->sec_def->sec);
 
 	/* BPF program's BTF ID */
 	if (attach_prog_fd) {
@@ -9479,8 +9473,11 @@ static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cooki
 	char *func;
 	int n, err;
 
-	func_name = prog->sec_name + prog->sec_def->len;
-	opts.retprobe = strcmp(prog->sec_def->sec, "kretprobe/") == 0;
+	opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
+	if (opts.retprobe)
+		func_name = prog->sec_name + sizeof("kretprobe/") - 1;
+	else
+		func_name = prog->sec_name + sizeof("kprobe/") - 1;
 
 	n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
 	if (n < 1) {
@@ -9762,8 +9759,11 @@ static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie)
 	if (!sec_name)
 		return libbpf_err_ptr(-ENOMEM);
 
-	/* extract "tp/<category>/<name>" */
-	tp_cat = sec_name + prog->sec_def->len;
+	/* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
+	if (str_has_pfx(prog->sec_name, "tp/"))
+		tp_cat = sec_name + sizeof("tp/") - 1;
+	else
+		tp_cat = sec_name + sizeof("tracepoint/") - 1;
 	tp_name = strchr(tp_cat, '/');
 	if (!tp_name) {
 		free(sec_name);
@@ -9809,7 +9809,12 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
 
 static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cookie)
 {
-	const char *tp_name = prog->sec_name + prog->sec_def->len;
+	const char *tp_name;
+
+	if (str_has_pfx(prog->sec_name, "raw_tp/"))
+		tp_name = prog->sec_name + sizeof("raw_tp/") - 1;
+	else
+		tp_name = prog->sec_name + sizeof("raw_tracepoint/") - 1;
 
 	return bpf_program__attach_raw_tracepoint(prog, tp_name);
 }
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ceb0c98979bc..ec79400517d4 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -89,6 +89,13 @@
 	(offsetof(TYPE, FIELD) + sizeof(((TYPE *)0)->FIELD))
 #endif
 
+/* Check whether a string `str` has prefix `pfx`, regardless if `pfx` is
+ * a string literal known at compilation time or char * pointer known only at
+ * runtime.
+ */
+#define str_has_pfx(str, pfx) \
+	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
+
 /* Symbol versioning is different between static and shared library.
  * Properly versioned symbols are needed for shared library, but
  * only the symbol of the new version is needed for static library.
-- 
2.30.2

