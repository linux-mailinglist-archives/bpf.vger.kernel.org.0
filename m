Return-Path: <bpf+bounces-45997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8929E199C
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 11:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC3B1666FB
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FCF1E2603;
	Tue,  3 Dec 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="haOnfxa0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A651E22E9;
	Tue,  3 Dec 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222548; cv=none; b=KICGQUblVElLZwIBwKoK0yF+CB1KQ0CNOwMUhuJJDwj7KJwfp+o4HmMN6b/CaDJWI+oaLE2DbXebuRU6AqlJ3uM6svOuoaIulXCVhdEXXBleaDEo2YzGuC9iEmFcjwunVgzRlQUN1cEteFnzYkG0OoYZTlSpiv7DXZAXmFsYBsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222548; c=relaxed/simple;
	bh=huDWne30J5ob4zsS1bNSlBR9Y1rYCh2kjshpdpHvoIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oj+DbM9J7sNWzCpHyAuzJWReYWezhCSyHCy4uIqKMSWhGLPRWK7TWV7SkAPjfLS2BjoJ2YHDb1E6w+ok49xSCEBZXiV6WLxv3HcExTVcTEhW2TL7rLmfT13POX5I8KvZDwZsFsPcTfHVPTBnP3ZrjxRPFZ788cr0fLvmI2LFlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=haOnfxa0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B38JfKY027880;
	Tue, 3 Dec 2024 10:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eCQE5jN00zJcuauOCTLwZrT7GsJeMG7eyAEO1hGFE8Y=; b=haOnfxa0PVsqapGn
	v0iAlk29s23mXpU918TYooJmvQrUr5pQwlgPYXO1q1pr/yDe3MIfLU2ebvYBn1pw
	FEI0E3AWv6xE0AE+bhwCS/dnxkEk6o3Y5yfFrGS5tFa8w8ZZC3ob/KB+BRPfXas+
	tOhhSimPXV2QvgzbArCEKwyRYPNlllHBzyxWQmx0dOfS65XwfiCdFEg9MN5a3jHz
	J7sRr+rizZp2D1vBRoN3ZFcEBN4++mJyeplqDXNYOSMUa8EV9Ryyb+0Yr5WDW8Cp
	9v495IZ7EJxFiyAedBCtJPkh6ztreZ35L41cUYY117+rdAKgpisAuBHkoR4K11ct
	YzzgWg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437tstfsk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 10:42:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3Ag4RW013842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 10:42:04 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 02:42:00 -0800
Message-ID: <577fb7ea-f540-4ca0-9569-3bd5bee87df8@quicinc.com>
Date: Tue, 3 Dec 2024 18:41:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf tool: Fix multiple memory leakages
To: Namhyung Kim <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@linaro.org>,
        <yangyicong@hisilicon.com>, <song@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
References: <20241128125432.2748981-1-quic_zhonhan@quicinc.com>
 <Z04u-7DQr5w9daS5@google.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <Z04u-7DQr5w9daS5@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: djibvdknjQX8f7VbEhxQnJS14VM8ZfqT
X-Proofpoint-GUID: djibvdknjQX8f7VbEhxQnJS14VM8ZfqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030091

On 12/3/2024 6:04 AM, Namhyung Kim wrote:
> On Thu, Nov 28, 2024 at 08:54:29PM +0800, Zhongqiu Han wrote:
>> Fix memory leakages when btf_node or bpf_prog_info_node is duplicated
>> during insertion into perf_env.
>>
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>> Zhongqiu Han (3):
>>    perf header: Fix one memory leakage in process_bpf_btf()
>>    perf header: Fix one memory leakage in process_bpf_prog_info()
>>    perf bpf: Fix two memory leakages when calling
>>      perf_env__insert_bpf_prog_info()
> 
> Although I have a nitpick in the patch 3, it looks good otherwise.
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> 
Hi Namhyung,
Thanks for your review~
I will arise the V2 to optimize patch 3.

> And I don't think the Fixes tags are correct, but it won't apply before
> the change it points to.  So for practical reason, I'm ok with that.
> 
> Thanks,
> Namhyung
> 

I will fix the Fixes tag as follows on V2:

[PATCH 1/3] perf header: Fix one memory leakage in process_bpf_btf()
Fixes: a70a1123174a ("perf bpf: Save BTF information as headers to
perf.data")

[PATCH 2/3] perf header: Fix one memory leakage in
process_bpf_prog_info()
Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as
headers to perf.data")


[PATCH 3/3] perf bpf: Fix two memory leakages when calling
perf_env__insert_bpf_prog_info()
Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in
perf_env")
Fixes: d56354dc4909 ("perf tools: Save bpf_prog_info and BTF of new BPF
programs")


>>
>>   tools/perf/util/bpf-event.c | 10 ++++++++--
>>   tools/perf/util/env.c       | 12 ++++++++----
>>   tools/perf/util/env.h       |  4 ++--
>>   tools/perf/util/header.c    |  8 ++++++--
>>   4 files changed, 24 insertions(+), 10 deletions(-)
>>
>>
>> base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
>> -- 
>> 2.25.1
>>


-- 
Thx and BRs,
Zhongqiu Han

