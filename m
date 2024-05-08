Return-Path: <bpf+bounces-29135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F108C06CE
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 00:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A912825A3
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DDE132C23;
	Wed,  8 May 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FqLr54g9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21919D530;
	Wed,  8 May 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205562; cv=none; b=oKxpWuyWSO2DIhvtIXLZq6ylaFPP+3HrrMh1alV/XFI8UEzzmlE3QG9fVljj5CfWOrAtLsqoYahNjWz7uVn8YmzWfZCIczKYkXvQSW1rx3gF8nBOR6/I4IV7fohtVoZy0RBYHVMZIqvWTt6Cf6YA4AQ8CQZfjK49JtdeYK5vCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205562; c=relaxed/simple;
	bh=Lbt/BdVqVoqXqbvgWDsKDBz2ZrpXnS78EOewM3BycVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gafECBo9zWy8pSoCHVh4frqtx2qkRt/KtAxqYqdghz04Z4WfBlNj/Edh7aAnAxpuRyoTI9yHnCM9pLvN6QBCs0FrcGcgMIKPJ7gKl2mTigzyizxnb0WLd0S5LHEmO+yYveREuqulOlsgeMv6qyL12XkV+cR36y264HkXL5D9NoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FqLr54g9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448CiPQJ010625;
	Wed, 8 May 2024 21:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=+3Yac5HRyzv80FmzVtxE
	CGGwHVIMXjDvug1aZs0hlZI=; b=FqLr54g9mTTSw/J330vdKK394+V1Xv1Irkds
	ayRCXQRzi0RNWWVHeCoh0iZa26FNxouXzWc7Sg7cWxnxN8h8NeYrT6kgXTw2GxlI
	DfiPqEi2OcbWkKS9gC0t8KOdKDkPYmQe+f/sbrZ+h8iSNrG1XY7lQiF9xswQLlZO
	n19v4ex9t535n98KVXKm7LEXIB5O9ua7muC0R0BHhE3UvuvyFUZ8f4KRsQz8fuf9
	AgJcBVEplgkNxBvvO2PANbZlyph2YpbsOmSGwg8BkgzUzcr4lK6xN/V9PU9jmSgb
	PZCU1+/rx9bbgxpDaph/FuACV+snwGw0Jx24Ncr5dSlD/AF+EQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09nqh5na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 21:58:44 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 448LwhKI032761;
	Wed, 8 May 2024 21:58:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3xyyr5s96m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 21:58:43 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 448LwhXP032755;
	Wed, 8 May 2024 21:58:43 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 448LwgUC032754
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 21:58:43 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id C17572210C; Wed,  8 May 2024 14:58:42 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v7 0/3] Replace mono_delivery_time with tstamp_type
Date: Wed,  8 May 2024 14:58:39 -0700
Message-Id: <20240508215842.2449798-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 7fS-j-dcUAYyKGU8M2z79hCEdWM6BM_b
X-Proofpoint-GUID: 7fS-j-dcUAYyKGU8M2z79hCEdWM6BM_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=869
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080163

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
 26 files changed, 181 insertions(+), 123 deletions(-)

-- 
2.25.1


