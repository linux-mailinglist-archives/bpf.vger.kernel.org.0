Return-Path: <bpf+bounces-70614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA84BC6291
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8228A34D8FB
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C352EC560;
	Wed,  8 Oct 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ecAJ9+qy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629202E229A
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944980; cv=none; b=n05VKz8dvHLNeCotwWMYPt8EeMN9YwhIZeYHfRrVpkknJEHU+6RStj37FVi6ix2cyaYV7BpDBrDFJS4KA+uFRyE2rz+PWxxd80LPkcu/OfO3CPv8BvbnWVeH19nQEFsbokmdHvOMdp9KEYfqtTzYwWI6HnKnxlLlyYPCMV/MTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944980; c=relaxed/simple;
	bh=GbpG2FqRVnBF9n+ZZUr8sO0mPmZE85T/nNYL9p4h80E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I72bW4CKWp2YcdSxOFEQ89c7AIkjRRgpnSdMQwUEzByJzkk+XFEp7Pd5ORG/JPPzjICjB/rzgTLFmXcNXikU3fidpBZNnfNJ+xGSGU+q1GC8uYe5uY0C7fDmM9ePETxQ5dIadhvvf+k3C4/70X09ivlGtX/NFje+td4s/XaZPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ecAJ9+qy; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HEUij032746;
	Wed, 8 Oct 2025 17:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=UVgW2
	MXcXU+Szym6BvfgkDA+NuWOoG9Qi8a472DXBjY=; b=ecAJ9+qyB+QRxi3SNLNM3
	93QUR0WRZHeQvzAUq0QKS6zXpXmdLo3q/d4Q1HvQxZkekXxLbLwmfQByVKDtyBm9
	qwJMYKLLZTKeR+GNRxzf+oSX9TrMGJRlgkeuQ6W3rQb5fuadzgLM12RwRIa6tNB5
	UWFWD5s4l9s7tFB8x81tnwk/+CarTR2lm+OdGxwnuPIBBZohNsWdYv9HDMuNahYC
	TMEd3BhzAZXC/4s3+eiFNWe1ZZEgryJ0G33Aa+4g/4Pwxe6jAEN04szcO92PVWtt
	ADdUR7Xu1+vHxRomN1ONMwtADBc8AoWgvI2/qv38FxxEi7uRkg19eGUR2Ctx/Ylb
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6br1c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDrV2036952;
	Wed, 8 Oct 2025 17:35:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rq18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:43 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFV2031138;
	Wed, 8 Oct 2025 17:35:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-11;
	Wed, 08 Oct 2025 17:35:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 10/15] selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to split BTF
Date: Wed,  8 Oct 2025 18:35:06 +0100
Message-ID: <20251008173512.731801-11-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e6a0f0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=hf7FfUZL3eI-ZkDr0lIA:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: rpP5ALPsj1EbZWBpq_QHpHsERpX3k7iN
X-Proofpoint-GUID: rpP5ALPsj1EbZWBpq_QHpHsERpX3k7iN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4zlWSmcviRqh
 aw4BzbcRJfCNN8hxHwJ7imokm2WNrGLVZkEB+lTFLRAsAjnW9VYC4uOHBpz/aZKhzLcPWKjBrm2
 LE78As9jTrN2YHHu5OLJskmc5803YkkIl3M06hR99ZWx//xXyGsd1LAxSE/PuvO73OCqXVDbIWy
 Yc+p4Ad4lAc6JN30qLKeqf1oe1ly8F3vlmxIx5wt0vP3mglrjhO1zOMd79Sz/L8xZLHvdKebiDI
 JvtISF8a3Vsm5yFeRpFJexZTovHOtNiB1tifZnwSVT5W/x8cAPaLPzgoXxUNA6wV3C5RpbzoBLn
 Y2oMH3lYVRIPA2bqqaJrj7pbWj64ciVes+jnS8zoTdKXD5O2vnzvBM7aZHDXHReQ4yUMQ9QxGze
 +X/4ltAQc8TshiGjiHc3ag7nmlkyXW+SleVGb2QjxvA6UWmzC8E=

When creating distilled BTF, BTF_KIND_LOC_PARAM and BTF_KIND_LOC_PROTO
should be added to split BTF.  This means potentially some duplication
of location information, but only for out-of-tree modules that use
distilled base/split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index fb67ae195a73..1dd26ec79b69 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -671,6 +671,72 @@ static void test_distilled_base_embedded_err(void)
 	btf__free(btf1);
 }
 
+/* LOC_PARAM, LOC_PROTO should be added to split BTF. */
+static void test_distilled_loc(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_func_proto(btf1, 1);                   /* [2] int (*)(int); */
+	btf__add_func_param(btf1, "p1", 1);
+	btf__add_loc_param(btf1, -4, true, -1, 0, 0, 0);/* [3] loc value */
+
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[3] LOC_PARAM '(anon)' size=-4 value=-1");
+
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+
+	btf__add_loc_proto(btf2);			/* [4] loc proto */
+	btf__add_loc_proto_param(btf2, 3);		/*  param value */
+
+	btf__add_locsec(btf2, ".locs");			/* [5] locsec */
+	btf__add_locsec_loc(btf2, "foo", 2, 4, 256);	/* "foo" offset 256 */
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[3] LOC_PARAM '(anon)' size=-4 value=-1",
+		"[4] LOC_PROTO '(anon)' vlen=1\n"
+		"\ttype_id=3",
+		"[5] LOCSEC '.locs' vlen=1\n"
+		"\t'foo' func_proto_type_id=2 loc_proto_type_id=4 offset=256");
+
+	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
+	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
+	    !ASSERT_EQ(2, btf__type_cnt(btf3), "distilled_base_type_cnt"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf4,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		/* remainder is split BTF */
+		"[2] LOC_PROTO '(anon)' vlen=1\n"
+		"\ttype_id=5",
+		"[3] LOCSEC '.locs' vlen=1\n"
+		"\t'foo' func_proto_type_id=4 loc_proto_type_id=2 offset=256",
+		"[4] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[5] LOC_PARAM '(anon)' size=-4 value=-1");
+cleanup:
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
 void test_btf_distill(void)
 {
 	if (test__start_subtest("distilled_base"))
@@ -689,4 +755,6 @@ void test_btf_distill(void)
 		test_distilled_base_vmlinux();
 	if (test__start_subtest("distilled_endianness"))
 		test_distilled_endianness();
+	if (test__start_subtest("distilled_loc"))
+		test_distilled_loc();
 }
-- 
2.39.3


