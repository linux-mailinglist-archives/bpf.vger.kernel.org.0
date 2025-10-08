Return-Path: <bpf+bounces-70606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD530BC627F
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E41882DBC
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2612BF005;
	Wed,  8 Oct 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TwaZNNrY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1F2BEFF3
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944962; cv=none; b=gtBKiL2ezt9HpJIpvPJd6hKUKlOByjD3orjJd7TdhXk4IzYcRlG/krYItXyOsMUe45qxrzmoYxm053pM3z3xzCxqNLzy2DAZcai+lWtutrugq+1eNTrsjUvWdvRi3xCl7dXxgD4hc3XhS3g8rOWfVXmvXLfuP7VMAf9ba3ATCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944962; c=relaxed/simple;
	bh=vdkclYeC+6E542zG5TERjCOOtXSFciaesuYsroKXwhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfBUiOsdUxxWrmjZnF84AkhUwYai4FS7HO2X0KD7boS4TTxc94wJSecP67ZlZD8jybsCqSe38g8jIVUWvEu65KFK3ZBJVOyPX4Mwbo86s6Vk/hx4oSVomszzR2EpQrDMbQ8HPbIOVEDoUmX42++4ftO/Da2ju69wUS6nbQK3Acc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TwaZNNrY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HEV3H000390;
	Wed, 8 Oct 2025 17:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=g54Bl
	KBmd/nl5S+l/QOPRx2rlqTWFlshBo4H0/w78lI=; b=TwaZNNrYVsWlp7tnldPKP
	DvuOMxSGdx2xtZyO2TLMZsB5bT3G+qJnURJA9O8SNPfC77uqAfGKC1xrtG6I0mIc
	kGfy++QDn9sOTvbwiMqJIrUzFED99odDqUZVPduHRyvlxr/hmGN6if8GU8bSdwsH
	D5nC3TrLLm9pfy7rU+7BWdKQWlQG5d0rHwd38+qYeDFWG1cHiB6naCIchs3enEQH
	ksMt0cQKIx6atUFki7m3aP259xPz6zXyddRHJLT7MQ+COe/tBvVKkk6Y8+gvbi3G
	a9MbX7Xarg80MEUZCkWmWDp5OyW3U02pUBvqsTIEuSUmtIGSqthfpwZARVycESGx
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6br1bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDt3j037061;
	Wed, 8 Oct 2025 17:35:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rpwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:32 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFUs031138;
	Wed, 8 Oct 2025 17:35:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-7;
	Wed, 08 Oct 2025 17:35:31 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 06/15] bpftool: Handle multi-split BTF by supporting multiple base BTFs
Date: Wed,  8 Oct 2025 18:35:02 +0100
Message-ID: <20251008173512.731801-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e6a0e5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=capUgACyIe1tkfN0SNgA:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: LxIqDmNU6WAWxOLye-F_PsvYBWDFGZPW
X-Proofpoint-GUID: LxIqDmNU6WAWxOLye-F_PsvYBWDFGZPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzas0ProKGm4u
 or6s+7bUwhjxfqf/4gYcsgSy4TRY2iWG4H0D4+3vBmp2/FEFjRPhwic+TE6nZ1GulYo9guMyG7r
 JicPsY1yBMhcoStiXpZk8OI8dftGWIfU+uvZnvKom0CPxVvS28vPZzoo2Ej5ebmSWD2zklGyNHj
 ptuu22qtbkFiYcy7Fbs0XjdwADempFzQ76gwZtW+UyILPqiPCMzQESaTkuEqQwYVilHy6+pVZM5
 Alc2JGXCK4/OKQtbWQYXcZRVL8rROZSDmt/owyV1IhcYXEN8ymrwR2HB4jhfqIakPeDfuM5wKnH
 T86bMh1FmMV6RrHn1CA4t1Y925RpzBEB+CZXgtWi94inDMFkzY+lwnyMlmvzsOTZo3jdpsIS+ii
 PBevbZbqXBMA5/qHQAQlI0n2i0YxjXksCjvZ45V4OVTOmD0Z/w8=

For bpftool to be able to dump .BTF.extra data in /sys/kernel/btf_extra
for modules, it needs to support multi-split BTF because the
parent-child relationship of BTF extra data for modules is

vmlinux BTF data
	module BTF data
		module BTF extra data

So for example to dump BTF extra info for xfs we would run

$ bpftool btf dump -B /sys/kernel/btf/vmlinux -B /sys/kernel/btf/xfs file /sys/kernel/btf_extra/xfs

Multiple bases are specified with the vmlinux base BTF first (parent)
followed by the xfs BTF (child), and finally the XFS BTF extra.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index a829a6a49037..aa16560b4157 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -514,7 +514,8 @@ int main(int argc, char **argv)
 			verifier_logs = true;
 			break;
 		case 'B':
-			base_btf = btf__parse(optarg, NULL);
+			/* handle multi-split BTF */
+			base_btf = btf__parse_split(optarg, base_btf);
 			if (!base_btf) {
 				p_err("failed to parse base BTF at '%s': %d\n",
 				      optarg, -errno);
-- 
2.39.3


