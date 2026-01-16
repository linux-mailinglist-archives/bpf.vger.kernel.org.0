Return-Path: <bpf+bounces-79258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E667D327BC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C511430158FC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8032BF58;
	Fri, 16 Jan 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iMG43BKV"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA132AAD3;
	Fri, 16 Jan 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573203; cv=fail; b=Mzwu3wHVT4zx/66lzuaLfbAyUGbX6VBH9likcVhyBJVsvFBtqmjb7Fo52mK2zxaPqcoMaF0KDNhxwOqin5PTWkxLK/vQt60WNwrsh6E6JUoyzOZzVniomz/YhzOHSpco4Gl4wEVpcnV6Ai8grh6l9oLGg0s7K6l47YLmt447C40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573203; c=relaxed/simple;
	bh=slyD31WCme5vt3SF5br9N93jNKt+OmwehVjke5xjU7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ErQk4DrIh1FOxvmUfz5HxzDrKKHdD99LqG2mFynkVYNDySX7SwjWlf4KAuHcs5CwsVQrRE/oUFca7oKgiFTpzanjCuhP4c2CiJEyNT8RBEs/m4s3YGz8OAAAZx23/ymD8d1JdXYM5v5174e7QzCbH1C5lpsfIW2CgC2O5ZjauAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iMG43BKV; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8l1G+YFcU4yXEtITnhdKBJWRsO2kT0toSxY2O8GmkQ7B75drOAiudTtjJ/TaJ2HXFCrSTsjOH76SzXAmmNOb6Y9e+n/mJeG6DPCqToiZWnlltU3CxH8YGuUzQp/jLe9tAs/hus1DfVC/7dSZ1zSB8OmnqL9qp2XmTa3IuqkbBuKVSDcMtGg4F2bw+JfqJH+F8BLq6W4wMi/qS/b+qj77/P56J/LF+n0D5fVS/b3za9FLeOfVBF94Lg1uoZPQfjgXAGMUEfnBBkymC/yofeSxVNXflMvH+J7t6i+WJsAHWnOug5KBvDd+W+z0wvIHniUS82MBFA0Jn4c2Mq7j1/nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV17lznJeksiImOTRUk6IEGn6dIa59wMx+la3hXZKqI=;
 b=pNhgfG/0N0WXTGmhzvlUtGcnxoWITr5wbvRfAYFHJ/y8fq57lbS6Fg90jtWvlb+D653F6WV+JeTfMM09MxpGPEKBQ6gZcHWll5fO56zhrAcnEQemPYtKZMXkkojX/ok/k8EMQPVErlW/Tqa6KCov7JV9k9J5K1GepS9a8IHzwSQKuN5tZRXidQWwVvcqtNmatwWR4IXWzTQ8b98bAgrUJnH5ZkScpdG+DI+RRCAfdX2L5bAOtXatB6F8Eky8ckLZK2Hgy8svf0Zh5Dd0GKbo84FFfLiXxBWQ0a8fbys4MJlA0BMJE4EAE6l0NkJA4rCqtSiUTtEW+ybZxNE8fa110A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV17lznJeksiImOTRUk6IEGn6dIa59wMx+la3hXZKqI=;
 b=iMG43BKVJw0SGz6tqBPPtv2ahWZTnSk1YgV/i+l+FmJ2113iBmRbSiKR8+tJbsvbhLXZEqZ7LH617QR14bH8dikmy2NXdqhmjTCV4TPVFrIBt99LvQyoIf3sbe5/3rjOwl7bZVgpC8WLBQHiZD6oVAVndNNTtqP8GAgD0pNprlz7bkjCXpXadMif6xYkKKbsRuSFS3Ynp7Az2Mk1yUhVA6qk0UynBdpVFhdDGD2Gvz1n//1wXBkLh/CN9WWHyBKqciAsR++9UYwOk+W8PZrfVgFbT4i4xOSNo9cdpE5EiBwWt0sDXVpmqaYofIX5ahjTQ9Ep54GEU10QtSTYLHHyIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV2PR04MB11882.eurprd04.prod.outlook.com (2603:10a6:150:2f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:19:53 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:19:53 +0000
Date: Fri, 16 Jan 2026 09:19:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 06/14] net: fec: add fec_enet_rx_queue_xdp()
 for XDP path
