Return-Path: <bpf+bounces-60224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE6AD4229
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 20:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323FF3A4C2C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885E248193;
	Tue, 10 Jun 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MFQJ/Sqd"
X-Original-To: bpf@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021135.outbound.protection.outlook.com [52.101.57.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8B13790B;
	Tue, 10 Jun 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581128; cv=fail; b=YFXduR0Pi4lo0rCXDRq5LLn/9sY7Qq6qhzR1yLw7L0aQ4Sgy522AOE+AiwfhT1nNg371DHq7JF8wjf2TyghzHXWbRnPOcE3WhFLl5v30Ae0H1g/SW+nCWxisKpEWqEslJVOX+JhEI2t8Q5RVvceAD4eY+bGFso9Lmml/jiayENA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581128; c=relaxed/simple;
	bh=E8yKD16HUthNJ8ai8a2zNd5pzC2YLHHaEgm9SXG1ILk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ab3D4e6WMVVdaPwpwI8jrsV4zeOmCEIOfe/rjbB1Yfw6/N77HXZJd6rVl9O6nRbXGCYG6SzorgJoiKtlD4iyJb9Ld2/qC4TKi0NA6+AJXPLNvj+ifydlQVm03YOtW2cQyxmM2ddXqOVhmvFWgxtV354TwyA48atWpMBpeBq7LY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MFQJ/Sqd; arc=fail smtp.client-ip=52.101.57.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcG5rOI0riVANrd5o68LoZEy54j/P/d+wJMp6H50iMiXN9vUlApSvQa3bldC1neifHJ3YUFz63g/WGIoBIF6+dhq9SQ1G7hrHLPeXY+AREjp+aVwCzazFlTRXsqSAx0ynM/+Edt64fTifnhvD0wl/+oIudso/REHJpETXopxVzJGlTcVgpqjusy0gUObOMExqoxY0IH2Df6cEVcrGXoTSdB6A2aODqx8RvJzFNcg8dFV7vSax6VywoUqMBagEws44GJqgIO4vIV1Q/HTAvZJx7lHGqjHoMhqBaQtgopkLnYi5WvFcAGbyJKJaslXS2R98buGpYrUZTvP5N+JEbKPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8yKD16HUthNJ8ai8a2zNd5pzC2YLHHaEgm9SXG1ILk=;
 b=Vq3klLXLBLbxCNxBiE1D16jxklPwVD1GB52Hum9zD4/G7QZOVvXmOQrPsOWS0mGJ5Ti2sGeJW5VMglg0vSyGYNyYxmng2srusvspYitOz7Io8SNiyaXtk+VT/tx13KE+/Vcd2nae97GUbISiHO51/VSFbmqLG/3Z+ugiTLbSO+yvzGBaU81AIJmy3d5wVKY8FfNA4ZcwKKqgoReucA4hzmsYmJqzxjltab3GStPCALSIZjMiviwL1SlJS30ZryvPsFjGI+YmyjH7tllu2t7XwLc58ZFjMmSk6CDkmjv1ZCEdVfLa1VngL/yKuT0XiguhIGH7K1hmvKzvlIiV4alKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8yKD16HUthNJ8ai8a2zNd5pzC2YLHHaEgm9SXG1ILk=;
 b=MFQJ/SqdU5CPF5c45Z3Nc2T6O7Pf1en/SweCj5DnfViP+wrql0KZ/NFpk2ndEI3iuA+Ixf3DQA25aEVabWZqk4cDNXQWHJD+a6PEtI5w/liRRHzNWOTBFTVXV6zTvsdHMnbtdjoXXEiyZsCMDgIShj6P9Qsi8Df3DhWQ3a4LIrw=
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com (2603:10b6:805:f::12)
 by SA6PR21MB4439.namprd21.prod.outlook.com (2603:10b6:806:428::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.7; Tue, 10 Jun
 2025 18:45:23 +0000
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf]) by SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf%6]) with mapi id 15.20.8835.015; Tue, 10 Jun 2025
 18:45:17 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next,v6] net: mana: Add handler for hardware servicing
 events
Thread-Topic: [PATCH net-next,v6] net: mana: Add handler for hardware
 servicing events
Thread-Index: AQHb2UwBnA3Q8Y0HEkWRvFDfxb79+bP8vLXA
Date: Tue, 10 Jun 2025 18:45:17 +0000
Message-ID:
 <SN6PR2101MB09435086F05835B226855B6FCA6AA@SN6PR2101MB0943.namprd21.prod.outlook.com>
