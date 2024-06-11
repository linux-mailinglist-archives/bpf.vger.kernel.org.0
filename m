Return-Path: <bpf+bounces-31865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CED90431D
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757B9B2430B
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F24D7B3FE;
	Tue, 11 Jun 2024 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LjmhXNjG"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2096.outbound.protection.outlook.com [40.107.237.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9665482D7;
	Tue, 11 Jun 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129022; cv=fail; b=kQ3rtXw8pvSqi9aYaiwF7vkG5qrwveibtHZ9/M/Q8LTjd0OvmybSbMHAJwLcx4wkw/eWCD2ZrpbpSOc/RP3vzMvEn3e6U0jErBJK6GSrIVVwBcWDKGgDoRFyuWeore5Uf/P5Z2OI9tLD1qgpOKoT12v06Ji80+vmKtuN4rXLlik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129022; c=relaxed/simple;
	bh=pqF3GnSXz5Rq4BawoM5pKCR925JXjJ9Pk0sTNpmy2Do=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fdSozWQ9DsVX61wm3h4ndFYJsxvsQChe5Vop25A6Kp7BqILJIbBVw1JFUpN4HkFmuy4pDdsQhODvoUDecQGvETe01TwZKmnQnDjdg//fGMJpVZJ/U4JkxrZGaIrfY2GxwVqp0jumfySjlfg//VHWaHLF3ZLG0w0W9x2TIZo87Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LjmhXNjG; arc=fail smtp.client-ip=40.107.237.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDJgKdFXvsbGR+EbjlT2I36mChzBFQTkOi6jzjFdpMJmfwHNj2it9ixiDDGBOkOyBa8C+V68HedQMbV6QDT6zriwhlZ9VjRdb9o73Cxh7kGenPopM5oBxJtBThi5EBdv8FNyyYsC+jaVepll5dScHUb6XEyLAwi7hmmHe7lm/3IvEla2UL/4+9FMLakSAMBS0vj5uIVQvxQQN1zLcbGRMUj06MnFML9IfcCDhKRj4UAY7eh/df/Ij/RCqpMVAbdcLrSLX0nEuv2wlNl+lG+ct09kS+rHB5H/wUkV6olQ+spvlXJ2g5QDKRlDBhsFVNhXodb2TG8cbbb7B9OeYfTvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqF3GnSXz5Rq4BawoM5pKCR925JXjJ9Pk0sTNpmy2Do=;
 b=ANIi6l/qDKGTvmyBr+NrJDrSbOZu+AoL1XhJ+fvCuOkOUBVcUdl2TwqKUTJZmDYSND9kns8cLmCTA9su8mDYRwyQh7mESfyODqOTEj/UDJ+Crj3F3iz4LtbMjWA3UT8RQ1jXu2yXFZJSKKm5im/W3NGKVtqN09pMg+NTlHr00/VrhjW8k3J4dE7ja4WpFF7Jnzwsln6LUn3UkBwFOaCE70Y+kW2SMeQye/o7cY9wdijYl5VDUc2Jw3bzg9En43ou9ePwmg5nuVgBVxdBZud2FDUNDEDzXvPJNt0UYw35XLGVy6Pb3EzMJqCEHxkjT6ezc9X5o8HZcUVyJuOc8rjapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqF3GnSXz5Rq4BawoM5pKCR925JXjJ9Pk0sTNpmy2Do=;
 b=LjmhXNjGkPyVX2skRgSR9jk1EEhj8oSZXuVlOd6nkE6T5yGzR8HkCvJ7BdMO4HPYyGo9lHS+TCVeyhwer6lL6spUcmnc1q1yxuPt/SJ1H/D0bFlDA6af7udzVkfvk9nZXuRJ7ZDZSvwUQx26mWorT4KiIC3Yc0oJKgkWTZPmjPc=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 PH0PR21MB4456.namprd21.prod.outlook.com (2603:10b6:510:337::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Tue, 11 Jun
 2024 18:03:32 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7%5]) with mapi id 15.20.7677.014; Tue, 11 Jun 2024
 18:03:31 +0000
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
Thread-Index: AQHau3yCjVULPkZ+NkeRwzD4A2YQ07HCw4UAgAAC/7CAAA858IAABaXw
Date: Tue, 11 Jun 2024 18:03:31 +0000
Message-ID:
 <DM6PR21MB1481935D432F5ABFF73325CACAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1718054553-6588-1-git-send-email-haiyangz@microsoft.com>
 <SN6PR02MB41572E928DCF6B7FDF89899DD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DM6PR21MB14818F4519381967A9FEE8B8CAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
 <DM6PR21MB1481E3F4E4E26765CCF6114DCAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
