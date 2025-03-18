Return-Path: <bpf+bounces-54251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0586A663A2
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 01:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E548179419
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 00:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDAB1805B;
	Tue, 18 Mar 2025 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="d+jFh65o"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474EA934;
	Tue, 18 Mar 2025 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257526; cv=fail; b=r1mnCMRb4GU0+0OYgBLXigosFIWT6NO0bhwj6c+P5j29JQmHoE0Tr85pgp1WJWI9m/e5gOR3KafDVKQlHOhNSVoCjIhYv6OUTmxGVIcVFyAVe7nW2nLTeTvoSi0KufBBB112HBpLY+S+pDwjaGAI/b550dL425yS7Wtr4zkzx9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257526; c=relaxed/simple;
	bh=T5PT/B0e++XcIdc2TNstz697kJfiOuQKcXOYD9puDys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MY9UDwef4U3lG2NWhKj/X51cVAxkAetT9pxJ6o9tEDKK6GULOiABLk4dAqYqdXjLrmKFagRh5xnVtPi3VSfnpjEoMYhFvu8hKti4HJyXJrkWYJP2qQiTeZxpntBihOdWP+OL5xWHdeQd4rPhYxTZocTdEie1YgCw5o4vJk2ubmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=d+jFh65o; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGXwQ86EMV1UTJyKPARtNZClTxKKIJFrQy1is2QKjXmOu3rEqO9gYfFW8Q9BrlFRGXJYW54hkpnc1NvoD4CGsvP/SSeiC6CsuWvRZWTLhFQYcQTMlDmNlXZysW1T66ddy5l1jqOzWjOwy2NE2ucM0IDYcperPcHVrAKbG7tvIAiZhjpsWK/d31cS8qjI0Jcg/zLxLKuQOOhYBsq0ztegKovimrWnlLlh3aFp8yxQA+fExkQ82aBM/bWi6gmT6+eVsxCKCv/FnoZbWXZfJsZCzbJEUlX9g3hF88qZQpgZnT/hVZkgRsRecGJCq1H5BZ/f92gTA7E+XxK3jtBCnsVJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45Md77WKSa/FVQszLfLaydrXCrkGQtuSpKdqSuwt4Qs=;
 b=aDPxnqsWW6wNx2e4Vo+cXblM1dtvowWK3AS8BXJj+Y57gQenF3/qfB6KAd8FhlavUvB8ZlQTB9ZvACCPyOdSoYWN8cMLh3qapkK/MNSYVcT9dhZ0VPd+8EXRUZ1Cska9zbyMoehKYFPKpN8KoUthJyazJrjJn9Zqchnfslo4rrTTZkNpUTFkG/CHH8L6/ioet4Obs5F/WVYi23lMad7prKGILbQQs2Xx1X381COPmTChUvHJKC3Xo7j2jN8R//kxs42avxdVYuC0fSzb7SrYk7MMcs1e/A7lVADuWzdfbbmCTbAkfqHV7sb48BBePdSB32eSPK+dg9Xz7azbMT/rpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45Md77WKSa/FVQszLfLaydrXCrkGQtuSpKdqSuwt4Qs=;
 b=d+jFh65oi+1FqZaXH1pU7UFUXRsEx3ccjq5ZJqSVsal6RehGHNnPLhKqeQhxTtZAf8e3/GomqIuQbl/6v+RIy4p0Cvwg0QbF4MB0dvXEm4eleeGxp5l5Vcf+j56zNGLzoSVJHTAf5Xrg5JC5rav3XbYhGW20fBoa0tDmZEv44j7nEu/L9Qc9PDQYR5JrDbAjxobAh7eUTPj4gzXdFhHy2mxV5ZD3FCEF31GV/07moq185ssc+3e+isqMLDcfQljH4CssKDxP6if3ELi/qfakI4t7UVTCd5oj9UAnQ4nRkW+oxuE9iy/qxPz29WWx5vXauQ0lj1jDodgZLp5CGmjXVQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7927.eurprd07.prod.outlook.com (2603:10a6:20b:396::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:25:21 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 00:25:20 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "patchwork-bot+netdevbpf@kernel.org"
	<patchwork-bot+netdevbpf@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@gmail.com"
	<dsahern@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "joel.granados@kernel.org" <joel.granados@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
	"pablo@netfilter.org" <pablo@netfilter.org>, "kadlec@netfilter.org"
	<kadlec@netfilter.org>, "netfilter-devel@vger.kernel.org"
	<netfilter-devel@vger.kernel.org>, "coreteam@netfilter.org"
	<coreteam@netfilter.org>, "kory.maincent@bootlin.com"
	<kory.maincent@bootlin.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v7 net-next 00/12] AccECN protocol preparation patch
 series
