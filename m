Return-Path: <bpf+bounces-37813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B878F95AAE8
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 04:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04EDB220D8
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F5F1804F;
	Thu, 22 Aug 2024 02:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aXqd61R8"
X-Original-To: bpf@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021073.outbound.protection.outlook.com [52.101.62.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8F14F98;
	Thu, 22 Aug 2024 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724293274; cv=fail; b=cPG+kwvs6WYicpVAYdpvfRuAl0+4Yi/FgcoQBbX4D9knreuLLWfc2FsAxwjX/BMX3owxFCYDAUs9SX9DfOBFPDRilau3ZOHvvu0ldK74M6C3sSZ68Fkzd1ABcSraOimh2o4BGE+TpT0jMMvPYHcYNsC8B5sVvgZ5RY8HWXdNsXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724293274; c=relaxed/simple;
	bh=JDNHyY72iY7R4RQ/03aGdDEzHX2NZBQi+vd2Ab1A/Ng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YVXJ8Ih1/kxxoFy7cauEmsePoYhY4nKDcPE2sGMPBkGDCHNPJ8RPe+ecTv5c5R7x8ldM54a+LHooQEEil9Vr9YuieyKzZnYhq2A4q1JZtGqV9rJF8c5JAfkiDgGB7oHKXgrpynbxq6Drr2d5978l5ubK+vEyV9W2IdWR56pmPj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aXqd61R8; arc=fail smtp.client-ip=52.101.62.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVQLOlKdktZYb+UXc0NSdINwsFCikJ7h0CRSfHDstTgCPjC5ccI4lc+oSDOIVZ3t1Rj0oI7QhvEiSCQ+LTLaJcP3sZLZiGZah7sTU8ZOq4LF6cKudaiDET103bRlgc2VjyCrkwR5tcuHmtOxYM/3it5opDDEwxxHD+ozYe74WvHgPEHnENUrzvXuTmOAxYE/mLdry1Qa0ABObwlk1aL0Q7Z8KD31buYmTpT182xrjFp49Tmpv+ruds723YDYYogkTU1TC12wJQTeQcqbZh1AAcgcCDXN2XtthYcBrhZIoL+obztzyAS3U3r5lS27ry5sUtM7CbHbEa4wWTU8/B6blQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83eZ0LmPTeNwG2WVLFvIjmcd/BIgFE7vr6jDfflR5/A=;
 b=hgkFk0z4QAmLfRGariR7sD4ObUJ7pttVkesu9m/bHvfLDdPk9E02roG3fqmw3Aqf3HSYC4ktTO0meT0N4yRcIUc0pR6nxPWaRQZIQtwWMVQU6Q/tAN+7ehhz8Gqck0gV2AjLyaCoAMD/kQBvkRqxXGCg4hV4yAD7RtMXY0khEz8xZM2icdbHoUftEiK7z/J+w0JI52btpBUDhJNzX2j+L6jXtONWzNF3FYkZPtdtq4FiZ36ECISKtf8aM7kIAOg+BmQbn9vwN0+Ck9x7k1yy6lF0X6feZSQiw4nEDa22rmS8DpVl4qg53YR6Wxd3XMkwa+i6gI6LyAYKTtOP+7e1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83eZ0LmPTeNwG2WVLFvIjmcd/BIgFE7vr6jDfflR5/A=;
 b=aXqd61R8dKAVK2syRcLmLkJZ7MJLsIBs2rV+Ey9LC/jvpyFasXKmzFOGzSYbTXrkegZpDjxYil4mSc8F1Nd6rYSgLnfjiCsc2xuLNjciZ0oGhinymtdCxQqmzL4n9CA5ktaZBVDvGo454etLRK9rkQLIDFrbxiuI3orQKZJ8cxc=
Received: from DM4PR21MB3536.namprd21.prod.outlook.com (2603:10b6:8:a4::5) by
 MN0PR21MB3266.namprd21.prod.outlook.com (2603:10b6:208:37e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.7; Thu, 22 Aug 2024 02:21:10 +0000
Received: from DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::6509:d915:a3da:2fa]) by DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::6509:d915:a3da:2fa%4]) with mapi id 15.20.7918.006; Thu, 22 Aug 2024
 02:21:10 +0000
