Return-Path: <bpf+bounces-5724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DEA75FB17
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 17:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B502814D2
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F205DF59;
	Mon, 24 Jul 2023 15:46:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F687D507;
	Mon, 24 Jul 2023 15:46:06 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7EFE61;
	Mon, 24 Jul 2023 08:46:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNRfKRFZX1dLAZ+4RjYX1hw5tqsUL+9wrh8MHJox52JoDbp5MfeLjBB1oZf+6ucTMRIXKOtWdCSzZCNfVCSMlru+aGDFHkiyiQYXUdACbvkg30aGYZYInhhI/mvDZQUG+/50E0TFw3/mHmzvFf4KBT5wdrNidoFvV/DzVjeVFqmoGaIeCKK63CrYT9WNJnd85d/zl1ivT9OINzbZisusPG6O/zZS7wamZPNfmlkelX9JNcopg/vFXqDjDmTdZaFycUMAei5vVQ1lKaHStbFOrIpzZXfFHrfxosuY/FyjP+10uILe91sMnDlR/Y1xyTOdFt1/e55Xnr+x7dEshz2VNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu75WyEQiSdPQx4qbpSOAMTnmeBGNkFYSert3oNa2TE=;
 b=H6hoT9mGFJEpna0BmIRCE8gXxbtIxPSsurghue19Y6kyxUiDxzCrrZLsMCDrqR6lEcEmibbv8W0UiAxGNLOuSoLFmkue7BJLRG1+fUe1Wm/6srDt4QxP1NK+PWjLF5dVu61lxSfh4WBJ4kmmIKgEctkmsBqGGCjFc2XCLFHLcCaMZAm9wCdPom6CysZU2noLFuH8qlNy6ugvZxgZg7Uo+zjgF5We00UgRd5agJlrr3xMiqOK7rO+ZwJI35rlC3KOI1s1EQLSybe9bQFFb6yNo7ZA1IJlB0gR5RlqLqDApmkAZ1fGEqmzh52fQBiHSWXTK5FRwVydC2FOO4neZkKNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu75WyEQiSdPQx4qbpSOAMTnmeBGNkFYSert3oNa2TE=;
 b=If1drKKy8/tm7Hs+ZdUu4DKe5Ojs3NPUYk4JZk4sVIcK+QwVw0XCa1WfBUn9wEMTQUGxMqDJXkjiW5vTKSa0gN2Vd96NUVTqO/TNsP5upyOlkU0tcqIxJzTGX0jW/aLIlZ4JT5IrT9s5dno22pq3eQQyqqU0aSmzxX1nCICcm2o=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by BY5PR21MB1425.namprd21.prod.outlook.com (2603:10b6:a03:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Mon, 24 Jul
 2023 15:46:01 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b%7]) with mapi id 15.20.6652.002; Mon, 24 Jul 2023
 15:46:01 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
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
Thread-Index: AQHZvAZSl8pOb40fXE2pDlV9gZuDN6/IzCkAgABE5NA=
Date: Mon, 24 Jul 2023 15:46:01 +0000
Message-ID:
 <PH7PR21MB3116F8A97F3626AB04915B96CA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
 <1af55bbb-7aff-e575-8dc1-8ba64b924580@redhat.com>
