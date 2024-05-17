Return-Path: <bpf+bounces-29939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E712D8C84C0
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4D01F243DB
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FDB374F1;
	Fri, 17 May 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nLs91guR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8D364AB
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941449; cv=none; b=lEXkfRi134rxacFVxkp/M+XKZOMJc0+vWF20FBAdN2U9VS2YMEEEL0rfmQs3cSiTmFosCiUGRQ5oMykRBRTpaQM1BR5egc/7SLdrrCAg8OCxa9ZlqNUrxS1D48nadoyswMHS8vgZjoejpPdMRqA3VvcOw1fq2PdsZKsEeMbJzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941449; c=relaxed/simple;
	bh=cBcfmcVBrgf6azkPS8GIkEODkINDbJ+MQWMXCGDO06I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJe/w30DyS1PHXGhEQEBIDlWVn/mObv1KUysA8XKsfF1Quig2/HQFcgxQh9H2VXylirD6+IyguBjWdavfc0+u3TZ6Vr2LhrezfO1Wec0dL5YKuHJtj8rKlzg1rSIbaYxKe7IY17oEoNWlNFs31B0Z9odtDnkGC4lAsgUQpvQWgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nLs91guR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H6dJiS007909;
	Fri, 17 May 2024 10:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=NLTtqzFIHAlwjSGVFNQNXoDScRZ3Sw+F0BFfEuNRB7Q=;
 b=nLs91guRJzc04FF1s6nOoVKBPl+oilYcY4VjRDKpP/d4Mc/t6X+j7mofWaFApZCeg088
 o4BijAXVKY161y5OlysAOwoD+7/Cf3Wx3vv0zj7C1wzJlLxc8RbL4dJHdXprmwtBygmx
 D57EeXjM/2NC+gxO8RqznQH7mbk1nRY8oEk6+dGGIa/V+A0zV4Domr4Yl0L5JMhUVl+x
 4qG/ug0MV/fx1auHMqckT/z2v0uDemSIRU41vdtDn8z0vqD1CHJshsYZABPjm3Wxh0Gh
 uEChGqRBojVUk0VKwROAeem7GX/D7YlRfpqyCrsFEIaQ4s0RF8ScJ190t73UB7XJso4H nA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx39a01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44H8wsAT001127;
	Fri, 17 May 2024 10:23:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fsuqsc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:43 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HAMqFq036134;
	Fri, 17 May 2024 10:23:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-196-17.vpn.oracle.com [10.175.196.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y4fsuqrr2-10;
	Fri, 17 May 2024 10:23:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 09/11] module, bpf: store BTF base pointer in struct module
Date: Fri, 17 May 2024 11:22:44 +0100
Message-Id: <20240517102246.4070184-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240517102246.4070184-1-alan.maguire@oracle.com>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170082
X-Proofpoint-GUID: gk_gf3-iOqMOyEtj24GH3o7fM7i7PVyk
X-Proofpoint-ORIG-GUID: gk_gf3-iOqMOyEtj24GH3o7fM7i7PVyk

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


