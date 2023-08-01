Return-Path: <bpf+bounces-6556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ECE76B741
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CEB281A6D
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE80E23BEF;
	Tue,  1 Aug 2023 14:20:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B232151C;
	Tue,  1 Aug 2023 14:20:13 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9231FFD;
	Tue,  1 Aug 2023 07:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWEdtVRax9sElBzEvXQaPlynNKuVzwrdGn5z62Uv2J/ES9Vw9CxIyKDc+YQHKPirq4EJYtHu61SsaGJBcp8iBHheeojFeUvMNpjFn6X5YHeaYcZpu0FYYoj0K94JkLNfqhxDaBdE7QMSaeGxmXsodGQhhM43T0ZrH9cSy9GJrJvlJ286pN/Vb5PqW2u5a3fdBQT5Q+L4dwQTlOBKi8S6cg1gZvxp1wxBhTnl0QowpieUevcjxhy4h0QWZpamCHv6bT5wj18tWi0grdWGxEnNZQVjwpfaduHUE6VALvKpe6rZZ1gmPIR3IHUbEk2XWSKhTEnInG+Ag4KREhJfDM5DAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Apt1mzF0xom3R320InKJZlYrsTY07kFbDGQhWzTnqVw=;
 b=BFooWYlCRBJLtCf+nWy4dxEMA3DgiFTe43cXc8XOGSLWXOhM+1sYgsyVkKgkLhr/LLHl0+Rz7uLEbUrElTJ9+en8OsBTos/a41niXg1KLBwEccMWAedmbtmPvC7GSJn8BuOFF7ms0oU+Qzxn2wBR8QOT0KYCDA/+iBWwe+c9oBWPOtJtPVl3bMJ58j4lKu5CQ5fAnw/SjkWgI6cWRtRAYo8hmpMUoFIYXV4Le/rcyvH+3Va+zJrLvHiUS+Bv5cqg2NLC4wgDvDCxBAQm1xAp6UtchrRVK6kGgHQXJd+twKf8s3WQ4X2IxvQuiUqoITphSTXYOYp2bJdj6lC6cryNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Apt1mzF0xom3R320InKJZlYrsTY07kFbDGQhWzTnqVw=;
 b=GpnnsMOLH8Hpi1MX1UczMQtmxdVMcwvXhaisRCifaOuuaPIi+3rySU70Hw/kGyPOR0xu6It+BAUcIZdeWjL9tll9VaiGCDDQw9gGckuBespZBnWgftbpSOZuc6KXYMngb6v/TwZQzxgP1iifu1Vi36xaVtl4jgckxwrqAI8PKLo=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by MN2PR21MB1488.namprd21.prod.outlook.com (2603:10b6:208:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.2; Tue, 1 Aug
 2023 14:19:57 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b%7]) with mapi id 15.20.6652.002; Tue, 1 Aug 2023
 14:19:56 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul Rosswurm
	<paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>,
	"hawk@kernel.org" <hawk@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4,net-next] net: mana: Add page pool for RX buffers
Thread-Topic: [PATCH V4,net-next] net: mana: Add page pool for RX buffers
Thread-Index: AQHZwZz+PvYViSLhX0CO26gqfH4jSK/Um8CAgADmSiA=
Date: Tue, 1 Aug 2023 14:19:56 +0000
Message-ID:
 <PH7PR21MB31164197BB4854DD1151CA34CA0AA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1690580767-18937-1-git-send-email-haiyangz@microsoft.com>
 <20230731173119.3ca14894@kernel.org>
