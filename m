Return-Path: <bpf+bounces-54212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4004A65922
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9419E885645
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ECF1E833C;
	Mon, 17 Mar 2025 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tH3XSipV"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2CB1E7C20;
	Mon, 17 Mar 2025 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229857; cv=fail; b=Jf48rhvozevfRwruf+VL++wo8xqTKG/6kY68dth3TDqT9pm4IB3EB/dJCZw+ctxS9TSoFbl1HfmU/Ef5XhkBoO8rYbOHGnGc2h3kodEA5lUedQ+JoAPkhqbIqwfLt81q5ZpWswojyD18L9//nf8D5fTsMHloNS8VppVWzrzfg2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229857; c=relaxed/simple;
	bh=BYaXlP5438O4mc+q4wieSI75X7RGMum0YC3UNTMq+IE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M7nkbbuPF9HK5sZ54z6LUYADBNA9YeWw9Ky++ynt4HFVHuBczrZeBVIkEuS3meZAEJr3fO3nNscBctQVrHvRgkMYmrg5z7dU3SL1/NoYZhvVd/zzrvwuX8t2d3/ctFfFGASWPokFZPUu4/pcI0KusD4z38qVW0uMRrbefkxgP34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tH3XSipV; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBB2kX6FtUgBTH2ndvCR0Km1l1egqzhKSxBwC/SrB/eKy91JYO9PeBypsr/rz+SnWAvC7VMp0C8zyDcSFMxoxsqswPVlZwQ02cG2EMCRQO05cLPrrIKlnqs/cpuwxqmJoOCd5rmtoAghwD1xEuigTRQwzDSY9vQKhOfHI2uXB066T8qCBWtubmoKZsoNGhSqP+lNP633W7LzBCghL0x1R/gwMXKsuUronLrP1y4tg9nf//AklIl8Bgf5CRgdPLNl+2HKOit3MVO7uB6AhBghTcK5JLd9xE/l6423HAxcwdgE7W/fgLMIavdbGW2OO4LTxVtl+hkV99kog1WFMXBSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKuHlXqY4LKjqtrS0kqwS77BbZOB/aGSdrVscQExPPQ=;
 b=sfNg7hmnMmU6p1aMoF1gSde46rRsDU4L9KF7HKBL/Ual3gkYwwDdYEXMVLNdrcOf4UNLGY7qUcJXp52EAIQ82oKbuj1Vv6JVvJFBvT+DMQs7/Pa9dum3MXQT+mU9HlcSGulqTqp11O9SVMAvioV7z7ez+aeH8FEQxF8gFkvB8EzRBXxEQTXSAXYsofZQvTLV/am3UTlD8l7Rpj4KjSsVlVN3PAZ7uE4TQlCl+j43Plio+mHALkQwesmU5kQXxIzWeiprPg7yuE8SBcbVOP8iy0FnpKMUElEoXrGAHtZ+5i0N29X3o1PuXKELa8CH+cZWaPh/hWFlG4Am6fCCzaXjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKuHlXqY4LKjqtrS0kqwS77BbZOB/aGSdrVscQExPPQ=;
 b=tH3XSipVexg6Hrb7Ev3vnWNMtGj2W6hqprZ3fIJ13v9RmEurT19LpkDkg9mTaeI4haLJEabAC9GQa/oGzC6Mi9pHNVjkdgrBeGcLIpiJKn/MtYYjl31v0JN6fX2GSeBEQuJDqW0vNwZIxDjPa0PGp3FQkKv772N47Z4PGqZqNtjaR+M+nm1dzaUFNWxnlFfgOEgAZj3cwfnW+NdZ3eBhq/p1o4l9+Ko35rwzn9u7U8ED87k0a4fEOXZ0ktlw51sLfoACS4VfzTUmeAauj+H+vdWj5CYAMMgfLEa36qx//ZKC47jgPVMl9/XVlfJP03MoZf63VQ2B2nlSLoxcpjFCAA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAWPR07MB10012.eurprd07.prod.outlook.com (2603:10a6:102:382::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 16:44:11 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 16:44:11 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@gmail.com"
	<dsahern@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"horms@kernel.org" <horms@kernel.org>, "pablo@netfilter.org"
	<pablo@netfilter.org>, "kadlec@netfilter.org" <kadlec@netfilter.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "ij@kernel.org"
	<ij@kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, "Koen De
 Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, g.white
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, vidhi_goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v7 net-next 00/12] AccECN protocol preparation patch
 series
