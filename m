Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0762412919
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 00:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhITW4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 18:56:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231495AbhITWyX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 18:54:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwNvk014546;
        Mon, 20 Sep 2021 15:52:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=p91luPlakZajEm5caCqgTyHKBLSb/KPHa8LPCeaH72M=;
 b=a4NKUEwKXx7K7KpWxA9WXmnpCArfx2oSq/HiV2gCZbsbIQrUzeQsN/9sSsvBZMsq1+bf
 jqw8W7or91PTb5Bja+T/nYyCDTwKiv5LUgA2vu+Aj4H1hWTuCCL+qgUsfzI0pUZQ4fqt
 mHFk5xr9ACOUTQHGjMzk1YBoRhAgOclJYxs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6f2rekng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Sep 2021 15:52:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 15:52:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6wgdu3zn3nOrRC6yVAz28e8IgXDwhRRTu4FWl+w9Gjf2e0qENuP4OtI8hi6tY1s079SrY5IjhtBRKVIi/JdsiPftvodEJsQB1BT644UpMIIrbnt1kVVbCSkrPNCW9IeDQesUcKTPXWe0KT6nO9iyjYoW4MZqTqDq6YkWCphtRlHEKH1q/mu14S2uk3JMU8bS34YGTv6ygM3hV5oMijsA5JYuqxuyPFSQ9LS9hZJnpcQaFEyUkKgudODTLuuL1tjO1D9rDiXbu2COOP/+PwwbLha0vqyXzb1KyYTaRu+dsMw3snrUUyTpDD5qmzXXLt9g4H5x62NSCV4SHdpZtqLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=p91luPlakZajEm5caCqgTyHKBLSb/KPHa8LPCeaH72M=;
 b=UMRYyrBFgwJNKztnlEx6g0ijGItSFifSO7/Cy8xsm9olUUVdZEPHrhvYX3NCIeEb+Xtq4Eg1ls0wPw1YPqCWUPyQP8FAHFI7jMnOdRcKEF2kdQv+xGzTpJVwH6LEJna/Notv8Yuslq6GWuTZ6rw5DZVW3btAheioCmIlvvs3Y2hIPuE6aANs1K5pExReYtDXYOHU4mHTZbrNsQ/rOBLpJ02mnI0A0jlNkH69Xclsg97C5ZWOdUvUeYaePRnwH2dGXsaR+KoLOFRQqAmISejwqgDtc/X0lehHhfRA31fuO+s8z1EUDQ32AslyOmxhMtuNfw5sxh7O0owebSZ9O+LXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB5015.namprd15.prod.outlook.com (2603:10b6:806:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 22:52:53 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe%9]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 22:52:53 +0000
