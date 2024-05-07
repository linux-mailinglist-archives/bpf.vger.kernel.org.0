Return-Path: <bpf+bounces-28936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F848BEBE1
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977A71F21A79
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9C178CC0;
	Tue,  7 May 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C7nPY7v0"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509F16E88F;
	Tue,  7 May 2024 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107652; cv=fail; b=ZaVNPhbWYDhucF501PzKmrzuerdwnsPTsbpMIaPBxop8xlZ9bhGhPlOwp3lyX8Gn3pSmOaOUFCgqO4ho45aSe8nV0ANz6M1d2JPFErqgjVkJ2dxl9zdOh/14i5QemvGPsO9vouzjIeqOjdbMrY56+Qj1NAi6UpuperR2evRMLJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107652; c=relaxed/simple;
	bh=sRfIC9eIMs35HNpGNTm9ilEMNUkn4dvgFYwTvQZ8kuQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eMVbtbF89koq3LAIYT+kZQjBqHCne0KkMNcVjTU8FAUiWcqFfY8l1t6qjGufFjREg6kfm7BmHtHTrGed66oUZQS3ve5oj5EF5Wgy6yBd5MkIRVsEqraXQ5SCCUSxk0OfolXs66yiM1CFAvNnKCSmuMjbKQ712LUVVzb2uffOXd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C7nPY7v0; arc=fail smtp.client-ip=40.107.8.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBqjZz9rPcNr9PLlySFIIXg+1hclH7pQPyg2jLKWDFnV76ImoZF6PXmyDFhZMiB9vK6M1CESvXUR6nGLUZqjB/L3qU5ypMfaRhrh9dYMBcugsKcRmokadZ8ZlF81LkuVVRnm44Y+S5RlZHQ/3VzvfT+E6IybicPn2wXA6SDn/SGY6MltVKUKidFWBnNPgK5lVTd6UwmZUtjJED6YhVI92X/CVoCJxm1aZA3a50GQ/kIzd46fZeDDiwCTfJpvJgUUZNC1xxNy1PxE0LcElFAzhPoeverzYSJr0ZUhEmf2q8stRRS1aXwbZcVjf0A/kjsx+eGYyNnZET/ptfaOPlpDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9ARmSVB6q3UGh+IrKQPkWi3XFtpb4PQIRo1doqw2yw=;
 b=Ro8KnDy6eABec4Qikt1Yc9hdTpu97pJxeQSUrooNWqPHsEIIn2e7YW386qpY13KKScyqbp77MvyvApA0TskJbovBqJj8fawnz7BJBspEDz7OH/v5W3tVsU9iINYC/sv0M34p/T9iUegXFNJILtOvXpCUiq3xuC128LbY57t6iEdeP5BPHsz6LECessjWcaL5Fl30uuMRKW40jPoG9dstGgEExSrDjIzxuMUqy3Gb1+1mfmvXEAin77KBsaMoTlTKq6ebICQYhCocKioel9n3kdscYtlQNxY0Jm4A5eWX74a6DCMoQBAZjYp5TjUAs+6+wB22c0PPHuQjEECJClXjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9ARmSVB6q3UGh+IrKQPkWi3XFtpb4PQIRo1doqw2yw=;
 b=C7nPY7v0NR78kPdZGGKKkSa/kK9Aqm+no5igLUimCvGJhknlmv3s2iqEqSg6kxhJoARojKekNvOr872E7WW3l8Sliy1YJm7Pca24TmykaKIsWACIWMZImJFLruKiZ9d/X1P1UtHI5pf5sg39XwGQF9ywybGWZ9m/BaFILrIJP9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:47:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:47:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:50 -0400
