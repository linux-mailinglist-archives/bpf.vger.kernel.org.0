Return-Path: <bpf+bounces-40475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A29892D8
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 05:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F371F239CD
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 03:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51DE3B1AC;
	Sun, 29 Sep 2024 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TUTIHQ61"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0729CFB;
	Sun, 29 Sep 2024 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727578849; cv=fail; b=C13uGNcbTWsL1i4dwHAqikSvpeLv31v1cbYYluGschSxrokykFiLgI+OpyGcYGYWANvNSsdbjnipNuX+NaBCtGodA0yNbxTe2tKjGMGQKW8q6HZsDhsC0+hkVlZef8+qdY8/ZeHioRY9zNSXRI82t952Q7t0IOrUtWc780Kjkn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727578849; c=relaxed/simple;
	bh=Dt0DsktHw3T9HCoveP76x7M4ForUVbak9L9RgESctOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hsPJKWSYpheZ5uh0/jI8dRijA7Tc1jG+ixGLCHL8Z2pHMRTjCtNq5Ik9JgX9LADSHv+1LRiE7FYZ5S+A15fkSCS8ZLlfaR87zVNoQ4v6LOBbHJNxWUylKioV09TohkmWw7V68M3MgRW3Ve868NdVlPfriXagdT6yU6Q/ymh0vu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TUTIHQ61; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkHKM2jNxBWZfeA5cNtx5/NlKyqBKZMzFuWt7b0gbreRMnYgyzWH/Xu1libpPaE8zlIHG9c92K2Zd8eKOjpbYaS1auVszfYZcq10UG/lLALqM926krHl4XfK41mw5Z6JdF8glwmBVMdwgz9y0XnuHM4fhgkCcEnJD7XtncIrUnRgFDk2QFiah3wT1rqoe/WLEuk848jmS3+whX+kN7N/xlb0VN15+fO1r+PbH+V/1c1ZA6yGym7kbGqFgW6b23tfNSROEyXbZ2Q0m1LGO5tvO87MzVFj94UgFwhFXSTU3LXnUGmIMeMhBT8adq8wOiV25nTN5qmU14DiAM09nMAHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y41x+Ww1ZCQDuSCxCKrcVKJipkciLJZIOVGdc5fTRIU=;
 b=jkSpRYlzMlDTChW9bBR1wkBptNUeMcPFIrnSnMR0pSufBC/DCEAMFJ/ez5Vs9LlCeQlNGzddCbLDJEpQ/LaTslzFz/3HEhwXNb7WVfZ4hz3gqOWnmJFu/ny016l0z6mS/PUW2Znm/4M4BCJtWKcIldwT8MEjZGbQ6SZAfhLQjVqT80hR5BZoH+pEF8JmBZSB1mApQR+t9nwyPyepqXUR1cA06PRLKDBkfZzwG9nTwh+rhrSUp9Xp0GgbhG6anEsBJ5RoBQvMVDQJdLF0Hh7mgdtM5ZnJ0tE0Jld3oqsl8REBtfVKnLjOP5zR/z3k5Y3bCrqe6KzhYXI4yA6pzGAIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y41x+Ww1ZCQDuSCxCKrcVKJipkciLJZIOVGdc5fTRIU=;
 b=TUTIHQ61QXgZbvP4MkjOPvk3sQ3p2wweNCYXcNYRGkXkTun+xWP2lnHjrD5CRLMJz/Qxmi3P/AcDbNYwOvmAlxFwx/sa9V6ZnK0NmQpm3IKEkPi9ZzbXyJhn8DNS9p564QXWHUdjZ8qtN4Hc/sCa4WzOQeJBo7uYu+hYyTSSagzNMlEVK4itQWp1QE1yhgON94tR63RMjiOc2DpuohJ144ULUhfWRzhul18yiPD9EL2CGiZj6emLjRhMkdk6tLR3viKB8MO/ZjWX7yJ3KEQkpni0UmHFr4zOcm2HMwpa6glbIFSj8seG1GQl6PtPuxZfoyk3PZdcKZpTQCft5DcyIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10690.eurprd04.prod.outlook.com (2603:10a6:800:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 03:00:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Sun, 29 Sep 2024
 03:00:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	imx@lists.linux.dev,
	rkannoth@marvell.com,
	maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: [PATCH v2 net 2/3] net: enetc: fix the issues of XDP_REDIRECT feature
Date: Sun, 29 Sep 2024 10:45:05 +0800
Message-Id: <20240929024506.1527828-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240929024506.1527828-1-wei.fang@nxp.com>
References: <20240929024506.1527828-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10690:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4a3041-8af1-4479-3e1d-08dce032e91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y77iRpOWN0jffu5zLese1YOF0Lnerl+/PJe3w9wdcUlAaYYcd7ZV4hTdnEV7?=
 =?us-ascii?Q?L/lTVpaZnUWP7A71xFpQY6tfEhtAaD7E9j8wkttiF2hBc3tOABvJ8lmOW18o?=
 =?us-ascii?Q?KspZEguNbaMR52aqnu5KgzXmat/jKr8OVnkrg9YMHMnPPPtuBn/3hKFsf058?=
 =?us-ascii?Q?OX0nXRyeofnPpCwITOc0r+rLARpKNoBlAAPL7T2kJazJD3tLl8f+px3/FiEr?=
 =?us-ascii?Q?aEJ/KDnPcUhwAMd/+yiD6xzS6g9klFJErgFKuVshMCval7ZWSVRIes5TDnPp?=
 =?us-ascii?Q?0/uW6BxAuG9TeLrDe8jzl7PMiXGDVRi+dsSXdlAxnMvec/tZ/bCsXldb26hd?=
 =?us-ascii?Q?y7vZfQEKmJz99yvT8OzaLuxz2YN5DOmUUGAAdNvvm3AdYpkvtuX0HXFm00yF?=
 =?us-ascii?Q?O3fkaVKQUzHRAAEafHa92yULn4QGMx/5BTyWVhWy/ODRkJYuSHkyzOlSqdiM?=
 =?us-ascii?Q?XpvdjsmYXXeV7buhyUYRqsKJzLx3PnY0yzJnSRyNlDOdBPKzYGcDUrpJ88Rz?=
 =?us-ascii?Q?Wfl47yJVkZRRvcxHTV5H0j02yie6ddG6GsLGZBq3osdfAIpzTjOuhBRcgeXw?=
 =?us-ascii?Q?Tbcdhgj29REMQlljJnn8fkR9Y7Nkf8SjneiCbcJn/DKgdibQDIBbDY3stgau?=
 =?us-ascii?Q?Jmoc9ij5sbqKsc3E4RlhziR5Rdub9Qvgf4i6Ig+RXBEvF95ZuHsTNbckd7Rh?=
 =?us-ascii?Q?STyu4dcEvZ+9Qt4VuhclGnaDi57NJ8MO5+iGMAzlu/AveEImxKImR58KY6uY?=
 =?us-ascii?Q?4OkG/IZWtrxkCN9I6FpFp+28cV77lJUUckSracyOzY009VYhCBiGcqpTH2NC?=
 =?us-ascii?Q?zcdjs/C4MA84eDzQLLbFHKyAfj6MYob/DVD1zwzTsr/parwetlGnvT7FcDsv?=
 =?us-ascii?Q?qmrwmUDDE57DOwrXTYIBJ6vgQ0OfNObjUiQ3piI6MBNILlk4A/O1YvlgBG9v?=
 =?us-ascii?Q?UHSUHBEz8f27uQMyB8CQvJzqEe1phZIN+Rt2T/RJgqgiiZv5A1xUF4chz0VX?=
 =?us-ascii?Q?1914EvRTy5jKQZY0NC8D4Mnm7MrkdRV/bYwsjOgKLJRRTfE2SuPtlmnFZJcf?=
 =?us-ascii?Q?GPCqw/VG2ns8dM86YUJwU+S6norB8gSWq9wR/2ctHlix+9+LhyWyHf5RAfQZ?=
 =?us-ascii?Q?esxz6mX2TbmUL5OOHh0mqZlgs7T49Qn/igJij+xU4QnT7rsJIv0qPi3ZblRc?=
 =?us-ascii?Q?KfpLcA/nxMf6NfU8WBztveOIA9P8tiZV7nnOQ4Nsue2k3CQurvaBNZ90HbJr?=
 =?us-ascii?Q?0gQOva4CC259t/ZGloow+A6pk3sRdxB8boihi04W7FqAa99CcRYbYiUfW0Yb?=
 =?us-ascii?Q?mam/SqSATge0+euWsDCYTVvS9HhvyN8PRRpPu0rspHkRKynHYKeGOxNPmbz5?=
 =?us-ascii?Q?gws35x5CZLAZTATQg50eEFL4+a9pjdwzSJEIt0EhYe7/laJAeh1h+PEIL2LK?=
 =?us-ascii?Q?pswTRerYBsc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2hBmbntK4XoZcYPmctfGfp7vfEEPBt5CET36TieJyFD4oOUENWTR+Q/8LBF?=
 =?us-ascii?Q?CtlS9D8VoTMHfCin48hXEjsEpjquAjHk8KigIeQJHRlk4YADOMJ60NwH3fgL?=
 =?us-ascii?Q?AhHAufD3NH9tLT1bgXDzntNPQOoP8s/e1hmKeyIqRWEDjmp8tHiLFA+2bDqv?=
 =?us-ascii?Q?/XPWRCrV3VJuMoR/eoAqvf2cJEVpXf3dhjk+Cw4m97g20Tqom5S69fEPX2lW?=
 =?us-ascii?Q?+RCcFLU6OjbaGKJH8/yfvGPejbMDqlhLPJEXvL1aiFhNyBlb2GO5hx5QJXsr?=
 =?us-ascii?Q?tD0WX3IZnzmZOINfBzIyLZGgvMcYl2v7gLCNHn4BTAZblifeiH4klffsSMr3?=
 =?us-ascii?Q?4xK+AyNazS3yAp3CpUsm428e2I+L2hlU2K/6+nZwVKjYDlP4luMtJ3HtWBt/?=
 =?us-ascii?Q?8DDb5ItEPPmoUgS6IyenmtlvbAM/B8ZqaSGInNFpJVL3gRAPrI6ASNf3yYdN?=
 =?us-ascii?Q?9ucwJk4dlx211Nx2PxvCGj+BCq9Kw6wiGAV7j2KV3L35Dmwa6o+QRAwxNhlp?=
 =?us-ascii?Q?pCt0kG48NDMWdZmkzNqmrMjHgmTjjKNG0yO2iy/ysTfl4T2FX6VNM5utjO3R?=
 =?us-ascii?Q?CryueZTI/HE3tMlW6Ik4c1l8NGAjYDqWXikLJlYCCXoIhWW7BAhxPuRJRFF3?=
 =?us-ascii?Q?PZsHtzsZHBzRbYG45IrhF/b7P8BbAPAJjbTXxTv21P9ulpDsVoVnY7QG60z+?=
 =?us-ascii?Q?S3YnRDQQXRCe6KHOsOcAhQvQ4t2yIQpAJDf9iGGLTPH4fjvCGbFwTA6+yF/R?=
 =?us-ascii?Q?SYu4kVAgkUpixzq0Re/pcG3sSqOdhi3jtv0wSNGghKb+v43KSk/ySHP1WKhP?=
 =?us-ascii?Q?cHSrIdt/xeffSWTBoyfbKwLfMq/wiFYMk2SryZtRGQvWTA9He1SLfbxJR4IH?=
 =?us-ascii?Q?AjpUtKprDbb091q1U05z994A5UuhbPfvSTP8oIF00EP/3WOgA4jdUjfjNczK?=
 =?us-ascii?Q?NKoQp4DeocdqikbFbKEuxT6Ib1CVNjnetxpnJAY0zG4FfDn+ftsLZYln/vAQ?=
 =?us-ascii?Q?WKXaExb+5FYZnnRzGZfUdMuzT6O+xlvuSnsQqfJPA02R1+eX8ufoUX+uav51?=
 =?us-ascii?Q?lo1GSVPeixCOEluFmgHgmYgvjiMZaXt6K4T2VPU69kJaAWe8AoQjPE7ZqOK+?=
 =?us-ascii?Q?UIzRtPuqb++HvD+juq6ckqV7L06njsfV7nRKN+VCu9WmGkrcmazKEyLhc2Qe?=
 =?us-ascii?Q?US6oL6EVcjnF0NGcHtfnljqOMjPJd8CZXTVWLLNIPv30QYdvDWmcDhikuu1z?=
 =?us-ascii?Q?uNQWZ4OQAYSjb4WuK8nvxs8UJkNKlfFAXGnlgYmzYoUsKgqZEFL5si4VjGR3?=
 =?us-ascii?Q?7mL5LiLuzN2MRAAKzI61bhZ+eb5yrWqjsvoOTPxtmgQrsPESx14pWLnRkBQn?=
 =?us-ascii?Q?blSNHTb8+P9SSLHfAhpbx29nwpNcfI+DJtnmcHSeQbvBmiY809wa4TV5UGNs?=
 =?us-ascii?Q?gE/80nY45KIOXPkHemOMgb77SJlJ6grg0lIgaAG5yLebw1P8xvuZ1bSqAxxm?=
 =?us-ascii?Q?WVHur9cJM8xceRKKB9w4QvBV9noVKgJUs8i+pYlz2WUtBqr80ioRVR8mm0wy?=
 =?us-ascii?Q?kJZPtYV6dAdvGxUVsO2NRQ9PfdwZmHTCa1udtu5h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4a3041-8af1-4479-3e1d-08dce032e91d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 03:00:44.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tJEz85tUSuB8JejL9mYnU1IdOcEks6KI888iS3tVxRYr+Lz9SYNCKYVTKudwtw+aqVipK8lf0iE/uVmifW73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10690

When testing the XDP_REDIRECT function on the LS1028A platform, we
found a very reproducible issue that the Tx frames can no longer be
sent out even if XDP_REDIRECT is turned off. Specifically, if there
is a lot of traffic on Rx direction, when XDP_REDIRECT is turned on,
the console may display some warnings like "timeout for tx ring #6
clear", and all redirected frames will be dropped, the detaild log
is as follows.

root@ls1028ardb:~# ./xdp-bench redirect eno0 eno2
Redirecting from eno0 (ifindex 3; driver fsl_enetc) to eno2 (ifindex 4; driver fsl_enetc)
[203.849809] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #5 clear
[204.006051] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #6 clear
[204.161944] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #7 clear
eno0->eno2     1420505 rx/s       1420590 err,drop/s      0 xmit/s
  xmit eno0->eno2    0 xmit/s     1420590 drop/s     0 drv_err/s     15.71 bulk-avg
eno0->eno2     1420484 rx/s       1420485 err,drop/s      0 xmit/s
  xmit eno0->eno2    0 xmit/s     1420485 drop/s     0 drv_err/s     15.71 bulk-avg

By analyzing the XDP_REDIRECT implementation of enetc driver, we
found two problems. First, enetc driver will reconfigure Tx and
Rx BD rings when a bpf program is installed or uninstalled, but
there is no mechanisms to block the redirected frames when enetc
driver reconfigures BD rings. So introduce ENETC_TX_DOWN flag to
prevent the redirected frames to be attached to Tx BD rings.

Second, Tx BD rings are disabled first in enetc_stop() and then
wait for empty. This operation is not safe while the Tx BD ring
is actively transmitting frames, and will cause the ring to not
be empty and hardware exception. As described in the block guide
of LS1028A NETC, software should only disable an active ring after
all pending ring entries have been consumed (i.e. when PI = CI).
Disabling a transmit ring that is actively processing BDs risks
a HW-SW race hazard whereby a hardware resource becomes assigned
to work on one or more ring entries only to have those entries be
removed due to the ring becoming disabled. So the correct behavior
is that the software stops putting frames on the Tx BD rings (this
is what ENETC_TX_DOWN does), then waits for the Tx BD rings to be
empty, and finally disables the Tx BD rings.

Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v2 changes:
Remove a blank line from the end of enetc_disable_tx_bdrs().
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 44 +++++++++++++++-----
 drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 56e59721ec7d..138c0a36f033 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -902,6 +902,7 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
+		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
 		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
@@ -1377,6 +1378,9 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	int xdp_tx_bd_cnt, i, k;
 	int xdp_tx_frm_cnt = 0;
 
+	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
+		return -ENETDOWN;
+
 	enetc_lock_mdio();
 
 	tx_ring = priv->xdp_tx_ring[smp_processor_id()];
@@ -2223,18 +2227,24 @@ static void enetc_enable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 	enetc_rxbdr_wr(hw, idx, ENETC_RBMR, rbmr);
 }
 
