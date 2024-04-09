Return-Path: <bpf+bounces-26322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE4789E4BE
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 23:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B17B1C21D3E
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F305158A09;
	Tue,  9 Apr 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PGRHbB1y"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDEA15887B;
	Tue,  9 Apr 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696772; cv=none; b=tbfRnRJUqJj/wZmgNuJdX/kjWnELJGElmocGm+MVxNyaZOEENr7XLL9QNWeAWhpy+Dd7MJP94cjLoXaMegnjp5WOQ8bGJCCiiwNkbfMUaemzmmawi9EBSQrqK+gyFC8TkCdqrYnuC07HIFnJFKhE0z8woIPZBmFE1xj0AhVTLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696772; c=relaxed/simple;
	bh=Jy24e7oy1xu/OFetGGcYd/gTCThcS3dxJIyooq7Oqyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RBMmPtrGTecY3+ORViasAN4Qvy6xyW6m5UqmKeh0MRbk0pjUNTWxtFk3s3EHV3p3ACPf220qFO5SN7SqYeR+7ZFgpZrC1Gywap0AjUs8xYH7i7Nqi1J1ABsbHmeO+B2r8J1LUNVR6I93LgDUj53BVaNuRsOU/E3K8anefo356Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PGRHbB1y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439KZcrF016172;
	Tue, 9 Apr 2024 21:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=V1SuP6eXVBFGYGm7m/1G
	hxLxiPFrHOkbv1QHcvwMGWc=; b=PGRHbB1ywlb7UzhJysUAaEBExh8K43CSbV8f
	Wx15QmwwQkjYki/2bvpGeoiZqMCXTvAkUv1MUDHVTbypbL52sG1vyiJws4VICY7O
	kgz4IZUrF1NcyEvCKusNVdHunxp3WG2h4JYssArXJL64IAuAmTywDvggfBPL61u7
	5r2Zo3JJNihA33fD++yX8QLCtpJ8UELr2pNG9nZJYYCSYUCI24GB8Tg+BWYNWWLy
	f4Vj9EfzRCR+01uHjo8hIeVqDNayA8TVipDzhpwtUGHPAn4YmCZZDvl/NF3uege6
	zkuA4HeaukzrvgshdC7C6Ex12d6fg3R7Yj0jpWuQdqzyW8mwAg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd3dy9f7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:05:49 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 439L5mZF025389;
	Tue, 9 Apr 2024 21:05:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xayfmk1ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:05:48 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439L5lpB025383;
	Tue, 9 Apr 2024 21:05:47 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 439L5l6S025379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:05:47 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 4F182220AB; Tue,  9 Apr 2024 14:05:47 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 0/3] Rename mono_delivery_time to
Date: Tue,  9 Apr 2024 14:05:44 -0700
Message-Id: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: QX38xT3t_NKNPLtQtrd_2YlODkrC3Axh
X-Proofpoint-ORIG-GUID: QX38xT3t_NKNPLtQtrd_2YlODkrC3Axh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=688
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1011
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404090142

Patch 1 :- This patch takes care of only renaming the mono delivery
timestamp to tstamp_type with no change in functionality of 
existing available code in kernel. 

Patch 2 :- Starts assigning tstamp_type with either mono or real and 
introduces a new enum in the skbuff.h, again no change in functionality 
of the existing available code in kernel , just making the code scalable 

Patch 3 :- Additional bit was added to support userspace timestamp to 
avoid tstamp drops in the forwarding path when testing TC-ETF. 
With this patch i am not sure what impacts it has towards BPF code. 
I need upstream BPF community to help me in adding the necessary BPF 
changes to avoid any BPF test case failures. 
I haven't changed any of the BPF functionalities and hence i need 
upstream BPF help to assist me with those changes so i can make them as 
part of this patch.    


Abhishek Chauhan (3):
  net: Rename mono_delivery_time to tstamp_type for scalibilty
  net: assign enum to skb->tstamp_type to distinguish between tstamp
  net: Add additional bit to support userspace timestamp type

 include/linux/skbuff.h                     | 40 ++++++++++++++++------
 include/net/inet_frag.h                    |  4 +--
 net/bridge/netfilter/nf_conntrack_bridge.c |  6 ++--
 net/core/dev.c                             |  2 +-
 net/core/filter.c                          |  8 ++---
 net/ipv4/inet_fragment.c                   |  2 +-
 net/ipv4/ip_fragment.c                     |  2 +-
 net/ipv4/ip_output.c                       | 10 +++---
 net/ipv4/raw.c                             |  2 +-
 net/ipv4/tcp_output.c                      | 14 ++++----
 net/ipv6/ip6_output.c                      |  8 ++---
 net/ipv6/netfilter.c                       |  6 ++--
 net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
 net/ipv6/raw.c                             |  2 +-
 net/ipv6/reassembly.c                      |  2 +-
 net/ipv6/tcp_ipv6.c                        |  2 +-
 net/packet/af_packet.c                     |  6 ++--
 net/sched/act_bpf.c                        |  4 +--
 net/sched/cls_bpf.c                        |  4 +--
 19 files changed, 73 insertions(+), 53 deletions(-)

-- 
2.25.1


