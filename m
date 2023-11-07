Return-Path: <bpf+bounces-14384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F27A77E3707
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CD3DB20DBA
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AFD10A03;
	Tue,  7 Nov 2023 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BNItPeG4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6DCA4E
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 08:56:59 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B6EAB
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 00:56:57 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A77Frmc012082
	for <bpf@vger.kernel.org>; Tue, 7 Nov 2023 00:56:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6snp4urfoNGGSk6I7/vsk/vbDfMDxgf7a28aw+tyvFg=;
 b=BNItPeG4+efUoP+R8TMBTpZHId/FlnhTxnyGZeyX9Bq97EHaMBLON95uUtlspBpR159E
 JIhc8zmUezbKwRTZHNQ/dxLTaLZsOIB9JjCbV9PM0Jk62Jm1n1HKfgYigb5IeuwbdMIM
 ynaogVO5rfk1LvvWOtVG8aSUcCJaVgL1fQA= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7gpbrfhc-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 00:56:56 -0800
Received: from twshared16118.09.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 00:56:50 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id E54F926E3B716; Tue,  7 Nov 2023 00:56:44 -0800 (PST)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 4/6] bpf: Move GRAPH_{ROOT,NODE}_MASK macros into btf_field_type enum
Date: Tue, 7 Nov 2023 00:56:37 -0800
Message-ID: <20231107085639.3016113-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107085639.3016113-1-davemarchevsky@fb.com>
References: <20231107085639.3016113-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BDXXyEZXiun2qb8bqmk_Tcvp0puQIinx
X-Proofpoint-GUID: BDXXyEZXiun2qb8bqmk_Tcvp0puQIinx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02

This refactoring patch removes the unused BPF_GRAPH_NODE_OR_ROOT
btf_field_type and moves BPF_GRAPH_{NODE,ROOT} macros into the
btf_field_type enum. Further patches in the series will use
BPF_GRAPH_NODE, so let's move this useful definition out of btf.c.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h |  4 ++--
 kernel/bpf/btf.c    | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4825d3cdb29..1dd67bcae039 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -186,8 +186,8 @@ enum btf_field_type {
 	BPF_LIST_NODE  =3D (1 << 6),
 	BPF_RB_ROOT    =3D (1 << 7),
 	BPF_RB_NODE    =3D (1 << 8),
-	BPF_GRAPH_NODE_OR_ROOT =3D BPF_LIST_NODE | BPF_LIST_HEAD |
-				 BPF_RB_NODE | BPF_RB_ROOT,
+	BPF_GRAPH_NODE =3D BPF_RB_NODE | BPF_LIST_NODE,
+	BPF_GRAPH_ROOT =3D BPF_RB_ROOT | BPF_LIST_HEAD,
 	BPF_REFCOUNT   =3D (1 << 9),
 };
=20
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..63cf4128fc05 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3840,9 +3840,6 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
 	return ERR_PTR(ret);
 }
=20
-#define GRAPH_ROOT_MASK (BPF_LIST_HEAD | BPF_RB_ROOT)
-#define GRAPH_NODE_MASK (BPF_LIST_NODE | BPF_RB_NODE)
-
 int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record =
*rec)
 {
 	int i;
@@ -3855,13 +3852,13 @@ int btf_check_and_fixup_fields(const struct btf *=
btf, struct btf_record *rec)
 	 * Hence we only need to ensure that bpf_{list_head,rb_root} ownership
 	 * does not form cycles.
 	 */
-	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & GRAPH_ROOT_MASK))
+	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & BPF_GRAPH_ROOT))
 		return 0;
 	for (i =3D 0; i < rec->cnt; i++) {
 		struct btf_struct_meta *meta;
 		u32 btf_id;
=20
-		if (!(rec->fields[i].type & GRAPH_ROOT_MASK))
+		if (!(rec->fields[i].type & BPF_GRAPH_ROOT))
 			continue;
 		btf_id =3D rec->fields[i].graph_root.value_btf_id;
 		meta =3D btf_find_struct_meta(btf, btf_id);
@@ -3873,7 +3870,7 @@ int btf_check_and_fixup_fields(const struct btf *bt=
f, struct btf_record *rec)
 		 * to check ownership cycle for a type unless it's also a
 		 * node type.
 		 */
-		if (!(rec->field_mask & GRAPH_NODE_MASK))
+		if (!(rec->field_mask & BPF_GRAPH_NODE))
 			continue;
=20
 		/* We need to ensure ownership acyclicity among all types. The
@@ -3909,7 +3906,7 @@ int btf_check_and_fixup_fields(const struct btf *bt=
f, struct btf_record *rec)
 		 * - A is both an root and node.
 		 * - B is only an node.
 		 */
-		if (meta->record->field_mask & GRAPH_ROOT_MASK)
+		if (meta->record->field_mask & BPF_GRAPH_ROOT)
 			return -ELOOP;
 	}
 	return 0;
--=20
2.34.1


