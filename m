Return-Path: <bpf+bounces-76434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DC8CB3F92
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3AF33031CFC
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886C532C923;
	Wed, 10 Dec 2025 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YdX2pg1d"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2812EAD0D;
	Wed, 10 Dec 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398881; cv=none; b=pxU4K6gHci0fURrZRuTAjq2b28igEpFFX4/NFFMk62rdgdS7o3CIJYw7WY0Je6Sxh5zrmr4hhb6zoA+V9znoQfz2+Y3hmrBMfDn3CYHOBCjrlr5En9AaHxcaIkj5BOWG4AbGM/0BoiIKOiiE9uIr9A0xbkKyzZ9WgmnA32metJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398881; c=relaxed/simple;
	bh=d61PyGw54C1FQq7jg3t9WJ1cxBE4hguMqLoNBkzHexE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzEtpnumMVcuJgVM1WhWwsJIPy4FSQl9vghRJv9kUJHe/qTmemOuIkkHvlyrTA9c9mVwhskcVa31jUgRLf6ko7QkZ42IR7tluo4/HVIHk3gzE7x/7KVyjDbO41lZiW72Ip007gybPo4nooQP88QHYnLEbxVaxjuwcwtAf28oaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YdX2pg1d; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIYOZl3758427;
	Wed, 10 Dec 2025 20:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=hEGkA
	kCWF7WIGrTUBJezXyGzk3hJWbnrydSfEHJs3Yc=; b=YdX2pg1dZxesFMdW0SJ4e
	oZag2K+RbBDETBKlwsp8UbNmgMlzTS+tzz1Fn85d3Qe9wqu2x68qv7tndpshZnpF
	UiS3rJ9uJtY6bKzHiyHXLFQ356ETqMOFhsUaTJT/E5Mr2c31piEmznI0ShNCVOG1
	yZsjbTgKPs22IhRW0RNTU5V0XFdmSp/Qt1RnZLb2Q7gat5MsuNwvQmIbAf9yn8ur
	LDBvcJEL5nbt/venu22vVXRQCx3qnMN3Z1YD7tnNJ9HHi4gj2bf3Rv3iG3tOsTFf
	RsAAgp1udO5DHbJl1XrApQpGAg+2lia8sh91d/J3bHrwfc9hHD0luMP+Y9RuhMb9
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aybqv0h7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJ70ZN039933;
	Wed, 10 Dec 2025 20:33:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxmrq84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:14 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKWkSn001635;
	Wed, 10 Dec 2025 20:33:13 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxmrprn-11;
	Wed, 10 Dec 2025 20:33:13 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 10/10] kbuild, bpf: Specify "kind_layout" optional feature
Date: Wed, 10 Dec 2025 20:32:43 +0000
Message-ID: <20251210203243.814529-11-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210203243.814529-1-alan.maguire@oracle.com>
References: <20251210203243.814529-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2OCBTYWx0ZWRfXxoM+Ha7qr+gb
 iTIU2ONA0O1DQU8nX6UNNE8MkMxJImwS3V1KmRTc5apPF1qdJAqDxErmuicXSJWTAn+TjzsqULC
 Iab5MAjfXgqM5YfGAA7Hffcg3TZHNjzf4X95ADgtDvvhDM0bbR92hKsWNNOS+Igcn6LAoTfsecp
 cX3AAmiX1IDIfnBQeQW9WLBuaV8o5WF9vWePX0xrdhf58qLwBx/wQVPndFQ+OMVC+PMxi6fFVYI
 t1WLNWMO5GC+kMI5rslP3Fmzv9Lixo2Dn8StWwdPXp8voBXdJYuaw5goKwS7Tqghw65/n480BpV
 wdIaFZtisAhZIyOyng1B3ujVCbR71zK0WuHhVPkpz4yexq1CrKgGGOdtAPp3IaNk7UNqGF+3Olr
 ag8De8xevBkU63xVIqFnVVkj0AeAoo+P1QW50LaCfEUoW2jPink=
X-Proofpoint-ORIG-GUID: rS5gvEpZgQLE0x_9OEpisz8u8LRS6u_3
X-Authority-Analysis: v=2.4 cv=OLAqHCaB c=1 sm=1 tr=0 ts=6939d90a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=J4qZCyyk7QvxA2XVlwcA:9 cc=ntf awl=host:12099
X-Proofpoint-GUID: rS5gvEpZgQLE0x_9OEpisz8u8LRS6u_3

The "kind_layout" feature will add metadata about BTF kinds to the
generated BTF; its absence in pahole will not trigger an error so it
is safe to add unconditionally as it will simply be ignored if pahole
does not support it.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index db76335dd917..c20f9bbcabeb 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -25,6 +25,8 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=enc
 
 pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
 
+pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=kind_layout
+
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
 endif
-- 
2.43.5


