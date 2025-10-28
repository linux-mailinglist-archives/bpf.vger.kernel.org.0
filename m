Return-Path: <bpf+bounces-72567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FB0C15A86
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DBB3BA81F
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FF134573F;
	Tue, 28 Oct 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VB7IqgKZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86B341AC3
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667076; cv=none; b=NOxFVRnPnFpV23UCeGP7p8g+B9F3p4QKo7bAJC46LJL3Qp10MoDudZ/3QpU8RqFAKjLfR77kGSLqWZt8go9KSzAuWQmpbC3G4LiYDLKU8/9IVtmeA15Q1uDraDQPWR/E4PvPC9w1hEdw3xxk9AHivIzizr/Yg/X6C7ungqqFJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667076; c=relaxed/simple;
	bh=8PUmWpKQLKM/JczYuUVZWd2e08egSgI8B+V0+d1Bh2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBgBUKD/bYWZQRbWcElXjIbSrdzCkPL/6OrEj/kaKnH8DMiTG5GNCPvLuWkP9v0uAHL4NFuVHwJXouMBIhguP9NdtfhRAsLeayS3AogHouuavT+q9EhGS7uoJeVOxwvWV9QUBSMJV+CG9NITG0+So3DIgVuK2rRq9JDQaR5I4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VB7IqgKZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDiWQ015545;
	Tue, 28 Oct 2025 15:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=IQDNK
	aqALv/ymULhw+K9cO+sYxWmMTW6CPX8soKQiW0=; b=VB7IqgKZeo7iGDWwbdYpW
	8UEXzsU1t7AeeQoX6Q2yAQWL2avjpft0LrnVD5vdn5TA0U3mr0lK9AaenYtmV+uV
	2dpV9kLW0BCF4G0Hz3axL/IwwepqwWuxeF/MQ8DSJ3S+RcGf5GXUfJq7Jt1zmzEz
	boBEXzPGgsRXgZ8uE1K9AP7n8DCDjn+ZXpuDR+8E+praFZOLebb3OW+9iV9NHhnj
	GEBpSndqlU6aaxZiYC5izZw17I69m4UDFIopFhmzSSGGNeHFn1j8VqOoWu62hbI5
	W5c+oduZNsbg4bRdhX71I5nZKtP0qDRaRunFzAo3roM5U6rsEQ23sMPLgxy6lP4Z
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ypmeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:57:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SEiCNf016883;
	Tue, 28 Oct 2025 15:57:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08cgx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:57:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59SFvDAe009896;
	Tue, 28 Oct 2025 15:57:21 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-56-75.vpn.oracle.com [10.154.56.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a0n08cgqf-3;
	Tue, 28 Oct 2025 15:57:20 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Test parsing of (multi-)split BTF
Date: Tue, 28 Oct 2025 15:57:09 +0000
Message-ID: <20251028155709.1265445-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251028155709.1265445-1-alan.maguire@oracle.com>
References: <20251028155709.1265445-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfX5itypDd15pMW
 UD353avWmnMnYWKStONtipEzVc6qYbAlcFIbhbuhI+6JGyzbpCxWjItTkcjuHVYkP6EK+l+kxj8
 M1EiE1lS7DQ69D6Semb2a8L1OdYrRC0y2XJNPdMHoW5bGlD2Ot9PS0ILOL6mHdOMJlRqjlOMpfz
 eBgHgelk0DjZo9hCXE1h89jzzkTRiqbMvevOZKnX7AiNRUXKKCzgARug4PQakfBVz3vSZjA2iE4
 xAMibvQp2hjZxrAQcs7gj3UGhrDMf29to4IurYaDGQW8gBd6sGghFDL/roOT5Ye9QTsKQ97Sl0M
 mfZpSUJXpEj2Wi4S+16q1KoGFJKT36ASX6FN0VIBqjntbR8z1LoeP0YrS8gmkLsStIeOXMr+Z1F
 jHIDihaYGQOBjwQva1wf/dOJAk4LPQ==
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=6900e7e3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=qObbi30BQAl4vFSC2DMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: MzoOYF5pH1Rr6Ss2J4hsDTT7cpZ38pdT
X-Proofpoint-GUID: MzoOYF5pH1Rr6Ss2J4hsDTT7cpZ38pdT

Write raw BTF to files, parse it and compare to original;
this allows us to test parsing of (multi-)split BTF code.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_split.c      | 71 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
index 3696fb9a05ed..ee1481c5fe27 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
@@ -12,11 +12,43 @@ static void btf_dump_printf(void *ctx, const char *fmt, va_list args)
 	vfprintf(ctx, fmt, args);
 }
 