Message-ID: <aWpJAfYTvO4D/COp@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-7-wei.fang@nxp.com>
X-ClientProxiedBy: PH5P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV2PR04MB11882:EE_
X-MS-Office365-Filtering-Correlation-Id: abd9a1af-1010-4da8-c3fb-08de550a5156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C0UXbQsRdXmuIbdu3hgF7JVoqYzOjV38kjeD/gJHFajU1vzkFzeu7Qrs6feR?=
 =?us-ascii?Q?im27dLlPnUMc97+BiE0+lsMARqVS49VcAFAGrb0Lnt6v7792/3UpVUF/fhvO?=
 =?us-ascii?Q?iofbJVSXG8b4nGSgCgi0B1ifvJ7DSgygJWachzRwIVjtjEmPgqcvvbCdmVC2?=
 =?us-ascii?Q?Re1ba9Dez0fpizLy7ICCRcZNB3zU3JXuAEEuEdAbUVZsYgBK0vV6MundvSyD?=
 =?us-ascii?Q?ts+FjY5cgRtyupziEYkFgO2l1NGVT05gDNNFiHGS4AZDH5C7JkODMawXLdwn?=
 =?us-ascii?Q?ik0pHvc0pVll6o6TnU3qYlodM69yKMv1TXI8EUSslsDLKC+dQRRN+CNe5q4f?=
 =?us-ascii?Q?U5YKQBWLYTiS6fJ1ofO57NFpeYVENRbPRh9N8rjIhLPsBlQm7kexIPYLc9u4?=
 =?us-ascii?Q?6WTg1Tj0XFhWDYraIE9laIknnSR8kr5Z0NZGOtHOqASSAbjfcTQHBF8ietOJ?=
 =?us-ascii?Q?tlXEfWlX+DD4myDVTN/oCRtNI75bgsgcMIuA26JJozre97ucYaqCwZoRJ+0a?=
 =?us-ascii?Q?uZ0U0y6hlYymMvbzl2UHpn4iEfThE33ZXWZXVVS+RgD4PvHfcubHftKmtzJT?=
 =?us-ascii?Q?kZqWW2+xmsr8afO0iFvPKpoe7wekd0a3d2SSH53t4kXpiW09aild0YcGQn3F?=
 =?us-ascii?Q?jdUkliFZJ7PLZF7AL0ElBYuMASlLvM/Ivu3G4Ba43WuUpo7QgwZRdiL2aW3y?=
 =?us-ascii?Q?YBRIrxLdjXOqOP4u80M3O75eFZIIViSFkq2id12LU2STElUiK8b12GeOmE22?=
 =?us-ascii?Q?QWJJ9cEsfLEp5UOsz2yY+bMV+z+L7nKVA23skN7r+M0wgKVKUlRNBNyMeuvp?=
 =?us-ascii?Q?gZ4HP/dpIURTbRsQfn4zkD6caM47QlHa1gXR2To6es6E9ALcie0OknmYfCQ0?=
 =?us-ascii?Q?tiBAOoz3g+3rk4BOj7awGF3RW2bqBkHC4HS6BwdYq8wSKL312BmN+GIZ95MK?=
 =?us-ascii?Q?P7LQn+Wnsjjbehl6g3oWuKx/kd96dZYRsuaJ3FOHe9A5lG0NNPdwZIA8JaHa?=
 =?us-ascii?Q?+dN0eDGKJ9TCnWXFjiFFVDsZYOW6NBkDs/TPlZ64YNFDwcu6nEAEl6XkA841?=
 =?us-ascii?Q?BeEiKPn8B3ITj9r2xMqasdys5r0SJS9lCc9B8jpZV53a9b2YQHgDOPxcWlde?=
 =?us-ascii?Q?G4bUiyT06pC6d1x2Pdsg8cKGg/DfreQL/r4vF29haKVB4rpDPTMJTm6Pocu1?=
 =?us-ascii?Q?rTVGM9KwV3jC3kFFhMMy1rvIrRAPtkqcX9KJhGAVbsnKYJx0toUdEXGFPQL4?=
 =?us-ascii?Q?LbUwmqxQj9ylS5jbm1590RHAKLw4J0WPbN8/C4j+JoUC923k84msPDjP8b92?=
 =?us-ascii?Q?WiNViY8tMBcapmlhcXn0DFDxaCWGBNe748dCakHAf8DLVKB0ySlxWILocVGT?=
 =?us-ascii?Q?trOqfJkumPNU1NK7yNRKzptTnixaqJe/jeDCxPRRawaAn/pmO8skgZg73QF1?=
 =?us-ascii?Q?IJz3wgbmQ6MRqRAMq0FYTonXvWvErJQAxZwm5n04sO01wO0BkRNKirg8fCaT?=
 =?us-ascii?Q?LwsOnmMX+sxWYKzlb28ZmoMFIYIFn5PEgS9kQRp7grDkAkO4h3hOe/efwjRd?=
 =?us-ascii?Q?QR2zzbKF6GiBuvSdvm5iwUI/ZKFvFLk0thAzmTod3WY3mM+Q6yzR48O+rVJL?=
 =?us-ascii?Q?JzCEH06yHRq6F0jyZzSJAu0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xLkPh21YrdFx4b9fa2XSxq5h6BpV50zmmNmJ2w4pBGz/H6ZGbx+ZTeT+tvVz?=
 =?us-ascii?Q?ggSkK2u0m9nG5lQ2QbMRW6jx0nsSkMF30uRm8UpiyYVpISboS3fVK6EfVwtp?=
 =?us-ascii?Q?ptwtpN9SeMXcFdGWe1NiMShYgQSorRUC0Rqz0tFF2IDeV0nj7EPtLA3ywUKV?=
 =?us-ascii?Q?kQOmMMtuWAwq9UmmlQyynlsD9FH9Rz/MkxAG3BnwA4YkcGzm5LnD1DNoxu97?=
 =?us-ascii?Q?oOChI6GMk6SYSaIfG+W+vtSFZwti8BGfIqagvClpg7zW/eP8AdI7fmuGRL5m?=
 =?us-ascii?Q?QnaIB3JKI/ASYkSaJn/XgaFhMgTfKkDPueE78Gp2KzGV0OxXbC8Eqmaauro2?=
 =?us-ascii?Q?toZ/VLiiZTVZIcoWcngH197Kh6O8QWa/Q2LUtaO7TS0p3kCp9LuUtoXYs0Dv?=
 =?us-ascii?Q?kK4U4rwXmOFedahzF+MCRlo6HZZDCb+CSP0qfon/k24bpyJtuIu/WBRwVAqn?=
 =?us-ascii?Q?UbKaov8Xn/YfaJxLfCUS/TmrcTWNzTA+vA6O0iMraPhymXGpEHE/GaEJ9CyK?=
 =?us-ascii?Q?WDW0FQuTMt+aRXkjb2AJJGwnOx6IrcDQbxu0Ii+rGl6cQrR+juXpK4tR9i8U?=
 =?us-ascii?Q?d+qc0tYKzLWs7MpHaWqFQUyA2E3emdS3BSN+fPixfwI6NZTDMihQmTxDois0?=
 =?us-ascii?Q?5NvAE7HX9aJL0NSFL7VeQ0hIn5qayu+iFQRY4fS9X5VaQXYyQR+k9X0mWq3n?=
 =?us-ascii?Q?3jDTQxfQfckRLFOyI/rFPACbIpV31vFQ+PNch0gVMf82osYjSOCbHfRnq+su?=
 =?us-ascii?Q?grjnrq2VjmfBFfob1p8vaI1ZbAr/fx+Su9sbzpuu/miw9e6a5jP7cB6gYit/?=
 =?us-ascii?Q?0JOFbECJBghImV4BM/FAtRHOZI6behdmzgwiN8Ik2NaARwUs7XuCa+EOxl6m?=
 =?us-ascii?Q?4diYbYZ6dqG1poX0hPY15rFU05+/OktVpx6v5P29Q7DBWo6xcLwrBUDB+w9O?=
 =?us-ascii?Q?cMqTsOxsP9V3+3wdNk0JoKT7nrP5UdUUCEHu1xPrs7TRzXW6weZq9YnRacGz?=
 =?us-ascii?Q?t5HfGjYZ/AE797Y5TR1aJmsJMfBFMUlHsVn2VeXXTehP7CibrmR/pjgZbntJ?=
 =?us-ascii?Q?hWyUh6Eaq34gVQ7/6jD1Wz3w0RVnG5A/SGHdyO6f/gGCK3OBEB8i6T4Z/8od?=
 =?us-ascii?Q?NKqmPMSntB1b2DLU0VOGMtP+vDCl2Yy/3PTa2OcMb2vm9d6UDYZpiiG50EXj?=
 =?us-ascii?Q?6LRiavId1SYE3AmF1AhodRVNs4wp1fKuNmiElw6hmX3/zvT6i95oqPx0elYk?=
 =?us-ascii?Q?Xfnh/efqw/GXHvnMcNeT5IBiOY13GpvYGl6cWC/qIFnWZRFnpgsMhVMigYgg?=
 =?us-ascii?Q?hWAnQknZD2yoEUye4P10Ep73gkGG+/744kQ2wxrsZoV5siHsLUB7LeDG6SL/?=
 =?us-ascii?Q?jh6Fh/z2o9AqaNzPWOGS/tCQ2zLP+uor6XThmSaJokLM2NHFNSGsHvTk/u8d?=
 =?us-ascii?Q?yBuDUeTr56h0tMNLOSqKc09IuSHftRf5vJG0VJMXpwUCcBFbrcFaqnceZU79?=
 =?us-ascii?Q?2hX0/oCL1avdyJcvpN7KXtgfh2yghHQEPi6yoBjUwtQwt3eFbOoHcwdGN4yE?=
 =?us-ascii?Q?gwxDwhSUhvA3u/WbgAJoqA0ViAO+dxU2gQc1heQsRAqDLYKFWdLqjAy6vQI1?=
 =?us-ascii?Q?pEeGadcyWxEF2916Wy6jY2AzknHxYW43O5IsR4znRwQilg8Abw+PqJFQze+J?=
 =?us-ascii?Q?kOAS6bcLiUjlPVmJ8YeRFT1LXPM7+mxvqTaLLkpVh/Lyt/MWKSJmIhWhHqGa?=
 =?us-ascii?Q?P3OEr2/V3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd9a1af-1010-4da8-c3fb-08de550a5156
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:19:53.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkXiIfS6IWEXRfbl+TWKnfBW8B2LgLiO8apkNPa8q9ObGwNO3WWzZOWZIvUlooyAkJQdfwVULuAFVCcJr0KJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11882

