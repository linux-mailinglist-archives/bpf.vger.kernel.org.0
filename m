Return-Path: <bpf+bounces-1107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03DD70E274
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743E02815D5
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2B8206A0;
	Tue, 23 May 2023 16:50:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6520693
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 16:50:47 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC01CD
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbugt4nzizGuwdk6cIrSjHT9YUfKyJjJQ2P9hzSmKM+1U425/yRcSAGXHKQsgYCUZzWNRQTnph63jUN+INPnqmYQOY7gtlRTzXejiTLI0bowTXuRJpCBRzMhbrpdO6tAbgk2t/ejk+J4zn+aeR1xlUEFTpVfAKJCyes97R2/bflFSeK+PKIuMFSjoNuilHgsAgQO3oWvO4tjscH0PBfID8UZ/BYx0omK13ITV6oA/PhGfNabp53/WT37jNXA6EanjgEdBQVvlbo3f7Z35Xn3TcMk8hqvTWMKMXkLKl50F1klqN/Mqv0d9DqIPQpZEERjTR5/6FDcP+UHIJuT9TnR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6saMxP49ighAjthR62Vg1+0E/Hinw+W5EZkUV8Ot4w=;
 b=RRn3H/hogLKyJ+iOfDzfsRqR6ooRfO1H4+uCZ8milw4EHYxAUOM60LswBoIGgVCJWmpuNzLGo2TTKHURH1La1zP7U+V4Ra9WPYaL6IqVk3sb9XBLYIwrxPILK77qgVwpfO8pj+anTVzN/umvlJSsYdfIFGa/RB/d3Hhk7Vm6HCxshPohfUrCHwUDtiIP8W1e5HrYh5PNSoUNLtO63sFr1vtH0BeUieB0LTvKyhLKWbIVcmk803BPUeUtBoROEcDpZLOSOr9aYCvsWPo+SM6GGkIxiyoOlz4UiY+6Fu+5OwkuGZwkMQQZ3joCeXFr/Uhx+KfBsmbCTy3XxxMgylh8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6saMxP49ighAjthR62Vg1+0E/Hinw+W5EZkUV8Ot4w=;
 b=hdtQWTTzvQk9gHYyIh64F4Fu9m7z+ugqgB7SnXR5QJvfPoZekYvkWXaLoq5ec0sJGoEZGd5dEcXwHXDL4ge+26JinBjM6p63rlrFe20gM/cV//w09MtRnyXlD0e6C40THcNpXwJj6HGP5+c8rL1/nKCOJNcp+j264XLFFAqakgg=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by BY1PR21MB3870.namprd21.prod.outlook.com (2603:10b6:a03:525::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.6; Tue, 23 May
 2023 16:50:42 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 16:50:42 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: David Vernet <void@manifault.com>
CC: "Jose E. Marchesi" <jemarch@gnu.org>, "bpf@ietf.org" <bpf@ietf.org>, bpf
	<bpf@vger.kernel.org>, Erik Kline <ek.ietf@gmail.com>, "Suresh Krishnan
 (sureshk)" <sureshk@cisco.com>, Christoph Hellwig <hch@infradead.org>, Alexei
 Starovoitov <ast@kernel.org>
Subject: RE: [Bpf] IETF BPF working group draft charter
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index:
 AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOAAMSGf+AAD196wAPVwpgAAAInH0A==
Date: Tue, 23 May 2023 16:50:42 +0000
Message-ID:
 <PH7PR21MB3878A4135C14B318DD43365CA340A@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
