Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9946925D9
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 19:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjBJS42 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 13:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjBJS41 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 13:56:27 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468378D45
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 10:56:26 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AIPpki025672;
        Fri, 10 Feb 2023 10:56:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=XxmJQ0+z0/TPWP96xnxnHTHAtwpd0X/+4vFqPy4Eqm0=;
 b=QDaggQlgLQFaHQ98N3DPzparzWiHlY9qyhcmaVAJet0FXfM4ZVvXyJ6maDCLCiCfWiF+
 zZ2y1xwtAHLn8IMJfwZmwPQSUuF3DtcOPBSugG0cCrnjzbLMgoMJlzGWA2FeW/5JLvCn
 x+1CwdOjoujCTDHGHMB2wttAk+NMbI2Ic2PXmRc6+srhHo8MGoH7JUnXl4JImP3Kkyf7
 7+It3ePcrxqVSRJKpq+wWv51dFH+xvSQS4xe6cMIHI7E2WHO6zlCZ9H0bUu0a8c8lrUF
 WhCBxNbGOtZIiCzicvBPtXQCMNQedOp//qQVhsfRm5ZVF52bLR3MxQOUG+k32guv+8EU qA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nnu5ug993-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 10:56:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRLG7atAtUeS3kF7Rr8Fy5I8MB41Erkxn1ghdJ0TDQUKP/kQQHJYOzqBfxXTcynMLw4KJrLKqdO2YfFZVHEF540/S7IDtBkI/C5WlRXENqJKyZi4Diagvm6q1gcOqcG7A/12y27z9KCqRDMMajmAOY04s4CbkEa5wdk4uGBlH50AKPVidIYzznRqQruegOFEPqxoTZf6/QO/YDOLnA2eVWecZHRtfrJWp8s4NCHdgrEtXU2ZQJnii/7qqmHBEKxhiFmjMM4H79phigQ4KUgLQUyAN9uHBCRmNwzNlkRyBV8vuoxwLBd/LZlapPB8fAXJPsEhn5kLFanfthx2wjhJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxmJQ0+z0/TPWP96xnxnHTHAtwpd0X/+4vFqPy4Eqm0=;
 b=oXRY642xQz33jWSsOIJINeeHJ1A4JEhLnDxZqG7Zk+cKSyngfyfyqtVBomkvN+NYnKLJXbj1WYcqAO0/cw5z7TErQD0UY3q1SEL9msokp6p/SzcHKZNf6Tcsev61ltvVkT4wgclDXjcW3jJcBqidYwWL7J0pNoYvdFCSDv5GUH8NbUC8Z8BGcuxx9opJnN4WfbWO+3nqLSDrdEZgEOEQ3e0BwAvOKizxeDKjJI7AIDN5clykiRZn6q2GLY8sJNR539HL2tJgldtKqbdpGICAjD8+cb9+6z5lLeDpC/IxQ6bHBHDpA0mrs0xeb/yuBW8Fln63AbIC56P03zBpsyb2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB5312.namprd15.prod.outlook.com (2603:10b6:303:16a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 18:56:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 18:56:07 +0000
Message-ID: <d4843193-212b-098d-ba7f-54521bf4414c@meta.com>
Date:   Fri, 10 Feb 2023 10:56:04 -0800
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
 <87fsbe8l8n.fsf@oracle.com> <87357e8f9m.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87357e8f9m.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:a03:40::45) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: dd676e28-4bef-49e0-66a8-08db0b9877a8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASpcZxbNCEXKyRk4G9JbJqjITZrAyN+DFnzgOBa6nYh33pZzSVfwjPrv9si4hL+7UATau67EvS+/NJGVoTPU6MGCmttYljiyGacW76uTxDVjFDju0S7BYBSqVzQEoQ31CeL5w6WNuPtyqkuSKUDCf85WbGnqVqhRvZ9UVDDj9ZQjwA4JDlqSxeuj+R6vVe76J6GfBQcdAMVXq+P8Dr+a1BppEsNrksQykSFV875bA9S2OzxQ9eY+4cvdSySS0ifUfZNBFD9wZF9TYTbhm5/7IU+E5TAEKfAJyNdIBmf8zyIgc4kEiypA286CxfQ98q1eUVZfxoNFh35JBnWSa8srKFBYhjJJkWLhEmgGHqulqt2rzz13lNHNrsEwle+tiyFdMxd2bEe82TdAC8yzoeJS+EPkf+OowuC6C6Hi3zcrnHgz81PLfmeUDIZuZTJOXdlFuOFI4SL34F605Wcwm61rqqLYPHElWfwLx+cDt5uChsoM+KAzrVmOgImm9kzJ2jJrBNXaKLJMKs6VvwrosFdWWy9CwsBrEO+1sHeuyC2U+Zzjt5T3AyENNNlcXHpTwl356g+OqkpGSW1H3iRrgJGZiTnvAb9/8ivo385j2+174vxCiE36WG60NvMDK5KywpAk4iXE+BKRwUlucqoXBVRPuTG3HaQ+gf0CPSOcvFwA5h4T10naO18gdxxh7q5BMC4yuRtat5CtsxEmwhyjRNVkGgn2O7SqxEFIGxnKf8AXqUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199018)(31686004)(31696002)(86362001)(36756003)(38100700002)(6512007)(2616005)(83380400001)(186003)(6506007)(6666004)(478600001)(53546011)(6486002)(316002)(8936002)(41300700001)(66476007)(54906003)(5660300002)(2906002)(4326008)(66946007)(8676002)(6916009)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG9PZUhaMVhVR09aQnllWjNCNGhXbnBidytkSm5iMy9Fc1VLN1VxOEhCZEZ2?=
 =?utf-8?B?SzR2TmpiR3RqNW4yOFV0bGtyaFpiQy8wRGcvMnI0cWU1L1NoeUVGTXdaMUN3?=
 =?utf-8?B?VmFQZjQ0WmUvUmVoOStsZmZYbkhJSjZTWkNxSm1yblZrblBtbjRwbW1tYXJw?=
 =?utf-8?B?c1hQRGRNZUdhNi9nS21IUEgwTjUvNDU0NFZhVURxbkl3UGwrZW9DSENlSity?=
 =?utf-8?B?ZFo4MEI0QVRoWFRqb1VIOE9uS2FFcUVnTDJiUlhvbkYrZzg1T3dCeURRZnJi?=
 =?utf-8?B?WTZwL3BRemdaZVlNVHZnS3pQTHh3MExRaE1idEhSZXROWHAzd2h5bXVkQUV4?=
 =?utf-8?B?a3NTMUdiMGxmcnNwOWEzQXpuZFdPczNvZVRCQWt6YUVacFRqWU5qS3NWbUw3?=
 =?utf-8?B?cmxFSjR3U21hSlBheDFrQjVmeUFuTndoR0Y3SjBTRWZmSWQ0OVJSR2h5dFM3?=
 =?utf-8?B?eFVvWmtiQUpQekxCcTh3cTU4ZmpaNnFKV00wS3Y4bDRHR2o4OVA4aVJUVGRh?=
 =?utf-8?B?eFBpcVV3YlU4ejhXN1NGK0dYQWg2aDhhVHF5dERrMEYzeWNFbllNNkxuQzlq?=
 =?utf-8?B?bVM3T0tkNUQ3bXFEc2tZTXB3YW90d3JRK1ZzNEFIdnhtNjJreXZZZXRJWXJ5?=
 =?utf-8?B?bk5BWWNIOTVZN1c4U0EwSW80OVg5Y2FJdU9hYkZnTHJJV2ZXWllSOU1qcUlj?=
 =?utf-8?B?emozWlpLcU5yU3pZdXdFcEtPYm82bGRXaVZKOEZ5eUs5REthUURuT1QwL3Y2?=
 =?utf-8?B?RXNjY1BXNVJGWXlzUWhwblRva1Z3bjhSczBHZDJwc1dzVFdSVGxEbXdmd2RN?=
 =?utf-8?B?dVpYTDBPQkh4ZU91TTU4VitEcGRlaWFxVEw2Y0hXSVozRlFERVZnaWhpS0s5?=
 =?utf-8?B?WkFtWGxRUFVnbkRQaEIxV3ZrbG5jY3YzajNPNm41R1FUQUQ2R3BYTE1hRmMy?=
 =?utf-8?B?Z3FJWk5DVXVIdk91U3g1L3JpaDc3dXNhbWNJVnJXVzJKWDFpOWZQTTRWbWln?=
 =?utf-8?B?ZCtzK1dEQkRxVGt6eDJla0puWkpXaXd3SE5kSU5YUHVnNzBYbEovRTlZVXRO?=
 =?utf-8?B?ZE1UMENFSTlkWHRMQVp0WHRYU2JMYnM0dWRqZGtSWGJXUVJNS0laTFUwR2V2?=
 =?utf-8?B?eDNENTRyckF5TTJUTjFielQ2Snlic3FPaHJGMGcwbGlSU3I4dkpWNEpmNVVY?=
 =?utf-8?B?b3ZFUi9iNVRSSzUxVis5L2dyR0VEV00zRkpXeVZ3bFVhdkgyalJtdFZON1lP?=
 =?utf-8?B?S1IyRVdKZm5NTk9jY0JhdFNFSS9paThZSHF2UW5rNllWNXdkK3lmb1grQkJ6?=
 =?utf-8?B?eFNoU0F3MjQ1WGNmWTRIUjNTeGhoaGVNaG81dVlaaTMzMXdBd0o1dTRubURu?=
 =?utf-8?B?SWxmWU9LQ1o2WGJ4K1VpTGxDL3VIeWEzUjBEdHlMSHA4SWNINk1HOGpWZmZR?=
 =?utf-8?B?bVo3R1pSVDJ3UkpkdWVuVzJseVBoS0dRZnY2MmxWOGZBRml3bnlNb0ZnZjE4?=
 =?utf-8?B?cVNWeWIzNlEzaWNMeUVlWlZZVHRTeGR2OU1qVTJrUWFtaFFneVVHb0xudEZF?=
 =?utf-8?B?NS9KSmJ0dlBMWDNmak94TG4rdDk5NTdBQlE2STViakpRWC9Wdk41QUdpRkFx?=
 =?utf-8?B?QjFWN1JjQjFNbmhhWTA3NVl1bVpqYm81dS9qd1FDcjFEOURZQlpLZUJucmJH?=
 =?utf-8?B?R3hGV0VSbDlwUmdpSy82dldWdkZLdVJZcWYxek5wTTFkZEo5MVA5TGg2dkJ3?=
 =?utf-8?B?ei9WM0dXbWxRVHphejNBYVdSQnBPZ1dHYUhmV1lsa3BadDBBMFNPZUZNVGVr?=
 =?utf-8?B?RDVMNFBydHNFNG9nclUybjZhOEhQYWhGZUIyV2QwVk12TkVyNTNCdjdLVSt6?=
 =?utf-8?B?cElNT25NMk00SnNiekJ6eFVMeWNxQjZxTjM5RmlpYkZvUE5ZUEZpOE5WVG1R?=
 =?utf-8?B?Sm5Cb1YyRGpzOTRkTTR4aVdOQnhUWktob0dZSG03c2hBK2c1UzNNa2dDTERQ?=
 =?utf-8?B?WXpLQk9zNnNkcHdPeDN4T3pIVlFDSnMrYk9WM0NDV3VmaWN5RU8xQkE3aEFh?=
 =?utf-8?B?OFlIeXRXV1hBWGxEVW9JOTJFZmFUMml4NG5uSVdlTkFIeXl6U0VSMkxoNjJZ?=
 =?utf-8?B?WmJ2cFJVd0FSWURKV1VZWlExZmZ3a1lXcnZ2SWtLTXVPOHdWWDg3aTJYQzFS?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd676e28-4bef-49e0-66a8-08db0b9877a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 18:56:07.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NdzhwKmP/qYSrYNB3jyZVfFQSC+373U4pDBaeczFezYPeedvx0xzRZabaSw86py
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5312
X-Proofpoint-ORIG-GUID: f0Xpx01DqmR2KtTqoOTw563bo_5W5vVi
X-Proofpoint-GUID: f0Xpx01DqmR2KtTqoOTw563bo_5W5vVi
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



