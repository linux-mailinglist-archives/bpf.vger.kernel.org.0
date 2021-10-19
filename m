Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10D432C80
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 05:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhJSEBx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 00:01:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229755AbhJSEBw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Oct 2021 00:01:52 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19ILBFS1002080;
        Mon, 18 Oct 2021 20:59:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KNchITZz9UvDre9bn9lsUugfAeOH7iFkZpaIAFd7yTc=;
 b=pFDphX8j02oyzT9b+lvR7M2OtB5f2cJGXd8whlcKboLJlVUFvbcfLs9gKo6zFjf15KHQ
 f/t4of5XvogVun1T+lR2U2k8AQTXBSgpnVRmNYGvlEQx7Z51hx1Nrj1sDq5iFxZoikNz
 7z9Y1E2/c1AVsh33SrkOYI//Mjpzm8Tinrs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bs7tue3t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 18 Oct 2021 20:59:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 18 Oct 2021 20:59:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ree2D08VYx6jI5JjS2Bf1by5wWo/0kVWm/vWTlm9oQSwdVdPh3nu29TdER4la76CRbMPDRPbGrbp07lXSe53fpXqGzXemfstm6WWDtgqkP2VemX3odNuOVd+VxyYMjC+aaiPOpQCd+fp6j7nzzCsFn93f+yIzY3dS8ZiL57kbQ9agKKkBdMB9dFcg+k65bQRKFHhT52itNmalpaDWy8lRzVplmsIRpR/NsK+MPHyS+IMfNYbzeWgFnrsrDuYvKt0O/nothTgv8i3JJyKkNG9eK94eedZpTJCRu4ohSJncaLn6YD7piZvcSoTYmqy12F8KyAV/xinP9RO6tKokMoALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNchITZz9UvDre9bn9lsUugfAeOH7iFkZpaIAFd7yTc=;
 b=W7MDXybIdfhud8Y3dn5D8cTuZlgHEfgvPaB/dvwLI51meeGRv/QwxQyIFUEA8GAYtns0c7gtpuZCyS514qlbpi1oIqRvFKvZSXNlMws19bTkEmf2hrGkBJNvTPr6UZcCqB0IGMY8zVkVqnwcPuWrOr8IaLik36BkVTlTQ86LY9fDCgp9KVyyaBqbWC/KLnGjrR7wqao9yH00z/zUFJxbnaNhnWGxq425L9pkB86m/sOzaGdC3DdVF9J879ucl7abhja9/ebGNbjtPhHZrSRs0N9q5syAlJ42e0E8oypvSDrb9ERXK+wd/MhIkRfvEbmiNcc5BrrjdAqM4mhxsACQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4338.namprd15.prod.outlook.com (2603:10b6:806:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 03:59:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 03:59:35 +0000
Subject: Re: BUG: Ksnoop tool failed to pass the BPF verifier with recent
 kernel changes
To:     Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
CC:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>
References: <800ce502-8f63-8712-7ed4-d3124a5fd6fb@gmail.com>
 <20211015193010.22frp6eat3wz54hq@kafai-mbp.dhcp.thefacebook.com>
 <da0a8a77-eb71-57c3-35b9-f1dcaeaa560d@gmail.com>
 <alpine.LRH.2.23.451.2110181442220.15730@localhost>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <359bfbf4-7662-672b-7691-f82b02588963@fb.com>
Date:   Mon, 18 Oct 2021 20:59:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <alpine.LRH.2.23.451.2110181442220.15730@localhost>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0053.namprd21.prod.outlook.com
 (2603:10b6:300:db::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e1::11bf] (2620:10d:c090:400::5:4102) by MWHPR21CA0053.namprd21.prod.outlook.com (2603:10b6:300:db::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.1 via Frontend Transport; Tue, 19 Oct 2021 03:59:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acc1e0c2-5f55-4d0c-7499-08d992b4dd1b
X-MS-TrafficTypeDiagnostic: SA1PR15MB4338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4338DF0B7A463FE9C1ED91BDD3BD9@SA1PR15MB4338.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfTgxF3Io0vpmgn/vrSTjFADud8ZNs1iFjXF7LAkffyqoTlGmXyfZTH3wggg2tcKh+uQXpoJKJo937ojqMlVvv8idPgBk7ODUq4AAxhDE046FlKkPwiubl7vrpBuEuxMwc3VUoCH1fl/bblL4/2pZuDhX9SBFEXdgiIVWxEeCQY6442kgbnbwdDrQnExRD+GmBlwZ6E3pZTiNTBqj0TzJmGu1AgvcTpNX2VPK/pCK5N/FehpatIUEFvvn7E2W0sdTPyJOEGt29bgJjYDkVdAMCGSLKNl6uXsqmIvyomvX4T5H7u8QxOi2OcfawSls65zuVCRyYQPmDRMVvCCNSz4mOCEUbFUgXJRSgD0m5B9VP/djAZc7RHJD9hqQI+8MIZ4o0nD3C79gsOI5y6/EhPzaTGPzET8z7+ALFdoZ4M3UWssCVPmgODATHrgehHxKoZWW17MeiNfQBg6y1aRubzmAWVTjT7aCpnCV52z89Fef2DtTipOxEW2XWcCYsrXWmaxUeySO85w+5EEESX2Z7IGnm4+HRtiJ9cAeyBIWq801GnyoDZWJLvRsOAd1cJBsUoVYpobsCOiWjnKDeHETaVNWy075Zfcfh3AVyiCsXKstmL1klNizUbRXhfZzhRJ5BlMh9SsYJ0pejGo8ZgxiQpqsFBMKKdn7ZLWeFe+m9TtV9QCWNw4sjTREtHkz/aw587llN92WKB2HFIHk577AfGhD+dWexr3owCOaydh35elv7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(4326008)(66476007)(66946007)(316002)(8676002)(8936002)(54906003)(110136005)(6486002)(83380400001)(31686004)(186003)(36756003)(31696002)(86362001)(2616005)(5660300002)(38100700002)(2906002)(508600001)(53546011)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdQaUFsc201R0RXOVBvanhMQS9FRWRJdUMxejhKSVMrTUNLckhJejI3YWRO?=
 =?utf-8?B?ZDRubHJuVXFrV3o0dDFlUm5BSzhkUyt4UXc3ZEpkVGJmLzhJZFlKelI0S1Jq?=
 =?utf-8?B?NFhESHZXak10R2xRa1R3R3NyWmhxbFRTdXJxSVhXekRKeWNGT05udFRXaTlz?=
 =?utf-8?B?bmljMTdZeVdkeE1DaVh4em41cEFVeldEdkRXTVJ5OTJ3WUlMeXFTZlF0TFFi?=
 =?utf-8?B?WUJLZWNETVE4QTRVdW5YWXJMQ2pmWmE4R1drbTN1Mi80NWhOdElCQjJMUWtD?=
 =?utf-8?B?MENjajdZTFlaaVBjeGJ3ZzROT1A5eFlrVlp0VFRMdndZMWEya3lLQUtMdGVv?=
 =?utf-8?B?N2loaXJack1XcW9hcktET05jZ2xVY0Rpa2ZsV1Boa2RDUjg1eTd4a002ZXcr?=
 =?utf-8?B?RkNiNnhDUkFEK2pPWnBDWEFBeWRQWHI4cWFLenQ5TXpPV3pML25iV1pVRDNl?=
 =?utf-8?B?bkxyZElEWmdLdm1mdm12ek9JT3BmbEtvbTB4U1NCZDdsZFFiUk9mOTNKVTM2?=
 =?utf-8?B?YWU2dTA5TzBpL1VOV05XVDF2RmJkOGZlRkIyNHlBcFRuYkJVdGVNd2ZrMWpD?=
 =?utf-8?B?SnF6eDRZMTFYMkFBdHZvd3ZPdUZxRUxuc0ZjaGwrYmFDYXltd00zemNiYzFQ?=
 =?utf-8?B?NldwanMyRmQ5bmpnNUZheXdoclpIRTR1d0oyUTZmViswVy9IVnVsYm5jQXJE?=
 =?utf-8?B?OW5RSGJWZWVETnFVUkEwWEllekVSUFR3R2ZNODE4emRCUWoxZ1JsVzRBdWxw?=
 =?utf-8?B?RG43M2R5cEZsTTZ0QW9qN0s0Q0ljY1dqN1I0bmRMa3VOS1ExdXcvSW1EcnpW?=
 =?utf-8?B?ZWV1MitrWnduaithTk5QZDdFbnpENG5MTE1BeUp5cEJtQll3eXliYnpob1F3?=
 =?utf-8?B?QWZUUWxqZnhDcWp1cVBpSzVIWTJmaDdRWDZrcVZSWDFyOForY2E0YmRkV1p0?=
 =?utf-8?B?YkxHWGEzMFRVdEtqSzdKNEhCdE1sY2l2eU1ucVNucXo5S083MHEweEFyYzZT?=
 =?utf-8?B?Unk5dzlKYWE0cG1UY3V0eENkdnFkN1VnZUNtOWtWUkl3WDNrbUVQTjRCcUpT?=
 =?utf-8?B?QktVMUI0K1JoVForZEE3SDRid3hsRUM2OVhCTXNKaVRsUUpTMlE0WVRaaXpi?=
 =?utf-8?B?VloxYjg4L211cVAxWkwyRXRGdE9KRHlLV3FROUJRRlRvVFJDS1h1RkJuVEQ2?=
 =?utf-8?B?TGdYcXRKRThibTgzQUdEWDhwcENqM01zVndZSE53LzJBWTFsTE1vQmUxeEZk?=
 =?utf-8?B?UXgvQmd6WjU4dnZ0Q3RvVE5TakQ0SnI5VkNGT1plKzEyR04rTU9mNXQ5NnVG?=
 =?utf-8?B?WWVTajZEdWptcVRoZzRLdEVTazVWcGlTVXhJYmRIdjdMbkZjcXhOTXlwdW85?=
 =?utf-8?B?Mm40UnlTaGx3dkpHU3F2anRVY2ptQmFtK25HUU00d0VhaW1qV0V2OE0wVE0v?=
 =?utf-8?B?U05KK3dGb1E1bk14Sy9sbm4zbk1LczhpMHBnQ3VTVXJFZFBENnRBei9RNFhK?=
 =?utf-8?B?MW1taXRvT3VpeUNxbVhwclB5bENzdThSVWVtU2lqZkVBSnZWWmJPWWxUckRw?=
 =?utf-8?B?ZUNKRGxkSkFpTUV2MENuMjEwZlZUMlBjV05yQ0hKQlM3Y2I3bXFEaWZ0aXFp?=
 =?utf-8?B?bjZHTW93dDZvTzV4ZnZUWUFqT1FMVGlHVVh4d1dOelVFeTRJN0F4djUxOGlU?=
 =?utf-8?B?ZXptTnRpTUFIQVVJczRVcGEzNnFPMlFWTHgvQlZrKzFUWFpoWWNsUnR5SU5m?=
 =?utf-8?B?WkZVa2J0eXA2cVdsZ1RQclk3V01rRWZIM2ZvbnBJeGk0QmdHZjBhU1B5ZG1W?=
 =?utf-8?B?UkQ4a2hZZ1RRUjdlRVdIUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acc1e0c2-5f55-4d0c-7499-08d992b4dd1b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 03:59:35.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inRqWTZKqoR74xv8UsJ+2kgIOGSRwDKA+lnBv6VydeL9Y9YjpLDDmGR24UrcqE5m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4338
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hoTKu03fn5BbTOx9yTRNbuQRZuLK2KAH
X-Proofpoint-ORIG-GUID: hoTKu03fn5BbTOx9yTRNbuQRZuLK2KAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_07,2021-10-18_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/18/21 6:53 AM, Alan Maguire wrote:
> On Sat, 16 Oct 2021, Hengqi Chen wrote:
> 
>>
>>
>> On 2021/10/16 3:30 AM, Martin KaFai Lau wrote:
>>> On Thu, Oct 14, 2021 at 12:35:42AM +0800, Hengqi Chen wrote:
>>>> Hi, BPF community,
>>>>
>>>>
>>>> I would like to report a possible bug in bpf-next,
>>>> hope I don't make any stupid mistake. Here is the details:
>>>>
>>>> I have two VMs:
>>>>
>>>> One has the kernel built against the following commit:
>>>>
>>>> 0693b27644f04852e46f7f034e3143992b658869 (bpf-next)
>>>>
>>>> The ksnoop tool (from BCC repo) works well on this VM.
>>>>
>>>>
>>>> Another has the kernel built against the following commit:
>>>>
>>>> 5319255b8df9271474bc9027cabf82253934f28d (bpf-next)
>>>>
>>>> On this VM, the ksnoop tool failed with the following message:
>>> I see the error in both mentioned bpf-next commits above.
>>> I use the latest llvm and bcc from github.
>>>
>>> Can you confirm which llvm version (or llvm git commit) you are using
>>> in both the good and the bad case?
>>>
>>
>> Indeed, this could be the problem of LLVM, not the kernel.
>>
>> The following is the version info of my environment:
>>
>> The good one:
>>
>> 	llvm-config-14 --version
>> 	14.0.0
>>
>> 	clang -v
>> 	Ubuntu clang version 14.0.0-++20210915052613+c78ed20784ee-1~exp1~20210915153417.547
>> 	Target: x86_64-pc-linux-gnu
>> 	Thread model: posix
>> 	InstalledDir: /usr/bin
>> 	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
>> 	Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
>> 	Candidate multilib: .;@m64
>> 	Selected multilib: .;@m64
>>
>> The bad one:
>>
>> 	llvm-config-14 --version
>> 	14.0.0
>>
>> 	clang -v
>> 	Ubuntu clang version 14.0.0-++20211008104411+f4145c074cb8-1~exp1~20211008085218.709
>> 	Target: x86_64-pc-linux-gnu
>> 	Thread model: posix
>> 	InstalledDir: /usr/bin
>> 	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/10
>> 	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
>> 	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
>> 	Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
>> 	Candidate multilib: .;@m64
>> 	Selected multilib: .;@m64
>>
> 
> Thanks for reporting! I've reproduced this and have a potential ksnoop
> fix (below) which works at my end, but it would be good to confirm
> it resolves the issue for you too.  The root cause of the verification
> failure is the access of the ips[] array associated with the per-task map
> retained to track function call history; it uses a __u8 index to represent
> stack depth, and the decrement operation seems to convince the
> verifier that the value will wrap from 0 to 0xff, and thus lead to an
> out-of-bounds map access as a result.  Adding a mask value to ensure the
> indexing does not fall out of range resolves the verification problems.
> 
> As to why we see this now, I'm not sure.  The accesses of the ips[]
> values were all guarded by bounds checks, though looking at BPF code
> around the verification error it looks like LLVM optimized those out.
> If LLVM is doing more optimizations like that these days, that could
> be a potential reason we see this now.
> 
>  From 2133464fe9b92be51ec80e4db7fb23ff9e77c40e Mon Sep 17 00:00:00 2001
> From: Alan Maguire <alan.maguire@oracle.com>
> Date: Mon, 18 Oct 2021 14:20:40 +0100
> Subject: [PATCH] ksnoop: fix verification failures on 5.15 kernel
> 
> hengqi.chen@gmail.com reported:
> 
> I have two VMs:
> 
> One has the kernel built against the following commit:
> 
> 0693b27644f04852e46f7f034e3143992b658869 (bpf-next)
> 
> The ksnoop tool (from BCC repo) works well on this VM.
> 
> Another has the kernel built against the following commit:
> 
> 5319255b8df9271474bc9027cabf82253934f28d (bpf-next)
> 
> On this VM, the ksnoop tool failed with the following message:
> 
> [snip]
> 
> ; last_ip = func_stack->ips[last_stack_depth];
> 
> 141: (67) r6 <<= 3
> 
> 142: (0f) r3 += r6
> 
> ; ip = func_stack->ips[stack_depth];
> 
> 143: (79) r2 = *(u64 *)(r4 +0)
> 
>   frame1: R0=map_value(id=0,off=0,ks=8,vs=144,imm=0) R1_w=invP(id=4,smin_value=-1,smax_value=14) R2_w=invP(id=0,umax_value=2040,var_off=(0x0; 0x7f8)) R3_w=map_value(id=0,off=8,ks=8,vs=144,umax_value=120,var_off=(0x0; 0x78)) R4_w=map_value(id=0,off=8,ks=8,vs=144,umax_value=2040,var_off=(0x0; 0x7f8)) R6_w=invP(id=0,umax_value=120,var_off=(0x0; 0x78)) R7=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000
> 
> invalid access to map value, value_size=144 off=2048 size=8
> 
> R4 max value is outside of the allowed memory range
> 
> processed 65 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 2
> 
> libbpf: -- END LOG --
> 
> libbpf: failed to load program 'kprobe_return'
> 
> libbpf: failed to load object 'ksnoop_bpf'
> 
> libbpf: failed to load BPF skeleton 'ksnoop_bpf': -4007
> 
> Error: Could not load ksnoop BPF: Unknown error 4007
> 
> The above invalid map access appears to stem from the fact the
> "stack_depth" variable (used to retrieve the instruction pointer
> from the recorded call stack) is decremented.  The off=2048
> value is a clue; this suggests an index resulting from an underflow
> of the __u8 index value.  Adding a bitmask to the decrement operation
> solves the problem.  It appears that the guards on stack_depth size
> around the array dereference were optimized out.

This is a case that compiler optimization hurts verifier :-)

  frame1: R0=map_value(id=0,off=0,ks=8,vs=144,imm=0) R1=invP0 
R6=invP(id=0,umax_value=15,var_off=(0x0; 
0x1f),s32_max_value=16,u32_max_value=16) R7
=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) 
R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm 
fp-48=mmmmm
mmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm 
fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm 
fp-120=mmmmmmmm fp-
128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm 
fp-160=mmmmmmmm fp-168=00000000 

