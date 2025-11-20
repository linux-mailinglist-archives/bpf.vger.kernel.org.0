Return-Path: <bpf+bounces-75145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 917ACC72F2E
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 09:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 943CC2A9F7
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9FC2D6E51;
	Thu, 20 Nov 2025 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jAq2MUiW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1B30E0EC
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628519; cv=none; b=TY8sHzkfJonbsieExEg7o/af7xjuIKRoapPs1eA5eq5gfEsXC816ZTf4xDIttXyjO/xDuCV09n+llkMKIVi0MDtf/MOz11idVk0Wnh4UGxkOVSZ31Ul7dTrvgro1pc+wxLp7nkX8Rknj1WMvNZ8fU6QcyJZdjg2xzMcGxciepPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628519; c=relaxed/simple;
	bh=oIYNxsK94JaO4vdSXnGVterse1TXgNndIoltJZAqvik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCF90eT4U9BKJeCCJ5PxauuR4yhat7uAudmPd7Bbg/6B6MDSD1tuNluREqcD9jReOzSVAAOXsy0GvKsJl8a67HsXFkOmzXDX2nNkYYoiV5NbVl8Zgl7IzeOPmSHThVkJ+7y9BRxA2t9jxsmQnWpVMVONNMgMOCZ73PjsFlcSV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jAq2MUiW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK3MlR0014385;
	Thu, 20 Nov 2025 08:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=PkIxI
	6pu3U2VDPKkcK98jFjXew8MYkCYuKDhyA76cDo=; b=jAq2MUiW4Kn2Dvco/S7Dv
	ZmsVZaWsSViGv0hUwoTKdzMqbg2QcMeWGFjlBwXQHoXIrb68RnmqAT763PpOrW0i
	dbwdnEAmxFQn3yynXDNEuP6YMiLNQGAL924JhF3cGESfYBv0+TQj0TPbsQ3FFvxR
	DjIS2escV1CV1odAXIbfF4VG1cuiwkUsf+Q5tR+F69AxnIp5XiSY+otINC1+bnq+
	MCps2ZD+aM8xav7OQrMzjsn45ijMzpWdwKUoJiZY0Z1OXv4KJC5bmoJ21XpPbwXI
	UeqpliO4gDop07xMdlW51jZxJyGr+Y+42dGTpBXyjLKxDG2K5dXSaj+yQQd+kOiJ
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j8pbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:48:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK6CNxe002613;
	Thu, 20 Nov 2025 08:48:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybrpag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:48:05 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AK8lwDV007208;
	Thu, 20 Nov 2025 08:48:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-185.vpn.oracle.com [10.154.58.185])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4aefybrp6k-3;
	Thu, 20 Nov 2025 08:48:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, sdf@fomichev.me, yonghong.song@linux.dev,
        song@kernel.org, haoluo@google.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, john.fastabend@gmail.com, eddyz87@gmail.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 2/2] selftests/bpf: Allow selftests to build with older xxd
Date: Thu, 20 Nov 2025 08:47:54 +0000
Message-ID: <20251120084754.640405-3-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: TyDBCOneHuf7Ki29OI8Y6YlQ44xbtgC5
X-Proofpoint-GUID: TyDBCOneHuf7Ki29OI8Y6YlQ44xbtgC5
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691ed5c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=sjjG6lzJni1mwoMb6D4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXzoTbNltNsnik
 /zQKAGJBRpGo28vE+De+Ook235vH8T+SiYDyAWvd8PH6Epp4ZMsAMN/jFP+nup8f04XAZ/NnaRQ
 xomse2B17gpJbUMLzmxksOX2qJPcMBpbfQlSWPekSXKLTYDobOIGSUXHVh3xlme1dYaOxc3F2Q6
 0AARn0bOC4O/dbJ6zD9+/K94MgW0FdjjXy+4D06KM69AbOZy9l9MI+ANSFt2hQ33fTAecIj0uiS
 calyaL4L16Fu2BFIvNh06DcQrvUUp8PyuACoxHczMfqmiWf939S0m/eESMOkQehKw2JVWbPk17s
 BsyDI2ZchUKXcSoDqGBzEnfMleAVdQtMHa5BIsdWMiqGMKBCTk1CVdfSzKVgV4Xxgj/2T2ztTFo
 QXYIdLPmc8/6cnRlyq7/hmCHnNH0sQ==

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
 tools/testing/selftests/bpf/.gitignore | 1 +
 tools/testing/selftests/bpf/Makefile   | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index be1ee7ba7ce0..ca557e5668fd 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -23,6 +23,7 @@ test_tcpnotify_user
 test_libbpf
 xdping
 test_cpp
+test_progs_verification_cert
 *.d
 *.subskel.h
 *.skel.h
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 34ea23c63bd5..bac22265e7ff 100644
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
@@ -905,7 +906,8 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	$(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h	\
 			       no_alu32 cpuv4 bpf_gcc			\
 			       liburandom_read.so)			\
-	$(OUTPUT)/FEATURE-DUMP.selftests
+	$(OUTPUT)/FEATURE-DUMP.selftests				\
+	test_progs_verification_cert
 
 .PHONY: docs docs-clean
 
-- 
2.43.5


