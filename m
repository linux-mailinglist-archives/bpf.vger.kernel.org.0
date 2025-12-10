Return-Path: <bpf+bounces-76423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D8CB3F65
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 345843028FE4
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB3632BF5D;
	Wed, 10 Dec 2025 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ShYtN9fV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60730216C;
	Wed, 10 Dec 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398604; cv=none; b=mxUz24BVr5Ec6frsoGjZNMCCgKgCWKK4Jm5/W/ynx3duWIHKi22ocQRf3ZpP25Dx6RuE5pb3y5aTE7WdftsPkN5aWCbLroVkykyE/FRhDwUIPbR+KxgoyHH0Sc+a+XTW5hvv+Tb05a1rf/071pFVXM2IGolnouuP7dl9WL8hFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398604; c=relaxed/simple;
	bh=lJtjFVp/X/PxBRo43RPzJfKsZ1wZxpFMlvjEPbZLQkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBP37GrIH3PTk4UdZ0EI/EhRvT3CqdM98SnNMKiTTN8bvZdzUmhShY8C/Z9730+/WJ+FVHPSZxO2/Ew+m40LkfqEGp9btKjY9XAuCG2fVy/xeWWGwvhqHfWlZHGvY9Xs9RhS/yrWmyZWE0qvKEcCxvpK7BjInaSD4P5i43hJR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ShYtN9fV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIY8F43631706;
	Wed, 10 Dec 2025 20:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=NeqH+/+PULeXVPV9AFHJ2h8q6RMvx
	LR5TgqF/3ZPsoY=; b=ShYtN9fV2+IiAqcDOGk4FMm/dPwZy/mkNM6fd3w8fZbed
	Ee4WEtWPxoRAucL9CuluoUwseNfuztmMozAzZQSCTlEPEmWPHAQ3kfWD7v5AAQRh
	ktt13KCaiZ/TSgrDK7kyflpoKmxiPXcdO837itiKh1dY/lhi8PDLjVttuLvXq0Tz
	ec+WB1an7WIsMwm45uDE1BOrKkl/AUeUwaZBmImh93sR+DHuD2iEnv6m/fpYrIak
	v42IufY4ee81SHOmauJygOAXCt8s5q6oNAklmbqELS8fZ6XvP3qF729NyGgHPhwU
	Iapn0Y1BHCJnDkPfwBpJ7nrqUdCZGuq04na+ks57A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayb2s0mbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:28:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAInXoH020900;
	Wed, 10 Dec 2025 20:28:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxb08cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:28:23 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKSNwq003322;
	Wed, 10 Dec 2025 20:28:23 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4avaxb080n-1;
	Wed, 10 Dec 2025 20:28:22 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 0/2] pahole: Add support for kind_layout
Date: Wed, 10 Dec 2025 20:27:50 +0000
Message-ID: <20251210202752.813919-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512100168
X-Authority-Analysis: v=2.4 cv=Raudyltv c=1 sm=1 tr=0 ts=6939d7e8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=R58p1Hktg7rUS1zaXpMA:9
X-Proofpoint-GUID: HTvCTILOSfqBrqY0jTkWf-zpmo6TQSMQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2NyBTYWx0ZWRfX8wl0b0fgZBqb
 SdH2r4w3ZaPZ6PexRMcLOaGcRlFD0DXBW9H+fqCYLfnClah9lqcdsxfBv+OpR+BEQ0//TwSp93F
 VPL/SZz7TeoxrSrVWlLoaM2o3xH7dfVNxcE7jYRaW9xf8YLTTPp9fUAqaH/abAsEWwzlCCCB+ii
 qW32mRhZPvKwcn/UqDtSoG98ZHs78GqGRYPSpnewMECHOt68MqXd/3OQCWhSDWEgmyVJVlxJ30x
 Tm6w/OwsO1g/6jS0l6Fr6xFhJJHUwrsRyPz1d/0pKcOHiCbpNZzQ8aresM311wY85r4MIgyuT3a
 6RxL+GcBaJyh25ILM+1OY3Gtv0yFtiSDRlSFvHdNoZNRBeiGDsiMtH2VfgnknLV3DnAhAc+SHYB
 gjuHsvHTnkLyr/cggJh2NwmlGoaSGw==
X-Proofpoint-ORIG-GUID: HTvCTILOSfqBrqY0jTkWf-zpmo6TQSMQ

A soon-to-arrive series will add support to add BTF kind layout
information to BTF; this describes the BTF kinds known about at
time of encoding in order to support parsing even in cases where
the kinds are not known to the parser; the kind layout relates a
BTF kind to the amount of space it consumes via an optional single
element following the BTF type or a set of vlen-specified objects.

This series implements the support for the BTF "kind_layout" feature
but does not require the libbpf changes to support it; the feature
test uses a weak declaration of btf__new_empty_opts() to handle the
unsupported case.

To test pahole with this feature, the following approach can be used;

1. Specify -DLIBBPF_EMBEDDED=OFF option to cmake
2. Install latest libbpf with kind_layout support

Alternatively with embedded libbpf the changes can be applied to
the embedded libbpf in lib/bpf/src.

Changes since v1 [1]:

 - Resynced with latest pahole

[1] https://lore.kernel.org/dwarves/20250528095349.788793-1-alan.maguire@oracle.com/

Alan Maguire (2):
  pahole: Add "kind_layout" BTF encoding feature
  man-pages: describe kind_layout BTF feature

 btf_encoder.c      | 20 +++++++++++++++++++-
 dwarves.h          |  4 ++++
 man-pages/pahole.1 |  2 ++
 pahole.c           |  7 +++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.43.5


