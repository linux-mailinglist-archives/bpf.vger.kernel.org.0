Return-Path: <bpf+bounces-11119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800527B378D
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B311F283B5C
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3EB521D0;
	Fri, 29 Sep 2023 16:11:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4F51B82;
	Fri, 29 Sep 2023 16:11:22 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8636B195;
	Fri, 29 Sep 2023 09:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwMOSmVRASdNN9mMlc7tZ+E45NbI9CuHk57FWWt7bFdO94OZ7qqpBWyyN+EgZm9l4gG5JZi1qgBcIaonxgC5yeYuZisDoqyChQXlIJHEyzK1QY5NzUD3N40siz3DqPnGbB5IhwbNqSRSG/vTwbUc/R29peP4MSk2Uex3BPpYdTa1rEN3z6DQjYqbCVesOyoRxHUv3pwo8CE9WzEE0KxLdjt89wq7RIRatA98W70p2BboxcCLojWlFO4NtdQijR9hBEuMrR5wC1lggb3iUULz/YGBngV1WgSvbqlbtlujfr0ZyFUaD010mFXL174QjLcVuP0ivmv2GR/hOGcXYSqKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJC2aiQiC5hJf7OB0sZYSJBR9db5xkLTrENNImHLkio=;
 b=NClmNFJwOKmSAl0LXdqCcp4FONtN3+60njP68JVJ8Jsx/d005oipmmjY6fTWtRH3hwQQuZnmVYSIGPykWbc2Sr9n30/uLECBJABVCZAWgs4W9Ef0f1XMOr7N/sCHr10+aLPC1pw9SH5aTIqOLxoNjsCTlBuHG9+iCQpEP2xolR+HyviT4PX9q9cD6xo8DN6pO5irjnU4zz/xxAZuLlChXo6lXzoSA3/Axdox21yXoNyIPUL6B8w+AC3t4AO1C+y8xV8DsT1TmQG8R/hsh4iCI1hDG/o/0jYvoa7VBjAajbPGY91ws7qFbd8YMAWnlj6Ow0S0sHlTACXTt6E7FSoiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJC2aiQiC5hJf7OB0sZYSJBR9db5xkLTrENNImHLkio=;
 b=aLS7iNfwvb8LzsNyykKCLmNhYTe6dY+Hgny52LbY7GUul2BvnJ6ITYOT8g7FpeKjmiIJSi1HqT7jpqDfytES5IOYUunWHjr3mlrGk1O/03D3NFizN/Qghw7xeM/feyrKzx95go8+dCgPc/WLi5TfXPi0wmBoPJOmnitvD6nTdqI=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by CY5PR21MB3566.namprd21.prod.outlook.com (2603:10b6:930:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.14; Fri, 29 Sep
 2023 16:11:16 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::da2b:c7df:4261:9bb9]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::da2b:c7df:4261:9bb9%7]) with mapi id 15.20.6838.010; Fri, 29 Sep 2023
 16:11:16 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul Rosswurm
	<paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
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
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net, 3/3] net: mana: Fix oversized sge0 for GSO packets
Thread-Topic: [PATCH net, 3/3] net: mana: Fix oversized sge0 for GSO packets
Thread-Index: AQHZ7ocno89Zc74TMUuQIX+kEl2AKbAxiKoAgAB0BqA=
Date: Fri, 29 Sep 2023 16:11:15 +0000
Message-ID:
 <PH7PR21MB311698B8C2107E66890F6C7ECAC0A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-4-git-send-email-haiyangz@microsoft.com>
 <ZRaRSKQDyfkhxYmY@kernel.org>
