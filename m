Return-Path: <bpf+bounces-17603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21D80FA90
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D57B20F82
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C211446A0;
	Tue, 12 Dec 2023 22:54:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6407AA
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:53:59 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLg7f5002091
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:53:59 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uxkk95hg9-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:53:59 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 14:53:58 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id F3BDE3D0C37DB; Tue, 12 Dec 2023 14:53:44 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: fix compiler warnings in RELEASE=1 mode
Date: Tue, 12 Dec 2023 14:53:43 -0800
Message-ID: <20231212225343.1723081-1-andrii@kernel.org>
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
X-Proofpoint-GUID: t7cPptOUgieUpsKjLqZne9qtVJM4__9t
X-Proofpoint-ORIG-GUID: t7cPptOUgieUpsKjLqZne9qtVJM4__9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

When compiling BPF selftests with RELEASE=3D1, we get two new
warnings, which are treated as errors. Fix them.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c        | 2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
index 1d418d66e375..244d4996e06e 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1254,7 +1254,7 @@ static int cmp_join_stat(const struct verif_stats_j=
oin *s1,
 			 bool asc, bool abs)
 {
 	const char *str1 =3D NULL, *str2 =3D NULL;
-	double v1, v2;
+	double v1 =3D 0.0, v2 =3D 0.0;
 	int cmp =3D 0;
=20
 	fetch_join_stat_value(s1, id, var, &str1, &v1);
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testin=
g/selftests/bpf/xdp_hw_metadata.c
index 3291625ba4fb..c69c08933fdd 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -79,7 +79,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32=
 queue_id)
 		.flags =3D XSK_UMEM__DEFAULT_FLAGS,
 		.tx_metadata_len =3D sizeof(struct xsk_tx_metadata),
 	};
-	__u32 idx;
+	__u32 idx =3D 0;
 	u64 addr;
 	int ret;
 	int i;
--=20
2.34.1


