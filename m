Return-Path: <bpf+bounces-26655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C298A3776
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EA128542B
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ADA14EC53;
	Fri, 12 Apr 2024 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aU7KLIPJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67553D548;
	Fri, 12 Apr 2024 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955721; cv=none; b=atwBQQPn7da2EVxgz1qKne7X0F6oclC5vLMm/aVjltlSt7VPLSJRbMRrQIMi1uaTIx7/sX5n3G860OBBN0OnnKuRPEVI15XgQaHJw5wtOWUPRgEXOf5NlVMi/3oDyuc3tHq5RHPnDtqmOR0D4K9RVX3GbHFGMBrNL7kd9ngOAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955721; c=relaxed/simple;
	bh=wDiqDfSQwKgl2YXcdLMUIGZS+yBAbZt9wH6TycsKLQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BqsAjSRDi/DP5huNukVNtCogTgRKUosr3J8/fNLX3UgxAyT8PPvBK9Ej9G3EUxhAucK7uUX414o1phhyWBhXHMEFIvgX1UcO1gDlrl70VEUBwndjwn7SqPVg0FFl5mtTOwWPPPXsF0XqvbFXYg1dT706sRf8+nznDbKOoinsd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aU7KLIPJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CJhNVw028876;
	Fri, 12 Apr 2024 21:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=xHF+sDd8rsIy2kUSdpvt
	vP96ViWFd/9tKXSBhWUmSq4=; b=aU7KLIPJ/2N9L6/2TPXDu/Bi+4TM+Z/3MpVo
	rGOGH03qa/ZcOzfgwEeG3WW8ItNI8RLas0hLVSfypxYp+Bi9f4u2re231F7kmGKC
	Ojq4bT8h1U3aeSnIafPvR+ZJQPvHk05nBDyYsXrQNYgdGt/SuFSYc8eO+GWGnINW
	sCVg5gzP5zdmp3q3r3oLNVvN4XVRrzLYBRZK6gbXMTAeSBgSIt/WvPyOLZJjNLsZ
	sNDOVuCKeBzEspJqsuGz/e/hehF3MhraTxwzmhdC/g6ptHLviEL8Hp2K/w6IxRjn
	je5h5TR+qu06Um0gbJsbziEN9SOf9yaKj/YjN66EmVwp9C3lNA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xf9wgrjec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:01:27 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43CL0kwI025723;
	Fri, 12 Apr 2024 21:01:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3xf5qntx8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:01:26 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CL0ZeL025662;
	Fri, 12 Apr 2024 21:01:26 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 43CL1QPC027052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:01:26 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 2ABB222097; Fri, 12 Apr 2024 14:01:25 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v3 0/2] Replace mono_delivery_time with tstamp_type
Date: Fri, 12 Apr 2024 14:01:23 -0700
Message-Id: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2w5KFFQIfGVL8DEc01YRNfcrngS0lgG2
X-Proofpoint-GUID: 2w5KFFQIfGVL8DEc01YRNfcrngS0lgG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_17,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=790
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404120151

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


