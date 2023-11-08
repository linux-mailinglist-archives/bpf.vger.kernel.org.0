Return-Path: <bpf+bounces-14455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C87E4FDE
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D866B20E13
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4EA8F68;
	Wed,  8 Nov 2023 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F66FB0
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:14:53 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D551A2
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:14:51 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A7NHSAK000888
	for <bpf@vger.kernel.org>; Tue, 7 Nov 2023 21:14:51 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3u7w39jy7h-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 21:14:50 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 21:14:47 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 16AC93B239432; Tue,  7 Nov 2023 21:14:33 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/2] veristat: add ability to sort by stat's absolute value
Date: Tue, 7 Nov 2023 21:14:29 -0800
Message-ID: <20231108051430.1830950-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YVi-n4bqI_xm_dC9QL4PKefV1ztNlzu1
X-Proofpoint-ORIG-GUID: YVi-n4bqI_xm_dC9QL4PKefV1ztNlzu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02

Add ability to sort results by absolute values of specified stats. This
is especially useful to find biggest deviations in comparison mode. When
comparing verifier change effect against a large base of BPF object
files, it's necessary to see big changes both in positive and negative
directions, as both might be a signal for regressions or bugs.

The syntax is natural, e.g., adding `-s '|insns_diff|'^` will instruct
veristat to sort by absolute value of instructions difference in
ascending order.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 68 +++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
index 655095810d4a..102914f70573 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -18,6 +18,7 @@
 #include <libelf.h>
 #include <gelf.h>
 #include <float.h>
+#include <math.h>
=20
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
@@ -99,6 +100,7 @@ struct stat_specs {
 	enum stat_id ids[ALL_STATS_CNT];
 	enum stat_variant variants[ALL_STATS_CNT];
 	bool asc[ALL_STATS_CNT];
+	bool abs[ALL_STATS_CNT];
 	int lens[ALL_STATS_CNT * 3]; /* 3x for comparison mode */
 };
=20
@@ -133,6 +135,7 @@ struct filter {
 	int stat_id;
 	enum stat_variant stat_var;
 	long value;
+	bool abs;
 };
