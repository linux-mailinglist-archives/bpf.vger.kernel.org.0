Return-Path: <bpf+bounces-32843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA077913B8C
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 16:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE821C20E5D
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F08479;
	Sun, 23 Jun 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g+uyjC5A"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670B5228
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150799; cv=none; b=g6WGY5zd5MTHGn0+/fTnOaekCRwmHKG1z8Djm8TTKEHchYiYsI9/JR96mp16zi4gOEtan+VfKa3p8otHibodPF3KuYxgu0E2cuxHC1NSse31dB+S5DaqxEwwzlBtrosDSdhbI6v5u5vJfCE4IA58PbdPjMHQ9+hs+CtImYRTzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150799; c=relaxed/simple;
	bh=6WNH7zH9/ckuNlQ1bPZCdUnjXe454uzTdU19IatBuv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqYMPh2fuB33ViriDqU13lOr1npS+QQf2O36Ymt2YuZRK2h0uKgEbuqvS6qBiTX8Ayb/zLz5oc9zUTAlbjPS6GE143Kq6d0EQHcMGDwufLN6nmdWfI2HRMyNkDfFj6Osk5qDR8ksVc0BLzs7R79yPUok0zWQPcIZFH6BLvJN3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g+uyjC5A; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45N2o1nQ011088;
	Sun, 23 Jun 2024 13:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=N96n1b/ub9i9b5
	Cy3DCFVFL/vrtFsmJPT7nUW5WvY1U=; b=g+uyjC5AMpgZwQljm++pdYhaVKULBd
	9tdpsgV9cfrRNPAZKuK6ZHwhyIPkPN+O5oRMc/w0jehFt70J5CBUimPyHtteEojt
	0HhJNVQtBv1aW7NnxSB/Pg2rlXPGi8m3nyF7JHyLJfC8HBrfjT/IDTfpXG3FbQOu
	OM44Vsa/NlkG2YBaOc43z9Uwb7fq1imRI7PQARl5Km8RRb1v0XuaD55CewmJ6tWA
	kowEHmmTxVf2DYHWPhbEQ2Wu5If9z2RI81X52KjgHKh9SacdW4KGURI9B7FYlva0
	mSeLddIItpV9hzkefTA5nn6HxvPstDWOnLvYYtAEKXEI8Hdad/F7gyyw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg918ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jun 2024 13:52:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45NBCUQV023503;
	Sun, 23 Jun 2024 13:52:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2bh1j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jun 2024 13:52:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45NDqTc3035846;
	Sun, 23 Jun 2024 13:52:29 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-162-165.vpn.oracle.com [10.175.162.165])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2bh1hk-1;
	Sun, 23 Jun 2024 13:52:29 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: acme@redhat.com, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf: fix build when CONFIG_DEBUG_INFO_BTF[_MODULES] is undefined
Date: Sun, 23 Jun 2024 14:52:24 +0100
Message-ID: <20240623135224.27981-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-23_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406230110
X-Proofpoint-ORIG-GUID: nnMbJx1jxELQkUCqPXADdxZIIVNzPTik
X-Proofpoint-GUID: nnMbJx1jxELQkUCqPXADdxZIIVNzPTik

Kernel test robot reports that kernel build fails with
resilient split BTF changes.

Examining the associated config and code we see that
btf_relocate_id() is defined under CONFIG_DEBUG_INFO_BTF_MODULES.
Moving it outside the #ifdef solves the issue.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406221742.d2srFLVI-lkp@intel.com/
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8e12cb80ba73..4ff11779699e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6185,8 +6185,6 @@ struct btf *btf_parse_vmlinux(void)
 	return btf;
 }
 
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
-
 /* If .BTF_ids section was created with distilled base BTF, both base and
  * split BTF ids will need to be mapped to actual base/split ids for
  * BTF now that it has been relocated.
@@ -6198,6 +6196,8 @@ static __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 	return btf->base_id_map[id];
 }
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+
 static struct btf *btf_parse_module(const char *module_name, const void *data,
 				    unsigned int data_size, void *base_data,
 				    unsigned int base_data_size)
-- 
2.31.1


