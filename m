Return-Path: <bpf+bounces-58491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A020ABC511
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 19:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23727A157F
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70102874EF;
	Mon, 19 May 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M98dtuy+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E51C5F09
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674008; cv=none; b=D8UfjQdSeya33OjfXdVDaxBQMHp3Aa9c2DaCaqAfHt+qFaPCRemmz8wkDpDl30xlhHU3mHZt7s1W2OdQIYvL2TXYENqZSft+l0jxiIjrsGM4jxMXQ6+lkIU51/bIT5wCuOrRAGVrI1QvrlSjk6/t7iZt6iNMS24TrhqzF0F1tjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674008; c=relaxed/simple;
	bh=sU7pudcMkyPFo/YJKepn/mksRvFbnP5SJ5+NATHOV/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWddA2jWKKcyGfXY0aCjwJFVhh+pUs8eRNOGHHndSrlndZsu63bZ7vEVrkrPbU251rjzDk+aSFfF6/H/QdkTLuJzHGsIVpKlTrtPjCFHTYX809wYNCzNXCdwzBEmhn14PfVjii3f8jvsYPnj+qjvodjwW19KEgkdBueo3sXD/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M98dtuy+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMtpd010286;
	Mon, 19 May 2025 16:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=CZO4o2hIb3ItJUFqrdbxxhGDt20Ti
	tOne3BXxWpSPm0=; b=M98dtuy+8TxyDljfCkjGbI/O8ZTPcO+W1zq2exwrW1svi
	GhBYPdeJFyx1vJwAoN+Q4DG+9Q3q8ZpJiN4kCYzuOLrNO8VqUcp634Z1ykLDuzOa
	qC3j6u8ZYOAyWsLD30sfG7fBeZTOYgSGgKiPjZWIlUxq3uphD/kbkmRlBNiu6wj9
	xTw7IPI6fGmbrSssOinJLahVT3R2xz/5K1U71ZML5Zkz0/DjsNfMKm5JTUJ2pjKj
	+wHvpNU+QIz0MJ7Hxl5f+hlp0ToJScfKrPs1fsaiP0V2pfhffy04G2PQP5UWArbt
	6LvBM/GRlohJCMtO2E+ly6hDYti/lGZdUAXvo89ow==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46phcdujtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 16:59:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFGt10002341;
	Mon, 19 May 2025 16:59:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6q2hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 16:59:40 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54JGu0Jl010939;
	Mon, 19 May 2025 16:59:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-48-230.vpn.oracle.com [10.154.48.230])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46pgw6q2f5-1;
	Mon, 19 May 2025 16:59:39 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, ttreyer@meta.com, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/2] libbpf: support multi-split BTF
Date: Mon, 19 May 2025 17:59:33 +0100
Message-ID: <20250519165935.261614-1-alan.maguire@oracle.com>
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
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=897 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190158
X-Authority-Analysis: v=2.4 cv=a6gw9VSF c=1 sm=1 tr=0 ts=682b637d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pxP0H8n_0CaKwmOv1fYA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: YINewxUs_2KcVflwJLABx88Ub5ecZeep
X-Proofpoint-ORIG-GUID: YINewxUs_2KcVflwJLABx88Ub5ecZeep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1OCBTYWx0ZWRfXxJkiFKTGck9s BOYLskpW9GeecXetwdvCXdmBVHOJkaJ7T/dRLWVdVaZFVJuYRo1QFsS1f5WJJlui5Td17a4zL4m fDBKAcOpbI5/lN1th1erPtxUWZSfqrfPe8OgwauApJz6dynyrdg2f4LiRb+iyKfUn2hGf7K7/dF
 4ivlFvLvdbMmAGj5JLZUUT+ycYnYX1qa0MfiHVNA1dtsGA52uJp+ZdwCVuU8dnI35WwvqRye93l 91feBW6NzbCoSSYCIH8QMRBlKIP8nph2fs5LfNfQBD+bdmTIfM6nKR0epkiFWrLEhh5TXbN039l /tTaQQxnbSGTo94WFQFa5TnC4GXFahFQEzDJgJTJX1GQVJXAh2YttBGUC+BWeW0P7yFLu/SYeBJ
 lWlXUAoKyJwE3cMxmFHV+s/5JciV8pv5j604P50/+Cvcu14OWPTs9UHz4YLDELIs372bDFi5

In discussing handling of inlines in BTF [1], one area which we may need
support for in the future is multiple split BTF, where split BTF sits
atop another split BTF which sits atop base BTF.  This two-patch series
fixes one issue discovered when testing multi-split BTF and extends the
split BTF test to cover multi-split BTF also.

[1] https://lore.kernel.org/dwarves/20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com/

Alan Maguire (2):
  libbpf/btf: Fix string handling to support multi-split BTF
  selftests/bpf: Test multi-split BTF

 tools/lib/bpf/btf.c                           |  2 +-
 .../selftests/bpf/prog_tests/btf_split.c      | 58 +++++++++++++++++--
 2 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.39.3


