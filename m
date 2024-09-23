Return-Path: <bpf+bounces-40186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1290897E5C4
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 07:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE781F217DE
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E6617996;
	Mon, 23 Sep 2024 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AysreTF1"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03AF168B1;
	Mon, 23 Sep 2024 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727070797; cv=fail; b=Bi+gEpfKaZlaoGQOLtDaB4jSyxSIhIlzvg/EtIz6oNvYUeHQCfTHX3Heicb9+cHvt9LYjX6kOYadwmudauuLr6f0/OGl7FpS3X3BMbEEfeplItChPZwaNKeoyos5liE8NanINNUsmFh8H9M59De4tMIqQOj2DveUeeTAM197+FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727070797; c=relaxed/simple;
	bh=0se5i/1BZoYAKVE1OzfrIvpufYCRhi8f/7plzIkWfTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dDSu1aJNQ92J6zSWRbl7Bv7OyX5YcMjhGI7XobGnt6g45vQaNt2A8BeVrlqed1rn349Rjit4BBpEJfRauLi18HVelN+T8r8YmD9kdTSqGwPJaubRR+uDpxUd20vmGjFbZnjnlH6JhPXvLAhL90wobtqxO+TDdxB4vY1Lwy7l69Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AysreTF1; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGFEzOaMSfQmcSO5Z4UrRBwxl3/5nIiZL+wGkGSdtt5MGbXiIhiEPvHRQIc/BVo6EusQ6I86/RgOtyc7hVczZWjrOX+iZTEpyxQLa4JZSIRiN5N71AlzdjR7hcR6+SOeiUFO/RLOdvLOS5scUJAP6hqQGl0tFYdG7yroDBsrXL2EG7H9L/Ju38DHju6QWOITOKGnPIANmhCXl4s/jygFwpeWP3Oj7reyt5BVatLh1pv8jL8krbPVetJYEVtp8kAAzmgoFwQNHqybHXLD477UZtljYGxB+YNbK21dTzOUMwgrLywg1XzdlNvefvpojkZ6XtNu3p2q5egrEUdktbmMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0se5i/1BZoYAKVE1OzfrIvpufYCRhi8f/7plzIkWfTk=;
 b=LGs/OeHPeIuVyYP0q/JGF8hLN+XHdLqoWNitJG6/7VmSeRHV+z/1gZLSACz71NMQDGk0RtcwekBQjWJc2IKyYOnPkeso+MPQAaahGO9jlFgbnInBb+NfcTfXK20VeNgvccWYpMp9vXSCA2rwqGLa/7mxh2bbjIHxJMuaFD4rtZwmUunJJ1gljARt/Dyr/L599IlC6PJYzGB6kgpnA6NhiC5SxnykvdWWNrvIGW8/KB1nA9aS6VXseeaDzc+sEmzErHEOmb7jVURsGgzjAEHPnVpjmYVWLRPFBCYDGOcKGQHkWezJVOn+U1v1+TZ0xXd9Z90EEo96b7zoiZQYdUPYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0se5i/1BZoYAKVE1OzfrIvpufYCRhi8f/7plzIkWfTk=;
 b=AysreTF1soqZKZfw37INcaRgYes3oqyPH+SBkBxyuyzHP662ofSc/PhXmbHzq4w+Sld4mjxNxrm8A3D3majw0XwJD3vphZAbzbgcX0flz+MlEiaOPiiU1M9HYM5UfhRwxKELQf3TSlDrpKAjykJlBR4dNbRY4xI3dleXl7m+TWCeu196Gk9iUR2/uSPUi0eHTsxbWD+1Ebsm8tLwFqSuG3q4A38x/x/eaMnht1sZPufgRWbugfaxiClfHT0e/I+Hh2dX4R/xrGbFG7r5OA0LofaxrJ5cFsTsnS5iXqAA6szjARBZ+3UbQihkVPljrUvvOG9tYwGGXxZGTRwBm4ye8Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB11035.eurprd04.prod.outlook.com (2603:10a6:102:493::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 05:53:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 05:53:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net 1/3] net: enetc: remove xdp_drops statistic from
 enetc_xdp_drop()
