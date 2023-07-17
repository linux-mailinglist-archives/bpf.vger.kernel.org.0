Return-Path: <bpf+bounces-5135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EAA756BFE
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 20:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C411C20A8C
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F79C145;
	Mon, 17 Jul 2023 18:28:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C1BE57;
	Mon, 17 Jul 2023 18:28:00 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40A2113;
	Mon, 17 Jul 2023 11:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNLxzrSliU+Oq5yxOzPlh6WhYMTe9TxxvIAJKW6ev0NaMNGVx0lLYQUTFuMBOPyA7Oh3JY08As+Hvv93yJJJNjshfG2BboTpJKCJ1aVsMXOh6hrZjCCraTy9HM/xGQr4eBL3zL1gsCiQTF0BgdN0Ecn5+qi9Hb67KNE0Je/axiXH3rHzY8DwZeMaLYlooQybytYFXyWxpIwVAY0Tk4GbHqYiaJYWm06DL16lYN/SuhPQuwhALllBx6YI2fbu7W+3lpz1HPJ82iUW1lBAAq0pdiuampv3H/6dDE1sdcMnUVlb5d+l4qpkP+1gTd6wyjQEIk3XRDv8keLwLf3OJaS//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xECg2fdFybFeUo6Syly6J+PHeoJu2YjCl2vbEQ6tcxo=;
 b=RHeU3Nj4sVN+GCyD2tUW7HihvpWb3C8SbLiS0iuiTs81/Wf0KFcqaCfHSF6+y0JwBD8DAmtncC5TfG9uvVWCwNLZXBotXlz1LOXXi+4IF738Za7X9hohLe8Byn+aW+CVZau2JwP0rUdSWuasy+Ai/b2PGll+Aeg6UhKkh7swrOYzrMNfNdT0ObSO/A4YDXz7ehxIuiYXsrCzIuGGHwNyNMyiGgrlG3thwmMRAWolmahP1as5kmyz0FovhFUgcV+ocU5n8q1YeVuBPXgEw3+JAMTAE8CtHMKHoI/qlH1Q2Nio6/x7kL7VWtEf3rPcgL1FIVTyw9J9bwV+X1Z2Z9GaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xECg2fdFybFeUo6Syly6J+PHeoJu2YjCl2vbEQ6tcxo=;
 b=UFO2IXJk16hHG/Bauj5hlludBMcKNiIPu2z6nH2UGkfHnynvSekXm0HMt1KP0X4X/KQ8KqmIwdtbXa3sEDHRyYWwcwpx1bmqhyvw85X30CKo9/I8cQn/j9ixic/M5FTPeatmWlDQuoJPofZ5k7cDS8ZKawPI4rC7k+5bTU9WzQk=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by BYAPR21MB1320.namprd21.prod.outlook.com (2603:10b6:a03:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.7; Mon, 17 Jul
 2023 18:26:05 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::1cd5:4b0e:d53d:3089]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::1cd5:4b0e:d53d:3089%6]) with mapi id 15.20.6609.020; Mon, 17 Jul 2023
 18:26:05 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: "brouer@redhat.com" <brouer@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de"
	<olaf@aepfle.de>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
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
	<ilias.apalodimas@linaro.org>
Subject: RE: [PATCH net-next] net: mana: Add page pool for RX buffers
Thread-Topic: [PATCH net-next] net: mana: Add page pool for RX buffers
Thread-Index: Adm1mSA+i88N/DCwBUak7+uxb6tVIwAbZ3gAAAgFFQAAClU74AABMteAAKG2e1A=
Date: Mon, 17 Jul 2023 18:26:05 +0000
Message-ID:
 <PH7PR21MB3116A5F9D82745EF174B4AD5CA3BA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
 <20230713205326.5f960907@kernel.org>
 <85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
 <PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <3b043a95-a4bc-bbaf-c8e0-240e8ddea62f@redhat.com>
