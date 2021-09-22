Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A61415054
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 21:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhIVTHk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 15:07:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2076 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236840AbhIVTHk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 15:07:40 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MIlTkN001023;
        Wed, 22 Sep 2021 12:06:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qy/X/bekj1cuUKcS5TM9pteo2wNNd0q6C+CLf4Gx+8A=;
 b=WOpsPftbqdNHUzcE1E11P/wbnyGOxxFgz+Hz+8AWMPlCHUOneug+Hk2nHmhLCY3j8Mml
 UOlWl20+rehNLJ04iHdnqyndxyTSRlOPv9gUnW3Bfo00AxQOrl5agvRIMhzL6GxnjTfB
 /k/RGyIG7EoWk1xuN7kkCGA2PTz7rCNaAks= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q54fdw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Sep 2021 12:06:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 12:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH9Bys0n3iNMcqPhwHXNYWJdR1l4RONvtUn64aIyen3c7uYcwerOpwKTMDWnyGE7dT/L/w+xYA/s9NGJZPjAYsdrWY8dgtSK5VvtMrZdjQStUjgADEQhx+ASJi1B4DS5rM/s8fkjB5fLTy2je8pG40O4gw9NwyT+gvPaQrpzxBvgWM0nN6oFgG+51VKU8YQVAKDXuhU/cR8amNRx+oTq9g1ooSMYU97V6OtNqY1Rl+7gcYNg+lL1LNvCLOolVXuzUIQX9TRJQ1PzQnQ884zcc780ausI3rRqO/4lO+MY/bP9roniHq/jUXYNw+hq/eJz3oApMaMM404+duCgo7MHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qy/X/bekj1cuUKcS5TM9pteo2wNNd0q6C+CLf4Gx+8A=;
 b=Qv0+HG2TjsnW2H89L7+53lpgAiUvbNKvxCKYKaywG0mWD9Fk0vRXWRlnZFPhV9fkGSYWZyryc7giUmxgXjKY84AbOQG7mh7ImzgH/inGGDJwK+8rYy1RfC70kHny5NhZ83CJhNHCBy5+5p2sCL5sSyL0rvl4zUs+xF/TQ5liKkYXQqGA8AOlPOZu2fVL4++fhDphymlVtUYRkMPYA36L6AmO3ANXZEhj+iU4EAeHSN0UZkKRx0Hkn9bA9+CAy5borv2VlOeHONsyh84/DwS70eFBKQI17/OfoNKaKtk9K1AF/8jnyv+Q3F0dQP4IXoV1LustbbYCatP61t8OvOsP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN7PR15MB4208.namprd15.prod.outlook.com (2603:10b6:806:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Wed, 22 Sep
 2021 19:06:05 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe%9]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 19:06:05 +0000
