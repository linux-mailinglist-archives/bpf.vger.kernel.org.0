Return-Path: <bpf+bounces-72645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8DAC173E7
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68DB53566F6
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271CF36A5E0;
	Tue, 28 Oct 2025 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYtTg1DE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B773557FE
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692181; cv=none; b=BdWk7myXRUbuV//0UA6yKSNxElxKJko/QWOhEP+hPcKe/MaTRWj9oN0pvFKeo5NuhzRH3aOzRPyxtG5t/hNUFbs19GD+3hbthFD8IKadv2Dua8zgSJEkwDhYZgNHX0/7sgM2WMyq2tjfd3HNwlv7bDm7rzpIJTmUP3oQ5nQHYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692181; c=relaxed/simple;
	bh=5OQlZJ+2cj+oZrJM21CRhpvTbwo7ClA34CAe6idBfuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/FvGiKzEtCdL8xFlXXqjESl257NPwaQwjMIPYdM2lCSXSLHup/iuy2vf6SRCKTWkc0+giw4HAHSh/AIA2j9pb4ZsgRl0yV9dbT0T0v/u8Dw3T1dZX4U6aKWbQfsy14HdQORUlacoZuAdKsstQ1NE/2COA5doalbS16Bb2ADCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nYtTg1DE; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SMCslW031175;
	Tue, 28 Oct 2025 22:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=UB6Hx
	WEoBAWOhWtRGJattRz78hrCqNBg94fn62nweqg=; b=nYtTg1DE62Iawxa91wdr0
	sKFagriwJMGFVJKTXg/imMO9TEuUu0wMcP7oDo/0P5Q3foYFFujWV1k0s6ggeqSp
	djABbQ4UCax7zecGEzY+jDOMxwY7MEEp/X9bgdz8v+yBlts7NKLFKf6Xouzi33Te
	hJU5ls9KxjtwLt9ZxvslN2q2MhJZuPiTVQaxQLZp7AvLBUyPNthc2750NCc1vQr/
	K5gj8BCfOyLLpavt77jlmkMyhE9w1XmfQ7PJ+/jfzBrOSPE5cNMkLfrJMzqSyK9+
	I/HGcbNGvJjyLurU7OrR5AP7PkQicxy2VVkFl3W+U710t/+FJug/eb+sL0y5Gp94
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vygbc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 22:55:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SLUFSX011236;
	Tue, 28 Oct 2025 22:55:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vwek6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 22:55:56 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59SMpl5w001957;
	Tue, 28 Oct 2025 22:55:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-249.vpn.oracle.com [10.154.54.249])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a33vwek50-3;
	Tue, 28 Oct 2025 22:55:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Test parsing of (multi-)split BTF
Date: Tue, 28 Oct 2025 22:55:44 +0000
Message-ID: <20251028225544.1312356-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251028225544.1312356-1-alan.maguire@oracle.com>
References: <20251028225544.1312356-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510280194
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX7M12HtyZ3xbe
 2LpGkI1SLi5HYaF+JezCv1+bOvArw3M3uU/FvWTOVMlnHFujI2MbVJNnL0WQkWrvYVf6gUDFPA/
 blBD4I2RcM8Z3Evs9w9P9Cyuply4GZFk+uHdZOQtC98D/BERrpl5swL6iT0nQqmAe+Ebrqh0vjA
 HYREglSt4TXC+RaWUlwwtwaGIp2Xf5F5R6K10JeUkYvsKg/7yAiSmaJdRJ/GGuPR10a4VefnNPt
 wrDeQWE4dBZHt3m3HTleSw474nxvgqDTkffZkDuAbFekYMeEIGpmXIYk27GtyKeMYHt2ObFHuy/
 /hPsgoXHaZOvCbp92dbYYjM8mkxN7nvKN0olM8d45zJC4Os7NKLAWicePfPxWpewENSZVoWOF/5
 3fi6YDB7rR4q3VPBethz4bkMT1RZsg==
X-Proofpoint-ORIG-GUID: q4oDN2DJPE_mIqfbjPK8hOI2Whh56GKT
X-Authority-Analysis: v=2.4 cv=M8xA6iws c=1 sm=1 tr=0 ts=690149fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=qObbi30BQAl4vFSC2DMA:9
X-Proofpoint-GUID: q4oDN2DJPE_mIqfbjPK8hOI2Whh56GKT

Write raw BTF to files, parse it and compare to original;
this allows us to test parsing of (multi-)split BTF code.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_split.c      | 80 ++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
index 3696fb9a05ed..b07a91ff28ff 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
@@ -12,11 +12,45 @@ static void btf_dump_printf(void *ctx, const char *fmt, va_list args)
 	vfprintf(ctx, fmt, args);
 }
 
+/* Write raw BTF to file, return number of bytes written or negative errno */
+static ssize_t btf_raw_write(struct btf *btf, char *file)
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
+	return written;
+}
+
 static void __test_btf_split(bool multi)
 {
+	char multisplit_btf_file[] = "/tmp/test_btf_multisplit.XXXXXX";
+	char split_btf_file[] = "/tmp/test_btf_split.XXXXXX";
+	char base_btf_file[] = "/tmp/test_btf_base.XXXXXX";
+	ssize_t multisplit_btf_sz = 0, split_btf_sz = 0, base_btf_sz = 0;
 	struct btf_dump *d = NULL;
-	const struct btf_type *t;
-	struct btf *btf1, *btf2, *btf3 = NULL;
+	const struct btf_type *t, *ot;
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL;
+	struct btf *btf4 = NULL, *btf5 = NULL, *btf6 = NULL;
 	int str_off, i, err;
 
 	btf1 = btf__new_empty();
@@ -123,6 +157,38 @@ static void __test_btf_split(bool multi)
 "	int uf2;\n"
 "};\n\n", "c_dump");
 
+	/* write base, split BTFs to files and ensure parsing succeeds */
+	base_btf_sz = btf_raw_write(btf1, base_btf_file);
+	if (base_btf_sz < 0)
+		goto cleanup;
+	split_btf_sz = btf_raw_write(btf2, split_btf_file);
+	if (split_btf_sz < 0)
+		goto cleanup;
+	btf4 = btf__parse(base_btf_file, NULL);
+	if (!ASSERT_OK_PTR(btf4, "parse_base"))
+		goto cleanup;
+	btf5 = btf__parse_split(split_btf_file, btf4);
+	if (!ASSERT_OK_PTR(btf5, "parse_split"))
+		goto cleanup;
+	if (multi) {
+		multisplit_btf_sz = btf_raw_write(btf3, multisplit_btf_file);
+		if (multisplit_btf_sz < 0)
+			goto cleanup;
+		btf6 = btf__parse_split(multisplit_btf_file, btf5);
+		if (!ASSERT_OK_PTR(btf6, "parse_multisplit"))
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
@@ -132,6 +198,16 @@ static void __test_btf_split(bool multi)
 	btf__free(btf2);
 	if (btf2 != btf3)
 		btf__free(btf3);
+	btf__free(btf4);
+	btf__free(btf5);
+	if (btf5 != btf6)
+		btf__free(btf6);
+	if (base_btf_sz > 0)
+		unlink(base_btf_file);
+	if (split_btf_sz > 0)
+		unlink(split_btf_file);
+	if (multisplit_btf_sz > 0)
+		unlink(multisplit_btf_file);
 }
 
 void test_btf_split(void)
-- 
2.39.3


