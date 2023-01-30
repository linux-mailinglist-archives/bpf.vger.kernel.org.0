Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9E680435
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 04:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjA3DMb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 22:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjA3DMa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 22:12:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA97173B;
        Sun, 29 Jan 2023 19:12:29 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U33ToY013849;
        Mon, 30 Jan 2023 03:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kclOriWpISNLxXWJoT42BpPqrHqsb88X8+/rZ9ajcLo=;
 b=AE9zAvxF7DPQFu+GlaaxUqYPqqhEIB8bYqcNXiHfy5w4YcdJd7o0u5gV38B0zZV1Acxx
 cAwAz0fb4hp+o9O3yyBlzVkm0/5vzIh5JQQ0QoV63nE/ptClN9XVKdvloinCvWLg9b1G
 7yTnSknpOneM+XGrtUeiOLGK202o95ZbzM6FBLkR6KTrNk0NboLoya9p7FjbWVougSQQ
 J9XdCVvcp2Xw1uJ7ddLxCkSbRLoSGW9OtVBVTofAAiuqRq0BxKwn0sq0pJB9pU42Xsoe
 kT/FEeWukgcp7VL3NEKa3urJptC1P6a6wcx8hwC6WDMYL5hEsDgKyFcDjAqYbNhvyyGJ Vg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncw0g2h8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:12:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U3COV7027839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:12:24 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 19:12:22 -0800
Message-ID: <b130c320-33b8-4d7f-b718-7328f4e79569@quicinc.com>
Date:   Mon, 30 Jan 2023 11:12:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] trace: add new file under include/trace/stages/
 for perf/bpf
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com>
 <20230124144611.3476ad36@gandalf.local.home>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230124144611.3476ad36@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3yI5TCPwcFDg25QWMXVLYdHI1mTjkJdy
X-Proofpoint-ORIG-GUID: 3yI5TCPwcFDg25QWMXVLYdHI1mTjkJdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300029
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 1/25/2023 3:46 AM, Steven Rostedt wrote:
> On Fri, 16 Dec 2022 17:03:04 +0800
> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
>> when experiment change for trace operation, the files under
>> include/trace/stages/ will be changed, perf/bpf trace may compile fail.
> Sorry for the late reply, I was expecting some feedback from the perf
> and/or BPF folks.
>
>> add new file stage8_perf_call.h and stage9_bpf_call.h under
>> include/trace/stages/, it will make sure no missing change when expriment.
>>
> Actually, these are not part of the stage sequence. In fact they could


thanks for explanation.


> possibly be replaced *with* the stage sequences (which I think I'll apply):
>
> For example:
>
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 155c495b89ea..1f7fc1fc590c 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -4,50 +4,7 @@
>   
>   #ifdef CONFIG_BPF_EVENTS
>   
> -#undef __entry
> -#define __entry entry
> -
> -#undef __get_dynamic_array
> -#define __get_dynamic_array(field)	\
> -		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
> -
> -#undef __get_dynamic_array_len
> -#define __get_dynamic_array_len(field)	\
> -		((__entry->__data_loc_##field >> 16) & 0xffff)
> -
> -#undef __get_str
> -#define __get_str(field) ((char *)__get_dynamic_array(field))
> -
> -#undef __get_bitmask
> -#define __get_bitmask(field) (char *)__get_dynamic_array(field)
> -
> -#undef __get_cpumask
> -#define __get_cpumask(field) (char *)__get_dynamic_array(field)
> -
> -#undef __get_sockaddr
> -#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
> -
> -#undef __get_rel_dynamic_array
> -#define __get_rel_dynamic_array(field)	\
> -		((void *)(&__entry->__rel_loc_##field) +	\
> -		 sizeof(__entry->__rel_loc_##field) +		\
> -		 (__entry->__rel_loc_##field & 0xffff))
> -
> -#undef __get_rel_dynamic_array_len
> -#define __get_rel_dynamic_array_len(field)	\
> -		((__entry->__rel_loc_##field >> 16) & 0xffff)
> -
> -#undef __get_rel_str
> -#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
> -
> -#undef __get_rel_bitmask
> -#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
> -
> -#undef __get_rel_cpumask
> -#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
> -
> -#undef __get_rel_sockaddr
> -#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
> +#include "stages/stage6_event_callback.h"
>   
>   #undef __perf_count
>   #define __perf_count(c)	(c)
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index 8f3bf1e17707..2c11181c82e0 100644
> --- a/include/trace/perf.h
> +++ b/include/trace/perf.h
> @@ -4,51 +4,7 @@
>   
>   #ifdef CONFIG_PERF_EVENTS
>   
> -#undef __entry
> -#define __entry entry
> -
> -#undef __get_dynamic_array
> -#define __get_dynamic_array(field)	\
> -		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
> -
> -#undef __get_dynamic_array_len
> -#define __get_dynamic_array_len(field)	\
> -		((__entry->__data_loc_##field >> 16) & 0xffff)
> -
> -#undef __get_str
> -#define __get_str(field) ((char *)__get_dynamic_array(field))
> -
> -#undef __get_bitmask
> -#define __get_bitmask(field) (char *)__get_dynamic_array(field)
> -
> -#undef __get_cpumask
> -#define __get_cpumask(field) (char *)__get_dynamic_array(field)
> -
> -#undef __get_sockaddr
> -#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
> -
> -#undef __get_rel_dynamic_array
> -#define __get_rel_dynamic_array(field)	\
> -		((void *)__entry +					\
> -		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
> -		 sizeof(__entry->__rel_loc_##field) +			\
> -		 (__entry->__rel_loc_##field & 0xffff))
> -
> -#undef __get_rel_dynamic_array_len
> -#define __get_rel_dynamic_array_len(field)	\
> -		((__entry->__rel_loc_##field >> 16) & 0xffff)
> -
> -#undef __get_rel_str
> -#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
> -
> -#undef __get_rel_bitmask
> -#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
> -
> -#undef __get_rel_cpumask
> -#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
> -
> -#undef __get_rel_sockaddr
> -#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
> +#include "stages/stage6_event_callback.h"
>   
>   #undef __perf_count
>   #define __perf_count(c)	(__count = (c))
> diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
> index 49c32394b53f..919b1a4da980 100644
> --- a/include/trace/stages/stage6_event_callback.h
> +++ b/include/trace/stages/stage6_event_callback.h
> @@ -2,6 +2,9 @@
>   
>   /* Stage 6 definitions for creating trace events */
>   
> +/* Reuse some of the stage 3 macros */
> +#include "stage3_trace_output.h"
> +
>   #undef __entry
>   #define __entry entry
>   
