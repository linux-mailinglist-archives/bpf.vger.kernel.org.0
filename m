Return-Path: <bpf+bounces-53428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9458EA50F02
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECDE16FC8E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB9E20896E;
	Wed,  5 Mar 2025 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X41VqMee"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C21FECA7;
	Wed,  5 Mar 2025 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214811; cv=fail; b=GAtBUCVtJKMHwtnHu0gmQ5XNbx2PbKVupKJPjlnR/tttXkDmnE4juR/gEbf95MFAPJTpiEbwgycsph6qJKL5HzgQfQry2Fa/wNb0znIYUjrEwAWUJxsPm6hI2Q4op+Z9TaY/2FROo7SdVqK2Lt5uVvMzA6GhwobVTd4S4AFiHmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214811; c=relaxed/simple;
	bh=Kd7jWkHmkcZXrdT3ET5GDMGPri98PKHd/rGDH54TxYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KZHeePmM3YCCGTh/QJNvWrnhJrEfiVjFksg1hWIY940RHadwquXnp8OhACOjIryK91nM2lNsTlfyOSLKDWIxshwYtHGmye7zwiYnRhRECHYiLZwjM2DBlonv5YgZOM02+ebJXkioHLtUooSENs+YLzRfqfBZPjaEoLSulH+FZmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X41VqMee; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxK0mpzM5JnMOESKiMXm5/7nVKJWNQ43+3iT8IMqOetdsSMb6JrWqpUusoOcy8L0kPmDMyTVrdYqLOj0knZ+1ePd5eR8wWuf50YHJCV7yJqM1W2etP+Yq+hgGdNeLYLBAoaVxOqc83wVSNuRCHzFAA/SVKbS7TaEoCj6EkrGlficV15RvCgmfpJ+8zEBlpXepxRJbPiaVZ2afLPSAf3GX2A0Ym8lf62Vma0xk/4h6UNvs2sHsOBhEoy/cmEsjpdx98uExrQrkUUDTm07MW902gYI3EVcETipXZETwZkYjuBwUHFiNX0TqSCkg6loq57IQioQLcylIAJ/3BrtWpaiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BNRUxzSl1urnrlj+p3T3SoU4u7k1rxSpliJwbM61/A=;
 b=t9BsoDPSHCJP8j7xUyiXj2mgOhy+qXZ9phDgibXCGakNpjlsJwVpW5S6V5fZSthihShraa4t9lnGCQ3Jy2yPiXpRHHHbKhjSdpy1mqGEDjF8nsVqGcNRuymHczbFfPsdX4C9+fG+fOgSh/isAwmqvI+H2CAh0we91DgiLjftoUOxFFJzULfKdtzIRHQ5FENWWMqLKtiMr4neeE4CvQgMhCGZ0ILxAiJitcLkd1TFvVeFPpjoo3DgLLjuXjVqIXxI9eC6KAxeh5o2i52QxJgeEfNHviOnCHWkgMpYJ+U7b+OCJpGewNRbclvqUXjTzjfpdv9RVE03IEUcLcbaDsiX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BNRUxzSl1urnrlj+p3T3SoU4u7k1rxSpliJwbM61/A=;
 b=X41VqMeewF81jFLRO79dKTWaEaGOAXCCtRHzgBQybZYHqGainEpnNBAzQGGXa+nnNq3OQnlr0CgK90ZTGCQcWp1W2Ir9gLGZGw6aIjWG8CaiTAy9EABvg58efUEbg6e8RIb3fZ2C5jxEuRy2iUs3CNf929rPPyJJWdYZ3UUKiIHobd4fwqkXy0U473BfPlBeHaYk/1burZ52l61Lmwmk0AEuh9h47rPWNi9NRF4VJ3v6DFI5mBpxu3hGDgXjxU8uIBerxIH1w1hY0UbmD9Ny/rXvJWt5cktt/NWT2J+tKhKEgCkdYt0Ua3Y4U8vOazOeHm2VsxCQgoLDsYS+dOm5Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 22:46:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 22:46:46 +0000
Date: Thu, 6 Mar 2025 00:46:42 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v8 05/11] igc: optimize the TX packet buffer
 utilization
