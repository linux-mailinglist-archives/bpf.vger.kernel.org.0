Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E29403D61
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhIHQLk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 12:11:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21884 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230091AbhIHQLk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 12:11:40 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188G4hXJ020185;
        Wed, 8 Sep 2021 09:10:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=w/JrOnXkQr4ItHDscuzlB8DHvVslN93MrQ7XE1E9Qhc=;
 b=nXuy4Qwzisl7zzRSoYzVUCr/1Ugc6XAZlqm2Qq8S6DmhTUfuuqeggiid7tFweo/aZ7Hg
 q5ncpZ6SKXtbM6v2eqGIaXdsgeZKeEWyHcmFlySnUQYu+NihPgMs8/akUmxLqkF8dQVd
 Ju6CRWrSRNFI0KrDZ0VJfqVqZsj2GMf1Ey4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcnbemyp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 09:10:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 8 Sep 2021 09:10:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4kF4bFPeX8iG8cQQFL9VQ6rd94UDIYKJIANHariN4ze2HPQVJcb6z1tn70cS27grwPTo9FHNZhS4WZhIZhEwPfamcxtZiLl5umMo846L3kEGhttEOY2REhahZI0sxUtNMewf2p8sK6dDWqhdxHJp3FHI3P2e1GxE4+SZ8QbVKEqWUn4nDhgNS0nFm/Ir2OJq0ISVSdwWm9IYoM+4swQtxjYGG7+1TXryTjsIYOwTYYjHhUkhExOhAeFAxAFBxoR0q/9e/1tc+A+J7rJAcFzBhh82tZb2IfJOJsfst0iUOOz/BveSe1rdmTH9bEBt8kie6TiOJhYkmFywK/YbfDpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w/JrOnXkQr4ItHDscuzlB8DHvVslN93MrQ7XE1E9Qhc=;
 b=avkdwcNdGAhiJf4s00Gferw/ypBfxbp0G09Zorrpk1awxY/D60Fj6N5qcnuavExJ7afm8SGraJ7BOGqT/btxOYi3buKU/ziGvRA10wW3gBKXe1PQ9KHJNkicF9YuqoLtlS4H5+KIAsGvZeHK1Xw4XHpHudK4K5kNSPI6lS4qywnCSOV8lpZE1jeAAOnsorik0kKLyXMlIPCUczhsbaVZSmqX7Ciki0MuuBwAZJTqs/n9yO3uzv63rntO9Dfh+UQWC6D9ADt5i/Py/foYtc7ipRG+ydqXsG3ad1Ws4lpHoU/nsRN9zE5+E4SznaOE9RXB6rGb7ZyABgoE9CBbhftGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB3658.namprd15.prod.outlook.com (2603:10b6:5:1fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 16:10:00 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::80a7:bdbd:d33b:e03c]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::80a7:bdbd:d33b:e03c%5]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 16:10:00 +0000
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
To:     Liam Howlett <liam.howlett@oracle.com>,
        Luigi Rizzo <lrizzo@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michel Lespinasse <walken@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210908044427.3632119-1-yhs@fb.com>
 <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
 <20210908135326.GZ1200268@ziepe.ca>
 <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
