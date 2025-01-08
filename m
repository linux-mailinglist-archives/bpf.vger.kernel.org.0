Return-Path: <bpf+bounces-48296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF170A065E1
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF481889D30
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3309202C3D;
	Wed,  8 Jan 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gdP2J5/O"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111142010E5;
	Wed,  8 Jan 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367370; cv=fail; b=XU147R2pT3cJWrWNUu8kyBHDDhEMpwMSx5Yng3iZ2+DZfYk+FlBFUxrW93fPuMRH7mi7A4GFWvY8hwTuOaNOhN0VFPn3+oCN0G1qGEdIufmiv6zdKSxe5LEQiGNq0/Vm7Kb9gvjCOqXa86GQN29xOcvEQjQEU7vs0TX7ALI4LcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367370; c=relaxed/simple;
	bh=H1hG0rtDt4H/HDxFyb1fTzpS6JFNFGQi6qUicv9aLAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DU6XSNiZNScsxXewKSqO0CGwHSFE81ePxf4B2wyVVzmxR+oQMl6QctgsWMtX42rOPmccNLOQ00Z+cmvWacragBsjxZbTPT1quYwdlJrd8j5pJNFhyhhwEW/Lq10nm2bH/+X25jfR95Q2of3WeeMMZTXxy92f2ucky+Ig2PJpMYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gdP2J5/O; arc=fail smtp.client-ip=40.107.105.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmqXTlfkSslaY7u618BsG9PsJagPrDuTp4owuoGP65u0ldoXBK4W3C97YaYqM5KbwZiaBV6Nf7+zkvV7nwNhfDgLxXRxty9Aj4VR9dVWWr+OJIaFSR0+6HGSLDdM+iCIaIxVAyCXL4C2wnX8a3z1HPE/3gwOLZ+y1cmD/6YBjmBCuvTuLGn0t+QBLj2SaiIANfMLllEFtduwvYZAJ6n6igwoTlQYrAXuDI5wPBls77U+XcJN0YicQxFHxwOtTr7YNm79zCNsEUUYMjVPPLkkes/wTF40EESbOK8+nUVH4KOzFc5A8P+v3tB4msMZV8kqLPoGNiiqs9ddeNobbCNuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPTXueMBJgsSkvnNHetI6HqmgEqC5M3DUcL/ufM09KI=;
 b=Jb4SrbZ/Hp0Nfg7EFHJwwSVC/upzzWPYz1b3GnTdRv+59pVB0L02CpY19cSgm9WU8F42bSCm320TXOnFW3xT05o2Hk5Y8HuldO6GGn0Q3ljqjBsap4g2cVLx2kiABubnHA4vbPmTPQy7e45N40n0HNLbb9QdGhKBKecH1zEilMd9TtUalWOpNQ4f9ko9iTL7rcTV9eWsSjh3bI7TeAJu6FxiWFC+hfiFFaqMp95trZrzQAAsDXGcxUkOG33+cvBRWVRIc+bEKIcoEd3Cns8/BPlaUVKMwuu+dDXwFjaIPrGdi6/sa79OLDUMp/7OEbeodb4RtfL+UpDyk2Z3f+HZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPTXueMBJgsSkvnNHetI6HqmgEqC5M3DUcL/ufM09KI=;
 b=gdP2J5/OHT053lEejo4V+USRG4xYSi6GfFGYttsCdT+UTP9pZ/7Bncl3rSshneyUa170mfHl8hxbTQb20mvEk9yP4BNBz+qKXxClukVP00cLz391d/5xvtVMcria5P0NrNHz3xKB6tEWjzR4CMW2AJZBSj2h5fF3DQmSO9LNvBw=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB9290.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 20:16:04 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 20:16:03 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: James Clark <james.clark@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "irogers@google.com"
	<irogers@google.com>, "will@kernel.org" <will@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"acme@kernel.org" <acme@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>, Leo
 Yan <leo.yan@linux.dev>, Graham Woodward <Graham.Woodward@arm.com>, Michael
 Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, Athira
 Rajeev <atrajeev@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] perf: arm_spe: Add format option for discard mode
