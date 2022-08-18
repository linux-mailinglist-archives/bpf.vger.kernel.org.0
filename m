Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A62597DB7
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 06:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbiHRE4q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 00:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiHRE4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 00:56:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF7F90C4A
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 21:56:43 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HNSugQ012025;
        Wed, 17 Aug 2022 21:56:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yubdMqlavSuzASRyao97zqdpYiPXVt3Zqf6KH4Qkjbw=;
 b=pwHNAZVHRNV6x5GJP77UhuWId1fFtqNPG3vlK82ecv37oyUb2BdF3LFTKBFojRSHXOGW
 eRe2tDfStoFFZHqwEOjzrPV4P7jGZq79IiBn99FbPf803r8/gIAfIqZN5gBzJQqnw0z5
 Pw1OY9++KCNvZx+Aa39zmPQp1a6TVHVlvdc= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0npd8bdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 21:56:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvL+ubgTM274lYu1rZt/j0taIPxfpj7vT/b5Dcmu+aUgK8a6PdNaulfgZY97Hw2GOdDxyk8mHvQElULw1Q/sjeyjdcGwpyYzB4Kpu9g5mhlYomXO+s0EBweRRZzoMMm4ebBfjICiz7Ad+hB8o1hJnaAsg0Wp//q/fczM+CYj7wkKIWXxHvH5A9ShR+p15m2/VD3v5xbuS0sDfB4zDKYAexlafejADbYKd0gDtXQXCCbZislafJDNyDnQBkXCx3wq+JHJxsPeAfaJwgdFvEcw3brk4Jtnl9T3P9SBJpOjhLkHDNEcnxWRr+Cej/zhovh7eAC1rpYcMOFtqi1zmcUrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yubdMqlavSuzASRyao97zqdpYiPXVt3Zqf6KH4Qkjbw=;
 b=Unpm73ekQPgIsTewD8Y4OYwe9dLURgSO9xgFKJndbw4R5HvUSATWnYKRpcuhZQXvoEXctMPSZ5rly39oZN8YNOaDVzAPOpw+lX4AcXHYydGKriS+YezUOqrWhQMhl4/rFQ8f0dJJwhTa7gmi7GcY00EfZkKs18nt0jE+gBF5XiNBkhFEUknvCvkT3thvQmRyuIl1X+3U+Ug/fK3AeZB3asFYTEhZxnu7x28BdLApy33D/kt6d98e0OCxoGAG1AsefgtMtmS6ejxPijtBSqVxbxqJ6EPNIAXvDAhBXuxAKIZXOO+biZY3VP2gEs4jUT4wsVWPpw+88LRUcVWeAJXsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH2PR15MB3733.namprd15.prod.outlook.com (2603:10b6:610:d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Thu, 18 Aug
 2022 04:56:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Thu, 18 Aug 2022
 04:56:25 +0000
Message-ID: <bdb4feae-47c3-80f6-cc10-741f90c28eeb@fb.com>
Date:   Wed, 17 Aug 2022 21:56:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
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
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQKvtxdSo3chBeGtv8KsoQ8drrpa7x=1sOem1kwYKr5iRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4828dc4-d27c-467b-1826-08da80d6012a
X-MS-TrafficTypeDiagnostic: CH2PR15MB3733:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAXvB8PNvV4Xo5gtbAeKzwoGhhdoW+io5y8RzpFoRm8yXigp6dFpiHbKVLEMhz3UkT2p6TJKjMTovDRD/g8yezmzdaXuwpdab8NKWgG0zZl2BVk54Ojoe//qLLCOASVvBemmlZo2ZbX4ma2dj9WKXz+Pg907e1WVIS1bZXxF47csHl4DEMiSgd1mFC2F5w0VXt8SW8UAg24KeH5LlLcKO+plfCluDGlmWHJJ3GhXSyEE1uyPrSCZw7XBUaQX0fq9+AULuLSIuDLUVgztskNfGthMHJS+lJorBnxwCP/t6y4iKGXrr4uylL6HGvG+/SCpxfvNMa55DW04lfpk+tjGZeYRdyn8MI3BplLSPlTzkfUNLV0DejC8f4BU77hT7n4A4N80KhwLaKkwnWflfAwbI5iID4HeHpSZgtAoskMLes5oy/NXTO9URPkABwjNZIwCgl/U1daWUQqzA4Us7rX5lqmEdhgiIOBEf7U8KobeWU7OkBv6Ixid4ETu3gf4q4YSB3W7J8xzIptwGwpO2PtLKrwRJHt7ggkg5/RSIFRHHSm2BDuxBn51ZbHtQeBG5er315IH329J/XVwKVlrVJjP103f2JSMpTPNsyRWZVW8IxQco3dpUCXosUU8OLP9uPsUQBsOG4TikZ/sEVDOsu1ziSzzLGhnb4kkI9pZVpBQrtoMGTOj2tmw4cPSE6f8HNGkcAAmscYSCVusdD194lTXXxPYOBtQPDsxLOsePDmYhRX0OrhdzgE7ZiVlcW+0R+R+1UFM9iGGjZYtbEpbyhtQdFQ6GGERI71qJ4R5izuCgmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(8676002)(66476007)(66946007)(31696002)(2616005)(6506007)(186003)(6486002)(478600001)(6916009)(66556008)(4326008)(316002)(53546011)(86362001)(41300700001)(54906003)(6512007)(38100700002)(31686004)(2906002)(36756003)(5660300002)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXphc3hjVjZ4MFUya0pGM0xLNHpocWYxYkUxWm5TeWR5T0lDbmpUSlU5MnNx?=
 =?utf-8?B?UHpNTEtZQmhaeWhCVnRpRFBEbVZTS3dEMDg3Q0U0NWtuTGl4MTI4YjRxckwx?=
 =?utf-8?B?aGhpN2RHa3U0d0FXcmo2QUJveTVoNnRDVmtDU2tuN1VsS2E1bmFqZ1pFRjRv?=
 =?utf-8?B?NTJSV0hzNndlajhPd3N0d05iNkJ3Ny84VXRNdElteEhZSU00ZkpjM1NseHM4?=
 =?utf-8?B?QTIzTTRaYVlSaTZNbEJWVllZa01tMHBYWkZTRGtlbWU2bkxlODlTZDc1VUVH?=
 =?utf-8?B?cXdoMlltNlZ5TTErMGw1YVJjMCt0ajZ3SkV4NmlyWTVkSkdWTDlJb0Y5Qm00?=
 =?utf-8?B?cStPVUFXWmxqbkxuKytsSHB3NVZmU2hiT0JwQWFGeERSUWpRMyt4bTRlUERq?=
 =?utf-8?B?OCtrejVjb1gyMWQ5a242czB0ZDNNdmxrbUZlTUdGZU5yelV1OVUra01QZVRF?=
 =?utf-8?B?MkZsN3dkdXZVTksyZzZPbnRvZWpvWmpGSTFYekgvRUkwOUphR3pudGNpVDIr?=
 =?utf-8?B?QlhlRW5Oek8rWGxoeFhaZnR0SXRCU3pJbXNjQUZpUDFDbFNZRm40bm5rdzlh?=
 =?utf-8?B?NWYrTTZSNUpwTG4rSUgxbnV3NS93SnN2NHlBcm42Mzh6eGl3ZnFLbERleGJk?=
 =?utf-8?B?RDkxRDQ4TytkQ1BjdHZqSXRhOHJwSVdZVG1PRTFXbjZWbm5La3h5VllXVDY3?=
 =?utf-8?B?SytlRGhjVFltVFBhekVQM1o1YVptSzljczlsTk4vS1phRjFWeWx2VVQxYzNC?=
 =?utf-8?B?T3d2TDkzYlZwM3krdEZGNmQyMTBuajNmK0x3VXc1TmcrMkJFOW1ncUgyekpG?=
 =?utf-8?B?K3hBejQ2dGE4TWwvZzJUY283VzJTY000SWx1TGx5clI4cVpkMm9FMVNKcmVS?=
 =?utf-8?B?Mzh5eFB0dlVyYzlGb20wOVBwQXVLRllHOFJjeUJrTC83SFMwWDVhYm5JWm44?=
 =?utf-8?B?MHJDVW9ob3dmWEZrb2M2Mi9vZlhXMmltbm9QV0ZLSHY3RHFzRmRlV3JSTDdr?=
 =?utf-8?B?aEdvWWNIaFQxcmdYYlk5aVhmN1VYelJDUm8wQnhxOE5BNWV1ZCs1SnZUSTNk?=
 =?utf-8?B?aHZsdFRKSit2Z3NjRlVvWVNzVlVjN3lqRGM1SzZvUEpvWU5hTG42bFVNWGhp?=
 =?utf-8?B?VEhKRXRRclByMUFmMDRMNDUrUWRiSk1sdldkM1YzQU1FOXV1dTM1OUpOTFI2?=
 =?utf-8?B?RFFjUlVzQm54U1FTMlZoRk40b1IrcG83OWJRTUFzdzhXWTJKNXppT1hVYzhn?=
 =?utf-8?B?bitmL0YyYk1rdmh1NHJPWmNPRmJsenV0M0ZWYzhZU2ZVQ01FTU96aWR2K1hP?=
 =?utf-8?B?c05aRUJvRElRTVJIS1dFRUNyYnlXN21ma1VIbHdsV3MrZ3FBMHpkM0ZEdGxD?=
 =?utf-8?B?WUYyTTExV3VJK1h4Tml1YUkwV0h5RGtXNWZJdHRXNWhnRU05V3RTMlBYY1FX?=
 =?utf-8?B?MTZwdHI3Z2Y1dm5rSC9uUnFnM0o1azgybFdpNEhqRmVrRnlVS1NWRUxZRG9W?=
 =?utf-8?B?cTFkNkJXL2xWR1lUNXI2dVRUdHh1NkE3ajllMkQ3TmNyWVdJSTk3UnljM2dP?=
 =?utf-8?B?MklGeHA0WnJvcXhnMDJ1ZTZUblVyVzg0VkxFbkRFdGk1S0lVa1Nhdk9mVE1l?=
 =?utf-8?B?MS9VRm9uSnlwQ2pzeUJ4YXVVakJEWGlpbVF1YmtxekQ0WEMvYzFnNzJvU3F5?=
 =?utf-8?B?emJOZVRZRE1oVFlLeHdQajEzbllQVFNmeXA5MUJ2UVoyWjhQOERHTHRoRHMw?=
 =?utf-8?B?em1XdzNKV1lSNFBqUTNHcG9wc3FGQnRJcEtXRksxQVBHOGFNZ080REZsMmox?=
 =?utf-8?B?OE1PdWFuMWlCTE0rS3pkQU92bDlhZmxiMGlVeFEvUVVtM1VITHR6dTBraWpI?=
 =?utf-8?B?UlFEQS83cGZkTThrMm9oZVRId1p0d1VSQUlpUjhiL1V0V3hjNCtuT3lCNWR4?=
 =?utf-8?B?eFZHQzVSUUQwa3dHT1FwRHJwVEFESWxTaVJYb21Za0lFQUx2bUNFT2NuSm53?=
 =?utf-8?B?c1k4Zi9sOCtZVkxRQzNkcFN2Ry9yZ0xkOXFNM1AyN3orQ0ltV0xYcVdobmpX?=
 =?utf-8?B?Z1JKZVZhYUJjWUpHMURzUGRETVdTWHpyVG9RQW8wZ053ZGpBN3BkajRlOXc2?=
 =?utf-8?B?UHNrb0pHT082QmxsWFZhNmszRDZOSGh6RXJ3ZGpFT1hreWdRM2ZxTldnNEtY?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4828dc4-d27c-467b-1826-08da80d6012a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 04:56:25.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhlcgJEfp6zvzPIY6GH3AqdLpttOJnZlmzadT68B4xWo076wJIw8XWeZ70hN5bxk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3733
X-Proofpoint-GUID: Oql8nQehJ-vFfuiFeJLtOe0sjzrEuj2X
X-Proofpoint-ORIG-GUID: Oql8nQehJ-vFfuiFeJLtOe0sjzrEuj2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
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



On 8/15/22 3:44 PM, Alexei Starovoitov wrote:
> On Thu, Aug 11, 2022 at 10:24 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> In C, struct value can be passed as a function argument.
>> For small structs, struct value may be passed in
>> one or more registers. For trampoline based bpf programs,
>> This would cause complication since one-to-one mapping between
>> function argument and arch argument register is not valid
>> any more.
>>
>> To support struct value argument and make bpf programs
>> easy to write, the bpf program function parameter is
>> changed from struct type to a pointer to struct type.
>> The following is a simplified example.
>>
>> In one of later selftests, we have a bpf_testmod function:
>>      struct bpf_testmod_struct_arg_2 {
>>          long a;
>>          long b;
>>      };
>>      noinline int
>>      bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, int c) {
>>          bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
>>          return bpf_testmod_test_struct_arg_result;
>>      }
>>
>> When a bpf program is attached to the bpf_testmod function
>> bpf_testmod_test_struct_arg_2(), the bpf program may look like
>>      SEC("fentry/bpf_testmod_test_struct_arg_2")
>>      int BPF_PROG(test_struct_arg_3, int a, struct bpf_testmod_struct_arg_2 *b, int c)
>>      {
>>          t2_a = a;
>>          t2_b_a = b->a;
>>          t2_b_b = b->b;
>>          t2_c = c;
>>          return 0;
>>      }
>>
>> Basically struct value becomes a pointer to the struct.
>> The trampoline stack will be increased to store the stack values and
>> the pointer to these values will be saved in the stack slot corresponding
>> to that argument. For x86_64, the struct size is limited up to 16 bytes
>> so the struct can fit in one or two registers. The struct size of more
>> than 16 bytes is not supported now as our current use case is
>> for sockptr_t in the argument. We could handle such large struct's
>> in the future if we have concrete use cases.
>>
>> The main changes are in save_regs() and restore_regs(). The following
>> illustrated the trampoline asm codes for save_regs() and restore_regs().
>> save_regs():
>>      /* first argument */
>>      mov    DWORD PTR [rbp-0x18],edi
>>      /* second argument: struct, save actual values and put the pointer to the slot */
>>      lea    rax,[rbp-0x40]
>>      mov    QWORD PTR [rbp-0x10],rax
>>      mov    QWORD PTR [rbp-0x40],rsi
>>      mov    QWORD PTR [rbp-0x38],rdx
>>      /* third argument */
>>      mov    DWORD PTR [rbp-0x8],esi
>> restore_regs():
>>      mov    edi,DWORD PTR [rbp-0x18]
>>      mov    rsi,QWORD PTR [rbp-0x40]
>>      mov    rdx,QWORD PTR [rbp-0x38]
>>      mov    esi,DWORD PTR [rbp-0x8]
> 
> Not sure whether it was discussed before, but
> why cannot we adjust the bpf side instead?
> Technically struct passing between bpf progs was never
> officially supported. llvm generates something.
> Probably always passes by reference, but we can adjust
> that behavior without breaking any programs because
> we don't have bpf libraries. Programs are fully contained
> in one or few files. libbpf can do static linking, but
> without any actual libraries the chance of breaking
> backward compat is close to zero.

