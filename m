Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787E66A4D8D
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjB0VtW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Feb 2023 16:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB0VtV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:49:21 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1942D1ACE5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:49:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwiqr5ol2/utJ8zXeRzs6bbR1RhrPOzY94rXutswE1JxRdvDeIlLsqE2kf6uX3F1hnFmiFjee3EHb1hB1m85tj5FvPBBqRrFEvbdgJRy/EYol50rogd8kwxcq67qtNfHX1gBZLAnsdr6QkpkjknWjrMV2mNv1Z9r9eMu+Y2pjjzivbLCrqe7JgHpVrv0DbB3VYXH/yYDkH0el4jMTai0w/5nSpP6D07MwCxaQuPp19JqjtAbd4C2LX3P9JFceKUzUgxUhwJL/i04rkIAfnn0rHG3EgpJ959bLrbFduRGXePpCTge47MK34jcj77LikwjkgR9YKNKyVYVNPa73O/yHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B3OyxQzLc1OxPNpotWN22J5BEf38/OYVA7GG2atdLQ=;
 b=fiFFdnay1wn6SA/OLiQVaAv2+oxgng5IGQBLmPLKcJf6txqmTpKQwKzEmhMLYeb2RcpSK+DWex9nLgnEiKNzUJgbv8Zp0GZ9f5odVUwhPW/3RSWYmFF2ri51ApgClKoIAArsDEa8CJ5/9lq+Dus+ocs5Y1GEoINTyWb3B3uW1MIRqEhKJe5l5ovkXKCvXzRRAb0vUz7pKnhZr0J0mYdia3HVuk77LdA1emIm+EXl3hqxuAw0+HHDyNnRSLREDKIxU4UjTKaL9ujpAufgm6K+8XQDxMoOhbhkj5Z8nHm7rMhVRQ5c8J3Fg+5M+ptKA/C7dkVvtDlAtYy1DBVtfXLPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by IA1PR21MB3475.namprd21.prod.outlook.com (2603:10b6:208:3e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.2; Mon, 27 Feb
 2023 21:49:15 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75%6]) with mapi id 15.20.6178.004; Mon, 27 Feb 2023
 21:49:15 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "bpf@ietf.org" <bpf@ietf.org>, David Vernet <void@manifault.com>
Subject: RE: [Bpf] [PATCH V3] bpf, docs: Document BPF insn encoding in term of
 stored bytes
Thread-Topic: [Bpf] [PATCH V3] bpf, docs: Document BPF insn encoding in term
 of stored bytes
