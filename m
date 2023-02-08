Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82268F609
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 18:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjBHRsn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 12:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjBHRsX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 12:48:23 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63102521EC
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 09:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk5kc1dANOeSzb5f/rqZuU1PY9TIh3VRGPOOInIY/tMbwKu76YehKoXYMX5fdSMDBh3R0U4ATn2HgdhZkUwaEc1cT/U8Dm0/vLhxKVMtFn4F4FYTQldvV5CDI2Cy58xmNi5ByjIrHvydDOiF78R79UimGOnTCWVhKtccGtCZ1E/icfDRA3/Xi5eG4j26DFqVM0t0s7bZ+vUSRWAS2XqXJ59f5VHrvtWwR2Hydi6oeAfb2AuC7KQw9afwaUAHLQ1LrztpifowXNySmTuvulZvKnzJfkwGGsyW01UM3Chd0n14NB6fEBmk84AOAydTzRh1Ft1gEW6RheN4fycUlb/uSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH9I57HbtKqq97p093w9qt+TVFIb9cFirWbkIgZ+lfU=;
 b=mQJDv8eawXlH+nj2sFaTscaYDZMmh1KvtDkNyGzr4a4aYqmsSP3RUsQpjR66YivwkoJvU1BTiwHAcdrYyaJq4dITj+IHDZNDDo33xSB2UZDn3ysKc+hExEVxUd2t4iUZDucEIuFLSDmgRVwVX/jrneXzHZEdNRQTxbv5RkzoURDN4Hb8stRp2cpqlNlGngK2X+BJFOwcE3qVUn/mBQgpb7Yyf5ZPFi4qWdd8MZWvWx9DaBsSnUAmOvtKkFw8x2FNP8kCp+FpjUofKr4ot5IkPEdxF47j8c7BoDpDu/88t+1FV4DDBhNAOxIPkSDxCTWOF0aeCAWRDJcJjdugVhfD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH9I57HbtKqq97p093w9qt+TVFIb9cFirWbkIgZ+lfU=;
 b=WK6LUD+JQ76SH33lxIs5JGdcMApHHYDmzuJx7TD20XjRwISlEuJ+Rq6NDMdN3J+NH9eZuXNuolzpcP46chfvQv9nb250a311RZHoHIVkSEhdbnVPiPZw8v7dXxFm/Tg5fMgHBtcHNmv0/D7yKH8/pimpeexV5uQK2mbIWCmnWrk=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SA3PR21MB3864.namprd21.prod.outlook.com (2603:10b6:806:2f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.2; Wed, 8 Feb
 2023 17:45:59 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3112:be93:6758:2d0c]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3112:be93:6758:2d0c%4]) with mapi id 15.20.6111.003; Wed, 8 Feb 2023
 17:45:59 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Dave Thaler <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
Thread-Topic: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
Thread-Index: AQHZOl+TrERI340YIUKwIUHtz2N6AK7FKkKAgAAlZICAAAHoAIAAAn8AgAAAuvA=
Date:   Wed, 8 Feb 2023 17:45:59 +0000
Message-ID: <PH7PR21MB387839E8170EB572814FA63FA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230206191647.2075-1-dthaler1968@googlemail.com>
 <Y+O7b5iKBUpskWLg@maniforge.lan>
 <PH7PR21MB387847C84B7D6DA43607692DA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQ+hgqw4fL8Vvq7GkP8VkO3wvFbhVD-LFU+h9-8vQC+0RQ@mail.gmail.com>
 <Y+PefizA09h21XSF@maniforge.lan>
