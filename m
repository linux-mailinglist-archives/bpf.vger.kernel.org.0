Return-Path: <bpf+bounces-40134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725E97D699
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 16:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C023B23874
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E18717BB32;
	Fri, 20 Sep 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DW5OrjGh"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841801779B1;
	Fri, 20 Sep 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841120; cv=fail; b=TPQc3XD/zZ0jege5W4xhdW0/DyRwwRyCOUssbCsS7a7FdhnB2DjB3n7Le6rkzKs3v09AjuXYHqDuy7Z/kwMOWskc1H65D8OsXu5CnBTRQJGdiH3Niw1TwHdmBxkPqAJ7iIP74VFqHqcfHMvzxa4Eh18qnFqPDO4kdjUxYOO9edE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841120; c=relaxed/simple;
	bh=zvXYrHLxCrxI+vqzsa648fkp3tUf1tQQfLlZYInx6dY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ij0XHi+IUA4ZQ1xA9rURUevdifRVuPiWE6ZI4OTf20jV5kQwv/WNEYCzP0Fn7yrzXnH/4r6aFnPvyz/zj77kHmCtjSudajLMb0Q8Dd2XLxv4Z11cPZf3KyUWtHvarn91VfPYr1Ujf+3a3DjrxOXRKG4UsxPwlD7sglNEH2/dQIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DW5OrjGh; arc=fail smtp.client-ip=40.107.104.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6zU8yelx+mjwFx5X2Kb2Ls99/YiP3nMyTyTdwbsiAWh8nr/OWNe9LkTHu6YpDGyag+ppngFH6JGnBIdERph8tElb/Rt2UvALXbHMk5O33C21yNDgKsJ8BsnYBKuem4zPkPutvur5Jas6N8WO2o/VNEPfFk44PCnwVj7aJx+D7UXCzbe62hKiZX9BIj0Y6l7dFwigjgQOA8U9RhxPEluIKK4q9SPgfCWcnQoBYfeW49I0O+VuKb1H5Y3IgE7hRG3VDSXceZWc3DvAcWmnNiX9ayPKi9/wID8+VoltfPFMSOeC+IqWvkZ7hh4XYtCSOp/ZaESlFFOwc5FdqjNE4TLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvXYrHLxCrxI+vqzsa648fkp3tUf1tQQfLlZYInx6dY=;
 b=MhT+eT5b+ZAz0pC6ZeCptgjEF+jvQvyafO14Of3Q2gFWYzaabx5wN5dDFtriWZjNFhokWdt+fHUAYewhe4aozXRsGqexlkqvkaWEBL+WuxQArpGr5ZL0vDCS/LXKs8+Lbq7ttW6QjuKv7tBKFTzLPwLCgltYeY4Isohz9XyU6617ivm5BIFD/mX7m5xXsMITQXlKYbD8eq6jjvfh3s0p4rnTTGEK8tuN2r7e1W2LbCH0bO1niB63Plmbae67TQmxb1oieFDui7C6fQ452d6Wrt4K6/RnPjvCnxrtmeB1fak3d+HYKVHBxpXc727jbt4i653wCxb9FcnmmU9MDxCSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvXYrHLxCrxI+vqzsa648fkp3tUf1tQQfLlZYInx6dY=;
 b=DW5OrjGh13/iz/yDTnntpSLSflWTvZF3pwF9E4s4MFTgO0o35WDrftBAz/0jTV/uzJyyJ5cj4Lwkk0X9LCHhYE57agNs3oigmsMhx9cfv6KIta9UZd/DlUvpCq3X4tZkRPn6C+zDAx60LIiPE1gutuMbd/ScLr64smSw7TOGm5GDA2s0X8TsvbuyHIGaWiizf8irDZVr9MAfciAkYYHQFFMyoQJneOtAU/bVZiW1Sgz5p4QCzio+M3x2hc/kxBk14u13wg91GBaH2zyxFM/UTdkD79DLrvIyRRAEp3oZObXcLyzE+KWL2d4JYvENr4K8ke5xilyVp/rIB4cVO9DE7Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 14:05:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Fri, 20 Sep 2024
 14:05:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
