Return-Path: <bpf+bounces-30818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA68D2B82
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 05:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EFD28B07C
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 03:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E215B139;
	Wed, 29 May 2024 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZAMlduDg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AE273DC;
	Wed, 29 May 2024 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953561; cv=none; b=KK2GPsCdA9SJnDjefiuZwXteaJDobaXDwDrD2joIrHO1p+pj/iQv/Y0mmpBo9QPaAkyp4sdHmZxTbrHdIhzItZ+GDV13jkn5EpAxDwj3W/H9Nk3weHx7Id/3KSvRBRM070jVo9DGksO0I/b9KhgBXU6hqRY6m5ok/sG3rd5J2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953561; c=relaxed/simple;
	bh=mGmvsLYGbl5StfulFfKED3RI+RHo0mK8xf/sBiNNDys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b8vAbggc1ey1IdfL/VTG9HhyA0aZJds3dDD84NdAoTU9ATW/bclJ+zEBB2q+ED3XBamTpwSck8AYLFVR6SLgihwOOI+X6HOhyDRMTsh/JoiGXJRQuMZzVJakiGY9pE15tj2OweWFDmUoUqy8WNoOXWCozzXnLLSLYRb5yoW7uwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZAMlduDg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T1TsHn026579;
	Wed, 29 May 2024 03:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UeX9dqG5LNZnU0NJjRWeuKT/wg9QJproSNKHyt1TmhY=; b=ZAMlduDgGLjvPXJj
	H8F2s3A6mSb7i2usmMFb0W0dS1bmYdKWI1DtBK+QvQU+P3c3YzqOcU+izDxJM8ei
	8ZTqY3wK4ElBLJbQfEqLn2I0TNzmRxqOeb7znHG4oQfqIGtuEDRZUrqVVxUtPEDi
	ty1gJg0ZBvKiL8yU7O1xJcVNxhkBWC2YwyAiDFsSnGsOxL/xtVYnE9LLRKqvyv93
	6ri8HLjKlNRa7inU3Bv+I5hpjqMs5SXzCmXrRGHEnihybDP+ybOFs3gDnqBJPS4X
	jQVKdTDXea2jS1qMjJrMAVvOPB+Romdg9Oefowr7bhhyIE1A479Sf9OBVp9QJIkb
	NcBGJA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qfv8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 03:32:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44T3WAfB002500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 03:32:10 GMT
Received: from [10.110.47.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 20:32:06 -0700
Message-ID: <ecac6276-c2e1-43b8-88ad-6ae91cff18cf@quicinc.com>
Date: Tue, 28 May 2024 20:32:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: validate SO_TXTIME clockid coming from userspace
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
        <kernel@quicinc.com>,
        <syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com>,
        <syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com>
References: <20240528224935.1020828-1-quic_abchauha@quicinc.com>
 <2c363f12-dd52-4163-bbcd-9a017cff6dd4@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <2c363f12-dd52-4163-bbcd-9a017cff6dd4@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t-qtwwLBKCyK8KaH6i9BfvPBh6cRLmuo
X-Proofpoint-ORIG-GUID: t-qtwwLBKCyK8KaH6i9BfvPBh6cRLmuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=697 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290021



On 5/28/2024 6:15 PM, Martin KaFai Lau wrote:
> On 5/28/24 3:49 PM, Abhishek Chauhan wrote:
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
>> Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")
> 
> Patch lgtm. This should target for net-next instead of net. The Fixes patch is in net-next only.
> 
Thanks Martin. Let me raise a patch on net-next and add your acked-by to it as well. 

> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> 

