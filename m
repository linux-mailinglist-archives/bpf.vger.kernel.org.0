Return-Path: <bpf+bounces-76597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BFECBD239
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66996300A8EF
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1562327BF9;
	Mon, 15 Dec 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dkQ/w0dc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9B21ADB7;
	Mon, 15 Dec 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790369; cv=none; b=uffxjza3S3HQ29jkCGCJ7XgRFCckU7nADLttr7taJl5GW+8H3xdeefvkBY+xTEcd8w/YrrY5zO20cgaJcbXEmirCuzL5KgNvxyRTczvM0yXqcQKNaFPsuG6bhthsUag9iDEn4j26R/gE7Pfl0kJc4tTTh3uDXhC/fPq+PYL98ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790369; c=relaxed/simple;
	bh=R46RowHVNcRX/fyaYFi3afp9MZxZtIKXHgOmyKUx4fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m64FfmPUHdNpabeW80ZQ0QIg6J5GBINYK1AlFmPmvnhua2eUvyTHYCilpIzWccsYfi7yCXTYNan/vMbVs772k8eznUnUJYVbcB5zG3/ygB81VfXO0P6UP0BvI6YWd7phBpbi4tMmdr+T0rkmZIOu9bOvH7xxIJSXAF9ziMjZ0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dkQ/w0dc; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF7uV8R1723582;
	Mon, 15 Dec 2025 09:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=opLkx
	oScR957WnYuTM9BmX0z2BvtKaU1ziDHQ/2ONS4=; b=dkQ/w0dcYxcElqK7EyeAp
	rR3gkKCgTDC9lpAvlnqZNKLDCcTH2fZ9FqwS5MI0G5G73++6Sm5zAupr9w75+FtW
	nwchXbTMzoQTViEgYbP6wQuMRhdTq70TbZNW695gNY6jSdIEEkmZSEu937mGFuXM
	cVfUWOy1ez+IfUAT2cvkNopVQUajWPMHOufMKjKcKX+r+OL/Uf3rAwIcGqwQTGsU
	60GQkKRZeqa1wJlrCqIxNTNRWsOqYk5isz328QEp+7i/6vdtZ/xqrdBu/kq+M19u
	yn45H60Z0EbjwFgXfPEDz+DuU3+NigZTYHjGy1/mJC89qXb1b4wXN9eUrlP2EaOv
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yruhncn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF82jkc025193;
	Mon, 15 Dec 2025 09:18:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8yh23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BF9Hdwk027566;
	Mon, 15 Dec 2025 09:18:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-2.vpn.oracle.com [10.154.53.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk8yg99-11;
	Mon, 15 Dec 2025 09:18:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        mykyta.yatsenko5@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v8 bpf-next 10/10] kbuild, bpf: Specify "kind_layout" optional feature
Date: Mon, 15 Dec 2025 09:17:30 +0000
Message-ID: <20251215091730.1188790-11-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251215091730.1188790-1-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA3OCBTYWx0ZWRfX4d4XNGTlez70
 Y1IZrJCvXA+GjsAFnBf9XzLL8PZNRup9gvhr/tqnr/vlsEGk3FRO0eRdoq0UHbL7MzmfW+4KMfL
 ecIaEqChmFNYtqfBozAan+8Wemaim5lr4chh4RMse21HiWA9pZBrumstuxH7sJPYSTxZTI/qypC
 nJ5OeMvtxDu9RJvvd36/6X405W20VvRzKn44KXfblW3qn8p24MMZC5EmQWdE+DIGUXn4/4BpIUX
 nIVMswz04K7wMNp9OAKZu+pa47mNwq9B90lpffSpK4/5jMEe1CernWbXt7lV8nKBPdKzENyqAFU
 hIxCJp8+soYUyEo4uT13my48avjtRtGhnC2ezu5NxolPzm3KB3/OzK7TvaBeU/OTGbcA4OcbFPW
 YhFl4szF5/6heyAuArCzP7GJVga0Cg==
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=693fd277 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=J4qZCyyk7QvxA2XVlwcA:9
X-Proofpoint-GUID: cgL2iCY8-KF84APPj1opM8dLzFkb2grD
X-Proofpoint-ORIG-GUID: cgL2iCY8-KF84APPj1opM8dLzFkb2grD

The "kind_layout" feature will add metadata about BTF kinds to the
generated BTF; its absence in pahole will not trigger an error so it
is safe to add unconditionally as it will simply be ignored if pahole
does not support it.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index db76335dd917..c20f9bbcabeb 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -25,6 +25,8 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=enc
 
 pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
 
+pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=kind_layout
+
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
 endif
-- 
2.39.3


