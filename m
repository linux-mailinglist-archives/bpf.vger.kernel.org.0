Return-Path: <bpf+bounces-13055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A07D427B
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AAB1C20AF9
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B9D23764;
	Mon, 23 Oct 2023 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gbDLwzyO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B71859
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:00:44 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB91D7A
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:43 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NKDh89013104
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IycrfTyEnyQVI9/6CSYf7V+dLXNMc7RXm6zjB6pA5sk=;
 b=gbDLwzyO4Z3XC4nVdL/hR7BEw7lFJhENEJvRhGZaII50ZiSut7V5h0AcTRySrX0yOKBU
 mnXnGz/Vz8yl0vCspnFoLAcGaKfCSPLFCU8PI+Kb15jEoccYi1pgn+l/AHe0nxPU4roe
 2Kn5b6RqHabrXicffoLSctxB2I52hMRyNek= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3twr6fv1wd-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:42 -0700
Received: from twshared12617.07.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 23 Oct 2023 15:00:38 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 16AC92632D0C0; Mon, 23 Oct 2023 15:00:32 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 1/4] bpf: Fix btf_get_field_type to fail for multiple bpf_refcount fields
Date: Mon, 23 Oct 2023 15:00:27 -0700
Message-ID: <20231023220030.2556229-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023220030.2556229-1-davemarchevsky@fb.com>
References: <20231023220030.2556229-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9lbb6Yc25UL1VGwbAU2WKzVsRkobjvY6
X-Proofpoint-ORIG-GUID: 9lbb6Yc25UL1VGwbAU2WKzVsRkobjvY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02

If a struct has a bpf_refcount field, the refcount controls lifetime of
the entire struct. Currently there's no usecase or support for multiple
bpf_refcount fields in a struct.

bpf_spin_lock and bpf_timer fields don't support multiples either, but
with better error behavior. Parsing BTF w/ a struct containing multiple
{bpf_spin_lock, bpf_timer} fields fails in btf_get_field_type, while
multiple bpf_refcount fields doesn't fail BTF parsing at all, instead
triggering a WARN_ON_ONCE in btf_parse_fields, with the verifier using
the last bpf_refcount field to actually do refcounting.

This patch changes bpf_refcount handling in btf_get_field_type to use
same error logic as bpf_spin_lock and bpf_timer. Since it's being used
3x and is boilerplatey, the logic is shoved into
field_mask_test_name_check_seen helper macro.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Fixes: d54730b50bae ("bpf: Introduce opaque bpf_refcount struct and add b=
tf_record plumbing")
---
 kernel/bpf/btf.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..975ef8e73393 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3374,8 +3374,17 @@ btf_find_graph_root(const struct btf *btf, const s=
truct btf_type *pt,
 	return BTF_FIELD_FOUND;
 }
=20
-#define field_mask_test_name(field_type, field_type_str) \
-	if (field_mask & field_type && !strcmp(name, field_type_str)) { \
+#define field_mask_test_name(field_type, field_type_str)		\
+	if (field_mask & field_type && !strcmp(name, field_type_str)) {	\
+		type =3D field_type;					\
+		goto end;						\
+	}
+
+#define field_mask_test_name_check_seen(field_type, field_type_str)	\
+	if (field_mask & field_type && !strcmp(name, field_type_str)) {	\
+		if (*seen_mask & field_type)				\
+			return -E2BIG;					\
+		*seen_mask |=3D field_type;				\
 		type =3D field_type;					\
 		goto end;						\
 	}
@@ -3385,29 +3394,14 @@ static int btf_get_field_type(const char *name, u=
32 field_mask, u32 *seen_mask,
 {
 	int type =3D 0;
=20
-	if (field_mask & BPF_SPIN_LOCK) {
-		if (!strcmp(name, "bpf_spin_lock")) {
-			if (*seen_mask & BPF_SPIN_LOCK)
-				return -E2BIG;
-			*seen_mask |=3D BPF_SPIN_LOCK;
-			type =3D BPF_SPIN_LOCK;
-			goto end;
-		}
-	}
-	if (field_mask & BPF_TIMER) {
-		if (!strcmp(name, "bpf_timer")) {
-			if (*seen_mask & BPF_TIMER)
-				return -E2BIG;
-			*seen_mask |=3D BPF_TIMER;
-			type =3D BPF_TIMER;
-			goto end;
-		}
-	}
+	field_mask_test_name_check_seen(BPF_SPIN_LOCK, "bpf_spin_lock");
+	field_mask_test_name_check_seen(BPF_TIMER,     "bpf_timer");
+	field_mask_test_name_check_seen(BPF_REFCOUNT,  "bpf_refcount");
+
 	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
 	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
 	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
 	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
-	field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
=20
 	/* Only return BPF_KPTR when all other types with matchable names fail =
*/
 	if (field_mask & BPF_KPTR) {
@@ -3421,6 +3415,7 @@ static int btf_get_field_type(const char *name, u32=
 field_mask, u32 *seen_mask,
 	return type;
 }
=20
+#undef field_mask_test_name_check_seen
 #undef field_mask_test_name
=20
 static int btf_find_struct_field(const struct btf *btf,
--=20
2.34.1