In-Reply-To: <ZRaRSKQDyfkhxYmY@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=611f39fc-2be1-4eff-a5c3-bc41ea96f21e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-29T15:51:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|CY5PR21MB3566:EE_
x-ms-office365-filtering-correlation-id: bd7e2f18-000c-46ff-81d8-08dbc106b555
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zL6KJNDBZA/TH8z4jXn26pQohoCAeHzOhdYX4oo96ieXrmjhnziGxDVNCuLaEB+7KivAKTp+Dll2+ubHLnJp0ioyKcP5eGQ9yLuBn8kqLnDc4r95X9w+akEKNNlPn6O+ybDC1cSmffN7DyAlqcEcgdHpoqfjrsuLj8u/Bmz5aDa3NMOHA4O7GqINLJeJmCHi2GpZ87xEkaMwM3ypsq7r5cj21GICAG4Q8C951E1VtxneOjnSlYtwZ0VB3k7mYIBzWvmhwrZDrXW7ozeyDEFSS3c+EBIM+K+tzlExKwnAjcqUBCtgEwTtR5JBRjX/E728cy133bynvTPKVruvnEnOONQaVr+2NqbT1ng7h/96xyruscZN9PAviv7id9SBWgJL2NGBrHeoReuy/EKeZCRvhJ459EJ/xcE3W6CrMgcWWIJ4glBcd8BuFpm0SSb2ZNpUE893V9CoKieorUW/iNGB+4dreuNb1XpZq3WgxgvGxA1Uj21k6CpqQYY03l40n5VPzVz4In0Yc5bj7z6ls/AZRAD+9nFioj+XrorrVe0JobHF2PA1QBPkaykYyb/6F8/Ey4GTdgn3eEcBgXanagrEZHR0pWwDImAMO3M53A+gyy22quCCjB8IWsTHpgTubJPdbm1WCAMZmo2F0CFl9O3RT16HoZRuhW0XKuBR7nW06tA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(9686003)(53546011)(7696005)(38100700002)(38070700005)(26005)(6506007)(86362001)(10290500003)(76116006)(478600001)(71200400001)(82960400001)(6916009)(83380400001)(64756008)(66476007)(54906003)(66446008)(66946007)(82950400001)(30864003)(4326008)(7416002)(5660300002)(55016003)(66556008)(122000001)(41300700001)(316002)(33656002)(8676002)(52536014)(8936002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eS3lUr6R+E6w/NYOjZbvc/cNHynWoXTPIf8F11NunVm7OUov+3/e4IuF9lFL?=
 =?us-ascii?Q?Vu1JWYSDfBPWT9IysO58p375XHs0/IrVYXDuZYmwWmiY0gWOh6fWiW3w/gYr?=
 =?us-ascii?Q?DUyCAbxWLcQQdd3i1U0W4V6XUC0JAM+BnihSp0G6BdFgMxgsMY/bFXBXf+Xd?=
 =?us-ascii?Q?rvionLgxLWhD3u/bvOmqwpVqcefWJIQEr4oaCO/X51ExqhSoJTnvNDA7E3tC?=
 =?us-ascii?Q?dBkgSXOniwobsN4EJQeuM2zfdC7NiH3s73hun/sgF60SjWl/36Pq24cDpcz3?=
 =?us-ascii?Q?Zt62EIDBt4ktQnkwERFM69nyWghp3HR+K478hkFE6Sey9++UZ/v0+FFBzUp7?=
 =?us-ascii?Q?tEArFSJd3czoMC4vTkcNZqG/YUsx5y5ks1TrPZ9VitB6Jua/jCBIEk+ZuIHN?=
 =?us-ascii?Q?2HtKJbbKHu/EYaBYrtAomwtBfBSuPJ87G2o6XAn8kWMDZiuMZevriYLc4J+s?=
 =?us-ascii?Q?WmPjryvgIFSAF9cfwTqvmFn7i29Gzrke7uGchtWLcJNpds6MoEcsScrab5M0?=
 =?us-ascii?Q?SVcdOeNvWm5FUMrpFzYDL57E7eUcio4htzrK5pKLsFxCBHCWgakX4JL0zjqF?=
 =?us-ascii?Q?ri8SPHp44PtTv7pbHLyXadrS4PdO6JwX6K8b3w7qqhBOSpAnZMml6XY7OWFA?=
 =?us-ascii?Q?xSWkX0YJz7JSpDssJpLvi6N1AEcskR/ri2/rwyok5Q/4BS3VK5aEfrwxbD/1?=
 =?us-ascii?Q?AnmTIIvGTKop1cQOVaiqRr/EyBczEenoG9HocnT1QSI0uGtNBWFPQZszZ0LT?=
 =?us-ascii?Q?o7YbR6r7joFc36t6hpLKb77ZmPYNilxlGx29OzTxEUq2aEoAGZOQmO9tAixl?=
 =?us-ascii?Q?6fYIq0QEW7n89rRENaiy6Z9ESwaGDewM1Yg+yqmTiPMvCOHGOlDiEPJvmw52?=
 =?us-ascii?Q?/WBlXJuVdQ0UKdL+UEKLKSiIyJ/l6F5Kd/NGE4Esdz3LwtmeQMII8do02cQn?=
 =?us-ascii?Q?pwM1SJNeigcoswfcdNQsQZhkGNKsjtQi/gLZhgQHzB60jcopKSfVQLhsq0nC?=
 =?us-ascii?Q?V9L4RHicMkfZm9EzPpuH8vSOZNlAM7yjCepn6cdy9D/aJc5mE+fe89hUH6Hw?=
 =?us-ascii?Q?AxUYaVkA1pqJKbWwHR3+21i9Iv2g1CYJRZg4wM3HgaHZKUQT1pNy87hP+6DG?=
 =?us-ascii?Q?tO0WD5IKZoPnptC6stfF7AT62cfyA5mpMcZzLxdMNE3oTPlCrHqUMMwotgtq?=
 =?us-ascii?Q?nY5eBwtxzkhpIB3HsgTZWW6w7B3Ad9Xb9S4BwqMSZGcJD5okRvKTyabCt6HR?=
 =?us-ascii?Q?IemCfZV/SH3LrwIBRdiNgSpb/Q9ReYU/fkWP1Y0ej4Z9sjQltN+xHOrpYfBS?=
 =?us-ascii?Q?MAX3A8/qeUmEQ2b5mue0S4OGTZ1b0/oosbe2L3Drmm1tPHKwx3GraqWp1B/l?=
 =?us-ascii?Q?x8P747j8NtDiB66X1CtU5esWEkC5w58BnPFt1YKe8VZZWqi+fgRDkO6k5VwU?=
 =?us-ascii?Q?HdN7ZSmRq8PicEvUmyO31rP/3GIWxDMTTpd8f2GsSNn11gp094fZMCD0D4CH?=
 =?us-ascii?Q?lHeC7GCJSM7Np4Eac/NKlL8lQXuIizwCbwcpECJ+XPfOia9s2ERGMQ9b9N6u?=
 =?us-ascii?Q?Wi/QiWioXHw0JiGZ8m1LalDTbIiZi5DwSzrjWHUq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7e2f18-000c-46ff-81d8-08dbc106b555
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 16:11:15.8787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZpMvy58eggoUjSGH0cEj6/BBFJSRVY75UBkcPOsO6hjluZtW1pV0C83yuyHCOWPReMh9H1ncFqGJCPdLOPujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3566
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, September 29, 2023 4:57 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Paul Rosswurm
> <paulros@microsoft.com>; olaf@aepfle.de; vkuznets <vkuznets@redhat.com>;
> davem@davemloft.net; wei.liu@kernel.org; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; leon@kernel.org; Long Li
> <longli@microsoft.com>; ssengar@linux.microsoft.com; linux-
> rdma@vger.kernel.org; daniel@iogearbox.net; john.fastabend@gmail.com;
> bpf@vger.kernel.org; ast@kernel.org; Ajay Sharma
> <sharmaajay@microsoft.com>; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net, 3/3] net: mana: Fix oversized sge0 for GSO packe=
ts
>=20
> On Sat, Sep 23, 2023 at 06:31:47PM -0700, Haiyang Zhang wrote:
> > Handle the case when GSO SKB linear length is too large.
> >
> > MANA NIC requires GSO packets to put only the header part to SGE0,
> > otherwise the TX queue may stop at the HW level.
> >
> > So, use 2 SGEs for the skb linear part which contains more than the
> > packet header.
> >
> > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Netwo=
rk
> Adapter (MANA)")
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> Hi Haiyang Zhang,
>=20
> thanks for your patch.
> Please find some feedback inline.
>=20
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 186 ++++++++++++------
> >  include/net/mana/mana.h                       |   5 +-
> >  2 files changed, 134 insertions(+), 57 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 86e724c3eb89..0a3879163b56 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -91,63 +91,136 @@ static unsigned int mana_checksum_info(struct
> sk_buff *skb)
> >  	return 0;
> >  }
> >
> > +static inline void mana_add_sge(struct mana_tx_package *tp,
> > +				struct mana_skb_head *ash, int sg_i,
> > +				dma_addr_t da, int sge_len, u32 gpa_mkey)
>=20
> Please don't use inline for code in .c files unless there
> is a demonstrable reason to do so: in general, the compiler should be
> left to inline code as it sees fit.
Sure, will remove the "inline".

