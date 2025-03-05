Return-Path: <bpf+bounces-53426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02712A50EDF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8351892923
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF6267397;
	Wed,  5 Mar 2025 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pPSE837e"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85551FCCE8;
	Wed,  5 Mar 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214429; cv=fail; b=ic3zFGUL9A3ucIu0mcN8tlDa+ZQ22thzE0yk77squ6x7x1QoTX2ozA7ZS1OFxwSHHjJtKH0oaa49ogEYQZptFMFNIDlDPUkHRkkgYsdDufbZkHmq4q0LbxLc/mS65jZW/YOiTXbz1mc+EPdeXMx8+aHcJo8PNQfirEk+ZxUL4dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214429; c=relaxed/simple;
	bh=+X5WVHDBshkjcJvN/uDgCu1sS8fZsrtES9i0yaideOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qV+T9IicQYBNJvRlCE4Fv+ahsyegxa/8+pOEtcJLs57Sb5DYGLTu4mBTMyFSM4hBzgzHnBqMQmbQ68lGVCVfNvaAEmcN3aJV5+snoYW5AV0POjVpicrOPK7PsAMcYCGkXsBBq9SFiFgI2tD2LQP1nVfvhDks2NJujdNgz0GZbGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pPSE837e; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1UORMM30PrvDldcjeUBL5QomiihdpgWAPOYx7NLeZbeWMGYLnQs66N6dxpZvAekgqrzrn5n5B5L+rW7mwroavshnUGeb0FgoKb02hXrE3mWkQTb9Zd5G4KEY6Ifdyfo20+xKGKc3rvmZ2dtb0FQHYPpjMdkP8AkRlreuSMfaKTn/l1QP0GLFEJoojWAL2pvCzQgIdc7V5YotQmgOQTesuBT4RtnZF4W7EPdrA8LywtczhraPj30ByUdWUaCXJ1gAsOwL2E7P2j/aX4gyIVjEKZjmD4O6wm0O+txzyKj6B1GBYFZrRTCic9adLUWgDWcZBebvuL0JnRvVqFnRhQgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMzrOeA4fthIzz8/CLwB8OgtWptSRc4ooGtW90WQnso=;
 b=QfPYcTxIhFVr/+K4JO6dg9MbQuJ5FUM1h64a3i0yTAL4WDYnfPknUVrrUdLmJY7Y6vm/iVmmKx3Fa5PmM595D0lWLBv1JvfXqFSB5QybVKXnwqJy6naDkg09jojL3dqHVzJD6eLlV5pe/PGYPq9wwSyrHK0+gvChj0rYye251y5fmiknaJYqk7EJMm1InfG4VTZMlqkTZTKSH14uwkfC08HYoWE7mjbKhGn72geOD4gNpqUcgmBPO9gVrpXB40heV/O80o95naVty/9mxMkEZKdAM1q6G/1YTsMiwlFn9YeXV0xMIKcGFkfaa4OOwJlnTxLtdd2Rndoeff09Ijg+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMzrOeA4fthIzz8/CLwB8OgtWptSRc4ooGtW90WQnso=;
 b=pPSE837eLm+0qDYOkbLwjV5D2hmIpWTabzzeisPM1mp9FWem+NRd7a1Qald3as7oUTvAOw7tTyqndrrBYBxwA6iWkYR+slXpzYhdgsWaLbU9vZBotGke7rjUHuq7MohwX5M0Q3R4L7oS6aH5f6Tdy4stm+3QcONwUkjlmWMnVYwuaxFmxH7+uNnmccV7l3dZSORmVTokHc/tpstEVpDOzKTKAsyQnRW3mwiHDgijdn7fBsZWlP+oknkg99thfFL2zRYtdagGy6sVclymmwRpRzDYb6JQbplBx+N+tgVd79Ep3RYWiuw1mX36te3o1GJ53G2Ogoe0yI9/OGAErzFSzQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GV1PR07MB8366.eurprd07.prod.outlook.com (2603:10a6:150:21::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 22:40:24 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 22:40:24 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@gmail.com"
	<dsahern@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>,
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
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v7 net-next 00/12] AccECN protocol preparation patch
 series
