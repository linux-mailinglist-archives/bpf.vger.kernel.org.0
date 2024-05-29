Return-Path: <bpf+bounces-30847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031D8D3B5E
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB30FB26AE9
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA990181D09;
	Wed, 29 May 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K+awFn/4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F8181CEF;
	Wed, 29 May 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997795; cv=none; b=t5zlgHRJhwLdkyIov6oLYu38jnJt2NXt2rl67NTlO2ssx5q8Lwn/WsLwRIaOMWan0AlZXbpU6Q/4Kh01gYdgi6rDPqtzyw52+UeaT875k+Zh+NIVUEkpDxP5cecpOgK5KlLi3cfJUIlHgKFxLOu59/wSYnO+N95YjzBCnKgj9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997795; c=relaxed/simple;
	bh=PGuq1nWW6Ce4ZkBk0TnI9bG4PCIDGFwjqQ9Xsaj+oGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AFfdwB/NbtlIoBN3vpzGN8o0Mt+bqrkqcEC08okuGZSRMrsue+bYXvxBAOgFHePS3/phAPqH+s4PJD4rdbH+J/ED+EuEeJfTPf3vWEAZV2VFJSiKmS9t8xgF/6p/XojemTZbXWzU8f5+Zt+Q1qkXOiJWqMU1MngFv97UEi8fV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K+awFn/4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TAWqTs027031;
	Wed, 29 May 2024 15:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	92CTHz0UFZuCUoY3V9kybNrLWakvxNbVMDycuT/J+40=; b=K+awFn/4PE5IyE7D
	369jN0z2sc+kw7TX6tn8RFKIXRlt/NXFaSfifhQjaWgJ4nON7fA8R+ZuMdyQxjFA
	Nhytn9cYIYRy3fVUebcuBjvApsACqBlEjrpScKCqhWY5J0qCh0wNkRVF/WY/firo
	vK2rlYISRA5ixkzeu9rrm4RMitkYJNIsV21CfBOXSlKH6lg4wM4KzFJ2kuDSBLpK
	ZHPorL+w6PAHnKjrAYLLtjn+F7kVE7/5EimsXSIhYQ9Atit+UMt/IKida9BLKSN2
	eV8/grz6wkoKBgTFPl04HfJr/adFwOpMdM2/VIvwAT5Q0cVG8j56bj8nrP2R6wcI
	ZqzpWQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h9b3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 15:49:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TFnQKN005363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 15:49:26 GMT
Received: from [10.110.47.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 08:49:22 -0700
Message-ID: <3d04ff60-c01b-4718-ae3d-70d19ee2019a@quicinc.com>
Date: Wed, 29 May 2024 08:49:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: validate SO_TXTIME clockid coming from userspace
Content-Language: en-US
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
CC: <kernel@quicinc.com>,
        <syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com>,
        <syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com>
References: <20240528224935.1020828-1-quic_abchauha@quicinc.com>
 <665734886e2a9_31b2672946e@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <665734886e2a9_31b2672946e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TPqcgTNlT5VIe9IKLmb3sa-dxGAbunfC
X-Proofpoint-ORIG-GUID: TPqcgTNlT5VIe9IKLmb3sa-dxGAbunfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290109



On 5/29/2024 6:58 AM, Willem de Bruijn wrote:
> minor: double space before userspace
> 
> Abhishek Chauhan wrote:
>> Currently there are no strict checks while setting SO_TXTIME
>> from userspace. With the recent development in skb->tstamp_type
>> clockid with unsupported clocks results in warn_on_once, which causes
>> unnecessary aborts in some systems which enables panic on warns.
>>
>> Add validation in setsockopt to support only CLOCK_REALTIME,
>> CLOCK_MONOTONIC and CLOCK_TAI to be set from userspace.
>>
>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>> Link: https://lore.kernel.org/lkml/20240509211834.3235191-1-quic_abchauha@quicinc.com/
> 
> These discussions can be found directly from the referenced commit?
> If any, I'd like to the conversation we had that arrived at this
> approach.
> 
Not Directly but from the patch series. 
1. First link is for why we introduced skb->tstamp_type 
2. Second link points to the series were we discussed on two approach to solve the problem 
one being limit the skclockid to just TAI,MONO and REALTIME. 



>> Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")
>> Reported-by: syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=d7b227731ec589e7f4f0
>> Reported-by: syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=30a35a2e9c5067cc43fa
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>>  net/core/sock.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 8629f9aecf91..f8374be9d8c9 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -1083,6 +1083,17 @@ bool sockopt_capable(int cap)
>>  }
>>  EXPORT_SYMBOL(sockopt_capable);
>>  
>> +static int sockopt_validate_clockid(int value)
> 
> sock_txtime.clockid has type __kernel_clockid_t.
> 

 __kernel_clockid_t is typedef of int.  

>> +{
>> +	switch (value) {
>> +	case CLOCK_REALTIME:
>> +	case CLOCK_MONOTONIC:
>> +	case CLOCK_TAI:
>> +		return 0;
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>>  /*
>>   *	This is meant for all protocols to use and covers goings on
>>   *	at the socket level. Everything here is generic.
>> @@ -1497,6 +1508,11 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>>  			ret = -EPERM;
>>  			break;
>>  		}
>> +
>> +		ret = sockopt_validate_clockid(sk_txtime.clockid);
>> +		if (ret)
>> +			break;
>> +
>>  		sock_valbool_flag(sk, SOCK_TXTIME, true);
>>  		sk->sk_clockid = sk_txtime.clockid;
>>  		sk->sk_txtime_deadline_mode =
>> -- 
>> 2.25.1
>>
> 
> 

