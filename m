Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA63403F7F
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhIHTMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 15:12:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57706 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245429AbhIHTMB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 15:12:01 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J9ZIt020124;
        Wed, 8 Sep 2021 12:10:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=d3fJrrWv5ES8KzV3fi+pfXo1bfqhL6Rpt4HJJVn1jwg=;
 b=j2bKMvzvR5Uc4d4HaF1u45vDelxnnRibGagUiacyUsUd/ZIUMKSj8ZRv8XR5Z+AWFaHm
 Bz8asgqRozyUSllRGQo8Oay0mj71/jKztCs4zv+KSWciy92Oz4DKabW2QW8evo/VJpY7
 fZGPEPecw/kpk4pVufiaLlGUH0ubXy7rifc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpj7ygf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 12:10:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 8 Sep 2021 12:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pext6HiIm2Ac/wjikSCm/jiB2wSlOL+ezFzGFsPpFVTtpn1tXGmN57U7uxR4j28+GjJPPEa0qKJRKzLjUnJh5nVpGk1rNgZNyjHms3tK8ep+T5dMf7TZR+v2qa8EVhrdH1yeXq5nIb4m/+UmLza0tQFgOigoIWo5/NKopI2HuNHufohK8BVMQ3zasxOab+X0Ris4iUPGqrVcoGSjeuEHA0eJTCZ7R8VEIBMzI4IXHl/W6R1Ec7eE1ku6VTt2sbavzZHiyY5nBf3BiCOQLk4npRVZptWKQgSxCMnsv/Chl63j8JD2MUa8GRlAuUYnzLcCqcZLTULRMg2n3Z5X7yxFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=d3fJrrWv5ES8KzV3fi+pfXo1bfqhL6Rpt4HJJVn1jwg=;
 b=QrGnC5goSNahakCloonG+NWW3Mys0JKtLEvDlfQ/dqTnAHLZiySLHQPRbismi+IPO/nhhQFGbn0IX/Ao4aSc5Aj/Cl8mg4b9oghYMfTQmChDQQKt++cEPJr7LkHWPLID+mCiXJGp0+Mq0+SC85BYxSJ2i1Hs8STe02vwnpu3YHTd0QpaxYG2Y7+Ph4UhsxKIGFBC3qyaz23D6BA/NJjjqQ3OaxDz3JjJJptSPg5/duqEmGCKC1EmGtvCii43zxaIxRowmVBY/QyOtHv+Ac8kNTLgI6StQLwfG1OSlXGW1bA2rk/1jf6rmJwznG5BwFuZvsBZWQTYttT4xm9s/7mfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB4371.namprd15.prod.outlook.com (2603:10b6:806:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Wed, 8 Sep
 2021 19:10:50 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe%7]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 19:10:50 +0000