In-Reply-To: <Y+PefizA09h21XSF@maniforge.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=acfb3d95-7fd0-4084-899d-899a183044f3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-08T17:42:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SA3PR21MB3864:EE_
x-ms-office365-filtering-correlation-id: f576f76a-4053-4cb2-212f-08db09fc56de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SyCoiDUpPaszf6CFU0EvywS6WFs2pe8oSZDbrqVRV8rskv+kqIszIqW0oIPSIBPaGCnRNr8jsvf1yDHrmioeSsAmZSb+TXCVqc5VUSv0uo6KLF8MR/+J0PXygQV2rqbZRPeOzs/IwdmgR8vhVXQwWoPlplSmAjn9mwjrMDAllMoT5IXL5ndhx5jU8xj+QoLVw9gqQunm0Iw0EKJFliqU4QaB0+74/NNqJYi7LYZKdpi4XMToNMRzmLyeN405fEGMxgwN81CwRAM/OMqcYmtupUZ6Rl/TI/mQNwgDHHHeZXw2l/uIqf9QRL65KSJX6Kgi831EjM/DU+CauRZdxA4NTYWJ+I19w08hfgcpV55rCdwtdrM2yl7eVOtljtq1UCiHBvmoU/jazrRnS7zLHOSK78zteRVOSdCpnmZJUCczjDbeodmIIl8kLgLyiPiZlLEw6xVeix/zPWxzocL/xN6FG04XpDN8EapMa4cFOx3q8/G3XDy8cxSRoWmvgbo8xTuaZrhCDyFYjk6egI/dpd7xj3lg6wI3ux7R5vkoERTe5R2Icqcd/WGRCiqxN09lWmX2mn5lbIHmx7VV8jVjer22GzcA1H0leC4/jDGY6DzmOVVjmqRzcnNwehgrAq+MM1eGwqEmFOwPNb3jFWwNukZSyjkJFPCpEz/9p+NT0oA+nAKDWoEldHDNQ0y2d+7J0jwvH5w8jFfXiL3PavjkmXAWnF3/YyCXtwaXUW/oMzNQEe/fnAj+B+8zr014gCmZIw9/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199018)(478600001)(53546011)(26005)(76116006)(55016003)(83380400001)(8936002)(4326008)(8676002)(66946007)(5660300002)(64756008)(52536014)(66446008)(6506007)(66556008)(66476007)(7696005)(71200400001)(9686003)(186003)(10290500003)(316002)(82950400001)(82960400001)(41300700001)(110136005)(54906003)(38100700002)(86362001)(8990500004)(122000001)(38070700005)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?toWS+aWsGwpCMTAEgQuSKt5nJLpc0iE5K4biuP+ksQTov1AEqQfpU2HHq2fV?=
 =?us-ascii?Q?JRvpeKPMr7cBYBypzV/OO8ipOxynaERllquWlrBAjnsVQBSCyde2iXSXGIxe?=
 =?us-ascii?Q?URjIpRoK+H1Zo8wmuHDMLswOI4SkQ4TF97Dksy1ozt4lL2w2NBVxXskpaozV?=
 =?us-ascii?Q?y6eqC1rKcEidStBZKUBqaHd8HG5g1eCAclE/4hugL5m7z+jgs0IUqY3RdhtT?=
 =?us-ascii?Q?0gKg68XzsdgMtrejOw2jyIygnbZIa6fmWGIGBoFWj71qKMRIH7Nh2RBnaSeu?=
 =?us-ascii?Q?daFV0dBgWptgWvOhTorTeTuX6VBDnGwc1AyqGqUbyGm+GEXQGmIRrpfARVak?=
 =?us-ascii?Q?Ak/Ht3TsE9r2N2wWAhudLvxbN3ZyoG8MXw41WMnSAM5SXiZ/ze20S+uvLfXa?=
 =?us-ascii?Q?TMqinx5BRMOBNubB1L8kBRars224sA9IMFD8BmEY2ocDR6WcZQWKnc74Wcx3?=
 =?us-ascii?Q?5+9szcawbq/K0MFhT8kTH2Zk/5cfR0JHBlnblv3ovYfHTsUppxnIgl8ilO/n?=
 =?us-ascii?Q?5oXPoGmbQ8m0/mu+VBhD12WQk6wAwXNAw06kyUOrhjIPMyYcIJ3LkBrC0ZKd?=
 =?us-ascii?Q?Yzj7+A+AzKiamkdkLMdO9vvhvDN4jEN4xDcqkJSn9f0n3v/cZe12Evmg3dq5?=
 =?us-ascii?Q?hldAuoVoS/s2jJhn6gDh4P67nhh2LHlcvEauqlXIIvpq2CfBdIEQmIUON0tp?=
 =?us-ascii?Q?CaW2g0+8mvTMdlgjIS3/MCGzeWyXn4zDkyi8yS+tzuJMl43VvQdZrHz6BZ/j?=
 =?us-ascii?Q?5OBlAuipDIswg0HRVp62oclIH7feLlRFTMeOlWJ71+z7aq4mBDlz1v1usobp?=
 =?us-ascii?Q?y+JbezuS3Rmcru1yLEWnfBGIZTaV4y1rqqg5T/8+6MO2ZmVv+eGlhmTsiD0g?=
 =?us-ascii?Q?urhsmzIl9ACHT/0byHhXRUNwsvocEkZZK0hJL2itdXW/6ed8lg+1kk8VoHdZ?=
 =?us-ascii?Q?oPjINX7UPHbO1e95C8mtFtPDPF+BXZhJ1l/DHO2JSsquXaGK4y1kV7lkoyyr?=
 =?us-ascii?Q?UDsBellVU5K593nDRI5MQzr8v/GFwmZX7rjGVEKRHSKkwCML0ON6TMAs8TbJ?=
 =?us-ascii?Q?kDzg68nELB6Le45VRJJSn6sh/nIUEzzUnHVr5AQ6X2ytVLfJv8fcQtSzPvlf?=
 =?us-ascii?Q?QjamLKUvID017OK9GyeuvP8EyHfgVOKy2brEwAPf9RfetZanpZSNGR4bMGg/?=
 =?us-ascii?Q?QKiiwFQvcLkzoKJk+xw4V7YJXj6K8yli6dGwRbRfZUVDOWPd8xPVgyS6ZIqE?=
 =?us-ascii?Q?2RPPNtxOBASxdAIozhWNX4LDVesEJsLEnh+1gRDOqwKvKYUH8eFll/SB65OX?=
 =?us-ascii?Q?lUQIWwPq22rJg3Kud8n9xUn582VHHl/k1pzmAFSf2DV3t57iZlHmfQUttCnd?=
 =?us-ascii?Q?pOzWUmthcJfbag5QM4QTNeI+44+zeunvTA3SQ0JFE1vgHuZcMkSWmtBJN0E7?=
 =?us-ascii?Q?az3YgdyFi4Qz1xgqNiLG+SwI/l6A5uD1efluLUWsk0u023QuOLdkInyOEMo9?=
 =?us-ascii?Q?9chO4ZzqLxo05/h3LdZqdiqp4xuzPWSl5p3+wMYd6C43+EokOATE9yTVbTsj?=
 =?us-ascii?Q?WpZ1XoouylbmoA8kQk27DJosmujhMVga8WIQPHyQI0dNTzgKJT7RbH3d8OFa?=
 =?us-ascii?Q?uA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f576f76a-4053-4cb2-212f-08db09fc56de
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 17:45:59.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Qs6HLk8d+Ss/c+p3G8MSXoQC7duEnQnwsbtVSmhuJiGz3dgERCjoJc/9H6EUzoibD2AWe/p3jyiEdxJlPbtYO26o497Zh+DhauRWLI73PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3864
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
> From: David Vernet <void@manifault.com>
> Sent: Wednesday, February 8, 2023 9:40 AM
> To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Dave Thaler <dthaler@microsoft.com>; Dave Thaler
> <dthaler1968@googlemail.com>; bpf@vger.kernel.org; bpf@ietf.org
> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper function=
s
>=20
> On Wed, Feb 08, 2023 at 09:31:18AM -0800, Alexei Starovoitov wrote:
> > On Wed, Feb 8, 2023 at 9:26 AM Dave Thaler
> > <dthaler=3D40microsoft.com@dmarc.ietf.org> wrote:
> > >
> > > David Vernet wrote:
> > > > > +Reserved instructions
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > small nit: Missing a =3D
> > >
> > > Ack.
> > >
> > > > > +Clang will generate the reserved ``BPF_CALL | BPF_X | BPF_JMP``
> > > > > +(0x8d)
> > > > instruction if ``-O0`` is used.
> > > >
> > > > Are we calling this out here to say that BPF_CALL in clang -O0
> > > > builds is not supported? That would seem to be the case given that
> > > > we say that BPF_CALL
> > > > | BPF_X | BPF_JMP in reserved and not permitted in instruction-set.=
rst.
> > >
> > > Yes, exactly.  I could update the language to add something like
> > > "... so BPF_CALL in clang -O0 builds is not supported".
> >
> > That will not be a correct statement.
> > BPF_CALL is a valid insn regardless of optimization flags.
> > BPF_CALLX will be a valid insn when the verifier support is added.
> > Compilers need to make a choice which insn to use on a case by case bas=
is.
> > When compilers have no choice, but to use call by register they will
> > use callx. That what happens with =3D (void *)1 hack that we use for
> > helpers.
> > It can happen with -O2 just as well.
>=20
> In that case, I suggest we update the verbiage in instruction-set.rst to
> say:
>=20
> Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper functio=
n
> integer would be read from a specified register, is not currently support=
ed by
> the verifier. Any programs with this instruction will fail to load until =
such
> support is added.

The problem with that wording is that it implies that there is "the" verifi=
er,
whereas the point of standard documentation (since this file is also being =
used
to generate the IETF spec) is to keep statements about any specific verifie=
r
or compiler out of instruction-set.rst.  That's why there's separate files =
like
clang-notes.rst for the clang compiler, etc.   The instruction set rst is,
in my view, should apply across all compilers, all verifiers, all runtimes,=
 etc.
It could potentially say certain things are optional to support, but there =
is
a distinction between "defined" vs "reserved" where it currently means
such support is "reserved" not "defined".
=20
Dave
