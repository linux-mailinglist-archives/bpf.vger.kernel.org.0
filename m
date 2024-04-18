Return-Path: <bpf+bounces-27092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CBD8A9027
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 02:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34A91C21942
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 00:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2185660;
	Thu, 18 Apr 2024 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ax2U+pHG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211228C11;
	Thu, 18 Apr 2024 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401313; cv=none; b=gWvrTtbD/OirQR2KYFoEOxRQ1LObMgTFQMEkm9HDydbPmYASYwr16KOaH0BST8FF4cp7NH3nkPvBbz18N2AhFqwis3QHHoOxJh3F4vabT6NNzuek0SSwdAObdj38FhUZYwX4jJ1vZw6YEfJu19lmmLwCVfWV9YfsEuWL0HtG32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401313; c=relaxed/simple;
	bh=4myWCl9rPEvJWxhoy9ruc8t8VmTwMfGnJKppesHAdak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WiEy99VLS4Oqd/Z4pXumvs8WM7wR/7VxCR3GQq+ChRj+8p654z9dw7bZvSyYZhqiw7nKrA3IXSKXE319HzqhroE5aISA/b9qqA5ZqxuR7d2Cyf32Msw5Hc+UZgobJiB+t6wUfpFnjG8EscQnhWW0TvcR50UwqIFb11SbdlE5bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ax2U+pHG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H8FdRs013344;
	Thu, 18 Apr 2024 00:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=b17XR78sxCkLDTNPfOL5
	o/sHbO6u5mrz5YsT90tih/s=; b=ax2U+pHG9Qiiy1G3b98+K4Dlp4VOjc5U+HBA
	VgVfLYmH+7ytwPxH1UWvUyvu239Fa2IVKFs51mB7sXAmF6bujmj3k1k2OCiUd2J/
	7aJAw1tsJ2PyhiV7R5w/MTT7v3z36p+LuyWaq+zNDLeZigEQp8PzoMQBWzlf+nfY
	7PZlLcs9Fy+wNmDFVOLuirW9IYV3QWmcAwxfs9UcFf69vJJy7kjX4lPguBd5e2Cc
	C1niwWI2HnUWvjfDau/K5bzEzV/cjireHCqvm0ns9WaBA8D50LaqEmi0T7OZuKn5
	R6KbVgkcv/uUBEaEf2KFGn2KpENSSEZzZYvD1b8OQ2bX+gzs9w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjarpjdfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:43:12 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43I0hAMa001750;
	Thu, 18 Apr 2024 00:43:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3xhpckexw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:43:10 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43I0h9Fw001742;
	Thu, 18 Apr 2024 00:43:09 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 43I0h91E001741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:43:09 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id B4648220A2; Wed, 17 Apr 2024 17:43:08 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v4 0/2] Replace mono_delivery_time with tstamp_type
Date: Wed, 17 Apr 2024 17:43:06 -0700
Message-Id: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: FKByXQ9fZPf2WC09diIY5oSLdH0Rirx7
X-Proofpoint-ORIG-GUID: FKByXQ9fZPf2WC09diIY5oSLdH0Rirx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxlogscore=830 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180002

Patch 1 :- This patch takes care of only renaming the mono delivery
timestamp to tstamp_type with no change in functionality of 
existing available code in kernel also  
Starts assigning tstamp_type with either mono or real and 
introduces a new enum in the skbuff.h, again no change in functionality 
of the existing available code in kernel , just making the code scalable.

Patch 2 :- Additional bit was added to support tai timestamp type to 
avoid tstamp drops in the forwarding path when testing TC-ETF. 
With this patch i am updating bpf filter.c and not sure
what impacts it has towards BPF code. 
I need upstream BPF community to help me in adding the necessary BPF 
changes to avoid any BPF test case failures. 
I have added some BPF changes as part of this commit to handle 
cases of both tai and mono bit being set at the same time. 

Abhishek Chauhan (2):
  net: Rename mono_delivery_time to tstamp_type for scalabilty
  net: Add additional bit to support clockid_t timestamp type

 include/linux/skbuff.h                        | 61 +++++++++++++++----
 include/net/inet_frag.h                       |  4 +-
 include/uapi/linux/bpf.h                      |  1 +
 net/bridge/netfilter/nf_conntrack_bridge.c    |  6 +-
 net/core/dev.c                                |  2 +-
 net/core/filter.c                             | 50 ++++++++++++---
 net/ieee802154/6lowpan/reassembly.c           |  2 +-
 net/ipv4/inet_fragment.c                      |  2 +-
 net/ipv4/ip_fragment.c                        |  2 +-
 net/ipv4/ip_output.c                          | 11 ++--
 net/ipv4/raw.c                                |  2 +-
 net/ipv4/tcp_output.c                         | 14 ++---
 net/ipv6/ip6_output.c                         |  8 +--
 net/ipv6/netfilter.c                          |  6 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c       |  2 +-
 net/ipv6/raw.c                                |  2 +-
 net/ipv6/reassembly.c                         |  2 +-
 net/ipv6/tcp_ipv6.c                           |  2 +-
 net/packet/af_packet.c                        |  7 +--
 net/sched/act_bpf.c                           |  4 +-
 net/sched/cls_bpf.c                           |  4 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 13 ++--
 22 files changed, 139 insertions(+), 68 deletions(-)

-- 
2.25.1