References: <1749479764-5992-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1749479764-5992-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1850e4b7-7068-444c-9f4c-432202184677;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-10T18:44:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB0943:EE_|SA6PR21MB4439:EE_
x-ms-office365-filtering-correlation-id: beffc6f7-05fb-4fcc-a3f9-08dda84ef19d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ArZB9o/M6ynswW1FgzVolLi8p+LBTSlpBfQ9uFBA2mbKOWCo8Pg8fPzhxS/v?=
 =?us-ascii?Q?0azzRhhP4iju+3MWm7zzPhHnP7fmqa/qS8kcfrq1q5nHXQ4JALRiWHGZcPJr?=
 =?us-ascii?Q?orv3FEl75ScrMhuzj2T3L+HLoXbal94MIGA25weB1+yUSxOCdynaII6cAzNn?=
 =?us-ascii?Q?Airix1yo28x5On6kCyjVECzfvcHmfMN9t/a50+YZD8lXdNkh/vqbnsyHMfjq?=
 =?us-ascii?Q?6i3Z/RbO+aTYTUg334PMYbIsKPiPkP/qICekjcohFFFwEJXwXv/zTG4ys8F3?=
 =?us-ascii?Q?+jxv92kzOUw83JJVGxZUUPrTLKJuz6PHaX3meoP5Y+vl660sStBI+9UBqRPg?=
 =?us-ascii?Q?h7Ja91prDySYEwCntmtlfCkRQEuxL8te+rec5fREAAizNigzGv1W8yDXRgMw?=
 =?us-ascii?Q?504tnXBtgkUQDY5bXA8KJO33KWtRe6UAjq6phFHREFDX336VDRPWMghk9omf?=
 =?us-ascii?Q?tNIXxg5OJISTH9K6Ts83XXXzRohNz/m6oRRkbcqL4+/KYxza7tmzn9vw9iBS?=
 =?us-ascii?Q?f3nQG5FFllnJmkTbSFZ4MzLbGzYqaQfBYwN/60111PA040Y/CbHEsNdVPE5a?=
 =?us-ascii?Q?F8hV/XsZTWq8J5BYMSl7QQkzoC/m17UEX2+l1aByuodlDr6wXCC5PT+LHQQq?=
 =?us-ascii?Q?zCZYhKjnR4Pn0gjXoPuh3mpeyk+VSkZ1CPDFH+qqmCtW8yKK+gWUObpg2Bl4?=
 =?us-ascii?Q?09V1l3bvf+JVFRCwG22jV27PstTJC4IGF8BPmArO8MTv2DBjqXD3uYcDdrXK?=
 =?us-ascii?Q?gUcjYX/kPvoM4BJ6F9ORagnrzC9HiH0h89wkbXYEojLld94vZ02OqfEweUIu?=
 =?us-ascii?Q?X6FWFADGk/Ks+7aaAl+5RqZNu72up4Do8UlDrG7pkF0C1UXA1XUfPZvCf57L?=
 =?us-ascii?Q?5FRE4UzVplYMhBvUloj6P4mRmW+fseyTB0VyAKjwd+2dR36nTqyo7KGj7oOc?=
 =?us-ascii?Q?zo+UjztgwH8eJ7gHtGRvBCMpuLg+AaCUUfiOBqsP/o2Z6WF4WG5bPkKA+CVM?=
 =?us-ascii?Q?VY24okPkmKDnij97Sm4YaHSKRWOCylHUUd0h05oFDw7OpQTyKgwphncefCOG?=
 =?us-ascii?Q?Fzye6nRVK8MPMqberN9Q3975zaElzNCe/WMqSeIadIxeeYaBRmgUDrFsoYFl?=
 =?us-ascii?Q?d+XW5uLwAt1NPDyGn4BkVhRt4Id6H0TZn0zr89DCBMSOyAGAXsmJnOHtQMi3?=
 =?us-ascii?Q?lRnFekkx/yhWkWJe7OOFehYBrwT44mS/IqlgCWlZ9rDjPeY5M43+t/F5ny3Y?=
 =?us-ascii?Q?LiGV5d4PiINcpLrJmUSJG1skYsAMmUN4RcPOckPdVfhVyuzP36NxJnViDg00?=
 =?us-ascii?Q?DNKkf9cluYuZj9OuxiDhNSE09PZPyO+mSskhPcbmhcC1CgL9vxbGG5bpY/Og?=
 =?us-ascii?Q?bOFw0TJ/hZQYKWjbqCSqgMaxbPCZWSQR77TUgbBw3uRZCoQ7U3hUDMFAyIH7?=
 =?us-ascii?Q?EGbDd0lqw/vWVm0n+sdnDoQtvFuxLnUH24cyE+Lej/0uooUQCq0jgQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0943.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N4dpdZ3G3+tJaVzZ6IJVyxrf5nTwr9gM/5/irKrX2Clis/nieaPTiGSLJ7nj?=
 =?us-ascii?Q?FWdFXpGDJWZJ32giPjrHlmGjDxfYXJ3mDtQsexFcmZ/EXnmZgMFp7Z3hm1lX?=
 =?us-ascii?Q?wKD3EfLyx0PoEfVzvOuTUxx2nKeQ0MRFSPnBiIqFpZ2PD//53TpLJqWPLQOz?=
 =?us-ascii?Q?3X7YamyxIjiaKN5F+ddGQDPWWkiTEtpR1k3wlb3RXeHtmErVzK2D6NTfu84u?=
 =?us-ascii?Q?uC63BSomDbulLUb2UTUP5SIjglKhHS+zbHWqWdPGuP/gayWyVCbSKZnIeE+Q?=
 =?us-ascii?Q?+mU6nF9WmuUuPfmWoTM9sx3C3v/WA181S8g/+vyvNf5naJ5fUAZhpYWcWldb?=
 =?us-ascii?Q?cTzv/MYHN78OeBk9aU0gp/dXPd3etCw0RycE0BZEGBSElpIVKABWyoHU437D?=
 =?us-ascii?Q?S6BaqkIQctUks+bygM5HXi9/Cm/wziYK6a06RKoHfchP6I4FdrtsjLPlX6tE?=
 =?us-ascii?Q?TAjlvuVQgqbgiWTJ3tK5Hz5nHF3zgq3yU7RAQgNOsxXn5M9BXwb1HgQLT4Yn?=
 =?us-ascii?Q?x2r2rDe0mwfH3rwH99dUBrWI/5PQsE56irRi0LHhVD70Nm1kw26Jafh7WnoI?=
 =?us-ascii?Q?nLaPUrforpWv2GtKsxqL2ZqUmyC4oPgbqCiH9y00SFyhon+0SDisv2Q7cUN8?=
 =?us-ascii?Q?ItNAFQKk1JxoDRd4a0TwhODvwLVlqUrH+acBiZ9EA6N2t2i6/rKuQr/vkAMy?=
 =?us-ascii?Q?fRp+W3D+iucM010TyBydqWbCE+0E0LcqpBoiQo4hiczBFC1FOhQrRCXNZhdm?=
 =?us-ascii?Q?g76QqZVvHOW1iCTbsng9bUAW9VwxMuCxif6kf+w5FcNwwdKRv56UFv4L2w+/?=
 =?us-ascii?Q?YWCMFMpx3uAwn2Na7Yp7I7jEgJ2Fvot1hAsBwgiuL0Pm5IJBAwG4FtZR+I72?=
 =?us-ascii?Q?yLLZ6Ya8cCBD2/HrD0roqy2PkvjH1iP21cqejxDfOgfYupqEWy0gCcnZpwKT?=
 =?us-ascii?Q?IH1onyPdCZKpYvFjwXMbtT0NIToljp5QwtKMrgN97Ovlo5wSVrLB9uejiEEv?=
 =?us-ascii?Q?HFKfdxDQQKc9H0fMg0QveJtYFUiptSDylajTNUPvf7enKqjYglicu0sAvVzP?=
 =?us-ascii?Q?oVRhdsG2Ou4ugsVc1o53I5w+EtGbBF7Zz03iIi/3e8uPyPuvN6jde6/tDM9Y?=
 =?us-ascii?Q?Nql0bqfaceN1IUbSRjGvGrWAT0hA1NZd6zoU7e5W7dlFsU0N7XFxL3NTRoeY?=
 =?us-ascii?Q?00XhL05nQJ/NUXrM03LP5UbvhdRCb3hPWoKWBjxMht0MNGfpVoEqFKbpm6u+?=
 =?us-ascii?Q?wHxTxBe6m7u/i319Kl/O++tLA/+dnm0GS9/s3YzulxUKJwScvj2FHbXwTZEN?=
 =?us-ascii?Q?oR04zRdrIBooYL8LEsa8t31YuA1qhLvcdKQYhK82maS4OyHk79FpqP6F0BHR?=
 =?us-ascii?Q?W+bfh6EvKdGXW7zFK+3b65sNWI3ECRDCHO6um0q2h0ab+ybW+8hm0mHEIW1A?=
 =?us-ascii?Q?kMXm+cfB+ftbpdV1twMMC3tBwulK8treNGseq9lpTGzEN0EERi2Cqsiy5CkH?=
 =?us-ascii?Q?DDLADntuBrQsYQsXzS9FKAm1XlVw9d6yHvMpMcDaaXlp89e5sNI4FQzbN1BR?=
 =?us-ascii?Q?GYWEOepP1LMNApLhjZAtzn4CDmuX6SIjNh3TjewX?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB0943.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beffc6f7-05fb-4fcc-a3f9-08dda84ef19d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 18:45:17.0468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RslmRvJd8n7OuQEIAWKUWXgDbJRRkL+bkgU4aat+2htR+X9fJXJ5zW0Kemegu8Um32w12/b77WD0+RiU9tQHvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4439



> -----Original Message-----
> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> Sent: Monday, June 9, 2025 10:36 AM
> To: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; andrew+netdev@lunn.ch; Konstantin
> Taranov <kotaranov@microsoft.com>; horms@kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH net-next,v6] net: mana: Add handler for hardware servicin=
g events
>=20

Rebased it, and sent out v7.

Thanks,
- Haiyang


