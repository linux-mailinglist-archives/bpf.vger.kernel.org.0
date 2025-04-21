Return-Path: <bpf+bounces-56319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45287A954F3
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F35817241B
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89651E2845;
	Mon, 21 Apr 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="EwqSq4hp"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9D1531E9;
	Mon, 21 Apr 2025 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254338; cv=fail; b=c/4n2oky+LVVx3+JFk9Qis/5q9WR2x123+GYI1DAUM+AdFV46SN+XRlWC+eEQXfi0Qfsr7jKehLfxsaVngFaAOjPpFD+3eZazLOmw8N1cNFWMDgVo/QG7L+NE+IhAxSpQEtJk4KdpOrt7XDd+gHrVjS3/gWX5CXEChBFG5J3dR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254338; c=relaxed/simple;
	bh=Zfz2/veScDfDLBwUqQ1JWWS3to4F5DXP7VMv9td8joQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iF7wYj9ihtVNpmz5USyb1IRHFFAvHh4jt3gNHJ/xGcG0CtT1YMrb05Xm8Ss4Cc3vlvjf7nM1m/CLMWhXduhzOOyxsyoo6L0Tx/wqIuZDoux+UkHNdC0DasWZZ82KvqMy0Rv90waH1GcGGV5yXTY3f7/D84g7BVNDsCrqZeNQhoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=EwqSq4hp; arc=fail smtp.client-ip=40.93.194.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ny5RsBKyy6wKr/DltF3KZKPHs8KDYv6zSLw97G2giioCQy4RxLSfP1yThHh+jS9Ukf30dJmuFfAJ++qB24LExy6UfOPorO+rQ31bQgKh9uFi5vJDEo7uYiRhn70hwnMBxjH3zx6rxHdVKuQOYbSt2+AJIZAq5EZbBcU6kS7ZW4OPLt6jW9eiu+MQyNEz0XZl4eZ2+9MVBF3FahiP33rBI9DNGl9qWbrjKbo+zo5uRQvVzs2Kg4oeDW5oSKWChns8MV3LquFB41aqgF8I4wW/oR/9lcCcBjWBSYpV62TGtdSxPAmL2uDulkG69w9fTGYMyBwjLPgf9bT2eZbIrz0pUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfz2/veScDfDLBwUqQ1JWWS3to4F5DXP7VMv9td8joQ=;
 b=yaVTJT4wF3w7yQfK53BiW86Y0CHptxxM/12doruvG18GdumJkKIjGvIuqpNUwsp/HkRtZy88Mym3yRCfh0gITi6IkOcuVb42dfyCuTjuz61lbP2hXrbNgAEo8PU7NLzvzF8mVdsj14z9jfQL72psvY3vizmq00cB9kj+ympHk8u5AjmcyoWZ3UsqO6mIM/OoAW9eGUSb7KiLt28h8cpzcZekygfBQdsSm+2gxamOSAAubych1MXqkyr81sqz/BIECEt3TeZycxrhT2PEO33/DJGma9OG1a8LoATY7dZAUDY9z+ToQlvh4ubwbHDxNsWTm+5nd/OrW4J2/1J8Ie+Ypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfz2/veScDfDLBwUqQ1JWWS3to4F5DXP7VMv9td8joQ=;
 b=EwqSq4hpBMHc8NbC5EwvtoAL+c1aSVJoRgfh112h1fd2U/BL1LZkpQX/ReDoQ8ru/UzNa2SIk23JDagnpxI8nE+ZQBygFHzqUsATjl53JIy8h/8L18Aqx5GU9TrYwKE355r+7S2O1HcacZrrM1NhqOs1i/57nTZQZqzhE95y3shK/wXyYUx8iS+w+JzfYKR7PzRlQEnTwA2XT6k85r2BrWes3fko84WpGiDmOl/mOgCrzyaZbvaqEXOeNqFRZHLEb821QyGhltUc6KONlwYO+iOCZXxxIS36eZeeyMi/+8t8DjC/V6tNjTUf9IG3cfI9EZvgYnp0vJhEYZPvi9tVfw==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by CO1PR03MB7818.namprd03.prod.outlook.com (2603:10b6:303:274::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 16:52:13 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 16:52:12 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Simon Horman <horms@kernel.org>, Furong Xu <0x1207@gmail.com>
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
Thread-Index: AQHbqF534FzGLRNwp0yA1XNTHIr18LOckb0AgAIaqQCAD7zwIA==
Date: Mon, 21 Apr 2025 16:52:12 +0000
Message-ID:
 <BN8PR03MB5073FDF1D834404244D50790B4B82@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250408081354.25881-1-boon.khai.ng@altera.com>
 <20250408081354.25881-2-boon.khai.ng@altera.com>
 <20250410161912.0000168a@gmail.com>
 <20250411162708.GL395307@horms.kernel.org>
In-Reply-To: <20250411162708.GL395307@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|CO1PR03MB7818:EE_
x-ms-office365-filtering-correlation-id: 5a4952ac-61ea-485a-35c3-08dd80f4dd4b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w6kug9EK2InvDx21TiOrzFX208cvblQrN4SEVxK7eVRY0xKdzrI/9EweBiMp?=
 =?us-ascii?Q?J0avKnDLUePpJ3a0uOj0OXUAn+tMPgQWvPYYahybMcHDmFhR1BUWR0gWhU/S?=
 =?us-ascii?Q?5hT07CYhy7WT2KaCcWYx1UbQt9Y2uMEzJ9symawZ0SCwQAEvxYiWmNVKbWje?=
 =?us-ascii?Q?yrQ3dz/g7Cf2Y4kLmSKdrJydB7voSE3JJtuKFkWikxQr8WuHus/JMVIhvNO1?=
 =?us-ascii?Q?gDrlD/fDbDgmWDuStMKpOVuPYCloGYxRbbXzjk2oZzFEm9IHOqAoRV2fcFF5?=
 =?us-ascii?Q?MPX+KLjbpFu45ru300+duwmxRsA0Sm4BOaLUrRB6A2LoP7iqXF10GzZimcoX?=
 =?us-ascii?Q?nnQruemkq2a8xnlJXHgSYkhV9dHjLbZzhmvP4fi+xy4HUZeqqAf2FgI0ZusY?=
 =?us-ascii?Q?b0LJsTgn0+eflzKD0efmtOqXylYHLn3DQbpXfDNkTsLIFcDOY3MlArnjwp1n?=
 =?us-ascii?Q?eluBj3Hbgc+cw4qhAHpUso7j7STsKp68zlqI3Wrbc28YjZTZle45+YFPmRLg?=
 =?us-ascii?Q?C6ppnPYqmOWp/BReV/+aBei/8eKtj5oHRGurex/FFFw0CuW+f2QaTNcpRP9U?=
 =?us-ascii?Q?TjffMq0I/t1OMMArFT1gPPeFUUGFEdWUAGxVwtRqHq9e/C5V67proy/iOg9z?=
 =?us-ascii?Q?ixVzLL3Vd2qns2DlXN8hWmaF2S2a/O6PVA1NvPyPgTePuc0qlfI6Cz3jmIN0?=
 =?us-ascii?Q?ougPdj8fCSaGpxQ8uOJUHQ6NRyDUy6QQm5WroTcFKLm2KuRxHl4bXfpez/Nf?=
 =?us-ascii?Q?/tyc3yq7dVo3qDKr+VGE2VnJl9cH//HE5Dm/QKj3OETxZxkok5caYq00yXY3?=
 =?us-ascii?Q?Fu0EJGNthiiJ7Y15FWTEjPu71PsfbijdWdEFIr+DxEHZnblimNnf7B6l0Fxx?=
 =?us-ascii?Q?I5Dhw7ryCejpReHzNJzIfrqQycqRri94CR4b3IaqA7nznCY3vmTcWL04fD7W?=
 =?us-ascii?Q?6Vtti96Krv15Iv6gT5pmObULZKsg4N4SdK1hQlsob5r3wW6mwvdtIPQVW5g3?=
 =?us-ascii?Q?2f0DzLdaJmFdAOHW+lLj6yB4vtNbhYDxr2LFF4iA49UMrQGrfifRsrhXyUrc?=
 =?us-ascii?Q?gqcm2YMKWsnBSwdMKdnnFZDaG4VsY4k2rKmJvAtXhSm7bkqKJ9J0xDcLuecE?=
 =?us-ascii?Q?NyPInWh/ep56FtuY535dIYZjMhLfAASK5Oka4WkiVyptW+KgN7izE1/BFS0y?=
 =?us-ascii?Q?QDwj6hcihPj/Brb/uHfmj+sM7xnF8EoIg19BQ6aVbToSa+W6GG28H29lMMfS?=
 =?us-ascii?Q?0E7atrJpX69eDfyhJyDEGDr3srJuwM7b0YDVXJ2cJUYlCD+YC/Natia5B/Wn?=
 =?us-ascii?Q?2P+tnVjpusIgRgr3+a5hFPMu/T56FPdGyz1Cscd8qfcrIZXYN8VHoaNKUSkk?=
 =?us-ascii?Q?mosOMHj5BaCgA0wj4HNi12Vu/5dhc2wFHUCvtwkVCzsnnfHEahDXDdWHoSNW?=
 =?us-ascii?Q?i8961BBSKbJvQ4XC+NWUYa2XxPICWc6rECN1cVmHQPFtEkgNvK9Atg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4Kj8ETH7qqNi1+Bq8EzONfIDwVzMrwTf1UMQrorHUoem0LvSc6CtExcuWVds?=
 =?us-ascii?Q?65XcQGbGQDVsl/KdLxf+i7wKCCnzbA++B0EVqh5xjUewBUyjPSAl47VB+ah8?=
 =?us-ascii?Q?VW/ci0Z97BMHfD7l1c1UZREWh2OhoO25fWRoPOPUfGaVpRnSHOlQECZFzQM8?=
 =?us-ascii?Q?NH7fgoM54h5vrLRM8eqE2UiDE9RtFVSSWyEzVsO98cGnzv0+0N+dDC4XEKW0?=
 =?us-ascii?Q?Igdu6OK1LEhyVeAh26h1488r65FlLunTxAx9u+r3R26i5MFgC7IeZ6BY66Wc?=
 =?us-ascii?Q?pkdIJ8Bn30/Yx2PneolOwbiyWmNQuAdYqnPeP3UCshoIqyJWggb28RlnAxM7?=
 =?us-ascii?Q?+/2HbgxZWOTsKBitATElu6jNPhcRk0oVxukUSHH6MA03qPhGkIRgu+ZAZ36P?=
 =?us-ascii?Q?HeGhxWFjOR3CW0dD92ynpqm252oN4mHkJ7JSmTpM5Sqy+Wh0n4EoHLVKP/ci?=
 =?us-ascii?Q?zaPQUS+Q/jgqfPENXZiQ5xvT1n/KIRu+jEjwDDej3BTpmc9t2vtoqdljYAro?=
 =?us-ascii?Q?VONt4oFdy8AFU7wetf2qujDfIgt6AG9OIDAo6iqvqMIrttRMou/yd0a0UYZ+?=
 =?us-ascii?Q?Zm1dSp5TdMs6B6eojeT98NTN1GUEFTrSvtzMmlh4yp52cfjBjLfNYYCvhBPo?=
 =?us-ascii?Q?0L55cI5aZKQ6o4HU6pUvBlL7iPyT83D/ADQK9uNpoOI7Gj/f3MI+bFEY1HwU?=
 =?us-ascii?Q?2k6kETGvA/imWOJke7Fi+bjsoXgTo91x5+4Lpo3DyD8A8qVhPqKIDnHly6f1?=
 =?us-ascii?Q?HP0Y1OHJG08EKb8lY31znhrjcjB4kZGvq2p1RUpLD5Gvqw/yvFweRaPhVGob?=
 =?us-ascii?Q?p+sKUniyNZRR+tj0x1Z7HkJjtHevyYyQMnlpZer2mF4hxee4mKbngn9F6zpU?=
 =?us-ascii?Q?g3iwWpLYANdXym/zmNKXOmOZYmynQuL7NOd6KHCvMg/OQE6p72gCDyTQTFTo?=
 =?us-ascii?Q?9rRMfzX5SuMR7QfiBXFagxYhM71S6KzFB0Rln2b7a9eOq0YAZtRi0HqIC4IU?=
 =?us-ascii?Q?oaJ02azuMjQ5TMO9CBzdGLX0DQ/82Jhg6c2J49p52wD7gwiqeeBcHq6UD2Ax?=
 =?us-ascii?Q?km+nH7p36Kkh5kOrXiMcV1yQsR5i/XJRfLGn4XThBd2PyKmslOwBNzjGaMD7?=
 =?us-ascii?Q?ssI1tjQYYChV1e/ty60nA2klHZE82qbMTVDobxAq0ES0XRKMzqKANe8v8QFq?=
 =?us-ascii?Q?4FrcVbNRu6+UkOOpnLKU7L9JIb5LpCvFvofNEpk+FEikoYUY3wS50675DQsD?=
 =?us-ascii?Q?L1RAmG+HH7AHub0AddoFxQcmyHr42ch+oAutCS5FoIANRbl+FvrBvWQOgRvR?=
 =?us-ascii?Q?aUzJXLQEAcHP5a+p+qRprrasdUIZB+ONCNEjQ8TOO+/r27881JprDyj1DYFY?=
 =?us-ascii?Q?vyHIM7dOtzfY7N62CFH38CUR/a54F053e33xs9LkHr3SGQoGl0RdIpS1pSY8?=
 =?us-ascii?Q?h1oNOL+uLtVvUM85lZQYFO0wmFt8Q73KjGRUyoXE1SHc22FiZ+aJoWIec5NL?=
 =?us-ascii?Q?P4YaGrrXQMHm8PjDqw6vT4mGpH7TnYVpI7bVJRvA0YHOMIhMX61nJZgFb3ov?=
 =?us-ascii?Q?ek8j4LEmOQiRNQ+3DBPKvq6wjn6OucJXVY6iVpUJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4952ac-61ea-485a-35c3-08dd80f4dd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 16:52:12.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuyAkAz1EkrvPl5oM/EHg0or3q1EAR3nkRC0obZWw611NCfTf6wOSEpnNDMLbTcnBAu2w1M8lt86DR0akfWEQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7818

> > I can confirm that 802.1ad (QinQ) has been broken on stmmac for years,
> > and it will be so nice if this refactoring includes some fixes for
> > QinQ
>=20
> FWIIW, please be sure that fixes are separate patches from refactoring.

Hi Furong, Simon,

This refactor is intended to combine the VLAN driver for dwmac4 and=20
dwxgmac2. From our perspective, on our board, we do not actually
use the QinQ feature of the xgmac2 IP.

However, I agree with Simon that the fixes should be separate from
the refactoring process

Regards,
Boon Khai.


