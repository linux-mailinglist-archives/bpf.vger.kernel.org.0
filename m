Return-Path: <bpf+bounces-59153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D9AC6655
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0144E1A6F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6039527933C;
	Wed, 28 May 2025 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WtnWiXZF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC8278741;
	Wed, 28 May 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426071; cv=none; b=XorAWCDA46Anechb8XYDfL5as2wT2Uwt+S6xlRylS5c4+1XIhtl7l3aasoSaSE/B10G8X/1DdaErqK3frqO6sjG1dT1rX7Yd7H2YyUYukHyypfWGSbCNN2SU5WPDtYIYpwfUUMBIQWZ2hxEpBw5ihFDgqgKNMbfruwRd9CRvn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426071; c=relaxed/simple;
	bh=gU217Fzc9dIuIZUT2xKsHiXAj4RS1HLBqytH+UplD1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eq5U6K06uVbq4+0dujPTQw2GfIgYScY7830IPLPV4CQw+3Qxti7WXmbnBXLk+wGpFUKDJXkMyZMxfv3n2+n4LCIYYwpVub2scNJ3KBFKNsmQ/CIMaoKk6mSU6SyV7Jvftesgfzxv1yhbt0ggA0bJ7fc3W8IWquca4aepMwxVVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WtnWiXZF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1ft2r004025;
	Wed, 28 May 2025 09:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=la1VO
	U71ZfArm6vqDd5Ma3qIeqtD4r2HxuSeUHwPmZg=; b=WtnWiXZFEgk8AghsDL4nA
	O0eN+WyF3BLR9MlI+N4HvVmCD7qtafL5HuWAvKxIDM15dXi8BRbMV3UAZMevKN0P
	cJgMlBtaTkM3lK9Z9SxmoxWdb1J8OktMDwcnugr8pgHSCgPN7WFEaKe0APC4Tg8U
	mdZVl6yY7Yxuv+Y5cQpcdwZYSXT/7xO3kEsa4CvvLAZd58EpyGcY9M/A7of1OZYv
	lhKDfQHcT+UBTaIUyND6UveXAdIu+X1ONgtTvosBiEmY99i20bhKuHPiR+ODID/7
	ip4LYWrDSLYmWNlwbwVgiHwsmTAXpjosd18bGJj8UC3YyJG4QAVFBEU+tv43t5gx
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s5c4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:54:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S93Zma027847;
	Wed, 28 May 2025 09:54:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4ja79gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:54:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9rs38013320;
	Wed, 28 May 2025 09:54:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46u4ja797j-3;
	Wed, 28 May 2025 09:54:02 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] man-pages: describe kind_layout BTF feature
Date: Wed, 28 May 2025 10:53:49 +0100
Message-ID: <20250528095349.788793-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528095349.788793-1-alan.maguire@oracle.com>
References: <20250528095349.788793-1-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NiBTYWx0ZWRfX++PpNPDIqSXC dHJ+Cr0yWzWdVyozRcAQ31v+k9o87jqycOwMOopjizIv9tZSGqxHKoUHLPR7zcjLSjWubJsfw0i C5Zl1VKkafkY51JPEdzu/O9F8IQI+nOLmpfNV7v5fB1Qe0SHlr1VqGdHXfiVSecY5J3dCC8lie9
 knVzdtgGhrqjwLM6OUg0Zy0+jdtEXAbPAiOSb43XdcfJueSE7CSk+VDfTmIZsIIbbORzZDA3TCL +CHoJvd1n7c6rylkQSYaTT+zKxYkCFstLDadvHrIulqvEPFctn3uMlKgepJ1fe/+Vh67MdK37r/ /7x9Ty2gnEG7FTsHhqYroWNxM8KMjnCUtMhGm9WhW8L4jicRFXekfjpNvcw7QYOt3ueZdZO6Jhp
 5BpZUJ0vbDflHzw65vMyJN0J3kvPjgTExwlTeoUscQWJpeJM3ycBWiWGrrDtcpPMZJmFJZyj
X-Proofpoint-GUID: a6JeUY9vTD3GKLX5o9q76rUNfEyaY2Gk
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=6836dd3c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=tfYQNom77gPQtgDtiRgA:9
X-Proofpoint-ORIG-GUID: a6JeUY9vTD3GKLX5o9q76rUNfEyaY2Gk

Add this optional feature to btf_features description.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 3125de3..6f2f3b7 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -337,6 +337,8 @@ Supported non-standard features (not enabled for 'default')
 	                   of split BTF with a possibly changed base, storing
 	                   it in a .BTF.base ELF section.
 	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
+	kind_layout	   Encode information about BTF kinds available at encoding	
+			   time in kind layout section in BTF.
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
-- 
2.39.3


