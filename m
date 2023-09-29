Return-Path: <bpf+bounces-11117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EF7B3743
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 17:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D236D1C20A03
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46529521B7;
	Fri, 29 Sep 2023 15:51:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48553513C0;
	Fri, 29 Sep 2023 15:51:57 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73219139;
	Fri, 29 Sep 2023 08:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3KbGc9dCvVAL3m2i1B4FPVo4bxMK7m885eiE2vyin9OvCqRNMf+jLftx2W586gaJItOPyDO3AWZY6nFd7yazp7qBBKz/AX3/xNwQnbs8RKVKlOSeRg62tmdU6dC1VlOFk6zm5a4ceUFU9elOiOEkd157nslqC0QapnZKthERTIYTOUPcKr3UMWPdVDp6QwaAadfLrUl/uZo6Qq/Fn3gQLXRxVDJJ5dzCrQTbDE45kLT/GZTfPPqwB9AC7g/ExKymOY89WO9bDhGmjMAG+VE/CBS6zIat9DhHmG2ojE161K6ctyvV/dCya+M/73G3P/bhmKUJ+1gnvAmLhsgN2bd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIPpshK020HBqkZ2JGexmD8GkKIfPySvj44NMeP/OOc=;
 b=kOh7UYn+P+yuOWSy9Fnlbv1RAVhvFr+uCOoluKgfYd9UgSWV9cfcERqwmSY6ubCZx0YqilnLhIhElNyktFTaFhWa6tqOAy1Zu8B22Iz7m6EwisEAoXdE8MshgYv8zcXCWThst/W6EEMwASadHQ3XEmL1WaT/7YJxxeti+V91NtVr+uP3ySyJSFvDxkxj2xkM9PVc7gA30Fnjz2ggC+SMBtgjJ1ws1ZWN9snNWjtqk95fx2Qe7f3tG2jeq856SQ0xjCGGAPw2uaK+aBCc6jRhQKtfXneyx2uI3nU2bfyGSwNacj8Oa4NIKTjBhZmCKTpWNXPoQWdNrHLzqbjvBJ52Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIPpshK020HBqkZ2JGexmD8GkKIfPySvj44NMeP/OOc=;
 b=OcednW0F22gpmc5nJa6KQF2PvT7Ngokjt5/MaV4dIV/DzWz+cUb0wyYztV40ZE+pWbFenNbIi2HTXYQqOYe5JezbSqIw5v90dpwURercy7ITaI4qfWxmbeTI5nVQ/WDHvz6bMVGaEp9OcnSaK4nuIbi0Za20WnSCkrlqTszpN+Q=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by PH7PR21MB4040.namprd21.prod.outlook.com (2603:10b6:510:205::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.17; Fri, 29 Sep
 2023 15:51:48 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::da2b:c7df:4261:9bb9]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::da2b:c7df:4261:9bb9%7]) with mapi id 15.20.6838.010; Fri, 29 Sep 2023
 15:51:48 +0000
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
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net, 1/3] net: mana: Fix TX CQE error handling
Thread-Topic: [PATCH net, 1/3] net: mana: Fix TX CQE error handling
Thread-Index: AQHZ7ocQrp/9gNb6kUCVZH6SP4kWcrAxU/CAgAAAtwCAAKcc0A==
Date: Fri, 29 Sep 2023 15:51:48 +0000
Message-ID:
 <PH7PR21MB3116CC4A402211384A28F13DCAC0A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-2-git-send-email-haiyangz@microsoft.com>
 <20230929054757.GQ24230@kernel.org> <20230929055030.GS24230@kernel.org>
