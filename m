Return-Path: <bpf+bounces-56294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67201A94C60
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 08:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3751891FD3
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7B92586ED;
	Mon, 21 Apr 2025 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ikO6o66n"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF77257AD1;
	Mon, 21 Apr 2025 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745215530; cv=fail; b=Q6rcVusRYfCfn5OYM+UwjTMyNLsDHDHTtk2mO1OTWXCFTAKFuRyeO7ZuT1Bv70QS6DvdIm0UDl5adr2+NV5E1aKQUnaxaqyMbuo02vYCbD5lAire8SPa4FdF+O0chDVklLBHzCYCebL+Po/B0t1t2DUISclwGT1qx7p6KYvIqT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745215530; c=relaxed/simple;
	bh=nqDebAl0o0u4Qu7ax2a7wIc2briry/Usnmo4UiHVgbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XPKqR9PA9umDlNkOpoA/QXIEEU8w7wAiFJsjY9yxdJk6O9ZdqA3WrVGr7NXrHk8x++qbtQ+Q4/CKrZ9heegk51Sa75f45r2w0TQWZWQS6CutDCEgtcuO3dXw6oRkBH/m745CCkvoWFlLznamAtYVj5yY8OhiCRlia8ykvBpzMpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ikO6o66n; arc=fail smtp.client-ip=40.107.241.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPFzBrgHF7+PmIAeWPRj6BJc6R5UidyskYhG4seveeYFR09Zo9FYP46hYv6jnbg7JnU1paAcvCiNrveb17dDgR9nds8yajqJ3vpJCJ9ZpKHwfU01CT3IErhN7q8gl/Z02HuMyN+UU9w83H5NUzoHPY+AAM7VehoDz+mt/Krhq5msd97kwpGStNhowp2SgS2n43yTtZAZl1Z4szTAIT+XfVVtT9T3fhW78jN+bz7eHWd0TcK9cbaOiTpCTFNUWTacYPQR/IRB2S5ziior19sQTydsbXm0nmcXRi+RklHSAm+tmEqt5Wtm46QDHyCN2za46HMeWBYu0dGu0nTcybeOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9+JII1Gxcdnor7JjYtsmO3QAahmGY4Dpx7nHQpFs74=;
 b=QnH3pZMLyinem7O0HZkQCw3YNElitjVj55uybsE9XHrZj4jBEXPqLOmch7BJnRwoqMt5jaQgDo/pzOvoJfUXWWw1Qh83NWAEl/8orRP8tCe2ORn4qTp2Rf8UyOUUTHvbV4NUw9pvu0PDG+SJGWp5zJ3ZHxO4ly2bM8ZFqlwAqwZEnT+6OK2GqxWY4bzodrrCWgFu28K/3qECKIs6uxEsIDWwxsLG0jCkJp07lReCDXx90DsC+3rz+5YfKMCGYtFr2gUkAY49YRUeaVlnb3+vXT5qx67IjEY1Hu5Q8bIeMu+W7uevQS+u1dpd+4Si3O7GuQgS5rk3REgwIftFGEg0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9+JII1Gxcdnor7JjYtsmO3QAahmGY4Dpx7nHQpFs74=;
 b=ikO6o66nvfhwKd+ZP9NoyLdS/0xPklLwjLcd0JNntJvF4neuQ059KybDz5l5C8Z0UcEgptuhY+nXFRQvaUR1FUcjM5EG7GYFt+jDJ/1NRQ454pFJkjtFbjI2SlL9fqOkU9hSnYszDybYfRJ2tLn4ue0lUt4upQfxR6xg/7IjdEApUuBFKXuxURvn/AxhTeKMy8nc8DBqtJkM+IayXdBjaTl4BVTla0Hq1qPbC0Tz9fCdsWM7d7ou8MQqDkCXw6aG0etiwi51R0R3pA7yCbcwwwlMsa8pg2KWr4fljOniCz6ROZv0hPv5F7hXIIIvk6Ug/f1y9TjGITosQery1QUFBQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7683.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 06:05:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 06:05:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Vlatko Markovikj <vlatko.markovikj@etas.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net 3/3] net: enetc: fix frame corruption on
 bpf_xdp_adjust_head/tail() and XDP_PASS
