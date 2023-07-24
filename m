Return-Path: <bpf+bounces-5737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7703875FF34
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0C51C20C45
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F6BF9DF;
	Mon, 24 Jul 2023 18:36:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D6652;
	Mon, 24 Jul 2023 18:36:39 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020020.outbound.protection.outlook.com [52.101.61.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F31BD7;
	Mon, 24 Jul 2023 11:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq/tdMvDxin1t4S6oVGV0xne/jcRI4yI2MOs/Gw9IMFTBusQJMgRyyXbUgvhBEmp7oh7u49SUZKlOqQoPPjC/xp6emiD47xsokuoANZ106DGx8CgQaAWrabNYoPdn61N0ZRHm0oTo+LWEmmfp9hTh8ctbVhLIK6SoNEV7DWpg55WqtXsJxf/R4Gn6wUquLKtrI0PheWBDPgXZaxNKEUWOZsfaNcSFsKHfF8eSiL/HdVSoCqpJFDgbBhM+NhZZBc+xTX3PhgE+RVoIrW0/A6yExlZcAVcs32lDwrQlghLhyjASTQxFhThwBl1Rarox7f8slM+joUMQPNbicChpRLzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl7AEv2eqAl06GaHGGCDCcditU000jD5YgP/2Lq9/p4=;
 b=BAwXOmxGX8VuIQWA0DNOnFUFqgm6g7E/Fj2JRMBBHMo8ML8K9QvlzYDPs3ScIriS9+c9xYpwuYxo1E01Tn7+OSH1Du5wafR3lbsg0ACHSxDbZDsPAszpG1uSImeFr9AFlAVxTqsQjMoxUEukbO60TMgIsd+U6hcYoF3ZetxFq0d4I4f2Bw/b0WcPhJtHx/bJVlOnILeJc8H2uFtJxgO0JmNO9juXt5jjQlQVNgLFZOIONZfkD8sxCx63TZGTj0S/cDUemQysJuaaapn3jzmj4ZLsLBd/nw3pymtpNi/ye1D3MrFDOcwRGP0Dn9wMB87R1fHOypnMP8wUj8wGPhKETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl7AEv2eqAl06GaHGGCDCcditU000jD5YgP/2Lq9/p4=;
 b=IaBv9+5KdRP0ko4rCOtAf0RO5d0x0VqYtaMAe2ef97Jr04uy+msJ6y4XVZ3HjiI4JZ5vixR2WIQZXOPdGtv0l7P3gdW0tcam3kcSQqJdDYpr6i6ki0JrP1vwXMj1YHMBZPhePOuFo1862Oi5LacIWMnz+h99ALNV+ZnvFfHVkc8=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by PH7PR21MB3093.namprd21.prod.outlook.com (2603:10b6:510:1d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Mon, 24 Jul
 2023 18:35:24 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b%7]) with mapi id 15.20.6652.002; Mon, 24 Jul 2023
 18:35:24 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "brouer@redhat.com" <brouer@redhat.com>, Dexuan Cui <decui@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Subject: RE: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Thread-Topic: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Thread-Index: AQHZvAZSl8pOb40fXE2pDlV9gZuDN6/IzCkAgABE5NCAADEEcA==
Date: Mon, 24 Jul 2023 18:35:24 +0000
Message-ID:
 <PH7PR21MB311675E57B81B49577ADE98FCA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
 <1af55bbb-7aff-e575-8dc1-8ba64b924580@redhat.com>
 <PH7PR21MB3116F8A97F3626AB04915B96CA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB3116F8A97F3626AB04915B96CA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c6d1dca0-82a5-4594-bb8b-68dcecd3c549;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-24T15:36:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|PH7PR21MB3093:EE_
