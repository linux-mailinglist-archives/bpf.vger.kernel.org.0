Return-Path: <bpf+bounces-60617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE04AD937D
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F7B176129
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C7222596;
	Fri, 13 Jun 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KT/d0d4J"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F11E51F6;
	Fri, 13 Jun 2025 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834421; cv=fail; b=pxDafZ34lHAt7XOwIYOSmtag8coT6I90475/jN7kQ6s9R7sbHH4EgT+oas+Nx9Gt1Dtq75AruP6Uprxcxc1xX3dcfHyYV4weeQ0+nUJT0fj8BzWSbZ7JhI3L65BYTW5DtXPVRaTAiMZWTJNQk8rk0y8aBuJj1l3hqY2lu8mpQhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834421; c=relaxed/simple;
	bh=Gqn2p+srHKJLgUuxVNLc9HXw/q5RRmyK9xCQASoZAN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kodbyMK2gftYeUFTZSlvqcof0qS4o23H5THvWyUd62qiaITK6T0uBnuOXwIU7OSq2WUev7fyK6/twaQc4H+CEmoTlO/6GTZ9qwtRCtvfZ5IHbvNW2FAPtfOCmDhdCdKQxBZ//6eznn6szEEzxXyynwx4oawcnDe4tJzXdnQJMNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KT/d0d4J; arc=fail smtp.client-ip=52.101.85.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcKnqpZh3br8Ic5ds+x2c5x78EtjFQoHL19zOAccX6fmUSFctdc6AGwrUrJv9SPxo3JWpF/JzDSsjXvu06qRUagT21xLbs7MAy0x10pkkQdYAzLkOdpcIhjFWxENwmysi4lf8Qva7DD5WCEcoxmNNElJTgruuigJBG8+GqJrAmWcD9MdTSPGTbNNgIRjvQxptJpUPUA3T87lp1ONK/amJTAn8VIsvcEpHKmwR+9ty9FQEtRcknTXJTwQHHxK/HXG67gyYKzcQ31BR/j6irmwh/06ypgbdlWay9+1o32zWH1oYw+7IXwJSm6dRLcOYMDlRLgTbvva/LaZ5uFQWYJLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gqn2p+srHKJLgUuxVNLc9HXw/q5RRmyK9xCQASoZAN8=;
 b=spQjXpTp9GJelR6FyOAJhM9Rc0xTb9CqA/B3Mlagbl6gU1fk83hwHw2+Wn14ewYA5Da1LzFR71Eb14wVsciAY10BBWIncQ3F4dSQGdGF3AnvvJkZSiXmb4aXcY8Q2pOl3VnROppKQYQpMyV3e3+/AVNVUbPtho7W7GHra5opD2tHVWa5PdSnpsDNhiYCwPlkp9dyme/DSijhB3ujoBBqNE8zXHbKIqK0QjwvezXPaulXY0yHjZkypHVsG2jGYuQ9yao46yxq2EPG1YxUNsIhqNKheGmd512/LkoFtoSJw5sOiAG8pzCD8qAXPhMLliijx+LIwlnEv7YgbPih8cYBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gqn2p+srHKJLgUuxVNLc9HXw/q5RRmyK9xCQASoZAN8=;
 b=KT/d0d4J/y6Ag+w/S1o8FLMCKugSaG7wPD80J16wy4G58BwPAXzyE+FMu8gL0UVpkaazBlbcd86JKPw8ZLck6rRi+Dc6ygDc4Yt5OYAwg8ZxgYi8ysp87A/E7SneHZ4x6aOCi+/ZpOUFOviAv28jvLVpP2Ly1fPI8Ng+EEFUomE=
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com (2603:10b6:805:f::12)
 by SA6PR21MB4287.namprd21.prod.outlook.com (2603:10b6:806:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.22; Fri, 13 Jun
 2025 17:06:56 +0000
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf]) by SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf%6]) with mapi id 15.20.8835.025; Fri, 13 Jun 2025
 17:06:56 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>, Long Li
	<longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, Konstantin Taranov
	<kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next,v7] net: mana: Add handler for hardware servicing
 events