Thread-Topic: [PATCH v7 net-next 00/12] AccECN protocol preparation patch
 series
Thread-Index: AQHbjh9jtAGqv333XUi9HKdrMqfnAbN3jGsAgAAOHbCAAElxAIAAN6VA
Date: Tue, 18 Mar 2025 00:25:20 +0000
Message-ID:
 <PAXPR07MB7984C811A8104A8ED9D852E1A3DE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
 <174222664074.3797981.10286790754550014794.git-patchwork-notify@kernel.org>
 <PAXPR07MB798499BAC1A21E323687C9CAA3DF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <eb1fb79c-d2f6-48bd-82b6-c630ae197a7d@redhat.com>
In-Reply-To: <eb1fb79c-d2f6-48bd-82b6-c630ae197a7d@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7927:EE_
x-ms-office365-filtering-correlation-id: af2645c5-85e8-42e3-ba23-08dd65b35dfa
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Gf9pT/C60InGdlvtDOMMnq2OW5qU6ehwT451P/Igurqo6EGtoE0WlH83h0pl?=
 =?us-ascii?Q?UQNoXWdFWqbIJvNgV04h3ECTdfNt7IU52KSEVPBgNv4JH9mt3PTa5fgxdPcd?=
 =?us-ascii?Q?WQd9NEX5txK67kzod2FJnl9ECKx5rAWE+SJOp+o4oK+5KbUbiYu/xZqm262x?=
 =?us-ascii?Q?Br0aWAn/PPBj4I3wBdLhrEXE6+wRMvArhJ6MBa4jP0t9inq5r5PYXdOeRNwn?=
 =?us-ascii?Q?MklC2t5b2UW/bX8bE0TXLzzs/KYBmf4voxNZptAPmOhAY1Wk+DNUjmMqwNje?=
 =?us-ascii?Q?m8IzzIVuJwTgBPC4TDojCDz4ZCI6i+KRjmVjGx0hH6JHevoFPz2grLBb47Df?=
 =?us-ascii?Q?TaAeeNAeYGj83ArZqIdJmbsIKAI+dVSYlIIT8vAwWJjcg0iiWKPJ9kt7PDL+?=
 =?us-ascii?Q?kU/TnHOpLKXwMBBb3dnBspJQ0/65+THJbe+rHr6Mp/feo51fHqiMIu9lsKiw?=
 =?us-ascii?Q?BjAs+nfuHxhe18/vlvRPFq8KPo0JMl7wq3NaX84pv1G9rZiyowtMYpOM9QpK?=
 =?us-ascii?Q?bSbW32VReuqnILHSLeYwcyNJvLBrjvvNcDji7i1hz4jhwlzxikGdOY+wxNoD?=
 =?us-ascii?Q?CfUk6Y+I8mZHkTpqYRuvH1vNpvf7A/sGGjIjYCzONYEtzso3PQXXsYwSTcqr?=
 =?us-ascii?Q?S94ayjq1LInjlHS+RCgjbJ0l7eBGxqt3y6wDjs/zFCUTTGRCki4noCXcbMYC?=
 =?us-ascii?Q?dvnpRgFOgRKDhjkapEnWVerMcZSx6EDYqNeRh3ABUJObDTW6T5IV7PAeMVm+?=
 =?us-ascii?Q?yi9U1FTousDfQ42j1OJ0a81VdC+DRWgvGEaAdN3YqRmRl4j6SqJaWhl9Jx4h?=
 =?us-ascii?Q?uQJ1MCmeOo97Q9/kmKtGMYgZaKsEOwXcZdoyh3/QnGz6Qo/6U6mdfRXKDKIv?=
 =?us-ascii?Q?+YNTB+YHtdgYWmow6i/hqKRNZf22bFm9WRdRxAoicx59R8zdUQlqz7Q0g9nv?=
 =?us-ascii?Q?EZ1KGFFwty6zOOh7VBDtsMzusVeGps7xHpsOEqv9Ne125+orgG15bI3BuPRy?=
 =?us-ascii?Q?JeHS0L7MCU7nGWhuMOlcmmMCm45ApDejBYxHqPwVuxHnhllwFFMAdNwiejs1?=
 =?us-ascii?Q?oHBs7+w2K9BeS6WNgd7CJ+jTDDMQTNZq6GnYYoUjCvVjPIkjtzy3c8wXJtmm?=
 =?us-ascii?Q?fWRDZpfMoYRqug375jkM458wX3iAZrMvFZs9CjV2DLuIxffEybze3svf7+5g?=
 =?us-ascii?Q?ClMyNXmuduYtcWMkq56Vit7haPGxl0gGCdp2gc/pv9xVkxFbzWqMB37Z4bA1?=
 =?us-ascii?Q?Qz3A1AJHTnVxXySgDOmuGgbioL9b0VuU3AG3wWlflHGZqROJNpc4Y3H/gj8R?=
 =?us-ascii?Q?EX7tnTFEe27hdg6xlxDoN1i1GxFTlC+GRKMg0OjeEYci9ZWgt9Jx74eJZP7y?=
 =?us-ascii?Q?Y7eJuty9Yg3LHznlvgPxXngpj8VzKtioMn38OuTtKtxXc92oFejfaaNO1OdA?=
 =?us-ascii?Q?msQwlrBWlS2OWJVDLCI3eLgmO8k8yz/Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kcoD/6BcX5yeaHA/mVnWY96zLSimYebzzhbFSQT7G7sb/Wk1WeGnEO7FJlig?=
 =?us-ascii?Q?2ogw6FDTMjppZ/D0WHZ4AX7zrg1EtVRNhx0BpUzInq0TPKDkd/aasS7f7DUJ?=
 =?us-ascii?Q?Zp7Nbopi/0ZMFThdfjQmW+GeSQkRNlDP/9kOJxps1cO7ounPTbocRJ2pndrQ?=
 =?us-ascii?Q?9PxIBMo3raSKkfKE7F3kbBi7SHcM4pn1GVM66fG5oOYQbc3AHVQOCaUpM56E?=
 =?us-ascii?Q?6eoGknps2UTyy9SH+c7e01MpRaIe86GwDkUvbObjCm1YH5brltl6qdQ5reox?=
 =?us-ascii?Q?lDvnkZqju6USS5ccrBebykGdiswc7qIFLD6yg6erX7BYhtaiZgIo8+8kFsmO?=
 =?us-ascii?Q?YBvvrpvsbmEa5NcSWOjq+S4yGPX6kB3kore0dolNATD1FgHusRKCTIRWetSO?=
 =?us-ascii?Q?1Xr9eQHLn0CDwmSh41yroa9jWx1FqG+uscpW4Enkb+f76Zq6/NlivdjHVKF5?=
 =?us-ascii?Q?K1me0ka5k7NEoDXbO4TCMx3zStwnq8c0D8B/zUzZf1zvK1s92iO+Z0Q7UYvO?=
 =?us-ascii?Q?C9CaB3OEMNDBIKYIxsKqxnB668xnxJmxOZdWZsmYIExQvv/nHVIXH0EjESit?=
 =?us-ascii?Q?6YrYs04fW6ltRKX34oOL9+iAMafLFv/ww0lYhEEVaEAPaaM2hQlyAwsQhBw+?=
 =?us-ascii?Q?9LAjuHNLIIJLtcpwI66X8CuHy8ZI8jrT3xg6M5P6refYLq4K1OOu3n1DroXe?=
 =?us-ascii?Q?TjbfmIPInWue2AvBBnxvfvxqWRvXP/TNxILZ/Q/kpMTH0BUJ4ognKdabgYer?=
 =?us-ascii?Q?dVkZFY119HG8xbATPk5T+G/+y/8L+qFI4/JqUtSCWcTkCSRmx2gs/nop/Utq?=
 =?us-ascii?Q?xfxse0pzTurDta5vQyM70B24apkcT4A7jf2DsYJQUJemfowdT0Yl8fliTpoA?=
 =?us-ascii?Q?P7DmonqWkAFa6oqv8CMDY8Bm6CoTZLJBbJFxPWtIYQp1q2+e6G4zqZPiDPyK?=
 =?us-ascii?Q?AU82PbCXl5h71H/+F5JhRCn2selVrjy6lg2Ju5a9cTR1UirlopZtfcRAg9mr?=
 =?us-ascii?Q?q5fIM15W5UGl/Z3jd3gvJlYWHzvBH2v2s7S6Uwt1KzRMt7D7eLBY0be84BtL?=
 =?us-ascii?Q?ApAr8jncEX8rznI7TN34ofARsTi0i1AnEX41rm7vhXlhvn1J6TFvG79qOu+V?=
 =?us-ascii?Q?DIim9Fi65jeJVZWwT2D+7HYcfH3BFNPEtnjwEysP/0HjjMeAcgfcdH8+WNqO?=
 =?us-ascii?Q?VeeYvGCln9k7iBcOCT7VosN5vr6WnEasMSL2UabLLoGzDoVIzirNjDWbu/E5?=
 =?us-ascii?Q?wyi86KU+0Y3S6O8SD8lbdFXzkdKfXbhK8PAoK9Ze+CMzgzEzC6ZYRtBKg1Lq?=
 =?us-ascii?Q?0W5Xp019w01g4LfUmwqkAarWgNxbE+K53sT/b9fRMt/UUqLeGl3b6eE2bG71?=
 =?us-ascii?Q?ygXckGJNgHysQ7o2S7webkT7raf3qeYan1nzS/M/vQnEwo38guRKIEGmaMrx?=
 =?us-ascii?Q?ojwKAmsJ+JiWIveDtFk+ORgi7t3qZ+gMOIEdUl3w9xTLIci8lKc9+4KKjKl9?=
 =?us-ascii?Q?IAlneFG1fEPDCPAcBfzUGoEaan1/kr3pBtSQ8JVGvREsYxmS/bjieScZBt/2?=
 =?us-ascii?Q?Y7WUgxXb3B88nhLTghxL4exI9fGLlolFyXrm7nV7kIAccmNN+HivgStkhVTc?=
 =?us-ascii?Q?h5wg7T6b9C9Y87Fk8yfEmaE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af2645c5-85e8-42e3-ba23-08dd65b35dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 00:25:20.6541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZ8TSdP/t/fgiERGlcG6E8+uXI1z68GC3VrlcSuZA1j2HsN+zor/zwU7h4625GdfUKTMcrrtRZnrB+a1wkc+OyAH0oB22DL8SR16ZF1WKh+9vlxhGZBlNOhZwLf7vYPn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7927


