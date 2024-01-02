Return-Path: <bpf+bounces-18769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99371821E72
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 16:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9F91C22483
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7592514AAA;
	Tue,  2 Jan 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stackstate.com header.i=@stackstate.com header.b="qF/jYrkr"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82114F72
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stackstate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stackstate.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzVFRpNuEekyejh1Q3Fkd8JlY+OdkXW8yrCDWbtWCjwiVSXBom/iA+JFrsCBdrsjPQz/RluN9q2dQGBtanqh/FgmneOFfGtW/ryS7TSzWOxzaHYSKMR57Eoqez84OT9wkWFpy+WUVim8Y+AcNVn5za981Z1p/RtD5X5rSHEIvOwp7a3uZ5PWzSFe/PTzfLbfgRJPx5WYlIu2q7V/Or6ITj67Fx59vnVgFJSJg58UwJ4iatBDY9BtyTq2+WsYj3p51YXyKaxmAMK9N4scQOVxWVYsFI/bsXV6NeQLwQGQfznmhHQu9L49C2YGpBRUAVYf5+ECuJebXJavlRxS5d+2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zkkr1q2Pkbv2XbQZyI/kt+X2kN2j25JtuxjUvtSdGrY=;
 b=n8ap8AX0WwhZFKYfWJ97qMrldcgdAQ0cHBMaVQITzC0ZtVM5X00uKVO7fZu2Q22qAETXFciTH7TbkZpicfXLwYyZKaod9TIEnEguaCGsFPrD+pPbKNan+hyz4PUV0bN3c7ZQbPIStXJd28rv2T/gGqLaJzSeXp5xw82rrDtMrqsAFZ1cfGHBjxSibVvolZSkF2FPgq7CPqI2o10cLtlhetkK8bT7BpjuJsVODBG6G+9LV+5s1vl5oufbcEiWSdQLvtrZs4FzbZ0m+ZUj3wwUdZu2vRK/XbsW2ioPDyvAoyjHIioqew//fqU8hGqiTpclfCwFHFEFqSuedFCKulZGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stackstate.com; dmarc=pass action=none
 header.from=stackstate.com; dkim=pass header.d=stackstate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stackstate.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkkr1q2Pkbv2XbQZyI/kt+X2kN2j25JtuxjUvtSdGrY=;
 b=qF/jYrkrGjLj6C81qvQnwBetOuB7SzT5NQ/HfljJPOf89CkzowaGR+imefKBnjdUDSBXgs4/4VNwIB1i3/OAXz07/bFuwUWWEV1P+1DkKq+MMT31XBbU1OJyZTeu7TueVb+V748KFm47ySXq+tQZmheTOxXxQByQEuKc4wwmKPas3dUloaBmL4sLOkAwTl8Yx7nWkhQU9s/CWLH4oswQt3InqGSekwhp39dlUZYkfz6QsRsKvOGi8ntWbqQeHF8IMszIvZfSwgCF3k0R0p4aYiIGWB+PiLtTmebJuy5nrT95fZcBiXqNrGvX7UDqnvvWrujVcMESZdskAtdJUBWqFg==
