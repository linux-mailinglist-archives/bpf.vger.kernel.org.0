Return-Path: <bpf+bounces-56317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4BDA954A6
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 18:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3DF3AB95F
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4501E3774;
	Mon, 21 Apr 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YFtb1VA2"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010021.outbound.protection.outlook.com [52.101.51.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FAC1DED5C;
	Mon, 21 Apr 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253618; cv=fail; b=NhyYYAfn75m2fJ1dKxsPB8WwVGgp11nsJUlFZ93M5/YyB/yWO0nOS2Go0ZKQj5RUDgq7W3NBC2m/Ei30cPMktBC/JPgzH05QoECevdxs4B+0IL/PwsCKKeLLnV2d08W0W4H1Cf745tlgwVNQJzppe+QvIykq/mCvoojuCTeWMgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253618; c=relaxed/simple;
	bh=YiPqWiyng7NaUrFlEVn0ufG6dtz7F/lY+8HNXRsvhvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rIishBYghDzcohoAxANhCAmnJQeJ6eLPcHvMsEZzK1XqtDWF77o6tFZT0+NvV2qAsXXDyHlBCRL8Fqp6QQmv3TigNI7LNeFLlq/rV47FISLCNy2L93WghKtES7qPlfiC8noTXP+x0xkJ9pw5GPc1HhZ/oNJzaKvgl1CjVnu/ZZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YFtb1VA2; arc=fail smtp.client-ip=52.101.51.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsqT7/xeNpWeSwvsLxWFi2EwtCC93pzZpTn3UmvnmtvQdzDHSlqfWEbQa9eaHIUgdcden1GZ3vqAT6Rm2fB42fgVRY7z+DiqnuauHtPjNibTEYasl/4IwQP3ArLIWyiz7oeIWtV+vY8ca11j2vLvtXOLMNY+PAr+cCIpPDS79m8Uv7cE/W9/J64gvxQiNc85f/Cb5Zsl94B7L1obAF1TOOnbz3fZC4pq6YCo3vVY1VzPUEUtru4Zwt3yO5jkkXYeuf9qrfZxUGhamYgMkAcpiXVbIi0XBEVOHGCY3hwvzKzK9SqfHjxPuknA64HDUJxTDppO+1WC6zRBo3buKZCRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiPqWiyng7NaUrFlEVn0ufG6dtz7F/lY+8HNXRsvhvs=;
 b=ZKi5eyXmB/jkKZwhlkqrWRO3SfxkklyMxNnQZdvi//iv1Qlq9IcKO8LxNOBNYr6DP86O9bfUV+8nXxUPgkrN1UPCuWd8AewlI/SBg/EOzGA14VfNNKeYrdaczSTk1+qZdRjXyWl8x0OXeFbeDg1ZzSeN0tU0DxnhhRNRLW7mM4Hdci1IY40JSqWuriI/UcPEtE/yooJ8Pns4Ro/cvK7lLD1qHiSOf0Z2o4DAZX0rapAOD+AnuDcDdpKFXFg6vJCXcy0pv7omcQX6BfceJJufK7wlkpHBJsu4XrRurWufHPb6Opa7G6NThiDfRt4TR76yH+Zgp9SkOGZds5oCe0ESqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiPqWiyng7NaUrFlEVn0ufG6dtz7F/lY+8HNXRsvhvs=;
 b=YFtb1VA2PQEXIMDxBUm5xi9XyQqrEdVPvCHfAmaNvTsuzRE8Bc9hxi2BpPD+zGBxHncGirGVre7KatWFObi93YayK6eHIr5SrByanKdiVZN6RgVkNwhcmhQXYFXHRE+0GCnauhHmbk2p5CxCbNkkGG+lYlOjBcXIZyWpq7TYkryy93HftHeTn7JtOeo6SE1+s5tnyL5mBsPNYfXxRmhiNPRtDzWy/EiWiQ5xoPZo7AnvVU8/aAAguZkr6R7v99JEq+m8M75GTdmUNSxs9XbubSL2+l31piSjU3LR4FUsd0TfnEaJHmvT+uXb/9zIy81QJkb6IAKGjgYDD9PaI7nV5g==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by CH3PR03MB7412.namprd03.prod.outlook.com (2603:10b6:610:198::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Mon, 21 Apr
 2025 16:40:14 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 16:40:14 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Furong Xu <0x1207@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Gerlach,
 Matthew" <matthew.gerlach@altera.com>, "Ang, Tien Sung"
	<tien.sung.ang@altera.com>, "Tham, Mun Yew" <mun.yew.tham@altera.com>, "G
 Thomas, Rohan" <rohan.g.thomas@altera.com>
Subject: RE: [PATCH net-next v3 1/2] net: stmmac: Refactor VLAN implementation
Thread-Topic: [PATCH net-next v3 1/2] net: stmmac: Refactor VLAN
 implementation
Thread-Index: AQHbqF534FzGLRNwp0yA1XNTHIr18LOcdZCAgBHvTAA=
Date: Mon, 21 Apr 2025 16:40:14 +0000
Message-ID:
 <BN8PR03MB5073BB4178D942835179AE68B4B82@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250408081354.25881-1-boon.khai.ng@altera.com>
	<20250408081354.25881-2-boon.khai.ng@altera.com>
 <20250410143821.000002c0@gmail.com>
In-Reply-To: <20250410143821.000002c0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|CH3PR03MB7412:EE_
x-ms-office365-filtering-correlation-id: d2234cc0-b296-4d7e-420c-08dd80f330e8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1/+tDC5jKhGyNtW2NwKpdYkXicZTyRtUgx30JUd/ctQiEb3vaaq3zwQlDCBO?=
 =?us-ascii?Q?Uk/YN/BneS3IdJzH5qBdy3xWTpcYQD7DXWZN24YgVISqJ5R19EMBhu8RlN9a?=
 =?us-ascii?Q?wA3nUfYerEUohFnPVbmLeFPEVemkOzOelcrM7Em10dRapQf8o30qpqdBIhk8?=
 =?us-ascii?Q?e5CRc5/BZHiSaUpvYG5zs4B7kIKmwLQQAC0ieWVD+4C4T/XbrXLtdLKzBrLM?=
 =?us-ascii?Q?XUx1EXAgPXSZOeb1378lRLfSruA47m7L50Yx51iHlxVa/aI+cgM92nzzLg3u?=
 =?us-ascii?Q?SxM66HYAKA9znIXli9qlP/wnbcxpgpW1rK4FglvSdIkB3V5+bKxBt7K61d9o?=
 =?us-ascii?Q?Wle7VcXx3XKYfKqr1IQcCCIwfAgXyxjgD/uztTDo/sf3QFcYCwaM4zTTZhxv?=
 =?us-ascii?Q?IiXUIfkcZIE8gD/KWtr/KX4X8WDKCdqq52GULCJZCnf0rAR3+I12KA1AJ/KK?=
 =?us-ascii?Q?zIIC2UA60PrPVlYrswznSmUF7N3tfpw/LKzDeZCTMVM4obXiroFOjWtHBnbO?=
 =?us-ascii?Q?tq94bDCL4vxgtrfIcJK8nqtQpsRjrWQn4Y6lPGndQt7NVf6EXSDvbj4Ld+1t?=
 =?us-ascii?Q?1PQ7fFgtncMG42zSrCZsSMuX9kgxpggBaRVz7gFyjr9HdsvUgkmgku8/Z7b3?=
 =?us-ascii?Q?ntz5YVfCPWWfwD1FZnkjJxaK9SHbgPugSIQeyslWuhP3wTJVXmQeVi7DgoHk?=
 =?us-ascii?Q?VwXQaj8X1e0ZO2SwD9SVI4HXUlcA8tiajk8JEf2hfEMkvZNU78Jj5F5LBlA8?=
 =?us-ascii?Q?5HRu1g136DRikp6UEOiehItQXT2NwY90bzl1j+RojRHIp3lB79dHfij9bniS?=
 =?us-ascii?Q?mJacW4vLW55aQ/BaXuK9LJ+2NA9txYrtfl8HyVJyUeDsZMYpGbnbflrRZ/vw?=
 =?us-ascii?Q?yZzasTke87Btoy3T57sZYgGm2v7q2hONnvdIX0qHKkBFlD6YBh7nXpswzPG3?=
 =?us-ascii?Q?CsHejtVmSdTV7lWImkNnAI1e3f6gfyT52LnkvCXGdxzosxr2Yb1G7iYjmP8F?=
 =?us-ascii?Q?iy19LZz2lWVDlqEQjKDImaNdsS3SUCYX017mVlWe4x2cGIdS+xgON87k5oBr?=
 =?us-ascii?Q?L+akVgNb6RwzSuAa70wdn5cTQQSkpBjUOS+8DiVWSVaX3Q9EOyBIRRoLgIUo?=
 =?us-ascii?Q?USnY52ETi4lQ+10H9XJbl+fUQXLOdEtLt2njTi0N3j+7zAiEQfQpxfEIMdW8?=
 =?us-ascii?Q?eqdDgcXHfxETXL1xe0fq7T5Q8k4vDS/ARkTBQ2Rv25JGT/JMxwL4NzwadIwu?=
 =?us-ascii?Q?r/ug9ah2UNdQRB5fwNBNZ8spqGku2AFwfukL3/7Q9sefgEoG60GS0rlcVQxx?=
 =?us-ascii?Q?rsg6Iw/aFG06qoTzSq1kQoQlA9zSr1B5PYgH8zkuIRHFVzzNdx582uPmx8IH?=
 =?us-ascii?Q?TPbAd/4mbs+GqWg8Hfqp7ASRhDT5p1SD863mH6vNZiq7R7n/l176Giwu9At6?=
 =?us-ascii?Q?QKpzOQ81N+mjI3wnVsuwkVhi/43VXCIF3o+D7zW7G0KD6I4azcRUKA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M5Vsx8Y9Ee6cgpbjlTrBvY41wfiApWAv/EyR0HdpBZEUUHHSfDR/yWJvaj1w?=
 =?us-ascii?Q?ycAzdqguo4kiWuyoIeKHdyKl8AZiJPaZwSMtYjYycIAnAA2KhVP8pjOjjx7P?=
 =?us-ascii?Q?K/TFxGG+siltfsFMQsAr9zRr2sBsv11HIebwVfbbeNxUGh7KaalBZCANPAiR?=
 =?us-ascii?Q?k7qiDBelb6a5f4eT2ibMlRrEhn6618jwYL53AtOL8yEPDEYi/Af3qV584Q3w?=
 =?us-ascii?Q?3aBJpAVWf2UMek0bTly6qmXKhjtnM3ceAL60Tz++3KeZS2lL/+soL3bcnxKN?=
 =?us-ascii?Q?Nb9Upd5vxgZe439memwmXvwNrYUar2j1KvZmxX82m45Hxtj6yOAGO3y0isQg?=
 =?us-ascii?Q?gAo5fRpzPEzNTfFPZ4AS8plfvFr5VbkE2NBpbz3A9qKgi7I3Cjyy1bQ8KzDm?=
 =?us-ascii?Q?++8YbDVA1fb7P+rl/HGaPhZSRW1TPx/4dqIHIyrXqreHThKbpcIuM7T/FB0J?=
 =?us-ascii?Q?1hON8CmbtC7ioe9HkaqI/uS1jqaWJHT8fGVmnYK7ej/aHBsJxY3iAxbVrLps?=
 =?us-ascii?Q?DkkA0SOla07QUKHq81RxDtPCG251n00g7JdQ1m1xbp3nNjIhS7M5tw0XYM7a?=
 =?us-ascii?Q?MYKJw2YxZ3Z/67OctXTBavzegZu2wpVdnubbWvgV3YhdQtu3Uv9uCwBx+uAk?=
 =?us-ascii?Q?z4adCEJ1n1xUDViE3CkhwNInveDZaHTB5STbvPpHm/5r7M4vPBCNzCRsQJO9?=
 =?us-ascii?Q?JFy2kh5UA2XdDHWcOe3kqqVYpSU7vVQuuOgNaKNZhXgLA0Q7++5Fb6h1fAmc?=
 =?us-ascii?Q?QcUTPrd+9IgO3xeo+cvPC9IAaBCxU7jmjuE7krA6jJUQo8nyvvu+Ce12rijU?=
 =?us-ascii?Q?e7JwYQTFs+mLxPjs9SDRsM9MLpYuVCko/XM5W5TQf7/hL4rO8S2QLhqZc+ea?=
 =?us-ascii?Q?TaSNw4WR0J6L8D83OYZwesk6Sf040TovWX9fXT3CLZRF6EEltP3hVHU9nZs6?=
 =?us-ascii?Q?T0azW2kt6Ml1BurYVvrABjL40dikwQIrTHIdlnHooOzqNsHweXpOobe7TO8S?=
 =?us-ascii?Q?Aeal8awKqrBVIDteMWsOLjIMn+dscpSXvyb1b3mqrL0rNrmynZPz4htyDtv0?=
 =?us-ascii?Q?MfkfNfrr+iC7AnbMd6LMAneqfRPGw0ibV8iYS8senIJQAgQkDLm3KhHO2svR?=
 =?us-ascii?Q?H1GRJiptj5ior1K+lW8YLmP1jW2Cj4IvvQbigaxKkvyAYVw5GlMnf+IiNy44?=
 =?us-ascii?Q?P1RQNqG/4DZ7YK5VhYq1SdUY7UAk/j/p026o6b0zp+9OiICYnHAqXpTxagrf?=
 =?us-ascii?Q?KtF9a7xm7GhQADnLmrELKnJtVtjc2v0vco2C/T++7ji+OO7ubo1gm5vGwfxh?=
 =?us-ascii?Q?55s6HNwHEyEr3n8I62uDcjts+ByD8G8fR+neb7yxmoo6jjQsooFEZKJeIbGR?=
 =?us-ascii?Q?RRDacLHnfC0j4GiFWNQpLpX2Y2/zL8IaeGyoUdsK+do6Np6ppl+FYziogxtD?=
 =?us-ascii?Q?oUX9RiLQDhAuKRrKUQ70aXFW/NwudpJHb0Bj3r5sJXSiEI73Cy5j2Ao9ObXT?=
 =?us-ascii?Q?5G8B8D2AkBP23Ev1dGxF+qI2P1UP/bK472nUWot0CxOB3QIWH6D9non9SDZI?=
 =?us-ascii?Q?dKAPi3E1W0FcryNrQly/cwnohD3NMTE8klsfQNSn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2234cc0-b296-4d7e-420c-08dd80f330e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 16:40:14.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/pgh2+N1LeI+SOl2tT99VuwM7i8zsYTNhWSU38uLfyfQVhoLls8efBcANnVd1CYe1r4y+R12XZnb79QKwpHeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7412

=20
> Rename dwmac_vlan_ops to dwmac4_vlan_ops will be better,
> just like dwmac4_desc_ops/dwmac4_dma_ops

Hi Furong thanks for the feedback,=20

This dwmac_vlan_ops is defined the same at dwmac4, dwmac510,=20
and dwxgmac210, thus consolidate them in the=20
same ops: dwmac_vlan_ops.

> dwxlgmac2_vlan_ops looks redundant here, another new struct contains
> totally identical members.
>=20
> stmmac_do_void_callback()/stmmac_do_callback() handles NULL function
> pointers so good, we can leave the un-implemented functions as NULL.
>=20
> Are you trying to avoid something undefined here?

Nope, since dwxlgmac2_vlan_ops does not hold the same ops with
dwxgmac210, dwmac4, dwmac510, this is not newly enabled, just move
over from the initial implementation on the ops assignment.

>=20
> It is a good practice to only keep inside the header those definitions
> which are truly exported by stmmac_vlan.c towards external callers.
> That means those #defines which are only used within stmmac_vlan.c
> shouldn't be here, but inside stmmac_vlan.c file.

I prefer to keep all #define directives in the header file to enhance
 code readability and debugging efficiency by providing a single
reference point for developers.

Regards,
Boon Khai.

