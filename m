Return-Path: <bpf+bounces-18987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5003823A49
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645A3287EF4
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34417F8;
	Thu,  4 Jan 2024 01:39:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E946184F
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiIB5027331
	for <bpf@vger.kernel.org>; Wed, 3 Jan 2024 17:39:19 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vcxn2qk6u-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 17:39:19 -0800
Received: from twshared21997.42.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 17:39:16 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B8DCF3DFAFE81; Wed,  3 Jan 2024 17:39:03 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v3 bpf-next 6/9] libbpf: move BTF loading step after relocation step
Date: Wed, 3 Jan 2024 17:38:44 -0800
Message-ID: <20240104013847.3875810-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104013847.3875810-1-andrii@kernel.org>
References: <20240104013847.3875810-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 78QGI2noR1vWjxUBOtO0jUBBoCZM-Ag1
X-Proofpoint-GUID: 78QGI2noR1vWjxUBOtO0jUBBoCZM-Ag1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_10,2024-01-03_01,2023-05-22_02

With all the preparations in previous patches done we are ready to
postpone BTF loading and sanitization step until after all the
relocations are performed.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01d45f0c40d0..836986974de3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8104,10 +8104,10 @@ static int bpf_object_load(struct bpf_object *obj=
, int extra_log_level, const ch
 	err =3D bpf_object__probe_loading(obj);
 	err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
 	err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
-	err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
 	err =3D err ? : bpf_object__sanitize_maps(obj);
 	err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
 	err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : targ=
et_btf_path);
+	err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
 	err =3D err ? : bpf_object__create_maps(obj);
 	err =3D err ? : bpf_object__load_progs(obj, extra_log_level);
 	err =3D err ? : bpf_object_init_prog_arrays(obj);
--=20
2.34.1


