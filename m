Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602764AE690
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbiBICj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbiBIB1Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 20:27:25 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69756C06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 17:27:23 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218Jtved028307;
        Tue, 8 Feb 2022 17:27:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4+IDs0Tq2fABKxlKx0gla+XSg+dufAX6Md6uFUK/vCQ=;
 b=B5Klsqh70+wzqz0eWtDMsjj9SM9CuhpajeZKksKQbts+iNyFKoW2slkbJOZbbseFDI7r
 X0IJd9BvQUC2u4Pn1J8h0NS6uqsQQZiBkQAXhWsGu9falIcF/CqkjF1E94XgKamLoH8R
 LM+iVVpFihJn9Kz8dinyz2L4vedd626xizI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3y3s1v2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 17:27:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 17:27:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2thSLF8nDh7xRsEA0bUejKj7yixVWBPlhODEBjfnQCqzn0RAg8g3hL0+l/G7FPuIZ7jZSqVglF9ZdshZgEGY/ESq6AJ6XcyQpLim++oX1Twccd4i0IyWgDwzEhoqwJ6PPf4V9oWFe7i8uypgesA3Lrp9F0MPDxrGeUiLkdjPuJUHTVd0JWwo6h9++TLeQ3qIYQZV/IeMKp+8YDRAbkWHJXGnFkRZ9DKmu8zmtubw1s7ab4xxJBVIGKaeoNuq05KbCvWn19uLUycIFSmvuko+Qjr/N7xG/2SeiJEXKrhUADhHyViXIfS88qGFfL2E2ZHbygBVODEwAcaAzUgElTBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+IDs0Tq2fABKxlKx0gla+XSg+dufAX6Md6uFUK/vCQ=;
 b=hAt2xD7QKUG0VaJURVmXPdooeIvivWsO86S4gzTXQkvMRonxFaaIp4rGrfEKv5nUQthTff3fGwu85bDDkKLPUGJMkgXM0J+SdwLxQAHTB8xSav15NniG+xs8BLkoViKHDqX/iZbaGVRRVqeN16qqDYAvYn5E0qnQoc32+3FcAg+mN8RqfXmPVBnhYWJAZG15YjyAOEQPGcfwDfzXGYpQhERsqFK6cVyfXZwS177cLFP9gGjyRxagbeZYJGFuGVOCelc5uay8hotXAWaQlSMTPAa7StGEakX2mUAHVSMO8HqhmMAFS4ZEYYxAHOcMMaF7FoDmmj5nqxVVgWesNTPdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4642.namprd15.prod.outlook.com (2603:10b6:806:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 01:27:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 01:27:04 +0000
Message-ID: <8e4e6af8-730b-25f7-d4bc-8ee5fb32bc96@fb.com>
Date:   Tue, 8 Feb 2022 17:27:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 bpf-next 2/5] libbpf: Prepare light skeleton for the
 kernel.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-3-alexei.starovoitov@gmail.com>
 <e90685a5-dad0-4a4b-aa8b-275eaef79e60@fb.com>
 <20220209004456.axst5cynliegcnjl@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220209004456.axst5cynliegcnjl@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0017.namprd19.prod.outlook.com
 (2603:10b6:300:d4::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99cb3813-3012-49e7-569e-08d9eb6b4794
X-MS-TrafficTypeDiagnostic: SA1PR15MB4642:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB46421D13CA78AEB241CB3846D32E9@SA1PR15MB4642.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRElJrkuPLiYoxW6x4WlD0ng92zu02hZB2thXfetBLFo3qEISLmrS5TsY3f3waoQJ1WKCGxHg6vJmSYWCq/vHBJrqiO6RCbms63jiVzKvtqHzPeLop6RKiiWcZVxojJNEKipvkmdRJSossTW2Ou21Y2TtCfPRhoJYlTM56HssQx0YkwSB2ECTDmS8Qhha/gcB2dqf6MuL79FMAowABoMsxtD0/6v0uSGaLfWu4ef06UPe3Q7lkcdklDr0OzAWbqMJIBXans0So3Xggu/oe/XlljcNIqSdosABOh73OLCoRxaVc70cYko0a5iOVdDZCoAti/AoE840tWxQyt29hPqQ1+gLRiUxYiuCnXAdF1HAGbvvDpgB4bdsSm27PeNeKGCIwhjdCLKQUIoTWvzdWGwqYAVbub0xAGELYzLx+FkeK35XXvqowShuRyGhuGJG+THFXS/UbhHoyjciaXLCfAS1EwT97g8zAjsW95EoTP1M6IWVRz4Ifv4gM1WHbyMgJqINnYaIJXYklmsYC4YmzR06NexVoI3ZRP6QOCKFedvM91o62H980fqKknnjdDvjYyrqKSZbM0n55LRUmgJow11xBWvH+E20bznbv3DnHw7xXvxJUnVchJdNhqsDl7DofwOzPtlRa3+7FY57MFTTcw3eY4/gEoPMjrbFYieiid6TKkrtd6YJcm08cBiPaZRKLPJVO0PuPCX+cD9i2qBM2eZ/CkXafGI9MXVLgRmYP+Ddm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66476007)(66556008)(8676002)(6512007)(508600001)(66946007)(53546011)(52116002)(6506007)(6486002)(6916009)(316002)(36756003)(2616005)(2906002)(83380400001)(31686004)(186003)(38100700002)(86362001)(31696002)(8936002)(6666004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJDaWtIWHlWZXlBcHdIZEt0QklTWlc5aS9ZWkl0OUFLK0xyQU16OTZDUStk?=
 =?utf-8?B?ejgrcDZvVEU2YlV1YU15RCtwRUJCbm0zd3dNc0lxV3g0cXJFWVdvc2FpKzAr?=
 =?utf-8?B?N3VVNjZXTjlFNUZSMGd0TVN3d3ZtYjU5b3FEOC9rOUJFSXpuZDVwbjBPRUR6?=
 =?utf-8?B?RDlUKy9iWUV2TTF3MERrRlJkN0JKRFNxMllITk54NC9kWkhGQkdTRDlmZHBj?=
 =?utf-8?B?eW5FV3ZzTC9zK0xKSHdTU1BGV2xPTzdKbVFENkNuOGs2ZjNNN285eUNLT2Ix?=
 =?utf-8?B?WDArYkhlNU5WS3kveS8xMTR0NE9FSWUxZ3FLY0JFMXJBN0JBUTdRRDF4ZHZB?=
 =?utf-8?B?djV4N0swdjJYbnB3N3Z5cTRzVExOcGpJNEpNRnVPa1loWFlmYXVHM1dsOFor?=
 =?utf-8?B?bmNveWtrVUhGS3ErV0hVeEtJR2JLWDgxdFlHUDdzTnl4VFYxY0E2bjk4aUJa?=
 =?utf-8?B?VDlKMGpTWTJKNW1MTmFZSXpGdEhabzdoaXdGbFE4VW5GeWZENzRCbkd0Ujhw?=
 =?utf-8?B?OUFRUDhYejRiVkFLZ3UrLzVCK1N2NXRBN0pQKy8xTzhleVNzemNKMXdUL090?=
 =?utf-8?B?RWR6WWFXSThVWnVjNnpLbHlNWEo1eEdnWXVvdDRUZEJnRWF1KzVzTjBES1R2?=
 =?utf-8?B?dnBGQXQyUDRTYUlSMjFoYXBHSzZjZzNUangvTi84VmJvUHpZSlVwM3ZVYlE1?=
 =?utf-8?B?YjgxakNua0l4TlRFcThDZVhsUWxpeEppTlBlR0UvZ09TWEFOa25TYldua0hh?=
 =?utf-8?B?WXRhVFhuenFkRVJ1cUNHK2k4alBSeWlFdGhWMUd1Ni9ZSGhBT1NHUWtiVVBU?=
 =?utf-8?B?S0sxc2k4ZERUVFpRSlYrQzFKUUx4Um5sYnFkRlZiRUlUWDROZ05pRWRidVBY?=
 =?utf-8?B?YlYrb1ZQZk54YkdlM3Zrc1lCRGk2NmNoUDdxaGFOMFhIajhuNi8rc0tWOGNF?=
 =?utf-8?B?WUw5bjBwbnV5cUlZVDdzNHRkcjdwbXU0czNJdUFmWVlialB3bWovbDhYTEFR?=
 =?utf-8?B?YUQwR0RDOGx4d3NlY0RwaXAyd3RXcXBZK21lODdrejcvcDZYN3RVUi9pZHhy?=
 =?utf-8?B?d1h1aHRSNWcwU0E4dmNlRlRjZFZiY0o0MjRIckUzQkhLMGthT2pWR0lmRjRX?=
 =?utf-8?B?aHNuV0p1QU5oK0ZnRUFNZzZMVzhBdjNpQkJGT0w3cEtMbzZML1ZHTlNMY3NH?=
 =?utf-8?B?Q2UyZjI3YXVSd0JVYnRiNnM0ZGtzTmhiUUtkZ0hxTUlIQXozVURDM0ZSUXZC?=
 =?utf-8?B?cGZEMGRNcmRFQ3NVaVRxNjNGWXlUTzZmWjJlWkJwYlZDT3E1Snc4STVKZ0NN?=
 =?utf-8?B?bmtDZHFueFhHVzRlZTJWVit1bUFsMlJLdk5sNCtqTWExM2h1NHJhbC9XWG5L?=
 =?utf-8?B?MHNqaGhyOTNNZWtNbktvOUtCWXZsb3BXc2hCTjNBaUczZTB2Nmg3V3pwSmR0?=
 =?utf-8?B?Vm5ZWGhwUVZudG9QK1VOaThRQk12UGU0c0lBamFUbm84c0E2Ly9ZclBHQStK?=
 =?utf-8?B?Q2Q3WWJjNEVBcVRZTzBSd2JTSU9wTFlSMGp6dERqRGlHMjBaWHBueUVQU0h4?=
 =?utf-8?B?ZGsrVzRhZ21rQUxFZW9WWjVFWExxZHRMNURFQWpKNDVJRDRDQzFZT2xNVkc1?=
 =?utf-8?B?R05aSXVKT3hiMXlXSHovRFJWd0N4WFZ2YzZlVGNFNHRIbmxpZFFpMnF6OXZ1?=
 =?utf-8?B?WXE1NHhzL1ZmUGRnNlJ0dHJYUXhNcUxPMlMyRjZrcGJmQ3o5WkFRYlpGcFd3?=
 =?utf-8?B?VGRpRnhwcEdURzd3WW9kVlFxdWFWRkhzMExEdVhsTEdMcXR0dDU3VStVTitD?=
 =?utf-8?B?bk1WV0pLTk8rOStJQWRMRHFtWCtxZjJZV2pNUXUzVkU0WVlBZExRR0FzaThr?=
 =?utf-8?B?MVVERjh3YnpVTGZxWGZ4RWdZSzJOeUZPWXBRanJCUlRDNktXT1J4WTk4VVIw?=
 =?utf-8?B?aHIxYWllSVRaRm1keTUvSkJMdUZFdmJQSlFyVU9FOWUvNUdqM0ZWSkJibm9I?=
 =?utf-8?B?cTJyd2ZMVS92SG5Hd1l3R1VDeWxnUzdONk9telZZWjR0dEhFcjIyZ00yLzJW?=
 =?utf-8?B?ZytJZEJCcVdMUEROSjlDMkdGTWYyYkVyR0QyWXRlVGVFMDF6WFM2azh0a2pE?=
 =?utf-8?B?VEZIS1ZaWDh6dThsQ1U0RlVLalQ1cGkrczBxaXNyQVpyMGVvZWw2NmswOGF0?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cb3813-3012-49e7-569e-08d9eb6b4794
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 01:27:04.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVxJb5HL5erD7F5kMHpmswRFv8cAWExt9Bn+SHQzREQt0QkKpE3kihO+HcDunW6t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4642
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: D42vS7dQrstQv1i5K3ylxoCILtFtA9Q9
X-Proofpoint-ORIG-GUID: D42vS7dQrstQv1i5K3ylxoCILtFtA9Q9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090009
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 4:44 PM, Alexei Starovoitov wrote:
> On Tue, Feb 08, 2022 at 04:13:01PM -0800, Yonghong Song wrote:
>>
>>
>> On 2/8/22 11:13 AM, Alexei Starovoitov wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> Prepare light skeleton to be used in the kernel module and in the user space.
>>> The look and feel of lskel.h is mostly the same with the difference that for
>>> user space the skel->rodata is the same pointer before and after skel_load
>>> operation, while in the kernel the skel->rodata after skel_open and the
>>> skel->rodata after skel_load are different pointers.
>>> Typical usage of skeleton remains the same for kernel and user space:
>>> skel = my_bpf__open();
>>> skel->rodata->my_global_var = init_val;
>>> err = my_bpf__load(skel);
>>> err = my_bpf__attach(skel);
>>> // access skel->rodata->my_global_var;
>>> // access skel->bss->another_var;
>>>
>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>> ---
>>>    tools/lib/bpf/skel_internal.h | 193 +++++++++++++++++++++++++++++++---
>>>    1 file changed, 176 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
>>> index dcd3336512d4..d16544666341 100644
>>> --- a/tools/lib/bpf/skel_internal.h
>>> +++ b/tools/lib/bpf/skel_internal.h
>>> @@ -3,9 +3,19 @@
>>>    #ifndef __SKEL_INTERNAL_H
>>>    #define __SKEL_INTERNAL_H
>>> +#ifdef __KERNEL__
>>> +#include <linux/fdtable.h>
>>> +#include <linux/mm.h>
>>> +#include <linux/mman.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/bpf.h>
>>> +#else
>>>    #include <unistd.h>
>>>    #include <sys/syscall.h>
>>>    #include <sys/mman.h>
>>> +#include <stdlib.h>
>>> +#include "bpf.h"
>>> +#endif
>>>    #ifndef __NR_bpf
>>>    # if defined(__mips__) && defined(_ABIO32)
>>> @@ -25,17 +35,11 @@
>>>     * requested during loader program generation.
>>>     */
>>>    struct bpf_map_desc {
>>> -	union {
>>> -		/* input for the loader prog */
>>> -		struct {
>>> -			__aligned_u64 initial_value;
>>> -			__u32 max_entries;
>>> -		};
>>> -		/* output of the loader prog */
>>> -		struct {
>>> -			int map_fd;
>>> -		};
>>> -	};
>>> +	/* output of the loader prog */
>>> +	int map_fd;
>>> +	/* input for the loader prog */
>>> +	__u32 max_entries;
>>> +	__aligned_u64 initial_value;
>>>    };
>>>    struct bpf_prog_desc {
>>>    	int prog_fd;
>>> @@ -57,12 +61,159 @@ struct bpf_load_and_run_opts {
>>>    	const char *errstr;
>>>    };
>>> +long bpf_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
>>> +
>>>    static inline int skel_sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>>>    			  unsigned int size)
>>>    {
>>> +#ifdef __KERNEL__
>>> +	return bpf_sys_bpf(cmd, attr, size);
>>> +#else
>>>    	return syscall(__NR_bpf, cmd, attr, size);
>>> +#endif
>>> +}
>>> +
>>> +#ifdef __KERNEL__
>>> +static inline int close(int fd)
>>> +{
>>> +	return close_fd(fd);
>>> +}
>>> +
>>> +static inline void *skel_alloc(size_t size)
>>> +{
>>> +	return kcalloc(1, size, GFP_KERNEL);
>>> +}
>>> +
>>> +static inline void skel_free(const void *p)
>>> +{
>>> +	kfree(p);
>>> +}
>>> +
>>> +/* skel->bss/rodata maps are populated in three steps.
>>> + *
>>> + * For kernel use:
>>> + * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
>>> + * skel_prep_init_value() allocates a region in user space process and copies
>>> + * potentially modified initial map value into it.
>>> + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
>>> + * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map and
>>> + * does maps.rodata.initial_value = ~0ULL to signal skel_free_map_data() that kvfree
>>> + * is not nessary.
>>> + *
>>> + * For user space:
>>> + * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
>>> + * skel_prep_init_value() copies rodata pointer into map.rodata.initial_value.
>>> + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
>>> + * skel_finalize_map_data() remaps bpf array map value from the kernel memory into
>>> + * skel->rodata address.
>>> + *
>>> + * The "bpftool gen skeleton -L" command generates lskel.h that is suitable for
>>> + * both kernel and user space. The generated loader program does
>>> + * copy_from_user() from intial_value. Therefore the vm_mmap+copy_to_user step
>>> + * is need when lskel is used from the kernel module.
>>> + */
>>> +static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
>>> +{
>>> +	if (addr && addr != ~0ULL)
>>> +		vm_munmap(addr, sz);
>>> +	if (addr != ~0ULL)
>>> +		kvfree(p);
>>> +	/* When addr == ~0ULL the 'p' points to
>>> +	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
>>> +	 */
>>> +}
>>> +
>>> +static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
>>> +{
>>> +	void *addr;
>>> +
>>> +	addr = kvmalloc(val_sz, GFP_KERNEL);
>>> +	if (!addr)
>>> +		return NULL;
>>> +	memcpy(addr, val, val_sz);
>>> +	return addr;
>>> +}
>>> +
>>> +static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, size_t val_sz)
>>> +{
>>> +	__u64 ret = 0;
>>> +	void *uaddr;
>>> +
>>> +	uaddr = (void *) vm_mmap(NULL, 0, mmap_sz, PROT_READ | PROT_WRITE,
>>> +				 MAP_SHARED | MAP_ANONYMOUS, 0);
>>> +	if (IS_ERR(uaddr))
>>> +		goto out;
>>> +	if (copy_to_user(uaddr, *addr, val_sz)) {
>>> +		vm_munmap((long) uaddr, mmap_sz);
>>> +		goto out;
>>> +	}
>>> +	ret = (__u64) (long) uaddr;
>>> +out:
>>> +	kvfree(*addr);
>>> +	*addr = NULL;
>>> +	return ret;
>>>    }
>>> +static inline void *skel_finalize_map_data(__u64 *addr, size_t mmap_sz, int flags, int fd)
>>> +{
>>> +	struct bpf_map *map;
>>> +	void *ptr = NULL;
>>> +
>>> +	vm_munmap(*addr, mmap_sz);
>>> +	*addr = ~0ULL;
>>> +
>>> +	map = bpf_map_get(fd);
>>> +	if (IS_ERR(map))
>>> +		return NULL;
>>> +	if (map->map_type != BPF_MAP_TYPE_ARRAY)
>>> +		goto out;
>>
>> Should we do more map validation here, e.g., max_entries = 1
>> and also checking value_size?
> 
> The map_type check is a sanity check.

Yes, I am aware of this as a sanity check. I am just wondering if we do 
this check whether we should do other checks as well.

> It should be valid by construction of loader prog.
> The map is also mmap-able and when signed progs will come to life it will be
> frozen and signature checked.
> rodata map should be readonly too, but ((struct bpf_array *)map)->value
> direct access assumes that the kernel module won't mess with the values.
> imo map_type check is enough. More checks feels like overkill.

I am okay with this. Maybe add a comment right before
bpf_map_get() to explain map with fd is created by loader prog so
map should be a valid array map with max_entries 1, the IS_ERR
and map_type checks are just sanity checks.

With this,

Acked-by: Yonghong Song <yhs@fb.com>