Thread-Topic: [PATCH net 1/3] net: enetc: remove xdp_drops statistic from
 enetc_xdp_drop()
Thread-Index: AQHbCnHMuBrO1CrjFE6GTOQ4l2wOzbJk1rEAgAANN1A=
Date: Mon, 23 Sep 2024 05:53:07 +0000
Message-ID:
 <PAXPR04MB8510259090731BFCABFDD47F886F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-2-wei.fang@nxp.com>
 <20240923050230.GB3287263@maili.marvell.com>
In-Reply-To: <20240923050230.GB3287263@maili.marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB11035:EE_
x-ms-office365-filtering-correlation-id: 357861fa-8a02-41c3-a917-08dcdb93ffb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ek1BTHRIeXpFOWFPU3NBaTJMMm8wY1AwYmY5VWRZeWg3K2VueC9MMmdOM2xa?=
 =?gb2312?B?a2ErNlZHUlF1bVZTckhVTk50aGF1S1JZU3lvbFVFaUh2TzhMaVlqcGFXcUEz?=
 =?gb2312?B?a3B3NXpYZjZPbGpxQkJ0dUZjNlduOTB2OWwzajJXWXdzU1Y4bHRPRDZ0WDN0?=
 =?gb2312?B?YTdrREhVdUZGM3ZqWHYweElEd0NiVmFHc2xmdEY2c29zbHQvSXZ5TnN3K2p2?=
 =?gb2312?B?UmxCSkViMzFFZ0tSK1M4OXF0dWs4cEpqendtWGRTYkd6MVI5SllCQW81Sklo?=
 =?gb2312?B?ZmFySkdsc2p0ckdVMm1sVEtSYm43ZzZPR2hOdTNNcFNKT1poOVFqRFZCakFo?=
 =?gb2312?B?eTlOV2VWTDRMa0lnejJHT3ZmVk1LTXV5QStqbGVXeFNZNFZIT3prOHdyd0dS?=
 =?gb2312?B?RTNFTEhtdGt4REJDT1JQV21uTzQ4Wjk1R3B5cWtNMG5oZ0tKMWNNaVZCZTNN?=
 =?gb2312?B?REJ6WjZTa3NXbDFMNkFQQW1LckJocHlMampidldPbFZWM3FCZ2gybHNUQ3Nz?=
 =?gb2312?B?TStpVDlmdnVWTDVpM1Jrc0VRcWhMTjA1OW55aFYxVnFUbitCVzRzTWV6a3p1?=
 =?gb2312?B?cXZHdE05aWRoR1d4enR4eEszSVlKUGUxYkp5enJqZGZaTXdRWXBHaEpURUpo?=
 =?gb2312?B?eXpaTmdLcEtWc3Q2WW9pVmxIRzQwTVFuNkdHSnNmb1R3YkNVZExydzJyTzl1?=
 =?gb2312?B?ZnpTSytzTVpHRXI4ak01R0hvZ1ViZVVzRDhUVEZEWXBKdk4raVpvY3E3WnFM?=
 =?gb2312?B?a0llWjB6ZjhMZVdZQ0o2OXRBTVlaSFh5bUJuQ1lHVmJvbDJoV3hEWHI5Zy9a?=
 =?gb2312?B?ekRrdEE2ajBESm8vOTRKTFNIMFRrQSs5YUpPN21hVEVObFZUOUQxKzFkdHd5?=
 =?gb2312?B?UlNGZTNFd3M0NHMyODlsZVYxQVRBcTMyYitBeGJxcWhrYld1azFFMFNiQmFl?=
 =?gb2312?B?ZkEwNlp1dnZ5Y2RzUmE5U1FaK2tURzk1cU1uQlFScjEyUnFTVEt0bXA2aWdm?=
 =?gb2312?B?YmdjcXZobDJ3TERvNCtNcDBjZllLaTcrMXpUMEZpK3EzZWlFdlhza0JkTDJj?=
 =?gb2312?B?SXZvQ0sraHE2VllVT2IvTmMrbGcwaU56YXpLNEV4UnZHdXZ2V3VvQ2hYOExL?=
 =?gb2312?B?YnB1MUdsd1dyMHNoZG5XUi8xTWFOQkliTTEvM3VUaGdNbzJvOFFjQWFJWjYv?=
 =?gb2312?B?bWxWVUVNWGd6NVlhOUpUbUVndWZqWU45MHNFbmZKWjVGSGM0QUl3RDVQVEFt?=
 =?gb2312?B?R2k2V21aTFRUZVdhVVpWdzRsN2NMNjVuaHRLYzVVRXRjaVR5akc3b01zOWZY?=
 =?gb2312?B?V1V6S3FmZGdTb3kwWTdERm4vZW5CTVRvd0huaEJtN2d1eUNzVXBCZkVDV21t?=
 =?gb2312?B?bXlOcGNBT3hqL0FoNmtRVHJueXRUQk93bUQzNHJMak9zQUFiK3ltRmZyUkZz?=
 =?gb2312?B?Mm1VbHRGd0xST1l1bWkxT1Iwd3BOd2J0SkRYbVZUNm5VdGxkQ1VFZllwcHNP?=
 =?gb2312?B?VFJUaE1oYUE4ejlGTzk1N2QrQWJLTWZhUHg3bUlHbkI3UldkTkFxQ3VLNU5p?=
 =?gb2312?B?Q0x2b0ZRVUdzUG5RMW9ycldVTUpJdStKQjhHeG8wdkptTk5HcUIwdnB6UHRa?=
 =?gb2312?B?MGp0ZUFSZi9LWnhlK2d6TnpJZlNPdytCckJ2QjNwMzdsUTl3cVBEajNqT2pp?=
 =?gb2312?B?R3pGRit0dWJxUXljTDdiVWRpckxrVWNDNGdOUTFaM0NuTCs2RnBna3c5QkpH?=
 =?gb2312?B?QXdOSkI2Q1BYWGFxRGV0bmtoVU1BYng0NUJ1KzN1aGw2M1Y2TWgwRktPMUV3?=
 =?gb2312?B?ZFVZc2NOeEVKaHVZWG0yUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aWtwenpLblRRbklhaHZjZUlOTFRCNGFlZk1qTUwvNm1YaG5Uczh4OC85emZB?=
 =?gb2312?B?K2hpT0hzM1U5SnFOd1BucXdkRDV5bU0zcGQ1QlRWWVgweTloWVRwQ3VyUDdr?=
 =?gb2312?B?Mi81Sms2cy8ybWRqMHFPQlJHVkoram5zNWE0YlBvNHBHNzFvdUQyU3JNWkRY?=
 =?gb2312?B?dk1xeWgxUjVkUkhzZmF6UjRRUnBHZ1JIcHVxdEpwVjVEVTB0WVhkQUJ4dDh4?=
 =?gb2312?B?WWxMQmQzODBtZUJWQlJrS3N3cmZrMVZ6bUpNd08zNnIxdW9NTHFSbGt5TmF4?=
 =?gb2312?B?VkxLcXdZbXFCZHFOZEVTZmZhUjcwUkZjekR6cWI0ZWpmZHRFcFA2b1JCV0Vi?=
 =?gb2312?B?TDhnMldXQ0tiTmhsSnRvd3JHUFBLL21QQWJHNWYrU1lwZEZraHVDdFZoa3VS?=
 =?gb2312?B?YjJ0UnE4ZWhRQmd4bG9NbXdLS2lmNlFJZzhFUEVuVUphQmtFdDdSeE1LQkE1?=
 =?gb2312?B?eCs4OXZTYmE1UUhBanMvVFk4SGZld3I0QlErRUh6eWJtUVpmbk9IWmZCWGp6?=
 =?gb2312?B?bUo3OFdJdTBzUWJNMTFqQ0RoRHVmcVJUR3JUTlUwWHFZZWNZY3NkZ2JKUGtk?=
 =?gb2312?B?WWxnY29zWmtHc1FNTXNycWwzWXdPeC9ORDFrbGQ5SnJycVFWUUFXWVlDcE1Y?=
 =?gb2312?B?QVZLR0pRVFVJekNvMC9WdUU3VzkyQnliVWR4RHErUXppdmxUek94cUNUekNi?=
 =?gb2312?B?M09jZWRNYjRrRElscldqbHU3U1lNTmE4U3BVVVhqOFg0VnVQZEw4ajR6RTU0?=
 =?gb2312?B?Y1lFenpkSWxqdnFzZGUvcWFteFVWODZVRllvQ2k1NExYdWRtUGQrb2lDamJ0?=
 =?gb2312?B?MmtXNXlwSXloUjE0RHgzSEdRZHJIekxkNS9WZ1BCZzROVEkwZ29HUEhFVmxl?=
 =?gb2312?B?RUQ0MGxneTJMUmxsU0ZtRU9udmlkMlBYS2UyYS84SDk3MGd0ZjNGZjhBTEpN?=
 =?gb2312?B?L0YzLzdDUWxWREUzV2hwUyttK2k5RVg1dVRqalV6ZDVjYk1sQ2NKVTZybnpM?=
 =?gb2312?B?T1RQYTUvZDFyTTV0cUxZa1o2MWR3cUs1YW5tRE5lTUVpdXNLb0FRUk1uQXhO?=
 =?gb2312?B?TDBicVV6M2RSNGp1eE5nYVhsVlFXNkxwamVpY0xJVFFQbUNYTjJrUzUxanBw?=
 =?gb2312?B?a0h2MVd0a3NBSlFYcFFoTS91SjVIWW1veU5UemZNQkhGdkNialN3RDJ0Q25E?=
 =?gb2312?B?VW8zbGZkOG1hbExXZHFCdEIzR2hic09PYnB5L1YxSHZqc3NSVTF2MkdmdElP?=
 =?gb2312?B?b0E0ai9ycDlOK3lyQWpaQ2lrTnZ2bGtNOHJybUlyMEh1WkxkekoxK2hRenRm?=
 =?gb2312?B?MCsreWhveHdmWEI4U1RsYVRWYzNEaEFpbjQyb2NYOGpMc2huOTVndkRrams0?=
 =?gb2312?B?akJTQndSYktsT2xDWUR5ZlJMQjd6MFY5L2dBck11OC84ckFsUXF4SnZmc3Rx?=
 =?gb2312?B?Nm0zQU00Mjg2N2UyTzNoMk96eFlaZTZwVW11R1lyc3BHUTJFM0hHWWpudnpC?=
 =?gb2312?B?K2tvUlcvR3RNdklOQVFTeUdXWEMyVC9BWGlsN2hROGxhd0FCTUt0NjFjUzQ3?=
 =?gb2312?B?RnFhaUhqSUhTMStLKzEyeG9kYU1zQ2NqRXVkbHlLYnpHSHFwcUFZc3dRbjBD?=
 =?gb2312?B?bk0xaVJ0Tk5xTTZoWTM5WDdCNHhrVnRVMHhxY0NNZkV1MmVvOW80TkpyUXI4?=
 =?gb2312?B?b1lha0I2TTdMRHdrN2haRE9oeUdTMUcxTVMvKzR0SVRRczRnOVMxdUhnbjFC?=
 =?gb2312?B?TWFUVjBndTZRNWdLYlFuakhPMm55c2N1QjlRVHBBL3V2a1dUSDVVT1ZSbHE1?=
 =?gb2312?B?dVozZWh3dzhrVlpFczgyTGFyRUFESjQ3ekhvMXpJOUdWaUVEZTZBT0R0NUZw?=
 =?gb2312?B?UVd0aXZycFVsU2pjczVpY1JQYmVPaDBHRDBCMXRvaVd3aHBYdFAyV1NSZTdO?=
 =?gb2312?B?bG9CWEtuNGtyeDlNU3FRVTJpZWtseTVia1VEYUVVcUFYRXQzMmx1SExOc2pZ?=
 =?gb2312?B?NGxuNjRoK24yVEQ0WTN1N0Jwb2FOUTRvbld0bGVXaWowT1N3WDZpWjJVOVBn?=
 =?gb2312?B?WFdRLzVyTmNyTlpGdGtIWk5aNTNqbWlYSHhxMzZKKzlYdTA3UitMK3YvVXps?=
 =?gb2312?Q?1os8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357861fa-8a02-41c3-a917-08dcdb93ffb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 05:53:07.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/JjGKGol2VCKmTgQdhCHEotaSV8zwJQRO+ayX8WSOhB6w6Tv0LDGcEB2Wta1o/tCIYS2f0NXcncmOxBcmStvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11035

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYXRoZWVzaCBLYW5ub3RoIDxy
a2Fubm90aEBtYXJ2ZWxsLmNvbT4NCj4gU2VudDogMjAyNMTqOdTCMjPI1SAxMzowMw0KPiBUbzog
V2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBl
ZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29t
OyBDbGF1ZGl1IE1hbm9pbCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IFZsYWRpbWlyDQo+IE9s
dGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+OyBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlv
Z2VhcmJveC5uZXQ7DQo+IGhhd2tAa2VybmVsLm9yZzsgam9obi5mYXN0YWJlbmRAZ21haWwuY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBicGZAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlz
dHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IDEvM10gbmV0OiBlbmV0Yzog
cmVtb3ZlIHhkcF9kcm9wcyBzdGF0aXN0aWMgZnJvbQ0KPiBlbmV0Y194ZHBfZHJvcCgpDQo+IA0K
PiBPbiAyMDI0LTA5LTE5IGF0IDE0OjExOjAyLCBXZWkgRmFuZyAod2VpLmZhbmdAbnhwLmNvbSkg
d3JvdGU6DQo+ID4gVGhlIHhkcF9kcm9wcyBzdGF0aXN0aWMgaW5kaWNhdGVzIHRoZSBudW1iZXIg
b2YgWERQIGZyYW1lcyBkcm9wcGVkIGluDQo+ID4gdGhlIFJ4IGRpcmVjdGlvbi4gSG93ZXZlciwg
ZW5ldGNfeGRwX2Ryb3AoKSBpcyBhbHNvIHVzZWQgaW4gWERQX1RYIGFuZA0KPiA+IFhEUF9SRURJ
UkVDVCBhY3Rpb25zLiBJZiBmcmFtZSBsb3NzIG9jY3VycyBpbiB0aGVzZSB0d28gYWN0aW9ucywg
dGhlDQo+ID4gZnJhbWVzIGxvc3MgY291bnQgc2hvdWxkIG5vdCBiZSBpbmNsdWRlZCBpbiB4ZHBf
ZHJvcHMsIGJlY2F1c2UgdGhlcmUNCj4gPiBhcmUgYWxyZWFkeSB4ZHBfdHhfZHJvcHMgYW5kIHhk
cF9yZWRpcmVjdF9mYWlsdXJlcyB0byBjb3VudCB0aGUgZnJhbWUNCj4gPiBsb3NzIG9mIHRoZXNl
IHR3byBhY3Rpb25zLCBzbyBpdCdzIGJldHRlciB0byByZW1vdmUgeGRwX2Ryb3BzIHN0YXRpc3Rp
Yw0KPiA+IGZyb20gZW5ldGNfeGRwX2Ryb3AoKSBhbmQgaW5jcmVhc2UgeGRwX2Ryb3BzIGluIFhE
UF9EUk9QIGFjdGlvbi4NCj4gbml0OiBzL3hkcF9kcm9wcy94ZHBfcnhfZHJvcHMgd291bGQgYmUg
YXBwcm9wcmlhdGUgYXMgeW91IGhhdmUNCj4geGRwX3R4X2Ryb3BzIGFuZA0KPiB4ZHBfcmVkaXJl
Y3RfZmFpbHVyZXMuDQoNClNvcnJ5LCBJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgd2hhdCB5b3Ug
bWVhbi4NCg==