On Fri, Jan 16, 2026 at 03:40:19PM +0800, Wei Fang wrote:
> Currently, the processing of XDP path packets and protocol stack packets
> are both mixed in fec_enet_rx_queue(), which makes the logic somewhat
> confusing and debugging more difficult. Furthermore, some logic is not
> needed by each other. For example, the kernel path does not need to call
> xdp_init_buff(), and XDP path does not support swap_buffer(), etc. This
> prevents XDP from achieving its maximum performance. Therefore, XDP path
> packets processing has been separated from fec_enet_rx_queue() by adding
> the fec_enet_rx_queue_xdp() function to optimize XDP path logic and
> improve XDP performance.
>
> The XDP performance on the iMX93 platform was compared before and after
> applying this patch. Detailed results are as follows and we can see the
> performance has been improved.
>
> Env: i.MX93, packet size 64 bytes including FCS, only single core and RX
> BD ring are used to receive packets, flow-control is off.
>
> Before the patch is applied:
> xdp-bench tx eth0
> Summary                   396,868 rx/s                  0 err,drop/s
> Summary                   396,024 rx/s                  0 err,drop/s
>
> xdp-bench drop eth0
> Summary                   684,781 rx/s                  0 err/s
> Summary                   675,746 rx/s                  0 err/s
>
> xdp-bench pass eth0
> Summary                   208,552 rx/s                  0 err,drop/s
> Summary                   208,654 rx/s                  0 err,drop/s
>
> xdp-bench redirect eth0 eth0
> eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
> eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s
>
> After the patch is applied:
> xdp-bench tx eth0
> Summary                   409,975 rx/s                  0 err,drop/s
> Summary                   411,073 rx/s                  0 err,drop/s
>
> xdp-bench drop eth0
> Summary                   700,681 rx/s                  0 err/s
> Summary                   698,102 rx/s                  0 err/s
>
> xdp-bench pass eth0
> Summary                   211,356 rx/s                  0 err,drop/s
> Summary                   210,629 rx/s                  0 err,drop/s
>
> xdp-bench redirect eth0 eth0
> eth0->eth0                320,351 rx/s                  0 err,drop/s      320,348 xmit/s
> eth0->eth0                318,988 rx/s                  0 err,drop/s      318,988 xmit/s
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 292 ++++++++++++++--------
>  1 file changed, 188 insertions(+), 104 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 0529dc91c981..251191ab99b3 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -79,7 +79,7 @@ static void set_multicast_list(struct net_device *ndev);
>  static void fec_enet_itr_coal_set(struct net_device *ndev);
>  static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
>  				int cpu, struct xdp_buff *xdp,
> -				u32 dma_sync_len);
> +				u32 dma_sync_len, int queue);
>
>  #define DRIVER_NAME	"fec"
>
> @@ -1665,71 +1665,6 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
>  	return 0;
>  }
>
> -static u32
> -fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
> -		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
> -{
> -	unsigned int sync, len = xdp->data_end - xdp->data;
> -	u32 ret = FEC_ENET_XDP_PASS;
> -	struct page *page;
> -	int err;
> -	u32 act;
> -
> -	act = bpf_prog_run_xdp(prog, xdp);
> -
> -	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
> -	 * max len CPU touch
> -	 */
> -	sync = xdp->data_end - xdp->data;
> -	sync = max(sync, len);
> -
> -	switch (act) {
> -	case XDP_PASS:
> -		rxq->stats[RX_XDP_PASS]++;
> -		ret = FEC_ENET_XDP_PASS;
> -		break;
> -
> -	case XDP_REDIRECT:
> -		rxq->stats[RX_XDP_REDIRECT]++;
> -		err = xdp_do_redirect(fep->netdev, xdp, prog);
> -		if (unlikely(err))
> -			goto xdp_err;
> -
> -		ret = FEC_ENET_XDP_REDIR;
> -		break;
> -
> -	case XDP_TX:
> -		rxq->stats[RX_XDP_TX]++;
> -		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
> -		if (unlikely(err)) {
> -			rxq->stats[RX_XDP_TX_ERRORS]++;
> -			goto xdp_err;
> -		}
> -
> -		ret = FEC_ENET_XDP_TX;
> -		break;
> -
> -	default:
> -		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
> -		fallthrough;
> -
> -	case XDP_ABORTED:
> -		fallthrough;    /* handle aborts by dropping packet */
> -
> -	case XDP_DROP:
> -		rxq->stats[RX_XDP_DROP]++;
> -xdp_err:
> -		ret = FEC_ENET_XDP_CONSUMED;
> -		page = virt_to_head_page(xdp->data);
> -		page_pool_put_page(rxq->page_pool, page, sync, true);
> -		if (act != XDP_DROP)
> -			trace_xdp_exception(fep->netdev, prog, act);
> -		break;
> -	}
> -
> -	return ret;
> -}
> -
>  static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
>  {
>  	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
> @@ -1842,19 +1777,14 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
>  static int fec_enet_rx_queue(struct fec_enet_private *fep,
>  			     u16 queue, int budget)
>  {
> -	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
>  	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
> -	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
>  	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
> -	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
>  	struct net_device *ndev = fep->netdev;
>  	struct bufdesc *bdp = rxq->bd.cur;
>  	u32 sub_len = 4 + fep->rx_shift;
> -	int cpu = smp_processor_id();
>  	int pkt_received = 0;
>  	u16 status, pkt_len;
>  	struct sk_buff *skb;
> -	struct xdp_buff xdp;
>  	struct page *page;
>  	dma_addr_t dma;
>  	int index;
> @@ -1870,8 +1800,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
>  	/* First, grab all of the stats for the incoming packet.
>  	 * These get messed up if we get called due to a busy condition.
>  	 */
> -	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
> -
>  	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
>
>  		if (pkt_received >= budget)
> @@ -1902,17 +1830,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
>  					DMA_FROM_DEVICE);
>  		prefetch(page_address(page));
>
> -		if (xdp_prog) {
> -			xdp_buff_clear_frags_flag(&xdp);
> -			/* subtract 16bit shift and FCS */
> -			xdp_prepare_buff(&xdp, page_address(page),
> -					 data_start, pkt_len - sub_len, false);
> -			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
> -			xdp_result |= ret;
> -			if (ret != FEC_ENET_XDP_PASS)
> -				goto rx_processing_done;
> -		}
> -
>  		if (unlikely(need_swap)) {
>  			u8 *data;
>
> @@ -1961,7 +1878,181 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
>  	}
>  	rxq->bd.cur = bdp;
>
> -	if (xdp_result & FEC_ENET_XDP_REDIR)
> +	return pkt_received;
> +}
> +
> +static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
> +			 struct xdp_buff *xdp, u32 sync)
> +{
> +	struct page *page = virt_to_head_page(xdp->data);
> +
> +	page_pool_put_page(rxq->page_pool, page, sync, true);
> +}
> +
> +static int
> +fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
> +{
> +	if (unlikely(index < 0))
> +		return 0;
> +
> +	return (index % fep->num_tx_queues);
> +}
> +
> +static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
> +				 int budget, struct bpf_prog *prog)
> +{
> +	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
> +	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
> +	struct net_device *ndev = fep->netdev;
> +	struct bufdesc *bdp = rxq->bd.cur;
> +	u32 sub_len = 4 + fep->rx_shift;
> +	int cpu = smp_processor_id();
> +	int pkt_received = 0;
> +	struct sk_buff *skb;
> +	u16 status, pkt_len;
> +	struct xdp_buff xdp;
> +	int tx_qid = queue;
> +	struct page *page;
> +	u32 xdp_res = 0;
> +	dma_addr_t dma;
> +	int index, err;
> +	u32 act, sync;
> +
> +#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
> +	/*
> +	 * Hacky flush of all caches instead of using the DMA API for the TSO
> +	 * headers.
> +	 */
> +	flush_cache_all();
> +#endif
> +
> +	if (unlikely(queue >= fep->num_tx_queues))
> +		tx_qid = fec_enet_xdp_get_tx_queue(fep, cpu);
> +
> +	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
> +
> +	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
> +		if (pkt_received >= budget)
> +			break;
> +		pkt_received++;
> +
> +		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
> +
> +		/* Check for errors. */
> +		status ^= BD_ENET_RX_LAST;
> +		if (unlikely(fec_rx_error_check(ndev, status)))
> +			goto rx_processing_done;
> +
> +		/* Process the incoming frame. */
> +		ndev->stats.rx_packets++;
> +		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
> +		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
> +
> +		index = fec_enet_get_bd_index(bdp, &rxq->bd);
> +		page = rxq->rx_buf[index];
> +		dma = fec32_to_cpu(bdp->cbd_bufaddr);
> +
> +		if (fec_enet_update_cbd(rxq, bdp, index)) {
> +			ndev->stats.rx_dropped++;
> +			goto rx_processing_done;
> +		}
> +
> +		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
> +					DMA_FROM_DEVICE);
> +		prefetch(page_address(page));
> +
> +		xdp_buff_clear_frags_flag(&xdp);
> +		/* subtract 16bit shift and FCS */
> +		pkt_len -= sub_len;
> +		xdp_prepare_buff(&xdp, page_address(page), data_start,
> +				 pkt_len, false);
> +
> +		act = bpf_prog_run_xdp(prog, &xdp);
> +		/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync
> +		 * for_device cover max len CPU touch.
> +		 */
> +		sync = xdp.data_end - xdp.data;
> +		sync = max(sync, pkt_len);
> +
> +		switch (act) {
> +		case XDP_PASS:
> +			rxq->stats[RX_XDP_PASS]++;
> +			/* The packet length includes FCS, but we don't want to
> +			 * include that when passing upstream as it messes up
> +			 * bridging applications.
> +			 */
> +			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
> +			if (!skb) {
> +				fec_xdp_drop(rxq, &xdp, sync);
> +				trace_xdp_exception(ndev, prog, XDP_PASS);
> +			} else {
> +				napi_gro_receive(&fep->napi, skb);
> +			}
> +			break;
> +		case XDP_REDIRECT:
> +			rxq->stats[RX_XDP_REDIRECT]++;
> +			err = xdp_do_redirect(ndev, &xdp, prog);
> +			if (unlikely(err)) {
> +				fec_xdp_drop(rxq, &xdp, sync);
> +				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
> +			} else {
> +				xdp_res |= FEC_ENET_XDP_REDIR;
> +			}
> +			break;
> +		case XDP_TX:
> +			rxq->stats[RX_XDP_TX]++;
> +			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync, tx_qid);
> +			if (unlikely(err)) {
> +				rxq->stats[RX_XDP_TX_ERRORS]++;
> +				fec_xdp_drop(rxq, &xdp, sync);
> +				trace_xdp_exception(ndev, prog, XDP_TX);
> +			}
> +			break;
> +		default:
> +			bpf_warn_invalid_xdp_action(ndev, prog, act);
> +			fallthrough;
> +		case XDP_ABORTED:
> +			/* handle aborts by dropping packet */
> +			fallthrough;
> +		case XDP_DROP:
> +			rxq->stats[RX_XDP_DROP]++;
> +			fec_xdp_drop(rxq, &xdp, sync);
> +			break;
> +		}
> +
> +rx_processing_done:
> +		/* Clear the status flags for this buffer */
> +		status &= ~BD_ENET_RX_STATS;
> +		/* Mark the buffer empty */
> +		status |= BD_ENET_RX_EMPTY;
> +
> +		if (fep->bufdesc_ex) {
> +			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> +
> +			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
> +			ebdp->cbd_prot = 0;
> +			ebdp->cbd_bdu = 0;
> +		}
> +
> +		/* Make sure the updates to rest of the descriptor are
> +		 * performed before transferring ownership.
> +		 */
> +		dma_wmb();
> +		bdp->cbd_sc = cpu_to_fec16(status);
> +
> +		/* Update BD pointer to next entry */
> +		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
> +
> +		/* Doing this here will keep the FEC running while we process
> +		 * incoming frames. On a heavily loaded network, we should be
> +		 * able to keep up at the expense of system resources.
> +		 */
> +		writel(0, rxq->bd.reg_desc_active);
> +	}
> +
> +	rxq->bd.cur = bdp;
> +
> +	if (xdp_res & FEC_ENET_XDP_REDIR)
>  		xdp_do_flush();
>
>  	return pkt_received;
> @@ -1970,11 +2061,17 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
>  static int fec_enet_rx(struct net_device *ndev, int budget)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct bpf_prog *prog = READ_ONCE(fep->xdp_prog);
>  	int i, done = 0;
>
>  	/* Make sure that AVB queues are processed first. */
> -	for (i = fep->num_rx_queues - 1; i >= 0; i--)
> -		done += fec_enet_rx_queue(fep, i, budget - done);
> +	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
> +		if (prog)
> +			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
> +						      prog);

