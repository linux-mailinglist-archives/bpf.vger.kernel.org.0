Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370EC6913C5
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 23:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjBIWzS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 17:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBIWzQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 17:55:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A05B754
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 14:55:14 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319Hr5IU030853;
        Thu, 9 Feb 2023 14:54:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date : to
 : from : subject : cc : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=oi5NVIMFb7dI17EUpZbpp+mB1vnHVONuer7K2VOmy7M=;
 b=OlosLGMN7zMHU3hjuv5purAnnqAieuVkDQspXM85v6P7qQA2MU5wp1oTC6J7Ipc/Y8hu
 e3UoWepzITy3arNaA18ebjIPBMhCbm6Ab8TC0KnXy8t36CV+f5ygvtej4gU5USQN+10V
 0hH0rJYIK6CIrr34iv0JWBSToA7IodKrWkQZSwX04eEC3Ih/84YTJvUb42qgQAS5bvVJ
 O4Vsl6uNu1e+oHfPhsc4p0z2Jx/k9dGUDEPDIeoq4bzEhzht/CZqZ+yT17j2JI9CMwKs
 hSjys4uCg0M+snf1f0DXoHEZ8lgQfqp6zjQBImr3cCzyrqS2T5ichylliXDwg3YPLEKH cg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nmce24e4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 14:54:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHVnrzMT9ui1uKSzP516rztq385EihEAzAn2LOgCfscwQcuzMA1jdk6R00hGWoRu18fFtp31yNbiCeD+cuw5+F20ekTa5LnRorxf0bnEzne3H3q1iAOEh8Oulhss9R3t9apT0IGz6kAxx8hu0WZdkI/YeVgEF9n0QXz8ZAE2Z3WuVYcdTyghjTad0BNfUGojZrvltRoG3ofpNilhs+oaiQ4XbljxTsK5j+mfHAj7++yFgi3jUkBH5IXVzmdK69jyh9WkqoIFUKRaG1SutQ0hkBtYNdT93Mv+dq29Wga5hSIEyZk5dPySErIruzwxcCTaYks+viDYwHx45/gM9cGu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi5NVIMFb7dI17EUpZbpp+mB1vnHVONuer7K2VOmy7M=;
 b=BaOUUE2y+qbOjnNqmlKWKH9RpO94fNcuEJX7Ct+sA4dK+oDn5ffR5Ld5mnAerPWWGjMeVQZS7RaKwdqgiPmiTPJ0iSy+gIKM7i5+tGcpt4CWQnwCvCO/SIOD+OYd7VsboRpkTySHmvs64UMKUEqQz5l3sVMk0t9CKxONUY/Lv3ZzH9RM8zDeORZwepQXsuFXA8GWqyeYLk7mz1gCVxgSrZ60FRL5GZBnFdNbtJw0K6TEV75lJwqn1lMFhMtjbtoKNtKjVEfL4iAxYjPQEQbQ8tvfHb8PB1Uj5+fM45riu4x4XgDBKGRC87H8datha85yV5BcBUOyi1WqDIO2Tv30KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN6PR15MB6241.namprd15.prod.outlook.com (2603:10b6:208:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 22:54:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 22:54:55 +0000
Message-ID: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
Date:   Thu, 9 Feb 2023 14:54:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
From:   Yonghong Song <yhs@meta.com>
Subject: bpf: Propose some new instructions for -mcpu=v4
Cc:     "yhs@meta.com" <yhs@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:74::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN6PR15MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a8433b-5111-47aa-d73e-08db0af0a95f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDMF2ecEZQ8pUIHlCBUAq5qUMnal36pIHT5zPkm6XRB0dPKqdacttkWgiSo+Nnez2XqTGldLIIJH1JRl9BhFE7Ol19lQbT13QVdg4HQBoJMynntqM920G+252P6eiG2H2Q79acsDf287e31H5+q9lRwQ5+Zn8meHrzqz9gHjwqn83kx7sJAce2Fhgc826AW8W/mDAjTRQ1mlVCHqOwh1UNWAsKrBz0g5N+gSKT/wqF5jxDv/W4sAFlrXc1sihj7Fb5NPcPx/UniZ6KS+0YP7jPiMWuJ8WBOLVC5NTWERzNJom7dbEGKOCFcJ7gpqY6Hs69EdDavyMFHnvEpQjhC6euOudiFgR+sFwZrCaXftT8AX3IoXBWfgJKCrml8d3wbarjPSBnZL9hc3AMq/IR0J8YYGNlg2Un8AOiofTUiwwR4b+TCsF+evCEVrXTJ9rvVITRS1JdOkGXanYkHwj9BQhnztwlirXFehmnmF6iS9HkS/u1q0+8dYOSWa44Ju56cwKDdGMyYFqojuTRYs5G3qdFzso383JdKFxBpn8tFq7Bl/4l/S7+++M0b1TnLgERMVemqz6K2QD9mj8ZCOOVw9/LzjYst5ET4cbdC3ec0i28pLmkCkBboq0tp77vY/yO6WvFqMk+n+KZ4GOGagrtxsss+1RKILET1Nu3hqPrrGsvWQLhf5ujZPNO4bHB9mfhnPFaqt+rzp1PrJncbULP8YA+o9HsuUw+m5ddkXb5QOyzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199018)(66899018)(31686004)(2616005)(478600001)(2906002)(316002)(110136005)(6486002)(38100700002)(36756003)(66556008)(41300700001)(4326008)(8936002)(8676002)(6506007)(5660300002)(86362001)(31696002)(6512007)(107886003)(186003)(6666004)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUNvamFMZFhFY25wUVZBQ3d4enJtY0sxV3Z2RzZ1S3c5ZXU3cGFCSHZkUmtu?=
 =?utf-8?B?N0UrcS9QZERXY2FQaDNhK2dGL0xDZlhxdmxtN2dkb0Vock53amRaQzd6Nmsy?=
 =?utf-8?B?cGtkOHp1VTZ0Uml1aThtQW4xS1N4VzQ4RDNZZDBVeDd1V01qNm1RczFXdWNT?=
 =?utf-8?B?b21MdDBPRmtYa09VSG1yZkx2US9oRzA5cmI4anlrMWRkbkREOE15dUl2L0Mz?=
 =?utf-8?B?YVVpWTgvaDhnMTlpY2M0TWRXYXZSTDVoRnV4eWUyeVRsbkI1TXBnSTBIeTJK?=
 =?utf-8?B?QUpTQU1YcFBpNkpXRzRZTWNwL0lvNEViUGplMVE3TS85S0Iwckd0N1pURUho?=
 =?utf-8?B?bS9YRjFiZ3U3eWw5TEcyb0d1U1JuaXlrRko2UjZ4UkxXOVlwbTVqRklyMzVR?=
 =?utf-8?B?MWczdUIvWDZ4bFJLVHFRQmZoWmE5VGxhRVQ4VDRWdUt4MGFMTlBoMTVScWtk?=
 =?utf-8?B?T081QmtHOGw2ekdGd2ZrbXhlS3dRVXdsVDFyMU1GSjMraE5rbGNBZU0zekhB?=
 =?utf-8?B?S0ZHbzhOUzQvTzZhYmdwNUhNRnQ5STdkdVVBdVZrSW5RUXlXNVAyQnJvdUU5?=
 =?utf-8?B?RytZRm9OenZ0UURQNjVVTDhCbzFFSGpNSHlLQmg4M29tK0V4ZEt6OXJCOCtv?=
 =?utf-8?B?NytJMFhxeml6NlY1b242REtrc3FJRHZLaGZjV1NTTkxlbXZndFR2MFh1TzVk?=
 =?utf-8?B?TW1LVklRV0w5TUZDWmxjcUIrcSt0ZGRnMUo4TE9vMldUa0ZxRVFWanpXcFR3?=
 =?utf-8?B?Q0VxOERHTXpWMXgwOVY3U0VBU0F3NmNzV29XQ1RCMnJ0MTZnMW1wVTNTNGFS?=
 =?utf-8?B?Vk9Lc1JoY3pZWW16MkpaMndUVVVrcU9WT3dadjQ3VDcyeGdCVkxDTi9kZ3FJ?=
 =?utf-8?B?VW1Tc3V1aC8yejR6eGV0S0VyUnp4QXV5K1lhQ0FLZ2oxSE9hSE1ZTTZBRjhX?=
 =?utf-8?B?VWM1cFJPSWhtbjY0T1Z5OU41ZFM1V05KVm10KzJPaHZCVjA4VnhZTUliZmZT?=
 =?utf-8?B?TlZIbnV2WkZEeTRCajc4aDVBTXlRL2UzQTNreGhxNXh1SitZZUJZaEgvdmZG?=
 =?utf-8?B?UTU5UmozK3NkSVNNSDcyNkl6b1lKWXRabWpVSVZIaWZneklRbXRoT2RXMWVl?=
 =?utf-8?B?NnFrQ1hRMDRJWEExbXZCZnNwUnNBVEdNeGtxVFR2SFNkVThqeHM0UkF1d2Jy?=
 =?utf-8?B?dU81ck1ORW5iMWNYU0dOVkZlM1BCYkdoNmkwWDJuQ1ZGR2JJR0JTZjVnTGFK?=
 =?utf-8?B?Ynd0QTduWTFydFdTcnBPeEdKcXovTC84cXluQjNCL010UUdhbGRlZzB1Nkcz?=
 =?utf-8?B?ZldReXdzVi8vczE1aERIbTYzU2JvaGtWYUpQQk1DdUluWmtvRFF0T3VtSEFB?=
 =?utf-8?B?amtTaUtMV216NHlVZENmTFVyblgzbk4rUmZqVmJLTlBseWlkUHljWXFhRFR2?=
 =?utf-8?B?enUrTkEzOTg1TlBPZ0hYT01LMlFIQVZoWlpOb3lvYmtZZFlFNXltTjBMMjcy?=
 =?utf-8?B?RDY5V2ZKZ1JwMVIxQU1zRU5ZUlBGbVNMU21DbHNJeEVtZ3lBZkVndktjUTJh?=
 =?utf-8?B?MUxSZU1hSGo1aEcvMDhraHNWV200K0FQWDJ4RENyUFNBMlhIcGYrd2ZiNTlu?=
 =?utf-8?B?UWFGVU1MR2VtbnUyZm54R2dJOWNSRUZGUG9ZSFcrK2dBTGpDY21CTU9xU1A4?=
 =?utf-8?B?ZUxycm5kbVV3V1N1ZWt4MklZVDFrKzdXeTYzVyt1amhlTnFvaGZqODJsL3Ra?=
 =?utf-8?B?QnZFeHFuS21OSldNNjI2aUdlUGppdFlST0tHclZCU3ZkK1lZaG1QckV2b1Yy?=
 =?utf-8?B?V3R4SWMzS1p4ZVlWVS8wRGIxckg0eFgzQ2VKeThPb0xzeU9XWWNrS0NhSnpt?=
 =?utf-8?B?ZnN3WFNjdVQwNW5vMlRIOExJNFQ5VVNTVFFWRWRxV3FYbDg5eEZ4SE1yakxq?=
 =?utf-8?B?eFBHTFJBamc4bG9pM0h4QVFhM0lwWWpXYksxRFh2WHp1V2Uwd3k1RW1nM1Vi?=
 =?utf-8?B?SnhIR01Hcm83V3ExUzUwOWZpT1RtNUFLVWFaQ1ZFRm9Tenp4YkdJVUdUTDFT?=
 =?utf-8?B?UXRzQ1NrNnJtOFFEMUE1NG01WitPaEdkSWFrd3EvUG9mcUttSHFxZnBza2Jx?=
 =?utf-8?B?ckVLK2xuckN4MmErMjc4VUliVHN2VXl1MlNBSGtLRllOQytRZGRYd3Ric2Ni?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a8433b-5111-47aa-d73e-08db0af0a95f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 22:54:55.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYcA3oy1PY4kUQBaRSn1C6UWCkh7HL8zeLijRFFQoTx6VRl7f8X8WmJUrbVmN2SU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6241
