Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88C62E8C3
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiKQWxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbiKQWxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:53:20 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65174CC7
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:53:18 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHMc4RS029228;
        Thu, 17 Nov 2022 14:52:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=BsX1/4yzQvfsjJ+00I1mBAPLxAWtCrC6gWXuwDB7/Kg=;
 b=Ir+a/Qu4LgbdNGiDexnokLdNeRquaH0NjwPjFxIPVS3CxdE4EB6Kv485ZvihAIj6W5mw
 X7md9a54AjooZRYiOjS4yhxxR+pFiMZwIqZ0PEl1Mb8txfjtm4W1Wl3rPBvJ5kphl3sG
 LU2WcYvPhP4vvWp3ief2JULkPv1n8HRdXopCkujuIwK+npxMeU5Z0QmQchHwfZJxOH8I
 rrjJRi+kMRCn3yDHDkcToZ9LQ/qINIRxHF1369sIXLX4cz+LUXcTU3cQXDUJf2UQQAtN
 j4zp952RV1bECuf8eLxfVR60k9E+lZL6P9ann6rrxc+qqH72i32urNttQC9FrDAM1E4L lQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kwwww03up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 14:52:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwljWGSpdow8JPi0NiQvhQQ5tjN5crnWbKJ7WWbHsGlvMwuVgYTmOASJmejFKseawctr7jl2DzmXAaofSRmvOMB02QJsnk16WLmG1Eq7o0u8AVhxHHtmbip9exBLks1ZVM7071aZ+b12janXspGudx6DcBDGx3+EWU9lDyyd2wlY+XgyevF9eYdEIRHzIIGEMYwPdH3EdXfsV+z5UlthM/c9hupHnK05WLT+tLMAnIWRW3n8oK3wGICEISdz9KCS7PLaV7s+PU1gF58jzCCO9mClhE8OrYzIkQJSJAD6IMV7uMer3muSqsP7KK/t1s9EaVC3xYbnC29jwxNOpSFbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsX1/4yzQvfsjJ+00I1mBAPLxAWtCrC6gWXuwDB7/Kg=;
 b=DTDiTPXzkGO1zuwp6Z7y8u6fpB6IYthikvhhJuE4Oe17rCsCEk0kGup0UyxNxii3cX4MVXrt5Q9hYP90iVkJ3OqfZN8GkhyE2TZ0QExnFX49b8tk1FXh0oEjREIfAf8Ls5ePv67GnzJCDaQdOUfHcJGqLtjaWzDXNhpov6Wphrm09KQDaU+l5DiV9AkNmtuRa8MWNVZyfCl1OyfpMlyhG3niVrGOEiuH2oefMPuqgsRRvoR09YcgnLVMrUNhD1JoAJA1pPxcAvQghqdlFrlDLN/NGyu5cR3yrOviM4WbnftiziEGuIaUlnflXUKETBX+qCNFjOf8NLV/v3tw58BQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3061.namprd15.prod.outlook.com (2603:10b6:a03:b2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 22:52:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 22:52:43 +0000
Message-ID: <94f9ec8d-8b54-2873-21d0-948c667e20d8@meta.com>
Date:   Thu, 17 Nov 2022 14:52:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf_get_kern_btf_id()
 kfunc
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20221114162328.622665-1-yhs@fb.com>
 <20221114162339.625320-1-yhs@fb.com>
 <20221115194308.ej5lwd2jo6ulebut@MacBook-Pro-5.local.dhcp.thefacebook.com>
 <20221115200541.bm7xhdurhpxuv54u@apollo>
 <1f856abf-0161-c560-7941-423c9f8c472e@meta.com>
 <20221117182404.lgi3nq4jcomjlbvp@apollo>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221117182404.lgi3nq4jcomjlbvp@apollo>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB3061:EE_
X-MS-Office365-Filtering-Correlation-Id: d88fede9-6610-49b6-c64b-08dac8ee6fbc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M16YoG6fw8CbktHfC1YZ/+sqQPWOuNgL38bogjI043nx0c1tXHtTkncbSDGqPcMS8ahvLQD5t3Il/yVccsTI9yiVgHYmK/FP+gk+FRIe7dpP4N9ZCurjuHlgjFpuythWBzfloqdEccV8cj1rvIhdHSR8JJJZHtomUaOYKo1VBiPIQz/NlmWwoHEEtS7Pd8JWKxrVw34X7spWGl4XDMx+RPojwWE2We2AoxEY9cI/v+GeIhDPvJV67uNum0YeHuFgVEcW7eohX185jbEPi/rjqI5LjAVRaonmPBoB7bcKBppf/nqY5ppDOhfaz5d2VUujYXBwOBorgQAAl15HXleOtLgWx10lubMASIQBuZgQZUbbEt4zPNaCcoqmuJuOr8rhM0cPfMVmMU0TFKmaf41pXSagXQOKbUGBbVUMp8vPsWOjEq+DJXRrtBPqu6yQyn9N9yzovrOxmqw5hjn68KKDtfKKXhbYvGHMNIKsrlPviVqTGss+vZ+5L7kgZs7JLpJ0dPZsxKbzl/BEoEMvnIXOrrxVMvmHM6irQs3OvIh+pyLOcPghoRZ5fV9pWEzPpZgWROO/pcBVPlxnWeVrvnMqVcrSTowShIMx7T8oo+JiKs1lB1tW47ahvw26IfLYATEQ0/umw0sPWgKQv1DLLbGF8xpMFIc4NoQaTV3H7o4FloYPAxANvHi+D5KyghP9S/9cSKe7t2wIZX1w3Avl+vp9EJlkrX3ECEsegK2VUPRtCu8dinW1jO4ZBqAZppWcL0/rjxzpbXofqcqENC0Tko0SIawMGtiebSwWsLpfMiHgz4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199015)(5660300002)(186003)(54906003)(6512007)(6916009)(53546011)(6506007)(316002)(36756003)(41300700001)(2616005)(4326008)(66476007)(66946007)(66556008)(83380400001)(8676002)(8936002)(38100700002)(86362001)(31696002)(2906002)(478600001)(966005)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FhSlJCdmJjdmRXQXBqWk03dzU5bUNkQkZOVFhkVHBBQXZIL3FoMTlaK1cy?=
 =?utf-8?B?NG0zNDZMdW5CbEpSU1RKME5McmlEMUxUNjFscWZ6M1YwWi9ZL0ROcXl3VGZn?=
 =?utf-8?B?UEI3b2JlMUhLa2srcGJyWXV1cGViNW5EdHMvYjNxT29ueThJNHBMMVFLN3JJ?=
 =?utf-8?B?VmE3VDY1eXNnQ0s5V1RsSDZPRnJGbm5pd3F4TzMxZGxnNFBablZrOTNNWCtX?=
 =?utf-8?B?UTFGWnFDanppZ2ZjMU1LSC9tTU1BK1VaMXpxTE80d2N3NkJ3bUlVR1RjQ1JG?=
 =?utf-8?B?T3pNZHVLd0JnTUpja1ZodGdzR3VRWUYwZWlhNGVOdTY3N3VZeEFlcjhzQnVr?=
 =?utf-8?B?SU43RFFNcFQxVlN1RHlGdENBbEtvV21IS2JrYklxVmVTUllRV0ZaVzVjbEwz?=
 =?utf-8?B?ekdub0RKR1kxd09Vd1VNS1hhN21md2tScUozSjNjZlhjM0RIRFNqcEFrQUJM?=
 =?utf-8?B?VUN1UjhyVUdhckNpMjBYbG9HS3ljZGNrVFNPcEdFd1BHQ0FDUkVaQm1JT1JW?=
 =?utf-8?B?ZGRHZGJsSzdwVFhDN2RMR2hRTGhzSzVjSnY0Zkx6d3g3dkkvcFBkNmpiUFdk?=
 =?utf-8?B?TUhpSzFTSUQ5MXFUMnp0VmsvalRMWkVlaUFFTDlQWVd1ek5jOTAwTGtmZkR6?=
 =?utf-8?B?dUt5RUdxR2Jtb0IvME1hRU4zREQ1VjhjWjkyZVNFM1E4dVJpSjB4Z2pyKzJD?=
 =?utf-8?B?OTJFK1NlMTZOY0FZNGFDaFFMcjFjOVZXdi9OS0x0WUtkQ1NzY0djRzJ6THVx?=
 =?utf-8?B?dEtidWI0WDM0d3p2aExyYndTNG1PazdEVS9QSjJlY2V1TWhWY0t2cDNKZnFk?=
 =?utf-8?B?djhkZjRxOTFRZDRHN2lJWmYrRWFBcUNZdlVmcXg3bTgyZzQ5UE92eXBOU3dK?=
 =?utf-8?B?cFozSVRwWTdVdmx6bU1BYUY1MVBIOEVPd2hrNjliZGFneFA5S254TE9WbjJ1?=
 =?utf-8?B?eFNwSW15R0htVFRndytDa2pTM3dnSlI2SlVtZkJSU1dWdExJaGFoZW45M3Bp?=
 =?utf-8?B?TWtsMVRpR1RaWkJONFdFbTJpWi9adSt4Y0VLamVYNGw3ZDBpdEZ6eFByRGE0?=
 =?utf-8?B?dUczSUpWZEo1SUxOWHBuQStIODN0TFN6R01rT25NUW1vZVRmSC9VWkFUT09L?=
 =?utf-8?B?MytCQ3NCSUl4Y0Irc1JERm5HWlEvaGV2b3lDUEFxRkhRQmtYc0NFN21vUytH?=
 =?utf-8?B?YytVbkw0R0FUQmlSMDd0OSt5TEtKbDAxZHM5MjRaOUZ3amZuTzA5bFJvR1RR?=
 =?utf-8?B?QytMZ294Y1hQNlZWRU1EUGQvS2Rabk1yUHZOWW5lTXEyQTM0eGM5WVViTTZn?=
 =?utf-8?B?TEFYZHpmQ0pDRXhYVzduaFBZNUJ4YWxubmErdmNSQlFHNU5adDVpSWtYQW5o?=
 =?utf-8?B?cHlPRU9nMmszUS8yaGJtOXFnaXUrVCtlOWhhYjkrU0hTaHhLR3hqQWRSR2J3?=
 =?utf-8?B?ejAxOHB3K1YxMnU4eStUbWNKcm9KQlBIYjVlTkxhQmhIRXJiQUdoQmVpTStt?=
 =?utf-8?B?TC9jNEZkK1lmWHBJTXBabzlhWGFlK2RQdEQ3ODVaZjNoemNBdjVmanBuWDhi?=
 =?utf-8?B?cnlab04vUHhWZU1rdUJRb0hGaGk1VW4wekhMR3hDYm9NY1dzRWZpZVBQZU9C?=
 =?utf-8?B?ZHU2QTd3dzEvYzE3Y1MvMUxHRXpjb3czQmliR0E3cGtqdEVWYlIvZU85OE5L?=
 =?utf-8?B?cDl6MXhDeGkvQkluZDdqaERNY1QvWDBidEsyZzJLSlRjZFgvNUtsY0RUTnlH?=
 =?utf-8?B?M2hnNE1xQnU1M3M3WEFrdXZONG5NSytDcGZ5amcrMi8zRElOV2JvS2RjMTRJ?=
 =?utf-8?B?QXpxbFpYNmF3TGw5V3FsN3BjQnhNUU9CSmRQSHJ6UmhycXRTMC9saWV5TjA4?=
 =?utf-8?B?c0xsNEFWTzE2MXBpL3JZWVg3MFoyRmtQbkhacTZQeUp6TENIaW1oSGIwUGZu?=
 =?utf-8?B?WVRYUUxtSllXUlV3ZXI4d1NOQmZOYk10M3h5QUlOZXFwODZtdjMxaU5jdGxB?=
 =?utf-8?B?UGQ3Qk4xSmRJU0taMmlTejRsbW9nYzJQcGZJaFAydG1NTzZiYzdUUkp6bkdo?=
 =?utf-8?B?NzBDNGNsczBYZEJES3preUI1M3Z6c2hJRmU1eVkyNFNpTHljZWFuc24wY0lx?=
 =?utf-8?B?K3ZBSzl0NTg5VDNXTTlLQVpIQXJiNHRUemt6Q2NqeWR4Zy9PRE54QjNHWnds?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88fede9-6610-49b6-c64b-08dac8ee6fbc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:52:43.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgRuUFXt0kB8ruGZZOepOUAjASdfDZE1VFcFLtPU3DylAe93vWfrjynL57Xwz7e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3061
