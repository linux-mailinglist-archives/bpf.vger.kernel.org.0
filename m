Return-Path: <bpf+bounces-40605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C798AD1D
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4561C21941
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DD1199EB1;
	Mon, 30 Sep 2024 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D7kd6oN6"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362619ABBF;
	Mon, 30 Sep 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725383; cv=fail; b=EgA6zcoe5dA1zqsIl5fSjqUgOPTSuJx3kBIn1O0T4Cwr+hAuN3b3RDEHtSN126lKYM5DStk3fiRP5HFbZ2tKjRdTrvcoTOQVbqWPXwQS5bByCWzxLiH/O6VpDexiM8QEzsGQCiyN53Eb0NrqltxS9bPUTgZL89MqG9WcIWPoAZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725383; c=relaxed/simple;
	bh=/ow1flkLRne6EE1Hp9S1E0GszHPqqrka8qrwUMZ+km8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VU7T8zNiPpJKRWcqcK5RxPQhurDRNH453sTq2iJA7EceL6h2vBxmW8FS1nzd0Lv3/Oydb7/1LLJ5MBnaV3lelTgCaE4E4GuUDR4YVScjNHBKyn8XLwtA9DqWmokYEF3u8Qckd5BDOglHy+rTKqEjdkobklmVY8Lumjl34QrbWzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D7kd6oN6; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDY6YFpILIFHcH5WJvQPh1VkOZC2g03vLjYUtDgukDCubFmrdK683Cv9BHJjxVFSyG1H9IUDFG2RV/wiZJ7zIAaVQsp1AU4Jn7mCyVzt8ANoSwcGGiRnadG2/mWRH6T1jVu4Ch/jN40k/vkdQOtrWhWSo0LfwdBzFfjRVTKg6aAXJTPC5WSrBTBiNUj9bfrYQreRctF9cI49ycMLnLeBK24V6y1GkDgjYMocey/7BhPeQPzMZkvgrao8Iee0ToYsXhrhrXfOBBFSU14HCWYnVnjF08f5RlNp1rhqgViiQh7u070Od78U6kG/icdA48GelB7Mv5EX+G/PQOXpCXgt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmfZ4SDUA4oFkthjzUWy3zBEbHAEc0AvX7E1l1sa70U=;
 b=hdmuVSZAa9coYj3pmGDW23O6oc4qenbrgCAl9qxtZnvI/XyEYnUgbCAOyT93zg/1vWjW7F80L783X2qm3YwkBsENckfrRFwAR4mKpQg0ACZMHZuDi9XYkryyWDpaUKiVKJuwSyxHyy6MJH0+eQQ5SLKCNCPa2E6qDe0F9B9BHYh1KIplHpnKWzkHjp2/F+kcrRbuQfKFuupZdjicYQM54o/wPxfyZh9N1oriBJp2xSY0eVjRfWArFNaWMtHAa67PukU7tyxfcLahfJhEHXtBHLhz6ryIz0YYMkJkC8hIFcqxAFl81pBFxHfrlVs+0AMeL+URNq6B96KO4NevvEP51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmfZ4SDUA4oFkthjzUWy3zBEbHAEc0AvX7E1l1sa70U=;
 b=D7kd6oN6mDITqUkdssCFrtlWcCDlrh7+bMuzJ7jbOfivN8CJBmOt+QYngMVUv4ClF3vcbET43+k1MKI+MVYJhisoFUV2Qeoou2FwkupJTUyKGCjJ8dJ+j5aOeZmegPT7NaESNYSF84jJKFC6ZDYbv7TVwaUh5V3XiGsfskDg2epkT3bgVUrnTSXPIOaLBj/sUtMUPbd+IBraWWr8JkDPrtfbatQ3S/JBeb/a7mIacOgb92FkSarn+/zFmA/7AetLhImaLVt4i5H3PI9+GqPpUQlHwKNv1R1o8WaVZuYNsQVW7ugb/+/pJAH3fXBdhm+oWkRVg+K6PznTYEiIb9o3hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:42:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 19:42:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 30 Sep 2024 15:42:22 -0400
