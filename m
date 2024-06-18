Return-Path: <bpf+bounces-32417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FB090D92A
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 18:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EC91F22555
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D955E48;
	Tue, 18 Jun 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KbpMpP0P"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48EA4F5EA
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727937; cv=none; b=Op5d7+2+SqJb/aOOLxJokfwzrhi+c4mF9MDPviW57rGAKdyG2hq6rvaX1gdRWWIVf79KsxH6TyQyPAdYrgiot9AWjrfMMJExp/WGXnSo1LSZoNzT9ysK84MFux8je+EgdaWEGF4Lbzj/F7qvxXDjE59KwWDez3y4BqYHEbS6r6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727937; c=relaxed/simple;
	bh=+QCAOu/5aQgGc3QbYyFl/PI5rr/3/dgQ16nKw57EcdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElX5HAmdh6RxjqDOvZ9e06nujYxW3SizNkzSpem4f9NKNsfM4C6p7pl0McoPi6/8oPf/owN1KyhW/hw9nYSO8HWslGnoLo8uVJ3T7fHx42grkM52XYanMo3i7/o3z39BJIrpOpGYp2ykCmOnMOZeP22+TKp4Q2S6M6F+Cr5SyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KbpMpP0P; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IFkdVB001177;
	Tue, 18 Jun 2024 16:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Y
	tEp1T4Acg9iUszU4TZFRcBYBbc/fsODX7QAVfZP2wA=; b=KbpMpP0PSPA4Qb7KM
	1LepYb5j6zC54m5UDWOLtrtJpyGhhpsYPyjxlXdl/3JllYPGzjhKIhvzas8p4i8T
	8QpuDNuVGwGazLNLXJ4sB3V5atCqT7Kk6dghBFjnCD3ZlzkCbSYrL7vRKyBtVQ4G
	dQhMYeaSfLwqRkUKOJ5aYgmGuGzKVGpUJVQyWcbyqpOX0nb8ABH+UPzdovIcmGD5
	5kwvoz7VVYipY+TApP9+EGBtqfZjy5BAMyYIvnUFNz/TsqlEv1do1OipnN4RQBN/
	fVr15PPR9TF6P2FvfW6TeVAvty+DYy+ykoa7RJdqyk9dBigBef/5PvKJ56fcH/ec
	G+SpQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1veddcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:25:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IFETLr034855;
	Tue, 18 Jun 2024 16:25:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8c0k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:25:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45IGOt3w028167;
	Tue, 18 Jun 2024 16:25:08 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-223-50.vpn.oracle.com [10.175.223.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1d8c08e-3;
	Tue, 18 Jun 2024 16:25:07 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 2/5] module, bpf: store BTF base pointer in struct module
Date: Tue, 18 Jun 2024 17:24:46 +0100
Message-ID: <20240618162449.809994-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618162449.809994-1-alan.maguire@oracle.com>
References: <20240618162449.809994-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180123
X-Proofpoint-ORIG-GUID: osnW9IODSUUAlQeRjdiTvbJVsPT3Igzw
X-Proofpoint-GUID: osnW9IODSUUAlQeRjdiTvbJVsPT3Igzw

...as this will allow split BTF modules with a base BTF
representation (rather than the full vmlinux BTF at time of
BTF encoding) to resolve their references to kernel types in a
way that is more resilient to small changes in kernel types.

This will allow modules that are not built every time the kernel
is to provide more resilient BTF, rather than have it invalidated
every time BTF ids for core kernel types change.

Fields are ordered to avoid holes in struct module.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/module.h | 2 ++
 kernel/module/main.c   | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ffa1c603163c..b79d926cae8a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -509,7 +509,9 @@ struct module {
 #endif
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	unsigned int btf_data_size;
+	unsigned int btf_base_data_size;
 	void *btf_data;
+	void *btf_base_data;
 #endif
 #ifdef CONFIG_JUMP_LABEL
 	struct jump_entry *jump_entries;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d18a94b973e1..d9592195c5bb 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2166,6 +2166,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 #endif
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	mod->btf_data = any_section_objs(info, ".BTF", 1, &mod->btf_data_size);
+	mod->btf_base_data = any_section_objs(info, ".BTF.base", 1,
+					      &mod->btf_base_data_size);
 #endif
 #ifdef CONFIG_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
@@ -2590,8 +2592,9 @@ static noinline int do_init_module(struct module *mod)
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