X-Proofpoint-GUID: Rrwnil8zcE7wzk-CgAoz1T_qNAhTFh20
X-Proofpoint-ORIG-GUID: Rrwnil8zcE7wzk-CgAoz1T_qNAhTFh20
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/17/22 10:24 AM, Kumar Kartikeya Dwivedi wrote:
> On Wed, Nov 16, 2022 at 01:56:14AM IST, Yonghong Song wrote:
>>
>>
>> On 11/15/22 12:05 PM, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, Nov 16, 2022 at 01:13:08AM IST, Alexei Starovoitov wrote:
>>>> On Mon, Nov 14, 2022 at 08:23:39AM -0800, Yonghong Song wrote:
>>>>> The signature of bpf_get_kern_btf_id() function looks like
>>>>>     void *bpf_get_kern_btf_id(obj, expected_btf_id)
>>>>> The obj has a pointer type. The expected_btf_id is 0 or
>>>>> a btf id to be returned by the kfunc. The function
>>>>> currently supports two kinds of obj:
>>>>>     - obj: ptr_to_ctx, expected_btf_id: 0
>>>>>       return the expected kernel ctx btf id
>>>>>     - obj: ptr to char/unsigned char, expected_btf_id: a struct btf id
>>>>>       return expected_btf_id
>>>>> The second case looks like a type casting, e.g., in kernel we have
>>>>>     #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
>>>>> bpf program can get a skb_shared_info btf id ptr with bpf_get_kern_btf_id()
>>>>> kfunc.
>>>>
>>>> Kumar has proposed
>>>> bpf_rdonly_cast(any_64bit_value, btf_id) -> PTR_TO_BTF_ID | PTR_UNTRUSTED.
>>>> The idea of bpf_get_kern_btf_id(ctx) looks complementary.
>>>> The bpf_get_kern_btf_id name is too specific imo.
>>>> How about two kfuncs:
>>>>
>>>> bpf_cast_to_kern_ctx(ctx) -> ptr_to_btf_id | ptr_trusted
>>>> bpf_rdonly_cast(any_scalar, btf_id) -> ptr_to_btf_id | ptr_untrusted
>>
>> Sounds good. Two helpers can make sense as it is indeed true for
>> bpf_cast_to_kern_ctx(ctx), the btf_id is not needed.
>>
>>>>
>>>> ptr_trusted flag will have semantics as discsused with David and Kumar in:
>>>> https://lore.kernel.org/bpf/CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com/
>>>>
>>>> The verifier knows how to cast safe pointer 'ctx' to kernel 'mirror' structure.
>>>> No need for additional btf_id argument.
>>>> We can express it as ptr_to_btf_id | ptr_trusted and safely pass to kfuncs.
>>>> bpf_rdonly_cast() can accept any 64-bit value.
>>>> There is no need to limit it to 'char *' arg. Since it's ptr_to_btf_id | ptr_untrusted
>>>> it cannot be passed to kfuncs and only rdonly acccess is allowed.
>>>> Both kfuncs need to be cap_perfmon gated, of course.
>>>> Thoughts?
>>
>> Currently, we only have SCALAR_VALUE to represent 'void *', 'char *',
>> 'unsigned char *'. yes, some pointer might be long and cast to 'struct foo
>> *', so the generalization of bpf_rdonly_cast() to all scalar value
>> should be fine. Although it is possible the it might be abused and incuring
>> some exception handling, but guarding it with cap_perfmon
>> should be okay.
>>
>>>
>>> Here is the PoC I wrote when we discussed this:
>>> It still uses bpf_unsafe_cast naming, but that was before Alexei suggested the
>>> bpf_rdonly_cast name.
>>> https://github.com/kkdwivedi/linux/commits/unsafe-cast (see the 2 latest commits)
>>> The selftest showcases how it will be useful.
>>
>> Sounds good. I can redo may patch for bpf_cast_to_kern_ctx(), which should
>> cover some of existing cases. Kumar, since you are working on
>> bpf_rdonly_cast(), you could work on that later. If you want me to do it,
>> just let me know I can incorporate it in my patch set.

