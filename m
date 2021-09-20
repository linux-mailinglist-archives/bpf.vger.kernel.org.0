Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A780A4127B7
	for <lists+bpf@lfdr.de>; Mon, 20 Sep 2021 23:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhITVHD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 17:07:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31966 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231799AbhITVFC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 17:05:02 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwRdI000545;
        Mon, 20 Sep 2021 14:03:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=q5+9U8jkNWzyd7E7bASyKqZ+gjTqBJWWEv/mFYLAyOY=;
 b=q1b6Ut9l9JA6vvQmz0rOlHYseaGdMkF8pH0N+P//7D3c5B9hieIC83NB3HeaLJng96F3
 FJL+yR+jGmp4KjBCNlKl1VC1SwfeLaeQu2McwPHQHFqd6cZ4npsCRjhPK1dl8iX51rBZ
 HoQxWe+JJ9vZzOvSt46v+qzTyHXtgORF5ek= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6g8uwwmj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Sep 2021 14:03:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 14:03:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W47iVKqgScprTm6+1kTl6SxbrpjwxTcaTEQXW3joe1qTIHtTJea5A/51dIoTmVldgZ9cgrE6GUyTLr4tKyF3gGJQZlNwPi1eiGIlbEaoBcRHfGYkDOSgyNxWBanoF4KtVnwsxR6750q4afwxFNu3qi4Uoor79jpfdguuEijQ52VhHOsI24F/GEHJe+H9a9i4af/Jr5SnvXcrfaQgTXNxgk3dU5J7ekKmBAeoZtX0izt3t5W0wZZowG6ULwT/zv2NxcqH9E7f2dcUCj8AKzZ0ZZLOvjrf/z57ZD6PnX6MudIBc0eG/UJHHetI6UTSiLAtvX5awdwT4l8VCnUxQJMa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=q5+9U8jkNWzyd7E7bASyKqZ+gjTqBJWWEv/mFYLAyOY=;
 b=FHFBhQ74hUw94Y/p3pOE5GN8j0HeeIAvFEMEu9KNpLZbRA3snngPRB1ie0S3PK+4paR/hjFNhQvMXas+zYVS/Z1twUPNERXXTbPqswzOQos8yjmx2lI06FjgdwiE+FNjtNvp3ssj+6ijXmBQx+cVJt9yOrqg5cjHeOlWn9yOpulDFXh75BN5PpGySF9Eo+JcotuYOTvcMMxeFs8SWBlAColPCd7VBjhSuvxaFds8Sv8qyyOV2Jk1a8gBpBQrdmpO4SKeAptj6e9HGy/dT+6LX2VZym88g9JPcTh8L8xtJu4HK9NiLhC9B9RyBRw5SW9RcKa/8oXdIJx6V/AXmDby3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA0PR15MB3854.namprd15.prod.outlook.com (2603:10b6:806:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 21:03:26 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe%9]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 21:03:26 +0000
Message-ID: <31392b5e-c470-5cbf-62ee-121b212ee175@fb.com>
Date:   Mon, 20 Sep 2021 14:03:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.0
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, <Kernel-team@fb.com>
References: <20210914040433.3184308-1-joannekoong@fb.com>
 <20210914040433.3184308-2-joannekoong@fb.com>
 <20210917170130.njmm3dm65ftd76vo@ast-mbp>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20210917170130.njmm3dm65ftd76vo@ast-mbp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::1889] (2620:10d:c090:400::5:99c2) by BY3PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:39b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Mon, 20 Sep 2021 21:03:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39e36f94-fea6-4589-fe18-08d97c7a16e9
