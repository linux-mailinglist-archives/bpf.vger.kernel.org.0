Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A936A233C
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 21:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBXUoP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 15:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBXUoO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 15:44:14 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA212F00
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 12:44:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS6AJNHshYpKQIdh3TklQRsovF4YoieET0pszWGkYAi1uK6/+XrPIFiLNfJ+p2Z3FoWcmaYThg/OWs0UBSgV6duUuUW63NQtpLtet459xkkhz91+GKuyfX9dCfoacAGvNti17D6/S8WquRO96YA8v/Th4nseRJwUbcLEgbURFCVYugZi6IHA0uNmaund9mGjQ9fGXxgW3K+n1RKcgrvaL0bScbRIiQ206FK/vTKVY6t8bIsfiF0avkp/HWmY33u+kc4rV9zam1lMllbNmcxrD7RGe7MLao2Ust6o7PT2uDfPKTX5Q69IZ5ilWmPf9sTsWmqEiUdZQDMDAnEDVze6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xzS4C60TSrY8pleyyAuC4inHGaP3sKq9qEColN+Q3g=;
 b=OHLtx1mbCkXOjzupkGenopggibJBAYFcRbd6PKREJja76moFquQ9kyBb1zFqqEL20eHHzO66Ua3bjjNlbI+GUFdTJr87Xu7KsVcGT2a70XKF9SZpPmgDtCuRoKHieTE00M1FLVt5mcJF225aSLEHuurUr0/q6OEoZ/WoNfTlf0B+jF1TTspz6H1aoNOA5L/kQ/ddRrGhR7k9zYb9fqUbX9qrXkC+8c6FubYfLsROBZ0cDIV6cmZaUBg+Sm89GMsJZ+97rDvwzbZ0k659+y26opK7mY9xLdmRxzuGy2Kwb/UIi0vK8QkbTCY0nd6ZMB0H8vs3K1DBX3TQU09CcMm/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xzS4C60TSrY8pleyyAuC4inHGaP3sKq9qEColN+Q3g=;
 b=WoQjrd9pKxeckVvHfMFSU3ZRtqoHvV+o5EPJUUy5BScPKQvGBIAz1JQ2VDgjKMhCqhMRNrKllAAcm25WC4J52UDt4e/TtCEyZ+zlItH8w8wAGVkhSniWCFjNECJG3nQOhUAyUqqZJyhfhsK38a0hOUZxIKSHzZFEmiUOLogRlNw=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by PH0PR21MB2005.namprd21.prod.outlook.com (2603:10b6:510:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.5; Fri, 24 Feb
 2023 20:44:10 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75%7]) with mapi id 15.20.6156.011; Fri, 24 Feb 2023
 20:44:10 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [Bpf] [PATCH] bpf, docs: Document BPF insn encoding in term of
 stored bytes
Thread-Topic: [Bpf] [PATCH] bpf, docs: Document BPF insn encoding in term of
 stored bytes