130: (b7) r1 = 0 

; if (stack_depth > 0) 

131: (15) if r6 == 0x0 goto pc+2 

  frame1: R0=map_value(id=0,off=0,ks=8,vs=144,imm=0) R1_w=invP0 
R6=invP(id=0,umax_value=15,var_off=(0x0; 0xf)) 
R7=map_value(id=0,off=0,ks=8,vs=144
,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm 
fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm
  fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm 
fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm 
fp-136=mmmmmmmm fp-1
44=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000
132: (bf) r1 = r6 


At insn 132, even we have r6 != 0, but range of R6 still shows it
could be 0. This makes later r1 - 1 will give a bigger range than
it actually was.

Your workaround below looks good to me. Could you send a pull
request to bcc? Thanks.

> 
> Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   libbpf-tools/ksnoop.bpf.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/libbpf-tools/ksnoop.bpf.c b/libbpf-tools/ksnoop.bpf.c
> index f20b138..51dfe57 100644
> --- a/libbpf-tools/ksnoop.bpf.c
> +++ b/libbpf-tools/ksnoop.bpf.c
> @@ -19,6 +19,8 @@
>    * data should be collected.
>    */
>   #define FUNC_MAX_STACK_DEPTH	16
> +/* used to convince verifier we do not stray outside of array bounds */
> +#define FUNC_STACK_DEPTH_MASK	(FUNC_MAX_STACK_DEPTH - 1)
>   
>   #ifndef ENOSPC
>   #define ENOSPC			28
> @@ -99,7 +101,9 @@ static struct trace *get_trace(struct pt_regs *ctx, bool entry)
>   		    last_stack_depth < FUNC_MAX_STACK_DEPTH)
>   			last_ip = func_stack->ips[last_stack_depth];
>   		/* push ip onto stack. return will pop it. */
> -		func_stack->ips[stack_depth++] = ip;
> +		func_stack->ips[stack_depth] = ip;
> +		/* mask used in case bounds checks are optimized out */
> +		stack_depth = (stack_depth + 1) & FUNC_STACK_DEPTH_MASK;
>   		func_stack->stack_depth = stack_depth;
>   		/* rather than zero stack entries on popping, we zero the
>   		 * (stack_depth + 1)'th entry when pushing the current
> @@ -118,8 +122,13 @@ static struct trace *get_trace(struct pt_regs *ctx, bool entry)
>   		if (last_stack_depth >= 0 &&
>   		    last_stack_depth < FUNC_MAX_STACK_DEPTH)
>   			last_ip = func_stack->ips[last_stack_depth];
> -		if (stack_depth > 0)
> -			stack_depth = stack_depth - 1;
> +		if (stack_depth > 0) {
> +			/* logical OR convinces verifier that we don't
> +			 * end up with a < 0 value, translating to 0xff
> +			 * and an outside of map element access.
> +			 */
> +			stack_depth = (stack_depth - 1) & FUNC_STACK_DEPTH_MASK;
> +		}
>   		/* retrieve ip from stack as IP in pt_regs is
>   		 * bpf kretprobe trampoline address.
>   		 */
> 