Message-ID: <17d7b319-01d0-163e-57b6-c385d38cc9ad@fb.com>
Date:   Mon, 20 Sep 2021 15:52:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.0
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
References: <20210914040433.3184308-1-joannekoong@fb.com>
 <20210914040433.3184308-2-joannekoong@fb.com>
 <20210917170130.njmm3dm65ftd76vo@ast-mbp>
 <CAEf4BzaA2QCmcc0nZqNbAqMdabqhjE5X_Nh59QjP8kd=iGH5GA@mail.gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAEf4BzaA2QCmcc0nZqNbAqMdabqhjE5X_Nh59QjP8kd=iGH5GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:a03:60::14) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::1889] (2620:10d:c090:400::5:99c2) by BYAPR07CA0037.namprd07.prod.outlook.com (2603:10b6:a03:60::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 22:52:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d505111-f820-4a19-600f-08d97c8960fa
X-MS-TrafficTypeDiagnostic: SA1PR15MB5015:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB50150B111FF5E8FF66AFDE93D2A09@SA1PR15MB5015.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7BOmodgAH+afCETy718y6pvQLncsrOdDp0V8VcxiuDPN82y+zFxMKcOE/wdaVuK2ZEPVsGov0IWtZiou1TmPf6ZZIBfXPSivRWYzejxE6HInaTUfiEL1mw7fLpDA8RXcnDb5dYabKh/0TAicNpteF3CLl7SEBFeDeOTvy4mHyuuGaBaz8+Cg0fGQA+NUynv/9F+BM+wWbcHRCCCR6v45lINgcilBTspmILbINnqPZ4/lZL6sdCTyvDls4G67GGV/0VPb9HoOXWNPwMOv5przVsBaSJYusWk5HjGEj3T1GtbVYE83qS4LcMvzgX45/omXqrc1qgMGbURB7m5goac1Z8QCNCH5UyjXzVOn6UY8UgqqwNiD1mdo5jjARa5dKBJaYsuz9laWfyIFYn4X3zKCiLv4km0WC7MJVlj/c9nZqSGNVGsNTToZ+3cQeybqqHlg/d/dLYf2Zjpn0yt249RjcT7yu6vmHaXOGH9fGzxaIwykqhxshowGi1Clcq0p9cbuHJwULAA6NZ54WgfIAV4TJ151Y2FBRQv6KkeaegbQJlOvau2uT/1O/OA3Pd2BFbVHe62hslud8r/So3v37sGoZq5AFUj4YgDLUJLwIs7NwTMRVXmRe8EsXsXpxpIBzaI2HEDUWtC8HFGchABVClmk4rYJq029+w+szgCHX2Mqj1AhyrX/Zh3f04P86sj+nz56veAdq4bcASFWscfYQWJm7OnCwe+32wfoKbBKria+pg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(31686004)(6486002)(31696002)(2906002)(83380400001)(186003)(36756003)(2616005)(110136005)(5660300002)(66946007)(4326008)(316002)(8676002)(86362001)(66556008)(66476007)(54906003)(8936002)(38100700002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktvTGdBdmtuelovUDI1N0U4NWZrV1p1eGtNdkxuL0orUldkZU8vZGt6ZWRu?=
 =?utf-8?B?ZVdtVVBEVlRmMWIvNWszK3JVRXd1eTcyYmZyQWVuR1Ftb1NrT0s4anduUHJ0?=
 =?utf-8?B?QmFFKzJLOW55SW1uYlg2R1VSSlFaTTc3OSsvbkJVTnNFM3ZYUWZuazU5U1ZS?=
 =?utf-8?B?VnhKQ0JQZHY1K2QrSkF2cmhFT1BhSlN1VGVlWjFTcFJuRTMvRmRxQkhaNE9K?=
 =?utf-8?B?aVkrZFQzTkZWUm54SGFHREhJeENLblF5djM2Rmx1RktnZ3Y1RWhVUE1rR3Fr?=
 =?utf-8?B?NDNXWk5neFp4cHMydFF5VGR5V01XRHlZSlhOQzN5bUErTnZYT1ltdjk2aXlq?=
 =?utf-8?B?eE1FS0J1WFhHQlVjQzBwckxyclVQb0MrY2RKdUR4ZHpBQnQ1MXBzZ3FpMW53?=
 =?utf-8?B?cSs3RzNGRG1VMGRPK1MvT0ZuRXdPYUR3cnF0T0xIQUpaTzViUEFhWC9wY3Rv?=
 =?utf-8?B?RENKeEJGWk9BNVIxY3YxUmlXYU5BS3ZMUDNEa09YWnZwWTFwTHY5eDNmK2hP?=
 =?utf-8?B?Rm1lWndkRUUzTGdRU21kZEwvaVhOTFVaM0k4TXhwMHB4SlVKTis5YmpLSVFp?=
 =?utf-8?B?S0M5Z2pKd1krOHF4NHVpNkU1dVZqdnVXQTNHMlovOXh4S1VHL0h6ckRRNjhh?=
 =?utf-8?B?cllma0dkUFRYQnVKcUdlY2VKci9xcFNERjg2RmEzRHU5NkJEdE8zNXZrUEU4?=
 =?utf-8?B?L251d2djdmUvNlJIR2MzMTZkSTJ1bFR0b3BINzh1dG93dEpQVHpseUdLUkNP?=
 =?utf-8?B?VEM4L0NkcmJxdFlKWFJVdkNyZmtoYXRwM3RaZEZvZEZOZ3B4RHBUcnhSUzlH?=
 =?utf-8?B?cm9wMkdxVVlJNGprZVYzaW9sbXZpbkN6VTJlUXNNbEdISnRFL1I5UU43MXNt?=
 =?utf-8?B?Z1RMZ3NiRTkwS3cwbnhzcitDRll0bjlkbkZjQVgwMTZMaHJGa2loSXNlUFFB?=
 =?utf-8?B?SElnOFI3dVdlTGRrQ09jaEJMdUU2dmxyQ1Rldk9nNTJ5eE9hWXB6QXVhSkJs?=
 =?utf-8?B?b1BMclI2dnRrQTNaSjJQazBlR3RxeVRMMlpybmJTZTQvNDNzTGlqU1Z3d0Rw?=
 =?utf-8?B?cTB2ak52a2lwckZtYjZKb3NtWGR2NTlXa0g1YjNMdzkza2s3RzlYRnVJOVkr?=
 =?utf-8?B?cXdiZy9ZeTk2VlphZDNUdStRNTM4N1hwcWk1eCtwM2FzSm05VDlkZktjNjE4?=
 =?utf-8?B?bHc2QWNoVGUrQW1vd0h5emxxTHg4bjJTZVU0cUdQVi9LY00yd0lGNlIwM2Mz?=
 =?utf-8?B?OTYyU0RjODhJSzdlaTJBR0JzMy9OQmYvTFdNa1lLVDRQWC8vNGVEeVQzNXo2?=
 =?utf-8?B?ZlVzekFOa1BMK0RFQmRXeGphVk1mRFlUNmpPVUVzRUFZVHpCd3RYNUNYYWhV?=
 =?utf-8?B?cm5RcE1HQ3RNR2dvNDVPTldNeWQwVnJ6UHJvWllrazNHYllKbUhlRGVBaWJx?=
 =?utf-8?B?aVdnd0lmRGh0NjcxcGREUDJKNU9wOUhMVzdkekY2bGxJSFpoNHFLby80QVRX?=
 =?utf-8?B?cnZtSlk3NVBXOFVLOFh4SHlyVEpRc3hwUkdxdjR5czVVNUpUeHpmVVBpRDdz?=
 =?utf-8?B?ZUprTXZady9NTkVGK0ZHekZicEk3azBoSldKakRBS2pkQW1rUjBrWXFxZHBk?=
 =?utf-8?B?eWRlTUh5WjdMT0hEYmdySDdQQ3FHY0lPWHFMKzFmbFB0a1YwWFN2YklCK3Bm?=
 =?utf-8?B?WGU0ZmNYdEFCL29BSXZZa1JGTEFzTDBBUEJsZFkvRlVxcUNLdVFoOVJtaHdI?=
 =?utf-8?B?QVlFYkdJRnZuQWFBanhyZEU4cFpWNW1kbTBYc1lUR09walBHY2dBQnVFNUxr?=
 =?utf-8?B?Tk1IdExsU2FoMTBsVzdaQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d505111-f820-4a19-600f-08d97c8960fa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 22:52:53.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KK/3nqdFzsnQMqZGsUk/AGZdz1PNto+add4vPaHnFk1TliksLrx9npTQEuYVavVUFZAJ6crhSofLsao6Ekt6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5015
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: oXRuZh9lA5zxZhTHSB9soKRafLml9K3j
X-Proofpoint-GUID: oXRuZh9lA5zxZhTHSB9soKRafLml9K3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My previous email replied to Alexei's email before I saw Andrii's new 
email, so please
feel free to disregard my previous email.

On 9/20/21 1:58 PM, Andrii Nakryiko wrote:

> On Fri, Sep 17, 2021 at 6:08 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Mon, Sep 13, 2021 at 09:04:30PM -0700, Joanne Koong wrote:
>>> +
>>> +/* For bloom filter maps, the next 4 bits represent how many hashes to use.
>>> + * The maximum number of hash functions supported is 15. If this is not set,
>>> + * the default number of hash functions used will be 5.
>>> + */
>>> +     BPF_F_BLOOM_FILTER_HASH_BIT_1 = (1U << 13),
>>> +     BPF_F_BLOOM_FILTER_HASH_BIT_2 = (1U << 14),
>>> +     BPF_F_BLOOM_FILTER_HASH_BIT_3 = (1U << 15),
>>> +     BPF_F_BLOOM_FILTER_HASH_BIT_4 = (1U << 16),
>> The bit selection is unintuitive.
>> Since key_size has to be zero may be used that instead to indicate the number of hash
>> functions in the rare case when 5 is not good enough?
> Hm... I was initially thinking about proposing something like that,
> but it felt a bit ugly at the time. But now thinking about this a bit
> more, I think this would be a bit more meaningful if we change the
> terminology a bit. Instead of saying that Bloom filter has values and
> no keys, we actually have keys and no values. So all those bytes that
> are hashed are treated as keys (which is actually how sets are
> implemented on top of maps, where you have keys and no values, or at
> least the value is always true).
>
> So with that we'll have key/key_size to specify number of bytes that
> needs to be hashed (and it's type info). And then we can squint a bit
> and say that number of hashes are specified by value_size, as in
> values are those nr_hash bits that we set in Bloom filter.
>
> Still a bit of terminology stretch, but won't necessitate those
> specialized fields just for Bloom filter map. But if default value is
> going to be good enough for most cases and most cases won't need to
> adjust number of hashes, this seems to be pretty clean to me.

With having bloom filter map keys instead of values,  I think this would
lead to messier code in the kernel for handling map_lookup_elem
and map_update_elem calls, due to the fact that the bloom filter map
is a non-associative map and the current APIs for non-associative map types
(peek_elem/push_elem/pop_elem) all have the map data as the value and
not the key.

For example, for map_update_elem, the API from the eBPF program side is

int (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64 
flags);

This would require us to either

a) Add some custom logic in syscall.c so that we bypass the 
copy_from_bpfptr call on
bloom filter map values (necessary because memcpying 0 bytes still 
requires the src pointer
to be valid), which would allow us to pass in a NULL value

b) Add a new function like

int (*map_push_key)(struct bpf_map *map, void *key, u64 flags)

that eBPF programs can call instead of map_update_elem.

or

c) Try to repurpose the existing map_push_elem API by passing in the key 
instead of the value,
which would lead to inconsistent use of the API

