Return-Path: <bpf+bounces-74588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 33318C5F834
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 627A535B870
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3230F923;
	Fri, 14 Nov 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wu4DQZR4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED73090DC
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159062; cv=none; b=GTCzLI5D1y4wfSpL+rbl3EIFKXCooDOtfjRXw4ujnmGFKFdd5Al9lVG02hlnhUUHzOswvUtXoZG6mG7Wnppmo3yMChk8ScmdZU4Si9zeYdQkRUoK16xW2sjHJj+LM54K9bZKadI7ZGrGHhYZ+hzGErwcjajzpXT/WDVSFSNAJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159062; c=relaxed/simple;
	bh=/Q85Y6hfpw16CtqT2ycSNjQnxL0bn2YO1c8UdKHzgmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFvADxRJgn45qzr5QIJXGxuecSClq4K3LZ3sory13+NjiTNt+GrvNWGo0/rGlcL1DQSQ8FskeIh1clJvXKkxhWD3FbUSYIrhAVMbmsBXRu4MUXxGEVXytnd8aRjpxrBURbcUgKvg82mxrkSD7EbapUwR4UkIvlLpKNBxfErP8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wu4DQZR4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEJuFD2015438;
	Fri, 14 Nov 2025 22:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ArF76
	ab83eMbWVxzRvNeuUpmnDVzOzT3nuHsfSwmtU8=; b=Wu4DQZR4D1DTGCqsCJgjQ
	nEnIsfATguEO84e5ZbFAJ/CZI0DYv9MG26YGqQ42sgdY8MYN1eBXHUy88FlNQmOs
	9iFMa2vzXG0d85iAdO5IPQ4YSFVSpBr/qRVzBD7cELKktmKI0bgp0+h0+x9PzcQ/
	YJPq4k2E6mzWIZj+vlzQbL40MFA1NgDZ5+X+P0f9HDwKT6nce8VPr2tYFjt4s/kI
	t0e5JEmicTEupDCexChzx9E1sxHZcFXE2gZahoCNohG+8rq6tba7083fL/DNBHoZ
	hF/t0FT9kbxi9UprTga2xVSPGpSgR+rPpw/gZEbBWhPDsKsQ+s512ZbpnjkoWDcG
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8ra1qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 22:22:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEKduFQ038911;
	Fri, 14 Nov 2025 22:22:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vae2t9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 22:22:57 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AEMMrli023375;
	Fri, 14 Nov 2025 22:22:56 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-34.vpn.oracle.com [10.154.60.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vae2t7q-2;
	Fri, 14 Nov 2025 22:22:56 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 1/2] bpftool: Allow bpftool to build with openssl < 3
Date: Fri, 14 Nov 2025 22:22:48 +0000
Message-ID: <20251114222249.30122-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251114222249.30122-1-alan.maguire@oracle.com>
References: <20251114222249.30122-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX18oK6jk3x9Ev
 cbN1sDLQ8TGtPXHE+tZ0+jwesMlQU3GZUhSdcMTfUblqT3qVWdLeeK8wPr0t9EaaiQZLp0Admfs
 yVGJNrlwfQWAlFD5c5A50D8vhv6DKFhL3PTgC+3BTuk5lPUJONy/DA/1BEhH3/tpoE8R6MahiFX
 zgom4XFwxsQuHB3CLN/+dfF1xkSDE49OCBbvtY2IqJIc/3B/8eKLUCpAY6Qn54jE559LERtiqra
 /jQwqbdqeTx1AQTeyGBmNoQERR22CmUCxsia+tzdTn5yliy4uY3KFCyNmSbZrz3wEYijrMB0uwk
 LS80/PDWbXr9UJAW9mm5xsctRBYTwLjNtCmfNy9SemIILufFEzZqFM7qsXM3MaF98siO6Zk8tOq
 xqqDKYU9oxulBaBXKyHinQbooraldg==
X-Authority-Analysis: v=2.4 cv=FqEIPmrq c=1 sm=1 tr=0 ts=6917abc2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ntg_Zx-WAAAA:8 a=yPCof4ZbAAAA:8
 a=19R0FJo-S2h8HcoD7-YA:9 a=RUfouJl5KNV7104ufCm4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: pVVzT6c0Dij5EzFcEOE7d8GlYrrHw_Kh
X-Proofpoint-GUID: pVVzT6c0Dij5EzFcEOE7d8GlYrrHw_Kh

ERR_get_error_all()[1] is a openssl v3 API, so to make code
compatible with openssl v1 utilize ERR_get_err_line_data
instead.  Since openssl is already a build requirement for
the kernel (minimum requirement openssl 1.0.0), this will
allow bpftool to compile where opensslv3 is not available.
Signing-related BPF selftests pass with openssl v1.

[1] https://docs.openssl.org/3.4/man3/ERR_get_error/

Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/sign.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index b34f74d210e9..f9b742f4bb10 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -28,6 +28,12 @@
 
 #define OPEN_SSL_ERR_BUF_LEN 256
 
+/* Use deprecated in 3.0 ERR_get_error_line_data for openssl < 3 */
+#if !defined(OPENSSL_VERSION_MAJOR) || (OPENSSL_VERSION_MAJOR < 3)
+#define ERR_get_error_all(file, line, func, data, flags) \
+	ERR_get_error_line_data(file, line, data, flags)
+#endif
+
 static void display_openssl_errors(int l)
 {
 	char buf[OPEN_SSL_ERR_BUF_LEN];
-- 
2.43.5