Thread-Topic: [PATCH net-next,v7] net: mana: Add handler for hardware
 servicing events
Thread-Index: AQHb3IWQwqPb+xeK20y76K+KMS7GBA==
Date: Fri, 13 Jun 2025 17:06:55 +0000
Message-ID:
 <SN6PR2101MB0943E22270089F2B8A6E9A04CA77A@SN6PR2101MB0943.namprd21.prod.outlook.com>
References: <1749580942-17671-1-git-send-email-haiyangz@linux.microsoft.com>
 <20250612182143.16f857a9@kernel.org>
In-Reply-To: <20250612182143.16f857a9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9e0fd4fc-eb89-4cb0-a17d-2efcd7bda278;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-13T17:01:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB0943:EE_|SA6PR21MB4287:EE_
x-ms-office365-filtering-correlation-id: 0e2d0e9d-0d5c-4c22-0c98-08ddaa9cb36e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oFcyMgG/H3vsy36ruw++4fVzPcwdwJtuNv22LbPodVqCoipzqQcGYdX9mnqU?=
 =?us-ascii?Q?9RSwTUCNlUxqe/89xJWvYLoLujBVokFOhMWQ/GkDyaD4p/u8klJv2SYBFlP6?=
 =?us-ascii?Q?JakwlaiWJjZffxKH88wsJKaDqhFEbQDbBs6Oy0oL6b2xyZd7HXAW/mPQ7Sa1?=
 =?us-ascii?Q?GV0UEXTeQPIhUtEGthtYQByYBiKzxxqEzL1LF7OmgNmAk6nVTLjh7Pi8pCeb?=
 =?us-ascii?Q?NjpDJgrSLUsX7FoevkFNEoaPi89YS0NOF5Yvt97zXOCda6C2pv88f6Mj9KRp?=
 =?us-ascii?Q?MptLC6ebiKzGNSHZnOsHkEwxv8P5f+b1G2jLNrKdwEwzmkP2E+SIufRdVt1O?=
 =?us-ascii?Q?BDAb/FktPmsjlub/D0WKEO3WMwKm7dbVpYP6KDtkT9cfwRAIdkFlXDLOFrYW?=
 =?us-ascii?Q?EhZrdVbF7UFT3xbj1NMtFAmZ1RTbZl/4PCzmiiLsBOBO1zOPbc25oDRUknpP?=
 =?us-ascii?Q?UtwsemvdfWBH6uN/a/G3la7mzrIxJJx6Ba31s6ffOAYQdvvLGIFO/CGnlV1b?=
 =?us-ascii?Q?HQat5h/8c1hSiE0fc1Pyj8ARMo+C/CPSZItRczo3D1WUPz3IXYkvZgAeGje2?=
 =?us-ascii?Q?3AYg8Yuf15EJF3JzXVhsc/21kl+VQ+OMlULksF4FpmTfpc7Uj+TglWh9E0og?=
 =?us-ascii?Q?WsS+cj7WaJnb4vEHeWez3grb+eVsgbfoa84iI5prymmzmWFQwSyIkuaxrVxP?=
 =?us-ascii?Q?9qOVCgKKXJODMiia5gevCGdj5lCr2ipO9EA0eUnFTPLoO8W3CJGWDw9EKgxY?=
 =?us-ascii?Q?wAEnauQq0ewm/Dg18NFcvTpdGe4UfpvUiLObb9TAOnwt2LyDxsqbtj5XyP5x?=
 =?us-ascii?Q?xczOFqX1HpdDNOmtxZf5YmwXX8nugLsPeWq8BkgCYkCoZzfV0mBnJPcCCgnl?=
 =?us-ascii?Q?vVaNS8dGMni3Wka1lDKgm6pqwyfZM4PWab81aBOcDzr6kckfCVRJWybJn/jM?=
 =?us-ascii?Q?YpvcUKCCQBgP9401Au2VhecWnUKCMNYWqi+qenjH5wiwxYaWaDoueyq1nNbl?=
 =?us-ascii?Q?0CbouSSiPc5wZzzfQg+uvDdYVsMz8giO50BV/pYeMcMhIrD0nFsDT9awRMoQ?=
 =?us-ascii?Q?FYg7M9y45GNE5vIOVxl0zIzgmv0VrGuOABg9OHEA+Dqo9LLqr7SFTmY1GY38?=
 =?us-ascii?Q?RiA53DEcxkRKr2G1KjnsGG9T4Aizza3lVgup7cF759p1LpidQ1KxRnW52IAL?=
 =?us-ascii?Q?x6pp3wSlnlJ+LMQyERr2caP/gjyuee7V4uVfAKMxSWXABtQzpDkN0XoijwGG?=
 =?us-ascii?Q?RCXJhGnK17Cg1NYthtv++RdDUxJ7fuTIRFZXuBKP8g6YD0cRZfW9dbFnG0yX?=
 =?us-ascii?Q?sGrGy9GpkWrvRoCUQeFEu9On86lRWhuAE0OvOTh6SHM+IH2KP3ToyEkyWyHF?=
 =?us-ascii?Q?/NgSDy8P2X24xj732tBAfLMrtc59AYpi5FZOqO8V12GMA1qUF4W/ZwdnewaU?=
 =?us-ascii?Q?fRTouVKjBJW6w8u5jDau2PgToN/4CaGqSXi4Av4NwI7VsatuX3QqmA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0943.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+zeAdBjZo9Awa+LZTKaujC5swhD4o4qPCDT8+RJEvl+Aapsh0r2Io1kvzoa1?=
 =?us-ascii?Q?u+8TjNmZw7WS06cC28dfh9/E0JQDfv2YwDWjct2GsNP6QHrVgdCHK5zCFq4r?=
 =?us-ascii?Q?5FONM7A7PAyWBNVbf6EGN9MCO9Co7yK6M/EuxzswJkUL/EYP2pxSB/AbZn18?=
 =?us-ascii?Q?pkOSuXiHsgIwaX8iAh2eWAmsixgPj8+JzBmfxWSGDZsOavmJUzC7J0t+IAp7?=
 =?us-ascii?Q?Rynd0y7Y/HOomp7HsoqDi+hERBjj6dXe2gtKnvbo5BqSX5j1uhsynTjlscQT?=
 =?us-ascii?Q?cmn+juuXTZDSmbfwJiPdk7XAYChUkEKysUZHGZvGmJYBW4BoWeOEhPFbbpls?=
 =?us-ascii?Q?1s2rxuDhQUgF9KaZEMcdFVrolqh5ztZHMHusXEsTAsbb0PH72fyfP6WKVOR3?=
 =?us-ascii?Q?00ZpJHfxPWeuPM+Xk8sA/olF/H5NGXTxzyNvsEKoECT3EWLH5SMDM0kNk+5f?=
 =?us-ascii?Q?EYKteXSIDUakEfrH3wjy51pEz6ZZoUqfhlo83lETMcwJ0HQf6rkAoc9EGj9a?=
 =?us-ascii?Q?kYAvOEf1A9YkCzVL5CM69eyO7VsAacxl8mDchwi9gB8EM/TZ8F7dB6WnlIaV?=
 =?us-ascii?Q?jdbiY19mfZFYtmGPgjuk4bzzpLguoA6P2GDzf6kzcx+tcdrMiUmNBPGkarPR?=
 =?us-ascii?Q?biG2Dw0y8cIY99owpghuriH0xK9O2PhzsZKwnQK0wnsB036hgXfPxUMXyOW9?=
 =?us-ascii?Q?EO0PpNeRJKBAHLkED6G+y5hJIZCVYYsTGovCyjj1XNxnwOxNnW2UMnyeOOWo?=
 =?us-ascii?Q?LqoYpn85SLufb48DL87lXKH1Yk3AMD/Qfrbf4qZjYdp/YnezwjF+ntTB6D1t?=
 =?us-ascii?Q?xQT+W2v8zjZVTY7SOj56ql7PR/mBKddlzT3LdpbQXfFkcSAk51K37d49m1QT?=
 =?us-ascii?Q?prn7kNLv7gwKXQTa7SQb9hIMlwCaQyJ32a/XQTelc5Ipp+PBcn34dbpXGeUw?=
 =?us-ascii?Q?9Br+yM6EUVhMaLGPhfJBr+/NAJ3bO3LNwFZT5y8RFyLiCbcgxCY1oUc4aKyv?=
 =?us-ascii?Q?rrVCoWwdQenjPLU17FNgmmoggvGNivORhZZjXwZJP1P32c7/T95i3DegYBNu?=
 =?us-ascii?Q?FI2OO/nhxNQcFioBfG/h90EAN5siYfTdOA3xlw8+FAXyTGOrPkmrfsLC2nbj?=
 =?us-ascii?Q?Ir5v2zI4SWm3ox2pj4ti/TaCofh51wMOUYVzjYSsqpOYDrn5yKI1ecrAFHd9?=
 =?us-ascii?Q?NW7oiKPqU7/FHQeSettZRsMEDEbdrw3gp9ep866O/0b3we478ilzqa7/v67M?=
 =?us-ascii?Q?hvvjY0jwq2GPIeYE/lbLtyszEhfmI5eWi2btdSxp0LBzJArtnBxGBu+W+DVh?=
 =?us-ascii?Q?x42wFA78jXxcedwGItJLAF6H8O+8IMQgZ/uiRpeWK9cqPXBO9/LzyQGUiAch?=
 =?us-ascii?Q?BYo8Ga6UHCkO8NfULtRJKD5iw1SGLjcbG0JTz1IxpHuCzHYn927X51/arfGm?=
 =?us-ascii?Q?5RdNMOXn/VnmyzgLFI1TgirIolIKCcY9py2F4l0hT1ji7FXeKNcv6RqXF/SZ?=
 =?us-ascii?Q?/mop9O/p0JgaRmmKi7JboBHMFttVouEMY9KcfuMe/uiPogac4DOBeR0h6d7K?=
 =?us-ascii?Q?G8Dh5O5r2MrCyRY+dDyJU/krM8Ks4TdrAnyG1S4q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2d0e9d-0d5c-4c22-0c98-08ddaa9cb36e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 17:06:55.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +j2d9GsNO6llwuoXFbhNMW9iOjAU8E2GTDb+0U5rzi+Gu3VD4HZMQCro+dBGUyKziV57Yeysep1lk0ucRD7Sig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4287



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, June 12, 2025 9:22 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; Dexuan Cui <decui@microsoft.com>;
> stephen@networkplumber.org; KY Srinivasan <kys@microsoft.com>; Paul
> Rosswurm <paulros@microsoft.com>; olaf@aepfle.de; vkuznets@redhat.com;
> davem@davemloft.net; wei.liu@kernel.org; edumazet@google.com;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; andrew+netdev@lunn.ch; Konstantin
> Taranov <kotaranov@microsoft.com>; horms@kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next,v7] net: mana: Add handler for
> hardware servicing events
>=20
> On Tue, 10 Jun 2025 11:42:22 -0700 Haiyang Zhang wrote:
> > v6:
> > Not acquiring module refcnt as suggested by Paolo Abeni.
>=20
> TBH I'm not 100% sure this is correct.
> If the service worker operations end up unbinding the driver from
> the device holding the device ref may not prevent the module from
> being unloaded.
>=20
> Could you try to trigger that condition? Make that msleep() in the work
> even longer and try to remove the module while the work is sleeping
> there?

Thanks for your suggestion! I tested and found that I can rmmod mana=20
during the sleep and caused accessing freed memory. And getting the extra=20
module refcnt fixed this (prevented rmmod during sleep). So, I added back
the module refcnt holding, and submitted v8.

Thanks,
- Haiyang


