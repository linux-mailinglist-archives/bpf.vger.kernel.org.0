Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E3E64E70B
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 06:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLPFkn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 00:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLPFkl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 00:40:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647E8F09
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 21:40:39 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BG4UpSU023766;
        Thu, 15 Dec 2022 21:40:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=X0mxpxIXVDTODxeIflU3B614km36wSRpjNZbGS8mK68=;
 b=ahpgllsQuFQ7+dJPe1sAMl40jOsDaZaq2ZgCPn6HDl4BuCl3Uosha19Cb+T3SrvbnlnG
 dnYCupLqqz+9tATboelSUbA9xFIrBzuBMedYTIMYsPJWrB3tTsqc28qbkG0FlhOq8bh1
 5HdLhXMLx6ew6xZmrGGw/l1ZRR9ELDoFJ7c/91TkMWniCpimBm10shtx1Ouo2lLsE54L
 e9GZplk8y8vrmtuKrSBjumukFdy1w2czDCr8uSsz2XsUIB3rmogjn4aGWwbLf0edWO0I
 MCEfm9jVqPQpcFo/f9BLUyRvxA8DkM5LruGnWmtRPKOVaXSOLwvj/OzUSErj+EpeYvQK VQ== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mg3hmx4n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 21:40:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVbxvbf0PlIW0UetWFBgTN0BKlhGcBqIvfdpFgTXgwK5aRrw5TxOcQN/DGDdUz+GmCrQ8myFupk6XkeF2HsosTYAkOMkL4xxvL29q5Br1nrXfPAPb9tObe8ucz5SJTlK2lC98mp7GC508RL7tOiZDKX6uTofc3l/1W4RM1OUe7nWdRlnY+MivUNAvt44sPaPjhzEtWLgns2X1kvnUDPWltfEVt7k46g/I2eqmdMYhuXz01GKB2Q6C0vRaUvF4Y5+05GWx/DFhU/9+Fv1WyB76pVoDSDKLpEaEY3SEGJFfC+ESHbKVrZZXTwT4q+RwbzgJHkQzclOEQuqJpbhSI8rJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0mxpxIXVDTODxeIflU3B614km36wSRpjNZbGS8mK68=;
 b=l/Ims/74NKto2wD9UorqDnqLf0MNFfrtQ2sHIBPfxjKt7XznOk1RVW7sh56Nv9Y0kkTlYQXvQdso8/AV6hc0NcaaNRU8uSVQVCTsrOU0ERE80Ha0E6Ita6hQa1kstKKTwV8KTpiGf0X4y7CXno4d5ZgkHQvjU5ugsdTYpBizg+pcuOUVl4Sd9X9ZEUHY3uq0m4hj+CTqBCPguIVZBNzVDD5P4xQraqpVcuybdQqJ7Ht4HPoPwRxgh66L03I9Ap+iEBRrtmB9FHvKWBqtsETz6Q6OTQ2vGALxAatWmbWfYEO8rRph4sBQgwlGHkdpo9HCys90NyN3AnlOAWuaDT6e+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4762.namprd15.prod.outlook.com (2603:10b6:303:10b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Fri, 16 Dec
 2022 05:40:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 05:40:02 +0000
Message-ID: <553c4d32-aac1-f5d2-8f39-86cdca1af0d6@meta.com>
Date:   Thu, 15 Dec 2022 21:39:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [bpf-next v2 1/2] bpf: add runtime stats, max cost
Content-Language: en-US
To:     xiangxia.m.yue@gmail.com, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20221215043217.81368-1-xiangxia.m.yue@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221215043217.81368-1-xiangxia.m.yue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bbad7e-1ca1-4bc0-dc78-08dadf27fa11
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNJuZ37YtasTIyoruFPko4DZtTOZ2jwB1zB2sOJQ601klSWV/7YD8wSnU/8teLzuzEEIn2SPuhhx9noMUMFzlq8GDsKBmwwnUW9K+3Q6v8fde5iQMkD9oLz3iNnmD5MpO08FE0z3F/SwKzCPey5NK2y/vYPq2gcXOCcr/XdEbXDswUmMPduwQg5LoySc5NntmDUhMMosVRcHkk7xUlKZdGPcwjRkdaeFa59qfZopqYLiWXuDnxyv4YhvUmxJu8Zo6clJCOYO2kn9HZXdYYch4s/eaWlmXXebJmdcEiAGIwz3JbMWVEvD0foP8j1cCUX81Jxl1s5PaVJUuiW2rp2nPurOU29QmXowp2zyu8jBmSjo5QoPlWnYxrXjpycWyA1LaNQeQ3Ntfn54qQkYb2uQpsbqkesiCPe+S3Q2BxLtIkc9wS7oi6/INLmZXvjjYK3eCK7hkejfzhUfIBTm12dIr2cfZFWLMsI9NcC+X5aRZdDK/awbYST61df9waixNmtc8JNkjeDK9Ty8ij6aDW99VJ1dPUYcJI5iH0msY6kdXMs40W1m13lql6AHHiqO8FmMvhIlA25FGNfrYZKzf152dyTg9u93vLwUFFI4PQZhO680vqJB5C4QwqJtekaXOScmzWg4BDe5DI/PFoHuxlAZU+TKf1FrEpvakqrbLyfSD/qMuBtW1s8dgv0q9gVM9iJ8468fjWNIbWgtjg1MnSS/td0oHdS8eS9PModie82Sy04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(38100700002)(2616005)(186003)(86362001)(31696002)(6512007)(31686004)(478600001)(6486002)(6666004)(8676002)(316002)(54906003)(66946007)(4326008)(2906002)(66476007)(66556008)(8936002)(83380400001)(41300700001)(5660300002)(6506007)(53546011)(36756003)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGxRaThpYkptRHBET0ZlM3VjNE9rd2xUSFVtNldFZWhCU05kTWRYdE9Ebkcy?=
 =?utf-8?B?VlRrdStWaEsrclNkOEpCTzZIbnpycW9OYlc3ci9oWEVpanJyb3I3aDMxUVJ1?=
 =?utf-8?B?b05KT0VWY25ITVhmSWVZUHBCeTh4cnNCdFA1TUNDK3NOWGJmdXRDQ0JqbG5j?=
 =?utf-8?B?bWlxU3FKRnd5bGMrTGRkRm02dlJPL0NTakFaN3l1WmltRzNPM1MxTW16UUZ0?=
 =?utf-8?B?cVJaY09hanZNREVLMDFGRFM5bVdYSDBiaFE1MW5pd0xzSVEwbDR5Zmo4aGFO?=
 =?utf-8?B?TlhQdnhWWUtnYzJLQ1ZLYm0xdEs3SzNGT2pxSkYzdnhQT2s0M2djMFpHVTgr?=
 =?utf-8?B?ZlphVWZBYnZMYXc2NUZUcGN6WkRMeGdjcU0weS9ZaE4zTTNVZE05TE1McGNO?=
 =?utf-8?B?Tk9Ob2R6SGkvMUQ1VWRWdnJ2NGl5RDVJUmNVVjEzaCtyaE9aZzAzUDl4WnZY?=
 =?utf-8?B?dEFBUFA5elNjVVQvaHVKeStyblpBcnpIZ2JJZm9TOUFoMUtPTlNxRDhvaGZN?=
 =?utf-8?B?a2pzdTB0akpmNTVPbVhGcW9FZk0wa1N3WXc3empkbzN5RjVncGpDVkdCUGpE?=
 =?utf-8?B?bWdKRjlpVnAzT2VEQUZnNXNUdjN3YitpVk9QV2pkRWljU3g0aUVoQkU2bVg3?=
 =?utf-8?B?TWRpSjJ6Tno2V3JPSmNOUE9XQVoxL0F3UDc1Tk5PakxPdzBLU1hpYUl1UWpj?=
 =?utf-8?B?SDdmdTNVeTJHQmYxcWpvQjMxd3RkeWNuYjc3dVVtWHVZcE5pRVdGT0dnaHNI?=
 =?utf-8?B?Y0pLQSszYkYzQ1I2YW5HbzcyNHhZbnJKbVhZY3JBOHRidUR3WE9LbDRqbkZz?=
 =?utf-8?B?NUxUV0ZmSnppYUZUWTlCbDc3RkMrcnpRa0NpeDhYR2tNRE91UTMrUXFDbm1h?=
 =?utf-8?B?MkliMDlUUC9GMjJ2ems1dElhVWhnb0N2ZDlzSzhoRzdsQzFWOU52cVZONVJ5?=
 =?utf-8?B?OHpkalhGNmt6RE01eXEwVktqcmJIUzJQVFJsb0g5Q1Z6ZXJNbEgxNk93VGJI?=
 =?utf-8?B?Qnk1MVVmeUNXOVRwdlNiY1ZxRTVYRUE2QlVLeGxBMGttSFJKUTlTeWU0VURw?=
 =?utf-8?B?UW9iYVI0Uk51aFlJWEszaTZMTFBxeXcvSkZ2b1Q2bTZRejVmQ284K1dGbk5o?=
 =?utf-8?B?TS9FcEQwV053WTBnY0w0bmhpSzJBWlhYckNtM0Q4N25mNVp3NW4wQjJSamw4?=
 =?utf-8?B?KzJXaDZKOTM5WXh3SitqT0VVZkt2YTdRbE9VQlpkdDlrVCtnUGV0TEVhalRy?=
 =?utf-8?B?T2lTNFZIdTQrQzdGQ3JGSyt1MkRDSDhtRGllT3c5Yys0NlIzUjFORkhtcTBG?=
 =?utf-8?B?YzZlV3E1dUlPa25OUm9hWmtLcHFBMUdyVG5kNjRlK0xmS3p1STlEWWtBOS96?=
 =?utf-8?B?bi9jUmRmSGlZQ0NReGpwaTY0eDlSSEcrd0xMTWZUVlpLWEw5bmRKeDFPdlpt?=
 =?utf-8?B?Z1RmQ2lpZ1JzL3dZY0VKS2hjQUI0VVdmVHZ0djVWSkV5bUdqcTdaYzd1RjI3?=
 =?utf-8?B?U0w1NFJIYkZLSUVLdENkbFJaa1g3MUxwMUZqZFRLZ2FaQ1Nqd082UnhuSDhp?=
 =?utf-8?B?Y0lHMEsvbEc1cFBsZGQxU3E5TWVFMzJJd2lmSzNkRHZqYmdvaU9xalc0QTEx?=
 =?utf-8?B?Sm03eHRBd3JiVmlVWXEvaVUxNVFMVENOTUllR0hELzdFRU1STnkwSytYbzMr?=
 =?utf-8?B?d1FuclZiVmFFQUhEblc5alZYZXhLSmZVcHhTUUZQemxQL2QrWHlyMTk3allz?=
 =?utf-8?B?ZUJ0WVVyNSsrRVVtc3M2UDBEdHFyejVMb2doRmdjb0RmRXM0RUkrZUV5dHNO?=
 =?utf-8?B?d1hjQTdnSldhVEVCUTNmYmNRRWVxTFZqVWNwWjhyLzZaUjlSMnBMNHlNOEhH?=
 =?utf-8?B?dS9tMk9WaTkrUERiMXR5TkJNYU1kVlQrN0VuaDhRODQwMlBvdWgwcEpzMjRW?=
 =?utf-8?B?TTJXZUlPUHVROTdZYVVNeUZHK2c0QjhNeXFMd1B2bVI4WGpMUW9tWlYzK2tp?=
 =?utf-8?B?anMzdEZJZUFqdkZkTTVqRS9GbC9VdVQ0SEE0N3YvZVR6RlZyaVk1d1paWHJw?=
 =?utf-8?B?WnJ1T1lhVkJwTHRFUHM2cFJwcVRValJkV0FweWFQTm9uQ09SWjVVYmZ0OU1l?=
 =?utf-8?B?amljZmlRNERnMEtwKzA2cHdhRldQNmxGdHlPcVlXU2w2ZmQvSXVJY0wvU2hF?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bbad7e-1ca1-4bc0-dc78-08dadf27fa11
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 05:40:01.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGcYYYbmugo0nM8D5uOpOiT+CGwvIL9hzlt1ww6jW+4KGS8/EQleKa2ogLFvHrGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4762
X-Proofpoint-GUID: oUQ8GBNtWy5Sl7E4Wbp15-c_1f1ftT26
X-Proofpoint-ORIG-GUID: oUQ8GBNtWy5Sl7E4Wbp15-c_1f1ftT26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_02,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/14/22 8:32 PM, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> Now user can enable sysctl kernel.bpf_stats_enabled to fetch
> run_time_ns and run_cnt. It's easy to calculate the average value.
> 
> In some case, the max cost for bpf prog invoked, are more useful:
> is there a burst sysload or high cpu usage. This patch introduce
> a update stats helper.

I am not 100% sure about how this single max value will be useful
in general. A particular max_run_time_ns, if much bigger than average,
could be an outlier due to preemption/softirq etc.
What you really need might be a trend over time of the run_time
to capture the burst. You could do this by taking snapshot of
run_time_ns/run_cnt periodically and plot the trend of average
run_time_ns which might correlate with other system activity.
Maybe I missed some use cases for max_run_time_ns...

> 
> $ bpftool --json --pretty p s
>     ...
>     "run_max_cost_ns": 313367
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Hou Tao <houtao1@huawei.com>
> ---
> v2: fix build warning
> ---
>   include/linux/filter.h   | 29 ++++++++++++++++++++++-------
>   include/uapi/linux/bpf.h |  1 +
>   kernel/bpf/syscall.c     | 10 +++++++++-
>   kernel/bpf/trampoline.c  | 10 +---------
>   4 files changed, 33 insertions(+), 17 deletions(-)
> 
[...]