Received: from AM0PR0202MB3412.eurprd02.prod.outlook.com (2603:10a6:208:7::10)
 by DU0PR02MB8546.eurprd02.prod.outlook.com (2603:10a6:10:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 15:11:53 +0000
Received: from AM0PR0202MB3412.eurprd02.prod.outlook.com
 ([fe80::fc91:4e0:f8aa:299a]) by AM0PR0202MB3412.eurprd02.prod.outlook.com
 ([fe80::fc91:4e0:f8aa:299a%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 15:11:53 +0000
From: Bram Schuur <bschuur@stackstate.com>
To: "ykaliuta@redhat.com" <ykaliuta@redhat.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"johan.almbladh@anyfinetworks.com" <johan.almbladh@anyfinetworks.com>
Subject: Re: test_kmod.sh fails with constant blinding
Thread-Topic: test_kmod.sh fails with constant blinding
Thread-Index: AQHaPY0DNq9iX0O5Q0axNCPqRgWtKw==
Date: Tue, 2 Jan 2024 15:11:53 +0000
Message-ID:
 <AM0PR0202MB3412F6D0F59E5EBA0CA74747C461A@AM0PR0202MB3412.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=stackstate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR0202MB3412:EE_|DU0PR02MB8546:EE_
x-ms-office365-filtering-correlation-id: 6c307635-d43b-4ea6-49b3-08dc0ba5274d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Qq3n6nBMXtyZRIxp5rTPtJGpEuYekQrpyf+xmJhHmzyheuAj8V2qf0e7FpDMmZFdI60XumJdcG7mhWc43azGdbUT4IZUwXgK8EXgV5KHVr6kQ7EmL4/PjY5yB24cWX6yO/TnOYKzjCy9heje/nVfa5CfeOEmutqRHzkTp5vh+b2lUiyUZ8Bbh+PM2/Ry56DQkzEHaB8VHZCvzXqd6sM/53oTBpi+F6CN5i4QzGRsg4463puJcRMponRXR9kVTm9C0ik1io4mGt9UwaDDN1qunKcVMuCOwi4w6KgyE3gNW0ZTvQG1Z0bIODD7CipBPyx6XIyyAylXcz+3afxFb8zeBu3ut8XhPFYZpNRRJoyqmqW90U4RvZksypioZqOiZCWM9IwmExSi3OrrBfqHiIU5v3q6YuRK14q2XaJCsw4FHLb0ot1psWKdxLvpmaD6IQIgtycEO+w3KzVC1G1ttpos60FXaIWZT3K2bw50s+xDFiNBGQkTX5VcpW5wk8H4sFD/cYC8q0si3TapKw4jvcs5KBhxdz46kXukKtQHWWjtUFUlvddiP0s5dV4Q3Dx4GQNx1D+jUIdzGawOExkOgV5yu3h/Mwj5/nNsxk5cK5En+kGx91UVUkcSYcKFcM7MlWPd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0202MB3412.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(33656002)(64756008)(66946007)(76116006)(6916009)(66556008)(7696005)(9686003)(6506007)(66476007)(66446008)(38070700009)(86362001)(38100700002)(122000001)(4744005)(26005)(2906002)(4326008)(5660300002)(71200400001)(478600001)(52536014)(41300700001)(316002)(54906003)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zbDm6WOHJZ30sA0FAYXmqUltpeVruGqYS0NQHUxF84j7fzgfBPbH0f0iwg?=
 =?iso-8859-1?Q?atczqw6ThWe3Beye7pZRvpBli0UjSOvSgEI4xQxvd1UnbOBPgu17nncMGb?=
 =?iso-8859-1?Q?EC88HzFiLxha8xuzG45JSBqHwB0emwxZcabgxIWXRv0zhnHCaVa92GlCgn?=
 =?iso-8859-1?Q?e2aMqcH6ooBZQzWrd3XaV95xq61q7wx45ilHCOTkQTl+ZSGWIydD7utJnx?=
 =?iso-8859-1?Q?QPMj8j0T8wZHyvQHVvwynRA3njhYwYhPGirS49aRZyXOZ3H46SabsFfmtT?=
 =?iso-8859-1?Q?P7xBh//C9qBQvB6upSpniLZO6Wi3Rmcv2tA+MZIsZvDo+4gEbajpkqDUMR?=
 =?iso-8859-1?Q?VNHpqChx2y0HBAW2+KikM7rvbcH9xhjVgwE+Cywx1XuYPftSNirC1NVoro?=
 =?iso-8859-1?Q?7HGfIcRQQTZQGyq1FtLC8VcjXAuJAOXHudP6boGICNUdqGXTNZHKJClKZP?=
 =?iso-8859-1?Q?tnrQt4h3LSJBBDjp30S653ddk5zMVxjvjBAd1Zf8yjy+kVktgEjp4lhu2k?=
 =?iso-8859-1?Q?wRwI2VjhBaYRQ01E/oUU1WxA8fB+gxyv7t611lixQkZCucynL7E40ArJab?=
 =?iso-8859-1?Q?+Nrk9udeeiN6mEnUP9GRftWqAqY1IVSWfWMneA3CbjHHZ6NoWgW2BfC8xm?=
 =?iso-8859-1?Q?A1RMWp6BBo7BFOLjc6XIafQbv+Mwsm/6qj47OH22sQgNOUB4OtPLNjYQES?=
 =?iso-8859-1?Q?gcPlWezHXZqk6FjPn3Kh2MDOxZUWaM9MIqI9p9GA/Hl2Xn1PT5/mBo2MAw?=
 =?iso-8859-1?Q?14D50/YjRg+rvEUWmKv2d3BRVrj4bUvQzOO3Hdg/gVCyleEo/AfAFyTRtJ?=
 =?iso-8859-1?Q?5zIF2lfC0BUU+hq0Xl8qFhVTHjSUU4+ENubXWvdk/IK0edmfxADbMP6/3r?=
 =?iso-8859-1?Q?4/1O8n4wzxJrdNSARRZCK3oVsDqKmuRgkoQgUNDk4HZtoWbX9bwU7hHdhU?=
 =?iso-8859-1?Q?Y1K2O+fEdhsd2sIqn7S8eCNpkqtjAO1SzZIUcQJmSfgFxUc+mcbzfoF3U1?=
 =?iso-8859-1?Q?nWKlXOAfOYmyaoCF0h2HdjIj1OnadcJvPGLdBSwlabDRzVUN8looXp0DJh?=
 =?iso-8859-1?Q?HQ442/PsM+Z/DZhunn9KUGFHCZJeyX0Ky8GMrVzMMEtEmifrCgV4A6860O?=
 =?iso-8859-1?Q?95LjLO/n+ndjwYxNfIjHvivOr75tsOQxr6T0r26uy09SBDKawarTeqRnly?=
 =?iso-8859-1?Q?saLf83nBe249Bs9UDQNAtq3edxZOuTe+yI8f0o9pcrHPFfFIiT4BNqwUE3?=
 =?iso-8859-1?Q?jlqudpMkRZlNrCyB0jx1UMUSybeWA+gWbG0gs01yxhL4fdJH0BPZAh9ekX?=
 =?iso-8859-1?Q?AB44RLnbN3E8KV9w/KEWvX1BBW7HskzqvOCkhTRf+UGuDiy8UciHG+0Jny?=
 =?iso-8859-1?Q?szhUtTomD0xo1KPhSwR3+Ou4xJJopyPjIMnVTlV/IlvJLZCLBOJRg0n4fj?=
 =?iso-8859-1?Q?GO535tztf+wKOrkH8PjEG23MN63cUaih7Nub6R6Hw7IxQaRZ39wKf+sYvn?=
 =?iso-8859-1?Q?cEtspE7lqQdqDk2PRM8KMeLrlkyg/NhHmR3MZiCcx8h8qNNTZSOFKu4cDh?=
 =?iso-8859-1?Q?ztVQMpJ9ctyeTqjP4qQI4dImPRHnoWJpn8pmVj9W0ZJJAQ22l4+Zxm8yMZ?=
 =?iso-8859-1?Q?hZe6ybbR3nFavYl5p3M7fEHNwJpa9iQVRn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: stackstate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0202MB3412.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c307635-d43b-4ea6-49b3-08dc0ba5274d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 15:11:53.6550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3d4d17ea-1ae4-4705-947e-51369c5a5f79
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75YZx+Bhi5AVqHk6PsQZOAzXPdDqH0nXEsJQp3WwYRO5JarzFcmgwBJdyysSZbtdtAJxWX8tKjWX++kK9pLacQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8546

Me and my colleague Jan-Gerd Tenberge encountered this issue in production =
on the 5.15, 6.1 and 6.2 kernel versions. We make a small reproducible case=
 that might help find the root cause:=0A=
=0A=
simple_repo.c:=0A=
=0A=
#include <linux/bpf.h>=0A=
#include <bpf/bpf_helpers.h>=0A=
=0A=
SEC("socket")=0A=
int socket__http_filter(struct __sk_buff* skb) {=0A=
=A0 volatile __u32 r =3D bpf_get_prandom_u32();=0A=
=A0 if (r =3D=3D 0) {=0A=
=A0 =A0 goto done;=0A=
=A0 }=0A=
=0A=
=0A=
#pragma clang loop unroll(full)=0A=
=A0 for (int i =3D 0; i < 12000; i++) {=0A=
=A0 =A0 r +=3D 1;=0A=
=A0 }=0A=
=0A=
#pragma clang loop unroll(full)=0A=
=A0 for (int i =3D 0; i < 12000; i++) {=0A=
=A0 =A0 r +=3D 1;=0A=
=A0 }=0A=
done:=0A=
=A0 return r;=0A=
}=0A=
=0A=
Looking at kernel/bpf/core.c it seems that during constant blinding every i=
nstruction which has an constant operand gets 2 additional instructions. Th=
is increases the amount of instructions between the JMP and target of the J=
MP cause rewrite of the JMP to fail because the offset becomes bigger than =
S16_MAX.=0A=
=0A=
Hope this helps,=0A=
=0A=
Bram Schuur and Jan-Gerd Tenberge=0A=
=0A=