In-Reply-To: <3b043a95-a4bc-bbaf-c8e0-240e8ddea62f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d2dcd3ba-2179-47d4-97b2-b07df7ca8193;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-17T18:23:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|BYAPR21MB1320:EE_
x-ms-office365-filtering-correlation-id: 6ca0c1a9-3c69-43a8-480b-08db86f348b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KiZseGPOoTcJ3LmgCO+QAcsgoDSPQNwNDdaOPGcSg6w4jTVtY52nM7S0FaDLlXJ8+jJqokZxP+yXuLFnVej82WXqmGiDWonhEVRw04Tu1XUIOIQBS3puibtbIEA2tzo2Mgj1iUpRCHOncSEEa87ZBaDxx/x82cTAmwzaTZzJCfMA0d8w2+jYaICHJSNncUaRG4ME1sCroxuiiQWwFryZcDCHc0lXuBervSD8C+N4R250IaLWTN8p2TfWJ9THsgg8/f1ZnUC/KOOCDyMAGyVvYbVDhPfOLm1doUWhOI7j87GMJPYeVeKONC+NMhc7hQEMePCqWobLS8s9gqrbJynmLamYo9RVxuy99toMV4sDYpsdtKwLNt9/ogdSW652HirNoDFqWFg9KhfLc/Bew0dI98kPFE6dD5dyI//DGmC/imORH0eIkngzcHIqPSkxwzZGRZ2U8CKhwM+L4zLo48SEKqlT5iOwR30dP72sLvaJRm351ZNvfCVAO2jieTjlvvgissIyekuYDTsNL5MVDgMN+VKySn3DJMg4GwavmjegeIeoeTPIqtJg0cDI2tQM6+QhWIb+i6qMvgYtzcf4kTE7W4TXaMwR5Jnsv8N+4Bjg867Wt76PNOqBAd3QzKJad2jdeIwNt2bH1WpZ3NWoxh1HWiGW2EYOKcwH9V+hcZYoRx4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(2906002)(8676002)(8936002)(82950400001)(82960400001)(316002)(41300700001)(5660300002)(38100700002)(7416002)(122000001)(52536014)(86362001)(33656002)(8990500004)(55016003)(38070700005)(7696005)(478600001)(10290500003)(71200400001)(9686003)(966005)(83380400001)(186003)(26005)(53546011)(6506007)(76116006)(64756008)(66556008)(4326008)(66446008)(66476007)(66946007)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Oqtzz4A6e+s8dQDn1IirBS1ostJx0tkUkbk9aBTLHLC8LGIgSbSCBzHK6UoP?=
 =?us-ascii?Q?MOC9JnLO+TlP9KRlTRSiJDg+HsP30OG8gfim9kicKr9lZR+0MxUnM04vIf4r?=
 =?us-ascii?Q?qE1fmEDhIvo5BWqI8r0qPCbv8vFYv3s6hTTYr9vxjmq1b8yEB+jx1k7HyCsd?=
 =?us-ascii?Q?lc2h0swJ9+iyTfjhsKyMEKp2zSOFqnZB/ozGud9o+V+Zv+ol1RqipH79WWPv?=
 =?us-ascii?Q?+O1y9zyMTIgR7Ab0qsw3rLJ3A6erKP6S2GmpCm5SL7QKTSyaBI7kasMxQF/f?=
 =?us-ascii?Q?SrcO+bfUMQBlWJpcrIetAUp1mVk3Ei+jSgWgkEW3GkP4GOiJBQk1VU9SJ7RE?=
 =?us-ascii?Q?3Iiz3WqMtYWcNP446C2rSLcaoBGcGUJXR72ozdBB4Yw1AzAnvWkUTv5eAGMz?=
 =?us-ascii?Q?0/ubIPjdtmeZAXXDo+BWJk8+YpgLAvuLr3AUAGEyww805nenygEe6G6GizVG?=
 =?us-ascii?Q?NKhY0u7JBwj7F327mJyWPg7Wu0HwLQtbDpCPpey4Spl6tJr3r75S9BBjeR/k?=
 =?us-ascii?Q?VhDCODWQ/6Y43Df7LRTnrB5lMVRUJ8TsAFtrtEbnX6zm3g/Zv8wihVzRVIUa?=
 =?us-ascii?Q?bTipr6F+mTYABBVQ8ZInfKIIPxBFMgnQXL89+cEm48m52v3YX+9xUxjT17El?=
 =?us-ascii?Q?DFechBr2FTcYyc0HrDhj4/8uYF+TpQQ9LL1BGpl6wBD3Sfwx3SMO2XIXET9F?=
 =?us-ascii?Q?kce9gfJe0rbl7o4FGiFkpF6RFMrUvqa/CjMetnu9N1VVhVoykEmOIKQoQepJ?=
 =?us-ascii?Q?MjaPfFxUKwp4MeCt+9S7SxhrwTUTZ58DoW2RzEOLIIv0qMWYtKlo3/wNREWz?=
 =?us-ascii?Q?Kf3Hc+ICxHZBCeOficlEJKtY1AKco2FqgESn7Tfz3khaxWTdyawsNnn2tTeD?=
 =?us-ascii?Q?XyOmOSHOrUcinBjbbHN7r3YtDCjNgO1guP0oE17ZGaKdzP9qIrWOCl4ZaijI?=
 =?us-ascii?Q?XoN3FEdTaltVTgs0sTh9batHfbwALEux/y5Uqx2Vn9Uu4W3XbN8rE5trK2GT?=
 =?us-ascii?Q?BbD7UNf85HpaCXExF8lX3RSBZKuSuuSwYLiXi7R0AOYOxWK1U3M+bOPTWiM4?=
 =?us-ascii?Q?awD/RDWquhsOGCv/T6lqHlY+ZEaDv4+lxJubTAiFH106MHaYIaUKfMpiIObS?=
 =?us-ascii?Q?p5uiJM73v7flTgZPDA/XldGbCu4+2xPb8n1B+eWUYLFPTfyDpZ2ge2xB3al4?=
 =?us-ascii?Q?lIVWaFrQggYlicc8G3Wh5O1XFeU/wfzmlvM8HRheazMlWoUR1u8skN9D+t9V?=
 =?us-ascii?Q?+Hd230I138RTvz9eW0DCTzebBEUW85x/q8UOR5H5E8YMX/Afb3rinBeZXL4s?=
 =?us-ascii?Q?0d2Z3cXWYJoclDBwqnSw3rL4N7qWzTN2+DKpDJhU+hlVvj2PgfVZ+cBNq2NP?=
 =?us-ascii?Q?VgUNxFjdiqwQa+DEBsUP/OpPvGhL1sqxGGcYhy28lj1P1o8nmF2E3KYM4M/g?=
 =?us-ascii?Q?S1y3M5RHwbuHsSq1OeN12Ua7aDlNPgrZOn+9H8eRmORBMKxv6cOCSm3amYq5?=
 =?us-ascii?Q?UN0WTT0SlHA5U0MZfur2lGGpTUNuBHkPsgVmo9aTAVGIlY0rDJdgocz2XxJB?=
 =?us-ascii?Q?rdZ15ULG3/eeSIn4JbfhOor6jYoqENz/59PwafzU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca0c1a9-3c69-43a8-480b-08db86f348b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 18:26:05.7630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnsjoZ8YEnPu860U8/I2uNnv3UQT/yfpbCLaFXZhDVV0LNx9p/veMOprpRlv+ytnUZh5b7ZfC1P9rt+liENWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1320
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Sent: Friday, July 14, 2023 9:13 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>; Jesper Dangaard Brouer
> <jbrouer@redhat.com>; Jakub Kicinski <kuba@kernel.org>
> Cc: brouer@redhat.com; linux-hyperv@vger.kernel.org; netdev@vger.kernel.o=
rg;
> Dexuan Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Paul
> Rosswurm <paulros@microsoft.com>; olaf@aepfle.de; vkuznets@redhat.com;
> davem@davemloft.net; wei.liu@kernel.org; edumazet@google.com;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; Ajay Sharma <sharmaajay@microsoft.com>; hawk@kernel.org;
> tglx@linutronix.de; shradhagupta@linux.microsoft.com; linux-
> kernel@vger.kernel.org; Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Subject: Re: [PATCH net-next] net: mana: Add page pool for RX buffers
>=20
> [You don't often get email from jbrouer@redhat.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On 14/07/2023 14.51, Haiyang Zhang wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> >> On 14/07/2023 05.53, Jakub Kicinski wrote:
> >>> On Thu, 13 Jul 2023 14:48:45 +0000 Haiyang Zhang wrote:
> >>>> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> >>>> usage.
> >>>>
> >>>> Get an extra ref count of a page after allocation, so after upper
> >>>> layers put the page, it's still referenced by the pool. We can reuse
> >>>> it as RX buffer without alloc a new page.
> >>>
> >>> Please use the real page_pool API from include/net/page_pool.h
> >>> We've moved past every driver reinventing the wheel, sorry.
> >>
> >> +1
> >>
> >> Quoting[1]: Documentation/networking/page_pool.rst
> >>
> >>    Basic use involves replacing alloc_pages() calls with the
> >> page_pool_alloc_pages() call.
> >>    Drivers should use page_pool_dev_alloc_pages() replacing
> >> dev_alloc_pages().
> >
> > Thank Jakub and Jesper for the reviews.
> > I'm aware of the page_pool.rst doc, and actually tried it before this
> > patch, but I got lower perf. If I understand correctly, we should call
> > page_pool_release_page() before passing the SKB to napi_gro_receive().
> >
> > I found the page_pool_dev_alloc_pages() goes through the slow path,
> > because the page_pool_release_page() let the page leave the pool.
> >
> > Do we have to call page_pool_release_page() before passing the SKB
> > to napi_gro_receive()? Any better way to recycle the pages from the
> > upper layer of non-XDP case?
> >
>=20
> Today SKB "upper layers" can recycle page_pool backed packet data/page.
>=20
> Just use skb_mark_for_recycle(skb), then you don't need
> page_pool_release_page().

Will do. Thanks a lot!

- Haiyang


