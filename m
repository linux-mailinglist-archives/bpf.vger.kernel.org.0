Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A486469257A
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 19:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjBJSi3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 13:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjBJSiY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 13:38:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859ED79B07
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 10:38:16 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AIQrTJ008149;
        Fri, 10 Feb 2023 10:37:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=92Tf/H4f2oSM3qwpipTCKJTrV1fyMz2MDtunCM7Duw0=;
 b=FPtoRoGGmhLxIN/Ay0Ewt5HXiTLX0fnMGUbHipJGBrl5T54hw2kHVZYtn2RLeV88pxn9
 2sctqZfD/UahGKpUdbWdanK01LIbPyTTeUKZV53QU8WYKuHqNJ2+YA+TbsMm1eUdafSn
 PP3apjVC/V6VJOzWcBkXoHON3nvU8mvoJTUJtXeL1xUBQRC29ObmCZIhYO/qjElXRHG5
 D41dElDKJLOGXCeQt4oSAXbGNCOnq652bRzBKFIUNtQJgI1ao50LqIOf7ss50nuvDRBt
 YkpUsTXXuKS8Li7b2jk4m2QIr+6SPWFGivDZqFaKoV7atmRdYseyaP+X/eqjMLJsye9e IQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nnu5eg3nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 10:37:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kShrVutoD3BrOw1L+LIX4VsoW0oqPh3zwJdNa0AuZ2x4V/yPGoNuVXyyohVy7H0S3GZKzPs9ufW0MQYqCncR8EluvtpAOh/6e97Xp/R3inGqkioE/IIjUyl8SjQsD7+qonsvelbL1LSw53z600hObMMXkLCXtQcSS01YTfBuGLTPQDa4zyYtTAOU1Kg7QnaKk1Tk0fLoTNai42y8ArBTNOiZ1+m0+///pJwuIUfztQ/Wzps9ubzFVpA5q/daHJ81NO8dYF2lHClgtPWnJNeDqwhplEBy8PMx5Xn/mgltcYYQiD4cp8lrVV5AFEa17BYqodbDfTL52IakxQ709CYOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92Tf/H4f2oSM3qwpipTCKJTrV1fyMz2MDtunCM7Duw0=;
 b=Cg6To8U/8DE/7/ncVT2vizF9lUu9UH1O8K3MxcNYJwM7WCVX1Z5sQ8cyUxqDsI1w6CFhw0+8cR1KiiWQFQM1VU885xc7m4z367OtTJCXVu4DY/PMXPhtgYaKnBFGHvD6i9hvw9Wkelc7TXRIn/8EeukWk7NHECzb+JLM/VV7tnVzMcD8WO42+Zm3ppbovY6FB4LuGy/TMT8r8SC09EXgdRfyH+Mz2F2e7NRxLMgRSNhBpF46Jw9VdyrpADWKhNyqerSjUUokZlV1PE2UBLH9hMWQK8o41Fgqg1pT9lnMIf3l+Bktw8qO7zAR6QTnPRP0GMMfsKF1HQqe2AoFNr691Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB6009.namprd15.prod.outlook.com (2603:10b6:8:17f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 18:37:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 18:37:52 +0000
Message-ID: <9c14efb2-5fdc-66b8-8b0a-1335674554ce@meta.com>
Date:   Fri, 10 Feb 2023 10:37:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: bpf: Propose some new instructions for -mcpu=v4
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
References: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
 <87fsbe8l8n.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87fsbe8l8n.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 16cfdf93-973b-48f1-0891-08db0b95ead3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUoqeAAKMurZfRrXrGPCwKKmlUCq7eQBuc9O0EhVOLKPMSCUxitHiptoJVKtOz8YVLXCLDNkhsqSoB2FqbQz0m4/ly4le7jtGRGEhoLoOXqHKykOir5wKmD53u3ay7WHbOCfiI6AWK/4UAbjtNxzHPoYoRo2l8g3yv+oQEWl5tqhIQjbv2nvPXASR04E5FNovi+8KjXCruk4wAxx8O0LIS0Ofk/mqlEboycKFhTb8OPutbxzUebuJaZEdu+kM6G57/hO/hBJEj6C+xLaGkrSfVvdj3Mys6adPMAdLtcXzTUZ2qgpCKHnz6675Rf4SNdf1MF+q6UXoEI0aH03MB/etm72V7N3AoCBxn18VBbJU6N8gX/gDNAoZN99Y8o9bhxqXKsZ5nGjfwwrGl2AgHEdM3z+ksgVlsqzL7NMPMsJdSR1eaDhUy6fp5oO8AaI6vOVNwWvD+4eAHH4Ii/gY+GHFOR+pMrKiEiKG76vQfpO6IW/Qg2RM86ACdE2L+hrfrqMhGRLXA6VWKtIDM713sgNvwerRKXZBpGPHkSwKS8OLQaFgz/5Y8uOVqeEgbSDXtxSCERx8yldI60r/cV1aM3SnsRzdUXJl22OvlAqJ0lHis/GIymE4DtQlbJlF/4/J8I5DHQrZ0w9FyAOXw+dZT0qlFpXJ3NuevI/p4HIVCEJisW4WFqgkfr2RTIMWSu29PZGUa7RDrO/aGk/JCaxnt2cyy69YhsKfepMoMYWWrEBqfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199018)(6666004)(6506007)(478600001)(186003)(53546011)(6486002)(36756003)(6512007)(54906003)(316002)(86362001)(38100700002)(31696002)(2906002)(2616005)(83380400001)(66946007)(31686004)(8936002)(5660300002)(66556008)(41300700001)(4326008)(66476007)(6916009)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkNvaDFtUXVzS1VuVXFxVlE5NXpETm5QR3pmaVlnNUFiSzhFajZqQW82bDg1?=
 =?utf-8?B?N1B2WllLRnlVdVYrTzZJWnY3TDIwWXhEV0ZQT1Qxd0dSQlBpeFNuQ0VCSjJp?=
 =?utf-8?B?TmtGcjZYdGptNGcxM1J3UHFkR0ordlEwdjk1TWk1RWFnZ2ZGaVU2eWE4NENv?=
 =?utf-8?B?SFI4K1RvRjlnNmRkRzdVUHM5QWtsMkdFZjNiTlBZV2FxZER5WVVrVFUwT2pI?=
 =?utf-8?B?NkVxcEJZVHFaYUJZcmlpakQvZXp6bHhtcGlhSm45MW5hNEdoRSsyb1Y2UGtD?=
 =?utf-8?B?S1dvd1VWa29qOFRjZGluZFE3YVBRc28zRGNWZnJPTjREeTNITzV5VHpXQzJO?=
 =?utf-8?B?ckhQWGJ5cXVHQlVRV25LTWdhd01ZZWpkQ1ppaElQNzBjcVk5OWU5VUwwZlFj?=
 =?utf-8?B?dTRKU2ttV0ROL3RxeXJ0UDhtcVJ6SzNlVnlxTmdOWmZkWmlGTVlRZzJHcjlu?=
 =?utf-8?B?MG4xeERUaEtzMjdna2R4ZmlmQW82VzdDOGVjRmpUVnBnaTZpbjJSYW1ac29m?=
 =?utf-8?B?b25mT2cwL1RFeVQ1eW1RT3Z6SGtyZjZENG5VMENzRC9iSHgyRm5DRGprTjJn?=
 =?utf-8?B?VE1RYTd0b01wYnR1aGdyVEswRGNUUjBmTlh6K0VzcHJBaTlmY0pVTkpVNnF3?=
 =?utf-8?B?ZGx4THFjM2dSRHNIc01ESjNkN3VVbG53Z3F6dElkcUxvcVdUTjQzaUxIYlps?=
 =?utf-8?B?V1hFRCtWZFExcjE5Wi91ZHlZNFhZclhqMkpXc2VTTU12eXBTZEMrRVdLdnJ0?=
 =?utf-8?B?ZEt4L1M3Y2Ivd0xmVEgrd2loR1JXcEtNKzVXdXJmOTd5MHNPdXI3S0FWUnc3?=
 =?utf-8?B?UkR1WlNjREdQVWNPa3dMa3VDcU1JUXdSVXg5SE1XdkJidDNaRnVvVnkyZEpB?=
 =?utf-8?B?aGEwb1NTQnhyRWxScUt4WEpOek5jRlp3R2xWM2xvZGp3ODdyWGJvRjZyZHlD?=
 =?utf-8?B?RHdRN2VlL2tuZWFidGluUnRFdnBjTWhCSW95UTAwbmE0WnVPcmxpblZEZ21L?=
 =?utf-8?B?b3NvR1dhc00zY0VibTdrTjVrRk94L0YwcVZrOFpxbEhZZVJ2RFdXNWI0RXll?=
 =?utf-8?B?aWUwUEcwb0NaY2lVWWRzTWpycTFXQjFOOUhJVFFocktoNUZaUUNhYzVUWEMw?=
 =?utf-8?B?YUMydmczazdYS3gvSUdWdDN3SnhsbmovcVBURTBFcVd1UmVybzhyMjYzWmhu?=
 =?utf-8?B?WGpjQ3M2eTF3OVJ2YmQrOEtZdmMvSnJadldQSTFaNlczaG5oOTJpNnNtK3VW?=
 =?utf-8?B?VzlMa0ordndwUUNxVjZBS3JxUktQalJFVStSWFJ5YlNtQjlMajJrMDhJNUIv?=
 =?utf-8?B?RisvVi9VbEU4NzFBbExTSnNCZjJpSFRYSCtYdjRBdjYzM2ZOWDIyUVlrQzVZ?=
 =?utf-8?B?aGlCNXdreTRESTEwTmtEMkszazVMSUFicnBBY054RmlBK0Z1cDRIWWliV2xh?=
 =?utf-8?B?Z0FLZFZGcmxaL0hza0ViM3VORlZja21reTBHRTJLR3RrRHdjbGVUZVFhRkZj?=
 =?utf-8?B?MTE2N3J0RmtPakhGWllVVDNKNHBaQW5YNStpang3d2VsSC9DeG8yREZTbXQr?=
 =?utf-8?B?SEJXWTNGMDZjS0hKOUZCSWk5MTZWWUZ6ekI4bmNLOU1pTXpsWTlRcEVtWjBo?=
 =?utf-8?B?OFRLUGxud2tHa1dHdkM4ZjVTMFRqNU4wZnpURmhvbWVKMUpwcDRaRmlZTHlj?=
 =?utf-8?B?SEM1ai9FL2hTQStNT2w1dlo0MkNDdWJ4VzN6amtVV2xVYUV0ZDljRmFTUis2?=
 =?utf-8?B?RTVabFZoUXJpaEpXbjRWUVNXT094K2VXZ2lXOWlTZWtzaGFjSWpCaEo2WS9a?=
 =?utf-8?B?Z2w5RnNtLzNFRm5wWTZHYlN2TXJiNVJaZDAxU25WamswZXhIQkgwL1FFcTVu?=
 =?utf-8?B?YzFtMWFYZy9mOTRLT05URExUb1hyVy9jd01oZFVtbjUzTktCU1RTYi9oQkd4?=
 =?utf-8?B?S3UrR1B0V1dpeTlDZ2JvU3VnWGk4eE15U0FRcUxIYnhadi9PTExMMUt5VVp3?=
 =?utf-8?B?MWxjMkZDd2RWWUNMNktBZ2FKVjFpR0tKR3ZaKzBLNTc4akRIcFNVcVRqeEVR?=
 =?utf-8?B?TWx1a0FQSEM1ZFJYVkhtNFcwR0FETUsrNmdDU2NQbWlZaE93N1g4akVTUWk1?=
 =?utf-8?B?bkNjbmloVTI4bDgzWC9DbitPSGV3b3JDRG85cFZXR0U4RGNUWDNTcGxCajNU?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cfdf93-973b-48f1-0891-08db0b95ead3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 18:37:52.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+dwEIEmEBd3tvCBaV7GTYFhPG7Yct40/XwKtK41q4cmZufJjHr28haCZ3f15H+m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6009