From: Long Li <longli@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix race of mana_hwc_post_rx_wqe and new
 hwc response
Thread-Topic: [PATCH net] net: mana: Fix race of mana_hwc_post_rx_wqe and new
 hwc response
Thread-Index: AQHa9Aq44p8AsxzWjUiMdY7lonjpEbIyi5AQ
Date: Thu, 22 Aug 2024 02:21:10 +0000
Message-ID:
 <DM4PR21MB3536B7F200C702FDE7033C8BCE8F2@DM4PR21MB3536.namprd21.prod.outlook.com>
References: <1724272949-2044-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1724272949-2044-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d932d75b-c45c-4401-af77-4f66bacd2e4e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-22T02:20:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3536:EE_|MN0PR21MB3266:EE_
x-ms-office365-filtering-correlation-id: b57f0308-e048-4abb-aac5-08dcc2511677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e0aWPfkN7eYaHhoGgSoImCaARia0Zro3P7938gvABdqd6JTUShLZVsLMUt6u?=
 =?us-ascii?Q?sG0iYNAQEfamTRu48yM3fKfpObVycLKPqBXyrBOldLCzZtNi2jKOu8nnKbQz?=
 =?us-ascii?Q?ByuVl5EBKMHF7nUEeSSz5TlSy3l9zlhtj+nppXvqfgCc4jA34An+IK5e7+hm?=
 =?us-ascii?Q?t5RWdBErKuM4HnnIOFbhZcVpSu1lcOuddI714DAHk4F3n+WrmD5pA6YHzeAa?=
 =?us-ascii?Q?xnihtu5ldZWBIJM9JPvhIWRGfOPLJa1P16lzd9R6SXSGvv6lPyEUNsFb7odp?=
 =?us-ascii?Q?nOl+XMnvUNtRFdnySkX4iR6xk0A3+Jk5cOulR82f825AiIPKAP43bOgUs2Tw?=
 =?us-ascii?Q?QisOiBwVidbGE0O5QCL2SyJuNyWN38N6tmScTymBDEfHjtdWH/RlYNRLuoCr?=
 =?us-ascii?Q?CVpD8tuVLTOVlknrI5P1vc9G+w8zVKztqc3C24lSCUOEsy0j99utK5rs7YvY?=
 =?us-ascii?Q?rFPlgw55tunMB4wd329R8YL9P8nKqVaBBXLC9Yx+vAdd/LLTUprM74L0vz6q?=
 =?us-ascii?Q?Wk122QbPRVTyCuVZaPcKLdhCVKHodeZcY3vTItAFd1tHQV1wzeEIB8hXJk0T?=
 =?us-ascii?Q?0wsZCgb1WNsL/gwWMopFGL4QLsFDBm8ruldr0w65DvuPIJQZMPnmGskZx8xU?=
 =?us-ascii?Q?EZNkSRzCsF8/krwrtqUF6OWnfBpJWSxR2QL1v+N/Fh1JaXCrqDO/r6ng8TQE?=
 =?us-ascii?Q?IruAO/y6r3GzzmZjTPYDLmfSzAe9UYYVe+vua/2rflHP8CXaiFxSGeMRwC2Q?=
 =?us-ascii?Q?Dxj/xmOnr1f2CN5nFqqusLJ8Ky72vnrIh3qIpiZLncG1WPUq7HsGpRxkvsQ1?=
 =?us-ascii?Q?4HPMO4VWjSCBvWy3jLHOuhTMaJSw8mkQXetSgM+WyoIRJ0AHu2dZo0quiFPf?=
 =?us-ascii?Q?8xJKLkHis5jeQAbpqUPyxEQc0jNcXdUfwNmzQof1beDSrP5Wv11zwIduwwMc?=
 =?us-ascii?Q?dtb1y+U/yupKjP3uGVYaWaamcG7/Txe0AG+OgUKa3wCo+K70uLY06vqWyFxu?=
 =?us-ascii?Q?PPof6wUP3m5LPSUsqPStBzse1YZwNnia/NQv8f5jlXpU4cDlgTIKCpTvhWw2?=
 =?us-ascii?Q?WePiVlTEovI4eCf9fYnQFbq1Xfse1Xq20lc2e+AdmvXOMyJjBF2g8+bzLbH6?=
 =?us-ascii?Q?a/UlGHj6iznyzQHi3lGxgm3UoVOPPM/dSGZpT8kvTGc8R15teXRm3AAWn8bD?=
 =?us-ascii?Q?FtOTqS4gSlbKaXvgicfPxBvPRfvEHke+NiJNaRrKX+0YC+ESwJ1Q+lIUPjun?=
 =?us-ascii?Q?eMyHAHD7/bZ3eiiiarqiXz3c33yrcAayzlvz7X8IXZLTqyaErdeL/Cpmyvql?=
 =?us-ascii?Q?thWEkuvDxrlTG57Qtpxk7u13auJKv9ExuzB59nBNdF2ct5EZ3nNuGp7cN2Tu?=
 =?us-ascii?Q?dD/N+2vgXHYzq3vkRnZWb+hFhqEtnNtAIlXW32iwIO0rFyqrGQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3536.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RXjmV+/+u9pgncigC0INXkFBiDKmIml1AbSRBYpRTEayJFNfpVetb9GSGoD6?=
 =?us-ascii?Q?oIW/jHciGsbwPPtsuSJv2SNtR73bkOlDeX5UHsF4SB8VkECxW0S0CAw5EtLt?=
 =?us-ascii?Q?OWGhkakBYYWbxf8eAoWkSLwxORXlH0fmE/JapjR9h8izYqYzMcoeXkgiKY/3?=
 =?us-ascii?Q?XqSHKcQvcm8pq4AI7YnnrdZp68IRRs+k1TmuZU0+EV1NDkpSchRVuDN/1i7a?=
 =?us-ascii?Q?Sgkf9ZLLvOP5LQJOSq6R4Xg0LtSY/Rp1iIm4AkoXTcgRKJSjjSo2x1f2bQ/O?=
 =?us-ascii?Q?H8uKzdjD5Esub8X2FL1/CMZmySX0xS9sKUSlZPpgZv6I55IJ1+lU9yLucB3r?=
 =?us-ascii?Q?MZ9F0RDGhn99c6l1bJGIC+ckWVdBwx46xjtrs5QlcIhIkq5W9rzu1rJFDaHP?=
 =?us-ascii?Q?RA8cfZvxuFbj3PMS5y0kImwOkFXDgAHuTJwXDh03JQmP3GD9acdU+7c6aC80?=
 =?us-ascii?Q?4R3HksXgkz+UT+rMSi9ALSik5lTxKpo9NToLtvqxqtCEuNyP9EznfOqwzLFt?=
 =?us-ascii?Q?8qLIg18Z6sBpj+wplHi9SzCqspy17BepOz/phAlnxEb7NmSwb3yWPjbRCNft?=
 =?us-ascii?Q?ZhjbIhCYEmhoBkcC3umwhZPC3cXoCp/tNBboZGDfxv1vbYemDj514lXpjf53?=
 =?us-ascii?Q?3iNRYFnzMak+Ci+EmmpJNbJ98xWpmPVygO4fLfzC5+NOH6D5qzbazBLjiyQn?=
 =?us-ascii?Q?LyUmXO1CenUrPBkDmeF20NkQawn+A1ByTgap6+Ek5oSXEoVg1ypHQaKZLmiY?=
 =?us-ascii?Q?BcaopiARJPnIr0pEtOfo04BK7weacQa5OIc94pnZbgE6vDdnbaDZGz86h5vn?=
 =?us-ascii?Q?plRoHsgyxtW3epPBbyedbZgDbNW3Q44FIWdYFcZVp7pqCR8IwZdy1fXdPIcJ?=
 =?us-ascii?Q?c22oiXcoFt5dcT6pi9RMY9uJVNAy2BOBNrym4XusTABb0JxxOtlScyZUGdSF?=
 =?us-ascii?Q?Mgfo/8Jg4ZS/8xGtr+Lo3Jme3P8mAnQc5ppLb6n/fAfOnM/9JzxeS0Lab6Hr?=
 =?us-ascii?Q?ZiwJaEO2WoEa3ggGfqv9tfwUdB7MO31xjNrw+bMsOqyTRY5P0cM9lvMs6yAo?=
 =?us-ascii?Q?jc2Q3eaJHYP6Cx7EdzXpZujiCoDQDKuNmQAoNq1B7IhSfbOQTJSnocV5XY+g?=
 =?us-ascii?Q?spNEWDRUspu5/kmfs+dcId92JhcMace4rGZj+nK5RSE237Mmjply710PI2Tf?=
 =?us-ascii?Q?6pDGEAiecukL3wzOOYXdfnlKBTawBnDQjfwyXcHr7vNHq6UXPYIKp9tR6UVn?=
 =?us-ascii?Q?SkkweqDT4Um5D36MBJX5SkS5elvhWOQud0NqDS7hBODOo3L5XsW7R71/2Zjq?=
 =?us-ascii?Q?+CG26OdCk4UH9PsmQhlTyxmPer5u3sMADC32Tr8+l5HXZJRXiuzSNlqWf8+c?=
 =?us-ascii?Q?JtIGDfXGIFhABrbyY9sFjmmso7/H/xMnyql+IbGP/kruNUdjDPk+ZRQOeQ+A?=
 =?us-ascii?Q?kvaCHufYGrXfkDQ33J98fFulL+Zk8admvqkwnyBbI1FqODqhU/Vg4FpfoP/K?=
 =?us-ascii?Q?oGbc+R7MCXixscr7cTQbGP3nAlFOU97XgwFrRToNUf6hMitEZiv9iDRsO9ZF?=
 =?us-ascii?Q?yBEY9+yJrzJJmaUmgeZ0EunGzeNzYEQ9qrlc2NnW?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3536.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57f0308-e048-4abb-aac5-08dcc2511677
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 02:21:10.4252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpwC9Fz4xm7hlQXGvQxuzimwcpXRhNfbmYH7nCyspjArX1ltu2jyp1PoJrDc/pV98wmnH74cNSBAxYvGaGVPdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3266

