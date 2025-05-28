Return-Path: <bpf+bounces-59160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE708AC6679
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FF2179C54
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21293279346;
	Wed, 28 May 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U2rbY+vL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FF748D;
	Wed, 28 May 2025 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426314; cv=none; b=MQFMM3sgAJuknWX5by6hj77dd69bIbDYVy3iwU4IzEITKDnCyAW9YewYwbmhpePN0gGG5Ajh1wj7Fixvu8F04CRuxKMIMrNQPdqeDqIlUYo/pX9JtyDKdCt4MhB+wnBWyWgCn8St2XjIt+8xFAf8lf4BwE+p+ENFfT3rDYrg5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426314; c=relaxed/simple;
	bh=I1k5kY7Ku8uknlMfkIAAzXh9HQr+ulRl2pvSl6kL86M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moAc+1jWSAqEixZCNQEtlx27bq/wZjVewBB88tP1t7u2why+5M3XRrOWCctAvTvKTYM9BTjG4yBSZoGPHIrTr9HkNM1RxcbHc+Slx5tAq1NjuubItzMTpR0yQFZ4c4ttrAjQ3r06OaMlZpEBamN9a74kv4V5xdA30yoRYmBfIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U2rbY+vL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1gCdR002321;
	Wed, 28 May 2025 09:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Cexua
	R91RZlj8N4rMHIdX8R9eFCCrcIzUPlSy66Lp80=; b=U2rbY+vLL1gbZjDGlA8DK
	m5u04kFRkj9QiNZTfdObrIOBafcMz+JwjRcL2ANurjXmod58nu0rawv/YU8tF1VC
	ZstIFQTXe/Uffld38r2zQq0qgjl0boHUkTejMxr5iz1CxI/i7lMJVA2JjQeJU42y
	ERnZ1AHEIRxEcZsRyb/+R9epAWdzGL1ABd6/37FyVxEWUgWp79/gXM4wsjzSesGQ
	ruXBwC4KjfJTJ1dAz1kW6hf8RS84Eg4j32m6R2nOQ+WPMsZsfdrmLcD+odet/QYD
	CpgIeg4ngTniadT8Ucf9dQgNK6o/lgc+0iUHbSyHECZRou7oGUjJo3FdhiLd1vBO
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ykwhhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S9UuTg024593;
	Wed, 28 May 2025 09:58:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaevaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9qwW4007194;
	Wed, 28 May 2025 09:58:11 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jaeuw6-10;
	Wed, 28 May 2025 09:58:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 9/9] kbuild, bpf: Specify "kind_layout" optional feature
Date: Wed, 28 May 2025 10:57:43 +0100
Message-ID: <20250528095743.791722-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528095743.791722-1-alan.maguire@oracle.com>
References: <20250528095743.791722-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-GUID: HJYkvhoa9vdlTi16vIeniBDsRHnn7qCL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NyBTYWx0ZWRfX0Bz2DJ5R1UZ6 T/ZK4pbJlEs2VTORYJnjijn8wbUgIn+yX02uCB7AND48iT54iyHFtgWhXnt9Goegu98VUUoWqrR FsKHFcg0ih5PBfx5dHZYraO3WoVAEmR06nBMsF37WkGSAjmy+WXnJXSitxUyCjwNJJBUjwW8vb6
 Mg68AbpTG4O5qgxETTzWCR0QDENHV7Ym1DKfJGgpfqFPXs9fg7dR22rPTx8f3FHjTSxsViZ3hrX 737U3Vzo6ufihJXtNMYf8dZF1L/ZLD37TgViqRwYeZwO4x4A02KWscJkRJ87eHpgxg4IIjDAJ7f ISPmdEhrrGvm7cGNE2ZTc2XS2NGJ3IyNDcFF8BHaPjEB8hfOcAPYNH8A4CmMWy0Fe+VYKczPE/h
 JB1pYJ2tiZUPO/B3JbKTHYX5YGlwWMHfXsHhu24JfkuPT7nOXxStjvo4AkyixmrMDPNf+vVl
X-Proofpoint-ORIG-GUID: HJYkvhoa9vdlTi16vIeniBDsRHnn7qCL
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6836de35 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=YSa9T1u8tzWrEExJ3QwA:9 cc=ntf awl=host:13206

The "kind_layout" feature will add metadata about BTF kinds to the
generated BTF; its absence in pahole will not trigger an error so it
is safe to add unconditionally as it will simply be ignored if pahole
does not support it.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index db76335dd917..c5a3526952ac 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -23,7 +23,7 @@ else
 # Switch to using --btf_features for v1.26 and later.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
 
-pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
+pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes,kind_layout
 
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
-- 
2.39.3