Please see below.

-----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>
> Sent: Monday, March 17, 2025 10:04 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; patchwork-=
bot+netdevbpf@kernel.org
> Cc: netdev@vger.kernel.org; dsahern@gmail.com; davem@davemloft.net; eduma=
zet@google.com; dsahern@kernel.org; joel.granados@kernel.org; kuba@kernel.o=
rg; andrew+netdev@lunn.ch; horms@kernel.org; pablo@netfilter.org; kadlec@ne=
tfilter.org; netfilter-devel@vger.kernel.org; coreteam@netfilter.org; kory.=
maincent@bootlin.com; bpf@vger.kernel.org; kuniyu@amazon.com; andrew@lunn.c=
h; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_s=
chepper@nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.jo=
hansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs=
.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com=
>
> Subject: Re: [PATCH v7 net-next 00/12] AccECN protocol preparation patch =
series
>
>
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>
>
>
> On 3/17/25 5:44 PM, Chia-Yu Chang (Nokia) wrote:
> > Hello:
> >> This series was applied to netdev/net-next.git (main) by David S. Mill=
er <davem@davemloft.net>:
> [...]
> >> Here is the summary with links:
> >>   - [v7,net-next,01/12] tcp: reorganize tcp_in_ack_event() and tcp_cou=
nt_delivered()
> >>     https://git.kernel.org/netdev/net-next/c/149dfb31615e
> >>   - [v7,net-next,02/12] tcp: create FLAG_TS_PROGRESS
> >>     https://git.kernel.org/netdev/net-next/c/da610e18313b
> >>   - [v7,net-next,03/12] tcp: use BIT() macro in include/net/tcp.h
> >>     https://git.kernel.org/netdev/net-next/c/0114a91da672
> >>   - [v7,net-next,04/12] tcp: extend TCP flags to allow AE bit/ACE fiel=
d
> >>     https://git.kernel.org/netdev/net-next/c/2c2f08d31d2f
> >>   - [v7,net-next,05/12] tcp: reorganize SYN ECN code
> >>     (no matching commit)
> >>   - [v7,net-next,06/12] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_dat=
a_ecn_check()
> >>     https://git.kernel.org/netdev/net-next/c/f0db2bca0cf9
> >>   - [v7,net-next,07/12] tcp: helpers for ECN mode handling
> >>     (no matching commit)
> >>   - [v7,net-next,08/12] gso: AccECN support
> >>     https://git.kernel.org/netdev/net-next/c/023af5a72ab1
> >>   - [v7,net-next,09/12] gro: prevent ACE field corruption & better Acc=
ECN handling
> >>     https://git.kernel.org/netdev/net-next/c/4e4f7cefb130
> >>   - [v7,net-next,10/12] tcp: AccECN support to tcp_add_backlog
> >>     https://git.kernel.org/netdev/net-next/c/d722762c4eaa
> >>   - [v7,net-next,11/12] tcp: add new TCP_TW_ACK_OOW state and allow EC=
N bits in TOS
> >>     https://git.kernel.org/netdev/net-next/c/4618e195f925
> >>   - [v7,net-next,12/12] tcp: Pass flags to __tcp_send_ack
> >>
> >> https://git/
> >> .kernel.org%2Fnetdev%2Fnet-next%2Fc%2F9866884ce8ef&data=3D05%7C02%7Cch=
i
> >> a-yu.chang%40nokia-bell-labs.com%7C72e33ae0d7f0420790c208dd659742f9%7
> >> C5d4717519675428d917b70f44f9630b0%7C0%7C0%7C638778422522699339%7CUnkn
> >> own%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJ
> >> XaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DkcRwgx%=
2
> >> FWDHKWt9hvGogvLksNHjjjQcd%2BAbCuSsJrtoo%3D&reserved=3D0
> >>
> >> You are awesome, thank you!
> >> --
> >> Deet-doot-dot, I am a bot.
> >> https://kor/
> >> g.docs.kernel.org%2Fpatchwork%2Fpwbot.html&data=3D05%7C02%7Cchia-yu.ch=
a
> >> ng%40nokia-bell-labs.com%7C72e33ae0d7f0420790c208dd659742f9%7C5d47175
> >> 19675428d917b70f44f9630b0%7C0%7C0%7C638778422522710517%7CUnknown%7CTW
> >> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiI
> >> sIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D3MvKCWlvavf14mc=
p
> >> i3Xt1L9UNX8VyJ51n0rK3vpcT6U%3D&reserved=3D0
> >
> > Hello,
> >
> > I see two patches are NOT applied in the net-next (05/12 and 07/12) rep=
o.
> > So, I would like to ask would it be merged latter on, or shall I includ=
e in the next AccECN patch series? Thanks.
>
> Something went wrong at apply time.
>
> AFAICS patch 7 is there with commit 041fb11d518f ("tcp: helpers for ECN m=
ode handling") while patch got lost somehow. I think it's better if you rep=
ost them, rebased on top of current net-next.
>
> Thanks!
>
> Paolo

Yes, you are right. Thanks for pointing out.
I will merge this missing one into the next Accurate ECN series.

Chia-Yu