Date:   Wed, 8 Sep 2021 09:09:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210908151230.m2zyslt4qrufm4bv@revolver>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BY5PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:a03:167::43) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
Received: from [IPv6:2620:10d:c085:21e8::18c1] (2620:10d:c090:400::5:f3dd) by BY5PR17CA0066.namprd17.prod.outlook.com (2603:10b6:a03:167::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 16:09:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875be233-4d4b-47e8-aecb-08d972e31c1e
X-MS-TrafficTypeDiagnostic: DM6PR15MB3658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB3658BCD3BE794D4393374BD4D3D49@DM6PR15MB3658.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aU3GD/WtKcfdx1r2kYUTeabIdj8RcDKkL6jUffc+Il6SslYO+MJeQADM/AT4Eb6xFsmDmvWJ54ZBBG1Ji4v7eYcdnYvqN7MEZNn/1nKSp9L95pUoNanfe+j9QcjE5hfSnoQahGcxeKVPoBjwca6yHe2hkD2vLpWyf71EM3IkKABpsalbm5oM4014YDgigvX4Z1vaGPrzmEYxzIeElyQtRw+8Xps6CwF0NyWWyOq7rYvqVS9GSKI7jg/0Y8WVSGlwDnuOrB+g/CK1Bt0MMZRbwHHv3SHQwffF++qwqGgMZMudfQH2JbECAc2stHQd4lxCvXX/BXjOU3e317Bz23mcUfaHXbU/k7qcbEkOiVQAHm47gV3nkc7BQA6qnl5B5NFQ5jRio5e9fTRV6pVDEEdT030A6hE7CMGENObb48XmCWjRd+AVh++1rDL5/M/obuwLTvLZ0nDhLmJxeebwXxs7qwdGJwctddawFKZ1fcmqCog5r0J/C91VvlgjwUf/UZAfhfK7s7BmzG40cBiX8nF5sRGluCWq1oEhY0/ocfUtBx2fWuMABxF+buT4FmzOB/PKW5BzQqXdRoATHD2gLm1mKKMcWRT2ofO0BLyDTeTgwqM3s08hMfoU8jW2NwrF42FFZ77cl6KOWKoXxDuRr46Zs+BHuOnnq0cjDyOSTGrN3E1z7jCK6KL2VP2yG8dLlYdlwHo36DL5ZDHIrwn90xFDKRh1d3Dm4xErWWjSubW1BixAZiOs43zJMggQqzskYBwIly3CIaa/Wg/AMAI0Tn3jXsBPbYZ5RGdlt1xEBmPfLfUQ0BEW0+GqyIf6Zna9oVNm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(5660300002)(86362001)(36756003)(66556008)(186003)(53546011)(6486002)(8936002)(316002)(38100700002)(31686004)(66476007)(2906002)(31696002)(83380400001)(54906003)(66946007)(110136005)(2616005)(52116002)(508600001)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVhJblZkRkp1d1QyZTVxM0M1azFCU2hKbHhNZkk2ZTNvRDNic2Z1ekxUU3cz?=
 =?utf-8?B?QTduVWU0SytHcE9NYVBva3FjVElqTGd0WkNLdEdQT1k0ejArb0hOc1hTUGJR?=
 =?utf-8?B?eWRUU0VFK0FrejMweGVXSmhJTXRhUjVySGwrVFdDMDRQRjk5S0U2bkJXU09D?=
 =?utf-8?B?cnE1VU1ZaE9jdllESG1ocFJaTmxYdTAvRzI1dGFUdHJxZzBqdmk4L2pvVmEr?=
 =?utf-8?B?NFlJODIrMzIrZnN2Rm5MMVJVZXNvQkpnb2w3YmxIOGE5WFRoeDkxeDVTNGFp?=
 =?utf-8?B?cm9JY1IrQUZsYlZ1ZkNjYXNwWGFsL2RSU3VTdlhobjR3ejlqelI0WGxkUmRU?=
 =?utf-8?B?VVFGNytyZWtTQ2ovV25qbFZGei9zbytUaG40THVEeXN5dGx6Ym1kODRKYVEw?=
 =?utf-8?B?aG1yQ1dWSTd4QWI4WG94bnhTWjJWZEFlaG5oeGtlKzhFTGl2aTMraHhXU0VR?=
 =?utf-8?B?Vk95YUpLTzJ4VVNSamhERElDeGVmTGFQaU9yVTZ5dnc4ZXJOcWc3MDhWbEk5?=
 =?utf-8?B?ZUcyNnhOVDlsYnlLeDA0ektMelJYTWdCbEEzdVpHRzhVbW1SY0I0RUV6ZzlW?=
 =?utf-8?B?dDVOaiszWGVGY2hxUjJaaVZKRlhEcWNmMktCV1EwLzVSTzdvMjVKRWxsak96?=
 =?utf-8?B?bU5rYThmdWxLcFdwTGtKeUlBYVB3MlVnVmtIQ3FzQk5meDY2VzBpUmN6K04r?=
 =?utf-8?B?TExIeW1vc2ZhOHVwcmhpcW9mM3JXTXhXN0srbFV4RFY4MHpvQnA3bXdsaCtm?=
 =?utf-8?B?Sml5aU03WDJpQmtDRjhDbFJCSGt2WnNSaHV1MzVkZXNQYzVpZXJVdTlSSjBF?=
 =?utf-8?B?MlJEeXZNVDVCeFU2bC9YZFN1eFNENzlyaTNhU3lpZ1RCeldjVDBTKzViVkFt?=
 =?utf-8?B?aDNNeDdUVXVxQjlsT0pXby9PbGdCNUN4NFoyY0ZMNUZONFF4UzhxbnE4aUxS?=
 =?utf-8?B?andUUERIV1BQQkk2T09MN0ZZVHZUS3BxNlNjR0VBNVd5ME1vdDBuR1VIeXpx?=
 =?utf-8?B?OHZTWVlJa3BkMkhodTFqMUpUNStzTHQyR3NuWjFXN08yaDNlMkFKdStVWlo2?=
 =?utf-8?B?a01iM3V0S2JzMnRjQ0xvTG5MM3dsc3lnNjZtQURyVWJuSFhOYVZNV3cyS0pr?=
 =?utf-8?B?SVFCbTY0czZIOCtFL0FTMStuSi94QWl4eHJQc2lzUmFRbGFoZ2pIcDRmYmZC?=
 =?utf-8?B?dEY1ZHU5eUhUcTByT1o4NERqaWV4QkU1RGhydG9za0grN2JGYmZKNEwzdHFK?=
 =?utf-8?B?ckt6U3MzU3hNajJ4Mk1XZFpLdWVXZlRjSnBuMzFNSGJMT1Bkbnd2cGlYMmJx?=
 =?utf-8?B?YlhnWFVlUnZSejQ1QVJDam93KzFTL1dta2h5c3phSS9mTDhSREMzRFIramNz?=
 =?utf-8?B?VnJoV2NMN2tnN0tjM3lzczE5STdLOFE5MTJOMFRnRVJVdGtsS1NyQ25XY0dR?=
 =?utf-8?B?Y3JDMVJGaklWS1N2NlhDQXJUUjBTalpDZ2hwOUlUNDYwOEsrcmdOOVFFbDRY?=
 =?utf-8?B?RHk1QlRRUCtYampHNGFkRStYWGdZYkJPaDYrOUVNZU1IZnpGUFViRUJrdjB2?=
 =?utf-8?B?ZDNXZ2pIWkhXSDZUZXdYaGlhRThSc1dMbVVDL2ZXbFJhc0JCQ2R5V2pSSGIw?=
 =?utf-8?B?TVhlK0dLWWlFTXhYTHZINlh2eDdHYXJVeHppQUNQQ0pqd3VTVWZQUXpPUnZn?=
 =?utf-8?B?TlBYYWhheUZ0ZWJ6eXgxUTQwaDFJbWFKSEYvdVJVUVRlRWx5QlJjOXNsUnI5?=
 =?utf-8?B?S0JoS3VpVkZsKy81RlFLSjkwVE4xTjJSYTFNQVpDZnBQWVFUbUpralM3djJW?=
 =?utf-8?B?dk1Bb1p3Q2U0Vk1rbWlyUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 875be233-4d4b-47e8-aecb-08d972e31c1e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 16:10:00.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FpOb6JJgfRqVRvDu+qtGGrwOJcybniv1ADa+xk5XwmuMym+yaIYvtTh2FQRf7Le
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3658
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: UnvDrf3tSweO2bwYnFVzdfnghdZAkf2r
X-Proofpoint-GUID: UnvDrf3tSweO2bwYnFVzdfnghdZAkf2r
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 8:12 AM, Liam Howlett wrote:
> * Luigi Rizzo <lrizzo@google.com> [210908 10:44]:
>> On Wed, Sep 8, 2021 at 4:16 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Wed, Sep 08, 2021 at 10:53:26AM -0300, Jason Gunthorpe wrote:
>>>> On Wed, Sep 08, 2021 at 02:20:17PM +0200, Daniel Borkmann wrote:
>>>>
>>>>>> The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
>>>>>> which added mmap_assert_locked() in find_vma() function. The mmap_assert_locked() function
>>>>>> asserts that mm->mmap_lock needs to be held. But this is not the case for
>>>>>> bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), which
>>>>>> uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
>>>>>> in bpf_get_stack[id]() use case, the above warning is emitted during test run.
>> ...
>>>>> Luigi / Liam / Andrew, if the below looks reasonable to you, any objections to route the
>>>>> fix with your ACKs via bpf tree to Linus (or strong preference via -mm fixes)?
>>>>
>>>> Michel added this remark along with the mmap_read_trylock_non_owner:
>>>>
>>>>      It's still not ideal that bpf/stackmap subverts the lock ownership in this
>>>>      way.  Thanks to Peter Zijlstra for suggesting this API as the least-ugly
>>>>      way of addressing this in the short term.
>>>>
>>>> Subverting lockdep and then adding more and more core MM APIs to
>>>> support this seems quite a bit more ugly than originally expected.
>>>>
>>>> Michel's original idea to split out the lockdep abuse and put it only
>>>> in BPF is probably better. Obtain the mmap_read_trylock normally as
>>>> owner and then release ownership only before triggering the work. At
>>>> least lockdep will continue to work properly for the find_vma.
>>>
>>> The only right solution to all of this is the below. That function
>>> downright subverts all the locking rules we have. Spreading the hacks
>>> any further than that one function is absolutely unacceptable.
>>
>> I'd be inclined to agree that we should not introduce hacks around
>> locking rules. I don't know enough about the constraints of
>> bpf/stackmap, how much of a performance penalty do we pay with Peter's
>> patch,
>> and ow often one is expected to call this function ?
>>
>> cheers
>> luigi
> 
> The hack already exists.  The symptom of the larger issue is that
> lockdep now catches the hack when using find_vma().
> 
> If Peter's solution is acceptable to the bpf folks, then we can go ahead
> and drop the option of using the non_owner variant - which would be
> best.  Otherwise the hack around the locking rule still exists as long
> as the find_vma() interface isn't used.

Hi, Peter, Luigi, Liam, Jason,

Peter's solution will definitely break user applications using
BPF_F_USER_BUILD_ID feature 
(https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L1193). 
So in my opinion,
the "hack" is still needed to avoid break user space application.

To answer Luigi's question below:
 > I don't know enough about the constraints of
 > bpf/stackmap, how much of a performance penalty do we pay with Peter's
 > patch,
 > and ow often one is expected to call this function ?

This function is called only if user bpf program specifies 
BPF_F_USER_BUILD_ID in bpf_get_stack() or bpf_get_stack_pe() helper.

> 
> Thanks,
> Liam
> 
