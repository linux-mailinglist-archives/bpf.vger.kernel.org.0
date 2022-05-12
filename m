Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A995F5243F6
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 06:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbiELENU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 00:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbiELENS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 00:13:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEBB1EEE14;
        Wed, 11 May 2022 21:13:14 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMwZF8022821;
        Wed, 11 May 2022 21:12:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Lq4lJSdQ60+laXy6LimrnIx9sOlVNTPRFpzYRwa3Lqg=;
 b=EN/AUQe+OZgROyOmCI3FVlXIEkG+VoaN6IXkYnAJlk8MEp1kyX7PyZFlM0ty7mWv3gR5
 8QDSNMGwzQ4mI2jOeU3H0XmXMb9+1v35/Bez7FKZjcPVcudud+OwyBFVzsrBWaFLMhff
 NOtZoLJY1/LttFBxEZvi96QssMqxvXo4Nlc= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g055hqsnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 21:12:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7aaDAx542KQ62m++cZj+1Gp4MLSLjuFVssKBhkENmEzUIy8nAmWMXyhQSlMglHPTKeWqIAGRlMiOcn4XwysaufqJIhdDjiyaeSPvrTUNL0i8/4bla9vdgcpDbvreG8sGrfol0/LKzUT+4d9UYkqRkrDbH6q9H5Vxo5qtCXQvzQPFXBa2+3YpvWKNAriMnb9iG6HL9u+dw4AfTRtMWUrGNcoXxNjCPNI5NdJYyHBEmszyjY+zc3phUvINEZqtI8c+eBoQWgS1zhJx5ilJbvob9NWYJnHR9o3waQdzqlF57CkgsGAPGm5zlh/yhMEiTi4rgKRdrpvda25i9vNFaHRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq4lJSdQ60+laXy6LimrnIx9sOlVNTPRFpzYRwa3Lqg=;
 b=XFUs69MW8KJXMmb/GgvP5qtCDMvWkHOAuRaCc/T0pzw6J9TNKsfv0i26EkYnUCCffxOjUaKgyHopYrYg3T0Mf7Q7PIjxQZa0lJDYnef7OCvqwpSHAItIiV/0c0L7WRJip7Xjf9WX4MJXx7lE+iofHhM7C74ZFcL6OjAdIGlcjX9aOBfROwOeA5wxw5R12rgWgNx8fCxjq4hNxgp5MHXQqvF0y1GCCHik4g/AnBldAPI0I/jW99XuCa8aTTds9z+LUlk0aZJgozyOdJvs/lvu5DAili2S2XIR1GP/Uz5e4dRgjbx1qLtUpE+q2ll7F2XEQOTNaBpcEJMwszi1dBaV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4935.namprd15.prod.outlook.com (2603:10b6:806:1d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 04:12:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 04:12:57 +0000
Message-ID: <366cdcf9-3f94-6ac0-aebb-ceda500ab89a@fb.com>
Date:   Wed, 11 May 2022 21:12:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH dwarves 2/2] btf_encoder: Normalize array index type for
 parallel dwarf loading case
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220511220243.525215-1-yhs@fb.com>
 <20220511220249.525908-1-yhs@fb.com>
 <CAEf4BzZgby0RDcXXwHtB+zxof3Gmgn+EUnbeEyYOshb7dfbzyA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZgby0RDcXXwHtB+zxof3Gmgn+EUnbeEyYOshb7dfbzyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9c3dcae-5f6e-4989-fcb4-08da33cdb1b3
