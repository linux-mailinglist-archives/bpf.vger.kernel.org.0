Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59B31490B
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhBIGmh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:42:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54636 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhBIGmf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 01:42:35 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1196epdt004976;
        Mon, 8 Feb 2021 22:41:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=so4sR6Z9folNS9eudWJxG0NsGfvC3l7bj1CDQmwexTM=;
 b=JknuReQR+aF/ljf4IkiSg1dMo38bu5Pzn7d7Vn89JxTOizYgjvNSw3cO6kGsQzo5Ovt2
 YAlPGAiuWJFHaClav3uF66ED5Z31wvyllV8oz/IF+TDpBA6PjQcRY9jlXlwBkyRSPX+J
 D18XqaC0qEVr880Ma5aiaqNseVHlqujDjJw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jbnp1d1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 22:41:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 22:41:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=df0wTh4IQzXZgHe9hgjVB1yKrxiddHrRAh8b6DmCh0/upGHIdJ2PHpXmkBZtJQg83/0LG2dps8Ai6ORRQjGwcUDd2KVtNP0ecNzPpO9gZ4FrtWlZiUniUsyBheW1sRwiikiB9TIxC29lazdftCzPxga2ugr9AfT2lwcU15SiHH85bHhGWI9AudrjgFgkkAMXfp/HSaQ0/h+N6Nnt0scD2f/bGo9Jltu5v36jjBHGknX8R+kZue0FRT04Bky10sygptoF5HS6sojsMNU48Po5dGDeM+cxcpwWZvZbUdt0zJDTEfdhL00blz1BF2mfDAclpcQJCuJWv/f5X3ZwJns3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so4sR6Z9folNS9eudWJxG0NsGfvC3l7bj1CDQmwexTM=;
 b=cAHnHwBCS3Jw9NfwVY/MsB5SQyUGR2bdGiwBeF+0s/69BVWMGdQqDDx4n3hX02gzbXsdo/3lvBQEqWHq4eL0BPBXZnZbwzh9CNdbs3OmsQSoYVpfhYjQP0TPw0fiHt6sCWpoK5JNu6Y7OeNTfsiUcx2teBwHuerS1eCR3dlktBQh7FJboH2+3icZko3hnDKrKRgN1AnumHwwNfhDgLLiPT8HK6Pj+RXK+XSXqchr1XgqHMPmh/jZkhI6g0kszc6KIxhY7uAp/61j2SBN7fUCKgFSljVghaaiRD4OWkkU1wwptVHouBuajhDQREc0kDCpCOvmqJ4li91QeOxWe/w6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so4sR6Z9folNS9eudWJxG0NsGfvC3l7bj1CDQmwexTM=;
 b=II3x+pMFeMOeR/y81DfFTw3GtjTe5yiZSgeVa6L0weqAs/uaN7fO4yOCFbthWimk6Z/yZg3Tbb9z1n3OJKeBvRe3vbeo0Fm/lJT7oQth5Ue8jnqdND7UaGkezTPrHd6hTmKRk1KeSXnjbHX9Is8EqQu3meFap59Lnsc7kw+9MOk=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2694.namprd15.prod.outlook.com (2603:10b6:a03:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 06:41:30 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 06:41:30 +0000
Subject: Re: [PATCH bpf-next 2/8] bpf: add bpf_for_each_map_elem() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234829.1629159-1-yhs@fb.com>
 <CAEf4BzYL5cmWyyHq4RzMdOmCbmicvQSGMKCih-eVdOUM_q_0Rg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <93053744-a41b-c25e-2d4a-5aa03c2339db@fb.com>
Date:   Mon, 8 Feb 2021 22:41:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzYL5cmWyyHq4RzMdOmCbmicvQSGMKCih-eVdOUM_q_0Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:e222]
X-ClientProxiedBy: MWHPR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:300:ef::29) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1610] (2620:10d:c090:400::5:e222) by MWHPR22CA0019.namprd22.prod.outlook.com (2603:10b6:300:ef::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 9 Feb 2021 06:41:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8076f64e-78c1-44a4-337d-08d8ccc5bba8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB26943CB52572C488A9A84F7ED38E9@BYAPR15MB2694.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G41Ed9CexhtWnhXhFqsRIMSlXaTS2XlQa+WWJ2xkYrshiGRrmAv8EzWG0hRI228yhyHitGagtGc3PsuuHE2vKcXEWFyDqp6Ow53v8kEm9sCbdVRrU9euGP25UYCFwVczQvN6V3Z/F4cvlAFDjkmr3l4OjMOOZEhaqG4rmJ7rNnEikDmyICk6ghIbmOADv6dy36hW9j23sL4ht6d4eZHG0LAzEO4DNy5iuoyY2ql9FrPkk5EZdMVHlw86W5gYu6qX4FZGqGfhqtC+r4UUmrlELvGsoa5Zml+PmNLzrvYlBTIZw50sCXCESchooq6Z7ZTxa8sJYtIUUsTbPN+lxDIhGX2+MmY4CjZhTLPdreITL8bmKFGbMU14F1YhNNgHF/vJYu7UQZQeTtD20psz+xRMQtu5R81npuLot+3jyXZOOhM52mUE9nEcxFPAZbn780i/KYk0WXvNXb+ehGIAA3fQOzvGlvEDhpjQxKX6e0WL57zziotaoiYhWG3CrwhoaPDOwnm0PZgXJFJTe4cshMgpBuc2HDaYvWKbsano6tO/cy7Mf0jKFagCc2G5fQRjyybsPDfzDMCsUveLXtq1OWPfiDrOEduN6qFk1E29JxAP/racmjCcSJAr8GLTi/9CWMGDl015vsNSwYhF7/6AL24XpPJjQTszj9q3FSjn+qSi2fbEaSD+53D5T2xSVjYDBNMW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(366004)(346002)(30864003)(83380400001)(5660300002)(54906003)(478600001)(966005)(36756003)(31696002)(52116002)(316002)(8676002)(66556008)(86362001)(66946007)(2906002)(2616005)(8936002)(6486002)(66476007)(31686004)(186003)(16526019)(6916009)(4326008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WW05UlFlTHRWaUdjTjBGRlJUTWFCRUdFaktkSG9YNXZNa0pqZjk5SU9aQ2FH?=
 =?utf-8?B?Qld1bHIveGNNMGRZOXdiRE5NSGtjSnNDSm9HTVhhN3NTaUNQam96UktzL2Nv?=
 =?utf-8?B?R0VhM1hDdkxRUDhENGZRbjJPd2FWRmNVUnp4emk2cWZUNW9tbHZOcWdFUDJV?=
 =?utf-8?B?Tkl0Qk81bG1lRVNma3FVZ2hYdWlyUXVCNFdqVFNaeStGNVNxYXlLVWw4UDR0?=
 =?utf-8?B?b2g2M3JxY2pscVV5aHB6dUtCREloUXB1dmhBbnU0RXJjd1piR1laZXI3ZTZ4?=
 =?utf-8?B?MFNGcllPNnBwS0s4c0lnUHVRL295YTY0WmRkQTQxc05qSmdkT3JjNGkzeEhM?=
 =?utf-8?B?RHlZdzBGaGRPczVFWnlhZTlNZDBGZG5sRW1OUE5BRHRUL1o4MTFDcm1FVXBG?=
 =?utf-8?B?c3R2N2dwaVBpOU1pSUIzOGsrMkt5V1FXNFZVcm9nMXNsNTAyeFNPMEVHb2FR?=
 =?utf-8?B?dzNnTnh3SWRZY28rcC93aW9GWEE5blhRRm5mY0FySnNIenpBSFhwNkZKd2h1?=
 =?utf-8?B?TlVLR2JaVmZYMGM4SU9LUlc1WVRqRllXdnhWdmpQaEQxU0h0Z0FUZlNGUG5I?=
 =?utf-8?B?L0xXdCtMRzB2VkJUN2VvdlZVK0RSZW1PaVhza1RWZU5sRHN5YjMvMFZEV3ll?=
 =?utf-8?B?YWlQRnppMTM5SmFodlk3RVZpS0hDbW9OWVRrTUhGdlFNdFJPZTZva2NoRGpK?=
 =?utf-8?B?MUxGOUFVYkxHMHpOVyszY050VW9iVTMrL2JuaHpZcFlib09oTmI3SnlvdWhG?=
 =?utf-8?B?d0NGRG9xd2pFWVlOdVhnM0pIaHBwLzVtdGxzZGk5RnhTeUFINjFkalA4VXlY?=
 =?utf-8?B?cUlwOXFqYjdMWnl6bS9kVmtBczhvWk55UUViS3hEbHlFVzdQd3BWSVhneU03?=
 =?utf-8?B?VlF6T3Z0bTAzMDJSSE9nSGlmQmYvYnlNSWU2TmJYeXlhVGQ2MnJ0bnAvWCth?=
 =?utf-8?B?R29waUMrQXltTEF5SlhDM2hraHllUkUvU1dHejNsWC8zazNOdDNTd3NYeStN?=
 =?utf-8?B?bnQ0cEE1YTFXODYrSmNqWjQvMjM4RjBPQUduaTA0ZFU2UUhFZ1paeUJlNUhj?=
 =?utf-8?B?aGFCMjlPSTJRUXNzcVJ5OXV5OCtDaVp3dnF4VzdqZERKb0cwYXk2Sm1ud1Rl?=
 =?utf-8?B?a2FFM29Rb2dnUVNaN2c3WWNWdlN4SHp6ZFV0NDlXY2laUjhJRVFyVjR1d0NF?=
 =?utf-8?B?QkNHaVEveFpISnZCR21hR24xZDRyUWo1QmZjUmNMQXZqTksrNzk2OUhzRWNs?=
 =?utf-8?B?a2hPYm5kUmgybWdmS3YxanNrdnhrRVVWRlB2bVBmdTR6eEhHODRjVDk3aG9H?=
 =?utf-8?B?MjVkdzNtdThxbHZIYXYrbGhPVnppS2R6bFEzMWhJUWc3REZWYm1UT25qcVJ3?=
 =?utf-8?B?cEZvYlBXeWlzb3ZwOFR0Y1RQRlFCeXcvRVhuekozcVNLS01Sdk8yeUl0RXhI?=
 =?utf-8?B?QnFENVJJd3Y2c0VhQjZnd0lncHdJbHp3aHJFR04wM3c1TTNXdm1pSVRmRTVa?=
 =?utf-8?B?a0dUeGJoWFZzTUFHTVovYTNsbWU2NE1FakVJbzd3NWpwaGdESlROazN2L3Zv?=
 =?utf-8?B?VTd4bXdoYlFSN2VoY3FWdjNyWVFUMm5jRXNJWUpYN3ZNaTdycGhOQU9EbExL?=
 =?utf-8?B?Rk12Vm4rQk03S0I3UHNoeitQS3BpNE9lSTNQM0tTeEs0YnAyRFVBUDNWaStp?=
 =?utf-8?B?QlBHV0V3cmwxSjU5ZExScmMzUFNVRnE1WG9TTTdrNGY5eDdyRjJnRlcxcVZm?=
 =?utf-8?B?NVZHV0Rqd1VPT2x4V0Vlb0tMRW9YTXBIME5VdjF6YmtncnVUVnNoMTZnSWxh?=
 =?utf-8?Q?N27G0kH8ZOzb0cxKsNqRmxi/L1chepL48JTog=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8076f64e-78c1-44a4-337d-08d8ccc5bba8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 06:41:30.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02+yo7QhLH4o4NEjnDaqBFHEBmPIrgcDAklx51chcUYyJ/dW5zjG2MZ81dfTzGxN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2694
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_02:2021-02-08,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/21 10:16 AM, Andrii Nakryiko wrote:
> On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> The bpf_for_each_map_elem() helper is introduced which
>> iterates all map elements with a callback function. The
>> helper signature looks like
>>    long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
>> and for each map element, the callback_fn will be called. For example,
>> like hashmap, the callback signature may look like
>>    long callback_fn(map, key, val, callback_ctx)
>>
>> There are two known use cases for this. One is from upstream ([1]) where
>> a for_each_map_elem helper may help implement a timeout mechanism
>> in a more generic way. Another is from our internal discussion
>> for a firewall use case where a map contains all the rules. The packet
>> data can be compared to all these rules to decide allow or deny
>> the packet.
>>
>> For array maps, users can already use a bounded loop to traverse
>> elements. Using this helper can avoid using bounded loop. For other
>> type of maps (e.g., hash maps) where bounded loop is hard or
>> impossible to use, this helper provides a convenient way to
>> operate on all elements.
>>
>> For callback_fn, besides map and map element, a callback_ctx,
>> allocated on caller stack, is also passed to the callback
>> function. This callback_ctx argument can provide additional
>> input and allow to write to caller stack for output.
>>
>> If the callback_fn returns 0, the helper will iterate through next
>> element if available. If the callback_fn returns 1, the helper
>> will stop iterating and returns to the bpf program. Other return
>> values are not used for now.
>>
>> Currently, this helper is only available with jit. It is possible
>> to make it work with interpreter with so effort but I leave it
>> as the future work.
>>
>> [1]: https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gmail.com/
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> This is a great feature! Few questions and nits below.
> 
>>   include/linux/bpf.h            |  14 ++
>>   include/linux/bpf_verifier.h   |   3 +
>>   include/uapi/linux/bpf.h       |  28 ++++
>>   kernel/bpf/bpf_iter.c          |  16 +++
>>   kernel/bpf/helpers.c           |   2 +
>>   kernel/bpf/verifier.c          | 251 ++++++++++++++++++++++++++++++---
>>   kernel/trace/bpf_trace.c       |   2 +
>>   tools/include/uapi/linux/bpf.h |  28 ++++
>>   8 files changed, 328 insertions(+), 16 deletions(-)
>>
> 
> [...]
> 
>>   const struct bpf_func_proto *bpf_tracing_func_proto(
>>          enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index dfe6f85d97dd..c4366b3da342 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -68,6 +68,8 @@ struct bpf_reg_state {
>>                          unsigned long raw1;
>>                          unsigned long raw2;
>>                  } raw;
>> +
>> +               u32 subprog; /* for PTR_TO_FUNC */
> 
> is it offset to subprog (in bytes or instructions?) or it's subprog
> index? Let's make it clear with a better name or at least a comment.

This is for subprog number (or index in some subprog related arrays).
In verifier.c, subprog or subprogno is used to represent the subprog
number. I will use subprogno in the next revision.

> 
>>          };
>>          /* For PTR_TO_PACKET, used to find other pointers with the same variable
>>           * offset, so they can share range knowledge.
>> @@ -204,6 +206,7 @@ struct bpf_func_state {
>>          int acquired_refs;
>>          struct bpf_reference_state *refs;
>>          int allocated_stack;
>> +       bool with_callback_fn;
>>          struct bpf_stack_state *stack;
>>   };
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index c001766adcbc..d55bd4557376 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -393,6 +393,15 @@ enum bpf_link_type {
>>    *                   is struct/union.
>>    */
>>   #define BPF_PSEUDO_BTF_ID      3
>> +/* insn[0].src_reg:  BPF_PSEUDO_FUNC
>> + * insn[0].imm:      insn offset to the func
>> + * insn[1].imm:      0
>> + * insn[0].off:      0
>> + * insn[1].off:      0
>> + * ldimm64 rewrite:  address of the function
>> + * verifier type:    PTR_TO_FUNC.
>> + */
>> +#define BPF_PSEUDO_FUNC                4
>>
>>   /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
>>    * offset to another bpf function
>> @@ -3836,6 +3845,24 @@ union bpf_attr {
>>    *     Return
>>    *             A pointer to a struct socket on success or NULL if the file is
>>    *             not a socket.
>> + *
>> + * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void *callback_ctx, u64 flags)
> 
> struct bpf_map * here might be problematic. In other instances where
> we pass map (bpf_map_update_elem, for example) we specify this as
> (void *). Let's do that instead here?

We should be fine here. bpf_map_lookup_elem etc. all have "struct 
bpf_map *map", it is rewritten by bpf_helpers_doc.py to "void *map".

> 
>> + *     Description
>> + *             For each element in **map**, call **callback_fn** function with
>> + *             **map**, **callback_ctx** and other map-specific parameters.
>> + *             For example, for hash and array maps, the callback signature can
>> + *             be `u64 callback_fn(map, map_key, map_value, callback_ctx)`.
>> + *             The **callback_fn** should be a static function and
>> + *             the **callback_ctx** should be a pointer to the stack.
>> + *             The **flags** is used to control certain aspects of the helper.
>> + *             Currently, the **flags** must be 0.
>> + *
>> + *             If **callback_fn** return 0, the helper will continue to the next
>> + *             element. If return value is 1, the helper will skip the rest of
>> + *             elements and return. Other return values are not used now.
>> + *     Return
>> + *             0 for success, **-EINVAL** for invalid **flags** or unsupported
>> + *             **callback_fn** return value.
> 
> just a thought: returning the number of elements *actually* iterated
> seems useful (even though I don't have a specific use case right now).

Good idea. Will change to this in the next revision.

> 
>>    */
>>   #define __BPF_FUNC_MAPPER(FN)          \
>>          FN(unspec),                     \
>> @@ -4001,6 +4028,7 @@ union bpf_attr {
>>          FN(ktime_get_coarse_ns),        \
>>          FN(ima_inode_hash),             \
>>          FN(sock_from_file),             \
>> +       FN(for_each_map_elem),          \
> 
> to be more in sync with other map operations, can we call this
> `bpf_map_for_each_elem`? I think it makes sense and doesn't read
> backwards at all.

I am using for_each prefix as in the future I (or others) may add
more for_each_* helpers, e.g., for_each_task, for_each_hlist_rcu, etc.
This represents a family of helpers with callback functions. So I
would like to stick with for_each_* names.

> 
>>          /* */
>>
>>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
>> index 5454161407f1..5187f49d3216 100644
>> --- a/kernel/bpf/bpf_iter.c
>> +++ b/kernel/bpf/bpf_iter.c
>> @@ -675,3 +675,19 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>>           */
>>          return ret == 0 ? 0 : -EAGAIN;
>>   }
>> +
>> +BPF_CALL_4(bpf_for_each_map_elem, struct bpf_map *, map, void *, callback_fn,
>> +          void *, callback_ctx, u64, flags)
>> +{
>> +       return map->ops->map_for_each_callback(map, callback_fn, callback_ctx, flags);
>> +}
>> +
>> +const struct bpf_func_proto bpf_for_each_map_elem_proto = {
>> +       .func           = bpf_for_each_map_elem,
>> +       .gpl_only       = false,
>> +       .ret_type       = RET_INTEGER,
>> +       .arg1_type      = ARG_CONST_MAP_PTR,
>> +       .arg2_type      = ARG_PTR_TO_FUNC,
>> +       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> 
> I looked through this code just once but haven't noticed anything that
> would strictly require that pointer is specifically to stack. Can this
> be made into a pointer to any allocated memory? E.g., why can't we
> allow passing a pointer to a ringbuf sample, for instance? Or
> MAP_VALUE?

ARG_PTR_TO_STACK_OR_NULL in the most flexible one. For example, if you
want to pass map_value or ringbuf sample, you can assign these values
to the stack like
    struct ctx_t {
       struct map_value_t *map_value;
       char *ringbuf_mem;
    } tmp;
    tmp.map_value = ...;
    tmp.ringbuf_mem = ...;
    bpf_for_each_map_elem(map, callback_fn, &tmp, flags);
and callback_fn will be able to access map_value/ringbuf_mem
with their original register types.

This does not allow to pass ringbuf/map_value etc. as the
first class citizen. But I think this is a good compromise
to permit greater flexibility.

> 
>> +       .arg4_type      = ARG_ANYTHING,
>> +};
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 308427fe03a3..074800226327 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -708,6 +708,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>>                  return &bpf_ringbuf_discard_proto;
>>          case BPF_FUNC_ringbuf_query:
>>                  return &bpf_ringbuf_query_proto;
>> +       case BPF_FUNC_for_each_map_elem:
>> +               return &bpf_for_each_map_elem_proto;
>>          default:
>>                  break;
>>          }
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index db294b75d03b..050b067a0be6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -234,6 +234,12 @@ static bool bpf_pseudo_call(const struct bpf_insn *insn)
>>                 insn->src_reg == BPF_PSEUDO_CALL;
>>   }
>>
> 
> [...]
> 
>>          map = env->used_maps[aux->map_index];
>>          mark_reg_known_zero(env, regs, insn->dst_reg);
>>          dst_reg->map_ptr = map;
>> @@ -8195,9 +8361,23 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
>>
>>          /* All non-branch instructions have a single fall-through edge. */
>>          if (BPF_CLASS(insns[t].code) != BPF_JMP &&
>> -           BPF_CLASS(insns[t].code) != BPF_JMP32)
>> +           BPF_CLASS(insns[t].code) != BPF_JMP32 &&
>> +           !bpf_pseudo_func(insns + t))
>>                  return push_insn(t, t + 1, FALLTHROUGH, env, false);
>>
>> +       if (bpf_pseudo_func(insns + t)) {
> 
> 
> if you check this before above JMP|JMP32 check, you won't need to do
> !bpf_pseudo_func, right? I think it's cleaner.

Agree. will change in v2.

> 
>> +               ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               if (t + 1 < insn_cnt)
>> +                       init_explored_state(env, t + 1);
>> +               init_explored_state(env, t);
>> +               ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
>> +                               env, false);
>> +               return ret;
>> +       }
>> +
>>          switch (BPF_OP(insns[t].code)) {
>>          case BPF_EXIT:
>>                  return DONE_EXPLORING;
> 
> [...]
> 
