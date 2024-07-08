Return-Path: <bpf+bounces-34103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D7392A7EF
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7376D1C20AD9
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BD614D6FC;
	Mon,  8 Jul 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NI+K/tje"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EF14D2B5;
	Mon,  8 Jul 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458530; cv=fail; b=gSa0sdWDvDnjxoIGV7PBl8WYUghcm1g0ASCiKltM14fgciOnUcDKhCT4KsZxZ5ikrc/mxa9sTGtnNKJmckpk6ZE8aCYAeXt3DHEySlGwyZPifddknJmK7ACrDxu4Wnms2+8TZx+iabUtlm+o/acgtslMBnrfC6sd+rbrX6fWRbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458530; c=relaxed/simple;
	bh=uY2nkKpnICqSJW+2sUmrQ3bOtlLbsFdr36z79uBXDc4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t/72/Vv/3X3fw85ZFpei3JdrXa4eTHqveUhO1Yskfvnd5G/uepru0bqQF80Un3TLsukJL2bgGS8br2RIdwF9GwC3egRbu5EJuCTwAjt+04dAOQNcDGn+7luVL7BQkaeu1zvQ7rJtI4m7k9cFTTjnFJ4OYJHdQDe81d71hxALBNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NI+K/tje; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOcG4/S/4EGcCv+QoGnEP/rrJ583wwt8bONj/r8rLQWc/IhW3r8inP3cRKYN5jeUS5mzKklCXpGvTke6vHjluMBCKJsQtFAdLvOQ0CLnZ8bpIYYEAAnK+882c4A8Yoaz0wu48hT843iOWiRik8oi6xSYViSxJERRSGRTqkjDJSQzg/P6pr+SKVd5rkoa3th0dWzsKg0gNkR62N0+7zqVii6c5j9HZlOx5RT8EHn8BATV9KFF/Wrm14VVjdyXLQDvEPxI2/R9/SZ4Puj2dV0NWyAe99nDBbyC/4B8ogNQ9h7gzuIy2fk35IGXFIWxPVsxYEqDt1QPbmvv/OqLbOApzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLGT5OScu7UCDsM7cb5Chl0NAEoT1Tcskk+zbqTr/tc=;
 b=TUUrhOfkJZpqdS9Km3kLICTd4H11Ieuf4QPQDQTlhTdJ9EJ5DxkviGsDj0M2n+RUpkM7kMtvpAYmOs916KEen6RaRVX2kXQ2xPZwWzx4AFzVcv7sd3pwAV1wEl1BEKcylkM/+BbzxKRyZ3Hyy6FlTiQZu4Ln9mq9qPtxvfWS/8UCmS/oaajS6rz/klc2594+zY6VQtRbkL2LbFMaZOMCxSD/CRnyhyVmdgSq70mFUtevV+isECsauw6JtHBpnPkwx87UVQk6ws/NP7q8/RTeUEqfe96xeAUDEELg1khjkXRJ9681mIVZaaQLrx1WNesPugu+5Q6hf34h8nNLOz8iqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLGT5OScu7UCDsM7cb5Chl0NAEoT1Tcskk+zbqTr/tc=;
 b=NI+K/tje6g2we3Ac0nysLfeZU52F6VFsCK6PNfx3ogB4f2Nf9PYsgpJjw+8FlkYDVExE75A15Hdj1ToaNAzqC+sZZ2bWTSdojwghBFwkjClqMlWAeem6fi16Y9Q7FREN21OFpqJCasoVfbowNb0suXPWvuBbJZ2Yn66H15tRXYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:08:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:08:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Jul 2024 13:08:08 -0400
