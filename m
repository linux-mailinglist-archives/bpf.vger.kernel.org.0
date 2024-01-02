Return-Path: <bpf+bounces-18791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B688C8221A8
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54657281488
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F716423;
	Tue,  2 Jan 2024 19:01:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0316410
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402IZJRQ002349
	for <bpf@vger.kernel.org>; Tue, 2 Jan 2024 11:01:27 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vc9pavjqg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:01:27 -0800
Received: from twshared24631.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 2 Jan 2024 11:01:25 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B48ED3DF01664; Tue,  2 Jan 2024 11:01:16 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf-next 7/9] libbpf: move BTF loading step after relocation step
Date: Tue, 2 Jan 2024 11:00:53 -0800
Message-ID: <20240102190055.1602698-8-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: jsBxd8l13IlWgUo2m2IMmqZf-G-JMpfX
X-Proofpoint-GUID: jsBxd8l13IlWgUo2m2IMmqZf-G-JMpfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02

With all the preparations in previous patches done we are ready to
postpone BTF loading and sanitization step until after all the
relocations are performed.

While at it, simplify step name from bpf_object_sanitize_and_load_btf
to bpf_object_load_btf. Map creation and program loading steps also
perform sanitization, but they don't explicitly reflect it in overly
verbose function name. So keep naming and approch consistent here.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d44aea1cc428..d5f5c1a8f543 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3122,7 +3122,7 @@ static int bpf_object_load_vmlinux_btf(struct bpf_o=
bject *obj, bool force)
 	return 0;
 }
=20
-static int bpf_object_sanitize_and_load_btf(struct bpf_object *obj)
+static int bpf_object_load_btf(struct bpf_object *obj)
 {
 	struct btf *kern_btf =3D obj->btf;
 	bool btf_mandatory, sanitize;
@@ -8068,10 +8068,10 @@ static int bpf_object_load(struct bpf_object *obj=
, int extra_log_level, const ch
 	err =3D bpf_object_probe_loading(obj);
 	err =3D err ? : bpf_object_load_vmlinux_btf(obj, false);
 	err =3D err ? : bpf_object_resolve_externs(obj, obj->kconfig);
-	err =3D err ? : bpf_object_sanitize_and_load_btf(obj);
 	err =3D err ? : bpf_object_sanitize_maps(obj);
 	err =3D err ? : bpf_object_init_kern_struct_ops_maps(obj);
 	err =3D err ? : bpf_object_relocate(obj, obj->btf_custom_path ? : targe=
t_btf_path);
+	err =3D err ? : bpf_object_load_btf(obj);
 	err =3D err ? : bpf_object_create_maps(obj);
 	err =3D err ? : bpf_object_load_progs(obj, extra_log_level);
 	err =3D err ? : bpf_object_init_prog_arrays(obj);
--=20
2.34.1


