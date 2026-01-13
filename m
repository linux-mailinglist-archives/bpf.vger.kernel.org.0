Return-Path: <bpf+bounces-78734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A1FD1A1F3
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 17:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5663330517D2
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE0387378;
	Tue, 13 Jan 2026 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gsDpdp9G"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638CF378D8F;
	Tue, 13 Jan 2026 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320706; cv=fail; b=f7nIj2QoGyO+CEjNJZe3+WNaHGNMAoZNsmg2GtGyNCgj3y5fQsoQngETnZS/dnQ2K9WtPvHDQoQKWUo37neEGl1MntD1CEkCGNixYkBQc11lviFX/MYVtZY94agAZakBLP8xlUm/J+lp5fhwboxwZWS1icHJKt1XVn+l2hXmAPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320706; c=relaxed/simple;
	bh=RXvj6A7i3Qo2N+AOlfjvhVy5nKzmFxJ81OtD+ONF/9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iht/epdijzueAzHSiyHxXIiaUgdF8+GMwhZfeU0z/fW/2WLBKYukE9gbNTkh3s4tcqjsj1RESVPeO/Ll5dUQUb1IX97ZqskAh0SlAnEZa5hK1lkaM8Ej7LNP9PKzTlM/VsEfamvd34KCKuzLqUcDw5SlZ+f2UdUr+n+DNsQQjS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gsDpdp9G; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrOU3BqOsDWgguAuCkx1BWwUu9jB8p+nno8dQZsoWhlwB9vnu6FKozPJC8wIe/U+2x/GmljKebsJOoN8p8JA2I1lX20dh6/AjmXHR1ECajHqiv12Yb7PT70Y06SkZzpWZ5J//UGdrzSa0VmYY3Jl/inZdsliMQjUedq2fTIe3XB3BI73jaKrXqd6wVNvNMW80HyDTMRksMyBFGd36uDGq5Pc9rlkQ7aB4PRzcMZUXsJ41g6g9WjT89BS45/bKdLBQVpiDdh1W3nxOPfIeJNitjDf3SxfLgvc2/lz1CHQlqXAw+xO6bda0b3Mc1xUWe3WXHuWBovV9qiqoswQtE6dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuKHkZI++WKsm8OIuNJ4RufuJVd6mEGh4RNx3O+xo1c=;
 b=JhyUywRxaCWn5dYoZlcU22nYz08UVNT7WASYms5S8RbjXkJbOH5J3II9c23pJ7RIOIL7Rm+diCorgJ+GDGCHzIj3exI6LXGgxCdjpPjlvPihFOJoQsK5h98pPPEmeLx2o3Zth5e9uMFZ8ZkUllnmzKMqsJ393OXdNxcnRe2sEwy0g4pg/Pu/NTIpWfjYzG74HZ9XRiR9/mbfR7ygN3lkBDeOoFhhuP72R5VxkaXZ/IgeFYhOHp+Wfd06yokvMAPMMjOTk6FWIpiDL+D137BLGfHYOhDQX+T8pBvAKhlm7jrDelP1oU/SaSGhaMhw7VoBgpo31f6+OtK7QgI4v9t1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuKHkZI++WKsm8OIuNJ4RufuJVd6mEGh4RNx3O+xo1c=;
 b=gsDpdp9GVsCGeGvtKyUDtO3LgThk0rW1RBXx18hVL90ke3P3Y0kLkOcrXghQTM0IzknX7dY4qdUhEfN/zxCv1F4NAEShpR5iS4zVcOJ4BMoJf2PC8aCunOgqfxu1SHrORwZcZ6U6HsyZ/nXXfjgSsw1RWC/QWfBMaF4yuY391B179IxBmQJPPtGL5JFIyr+zsMRDPeYOWPgphPMHxjF1DOhjKC1CMMuf7LYv+t82jZYwLPui2IH3fEEuEoyfOBWajvTVGwHQbhkA8pM5xRJefZjeaAhkBtTME0pIH7ZgmtmjI/00zQRMrrm2BmURVTR+dL1/K0gPf3MYSjA32/8sGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by MRWPR04MB12042.eurprd04.prod.outlook.com (2603:10a6:501:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 16:11:40 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Tue, 13 Jan 2026
 16:11:40 +0000
Date: Tue, 13 Jan 2026 11:11:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 05/11] net: fec: add fec_enet_rx_queue_xdp() for
 XDP path
