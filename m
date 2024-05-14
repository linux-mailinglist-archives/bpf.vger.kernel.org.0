Return-Path: <bpf+bounces-29707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA98C59B1
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 18:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159F91C21573
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382AB17F361;
	Tue, 14 May 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TnbRdz6A"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321DE2E644
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704067; cv=none; b=QVhXYEpVSFhJetikU/GwGNqR4fHM74BKAyRHW7B9ysIsjWZaQyO8oZMhJNwNwr2dNDVDesMnehqBQDzywhWZXhIW4OjcK6JrV4l18U2iJJKeSmEXMYI3j5zqPF5go0z6oFlX6IvrLVnB4IivYzU23MoJDewY4Dr5j4Zi6u8n8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704067; c=relaxed/simple;
	bh=I0WkWCd+StdkkkIi8U4rkJvrpiyCs5hdQbhtlspMpQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PlLabu72fXnxa+0F/HbCXc19PFBmYmgPR+STVFYWpqYumnJ0MP0nbNQZhn3VFZqITPAO3P354EtFNhaf2BhE98pOJRbdnXLemGyU5Yg65DJuoE3PAwvQFUsTSUtcuYMoG5QXgay8Px9dhIr/HKU7WX1hfQSX4m/fid1AnPJRGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TnbRdz6A; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ECg0UA006826;
	Tue, 14 May 2024 16:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=vgIR2PsIoaGkd9RijBXIWbYLDAJjWHHEMi9OO5xK+JU=;
 b=TnbRdz6A0zJ2i37jReTUzXR2ZYBqecaJgTISqD8BoB8RQUDKDeonlj7n+AEZTMsUce3i
 It6eaB7U88yfP2Ez21PIxWODrNpimQmAcxegYfZ6hI/eZ1h8Bj9ZTdx9TdWxdLkE1TlJ
 6ycaEol8rEYzmYIWMn5WePhZCCkzuZW5C4aNn3g6rDgaw99QlZC9VM7ZYDXZYuTg8DS6
 v0EsH6Y8l0twESnqpNL+Oe1X+Bx4yDUks/35vAqbkLNyTTLaAZj9VqW3txNiQXlms9vv
 cwGcEaCQVAIO22YLiGH1xi16VvjgskfEavIzWoL7CcQWHQZcVjFz7LrdTJzqu8j95XwY oQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx31tb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 16:27:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EGB3vl017401;
	Tue, 14 May 2024 16:27:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y47fcws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 16:27:22 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44EGOxpv035863;
	Tue, 14 May 2024 16:27:21 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-191-216.vpn.oracle.com [10.175.191.216])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y1y47fcsv-1;
	Tue, 14 May 2024 16:27:21 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] kbuild, bpf: use test-ge check for v1.25-only pahole
Date: Tue, 14 May 2024 17:27:16 +0100
Message-Id: <20240514162716.2448265-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_09,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140114
X-Proofpoint-GUID: F1puf_PFLPN1oA6KSCglx73jnYIQ4PiQ
X-Proofpoint-ORIG-GUID: F1puf_PFLPN1oA6KSCglx73jnYIQ4PiQ

There is no need to set the pahole v1.25-only flags in an
"ifeq" version clause; we are already in a <= v1.25 branch
of "ifeq", so that combined with a "test-ge" v1.25 ensures the
flags will be applied for v1.25 only.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 2d6e5ed9081e..bca8a8f26ea4 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -14,9 +14,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
 
 pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
 
-ifeq ($(pahole-ver), 125)
-pahole-flags-y	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
-endif
+pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
 
 else
 
-- 
2.31.1


