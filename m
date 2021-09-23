Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3019416800
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 00:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhIWW3l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 18:29:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29436 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239507AbhIWW3k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 18:29:40 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NLavkL014456;
        Thu, 23 Sep 2021 15:28:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nuZD4rfB5EHbd0RWKBdjhoYgcPIvuvK9MEXIofbnlKc=;
 b=mxCw0Ty3ZsRM+KbivH7FEM459RGyvtBzSJkkru1jhS3SwbN9oq4rJbzIkYfhOtUB2Hi7
 SxegTTqjlV1Ett6scWRlfGKCgEUot792/BVgmrxj4hvdNdhhKoxItBbRjm0ZWAfxCntL
 SUX0eW93eKEZfsiBoqGgb2CYYwv3S+EovJs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b91na88mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Sep 2021 15:28:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 23 Sep 2021 15:28:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibod/RCQ9OtWrcrLzFGC6dTJm2y1NFegQ8JAgKgtf2AUWx3VvNcilWuYFKuzUsgPHEzwaAO0OgE9QMQsMCx3GI3ebba/ezafioCvTh54INPxAXQseB/38ErjRbgwlnoq15faJHyzGeACY5QMBkLJGkkHzHT+IWQyyaxqBvD/XWNHWH9N/mwxmXbxqKv9yZGIVqRovsiARX3gJlAbUgQesGznTLX2L5PbMa+BFOycYkQe7qMwnlLJhNYDfLWNKKgyPmTV5Q3vmtii+1TgDMN1d37B3NL7xfVadmQhDgkOJGWScso/qb0TjbR/L+N4wSGSCL5FzJPnZXA1/XZPL2RpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nuZD4rfB5EHbd0RWKBdjhoYgcPIvuvK9MEXIofbnlKc=;
 b=lvywoL/CYwJKpg2IND27vTPtss8EBHtItumqqlyc8zaE8nH2Stu4zfVwCyrOSc1mwe6GL1SFKI8q61TMjl3u93oKCjCzhqDNcPkwIwMIr4fOkMRXOF0ICfce1VkqwfAHzEIF+qSiyKDXf4jdS7uQXPMi9F8ciYpMRJ+7kq5w6U1NYLfPDvFn8LAMERbs/DazqGpQR7u2H7HZOSPfAowDJmbkmXoHveSiKVmSQK3jWHsWmEYj0Sg26+3KJyw+wEUhif38lnnr6SwAvLATQaV+FZRLtgRbH7gS894qqrdv4ne4vrt9gPy9lWfiWYIqmXyGJ5dQMoQ20sY/nS5ieuFKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 22:28:05 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::1d1a:f4fb:840e:c6fe%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 22:28:05 +0000