Thread-Topic: [PATCH v3 1/5] perf: arm_spe: Add format option for discard mode
Thread-Index: AQHbYdnYN7Y6izbgSEGawqTCEKZe9rMNUIMM
Date: Wed, 8 Jan 2025 20:16:03 +0000
Message-ID:
 <GV1PR08MB1052186F99D5BFCF9169DD90FFB122@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20250108142904.401139-1-james.clark@linaro.org>
 <20250108142904.401139-2-james.clark@linaro.org>
In-Reply-To: <20250108142904.401139-2-james.clark@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR08MB10521:EE_|AS8PR08MB9290:EE_
x-ms-office365-filtering-correlation-id: 771d2886-2150-4410-cd85-08dd302146a8
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VTA6EyG1TKFuVnTiHy5Iu2sOF32NpXEEaqPxduSNzc2URDNX2N862t/by6Z6?=
 =?us-ascii?Q?akMtyI7JwAIhLX+ATewARFQbUC6xdIVyAw1qro4Et1cVESzKVL7vkTf/7yHg?=
 =?us-ascii?Q?mmVwSlKc2jeSmVAET3DzIJPQPVbFm1c/is0hUW9XwdCY8JM3CgEchdnceAFU?=
 =?us-ascii?Q?DElXIEvr5TMixqxGxNJc0CkDm0zVsTbAxeZS9floSfGNTl1OHV0TfaGmF4Jw?=
 =?us-ascii?Q?vXqCqqJchX0oNrPXCmhONBnAH8WgGP5xQvLaP0UD+pqWsHyU5JHaCi4/YkkA?=
 =?us-ascii?Q?EC5bPqHQ4tzsdIK/BzOsjKnoAifBdgFzoCs9YjJj9I1N6XEJOU5lJ40MtT2Q?=
 =?us-ascii?Q?55Z+/CzR1tYx2dr3dx8smOcHbZc3guwzcnxmej7lxwWuM/fkvktXce88bNlN?=
 =?us-ascii?Q?usWQ5c3Ggp+yTy+eoOemFCxUkaA0uE8Hd2pqP0uAAPCDj/+6BPgVnHtVNfTG?=
 =?us-ascii?Q?4aN2w7cjt5ftJo0DOIWQTZ0yWzMK1HtZB9AQ1keroh+pTx0QgO1XYYbLvH30?=
 =?us-ascii?Q?t8TVf/JRrhWu6AcfhMc+RfV0cIudGdiNHNypL1qnOA41nBYtPpq0RyTUPfUZ?=
 =?us-ascii?Q?y52jd43Jd2fY58A6z2WG+aUWYPAdl1tBU3gdM32DdGMEfPyZPMUhD41NURbm?=
 =?us-ascii?Q?Ja1NgRvUgJBES/uBnFT6vYorPNKM9ATPYoZVzgcKbKt0UYo5DOrVxunDZobQ?=
 =?us-ascii?Q?Rf4dqIS2yYWYn7fXopG44hAAs3GmFMIDjxv2loR7cQI18NKi3HGE6wMJ7kBE?=
 =?us-ascii?Q?VrjtIizvSED6To4CY9HMB5aoU3FQB7DsrdID3OBRxsrsk2pVRX/9Z8WbJYaS?=
 =?us-ascii?Q?1ZQC6Mg6gUt7QL7IM8NrutKpf8Alm1kV3WRLwvcotjx9y6BpurRui9rSkh1f?=
 =?us-ascii?Q?YT/a5UJQqH6/1MvqRGpsBiNc2/+Diu6hT4fwPhv5ghNaPN0euO7a+V4Ry5vq?=
 =?us-ascii?Q?yqMYr3JcLaw3el1IXdPZyH+KgUARgHP94n0dfQlKdxBpdmRogoYpwIngGe85?=
 =?us-ascii?Q?6OG9rI53GUT8Kn9RM/CRp6UpudiDzOc4c8UiXotx/NhPIADuX9VdFwIjLDcV?=
 =?us-ascii?Q?AGYjUA9nV9cDN+se4XUaYEWjjSna2RKIw9QBvteNGDRlVkwCqzeE1g34k6y/?=
 =?us-ascii?Q?0Ml+9ZKa/bPdpe5WhHQDpczH8PodTgS6vVS2JhmpU+kNFbipWt1mVR+cF4DW?=
 =?us-ascii?Q?xINsL2n8IFaD8g9iGnIfn2oAUvBKV8h+7l5lZkF+A0A2NP2LqavWz0rdQ65C?=
 =?us-ascii?Q?FIR69MuPINzlBUqQ18JHq+3UA6dZf2UtfJ2X7Xr31e8bWm/UtvP3lY+ElUQc?=
 =?us-ascii?Q?bSzPkJ41k1mn+YDUB7pEiilO6NP9cFMo3JDrswQXZHBpg9iby46x6f6viFDj?=
 =?us-ascii?Q?tpnaoVn3nN1Tsd6IwWwOM8E34MIkenGBJHQ/OpPL7oJtwMngIi4g2FeZhGwM?=
 =?us-ascii?Q?bYYlHvpO0HZHfgWublbol5kHrpmMA11L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LP8Lwx/o8XeyKK+RIGyaQyCqBasaQ1YDds4QI5sgoBmY4yN/EaHAa5/uAxGP?=
 =?us-ascii?Q?CiRImwYwveZPq8+HF4LvWONxc4+RepwsDoQIywqlQk0De8SjQY+qB9/aXs8W?=
 =?us-ascii?Q?Ws+NmzDP5TuDsFobll7+V+bS4lyWBR275lZ+5f9mJ2QG2zjlScxcqCNNvXbw?=
 =?us-ascii?Q?Yj0drsObTsw+3Lam/p94FWaljgj1k72hWM1Qt/G5ohojEcsD0T6s7HccOVeE?=
 =?us-ascii?Q?k1qViMpTt9sP1x4eVfuXw9P8XaFsQxOQJl5XK9eV3KEQx760J7rjDxhYA5H8?=
 =?us-ascii?Q?lY3KTTQ36B8k38Opjxq65h4SQtaG8layvuSKN80aIJsClsrOEy4ZclstgSaN?=
 =?us-ascii?Q?/Iw7M3uQ63S8YhpxbLlb7wH0ubTsKFcVf0io9fFhpm4ibvsWEETzrNt7FBwT?=
 =?us-ascii?Q?M4tXZ66egzh6g5A73TfsgEvp36IawTqEzAOgdBMDYnX3PcV+AC1VMXeHMRHs?=
 =?us-ascii?Q?QdRZ4OEN7x7aDYNf5DPLH0Z938Tkn5+pga3YvziwmrzHqZncRKfsucwgdxzQ?=
 =?us-ascii?Q?mhBULc5LTFPcV4T+xl0LAV3goebzUbwzfs7C6zHzeH6EcJSz6wyXirlKTD/S?=
 =?us-ascii?Q?gvcfm9DFU6+rYTsbKb9woHz4yJgQ+BBpPKTLf8/6xehBjOnJpIaNi6enu74D?=
 =?us-ascii?Q?nHrjOHeoyj7mPTntSQ1NforEGwA3RmMdeeussqZFlxOIc4ECE5XQ4FrJPug1?=
 =?us-ascii?Q?Pjbj3ZGy5SCFlu1h5SgyOlgS0tNLwKT+Ajoy55Yzw5fYGzBph8wlrV3nVajK?=
 =?us-ascii?Q?siJ86EdVC6WeMvJxQ1EywF+x3zgbBbrsl/LIb+e7mgZyX+hqN4BtDrwcl2V5?=
 =?us-ascii?Q?v5OTiJpGmp7JXN/9OBC2nAs2vtz0UveFQMMmCAbgQzukIFF4iEAnQiTc4clc?=
 =?us-ascii?Q?ezC0+s6GMFCEi/tHnZw7PyTVkO1dOC4VSHdaxQO7ZvR1krM7e1vppFwEWsmd?=
 =?us-ascii?Q?AzJPMJa5klC2MpugfGrVjrqLTQ1+Pj9Gawhmp5l6pFT2la47VTMeEp8y0VVy?=
 =?us-ascii?Q?Ir+30UqXo2jdVl1nsjjhx+YiAdCHLR0GJhS6w+PiBqCWptbfaV7hK4vEZrsJ?=
 =?us-ascii?Q?jNCYV8g+HJOGzFPcCqqTrYUMQxeHZcAQleVhMQq/YfeItV+zo63eTJG9DxIc?=
 =?us-ascii?Q?FMwik8bp+mBmLhCkvNrCjfeK+f+cNLF8mGbHJlvFPOTPb3p+fp46NjwR8Upa?=
 =?us-ascii?Q?sDjzbWS4FM6xthqofM9lfARFOSdNaay7toX0f5XEWf4XCFT899uD7gKBU7dS?=
 =?us-ascii?Q?4USs7MHkQyJuU2lwgrezl9HXp7VDGfOBXr9hUeXuEvEmKuvn9IHv7sBf20/l?=
 =?us-ascii?Q?06sfEgRTTMKNqgSoWX1y7LMKjsZcC2u4QJ5KczF1AkHiXDoFIGajeWtTr4IG?=
 =?us-ascii?Q?nDv44xe/j+6vxqTY1WQJTa/vWim8MvoVhU+SKPNslq0dy8ziGQ12aqlWrtk0?=
 =?us-ascii?Q?pU5597syFqIaFKU8ZqUUT20ozB0ofL/a2B9+8DCHS7a3chxRDqPzH3rTtEQa?=
 =?us-ascii?Q?rAMxHg3B1FsGFW0aADr7uXOwfdTXyS1TG2v55/mZ9IG2ansjkcRSTioWHlsG?=
 =?us-ascii?Q?St9auZiGMcUoopyP3GM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771d2886-2150-4410-cd85-08dd302146a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 20:16:03.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hd83cPK2XniEtYucZIOXF0T6MAicEOasHU3Rf9iWpGvXis48VnhYciEK1r9fTwq37MEzknj4CaJFKTCDPoRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9290