In-Reply-To: <20230731173119.3ca14894@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c2030880-6a0e-4d3e-b657-40828f2ff054;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-01T14:15:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|MN2PR21MB1488:EE_
x-ms-office365-filtering-correlation-id: 3b5e5aa4-b785-4785-f3a6-08db929a61df
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kJAUxEi5/bXVf3C88aJuftmCtKA8K1WKxQPcrW0jCEgTIraf3ySxbOy/pyIYj4OKo3cEelag1o/9umOp+PDTVozVPStVx7clRgYS3U+pnU6r2U/+Y7ljqhkn/idGpY1a1R0HOBzSMVuhYkazkAwGWkmQHdpcWBTjtyeQfLTXhnrMM/40O8V0lKbNE7LSUhZNzSaRZsWiGfmtJ4YV29fx60UtP4765YnaIlWxseUYUu7A5S7CnEBl5RX+Cq/nvPYcpx+UTJ5lE9UcAcnbXFf2dDS4jMfpDZ88BwNCMJfxcqcCJSHl2ze7I6eZpbJ8xanS5pcjToGfDvgeIEHw5n9nZG3Gh3pr3sQCR7gUg22FHFYWEP2huGAjxSlcXuTsDT/L1zFpL9P9f7pdFyl3NbOenxC0B2fYoHjSnmgaaaPv3ao92DLjhysAeGUPaPIN9uVGmhAhs+euYx0CTzz8EgaIz3gkO1aY199XYEN4ju85exCWM+W3ucNv2qC9v2oRfDU9Zg5zWroWTgbPWnFS4iohFuw+vqRxabsApmgiizdJw3CsgtbpbQkpg625C7LS6cPaop7Lm0TLgUxPl02iQvS157MWAA/jEGH8hfZVgVNzLu0pxEM1HbMnY5wxV7rabSiccWXg6VRTdsfnQ9YfPWkJvg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(38100700002)(8990500004)(66476007)(86362001)(786003)(8676002)(8936002)(316002)(64756008)(5660300002)(4326008)(66446008)(6916009)(54906003)(7416002)(122000001)(33656002)(52536014)(76116006)(66946007)(66556008)(82960400001)(41300700001)(38070700005)(82950400001)(478600001)(10290500003)(2906002)(71200400001)(966005)(9686003)(7696005)(6506007)(26005)(83380400001)(186003)(53546011)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PeBDIEqho1o1odxYD6iure8FJZPmmMlpg2Ak++jU6dq3tRt4W41TM8vFPJ+e?=
 =?us-ascii?Q?xx2KSAKZ3N08bcDTP5GuFVfJpGX1UvcIdRKVZguhXVTrDyBlJyow8+uuJpek?=
 =?us-ascii?Q?6Ql8hgAB1NPyzDsesqhETqQ/KvskhyUsHyXtMvkb9XL21tyO026K9L0Dkg2v?=
 =?us-ascii?Q?M5Hw6VuCfHEy19q10S7Kn4x5VkbMHrGJrrmeNDMUFFhicdL1QLd8zDYYsoaO?=
 =?us-ascii?Q?0E5QGPGpYT4yk28HJiM2O5Dhh9nSPYO1rHLVQZmbVaBfoUflbgyeBhQscZgf?=
 =?us-ascii?Q?MNXcjTSTw14gh8aRk1qwxAo6AUR0gPGkY7sZZE42YKG3RD3HpqnWii6OZSkI?=
 =?us-ascii?Q?BGdNyvT0h0iq+Fkntna+g/wZ+VhEG2H9KP/Czge6DntDxXGHWHmVEwGUXcez?=
 =?us-ascii?Q?rAxzHkclK/CfTEz8TE4ajL4bKmVHWKTkVGdTBGT6A6sOD3/HLYFFOrqcm9KG?=
 =?us-ascii?Q?k8wQFffTMnW+p9DgEQaOY4tB5qD+IdNx/YeSFSZju6WSmVRyhZ5eVn2i85aG?=
 =?us-ascii?Q?xZINvXMg82PVc3sSykGPEuN9Agu3/T3fXgLg1Y+7rfDD+8jpyYWpuu2UWoyh?=
 =?us-ascii?Q?Et5sc2+qG6HCCnP5zXHWMs3d8OQ3w+3hMpnS9/LP4yXQZC83Fjehdrln8BM9?=
 =?us-ascii?Q?sULB9Gkeau6WmFrVWA+46c870oKWFzyySxDrrwwOv7NT5PVEYU1egyuRBvyM?=
 =?us-ascii?Q?gSdsnEaNTYWrNCN/ZJXLD9o4fmtE0CXkD0D0/elC1vckhMahGkfQ8eL4OmGu?=
 =?us-ascii?Q?pYqHm7ALBjvHVdtPzJz3n4TAf4QACW2g34zUXKMG2CVbbBt2xWk0Yf7hHBMv?=
 =?us-ascii?Q?uKSfqEowHZ0L15JUw6pp0UHN2dAV4NmZGkt5tKbtOYfE3N/Ze+o8K1538I2X?=
 =?us-ascii?Q?cDNl0Pqv8WaZEqDADT7RVHh7Np0dZ945CAOXAKJxYa8QWvqSHCH07LYe07AV?=
 =?us-ascii?Q?4D7dO28EnSUeCU/P6VHysIEcQr2XUCgc5LaKJT3ulNncXD75MlIWBkV8MtXp?=
 =?us-ascii?Q?XHrqoKGlFbUrZs1rxN0yzrlZXh/T0ZAgdHEgWfNbYBlCqM65OyCVgAV/7OM5?=
 =?us-ascii?Q?KNQuhqrv519lxPJJ18QIcpFgEqm69N9nOGAPymmLYomIAtWpj4muMrjHEu79?=
 =?us-ascii?Q?RfI/tpTF2l6dA1u3BIt6oktUKurEJXT5hJG0bz8Pe2EEmGOGGNPwVxhkGj0R?=
 =?us-ascii?Q?5sXoxqXDGXfQ+1D/0VERBrF8D+Awhop7j+uXnBe0qdwPdVX5sPgCV5Bdkg5n?=
 =?us-ascii?Q?yM+3aPq7tAdJtIdngqPPlsm8SL6mWDCUwjfOmioVgP2Faggb4TmGTGHOrpod?=
 =?us-ascii?Q?Gx5IDt7poH7KIEi51XwE6dHmDK5V7GtLQCz619o8+BiCwqDzphPFQ8miPCuD?=
 =?us-ascii?Q?tfD3lv9NCWrwpIEfyBSYqhWQa3GMjAz5a7W8vWqQjW6NNg8nmFnOx5jhXDoE?=
 =?us-ascii?Q?8QGzqm2/vnXNkV2Sidv4pruLhrKz/2KXHiygyHrD3AYPMQeo5eWcZ33nMBwK?=
 =?us-ascii?Q?iZcZl5YSsQ8O3FwwKAVK7YfF6nlhf3rQg2zgg/LiXUFA0283VUF3o8daSoFx?=
 =?us-ascii?Q?YcS/+fcvShAuzmyOhfGxmPO1qLqJTTzd3yZwkzP1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5e5aa4-b785-4785-f3a6-08db929a61df
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 14:19:56.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8g/W42EzRopmQHiWk6qBeNDd+fzphWHBGlHDFG6cV19yu4FWlG7FCRRfgvxImI3Uyo4fe3uf6y+JMwuQ9KzaYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1488
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, July 31, 2023 8:31 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Paul Rosswurm
> <paulros@microsoft.com>; olaf@aepfle.de; vkuznets@redhat.com;
> davem@davemloft.net; wei.liu@kernel.org; edumazet@google.com;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; Ajay Sharma <sharmaajay@microsoft.com>; hawk@kernel.org;
> tglx@linutronix.de; shradhagupta@linux.microsoft.com; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH V4,net-next] net: mana: Add page pool for RX buffers
>
> On Fri, 28 Jul 2023 14:46:07 -0700 Haiyang Zhang wrote:
> >  static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
> > -                        dma_addr_t *da, bool is_napi)
> > +                        dma_addr_t *da, bool *from_pool, bool is_napi)
> >  {
> >     struct page *page;
> >     void *va;
> >
> > +   *from_pool =3D false;
> > +
> >     /* Reuse XDP dropped page if available */
> >     if (rxq->xdp_save_va) {
> >             va =3D rxq->xdp_save_va;
> > @@ -1533,17 +1543,22 @@ static void *mana_get_rxfrag(struct mana_rxq
> *rxq, struct device *dev,
> >                     return NULL;
> >             }
> >     } else {
> > -           page =3D dev_alloc_page();
> > +           page =3D page_pool_dev_alloc_pages(rxq->page_pool);
> >             if (!page)
> >                     return NULL;
> >
> > +           *from_pool =3D true;
> >             va =3D page_to_virt(page);
> >     }
> >
> >     *da =3D dma_map_single(dev, va + rxq->headroom, rxq->datasize,
> >                          DMA_FROM_DEVICE);
> >     if (dma_mapping_error(dev, *da)) {
> > -           put_page(virt_to_head_page(va));
> > +           if (*from_pool)
> > +                   page_pool_put_full_page(rxq->page_pool, page,
> is_napi);
>
> AFAICT you only pass the is_napi to recycle in case of error?
> It's fine to always pass in false, passing true enables some
> optimizations but it's not worth trying to optimize error paths.

Yes, this place is only for the error path. I will pass in false.

>
> Otherwise you may be passing in true, even tho budget was 0,
> see the recently added warnings in this doc:
>
> https://www.ker/
> nel.org%2Fdoc%2Fhtml%2Fnext%2Fnetworking%2Fnapi.html&data=3D05%7C01%7
> Chaiyangz%40microsoft.com%7C82fcd2d20fe54dd8cd4808db9226a2c7%7C72f9
> 88bf86f141af91ab2d7cd011db47%7C1%7C0%7C638264466881746523%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DD9ac4TnYOSPwGmk%2FKX
> G4buu%2FKT7J%2BuH8lAJNPl%2FRWy4%3D&reserved=3D0
>
> In general the driver seems to be processing Rx regardless
> of budget? This looks like a bug which should be fixed with
> a separate patch for the net tree..

Thanks, I will look into and fix this in a separate patch.

- Haiyang