Subject: [PATCH v7 04/10] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-pci2_upstream-v7-4-ac00b8174f89@nxp.com>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
In-Reply-To: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=8140;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uY2nkKpnICqSJW+2sUmrQ3bOtlLbsFdr36z79uBXDc4=;
 b=EDO5dXKBwT7umEBVrJ/v/ee9Cq9EEDG1j+7Ja/DtbkQQt8sQdCIhMKH1kw3MNpgCFFTUNG1X5
 LoTUuurGIavAW1jkR3zK64i+7lzvYx8QNd7fY5i/Kfysh1BJYg5/Euu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: c218dc2f-56c9-489f-3805-08dc9f70a0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0lNWDZEbVZydGp2RWdxUTg2VDFNa3ZzNEd5M3VwNXM2OWVNNUgvckoySytm?=
 =?utf-8?B?ZVhqZ2NGNWcrUFF4azdXNmtSUU51N3Zja1EzNXlQRTYvQWVCdG1XaWthaU9l?=
 =?utf-8?B?R0hsR0lWazBqeFZHUTZ6ZFhLcmF5Smh3Y2grZ0YyYXRGLzdnVzVOY1gxUnFE?=
 =?utf-8?B?S2l3RzFicnVMcFA1U1NOaC95RDRCbzhIMVNjSnR0UFFkakw5cDdUcDI4YzBB?=
 =?utf-8?B?VUx5SG5HVUx5WTJaazAzSmVsRUluWXJocWw2ZHJrRWEwZDVaVmhTNllzMEM4?=
 =?utf-8?B?aHJ4RUEyNUQ2SHlIOXVQODc4UHM4QkYydEo0V2twa3JJZW8xRW1hS1VEQVBz?=
 =?utf-8?B?bDZRN2EwQ0YvZElPTU10Z0lKWDZKZEdVb1h2TUk1a2JFektRcFlkVTcrNW5C?=
 =?utf-8?B?dGk0cWdNeWVJdmcxNU0vaC9tc2hCVDIrWHJEOVFmdUF3ZGp2VDVWMjYzZVlI?=
 =?utf-8?B?VEw0OHJTVlpNdDd3dVQ0QUc3MjM3QytIN2NRNjVZVElkSEp6WXdCMlBvVzdH?=
 =?utf-8?B?OXFHdVJKR2VVcHIzS2ZxMHluNFdaM0hUUDFQZEJYdGtXdjFXVExOdGRwWWNE?=
 =?utf-8?B?Vk55UHhEbGMrRmJJUmZXZHU5ZjJxNWJtTGNUeHROMWsrQi9yZHYrdWpBWWNj?=
 =?utf-8?B?Yk5ER3cxMmFlcjJxSlErL3NwdDd1V0hhR1lyaHVVUnBVNzQ0RFNQRkNWWk9X?=
 =?utf-8?B?K3pKaXQ1ZVUwK3BkUXA2OXZOS0Y0Q1dWZlV3YTA5VEFaRXJLNzBOZGMyamNy?=
 =?utf-8?B?dUpNbEJycWVXaHNYMlN1ZFBDT2k0NEMyaVFRS0ZSZUN2ajMrNU5mREtLOVB5?=
 =?utf-8?B?N2N4Z3lSUldBNWJLb0NoTDRRWXU2dVFEZm83Vis2T0ZHbTVXanlsZ2lvL25T?=
 =?utf-8?B?TnZXQ0l0UGp2dDNGU1lCVEhZcVpFaXJMZUx3Z2l5cDRpbVV2S3BlVFhBU3pF?=
 =?utf-8?B?RDlqbml4bjE5UjBKSFhGSURHUVNFS0RhTzRFS2FqRFYyb29ZM0tranNzb1k0?=
 =?utf-8?B?VkRyenh6SDVaWiswUzBzVXJ2ZkhQT2xvWWxXVEpTbTlEc1BnVVZ5SlI5TFor?=
 =?utf-8?B?THE4cTJtVXVMY0JrUkRPa1VMTkNlZjVRZkVBTXJqWWZQNDB3dDlwcG8zZEcy?=
 =?utf-8?B?MHFObFNDR1p3VzJBa3d1bHh1NXk4WUJBNm9YTWRFNTV3aGNPaWcyaDdXYTRB?=
 =?utf-8?B?V3drRzRyYWpuYnNJMlZBeVp4Tmo5UTc5LzNKeW5rMitUWDNwNzNmdEVHT3RE?=
 =?utf-8?B?VGpLRFJlMlg4Zjh6Rk9nMDA2ZkxUQnBxU3hhWjlLdHpaSmxMaWZ1QXRyOUdL?=
 =?utf-8?B?cTVUL2toZ0c5b2owejA1ak41dmNkZm85S2hlNTloVi83Yml5MTFtd3dNMmds?=
 =?utf-8?B?aURtZVZva1R1cUJPTW9CdEVIWW90VTFSVVJ5c3dYRkFnOTNObmlQclBDSFMz?=
 =?utf-8?B?bndqYzFkSWJWMlBrcXNjSEVoUXQ4L1RGZlMzMXN4T3diY1RWT0h5SG4rNkNO?=
 =?utf-8?B?VTN3QnhlSWZ1ZHpmd2NXZlFSclR4KzhTbUdWM3A1Nk5adFpmSmZsNEkyNGIx?=
 =?utf-8?B?c0VQWWxWY1BjaU9JVExvYTdHUi9hZ2grWmt0cDQvcVphSnZ2d2tmS1FOSlNM?=
 =?utf-8?B?MHpOMnJyWmx0aFZpdVZlYUdUeDUvKzRjd1BhUmNXR0JscEhISG4yYTBzR3Z2?=
 =?utf-8?B?SWVldFJDNnFxLzl4SzAyNGhCTEZBT3Y5TFovOWFhWUhrRjZBYkJWZDl5aWcr?=
 =?utf-8?B?dlFQYTNrVTB4cmUydG9yeG5HaVBEK1VETlJ1VVpkajNRTlJPTDBXbjc2Ty8r?=
 =?utf-8?B?ZGY2ekJQaHVxS2x5cmZWR0JqVEdZOUQ1UFZOa1RULzNIWXhkYkVVdGFaUXdU?=
 =?utf-8?B?Z21jcjR6R3RxallWbEtEd2h4cU1LYjBlU3hsSDY0a0h3QU8xcXozQUhOYXAx?=
 =?utf-8?Q?rJYUKr95aS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1BPM1JqWnJzRnFEQnVuMWxpOXU0K2NVSkdMdGRHSUx3YmxlMjlOUy9LNUFI?=
 =?utf-8?B?QUhJWUQ5NHlZYzEza0tzaGRzZFJIbEd5TkN1aTJINUY5cEszT0J6TGRBWUlz?=
 =?utf-8?B?QVR2YVFHSStrbUxEOGlKWm1PeUFiazBNamhsa0FKQUhQaytNZ3JER212MW5E?=
 =?utf-8?B?dnh5RlFlM3R4Sm1Pd3VVRlBaMVdld0ZLSVE1UDhkMjlPYXVscXRZeHFBZWw1?=
 =?utf-8?B?dnF6cFhpZVBCd2RSaG1acW5QTnFzN2hGTWZzTW1jMnRreU5iQlRLZitnYWV3?=
 =?utf-8?B?UHFHSkhYRE5DZllXYlpMUnVLZEtMSmgxNm9XY0VuMXhsNE40Q0ZPZVRoNkpL?=
 =?utf-8?B?WlpPWHdQcWl2dk1nN0ROSXhwL0t1eEtzcDgyeU5yNXBKUWhjN1FvQ0dXVjJj?=
 =?utf-8?B?WjhJMC9jOU1OTk1kN0NrY2NadUxrUWllYmdvaGxUSGhDUkpKZUlUOE1YMzQ0?=
 =?utf-8?B?NVIybFRzODNPMmpjQ094ZUxpYnhWejN3NzIwYk56YVlEd1lWaXlCaXJnTGpF?=
 =?utf-8?B?eSsvd0VCWUFWSUE0S3pocmZzZ1NYR1g2RmRsQU02cVYxa1dsVzRJOEk3bVhD?=
 =?utf-8?B?ZXgvVXoxUUxnVnd0dUMxdFhqMGhHQjd5UkRZMmtjYVY1ME95Q21CcHN6MnJk?=
 =?utf-8?B?bElFc2x1bDVKS1RvNlk4Y295cDlmeXhwNHJOZFJqUXNiSGpVNUZ2OTMwaXI2?=
 =?utf-8?B?QUdVZ1lRd3RTQWJRL0NUYm5RTkVxSDJRSTV2VFc1N1htR2JaV04wTllBZ21B?=
 =?utf-8?B?RGxyd0JNMmRvUDBBSkdzMklQb2ZDMkYva1RtRFJBYzM1RFM4SmJvVS9QUEJK?=
 =?utf-8?B?NncwQ1BNcldCSFl1NGdmN0piNklnVkx3OEdORHZuWUZBSTBtZHd2M1EyUW9s?=
 =?utf-8?B?aUkxNVdXOEFickMrRHlTOUZiUUVRUFh5bzB1bXJLWHBuOTZ1T2p6N2ZSUHZO?=
 =?utf-8?B?TGhCUDR4SnhsclNaeGh5WFVqREdhS24zZ3dXaU9xdXVOVHgzcVdxTjFxVTlJ?=
 =?utf-8?B?a1pVK3VQNWdMdS9zcW1tZjlMdVhubWhPTWhndSsyVUttaHR6VHV0YWs4cWZW?=
 =?utf-8?B?dVJrdkd2ajZJOGVlbGlZWEoyTDg5RWJvbjh5NmwrMXpxQnJJc0RUNmpFaUxB?=
 =?utf-8?B?OXNtNzJQa01oRFVSMXJ4dmdVWDMzSWtMamtVOG5SejhoVUdPem5odzV2R2Qx?=
 =?utf-8?B?S0dJV29Jd0VqMU5ZU2tBRyt6a2pXcnR3aG5jRVFlUkpLenNFalJZdlFQdFNi?=
 =?utf-8?B?aDh5RWxHUGNSakZ4eFNScm9FTzljVGVQWEl3Ui9hdlMxcDFMYno4UmVNMTN1?=
 =?utf-8?B?OVhKeFQwTVhqeGhBNWpuQVFCaTdyWkJjTE9ueExjRHFzUWsyd1A3aHRJZXgy?=
 =?utf-8?B?R2JSVW04S3VJZ2VRUVlCckZLK01IWDdhUXlNNDVGU1ZQNmxLWmlJMDgzdnVP?=
 =?utf-8?B?UmRWOThSbjhiTWtXbFlkZkJGQUZhdUZrOE1BRHkxUmw0Q2Rkc3BDMWJrOW10?=
 =?utf-8?B?bmpYQWdvV2M4eml1VWkrYk5EVlFVOE5PNXFFdWFzanBxWlJnUjlqNDZMdTJN?=
 =?utf-8?B?eStvREFyeGNKVHF5UTROZGdWWTlabnFHWGRJWDVDblBQMzNIYWtrUDF1Q29V?=
 =?utf-8?B?OUtKa2Q1RStheXBocDZHN2VhV0tkOGxnQTZXUlVoWmFPeXN0OWtsdjZBKzgw?=
 =?utf-8?B?ZGZ1Y0gxdVkzekJlU1FHa0U5V1dRQm93Z3Q5aEdaaXdSV3FpNmVvWlpBNUpU?=
 =?utf-8?B?Slo0b25PSzB6WWxXcWhUdmdDWGYyNEs1NWhNZ0hCZEhIMmplNyt1TTZqWTVn?=
 =?utf-8?B?QzMxR2ZybVNDTXpjMGJWeHU0OEgrZ2FlaUVpU09meVFiL0pGTzM1aG1LT1NZ?=
 =?utf-8?B?R0wrRk9WbXZNaGVlb3k3QjBLamVvajlhbm5Za0ViaGRzNHpOc3RLaXdNeW90?=
 =?utf-8?B?dXhPaEtqbWdMV2FCOXh1cExLSm1OZkNmSExxZjJPT09zS1FrTXZ5MTcvQVcv?=
 =?utf-8?B?UVdTRStGZUdVc1ZVT1RGWjczb0RDOHc2Z0hjNjBKbUJXMEdNTUxveGJqZW5u?=
 =?utf-8?B?NDhCTVB5aTRsS0d1eGZJdjBXZU01NjNPSkJQbnpqbDdScEdYRjlLSVQ2V1ly?=
 =?utf-8?Q?cdtM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c218dc2f-56c9-489f-3805-08dc9f70a0b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:08:46.1960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWrPERT6msCT4LGNyWYHxZv/Mve8ipaSDgIQQ9iB3YX8lqM4G7TReltt/OqH7tTC61WDcPjFRfdafcn6h4yNsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

