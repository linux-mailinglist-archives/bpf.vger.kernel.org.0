Return-Path: <bpf+bounces-32199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6E909280
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 20:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFC0B20A88
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CAC1A01B6;
	Fri, 14 Jun 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NnLl/V/0"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216B8C07;
	Fri, 14 Jun 2024 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390784; cv=fail; b=AnVJYUzohFepXuLQoM9Y4Y5v/HHVR1rp3QDaZ94kzfw9FJJIBFf/6k2Ql+eGfo6kEpV7dhjcURgsY9azVM5UnkuTlmlQNWXEWupVl4KIb+yeaRRkpR5SyK9AUSukUgncTyj/CNBM2FUkXMYB55tGadGT3F4O61WUmj93B+HA6go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390784; c=relaxed/simple;
	bh=LQEWB8rmGm9/pBW47Cwn53PQP/d2JYnPSuVEorJ+EF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0yo6En4u1WHp93rZyLcc4KxRbeKlBZjwdAd9U4YzEiniitULWgBW/veUh41S5IKfUWBuTqJn2Y/TYSD1tlI9Ip3ue/raeCr2BqA2rmjP5EyXo4QxHC78aQpuC8al21Ta/scJIv2Q4GBF98pkjsNQyAoiSL8kT1MPvlTg4UBK6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NnLl/V/0; arc=fail smtp.client-ip=40.107.93.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBIpALQKGQ/Q/h51ADjm5duw28NgqQ/TxtQdSNLGqiLqjp5qlwki8O/OFvjz4NQ2/MHfLuypyp0lX1TGXGTcLAos2jJJPfq51HNhGTh6Xj/vr03YgoLIuhO98PeTQ5wUrqsVVAZZI6j4adPW8vgKftGJ9jAS3Wve1jiKmRZsPjJQoI5uCwgf318rBM2yL00w9hoHxOX2i2GtpOlvvHcCSkfoHcmbI9YB/cgTt2Qp4uuSlfIGQUxEOHsgwAkdrUpeoftESLk5r/kRBgRVFV08cfte39SrK1VrYuYjiXo5YcrC8iMN0hPPDHi4tuR35YvgZV36Qsq8CsaX/opIYId2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7F0I0Tc/o0k9AZ7iMNzm2ybVrmzdBFrXX0/VQwIBLk=;
 b=HMjiHy9itsfRoZxaHGMTAttlGh3v2rCv+0r+RYhv601DuL0SUDXldFQ81sWe0xZhAvirhA+E/tbajtHrd5PAzV7JcuwzjBL6PGPwnQv/c/G7VGs/PthaUekuoGb/PqCKP9nNV5Ah6dtKm7mGF0FTPTVz+1GMtB4/iXTF7cPIhmHExwMSN9XqDkl3yc+t2gd/1fbf5XF5ypatCjKnxDoHQ7yaFkY84vHsWiep5kAbYJNQhwfgQJwav+izLT6YFh5e0CmvK5og/ZPFMeMzJM9d+akI8c1pXrvqNJAO1GlzPCaCXEsXmqxQ6wO9ZJNwqs9pY9WO6l0baX6sdispp5kerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7F0I0Tc/o0k9AZ7iMNzm2ybVrmzdBFrXX0/VQwIBLk=;
 b=NnLl/V/0VMp67oH+v/FOQQr2l1lkYgAUJ6B+n1gKUy9FrqZ+hWZ84WUQRZQnm6+R+l8mu9RSZhMYf0Tv77ZwLSQ+QcWGYRDF+xuaYJTzBm9MEb/2SPFfX08oaTftz4kdxf+CTGO/NpEXhqTuNdQjUxWG/u4PTP47r6g78vGHeYA=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 PH0PR21MB2030.namprd21.prod.outlook.com (2603:10b6:510:ab::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.17; Fri, 14 Jun 2024 18:46:12 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7%5]) with mapi id 15.20.7677.014; Fri, 14 Jun 2024
 18:46:12 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Topic: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Index:
 AQHau3yCjVULPkZ+NkeRwzD4A2YQ07HCw4UAgAAC/7CAAA858IAAl4CAgAC8DoCAA3SqUA==
