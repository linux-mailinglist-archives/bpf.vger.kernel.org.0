Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C136A8B5D
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 23:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCBV5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 16:57:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31996 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229607AbjCBV5O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Mar 2023 16:57:14 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 322KUwBR013159;
        Thu, 2 Mar 2023 13:57:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=rjF3J9jRxYeh48TbY8D8EhYps/kjN1ol6fys7rdTRKA=;
 b=g1nxCQG9ViG3TNx0GU6/ijRGrDUaE3CShDcpJN+b6m8n0iCHm6lefBvXfGmURrBX3DJ/
 TJJqqrmuXRt29nnAG/SAt8YPZbox0Duy7BdsZIhla9FnBYglnEttlL+guqxbNkJ5ZJPY
 6N1PRk63/D7tVcbwXAQWYr+TIBQYm72g8NOvhWT4A/n2FM0ybfQEAYk4mexj1Y1nztPd
 HInvGaJJEVdaV9o18hpAdZFuE4YndhCbG7d+SDkrsSMHgLD6xYXv8OZhbvANzGZuKhsr
 UxNmBhFmQ/2WXyLpF2BRr2KnkUbuT8skNb9rmSXgK3koUnPumQWZOtgDzVAIlsxQ1I+O Dw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p2uad44u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 13:57:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9ibl7LVUTcqP07tGr5iSBsRGRAwRAbRmRGkH5UI0/89ZLB1Hq5jRn41UnVF2viHh3mPJgn7Hg33OcvS6FPVRgJ82bHqMgt1I2PfySTfxKex612ok843GQHeimSLgSeXD6/57eYkb71dST2UvzHlNVjAQ+wGoFLBzDEIi4tnIn3p3/ymbVZqtD6jlgIrn3y50wYNnT898jX2NglmbdKbVjX7iHmjSectGUcs+mCCfWa/qT5IaWUavomLh3vRxwckqMbCIOBsVV0to2Ahfb1i6wOzeyYM0B0sFPMd7+GnoqBZvwSn9dl6gJlkVl46r0RNNAfXofNEPVvmNzQKV7rtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjF3J9jRxYeh48TbY8D8EhYps/kjN1ol6fys7rdTRKA=;
 b=YqD1eNK2R3vZRIysSiC6/IJzPdHVKJyzQ3mpuyyr8YMTvFsai+CgVFQOsUiYKcl34mZm3vzz+Yc2qFEYckQaBMxRuvlk7HVsngMnzMYHymdGiw3KExIF7mpP6bNowP5IIgWHXwvbDPVml3Rp2tI84nTTuJU30LRO8mxxwpdc7rbJKE14TtaKhrosVhblgWTb2wuNYCGpUQKOYjZB1M5HEAwzcceUwP/bWDMPtMqTl0uuC+aRNiFUsIAeokPRHlELBf35NcqztniR2eEYHbJN0DZw5X51Cp+ioQM2n5Z77TW09nNgcr2cDuwDCsHg5xntVup2DlZN1RnjIX4hmkXO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA3PR15MB5653.namprd15.prod.outlook.com (2603:10b6:806:318::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:57:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6156.020; Thu, 2 Mar 2023
 21:57:10 +0000
Message-ID: <be155f17-53c3-0a44-3800-c3f2fc2d6915@meta.com>
Date:   Thu, 2 Mar 2023 13:57:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: dereference of modified ctx ptr
To:     Barret Rhoden <brho@google.com>, bpf@vger.kernel.org
References: <faa3ab66-73e5-0532-27ff-dc2c4cfa8dcd@google.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <faa3ab66-73e5-0532-27ff-dc2c4cfa8dcd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA3PR15MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b8b0fd-2d8e-4957-b4c3-08db1b6912d5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKppxoED60fWx7jMyNH4ScE0Yufua7OdUQz1bmcgaxuggYFp6ERK3G5gYeEiqrg2A0PtDwmTbRPJRpVyHKSvX1v365S3DXys9EoU1nACH9VQP5G+B9cDLlxF7Kt0HQR41j4IxFBE8cr7MS+ZRI+fn4z2NGJ8wUbSerm/CmKv5DPzx3CBdo44KFUJm7JnsMu65cts9b4XMip4L5Q9XpufHlgCnr3oGPy8MrWIUdzcfbutG/oo2OCvXlLOAIzeljcB+FP9JWqIR3giJoXFS71Z9lO03TDeyTVeK0QD7Cpts+OQDF96ObBptJ5cgVQ/SLH5qqz9jyFszcuU3lAfQZvA80Q6uEbs5AM6T1dqiU5o3Ut2InD7Mw/WECORV1wCoiV4p2WEmMkWctb6I3pDvspwOPmCBFPLcHXaSZ2acj255SkYZTC4W7FYbjxVVhdQp6fD9EROW1OimgMwDqQi+cBzsoeUg/jB2WJbvGhQW0lE6EhyCj4ArwQOtE29m/bPpJlk1q4yNsV+ljDdjK7JMudPmUonORFXQU3CKrOiWMp9CiJFuNAGj2aPLNheijJwJ2VCQmfX4gIjoBsV8E3uMSIyZcfGodQJl1YhYJ3Bp/V2OuP7+t7DfGApTX7BVHXHaN0LbPbne4QEcctdjMaBgVqnyckpEFmtLBhI9efUb9zVuNQRPT85x/lg1BzOWeWh7ciWFqUa4E/F4oBoq3A0YXMNfJd7fLKU3VCoiyxy1mlAlHhDZ4+4e/2qlMJfGUBVPF4hV6+g7/RyApokikOxnskvOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(66899018)(66476007)(38100700002)(66946007)(53546011)(6506007)(186003)(8676002)(31686004)(5660300002)(66556008)(478600001)(2906002)(6512007)(8936002)(966005)(6486002)(36756003)(2616005)(316002)(31696002)(83380400001)(86362001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhzNVhtWDg2RmdEVTVmSlhOL050ZlA0SCsrZ296L0RNekxwOTBoTnY2M3Zm?=
 =?utf-8?B?ajROVGtZT0FRdnljOFAwdk9qb3I2dVZFcVR6WFBib1o1SlhuVFM0WmFSWGRl?=
 =?utf-8?B?citGaVRxUE5NR1dSazFJdDBET3pOSnY5a1EwMlF3VElXUUh0dG1xTHIwTGEz?=
 =?utf-8?B?elJ4TzFmZU5jbnQ1bkpGU3BJdC9iNU1uaFJZVWVTeFVGUTlKS0FISWFkTTVm?=
 =?utf-8?B?eTFEU0FHa05qT1V0OFprS3gvdjkxQ3VQdk9RTEFmNUg2eGtna2hZN08zNnhu?=
 =?utf-8?B?QndWWWwrcEJYQjEzS2FwQ2hQTDBKV0pnMlBKSmgyRk05ZUpvZzQ0bXE4SlNl?=
 =?utf-8?B?UkFoT3RiR1o2M2FRbWFicjJTanZUTzBWcThFNmIzWHQ1bnE3QXd4cCsySDVO?=
 =?utf-8?B?SUFpeERCbXpxSDFUR3QrRmUxUC9rbnJGWFE4YnJ0SUlFWjkvb2w5djdoeTNM?=
 =?utf-8?B?THdmQ2YwNlJXOEtvbFp3eUx3WkRXUFdnVlFQZUlOU1M1R3c2QlFnZW5QVU1q?=
 =?utf-8?B?VVRINWIwdUNCTjcrMVFNdTZBSU41TlRhYWV4U2VlTGtkSk9QL3pKbGpkSkhT?=
 =?utf-8?B?bnM0T1JiTzRHeU5SU3V5ZGppeFBzTk54eElYc1QwUDZhQVNKU2wvaEc0ZjdD?=
 =?utf-8?B?c09yK3R3Q3FHOElDOTZFUDhPenIwbFJHc1BkN0RTb0JybmtrNkhCckcvSkJ0?=
 =?utf-8?B?OVVCdDkxZ09OZTNmQVprZmxUVTJrdVNiRkg3Rno3NnJJT3dONENEb0puOTY1?=
 =?utf-8?B?MExLTWpPZStmUEIySG5ZQVRQWkxUb3BGQi8zN0tsSi92T3pDaXIzQWQ3OSt5?=
 =?utf-8?B?Yy9VSmVIeldoNDg3dGROcU9UVXoxQ1ZOOEtXemJ4L3BzV0xhZUlWQzVId1Bk?=
 =?utf-8?B?RzJSckNOT2tBWkpNUC83VVFUWDBybHFlWFVWWmxIanVER29YTW1qbmJndGNn?=
 =?utf-8?B?WkExVjhEOHJ0ZW55K00wRVZzc3NrelYwd1hNZ3dDSk4zY0diVnc5VlRGR2dZ?=
 =?utf-8?B?VkcrQUZidFVFK2xSejhSVUJrdUdpMmhWQTJtWCtZN3FKVHUvL01kRGdpd2ds?=
 =?utf-8?B?Z2Z3V0Z6NzJHNkRTeXJOa3VIN3VOS29JeVkrRjhQZjh4MVM1TDU1cThGUUlK?=
 =?utf-8?B?S0kxTTdrd0U1OFRJOGsxUW9CNzY5MEMxZzhPeFgzNTBWc2VGZmlPZG5Ycnp0?=
 =?utf-8?B?SzlRcmdqd2xuMHdjV0RLMGxhdDdPOTlCUTZ6dzUzWUl0NlZlb2RPZFJDU2Jj?=
 =?utf-8?B?SGxpbFRxSkZEc3h6UWdEcFlsMGtndHdvUXNOYnNNblo0Y2R1cElPcHg3eURJ?=
 =?utf-8?B?elExaWZmelU4TXFKR3I0RDZ0Zm5wUlpjeXdwWmlaTDRRaVhWejZLdzArZ1Jn?=
 =?utf-8?B?L3BrYzZ0VEZCcEZOKzFtT0pHeXh2aGZYSVZsSGtQODdVZGl5Q21pS1UvVERG?=
 =?utf-8?B?N3ZPR2RoSW91S2d6MnM5bytaSm1DWnV6YWU1b09nYjU0QjRjL1BNLzJCOXo2?=
 =?utf-8?B?SXhwSksyc2hGL0NIUVVrOUNOUVZSZjBnRWloTXJEc0JUY2h4WDdoQkVteGZl?=
 =?utf-8?B?aTI4eHVoSmMwMEVBZFNrY1Y0S2FnR29ZUGdDZXprTVFVZ3BKMVBLckZ2cWgy?=
 =?utf-8?B?ZS9TRkpabEpodi9XUG1ybUhqd2p2TFBXMGU0MHdkTFVKQnZvUlV4bzZhd1Zt?=
 =?utf-8?B?eVB3L1pkeFFYM1NhT0lsVU1QMGt5WXBNeHRLeVBTUUwxZXFZZHFoOWZrU0NO?=
 =?utf-8?B?QkJYKytGbHV5OFRtVCtvdCszZmFKM1dwVkdiMTlJaFVxOVRWVkdRd0llRGVt?=
 =?utf-8?B?c3dFVmNrYkIzaVpHa0lEeHpEUklNWEJQNExVR2MzaFhoZ0NIMUZYM1Z3U3RN?=
 =?utf-8?B?TGcyUUNtVGNyemk3N2dZeTJCNmFoK3ROQ2J4ZGlqVVk3aXo1TUs2ZFlHVXh6?=
 =?utf-8?B?aTV2dzZNWUhFUDlSeFpGK3NsMC9LK1R0YmlwRHFXaFhzL0Z4V21YbXZVcmZr?=
 =?utf-8?B?aE9pbldRclBlMWxUTmtDVjdmZkJZNzFKWHl2ZEF5QWpYb01TSS9jeWYwQkNH?=
 =?utf-8?B?aC9VanJaWlZlZjlpVm1PVzl2dVNBTVZvc05wWVdXMGRGTFJiV1Z6THh0czZ1?=
 =?utf-8?B?R2VYVDRyTlZDWWRJa3FoeXVNM2c0cFdmTmEva2UxdHlyRUJITkNFRVZhWnJ1?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b8b0fd-2d8e-4957-b4c3-08db1b6912d5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:57:10.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIsJz4VEDoolHWmZWvzG2nMR7hOpgmyL9y0PCFlqRYyqfZTxIZuXwz6oKTujoW4v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5653
X-Proofpoint-ORIG-GUID: OwKJOIknZI6tJHiZMI-QBBFQIKygrj2g
X-Proofpoint-GUID: OwKJOIknZI6tJHiZMI-QBBFQIKygrj2g
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/23 12:12 PM, Barret Rhoden wrote:
> Hi -
> 
> Depending on how complicated my BPF programs are, the compiler may 
> modify a context pointer before accessing the context.
> 
> The specific context is our struct bpf_ghost_msg:
> 
> https://github.com/google/ghost-userspace/blob/main/kernel/ghost_uapi.h#L385
> 
> 
> But in general, it's something like this:
> 
> struct bar {
>      unsigned int x;
>      unsigned int y;
> };
> struct foo {
>      union {
>          struct bar bar;
>          struct baz baz;
>      };
> };
> 
> Given a struct foo *p, where I try to read p->bar.y, the compiler 
> usually emits something like:
> 
>      r1 = p
>      r2 = *(u32 *)(r1 +4)
> 
> which is fine.
> 
> but it could also emit something like:
> 
>      r1 = p
>      r1 += 4            // uh oh!
>      r2 = *(u32 *)(r1 +0)

Do you have an example that compiler generates code like the
above? In bpf backend, we have an optimization to capture thing
like this and optimize it to
    r1 = p
    r2 = *(u32 *)(r1 + 4)

> 
> I tried getting around it though various uses of "noinline" on functions 
> that take context pointers (or the union structs), e.g. here:
> 
> https://github.com/google/ghost-userspace/blob/main/third_party/bpf/biff.bpf.c#L405
> 
> But that's extremely brittle, and the compiler can legally modify 
> pointers to get to internal fields.
> 
> Recently, I've taken to just copying my context payload onto the stack 
> and copying it back, which keeps the amount of times I run into this to 
> a minimum, but is not ideal.
> 
> Can we change the verifier to allow a ctx pointer to be modified?  Or is 

We cannot do that for complicated case. Note that "ctx_ptr + offset" 
often subject to rewrite, so at verification, the verifer need to ensure
the offset is a constant. This may not be the case. See an example at

https://lore.kernel.org/bpf/CAA-VZPmxh8o8EBcJ=m-DH4ytcxDFmo0JKsm1p1gf40kS0CE3NQ@mail.gmail.com/T/#m4b9ce2ce73b34f34172328f975235fc6f19841b6

In such cases, you could add memory barrier to prevent some llvm
optimization so the result code will stay with "ctx_ptr + offset" format.

Also, Eduard has worked on this issue for a while and currently it
is in progress.

> there some other trick I can do to prevent the compiler from modifying 
> the pointer?
> 
> Thanks,
> 
> Barret
> 