+static int btf_raw_write(struct btf *btf, char *file)
+{
+	ssize_t written = 0;
+	const void *data;
+	__u32 size = 0;
+	int fd, ret;
+
+	fd = mkstemp(file);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return -errno;
+
+	data = btf__raw_data(btf, &size);
+	if (!ASSERT_OK_PTR(data, "btf__raw_data")) {
+		close(fd);
+		return -EINVAL;
+	}
+	while (written < size) {
+		ret = write(fd, data + written, size - written);
+		if (!ASSERT_GE(ret, 0, "write succeeded")) {
+			close(fd);
+			return -errno;
+		}
+		written += ret;
+	}
+	close(fd);
+	return 0;
+}
+
 static void __test_btf_split(bool multi)
 {
+	char multisplit_btf_file[] = "/tmp/test_btf_multisplit.XXXXXX";
+	char split_btf_file[] = "/tmp/test_btf_split.XXXXXX";
+	char base_btf_file[] = "/tmp/test_btf_base.XXXXXX";
 	struct btf_dump *d = NULL;
-	const struct btf_type *t;
+	const struct btf_type *t, *ot;
 	struct btf *btf1, *btf2, *btf3 = NULL;
+	struct btf *btf4, *btf5, *btf6 = NULL;
 	int str_off, i, err;
 
 	btf1 = btf__new_empty();
@@ -123,6 +155,35 @@ static void __test_btf_split(bool multi)
 "	int uf2;\n"
 "};\n\n", "c_dump");
 
+	/* write base, split BTFs to files and ensure parsing succeeds */
+	if (btf_raw_write(btf1, base_btf_file) != 0)
+		goto cleanup;
+	if (btf_raw_write(btf2, split_btf_file) != 0)
+		goto cleanup;
+	btf4 = btf__parse(base_btf_file, NULL);
+	if (!ASSERT_OK_PTR(btf4, "parse_base"))
+		goto cleanup;
+	btf5 = btf__parse_split(split_btf_file, btf4);
+	if (!ASSERT_OK_PTR(btf5, "parse_split"))
+		goto cleanup;
+	if (multi) {
+		if (btf_raw_write(btf3, multisplit_btf_file) != 0)
+			goto cleanup;
+		btf6 = btf__parse_split(multisplit_btf_file, btf5);
+		if (!ASSERT_OK_PTR(btf5, "parse_multisplit"))
+			goto cleanup;
+	} else {
+		btf6 = btf5;
+	}
+
+	/* compare parsed to original BTF */
+	for (i = 1; i < btf__type_cnt(btf6); i++) {
+		t = btf__type_by_id(btf6, i);
+		ot = btf__type_by_id(btf3, i);
+		if (!ASSERT_EQ(memcmp(t, ot, sizeof(*ot)), 0, "cmp_parsed_orig_btf"))
+			goto cleanup;
+	}
+
 cleanup:
 	if (dump_buf_file)
 		fclose(dump_buf_file);
@@ -132,6 +193,14 @@ static void __test_btf_split(bool multi)
 	btf__free(btf2);
 	if (btf2 != btf3)
 		btf__free(btf3);
+	btf__free(btf4);
+	btf__free(btf5);
+	if (btf5 != btf6)
+		btf__free(btf6);
+	unlink(base_btf_file);
+	unlink(split_btf_file);
+	if (multi)
+		unlink(multisplit_btf_file);
 }
 
 void test_btf_split(void)
-- 
2.39.3