X-MS-TrafficTypeDiagnostic: SA0PR15MB3854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3854446684D416275B08C072D2A09@SA0PR15MB3854.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNuBHZlhs6dPra0Tsh/7RlQZlYQ35+wt0oWVsburc3Qhr06zEh5pnAkIilOA28xE0Gw4/a38w042n/PTgom2BQYd1vhX2/Wq/rVj86++bbf+Z+N5en6+7aUxVCUTxYpgxc3GuXa3+KQNM2SeENuXB9zPFIHXwtSH+8rMLeT9OY7BI9/HYnb1f8LJCxxR30G4gPhh87GM7UrAHVRh9o6Ofcuy5T5iJQ0NxbhXo/2ODnnBOUugyPeV3iNxVrEO5izGbytZrTiCfAjWwSGtSh/bcjLgJeD3FX5i/YEJGRRvYYQmu3AkrlgLYEREHgJofJ5hawuz+nzmSn2YiDVPV9OY+DPcT7wbsZYVpiCZBxxzLIggyavsWE9/dDJRinJ87Ss7RMBfbE7InhybeO9pEbZSGaAdD9q0Pcg19NV+Zthck1doWOHx7MAqH6nuA3NIbFssXdoK+Nxtmvt8KeS9U/nKcJNmxM9xhe8h/83U2o9jnkBGMsTYonLKIjNa3fdFj7D98JBT5Tbv9U4hbFm9MDjcF3l0w0dLZd8x8QftrT2NObcLcwOKt8SReFoGxYUGgte4UQJcVsD565uz3cw6A7FVerpPrEvoNUNRMuguIHpJ0HI+wQIuhxVafy3tqCs3VeVGaW0Kn5D08a7DB2FFo2EfGOSwZCongHAi5Kwp/r0Bc2WF7BfAcx070713sChvnf0RH/3wonULmhfpy6HFgrmkvFi2UCYSQuODiUGWhIYk6NE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(2616005)(53546011)(6486002)(8936002)(6666004)(8676002)(36756003)(66556008)(6916009)(66476007)(4326008)(66946007)(31686004)(38100700002)(86362001)(2906002)(478600001)(186003)(83380400001)(5660300002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVl2WE5rTWhmK0xST3psSXJYNUFRNXkxN3NVcnlCZlN6UkZJbUo0SVYyR1VQ?=
 =?utf-8?B?cFo2SExDUWd6bHNxd1pXZVREYWFURjlaWHNJaThiUGZQS2JUR1Y0WnFjajR3?=
 =?utf-8?B?Y09SUjFXNnA4TEpvd054V3VUNWNyd2owdUFjSmJMTnZmTHVoS3pCR2J5eXZE?=
 =?utf-8?B?dEVtbXR5MzVFOVlSc2FxQ1BoVXg1amp4eDlMMnZlTk51K1JRazJSbGpDSHJJ?=
 =?utf-8?B?bEdEOFNHRVZkN0hJOWpZbFlwTmFGOHVidjRsOHF2dTh3QWJURFFoaW5wMk5B?=
 =?utf-8?B?YWtteGNUTUtDYU5EckY5VE1LY1BOdlByL2lpWVdZV0xYZVpKWlc3RlBUSGhm?=
 =?utf-8?B?K2lpSTFHZkFjODZBOW1PWmlYVWFkTjJxZHN6NlFFQVV0bnJRN0tlRFpzL1Ba?=
 =?utf-8?B?YWpCNG85eE9JcnpVL3VWNnhJbEdrOU9Db1RBS3czRk9XOEExQTBsc3VNYVpo?=
 =?utf-8?B?SmR2c1dqd2h2MUtSblJLWmppRDVzSVBvM3pMTFFCQ3l6ZHlzZytMV1lEUVRp?=
 =?utf-8?B?TzVYaUI2WGZCMW5vMzRtOW5jQ0l2S3ZJRWlBQ3d5ZHkreUFPSmNTM1c2dC9C?=
 =?utf-8?B?VjVTMzF3R09PWUovYlhIZlVuMU1VN2R0bm1QWGphYlNnVlJTc2gzUThoNnJj?=
 =?utf-8?B?R2RqNzNucHBqT1VGYUkzMlQ5UFVFNFkwS2EyQndEQmZlQlo4ZWs5QXNDWmtT?=
 =?utf-8?B?YmwzcXFXUEQ1eUFoNkl1SVdyZldINlpKS2I2Qk5yWTRZZkhXREVnSkFLWTk5?=
 =?utf-8?B?eDhteXREbEcvRWYwRUZVOWoybm95WDg1bHVrUnByVDZ6M1VIblVnZEx0YzB3?=
 =?utf-8?B?K2hCK0ZMdWRlaGZ0UzBVOElLN0w5VzhSZENXWVpUZ2U4YXFYZlpZejI4L0Fu?=
 =?utf-8?B?SXI0Tm1KNml3REUvbkVqcHVSeXI1ckFINXpETG9ibGc3N3ZkVGdlZVBXTHdH?=
 =?utf-8?B?RzZQWVpHR0N4V1N6MGQ4dnZZZUJ6QlBBbzJBZWdtdTdsZzJqWkM4ZWJxZFF0?=
 =?utf-8?B?eG9neVhDZkd3WkpBRXJhU1lDaFpmbE93TlVYc0ZOTmxjUEtBM3ZEQ3BjaDYy?=
 =?utf-8?B?SzZydmZVbmljdzBYSlFyVkhxTit3TkFSWHFZSE04MXpCdzgyQnd1YTdKQVly?=
 =?utf-8?B?SVpIUlBDdS9Lbll0N0Z2WDEwQnhjcXBDaDBKTm9BQ2ZIbktVRjR1WUlhUXVD?=
 =?utf-8?B?aEZIYVVvUjN2N1hxUjg3cmk1dXlFVk1SUlMrTXZhdXNOYkxRdk42Tm1OODlR?=
 =?utf-8?B?eDhHQmR1cEhKUnYrUEJlYzhwVUFnVVRYblRET2pzQXZ5ZDRoelQ1QS9zWmFv?=
 =?utf-8?B?d0JGb0hXM3hlMW80RWoxRXl0TUZtd3d3WnFzQXpaUGo5WFpKMFlrbHlPdEtR?=
 =?utf-8?B?ZFpJSDk0b0ljREgwTy8zVmp5QUVEbytpMnZPN0FNMXdsYk9RZGJkckI5K1pD?=
 =?utf-8?B?VkZ6YVdLOGZvcmlvUjhGUUxhNVlhVlJFblhzYjR6ZnRCemV0Um5EQThxMlk3?=
 =?utf-8?B?L1JDQ3VoKyswYUI2ekUxdVJhdEFzRUlOVmE5d0xRdzllU2krQTEzUFB5cVFW?=
 =?utf-8?B?cHc4YmE4eG9pUWg2cXVmQmlneWdja3VZenV0RC9aOXVKL0lWeTd1Z1R3YU8y?=
 =?utf-8?B?OHNxd3h4UkFBVGVwVmpRMlRpbDVpTUpYVHdPOFUvYkxyYlBSUjFZUXVXaHk0?=
 =?utf-8?B?TEJLRUNyeGNpZUwvM2NDaGxTV3JuVkpkSEY1YU9UaUdaL2JiKy9HYjMxRjVK?=
 =?utf-8?B?R2RBN0grYTNjTCtZNXV1bm1MN1ZTNVVDM1JmbEhxUEp6SVBuWnhDVEU0cWJh?=
 =?utf-8?B?aGU3VXVHNHhQQkVIQ0hkQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e36f94-fea6-4589-fe18-08d97c7a16e9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 21:03:26.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkkoCQx6Sav8UbXNv+pNH89xpEH8sWX2Z+I9PQ66YmPrlW08hiAqH0BYTomYKbKJbMAbKooPIkg4QeoMIiUxfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3854
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: nxxN54aCUQX1aWXSf-g3GH2flo9fDpWR
X-Proofpoint-GUID: nxxN54aCUQX1aWXSf-g3GH2flo9fDpWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109200120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/17/21 10:01 AM, Alexei Starovoitov wrote:

> On Mon, Sep 13, 2021 at 09:04:30PM -0700, Joanne Koong wrote:
>> +
>> +/* For bloom filter maps, the next 4 bits represent how many hashes to use.
>> + * The maximum number of hash functions supported is 15. If this is not set,
>> + * the default number of hash functions used will be 5.
>> + */
>> +	BPF_F_BLOOM_FILTER_HASH_BIT_1 = (1U << 13),
>> +	BPF_F_BLOOM_FILTER_HASH_BIT_2 = (1U << 14),
>> +	BPF_F_BLOOM_FILTER_HASH_BIT_3 = (1U << 15),
>> +	BPF_F_BLOOM_FILTER_HASH_BIT_4 = (1U << 16),
> The bit selection is unintuitive.
> Since key_size has to be zero may be used that instead to indicate the number of hash
> functions in the rare case when 5 is not good enough?
> Or use inner_map_fd since there is no possibility of having an inner map in bloomfilter.
> It could be a union:
>      __u32   max_entries;    /* max number of entries in a map */
>      __u32   map_flags;      /* BPF_MAP_CREATE related
>                               * flags defined above.
>                               */
>      union {
>         __u32  inner_map_fd;   /* fd pointing to the inner map */
>         __u32  nr_hash_funcs;  /* or number of hash functions */
>      };
>      __u32   numa_node;      /* numa node */
I really like the idea of union-ing inner_map_fd with the number of hash 
functions (my worry with
using key_size is that it might be a confusing / non-intuitive API quirk 
for users), but I think this
would later require us to add some bloom filter specific APIs to libbpf 
(such as bpf_map__set_nr_hashes).

To make the bit selection more intuitive, Andrii suggested defining some 
helper like

BPF_F_BLOOM_NR_HASH_OFF = 13

where the user could then do something like

struct {
     __uint(type, BPF_MAP_TYPE_BLOOM_FILTER),
     ...
     __uint(map_flags, 5 << BPF_F_BLOOM_NR_HASH_OFF),
};

to set the number of hash functions.

Would this approach address your concerns about the unintuitiveness of 
the bit selection?

>> +struct bpf_bloom_filter {
>> +	struct bpf_map map;
>> +	u32 bit_array_mask;
>> +	u32 hash_seed;
>> +	/* If the size of the values in the bloom filter is u32 aligned,
>> +	 * then it is more performant to use jhash2 as the underlying hash
>> +	 * function, else we use jhash. This tracks the number of u32s
>> +	 * in an u32-aligned value size. If the value size is not u32 aligned,
>> +	 * this will be 0.
>> +	 */
>> +	u32 aligned_u32_count;
> what is the performance difference?

Using results from the hashmap benchmark tests, using jhash2 instead of 
jhash for 4-byte
aligned value sizes improved the performance by roughly 5% to 15%. For 
non-4-byte aligned
value sizes, there wasn't a noticeable difference between using jhash2 
(and truncating the
remainder bits) vs. using jhash.

> May be we enforce 4-byte sized value for simplicity?
Sounds great! And if in the future this becomes too restrictive, we 
could always loosen this
as well
