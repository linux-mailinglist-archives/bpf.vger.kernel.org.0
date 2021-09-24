Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8654178D1
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 18:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbhIXQgH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 12:36:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347760AbhIXQeJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Sep 2021 12:34:09 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OERq8a001546;
        Fri, 24 Sep 2021 09:32:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uCAN/cmVnFMzyLnppTR7t5lzZM3czP9aWuZZ0Nznh6Q=;
 b=FG6NeG/I572yt4T+A2LT3OvH47EuY7kRhH7uUq5w+rzU2ApJHf7MzZP+ZFwVQx9HtBE4
 Q28oJ4gakF8R+ln6ofKPraSxVKXiBWaOvD+cYzOM9d+mrsqbycx2fZGussgqMkh8pEDK
 x+L2W0oS1xWe/5dhm/fvWGEGCQ6smwKyFhQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b93fw53bn-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Sep 2021 09:32:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 24 Sep 2021 09:32:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dmg7UrdDz/hpJli0K94dUUSsjGNfqOyqlSzLjzCoW3qF4z5norF/DiICz9SXve4xn0pMjPXByCa0taHCoHDSkmS0LYdyfVr/f1hLLq5pnqTHonVAN4Z50KdXYlANyps3AeiOaGgRbEMWRVF5I8zpuXwXyfK2qDWDYyjxsU/Ez6GwRGMNkezZypT/Y3K2m+WCDJqX8qzg1d7G+jMHfZHxYnuNqXzX1w4aufNTNZqJPeGkvwCtZU40b6kkD/MKDwKCN2Kd5Wk2vuB6Xr2BsUlLQ8pVzWCaTAKK/Y+YnjMZowfMe8lul1BRh8gp/mY2FhigIC/kGod5BZ9MVp7XB/mcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uCAN/cmVnFMzyLnppTR7t5lzZM3czP9aWuZZ0Nznh6Q=;
 b=Jfw6xX6RvlfqDDKpRYM/bQgG4ZPOe5/ez70R8Aype8DyR0WMxU7IxoE2JghOWt2kS6dqmEk4m/t5BUb1ywNpW83bYa0yQwMKawIdvAHlAOGFUVd8xfc+5JUvIC/HmVOpVf43dri5UT3vQhJwwaIvV0HF9Hp/QB8AEIL6OqwsYoawiBQnylqVCUo9R9i5KhVC49znkQxXoz9+6g09AmndS+qRkRkElPaoYJ/i0S/n5y9qQqW07Z9pK54YZUXRIsP97kJOcVv97wOyyHJ5FHoPcQxGT+z+djdcVJIParzpHoIIjFxnziPEF7Q4YsT/gdhwHIZEsfBdLff8qBtrVhVerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB4467.namprd15.prod.outlook.com (2603:10b6:806:196::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 16:32:26 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe%8]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 16:32:26 +0000
