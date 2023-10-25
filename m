Return-Path: <bpf+bounces-13273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BCD7D76EC
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C981C20AB7
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ACC347B3;
	Wed, 25 Oct 2023 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="a4ZPPbIM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706922F1A
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 21:41:29 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2CD136
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:26 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PLfQHm028069
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6snp4urfoNGGSk6I7/vsk/vbDfMDxgf7a28aw+tyvFg=;
 b=a4ZPPbIMiGHzzKE0X/FpgJvKRLDVvIa+/ZaztrRZY9vtzmFWGgrYMWsruJ+rrPXFIOfQ
 TjTnFxyXFyXkeBgoadoS8xlhvvx/4j9YHDsZKCauuvLWEORd3S9ddF0yzJH5uv5BhXPm
 CVTZvmf8M8dvC3wgWM8fLn3QWDXEAPOwTZ8= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ty23qmge1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:26 -0700
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 14:40:19 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id E7FB4264D46E1; Wed, 25 Oct 2023 14:40:13 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 4/6] bpf: Move GRAPH_{ROOT,NODE}_MASK macros into btf_field_type enum
Date: Wed, 25 Oct 2023 14:40:05 -0700
Message-ID: <20231025214007.2920506-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025214007.2920506-1-davemarchevsky@fb.com>
References: <20231025214007.2920506-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 20Jg-FAayl_ytXO45-bD8sWu0Y1Qsw5x
X-Proofpoint-ORIG-GUID: 20Jg-FAayl_ytXO45-bD8sWu0Y1Qsw5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_11,2023-10-25_01,2023-05-22_02

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


