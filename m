Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEFA607F03
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 21:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJUTZC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJUTZA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 15:25:00 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11020023.outbound.protection.outlook.com [40.93.198.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE365566
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 12:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+bmsmsUfq8Aw6cGndAQgC8n/c1JEc//PVMeT9hxEzG+5EvwbqKbp5Q0aQukj4aNFV8BEtBxN54Ia9EtR4tfiJ9K1zUpwAzj8ndFKUbLotqzW8juXGfsjc0irlJVrBsK0lt7mkVqKiQu/AUoaRjCLUuDDp12NJV+H8LHjbfOLj0Lx3SaCrBp99jLFvZY7ckD7bCj8rxEgpjkqod9RQOScednc1amb2PnnZBkGMraTXYf5CpKcPAhXaK/QFDMp8R1iu1rn0OeMWTdwz5V3iqJPHpN5KsD0IBeh91EnY6r+mJKPJdMSXgqdXIhwa2MOiCf4IXDK6OynGNJO2OcKPFkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ro8bqKlzlIS4oluL0E1YgGrlHTHYfD9w/wCxLHKPc2Q=;
 b=XbLWkg8FQRPnh0r46iFb25DlTN29ngr6XY7/zcDSD02QJeUM3dR7VRYC7y/TxcvQbS0q8+8hFzcORxpQpuSc8LcOYpE2jSoB5KTIUdMjR8nKN/jvZbLiHNXPy3g3ci7tQobT5v0uTQjo3MjMUa0eCkrZYi2BbvruRU/sYXfEOraXtuNiu8uCi/FNRcaCJQAHEXO7tC2/UunQB90ZTrfGWDiFnigPtKZVkxfJcVNcIUT/lRRa3YjxBCwvD42dsG9JR24OYLMFoVLdfXyL5HWUPSzWXdAeUVMedWSULbKEzM/zzLuUsHSXrRsWUvRyiIpN660aXBxVB1uPNr+RTGjvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro8bqKlzlIS4oluL0E1YgGrlHTHYfD9w/wCxLHKPc2Q=;
 b=S5UKnVcqG79LEr7k/8F5oprGhfk4ZfiBWtH3fe2btGw5W6iMeIoZcw8wp1WKvek0JwUsJ3+9M+8D6UP7bjfdad2jMIT91nkhe/TRqm7YtiECRqSKzRNwuNnIyBXSbtmHtssuKd99dSYMmSrp76lzhRftc0lW6PIQ0xznXCtiHR8=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DS7PR21MB3669.namprd21.prod.outlook.com (2603:10b6:8:92::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.6; Fri, 21 Oct 2022 19:24:55 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2%2]) with mapi id 15.20.5746.006; Fri, 21 Oct 2022
 19:24:55 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Stanislav Fomichev <sdf@google.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 3/4] bpf, docs: Use consistent names for the same field
Thread-Topic: [PATCH 3/4] bpf, docs: Use consistent names for the same field
Thread-Index: AQHY4+oRxc9QaZzI/0a6dc/gqciqz64WMviAgAABliCAACodgIAAARoAgAK7gVCAABvtAIAABhoA
Date:   Fri, 21 Oct 2022 19:24:55 +0000
Message-ID: <DM4PR21MB344020F909D07E5DEE316818A32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20221019183845.905-1-dthaler1968@googlemail.com>
 <20221019183845.905-3-dthaler1968@googlemail.com>
 <Y1BkuZKW7nCUrbx/@google.com>
 <DM4PR21MB3440ED1A4A026F13F73358C3A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAKH8qBterhU-FM52t8ZukUUD3WkUhhNLSFq1y2zD7geq4TYO6g@mail.gmail.com>
 <CAADnVQ+8AtZWAOeeWG5REvW2nW7bw20aZpfHxUjERnqMSHGRiw@mail.gmail.com>
 <DM4PR21MB344040829C9EAD2B159CAF3BA32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQL4-aNJ8gZziNC7n7_mchK+Te1+HDBg2sG2YvS3K+2kFQ@mail.gmail.com>
