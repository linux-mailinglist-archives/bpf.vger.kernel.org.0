Return-Path: <bpf+bounces-18785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C491A8221A3
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0CBEB22950
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA2A15EA3;
	Tue,  2 Jan 2024 19:01:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36415EBC
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402IZJbM002315
	for <bpf@vger.kernel.org>; Tue, 2 Jan 2024 11:01:05 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vc9pavjkd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:01:05 -0800
Received: from twshared24631.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 2 Jan 2024 11:01:03 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2928C3DF0161C; Tue,  2 Jan 2024 11:01:02 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf-next 2/9] libbpf: make uniform use of btf__fd() accessor inside libbpf
Date: Tue, 2 Jan 2024 11:00:48 -0800
Message-ID: <20240102190055.1602698-3-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: gUmwuBudrRiCcW1PBgHk3NhhTRGvqLqM
X-Proofpoint-GUID: gUmwuBudrRiCcW1PBgHk3NhhTRGvqLqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02

It makes future grepping and code analysis a bit easier.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8e7a50c1ce89..4d4951933836 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7027,7 +7027,7 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
 	load_attr.prog_ifindex =3D prog->prog_ifindex;
=20
 	/* specify func_info/line_info only if kernel supports them */
-	btf_fd =3D bpf_object__btf_fd(obj);
+	btf_fd =3D btf__fd(obj->btf);
 	if (btf_fd >=3D 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
 		load_attr.prog_btf_fd =3D btf_fd;
 		load_attr.func_info =3D prog->func_info;
--=20
2.34.1


