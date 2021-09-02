Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5D3FF6DA
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 00:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347596AbhIBWJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 18:09:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21446 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233108AbhIBWJD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 18:09:03 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182M45M2010149;
        Thu, 2 Sep 2021 15:08:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TgW9UcRNJFlI25UAvkd3RjOlCrYmPX6udkUGjzTGkug=;
 b=YCOZrmblO4cUB24SutwAxz7/0u/zAGv1abEcQJiMKqbpGE6VWgHl3aIio8SkTidRJetP
 OHBffk3clZSc2vKJjhoDzrppmR+N1VShpH+SVt8k1jOlRVSP8qgNF0xTUfRd16TOBwdQ
 Ael39rbTdCcYJS9wPXZ3QcEqFOq2L9kMCSQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3au1yb354b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Sep 2021 15:08:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 2 Sep 2021 15:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqCIUw4FOOPHiFdlYQbBZbsXvxiTcKbXqGqwLkWGQhlzxIp+f1FygHHWeyUkCgyDvuHXsHdNAoAoUL3x51io0l4KIEc7xBtNHJgmSm1wrhZSl7YDYit78eQQ+XlI/+P+d6fn7I0KJ4Sk6ZM2HZOpdKZQexiG/z08oz+u9WQuyMRrOJWlE7FIfh181GszshhgVNCp555lyOd/1Z6EN2SEG1EWvnaegblCwEOxbG4sAy1SCPvOu1GoAO4pwt84MoRXSbH4/5CWIRQqV3bW1J+tjGYrVyaq5gRGXealqq+DYcRhivgl5ggBskWdvtU2njvS5qK/pGdNVZV2/r4pje8/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgW9UcRNJFlI25UAvkd3RjOlCrYmPX6udkUGjzTGkug=;
 b=LQh0BFpeuqVtFa73IOxyoMgeasCoppz+wjsUMEyCuJM549w4FkZz7kDDEWA33dfprMELzelGpSzlUGUkZZ7NVUKJmEk4wKN/lV6LNFk+s7mEhkpVIsHC9+FXtq0iU2wszjBWZ4CPWtaXkWY13i861BueFNdjTfQ2g9yQnEo8sPqCcYxOXCfJ+H3hFFUGqwULQ+YeMAyfAk6PiKjTPuNiN0RJTOHKBJlWvhSFpe2kVj+AifkkaZurS/sSizZ7ymE4ktMkDs+aIKi5OsVWTibKcvaskT44W/sQIiCfcHgwT+EfJ5vIgmfqQfiiNd52kRec1djV5jzFlgL/IoT+NRDCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB4369.namprd15.prod.outlook.com (2603:10b6:806:190::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Thu, 2 Sep
 2021 22:08:00 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::6dc9:801e:3ad5:a175]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::6dc9:801e:3ad5:a175%8]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 22:08:00 +0000
