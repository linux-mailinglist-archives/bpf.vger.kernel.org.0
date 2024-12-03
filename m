Return-Path: <bpf+bounces-46026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CDB9E2E59
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC989B2BF23
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19491204F7A;
	Tue,  3 Dec 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="as23B1xR"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013012.outbound.protection.outlook.com [52.101.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97C2AF05;
	Tue,  3 Dec 2024 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258568; cv=fail; b=Pl7F1FQtsOLMe+6HISCWjfk9SRuMx2zD4QawjyDWK4Jm4EzealYRBk6f/2W2cDdpYMojbhKjdl5t5cnjVJuCxPVIDw4cHlbPBwuw/dkUWVvcIDgpkJ0/iaQRZ1q4bIY1w9AVMhxFFmATg60rBukEXDOgWidfq4Kk2/Gwle6xRR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258568; c=relaxed/simple;
	bh=xxHewoF9jA/a2MtdASULIX9MIcP5ayLeSkfBiNFgu7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ug40hbb5PNA53axKsN33k1njjE3pzixatbTzj7Y4UdXIHO9BPSrGxW7tgxeWzqQtPhhvvpJqIIT9OcsPRxbAHR0tj9HgkMI/ABSt2SSPKD1WCq29lBd6Qs/SpO1TzW7GhV9858PuprInjiGft03jr8DGDWmweUuswGYl5qT0Ksw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=as23B1xR; arc=fail smtp.client-ip=52.101.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWZIXe2EN98ef0XrxnNwIAjyhQXR/cN0afVwOP+G/7UxV3XwUtCQvje3WfRYHJrIsV8E/jrd/EJsHZD9vlyq3qk1cMpaiOyweONUNQk9bJEo7C3bOIR1CHgh6A+P9RJwhJIfbKeACg6W+TOl6szWPcCo16QcvtbVBV7BTTylNM/GcXhI8+6QNBMeCfqZPYMBy4S4m75NtQ3GSMnhARnrJPCQ1q+AZrEchKSvx7vFUUvjvK5OSptfoMKxmQahO8z+Lz4f8ZLjhWxXWUg+O32mQzCF5DW+TvplN0dKXADaFy/Cr7V5mjdleflSMyb9D2IcAMnQqUaS6Y6H/ipG2E15Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foMVlbPP09JLmHpr0QxFwWIDAcXes8+LlaDQnnHmzcA=;
 b=wqIK0OHt/Q431r039ps3wx/tf2EC4NR79Fb3CSuH3ao+DvOXTpdX8Xoqgi4UVLXkdcTdaALZ1Ezij3CccfJMk7C9aBA9xHNNjaeCFdTsk/uE2LuAqoz9bOGEOKiYxGW3SStx+U3qk7ZElbAIL5bioQCRm45YEQudu7R7CokkCFWhIIRsy+asXukXL4JBlSFP2YqaxCEP5M0keUCoqWmmcZJ5GN9ufmSD2rXrYAbrMVfFT1MeOWK9gK7GKdzyBqngoq+05wmSVYSk/uA+WlQKNqdzCvUOt0W/CJPKVeVvQ0nKvwCIBU3B289HyPmcub5f/cnvOqp9QTKtwWN9y42MXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foMVlbPP09JLmHpr0QxFwWIDAcXes8+LlaDQnnHmzcA=;
 b=as23B1xRsDopXlumIGMKwqymbQH3aU6YfUuEel+9imlVBQhW/BiSoTK0UF3mAStGvySPOaIQMXix18Ny1rRfC/4Ey/0wIRJBc/ymn+Yf87AqOO/iDhA0IIlKO/DachWodPlZieHdduxNmXAftwn/Aqk0vmZ+IPzjIsZCuLChk58qik7B36pSaRrVW4UFrJVehOhIv/I/hJrn7RqqoPtA/z8goQ9CaFxKK9Kj++IwLdyDnJPdJjJDZEFE3dtFgVXVSh115UaAZk7ry6Q82IQE2ufrh3aCQrdF7R8FGlVI74hrcZcASX8YuoV6vEmRI9KeU8mIRp30iw1s3txD8Q3QoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 20:42:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:42:43 +0000
Date: Tue, 3 Dec 2024 15:42:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org,
	jgg@ziepe.ca, joro@8bytes.org, lgirdwood@gmail.com, maz@kernel.org,
	p.zabel@pengutronix.de, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v5 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <Z09tOGxAK6nBB8wV@lizhi-Precision-Tower-5810>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
 <20241104-imx95_lut-v5-1-feb972f3f13b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-imx95_lut-v5-1-feb972f3f13b@nxp.com>
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b779533-80f4-47c0-d4f0-08dd13db09b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8RkZEXpmCXK5gpo1eUaZ03JxVeaSPQ4lMFMbhmcfXQdp5+Nb2kG/CpbYfyIR?=
 =?us-ascii?Q?P8pqmX6wi2HAjVYcrWVa7ZRV+giVuoa5NlPE084/Lia51IPpfHAxHXQQwY8V?=
 =?us-ascii?Q?1mp0fgpOYdbnLlq9BFMFXzqdeJbzcM+pT9oEJsZ4ogj2IHpGFk4CxOBn/WIh?=
 =?us-ascii?Q?+8arp0sY6gRauEDaXbJl86Jsv0GWVpCbbr9T2gFrAu7EU65ncZ92F0vsmTA3?=
 =?us-ascii?Q?gQr49P2PdTJ5+JJDYuMPzShfLmTu5Wds7S56KlvakJ50x3M+j1R+GFMmL+Ox?=
 =?us-ascii?Q?sYmgTuK68AAic2hMFP5ZQvRT7xXfeXY7qhMgUPhIUosCm0nFsbpMehQGqwBG?=
 =?us-ascii?Q?UjnbVoTYuiWV1CE2X+AYyZQhYaUZCSJayz+4Qatn4C+EEneqJ6hV3EbY+igl?=
 =?us-ascii?Q?VpZuUSm/tnktrojqO3fTqU45J0r8ELAxjDRTjR7jf7YgFDKgBI9e4vTYZZEk?=
 =?us-ascii?Q?XlVyWHmPPXwPUO4Cu0sX2XU2mSaw4hpO6b9qoS7C6UefV9Xu/BEdAln5DstX?=
 =?us-ascii?Q?YyroipTF+S1GR7VXmPRre6naMtWoreZmSsBfylZzdT0HZ8L+8LtnebKP+0sg?=
 =?us-ascii?Q?JD3nzQUdjXE59Fq0Lsth77R3o43yPDP9Mo1oKIbral3XOzAwaL2yXJVHFnS0?=
 =?us-ascii?Q?zrS27ijuJLDVI+zHzh9okRg/TgiOBlxJ4FBDA3gNGecJuCDjJbump+KjcAMT?=
 =?us-ascii?Q?2H2zAZYt50vPuCjDoR+3oLXiMyTF++P8jzIqKCYZ39XOu7Z5NP8sGVxeA69+?=
 =?us-ascii?Q?Dsmreafs2/EZhMKP4scdzpFKtvVlRe3X8Qfa4datVDUtGHhvOONOnEmSy6Os?=
 =?us-ascii?Q?OtLHh0XKcbyzQwwUXtNOY+dGKo1rPC3G5ORxj8Fn0z8nUpkyxyBXnP/t1eVg?=
 =?us-ascii?Q?xZOmmJEb5W2dlSuH9BJskbwvp3gzuKi/4KKHXpqW9wqocUptmcAVVOG14dLA?=
 =?us-ascii?Q?zFirD95wTS9d/yb1eM5eV/rkz3lReZnltN+4tpYAFLXbfLdMwqZ497ciRQeV?=
 =?us-ascii?Q?nvdZq6Dgq6kNtF+uoCUMDvIZ7ySm5hBeoRneoqyB/m6YVHn3Qb7b4D21kpOk?=
 =?us-ascii?Q?cwypK/BkJNoiPjWo+ePf6GjlnlR9xNI2NxwMcKR+X4xGsTAxHbafqv7UUf4i?=
 =?us-ascii?Q?Lny5vFMtERZgYpYP3iMUI8nBgOBSFCQIjVZ6WLJrn2Y79wMYk05+f4xsARgB?=
 =?us-ascii?Q?/7YFIn8HvGL8zM9b7FbrFVXS2Ny0b59+ZSbQ08Fe8L7xfmaB4OyOYKM1zid8?=
 =?us-ascii?Q?y5B+tvwdeUayfVEDSUjSg3BOsnmKl9fk2EnFcZnKeNsOjxdBL5yIjgucnlLq?=
 =?us-ascii?Q?LrIXqgvMHswBQz40dSjcpsCvpnYlsw0y4OL9yFQbEkzK1L3QMT+g+rC/7Wl/?=
 =?us-ascii?Q?MkuQrMZY2L/iN66AJtOkAIcmTD3dYlBg/e0HHi3lFdv+Jx9hcEFNW+gbtNcf?=
 =?us-ascii?Q?fbLhOFQlMgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IDL+JB1TxxDfF2L+m2jO+9b8n5ca1fCy5PrjWsbeSCf9ZpynybBeVhaJJD0J?=
 =?us-ascii?Q?0FkrJhBsf7RPd3oN5yOaE2mZHUiQUxFFacueLqYOx7RhHrNGw4R8LTmiI9Sh?=
 =?us-ascii?Q?cfgFLyiK6r5gsQvOsAUzDoa62H2GUosP1RAwKbVZtKCPHc/NFEg/8Ih40uEL?=
 =?us-ascii?Q?qULX31lznLh+wG0cE0muEWu/TUBwX/W4b0Sr1Z+TpO5XFZtLFyxuB/4vz7cp?=
 =?us-ascii?Q?TPt4hDajZ2Yy8JBA54FCHHw6hAuUjKuvGc73Ma0zrIun83Wx7UBLFTJlawg/?=
 =?us-ascii?Q?sBUNtCDxUrvaMgiqoPpDqWjnhuZ1fTn+0b2UMgud7Ojam8sIIAqqnqt96Ek9?=
 =?us-ascii?Q?723gl3/CpwBS8ngffcBdIb1vzrMh59cjGwbAHxb99ZO3Yvo2PexDoJTOOwoF?=
 =?us-ascii?Q?bBrOIzgstC/8q87nDbecqfn84S1QEj/1FRfWTBua9KjsG+rdy8Wwb0Hass2e?=
 =?us-ascii?Q?Ef1kfqkjiYwiqZhu7tWBwvznKERfxsd94+dQKJJkzau9UHV0LxnOOeSmTXcj?=
 =?us-ascii?Q?KslJnWNAT6W6ZhGIAbDoQFPlzZ3FyRz93JWqAW5L6/icCXBvAuluUSmrpE2d?=
 =?us-ascii?Q?5MnNeX99Qd5rFDJ9SJrXNeWU2eiDhIIW+HnvPhQpsyYSd8wuCnwW3mc2zb/Z?=
 =?us-ascii?Q?UsGjIl9URVxwJOE5o+lHmGgP4olQNAW0PSaqMNpMF7yM0cSS3RUlEk3bqBB5?=
 =?us-ascii?Q?dM+8jq5qomdf7cwC0s9e9H/6WTrxni1DiuUqzH4jY/YEg4QIQ+mo+4YGbOoe?=
 =?us-ascii?Q?lzCwMxMF0uk0W8gaDfjHWsv/qxuIGiaJ0SzR7L9lZjQ7aOpnOcOz0OoEgeSJ?=
 =?us-ascii?Q?faUEvB3KeUyxq38C8SklP9613Q6IO2up7WVl6n4HVKTzghtLrJVc1L8jlJ24?=
 =?us-ascii?Q?szkKM6z3P+9P/161GAw8PPfPPZh97WxDFjl3TarBQaFI4hfUd4ORC994sy3f?=
 =?us-ascii?Q?dEj7gKMifVhsVtfdrwuyXoqTZB/KZTuo3YnybhCSJh0bVsVVQaXxRvYY3Ihd?=
 =?us-ascii?Q?t/IvvwSw1fI2aUdLfqtVMY1RaaIOXGRD1jfAopbEaj3YCzSYlnIjkCOiaiQU?=
 =?us-ascii?Q?jxrJcjGdwm8/hUhJoiuVP1PEszHtxFz3mNkPQUZr66vOVcw+HnZwD6w9UDCC?=
 =?us-ascii?Q?cI8yM6nZ1XapWgufiFVyK4PHLoocZyqvPYnZUBuoEl8vBnsxPwRB9hyeuAPb?=
 =?us-ascii?Q?ZB3CFaEoJeeB/wklwj9QUDnVdVHyr0D0d8p7ld6fnMIMEs2DttKEWj9Vg/7v?=
 =?us-ascii?Q?g/jl7c8iVUP8vDVaYmzSjEkuQen7TBuaNfrhlBWVqFgKikY+KIrpGSrLgVui?=
 =?us-ascii?Q?sYnqx67Nn9u6g28117fOIiDIhgQ+yKtK0d/G/71RnaZy/TxW7p4KwZqJVm3F?=
 =?us-ascii?Q?/dZJXRsZio1buSG+fkkmhCrOT0gVm0wYIU/jnsokr23oDwgEVI4mpwHTY1J2?=
 =?us-ascii?Q?J2SKaEebFIFUJ02lsiQhYSREDItQUzV1Rw+Xf/+cSLozL32vzUGdu5vdaKHB?=
 =?us-ascii?Q?f/i33iH3uPZraCXg2ebAWgKapDo5HiBC8ivuPBznmGaMqTONJzTltCh3nmAu?=
 =?us-ascii?Q?QLOGxdkeKOE5kMAtMz1dHKkaneygnFVrMx4Zw2+5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b779533-80f4-47c0-d4f0-08dd13db09b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:42:43.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /N8yu+60V1ooAuiWCR8seJFhudQsWOqJYzZVVTixB4GVyu8o0shUi6wVEMyeEmAIqxDjD6hMPdkKQ5+cA4KL+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

On Mon, Nov 04, 2024 at 02:22:59PM -0500, Frank Li wrote:
> Some PCIe host bridges require special handling when enabling or disabling
> PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> to identify the source of DMA accesses.
>
> Without this mapping, DMA accesses may target unintended memory, which
> would corrupt memory or read the wrong data.
>
> Add a host bridge .enable_device() hook the imx6 driver can use to
> configure the Requester ID to StreamID mapping. The hardware table isn't
> big enough to map all possible Requester IDs, so this hook may fail if no
> table space is available. In that case, return failure from
> pci_enable_device().
>
> It might make more sense to make pci_set_master() decline to enable bus
> mastering and return failure, but it currently doesn't have a way to return
> failure.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Bjorn Helgaas:

	Can I keep your acked tag? Compared V4, just use static helper
functions.

Frank

> Change from v4 to v5
> - Add two static help functions
> int pci_host_bridge_enable_device(dev);
> void pci_host_bridge_disable_device(dev);
> - remove tags because big change
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Marc Zyngier <maz@kernel.org>
>
> Change from v3 to v4
> - Add Bjorn's ack tag
>
> Change from v2 to v3
> - use Bjorn suggest's commit message.
> - call disable_device() when error happen.
>
> Change from v1 to v2
> - move enable(disable)device ops to pci_host_bridge
> ---
>  drivers/pci/pci.c   | 36 +++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h |  2 ++
>  2 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 67013df89a694..4735bc665ab3b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2055,6 +2055,28 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
>  	return pci_enable_resources(dev, bars);
>  }
>
> +static int pci_host_bridge_enable_device(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
> +	int err;
> +
> +	if (host_bridge && host_bridge->enable_device) {
> +		err = host_bridge->enable_device(host_bridge, dev);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void pci_host_bridge_disable_device(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
> +
> +	if (host_bridge && host_bridge->disable_device)
> +		host_bridge->disable_device(host_bridge, dev);
> +}
> +
>  static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  {
>  	int err;
> @@ -2070,9 +2092,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	if (bridge)
>  		pcie_aspm_powersave_config_link(bridge);
>
> +	err = pci_host_bridge_enable_device(dev);
> +	if (err)
> +		return err;
> +
>  	err = pcibios_enable_device(dev, bars);
>  	if (err < 0)
> -		return err;
> +		goto err_enable;
>  	pci_fixup_device(pci_fixup_enable, dev);
>
>  	if (dev->msi_enabled || dev->msix_enabled)
> @@ -2087,6 +2113,12 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	}
>
>  	return 0;
> +
> +err_enable:
> +	pci_host_bridge_disable_device(dev);
> +
> +	return err;
> +
>  }
>
>  /**
> @@ -2270,6 +2302,8 @@ void pci_disable_device(struct pci_dev *dev)
>  	if (atomic_dec_return(&dev->enable_cnt) != 0)
>  		return;
>
> +	pci_host_bridge_disable_device(dev);
> +
>  	do_pci_disable_device(dev);
>
>  	dev->is_busmaster = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a17edc6c28fda..5f75c30f263be 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -596,6 +596,8 @@ struct pci_host_bridge {
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> +	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>
> --
> 2.34.1
>