x-ms-office365-filtering-correlation-id: 242c5c42-19ae-4817-f763-08db8c74be72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EgWjJkzJOmlPs726XpjMQK4JsWURU7/9XhyGFEz8s9htnPyKfyUxXw6xxpSBdZwMkQRtwQktx9qVEDQzgalSVmHzgZYcBsk48oua+FMG62F6fqpURpwbzyduzSRzC789/M9bMXz0G2kgM24/QdAYlBpWG/7XXTGmyMQoaz1FBA36sQCQD+hhGHYBiiQoN+Dh1pN4VDVW3GquUrSauDi8XJBlPtcD863CidT7BHa16qtWK+S/WkRTzj+hlWgM0oFbgPBSzXPsaXXuFYrZ38FdMijQzaHGWuC2OdgbuYNL4hpeBD06XXHQtyOm2dxl73MK4EcovuLoplXR7MBgs6XS5wCeCJRM7oWTGbdv+YS/v+7eJtdycBeIT8ntZF70xvDdc+AS5e93jiF2cVTz5+QjOdLaQmY4h6jD3TEmS8QlcYM51eYAm78pGIhG3iF57HOomldd2JePDm8mwZ3u8EiC27dnix5FKtuPXi9x9fi9/9dOl4STVrfvoMqm3teEHOt/iVo3Yxcp+JkeMRpes1QOWLkcQD19p48COqDz24R69HgoyYVMWYdh2tZHMOFUbOYhUGNJnSwmuhZJLFXAKmd1v2x/QcW+K2/fR/v4vWGnLtmCi5Jxey6EFv6lmoSapvkCvhqjIedPDUzWLVq9ydtF4AOZVLSStzrROX5Hw4I7cMk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(38100700002)(66476007)(66946007)(122000001)(110136005)(54906003)(316002)(10290500003)(7696005)(76116006)(55016003)(82960400001)(66446008)(64756008)(66556008)(4326008)(478600001)(82950400001)(186003)(6506007)(5660300002)(26005)(53546011)(71200400001)(86362001)(7416002)(2906002)(38070700005)(8676002)(9686003)(41300700001)(33656002)(8936002)(52536014)(2940100002)(8990500004)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MJIkgGmyN/1n85fmghFqxLsAdlVo+89sOgr5xPECaUfXCmvzzgZbsotqrmwq?=
 =?us-ascii?Q?LEUibAwOosZfScfYL4OI8/wIMWkuUGZnKe6HWvdqXf4qtelwE6X49PsZrbG4?=
 =?us-ascii?Q?3vRm1bM0IkGjwGmJaPg7lBv74WR19pXsUOME8Yy26WYSMmzfXlKUSrMOddL2?=
 =?us-ascii?Q?F6K/t8EN3BRr9Ww+BUyWl/WJSeA/oSymLzJ85sPtvE3tdWzNDANMzTd8lSp+?=
 =?us-ascii?Q?TGObzkGKvO8txVoa7bKZ63rYtOAMm2dA7PtvC9tN/wOR5v+8z08Y4N5a8xPj?=
 =?us-ascii?Q?gNQlUA0UeNk1gCHRRQH9zkGoTdQSTXrtDZo9Xi6g+EAHoRkqWYv+ubv6hVNa?=
 =?us-ascii?Q?MECLn4oKxzdc6H2m/FzfZsufC6tFrZ7DgRHqcB0JPhpNkyrhIOTTl5G/Hhug?=
 =?us-ascii?Q?cVNU1Aj5xf4QRTvVZUWzMg6eRoalX9jJmWJwjzwK6pnG05NKRe5YC6i12TuK?=
 =?us-ascii?Q?6KQDHtUAz4pnTsV6LP0RFJYi+hE1MT1zzDQ/2XB8cZ+18V4HoDqdO0Nzu7n/?=
 =?us-ascii?Q?hbC1LE82V3lt4Kk6EmNC+pIYSqyRtJpm+tR7y86/mOfi8zdIu50IHgx8CPT7?=
 =?us-ascii?Q?55kscRaXkd2O2p7fS6ksESNbjheD+m0hszvL76+EDBEyZd+H/5qosNVFN/3S?=
 =?us-ascii?Q?rPj50uD4uqJa6st6tk6Tv9bnbFJ8xdt68wDFJKlqiiPl+QIiexDHmggyUZwn?=
 =?us-ascii?Q?OIgx7sEySYrS1tH+5EznmflCopFFB6e4zuoyEgIndF1KDu/l7Jkzx7BdHU3V?=
 =?us-ascii?Q?ElpcK6S3VEdklAa44T5JjThH/0bfiSL0GVBRVUFWNMRB1yZ+kTfvTqNcSREv?=
 =?us-ascii?Q?BjivO9qd5lzOvHU+8VdyiYWZbqJLLQ2+YtIckbJXdUlRcTIyfF2KWICrt1oL?=
 =?us-ascii?Q?qCYSq3b946Abi9sgDUtSmT2RqD0Jw6Y31ufl9XNDVKgT9Xhnmx0ESendB/9M?=
 =?us-ascii?Q?lVLieMeh1a982xvy/6noLrT4r+PuCdUdhN7bL9Zsnu8WgGCF/RtM22UNOYK9?=
 =?us-ascii?Q?Ovad+D/XwvY62JckI0ef5ZzL8U3XwSHUypmx3PbIvcBUQSSVNA28575AB/4f?=
 =?us-ascii?Q?xRsFLGy3E9X9VRMQy7gSx4paOjjBEEyPX2eeAFPsCUmB0Qh1Wvy3/Dy6Rt1H?=
 =?us-ascii?Q?/0B04ogvVgRindpbQg9icwUZQyIcMIT4Ko7d7+qsouYC1pLfb4jBUTc8qCkU?=
 =?us-ascii?Q?OgNu1k2/2W3teqR2/wsbyVKFCUzwm0uoez9nSE1T2pAyagS16aOtsqmvLzdJ?=
 =?us-ascii?Q?LJLs5G7PDFkoaUdJYLtBozUTI0xcbbzs8XpmKqQr0znnAoK4i8iL9YzRuMre?=
 =?us-ascii?Q?LMlx5VlbFGz0UqQhAeFArK5qCIZaR2N8Yi7RoiNy7KjYiLvV65xTyqLVkPQp?=
 =?us-ascii?Q?vkxcPb4Rqz9X4sv//gxqEjPyezH7CdssB6JkIAFqPcxHilmepNd+4maVIWVA?=
 =?us-ascii?Q?czHJjjKtMUNRj7h/3k4Nz/OG5O1vijQ1kBj3vyRIDZqrmZevCe2J8GBwAmAt?=
 =?us-ascii?Q?b10ul3f7kqJTOqJ96EsW+7zPOu9M5e4horBZ3Ry/riDlh3ZaGVgAFcKE7rJA?=
 =?us-ascii?Q?L7Mbo7LFkmfNozJyOzPsrSzUD0uZ7ypXphkoaad7?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242c5c42-19ae-4817-f763-08db8c74be72
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 18:35:24.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RheOJWUEvLDV+KzvKPeoSDipOWJlzLjuP29cMzxaxx0goORHp1xx5yKkqzxDl0ylchBtliOtUkJpQkQt80xF3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3093
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Monday, July 24, 2023 11:46 AM
> To: Jesper Dangaard Brouer <jbrouer@redhat.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org
> Cc: brouer@redhat.com; Dexuan Cui <decui@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; Ajay Sharma <sharmaajay@microsoft.com>; hawk@kernel.org;
> tglx@linutronix.de; shradhagupta@linux.microsoft.com; linux-
> kernel@vger.kernel.org; Ilias Apalodimas <ilias.apalodimas@linaro.org>; J=
esper
> Dangaard Brouer <hawk@kernel.org>
> Subject: RE: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> > Sent: Monday, July 24, 2023 7:29 AM
> > To: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.or=
g;
> > netdev@vger.kernel.org
> > Cc: brouer@redhat.com; Dexuan Cui <decui@microsoft.com>; KY Srinivasan
> > <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> > olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> > wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> > ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> > daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> > ast@kernel.org; Ajay Sharma <sharmaajay@microsoft.com>;
> hawk@kernel.org;
> > tglx@linutronix.de; shradhagupta@linux.microsoft.com; linux-
> > kernel@vger.kernel.org; Ilias Apalodimas <ilias.apalodimas@linaro.org>;
> Jesper
> > Dangaard Brouer <hawk@kernel.org>
> > Subject: Re: [PATCH V3,net-next] net: mana: Add page pool for RX buffer=
s
> >
> >
> >
> > On 21/07/2023 21.05, Haiyang Zhang wrote:
> > > Add page pool for RX buffers for faster buffer cycle and reduce CPU
> > > usage.
> > >
> > > The standard page pool API is used.
> > >
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > ---
> > > V3:
> > > Update xdp mem model, pool param, alloc as suggested by Jakub Kicinsk=
i
> > > V2:
> > > Use the standard page pool API as suggested by Jesper Dangaard Brouer
> > >
> > > ---
> > >   drivers/net/ethernet/microsoft/mana/mana_en.c | 91 +++++++++++++++-=
-
> --
> > >   include/net/mana/mana.h                       |  3 +
> > >   2 files changed, 78 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > index a499e460594b..4307f25f8c7a 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > [...]
> > > @@ -1659,6 +1679,8 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
> > >
> > >   	if (rxq->xdp_flush)
> > >   		xdp_do_flush();
> > > +
> > > +	page_pool_nid_changed(rxq->page_pool, numa_mem_id());
> >
> > I don't think this page_pool_nid_changed() called is needed, if you do
> > as I suggest below (nid =3D NUMA_NO_NODE).
> >
> >
> > >   }
> > >
> > >   static int mana_cq_handler(void *context, struct gdma_queue
> > *gdma_queue)
> > [...]
> >
> > > @@ -2008,6 +2041,25 @@ static int mana_push_wqe(struct mana_rxq
> *rxq)
> > >   	return 0;
> > >   }
> > >
> > > +static int mana_create_page_pool(struct mana_rxq *rxq)
> > > +{
> > > +	struct page_pool_params pprm =3D {};
> >
> > You are implicitly assigning NUMA node id zero.
> >
> > > +	int ret;
> > > +
> > > +	pprm.pool_size =3D RX_BUFFERS_PER_QUEUE;
> > > +	pprm.napi =3D &rxq->rx_cq.napi;
> >
> > You likely want to assign pprm.nid to NUMA_NO_NODE
> >
> >   pprm.nid =3D NUMA_NO_NODE;
> >
> > For most drivers it is recommended to assign ``NUMA_NO_NODE`` (value -1=
)
> > as the NUMA ID to ``pp_params.nid``. When ``CONFIG_NUMA`` is enabled
> > this setting will automatically select the (preferred) NUMA node (via
> > ``numa_mem_id()``) based on where NAPI RX-processing is currently
> > running. The effect is that page_pool will only use recycled memory whe=
n
> > NUMA node match running CPU. This assumes CPU refilling driver RX-ring
> > will also run RX-NAPI.
> >
> > If a driver want more control over the NUMA node memory selection,
> > drivers can assign (``pp_params.nid``) something else than
> > `NUMA_NO_NODE`` and runtime adjust via function
> > ``page_pool_nid_changed()``.
>=20
> Our driver is using NUMA 0 by default, so I implicitly assign NUMA node i=
d
> to zero during pool init.
>=20
> And, if the IRQ/CPU affinity is changed, the page_pool_nid_changed()
> will update the nid for the pool. Does this sound good?
>=20

Also, since our driver is getting the default node from here:
	gc->numa_node =3D dev_to_node(&pdev->dev);
I will update this patch to set the default node as above, instead of impli=
citly
assigning it to 0.

Thanks,
- Haiyang


