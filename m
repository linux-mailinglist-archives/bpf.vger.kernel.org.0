Return-Path: <bpf+bounces-29313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216798C1831
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864331F21BFF
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351485653;
	Thu,  9 May 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0mWpryS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D984FBC;
	Thu,  9 May 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289542; cv=none; b=ssCbb32k2lXtVbgp5XobTlnFdtzz0LZSnMhoCNhIwYXBIURyszswQfo0lfF78Sh449g2qEbUWl+wvYAeDEQZbb5RxkXaj8Faau3IObKYQwWi1JGp2YR06l+3jLh0VsJU4Ja3Lsy6FDPR8Ie4aiXhteok5DQh83MqFzHuwXm61ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289542; c=relaxed/simple;
	bh=DSNcjb0/9m14mg1z288CJEBF+EywuKjvLqNTFhCT7uE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QzkSiHT9r8qR3IPtrD5NMN/XLXsrYO+2x6cBmhKLE0n+rJo1um4j581DrNmhE3xcltn7Kzw//unXKjQx+uAJgYjaniRHnvGtxFivrAd1XyqyeFYUmu3YEwh130SvL1K+8yga4PxUhmjluh8s1nqU8GsrBHLhjxAXuYxoMuaNQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C0mWpryS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449KsrG9008212;
	Thu, 9 May 2024 21:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=Iic5rqV5jfXiANtpFR5G
	e5pqq5EIbYObP8BVr/ZIjn0=; b=C0mWprySAuansH8pKuup0cud5cJntOfGlVCi
	GtUmmE89fIX3GkPNqmJMPidERknwsyf3WXlUcRiabdmMzXNkWwegQRgLFo/cL3nI
	rA7RkmufQrmDw0UHr6lDnAzoAuPs4TJ24ByheRhwgReCXC5OjklOFv4Jhd6WfJkM
	hlt20tyEDAtqlF3qK0nDPXMqcwtMa2JZpyf+CbhdltuaJ+kcKnaKwRmnxRTRz07L
	ignV3PLo9mYDcCciigmH/JdEL39UYQrJK509zk2x8nPtH7oATI3sz//A+XHvmhfs
	9mixGcA+Yd3I3+VcnmX16xgCtdzed0mo6OrJGKKUAf0b5hTFpg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y08ne3rwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 21:18:35 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 449LIZtb014490;
	Thu, 9 May 2024 21:18:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3y0wfhkte5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 21:18:35 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 449LIYIJ014485;
	Thu, 9 May 2024 21:18:34 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 449LIYKB014484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 21:18:34 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 4D28823A6F; Thu,  9 May 2024 14:18:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 0/3] Replace mono_delivery_time with tstamp_type
Date: Thu,  9 May 2024 14:18:31 -0700
Message-Id: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: JWJiFtWoRHtNMSnr0dmGzugIwJDb8BTw
X-Proofpoint-ORIG-GUID: JWJiFtWoRHtNMSnr0dmGzugIwJDb8BTw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_12,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=977 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405090150

Patch 1 :- This patch takes care of only renaming the mono delivery
timestamp to tstamp_type with no change in functionality of 
existing available code in kernel also  
Starts assigning tstamp_type with either mono or real and 
introduces a new enum in the skbuff.h, again no change in functionality 
of the existing available code in kernel , just making the code scalable.

Patch 2 :- Additional bit was added to support tai timestamp type to 
avoid tstamp drops in the forwarding path when testing TC-ETF. 
Patch is also updating bpf filter.c
Some updates to bpf header files with introduction to BPF_SKB_CLOCK_TAI
and documentation updates stating deprecation of BPF_SKB_TSTAMP_UNSPEC 
and BPF_SKB_TSTAMP_DELIVERY_MONO 

Patch 3:- Handles forwarding of UDP packets with TAI clock id tstamp_type
type with supported changes for tc_redirect/tc_redirect_dtime
to handle forwarding of UDP packets with TAI tstamp_type 

Abhishek Chauhan (3):
  net: Rename mono_delivery_time to tstamp_type for scalabilty
  net: Add additional bit to support clockid_t timestamp type
  selftests/bpf: Handle forwarding of UDP CLOCK_TAI packets

 include/linux/skbuff.h                        | 68 ++++++++++++++-----
 include/net/inet_frag.h                       |  4 +-
 include/uapi/linux/bpf.h                      | 15 ++--
 net/bridge/netfilter/nf_conntrack_bridge.c    |  6 +-
 net/core/dev.c                                |  2 +-
 net/core/filter.c                             | 54 ++++++++-------
 net/ieee802154/6lowpan/reassembly.c           |  2 +-
 net/ipv4/inet_fragment.c                      |  2 +-
 net/ipv4/ip_fragment.c                        |  2 +-
 net/ipv4/ip_output.c                          | 14 ++--
 net/ipv4/raw.c                                |  2 +-
 net/ipv4/tcp_ipv4.c                           |  2 +
 net/ipv4/tcp_output.c                         | 14 ++--
 net/ipv6/ip6_output.c                         | 11 +--
 net/ipv6/netfilter.c                          |  6 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c       |  2 +-
 net/ipv6/raw.c                                |  2 +-
 net/ipv6/reassembly.c                         |  2 +-
 net/ipv6/tcp_ipv6.c                           | 12 +++-
 net/packet/af_packet.c                        |  7 +-
 net/sched/act_bpf.c                           |  4 +-
 net/sched/cls_bpf.c                           |  4 +-
 tools/include/uapi/linux/bpf.h                | 15 ++--
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +--
 .../selftests/bpf/prog_tests/tc_redirect.c    |  3 -
 .../selftests/bpf/progs/test_tc_dtime.c       | 39 +++++------
 26 files changed, 180 insertions(+), 124 deletions(-)

-- 
2.25.1