In-Reply-To:
 <DM6PR21MB1481E3F4E4E26765CCF6114DCAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fb4882b-67e9-4568-8c78-027b60b1813e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-11T16:45:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|PH0PR21MB4456:EE_
x-ms-office365-filtering-correlation-id: 0a225b79-94ae-4618-2906-08dc8a40cdf8
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|366008|376006|7416006|1800799016|38070700010;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Tcwu3SXVdCXabp7oiVnOesM7NjoQdrc4+Aq02SK7+ppL4+BYDuCh4yYc3+?=
 =?iso-8859-1?Q?DLj4SR5JZESiF8Xu13V6WmEpT3k+dIUJ5Ta3xeZh1x0sxFA+JnrXMVnVal?=
 =?iso-8859-1?Q?6zg+DOvLbyCdGuG8zlDWHtc2pbstN42aUS/5ia+AYEx3AYs1/Fmf1qw1Pw?=
 =?iso-8859-1?Q?oWjm3ZiXFZFbkvp51DtBwGrgEqg4yiQcylt07TLmiTuoJLSzwI2/D9YO+4?=
 =?iso-8859-1?Q?k8ipcaKwh8PFDRBUJFpre1ihck+0ujfuZygw1A1x5xYWT3vDakX2ZDoSKh?=
 =?iso-8859-1?Q?zG2Qe5ZeCQIytF5y9EZtxGtm6Lfo2+v9KZmVca2D5zQog5KckIp842iyaT?=
 =?iso-8859-1?Q?LF5w6y/T1M4fubhgp9GJvi0ihgIBOpM1o2rcowS7k37BOpdLzaCuHKrNcd?=
 =?iso-8859-1?Q?Ockfj9zXXBnjw+4Uz+2LM+cS0dkvrcjTNvM8EuEX8J3K1QVtydgWySlX7t?=
 =?iso-8859-1?Q?f+3w38bgKfRui5tgsWyvzccHfTfBYhS9G3r2mNW+CkQAmtpLSLqGPpUn0z?=
 =?iso-8859-1?Q?zRPulFeHzuVi6HG91cvIlJpWkVH2drOsDXYvN8L8wN5Sq3JuAxw4g5TWFk?=
 =?iso-8859-1?Q?nbD2WlJzBPBptIQO2dmPNnw5Fo/a9k5QdNxZggLi3D834qSF+TSo1t5Cm1?=
 =?iso-8859-1?Q?qHu1uz9DHQb/KxS7kZO90FRPCb5c82cIaboEMVlOaqpXmx8iWkqGCYGNqt?=
 =?iso-8859-1?Q?A+80eW4vLXdO8Mp6px+RagpKFwjKTKzFwctORUd+DjFI4BIqrP2N8JXIt9?=
 =?iso-8859-1?Q?+r7pcS5sN7sxyJr6nDzYwwUCeMTkTBcOWCWTypvRhKaxY3kOX44lQ0w4eN?=
 =?iso-8859-1?Q?dMHB2E9C7XIAJj8VbZ8lin8V+gbvjeeukoc6SptoHsrm3tt5yrrc431Uty?=
 =?iso-8859-1?Q?EN4JtuX0dLnCmghqHznfTk9oscBDSWYG3rT23KTSO5jP2nQY3SRCwb9WoD?=
 =?iso-8859-1?Q?P09jvHoJlSWekBfYHFd6LbOPTwIIxazcbowKwqaQX4It4uM26LYk5E/p4N?=
 =?iso-8859-1?Q?+DdqCYp6xU9bBFdJdgkRzRReI17E9ivBtLwdE8DOc9uI78QJEOw13QZ1i/?=
 =?iso-8859-1?Q?qtM6dDcAI1Sg7yi1J3xYZDbUvrPIhaJta+8Y2QgL+vQws1fcN8wVPZKMVG?=
 =?iso-8859-1?Q?lW+vdtNdf/vO2F0YZFst9GAlG+4epvMoUKpOEpDJcWJ5FPQgzAMz8RVXIu?=
 =?iso-8859-1?Q?KJOExC3/dyKv24pdM/BsAvmuuQsymT10fjiX9g5CGXP1MYLfcvSiopSfb9?=
 =?iso-8859-1?Q?0oLPbll7aglCS9cN5kD0D9LPkJnFo6p5qlm3Y/SlQIZgZWU3BvzJIHzl9b?=
 =?iso-8859-1?Q?cWbkEXIhIdUQ8U1RKSeftiFZJsQo8nPj2ADxfCrjVBoWCNNKgA9B5L560q?=
 =?iso-8859-1?Q?qWjBZbQkRxAmvl0e0jZ+2/tfZbwRhR+629J3Rl89i4GOe+j2PIESA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(366008)(376006)(7416006)(1800799016)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?djE1CMAwi/whWfhMLU19wg6WECBs7fSs2t6d41+8X9+jZKrG6EDCl7wY6+?=
 =?iso-8859-1?Q?JX+qvDYNtr01ygLPyH/2UG17W975lyzBH6gA7SX69GnDoCo3cZumG3CMXf?=
 =?iso-8859-1?Q?MXZ4QNvKyd+QN5F9QwtUfKboMz/8+sG9roGunMuuAtmkiY6ItarM1VT9xc?=
 =?iso-8859-1?Q?Li9Aykd9ZQB09ArLnQxp/WNSrPp2kPs2EnlnC5BgJ86PgF3soJjYRz6FVN?=
 =?iso-8859-1?Q?2VtweawhaCx5ANgXQH8A/KmIqn9voxIAyh4hZLvvXKES0IL3/PgXRDoOoa?=
 =?iso-8859-1?Q?5PMyPaIVDOa/EiMZP8XIq5mUN8DhlLTvelu2Ki5AyFukWSV2QY7iY33a2C?=
 =?iso-8859-1?Q?pA8hwD+1DQalmFJLDU8lVJTjTfI+A0DDTAfU6x5Sg5jJWoR4DZhMEPvA9b?=
 =?iso-8859-1?Q?hjoAb5CpzvN+oQg3Q9F0PeLmUuIQBDkm5wylkiITcr4zIBbpbT8ysGR+NI?=
 =?iso-8859-1?Q?EthI7ed2Ry/clx8voMiZfd1w502kdAIdYLkVf5VXCQMbiisGOzsSRxKFVn?=
 =?iso-8859-1?Q?IhsMomnx+cSvYePw08UIesXx71tuolZfiFc7GKIX77hwHizZv6zpUi5w3b?=
 =?iso-8859-1?Q?7Z6lEK6CmqoGSkbdko3M2j6vmpz08lQF9IJA01nEeldiiCGacLMaF/Js1V?=
 =?iso-8859-1?Q?C36E4rtu4SeaDFh6KyLALZngpzWriwykPFiLXjrhSIqweZ960p/JZQ0cGl?=
 =?iso-8859-1?Q?A4NVm1zSUswREDRsXu0fOkdnsAx6Mgxu6KFhN1tc4WX3zqO3/yBgjbrcjw?=
 =?iso-8859-1?Q?dECBKetRHaol0aBcPakrGr+sGDN4DOj0lVpie3W3ivNrEhPyPd98Toad+/?=
 =?iso-8859-1?Q?YQ3URPlu2LqQW1X/Fb9hQxpnIPvFjsWbB7uY7JOm1ay1uwIAakQ40SFNR4?=
 =?iso-8859-1?Q?2wB9F4Fmq40uNEkBiTgTbFLUCDm6qdFceDVY/ys1vKPCCVUbBaNgM+DdX1?=
 =?iso-8859-1?Q?YpLPWnc1ollNT+klORxZW/6bClVULLrFkk/lZ8TkgZBU/6XV1AEims4cCx?=
 =?iso-8859-1?Q?r52L62ZvgUi1mliGtTjewUS62TZNI49LnQ7PN5xgo1UpTZ9VAf4biMywf2?=
 =?iso-8859-1?Q?7TpeJtI0x9JM+za1ofQDHS5Lx3zh6j1kKwn49GIjs81HhDwNW4V9YMSG3F?=
 =?iso-8859-1?Q?6isTvbRUHfl1qstpX+dCMfspaQQ8j/Fjbw4RRhMPel7InwMrGK9rY4rQFu?=
 =?iso-8859-1?Q?20zaljubCznaO295zboRiZe5izG1MbXMGQq6m9mSKrElPrGgt78FdM3wPr?=
 =?iso-8859-1?Q?yOyoBseTYUeHwXt3OD3ssU5EliFDlTQt3Zdjx7l1y2mgalWwIiPngc4aD8?=
 =?iso-8859-1?Q?02SGiTsSJWSbytXR6SaVG+c76ttZ9bOGjTbJHGoypsc1NTa1Ouk2noUn2k?=
 =?iso-8859-1?Q?cgHpRG1oQpVOWWfbQJSjeHJunPw9KGWqsyZkdQx/0lVYCDfBYs8eF5yeYR?=
 =?iso-8859-1?Q?5ptnZnghKgvUdd3zuc8dIa2HYCthx1K6zxkoy/qe/E0PYaRZpJsfzuPWrU?=
 =?iso-8859-1?Q?4l+vKHr//WD/PMO5N6nfBANgxuUW3E6pR5/lrTRMxjVueRn7KBww+ly+fI?=
 =?iso-8859-1?Q?qPtwhj5Osu2buvMqqqnF+1g6UHz3MCZa9S29S8tYrXBGn7pvvCL0VHyhPt?=
 =?iso-8859-1?Q?yVIDEtF5hP0oAQ8RFZ8O/QCJj+vI8cntJB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a225b79-94ae-4618-2906-08dc8a40cdf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 18:03:31.7414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+l1W9t3R67w7qJ/WR/2gignNuKO+ZYK7vnKmJJPgD/WznAYNJwjjnomGNKLC43QkiDt1Edmjs5x4Khd5u4GEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB4456



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Tuesday, June 11, 2024 1:44 PM
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


