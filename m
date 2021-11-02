Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87967443966
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 00:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhKBXSs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 19:18:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhKBXSr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 19:18:47 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2Lc6AA000644;
        Tue, 2 Nov 2021 16:15:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2jtpAc4cIYlXEySdfD4DfEGlj3LgU+JVtL30gvP290U=;
 b=VdXruK1p/XvL19dQL9SZMRLxYEmwZz/T9QhbeD9lxuvr0SZuSEVvQpC6BgqIQJRytQ7s
 QmwbU/y6iaqrTmhMTXcr3vyhxpRAnq16S4VVxWu1CrKtENnY2oiqp+wXfCEo6B7DP7kE
 1BFAjwc+qsVPvuaN0JDQnKQ/XFHWGv97rA8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddp8n83-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 16:15:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 16:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2MQDjNXS7CG3ZVJmt+0w7Wxn8mI63BRooDjq4xwXUUGFP9xZiliBTgdJe2hpUrswP77wvokiVvGJI15mLaBKbhIQqDT082/MDnmu0bJjjbfOdEvqQLwabWBXwhpibgk0RFgMu6I1u0ZQiDzJuAWnOu0UhkGDgi6XKRTkLW9cTBDYqMOzPsyqLCbqRdcZ17FIk6RSWg14AwoB5syJhLXaKxzcM5ssll4MqUjfxhTv/c8670pE3xaRhRV1ei2rwlMXj29xgSxphtpHF/+5Dv+geKjF5CpdnOq6WKBVF0PyOBux49npGmSUAKu45xqQfudnR898CH/FxWWiU7pC7iw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jtpAc4cIYlXEySdfD4DfEGlj3LgU+JVtL30gvP290U=;
 b=FxHzjbB/7cwNW1NHcWpHoIwA4ESL1vwkwrXO0wbTpYEuJzoWlqu119uUWBURIT9C+c+4dSjL8ubR1LeJIJqTIGl2tQJlCZZTr9xsS7TxwBkkM5zIfeY8Wt9038js5zkNLNIhKJ3cmjA4yEbtTUBMNF1mmizcYHcO4AbPS4RIuOrfRXVM1naXQcuiiQUFLkBnzE0z7WgSMdV1jVqzIEC79NAIFc8+a7EsTW80n80Y4Wl8Z2N3qSTOPQf/FRwThnTUnwAoCuXcihLEoD367uVcaPR+FuPDbTywCsiFhqoHy1JdRogELIpGAFfM+9aBLIg5Oy4Q978eeeCRvy+YEVnXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4738.namprd15.prod.outlook.com (2603:10b6:806:19d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 23:15:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 23:15:52 +0000
Message-ID: <700bd919-6d33-d6e7-6454-a324a74fe7fa@fb.com>
Date:   Tue, 2 Nov 2021 16:15:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211028164357.1439102-1-revest@chromium.org>
 <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
 <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com>
 <204584e8-7817-f445-1e73-b23552f54c2f@gmail.com>
 <CABRcYmJxp6-GSDRZfBQ-_7MbaJWTM_W4Ok=nSxLVEJ3+Sn7Fpw@mail.gmail.com>
 <dccc55b4-9f45-4b1c-2166-184a8979bdc6@fb.com>
 <CAADnVQ+pwWWumw9_--jj7e_RL=n6Q3jhe6yawuSeMJzpFi_E2A@mail.gmail.com>
 <CAEf4BzZ-YtppVG2GARkc_MNu-khqJXgS4=ThzOV4W6gic1rCxg@mail.gmail.com>
 <CAADnVQLKkqjnTOAqm3KeP45XsbfDATWcASJr5uoNOYT33W40OQ@mail.gmail.com>
 <CAEf4Bzb4Prxt48bfX8qJ-GSMXPZU9ndkqExvPtOWzEsuK965ig@mail.gmail.com>
 <CABRcYmKBAssv7YKqFnw5dOBA9NTCyNJ5DnffkiP6=NUjC3+USg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CABRcYmKBAssv7YKqFnw5dOBA9NTCyNJ5DnffkiP6=NUjC3+USg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:300:13d::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:deca) by MWHPR20CA0016.namprd20.prod.outlook.com (2603:10b6:300:13d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 23:15:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46db5723-5877-4b74-76c4-08d99e56b6fd
X-MS-TrafficTypeDiagnostic: SA1PR15MB4738:
X-Microsoft-Antispam-PRVS: <SA1PR15MB47384DF734394455266287C5D38B9@SA1PR15MB4738.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hp+st0P5JWRMD7nONiTnHT0wTHpX9RABeNRhWthUOICdPNofGnXH35fVLuNlqVd6PZBHeVt3mTxwgmDinCRRu+ZtFo0iCEhpDVpNwTGNp/POM7RvHXK04CQlksjOzec2onP5oDldlKSQEKMGaVoreqWDIInXBDYxqY3hsAFeNxfMWJurNuZ+WRwKd3+n9n0PtG22NrB+9TV0dR3TrnrfWuF/DWAFcArW3SDga5Q2/Wk9zchwCLXgyTd1tEB5qXGtNXeH51PsxR0WOSyzIzEnY4iBd/cYzMS2LJ5uYBj2Tho0WC9vWGIWc9nY0K/xmiq2QaghA37aZSFPojKFZqL4iIn5WInTd8OGUROGRPHAo36+AS6XHY1hLFoT9njPv/3c5YPbRbRf+EwEJpqr5lkBIHvv+s+119n/yuEI3Xtb33hyDB8xYy0jP5hOEtpBJReJ3E8s1Ume+md341+Hz2lUN9xol8+dTQQe3nRrejZ+mTfdhO9njHoTf0f154aI8/pr0yNsh4GtUNY76qg6wux4sYaPHmsBV0RPPSvAzwDqfipPQ9aGTT0l/9nonpDCt9hQVazAZJKrLJjgmNRkuqrX2Fz9XqU6ukUhf8Ku1HcQZaOyEHmQ2ws7o89o8/xGLHAd8NbISnLsgOcnCgOago1shFsCPxIFUuopSw3S6CoxV+ckKPe6Ap105MhrETmhwqRPR20Jl6tSfm7cVl5TWMC7yZrjW8ZMqDwCZ+Cz052NeBJc0nxqIDO2601Tjbs7wZk0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(4326008)(31696002)(2906002)(2616005)(508600001)(36756003)(316002)(86362001)(7416002)(186003)(6486002)(5660300002)(54906003)(66476007)(66556008)(8676002)(110136005)(52116002)(83380400001)(38100700002)(66946007)(53546011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THZnbit0THFwT083Rms1Qlo1WFVxL05TMWdpWFVwZ3ZQdG1rTUJFVVlEaDFx?=
 =?utf-8?B?UDY0V2xwQnUzelhHU29YdWdqVWtxVWFUQVdMNkVYNSs0TDdhZk5OeURmNXNH?=
 =?utf-8?B?cjgrZjVmOVYzSVRBNVVHajFkVG11ZTM1Ym1SY2pnT1VMV01KVWZJS1hNR3ZT?=
 =?utf-8?B?VGU3cVhTdFp0NkFJaS9CYVRHRUUzWlAzRVFzRzFDWkFON29sTjQ4UVlXVXpy?=
 =?utf-8?B?Z1ZoTVpEdDk0S09OWjBMZWJVajdRYzlGM1JQTy9PM2V0b2VoTXQzRHJmSTlZ?=
 =?utf-8?B?NzFFeFUvdnhzVXdxaGMreHlVcEtERlR2NGlSYkVLZVdMSzhnZDNIMytaaVll?=
 =?utf-8?B?bmh2eXBqUTMvYWZXNWVzWFZpdW1zZXFNS2tkMWpNdDRwRVN0SWhlRlJQL0Y3?=
 =?utf-8?B?VTMrNnhTUDFSUXMvUjdKOENodE9ENElTem9rdDl2S242Y2pKTHdudnNZbis2?=
 =?utf-8?B?WEZ0R2tlUnVxcXAvNGVYNGJxZ2l4YTlOTk9mU20zaGdYeU1jSnk4djNQM3Ny?=
 =?utf-8?B?bjRqMW1FTTMvUlVqMWl6dlE3ekY3VGdVOW9FOS96RU52d0FxQzhpYy8xdDZn?=
 =?utf-8?B?SEF5d1pMY3VSQTJ0SFVkd01wY3d2QlFyQlZXRkRvVTZMdUk2OVpYM0xaTHk5?=
 =?utf-8?B?d05lU3gyM3JMTGYrL0M0RVlDRWVsaDVZVzJZZTUxNzdMMll5RmJIT2tQakw4?=
 =?utf-8?B?bE4vK2tUbGJ6UVdrSGR0UjNXcTF5N0tJUEpUOE9CdTdkNmNWV3hHNXk2ZE1V?=
 =?utf-8?B?R2g4S0NxUkNieDhQSkw3Znc2aUtzYWo4NTZzd3hpRHNEcXJEKyt1UDRSMWJl?=
 =?utf-8?B?YTNBSmdIYTNhQmkwNzVhN09vREY3M0JJMnN5c2YvRlJGWkEwVXlmSkptSHBY?=
 =?utf-8?B?RUlDaGZqaEhTS09VeFVKRkl0WVFPekVGN3hmcmdIMG42WDlucmZhazY0bWRs?=
 =?utf-8?B?dys3bVBuZk40WFlIVFNWUWZhdEN0YXVRMkkrY1BVcXc1Z2JNS1UvUnN4ZFVy?=
 =?utf-8?B?SVNoUUF0R05mOC9pRjY0TXNvVHkxaSt3NWEweGdxOE5CNjMrSlV5ZHdESnA4?=
 =?utf-8?B?Uy9zRVdSaVFwekI0bU12aFdrVVhWTWlOankyNkFTandacU5IZXZJTVdSeWVQ?=
 =?utf-8?B?R1crMW9ORGE3elV2SFRtWXJQa25LdHdPd29uaWFiMnhLSzJWNDBISWJWZlBT?=
 =?utf-8?B?cDRuRHRlbjgvZEFQKzY1S1dUemFxRFpQTWZ4ZTdUMElGK1hBby8wcnhudEpz?=
 =?utf-8?B?M0l5UkRJTW9MeDRDaTJpSW1QRkUzY2srcjFUTjRCZFVGeVlvWk5YdVhQVEJK?=
 =?utf-8?B?UVBoN25kcXVUNzZoUkQvcVJ5Nnl4T0RMRVNTRkM0bDFUWStnTDljWHpYMHFk?=
 =?utf-8?B?MWMvNUsvUGhsQVdNTTFOL3ZsUk5zcDFpT3IrNG9UdWk0bkJLcVhNSHhjOExh?=
 =?utf-8?B?VHJPVVJuMjBOOTNiZmlYNTYzcjBnUjhnMElLVkpMQVNEVzAzTVQwcTZBbDd2?=
 =?utf-8?B?dU5FZWs3SlFzZXF2Z3JsUHFmZ2lPZ3ZhbUFSSUxwL08yWDdCa05YMU1PYlNh?=
 =?utf-8?B?RENOTFlrdzladlNPYWh4cDhUWGloM3lrV2JYYjVkSTBRQVhmaG03RFJGVjdx?=
 =?utf-8?B?SGZaTW4yN0FYZ3oyWkxOak5QbGpQRDhCaHpsYWFWRUw0N3FVMGlFRkFhdnVJ?=
 =?utf-8?B?RnFhWGx6bFlaa0N4ZklDUVpTTnAyem84VTRFZDNEV3VXSG50ZVBzTURLNnM5?=
 =?utf-8?B?NkdXWUhrWlBEMnBPTTQ5Z3pmQ3RtOVptWTdiMndtRDE1bzlsUWY5elFWbUhM?=
 =?utf-8?B?VjYrWFpjZUtrUFQwSmEwVWtmNGVlNXV4Q1hVcXpwZkFKNlNaQm1vL2FaNGQ3?=
 =?utf-8?B?WkNEOFd3OG9rVEI4SlVKbzhockxpVGRZc3pMWnp4eE40MVN0Z1JLOTRab1M2?=
 =?utf-8?B?YlRtakovUVZMMnRWSmpVeGY4VU91ZjJ6QTJJVXlTSVJQV1RTOEowNW5OVExJ?=
 =?utf-8?B?UzdiOVlIL1hVbFRSS2ZtdWNHa294MTJxQUFrNVgyV21hcXlMYmg2RldaZWJZ?=
 =?utf-8?B?S2lhUGZQQkVIOTBjM2cwbjhKWmQxU0ozQjJQU0FpenAweTlleVl4bGhyWSt1?=
 =?utf-8?B?OW9rTzBYZGcvdTJ1ckNZZ2d4bGVlNUJtU2JDTmhscDg2WW5FOEhUemRQVUdG?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46db5723-5877-4b74-76c4-08d99e56b6fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 23:15:52.5235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25VDMydXjDDgg5n6YasyIKThQ5HvNETZ9iD5D8DZ5je0MAd8VPfwYxsCVlCEivRp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4738
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: hygAv9DLceAR4ETz_z0vgbYahkJZEz2S
X-Proofpoint-GUID: hygAv9DLceAR4ETz_z0vgbYahkJZEz2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 4:03 PM, Florent Revest wrote:
> On Tue, Nov 2, 2021 at 5:06 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Nov 1, 2021 at 8:20 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Mon, Nov 1, 2021 at 8:16 PM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>>
>>>>>>      FILE *vm_file = vma->vm_file; /* no checking is needed, vma from
>>>>>> parameter which is not NULL */
>>>>>>      if (vm_file)
>>>>>>        bpf_d_path(&vm_file->f_path, path, sizeof(path));
>>>>>
>>>>> That should work.
>>>>> The verifier can achieve that by marking certain fields as PTR_TO_BTF_ID_OR_NULL
>>>>> instead of PTR_TO_BTF_ID while walking such pointers.
>>>>> And then disallow pointer arithmetic on PTR_TO_BTF_ID_OR_NULL until it
>>>>> goes through 'if (Rx == NULL)' check inside the program and gets converted to
>>>>> PTR_TO_BTF_ID.
>>>>> Initially we can hard code such fields via BTF_ID(struct, file) macro.'
>>>>> So any pointer that results into a 'struct file' pointer will be
>>>>> PTR_TO_BTF_ID_OR_NULL.
> 
> Right, this is what I had in mind originally. But I was afraid this
> could maybe prevent some existing programs from loading on newer
> kernels ? Not sure if that's an issue.

This potentially could cause an regression, especially in mosts cases
the result of direct memory access is not used as the helper argument.

So the best is to add checking around helper itself.

> 
>>> The helper can check that it's [0, few_pages] and declare it's bad.
>>
>> That's basically what happens with direct memory reads, so I guess it
>> would be fine.
>>
>>> I guess we can do that and only do what I proposed for "more than a page"
>>> math on the pointer. Or even disallow "add more than a page offset to
>>> PTR_TO_BTF_ID"
>>> for now, since it will cover 99% of the cases.
> 
> Otherwise this sounds like a straightforward solution, yes :)
> Especially if this is how direct memory accesses already work.

Alternatively, the verifier can add such a check for the related helper
parameter. But looks like that adding the check inside the helper itself
is easier.

> 
> I'd be happy to look into this when I get some slack time. ;)

Thanks!
