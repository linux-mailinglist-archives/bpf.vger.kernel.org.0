Return-Path: <bpf+bounces-1315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF2A712A22
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 18:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524961C2109C
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB427708;
	Fri, 26 May 2023 16:02:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F1742EE
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 16:02:52 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997F210A
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 09:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7vxAsQqe3a8UNUFUWfy79spcH9uJXMRn3jPyfqIbONFpd1IlMyMkAHVxj6qDNu2INjqOAIykCi4DAuTJnqQQFfmG0EXucYmw4iqYvK5MmlizaHggmnCGnrGMDKycrS6Y523wySOQuFigqZmkIAM4941diCN66nTYjkI9k1eEpy21YObCE3b+AdjWwv6e6MAD54I2e9emMS0Xr5BBwrrfX9hS6mA3kzVI/EYIeVi30Gdwo2oYxmSyf5dvUatxCAKf7Kmvfy5M3vbwObTqOaT3hu+wKhBI8zHI7cuPoBg/CXm1isZJBZgCoHJYNGnk3h53VnGCZ6x9TK741+5TsrG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1sQzL61oq6O+GVUKj3+qduQC6EBqmqrXIGGLsk9cis=;
 b=k5J5lqnlXHgcifoUB1g99m35Z5Kx+vunremNADhYbtnm/37afcwkz8/eSQJudJ3fy6gU/ikaHfGnk5iyaVR25p9QyidPftYdwVRZ4scqW38SQtlLs8Mxx2Qah6rHyc0YoBKYzDAC9A3OcgSYMyF8mJbNUMgrAqaCQgUCQa3Adfq1vEwS9y1Cb7FpoboJxm2Go/vHVHa3vOMftbeeBntx8vc91M8CHPqC6NDfylprBrioiEVIvyU6eb54v06zz91hQ4PsUCkzhneTZFh8i8IhceyJ4W6TPwTNcpVGJBt3MmHwETjYjlskzBRcTIak5bIqNYvHj5J/gZPIR8QRL7qV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1sQzL61oq6O+GVUKj3+qduQC6EBqmqrXIGGLsk9cis=;
 b=INqX/nuk9tHCl3kWR5fVidQQ5/tpM9VYKsyQu7VlgSgkrr/9SAKmy7Loo/LEUNU2g2j5rrwPvxWzjal3QY/hh97mrdADrRD7obtSXyX3mvi9JWc/heB7JBYG/pnq65c+Yyg9iQozqzDSCrcNRnVCk5XSChm/PhzqTEEV8DFoHBA=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.6; Fri, 26 May
 2023 16:02:46 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149%4]) with mapi id 15.20.6433.013; Fri, 26 May 2023
 16:02:46 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: "Jose E. Marchesi" <jemarch@gnu.org>, Christoph Hellwig
	<hch@infradead.org>
CC: David Vernet <void@manifault.com>, Michael Richardson
	<mcr+ietf@sandelman.ca>, "bpf@ietf.org" <bpf@ietf.org>, bpf
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Erik Kline
	<ek.ietf@gmail.com>, "Suresh Krishnan (sureshk)" <sureshk@cisco.com>
Subject: RE: [Bpf] IETF BPF working group draft charter
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index:
 AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOAAMSGf+AAD196wAPVwpgAAAwOVAAAFPnKAAEnmqgAABUBbrgA+cTCg
