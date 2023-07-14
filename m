Return-Path: <bpf+bounces-5018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E9753B55
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 14:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05E81C215BB
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858EF6AA6;
	Fri, 14 Jul 2023 12:51:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E41371E;
	Fri, 14 Jul 2023 12:51:47 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379B8173B;
	Fri, 14 Jul 2023 05:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqKYtkWuH6aoBTPYDgPnAShNIzXtpg4Uf6kOXuXWWTG53EdBNuDYQVGhy5tvS5SIXrkPd/rrHte6q/DOkq4aTChA4QueZM1X6V9VfTr03jgy6efyjocDMvCP9ch48+0p0ZJC++770oRhgAMFovvNu+/OcAVGkMvwa6xrgxdnUM3foGqcW9USMSOGy3sO5zOScdiCv4TY5dF5EPOEqcaMlHnTnfYNspx9Spd5xhL+PEKrqOgNCCFS4RsnjPg2VyX+4gWNucPCmNmyKCZB1hZQQZVmEB25pMEv4jWQKb5Uxh0O2fy//ct/goPJZBjhqcQrquNZIr15FhVBPZVRk8otzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjeUD/cm4TRxtFhXaNnD2WHoiZYCeEOVmR3zeCMy8rs=;
 b=IVcomRDuec2dxG7GBtZaP8W+J2UqtGy4qspax0yhTKf5HHbtuoRS3NVFiWq2I2dPkBKDp7glLAmBR78A2QlqXZ0pe0gLJfSxQ3y+aG5DRqSP81jSRjsExwk/aJXp3RljX6OZJqiwEUGcTP4YVGt8SgwAhU4SCATNAVjvPfL9hZJohQ9QUlQrdH6R6g4do5TKDOSeLv8pj8rgo4nwR5UcxzYuw+mT5yxZ5gw23mhhcel9Fo1mftGAtYIferCHZherF4UfB6nZpSGK0VTeYrDy9quZd6TjKpTCsWj5EiefSN95JAvpzXdNYS3sIT1XZUIKP/e7YbWgcGCQdap094PXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjeUD/cm4TRxtFhXaNnD2WHoiZYCeEOVmR3zeCMy8rs=;
 b=XT4Jss09CW14oidbUDlfoha0tcOtRh9IaXxRsejuIL17BmcxEPIiZFy+oehOYvBDf/PPr3J+4JNzn/frbnO3710SdGGB14uQ0RofaTMwhOsK7ad9VtlCU7WhJe+Ti1wMHjwfEWukMoR083R/1nPlUsq/All09KfPwMAo1kekaYY=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by DS0PR21MB3928.namprd21.prod.outlook.com (2603:10b6:8:12a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.1; Fri, 14 Jul
 2023 12:51:42 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Fri, 14 Jul 2023
 12:51:42 +0000
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
Thread-Index: Adm1mSA+i88N/DCwBUak7+uxb6tVIwAbZ3gAAAgFFQAAClU74A==
Date: Fri, 14 Jul 2023 12:51:41 +0000
Message-ID:
 <PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
 <20230713205326.5f960907@kernel.org>
 <85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
In-Reply-To: <85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3cdd08bf-ea10-4683-bb9b-e9df80cff03b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-14T12:38:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|DS0PR21MB3928:EE_
x-ms-office365-filtering-correlation-id: f7db622a-30a1-4853-6b78-08db84691279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sYnTBZO2POXrni1Y9OQDBlQUSswTpvH/ApKMCCb8mLnTKfgBR7ysp1XcONAJ29eFmfEbpw8CiUuUzrL/9x8MFiyZZbF3VQaVWzi/eKSsxq+EhNTxblEArocQ6Co4YBeCINEB7VepHwavxtZIayl9ozJD3f5lni1IMM+vFtBc3kCd6lFaceKVRwGt40e3hPutKsfBZVmac9euku8FunPmZ7zsS70ZzT2BBbmuLtLLQm8MN/Rcyk9C9yfVFikk31/v6ApxDFf8pX9LIBP89/gUaFDtanDfb+mqzYYokfGoPhW8yXvhTXNwNsCY1rRiIL8zBR7HtSDRoheSfQd0rJboRbkr0KyUxOSyxqbblFybBESs+4S4WhFoV+iLHZvkAD+kLmT8zoNHX6A6m9UvkcCz1j0X814VQWLXS0Sx80e3kkcrxs/c09zyr92/E0DbRMOSx09ggIIMpA0WGx2RdTKW9nITYxTCacM328zkPaQT8Ct4yMINuClrxJSP6pZC6hkI4oYv9gVMaOEnNcAwUIrLUTlN6ditbZARtOS5aRUkIJMVClW+hNDkd3eew4tsHE8hS/pZX2bmv4cxXZ4xFYHE10qaE8vXQez6yZkAzTrwqo0aDhCEGUf1u99pTEcqCGSkSbgl7Vwvmn7yL3n0r55MDORB6PQh8ZdtSlJZPF6+oC8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(41300700001)(7416002)(2906002)(86362001)(38070700005)(8990500004)(33656002)(26005)(55016003)(83380400001)(186003)(64756008)(6506007)(66476007)(9686003)(71200400001)(7696005)(82960400001)(54906003)(76116006)(122000001)(110136005)(8936002)(8676002)(10290500003)(4326008)(66446008)(478600001)(316002)(38100700002)(5660300002)(66946007)(82950400001)(66556008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K9J2H710GKRC5KZlAHz12kSMWOJUlf1Y2rWc3GVzBon4D3Y+IS9XIED10gE5?=
 =?us-ascii?Q?EQq+ITr67Pz3HrDur3uPt+305YK428DFBcUed+GK6Ufu2yXQ68iJLAo4USsJ?=
 =?us-ascii?Q?mxE7Nidp0H79jKrXdnkK9ZD+7aHwfBMZgHo95RkQkkYPDKUDNXlQsPtA0Mlp?=
 =?us-ascii?Q?n56ylCwSegWbHGZVfim2DwpaFhQQeX2EGFq2Wf/EuuVj81hcjZEM9jytbdmy?=
 =?us-ascii?Q?uFQOqC5+lXS40kfnC3SoVL7MfYx8lWeL90X6OV4QyYOHRH4wWtnMrrsE960Z?=
 =?us-ascii?Q?KHU12A/yBw2qkWu5A0i+USs3dN7iN9gRYiFBIUmzbSdzwa3FNxrpnyxcD8ro?=
 =?us-ascii?Q?F13ilLj7HwVsxyHUk10q7ofAj0hY2mXC+gp3Vf5w9iWv1vmLCwH4a2xJ+ugF?=
 =?us-ascii?Q?BfUKTAFgAKpA+WskIAaQuMzYPDBGnCpLpkR+KebTkU5N/KlxNVgpqJfzlFgh?=
 =?us-ascii?Q?tCDXxInP7xYOe5j++FS2kXVRzZ3azbn0QzxjP5QK0EpiBr11Prf5rdtNP58j?=
 =?us-ascii?Q?UcEiBMWC1FN1OFxUygljCUs/LkwxZW2RkWfMCJv94gNDRWrHNYQd+ulyQrp+?=
 =?us-ascii?Q?O8vnAedwRPofXpnX81Ox1r3jyav41Mv1y8l1AGcZRpeVzhfLPG6wbW0RhNbS?=
 =?us-ascii?Q?NLKfPV66LeylXo8WXak0WVubcAHqaHhaoGmeUJAhWJbpls7O81BjJkq2D1qW?=
 =?us-ascii?Q?a5cKOqqFUQgeAS1MfaLFPEqmwuoAmkaY9gWR5VHr/gAHkYFVpTIJBp6Xjiga?=
 =?us-ascii?Q?W9GhnUhAnOYPL4eTowx9mnTlZSpFpcOBUbBtgGPoTj0QTFvK+++QIQOra6Qk?=
 =?us-ascii?Q?AlGALTeM3hPbeyzSkNuJqmnSaM9N3LVHnaT5oLUrgtw4MyXqMU/DEGY2MlYK?=
 =?us-ascii?Q?2RxOqg8FTl/vBDKr26Hc5Xxl40u/D2YjdLKn7+5uTHKD+ITdAF8+K9WCbtJd?=
 =?us-ascii?Q?v4zqzcF6DVFmFq0yjfQmFbYy3H6BEqi9toe0XrBBqq+JFwSgbsIqr3a1I7/U?=
 =?us-ascii?Q?2JJ7717W5VLGlLJx67bsFlW80HNg90+GvJ5BUXKwcZ5+SWyFZSzdw5HlS73Z?=
 =?us-ascii?Q?hTbvjsuRGYz50lnx7nKq3faarPtTImnQjSPfulR1zgN/EupvSOfL31kZn5/k?=
 =?us-ascii?Q?IVZnc/uTV0MKA4mfakkXShkeKL1T5v8li7RmNB7mRLMlGKXguqlcTONsSZqE?=
 =?us-ascii?Q?d+/pkNRVtiwU9l8rF/g/XTRjK3lP5ak9FQxQqLXyq6MrmuyEA04xB7v77P+W?=
 =?us-ascii?Q?15kG4c244u2lcOqPQ4BH7BCkaMF7Y7QdmHCN4ESUm0wXD5PbNc89bNDq+ZLY?=
 =?us-ascii?Q?q7ETvPzkrJbmX8xTcT1mLA4U9a4mPvC7BuMdoneDkoLxoIjPDZ5FMe6QUURS?=
 =?us-ascii?Q?1ReCFyDef38n9QyO2hFQeoo1qwGBSoTHaof6ZaIkfoJf1lAWT7nOckjKEqJP?=
 =?us-ascii?Q?y/WoCefDcCz7ciFCEzceAXUFcuFe9x5fPJNajneTCVHRv/l0Ea3qxGxlA5lL?=
 =?us-ascii?Q?ymovJ//ERckTLvyH7bagBZHnBLPwOhCjQPOP37QifEKgE8IWxCiSRjsTr5K+?=
 =?us-ascii?Q?FXQK667iter3XIjo03sh8R05cilBidQ3KBB1WBy9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7db622a-30a1-4853-6b78-08db84691279
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 12:51:41.9017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxTUxmBrzvb2KTDw8pteweKpX0GFLpqx1h2Z7g5yroA/mEzB9ez550YiaeIGiGR5ft9bSRO5cDFr0cvrhF4S7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3928
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> On 14/07/2023 05.53, Jakub Kicinski wrote:
> > On Thu, 13 Jul 2023 14:48:45 +0000 Haiyang Zhang wrote:
> >> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> >> usage.
> >>
> >> Get an extra ref count of a page after allocation, so after upper
> >> layers put the page, it's still referenced by the pool. We can reuse
> >> it as RX buffer without alloc a new page.
> >
> > Please use the real page_pool API from include/net/page_pool.h
> > We've moved past every driver reinventing the wheel, sorry.
>=20
> +1
>=20
> Quoting[1]: Documentation/networking/page_pool.rst
>=20
>   Basic use involves replacing alloc_pages() calls with the
> page_pool_alloc_pages() call.
>   Drivers should use page_pool_dev_alloc_pages() replacing
> dev_alloc_pages().
=20
Thank Jakub and Jesper for the reviews.
I'm aware of the page_pool.rst doc, and actually tried it before this=20
patch, but I got lower perf. If I understand correctly, we should call=20
page_pool_release_page() before passing the SKB to napi_gro_receive().

I found the page_pool_dev_alloc_pages() goes through the slow path,=20
because the page_pool_release_page() let the page leave the pool.

Do we have to call page_pool_release_page() before passing the SKB=20
to napi_gro_receive()? Any better way to recycle the pages from the=20
upper layer of non-XDP case?

Thanks,
- Haiyang


