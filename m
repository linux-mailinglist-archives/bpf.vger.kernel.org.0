Return-Path: <bpf+bounces-44372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A39C24A5
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442661F21D46
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386CA233D89;
	Fri,  8 Nov 2024 18:07:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B5233D7C
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089278; cv=none; b=SwvzIe90uOnYiReye/Fmzo9QfVC5XtTQE7ELawzOzD0YJ/HIqG4eQSNK+GyHqZJyNzdkXnC+rtXAlzWcXTMjFdIHMMvX9KJKCUok+P7ICcaEAW/wVOX+PZC1TGlxibaRf66QdAwtRraUXZ5uvNuMpjxWYqmMhCXKow3KXRfML+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089278; c=relaxed/simple;
	bh=o8lH6VFClLPMd9R0JpHX4h8TLARAMqouOLns2ETyhOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lB74CGtMRViSlpfJUdduLz6y4TDFD+pOJXVIpp6XhxXAzwBdGua9OtXqHOVRciZAwfSvW29vRDyI6HcPRlSlyZTjykBJ9M2NpDAHk56SzJ6Rv9J0SR3X8v1Kj5Fu4zfXBNVYIMGjfnZGmevFQronflN0yY+GA9BGKrNc+fA5E9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B1CDAADDC517; Fri,  8 Nov 2024 10:05:13 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com
Subject: [PATCH dwarves 1/3] dwarf_loader: Refactor function parameter__new()
Date: Fri,  8 Nov 2024 10:05:13 -0800
Message-ID: <20241108180513.1197600-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108180508.1196431-1-yonghong.song@linux.dev>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The dwarf location checking part of function parameter__new() is refactor=
ed
to another function. The current dwarf location checking only for
the first expression of the first location. One later patch may traverse
all expressions of all locations, so refactoring makes later change easie=
r.

No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 77 ++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ec8641b..4bb9096 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1157,16 +1157,56 @@ static struct template_parameter_pack *template_p=
arameter_pack__new(Dwarf_Die *d
 	return pack;
 }
=20
+static bool check_dwarf_locations(Dwarf_Attribute *attr, struct paramete=
r *parm,
+				  struct cu *cu, int param_idx)
+{
+	Dwarf_Addr base, start, end;
+	struct location loc;
+
+	/* dwarf_getlocations() handles location lists; here we are
+	 * only interested in the first expr.
+	 */
+	if (parm->has_loc &&
+#if _ELFUTILS_PREREQ(0, 157)
+	    dwarf_getlocations(attr, 0, &base, &start, &end,
+			       &loc.expr, &loc.exprlen) > 0 &&
+#else
+	    dwarf_getlocation(attr, &loc.expr, &loc.exprlen) =3D=3D 0 &&
+#endif
+		loc.exprlen !=3D 0) {
+		int expected_reg =3D cu->register_params[param_idx];
+		Dwarf_Op *expr =3D loc.expr;
+
+		switch (expr->atom) {
+		case DW_OP_reg0 ... DW_OP_reg31:
+			/* mark parameters that use an unexpected
+			 * register to hold a parameter; these will
+			 * be problematic for users of BTF as they
+			 * violate expectations about register
+			 * contents.
+			 */
+			if (expected_reg >=3D 0 && expected_reg !=3D expr->atom)
+				parm->unexpected_reg =3D 1;
+			break;
+		default:
+			parm->optimized =3D 1;
+			break;
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
 static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 					struct conf_load *conf, int param_idx)
 {
 	struct parameter *parm =3D tag__alloc(cu, sizeof(*parm));
=20
 	if (parm !=3D NULL) {
-		Dwarf_Addr base, start, end;
 		bool has_const_value;
 		Dwarf_Attribute attr;
-		struct location loc;
=20
 		tag__init(&parm->tag, cu, die);
 		parm->name =3D attr_string(die, DW_AT_name, conf);
@@ -1208,38 +1248,9 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 		 */
 		has_const_value =3D dwarf_attr(die, DW_AT_const_value, &attr) !=3D NUL=
L;
 		parm->has_loc =3D dwarf_attr(die, DW_AT_location, &attr) !=3D NULL;
-		/* dwarf_getlocations() handles location lists; here we are
-		 * only interested in the first expr.
-		 */
-		if (parm->has_loc &&
-#if _ELFUTILS_PREREQ(0, 157)
-		    dwarf_getlocations(&attr, 0, &base, &start, &end,
-				       &loc.expr, &loc.exprlen) > 0 &&
-#else
-		    dwarf_getlocation(&attr, &loc.expr, &loc.exprlen) =3D=3D 0 &&
-#endif
-			loc.exprlen !=3D 0) {
-			int expected_reg =3D cu->register_params[param_idx];
-			Dwarf_Op *expr =3D loc.expr;
-
-			switch (expr->atom) {
-			case DW_OP_reg0 ... DW_OP_reg31:
-				/* mark parameters that use an unexpected
-				 * register to hold a parameter; these will
-				 * be problematic for users of BTF as they
-				 * violate expectations about register
-				 * contents.
-				 */
-				if (expected_reg >=3D 0 && expected_reg !=3D expr->atom)
-					parm->unexpected_reg =3D 1;
-				break;
-			default:
-				parm->optimized =3D 1;
-				break;
-			}
-		} else if (has_const_value) {
+
+		if (!check_dwarf_locations(&attr, parm, cu, param_idx) && has_const_va=
lue)
 			parm->optimized =3D 1;
-		}
 	}
=20
 	return parm;
--=20
2.43.5


