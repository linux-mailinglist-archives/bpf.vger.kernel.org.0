Return-Path: <bpf+bounces-73498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1B2C32E9C
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 21:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F275242791D
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 20:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B82EB5CD;
	Tue,  4 Nov 2025 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rcSLb8HL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFD1DD9AC
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288443; cv=none; b=hp0kPgNwazGYlm1dxPD16J1fIpDEt7t6Kqr3sgtQZOlcY4QoN2bSEBC5Qvz0cxrT7wBcv/L4dgJaAy/y3472CCgiYSev6+TKL7CE2bSLLrUPJKffnZtmR/ERSbl0aUM8YnnHQKYiGyaeMB77yWJBPTiXuU+52qv6eoe9AnNro1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288443; c=relaxed/simple;
	bh=W1qfJOwb6l5jCimUbJY36mpQKTLRlWHv2UHBPXR74xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LC5IdZFx5FQcpGK4JjLCFhllK1vkej+mV1lXk2h9cXmwmK/fa23ggxQLeELM/0Gswb+davDrmsLEGdi4FvMbVCYIxXdoL8uwN/5HGk4lZAvGmLScFFYSASE0I2mYXwy1PySkLMKm1CeFYT+7ZyGctlMdiuZj2ABJGUgmBAUO1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rcSLb8HL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KNHtT005508;
	Tue, 4 Nov 2025 20:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=5O4Lk
	WUG8oZkhWadqM9nkhXjxKjERsvDZiyfJEycm+Y=; b=rcSLb8HLQ4F9OOusWsO5N
	V2x6muDLQXaPLBSiqlr6JGaNR617srnK2G6R6uCLixTnQgY5871DoMdPsIqBqLQE
	MtTHKqjD+l+XahWelTsAruDjg6+CWtfu2YXD1ylXbvxTB0MY5qHZl2VTWet3y+q2
	b5t7olABZE2lkiiHnDpUghrWZg7+g4FridL+5DBD54NlvItjL8jRVq3fiJYd5JJ9
	FE6KfWLAkcAgaM2DLOHYjdMuRGcQf84CYluuwMOoNNu97i3PbEt/gDfYRxe2JZmF
	YhWjPtXPljDtDUQ/0xhJIJ2HNI6i7RM2E8qHDtvejs4aZ8gKMj6gkBLwYq6EALbK
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7r4m04vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:33:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KBCiS019553;
	Tue, 4 Nov 2025 20:33:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nkw97k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:33:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A4KXWvg039670;
	Tue, 4 Nov 2025 20:33:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-143.vpn.oracle.com [10.154.59.143])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nkw8un-3;
	Tue, 04 Nov 2025 20:33:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, ihor.solodrai@linux.dev,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 2/2] selftests/bpf: Test parsing of (multi-)split BTF
Date: Tue,  4 Nov 2025 20:33:09 +0000
Message-ID: <20251104203309.318429-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251104203309.318429-1-alan.maguire@oracle.com>
References: <20251104203309.318429-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040173
X-Proofpoint-GUID: _ZfQcLIq8On2VbHfg61xlPgT1ycBbWek
X-Authority-Analysis: v=2.4 cv=PaHyRyhd c=1 sm=1 tr=0 ts=690a6323 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=qObbi30BQAl4vFSC2DMA:9 cc=ntf awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE2OCBTYWx0ZWRfX33OHaGtX51Ep
 Wx2f7wvjwZhYK6W41Q+k3w1DMaufH3NgzGPRMJfgwfjiXYvDziEYi+FnDp+qMHxMMzlrKADVCuz
 AE0hmeV1ok4jRmfy9L1ct8oC6wxlZ1s7uIxCsDdvFe9zXe8K4dq9Yj2t+dqAUE1ac650upOmwk5
 sPDHGID4lPEB2la2VyGds8pUgSInEcY8lB/LXU0yFoPrVpYkyzkMXUQfVJaqO2xt71H4jCdo7zF
 ntRfjS+WXewtp8RjxGT1a1UNA9C9ppmY/Y212KcicJcP9QESvT7pHMoYjPFDd9V65NHPzk3oQ4d
 Sbxd1eLreajfjUIueJLG5BEzYrazQ4Coew8C/jN6ANsCWPctG3A9Z6d3rYtv4HZb1NtGn2Q8avW
 GhmS9e9ApcITVsPwy9mdajMymYZgsk/S5Fp7CBefcMbDwh7BSJg=
X-Proofpoint-ORIG-GUID: _ZfQcLIq8On2VbHfg61xlPgT1ycBbWek

Write raw BTF to files, parse it and compare to original;
this allows us to test parsing of (multi-)split BTF code.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_split.c      | 87 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
index 3696fb9a05ed..2d47cad50a51 100644
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
@@ -123,6 +157,45 @@ static void __test_btf_split(bool multi)
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
+	if (!ASSERT_EQ(btf__type_cnt(btf3), btf__type_cnt(btf6), "cmp_type_cnt"))
+		goto cleanup;
+
+	/* compare parsed to original BTF */
+	for (i = 1; i < btf__type_cnt(btf6); i++) {
+		t = btf__type_by_id(btf6, i);
+		if (!ASSERT_OK_PTR(t, "type_in_parsed_btf"))
+			goto cleanup;
+		ot = btf__type_by_id(btf3, i);
+		if (!ASSERT_OK_PTR(ot, "type_in_orig_btf"))
+			goto cleanup;
+		if (!ASSERT_EQ(memcmp(t, ot, sizeof(*ot)), 0, "cmp_parsed_orig_btf"))
+			goto cleanup;
+	}
+
 cleanup:
 	if (dump_buf_file)
 		fclose(dump_buf_file);
@@ -132,6 +205,16 @@ static void __test_btf_split(bool multi)
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