=20
 static struct env {
@@ -455,7 +458,8 @@ static struct {
 	{ OP_EQ, "=3D" },
 };
=20
-static bool parse_stat_id_var(const char *name, size_t len, int *id, enu=
m stat_variant *var);
+static bool parse_stat_id_var(const char *name, size_t len, int *id,
+			      enum stat_variant *var, bool *is_abs);
=20
 static int append_filter(struct filter **filters, int *cnt, const char *=
str)
 {
@@ -488,13 +492,14 @@ static int append_filter(struct filter **filters, i=
nt *cnt, const char *str)
 		long val;
 		const char *end =3D str;
 		const char *op_str;
+		bool is_abs;
=20
 		op_str =3D operators[i].op_str;
 		p =3D strstr(str, op_str);
 		if (!p)
 			continue;
=20
-		if (!parse_stat_id_var(str, p - str, &id, &var)) {
+		if (!parse_stat_id_var(str, p - str, &id, &var, &is_abs)) {
 			fprintf(stderr, "Unrecognized stat name in '%s'!\n", str);
 			return -EINVAL;
 		}
@@ -533,6 +538,7 @@ static int append_filter(struct filter **filters, int=
 *cnt, const char *str)
 		f->stat_id =3D id;
 		f->stat_var =3D var;
 		f->op =3D operators[i].op_kind;
+		f->abs =3D true;
 		f->value =3D val;
=20
 		*cnt +=3D 1;
@@ -657,7 +663,8 @@ static struct stat_def {
 	[MARK_READ_MAX_LEN] =3D { "Max mark read length", {"max_mark_read_len",=
 "mark_read"}, },
 };
=20
-static bool parse_stat_id_var(const char *name, size_t len, int *id, enu=
m stat_variant *var)
+static bool parse_stat_id_var(const char *name, size_t len, int *id,
+			      enum stat_variant *var, bool *is_abs)
 {
 	static const char *var_sfxs[] =3D {
 		[VARIANT_A] =3D "_a",
@@ -667,6 +674,14 @@ static bool parse_stat_id_var(const char *name, size=
_t len, int *id, enum stat_v
 	};
 	int i, j, k;
=20
+	/* |<stat>| means we take absolute value of given stat */
+	*is_abs =3D false;
+	if (len > 2 && name[0] =3D=3D '|' && name[len - 1] =3D=3D '|') {
+		*is_abs =3D true;
+		name +=3D 1;
+		len -=3D 2;
+	}
+
 	for (i =3D 0; i < ARRAY_SIZE(stat_defs); i++) {
 		struct stat_def *def =3D &stat_defs[i];
 		size_t alias_len, sfx_len;
@@ -722,7 +737,7 @@ static bool is_desc_sym(char c)
 static int parse_stat(const char *stat_name, struct stat_specs *specs)
 {
 	int id;
-	bool has_order =3D false, is_asc =3D false;
+	bool has_order =3D false, is_asc =3D false, is_abs =3D false;
 	size_t len =3D strlen(stat_name);
 	enum stat_variant var;
=20
@@ -737,7 +752,7 @@ static int parse_stat(const char *stat_name, struct s=
tat_specs *specs)
 		len -=3D 1;
 	}
=20
-	if (!parse_stat_id_var(stat_name, len, &id, &var)) {
+	if (!parse_stat_id_var(stat_name, len, &id, &var, &is_abs)) {
 		fprintf(stderr, "Unrecognized stat name '%s'\n", stat_name);
 		return -ESRCH;
 	}
@@ -745,6 +760,7 @@ static int parse_stat(const char *stat_name, struct s=
tat_specs *specs)
 	specs->ids[specs->spec_cnt] =3D id;
 	specs->variants[specs->spec_cnt] =3D var;
 	specs->asc[specs->spec_cnt] =3D has_order ? is_asc : stat_defs[id].asc_=
by_default;
+	specs->abs[specs->spec_cnt] =3D is_abs;
 	specs->spec_cnt++;
=20
 	return 0;
@@ -1103,7 +1119,7 @@ static int process_obj(const char *filename)
 }
=20
 static int cmp_stat(const struct verif_stats *s1, const struct verif_sta=
ts *s2,
-		    enum stat_id id, bool asc)
+		    enum stat_id id, bool asc, bool abs)
 {
 	int cmp =3D 0;
=20
@@ -1124,6 +1140,11 @@ static int cmp_stat(const struct verif_stats *s1, =
const struct verif_stats *s2,
 		long v1 =3D s1->stats[id];
 		long v2 =3D s2->stats[id];
=20
+		if (abs) {
+			v1 =3D v1 < 0 ? -v1 : v1;
+			v2 =3D v2 < 0 ? -v2 : v2;
+		}
+
 		if (v1 !=3D v2)
 			cmp =3D v1 < v2 ? -1 : 1;
 		break;
@@ -1142,7 +1163,8 @@ static int cmp_prog_stats(const void *v1, const voi=
d *v2)
 	int i, cmp;
=20
 	for (i =3D 0; i < env.sort_spec.spec_cnt; i++) {
-		cmp =3D cmp_stat(s1, s2, env.sort_spec.ids[i], env.sort_spec.asc[i]);
+		cmp =3D cmp_stat(s1, s2, env.sort_spec.ids[i],
+			       env.sort_spec.asc[i], env.sort_spec.abs[i]);
 		if (cmp !=3D 0)
 			return cmp;
 	}
@@ -1211,7 +1233,8 @@ static void fetch_join_stat_value(const struct veri=
f_stats_join *s,
=20
 static int cmp_join_stat(const struct verif_stats_join *s1,
 			 const struct verif_stats_join *s2,
-			 enum stat_id id, enum stat_variant var, bool asc)
+			 enum stat_id id, enum stat_variant var,
+			 bool asc, bool abs)
 {
 	const char *str1 =3D NULL, *str2 =3D NULL;
 	double v1, v2;
@@ -1220,6 +1243,11 @@ static int cmp_join_stat(const struct verif_stats_=
join *s1,
 	fetch_join_stat_value(s1, id, var, &str1, &v1);
 	fetch_join_stat_value(s2, id, var, &str2, &v2);
=20
+	if (abs) {
+		v1 =3D fabs(v1);
+		v2 =3D fabs(v2);
+	}
+
 	if (str1)
 		cmp =3D strcmp(str1, str2);
 	else if (v1 !=3D v2)
@@ -1237,7 +1265,8 @@ static int cmp_join_stats(const void *v1, const voi=
d *v2)
 		cmp =3D cmp_join_stat(s1, s2,
 				    env.sort_spec.ids[i],
 				    env.sort_spec.variants[i],
-				    env.sort_spec.asc[i]);
+				    env.sort_spec.asc[i],
+				    env.sort_spec.abs[i]);
 		if (cmp !=3D 0)
 			return cmp;
 	}
@@ -1720,6 +1749,9 @@ static bool is_join_stat_filter_matched(struct filt=
er *f, const struct verif_sta
=20
 	fetch_join_stat_value(stats, f->stat_id, f->stat_var, &str, &value);
=20
+	if (f->abs)
+		value =3D fabs(value);
+
 	switch (f->op) {
 	case OP_EQ: return value > f->value - eps && value < f->value + eps;
 	case OP_NEQ: return value < f->value - eps || value > f->value + eps;
@@ -1766,7 +1798,7 @@ static int handle_comparison_mode(void)
 	struct stat_specs base_specs =3D {}, comp_specs =3D {};
 	struct stat_specs tmp_sort_spec;
 	enum resfmt cur_fmt;
-	int err, i, j, last_idx;
+	int err, i, j, last_idx, cnt;
=20
 	if (env.filename_cnt !=3D 2) {
 		fprintf(stderr, "Comparison mode expects exactly two input CSV files!\=
n\n");
@@ -1879,7 +1911,7 @@ static int handle_comparison_mode(void)
 		env.join_stat_cnt +=3D 1;
 	}
=20
-	/* now sort joined results accorsing to sort spec */
+	/* now sort joined results according to sort spec */
 	qsort(env.join_stats, env.join_stat_cnt, sizeof(*env.join_stats), cmp_j=
oin_stats);
=20
 	/* for human-readable table output we need to do extra pass to
@@ -1896,16 +1928,22 @@ static int handle_comparison_mode(void)
 	output_comp_headers(cur_fmt);
=20
 	last_idx =3D -1;
+	cnt =3D 0;
 	for (i =3D 0; i < env.join_stat_cnt; i++) {
 		const struct verif_stats_join *join =3D &env.join_stats[i];
=20
 		if (!should_output_join_stats(join))
 			continue;
=20
+		if (env.top_n && cnt >=3D env.top_n)
+			break;
+
 		if (cur_fmt =3D=3D RESFMT_TABLE_CALCLEN)
 			last_idx =3D i;
=20
 		output_comp_stats(join, cur_fmt, i =3D=3D last_idx);
+
+		cnt++;
 	}
=20
 	if (cur_fmt =3D=3D RESFMT_TABLE_CALCLEN) {
@@ -1920,6 +1958,9 @@ static bool is_stat_filter_matched(struct filter *f=
, const struct verif_stats *s
 {
 	long value =3D stats->stats[f->stat_id];
=20
+	if (f->abs)
+		value =3D value < 0 ? -value : value;
+
 	switch (f->op) {
 	case OP_EQ: return value =3D=3D f->value;
 	case OP_NEQ: return value !=3D f->value;
@@ -1964,7 +2005,7 @@ static bool should_output_stats(const struct verif_=
stats *stats)
 static void output_prog_stats(void)
 {
 	const struct verif_stats *stats;
-	int i, last_stat_idx =3D 0;
+	int i, last_stat_idx =3D 0, cnt =3D 0;
=20
 	if (env.out_fmt =3D=3D RESFMT_TABLE) {
 		/* calculate column widths */
@@ -1984,7 +2025,10 @@ static void output_prog_stats(void)
 		stats =3D &env.prog_stats[i];
 		if (!should_output_stats(stats))
 			continue;
+		if (env.top_n && cnt >=3D env.top_n)
+			break;
 		output_stats(stats, env.out_fmt, i =3D=3D last_stat_idx);
+		cnt++;
 	}
 }
=20
--=20
2.34.1


