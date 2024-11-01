Return-Path: <bpf+bounces-43790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D0E9B99D2
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 22:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1136F283002
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4D1E5729;
	Fri,  1 Nov 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AzWYrHVP"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2B1E2846;
	Fri,  1 Nov 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495109; cv=fail; b=fONJ73RFmje/jatCTKX7fTouEVL8XQMFKqqF9qjmB2JtB1pEVqCB0Gr8bb7KeatNxYlu9kLpFwMIi8LPc5ogZPSNTXrxFXHOsRDPFk7SoA6bDJjwWqtkSYrfRjYUP0McGLIbCAedj7h62mfOUQWjfM0+cCiBkrt4s/FOIrSZ5f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495109; c=relaxed/simple;
	bh=rJIqxvluRC/yMOR5R9EHOlh7W/U5VF9REJtvm0zbl1o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=E00D28qCFAZKf9GEed9feL/RnefoE19fHZT6sCNaynMvQXtHHw3qO5pZLRfijNUPyoviGAKOx8ShonR6JRAKjmDau/mWE3aSSwDKqtk+eoWYpD9DifGVHlAQlMUwZSmCKL2Z0lSF5onTvMOCTR28+6k6QDCCTJ5eS9hAEufY3ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AzWYrHVP; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpsN5UwMQVpd2auImlR5HpYcdkS89MdoEuFLjK8E/2RF24ozhf4deZM5uYRPsvWdFIVgUD0493qokCcEW8Q4Mv2mgi4yFENp9HHsXFhgHOr2T/aBunJLPSqZ2We6+afXYsno7oxbLbmmkdQ6M0NVnOXxPL+0hzaq9S4O5q6chk6ALmI3+UtjIJhJNfVM5Nmx2s05tjpe3CtMm9IZyAZWEr8voXOOQ5qhE4efTEUrRp+yhUY1hy/gF87McxRFbGPmcQa1El9Wd1sC5NNW+kq0oIEOktT1dqSLOlfur9yj0dLUGgPQYRktUGghS1AUkXGoeCKfYW6u4nGSj2ugm/SISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgZfvPdpXTDMFhwi/+fS6tJCSsYlh0cHbpKlPxzHmSU=;
 b=Z/PRm1Zt7f4VwjbH62PcQJuoOXOFKvvT/guMOJkgAZaP9LNXzebiVqPxvWh2T1aC+OdTwX8sheOqrdMiCehiExm+xv5vSffykhQ0EaamdxQYa4yXDA5Fh4rxV01vGm9XoLN5o5lnXlXz0Gytwk2xes35w3mP1D2T9v9yLUnT3rlSIWYceSN+VyruaTqensOq17DDF+xQvCIAF4pJSnSOWe1sNBsY5+eaH8/x8GgfcO3MtayzKVDS1eUhkPxXaBoI54OyTRq6gdf5C/l7qExAllmNez/zKgt8fNMp4nOx58fdC0DMlpeDj/kSMk8ygCGnFJh8htOF4KSEgNjOGObHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgZfvPdpXTDMFhwi/+fS6tJCSsYlh0cHbpKlPxzHmSU=;
 b=AzWYrHVPO9jwo+DEMwHsJT6JGOgtWgoGtM5Wx+T/12Ccpp9Pxvqty3Gtyd1IVlFRpVUPTbdjMwT2FQkgWI9SbmqMKfDJIFPWX5K7/4oIWkvUl9nT8iRVn09JQ7ibs2KjHLSr8zd5nj1pT57C37j4LfCib/dcdGkiWoMavHn4Egy+i5lUdSIPy8NP2Xfqz7H860kcXayxrzXCSj8stkASKZkecegNtxzWGLBHyzRnCwMhWwcnI1w5e4X8PLaWZTNe8ClfS02COEiz2DhkxJVJ1mxndZB8CvU9/t1jemnDOW54bzTPYOn686e2ZoAAjcAWA2LOrkqD6FGjb4swHPivtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10502.eurprd04.prod.outlook.com (2603:10a6:102:44f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Fri, 1 Nov
 2024 21:05:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 21:05:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 01 Nov 2024 17:04:39 -0400
Subject: [PATCH v4 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-imx95_lut-v4-1-0fdf9a2fe754@nxp.com>
References: <20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com>
In-Reply-To: <20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730495090; l=3777;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rJIqxvluRC/yMOR5R9EHOlh7W/U5VF9REJtvm0zbl1o=;
 b=pmY+M7aJ3wCP5C5dh8LDONwupDZUwfyckIugCkGGv6I/UrbabCgqsTxrlxV//qW3N7sqPIpOa
 pSbqeXRj7cfCm0AKXcyRewJeUFbp1iHuhqZTB52oA1r4CaoezDIBVP7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10502:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ca22a4-4fa8-41bb-c1de-08dcfab8da5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjhqZndwaWJqQm5vcVdqeUZwUmJZNUlENFRrRmdqNklWSWFQWFVONUxPdnRN?=
 =?utf-8?B?cjliejl2VXIyZWZiMy9zZnlJbFhNQnpwQmJkSGtyY0lZUGI3MHpGV2pYek9U?=
 =?utf-8?B?aG9EYWdiZkVSdmJ2ajl4a3hCaVdnSVFKTWN5amR5c2szU2JweE1pcmxHajFC?=
 =?utf-8?B?QjJhb3BHcnRqUTVBQ2FVak9rZFp2K3hDdHc3UjVlWExLell6MXlwMmRkRHha?=
 =?utf-8?B?Sk02ZUVrL1VSbjdxdlhmZXZMZkw0WmxoQnVtUzZNUmNJQml3MzRTcklhSmdQ?=
 =?utf-8?B?TFpiYzZjMjY4OHF2cFVxUDVvS054S2RvYjJTOEFldVF0MzE5eEJ0M2lJdXJO?=
 =?utf-8?B?KzlMQWw3NktkVU1LRURPTmUwZTJtY1JCMEtQV203SW80YUgzelpMb2x5TlJY?=
 =?utf-8?B?b09IdGJlaThIMmJrV2swTW5pRVRMMDNPY0R5NXNvRzNLaTNhTXNIUGQyV0xH?=
 =?utf-8?B?U28xdkF1aDRYd0RPZTI3RzlrWmRuZHNGZ0Y4OERnaUtkOWxyN2UzdTJNMDFW?=
 =?utf-8?B?NTZpNjFvemRXeHNISEtBaHZWdHBxUkppTzBWZWpaMG1iODdkbnB1UHN5T2Rn?=
 =?utf-8?B?RkdocG40R3hob2hXSG5zSTByTFl3ZEtHM1RLN2dQbVlDcE1Lajl2OUtYRDN1?=
 =?utf-8?B?QW5ZbFhpam9idWk4VjB1SGxkL0w0WHJiYlVXVTRwRndEd0dqYmRmK1psZnZG?=
 =?utf-8?B?L0F3WjFmeVpleVNlK1BCSWNGU1M0Y2l2alNDV3hPL1g5UzMrR1c2WFZmWFdV?=
 =?utf-8?B?T1ZLMGttMlBsQVNCUEIxNzlJN2NRSitqcWVwYzlkQkJuNHgxQzVGZ0dyYldW?=
 =?utf-8?B?WmRNNGp6dlNwcy9jeXUzN2FNMkRmZ3R1RDZBbVRqM25hUUFiSlZWRURCQTBG?=
 =?utf-8?B?aEplQ3hRRTdlR25GK3NSb3VFWlUxVDlOWjZYTXVUaW5PSmpmWGlXbnNvemtw?=
 =?utf-8?B?aGFEaUJGTVBQVVZ4a0hQMGErL1B4K0tyRkdSY1FwSmp2OSsvbERoNUFGaWlz?=
 =?utf-8?B?b29QZG5DM3VpT28yOU83RUdXVXlRaGxDeHBPT2dmTWk0SzNhemFLd1hSYzgy?=
 =?utf-8?B?VnR0Rk1jaUFwTGlSSXJCeVRwSEFPVFYwYTFYaE9RQjZmbTY5WmFuV2czYXFH?=
 =?utf-8?B?YWhIaHBOeER3bjBreks0L3FoM2xTN3I1aXdYV2lJY0RrVHhnRlJ3eTBySTJW?=
 =?utf-8?B?VmJZcWVLTTZhckNvd1d4OGJDd0RRN01EeGFzY0RTcGVIbUw0YUdGVitKNEFy?=
 =?utf-8?B?TUxXRUJkMkkzYS96dkpQMnNtNTM2RDZCSWw3NkpNTGh4ejIxT21ReW1mSnZE?=
 =?utf-8?B?UGZ5K2lHS2hSVVYyRXM3N2R3VEtNY3l2NDh2cTRkTGd2eStuQ2QyazFraWNz?=
 =?utf-8?B?bThSWGRtZXFpTTBDUUxLTC9kdGpvRkxSQ3N1RUNPRks1Zmp2QzMrMU5rbktm?=
 =?utf-8?B?L0FtQ3lOc3hwQkx4MlZRMHBTbjRTMGNVWHpqTm9VbFA0WE51MVFlbU5yZGZ3?=
 =?utf-8?B?QW53ZlVEOFlxTndSK0tja3ExbFVFR2NkSFg3MFBNdEl1ZW5UcWtDb29OVUhM?=
 =?utf-8?B?WFlCQ2c4SUk1WW9iNW92QzVrZ3BZM3gyYUJLK0VMNzY3Q0NzTEVNMlNVbXRH?=
 =?utf-8?B?YnVUcXNrMXpzMTk4L3VlaUwwc0YzalNpLzcyQ0ZZdWVwdHovUlZQZ1dSYzAz?=
 =?utf-8?B?SUhaYWIxaHNkamd6bmhPN0ZZVGJNMmQvbGtaUHV6RHdVQll5QjlKUEc5aURC?=
 =?utf-8?B?YlFTQVVnQWNzdXc1a0YzVFdOZkZXMFNUQzVqNHZqTDlCWkMwVC85d2UrWStr?=
 =?utf-8?B?cysrRG9QYXk2QklxM0tTa2RjT2ZRMERxQjhNaVRSYmVNZXpsYjVPUVpnV0x0?=
 =?utf-8?Q?1edIWIsijt3bn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2I3b3dOSll0UDR3cFRWQ1VoYnZCQmlka2toMjlrYm42L2VRUjlVekJQdUpU?=
 =?utf-8?B?UXBwc0FXczJLNlhrbURKWEpDc1pXZk5IVG0zNFRVNzNvRTViTHRBNURQRUE4?=
 =?utf-8?B?cjREclpvcjVaTERFUmcvbzNwV3B0RDVSL0Rrd1VhS2cxcDZQN0dCZG1YaGZo?=
 =?utf-8?B?TTFFaTZsenAwdFZmRUhySzI2Sk9vVjNremxhdGJDbVMwSEhRYzczaWl5UG1o?=
 =?utf-8?B?a1g0U0h0enNzMlNaWG9jRmFpQjlWZG5iQlhKWk5XalU0aHFXTjdsWllGTmlD?=
 =?utf-8?B?RXdoYlhwMGVucjhXWDFVSzJ4T1dPdVBDUDgzZkh2Mk1BcURVLzhDamFZemFn?=
 =?utf-8?B?TXZSNWtVUm5NMHNBUm1NZ1MrTVZjeERBVWdKTEF6ZHA0Y3BRb0I0K29idEZ4?=
 =?utf-8?B?OWFXKzU1S3ZOamw2MHBheS9uek8vUENDMmpDa2RyUXJjTFRTTGdaRmRyREhM?=
 =?utf-8?B?cUhhKzkwdGJObHdVN25XUkFqWWRIaDF4MTNvYUVhTVg0ZURFRmFScXZ1TG8v?=
 =?utf-8?B?WXpjVk12R1dwdDBVQUhIU2pSTlVtRmx3b0Z4cExTVzZZOVpzTFpYZGxOdm1Z?=
 =?utf-8?B?ZVU0dWZtUEVBditHUDlxUE1LV0NwdGhNeUhJem5ZZmkvcFh6bDVvSTZBUEpJ?=
 =?utf-8?B?NnFKN29UMmNNc2pKNFNpVlB1UnZtTEJmWGFzNkZCUjZjSDFPK2d2TDhoZUVv?=
 =?utf-8?B?d0YrRnVlbkFRVHdjLzMyOHFLN3lucDNaVTBGZ2p6TWkzaGFad2wxNUkwdU5H?=
 =?utf-8?B?c1BVWnh2Wk9ZeVZ5MGEvbUg1R080Q20rSFdHeHlvZzJTNmM0SkdOZWowRWFn?=
 =?utf-8?B?bGZGNE5KNVR0eURzNDdNMDl3NnU2ZEpFY0hRNXh0WDFjU2w0eVNESEFIVzFh?=
 =?utf-8?B?RXRmakU0cFVpUjhQNlBCK2x2enNHTUNqRVdjZ054T1N4cEIwWklvM2k3TlJL?=
 =?utf-8?B?cEZMa0F5bjFoaWdINitaeFNMWGVZaDZmUmxsd3U5ajFHRGpaeko1SU5lRmRJ?=
 =?utf-8?B?TGxvajJOMlNYWjFMdUFZaFpZcS9HWDRpWXM3N1dqOWVMN0NmaDNZa3BmREhZ?=
 =?utf-8?B?M0FNbmhSRktOZTVZcEdJbXQ1N0V1ZG9iWVlPSzdGbEJPQ3NhV21PY1YyMkpl?=
 =?utf-8?B?cHYwVU94cW9ZUDlFcUlMQU5RL1dGVmExdVNzc0w1MVJ0ZXljMmJkZmROSHlu?=
 =?utf-8?B?MTdtOCtVUzdwMFEvSlZXMVhwS3ozMGtlSGJmdGdlVnRpenZwdHJEN1FGaFN0?=
 =?utf-8?B?Qy9haWF0c1J5VHdjeHpTSUk3djc2czc2SVVLdkRTY25BWmN4YkN3Y1NQenNw?=
 =?utf-8?B?SkZPNGtLeVRqMkh0M1FvSG5iTDZxcTNkOU03Y0l6Sm5SZGRuVGZ2MTdja0x6?=
 =?utf-8?B?VG9LalJmUFBTQmlnaTIzV3BvVFpheDd1YU1TYzdsblpzdGE4MTRQaWk3TG9D?=
 =?utf-8?B?cE8rcGFyWW1ZQmF2WnhxZzY3bTVRZFF3VE9YOU1HeHFKZ0lXVnQweGFMem5I?=
 =?utf-8?B?TllnVVYyWU44T20xQUtudTkyVVN3Ni9OdUFxMzBMM3NkQzI0cGlTeHJtVUh3?=
 =?utf-8?B?TU5mMEwzMGlIMG8ydXlqVkRWZUc5eFBLMGt5UU83R0ZwNGwwWkl4cVBrV2di?=
 =?utf-8?B?VkZQb1lOMDdHa0MrL1BOaUowNWlpaDcwTVRvRHRoSTNkaW0yWnU4VUVyaS95?=
 =?utf-8?B?RmJxUmViTEZXRDJ5RXBVNjRSM3duMkRpdkxzL2pzUklTSnRRbTVYUTR4bC9u?=
 =?utf-8?B?Qkd4WkVZY0JyUUlUZVFLUjJjTm5EVklwZ011c01ZdHNBZWFqbmVFNXA0ZnQx?=
 =?utf-8?B?K2FGZ1BZenVlaEpIMmpReGFzdGFTMFQ0bE1PbkR3S3pLWEdBN0hjeTdvRUky?=
 =?utf-8?B?Tjc4T2VELzhlaFg2djNGanl0SHA5UFE5NjdvUG12TU5keXp3M3R2U0tFWFdH?=
 =?utf-8?B?aWVwWkh6aDFkT1BwQllBWDhwSnMxdllSY05uektvb1FxTjlGSFh1a2pSZXV0?=
 =?utf-8?B?Nlg4NkJFSFdRdUxpS1YvQkdDeFRxemdGZCtTWFBoK0NKUVBGWkRYeEh2WWRV?=
 =?utf-8?B?K0tUeXJVRDY4dVZuV3dCQ0V2YldnSTFHN05uNExXSXBEbGl3K3ZIZUtybGdP?=
 =?utf-8?Q?rzK8iUwiz9B0L5AcgZGYfaZgH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ca22a4-4fa8-41bb-c1de-08dcfab8da5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 21:05:02.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kufqtSdoXTfMtXgghIeQW/SO/Gv5XUUXn1hzxveBWU7C8n4XuuSIoX5vsEAK+tej9rdXGoQr1TZqe9RaAXckdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10502

Some PCIe host bridges require special handling when enabling or disabling
PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
to identify the source of DMA accesses.

Without this mapping, DMA accesses may target unintended memory, which
would corrupt memory or read the wrong data.

Add a host bridge .enable_device() hook the imx6 driver can use to
configure the Requester ID to StreamID mapping. The hardware table isn't
big enough to map all possible Requester IDs, so this hook may fail if no
table space is available. In that case, return failure from
pci_enable_device().

It might make more sense to make pci_set_master() decline to enable bus
mastering and return failure, but it currently doesn't have a way to return
failure.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- Add Bjorn's ack tag

Change from v2 to v3
- use Bjorn suggest's commit message.
- call disable_device() when error happen.

Change from v1 to v2
- move enable(disable)device ops to pci_host_bridge
---
 drivers/pci/pci.c   | 23 ++++++++++++++++++++++-
 include/linux/pci.h |  2 ++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2a..4699b1208d621 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
 static int do_pci_enable_device(struct pci_dev *dev, int bars)
 {
 	int err;
+	struct pci_host_bridge *host_bridge;
 	struct pci_dev *bridge;
 	u16 cmd;
 	u8 pin;
@@ -2068,9 +2069,16 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (bridge)
 		pcie_aspm_powersave_config_link(bridge);
 
+	host_bridge = pci_find_host_bridge(dev->bus);
+	if (host_bridge && host_bridge->enable_device) {
+		err = host_bridge->enable_device(host_bridge, dev);
+		if (err)
+			return err;
+	}
+
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
-		return err;
+		goto err_enable;
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
@@ -2085,6 +2093,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	}
 
 	return 0;
+
+err_enable:
+	if (host_bridge && host_bridge->disable_device)
+		host_bridge->disable_device(host_bridge, dev);
+
+	return err;
+
 }
 
 /**
@@ -2262,12 +2277,18 @@ void pci_disable_enabled_device(struct pci_dev *dev)
  */
 void pci_disable_device(struct pci_dev *dev)
 {
+	struct pci_host_bridge *host_bridge;
+
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
 	if (atomic_dec_return(&dev->enable_cnt) != 0)
 		return;
 
+	host_bridge = pci_find_host_bridge(dev->bus);
+	if (host_bridge && host_bridge->disable_device)
+		host_bridge->disable_device(host_bridge, dev);
+
 	do_pci_disable_device(dev);
 
 	dev->is_busmaster = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be61..ac15b02e14ddd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -578,6 +578,8 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */

-- 
2.34.1


