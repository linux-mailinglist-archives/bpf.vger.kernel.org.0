Return-Path: <bpf+bounces-28565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E28BB95A
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 05:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A5E1F23766
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651CDF513;
	Sat,  4 May 2024 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iaqq+1NZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746212B83;
	Sat,  4 May 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714792444; cv=none; b=u9af6Mb/UKR+wbW4M2TLSFcGm3Q5qU8o9K8vIoeSxd6iwklQWzothc17un5XZajxkDH9m/WQh3fYCzvlZqLh9bzG2jfCGCWtHpQGwFYCR5bNCJmjmsgSFJwqZJdzYNiRh2Foyxm3xsf+zZtLKgtZh7sk3+s6HbyuzHS+8TxnF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714792444; c=relaxed/simple;
	bh=q7oZJv7BUih3IUeI+4iSVn1MKkJifyaXJFk8+OP6k6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ouoEcqzz3kLHkFZYRU7Xsfywcuz/W38mUUX7ARzKNkEszmWMz7wv19rJM84v7gQ5qIZUwRFBSs1F+a6+hF0jw9vyuKHZOfd9gBcS6egXzwWKbeqw0yG/tjOKMWd40nB0O0Xn4B/qyMXhEUqno8E9e1JFkrHJ+Azg+49/aa/jAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iaqq+1NZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4443BB3e017945;
	Sat, 4 May 2024 03:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=RKlYwg+yWAUON7cOPPxA
	UCg8T1J/PYF2wNi64YkyYSM=; b=iaqq+1NZSSGUpsAyQsInlz6e1B1WItgxHYEk
	O8mmPm85jdUMTTCzdXE45Vih/Z1Sr0c/zS72IRmTudQTkyYNcXPPWGGBG8556MNk
	1mXIptCgZvS/CtX3L+4TWm3mkjWX10ikLiLxqlScT2FYjwvHzKOiHO0HoD7mi4Zk
	Wk0H3yfifvOepxL2tgidAN+63EXuGiUEHhSuxtXE9wbjh2OXfl2bqMT/zq8pqKul
	watd0PYIuzZoMBNfFXCh9pXtVtiNfPtipHA1W5RxmfeXG4eQR/G3LNGlfFIYzH2b
	ZZxTXFGbXpn338mQHrI4Hl3QONsNfe4FejBfmoIa2iORwF8s5g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwc1c01kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 03:13:35 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4443A97h000922;
	Sat, 4 May 2024 03:13:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xvjwwju2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 03:13:33 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4443DXIL005851;
	Sat, 4 May 2024 03:13:33 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4443DXoX005840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 03:13:33 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 997DD2395E; Fri,  3 May 2024 20:13:31 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v6 0/3] Replace mono_delivery_time with tstamp_type
Date: Fri,  3 May 2024 20:13:28 -0700
Message-Id: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: iqV0ZTpcaLro2W2rkGywQ4024kdTJxP6
X-Proofpoint-ORIG-GUID: iqV0ZTpcaLro2W2rkGywQ4024kdTJxP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=831 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040022

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
 net/ipv4/tcp_output.c                         | 16 ++---
 net/ipv6/ip6_output.c                         | 11 +--
 net/ipv6/netfilter.c                          |  6 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c       |  2 +-
 net/ipv6/raw.c                                |  2 +-
 net/ipv6/reassembly.c                         |  2 +-
 net/ipv6/tcp_ipv6.c                           |  2 +-
 net/packet/af_packet.c                        |  7 +-
 net/sched/act_bpf.c                           |  4 +-
 net/sched/cls_bpf.c                           |  4 +-
 tools/include/uapi/linux/bpf.h                | 15 ++--
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +--
 .../selftests/bpf/prog_tests/tc_redirect.c    |  3 -
 .../selftests/bpf/progs/test_tc_dtime.c       | 39 +++++------
 25 files changed, 172 insertions(+), 122 deletions(-)

-- 
2.25.1


