Return-Path: <bpf+bounces-29669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98BE8C4874
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 22:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC14B1C20CE9
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C4381AC7;
	Mon, 13 May 2024 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dv3slrdD"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021006.outbound.protection.outlook.com [40.93.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F41C69E;
	Mon, 13 May 2024 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633443; cv=fail; b=rKBk2zHnB6lfoqotAsAClICtjjsXIO1ygi2B43dCOd1OE2tASdi7T3NNPj30/j3MPgYw9TC08eVJAay0nnPlLCxVxkXWJ9SfCUDnUgLcUMjTsyAJb5S/D6CBWFRds/mBfXJSmvSaSKryyb1aTneW1Z0ORf7l86G1XP4f87lTB7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633443; c=relaxed/simple;
	bh=UbxpnMKaNwI97jQyhCl9SJ2XtNtQIMdYLl/qnESXs6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XN2aPkbS53G2//eu3blYfam6e5WeLjdyJLKIMl8JE9+t5/wIIPeOZ8PtbWAc9ZGcJZspzExwmPo5G/d8uSYgg+7bSiQXbCSOk5ynitOha+72cWXyn40pAbi6hzA+fPzXqoXiJBQVCWw/X+W5CFAd7IHxMR4mnpaQx2JYrLY0FRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Dv3slrdD; arc=fail smtp.client-ip=40.93.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrrYCv8HxOusmMYKQ570i0X/GR7nrkQ8L9PkoZhmJE7WYCWDbdT5weqzVwe2j+Gxb1s1gltuEmT3PdPKtQhMPejiY6hBPixLbBntGkPriJ/Mq3J0Kg6T0amse85grAYcEFA4TLvzf6nVLq93MSwoS9u1unMRgsvWWdhImaCSflZH5C6wrbCfZ3nlE4DHIJL7xB12Ub2mwQitFlzceZF/7OAGTGujj3XK0IVkJSfaRXCdLoIOx3cfBvmr0t60uaNS05ILhxKr2BGEk+QHhI4uJWW/dP0zrXiVRjBpyKGEdKuSyCYHq8mzglxfrlGLfDu4NTHp4Uoq9GhUN0GzrRJZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5gH74DSu+jfqStvA8VcF4BfD8y+KLuRxkJlu8XBm/k=;
 b=NOps55e1XCHdCTbHwjcLA4FyBVaA5f+LrIxhDEheIu0P8KClwTtXVxT8BX+0hjaEHuTX+XzBtGsmrF6sG217LcJzY0Rcl4uArkPuvsxbhLu+e8C718sNA3psAu0PcRfbI0e8A4Oo+JZyKxFJU6DnC1OXsgH/Kwcdr/fpEMell40W1WL/ADX5yxhBIUdi2TcjAp7wMM+5OsJzFfJioAKrZ84HjSWqe1+DTYFkiQxGQBP8DucayKs6xZbA3zg5CPu2ON0QA08SgWPR3I4uC1bTmQs2MZrDsmFuIrUqKUt38lsnkZYfEYBUQxAU3CpzgxzOyiRRxZVFMG6ydK6mkzNasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5gH74DSu+jfqStvA8VcF4BfD8y+KLuRxkJlu8XBm/k=;
 b=Dv3slrdDkdJ7sj24iInRfevJigr/XQnLfgB8J6nd/et6KcKdmHp+HOOHwpn//3MfiLM9k68bEfAQrWX+dpEWmPvnoMtPUVYRvNKfHv56Rinv8OvV6kKaAxchWQxDnewHislygIflBqAAmDvwfSNwNRAS+D2IUF4sVaklY5YYMtA=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 LV3PR21MB4191.namprd21.prod.outlook.com (2603:10b6:408:27c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.5; Mon, 13 May
 2024 20:50:38 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e%4]) with mapi id 15.20.7611.002; Mon, 13 May 2024
 20:50:38 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: mana: Enable MANA driver on ARM64 with 4K
 page size
Thread-Topic: [PATCH net-next] net: mana: Enable MANA driver on ARM64 with 4K
 page size
Thread-Index: AQHapXRSoF8bWF0GzU23EBNbj3wY2rGVoRqAgAABNAA=
Date: Mon, 13 May 2024 20:50:37 +0000
Message-ID:
 <DM6PR21MB1481F5EE04BAB66E380A0706CAE22@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1715632141-8089-1-git-send-email-haiyangz@microsoft.com>
 <20240513134201.5f5acbae@kernel.org>
