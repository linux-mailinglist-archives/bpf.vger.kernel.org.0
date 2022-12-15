Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AED64D604
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 06:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLOFIg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 00:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOFIf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 00:08:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EFA2A409;
        Wed, 14 Dec 2022 21:08:33 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF0Q9Yb013642;
        Thu, 15 Dec 2022 05:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vV63i7XPhQuKxkmnB4IHSWLm80MbU9MQxTkVDGq/ubE=;
 b=QYrRiLs/IJ1yR3ZAtXaidzUGmgrEi0XarMzLYkGzQDS9VZGY89JEJdw9U4jlkwBFr75p
 oGdfTt94evNZRDvqfHVzg2Eo5slrS2t7hrDR4NQOzHNttJaKg9NG/4oAwVT2j8kny2Zn
 7rIfWEqmRz2C5gIk2QVGrG0gaTioXH5EJfP9L/rHWY7GrOXQde2zDWqAi1MFWmX0jghL
 8s1KSQDsZ5B/DnhVhxsD3p0LGlj2fVsxaY3qrgBPoGSFayPSeAy6jXPmxWj1UC+lMFsl
 ISGwKcL8+pQc9N5Zu6RsF7m/d3dX9E7aYP05WyePMtqQckPtZcdG5pZzu/9bJxiB//Ao Kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rru9eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 05:08:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BF58OCU010851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 05:08:24 GMT
Received: from [10.253.79.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 21:08:23 -0800
Message-ID: <fea0e9c9-18b6-0b6f-9e5e-5632d7ab6eea@quicinc.com>
Date:   Thu, 15 Dec 2022 13:08:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] trace: allocate space from temparary trace
 sequence buffer
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <1671078807-20748-1-git-send-email-quic_linyyuan@quicinc.com>
 <1671078807-20748-2-git-send-email-quic_linyyuan@quicinc.com>
 <20221214235402.5ea7489e@gandalf.local.home>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20221214235402.5ea7489e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PNYOKtCmyB1YIb_nJxPdIM7WlbdJtzTC
X-Proofpoint-ORIG-GUID: PNYOKtCmyB1YIb_nJxPdIM7WlbdJtzTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_02,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 12/15/2022 12:54 PM, Steven Rostedt wrote:
> On Thu, 15 Dec 2022 12:33:27 +0800
> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
>> there is one dwc3 trace event declare as below,
>> DECLARE_EVENT_CLASS(dwc3_log_event,
>> 	TP_PROTO(u32 event, struct dwc3 *dwc),
>> 	TP_ARGS(event, dwc),
>> 	TP_STRUCT__entry(
>> 		__field(u32, event)
>> 		__field(u32, ep0state)
>> 		__dynamic_array(char, str, DWC3_MSG_MAX)
>> 	),
>> 	TP_fast_assign(
>> 		__entry->event = event;
>> 		__entry->ep0state = dwc->ep0state;
>> 	),
>> 	TP_printk("event (%08x): %s", __entry->event,
>> 			dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
>> 				__entry->event, __entry->ep0state))
>> );
>> the problem is when trace function called, it will allocate up to
>> DWC3_MSG_MAX bytes from trace event buffer, but never fill the buffer
>> during fast assignment, it only fill the buffer when output function are
>> called, so this means if output function are not called, the buffer will
>> never used.
>>
>> add __get_buf(len) which allocate space from iter->tmp_seq when trace
>> output function called, it allow user write any data to allocatd space.
>>
>> the mentioned dwc3 trace event will changed as below,
>> DECLARE_EVENT_CLASS(dwc3_log_event,
>> 	TP_PROTO(u32 event, struct dwc3 *dwc),
>> 	TP_ARGS(event, dwc),
>> 	TP_STRUCT__entry(
>> 		__field(u32, event)
>> 		__field(u32, ep0state)
>> 	),
>> 	TP_fast_assign(
>> 		__entry->event = event;
>> 		__entry->ep0state = dwc->ep0state;
>> 	),
>> 	TP_printk("event (%08x): %s", __entry->event,
>> 		dwc3_decode_event(__get_buf(DWC3_MSG_MAX), DWC3_MSG_MAX,
>> 				__entry->event, __entry->ep0state))
>> );.
>>
>> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
>
> No!
ok, so you don't like a common function in trace_seq.c ?
>
> Here, I did it for you:
>
> -- Steve
>
> diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
> index 48b44b88dc25..81abdcbfc660 100644
> --- a/drivers/usb/dwc3/debug.h
> +++ b/drivers/usb/dwc3/debug.h
> @@ -11,6 +11,7 @@
>   #ifndef __DWC3_DEBUG_H
>   #define __DWC3_DEBUG_H
>   
> +#include <linux/trace_seq.h>
>   #include "core.h"
>   
>   /**
> @@ -381,6 +382,19 @@ static inline const char *dwc3_decode_event(char *str, size_t size, u32 event,
>   		return dwc3_ep_event_string(str, size, &evt.depevt, ep0state);
>   }
>   
> +static inline const char *dwc3_decode_event_seq(struct trace_seq *p,
> +						u32 event, u32 ep0state)
> +{
> +	char *str = trace_seq_buffer_ptr(p);
> +	int size = seq_buf_buffer_left(&p->seq);
> +
> +	dwc3_decode_event(str, size, event, ep0state);
> +
> +	seq_buf_commit(&p->seq, strlen(str));
> +
> +	return str;
> +}
> +
>   static inline const char *dwc3_ep_cmd_status_string(int status)
>   {
>   	switch (status) {
> diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
> index 1975aec8d36d..bee2589e85a8 100644
> --- a/drivers/usb/dwc3/trace.h
> +++ b/drivers/usb/dwc3/trace.h
> @@ -54,15 +54,13 @@ DECLARE_EVENT_CLASS(dwc3_log_event,
>   	TP_STRUCT__entry(
>   		__field(u32, event)
>   		__field(u32, ep0state)
> -		__dynamic_array(char, str, DWC3_MSG_MAX)
>   	),
>   	TP_fast_assign(
>   		__entry->event = event;
>   		__entry->ep0state = dwc->ep0state;
>   	),
>   	TP_printk("event (%08x): %s", __entry->event,
> -			dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
> -					__entry->event, __entry->ep0state))
> +			dwc3_decode_event_seq(p, __entry->event, __entry->ep0state))
>   );
>   
>   DEFINE_EVENT(dwc3_log_event, dwc3_event,
