Return-Path: <bpf+bounces-14928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3217E8FC7
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA93F280C11
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BC28495;
	Sun, 12 Nov 2023 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dfJzzei3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F9648
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:36 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA1C2D64
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCiope031638;
	Sun, 12 Nov 2023 12:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=2A0noEcPZRk9vO9efuZPj783oUGGJPiH8HIglN5iNmA=;
 b=dfJzzei3XYGT4jPcsuZSP+yiAzutPDpKKYVRYS15sIjjgbDOC+Tzj1UZugaBhuwStCON
 kr1ma4RNwfFC7EuU9qPkvYSY7rXXRz6XKJNPH9MRLvxPY6jn6v4MCfn8hNsKIHE1D+OJ
 UxiZuOS1eh+SQbHTjkvbRfaEcjvAImBt9cdZKL2H/57XtOr6Fk2nIZlXXZyvaZJbKw9N
 8Ay0S4nYDciYDV0/XIqvAQZzGNqZIwKFLNJUjLLynugQzo1Gyc+sqACXWl611Jas4fp4
 F3nGJ1GHlemPItPQVb/c8l8OfEEaa+2WoFItTML/qulA4P4OxK8QJSmM6hxX8/Pwvvug /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2sthe53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCENCi008877;
	Sun, 12 Nov 2023 12:49:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:17 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceK029718;
	Sun, 12 Nov 2023 12:49:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-10;
	Sun, 12 Nov 2023 12:49:16 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 09/17] kbuild, bpf: switch to --btf_features, add crc,kind_layout features
Date: Sun, 12 Nov 2023 12:48:26 +0000
Message-Id: <20231112124834.388735-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-GUID: 4x_eiEopxNJrSH83pDkq7mjoPUIhZZ9K
X-Proofpoint-ORIG-GUID: 4x_eiEopxNJrSH83pDkq7mjoPUIhZZ9K

For pahole v1.26 and later, --btf_features is used to specify BTF
features for encoding.  Since it tolerates unknown features, no
further version checking will be needed when adding new features.
Add crc, kind_layout features.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 82377e470aed..f8ce33d7f9bb 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -16,4 +16,6 @@ pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
 pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
 
+pahole-flags-$(call test-ge, $(pahole-ver), 126)	= -j --lang_exclude=rust --btf_features=encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,crc,kind_layout
+
 export PAHOLE_FLAGS := $(pahole-flags-y)
-- 
2.31.1


