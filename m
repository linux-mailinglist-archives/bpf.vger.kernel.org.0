Return-Path: <bpf+bounces-32058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95FE906956
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5324E2860AB
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0461411EE;
	Thu, 13 Jun 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="khsDkUvl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2401420BC
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272280; cv=none; b=UenJ8lHW/p85TKUZ3qC3DZnIFHkRHEVPIIooIcGSnXveykjUUXfpRJcqw7G7IWGRJkN7vBx3vejV4ZF2foNrDa5sHcS203zqREyabUjQNO7Kymld2cYOcn0qe+Dky2Qto+NxIc7OoH4Sv7NimDMSwTnhE5g4C0NKOYb5C8/BbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272280; c=relaxed/simple;
	bh=THnyC1XxFeGbui19VEy45rXxw+dSEpMYLDYCgazTavs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aw9KuzMeDHfVjSGeIuRNxZ/jor6veJEgMkN7/5OqQKPmMh5Z7kjD/SJ+7qXywVYNeAG4TYHofcQ6wZ8R3INFbPqLyt6xxpsLf4BuAp3h2wKjV6rvWeaQMS0+4GPgnvP3k6eGn/QEeb0yNlLCOoWfW1fVZURTuCX8u60YPD7RT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=khsDkUvl; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7tas5005642;
	Thu, 13 Jun 2024 09:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Q
	MNUiCZCzjxuVoIZB25ttyihVEWDIIY1wyMU/2RZ8oM=; b=khsDkUvlzRusxvtWp
	v4TIS5r9euv7qhlBS/aWKhMucWbZKO7a+h0CSEeIvMEr7SWZ2tuLgEqd3dIsy8LJ
	wnmT5bbfCMcNuiqA+cys4IQNrUjGJk2uoT8a0MQ3yXChq+EIYPWnmOtipLFzC2gV
	dofSfXdWmHEfp2HsrkjQ4XW5R7l52v/WUfq8Bgr/meEqx5z0d2KHXNKKh7uqJGrE
	yhVn/eQqy7zUHVo9/fAUeLyBg5Qo7jL1t2V34XjLQQRSbdBAL2eX1TzXtmsX4OsM
	LqSSUuRJsgA5wPSXh/O3NumjIWfAeqXK8IGHurnLgDmXn+V95wOEgpbfznixpo5f
	din8g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhf1h5va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45D8u6UF014375;
	Thu, 13 Jun 2024 09:50:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncewnmdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:52 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45D9oJq4005489;
	Thu, 13 Jun 2024 09:50:51 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-187.vpn.oracle.com [10.175.212.187])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yncewnkqw-8;
	Thu, 13 Jun 2024 09:50:51 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 7/9] module, bpf: store BTF base pointer in struct module
Date: Thu, 13 Jun 2024 10:50:12 +0100
Message-Id: <20240613095014.357981-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240613095014.357981-1-alan.maguire@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130070
X-Proofpoint-ORIG-GUID: 6r5rhXKeeezv3AOcJbKKwyx9M5E-siqL
X-Proofpoint-GUID: 6r5rhXKeeezv3AOcJbKKwyx9M5E-siqL

...as this will allow split BTF modules with a base BTF
representation (rather than the full vmlinux BTF at time of
BTF encoding) to resolve their references to kernel types in a
way that is more resilient to small changes in kernel types.

This will allow modules that are not built every time the kernel
is to provide more resilient BTF, rather than have it invalidated
every time BTF ids for core kernel types change.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
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


