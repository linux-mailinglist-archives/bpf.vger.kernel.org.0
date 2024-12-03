Return-Path: <bpf+bounces-46039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639499E2FD4
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 00:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B4028347C
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EFB20ADF3;
	Tue,  3 Dec 2024 23:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nxPFKg4y"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D620ADD3;
	Tue,  3 Dec 2024 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268462; cv=fail; b=QcOe/SlHLGup2711M+t/I2uBggCnqAhM3cJej5GkYk59qx5lp5Jw9Wlb3NfT0UCQER39euW8Bt3H/Mgg5CwTvMxDgDXlMckHEYdvMm1lR0cgsUJJwFBP9WE63jHirkYl3bX7OHAfslvZY+5/ZPE9XGMZgBdcl9clNaFeEj0Wgzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268462; c=relaxed/simple;
	bh=7cB7g1Uh8JOotIqznQjVLlaCi6bPwnExy88Hl3IJhNU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d78KZMfwXfVlGy0XWf6e/jh+w3m/7dK5x7SUgNoPzLgzh4PD8D+HT9T5ePaMhtQEjpC7cidn3QI2X6oms6S0UzUqD84U8MwPe6+2TlV0KU7JWU5lfmD68qd+Axtec1v98fCMQATxZzshFaeq3NhF4Tb7C+4LDPg1Peg82v+Mo64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nxPFKg4y; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia4NsE56WuWkjr8uh8lxepfvpRh1S21Zo8M0cQsXCc9oGodJIZ3MD+g4EEBzT7zxtkaGDhZu+HohadHpsqGismREKmeO70lVMDybuw7wB8ZZP3bHaYi7uAK5i5sjHYm/fisnoQvJbumfjo7m/G88K6WuQPvj8tgDKFUhSUD9k7w5BOuHWIoHFBcdoYtHEQ3UkrGpfj+6l5X7LIj5kwHpq7G7jWjWhBZDgZpQCaF8VkfMiTAFxWiMaTgnd3UH5SqULFa/wwvil2+mNYFLUMzPKUrba4yzfDkkr9OygWPY4Tej5x1WEGElAz31jOsVNbkOvBsAhQ4OEWGiDUjr3spvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw/R9FZZp1VJOqnI4EGnpxzsdk8zWFQNSU+rOqngUXE=;
 b=YIwHjjvsg/lCMouGR7/vNoGajYFk/7WFjzR92+J+BCRmPKR1F6w6Zp0QOwhJcsdymyVRbc+NXruy5C+f6m5nHSF0yBhOoORz2hVqNnRYmS84govh4UhLCs3NeWxg8X2EnP/08Wy+qtsWi9N5EL2anjz5w93Nc0z8+XUig+PY3oKOPGMSApUiHGr3aVeXdum9dhF5Vb2dK6YiWbVWFjvaiAMjidV6j9JUhB1i2PvntCzRU19qe/iFy63kPRTbyBgDOT+6LzJQxqSndiYcWXiFoB43myh0I9MtJAOHfxFTMUJ17gnrEGiKxw3PSzqmQYldH3enVJFoaWeuQS0XVZ1BzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw/R9FZZp1VJOqnI4EGnpxzsdk8zWFQNSU+rOqngUXE=;
 b=nxPFKg4yEyWDQxtZ++kZTw4YYxhvYvZrU/egw69hh2+mqxUbS1RbGqzcOTfGXvgoz6sgs6zutcO1mwiiaryIYR7q50KLAzah1661ygg/5QIUYKVYpcCyVRVynW9S8ruXoCVQIMEk1DG8tWt3fBMbyQyJBDbVDVtmN4hXNeElpMSi8hzfZJmtvPY5WsOloit1qI09QBzE4YNqsRtBdaBGydVrJOTBHyMU6I8nHweJ2EVj/aVj+bj4DT6fMmHwpffTo9C3JRp1D/y0E/9I3VasLJNEZMssC7+uBlGNQvM+K5F+EhmbzRncCd6pHoDaJft3yKUnBhAAnQOiLurGs41PYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 23:27:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:27:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 03 Dec 2024 18:27:15 -0500