X-Proofpoint-ORIG-GUID: Gf8RsHaTz2yvhTm5BAyrE04wXia9HChM
X-Proofpoint-GUID: Gf8RsHaTz2yvhTm5BAyrE04wXia9HChM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/9/23 3:36 PM, Jose E. Marchesi wrote:
> 
> Hi Yonghong.
> Thanks for the proposal!
> 
>> SDIV/SMOD (signed div and mod)
>> ==============================
>>
>> bpf already has unsigned DIV and MOD. They are encoded as
>>
>>    insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>>    off(16 bits)
>>    DIV     0x3              0/1               BPF_ALU/BPF_ALU64          0
>>    MOD     0x9              0/1               BPF_ALU/BPF_ALU64          0
>>
>> The current 'code' field only has two value left, 0xe and 0xf.
>> gcc used these two values (0xe and 0xf) for SDIV and SMOD.
>> But using these two values takes up all 'code' space and makes
>> future extension hard.
>>
>> Here, I propose to encode SDIV/SMOD like below:
>>
>>    insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>>    off(16 bits)
>>    DIV     0x3              0/1               BPF_ALU/BPF_ALU64          1
>>    MOD     0x9              0/1               BPF_ALU/BPF_ALU64          1
>>
>> Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
>> to indicate signed div/mod.
> 
> I have a general concern about using instruction operands to encode
> opcodes (in this case, 'off').
> 
> At the moment we have two BPF instruction formats:
> 
>   - The 64-bit instructions:
> 
>      code:8 regs:8 offset:16 imm:32
> 
>   - The 128-bit instructions:
> 
>      code:8 regs:8 offset:16 imm:32 unused:32 imm:32
> 
> Of these, `code', `regs' and `unused' are what is commonly known as
> instruction fields.  These are typically used for register numbers,
> flags, and opcodes.
> 
> On the other hand, offset, imm32 and imm:32:::imm:32 are instruction
> operands (the later is non-contiguous and conforms the 64-bit operand in
> the 128-bit instruction).
> 
> The main difference between these is that the bytes conforming
> instruction operands are themselves impacted by endianness, on top on
> the endianness effect on the whole instruction.  (The weird endian-flip
> in the two nibbles of `regs' is unfortunate, but I guess there is
> nothing we can do about it at this point and I count them as
> non-operands.)
> 
> If you use an instruction operand (such as `offset') in order to act as
> an opcode, you incur in two inconveniences:
> 
> 1) In effect you have "moving" opcodes that depend on the endianness.
>     The opcode for signed-operation will be 0x1 in big-endian BPF, but
>     0x8000 in little-endian bpf.
> 
> 2) You lose the ability of easily adding more complementary opcodes in
>     these 16 bits in the future, in case you ever need them.
> 
> As far as I have seen in other architectures, the usual way of doing
> this is to add an additional instruction format, in this case for the
> class of arithmetic instructions, where the bits dedicated to the unused
> operand (offset) becomes a new opcodes field:
> 
>    - 32-bit arithmetic instructions:
> 
>      code:8 regs:8 code2:16 imm:32
> 
> Where code2 is now an additional field (not an operand) that provides
> extra additional opcode space for this particular class of instructions.
> This can be divided in a 1-bit field to signify "signed" and the rest
> reserved for future use:
> 
>     opcode2 ::= unused(15) signed(1)
> 
> Thoughts?

If I understand correctly, you proposed something like

insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
EXT     0xe              0/1               BPF_ALU/BPF_ALU64

The insn BPF_EXT means the actual 'code' is in 'off' (16 bits), right?
I think this could work.

But we already have precedence to use off/imm fields for insn encoding,
e.g., newer atomic insns like XCHG using imm for the 'code' and we use
the BPF_ATOMIC to indicate a 'class' of atomic operations.
In this specific case, we use MOD/DIV as the 'code' which implies
a class of mod/div variants and the 'off' is the way to differentiate.

There are pro's and con's for each approach for the above EXT vs.
my proposal. But maybe we could reserve EXT for future use?
