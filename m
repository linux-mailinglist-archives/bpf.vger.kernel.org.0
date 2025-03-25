Return-Path: <bpf+bounces-54698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22EDA7069C
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C067A17D8
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E025C71F;
	Tue, 25 Mar 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GG/JgKv9"
X-Original-To: bpf@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D2DF78;
	Tue, 25 Mar 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919587; cv=fail; b=oM8UfBPx8+3qPJQHmuoq9xf0uZ18KI8Eh2MAXKfw1VucBhPnTjZZuzNL2TfNk0nB3Cj/0VytZdhHhm73re7l8PLq9OQJ+tlfpfqEQT0MUVMkqbr/hPG/oRXpxMkPLPCqX6lzdqdbreGtct0aQPhfA78wxaueG9CH9GuPSD045XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919587; c=relaxed/simple;
	bh=XkgrraaP8rxiCtP/wyZgna8iOhukKDzKen0eSXolhek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLGgAjTaPEfKVWZ5+ZHcqpt/R1xtaJR5QDX49RylVTgQiiP+9QtmdpR14+OFUhEd/fyXtA6RV/JS1fQQ3AnIhOT6m0YcSd7gZTICe+zF/CVRcAFC35b2nEWYa/JC2w01MnAYO5I0SAMFNiycMg62154KFDxH6Iww20u4PJ8Ab8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GG/JgKv9; arc=fail smtp.client-ip=40.93.198.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz94Nfa33ScI1ySKysjd0T8iXsmmKUf3jQWxGGc2sn/v/NPuRWFw7kWq7jkoB6DOlmKFmR/+bd2T2fPxVxEzoYyalU6MCG7rI+g1UNgK62QtJ/e7P9pqzAVJBtXW8A/mIjjdR2GgOuIga5BoHVyGXhTdUVBa6ve9m14X1aNyrLmnSEVasvCpiiphydLdKh17b6kKYNRHm+8K1L+727MskVpA10k+l+Hl82flo3S8Yq4n42xGLJwcjNjR+2gry6E4pGiN6e2GlC0j6Kp6iyM8Wbhb9mj2srLLHFBw3bxV2BSr8ZW9DGEQ40UFZPHSy99309F1ae4mGqHN2fcGnHw4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkgrraaP8rxiCtP/wyZgna8iOhukKDzKen0eSXolhek=;
 b=F5KVHyOOFJXrmUQmRmD0OYrk858D7DrnNZB2Bq4RDjEXS1R4IUQxVe8kQOoXQuqGgCAcbEdZEjOuBMJnl2G+GTt0nq0rokC0HgmTMG/O8RSLZx7S2ELC5OtL0bFbR4NOTG5JlAmspoLdNs0HlUxN/sGPIKnsEvGII4LzEk3YcBR7x5SgEptacUZ7CJf8GbGMPGQ1vr8xPjTxolb1Kt46d/7DYkxzTUZ4+yvlRzGQss+B5+UYzxpXklNOFMyfQ8MrmEohx7EeRYkARGcPZSjvwmL41GsiOCS9gBzWhm02QSO+2EScF8rn2zgVTxuXk7GyNIb5IvpENhzTcLRq+fUzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkgrraaP8rxiCtP/wyZgna8iOhukKDzKen0eSXolhek=;
 b=GG/JgKv9KviAFlL/qyyqLTD1ER2LoOFd9e3k55h2vT1OSphASr7VRhJv4Weh82uAnBDd947TxHg2hVsS3Ijgu8a1HWxUgp01ec017ozPtVyxoFWf0adQxUa3YZsETuiiHuZ6v4YARhEybejU0qiwPzh8JCGpaz96lH63MSsoi0E=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL1PR21MB3256.namprd21.prod.outlook.com (2603:10b6:208:398::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.25; Tue, 25 Mar
 2025 16:19:42 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684%5]) with mapi id 15.20.8583.023; Tue, 25 Mar 2025
 16:19:42 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net] net: mana: Switch to page pool for
 jumbo frames
Thread-Topic: [EXTERNAL] Re: [PATCH net] net: mana: Switch to page pool for
 jumbo frames
Thread-Index: AQHbmsaSlJBPb3cqM0Gn5oRfnPsIUbOEDCqAgAABD7A=
Date: Tue, 25 Mar 2025 16:19:42 +0000
Message-ID:
 <MN0PR21MB34373C46ADA00725818EA381CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1742605475-26937-1-git-send-email-haiyangz@microsoft.com>
 <20250325091335.6833ed27@kernel.org>