Subject: [PATCH v4 12/12] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-12-e8c80d874057@nxp.com>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
In-Reply-To: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=4309;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZPjAcBxtYZJ5XniaGZi6HJYuwyn8TYkFm7iZBMDoWyQ=;
 b=N9Nuh+GGq78j5duB6mgd1DTwhcXW8tEGRaXD2TuBw1H0WsH1ex7NBVYWqdvCxjs80qQIdrTFH
 LAg8rwiM7NOCJi53O8ZNlbd6O5+s5fZntngaQHNIUwdUkQ/niVLmylQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c11f36d-28db-4f78-fb4b-08dc6ec624a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c25xWnZ4MjUvbWJuV0dwQVhzeUhzS2JlNVUxYmEwNFE4S21URjV1MzhtaVlX?=
 =?utf-8?B?U3REdjAzK3U4R3BRRFFMVldEN2lmVjl0VXhJYmdDalczSlI0SG05ZE1JbkdT?=
 =?utf-8?B?MUhzd2hvMHA0V1djYVBFWjMwMFpUdGVrRDU0and4alNhZlkrNnJjbUZScWI0?=
 =?utf-8?B?YTVJdzdoTnRKdEs5RllIL0VUOGFwR3F3MlJHK2I3U2pIK0pIREw4SG5LTVhG?=
 =?utf-8?B?VS9wc1JzVHUzNG5ZQjZHVENYQ29LcFZYSVA0VnFxc3A0NGdZQURGeEFzTVYr?=
 =?utf-8?B?MmRzcGZBUDI5dHJaTVJYR0dBVUdGNXJJanNOY3czNlk2VTBPMURrWThycXNH?=
 =?utf-8?B?ckF2enlPZ2t3ajZoUGk5ZFJGdEVGRGJzM2c1bHc1clY2QjJLUS9UWldEY0Nl?=
 =?utf-8?B?bXJKRVdnQTRKM2thdTdYVGFSZmtmZmxub092MkZ5YlNpc3hmSVJMcUJlMkoy?=
 =?utf-8?B?UVg2ckZvbEpTd1RqeWlLMU5QK2EyNzYyY081NkZkMlN5VzhoYjhIVjh2ZkNm?=
 =?utf-8?B?Z0o1elVHU2VuSFZkNGU4azdudmhzdzZxcEFGenR1L3g4WTRRWGRpOEs2d3FE?=
 =?utf-8?B?M25PcFBMSHJTRHBUZ2YxcHIrZGRTTHN6cHBRbktMaXBUUHJJeHBoMDNUZUJ6?=
 =?utf-8?B?cVlDOHpnbGtUbFpNZ3VRZ3NKL1BNNGgyb2w5a1VaRGlyUG0wTlF6TG9ibXNY?=
 =?utf-8?B?YVFkNFN4OFgyYzY2U0xyMFlNL2x3Z2ZHdXNPUFQ3UjBpYnJNek4vaUVRVlhk?=
 =?utf-8?B?NTR4cFhvUjBReVFlM3VlTXVVS1BRWmdiTWhGK0J2MzJrTFdhTW9Kb3AvRjhx?=
 =?utf-8?B?RkU4ZEF6NDgvaEFWK2pkZmZlUzByYUEwcjVLejBkTVVlMGdJb2hWV09ZZ1Zk?=
 =?utf-8?B?NkVnejJSMlQyd21raDhiQXpoWkxVOXZ2eVhiZE1XSXJaVG0yLzJEQ0hqYmNO?=
 =?utf-8?B?aUMzenVselQzdVNjenZ3MWlENDhGblQyY2lldWNHZS9Nd2U5T1ZTRHJ5OFVI?=
 =?utf-8?B?YldFVWZFN3Y2eDhsaXNXVEFhanVXYkRKM0Z4VXRlZkJidWVpQWNXc213ZE43?=
 =?utf-8?B?QXlsNFpQQk1VUDR2cGpldmE5c3VXVWNOMDgwbW5TNlNRUkZENmZ4V3BjMU5N?=
 =?utf-8?B?ei9IOUhIVlZRcWc3N2FqTUY5b1duenJsR1FobHJjbEZyZ0RPdkNqMzFmNHpH?=
 =?utf-8?B?ZWl5aDNqSk9WMGp1VHRnTVdUZUgxSGpCc1RNTXVTRXMrQUhWbXJoOXRCbkVG?=
 =?utf-8?B?eTZ0cDh5a1JvcGlvYkRKSE9xS3MzZnVDMDlOd1NJZEhUK0VzT1ptQWt2R0dP?=
 =?utf-8?B?eGRZVDFZYjdMMWdjOXc4RkMwcVFPWmZaeXloazZoUHdyS2xBLzMrUVEyRHV2?=
 =?utf-8?B?L0w0aXY3dnNGaHNkT1ZKMVpNT1Y2MjlTY0RHb0tPdjBCR0Z4VmRNdVhKck8z?=
 =?utf-8?B?TnM1bUcvSVhFQlFyZnExcm5pblRmQm9rUW0xSmI2UFM3VzVOZTd4bDdJSHBl?=
 =?utf-8?B?RVovNCtyL1pBL3U4MDZoVmozRGNmamt4N1c0NitXbEoxQ2I3ZlA3TGtyaENS?=
 =?utf-8?B?UnhUeitjZU05S3JIRjNhUFlkaEh3ekxUdDIzTWVSVTRjb1kyZUNwTXhaNlhv?=
 =?utf-8?B?bGNPdWNMNHFVK1pwaGJaclVOMWZKQ0I0TTJGK291TmVoTlZKZCtTc0Uvd09H?=
 =?utf-8?B?cjFmdHU2NXMzSmZ3d2NVVENtVlBlMHovSkNIdm93Uy9QZXJScGlxR2QvQ2Ny?=
 =?utf-8?B?RG5ST0h2TjZzZGtneTVNSUllVmVKWmhnTzcxK3pYSTVlTEEyTy9JNjJnZkhq?=
 =?utf-8?B?UG1lazZId2d2UVRYZU1LQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjZXam1wVy93QlJMK2NBMXFodk1xeTBLWHNlSGorOU9iWWdZcyt5cWt3bUtz?=
 =?utf-8?B?aVhOMXl2STErVTFEUmJMcVdoaFRVdENOblQ5YzMwbFVITUVwTEUxNFZzdUJN?=
 =?utf-8?B?Nkx0Y3VGb2hPSDN3MlcxcHZRd0wzNi9xVENYU1JJVjJDTlFYM0c2OFVrREd6?=
 =?utf-8?B?REsvYXMvb0wybHlxRWRldmpFL3VSSEQ2VTJqTTl5TzJaTmdPK1lTd1V0bENI?=
 =?utf-8?B?UTR4RUJlck0va1JCYkhJbmVXYS9ENHY4Mm5WYzd3bXNpbWZyaUJ6V09NaUZV?=
 =?utf-8?B?SjAvOFEvZ3p4SVBqQUh2TmZ1RjhGN2liWlRnTFYxUU5aY2NhQ1JRNFg5Z01x?=
 =?utf-8?B?bjArVWRCNkgrWHN2SSt4WldMKzV6S3NvbldDT01uVExwVlpRU0tycTZuajhK?=
 =?utf-8?B?L1BUcUF6MVVpbG5LVzRJampBME1JZFp1QVp0SU93Y0dDaTZZeXY4cVZQNkN0?=
 =?utf-8?B?aDN4aDdFb3dISXRwcmRxWjBZWjEyRjl6S1ZvcVNuNWx0dDZXY1BJRUtGMzJY?=
 =?utf-8?B?UlIyUll0ZFp4eVBmRkpFa1JLd2ZaSGVpMGNwdVZtaFlUQXlmcUxVNDBiSElz?=
 =?utf-8?B?MXppdUxPZDh0bm9IOEMyY21MSEJQN0c4Z21IQ0R2SXZxVTAvSTNpalRtYnlK?=
 =?utf-8?B?UG1jRlA0aDhBQ2o3a08xRUhaR2NTV091TUFLQXJVb2h2bU9IcXQ5M2Zab1Nj?=
 =?utf-8?B?bzBOclNWc0xMSHpicml6Q3J0YlpCdGZIckJ4dEhPbEdWVW9Ea2s5L3dVVThk?=
 =?utf-8?B?OGV5SUpYV2JGZGdjTVo1SEtpMERIb21HZGdEdVAzdXI2aG5neDNHRDcwOCs4?=
 =?utf-8?B?ZWFkdHRuY0lLRUtzTFJ2N21ob1lFRHRZalhZWC9BbWFDL2pOdVFBcVNrLzdu?=
 =?utf-8?B?MTZqNTBvcjJIZHZCY3Irb0VKL21oQ0FmR0pEWmE1WGdhaU1LRmp5MGtiYWZ4?=
 =?utf-8?B?S1pjYUphWmRnMHpOc1Ztc0JveDhPOWc5VGttZ084NW0rbG5xdGt6TEVaZmsy?=
 =?utf-8?B?bGwxdU1ma0gvSVRHamdUanowYjBLWjNSOGphQ0VpNlF0M25tRG9wL1FoVkxG?=
 =?utf-8?B?aG1UWTVlNjU5WFNEcWFNemJYdVhUWkRrOTQyWDVQTEkrQmZUMXpWZkRvVGVV?=
 =?utf-8?B?OHh1ZUc3MW9PZmc3bERhaDRqU2xTRlBOSC9raXlCTGFQN1JGOEFNVW1hQU5J?=
 =?utf-8?B?UnhiKzFnMTdZRnRCTHdkWWRTNVFWVEt6cldGbzBrZmF3RHdGRjJhQll5SkN6?=
 =?utf-8?B?eEJnZitXNlVHTCtqdU0wVTJYcDh3c1RyMVRvWVpla0l5ODBwcmYwNWZtcmpR?=
 =?utf-8?B?MUJEOTZhT3dEZ2Z3c2xwUkN5WHlPSkEySmtvYWw1a2tFdEpLb1hDTWlUc0Uw?=
 =?utf-8?B?elNlaG1DczUyZ2orYnBGTEFkeU5MVDdXUm1EckE1UFk2dVlYQ1BLYTJOa3dV?=
 =?utf-8?B?dHROZlpEZExoYnZpbXovRFUzYmZ2UjR5YnIvanNibDFtdktIa3pmVk5xSlFy?=
 =?utf-8?B?N29hdm5zdWkzT3NvTVJMdXVoczhYVjc3RWducjhTZ2pSM0dXUlpNc2kwbXkz?=
 =?utf-8?B?cy9xdkZiczRhWldRM3ZhdjVZYUYzWDBVM1FTSVMzM0pIaC9VL3VYelIrZVB2?=
 =?utf-8?B?alhSOWw4bXNuOThudTV0eHZVMlRYcnpzOVRaK1VaUzdWMG0rK2xObXBGcHV4?=
 =?utf-8?B?M2MyUk9xWnh6SWdPaVB4dkJvS2RjM2lhU2NTMzVzazNNTC8xcW1zSisyOGpx?=
 =?utf-8?B?dVgvSEl5ZXd0ZytzNE5vZkcyd1I2TDJlZFpFVG9FeEZuS0g4K2JRbXZuWWdM?=
 =?utf-8?B?NThGYUV2TGtXWjczSU1UZkVwck45bUJNdFIvUjdJUU9hOWJMdFhaRlFHWEZs?=
 =?utf-8?B?ZzF2RCsvZWhGN1FBTW56RGFFSnJFbUtlZk94UkhYcEoxU2pVZFhPM0NPMUJD?=
 =?utf-8?B?UmZlKzhjajZMTXpZV1pOSks2Zkc3UERKUjNVNHRqKzRlVXk0T1JqeDI3MEhw?=
 =?utf-8?B?WWhyTS9TMkdmTVN6SEtVU3pjSmlreFZpUTNWOVVRNmpwSUxuYS93LzhJYlpJ?=
 =?utf-8?B?MXFwUGJiSDd5K3NwOGFrODZmRGRlaDd2SDFOWVZIWFBJQS95RGZJV2NNRzJ6?=
 =?utf-8?Q?NyxwbWZ0cnKtv8WghoHolkwZW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c11f36d-28db-4f78-fb4b-08dc6ec624a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:47:27.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c252wehaEyfmzzF57iSFhRpekzgJm51HrBSbR8OZmfSrsJxa7U5hgFfwlnGuEt8GWebUo7oaz4xEgTCLIiyCIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