Thread-Topic: [PATCH v7 net-next 00/12] AccECN protocol preparation patch
 series
Thread-Index: AQHbjh9jtAGqv333XUi9HKdrMqfnAbN3jGsAgAAOHbA=
Date: Mon, 17 Mar 2025 16:44:11 +0000
Message-ID:
 <PAXPR07MB798499BAC1A21E323687C9CAA3DF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
 <174222664074.3797981.10286790754550014794.git-patchwork-notify@kernel.org>
In-Reply-To:
 <174222664074.3797981.10286790754550014794.git-patchwork-notify@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAWPR07MB10012:EE_
x-ms-office365-filtering-correlation-id: 18761b38-24cd-413d-0f3f-08dd6572f1e3
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XitGAmCULj7jCYVlctZEYgwrBTLjzawHMrAyETemgHcDLkmuKqnGLCY0ehkH?=
 =?us-ascii?Q?53qLF7bLLzXTwkjWE6Fec6a4K1u1O1zIgH93Dmk0ZOY/qKUXWZx6R78w6sxo?=
 =?us-ascii?Q?3fjLQM/Uc9EjMyIUAxBYTgofYaEJnwhGs8/vyzfIYuzzTSstY9a0tKfjkVgN?=
 =?us-ascii?Q?3+GCDSBvOQh4tTOi2U1epU/1jtEQnZkcYZ0OAkGzsL3WtIJsyqgWOI7CBCwg?=
 =?us-ascii?Q?2yARDn+bfG5UOdN3sUnT1X2wMub6me6YSBQ2JrVuWSEC0rgNQet2Rn2XXhet?=
 =?us-ascii?Q?RPY7G+CaDNDpr8ADdS0McV9OBjnZf4jZNnbViNr0uEXVtAqS4i+YtqhNROr8?=
 =?us-ascii?Q?bfSnXBZfXsC9tULMnumjNZH+DsWmhsz1lmRJQKGd3C1Kgf3z44ku/l3+F5Mv?=
 =?us-ascii?Q?3vyGQg4D5EM/ueOp87+FB/7CKibL0OcvgD0buMf1/3RNT5C/jHJ5JA+2TT43?=
 =?us-ascii?Q?OHsXLrhGjBjYFl04wb9NfVifBmCTJ/p4xKwrmlfB6fjYpC09lf02EUPRjcAq?=
 =?us-ascii?Q?2/nQDHEQImymKmIDL5PJh3LoqJZWlMIuYAcy8E+hV+0zCiQcQNWSfuRVzTiv?=
 =?us-ascii?Q?btjXqff0drwWMGpjEqI3Rz26qo7b2iUY4xrObIwDam0geET3ht4VUOs/pdZT?=
 =?us-ascii?Q?n6Rxf2DeTQvUm3jHkURGFqrXmTZb1YIocquODdx2okZkZOwvDaJ8o1kCiaG5?=
 =?us-ascii?Q?Xb0VvSLY9YfLQWjS8rauaT4OfeY5L19RLiISmCtlcaCiMXXGYOafOHgISakp?=
 =?us-ascii?Q?onW1Vkc9TFfBvimWir7ITbui0lPAUWt1N/C0FohyI9Ok0yu3O0mONbGRBhF0?=
 =?us-ascii?Q?dzni3md9iUoSp4xLzJLl/LWyuvS52uroiEY00KFFmZyK6wYPfsVqCjHCKC5d?=
 =?us-ascii?Q?uD3ird+E6JNpWEdD5XC3uVbr7QDzvNm9VtOGYfDilxAM3SQL9aOvxpQxDfOR?=
 =?us-ascii?Q?sCSHb2nLxrSfWxj50L/TcpEQzaBDYnc+x7z1pDcm0uQH7nf7o0MahptbAd3K?=
 =?us-ascii?Q?XrCqCs/wFIFNNiqoI8kNQtQJlmYdz277Y5NHcCnxnWfcv9z/qYiRLM+vlMe+?=
 =?us-ascii?Q?fTQ380TMBrEhqVRlt7CHiKnOizyi20jmLDsoSyxdW5N67ZmGEgHuFVs9duxt?=
 =?us-ascii?Q?QzAzlBGdqBZFePoYy3WPtwr07QgEprJxivp4WSpDSBOwFPi8WG36LDFTlTcO?=
 =?us-ascii?Q?k55UdZ0cNhnD4flfCo3/USNF2RMC8JmstySKR76rCKooO64PV0AstuXyWkI+?=
 =?us-ascii?Q?W2ifDV4e0wGoq3NAPhycdG+EJHmQCjUCJvxUnmLeJm9csVd7TGT6ydWArRjE?=
 =?us-ascii?Q?iYQ07B4n6/qtvzYN5Ri7nkPVqcJcgfdIEXulQfv5/cTKBgpMWKGEpeAvakgA?=
 =?us-ascii?Q?IoKTat4+rkQShb8oSRGW8l76+UfZyKTUzRtn+g0CMscqYOHssI3wlX/k0Kyt?=
 =?us-ascii?Q?Xf7dmP9VDXrImBTgO+42jO+Su0lhiGNx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x3mRSQsQfDfjnUFiME65h+MIcKOgB1gqXL+aeZTqgreS02LEuiYrs5LJL1of?=
 =?us-ascii?Q?rEUXJkceuPa/YCnxSaNrwsBAaRF/gTyqERr1hvIPsVDTK0P7q+mkR/jS6bD7?=
 =?us-ascii?Q?uW8nYmLfYsfT3DnXtHoIuXVlNNCiQkRqfnK1ZRVXtNIkEpabpdcUDOVPrLZ2?=
 =?us-ascii?Q?s+uaFZU8ncxjmV66Zqb3YBt/tj8lM0dx8yhaddcCzrCAUy9pgrmifuIOL2uU?=
 =?us-ascii?Q?WrFgl0tA/c6ADwWQIx/76jviZQCgQPR5/vEJ1Fw3eaOowRYwPQzFxOr1TuaU?=
 =?us-ascii?Q?IBR9GRxCI0eacgvDOOonjuKB4vDu4EIyHpg05UzBt/FxtshJSTABViESh+4u?=
 =?us-ascii?Q?xAYBPAkPsRy072zJXs23Fki4ZHt83OJCvH3gvix+xW8G8a3gAHRslVq1zxjt?=
 =?us-ascii?Q?osn/TpxLdN+/eGmg6oOUVRgVqfDHMvxPPF3unhVCO953qlDSixYLl6rXDFep?=
 =?us-ascii?Q?pCDi2kjYmtcBm3mkAF1djsMHU232ksW+P45VDoY1BxlVixf+UBucdFCvOWqX?=
 =?us-ascii?Q?3jW6/fJA1v5KbORRFJwArhJgr2Ezsv8va8YWr2zeKjC0Y6JTCFC+weQbhaw4?=
 =?us-ascii?Q?Ta/YbRpOenv+4WGiF4x++FrvInTAXWEtwBeNPOyM9HbvuXR4fz2fNLRJ+67S?=
 =?us-ascii?Q?qtCGP/t7TjTm4lPwZUsSTScW0OfJRcoD++2J0xPGjgHerWjVc+bRkpNzJnRN?=
 =?us-ascii?Q?UJXxU9MrubDiqNo0qd0RMkLU4Ve1S2wMh1dP+c8qr7jHa+lOHrpK8aXhQocj?=
 =?us-ascii?Q?W+tEojknHHj2G0NA3eWiaPc1GskSNcPOqK4kHxZNaz7UdQnjU5e/Dt6v/KKt?=
 =?us-ascii?Q?jnlTs69rCobOaHRoObrp+I8mTLiipCbcVafTuUu3no/wbV5HQXErNE2jXVUe?=
 =?us-ascii?Q?jKWhu6Y86FTCzOjRdT9xhfwRHHdXaM2bv/IHIJyv5/7lODq7KStxfXi6e4hr?=
 =?us-ascii?Q?XkiHEr9cVCX3fQ1lB78ketCuwlUYetUTkWEvifPCb84fPp+lGBy0BXoRovIW?=
 =?us-ascii?Q?d7jJ9nz08FrqpsZKoYSF+1yzUQSyfK0zBryuokB0i2gzQb+Qa9B0umNgFtD3?=
 =?us-ascii?Q?BpPIvY2iCePjfp+nKyBS9eCwo9x19SHnH0YNQh3k8LsuMgzwCHYRTBilnJRo?=
 =?us-ascii?Q?YFhnUdyyVGO+QfAsyyBdHLYOp3s3HQLDD5iuFeFVH0ePSs6BqrG82g7eqqH1?=
 =?us-ascii?Q?+AG54tAXxra9g39hGtk34WqHDfQYYCREmnPo1vgCClj9LCgzvY/K5yFCp/i/?=
 =?us-ascii?Q?As+QiKJuMt+9DTLFR8sGoImBMS6Vi8VM7er2D4BsVZgiKSkrwx3FDo007NuF?=
 =?us-ascii?Q?axSTqGotYZfjvZdAw//rOCmus7fLuqRTFbqfYT7tN9Ek3RaQSUx3gJ4Mx5iC?=
 =?us-ascii?Q?hZ0BZeZPmGkjjq8/YOHWwxLps3vJwrvSlP3NHmQh3qxTuZOlLTZZRF1jwipU?=
 =?us-ascii?Q?uG7fgNTpEab1PTy33D/DUU35I5VwhR6rZ5eTDvuJualRavzODJvBrEu0xCDL?=
 =?us-ascii?Q?mDdi3oF2EWD30w93LqcTVd1zHayPV+BwX6PNn0WzXJ7B+ZgetOn00inrYcdl?=
 =?us-ascii?Q?SDbTmrTK0dQUW4vYyVIxe13I4MpNxBj65egcQhbHSkABZrl6E/xSEUUww6mP?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18761b38-24cd-413d-0f3f-08dd6572f1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 16:44:11.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1C29kysaqpjAmLYLU5QZTEP4PtWvRi4BVy88AXCtpm6YyrQLDslBLF/+laIveYPf6eAj60MU3zDQL2wrrFWcslMG+EZzpgd2dDQn6qzBDvxwV8sebrPio4Ud8abqivB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB10012