Message-ID: <0c1bb5a6-4ef5-77b4-cd10-aea0060d5349@fb.com>
Date:   Thu, 2 Sep 2021 15:07:56 -0700
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
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <61305cf822fa_439b208a5@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:102:2::29) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::12dc] (2620:10d:c090:400::5:b76f) by CO2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:102:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Thu, 2 Sep 2021 22:07:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f483a011-17c2-4331-1fce-08d96e5e20bf
X-MS-TrafficTypeDiagnostic: SA1PR15MB4369:
X-Microsoft-Antispam-PRVS: <SA1PR15MB43696A0FFD4F480139030CD1D2CE9@SA1PR15MB4369.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMUbJatza+GMac/DPzRxxqp5Xcts/xRfaeYp04wl2le/UoOVr88am9DXlNWy6axphRBF4PskWA892pQ8hT4zz8aMKFhbR41ZaD2/2biOJ0a0oR5UCsPqGAAE5J6XNzz5uAW9oXHmEc+xPqMUpI+Ii5+j1zr3F5PptKby74QozIv2OFvD6VCdoVYkoJtb974KZzdJaNBZYHm4JkLFr59VTYCc8+myNiVYUUdyEsSfu3weG5V+fZj4lu9R2AMkop3QZdJt+NXEcjDYBffxjxlSQ0j3aI9x2OWA1BImBvfDMKCdIt3PYcn6kxGK/c/DXtEmeB4vClJoIxGOlcSTuSXq2SsMvlhAEFB01Ut2tcJbZTnw6oSV9ft9VOyW5zWA8CCEGw6LGdMOR6kIK40vRGklqemqPGo1othJ6NRssKW8vxyNv5rNZt3RjL2bHl2tzrPP10+412bh6CPI98RQkrw+kHvngYiorUDgyx7r2CD6/zLA0JjIYLc6FmCfBlmmGoFywyiZtAgckQiZNhdmF+i6P44PVbl8H7jjnlspHeWBLNV/FqQxYtHtjinM7TJI4IMDLyM9Rac3D6YZy8Qjv10kxFA63Ik/Lww+HE+yvvduKQ09gvANfM6JV7E7DnzBd0ZeQvt98If2jpqi7i8FaRzks3957i/Gx0PN6mjOJsAYLfT0hfdHPAUqodEQHKOjiLOt/gh75TJGQUd0ZaEaKo0Msrfp7y5n5GJ4zl8m8SIAAmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(53546011)(38100700002)(186003)(86362001)(66476007)(83380400001)(66946007)(6666004)(110136005)(31696002)(4326008)(316002)(66556008)(8936002)(2616005)(30864003)(8676002)(31686004)(2906002)(5660300002)(478600001)(36756003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitOOUo3M21hc1Iza3FLK0Z2SnZyc3hKR2xzS1dvc1plTUdNTzBuTzRVQ1R4?=
 =?utf-8?B?M3gwNi9mRmtqMk82MFlmZTNtNnY0bVp4eTFiOHhNdDJSbmpFeVN6RmhFY1dV?=
 =?utf-8?B?TmxzY1BJb3RXM0U1NUVtRXdBYk1tdkdpNTFZNXZUUFBzM3Q3SlZyNmV6V3lN?=
 =?utf-8?B?YXkrOEFFMEFXM3pLRFgzb3V1OWgybVZVcWtMZGpBS0swaTUycTZ2eHBMblBt?=
 =?utf-8?B?Y0lrdzFnZTJQNjYvbWVhVjA4aDcveFZDbUV1MGtUZTQwMkpCUXUyWnkrb2hr?=
 =?utf-8?B?NWZiMDVzZ2p4UEJjU3ZqUTQvOFVRNXJIWWxBV0RFM2lmL3kzVEhhZmFnd3E5?=
 =?utf-8?B?TFZHcmR1RHZXdFR5YTZPNHErVmo0bHVrQjFIREw1bHM0cWJwaFNqaExGU1hZ?=
 =?utf-8?B?VU5vTE9nYi8vR1pBci9ZR2ROWTA5MlBNc0V4SzlMY3NaV1hITnR6elJRMHJV?=
 =?utf-8?B?U211TmhaQ2tZR1FteXRQclIzeGlLaUpocWMrekNKOEdLdXhHaVUxc2ZqOXFs?=
 =?utf-8?B?VlY5UG9DZlBoVTdXQlozR1AvL3hzZkhtTXBSZnlpVXphWlY0eC9WMUpPSkJR?=
 =?utf-8?B?TWd2bTc3R0gxMzBhR0dMaWlkYUdBdG5VVk1tbzlMbXdKM1o4RVRBUyt2aWcr?=
 =?utf-8?B?NmhuUlA1YkhHZHRjbDBCN3JCNjJaVmZrNjNHNnBRQWlQNTZ6U2hrT3BXcnpa?=
 =?utf-8?B?QmxJMnRRNGt0bzVZQWoxSVp5SzlFb3Fuc3V1ZkV0M1hQWTU2ZElNVzlQZTFB?=
 =?utf-8?B?QzRZVE5IOUtzMmhzK3FVcEZWajBRSm5pa2YraHgwYWJCWVZRWm5DbExrOEsw?=
 =?utf-8?B?eXVYRENKOFByZTA3elhlTkNiZ2FlZSt3Q0lHV3RUYlFudUFGSCtEeUg3b1lF?=
 =?utf-8?B?TVdVTEszOEgxUS9lR1hWZFFaWVhnbHdFeUpGVHlGWGdueW85UGVZWnNVV3lN?=
 =?utf-8?B?ZmFYd3lwY0hXWVdXRy9hQTJDYzA1eFduVjg2SlJQNThsR3cxY0NmUWE1S0pm?=
 =?utf-8?B?SlVNUFNWSFNjbytYRFdHZlhWVDlqSDRmL0NRN2tzOEpYOTVJeXVodjFzNUxz?=
 =?utf-8?B?UFEvajFvNE1Lakc2WTVGNC9Gak96U2NUbDlJRHdoZFhZekxKcXYwNWlrTWVj?=
 =?utf-8?B?THlaeTlheXFjcm5Lckpubi9Mc1BhS0wvTGxYU2JBdzF6NCt1MUV4WUJSUkxL?=
 =?utf-8?B?dGNiTDVyWHJCK0hheG93dnd6eHJtWlQvdnRkZ1JvMHY0NkxCNlZOUnpMcm81?=
 =?utf-8?B?SmZGUmNraERlQWVrUVp1NTArc3JtQkwzS0ZVVDltV3pvUm40TEtiWHhaMHQ4?=
 =?utf-8?B?TitxbXZITGkvaWJ3dnJzMGRKRFFRa1cxTm1OT1dxN05yU241ZWlTU3M5TnRn?=
 =?utf-8?B?MHdJd2paWDFWeHVZMVZpRThVS1NoemVTV2dvYVloemp6aDFET3B3Mk1adUJE?=
 =?utf-8?B?YzFjMG0yeVNjNTV2aXU0NzNzbTJzclMydStGeWxUcXp3cStOc3UxRkFHQS9Y?=
 =?utf-8?B?dW0zT0R1UjZ6Wjg3QjZWVDFHd2FCc0FSMWlzR0JubFhDampLdVNZQ3Evai80?=
 =?utf-8?B?NG5sVmlUTHNrTjJYQTYzdjNXM0VYVVVFR2xSVlExVVJUYWpURmtaNktlRHM3?=
 =?utf-8?B?Y25Jd3dzSG9YMThaTlhUQXZsUFNZZDZPbk1aNVo0ZXFyTldqa2ZXQXE0c3hN?=
 =?utf-8?B?bG03QXpMdUVrSmM2clYxb24xaHJsSUc1eGV6RFE0UzVNSGo2SVlJOFlXd1hN?=
 =?utf-8?B?UEYvV2hvN1ovOHZIcWlJM0dRYjNlYy9qMFMxcGNxemFhU05kVTRpT3FFa0pk?=
 =?utf-8?B?OG45UDB3NnZQcFpCU0RoUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f483a011-17c2-4331-1fce-08d96e5e20bf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 22:08:00.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYfkwMim5pUuB1xZrsnmiPY0YgPr1qShhK25k1JaoOormTwHzNYXsdGFpehDfcj4Xv+mNQxVnFQQsESJ8HAcwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4369
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: sSkRbLvi3qRYlpsF0dLnhA6S5WebjXfY
X-Proofpoint-ORIG-GUID: sSkRbLvi3qRYlpsF0dLnhA6S5WebjXfY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109020127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/1/21 10:11 PM, John Fastabend wrote:

> Andrii Nakryiko wrote:
>> On Tue, Aug 31, 2021 at 3:51 PM Joanne Koong <joannekoong@fb.com> wrote:
>>> Bloom filters are a space-efficient probabilistic data structure
>>> used to quickly test whether an element exists in a set.
>>> In a bloom filter, false positives are possible whereas false
>>> negatives are not.
>>>
>>> This patch adds a bloom filter map for bpf programs.
>>> The bloom filter map supports peek (determining whether an element
>>> is present in the map) and push (adding an element to the map)
>>> operations.These operations are exposed to userspace applications
>>> through the already existing syscalls in the following way:
>>>
>>> BPF_MAP_LOOKUP_ELEM -> peek
>>> BPF_MAP_UPDATE_ELEM -> push
>>>
>>> The bloom filter map does not have keys, only values. In light of
>>> this, the bloom filter map's API matches that of queue stack maps:
>>> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
>>> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
>>> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
>>> APIs to query or add an element to the bloom filter map. When the
>>> bloom filter map is created, it must be created with a key_size of 0.
>>>
>>> For updates, the user will pass in the element to add to the map
>>> as the value, wih a NULL key. For lookups, the user will pass in the
>>> element to query in the map as the value. In the verifier layer, this
>>> requires us to modify the argument type of a bloom filter's
>>> BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
>>> the syscall layer, we need to copy over the user value so that in
>>> bpf_map_peek_elem, we know which specific value to query.
>>>
>>> The maximum number of entries in the bloom filter is not enforced; if
>>> the user wishes to insert more entries into the bloom filter than they
>>> specified as the max entries size of the bloom filter, that is permitted
>>> but the performance of their bloom filter will have a higher false
>>> positive rate.
>>>
>>> The number of hashes to use for the bloom filter is configurable from
>>> userspace. The benchmarks later in this patchset can help compare the
>>> performances of different number of hashes on different entry
>>> sizes. In general, using more hashes decreases the speed of a lookup,
>>> but increases the false positive rate of an element being detected in the
>>> bloom filter.
>>>
>>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>>> ---
>> This looks nice and simple. I left a few comments below.
>>
>> But one high-level point I wanted to discuss was that bloom filter
>> logic is actually simple enough to be implementable by pure BPF
>> program logic. The only problematic part is generic hashing of a piece
>> of memory. Regardless of implementing bloom filter as kernel-provided
>> BPF map or implementing it with custom BPF program logic, having BPF
>> helper for hashing a piece of memory seems extremely useful and very
>> generic. I can't recall if we ever discussed adding such helpers, but
>> maybe we should?
> Aha started typing the same thing :)
>
> Adding generic hash helper has been on my todo list and close to the top
> now. The use case is hashing data from skb payloads and such from kprobe
> and sockmap side. I'm happy to work on it as soon as possible if no one
> else picks it up.
>
>> It would be a really interesting experiment to implement the same
>> logic in pure BPF logic and run it as another benchmark, along the
>> Bloom filter map. BPF has both spinlock and atomic operation, so we
>> can compare and contrast. We only miss hashing BPF helper.
> The one issue I've found writing a hash logic is its a bit tricky
> to get the verifier to consume it. Especially when the hash is nested
> inside a for loop and sometimes a couple for loops so you end up with
> things like,
>
>   for (i = 0; i < someTlvs; i++) {
>    for (j = 0; j < someKeys; i++) {
>      ...
>      bpf_hash(someValue)
>      ...
>   }
>
> I've find small seemingly unrelated changes cause the complexity limit
> to explode. Usually we can work around it with code to get pruning
> points and such, but its a bit ugly. Perhaps this means we need
> to dive into details of why the complexity explodes, but I've not
> got to it yet. The todo list is long.
>
>> Being able to do this in pure BPF code has a bunch of advantages.
>> Depending on specific application, users can decide to:
>>    - speed up the operation by ditching spinlock or atomic operation,
>> if the logic allows to lose some bit updates;
>>    - decide on optimal size, which might not be a power of 2, depending
>> on memory vs CPU trade of in any particular case;
>>    - it's also possible to implement a more general Counting Bloom
>> filter, all without modifying the kernel.
> Also it means no call and if you build it on top of an array
> map of size 1 its just a load. Could this be a performance win for
> example a Bloom filter in XDP for DDOS? Maybe. Not sure if the program
> would be complex enough a call might be in the noise. I don't know.
>
>> We could go further, and start implementing other simple data
>> structures relying on hashing, like HyperLogLog. And all with no
>> kernel modifications. Map-in-map is no issue as well, because there is
>> a choice of using either fixed global data arrays for maximum
>> performance, or using BPF_MAP_TYPE_ARRAY maps that can go inside
>> map-in-map.
> We've been doing most of our array maps as single entry arrays
> at this point and just calculating offsets directly in BPF. Same
> for some simple hashing algorithms.
>
>> Basically, regardless of having this map in the kernel or not, let's
>> have a "universal" hashing function as a BPF helper as well.
> Yes please!
I completely agree!
>> Thoughts?
> I like it, but not the bloom filter expert here.


Ooh, I like your idea of comparing the performance of the bloom filter with
a kernel-provided BPF map vs. custom BPF program logic using a
hash helper, especially if a BPF hash helper is something useful that
we want to add to the codebase in and of itself!

>>>   include/linux/bpf.h            |   3 +-
>>>   include/linux/bpf_types.h      |   1 +
>>>   include/uapi/linux/bpf.h       |   3 +
>>>   kernel/bpf/Makefile            |   2 +-
>>>   kernel/bpf/bloom_filter.c      | 171 +++++++++++++++++++++++++++++++++
>>>   kernel/bpf/syscall.c           |  20 +++-
>>>   kernel/bpf/verifier.c          |  19 +++-
>>>   tools/include/uapi/linux/bpf.h |   3 +
>>>   8 files changed, 214 insertions(+), 8 deletions(-)
>>>   create mode 100644 kernel/bpf/bloom_filter.c
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index f4c16f19f83e..2abaa1052096 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -181,7 +181,8 @@ struct bpf_map {
>>>          u32 btf_vmlinux_value_type_id;
>>>          bool bypass_spec_v1;
>>>          bool frozen; /* write-once; write-protected by freeze_mutex */
>>> -       /* 22 bytes hole */
>>> +       u32 nr_hashes; /* used for bloom filter maps */
>>> +       /* 18 bytes hole */
>>>
>>>          /* The 3rd and 4th cacheline with misc members to avoid false sharing
>>>           * particularly with refcounting.
>>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>>> index 9c81724e4b98..c4424ac2fa02 100644
>>> --- a/include/linux/bpf_types.h
>>> +++ b/include/linux/bpf_types.h
>>> @@ -125,6 +125,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STACK, stack_map_ops)
>>>   BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
>>>   #endif
>>>   BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
>>> +BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>>>
>>>   BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>>>   BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 791f31dd0abe..c2acb0a510fe 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -906,6 +906,7 @@ enum bpf_map_type {
>>>          BPF_MAP_TYPE_RINGBUF,
>>>          BPF_MAP_TYPE_INODE_STORAGE,
>>>          BPF_MAP_TYPE_TASK_STORAGE,
>>> +       BPF_MAP_TYPE_BLOOM_FILTER,
>>>   };
>>>
>>>   /* Note that tracing related programs such as
>>> @@ -1274,6 +1275,7 @@ union bpf_attr {
>>>                                                     * struct stored as the
>>>                                                     * map value
>>>                                                     */
>>> +               __u32   nr_hashes;      /* used for configuring bloom filter maps */
>> This feels like a bit too one-off property that won't be ever reused
>> by any other type of map. Also consider that we should probably limit
>> nr_hashes to some pretty small sane value (<16? <64?) to prevent easy
>> DOS from inside BPF programs (e.g., set nr_hash to 2bln, each
>> operation is now extremely slow and CPU intensive). So with that,
>> maybe let's provide number of hashes as part of map_flags? And as
>> Alexei proposed, zero would mean some recommended value (2 or 3,
>> right?). This would also mean that libbpf won't need to know about
>> one-off map property in parsing BTF map definitions.
I think we can limit nr_hashes to 10, since 10 hashes has a false 
positive rate of
roughly ~0%
>>>          };
>>>
>>>          struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>>> @@ -5594,6 +5596,7 @@ struct bpf_map_info {
>>>          __u32 btf_id;
>>>          __u32 btf_key_type_id;
>>>          __u32 btf_value_type_id;
>>> +       __u32 nr_hashes; /* used for bloom filter maps */
>>>   } __attribute__((aligned(8)));
>>>
>>>   struct bpf_btf_info {
>>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>>> index 7f33098ca63f..cf6ca339f3cd 100644
>>> --- a/kernel/bpf/Makefile
>>> +++ b/kernel/bpf/Makefile
>>> @@ -7,7 +7,7 @@ endif
>>>   CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>>>
>>>   obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
>>> -obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
>>> +obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>>>   obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
>>>   obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>>>   obj-${CONFIG_BPF_LSM}    += bpf_inode_storage.o
>>> diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
>>> new file mode 100644
>>> index 000000000000..3ae799ab3747
>>> --- /dev/null
>>> +++ b/kernel/bpf/bloom_filter.c
>>> @@ -0,0 +1,171 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2021 Facebook */
>>> +
>>> +#include <linux/bitmap.h>
>>> +#include <linux/bpf.h>
>>> +#include <linux/err.h>
>>> +#include <linux/jhash.h>
>>> +#include <linux/random.h>
>>> +#include <linux/spinlock.h>
>>> +
>>> +#define BLOOM_FILTER_CREATE_FLAG_MASK \
>>> +       (BPF_F_NUMA_NODE | BPF_F_ZERO_SEED | BPF_F_ACCESS_MASK)
>>> +
>>> +struct bpf_bloom_filter {
>>> +       struct bpf_map map;
>>> +       u32 bit_array_mask;
>>> +       u32 hash_seed;
>>> +       /* Used for synchronizing parallel writes to the bit array */
>>> +       spinlock_t spinlock;
>>> +       unsigned long bit_array[];
>>> +};
>>> +
>>> +static int bloom_filter_map_peek_elem(struct bpf_map *map, void *value)
>>> +{
>>> +       struct bpf_bloom_filter *bloom_filter =
>>> +               container_of(map, struct bpf_bloom_filter, map);
>>> +       u32 i, hash;
>>> +
>>> +       for (i = 0; i < bloom_filter->map.nr_hashes; i++) {
>>> +               hash = jhash(value, map->value_size, bloom_filter->hash_seed + i) &
>>> +                       bloom_filter->bit_array_mask;
>>> +               if (!test_bit(hash, bloom_filter->bit_array))
>>> +                       return -ENOENT;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static struct bpf_map *bloom_filter_map_alloc(union bpf_attr *attr)
>>> +{
>>> +       int numa_node = bpf_map_attr_numa_node(attr);
>>> +       u32 nr_bits, bit_array_bytes, bit_array_mask;
>>> +       struct bpf_bloom_filter *bloom_filter;
>>> +
>>> +       if (!bpf_capable())
>>> +               return ERR_PTR(-EPERM);
>>> +
>>> +       if (attr->key_size != 0 || attr->value_size == 0 || attr->max_entries == 0 ||
>>> +           attr->nr_hashes == 0 || attr->map_flags & ~BLOOM_FILTER_CREATE_FLAG_MASK ||
>>> +           !bpf_map_flags_access_ok(attr->map_flags))
>>> +               return ERR_PTR(-EINVAL);
>>> +
>>> +       /* For the bloom filter, the optimal bit array size that minimizes the
>>> +        * false positive probability is n * k / ln(2) where n is the number of
>>> +        * expected entries in the bloom filter and k is the number of hash
>>> +        * functions. We use 7 / 5 to approximate 1 / ln(2).
>>> +        *
>>> +        * We round this up to the nearest power of two to enable more efficient
>>> +        * hashing using bitmasks. The bitmask will be the bit array size - 1.
>>> +        *
>>> +        * If this overflows a u32, the bit array size will have 2^32 (4
>>> +        * GB) bits.
> Would it be better to return E2BIG or EINVAL here? Speculating a bit, but if I was
> a user I might want to know that the number of bits I pushed down is not the actual
> number?

I think if we return E2BIG or EINVAL here, this will fail to create the 
bloom filter map
if the max_entries exceeds some limit (~3 billion, according to my math) 
whereas
automatically setting the bit array size to 2^32 if the max_entries is
extraordinarily large will still allow the user to create and use a 
bloom filter (albeit
one with a higher false positive rate).

> Another thought, would it be simpler to let user do this calculation and just let
> max_elements be number of bits they want? Then we could have examples with the
> above comment. Just a thought...

I like Martin's idea of keeping the max_entries meaning consistent 
across all map types.
I think that makes the interface clearer for users.

>>> +        */
>>> +       if (unlikely(check_mul_overflow(attr->max_entries, attr->nr_hashes, &nr_bits)) ||
>>> +           unlikely(check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits)) ||
>>> +           unlikely(nr_bits > (1UL << 31))) {
>> nit: map_alloc is not performance-critical (because it's infrequent),
>> so unlikely() are probably unnecessary?
>>
>>> +               /* The bit array size is 2^32 bits but to avoid overflowing the
>>> +                * u32, we use BITS_TO_BYTES(U32_MAX), which will round up to the
>>> +                * equivalent number of bytes
>>> +                */
>>> +               bit_array_bytes = BITS_TO_BYTES(U32_MAX);
>>> +               bit_array_mask = U32_MAX;
>>> +       } else {
>>> +               if (nr_bits <= BITS_PER_LONG)
>>> +                       nr_bits = BITS_PER_LONG;
>>> +               else
>>> +                       nr_bits = roundup_pow_of_two(nr_bits);
>>> +               bit_array_bytes = BITS_TO_BYTES(nr_bits);
>>> +               bit_array_mask = nr_bits - 1;
>>> +       }
>>> +
>>> +       bit_array_bytes = roundup(bit_array_bytes, sizeof(unsigned long));
>>> +       bloom_filter = bpf_map_area_alloc(sizeof(*bloom_filter) + bit_array_bytes,
>>> +                                         numa_node);
>>> +
>>> +       if (!bloom_filter)
>>> +               return ERR_PTR(-ENOMEM);
>>> +
>>> +       bpf_map_init_from_attr(&bloom_filter->map, attr);
>>> +       bloom_filter->map.nr_hashes = attr->nr_hashes;
>>> +
>>> +       bloom_filter->bit_array_mask = bit_array_mask;
>>> +       spin_lock_init(&bloom_filter->spinlock);
>>> +
>>> +       if (!(attr->map_flags & BPF_F_ZERO_SEED))
>>> +               bloom_filter->hash_seed = get_random_int();
>>> +
>>> +       return &bloom_filter->map;
>>> +}
>>> +
>>> +static void bloom_filter_map_free(struct bpf_map *map)
>>> +{
>>> +       struct bpf_bloom_filter *bloom_filter =
>>> +               container_of(map, struct bpf_bloom_filter, map);
>>> +
>>> +       bpf_map_area_free(bloom_filter);
>>> +}
>>> +
>>> +static int bloom_filter_map_push_elem(struct bpf_map *map, void *value,
>>> +                                     u64 flags)
>>> +{
>>> +       struct bpf_bloom_filter *bloom_filter =
>>> +               container_of(map, struct bpf_bloom_filter, map);
>>> +       unsigned long spinlock_flags;
>>> +       u32 i, hash;
>>> +
>>> +       if (flags != BPF_ANY)
>>> +               return -EINVAL;
>>> +
>>> +       spin_lock_irqsave(&bloom_filter->spinlock, spinlock_flags);
>>> +
>> If value_size is pretty big, hashing might take a noticeable amount of
>> CPU, during which we'll be keeping spinlock. With what I said above
>> about sane number of hashes, if we bound it to small reasonable number
>> (e.g., 16), we can have a local 16-element array with hashes
>> calculated before we take lock. That way spinlock will be held only
>> for few bit flips.
> +1. Anyways we are inside a RCU section here and the map shouldn't
> disapper without a grace period so we can READ_ONCE the seed right?
> Or are we thinking about sleepable programs here?
>
>> Also, I wonder if ditching spinlock in favor of atomic bit set
>> operation would improve performance in typical scenarios. Seems like
>> set_bit() is an atomic operation, so it should be easy to test. Do you
>> mind running benchmarks with spinlock and with set_bit()?
> With the jhash pulled out of lock, I think it might be noticable. Curious
> to see.
Awesome, I will test this out and report back!
>>> +       for (i = 0; i < bloom_filter->map.nr_hashes; i++) {
>>> +               hash = jhash(value, map->value_size, bloom_filter->hash_seed + i) &
>>> +                       bloom_filter->bit_array_mask;
>>> +               bitmap_set(bloom_filter->bit_array, hash, 1);
>>> +       }
>>> +
>>> +       spin_unlock_irqrestore(&bloom_filter->spinlock, spinlock_flags);
>>> +
>>> +       return 0;
>>> +}
>>> +
>> [...]
>
