Return-Path: <bpf+bounces-44304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD69C1177
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 23:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6ADB21DB3
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066221830E;
	Thu,  7 Nov 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JgXZuTi8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A5215C6D
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017093; cv=none; b=uH6HVb4PZJUR+k0yazijZO6aDw/eHtgAK31PKC3nEJb8SkoBQR/puatcaJi8yU3WuOPVT/PGrQ8gtSDMOc+Sr9E/ltBwunx6uTzdVS8vB/MW94LRTZwY0mWSOakIKjccGtWBBEpMexyJfjyV5Wnl2YOSkArqWPrJNM5jmhtqtd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017093; c=relaxed/simple;
	bh=dmaGCj0V4zHbjLVqd4UC3x/CNUMJqeSWrD1vslBrsT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pkNt9rjFTI8plR7aklirIkTvYXkvl95KsL03ASesSXY5HyaTVeWJ+4Zw08jHAoykwcuO5BHgn9Z1Hfvdy//JTfZmffq4NJoUfJpwP4Z5WrdGPKJmv6fEziN+WlFqq9h9OEpq6aONLtFL9M0PGECbGL54d9kKH+jFsBjF4xumOmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JgXZuTi8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HLd4i005175;
	Thu, 7 Nov 2024 22:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dmaGCj0V4zHbjLVqd4UC3x/CNUMJqeSWrD1vslBrsT4=; b=JgXZuTi8+0PDyTz/
	JMIqweAjG3Z4IFjx3Madcfij3xuKZSg5MWX5ITTNQw6DbFkGdK4MrK/WbhfWVfnq
	TeHiQ5okIY2rXQ3hP/kIrC0evQFfhhOyrcmsqbjJtok1EjOEP4WGRtTvdLEP/WYo
	xuMMTPRQStAxoJuUlAE8GsradCexk72DxWx6MhiZpfbSsojD2jVMLZKjFrFd9+YK
	uwBe5Bj0IDWfdyddLSI4HGILHaaTmLcd3G2A+i7YYHfyPBOfnBDj72Wn0tVcrj44
	fTjZQD+LWDIDGu16zgJ0E0j1l/1ZsbwIdmzOxvfr3HvXOBngApNbjQSex0/0Nk8F
	a7joYw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qp2rysws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 22:04:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7M4UXs018130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 22:04:30 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 14:04:30 -0800
Message-ID: <ff32dfb9-5fd5-4d43-9a8b-f640da32e000@quicinc.com>
Date: Thu, 7 Nov 2024 14:04:29 -0800
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
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241107175040.1659341-11-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0RBIQulL3PAFPKUBGEt1bbMeqy3l7j-L
X-Proofpoint-ORIG-GUID: 0RBIQulL3PAFPKUBGEt1bbMeqy3l7j-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxlogscore=779 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070172

On 11/7/24 09:50, Eduard Zingerman wrote:
...
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/test_inlinable_kfuncs.c b/tools/testing/selftests/bpf/bpf_testmod/test_inlinable_kfuncs.c
> new file mode 100644
> index 000000000000..d8b90ee7f2b0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_testmod/test_inlinable_kfuncs.c
> @@ -0,0 +1,132 @@
...
> +MODULE_LICENSE("Dual BSD/GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Not sure if this is
applicable to your new module, but if so, please add the missing
MODULE_DESCRIPTION().