Message-ID: <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
Date:   Thu, 23 Sep 2021 15:28:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
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
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0079.namprd02.prod.outlook.com
 (2603:10b6:208:51::20) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11e8::182d] (2620:10d:c091:480::1:6fe1) by BL0PR02CA0079.namprd02.prod.outlook.com (2603:10b6:208:51::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 22:28:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e69417-bf64-4bf2-feb4-08d97ee16985
X-MS-TrafficTypeDiagnostic: SA1PR15MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB50167B47D842B4E468A0E6DCD2A39@SA1PR15MB5016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3NWPXrabNQgX1bGfuj+Jn/43LnsjK7BIIiTtGv46Xwla2MvtfDLVR9gxkouZas0XLdjx+lCKEf9WTTOodleWhzjZ5b3J+Jz71z5cBGm96VzdHKupmuX6qCk1FF20zo9bzXYL4DUP2N+vThGW4Vhqoutt0FVVMCqXLzbQ1+jLa1HOkOMos+SP0zzVcP+tMCsH2VfwaAKgXT21mVi8ryJdrbBhy2BjAQ5Hik6Woxtn8P3sSgECDOxzhNL9DWhobkqRzBZPq1GUQ6XMwyj93lD2HW6Eulifj4+yzY2NDuNz1xu4njw2RGYKa/W6zmVZiD8P+rNQ5o73kdAoSJCnoNB+s2rWtH8bVjDmSjKc1DNhsNy7+QNyh8hDmhgJ7S3CDlb7/FbFkYIZQ1MU6UVqfY7g9mENPA4CRhepfgIVYA4Rpqlnxrguv/3olCFAFVg+y6vVDbgmPnT+7ubV0PH2FEP+4F+bLIY9REJfQcDdo5paegv+PR7vrb6faZM0rMn3TS/VHWHuy3NMr7wF0EnxoHYnfOjokWq+N4OgryrwHSkHOlTvJVQumbgPSw9eV3bEnKMXF14qBtnlwizqXzV2KaQr8EyaPmVWk8cSs7xXc4/NC/dOcZ3j3ujaCiecKK4sjfdXT3yoKr5e0KgQrEKQjhK1o++M8N5qr8d36RVT/L7EB0MU0wH8WKo0dd6g0xdJouaKyqOyNTNV339Z8HV9Q78rukKpPLMvBNuMs6gtX11mdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(36756003)(186003)(4326008)(5660300002)(38100700002)(31686004)(8936002)(316002)(6486002)(8676002)(53546011)(66946007)(2616005)(31696002)(110136005)(54906003)(2906002)(83380400001)(86362001)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWl3VDI0U2Jnd1RpTGxOb01JOVJmbXU3V3FqUjN0Z29adk5qcTh5ODVOY0Fn?=
 =?utf-8?B?OGhqVVFQai9QVkNpb25VRGZQTWVMdGI3UExINnFuVGh1QklKNHU5MUM1NERN?=
 =?utf-8?B?OUZRZzdEbWsyMElNMVZ3aDZqdHZqVlpsaEhoUXNrN3VqNDUzS3lHSEwvc2pS?=
 =?utf-8?B?eGVyTzhzYkh5RnNpL21NVzlnNnhRcThiRHZobkRnS3FYTi9URFZFaStCNHA1?=
 =?utf-8?B?THhJcjV2UUNRN1JwRFdVR3Z6eC83MDB2V3VqdDlNa1hZT091OG5aWmNBZVo2?=
 =?utf-8?B?ZFRMTzZVTFFzdkREeFdUbXRUSngvSXMydmhibEI0RHBwVWowbFBncmRJaSsz?=
 =?utf-8?B?SlRRdU16YnVKd2xRRkVBMEIwbGFzclhncTI0anpEekF5Qy9zOGtwcGo3bEpj?=
 =?utf-8?B?U2M5dVQ4cGp2b1NHOExsVHFMaW5SRFlvRENFdytYdkhpVHdBS3JucUwreE1Q?=
 =?utf-8?B?MzVybjBvQkRKZEo3dmI2ZjJ0azM4ZmpVWG5lVjI2MFVpYTdjMHdnOTlySU4w?=
 =?utf-8?B?UC9oek52R2JYV3RHQ1I4TkR4K1NMTlpBWllsVjc3OGsrODBVZjdDazRMWHRO?=
 =?utf-8?B?bnNlMmdkS29UVFZmT2tPTGFINW9SWmpONDA3RVlHeG1EUElYSDh6MFRlUmdw?=
 =?utf-8?B?dVcrSVlMS1VGQ0ExUXRWaExzSEdWL3BUdEE4TXUyeHVrSEdSL04zaHNnNzNU?=
 =?utf-8?B?bzl0SzhLVDBWeVFtQWg4VUlpTzhqTVZQY1Z0emxzM3BjbEVRR0JGYUlBbUdX?=
 =?utf-8?B?RmR5K0t0cldDOERUek5QbktheWo5ZFI4bVZ6ZUtzUE5CWG1KRng1WmpZZm5C?=
 =?utf-8?B?RVEzMjZRazFTWXZoa3ZBME1sNllnejV4VngzaEkrMmR0cXdlMDdIMVM4VkVJ?=
 =?utf-8?B?RlA2dDlWaXVHcWo5UXE1VWNPNTczeWpTUjV0MWErL2lJcGlXV29VUk1iTWtJ?=
 =?utf-8?B?UVJwN0ZGaGFjeGQxNURvUEp6TjNhZmdCRXVOL2RrTzkrRVRuRWhST1oyT0Nz?=
 =?utf-8?B?aFFkL1lpRXJuYmo3TkFHQ1NsVHI5K1VpYTVKYnZjUy96KzJFYTlyS3N6VVda?=
 =?utf-8?B?MGM0VEVpRnkxdkFLenFSeEdCRXlDZzBiMVY5NFJER3lPTHFIQUdRV3BPdzY0?=
 =?utf-8?B?YlpDRysrSFBSazQ3WnVOYlh5VVd2UWFYdEpIbEF6VlFtTldSQ1BWY3pKVU1z?=
 =?utf-8?B?bnE4QmpIRE1aRVM1N2NpaUhpRU1WOFluNytqUDNFcDdnS1ZYWHR2eWRscmxx?=
 =?utf-8?B?ZmhDM3BIUWRmUUtuSW92WDdQQlJFUysvNHB3K3lIQjR2M2pSTjZZdUh2ME95?=
 =?utf-8?B?RDBvRStLZE9UNVdORENtMUZUcS9La0owTzZRTjNJODhDdG5LYktWU1FNSVpV?=
 =?utf-8?B?dEdzeklKaEdZc2x3dko5UG1QZmJHVjdpRHF5UGZHOW9oaTFyaXVkYW82NTRr?=
 =?utf-8?B?bXNvdmtIVTc1QXBvSnVsa0RKbkd3RlFNcW1aOHAvUWc3dzN2T0QzdHJIVGFL?=
 =?utf-8?B?aS9ZOG95Mzg0ZG5aQmR5ZFFOTFhXaHRlMWZrMEFIT3VvSnhjbUpYUkFYZWM0?=
 =?utf-8?B?UWFOb0t1aVB6M2dxYWk0WGVjZDZIS0VHZnpFTEE4UGZxU01heWFvcG45ZTgy?=
 =?utf-8?B?SnBhbS9OR0htQk4vNWF0eDdVKzc4S2sxS2hyS2tQb1ZwUHZsaGs2Y0N3U3l3?=
 =?utf-8?B?V0ZOUmJ6VHlmUkhRYTAxRkFNWHM5NW1kUXM3ZFFwYTRnSU9KVnVTbUxNdEts?=
 =?utf-8?B?TFRXWmZ0c3I3SmpUUCt6dEdiV3k4NXdaeWEwMmxBMUo2TnFTM3RDSlhjb2Vn?=
 =?utf-8?B?Mk9TTjVaUVNGcDcyUWhkdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e69417-bf64-4bf2-feb4-08d97ee16985
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 22:28:05.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NELzSXHjFUIhvp7ecQy3gqV6S/Bn/a7QyP5WwxTcM4Bxk2e/18Jt1hKJ+brdyVCTN2UQEu6aIs2b2pDqUwqxHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5016
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: BmOCmEg44RnwYt7c9MfmDuK1IYu54KeU
X-Proofpoint-ORIG-GUID: BmOCmEg44RnwYt7c9MfmDuK1IYu54KeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_06,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230000 definitions=main-2109230130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 9/23/21 2:12 PM, Andrii Nakryiko wrote:
> On Thu, Sep 23, 2021 at 1:30 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Thu, Sep 23, 2021 at 12:42:33PM -0700, Martin KaFai Lau wrote:
>>> How to move it forward from here?  Is it a must to keep the
>>> bloomfilter-like map in pure bpf only and we should stop
>>> the current work?
>>>
>>> or it is useful to have the kernel bloom filter that provides
>>> a get-and-go usage and a consistent experience for user in
>>> map-in-map which is the primary use case here.  I don't think
>>> this is necessarily blocking the custom bpf map effort also.
>> I think map based and helper based bloom filter implementations
>> are far from equivalent. There are pros and cons to both.
>> For example the helper style doesn't have a good way
>> of query/populate from the user space. If it's a single element
> I thought about the use from user-space. I'd consider two ways of
> doing that. One more complicated but with better performance, another
> simpler but less performant (but in this case less performant is
> equivalent to in-kernel implementation performance, or still better):
>
> 1. Have identical hash function implementation in user-space. In this
> case Jenkins hash. Then memory-map contents and use exactly the same
> bloom filter code to set the bits (as I said, once you have hash, it's
> just a glorified bitset). This has the downside that if there is even
> a single bit difference between hash produced by kernel and
> user-space, you are screwed. But can't beat the performance because no
> syscall overhead.
>
> 2. Use BPF_PROG_RUN command to execute custom program that would set
> one or multiple provided values in the hashset. Just like we argued
> for BPF timers, BPF program can be a custom "API" that would avoid
> having separate user-space logic. Pass one or many values through a
> global variable/array, BPF_PROG_RUN program that would iterate values,
> calculate hashes, set bits. It actually should be faster than doing
> BPF_MAP_UPDATE_ELEM syscall for each value. Next proposal will be to
> add batched update support, of course, so I won't claim victory for
> the performance argument here. :)
>
> But yes, it needs a bit more (but simple) code, than if the kernel
> just provided a Bloom filter map out of the box.
>
>> array the user space would be forced to allocate huge buffers
>> just to read/write single huge value_size.
>> With multi element array it's sort-of easier.
>> mmap-ing the array could help too,
>> but in either case the user space would need to copy-paste jhash,
>> which is GPL, and that might be more than just inconvenience.
>  From include/linux/jhash.h: "You can use this free for any purpose.
> It's in the public domain".
>
>> We can try siphash in the bpf helper and give it a flag to choose
> I did bpf_jhash_mem() just to demonstrate the approach quickly. I
> think in practice I'd go for a more generic implementation where one
> of the parameters is enum that specifies which supported hash
> algorithm is used. It's easier to extend that:
>
> u64 bpf_hash_mem(const void *data, u32 sz, u32 seed, enum bpf_hash_algo algo);
>
> enum bpf_hash_algo {
>     XOR = 0,
>     JENKINS = 1,
>     MURMUR3 = 2,
>     ...
> }
>
> Note the XOR case. If we specify it as "xor u64 values, where the last
> <8 bytes are zero extended", it will come useful below for your
> proposal.
>
>
>> between hash implementations. That helps, but doesn't completely
>> makes them equivalent.
> I don't claim that implementing and using a custom Bloom filter will
> be easier to use in all situations. I think the best we can strive for
> is making it not much harder, and I think in this case it is. Of
> course we can come up with a bunch of situations where doing it with
> pure BPF isn't possible to do equivalently (like map-in-map with
> dynamically sized bit size, well, sorry, BPF verifier can't validate
> stuff like that). Dedicated BPF map or helper (as a general case, not
> just this one) will pretty much always going to be easier to use just
> because it's a dedicated and tailored API.
>
To me, it seems like we get the best of both worlds by using both of these
two ideas for the bloom filter. For developers who would like
to use a general bloom filter without having to do any extra 
implementation work
or having to understand how bloom filters are implemented, they could use
the custom bloom filter map with minimal effort. For developers who
would like to customize their bloom filter to something more specific or
fine-tuned, they could use craft their own bloom filter in an ebpf program.
To me, these two directions don't seem mutually exclusive.

