Return-Path: <bpf+bounces-44775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C169C79A0
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B48ACB600D7
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6784D13;
	Wed, 13 Nov 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DWVD4kXw"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCEA7083B;
	Wed, 13 Nov 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513359; cv=fail; b=r+TKhW4/LdEH0BjhodVrkUcfqEAwHdv9JjtAihbx26S5njAzZ6S/K1kcwM7pthF75NdYbZQv7wh2/1ZJDidKmwjf/kj+ztjsaJaLHGiD7IR8A3JhLvqj9lgykWY6CwFh6Ul0MYcKUIRyDmQ6KMWLUrOrZ3CVeCX8HP7ASi+NMLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513359; c=relaxed/simple;
	bh=g2Cv7Rq/b3r/evs58Sw3wNE02SzKHSBQXPMNRYWEODk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qp2ag4Pnv7CVLamPgHxjL60fnd8hRzcXizY4A1b/B90VDbV+FzFsqhWGp7Lmfx36nS5IuOdfu4SA/3iC8gp3MkVlpav2XaKY2y2wr8nYNgmFNY6eM+EzlY50kXQRUDinNVEh6cMWVnDDlN8PyJJmmZMNPnkfsKfA8vbZHmPLX9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DWVD4kXw; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsjumdwXi0bnA5F4LLQtrshgNP71G3p5Qg4KFnj+XK+UYSS/US7xSAS2QsYd4jD8vqs7UTOxqsbLNHxRTFWDQF3b5Hn32FnIzAaKS2XXeEqEN8ml6ob0RiHM8LdLX6jQf0Y5bs++0Q+b1d57CiuAHoak70n0QKNv6NQIAO4RpuNeyB7DIBbRyV5xCBrOXn72S2DMyHyc8Ys69WeyRVeK3ZfTB52PQNBi6ooh+Y044N9+/5lrotV2ICR5Zda7TP4Fd9tgtuw/0QxnWrrEiaSAJJhDPXzD20v6Ed77+aA2rgCk/8SOmcD71FumqnjmF6TuZanP+jSPspJULxoXvf1OfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1O9+djzdBi1jGLoprRNq8CZGqAdwOUFTtqlOzuEyw0w=;
 b=LNhlzfEVJPgM8L3OOszpwooKIJB408WjlHHQKGMx+HcEbTs+ZfCUKx+f/8HSCZw89VjMYVrBuvyJlHJQntxgdpSJQnUpmKKFmM2iOu/Mbf3msvsLnjzPeaVZEMh3XMH/Y7zYfHk/dsk+CYQs4i3UOjClUI/DfnKfqGipo74CxNkQHu+IOEOlu8lsCFP2vdsffNpFKgpva5i3spoSUlvAAt6Ou+hvp6p5RGUFcBxUONH/pGquLuQAsauaDw9pqTWKXr0+uFERJV8DbERLSdMxMtiDVa4Yul3s9UxrhJgFNRIfDJeXv/R235tbrU2NdLVDrbp2vbYcTwu+SVQQNpf/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O9+djzdBi1jGLoprRNq8CZGqAdwOUFTtqlOzuEyw0w=;
 b=DWVD4kXw2F5FA/3R0B+U30M9CFo5bW6+q7E7WM6Pk04ozpBztbqZ32k55frnlw2++0UqK4fTobYcG8rhyK2RHtvpxzUG+ygWY1a43G1Fyb3a5L+yTH5ewcwGN58S5XivcPeeio0FJHilgHzxZ7sKuX8Ha3vgZnd04K8y3zIyZnkTuBB1XW5rTFwryr8qcBwkzA2+DnqHm+qDal+8GGuAbc9abk5dJoUeLJA2YP0Dfz80p9OWqS2C8tEiSJ+fhpISJADxqHbfZHfJWnwzqvG209VFj9G7XhKsks+leCHWoDgZnTxVqD/NIYv+f0eGRwJdgE4W5zpVbuo9GXl+993Uqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB10852.eurprd04.prod.outlook.com (2603:10a6:150:225::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 15:55:52 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 15:55:51 +0000
Date: Wed, 13 Nov 2024 10:55:41 -0500
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
Subject: Re: [PATCH v5 0/2] PCI: add enabe(disable)_device() hook for bridge
Message-ID: <ZzTL/b4BEAGvSa1Q@lizhi-Precision-Tower-5810>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB10852:EE_
X-MS-Office365-Filtering-Correlation-Id: 458943bb-a47c-4d2f-91d5-08dd03fba60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODdCalpNTzY1Y25Qei9QUm05WmRnYy9vS1BTaUl2aGphZndIWTdmUEZ5L1ha?=
 =?utf-8?B?ZXlNdlRrUTZqYzdvUS9lUlVqVFFVMFNZNG9lcG9KK2xMazdyOUVyRkd2aTM3?=
 =?utf-8?B?ODRjK1B5Mi9pQis4YWVsSjFGVUR4YkdSY0tZSDd3dUQ1Qi9XYW1DYS9PWVQ1?=
 =?utf-8?B?U1pJSVExOW1xTnBtM0ZjU1F4TjlYdEN5UDFGRlE0enBYTFRKVWlMWEtybVN6?=
 =?utf-8?B?ZnkwL1RDTnp0dzlRcjEwN0lJMW9hZXluWWlHa3hLOXVSUXdqcjRHRko3bmpC?=
 =?utf-8?B?NEJwRjB0R2hjRnFpT3hZL0srQkcvV3BlYURBY3JLdHFRanZPbjlnVEVCanNa?=
 =?utf-8?B?ZFR0dmlqUG02UXRVN092MjArR0I0V1JZL3k5Q1NGeHNyTnpUVDBvZXpjYjN0?=
 =?utf-8?B?UWxMTTRlRjN1RklUK2ltZSt2eEI1R09FWlc2MDU3ekh5Vy9BZ0E4WlduaDF0?=
 =?utf-8?B?Q251RUxOWXF2MXpGelpRSzBaVERnVmxVWC9sSllQeHhkK2FwWkFQWGp5NVUw?=
 =?utf-8?B?dzUrZGEybmM4UTFialF6SXpHejRZemwwZ2w2MzROS1VPblB2M0xEMDlpWGpy?=
 =?utf-8?B?REU1dkhBbHFwMm9wVFNxb2F3S0xYVFZpSDNPdGFFSlpaazhDQ0srRml0eDZU?=
 =?utf-8?B?ZUFNV2NLY0FmVllFV3lRMWtUUWJGeUtBeTU5alhKMWU4WTdJbWVJbmYxSDll?=
 =?utf-8?B?QU5NMDVPSHJ6OVdKcHVNRnlNaEEycXVDc3FuNW9SMjc3WnNBdHNNL0ZVQ1V6?=
 =?utf-8?B?Tm1uVnpBL0l0WUR3THlRY0xRVFBzcFN3bDRHVmh3Q0NlQzZJcDBFZE9kM2xL?=
 =?utf-8?B?cWxDY0dBUTR1ZW9vVU1aK0h2RFdHV00xSkxqYklFMlk4ZjlPajNjS3pyWFlj?=
 =?utf-8?B?RFFWU0VMcVRseTNRZVdQb1hlUnkrZjBud0dDU2VSaGcvOEpKdnpPRTZPdkt4?=
 =?utf-8?B?amg2bUZYWDBzY2RmUks3UUJ0d25pem40dkhadm0wcHhFVGtVUmdERzNDVFpw?=
 =?utf-8?B?R0tsQ0dndkxEYjZtMEt0R1ZGV2RibDM4UEZtZ3VOMFU5bGFUWmpCRmVFZnAy?=
 =?utf-8?B?MUE1WEtubDBBbmVZU20rclUxYXN0aVcrUDlKNFdjdFlzbW1iNE4rYjdWZTFa?=
 =?utf-8?B?Vzk4UGdtdWl1dGIwVnM3RzFFQ2FSdXIyMjh5eGVic0ZqcnNwWmdhSW0xODBJ?=
 =?utf-8?B?bk9mdm83bmw5NlREeFpPcU9weHgrVXhKaXB3VnNmUitRbUFkZW95TEtOM243?=
 =?utf-8?B?bmVNSnFXc0wrQUFlM3QxY1dra1lzSllBMmdjZVlrLzhFRVRBdjZtTTJ1eE4w?=
 =?utf-8?B?RkN2Q3JnUzgxUFRIRzNHdFEzZDdnN1hvdTdTVStPVWs3ZTFqNnRnWUdzV0Nk?=
 =?utf-8?B?VUxlZEF6TGJVOTNVOWFabDRSYTZOYWhGWm9NOWYvM2RrdEFaTWZrQ05UNWZr?=
 =?utf-8?B?MXZzZWhrN0xOUnliOWVWQU8xR0Y3ekdSclNRS3NJdVh1SGRVcWRUTHc1cldz?=
 =?utf-8?B?SUROaXcvZmFvUjZoMDUzMGY2Nzd5cDZZVllybW5IU3FxWnFCN1BGc1U2L25i?=
 =?utf-8?B?aUdHeTEzNTloNlUwREtreloxZzhtb3RKSFlhOFFYZlJSUEVLd3FFSjQ4RWxK?=
 =?utf-8?B?VEJPVkRobUlZQTFqdkZTcTRLZWRjU0VaUXBzNGtiSG1xVkY0WDN0anJja0pu?=
 =?utf-8?B?MzNOcmRZRVJ3MG41MHFuV2VkUi80ZDd2S09VaWZURzgwelRHaTA0V25nUU1T?=
 =?utf-8?B?WVkwM0FPK1RrL2VpeFNiSU9iTVNSbUhKV0YvQW1wZHlxZDRZNzV2Tk5KeDRO?=
 =?utf-8?B?NVR3QWRyMjlsRk9nb1ZZT2JiWXF6UlQxRDRGNWErcFBmWXFPMDVrcmNRZjNK?=
 =?utf-8?B?b2NYaVFOTVk3eVdNVWMwTlRqMzZXc3FXUS9mQ1EwUjB0b1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elBmaHRwZUZFdHlkV0g2VEpGRkViU0JDakx3aTdWTHJwMWRVU2pLdnAzTTRt?=
 =?utf-8?B?S2UvakMwTEJBZmVFQ00xNWMvdWxrcktQcU5KZHJBT3FXaGprdjdCcW45bU91?=
 =?utf-8?B?aW5QOVpXd1dmT2hhdXYwTngxSFNWWHY2U1RzZXV6SXFSZkd3NmltWUdHc1l5?=
 =?utf-8?B?dXV5SmEzanA4TjFybktMcVNLN1JjYVhiWG8wRTdDdG93dzJLMDU3MnNSTjlO?=
 =?utf-8?B?UzlVTHZMbnpia25ESThwRk5TSTFrQ05rdlBZTTk3T2xjWEgvcU5ZOGZ2QVVM?=
 =?utf-8?B?M1hZN0pFLzl4QmwrZUpzVVIweE9rdWxEY2hBYnJXemsya2hBSW1MNFJDQUt6?=
 =?utf-8?B?VjVJZjVPU3J3Z2Uya05BZUxvREI4UlZNQU5CSEVkdUJSczNMb2JhMWxNeEF0?=
 =?utf-8?B?Tmk1RTRkVEV5ZnJ0N3Uwam5PbXEzUW5zOXZXaVVVdHFSNktBMlAzdlFGUzE5?=
 =?utf-8?B?a1ZCd2YvWnJ1UHhJUWh1Tm9UTzRJY08xdDVPNk1YSXFmMHQwWE1lU3ZiMXFz?=
 =?utf-8?B?VmhzS2tIU1VCRGlaeDY1V3ZWYWNEYml4L0d0alVORDhnQTVCVFdZeEdZTTR2?=
 =?utf-8?B?WlFHdkZ3UDgxdlNPQUdDazRVQnhDbjllSUFUNlJrUVJ2a0w1OHZVNUpzRGg1?=
 =?utf-8?B?ME5ub0NSOHF6dXp4VnVrQkxCYis1TUV6R2hoRnVPNjh1OGVIdjg4NGZ0ejE3?=
 =?utf-8?B?Vk5DM0FRMURVQjUvMy83SnZqN3A3STNBSk1Xb04wMEkxU3d2bTR5bmkycGFU?=
 =?utf-8?B?TjNEVjhiYllOQjF3UmJSVzNIUzN0ZkVSNmxhQXovemJ1ZHB2MGpodEZSM0Jx?=
 =?utf-8?B?aVc5VHdDTS9yeCtlSXp4SmlHUk5SdzFMU3ZZUzYxNVZhREFMYUJXRmhST3RF?=
 =?utf-8?B?WXc5aTNZb3ZTUlJmejRmV0pPczAyTWcrQ2dJVUpjeTlMY0l0TnJmQm9UQm9B?=
 =?utf-8?B?c0pFNFhqUVkxdUsrRVIydWF1U2g4cFNkWXYzRFpneEljSXQyNHIzRUJpYVRO?=
 =?utf-8?B?TGpCSW9rNitUSkhLTVh3NzM2WGVBMTFCV2F2M01pNFFJZWs1Z1VoN25Iais5?=
 =?utf-8?B?YlBCZ29nK2ZtMEhtbVZoOGxhenp6NEFseUNQWG0xS1gwQmo1SVVVblBnSDhP?=
 =?utf-8?B?Zys3b1dPa1NFLzhKaWsyUHYrRG5rRGJ6Qmk3czNsVXhRMUlMRG5wY2ZySVgx?=
 =?utf-8?B?NEY0cHV3Y1VERXZQVDlEKzcvNUM0Z2NNR0dXc0xVamFiaFhEdEoxdm9TMWVo?=
 =?utf-8?B?NmhKU2Vlb3RuL20yV1cxUWZkckFvdng1QWxGT1YvR0NuSlN3SUppRVZrd3Fn?=
 =?utf-8?B?dkM3cTQxTFBLR0lQaUFWdjlWWTZybnNoSjRkWklPanhrSkdCcW5vbVZDS0t2?=
 =?utf-8?B?L29FMVNkQUs0QWZvMDhoRGpTVVA1UEx0MGFVLzc2OWl5QjJGQ2xaTDVkWS9F?=
 =?utf-8?B?YThVdzRDODFqYkY5cXcvSzNwc2hkbU9MRUYzQ3dnVmdpKzBUdm5LRldDcmxz?=
 =?utf-8?B?QitFdWZ0TkpQZXhBZmxNQjFYL1RWTGgzcWh3aklCa3ViS1FQVjUwRFcvUng5?=
 =?utf-8?B?SjA3Y1c4MjB5b2NnakRWZU5IbVF1SDYwL0F4dWpSOVFhVzl2dmhIM0E0Z2hD?=
 =?utf-8?B?aUxQSy9BbG0rbmpsWjFuQm9tOU9FZVhuTGJaSHl5KzVSa1U4eUhvZStCODBC?=
 =?utf-8?B?ek1lQ1JCWjNOTWNIcVpGZ3VqeWNISjAxZmFUTkNXVXB6b3hhZGlVNDNjS0M4?=
 =?utf-8?B?R2xzTUpQVmt4STNtaVJrNkMvRmZEK1E3dDdvb0hiRzVtZC91Q1NlZDlFZDQ4?=
 =?utf-8?B?YzRpeHUxOVJ0M1dsVmwwQVBBVmFGdjI3VEU4NUtlcGNhakVMNCtZamh2VFY5?=
 =?utf-8?B?dVYrOERUSGRWMFFYY3IzKzl5Q0VBNEVPejZDZjZ3ZlRyQWZXZ1J6Y09FYmdq?=
 =?utf-8?B?UlFDeVpib0EvODdqamM5SE9lemdkT0RFcE8weHE4a2pDRVVWWlNQUnVDekJJ?=
 =?utf-8?B?aE1hRmZrck5OK0swdEF1V0dhWE9DQU9KbzN6OHY5dnYxWGhnYm56S2pobHBv?=
 =?utf-8?B?SC84THNRR2YxeDFlRG1lbUJlemt3VVFMZXU2MHRJNlBxMVJtNXdpWVpuUVQ2?=
 =?utf-8?Q?i6jA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458943bb-a47c-4d2f-91d5-08dd03fba60e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:55:51.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18cRogZmWlm2+9Ef+YqXQ0bf6s54pHrgpEKd04/JIryQC7kMPasYKCkiVIOBTMUljcYYbtwcIyUfKPJSGoY+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10852

On Mon, Nov 04, 2024 at 02:22:58PM -0500, Frank Li wrote:

Any comments for this patches?

Bjorn and give ack at v4 and Marc Zyngier give test/review tag at v4. I
just drop these because change to use helper function and funtionality is
the same.

After this patch merge, I think apply's bus notification can convert to
this way.

Frank

> Some system's IOMMU stream(master) ID bits(such as 6bits) less than
> pci_device_id (16bit). It needs add hardware configuration to enable
> pci_device_id to stream ID convert.
>
> https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
> This ways use pcie bus notifier (like apple pci controller), when new PCIe
> device added, bus notifier will call register specific callback to handle
> look up table (LUT) configuration.
>
> https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
> which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
> table (qcom use this way). This way is rejected by DT maintainer Rob.
>
> Above ways can resolve LUT take or stream id out of usage the problem. If
> there are not enough stream id resource, not error return, EP hardware
> still issue DMA to do transfer, which may transfer to wrong possition.
>
> Add enable(disable)_device() hook for bridge can return error when not
> enough resource, and PCI device can't enabled.
>
> Basicallly this version can match Bjorn's requirement:
> 1: simple, because it is rare that there are no LUT resource.
> 2: EP driver probe failure when no LUT, but lspci can see such device.
>
> [    2.164415] nvme nvme0: pci function 0000:01:00.0
> [    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
> [    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12
>
> > lspci
> 0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
> 0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)
>
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Richard Zhu <hongxing.zhu@nxp.com>
> To: Lucas Stach <l.stach@pengutronix.de>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kw@linux.com>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Rob Herring <robh@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: imx@lists.linux.dev
> Cc: Frank.li@nxp.com \
> Cc: alyssa@rosenzweig.io \
> Cc: bpf@vger.kernel.org \
> Cc: broonie@kernel.org \
> Cc: jgg@ziepe.ca \
> Cc: joro@8bytes.org \
> Cc: l.stach@pengutronix.de \
> Cc: lgirdwood@gmail.com \
> Cc: maz@kernel.org \
> Cc: p.zabel@pengutronix.de \
> Cc: robin.murphy@arm.com \
> Cc: will@kernel.org \
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v5:
> - Add help function of pci_bridge_enable(disable)_device
> - Because big change, removed Bjorn's review tags and have not
> added
> Marc Zyngier't review and test tags
> - Fix pci-imx6.c according to Mani's feedback
> - Link to v4: https://lore.kernel.org/r/20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com
>
> Changes in v4:
> - Add Bjorn Helgaas review tag for patch1
> - check 'target' value for patch2
> - detail see each patches
> - Link to v3: https://lore.kernel.org/r/20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com
>
> Changes in v3:
> - disable_device when error happen
> - use target for of_map_id
> - Check if rid already in lut table when enable deviced
> - Link to v2: https://lore.kernel.org/r/20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com
>
> Changes in v2:
> - see each patch
> - Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com
>
> ---
> Frank Li (2):
>       PCI: Add enable_device() and disable_device() callbacks for bridges
>       PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
>
>  drivers/pci/controller/dwc/pci-imx6.c | 176 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.c                     |  36 ++++++-
>  include/linux/pci.h                   |   2 +
>  3 files changed, 212 insertions(+), 2 deletions(-)
> ---
> base-commit: 06fb071a1aefbe4c6cc8fd41aacd0b9422361721
> change-id: 20240926-imx95_lut-1c68222e0944
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