In-Reply-To: <20240513134201.5f5acbae@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=16de0ef6-6bc9-49ea-9ab7-dc6239760e82;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-13T20:46:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|LV3PR21MB4191:EE_
x-ms-office365-filtering-correlation-id: ee5ff38e-4c1f-4fad-f268-08dc738e5811
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vKYC12z9w998ZPl5tg+sFnR+P4Eii8uFV9luCkCkqKdb/921OZSmmaorv2ln?=
 =?us-ascii?Q?eqg5j4J4CVQwTTth3y7jXOfAEuqoPPh2vt21qpphGK0tSs54ahwvmvKv0oFa?=
 =?us-ascii?Q?MFE2JA677jnhHc8FfT/yejWEVqDZg39gCTkBq2aAOqnIK7l9+Js0577XCzt0?=
 =?us-ascii?Q?bF+fjCH9S8mLUVBqJTtXLLqFZ5Bd5uaYj67HuoHWBLoUXbyfZYEx/ZfX46YY?=
 =?us-ascii?Q?4hwr/X8mC8AEhLrgWpUo4mXTWqQOcDEy3raN/wCJeOJSfE9ebwUp8oOEP3Ei?=
 =?us-ascii?Q?OoCst7LOaz9l5e1sHhVc+b9JYPHLmptdEemu2l4sSY3kdRiU4MzFMU/GnYjW?=
 =?us-ascii?Q?93YpOL/+cVlnB0wzMPxNM44XODkfGH3qVxFKQVu6E5V5VWER5CkLe6onjTI9?=
 =?us-ascii?Q?nJMNFD31NQcgN6T/W+KGUB57YHNATEKjTjADuqq7Wmxd1KfnXr04zil6+P6t?=
 =?us-ascii?Q?7i/0Mcu+G6rJyNrni1xkcw3+HZot9IHbTvpbZEEBqIlSgjvfYIBi61/ZASPv?=
 =?us-ascii?Q?USoMbSA7pdq2NWOe9Wt3BgPDS+XDsHxhPoybOAgucT7NOrwOk4g8hsL03xx8?=
 =?us-ascii?Q?SaTlU5yoEoqymmyJgNJrlGts9wHUkYHMpsAmhKjgPqxFBl2ZY8LATKL6lTqJ?=
 =?us-ascii?Q?3AnaZ9Oy8Btr9eaFQAaFtDu3Bs9yTim0x764m1S2ajqFpO3zi77yY5Tz0A7M?=
 =?us-ascii?Q?fB7ZSHHB0yxxrPNV+bwnPIl/MdqyHH6qat/f9oCxaViY5eMUvWDyaPCDkydo?=
 =?us-ascii?Q?9rBH7H/9i0iPDQoFle5xx2vIvHhRsC1WMKrQA7m6nt/ldyA7/sC6FayVHTiC?=
 =?us-ascii?Q?5GTdhslGmWF4k15GmiK2OJJqrhBf5LhzB9aFf5zIcY1encgXmna6Nhcmmob+?=
 =?us-ascii?Q?Dayf4MIX5avaz4gXU/DIAqj3oFVa8MBRxoQnmcXue7/nQ21eqQLwjpi86D7g?=
 =?us-ascii?Q?5Q91OEh6kZnmtjj+N3Ty01eQa97rA8ByG0fk043mi+NCm/y6e5B5YkEBZHXR?=
 =?us-ascii?Q?TDYCQ/jTBs6yvqQJlyUbn8/HJZm/LOfJTiwp3cZG7ZPe5SlzfJtzSk4Rf6IH?=
 =?us-ascii?Q?JsNp3eLMMRJQW7bAMYrl53dre3+Z2xx3ryKF/HIsiwLFyjyecAMWkvMnXWxP?=
 =?us-ascii?Q?dZQADxAc6YDppcHIgIotwZDt6+IHDk8OXOJt/y2YoE4ejkhSh2iU1r1NieS6?=
 =?us-ascii?Q?JtiWSW9eOUDWpgx1dr26QSumqr1svW9WfdLU6+PRHaxtsLuxLwBzYRnHx21i?=
 =?us-ascii?Q?YZ9l5z0vkfHJ/Y+zSctLK2QLRxDVqSX/FPlfaygwNw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KKw68Bc/aVlIZQIG2/+mjiztrnM6x2aOQ/yOEJmtv2UGiElMNlfnlHZBZsIB?=
 =?us-ascii?Q?X42HXaDtUHsj6p0vbVrNvH4MKFXgMjo9sMRwax45vYMiqdqQ8OpuhTeAB8AN?=
 =?us-ascii?Q?yECvZXsstmRmAmwyv4JWkr4IeJd7EgEDv6CLIhP25JZaes73cAgQ4KVS1uCv?=
 =?us-ascii?Q?qtXDw+tm8FolA1VKFUyy6EDxD1JY+OlYTvclJnf2MZfxpSHspZXRrwR0mM88?=
 =?us-ascii?Q?tpUsbaFEvxqFIKwuqaN9AQQMTNoAkBR5wgCiKe9rGD3NK91B+RCLLkFGOARs?=
 =?us-ascii?Q?6u/Cw/UxVm0nDEqo+ax5pJsV0JxhnvAdyBbXGzt7QxQQOTyfYPNtJMRRO9ct?=
 =?us-ascii?Q?5KOGfvTQG/tQcELZSf20yT6HFkcdEChBN1bNcIHdTnqaHNQJFlH5mTaoGgdz?=
 =?us-ascii?Q?ZZOo2id+t12EKlyL+Lo/kxcBUPXjOkRVzox/gpia/Nv8pz0DvjPMOegfYN/a?=
 =?us-ascii?Q?Wc7Y59Ectfot7z8XjRHaYwmpaHItffpIjwrhZ/dypWUIxN6hsp+5FY36Dsgn?=
 =?us-ascii?Q?Rs/YJLOKdbm82g9u3a4DNHE9NjI3ohk9Pvb6AzM7BVyffLdysYc6Z97iOJvM?=
 =?us-ascii?Q?Gi+BqXtfNX5wl5AhqZppWYwP6mUVOJgvcfI6/BZqbZDlQF328Lrj6F3m/Q80?=
 =?us-ascii?Q?K9taRzNJXUIs2IXpahPMdEXhjiJJIxYffTFw4eYhwb1XziyAl552zmlM+lOs?=
 =?us-ascii?Q?KJzujWiJdhyourez4RB5Lumrkhh7Fpy5KZ/HSz+LXL9/xd0aJQGYjoVTaVAD?=
 =?us-ascii?Q?4z15gfkzo3BDG4vNxI8CvdGg1kOYDvJiUpjxYmjaTww7L5J/IqAGELp64FKm?=
 =?us-ascii?Q?50+/EnPqtHWLzcmDgxdk6ifWn91sPn14LjY6q9UQb7my5wl/qPzrOFN2aLz2?=
 =?us-ascii?Q?CEivWryj60nXp4LQJ3T7VaoX2YOrefm23hN52lXXgeKFxKDc34LrnoWcRlPV?=
 =?us-ascii?Q?UXMcXyUBsmNT1gsNbBzQN+UTVr5QixfDF885s5FI6quxJWMNrAH/SfPAwirQ?=
 =?us-ascii?Q?KT2MFIVifTSBGYGyHvYIiRmfj0scXhluu+Obz43mm8x0X8sHOezhxEZvjosM?=
 =?us-ascii?Q?+lAeko4YU/dxckMkEJzGB01Eyj+GPVd2N2UnVPaGZSf8Gihk0VQOje3tg/Ei?=
 =?us-ascii?Q?fCleVFrWUwi49e7eAhTypDenI3hLNLb2+j7DPqbZU7PmzJ5sxPHImTO5/puE?=
 =?us-ascii?Q?Urgvakdqi7O7YFhAxnwU4Ibenj+OgtNiOXfXQHLXJjZ0vfmLF8vM7nxuJRbq?=
 =?us-ascii?Q?RRnuZ9OJKBqsrYo3UslMWE8CFf02TQh6+NDaFnTunCiys7sKBc5RzF5PVvBf?=
 =?us-ascii?Q?Z1YJuCbKCECSoskoqauCEfcvXPLJPAiMBcoYlDmZqohL9iThkAptcCaN/oZ4?=
 =?us-ascii?Q?VyH8dshBrtp1U5iNIrKns+qux+7f+qjnGHZRshoxMXI2l53Doy8auhc1LO2K?=
 =?us-ascii?Q?vmpESmmIjc75LDDCP11AO/W/NGgv1gBgdyFXzOMM+3P9o4BojN/HxEOoM+iw?=
 =?us-ascii?Q?RoLbd1h4moHqTfOd9k5TXdd3SoFTF0c/002/S/ENIDGXxXoxJDCjtvgwdL8Y?=
 =?us-ascii?Q?ib5LLJCDMjslxo+dOvXyEUo9+8NKersDDbgo9kRN?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5ff38e-4c1f-4fad-f268-08dc738e5811
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 20:50:37.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNUr5fU89Wcy2N6hwibGVvzeozATPHouj6OXRRZIOVgRf/Kl8q5ixK/RD3v5XkOp68a7IC3PIp8jVtykOMc2Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR21MB4191



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, May 13, 2024 4:42 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; pabeni@redhat.com;
> leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: mana: Enable MANA driver on ARM64 with
> 4K page size
>=20
> On Mon, 13 May 2024 13:29:01 -0700 Haiyang Zhang wrote:
> > -	depends on PCI_MSI && X86_64
> > +	depends on PCI_MSI
> > +	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)
>=20
> Can ARM64 be big endian?

From the document, it can be:
"ARM cores support both modes, but are most commonly used in, and typically=
 default to little-endian mode. Most Linux distributions for ARM tend to be=
 little-endian only."=20
https://developer.arm.com/documentation/den0042/a/Coding-for-Cortex-R-Proce=
ssors/Endianness

MANA driver doesn't support big endian.

Thanks,
- Haiyang


