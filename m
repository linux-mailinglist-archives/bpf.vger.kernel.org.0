Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5A315A3E
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 00:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhBIXrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 18:47:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38840 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234618AbhBIXPB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 18:15:01 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119NDwGI009883;
        Tue, 9 Feb 2021 15:14:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yqMSV0+aBDQLV/zg5rb6oOhTVbwNLbERHZPVaXbbwKg=;
 b=ecIPAT/JdMNvrCHjO75Ece85sK/4++KqAgZ8WDDAw4/LAsBr0HmLNBLXXZ2vQA2Xk9lN
 JwAiOr9WiIbAUVdkLyEbcW5YfM11uHiP4SCPcpYhP9BESrTMC5N038vGPt2w9BdaoHLM
 3qrc+FD61g4UxUvNR9aJ+mziyb4U+OODcO4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hsgtrv5e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 15:14:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 15:13:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUDxFSj3+yezABuSubgj61i1Cozhf+2qDu+z5zZX9Nx4RZmj4X8Y0wfBsGYrkTBcRJEtOEv/bFUO46yIAQ2bgDhSqAxW2uPIGc0bzUoilBSV5mFwmZCSJoWKyIQq4sq+/hW9/7NYAW16hgodkqHYTFHEyaOStC3k6W0tbO9S6KuXxt8AMdDKBk2Xcd4TLAzwk6rcEncBAGY6JUreFtyuf0+4AgZaxq8mBKZ07gSb5BzeFC+S1V+H4BgULE1ZRiegmNu2KoYgd78sTjLKrkNO1DGBzri9TRNQqYmZsj88IyAM4xLkl17GVj3QreuywsewmclEtx0LJVGQ6vN6PFzV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqMSV0+aBDQLV/zg5rb6oOhTVbwNLbERHZPVaXbbwKg=;
 b=nOccnV8KeTo11+BYucL3t9O/J5f+xZQMn/YmOyvAtbOOd9TVHeA03EXH0rf+l+C6QvovDMoPHWBH6TIUOemMspFtHfWqnhwlgoz+/tC0WwKpqWBj3Nefle76s/zVXnKQDetbaH2SIZ+FprkCj/9hK74J+SCBhZsCfuOgQ+QY9s6SFZN31yMNBPNtRn4h8OPwK/fbECMzBGJ8wW3WmFNqrRLbjDrijRRXaIKHwkEJLgvRd5N9gWf7WR3B8+5dx/6eWAWAoYcF9CA+M1bbEm3eEqwnTAe5ZJmaC+O6d+yZwuAxc1biPxZ/DSQgVgc6WVvHoI3P7b5SCznIKGpwa0SUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqMSV0+aBDQLV/zg5rb6oOhTVbwNLbERHZPVaXbbwKg=;
 b=L3f40eGMC1huY6fnqQWRuR5x+pkjqMRhuIPcpj2EtpCTaqFcprzf016+p6piSOH1uU4iMOwpzt3Wt61h+UJT1yJCtsJ7XZv3sPsImcdhKODdPGbarQPOqIwYSbiSSa/gv0b7pRZoiAk7pOi/ysQpuIrvWofBrRnLBbNy5iFdWf0=
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1729.namprd15.prod.outlook.com (2603:10b6:405:4f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 23:13:24 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd%6]) with mapi id 15.20.3763.019; Tue, 9 Feb 2021
 23:13:24 +0000
Subject: Re: [PATCH v3 bpf-next 7/8] bpf: Allows per-cpu maps and map-in-map
 in sleepable programs
To:     KP Singh <kpsingh@kernel.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
 <20210209194856.24269-8-alexei.starovoitov@gmail.com>
 <CACYkzJ66POr0opxbrvRTTTc-T4CsyirHpDPvWRaM3R1bmNvm8w@mail.gmail.com>
 <9a45e856-c464-c6e0-6c26-baf364b6bbe8@fb.com>
 <CACYkzJ4=G45CG+_6wq+xR64PpZ_z1gvQsJWhYFhzKd=2_Y-s1g@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <61dffef3-ab23-8d9b-70da-3e84caa84fe3@fb.com>