Message-ID: <aWZusgu160VJFqpT@lizhi-Precision-Tower-5810>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113032939.3705137-6-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::32) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|MRWPR04MB12042:EE_
X-MS-Office365-Filtering-Correlation-Id: 191bdbea-953c-4108-7e5f-08de52be6f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3LZttJfnqletb2Ot9jLxDzU30r61KUBdFHkQ0zsaw64kMUW9SKeqe5FlFvap?=
 =?us-ascii?Q?U8P4u0P0+PDKntMJVJ4PvqZQHhvaXONeGogl5X/IhkwzgSTb7+I/qRBBevWw?=
 =?us-ascii?Q?nbJpFU3+r2ZFzSRgxs0XUtbjQZAi357aJbuhMY4NJRBEgrSIX2JLAVwU9zIs?=
 =?us-ascii?Q?5O4Ww5qGlpAm+q/zoC6gwyZj0TSvPu+IG9o+pVPoXQF0bpN+OcCie3BpLd09?=
 =?us-ascii?Q?JUVpmM+4kyiyzP35GINrq+dQ94/eUC434AO5MFVZGQRL37JPcgfBM3KuFP6l?=
 =?us-ascii?Q?GLKNxJwT9OGD2TvVhjg64cbO92fhFmZGcJ+no4y/y+7jNxIyFdWhJbB1YCQT?=
 =?us-ascii?Q?4C7QC4kTmJ9KqsN4uUZc2VgfqenS04GWct5P4bxNXVsPtFLIOtoaKDzBvawa?=
 =?us-ascii?Q?ckK2MYgv58OAieuy1hVqSdmrnvj1RKb4/5Nic9I4DbhI7FyeNWr7EmznJymI?=
 =?us-ascii?Q?FuUABxxRXUnmoC48X2PZoNsv15adgxOfrOc/cf4pyTsY7LEADBg9SEhYslyE?=
 =?us-ascii?Q?unRhCWfS5tmLDesa/QtUoylVo1JyAz/zf1y7W+esNc97UAZQFJVgRPs4qgrA?=
 =?us-ascii?Q?F1LOLGaSnYf7U6iLr9/gGtxluxeS20ceuFTYUhbfZyZJBbcaxvhQdNn73rBf?=
 =?us-ascii?Q?f+I5ONyO3/QoohL39BYqhmfTSmhDkh64XJsecavBV0MuUOh5AUjdXTgLLYFr?=
 =?us-ascii?Q?nQZH4qElA2FabziQYoYjqsLghvFA4xCwkteiSQb2dfmGNt3PIn7RzcvfI3Gc?=
 =?us-ascii?Q?NyjL/gYiQaTnZn+fgIDlG2NkN2plghk4zQDEzgaEFu3gCgaCQfynrhyyxZKW?=
 =?us-ascii?Q?Imjlus4ALLg5nUFlI91g+cPJAHoUkMRFfH7HX2dDmhE8xON6B1gh6S5SzBkx?=
 =?us-ascii?Q?+uYEiMsBHl05e613l7tYvbyq9t8NnpxOQ3NtsVnAgnzI4V4Qnd4JVBFzyX7c?=
 =?us-ascii?Q?HfTRaRIU5tUbcXZ+RYyKa6GyLLlTyVqh3M8WnLmXKq3i+SSaOPP30rqoBkzK?=
 =?us-ascii?Q?DDjjkmAfxXvOgL4GVTnxFaRld5YlfzA8QiTdHzL/oyK2VhG0dsYQ9gV5FhcC?=
 =?us-ascii?Q?DvhfgOcK5vU6mlN9Trx9SYhtbJaCodM2C+1XhVlYjpxAAl+luKfyXfyGlf+3?=
 =?us-ascii?Q?78bXoO+3DLIT1pmDsgnMdstMWtjbRfP+xYrHH7xvhHvMTH8+L+zUUaqpEIKd?=
 =?us-ascii?Q?Weg81s5u3H24kuOmy2rM++fIEMi7uC7uL93x88RjdfrouPU8Cw4B3y8s02L2?=
 =?us-ascii?Q?eW4wV2zIxF1EeX2TzgQ7CChMS/oQvjSV7MAyE19iKM3IKvpqPdThFBX3WRd9?=
 =?us-ascii?Q?610kIU9UgBo+lAEuPa1kZYRfdkRND7sD1RYXUXKgDtD3xfeNbg+tv6Sf5ZsX?=
 =?us-ascii?Q?5fvrktj5+eYup9jOT16uvNIQiH8e4KjecH+L+hAYvLC+0w11xbuqQfDAu/Xt?=
 =?us-ascii?Q?Ec2+t6bJER16hewGOaBmptAWOB8O6R0JzRH8RTuxpa0RCQ6xSeqAJ/lsHqXW?=
 =?us-ascii?Q?6EEES5z1ZZS2yqIo0p2LrUZn+XChW9bBlvyN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/5/CTvC3ICn8Pwd0y5V+8j4FWKoXlskFXGmQEyb/LV74Vm9Ll3d++WXerIt?=
 =?us-ascii?Q?DTkz5ohAe0ypaP4Gj6M43ye6CgiseFBRcKAqpsMMr6fBZnlj6ZsZGXWvCfSx?=
 =?us-ascii?Q?zMirY+D/KBcWNjo4TwW3L+DAhWm8ySMB+zDTRwMTCXZlC7hFXEZBdQH/JaXt?=
 =?us-ascii?Q?o+7/C3tApdmlBH8lwG9B40wCRsWEKh+W397gZLxzAsFRk1RhTmkfHvvDfAxz?=
 =?us-ascii?Q?j1Ldbjqb2nebfDCz1LkaZkbHPQgzCzNbRNrcUyD5cmma20fDd4yybNjv5bYw?=
 =?us-ascii?Q?O4ELbiCCOuOBMza8dV6Y8sJpPGHSwvyrV3IOfIOSabUr0CyrNyMWGERc1fQf?=
 =?us-ascii?Q?RTcWufdtTuN/vbhK6OW3+SWACxURjHZv8XdpMYeYDGm0VdFqRJ2ApQauiIVS?=
 =?us-ascii?Q?9k5dd2VYJrQRn+NOlCBwsa7IjNKitgqwpepFKuZ+9FTzJ0m6kgSxPf/+FTsu?=
 =?us-ascii?Q?6g4WiihvnAM6Ip+dU6yIPE5ouWZyxM1WrBIt98H3Y6Qp9hNNyROpF844/D+3?=
 =?us-ascii?Q?IflEzCVwdXkA9sr0TMrnaCyB8qkq8dhInqlNZrOWjsKb/3Xf2i7Ss8XyPXOr?=
 =?us-ascii?Q?VWiIoQ1qoMst4ECxfuDuTjk4tZ3/baSxQV9+Qjc3FD04gAOMelutfcT99Kt9?=
 =?us-ascii?Q?/1RJ13iscPy4wmJAGGnGYsvzCP0Zv/ZeZmfwVL+sP6ZyVYoGsabaSP+aAv9i?=
 =?us-ascii?Q?g4+YPFMBu/wf29DAEdxwaSBkcazHJ6R0FYksVcqVWiAKVpeFoQfT4kZdERD3?=
 =?us-ascii?Q?Vwv8uLV9rOFNd3yuEVyl4wpkUvfBTJdQmYGhIU/hL60lCK6RHMrqe0/sBzqe?=
 =?us-ascii?Q?4+6nSlywraLW2MJMPlAuWkgXbzACTt3JIefk5LAuQLePXaDiV5YyKgcajXGE?=
 =?us-ascii?Q?NmP5JSGKnUHuAKM4R6ntKvqBCRlDJZl4piY9MqbrPRBVtYdM0DjIzAnZRFiE?=
 =?us-ascii?Q?qCH61D10gY/JRx7IcC3O5I3sH0o6xc9/9A0ngQOz2SW65T0bva7GiTKOpvZH?=
 =?us-ascii?Q?VbHrvFPs97mogg/aoxRppIJHmhDFFxfTQ7EjH7AV+wBnPeiZl3vfZz3+ui6D?=
 =?us-ascii?Q?Y8RCw0//kLRC43htO0NOOxB4aHhtawY1Z3UvC6ohNsUfcXWBrf56zfrHLCMx?=
 =?us-ascii?Q?XHHcze+HPTyJwIrO1Q2oUpVOyp8+UFyNUDOHUV4JBhmG53raEKC7XK7rngEN?=
 =?us-ascii?Q?pFFqJYsPyjDCn0B8QqvYYjDkQzQPRNwpNoljEh5l2dVIwyLhqmBpEKt3++Dv?=
 =?us-ascii?Q?h0bru6PFUBDPqn7+rBzLvNga3EDSpu9Pm/RmVTvcMVfDLW+qiNZziJelm2Ik?=
 =?us-ascii?Q?ovsLYDGiwEf0KKGOS0RUFfs9CsvuERCyj4oWKBk6TnqKW++IzgCp4wTFn7UP?=
 =?us-ascii?Q?/HL0jn2rnxezFSErSY23AEhZhazLcNDAKUYHGI9UwWgeW3ml5wpyamYfnB9c?=
 =?us-ascii?Q?U+k6kQh2tsg9TfK0mvIoPaxHwjpjt7PfAAIknavTqlMH/ussKlhV9MRuDGjo?=
 =?us-ascii?Q?dqO80zi0u5xiCwOA7GVvelVzfKLbOwynFFOM2y1icsfVmxpoORd0UZejG53L?=
 =?us-ascii?Q?2D07nxYUm7hi9z4Qz+ef7Kd1O7J9JubXhHa1GeyJiOr+1ol+sgy8HRPNS2Ln?=
 =?us-ascii?Q?nJwMv7osgrb6wPaIfscRxOJp6zOW9fKYVeJgKaJf5Os6wkTqMbIIFRH+u1Ys?=
 =?us-ascii?Q?WrqyUh2c5lh904/X+CjESan0WY//CKxMtm+iBBB8kiL9YJ+w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191bdbea-953c-4108-7e5f-08de52be6f5c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:11:40.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTwqJm7fCgtHD8KeCBFPypMi7pNBhGrl0XGa5xPJQvbsmzd/e4XhSFwJbSeckg/3ihwqoTz4586VbquGntAZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12042

