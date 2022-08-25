Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111415A07C5
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 06:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiHYEK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 00:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYEK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 00:10:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3239DB7C
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 21:10:54 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P0ivN4023863;
        Wed, 24 Aug 2022 21:10:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3RTkOT8m8JSlrFvlEllDd3ZFuV5KA4TOgfNFmpvIvR0=;
 b=XJUDOCpX3t45RPu5XEeyZ4+2LqXP9hFwEy1B6e9E05kToKRKGgoLGyYwwT52+VKYw9tJ
 ZnAY4VTdzL9gTfIcGOf5ZGXJ7pDKSumVVjT+q6H+fl2fFWKEefrOtqCWxvcAVDGuq86m
 AHWeVPbIwawuwSvF+6APr60DiuziyIPIGu4= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5u572424-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 21:10:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXpk4CzBs+AGyhlsegym2wfojtBqDGKxMPI+HTt8ZbD3kaT8nt5OLqt1oShYacK58biLNTytEyqOJVl7EVYhp5moWjg8dXYeExBEYR/pFj+RcWpSjoMSJLNlQkdAovL6nuzE1Cc14Hn17FeLuqhKuasblUbrsAyGbeaA1IUx1Wez+RgbFBQ2gz1ZBD0bV/GpbTqT8zMgtDA+ZxA0/wsqGeu0C7ifuPoj2UAOAYy/7XhSfsR4YsPDNJksUdss/w1pDdOWy2R83qj0eMWgOSvQagV6AOKMzLAu9S3NArJmqBBQ0ZxnUbMNISmyhV85To7p7mA0a91PjzLbpiEYQDnbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RTkOT8m8JSlrFvlEllDd3ZFuV5KA4TOgfNFmpvIvR0=;
 b=AMBZGAar9zRrT+d8i6u4w5TF72inWfms4mPl4McC82xLSpCABCEWzbGm3+wB5IGZWNtSLYbdrHvgNbQ3P8VM+zZHYSyF3/XAhhoBHKEFqX0SPvk8FP89eWaegGd/YUdwvqFkRifujYhWQDge552satJOIrM7kQl+peHxj4RvyF93oL7ClTXDM5VtbRFYzGvrXhlMnyTaBByPY5cgDQbZWI6sc+E+h7NlZP3UrBf65/GgIenwC9S/BzYs99E7lR4k7Eb9r+PuaxIVjXtRTdroFyKBiYB5k46KvvjyGaMfZBvmmkU98cSJOIoHE4f0STLDm3YbQg4d+xlFMUy9PCNr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4750.namprd15.prod.outlook.com (2603:10b6:510:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 04:10:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 04:10:36 +0000
Message-ID: <60ac8d9e-a8d5-634a-7f19-75cf393637d2@fb.com>
Date:   Wed, 24 Aug 2022 21:10:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct
 arguments
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220812052419.520522-1-yhs@fb.com>
 <20220812052435.523068-1-yhs@fb.com>
 <CAADnVQKvtxdSo3chBeGtv8KsoQ8drrpa7x=1sOem1kwYKr5iRw@mail.gmail.com>
 <bdb4feae-47c3-80f6-cc10-741f90c28eeb@fb.com>
 <20220818204428.whsirz2m6prikg7n@MacBook-Pro-3.local>
 <18c8145c-f6fb-865e-ebd7-2c0c694fdb13@fb.com>
 <CAADnVQLVuMX4je_4qMruPiDvGf+Uzn80Q1iFcmmunzd9hxFL8g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQLVuMX4je_4qMruPiDvGf+Uzn80Q1iFcmmunzd9hxFL8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77dc540a-0208-46cb-97df-08da864fc367
X-MS-TrafficTypeDiagnostic: PH0PR15MB4750:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IDKVgvnL9+8UxIm01bWgTTnKX4sy799YHAX1uyBlYyUV4rr/debWcptoHuzVYDJQTlNGWFZT/Ts1UsZBCQ+A7cYZ9ggqb5qa/hFLv6FKis1mSupkBNhvYxo1wAi0UQ44vYMam0G07rCf/D/rFUpiAL98bL1+wcPmzX9Y1aNYC9hsxIKzJ2QPK46LPc9RF3/aSmHxIv85HyxaPxbcpnXZ7Gqh2Jh32nNg6SmqkRMt+UMOngAKxfHRTeXqTmM2ZahmmKNO0T19RXc/G8LS6geUhJA/G1jodVdfPpIqTZVdLS/Q7CpW4jzs5e+vl3k3vjKn/loxRJjY3WbNVUtDdgFjrJGt5KuAVGFlWppoRncn6FpGK/u2FZ5A0phVaX9BLapkJzPKWuBEL0DQasQekTZiC6FeR7uING/PS+0oy725Lg71S9XeIvvWLtdXet7hKNBJtnGjup5xJjez6rk6mSjH8SsJuBfx8Q6cavCbn6si2VKd6Azzmv64qtY2f80XaIRMGrTiyjMdknqqJih6MFf6NdtexCcg72nFYqiYpkNi9sw6Gxx1UqiYx+9yC09IsV8mh6SZweoL7M/hFztRRxBEk2VyiL/4tu0LFsGdjXeDtbT3DUhMIcvaLSgN7s/iOU0yfmsKRSMf/4yZ0HsgqSYUDNbxzg5ji4Y30ujcIJWtMrTM7q98x4OhyMhmB37r0yZqejog0ipv8AGxbHZOZQIJ+U55piQoeElP5q+YF6Yo3BSBa1TyTEpQBh7dr7wDnWCNtUJpeRcfrQxkMeAQjLlxfkam42Kc9TvQmprbLH0eFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(8676002)(4326008)(2906002)(66476007)(6916009)(54906003)(66556008)(66946007)(30864003)(8936002)(5660300002)(38100700002)(316002)(36756003)(86362001)(31696002)(6506007)(41300700001)(6512007)(53546011)(478600001)(6486002)(83380400001)(2616005)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWN1ZEJObDFFb2hCVnNNVjlYa2VVUWVpbUFEenA0SlhkUFI0UUpSNGlOdlI4?=
 =?utf-8?B?SkRXMDBVdVpwaXVpUXVxVUU0dzE2VFdZNm9QWXhYZkdLQmFNN0JnMEtVbkh3?=
 =?utf-8?B?ZzU1Mkp2STZaaVJhZjIrNzljamhjdkxBWUV0UVVNendYdXFlRnFzbTRQTkwv?=
 =?utf-8?B?eUltWXNvcHh6ZXZjNUxBYjRFMGxYL1k0VlI4UkUzYXU2UE1RcGplSEIwVEdP?=
 =?utf-8?B?MHIySG80NFVEZUJYdGczWUJrc1FQSzNKMWNVZy9uZE1jRTRrMU04UFJRcEZl?=
 =?utf-8?B?Ulh2T2Q5N2c3MkRSQ0liQVNGMFY5YTdUS3dQVk0rTCtvd0hhUkhNbGVaNmNl?=
 =?utf-8?B?bitoWWFzWGdnbzhETnE0N0hnNWZJanZwUEJPRjNHWFBGOFF3QThBb3QrbFRO?=
 =?utf-8?B?eUN4OGcrcnhVWkEzSXFpM3ZCRGRXTXRTYXBld3U4SmRYdWQzVVcxb2V0M01q?=
 =?utf-8?B?WTRQQTY3VFlmL21aTzBLVkZoNkhEemcrQzJUVDRsZHZPMmVoTUlDVmRmaEVD?=
 =?utf-8?B?MWtJK3lXQUhPVWoybmQ2NFo3K3ErRDI0UE0zQWxDZllHMXZMTXh0QklmcUNP?=
 =?utf-8?B?QlgwbXVkUG4zbzlBdzFzZ1gzc2VqTUZGcmtaS25NS0Y0TGFBcXFuNk9uNjNV?=
 =?utf-8?B?ZVJtNVMzNTEzYi9tMmhSSWV4YXN1RkpjWlNJTUZjU0l0VHBxZ3dhSWc0UDNu?=
 =?utf-8?B?WW9jSHBSb0VQZktzeFh3cUtoSkRXM0NxSFBDTzlrbWVKc1M0eWdmWlB0Q2Nh?=
 =?utf-8?B?NVFyajM1Q2xPMERyYmp0Mk5WU0FpRERZRXdHOWNadjFEalhvMTFkcSs3ZG9v?=
 =?utf-8?B?bTVyQms0OTJZVThRdFR5OEJ1cFFiWk1ETW1RRkpoVUlYa1Y5TkVxVU1wVjNw?=
 =?utf-8?B?bEFCcm1vM09pR0puaWthcURGMjdoM1hkU0c4Y2VOMWltYU1hN0twTTVlaStL?=
 =?utf-8?B?Q3o4Wk5IbDBLeXpxS2NlZ2ZNZEhMS0dDcVR4eXZFWVhMMjc3cHV0YUFteFJP?=
 =?utf-8?B?VEp0ZWdRYWt3cU5UMjFlMEp2cjROY2JpanFQMjllYjdYU0VzZEI0UEhNdkNY?=
 =?utf-8?B?SVpCSnFzd2kzQVZlYS9YN1VEUHhnY3hzT0xYTnF1RkFHUE5BSHFnU3NCVnEx?=
 =?utf-8?B?V1pmUGI4ZmVSd1drV1ZVZHA2Y1hhRTV3LzBPcGxRNlMyTEVrVGJyb1kyNnAy?=
 =?utf-8?B?Q2xhUUNFNUxrRnhuZXFKQ2VhcFFMMHB2aWdQNjl1TEJSUFZZbE5LR0N6clA2?=
 =?utf-8?B?U3dsWWUzendXck1ma29MaEluVnpvMDg0N3hMQk5TWndmbW84cFA4amxpM0ph?=
 =?utf-8?B?TTB1ZGlDUlhySmdPWDkrZmJoWHgxTnJhQUZvMnhxeG1yak05SDRsTmlTWWVH?=
 =?utf-8?B?bjRhazlLVjAvYlVEaUVRRGVxenFSb3ZVWm1VaEY4RjFnQnNBQmFwN1ovb0xn?=
 =?utf-8?B?d0o1NVlJdEEwdmVFWXRQWHhmQXBweVF4MTdWdkFRV2k4QTNyYkRvVEFNNjJZ?=
 =?utf-8?B?MW0vYXNVenlQSllXNjRRUzhqbklwbUhqVlNpT2loTS9DRHFKRVlncGxrT1BV?=
 =?utf-8?B?SFdCdXV0QjJWcUp4TE5IZ1RSeEFxZURVaHh1cURJdnF5emdCcEw3NkNaNTQ2?=
 =?utf-8?B?em9VdkdxYjNrdEFlNTZUcnN0TnFpTWJxOFRJNW41WE4zZlJ3M0Jzd2R0Vmo3?=
 =?utf-8?B?ME1lV3NrS3Nmb0VCaEk0K0d1SjQ5cFlkeVo5dFFCbTZBUlpCQkJ0SVNJdmtr?=
 =?utf-8?B?d1FSaDFSSDBSM1Z2ZkUydVF5cXRONkhvelhXYlBKQ2pQUDFOR3JhUWdZYzJs?=
 =?utf-8?B?UERtMkpzNWl5ZnErR1M3WGozaGpROVpuNFBKR0NhWVR6a0twcmV5Tzl0MDlO?=
 =?utf-8?B?ZUFlYTNDV2hPTzFzM0cyenhnc2I1UWNNM2d0VnRPaFJ4dEk1T2gwak92UVU1?=
 =?utf-8?B?RnhBMjVtSU9wQlhHTzUzdk1ZeVJPS2JDR0dGNEhHQkp4RXdUbEhScFhYZ0Ru?=
 =?utf-8?B?WGZVM1pnUm1XVHN3YjkrMzd0K2VhSUE2bjl4RTQzdmpYdTd3anJXcGJNd0xE?=
 =?utf-8?B?NmNGN0VoMTNzT1ZPV2tvbEI4ajBuZEZITE55VHBIZWxBKzBzYW1vSE40WjRN?=
 =?utf-8?B?dGZWekJIU0w2WTNCOFRRYTU3Szh1SWRWR3lDdXVTRGdZQVViaUdZb05sbGg0?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dc540a-0208-46cb-97df-08da864fc367
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 04:10:36.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPVJURecZXJOXnuNlG6T3dIHsZ0Bz2muNIoOp8FNHt3vZ+2sIwyfzuAJkJBJTI3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4750
X-Proofpoint-GUID: wbF75X9f050KWZPKd1-_iHJBEPA582Jh
X-Proofpoint-ORIG-GUID: wbF75X9f050KWZPKd1-_iHJBEPA582Jh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_02,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/24/22 3:35 PM, Alexei Starovoitov wrote:
> On Wed, Aug 24, 2022 at 12:05 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 8/18/22 1:44 PM, Alexei Starovoitov wrote:
>>> On Wed, Aug 17, 2022 at 09:56:23PM -0700, Yonghong Song wrote:
>>>>
>>>>
>>>> On 8/15/22 3:44 PM, Alexei Starovoitov wrote:
>>>>> On Thu, Aug 11, 2022 at 10:24 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>
>>>>>> In C, struct value can be passed as a function argument.
>>>>>> For small structs, struct value may be passed in
>>>>>> one or more registers. For trampoline based bpf programs,
>>>>>> This would cause complication since one-to-one mapping between
>>>>>> function argument and arch argument register is not valid
>>>>>> any more.
>>>>>>
>>>>>> To support struct value argument and make bpf programs
>>>>>> easy to write, the bpf program function parameter is
>>>>>> changed from struct type to a pointer to struct type.
>>>>>> The following is a simplified example.
>>>>>>
>>>>>> In one of later selftests, we have a bpf_testmod function:
>>>>>>        struct bpf_testmod_struct_arg_2 {
>>>>>>            long a;
>>>>>>            long b;
>>>>>>        };
>>>>>>        noinline int
>>>>>>        bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, int c) {
>>>>>>            bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
>>>>>>            return bpf_testmod_test_struct_arg_result;
>>>>>>        }
>>>>>>
>>>>>> When a bpf program is attached to the bpf_testmod function
>>>>>> bpf_testmod_test_struct_arg_2(), the bpf program may look like
>>>>>>        SEC("fentry/bpf_testmod_test_struct_arg_2")
>>>>>>        int BPF_PROG(test_struct_arg_3, int a, struct bpf_testmod_struct_arg_2 *b, int c)
>>>>>>        {
>>>>>>            t2_a = a;
>>>>>>            t2_b_a = b->a;
>>>>>>            t2_b_b = b->b;
>>>>>>            t2_c = c;
>>>>>>            return 0;
>>>>>>        }
>>>>>>
>>>>>> Basically struct value becomes a pointer to the struct.
>>>>>> The trampoline stack will be increased to store the stack values and
>>>>>> the pointer to these values will be saved in the stack slot corresponding
>>>>>> to that argument. For x86_64, the struct size is limited up to 16 bytes
>>>>>> so the struct can fit in one or two registers. The struct size of more
>>>>>> than 16 bytes is not supported now as our current use case is
>>>>>> for sockptr_t in the argument. We could handle such large struct's
>>>>>> in the future if we have concrete use cases.
>>>>>>
>>>>>> The main changes are in save_regs() and restore_regs(). The following
>>>>>> illustrated the trampoline asm codes for save_regs() and restore_regs().
>>>>>> save_regs():
>>>>>>        /* first argument */
>>>>>>        mov    DWORD PTR [rbp-0x18],edi
>>>>>>        /* second argument: struct, save actual values and put the pointer to the slot */
>>>>>>        lea    rax,[rbp-0x40]
>>>>>>        mov    QWORD PTR [rbp-0x10],rax
>>>>>>        mov    QWORD PTR [rbp-0x40],rsi
>>>>>>        mov    QWORD PTR [rbp-0x38],rdx
>>>>>>        /* third argument */
>>>>>>        mov    DWORD PTR [rbp-0x8],esi
>>>>>> restore_regs():
>>>>>>        mov    edi,DWORD PTR [rbp-0x18]
>>>>>>        mov    rsi,QWORD PTR [rbp-0x40]
>>>>>>        mov    rdx,QWORD PTR [rbp-0x38]
>>>>>>        mov    esi,DWORD PTR [rbp-0x8]
>>>>>
>>>>> Not sure whether it was discussed before, but
>>>>> why cannot we adjust the bpf side instead?
>>>>> Technically struct passing between bpf progs was never
>>>>> officially supported. llvm generates something.
>>>>> Probably always passes by reference, but we can adjust
>>>>> that behavior without breaking any programs because
>>>>> we don't have bpf libraries. Programs are fully contained
>>>>> in one or few files. libbpf can do static linking, but
>>>>> without any actual libraries the chance of breaking
>>>>> backward compat is close to zero.
>>>>
>>>> Agree. At this point, we don't need to worry about
>>>> compatibility between bpf program and bpf program libraries.
>>>>
>>>>> Can we teach llvm to pass sizeof(struct) <= 16 in
>>>>> two bpf registers?
>>>>
>>>> Yes, we can. I just hacked llvm and was able to
>>>> do that.
>>>>
>>>>> Then we wouldn't need to have a discrepancy between
>>>>> kernel function prototype and bpf fentry prog proto.
>>>>> Both will have struct by value in the same spot.
>>>>> The trampoline generation will be simpler for x86 and
>>>>> its runtime faster too.
>>>>
>>>> I tested x86 and arm64 both supports two registers
>>>> for a 16 byte struct.
>>>>
>>>>> The other architectures that pass small structs by reference
>>>>> can do a bit more work in the trampoline: copy up to 16 byte
>>>>> and bpf prog side will see it as they were passed in 'registers'.
>>>>> wdyt?
>>>>
>>>> I know systemz and Hexagon will pass by reference for any
>>>> struct size >= 8 bytes. Didn't complete check others.
>>>>
>>>> But since x86 and arm64 supports direct value passing
>>>> with two registers, we should be okay. As you mentioned,
>>>> we could support systemz/hexagon style of struct passing
>>>> by copying the values to the stack.
>>>>
>>>>
>>>> But I have a problem how to define a user friendly
>>>> macro like BPF_PROG for user to use.
>>>>
>>>> Let us say, we have a program like below:
>>>> SEC("fentry/bpf_testmod_test_struct_arg_1")
>>>> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a, int b,
>>>> int c) {
>>>> ...
>>>> }
>>>>
>>>> We have BPF_PROG macro definition here:
>>>>
>>>> #define BPF_PROG(name, args...)     \
>>>> name(unsigned long long *ctx);     \
>>>> static __always_inline typeof(name(0))     \
>>>> ____##name(unsigned long long *ctx, ##args);     \
>>>> typeof(name(0)) name(unsigned long long *ctx)     \
>>>> {     \
>>>>           _Pragma("GCC diagnostic push")      \
>>>>           _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
>>>>           return ____##name(___bpf_ctx_cast(args));      \
>>>>           _Pragma("GCC diagnostic pop")      \
>>>> }     \
>>>> static __always_inline typeof(name(0))     \
>>>> ____##name(unsigned long long *ctx, ##args)
>>>>
>>>> Some we have static function definition
>>>>
>>>> int ____test_struct_arg_1(unsigned long long *ctx, struct
>>>> bpf_testmod_struct_arg_2 *a, int b, int c);
>>>>
>>>> But the function call inside the function test_struct_arg_1()
>>>> is
>>>>     ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2]);
>>>>
>>>> We have two problems here:
>>>>     ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
>>>> does not match the static function declaration.
>>>> This is not problem if everything is int/ptr type.
>>>> If one of argument is structure type, we will have
>>>> type conversion problem. Let us this can be resolved
>>>> somehow through some hack.
>>>>
>>>> More importantly, because some structure may take two
>>>> registers,
>>>>      ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
>>>> may not be correct. In my above example, if the
>>>> structure size is 16 bytes,
>>>> then the actual call should be
>>>>      ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2], ctx[3])
>>>> So we need to provide how many extra registers are needed
>>>> beyond ##args in the macro. I have not tried how to
>>>> resolve this but this extra information in the macro
>>>> definite is not user friendly.
>>>>
>>>> Not sure what is the best way to handle this issue (##args is not precise
>>>> and needs addition registers for >8 struct arguments).
>>>
>>> The kernel is using this trick to cast 8 byte structs to u64:
>>> /* cast any integer, pointer, or small struct to u64 */
>>> #define UINTTYPE(size) \
>>>           __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
>>>                      __builtin_choose_expr(size == 2, (u16)2, \
>>>                      __builtin_choose_expr(size == 4, (u32)3, \
>>>                      __builtin_choose_expr(size == 8, (u64)4, \
>>>                                            (void)5)))))
>>> #define __CAST_TO_U64(x) ({ \
>>>           typeof(x) __src = (x); \
>>>           UINTTYPE(sizeof(x)) __dst; \
>>>           memcpy(&__dst, &__src, sizeof(__dst)); \
>>>           (u64)__dst; })
>>>
>>> casting 16 byte struct to two u64 can be similar.
>>> Ideally we would declare bpf prog as:
>>> SEC("fentry/bpf_testmod_test_struct_arg_1")
>>> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 a, int b, int c) {
>>> note there is no '*'. It's struct by value.
>>> The main challenge is how to do the math in the BPF_PROG macros.
>>> Currently it's doing:
>>> #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
>>> #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
>>> #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
>>> #define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (void *)ctx[3]
>>>
>>> The ctx[index] is one-to-one with argument position.
>>> That 'index' needs to be calculated.
>>> Maybe something like UINTTYPE() that applies to previous arguments?
>>> #define REG_CNT(arg) \
>>>           __builtin_choose_expr(sizeof(arg) == 1,  1, \
>>>           __builtin_choose_expr(sizeof(arg) == 2,  1, \
>>>           __builtin_choose_expr(sizeof(arg) == 4,  1, \
>>>           __builtin_choose_expr(sizeof(arg) == 8,  1, \
>>>           __builtin_choose_expr(sizeof(arg) == 16,  2, \
>>>                                            (void)0)))))
>>>
>>> #define ___bpf_reg_cnt0()            0
>>> #define ___bpf_reg_cnt1(x)          ___bpf_reg_cnt0() + REG_CNT(x)
>>> #define ___bpf_reg_cnt2(x, args...) ___bpf_reg_cnt1(args) + REG_CNT(x)
>>> #define ___bpf_reg_cnt(args...)    ___bpf_apply(___bpf_reg_cnt, ___bpf_narg(args))(args)
>>>
>>> This way the macro will calculate the index inside ctx[] array.
>>>
>>> and then inside ___bpf_ctx_castN macro use ___bpf_reg_cnt.
>>> Instead of:
>>> ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
>>> it will be
>>> ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), \
>>>     __builtin_choose_expr(sizeof(x) <= 8, (void *)ctx[___bpf_reg_cnt(args)],
>>>                           *(typeof(x) *) &ctx[___bpf_reg_cnt(args)])
>>
>> I tried this approach. The only problem is sizeof(x) <= 8 may also be
>> a structure. Since essentially we will have a type conversion like
>>      (struct <name))(void *)ctx[...]
>> and this won't work.
> 
> Right. Just sizeof(x) <= 8 won't work.
> 
>> So ideally we want something like
>> __builtin_choose_expr(is_struct_type(x), *(typeof(x) *)
>> &ctx[___bpf_reg_cnt(args)]
>>       (void *)ctx[___bpf_reg_cnt(args)])
>> here is_struct_type(x) tells whether the type is a struct type
>> or typedef of a struct. Currently we don't have a such a macro/builtin yet.
> 
> Got it.
> Maybe we can do *(typeof(x) *) &ctx[___bpf_reg_cnt(args)]
> unconditionally for all args?
> Only endianness will be an issue.