-static void enetc_enable_bdrs(struct enetc_ndev_priv *priv)
+static void enetc_enable_rx_bdrs(struct enetc_ndev_priv *priv)
 {
 	struct enetc_hw *hw = &priv->si->hw;
 	int i;
 
-	for (i = 0; i < priv->num_tx_rings; i++)
-		enetc_enable_txbdr(hw, priv->tx_ring[i]);
-
 	for (i = 0; i < priv->num_rx_rings; i++)
 		enetc_enable_rxbdr(hw, priv->rx_ring[i]);
 }
 
+static void enetc_enable_tx_bdrs(struct enetc_ndev_priv *priv)
+{
+	struct enetc_hw *hw = &priv->si->hw;
+	int i;
+
+	for (i = 0; i < priv->num_tx_rings; i++)
+		enetc_enable_txbdr(hw, priv->tx_ring[i]);
+}
+
 static void enetc_disable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 {
 	int idx = rx_ring->index;
@@ -2251,18 +2261,24 @@ static void enetc_disable_txbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 	enetc_txbdr_wr(hw, idx, ENETC_TBMR, 0);
 }
 
-static void enetc_disable_bdrs(struct enetc_ndev_priv *priv)
+static void enetc_disable_rx_bdrs(struct enetc_ndev_priv *priv)
 {
 	struct enetc_hw *hw = &priv->si->hw;
 	int i;
 
-	for (i = 0; i < priv->num_tx_rings; i++)
-		enetc_disable_txbdr(hw, priv->tx_ring[i]);
-
 	for (i = 0; i < priv->num_rx_rings; i++)
 		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
 }
 
