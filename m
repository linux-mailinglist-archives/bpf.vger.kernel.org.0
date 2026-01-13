Return-Path: <bpf+bounces-78649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9ACD1682A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9F7309D288
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7634B18E;
	Tue, 13 Jan 2026 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W4lwFkcv"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F0834AAFC;
	Tue, 13 Jan 2026 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275039; cv=fail; b=mgmvYwqbwLKFZNgnxyLx9V8kuzLBpN+Zvx/FY2xsOSV8LO1izrO7pHOfI+l+pfVYUTSFgeYrZ4ZQ8eBdGih2XVd6kRXG/SAQNEeoRY4rMPJrzJY24f2q04lbG56JRjfYrY59hFFwMR8zpYKcL22QiOe2syyVbhCECL6P3/yzuqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275039; c=relaxed/simple;
	bh=l+uFkGO9bEVIfEnGUFzr2E6nxsieTb8yR6LszgqsGwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i3RQ7Eq7zmnUwFkU+p+flzYCSNy4ANhtmbDI+cQtlyy1elvfYpSyh15fDgqdJAXA+EqPK7TwFFiCiREGMIN4kBPBB2b9RtYboIFdWdVMRzbJCRHqr3timGkBPl+6cgZOBovpAsgS0kTO50I8qW6xgZSHRJQ5lZk9WH7C679elNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W4lwFkcv; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTlkkxdOiajxICDAoejVLaZ0VRW3Clkp434cYDWYJ//OdsBAdijJkUj5jjtftUzkrnv9F/4HZDoh9oLJISCYNVRT7IP/wdUa7JqOAv7/ba2QFTSLwHIR8Pu26yX2Le60uBzkJnUVnYae5Apv67nP08iJKLg6RqMm3wUlQzc1qM4q9IE+mO7c59qM+12mg8xQHopfbXI8fHMmPkTTliA4fWGIxYYxibNf6WpeI/MCCxKJ4dzYBtJPfukI4oyEEqWwi+b91l/PW30JH1OOdxagnQn377lrx+p7u+4uB5koCmRluWxcdUqcvXZ9v6FLb8kJvntGiJ/RrXoaAZi5OqvrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCbW1XYjBMdxeapt3izJrw1vAYc81Al8hzZkfHVQG1E=;
 b=COzRqUKiYNS5853PKovQxuoGfjwq6k0/RmGoMTWFdIBzCqpbUayjgT27JyOzjV+vYak4wkZeOEuwDs9P7Q9bLdBFVKlDP3TFWk8coRKEoA+VKmiz0LEPGgyXX52JwCEWxYm7FRYsbYehpxsx8m3W2x8vZpfAklyBznUFRxdo/RjC90gSImt4s0fhz7h7clVFZosBHx8ju8zLrvMvHCSBximLzcpR6VUi/3jqjv7U/oieEL5AJopAZexfrmt1CcHcvsVJOuCHw/3ZxTLZYjq8cn/36YMpSN+rUMbTpz33UmciTVwFYLU+Anx44CeYH0Rqt1L56NJ1mEk5i/L7LtmFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCbW1XYjBMdxeapt3izJrw1vAYc81Al8hzZkfHVQG1E=;
 b=W4lwFkcvgtKtTYaJHS6N1i6gIhq/o1FCvyxjs0M8f49ZElNEFi8fATRvxUoHtZydc8fkju/bx9jsW3T279CsXDD8dKDUn7aa21YMX4X9kUJNj5qcrregtqV4RpouHmmhc7ghWqkhgNpSgDarrMyQYpB1Z3CC76s0HdkrBnPFY1ll7tNUeae7/frWFPcV+Ltxfk/9pGNyi5z7dCHz+EG/22r25XpK8UaniTBM6qsO+GpAOfT6cPkp/ue+dA1VOLsfp87CguaEj9e5sd3daybQIKdgMI9BhIhrs1YuABP88cktG5RV6idbIpruiYMkHT2kjnrZIGXyxZM+2Hrnciqmog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 03:30:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 05/11] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Tue, 13 Jan 2026 11:29:33 +0800