I think if we could change the non-associative map types (currently only 
stack maps and queue
maps, I believe) to have their data be a key instead of a value, and 
have the pop/peek APIs use
keys instead of values, then this would be cleaner, since we could then 
just use the existing peek/pop
APIs.

>> Or use inner_map_fd since there is no possibility of having an inner map in bloomfilter.
>> It could be a union:
>>      __u32   max_entries;    /* max number of entries in a map */
>>      __u32   map_flags;      /* BPF_MAP_CREATE related
>>                               * flags defined above.
>>                               */
>>      union {
>>         __u32  inner_map_fd;   /* fd pointing to the inner map */
>>         __u32  nr_hash_funcs;  /* or number of hash functions */
>>      };
> This works as well. A bit more Bloom filter-only terminology
> throughout UAPI and libbpf, but I'd be fine with that as well.
>
Great, it looks like this is the consensus - I will go with this option 
for v3!
>>      __u32   numa_node;      /* numa node */
>>
>>> +struct bpf_bloom_filter {
>>> +     struct bpf_map map;
>>> +     u32 bit_array_mask;
>>> +     u32 hash_seed;
>>> +     /* If the size of the values in the bloom filter is u32 aligned,
>>> +      * then it is more performant to use jhash2 as the underlying hash
>>> +      * function, else we use jhash. This tracks the number of u32s
>>> +      * in an u32-aligned value size. If the value size is not u32 aligned,
>>> +      * this will be 0.
>>> +      */
>>> +     u32 aligned_u32_count;
>> what is the performance difference?
>> May be we enforce 4-byte sized value for simplicity?
> This might be a bit too surprising, especially if keys are just some
> strings, where people might not expect that it has to 4-byte multiple
> size. And debugging this without extra tooling (like retsnoop) is
> going to be nightmarish.
>
> If the performance diff is huge and that if/else logic is
> unacceptable, we can also internally pad with up to 3 zero bytes and
> include those into the hash.
I think the if/else logic is unavoidable if we support non 4-byte 
aligned value sizes,
unless we are okay with truncating any remainder bytes of non 4-byte 
aligned values
and stipulating that a bloom filter map value size has to be greater 
than 4 bytes (these
conditions would allow us to use jhash2 for every value without an 
if/else check). If we
internally pad, we will have to pad on every update and lookup, which 
would also
require an if/else.
Thanks for the comments and reviews, Alexei and Andrii. They are much 
appreciated!