In-Reply-To: <20250325091335.6833ed27@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9c45c4e0-11a3-4cec-810e-d00a60deba1a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-25T16:17:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL1PR21MB3256:EE_
x-ms-office365-filtering-correlation-id: b9a12f06-4076-4452-ddca-08dd6bb8d997
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?t8MILOESENVLlWjJp0+gdIftNa2V7e0JRCkGZg8tjWdw6nk1GsMcvGj9ZXYF?=
 =?us-ascii?Q?G33lxerA2lsddBEO873ENVZYnTl5q4x1xD3xNKuJpfA771BJLLM66mHJxA8N?=
 =?us-ascii?Q?oKa32E+ExOXhsUMVehJss3RVp1YtMQmNngmNdlVSieEgyacvGr19Gby+PZhg?=
 =?us-ascii?Q?YwZSiDWFsMrr/wClZNsdV9o9vLBpqcVru/oe+gPqdNq+BqegNotYVNY0Dvx9?=
 =?us-ascii?Q?CnJBlwws39h20lD1b5+NfYQVlpa0113l6VKXXyStm2gFd8GoMGFQPH2DppBB?=
 =?us-ascii?Q?XKaCF0D7mnaVLhN9MkfAkd3koefw4zR5o2T0NO8ySWYB+5HW05iUgs+rnTFu?=
 =?us-ascii?Q?+UONz8D2H9ybmr2k2RJ/VDSgxhAe1i8lSdnZrKyZgJt64bgtjlEwXo38Zl7c?=
 =?us-ascii?Q?JH0Tw/S+HBhrbjNW8f/f2rNHE3BeSeznKJF3DshSsdVIcb+lUZjDG76g5Gyk?=
 =?us-ascii?Q?iCIApimhNZHuX+5FHWjr57gCD2zEDFWoZPL3MH960RkRRRoo7maKsatywVyg?=
 =?us-ascii?Q?51OhnD54lTTh84l1epJi5e3Zlt5tbUyBoOUj0wmq6zZFNaGewwtTU5U+7Xq/?=
 =?us-ascii?Q?IbNaPucbXCFntEdTrtriHlueiH7YUCgg28pi6Ip7757eZqLJuW1oarqP2x/5?=
 =?us-ascii?Q?EXh4B3u0FvlNbxP1UXJnmvJGf6seKf47eAhZxlh13VU+5FcMgztWS8tbRpsn?=
 =?us-ascii?Q?tmxt7RiWv3EDkttTV1BpT/wtrdlw+WPsu/IPO/AVq60ac8+olBTeRkzT17j1?=
 =?us-ascii?Q?6PO/3Qc9TGHIwzIRddrepviymfnTxaJJdKNMOj73NIhvyzv8NxhDdWfHmzjR?=
 =?us-ascii?Q?eDhnnF2IXfRQJTNvPFqs052pEV5Edg5XynA1ZbwlFVyYJfeBpkUVlyLYjXU5?=
 =?us-ascii?Q?aqJ/K70vsMfI1hqpbJ4FHbh1UpgLkJZwTljtowlg6rwrwnYTZFMVUEglQJlC?=
 =?us-ascii?Q?sCX8sYtuFdM9bXywzCD5FU/ehnyFQ12uAfevvPt+pT8ALq6D/ASq1w2ULa6X?=
 =?us-ascii?Q?bWl27BS0T5s7ClNc5JzvgxPxnWgWTArNUTeF1FJd27EwpLgtUkhRxNow65rd?=
 =?us-ascii?Q?pFfzNMnyz8HkokJhHShDhcfDRR5iI98twJY8AM5eGoxtGckiIyrhE9Z3xwNG?=
 =?us-ascii?Q?VNwVlHeuOgFcpfJzrIFqAkfytzU4h+/m6i1mus40MUF2eIuEA2hriAUoUMnM?=
 =?us-ascii?Q?FZGIiy8Sx79vpiTGXZb9Wq0pDknO9sVYXl20Jv2qqkd/9gkQaEktmcap2CJ5?=
 =?us-ascii?Q?dcOB+oNggbVBbYOCCUiQ4J9TPJUAwuUDGSbZDad9Y72e2c2z8WYll0d5XQiN?=
 =?us-ascii?Q?hAa4IhWfpr5wzZZcS640/WIqocpuJNomuuloGS3QK17+szY8+Kiba8a7wGkY?=
 =?us-ascii?Q?eA+1Q6JUFvze+kfL1l1ddZ3/NeD9xI52JimvChDZdBBBkWdd1UXo+pNw99qm?=
 =?us-ascii?Q?tvzk5UCCpCSsMPbJkkgdukYNHOQG9ordzjibk3uSGoO63OWSk2yWQVZVRwXL?=
 =?us-ascii?Q?M1IvUnf3m+UlCME=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?etWsutylyjkMDYZP0qTfyKJGbPCPAJhcwd8Xmlk1rMdntO7l6fl+gGANLlJM?=
 =?us-ascii?Q?fjWVVS8BuV3CHFDMXo+gfiCwZ1HIhL2jMY5A9n0891g6jaXZ4IoXiX6mqWhX?=
 =?us-ascii?Q?FWVY6SMS6u5wAIRYmZULNGYGcAGnVRUH/SObBpP8yU3DKM2rURCFxXgiQ7Lh?=
 =?us-ascii?Q?RzA1F/d7G1eNOhe7vhZpc5EhuQen3D5Xt+iGTrrCEE2hgiMq/WzGf7QkI33l?=
 =?us-ascii?Q?Hpbo/ZrCBJwCIDW3FXg4gZLmFzh7Bw2sLq7r8wwLojRYe5kn9oXiRyAkEWUJ?=
 =?us-ascii?Q?D8rajzZS9bNCYCsC7s3IqI6EapFqZlnMp/jbhhKRmnIq8Lw7Qnd0jTiCozkE?=
 =?us-ascii?Q?aWX0R7YF6V8xng75UxzJVV5jGb6SgKIoV+ViErOB/1iFEN0ADTo5jNK0A6Ls?=
 =?us-ascii?Q?/2jlsOyDUizy3AdhfNj7DpP68Lp/dceROZ6BwD+ErATC9x2+Gf9rQQo5TJ3S?=
 =?us-ascii?Q?JuA9n4yTxc4x2s8gcOGV77mqWhFEcUj34I5OgCo/fOYZC4pvOau8lxsr1HdG?=
 =?us-ascii?Q?K3GXYSDQE0nAmtp2hKeZxo2DUup4Axcyce4AAZO0e6BvwzI5n+WLP+6ceLtO?=
 =?us-ascii?Q?CxhvGuc6vkQWFLB1WQDxbMZT0G+eWQ8RD1rxuuNMVpc20aV+hqHflQHkvkFD?=
 =?us-ascii?Q?YW07EpXGJNdLo+Ko7ijRkIf4XdujkIKQivINxQ8HB+HLqh7rpOh3QdWBNMx+?=
 =?us-ascii?Q?HXVb6+qTezACMhxpb2jxmJJj3Q4kHaMswuDL6cY683hXJEaXxtcf+P8bb8dl?=
 =?us-ascii?Q?g+8ODH/ott0kCYa8n1fsjXKfP/YH3ooWaEQj8lhaOZb4ziELEpcwu0mx36VZ?=
 =?us-ascii?Q?F8XKLYFTjUsYjPFmCbaqf5bdzSkmpaeKNT9u8DB3JCJh8lvi/FQkn2NyIRhH?=
 =?us-ascii?Q?WPHMhScNsQ8dVzJE1gdFQQWap0xHEwHj/x4Dyw92lD5xcc06WInS3Ao+LY69?=
 =?us-ascii?Q?kHQYqxlUPpr0oDN2BZ9e6N8lIcvs5nf2bCDnv4/VUdIKiSBaflMRqqQXu48V?=
 =?us-ascii?Q?XPrPw19BPQ0SIs3vHqXeVnpz2XXks7mrr2as18EZQeP6eMagVWDqovnyce6G?=
 =?us-ascii?Q?iZNOC+pHRpkI2d9C2df9A/km/+iMbklpQJbx+E/Tuhhomhkl7HzGDjWbVcEr?=
 =?us-ascii?Q?WcmKB1nMtiJFomU6OhCTMCPKzw8+Hm31ab+oI1XcU1Vh9LqQS6M+xZbFn/9M?=
 =?us-ascii?Q?cwQywVjmRKh5VLn54Rvt4BKgwb68mcl20VpdQ00onCFB4EVxNJbUCXBUeBuK?=
 =?us-ascii?Q?ZXAcKPWMh43f4+i9go3ELxaqB10QjzeyGxEMBvrTgkwTGw5RRhwiP3MMEv7y?=
 =?us-ascii?Q?jeCCh4dOClr8kW3q4e0oNaMZpBRFRK3G2E0rkpHopozQ8P7q94hOHgeOg0Ai?=
 =?us-ascii?Q?2rw1SNrJW9/BQ7Td/Xp32FzSAWtfgofOYZr791wRV39gdK5mBnuzCe0cm7Q3?=
 =?us-ascii?Q?OiZ6S71hArl256qxHg4jxhCGQc+ZbwTUeD9RxEGaJeIZeUXt/NIavUyr8Roj?=
 =?us-ascii?Q?3xRBvHKwOZBsjVFs76YI3CfPKb+Qwh4uk6BE1o/yml73aDYqR/bzrNddlxwu?=
 =?us-ascii?Q?Fn/F/R6Ddx4Z8r5xjvOZxtjwdSqSMHbXGakWoFmd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a12f06-4076-4452-ddca-08dd6bb8d997
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 16:19:42.4918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xk99OJHRTi8hW8Ga6ZuYjgAU+YJIaY27bAK5ondJzAZdO0568HwBcci1BxooMXdJH+UPPjh1TNJrmyMOYSAn8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3256



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, March 25, 2025 12:14 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; pabeni@redhat.com;
> leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net] net: mana: Switch to page pool for
> jumbo frames
>=20
> On Fri, 21 Mar 2025 18:04:35 -0700 Haiyang Zhang wrote:
> > Since commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
> > page_frag_alloc_align()"), the netdev_alloc_frag() no longer works for
> > fragsz > PAGE_SIZE. And, this behavior is by design.
>=20
> This is inaccurate, AFAIU. The user of frag allocator with fragsz >
> PAGE_SIZE has _always_ been incorrect. It's just that it fails in
> a more obvious way now? Please correct the commit message.

Yes. I will correct the msg.

