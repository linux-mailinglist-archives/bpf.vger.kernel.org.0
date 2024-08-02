Return-Path: <bpf+bounces-36295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B62F946087
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 17:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3631F2207C
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3EC1537B2;
	Fri,  2 Aug 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mS886OoZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19342136351
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612606; cv=none; b=Ae8eiyfUbGmTdsNHtXChGfTp5Y0V/TFSVGuDa8m78DYrnO362Brbp+5U/gCIxvHGYO+acaFaZr7N7jR+dvvfvHlMTPMRQiEW1SJh4sYPnp3nKWHKA0VK9qH166XbRs7YwNIeop7wWcJDvjT4E2a2gcdD2UbbSpan0H4utp1W0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612606; c=relaxed/simple;
	bh=0vRGRItXBV1uaBq7KDbZfpLL5rK8BysppsQqkPsrPHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tC1VwHfS/UC4JVfZefZpLdg9Y9bc5KvWQpIjtQ4neFFQE0mOQ6TMgNYQe67KwdHzcAvQTAwK9QE2B43Jz4o6LZ2eZpntbZ9nTJX9MSZJKToD/BKd3ktLzWpzdRArdezMwJ/0BZa6JOLoxsHwOo9bjMAp+a6PSJ7XQPmdQn1FCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mS886OoZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472DGRjY015418;
	Fri, 2 Aug 2024 15:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=zK7kd2lOLLuhCz
	Sym29qXUOihVIZJJIdIIRp+l/OQF0=; b=mS886OoZDUflFMks7iVix+nqjdjd9o
	CGUeNHDKRUKHuz7pi1H9o5owDNIxZ7ywK6BRM7N87T9jx7/0AqSq+xpIdMQjb/AX
	p7AAhKGkpBHH4IRCxQuNnUT//4duCPDMRPNhwHQoEl8PP0YpdGfSCbw+f1S4TaEC
	q+HKw9v6O6FMj9X4ig64u6z/9Yak4h8K0f8nKv/JDUbn+41O50XiFSy7LFcrDiEM
	YaQxmQH6v4Pe2vEH1OtEN12fk+3fnG142/rAatgRwOa20J1hOTy8yvNIojd2hE8I
	kDXVrhQZidV3yOehaWzDArF0d0GyMiz0TRn3mygfvVIVCmoNoTnm0NWQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rje8hdts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 15:29:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 472E3JSe001864;
	Fri, 2 Aug 2024 15:29:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp1rhd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 15:29:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 472FTYgV035653;
	Fri, 2 Aug 2024 15:29:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-223-234.vpn.oracle.com [10.175.223.234])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40nvp1rh9t-1;
	Fri, 02 Aug 2024 15:29:34 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/3] add TCP_BPF_SOCK_OPS_CB_FLAGS to bpf_*sockopt()
Date: Fri,  2 Aug 2024 16:29:26 +0100
Message-ID: <20240802152929.2695863-1-alan.maguire@oracle.com>
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
 definitions=2024-08-02_11,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=857 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408020107
X-Proofpoint-ORIG-GUID: PvZQNBqQZDl2i-GIVJ1i6EfYqKokns7X
X-Proofpoint-GUID: PvZQNBqQZDl2i-GIVJ1i6EfYqKokns7X

As previously discussed here [1], long-lived sockets can miss
a chance to set additional callbacks if a sock ops program
was not attached early in their lifetime.  Adding support
to bpf_setsockopt() to set callback flags (and bpf_getsockopt()
to retrieve them) provides other opportunities to enable callbacks,
either directly via a cgroup/setsockopt intercepted setsockopt()
or via a socket iterator.

Patch 1 adds bpf_[get|set]sockopt() support; patch 2 adds testing
for it via sockops and cgroup/setsockopt programs and patch 3
extends the existing bpf_iter_setsockopt test to cover setting
sock ops flags via bpf_setsockopt() in iterator context.

[1] https://lore.kernel.org/bpf/f42f157b-6e52-dd4d-3d97-9b86c84c0b00@oracle.com/

Alan Maguire (3):
  bpf/bpf_get,set_sockopt: add option to set TCP-BPF sock ops flags
  selftests/bpf: add tests for TCP_BPF_SOCK_OPS_CB_FLAGS
  selftests/bpf: modify bpf_iter_setsockopt to test
    TCP_BPF_SOCK_OPS_CB_FLAGS

 include/uapi/linux/bpf.h                      |  3 +-
 net/core/filter.c                             | 16 ++++
 tools/include/uapi/linux/bpf.h                |  3 +-
 .../bpf/prog_tests/bpf_iter_setsockopt.c      | 83 +++++++++++++------
 .../selftests/bpf/prog_tests/setget_sockopt.c | 11 +++
 .../selftests/bpf/progs/bpf_iter_setsockopt.c | 76 ++++++++++++++---
 .../selftests/bpf/progs/setget_sockopt.c      | 37 ++++++++-
 7 files changed, 188 insertions(+), 41 deletions(-)

-- 
2.31.1


