Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E0664E5D0
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 03:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLPCFY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 21:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiLPCFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 21:05:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950DA389E1;
        Thu, 15 Dec 2022 18:05:22 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFNxuTh023343;
        Fri, 16 Dec 2022 02:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GEA8hmZbE1oPUuiBBVvTXblNeCIpWNgJNzV47oqrkx4=;
 b=PrxWZV2jFL8NGZR20Z1500z5Eq1vGQW+PL36WwiMn8X9NgPtNnJ3XlhEgK/sDfK2cDEY
 kqnERJs19EEiWVH4+LqHKlzJWiONQPDcL0SskrG+E8fDSQkFUIIO8WBl5bGgA5xUVYsm
 5ufOluQdTZG4t7C7f5Vzp4IM+hlHkK2JhwUQ7eG5Yg9UJZgE/FHCslZW4DTRqv7YyRom
 IGrWXcgf/6L/7gBrFa2ZlpxyQzr9m8QNZE81+yvsQFCg8kcIkCISaJh1tkynsSmHYgWd
 +K7lmcq2sumDQ6o4hgbDgtEhSsVG9lM3qplsIXbsHiiceOwa/OD9Vh8CeqmfTW6fxnTm xg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg06ru269-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 02:05:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BG25IBp015883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 02:05:18 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 15 Dec
 2022 18:05:16 -0800
Message-ID: <9b2ec1b4-0494-12fb-8cbb-aa63f47085fc@quicinc.com>
Date:   Fri, 16 Dec 2022 10:05:14 +0800
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
 <20221215082345.56276315@gandalf.local.home>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20221215082345.56276315@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ooZ_O7waCuTuYX_Dz0hVNrTyGDlnDdGU
X-Proofpoint-ORIG-GUID: ooZ_O7waCuTuYX_Dz0hVNrTyGDlnDdGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_12,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160018
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 12/15/2022 9:23 PM, Steven Rostedt wrote:
> On Thu, 15 Dec 2022 12:33:27 +0800
> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
>> --- a/include/linux/trace_seq.h
>> +++ b/include/linux/trace_seq.h
>> @@ -95,6 +95,7 @@ extern void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
>>   extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
>>   			      int prefix_type, int rowsize, int groupsize,
>>   			      const void *buf, size_t len, bool ascii);
>> +void *trace_seq_alloc_buffer(struct trace_seq *s, int len);
> So, I really don't like the name with "alloc" in it. That makes the
> assumption that it also needs to be freed. Which it does not, and why it
> confused me last night.
>
> A better name would be trace_seq_acquire(s, len);
>
> And it should return a char *, as it it process stings and not arbitrary
> binary data.
thanks, will update next version.
>
>> +/**
>> + * trace_seq_alloc_buffer - allocate seq buffer with size len
>> + * @s: trace sequence descriptor
>> + * @len: size of buffer to be allocated
>> + *
>> + * allocate space with size of @len from seq buffer for output usage,
>> + * On success, it returns start address of the allocated buffer,
>> + * user can fill data start from the address, user should make sure the
>> + * data length not exceed the @len, if it exceed, behavior is undefined.
>> + *
>> + * Returns NULL if no buffer can be allocated, it also means system will
>> + * crash, it is user responsiblity to make sure total buffer used will
>> + * not exceed PAGE_SIZE.
>> + *
>> + * it allow multiple usage in one trace output function call.
>> + */
>> +void *trace_seq_alloc_buffer(struct trace_seq *s, int len)
> char *trace_seq_acquire(struct trace_seq *s, int len)
>
>> +{
>> +	char *buf = trace_seq_buffer_ptr(s);
>> +
> You need to check the length first before committing:
>
> 	if (seq_buf_buffer_left(&s->seq) < len)
> 		return NULL;
will change next version.
> 	
>> +	seq_buf_commit(&s->seq, len);
> Because the above is a bug if len is too big.
>
>> +
>> +	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
> And then we don't need this either.
>
> I must apologize for the response last night. It was past my normal bed
> time, and I must really avoid reviewing patches when I should be going to
> bed ;-)

sorry to bring your attention near your bed time.

I accept late response next time 😁.

thanks again for all your comment today, it is very good.

>
> -- Steve
>
>
>> +		s->full = 1;
>> +		return NULL;
>> +	}
>> +
>> +	return (void *)buf;
>> +}
>> +EXPORT_SYMBOL(trace_seq_alloc_buffer);