Message-ID: <20250305224642.7c6dz52mhj35f4f4@skbuf>
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-6-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305130026.642219-6-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: c19c3634-5919-4aa6-3dfc-08dd5c379bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?alZilPaP6HVFmrffn5sYcKVod/pZqFZG8oeXzM6mQXCJ/6lf+7nvhrrYa9j1?=
 =?us-ascii?Q?2U0MUrQ+xoVdSoD5cV9hMIxiAxCYSf5zLhskJXJENGgzKdIDGlKsQP6aL5Ap?=
 =?us-ascii?Q?9W2kDqmGm1po3Ff9giec7f+o0ZFZYh7W0vqBl06aoUkTS0FTaUktnJEY1ZdX?=
 =?us-ascii?Q?6rh/tc8iQgln8u2yfvGo22PzinREyLxEQ44yo9AulkZLk2LNMSYoRHKiGuDu?=
 =?us-ascii?Q?g5JRVxb3uRnn3x0NSLKfh6Xrza0OyLC1Yrn7P+r2NjyNgXByo+RdKEsLoVr6?=
 =?us-ascii?Q?TLaM22EP9t3PaDzpNLSz+7FGpqhc+G2bfyKWILvY27HE/87GXZiSJabYuITY?=
 =?us-ascii?Q?kTU5N5JoIw/MV5xnETzNYCNNHqEJJjVnsokSEUoLJSVPQi9zRMi1DwGduFZH?=
 =?us-ascii?Q?BDkXpXz2FErJTFL+7SEcvgbwHMZLWuuaSpmSUW+1lQFxX65Aj4D8Ff9kItZT?=
 =?us-ascii?Q?XV4QaSqCW50OZC5LjwN1ViL8CiJzNV03xHz6qsBZgnAzmJxgSrVO4sfMiP7o?=
 =?us-ascii?Q?X44FT9MJqYcn2QpYE0uDIR/4zNQDHwqqsexcgS7UxCHWzbuYeFKrgbhJUtI2?=
 =?us-ascii?Q?GP2YNleD+OHQ2GobXofybKgwkzGrxj9J+7XcqU2cRmqI3vnpNsVefSP0e3TN?=
 =?us-ascii?Q?XvqlfJLLJ3eQBy9U8tV04jycCViow3E7qqrqxHpa8HCSamXmhL0dwDs/emQP?=
 =?us-ascii?Q?n20qR+ItYYoPHMngYloSBnTc7ZB53Af0PTYEoC97CDwb5cMYmL3ZbIgmJlyz?=
 =?us-ascii?Q?CR1aN6wg4k7pNEmuDeBxV/NJ5+7q+4ef22Ec5jcfRN8P0W7JoSp1WuyCFgc9?=
 =?us-ascii?Q?2yQIVtADkM0ga9OhSednaGpJR+ZzHGaCZMKk5qVA5pK2BUuDMe6ef8OwyUsL?=
 =?us-ascii?Q?KBAwwC3LvWJTb+8/tLreG/Hw+mduv8l4iLrP3RKqYyee23/xypWu6nEZPX88?=
 =?us-ascii?Q?J3kYj5jo6FXFbAnYDYRcqauNYwwwAnKBFVN1Tty65ojZ97+RqV6lIGWfCGww?=
 =?us-ascii?Q?xdMIuHTb3QkUkSKsUkXHjT8751W56/OlfE6BIk4gO+Zh8LthNxuP1s9R+FQ4?=
 =?us-ascii?Q?MMeFwbdEDGDBRf2oHXiLW/oDU0JVbhlzZPBk8/dZzj2rxR9eV2vI1WdLo35+?=
 =?us-ascii?Q?QsOIIlXmv1a2PCqAlMBp/JK+bgdb/SfER5W7CwBqiMfRsab6XJ/gzLJdo1HY?=
 =?us-ascii?Q?KJGKDVLCbj/Aov9lQHZooXnQpm/TK7DX+xmQEmVuS83oxQdwlaL9XS2t8Ncw?=
 =?us-ascii?Q?sXcOZ3TfO+Poi/71aLIaykb6ETMNkPrFoJpeOI12nK5MeospFuJT9aIgnTy6?=
 =?us-ascii?Q?xDje1/axpkw9VCvXByfXlVv23FTbhhURuFKW5a2J3lenEBgfcHDDhCXsSKKj?=
 =?us-ascii?Q?3Sg51fLCnad9s6SKPsrUYJ8W6eLr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QGAO2UlMqHMCvGp+pyDrhTd1V3qdBtjJ+p/3ze0dKUnENjmo5WK/A6b3p3pv?=
 =?us-ascii?Q?sV+Lrp2yh79jQSATSO5qIVoK4BQCrqnbm5cKIgYsmaekp60YOtHQMEnHXUYU?=
 =?us-ascii?Q?iYjTmICfyDEALSqLF0fhRg9X2V9G6VWRGkWUGSGMbvjRXDltGczOyTQtyotq?=
 =?us-ascii?Q?x1A8b3czamYNuM336xrgLUf1IZj5drJjIsTR2i8Cc8gPauxX+KKyVCJSAjGj?=
 =?us-ascii?Q?L/BLAln2qfwBl1w+eJUuEOLBFvVjgoBQcwIy9OA3sXHzJjAQQ/cmk+JAxLM9?=
 =?us-ascii?Q?59/cKKnahPBKY3MYIUxGVFHw6aGiO9qtyb43OUzpPH/0eGpMEVu1jJoBSfwP?=
 =?us-ascii?Q?x/IyHdIyzhRxMRwYlng5zDp6dbUd2n1BEEB2BZ2dHwJWLaqVCU1BuLKQeXzo?=
 =?us-ascii?Q?hiRtL8g5Ch42ttkY5PKtGLeLMmt53cJMAKGjAc+nbyoDPy4tSrp0IrgfedM+?=
 =?us-ascii?Q?mI1OFpgUjshs+WeXVWLb6sotpkpeUzg6aZ2xQSTsEFau2b23NfLgSC81xCMp?=
 =?us-ascii?Q?vzncSdnOn1QPFcWZvZ+I3VrJnwndrrYcJZoMbI9fvjzl5GUiPnO5cJibuDio?=
 =?us-ascii?Q?458r55zF5EQgSPurflmsFDr+IIwm+1Sy1RZe45DZbaTQrHjPsxb5aqy77bVe?=
 =?us-ascii?Q?pqQvLxwrzZu5RmEXpX1PZgv+G78CS6zyEp6550gEb658RiVDgpnDnS7y4r/L?=
 =?us-ascii?Q?S6yEqDYwcBBrG/mleTT/ps2kAcD1Hn29v7hgLaubZyAyzI7Bh40L6Ee+Zedy?=
 =?us-ascii?Q?TXG8vm5qavVQJs6CgpF/DENRfzpH5pLIR5nl+AGXs0El199qNldY9rO9b7IH?=
 =?us-ascii?Q?G1fpXPjCvBsQEwF8JpIWdYmhiIhRhvyAApRQIo7+qwQdS0S0QY6EVW0DC++M?=
 =?us-ascii?Q?p7FeSAVVUIX8sGWb9vKVIb5O1SXj+77iXVVRwOswcgmEL05vyErrAVaTjKGb?=
 =?us-ascii?Q?FLlODLC1+DdQysjM+qxZG0BZq/d12JQ2Oy0q0RNC0pbeqUCYO+5pn6e4bAeb?=
 =?us-ascii?Q?0cwxaO3zoaCVcakWEDvM3/plT91my7KVT2ZAbh5WLfGVHu1CY1dk+gO7Ioqm?=
 =?us-ascii?Q?ggkpZKrDt0dy0MggQghLt6fVpUwIlmeDNN9Bl9h9QVZCcqwDu4nklKhaBzlO?=
 =?us-ascii?Q?2nljlLwOybykARsf6xXH5oaiE0r55zEbY3sKUz88xQ4E9oPIqbN68XKLg0aA?=
 =?us-ascii?Q?CqqsL/AAW1eE/v4xzTX6RKre8eBWdr/4vTkylWAorK+rgpDubo11t4lHIwx+?=
 =?us-ascii?Q?qarF1n7qd/qdF3XVW8tUJ+9NooPlRFCcnDUMYETNelpEJhzqLaPOoHc+pG0L?=
 =?us-ascii?Q?JqkVOK3xXr9iJ9shr2agzV6V5rBrcCXbXaFqJ+RGgPTitD2nbkWTX5QCXmLW?=
 =?us-ascii?Q?eY7AQ5lmAxf+6+Lm9dAhH7X7ahjmok+/6B5QsOek7Pn+dY2H052tA/DguO2T?=
 =?us-ascii?Q?X2gvjvlPHBHvi4PqrQI7K0ipW7Po+ETqYRTkz26HKfIXsICPO2d2iNGKcpY6?=
 =?us-ascii?Q?yN5gKgh4xHyviW6STEIFdsXwdwLFxwK9bdOl6hN3uKDJT3zw6I7JnuQFcjON?=
 =?us-ascii?Q?0cL3WtnG3Ka4nloh6NSHqkJEW6T3m/u0OpvXu1eb1u3F3AwH2gZi4hPaWfl6?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19c3634-5919-4aa6-3dfc-08dd5c379bcc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:46:46.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwPFh28Shmt9gxHe+/dpNJ23THtpgOkyGfspwbhfNZHsFK717tnVxmxyQBTHtGtnrorixW1zqAdQQjdj+7tAig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101

On Wed, Mar 05, 2025 at 08:00:20AM -0500, Faizal Rahim wrote:
> Packet buffers (RX + TX) total 64KB. Neither RX or TX buffers can be
> larger than 34KB. So divide the buffer equally, 32KB for each.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 8e449904aa7d..516ef70c98e9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -400,7 +400,8 @@
>  #define I225_TXPBSIZE_DEFAULT	0x04000014 /* TXPBSIZE default */
>  #define IGC_RXPBS_CFG_TS_EN	0x80000000 /* Timestamp in Rx buffer */
>  
> -#define IGC_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
> + /* 7KB bytes buffer for each tx queue (total 4 queues) + 4KB for BMC*/

Strange formatting here: space before "/*" but no space before "*/"?

> +#define IGC_TXPBSIZE_TSN	0x041c71c7
>  
>  #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
>  #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
> -- 
> 2.34.1
>