> Hello:
>
> This series was applied to netdev/net-next.git (main) by David S. Miller =
<davem@davemloft.net>:
>
> On Wed,  5 Mar 2025 23:38:40 +0100 you wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Hello,
> >
> > Please find the v7
> >
> > v7 (03-Mar-2025)
> > - Move 2 new patches added in v6 to the next AccECN patch series
> >
> > [...]
>
> Here is the summary with links:
>   - [v7,net-next,01/12] tcp: reorganize tcp_in_ack_event() and tcp_count_=
delivered()
>     https://git.kernel.org/netdev/net-next/c/149dfb31615e
>   - [v7,net-next,02/12] tcp: create FLAG_TS_PROGRESS
>     https://git.kernel.org/netdev/net-next/c/da610e18313b
>   - [v7,net-next,03/12] tcp: use BIT() macro in include/net/tcp.h
>     https://git.kernel.org/netdev/net-next/c/0114a91da672
>   - [v7,net-next,04/12] tcp: extend TCP flags to allow AE bit/ACE field
>     https://git.kernel.org/netdev/net-next/c/2c2f08d31d2f
>   - [v7,net-next,05/12] tcp: reorganize SYN ECN code
>     (no matching commit)
>   - [v7,net-next,06/12] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_e=
cn_check()
>     https://git.kernel.org/netdev/net-next/c/f0db2bca0cf9
>   - [v7,net-next,07/12] tcp: helpers for ECN mode handling
>     (no matching commit)
>   - [v7,net-next,08/12] gso: AccECN support
>     https://git.kernel.org/netdev/net-next/c/023af5a72ab1
>   - [v7,net-next,09/12] gro: prevent ACE field corruption & better AccECN=
 handling
>     https://git.kernel.org/netdev/net-next/c/4e4f7cefb130
>   - [v7,net-next,10/12] tcp: AccECN support to tcp_add_backlog
>     https://git.kernel.org/netdev/net-next/c/d722762c4eaa
>   - [v7,net-next,11/12] tcp: add new TCP_TW_ACK_OOW state and allow ECN b=
its in TOS
>     https://git.kernel.org/netdev/net-next/c/4618e195f925
>   - [v7,net-next,12/12] tcp: Pass flags to __tcp_send_ack
>     https://git.kernel.org/netdev/net-next/c/9866884ce8ef
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

Hello,

I see two patches are NOT applied in the net-next (05/12 and 07/12) repo.
So, I would like to ask would it be merged latter on, or shall I include in=
 the next AccECN patch series? Thanks.

Best regards,
Chia-Yu

