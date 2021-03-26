Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1480834AB50
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 16:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhCZPSZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 11:18:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230224AbhCZPSR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 11:18:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12QF8WLx025734;
        Fri, 26 Mar 2021 08:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2V91UNk5Yx3yDrkd+SB4gY5pmScOARBIp7Rh9Tfk9TM=;
 b=TCXdRlbjdFg0KwjmPe/zVUmgfsnZG/+7kqc7iGzox2q0CgYXmoga7Jg1vgh8hdhe+olM
 40vklYFKr5ybRdQyFAAge39wEr2ggQuuH7zey5qPdyu/Z+9rWgRu+4l7mEmd7z8CPm0A
 CCc8yOg2teqlkiEdzyIPDAt3vBHU4lZMNXY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37h15tmpke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 08:18:13 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 26 Mar 2021 08:18:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyH7EuNBU3FIsuraM3JxihK1ddfOjPgNmkdzYxDyzUlDkcr3anPaYgtEAlR2SksrHWBCDOw1w3Q+Pw5zrjcLeQbbWodxV3Tv7Ypp9O+fRCdXXjoQedBvjlYvbQXQDkN3N5txgxe0Ks7EMDhuUf91dofcr0xfBZttPNYxWcN0sQn5qQgs7q2LEwo/ZvH/9rOW+lkosPMWkte+WNYKZ91VFityZL6dxIyHQHh35fbr/p+QGsnAVDOgGeakhktEqlZNBn98R3OmGcUm4L6uUEHQBvctVoJxDxs4r1X5XkX35v0eatsC0Gm55rCoERk81Q293FpYj4aop23k8PY7TIFj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V91UNk5Yx3yDrkd+SB4gY5pmScOARBIp7Rh9Tfk9TM=;
 b=AcRH2kO91uJ5reZ09r/IRAx/p3gD5eOl195wLv6bZJBgzbkrYKNgn+tlIVqYqhdm2/D7o2mIRJ3/E1rKBlP/WiOZVLqtGGMFEBz2+beRAP4nIgk1SXoCr0yVISFmFBWbAgnap/cc4VacJUndkvH2F3HbJIJUhbJoUzbtmfmu4ixs48kDkT9owcRBCBJc6XJukSkDwXgBw8wzx1tJCQAaHwforJctcZsIpBEX5VpOovTdkDibBMQErMClS2hXJEJ2yKwz7vX+xa3ZSQ962I7hjKUYHJbqIJaoYxJaIdYwdXQr/ryDXDxJcCMMQ9ZxCPzIYfJlckT3qUB+y5dw6JYDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4435.namprd15.prod.outlook.com (2603:10b6:806:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 15:18:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 15:18:11 +0000
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065332.3122473-1-yhs@fb.com> <YF3ynAKXDCE0kDpp@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d618edb6-e4c0-a260-905f-e07720746594@fb.com>
Date:   Fri, 26 Mar 2021 08:18:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YF3ynAKXDCE0kDpp@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:8ff9]
X-ClientProxiedBy: MW2PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:302:1::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1337] (2620:10d:c090:400::5:8ff9) by MW2PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:302:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.2 via Frontend Transport; Fri, 26 Mar 2021 15:18:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5829bce-c691-4fbe-db80-08d8f06a5e1f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4435E9805DDC98EA8D4F469ED3619@SA1PR15MB4435.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvv48GvTWF/9gWhih5T5F+npW444BOOeTKZIbdh96kypVYCWvrdCT+YjV3AR2bw0a7g5tGyZSg7U91nL05EgxWM6MPWOMCrMXcVM0TfVftuCAlS/AtvlkZVd7zaa371Dtuld8ARiht8QOBjpu+6FAx+CUeU6X//Ldu/TvAwRf+4T/bOmoWbhMD78rdI63GtvNFBd/gypjXDXw+zwndbvFes+o+HTbrYfMeJOwHDrP+g8ey8YlX4ukBctlH2evyPKfIMddspXxQZC6G1tyANbiaYh5XwRWJXDV5TfEx4KQEbv/GllBptHwNz46TRx36QPdG4EG2Y44vnLkkldq+HNsxfvw3np58fD10zHjqUle/x1a9bFP0TPnPkHcdG+dsAFdXNgblA2e/VoOqkgqhDu4YZtRFB435H22by/kx9MWgfe2iINPB85q2SguvsTDI+QBdzWurjsCQoheN/kRYgeFh96/CmK0Ie1GNBXELV010s0N9yn30Vn+m1AIXlWjM4VTr3zT72eJymTJbdaDWdlRiBwBE2MigeL/50bsiqxmf2YMmPYRCg8jEEmvSrwqxX1eH9Mcu8ffkgqiOXAqrAw2UOVOINaqvAn60bwkKrDzPnSUqVn3hH7lXsurtHiDvcKRwtWOI/D7WRfOXUU/Cnx+3QsDWOdYuEcdxeFPWtt0QGyxzwG47yfTYlKdXbqMTagXnn52Dm3ZuqDMfRX4Se6d8hhsUsh9vcfsGjua3EJGkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(136003)(366004)(53546011)(36756003)(6486002)(31696002)(16526019)(83380400001)(66946007)(31686004)(186003)(8936002)(66556008)(4326008)(52116002)(2906002)(5660300002)(6916009)(66476007)(316002)(8676002)(54906003)(2616005)(38100700001)(86362001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OHozNUs1SGNmbWlxMmViTXRkeWtQU2hZVmVScExkU3lCWkhXSHByLzdDKzkw?=
 =?utf-8?B?Y3ZBa1p1bm5xT3l6RE4yZWdSQnBPVUk4c2FFSlVLdnAwRW5HcU1CNzZsUlhI?=
 =?utf-8?B?c0E0Wkp3SkYvamp1TFZQWEsvRkFMcGRZTmlISXBtdGYxbVVmOG9FdENQZmVq?=
 =?utf-8?B?Sm9HYWlYYU9pTGVHb01icnR3YkJyTUVsMDRMdndpSVhmQWFOVGNZdVNSV3dM?=
 =?utf-8?B?Tng3LzhCREhXZGpURnZRc0ZQWnJsVDVQdjJmdWZuU1hMTy9QMjZ6RWV4K2Jo?=
 =?utf-8?B?aUNRdU1KaHVEbHpLQVFOSEt6Ymo4aTNZVk14TTh6NzAyYkZpenIvUG5wVDdZ?=
 =?utf-8?B?UExDZmhCaHZ2M2JHd25lOEh1d1VlK1pjbWpnMHhaU0c0ZkVSak1nMVlTZllD?=
 =?utf-8?B?dzc5MFJnSStTL1VRcFRaWElRN2hhWjdyUjFMZnJDWlNuMWZIbXhDd1lkcG5T?=
 =?utf-8?B?bUxkMkNmWlhKUGRNNUdrTlRucERtN25CaE1kSmdPMHFuVFZNUzNweU5LRFl6?=
 =?utf-8?B?QS9uRy8vZnc0SFUwZXlNS283b3U5L3BlZTNBT1Byb3hwYkJHNk9NNUdya0Ft?=
 =?utf-8?B?WTBpNWpIWGJmQ1pZVUpIQ0N2VlRUOFFLSEkvcndPbmd4WVR0OGNoV1NDSXNL?=
 =?utf-8?B?VjduNWtUTU4ydU54RXF1QjhNZnBoeE5LQWtBODBnSHBVS1F3M0tHVGRyUXFG?=
 =?utf-8?B?dlZLU1pNMWl4QVh4VTJMV0tFeTNJUDhNMWVRVnVsaWhiVjBzUVlwNm5CV1Rx?=
 =?utf-8?B?M3ZrM2I4ZE4xY0lrRU9QSUJzd2kweWl6T3JCa21XUkU1UUxlRFJxa3VnUGRM?=
 =?utf-8?B?cmhHSCtGYzlmUU13U1grM3J6S2M5cktqUDRuNHVBK09JVjcyVFV5MUkvejlC?=
 =?utf-8?B?dFRmdDlGZGdSUFhzczcrSXZPZndtYkJrSlVlTFcramJsTDlhV1UydEZoK21N?=
 =?utf-8?B?ZUZ1a1BlUk9JTE1vcWpobzloT0ZqejBWeDhFRUVwaTYvUWUwYmljcGxRUnpo?=
 =?utf-8?B?UUoybGgzcDlNQXdObC85S0FER1hWcnlPMm9YaWI0VTZuN0xWbjJiQ2VVNkVi?=
 =?utf-8?B?c2s2MndEc3dxYUE2eCtUcFVZc0FvS0Q3aUVsMW9sbk1CQld2b0hOMU4za0xu?=
 =?utf-8?B?N3d6UXlpbUJTUXJ1MnFWSjQyUElCRkh0NDQ3YlJ4aCtMMjBMZ0NGSS9DdDNV?=
 =?utf-8?B?eFBVbXptMDF2a2UwWWluM1hXclN2K2pBU3RQek1TbTFPdWlQa25pM25XN0Vx?=
 =?utf-8?B?a2QxTE9lVkplY3RUQ0tjNXg5UnpTTzMvRjlKdEtaKy9Gc0lRUDM4Um1adUVs?=
 =?utf-8?B?T28rVnY0ZHhDcm5wNmgrOXhsSEN6M1ZsQW1kcjY2NllsMGVzR09yVVVmUjZT?=
 =?utf-8?B?dmNHS3M5RGo2OEhoM3RkR3VwMURPeGpyaklXVDhSbTBWbmRHa09wa3BUZzZH?=
 =?utf-8?B?YTRUVGFyNzRUM0FiMUNQUTU5YVpQMEFVaC9qNnhXY0hSRXJkSnRXVSt4YXE4?=
 =?utf-8?B?SnR1VmxiQ0NJb2x0QStJWW1adFpPOVJUM3V4L1FtcUxraTVBWWQweU1yQU5S?=
 =?utf-8?B?VXN1blJEQVIrTE5NeDJBYTlJUUpqa1JnMHV1V3RXeENrTmdnZHdjSFQyTFlo?=
 =?utf-8?B?NUtEeTJ5NSsxZXpVQUpNdFZkbk9GeU5rZVZpM05GcHlSKzU1RjE1Umdhb2Ri?=
 =?utf-8?B?dFFidWcrUmVTczVETStlcVRjNS9PdkJBdUs2Vjc2cWJ2UWhrRHJkUHQ5bGtv?=
 =?utf-8?B?TDRsVjNWaHIrYkV2SWxTaUR4NTVqdHQrQW1NOFowRmxyNzAwcXk4bnA2TFNK?=
 =?utf-8?B?dkR6d3RoRXhlY1kraVlXdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5829bce-c691-4fbe-db80-08d8f06a5e1f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 15:18:11.0540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGRKECQG3ijbTYZDPCg7jkhSVebIgVFzZWdmj2PzWGc6E3YzImpgIxwrZOncfUfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4435
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: F-KBSOfaNsu9wCawEM9QOK-t4EREUeTv
X-Proofpoint-GUID: F-KBSOfaNsu9wCawEM9QOK-t4EREUeTv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_06:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103260116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/26/21 7:41 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 24, 2021 at 11:53:32PM -0700, Yonghong Song escreveu:
>> This patch added an option "merge_cus", which will permit
>> to merge all debug info cu's into one pahole cu.
>> For vmlinux built with clang thin-lto or lto, there exist
>> cross cu type references. For example, you could have
>>    compile unit 1:
>>       tag 10:  type A
>>    compile unit 2:
>>       ...
>>         refer to type A (tag 10 in compile unit 1)
>> I only checked a few but have seen type A may be a simple type
>> like "unsigned char" or a complex type like an array of base types.
>>
>> There are two different ways to resolve this issue:
>> (1). merge all compile units as one pahole cu so tags/types
>>       can be resolved easily, or
>> (2). try to do on-demand type traversal in other debuginfo cu's
>>       when we do die_process().
>> The method (2) is much more complicated so I picked method (1).
>> An option "merge_cus" is added to permit such an operation.
>>
>> Merging cu's will create a single cu with lots of types, tags
>> and functions. For example with clang thin-lto built vmlinux,
>> I saw 9M entries in types table, 5.2M in tags table. The
>> below are pahole wallclock time for different hashbits:
>> command line: time pahole -J --merge_cus vmlinux
>>        # of hashbits            wallclock time in seconds
>>            15                       460
>>            16                       255
>>            17                       131
>>            18                       97
>>            19                       75
>>            20                       69
>>            21                       64
>>            22                       62
>>            23                       58
>>            24                       64
>>
>> Note that the number of hashbits 24 makes performance worse
>> than 23. The reason could be that 23 hashbits can cover 8M
>> buckets (close to 9M for the number of entries in types table).
>> Higher number of hash bits allocates more memory and becomes
>> less cache efficient compared to 23 hashbits.
>>
>> This patch picks # of hashbits 21 as the starting value
>> and will try to allocate memory based on that, if memory
>> allocation fails, we will go with less hashbits until
>> we reach hashbits 15 which is the default for
>> non merge-cu case.
> 
> I'll probably add a way to specify the starting max_hashbits to be able
> to use 'perf stat' to show what causes the performance difference.