Message-ID: <118c7f22-f710-581f-b87e-ee07aced429a@fb.com>
Date:   Fri, 24 Sep 2021 09:32:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
 <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
 <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
 <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp>
 <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
 <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::41) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::10fe] (2620:10d:c090:400::5:34e8) by BYAPR07CA0100.namprd07.prod.outlook.com (2603:10b6:a03:12b::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 16:32:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8274f93-28f9-4062-ac5f-08d97f78e4c9
X-MS-TrafficTypeDiagnostic: SA1PR15MB4467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4467BE644BCAF68D0CE07D7BD2A49@SA1PR15MB4467.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8iQaXRxvXTmAnckJvbJOG9P2NkvId6veM/jl0pJZdWG2JUjum8Aa9xre1NgQqZl76Yjsq4TDIHHGhC2GAoD/YTcdGEK5qtq2eR3L7sDbnDCb7Y+5HrOcKlyesXkLBYF6kvUkyt5dCdKmx2s9U4PW1iyWSZjQww40o0vexnhz6PpzswrJ1YXzqsIm9XG9kbf5P+KZmqrvMch8aqB9tR8GGKiLI8W+hYxXxwtNycjDvUUIP16QzbwFiQFNzNrzf5HI9Lsk1OLtYa7mYP5McwKVIE+Td5dEnnXTczDFc2GbaROs1GsZ9zZgZZFRSywAk1FzJATuN2h1vvw8KUUSi7CPq+F0jhHMl30DBgWeHxB353E74eiVwxoeZXE1470rj8PHJyKtJxxwyH3+tnC+FnoZ7uV0IYjm5Zx7zPaY7jpgfS5/R6PNtJx01wcusStF1sTzn0UxUf4PZ//n0nOE/kB6P8WpHC3jCb0lZVtRfmYHKxbOEtcqGg7VJvETPpuafSo4BC3/7JR+8fRaYRYJNVbmYv6d9sK7KDgWlVp8irmlIsU0GOvSwb3DU+W3ep+P6r/roqS7muKzQsU/xvfRILCUGr9aypSvrBUDztXRYc5naLx/qmV+pRnyuS1QmEpTE2HDUQVlySrAYMPcV0xRPmavfwC3aqC0wFRPk9jVou5PARDWZy+1FNb0fMqWWew7BvOAoOIiPWMD8h3MoBKSmJKXcOYAqW8bvBMbHBeh5j7Lt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(30864003)(508600001)(83380400001)(31686004)(31696002)(36756003)(66946007)(4326008)(66476007)(186003)(38100700002)(66556008)(53546011)(86362001)(2906002)(316002)(2616005)(8936002)(6486002)(8676002)(6916009)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZxSWhKb1VZQ1NMSXJ5bWl2eW5vQ0Q0WDV3UERwQ2ZJa1FhWFFVR1lRQWhm?=
 =?utf-8?B?Y2dmQlNwazdSTkRQUHM5cnZmOFdBK0RnV29jeTdtV29DdEt3WXN4bUl3YUJu?=
 =?utf-8?B?YmRmdElhb25lOTVnR3BaMXBUcXdsUms0MW5CR2RnYkRlbnhHU2ZzdzEzZVhu?=
 =?utf-8?B?NTZudGQrMENKQlFVVGlwRDRRK1EyZ0tKU3NzL1E2VVo3RDBJRkpiYVpmdVBW?=
 =?utf-8?B?RjJSdWFVUkIxbW1Md0kxUDNhYkV6REFnbDcybDN3T0FSVktYalFQc1JZbGw3?=
 =?utf-8?B?ZGZrd1NLSWZaNVdWSGRXR20rOXBRWkRvRzJwb0VXcWlpa3hMQXhpTExoYWEr?=
 =?utf-8?B?ZXNmRG81SnN0eElnbU5PYzhuM0grNytJQnRpcVhROStXRUNsczB2S1k1VmRE?=
 =?utf-8?B?Zi8xNzl0dU9lSGk5RWZIWUdwNUVWL1JvRGFIQXJyUmRFR1EyKzBsbjI4Uzg4?=
 =?utf-8?B?SEVpeDJlYzdBOGpPSDRZNVQwWXBFYm4zYXVwWW1Pdzhja0dYeHkwd2xpN3R2?=
 =?utf-8?B?QTg2djJsQWFKRHF3bXBqTjJSVlV0Q0xJU1JGRGZURjZ1YklwNW1nZE1BWFhq?=
 =?utf-8?B?dk9Ma3B2M1dZcE5pbDBDampLNER5Z01oQ0xQMHA5ckhueE9kNU9vUTh2SXI0?=
 =?utf-8?B?LzZvT1ZpTUhBY2luRXVxQ3kyeFpQWi80UDY4ejFrMHBGM2JzVGM5S0FFWEx6?=
 =?utf-8?B?NHE2bE03ZldGaUloMDcrY2N2KzJ6WDFOQ3lac3pBYjJVVUU4Slh5R3N0Y3Z5?=
 =?utf-8?B?TlFuQ2c5SlRNRGdFakVSUmpyb2oydEVwTE1pdTN5ZGtseHdROFlXZGZxV05G?=
 =?utf-8?B?Q2Z2SlloNEJQcjlWcU5NeG9vRlJDbUFaay9ZdzhSRXFJQnVha0NRdVlUT2ZR?=
 =?utf-8?B?c2VSejZCZUhQaHMwU2dVL0JRUzVTSWxXa3R5azNnM0JTS2ZNNDc1Rm00OGtL?=
 =?utf-8?B?eU5FNTRvV3RhU0pINVhBM3FFbGVmLzlIeXFFM3owUks5Q1o3WFJrUWpvYzR1?=
 =?utf-8?B?RnJpMWMvVXFtUlNyUVhNQUxiUCtFM1VXd2xtMTVmT0Z5akFUcnd0SXRMQTVK?=
 =?utf-8?B?Qk9QVGY5TUE4UU42UmNMMHNsT3RWbTlsRE1sWFlNK1JnMWhFZ2N3ZmhkK3dq?=
 =?utf-8?B?K21TaUtScFJiTUJQL2NPcmsxNm1VdTBuRU8zSmw1YzJWeHhEVlNMUEEzTVRN?=
 =?utf-8?B?SDlEcDZwUUwveUdIRE9WZi85bGZmT0VPSWZyZEN0M2tuaWJCcG9meGR5NStq?=
 =?utf-8?B?NnNCR055cEJ5ZVZZQ0c5VDIyNlRpcEVsS2liZVlZUXMzVncyei9BSEV6VGpy?=
 =?utf-8?B?N0JueVQwbUk3QkNWYlFYR0k1RUFVbUNyVzE4QXZPRmgxem1jb0tBWFJEQjMr?=
 =?utf-8?B?Z3dQN05ZQktlLzZoemowWndIbE8zMWpka2tvYUQyc0lZelFCNzBkaGRVQlg5?=
 =?utf-8?B?a0FVbkE5WWJhTHFpREVSbk51dVhhR0xOM0U0WUp6OHhnYVdIQndJR0NtNGV1?=
 =?utf-8?B?ZEZxb0JCRjJmbmhDRkxJcktGalQ4eXRXZE81LzJxcm95OUEzYTNYQXRkZmRx?=
 =?utf-8?B?WGJjNFZTdFBXT0NnNkx6SGF3Wks3WGRqejZMNUlkNXF0NVl4SXR0Q2ZVOTN4?=
 =?utf-8?B?SEltanpuM0JwMFlCb3htSlF6NjNFbndZdjJpOTlHRG1Yd0V4ZmV1V1VJcDE3?=
 =?utf-8?B?WW1NcHNydHp3N2lIcE9WNU9qVitzbnVFMU1ZL0c4eWlMWU8wWVMzMTUrYzlm?=
 =?utf-8?B?YkRCZG80OVZZbTV2cmRzeTdpRmtmWkQreGF1ZDB3VnBkK3lxeXYreHlGOWxx?=
 =?utf-8?B?bFNLSm5yK2MyakNIdmI4dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8274f93-28f9-4062-ac5f-08d97f78e4c9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 16:32:26.2414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ndp0RBwbEzwrsoyhgzxGEe1hq03cAihRaVvIPz2eLUKmdF/HWsFOGM7YpiLRSZXEJbn+pwXP6Ctn0jbptJYKxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4467
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3AgYI5XZQV44189WcE4PN3TN-7mdkEwJ
X-Proofpoint-ORIG-GUID: 3AgYI5XZQV44189WcE4PN3TN-7mdkEwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/23/21 7:23 PM, Andrii Nakryiko wrote:

> On Thu, Sep 23, 2021 at 3:28 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 9/23/21 2:12 PM, Andrii Nakryiko wrote:
>>> On Thu, Sep 23, 2021 at 1:30 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> On Thu, Sep 23, 2021 at 12:42:33PM -0700, Martin KaFai Lau wrote:
>>>>> How to move it forward from here?  Is it a must to keep the
>>>>> bloomfilter-like map in pure bpf only and we should stop
>>>>> the current work?
>>>>>
>>>>> or it is useful to have the kernel bloom filter that provides
>>>>> a get-and-go usage and a consistent experience for user in
>>>>> map-in-map which is the primary use case here.  I don't think
>>>>> this is necessarily blocking the custom bpf map effort also.
>>>> I think map based and helper based bloom filter implementations
>>>> are far from equivalent. There are pros and cons to both.
>>>> For example the helper style doesn't have a good way
>>>> of query/populate from the user space. If it's a single element
>>> I thought about the use from user-space. I'd consider two ways of
>>> doing that. One more complicated but with better performance, another
>>> simpler but less performant (but in this case less performant is
>>> equivalent to in-kernel implementation performance, or still better):
>>>
>>> 1. Have identical hash function implementation in user-space. In this
>>> case Jenkins hash. Then memory-map contents and use exactly the same
>>> bloom filter code to set the bits (as I said, once you have hash, it's
>>> just a glorified bitset). This has the downside that if there is even
>>> a single bit difference between hash produced by kernel and
>>> user-space, you are screwed. But can't beat the performance because no
>>> syscall overhead.
>>>
>>> 2. Use BPF_PROG_RUN command to execute custom program that would set
>>> one or multiple provided values in the hashset. Just like we argued
>>> for BPF timers, BPF program can be a custom "API" that would avoid
>>> having separate user-space logic. Pass one or many values through a
>>> global variable/array, BPF_PROG_RUN program that would iterate values,
>>> calculate hashes, set bits. It actually should be faster than doing
>>> BPF_MAP_UPDATE_ELEM syscall for each value. Next proposal will be to
>>> add batched update support, of course, so I won't claim victory for
>>> the performance argument here. :)
>>>
>>> But yes, it needs a bit more (but simple) code, than if the kernel
>>> just provided a Bloom filter map out of the box.
>>>
>>>> array the user space would be forced to allocate huge buffers
>>>> just to read/write single huge value_size.
>>>> With multi element array it's sort-of easier.
>>>> mmap-ing the array could help too,
>>>> but in either case the user space would need to copy-paste jhash,
>>>> which is GPL, and that might be more than just inconvenience.
>>>   From include/linux/jhash.h: "You can use this free for any purpose.
>>> It's in the public domain".
>>>
>>>> We can try siphash in the bpf helper and give it a flag to choose
>>> I did bpf_jhash_mem() just to demonstrate the approach quickly. I
>>> think in practice I'd go for a more generic implementation where one
>>> of the parameters is enum that specifies which supported hash
>>> algorithm is used. It's easier to extend that:
>>>
>>> u64 bpf_hash_mem(const void *data, u32 sz, u32 seed, enum bpf_hash_algo algo);
>>>
>>> enum bpf_hash_algo {
>>>      XOR = 0,
>>>      JENKINS = 1,
>>>      MURMUR3 = 2,
>>>      ...
>>> }
>>>
>>> Note the XOR case. If we specify it as "xor u64 values, where the last
>>> <8 bytes are zero extended", it will come useful below for your
>>> proposal.
>>>
>>>
>>>> between hash implementations. That helps, but doesn't completely
>>>> makes them equivalent.
>>> I don't claim that implementing and using a custom Bloom filter will
>>> be easier to use in all situations. I think the best we can strive for
>>> is making it not much harder, and I think in this case it is. Of
>>> course we can come up with a bunch of situations where doing it with
>>> pure BPF isn't possible to do equivalently (like map-in-map with
>>> dynamically sized bit size, well, sorry, BPF verifier can't validate
>>> stuff like that). Dedicated BPF map or helper (as a general case, not
>>> just this one) will pretty much always going to be easier to use just
>>> because it's a dedicated and tailored API.
>>>
>> To me, it seems like we get the best of both worlds by using both of these
>> two ideas for the bloom filter. For developers who would like
>> to use a general bloom filter without having to do any extra
>> implementation work
>> or having to understand how bloom filters are implemented, they could use
>> the custom bloom filter map with minimal effort. For developers who
>> would like to customize their bloom filter to something more specific or
>> fine-tuned, they could use craft their own bloom filter in an ebpf program.
>> To me, these two directions don't seem mutually exclusive.
> They are not mutually exclusive, of course, but adding stuff to the
> kernel has its maintenance costs.
>
>>>> As far as map based bloom filter I think it can combine bitset
>>>> and bloomfilter features into one. delete_elem from user space
>>>> can be mapped into pop() to clear bits.
>>>> Some special value of nr_hashes could mean that no hashing
>>>> is applied and 4 or 8 byte key gets modulo of max_entries
>>>> and treated as a bit index. Both bpf prog and user space will
>>>> have uniform access into such bitset. With nr_hashes >= 1
>>>> it will become a bloom filter.
>>>> In that sense may be max_entries should be specified in bits
>>>> and the map is called bitset. With nr_hashes >= 1 the kernel
>>>> would accept key_size > 8 and convert it to bloom filter
>>>> peek/pop/push. In other words
>>>> nr_hash == 0 bit_idx == key for set/read/clear
>>>> nr_hashes >= 1 bit_idx[1..N] = hash(key, N) for set/read/clear.
>>>> If we could teach the verifier to inline the bit lookup
>>>> we potentially can get rid of bloomfilter loop inside the peek().
>>>> Then the map would be true bitset without bloomfilter quirks.
>>>> Even in such case it's not equivalent to bpf_hash(mem_ptr, size, flags) helper.
>>>> Thoughts?
>> This is an interesting suggestion; to me, it seems like the APIs and
>> code would be
>> more straightforward if the bitset and the bloom filter were separate maps.
>> With having max_entries be specified in bits, I think this also relies
>> on the
>> user to make an educated call on the optimal number of bits to use for
>> their bloom
>> filter, instead of passing in the number of entries they expect to have
>> and having the
>> bit size automatically calculated according to a mathematically
>> optimized equation.
>> I am open to this idea though.
> We can provide a macro that will calculate mathematically optimized
> value based on desired number of unique entries and hash functions.
> E.g.:
>
> #define BPF_BLOOM_FILTER_BYTE_SZ(nr_uniq_entries, nr_hash_funcs)
> (nr_uniq_entires * nr_hash_funcs / 5 * 7 / 8)
>
> Kernel code can round up to closest power-of-two internally to make
> this simpler. So if users don't care or don't know, they'll use
> BPF_BPLOOM_FILTER_BYTE_SZ() macro, but if they know better, they'll
> just specify desired amount of bytes.
Sounds great!
>>> Sounds a bit complicated from end-user's perspective, tbh, but bitset
>>> map (with generalization for bloom filter) sounds a bit more widely
>>> useful. See above for the bpf_hash_algo proposal. If we allow to
>>> specify nr_hashes and hash algorithm, then with XOR as defined above
>>> and nr_hash = 1, you'll get just bitset behavior with not extra
>>> restrictions on key size: you could have 1, 2, 4, 8 and more bytes
>>> (where with more bytes it's some suboptimal bloom filter with one hash
>>> function, not sure why you'd do that).
>>>
>>> The biggest quirk is defining that XOR hashes in chunks of 8 bytes
>>> (with zero-extending anything that is not a multiple of 8 bytes
>>> length). We can do special "only 1, 2, 4, and 8 bytes are supported",
>>> of course, but it will be special-cased internally. Not sure which one
>>> is cleaner.
>>>
>>> While writing this, another thought was to have a "NOOP" (or
>>> "IDENTITY") hash, where we say that we treat bytes as one huge number.
>>> Obviously then we truncate to the actual bitmap size, which just
>>> basically means "use up to lower 8 bytes as a number". But it sucks
>>> for big-endian, because to make it sane we'd need to take last "up to
>>> 8 bytes", which obviously sounds convoluted. So I don't know, just a
>>> thought.
>>>
>>> If we do the map, though, regardless if it's bitset or bloom
>>> specifically. Maybe we should consider modeling as actual
>>> bpf_map_lookup_elem(), where the key is a pointer to whatever we are
>>> hashing and looking up? It makes much more sense, that's how people
>>> model sets based on maps: key is the element you are looking up, value
>>> is either true/false or meaningless (at least for me it felt much more
>>> natural that you are looking up by key, not by value). In this case,
>>> what if on successful lookup we return a pointer to some fixed
>>> u8/u32/u64 location in the kernel, some dedicated static variable
>>> shared between all maps. So NULL means "element is not in a set",
>>> non-NULL means it is in the set.
>> I think this would then also require that the bpf_map_update_elem() API from
>> the userspace side would have to pass in a valid memory address for the
>> "value".
>> I understand what you're saying though about it feeling more natural
>> that the "key" is the element here; I agree but there doesn't seem to be
>> a clean way
>> of doing this - I think maybe one viable approach would be allowing
>> map_update_elem
>> to pass in a NULL value in the kernel if the map is a non-associative
>> map, and refactoring the
>> push_elem/peek_elem API so that the element can represent either the key
>> or the value.
> Yeah, we can allow value to be NULL (and key non-NULL). But why
> push/peek if we are talking about using standard
> lookup_elem/update_elem (and maybe even delete_elem which will reset
> bits to 0)?
In the syscall layer where we handle lookup_elem, we call 
map->ops->map_lookup_elem
and expect that the ptr we get back is a ptr to the value associated 
with the key
(and if the ptr is NULL we treat that as an error).

Instead of adding special-casing for bloom filter maps to treat a NULL 
ptr value
as something that's okay, it seems cleaner to repurpose peek to be the 
API we use for
all non-associative map types.
>>>    Ideally we'd prevent such element to
>>> be written to, but it might be too hard to do that as just one
>>> exception here, don't know.
> BTW, that nr_hash_funcs field in UAPI and in libbpf was still
> bothering me. I'd feel better if we generalize this to future map
> needs and make it generic. How about adding "u32 map_extra;" field to
> UAPI (as a new field, so it's available for all maps, including
> map-in-maps). The meaning of that field would be per-map-type extra
> flags/values/etc. In this case we can define that map_extra for
> BLOOM_FILTER it would encode number of hash functions. If we ok adding
> hash function enum that I proposed for bpf_hash_mem() helper, we can
> also include that into map_extra. We can reserve lower N bits for
> number of hash functions and then next few bits would be reserved for
> hash algo enum.
>
> So then you'd define map (in libbpf syntax) pretty naturally as:
>
> struct {
>      __uint(type, BPF_MAP_TYPE_BLOOM_FILTER); /* or BITSET, don't know
> which way this is going */
>      ....
>      __uint(map_extra, BPF_HASH_SHA256 | 3); /* 3 x SHA256 hash functions */
> } my_bloom_filter SEC(".maps");
>
> BPF_HASH_SHA256 would be defined as something like 0x{1,2,4,etc}0,
> leaving lower 4 bits for nr_hash_funcs.
>
> And then I'd have no problem supporting map_extra field for any map
> definition, with bpf_map__map_extra() and bpf_map__set_map_extra()
> getter/setter.
>
> map_flags is different in that it's partially shared by all map types
> (e.g., BPF_F_RDONLY_PROG, BPF_F_INNER_MAP, BPF_F_NUMA_NODE can be
> specified for lots of different types).
>
> Naming is obviously up for discussion.

I love this idea!


To make sure we're all aligned on the direction of this, for v4 I'm 
going to make
the following changes:
* Make the map a bitset + bloom filter map, depending on how many hashes
are passed in
* Write tests for the bitset functionality of the map
* Change nr_hashes to a more generic "u32 map_extra"
* Incorporate some of Andrii's changes to the benchmarks for
accounting + measuring
* Add more documentation regarding the optimal bitmap size equation
"nr_unique_entries * nr_hash_funcs / 5 * 7 / 8" to clear up any confusion


Thanks for the discussion on this, Martin, Andrii, and Alexei!