On 2/9/23 5:45 PM, Jose E. Marchesi wrote:
> 
>> Hi Yonghong.
>> Thanks for the proposal!
>>
>>> SDIV/SMOD (signed div and mod)
>>> ==============================
>>>
>>> bpf already has unsigned DIV and MOD. They are encoded as
>>>
>>>    insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>>>    off(16 bits)
>>>    DIV     0x3              0/1               BPF_ALU/BPF_ALU64          0
>>>    MOD     0x9              0/1               BPF_ALU/BPF_ALU64          0
>>>
>>> The current 'code' field only has two value left, 0xe and 0xf.
>>> gcc used these two values (0xe and 0xf) for SDIV and SMOD.
>>> But using these two values takes up all 'code' space and makes
>>> future extension hard.
>>>
>>> Here, I propose to encode SDIV/SMOD like below:
>>>
>>>    insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>>>    off(16 bits)
>>>    DIV     0x3              0/1               BPF_ALU/BPF_ALU64          1
>>>    MOD     0x9              0/1               BPF_ALU/BPF_ALU64          1
>>>
>>> Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
>>> to indicate signed div/mod.
>>
>> I have a general concern about using instruction operands to encode
>> opcodes (in this case, 'off').
>>
>> At the moment we have two BPF instruction formats:
>>
>>   - The 64-bit instructions:
>>
>>      code:8 regs:8 offset:16 imm:32
>>
>>   - The 128-bit instructions:
>>
>>      code:8 regs:8 offset:16 imm:32 unused:32 imm:32
>>
>> Of these, `code', `regs' and `unused' are what is commonly known as
>> instruction fields.  These are typically used for register numbers,
>> flags, and opcodes.
>>
>> On the other hand, offset, imm32 and imm:32:::imm:32 are instruction
>> operands (the later is non-contiguous and conforms the 64-bit operand in
>> the 128-bit instruction).
>>
>> The main difference between these is that the bytes conforming
>> instruction operands are themselves impacted by endianness, on top on
>> the endianness effect on the whole instruction.  (The weird endian-flip
>> in the two nibbles of `regs' is unfortunate, but I guess there is
>> nothing we can do about it at this point and I count them as
>> non-operands.)
>>
>> If you use an instruction operand (such as `offset') in order to act as
>> an opcode, you incur in two inconveniences:
>>
>> 1) In effect you have "moving" opcodes that depend on the endianness.
>>     The opcode for signed-operation will be 0x1 in big-endian BPF, but
>>     0x8000 in little-endian bpf.
>>
>> 2) You lose the ability of easily adding more complementary opcodes in
>>     these 16 bits in the future, in case you ever need them.
>>
>> As far as I have seen in other architectures, the usual way of doing
>> this is to add an additional instruction format, in this case for the
>> class of arithmetic instructions, where the bits dedicated to the unused
>> operand (offset) becomes a new opcodes field:
>>
>>    - 32-bit arithmetic instructions:
>>
>>      code:8 regs:8 code2:16 imm:32
>>
>> Where code2 is now an additional field (not an operand) that provides
>> extra additional opcode space for this particular class of instructions.
>> This can be divided in a 1-bit field to signify "signed" and the rest
>> reserved for future use:
>>
>>     opcode2 ::= unused(15) signed(1)
> 
> Actually this would be just for DIV/MOD instructions, so the new format
> should only apply to them.  The new format would be something like:
> 
>    - 64-bit ALU/ALU64 div/mod instructions (code=3,9):
> 
>      code:8 regs:8 unused:15 signed:1 imm:32
> 
> And for the rest of the ALU and ALU64 instructions
> (code=0,1,2,4,5,6,7,8,a,b,c,d):
> 
>    - 64-bit ALU/ALU64 instructions:
> 
>      code:8 regs:8 unused:16 imm:32

That is correct. My design can be interpreted this way.
