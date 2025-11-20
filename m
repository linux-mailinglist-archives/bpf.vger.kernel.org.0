Return-Path: <bpf+bounces-75144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8BC72F2B
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 09:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 32038289CB
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92930CD87;
	Thu, 20 Nov 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FXMuqgTn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF52D29B7
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628507; cv=none; b=ZkdpjOBtj4THHnQnkVh3Oygke2+2EGwvjD7HdfPYeHAJplIHfdw2E6527/rkFoznLFsIki8TpM0Pxtk3GHBFNOM7xR+AaK2eE4r1U4PQE/USobwxJ4b8ieSppS9w+yKOvcIEnub8wvNSkNG56ruXI16zAbAvhIOMLrp/eAb/VIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628507; c=relaxed/simple;
	bh=yWvO1KzEYrbKX06F8hHirhlEjBGMt9iZSYN8GtTkNMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0u4439ZhBw5lL00OB0CeEKG4taFJZqoWAOt6zXCZJUV4MQwzAO9u5RcVYReB8BhW7mncEHFRiDoqmL3M/UCoo4Z8lGez/pBRVJQAK7NTCiVHKU8BnrPwHYXzlSKI+/P2rct3or4sSrmY8aIdXYhgIZuq9HAw8KoIhuKqLVMQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FXMuqgTn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK1NF78007070;
	Thu, 20 Nov 2025 08:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=mut73SkUTQhNHOtQ6r8LVcVZkJGFk
	HK2FBs2NRFLKDU=; b=FXMuqgTnFLk9+KyJlaOcXYfJCtvprUmaps2T5bConTVne
	0gwOLUmDx5O9nbj/TmQyYZXa1DwWpiamWvYlCsCGPZNjFLrokMyA6KZ9px7JAlDr
	B6X18bN1yzGKTiDTDrJYB2DMyZ06VE4MC6g8Cz7fDVvkTVbdA+TfweLPWIbssFCe
	Fk+aLGD7yKLE42RKpDb4PJ184Y6QoiMg5t0fct3mvb+GagCxGUJqTjgGy4nfgKFz
	p7I7GEjudaUQrNv8UDOXZwHvF3goL3DrECHyebjtwKy3sm1BGQfAOIj00EXJ8h/o
	QTedyu0VG5JOWUxkvbZFjDTVsh9wWUcvF2FU46iNg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j8pbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:48:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK8kfsP002529;
	Thu, 20 Nov 2025 08:47:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybrp7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:47:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AK8lwDR007208;
	Thu, 20 Nov 2025 08:47:58 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-185.vpn.oracle.com [10.154.58.185])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4aefybrp6k-1;
	Thu, 20 Nov 2025 08:47:58 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, sdf@fomichev.me, yonghong.song@linux.dev,
        song@kernel.org, haoluo@google.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, john.fastabend@gmail.com, eddyz87@gmail.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 0/2] Ease BPF signing build requirements 
Date: Thu, 20 Nov 2025 08:47:52 +0000
Message-ID: <20251120084754.640405-1-alan.maguire@oracle.com>
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
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=684
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200051
X-Proofpoint-ORIG-GUID: 1IJ-fce9dbN6VqPS_SkJorU4P-iVTU5J
X-Proofpoint-GUID: 1IJ-fce9dbN6VqPS_SkJorU4P-iVTU5J
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691ed5c0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Gw4jZCU0mW2V5OaeerQA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX0vZ0rcvsSLNE
 gJwOM5p2+tMsbIJBf3L0+Ny/0roHhK6irIQalIf3p6S5oHqcc+XG7ycDL5a0eXEuGESMyATAUwZ
 9qrzf7l+w8q0M+wOcW1RjRQgasUZvn1MOf+XHSxRMhfLS6NsVX8mT7FebCpasJi8YEe87ZUw+mg
 94sqrU005NwZdI6OQxvkFPbhPGoUrG1J59T8OdY8CCZEvvpRh5rVO45Ywk5xJKzmRxp+65+hAtO
 gWSdtIAy3c26DC3h+PoH5OuiAJCoQIvn3UJ21dB0fEGZpUMwd3wtJo1EwprL23yw9XM3LOeklWG
 S3cY20eKKnC33poJXj0yxZwFRZxElLD98vMFKo1GEm9xMfPi4JLSoEbAHI8Oh3eQc8pzxh6LdKD
 i2qGPOOCX+Wv14/wY/inAdlZK/qALQ==

This series makes it easier to build bpftool and selftests with
signing support, removing reliance on >= openssl v3 (supporting
openssl v1) to build bpftool and not requiring latest xxd to
build verification cert header in selftests.

Changes since v1 [1]:

- Updated patch 2 to add symlink test_progs_verification_cert to .gitignore,
  EXTRA_CLEANFILES (AI review bot)
- Added acks to patch 1 (Song, Quentin)

[1] https://lore.kernel.org/bpf/20251114222249.30122-1-alan.maguire@oracle.com/

Alan Maguire (2):
  bpftool: Allow bpftool to build with openssl < 3
  selftests/bpf: Allow selftests to build with older xxd

 tools/bpf/bpftool/sign.c               | 6 ++++++
 tools/testing/selftests/bpf/.gitignore | 1 +
 tools/testing/selftests/bpf/Makefile   | 6 ++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.43.5


