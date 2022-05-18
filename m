Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7158B52AF2A
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 02:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiERAah (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 20:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiERAag (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 20:30:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD7B35865;
        Tue, 17 May 2022 17:30:35 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKFF6p018468;
        Tue, 17 May 2022 17:29:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OUxz2s96T678f4v4alOWKrJbh6B2ZGBUr0SeX783KlE=;
 b=PkdOTYB8XtA2fQ2QYeoK1lpC3C67Ogm3XCcqixhVKcrSAdB/kfRCDAHNAEVq/smZZhBi
 fQ9415BRKnxRMJIAjCdwlrzhHnCE+NHvurVmQw+wup6htvdTq9xBrvwEm7YKwfAqKqTx
 9Gr6GEjF2WlmY4N8Lcd1Eqt/zphBODUTb4w= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4d81v90n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 17:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTeuHycVcSWCkLgL9PIYEBafXouQWxeoM9oVnmXu/u3+pFL0fgW70+gnAYR2jCOOZUihYgAaXngSAP8rY1U90EL56UMFxje+ngxePN1H5bpG4y1ANVSBp+H1INVFV51SHfjGvTaWljSSgk/hlNxb/FXjLPr7yUk+catCt5SPiJYaZWy6kVwytXdl5454d1zEyI4R+TCsFqFzns8GaJK0dNIGce50SRcN3dTHBGcM/RlZd6dx2SITvXMMZ+XZvOaTVgp6nwELRAMFYauya9O/FlJNNve29nGdx4E3vONfPQK8sxI1RMlZcadkgjNW1utKgZJaaljepGJmZUYvnsvllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUxz2s96T678f4v4alOWKrJbh6B2ZGBUr0SeX783KlE=;
 b=j044LNaRu+glLhkQq0hqD6qngiTN3Nym6nBDtunV7G8VlAd71xiYfGFdYlvB9vyi0BiQPAnNkWnKTaYww937LZAcFcAnvPoXWDo0gELonb9p0OxQy6wk4Nx/W81tBUeQB05XEsqpI32KEP8X7YlsTxjZyGuspVaUhKTl1raAe/JOXuKQBeQWnF0TjgrPmZ+OniurpwIXqe6tXyd8rZvw+0eXCKnV71z6+8j/pNEyXMyggdBj5Rb6Y5PFN/LQzrKeGj4QFvLA7VyRA9P4+0Q6AxIwHV/XTm//fURh1EEHKNAjI8bTz/QVfqJWitbcL25zJKSdOfjTVImHF1N6uacJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5124.namprd15.prod.outlook.com (2603:10b6:303:19b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 00:29:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.013; Wed, 18 May 2022
 00:29:53 +0000
Message-ID: <e2460561-79d0-3b08-1ecd-1876389d5c26@fb.com>
Date:   Tue, 17 May 2022 17:29:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH dwarves v2 2/2] btf_encoder: Normalize array index type
 for parallel dwarf loading case
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220512051759.2652236-1-yhs@fb.com>
 <20220512051804.2653507-1-yhs@fb.com>
 <CAEf4Bzbr1M-WZLk1CRbSy5Ai8CCAH6JJH_=hGJ0rgQtriV8Ndg@mail.gmail.com>
 <YoPBxEscJTw2YPTC@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YoPBxEscJTw2YPTC@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::36) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 308e756d-87b4-4156-cf9f-08da386586b1
