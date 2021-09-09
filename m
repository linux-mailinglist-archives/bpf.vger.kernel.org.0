Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1B40600F
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 01:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhIIXcM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 19:32:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63448 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232591AbhIIXcL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 19:32:11 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189NRnAR005372;
        Thu, 9 Sep 2021 16:30:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4O1UZ0PAMMwIQIaiKzWB0oEs0n3Pbon2jZVwgy+LaCI=;
 b=f+u6POlfNPSpqcir9ZeIaQJFHh9WpM/sHd8aTwzGRJZ+R/ffuSWg8aCfHBBKXuL3yzZa
 ViKa5Nq0+xDdcq3uWASH018J4VQTrGAZYgiG08ZNihH65ixoLEkxydTXnL3l8aJQu/6O
 mPno9xuf3WZAXfG3/IKMzPTIVlIjBBeiWYM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytffrh00-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Sep 2021 16:30:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 9 Sep 2021 16:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBjNsQGJN1Qfyi5W3ZdhD2G03JKwodUh67TYVrX3AjcWQNZhc4cgNlAnzoip2ySfF5EIheaNxlRF7UitHlMobUnSrP79Qc/w5dfeGQXw0Lphgzy/P3LVJ9BOiMsB5IxxMqpzdHq8onVWzVWeDOmAnssi/1e2azhbdhVllPATPTtqwtnUru9wUX2FTgVlLIkDgy2kss1nkh91EIIkRQh+Ee2CAB7zhElCtxKNLMPoWCAtIWw3q6JgLRrRPNG7mdmr74cdjjtZ+gIEy9ORs6SFeEIfFsbIPRHhpqLSO7SF9JVsmgT00vQzacNKlN3JHEVDeSd5S9MBadGUO98L0e2d4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4O1UZ0PAMMwIQIaiKzWB0oEs0n3Pbon2jZVwgy+LaCI=;
 b=nCVMLZRAOVNkU19egXdZu5P34AE0Gmlth3O2jyaT0Wn+wl65sWSWFz/FUA2+7QHAnzBXhv2aSP0laQSUGs5GxBRLSZUaAV73kJ6MXLihmP1X6RHlQC9l0bzoPyR7QyPESMPwuo8+spUwHStbnVXPeppdV/ElJ3wkIR/dBJLYzD9xdvUcoFPiC1JAqCpwkzLkk2Z/vboEvsl4CwRBy5I5cLbLfDMx4bbOCaaCWpYCE1yZ98UhiSVc3M7e3rD09fShhrKtTbMBwWantgPz/T6ifB4zhq97J4554eBRaqe0T6+wEiaOJo2EbUz3kxyXpNhnkljeVpOHdFdQn9wvqd2Prw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4240.namprd15.prod.outlook.com (2603:10b6:806:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Thu, 9 Sep
 2021 23:30:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 23:30:43 +0000
Subject: Re: [PATCH bpf-next 0/9] bpf: add support for new btf kind
 BTF_KIND_TAG
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <david.faust@oracle.com>
References: <20210907230050.1957493-1-yhs@fb.com> <87a6kl8j1j.fsf@oracle.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e79ad277-9f26-1169-6e31-57d0b70d89d2@fb.com>
Date:   Thu, 9 Sep 2021 16:30:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <87a6kl8j1j.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:fa35) by BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Thu, 9 Sep 2021 23:30:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdedae96-c1cf-495b-3ecd-08d973e9d76d
X-MS-TrafficTypeDiagnostic: SN7PR15MB4240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB42404D3967E8C2BFF875DA54D3D59@SN7PR15MB4240.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaNbeth//tP7R77bF0/k3YE40DUMzHEelPAHiU+SwUNVzH0vRr8arIstmGmfD0O4F9TnTPbv/nx7Xpf7zQveY7ACpz/MNCw+rsDAuPzm/lme1iTzLc/oM+G7Fqc5oxlsHFeit7jrKa6TqFnMz1uDgdVLIgcs315YkIoPV8HsDL915i/ohF2z8n3G06V4wRvPW+ibm8KqZh7mDrqZ8kORqli58c3K8Hks4uMmYwDhPP6gYp9itHjXNhSKIM0mz112B//jGdiBbUJLoIveHpt2rOIgu1bdFPBIUFsv7bC6zgYLxec9iMXQE5VIH8CmiKAEPRFUhbSiYHnknk4iCQNYyo75B8djRcJR/eO5Lte+n1LWTB85foH88dp60jWBN2i+7nXP4JxMHtC4RF16xgeZLMmRMZ1LSTMG5D1o8iL1f+JWnmA3bBNk37iUXQgQS/EqB24+adRg8Ql5z2h9ZYxs4xa9ih+t5uts6YVnkkMtMg3uvuTRUgm17Q5ipN6YzhlCzvq4nTVl4Wm5Z2okurOux3DrqwJA7+QmPAtPOdbNW5Q0wovHNty5pfuLTZI9Hf2l5uvfR6NfiySc6uQpN/2Grs/7q+8BCsrTBj3cuuTWGkBZHjdDF45n2keTBrlLDtMjl2/5NOu7BgDsYnDePh7pVSOaMiFeFOsExtM7z2zqUOFs4kEI9hBIzYrIve20rqtWY2+zHHEAOi4lc+p5Q09nmEG9BiwYDlbDALzERAxvIzNC90NELVK7WqKa2LC16PxKxYOVN1KD+n34xycCyBiA7v1PeQD1lMQ6kWSJXflQwGwp9quIiZ2FQKbcZu0jo0mW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(54906003)(966005)(4326008)(31686004)(6486002)(8936002)(53546011)(86362001)(2906002)(38100700002)(316002)(8676002)(2616005)(52116002)(31696002)(83380400001)(5660300002)(478600001)(66556008)(66946007)(66476007)(36756003)(186003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEhSclBQcVl1ZnN6ZmVJOG1qdUo2ZW1nZDlDakYwZ01Md0drZnhCY1BRRElL?=
 =?utf-8?B?N1VCdGRKQ1l1OVdaaHB3cnF4ZVgrdWFvYm1XakJQaE0rNGlFM3dTZnlTVmhZ?=
 =?utf-8?B?dVVRclhtOW04eWp4UFhNMkpIb05ESEs5TDdkc3ltR2FscnpaSENyU0x2UVp5?=
 =?utf-8?B?djZTMFc5M1NqSDkzR2pScis2VXV6K3J0b3pudkNkRG9GZDJnaklzcUlXZ0Fw?=
 =?utf-8?B?MWJSMmdadTEySE5EZmRDdUJKUXJzekNSdUR4bEY0OFJFd0hFYkZsRGFRTFlx?=
 =?utf-8?B?YlMwak8renRxTU14VU84cm1hdWk3K0kvS0JBaEFPUzR5N2VUaVFYbHhFbG1N?=
 =?utf-8?B?Q1owZDdQdHcyUHoycXdjbnpNQ05SdytQbW95UFlYcGVXS2h4SlRkbnlZWGcv?=
 =?utf-8?B?VHgwL3NXQW5lUDVqeXlpR3pSa0dBdGxnYm5jMnZoUllFcGNCd2JOWEFlbWhh?=
 =?utf-8?B?VWhmQU5DS1MwRnVIV2tQTCtEYzRXMGo2NlRzTGRwemRPb3lkMWJqNFdrUUxk?=
 =?utf-8?B?T1RFemwyWGl4OVJpb2pTVG5YbjJjamV3RE5RS0hHc1AybStXcmdwK0Z4dVg0?=
 =?utf-8?B?NXh3dVJmemxIY1ZuT0hIZ0xnMUhQRzZWM2FNbWRPQ3pjaGtIT0ZDd2hvYlZM?=
 =?utf-8?B?Sndkemp4QXkveVJqWXpUSHd0M0oweEJNNXo2cEdRZ0xlYU5jb1Y1aGE3UFFK?=
 =?utf-8?B?RkhybTk5MEx4RFJweVZGang0UWVaU2pLeTdRRjVCY1hsRFNVUWFBRHBPeFQ3?=
 =?utf-8?B?ekswK250aEpqUzdORDc2OU9zYVV3QVdRclByMGFrbllJdVNGNFlTdmRkWEFS?=
 =?utf-8?B?VlRoVE8weitqakJFS3FOTzkyWUFRbEpJUVJzK3MvOTN1UC9vaTNpOFU4REtL?=
 =?utf-8?B?aHlPQ0UvelBXbkVZa3pNOGZraUd2dmRMUXFjZmhkNmYwQmMzY0MyaFFWbFE2?=
 =?utf-8?B?OUZOd2JaczVyZGp0NURONm91bkdKUGNBczZlMDJPaU5wSlQ1aEYyQ1gwMG4w?=
 =?utf-8?B?RU5pdkt6clRBOTMvbG1PTE03MlFTd2xPUTB5WXRTS1QzTXY4SEEvaUx4NXhq?=
 =?utf-8?B?cmpVbWVDRVlDWW85MjlQUVQxSHN5c1dNWm5ISzhYTTZCTDBZNzJEa2dReGZ6?=
 =?utf-8?B?T05OZ1E0eEtXaURGdUdET3ZFRm1tbERWL3VFdWFOSUlJblhLZUVRbGxCMUxB?=
 =?utf-8?B?SldYanp6UVV5MUJWelRTS0lSWWl4Y0RPU0pkckYzRGVVbll1SHdKWk9FMGdI?=
 =?utf-8?B?MHNsZnRsTStWOCtTTFdGWjhIdkVNMUMxV1JLRWpTU2FoWG1jYXpJaGsreVZt?=
 =?utf-8?B?eUZMMVNlYWJzR1czR0E4R0VRVS96Z1hQRkV5TUhhOVJVQi9lQm15c3JMU2Y5?=
 =?utf-8?B?ZUI3ZSt6Q0FqVjZRb1AvakhsYTAydGZoem91VFdqZmtscHAydnpSSHNrTSsw?=
 =?utf-8?B?eTdUNDVoczZNWWhzTktUZ0dwbFpVWTZSYUFjK0pubGJvejRIdlF4VDBhME41?=
 =?utf-8?B?N1Z1K1pDTUNBQU9UdUJtd3RpVVNlVHV4SEpvTmRtdnRNSGZYMU5tNUlIL05B?=
 =?utf-8?B?U3EyRGxheWV5UmQvYXRYK2VZWHJ6ckNwdGFDRUEyMzl6YlVNdGU4U0tkWEc5?=
 =?utf-8?B?eDlCS25JcmJweVdSelFSTklQeEF3TGdtNHlLd3hhaHB0WS9pNFlWc0k2Ukhl?=
 =?utf-8?B?MVIvNld3Q2VscjlyajVtTUtMQXJCOTFWUkVIWCtPWU1pTDFndlFMUVJHell0?=
 =?utf-8?B?MVp3NVNiTElFZEJ4dEp0SGZBS1p6ZGdCUFRYblMyd1hVc3NwUzg1Z0daZGY1?=
 =?utf-8?B?V3RrTnlFYUhVNEp6bzl6Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdedae96-c1cf-495b-3ecd-08d973e9d76d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 23:30:42.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJWIXWDy2Hn+BC5tomY8DZE9gqQLaq+4ZWgZ8FlACSpSwQXv+ov/8f5886Mr3IN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4240
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: iJwL6ebT7MPC8DWQzn9Ygtroej_p7hLf
X-Proofpoint-ORIG-GUID: iJwL6ebT7MPC8DWQzn9Ygtroej_p7hLf
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_09:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=992 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1011
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/21 3:45 PM, Jose E. Marchesi wrote:
> 
> Hi Yonghong.
> 
>> LLVM14 added support for a new C attribute ([1])
>>    __attribute__((btf_tag("arbitrary_str")))
>> This attribute will be emitted to dwarf ([2]) and pahole
>> will convert it to BTF. Or for bpf target, this
>> attribute will be emitted to BTF directly ([3]).
>> The attribute is intended to provide additional
>> information for
>>    - struct/union type or struct/union member
>>    - static/global variables
>>    - static/global function or function parameter.
>>
>> This new attribute can be used to add attributes
>> to kernel codes, e.g., pre- or post- conditions,
>> allow/deny info, or any other info in which only
>> the kernel is interested. Such attributes will
>> be processed by clang frontend and emitted to
>> dwarf, converting to BTF by pahole. Ultimiately
>> the verifier can use these information for
>> verification purpose.
>>
>> The new attribute can also be used for bpf
>> programs, e.g., tagging with __user attributes
>> for function parameters, specifying global
>> function preconditions, etc. Such information
>> may help verifier to detect user program
>> bugs.
>>
>> After this series, pahole dwarf->btf converter
>> will be enhanced to support new llvm tag
>> for btf_tag attribute. With pahole support,
>> we will then try to add a few real use case,
>> e.g., __user/__rcu tagging, allow/deny list,
>> some kernel function precondition, etc,
>> in the kernel.
> 
> We are looking into implementing this in the GCC BPF port.