From: Richard Zhu <hongxing.zhu@nxp.com>

Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
the controller resembles that of iMX8MP, the PHY differs significantly.
Notably, there's a distinction between PCI bus addresses and CPU addresses.

Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
address conversion according to "range" property.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index df623977d8fe6..a5af3e874613d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,6 +82,7 @@ enum imx_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX8Q,
 	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
@@ -98,6 +99,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 #define IMX_PCIE_FLAG_MONITOR_DEV		BIT(8)
+#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(9)
 
 #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -1091,6 +1093,22 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
+	struct dw_pcie_rp *pp = &pcie->pp;
+	struct resource_entry *entry;
+	unsigned int offset;
+
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
+		return cpu_addr;
+
+	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	offset = entry->offset;
+
+	return (cpu_addr - offset);
+}
+
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1099,6 +1117,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
+	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1599,6 +1618,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
+		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CPU_ADDR_FIXUP)) {
+			if (!resource_list_first_type(&pci->pp.bridge->windows, IORESOURCE_MEM)) {
+				dw_pcie_host_deinit(&pci->pp);
+				return dev_err_probe(dev, -EINVAL, "DTS Miss PCI memory range");
+			}
+		}
+
 		if (pci_msi_enabled()) {
 			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 
@@ -1623,6 +1649,7 @@ static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
 static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
+static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
 
 static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
@@ -1726,6 +1753,13 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
+	[IMX8Q] = {
+		.variant = IMX8Q,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1804,6 +1838,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx8q-pcie", .data = &drvdata[IMX8Q], },
 	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },

-- 
2.34.1


