Return-Path: <bpf+bounces-47114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE99F48FF
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 11:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B825C1891257
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 10:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F61E3DDB;
	Tue, 17 Dec 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CZzJOeso"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F31E0B7D;
	Tue, 17 Dec 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431815; cv=none; b=hMHCMhy1F2vWH69zFCU36uZN6xWyZl1ODYY9bdCuOwXVg6qXEeNbBlWcPRr0IanJR9e8AdE22vqlcLeoe1P0hFG68ZOZ9RokWI0ZJXLfzd56+J15irOh6F5NhPl4UucE7C0VxPsa/pUsMesSvCQYHfkQy95dCsuKVL3cuKQopAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431815; c=relaxed/simple;
	bh=UmwmvHSWreHO3WY2crs9WXceMssQhSzvUjWuR921BpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HX8etQ5TswlkyFbpu1qaSmzQlhSnO3rWj8/FaR4SIWSsx9u/h1dy/tD7bXL857LMwSuFlCc54Xpad0azsgm3YOaRQuxWM5SaxyQBiV/oZRqfjsnMpcomgQIA6lgCac6n5zhylvxMtc2YlzSiW8+3+k68fDDaFLmuaHg13+WLItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CZzJOeso; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1udiF002233;
	Tue, 17 Dec 2024 10:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=cxYglM6mPkNwN2PxnA9JayFG/EENT
	xEzJRw7pX+ZIJo=; b=CZzJOeso6sPWtOFHXxs0wOjAPE6OYv+8IgvroV0dYIcct
	BBgSrzjXdMQyiyK9JefCiACEW3/ZYtDfXDnqFQC1aVeeVKL2XS1hjiTjr2DmED3Z
	jeFDQbCEgQNWA5muYUNfvSKmmAB6v2KI+1WYo+S/3AHGas6OP+Z0usRIr9UvyZS/
	yYsiFQEWLtnuwIOkpGmVzXK0pKefLsxQFNnIU5YcJ2WPWO4FLaZkPkWTP6r09Mmg
	EcZv46kxFc8jk6UE2qIXbpG3+efBFcdN3IQT4upzRv5RXUFuuhCP4WpH5mU8VTmU
	GWV6HIcbl9/vm80Y1sKyOiOAaRA29cD5avt5vqzdg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9drbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 10:36:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH9g11W006393;
	Tue, 17 Dec 2024 10:36:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f97hnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 10:36:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BHAaXGI025877;
	Tue, 17 Dec 2024 10:36:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-175-207.vpn.oracle.com [10.175.175.207])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43h0f97hm6-1;
	Tue, 17 Dec 2024 10:36:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        stephen.s.brennan@oracle.com, laura.nao@collabora.com,
        ubizjak@gmail.com, Alan Maguire <alan.maguire@oracle.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH dwarves] btf_encoder: verify 0 address DWARF variables are really in ELF section
Date: Tue, 17 Dec 2024 10:36:29 +0000
Message-ID: <20241217103629.2383809-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_06,2024-12-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412170087
X-Proofpoint-GUID: JXuFirqh3-C1EGlOH2O6iov6up5goOlU
X-Proofpoint-ORIG-GUID: JXuFirqh3-C1EGlOH2O6iov6up5goOlU

We use the DWARF location information to match a variable with its
associated ELF section.  In the case of per-CPU variables their
ELF section address range starts at 0, so any 0 address variables will
appear to belong in that ELF section.  However, for "discard" sections
DWARF encodes the associated variables with address location 0 so
we need to double-check that address 0 variables really are in the
associated section by checking the ELF symbol table.

This resolves an issue exposed by CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
kernel builds where __pcpu_* dummary variables in a .discard section
get misclassified as belonging in the per-CPU variable section since
they specify location address 0.

Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 3754884..04f547c 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2189,6 +2189,26 @@ static bool filter_variable_name(const char *name)
 	return false;
 }
 
+bool variable_in_sec(struct btf_encoder *encoder, const char *name, size_t shndx)
+{
+	uint32_t sym_sec_idx;
+	uint32_t core_id;
+	GElf_Sym sym;
+
+	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
+		const char *sym_name;
+
+		if (sym_sec_idx != shndx || elf_sym__type(&sym) != STT_OBJECT)
+			continue;
+		sym_name = elf_sym__name(&sym, encoder->symtab);
+		if (!sym_name)
+			continue;
+		if (strcmp(name, sym_name) == 0)
+			return true;
+	}
+	return false;
+}
+
 static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 {
 	struct cu *cu = encoder->cu;
@@ -2258,6 +2278,13 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		if (filter_variable_name(name))
 			continue;
 
+		/* A 0 address may be in a "discard" section; DWARF provides
+		 * location information with address 0 for such variables.
+		 * Ensure the variable really is in this section by checking
+		 * the ELF symtab.
+		 */
+		if (addr == 0 && !variable_in_sec(encoder, name, shndx))
+			continue;
 		/* Check for invalid BTF names */
 		if (!btf_name_valid(name)) {
 			dump_invalid_symbol("Found invalid variable name when encoding btf",
-- 
2.31.1