>=20
> > +{
> > +	ash->dma_handle[sg_i] =3D da;
> > +	ash->size[sg_i] =3D sge_len;
> > +
> > +	tp->wqe_req.sgl[sg_i].address =3D da;
> > +	tp->wqe_req.sgl[sg_i].mem_key =3D gpa_mkey;
> > +	tp->wqe_req.sgl[sg_i].size =3D sge_len;
> > +}
> > +
> >  static int mana_map_skb(struct sk_buff *skb, struct mana_port_context
> *apc,
> > -			struct mana_tx_package *tp)
> > +			struct mana_tx_package *tp, int gso_hs)
> >  {
> >  	struct mana_skb_head *ash =3D (struct mana_skb_head *)skb->head;
> > +	int hsg =3D 1; /* num of SGEs of linear part */
> >  	struct gdma_dev *gd =3D apc->ac->gdma_dev;
> > +	int skb_hlen =3D skb_headlen(skb);
> > +	int sge0_len, sge1_len =3D 0;
> >  	struct gdma_context *gc;
> >  	struct device *dev;
> >  	skb_frag_t *frag;
> >  	dma_addr_t da;
> > +	int sg_i;
> >  	int i;
> >
> >  	gc =3D gd->gdma_context;
> >  	dev =3D gc->dev;
> > -	da =3D dma_map_single(dev, skb->data, skb_headlen(skb),
> DMA_TO_DEVICE);
> >
> > +	if (gso_hs && gso_hs < skb_hlen) {
> > +		sge0_len =3D gso_hs;
> > +		sge1_len =3D skb_hlen - gso_hs;
> > +	} else {
> > +		sge0_len =3D skb_hlen;
> > +	}
> > +
> > +	da =3D dma_map_single(dev, skb->data, sge0_len, DMA_TO_DEVICE);
> >  	if (dma_mapping_error(dev, da))
> >  		return -ENOMEM;
> >
> > -	ash->dma_handle[0] =3D da;
> > -	ash->size[0] =3D skb_headlen(skb);
> > +	mana_add_sge(tp, ash, 0, da, sge0_len, gd->gpa_mkey);
> >
> > -	tp->wqe_req.sgl[0].address =3D ash->dma_handle[0];
> > -	tp->wqe_req.sgl[0].mem_key =3D gd->gpa_mkey;
> > -	tp->wqe_req.sgl[0].size =3D ash->size[0];
> > +	if (sge1_len) {
> > +		sg_i =3D 1;
> > +		da =3D dma_map_single(dev, skb->data + sge0_len, sge1_len,
> > +				    DMA_TO_DEVICE);
> > +		if (dma_mapping_error(dev, da))
> > +			goto frag_err;
> > +
> > +		mana_add_sge(tp, ash, sg_i, da, sge1_len, gd->gpa_mkey);
> > +		hsg =3D 2;
> > +	}
> >
> >  	for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> > +		sg_i =3D hsg + i;
> > +
> >  		frag =3D &skb_shinfo(skb)->frags[i];
> >  		da =3D skb_frag_dma_map(dev, frag, 0, skb_frag_size(frag),
> >  				      DMA_TO_DEVICE);
> > -
> >  		if (dma_mapping_error(dev, da))
> >  			goto frag_err;
> >
> > -		ash->dma_handle[i + 1] =3D da;
> > -		ash->size[i + 1] =3D skb_frag_size(frag);
> > -
> > -		tp->wqe_req.sgl[i + 1].address =3D ash->dma_handle[i + 1];
> > -		tp->wqe_req.sgl[i + 1].mem_key =3D gd->gpa_mkey;
> > -		tp->wqe_req.sgl[i + 1].size =3D ash->size[i + 1];
> > +		mana_add_sge(tp, ash, sg_i, da, skb_frag_size(frag),
> > +			     gd->gpa_mkey);
> >  	}
> >
> >  	return 0;
> >
> >  frag_err:
> > -	for (i =3D i - 1; i >=3D 0; i--)
> > -		dma_unmap_page(dev, ash->dma_handle[i + 1], ash->size[i +
> 1],
> > +	for (i =3D sg_i - 1; i >=3D hsg; i--)
> > +		dma_unmap_page(dev, ash->dma_handle[i], ash->size[i],
> >  			       DMA_TO_DEVICE);
> >
> > -	dma_unmap_single(dev, ash->dma_handle[0], ash->size[0],
> DMA_TO_DEVICE);
> > +	for (i =3D hsg - 1; i >=3D 0; i--)
> > +		dma_unmap_single(dev, ash->dma_handle[i], ash->size[i],
> > +				 DMA_TO_DEVICE);
> >
> >  	return -ENOMEM;
> >  }
> >
> > +/* Handle the case when GSO SKB linear length is too large.
> > + * MANA NIC requires GSO packets to put only the packet header to SGE0=
.
> > + * So, we need 2 SGEs for the skb linear part which contains more than=
 the
> > + * header.
> > + */
> > +static inline int mana_fix_skb_head(struct net_device *ndev,
> > +				    struct sk_buff *skb, int gso_hs,
> > +				    u32 *num_sge)
> > +{
> > +	int skb_hlen =3D skb_headlen(skb);
> > +
> > +	if (gso_hs < skb_hlen) {
> > +		*num_sge =3D 2 + skb_shinfo(skb)->nr_frags;
> > +	} else if (gso_hs > skb_hlen) {
> > +		if (net_ratelimit())
> > +			netdev_err(ndev,
> > +				   "TX nonlinear head: hs:%d, skb_hlen:%d\n",
> > +				   gso_hs, skb_hlen);
> > +
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
>=20
> nit: I think it would be slightly nicer if the num_sge parameter of this
> function was removed and it returned negative values on error (already
> the case) and positive values, representing the number f segments, on suc=
cess.
Will do.

>=20
> > +}
> > +
> > +/* Get the GSO packet's header size */
> > +static inline int mana_get_gso_hs(struct sk_buff *skb)
> > +{
> > +	int gso_hs;
> > +
> > +	if (skb->encapsulation) {
> > +		gso_hs =3D skb_inner_tcp_all_headers(skb);
> > +	} else {
> > +		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > +			gso_hs =3D skb_transport_offset(skb) +
> > +				 sizeof(struct udphdr);
> > +		} else {
> > +			gso_hs =3D skb_tcp_all_headers(skb);
> > +		}
> > +	}
> > +
> > +	return gso_hs;
> > +}
> > +
> >  netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *nd=
ev)
> >  {
> >  	enum mana_tx_pkt_format pkt_fmt =3D MANA_SHORT_PKT_FMT;
> >  	struct mana_port_context *apc =3D netdev_priv(ndev);
> > +	int gso_hs =3D 0; /* zero for non-GSO pkts */
> >  	u16 txq_idx =3D skb_get_queue_mapping(skb);
> >  	struct gdma_dev *gd =3D apc->ac->gdma_dev;
> >  	bool ipv4 =3D false, ipv6 =3D false;
> > @@ -159,7 +232,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> struct net_device *ndev)
> >  	struct mana_txq *txq;
> >  	struct mana_cq *cq;
> >  	int err, len;
> > -	u16 ihs;
> >
> >  	if (unlikely(!apc->port_is_up))
> >  		goto tx_drop;
> > @@ -209,19 +281,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> struct net_device *ndev)
> >  	pkg.wqe_req.client_data_unit =3D 0;
> >
> >  	pkg.wqe_req.num_sge =3D 1 + skb_shinfo(skb)->nr_frags;
> > -	WARN_ON_ONCE(pkg.wqe_req.num_sge >
> MAX_TX_WQE_SGL_ENTRIES);
> > -
> > -	if (pkg.wqe_req.num_sge <=3D ARRAY_SIZE(pkg.sgl_array)) {
> > -		pkg.wqe_req.sgl =3D pkg.sgl_array;
> > -	} else {
> > -		pkg.sgl_ptr =3D kmalloc_array(pkg.wqe_req.num_sge,
> > -					    sizeof(struct gdma_sge),
> > -					    GFP_ATOMIC);
> > -		if (!pkg.sgl_ptr)
> > -			goto tx_drop_count;
> > -
> > -		pkg.wqe_req.sgl =3D pkg.sgl_ptr;
> > -	}
>=20
> It is unclear to me why this logic has moved from here to further
> down in this function. Is it to avoid some cases where
> alloation has to be unwond on error (when mana_fix_skb_head() fails) ?
> If so, this feels more like an optimisation than a fix.
mana_fix_skb_head() may add one more sge (success case) so the sgl=20
allocation should be done later. Otherwise, we need to free / re-allocate=20
the array later.

