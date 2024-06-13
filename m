Return-Path: <bpf+bounces-32057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26EB906953
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7018528697B
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D2B1411CD;
	Thu, 13 Jun 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NGSU2yzI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77211304AA
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272275; cv=none; b=qGVAkgh9N5DQctMCaKemRLV7HPYX/q7cYCaUeKCWIfk6Og7EXrjnK8Ff7FBnKzNPmpd0i3SJZw1a0Gx8GXqgg/KH75biBoEcJYA5FRnSKCRUcCeZP2Bg9bNnlWCv0iA7nq6ZPdr60TwVkvGJh4OcXP4ilBRSkg0F5q7ZmjcPAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272275; c=relaxed/simple;
	bh=wTN4tIEi7cWRV7PbinhALrFZyxfwQiuzeC5eGQ0iW/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIZJcRDWOpfqM3pXdwPJwZhD9jzJqXqrimInRcSc5UhSm1Od8vddPNqh16ftPupw4lOJU76zP0a9EN7dD2f/au1mNW3R9nQHe5CINyl3wCC2VAcIE7V7x7iqxwY+tzpNMCF88gS/PeRyEMe+Dz5MepCNbbwE0qqzBhYtMmRWiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NGSU2yzI; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7tSNY015056;
	Thu, 13 Jun 2024 09:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=x
	BHVOk/SLAV3IRXVtEbJcbhdY79vSdPliGCnTrlM6y8=; b=NGSU2yzIaufNmSLwM
	gyKuGBmTTAilQ2kmwPv96lNIaaZNle9Hhyq5+RRgpqD+sPrAwdFrjcVKaRf0QpIX
	LwhW+odIdeOirZuzwXpNCSdmwERzOLZZRqrxWqyNpu1r6jzmgJOaf6GQHQFT+aMt
	CfYcMXOzM5zuzWmf13FI5cfXCs3SbGqnE7UndlqCrPN7EK9QMmHtDxrjP0fZ6e3L
	pCP5yr3CZ5dza/dD/K4IuoZfuInGP1AUccsBhzDg9rKzoC07Bp0/K/zPj9AFI2l+
	Z4+IehG9J8NLrGuC5Ujz6aiivYjgHCAJcWatrquG9qHmlhKYCl6UPEaYMffGSODW
	WXZqQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fs2f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45D9C2kI014346;
	Thu, 13 Jun 2024 09:50:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncewnmb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45D9oJq2005489;
	Thu, 13 Jun 2024 09:50:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-187.vpn.oracle.com [10.175.212.187])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yncewnkqw-7;
	Thu, 13 Jun 2024 09:50:46 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 6/9] resolve_btfids: handle presence of .BTF.base section
Date: Thu, 13 Jun 2024 10:50:11 +0100
Message-Id: <20240613095014.357981-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240613095014.357981-1-alan.maguire@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130070
X-Proofpoint-GUID: LdSqoSdMMtg8foxSuURWX5Q8PrILbb1e
X-Proofpoint-ORIG-GUID: LdSqoSdMMtg8foxSuURWX5Q8PrILbb1e

Now that btf_parse_elf() handles .BTF.base section presence,
we need to ensure that resolve_btfids uses .BTF.base when present
rather than the vmlinux base BTF passed in via the -B option.
Detect .BTF.base section presence and unset the base BTF path
to ensure that BTF ELF parsing will do the right thing.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/resolve_btfids/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index af393c7dee1f..936ef95c3d32 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -409,6 +409,14 @@ static int elf_collect(struct object *obj)
 			obj->efile.idlist       = data;
 			obj->efile.idlist_shndx = idx;
 			obj->efile.idlist_addr  = sh.sh_addr;
+		} else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
+			/* If a .BTF.base section is found, do not resolve
+			 * BTF ids relative to vmlinux; resolve relative
+			 * to the .BTF.base section instead.  btf__parse_split()
+			 * will take care of this once the base BTF it is
+			 * passed is NULL.
+			 */
+			obj->base_btf_path = NULL;
 		}
 
 		if (compressed_section_fix(elf, scn, &sh))
-- 
2.31.1