Thread-Index: AQHZSIsyp6fOjZBYSEih3KBdHGKDtq7ejzMQ
Date:   Fri, 24 Feb 2023 20:44:09 +0000
Message-ID: <PH7PR21MB3878B8C1197ACE5318E332A8A3A89@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <87y1om25l4.fsf@oracle.com>
In-Reply-To: <87y1om25l4.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6c7bd9c9-ebe7-4ad8-9ec9-75cfe358f199;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-24T20:39:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|PH0PR21MB2005:EE_
x-ms-office365-filtering-correlation-id: 71ea6242-52a9-4448-d4d3-08db16a7e15e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYgsmKzs09nECMishKAl6Hoq1Fn9BJa6If5SDGQV8/ZlF2eSIHgAmkzfNA1psUvbAWwnDTu1lrnpFSmPTzmCrX7sVXDsaGLobYH6e7Fn75Sq8u8fFOHO1a8FUj+qlcgFJO4h9H8/uupN5/ZIWuhSj2vzqvT8aDYNy7E7X9POfs7R7v6Ae8noHiIw5n7A8r2bH1rduYp5bp8afclSTb+Fvmi0De+5sRHmbBCwBOhxGPCB9pyUwpQdOalhjND8ODpjGuXPT7f+R0JbQJ7uHjI1xGy7z6QtUmY8f0Zd3ztaSKAV1aDVCRsUylayryUr5YAqIIaSMDsqo2NV+k25GGNpipx5yLxUxNg6WDDScR/6ofOz5NO8EKGGnyOdTJKLX2FFvJxGtrAKIjPNyKtBFuibynZGhyEXZ0Jz9XiZFtgHtQJKH+jaCCeAxby557qn4pSMVhnSw6g5q3oTw8h4Y9dVPUcoi4nf+t0P4Q/AWsW9//N3GSckw3LXan8St8FDq3D0AkFpKDZPEz7gm+SDecHsIz70kWWAh2phUnRZkR3VghVORFf8EX6epkuu+taSmXcNf1QkqMgNRF7bl1Fem0gNu+ACo1wdBIc+B/kzSqnIIaJd3nkawzv9da4Hmctje9B64JwQcUw3ld56SwZ3vSAXo1aR1YJ/IepSndnoTsL4cTQyHVylIRyrDEyPQ/YFJuWPOc6FI/3cuJEsZ4BhpPeW4v2ZeVumGPOs+qM6uJFXtjAH3R8RYYq2xfrP/KlEju6T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199018)(8676002)(8990500004)(26005)(66446008)(186003)(41300700001)(53546011)(4326008)(66476007)(54906003)(66946007)(76116006)(64756008)(10290500003)(66556008)(6506007)(9686003)(7696005)(316002)(478600001)(52536014)(5660300002)(122000001)(38100700002)(71200400001)(82960400001)(33656002)(82950400001)(110136005)(8936002)(38070700005)(2906002)(55016003)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LMXOyIVW/VWSrtNa6Hv9p+t958EJHFNYgPsyiKg8ezNbLCKOhVLMxHSLB6mv?=
 =?us-ascii?Q?IYojCQuKn1KCRW6n1TqTHHC2aEHi52EgHd4jROfd7jG9EtU2Nq6jKaAEL4Wx?=
 =?us-ascii?Q?1QkEKV3zKYoweX6o/BTG4lKGGifg9P6GtaeQHERF8S4SlwaHrvNzIZNGvlVR?=
 =?us-ascii?Q?A1mp1pYypk1cuL0bjBo6jsLHDGp04kWbUJpkM8SXUQuUI4LHzvilKd64axeY?=
 =?us-ascii?Q?IYwE5osNqRx93MZSZj3bHmz0qlO5rT4bKDb93HokLmSTX3IcDekKCoVadgdJ?=
 =?us-ascii?Q?JyVS8ZpVtiZAShigPbWj3CAFF/MSrDuMI5WReaZSUHhYSX2ctcTFYIYJQXpT?=
 =?us-ascii?Q?gduomnWQ7ChmQzMAdD2v7n5GEnyzKLvTM68a0fz6ZNuFb9y/VsjZ5oY9n2z9?=
 =?us-ascii?Q?vsc6MVsHDjq6xubYrgiSh1Lr9Cl9DNcS9/a050KzpPiBdR/5+CezOlcsd8JV?=
 =?us-ascii?Q?+j6vgW/8315wlvz1mCAoDYvk9xu3sIYMfbKZoqqwIiL1dmsiw82UViLgZ7V6?=
 =?us-ascii?Q?1RapQyFmNJadSG09aAyIhX0C+Od8Xq2WkjKIHLFlmugS/2zQjNLENkjy0sCg?=
 =?us-ascii?Q?i5SbhyFJpAXjBpssAreNY6aHHg8TxHFTaPXneRmPq1EGVv+z69Qv98FXX8dX?=
 =?us-ascii?Q?HA8mI/ZFOTg8kFm23LcObTL69fHQjZLRHONA3y3VUaNiCV9zB2CheWFk21QK?=
 =?us-ascii?Q?LJv0uRnVVGXivZQGKhE5dY8+Bdz8OA0iUaHY8ZbnkEjuKjqGGLrmC/poyScq?=
 =?us-ascii?Q?e85YhyyYtFS92hQYDk1LR2zW3Ejc7XXSDbihHYOeWPsCNXT/hEcx0p4mi4SX?=
 =?us-ascii?Q?N7MvDWnZViPwIthr49KszxVsP3KBPbf8DGqSp9PGAJ71UkM+ACnU8LBcRcYF?=
 =?us-ascii?Q?6qUUK/flN3/jSh/Ckg46uH2yN0KNWl+bWzVp027r6mBqyAlwkHaxI4J0i35a?=
 =?us-ascii?Q?5l3fxDgdJop0YuTw81r+wGXsCgT5jLANQQKGyOJF/+mR4kgtTp050ojmQunl?=
 =?us-ascii?Q?0AWwYhu7/19CyXLR5Dk6L+8gnZe6Gb6nnYgS80puc8FBX9tyaEPMb6E5XYih?=
 =?us-ascii?Q?6+uJtu3P+s/zcSKUljYzfDBe9xUM45Y8OjiPAFdzjV2bfCJem2OVYkKZosEi?=
 =?us-ascii?Q?m3CUAtNwJMqnU6OAvXrZA2h4hrbmwJ3Egm7/xUkxAvh6jjxBUgTu8IfsxgB3?=
 =?us-ascii?Q?GzrvkGBNKiUDoce+gRiOo56QnbcJ+uyAGxZmASyE/33Vp40qbnc3Wc+ZUBFu?=
 =?us-ascii?Q?PFKjFf+Xkyb5X3tysS5wvPfF4yKwG0ceEGuBsXSIduZRokhF+Z0NRyTE3FQ2?=
 =?us-ascii?Q?DZA3CVv7t38F5NY127jSbEZFEunl2pSjB4TLzZDLmGAnFjCnPFlBb81+zNhw?=
 =?us-ascii?Q?vklbsFOxsjN8EEvTKDSDixmCzN1hcCyaSYwjJ+ldrDRMKKzXCu+WlJB9VlO9?=
 =?us-ascii?Q?K0jzD71HnavELe1NceoAt2m17TQOm67GY9LXF2wfCXyYhNxB8hpVkAFD4a2o?=
 =?us-ascii?Q?V9GM0LGU0n2auLmTrx/TnSP3PcgKsTOtLc7Tw5NpkTMxQb4dqewt4C/J+vb9?=
 =?us-ascii?Q?/JtsLU3hSWukDfLTAMVRKn6Srxt8Q1CbCWbnHZ/FKmzDPnGQ4fdcO/Ut5d+1?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ea6242-52a9-4448-d4d3-08db16a7e15e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 20:44:09.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qfgbUUaMuHwvSwzVTkkbG/RUetYO4kMW77yNMQTahRAPzbzi4787gaDcKxqNuXn3ignPbavoL6mkljSiwKYetD3n+Nu3bXeAhtlT7eO+Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> -----Original Message-----
