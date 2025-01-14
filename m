Return-Path: <bpf+bounces-48852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B30A11232
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 21:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4F91698FE
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0620F096;
	Tue, 14 Jan 2025 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dUJLRRa4"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38920F071;
	Tue, 14 Jan 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887066; cv=fail; b=EpezfS8IJwSfEAIEXm0Fx/KFuFbtGweDCjQuZVJWC9JrPD6EMAy1Qb6R1BH1BcTh7p1uo0Eh9Ptx9OBfazMbJKxUDqqtD34v8oS706CfNngfaEeUubDE5hOYU7QwNUJ8MoPWA8nPSz2VlwGKL4zRtJdLHaCW1JwX6V/QpEUTN5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887066; c=relaxed/simple;
	bh=RQX2/sgMFQZpgSFRGn7Mr1SVILSMirf9nBRzmg2vfMg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uvJj6aP2+56AZNAngy2IORD854pfHM+J6lIApkYaWP/qi8p8rCBfRjQXFKFJyk+bWKQ/20rD2sXOZuKdniUTuz7Jkl72cX1cWeNxZ+4lceynStYaTMNQ6x9LH3kpZLfpBXpAj/IJRUiOw6pCoMGlD0w0CMRx0YkTEAV6TOD8zFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dUJLRRa4; arc=fail smtp.client-ip=40.107.104.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+xUg1XLUVYNWCT0eyLciqRCGyO6byLcSTnMiyuE8c+fi8nZOoXFjsPjRNDrC0WtH2ifVRvYYzzAvrj6NBKwN24ww+3NIUWwmtsy1D7DEoj6DzhEuRDZTTq8cRZ8qxKPdHjOia6EdlUBrftAdQb6l6WrurB3lbxv8U8BYKGSJOS20NCtTYaXOc7O20jSL2+h9jnEf5Vn9H8qqeWwds1wHW6W3oGsyzi1Nv67E5v41VzQTrGjywYSwycSOyGZKLS5Ja0VRy4bOxz3AGhPmoQxAaBbm/bPGQUuVTUOq3IVYxVpliNLeSrvd/57x8CsFfgiwM6oyxgCyRQPkw07VJi8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIYnl0QMss/E9dnZTRNT1diPgdnd40NFqD7KFzCG44U=;
 b=VEdDKZJMOauir+swUQdOzUZG24E8I614w9Mi9NCUTskRmZ0GnE6QsT0P6y/6IFreTYMIEy5HiJt4rOiTgzmO5IyHQzPmNw1AwHFiKuUFr1zSbPBiOxnoNcEKLP/kAYD5z0V7FRBxkF8T6d34jKdFnJPCwcoUuBM8np+NMToBT7qRuu/MqvenQ0tSDslc64qHNQhuLD7pGVp/F4kA0qhf1E6Z2emLc4pE/TJqpFzjj/F6d0hFbwx1w/8cGFPshBz50dMzkdke5KqCPqpBXn94HxiuZpye67BvjKQvDbKDGkZa4lydGuyFzDi7AUiOHQPA/DthojamPS+GDTz2VbiAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIYnl0QMss/E9dnZTRNT1diPgdnd40NFqD7KFzCG44U=;
 b=dUJLRRa4mA3Hf3IPq/CoXdKLyeeNxey6X6ZYnyprWYfBqXZoefyHEc8xrneUW3lDD7OBzFBvtug9XV3Xajjw/3vCafzp+2PFNXL+3vC0UWrjMa3eDwr39UvsUacfe10TWinBIn/M331Xrlg92iJoHkvXA6v4yl3CigVX6WnHeqEVqPmJpw1nEtwfA95Arw8Zwdqc8vuxQR6ZoSYpJ9isM2OecAW9GOeM2+ycu7v+XqYPQ7TUwfXkn1kg5bi7XQERO3HpChVLFMuu/4SDh3RaGBGX7v8Tv9Uk8K4soqLwJFF38kzstIuSl8dIhcg3QCTUW5vlcJ1HSMBinspFevzNxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10374.eurprd04.prod.outlook.com (2603:10a6:102:41e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 20:37:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 20:37:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Jan 2025 15:37:09 -0500
Subject: [PATCH v9 2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-imx95_lut-v9-2-39f58dbed03a@nxp.com>
References: <20250114-imx95_lut-v9-0-39f58dbed03a@nxp.com>
In-Reply-To: <20250114-imx95_lut-v9-0-39f58dbed03a@nxp.com>
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
 will@kernel.org, Robin Murphy <robin.murphy@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736887043; l=10863;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RQX2/sgMFQZpgSFRGn7Mr1SVILSMirf9nBRzmg2vfMg=;
 b=M8MUuP9CBJD2joro+ohSQe09zb8ZqAEuJgLtzOotlh7fA2HwZrWozDXeN5TuGzfHVC9DJN4rv
 UxSkLl8WP70CXA+5+39Fij2puzdGur4EzTXXAH1mlao4hKqLIqgfHJW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10374:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b5e9c5-d6cd-4713-ac56-08dd34db4afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDVDQ0hJKzZVRzRzcmttL3l0YUNSbVpJbW5SMTE5UXAxcWZ5R2ZoamVuUFZl?=
 =?utf-8?B?Sitpd2JvYVFZeitoZ2VXblMvbmltd21laGYrVlM5VHNPVjFDaVRSNjYzc2hm?=
 =?utf-8?B?SmZvYllxeDBUTng4UUxsT3pYTFg0WDhsMXNhZERPVXlOWjI3a2FSWVpEVGti?=
 =?utf-8?B?TS92c2Z0RVJZVnhIQWo0TDQ5NmNEYi9HaktLcDlxLy9XcDYzK3ZtM2tuYXNa?=
 =?utf-8?B?L3huNEhFbHluQnhleUFRcXBENFFYU0cxbnE2NlljZXJUOFNXczc1ZGVvNmxT?=
 =?utf-8?B?Q0gwaGl2OE5OaDlWTGV0RDV5YU53bENPZzhjakxoS01ya1ZSVjcvVHI5Q2tz?=
 =?utf-8?B?aGhkNzkyRnNJMVgxNFhlR0JhK3pVMXE0Zk9Jd1hlYW5FUnczemxLTG5LQUpl?=
 =?utf-8?B?Wkh2Sld5WDdzVm0wVldSeGcwcUFqZCtMSUdLSzJPK1lqTmZiVzMvcWdiVWhF?=
 =?utf-8?B?M0ZTTEs3WmpaWGFWWEdYN3BEM2hVcDBLRTU2ZVh3N3VYYktSY2ZqQzNtM21Q?=
 =?utf-8?B?aHBhVVpVNkpTbkhOdll6dGRYU0F1ck5XNHJRRmpSSzJFazZybklGb210Mk1R?=
 =?utf-8?B?SXUvdjFFNGw0NlNzeE54ZVdwNGpjWEpxYXc1Y3A1TmI2cDYwMVplZ0gycmls?=
 =?utf-8?B?QXhOL2FRUExUaXl2eFM1T3NxRUlWYk5HdUx2ZytjdVNPOGE5T0hkMGdjcTIz?=
 =?utf-8?B?VjFqWDlQMzhwLyt4NjF1Umw2enV2SWJDV2ZyNWJ3cjlBK3ptTTkrY0lxTTJz?=
 =?utf-8?B?RlNuNVNrZ0JOL1V5QXhUUDdIN2wvREpWR2VoZVZFWUhYc3VYRXRnQ0pSNTNx?=
 =?utf-8?B?OCs2eCtEdVkrYjhuK0JGOW8xNUtqc1Q0dmoxWldZazVxWTFDTEhnUHp5OGQ2?=
 =?utf-8?B?VFRISmJJaEs0R0Z0NGNqbEVNTjVxVU9jbUdscUJFZldXcHN5ZzZtSHhVVTFV?=
 =?utf-8?B?bDBFYmlCR1g2clc5ZE42Q01qU0NPdDNncHhDQUFOVEJ5bUpMeFhjcGVMeGdB?=
 =?utf-8?B?WjM1WGh6eVUwUmRDdXlydUlWVXlzeVFhWkFYWmwvQmUzS2hTdjltaHBYcWFt?=
 =?utf-8?B?T1JLUy9kelJwZDZWSXdNRFhPTXBSYjNmTEZXRm1SaVFqY0VwUkRWL2ZtYmkz?=
 =?utf-8?B?bXdZQWl2OXZUSWFEM0lWQ0RZemU5c2JValpFNi9xTWtFdmRaeEVWa0w0SWJr?=
 =?utf-8?B?WHhoa3pia1hXdytLNzl1ZURCWUhBR0VmTGlidVZhSitVNE9PaThZZjUwM0Q1?=
 =?utf-8?B?WjBJeE81N0syYjY4OFFkajU0YWFBeVd4WXlRUE1hOVpySG9mRk0vYVJLNTVS?=
 =?utf-8?B?Mzk4bmFGbURPMmJpZ25zNDZsSDJIQzJrcFdUbkNabkVHcC93Q2FWM0VneG5K?=
 =?utf-8?B?OXE3MThZVjVUSElBdCtYL2czclplMnB0WmYrS1VsUytrUjNVTVdNWkNlNGtp?=
 =?utf-8?B?bjJrRS9td2NFM2VMdWJjVVZjQldEY2pYMW9PRndteW5aTkQwb3c0bm9QTnpp?=
 =?utf-8?B?Z1VTN1JpMVZKMXZha3dvWnNlcnJhS29OWHJqWlVaUlByTUtGRFZNbXlrcm1l?=
 =?utf-8?B?QmZnQ1l6WTBpdzdpYWdEWUVSMG1xcTYzQ0MvYnRBb2RKa2lwRG1KSXZYTGY5?=
 =?utf-8?B?QXBmM1UvU2ova3ZUNWNTWTllRDdHbExhOENJWkRTdmdIakplWXNNQUs1VWVI?=
 =?utf-8?B?N2Z4WTNYMGFkc1pTUUlpenRkdm8xU1FSb2xiYVJnUVZrZ3FmZ1cyTlBJcXF6?=
 =?utf-8?B?NFFiblJkVW1QTXJVRFZLYXBKcGJpNVFabVVUWFc2eFdNRzNZUlllNGZrMWVT?=
 =?utf-8?B?em5rRnJOUXN0WW5hcWdtRVZPb0NlaDZxakdPQmNSR3Y5bDZMZjZDZGJZTlFr?=
 =?utf-8?B?ejE3OWRHcVVXWm5icU8rVmNYM2R6M3ZwblJ1eFRlWktRUThqemU5TkF0WEZQ?=
 =?utf-8?B?Y3VyV1V6RUF2alNuQmpXZWJTdjBsaFdjOVVkVUNmSmJXSjVTMUtPZytyWkZ2?=
 =?utf-8?B?NkYycDFWZGlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnY2VHpxM0dwZ1Q4M1E0RmlXMDhDUzl3Z1NoelFoWHFDREVMZlpKRG1vRm9U?=
 =?utf-8?B?WDMvZi85TTdCWWhueFFYRGFhOUplWU0wUlBJSGxTSHViZDhqWjdlZVhoOG5x?=
 =?utf-8?B?Rk5WVzNVOERYcENCT0swS01oM2ZiSGE0cGxlTW92QURWM1Z6ZFJNc2xMTFpj?=
 =?utf-8?B?eE9sWHZLdHZpRFhzaUJ0ampTRTlaR2JlQ1BkckwvbDI0ZEVYMlFSSjcyYWRr?=
 =?utf-8?B?cHZuWExEbHdPZGQrc0ZQQUVnU2x0UmhwR1F0T0VXbEZZUDRLQVFqQ2JBZGVn?=
 =?utf-8?B?R29FZDFGS1pkUTdYRXlIZklya1IvVmp5RXF2dkNDS1JUelNrV09wTGhuMjEr?=
 =?utf-8?B?K0NhaDVWWHlLeEVEaysyTUU2d3FGdkxKbHBrd3M4N3pheHU1SjN5VlBvbUYw?=
 =?utf-8?B?L3FOOUgzaDBtRUJtU1FNdDRkZG16MDJhU0dGMVo3NHBNNVhsWlFYZzV0LytN?=
 =?utf-8?B?ZmdaWEhPK3lIT0VqSU1rSVI2Rk4yMWVqRnNhb2Z1dEJGTTN0RWZBVE51dUg5?=
 =?utf-8?B?R1ZEUUFLWGxrUjRRZ29MRTUydHlSRG1mYXhEMUtabXYrUlJ5cGRBd3pQemNN?=
 =?utf-8?B?U3ZUR25CSjgwSS84ZW9kcHVqQWlubEViczFnSmU3UFVGWEtYQkNOcVl4WVJD?=
 =?utf-8?B?eE5Bc1kxc1E2akp6Z2ZkWHZTa2hNZ01yQ0Q5VWRLRkZWOTRLcTFpZTlMVndQ?=
 =?utf-8?B?M05oa3A0TmU3bWxheEV1YnlMMGpPbFBEZFlwN1p5SEUzRE5kZHlCS000RkR1?=
 =?utf-8?B?RlQ5VmY4UVhSUXVIWTJYWTlqcy9NQzdBRSt6QVh1MGgwUWZudWY3R3I3eGJW?=
 =?utf-8?B?ak1UeVdZTG9ZNkJzSGZ1MzdibDVqUitseENSRGZLeDNiTmw2ekNCV1ZZd294?=
 =?utf-8?B?MDhlcWVUaExzVy9HbVZBVzZHLysra2dzblk4YlF6c3lCdW04RnYrdzZKaHBJ?=
 =?utf-8?B?cE5iVzMrTk9yb0R0ZnRCZk1XQUlja3JiL0JDdzIyLythaTZxMmgyU1RTellL?=
 =?utf-8?B?em1yUUM1S0ZzbDhDc1dqS29FNEZnc2Z6cDFWTUJNNkN6SXh5dXhpSldMZ1M1?=
 =?utf-8?B?RFdwdHV6dXJCWUJaNVdWbk5DMnBNditOaitUQ1EzOUh3ZHMvTUVGYVBOVXNC?=
 =?utf-8?B?aXJYWm04SUprZFk0SjNvbDc4WDlJWlcyY0lRMlRXZEcvekhneVphYXlPL3NM?=
 =?utf-8?B?aDV1U2dzL0NqKzdCZWNhd3ZMUGpYQ2wvdkd2T0pSS0ZqTWdmelhENU1VbHcr?=
 =?utf-8?B?bUNEVjN6NG1vVDRQOXZ2TUZVSENlMWZ3eGNkamg1R3FqOUxYSUxkM1RBK2N4?=
 =?utf-8?B?VDJEaC9xbnRUaGZ5aTBVNzF2emRnSE1TeS9jMzZ5QjRKVVgxR2YrY3JWUUpx?=
 =?utf-8?B?YWZDTEpOS3RPUUt4MEtXMmUvdXBMcTZ1MmpRY0NYWU5XZlRtYzB5NjNoMHZG?=
 =?utf-8?B?TUpmUkhzcyt4RDhBSm42aVM3QW5sMDBCVEUwZWNtVytkNGJlczdnbVBSNnFD?=
 =?utf-8?B?a0RMUWxTMDFiUVRiaG1NL25zL2dvMUcybUlBZDJpck9EcWx4R1JWMUlaT2ha?=
 =?utf-8?B?dngwY1lSOXMvcFVRdE84RTJ4U1pVUzM5Q3ZJQ0l0Wk9TMjVaeFM5dlVCVi9s?=
 =?utf-8?B?RkdZR3gzZTV4TWN6R3dYZERMVmVQcmM4WHFQMGp2NzBxV2E1SnBHcUdLMEc3?=
 =?utf-8?B?cEJyaG85VW1QQ0pSMTFacG44QlhuWnI0bVMrWWFyRGxOUkp1c3phem1UNWhG?=
 =?utf-8?B?cys1OHNRNkcyYjh5MjhXditoSHh5M0tpZFBkTmlKdG1LNXlKT1Y1b3pMYkxr?=
 =?utf-8?B?QWtwaUlMbVU3VjBhaHUvMHd2VUYzNG4xd05nM1JIblJuYk80OHdHc3ZPUFpU?=
 =?utf-8?B?R2MyYmsyb0JrMW1MUUFaZUg2eVJlZkdqdVk0cHg2T1NzeTAyaDI1dnZaSzVN?=
 =?utf-8?B?d3Z0N1daK0hwRUtXRnpuQnRWY0xna0twTjBvMWlUSE1MMEk0bFV5MWxFYVFp?=
 =?utf-8?B?UnlPU213UDQ3WnErNjZCTGFVMXpXbS9MRGtpMlp2WmRtVGRGMmRQd2dwWStt?=
 =?utf-8?B?amVZeWVIOU5CRlo5N1A0R2NqUEc0R1ZzWGJyOUcyeGVNb0U0TGpvaVd5cXpw?=
 =?utf-8?Q?Bi5HU3IIolI0QfbZYoED8jqz9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b5e9c5-d6cd-4713-ac56-08dd34db4afa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 20:37:41.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFMKCUzBRKp1urAHD6mGTi6m71Uw+IvLT3xUgdanQYhNFWgajAWZ1A2axHXrZPhbqTNPEMEdLn280eACTBmDQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10374

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves checking msi-map and iommu-map device tree properties to
ensure consistent mapping of PCI BDF to the same stream IDs. Subsequently,
LUT-related registers are configured. If an msi-map isn't detected,
platform relies on DWC built-in controller for MSIs that does not need
streamdIDs.

Register a PCI bus callback function to handle enable_device() and
disable_device() operations, setting up the LUT whenever a new PCI device
is enabled.

Known limitations:
- If iommu-map exists in the device tree but the IOMMU controller is
  disabled, stream IDs are programmed into the LUT. However, if an RID is
  out of range of the iommu-map, enabling the PCI device fails, although
  the PCI device can work without the IOMMU.
- If msi-map exists in the device tree but the MSI controller is disabled,
  MSIs will not work. The DWC driver skips initializing the built-in MSI
  controller, falling back to legacy PCI INTx only.

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v8 to v9
- update commit message.
  Rob agree parse msi-map and iommu-map by existed of APIs.
  https://lore.kernel.org/imx/20250113225905.GA3325507-robh@kernel.org/
- update comments to make logic clear
- use
	if (!err_i)
	else if (!err_m)

Change from v7 to v8
- update comment message according to Lorenzo Pieralisi's suggestion.
- rework err target table
- improve err==0 && target ==NULL description, use 1:1 map RID to
stream ID.
- invalidate case -> unexisted case, never happen
- sid_i will not do mask, add comments said only MSI glue layer add
controller id.
- rework iommu map and msi map return value check logic according to
Lorenzo Pieralisi's suggestion

Change from v5 to v7
- change comment rid to RID
- some mini change according to mani's feedback

Change from v4 to v5
- rework commt message
- add comment for mutex
- s/reqid/rid/
- keep only one loop when enable lut
- add warning when try to add duplicate rid
- Replace hardcode 0xffff with IMX95_PE0_LUT_MASK
- Fix some error message

Change from v3 to v4
- Check target value at of_map_id().
- of_node_put() for target.
- add case for msi-map exist, but rid entry is not exist.

Change from v2 to v3
- Use the "target" argument of of_map_id()
- Check if rid already in lut table when enable device

change from v1 to v2
- set callback to pci_host_bridge instead pci->ops.
---
 drivers/pci/controller/dwc/pci-imx6.c | 199 +++++++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c8d5c90aa4d45..bc3f8471d65ab 100644
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
@@ -87,6 +103,7 @@ enum imx_pcie_variants {
  * workaround suspend resume on some devices which are affected by this errata.
  */
 #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
+#define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -139,6 +156,9 @@ struct imx_pcie {
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
+
+	/* Ensure that only one device's LUT is configured at any given time */
+	struct mutex		lock;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -930,6 +950,175 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
 	imx_pcie_ltssm_disable(dev);
 }
 
+static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+	int free = -1;
+	int i;
+
+	if (sid >= 64) {
+		dev_err(dev, "Invalid SID for index %d\n", sid);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&imx_pcie->lock);
+
+	/*
+	 * Iterate through all LUT entries to check for duplicate RID and
+	 * identify the first available entry. Configure this available entry
+	 * immediately after verification to avoid rescanning it.
+	 */
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+
+		if (!(data1 & IMX95_PE0_LUT_VLD)) {
+			if (free < 0)
+				free = i;
+			continue;
+		}
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+
+		/* Do not add duplicate RID */
+		if (rid == FIELD_GET(IMX95_PE0_LUT_REQID, data2)) {
+			dev_warn(dev, "Existing LUT entry available for RID (%d)", rid);
+			return 0;
+		}
+	}
+
+	if (free < 0) {
+		dev_err(dev, "LUT entry is not available\n");
+		return -ENOSPC;
+	}
+
+	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+	data1 |= IMX95_PE0_LUT_VLD;
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
+	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, free);
+
+	return 0;
+}
+
+static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
+{
+	u32 data2;
+	int i;
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == rid) {
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+
+			break;
+		}
+	}
+}
+
+static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
+	struct device_node *target;
+	struct device *dev;
+	int err_i, err_m;
+	u32 sid;
+
+	dev = imx_pcie->pci->dev;
+
+	target = NULL;
+	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
+	if (target) {
+		of_node_put(target);
+	} else {
+		/*
+		 * "target == NULL && err_i == 0" means RID out of map range.
+		 * Use 1:1 map RID to stream ID. Hardware can't support this
+		 * because stream ID only 6 bits
+		 */
+		err_i = -EINVAL;
+	}
+
+	target = NULL;
+	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
+
+	/*
+	 *   err_m      target
+	 *	0	NULL		RID out of range. Use 1:1 map RID to
+	 *				stream ID, Current hardware can't
+	 *				support it, so return -EINVAL.
+	 *      != 0    NULL		msi-map does not exist, use built-in MSI.
+	 *	0	!= NULL		Get correct streamID from RID.
+	 *	!= 0	!= NULL		Invalid combination.
+	 */
+	if (!err_m && !target)
+		return -EINVAL;
+	else if (target)
+		of_node_put(target); /* Find stream ID map entry for RID in msi-map */
+
+	/*
+	 * msi-map        iommu-map
+	 *   N                N            DWC MSI Ctrl
+	 *   Y                Y            ITS + SMMU, require the same sid
+	 *   Y                N            ITS
+	 *   N                Y            DWC MSI Ctrl + SMMU
+	 */
+	if (err_i && err_m)
+		return 0;
+
+	if (!err_i && !err_m) {
+		/*
+		 *	    Glue Layer
+		 *          <==========>
+		 * ┌─────┐                  ┌──────────┐
+		 * │ LUT │ 6bit stream ID   │          │
+		 * │     │─────────────────►│  MSI     │
+		 * └─────┘    2bit ctrl ID  │          │
+		 *             ┌───────────►│          │
+		 *  (i.MX95)   │            │          │
+		 *  00 PCIe0   │            │          │
+		 *  01 ENETC   │            │          │
+		 *  10 PCIe1   │            │          │
+		 *             │            └──────────┘
+		 * MSI glue layer auto add 2 bits controller ID ahead of stream
+		 * ID, so mask this 2bits to get stream ID. And IOMMU glue
+		 * layer doesn't do that.
+		 */
+		if (sid_i != (sid_m & IMX95_SID_MASK)) {
+			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
+			return -EINVAL;
+		}
+	}
+
+	if (!err_i)
+		sid = sid_i;
+	else if (!err_m)
+		sid = sid_m & IMX95_SID_MASK;
+
+	return imx_pcie_add_lut(imx_pcie, rid, sid);
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
@@ -946,6 +1135,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->enable_device = imx_pcie_enable_device;
+		pp->bridge->disable_device = imx_pcie_disable_device;
+	}
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1330,6 +1524,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1627,7 +1823,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
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


