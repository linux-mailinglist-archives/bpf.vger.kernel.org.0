Return-Path: <bpf+bounces-58663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E178EABFC42
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 19:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BEF179CA1
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C028980B;
	Wed, 21 May 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FB8F5eCs"
X-Original-To: bpf@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021094.outbound.protection.outlook.com [52.101.62.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00C1A5B86;
	Wed, 21 May 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848527; cv=fail; b=DXIPr3SYlL1qI8ntyOMRMI7YzSGhuW69mu4pvNpzEBWiobB6NFkyuJ4TomUJ+C1pfow87ajLhNNwk/RYyYkR9DYA3InoHotTm5BixH41XszICXbkwFU0z97DdDk7PaRALG4aDQJexJx2kMcJlHtzDNDJfzoabJ1J3l7XmMbY1xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848527; c=relaxed/simple;
	bh=AiRwuqE7g+2fbtYrfWBrOvhl7gAcT5DX8soNvUIiLCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a8PT59QuK5nUlDz58BqgEfF4Z3RVxZQFYxhQ4eXSKmYiJGvGPxX17yG9MREmVNh88pT2G0eFHOAlLIDqrDwdysr6nDWiPsY8eLYLX5J45W2IhU2GQFSyTeOgaed+NZSUqEmm7YuTacHEWzhdv5cgRVq7JFYzFt9FntxaP/DxNFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FB8F5eCs; arc=fail smtp.client-ip=52.101.62.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOLvTR3tnCqngn7y0tYaouFbOHgXe2S5G3/d9yUWFQXzrZERCFN2QbLvuhNXxMRBeHzeIwTnqjXbsFV0mzSo7qPTWiGkRYwecb8CqeEE6uwIc7YYxCKiQzqpN5SHSXgOB25u6cN+fu3Po9wVl6Z426Z5NcA+Z+A8AwLwfgBXJokO9/RNz4k1FHJrMYgepOMzMtoj/1+obIHMPkT+W+ucrG5Shb6KBhi9CnquiPMc/8DMgQD/7EQNFOUJv3leaZYMPZ0TwphVPTkrnm0ZPXSy0hIZX6H9BzzJ+89uTmjWWGnlDjkJp95UxwRvExinqApRmQrTu5BLDRikEdA1HGaDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20EhX3nT1OakEECAAAaFF1f4Roh44luGRXPWndMq+Ho=;
 b=e/ZjnArho5rLZNxBcMrZWQbBtU1c09MrL9eup6AmpdPVCFxRLK1YaiG5wunVs3ZFrLmhFDiVolAbrBTqxaJQu4stVQrf7kdaDfLeKjTOj3+sMvXV1xQ4odmH+2xxlRpIs9GcAhL4V9wGJz13ZyjQxosGKbGFZnYB4HDRn7HIo5pbySuqU30utgjERhEcaqoyYaQYx0QHHq6B92lD/DXrFDcLWv2gSXHk0fd+uJVDA2ipeFO8B02uH1pqZ8aey4AwNiWz32apjHbznks9SXNC7siQiRrUS0mvUvbQlgBCPuHMOeJK7flFQsXnOPsyPA/3W1EgraLXBCu2QdItUyQCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20EhX3nT1OakEECAAAaFF1f4Roh44luGRXPWndMq+Ho=;
 b=FB8F5eCskK4D7HyDNndzig0mF2tJdohuN2JyOG8dZHWk+g71DRLZ7nDPv+stPixdcX88m331AY+JCT5x11JzUvXwHQ40t+KBWdl+r1XMELzgpENLdDarghLVZefdWsopOo6PdwBv9ZjaICvMTp+Wr4/G3o05qrb415fL+7BwG18=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL1PR21MB3139.namprd21.prod.outlook.com (2603:10b6:208:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.18; Wed, 21 May
 2025 17:28:40 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 17:28:34 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "stephen@networkplumber.org"
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add support for
 Multi Vports on Bare metal
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add support for
 Multi Vports on Bare metal
Thread-Index: AQHbyNn8vVCGUyGze06AyBI1ln70urPdIEiAgAAzRTA=
Date: Wed, 21 May 2025 17:28:33 +0000
Message-ID:
 <MN0PR21MB34373B1A0162D8452018ABAACA9EA@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1747671636-5810-1-git-send-email-haiyangz@microsoft.com>
 <20250521140231.GW365796@horms.kernel.org>
In-Reply-To: <20250521140231.GW365796@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6a708164-7a8e-410d-8122-0ca75553fb8f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-21T17:06:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL1PR21MB3139:EE_
x-ms-office365-filtering-correlation-id: 2888f9b5-c129-43cd-6d23-08dd988ce9b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?69AivwsuQZevk0AlvIJGVRGU+2s8e+/Jk3qhv+UYzjIHhDkOo1MMrwNT7rzk?=
 =?us-ascii?Q?Cjcb1ZsaaWCBVJOBItGXFhKnD6mkxkamhR6c76c3xsAcXeVeq6vJNecRDfAe?=
 =?us-ascii?Q?pTaM/0I7uqS7q91wiVciJ3usUAo+mLJmQZf+dMgQkYQMJ4b65fevJbVWhrXa?=
 =?us-ascii?Q?Qx3E3MHeCk3p2rVSEimWhOLWogKkz6wVn4HggV2rpB+WsefOzfDE9069o5z5?=
 =?us-ascii?Q?XQBeRBptnOKkB+Qgb6uMMPxFDAjYPpfQ0SiQZgbgEdG7lzcCJbURe/uQfOWZ?=
 =?us-ascii?Q?VaS0rzg32QFzILEr3pA9eFEhH9f5aa9rdboha6SpV4o4/xWHYkbdqhsKCpiX?=
 =?us-ascii?Q?CXpTr84UbMnjcmw/sBrNfcycLPszuA8r4lumtEv+krgQ7GNzx24gJekpLi/A?=
 =?us-ascii?Q?lEsvQt4LZDGQq5ow2EAlfEl86SZy0Ac6i0bb5KYE9abuGpvrzVGC4jyBKQCu?=
 =?us-ascii?Q?qYaqk3oHiuUqXtTfqNlssMrGkJFkDrNnN3a+r8G7Y150w00XwL5uraR1rGJv?=
 =?us-ascii?Q?FV/taV/hzh3kVbMl7i29+PPQXE/rG/O9LyiYk25LqcLp1U/5Bcdhv8tkKRzo?=
 =?us-ascii?Q?jFn8LwKgpy19tceF80Tu6DmWRD0iAuOstuxeL3rothYMdSvQSpVFOErrUemo?=
 =?us-ascii?Q?00W5WMaG4I9enU0bmgaroKbKRHGgrgGfH+sKfDzzhqWSCUIPjZkvEUv2+wPO?=
 =?us-ascii?Q?q0h/SHiE6BuGO6+e2CJ3dRIO5LYGlq3ZZou9jBX0cZiLS3Dx/JehJdRywUi6?=
 =?us-ascii?Q?kNJ7q5I5axseSqGoNM7FH6Ahv2qSiOmy26GtAYpbFTv0ILKl2hQap5cnh2mB?=
 =?us-ascii?Q?M7zLL59rH0o/cqdOwhbNMbIdxe8920uEFsAcfWd9+Wg8RgqM+EwT1twXqn6p?=
 =?us-ascii?Q?D6AiXW88eU9DHkEx+CfMF9FvZPdI0IyETbGnLeUxgdNmWDw5fF8J52Ox85To?=
 =?us-ascii?Q?l4HF+lsgs9RY/rgdaGYmggY/2K2yOjVMT6zrqSlysLXdlvpWnXeVWn0cZiBb?=
 =?us-ascii?Q?qIWZ6dZkT2iPTFUm0j0071KOxrNnyJK94+mlIKkW4WN1BYNavy3qnZj0Qktq?=
 =?us-ascii?Q?B2/RaoenD3cM8ZvQkLl4flZLaAEmPwnKS/t3egubO134OBK9u1AtlONlsNSQ?=
 =?us-ascii?Q?+8ArF+9oeILrZoC/OSsdKTF4+VtGRjtJ5N8apO+gRq5SKjCaMUmutQzoKRXY?=
 =?us-ascii?Q?YaLHTBIv4GKgv8jPtaxNRSCM+uaD3Ud8wmVSDofyKIiAj4dt/6hMZjvzYq7b?=
 =?us-ascii?Q?Kkm8qVocyQQcKIXGhV7LJ7peC/1Exmappji1AA6qwymfoZVhYJFuUMwfTrGP?=
 =?us-ascii?Q?Zy6yJUUPgCRoKC25lVXD8EzlxCYSL+q+QwAbxb955nulnYchS52ww/+/j5qi?=
 =?us-ascii?Q?LxZv6xWF6jSVpGb/D55TtDiTNXeTJRFt8Xo/QtatWaZP4zGtoRv9NKUBSJZ/?=
 =?us-ascii?Q?MujBkywwgnRL3OTqzbni4P2baIxV9YEVrvRbBY04Nx9hEQI8RMJIkw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y6/UDguKWEtih6W/vuye9L87hfXTXYQWy1pP8RblMq/w0CbUGTTyYYWvMy3k?=
 =?us-ascii?Q?qboDF6vZ3nkDBMWt9K+cl0WcggNuyQGHIOSzh4LHJ/Nkzf4LHox1aQRsJSyy?=
 =?us-ascii?Q?RXjYx8dMSS/7SjL8u7DKli+huD6OrKbrHMmKZcjpyiBSUZko2FW2ehrETK5p?=
 =?us-ascii?Q?/Z0+KyepbfBnIuukeNvKTXCdZ8tq9j21t1HxVvJmhdptfOfx7G3iFaigyYmI?=
 =?us-ascii?Q?OVgyvHf+/QSax/WDOJqMqEzboGTpCUt+aY5Xz5JO7aSkNBIE9iDR8YvoDP8c?=
 =?us-ascii?Q?/wMGEIvN+1jhAqB0J58Mo981kBjQgB+veTm49YX9E4GDM2wVzNm2M51TZx/h?=
 =?us-ascii?Q?7lrfqb8vXfMESZUUI6lG/2IyHAG45OtNAUQV5HYhkS9pLVIJ762NtsZx+6f7?=
 =?us-ascii?Q?JswWOwUcDQ0W9oKE//emoop4rI9vHQSVAYjGzmvtE+mX1NfIh3E+uiawoU12?=
 =?us-ascii?Q?rErM5YSmLfCu6OIWTrnyINWwIMrVI7PUcHI0Tk1ZGjTjW32w5Y8gelEvDTjH?=
 =?us-ascii?Q?TICL22thGwlR2RQvjehWxQwz/uD3sheUmskyuIFTrQZpEZMVRGCyTdN1s70B?=
 =?us-ascii?Q?dw54VUOyQbqw194mV3eHFLeJPNz1DHiC+0hczivUbUVz0EgBnaLz1GhZ8B4Q?=
 =?us-ascii?Q?GZ22TMl8x71mhrmMWzdcUGT+ei9eaCT0ctkWvl7O+s+bwEZR/ZAm7suhNP3/?=
 =?us-ascii?Q?dygONRq7EICor1ggvXFsNGh+tM2yU/vq0bSqzknp+yK32Tqx9GABTcdnIkJR?=
 =?us-ascii?Q?MUn1vRofKAktxh3FnLhsxUVbdqcRp7kUCw3WVbO7MuZx6OtzCAoGDwWsN47J?=
 =?us-ascii?Q?oBu3O0/zCv/FQG0SSSsQ9olpkFVxabsnDTR4HaU+YdwkFmAfIFVXTYQygixz?=
 =?us-ascii?Q?I9VEDhqeUHxwvSxjSjjFn11Ury4p4vBU+H4ocjsK27tIX9dwFMv6Csr2hd64?=
 =?us-ascii?Q?7VovVK2I0bujD32HMeS26hX0Av8gdo5RjCsPsVfYFhIR2FodCxPPXIpjr9Rf?=
 =?us-ascii?Q?+CnLw5S9P7sMCCL+qNPb61+g77N0LHs8ekbtlrcOwpb0UlGUtlKyZ+xVRESS?=
 =?us-ascii?Q?fTkROttSZBGjcduIxxVMVPOnQGF+yxS9Z032iVuTX+5E38H6VQUkaOVLB/Wq?=
 =?us-ascii?Q?4RAedHgQNaQ2Ck9wEVVnmMT8Fz0vReYQiw7WCKtPtbibt3o6bP2D+rEaRIaB?=
 =?us-ascii?Q?onDjBP6Vn1rVsdvW/ivE9OvSeHRUPi+M4R3L7Adnj0OKFe/saR5ZoUoK8nG5?=
 =?us-ascii?Q?OxUFnv0D4D4Xlk7bp5+q11pJMCU54zlU4EHuNWzwNlgI7uWpwhMjespcll1B?=
 =?us-ascii?Q?VXiRJc7D7qUDgNyX0tbN6nS3VWJavL2JckkklYibOoF8LS80MniE2mYjCWTQ?=
 =?us-ascii?Q?we+IcKdp7hCZ1xXAcO5/CmWuvi6FA6eQ7zfzE5xNfnNpGL/pQ/sGZMaipcDB?=
 =?us-ascii?Q?H951/xyT2RX9qe5xspS3pMWbqVa8/skqBXOkFcLrvjZxJfA0N3gH0o1I1z4O?=
 =?us-ascii?Q?yuPtPN2RSYD3pm7W9T2SHiXxq6JZGVF9FvqI4Fldgg7cMA5WhLOIVHdBpTdV?=
 =?us-ascii?Q?NIKg4tqY83hdjRdGVFyf9m5+Y0K6BostJeu+iDv5?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2888f9b5-c129-43cd-6d23-08dd988ce9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 17:28:33.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hy/yac3T411UDT3T9Y+fzNDgJwib/bhQK94S1SF4LyPVnivj/j63anC0VVh/RhSUMlFS76H4Fwn4azqNTgja/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3139



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Wednesday, May 21, 2025 10:03 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; andrew+netdev@lunn.ch; Konstantin
> Taranov <kotaranov@microsoft.com>; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add support for
> Multi Vports on Bare metal
>=20
> On Mon, May 19, 2025 at 09:20:36AM -0700, Haiyang Zhang wrote:
> > To support Multi Vports on Bare metal, increase the device config
> response
> > version. And, skip the register HW vport, and register filter steps,
> when
> > the Bare metal hostmode is set.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> > v2:
> >   Updated comments as suggested by ALOK TIWARI.
> >   Fixed the version check.
> >
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 24 ++++++++++++-------
> >  include/net/mana/mana.h                       |  4 +++-
> >  2 files changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 2bac6be8f6a0..9c58d9e0bbb5 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -921,7 +921,7 @@ static void mana_pf_deregister_filter(struct
> mana_port_context *apc)
> >
> >  static int mana_query_device_cfg(struct mana_context *ac, u32
> proto_major_ver,
> >  				 u32 proto_minor_ver, u32 proto_micro_ver,
> > -				 u16 *max_num_vports)
> > +				 u16 *max_num_vports, u8 *bm_hostmode)
> >  {
> >  	struct gdma_context *gc =3D ac->gdma_dev->gdma_context;
> >  	struct mana_query_device_cfg_resp resp =3D {};
> > @@ -932,7 +932,7 @@ static int mana_query_device_cfg(struct mana_contex=
t
> *ac, u32 proto_major_ver,
> >  	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_DEV_CONFIG,
> >  			     sizeof(req), sizeof(resp));
> >
> > -	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V2;
> > +	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V3;
> >
> >  	req.proto_major_ver =3D proto_major_ver;
> >  	req.proto_minor_ver =3D proto_minor_ver;
>=20
> > @@ -956,11 +956,16 @@ static int mana_query_device_cfg(struct
> mana_context *ac, u32 proto_major_ver,
> >
> >  	*max_num_vports =3D resp.max_num_vports;
> >
> > -	if (resp.hdr.response.msg_version =3D=3D GDMA_MESSAGE_V2)
> > +	if (resp.hdr.response.msg_version >=3D GDMA_MESSAGE_V2)
> >  		gc->adapter_mtu =3D resp.adapter_mtu;
> >  	else
> >  		gc->adapter_mtu =3D ETH_FRAME_LEN;
> >
> > +	if (resp.hdr.response.msg_version >=3D GDMA_MESSAGE_V3)
> > +		*bm_hostmode =3D resp.bm_hostmode;
> > +	else
> > +		*bm_hostmode =3D 0;
>=20
> Hi,
>=20
> Perhaps not strictly related to this patch, but I see
> that mana_verify_resp_hdr() is called a few lines above.
> And that verifies a minimum msg_version. But I do not see
> any verification of the maximum msg_version supported by the code.
>=20
> I am concerned about a hypothetical scenario where, say the as yet unknow=
n
> version 5 is sent as the version, and the above behaviour is used, while
> not being correct.
>=20
> Could you shed some light on this?
>=20

In driver, we specify the expected reply msg version is v3 here:
req.hdr.resp.msg_version =3D GDMA_MESSAGE_V3;

If the HW side is upgraded, it won't send reply msg version higher
than expected, which may break the driver.

Thanks,
- Haiyang