Agree. At this point, we don't need to worry about
compatibility between bpf program and bpf program libraries.

> Can we teach llvm to pass sizeof(struct) <= 16 in
> two bpf registers?

Yes, we can. I just hacked llvm and was able to
do that.

> Then we wouldn't need to have a discrepancy between
> kernel function prototype and bpf fentry prog proto.
> Both will have struct by value in the same spot.
> The trampoline generation will be simpler for x86 and
> its runtime faster too.

I tested x86 and arm64 both supports two registers
for a 16 byte struct.

> The other architectures that pass small structs by reference
> can do a bit more work in the trampoline: copy up to 16 byte
> and bpf prog side will see it as they were passed in 'registers'.
> wdyt?

I know systemz and Hexagon will pass by reference for any
struct size >= 8 bytes. Didn't complete check others.

But since x86 and arm64 supports direct value passing
with two registers, we should be okay. As you mentioned,
we could support systemz/hexagon style of struct passing
by copying the values to the stack.


But I have a problem how to define a user friendly
macro like BPF_PROG for user to use.

Let us say, we have a program like below:
SEC("fentry/bpf_testmod_test_struct_arg_1")
int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a, int 
b, int c) {
...
}

We have BPF_PROG macro definition here:

#define BPF_PROG(name, args...) 
     \
