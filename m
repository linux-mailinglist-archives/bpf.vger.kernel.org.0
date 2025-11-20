Return-Path: <bpf+bounces-75146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9738C72F37
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 09:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 82A0E2A2E4
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA421279DCA;
	Thu, 20 Nov 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2wM9im3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5272116E0
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628564; cv=none; b=fNpdLF9ssMIXgCg19oM1H/6+wf/zPTC+u5MUPyUllfsKZx44YUOT3/eYkZS+AK6dfLTizoyzOKP8nE8UU5+uVmZziNxkxlz2IfxEPZgmX7pMe8St0yN3zJx5WP8R02jg+JhKNcWy5EgOX8Ru3iQdBEfR9jNeuojfou07N2q4OBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628564; c=relaxed/simple;
	bh=N5GwQqxAShEuvAMIoSvs16H/P8lmkO9g18m785oNEH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGAjHkMChSINty71kAwtWHXGD7Lku/JojHAoAZrng8hG0mUtvKsd5BcP8IKfK2g31J4TN2MkBbDR6WEE9ruhdTOwtUFvCD+Y8efdQQaRSx0xht/vfn8xn1yrp3gVKN+dEd0BJYbg0bs68KrV5k4AV4t2MUKPMYcWbtvFVoYn5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2wM9im3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK6RH1p027049;
	Thu, 20 Nov 2025 08:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=2Dg88
	uwe2LMmz3u4w6vFlh1F3sCf6A0mBpPEmCh4vO0=; b=W2wM9im3IUmA00Lfafx1/
	PKO7F0mFobEP4A7agVUhkmtC6Q7pULgzp2AnUMIdfBq7754bJ8a7ZhpEZeD+ziKg
	GN+8PDHbfmsRcNRTgFiZsVB5bnTZwfA/Zhhzi8IKF0fVTWdbw11EO9n2KQELjQbU
	zPNSOeCNSDjQJnmDoMZijW9QVD10i/licbp1oWFkqDZyTU1jtrgUtof13tPnvXZO
	dDUblxJkXjxx8IBRKEF8f7HYv/L3fiTnm0GKTDZtuLLI/UdiRsWRuZ0G0tI6vNrD
	1tMYwjoAPkYj3wtvjenLgQdIM4iU/lQ782wWo3qaPl+hSIC/xL8IHHPpYDyIC3JW
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbc0hgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:48:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK6L1ns002520;
	Thu, 20 Nov 2025 08:48:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybrp8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:48:02 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AK8lwDT007208;
	Thu, 20 Nov 2025 08:48:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-185.vpn.oracle.com [10.154.58.185])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4aefybrp6k-2;
	Thu, 20 Nov 2025 08:48:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, sdf@fomichev.me, yonghong.song@linux.dev,
        song@kernel.org, haoluo@google.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, john.fastabend@gmail.com, eddyz87@gmail.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 1/2] bpftool: Allow bpftool to build with openssl < 3
Date: Thu, 20 Nov 2025 08:47:53 +0000
Message-ID: <20251120084754.640405-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251120084754.640405-1-alan.maguire@oracle.com>
References: <20251120084754.640405-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200051
X-Proofpoint-GUID: q-w-8hlufr0RxlwcunPszmC0ZtxC3WGh
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691ed5c3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ntg_Zx-WAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=19R0FJo-S2h8HcoD7-YA:9 a=RUfouJl5KNV7104ufCm4:22
X-Proofpoint-ORIG-GUID: q-w-8hlufr0RxlwcunPszmC0ZtxC3WGh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX2Gu3MdiptbIl
 AL6edmyInFF7djRfu7dpcMbNknbVi4P0alZ/Q/AsMrdhIUjgLYSQXtvZkw5jcLelYYS7IyNlSRB
 EI7fJGjo1pM3C2F1mFGHCH/+N0vtwzWNateBZQ6/I5GbU2j1ssLtb1OYPM+EpwVuuElUPtr+Bom
 CxTFHNdMcvOzamtdMc/6F/gfvQ37ebqY7f07xJkl0LIUzJKEJ/YqkC2ThSsnvGisrpcz92qC8nO
 9VnYcbryLbq0PALBmh5RHXS/7aOQVgGrsob0BZGN8bkMMGumMLAci2iGacRdwWxWrZzCjJ8TLoP
 iGY13HVNZtv7Ah69nE6sEGabkzV7Us0jFqQZ/lmCF4x6QqBsc0k5qqebUXKZPwqHUr3r55HqghW
 ZFKR2nCugx2Qo6nL+fz6yQkT56qzsQ==

ERR_get_error_all()[1] is a openssl v3 API, so to make code
compatible with openssl v1 utilize ERR_get_err_line_data
instead.  Since openssl is already a build requirement for
the kernel (minimum requirement openssl 1.0.0), this will
allow bpftool to compile where opensslv3 is not available.
Signing-related BPF selftests pass with openssl v1.

[1] https://docs.openssl.org/3.4/man3/ERR_get_error/

Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
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