Instead of using the switch case statement to enable/disable the reference
clock handled by this driver itself, let's introduce a new callback
enable_ref_clk() and define it for platforms that require it. This
simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 111 ++++++++++++++++------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 47134e2dfecf2..dbcb70186036e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
+	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 };
 
 struct imx_pcie {
@@ -585,21 +586,20 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	unsigned int offset;
-	int ret = 0;
+	if (enable)
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
-		break;
-	case IMX6QP:
-	case IMX6Q:
+	return 0;
+}
+
+static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	if (enable) {
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
 		/*
 		 * the async reset input need ref clock to sync internally,
 		 * when the ref clock comes after reset, internal synced
@@ -607,55 +607,33 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
 		 * add one ~10us delay here.
 		 */
 		usleep_range(10, 100);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
-		break;
-	case IMX7D:
-	case IMX95:
-	case IMX95_EP:
-		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		offset = imx_pcie_grp_offset(imx_pcie);
-		/*
-		 * Set the over ride low and enabled
-		 * make sure that REF_CLK is turned on.
-		 */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
-				   0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-		break;
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	} else {
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
 	}
 
-	return ret;
+	return 0;
 }
 
-static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6QP:
-	case IMX6Q:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_TEST_PD,
-				IMX6Q_GPR1_PCIE_TEST_PD);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
-		break;
-	default:
-		break;
+	int offset = imx_pcie_grp_offset(imx_pcie);
+
+	if (enable) {
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
 	}
+
+	return 0;
+}
+
+static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	if (!enable)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	return 0;
 }
 
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
@@ -668,10 +646,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 	if (ret)
 		return ret;
 
-	ret = imx_pcie_enable_ref_clk(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie ref clock\n");
-		goto err_ref_clk;
+	if (imx_pcie->drvdata->enable_ref_clk) {
+		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
+		if (ret) {
+			dev_err(dev, "Failed to enable PCIe REFCLK\n");
+			goto err_ref_clk;
+		}
 	}
 
 	/* allow the clocks to stabilize */
@@ -686,7 +666,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 
 static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx_pcie_disable_ref_clk(imx_pcie);
+	if (imx_pcie->drvdata->enable_ref_clk)
+		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
@@ -1475,6 +1456,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1489,6 +1471,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
+		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1504,6 +1487,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1516,6 +1500,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
+		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1529,6 +1514,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1540,6 +1526,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1551,6 +1538,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX95] = {
 		.variant = IMX95,
@@ -1577,6 +1565,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1589,6 +1578,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1601,6 +1591,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,

-- 
2.34.1