Subject: [PATCH v2 2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-imx95_lut-v2-2-3b6467ba539a@nxp.com>
References: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
In-Reply-To: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Frank.li@nxp.com, 
 alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca, 
 joro@8bytes.org, l.stach@pengutronix.de, lgirdwood@gmail.com, 
 maz@kernel.org, p.zabel@pengutronix.de, robin.murphy@arm.com, 
 will@kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727725360; l=6499;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/ow1flkLRne6EE1Hp9S1E0GszHPqqrka8qrwUMZ+km8=;
 b=VSHAB168heyaN9gExA3KwUUhlDKS+QsVzhS7sU5Awy37yr2hsoIuZAjXUcsNOsf6MoeyuCeaK
 kMK+jzIySY9CdCwrvBjAaMcMs6nqR62wt7zhlYPGtHXIqVOtT25oYVD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 7864536c-2eb8-46ee-975d-08dce188167e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWpzdkRldXdMTnFIdjBQMHhVeVF5bFM0b0pTSzQ5alVPNkl2bjMxQ2Fnd3Nm?=
 =?utf-8?B?Q3lUWG92KzlucVhjaDhjMmozLzlMZWczSjR2VnI0T09QV29laURjS2dpZzBa?=
 =?utf-8?B?UEpYOHhpTDVYM1ZoRzZ0M1JDdG1ocEk5N2FQN0cyQ1hrNFRSbVQ2dkdBN1A0?=
 =?utf-8?B?MU91V1N0WW1jUXZUTkI0VEQyTTd5WGMvQ0d0aGxYOGU2SDg0bStzb2JsMzNt?=
 =?utf-8?B?QjhjR1Z5KzlwZG1SUFVQRGlHanRUcVdVVUl2WGhUUk1COGovV3F5NHZIOEFp?=
 =?utf-8?B?bFNrcGRvd1JlOW1NT244NnQyTktYOTRpbUVubGZkbnNaR3hETzNNcDdJcGtK?=
 =?utf-8?B?R0pSTU9YUS9NQzJLNjl5Rjd1bzJNaUlRREVVTGtqTFBwVkFlVkpoWEM4dzNj?=
 =?utf-8?B?ai9VVXgyd09NR0Z6eFREWUF3N0Y3cVBoVWo1UmwzakVVUzVqZUNWUlJ4VEp3?=
 =?utf-8?B?bGE5SnZxYUZqMnlKYWYrZlVTanlOWjZoZ3FHSy9YSCthZ2kwNzlJWU4xM1lV?=
 =?utf-8?B?MHl3cm04cWNkZlpBVTBrWkdRaHRWN0xTVDdYWTJ5R2lvNlJhak1LdkdxT09y?=
 =?utf-8?B?QWJGWTB1RGQ5ZWJwclpTMkFnWE1mb2M5Z3l4OVVEaGF2cjRsY0k2eFdaZVd3?=
 =?utf-8?B?Q3ZRb2QxT1FpcTYrY1JMRWY2cE5tVld5UW9MMXZQUm1ETmxObnZHNTQwdDIr?=
 =?utf-8?B?ZFVnODl0dFhDM3hJbUsybjhQdDJBZnFNd2tUenRvRTF4RVRDRGR3LzhRWmZ3?=
 =?utf-8?B?MWhIMGdkZlpidDJORHliVUJxWnh5UENaTUpWbUN4ZEx3VnpOMXZrY1h3R2h4?=
 =?utf-8?B?S3ZXWnAzNklBNklZSDNpZkpWcUthdmJhM1NPREpNdGFKZW5rakR5SU4rMURD?=
 =?utf-8?B?M21Qem1ObWhIVStQYUljclVXa0w0STlvUnU3NmJVQldVbWFhS0hTc3BHWFli?=
 =?utf-8?B?UTFIRno5NFlrb3ZZOFdOMlYycWcxYy9jN0c0aWpMU0lVWHBnK3hpU3FNYTlG?=
 =?utf-8?B?WCtkalU5eHRtODNjRGpUcEV1ZS9FZ0dRaGhmQzVPb2xRZ010MWF6aDFZMHFo?=
 =?utf-8?B?d1RqWkFPSDhBSlRWbmcvTUVST1pZWDZKd2FLY2w3RWZLb3ZoSWZoR2Qzd2sz?=
 =?utf-8?B?R3JJUGE3bFkva2pscVRabGNCd1UwT1R0Z2UyRlZ3WXgyTjE3T3NOeWF5UWZT?=
 =?utf-8?B?eUlOd0Q4M0lDNzhqdnpZTzZJaFgvQVdWTTJpZ0JINVhqRWMzbTBvS3FuM05K?=
 =?utf-8?B?R05HNjlQRzhORHZ0L1ptSUp6dXNwam5KMVpjMjNwdXI0d3doajFLei9HekV5?=
 =?utf-8?B?L2hzZjcvVndHYTJ0bGtDRzlyd0MxdlAvMWpPbkhva0ZzUk5vY1FUU1RwUWwr?=
 =?utf-8?B?R2xQM2ZmZkRlWGZiczVpMlhLVzEzUk05bHBEZ1JYWEFlYldXSW5JMHhBcmZv?=
 =?utf-8?B?azEzRGRNSkVaRFV0ZW1HY0taalFhKysrcUV3WGZOb3RrVi9vcW9kdU5FRit0?=
 =?utf-8?B?NlZUMXRJbkZZM2ZMWTJoMUJ0SmFXRFZIUVhEV2JTTVB4dDlHTk5JWnA3b3Rk?=
 =?utf-8?B?RWkrUFRkT0RKaEFQNTJNc0dMdmlwb2VmdGNaeTNhbUNGSlRsNVpkd01taWRX?=
 =?utf-8?B?MFczUHhCOVVERTVxemVZeXRHMzE0MEpZSjRBZTladHRnZlBYMzlhYXdiQ0ZO?=
 =?utf-8?B?WEZsdlVUVVhUcVRUMkFPazZhK2I0VUtKVWdkWEhqWFo4WUo3RnIvanN4MXRW?=
 =?utf-8?B?dUZVdlAyYnhCdGtkTm9EM2VQOHQvbWV4dkZ4WjY0T0NIdEwyZktTRUg4Sit4?=
 =?utf-8?Q?OfErCAxq1SrVfowg4838h21Qj++YSzq4LZgvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akZYOXFPQnl4aW5IMzNuY043Zkltd1VZNENTOVdoQmZjVGlvc0p0N251NnJC?=
 =?utf-8?B?dW5CVnJ4Z2lRNHpDcVVIeUlERU5JRFdpd25FU0U4bEVKajVrRlpuUjZzZkhu?=
 =?utf-8?B?Nk9vMzZ6T3N1enY1RjJ2cTRUN3o4Q1FzM3FUN2p6bmE2KzYySGpQZnZhQVBV?=
 =?utf-8?B?bXNRMHVISVJ4Wll0eVR3ZWlKdHFuQmE4MWh1a0o4QzIwZ3lWeWVsN05rM1ZP?=
 =?utf-8?B?T2NJYW8wYmZjb2dqSzByY1Nadm1xNVdMOEY2STBPMS9sNWxRemxBK1RKWHlD?=
 =?utf-8?B?VUI4NE10Zm5aTFQ1OHNLc0h3QnZjUldRZGRiV2hSS3V2dGVXQWlQUEtNbGRy?=
 =?utf-8?B?ajJENUV1UkdyaG5FcGlzNUdlZHdKakI3Y1ZzMXMyL0lHQ2lTaStzM1VZWXFp?=
 =?utf-8?B?N09HNFhCMFlsSFdua0dqam1ZcTNESWZwNkJpUFpwbk8xMzh4TC9OM050aGwr?=
 =?utf-8?B?WlpqVndNKytjSTNXU0w2aGZlelE4TXdldnVIdnZPbWE5bS8zUHI2bTU3eHMr?=
 =?utf-8?B?anR2bG5CalYxVllFY05lNFh4Vmg4Y3B1NWhFKzR6Wk1CbE9xeCtwZmZjSTdY?=
 =?utf-8?B?dElsNFZPSXZ2aGMyMnhhRjYvRUxiOXpyNW90RVUwQlNIay9KcnpMMTNBZ0VS?=
 =?utf-8?B?ZVI2anRNc1g2RFlsYmJ0N28yWGxiVms1TXRYRG41cUk5WVVTRHB6TmZaOStk?=
 =?utf-8?B?VDdmc1RUWHNyN21hRUZ4YTBqbXBhY2ViWjBMbkk1WkFTQ1FaUGFUZ0YwekZn?=
 =?utf-8?B?YVJkSFJLVk9MWGgrM2YvNUhEM2xtOVl2bU9ZWVE1SGoxZjVzcGtBY1ZHenhK?=
 =?utf-8?B?VUNRRmc5bzF5Y3BtWFo5TnJJQ3JBRE1melFLQXdCdzA3WXhLL3lkZTQvT1NR?=
 =?utf-8?B?ZVR3dW5Hc0ZJbDFpUUpNTjZxWFk3UFpvOU1ONjlqU29tU096MWtUVXB1aFJx?=
 =?utf-8?B?V2JHZytTdDV5REZtbW9vdG5jVWZoT0JOZ0VzVUswL0NmMW51SkdrMXVlSElk?=
 =?utf-8?B?Q1RMNVhVL1ZZd0NuVksvaFdWa0VuRkdpbEZya1NZVnkrdlAxUEw4d2FvbmVv?=
 =?utf-8?B?bzlYL2dWYmVXYWdiK0VYQU9vb3lDcVVUR3ZRdFV5bGM0TlpYUGp6dWp2bGtm?=
 =?utf-8?B?TWlIMnVQZ1dmeE5DSnpNYUcvdjNrdk5BRnI2c3FLcVVJaGZleCt1MU9mQVgx?=
 =?utf-8?B?djJlcm9JN2Y5ZXNLdU9zWk9DV2UzVGRZeUp2NFFONFY0U05mWFRFQmRzM24z?=
 =?utf-8?B?bWlxUGZOZFdnQ2ZYeUxOOEorTDV1Ti9kNlNKM25Wb1pIOVpXdWhuSDQ5ZlNp?=
 =?utf-8?B?TzFjckZycytWVVpSbU5hQTNDRGFodWozM1NQUG8yMW5LTktkTjBoYUpCeHky?=
 =?utf-8?B?TjJLZUhtR21FOHR0NGkzRVdJNjcyR0xyUlo3cS9TcW5DQ010bmpHTHQ5NzJN?=
 =?utf-8?B?NXg5THIyOWZIZEM1dmZOck4ydjBkSmFGM3RxVlUzZGZWTHlKaGdyYkF1bDlt?=
 =?utf-8?B?QU9KNDhJOWJYdnNxZUQ3bkh1WGhBdGE4TXZQc3d3NmZwMnFqWkVZelQrSjNw?=
 =?utf-8?B?bGhjT2lvOVFRUkFMbWFXTFl0VlBIUmo3aFd5KzhXdnBWNkgwZ1RlNEJFVXUy?=
 =?utf-8?B?OWIvVmg2V3djMlhwbzkxSm50am1nWTEzbElaVkVCUVJQVWVpVytlQkd0M2ZE?=
 =?utf-8?B?N2tsQkhsUyttUXRMR2ErT09RRW8rcW80eVVUd1N6UEEydGlkNFMwVUhBMXFQ?=
 =?utf-8?B?ZXVNS3hXYXlobWFvbTh6cXppV0tqa3lPYlVJdk5YMlh0TE1PTVBaTzRESTIv?=
 =?utf-8?B?OVNVR09xU2IrUzFhWHlqbUxySCtFWFBDRjd4MFZhaFR6WnFIQnlvVXNjL0R2?=
 =?utf-8?B?aFprL2Fxam9qNGQrMEFwRnYvMXVoRVJ5enFoS2RldXNkSUhSSlBubDZTUHE3?=
 =?utf-8?B?TkJib05RZ202dUI0NzUxTGNLZXduQkpjZkVKSElHYzdtS05nbFhYcnQ4aDRY?=
 =?utf-8?B?NDVJYzkwZXZkMEkvNEZFSENHREQyVHpnZXZzVnNJNmdxSnIrL2ZYUnd6NDJq?=
 =?utf-8?B?TlEwVy93MnZIYk1FSDAwRUNwUHQvc2lnT0l1N09RUVlTelgyOFQ1UG9FLy9E?=
 =?utf-8?Q?BTRM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7864536c-2eb8-46ee-975d-08dce188167e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:42:58.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5j4MJN7KwPstC6C6ZeBBrC8jqf34aKs3w7N4xfCaDobkBOpgfNgZjZmpdP8aT1L69He4E8CvU3LcUDpaOxY/9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves examining the msi-map and smmu-map to ensure consistent
mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
registers are configured. In the absence of an msi-map, the built-in MSI
controller is utilized as a fallback.

Additionally, register a PCI bus callback function enable_device() and
disable_device() to config LUT when enable a new PCI device.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- set callback to pci_host_bridge instead pci->ops.
---
 drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 94f3411352bf0..29186058ba256 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -55,6 +55,22 @@
 #define IMX95_PE0_GEN_CTRL_3			0x1058
 #define IMX95_PCIE_LTSSM_EN			BIT(0)
 
+#define IMX95_PE0_LUT_ACSCTRL			0x1008
+#define IMX95_PEO_LUT_RWA			BIT(16)
+#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
+
+#define IMX95_PE0_LUT_DATA1			0x100c
+#define IMX95_PE0_LUT_VLD			BIT(31)
+#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
+#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
+
+#define IMX95_PE0_LUT_DATA2			0x1010
+#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
+#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
+
+#define IMX95_SID_MASK				GENMASK(5, 0)
+#define IMX95_MAX_LUT				32
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -82,6 +98,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_HAS_LUT			BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -134,6 +151,7 @@ struct imx_pcie {
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
+	struct mutex		lock;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -925,6 +943,111 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
 	imx_pcie_ltssm_disable(dev);
 }
 
+static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+	int i;
+
+	if (sid >= 64) {
+		dev_err(dev, "Invalid SID for index %d\n", sid);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+		if (data1 & IMX95_PE0_LUT_VLD)
+			continue;
+
+		data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+		data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+		data1 |= IMX95_PE0_LUT_VLD;
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+		data2 = 0xffff;
+		data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+
+		return 0;
+	}
+
+	dev_err(dev, "All lut already used\n");
+	return -EINVAL;
+}
+
+static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 reqid)
+{
+	u32 data2 = 0;
+	int i;
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == reqid) {
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+		}
+	}
+}
+
+static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
+	struct imx_pcie *imx_pcie;
+	struct device *dev;
+	int err;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+	dev = imx_pcie->pci->dev;
+
+	err = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", NULL, &sid_i);
+	if (err)
+		return err;
+
+	err = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", NULL, &sid_m);
+	if (err)
+		return err;
+
+	if (sid_i != rid && sid_m != rid)
+		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
+			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
+			return -EINVAL;
+		}
+
+	/* if iommu-map is not existed then use msi-map's stream id*/
+	if (sid_i == rid)
+		sid_i = sid_m;
+
+	sid_i &= IMX95_SID_MASK;
+
+	if (sid_i != rid)
+		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
+
+	/* Use dwc built-in MSI controller */
+	return 0;
+}
+
+static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -941,6 +1064,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->enable_device = imx_pcie_enable_device;
+		pp->bridge->disable_device = imx_pcie_disable_device;
+	}
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1292,6 +1420,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1587,7 +1717,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX_PCIE_FLAG_HAS_SERDES,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_HAS_LUT,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,

-- 
2.34.1


