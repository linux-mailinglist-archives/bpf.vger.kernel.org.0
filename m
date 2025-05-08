Return-Path: <bpf+bounces-57753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27208AAFB38
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA964C4694
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0222A800;
	Thu,  8 May 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GBq6Lzks"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCCC17BA5;
	Thu,  8 May 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710581; cv=none; b=SETV/pheiHAngO/DqppnFbBkIvL+qMrK1sTh4re7RxIxumIovXykKvGomOVvEUxAI72JmjheuR7njvUD/gtSS0xLaC8nL5Gnlw17ZfLhCArOqnAno0Iff5BizCEhpX6o/9KenQMuPYbZn3T52TP02Y9jN5cDNuWtIz52vuOEc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710581; c=relaxed/simple;
	bh=UxJOqCbbzUBkE2SE3OZT0jv5PUQOk/QsXezrDsZp2lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lmPjNmybzPoiJv1a0/P51e3Kuvk3jCO0D14Hyd34IpCt7BloEHQ979m47/BwGuNDld8LztWjaq/szn/xTRrzOTr68XFLKmlccYQbPzXu6uoYs+jfEbh22lbxIoBiCDJKL0DTc66783AmPIzCbytzEW+zFI+7rh5R4giRL3kTHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GBq6Lzks; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548DCIbk003664;
	Thu, 8 May 2025 13:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=tWqiE7mUbEZx7KuE6cfvjk4yvwZhK
	5C/gXWPt5+QTGg=; b=GBq6Lzks2s4YSSaEgI7Foyizp4qI586U3NiMqWVjCpAJT
	KIFockvzdVBa6SB8Cql4262hGbY3jGeTCi+tYlcNCgT9hy3kxBs/unBfPxPNEsLr
	qGjAYAVKJtK3b/0/MVY3vVar0qiT8G104bt9lmz0u7WUgYq1pHdRVgXDKV4F/ymR
	MieyPNGcR5zRdiv7gHYrEP5mjnIykZWw9qCByRlAzkchDv+6ZbCBjZn+wueLgwgD
	Tj+z4aKTovS2e9+aVQQFDn7SizA4Edik4KyEfFuc2KRHaKxbP/nYhPnDT8Udpetm
	SGh75PRZU2LdY+285PKbJK4+/rdghu2bkuh6jCKTw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gw9nr0ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:22:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548C6l7Y035564;
	Thu, 8 May 2025 13:22:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kcedn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:22:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 548DMgb7024112;
	Thu, 8 May 2025 13:22:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-49-250.vpn.oracle.com [10.154.49.250])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46d9kcedkj-1;
	Thu, 08 May 2025 13:22:41 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
        tony.ambardar@gmail.com, alexis.lothore@bootlin.com
Cc: eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
Date: Thu,  8 May 2025 14:22:34 +0100
Message-ID: <20250508132237.1817317-1-alan.maguire@oracle.com>
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
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=716
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505080112
X-Proofpoint-GUID: 5eZR7jLxYmuuHlbe47f-t6XWT1WU9KAb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDExMiBTYWx0ZWRfX9N4DQJSKWXH5 /gSAOtx3OeQ3QOyobOfnjrEk9RUhNsmfcHVzW4uOZmPboosEzMX2D+ah2cdXFGWiE7y0Wlegul4 pA3G86jRFiuakzVW/3yRUWh27BfMCGY1ToxLClvXrP7o0qkUzPdkHJ2iApnsdpqHa4/Wz5KjXQB
 qosghYhbb3EMUDC93fUBvoosV2aUjxj+fQCsKLVV97bsZyz4iC73PgL/GgAFmpMRaI/ZCTy06lR FHBMzfHncR1bqlS6d+AxZmEinbRkNyDCsL1UZ648om+NVDQFVquYHrXeAzmmyBdJHepJVJUXois Rq8NoGMG5uMvua/Edxnh6SjXY7s6+25QwUZjJtY35+L8Ob35WyfGeva9iBQy/rOKNTzAcWzlDP+
 usOg79Cn8fUtWXQbZc3O5W1ymrdVz3XYANg8FZHZQwO0x7Xiz0OLXZpmjPsK5CRWWJEXezA6
X-Authority-Analysis: v=2.4 cv=SKdCVPvH c=1 sm=1 tr=0 ts=681cb023 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=6g8IY-ITpH_eT7mAbvkA:9
X-Proofpoint-ORIG-GUID: 5eZR7jLxYmuuHlbe47f-t6XWT1WU9KAb

When testing v1 of [1] we noticed that functions with 0-sized structs
as parameters were not part of BTF encoding; this was fixed in v2.
However we need to make sure we handle such zero-sized structs
correctly since they confound the calling convention expectations -
no registers are used for the empty struct so this has knock-on effects
for subsequent register-parameter matching.

Patch 1 updates BPF_PROG2() to handle the zero-sized struct case.
Patch 2 makes 0-sized structs a special case, allowing them to exist
as parameter representations in BTF without failing verification.
Patch 3 is a selftest that ensures the parameters after the 0-sized
struct are represented correctly.

[1] https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambardar@gmail.com/

Alan Maguire (3):
  libbpf: update BPF_PROG2() to handle empty structs
  bpf: allow 0-sized structs as function parameters
  selftests/bpf: add 0-length struct testing to tracing_struct tests

 kernel/bpf/btf.c                                     |  2 +-
 tools/lib/bpf/bpf_tracing.h                          |  6 ++++--
 .../selftests/bpf/prog_tests/tracing_struct.c        |  2 ++
 tools/testing/selftests/bpf/progs/tracing_struct.c   | 11 +++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 12 ++++++++++++
 5 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.39.3


