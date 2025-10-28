Return-Path: <bpf+bounces-72566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB59C15A88
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1361889564
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11753451CC;
	Tue, 28 Oct 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qudhhOsT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F53446BC
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667067; cv=none; b=W8utt/UnXxc2c5wQ6rpQ9nxmSPXgrmD0y4u47mjeaJ/MaToqwgYrXImqh6KWYJgc2MGNOcwQtbA6cuhEHhCYWgYca8MPC8fIaCOkaG5v0+KQCyLCe3VV/H082h+4d4owxGUs0TKtMyDAtPz92jA3+Ev+QEYj2VyToMe6C04ZJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667067; c=relaxed/simple;
	bh=8rKlImVj+2AWELQdN88rOb9nCKOjayRLnM0j8RW3Cgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAuwuT/DKILABFm/Owbq7zy/BAkh6C8nf5p+BHlQJy63oggnno8WjPyiqhUF2Dkmm+qm3+TkPPhHob1sYxL3g89VMmO48W+Lq81rph/ZfuCj4/UX1aRYP7vCzm+r0yyRU+gvKaO9shSaa3gN8et4WKouIXrCsbDZL8kkfHUyzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qudhhOsT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDbHZ015523;
	Tue, 28 Oct 2025 15:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=2apWbwLJk1u0zQgNR+b9pvAEa+4ZE
	exi+CEUC/WGAx8=; b=qudhhOsTeVI26BXjbTXfgy8svd+CRURSH0gWxGqQgjDjH
	MKByzFpKrB8hcs+Wl4P0oRjK+FV217z/sFOAa8YiM0JnN57zpqpmoQKs4eSdC7T9
	ilkDOcVKkWspNdyTcak2hkh5mQq8uPtJnN12OzwoImTUL8PrDzhhST5+gajZk6Tw
	Ud4iRPpRne4/VtPrTiY3NEufGgvNPr31/SOJGDEySkxtponINTU9xdNAQlb4EiGj
	yxa30DtWl1/G0KiKf4zzbmuijNlc7djkholA1znba9WPjDioIcZT/Bbjy732hSGx
	sARxuaCJPRgWcTBMxNYoBWUqEwuITX+Z/U+HUE3cg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ypme6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:57:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SEkB4k015250;
	Tue, 28 Oct 2025 15:57:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08cgsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:57:14 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59SFvDAa009896;
	Tue, 28 Oct 2025 15:57:13 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-56-75.vpn.oracle.com [10.154.56.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a0n08cgqf-1;
	Tue, 28 Oct 2025 15:57:13 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 0/2] Multi-split BTF fixes and test
Date: Tue, 28 Oct 2025 15:57:07 +0000
Message-ID: <20251028155709.1265445-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfX7c4LLwesufsH
 1yAw+CSJWskht+D9qtztVv+xwE9v+Lm7UxfjOLfA2pZpomp0Wdzw/Fk/xLtUxw3J7gEkh+or5OB
 PXb49ndsMaUa7RxjHFbkVbOvuPrgyQdd70wwlpWpipnS6ZlHdRpxshHyPq6IPTdt9hr7m6yOiNu
 B3EFWaDweEX0hrqGXmArrLo0qcrOXMztJjw9yEeWQ/KUSwBe2sqvmd9qT2ytnfd3f1z3LO7UpjG
 icgTy27hml4QS195dNDOrYoT/PgpGjQK80sNNahWE2xzh08Xkei5o0VXPCxjHbduT+a9641roUM
 27KmDffY9NT8+TYb6aSoRpauZuHFERCOzrpR6AHmW5Pm6qlA6AWSr6GqCHGi3JMEfZh1Ef13T8L
 WatUjhlL/x1bxIDMb5pF7snix7upOA==
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=6900e7db cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=tF5ihoDdPAHooiK521IA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: KnPoBR8IDnKA4diviz5ynCL9Fi81ZgUp
X-Proofpoint-GUID: KnPoBR8IDnKA4diviz5ynCL9Fi81ZgUp

This small series consists of a fix to multi-split BTF parsing
(patch 1) and a test which exercises (multi-)split BTF parsing
(patch 2).

Changes since v1 [1]

- BPF code-review bot spotted another place that the string offset
needed to be adjusted based upon base start string offset + header
string offset.
- added selftests to extend split BTF testing to parsing

[1] https://lore.kernel.org/bpf/20251023142812.258870-1-alan.maguire@oracle.com/

Alan Maguire (2):
  libbpf: Fix parsing of multi-split BTF
  selftests/bpf: Test parsing of (multi-)split BTF

 tools/lib/bpf/btf.c                           |  4 +-
 .../selftests/bpf/prog_tests/btf_split.c      | 71 ++++++++++++++++++-
 2 files changed, 72 insertions(+), 3 deletions(-)

-- 
2.39.3