Thread-Index: AQHZSu9U6DOvMuxo7kiJag5inonkqK7jVBzQ
Date:   Mon, 27 Feb 2023 21:49:15 +0000
Message-ID: <PH7PR21MB3878F2AF288BE7671D61E257A3AF9@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <877cw295u8.fsf@oracle.com>
In-Reply-To: <877cw295u8.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1440e9d1-43b3-4171-b3df-97af6266bcde;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-27T21:46:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|IA1PR21MB3475:EE_
x-ms-office365-filtering-correlation-id: 96065274-6cba-4eea-4fad-08db190c787f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lRNP8gVLD4WXKkdZhXs0S2wu/zKDT9WIOxywyS+NYjh6eKAZGOPzs7B0Nx4abZCok6eHYhYu625UwyFG44JFRml87zVY7HvAukQX7IOq5uEXTOzC5dWlUWa/CRPnG6N2jf3ajnmfkmDtJx9lx/k5/w9EJmK8YWCuTMN4ACbq9Ib5wezcbimsxBIyzQ/1JCeIbACmkC2LX5utETuZR+WovMcnsvmChqnWFDtuT75Ha0qkCeb9n+3Fx4CywsRf9B0nzAva9jtuJrd1PuovfGcZGdbZ8tAQdWjGI43cfEIDLGEZiPGj6BEKcoOK2BIXbcjjKeEdXnK/k3MsKTAu/DxbzubQFXUB7QhJf/Mo5pOBlBzmzcIN3uf2DouBNi2DAKvzLvrV35BmoeOYhRZhiyk/2d4s+JnMe0vnjAoT0d+xzs510bL+ECiFkn+t4EqE/lAiQiThuGHtOxGQwR6nsfIqSQGxcIHFnMSIV/HIX5mmuDnn24XtJfMHYFNlARJwyENrmCKC6rXB3vDWeldCHDflAPgyQiRgM0tT0ZN5hy6U/LpoUnfOb0NQ/c6rG5TjVDpOfCaxqM9zH2zo8qOa9tiES38w6NXeppQnz9n6zkkq0l+5rgxglE7OTWTlcUGDxSHklO412cptCSbHhZzF0viYaNohMcb9ClGUxdKy8YbUo+6ZpLT16i8puKgcYdjr693juUjC034hY/OmHxnBK2bStP/8B7yzTXNHoYOIgrhDelULF6K4jNxIT7EiE1hH/Wp+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(38070700005)(52536014)(66946007)(966005)(86362001)(66556008)(316002)(66476007)(66446008)(33656002)(55016003)(54906003)(71200400001)(110136005)(7696005)(478600001)(64756008)(10290500003)(6506007)(41300700001)(9686003)(4326008)(76116006)(186003)(8676002)(53546011)(2906002)(8990500004)(82950400001)(82960400001)(38100700002)(8936002)(5660300002)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rDmpDOQF0KdCHDjJP2V4gS8u1XCepUT+JFjYVB6Th0VBaeuKLLmQrYUy8D00?=
 =?us-ascii?Q?S1cOTm99K+h/mvr7dmAVjPbM92Z1d1IE+JtkZt/c3qcts3EYlRiVgdd35+6l?=
 =?us-ascii?Q?4EH6TDLJII4ZgXQd3FBH48uz8ygk/eXDNKYFPDxYgnC1sUxfXdhiyHD/1b4i?=
 =?us-ascii?Q?CIMNkh3ETrmw61VPbkOqQ4XMrHMf4Y3qEc2guSSXbR5YaHS8oCGE9a51VxZU?=
 =?us-ascii?Q?jiX08G4Gr+6AZkoYflgsoOsF/3AQ98zgkIUF0MHPnQfv3f8Xu+ka9TgmiBSl?=
 =?us-ascii?Q?HM6yiTz2NwoSRDMrouuK8JStLwydS2r3t9qZv+71FPi82AgY+r+/U07lU6Je?=
 =?us-ascii?Q?MXxpIXjdBaljatVC8kSG6fPPm6yQhGqC9+NlrF5Ims+kD6MX+0ltZ4nCV/SZ?=
 =?us-ascii?Q?tN5zfX7h8gY+9uZIx2o9TcYpan/DGL4VNvUgqXOXidV/pBfvzEQOfEn29J9l?=
 =?us-ascii?Q?DFGOLYjNhgyQBkyEMCpejJiIk7j31k+trb0yc2M/Y4zyseOd4e/NTJFmyAV8?=
 =?us-ascii?Q?RyXaq4NHSfoD0HfTgDDQ0AxpzPM+hzolC86veKeoceOJCJQWdY1NWzIW2mXp?=
 =?us-ascii?Q?oB68CPs1eTNdwKMEy4UxODiF4MTKRkczjJRTNiLGuzxOsbAezj3JrYq1pIZO?=
 =?us-ascii?Q?cH/XbbR0uxlmvRPNTK3Y+uiwUpRe8TUPT0CqZFpap5Cg1Dlfvowr7MQxZukG?=
 =?us-ascii?Q?yAeTTAlgiN0mjKsQ1D0FBfU/rnUUGleHoxeWvE7RLlNpmhwr4qHMvW47yZC7?=
 =?us-ascii?Q?7DCygMYj4wSKLjEO5d8MsJ5x0QKbXQE63x2d+XaB5lYsmJxdBRY7nTsoADo7?=
 =?us-ascii?Q?PBSozO1VCfa49E8lo25cq9CD468I5C1GcSR9GEAbs+W0Bga1O9WnqbK/Eb14?=
 =?us-ascii?Q?DBxNE7R2nMzYOieAiZcURUyB6fA5MuKUWKzZ8EtiR8P0XHn6rRs6njGKyGFJ?=
 =?us-ascii?Q?DbbgKrZLCr1tEAsnV3Auk/5XW2ZJG/0PqSiMbG5Pu+zsCxmPS4ksJ2EKhdPR?=
 =?us-ascii?Q?Mzvx1HiKrABdnziQQBYisrnJswaQ2x7zChvY1DlligMfO3DyXKq6VFR0ZSAI?=
 =?us-ascii?Q?ikLvCkOe7MR3xylnGtK3OeQqVxeutMPDIaPscdqwqk9pLXeMGMFF5cAOEaIi?=
 =?us-ascii?Q?FRYn8FmRFX4rOle5pkNDgtXrirpFhqZ3sKazihCiS6YbQ1KrRhITD4Om1Lka?=
 =?us-ascii?Q?MWe5VFZUqWM15JNcNwz2LACbKFRLRM7eQ8pXYpmfUtkdNTfiHl1b2eqs9DDG?=
 =?us-ascii?Q?/0bm0TXjabPPgzy0azymYcJgMKNXSHB4dxfWjueXCKOt9BnKE7jimI71v/St?=
 =?us-ascii?Q?ByiiOhnlNwyGt1KgS83aIfGku0GrtCXRAUGQvgBfMBOkf5Wux3jXPn0VX/rO?=
 =?us-ascii?Q?NOf8yqDMfkj91h7jdbJW9kzpO56oWA+uda9PjmeNS3mA7gs1IHDAviqtHGbk?=
 =?us-ascii?Q?62sXW/pRmxmReHH6RYMcvVhEESCzQECiswDBUzmYrqhN9F+sJGQKoOik4Svk?=
 =?us-ascii?Q?c6pE+k3JsiaXkWF8ftmRLG4up3bVFI4jVM+HKbtfvA2sT/n8EwVQPIx7t+0c?=
 =?us-ascii?Q?sA6ThyDyPUKSV3xHFXMLwRQ6tYzSApg5paaldih2NznzRyxweIxcD00rfQHH?=
 =?us-ascii?Q?2gUTzVaR8STuWOrgr59pSdzXQ9JXX84pWY2gKOL/B1Ji9YmYDwrXnqlJXtVs?=
 =?us-ascii?Q?qgFPRw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96065274-6cba-4eea-4fad-08db190c787f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 21:49:15.4812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pu5xyJjrXxG5qPLrNQ/D06Qdrw8m5JjkHZPY3uZS8PPF9vsFIJ2LtyRUIJXenzkkyr0CEPdJYMFcNoIJ9msk9bTHGkvHn+FdcR4oNVzL6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3475
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> -----Original Message-----
> From: Bpf <bpf-bounces@ietf.org> On Behalf Of Jose E. Marchesi
> Sent: Monday, February 27, 2023 1:06 PM
> To: bpf <bpf@vger.kernel.org>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>; bpf@ietf.org; David
> Vernet <void@manifault.com>
> Subject: [Bpf] [PATCH V3] bpf, docs: Document BPF insn encoding in term of
> stored bytes
> 
> 
> [Changes from V2:
> - Use src and dst consistently in the document.

Since my earlier patch, src and dst refer to the values whereas
src_reg and dst_reg refer to register numbers.

> - Use a more graphical depiction of the 128-bit instruction.
> - Remove `Where:' fragment.
> - Clarify that unused bits are reserved and shall be zeroed.]
> 
> This patch modifies instruction-set.rst so it documents the encoding of BPF
> instructions in terms of how the bytes are stored (be it in an ELF file or as
> bytes in a memory buffer to be loaded into the kernel or some other BPF
> consumer) as opposed to how the instruction looks like once loaded.
> 
> This is hopefully easier to understand by implementors looking to generate
> and/or consume bytes conforming BPF instructions.
> 
> The patch also clarifies that the unused bytes in a pseudo-instruction shall be
> cleared with zeros.
> 
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> ---
>  Documentation/bpf/instruction-set.rst | 63 ++++++++++++++-------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst
> b/Documentation/bpf/instruction-set.rst
> index 01802ed9b29b..fae2e48d6a0b 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -38,15 +38,11 @@ eBPF has two instruction encodings:
>  * the wide instruction encoding, which appends a second 64-bit immediate
> (i.e.,
>    constant) value after the basic instruction for a total of 128 bits.
> 
> -The basic instruction encoding looks as follows for a little-endian processor,
> -where MSB and LSB mean the most significant bits and least significant bits,
> -respectively:
> +The fields conforming an encoded basic instruction are stored in the
> +following order::
> 
> -=============  =======  =======  =======  ============
> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> -=============  =======  =======  =======  ============
> -imm            offset   src_reg  dst_reg  opcode
> -=============  =======  =======  =======  ============
> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.

I think those should be src_reg and dst_reg (as the register numbers)
not src and dst (which are the values) or this will be a documentation
regression.

Right now I think this is a regression since if I understand right, with this
patch, "src" and "dst" now refer to both in different places which is
confusing.

Dave

>  **imm**
>    signed integer immediate value
> @@ -54,48 +50,55 @@ imm            offset   src_reg  dst_reg  opcode
>  **offset**
>    signed integer offset used with pointer arithmetic
> 
> -**src_reg**
> +**src**
>    the source register number (0-10), except where otherwise specified
>    (`64-bit immediate instructions`_ reuse this field for other purposes)
> 
> -**dst_reg**
> +**dst**
>    destination register number (0-10)
> 
>  **opcode**
>    operation to perform
> 
> -and as follows for a big-endian processor:
> +Note that the contents of multi-byte fields ('imm' and 'offset') are
> +stored using big-endian byte ordering in big-endian BPF and
> +little-endian byte ordering in little-endian BPF.
> 
> -=============  =======  =======  =======  ============
> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> -=============  =======  =======  =======  ============
> -imm            offset   dst_reg  src_reg  opcode
> -=============  =======  =======  =======  ============
> +For example::
> 
> -Multi-byte fields ('imm' and 'offset') are similarly stored in -the byte order of
> the processor.
> +  opcode         offset imm          assembly
> +         src dst
> +  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
> +         dst src
> +  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
> 
>  Note that most instructions do not use all of the fields.
>  Unused fields shall be cleared to zero.
> 
> -As discussed below in `64-bit immediate instructions`_, a 64-bit immediate -
> instruction uses a 64-bit immediate value that is constructed as follows.
> -The 64 bits following the basic instruction contain a pseudo instruction -
> using the same format but with opcode, dst_reg, src_reg, and offset all set to
> zero, -and imm containing the high 32 bits of the immediate value.
> +As discussed below in `64-bit immediate instructions`_, a 64-bit
> +immediate instruction uses a 64-bit immediate value that is constructed
> +as follows.  The 64 bits following the basic instruction contain a
> +pseudo instruction using the same format but with opcode, dst, src, and
> +offset all set to zero, and imm containing the high 32 bits of the
> +immediate value.
> 
> -=================  ==================
> -64 bits (MSB)      64 bits (LSB)
> -=================  ==================
> -basic instruction  pseudo instruction
> -=================  ==================
> +This is depicted in the following figure::
> +
> +        basic_instruction
> +  .-----------------------------.
> +  |                             |
> +  code:8 regs:16 offset:16 imm:32 unused:32 imm:32
> +                                  |              |
> +                                  '--------------'
> +                                 pseudo instruction
> 
>  Thus the 64-bit immediate value is constructed as follows:
> 
>    imm64 = (next_imm << 32) | imm
> 
>  where 'next_imm' refers to the imm value of the pseudo instruction -
> following the basic instruction.
> +following the basic instruction.  The unused bytes in the pseudo
> +instruction are reserved and shall be cleared to zero.
> 
>  Instruction classes
>  -------------------
> @@ -137,7 +140,7 @@ code            source  instruction class
>    source  value  description
>    ======  =====  ==============================================
>    BPF_K   0x00   use 32-bit 'imm' value as source operand
> -  BPF_X   0x08   use 'src_reg' register value as source operand
> +  BPF_X   0x08   use 'src' register value as source operand
>    ======  =====  ==============================================
> 
>  **instruction class**
> --
> 2.30.2
> 
> --
> Bpf mailing list
> Bpf@ietf.org
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww
> .ietf.org%2Fmailman%2Flistinfo%2Fbpf&data=05%7C01%7Cdthaler%40micro
> soft.com%7C65d83bf2fe834f73f84908db19067400%7C72f988bf86f141af91ab
> 2d7cd011db47%7C1%7C0%7C638131287757978381%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=8il1%2B8I1T8GBqn3U%2B7YJehIKjS6s
> gvxTRWS2CTpg%2FZY%3D&reserved=0