Subject: [PATCH v7 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx95_lut-v7-1-d0cd6293225e@nxp.com>
References: <20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com>
In-Reply-To: <20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733268445; l=4315;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7cB7g1Uh8JOotIqznQjVLlaCi6bPwnExy88Hl3IJhNU=;
 b=HYEDrP3HycCh9VaQ+5xea4ku8p7VoaXNt8ymbqLM1S22i/IOHU1vw/3j1k4twoMYU4xIex9bw
 KJQHtfrXORlCcK0M8LWPV25Tlyh0nJ4xXMM/521OoXSlDOythVDflv9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: d97c3db2-27f8-4664-9d79-08dd13f212cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEc1RUREVjgrMEZNYnB3UjhXa0paczZ5SndSU0xrUnBNelE2bUdhb2lWWHRp?=
 =?utf-8?B?QUFUamg0RzhnNjNDNmVEQU1wOG1rN0hNd2FTY0Q2bkF6ZnlMN0tnTURJdHVa?=
 =?utf-8?B?dnBDVFgrNXRmQWd6NDF3ZERZb3JnWXNsZTRrcWcwVE1vSDdDbDduRUlCdW8w?=
 =?utf-8?B?QjJWRGVnMFdDMnpSTVFEZW9tcnZTK00vVi9QcWRJcGYwSWtsKzFWM2g2MHlz?=
 =?utf-8?B?SUhtcmJXdGxVTDR0cllYNCt1eUhSMGN6Znl0cVpscklVQkt2RWJ4N1VDVWFv?=
 =?utf-8?B?ZFBGOEZTcThoWHNJZWZjUFgwSHQ5cEhGZVViRFgwMUxOV0pkMlpQZEJoVXI5?=
 =?utf-8?B?aG0zdExpNlpqVWdhbjlZcU9oYWhEZlZGNDFtV2VBdEduTDNuS1c5NnJoSzNK?=
 =?utf-8?B?YUptMjZ0Q0FRaWN5STVvMmsyeHVGUDhsMnk3Z0VhWGkxZUo2ZWpuWTlDQmww?=
 =?utf-8?B?ZlhVSFFFeXR3RnlqU2d2R2VaWVpsc0YzTno0a2VDbkpoNXFEUkZqWEllWEZT?=
 =?utf-8?B?NStvTUlCNE5BVUsxQ0dTSWpJZkJjdFZPc0tzaWtYa2lrK0pBS2hrTmhGcmpP?=
 =?utf-8?B?aHV5NjBDaEZKOUtGcHdvNmJVWkJoaU1aUXR3ZWNjMWJ4M2cwK1pRYjhBeGgz?=
 =?utf-8?B?ZUFxMGZEWVVzaW9hZUU2T1dtMEVmc3VwYUdqQmJFdVVianVROTE4MG9hV05J?=
 =?utf-8?B?TDlLUFFEMyttci9DMWx6a0VSbnJBTHBYRXYvVUkrbXZmSU1NR2ZPN2wwVDFL?=
 =?utf-8?B?bWtPSW5icjNnVEo3eXlVZTBBTEorOXphT1FBTFRTNVVCUmlkN1NlVEx6WHRZ?=
 =?utf-8?B?SkJxc2wvQ3JzWVlaYkhSK3dpbXBoRkFOc2JnVkdETFpUeTlEUDduWXk3cm1Q?=
 =?utf-8?B?SDJncFV2TEhOdkR3SVNvRTN3Y0FrM0plTFU1RTkxZjQvYlZ0YklNbG5hMFNr?=
 =?utf-8?B?S3pjRDJCaHdRRGdkT3IyRit5eExHN2Y2L0FiSElUZjByU2hKNGxQbzdIamNM?=
 =?utf-8?B?RXFzK2FqM3UrSENjcGcwNWc0RWZya1RLU0dYUnhjU2NLczZndzdsU1kxbGds?=
 =?utf-8?B?ZU45R0FZbFhIa1hyRFFyTW1nMzlSbGNtOS80RXlJT01aaHFwNDI2UWNyOUZi?=
 =?utf-8?B?UTF1T3NXLzQzU0VwbUR5dXBETXRYeWtZWHFhRzNRampuMEp6R0hNejFKcWQy?=
 =?utf-8?B?bGQyK1FOS1I2QWtxaHZGa2lUczhRQ0FZc1g0a1c5OG14OHhjRHI4ZElxMEJO?=
 =?utf-8?B?d0wraFhiOGxkWHo2TEVxTjh2c3RHUzJ0ckRUajNKOXRsZDNXcTBmZDJraThm?=
 =?utf-8?B?M21tU2dkaWhGd3dhMUFWVkFDTVJJTkdBTFY5MGZlQjR3Zm9GSXpSWnVYeVhJ?=
 =?utf-8?B?cS9tZFA4eUsybVp2akRxMmFFNVJFVDkrck9SMWxhWUlXQzI2QmJQWGcrQTUy?=
 =?utf-8?B?OG9ZRGc3OVBmQkE3Ylk2Zi90MkJMMSsvbVR5OUI1aUFseTcxVkJvZ0dQL1gy?=
 =?utf-8?B?aEdPRXNtT095QStvMWRUeHltblpzanZXbldoLzlSc3VjTWNmTThIK3ZFTkhl?=
 =?utf-8?B?enN2a3dqbzFReTJlUkJ0WTVCTXM0WERnb09KZTgveFkxRit0d2hVM3Z5Wmhl?=
 =?utf-8?B?TjlHYXlySTRQYVlRLzdjenM3OGFBVnlqOVo3My9YQkZBeXM2emxDclZwREtn?=
 =?utf-8?B?aHdEWjBVNGd1ZTgxM3ZTNXVQcjR1UGFoSzIyN2hhSXliRU00Ky9wdzgzaGp1?=
 =?utf-8?B?bERyMDRSL2tqYks4b1lVYzNQeVM4Ry9zQStyWDZweG9KNktLL0lneFcyU2pX?=
 =?utf-8?B?ZjF5eGFTcXpEdzNXbTRadTFpeVZPQ29taUZrYnIzeTJ1TWdDZldpaWxEOTZK?=
 =?utf-8?B?cHdCeklCUDJKb09qUHdnandnVDZ4RHY5eGx6SlpJZEc2Z29rUDNKcEVKTC85?=
 =?utf-8?Q?ad0Er1hoZB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0NWUTdKSlkxVzlBRThPVFBmVlRtL3Z4clZudEpMQmRDMjR6ZXhrajBSYlBG?=
 =?utf-8?B?a1kxemkzWEpCc3JLMDhaU1lNbm1CdzFRTFZwNXNaK0RQQ2FzQUtMQ0FLNVZz?=
 =?utf-8?B?NE84MWRkNWlRMThDTFd4VWlFdUZwWGZpcytmOUZyNFF2bDRya1luVW5qN3Z1?=
 =?utf-8?B?dS9FS0lMZWRZd041QWlWOVdxa05BZGM3VmgxeXR3NTFCUm9kSHNla3V5WnpP?=
 =?utf-8?B?MnJkaDVvZThibXZyNGhhZDlzUllmLy8ydzNGeW1PektoWTRYVklJak5tcEMz?=
 =?utf-8?B?cEdSeUlUOExWcGZLMzNmc1c5V1gwWk0rVW1JS2g3YkZIWjlIREk1aFpiTmNp?=
 =?utf-8?B?dUlvVGlVT0xoVHYva0R4bnZiY0VlcFZnMkt3NTkzVjBFNTcvUVgvU2ovOGdT?=
 =?utf-8?B?UHRmYXhJSGkvd3daR0VxQlJNanRJK3YyR1FmWnJROERRUC9jSGZndXdYc3BR?=
 =?utf-8?B?MHd1SDhLckJ5WHYwL3pLUlZHTXBheGVRQTg2U09XZUdiZkMzV3dwNWtyVE1a?=
 =?utf-8?B?WUkxdXpEcWtzOGt3cjNTUkNYWG44YmkyZlZVOUd6OHVVbFRHMXBZcjZjUSsv?=
 =?utf-8?B?ZUs3dlNmMVdmYVF3QnJ4UjlsTHZLN1NKZzI1cXY3NjVBMVdsbW55MzM4Z0ZO?=
 =?utf-8?B?U255Nm5nUC91SUFhKzN5SGFkVDEwSzZTendiWFhDMG9jQlZzNGtMV3NMbEhT?=
 =?utf-8?B?YllqYXFhSzRhbk1xcytKZ2grU3lxSlBGUGJFd0d1MmFDajdCR1hBUlFVM2lt?=
 =?utf-8?B?OFFwejQzV0srWnBSQnQ4dDJhaXBkTjFrTm04cVVtbG16dk5RcHp3WjBsVnlV?=
 =?utf-8?B?V0FWcTE4ZEtaWW1OeWpGU2pFeEo4WnVyRVRtR056NzFoUFRuQzlyUERKZmUr?=
 =?utf-8?B?WU13YzYrQU9lVmVKeUpUNjhJYUtFV0s0OGR1K3BpeEVLQVNwZElEeEVFM01G?=
 =?utf-8?B?YmphZlNIeTJmbEdHS1ZLQ0lxOTBGKzB3bVNaQm8rKzc5dGFxK2g1Skg0RExM?=
 =?utf-8?B?MUYyYjJiblJyeHRLS3U5TFdzdEVvK29jbUZoNDlIdmo5OWt1Y043VFlWMEEx?=
 =?utf-8?B?VjUzeG5wODhQZStFQ3lGeWJJdlJ6N2k5OWRXNitHWnBpd3dVK3Q0VHZic0Fo?=
 =?utf-8?B?aFN6eFExVkk5T0dOVU5MdEh5WVNzM0tNS0tVc2tYUFZ2U2x2NTJ3emltUnBK?=
 =?utf-8?B?TnRib1paazdHSHFscHZTZ1g0bWpLWVR1YlFhaGNIOVdENlhuSnJYcnNoK04v?=
 =?utf-8?B?SUdFRzhVc3B6OHlCNzFsbmwyQnBQNEtCK1RaRmh1aG9zVTFSdlZWcUUzWmZy?=
 =?utf-8?B?RGdXOGVYcWNidXVDSWtiSDcxVmJzN29qVFBwZGZoQkZZNlQ3SXRRbHZZcWtL?=
 =?utf-8?B?cys2SVViMHBrdmdsY0lGRGZuaHRFTzVUdmdGdzJGWUhMSFJ6cVlkUzhiN281?=
 =?utf-8?B?MmRxcWxTUzhaWUN4ZFhmckgwZlMrM0p1WE9nRHZVY2dwd2ROZ1dtWkhQZDFM?=
 =?utf-8?B?SDlEb3NybStxWDJ4bjc1VFpsc1BjQWlmb1VBcUxiVit0YjVGQ1NQQXBFaVlT?=
 =?utf-8?B?NlBDTE5QWDdQMExPS3JtanhaMTc1TTBUMStBVk95cVlvWTFJZTUvWjVWYU94?=
 =?utf-8?B?bXhRc0g2d1YwWnN0Zm5SWkJUMGRXRUY1SldHNXB1YVptT3lFVTJEb3VhamI1?=
 =?utf-8?B?aVdMS094d3BUZk95dmgwVzFZcG5adExMUzJhOEZTQkJHWGV2VFlzTkJHcVla?=
 =?utf-8?B?WkIvMjJHSk0yRSswdUt4ZkE3NnpSZzVsR1JsY0J4OFNTRGtzS2MxRXNmOVQ4?=
 =?utf-8?B?ZHZJblVwRVpBVFR6M3RCb3lKeXNEYjJxWFJlbVVvbnY0eE1OeVhaNXFmSXBV?=
 =?utf-8?B?UDNhVEJvYitoZ2lJMVZETElCUUZKdm1xRjR3TlFLSlo0Z3JmYk1LdUIzN0Ra?=
 =?utf-8?B?dWdOcnU2Lzg5VTQ2ejU1SGljdXNYQldiQkNFY1RpcHRLcGdxZ0QwU3NpZXd6?=
 =?utf-8?B?N1lLTEVjdmszSWhCRWgzMHRVYmxDNWg2YjcxMWw0MDJrdit2ZEQvN0lPU2dp?=
 =?utf-8?B?QmI3SGxwZGRhcUw1M2NaWUJNUUFtL0NITHFub2lhZHgyaGNJeERBUjhITVBH?=
 =?utf-8?Q?ozRHBQfq2rWwzmQNe69yDe/om?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97c3db2-27f8-4664-9d79-08dd13f212cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:27:37.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPvjD5g0D6NQxdqi3fme37RGDPMwuL9u2yUtj+aVySPAeKYVnjOpAwA83StO6uufIkinRs7f32+D9n08mSrOPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846

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

Reviewed-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- Add Marc testedby and Reviewed-by tag
- Add Mani's acked tag

Change from v4 to v5
- Add two static help functions
int pci_host_bridge_enable_device(dev);
void pci_host_bridge_disable_device(dev);
- remove tags because big change
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>

Change from v3 to v4
- Add Bjorn's ack tag

Change from v2 to v3
- use Bjorn suggest's commit message.
- call disable_device() when error happen.

Change from v1 to v2
- move enable(disable)device ops to pci_host_bridge
---
 drivers/pci/pci.c   | 36 +++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |  2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b29ec6e8e5e2..773ca3cbd3221 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2059,6 +2059,28 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
 	return pci_enable_resources(dev, bars);
 }
 
