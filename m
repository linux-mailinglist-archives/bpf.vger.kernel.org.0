Return-Path: <bpf+bounces-70607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB9BC6285
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C32D4E9FC9
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDFC2BF00D;
	Wed,  8 Oct 2025 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HzE6l6ek"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FF2BEFEA
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944965; cv=none; b=UjQI6gGCOcswVQ40u+cbH1flGVRwM5geeUxpKq7ARz9N1nqwC2Av8bNlUnNkWoDeWemz6QOqw6on/BwY4y7B7GFUFAhS+TMy+Y1sVIY/DWXHVleUHQzDWmGQmHPcBCPImk2++1+ZIlycE06HWQOwIt/5be0vDumuMGs+Xn/r6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944965; c=relaxed/simple;
	bh=CSWMVd+ARz5QahJJkb/9drheJGYn/EoWYQfSrdLBKZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/wc9eKPBxFAusAsqJPcC05XAobyST+8vfRMVxf8iKKL/tnNz+JfaKAL+C6tKlswp7dG4iKpftfw3MZtRS365LXQI8aZNN7sBHBm8dad+MI6jQrPTcKcOM+N5pmF81iOjEtnzxUCNwrN2XpMEsYrtoc30lYPqtPvdK+jfMK82U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HzE6l6ek; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HJWhu018517;
	Wed, 8 Oct 2025 17:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=PSE8F
	gWXWtqAQbmpQLKby3EFKPetcuY2ZCAnjpIRgWM=; b=HzE6l6ekRfPhQ20TajUJb
	D6PY3jl94dIRIVjeDcGch2SkZ/2gSVws/ZrBRo9q1BiZg9pgccZuUyrQSJRViknG
	EuGOrZwLTnIoeSNbty0/ytBUr7JMxo/4TARZ6Iuu9FZ0J3BtcMC9hXnNW0nWfs/6
	21BX4CAIKosdpAUd3f2Os27e3XPP57aQ+ZkRJdFH24I6/JS1bKJ4JveFxs1QlZaA
	BLloNramZKAbEh42YABhQLgmluXYXXjRD4LBf8YdTZGF2H2od+OENtlm8Nfkmgg6
	6RCWtWjPR6qUUzj744eJ/NiovoYAzE9BhJmPDhX/CBjVdMwUUW7b1edu0FEUoGoY
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8pr0xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDt3n037061;
	Wed, 8 Oct 2025 17:35:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rq0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFV0031138;
	Wed, 8 Oct 2025 17:35:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-10;
	Wed, 08 Oct 2025 17:35:39 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 09/15] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
Date: Wed,  8 Oct 2025 18:35:05 +0100
Message-ID: <20251008173512.731801-10-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 7FE-5BdNrxgPfpquQ_TRuCTamqnLRNOn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX35xc+7FDtXvT
 AztRv2sFDL9pVm8BleSzqx8xgCH8xnYCrxRODCeE5DEHdkoS1Z4lVXIYMn1D+8yiEYewUtf924H
 MVg6U2d1wf0ZRBo4HPumZtUbYqM99cgGTkhUEJUVh6RNKPux/ci1Rg3DjD5r1FFg/hDO6a+ahWX
 kUmHi5LMw+YJesTUyWbgHOXrSsUmz2mrKuMssf1BK7/kQZNwLkvEgzDu+SJXTUxJLgIdtfn9/Sj
 4ew104d3Tn+CfquW2L3dXi+dNTkwLbEDhQlyQA8050JxmIzY/3AD6mAkgNNwBOABhp6fsKkmv2J
 VeH687WubwdzJ2BYXhInf23L3n9htN4nZbewgwuD3qkPxq98nsW1nA3tgzjw37tLgpkAh1MBhI+
 2X919d3a0ipcsJRzV7IEj7olaHFrebzAtI0zth4LBG/gGPukLFU=
X-Proofpoint-ORIG-GUID: 7FE-5BdNrxgPfpquQ_TRuCTamqnLRNOn
X-Authority-Analysis: v=2.4 cv=U6SfzOru c=1 sm=1 tr=0 ts=68e6a0ee b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=Dqmx8x_qsB7B715aku4A:9 cc=ntf
 awl=host:13625