> From: Bpf <bpf-bounces@ietf.org> On Behalf Of Jose E. Marchesi
> Sent: Friday, February 24, 2023 12:04 PM
> To: bpf <bpf@vger.kernel.org>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>; bpf@ietf.org
> Subject: [Bpf] [PATCH] bpf, docs: Document BPF insn encoding in term of
> stored bytes
>=20
>=20
> This patch modifies instruction-set.rst so it documents the encoding of B=
PF
> instructions in terms of how the bytes are stored (be it in an ELF file o=
r as
> bytes in a memory buffer to be loaded into the kernel or some other BPF
> consumer) as opposed to how the instruction looks like once loaded.
>=20
> This is hopefully easier to understand by implementors looking to generat=
e
> and/or consume bytes conforming BPF instructions.
>=20
> The patch also clarifies that the unused bytes in a pseudo-instruction sh=
all be
> cleared with zeros.
>=20
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> ---
>  Documentation/bpf/instruction-set.rst | 43 +++++++++++++--------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
>=20
> diff --git a/Documentation/bpf/instruction-set.rst
> b/Documentation/bpf/instruction-set.rst
> index 01802ed9b29b..9b28c0e15bb6 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -38,15 +38,13 @@ eBPF has two instruction encodings:
>  * the wide instruction encoding, which appends a second 64-bit immediate
> (i.e.,
>    constant) value after the basic instruction for a total of 128 bits.
>=20
> -The basic instruction encoding looks as follows for a little-endian proc=
essor,
> -where MSB and LSB mean the most significant bits and least significant b=
its,
> -respectively:
> +The fields conforming an encoded basic instruction are stored in the
> +following order:
>=20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -imm            offset   src_reg  dst_reg  opcode
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.

Personally I find this notation harder to understand in general.
For example, it encodes (without explanation) the C language
assumption that "//" is a comment, ":" indicates a bit width,
and the fields are in order from most significate byte to least
significant byte.  The text before this change has no such
unexplained assumptions.=20

[...]
> -Multi-byte fields ('imm' and 'offset') are similarly stored in -the byte=
 order of
> the processor.
> +  opcode         offset imm          assembly
> +         src dst
> +  07     0   1   00 00  44 33 22 11  r1 +=3D 0x11223344 // little
> +         dst src
> +  07     1   0   00 00  11 22 33 44  r1 +=3D 0x11223344 // big

Similar assumption without explanation of "//" meaning comment, and
some implied tabular formatting without being an actual table?

[...]
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -64 bits (MSB)      64 bits (LSB)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -basic instruction  pseudo instruction
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This is depicted in the following figure:
> +
> +  basic_instruction                 pseudo_instruction
> +  code:8 regs:16 offset:16 imm:32 | unused:32 imm:32

And here the use of "|" above I find confusing.

What do others think?

Dave