Message-Id: <20260113032939.3705137-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113032939.3705137-1-wei.fang@nxp.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c16618-e0f7-4201-09d5-08de525419f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?msxmAAUguLMF4m+WJS1kGssPUP1VZLLxnxPnGD1Ws1keWqRQ1FI1KkPr0mji?=
 =?us-ascii?Q?FySAV2fEQ4Nt6Hop5NXnvkxPLMBcswhzMKZv8MBHELgWq1NiaHFdHk+eskNB?=
 =?us-ascii?Q?hDsVpjCir8knrWTv+ML9gXGomRuxhfrLM4QPrj0FXZK3aOibNlor4k1euo8X?=
 =?us-ascii?Q?dbl2Fdc7wxMbSEwTir/An+VvIufzxLMIXnauv6+o+yt89iuTXpcE1yhVrW8R?=
 =?us-ascii?Q?XMmzoO7onG8CwJp/b8vBvTpyrGvTF/0SBF84dNeWEZy4aljPzwTxOt7vROxN?=
 =?us-ascii?Q?3IQYQfL+HEnuaOiC65VGN/eFRieG4yj9qayJbBEGGQL8980PSOyup1K5jDqu?=
 =?us-ascii?Q?XbjHP4eBlbv+VUbuIx219uj/Sd5IZXuPd0qlNE35PTK2cw/B8212Jha6iQXX?=
 =?us-ascii?Q?pmN4VLYgEYI1tczvmFW5mZDi1Vzs0se/R6a3ZM0NpWMWW6PpMgE0cQW90J4V?=
 =?us-ascii?Q?W1+vziAOkVTYhuquPDp3cG0TnnJFK4WZcMbHI2+mrfnRfZvAWPwdIHmBuPDe?=
 =?us-ascii?Q?MjOZIPCjm/jGpjHGPVqwpSvkexgRUknlJo7ZPbhRwwZBpfgL/VCXvAYDUGBU?=
 =?us-ascii?Q?5FDNSKlWo7dWkF7X/i7Xz1JUb9K7XPw1FeDANK+xrd1AJoK8g0j+F1v9QWPE?=
 =?us-ascii?Q?1u5HwPN+2JksoR7IZEj2Qd3jW8TwwB3I9u9b8LAi+RnjoJpsNWEFzbTvtPAe?=
 =?us-ascii?Q?J53JJWLpKvF/r/j/Q1Hxdv5EFWsQAnCpHtYsN/bVrdvAEsCOVMym2X//cYXl?=
 =?us-ascii?Q?2zp5VfA4LnU1AfqIs6CYI9RaYl4EuT4FqWOqjKFST4eUzIysuQB4UQwLrKsU?=
 =?us-ascii?Q?fZTQ203MhWZ3PFiGd0DkwogbCtb4KorX4snzEJ3LGYZC31f8x628sFbyJD2G?=
 =?us-ascii?Q?9F7o5N3mjduFPI/PE2AaF81Dv3wBw3YwqYtUvthN2t26hJC9TPxapV4O/f0n?=
 =?us-ascii?Q?0cCEEYCVmGN2XLbcEV6iaAT+N9fDLHKhxc2q8zuddwniHo/VvxjnOJt9fPwU?=
 =?us-ascii?Q?JU2RauPXtAVuGRc5RJRKsPm34kwNymQEVdUE1edsPgLXdxbzvV8l+c8I0rFy?=
 =?us-ascii?Q?sVVjZhrH9rrgT9QD23kbP1aitgNx+4VOyVed4DV2cbXWJHAbPZOZ9ego7cS3?=
 =?us-ascii?Q?f5INSDG3t1UjWC4HzVGpoCPvbLTV6AqfH53KtM389MuhDjwuvvU2zK2L4dNO?=
 =?us-ascii?Q?cAO9YjelfhnunBK6ooy5q6ukgPl/mH5AL1zEOpVwx+uTUnMRQT8Y+uErriI7?=
 =?us-ascii?Q?aL4qhfISGI7ct1QsTWxN/F7qYHkRE3Sn8w2uvVOS3uX0KRG2RQUugsq9qP4+?=
 =?us-ascii?Q?PrxUWiCzQipxVg7C10PmUPnAoUk1vJr6SbgA5JWhCklMTb0PIvfE6vQtQ5Md?=
 =?us-ascii?Q?G6md3yQ5wL0O8sa/8ZpRrf3gcAaVGyHN8PUPNER+3gY8wvq5I5igk6D3tKZ1?=
 =?us-ascii?Q?QR6APz99d05zwOOADkEOqeatZI6yz8jmeJA8NgPkqzkPhjRijK1fR/fDH7Um?=
 =?us-ascii?Q?83DGf607jDLrfsFEj0R0lvueZ1cFxT8Hk4RCSlFCLuC0ETYUnzpZ3JEJUQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiKW6J5+XDwhMTtVmqC/w6TVTZ9zj3twtZEnIeuJ9fT7KoPw9b0TRwaFmX/F?=
 =?us-ascii?Q?43MN5CgFlwHf0D+owfsNyajxrgvSl81AxGbE7kJ3Ujj6GJiaupSZGUuwKf6J?=
 =?us-ascii?Q?jNTHRawC5v3COYX+FVAvaYzgMcmKJwh1bkJI2SRw4ezmPo3a1xL83UxsvJo6?=
 =?us-ascii?Q?H2YUjO+hsFIZWpeMBMvnMJY2XIBvKrEKK3U0yQNX4ZamPOCTj7NBT4s/EHvG?=
 =?us-ascii?Q?bOClTVHqhXrlCrD2NFaYI6CIoivbZ8AYFedPGFeg89j7XJgY2/+NfIylktfX?=
 =?us-ascii?Q?wLT1Hd/OJGs4jN7OY5LnT9v+u0QdIgEQ4g+Tkg4e1upmKvTGEJU5YUbLb5hl?=
 =?us-ascii?Q?xpAe138VKreJtwRgCpWRJ/0Bm6sqe1kA1TfRXgqNH7cIxkmPlB4ewME7Lhh0?=
 =?us-ascii?Q?sJ5KPvJu2qN/32nbeB6bOxKGgJGAKdD1WM3VuiAmn4NVhAdc6xqgb5TyPKIA?=
 =?us-ascii?Q?hz4vRyIY/JsWDCB/ZasfuO0KHCvFA/giXcSmcmssYFQ1xdsmIuAA9AdSH0ai?=
 =?us-ascii?Q?6/ZzmvV/2e8q8+I20umI0wDDqqy6poRFi0xWhWXVXKZA7Fq7MuSIpbaWtrHt?=
 =?us-ascii?Q?t62nP5RpKKYfPX+hQj9m9tP42WdHbbRiJXUunlWzuDPqcA+a7zRXhy7bFZ9/?=
 =?us-ascii?Q?uTYygTaAyoWDtQxVwNkAOt3O//4aKlGZrPO2pwrxfezWDrAc5JAK2GoKxRDq?=
 =?us-ascii?Q?IuUdduJQjaTpVGcRKED2UXdntG0v2AdimtUGT1NE4hLST8AlAbL0y54M0JYE?=
 =?us-ascii?Q?Fe2tkel29GeeFpMIUaPUYW0SnFU6xzePFurC4BrXkJMtIWnp67KT/YGra5Sg?=
 =?us-ascii?Q?uO8SvWBU5ieFlg6LruZNj8GQbI4i8mQdqkDkL1phgxaxE2JEznedLQcosY5p?=
 =?us-ascii?Q?mDihS6guvvgT/vAqT9js2Q+nJlS8QLRSG/Wq14c0HFbs44WvWUFyPA/3VOw9?=
 =?us-ascii?Q?yM7kcsMJCZoYqV+yPOsY8RLbt9b6yXKViGSpqdKezoTtRrTPCCQ/+xdOEPlV?=
 =?us-ascii?Q?y88jvEQmS7OYG7tfJBF3vRKGO8zBVwNiMoItDa51XESP6lBiFsfFVqPsb/GF?=
 =?us-ascii?Q?CkVFZQYvNCmGyExl5wBi5Ke38B3FyGDxnInex0LT/n7NVhpRhKOb/quAG6OY?=
 =?us-ascii?Q?MDL/UaA+KMobiZRoTR0ciTeZ9jPfPQTQwQ/efdMFNzwT91WfzfogxvwgSzAz?=
 =?us-ascii?Q?7PpiEYrZ5z3OXohYsR/f2pDTRRqutHEaolPsKYClQ0FwtmVMs0aMa1cpnQII?=
 =?us-ascii?Q?+XVTS8Vza7YDOqDdaVqS4VhMPwmHyXMgYW6dcUT9Zt7jrPax7t3YGvDOxlRa?=
 =?us-ascii?Q?avLxgC53YNedSch0MsT3JLMlHVDr2ToVmF2z1LixWzQVesh/Q7u1yYoNM49O?=
 =?us-ascii?Q?avAFoc7yASA3YyC44lbSigfTpOjpMufwwYoI7Zo+VPCkZSr5A/ImF2juiUNw?=
 =?us-ascii?Q?NuTA9/9wpfxlayFZ6BjGl9fh5mqSCx67pNyCC0Xkx4YPQnScQ0R4oRzUksmC?=
 =?us-ascii?Q?6Z1phWVDf2u1JlO31CBJ1bKQ3uEwKDB3YVbJNxkZJslDPdSDgKFnCKdFnPtV?=
 =?us-ascii?Q?4g4lMG1eobHh2lE/3RW6ErcJnp3BW+vi4wSMRh2E43x+UmQgQ256qQjTCyBO?=
 =?us-ascii?Q?jvTYwBfjvuC7uGPeWseTlCKC2aJ3oSc3BVTgh93R7QVfsF6QQYpZZ32Td93J?=
 =?us-ascii?Q?hYA9Aylx6mB3EKETQekFEF/GK+Ak3gpfyFnUzaNfvCgSoLARTlEvHXOVcAdH?=
 =?us-ascii?Q?H79kneVUNA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c16618-e0f7-4201-09d5-08de525419f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:30.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLcIB+LNo414i5myahpxdprz7zvqgIiH4IBJcqxQbpIMPIckR+47Z2FAHlDhnuuxujDmmx5p1ziXxRObrF9PAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