In-Reply-To: <CAADnVQL4-aNJ8gZziNC7n7_mchK+Te1+HDBg2sG2YvS3K+2kFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c9c43cf0-0789-416f-910a-5ad5797d9406;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-21T19:23:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DS7PR21MB3669:EE_
x-ms-office365-filtering-correlation-id: 69fc4db1-b409-4153-e023-08dab399ef47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4S8O7dGxav8KdoYiJW8FhoIhAVRiJZot064WOsRetqXKQtNB8OOnOMUOB1b8fpypC6XpYUolKJRrAwjK1NTVDR8Jy6BTxRXQBd7TnpE/Ep7WkHYw21QpiovraFAENA2U4vEnHgI9D9quwgdngEqiI/yrSyMDvZRueE/iHYN8DmtIFT08a1cr82/Cr8wGI62UngnL9YEathAlD6aqiwsGWsX65VR95QwRCl7/HiTOXT92LQyKXyL4toqvHT8ZWS5KjZGOoMJ7UqP5htBLVNXrxyfdfuMvyTjYarxCV1nyIl8hYrius04tWKt70YnidQF5inVmTyD/tuqyPFAR3gIPX/2OJjMD+zMyydwbXkcMQs/wKd5iLzcbb1eJn9TQGuAqtbT+otm4tVADUJhYlAbOsgCyuUZ3qPAUS6Afx1Pf1NxWC016QxIs1+Eu1AXF5QcmzurWH7E1yeTzSJKpCjbNtOjPzNfhqDYNbR2LyjB0dRKRh877vqrDYOa+F0frfLeF3klY8Zan037K89+gzBZImiWh1sdL8IzUrbFKVWBbKxJCB0RGmmGq+3di153FOvTzDKoCgsusRxXGHREnrh9pBnh8rTQB2QbpuGP3IJCu9M511V47zoQCUmcMJv+bSqDuyFlcO7iF4iM4fL28kZja7A94jKZbABZu5K/R52FLQZ627Hj9bkgMTCqKsNAb5NgwG1MWOzm3hnVM1lwDgP/ileyWqJGeLrsNE1hqER0CoBGky34BdAQGFCggy+z0IacO6pqo/cCIJI8vGdIWuycclFtyr26tFnImu5w5VEFZejqHfEeuhr87vUhQZVQfoBQGRHxmHfUJ2FGrW+D5vtlmWiai4sdgwKBRHM9rmaGNrLs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199015)(122000001)(82960400001)(316002)(54906003)(38070700005)(76116006)(4326008)(66476007)(66446008)(82950400001)(8676002)(38100700002)(86362001)(64756008)(66556008)(10290500003)(8990500004)(41300700001)(52536014)(66946007)(8936002)(53546011)(966005)(186003)(83380400001)(71200400001)(6506007)(478600001)(7696005)(2906002)(9686003)(26005)(5660300002)(6916009)(55016003)(66899015)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BPglHa+PD4uN8YgBY+/doBoQy/4le81djK0jgfygUk6eHPZF1By23htiIabv?=
 =?us-ascii?Q?NGVQG+2hmUU2x8C4/gUiqEoQO1Dg7P9pMK+Fkb+dI5/amm9ZJsWR+CgokB6J?=
 =?us-ascii?Q?fVg4df0vKggsPdJ7SbfZuU6PPLe4w8JJa0daM2mQjWN/oO9sTqQ73a6quMHk?=
 =?us-ascii?Q?ybJC5mKrDnUV/siDcuKrWkuBvIfI+//o1OTnvtdp4cOqjzXNTnbUAyvcaVoV?=
 =?us-ascii?Q?cA/bk3peQLG2U4xQda3voeniNRZ2Max/APhu10sEKxI54gF9lw3iHPigy/6J?=
 =?us-ascii?Q?XE9AcoyNKRPWCj4wxBE1gZ76qZgXAuYVbiNuz5yD5PohLzKj7U/g6UW74R36?=
 =?us-ascii?Q?ewb5t+M60kW02m65rN1upypZZkb7RYKuguLcEzUT4LTox3m3MdSStU9+AQmt?=
 =?us-ascii?Q?jAk6bzBW09FHF+mQ5WmshnQfdzjgDH9jvlVHTonFTIXt4rqH3d30+ks/nIcZ?=
 =?us-ascii?Q?U/ejIK98SZEqyrEzhgxXpq9SnP6VUxb6idV9NPRAdUZX4xZ9VBqAzAwRkfCJ?=
 =?us-ascii?Q?7XIJVz5EkvotCJXtO7kPuOOMO52wkhV5cw1bQkgC+zHNgBkCdVdl01+ZMGlw?=
 =?us-ascii?Q?UoM/xdHArLuWcJM0tVw3fgIwlzrmQVe4bhehFTs4Y/9RF4oxMQEGp8uWYdYm?=
 =?us-ascii?Q?usP/FcEbXhLN9+F5gOwQ3wGK5gHoCFmea7OB8e2IZNEIeVuszawCUYJh4ZQ0?=
 =?us-ascii?Q?lYlaJzEf/hiTSmarW3AVSN9aB3lxaA4IJkyzgLX3flI5BKq6hMs0ZU5MWl6q?=
 =?us-ascii?Q?bk8+PVaXWJiNBz5BwZgXwKlrxLI2tiic80pSpfhdqpxqtfHytlPbzW/SYwDt?=
 =?us-ascii?Q?2COvH0duI5h9P2wt5OtjAL5n+ykp79hf29FeYwlDe8UHdAkikOvJHDIPmf83?=
 =?us-ascii?Q?8BHjmXZfN04ECrDNgt0T5VKIiEOzKFsQ00pPPmsTQNi6Mxbc/1t1cFmZq+4s?=
 =?us-ascii?Q?uq0QBetnRoyF/AkbddMaFN9qaEC8Xf4MCnledw++sjBtgw7ybKKkxanpJJNR?=
 =?us-ascii?Q?pzHDOS6cMJXDkKpqSbzvPR1cWp4bwomMJ/uklDpyY1p31CYEE9tbeJ6u5EVw?=
 =?us-ascii?Q?TMVTciVKevAbb85WouXySP3UO7sIovllj7aj2cIOJWLGbO4XVhdoJnF5WOZb?=
 =?us-ascii?Q?23NyTELkjHhgo8wAPY8e04Ysx/ayhnyR0OXeSikh/kD6NoVp5FqyTAOM2c7Y?=
 =?us-ascii?Q?sgRv25RxHznyUBrg8ykrgSkXpEDjOnO3incMxS4AVeWNzJq8DUNf1Hr7as1Z?=
 =?us-ascii?Q?lIiPnqXhFAT7OsnCFEKtj0jFVML0Re5DgCoXdKI/lEQiQBqZKa6BNu2Dsb4T?=
 =?us-ascii?Q?rpQFUT8boXGbEoyJ1DOU4bdmkPZDotgX0Vmn7FQapLOzfJ+ca5IjFZXuD45c?=
 =?us-ascii?Q?oF3x/XyFz1jtDzCEZ3sJCw9ZKCgi78LVSU9B6Vhif+DhgMhs4PjO+SfugfxC?=
 =?us-ascii?Q?LnVk1g/3gtfAy/MOQO+f2bWcCi1WBIAQRYmstVDFoQgO7wJDu6IcUJQ8QiFZ?=
 =?us-ascii?Q?FR3yp5C8Q7BJ6U48cpHa8TPvplpMaxDTCpb5LU3p/IQ9h/J4qPSaRuCg4j6q?=
 =?us-ascii?Q?Mb3Aa2/TNwyudVGSjaxKxMeJOu4eqgC71APut9KxK7u+gZ8FVxOyBy80r74q?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fc4db1-b409-4153-e023-08dab399ef47
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 19:24:55.1554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g20SNE/IT0e9NQMr7QKTKJmIwrgCzoUhYF1bb3Xy/fGQtNtR1XoFLkE0f7k23OxDfPYzmYBlJY7x8Mtr1LHMrgBb7d/NjXlnvFtUZRmb+3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3669
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> -----Original Message-----
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Sent: Friday, October 21, 2022 12:01 PM
> To: Dave Thaler <dthaler@microsoft.com>
> Cc: Stanislav Fomichev <sdf@google.com>; dthaler1968@googlemail.com;
> bpf@vger.kernel.org
> Subject: Re: [PATCH 3/4] bpf, docs: Use consistent names for the same fie=
ld
>=20
> On Fri, Oct 21, 2022 at 10:56 AM Dave Thaler <dthaler@microsoft.com> wrot=
e:
> >
> > > On Wed, Oct 19, 2022 at 4:35 PM Stanislav Fomichev <sdf@google.com>
> > > wrote:
> > > > On Wed, Oct 19, 2022 at 2:06 PM Dave Thaler
> > > > <dthaler@microsoft.com>
> > > wrote:
> > > > >
> > > > > sdf@google.com wrote:
> > > > > > >   ``BPF_ADD | BPF_X | BPF_ALU`` means::
> > > > > >
> > > > > > > -  dst_reg =3D (u32) dst_reg + (u32) src_reg;
> > > > > > > +  dst =3D (u32) (dst + src)
> > > > > >
> > > > > > IIUC, by going from (u32) + (u32) to (u32)(), we want to
> > > > > > signal that the value will just wrap around?
> > > > >
> > > > > Right.  In particular the old line could be confusing if one
> > > > > misinterpreted it as saying that the addition could overflow
> > > > > into a higher bit.  The new line is intended to be unambiguous
> > > > > that the upper 32
> > > bits are 0.
> > > > >
> > > > > > But isn't it more confusing now because it's unclear what the
> > > > > > sign of the dst/src is (s32 vs u32)?
> > > > >
> > > > > As stated the upper 32 bits have to be 0, just as any other u32
> assignment.
> > > >
> > > > Do we mention somewhere above/below that the operands are
> unsigned?
> > > > IOW, what prevents me from reading this new format as follows?
> > > >
> > > > dst =3D (u32) ((s32)dst + (s32)src)
> > >
> > > The doc mentions it, but I completely agree with you.
> > > The original line was better.
> > > Dave, please undo this part.
> >
> > Nothing prevents you from reading the new format as
> >     dst =3D (u32) ((s32)dst + (s32)src)
> > because that implementation wouldn't be wrong.
> >
> > Below is why, please point out any logic errors if you see any.
> >
> > Mathematically, all of the following have identical results:
> >     dst =3D (u32) ((s32)dst + (s32)src)
> >     dst =3D (u32) ((u32)dst + (u32)src)
> >     dst =3D (u32) ((s32)dst + (u32)src)
> >     dst =3D (u32) ((u32)dst + (s32)src)
> >
> > u32 and s32, once you allow overflow/underflow to wrap within 32 bits,
> > are mathematical rings (see
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fen.wi=
k
> ipedia.org%2Fwiki%2FRing_&amp;data=3D05%7C01%7Cdthaler%40microsoft.co
> m%7C44c24e3f67aa4a5c846f08dab396adb0%7C72f988bf86f141af91ab2d7cd01
> 1db47%7C1%7C0%7C638019756992501432%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3D1rLsMSKUn0sNiZcN2RjDMH9jWIKCuf%2Fc3qZ
> d2QOanW8%3D&amp;reserved=3D0(mathematics) ) meaning they're a circular
> space where X, X + 2^32, and X - 2^32 are equal.
> > So (s32)src =3D=3D (u32)src when the most significant bit is clear, and
> > (s32)src =3D=3D (u32)src - 2^32 when the most significant bit is set.
> >
> > So the sign of the addition operands does not matter here.
> > What matters is whether you do addition where the result can be more
> > than 32 bits or not, which is what the new line makes unambiguous and
> > the old line did not.
> >
> > Specifically, nothing prevented mis-interpreting the old line as
> >
> > u64 temp =3D (u32)dst;
> > temp +=3D (u32)src;
> > dst =3D temp;
>=20
> Well dst_reg =3D (u32) dst_reg + (u32) src_reg implies C semantics, so it=
 cannot
> be misinterpreted that way.
>=20
> > which would give the wrong answer since the upper 32-bits might be non-
> zero.
> >
> > u64 temp =3D (s32)dst;
> > temp +=3D (s32)src;
> > dst =3D (u32)temp;
> >
> > Would however give the correct answer, same as
> >
> > u64 temp =3D (u32)dst;
> > temp +=3D (u32)src;
> > dst =3D (u32)temp;
> >
> > As such, I maintain the old line was bad and the new line is still good=
.
>=20
> dst_reg =3D (u32) (dst_reg + src_reg)
> implies that the operation is performed in 64-bit and then the result is
> truncated to 32-bit which is not correct.

It is mathematically correct as noted in my email above, you always get the=
 correct result if you do the addition in 64-bit and then truncate.  You ge=
t the same
result as if you do the addition in 32-bit and then zero-extend.

> If we had traditional carry, sign, overflow flags in bpf ISA the bit-ness=
 of
> operation would be significant.
> Thankfully we don't, so it's not a big deal.
>=20
> but let's do full verbose to avoid describing C semantics:
> dst =3D (u32) ((u32)dst + (u32)src)

Ok, will do.

Dave