Date: Fri, 14 Jun 2024 18:46:12 +0000
Message-ID:
 <DM6PR21MB14813BDF16ABED9C9AADE3F2CAC22@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1718054553-6588-1-git-send-email-haiyangz@microsoft.com>
 <SN6PR02MB41572E928DCF6B7FDF89899DD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DM6PR21MB14818F4519381967A9FEE8B8CAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
 <DM6PR21MB1481E3F4E4E26765CCF6114DCAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
 <SN6PR02MB415781A68B43463F34A884E2D4C02@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DM6PR21MB148141756E3739CD3F13E2C4CAC02@DM6PR21MB1481.namprd21.prod.outlook.com>
In-Reply-To:
 <DM6PR21MB148141756E3739CD3F13E2C4CAC02@DM6PR21MB1481.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fb4882b-67e9-4568-8c78-027b60b1813e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-11T16:45:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|PH0PR21MB2030:EE_
x-ms-office365-filtering-correlation-id: d4a4de58-86a1-4937-b155-08dc8ca24357
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|366013|7416011|376011|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UqMh7+mueQSswXaksTZyX9PdAZu4rnDM+d8Al1Z9R29+eEjJHjfN2azANc?=
 =?iso-8859-1?Q?uA5aSMptJhEYCbAICHETxB+3hXUl60TjD2Vt4CkOHZOYemvH76/56Fhujf?=
 =?iso-8859-1?Q?e8M7mbToVF8akXEAp/I0gN+NLSt2YQwirbsGU12bMA68y5P/8bgjUbcrzc?=
 =?iso-8859-1?Q?lptX6l4C3PL42gHpPjuXz+uKiP+bTK2GqYWEvZ+xZWQ2kbJRSUEXf6LuYs?=
 =?iso-8859-1?Q?DvQXHLv15rl4hu5klb8BbSmvvy+HCX8oUVvK4hAQTGF/RhK5Tw8WjzIY08?=
 =?iso-8859-1?Q?2Ea5IOEYfXMCIdaLLy8krmewqOZGMw0BxYk7pt1UPiHFwd/viyyKc/TXYR?=
 =?iso-8859-1?Q?2LGPE3YNJWwJ0BaVg/beGs1AnYDvvx1ryRerHKNKwEsQ84Gd4EvPEJ6LBi?=
 =?iso-8859-1?Q?wBG/DYzSAE2yQhDP2tWZG+zNhdIyOpssh2AHW+rXlHBW4rI/aAW0yjnZ8Y?=
 =?iso-8859-1?Q?6DqIu6Wua1NYS2Yu/tgGk8rDFzZqX5FxoR5gNeTQ9/MzoNXqir4BqR3ZRr?=
 =?iso-8859-1?Q?N0TnRDBSDCR5KXrGJLbMFSYOhTDMQ/3jIcQYYlVJ0/aRvYEtl21gAJv0Bi?=
 =?iso-8859-1?Q?56lSyAvt5FuNPGdVHojbZaM+mDtkKrzIolb62n4TYRj2KfMQltJZH7Ynnq?=
 =?iso-8859-1?Q?QeMTN7fSrY1LeCxgRTo6qiEnUCXG0V2AAMYTqC9Fw0kxuEgXmx46NUebYd?=
 =?iso-8859-1?Q?AaRsWvp9U8t9YgyPVRK+a0uSpGzFb2XEWN+THY9kMFnvxGyVrltOtl/lKo?=
 =?iso-8859-1?Q?NXViPDQXJ7L6IQes5xrDG0YeWDGHVYZtv/PjHhhJ2kUrdjco89c/yXd51+?=
 =?iso-8859-1?Q?22LS2HnZvfw3HdfNCFflLewLIESGvnTz5+lbp3FVOIpV3jMa0qA5d408wl?=
 =?iso-8859-1?Q?lvl6fmvaRPB1fK+FPiAWoHx1y6te7tci9X3xFrfiJfQMx9yVcU7QPRaE7x?=
 =?iso-8859-1?Q?QSPTjbnHCOJC7lO3f8PiyI12FHachnOrxWCioc/VA6ObxpPp5m+rDfjAyI?=
 =?iso-8859-1?Q?R1jOAH0d6/Ozjo20M/Ae9/wiQFjODtqsIprDWc17HsWTVSasZgDx+DXwwt?=
 =?iso-8859-1?Q?acpqm03+1XQeO4Za+AArC32+2ODcVSmZcphzXckbTza/7UL2O5YitBf05i?=
 =?iso-8859-1?Q?iUfssqGNPrbqDegUTuKIMCvrVmR4NWF9kLbpMPbEAnRCcmBmygj2925A1m?=
 =?iso-8859-1?Q?VmbK7RT06dTsB1aArF9tVFcgRVnKVH4RRbEefZso45tvtfOWfWsp4/pkjX?=
 =?iso-8859-1?Q?4yffrOHtPcjOGASBHjzaJqzBcLNpAPKFN4G+JOYEVX4MaBEFcTB8ZlFnjS?=
 =?iso-8859-1?Q?WgyFlboX+XcTAuOCpX7P7np9m88y0u265sNch0JJosbwELVFVC72RxBBxh?=
 =?iso-8859-1?Q?ffTnZjJd/97y7UoVpJ49hxBmh4vjg8WEr+iQ8xgWbb1qweKoK7VX0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p6C08Swj+27NHdhG6JCkbz3VIT85itjTAnxx48qqorfQGsTFw6GH7jHKuJ?=
 =?iso-8859-1?Q?U5OSaUl5LHbU3qYdJTDqAtE6jAiUQTFsJ83dvQh1r2hI5VEbxyhVYMjtO9?=
 =?iso-8859-1?Q?dpNHglZlLXHU6XWJJhhfitm45EPLvOeXV5/OuQsCcOwkkgvQkJhBKz5Szd?=
 =?iso-8859-1?Q?17iCRir5FIrS0pm/SROqLCP+2wefLbXXGpEZ+MOQHpW9aJSkFi5And883m?=
 =?iso-8859-1?Q?LcZQi3pQjb8KTqjdOUtGadJ4a9i9/JRpARRpvAFbd6Tvcl6MgdPAvatxf1?=
 =?iso-8859-1?Q?HkKeejozKexqGERq4KUiBuNeLjlXJxMuAUp94EuLfzC7Rg7m3Fw36bFEKP?=
 =?iso-8859-1?Q?Jo9cDC21HKE0SPnGZpYkmU096f1QZhEvfrU3cUARQU7gvQjN2hy+k5BKO7?=
 =?iso-8859-1?Q?airpai62j04LUn2zrYGgrEVhlB7a1XOWqvCmXauOXlijDWEjDj7OtCdH1k?=
 =?iso-8859-1?Q?C24KfOpumASUJ8hByZoTxUf2DzJG8RLo2XuU40G/Y2811/OVMsuhdDx1in?=
 =?iso-8859-1?Q?bZmAPyZnYDSkzLSpvC0RUhyDPsvYIdlRJuojr6OjxKknbbSQ/kPFEMkojc?=
 =?iso-8859-1?Q?MBhHOTlXRfZeyiNdjzLIONa2sAcrNSx23nJRsSE3/ZJOsdFiFdFVFoUOz7?=
 =?iso-8859-1?Q?x8za1L9y8Nx23XsG+WC23kiDZzxPjIfl9hhmJNSUvZKMpU9IG7+nI3YPVU?=
 =?iso-8859-1?Q?mh8XawTNqJ3Zv2BN5vrmaU0p8PDP03E30PA/dPh1m8/3OCFK7fhnJkRGFZ?=
 =?iso-8859-1?Q?Hge1i8neCpaYqkfboFMDPyf0kMCEvVZbZEgAJLfMDRfT62jBwbeNtlzsmS?=
 =?iso-8859-1?Q?CV09Sm0moMSxTaPRBrJZwptO3x8Z6nJHC1aEIvwqDrLnMudRnD+2DSdqDB?=
 =?iso-8859-1?Q?Hq+QaxoIrNerZm6/qVAEcTepC6YXBi+tuef35k3QH8XLUW/JqrX0B7Xp/5?=
 =?iso-8859-1?Q?2hJhhka1A/w3bwm6k0RoKibWk6/hMnP3PQ/OeWzdvcK9tFjWrGYEN3a0JU?=
 =?iso-8859-1?Q?9wUqEfsuanjXHMRW+IKLJBWGiNbUj+OLaTqaZk4rPg/nrIm7j/Uzk9NQ37?=
 =?iso-8859-1?Q?enO5Wc8nrXzf3vzJCo2tZ+mCDQ8Fq9jpVPYO77VbnDhhVYC8blQ2p8eJzX?=
 =?iso-8859-1?Q?WwwBPxRawFemjnHdrrM3yHSEcG7I++POBAQ/vOPZtaCxJyvKf3+E57dRxK?=
 =?iso-8859-1?Q?RWhgMACAgNdUsDPpCHBelLmm6gOdhXKcs7Y79h131Sq5GPYESkeLYFFt3I?=
 =?iso-8859-1?Q?zwEAfnkbwRQyejk/GpO8E0uibsBelOnNW9YPQLrD8iw7dBq9GNlsBymsxZ?=
 =?iso-8859-1?Q?sG/Hs2fq7g+UIFQOYpVstndRZW7YoWWIAkNozbrsCMhmMd+qlTgoM7GMZD?=
 =?iso-8859-1?Q?/r769dqLcrZZ9otNiYVVzIrbSg9hjtHgxnQzoI8MWtf6w1q6Qwqt6VyJqC?=
 =?iso-8859-1?Q?gFGhtyfK/OYEIjxZnNIYCCDYzePIn15nmTZXpzJpUamsmwkrt12N/Win95?=
 =?iso-8859-1?Q?D4lCgmQ+eWZv69BFBmaGxTV4FYyasHjLPQEhPcqJaaBXEsubK1bYXP37VZ?=
 =?iso-8859-1?Q?IV3P/snO8R5OIS6W+YZ7pl9U2qU4SVEWuisj5uo5qznS33nuy0zjdxeTxx?=
 =?iso-8859-1?Q?QBem6vCKSPTgYNxFQMlRYx5rQrubCDzgt/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a4de58-86a1-4937-b155-08dc8ca24357
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 18:46:12.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUejeFn9LbVH+fqOIPe4gfcSL7TC2QsVkazaQbGKJ/YzJ2SIrYnpjEX3tDPkqtUqd3K3QKEhrXlty4py/4lIzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2030



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Wednesday, June 12, 2024 10:22 AM
> To: Michael Kelley <mhklinux@outlook.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Cc: Dexuan Cui <decui@microsoft.com>; stephen@networkplumber.org; KY
> Srinivasan <kys@microsoft.com>; olaf@aepfle.de; vkuznets
> <vkuznets@redhat.com>; davem@davemloft.net; wei.liu@kernel.org;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; leon@kernel.org;
> Long Li <longli@microsoft.com>; ssengar@linux.microsoft.com; linux-
> rdma@vger.kernel.org; daniel@iogearbox.net; john.fastabend@gmail.com;
> bpf@vger.kernel.org; ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH net-next] net: mana: Add support for variable page
> sizes of ARM64
>=20
>=20
>=20
> > -----Original Message-----
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Tuesday, June 11, 2024 10:42 PM
> > To: Haiyang Zhang <haiyangz@microsoft.com>; linux-
> hyperv@vger.kernel.org;
> > netdev@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> > Cc: Dexuan Cui <decui@microsoft.com>; stephen@networkplumber.org; KY
> > Srinivasan <kys@microsoft.com>; olaf@aepfle.de; vkuznets
> > <vkuznets@redhat.com>; davem@davemloft.net; wei.liu@kernel.org;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> leon@kernel.org;
> > Long Li <longli@microsoft.com>; ssengar@linux.microsoft.com; linux-
> > rdma@vger.kernel.org; daniel@iogearbox.net; john.fastabend@gmail.com;
> > bpf@vger.kernel.org; ast@kernel.org; hawk@kernel.org;
> tglx@linutronix.de;
> > shradhagupta@linux.microsoft.com; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH net-next] net: mana: Add support for variable page
> > sizes of ARM64
>=20
> > > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > index 1332db9a08eb..c9df942d0d02 100644
> > > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > @@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context
> > *gc,
> > > > > unsigned int length,
> > > > >=A0 dma_addr_t dma_handle;
> > > > >=A0 void *buf;
> > > > >
> > > > > - if (length < PAGE_SIZE || !is_power_of_2(length))
> > > > > + if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
> > > > >=A0 =A0=A0=A0=A0=A0=A0 return -EINVAL;
> > > > >
> > > > >=A0 gmi->dev =3D gc->dev;
> > > > > @@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region,
> > NET_MANA);
> > > > >=A0 static int mana_gd_create_dma_region(struct gdma_dev *gd,
> > > > >=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0=A0=A0struct gdma_mem_info *gmi)
> > > > >=A0 {
> > > > > - unsigned int num_page =3D gmi->length / PAGE_SIZE;
> > > > > + unsigned int num_page =3D gmi->length / MANA_MIN_QSIZE;
> > > >
> > > > This calculation seems a bit weird when using MANA_MIN_QSIZE. The
> > > > number of pages, and the construction of the page_addr_list array
> > > > a few lines later, seem unrelated to the concept of a minimum queue
> > > > size. Is the right concept really a "mapping chunk", and num_page
> > > > would conceptually be "num_chunks", or something like that?=A0 Then
> > > > a queue must be at least one chunk in size, but that's derived from
> > the
> > > > chunk size, and is not the core concept.
> > >
> > > I think calling it "num_chunks" is fine.
> > > May I use "num_chunks" in next version?
> > >
> >
> > I think first is the decision on what to use for MANA_MIN_QSIZE. I'm
> > admittedly not familiar with mana and gdma, but the function
> > mana_gd_create_dma_region() seems fairly typical in defining a
> > logical region that spans multiple 4K chunks that may or may not
> > be physically contiguous.  So you set up an array of physical
> > addresses that identify the physical memory location of each chunk.
> > It seems very similar to a Hyper-V GPADL. I typically *do* see such
> > chunks called "pages", but a "mapping chunk" or "mapping unit"
> > is probably OK too.  So mana_gd_create_dma_region() would use
> > MANA_CHUNK_SIZE instead of MANA_MIN_QSIZE.  Then you could
> > also define MANA_MIN_QSIZE to be MANA_CHUNK_SIZE, for use
> > specifically when checking the size of a queue.
> >
> > Then if you are using MANA_CHUNK_SIZE, the local variable
> > would be "num_chunks".  The use of "page_count", "page_addr_list",
> > and "offset_in_page" field names in struct
> > gdma_create_dma_region_req should then be changed as well.
>=20
> I'm fine with these names. I will check with Paul too.
>=20
> I'd define just one macro, with a code comment like this. It
> will be used for chunk calculation and q len checking:
> /* Chunk size of MANA DMA, which is also the min queue size */
> #define MANA_CHUNK_SIZE 4096
>=20
>=20

After further discussion with Paul, and reading documents, we=20
decided to use MANA_PAGE_SIZE for DMA unit calculations etc.
And use another macro MANA_MIN_QSIZE for queue length checking.=20
This is also what Michael initially suggested.=20

Thanks,
- Haiyang