Currently, the processing of XDP path packets and protocol stack packets
are both mixed in fec_enet_rx_queue(), which makes the logic somewhat
confusing and debugging more difficult. Furthermore, some logic is not
needed by each other. For example, the kernel path does not need to call
xdp_init_buff(), and XDP path does not support swap_buffer(), etc. This
prevents XDP from achieving its maximum performance. Therefore, XDP path
packets processing has been separated from fec_enet_rx_queue() by adding
the fec_enet_rx_queue_xdp() function to optimize XDP path logic and
improve XDP performance.

The XDP performance on the iMX93 platform was compared before and after
applying this patch. Detailed results are as follows and we can see the
performance has been improved.

Env: i.MX93, packet size 64 bytes including FCS, only single core and RX
BD ring are used to receive packets, flow-control is off.

Before the patch is applied:
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s
Summary                   402,105 rx/s                  0 err,drop/s
Summary                   402,501 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s
Summary                   667,000 rx/s                  0 err/s
Summary                   667,960 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s
Summary                   208,502 rx/s                  0 err,drop/s
Summary                   208,797 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s
eth0->eth0                311,340 rx/s                  0 err,drop/s      311,339 xmit/s
eth0->eth0                312,030 rx/s                  0 err,drop/s      312,031 xmit/s

