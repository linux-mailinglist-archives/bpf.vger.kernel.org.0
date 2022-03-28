Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AEB4EA371
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 01:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiC1XMG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 19:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiC1XMD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 19:12:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AB615FC8
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 16:10:21 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22SLL0At025331;
        Mon, 28 Mar 2022 16:10:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jxz1M+WVcSas3v6+jMbjqNBmDmMk2JB64Tdo2fYFnkU=;
 b=P7SRIAeim75omu/4/zIAumTEDo3ZG9ljCCmjqugaMW2Xu0rMZ8YfgMKQjGSUsfaQkifm
 DpVsUrAPPYOiBDSKrbzCcA/wsJRUJWpmbqm4ZoErF2I3vNVdXHiH/a3UCODqtPOaoIXu
 QzwFbUPpzlbf8aKrsS473OrICL3ai/LJ3t8= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f1yxtpdvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 16:10:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heQMN9btoi3ASThGYuitfS3vR21teKHAxPss1NliN2IABNfSHcBpqUqgltssICZBBEdowBr9FaDRjsOEg1CECMq1K5JWLHOLIQoksHFbsHOwiDQkN3Y6gMtZTh6jpjHZeYFadJ43CnJ/ZUoIQZfyM6tpYvZAcZTOPtFqeIAlf7RijEsySgd7aW1nC3SyJAm768oxT7MsA7X1MvKAjOD/DYYaO3IHm5Aa/VAgHA5Yuc6YfiSFZzKzD75vYUjyXjPYyvaS5K/h89KpVD8Pg9FT510gCPk5e1KFZiTrVnkWZuSNt6AWFlHWfCgLAQFWL2wdOysYlC2bM4zjUUrADXmFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy7E/YBiGnZTag9hvHuGxM3fp4/eVzC3cQMYv0dRQes=;
 b=ctUUh8p84sT0C9Fw61dcKrtAg81cccVAaJda0OXKpfk660ZA8HCexj3Iw8kc8kncEsByySkOQaOQ4qG4MxTjwuuPnujO3GxugjmdQIm/zLuQoDjLErJWmcftFsxbQn9UmCg/DrOciQEUN5Hk6f99Ax0N8Nt5JT5CeVqvizqPSD/zP7nYNmO31EnijClo777WbKupyvFN5mckwBGAvysyf1/5sfC3m3by78sExJ/CnJie0TNxDalTJZ6itXFTUOv6P2IMtCxZjAva0Bw7JjYsWW2HUnoJqgtpwmIk1knKZ2sCrTtaGfE7FVvRttT++c1LSaO+fehiuhEq0wMnvf5WXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB5083.namprd15.prod.outlook.com (2603:10b6:303:ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Mon, 28 Mar
 2022 23:10:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 23:10:15 +0000
Message-ID: <8b498619-a08e-0c4c-c1d3-93dc9cdbc1f2@fb.com>
Date:   Mon, 28 Mar 2022 16:10:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] [PATCH bpf-next v2 2/3] selftests/bpf: add ipv4 vxlan
 tunnel source testcase
