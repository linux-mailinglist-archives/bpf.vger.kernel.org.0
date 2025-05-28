Return-Path: <bpf+bounces-59151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39AAAC6653
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689D03A97BF
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F627877B;
	Wed, 28 May 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qaMdrpWq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82675A2D;
	Wed, 28 May 2025 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426060; cv=none; b=h9PdnAfy+flaCa7fj69FF+XOc+4KfSKCVNhAsKwDzg+BXnbN7TffZprDE3HDRZdsaPqYM4SoJOLCQZBAY/PCd3TLeMvu5mlQ3pu+iRoNY38P89pY1gYRkujGNT8l2TQUM/c3fWDLOr+4Enxgqf6zkAxpovsmuK2H792zb6D3PHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426060; c=relaxed/simple;
	bh=hymKjgdGZBBHJdguAXeWnMcqyJGBfy7xcIJxesUqu/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbtqBX20cMDFjbdopttENlccwZaJldx3rTEPzKYkDQ20xjq81dHY3rpTR+PIZ3N+Ta6Z+ZveTK0GSSHhdFmUPC2B/pJqe9ZabrIy7iXimqzq0DBeQRwshAORmJrUZ525aP0AxFLpTBAHrQkS/+sSqq3krmoePw/wOsrnjTZZDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qaMdrpWq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1fuMc004030;
	Wed, 28 May 2025 09:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=43pviGFJO1d7CRq8lDO9uUYVrrBo0
	178sNFNpqYWoXw=; b=qaMdrpWqSdw9e1DlI1EsKlIP5+TnUwtmHxtNDDtg4OW6m
	wK6htUbpVPLKGMyL+Ap3eg9ktv7CcL3YDjPtTAPmMD8VhczKhSegBsBA2h8YohbJ
	6htrsKi4fdP2kuVH/DaXQn67n3a/Gb3xHcws+XF94k2/tldeNWhgi7mRUQdSOB4G
	gyWGTwFmga2dMADkXPiDPBr6nTbEFxfQLW7eI5oa9h3UEfe92xmORAzeJjDYaUSt
	lBhreaY7TrX2+KsOQA+xrl8TzdcEJk7FiSngRQXy+CjJpKC6L40JhN8nS+ehvcMl
	+Pn2HxwSNCj9NwzPkxNAWXiHhTJzvL3dV2fWJ3aVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s5c4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:53:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S7Ssao028686;
	Wed, 28 May 2025 09:53:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4ja79af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:53:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9rs34013320;
	Wed, 28 May 2025 09:53:54 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46u4ja797j-1;
	Wed, 28 May 2025 09:53:54 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/2] pahole: add support for kind_layout
Date: Wed, 28 May 2025 10:53:47 +0100
Message-ID: <20250528095349.788793-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
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
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=960
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NiBTYWx0ZWRfX+nuiI6Pgd7pf hNHiNrQiTvTL9XTo+YJoJjVvOVWMI5SRjSqFcTb1onFRqzTxplLWQVjyAF3qiB7ctznf7oxV1uN YbvThXpMxJn6e6C5Vk/ufqXVGmtbsJl9pSLcmaw3KKRmo3eD5ynw/26RvAOpTFhQYnunQVG6FD1
 Nq8yBjpk02Ieotfzj50+gCF/iCD8dBX7VfIvx8q1uBs/eMUGJdB1XBTO6Yw658x2JCopraqiHFf vM+LHR41/zCPNZOGnRZNjhX//Xqg9K3l/p2il9PtCm10d2o4ekBUg0fm49Y5uIDxCyfbpKJ4Sj/ g3JqkPf8iWl6NM8pehmiVxYJsEkx3fGj7gs/++M6q3yA/FIPnpjBNk7x+MJYsbPiSl99VRd1bxB
 GrPnq84Iz4NwMphsQRLZdkG9ZSikNvIe1sCEhBsOq1l/IxenODGo9FoOWP0+x9R/ahpALBZY
X-Proofpoint-GUID: DD0qzMg8h91nm1m5zz0gQPyiviRfmYDA
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=6836dd34 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=dt9VzEwgFbYA:10 a=h_xdTLq9NACotyI007wA:9
X-Proofpoint-ORIG-GUID: DD0qzMg8h91nm1m5zz0gQPyiviRfmYDA

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

Alan Maguire (2):
  pahole: Add "kind_layout" BTF encoding feature
  man-pages: describe kind_layout BTF feature

 btf_encoder.c      | 10 +++++++++-
 dwarves.h          | 13 ++++++++++++-
 man-pages/pahole.1 |  2 ++
 pahole.c           |  7 +++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.39.3


