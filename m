Return-Path: <bpf+bounces-26589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CD28A220E
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7401AB213EA
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 23:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C7E47A55;
	Thu, 11 Apr 2024 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DOn/9P98"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4517548;
	Thu, 11 Apr 2024 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876731; cv=none; b=hMxpYVm0FBj9NpA3Xmm2vJfMc0oyXpqzg7UfREkXdF5jklJk8RxcxK8R9ORq1nhkmBlg/nzPMitxV/RbQN3GkqgqFYzZo7j8tni3SLo6Ev9Ks6ixx57qgScEIOaNaQTeX9C6X0jOH+GTD2u/FYRIUXCAygVHN58Eaeh7E6eizHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876731; c=relaxed/simple;
	bh=wDiqDfSQwKgl2YXcdLMUIGZS+yBAbZt9wH6TycsKLQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CnwxfJWVyu8/O/i+0TRYPTdDfDjx+uya0UeNST/lt+6JaVsDpp3NITzPaUjY3iRRKnkJCQrvxuPZ/pi624G/F4GhGD3loREGsgLUcwteAlt/3XTOhY7X15Py3Aca1M/o2TWlNS3H5o/WVT/zKRMnKkxYY/ZtUieq6zJ970G5MUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DOn/9P98; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BMj2wk015725;
	Thu, 11 Apr 2024 23:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=xHF+sDd8rsIy2kUSdpvt
	vP96ViWFd/9tKXSBhWUmSq4=; b=DOn/9P98/+D/+5KZbG2smy99B0u5betliX7b
	gsl6zieKTOWPCqj1oT40vl3MkbUAqRl+BdVC/giKBAw4CGt7JM9sBIwfZmoIJvVy
	VN2lWg5VJ63SN5ulsG8Oxlw/4uLrUHs4Q3Ttop9B7jeJhsp+ImOlcOTInYFR4pp/
	QeEHQnOK53rj7jZrcVqO+IY1Bw0M5WpF4m82nrB7tpQJPX6p6KfceU1/jt/C4+Ay
	+E5W5KMyKZHACyB/D5uZBV7HrHl9Pb3SXoGTe+6Yg1BN94DpPkESHFKuWHBRMbkd
	uGLt68oStY82CDUqtmfZnxKUHHCfepvXG+PgMXd7qbkMrl+Qlw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeb62ap3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:05:08 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43BN58br022029;
	Thu, 11 Apr 2024 23:05:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xdpry4xym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:05:08 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43BN575N022016;
	Thu, 11 Apr 2024 23:05:07 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 43BN577E022014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:05:07 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id B4684220A5; Thu, 11 Apr 2024 16:05:06 -0700 (PDT)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Subject: [RFC PATCH bpf-next v2 0/2] Replace mono_delivery_time with tstamp_type
Date: Thu, 11 Apr 2024 16:05:04 -0700
Message-Id: <20240411230506.1115174-1-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OU1udE0yyT2rmM7aIJvnhhEJDqJkmBGv
X-Proofpoint-GUID: OU1udE0yyT2rmM7aIJvnhhEJDqJkmBGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=791
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404110165

Patch 1 :- This patch takes care of only renaming the mono delivery
timestamp to tstamp_type with no change in functionality of 
existing available code in kernel also  
Starts assigning tstamp_type with either mono or real and 
introduces a new enum in the skbuff.h, again no change in functionality 
of the existing available code in kernel , just making the code scalable.

Patch 2 :- Additional bit was added to support userspace timestamp to 
avoid tstamp drops in the forwarding path when testing TC-ETF. 
With this patch i am not sure what impacts it has towards BPF code. 
I need upstream BPF community to help me in adding the necessary BPF 
changes to avoid any BPF test case failures. 
I haven't changed any of the BPF functionalities and hence i need 
upstream BPF help to assist me with those changes so i can make them as 
part of this patch.  

Abhishek Chauhan (2):
  net: Rename mono_delivery_time to tstamp_type for scalabilty
  net: Add additional bit to support userspace timestamp type

 include/linux/skbuff.h                        | 50 ++++++++++++++-----
 include/net/inet_frag.h                       |  4 +-
 net/bridge/netfilter/nf_conntrack_bridge.c    |  6 +--
 net/core/dev.c                                |  2 +-
 net/core/filter.c                             |  8 +--
 net/ipv4/inet_fragment.c                      |  2 +-
 net/ipv4/ip_fragment.c                        |  2 +-
 net/ipv4/ip_output.c                          | 10 ++--
 net/ipv4/raw.c                                |  2 +-
 net/ipv4/tcp_output.c                         | 14 +++---
 net/ipv6/ip6_output.c                         |  8 +--
 net/ipv6/netfilter.c                          |  6 +--
 net/ipv6/netfilter/nf_conntrack_reasm.c       |  2 +-
 net/ipv6/raw.c                                |  2 +-
 net/ipv6/reassembly.c                         |  2 +-
 net/ipv6/tcp_ipv6.c                           |  2 +-
 net/packet/af_packet.c                        |  7 ++-
 net/sched/act_bpf.c                           |  4 +-
 net/sched/cls_bpf.c                           |  4 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  8 +--
 20 files changed, 84 insertions(+), 61 deletions(-)

-- 
2.25.1