On Tue, Jan 13, 2026 at 11:29:33AM +0800, Wei Fang wrote:
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
> root@imx93evk:~# ./xdp-bench tx eth0
> Summary                   396,868 rx/s                  0 err,drop/s
> Summary                   396,024 rx/s                  0 err,drop/s
> Summary                   402,105 rx/s                  0 err,drop/s
> Summary                   402,501 rx/s                  0 err,drop/s
>
> root@imx93evk:~# ./xdp-bench drop eth0
> Summary                   684,781 rx/s                  0 err/s
> Summary                   675,746 rx/s                  0 err/s
> Summary                   667,000 rx/s                  0 err/s
> Summary                   667,960 rx/s                  0 err/s
>
> root@imx93evk:~# ./xdp-bench pass eth0
> Summary                   208,552 rx/s                  0 err,drop/s
> Summary                   208,654 rx/s                  0 err,drop/s
> Summary                   208,502 rx/s                  0 err,drop/s
> Summary                   208,797 rx/s                  0 err,drop/s
>
> root@imx93evk:~# ./xdp-bench redirect eth0 eth0
> eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
> eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s
> eth0->eth0                311,340 rx/s                  0 err,drop/s      311,339 xmit/s
> eth0->eth0                312,030 rx/s                  0 err,drop/s      312,031 xmit/s
>
> After the patch is applied:
> root@imx93evk:~# ./xdp-bench tx eth0
> Summary                   409,975 rx/s                  0 err,drop/s
> Summary                   411,073 rx/s                  0 err,drop/s
> Summary                   410,940 rx/s                  0 err,drop/s
> Summary                   407,818 rx/s                  0 err,drop/s
>
> root@imx93evk:~# ./xdp-bench drop eth0
> Summary                   700,681 rx/s                  0 err/s
> Summary                   698,102 rx/s                  0 err/s
> Summary                   695,025 rx/s                  0 err/s
> Summary                   698,639 rx/s                  0 err/s
>
> root@imx93evk:~# ./xdp-bench pass eth0
> Summary                   211,356 rx/s                  0 err,drop/s
> Summary                   210,629 rx/s                  0 err,drop/s
> Summary                   210,395 rx/s                  0 err,drop/s
> Summary                   210,884 rx/s                  0 err,drop/s
> `/-fec_enet_run_xdp
> root@imx93evk:~# ./xdp-bench redirect eth0 eth0
> eth0->eth0                320,351 rx/s                  0 err,drop/s      320,348 xmit/s
> eth0->eth0                318,988 rx/s                  0 err,drop/s      318,988 xmit/s
> eth0->eth0                320,300 rx/s                  0 err,drop/s      320,306 xmit/s
> eth0->eth0                320,156 rx/s                  0 err,drop/s      320,150 xmit/s

Can you just keep 1 or 2 test result in commit message, and remove
"root@imx93evk".

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 300 ++++++++++++++--------
>  1 file changed, 189 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 7e8ac9d2a5ff..0b114a68cd8e 100644
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
> @@ -1839,26 +1774,20 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
>   * not been given to the system, we just set the empty indicator,
>   * effectively tossing the packet.
>   */
> -static int
> -fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
> +static int fec_enet_rx_queue(struct fec_enet_private *fep,
> +			     int queue, int budget)
>  {
> -	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct fec_enet_priv_rx_q *rxq;
> -	struct bufdesc *bdp;
> -	unsigned short status;
> -	struct  sk_buff *skb;
> -	ushort	pkt_len;
> -	int	pkt_received = 0;
> -	int	index = 0;
> -	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
> -	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
> -	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
> -	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
> +	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
> +	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
> +	struct net_device *ndev = fep->netdev;
> +	struct bufdesc *bdp = rxq->bd.cur;
>  	u32 sub_len = 4 + fep->rx_shift;
> -	int cpu = smp_processor_id();
> -	struct xdp_buff xdp;
> +	int pkt_received = 0;
> +	u16 status, pkt_len;
> +	struct sk_buff *skb;
>  	struct page *page;
> -	__fec32 cbd_bufaddr;
> +	dma_addr_t dma;
> +	int index;
>
>  #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
>  	/*
> @@ -1867,21 +1796,17 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  	 */
>  	flush_cache_all();
>  #endif
> -	rxq = fep->rx_queue[queue_id];
>
>  	/* First, grab all of the stats for the incoming packet.
>  	 * These get messed up if we get called due to a busy condition.
>  	 */
> -	bdp = rxq->bd.cur;
> -	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
> -

This patch is quite big, can you slip to more small ones.


>  	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
>
>  		if (pkt_received >= budget)
>  			break;
>  		pkt_received++;
>
> -		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
> +		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);

you can keep queue_id or use small patch rename it.

>
>  		/* Check for errors. */
>  		status ^= BD_ENET_RX_LAST;
> @@ -1895,29 +1820,16 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>
>  		index = fec_enet_get_bd_index(bdp, &rxq->bd);
>  		page = rxq->rx_buf[index];
> -		cbd_bufaddr = bdp->cbd_bufaddr;
> +		dma = fec32_to_cpu(bdp->cbd_bufaddr);
>  		if (fec_enet_update_cbd(rxq, bdp, index)) {
>  			ndev->stats.rx_dropped++;
>  			goto rx_processing_done;
>  		}
>
> -		dma_sync_single_for_cpu(&fep->pdev->dev,
> -					fec32_to_cpu(cbd_bufaddr),
> -					pkt_len,
> +		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
>  					DMA_FROM_DEVICE);

the same here, Add local variable dma should be in new patch.

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
> @@ -1964,9 +1876,171 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		 */
>  		writel(0, rxq->bd.reg_desc_active);
>  	}
> +
> +	rxq->bd.cur = bdp;
> +
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
> +static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
> +				 int budget, struct bpf_prog *prog)
> +{

Or create new patch to duplicate TX and RX first. the changen rx part.

Frank

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
> +			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync, queue);
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
>  	rxq->bd.cur = bdp;
>
> -	if (xdp_result & FEC_ENET_XDP_REDIR)
> +	if (xdp_res & FEC_ENET_XDP_REDIR)
>  		xdp_do_flush();
>
>  	return pkt_received;
> @@ -1975,11 +2049,17 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  static int fec_enet_rx(struct net_device *ndev, int budget)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct bpf_prog *prog = READ_ONCE(fep->xdp_prog);
>  	int i, done = 0;
>
>  	/* Make sure that AVB queues are processed first. */
> -	for (i = fep->num_rx_queues - 1; i >= 0; i--)
> -		done += fec_enet_rx_queue(ndev, i, budget - done);
> +	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
> +		if (prog)
> +			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
> +						      prog);
> +		else
> +			done += fec_enet_rx_queue(fep, i, budget - done);
> +	}
>
>  	return done;
>  }
> @@ -3961,14 +4041,12 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>
>  static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
>  				int cpu, struct xdp_buff *xdp,
> -				u32 dma_sync_len)
> +				u32 dma_sync_len, int queue)
>  {
> -	struct fec_enet_priv_tx_q *txq;
> +	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
>  	struct netdev_queue *nq;
> -	int queue, ret;
> +	int ret;
>
> -	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
> -	txq = fep->tx_queue[queue];
>  	nq = netdev_get_tx_queue(fep->netdev, queue);
>
>  	__netif_tx_lock(nq, cpu);
> --
> 2.34.1
>