X-Proofpoint-ORIG-GUID: _SLzoCoq7sVwN1KpNRSI1EtT8LLdpmpK
X-Proofpoint-GUID: _SLzoCoq7sVwN1KpNRSI1EtT8LLdpmpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Over the past, there are some discussions to extend bpf
instruction ISA to accommodate some new use cases or
fix some potential issues. These new instructions will
be included in new cpu flavor -mcpu=v4.

The following are the proposal
to add new instructions in 6 different categories.
The proposal is a little bit rough. You can find bpf insn
background information in Documentation/bpf/instruction-set.rst.
You comments or suggestions are welcome!

SDIV/SMOD (signed div and mod)
==============================

bpf already has unsigned DIV and MOD. They are encoded as

   insn    code(4 bits)     source(1 bit)     instruction class(3 bit) 
off(16 bits)
   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          0
   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          0

The current 'code' field only has two value left, 0xe and 0xf.
gcc used these two values (0xe and 0xf) for SDIV and SMOD.
But using these two values takes up all 'code' space and makes
future extension hard.

Here, I propose to encode SDIV/SMOD like below:

   insn    code(4 bits)     source(1 bit)     instruction class(3 bit) 
off(16 bits)
   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          1
   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          1

Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
to indicate signed div/mod.

Sign extend load
================

