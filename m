Return-Path: <bpf+bounces-65205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2643B1DA1A
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352153B961F
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455426562A;
	Thu,  7 Aug 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o65qfClI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93330263F52;
	Thu,  7 Aug 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577743; cv=none; b=FCPmUHaxJsYh1KOXMGiGelEVXpV6OJUB9ZqxrQ45vNx0FYpAqMkddow8ZYERGrdOc/Lv+GXEz2gjfCD/grcPRMHYCVwstQuZ4sJ76YxlbxZf/8SuXLEIvzt2U6/UcVLKo1aOuT18N7iuqRGtb36BHRid30njtwUA7OvIh9SL6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577743; c=relaxed/simple;
	bh=Km0dZn0ri4q9/DPF+d7dkn8lqxW13DF43Fgx6x7ZDho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URg4Ngxt51+JS/89kl3AAaZfE+y/L1GuSi0SaRRxVmvSQAm5GajKXb0dc5AaByvme9hq7omJf1o3r8up3hg29Hi8B9LJXcqZJdhMYbIMUY3vGBHHwT6BgfUKJAVbzzVVeP1JZ/ewthoaFWEwexIvj0MlhlZLX3Scu7KJE4aAdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o65qfClI; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777Msdx028191;
	Thu, 7 Aug 2025 14:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=zjJvo
	yPY+5FDfkx9nxgaKrI//e+aeBzpwZrkTIy1Beg=; b=o65qfClIV+2S+tCkE7Zbq
	FbkO/Gyr84V4ZJiR0n3yJNfD64mUZLwunTxbeSZ1+F0T/d7adVq/y+tm6k/DjA7B
	e7PoIl7xUh3bvZVINYzaveHAQEhQh7shFy8tyXs/wEYdTWQgK9MKmkPmVqIG9gn7
	PY4bv4W8h35J+qNWgK/OynzqBFpbGY9sBNv/b7BXAxkMYtepZy7MizF2TokUBuqy
	vRxsmJYX2mF9rAlpNmbDfplLWH7zuoKQxUpevu3ygxDSw0dd1okhnTkX9iK2Qt9e
	oLrhqu0YhK6gLqwI/1CkQGJurVCQl1OC02yV3pI15cOxmNKY8A9Kpzumsie8V6GY
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh47yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577DnK14005633;
	Thu, 7 Aug 2025 14:42:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwyhvv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:12 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 577EgAIl014830;
	Thu, 7 Aug 2025 14:42:11 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-8.vpn.oracle.com [10.154.53.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48bpwyhvt5-2;
	Thu, 07 Aug 2025 14:42:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 1/6] btf_loader: Make BTF representation match DWARF
Date: Thu,  7 Aug 2025 15:42:04 +0100
Message-ID: <20250807144209.1845760-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250807144209.1845760-1-alan.maguire@oracle.com>
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExOSBTYWx0ZWRfXydSe6qnlR4Qj
 BeGfwKOEX4QE1CBtgv+IZwa4iRL3cBFiPvp2LT3oEvOT24HDSFWWNYx5tlpdC9Hvg5wMGCxeuZK
 /vOt8ILa3MMHLbXm9uuHTrn1TVITusDdoy7r8ZE4k5a/zENIyQ/xMYB5/TAqc0p5mnheaLIg33d
 JNO4mxt7J+sC2hHqG9S6EuIDeAhX73o+KjRIo9F7AGDjJCpiqyONdKk2qdOcCcXC50TUjkuW+Ph
 4GvhrjP4xcMwRNASopizcgf2fyiwFeiGqe0EGmr93kHTDQfiUNIP55mSQrIS8/GeHvZnWkrOVA2
 XDCOTvEc4absSktvoiEnLM0XX+Kdr5f6CYe70EkN6SV8J3TgvLdOhe2HQsF3I+NPFv5uMBrrXbt
 ynUhcvOpTWUvevbICdK+4DzGPVhmfpKMVz5+buRT5SczisuWO+PvgEdK5zwIIWvAUM10LfAh
X-Proofpoint-ORIG-GUID: wuvOeQscZuTy-RN2q4ZBKekHvLvGHyDp
X-Proofpoint-GUID: wuvOeQscZuTy-RN2q4ZBKekHvLvGHyDp
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6894bb45 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=3rK2JQj8WhsnV6v3Al0A:9 cc=ntf
 awl=host:12069

The function prototype representation for BTF needs to be modified to
fit with the DWARF-generated one.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_loader.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/btf_loader.c b/btf_loader.c
index 64ea680..42bca92 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -84,6 +84,8 @@ out_free_parameters:
 static int create_new_function(struct cu *cu, const struct btf_type *tp, uint32_t id)
 {
 	struct function *func = tag__alloc(sizeof(*func));
+	struct btf *btf = cu->priv;
+	const struct btf_type *t;
 
 	if (func == NULL)
 		return -ENOMEM;
@@ -95,7 +97,9 @@ static int create_new_function(struct cu *cu, const struct btf_type *tp, uint32_
 	func->proto.tag.type = tp->type;
 	func->name = cu__btf_str(cu, tp->name_off);
 	INIT_LIST_HEAD(&func->lexblock.tags);
-	cu__add_tag_with_id(cu, &func->proto.tag, id);
+	INIT_LIST_HEAD(&func->annots);
+	t = btf__type_by_id(btf, tp->type);
+	cu__load_ftype(cu, &func->proto, DW_TAG_subprogram, t, id);
 
 	return 0;
 }
@@ -124,6 +128,7 @@ static void type__init(struct type *type, uint32_t tag, const char *name, size_t
 	type->size = size;
 	type->namespace.tag.tag = tag;
 	type->namespace.name = name;
+	INIT_LIST_HEAD(&type->namespace.annots);
 	type->template_parameter_pack = NULL;
 }
 
-- 
2.43.5