> Subject: [PATCH net] net: mana: Fix race of mana_hwc_post_rx_wqe and new
> hwc response
>=20
> The mana_hwc_rx_event_handler() / mana_hwc_handle_resp() calls
> complete(&ctx->comp_event) before posting the wqe back. It's possible tha=
t
> other callers, like mana_create_txq(), start the next round of
> mana_hwc_send_request() before the posting of wqe.
> And if the HW is fast enough to respond, it can hit no_wqe error on the H=
W
> channel, then the response message is lost. The mana driver may fail to c=
reate
> queues and open, because of waiting for the HW response and timed out.
> Sample dmesg:
> [  528.610840] mana 39d4:00:02.0: HWC: Request timed out!
> [  528.614452] mana 39d4:00:02.0: Failed to send mana message: -110, 0x0
> [  528.618326] mana 39d4:00:02.0 enP14804s2: Failed to create WQ object: =
-110
>=20
> To fix it, move posting of rx wqe before complete(&ctx->comp_event).
>=20
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network
> Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 62 ++++++++++---------
>  1 file changed, 34 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index cafded2f9382..a00f915c5188 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -52,9 +52,33 @@ static int mana_hwc_verify_resp_msg(const struct
> hwc_caller_ctx *caller_ctx,
>  	return 0;
>  }
>=20
> +static int mana_hwc_post_rx_wqe(const struct hwc_wq *hwc_rxq,
> +				struct hwc_work_request *req)
> +{
> +	struct device *dev =3D hwc_rxq->hwc->dev;
> +	struct gdma_sge *sge;
> +	int err;
> +
> +	sge =3D &req->sge;
> +	sge->address =3D (u64)req->buf_sge_addr;
> +	sge->mem_key =3D hwc_rxq->msg_buf->gpa_mkey;
> +	sge->size =3D req->buf_len;
> +
> +	memset(&req->wqe_req, 0, sizeof(struct gdma_wqe_request));
> +	req->wqe_req.sgl =3D sge;
> +	req->wqe_req.num_sge =3D 1;
> +	req->wqe_req.client_data_unit =3D 0;
> +
> +	err =3D mana_gd_post_and_ring(hwc_rxq->gdma_wq, &req->wqe_req,
> NULL);
> +	if (err)
> +		dev_err(dev, "Failed to post WQE on HWC RQ: %d\n", err);
> +	return err;
> +}
> +
>  static void mana_hwc_handle_resp(struct hw_channel_context *hwc, u32
> resp_len,
> -				 const struct gdma_resp_hdr *resp_msg)
> +				 struct hwc_work_request *rx_req)
>  {
> +	const struct gdma_resp_hdr *resp_msg =3D rx_req->buf_va;
>  	struct hwc_caller_ctx *ctx;
>  	int err;
>=20
> @@ -62,6 +86,7 @@ static void mana_hwc_handle_resp(struct
> hw_channel_context *hwc, u32 resp_len,
>  		      hwc->inflight_msg_res.map)) {
>  		dev_err(hwc->dev, "hwc_rx: invalid msg_id =3D %u\n",
>  			resp_msg->response.hwc_msg_id);
> +		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
>  		return;
>  	}
>=20
> @@ -75,30 +100,13 @@ static void mana_hwc_handle_resp(struct
> hw_channel_context *hwc, u32 resp_len,
>  	memcpy(ctx->output_buf, resp_msg, resp_len);
>  out:
>  	ctx->error =3D err;
> -	complete(&ctx->comp_event);
> -}
> -
> -static int mana_hwc_post_rx_wqe(const struct hwc_wq *hwc_rxq,
> -				struct hwc_work_request *req)
> -{
> -	struct device *dev =3D hwc_rxq->hwc->dev;
> -	struct gdma_sge *sge;
> -	int err;
> -
> -	sge =3D &req->sge;
> -	sge->address =3D (u64)req->buf_sge_addr;
> -	sge->mem_key =3D hwc_rxq->msg_buf->gpa_mkey;
> -	sge->size =3D req->buf_len;
>=20
> -	memset(&req->wqe_req, 0, sizeof(struct gdma_wqe_request));
> -	req->wqe_req.sgl =3D sge;
> -	req->wqe_req.num_sge =3D 1;
> -	req->wqe_req.client_data_unit =3D 0;
> +	/* Must post rx wqe before complete(), otherwise the next rx may
> +	 * hit no_wqe error.
> +	 */
> +	mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
>=20
> -	err =3D mana_gd_post_and_ring(hwc_rxq->gdma_wq, &req->wqe_req,
> NULL);
> -	if (err)
> -		dev_err(dev, "Failed to post WQE on HWC RQ: %d\n", err);
> -	return err;
> +	complete(&ctx->comp_event);
>  }
>=20
>  static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_=
self,
> @@ -235,14 +243,12 @@ static void mana_hwc_rx_event_handler(void *ctx,
> u32 gdma_rxq_id,
>  		return;
>  	}
>=20
> -	mana_hwc_handle_resp(hwc, rx_oob->tx_oob_data_size, resp);
> +	mana_hwc_handle_resp(hwc, rx_oob->tx_oob_data_size, rx_req);
>=20
> -	/* Do no longer use 'resp', because the buffer is posted to the HW
> -	 * in the below mana_hwc_post_rx_wqe().
> +	/* Can no longer use 'resp', because the buffer is posted to the HW
> +	 * in mana_hwc_handle_resp() above.
>  	 */
>  	resp =3D NULL;
> -
> -	mana_hwc_post_rx_wqe(hwc_rxq, rx_req);
>  }
>=20
>  static void mana_hwc_tx_event_handler(void *ctx, u32 gdma_txq_id,
> --
> 2.34.1