> > > @@ -183,7 +184,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc,
> bool
> > > reset_vf, u64 eq_addr,
> > >
> > >=A0 /* EQ addr: low 48 bits of frame address */
> > >=A0 shmem =3D (u64 *)ptr;
> > > - frame_addr =3D PHYS_PFN(eq_addr);
> > > + frame_addr =3D MANA_PFN(eq_addr);
> > >=A0 *shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
> > >=A0 all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
> > >=A0 =A0=A0=A0=A0=A0=A0 (frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> >
> > In mana_smc_setup_hwc() a few lines above this change, code using
> > PAGE_ALIGNED() is unchanged.=A0 Is it correct that the eq/cq/rq/sq
> > addresses
> > must be aligned to 64K if PAGE_SIZE is 64K?
>=20
> Since we still using PHYS_PFN on them, if not aligned to PAGE_SIZE,
> the lower bits may be lost. (You said the same below.)
>=20
> >
> > Related, I wonder about how MANA_PFN() is defined. If PAGE_SIZE is 64K,
> > MANA_PFN() will first right-shift 16, then left shift 4. The net is
> > right-shift 12,
> > corresponding to the 4K chunks that MANA expects. But that approach
> > guarantees
> > that the rightmost 4 bits of the MANA PFN will always be zero. That's
> > consistent
> > with requiring the addresses to be PAGE_ALIGNED() to 64K, but I'm
> unclear
> > whether
> > that is really the requirement. You might compare with the definition
> of
> > HVPFN_DOWN(), which has a similar goal for Linux guests communicating
> > with
> > Hyper-V.
>=20
> @Paul Rosswurm You said MANA HW has "no page concept". So the
> "frame_addr"
> In the mana_smc_setup_hwc() is NOT related to physical page number,
> correct?
> Can we just use phys_adr >> 12 like below?
>=20
> #define MANA_MIN_QSHIFT 12
> #define MANA_PFN(a) ((a) >> MANA_MIN_QSHIFT)
>=20
> =A0=A0=A0=A0=A0 /* EQ addr: low 48 bits of frame address */
> =A0=A0=A0=A0 shmem =3D (u64 *)ptr;
> -=A0=A0=A0=A0 frame_addr =3D PHYS_PFN(eq_addr);
> +=A0=A0=A0=A0 frame_addr =3D MANA_PFN(eq_addr);
>=20

I just confirmed with Paul, we can use phys_adr >> 12.
And I will change the alignment requirements to be 4k.

Thanks,
- Haiyang