Content-Language: en-US
To:     =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Cc:     kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
        ast@kernel.org, andrii@kernel.org
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-3-fankaixi.li@bytedance.com>
 <1e206112-c610-d4e5-1ab6-e78ea3e2dcea@fb.com>
 <CAEEdnKEF=EfiXsQX7HgPbj2Fz2Un2km1nb=SgK8uNNYxsP05cw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEEdnKEF=EfiXsQX7HgPbj2Fz2Un2km1nb=SgK8uNNYxsP05cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MW4PR04CA0261.namprd04.prod.outlook.com
 (2603:10b6:303:88::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c657ea9-47e7-49f3-f370-08da11101e29
X-MS-TrafficTypeDiagnostic: CO1PR15MB5083:EE_
X-Microsoft-Antispam-PRVS: <CO1PR15MB50835AD3814F7FA54F647BE2D31D9@CO1PR15MB5083.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDrT3s0ryQ+qOcWRb3UnyTy5X+CwJk+XA0R9ohG+CBQivTRxFCyI+cEaEpYVc7NWzJLyOR0jgibvxTDkbszzCUXHCORDDeCt9pa6T5aWKCcMHChYq6HS9QbFMfICMCFZf/2RLYQGjFVMjcNiRSj0icfQkNXtb1xFavQWFz1CTDwvAjjQTPQoUHAjuiPe3/uBpgwdtRmlpcl3vy58cNg6/Eundmb97re20UJatRox3AhxNbgbCapCb0+MV3whBYGoX2mgvwQQDZM/hPLPuHDL9m4acUbFVacC5qeKpmOisNYGUDgsXrAklAIrsKPYZMExCjyjDWzfW5+MXTXSfBTuC0r+Lw3BiYAjYVtakwAXS/Z5F2UMJAe2S8wa2f9grfkliVkRk7AtAc1BfbSkMQXw2JS0jKp3XVONHj91bNMMyh+XW3QknB7Q7lHuOU+S+52pgYljgfPXIfaQUGmUq5pxZqsH7TEXVCdSTjmvI5wyJk0RijK8BMSddaf1V3khMFv7ATxVYdTkAGCRmbw0jTiZmJqUm+Fcq2yIJtcfyFGGQLzKd2fAxXnL92gRYO92iY97ROQuWCdJ9jsqV75JvzBsaseoTCioSdf864x20Am1KDZJGWc7LOI8yBhYdZv2Lu7nLvhooZjrquqkZD/kgmL99MBLq3HmUz3vH1yOhlQiWig3xR+lz+K9/7Ulpj7zXWKfvFEgNL6+Eun4BXCm48xlr+WQYNaTXSlTn1n+z22hMbP1SvDjLEJGp3BwEWG9xA3ypL/CW+P0lAJP9KWtkGmduobq7707vQV4pyDN16b+RmvIV54YXzReEaBfDknTSJICPigahqD2cH8XJXsKw3yoCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(52116002)(86362001)(6506007)(6512007)(31696002)(53546011)(6666004)(66476007)(8676002)(66556008)(2906002)(66946007)(5660300002)(8936002)(31686004)(36756003)(316002)(508600001)(4326008)(6486002)(966005)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SURxaUdOdkJNby8rUXhYYnZNZ042S09mMXppZWtzK3YwMXdXeDlpd0Vlbk5O?=
 =?utf-8?B?Z1NTTHhIbHR0ZlNrdTIwZFlSLzVQWlBsb2UvN01aTDltR1NvUGw0UTBxcUNs?=
 =?utf-8?B?QkxheE9YZUJtWmJkR3Q3aTg2WFEzKzZTYzRWQkRVdExSUjVONkxwRXkxMkhO?=
 =?utf-8?B?dVB3NmdpQTV6WjQzRVEwaWNzVG93cEtBRmxsVUxFTVJMNk5jUGE2T3h6VURX?=
 =?utf-8?B?ZDR2TDhuMFFSL2VzdU1pSGw2Y2ZGOFdwS21EMkptemdaajhBbjZBZCtjeFpq?=
 =?utf-8?B?QXJ1dWNxZDVMUEphTysyN3JZVWQwNzExTE5jaUxDUVNpMCsrN0tUa3ZCaXpV?=
 =?utf-8?B?aFRaUG9GRDFjaHpjVnM5RDY3clV5dWVIY09RUXZZbXF3WXRNKy9MZkpkd1dx?=
 =?utf-8?B?d1c5N3dkdWxocmlHSTYxamtkMmFtenFEdVpuVUorRm42Y2VhbU5DSnpMY3pt?=
 =?utf-8?B?NUpKMnB4Y2sxRXhuS1JrOExoK1g4bytJYU1Sb2VSaFBFYjJ6aGhiVkRQNGhX?=
 =?utf-8?B?bnJIYzNnQk1NcEVNa2hYaEdQUmxTalFxK0FIT0hCa2M0am5zRzVyN28xa1da?=
 =?utf-8?B?U29veWF2TXl5bjhpRlAwMXN0d3ZHUVdwaDUrY09ocTg1RU45a0N0dmN6RWQv?=
 =?utf-8?B?ZGhSdkZBVVR5NGNXTzVDZGJlcHdrRE9aYlA3Q20rem5uTXIva3BCdVFHSUFp?=
 =?utf-8?B?T05nLytjeXU4SFlMZDBBY2NkYjRtUUdTRUJCNFZZdEtwUklWdmpQa1pDbkdk?=
 =?utf-8?B?NDRqamE0ZGprRExHZTl2ZnRtSVlSMHlvd0tDYTVON1E4NkY1TEVjTDlsWWhH?=
 =?utf-8?B?Q1lqcEdRMk9xMzBYaXJnYUxRVHdvT3pydkhyUkZGeVhkQW9jZUtIZXo3N0Vx?=
 =?utf-8?B?WVIyNWtVTlFBbk5vWU1iT1c5QTREdlJQQjZ6YTZVYlhvaDlvY3VtZ0Nra1lE?=
 =?utf-8?B?bWVqUGkxbTF5Q3BJbFVydTROSnBQWEpPdFlnVmRlNWUydVBJWmt0bjJsVWJ3?=
 =?utf-8?B?elNrN0VqbjkydjBLRmVkbjBFcnJBNnFwRFluZElTNVgwdk1ucDZWUkgrMzZX?=
 =?utf-8?B?WU54UlRRcE9mcW5pdytraDhqTlIvVkw3ZTdVUVhwRERjUlZud3pLTTZBVWg5?=
 =?utf-8?B?cmJ0Wlp2Q3UzenpVcktVVVFIYWY4K3h2N2NzYXdqRGNETHNYWU5LZE4vdE1w?=
 =?utf-8?B?WWpXUzd0VUpQUU1MMjRMcjZjYnpRNFlvNkF5VUNCMWpqVm1uY3l4YytqWXhI?=
 =?utf-8?B?VXk3dk9zTnNRamZBWG1BMm90WUhQOEZSWWg5ajM3Rmxib3d4YkVhcGdza2tv?=
 =?utf-8?B?NTMxS1lPTGNSbSt3a2lSamYzbXF4WmxZUTZhaURtTVM1UDJqaHhtK3BLZFBW?=
 =?utf-8?B?clZ6QmRLeFFZZlh4YnZIN05seElkY3ZKSWZrWHU3TFdOT2Y4NFhGb3g4eDI0?=
 =?utf-8?B?dnV2VTdwWDg3YU8wYlFwSkFMWVZqZHAvMWRDRWZ6Q21VTnpncFo1b3RCRlh5?=
 =?utf-8?B?dWQ1UFRJNHR3MXJ2YkpXYW5hZDkyLysxSGhsV0txTGY5NWJCS1c2TVdUU0Zt?=
 =?utf-8?B?cW5kRGVQUjJEUDR0R08yMFg0Z0NuaHVwREpyekg4ZEZjbm5KWnBySXMyR3NO?=
 =?utf-8?B?UHloTFUvbTFpWmpMcjg0RjVxUGFnVTZ3TkROQ0UxL3MraFR0Qm1hWSs2RllN?=
 =?utf-8?B?blZoYkxmY1NqZGRoVVpmVWhsYjNtdzcyaGJkZlFXRTl4dFM3QjM0L2x6MWY5?=
 =?utf-8?B?QTNQZ3BGamt1ZXo5OWU5akR2QURmK0x5TEgrYzdkeENIWWY1RmYzNHg2SVdQ?=
 =?utf-8?B?c0VoVHhIQXNheXBwSU04dUlCUGZya1EzNFRxQTY1cXpVcmJ4NDBXYmpTNXFt?=
 =?utf-8?B?SkZUM2RNdk5wM01sR0dmVU8vUmt3d1pvSzdBOU9ycnU5UkV5UXBnZG1FZGdn?=
 =?utf-8?B?NGE2WFg4VVV5bUhIVVFSTU9hcmVSRHA4WVMzSjFwUVlDODArVWRQYzBLenR6?=
 =?utf-8?B?cHh5OEp2d1g1Zm1HOHkwZTg4Qllid0ZCZ09sQWI0UG9Pd3VvV3cwTG9RbW1x?=
 =?utf-8?B?NUxjbWVQWTRVRnZFUHdXZjNBYWtteWhsc0p2ZVVpRkVkV1Uybm1Fb25LM1lG?=
 =?utf-8?B?TXp1VXpkakFrZmx5eE9zZVFJZm1QaDBmTUdBd1E0Qm5mTkNqYk5MQVpFbEwz?=
 =?utf-8?B?VW5PSU1tTVZBOXptZUZ3UnZiUDNKdzZBcjFDaXlMa1lzYTMzTFRCMVhFYzUw?=
 =?utf-8?B?anE3SzN4VkhUaDk5dFNOWU5EeHNFZi9pK2xub2tqWFd2NlVvU1BwL01vWnNZ?=
 =?utf-8?B?UlhMMCtVcWhVdHR5VWcvODUwUG92eVh3QjVrOWVzbEhQU1c1Ny8vbEM5Nngx?=
 =?utf-8?Q?/L4mTmSKFu9AeCEI=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c657ea9-47e7-49f3-f370-08da11101e29
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 23:10:15.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv74lC0fEmUbrp6taUbk+zqSj49IRaLmCmZ8MD3/KN2Ezr9LMeIvcmZrJcvB1Cg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5083
X-Proofpoint-GUID: N_ECvFC7g9WJnv_YoI8pAldAHxsBJxVc
X-Proofpoint-ORIG-GUID: N_ECvFC7g9WJnv_YoI8pAldAHxsBJxVc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_11,2022-03-28_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/26/22 10:04 AM, 范开喜 wrote:
> Yonghong Song <yhs@fb.com> 于2022年3月26日周六 00:41写道：
>>
>>
>>
>> On 3/22/22 8:42 AM, fankaixi.li@bytedance.com wrote:
>>> From: "kaixi.fan" <fankaixi.li@bytedance.com>
>>>
>>> Vxlan tunnel is chosen to test bpf code could configure tunnel
>>> source ipv4 address.
>>
>> The added test configures tunnel source ipv4 address.
>>
>>   >It's sufficient to prove that other types
>>> tunnels could also do it.
>>
>> Could you be more specific what other types will also use source ipv4
>> address. It is too vague to claim "it's sufficient to prove ...".
>>
> 
> Is it better to add more test cases for other types of ip tunnels ? It would
> introduce more duplicate codes.
> 
> In the kernel, this is referred to as collect metadata mode as follows:
> https://man7.org/linux/man-pages/man8/ip-link.8.html
> Kernel use "struct ip_tunnel_info" to save tunnel parameters, and use
> it for tunnel encapsulation. The process is similar for vxlan, gre,/gretap,
> geneve, ipip and erspan tunnels.
> The previous test cases in "test_tunnel.sh" test this mechanism for bpf
> program code already.  Based on this mechanism, I just use vxlan tunnel
> to test tunnel source ip configuration.

You can just mention something like:
   Other type of tunnels, e.g., gre, gretap, geneve, ipip, erspan, etc, 
can also configure tunnel source ip addresses.

> 
>>
>>> In the vxlan tunnel testcase, two underlay ipv4 addresses
>>> are configured on veth device in root namespace. Test bpf kernel
>>> code would configure the secondary ipv4 address as the tunnel
>>> source ip.
>>>
>>> Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
>>
>> Again, please use proper name in Signed-off-by tag.
> 
> Thanks. I will fix it.
> 
[...]