In-Reply-To: <1af55bbb-7aff-e575-8dc1-8ba64b924580@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c6d1dca0-82a5-4594-bb8b-68dcecd3c549;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-24T15:36:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|BY5PR21MB1425:EE_
x-ms-office365-filtering-correlation-id: 1f71a066-3da6-48b7-54db-08db8c5d1522
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zdRAyB4+tAUOsO2Q/Wdtm0dpa5nlpeD45xZ/grD3WWCNA3JJPMtl/13jeTZiyrQbLbemrXcaXKsCpz7f0il28cgKX1MThIkAGUvxRDZjJw0i8IpZHAES81oQTjbkpIaPpsGlfJSWUyJTnm29J3CrTo/Bh3TxRUdhJ7CdOremFOlUS1oGpEUysFSVbFZjkBYiqfl5SN29XvzyDLyuWvJiDFYQ73ElOY+4GjbnRyA/Q1wgftD15Fb3ne4IaNu0Wrt8DBsqm8ibO2324pM5tv8J/QCRfczwSnWFbKhKDro2N8qNXnEB370e/CVy03fwa/1CHBrPLwGXBjiZ/2g2zdety71r30ZSKuUKAB739yzJanrK3Q7TEibD0y0SPpTynedltHgbQaRRKypMCXQTJJh4rZnbUaDC/kjC18UXoVgkr2dVvPclWL7vMquwUb3A816FNQhERIIjpwmSAvbEuvIZDvdTr9wU7e50IrTlonXMwfB3ZVtXTLPtcpv19N+q070wRMdztjK9FuiJT05KboN4qmUSKtBMjJh70qY2RPkuAK2KY3TP2tL04YNVOVRLiC7QUq+PQFY+kwExGICCv53iaD3fGgysZnUgYrFCi+0t3RAXoLjJH8m8jxYmoIzpZj8QrC0J07cQREdgleURSojlLK+0CnYbS/xUJKJukb2VTVs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(122000001)(38100700002)(71200400001)(9686003)(55016003)(41300700001)(8676002)(8936002)(82960400001)(82950400001)(478600001)(10290500003)(110136005)(54906003)(66476007)(4326008)(66946007)(66446008)(66556008)(64756008)(76116006)(8990500004)(316002)(7696005)(38070700005)(83380400001)(86362001)(2906002)(6506007)(5660300002)(7416002)(53546011)(52536014)(33656002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BFZHFiou+iCCVFaD9FU08Dsd1CnuZNYPQrW7u6LwJiUqeAWwPzmS8eZig86u?=
 =?us-ascii?Q?B0PLpOEDD4yETc/pkhztZNn+uFg4NCGSZLm942ND4Bj5vdkHXD2mxicsu2Lk?=
 =?us-ascii?Q?YP3FUl0U4CKrZn+BxqyYEhH5Iaf4NVEiIWL5OpaFzGGADcug7dy43sgLDam4?=
 =?us-ascii?Q?Gm8/4kL7U0cn+TQGxAbff1niSd3OO6wsn/UTTEh9JVd6YZO1N8xqhTB4acjl?=
 =?us-ascii?Q?VQFqtpTZhkFmQLPhWRop4HuQKc/mSbJjCLP2K1ELbRgTedPZJazAObuYohTq?=
 =?us-ascii?Q?/fjWuWVhDqHDDl4BcN53fyuAObiGmc1yY9Vx0ToReS+l2QfCbtLoGM41/GlD?=
 =?us-ascii?Q?YMtWGaESxi3uVoCltL42v6kP9RNgXCozXyVyOJ+OriquyZDDDa76XFli5nHJ?=
 =?us-ascii?Q?m1YP5y3mJVmunwGzlp9n2jsYN1t+tj8BMD5HTPc9vRl6OYifqzrfMHr+Tam3?=
 =?us-ascii?Q?cBk7zIRXGsDGMH3r7gN72CJ2eTOTbDgOQHksTFvt40PYwNogjralSuQwfGjo?=
 =?us-ascii?Q?lqiuXB8ZNPp6uP87FqGuCGWsqEBCxLBPcaexj80iXZBp1K17BlPcLqWJM7ya?=
 =?us-ascii?Q?xDjU0vgRzLFUhs4rVuMUt3XKG4ZxtK20g3GZZGs76GzBVyd1C6EakEDf6TJu?=
 =?us-ascii?Q?LKy5cHbnDbC4OIqSRXePSF6L8s6VHvJkFYfZIg57sW1VPaMZAsVVmrKdOxt0?=
 =?us-ascii?Q?BpAUCGiFRk+EsnjZarlw/i15ZkpGUP8dOGjLd0VvPN1rqaEXLB9BSbIJcc2I?=
 =?us-ascii?Q?fcrEyH2GVL6Mh6g8AM0Wws5TW/faqUvaexLcXEl0jd0QwQgvDhJJlBEoKLSI?=
 =?us-ascii?Q?952+GPc7KpRBx1bWTckqLFXlDwFjPFjDis1CYuoF0K3gjuZe+KG2Y+I+nsup?=
 =?us-ascii?Q?kws1Bv0d5OYkwWJjPK63eYkQobbx4/dP5if2+cY3x5mXMWeuyev+gPjf/PUB?=
 =?us-ascii?Q?s/zTqvryzkldt2w1cQtAqbidDJ4DT54Rc+t9XwIEvm2qgUFwcjlfbXqxayjQ?=
 =?us-ascii?Q?9bUHgxIGRZsLFduZGH6hSXJoxSW5P5e8Un3FfEyC14YhBUVW4wkT25PAkefv?=
 =?us-ascii?Q?D+s6m259Yj5FxnqVsNtA+YIMNQmxcAbek41Ug7EWFLDuPUlBdXJnBZyxAY+i?=
 =?us-ascii?Q?pngQO51W0HIjN4UazUUnedG0AJXZmPZt3XnopaKGd5MbD7/PvQYGyrLkQ9m3?=
 =?us-ascii?Q?kLAbBUaj0bt7Kxz8DfMyCDkJTZ3iWnop0mkC0YMnrRu5xSFIHD1DQuiioOtj?=
 =?us-ascii?Q?sQeQlUJ5v0aBbxwoLiRlXBD0IMQYSPkCmeQHasGOBiWbw59zIHdg5VC+s1ar?=
 =?us-ascii?Q?ZxVXD8/irHe0lLU1Fhe4MCILYnmL/q0ZfWVhZUM+/esyAgTRcWmr2rvOQ/Ee?=
 =?us-ascii?Q?inBjwOZMjgDuvfmXJajs9TeGSJaJCxn0D2dBnOHm/B2Qb4dKBXAdY5f+0AJp?=
 =?us-ascii?Q?dENiW3Zgcjvj1o0Sr0EkOnkM97g72kUmVqgQEXPJJMY3PnGlz9p2SalOJJ1y?=
 =?us-ascii?Q?gYSgI4EwO0ZKHe8EsJf/Sn3DtQ62XbNkEIzp1NG/K01Qf6w878EWgVH0npsV?=
 =?us-ascii?Q?ek924Tzqkiba2p/gpWbLvxCJe+nD33RPsPl3Tu/e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f71a066-3da6-48b7-54db-08db8c5d1522
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 15:46:01.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIL+y0jUG5MlouwZJsj+P0mIY0FFUAN9YnqeODMreuhQl7q1pm1ab5eTwwHORdYu81Egz+1UYAV3DrKpoaIvLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Sent: Monday, July 24, 2023 7:29 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org
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
> Subject: Re: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
>=20
>=20
>=20
> On 21/07/2023 21.05, Haiyang Zhang wrote:
> > Add page pool for RX buffers for faster buffer cycle and reduce CPU
> > usage.
> >
> > The standard page pool API is used.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> > V3:
> > Update xdp mem model, pool param, alloc as suggested by Jakub Kicinski
> > V2:
> > Use the standard page pool API as suggested by Jesper Dangaard Brouer
> >
> > ---
> >   drivers/net/ethernet/microsoft/mana/mana_en.c | 91 +++++++++++++++---=
-
> >   include/net/mana/mana.h                       |  3 +
> >   2 files changed, 78 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index a499e460594b..4307f25f8c7a 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> [...]
> > @@ -1659,6 +1679,8 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
> >
> >   	if (rxq->xdp_flush)
> >   		xdp_do_flush();
> > +
> > +	page_pool_nid_changed(rxq->page_pool, numa_mem_id());
>=20
> I don't think this page_pool_nid_changed() called is needed, if you do
> as I suggest below (nid =3D NUMA_NO_NODE).
>=20
>=20
> >   }
> >
> >   static int mana_cq_handler(void *context, struct gdma_queue
> *gdma_queue)
> [...]
>=20
> > @@ -2008,6 +2041,25 @@ static int mana_push_wqe(struct mana_rxq *rxq)
> >   	return 0;
> >   }
> >
> > +static int mana_create_page_pool(struct mana_rxq *rxq)
> > +{
> > +	struct page_pool_params pprm =3D {};
>=20
> You are implicitly assigning NUMA node id zero.
>=20
> > +	int ret;
> > +
> > +	pprm.pool_size =3D RX_BUFFERS_PER_QUEUE;
> > +	pprm.napi =3D &rxq->rx_cq.napi;
>=20
> You likely want to assign pprm.nid to NUMA_NO_NODE
>=20
>   pprm.nid =3D NUMA_NO_NODE;
>=20
> For most drivers it is recommended to assign ``NUMA_NO_NODE`` (value -1)
> as the NUMA ID to ``pp_params.nid``. When ``CONFIG_NUMA`` is enabled
> this setting will automatically select the (preferred) NUMA node (via
> ``numa_mem_id()``) based on where NAPI RX-processing is currently
> running. The effect is that page_pool will only use recycled memory when
> NUMA node match running CPU. This assumes CPU refilling driver RX-ring
> will also run RX-NAPI.
>=20
> If a driver want more control over the NUMA node memory selection,
> drivers can assign (``pp_params.nid``) something else than
> `NUMA_NO_NODE`` and runtime adjust via function
> ``page_pool_nid_changed()``.

Our driver is using NUMA 0 by default, so I implicitly assign NUMA node id=
=20
to zero during pool init.=20

And, if the IRQ/CPU affinity is changed, the page_pool_nid_changed()
will update the nid for the pool. Does this sound good?

Thanks,
-Haiyang


