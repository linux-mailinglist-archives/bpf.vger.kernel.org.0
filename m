Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A045F4583
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 16:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJDOca (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJDOc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 10:32:29 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4354F670
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 07:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsU3M2TLBr2J4pE7dlMARSwhwfAunc7LHSyW410Xrf15ftJ1xvv3AW8YX0EMEjIAk497wPP/XZTVdskRXzmW8mJTPdCowud4dus9NklwCFRtTEpAbc1wkMdrrUeTy5u7Z3NoG4Ou0sayn/jO6Bh3VVaYnj45NiILsGcanmrkOAF313Negt/D2nhIhC9lROlnCHfAc1U1YyYD2q1Txh7XzJEhO1H5+EvEHmfYL4TK+d/y8g7LpgvNiw/5c6asJns+URnURgeGdZfhDD6DkqCamh/RIa3m2IZq4xYHZTmhjRK4xZHf7eLjl72bY1xOj0QqWtXEiSHvaPw72qltP0uZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kddNBlANfcODwWImO4gdYSGVXVm16zKEuYLlsuckVH8=;
 b=HY9amHknd4I5Sy8G3WjCFab7RRng6kvT22+4mUXC8Qrh1N7WrRBbhTjCPLYQRl3nbzu+49pyZcddkfkh3xXhGK8CaadXZjNNQubdURISLrw0YQZ1oaMGCyUCkoRvIZ/Cgjdox8SI6pJ2B7gWoOmmF2kvn4WKVP3U7dGsjdG9JMboqn3EQuXc5fcmjFxaCPg2cyBI2JIy+O6gX8+tvP++PIIqNZUwn3uiAlB3lgwa9Y04SIGjFynP+y0TM9nHK2biY7h2VzjSloUlyZX/1Ehw63cZylGY1D1wI6VRh3NjZEByKLqSKrdSdDEKV8DqpkQUIELyz7MAa4RLato8NUZuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kddNBlANfcODwWImO4gdYSGVXVm16zKEuYLlsuckVH8=;
 b=abqPUbFn1dOlHyuaGOUiYvdBWw3IS4OK3XEuQVkV+UAU3NmtAsfDKJQmzns33/nFZoz+tdRSi9ZHaMr69Hbe7LVAxOf1hDOXjbbJIUmPdV3PbfvjgbZHVMHRUfTMYljY/rtT/W8D5ZahdYwalgrcSuLpC2Olm88E9zH78992LOE=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 SJ1PR21MB3528.namprd21.prod.outlook.com (2603:10b6:a03:454::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.3; Tue, 4 Oct
 2022 14:32:24 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5723.008; Tue, 4 Oct 2022
 14:32:24 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Topic: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Index: AQHY0qNqv++jE8+E60q227lL8nNlGa34j0YAgAXGAWA=
Date:   Tue, 4 Oct 2022 14:32:24 +0000
Message-ID: <DM4PR21MB3440664B3010ECDDCF9731D1A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-11-dthaler1968@googlemail.com>
 <20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0a9a8824-3be3-4457-9f1e-0813f8a19eab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-04T14:26:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|SJ1PR21MB3528:EE_
x-ms-office365-filtering-correlation-id: dfff3f28-782c-42c1-92d4-08daa6154158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VECdZ8HfKRxrnmVRJnin5Hjh5UJ+sMOX1oFhrZDKCS//9B4+URgeJq5eOqogmwk95Ty36EA6JOBkEFnSXZBa/1fncdWwiicA7H69cQXDB+qz90oHQ/IzRZfcG5umY8PDucZHb8fwCZpcO6ZNXo6loJWDp1PucL5wngnQJtRxlCKCKXY0UZnxwbYL4Xm5WC6/geLX3dsNqU/aoGK/ksdn6lpfhgOCVpbXxKFcUCFxeJab9Nqz2iXDXMfqurS50wal4Kx3FMC17RYxK+lzt7cwv719RpgPW+C1U55WBnTTLUlbcfMnmgdL8vYLdw/6E/Mqp52fsZBfKkIIcwAOV4SXCd83q6B/Jrx9gkmcdMHQmFdhL+QIjWvYgDFDGhe2+K9+lTMHDL2jdUtT+HkLjq5+alH1NriXO7HzxDtwWejHQg+38aX6SG7ZpuzrRjGkoNe2RUxppQoRzHyoGXkCTblSQ9tvM2Sk8x8O5f733ZjD8OZtd3YZNHwJwqdXJ10gvUDbtRLzfGjDiPK5eU0XU9VFEdqW7vBFO7gXhUNLxP9T1Hp/n8L/MbG2KdQefUJR0I8vUizFFysxznY+uJiZt1stef8tkbaBeirxlA9a6ERcF+NYpGMC/RpI0H3ko8rbHA5SZTghKAi+67tt5MDfVrsHbpi/tkXzCPf4A0+K++ezc7qgrQuvnSkyYS4b+KilpWdE/BiSMc+q67QV9ADmY+Hp7fwugmjYgtjXTGhhUh+3o5W+HQp6a4TtFmdeoNKi/Pl5ipYUQBDv5/93GsdRExFrmG+14rWEJRgB/n1qgy85wXxGxuaI10yKPwc/VA8ZR+C5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199015)(2906002)(8990500004)(316002)(64756008)(66946007)(76116006)(8676002)(4326008)(33656002)(66476007)(66446008)(8936002)(41300700001)(10290500003)(66556008)(71200400001)(110136005)(478600001)(7696005)(5660300002)(26005)(9686003)(6506007)(86362001)(82960400001)(52536014)(38070700005)(55016003)(122000001)(82950400001)(83380400001)(186003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dOGzeaZO3AGuH4JFdG6e7YhZqYR60JaAERuKUaGpewGlEBFLhYOtGLmRKYOY?=
 =?us-ascii?Q?Ru3uaEeFgeN5S3WMr57YnguMoeP4q1sLhZfV0aTrGTDxipzGKWLAIk5p9Jh+?=
 =?us-ascii?Q?W1dw/9+IG4cy5GAKNK2cIfy4imU11tr4DwQRNphjYMBcvuIW9MqOvBVo9XM5?=
 =?us-ascii?Q?ajtwSKy7QRkH1dPz1rOBWE+EvBV+8e8EhY0NSSV4SsEfIMBpzTeTERu7hDEI?=
 =?us-ascii?Q?9jU7K2NB5IMMVgsCNUiyhEt1XV0USfy8FTcj7fePzVaBfqG2YUUah6TK9/5o?=
 =?us-ascii?Q?u0AH+Vq7a+UzNYlHqkf7ep1lo41Ys7BUCIebM/gLnByETt0HfdmP5In0od3D?=
 =?us-ascii?Q?eclDVMR8pOaeh58WjSaJVbQ5l0lrXCgpRzdodeFei/DuqQOhu2ZJcryoUNQm?=
 =?us-ascii?Q?x3yxJM53Q1zGCxj/ztyV+O/mw7nSc/RPHxHVS5iURxAIJEztvQmbx2ri/ZVM?=
 =?us-ascii?Q?mrDTFGHq45oYC7g50pTKQ0g4AethJHEijP31PXPl6aFHix5bXW5U+HalxMVI?=
 =?us-ascii?Q?xp9lcPWuQfxEcoqoLtlQWnoDQVZehjU4EdXeayAXIpE6P9N8zAMKt3SoHY6u?=
 =?us-ascii?Q?GkVOAeeEj2Qr2AwZoHbzlbVn5Ab6b502JKkcPLqzhecQ3CdXirh3NS3fecJq?=
 =?us-ascii?Q?auj+0p1N371Mrd+KgRARElRg/yf8uJ1xSybRXna6cFmPb5sekv6DUp48QGHt?=
 =?us-ascii?Q?ZsPD2hhBadcKdSuRaLcdEBX42+/D+dcx8WBRh4geKlf79rVBVnerPxuShmNc?=
 =?us-ascii?Q?y2WZw6Kf/fhawT1fK9suvnAveTmAu7xOEWnkLcuCpZlBGzmiC2P0ugR1kZmn?=
 =?us-ascii?Q?KgSED/g8gwCRs1oGOLg1OJKrix2Lxw4FZF8/Lrv/9Uu9Sg9KAG+Ik0jXva//?=
 =?us-ascii?Q?0T39UE07rItW1WXkXvam0jCQ+avlrlvvbSO65vlWau93HqUhRXp4nY4SwFe0?=
 =?us-ascii?Q?1wGrtQ/HG9vSYNdnicUFBciYfcGFn7z2w0ZGz3NEh+mJqCVKkuLKcUFOyhty?=
 =?us-ascii?Q?IFrui0LSaavy5eUhmVUCMVvshzE0dkYBXh7HWctBCPJv8g84swKINjO9unSS?=
 =?us-ascii?Q?OOGrftr1bUfYy9EDrHPZWxFpchACfaOSkIxe07qY/d851R0/gfNdaZePBSyl?=
 =?us-ascii?Q?5SvzlGb3xoMc6/Xr2H2QQgtlZoVzlnV+Bo1WSXU1KsBi1+Pj+6/4XWGaF6nT?=
 =?us-ascii?Q?8VW5hnGcL6Qjlwap0Ot5B9g56igWYDt0EXjN31PnTgvCDEQGhHcm3TVOvDxa?=
 =?us-ascii?Q?XrOSoUd9UQuARLaHRDM2qMtgrd4r7F8yTb+TIaz5mB9S9yY1GkMrQqbEpJeG?=
 =?us-ascii?Q?C4OYu7A0exAIsoDKA8M/EnTq5/YvNH7ICgb/v4yFj2KrKR/3X0PiNQNjI/N1?=
 =?us-ascii?Q?EH2ovCtlQYyjtWWtOYW4jc9OMXCKG7YNjvoXMwxj5q65/R08vrXzqdx5xIp0?=
 =?us-ascii?Q?9+rrq732smQzsVV6ne4gtJdN4uvvJvFrDj4T6/1lS8mE6keA/acpRMTUVPI8?=
 =?us-ascii?Q?PZ5XTwGxIM/T+SeMh4m5Q7p18k7f6JlaXKtwPFzsJ3calLgm6K4BgN20OpDt?=
 =?us-ascii?Q?qOGJv63G/cyqcKLJ3HkAqQ0GrSZamtrlpdWr3XJG33/7kVs+GVE+FdvY8KiD?=
 =?us-ascii?Q?9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfff3f28-782c-42c1-92d4-08daa6154158
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 14:32:24.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eaYfn9qwaeXYdzoUwJUZ6ZSKGWd1iLs/J3TkLZoAq90wsLTxULZBMZSNqzx3dztlfTHSYFW36dZv2zJTW6hmodoJ8ggSlrCUMODZv+FNpkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3528
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > +The eBPF instruction set consists of eleven 64 bit registers, a
> > +program counter, and 512 bytes of stack space.
>=20
> I would not add 512 to a doc.
> That's what we have now, but we might relax that in the future.

I think it's important to at least give a minimum.  Will change to
"at least 512".

[...]
> > +Registers R0 - R5 are scratch registers, meaning the BPF program
> > +needs to either spill them to the BPF stack or move them to callee
> > +saved registers if these arguments are to be reused across multiple
> > +function calls. Spilling means that the value in the register is
> > +moved to the BPF stack. The reverse operation of moving the variable
> from the BPF stack to the register is called filling.
> > +The reason for spilling/filling is due to the limited number of regist=
ers.
>=20
> More canonical way would be to say that r0-r5 are caller saved.

Will change "scratch" to "caller-saved"

[...]
> > -``BPF_ADD | BPF_X | BPF_ALU64`` means::
> > +``BPF_ADD | BPF_X | BPF_ALU64`` (0x0f) means::
>=20
> I don't think adding hex values help here.

I found it very helpful in verifying that the Appendix table
was correct, and providing a correlation to the text here
that shows the construction of the value.  So I'd like to keep them.

[...]
> > -The 1-bit source operand field in the opcode is used to to select
> > what byte -order the operation convert from or to:
> > +Byte swap instructions use non-default semantics of the 1-bit
> > +'source' field in
>=20
> I would drop 'non-default'. Many fields have different meanings depending
> on opcode.
> BPF_SRC() macro just reads that bit.

Will reword to say:
Byte swap instructions use the 1-bit 'source' field in the 'opcode' field
as follows.  Instead of indicating the source operator, it is instead
used to select what byte order the operation converts from or to:

[...]
> > +* mnenomic indicates a short form that might be displayed by some
> > +tools such as disassemblers
> > +* 'htoleNN()' indicates converting a NN-bit value from host byte
> > +order to little-endian byte order
> > +* 'htobeNN()' indicates converting a NN-bit value from host byte
> > +order to big-endian byte order
>=20
> I think we need to add normal bswap insn.
> These to_le and to_be are very awkward to use.
> As soon as we have new insn the compiler will be using it.
> There is no equivalent of to_be and to_le in C. It wasn't good ISA design=
.

I will interpret this as a request for someone to do code work, rather
than any request for immediately changes to the doc :)

[...]
> >  Regular load and store operations
> >  ---------------------------------
> >
> >  The ``BPF_MEM`` mode modifier is used to encode regular load and
> > store  instructions that transfer data between a register and memory.
> >
> > -``BPF_MEM | <size> | BPF_STX`` means::
> > -
> > -  *(size *) (dst + offset) =3D src_reg
> > -
> > -``BPF_MEM | <size> | BPF_ST`` means::
> > -
> > -  *(size *) (dst + offset) =3D imm32
> > -
> > -``BPF_MEM | <size> | BPF_LDX`` means::
> > -
> > -  dst =3D *(size *) (src + offset)
> > -
> > -Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +opcode construction            opcode     pseudocode
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +BPF_MEM | BPF_B | BPF_LDX      0x71       dst =3D \*(uint8_t \*) (src =
+ offset)
> > +BPF_MEM | BPF_H | BPF_LDX      0x69       dst =3D \*(uint16_t \*) (src=
 +
> offset)
> > +BPF_MEM | BPF_W | BPF_LDX      0x61       dst =3D \*(uint32_t \*) (src=
 +
> offset)
> > +BPF_MEM | BPF_DW | BPF_LDX     0x79       dst =3D \*(uint64_t \*) (src=
 +
> offset)
> > +BPF_MEM | BPF_B | BPF_ST       0x72       \*(uint8_t \*) (dst + offset=
) =3D imm
> > +BPF_MEM | BPF_H | BPF_ST       0x6a       \*(uint16_t \*) (dst + offse=
t) =3D
> imm
> > +BPF_MEM | BPF_W | BPF_ST       0x62       \*(uint32_t \*) (dst + offse=
t) =3D
> imm
> > +BPF_MEM | BPF_DW | BPF_ST      0x7a       \*(uint64_t \*) (dst + offse=
t) =3D
> imm
> > +BPF_MEM | BPF_B | BPF_STX      0x73       \*(uint8_t \*) (dst + offset=
) =3D src
> > +BPF_MEM | BPF_H | BPF_STX      0x6b       \*(uint16_t \*) (dst + offse=
t) =3D
> src
> > +BPF_MEM | BPF_W | BPF_STX      0x63       \*(uint32_t \*) (dst + offse=
t) =3D
> src
> > +BPF_MEM | BPF_DW | BPF_STX     0x7b       \*(uint64_t \*) (dst + offse=
t) =3D
> src
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I think the table is more verbose and less readable than the original tex=
t.

Will change back to original text.

Dave