>=20
> >
> >  	if (skb->protocol =3D=3D htons(ETH_P_IP))
> >  		ipv4 =3D true;
> > @@ -229,6 +288,23 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> struct net_device *ndev)
> >  		ipv6 =3D true;
> >
> >  	if (skb_is_gso(skb)) {
> > +		gso_hs =3D mana_get_gso_hs(skb);
> > +
> > +		if (mana_fix_skb_head(ndev, skb, gso_hs,
> &pkg.wqe_req.num_sge))
> > +			goto tx_drop_count;
> > +
> > +		if (skb->encapsulation) {
> > +			u64_stats_update_begin(&tx_stats->syncp);
> > +			tx_stats->tso_inner_packets++;
> > +			tx_stats->tso_inner_bytes +=3D skb->len - gso_hs;
> > +			u64_stats_update_end(&tx_stats->syncp);
> > +		} else {
> > +			u64_stats_update_begin(&tx_stats->syncp);
> > +			tx_stats->tso_packets++;
> > +			tx_stats->tso_bytes +=3D skb->len - gso_hs;
> > +			u64_stats_update_end(&tx_stats->syncp);
> > +		}
>=20
> nit: I wonder if this could be slightly more succinctly written as:
>=20
> 		u64_stats_update_begin(&tx_stats->syncp);
> 		if (skb->encapsulation) {
> 			tx_stats->tso_inner_packets++;
> 			tx_stats->tso_inner_bytes +=3D skb->len - gso_hs;
> 		} else {
> 			tx_stats->tso_packets++;
> 			tx_stats->tso_bytes +=3D skb->len - gso_hs;
> 		}
> 		u64_stats_update_end(&tx_stats->syncp);
>=20
Yes it can be written this way:)