Thread-Topic: [PATCH v7 net-next 00/12] AccECN protocol preparation patch
 series
Thread-Index: AQHbjRhflAruFXHg10qYwLWNb+CCQ7NjwsIAgAFh4NA=
Date: Wed, 5 Mar 2025 22:40:24 +0000
Message-ID:
 <PAXPR07MB7984071EC55810F2E7CA5674A3CB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250304151607.77950-1-chia-yu.chang@nokia-bell-labs.com>
 <20250304173236.717ad5b5@kernel.org>
In-Reply-To: <20250304173236.717ad5b5@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GV1PR07MB8366:EE_
x-ms-office365-filtering-correlation-id: 50d245f9-e8c6-4efe-3438-08dd5c36b800
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pfQLQHIkdfc45Zk+cFyM10DwfwLthbyJhxPf8psS5TITW6tdhka4owszuap/?=
 =?us-ascii?Q?9OuJGgpqxcNMFuz0WIbpOYsY6XpXSq4a5q03NGzhrGctoWINZCSqQBOVAWOf?=
 =?us-ascii?Q?C49SIdMMBTgI8nVTNA2u717bZ5gEaL1t3HMINezFLjr8yvgbUo1uAOZSOTXc?=
 =?us-ascii?Q?SMs/FHycsU1SaMfzKip8QH5/2SNeZOBPR+PTnByFwx7ULYrI3A1nkd2VnaZg?=
 =?us-ascii?Q?STxBmWt5Cueuwd6XtFd0IUZx0uuOv0m6KhqZDT6xCYUejWgIkqxG3uD9zC0A?=
 =?us-ascii?Q?Wg9UoyP0i4U2E/ntdTwLd+1CHeNlpbD9rUiUWouCfB5DZRmwTSGh3OzUB/I3?=
 =?us-ascii?Q?cmSw5pRlCEXmti8X1COrZyYjtkqW8zn3HIDCOLWYyeVjcNb1RE2UOZrJcACb?=
 =?us-ascii?Q?1XCteErSJJDwv9oIzCot/oYUyutpCF6BCX9e3DJpjWDVrv5q1oCSaD3lm+06?=
 =?us-ascii?Q?IzlsLl51h0v7YA8HKo2ZuBCjkApPzMbh/gjSSrtEfxdX/baD87WMYFojEokv?=
 =?us-ascii?Q?vJz/GeZqQDJaKnwPyM8EBMc0crE5jqTFTwkiIbmyNI2al0QmKlp7iFdo5ZZM?=
 =?us-ascii?Q?w1L+MYgSy8YtdCf0S9QzMO9zFg9VsaBg0+o3C3WrFKVnzKVTuyhIPXST58TE?=
 =?us-ascii?Q?lUZmLMWQUUf27NkZ0Pmg8MAZxTYo8eey+rQJZnO2w/HVv2AhrqoVVh2iBKHX?=
 =?us-ascii?Q?t63bTvwVJ4nBPSLZozthyaVgCiEKlWkX+LMxp+qLuIUNMxbUYnt5yhT3h48r?=
 =?us-ascii?Q?mKO0Shp8jN/CVUpZNGgC3SjTr2ImbURvUgxbu6Ov57vBS8bZgZZpSUOrkyPJ?=
 =?us-ascii?Q?Se3Us3PHR+jtSeE0aVYbhYDK8h4RJ69B9P906T0EOgLELFJyvsPWHmxAqr06?=
 =?us-ascii?Q?h0DH+lpo5CtASWi5DzWuf/6XCWFF0BoSGcSL/LPiNM7kfLroZ8vOU6RULgnV?=
 =?us-ascii?Q?9RPITc6GNRvQ4kPaaLxgHHJ+awjnPgGPNWlzsSTqfhhzucmaXIH0Nz0lvKJ1?=
 =?us-ascii?Q?oHr28I290+Tz1BhmMZdsPhT6c3QXsKp1eZhJZVREi8lrHCrMnTdMG7NuhWCi?=
 =?us-ascii?Q?AwMe5JuT1b0oadQ5AgZk/ii2U6BbZ6OCX/e6weAwTzQ1rg5pXZSevvrj6SQS?=
 =?us-ascii?Q?6opA0r00O6Q/wMPsJkqmhgo0N/0ovYpbDcNXiXnEWwhwNC7G0jXH2Z5nD5cB?=
 =?us-ascii?Q?ebcFIlwFVuQzvaZuOgfC8jkYm9ug47srvZAvKES1TMIS+vHzWbhdDJC84+rT?=
 =?us-ascii?Q?789F4CuibdaHVb5Mhgzk/sHWjGBelX57UVjFJtIwn7apV41njfmSc0vofApD?=
 =?us-ascii?Q?A3LycrLmjz6VrPh6LSLmAE+q/PySXUiBV5NrgsS5GRz++E9MjQna3s5L2E1f?=
 =?us-ascii?Q?4eQNR/iGLI2ZsxRj33gWS/KE2lVwPpI9RHztvGnkzZay22Bvbg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3YOgTwYbJml6tY+r2kfNJfbloCvmaE0G0GqcqErvVsdbAdMwHRwTIGajEFmK?=
 =?us-ascii?Q?3NOGHk0oV4Qe3OaHi9+wyd4wZD7BG8vrhp94p+xY2CKSYJrawDZN3ueM/sFI?=
 =?us-ascii?Q?bAmjlFhsAB8GY+DEg1YWmMOdoeGDaQe8B62aFcpzgfzuR4xQ+lpyPOn7paSO?=
 =?us-ascii?Q?kvp5XMvUcs/UIqgT5VIwsJRWwOVhz6xd//H8Y++UbJ2CKYxKlSS3VupMai3S?=
 =?us-ascii?Q?53r1/EJCV93Nt9v3ng8e1HMLNHSWI9SQSrLy/T8j3gKNfrPpTZbEhyv+wyHn?=
 =?us-ascii?Q?KlLbjQNmvGEcGq/YvIL6ItY5H4Bl5fe9MgJyCEeK8X5lLG7EcrK4Tx3ekdJB?=
 =?us-ascii?Q?hB/Xlr0RmAc+bM9zG9NCRJXdtMSGTQJDsfEP6hit8utn7emQfhXy5REooRxC?=
 =?us-ascii?Q?UYXYpYDS2mbYV99CMy+73KzfZwJhgaEmMvpb734D6kngjS23OWuqVpB+TYBV?=
 =?us-ascii?Q?zuFK4GxKcXPvelZ2iWjbvg/DxZ1uelfqWra46PvSWIkI0gJpeyWQzopIA/Xm?=
 =?us-ascii?Q?XVOGLoh4YMLJdivhxIzOlulzjELSPrV7jbvHMN3XK1l4iHUCfwJHHaGuuvTs?=
 =?us-ascii?Q?7PYQP7iftwfNv3T6AtNS+AZjLItoiEUzyFuByMaSah69TQ761WJmKyX41c9+?=
 =?us-ascii?Q?fCxXjGkZoRzTfQ9ECXpBhRYyaxkpIVV8NhEHq/QMcRB5pHkAh2/m6deYmo6b?=
 =?us-ascii?Q?KHIcsFXW32KF0a7akAiisgNceLgkWi7qyOincpZXuA9/oIZMXkZDQJ/Kc8p1?=
 =?us-ascii?Q?NDeOXs0+trb+Ln3UsikPStKoaCVKJ+va6vhSQSwtPuB8sK0CIxi4vg1u5cX5?=
 =?us-ascii?Q?A5E+UwXWmpSouhDIjboYzRvEtPplQrm2mdBmn+upsvUXz6P71A19TgC0BX+J?=
 =?us-ascii?Q?t7MTiePRnxtaqnZEwTzkCBCc6/6q1XMTHdu2/2y0yTKEa2efiDkP0rbyiRb1?=
 =?us-ascii?Q?GuI0onvaYKUuN4ZfMGQiDG+LFBADn81t95IZfrGuIHJ8pwcrHBHMZEmCpOsD?=
 =?us-ascii?Q?JhQGPdD7bOyBtR/63JzSj12VkDjIhe0FK+IAPwQScCpNY7F/nBV8bzEDf3HF?=
 =?us-ascii?Q?reTLZ7N1q8VmA81cT0JJWfCpyGbxdYlOWQQ735oDQfOyqqqIsikqEorPGsEr?=
 =?us-ascii?Q?JJyycI+wIWzjFs1eRS+f7flP///Zz6d5aJ2iOCwY+DxoQI9YBagZWoTKdOrq?=
 =?us-ascii?Q?8QvsEcyqRwlWJgXEBb0RWlYusZV94ah/LaTbxc9AM4j2aXu1zKLDLsB//ZsJ?=
 =?us-ascii?Q?YUFuI9xlFBWWBm/tWIcMnnXCaviMk80ylkzRI6fu3sDR5Y+XLG/8wbLflVlZ?=
 =?us-ascii?Q?uAlH6Qy1ftNzE+SFEzJRuZY3XeVrrrMKk3F3Hy03IyG+bojbriff31Tm+K6b?=
 =?us-ascii?Q?EYCUOVQio/6GQH92EfcVxcHyyGhpa7Z+6zTfKMoBCjXNQ5A78lgA8jF9KeKa?=
 =?us-ascii?Q?GqYrWupSR2vaEulQEBUfCGB1uFzx665qMx2f+chn3xLkM/nTCE7w0H2rSA5D?=
 =?us-ascii?Q?NO+m4QV+dRItuluIdjf38K6FR0UVFnn1EhkWJjIC10zll/dLKDhmocLy0Qlh?=
 =?us-ascii?Q?NJSehHa/xAdnCMI/ePEgIBrrAWgzFO/vwEceEmjlrOzs/UqjtrbJiQADNL7J?=
 =?us-ascii?Q?nw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d245f9-e8c6-4efe-3438-08dd5c36b800
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 22:40:24.0973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aqx2CyhzFTr9aH+C10Rsf8MHcRS9qVGRVXqigss5m/UtoV4TmWzFGG4jg0Yw25J2dbkyMnJv9z02IxV8rFDhEgS+x3QOgJD616HNHkZWIQ0F8uMMbycAiB3rlRsntcH6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB8366

-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Wednesday, March 5, 2025 2:33 AM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: netdev@vger.kernel.org; dsahern@gmail.com; davem@davemloft.net; edumaze=
t@google.com; dsahern@kernel.org; pabeni@redhat.com; joel.granados@kernel.o=
rg; andrew+netdev@lunn.ch; horms@kernel.org; pablo@netfilter.org; kadlec@ne=
tfilter.org; netfilter-devel@vger.kernel.org; coreteam@netfilter.org; kory.=
maincent@bootlin.com; bpf@vger.kernel.org; kuniyu@amazon.com; andrew@lunn.c=
h; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_s=
chepper@nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.jo=
hansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs=
.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
Subject: Re: [PATCH v7 net-next 00/12] AccECN protocol preparation patch se=
ries


CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



> On Tue,  4 Mar 2025 16:15:58 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > Subject: [PATCH v7 net-next 00/12] AccECN protocol preparation patch=20
> > series

> Please wait 24h in case someone has feedback, and then repost this correc=
tly.

Thanks for notification, and I just resubmit v7.

Brs,
Chia-Yu