Reviewd-by: Yeoreum Yun <yeoreum.yun@arm.com>

________________________________________
From: James Clark <james.clark@linaro.org>
Sent: 08 January 2025 14:28
To: linux-arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org;=
 irogers@google.com; Yeo Reum Yun; will@kernel.org; Mark Rutland; namhyung@=
kernel.org; acme@kernel.org
Cc: robh@kernel.org; James Clark; Peter Zijlstra; Ingo Molnar; Alexander Sh=
ishkin; Jiri Olsa; Adrian Hunter; Liang, Kan; John Garry; Mike Leach; Leo Y=
an; Graham Woodward; Michael Petlan; Veronika Molnarova; Athira Rajeev; Tho=
mas Richter; linux-kernel@vger.kernel.org; bpf@vger.kernel.org
Subject: [PATCH v3 1/5] perf: arm_spe: Add format option for discard mode

FEAT_SPEv1p2 (optional from Armv8.6) adds a discard mode that allows all
SPE data to be discarded rather than written to memory. Add a format
bit for this mode.

If the mode isn't supported, the format bit isn't published and attempts
to use it will result in -EOPNOTSUPP. Allocating an aux buffer is still
allowed even though it won't be written to so that old tools continue to
work, but updated tools can choose to skip this step.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fd5b78732603..f5e6878db9d6 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -85,6 +85,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_LDS                       (1UL << 4)
 #define SPE_PMU_FEAT_ERND                      (1UL << 5)
 #define SPE_PMU_FEAT_INV_FILT_EVT              (1UL << 6)
