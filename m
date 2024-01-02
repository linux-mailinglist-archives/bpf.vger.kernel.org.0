Return-Path: <bpf+bounces-18790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7988221A7
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F5A283B8A
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339E1641A;
	Tue,  2 Jan 2024 19:01:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C21640A
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 402IZKHB017852
	for <bpf@vger.kernel.org>; Tue, 2 Jan 2024 11:01:25 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3vc0ecpsqc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:01:24 -0800
Received: from twshared21997.42.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 2 Jan 2024 11:01:23 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id A011D3DF0165E; Tue,  2 Jan 2024 11:01:14 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf-next 6/9] libbpf: move exception callbacks assignment logic into relocation step
Date: Tue, 2 Jan 2024 11:00:52 -0800
Message-ID: <20240102190055.1602698-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102190055.1602698-1-andrii@kernel.org>
References: <20240102190055.1602698-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yp-r8JIqtmid3XKTql3kwBZLplzBgSgh
X-Proofpoint-ORIG-GUID: yp-r8JIqtmid3XKTql3kwBZLplzBgSgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02

Move the logic of finding and assigning exception callback indices from
BTF sanitization step to program relocations step, which seems more
logical and will unblock moving BTF loading to after relocation step.

Exception callbacks discovery and assignment has no dependency on BTF
being loaded into the kernel, it only uses BTF information. It does need
to happen before subprogram relocations happen, though. Which is why the
split.

No functional changes.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 165 +++++++++++++++++++++--------------------
 1 file changed, 85 insertions(+), 80 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e0085aef17d7..d44aea1cc428 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3172,86 +3172,6 @@ static int bpf_object_sanitize_and_load_btf(struct=
 bpf_object *obj)
 		}
 	}
=20
-	if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
-		goto skip_exception_cb;
-	for (i =3D 0; i < obj->nr_programs; i++) {
-		struct bpf_program *prog =3D &obj->programs[i];
-		int j, k, n;
-
-		if (prog_is_subprog(obj, prog))
-			continue;
-		n =3D btf__type_cnt(obj->btf);
-		for (j =3D 1; j < n; j++) {
-			const char *str =3D "exception_callback:", *name;
-			size_t len =3D strlen(str);
-			struct btf_type *t;
-
-			t =3D btf_type_by_id(obj->btf, j);
-			if (!btf_is_decl_tag(t) || btf_decl_tag(t)->component_idx !=3D -1)
-				continue;
-
-			name =3D btf__str_by_offset(obj->btf, t->name_off);
-			if (strncmp(name, str, len))
-				continue;
-
-			t =3D btf_type_by_id(obj->btf, t->type);
-			if (!btf_is_func(t) || btf_func_linkage(t) !=3D BTF_FUNC_GLOBAL) {
-				pr_warn("prog '%s': exception_callback:<value> decl tag not applied =
to the main program\n",
-					prog->name);
-				return -EINVAL;
-			}
-			if (strcmp(prog->name, btf__str_by_offset(obj->btf, t->name_off)))
-				continue;
-			/* Multiple callbacks are specified for the same prog,
-			 * the verifier will eventually return an error for this
-			 * case, hence simply skip appending a subprog.
-			 */
-			if (prog->exception_cb_idx >=3D 0) {
-				prog->exception_cb_idx =3D -1;
-				break;
-			}
-
-			name +=3D len;
-			if (str_is_empty(name)) {
-				pr_warn("prog '%s': exception_callback:<value> decl tag contains emp=
ty value\n",
-					prog->name);
-				return -EINVAL;
-			}
-
-			for (k =3D 0; k < obj->nr_programs; k++) {
-				struct bpf_program *subprog =3D &obj->programs[k];
-
-				if (!prog_is_subprog(obj, subprog))
-					continue;
-				if (strcmp(name, subprog->name))
-					continue;
-				/* Enforce non-hidden, as from verifier point of
-				 * view it expects global functions, whereas the
-				 * mark_btf_static fixes up linkage as static.
-				 */
-				if (!subprog->sym_global || subprog->mark_btf_static) {
-					pr_warn("prog '%s': exception callback %s must be a global non-hidd=
en function\n",
-						prog->name, subprog->name);
-					return -EINVAL;
-				}
-				/* Let's see if we already saw a static exception callback with the =
same name */
-				if (prog->exception_cb_idx >=3D 0) {
-					pr_warn("prog '%s': multiple subprogs with same name as exception c=
allback '%s'\n",
-					        prog->name, subprog->name);
-					return -EINVAL;
-				}
-				prog->exception_cb_idx =3D k;
-				break;
-			}
-
-			if (prog->exception_cb_idx >=3D 0)
-				continue;
-			pr_warn("prog '%s': cannot find exception callback '%s'\n", prog->nam=
e, name);
-			return -ENOENT;
-		}
-	}
-skip_exception_cb:
-
 	sanitize =3D btf_needs_sanitization(obj);
 	if (sanitize) {
 		const void *raw_data;
@@ -6628,6 +6548,88 @@ static void bpf_object_sort_relos(struct bpf_objec=
t *obj)
 	}
 }
