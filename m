Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FFE585447
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiG2RQQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 13:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbiG2RQP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 13:16:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543911A3B3;
        Fri, 29 Jul 2022 10:16:14 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26THAt2m022208;
        Fri, 29 Jul 2022 10:15:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4gvml83LXFU0FxzIq1ekL1fpa1EM18O+ZOCHKO+dkuM=;
 b=Dcp6BmqEkDdW3MrPwqBnAZsn3XJwdWkZ2LFqbATBDSky0iJQgvsc/MIMyWwPySNJlt/Q
 tpaB6dHJT4oZ9NB5KCa0MCwYWgJBc7chTMclIzBCuBXhIrmbV2kDS7m5JgY+y0r5Te/a
 9tOPkpsf39heQpFxUB+WdF8BHEjy+q1D6jk= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hks0q28p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 10:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj0dP73NnkXgUVyq9eSmUXCn5+lGRdHdP5Hl1VjKr8e8ca1D3I3fIWekn9MmET8fgiUqPXCh5xf+YLWo16uwBn2cfG9jwQ5x91euBazy2NrXSzakik4isMOaBilj6MbcZ/aEPJ9r25t4OAnBrCdQ27d1opDl3NjuCtNh+QTayO1trxrEbHU4Z1jV9RCc/l4uckn/iQaX0tCz7YyJIT4N9cTCaqiqGP+/M4AR52w5CfB3t+7OL4TlrRJPV4UJG+fDJe1dliTXi2hFZSNXDKP7z3jM/xEXqdoSMuTaUkJEaMSE6ty5JKRXu8505AX2zHfPufEcTjDS8QeIhl6myJz16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gvml83LXFU0FxzIq1ekL1fpa1EM18O+ZOCHKO+dkuM=;
 b=PFqiblukEH8kwBYrQGFPruNkAqsnrbvH5gl7arimJbOkbA0kz8DBY1T9bpBcl0SeuaIVUHyJHGJwBxhQTd94T5JNEM1qXgK/oNpvBNi1fz12qV0T6pGjJoFJCzPia0eDQ8YdTSSB29gn3f8696SRoWLJGhw1Z9G2AsZ9n0WRwL/aUicf/0wAPNALq8XRixIbFG3daSIHiIcAkXj8HcX76Ka/x/6AI6lZ6FL36Iv3xlld0kKv8mUNiDJOYt/31NFtgp04S5DAsXvPbtPNq36yQUSR72k4mXFkUcJVLYU2IyiZkwQPpwjO6/csH/4UKNWHTPJD8OXqvomONeyLRZEITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB4269.namprd15.prod.outlook.com (2603:10b6:805:e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 17:15:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 17:15:24 +0000
Message-ID: <e186cbd5-4c22-8069-717d-35bb8f8e4fff@fb.com>
Date:   Fri, 29 Jul 2022 10:15:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] bpf/verifier: fix control flow issues in
 __reg64_bound_u32()
