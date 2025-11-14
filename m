Return-Path: <bpf+bounces-74586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 915D0C5F825
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B293235B802
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC18930ACF3;
	Fri, 14 Nov 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qsJPEFC5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9453002C2
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159004; cv=none; b=CZxXYz0mHE3eUXn9FQE3XbMcNdC1IQFjhZXfcU/8Wn/J91ZQlxOn9XeMZEY2JYODuIRzA2Hie9S2SK90cLSaoZt1zMcf1XOP5igx1mFBheotDOL5az7EVF42GtmkCzTx2TLJM1w1lxxrrT/q0BPCm0oqrUn5fUu0A2y2MWX3WEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159004; c=relaxed/simple;
	bh=tjVclAOu5umgF0CbPypX55FVifbsn9rbY1fVntJ/8tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoD1FSkuMTh+7qJFC31lBq7EVRG4DE2nMjvSrG2NB5A2zjuevvA3nbY/ET5eCae5C+51gJdfQoVAqs6egHkJLELwCoUAOIXFfuPzxDYgQ2Pb9Ua5VkrNIYsx/4Qt/yfJas3gXPEkiUA3nHsnkxuDLbQXI0ElmE15WgDVFSJD4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qsJPEFC5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEJuV5C011068;
	Fri, 14 Nov 2025 22:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=WNOCH
	MFWOOQ37Yrhqz3r1nwHu5N/J0mwE4WKNvKhZ/0=; b=qsJPEFC5ko+xzwfsnlzva
	jEhmNMoIjGnH6Eos76EvhJUsFDogtwDmGwK2awdH0SauRhEV27geMEVgc1k+z8ef
	vDXhZVwRbMmG6icoBcGL68PibS3GCWKPbpmfR4uOUuE0ccCUj0gK7Ugi3njRTJFv
	5zE+XftfTakj0Y2A6In/EpPAcsdgYiV6VSijreANWvN4ZRMxqvKzaVZqM8QaXTEn
	4cz44VA9bG5uGqjKT6Rzaif9d/LPKrewpzGjK7thu6McBCIE+kjKJCZjznNnH8ym
	Jw6bmSj31jak7PjX6nfFyS8ZIAIS89Q6MPNY/qAHzedHzSe3dpxaOd5HcsgUCa2j
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adrdjj1w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 22:23:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEKduFR038911;
	Fri, 14 Nov 2025 22:23:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vae2tae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 22:23:00 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AEMMrlk023375;
	Fri, 14 Nov 2025 22:23:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-34.vpn.oracle.com [10.154.60.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vae2t7q-3;
	Fri, 14 Nov 2025 22:23:00 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Allow selftests to build with older xxd
Date: Fri, 14 Nov 2025 22:22:49 +0000
Message-ID: <20251114222249.30122-3-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=L9oQguT8 c=1 sm=1 tr=0 ts=6917abc6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=d_wJ2tRVBGN3PKCV0xsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Vq2_CeKOKjsoFmcTj20h3c0lO1RBg140
X-Proofpoint-ORIG-GUID: Vq2_CeKOKjsoFmcTj20h3c0lO1RBg140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX4Q2kmS8cbTsb
 aCNQoY+VRslNiSEGgjotha1ucIQaUl4dq7EI7okLM2NnMCFaO03wCx8yEseJ9KM1Y4YCkjBydJA
 WOUFNTar+t1EVzFydylW5+gaYx/GXYrSndfnmFu53CMVnYp8HsMbjYiiKQNBFgPj6yhCRtBWBfj
 gXHWz2/bYbxbLEAB6zm3PSV1TxWwkCbzwInTopN2zC+mhiliTYrgyIYTjd3DslDOQgUTN3/OcLS
 awI93VaKBxad48aSnAwRZmdx21TiluXdgyHa15NaG/VU1eSVDbFnSCU7WOk6h/BFFAGwkZZCIbo
 /YmgfxAOMlxdnqySK2gYhlJnRU1JaMq091mGPsRyoeRz0CrUTho9PkiankCfLX6Q0hWtuuPLmof
 QZjhALvx9F3ci654ksu1R13QnxpwPw==

Currently selftests require xxd with the "-n <name>" option
which allows the user to specify a name not derived from
the input object path.  Instead of relying on this newer
feature, older xxd can be used if we link our desired name
("test_progs_verification_cert") to the input object.

Many distros ship xxd in vim-common package and do not have
the latest xxd with -n support.

Fixes: b720903e2b14d ("selftests/bpf: Enable signature verification for some lskel tests")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 34ea23c63bd5..8687c17c5084 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -731,7 +731,8 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
 
 $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
-	$(Q)xxd -i -n test_progs_verification_cert $< > $@
+	$(Q)ln -fs $< test_progs_verification_cert && \
+	xxd -i test_progs_verification_cert > $@
 
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
-- 
2.43.5