>> As far as map based bloom filter I think it can combine bitset
>> and bloomfilter features into one. delete_elem from user space
>> can be mapped into pop() to clear bits.
>> Some special value of nr_hashes could mean that no hashing
>> is applied and 4 or 8 byte key gets modulo of max_entries
>> and treated as a bit index. Both bpf prog and user space will
>> have uniform access into such bitset. With nr_hashes >= 1
>> it will become a bloom filter.
>> In that sense may be max_entries should be specified in bits
>> and the map is called bitset. With nr_hashes >= 1 the kernel
>> would accept key_size > 8 and convert it to bloom filter
>> peek/pop/push. In other words
>> nr_hash == 0 bit_idx == key for set/read/clear
>> nr_hashes >= 1 bit_idx[1..N] = hash(key, N) for set/read/clear.
>> If we could teach the verifier to inline the bit lookup
>> we potentially can get rid of bloomfilter loop inside the peek().
>> Then the map would be true bitset without bloomfilter quirks.
>> Even in such case it's not equivalent to bpf_hash(mem_ptr, size, flags) helper.
>> Thoughts?
This is an interesting suggestion; to me, it seems like the APIs and 
code would be
more straightforward if the bitset and the bloom filter were separate maps.
With having max_entries be specified in bits, I think this also relies 
on the
user to make an educated call on the optimal number of bits to use for 
their bloom
filter, instead of passing in the number of entries they expect to have 
and having the
bit size automatically calculated according to a mathematically 
optimized equation.
I am open to this idea though.