Patch still is hard to review. It may be simpe if
1. create new patch cp fec_enet_rx_queue() to fec_enet_rx_queue_xdp().
2. the change may small if base on 1.

> +		else
> +			done += fec_enet_rx_queue(fep, i, budget - done);
> +	}
>
>  	return done;
>  }
> @@ -3854,15 +3951,6 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>  	}
>  }
>
> -static int
> -fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
> -{
> -	if (unlikely(index < 0))
> -		return 0;
> -
> -	return (index % fep->num_tx_queues);
> -}
> -
>  static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>  				   struct fec_enet_priv_tx_q *txq,
>  				   void *frame, u32 dma_sync_len,
> @@ -3956,15 +4044,11 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>
>  static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
>  				int cpu, struct xdp_buff *xdp,
> -				u32 dma_sync_len)
> +				u32 dma_sync_len, int queue)

you can split it new patch, just add queue id at fec_enet_xdp_tx_xmit().

Frank
>  {
> -	struct fec_enet_priv_tx_q *txq;
> -	struct netdev_queue *nq;
> -	int queue, ret;
> -
> -	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
> -	txq = fep->tx_queue[queue];
> -	nq = netdev_get_tx_queue(fep->netdev, queue);
> +	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
> +	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
> +	int ret;
>
>  	__netif_tx_lock(nq, cpu);
>
> --
> 2.34.1
>