X-MS-TrafficTypeDiagnostic: SA1PR15MB4935:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB49354A3C35EAA18D8F4209F0D3CB9@SA1PR15MB4935.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPZ/90MgYm4uIHO0ihXxoPTwQVYC/GbztaBBM08F5iVToWvtwpthHnxlQWtl4aiTpr4Dse4dIM8XJMj1p6D218n1G1Mu39ZdO67MN36mZ4onFNfxYFOKGV7aUwOA4xkAiEacc8ETH7iUs8D+h8H4M5t/woLMIN+h5570DxDkrUHgft45SG15/+t7K605wWkkfWIAjp6pSs0p+2emWxKzBsQQJXPQmDIW/2wVKzqU9pyMlrp2cy6SXh+DLeUlX/gsrQXJt4ZMnH3WUBflCsCQ/vwzbouvJnPaOe9tepeo3OjPpiXNv3dsTM8p8tuoqYwO+PFB1OrWEjBSZFyUkeYlwMFxm9v7kx4BQyAWkxP0FSFrsYMvqw+WeflC4us5ec+TNbrYAu5DBtpuLASQvCMINFt2QGezZMWxJtfOs3d1U+HfL+W11IWlr0w6AkQJtjDEGyjZ4ttjqb6MtSOpxXVyn/LcPT00FzlsqVOlTIkV9cdEa1WOsbxlECTD0Dph0zJDczlZ93VKhfBiOcZ8mlF87fF26ZZSb9dFgVAD9G5kZ+pgtzcsGcK+YphtIu58lwU5rK1XN6BMO5MGjvdBObuQ7KPbmJlkI6QCY0AAVSkbyes1MIH6nJ5pzfHuxHGTcQqf+pfaRJsQzJKvuyxDIv/NyUrSlvGgU5Mcd8xTRKvvIrNEbDB4tH/Hc8mFhME+AgaN3EfrAs6GvkCT6nkHcbNl+Sw4abO+qcOUFnVKQxbidZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(4326008)(8676002)(2616005)(66946007)(66476007)(66556008)(508600001)(31696002)(186003)(52116002)(86362001)(6666004)(6486002)(6512007)(316002)(54906003)(6916009)(53546011)(6506007)(31686004)(8936002)(36756003)(2906002)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05MMEk3VlI3WlhjVUxtN2NHejhMS2JWT1ZZa2R0azNxSHpQYUhFeUpzcFVC?=
 =?utf-8?B?YU80S1Q2TytCM3hQRHJDbWZlaXlIYmVGSXJLVTZZanNHS1RFYjNZM2lCRjhl?=
 =?utf-8?B?WVQ5UUd6WVpScWJCZDZ0WHNURkxBM2xiMm56eXhwUk8wc3NkTE9ydENURUJ1?=
 =?utf-8?B?U1ZrSWpHbytiNGZmTDNKL1p1bzJ0THRaY0hqQ1lmWmNrTzE5aStyVnFHdnVH?=
 =?utf-8?B?emgralZvQm5HcDZGY3cyc2dmMkJxa3V0Mm9tQkp0L0RCL1piL3BtMzhPRks0?=
 =?utf-8?B?Mk9pdUhZWFNlbGhrN3dCYjE3NnlaaHQ3dUZKODRyYjJlTVpRWU5vbmVIaTZN?=
 =?utf-8?B?NTdBcm5TUzN2amdZNTBxWHU2S3lPckhhZGFSTUFCcHpEb2NWOHRBemJSQnI0?=
 =?utf-8?B?WmRTRHdtSjNxbnZCWFh3Tnpmb1FMVGdhNmhrNFM3WFl6eWcvUnZmNzZHUmpJ?=
 =?utf-8?B?eXRZT2g3aHorUzlHV29pY1UvQTBCc3J3OXA1MnJVRUhua096QW41L3U3Z3FD?=
 =?utf-8?B?UzhXSXJ6NGx5WEVsM3hpSFQvY00yREhyZktOZDd0OEVZYWd0TDY0TVVSaGxX?=
 =?utf-8?B?VFpwS01VQzd6TGdWU0VqZkxZN0lYYzQ4YnBsWGw3Q24xTFRmNkRKdXIvOGpV?=
 =?utf-8?B?WmQ2bmFnN1ZsUWRnRi9YNitzdTdXT2Yvdi9NcVBWRlBCT3B1aUlNYUJSTERY?=
 =?utf-8?B?UHZRNE8zTkRXb05WS1ZSVWpYTi9QNWVFT1hBa0ppWFJ4QWo2ZDFMdGcxSkRH?=
 =?utf-8?B?UmtlTEhmZWM2MzdFdlM0NzVKajArdlluY0EwVVF6T1VIb1lhSzlUdjZTZC9T?=
 =?utf-8?B?cG53a0dIc3o4RWJzVTNOUzdPMytwcFpGeEZxakEzQ2F4QzNQUzE1Zzg2cUpq?=
 =?utf-8?B?L3Z6UDNhakRXUHJnUG01RWlpNGQyZzdPVlJXY1RxcU5RSHFYVW1Ic1c2azZx?=
 =?utf-8?B?L2NRTlJGZnhHa0djLzdkeGM2aExrelA2U1pmS2YxMmsrQUFSZFZNRndWZzFR?=
 =?utf-8?B?T1N0ZmtRUUl3NWdUSmVpb1BXQ2NEaUNIMDJGLzFkSVlCUFFWN3E3T0ZjeWht?=
 =?utf-8?B?cktGYis5bExMbDJaYXd0NXhYU29abGtoVHdDUDROYitHa2hoNStWRm1GYk45?=
 =?utf-8?B?T2ROM1VKeXhuUWl1cXdZaFB5clo5MnNndEJrKzNyYkVoYVdnNEVmc3VvZU41?=
 =?utf-8?B?L2xaanZoMm5Kc2tGdzNqNk1wTEVmWkU3RlNLWWZPTUhVTHdhUmVZMzB2RHRH?=
 =?utf-8?B?NlpObVJxeE9RVVFBQ1QxK3dkdGJnMzlSYVFZck1zMTQwQW5ZVS92U3J5Ykpp?=
 =?utf-8?B?VythVWVBMmhmaVhwQkgzOHpOTEEwaVV2c0tzWUlnZzloVXcrVG5mbnNGbDVa?=
 =?utf-8?B?UXlyOEQyMlB3cHVOYkNqUEMwOCtobW9iNHlQU2x3NmIydERzK1dPYlVnWHlY?=
 =?utf-8?B?eUVtYzFWMXc1dkZoK1BTWkZIb2wxQlozclhmSkpZbzFjaWt1emdsMDVEMEpy?=
 =?utf-8?B?a3hOOXlyL3A1MWFJVWpPeXBITjhVNkxQanFJV3hWcWtFd3JOclhtSmw4b01B?=
 =?utf-8?B?Q1ROZ1NIWW1TN243dlNGU0NyRFVmK3lsTzU3QmdZV2RMb1JGU2dMaTI4UUdQ?=
 =?utf-8?B?VlVEYmJnb0Q2UExvNG11cHdOUUVqaEdXZFJtUWRoNVVsUWhJQmpudzNkUVRl?=
 =?utf-8?B?Yjd6TUxIOFNzcTdNcTBVUFVuaUkwYVhYV2UwVklFbExaRnBNcXkvVm92dndl?=
 =?utf-8?B?TWUvc3pyZ2dNUkJBMVpoNG5za3A5VEROOU5Za1VtMll1YU0vRWRPWnpaYkNB?=
 =?utf-8?B?YzlYaVlGRGRlR2p4VlhnQlZEaVR3dEVhbWtpUlNuNEZOYUtQUUdnQ3FuSnY3?=
 =?utf-8?B?SDl6UGZzWUs5WWh5bjFGWk11M3hkK29ndFptMWF4Wkg2c3lXNWU0R09uUTdP?=
 =?utf-8?B?SFNIbm1MVWJxMlVTcDM2ay8vVmJtZ1Fzemt0TDJVS2hjV0RiVWR4NUhJeEhN?=
 =?utf-8?B?OU9WZFIvVW52WnVJN1JqaTBhRFhOL1NCL29QQXZpSmptQTFyV0tFNERFMHl2?=
 =?utf-8?B?dENyTjkrNDd6Q1czNC9GUDZHeW9JdmZsTm4zeE1hRGh6azdtK0N3QXdYQUUy?=
 =?utf-8?B?TDlEK1kwZERvTFFtUjFzdURsbmtiL1RTVmtQRTYxT1ZFSEI0Z0ZmbUdDeFM4?=
 =?utf-8?B?em9XM3FKbCtTRzZ6Qk5hZzlzbnZwOHVaZkxUYjlDdGlTTHdzblNxdnVjZGNY?=
 =?utf-8?B?UG1DRGpHT0dNSUkvY2FPRWVyZi84Sm9ZY0FqWmE1cUZmNXdZbGRwQ2ZvRUxj?=
 =?utf-8?B?OGN5ZnMzdG5RUEJkL2l4aDZYRzlzSWRlejZsU1FUNFdzcEZ1VmN3YkJWRmpB?=
 =?utf-8?Q?GG2uFZekYFXo4E0A=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c3dcae-5f6e-4989-fcb4-08da33cdb1b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 04:12:57.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQpJtfGDkvhsxAz7IEzL0NcQUeVi89isDwpD1DbpU36IN5J8a2SuJILZz22XoAbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4935