After the patch is applied:
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   409,975 rx/s                  0 err,drop/s
Summary                   411,073 rx/s                  0 err,drop/s
Summary                   410,940 rx/s                  0 err,drop/s
Summary                   407,818 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   700,681 rx/s                  0 err/s
Summary                   698,102 rx/s                  0 err/s
Summary                   695,025 rx/s                  0 err/s
Summary                   698,639 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   211,356 rx/s                  0 err,drop/s
Summary                   210,629 rx/s                  0 err,drop/s
Summary                   210,395 rx/s                  0 err,drop/s
Summary                   210,884 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                320,351 rx/s                  0 err,drop/s      320,348 xmit/s
eth0->eth0                318,988 rx/s                  0 err,drop/s      318,988 xmit/s
eth0->eth0                320,300 rx/s                  0 err,drop/s      320,306 xmit/s
eth0->eth0                320,156 rx/s                  0 err,drop/s      320,150 xmit/s

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 300 ++++++++++++++--------
 1 file changed, 189 insertions(+), 111 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7e8ac9d2a5ff..0b114a68cd8e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -79,7 +79,7 @@ static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len);
+				u32 dma_sync_len, int queue);
 
 #define DRIVER_NAME	"fec"
 
@@ -1665,71 +1665,6 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	return 0;
 }
 
-static u32
-fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
-		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
-{
-	unsigned int sync, len = xdp->data_end - xdp->data;
-	u32 ret = FEC_ENET_XDP_PASS;
-	struct page *page;
-	int err;
-	u32 act;
-
-	act = bpf_prog_run_xdp(prog, xdp);
-
-	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
-	 * max len CPU touch
-	 */
-	sync = xdp->data_end - xdp->data;
-	sync = max(sync, len);
-
-	switch (act) {
-	case XDP_PASS:
-		rxq->stats[RX_XDP_PASS]++;
-		ret = FEC_ENET_XDP_PASS;
-		break;
-
-	case XDP_REDIRECT:
-		rxq->stats[RX_XDP_REDIRECT]++;
-		err = xdp_do_redirect(fep->netdev, xdp, prog);
-		if (unlikely(err))
-			goto xdp_err;
-
-		ret = FEC_ENET_XDP_REDIR;
-		break;
-
-	case XDP_TX:
-		rxq->stats[RX_XDP_TX]++;
-		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
-		if (unlikely(err)) {
-			rxq->stats[RX_XDP_TX_ERRORS]++;
-			goto xdp_err;
-		}
-
-		ret = FEC_ENET_XDP_TX;
-		break;
-
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
-	case XDP_ABORTED:
-		fallthrough;    /* handle aborts by dropping packet */
-
-	case XDP_DROP:
-		rxq->stats[RX_XDP_DROP]++;
-xdp_err:
-		ret = FEC_ENET_XDP_CONSUMED;
-		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(rxq->page_pool, page, sync, true);
-		if (act != XDP_DROP)
-			trace_xdp_exception(fep->netdev, prog, act);
-		break;
-	}
-
-	return ret;
-}
-
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1839,26 +1774,20 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
  * not been given to the system, we just set the empty indicator,
  * effectively tossing the packet.
  */
