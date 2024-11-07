Return-Path: <bpf+bounces-44306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E15D9C1199
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 23:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995EF1F23DC0
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EBF21892D;
	Thu,  7 Nov 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F0RjzsW6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023202178FC
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017975; cv=none; b=IDqpeaYcvlW9IQj5nsKQkQsi4gSnbk7YwY1NYur07glTC4uzZ889TQNqk4Gi3sg2ZzwM68OpxMU03DQpExFGlBCJeqpwlygVNwhgXIK7F0iVR+sCN9AJ69B/AbMVpZ3F/rYnoYioO7/Tj4N8nFvlwkdGZSXQJgWxFDSX7Mv9tvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017975; c=relaxed/simple;
	bh=+e2SgZiidAPh341FGgO5kn8VwM8WPeZNDEGRYSw3Swo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eW4haMGE+kUiHvlzeilZV8tTRxpVjp9DE9vuv0tlnaccc7ZzGPyCTKzK2ccu9tLE6BPzFzryW3CBu1hyJDsh7+zCtdCMhcOYgBRbpdkZc9VqbNXBvxTjsw0aF7er1BSHWOVS6V8z/PFZ6J/n4+YybF3vFGmcYtCrUkSiT1QBHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F0RjzsW6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HLZv4020644;
	Thu, 7 Nov 2024 22:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N/xXIGSKdTMXG2WL6pYXvvuzyAwIgYtuu1Q412yojRI=; b=F0RjzsW6E2WiqO5F
	AqcLkBuVkJmxb1c6ES5ne0+Uy9Dl1rr/BF+h07EKTko9Nv/MKzK4R0qUN5ZZPxQy
	EaGhyhoGtLTsGrT1CbLbq+UIXlo9Dgg338zsbDcxZHCXqzrzam45O2fXkCVd5rNf
	FKETLOWK+IhsBwd/n7QFyZOmG5KaQUCcxZBr//bGJ6EMYFeqIT5qQQAn+WlDaCbV
	wVj+kdy8U7epYB/nS1MUq7g0vN/EinYSU+vZx7vh3LNoFOgVKe5WSD3ay03PRG17
	xMom1GMLsqcRY7MVhArpRPmckxzYoclZwqOXnNf1HKSsbVj17x9UBis546KVDUnX
	Acb9OQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ry701901-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 22:19:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7MJ4R2003576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 22:19:04 GMT
Received: from [10.48.242.241] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 14:19:04 -0800
Message-ID: <4e809347-4b5e-4e6c-8c60-8eea19292165@quicinc.com>
Date: Thu, 7 Nov 2024 14:19:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 10/11] selftests/bpf: tests to verify handling of
 inlined kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>
CC: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
        <kernel-team@fb.com>, <yonghong.song@linux.dev>, <memxor@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
 <20241107175040.1659341-11-eddyz87@gmail.com>
 <ff32dfb9-5fd5-4d43-9a8b-f640da32e000@quicinc.com>
 <5a82fa4bcb3c342a8bb305945baed072d4b89a92.camel@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <5a82fa4bcb3c342a8bb305945baed072d4b89a92.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DCkcHF1PGyLaf-Fr06yRbklBLiv-2VIc
X-Proofpoint-ORIG-GUID: DCkcHF1PGyLaf-Fr06yRbklBLiv-2VIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=856
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070174

On 11/7/2024 2:08 PM, Eduard Zingerman wrote:
> On Thu, 2024-11-07 at 14:04 -0800, Jeff Johnson wrote:
> 
> [...]
> 
>> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
>> description is missing"), a module without a MODULE_DESCRIPTION() will
>> result in a warning when built with make W=1. Not sure if this is
>> applicable to your new module, but if so, please add the missing
>> MODULE_DESCRIPTION().
>>
> 
> Hi Jeff,
> 
> Thank you for the heads-up.
> The MODULE_DESCRIPTION is already present in the bpf_testmod.c
> (this file is renamed in the RFC, but remains as a part of the module).

Does bpf_testmod.c already have a MODULE_LICENSE(). If so, then I'd drop the
extra one in test_inlinable_kfuncs.c.

My reviews on this subject are triggered by the lore search pattern:
MODULE_LICENSE AND NOT MODULE_DESCRIPTION

Since it is expected that the two should appear together.

