Return-Path: <bpf+bounces-33424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFD191CBFE
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 12:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22871B20E38
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708C3BBCB;
	Sat, 29 Jun 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FOV01QtZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D43803
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719655296; cv=none; b=slC8e94XAJU5Z7ciatMmZpkLftXnlmL/ZMixn8Kv7OLsEv8253UYMRoamW2sk6FIX628ValzgMAWfsB5qYD/YGlvDuGC4yKCR+HPWHgXSiNSWDCZYoNvqWYT7QN0pwqOeGhEjdA1m4OeILh9TCqbw7DTctM6vJ1L5G2SUnrMKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719655296; c=relaxed/simple;
	bh=Y1GRrb6d1e6ncHde4e5nAXATENNYDhBPvQ1U7JhpJxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dL/QtcBGpSgAAhLBG8qlPotQq80YxejdMPI9L5CVh999+IvTVZ9VY/ccZB8Msp07f/q4VxLCnlxWqUwrwJfymIZfyRxef1JlexBjMhxYcaNyG2vjVhBCheemZNCMF8h1bjsZPMhT7sRcHPw/x/oRzbxJaUxpvjsuloFsQSN64Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FOV01QtZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T4j09m028509;
	Sat, 29 Jun 2024 10:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=aQ+MVN2YE5G3if
	66ZfqLH+sxs3o7L7Gh/6UgKjHj4vA=; b=FOV01QtZnBtguvGvEFIBKmr/v4PULJ
	piIJNsYDpv+KtDTZMdxikGpFkYqt84762alwMjLhCW4RsEB2vG6AW0Mv5NxF/4A9
	4guVT7TWmbC4u2YDBZgBcZ9LBr56PmiPcM4pufYB+VyIx83Czyqwf5ZA6qq2uxZD
	4d6qb7JIy5FPiUfGgQEBxgBNkhSJxzomc6zjHD3Q/UX6y3BTvxPyLd+StPs2XYGP
	BEk0kjKXFgn2utqdOWNnOkBVDrAf91jDi7qS4XeVOAwp5tj1yGYUjAOzs6xiykCY
	fjpejJvngMa72OvQ11XaYv78UTMA59qamI/Y5Mo2fAMDRL5bG8lSg1xw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59093p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 10:01:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45T627nE019066;
	Sat, 29 Jun 2024 10:01:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb73jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 10:01:02 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45TA12ow024698;
	Sat, 29 Jun 2024 10:01:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-222-155.vpn.oracle.com [10.175.222.155])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4028qb73ha-1;
	Sat, 29 Jun 2024 10:01:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] libbpf: fix error handling in btf__distill_base()
Date: Sat, 29 Jun 2024 11:00:58 +0100
Message-ID: <20240629100058.2866763-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_03,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406290074
X-Proofpoint-GUID: 44NtOmmv5W8SyxmQYe5WEHjCbWuBSFjC
X-Proofpoint-ORIG-GUID: 44NtOmmv5W8SyxmQYe5WEHjCbWuBSFjC

Coverity points out that after calling btf__new_empty_split()
the wrong value is checked for error.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index cd5dd6619214..32c00db3b91b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5431,7 +5431,7 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
 	 * BTF available.
 	 */
 	new_split = btf__new_empty_split(new_base);
-	if (!new_split_btf) {
+	if (!new_split) {
 		err = -errno;
 		goto done;
 	}
-- 
2.31.1