Message-ID: <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
Date:   Wed, 22 Sep 2021 12:06:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
References: <20210921210225.4095056-1-joannekoong@fb.com>
 <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0038.namprd15.prod.outlook.com
 (2603:10b6:208:237::7) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11e8::182d] (2620:10d:c091:480::1:6fe1) by MN2PR15CA0038.namprd15.prod.outlook.com (2603:10b6:208:237::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 19:06:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b3ed4c0-a54f-4db3-a73a-08d97dfc06e8
X-MS-TrafficTypeDiagnostic: SN7PR15MB4208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB4208D1E81CB4B0524F7B9D5FD2A29@SN7PR15MB4208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9IUjT1SEXCPfjMWn2gcjDKyxmt7T2DFeNa/+QNXtjZHQrt8Hi+kjcPAQmS7r0xLN/3farQofAIe+hjX9WEMN0JSc7XQdtxyQ+G5G+WAHW1Krt7/N4DvkhtcS1D3rzG4BB9AIw/esjF4tSAPRPCUwwECIBh8LmteKIoDdwPNoGxA4yvrDbC7EEyntzbT4tt/nb0dSeJGIZsyv3CZRmwxe5916jWajL2j81luJYAv+5bLbHJIQ+E5xTNRr8yoH4GTzlJmQXlng9ERwP4mBK9sBGn7NucCNOUmKT4RMxG24VjYQPmGvV/VQ4zvFC2LbV9dCFZRud8jQRQCclYcjrg1tkuIYeC6AWcQ0PZ3MZoz40HH/5JgnSg1g4OkPQ6T0IUTMTlW0LBePxk57aoRMSnoxw2CC14z9qcYu4PXPOhhjt3U+vlCorQA1+Vmof432CTgICaFwmP55K3LZOZGa8osXU3Bk3PDedQJT8XoJlyOOAJWODMATrwAsvoP8wGim30FVKVTw9rv8t+XciHC4VYMavRNpm9No08ihIXaaUfQU7AT0qjVB3zTDQBx9aceuu4rU/u1HNhVTjDKojwsYgfb4egECYtkiDCeim6olKk7wLq60Y+KJYRXb5OtXpRAr9VlRKjuM0YksI0jwE27Tm7yst378v8deIfM+Yya4lFgXzP45l1xgUakADDJZf2SmQChFsKBuvepxmXegX130zssmGGzN4fdh9zuWCB5rCZlc84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(66946007)(66556008)(66476007)(38100700002)(4326008)(8676002)(8936002)(31696002)(2906002)(31686004)(6486002)(2616005)(86362001)(5660300002)(508600001)(6916009)(36756003)(83380400001)(316002)(54906003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZERhZVBrYzl2RlV3bDluL2RzT0xiVFNHcTJCR2lYeDBVaHFkeTZOMmRyMXMr?=
 =?utf-8?B?cnE3VkhoNlhqblBObkY3UU01c2JTd2dQYVl1RWRpWGkydHBoNk11VXEzMXRM?=
 =?utf-8?B?UnNINDRwRis2TkNMdkhITHdua3hKT2VCcXVpTjk0TEVBdG5NdGpzSmE0VXh5?=
 =?utf-8?B?WWZDc1ZBL3pGcnk4THhGUXhKTTA2R0F5U2RJdG1sZUYwVlhwUmduK05NTm5F?=
 =?utf-8?B?a2wyM21iME5vYXM2RDV0Z1JFYmMzZTZVVEFIKzJvSngxZWk3ZEZCM0RGWVhO?=
 =?utf-8?B?cjJOcWlpUFJDM2JuTng5MUw0amMrMHRrU0U2WjVxNEdKOGdPazUzanZSZjJN?=
 =?utf-8?B?bHcxa1E3NGF1cktVdVlmSFBDejF0bjNzZzMxMjRUbjIxWnZlUXdJaTlTTldL?=
 =?utf-8?B?SnUwRGJkazVXYjZGdDN3ZU1qUXI5MFNyM25tQjBqbkFPcnRSZ0RPeXlFVHBq?=
 =?utf-8?B?cm1na2xDVlVGQlBuRzdmZmlmdGh2S1d0L0d1dmZLcHl1aUJFdzFFR3laZTJ6?=
 =?utf-8?B?Y2ZBTGtpbWpiOHZMV01NZElIay9nYXlaeG85NEpicmZ4OXJtSXM3b2F6WlI3?=
 =?utf-8?B?QzZ1YTRiQzFwVURLZ1ZIdTVLY2x3OHkwRFNJRHdpK2RqYXJMa3EzYllBWkVk?=
 =?utf-8?B?SFZ6UVFUZHUrcjdLdnNCK2VGTUdOSnB6NG9hNWJhTmVuK1BMb2dRUzh5d3Vh?=
 =?utf-8?B?Y0dWTGl5Z2VMTTJYYkk4bzZKWWx3S2xvdEhjYm1kRzlHNWJIdC8yVXFwd0tX?=
 =?utf-8?B?V014VTA5S3BQMjdzRTZnRzZWRTdLVFkvay9YSXc2VkZUNjc5UEovMkEwRnc3?=
 =?utf-8?B?bkJqblNrRTR4emRpRzVCbEdRNUs4bnRrS2N4V3NHVlBiSk0yNTVUdW9mZTUy?=
 =?utf-8?B?c1NZL2xJbzNoWThGZ2tZOGJhS0pqcjZlU2k0MCtvSTZSK0FUVTY1bXRHWjJT?=
 =?utf-8?B?QkF1MmNCazlUYm1lWnZ5eTdCdjgzY0o4aFBZbTdXZmV5NXlvVlNSTU01Q3Qz?=
 =?utf-8?B?SVdtNjNlYTBnbmdCS0RTTDc2bWJTNDRSL2pBVHh4TTBlRmJwNmV5Wm5hMGhn?=
 =?utf-8?B?OEs5S25nUjdodlZXcitGT3NHZ081dXo1VlJ6RzRUbjJROTVYTE5RVDdpN3M4?=
 =?utf-8?B?Y0hMaGpqdngyL0g2N2NEZ3YrcytmRm5ra0pZVkhjOExDcStqY1dQeHJpZ2Vt?=
 =?utf-8?B?REM5MEY4NEwrSFJpWk0xZE1icFk1NWZDcGJMWngzTS9MTjc5UkZDREpkWkpz?=
 =?utf-8?B?K0I3WVU2cUxlOXFpTFdpZ2thVkRDaG52OGlWTXV2RDEvQ2NnbUo4eUE2ZTR5?=
 =?utf-8?B?VEJhNVpWK1FpVzdsMjNQZ2xRNEtKMTJJbHQ3YnQyNjRFY0NROGxwYXdxUmk4?=
 =?utf-8?B?cW43aFV4dFNTSUo1T1pjRGwrZHF6WEQydms1RzFMUitNUW1lSElMRzV5ZS9n?=
 =?utf-8?B?dkVjRU5iK3BBVVJ1SHdkaTdYMm0zeW1Ra0ZmWS9hZER6cGh4UkZzNFJFLzI2?=
 =?utf-8?B?bEFFczZNYm0yeDZ4WDM4RGM1WmpFWlBKeU5HMHVVVm5FUEc1VS9qSHJqV28y?=
 =?utf-8?B?aDltK3hXYlVFS0xVYlFDeVdkZjFZQmZKczN3WjNVZlF1MUo3Q0JKakRDMVc5?=
 =?utf-8?B?M1VLR1pXNFg2czJuR1lqaElvZmRqWWgrQnFRR1pXSmZIS0NRT1JaL0cvdVBo?=
 =?utf-8?B?OGJ0MTJISnpqUzBXdENhdGdEcTl1RkRyV0x0cm1XRTZZZ1lCaDNzNVlMaWZm?=
 =?utf-8?B?cnI2K0JkQURzaEFSbXpNMVkrNUNFZ1NOaXVMRDEyaUhyRExNdWV6ZkZHWlZt?=
 =?utf-8?B?OVNxWUh2WG0zaWlsWmZ3Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3ed4c0-a54f-4db3-a73a-08d97dfc06e8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 19:06:05.2936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPvdA62lIoJstDn+VEEO+8Ssav5J0UKTyTqHsBpkq5fERve3Wp3aYAuRjGktYTONgLbVqRw2S9OY4NXbgq574A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4208
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: IAcOPei8UP67ZPmkKOkDKr3bqyf6mLT5
X-Proofpoint-GUID: IAcOPei8UP67ZPmkKOkDKr3bqyf6mLT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_07,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 9/21/21 4:44 PM, Andrii Nakryiko wrote:
> On Tue, Sep 21, 2021 at 2:30 PM Joanne Koong <joannekoong@fb.com> wrote:
>> Bloom filters are a space-efficient probabilistic data structure
>> used to quickly test whether an element exists in a set.
>> In a bloom filter, false positives are possible whereas false
>> negatives should never be.
>>
>> This patch adds a bloom filter map for bpf programs.
>> The bloom filter map supports peek (determining whether an element
>> is present in the map) and push (adding an element to the map)
>> operations.These operations are exposed to userspace applications
>> through the already existing syscalls in the following way:
>>
>> BPF_MAP_LOOKUP_ELEM -> peek
>> BPF_MAP_UPDATE_ELEM -> push
>>
>> The bloom filter map does not have keys, only values. In light of
>> this, the bloom filter map's API matches that of queue stack maps:
>> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
>> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
>> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
>> APIs to query or add an element to the bloom filter map. When the
>> bloom filter map is created, it must be created with a key_size of 0.
>>
>> For updates, the user will pass in the element to add to the map
>> as the value, with a NULL key. For lookups, the user will pass in the
>> element to query in the map as the value. In the verifier layer, this
>> requires us to modify the argument type of a bloom filter's
>> BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
>> the syscall layer, we need to copy over the user value so that in
>> bpf_map_peek_elem, we know which specific value to query.
>>
>> A few things to please take note of:
>>   * If there are any concurrent lookups + updates, the user is
>> responsible for synchronizing this to ensure no false negative lookups
>> occur.
>>   * The number of hashes to use for the bloom filter is configurable from
>> userspace. If no number is specified, the default used will be 5 hash
>> functions. The benchmarks later in this patchset can help compare the
>> performance of using different number of hashes on different entry
>> sizes. In general, using more hashes decreases the speed of a lookup,
>> but increases the false positive rate of an element being detected in the
>> bloom filter.
>>   * Deleting an element in the bloom filter map is not supported.
>>   * The bloom filter map may be used as an inner map.
>>   * The "max_entries" size that is specified at map creation time is used to
>> approximate a reasonable bitmap size for the bloom filter, and is not
>> otherwise strictly enforced. If the user wishes to insert more entries into
>> the bloom filter than "max_entries", they may do so but they should be
>> aware that this may lead to a higher false positive rate.
>>
>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>> ---
>>   include/linux/bpf_types.h      |   1 +
>>   include/uapi/linux/bpf.h       |   1 +
>>   kernel/bpf/Makefile            |   2 +-
>>   kernel/bpf/bloom_filter.c      | 185 +++++++++++++++++++++++++++++++++
>>   kernel/bpf/syscall.c           |  14 ++-
>>   kernel/bpf/verifier.c          |  19 +++-
>>   tools/include/uapi/linux/bpf.h |   1 +
>>   7 files changed, 217 insertions(+), 6 deletions(-)
>>   create mode 100644 kernel/bpf/bloom_filter.c
>>
> See some stylistic nitpicking below (and not a nitpicking about BTF).
>
> But I just wanted to say that I'm a bit amazed by how much special
> casing this BLOOM_FILTER map requires in syscall.c and verifier.c. I
> still believe that starting with a BPF helper for hashing would be a
> better approach, but oh well.
>
> [...]
I liked your comment on v1 regarding using a BPF helper and I agree with 
the benefits
you outlined. I'm curious to see what the performance differences 
between that approach
and this one end up being, if any. I plan to test out the BPF helper 
approach in a few weeks,
and if the performance is comparable or better, I am definitely open to 
reverting this code
and just going with the BPF helper approach :)
>> +
>> +static inline u32 hash(struct bpf_bloom_filter *bloom_filter, void *value,
>> +                      u64 value_size, u32 index)
>> +{
>> +       if (bloom_filter->aligned_u32_count)
>> +               return jhash2(value, bloom_filter->aligned_u32_count,
>> +                             bloom_filter->hash_seed + index) &
>> +                       bloom_filter->bit_array_mask;
>> +
>> +       return jhash(value, value_size, bloom_filter->hash_seed + index) &
>> +               bloom_filter->bit_array_mask;
> stylistic nit, but this feels way to dense text-wise, this seems
> easier to follow
>
> u32 h;
>
> if (bloom_filter->aligned_u32_count)
>      h = jhash2(...);
> else
>      h = jhash(...);
> return h & bloom_filter->bit_array_mask;
>
> WDYT?
I think this sounds great! I will make these changes for v4.
>> +}
>> +
>> +static int bloom_filter_map_peek_elem(struct bpf_map *map, void *value)
>> +{
>> +       struct bpf_bloom_filter *bloom_filter =
>> +               container_of(map, struct bpf_bloom_filter, map);
>> +       u32 i;
>> +
>> +       for (i = 0; i < bloom_filter->nr_hash_funcs; i++) {
>> +               if (!test_bit(hash(bloom_filter, value, map->value_size, i),
>> +                             bloom_filter->bit_array))
>> +                       return -ENOENT;
> same here, I think the hash calculation deserves a separate statement
> and a local variable
>
>> +       }
>> +
>> +       return 0;
>> +}
>> +
> [...]
>
>> +static void bloom_filter_map_free(struct bpf_map *map)
>> +{
>> +       struct bpf_bloom_filter *bloom_filter =
>> +               container_of(map, struct bpf_bloom_filter, map);
>> +
>> +       bpf_map_area_free(bloom_filter);
>> +}
>> +
>> +static int bloom_filter_map_push_elem(struct bpf_map *map, void *value,
>> +                                     u64 flags)
>> +{
>> +       struct bpf_bloom_filter *bloom_filter =
>> +               container_of(map, struct bpf_bloom_filter, map);
>> +       u32 i;
>> +
>> +       if (flags != BPF_ANY)
>> +               return -EINVAL;
>> +
>> +       for (i = 0; i < bloom_filter->nr_hash_funcs; i++)
>> +               set_bit(hash(bloom_filter, value, map->value_size, i),
>> +                       bloom_filter->bit_array);
> same as above about hash() call on separate line
>
>> +
>> +       return 0;
>> +}
>> +
>> +static void *bloom_filter_map_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +       /* The eBPF program should use map_peek_elem instead */
>> +       return ERR_PTR(-EINVAL);
>> +}
>> +
>> +static int bloom_filter_map_update_elem(struct bpf_map *map, void *key,
>> +                                       void *value, u64 flags)
>> +{
>> +       /* The eBPF program should use map_push_elem instead */
>> +       return -EINVAL;
>> +}
>> +
>> +static int bloom_filter_map_delete_elem(struct bpf_map *map, void *key)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>> +
>> +static int bloom_filter_map_get_next_key(struct bpf_map *map, void *key,
>> +                                        void *next_key)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>> +
>> +static int bloom_filter_map_btf_id;
>> +const struct bpf_map_ops bloom_filter_map_ops = {
>> +       .map_meta_equal = bpf_map_meta_equal,
>> +       .map_alloc = bloom_filter_map_alloc,
>> +       .map_free = bloom_filter_map_free,
>> +       .map_push_elem = bloom_filter_map_push_elem,
>> +       .map_peek_elem = bloom_filter_map_peek_elem,
>> +       .map_lookup_elem = bloom_filter_map_lookup_elem,
>> +       .map_update_elem = bloom_filter_map_update_elem,
>> +       .map_delete_elem = bloom_filter_map_delete_elem,
>> +       .map_get_next_key = bloom_filter_map_get_next_key,
>> +       .map_check_btf = map_check_no_btf,
> can you please implement basically a no-op callback here to allow
> specifying btf_value_id, there is no good reason to restrict this new
> map to not allow BTF type being specified for its value
Sounds great, will add this in v4.
>> +       .map_btf_name = "bpf_bloom_filter",
>> +       .map_btf_id = &bloom_filter_map_btf_id,
>> +};
> [...]