Currently llvm generated normal load instructions are encoded like below.

   mode(3 bits)      size(2 bits)    instruction class(3 bits)
   BPF_MEM (0x3)     8/16/32/64      BPF_LDX

For mode, existing used values are 0x0, 0x1, 0x2, 0x3, 0x6.
The proposal is to use mod value 0x4 to encode sign extend loads.

   alu32_mode  mode(3 bits)      size(2 bits)    instruction class(3 bits)
   yes         BPF_SMEM (0x4)    8/16            BPF_LDX
   no          BPF_SMEM (0x4)    8/16/32         BPF_LDX

Sign extend register mov
========================

Current BPF_MOV insn is encoded as
   insn    code(4 bits)     source(1 bit)     instruction class(3 bit) 
off(16 bits)
   MOV     0xb              0/1               BPF_ALU/BPF_ALU64          0

Let us support sign extended move insn as defined below:

   alu32_mode  insn    code(4 bits)    source(1 bit)    instruction 
class(3 bit)   off(16 bits)
   yes         MOVS    0xb             0/1              BPF_ALU 
           8/16
   no          MOVS    0xb             0/1              BPF_ALU64 
           8/16/32

In the above sign extended mov instruction, 'off' represents the 'size'.
For example, if alu32 mode is enabled, and 'off' is 8, which means sign 
extend a 8-bit
value (imm or register) to a 32-bit value. If alu32 mode is not enabled, 
the same 8-bit
value will sign extend to a 64-bit value.