Message-ID: <62b03218-5791-e561-6428-eca0092b5789@fb.com>
Date:   Wed, 8 Sep 2021 12:10:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0.3
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
 <CAEf4Bza_y6497cWE5H04gDg__RkoMovkFYSqXjo-yFG7XH11ug@mail.gmail.com>
 <61305cf822fa_439b208a5@john-XPS-13-9370.notmuch>
 <0c1bb5a6-4ef5-77b4-cd10-aea0060d5349@fb.com>
 <613259dfb6973_1c226208c1@john-XPS-13-9370.notmuch>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <613259dfb6973_1c226208c1@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c1::1250] (2620:10d:c090:400::5:92b1) by SJ0PR05CA0172.namprd05.prod.outlook.com (2603:10b6:a03:339::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.7 via Frontend Transport; Wed, 8 Sep 2021 19:10:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e1f4984-6ce6-471b-6845-08d972fc5f34
X-MS-TrafficTypeDiagnostic: SA1PR15MB4371:
X-Microsoft-Antispam-PRVS: <SA1PR15MB437180F8BE448F09584B1A0DD2D49@SA1PR15MB4371.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ToRaUhBUqd5jzukpe4ARnEIOsMxfaxftZkvutGDzIV0iD8gWvK7qyc0GQkN3DMJm7l07mONkLlco03DUUw29U8JYeGTXoV67fDzBLDapHvIEohXZKfisiviKgv1Knrfs7oXf060mOtbtfqDWl5+V45azNVNX5IzmYaWOjE8hHu0O7zrx76u4cqd1A7F5WYpK/rRZF/BPveBWZZMxC2kPGo4eizekFqaiGwMN4wDuXUQXyFjYF35XBZWOzGDqHaimAlExFJAm0usYuxpLcJCA2dUIOplCOvUPE+CkFgSi7CZr09v7pRmHbJJKtVyoUn2EzDWnonvWN3AEu+26Kg9ip4JpEs1mZHKjXN/UN0XjE77m/GMP3yq/tjdZg2E60po9hQfixpCyxaAD5GM95c6laQiKos9fv3qi8Uq+yVU75I4SZRg9f4rV9pARTQcrNnddGacjyn9OgHMWR5m1KsNMg0kwp49vWwrV/bnFiEvaJ7xhxYavGrKtvMb88YhiHDGu/ltYuafJQxA3/o+lrrhA0D6Bbb2W6R5fh/M+B4d8lG4q9DoroBNXHlbiXz8gdBDwQqQv2dNdvwz5fMR01NgspjhpAVYyqSk48BLxMIkdH26CcRbqF1VKGa0Gy7QHK/KpC87ztHR4WJB1wYh8uS+8jjppIc/E/x/T1LaQOBat9dV5n3XijG4kChkua3mhbLnBFo8l+9sqpd41us3KrLkhBXS0Pn3WNkOdHjply2bQPEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(2906002)(186003)(38100700002)(2616005)(66476007)(316002)(31696002)(31686004)(66946007)(4326008)(110136005)(8936002)(5660300002)(86362001)(508600001)(83380400001)(8676002)(36756003)(66556008)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZRd1FoK3lhOUtCcEVsQ0hvT1lZWTlzengzNXhZdm01MytyQmVpQnNiOWhJ?=
 =?utf-8?B?cy9xU2liSndRdHpvNzNkOTViWUg3TS9icUhiQ1o2amtSZExEcTFCZ1hYNEFN?=
 =?utf-8?B?dnV4eFZUZWtsdmpkaWREM2VLZ3p5amQ5RU51WFVPVnlRT1lXYUhvenVQaVZU?=
 =?utf-8?B?ZEhBTVA3ZkNiL2pFZW9kSVFRNXowN2tZMHliNSs4MWpCVjR5c1docll6MWFR?=
 =?utf-8?B?U002ci9DRVlMMStnRkIrUzJJK1dRNnJBRk1URW92WHlDZzg1R3FmaU5uRFl3?=
 =?utf-8?B?YWYrOGtaeFRHMFhkMGZiN3Vrc09UM1ArZ3ZoeDNpS2N5RWYrUVUyVCtpL2FY?=
 =?utf-8?B?TXdGQzNaNzlFdkU2aU5DWUdYRDRnNjBISndxekxYMDBIbUVlTFQ1TUdLUUlO?=
 =?utf-8?B?aUZMckdPNU9MZFdKZmxhc0JiYlRIQ2tML2RYKzl0ZDlXTjc2YlFva0Fyd1VE?=
 =?utf-8?B?Y0llL3Y5RVpVVU14RlM2aWNESC80SEE3akpMK3pWQkFUdWdwaFVaY0NoaVhv?=
 =?utf-8?B?TjAreW1CUGYxeVUrM1ppL2NpMVdoWFkvMVV2MGw4VVoxcXFwWktHNDJqbnFn?=
 =?utf-8?B?OFNFQmFYTXJGQ3BFb3Y2d0R0S0tMenhHSmxiVE1hLzJXWHVlNFFQbkJZUTZN?=
 =?utf-8?B?RTVKbUJ3TFJzbzY4L3BXczZ3UE55dWkzN0JheXF2Qkl3YndNWUZ4OGtoUTYw?=
 =?utf-8?B?ZmtJTGZPWWJFVy9ra2JIUkd4MnIweWJSeTJzR2psRVJGVis1YjhvVGNSQ01K?=
 =?utf-8?B?K21ENzQ5K3gxNFdHNjBJMCsxUUxBL1FmYXdkam1tbVFqWFNuN1pRYXRwMlVU?=
 =?utf-8?B?QjUyT2VjNjUzdzlRcno3ZElvYmZmZHh2R05NdkRsMVZwL2dPc1dGemtIbjFG?=
 =?utf-8?B?NWJnVC9Halg1WVFvWDBaZ1Q1SGVvVWVERTJ0bW9aTDRyVnI4QnRJMDFoZUty?=
 =?utf-8?B?V3ltU2FPWmQ0U2NTRm1WK0x1M0dlQzI5ZGhSSERicVYvYzBjM1gwTERwQ3Bx?=
 =?utf-8?B?RzU1cTZrMjRSdnJYNEpNc0xZazNTcTM5UVZ4ZWVtNTU0MFFZVC9yNDd1dW9Y?=
 =?utf-8?B?L3ZoM2JpYnk3K1V4U1hONnlPYzFDSG9GaU9kaTdtUllYaU5PQ0dWNXVsbWNy?=
 =?utf-8?B?YTd1K3V4bmtkdVNtQ2s5dnlsRGEvUFM3c3NCM1VZdnVFL25rQjdHd3g5VVQ1?=
 =?utf-8?B?TkU1RVdTcXJwZXZOajhNeGdsRTJtTTkrcWJ1M3BZbzN2Mi85NlFzUnVkVUF0?=
 =?utf-8?B?YnBGeWQrQ3dzL0J0dVNOQzBacDRabXh3UDJzTUQ4dkdNZXBvQ21BTTUvZGNB?=
 =?utf-8?B?YkR0TXpPR2tSOHpieE0yTlpOSElneURPMFBreWU5VE55aDcvaTFEbnh5d3ZS?=
 =?utf-8?B?K3I2cHhDeHI5WE9rQjdPNGcrdG1sS3dmS2xGaThVSzd1d2VZV2R3U0JNUXdi?=
 =?utf-8?B?MktrdFRlRFdjVEdFUTlnRlFhZFROcWo1SS8zcWlVaFlkNEo5NVQ2eXlzYjNK?=
 =?utf-8?B?U3FXU2RCUE5xd254b1lSUVpPMll0MXlHVU9wMTJKa2lYVE51dC9Jc29NNkVt?=
 =?utf-8?B?ZmtUdjU2alJSRGxEMzBXcnI3MmZHMmduUWs0SEdyTE9DdEtPVUpueVZxdGtE?=
 =?utf-8?B?VVNPbjQ1WC9PZy9RTkJCa2Z2RUZkTjZMRDlUaEpUMGVBb1NvMlhwcnV4K24z?=
 =?utf-8?B?QlJER0JHcmdOc2dqZXl5NlFkcXcrNS9VSWdCT3BlUlJVaGpQTG13VlIrSkhD?=
 =?utf-8?B?T0dxMUJRcTdMdDR0TnE5ajhQQzA1OFNXZWhZRnJUd0F5a3MxamFQNUZXZEpp?=
 =?utf-8?B?djVQODUxbjBoM29MWktJUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1f4984-6ce6-471b-6845-08d972fc5f34
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 19:10:50.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cu/+lOxYuf8gWCYoHrje/zlIoxptf0v7hn5xJBpuzIVUneuA5kIV3/iq89HBkTS7+Xl81+soOUOtOgSjnDVsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4371
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GhZHxNJWAYnu822WP_0XmyysHCS2kpKl
X-Proofpoint-ORIG-GUID: GhZHxNJWAYnu822WP_0XmyysHCS2kpKl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/3/21 10:22 AM, John Fastabend wrote:

> Joanne Koong wrote:
>> On 9/1/21 10:11 PM, John Fastabend wrote:
>>
>>> Andrii Nakryiko wrote:
>>>> On Tue, Aug 31, 2021 at 3:51 PM Joanne Koong <joannekoong@fb.com> wrote:
>>>>> Bloom filters are a space-efficient probabilistic data structure
>>>>> used to quickly test whether an element exists in a set.
>>>>> In a bloom filter, false positives are possible whereas false
>>>>> negatives are not.
>>>>>
>>>>> This patch adds a bloom filter map for bpf programs.
>>>>> The bloom filter map supports peek (determining whether an element
>>>>> is present in the map) and push (adding an element to the map)
>>>>> operations.These operations are exposed to userspace applications
>>>>> through the already existing syscalls in the following way:
>>>>>
>>>>> BPF_MAP_LOOKUP_ELEM -> peek
>>>>> BPF_MAP_UPDATE_ELEM -> push
>>>>>
>>>>> The bloom filter map does not have keys, only values. In light of
>>>>> this, the bloom filter map's API matches that of queue stack maps:
>>>>> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
>>>>> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
>>>>> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
>>>>> APIs to query or add an element to the bloom filter map. When the
>>>>> bloom filter map is created, it must be created with a key_size of 0.
>>>>>
>>>>> For updates, the user will pass in the element to add to the map
>>>>> as the value, wih a NULL key. For lookups, the user will pass in the
>>>>> element to query in the map as the value. In the verifier layer, this
>>>>> requires us to modify the argument type of a bloom filter's
>>>>> BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
>>>>> the syscall layer, we need to copy over the user value so that in
>>>>> bpf_map_peek_elem, we know which specific value to query.
>>>>>
>>>>> The maximum number of entries in the bloom filter is not enforced; if
>>>>> the user wishes to insert more entries into the bloom filter than they
>>>>> specified as the max entries size of the bloom filter, that is permitted
>>>>> but the performance of their bloom filter will have a higher false
>>>>> positive rate.
>>>>>
>>>>> The number of hashes to use for the bloom filter is configurable from
>>>>> userspace. The benchmarks later in this patchset can help compare the
>>>>> performances of different number of hashes on different entry
>>>>> sizes. In general, using more hashes decreases the speed of a lookup,
>>>>> but increases the false positive rate of an element being detected in the
>>>>> bloom filter.
>>>>>
>>>>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> [...]
>
>>>>> +static struct bpf_map *bloom_filter_map_alloc(union bpf_attr *attr)
>>>>> +{
>>>>> +       int numa_node = bpf_map_attr_numa_node(attr);
>>>>> +       u32 nr_bits, bit_array_bytes, bit_array_mask;
>>>>> +       struct bpf_bloom_filter *bloom_filter;
>>>>> +
>>>>> +       if (!bpf_capable())
>>>>> +               return ERR_PTR(-EPERM);
>>>>> +
>>>>> +       if (attr->key_size != 0 || attr->value_size == 0 || attr->max_entries == 0 ||
>>>>> +           attr->nr_hashes == 0 || attr->map_flags & ~BLOOM_FILTER_CREATE_FLAG_MASK ||
>>>>> +           !bpf_map_flags_access_ok(attr->map_flags))
>>>>> +               return ERR_PTR(-EINVAL);
>>>>> +
>>>>> +       /* For the bloom filter, the optimal bit array size that minimizes the
>>>>> +        * false positive probability is n * k / ln(2) where n is the number of
>>>>> +        * expected entries in the bloom filter and k is the number of hash
>>>>> +        * functions. We use 7 / 5 to approximate 1 / ln(2).
>>>>> +        *
>>>>> +        * We round this up to the nearest power of two to enable more efficient
>>>>> +        * hashing using bitmasks. The bitmask will be the bit array size - 1.
>>>>> +        *
>>>>> +        * If this overflows a u32, the bit array size will have 2^32 (4
>>>>> +        * GB) bits.
>>> Would it be better to return E2BIG or EINVAL here? Speculating a bit, but if I was
>>> a user I might want to know that the number of bits I pushed down is not the actual
>>> number?
>> I think if we return E2BIG or EINVAL here, this will fail to create the
>> bloom filter map
>> if the max_entries exceeds some limit (~3 billion, according to my math)
>> whereas
>> automatically setting the bit array size to 2^32 if the max_entries is
>> extraordinarily large will still allow the user to create and use a
>> bloom filter (albeit
>> one with a higher false positive rate).
> It doesn't matter much to me, but I think if a user request 3+billion max entries
> its ok to return E2BIG and then they can use a lower limit and know the
> false positive rate is going to go up.
>
>>> Another thought, would it be simpler to let user do this calculation and just let
>>> max_elements be number of bits they want? Then we could have examples with the
>>> above comment. Just a thought...
>> I like Martin's idea of keeping the max_entries meaning consistent
>> across all map types.
>> I think that makes the interface clearer for users.
> I'm convinced as well, lets keep it consistent. Thanks.
>
> [...]
>
>>>> Also, I wonder if ditching spinlock in favor of atomic bit set
>>>> operation would improve performance in typical scenarios. Seems like
>>>> set_bit() is an atomic operation, so it should be easy to test. Do you
>>>> mind running benchmarks with spinlock and with set_bit()?
>>> With the jhash pulled out of lock, I think it might be noticable. Curious
>>> to see.
>> Awesome, I will test this out and report back!
> It looks like the benchmark tests were done with value size of __u64 should
> we do larger entry? I guess (you tell me?) if this is used from XDP for
> DDOS you would use a flow tuple and with IPv6 this could be
> {dstIp, srcIp, sport, dport, proto} with roughly 44B.

Great suggestion. Alexei mentioned this as well in his earlier reply. I 
am planning to run benchmarks on
the v2 version using value sizes of 4, 8, 16, and 40 bytes.

>>>>> +       for (i = 0; i < bloom_filter->map.nr_hashes; i++) {
>>>>> +               hash = jhash(value, map->value_size, bloom_filter->hash_seed + i) &
>>>>> +                       bloom_filter->bit_array_mask;
>>>>> +               bitmap_set(bloom_filter->bit_array, hash, 1);
>>>>> +       }
>>>>> +
>>>>> +       spin_unlock_irqrestore(&bloom_filter->spinlock, spinlock_flags);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>> [...]