Subject: RE: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Topic: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Index: AQHbCnHT295KDDvRD0aXaVmRMCCprrJgpnMAgAANdRA=
Date: Fri, 20 Sep 2024 14:05:14 +0000
Message-ID:
 <PAXPR04MB85101DE84124D424264BB4FD886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com> <Zu1y8DNQWdYI38VA@boxer>
In-Reply-To: <Zu1y8DNQWdYI38VA@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7444:EE_
x-ms-office365-filtering-correlation-id: 6155f98c-0696-499a-5adb-08dcd97d3fad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?OXY1T2lWb295MC9CdzZTeDg1RkJVd2VKVjdEWEhOTHBGYkVnWHc0b2EyMlR6?=
 =?gb2312?B?b2xydkhVb0NsVHREOUozMDZKVmw1bHgzUmFMMUUzWGlMMm52Y1hlbjloc2Jp?=
 =?gb2312?B?Wld5dU9YOTBacExRNC9NUUpDVWxFajk4ekpGTklCTTdnWXFOMzFMNlprWU94?=
 =?gb2312?B?b2NpdkIwTG9sbjAxZlZzK05jVE9id3hVSkdER2VEd2Z2L1E2a2I2eC9Ca0E4?=
 =?gb2312?B?UndoS2lzWXY4a2lvN1lsSVlsTnNnU3ptSkVBTmVFcHVBMTNYSHlFaUZLQWxJ?=
 =?gb2312?B?Q0IxQmVPdm1OWjIxcFlTTWY5elR0MmNrUUxDMkREcHhINGZDK3IxUFVZYm1h?=
 =?gb2312?B?d3gzN3EyNkNDbisyWmlXUFgvMzBmYUZwd2FlTUZXNWNraDEvRHZyZElLdjY1?=
 =?gb2312?B?b2ZUaFFmUzljcFd2ODNScFNzb0tuOFB2UDNhT2JWb1UydG5VRmxVSThDNzda?=
 =?gb2312?B?ajBtMi9yWWttNzhiV0FWczlNckZjMGhTcnFwUnZtVForOHlqOTFJNFIzTUp3?=
 =?gb2312?B?bFFudEtHT0R1YUg1NFhwN3RFS0MvVEJZb25nWWNOaGVVdU1QZjBwRjlsbXFQ?=
 =?gb2312?B?U0wxUGdPRUowUnRod0g3OUlJTVMrSm5CTjQ1VEh3NFIvbHBoZXFaOXRJL0Vp?=
 =?gb2312?B?WG8yZlBERmFPNzRUSGdrNy8vR1dYZzFuc2RKdmlLKzFYSmxuTzZXUWlQYmEw?=
 =?gb2312?B?S1EwYnk3ckk2L3RKYlNaL21DTno2Wm9vcHNJRVNITFRmRXFpdldWZExiNWZT?=
 =?gb2312?B?VHdZREtBOGN3NzBsUUE0NmFXZ1hoa0kya0haODIvUUtvaStkcVB6ZXZnWWxK?=
 =?gb2312?B?cVBuOGpJeXBuTDJqaDFVbWFEbmxUOEJHcWlMZVpQRHBKbzI4UXc1aWc1dkRa?=
 =?gb2312?B?TU5VYWtTYnhFV0wxb3BXM2ZrcU04am9BR0VBNkQvQnpyYnViOFJCRG8wbE9p?=
 =?gb2312?B?dFNhMVRIbEh1VWJWNWhWL2ZPZ2tiWkJqN0F1S2dwZklBSmVjVXE3UFg3Z3Zq?=
 =?gb2312?B?VmFnZXJDbytuUGtpWi9ibXltRlR2TENMcnRaa3RGQmI5dVZtendrdDBsc0Fj?=
 =?gb2312?B?U3cxV3M2Snc3cGMvOUxEQXJVM0hlWmM5ZDByeEtvM09iVHpzZldxZVQ5SFV4?=
 =?gb2312?B?eXJtYWZpSDZheUM1eS9VdUZqMkRxemhLam14ckpueGlpODBjb1JXVzI4TW5W?=
 =?gb2312?B?Vk83ZEwzc2FLeExmTmM0NUhvUFJrcnMvTkZQbzdIclR6dkZBMXA5RzB6bmU5?=
 =?gb2312?B?OVNMeDNoTzUyVWpRaXB4aUQrWFV1L1YybnQyRTZFcUdQMXNoVlp4Q29KNXBP?=
 =?gb2312?B?UU1ScUFNZlZJWDZCdjdORFBtUmdrQVcwdjZjZHZDTEcwTFQvcmdyNlExQnQr?=
 =?gb2312?B?MmJBY29MMGRFQlVVd3gzTzBUaittVDlSelhUbXZ3VnQ1MmxyQnBpZjU1TUw3?=
 =?gb2312?B?bW5MdVhPdGpwUHpKMFBYTEFVR21idUtkU24vQUZ6VWtqNTBZMFZ6L1gzUjNE?=
 =?gb2312?B?QUtuN1RER1I2SlF5SFB0YUJQR1Bmak5zdERCcExjTEgyV0V6dU9Zd1VONUpO?=
 =?gb2312?B?Y250ZmR0RXlCMXhkU09GTm5vNjA2Slk0OUJnMXVpOTZ3RmdoL1NYdkp1NHNn?=
 =?gb2312?B?QVVUVFBnTmhORjV5amFOMFM4dG1qZm9ibE5LRUxnSDR3bUJvRE1yUXhOeDNa?=
 =?gb2312?B?ZWtGdXJmUnFXMnYxeUEyY3VTWGxWUlRuWnU5MHdrUklvNGpTeHZ5Rks3WnJC?=
 =?gb2312?B?M0hjbXQvTTNNQ2krSEtCM2VGaGw4dXNyeUd6TSs3dUhySVJXUDNESlpreG9B?=
 =?gb2312?B?U2NzNWRFVzVJSWdTS29UUlBjTlVSWkw0U0RkYnVDQkcyejJmTjM0Sjl1aGtY?=
 =?gb2312?B?QzlmeXJwQzdQbE1qekd1Y3ZMcXM4MjRkQTEwbDYvb0N4Y1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MTJBcEp0K2dIQjRJZEZqR2RBZ0xzOHMxZEZsUkYzRklSRWk2dXNpdDVhUHhX?=
 =?gb2312?B?d09xdWZFYWxsTXpoajg1Q2xZWVJvSGpjMG4yL0NULzV1T2FJdG5RR2JseFlK?=
 =?gb2312?B?TzVKRDkvVi9GVk56L2xCYWRMNWlsV2F5RnYySlVZd2FwTnE4bi9oZEhlekhU?=
 =?gb2312?B?SmJJdWhHMFJHd0xlM3l4R0dhQkllNFJQa1VLL3Zmay9YUjVGVDJETUtzY3lN?=
 =?gb2312?B?MWFpaGFhNEJtV2ZLMnFDd0U3d3RlZkx1MmdRZWlTNVJkUTkyVlk0L0JKeXly?=
 =?gb2312?B?Wkd6UG1ES1p0c0JwWTY3YWNJSXErUUJQRXg0RzJtUkZ6NGlVNnJOdHhaY2F6?=
 =?gb2312?B?SFBwd3VUVjVYYnZlTHJrUEQyYzBuRWZoK3F4ZER6TzhhUnVJS1Mvbml3Q25S?=
 =?gb2312?B?U21qMUtPZ2pUdjdrT1hPZnNMMWdCeE9IcVQrV2NFaDJNbXZIRlVPRUx2d2ZS?=
 =?gb2312?B?Z2s1NG80UUpLM2picjdrUXdKWGFxNzdmZmxmVjViSXAwZ1RESTdzdi9iTElS?=
 =?gb2312?B?ckxyQkFsczNNYVR2a1ZnK0dHcHF0eEhxdjMxSWtlK0ZCZnh5REkzS3dkSnZW?=
 =?gb2312?B?MXl4Zm1MK2dHRjFHbS9JbXhLRWt3NUpNMGExQ01zQnV2QUpHa3lHT1FUZk5F?=
 =?gb2312?B?N0ZlczhaajBXcUl3YkxtTXRNQUVIVmpZK2x1d056QVlNWWJSZGRkTGxxWVJV?=
 =?gb2312?B?d3hTZXpQYUNhZnQ5Sm5oT0IxbHY4NHJMWDZrVXJ4WFQzY1YrdXNRSHlpaWlj?=
 =?gb2312?B?RE5EZHVqajZyZEpYN3hVU3Y1MVRNRHRDZDVZUU1sVUV6ZXFPVVhvWlNBdXVh?=
 =?gb2312?B?MGJJNlVteE9ZUzJPNFdYdzJ4d2JCcUgvSUhINnBsNXhESHlvcWM1ZnVIRmdU?=
 =?gb2312?B?aUZhZVBSMG5xNjdSWmtocXlzOHAzK3o5Sk1TajJ0TlExaWI4M0xLazF0ZnQ1?=
 =?gb2312?B?ckFtSGJjVldHQlY5WTNJVTNPWU9zRkVXenpZUW9aL3BiYU9aNnZTMXgrc0lM?=
 =?gb2312?B?YkJyUkE1eUpiREZvMGNNMVlIYWk4MWJGWityYWYzaFVYYkdzN0xpRTF1ZHVr?=
 =?gb2312?B?OGZpb2JPSDZNNkJtcm1JbFVvZWR4Z2I2a1h0S1dsN1g1VURKZXE1M3NoV3FK?=
 =?gb2312?B?WmJacDBXajBadmw2WnFmS0ZxU2xFRnQxUHgzaDFNdzlsOUJucEdQbnk5blZ4?=
 =?gb2312?B?L3FtdGpKVzlST09IZDF1b1V4WEhWN0t0UE5acUh1T20vTHl5OFdxUFJWWFJW?=
 =?gb2312?B?ZnV4Nko2b2NzeGl2UHk2Sm55dDJ0b0NPUjBqcmtsSk00RFEvWGRXNTBDU2Zh?=
 =?gb2312?B?Z2NPU3pBRXE2RHB3Wml5TW5FMzltUUZ2aXZUNjQrNEkvQXlRUUpVNWFjeFFl?=
 =?gb2312?B?WTFLRThxQUlId215Mm16ZW9DazlBLzY5eml3ckJDUjRVejc4OXYxTUp1SmtF?=
 =?gb2312?B?OGg1ajdDV205dlFOV2cxT3k4UjA3elZLZnUwWU45eEgyYis5VFErYnlUVXU2?=
 =?gb2312?B?UDN5bUtpbHFHZjZ5M1NVZjBJWlV6Yklqa2FuMzh2SVFVaFdrdUpHNHRsL1lQ?=
 =?gb2312?B?cUd4d3JSeURVb1cyeGZMWFBMR2phVWM5WTViUmRrR1BubGhXZDJ0V2RVQzRM?=
 =?gb2312?B?bnJBYnpTcmdXSUYzaTdPWVhReW5KdHJmWVZTNGlseSt3QWVQOFFPNnJXZUJt?=
 =?gb2312?B?bXlWTGRtdE5OUGVxTktuRFVrK2hhU3RsMEkxNTZLaE0zVzZ4QitsYmVLc1ZL?=
 =?gb2312?B?NjUvMndmN1hEdDIvVE9CKy9aUjdyRFdtRjU5QW5yNlVnUUNUVkI3SWlWb2Zi?=
 =?gb2312?B?SHdSZnJGM0x2dldJRHFyOEJkV25FTDJJZkhGLzRpNTVhV2ZMcVRIY2JlMEJO?=
 =?gb2312?B?Zlc5RW5vWjFqTGlXL0E3T0htVkkwaFV3SndEcVFtcTFkYXNXbEM4a0JJRS9s?=
 =?gb2312?B?V0k5MnZlVmdSdGJLVzZ1ME1UT1dPbVhUM3pkbElBSnV5RW4xa1RrVkpvODha?=
 =?gb2312?B?bkVOMUU3ZGhMdFBMd21rU3ZoT2xFTERoa3NDY0c1NzZpa3ZOVXU5bHo1cmJ2?=
 =?gb2312?B?NnpTQlMxNjJaM2o4NHh1YkZ5Uy9NRzlMb1NuN2c5R0NNQTAwNEgwTDFlNGtl?=
 =?gb2312?Q?Q7y8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6155f98c-0696-499a-5adb-08dcd97d3fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 14:05:14.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /idQ7mhq9wlRgOS7iSbMxnEsUp2Ov/U5YmfqC18dncO1/X54hhHHyL3fHrsJOXjiEo4ETtBAwm1a8LlqXX6tqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7444

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYWNpZWogRmlqYWxrb3dza2kg
PG1hY2llai5maWphbGtvd3NraUBpbnRlbC5jb20+DQo+IFNlbnQ6IDIwMjTE6jnUwjIwyNUgMjE6
MDUNCj4gVG86IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlA
cmVkaGF0LmNvbTsgQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBWbGFk
aW1pcg0KPiBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgYXN0QGtlcm5lbC5vcmc7
IGRhbmllbEBpb2dlYXJib3gubmV0Ow0KPiBoYXdrQGtlcm5lbC5vcmc7IGpvaG4uZmFzdGFiZW5k
QGdtYWlsLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsN
Cj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCAzLzNdIG5l
dDogZW5ldGM6IHJlc2V0IHhkcF90eF9pbl9mbGlnaHQgd2hlbiB1cGRhdGluZw0KPiBicGYgcHJv
Z3JhbQ0KPiANCj4gT24gVGh1LCBTZXAgMTksIDIwMjQgYXQgMDQ6NDE6MDRQTSArMDgwMCwgV2Vp
IEZhbmcgd3JvdGU6DQo+ID4gV2hlbiBydW5uaW5nICJ4ZHAtYmVuY2ggdHggZW5vMCIgdG8gdGVz
dCB0aGUgWERQX1RYIGZlYXR1cmUgb2YgRU5FVEMNCj4gPiBvbiBMUzEwMjhBLCBpdCB3YXMgZm91
bmQgdGhhdCBpZiB0aGUgY29tbWFuZCB3YXMgcmUtcnVuIG11bHRpcGxlDQo+ID4gdGltZXMsIFJ4
IGNvdWxkIG5vdCByZWNlaXZlIHRoZSBmcmFtZXMsIGFuZCB0aGUgcmVzdWx0IG9mIHhkby1iZW5j
aA0KPiA+IHNob3dlZCB0aGF0IHRoZSByeCByYXRlIHdhcyAwLg0KPiA+DQo+ID4gcm9vdEBsczEw
MjhhcmRiOn4jIC4veGRwLWJlbmNoIHR4IGVubzAgSGFpcnBpbm5pbmcgKFhEUF9UWCkgcGFja2V0
cyBvbg0KPiA+IGVubzAgKGlmaW5kZXggMzsgZHJpdmVyIGZzbF9lbmV0YykNCj4gPiBTdW1tYXJ5
ICAgICAgICAgICAgICAgICAgICAgIDIwNDYgcngvcyAgICAgICAgICAgICAgICAgIDANCj4gZXJy
LGRyb3Avcw0KPiA+IFN1bW1hcnkgICAgICAgICAgICAgICAgICAgICAgICAgMCByeC9zICAgICAg
ICAgICAgICAgICAgMA0KPiBlcnIsZHJvcC9zDQo+ID4gU3VtbWFyeSAgICAgICAgICAgICAgICAg
ICAgICAgICAwIHJ4L3MgICAgICAgICAgICAgICAgICAwDQo+IGVycixkcm9wL3MNCj4gPiBTdW1t
YXJ5ICAgICAgICAgICAgICAgICAgICAgICAgIDAgcngvcyAgICAgICAgICAgICAgICAgIDANCj4g
ZXJyLGRyb3Avcw0KPiA+DQo+ID4gQnkgb2JzZXJ2aW5nIHRoZSBSeCBQSVIgYW5kIENJUiByZWdp
c3RlcnMsIHdlIGZvdW5kIHRoYXQgQ0lSIGlzIGFsd2F5cw0KPiA+IGVxdWFsIHRvIDB4N0ZGIGFu
ZCBQSVIgaXMgYWx3YXlzIDB4N0ZFLCB3aGljaCBtZWFucyB0aGF0IHRoZSBSeCByaW5nDQo+ID4g
aXMgZnVsbCBhbmQgY2FuIG5vIGxvbmdlciBhY2NvbW1vZGF0ZSBvdGhlciBSeCBmcmFtZXMuIFRo
ZXJlZm9yZSwgaXQNCj4gPiBpcyBvYnZpb3VzIHRoYXQgdGhlIFJYIEJEIHJpbmcgaGFzIG5vdCBi
ZWVuIGNsZWFuZWQgdXAuDQo+ID4NCj4gPiBGdXJ0aGVyIGFuYWx5c2lzIG9mIHRoZSBjb2RlIHJl
dmVhbGVkIHRoYXQgdGhlIFJ4IEJEIHJpbmcgd2lsbCBvbmx5IGJlDQo+ID4gY2xlYW5lZCBpZiB0
aGUgImNsZWFuZWRfY250ID4geGRwX3R4X2luX2ZsaWdodCIgY29uZGl0aW9uIGlzIG1ldC4NCj4g
PiBUaGVyZWZvcmUsIHNvbWUgZGVidWcgbG9ncyB3ZXJlIGFkZGVkIHRvIHRoZSBkcml2ZXIgYW5k
IHRoZSBjdXJyZW50DQo+ID4gdmFsdWVzIG9mIGNsZWFuZWRfY250IGFuZCB4ZHBfdHhfaW5fZmxp
Z2h0IHdlcmUgcHJpbnRlZCB3aGVuIHRoZSBSeCBCRA0KPiA+IHJpbmcgd2FzIGZ1bGwuIFRoZSBs
b2dzIGFyZSBhcyBmb2xsb3dzLg0KPiA+DQo+ID4gWyAgMTc4Ljc2MjQxOV0gW1hEUCBUWF0gPj4g
Y2xlYW5lZF9jbnQ6MTcyOCwgeGRwX3R4X2luX2ZsaWdodDoyMTQwIFsNCj4gPiAxNzguNzcxMzg3
XSBbWERQIFRYXSA+PiBjbGVhbmVkX2NudDoxOTQxLCB4ZHBfdHhfaW5fZmxpZ2h0OjIxMTAgWw0K
PiA+IDE3OC43NzYwNThdIFtYRFAgVFhdID4+IGNsZWFuZWRfY250OjE3OTIsIHhkcF90eF9pbl9m
bGlnaHQ6MjExMA0KPiA+DQo+ID4gRnJvbSB0aGUgcmVzdWx0cywgd2UgY2FuIHNlZSB0aGF0IHRo
ZSBtYXhpbXVtIHZhbHVlIG9mDQo+ID4geGRwX3R4X2luX2ZsaWdodCBoYXMgcmVhY2hlZCAyMTQw
LiBIb3dldmVyLCB0aGUgc2l6ZSBvZiB0aGUgUnggQkQgcmluZw0KPiA+IGlzIG9ubHkgMjA0OC4g
VGhpcyBpcyBpbmNyZWRpYmxlLCBzbyBjaGVja2VkIHRoZSBjb2RlIGFnYWluIGFuZCBmb3VuZA0K
PiA+IHRoYXQgdGhlIGRyaXZlciBkaWQgbm90IHJlc2V0IHhkcF90eF9pbl9mbGlnaHQgd2hlbiBp
bnN0YWxsaW5nIG9yDQo+ID4gdW5pbnN0YWxsaW5nIGJwZiBwcm9ncmFtLCByZXN1bHRpbmcgaW4g
eGRwX3R4X2luX2ZsaWdodCBzdGlsbA0KPiA+IHJldGFpbmluZyB0aGUgdmFsdWUgYWZ0ZXIgdGhl
IGxhc3QgY29tbWFuZCB3YXMgcnVuLg0KPiA+DQo+ID4gRml4ZXM6IGMzM2JmYWY5MWM0YyAoIm5l
dDogZW5ldGM6IHNldCB1cCBYRFAgcHJvZ3JhbSB1bmRlcg0KPiA+IGVuZXRjX3JlY29uZmlndXJl
KCkiKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTog
V2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
cmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+IGluZGV4IDU4MzBjMDQ2Y2I3ZC4uM2NmZjc2OTIz
YWI5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0
Yy9lbmV0Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRj
L2VuZXRjLmMNCj4gPiBAQCAtMjc2OSw2ICsyNzY5LDcgQEAgc3RhdGljIGludCBlbmV0Y19yZWNv
bmZpZ3VyZV94ZHBfY2Ioc3RydWN0DQo+IGVuZXRjX25kZXZfcHJpdiAqcHJpdiwgdm9pZCAqY3R4
KQ0KPiA+ICAJZm9yIChpID0gMDsgaSA8IHByaXYtPm51bV9yeF9yaW5nczsgaSsrKSB7DQo+ID4g
IAkJc3RydWN0IGVuZXRjX2JkciAqcnhfcmluZyA9IHByaXYtPnJ4X3JpbmdbaV07DQo+ID4NCj4g
PiArCQlyeF9yaW5nLT54ZHAueGRwX3R4X2luX2ZsaWdodCA9IDA7DQo+IA0KPiB6ZXJvIGluaXQg
aXMgZ29vZCBidXQgc2hvdWxkbid0IHlvdSBiZSBkcmFpbmluZyB0aGVzZSBidWZmZXJzIHdoZW4g
cmVtb3ZpbmcNCj4gWERQIHJlc291cmNlcyBhdCBsZWFzdD8gd2hhdCBoYXBwZW5zIHdpdGggRE1B
IG1hcHBpbmdzIHRoYXQgYXJlIHJlbGF0ZWQgdG8NCj4gdGhlc2UgY2FjaGVkIGJ1ZmZlcnM/DQo+
IA0KDQpBbGwgdGhlIGJ1ZmZlcnMgd2lsbCBiZSBmcmVlZCBhbmQgRE1BIHdpbGwgYmUgdW5tYXBw
ZWQgd2hlbiBYRFAgcHJvZ3JhbSBpcw0KaW5zdGFsbGVkLiBJIGFtIHRoaW5raW5nIHRoYXQgYW5v
dGhlciBzb2x1dGlvbiBtYXkgYmUgYmV0dGVyLCB3aGljaCBpcyBtZW50aW9uZWQNCmluIGFub3Ro
ZXIgdGhyZWFkIHJlcGx5aW5nIHRvIFZsYWRpbWlyLCBzbyB0aGF0IHhkcF90eF9pbl9mbGlnaHQg
d2lsbCBuYXR1cmFsbHkgZHJvcA0KdG8gMCwgYW5kIHRoZSBUWC1yZWxhdGVkIHN0YXRpc3RpY3Mg
d2lsbCBiZSBtb3JlIGFjY3VyYXRlLg0KDQo=