+static void enetc_disable_tx_bdrs(struct enetc_ndev_priv *priv)
+{
+	struct enetc_hw *hw = &priv->si->hw;
+	int i;
+
+	for (i = 0; i < priv->num_tx_rings; i++)
+		enetc_disable_txbdr(hw, priv->tx_ring[i]);
+}
+
 static void enetc_wait_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 {
 	int delay = 8, timeout = 100;
@@ -2452,6 +2468,8 @@ void enetc_start(struct net_device *ndev)
 
 	enetc_setup_interrupts(priv);
 
+	enetc_enable_tx_bdrs(priv);
+
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
 					 ENETC_BDR_INT_BASE_IDX + i);
@@ -2460,9 +2478,11 @@ void enetc_start(struct net_device *ndev)
 		enable_irq(irq);
 	}
 
-	enetc_enable_bdrs(priv);
+	enetc_enable_rx_bdrs(priv);
 
 	netif_tx_start_all_queues(ndev);
+
+	clear_bit(ENETC_TX_DOWN, &priv->flags);
 }
 EXPORT_SYMBOL_GPL(enetc_start);
 
@@ -2520,9 +2540,11 @@ void enetc_stop(struct net_device *ndev)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int i;
 
+	set_bit(ENETC_TX_DOWN, &priv->flags);
+
 	netif_tx_stop_all_queues(ndev);
 
-	enetc_disable_bdrs(priv);
+	enetc_disable_rx_bdrs(priv);
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
@@ -2535,6 +2557,8 @@ void enetc_stop(struct net_device *ndev)
 
 	enetc_wait_bdrs(priv);
 
+	enetc_disable_tx_bdrs(priv);
+
 	enetc_clear_interrupts(priv);
 }
 EXPORT_SYMBOL_GPL(enetc_stop);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 97524dfa234c..fb7d98d57783 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -325,6 +325,7 @@ enum enetc_active_offloads {
 
 enum enetc_flags_bit {
 	ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS = 0,
+	ENETC_TX_DOWN,
 };
 
 /* interrupt coalescing modes */
-- 
2.34.1


