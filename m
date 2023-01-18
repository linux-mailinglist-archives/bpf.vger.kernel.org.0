Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4686725A9
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 18:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjARR6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 12:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjARR6a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 12:58:30 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A335354B
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 09:58:29 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30IBYM8b026109;
        Wed, 18 Jan 2023 09:57:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=8ZsZiGbNU+L5bpWRAiDuAewLRQJzFU+Mr4/UMatgoGY=;
 b=Oep4Fsa/u9XH2HysLS+8q51XVrfjNWR3mPTkWQ44QUkd8JWHR5/lk77UHUle304RccTd
 CAZfhzHmoQdr+x/OYxZf8CW/MTniIaAT0VDLp8e79/MV9ShUUnvyLPZmAFO8rF/Wa/WG
 /ZVGf3e1HCmkbAddADa8UJVykmxgQ8QdFjDcbeh4d9l0jVsDRav8Iy182b8sPkRZ96Qo
 2mUNHM8r726Vo13C/i8xfIRaQneOUNtpbJ0BJ853v3Vx8a7B5B0IPx6DJcsXrc8aSy5K
 /9nL05PeNckULb23NgoN5a6jrXX8SOXNuxsppEg/iQXwa0L0p2gY/+thUIHViHCs15Bm 8A== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by m0089730.ppops.net (PPS) with ESMTPS id 3n611sf38s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 09:57:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGIGSO9aEqmyzOwrvpwUppy5hXHEcAdXhDYhefre6s+AVtvuTrE4Q2myprW6ePHFsKef0gE1pwbW7GEHHyc+Uom0vE2OcAm+3CTQ4VHWU1SHsD9JxPpiPeoh/zrcVGvAgC97bT0ewWXLU+p+/dvFoVwwMVWzwNF5g5ZG0MfGHimNiGDZAdwrbOLhM5/Sfen20Cya9sSa5C8RGP7zw4oQbVmHU5sqQdzUxfh2Dp6/FyVTGSghXmcvPsH4ht1V4bVzis4SWXiCYfh4U5fQ25WJ8zh/reY3QchRBHr/vYqLnBmWHBWN1kBoDS1go0zjSE0/DhCpr/HwtR+82jrjGBpWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZsZiGbNU+L5bpWRAiDuAewLRQJzFU+Mr4/UMatgoGY=;
 b=e1tMNFPjciNnmFJELLd1qA4Q6xcPU3pbfdfOHSeVz8zsEefhjJC+JsmGy1uXUxMWNu0uuYQXtUagnBctpHfIbhEWOpBoEr2huZRERJw1G5PJCwi3cm5MlkWy7+onpK2gEC6bvbwZ7upQA2An/KeOkT/XghztClq76ECdBbdmibcD66f8Tfnu8Nziw8jiQ7guoDUcROf2lmNiYwKlbu4Yla+AGQ/41WX1lW6BvIl76Daw/8JzjbQ11HtAmivw50b3tOZMcfwikcXMs8qDPnNK47RDf5iAMrumo/XK8021RaQlFU7hBYfcCEq4ig5BiaUATYNBmCPs2cBAEwHKDUELtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH0PR15MB5971.namprd15.prod.outlook.com (2603:10b6:610:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 17:57:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 17:57:50 +0000
Message-ID: <5592d49e-5a8a-158a-093f-158ecca80cdb@meta.com>
Date:   Wed, 18 Jan 2023 09:57:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf] bpf: Fix off-by-one error in bpf_mem_cache_idx()
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20230118084630.3750680-1-houtao@huaweicloud.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230118084630.3750680-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::37) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH0PR15MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c783b83-aa02-4f83-3816-08daf97d8400
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGr4bkYwwuDNHFxhPKqDKAOPEtgi2z4UXENaZE3hE2rLPF6JizfFEsjADn8iLeIdGMBnrW4mTgw0/ozFt3J+Xjeo0h2QBwQ5Y7IgWT3+dhfP0Mbb7yb7oVTDuZzu8HBp5XLpck6cc6cRq/1FO/luJ5sZ9RrmA096n3ruMeAwEJ0yc41jUvc1ERaOCi9jR6BX9w9JABSWvhSSpjTDbGIBmHmE8m97HPzqN7OZNWq94w5UvElIHmX03SFs7mpxaG3ctpEWpv7mVes2mC6Nz2vH7AJ6o9qgWSlMRmaPgX5g6sPSCizZT9ofpeONxtV8t7j/iBG0ua2KFs5aaO1xwRv9/qyR3AJMg7J6+v9TF657V5Un0nMkU7vQ6WCkXaFf4Fqssapftqs+YnMnwMBRmBrvtl+XRxFtYyL5CDRLWEG3VJbMZsGKkiVUObzb2rH+Iu13oto1OyapKHrp6jjkTNQH8YFgs4olqIL5t//V4ITzyL9b8xOCKxzZcsQJvHB+8Hnn86cZK6kTn61NkfXtkvcfAeLPoDqmX2e17mACMW7D5vWLutu0mdxYKoQuacb5s99IMo0EZrYIwfiSWy1xiTcpo96mVsaUbzKWroc0qPHCXYFvfjQhCxncZ2Nmy5wPEQFz+02gW/WkTseUEMJIAxPCUSmLp6w+HTVgQs1KIPW9cqiSGIZGzuzd2Dqhtd/D70sXKSuTWkEa8SlqYjzfUjzjiPHd8UHSYXlUG4zfzTomXAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(66556008)(66946007)(316002)(8936002)(54906003)(66476007)(83380400001)(36756003)(4326008)(41300700001)(8676002)(2616005)(5660300002)(38100700002)(31696002)(86362001)(186003)(6506007)(53546011)(478600001)(6486002)(7416002)(6512007)(2906002)(31686004)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b29QMFF4L1QvV3BjUnFhcS82WEgwWitQM3VHZnV3VjlBaldyM0hRMUJibWpS?=
 =?utf-8?B?WWxZOHhuNVRORkdNYVl6WitmUkRWbjJqSWlrbDY0bUkvbVJzbVFBaG0xMnRQ?=
 =?utf-8?B?ZTI0QXpTL3lSUGJjdkN6YjcwYmJKcWtiTW5NWS9uMUhjYmRYZDBjVGxhOE1K?=
 =?utf-8?B?RU1sQlV3V3FKaXo2bWx5RG5SSFhRd0dZaUduSkpZSEFYZ0grbDNkQ0xXK1hP?=
 =?utf-8?B?VXNVVThZbWNBWU1WVnFpMDFqTkdNakR1Y2xVZCtpVkxMd3lwUGFXT01pOU1Q?=
 =?utf-8?B?bktqaTNueHBCSXdDL01MalljS1JoZXNNaWNEcDlFQ1ZORHZHbitiWXROVnIz?=
 =?utf-8?B?cVBVRkZjSW5VRHNzcWRJSUFEMzFsWk55WCtTN0s4amxTQTc0UVRQS0hrTVNE?=
 =?utf-8?B?QUJqSTFXQ1JJRkVvOFhXZC84cmxqNDQ1NFRlNE1xRGQ1MUdZNzhkTjY5Snpx?=
 =?utf-8?B?R1RlMHdJWUQyVnlab2lWY1ZsdEpnbkdTelhvRWlxSlhsZ0J3MUFiSDdHOHdT?=
 =?utf-8?B?NXZxZnpqeWFTT3Bjc0dDNVJsNXQ5Y1p0Z2hJcG4zNW9EV1hJSjczbEFpeEFH?=
 =?utf-8?B?U3lvY0xzaFJlRTIvRlk1NzFNQU1TR2M1THBpYU9NbWpUb2k0QkV6MzVrbXV4?=
 =?utf-8?B?a2NsdklISWpadnNWVE0vNko3aXYxVUxUVSt3dWR4eVpYcmJYR3FQTWpGNDkv?=
 =?utf-8?B?ZURYZUtRMERKZ1hOWVczU1ZWWU1hMWpveXgwMTlFYTR5VzVYV3lLVEN5bzdx?=
 =?utf-8?B?QWd0SEc4c05aZGdhLzlwaWZGYS95OTl4Z29CYWx1TURaVGNCOHc0eUQ5dGwz?=
 =?utf-8?B?RlIwM2ZRUTVjWVM5Tk8wY0xyZnhlZFZPaWpQcjhHOGRDdWNuSU1NQzZmOGhI?=
 =?utf-8?B?TGJyVFcyQ0NWcnBIOEt2M2ZEb2F5S3BsbnNYVFJvN2hNVUdiUnl2c1BGWDMz?=
 =?utf-8?B?MjY3ejBaTjI4emRRWlNMQ1hRRVVyY0RwRjlFcG0vSUY4TFdFZURVNTlWaGNE?=
 =?utf-8?B?YVlESUVYdDA4aTJ5Y2JYek05V1BEWmxqYXhyaVY5Slg1UnF1dWljMk5yUzhC?=
 =?utf-8?B?QUNwdlpOYWNBV01nbGxGbXJFTGE1aUhUZ2pBcjdyQTBsdkFIbTFyOG5mbDcx?=
 =?utf-8?B?M3E3dmIvN0U2RnZXMjg2QmNsWXBySm5LR3QyZkVqSGRsaFh2YmdoTFF5TnRD?=
 =?utf-8?B?WWNCdlNvVFcrZldIL21PRVNHUEZhQUhjN0VqVGw4UytMRWNaQkl4aFllSVIw?=
 =?utf-8?B?RGVHSVpOYTh0RTlvTG83SGY1L1h2eHhKeXNsTjhsMGg4VmF3amJ3UzE3clJ0?=
 =?utf-8?B?L1ZOUTBPQ2NCYWhvNWlwSlJOcVBJV3RWazlGOWRtYzVHbGlCWUFhY01CVklr?=
 =?utf-8?B?K1lxSmJhWjI2SDkzbWZ2b0VFQXFlcTIzbE0rMGt2NXBSQ1VzM1VyRkdFcmZw?=
 =?utf-8?B?OFdHQlNQbEFVcTRWUEhuRlZYTnVENVlDYm81YnpvVUhnazFodnVuamlHSGxs?=
 =?utf-8?B?S3lTWERNeUFPUUEwM2hDamZxMlU0QWluVkpJUzdsZUJWZDc1RzF2NnYwL1dk?=
 =?utf-8?B?YW01N2lxN1BjdGtNMWVvRW9CYjd4MmJ5bFBNOUxKenBITGRxdlFkdGlsaStC?=
 =?utf-8?B?TFhGRFhDSStmRmF2aDVFM1JwSVpaRE42a29kMENDRzRVd21MbEJXem9FY3o3?=
 =?utf-8?B?UHVjR1Z2WnczeklIcXV2T3pOOTRhcEUvd0ZXb0tLK3c0RGFGeHVETkhqSGI0?=
 =?utf-8?B?SC9VQmcwdE43NVVNRnkvS1dxVlZybXlqVUd4UjZ1akFtV25INEdsdUdVdXAz?=
 =?utf-8?B?ZStZOHZ3K3M2N1RGdEhyZFZBMnlRTkRFUG9DVG0wbG9iUEdFeXJyVHBKZVU4?=
 =?utf-8?B?Sk9QOGxmTnF6cTcrcGZja1ZpRi9EeTFrZzE0blhZaHYvQmNZSDFCV3c2andV?=
 =?utf-8?B?RkJCQTMrZnhkVkJsYU1XeXBBeVB0TEN0R3h5ZXBaV2FuQWZkNlU2TXI3Z1Q5?=
 =?utf-8?B?SFBxRmpNZFBmRW1xamhoaEYxUGo3OGN6bmU1WDVnRGtSaFlxWGt0WGhJL0tr?=
 =?utf-8?B?bnRSRjJrcU1CTjR2Y3J2amhVNDlXbmFVendYUVRjYnVWWTREcEhCUTdyWHJl?=
 =?utf-8?B?eGxZZTlEdllod0NzOHRkcHJsK0szcEhBOXIrTTNqQWc0dnR3Q2RZa2pLY1la?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c783b83-aa02-4f83-3816-08daf97d8400
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:57:50.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGc1MqKRRR5HX8sPNr0lCAU5Ge2N83YQKExh6tAxtS/2q2SFwAGh8py3m00SY6/L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB5971
X-Proofpoint-GUID: 1zwoo8AuNSQxBZAgQrbBsUvQ4sy7JoYR
X-Proofpoint-ORIG-GUID: 1zwoo8AuNSQxBZAgQrbBsUvQ4sy7JoYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/18/23 12:46 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> According to the definition of sizes[NUM_CACHES], when the size passed
> to bpf_mem_cache_size() is 256, it should return 6 instead 7.

More importantly, e.g., if the size is 4096, illegal memory access may 
happen.

> 
> Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allocator.")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/memalloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index ebcc3dd0fa19..1db156405b68 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -71,7 +71,7 @@ static int bpf_mem_cache_idx(size_t size)
>   	if (size <= 192)
>   		return size_index[(size - 1) / 8] - 1;
>   
> -	return fls(size - 1) - 1;
> +	return fls(size - 1) - 2;
>   }
>   
>   #define NUM_CACHES 11
