Return-Path: <bpf+bounces-28294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147E28B80F3
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 22:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45F42855CE
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC06199EA4;
	Tue, 30 Apr 2024 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jzFsFGfG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A932174EF1;
	Tue, 30 Apr 2024 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507199; cv=none; b=Z29vDli6JAeoWrIkeCMNxcKE7Hb1uJzAUgpUIqyliuOwlWYBygpPGBKKemG9bAbvi1Hf7ardb5i3DddWcfpIsdsvEWHJV09Puc+syfG2XJ7mNtdkb5pZYv2lkpl17PEcXxqd3LSPi8VGud72ngNZyD4x6URsY/uiJ2RPxfExlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507199; c=relaxed/simple;
	bh=yGI8rHp7d7L9kbE813idL3CIk7NqQ7kEfvGzd5z2dhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o2xk1Td9UxS9UmOlykWFaNbMQshw+UXAU+ogxzUg8d9x78xwWl16+yFsESBW2Lq9uxztPDr2GD4MJJirrIfucZxpbs95CHyyKnY80ov5gGnKZECAO1dRZHT30afuNpGv+9NLDvK1NwoiNw8t8dNXC86pSjYGFZ8aDESXjidZAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jzFsFGfG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UJdAwq015120;
	Tue, 30 Apr 2024 19:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gHBK/SMKqy0pt4SuJXygjGLR4a9GPGN8t1EdsxK0Kno=; b=jz
	FsFGfGCLJnA9j2yH0zpA/89gD/F4tUMa6ciWg2J/4dUsGPor73hZXbKi6Ms7BAho
	yWBmctBnErasMm5gyh1xrsw6MEkzbvc2S6cQ1LeeCSebEqk+/mqtnxEQ7Fk99n+a
	MimnrBgrezIAmB5YwiyiIkJt1Wa6VAljQO5qd0L6BtzDnBbypvNBZt40DfJkGsOF
	rgIx6KoJMfLOg2rldSzzVdeukjtK5wPGtN97LSwAlCutzBtLNVMEvx0tDiJJeepQ
	Fm8erpjkbEKjvi+fBovsvv7mx/4qIEd1NmqkFHC6YxeazI7VSh9WKwQUlYl5dGEu
	9vdDgGeEso3VjgG+InEg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtrep2hg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:59:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UJxZhw021888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:59:35 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 12:59:31 -0700
Message-ID: <13e141a2-ce22-42c8-b462-348ee700fe03@quicinc.com>
Date: Tue, 30 Apr 2024 12:59:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support
 clockid_t timestamp type
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Willem
 de Bruijn" <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf
	<bpf@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
 <c20eb574-22f4-49f8-a213-5ff57eb6222e@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <c20eb574-22f4-49f8-a213-5ff57eb6222e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RT8YUXCqthp7g5R6xfM6-Lsmir3XpD4l
X-Proofpoint-ORIG-GUID: RT8YUXCqthp7g5R6xfM6-Lsmir3XpD4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300143



On 4/26/2024 4:55 PM, Martin KaFai Lau wrote:
> On 4/24/24 3:20 PM, Abhishek Chauhan wrote:
>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index a9e819115622..63e4cc30d18d 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -955,7 +955,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>               if (iter.frag)
>>                   ip6_fraglist_prepare(skb, &iter);
>>   -            skb_set_delivery_time(skb, tstamp, tstamp_type);
>> +            skb_set_tstamp_type_frm_clkid(skb, tstamp, tstamp_type);
>>               err = output(net, sk, skb);
>>               if (!err)
>>                   IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
>> @@ -1016,7 +1016,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>           /*
>>            *    Put this fragment into the sending queue.
>>            */
>> -        skb_set_delivery_time(frag, tstamp, tstamp_type);
>> +        skb_set_tstamp_type_frm_clkid(frag, tstamp, tstamp_type);
>>           err = output(net, sk, frag);
>>           if (err)
>>               goto fail;
> 
> When replying another thread and looking closer at the ip6 changes, these two line changes should not be needed.

Similar code exists in ip_output.c for ipv4 packets  =>  ip_do_fragment => I was thinking do we need 
require that code or not. 

Since in both functionality are the same, only difference is protocol. 

From what i see is the for Frag cases in both ipv4 and ipv6, previously skb->tstamp_type was being 
set for each fragments. 

If we are planning to not do it for ip6 the same should follow for ip4 too. 