Ensure that location params/protos are deduplicated and location
sections are not, and that references to deduplicated locations within
location prototypes and sections are updated after deduplication.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/prog_tests/btf_dedup_split.c          | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 5bc15bb6b7ce..583d24ce0752 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -539,6 +539,97 @@ static void test_split_module(void)
 	btf__free(vmlinux_btf);
 }
 
+static void test_split_loc(void)
+{
+	//const struct btf_type *t;
+	struct btf *btf1, *btf2;
+	int err;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+
+	btf__set_pointer_size(btf1, 8); /* enforce 64-bit arch */
+
+
+	btf__add_int(btf1, "long", 8, BTF_INT_SIGNED);  /* [1] long */
+	btf__add_ptr(btf1, 1);                          /* [2] ptr to long */
+	btf__add_func_proto(btf1, 1);			/* [3] long (*)(long, long *); */
+	btf__add_func_param(btf1, "p1", 1);
+	btf__add_func_param(btf1, "p2", 2);
+	btf__add_loc_param(btf1, -8, true, -9223372036854775807, 0, 0, 0);
+							/* [4] loc value */
+	btf__add_loc_param(btf1, 8, false, 0, 1, 0, 0);	/* [5] loc reg 1 */
+	btf__add_loc_proto(btf1);			/* [6] loc proto */
+	btf__add_loc_proto_param(btf1, 4);		/*  param value */
+	btf__add_loc_proto_param(btf1, 5);		/*  param reg 1 */
+
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2\n"
+		"\t'p1' type_id=1\n"
+		"\t'p2' type_id=2",
+		"[4] LOC_PARAM '(anon)' size=-8 value=-9223372036854775807",
+		"[5] LOC_PARAM '(anon)' size=8 reg=1 flags=0x0 offset=0",
+		"[6] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=4\n"
+		"\ttype_id=5");
+
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+	btf__add_loc_param(btf2, 8, false, 0, 1, 0, 0); /* [7] loc reg 1 */
+	btf__add_loc_proto(btf2);			/* [8] loc proto */
+	btf__add_loc_proto_param(btf2, 4);		/* param value */
+	btf__add_loc_proto_param(btf2, 7);		/* param reg 1 */
+	btf__add_locsec(btf2, ".locs");			/* [9] locsec ".locs" */
+	btf__add_locsec_loc(btf2, "foo", 3, 8, 128);
+
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2\n"
+		"\t'p1' type_id=1\n"
+		"\t'p2' type_id=2",
+		"[4] LOC_PARAM '(anon)' size=-8 value=-9223372036854775807",
+		"[5] LOC_PARAM '(anon)' size=8 reg=1 flags=0x0 offset=0",
+		"[6] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=4\n"
+		"\ttype_id=5",
+		"[7] LOC_PARAM '(anon)' size=8 reg=1 flags=0x0 offset=0",
+		"[8] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=4\n"
+		"\ttype_id=7",
+		"[9] LOCSEC '.locs' vlen=1\n"
+		"\t'foo' func_proto_type_id=3 loc_proto_type_id=8 offset=128");
+
+	err = btf__dedup(btf2, NULL);
+	if (!ASSERT_OK(err, "btf_dedup"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2\n"
+		"\t'p1' type_id=1\n"
+		"\t'p2' type_id=2",
+		"[4] LOC_PARAM '(anon)' size=-8 value=-9223372036854775807",
+		"[5] LOC_PARAM '(anon)' size=8 reg=1 flags=0x0 offset=0",
+		"[6] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=4\n"
+		"\ttype_id=5",
+		"[7] LOCSEC '.locs' vlen=1\n"
+		"\t'foo' func_proto_type_id=3 loc_proto_type_id=6 offset=128");
+
+cleanup:
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
 void test_btf_dedup_split()
 {
 	if (test__start_subtest("split_simple"))
@@ -551,4 +642,6 @@ void test_btf_dedup_split()
 		test_split_dup_struct_in_cu();
 	if (test__start_subtest("split_module"))
 		test_split_module();
+	if (test__start_subtest("split_loc"))
+		test_split_loc();
 }
-- 
2.39.3