Thread-Topic: [PATCH net 3/3] net: enetc: fix frame corruption on
 bpf_xdp_adjust_head/tail() and XDP_PASS
Thread-Index: AQHbr5BYnVjPia7reEWdyDcAvBVpdbOtp2ow
Date: Mon, 21 Apr 2025 06:05:22 +0000
Message-ID:
 <PAXPR04MB85109A26C0636F3EF33174D188B82@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
 <20250417120005.3288549-4-vladimir.oltean@nxp.com>
In-Reply-To: <20250417120005.3288549-4-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7683:EE_
x-ms-office365-filtering-correlation-id: abc04234-09a8-49da-bb1a-08dd809a80d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J6cngWZDFEiUlsmCklJ3/qDMl7DEdHZCZWKumwPT02HY8Tbvw36iv1myUtBm?=
 =?us-ascii?Q?sjk/Wszw8iGpWcTSHE4aloPr2L/LGq6sMBK1AxPdl9zg5qnl8xVpJ4+WfTU3?=
 =?us-ascii?Q?t/b5iHr/5KMvjwRfFoaj8q0Sm/6uKoZaltwsuKloZTDtKLYpZjiONfoVZF38?=
 =?us-ascii?Q?4oAHJ7bcxcg7/sDPNeNjxfQOKsHA/plQfjNbjqtLsm5JyZQQBw7wWm2km19K?=
 =?us-ascii?Q?hu9fJMX5sflL0A3Ln60FYzyvLG0iq1xElFw5N+rM4OGx5HTC0Q/A0C63vh+l?=
 =?us-ascii?Q?3vLVRoYbBnFobBzbnxIM4BDHpcDB2oOnQCb0ggBaOkZmi1yg+BF7/B+sPudT?=
 =?us-ascii?Q?hNXya1h5Xgrl7JkzPeOoxUd0VLjmBSmfbDyhEHsol3ux8UaUUy9DpjSq3ae2?=
 =?us-ascii?Q?CdvB2mst3lRQdJxBaKxtMoHGHQkClN68yexW7LM5HGTmSbqxoOmZ5SqOq0mc?=
 =?us-ascii?Q?9OegtmPBLLY9YjSVEuZsCDpLaEMXbBv4WgqLcI5JAXX7i+iGJpNm+MFgtXH6?=
 =?us-ascii?Q?LZgsZso/Gu9mgSaQEyuZELvBeF95W/y/wkECkTbQLR9MyJZJdcf+SB6VB+89?=
 =?us-ascii?Q?Ga4uurrfMZIS8HjU8cg0KDKDZghT0DfdXzZ5noGwlZv9ySxVeC5P0Kt2H2Xn?=
 =?us-ascii?Q?mLDN2xJBJVVFxLJfwpN1VOAUIKsn6pQPXS0x4n3yP0Sgx1V5xuwCnOJ8GESF?=
 =?us-ascii?Q?q54nqL9CwNFn0HUKupPrh1iDiAD5yZPLJ5WUtir6zlnkk9DpKV5qvVr/fpCK?=
 =?us-ascii?Q?ftHFaFsrr49DMknvp2spy2HaIS6yfDHdZShTjR6V2qthP6aD1qxA6tGly2Sh?=
 =?us-ascii?Q?O6+J14A5TKFOg6r9pKhDfID92pu79TKtx7wsZeodbfO/98ty2K1x1/oX2iFP?=
 =?us-ascii?Q?zTySzHgocYkrAyBqRt69hfYe5eD6QBRP/KJhxxi5vdOxKeW1p5l+CrgHV6ve?=
 =?us-ascii?Q?GJXeCO9XhXU9dBR3NLR3kGXkdcHlXvzm9uCgCOsQlNjIFUg14Vpvt7SZVI14?=
 =?us-ascii?Q?qhETm97VyjwDhGOrQ/PqUiQAqsc7+I6rDTvZb+HfVCuzF3cdaiBaGp14Pcpq?=
 =?us-ascii?Q?RJox4MJArvdKz6gh8oUciQAozzyNpYBESiYQTtFHUec70ZCWcBzIrRvj9ENd?=
 =?us-ascii?Q?vMbiAl1+JdaS3kxd48WrmBFy32Og+YY3IK+AADFhg3lqx71uL0bxHRcmvIDU?=
 =?us-ascii?Q?gvp2ANW5Goan1U/oRctP7WMxXIxIq9ECuxYrDJYvhCZ9xsaH2muazcKFoc3M?=
 =?us-ascii?Q?m82t7F3n8uC9ihg9kmJe4y9KwGlcdFtEIeDtXGITn1khsXldWh/tFxc6jhEX?=
 =?us-ascii?Q?fgfMyMTyQq0z0lnYaI+qnyE2Q3jCZbbar3xefARzIqJEnMr/yK3hAh51Jxc4?=
 =?us-ascii?Q?YKC7t70N8/NHqbiNge/QDpKUsRE0vGnABUnkDgpvZ+gDskciL3AYxJdnXAp2?=
 =?us-ascii?Q?v25Qd5unDj8Evtcha/KKAMJ8Kfl+WztChojIhYsVqX0j5CstYH+xBQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lZt1gXKNTmO/vn8z4MSutCH90V+ewtkBSEAXnmNOvI2Cg0s6Dl1/rlUzdCNY?=
 =?us-ascii?Q?73SylAWQgwUSRzshlFj4dDTK2Cp1UTfnkx4SlcLcUtlWXv5vnOFBNmqOwZgP?=
 =?us-ascii?Q?O1HCazl1DiX3R7KcD7jF6in6mmCTdo6Xl/6fJre+tagsqxDUdcle+tcswD8N?=
 =?us-ascii?Q?GzHwNo3SEN3r40P5F9g+UiXu86hkkgjTxtv0NZm1kgBeJCI1QMRR3xg4/onL?=
 =?us-ascii?Q?/EJp3AX8JIo3plPJ/+rlTuQb4CkaicNikK6pFdaU5E0JZz7nG25h+QywHto4?=
 =?us-ascii?Q?JevKA6KWf7JqafB5Q+zX16sS5L/JRD/dLBTx95aFwB0Ta4n+cs3XXLfbAMy3?=
 =?us-ascii?Q?roKGjitRajeLlm6WWHcnDZUaVlEIlD9feOR9254wrP9y2YcSjcsr40aBKOiu?=
 =?us-ascii?Q?HPM+MT1A7e8Et/1Zg+ZA6NFJk7GYnQeCh1+NO9OqB0oAzjfGjkLpU6owtgpQ?=
 =?us-ascii?Q?429P5D3dntwY76neVQoojaVcdqqVhinEYNAC/tWYBOtJlTK6qnxFGL+pO1j6?=
 =?us-ascii?Q?6pjg+BcbJRR7XdB8uNQNeSYCdt14q2l7O4A0Av15dXFOicWDau8L24TwO+Zw?=
 =?us-ascii?Q?s2ZjN9zOh1PGM2xe1+0UlojuDECCqVP0Fs44n3SrwMPu4rT93iWflG3k7gwF?=
 =?us-ascii?Q?gXMAqTXrXQyQvIoxmKt+HoD2u1Fjf5ArLjEL/Mc1ghcgCS7SLNPKIkHa+wB4?=
 =?us-ascii?Q?9ZkNlVegNsXEqKQWV1/TpvzEoYsTfH4svh7HNm/oZ6bVTQnUXjfdxcioFvlY?=
 =?us-ascii?Q?jU+Rle7EfEMNrVjLnykMdUyxr7FWLkPqOBb6150wFeXy3QXLmbJLvU9NAiD/?=
 =?us-ascii?Q?KV8t5r15GlnbPwgO6hfAkPPLtSik2XTMaYxKmMbwxyfNxtwIXuyHhy98MqFu?=
 =?us-ascii?Q?qdTWRZjg/MHNlnY2Fc5eEzi2J1KmqQF9ATe6nRQ9SM1JuZUE3oPhkOkJ7jNE?=
 =?us-ascii?Q?iS1Z+iIpsOLP2cA2PSNNvs73p6wf+h2v17ImGgH+xes8sYmiii+IYI17jCLw?=
 =?us-ascii?Q?KSC5ckakYwIPpT7iuusxigrYZV+DHgEhtBSJfr8Q2ST3CBaAzOeYXcW9E/UU?=
 =?us-ascii?Q?FWJRHJySTWMyuxvGKryFOqRBJtKthnbJ9h8enkakCft1LW5JK7yGOz+wAmbY?=
 =?us-ascii?Q?sQcToS2jlBNWoGlRGV90CXS4gCFB/u3+HCC9Mleymq+MGIarT2pY43OmOwZB?=
 =?us-ascii?Q?6r0wYI/4hOkGGtnqZEUa1z2omIXy+XRP2MZUa8Ce8mFKvRcJSafDo7ohGZV6?=
 =?us-ascii?Q?DfiPrr/eE4vfVwxZh45yZ2yWXpVxZqh68Cd2Oa/KbolP2fK7dczYXvz3pk/J?=
 =?us-ascii?Q?QhNBFdIeJB9XwDED/QdztCl5Fcjkc4IhBrgNPNwCiCESr6jlu6GEpc7H33vr?=
 =?us-ascii?Q?nS/u4JfMkDB5eCo60aPRbiusTstIPMQRNB7eFxuIBZtpFxWyej9UQGoPN9Z6?=
 =?us-ascii?Q?Uinb1S0LtS9tYb3/qhzOH4sQwP8CtlBnET2Z/YyrFPonzhjS0LCxCYM7snQ9?=
 =?us-ascii?Q?Gl/+4IthKeE2qVPITSQuIsz5Y87HMVR1uunUjeRRhGRvfFn3sk+JaOlFnFW3?=
 =?us-ascii?Q?KElPwHdop4RG3ZxSa8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc04234-09a8-49da-bb1a-08dd809a80d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 06:05:23.0560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTsuq62Ux5mE2tUQkE09Zm1nin4qp16LeITt/6V+67Ipw7CmmLCVU+3Ii1h57pkQfO6Z9MJGj+j/BWXfiIFfjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7683