+#define SPE_PMU_FEAT_DISCARD                   (1UL << 7)
 #define SPE_PMU_FEAT_DEV_PROBED                        (1UL << 63)
        u64                                     features;

@@ -193,6 +194,9 @@ static const struct attribute_group arm_spe_pmu_cap_gro=
up =3D {
 #define ATTR_CFG_FLD_store_filter_CFG          config  /* PMSFCR_EL1.ST */
 #define ATTR_CFG_FLD_store_filter_LO           34
 #define ATTR_CFG_FLD_store_filter_HI           34
+#define ATTR_CFG_FLD_discard_CFG               config  /* PMBLIMITR_EL1.FM=
 =3D DISCARD */
+#define ATTR_CFG_FLD_discard_LO                        35
+#define ATTR_CFG_FLD_discard_HI                        35

 #define ATTR_CFG_FLD_event_filter_CFG          config1 /* PMSEVFR_EL1 */
 #define ATTR_CFG_FLD_event_filter_LO           0
@@ -216,6 +220,7 @@ GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
+GEN_PMU_FORMAT_ATTR(discard);

 static struct attribute *arm_spe_pmu_formats_attr[] =3D {
        &format_attr_ts_enable.attr,
@@ -228,6 +233,7 @@ static struct attribute *arm_spe_pmu_formats_attr[] =3D=
 {
        &format_attr_event_filter.attr,
        &format_attr_inv_event_filter.attr,
        &format_attr_min_latency.attr,
+       &format_attr_discard.attr,
        NULL,
 };

@@ -238,6 +244,9 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struc=
t kobject *kobj,
        struct device *dev =3D kobj_to_dev(kobj);
        struct arm_spe_pmu *spe_pmu =3D dev_get_drvdata(dev);

+       if (attr =3D=3D &format_attr_discard.attr && !(spe_pmu->features & =
SPE_PMU_FEAT_DISCARD))
+               return 0;
+
        if (attr =3D=3D &format_attr_inv_event_filter.attr && !(spe_pmu->fe=
atures & SPE_PMU_FEAT_INV_FILT_EVT))
                return 0;

@@ -502,6 +511,12 @@ static void arm_spe_perf_aux_output_begin(struct perf_=
output_handle *handle,
        u64 base, limit;
        struct arm_spe_pmu_buf *buf;

+       if (ATTR_CFG_GET_FLD(&event->attr, discard)) {
+               limit =3D FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DIS=
CARD);
+               limit |=3D PMBLIMITR_EL1_E;
+               goto out_write_limit;
+       }
+
        /* Start a new aux session */
        buf =3D perf_aux_output_begin(handle, event);
        if (!buf) {
@@ -743,6 +758,10 @@ static int arm_spe_pmu_event_init(struct perf_event *e=
vent)
            !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
                return -EOPNOTSUPP;

+       if (ATTR_CFG_GET_FLD(&event->attr, discard) &&
+           !(spe_pmu->features & SPE_PMU_FEAT_DISCARD))
+               return -EOPNOTSUPP;
+
        set_spe_event_has_cx(event);
        reg =3D arm_spe_event_to_pmscr(event);
        if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
@@ -1027,6 +1046,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
        if (FIELD_GET(PMSIDR_EL1_ERND, reg))
                spe_pmu->features |=3D SPE_PMU_FEAT_ERND;

+       if (spe_pmu->pmsver >=3D ID_AA64DFR0_EL1_PMSVer_V1P2)
+               spe_pmu->features |=3D SPE_PMU_FEAT_DISCARD;
+
        /* This field has a spaced out encoding, so just use a look-up */
        fld =3D FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
        switch (fld) {
--
2.34.1


