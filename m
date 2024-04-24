Return-Path: <bpf+bounces-27743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4C8B1613
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785211F23BDF
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379716C86A;
	Wed, 24 Apr 2024 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W87k+08j"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B013AD0D;
	Wed, 24 Apr 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997254; cv=none; b=pkHtTXY3q1dFPZQ9W+5LFADzBeBPTMem/QgRM7W0tScEWqKGyGLUHW0Q2GMx1MTS94lyWjwiL0+as3hXjVNtvXokAGUGtLMaWbWXPzxsBv87B/VfLf0OFzmxJYcUUL49U6wppNXwGU+3H/GOJj50PKHKTmiGn8EM0yzIzpbfbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997254; c=relaxed/simple;
	bh=cONU3mmrJUgdSbGbxulujXMO9As0fPjca+3seJRZqvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U29oEoDiVV+F4nqxvjhkL0bpYh/W2wbu9lb8+RITebIGMfZN7lPBppjQVKppfEHFNNHcwEj/c0iqCDHQzFk5Z3sFicuWZ3hDRACF65UgDNU3An0i9jiQ8AGS7MMdTLk9fbCiZsuhkzHb3hhshb8y4+GzheNxnwUhwsUCkrjHP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W87k+08j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OMJ4vN001337;
	Wed, 24 Apr 2024 22:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=3K56OkUxERthHoKXLzWV
	jMjq56gNekNkkNgWZBs6Y5I=; b=W87k+08jZPWZCRZ0Xo6ulY3o7K01ZNLa9WeQ
	WvlxnLO9tXOrWWZb7v3PXjB4okjJUhCw3ElQLt4jzbl7YteOtWWHUfem+aqItBTc
	aA/wHjVcmZ8A4/dFggZ69trRpGu0+C9f0Gh7VQGVWnhFiykGsJRsECwVEcsgD4OL
	+CO78i4J6rbwGHIY88wwdKtgaY1my4b1KqxdBspYqysvZUccFJy5FR911Q+EDQWs
	hdHhDQ+oTi0teWyJ+rGZ0NL2k6iKyGMBGXjfPHmaLsEic3EDu5e5UZdiWB+ea6yT
	BoMajfPDdB9vjfKmmfWontBAhXykDfTUA9g2an0lhK8Hgymdhg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e2a56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:30 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43OMKT4S019393;
	Wed, 24 Apr 2024 22:20:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xp4jb1776-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:29 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OMFl0D014703;
	Wed, 24 Apr 2024 22:20:29 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 43OMKT0w019376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:29 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 53FF5220BD; Wed, 24 Apr 2024 15:20:28 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v5 0/2] Replace mono_delivery_time with tstamp_type
Date: Wed, 24 Apr 2024 15:20:26 -0700
Message-Id: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: mhu9cKJ6S1ivAzggkV6TcCOGIuHE4fvL
X-Proofpoint-ORIG-GUID: mhu9cKJ6S1ivAzggkV6TcCOGIuHE4fvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=754 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240115

Patch 1 :- This patch takes care of only renaming the mono delivery
timestamp to tstamp_type with no change in functionality of 
existing available code in kernel also  
Starts assigning tstamp_type with either mono or real and 
introduces a new enum in the skbuff.h, again no change in functionality 
of the existing available code in kernel , just making the code scalable.

Patch 2 :- Additional bit was added to support tai timestamp type to 
avoid tstamp drops in the forwarding path when testing TC-ETF. 
With this patch i am updating bpf filter.c and some of the BPF
unit test framework which tests redirect test scenarios. 
Need reviews on those patches 


Abhishek Chauhan (2):
  net: Rename mono_delivery_time to tstamp_type for scalabilty
  net: Add additional bit to support clockid_t timestamp type

 include/linux/skbuff.h                        | 74 ++++++++++++++-----
 include/net/inet_frag.h                       |  4 +-
 include/uapi/linux/bpf.h                      |  1 +
 net/bridge/netfilter/nf_conntrack_bridge.c    |  6 +-
 net/core/dev.c                                |  2 +-
 net/core/filter.c                             | 50 +++++++------
 net/ieee802154/6lowpan/reassembly.c           |  2 +-
 net/ipv4/inet_fragment.c                      |  2 +-
 net/ipv4/ip_fragment.c                        |  2 +-
 net/ipv4/ip_output.c                          | 11 +--
 net/ipv4/raw.c                                |  2 +-
 net/ipv4/tcp_output.c                         | 16 ++--
 net/ipv6/ip6_output.c                         |  8 +-
 net/ipv6/netfilter.c                          |  6 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c       |  2 +-
 net/ipv6/raw.c                                |  2 +-
 net/ipv6/reassembly.c                         |  2 +-
 net/ipv6/tcp_ipv6.c                           |  2 +-
 net/packet/af_packet.c                        |  7 +-
 net/sched/act_bpf.c                           |  4 +-
 net/sched/cls_bpf.c                           |  4 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 ++-
 .../selftests/bpf/progs/test_tc_dtime.c       | 24 ++++--
 23 files changed, 153 insertions(+), 90 deletions(-)

-- 
2.25.1


