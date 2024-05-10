Return-Path: <bpf+bounces-29454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0628C222A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E760B22D28
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6108004A;
	Fri, 10 May 2024 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KEmpschX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B747F7DB
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337150; cv=none; b=f3l+xlRdo8VRCO/YFGJCSwaUlVpi21XSJM1OB4I2tmiHs1ncjYXjSxO9W/xMIgr8WWsL3aLMBmSO6kJUWgzVUmYtNMtDAy2K5pIoQu2+TKU96rJY0bGWXw660Tre5x5sW1CHwKgGLh+P5RVg11BUx0YDJQfYgpJEsw4P6pZZcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337150; c=relaxed/simple;
	bh=cBcfmcVBrgf6azkPS8GIkEODkINDbJ+MQWMXCGDO06I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTuLyNuYz3TQba+dNsFwJ96K9CZbTsBFHKBzxW/uyqYdA9vKfp9i5fvvpj3eJD2eQ1omBHtC1AAnXVYlLsrItjRnFWdFbRX/eWTxeuSKo8hEbzpRyxSnrbJOGVHSIphd5jPKD+XDcD1v4VfyeEA5IF371TzpQKh6WuYE5/i8f5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KEmpschX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AASw9m015485;
	Fri, 10 May 2024 10:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=NLTtqzFIHAlwjSGVFNQNXoDScRZ3Sw+F0BFfEuNRB7Q=;
 b=KEmpschXAVTjv3bXXv+cC007wNqU7T3AFY0K5vowjlG4BOEzSOU6miXdxxiSLOGctxre
 LQZLsSE+aJJLVAY3x5bpOAicnfqF7nxcd5hCvW2nt10oofhlUOQ9h8IXg9aZRZYBRDiV
 1CjWsiEHTvcTB1+QoyRXz7ypVGP9sMyLfLyt5eoh0gWCPHSt7d4qhtfRUy7Bb4J/pVoe
 YVZIyqt+U4div4yumponQVFaABhkflwTMOUJ85u29mz2u+JHel2CICuIiM0Yi8ZcuqKf
 9be6PiBxiXWcmLfa3cadG9e/riNoWbcLRLz8QQEHR+jHm/2zFsg0nRGLheCsOjgNsqJ4 dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1a0j8pf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:31:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AA00xO019748;
	Fri, 10 May 2024 10:31:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpcn8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:31:52 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44AAV0hj011786;
	Fri, 10 May 2024 10:31:51 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-199.vpn.oracle.com [10.175.161.199])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpcm4p-10;
	Fri, 10 May 2024 10:31:51 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 09/11] module, bpf: store BTF base pointer in struct module
Date: Fri, 10 May 2024 11:30:50 +0100
Message-Id: <20240510103052.850012-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240510103052.850012-1-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100074
X-Proofpoint-ORIG-GUID: q31h4cfS-aMvnfzix_m4bxfnMlWIDvgu
X-Proofpoint-GUID: q31h4cfS-aMvnfzix_m4bxfnMlWIDvgu

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
index 1153b0d99a80..f127a79a95d9 100644
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
index e1e8a7a9d6c1..e18683abec07 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2148,6 +2148,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 #endif
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	mod->btf_data = any_section_objs(info, ".BTF", 1, &mod->btf_data_size);
+	mod->btf_base_data = any_section_objs(info, ".BTF.base", 1,
+					      &mod->btf_base_data_size);
 #endif
 #ifdef CONFIG_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
@@ -2587,8 +2589,9 @@ static noinline int do_init_module(struct module *mod)
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