Hi, Jose, thanks for your reply. It would be great if the
btf_tag can be implemented in gcc.

> 
> Supporting the new C attribute in BPF programs as a target-specific
> attribute, and the new BTF kind, is straightforward enough.
> 
> However, I am afraid it will be difficult to upstream to GCC support for
> a target-independent C attribute called `btf_tag' that emits a
> LLVM-specific DWARF tag.  Even if we proposed to use a GCC-specific

Are you concerned with the name? The btf_tag name cames from the 
discussion in
https://lore.kernel.org/bpf/CAADnVQJa=b=hoMGU213wMxyZzycPEKjAPFArKNatbVe4FvzVUA@mail.gmail.com/
as llvm guys want this attribute to be explicitly referring to bpf echo
system because we didn't implement for C++, and we didn't try to 
annotate everywhere. Since its main purpose is to eventually encode in 
btf (for different architectures), so we settled with btf_tag instead of
bpf_tag.

But if you have suggestion to change to a different name which can
be acceptable by both gcc and llvm community, I am okay with that.

> DWARF tag like DW_TAG_GNU_annotation using the same number, or better a
> compiler neutral tag like DW_TAG_annotation or DW_TAG_BPF_annotation,
> adding such an attribute for all targets would still likely to be much
> controversial...

This is okay too. If gcc settles with DW_TAG_GNU_annotation with a 
different number (not conflict with existing other llvm tag numbers),
I think llvm can change to have the same name and number since we are
still in the release.

> 
> Would you be open to explore other, more generic, ways to convey these
> annotations to pahole, something that could be easily supported by GCC,
> and potentially other C compilers?

Could you share your proposal in detail? I think some kind of difference
might be okay if it is handled by pahole and invisible to users, 
although it would be good if pahole only needs to handle single 
interface w.r.t. btf_tag support.