name(unsigned long long *ctx); 
     \
static __always_inline typeof(name(0)) 
     \
____##name(unsigned long long *ctx, ##args); 
     \
typeof(name(0)) name(unsigned long long *ctx) 
     \
{ 
     \
         _Pragma("GCC diagnostic push") 
      \
         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"") 
      \
         return ____##name(___bpf_ctx_cast(args)); 
      \
         _Pragma("GCC diagnostic pop") 
      \
} 
     \
static __always_inline typeof(name(0)) 
     \
____##name(unsigned long long *ctx, ##args)

Some we have static function definition

int ____test_struct_arg_1(unsigned long long *ctx, struct 
bpf_testmod_struct_arg_2 *a, int b, int c);

But the function call inside the function test_struct_arg_1()
is
   ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2]);

We have two problems here:
   ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
does not match the static function declaration.
This is not problem if everything is int/ptr type.
If one of argument is structure type, we will have
type conversion problem. Let us this can be resolved
somehow through some hack.

More importantly, because some structure may take two
registers,
    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
may not be correct. In my above example, if the
structure size is 16 bytes,
then the actual call should be
    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2], ctx[3])
So we need to provide how many extra registers are needed
beyond ##args in the macro. I have not tried how to
resolve this but this extra information in the macro
definite is not user friendly.

Not sure what is the best way to handle this issue (##args is not 
precise and needs addition registers for >8 struct arguments).
