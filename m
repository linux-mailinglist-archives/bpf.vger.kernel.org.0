Return-Path: <bpf+bounces-76728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FBACC4A43
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A023061D63
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B430F538;
	Tue, 16 Dec 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QcsksXkW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8A26B95B
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905644; cv=none; b=DUsqnMicOJz2dGFWuwZZASFhqNvV32+ZwwiF3RB1j6Zc4JZdOwKQpHNydNtuvZmhw0wA8X718nVVE+M/s7jtPJn+tiFM5YECO40Nkf6mnCTV4RQxvBIIwz2qVLPkwlP7l7BuQxXkJRHSRbl96ZAzJ3OefsRlAVmYl8vQrm5GeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905644; c=relaxed/simple;
	bh=uKyPtuDYRRHp6Nq/MlUVAjy+hEoX/Pr7VOAV2p9gT1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsR8A2YtUUWvn0d007YbaipgHrxLajQkax0mqK1Dv+Vbqdpo2RvndfeLUsmfKP0aycL8gEAdAiB3kkpDeIvDBlz/SjGq6yHBuCw6/pEAPyF+rEfpsQNlJE5jgQU0/ycZRnO7Z25jK6VTUeF7QtETCfGjLVziF+6NsmyV1OdWHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QcsksXkW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGDuLC1374205;
	Tue, 16 Dec 2025 17:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=0qZDZ79fqhXgmN5YkWJvqDIGvePl6
	4ExuYpzeJ79j84=; b=QcsksXkWwwY0GJZB+EwDr1HkP2hjhTHPHzG6V9AHjOPzc
	/spCOfHv3+agj043di+KXxC3iCKazzXgrpqFgVD6n6xxJrcef8AE1vMqwE+caWh3
	DNXQvD4pgX0NZ/e7ckb+ZhqIsyPK3DgNqjMIOq98DExbywCxRPzPhFkk9MOvZsXp
	aAOc8PAGsUi08MQuZzUb+3spnncBczcqSLB2oAtGamsuSOL3x3Lg1ZaRj4L1kdhw
	cXroM6WCPOK1ptsKOZB30P10OAcHw8GZQ5bqCt0xPBdicLhVgrdgLdwbFqPFjD88
	BYisogRhrW6hF77CD8ZZClqjaNzjptzbiP3YAU8FQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xqxvey4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:18:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGFmSsC005928;
	Tue, 16 Dec 2025 17:18:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkdgptj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:18:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BGHIvZP039632;
	Tue, 16 Dec 2025 17:18:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-156.vpn.oracle.com [10.154.50.156])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4b0xkdgprs-1;
	Tue, 16 Dec 2025 17:18:57 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/2] Handle -fms-extension in kernel structs
Date: Tue, 16 Dec 2025 17:18:52 +0000
Message-ID: <20251216171854.2291424-1-alan.maguire@oracle.com>
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
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=917 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE0OCBTYWx0ZWRfX3dln/QIgCSWY
 5wLMSlIWGVZhT8dDddi5SBRDar3Bi/oJRufG7xD892G+MNZ/t9JHt25eH/umJTaiz+E/qO8lVum
 ziwWTD8XDFFroOYgfXXR0elJrA6snweJ5GzVkST4dK/VlDcBjwb4mqXCM/1SRoIj4jfH/Z0k8+W
 /mMWOGwH/5dEqSYB4cJ/T6ZaFl04m9tTlcRolrmF6+lj+s+I2UKaRVlCWs3o4LtQcEGH5Avh94Z
 HcIEHTdw26+MrS8U1/+OMJ0g6Vct4v8OFtu4fEryQZLZls/9awEhd0b+uSzLNhWifnOnFJ6+3AM
 woTIFI8bS6ItAuTQNB6MVK/6yZUq8kCd67ZcMzfPN3GpS6DgGXqW3cNhpZtIlQZFGUV7IeDc0K5
 ui9PcyZ6coKkyb/bg3l2oCiPb76TeJzQhGIRUHHI1L82Oytpmuo=
X-Proofpoint-GUID: rBYhLbXYyt0tqslDFgNo5P4av0lCDKBW
X-Proofpoint-ORIG-GUID: rBYhLbXYyt0tqslDFgNo5P4av0lCDKBW
X-Authority-Analysis: v=2.4 cv=BYDVE7t2 c=1 sm=1 tr=0 ts=69419483 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=4U32NmAA7IdqOqh1_S4A:9 cc=ntf awl=host:12109

The kernel is using named structs embedded in other structs
with no member name (similar to anonymous struct usage).
Such an arrangement causes problems for compilers unless -fms-extension
is specified.  With vmlinux.h generation we do not want to impose
that on the vmlinux.h consumer, so generate a compatible representation
using anonymous types.

Patch 1 adds libbpf support for this in BTF dump code; patch 2
adds bpftool support to use the new option.

Note that this was essentially

Suggested-by: Song Liu <song@kernel.org>

so feel free to add that to the series.

See [1] for more.

[1] https://lore.kernel.org/bpf/CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com/

Alan Maguire (2):
  libbpf: add option to force-anonymize nested structs for BTF dump
  bpftool: force-anonymize structs to avoid need for -fms-extension

 tools/bpf/bpftool/btf.c  |  4 +++-
 tools/lib/bpf/btf.h      | 25 ++++++++++++++++++++++++-
 tools/lib/bpf/btf_dump.c | 25 ++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.39.3