The problem is with hashtags__find(), esp. the loop

         uint32_t bucket = hashtags__fn(id);
         const struct hlist_head *head = hashtable + bucket;

         hlist_for_each_entry(tpos, pos, head, hash_node) {
                 if (tpos->id == id)
                         return tpos;
         }

Say we have 8M types and (1 << 15) buckets, that means
each bucket will 64 elements. So each lookup will traverse
the loop 32 iterations on average.

If we have 1 << 21 buckets, then each buckets will have 4 elements,
and the average number of loop iterations for hashtags__find()
will be 2.

If the patch needs respin, I can add the above descriptions
in the commit message.

> 
> I'm also adding the man page patch below, now to build the kernel with
> your bpf-next patch to test it.

Thanks for adding man page and testing, let me know if you
need any help!

> 
> - Arnaldo
> 
> [acme@five pahole]$ git diff
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index cbbefbf22556412c..1be2a293ad4bcc50 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -208,6 +208,12 @@ information has float types.
>   .B \-\-btf_gen_all
>   Allow using all the BTF features supported by pahole.
> 
> +.TP
> +.B \-\-merge_cus
> +Merge all cus (except possible types_cu) when loading DWARF, this is needed
> +when processing files that have inter-CU references, this happens, for instance
> +when building the Linux kernel with clang using thin-LTO or LTO.
> +
>   .TP
>   .B \-l, \-\-show_first_biggest_size_base_type_member
>   Show first biggest size base_type member.
> [acme@five pahole]$
> 
