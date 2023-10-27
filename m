Return-Path: <bpf+bounces-13460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E77D9FB2
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7B12824C9
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8673C07C;
	Fri, 27 Oct 2023 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E3C3AC25
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:17:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D80F3
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:17:44 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39RE56Ce003448
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:17:44 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u089acj97-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:17:43 -0700
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:17:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id DBF533A796755; Fri, 27 Oct 2023 11:14:40 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 23/23] selftests/bpf: add iter test requiring range x range logic
Date: Fri, 27 Oct 2023 11:13:46 -0700
Message-ID: <20231027181346.4019398-24-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027181346.4019398-1-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7F6M4BRulpTrH1Kw3Cl3C7mPc4kXOASG
X-Proofpoint-ORIG-GUID: 7F6M4BRulpTrH1Kw3Cl3C7mPc4kXOASG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

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