In-Reply-To: <20230523163200.GD20100@maniforge>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=554dac9d-3ca9-4449-a15d-4f43448a0cab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-23T16:47:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|BY1PR21MB3870:EE_
x-ms-office365-filtering-correlation-id: 058c9a0a-a262-482a-cf6c-08db5badd8c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 K8m4rxpdbnZZUwXOdEX0hHJlqaQSTXZJZJWv37QvHJyEjjzTU3IonFRGD1tdxhib4Sz1q83LMLba7URqZ7iVJN0BdCqfIAgGio1kX0K1GvFVAj4Jz5C7bdB34973vWjIaXYmnGsG544jE/IwitRoXi0BPW/d1d7iX0toNqJUnKG76loxmOknkHQOO11MW0jTi7t3uCCLmR7aBbfFZmpwFk9pBr91z3N2knyghnbCjkE6gAvKJMFkkkn8RSF4vw7yws25Slj7QDqtXQDHZACHk9+dWAYvsEkWZ5LvIpfpaZ1iJ5A+K1Ebks5IH/GtGw89shSakOV9mLczRqGRTlDxe++7Wdqp95jiOXeMz2w9Iindv4fm1g2qqZqhd/iWvHRrO1hxNpy4KYQ0EfsaqWJf7q86mFLtql2P6UlfCnfsqLckCqSx9SrGaL3GrGRMRUopo3FKrNaQuwIcqCR62nenmJOS3W5AHnGKf817AVz/54VuZ2AeZNwRQlvO92EHI7RHTg8vEZUhT16LfgRUHkztxboSD3kdhyrstyrwhBnaSriVZ0o1c0QVwaILhRyMn2/45GXMEjFuDvtMlcuruSy37z724wypA79vKkFxBPTwSU25dq1bCdThnKRW6i0Kcq6pWuwp9g6en/OaTUybO5KFBpcJLzKpyUo3ikCOeuqdYwc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(52536014)(5660300002)(8936002)(8676002)(86362001)(2906002)(53546011)(26005)(9686003)(6506007)(83380400001)(8990500004)(186003)(33656002)(55016003)(64756008)(4326008)(6916009)(66446008)(76116006)(66946007)(66476007)(66556008)(82950400001)(82960400001)(122000001)(71200400001)(786003)(316002)(54906003)(38100700002)(10290500003)(38070700005)(478600001)(7696005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Sr80Ypv0uyEuy0F5UXqJnzFeBKDHYvkgvhuX8JN7KKV9P8QU5Qho64LLaNVC?=
 =?us-ascii?Q?A24fUjgoW/9FJ+jT9PdLUjolHIC4rHQ/UvT/ghNkczBLlxNQPtT34QWo+pqu?=
 =?us-ascii?Q?7YlRgM0udabtkzLPyrE6dEq041O3PFH7mcBV+pI2AL/PnfcAC0O0j0e1alR/?=
 =?us-ascii?Q?ZOqmfuiNSV1XnBhkWBRXhK6aD4MDap47Xg/kPnwVH4cwa8eOHLdiq/R+hCaO?=
 =?us-ascii?Q?RFN2PmMkp/NhcjraGmvvBfZhMXEEe/ckqXWv2d6JkuS8E3WBG4yC7o21eL5i?=
 =?us-ascii?Q?koRw6mfKrSGDD2YYdtSbhB9t3Eb9BGUybf+r4w/oKKSnyl7ugi8Ey0yWlfeU?=
 =?us-ascii?Q?+9zf+xX/ZJigwFVf5uBGXceDzfpxOQ5TMdtmI8+iYJQkZVxzlPTL5QAl7m1F?=
 =?us-ascii?Q?+vbrAEOKSulivCJ34n8QCQoFy3tuzMoNQF9mjJjFMEjt4LPj7QcD1kdje51+?=
 =?us-ascii?Q?xuFM4dIBIUW9dF7nv/40t4jl/DuO91DAl3iL0cjrhJSe4nGHG6utl6mw2Rvr?=
 =?us-ascii?Q?TbEzFIg0fFpdmvRe20RE1xgLHs7/uCJ7AiFz9+WG+QcIODhWU7J0hXPmVhCv?=
 =?us-ascii?Q?Bb9+Whwy9ijZg6li4e2POO6jQZSiY5TBzpjSK8GMyEkPY0su9fOO6dNroftl?=
 =?us-ascii?Q?fHpgs7WarJjMjLyZoWEmb2IHw8ZBGouuTH1mMTdZQVp3uki2wuI5EPHRAChU?=
 =?us-ascii?Q?2uVkYcAFNWkh5CB3aiwhUlzjsWBG+poRxuKYW/kpuXY0pHriPIuEY8EFIovB?=
 =?us-ascii?Q?8EVbq/9MjleEAFTG2JDTPyGz9NbO/zpcDbI46bsCGJ6Da63o7TlCsOIHLkKo?=
 =?us-ascii?Q?gaW0j3WW4p0f8lWqbUJIArpPINERiGTeRYrBumCPIndZd4DEi270LTBhwe+t?=
 =?us-ascii?Q?xzScQjqxel/jD1AcNmG2bmRpLnpPry1LbwLoQfuPEd7/h7KWeMUlAGtMhU8F?=
 =?us-ascii?Q?T/U9jz6pPG4Di7H+7Sz/vwqle1xGa9/8na4pVOJr1Tov/7VPnzkwifRXAT2I?=
 =?us-ascii?Q?UTWCccQlSFjKZZpUbvyl8jgpZTRr+/XL3wVK4KxoV5gwoGUwp/yqfS2J8TqU?=
 =?us-ascii?Q?mAssdmIG16XXv67q5HVPGTNOTMFUVQktTMtC1T8nRKOlfL7DtIWBHFYZMzd4?=
 =?us-ascii?Q?OTyd0C60X/LViiIxQFhFrM53/t3lEmSroDfU54FNfnEBT78pe2uyn7/yleKK?=
 =?us-ascii?Q?52bpVb+YoCGUMiV1b+hcxsECzd/D2ngXInXSiRjAlSy2HcOg2HnpesIy00UA?=
 =?us-ascii?Q?m1HYPmuOBWWyRzaGKeVE6va8yzNzIXyXYjSQDuctLafi3ipu4jvExBkKWNRl?=
 =?us-ascii?Q?S16WzLT9LtDQNLfnhYikrsa13QNFu1TmW1Je6D+2UCbRXwSkT7peA3zV3QHo?=
 =?us-ascii?Q?sJ4fQrhODsonjDHHynor32k5jOWhGjtjTGfdUMuzd2Jvw5GGAN3fE+y8f1ZT?=
 =?us-ascii?Q?LxeQrkVe2r2G07pSSPgwcxkQn5d1Gg9LPvUA76C2xgu5a3hpw+MK3qN+k2e4?=
 =?us-ascii?Q?A9vmRW4hqT/+SQD9/VFOOMAd3DdMPzDTJYs/wW3oV7JfrhBTGnJPFvT60RNk?=
 =?us-ascii?Q?XO1C+Ec+G+zpsrdOEyUxCjQy4WnQ1r9AtnhL95HvoSRrIOErj53wW2gqCwT1?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058c9a0a-a262-482a-cf6c-08db5badd8c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 16:50:42.7047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07HP8bxSyshPoYtV2/6uyO2DswlNqHhXL4uwr8kRWFzbTdPPMS3K1iVBq6hAA92bKNTryf/a1erDYmPDgndVCT7VEKvgw0NCEteoyl4bv2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3870
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: David Vernet <void@manifault.com>
> Sent: Tuesday, May 23, 2023 9:32 AM
> To: Dave Thaler <dthaler@microsoft.com>
> Cc: Jose E. Marchesi <jemarch@gnu.org>; bpf@ietf.org; bpf
> <bpf@vger.kernel.org>; Erik Kline <ek.ietf@gmail.com>; Suresh Krishnan
> (sureshk) <sureshk@cisco.com>; Christoph Hellwig <hch@infradead.org>;
> Alexei Starovoitov <ast@kernel.org>
> Subject: Re: [Bpf] IETF BPF working group draft charter
>=20
> On Thu, May 18, 2023 at 07:42:11PM +0000, Dave Thaler wrote:
> > Jose E. Marchesi <jemarch@gnu.org> wrote:
> > > I would think that the way the x86_64, aarch64, risc-v, sparc, mips,
> > > powerpc architectures, along with their variants, handle their ELF
> > > extensions and psABI, ensures interoperability good enough for the
> problem at hand, but ok.
> > > I'm definitely not an expert in these matters.
> >
> > I am not familiar enough with those to make any comment about that.
>=20
> Hi Dave,
>=20
> Taking a step back here, perhaps we need to think about all of this more
> generically as "ABI", rather than ELF "extensions", "bindings", etc.  In =
my
> opinion this would include, at a minimum, the following items from the cu=
rrent
> proposed WG charter:
>=20
> * the eBPF bindings for the ELF executable file format,
>=20
> * the platform support ABI, including calling convention, linker
>   requirements, and relocations,
>=20
> As far as I know (please correct me if I'm wrong), there isn't really a p=
recedence
> for standardizing ABIs like this. For example, x86 calling conventions ar=
e not
> standardized.  Solaris, Linux, FreeBSD, macOS, etc all follow the System =
V
> AMD64 ABI, but Microsoft of course does not. As Jose pointed out, such
> standards extensions do not exist for psABI ELF extensions for various
> architectures either.
>=20
> While it may be that we do end up needing to standardize these ABIs for B=
PF,
> I'm beginning to think that we should just remove them from the current W=
G
> charter, and consider standardizing them at a later time if it's clear th=
at it's
> actually necessary. I think this is especially true given that we don't s=
eem to be
> getting any closer to having consensus, and that we're very short on time=
 given
> that Erik is going to be proposing the charter to the rest of the ADs in =
just two
> days on 5/25.
>=20
> Thanks,
> David

I can tell you it's very important to those who work on the ebpf-for-window=
s project that the ELF format is common between Linux and Windows so that t=
ools like
llvm-objdump and bpftool and other BPF-specific ELF parsing tools work for =
both
Linux and Windows.   We don't want Windows to diverge.

As such, I feel strongly that it is a requirement to be standardized right =
away.
Hence I would not want this removed from the charter unless there's an effo=
rt
to do it somewhere else right away, which would seem to increase the coordi=
nation
burden.

Dave