=20
+static int bpf_prog_assign_exc_cb(struct bpf_object *obj, struct bpf_pro=
gram *prog)
+{
+	const char *str =3D "exception_callback:";
+	size_t pfx_len =3D strlen(str);
+	int i, j, n;
+
+	if (!obj->btf || !kernel_supports(obj, FEAT_BTF_DECL_TAG))
+		return 0;
+
+	n =3D btf__type_cnt(obj->btf);
+	for (i =3D 1; i < n; i++) {
+		const char *name;
+		struct btf_type *t;
+
+		t =3D btf_type_by_id(obj->btf, i);
+		if (!btf_is_decl_tag(t) || btf_decl_tag(t)->component_idx !=3D -1)
+			continue;
+
+		name =3D btf__str_by_offset(obj->btf, t->name_off);
+		if (strncmp(name, str, pfx_len) !=3D 0)
+			continue;
+
+		t =3D btf_type_by_id(obj->btf, t->type);
+		if (!btf_is_func(t) || btf_func_linkage(t) !=3D BTF_FUNC_GLOBAL) {
+			pr_warn("prog '%s': exception_callback:<value> decl tag not applied t=
o the main program\n",
+				prog->name);
+			return -EINVAL;
+		}
+		if (strcmp(prog->name, btf__str_by_offset(obj->btf, t->name_off)) !=3D=
 0)
+			continue;
+		/* Multiple callbacks are specified for the same prog,
+		 * the verifier will eventually return an error for this
+		 * case, hence simply skip appending a subprog.
+		 */
+		if (prog->exception_cb_idx >=3D 0) {
+			prog->exception_cb_idx =3D -1;
+			break;
+		}
+
+		name +=3D pfx_len;
+		if (str_is_empty(name)) {
+			pr_warn("prog '%s': exception_callback:<value> decl tag contains empt=
y value\n",
+				prog->name);
+			return -EINVAL;
+		}
+
+		for (j =3D 0; j < obj->nr_programs; j++) {
+			struct bpf_program *subprog =3D &obj->programs[j];
+
+			if (!prog_is_subprog(obj, subprog))
+				continue;
+			if (strcmp(name, subprog->name) !=3D 0)
+				continue;
+			/* Enforce non-hidden, as from verifier point of
+			 * view it expects global functions, whereas the
+			 * mark_btf_static fixes up linkage as static.
+			 */
+			if (!subprog->sym_global || subprog->mark_btf_static) {
+				pr_warn("prog '%s': exception callback %s must be a global non-hidde=
n function\n",
+					prog->name, subprog->name);
+				return -EINVAL;
+			}
+			/* Let's see if we already saw a static exception callback with the s=
ame name */
+			if (prog->exception_cb_idx >=3D 0) {
+				pr_warn("prog '%s': multiple subprogs with same name as exception ca=
llback '%s'\n",
+					prog->name, subprog->name);
+				return -EINVAL;
+			}
+			prog->exception_cb_idx =3D j;
+			break;
+		}
+
+		if (prog->exception_cb_idx >=3D 0)
+			continue;
+
+		pr_warn("prog '%s': cannot find exception callback '%s'\n", prog->name=
, name);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 static int
 bpf_object_relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
@@ -6688,6 +6690,9 @@ bpf_object_relocate(struct bpf_object *obj, const c=
har *targ_btf_path)
 			return err;
 		}
=20
+		err =3D bpf_prog_assign_exc_cb(obj, prog);
+		if (err)
+			return err;
 		/* Now, also append exception callback if it has not been done already=
. */
 		if (prog->exception_cb_idx >=3D 0) {
 			struct bpf_program *subprog =3D &obj->programs[prog->exception_cb_idx=
];
--=20
2.34.1