Yes, endianness will be an issue.

> 
>> Note that in order to make sizeof(x) or is_struct_type(x) work, we
>> need to separate type and argument name like
>>
>> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int,
>> b, int, c)
> 
> agree.
> 
>> Which will make the macro incompatible with existing BPF_PROG macro.
> 
> right. we need a new macro regardless.
> 
>>>
>>> x - is one of the arguments.
>>> args - all args before 'x'. Doing __bpf_reg_cnt on them should calculate the index.
>>> *(typeof(x) *)& should type cast to struct of 16 bytes.
>>>
>>> Rough idea, of course.
>>>
>>> Another alternative is instead of:
>>> #define BPF_PROG(name, args...)
>>> name(unsigned long long *ctx);
>>> do:
>>> #define BPF_PROG(name, args...)
>>> struct XX {
>>>     macro inserts all 'args' here separated by ; so it becomes a proper struct
>>> };
>>> name(struct XX *ctx);
>>>
>>> and then instead of doing ___bpf_ctx_castN for each argument
>>> do single cast of all of 'u64 ctx[N]' passed from fentry into 'struct XX *'.
>>> The problem with this approach that small args like char, short, int needs to
>>> be declared in struct XX with __align__(8).
>>
>> This should work. But since we will change context type from
>> "unsigned long long *" to "struct XX *", the code pattern will look like
>>
>> BPF_PROG2_DECL(test_struct_arg_1);
>> SEC("fentry/bpf_testmod_test_struct_arg_1")
>> int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a,
>> int, b, int, c)
>>
>> Where BPF_PROG2_DECL will provide a forward declaration like
>> #define BPF_PROG2_DECL(name) struct _____##name;
>>
>> and BPF_PROG2 will look like (not handling zero argument yere)
>>
>> #define BPF_PROG2(name, args...)                                      \
>> name(struct _____##name *ctx);                                        \
>> struct _____##name {                                                  \
>>          ___bpf_ctx_field(args)                                         \
>> };                                                                    \
>> static __always_inline typeof(name(0))                                \
>> ____##name(struct _____##name *ctx, ___bpf_ctx_decl(args));           \
>> typeof(name(0)) name(struct _____##name *ctx)                         \
>> {                                                                     \
>>          return ____##name(ctx, ___bpf_ctx_arg(args));                  \
>> }                                                                     \
>> static __always_inline typeof(name(0))                                \
>> ____##name(struct _____##name *ctx, ___bpf_ctx_decl(args))
>>
>> where __bpf_ctx_field(args) will generate
>>      struct bpf_testmod_struct_arg_2 a;
>>      int b;
>>      int c;
>>
>> ___bpf_ctx_arg(args) will generate
>>      ctx->a, ctx->b, ctx->c
>>
>> and ___bpf_ctx_decl(args) will generate proper argument prototypes
>> the same way as in BPF_PROG macro.
> 
> Great that 2nd approach works :)
> If 1st approach can be made to work we won't need
> additional line BPF_PROG2_DECL(test_struct_arg_1);
> right?

Right. I don't like addition macro like BPF_PROG2_DECL as well.
I just checked Andrii's approach. It may work and we may not need
the addition macro any more.

> 
> Either way we can start with 2nd approach and improve on it later.
