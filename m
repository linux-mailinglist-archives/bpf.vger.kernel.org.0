Return-Path: <bpf+bounces-70608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E1EBC6288
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC56188E271
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840692BF3C5;
	Wed,  8 Oct 2025 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KulsQZI+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EDE2BEFEB
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944966; cv=none; b=MU39N0MuoO2ELj1NJ387IjKmexzJvSnD3K3Nhu08bVVICdDudkrk+2p+2P3erJFh0nbtnMfFM0YKuToajNMud51YzbskEIxXGB7DJJ+JxW4PA+Gaw7x3TD15QGuoWDpKR4vFXpoMIMzBezde6x8P/4J1wMMy+NX/RHboaS8C+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944966; c=relaxed/simple;
	bh=a+BlhbGV3CO3mxKfUMBK0iqfAab9E+xqoGGTTKxE6Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9qFf0f0pKJ+TOAZ5wc4lPTOC6uFLfl3JH6CyF5Qc+OwBXwLc8RGLVO7j+VGJiXhiEQr4lHPdp6EztCOUdlKPhBAEmZh65w2MJZ66yDIS836zdEBKFEUuEU+GJVw3CerQ7t9L5EYZr5BVxLHhehGFGzN23sDfV455jEl1YxDxlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KulsQZI+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HEUPl014051;
	Wed, 8 Oct 2025 17:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=qAS/b
	Id44cXOkn+p3JRzYkmfW5241elB36sMvFJrSA8=; b=KulsQZI+Df0IVpK36aAWD
	iF4YTX3I/jEdbg+aZm+NC3OKntaMe1ftQFP5+aTEG1ptqJ+IspUSvrSbDJOFTvKm
	L9HME3z7eO9neZafViTTvDg+zbxIIOQrgipi+kmM+cPs0MpNTM7F7eHXPIejFKYE
	2FaiMatqgIMZoK4idyXaqR4TQuDZalubZ+AsZH9TYSu9HzXHsehgxYrLoLiIWy39
	jDWQ0tA2rc5AR+uS8zP1lIRMTLI/kSRBbb8G6JXNKRFCf7xbXWJtGdFwvWN1LIlU
	sw/16rFiriaTE6ssi2fMAAtq1EExabg/DKx+oz+N8n01S87AsnDu9yrjKMyYbQib
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6c81d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDsts036975;
	Wed, 8 Oct 2025 17:35:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rpyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:37 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFUw031138;
	Wed, 8 Oct 2025 17:35:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-9;
	Wed, 08 Oct 2025 17:35:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 08/15] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to field iter tests
Date: Wed,  8 Oct 2025 18:35:04 +0100
Message-ID: <20251008173512.731801-9-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: iheZKKMJuLGUDWINRI9ROufG_PMw-h6C
X-Proofpoint-ORIG-GUID: iheZKKMJuLGUDWINRI9ROufG_PMw-h6C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1i4V16KLtCPM
 KdX3hEF5UcQ0CXbZjpdzoXSyNi7pFvFURyxsOxHYL5SNOqSNmcZBcqlcD7vjkShZdI5BdnXgofD
 gxA/jC7ksxKxc2GuS8N76x+fIcY/j5qdl4P90rrGA9IPEE4mMonnAF7te7FTGyXY9AIFhn5oF3O
 DVe09YI8PyayrOAZ0IQQBuNNlkLbQUl9rCZMDZ6xuVP33AFYz0m51e0YdrI3j+ecarmltYZmdxQ
 4bPHTONyJCibUvlhtWOIHA2pigqlvBIjIaZcTnTJ3PWmVbPvnHq/5/JHR2Uww+O5tl8MjeCEvLb
 Qe48MHizKGvuUNlrv4C7Q1idtWC+8/rVbCuIJKQiedC8aCothdNXegTe+HQ0YmbpsQLordxbA0B
 BcA+JP2ddc8J+bWNzcVofAQnnYECiuzzNngxYBVsmfUM1D8gjSA=
X-Authority-Analysis: v=2.4 cv=FYA6BZ+6 c=1 sm=1 tr=0 ts=68e6a0eb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=P1WRmwLrVkm1f4vsXGUA:9 cc=ntf
 awl=host:13625

BTF_KIND_LOC[_PARAM|_PROTO|SEC] need to work with field iteration, so extend
the selftest to cover these and ensure iteration over all types
and names succeeds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_field_iter.c | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c b/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
index 32159d3eb281..12f8030dd31a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
@@ -31,8 +31,11 @@ struct field_data {
 	{ .ids = { 11 },	.strs = { "decltag" } },
 	{ .ids = { 6 },		.strs = { "typetag" } },
 	{ .ids = {},		.strs = { "e64", "eval1", "eval2", "eval3" } },
-	{ .ids = { 15, 16 },	.strs = { "datasec1" } }
-
+	{ .ids = { 15, 16 },	.strs = { "datasec1" } },
+	{ .ids = {},		.strs = { "" } },
+	{ .ids = {},		.strs = { "" } },
+	{ .ids = { 22, 23 },.strs = { "" } },
+	{ .ids = { 13, 24 },.strs = { ".loc", "func" } }
 };
 
 /* Fabricate BTF with various types and check BTF field iteration finds types,
@@ -88,6 +91,16 @@ void test_btf_field_iter(void)
 	btf__add_datasec_var_info(btf, 15, 0, 4);
 	btf__add_datasec_var_info(btf, 16, 4, 8);
 
+	btf__add_loc_param(btf, -4, true, -1, 0, 0, 0);	/* [22] loc value -1 */
+	btf__add_loc_param(btf, 8, false, 0, 1, 0, 0);	/* [23] loc reg 1 */
+
+	btf__add_loc_proto(btf);			/* [24] loc proto */
+	btf__add_loc_proto_param(btf, 22);		/*  param value -1, */
+	btf__add_loc_proto_param(btf, 23);		/*  param reg 1 */
+
+	btf__add_locsec(btf, ".loc");			/* [25] locsec ".loc" */
+	btf__add_locsec_loc(btf, "func", 13, 24, 128);	/* "func" */
+
 	VALIDATE_RAW_BTF(
 		btf,
 		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
@@ -123,7 +136,14 @@ void test_btf_field_iter(void)
 		"\t'eval3' val=3000",
 		"[21] DATASEC 'datasec1' size=12 vlen=2\n"
 		"\ttype_id=15 offset=0 size=4\n"
-		"\ttype_id=16 offset=4 size=8");
+		"\ttype_id=16 offset=4 size=8",
+		"[22] LOC_PARAM '(anon)' size=-4 value=-1",
+		"[23] LOC_PARAM '(anon)' size=8 reg=1 flags=0x0 offset=0",
+		"[24] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=22\n"
+		"\ttype_id=23",
+		"[25] LOCSEC '.loc' vlen=1\n"
+		"\t'func' func_proto_type_id=13 loc_proto_type_id=24 offset=128");
 
 	for (id = 1; id < btf__type_cnt(btf); id++) {
 		struct btf_type *t = btf_type_by_id(btf, id);
-- 
2.39.3