> Sounds a bit complicated from end-user's perspective, tbh, but bitset
> map (with generalization for bloom filter) sounds a bit more widely
> useful. See above for the bpf_hash_algo proposal. If we allow to
> specify nr_hashes and hash algorithm, then with XOR as defined above
> and nr_hash = 1, you'll get just bitset behavior with not extra
> restrictions on key size: you could have 1, 2, 4, 8 and more bytes
> (where with more bytes it's some suboptimal bloom filter with one hash
> function, not sure why you'd do that).
>
> The biggest quirk is defining that XOR hashes in chunks of 8 bytes
> (with zero-extending anything that is not a multiple of 8 bytes
> length). We can do special "only 1, 2, 4, and 8 bytes are supported",
> of course, but it will be special-cased internally. Not sure which one
> is cleaner.
>
> While writing this, another thought was to have a "NOOP" (or
> "IDENTITY") hash, where we say that we treat bytes as one huge number.
> Obviously then we truncate to the actual bitmap size, which just
> basically means "use up to lower 8 bytes as a number". But it sucks
> for big-endian, because to make it sane we'd need to take last "up to
> 8 bytes", which obviously sounds convoluted. So I don't know, just a
> thought.
>
> If we do the map, though, regardless if it's bitset or bloom
> specifically. Maybe we should consider modeling as actual
> bpf_map_lookup_elem(), where the key is a pointer to whatever we are
> hashing and looking up? It makes much more sense, that's how people
> model sets based on maps: key is the element you are looking up, value
> is either true/false or meaningless (at least for me it felt much more
> natural that you are looking up by key, not by value). In this case,
> what if on successful lookup we return a pointer to some fixed
> u8/u32/u64 location in the kernel, some dedicated static variable
> shared between all maps. So NULL means "element is not in a set",
> non-NULL means it is in the set.
I think this would then also require that the bpf_map_update_elem() API from
the userspace side would have to pass in a valid memory address for the 
"value".
I understand what you're saying though about it feeling more natural
that the "key" is the element here; I agree but there doesn't seem to be 
a clean way
of doing this - I think maybe one viable approach would be allowing 
map_update_elem
to pass in a NULL value in the kernel if the map is a non-associative 
map, and refactoring the
push_elem/peek_elem API so that the element can represent either the key 
or the value.
>   Ideally we'd prevent such element to
> be written to, but it might be too hard to do that as just one
> exception here, don't know.