In-Reply-To: <20230929055030.GS24230@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ae4b10a5-1bb6-4777-a187-beca342ffb41;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-29T15:48:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|PH7PR21MB4040:EE_
x-ms-office365-filtering-correlation-id: 45a7bdbe-2ff7-4c19-ac88-08dbc103fd8e
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kPHxg8hCAH5+hdFx0VdPOq8fbMUkfAt3zuarVNNfQl3Or8dt4mhqMO6x74YtbpJEMM1+PlODXugQIdrqNQgJ84++LupiyPmljnfUsOASHCCfLjRXbImrLqb9LVsuL7hu4+/x0117SaIunOOy7gfiGiQlqN9XRBkBoQ+y4ZQurbW3jNl6vtXI0UyHsAFgaUbtw0KpoI5+mG+zKz9GOrxQfCJWzLrbxJELOZvev/dQfhGTh0kOWBLfnyoICLD3Ubt4JQNo71yiwJ+qK4PQ87w86BpNKGjfyY8Zhzke44t2Q1+ifG9krRRFD0mUu5yyW7md/q5Ec9+KPvhIbLJWV44NO99r2YRC2DBzbiNhd88z7QP8fgJQijbd+7xOr3OWTtn/dPwJYc1JoYxylpkvKUmNkps2hum+Z0kaUKyl3o0S6Axv5X94Fow+jxyrYuhmNqE2AETpzmGsw715jlCaBhSKw9GAnydxROjzP9kHFYjJR7OYBblacNdimDqCKiX9uuQEAGuNfx3Iu1+WHHtwgZPx1xkc4PlDI6F7fat8xRuZM8an0O0IDAjX7niRVUxW/hiaKuqAb/Mr/RGBaQJA2nfA6cyfBmcIcVp+GUkwbjbkICQ/SpWIQMlUDbgUh3UyPMENVfFojudKiAKs6sBqtSl81YQG8ffo6mtBNtfMhtHPfXg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(53546011)(9686003)(71200400001)(7696005)(6506007)(38100700002)(38070700005)(54906003)(66556008)(66476007)(66446008)(66946007)(64756008)(33656002)(76116006)(10290500003)(86362001)(478600001)(6916009)(83380400001)(82950400001)(26005)(122000001)(82960400001)(55016003)(5660300002)(7416002)(316002)(41300700001)(52536014)(8936002)(8676002)(4326008)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mE7E+HbUDiBOALI2aZp/HnolsxScvh9I2doYf86VDho6xhK/XWeMTGgR/Aj9?=
 =?us-ascii?Q?LICf2ysqMaNbnDFiLOezk0iziYU4QOLsrJKIFFMyFyIQNzd1hDxag2C3+CSn?=
 =?us-ascii?Q?44w+i0DPUxO9d9rAA61FwwUbs8f617lAql8G01DLlDsiiqDnGieJFng1kV1G?=
 =?us-ascii?Q?re6vsmaG4WamyHXQrLge4hbdwZDHdTpVUBgaLWhg2svD8KbEMN+1OC49SyW8?=
 =?us-ascii?Q?gmMFwIW7ldEVbvR7E/v8YYZ9b6wMIAQ5Y0DjFRKJ3AseHjtQAYc6nP64pV7S?=
 =?us-ascii?Q?BS+ksFFUdKGzYEJ3ktoHng+HZBAC2AVW+WW0rEzPOdh7Cy8Xr6mCS/WGcxtE?=
 =?us-ascii?Q?tO5qq3HkgT5ZhP2py94knsn/fvoB5cg1ji2ew95cM3zE63t4Bve+cKw7AzA7?=
 =?us-ascii?Q?BKDR13TlecYih3fWjnFJ+HkpDwbcEpNWtyPDfsV4FBe4BlJKreoMSPpEmfI1?=
 =?us-ascii?Q?rPbuqyXr1DgNnIYsZmdnmsF42YZQR9Fzl9lHpHmjpaOEEP91r7i7v0lgExde?=
 =?us-ascii?Q?T2tH6SK7C+q+7eXHkP5yNZ9CiiGHsdRCFSkBfq/G9EC/awgWjpFn7pxEpKm4?=
 =?us-ascii?Q?7BksKXPjoraJFAxiZbV7NusmrrN4J6w2MwZlXj0bl+yI2tav8r2prOZ9/TUl?=
 =?us-ascii?Q?TU3MH/53DK5hVBVhZLm2Zv0QYN8RKTMzMgQdFPUD2jVg9RBf0vXcPU95D1Tv?=
 =?us-ascii?Q?eYfNG9/jwrOcK0vsKa3kO6f9YABQX3wFYfWRH4ag+PUze+FHdftx8JCDe5pU?=
 =?us-ascii?Q?eoj2DPHCSCMmk4ZhGWCXRX3WDbICFm+/cU4z/T5+W8mR7F3EJYIoEAQ2tO9z?=
 =?us-ascii?Q?+5+TipNK+h/ZAeDwe/oIL/SFOZje12pVadU7UWQmDkOnMn/lJ9STq6iEh6w4?=
 =?us-ascii?Q?Cqb2CVOb/ojFEiIm3JBxCeRCzX8xcn3NjYAqGcgFLwjipMfQNW3x86gnCbiG?=
 =?us-ascii?Q?ONL3S5nHRYC8JvtAGi9uf3b1YMR/4FrsLGle1Fz0sFTkf0FTmexmD2tkWDuw?=
 =?us-ascii?Q?wbcLI3s1iewDBs6olomp3DgjHWnoQOpxN+mlCFKOJASk0mFJ3oF/WZamEEA1?=
 =?us-ascii?Q?rdMRdS9zk0eRQ6rz0jLdhXiOtn/oeRa9szJITjGwc8qiynybmN+thF4OtrAV?=
 =?us-ascii?Q?eHBzCOmu2QIIRZ5MwYXyartf3Zo9wqR/85oOeEH9XPnLLYe6wb4uRB/mKHd8?=
 =?us-ascii?Q?wBc7IyhIPnrCh/OA5Fa3T+YBVCzGwDZzIT/LomoOSKFxBGlgthnbcEJWLqGq?=
 =?us-ascii?Q?tITqzRoR+PJyr/0SjYY7ixwUOqh9UIHyLyDeHmcDaT3Ti1F9JxIX2OeBzPil?=
 =?us-ascii?Q?JyKlWpxv5exwwMQ4CO1yzXdHFeJsuN7+w5XUsSbYL8v0o+rHplaRRaLTeOuo?=
 =?us-ascii?Q?8PtwM0O4sYU8vttfKnmSB4i3He5meYvd4MUDL71mpQ9z6Tl/1GZ2Fs2yEZYw?=
 =?us-ascii?Q?lsQjgYsqZ3IDqtqbeMa6EwfnkIP1Gf8pqSMjmp9T72WR53Kbh5CyzXefpEhj?=
 =?us-ascii?Q?sbG/r/T/XPraDK5A6QrhCF+j1JSISP3ZArUeUFC8ylja+Xhl46n85/fKz26w?=
 =?us-ascii?Q?vBhS3PHg0SFr/Uu+taF9j40Pj8/B5GDfmywECm+p?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a7bdbe-2ff7-4c19-ac88-08dbc103fd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 15:51:48.5581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jg0eZeZM3JtwGFdjqfdt6e0nbsoHuKIPtqXDZ5sJ6Cspm94OiXOKdJ7KYDVRinjIXeSTn1TtiM/zfu3fKdG/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB4040
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, September 29, 2023 1:51 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Paul Rosswurm
> <paulros@microsoft.com>; olaf@aepfle.de; vkuznets
> <vkuznets@redhat.com>; davem@davemloft.net; wei.liu@kernel.org;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; Ajay Sharma <sharmaajay@microsoft.com>;
> hawk@kernel.org; tglx@linutronix.de; shradhagupta@linux.microsoft.com;
> linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH net, 1/3] net: mana: Fix TX CQE error handling
>=20
> On Fri, Sep 29, 2023 at 07:47:57AM +0200, Simon Horman wrote:
> > On Sat, Sep 23, 2023 at 06:31:45PM -0700, Haiyang Zhang wrote:
> > > For an unknown TX CQE error type (probably from a newer hardware),
> > > still free the SKB, update the queue tail, etc., otherwise the
> > > accounting will be wrong.
> > >
> > > Also, TX errors can be triggered by injecting corrupted packets, so
> > > replace the WARN_ONCE to ratelimited error logging, because we don't
> > > need stack trace here.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure
> Network Adapter (MANA)")
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> Sorry, one latent question.
>=20
> The patch replaces WARN_ONCE with a net_ratelimit()'d netdev_err().
> But I do wonder if, as a fix, netdev_err_once() would be more appropriate=
.

This error may happen with different CQE error types, so I use netdev_err()=
=20
to display them, and added rate limit.

Thanks
- Haiyang

