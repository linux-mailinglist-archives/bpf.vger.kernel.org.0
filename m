Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F2764D51E
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 02:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLOBxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 20:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLOBxi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 20:53:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B8E50D5B;
        Wed, 14 Dec 2022 17:53:37 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF0mGcZ008097;
        Thu, 15 Dec 2022 01:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ay6J4/M84fQa4iYnSHtIR8AeJW0o0nvZ0WzUDtR/rhc=;
 b=WaS7vnt6z0Cef3wYth3Urb+j+V8V9k/Wva/zCg2UV3g35N7F4j7G4ViM1GJ8Fdc9eMU7
 i0VpxKued80FT0c50bf6bEBYaQ7h960xJ7JKBLwb7TAWy2Ve7PFEzAMqJ6z0sNjENQPw
 ZrDvl53sjHNMv88H7UxfjxaAn33igYf0helASaqFe78FcjeuB76Re22A0rWxxGT6U9On
 jGxeL4XBoJrvKSrf4YNmCPwjhRPSmcAE28MAPN7U6elBqD7ANItbAAE82KjjLmTWBBPs
 XNqm5Ya9eSoiA3lxA878k+zk0aqUDyWE+mm84NhPPjFpzRlgoCT+TjeGkrfUPwDlh6Ef 6w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rrjxrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 01:53:33 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BF1rV0h029240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 01:53:31 GMT
Received: from [10.253.79.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 17:53:29 -0800
Message-ID: <125146b7-3371-2d66-4d25-b829d9f334ea@quicinc.com>
Date:   Thu, 15 Dec 2022 09:53:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 2/2] trace: allocate temparary buffer for trace output
 usage
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <1671027102-21403-1-git-send-email-quic_linyyuan@quicinc.com>
 <1671027102-21403-2-git-send-email-quic_linyyuan@quicinc.com>
 <20221214092550.1691829e@gandalf.local.home>
 <f929751c-d299-b1d4-7163-74a3ffb18bfe@quicinc.com>
In-Reply-To: <f929751c-d299-b1d4-7163-74a3ffb18bfe@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v-iHzcB8krMvbDqYUVR40btblnZTb1S6
X-Proofpoint-ORIG-GUID: v-iHzcB8krMvbDqYUVR40btblnZTb1S6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_12,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=873
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

is it possible add a generic macro like #define __get_buf(offset, len)  
(p->buffer + (offset))  ?

it only use buffer filed of struct trace_seq .

On 12/15/2022 9:22 AM, Linyu Yuan wrote:
> thanks for remind, will check and use it.
>
>
> thanks
>
> On 12/14/2022 10:25 PM, Steven Rostedt wrote:
>> On Wed, 14 Dec 2022 22:11:42 +0800
>> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>>
>>> there is one dwc3 trace event declare as below,
>>> DECLARE_EVENT_CLASS(dwc3_log_event,
>>>     TP_PROTO(u32 event, struct dwc3 *dwc),
>>>     TP_ARGS(event, dwc),
>>>     TP_STRUCT__entry(
>>>         __field(u32, event)
>>>         __field(u32, ep0state)
>>>         __dynamic_array(char, str, DWC3_MSG_MAX)
>>>     ),
>>>     TP_fast_assign(
>>>         __entry->event = event;
>>>         __entry->ep0state = dwc->ep0state;
>>>     ),
>>>     TP_printk("event (%08x): %s", __entry->event,
>>>             dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
>>>                 __entry->event, __entry->ep0state))
>>> );
>>> the problem is when trace function called, it will allocate up to
>>> DWC3_MSG_MAX bytes from trace event buffer, but never fill the buffer
>>> during fast assignment, it only fill the buffer when output function 
>>> are
>>> called, so this means if output function are not called, the buffer 
>>> will
>>> never used.
>>>
>>> add __alloc_buf() and __get_buf() which will not allocate event buffer
>>> when trace function called, but when trace output function called, 
>>> it will
>>> kmalloc buffer with size DWC3_MSG_MAX for temprary usage and free it
>>> before trace output function return.
>> This looks exactly like what the trace_seq *p is to be used for.
>>
>> static notrace enum print_line_t                    \
>> trace_raw_output_##call(struct trace_iterator *iter, int flags,        \
>>             struct trace_event *trace_event)        \
>> {                                    \
>>     struct trace_seq *s = &iter->seq;                \
>>     struct trace_seq __maybe_unused *p = &iter->tmp_seq;        \
>>                                          ^^^^^^^^^^^^^^^^^^^^
>>
>>     struct trace_event_raw_##call *field;                \
>>     int ret;                            \
>>                                     \
>>     field = (typeof(field))iter->ent;                \
>>                                     \
>>     ret = trace_raw_output_prep(iter, trace_event);            \
>>     if (ret != TRACE_TYPE_HANDLED)                    \
>>         return ret;                        \
>>                                     \
>>     trace_event_printf(iter, print);                \
>>                                     \
>>     return trace_handle_return(s);                    \
>> }                                    \
>>
>> That is a trace_seq buffer that is for temporary usage during the 
>> output.
>>
>> See:
>>    include/trace/events/libata.h
>>    include/trace/events/scsi.h
>>
>> As well as the macros trace_print_bitmask_seq(), 
>> trace_print_flags_seq(),
>> trace_print_symbols_seq(), etc.
>>
>> -- Steve
>>