32-bit JA
=========

Currently, the whole range of operations with BPF_JMP32/BPF_JMP insn are 
implemented like below

   ========  =====  =========================  ============
   code      value  description                notes
   ========  =====  =========================  ============
   BPF_JA    0x00   PC += off                  BPF_JMP only
   BPF_JEQ   0x10   PC += off if dst == src
   BPF_JGT   0x20   PC += off if dst > src     unsigned
   BPF_JGE   0x30   PC += off if dst >= src    unsigned
   BPF_JSET  0x40   PC += off if dst & src
   BPF_JNE   0x50   PC += off if dst != src
   BPF_JSGT  0x60   PC += off if dst > src     signed
   BPF_JSGE  0x70   PC += off if dst >= src    signed
   BPF_CALL  0x80   function call
   BPF_EXIT  0x90   function / program return  BPF_JMP only
   BPF_JLT   0xa0   PC += off if dst < src     unsigned
   BPF_JLE   0xb0   PC += off if dst <= src    unsigned
   BPF_JSLT  0xc0   PC += off if dst < src     signed
   BPF_JSLE  0xd0   PC += off if dst <= src    signed
   ========  =====  =========================  ============

Here the 'off' is 16 bit so the range of jump is [-32768, 32767].
In rare cases, people may have large programs or have loops fully unrolled.
This may cause some jump offset beyond the above range. In current
llvm implementation, wrong code (after truncation) will be generated.

To fix this issue, the following new insn is proposed

   ========  =====  =========================  ============
   code      value  description                notes
   ========  =====  =========================  ============
   BPF_JA    0x00   PC += imm                  BPF_JMP32 only, src = 1

The way, the jump offset range become [-2^31, 2^31 - 1].

For other jump instructions, e.g., BPF_JEQ, with a jmp offset
beyond [-32768, 32767]. It can be simulated with a
'BPF_JA (PC += imm)' followed by the original
BPF_JEQ with the range 'off', or BPF_JEQ with a short range followed
by a BPF_JA.

bswap16/32/64
=============

Currently, llvm does not generate bswap16/32/64 properly.
Rather it generates be16/32/64 and le16/32/64 instructions based on
endianness of the current bpf target in compilation.
The existing encode looks below:

   bpf target      insn    code(4 bits)     source(1 bit)
     instruction class(3 bit)   imm(32 bits)
   big endian      LE      0xd              LE(0)
     BPF_ALU                    16/32/64
   little endian   BE      0xd              BE(1)
     BPF_ALU                    16/32/64

LE insn will do swap if the running target is big endian.
BE insn will do swap if the running target is little endian.
See kernel/bpf/core.c for details.

The new bswap instruction will have the following encoding:
insn    code(4 bits)     source(1 bit)     instruction class(3 bit) 
imm(32 bits)
BSWAP   0xd              0                 BPF_ALU64 
16/32/64

The BSWAP insn will be swap unconditionally.

ST
==

The kernel has already supported BPF_ST insn like below,

   mode(3 bits)      size(2 bits)    instruction class(3 bits)
   BPF_MEM (0x3)     8/16/32/64      BPF_ST

The semantics is:
   *(size *) (dst_reg + off) = imm32
LLVM just needs to implement this instruction under -mcpu=v4. looks
like gcc can already generate this instruction.
