Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22592C8AD6
	for <lists+bpf@lfdr.de>; Mon, 30 Nov 2020 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbgK3RXo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 12:23:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61426 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387405AbgK3RXo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Nov 2020 12:23:44 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUHFekW021181;
        Mon, 30 Nov 2020 09:22:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Mv9ZoRm2d8SmhK+vyR2tGWSF85mmdzoYy0N0dYg4zSI=;
 b=jO2t9/QFJMgac58AL90ioXNpj4Ra64JPR/xuV6oeiSH6hN36tYPb90BjtGCvKJkzTRk4
 MxHQFLv3h5i23FW0KqcmsUm10K0XE/zSq8QNHvBLhDnnhAUPknO4fiV/qlZNjOTn3RGx
 Uz9ePdpYsYNbA2VW0uLlCCO4lUY9U2C/EzU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 354c7qd8b8-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 09:22:47 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 09:22:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbYTLUwwV++LEMn5irR2D9Bj/3obgpNPrnOsrUdiba7+TBWo19gvXHT7YEXyG48SYGUIGDxg62pGKKFYywXGf4+J+HVFEhRzfQoNz3np67JrI8Wl9ycBMq6cazhwhzuO1hq0AAFIrrxvXaVVekAXDGkdyXl/LgxKex7jBQXvp3JMLo7/XOUJZPyUp9pVzB4nyedRy4KXpgBL41X41dzSd7nukABTZHxarY598sSHH3xyZAbHYymP5p5KwsTEEdqJE1k89itiMxWB1oGHJaAv2mPK1LxoZcfKG5p7XAryruqNM+iPv641BKBOdaW36E1FfXNA+rlHUsh3GlsotUqvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGuPEhIaYygJuujnXxmrft24HMjZG1Dx12ido4iltKY=;
 b=MzjRluFGxBf8/+jtOe7dPKaytZ050rXlZLP2ZsjWomJQGTS1hHHJcp7urXotL18Kyu5TjW6qqOun8A8pzJ08Xt6+QZs2rtErlZ/KNnZ6wIhga0BhD/OFPnlAlcKILISY1hUakI+pnOllRBsuL5Smx3bcs7RguhhFMNHYsC5jArMeCPUGJwXp5gTxh4BkQHpVcPtfjIWgOnUV8X4PXxheSNk7RZ93Ajrq4diPPioeGPEXeLFlp1kAEw5H6fA++iTcYZ+4G3I5/1ADOwfcVlzoOCwEPEGyrrc0Cs2Yz5oFjT42iH3SAsvfoRNYvWdXGzcW//UNGpqMY+KcNiMCeC+2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGuPEhIaYygJuujnXxmrft24HMjZG1Dx12ido4iltKY=;
 b=I+E2CIohArR/gcEHqUeoRFl35izRCEAzPMKWf5HdtnhdT/MQTxfyShxxZv0RJEi9QDgWQHQAU0kVzPShWKZoGkNH5ezbriyd5DezUWOIDGEpssNFOPUNkM95GjNI7JP3lD++xknv8pKfBf5w0ZJlkDtKvWFS4HpqEExrCmXtJo4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3301.namprd15.prod.outlook.com (2603:10b6:a03:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Mon, 30 Nov
 2020 17:22:40 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 17:22:40 +0000
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
 <20201129014000.3z6eua5pcz3jxmtk@ast-mbp>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b3903adc-59c6-816f-6512-2225c28f47f5@fb.com>
Date:   Mon, 30 Nov 2020 09:22:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201129014000.3z6eua5pcz3jxmtk@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:5f96]
X-ClientProxiedBy: MWHPR21CA0055.namprd21.prod.outlook.com
 (2603:10b6:300:db::17) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::124e] (2620:10d:c090:400::5:5f96) by MWHPR21CA0055.namprd21.prod.outlook.com (2603:10b6:300:db::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2 via Frontend Transport; Mon, 30 Nov 2020 17:22:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 536299a0-61c9-4202-4154-08d895548a0e
X-MS-TrafficTypeDiagnostic: BYAPR15MB3301:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3301499B150921873C94221FD3F50@BYAPR15MB3301.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RY806nBkb0P6drWD6dFXHl+Rtj7NFdvk1hpXvzUQBzWLAXa6pYN3Cmdpk2e2udAPuOEC6CMFT85FplUuR7ZmVvg4ZZRnJ0q2I6RJNems++7U4ove4sH2fjfPYfjXEtPkLnVpSWQ2hF+3iWouZYVVwHzEiAN0/9uVotPy1XoAbt/cYFTOw7mL5ArOxRxOZ5LdLIZHkb/ly67F5CqhGEah18sIumMqFUmo71FcqX6yuk1rVANNlpYTeth5BkVNpopyDKcHkJYQH46GV7ICVeR9VrSQXNq+mrhlz2pdp1DX8kE3Qxxt0SFDDcqncGGMQgWIafQdDz96iMyUecw+7PosEPuen3YEFr7hPdTqsQOQm9/BpSt3qOmkSVhE6ihwvF2cYimq9pd0yLUvT2igpBAZprJQCIVzgqsHSlOJnRGwdyg8VXgne7WF+yIW8MkXkWUafBny1HRZgO1ZV5RjB/3SlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(376002)(366004)(136003)(66476007)(6916009)(66556008)(478600001)(8676002)(2906002)(16526019)(186003)(36756003)(5660300002)(966005)(52116002)(86362001)(8936002)(4326008)(6486002)(316002)(53546011)(2616005)(54906003)(31686004)(66946007)(6666004)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dEtzbVBTa1ZFUjhqWEVNaGxLQXljWGlrUlpkenhnYVpBNDk3dHBVMjJxVW9i?=
 =?utf-8?B?RVhkT3lxc2NVcWFwb1VlQUREWE9BbjMzNEw1SWc0UWhESytRWDBoRFJNNmRH?=
 =?utf-8?B?NG0wWURvRTQ0azBnRDVSTzNRYUV5eUhNT0VyYlZHSS90OElGTUdWSUxpYlVI?=
 =?utf-8?B?cXV2LzAyclRBTG51SjRjZUkwa0xHV25wU3RDNDF6ZEpvTFdpNUJ4Mnpvb0NF?=
 =?utf-8?B?MWh0Z2F0alJvbHBCNlB3NnZKVXBySVU2R015SWptNThaK0piYUxJY2FCb2I4?=
 =?utf-8?B?amlIbS9uOGFTckVSK2ZEUzBUWXdFUCtHYTFaZEtOTStrSThvWUhrenYwNHVo?=
 =?utf-8?B?MGl1NTdWOTJwc3ZYVkpMNkdaSVVtOE9nN1VSM05oNVJzcjF0Q3lKcHBic2Vv?=
 =?utf-8?B?NW5ROGdiR1V3VGI1NFN1TVdyRW44NUNaS2doNFM0ZVZVR2dVYURkMVpKSFk4?=
 =?utf-8?B?d1pSY0oxMWRXOEt4QkZlTFpZZTNEcU4vT1VSc3dmdGgwUnFKTTE2RFM4eGs3?=
 =?utf-8?B?MFE5aUJqajVVejhBS2ozSXFzZUFLUmVEeWhPdnJsSEVybFhwYWlPYVowd3Uz?=
 =?utf-8?B?a3ZpaEIrQnhLZHdScjRYTDMxeDhRZUVmSkdsVTJkb3ZZZitmajh3SXF0UzNG?=
 =?utf-8?B?NFdrdmF4MEY0VlozL0FCZHV6aFdSNjRPbGV6elJFMW9WSVErcWJ4RjZ4Ungv?=
 =?utf-8?B?ZG1mVXpvQmlrZDVFQ1hSdjZDdFZ3T2luYnBWZE5xQjV1dExEYTlUd1luY1RZ?=
 =?utf-8?B?OEJxcWUwMG83OW9pUWoydENVWFkvdGNZTGhtUUxmVUNxd1JPOEIxYkNLeGlt?=
 =?utf-8?B?RFM2eGduTFJmajZNWHM0M1QwYmlCMGlUdEs0VVpudkNLcG4xSmZJRmxkWkE1?=
 =?utf-8?B?WWhRbXJFUlZXV094VkpKR2tHaHRoREQwZkFQbjRZOHp3a0ZQS2ovYWNZcXh0?=
 =?utf-8?B?NFhISTVrdWFWNDB2KzFpeit2dE8yczFYUEtSODRPTUVlbGNtMktmbkZjdlpF?=
 =?utf-8?B?WTJONWhPeTV0R2dwVXNvVjBheGhxT1k3SXlialBOeVlFMC8zVTNwUVBOYVJM?=
 =?utf-8?B?ZzNiUmxORzFvRlJNbGx5N2QzbUVCaDdjWWEyNFhXa3IrU0YrR3BVeGs0MExx?=
 =?utf-8?B?T3JIOU9SWjN3WXhGbWhhKytGNjN4RTAvd2RmZXVvWjdnV3BOLytJM0RSZktY?=
 =?utf-8?B?TGNqYlAyTWRTUFEyUU5QdlhmaHV0Wi92T015bjN1eXQrVEJaNmdVNXdONWJw?=
 =?utf-8?B?T1Ria0JSY0NXc05Eb2J3OENXdEkwVGtoZUpVclBta2h6S05aaFJtcm42VHpu?=
 =?utf-8?B?Uk9iTC8rMUpocG9qeW5ncWQyNzgxQmlKQjBoRG1mNFllWm9QeDM0OWxZUStP?=
 =?utf-8?B?alg5MDg2UGRSUlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 536299a0-61c9-4202-4154-08d895548a0e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 17:22:40.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNBkPxGSvHQlo+bgJ5/lOcua5bIxCKOsnQcEtyPwOh7KchfS0jjSRb0niET8/jr/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3301
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_06:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/28/20 5:40 PM, Alexei Starovoitov wrote:
> On Fri, Nov 27, 2020 at 09:53:05PM -0800, Yonghong Song wrote:
>>
>>
>> On 11/27/20 9:57 AM, Brendan Jackman wrote:
>>> Status of the patches
>>> =====================
>>>
>>> Thanks for the reviews! Differences from v1->v2 [1]:
>>>
>>> * Fixed mistakes in the netronome driver
>>>
>>> * Addd sub, add, or, xor operations
>>>
>>> * The above led to some refactors to keep things readable. (Maybe I
>>>     should have just waited until I'd implemented these before starting
>>>     the review...)
>>>
>>> * Replaced BPF_[CMP]SET | BPF_FETCH with just BPF_[CMP]XCHG, which
>>>     include the BPF_FETCH flag
>>>
>>> * Added a bit of documentation. Suggestions welcome for more places
>>>     to dump this info...
>>>
>>> The prog_test that's added depends on Clang/LLVM features added by
>>> Yonghong in https://reviews.llvm.org/D72184
>>>
>>> This only includes a JIT implementation for x86_64 - I don't plan to
>>> implement JIT support myself for other architectures.
>>>
>>> Operations
>>> ==========
>>>
>>> This patchset adds atomic operations to the eBPF instruction set. The
>>> use-case that motivated this work was a trivial and efficient way to
>>> generate globally-unique cookies in BPF progs, but I think it's
>>> obvious that these features are pretty widely applicable.  The
>>> instructions that are added here can be summarised with this list of
>>> kernel operations:
>>>
>>> * atomic[64]_[fetch_]add
>>> * atomic[64]_[fetch_]sub
>>> * atomic[64]_[fetch_]and
>>> * atomic[64]_[fetch_]or
>>
>> * atomic[64]_[fetch_]xor
>>
>>> * atomic[64]_xchg
>>> * atomic[64]_cmpxchg
>>
>> Thanks. Overall looks good to me but I did not check carefully
>> on jit part as I am not an expert in x64 assembly...
>>
>> This patch also introduced atomic[64]_{sub,and,or,xor}, similar to
>> xadd. I am not sure whether it is necessary. For one thing,
>> users can just use atomic[64]_fetch_{sub,and,or,xor} to ignore
>> return value and they will achieve the same result, right?
>>  From llvm side, there is no ready-to-use gcc builtin matching
>> atomic[64]_{sub,and,or,xor} which does not have return values.
>> If we go this route, we will need to invent additional bpf
>> specific builtins.
> 
> I think bpf specific builtins are overkill.
> As you said the users can use atomic_fetch_xor() and ignore
> return value. I think llvm backend should be smart enough to use
> BPF_ATOMIC | BPF_XOR insn without BPF_FETCH bit in such case.
> But if it's too cumbersome to do at the moment we skip this
> optimization for now.

We can initially all have BPF_FETCH bit as at that point we do not
have def-use chain. Later on we can add a
machine ssa IR phase and check whether the result of, say 
atomic_fetch_or(), is used or not. If not, we can change the
instruction to atomic_or.

> 