-static int
-fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static int fec_enet_rx_queue(struct fec_enet_private *fep,
+			     int queue, int budget)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
-	struct bufdesc *bdp;
-	unsigned short status;
-	struct  sk_buff *skb;
-	ushort	pkt_len;
-	int	pkt_received = 0;
-	int	index = 0;
-	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
-	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
-	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
-	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
-	int cpu = smp_processor_id();
-	struct xdp_buff xdp;
+	int pkt_received = 0;
+	u16 status, pkt_len;
+	struct sk_buff *skb;
 	struct page *page;
-	__fec32 cbd_bufaddr;
+	dma_addr_t dma;
+	int index;
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1867,21 +1796,17 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 */
 	flush_cache_all();
 #endif
-	rxq = fep->rx_queue[queue_id];
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	bdp = rxq->bd.cur;
-	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
-
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
 		if (pkt_received >= budget)
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
@@ -1895,29 +1820,16 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
-		cbd_bufaddr = bdp->cbd_bufaddr;
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
 			goto rx_processing_done;
 		}
 
-		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(cbd_bufaddr),
-					pkt_len,
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
-		if (xdp_prog) {
-			xdp_buff_clear_frags_flag(&xdp);
-			/* subtract 16bit shift and FCS */
-			xdp_prepare_buff(&xdp, page_address(page),
-					 data_start, pkt_len - sub_len, false);
-			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
-			xdp_result |= ret;
-			if (ret != FEC_ENET_XDP_PASS)
-				goto rx_processing_done;
-		}
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1964,9 +1876,171 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		 */
 		writel(0, rxq->bd.reg_desc_active);
 	}
+
+	rxq->bd.cur = bdp;
+
+	return pkt_received;
+}
+
+static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
+			 struct xdp_buff *xdp, u32 sync)
+{
+	struct page *page = virt_to_head_page(xdp->data);
+
+	page_pool_put_page(rxq->page_pool, page, sync, true);
+}
+
+static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	struct xdp_buff xdp;
+	struct page *page;
+	u32 xdp_res = 0;
+	dma_addr_t dma;
+	int index, err;
+	u32 act, sync;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		page = rxq->rx_buf[index];
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
+
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
+					DMA_FROM_DEVICE);
+		prefetch(page_address(page));
+
+		xdp_buff_clear_frags_flag(&xdp);
+		/* subtract 16bit shift and FCS */
+		pkt_len -= sub_len;
+		xdp_prepare_buff(&xdp, page_address(page), data_start,
+				 pkt_len, false);
+
+		act = bpf_prog_run_xdp(prog, &xdp);
+		/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync
+		 * for_device cover max len CPU touch.
+		 */
+		sync = xdp.data_end - xdp.data;
+		sync = max(sync, pkt_len);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			/* The packet length includes FCS, but we don't want to
+			 * include that when passing upstream as it messes up
+			 * bridging applications.
+			 */
+			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
+			if (!skb) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_PASS);
+			} else {
+				napi_gro_receive(&fep->napi, skb);
+			}
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, &xdp, prog);
+			if (unlikely(err)) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync, queue);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_TX);
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			/* handle aborts by dropping packet */
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			fec_xdp_drop(rxq, &xdp, sync);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
 	rxq->bd.cur = bdp;
 
-	if (xdp_result & FEC_ENET_XDP_REDIR)
+	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
 	return pkt_received;
@@ -1975,11 +2049,17 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bpf_prog *prog = READ_ONCE(fep->xdp_prog);
 	int i, done = 0;
 
 	/* Make sure that AVB queues are processed first. */
-	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, i, budget - done);
+	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
+		if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
+						      prog);
+		else
+			done += fec_enet_rx_queue(fep, i, budget - done);
+	}
 
 	return done;
 }
@@ -3961,14 +4041,12 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len)
+				u32 dma_sync_len, int queue)
 {
-	struct fec_enet_priv_tx_q *txq;
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
 	struct netdev_queue *nq;
-	int queue, ret;
+	int ret;
 
-	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
-	txq = fep->tx_queue[queue];
 	nq = netdev_get_tx_queue(fep->netdev, queue);
 
 	__netif_tx_lock(nq, cpu);
-- 
2.34.1