> Vlatko Markovikj reported that XDP programs attached to ENETC do not
> work well if they use bpf_xdp_adjust_head() or bpf_xdp_adjust_tail(),
> combined with the XDP_PASS verdict. A typical use case is to add or
> remove a VLAN tag.
>=20
> The resulting sk_buff passed to the stack is corrupted, because the
> algorithm used by the driver for XDP_PASS is to unwind the current
> buffer pointer in the RX ring and to re-process the current frame with
> enetc_build_skb() as if XDP hadn't run. That is incorrect because XDP
> may have modified the geometry of the buffer, which we then are
> completely unaware of. We are looking at a modified buffer with the
> original geometry.
>=20
> The initial reaction, both from me and from Vlatko, was to shop around
> the kernel for code to steal that would calculate a delta between the
> old and the new XDP buffer geometry, and apply that to the sk_buff too.
> We noticed that veth and generic xdp have such code.
>=20
> The headroom adjustment is pretty uncontroversial, but what turned out
> severely problematic is the tailroom.
>=20
> veth has this snippet:
>=20
> 		__skb_put(skb, off); /* positive on grow, negative on shrink */
>=20
> which on first sight looks decent enough, except __skb_put() takes an
> "unsigned int" for the second argument, and the arithmetic seems to only
> work correctly by coincidence. Second issue, __skb_put() contains a
> SKB_LINEAR_ASSERT(). It's not a great pattern to make more widespread.
> The skb may still be nonlinear at that point - it only becomes linear
> later when resetting skb->data_len to zero.
>=20
> To avoid the above, bpf_prog_run_generic_xdp() does this instead:
>=20
> 		skb_set_tail_pointer(skb, xdp->data_end - xdp->data);
> 		skb->len +=3D off; /* positive on grow, negative on shrink */
>=20
> which is more open-coded, uses lower-level functions and is in general a
> bit too much to spread around in driver code.
>=20
> Then there is the snippet:
>=20
> 	if (xdp_buff_has_frags(xdp))
> 		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> 	else
> 		skb->data_len =3D 0;
>=20
> One would have expected __pskb_trim() to be the function of choice for
> this task. But it's not used in veth/xdpgeneric because the extraneous
> fragments were _already_ freed by bpf_xdp_adjust_tail() ->
> bpf_xdp_frags_shrink_tail() -> ... -> __xdp_return() - the backing
> memory for the skb frags and the xdp frags is the same, but they don't
> keep individual references.
>=20
> In fact, that is the biggest reason why this snippet cannot be reused
> as-is, because ENETC temporarily constructs an skb with the original len
> and the original number of frags. Because the extraneous frags are
> already freed by bpf_xdp_adjust_tail() and returned to the page
> allocator, it means the entire approach of using enetc_build_skb() is
> questionable for XDP_PASS. To avoid that, one would need to elevate the
> page refcount of all frags before calling bpf_prog_run_xdp() and drop it
> after XDP_PASS.
>=20
> There are other things that are missing in ENETC's handling of XDP_PASS,
> like for example updating skb_shinfo(skb)->meta_len.
>=20
> These are all handled correctly and cleanly in commit 539c1fba1ac7
> ("xdp: add generic xdp_build_skb_from_buff()"), added to net-next in
> Dec 2024, and in addition might even be quicker that way. I have a very
> strong preference towards backporting that commit for "stable", and that
> is what is used to fix the handling bugs. It is way too messy to go
> this deep into the guts of an sk_buff from the code of a device driver.
>=20
> Fixes: d1b15102dd16 ("net: enetc: add support for XDP_DROP and XDP_PASS")
> Reported-by: Vlatko Markovikj <vlatko.markovikj@etas.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 26 +++++++++++---------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 74721995cb1f..3ee52f4b1166 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1878,11 +1878,10 @@ static int enetc_clean_rx_ring_xdp(struct enetc_b=
dr
> *rx_ring,
>=20
>  	while (likely(rx_frm_cnt < work_limit)) {
>  		union enetc_rx_bd *rxbd, *orig_rxbd;
> -		int orig_i, orig_cleaned_cnt;
>  		struct xdp_buff xdp_buff;
>  		struct sk_buff *skb;
> +		int orig_i, err;
>  		u32 bd_status;
> -		int err;
>=20
>  		rxbd =3D enetc_rxbd(rx_ring, i);
>  		bd_status =3D le32_to_cpu(rxbd->r.lstatus);
> @@ -1897,7 +1896,6 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr
> *rx_ring,
>  			break;
>=20
>  		orig_rxbd =3D rxbd;
> -		orig_cleaned_cnt =3D cleaned_cnt;
>  		orig_i =3D i;
>=20
>  		enetc_build_xdp_buff(rx_ring, bd_status, &rxbd, &i,
> @@ -1925,15 +1923,21 @@ static int enetc_clean_rx_ring_xdp(struct enetc_b=
dr
> *rx_ring,
>  			rx_ring->stats.xdp_drops++;
>  			break;
>  		case XDP_PASS:
> -			rxbd =3D orig_rxbd;
> -			cleaned_cnt =3D orig_cleaned_cnt;
> -			i =3D orig_i;
> -
> -			skb =3D enetc_build_skb(rx_ring, bd_status, &rxbd,
> -					      &i, &cleaned_cnt,
> -					      ENETC_RXB_DMA_SIZE_XDP);
> -			if (unlikely(!skb))
> +			skb =3D xdp_build_skb_from_buff(&xdp_buff);
> +			/* Probably under memory pressure, stop NAPI */
> +			if (unlikely(!skb)) {
> +				enetc_xdp_drop(rx_ring, orig_i, i);
> +				rx_ring->stats.xdp_drops++;
>  				goto out;
> +			}
> +
> +			enetc_get_offloads(rx_ring, orig_rxbd, skb);
> +
> +			/* These buffers are about to be owned by the stack.
> +			 * Update our buffer cache (the rx_swbd array elements)
> +			 * with their other page halves.
> +			 */
> +			enetc_bulk_flip_buff(rx_ring, orig_i, i);
>=20
>  			napi_gro_receive(napi, skb);
>  			break;
> --
> 2.34.1

Reviewed-by: Wei Fang <wei.fang@nxp.com>


