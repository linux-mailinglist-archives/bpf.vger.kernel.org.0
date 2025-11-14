Return-Path: <bpf+bounces-74587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA7C5F826
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B48A35C9AD
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C5313522;
	Fri, 14 Nov 2025 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OfomUf3q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60B309EEB
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159006; cv=none; b=h6j0je27J+w+pTNugozfIVygUG0IImJd7liNZ6g7A1zUzhDx2oQte+MAHOVwv64hPFYubJZDPYmi2RQSl3UyFnTmQdVXFdbVGN5t/CAMF4wSeiUiwX51nsQFmSbrBkaoAXwx7FOm2X1zW9y7PteU2FYDgP1NFRkoEX2RFnuXWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159006; c=relaxed/simple;
	bh=iCDEektsdxDzSqSp/sHDUzS2rZ4hlSOazoEM5nbwbBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCEyDzcJAHWc8e72NNXdV0W/kgDPYfq60vOEoKKcPTyPVk5BJ99mupYLAUxkg3ioh0ndj4ov8ME0cvZ+gbg1TGxCoJcRNY906sE7phmZDtY9n+BUmd6qTD5HjAMfJ+AsFofTO01/tvO3ZiKTlVOI/BybNSpNEUZJtOC3lNF3lH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OfomUf3q; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEJuTu8029280;
	Fri, 14 Nov 2025 22:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7nr1PwNQAnW5H2nJz5B0tBmEo2sYU
	rQDtvajrbP0BmY=; b=OfomUf3qldFZcrYD/YfYPggNQluVIvgH+nqyBC/UtvWW+
	jGTxoFEkAQXEDVDBEV7rWR559L0cg9fQ9t0QWbLHn3B0WkZa+qVaYvQ1KqyBLwto
	G+Di7JT1xqx2yeEL0pttVLaiBhGQdrJVBKymQNaSq09AcQa7EUl89NlaFnFpvXd6
	/26UxJwFron4D1Ln19wG9S58AbdyMEHjRyo5d2a3AhFDSgNn3QTsiRovYN3Gpy4K
	Rf15koX4KX42uYdSrMUdrKkCjYj8JWFFJk+okWorl8WIO6aLYjOHGatvENeGThiN
	qo77YLY+piWorPfTvvduIxBiA709Vl4Z6qXZFnWVg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8uj17d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 22:22:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AELR0DP039056;
	Fri, 14 Nov 2025 22:22:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vae2t8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 22:22:54 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AEMMrlg023375;
	Fri, 14 Nov 2025 22:22:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-34.vpn.oracle.com [10.154.60.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vae2t7q-1;
	Fri, 14 Nov 2025 22:22:53 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/2] Ease BPF signing build requirements 
Date: Fri, 14 Nov 2025 22:22:47 +0000
Message-ID: <20251114222249.30122-1-alan.maguire@oracle.com>
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
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=572 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfXx/7n/28eG4ZD
 aJBOhPNJSHSiqX2G1FObGgv+Ks0VvB/xg2zYF9UyZqBbSah4WmmcQq5sTTyO5HQ5RcvyjZnIMHv
 EOEBD+/jA5/zKElFt0zVkxls7G6BM/Kw/rS/djMu34dW4aiSpckMnmu4fjhB/F24SS38uCSsWJb
 rztDQBnr+BnFXcm/uMVM3jchYfiiTbeZhU0ftL573jRAD/tP4NAf8uO01ErHRNQ//g5LQjtfzC5
 N6M1EvTmjr5pcBvGEwjNqD+SYKUGWibd4lcZcZO75WbjjygIVnOJVuBONwHdqLlkEYJUG1rDDWP
 4DOek4Lto7d8PIKTuNSBnTZfIkpyB8pvCNqn0KLsIC/QtSkwuYsF5HaHeFGR6xpmWkRaFaWeylW
 bB5etGhKO2W+GpPaQ3Uat7RH9kvohA==
X-Proofpoint-ORIG-GUID: 7LV3VpdG4b9DGz3u0Xe5qjs-k0J56LvS
X-Authority-Analysis: v=2.4 cv=FKAWBuos c=1 sm=1 tr=0 ts=6917abbe cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QA6Lw3nylWgmMF2CQhYA:9
 a=zZCYzV9kfG8A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 7LV3VpdG4b9DGz3u0Xe5qjs-k0J56LvS

This series makes it easier to build bpftool and selftests with
signing support, removing reliance on >= openssl v3 (supporting
openssl v1) to build bpftool and not requiring latest xxd to
build verification cert header in selftests.

Alan Maguire (2):
  bpftool: Allow bpftool to build with openssl < 3
  selftests/bpf: Allow selftests to build with older xxd

 tools/bpf/bpftool/sign.c             | 6 ++++++
 tools/testing/selftests/bpf/Makefile | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.43.5


