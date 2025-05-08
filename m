Return-Path: <bpf+bounces-57772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C45AB004B
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 18:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BDE1C25B94
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EF2820C7;
	Thu,  8 May 2025 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QlWX6uZg"
X-Original-To: bpf@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020108.outbound.protection.outlook.com [52.101.46.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98047280CCE;
	Thu,  8 May 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721260; cv=fail; b=nexG2IO8caEZ0lf/UVbowV41nchHKvObQLmp+DQLuaZpQc1cht+3GZdJSwQ5ia+GWiYLjzLW6p++BiuqrMs22xEBFTpFhNcnJleu0F10H9ndna7R9KMyKsZSuHGyWTl/qfS28bRsbMJc/rlGvFFdXPgfr/m/N/Q0FON1w5ozUes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721260; c=relaxed/simple;
	bh=A2xovAIVlfnS3CJb1lK2TnT44Le1H9kdrkVT5OhuwgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hCLNbeantgAubz6fBeEcptzcNwr3rTLqNVRSFk85awOHRnuuRrKsuKnOeYQxmHaEktc0y+WlSpytXqwG4w9vVaXw93qmp3ZX4tSKAkKmSZo1Yw9oLm7F8/axre8MggjvVJX58IYBFLpzRVojueEEP/jax8WdOd2v/BTz9bEY+Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=QlWX6uZg; arc=fail smtp.client-ip=52.101.46.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/wdL8LnJ1f2OXLWt17a+IHmwz+0fOmfqA3KP1TeCTZlA9ZSX4bafKRYZhUyvinlrdNcUCjHNXvKOWJgw98W47vbrvUOePAQ+xcZBaMj5789qZSYshS7D91oxRqA2tWh5GOErg+Jd8WmpAKxKIaMsfLAKUYX7PeeZ3d1N1CbhhUeWXBdBl1J79L0iPkLdfS9C+je1ycLK3ASh+PthbJ7kXo94iQV+aILUNqbmo6POkpCwX1EBBXDnr67tqzk66E0gpUGfCUk01i/a5FRExwa1CROdmg9caCjqOkDgXE6Pxf7+FVpdFlUBgX0WHyP+2LT87kU+SqXrxVB+B/fFGakmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cAyAeQAQTx8V5pBe2tQAXegvugVrKedFCN2NCRor9A=;
 b=Mmt8B5pQhan1+HVgF9YgUsplN/6CD8GTwf6qnouXK5drsYjDUsFZvqgtV02DmZHb9HOtq2VopziDxLlU0Nxed4uvhqHfx+uUfnE2rMghuU8ehFPH5TeHjTTZfDXVaBjo8Qav9/hHsnosauoicPc1orJmwPISlN9kAJkK5GBnZSAHGqgfutHcekAkG7ma9KXYAZyXmYG/KeyVMfHDM5G94VKNK0cpJ/bmEQQxg3qKvRk60Jd4EWFEYkkNQ9Hhs+chAVnJzouiPZaOpeR4zW/8kHCJC9ENQY1w+bvqDEBTJrsrTcPvGzsJmvYdadOnMPz8xLHBxli6c390qedlGl7Kxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cAyAeQAQTx8V5pBe2tQAXegvugVrKedFCN2NCRor9A=;
 b=QlWX6uZg2KegD0xopEz/XKtQI1siK/kRPGUA5yaEagA2w3jOcBSAI1yukg8nbYV4ysw8y+IzdQGLTJZCJExh5Ht46jG1vTuRv2l3xG6pdv0q1B+rRHPvhzt5Qe1A7W2t3CGLWbqiIqHey9Smsiw5+voTzBme/uUsFGJ1IK4aRi8=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL1PR21MB3331.namprd21.prod.outlook.com (2603:10b6:208:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.6; Thu, 8 May
 2025 16:20:54 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8746.005; Thu, 8 May 2025
 16:20:54 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: mana: Add handler for hardware servicing
 events
Thread-Topic: [PATCH net-next] net: mana: Add handler for hardware servicing
 events
Thread-Index: AQHbv2kCKqGuw59gGE6DfYvpyoXn+7PIeI0AgAByxCA=
Date: Thu, 8 May 2025 16:20:54 +0000
Message-ID:
 <MN0PR21MB34378EC0697BCDCE76FFA429CA8BA@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1746633519-17549-1-git-send-email-haiyangz@microsoft.com>
 <20250508092924.GA2081@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250508092924.GA2081@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8a06a2d5-acc2-4d50-a746-e1a6c6e169fd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-08T16:20:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL1PR21MB3331:EE_
x-ms-office365-filtering-correlation-id: 93141478-98c5-424e-1a8f-08dd8e4c4e83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kYUd5jb5VPGIjxyMVIByqVzESm3YIp8nMFEJNkSHxeMJmAyoa6Thopc+k85V?=
 =?us-ascii?Q?Sksn4Zo0KDlrglhFMN2UbQD3MCT7WnPNgzYhdC8BeCVLNmYL7LsUGuyO4pL4?=
 =?us-ascii?Q?4qn5GVjUiDwMfnbNBh5E1cbCJrdW0nv5EodIA83z3BowG69Xkq+WWhChWhWi?=
 =?us-ascii?Q?Cz7AVNNxnjkVx9irAWvAWklLpa0u0ZaPaYvYkYXHIf4NBjdUtCuK1aDg7j76?=
 =?us-ascii?Q?hCAIpTodxSmgZX/jeyoPdh2gGKutPpQA9rLZ7h+uH2MKPKRTZNfU0naei4+n?=
 =?us-ascii?Q?fdoUq20cm2p1yoDemIe1/w6vRCoRnw+xXObyC4tQJI7XwC+fUmiwcRfXEPTi?=
 =?us-ascii?Q?eqUjzl1i6yRfe33SUh5MIDjob8+c7rSAizDeEkgY0l/hjkWagJ6DDFa/zY4H?=
 =?us-ascii?Q?GQGPHlK0CGBQr8CvTjRoPDMxrCEkGhMr891ejJB8Y2Braf5ZBTT+J+c7g/TT?=
 =?us-ascii?Q?pJLL+JjZlGO7xopu70xQ8ERdcxfiSjzpdNUz77NKCURF8TR8O6tGe17mkBfG?=
 =?us-ascii?Q?1eZPz8bJZlv8IvsfXq9UyGo7H6WuoxuO3In3R9xwM4BrzY0odGAToQxjhKF7?=
 =?us-ascii?Q?CWDBE6X0SFTOykHtZ+SNxhK7OIu7MjI5eL6fzvv+Nsb+b7CAStqmuyOcIxdA?=
 =?us-ascii?Q?cHSCkuGIhRRUZwWwfD8GNl6WjfeSBM5zJdQ+7SqeX139X0KpFllG6JsLHY8L?=
 =?us-ascii?Q?7MzZfKmW9co3bH8w//jD+wIZl51q0iHA/SUdIvUTqTZyWD31ESltV7oi+TkB?=
 =?us-ascii?Q?TCZCD/Rti+cEK5mL8KCahOz7hPVRJx39aKs43rYnswPpGzCa3e6bpKW6qqaT?=
 =?us-ascii?Q?ChmzWil01Jhqr/isUkWw8KTNFq7oHr1wEPuOgrI+QSVBs36Y/BWm8/JmblzI?=
 =?us-ascii?Q?lpwkEH1Bk+JNzrsDEwE0iE4SeZ6JseYcC3+5+EUbmjDDK8vw7oozSwXSk/7o?=
 =?us-ascii?Q?UuDsxVkql1zYJfJnlZVNThXukNxTbIsB3ju1wXVm5Y3XzD51T8p5K5oZtKgh?=
 =?us-ascii?Q?w4JZMPHpkU7+HJz+5LMLDof3y3GbRMUaZU3dReKYD+pf1W+QqOevldgMqNql?=
 =?us-ascii?Q?/W0afkxE3qhuFsSR+eNqUoHROUohD2prFOtJMw/4uTmuXblXC2furY3b/F25?=
 =?us-ascii?Q?PIRNWoD8bn3ipcSXLb66H4gSe6OxC2RQ6tQ9+riiQ6pVM5hKa5qpRaQfX5aQ?=
 =?us-ascii?Q?sMABad1sjR4t73EEFujYjcj26zVkUdWJ4hwODwa1+ItPu/oPnDWYdDVCqr/8?=
 =?us-ascii?Q?HBd2bDxSB/3/cn0w+4LnyUCs4tQApf8/oZ7qluYcwEWIHttgE4o0ZTZWthuy?=
 =?us-ascii?Q?YKGkmCYcaGt9E4gBasTzq3y12R5J0UsgK7vA/jtB/qw4qxOa6NMMvgxsYR0Y?=
 =?us-ascii?Q?jBrlj23zM8Dw9Q4bmyZCbcwvatUHp1Tu+XoHCSdffoXmZLy2z40YSe4XuEgB?=
 =?us-ascii?Q?pUCQygtXZE2HF3HheMEQJ8CZty0Jem3/mCbFUHhRyDd5N5OjWy9hqA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DTxnPE1zZAGK6KSRI9ahx6dFAMQ8no2hsuSrPDPHDJOyJbZP0xP5BrLztSFq?=
 =?us-ascii?Q?cgCbQgawn57452WSNFogkU92BeKE+PlDaUsMDz7Bn2nGKeuDeIlYp9rXjznN?=
 =?us-ascii?Q?il9TqBz4LFBo/Ns/cU9g0otDWjl+Lj2b7G1LEyTWp+7sPp/IOUymY2YDlyun?=
 =?us-ascii?Q?grahYvcOor6g0VxbWGqJdq2PJUTKxmQEewJKYHfMzzwxsFfbHCgPRzk+fLp5?=
 =?us-ascii?Q?MvFCU7mevHvvXAhuqCl3d6PYh18TJoMpVXVvGUApBsU9Gsx63Ei8jgHjJ3vO?=
 =?us-ascii?Q?zp7MhWqJ5lEuhnkDGXiKdun21+r0cep2A8S5Y5g1gtwBHg7xQKGwrK/OuQaF?=
 =?us-ascii?Q?Ri3sWFvrsHrhaZnrXXE7KJwWEGz2Wsw7N9KKpz5YLj3bWPjrLim+YcuYJf4D?=
 =?us-ascii?Q?8w4zU3Fx9mBWCMskV2ppgUwuarb1kPxw5fZahY1RNBz4xmXpvmLP4XzJM4M+?=
 =?us-ascii?Q?2JhNqKMN4EvuYmezxKNVcmVN5Z7BA7ind0adCeVpmLXvBA7yvWDG4dkvCy2A?=
 =?us-ascii?Q?0TFnIDgwOQ0Kbjy+0a1ELwxswHtd9dHVNOyhDnSH6KF4HBS8h8eTaQfAfIRI?=
 =?us-ascii?Q?10DwgQZNlTyHog/UgNqwSZa1BP+LkeVxt7QYsC9dP43qDyKpofcobVxrFKfz?=
 =?us-ascii?Q?bIIxR+sRsXPHSsr2Y401Xd+jxnNo2em7XZ91MOuIVrAPtX78hhoJMwFBeakx?=
 =?us-ascii?Q?rsFIdPV3xCzYRsyH+9QcxIyGMb9pMW4ls7zTz+SXU8WBn1DqlSRVvDIwxcrV?=
 =?us-ascii?Q?3WIAZy3Ff4xiXk/u9VHv2kuYbXpK+YMTRcKjCk7vPVuebzyL4qnLDrfpjgme?=
 =?us-ascii?Q?G0t17J+I79MFXN5u0YqHCWKUVSpPgq/c/JUI2xKAswaJQD8j7JfcQ4wuOune?=
 =?us-ascii?Q?9JNi9QeMywfvAbQIUrSpXc69fsi+OL5LdcyBwcx4WUaHOWX+OKjG/3CPuhRv?=
 =?us-ascii?Q?aFTgQdOG4rHCvrxW+eNgRJCKCUWKzckd+iBKS2p/IicuM0uW7aAjimKZ1WFo?=
 =?us-ascii?Q?oIDeQiL+CE9ZLlIhKxYyOfTvXQ0Q18pdrEH0VH5P47s+39/kQtOl1u12Y1Pk?=
 =?us-ascii?Q?9ie9v/rhpBBdpH5vg8nnBe01apmx+iHOCyE/9Z5/OWPFyOs05NIiPd6PkZTE?=
 =?us-ascii?Q?qYxOKCzybgcEcBoXpn8GR7Utlh1yjw3dWhuFANnJL9+Sd32ycyybYKz6D3Sn?=
 =?us-ascii?Q?blenh3Uo+3gZLT7njS6O+wsCpfIwU3IdjHAwvTDOlgG4hin6xnjHn5zTPn3N?=
 =?us-ascii?Q?UanevhmaNt8kg8sK90ehbAtAVAhXhgJEVv3z9bfFnCSiLi1W9BNFf5MUkG3Y?=
 =?us-ascii?Q?ksmkEO9fH6qsuu0eM9a0FxqJCg/ZBlLy7C3w2WT56qSJOVIKzVYr/9m9vIM3?=
 =?us-ascii?Q?LTtxIZhnryhtWBgqNEIXMqgrDjB5YfB2x67/ewvUFfCeaaYdgeL/Q8B7TrGE?=
 =?us-ascii?Q?YHSpDHhVwzEAms0/1dkp4vuDP2TCZcp+l8cOrcxRqBefcna5nVOZe6P53uDM?=
 =?us-ascii?Q?JnNl2sAAbRXQcrbA75cRev9/2+0JPOFZHtTjbvztnfI50LT1Z3iEK2lVqN8C?=
 =?us-ascii?Q?pk6hsekRVsuK89j/LRj0qxNaV8SgnYjFsG77iveX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93141478-98c5-424e-1a8f-08dd8e4c4e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 16:20:54.2102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwb7fm6toHaEjhy/RldTNCO5Mu+kKyM0RCIjsJ39T+a7+PaE7ZAzz7dU6hgytGB3kjmlybBsZ39LBTo+3bjk1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3331



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Thursday, May 8, 2025 5:29 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> andrew+netdev@lunn.ch; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: mana: Add handler for hardware
> servicing events
>=20
> On Wed, May 07, 2025 at 08:58:39AM -0700, Haiyang Zhang wrote:
> > To collaborate with hardware servicing events, upon receiving the
> special
> > EQE notification from the HW channel, remove the devices on this bus.
> > Then, after a waiting period based on the device specs, rescan the
> parent
> > bus to recover the devices.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 61 +++++++++++++++++++
> >  include/net/mana/gdma.h                       |  5 +-
> >  2 files changed, 65 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 4ffaf7588885..aa2ccf4d0ec6 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -352,11 +352,52 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8
> arm_bit)
> >  }
> >  EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
> >
> > +#define MANA_SERVICE_PERIOD 10
> > +
> > +struct mana_serv_work {
> > +	struct work_struct serv_work;
> > +	struct pci_dev *pdev;
> > +};
> > +
> > +static void mana_serv_func(struct work_struct *w)
> > +{
> > +	struct mana_serv_work *mns_wk =3D container_of(w, struct
> mana_serv_work, serv_work);
> > +	struct pci_dev *pdev =3D mns_wk->pdev;
> > +	struct pci_bus *bus, *parent;
> > +
> > +	if (!pdev)
> > +		goto out;
> > +
> > +	bus =3D pdev->bus;
> > +	if (!bus) {
> > +		dev_err(&pdev->dev, "MANA service: no bus\n");
> > +		goto out;
> > +	}
> > +
> > +	parent =3D bus->parent;
> > +	if (!parent) {
> > +		dev_err(&pdev->dev, "MANA service: no parent bus\n");
> > +		goto out;
> > +	}
> > +
> > +	pci_stop_and_remove_bus_device_locked(bus->self);
> > +
> > +	msleep(MANA_SERVICE_PERIOD * 1000);
> > +
> > +	pci_lock_rescan_remove();
> > +	pci_rescan_bus(parent);
> > +	pci_unlock_rescan_remove();
> > +
> > +out:
> > +	kfree(mns_wk);
>=20
> Shouldn't gc->in_service be set to false again?
>=20
> > +}
> > +
> >  static void mana_gd_process_eqe(struct gdma_queue *eq)
> >  {
> >  	u32 head =3D eq->head % (eq->queue_size / GDMA_EQE_SIZE);
> >  	struct gdma_context *gc =3D eq->gdma_dev->gdma_context;
> >  	struct gdma_eqe *eq_eqe_ptr =3D eq->queue_mem_ptr;
> > +	struct mana_serv_work *mns_wk;
> >  	union gdma_eqe_info eqe_info;
> >  	enum gdma_eqe_type type;
> >  	struct gdma_event event;
> > @@ -400,6 +441,26 @@ static void mana_gd_process_eqe(struct gdma_queue
> *eq)
> >  		eq->eq.callback(eq->eq.context, eq, &event);
> >  		break;
> >
> > +	case GDMA_EQE_HWC_FPGA_RECONFIG:
> > +	case GDMA_EQE_HWC_SOCMANA_CRASH:
>=20
> may be we also add a log(dev_dbg) to indicate if the servicing is for
> FPGA reconfig or socmana crash.

Thanks, I will add this.

- Haiyang