Date:   Tue, 9 Feb 2021 15:13:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CACYkzJ4=G45CG+_6wq+xR64PpZ_z1gvQsJWhYFhzKd=2_Y-s1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:c01f]
X-ClientProxiedBy: BY5PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:a03:167::27) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:c01f) by BY5PR17CA0050.namprd17.prod.outlook.com (2603:10b6:a03:167::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26 via Frontend Transport; Tue, 9 Feb 2021 23:13:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fed342-614a-4d6c-0fd2-08d8cd504ca9
X-MS-TrafficTypeDiagnostic: BN6PR15MB1729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB17293BFEF67F5857B30F700DD78E9@BN6PR15MB1729.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsTltGxcb1qhnZZ3zUCBb/xN3XWuNUF8SCjODkbjvwPpFDmACDVBdxfD474NiJok5/a4CmbG5rBytysWJd5yF4/Bh4wLjAZLCjE4Ce0micr8nnd6UQUEGDKdYM3aXXzJPoeEQcnevDpY52+T69CL9Z2OZcQqwQs+ssbxt6QLKwQigo7iXNBDvzbYaAMbbtyINz+bfryTvYPDHumrgWwyZQjUDNi5Rw8RYrxdNmwpic3lt7q4bP5Yco55JO7oiVxdLfUHSjOY20Q+yVaC4IwZjPRHneZR59ldY+y8vlzlCb8f7lWweUGbuqoUKi1cBbULaWpaRXvzrkhcZUjLy4+MD/LoSfUHB8ucMd4rlINzBXg9BTTB9Amr37Rc54h4nnDMkkp3b2bUJ7Xu9Kv9iQtwsL/7J/3ugU4X+D/GWrZQdb79r81q9+aIA2glJj0X6Jdp7/ybzmQNI2GahjrJbGAEFm5txSBsly31cU7g5uoxT12uwiwPIifRlBRWp8QIzdLJ6/KuZMB1zNBewETvwqcYRsj6u8AtpCK5L6mtTUSX0cIXrPgnuh42aumiePQ7wEQvqdUXEOVhydFTgUiMHXocB59teeGuVAPLC8od1BMEb5hrEUHia7pXEGtN/z3C284lMsf/kPnAht7AeqI5bGJhiumUWC8O2yx0rTdXjPlpMqsAt9aOQh0Y4yckxtvS+d9U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(86362001)(966005)(83380400001)(478600001)(52116002)(31696002)(8936002)(6916009)(2906002)(4326008)(53546011)(66946007)(5660300002)(6486002)(2616005)(31686004)(8676002)(16526019)(36756003)(66476007)(186003)(54906003)(316002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NzNJWVhYeEM2WjFjUWg0Y0lqOWxPc0RHVjU2MnVtQlZLMllJUU84Q2ppaFlG?=
 =?utf-8?B?WG54ZENsZmRNN0s0bTdWU05DcGhuWEhnZWJZS0FsbVloM3dEdk1xeWlsVkpI?=
 =?utf-8?B?czk5L2xRemN0TTVVZkJaMFVpQ3puaHlobVl5ejl5eVAwL3Z1NjQyRkxxbjZz?=
 =?utf-8?B?SlkyMm44bFp3MDNpTzJ2bGxBMk1YVUdTaGJyTkVKd0hUcmMzeDkxaG5uR3dq?=
 =?utf-8?B?emVCSXcxaUYvRnVFTlNVOGxDTHIveEFaWWJreXpJOEdrUnFpZkFnOWpETkxF?=
 =?utf-8?B?RWpaRG5YZnJRMVdJaWEvYW9XcjlEZW1tQUZOSEU1NVpEWWRCcHpGVXdqanZZ?=
 =?utf-8?B?d3grQ011NnBvUGg5Vko1OGlwSUhQcHd2V25jb0pCTEZoWGZQQkFrV0pQaG0w?=
 =?utf-8?B?eHVPbkpmMUFiVGMrTXJLa2djSndpQnpvVDhUc1htcm9KME9Jemk2UnZ6Z254?=
 =?utf-8?B?MFJSdHpSUzJpTk1PVjh5a2pzZG9yVzdDSWpZbzRHOWg5MENRQmdWdGxHTXFE?=
 =?utf-8?B?ODlQZXlYR1JDejJiQ2RhVExUY2g0NjF1U2QrazVkdHlwaHRxUExaOTFYSFhF?=
 =?utf-8?B?SEdyVlhibE11aEsrUXlNY1JMVEFoZW5COXRiRXVxRlN5VXl2cTMrNjk1QWhN?=
 =?utf-8?B?MXM2RVdaM1VvZlhOQ1pGeEd0ZkZNNnVMc3dmcVhzOHZsVHFUVEw2Y3JQdG93?=
 =?utf-8?B?VVRiRXdoMG84T3BKSmRKdlN6ODh4UFlEMWg1b2hXNXZEeEpxWHFHYS83SzZw?=
 =?utf-8?B?SWpibDYyKzZLTGNYZ1ZGZXkzVVRWMmI1UXk1Um42RTcra2k4UVZIT0N6bHFi?=
 =?utf-8?B?S2gvcEYrbmNlQlNHcGlaOS9abHBSTFZhOHMrVEo2SHBZaWN3d0lvNk9oR0s1?=
 =?utf-8?B?YTRBUzc0ZzczVktKcGtIUUQvRzNvMWlyaUxHNU5pQ2RTdGlpMDJoNEppZ0xi?=
 =?utf-8?B?T2dKZC94ajVSRVUzMkxZS3JnQVJtRWdnNnE3RUluY1JqNHIvOWVORTJNN1JX?=
 =?utf-8?B?VWtLUGlJT3F1elRKUG1uRmpUTTFiQ3dOditGa1ZsNHAydGFnZisvRnpQVUtz?=
 =?utf-8?B?MWhROEIvYjZRalg1TDJ3VG5Ub3QvN0pwVHc4Q3JraEl4Ry8rWmlJeU16bzNi?=
 =?utf-8?B?MjM5bmNZbVJ2eUV5WkV1dXhrYlMyWldBR1hQMFlFWUJTK2pwVXZoWE84eC8r?=
 =?utf-8?B?bmJFOWJ2UlZaVEFVNHpkRVF2UkgwVkRBb3RKbUJrSWRpSlNGWFlhUzl3amVU?=
 =?utf-8?B?bVpCc3RhZVJUTUJVZGVGY0VuZjl4SEJkR04wdmN1Y09uVkhvRmN5cnhuY0FR?=
 =?utf-8?B?cVI0YmN5VyszVERtZEMwV2pldnByTkNrMXVLTmdJcmxONHNGMG1Wek13eWFh?=
 =?utf-8?B?UXAvVS9IU0Z4U2pXaVZ4Yjg1OUZ3WDhhLzFlSWFwMkk0YVFJNUNDbUd6NTA0?=
 =?utf-8?B?WGdNbDJyK3NMaXBWd0xyMGd3bVA1UVNpNytJQTRUV0hOYXo2SjY0NTlzck52?=
 =?utf-8?B?RllJSEtJcnhibDJtTXhERmFQTWVycFpKWWhpakFsTytrQktBYkM4b2puYmdp?=
 =?utf-8?B?QU5OSzJCVk1wTGl6Zmo3L3Q4NUc3dW10YXJUUGxWS0xFbDlzN04yQkpYekww?=
 =?utf-8?B?MmpMaUVVeW54Q0I4VDk2SEl0R2lNdWpTbEs4OFNnTXdsWncrb05XYjRhNXN3?=
 =?utf-8?B?eERuQm4rWGpSK2FxV0dFRmhWWTJTeDVoakRUNzRZb2RMdS9JTUkydHJia3Mw?=
 =?utf-8?B?TEIrTFVvb29lZGFNcmt2dkNyMkNYb1VaOEUyMDNTQ0o1RXVDeUpwMnJXeDVk?=
 =?utf-8?B?N0E4MmI2UlVIU1hxMmhPUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fed342-614a-4d6c-0fd2-08d8cd504ca9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 23:13:24.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGwhyiJ9GlpYCcxRpsV/7UGyzZcrbRPe1nbGmX3KNpPqTokd7bzUN+cAVMsxa3bH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1729
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/9/21 2:43 PM, KP Singh wrote:
> On Tue, Feb 9, 2021 at 11:32 PM Alexei Starovoitov <ast@fb.com> wrote:
>>
>> On 2/9/21 1:12 PM, KP Singh wrote:
>>> On Tue, Feb 9, 2021 at 9:57 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> From: Alexei Starovoitov <ast@kernel.org>
>>>>
>>>> Since sleepable programs are now executing under migrate_disable
>>>> the per-cpu maps are safe to use.
>>>> The map-in-map were ok to use in sleepable from the time sleepable
>>>> progs were introduced.
>>>>
>>>> Note that non-preallocated maps are still not safe, since there is
>>>> no rcu_read_lock yet in sleepable programs and dynamically allocated
>>>> map elements are relying on rcu protection. The sleepable programs
>>>> have rcu_read_lock_trace instead. That limitation will be addresses
>>>> in the future.
>>>>
>>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>>
>>> Acked-by: KP Singh <kpsingh@kernel.org>
>>>
>>> Thanks! I actually tested out some of our logic which uses per-cpu maps by
>>> switching the programs to their sleepable counterparts
>>
>> You mean after applying this set, right?
>> migrate_disable is the key.
>> It will be difficult to backport to your kernels though.
>> The bpf change to enable per-cpu is easy, but backporting
>> sched support is a different game.
>>
> 
> Yes after applying the whole set.
> 
> Also, I think I also got it to work on 5.10 by (I am little less sure
> of this one though)
> 
> -  Backporting https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=12fa97c64dce2f3c2e6eed5dc618bb9046e40bf0
> -  Backporting https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=74d862b682f51e45d25b95b1ecf212428a4967b0
> - And, backporting this set (I initially missed
> https://lore.kernel.org/bpf/20210209194856.24269-3-alexei.starovoitov@gmail.com
> where you add the
>    calls and ran into issues).

and the whole machinery that it depends on.
