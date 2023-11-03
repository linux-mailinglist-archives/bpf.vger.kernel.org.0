Return-Path: <bpf+bounces-14055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE47DFD79
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 01:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A9AB21372
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DC315B4;
	Fri,  3 Nov 2023 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA61386
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 00:09:02 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A5182
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:09:00 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2MZmCE017058
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 17:09:00 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u4mpq8c8m-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 17:08:59 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 17:08:58 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4116F3AD8A8F6; Thu,  2 Nov 2023 17:08:50 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 13/13] selftests/bpf: add iter test requiring range x range logic
Date: Thu, 2 Nov 2023 17:08:22 -0700
Message-ID: <20231103000822.2509815-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103000822.2509815-1-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: roougdSoPpBt0wMeiH5PVeWEYHRn6CEC
X-Proofpoint-GUID: roougdSoPpBt0wMeiH5PVeWEYHRn6CEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02

Add a simple verifier test that requires deriving reg bounds for one
register from another register that's not a constant. This is
a realistic example of iterating elements of an array with fixed maximum
number of elements, but smaller actual number of elements.

This small example was an original motivation for doing this whole patch
set in the first place, yes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/iters.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/se=
lftests/bpf/progs/iters.c
index c20c4e38b71c..b2181f850d3e 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1411,4 +1411,26 @@ __naked int checkpoint_states_deletion(void)
 	);
 }
=20
+struct {
+	int data[32];
+	int n;
+} loop_data;
+
+SEC("raw_tp")
+__success
+int iter_arr_with_actual_elem_count(const void *ctx)
+{
+	int i, n =3D loop_data.n, sum =3D 0;
+
+	if (n > ARRAY_SIZE(loop_data.data))
+		return 0;
+
+	bpf_for(i, 0, n) {
+		/* no rechecking of i against ARRAY_SIZE(loop_data.n) */
+		sum +=3D loop_data.data[i];
+	}
+
+	return sum;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