X-Proofpoint-ORIG-GUID: -AOndbraJYpgq-jcx-XlZ8Qy7qb_F3U1
X-Proofpoint-GUID: -AOndbraJYpgq-jcx-XlZ8Qy7qb_F3U1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/11/22 5:32 PM, Andrii Nakryiko wrote:
> On Wed, May 11, 2022 at 3:02 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> With latest llvm15 built kernel (make -j LLVM=1), I hit the following
>> error when build selftests (make -C tools/testing/selftests/bpf -j LLVM=1):
>>    In file included from skeleton/pid_iter.bpf.c:3:
>>    .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
>>         '__builtin_va_list___2'; did you mean '__builtin_va_list'?
>>    typedef __builtin_va_list___2 va_list___2;
>>            ^~~~~~~~~~~~~~~~~~~~~
>>            __builtin_va_list
>>    note: '__builtin_va_list' declared here
>>    In file included from skeleton/profiler.bpf.c:3:
>>    .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
>>         '__builtin_va_list__ _2'; did you mean '__builtin_va_list'?
>>    typedef __builtin_va_list___2 va_list___2;
>>            ^~~~~~~~~~~~~~~~~~~~~
>>            __builtin_va_list
>>    note: '__builtin_va_list' declared here
>>
>> The error can be easily explained with after-dedup vmlinux btf:
>>    [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>>    [2300] STRUCT '__va_list_tag' size=24 vlen=4
>>          'gp_offset' type_id=2 bits_offset=0
>>          'fp_offset' type_id=2 bits_offset=32
>>          'overflow_arg_area' type_id=32 bits_offset=64
>>          'reg_save_area' type_id=32 bits_offset=128
>>    [2308] TYPEDEF 'va_list' type_id=2309
>>    [2309] TYPEDEF '__builtin_va_list' type_id=2310
>>    [2310] ARRAY '(anon)' type_id=2300 index_type_id=21 nr_elems=1
>>
>>    [5289] PTR '(anon)' type_id=2308
>>    [158520] STRUCT 'warn_args' size=32 vlen=2
>>          'fmt' type_id=14 bits_offset=0
>>          'args' type_id=2308 bits_offset=64
>>    [27299] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>>    [34590] TYPEDEF '__builtin_va_list' type_id=34591
>>    [34591] ARRAY '(anon)' type_id=2300 index_type_id=27299 nr_elems=1
>>
>> The typedef __builtin_va_list is a builtin type for the compiler.
>> In the above case, two typedef __builtin_va_list are generated.
>> The reason is due to different array index_type_id. This happened
>> when pahole is running with more than one jobs when parsing dwarf
>> and generating btfs.
>>
>> Function btf_encoder__encode_cu() is used to do btf encoding for
>> each cu. The function will try to find an "int" type for the cu
>> if it is available, otherwise, it will create a special type
>> with name __ARRAY_SIZE_TYPE__. For example,
>>    file1: yes 'int' type
>>    file2: no 'int' type
>>
>> In serial mode, file1 is processed first, followed by file2.
>> both will have 'int' type as the array index type since file2
>> will inherit the index type from file1.
>>
>> In parallel mode though, arrays in file1 will have index type 'int',
>> and arrays in file2 wil have index type '__ARRAY_SIZE_TYPE__'.
>> This will prevent some legitimate dedup and may have generated
>> vmlinux.h having compilation error.
>>
> 
> I think it is two separate problems.
> 
> 1. Maybe instead of this generating __ARRAY_SIZE_TYPE__ we should
> generate proper 'int' type?

This should work. Will post v2 with this.

> 
> 2. __builtin_va_list___2 shouldn't have happened, it's libbpf bug.
> Libbpf handles __builtin_va_list specially (see
> btf_dump_is_blacklisted()), so we need to fix libbpf to not get
> confused if there are two __builtin_va_list copies in BTF.

I checked code. the libbpf prevents generating
    typedef <...> __builtin_va_list
since __builtin_va_list is a builtin type.

Here, due to __ARRAY_SIZE_TYPE__ problem, the following are generated
in vmlinux.h.

typedef __builtin_va_list va_list;
typedef __builtin_va_list___2 va_list___2;

since __builtin_va_list appears twice in the BTF.
But due to the libbpf implementation to skip
    typedef <...> __builtin_va_list

We don't have __builtin_va_list___2 defined and this
caused compilation error.

Although we could workaround the issue in libbpf
such that if the typedef is in the format of
   typedef __builtin_va_list<...> <other_type>
we should just emit
   typedef __builtin_va_list <other_type>

But fixing the issue in pahole is much better since
we won't have va_list___2 any more.

> 
>> This patch fixed the issue by normalizing all array_index types
>> to be the first array_index type in the whole btf.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   btf_encoder.c | 24 +++++++++++++++++++++---
>>   btf_encoder.h |  2 +-
>>   pahole.c      |  2 +-
>>   3 files changed, 23 insertions(+), 5 deletions(-)
>>
> 
> [...]
