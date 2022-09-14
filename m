Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782F35B817D
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 08:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiINGXG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 02:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiINGXE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 02:23:04 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10083.outbound.protection.outlook.com [40.107.1.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6FC71998
        for <bpf@vger.kernel.org>; Tue, 13 Sep 2022 23:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbOClWyVvdzWScPpqB97dGvKia0hGeCEDaSztAXGLswWzv5Gkvxv4Ucsw3EbFxTW9LLsH9m6ZhO26khoTRWASR9cSyFu9Zc+U077+QuiNu+LBdJSJ2WugPMDjKsu7WoRiMYPoNn5UPfswH9P0yc/dZK4bbR5oKzToM/p1rrD1GY5NvrYa9L9CMHmic+Wn7wjboPUtlAogHwUJwbT6Px0o+s5B0MpU6+Yvh2iHLBZKnPWng5MMI7B9f1bvh9UzxZgI3dHVRInYucN5EIk0WtsP5DxhoiVY4w7JwUGeyP1nv4XIuZdMUo0SAsAt2IZff5ALsqjlmMBGQQEScvnwEXT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jViKBkHzcWoqt80hbjAFeM+sV/Gzdjm3StOiTHlV858=;
 b=aFs7SacXYYnIYjEHEhzMpcygdUcCm3Hk3c1D4+J5VVUXpvT47vD+rGKiTKrFjt/t592a8YfghhcWulwhYCKsPmq24HrTqBXKT2hXyb2UC76Lfa7JE48kTTfVJzbDL/NavckwWujQa+fpL0uM+4k0B+gC2N2qPaaOOsaPFR5XvtBuu5v9YxNopO0MQiPkE4f+RjhoopHACAP/WOV/dKcllGHbSbs73aNzcc3QNHgbzt3ydEft6wdjv1sqf4eW7RZWsLY+VLmtNDXxowpDN46UapWMjCgx7Wz856t6HCrZopY11qVrKJtfacud86ucVeOLKD0/ubTgX4iL0OfuWyIcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jViKBkHzcWoqt80hbjAFeM+sV/Gzdjm3StOiTHlV858=;
 b=382yNmp1qZ0BMdPR96Diq4nE01Pfm/ZeCmr6k0uDCZhXSplQ+RsZB6aQCdRVE/jADFu2PN+BculbPv2ZGn90kdFcRVHNAfTWvO3QhZNXPmCQx0rkPgDgxPf3TsL/b5JnK1k6t38C1NgPASR7mphg4d4LPSdO90oRqeuaK/T4v8x53j2xkxUDQmwXsBsUuIHXhL6BxzGEg2bM3VtpibslRwc77sYW+nVrwpHByciTmHCqv+MpREnweBe7F5tmITtRoyTmZf0+VAaqDlhZeaiwcsYcB5tImdOKyEOs4HOYCeFthESHCDoavYG5sIQ7lSxhkvN+3t+TthaF7TsBmU62rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AS8PR04MB7782.eurprd04.prod.outlook.com (2603:10a6:20b:28a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 06:22:57 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::9c5d:52c0:6225:826e]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::9c5d:52c0:6225:826e%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 06:22:57 +0000
Date:   Wed, 14 Sep 2022 14:22:51 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
Message-ID: <YyFzO205ZZPieCav@syu-laptop>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|AS8PR04MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: f4805390-286e-4e6e-d02b-08da96199055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNrL2o/MBkfTAMjUimU2flHfZd2ZSL0T4ARXGZmv/g1A25nVXioMHgYJcMGMc9tSMTHfYuv2iuvCposyyvrIaZzd5mE7/KBpnuDQLPc6CHzufdfWVujnsGf4GqvKifs1dBU46YjYeWL+H/nynsBcPLeHeex9EeA4eBS76JgLI3xssHIQIRQGUH0WHnHP8CVnR/K77AfmNy0yIkHKoflqdZqYawSeLdKNME3vittad0lU3ZXHcvThtWAnX2rUob3DnokZcYNfEt51UaC5s9+sXP91EHq0+1amXZxQnP3C+mibDEc7aTLKqp8U0axlI86GpkNq/yXmaZlfEhSGpXJqI/Dn+lYr2wmVftCW7v9UDlwyOjxOAURS4OV3xq8/ZLXw4nxtxCMnNURv9ZT5GcA5viaTJUqjDxSa1YO6Unzp2RwgVeSkF0QmAdjydhJoUwEFomm4ETeFgGu066O1tHMdMbjhJqiwQkaFzCdnUPdbr3QDJNicaCHM8C+Bhyrejg7oEU93wf5wTLEfvJ5n4jhmZMrFOWJrnVbdSunqe48d/ysVoweScBzkphmmprzcjaP5h7+8Bb1EKawd6ble4e4yrlXqzHVcrygq9EfDi1Xq5iRqpmRmZ3ozpYZSwutapi2PY7W0INLbtqMe2puukn3ld41qNsQI5pgkkeeDXUrHsrmEW/QiXaRBIa0HBGxYsPOTiB0eNgIXupVcU4uOUcEh2LKylmr1HE7+qAPfbIQzk/MeVGOJiJZ+e7uMUNf7fVV6Uv1lKI88MMIebiKOrhIOHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(38100700002)(86362001)(478600001)(6486002)(41300700001)(186003)(316002)(6666004)(6506007)(66556008)(8676002)(66476007)(4326008)(30864003)(2906002)(15650500001)(53546011)(6512007)(83380400001)(966005)(26005)(9686003)(6916009)(66946007)(5660300002)(8936002)(33716001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aml1bmM1RE1FeVlYcmRtb3Rpc1RaQndyOUlFblpLYVdvblBSdzkyV3dkSkdL?=
 =?utf-8?B?NkZWZmpkQ1cveTVPYkpGZDRneE9ZOFYzVTUyb3VEaUx3cXAxQkRUTXFJRUpO?=
 =?utf-8?B?MllZZDZIYWRlZktZcDE1ajZnWE5wanlIWlozMjBSTkhMOGF6THJEc3BuRngr?=
 =?utf-8?B?NFdSZXk4aHJ5aDczdHA1aEFHbm10cURDQ2FCcWZzbE1jK1doYzRsS05YMWp4?=
 =?utf-8?B?d29UUEFvYm15Mk5KaTBoY2hTcW9jT1VPS2Z0ZTNuWVRyek1pVThUcHdQZ1Mv?=
 =?utf-8?B?eThGOXAxY1JuOERTS1VuYXZGL3UxMUVOVE1kUnNPeGtKZjJOU1N0SnE5bU9D?=
 =?utf-8?B?TEtneG9oRXZ0VFBYNllXREl4SzJqbndINHdnWWc1MVloNDI0QVNyL3NPZi9Q?=
 =?utf-8?B?ajdpKzN3ekF4YldOU2RzUEE0MWJlOXgvanpHYVIzME9HQlpHQnM0NkkwNC9l?=
 =?utf-8?B?Z3U3T0F2eVhSMU96cVdCSGRlY1FRZ2J1ZU4yNnFrTjFIdUpvbU51dVlTM3Qy?=
 =?utf-8?B?bTErdEZRM1JQcysvNmtBajhwM3pyMU5lK2RESndFQTQ1RjVPcldIL0M3ZnpQ?=
 =?utf-8?B?cHhUSVJsM0hZeTYvdE9JMFh5NXowOU9IME1STGVGRTkvSkF1ZW5sZmQzVUNN?=
 =?utf-8?B?cW14NzdpL2FPNnFGK0lvYnN6ZlgvZU52ZlY0MHN1eXBOSDRVN2VUYU04aDBh?=
 =?utf-8?B?RjF4eVp5VGJhL1ByWXFKbVBvSjZDNG5keFFOZlhLMWUxN2NkakkwazByVndw?=
 =?utf-8?B?WEd5TWdyTGN3bHV6M2Z1aHVoUzN4MUJJUk4yRzcxVWU3bFZSL0R3VlNSSEtj?=
 =?utf-8?B?RDZTWEVFNzAxbDM5WjBPVXNGUm5LL0NLSmk5dk1nZW1FcFVzbjIyL3cwb0Zw?=
 =?utf-8?B?dkpKSTd6dUJmamdFd0JuUFFvRjB1SFI1cVdtSE11cHZtNW1ybzU3OEczN0ta?=
 =?utf-8?B?Y0dkc2lTVVNCRERLTTV2NCsvZGJqTmxMMUI2em80T1VmVmFydlA3RURSTTUw?=
 =?utf-8?B?bC94cFhMZmovbTdwdXFWYmIzLzNhekRhZlo2TjZ3citsZG1VN3doTEV2Z1J4?=
 =?utf-8?B?cnIxZmZWQVJUcW9IaDBDODloa1dBcEU2SmR4ZitCTVRYcnBFZDVqMGIwMjJv?=
 =?utf-8?B?VUIvekRDek9Hb0JhWkRNTVFTdG5uVE1KbHdFWFNmcHYyYVlnbzBNbkQ4aEVK?=
 =?utf-8?B?dUYrSlQybklsWFBqUEQ0cTY0Wk11RmRuRFB0b1JadGRockFWS0NscG0xbUlR?=
 =?utf-8?B?V2lHSkRneDdiODRhdWxRdGtiODIyMnRDWWhQM2R1Y0RCNzdLUXcrejlsZjNQ?=
 =?utf-8?B?RFhmNVF2amNNTTBqV2h1ZHlUTHlQUk5YNU96UXczT3FDaVJQbE0vT2w2QjJa?=
 =?utf-8?B?SWoyN3VTQk1sRU9oRzMzMnFmeXY4R3BMd1hUampNSC9uYmpTdVF4Ti9vYWVz?=
 =?utf-8?B?M0xwNlVIYWpuTzMycldseHVHKzNLcEFZNEtFb1lzUW1zcmlnNGRaMDRORkFk?=
 =?utf-8?B?L3B6VDhmd21KQ2Z2d29DM1B5bVFYa1puVDkrd0o5ZVlXZkNob0hIcnZzNTJ3?=
 =?utf-8?B?VjRQQzlzRFNFZWlNL0E2WFpVclppN095VHcvYktsalpiQmdRRmpYR1VGaHZN?=
 =?utf-8?B?VkFBL05vVi9FSEY3b3dGYWlxVURYOFdMdURWUTcySTZ3d1dsMmlwRkhnbjJV?=
 =?utf-8?B?UTlBVlNZSW9nWGlLOHZFZ3JHOEpJV09EZEM2YWRRMHJHSkhuMkRoblhjeEsv?=
 =?utf-8?B?UGs3SEVvd2xwUzdoSG1HMjZjdXZjMnVrcFNTN1lLaW5hUTV3NTdJSmxsSFJw?=
 =?utf-8?B?ek1rdGRsY1VnRDBCOUNrb3o2VnlHb296SzRmelU4UUV3TFliOTZuNExXT0d6?=
 =?utf-8?B?VzVtaEludzRMTElERElLTjQxRkRxVnVlaGszd0x5ejJlTU5ZNVhBSzkrOHRy?=
 =?utf-8?B?cG5YZlY2QWdhUVZrbEtMZm1VeUhISkFrdXRlSjQrWGMvMlU2R3FuYVlBR0RJ?=
 =?utf-8?B?N28vemVPM1JLVG1DaXBDaXJlaG94MUhMRGYzVFliNExQUC9hTGJBcHJGUnFu?=
 =?utf-8?B?N0JTVGJTR2R6dGRvb3RJQ1Vzd2pCWVgzWlZMVFkrcUMreHR0d0YrSWN2S3lL?=
 =?utf-8?Q?xfcK/VtBJDgy9/qnnTeKROxjc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4805390-286e-4e6e-d02b-08da96199055
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 06:22:57.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zo6WlVz+GUZfKpIhQA2HZDK1NZCBxddrFH8+MYNCqOjGoAYCes973vQT88Pd+HEXGGXsbY3waL9VeQfVsA+g9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7782
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 13, 2022 at 08:12:52AM +0000, Dave Thaler wrote:
> Resending since the list apparently never got the emails I sent last Friday...
> 
> From: Dave Thaler 
> Sent: Friday, September 9, 2022 9:36 PM
> To: bpf <bpf@vger.kernel.org>
> Subject: ebpf-docs: draft of ISA doc updates in progress
> 
> I've been working on ISA docs, with review by Jim Harris, Quentin Monnet, and Alan
> Jowett so wanted to post this before LPC when we can discuss progress and open
> questions.
> 
> A rendered draft can be viewed at:
> https://github.com/dthaler/ebpf-docs/blob/update/isa/kernel.org/instruction-set.rst
> 
> For people who prefer github format: https://github.com/dthaler/ebpf-docs/pull/4
> 
> For people who use format-patch format, see below.  The instruction-set.rst
> changes are directly diffs against the kernel.org copy mirrored
> to github for rendering via the link above.
> 
> Feedback welcome on the direction so far.

Thanks for working on this! A few inlined comments below.

> Thanks,
> Dave
> 
> [...]
> 
> diff --git a/isa/kernel.org/instruction-set.rst b/isa/kernel.org/instruction-set.rst
> index 1b0e671..7f8ee00 100644
> --- a/isa/kernel.org/instruction-set.rst
> +++ b/isa/kernel.org/instruction-set.rst
> @@ -1,8 +1,24 @@
> +.. contents::
> +.. sectnum::
> 
>  ====================
> eBPF Instruction Set
> ====================
> 
> +The eBPF instruction set consists of eleven 64 bit registers, a program counter,
> +and 512 bytes of stack space.
> +
> +Versions
> +========
> +
> +The current Instruction Set Architecture (ISA) version, sometimes referred to in other documents
> +as a "CPU" version, is 3.  This document also covers older versions of the ISA.
> +
> +   **Note**
> +
> +   *Clang implementation*: Clang can select the eBPF ISA version using
> +   ``-mcpu=v2`` for example to select version 2.
> +
> Registers and calling convention
> ================================
> 
> @@ -11,198 +27,331 @@ all of which are 64-bits wide.
> 
>  The eBPF calling convention is defined as:
> 
> - * R0: return value from function calls, and exit value for eBPF programs
> - * R1 - R5: arguments for function calls
> - * R6 - R9: callee saved registers that function calls will preserve
> - * R10: read-only frame pointer to access stack
> +* R0: return value from function calls, and exit value for eBPF programs
> +* R1 - R5: arguments for function calls
> +* R6 - R9: callee saved registers that function calls will preserve
> +* R10: read-only frame pointer to access stack
> +
> +Registers R0 - R5 are scratch registers, meaning the BPF program needs to either
> +spill them to the BPF stack or move them to callee saved registers if these
> +arguments are to be reused across multiple function calls. Spilling means
> +that the value in the register is moved to the BPF stack. The reverse operation
> +of moving the variable from the BPF stack to the register is called filling.
> +The reason for spilling/filling is due to the limited number of registers.
> 
> -R0 - R5 are scratch registers and eBPF programs needs to spill/fill them if
> -necessary across calls.
> +   **Note**
> +
> +   *Linux implementation*: In the Linux kernel, the exit value for eBPF
> +   programs is passed as a 32 bit value.
> +
> +Upon entering execution of an eBPF program, registers R1 - R5 initially can contain
> +the input arguments for the program (similar to the argc/argv pair for a typical C program).
> +The actual number of registers used, and their meaning, is defined by the program type;
> +for example, a networking program might have an argument that includes network packet data
> +and/or metadata.
> +
> +   **Note**
> +
> +   *Linux implementation*: In the Linux kernel, all program types only use
> +   R1 which contains the "context", which is typically a structure containing all
> +   the inputs needed.  
>  
>  Instruction encoding
> ====================
> 
> +An eBPF program is a sequence of instructions.
> +
> eBPF has two instruction encodings:
> 
> - * the basic instruction encoding, which uses 64 bits to encode an instruction
> - * the wide instruction encoding, which appends a second 64-bit immediate value
> -   (imm64) after the basic instruction for a total of 128 bits.
> +* the basic instruction encoding, which uses 64 bits to encode an instruction
> +* the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
> +  constant) value after the basic instruction for a total of 128 bits.
> +
> +The basic instruction encoding is as follows:
> 
> -The basic instruction encoding looks as follows:
> +=============  =======  ===============  ====================  ============
> +32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
> +=============  =======  ===============  ====================  ============
> +imm            offset   src              dst                   opcode
> +=============  =======  ===============  ====================  ============
> 
> - =============  =======  ===============  ====================  ============
> - 32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
> - =============  =======  ===============  ====================  ============
> - immediate      offset   source register  destination register  opcode
> - =============  =======  ===============  ====================  ============
> +imm         
> +  integer immediate value

Perhaps mention that imm is a _signed_ integer just like offset below?

> +
> +offset
> +  signed integer offset used with pointer arithmetic
> +
> +src
> +  source register number (0-10)
> +
> +dst
> +  destination register number (0-10)
> +
> +opcode
> +  operation to perform
> 
>  Note that most instructions do not use all of the fields.
> -Unused fields shall be cleared to zero.
> +Unused fields must be set to zero.
> +
> +As discussed below in `64-bit immediate instructions`_, some basic
> +instructions denote that a 64-bit immediate value follows.  Thus
> +the wide instruction encoding is as follows:
> +
> +=================  =============
> +64 bits (MSB)      64 bits (LSB)
> +=================  =============
> +basic instruction  imm64
> +=================  =============
> +
> +where MSB and LSB mean the most significant bits and least significant bits, respectively.
> +
> +In the remainder of this document 'src' and 'dst' refer to the values of the source
> +and destination registers, respectively, rather than the register number.
> 
>  Instruction classes
> -------------------
> 
> -The three LSB bits of the 'opcode' field store the instruction class:
> -
> -  =========  =====  ===============================
> -  class      value  description
> -  =========  =====  ===============================
> -  BPF_LD     0x00   non-standard load operations
> -  BPF_LDX    0x01   load into register operations
> -  BPF_ST     0x02   store from immediate operations
> -  BPF_STX    0x03   store from register operations
> -  BPF_ALU    0x04   32-bit arithmetic operations
> -  BPF_JMP    0x05   64-bit jump operations
> -  BPF_JMP32  0x06   32-bit jump operations
> -  BPF_ALU64  0x07   64-bit arithmetic operations
> -  =========  =====  ===============================
> +The encoding of the 'opcode' field varies and can be determined from
> +the three least significant bits (LSB) of the 'opcode' field which holds
> +the "instruction class", as follows:
> +
> +=========  =====  ===============================  =======  =================
> +class      value  description                      version  reference
> +=========  =====  ===============================  =======  =================
> +BPF_LD     0x00   non-standard load operations     1        `Load and store instructions`_
> +BPF_LDX    0x01   load into register operations    1        `Load and store instructions`_
> +BPF_ST     0x02   store from immediate operations  1        `Load and store instructions`_
> +BPF_STX    0x03   store from register operations   1        `Load and store instructions`_
> +BPF_ALU    0x04   32-bit arithmetic operations     3        `Arithmetic and jump instructions`_
> +BPF_JMP    0x05   64-bit jump operations           1        `Arithmetic and jump instructions`_
> +BPF_JMP32  0x06   32-bit jump operations           3        `Arithmetic and jump instructions`_
> +BPF_ALU64  0x07   64-bit arithmetic operations     1        `Arithmetic and jump instructions`_
> +=========  =====  ===============================  =======  =================
> +
> +where 'version' indicates the first ISA version in which support for the value was mandatory.
> 
>  Arithmetic and jump instructions
> ================================
> 
> -For arithmetic and jump instructions (BPF_ALU, BPF_ALU64, BPF_JMP and
> -BPF_JMP32), the 8-bit 'opcode' field is divided into three parts:
> +For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` and
> +``BPF_JMP32``), the 8-bit 'opcode' field is divided into three parts:
> +
> +==============  ======  =================
> +4 bits (MSB)    1 bit   3 bits (LSB)
> +==============  ======  =================
> +code            source  instruction class
> +==============  ======  =================
> 
> -  ==============  ======  =================
> -  4 bits (MSB)    1 bit   3 bits (LSB)
> -  ==============  ======  =================
> -  operation code  source  instruction class
> -  ==============  ======  =================
> +code
> +  the operation code, whose meaning varies by instruction class
> 
> -The 4th bit encodes the source operand:
> +source
> +  the source operand location, which unless otherwise specified is one of:
> 
>    ======  =====  ========================================
>    source  value  description
>    ======  =====  ========================================
> -  BPF_K   0x00   use 32-bit immediate as source operand
> -  BPF_X   0x08   use 'src_reg' register as source operand
> +  BPF_K   0x00   use 32-bit 'imm' value as source operand
> +  BPF_X   0x08   use 'src' register value as source operand
>    ======  =====  ========================================
> 
> -The four MSB bits store the operation code.
> -
> +instruction class
> +  the instruction class (see `Instruction classes`_)
> 
>  Arithmetic instructions
> -----------------------
> 
> -BPF_ALU uses 32-bit wide operands while BPF_ALU64 uses 64-bit wide operands for
> +Instruction class ``BPF_ALU`` uses 32-bit wide operands (zeroing the upper 32 bits
> +of the destination register) while ``BPF_ALU64`` uses 64-bit wide operands for
> otherwise identical operations.
> -The code field encodes the operation as below:
> 
> -  ========  =====  =================================================
> -  code      value  description
> -  ========  =====  =================================================
> -  BPF_ADD   0x00   dst += src
> -  BPF_SUB   0x10   dst -= src
> -  BPF_MUL   0x20   dst \*= src
> -  BPF_DIV   0x30   dst /= src
> -  BPF_OR    0x40   dst \|= src
> -  BPF_AND   0x50   dst &= src
> -  BPF_LSH   0x60   dst <<= src
> -  BPF_RSH   0x70   dst >>= src
> -  BPF_NEG   0x80   dst = ~src
> -  BPF_MOD   0x90   dst %= src
> -  BPF_XOR   0xa0   dst ^= src
> -  BPF_MOV   0xb0   dst = src
> -  BPF_ARSH  0xc0   sign extending shift right
> -  BPF_END   0xd0   byte swap operations (see separate section below)
> -  ========  =====  =================================================
> +Support for ``BPF_ALU`` is required in ISA version 3, and optional in earlier
> +versions.
> +
> +   **Note**
> +
> +   *Clang implementation*:
> +   For ISA versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
> +   ``-Xclang -target-feature -Xclang +alu32``.
> +
> +The 4-bit 'code' field encodes the operation as follows:
> +
> +========  =====  =================================================
> +code      value  description
> +========  =====  =================================================
> +BPF_ADD   0x00   dst += src
> +BPF_SUB   0x10   dst -= src
> +BPF_MUL   0x20   dst \*= src
> +BPF_DIV   0x30   dst /= src
> +BPF_OR    0x40   dst \|= src
> +BPF_AND   0x50   dst &= src
> +BPF_LSH   0x60   dst <<= src
> +BPF_RSH   0x70   dst >>= src
> +BPF_NEG   0x80   dst = ~src
> +BPF_MOD   0x90   dst %= src
> +BPF_XOR   0xa0   dst ^= src
> +BPF_MOV   0xb0   dst = src
> +BPF_ARSH  0xc0   sign extending shift right
> +BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
> +========  =====  =================================================
> +
> +Underflow and overflow are allowed during arithmetic operations,
> +meaning the 64-bit or 32-bit value will wrap.
> +
> +``BPF_DIV`` has an implicit program exit condition as well. If
> +eBPF program execution would result in division by zero,
> +program execution must be gracefully aborted.

As discussed in yesterday's session, there's no graceful abortion on
division by zero, instead, the BPF verifier in Linux prevents division by
zero from happening. Here a few additional notes:

1. Modulo by zero is also prevented for the same reason

2. If the divisor comes from imm, then the verifier checks that its value is
   not zero. If the divisor comes from register, the verifier patch the
   programs so that division/modulo by zero doesn't happens, somewhat
   equivalent to the following pseudo code:

   /* divisor in src */
   if (src == 0) { 
     if (code == BPF_DIV)
       dst = 0;
     else if (code == BPF_MOD)
       dst = dst;
   } else {
     if (code == BPF_DIV)
       dst = dst / src;
     else if (code == BPF_MOD)
       dst = dst % src;
   }

> +Examples:
> 
> -BPF_ADD | BPF_X | BPF_ALU means::
> +``BPF_ADD | BPF_X | BPF_ALU`` (0x0c) means::
> 
> -  dst_reg = (u32) dst_reg + (u32) src_reg;
> +  dst = (uint32_t) (dst + src);
> 
> -BPF_ADD | BPF_X | BPF_ALU64 means::
> +where '(uint32_t)' indicates truncation to 32 bits.
> 
> -  dst_reg = dst_reg + src_reg
> +   **Note**
> 
> -BPF_XOR | BPF_K | BPF_ALU means::
> +   *Linux implementation*: In the Linux kernel, uint32_t is expressed as u32,
> +   uint64_t is expressed as u64, etc.  This document uses the standard C terminology
> +   as the cross-platform specification.
> 
> -  src_reg = (u32) src_reg ^ (u32) imm32
> +``BPF_ADD | BPF_X | BPF_ALU64`` (0x0f) means::
> 
> -BPF_XOR | BPF_K | BPF_ALU64 means::
> +  dst = dst + src
> 
> -  src_reg = src_reg ^ imm32
> +``BPF_XOR | BPF_K | BPF_ALU`` (0xa4) means::
> +
> +  src = (uint32_t) src ^ (uint32_t) imm
> +
> +``BPF_XOR | BPF_K | BPF_ALU64`` (0xa7) means::
> +
> +  src = src ^ imm
> 
>  
>  Byte swap instructions
> -----------------------
> +~~~~~~~~~~~~~~~~~~~~~~
> 
>  The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
> -code field of ``BPF_END``.
> +'code' field of ``BPF_END``.
> 
>  The byte swap instructions operate on the destination register
> only and do not use a separate source register or immediate value.
> 
> -The 1-bit source operand field in the opcode is used to to select what byte
> -order the operation convert from or to:
> +Byte swap instructions use non-default semantics of the 1-bit 'source' field in
> +the 'opcode' field.  Instead of indicating the source operator, it is instead
> +used to select what byte order the operation converts from or to:
> 
> -  =========  =====  =================================================
> -  source     value  description
> -  =========  =====  =================================================
> -  BPF_TO_LE  0x00   convert between host byte order and little endian
> -  BPF_TO_BE  0x08   convert between host byte order and big endian
> -  =========  =====  =================================================
> -
> -The imm field encodes the width of the swap operations.  The following widths
> -are supported: 16, 32 and 64.
> -
> -Examples:
> +=========  =====  =================================================
> +source     value  description
> +=========  =====  =================================================
> +BPF_TO_LE  0x00   convert between host byte order and little endian
> +BPF_TO_BE  0x08   convert between host byte order and big endian
> +=========  =====  =================================================
> 
> -``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
> +   **Note**
> 
> -  dst_reg = htole16(dst_reg)
> +   *Linux implementation*:
> +   ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and
> +   ``BPF_TO_BE`` respectively.
> 
> -``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
> +The 'imm' field encodes the width of the swap operations.  The following widths
> +are supported: 16, 32 and 64. The following table summarizes the resulting
> +possibilities:
> 
> -  dst_reg = htobe64(dst_reg)
> +=============================  =========  ===  ========  ==================
> +opcode construction            opcode     imm  mnemonic  pseudocode
> +=============================  =========  ===  ========  ==================
> +BPF_END | BPF_TO_LE | BPF_ALU  0xd4       16   le16 dst  dst = htole16(dst)
> +BPF_END | BPF_TO_LE | BPF_ALU  0xd4       32   le32 dst  dst = htole32(dst)
> +BPF_END | BPF_TO_LE | BPF_ALU  0xd4       64   le64 dst  dst = htole64(dst)
> +BPF_END | BPF_TO_BE | BPF_ALU  0xdc       16   be16 dst  dst = htobe16(dst)
> +BPF_END | BPF_TO_BE | BPF_ALU  0xdc       32   be32 dst  dst = htobe32(dst)
> +BPF_END | BPF_TO_BE | BPF_ALU  0xdc       64   be64 dst  dst = htobe64(dst)
> +=============================  =========  ===  ========  ==================
> 
> -``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and
> -``BPF_TO_BE`` respectively.
> +where
> 
> +* mnenomic indicates a short form that might be displayed by some tools such as disassemblers
> +* 'htoleNN()' indicates converting a NN-bit value from host byte order to little-endian byte order
> +* 'htobeNN()' indicates converting a NN-bit value from host byte order to big-endian byte order
> 
>  Jump instructions
> -----------------
> 
> -BPF_JMP32 uses 32-bit wide operands while BPF_JMP uses 64-bit wide operands for
> +Instruction class ``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
> otherwise identical operations.
> -The code field encodes the operation as below:
> -
> -  ========  =====  =========================  ============
> -  code      value  description                notes
> -  ========  =====  =========================  ============
> -  BPF_JA    0x00   PC += off                  BPF_JMP only
> -  BPF_JEQ   0x10   PC += off if dst == src
> -  BPF_JGT   0x20   PC += off if dst > src     unsigned
> -  BPF_JGE   0x30   PC += off if dst >= src    unsigned
> -  BPF_JSET  0x40   PC += off if dst & src
> -  BPF_JNE   0x50   PC += off if dst != src
> -  BPF_JSGT  0x60   PC += off if dst > src     signed
> -  BPF_JSGE  0x70   PC += off if dst >= src    signed
> -  BPF_CALL  0x80   function call
> -  BPF_EXIT  0x90   function / program return  BPF_JMP only
> -  BPF_JLT   0xa0   PC += off if dst < src     unsigned
> -  BPF_JLE   0xb0   PC += off if dst <= src    unsigned
> -  BPF_JSLT  0xc0   PC += off if dst < src     signed
> -  BPF_JSLE  0xd0   PC += off if dst <= src    signed
> -  ========  =====  =========================  ============
> -
> -The eBPF program needs to store the return value into register R0 before doing a
> -BPF_EXIT.
> 
> +Support for ``BPF_JMP32`` is required in ISA version 3, and optional in earlier
> +versions.
> +
> +The 4-bit 'code' field encodes the operation as below, where PC is the program counter:
> +
> +========  =====  ============================  =======  ============
> +code      value  description                   version  notes
> +========  =====  ============================  =======  ============
> +BPF_JA    0x00   PC += offset                  1        BPF_JMP only
> +BPF_JEQ   0x10   PC += offset if dst == src    1
> +BPF_JGT   0x20   PC += offset if dst > src     1        unsigned
> +BPF_JGE   0x30   PC += offset if dst >= src    1        unsigned
> +BPF_JSET  0x40   PC += offset if dst & src     1
> +BPF_JNE   0x50   PC += offset if dst != src    1
> +BPF_JSGT  0x60   PC += offset if dst > src     1        signed
> +BPF_JSGE  0x70   PC += offset if dst >= src    1        signed
> +BPF_CALL  0x80   call function imm             1        see `Helper functions`_
> +BPF_EXIT  0x90   function / program return     1        BPF_JMP only
> +BPF_JLT   0xa0   PC += offset if dst < src     2        unsigned
> +BPF_JLE   0xb0   PC += offset if dst <= src    2        unsigned
> +BPF_JSLT  0xc0   PC += offset if dst < src     2        signed
> +BPF_JSLE  0xd0   PC += offset if dst <= src    2        signed
> +========  =====  ============================  =======  ============
> +
> +where 'version' indicates the first ISA version in which the value was supported.
> +
> +Helper functions
> +~~~~~~~~~~~~~~~~
> +Helper functions are a concept whereby BPF programs can call into
> +set of function calls exposed by the eBPF runtime.  Each helper
> +function is identified by an integer used in a ``BPF_CALL`` instruction.
> +The available helper functions may differ for each eBPF program type.

While BPF ISA only supports direct call BPF_CALL[1], technically there is an
opcode 0x8d (BPF_JUMP | BPF_CALL | BPF_X) that has the indirect call
semantic, and Clang emit such indirect call instruction if user attempt to
compile with -O0.

I think it worth mentioning in this document for better clarity, perhaps
simply saying that indirect call is not part of BPF ISA is enough.

1: https://lore.kernel.org/bpf/20220713011851.4a2tnqhdd5f5iwak@macbook-pro-3.dhcp.thefacebook.com/

> +Conceptually, each helper function is implemented with a commonly shared function
> +signature defined as:
> +
> +  uint64_t function(uint64_t r1, uint64_t r2, uint64_t r3, uint64_t r4, uint64_t r5)
> +
> +In actuality, each helper function is defined as taking between 0 and 5 arguments,
> +with the remaining registers being ignored.  The definition of a helper function
> +is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
> +the number of arguments, and the type of each argument.
> 
>  Load and store instructions
> ===========================
> 
> -For load and store instructions (BPF_LD, BPF_LDX, BPF_ST and BPF_STX), the
> +For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, and ``BPF_STX``), the
> 8-bit 'opcode' field is divided as:
> 
> -  ============  ======  =================
> -  3 bits (MSB)  2 bits  3 bits (LSB)
> -  ============  ======  =================
> -  mode          size    instruction class
> -  ============  ======  =================
> +============  ======  =================
> +3 bits (MSB)  2 bits  3 bits (LSB)
> +============  ======  =================
> +mode          size    instruction class
> +============  ======  =================
> 
> -The size modifier is one of:
> +mode
> +  one of:
> +
> +  =============  =====  ====================================  =============
> +  mode modifier  value  description                           reference
> +  =============  =====  ====================================  =============
> +  BPF_IMM        0x00   64-bit immediate instructions         `64-bit immediate instructions`_
> +  BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BPF Packet access instructions`_
> +  BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BPF Packet access instructions`_
> +  BPF_MEM        0x60   regular load and store operations     `Regular load and store operations`_
> +  BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
> +  =============  =====  ====================================  =============
> +
> +size
> +  one of:
> 
>    =============  =====  =====================
>    size modifier  value  description
> @@ -213,18 +362,8 @@ The size modifier is one of:
>    BPF_DW         0x18   double word (8 bytes)
>    =============  =====  =====================
> 
> -The mode modifier is one of:
> -
> -  =============  =====  ====================================
> -  mode modifier  value  description
> -  =============  =====  ====================================
> -  BPF_IMM        0x00   64-bit immediate instructions
> -  BPF_ABS        0x20   legacy BPF packet access (absolute)
> -  BPF_IND        0x40   legacy BPF packet access (indirect)
> -  BPF_MEM        0x60   regular load and store operations
> -  BPF_ATOMIC     0xc0   atomic operations
> -  =============  =====  ====================================
> -
> +instruction class
> +  the instruction class (see `Instruction classes`_)
> 
>  Regular load and store operations
> ---------------------------------
> @@ -232,19 +371,22 @@ Regular load and store operations
> The ``BPF_MEM`` mode modifier is used to encode regular load and store
> instructions that transfer data between a register and memory.
> 
> -``BPF_MEM | <size> | BPF_STX`` means::
> -
> -  *(size *) (dst_reg + off) = src_reg
> -
> -``BPF_MEM | <size> | BPF_ST`` means::
> -
> -  *(size *) (dst_reg + off) = imm32
> -
> -``BPF_MEM | <size> | BPF_LDX`` means::
> -
> -  dst_reg = *(size *) (src_reg + off)
> -
> -Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
> +=============================  =========  ==================================
> +opcode construction            opcode     pseudocode
> +=============================  =========  ==================================
> +BPF_MEM | BPF_B | BPF_LDX      0x71       dst = *(uint8_t *) (src + offset)  
> +BPF_MEM | BPF_H | BPF_LDX      0x69       dst = *(uint16_t *) (src + offset)
> +BPF_MEM | BPF_W | BPF_LDX      0x61       dst = *(uint32_t *) (src + offset)
> +BPF_MEM | BPF_DW | BPF_LDX     0x79       dst = *(uint64_t *) (src + offset)
> +BPF_MEM | BPF_B | BPF_ST       0x72       *(uint8_t *) (dst + offset) = imm
> +BPF_MEM | BPF_H | BPF_ST       0x6a       *(uint16_t *) (dst + offset) = imm
> +BPF_MEM | BPF_W | BPF_ST       0x62       *(uint32_t *) (dst + offset) = imm
> +BPF_MEM | BPF_DW | BPF_ST      0x7a       *(uint64_t *) (dst + offset) = imm
> +BPF_MEM | BPF_B | BPF_STX      0x73       *(uint8_t *) (dst + offset) = src
> +BPF_MEM | BPF_H | BPF_STX      0x6b       *(uint16_t *) (dst + offset) = src
> +BPF_MEM | BPF_W | BPF_STX      0x63       *(uint32_t *) (dst + offset) = src
> +BPF_MEM | BPF_DW | BPF_STX     0x7b       *(uint64_t *) (dst + offset) = src
> +=============================  =========  ==================================
> 
>  Atomic operations
> -----------------
> @@ -256,76 +398,83 @@ by other eBPF programs or means outside of this specification.
> All atomic operations supported by eBPF are encoded as store operations
> that use the ``BPF_ATOMIC`` mode modifier as follows:
> 
> -  * ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
> -  * ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
> -  * 8-bit and 16-bit wide atomic operations are not supported.
> +* ``BPF_ATOMIC | BPF_W | BPF_STX`` (0xc3) for 32-bit operations
> +* ``BPF_ATOMIC | BPF_DW | BPF_STX`` (0xdb) for 64-bit operations
> +
> +Note that 8-bit (``BPF_B``) and 16-bit (``BPF_H``) wide atomic operations are not supported,
> +nor is ``BPF_ATOMIC | <size> | BPF_ST``.
> 
> -The imm field is used to encode the actual atomic operation.
> +The 'imm' field is used to encode the actual atomic operation.
> Simple atomic operation use a subset of the values defined to encode
> -arithmetic operations in the imm field to encode the atomic operation:
> +arithmetic operations in the 'imm' field to encode the atomic operation:
> 
> -  ========  =====  ===========
> -  imm       value  description
> -  ========  =====  ===========
> -  BPF_ADD   0x00   atomic add
> -  BPF_OR    0x40   atomic or
> -  BPF_AND   0x50   atomic and
> -  BPF_XOR   0xa0   atomic xor
> -  ========  =====  ===========
> +========  =====  ===========  =======
> +imm       value  description  version
> +========  =====  ===========  =======
> +BPF_ADD   0x00   atomic add   1
> +BPF_OR    0x40   atomic or    3
> +BPF_AND   0x50   atomic and   3
> +BPF_XOR   0xa0   atomic xor   3
> +========  =====  ===========  =======
> 
> +where 'version' indicates the first ISA version in which the value was supported.
> 
> -``BPF_ATOMIC | BPF_W  | BPF_STX`` with imm = BPF_ADD means::
> +``BPF_ATOMIC | BPF_W  | BPF_STX`` (0xc3) with 'imm' = BPF_ADD means::
> 
> -  *(u32 *)(dst_reg + off16) += src_reg
> +  *(uint32_t *)(dst + offset) += src
> 
> -``BPF_ATOMIC | BPF_DW | BPF_STX`` with imm = BPF ADD means::
> +``BPF_ATOMIC | BPF_DW | BPF_STX`` (0xdb) with 'imm' = BPF ADD means::
> 
> -  *(u64 *)(dst_reg + off16) += src_reg
> +  *(uint64_t *)(dst + offset) += src
> 
> -``BPF_XADD`` is a deprecated name for ``BPF_ATOMIC | BPF_ADD``.
> +``BPF_XADD`` appeared in version 1, but is now considered to be a deprecated alias
> +for ``BPF_ATOMIC | BPF_ADD``.
> 
> -In addition to the simple atomic operations, there also is a modifier and
> +In addition to the simple atomic operations above, there also is a modifier and
> two complex atomic operations:
> 
> -  ===========  ================  ===========================
> -  imm          value             description
> -  ===========  ================  ===========================
> -  BPF_FETCH    0x01              modifier: return old value
> -  BPF_XCHG     0xe0 | BPF_FETCH  atomic exchange
> -  BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
> -  ===========  ================  ===========================
> +===========  ================  ===========================  =======
> +imm          value             description                  version
> +===========  ================  ===========================  =======
> +BPF_FETCH    0x01              modifier: return old value   3
> +BPF_XCHG     0xe0 | BPF_FETCH  atomic exchange              3
> +BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange  3
> +===========  ================  ===========================  =======
> 
>  The ``BPF_FETCH`` modifier is optional for simple atomic operations, and
> always set for the complex atomic operations.  If the ``BPF_FETCH`` flag
> -is set, then the operation also overwrites ``src_reg`` with the value that
> +is set, then the operation also overwrites ``src`` with the value that
> was in memory before it was modified.
> 
> -The ``BPF_XCHG`` operation atomically exchanges ``src_reg`` with the value
> -addressed by ``dst_reg + off``.
> +The ``BPF_XCHG`` operation atomically exchanges ``src`` with the value
> +addressed by ``dst + offset``.
> 
>  The ``BPF_CMPXCHG`` operation atomically compares the value addressed by
> -``dst_reg + off`` with ``R0``. If they match, the value addressed by
> -``dst_reg + off`` is replaced with ``src_reg``. In either case, the
> -value that was at ``dst_reg + off`` before the operation is zero-extended
> +``dst + offset`` with ``R0``. If they match, the value addressed by
> +``dst + offset`` is replaced with ``src``. In either case, the
> +value that was at ``dst + offset`` before the operation is zero-extended
> and loaded back to ``R0``.
> 
> -Clang can generate atomic instructions by default when ``-mcpu=v3`` is
> -enabled. If a lower version for ``-mcpu`` is set, the only atomic instruction
> -Clang can generate is ``BPF_ADD`` *without* ``BPF_FETCH``. If you need to enable
> -the atomics features, while keeping a lower ``-mcpu`` version, you can use
> -``-Xclang -target-feature -Xclang +alu32``.
> +   **Note**
> +
> +   *Clang implementation*:
> +   Clang can generate atomic instructions by default when ``-mcpu=v3`` is
> +   enabled. If a lower version for ``-mcpu`` is set, the only atomic instruction
> +   Clang can generate is ``BPF_ADD`` *without* ``BPF_FETCH``. If you need to enable
> +   the atomics features, while keeping a lower ``-mcpu`` version, you can use
> +   ``-Xclang -target-feature -Xclang +alu32``.
> 
>  64-bit immediate instructions
> -----------------------------
> 
> -Instructions with the ``BPF_IMM`` mode modifier use the wide instruction
> +Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
> encoding for an extra imm64 value.
> 
>  There is currently only one such instruction.
> 
> -``BPF_LD | BPF_DW | BPF_IMM`` means::
> +``BPF_IMM | BPF_DW | BPF_LD`` (0x18) means::
> 
> -  dst_reg = imm64
> +  dst = imm64
> 
>  
>  Legacy BPF Packet access instructions
> @@ -333,34 +482,236 @@ Legacy BPF Packet access instructions
> 
>  eBPF has special instructions for access to packet data that have been
> carried over from classic BPF to retain the performance of legacy socket
> -filters running in the eBPF interpreter.
> +filters running in an eBPF interpreter.
> 
>  The instructions come in two forms: ``BPF_ABS | <size> | BPF_LD`` and
> ``BPF_IND | <size> | BPF_LD``.
> 
>  These instructions are used to access packet data and can only be used when
> -the program context is a pointer to networking packet.  ``BPF_ABS``
> +the program context contains a pointer to a networking packet.  ``BPF_ABS``
> accesses packet data at an absolute offset specified by the immediate data
> and ``BPF_IND`` access packet data at an offset that includes the value of
> a register in addition to the immediate data.
> 
>  These instructions have seven implicit operands:
> 
> - * Register R6 is an implicit input that must contain pointer to a
> -   struct sk_buff.
> - * Register R0 is an implicit output which contains the data fetched from
> -   the packet.
> - * Registers R1-R5 are scratch registers that are clobbered after a call to
> -   ``BPF_ABS | BPF_LD`` or ``BPF_IND | BPF_LD`` instructions.
> -
> -These instructions have an implicit program exit condition as well. When an
> -eBPF program is trying to access the data beyond the packet boundary, the
> -program execution will be aborted.
> -
> -``BPF_ABS | BPF_W | BPF_LD`` means::
> -
> -  R0 = ntohl(*(u32 *) (((struct sk_buff *) R6)->data + imm32))
> -
> -``BPF_IND | BPF_W | BPF_LD`` means::
> -
> -  R0 = ntohl(*(u32 *) (((struct sk_buff *) R6)->data + src_reg + imm32))
> +* Register R6 is an implicit input that must contain a pointer to a
> +  context structure with a packet data pointer.
> +* Register R0 is an implicit output which contains the data fetched from
> +  the packet.
> +* Registers R1-R5 are scratch registers that are clobbered by the
> +  instruction.
> +
> +   **Note**
> +
> +   *Linux implementation*: In Linux, R6 references a struct sk_buff.
> +
> +These instructions have an implicit program exit condition as well. If an
> +eBPF program attempts access data beyond the packet boundary, the
> +program execution must be gracefully aborted.
> +
> +``BPF_ABS | BPF_W | BPF_LD`` (0x20) means::
> +
> +  R0 = ntohl(*(uint32_t *) (R6->data + imm))
> +
> +where ``ntohl()`` converts a 32-bit value from network byte order to host byte order.
> +
> +``BPF_IND | BPF_W | BPF_LD`` (0x40) means::
> +
> +  R0 = ntohl(*(uint32_t *) (R6->data + src + imm))
> +
> +Appendix
> +========
> +
> +For reference, the following table lists opcodes in order by value.
> +
> +======  ====  ===================================================  =============
> +opcode  imm   description                                          reference 
> +======  ====  ===================================================  =============
> +0x04    any   dst = (uint32_t)(dst + imm)                          `Arithmetic instructions`_
> +0x05    0x00  goto +offset                                         `Jump instructions`_
> +0x07    any   dst += imm                                           `Arithmetic instructions`_
> +0x0c    0x00  dst = (uint32_t)(dst + src)                          `Arithmetic instructions`_
> +0x0f    0x00  dst += src                                           `Arithmetic instructions`_
> +0x14    any   dst = (uint32_t)(dst - imm)                          `Arithmetic instructions`_
> +0x15    any   if dst == imm goto +offset                           `Jump instructions`_
> +0x16    any   if (uint32_t)dst == imm goto +offset                 `Jump instructions`_
> +0x17    any   dst -= imm                                           `Arithmetic instructions`_
> +0x18    any   dst = imm                                            `Load and store instructions`_
> +0x1c    0x00  dst = (uint32_t)(dst - src)                          `Arithmetic instructions`_
> +0x1d    0x00  if dst == src goto +offset                           `Jump instructions`_
> +0x1e    0x00  if (uint32_t)dst == (uint32_t)src goto +offset       `Jump instructions`_
> +0x1f    0x00  dst -= src                                           `Arithmetic instructions`_
> +0x20    any   dst = ntohl(\*(uint32_t \*)(R6->data + imm))         `Load and store instructions`_
> +0x24    any   dst = (uint32_t)(dst \* imm)                         `Arithmetic instructions`_
> +0x25    any   if dst > imm goto +offset                            `Jump instructions`_
> +0x26    any   if (uint32_t)dst > imm goto +offset                  `Jump instructions`_
> +0x27    any   dst \*= imm                                          `Arithmetic instructions`_
> +0x28    any   dst = ntohs(\*(uint16_t \*)(R6->data + imm))         `Load and store instructions`_
> +0x2c    0x00  dst = (uint32_t)(dst \* src)                         `Arithmetic instructions`_
> +0x2d    0x00  if dst > src goto +offset                            `Jump instructions`_
> +0x2e    0x00  if (uint32_t)dst > (uint32_t)src goto +offset        `Jump instructions`_
> +0x2f    0x00  dst \*= src                                          `Arithmetic instructions`_
> +0x30    any   dst = (\*(uint8_t \*)(R6->data + imm))               `Load and store instructions`_
> +0x34    any   dst = (uint32_t)(dst / imm)                          `Arithmetic instructions`_
> +0x35    any   if dst >= imm goto +offset                           `Jump instructions`_
> +0x36    any   if (uint32_t)dst >= imm goto +offset                 `Jump instructions`_
> +0x37    any   dst /= imm                                           `Arithmetic instructions`_
> +0x38    any   dst = ntohll(\*(uint64_t \*)(R6->data + imm))        `Load and store instructions`_
> +0x3c    0x00  dst = (uint32_t)(dst / src)                          `Arithmetic instructions`_
> +0x3d    0x00  if dst >= src goto +offset                           `Jump instructions`_
> +0x3e    0x00  if (uint32_t)dst >= (uint32_t)src goto +offset       `Jump instructions`_
> +0x3f    0x00  dst /= src                                           `Arithmetic instructions`_
> +0x40    any   dst = ntohl(\*(uint32_t \*)(R6->data + src + imm))   `Load and store instructions`_
> +0x44    any   dst = (uint32_t)(dst \| imm)                         `Arithmetic instructions`_
> +0x45    any   if dst & imm goto +offset                            `Jump instructions`_
> +0x46    any   if (uint32_t)dst & imm goto +offset                  `Jump instructions`_
> +0x47    any   dst \|= imm                                          `Arithmetic instructions`_
> +0x48    any   dst = ntohs(\*(uint16_t \*)(R6->data + src + imm))   `Load and store instructions`_
> +0x4c    0x00  dst = (uint32_t)(dst \| src)                         `Arithmetic instructions`_
> +0x4d    0x00  if dst & src goto +offset                            `Jump instructions`_
> +0x4e    0x00  if (uint32_t)dst & (uint32_t)src goto +offset        `Jump instructions`_
> +0x4f    0x00  dst \|= src                                          `Arithmetic instructions`_
> +0x50    any   dst = \*(uint8_t \*)(R6->data + src + imm))          `Load and store instructions`_
> +0x54    any   dst = (uint32_t)(dst & imm)                          `Arithmetic instructions`_
> +0x55    any   if dst != imm goto +offset                           `Jump instructions`_
> +0x56    any   if (uint32_t)dst != imm goto +offset                 `Jump instructions`_
> +0x57    any   dst &= imm                                           `Arithmetic instructions`_
> +0x58    any   dst = ntohll(\*(uint64_t \*)(R6->data + src + imm))  `Load and store instructions`_
> +0x5c    0x00  dst = (uint32_t)(dst & src)                          `Arithmetic instructions`_
> +0x5d    0x00  if dst != src goto +offset                           `Jump instructions`_
> +0x5e    0x00  if (uint32_t)dst != (uint32_t)src goto +offset       `Jump instructions`_
> +0x5f    0x00  dst &= src                                           `Arithmetic instructions`_
> +0x61    0x00  dst = \*(uint32_t \*)(src + offset)                  `Load and store instructions`_
> +0x62    any   \*(uint32_t \*)(dst + offset) = imm                  `Load and store instructions`_
> +0x63    0x00  \*(uint32_t \*)(dst + offset) = src                  `Load and store instructions`_
> +0x64    any   dst = (uint32_t)(dst << imm)                         `Arithmetic instructions`_
> +0x65    any   if dst s> imm goto +offset                           `Jump instructions`_
> +0x66    any   if (int32_t)dst s> (int32_t)imm goto +offset         `Jump instructions`_
> +0x67    any   dst <<= imm                                          `Arithmetic instructions`_
> +0x69    0x00  dst = \*(uint16_t \*)(src + offset)                  `Load and store instructions`_
> +0x6a    any   \*(uint16_t \*)(dst + offset) = imm                  `Load and store instructions`_
> +0x6b    0x00  \*(uint16_t \*)(dst + offset) = src                  `Load and store instructions`_
> +0x6c    0x00  dst = (uint32_t)(dst << src)                         `Arithmetic instructions`_
> +0x6d    0x00  if dst s> src goto +offset                           `Jump instructions`_
> +0x6e    0x00  if (int32_t)dst s> (int32_t)src goto +offset         `Jump instructions`_
> +0x6f    0x00  dst <<= src                                          `Arithmetic instructions`_
> +0x71    0x00  dst = \*(uint8_t \*)(src + offset)                   `Load and store instructions`_
> +0x72    any   \*(uint8_t \*)(dst + offset) = imm                   `Load and store instructions`_
> +0x73    0x00  \*(uint8_t \*)(dst + offset) = src                   `Load and store instructions`_
> +0x74    any   dst = (uint32_t)(dst >> imm)                         `Arithmetic instructions`_
> +0x75    any   if dst s>= imm goto +offset                          `Jump instructions`_
> +0x76    any   if (int32_t)dst s>= (int32_t)imm goto +offset        `Jump instructions`_
> +0x77    any   dst >>= imm                                          `Arithmetic instructions`_
> +0x79    0x00  dst = \*(uint64_t \*)(src + offset)                  `Load and store instructions`_
> +0x7a    any   \*(uint64_t \*)(dst + offset) = imm                  `Load and store instructions`_
> +0x7b    0x00  \*(uint64_t \*)(dst + offset) = src                  `Load and store instructions`_
> +0x7c    0x00  dst = (uint32_t)(dst >> src)                         `Arithmetic instructions`_
> +0x7d    0x00  if dst s>= src goto +offset                          `Jump instructions`_
> +0x7e    0x00  if (int32_t)dst s>= (int32_t)src goto +offset        `Jump instructions`_
> +0x7f    0x00  dst >>= src                                          `Arithmetic instructions`_
> +0x84    0x00  dst = (uint32_t)-dst                                 `Arithmetic instructions`_
> +0x85    any   call imm                                             `Jump instructions`_
> +0x87    0x00  dst = -dst                                           `Arithmetic instructions`_
> +0x94    any   dst = (uint32_t)(dst % imm)                          `Arithmetic instructions`_
> +0x95    0x00  return                                               `Jump instructions`_
> +0x97    any   dst %= imm                                           `Arithmetic instructions`_
> +0x9c    0x00  dst = (uint32_t)(dst % src)                          `Arithmetic instructions`_
> +0x9f    0x00  dst %= src                                           `Arithmetic instructions`_
> +0xa4    any   dst = (uint32_t)(dst ^ imm)                          `Arithmetic instructions`_
> +0xa5    any   if dst < imm goto +offset                            `Jump instructions`_
> +0xa6    any   if (uint32_t)dst < imm goto +offset                  `Jump instructions`_
> +0xa7    any   dst ^= imm                                           `Arithmetic instructions`_
> +0xac    0x00  dst = (uint32_t)(dst ^ src)                          `Arithmetic instructions`_
> +0xad    0x00  if dst < src goto +offset                            `Jump instructions`_
> +0xae    0x00  if (uint32_t)dst < (uint32_t)src goto +offset        `Jump instructions`_
> +0xaf    0x00  dst ^= src                                           `Arithmetic instructions`_
> +0xb4    any   dst = (uint32_t) imm                                 `Arithmetic instructions`_
> +0xb5    any   if dst <= imm goto +offset                           `Jump instructions`_
> +0xa6    any   if (uint32_t)dst <= imm goto +offset                 `Jump instructions`_
> +0xb7    any   dst = imm                                            `Arithmetic instructions`_
> +0xbc    0x00  dst = (uint32_t) src                                 `Arithmetic instructions`_
> +0xbd    0x00  if dst <= src goto +offset                           `Jump instructions`_
> +0xbe    0x00  if (uint32_t)dst <= (uint32_t)src goto +offset       `Jump instructions`_
> +0xbf    0x00  dst = src                                            `Arithmetic instructions`_
> +0xc3    0x00  lock \*(uint32_t \*)(dst + offset) += src            `Atomic operations`_
> +0xc3    0x01  lock::                                               `Atomic operations`_
> +
> +                  *(uint32_t *)(dst + offset) += src
> +                  src = *(uint32_t *)(dst + offset)
> +0xc3    0x40  \*(uint32_t \*)(dst + offset) \|= src                `Atomic operations`_
> +0xc3    0x41  lock::                                               `Atomic operations`_
> +
> +                  *(uint32_t *)(dst + offset) |= src
> +                  src = *(uint32_t *)(dst + offset)
> +0xc3    0x50  \*(uint32_t \*)(dst + offset) &= src                 `Atomic operations`_
> +0xc3    0x51  lock::                                               `Atomic operations`_
> +
> +                  *(uint32_t *)(dst + offset) &= src
> +                  src = *(uint32_t *)(dst + offset)
> +0xc3    0xa0  \*(uint32_t \*)(dst + offset) ^= src                 `Atomic operations`_
> +0xc3    0xa1  lock::                                               `Atomic operations`_
> +
> +                  *(uint32_t *)(dst + offset) ^= src
> +                  src = *(uint32_t *)(dst + offset)
> +0xc3    0xe1  lock::                                               `Atomic operations`_
> +
> +                  temp = *(uint32_t *)(dst + offset)
> +                  *(uint32_t *)(dst + offset) = src
> +                  src = temp
> +0xc3    0xf1  lock::                                               `Atomic operations`_
> +
> +                  temp = *(uint32_t *)(dst + offset)
> +                  if *(uint32_t)(dst + offset) == R0
> +                     *(uint32_t)(dst + offset) = src
> +                  R0 = temp
> +0xc4    any   dst = (uint32_t)(dst s>> imm)                        `Arithmetic instructions`_
> +0xc5    any   if dst s< imm goto +offset                           `Jump instructions`_
> +0xc6    any   if (int32_t)dst s< (int32_t)imm goto +offset         `Jump instructions`_
> +0xc7    any   dst s>>= imm                                         `Arithmetic instructions`_
> +0xcc    0x00  dst = (uint32_t)(dst s>> src)                        `Arithmetic instructions`_
> +0xcd    0x00  if dst s< src goto +offset                           `Jump instructions`_
> +0xce    0x00  if (int32_t)dst s< (int32_t)src goto +offset         `Jump instructions`_
> +0xcf    0x00  dst s>>= src                                         `Arithmetic instructions`_
> +0xd4    0x10  dst = htole16(dst)                                   `Byte swap instructions`_
> +0xd4    0x20  dst = htole32(dst)                                   `Byte swap instructions`_
> +0xd4    0x40  dst = htole64(dst)                                   `Byte swap instructions`_
> +0xd5    any   if dst s<= imm goto +offset                          `Jump instructions`_
> +0xd6    any   if (int32_t)dst s<= (int32_t)imm goto +offset        `Jump instructions`_
> +0xc3    0x00  lock \*(uint64_t \*)(dst + offset) += src            `Atomic operations`_
   ^^^^
The opcode should be 0xdb as well

Otherwise,
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

> +0xdb    0x01  lock::                                               `Atomic operations`_
> +
> +                  *(uint64_t *)(dst + offset) += src
> +                  src = *(uint64_t *)(dst + offset)
> +0xdb    0x40  \*(uint64_t \*)(dst + offset) \|= src                `Atomic operations`_
> +0xdb    0x41  lock::                                               `Atomic operations`_
> +
> +                  *(uint64_t *)(dst + offset) |= src
> +                  lock src = *(uint64_t *)(dst + offset)
> +0xdb    0x50  \*(uint64_t \*)(dst + offset) &= src                 `Atomic operations`_
> +0xdb    0x51  lock::                                               `Atomic operations`_
> +
> +                  *(uint64_t *)(dst + offset) &= src
> +                  src = *(uint64_t *)(dst + offset)
> +0xdb    0xa0  \*(uint64_t \*)(dst + offset) ^= src                 `Atomic operations`_
> +0xdb    0xa1  lock::                                               `Atomic operations`_
> +
> +                  *(uint64_t *)(dst + offset) ^= src
> +                  src = *(uint64_t *)(dst + offset)
> +0xdb    0xe1  lock::                                               `Atomic operations`_
> +
> +                  temp = *(uint64_t *)(dst + offset)
> +                  *(uint64_t *)(dst + offset) = src
> +                  src = temp
> +0xdb    0xf1  lock::                                               `Atomic operations`_
> +
> +                  temp = *(uint64_t *)(dst + offset)
> +                  if *(uint64_t)(dst + offset) == R0
> +                     *(uint64_t)(dst + offset) = src
> +                  R0 = temp
> +0xdc    0x10  dst = htobe16(dst)                                   `Byte swap instructions`_
> +0xdc    0x20  dst = htobe32(dst)                                   `Byte swap instructions`_
> +0xdc    0x40  dst = htobe64(dst)                                   `Byte swap instructions`_
> +0xdd    0x00  if dst s<= src goto +offset                          `Jump instructions`_
> +0xde    0x00  if (int32_t)dst s<= (int32_t)src goto +offset        `Jump instructions`_
> +======  ====  ===================================================  =============
> -- 
> 2.32.0.windows.1
> 
