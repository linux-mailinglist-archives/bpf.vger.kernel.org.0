Return-Path: <bpf+bounces-5470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7875AF76
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CF31C21404
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F191801A;
	Thu, 20 Jul 2023 13:15:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2707717AA6;
	Thu, 20 Jul 2023 13:15:40 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF2135;
	Thu, 20 Jul 2023 06:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCKb15USw5N3dvNJwmzCR4/dwVP4uEQYUjbqui8FoLM16HtG/p7qqShcpz9GpQ5fkP8GSOSut+QkL+lKlfWLtcX871KHi5AMIPFJGSmAm97mF7hVj430v4C0ujoQ5axhdC2DDum2Qc4mobT5uCMbh1lZUJn1r4KYdfNxUqx6jVB+BDSdT4HQDRYR2OevWt+3mJ08+HV0+x+1UXrqVgWy4oJTcbwtaTWsD980ntC2dlL01S8eoEljm9fC5DfK9I1MiapICU+YD7p0/ccEu5/2r4tQQiV7uLMk7+GTTv6co2rDJjWrrUuhR6NeAYaG8Q9e9M2ym5TrlGowrAoG9qX/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nvSHRY+Yx7GWbszZ+ft1sK85G4C066hui/lJIjOxl4=;
 b=MpqdOdBxOyWNEgbYkOFERUu6Lj8y9YVDS0e6dsYiiuXVY2m3Cf48seLf0wtwpJziPQSit/FeRv2/NEy9QlOoYVyx+5iI1j2qOH/sVnx6wgcjLFYVg/yDE5D35KYhb4ihvYMWhOGKcFNfxwamRejtgKUOY36p2r0XrsL8+P37hACySJg86ol5vmrWTQ8PMxdtQlGZkUwmAtgBVNtB3CHoid44lKE3Xkir3/kh+ABVQ98/o3wCgALXlJRG0333UtlmSUtTaICGPqL6fbUkaeQmSr3WFsON6g9B8wtYunj/pVk/h7netxDHkANEvEWMeyaK+cHTXn5j/ky+DpG6bbfnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nvSHRY+Yx7GWbszZ+ft1sK85G4C066hui/lJIjOxl4=;
 b=h/0tlq662Y62GJT1pzS8wGNmv1AyfS9zekyMJIcOCjQ1XPq3a8zRrN05iiWQPg83ovGWFNH2Wz/9J/BBgziH8Je76i7GwNuC425zHLcPEjHg0ZRxlOHnHlYJU/1g3jEgsQk1UZ9LIjFSXXeb8m5YMht5jMyGPpcwxeASll4zMh0=
Received: from BL1PR21MB3113.namprd21.prod.outlook.com (2603:10b6:208:391::14)
 by LV2PR21MB3372.namprd21.prod.outlook.com (2603:10b6:408:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.8; Thu, 20 Jul
 2023 13:15:36 +0000
Received: from BL1PR21MB3113.namprd21.prod.outlook.com
 ([fe80::31a5:bfb:41e6:6cdc]) by BL1PR21MB3113.namprd21.prod.outlook.com
 ([fe80::31a5:bfb:41e6:6cdc%4]) with mapi id 15.20.6631.011; Thu, 20 Jul 2023
 13:15:36 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul Rosswurm
	<paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>, Long Li
	<longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2,net-next] net: mana: Add page pool for RX buffers
Thread-Topic: [PATCH V2,net-next] net: mana: Add page pool for RX buffers
Thread-Index: Adm5wYXxv9h/LIMj1k64MaVoaiA9DwBAUXeAABJYzjA=
Date: Thu, 20 Jul 2023 13:15:36 +0000
Message-ID:
 <BL1PR21MB31133BBFFA8C7268175C377DCA3EA@BL1PR21MB3113.namprd21.prod.outlook.com>
References: <1689716837-22859-1-git-send-email-haiyangz@microsoft.com>
 <20230719212939.6da38bc0@kernel.org>