X-MS-TrafficTypeDiagnostic: MW5PR15MB5124:EE_
X-Microsoft-Antispam-PRVS: <MW5PR15MB5124AEF9712723A3FFF89781D3D19@MW5PR15MB5124.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRLWjjdpYS7FmhaZR5dMjjZn4dp3OkjvnBVoPGTtSfk9JhZXnqDBWlKFnpF2u6u+j45jcTiKzjz+zPBb6wZJMamg+/JsieuktPryRXtX9FPvy4ArcFcW1J28ICzl3TTJJcqWFn40IyKJOSh/dx0hz58197LWBjOJfFWJop0f/xN48Ifvfy3Zhq+fepaJmVPEdymPxDNkZHc9hYjJTH1hJ2s+FZYaHq9tn6GOGFE+YUxJkbTCWaJlsyV7NBMcVJWoX1T3wz2N3IAC0WjQq4EO8XxT1PuJlWNqPn/U6w+x3ErCIGpjQUF8reTssuLIKTRf+Ai7oTVDQfcAoEgW6re6V50PM7GSmL2bBOjtSBD7kdJtsACJsWZJToAm8VFwv0JeKVb/xH7IRSogtlXYnFHwy2YjVksXiazMv7WVSIpu309/kK/VcwFdeNxLS/jZI8nRN6TJM8raPH++R5YQTitY+KQL/YGVfFMRq9c8BhWiFAAF3xlRum+0Q01US+ihX4wYbQEjshhKZ6ZZB/83hZBxIaz/Z05bBdlRwGRZwNABZHd4byKJz6FiQnErMFRKd9KrkLFO7dctqz7fgXTl4l8xzwPm6FF7qfwVJOFM1An2CoDMigPhj2SQ6EMjFYtMphtiioUnkOc5SMyXuHmPX76n/2NbcbkuatH3cg5QwXVmSbXOzfeGXI80rn4cwrJRAja4A8miZqFRKcXWtnR7ZkOy4fESgDQWr4Qlilwd+4xVV4VEuW5VZRJhkK16Rj2HL2lj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2616005)(66476007)(6486002)(66556008)(6506007)(508600001)(6512007)(66946007)(8936002)(8676002)(4326008)(5660300002)(52116002)(53546011)(36756003)(110136005)(54906003)(316002)(2906002)(31696002)(186003)(31686004)(83380400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0RUZzF1R1daL1ZuaXRCZXpRbndIYkxYS2dXci80VzAzL3ZFMG5VTWdCVVRS?=
 =?utf-8?B?LzRiTGJpR1FxUkdaNkpWY3lKMkNkdlJUd2dadlVBR0crazBLbDgyaGQ3V3Ey?=
 =?utf-8?B?bHQxcUFYR00vSVlnblQvMkorN1o0dzJVOW0xa3RXU3BOK29VVCt1amF6L2VY?=
 =?utf-8?B?YWQvNm5kT1c3QmJWQ2hlY2oxZWxOcFdKaUI2Q1ZCemE5dWVyUjNvNGRTTm5s?=
 =?utf-8?B?Y3JRU08vaXFVV2tUdHNKUXJaYXJxbkE5MFRuYTFNendOUVpEVFYvVEo4YzZD?=
 =?utf-8?B?aE5OOEZBb0daUUpLamc3TitML0hablUreko1OGhzZlYxSDAwVndqVGZzSSs3?=
 =?utf-8?B?K1FTUTRmMG0xbXlRRjBiM3hId1crVTE2dHR2MXBtTlpUbVdZNkgwSVIwZTl0?=
 =?utf-8?B?MHdXYnFLK1Zhc1JTTEpTSTJOVkp0ZGtGTENpZGVVL214N0JtNGpDc0JiV0RU?=
 =?utf-8?B?YkdwM0ZYSFN1d3lNQ0Y5ZGlKUUZTdzg5YXNBUitiZlZHUWYyS3lGcWxWcThJ?=
 =?utf-8?B?b0ZmN2lVaFR2TFVsUHFvSjA1VkU0bFFBZEg5WFhlc3IvWlBoY3lGREc2YmNo?=
 =?utf-8?B?VHBQTXBHRFdGSURWMmMxSVphc0M1R1FqaWJjV3dEQjIwUTZFbzJuUDJvSTJq?=
 =?utf-8?B?K1ZIWDNDdktlbUVjTFpDSU5ocHNCL2NDKzQ2YkgxWGFic1RKUTJpeFYzdGFK?=
 =?utf-8?B?KzRCSHpVMzZtRUpLSi9XNU1Xd2pPS0NtblVlR3ZXbndsU08wb3B3aXc5OUlX?=
 =?utf-8?B?R2UzbjRYZEo3MnJLWkFua1czUjFLSXFldmZPb2ZOQVc3TC9Bb1hlamdLR1ZJ?=
 =?utf-8?B?blNPbHN4ckN2THViZ1dOTkFlK2dEUGhsdkxSc1NsdUtSa2FPNElqSW16aE1k?=
 =?utf-8?B?M0xiKzBLZWF4RFI5aDBWTGVLek1aKzNFbFlwSUZOQUN1N0lJaUlra0J0aTlF?=
 =?utf-8?B?Q2pQSTFtbHQ1RmdDVCs4ZXpwU1k2a0UrSTArK21yK1p4Z3RBcGVXUE4rYjB3?=
 =?utf-8?B?Tkh3Q09TSWRoSEx3ajhKV1JpV1pFSW1wem8zQWZ4dXFZM1dOK2R2ZDEzTDJU?=
 =?utf-8?B?SGFmNmJrbGFza1Uvc21vNDlGK1MvejBEQWthTHNiajBXTHlleXNIVFJOZlhv?=
 =?utf-8?B?WEZqZFN4Qk55QVFSa2pGeTRlR0ZLQ2lteDE0RE5OZnhQYjBBT3Y1aFRTOCtM?=
 =?utf-8?B?dExLajFOQVFFUmFCYVQ5MkpscHFwMlBSVDBmaXMxdDBUN1NCU1dQTUl1ME14?=
 =?utf-8?B?d0s4cUtBYklnY01UdVVUMFNRU2N3dVg0dER0em9Xd3VoOUdaYkJmQWRLUm44?=
 =?utf-8?B?R0d6cExuSmh2aHV6ZFpJZ2hwU1Y0NkFramRmSTl6U2VRbnpBYmRJV09mVDdG?=
 =?utf-8?B?VS9mV01Fd01WQ3R5VkhEblVabGxkNEhwVVZ6OWJsWlM5QjVGc1BTclhhRHQx?=
 =?utf-8?B?dlNPbWJkM0NzN285UGpCWVVwTzFndEZVazNMOFVVblliQkhyRDNreWxpb3lm?=
 =?utf-8?B?ZnhrbmpSSDZvbmNSNzZIVFRFNFpwQUQ3Y2lCbkdNSGU0Vzg2S2c5KzNFcU9G?=
 =?utf-8?B?a2hiRWJkOGgvQ2ZVb1huWnAxbzVpM0ZWRVA5VFZLRUh2N0p1b0MvQzBJcWFC?=
 =?utf-8?B?MzF3WDdGNnFaZHRITDI1VGUzK1ltdExtRU9JYTM2dmtzRnpNL0x3R1JMMWlv?=
 =?utf-8?B?RExrNXFhM3c4MXhiTjh1bmtncHBvMkZPekZJamVYSEd0MmNjNFVEZmRkSWpr?=
 =?utf-8?B?YlpWNm0zTXpjdlBzZDFYQWh3eTB5Q3ZUcWtXUXFBeERmVElhdzVlRzFGVk83?=
 =?utf-8?B?ZzZNWWZJdUlBVE9ycDJXcG9VZHc3NHZPVFZ4cXYwNlVXODZicHlLM2MydzRi?=
 =?utf-8?B?bHBTTGtyVDA3VEkvOTR5bEUycmxCOWloZEdhWG5zSEVOa0xYb1hJWmhTdlhy?=
 =?utf-8?B?S1ptZXgxVWZpOGNhSEJMa21aUXlTSytrbjVuQXBTdTcza25XRFcwM0RiZGpK?=
 =?utf-8?B?bDFreWVjZmFnOXByTEF5WnhSQnRzRm54WG0zYk05a3B0U3V1SGFOVS9wajE2?=
 =?utf-8?B?WHhxMjEvL3Y0eU1zaXhGWkY3SXdUbHhIbm84dk1ITlN6Rkh3ejhkYjg1MGpy?=
 =?utf-8?B?NTBMVEs5NEdRS1REMWJFeU9PVmQrdzV2eGNkQk1EejVTZmlsc3lwVlRJN1g1?=
 =?utf-8?B?Wk84UnJQbVEwSlpaNjB6L215Y1dUMCtwSUdWUk1GUDA4WGhLNnozbk01d0Fw?=
 =?utf-8?B?Z0xMZjFyZ1hHcVZqbkRXZURId0FPM0c3WlplM2FqTlBqUUZQdTdOTEw0czNO?=
 =?utf-8?B?Qjh1WExIYnRhYldlOTdCZTJhZnBKRm1MVFZCZjJySWJ1MHYrb0R2YWgwcmF1?=
 =?utf-8?Q?dKZbkOstnWs7ubsU=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308e756d-87b4-4156-cf9f-08da386586b1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 00:29:53.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKWllcLRDQnRDl7BiZIoxkKySK0FL3csGzl/w5pYrH0Jt4XO+3unTn9WEjfQ48lV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5124
X-Proofpoint-GUID: qn-nBHlMceJo9UhRMLBdi9v12j-yhtmV
X-Proofpoint-ORIG-GUID: qn-nBHlMceJo9UhRMLBdi9v12j-yhtmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/17/22 8:39 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 12, 2022 at 03:55:14PM -0700, Andrii Nakryiko escreveu:
>> On Wed, May 11, 2022 at 10:18 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> With latest llvm15 built kernel (make -j LLVM=1), I hit the following
>>> error when build selftests (make -C tools/testing/selftests/bpf -j LLVM=1):
>>>    In file included from skeleton/pid_iter.bpf.c:3:
>>>    .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
>>>         '__builtin_va_list___2'; did you mean '__builtin_va_list'?
>>>    typedef __builtin_va_list___2 va_list___2;
>>>            ^~~~~~~~~~~~~~~~~~~~~
>>>            __builtin_va_list
>>>    note: '__builtin_va_list' declared here
>>>    In file included from skeleton/profiler.bpf.c:3:
>>>    .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
>>>         '__builtin_va_list__ _2'; did you mean '__builtin_va_list'?
>>>    typedef __builtin_va_list___2 va_list___2;
>>>            ^~~~~~~~~~~~~~~~~~~~~
>>>            __builtin_va_list
>>>    note: '__builtin_va_list' declared here
>>>
>>> The error can be easily explained with after-dedup vmlinux btf:
>>>    [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>>>    [2300] STRUCT '__va_list_tag' size=24 vlen=4
>>>          'gp_offset' type_id=2 bits_offset=0
>>>          'fp_offset' type_id=2 bits_offset=32
>>>          'overflow_arg_area' type_id=32 bits_offset=64
>>>          'reg_save_area' type_id=32 bits_offset=128
>>>    [2308] TYPEDEF 'va_list' type_id=2309
>>>    [2309] TYPEDEF '__builtin_va_list' type_id=2310
>>>    [2310] ARRAY '(anon)' type_id=2300 index_type_id=21 nr_elems=1
>>>
>>>    [5289] PTR '(anon)' type_id=2308
>>>    [158520] STRUCT 'warn_args' size=32 vlen=2
>>>          'fmt' type_id=14 bits_offset=0
>>>          'args' type_id=2308 bits_offset=64
>>>    [27299] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>>>    [34590] TYPEDEF '__builtin_va_list' type_id=34591
>>>    [34591] ARRAY '(anon)' type_id=2300 index_type_id=27299 nr_elems=1
>>>
>>> Note that two array index_type_id's are different so the va_list and __builtin_va_list
>>> will have two versions in the BTF. With this, vmlinux.h contains the following code,
>>>    typedef __builtin_va_list va_list;
>>>    typedef __builtin_va_list___2 va_list___2;
>>> Since __builtin_va_list is a builtin type for the compiler,
>>> libbpf does not generate
>>>    typedef <...> __builtin_va_list
>>> and this caused __builtin_va_list___2 is not defined and hence compilation error.
>>> This happened when pahole is running with more than one jobs when parsing dwarf
>>> and generating btfs.
>>>
>>> Function btf_encoder__encode_cu() is used to do btf encoding for
>>> each cu. The function will try to find an "int" type for the cu
>>> if it is available, otherwise, it will create a special type
>>> with name __ARRAY_SIZE_TYPE__. For example,
>>>    file1: yes 'int' type
>>>    file2: no 'int' type
>>>
>>> In serial mode, file1 is processed first, followed by file2.
>>> both will have 'int' type as the array index type since file2
>>> will inherit the index type from file1.
>>>
>>> In parallel mode though, arrays in file1 will have index type 'int',
>>> and arrays in file2 wil have index type '__ARRAY_SIZE_TYPE__'.
>>> This will prevent some legitimate dedup and may have generated
>>> vmlinux.h having compilation error.
>>>
>>> This patch fixed the issue by creating an 'int' type as the
>>> array index type, so all array index type should be the same
>>> for all cu's even in parallel mode.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   btf_encoder.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>
>> LGTM, it should work reliably.
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Applied and testing.

Thanks!

> 
> - Arnaldo
>   
>>> Changelog:
>>>    v1 -> v2:
>>>     - change creation of array index type to be 'int' type,
>>>       the same as the type encoder tries to search in the current
>>>       types.
>>>
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 1a42094..9e708e4 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -1460,7 +1460,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>>>
>>>                  bt.name = 0;
>>>                  bt.bit_size = 32;
>>> -               btf_encoder__add_base_type(encoder, &bt, "__ARRAY_SIZE_TYPE__");
>>> +               bt.is_signed = true;
>>> +               btf_encoder__add_base_type(encoder, &bt, "int");
>>>                  encoder->has_index_type = true;
>>>          }
>>>
>>> --
>>> 2.30.2
>>>
> 
