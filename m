Return-Path: <bpf+bounces-30723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E628D1B3A
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066DFB233DF
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5116E897;
	Tue, 28 May 2024 12:25:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051D16D9DA
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899152; cv=none; b=rglQtHslPRsUqIQOWVKGc+zxj7F7d2Nl5+uwxxWL10bzP0JifN1phCGrilLMUXrR5YpVqiQ2MnTsdmMwBWKqSQDquNZXlaO0xEbyI9e6cjKF/nXGpWm/JsMzGsIfMNY2PyKLMyWlCh6OHCf1JBDCS+5jT7c5KysFUzs1WBdG0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899152; c=relaxed/simple;
	bh=+wSddMgxl2sIL/XsgLFGojVqJEopYB3VHIzYvZeTsGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfcEK9yy669IHkcKN6letB6cGkGzcEXDcuN1zCHTgp+CqIDFWidUP4by5PVPqE0wESvrSccVZUNNilNZtFlEcpZYrfoe41OejFIDeDJmHvfOkaJEENJz5p/CPW1pYEzVqeRFZujUAUDnUgxtWPlaSJF0jNfgMoEIazzSWSRmxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBovZ7028895;
	Tue, 28 May 2024 12:24:53 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3DHM8R7VE+WLO87zUXlgLsaD7zsb7N/cM/udZHeFAABmc=3D;_b=3DKG/Hjket?=
 =?UTF-8?Q?toS1dontc+gBfDwnNtBXXf5yxlCl2Vmt2g466FkW+lGUVpUiV926Xg5S9nmE_g1?=
 =?UTF-8?Q?rlqsuQQcm+W0z2StavSUVTXHJ1uXfCgbzUfAm9t4SR+EtF0voEopRijPjZZ80GP?=
 =?UTF-8?Q?qMj_Glv79BvmYStAUeOGuFlH/jYhIQCR1vef5diC7nhIjuZOsnbThPg025XnxCu?=
 =?UTF-8?Q?wyzt+Oo72_suLT7gcy9vay0nsqGs80IjWoNNWq1p2f5u/EQ7ytFL8tp1Y4Quexr?=
 =?UTF-8?Q?2NlJNPh4WmYTbkC_YX6+R4CuinADW4FjjiVFtupWS//jYdp8OTl0TlEpJJquqq8?=
 =?UTF-8?Q?SMNxk5gsihgwIoj1wPYFR_xg=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg46ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:24:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBotH0037258;
	Tue, 28 May 2024 12:24:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc535a081-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:24:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SCNlJZ022297;
	Tue, 28 May 2024 12:24:51 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-164-70.vpn.oracle.com [10.175.164.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc5359yey-8;
	Tue, 28 May 2024 12:24:50 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 7/9] module, bpf: store BTF base pointer in struct module
Date: Tue, 28 May 2024 13:24:06 +0100
Message-Id: <20240528122408.3154936-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240528122408.3154936-1-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_08,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280093
X-Proofpoint-GUID: XHhE3Kotyfix3UsoCqlRiKd8syIN8Yh4
X-Proofpoint-ORIG-GUID: XHhE3Kotyfix3UsoCqlRiKd8syIN8Yh4

...as this will allow split BTF modules with a base BTF
representation (rather than the full vmlinux BTF at time of
BTF encoding) to resolve their references to kernel types in a
way that is more resilient to small changes in kernel types.

This will allow modules that are not built every time the kernel
is to provide more resilient BTF, rather than have it invalidated
every time BTF ids for core kernel types change.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/module.h | 2 ++
 kernel/module/main.c   | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ffa1c603163c..ccc5cc5e0850 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -510,6 +510,8 @@ struct module {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	unsigned int btf_data_size;
 	void *btf_data;
+	unsigned int btf_base_data_size;
+	void *btf_base_data;
 #endif
 #ifdef CONFIG_JUMP_LABEL
 	struct jump_entry *jump_entries;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 91e185607d4b..bd2870d9b175 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2154,6 +2154,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 #endif
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	mod->btf_data = any_section_objs(info, ".BTF", 1, &mod->btf_data_size);
+	mod->btf_base_data = any_section_objs(info, ".BTF.base", 1,
+					      &mod->btf_base_data_size);
 #endif
 #ifdef CONFIG_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
@@ -2578,8 +2580,9 @@ static noinline int do_init_module(struct module *mod)
 	}
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
-	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointer */
+	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointers */
 	mod->btf_data = NULL;
+	mod->btf_base_data = NULL;
 #endif
 	/*
 	 * We want to free module_init, but be aware that kallsyms may be
-- 
2.31.1