> Also, it is unclear to me why the stats logic is moved here from
> futher down in the same block. It feels more like a clean-up than a fix
> (as, btw, is my suggestion immediately above).
Since we need to calculate the gso_hs and fix head earlier than the stats a=
nd=20
some other work, I move it immediately after skb_is_gso(skb).
The gso_hs calculation was part of the tx_stats block, so the tx_stats is m=
oved=20
together to remain close to the gso_hs calculation to keep readability.

>=20
> > +
> >  		pkg.tx_oob.s_oob.is_outer_ipv4 =3D ipv4;
> >  		pkg.tx_oob.s_oob.is_outer_ipv6 =3D ipv6;
> >
> > @@ -252,26 +328,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> struct net_device *ndev)
> >  						 &ipv6_hdr(skb)->daddr, 0,
> >  						 IPPROTO_TCP, 0);
> >  		}
> > -
> > -		if (skb->encapsulation) {
> > -			ihs =3D skb_inner_tcp_all_headers(skb);
> > -			u64_stats_update_begin(&tx_stats->syncp);
> > -			tx_stats->tso_inner_packets++;
> > -			tx_stats->tso_inner_bytes +=3D skb->len - ihs;
> > -			u64_stats_update_end(&tx_stats->syncp);
> > -		} else {
> > -			if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > -				ihs =3D skb_transport_offset(skb) + sizeof(struct
> udphdr);
> > -			} else {
> > -				ihs =3D skb_tcp_all_headers(skb);
> > -			}
> > -
> > -			u64_stats_update_begin(&tx_stats->syncp);
> > -			tx_stats->tso_packets++;
> > -			tx_stats->tso_bytes +=3D skb->len - ihs;
> > -			u64_stats_update_end(&tx_stats->syncp);
> > -		}
> > -
> >  	} else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> >  		csum_type =3D mana_checksum_info(skb);
> >
> > @@ -294,11 +350,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> struct net_device *ndev)
> >  		} else {
> >  			/* Can't do offload of this type of checksum */
> >  			if (skb_checksum_help(skb))
> > -				goto free_sgl_ptr;
> > +				goto tx_drop_count;
> >  		}
> >  	}
> >
> > -	if (mana_map_skb(skb, apc, &pkg)) {
> > +	WARN_ON_ONCE(pkg.wqe_req.num_sge >
> MAX_TX_WQE_SGL_ENTRIES);
> > +
> > +	if (pkg.wqe_req.num_sge <=3D ARRAY_SIZE(pkg.sgl_array)) {
> > +		pkg.wqe_req.sgl =3D pkg.sgl_array;
> > +	} else {
> > +		pkg.sgl_ptr =3D kmalloc_array(pkg.wqe_req.num_sge,
> > +					    sizeof(struct gdma_sge),
> > +					    GFP_ATOMIC);
> > +		if (!pkg.sgl_ptr)
> > +			goto tx_drop_count;
> > +
> > +		pkg.wqe_req.sgl =3D pkg.sgl_ptr;
> > +	}
> > +
> > +	if (mana_map_skb(skb, apc, &pkg, gso_hs)) {
> >  		u64_stats_update_begin(&tx_stats->syncp);
> >  		tx_stats->mana_map_err++;
> >  		u64_stats_update_end(&tx_stats->syncp);
> > @@ -1255,12 +1325,18 @@ static void mana_unmap_skb(struct sk_buff *skb,
> struct mana_port_context *apc)
> >  {
> >  	struct mana_skb_head *ash =3D (struct mana_skb_head *)skb->head;
> >  	struct gdma_context *gc =3D apc->ac->gdma_dev->gdma_context;
> > +	int hsg =3D 1; /* num of SGEs of linear part */
> >  	struct device *dev =3D gc->dev;
> >  	int i;
> >
> > -	dma_unmap_single(dev, ash->dma_handle[0], ash->size[0],
> DMA_TO_DEVICE);
> > +	if (skb_is_gso(skb) && skb_headlen(skb) > ash->size[0])
> > +		hsg =3D 2;
>=20
> nit: Maybe this is nicer?
>=20
> 	/* num of SGEs of linear part */
> 	hsg =3D (skb_is_gso(skb) && skb_headlen(skb) > ash->size[0]) ? 2 : 1;

Will do.

Thanks,
- Haiyang