Date: Fri, 26 May 2023 16:02:46 +0000
Message-ID:
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
In-Reply-To: <87y1lclnui.fsf@gnu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=faa86fbf-a788-4a29-b97e-2edefbfcd7b4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-26T15:56:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|PH7PR21MB3263:EE_
x-ms-office365-filtering-correlation-id: 272748ae-eff3-4a06-bde8-08db5e02a590
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /+p6rkfFqDRkhR9B1zpJkmpIi6dNorAHJo3i+eEbJsH4WYhWnD5Bji7+B4RAJsXLfXe43Ldkw4XnIbGq6/WXpMGzVw1TftCOCWfq7QI+bBy8yRJ38j6CqaRUSnuoV24ZBsOKxa3YRjNMMWCk9jpsqRS63WsvbPoZb8uaHI0Sx2DiCtjExofUC9g9o7PLmbZCqCcKvROSuxGxwUaoPDD4v9KQw8DUQiwScWriGzDBnirMBhvmsTM+IZ8+g1rKPwRaXyfoR1i3KiOGTiezTkg+YKinjvSevu5Q5S4q9HiH8S6oz231N9h8Iy4ZI66Jrw/w7mmxhUps7MgjuBcAd8v+3MWo2DyfzEkMoQiYBLAwQH1rlzA9iQGvTGhNHEUeAopY1Sln8vogeL2wgAxnQcS6o0i9gv0weC3EINvGW4Hr/aNeRdHNznicTJk4BziLbn6BucIh6W8/6Mu6w+tKPwiI0KtfLQKAlizcKT4F7PBdBlZSNnO05xDTHSIWvB1C9OyryfTFngjVeo/kUAg5P6Ha9NUyB0r9KGL18jqJDUtvetLkRqTbSu46zEenjLOGBYSqGj3l2J/coRpb6dF7j5/zchwczS2zrb6Q+EFZ8oUt4EV8gub2nyIXmgrG6fSA1OTxqKVntrlmdK9OzYIUy0h1CZrj5skEwan9+asTlCbFGv0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(41300700001)(38100700002)(316002)(786003)(7696005)(8936002)(8676002)(38070700005)(186003)(33656002)(86362001)(2906002)(83380400001)(5660300002)(52536014)(9686003)(6506007)(26005)(8990500004)(966005)(55016003)(10290500003)(478600001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(110136005)(54906003)(82960400001)(71200400001)(82950400001)(4326008)(122000001)(12290500021)(15398625002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I9QCSRkTbBomS6LccqnfqCmJqCRxo4VYol0fZTn3vC6YGKW/UFQvQCDmNayt?=
 =?us-ascii?Q?R9gLXfNCppMQrKeo0zs/DewpqnVmv/zhw1R6FP+TTU8DHBo6wpe0uqSK4zjl?=
 =?us-ascii?Q?+3CE7xxFKLk/VjCmSH0w9+N1tWi8uPLoWIQ323PWglB5577HAZd9alC6zkZ0?=
 =?us-ascii?Q?RbytEM3aFddmIr398P/LIZxbL6WFWTrVf5j2PtzXYw7cD+zfjHwXnwKCyUjL?=
 =?us-ascii?Q?yQQpm1rlqMujrAZIIl+DVHddWCER/kW3nws9O1HTBjCt/1IyP8Y94fUXIcy3?=
 =?us-ascii?Q?MmIyNH9jA+66Z7Bv05oMceFc4+ZdjK9HLmkkNBEC/fm+5+Z6U57g/NxhKh4m?=
 =?us-ascii?Q?tabmJm85OkZYWBgKxJPooeI6nRLKp53IkOb0SB7LHv7yEJ5AjF12l5wVcgrw?=
 =?us-ascii?Q?MxAXZo4hNCC26T6jA6R9jAB0/eM6ARYrHY7JeCGPPSehsVmt4CaMe7TZnXJv?=
 =?us-ascii?Q?fuO5uCtM+739PbAOQ1ZCql5oiNCFsQwy7MtBcxPs/iEvVLoWKjlzFUEWmctP?=
 =?us-ascii?Q?xYFyN44lGrR55yrNCjJTGiGH9Mqnwr2+UE89F9sdXxrGGiYY+iADN2gP+W+D?=
 =?us-ascii?Q?Y/BbrKXddWFZg3ilzdXEu2HBUnqlRoi9bid/RfRhPHZrACoZCmr2b0EaIC1Y?=
 =?us-ascii?Q?tyYVkxK7OhdQ3Bi4svCs+hu45WCswBrmHrvw+ErLgMuul2f5ajP9NZrbWrYl?=
 =?us-ascii?Q?UURjN508XtAxb3Y4Hpmdp1CU4GQ+08hYiOmnbXuEb4QDoAATDJOLyYUheM5A?=
 =?us-ascii?Q?GnatxmEhY8GTNRdsbyGO1B7/1uP+KgmXOU6nE2q9Qhg2saEVIaRyyS+4+Rdt?=
 =?us-ascii?Q?QVbejeRFI7pcjaBKFbopfuagt26wPLzWPrfhFD5nYmfv0ha4euLJ/NUzbWSy?=
 =?us-ascii?Q?ztgJSyNQMaFH4A09GqSsqLpsRYHx65dNQ0WIisgv6hmKOAoFnWbRPd9RJt54?=
 =?us-ascii?Q?Oszaz/vh2pij7DSqIQTZ8Ms1DV3i5HSLp3cf7Sx6mSANrYf2+7P1qmNHym3k?=
 =?us-ascii?Q?AFkPLd+kRlOMM0HCbH3wHvdIhbZ+Bkiscuyg07jzsvTecgg9QhFUtL3W36eu?=
 =?us-ascii?Q?s2A/I2uJ8RzS2z1l/ZTQKEPTNzpCwjZCellOcg1WVzBXVo2IpRdtDzkHSZDV?=
 =?us-ascii?Q?LtAysXiUk+O1ZG8Phv2ogXZGl6+a4qPidFPsOmsjAq8vssTpuDcsoyrHg69f?=
 =?us-ascii?Q?vX7sL6907tMqkOS46zw1PqRWjznkesJsrIzl5mwtDPuW8qIm2t8Ik3QF8goG?=
 =?us-ascii?Q?9EUovMtRkbYbUcRQCkKHeNDJtxjPeWMV4P2bzS9M/4FiOEwnAm9WM1VN+5s1?=
 =?us-ascii?Q?SPQh4ERwqWHnWFOdMI6D6LkbHPxYYqmE7DzrUqpNAMayx4fMl9mjDjomfcrJ?=
 =?us-ascii?Q?aYrvpgKMUsfDgXjhmjz2z0KbE8MUXt5dYkubRJJ9PQPccL6/S/HHsbohA07E?=
 =?us-ascii?Q?NnBVqAJfaMoto7R3IH0jmB1NA13Yu8cn/vfo00UNUlcnwRNHJ++koFrE5Mtn?=
 =?us-ascii?Q?FtC3+exWRjsRqV2JXOqAFCzmVmwbxra/memg4f7VpSwl1meSqVtbTp/ZjN8Z?=
 =?us-ascii?Q?1YNVGhvAzUSeArTqC8gtCEq8ViPwjbVSV3DAKY8DT4Oy1Th2BvtJhlPAeo/7?=
 =?us-ascii?Q?rQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 272748ae-eff3-4a06-bde8-08db5e02a590
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 16:02:46.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyb+K+LUEYwlzelKMCOWyI5H/9O1FG5CbBmvWAt7kkNBR3LIp8zg4l7epg8RoXaNh2AIscESd5D+CoK40jsUM0jcRqIwz/RVr9uNWlZQ4Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3263
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jose E. Marchesi wrote:=20
> > I'm really lost in this discussion.  All aspects of the ABI are a
> > required part of interoperability.  And one of the promises of this
> > IETF eBPF project is to provide for this interoperability.
> >
> > This is a very different situation from the binary ABI for Linux or
> > Windows, which has traditionally never been interoperable between
> > vendors, odd examples like iBCS2 [1] notwithstanding.
>=20
> The situation is not that different from the perspective of the producers=
 of the
> programs.  Even within the context of a single system the different vendo=
rs of
> compilers, assemblers, linkers, libc, and other tools need to coordinate =
and
> agree on conventions so they all produce compatible programs which are ab=
le
> to interoperate and run on the system.
>=20
> The psABI is what provides for this interoperability, and it works just f=
ine.
>=20
> None of these psABI are maintained as standards in the strong and strict =
sense
> (ISO, ANSI, IETF, whatever) and I am just wondering about the convenience=
 of
> doing so for the BPF ABI, given the nature of these.

The RISC-V calling convention is indeed maintained as a standard.
https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf is the relev=
ant
document by RISC-V International which per https://riscv.org/about/ is a st=
andards
organization.  (I haven't participated in it, via the Confidential Computin=
g Consortium I have interacted with some people who have.)

The eBPF Foundation could publish the equivalent of the riscv-calling.pdf d=
ocument
above, but we (the IETF and BPF communities) decided the IETF was the best =
place
to publish such documents.  As such, I envision an IETF RFC for the BPF cal=
ling
convention that is very similar to the RISC-V standard one above.

Given the precedent, and the need in BPF, I don't see a problem.

> I reckon the perspective from the system side may be different.
> No more binary program solipsism :)
>=20
> Example:
>=20
> If I understood correctly from the thread, an IETF standard document is n=
ot
> supposed to be updated regularly.  Instead, it is expected to be carefull=
y
> designed to rely on "codepoints" so all additions are optional and are re=
leased
> in their own document or supplement.
>=20
> As someone who uses ABIs on the toolchain side, and who contributes to so=
me
> of them, I am personally skeptical that schema can actually accomodate th=
e
> reality of an alive and evolving ABI, especially one as young as BPF.  Th=
e
> resulting "authoritative" documents risk to be outdated more often than n=
ot,
> and end being a curiosity that nobody actually uses.
>=20
> I would be happy to be proved wrong, and of course the WG is free to not =
share
> my concerns, but I have to voice them.

See the RISC-V document above.

Dave

