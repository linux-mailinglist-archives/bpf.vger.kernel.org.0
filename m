Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206AB353BD1
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 07:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhDEFnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 01:43:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229454AbhDEFnP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 5 Apr 2021 01:43:15 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1355fIJG010162;
        Sun, 4 Apr 2021 22:42:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=j24R0+EUZd2neGdy0loAgffX21qeYnkntITEKSTOZyM=;
 b=KJ1iGQhSDCRXoVrwfXYgVH08piR01CdHSUOi4bXAsp68v/vlE7dKd9nW6eC0hJfR/jNv
 ZSDrA1yYc7HgNgHklZZrdMxdspMoOvCB1v75GU4tRrSPCSAHMAbaAQaepjHsO5tRsBys
 lykWt+9EsBNf/yXDo8cIP6BVx5Jj6h0u8oQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37qnq6958g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 04 Apr 2021 22:42:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 4 Apr 2021 22:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WETxxM0W5+h4kiDJvGo9XEmUs4a2WzBePhsNczd9ZSe7rK25ckPi1NgICw/4i/uft2x9wTbDPf8zOE7oQ1ZxbVMGgqfe7ZOgX5aPL0eZr2siU7kusS29x0911EAZH1fiMbpBLS5xcLiB2e9lX/2uTfObjLkUvWdZwI09hbdkmRfjNh9SNBdqipC+c7ub2mBcnArhMIxqHLYBOGQO8tAwsCJVdDsyDoPbHx7Sk9Ho3yMsmGeOoeVwDxoTA+Jdr1B4EzK3dfpkegs8sTqSKoIafRPwYUKoVaL8wySV+90EgI4oO9+g/mjwCRhU7T2Hc1UAO4IFBaQIplFKEu/FYUkPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j24R0+EUZd2neGdy0loAgffX21qeYnkntITEKSTOZyM=;
 b=V+27IroGDuzVMfgn7Mq5KDHThXlsOTZ3GPkY3WMbP/i3Hza73vUi5gsRewcoZs0S9uLoEB9w/Xh7i1hXxWDuqcklJqiTc09nBOW3BZ8w6F06t28l0LWBjHgNasnbY5iHoimp5Pt8bkWec7ah/1IhxxODszQJ/n1uq8NkPHJajjGbxlo1BUDWq5I91socPj6JEOk8arRdnE0YQGjeE7icTNEeszYjdpgidclG6DCItnQdU1vP5fnuiKcjcPS3ufvbrVwACQ2MWpFT3RxFNGyzwHpg8T5bpEjsqwzAFlbWjracMWuvY6PwCxJiv40GieL7BrNmynq9bTo+qyKsV2UWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3792.namprd15.prod.outlook.com (2603:10b6:806:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 05:42:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 05:42:52 +0000
Subject: Re: [PATCH v4 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
From:   Yonghong Song <yhs@fb.com>
To:     Denis Salopek <denis.salopek@sartura.hr>, <bpf@vger.kernel.org>
CC:     <juraj.vijtiuk@sartura.hr>, <luka.oreskovic@sartura.hr>,
        <luka.perkov@sartura.hr>, <daniel@iogearbox.net>,
        <andrii.nakryiko@gmail.com>
References: <YGHOxEIA/k5vG/s5@gmail.com>
 <ce69af50-3667-c52d-1f1a-b924bbe0fc58@fb.com>
Message-ID: <9325297a-66b8-eb26-22cb-aa4a740e8df6@fb.com>
Date:   Sun, 4 Apr 2021 22:42:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <ce69af50-3667-c52d-1f1a-b924bbe0fc58@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:e412]
X-ClientProxiedBy: CO2PR04CA0144.namprd04.prod.outlook.com (2603:10b6:104::22)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1149] (2620:10d:c090:400::5:e412) by CO2PR04CA0144.namprd04.prod.outlook.com (2603:10b6:104::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 05:42:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0062e473-92dd-4ad3-a0a5-08d8f7f5a7bf
X-MS-TrafficTypeDiagnostic: SA0PR15MB3792:
X-Microsoft-Antispam-PRVS: <SA0PR15MB37921B9BC9B7C0F84A3939AFD3779@SA0PR15MB3792.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbxeqNzYd+/hcoRPwn/ZyOcKW7jO9WhJT+gcQ32yB4VEuOy2RSI7DcAR8UC1i8hzE+2TND22Bp4hxmuCZdaYNMWX3vWJ/fREUMwDTHqdR0NPVHimGwe66LaiiwXKpDEQg0sQKr3vPf8f3Ydm6UIrqBZLXhx7YJosa+p6NBD7VQ6f+HyMnsjTTE7HatbmKPrimXekpwzZmygmN0KEu23Ew/58eVwo1PE+2Sb71WbK67J+A+khGAXB4sfJeS31ARkMrPJF6DBydps5mBacq9qwIZX05VdSz+QXPDsWWdWOtzf1JiJSO1/tEN1XoRde7h3dUbDRosELoHYNV3V7Vh7SwG//1SkxP06ATUEV6j0HsUjUntjZ3Gepixca1YmFgVvZDkVEcn7XI4PgQaI/550liFX7jdA8y4wx/zE/fDM0siq1n7N19+mpGPhwesJVqyBH5zLm7X7a30Q7ttjfJ3ZsrbA60ssDuDlnVyYdxMcHeMVxzWxu0FQY1CRLR1lerxgwMiyKToYkzuCXZw00rXzoZy126gAsMLp5xwdUHMosPgPJ6hQW2f2W8li+ctKD9B73qZcM3kgExFMhIywfc+ryI3mWPaqbRUoXEbTzMFOaP5Ndh/LXo/Zk/3ILRjd2Tj11oFaHdEdtlb/va1RAhQuZ7xYysB4CR9TV1JJOtbyJwjxIt37Qb/FQooweAtPnRS0nIVAqOZP/2xXQ9ZGgFxW7Xoid/42pEAnMoZo6NYV0Kn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(39860400002)(376002)(396003)(83380400001)(36756003)(8936002)(2906002)(2616005)(186003)(31696002)(86362001)(6486002)(53546011)(16526019)(52116002)(316002)(66946007)(5660300002)(4326008)(66556008)(66476007)(38100700001)(31686004)(8676002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UVB5VzNNVll1Sk01bUJnQjJnL1BIRFVJOEttcjMyUTBqeWQxbmJ1RXpFYlBm?=
 =?utf-8?B?MlVaMnVIeFU5VmpqM0VDQ2czRUxSOE9oZUtLM0swOVZkS2R1dkdDQktsYUZt?=
 =?utf-8?B?cFdkV1BpeXhEd3pZVEdSeVlxbWoxZUt2M2k0bGhwNFAvOStheTdhcWtZUEFD?=
 =?utf-8?B?TE1XZUpWaXJzeFpPdnZDa25KT2ZubjZRdTd3VFpicC9tdUozb2RoRG9DemN6?=
 =?utf-8?B?ZHd1dkFVVURGelZIQ09TNExRVDRvVlYyWXNma0lWemdQR0RiTGFlNEcwNllu?=
 =?utf-8?B?MWdPL2l2Uk5XdjhDcm1jYjE4bmxEc0lGN3NrWUJlbVF1V0o3SVVweHdCRlFr?=
 =?utf-8?B?QlJaVEZtY1RYTUtidHJ1bTd3QTYrSFMyaFZIeXNFdlBNend6c0hGTG1aOHhi?=
 =?utf-8?B?bUxHYU1OQ3dVWnhZOEFBbG9oQ2xDWU1hU211ODRXdzhFa2VUcjRsVzk3TDNk?=
 =?utf-8?B?cVA2VFNRL3dWZlZyYzBNK2hhSGZzUmtHRkg0Y0Y5MEVZTzlhemJ1U2Vhbjl5?=
 =?utf-8?B?dmgvNmJadDdYNzk3ZWNYRytRYWh5K09hSFp3bzVTQjhHZ0NNcngzYytDaStF?=
 =?utf-8?B?bnJJNnVYaDdDaG9PdEJhdE4rY051bWxTeDR2M3FRNlFUUHIyL0VzcTRjbjRT?=
 =?utf-8?B?UEpXajRkRC8rSVI2eG9OTnhPTVNjVjd3Z3FYMmErVFh2T3ZQZlVORUtWU3Vq?=
 =?utf-8?B?RDhJUzIxeFgvSzEzaVo5bnN1NGplOUh2NVBQS2tOaDNtMzMySlYxRkJBOTVa?=
 =?utf-8?B?Q1Zwejk2cmkremRwOWdpOTV4WklTVVlCRHNjUVZRYWNiOGw3ckFabHZaVloz?=
 =?utf-8?B?R1Z4cUlPMGFCYU9rb2gzVXFQdXJVOExXbnI2OTNxNnFnbmJaOXJPVllXUzI4?=
 =?utf-8?B?YnJrejJkb05yMEU1WEkxVktKTGtaTTFFUFBDTWplelUzMkNoRVlKY0ZFS3pH?=
 =?utf-8?B?WmJKb0pQUndYTmI2OWd6TS8zeEZqM090eWJWV3hzVXZTbi9RV29ibE9NMEkw?=
 =?utf-8?B?ZllXMlh2R3AzbzhXbWtkZ3RSUjh5Z1p4ZG1XQnQrQkJTTlY0WVkwb2tLUW1H?=
 =?utf-8?B?RXZPOHp1eEZmcUF6bVluNGtpajVWL1lSWUo4T3g0MDB6Vlg3VzZFWFQxa0p5?=
 =?utf-8?B?QkdMY2Ywc1ZJMStjUUJBMnVJNjFjcHZUZ0hiLzVuNWJ6Z1hHYjRMaWJxckw2?=
 =?utf-8?B?U1pMWnc2VkY2QVd6QTNBckhOVEs2SlNsSEFvaXM0cVpaS0E3allwVDlLTUYw?=
 =?utf-8?B?M3ovRnZKQisxZjI0MVIybWFxUnlwUEJycWdpSWZZZWowSjF5RXdTcnNsdTNX?=
 =?utf-8?B?Q0dZR2QwcThnNENON2prcURhMXZKMjVNcmROR3lLZCtBV1YvNmp5ZnduQXBz?=
 =?utf-8?B?c2hJaklIc3ltaUQ2eVN2U2JBY1dxaXZ3NUdGcE9BRGxWYkoyNGVxOGZuN3FV?=
 =?utf-8?B?NFF1NG1WbW1nMUk5Y3g5UTJUOXcvYWlmS3V3UHFjdHVnNUpWQjgrSk4ySllB?=
 =?utf-8?B?aHQ3U293VWdwQ3N5VnBrSnlKNGRxUXhITTlpRDYwQU5ieGpPR28wZWdGMitS?=
 =?utf-8?B?L0IrRzE5NzI4QzIzSnBrQytBZVR4MnQwNVpYZlppdERaUGh1bFQyL0prMmxH?=
 =?utf-8?B?blN1cDNndGtBZlhlLzZPUkxJcEVRbFU3UEVTQVQ3MHRjMXpBelFjOFhHNkFG?=
 =?utf-8?B?MjFlV3crOXRNMmU4R0YxYWxtZURJb0h4N1J3c0s3dFg4RUcvSmUycFRESlBQ?=
 =?utf-8?B?R0lhUWJEbk1ReldKNG80UGljNGd2SUdySHh3Ry9yci92QmJDRGpQQmR3RkJy?=
 =?utf-8?Q?EYIHjg5CHZHOabSVSxhByxTVOqG5KzL00ipt0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0062e473-92dd-4ad3-a0a5-08d8f7f5a7bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 05:42:52.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLIB5vkF8PJODWN2sMOdozZrPzrpJ57W5yIi87aAVouORLeZn52wJWwaFKlAPhTw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3792
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: _MQPXXo4-GbLDnq7-sR7EuXiIctnoE9S
X-Proofpoint-GUID: _MQPXXo4-GbLDnq7-sR7EuXiIctnoE9S
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_02:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/4/21 9:47 PM, Yonghong Song wrote:
> 
> 
> On 3/29/21 5:57 AM, Denis Salopek wrote:
>> Extend the existing bpf_map_lookup_and_delete_elem() functionality to
>> hashtab maps, in addition to stacks and queues.
>> Add bpf_map_lookup_and_delete_elem_flags() libbpf API in order to use
>> the BPF_F_LOCK flag.
>> Create a new hashtab bpf_map_ops function that does lookup and deletion
>> of the element under the same bucket lock and add the created map_ops to
>> bpf.h.
>> Add the appropriate test cases to 'maps' and 'lru_map' selftests
>> accompanied with new test_progs.
>>
>> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
>> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
>> Cc: Luka Perkov <luka.perkov@sartura.hr>
>> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
>> ---
>> v2: Add functionality for LRU/per-CPU, add test_progs tests.
>> v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
>> flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
>> v4: Fix the return value for unsupported map types.
>> ---
>>   include/linux/bpf.h                           |   2 +
>>   kernel/bpf/hashtab.c                          |  97 ++++++
>>   kernel/bpf/syscall.c                          |  27 +-
>>   tools/lib/bpf/bpf.c                           |  13 +
>>   tools/lib/bpf/bpf.h                           |   2 +
>>   tools/lib/bpf/libbpf.map                      |   1 +
>>   .../bpf/prog_tests/lookup_and_delete.c        | 279 ++++++++++++++++++
>>   .../bpf/progs/test_lookup_and_delete.c        |  26 ++
>>   tools/testing/selftests/bpf/test_lru_map.c    |   8 +
>>   tools/testing/selftests/bpf/test_maps.c       |  19 +-
>>   10 files changed, 469 insertions(+), 5 deletions(-)
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>>   create mode 100644 
>> tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> 
> Since another revision is needed, could you break the patch to several 
> commits which will make it easy to review?
> Patch 1: kernel + uapi header:
>    include/linux/bpf.h
>    kernel/bpf/hashtab.c
>    kernel/bpf/syscall.c
>    include/uapi/linux/bpf.h and tools/include/uapi/linux/bpf.h (see below)
> Patch 2: libbpf change
>    tools/lib/bpf/bpf.{c,h}, libbpf.map
> Patch 3: selftests/bpf change
>    tools/testing/selftests/bpf/...
> 
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 9fdd839b418c..8af4bd7c7229 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -68,6 +68,8 @@ struct bpf_map_ops {
>>       void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
>>       int (*map_lookup_batch)(struct bpf_map *map, const union 
>> bpf_attr *attr,
>>                   union bpf_attr __user *uattr);
>> +    int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
>> +                      void *value, u64 flags);
>>       int (*map_lookup_and_delete_batch)(struct bpf_map *map,
>>                          const union bpf_attr *attr,
>>                          union bpf_attr __user *uattr);
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index d7ebb12ffffc..0d2085ce9a38 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -1401,6 +1401,99 @@ static void htab_map_seq_show_elem(struct 
>> bpf_map *map, void *key,
>>       rcu_read_unlock();
>>   }
>> +static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, 
>> void *key,
>> +                         void *value, bool is_lru_map,
>> +                         bool is_percpu, u64 flags)
>> +{
>> +    struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>> +    u32 hash, key_size, value_size;
>> +    struct hlist_nulls_head *head;
>> +    int cpu, off = 0, ret;
>> +    struct htab_elem *l;
>> +    unsigned long bflags;
>> +    void __percpu *pptr;
>> +    struct bucket *b;
>> +
>> +    if ((flags & ~BPF_F_LOCK) ||
>> +        ((flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
>> +        return -EINVAL;
>> +
>> +    key_size = map->key_size;
>> +    value_size = round_up(map->value_size, 8);
> 
> This value_size is actually a round_up size, so maybe
> rename it as "roundup_size". Also, I see it is only

Sorry, I actually mean "roundup_value_size" here.

> used in is_percpu case. It would be good if it can be
> moved inside is_percpu branch.
> 
>> +
>> +    hash = htab_map_hash(key, key_size, htab->hashrnd);
>> +    b = __select_bucket(htab, hash);
>> +    head = &b->head;
>> +
>> +    ret = htab_lock_bucket(htab, b, hash, &bflags);
>> +    if (ret)
>> +        return ret;
>> +
>> +    l = lookup_elem_raw(head, hash, key, key_size);
>> +    if (l) {
>> +        if (is_percpu) {
>> +            pptr = htab_elem_get_ptr(l, key_size);
>> +            for_each_possible_cpu(cpu) {
>> +                bpf_long_memcpy(value + off,
>> +                        per_cpu_ptr(pptr, cpu),
>> +                        value_size);
>> +                off += value_size;
>> +            }
>> +        } else {
>> +            if (flags & BPF_F_LOCK)
>> +                copy_map_value_locked(map, value, l->key +
>> +                              round_up(key_size, 8),
>> +                              true);
>> +            else
>> +                copy_map_value(map, value, l->key +
>> +                           round_up(key_size, 8));
>> +            check_and_init_map_lock(map, value);
>> +        }
>> +
>> +        hlist_nulls_del_rcu(&l->hash_node);
>> +        if (!is_lru_map)
>> +            free_htab_elem(htab, l);
>> +    } else
>> +        ret = -ENOENT;
>> +
>> +    htab_unlock_bucket(htab, b, hash, bflags);
>> +
>> +    if (is_lru_map && l)
>> +        bpf_lru_push_free(&htab->lru, &l->lru_node);
>> +
>> +    return ret;
>> +}
>> +
[...]
