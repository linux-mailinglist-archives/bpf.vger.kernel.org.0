Return-Path: <bpf+bounces-18456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F35681AB07
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 00:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0402E1F23872
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EAC4A9B7;
	Wed, 20 Dec 2023 23:31:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201334B5A1
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKLtas8018814
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 15:31:40 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3v3tv15pkm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 15:31:40 -0800
Received: from twshared17891.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 20 Dec 2023 15:31:39 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 66EF73D86504A; Wed, 20 Dec 2023 15:31:33 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/8] libbpf: use explicit map reuse flag to skip map creation steps
Date: Wed, 20 Dec 2023 15:31:21 -0800
Message-ID: <20231220233127.1990417-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220233127.1990417-1-andrii@kernel.org>
References: <20231220233127.1990417-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eAI6QxzTN7O0DvVG3KaOMittyz4SFCPy
X-Proofpoint-ORIG-GUID: eAI6QxzTN7O0DvVG3KaOMittyz4SFCPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02

Instead of inferring whether map already point to previously
created/pinned BPF map (which user can specify through
bpf_map__reuse_fd() or bpf_object__reuse_map() APIs), use explicit
map->reused flag that is set in such case.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e4fe79d5693f..2ead8fc1e344 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5463,7 +5463,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 			}
 		}
=20
-		if (map->fd >=3D 0) {
+		if (map->reused) {
 			pr_debug("map '%s': skipping creation (preset fd=3D%d)\n",
 				 map->name, map->fd);
 		} else {
--=20
2.34.1