Content-Language: en-US
To:     Zeng Jingxiang <zengjx95@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
References: <20220729054958.2151520-1-zengjx95@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220729054958.2151520-1-zengjx95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfd7346e-c8ff-424f-ea15-08da7185eca8
X-MS-TrafficTypeDiagnostic: SN6PR15MB4269:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evMOAso4mRn0P4KYECUowEjFTrcrmPFUeXm9j1uX8xlADTP2l6eHDUCLgk6aHg48J/0zo/Msb/MLLRlMagb1UvCVTr4R4R1sAcrjzBVOG5vdPNq6cyg1h7332wldu5MJIzHN6qJpXU6hkDvmaWdN9I9d4VGClTJgJSBxWs+Ph+JQMu0n8KzWLcHhrDRAxUKALfSMBpMaEA3R4uIRR2miGDca9ZLTANy6E3uq1stA/rBQoPGiBx1fZ02hsJ306byKaA/S3NkPTdkGuYf3r8tDu6N8EequXIrN2ZXittYX2Z7gC0QVLig8Yt5blROz82vTojXTPiNRX6hefx233KbQaacrpyKdMCXeGsLI/H6j5QoBe/MROD11dVW34EI2SARM79RvrsM4vmKWWZI2QnX48HOAvdA63IqbYSrXSVn3JgtwhkN1q2o82Pe9RLJaS0IXxwc7era8H2QripLuBnvTXNutFANYn8Aes7B76WUqQeEvI/i8r+eRjWC8HI02XYJOIVHRFMf1ah/fJuwTws9+x47rUmg7I/G130hdWSgdxwKAeVqmUilGdpCeJ9TrGsCtjEuJl6guzN9JTcZ9crBybrGWDXp3WEHmwGHazFY/wmrolr45O356dlvJjOs7vR43Zz+cc5XyzJ2QsAwrZGg2drFJteqswbFkGcKz5+m5ddhp6qvYtEG1v0n4hrWd74xqJ5I/nV8thEOy69baoTd4IncIIEqA1vRiQRROes+afHUN90/nSwp75cd1pH/1dRJy4LbkltyiISkGjy6CLYXmeyfYtPmf1wBKIA+qd4//9BcqWHeouD8LlcnLK43mohe/tQCbeHtVZGc7PyYDyqCkarFc0Je+RCdBXWNIX+5P8Rg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(38100700002)(8676002)(921005)(66556008)(4326008)(66476007)(66946007)(316002)(31686004)(8936002)(7416002)(5660300002)(83380400001)(86362001)(6506007)(2616005)(31696002)(186003)(53546011)(2906002)(36756003)(478600001)(6512007)(6666004)(41300700001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0l3WWc3eDdXaWVhQ3ZoVndsRGViUDRaTVNublh3dUxodUZXRzFaUjN3WHZ2?=
 =?utf-8?B?STIzc3o5KzdHVlZkZHc3alhrcmptaGpWVmMzNW9iYVFuaHFGNjVnUFhpbnpJ?=
 =?utf-8?B?UEdXU2M3UEljSkd5SzJzeXc0YkhVU29VeC9YaC9TbUZzWHpWM0lNeWV2MHNq?=
 =?utf-8?B?dm1oVUlyb3ZyY2RPSUVQY3JGaG9qbUE2bFBSNVNPUWFsVEZ6bW1zNzMxY1V4?=
 =?utf-8?B?b2FjVEgyWU4vNXN5TUVBMG8xTEI3UWpiMTIwS0JTSThJalZqeUd3RmxoWU9u?=
 =?utf-8?B?citOamRxZDZhVkJMdlZIK1MzQ0R2aE9CODRPTElPNmtYNFB1dFFJQ20rSC9S?=
 =?utf-8?B?R1lyU3ZscGJ3dEwwdmtYMFJWSFZqTVYyS1A5SWp6M1lybDd0RHFucHU4YTFu?=
 =?utf-8?B?N01aa0lzSUh0OGNpd2JBWklmZUFwWTNGSVZMSTVtS2tHbGd4SWhqemRQZmQ3?=
 =?utf-8?B?aHB3K1BscWtUbnRyczFVbGtLNkJlbXIrK0hzOFRhbDZ0anV2QzlRdFgybGx6?=
 =?utf-8?B?NjFBaDRzV2lSalkyWEhLL1dLeVBTYUdNeGNicWZwb252WWw2cDI3L0pGWURQ?=
 =?utf-8?B?Wk12aGZSN2dXdFhvdi9EYko1YWhGckc5RysrbXVoODN1NGtHeDJIWmtFeGpy?=
 =?utf-8?B?STljeXhWeTJlRjE0RzBpdnlaVXU0ZEx3WndzOGZESmJCZVFNNnJ0a0FOZTIz?=
 =?utf-8?B?WkFTK1NLZ0Q2dmErMXk0TUtQZmVsWk9KV25oSUQ1M3RqSHlaRVRjVGNqb05D?=
 =?utf-8?B?SVh2ZlRxalVDQVlEa1hxelJyd0IxMlVWcCs3M1RrY3RqRmNLWk82Q3I1OEZ3?=
 =?utf-8?B?V1lRSCtPWXo3MVBVYTVHZk54ZEl4bG5rRWYyb2JSR2FNVy9iY2hxRVordWZx?=
 =?utf-8?B?V1creWlIKzFpSm9ScDZYZE9ZNGtUQ2l1VGU2ZFVuaDErVVNGZ2FybXV1NUk0?=
 =?utf-8?B?TFhWSFpYeXk3bG5iTG8vREJubC9ZRXR6VThzYnFKN3dZN3N5c0Y3T0FqTk9R?=
 =?utf-8?B?NXlNNURNSGwvS2wyRXJVM201R0Q5NkF5c0k2U1ZZRFJvTzJwL3pSOEd2SlZP?=
 =?utf-8?B?SmUrRHpld1N0RGFCcklralU0cHkxckNkbnlRT01GN3RVNExRUG95citmcjN4?=
 =?utf-8?B?Zzd5RVppZysyVUhtRDQ5REhSZXB6TERicERxSHlKdnVydU9QQVY2WjBHOWhr?=
 =?utf-8?B?VzNYd21Td3dwOGdDakxVbFdrSkFSNEU3eDNjaHRVQkhyemVsN2pNdjVodUNn?=
 =?utf-8?B?S0lwV2JmRk5vTVpZTmpiemZuK0ZJTzl0UnZCbXZiZkV6Z2hVK1RSVTV1bXdl?=
 =?utf-8?B?ZTJtUEpEU0hpb2FEK1FnZGY1YVdQT3RVS28vV3RoTXRFNDhybnloRHFIMEhn?=
 =?utf-8?B?TFdlaDJJMHp2dVZtVmlMU0lHanNFUXY2MWZrNW9GS1hRQTl2T2ZZYllNTjhE?=
 =?utf-8?B?d0lDdjZ3RG9reFFVaFUzTzMzRU91N2l6b1NYU2NTQmRJSzkyZVRBNWxvd2JC?=
 =?utf-8?B?eW9XQ1ByVjgzU0M3YjZTODl6WEFPTXdKQUtnSmlsM1huYW44OU92T0lWbTZn?=
 =?utf-8?B?NlNQdFN1Zzk3TzJGK3pEMjh2d0MrZ0VuYmlGYkNnTFNvSUExYTZzZSt0bXBm?=
 =?utf-8?B?QTF5ekphNCtRS09wbmpRSTBER3JvSFZHVVNzejJQQm83Z3Q4ak15bmlERmdH?=
 =?utf-8?B?MXhWZlBGQjR2VzFubCtpa3F3QnRmT2pVRndXK0p1cVc4alVEd05wQVI4Nlhw?=
 =?utf-8?B?b1NRU2d6eHk2QXFGb2lLT1B6Mng5c2N5a29YR3h5VTk0ci9EQXdNQlBabFA3?=
 =?utf-8?B?dE9TWFovV1NKTkw2WkZXelFuY2lTVHdDMWVJR2laR1lLbWswOU5nejBucnR5?=
 =?utf-8?B?bU1vamNWbkliVHo4STYrSXh1RmxiYzFpcGY5MVErekxteHp1bk43Q0JLWHBL?=
 =?utf-8?B?ejV4ZG4wTEpNbkd2d0tvdTkrUVBYTlJ1SlZqdFh0ejhCYzQyL2xSenFxMHIy?=
 =?utf-8?B?Zk5hWlFwQk1Bd0MvZzJkd3RqQVZ6QldIVWp4U09yQTNCMjNvN01zTUpTaFRY?=
 =?utf-8?B?ZlRTUGhVeUtkSGdmTlBYaVE0TWRvU0lMMFpMM2s4NWt5azdubGhZYjVRdkJk?=
 =?utf-8?B?VVlCNGpMQ3g5WFVqZWQzcVh3aHBPTUViaXc1VzB1KzdqcjZnb1E2Y1FzQkxQ?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd7346e-c8ff-424f-ea15-08da7185eca8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 17:15:24.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYIBPaq1gWM0Q54W3w0DtLrQ4oO/KtAee0I9Y5ZwsJJJBkpSbZEsHXftVvd40cbO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB4269
X-Proofpoint-GUID: H6i5fn7BmQreupWrQi32B6g-vfm4nMSG
X-Proofpoint-ORIG-GUID: H6i5fn7BmQreupWrQi32B6g-vfm4nMSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_18,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/28/22 10:49 PM, Zeng Jingxiang wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> This greater-than-or-equal-to-zero comparison of an unsigned value
> is always true. "a >= U32_MIN".
> 1632	return a >= U32_MIN && a <= U32_MAX;
> 
> Fixes: b9979db83401 ("bpf: Fix propagation of bounds from 64-bit min/max into 32-bit and var_off.")
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> ---
>   kernel/bpf/verifier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0efbac0fd126..dd67108fb1d7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1629,7 +1629,7 @@ static bool __reg64_bound_s32(s64 a)
>   
>   static bool __reg64_bound_u32(u64 a)
>   {
> -	return a >= U32_MIN && a <= U32_MAX;
> +	return a <= U32_MAX;
>   }

I cannot find the related link. But IIRC, Alexei commented that
the code is written this way to express the intention (within
32bit bounds) so this patch is unnecessary...

>   
>   static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