+static int pci_host_bridge_enable_device(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
+	int err;
+
+	if (host_bridge && host_bridge->enable_device) {
+		err = host_bridge->enable_device(host_bridge, dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void pci_host_bridge_disable_device(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
+
+	if (host_bridge && host_bridge->disable_device)
+		host_bridge->disable_device(host_bridge, dev);
+}
+
 static int do_pci_enable_device(struct pci_dev *dev, int bars)
 {
 	int err;
@@ -2074,9 +2096,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (bridge)
 		pcie_aspm_powersave_config_link(bridge);
 
+	err = pci_host_bridge_enable_device(dev);
+	if (err)
+		return err;
+
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
-		return err;
+		goto err_enable;
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
@@ -2091,6 +2117,12 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	}
 
 	return 0;
+
+err_enable:
+	pci_host_bridge_disable_device(dev);
+
+	return err;
+
 }
 
 /**
@@ -2274,6 +2306,8 @@ void pci_disable_device(struct pci_dev *dev)
 	if (atomic_dec_return(&dev->enable_cnt) != 0)
 		return;
 
+	pci_host_bridge_disable_device(dev);
+
 	do_pci_disable_device(dev);
 
 	dev->is_busmaster = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eefd..bcbef004dd561 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -595,6 +595,8 @@ struct pci_host_bridge {
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


