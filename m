Return-Path: <bpf+bounces-45998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2679E19BB
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 11:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78992288D2C
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370D61E3789;
	Tue,  3 Dec 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UKnCqHRr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3A1E25EC;
	Tue,  3 Dec 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222773; cv=none; b=VIL4YlgycEx2yQI1fGEHkIJmdk696v06oX7F4zrBOivzUxt0MN9ZbApIZJbsZH96w6ymU+6hIWsv6RC9sgC+ETq0hehzt6ED3WKj3voKBLxv2pIVLg0b0XZFr6b6Y7MgDrZMfqZIfVw38Mk2Qsw5W7qysxyIRJ/p6HM5QChJn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222773; c=relaxed/simple;
	bh=P51bhc3HZ3o911SSeg8+stkV+cAHvwFIJ068zwsw+4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AzwRkmni5Te1EBZ/R5u3W8R0YUH76RMBB9AOeo3K7PT8iKKc34VIID2ARdj9lFpYtR9z0zrLm3t4qZ4JwSNxNh4fCzJd0RRT/JxESlFu/qes1PeZlpWhSmx2tlErrxKxAAPjpqSS+zbgcqENGxbf5dRws/hLN1a+b7IrdL5l/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UKnCqHRr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B362c2m027841;
	Tue, 3 Dec 2024 10:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UN0XSC5qycfF5izJMc2/kTr5aNMxSwmq9lk/LJNJHAE=; b=UKnCqHRr6h7c9L+G
	SOUED9IjML+F6Wq4l6MVo+/n63ONsACHcyNcKpfdwX+DOuhJYPM4inCAazjGwrTM
	UrcLm9UbC5vyB60B481/9B4Sr6PxifDtM+Joiah0cviayC3ka41Sxh28rrYkZZUG
	yWxWdH6ZKGs66aUuZPkSu5LusPAOeuhx6dsIYMVBGLdu2kRfniujuHLWs23w3gBM
	sGw5MhkxrFDuzR2V2IiW+Ffm7fEhJrxwxnmG8zyJWJL8FF8r7RVwLdCwZegVUhvQ
	80Ol5DE4OqUOZTapI4HIeYJ8JLey107dMHwIF44EBEL+IA2X1f567YNZcByhX5be
	DWTXzw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439vcegqwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 10:45:52 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3AjpEI023835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 10:45:51 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 02:45:47 -0800
Message-ID: <de297c20-8a91-48b5-96bd-e59019a780ef@quicinc.com>
Date: Tue, 3 Dec 2024 18:45:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf bpf: Fix two memory leakages when calling
 perf_env__insert_bpf_prog_info()
To: Namhyung Kim <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@linaro.org>,
        <yangyicong@hisilicon.com>, <song@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
References: <20241128125432.2748981-1-quic_zhonhan@quicinc.com>
 <20241128125432.2748981-4-quic_zhonhan@quicinc.com>
 <Z04uaWQxI3LXfAtg@google.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <Z04uaWQxI3LXfAtg@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sw8Ejl0PTIlAF3LzMLtkVf2tQuYRTu8e
X-Proofpoint-ORIG-GUID: sw8Ejl0PTIlAF3LzMLtkVf2tQuYRTu8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030092

On 12/3/2024 6:02 AM, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Nov 28, 2024 at 08:54:32PM +0800, Zhongqiu Han wrote:
>> If perf_env__insert_bpf_prog_info() returns false due to a duplicate bpf
>> prog info node insertion, the temporary info_node and info_linear memory
>> will leak. Add a check to ensure the memory is freed if the function
>> returns false.
>>
>> Fixes: 9c51f8788b5d ("perf env: Avoid recursively taking env->bpf_progs.lock")
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>>   tools/perf/util/bpf-event.c | 10 ++++++++--
>>   tools/perf/util/env.c       |  7 +++++--
>>   tools/perf/util/env.h       |  2 +-
>>   3 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
>> index 13608237c50e..c81444059ad0 100644
>> --- a/tools/perf/util/bpf-event.c
>> +++ b/tools/perf/util/bpf-event.c
>> @@ -289,7 +289,10 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>>   		}
>>   
>>   		info_node->info_linear = info_linear;
>> -		perf_env__insert_bpf_prog_info(env, info_node);
>> +		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
>> +			free(info_linear);
>> +			free(info_node);
>> +		}
>>   		info_linear = NULL;
>>   
>>   		/*
>> @@ -480,7 +483,10 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
>>   	info_node = malloc(sizeof(struct bpf_prog_info_node));
>>   	if (info_node) {
>>   		info_node->info_linear = info_linear;
>> -		perf_env__insert_bpf_prog_info(env, info_node);
>> +		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
>> +			free(info_linear);
>> +			free(info_node);
>> +		}
>>   	} else
>>   		free(info_linear);
>>   
>> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
>> index d7865ae5f8f5..38401a289c24 100644
>> --- a/tools/perf/util/env.c
>> +++ b/tools/perf/util/env.c
>> @@ -24,12 +24,15 @@ struct perf_env perf_env;
>>   #include "bpf-utils.h"
>>   #include <bpf/libbpf.h>
>>   
>> -void perf_env__insert_bpf_prog_info(struct perf_env *env,
>> +bool perf_env__insert_bpf_prog_info(struct perf_env *env,
>>   				    struct bpf_prog_info_node *info_node)
>>   {
>> +	bool ret = true;
> 
> Please add a blank line between declaration and the other statements.
> Also I think you can just use the return value of the internal function
> instead of initializaing it to true.
> 
> Thanks,
> Namhyung
> 
> 

Hi Namhyung,
Thanks for your review~

I will add a blank line between the declaration and the other
statements, and optimize it as below:


+bool perf_env__insert_bpf_prog_info(struct perf_env *env,
  				    struct bpf_prog_info_node
*info_node)
  {
+	bool ret;
+
  	down_write(&env->bpf_progs.lock);
-	__perf_env__insert_bpf_prog_info(env, info_node);
+	ret = __perf_env__insert_bpf_prog_info(env, info_node);
  	up_write(&env->bpf_progs.lock);
+	return ret;
  }


>>   	down_write(&env->bpf_progs.lock);
>> -	__perf_env__insert_bpf_prog_info(env, info_node);
>> +	if (!__perf_env__insert_bpf_prog_info(env, info_node))
>> +		ret = false;
>>   	up_write(&env->bpf_progs.lock);
>> +	return ret;
>>   }
>>   
>>   bool __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>> index 9db2e5a625ed..da11add761d0 100644
>> --- a/tools/perf/util/env.h
>> +++ b/tools/perf/util/env.h
>> @@ -178,7 +178,7 @@ int perf_env__nr_cpus_avail(struct perf_env *env);
>>   void perf_env__init(struct perf_env *env);
>>   bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
>>   				      struct bpf_prog_info_node *info_node);
>> -void perf_env__insert_bpf_prog_info(struct perf_env *env,
>> +bool perf_env__insert_bpf_prog_info(struct perf_env *env,
>>   				    struct bpf_prog_info_node *info_node);
>>   struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
>>   							__u32 prog_id);
>> -- 
>> 2.25.1
>>


-- 
Thx and BRs,
Zhongqiu Han