I just prototyped a little bit with Alexei's suggested interface. It has 
some differences. I will explain in my next revision.

My prototype already added bpf_rdonly_cast(). As you suggested, it is
not too hard. I have not done with module btf yet. Will add it
as you suggested below.

> 
> I think the patch itself is pretty trivial. What's needed is a bit of
> refactoring, since I would also want to make this work for module BTF types.
> 
> In that case, we need to take a type in prog BTF, look it up in the kernel, and
> mark the reg using looked up BTF and BTF ID. However this raises module BTF
> reference, and it needs to be kept until verifier is done (as it gets set to
> reg->btf).
> 
> This is why the helper takes local type ID instead of bpf_core_type_id_kernel,
> since that doesn't work for module types (IIUC).
> 
> Instead of the current used_btfs array logic, Alexei suggested guarding module
> BTF free path with a rwsem, which the verifier can hold in bpf_check, so that we
> don't have to worry about keeping module BTF references around during verification.
> Modules are loaded/unloaded infrequently so it should be fine.
> 
> Then it also became clear we currently stash BTFs in some places unecessarily
> and we could simply drop those after prog is verified. So it would make sense
> to drop those cases too (kfunc_btf_tab, used_btfs btf_mod_pair, etc.). After
> verification the prog only needs to pin the module references, not mod BTF
> references.
> 
> Maybe all of this does not have to be done together.

I will focus on implementing bpf_cast_to_kern_ctx() and 
bpf_rdonly_cast(). Others can be delayed for later patches.

> 
> So let me know if you want to take it, I have no problems with that, otherwise I
> can get to it once I am done with the linked list and dynptr stuff.