In-Reply-To: <20230719212939.6da38bc0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f511a1e3-4e19-4c48-adae-2364410d9146;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-20T13:14:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3113:EE_|LV2PR21MB3372:EE_
x-ms-office365-filtering-correlation-id: dba0f956-2893-464a-af9f-08db892367fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b758iFJG4wP9g2RdeuZk6fiRq2TOyAIB4tRuYP4I3P89DcQ4E3vGMqPHLFFg0/zAuoczD5MlwaxAYLbubMte8/V2MEncKz4078SFy72iaONqPTzdWxFji/AujH3BaYiXCzWpSAuBVRf1MRH0zN0qeyk0Ji2qyFTVARqItKx3Ffn0eyagUySX6Z4llguqKXK0oFEb5ZaF1k96eeNQP8GjqzeYNNIlsTxJU4DK/nyxVePzI/IKK/+rh5qiLZH7Zi7QnnfmPGUAkOqiKUUsBTwvFPN6a8HgC6bITkbUIOQvfyvoQHoekBp6D2HwGeoN4Tj1GpuNWvO1bAjF8Jw/4ksfrb7dYsWXLffjMMHf1+vb5flsWR1278kD0Ys9rzSCKDsGiK+8bidD8p6gIaKLrOFX3JrLrZQ4LU5IPmOsPyh/W7pSjz6zDE2FnPb1LDpzFMjfJ/vS//qChPVm0NbYpjxCg02ByhFIs0K/RJuUOAwSuzydUp5g8qohI/AE8C4GoTO+d9u/U8kclxYopSYOjZoByaMzimFWedh4toSyaaH3EhLS+t9fxdCwEMGjS8Xtzk+gUyLP/K8yhPQBa0/0ykT8jGKxFSCvRud/620inJTNIvWX+kkTagKSMEGVg/hIB1Q0ZyU99sFtdwNPphKF8EeB091EZHdUGEMhCfZKQ6zgnB4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3113.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(66556008)(4326008)(122000001)(66476007)(66946007)(316002)(38100700002)(6916009)(5660300002)(7416002)(66446008)(52536014)(76116006)(41300700001)(8676002)(55016003)(64756008)(8936002)(33656002)(82960400001)(38070700005)(82950400001)(8990500004)(86362001)(9686003)(7696005)(6506007)(26005)(83380400001)(53546011)(2906002)(186003)(10290500003)(478600001)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ym1lQ166b/AfHWRhBMnNOAJ6Uj3be4FHaHerZylwFZjEVsGZonxQ9itIGg1V?=
 =?us-ascii?Q?tQv8zfgzu9P1vR1rFwH+pfaABpgC/f+2emN8yBsB76++LJ5pqWgq443VIMLY?=
 =?us-ascii?Q?gKS3dBBHdzdEo9/mX66hzPJwzFpvG1HQfcaUsdPblZSkdCmce9PFICKMXwPu?=
 =?us-ascii?Q?/aWoZ5aGiKfKBJHsPqT1VZZJBIy2NSotKG8J3pcMEguyWl5JfSrYfuKRcUFw?=
 =?us-ascii?Q?wpsT0ujFUMSRV269BUyvs+Q//CQX5Ki6Hwn2074Yr6nLGa6qcl3v13QWO9bi?=
 =?us-ascii?Q?P/jIvR1dUfzWCw8YP28w6AjoXx3edB1tn2m5Y2E/YMZWA5NZJ9IrVfbijXKk?=
 =?us-ascii?Q?5bp3IzbC+D/C/IvippCkxH1OobaMvNFS3OC3oCHp+nX1fTzW8GzKCB8hWCjq?=
 =?us-ascii?Q?rqrklTGPGyOMeHJqjhDknzsrHEtbZN2RmBMF2ZKdJggOZTIaHLQfon1eo3YL?=
 =?us-ascii?Q?TTWPASE9zH4+YjdqhZjY9OIs5R0Axn/lYLCagAgcSScMlrG/jagdA+NkWUeC?=
 =?us-ascii?Q?yMPBmDF3qnDjKtQ6KkMzTkas35BxSEgrI86L0kdwJYK1trUj5J5IXnSQiV89?=
 =?us-ascii?Q?bERExti/+EGbcZK13Z8nmUfr5l54e3uJyUYhmz+LIF+fp+sxgoBra8ZxZA7t?=
 =?us-ascii?Q?YlhMocyP/0Xeq162wLY8PtrBVqqwNhalH3JXdcrHfYP2X5ateDO3subhxYJA?=
 =?us-ascii?Q?bLPwwN+iGN/V6hR7IahKdx51zb5pcl7xAagqWIcKI67w71GN8jDzB+B2E1SG?=
 =?us-ascii?Q?JNvPzoaJVLeOzLTXm5CbF1GzKQdXjo5FTAMrjfIJXiwKJ4uftObafRoXn5j8?=
 =?us-ascii?Q?+C/5JwzzJF3TsBJT6MtYndcwI+hs43rSwT2RxiVDoY3ymdg7/tXM7CBLUCZZ?=
 =?us-ascii?Q?sLpZjWl6+msXsvzly1gbQbjgh/FSa1e6jBG85rWRjUyht6KKayz3bOe71TAF?=
 =?us-ascii?Q?D5TlrM3JtGDC1LYEI59tsOMwhqoh7/BPdZlDVfqqwuwqb0guGKFwy/mCG/Fb?=
 =?us-ascii?Q?q0ZQdA3+elYVcqx+koXCahph++bzLcphzAF0WJCCtOos8BacKmcnJhPbRYlv?=
 =?us-ascii?Q?dyUZjauS4NIUP7FKoDGvGkOjbUv10z0x6/kZFK74VWux9SF4M/rI8oFxnvao?=
 =?us-ascii?Q?yYPwqYxpPDb/acHN7k2FEcN90rLKz8P+5X60pqroXZHOyt1rH9cmxVKTZo12?=
 =?us-ascii?Q?XWl1DjD/7v07RwbXE9Gz5rKB1RkFheK87l0kF/zrq+DjunBpD7vFL14MPw2z?=
 =?us-ascii?Q?Vx2Bw8CrkbHlAGJS1tJq5S3JnBHo9qnLxS7ZLVwW03ZE2EJUAC3LNllhffrA?=
 =?us-ascii?Q?69Dq2a9+Aqcexj/LlxBk89z54ztxlMIZU/cWwYRaKEIuP2ghB+aP/fU6N3Rq?=
 =?us-ascii?Q?RcZjldq6IfkBhhaKJDXEc2SiBj8NE0KwpcWsB2svZt1pt2lOdrEqTDgHlIsu?=
 =?us-ascii?Q?ghAv0kPb/r/MJA76Wzt88rvWBrZ5EWsOkMh5lYKUgeBb3E8Beuv4Ue/4+T/X?=
 =?us-ascii?Q?gvECEhwOEjLnXWai0POOg3F55onNPHpd9AQJzVxen+gPd4F0b99fmrANAYa0?=
 =?us-ascii?Q?SFARayGK1Si8/1tgxTv4un3RrdSX/YXtkq8ZViSb?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3113.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba0f956-2893-464a-af9f-08db892367fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 13:15:36.4126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7QsHhfrBxRXGyRCmjGrDJdKq7GKQLF7mACOO06k78W6+yqfN+DjgGY8hw9FNdrQlUS7A0Q1z9VsMoaauLb80w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3372
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, July 20, 2023 12:30 AM
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
> Subject: Re: [PATCH V2,net-next] net: mana: Add page pool for RX buffers
>=20
> On Tue, 18 Jul 2023 21:48:01 +0000 Haiyang Zhang wrote:
> > Add page pool for RX buffers for faster buffer cycle and reduce CPU
> > usage.
> >
> > The standard page pool API is used.
>=20
> > @@ -1437,8 +1437,12 @@ static void mana_rx_skb(void *buf_va, struct
> mana_rxcomp_oob *cqe,
> >
> >  	act =3D mana_run_xdp(ndev, rxq, &xdp, buf_va, pkt_len);
> >
> > -	if (act =3D=3D XDP_REDIRECT && !rxq->xdp_rc)
> > +	if (act =3D=3D XDP_REDIRECT && !rxq->xdp_rc) {
> > +		if (from_pool)
> > +			page_pool_release_page(rxq->page_pool,
> > +					       virt_to_head_page(buf_va));
>=20
>=20
> IIUC you should pass the page_pool as the last argument to
> xdp_rxq_info_reg_mem_model() and then the page will be recycled
> by the core, you shouldn't release it.
>=20
> Not to mention the potential race in releasing the page _after_
> giving its ownership to someone else.
>=20
> > -		page =3D dev_alloc_page();
> > +		if (is_napi) {
> > +			page =3D page_pool_dev_alloc_pages(rxq->page_pool);
> > +			*from_pool =3D true;
> > +		} else {
> > +			page =3D dev_alloc_page();
>=20
> FWIW if you're only calling this outside NAPI during init, when NAPI
> can't yet run, I _think_ it's okay to use page_pool_dev_alloc..
>=20
> > +	pprm.pool_size =3D RX_BUFFERS_PER_QUEUE;
> > +	pprm.napi =3D &cq->napi;
> > +	pprm.dev =3D gc->dev;
> > +	pprm.dma_dir =3D DMA_FROM_DEVICE;
>=20
> If you're not setting PP_FLAG_DMA_MAP you don't have to fill in .dev
> and .dma_dir

Thank you for the comments.
I will update the patch.

- Haiyang

