Return-Path: <bpf+bounces-26452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F72C8A003F
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A28284A08
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F09180A88;
	Wed, 10 Apr 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UPyw8BLE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9047460;
	Wed, 10 Apr 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775875; cv=none; b=gvivG6DsYK4f52eU1YQxHSEVGTpPKQIlDms5ICgBpNAQAZJc0lrg1gjo9szDVVEmmtFYuHPvIUeOGBKgLlsKc+Ghej4gh7bRLKk+RqI9C1+W7V0qLthvq9n3pXDGQkcipkG94c0O6LiFQtzQw+l8c8kfKvZfdfbAZIokP8MuTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775875; c=relaxed/simple;
	bh=WNUHRnuL/nPa/KdZjEbb1Yec0muX2H7NaxT84SbLG+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RlXcUth3pHaBcf9SS3Vrm1ACfIS2RClT7dFX3iEkDINn2yWBE4SDrmweFJZDIxXl0xWWDUWfQmhj8CSjmHrqZQY0gT0fV61QZ9LiwEnnhkhttS+A2A0u6q8nYfCYL1xwTUwI5eFGrppxq+QiTv19pgrZONtK72u1j5oGcKlLMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UPyw8BLE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AEFVpt031790;
	Wed, 10 Apr 2024 19:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=McZIZ4RkNyMqFdfx+BLnURSG0gx07exkf3P/nz9bFEk=; b=UP
	yw8BLENpdWV1k3PlqVVCFwwJIkjna/c/YldXBHce6NcvOkvYqn3tBoOpsmLIebVs
	FlBOa8p34dDNVi1dFVYLZkUHj1Reo53ydytnO7YMV0SxWII2eALJ7pzMJ+8Rf+Jo
	jaIhDVf7Cl68YSeI6jnt2wY6wPlqVw8y2cRQqHUCUs54/WD7fVolF0c323iJiYMC
	x/V634ulbM9T/ytbfmwAZ7hqUQD3wHuT+vi4W55LajlRWntAkIvmISMjEMacrUs7
	Q2EZxG7SLMVrdJJJ57roPtJUmejoygTpQySA6+t7na5ftPKLrmN73PmedA6aLCa6
	X961rZAPS+L/WK/eIPHA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdphau2cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 19:04:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AJ4BSS016238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 19:04:11 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 12:04:07 -0700
Message-ID: <f6066cc2-410a-4043-9657-7168dbd2a2ce@quicinc.com>
Date: Wed, 10 Apr 2024 12:04:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 1/3] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
CC: <kernel@quicinc.com>
References: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
 <20240409210547.3815806-2-quic_abchauha@quicinc.com>
 <6616b0af63eed_2a98a52947e@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <6616b0af63eed_2a98a52947e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8QFGfTKv0lAOUgSU9Ht80HCesRaoTJFS
X-Proofpoint-ORIG-GUID: 8QFGfTKv0lAOUgSU9Ht80HCesRaoTJFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=942 mlxscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100138



On 4/10/2024 8:30 AM, Willem de Bruijn wrote:
> Abhishek Chauhan wrote:
>> mono_delivery_time was added to check if skb->tstamp has delivery
>> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
>> timestamp in ingress and delivery_time at egress.
>>
>> Renaming the bitfield from mono_delivery_time to tstamp_type is for
>> extensibilty for other timestamps such as userspace timestamp
>> (i.e. SO_TXTIME) set via sock opts.
>>
>> Bridge driver today has no support to forward the userspace timestamp
>> packets and ends up resetting the timestamp. ETF qdisc checks the
>> packet coming from userspace and encounters to be 0 thereby dropping
>> time sensitive packets. These changes will allow userspace timestamps
>> packets to be forwarded from the bridge to NIC drivers.
>>
>> In future tstamp_type:1 can be extended to support userspace timestamp
>> by increasing the bitfield.
>>
>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>>  include/linux/skbuff.h                     | 18 +++++++++---------
>>  include/net/inet_frag.h                    |  4 ++--
>>  net/bridge/netfilter/nf_conntrack_bridge.c |  6 +++---
>>  net/core/dev.c                             |  2 +-
>>  net/core/filter.c                          |  8 ++++----
>>  net/ipv4/inet_fragment.c                   |  2 +-
>>  net/ipv4/ip_fragment.c                     |  2 +-
>>  net/ipv4/ip_output.c                       |  8 ++++----
>>  net/ipv6/ip6_output.c                      |  6 +++---
>>  net/ipv6/netfilter.c                       |  6 +++---
>>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>>  net/ipv6/reassembly.c                      |  2 +-
>>  net/sched/act_bpf.c                        |  4 ++--
>>  net/sched/cls_bpf.c                        |  4 ++--
>>  14 files changed, 37 insertions(+), 37 deletions(-)
> 
> Since the next patch against touches many of the same lines, probably
> can just squash the two.

Sounds good i can do that. 
Make only 2 patches 
1. rename + assign tstamp_type
2. introduce another bit for clock_id base time 

