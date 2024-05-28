Return-Path: <bpf+bounces-30771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0238D24E2
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA381C2716A
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846B17B41E;
	Tue, 28 May 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SWd7kaGb"
X-Original-To: bpf@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61217B40F;
	Tue, 28 May 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925183; cv=fail; b=ngeiVAgD0Vm4rggbKc7PsQbp+VrgHy+cT7RjnQwdojdy1JJBVkZqihpkRlqi5fElmH/XHYaB7EHaGA9HsWSwKZq/hKPQsIVwC/YkGUPksVWbYhR+2pJV7G94zUmk4nEVlrvSKTsY8GkrNUEuvcqAyeEEQNKAQ6t9PtaHOIyTqLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925183; c=relaxed/simple;
	bh=xuuFZZmFwLzfr3EwP7rBkaowEqdCoyLdbmk+g9T6uJ0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EuiMfqLyJ0dPKTExdI4XuVjNLzhcl2FsUgOilh9fREnWHc9uscVm4gmui7qSw810z3Gt4waqOglsTj0VPzGnnjQa/JQtOvwB5pIHsCQiWZF2gRJbw5qk1Gye3qD5+aEbjhvmBnIxC5dCQ4lgti7lFSK7HPrmE6hcntGPLIunVXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SWd7kaGb; arc=fail smtp.client-ip=40.107.15.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJcotbGmPoo5xFqMSYaJgETR4PvotE8wYYogbxCfBmuXzWII4eKXl4uzQVxJVtbWFGJpT9tLBe3vqKxKi8civD0jN9rf2lX+nsmd/rCzkOzBuZip3vcmQj1pfBloS/Tvjdjrv3vK168PqRFUiDsi05RpZXD81IdPUgWOHix1V0k4WWC9PNx+T/639xGRZEvBEdJsKyi2YYzWkb6WBnpCKocBjejZlEgavZryU26UegOPqYlKOPuJmQxGrXPT36IOtmd7a75OuW1OziM9axkqPUHfIpj+6J7kLPvlEg4EY8z5QerYd4WW7yFK9b+YTyqPGjaDrR2iIaeRwAUrFnGpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gusIGSYkHi6d8e7/P6xrgDBiBJjdKRaehtAk6+gU0hQ=;
 b=ETHhJLg7mVw7VV84+ktTsocU4vguU1OIP1l484rKaih2+3Ge5o8FVT2mXHsIGbz2s4xElub68SWYxDAX5yOwNuQN/rwViTsEG4eoKONGcDpOOh0s5M//OQ2BzDmI6WcLVaDkLsHklDHVkFtB9YKYDiEdH4+VoHPhqFSIJsxP9JSjzDsunWZRS5nItn/07L4XA5R2WBFAUekYStJFmCGuzPpYWUUcTAXwIlHQ0wUdpj84zyKbxNcxIN2jMf9U2uHjGg69GfbPqrWNf3ONXAbXt3ti8Simwnx0vgx+c2r/EjLCFAjGlsdxoXBrR0REsNMqwaKfkevVN9F28JxBPyxypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gusIGSYkHi6d8e7/P6xrgDBiBJjdKRaehtAk6+gU0hQ=;
 b=SWd7kaGbr+dnGELY1QS+aR4z87fxX1u0Kk/PpY9tXorJFOV4/+g0y6NX+e0ktg+OYjOZj0KULSqotZunnC8aj+rM1INfierfi3X7xQerIekGf0bb3N6k2f2qnRWjMEXzfi3X/pNaNu8DtjmD0hQfHiSrUlYaKV67y5APunhT+MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8663.eurprd04.prod.outlook.com (2603:10a6:10:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:39:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:39:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:15 -0400
Subject: [PATCH v5 02/12] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-2-750aa7edb8e2@nxp.com>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
In-Reply-To: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=1357;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bSLzEn4WP2o59goDiJt0y+MAE1L3Qob46G2eyxAvsHE=;
 b=IHsNuLI9KEzqmFrZ9uY6rFIOIDEULpHj4gLoVzwGoipaIvI15rHqC4QksTp2oodPmdD7HuDc7
 d17TQt0FG1pBL5u+R0mkEO2BIJ6O4ip30Ooc+UIQWrsYCI9tJ9EghA3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: adb3b20d-afda-4ae1-f692-08dc7f4de982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|366007|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3VmdDRhTUNwQnFNSVlaTkk2Z0lIRDZTckwvZldtbzdPQUs1Y1lzM08rQXlI?=
 =?utf-8?B?akowcUdxbFl4eHpMRG1YOEV1SXdKdGVGUDkrclVpNHJiMGp3Qk02Q0p2U29G?=
 =?utf-8?B?SThDN21vMWYxMVlIQ3V2aHBuakwvZDZ3Q1lwcnpFcmtMWDJsY2tWK3kxNHF2?=
 =?utf-8?B?aGR0S3ljblE4cUdFajZEYnphWlFycUcwdlhmcVM0SThiT0UvV1BFdlhveko0?=
 =?utf-8?B?UWlrSGJPL0FZSEdDOGd0R2tybi8xOWM2bS9yaGlpZnhRMHI2TW53N0I4TG80?=
 =?utf-8?B?YUF5MlErQ3cxOGU3enQ1V2NPQ3dBODBZKytjNWh3eDlVVC9MMXdrR2dZTkkv?=
 =?utf-8?B?UmE1TWtzTGNuN0toZXBWaDNGZXBtRndRTlN3N1J2dUJVbDMzZnA2ZC9QbHcw?=
 =?utf-8?B?MWIzV1ZzcXRWckZ2WWhVOFlMaE5MNm02enA0dG5zZHN0T21IMzJEQk1YRFVv?=
 =?utf-8?B?U0JDZk0xem9WVElKOER6ci9hc3N2MUN3Z2tnZHR4bjhWNmhheVg1TFlFOXRM?=
 =?utf-8?B?NFcxZDNleUdsSEhhbytDWFl6ZzZ4T1Z3VmVCcUg1SG9yeUpEZ25ibGtHSG9x?=
 =?utf-8?B?aFhkeWNxdUF6ZjMzL2JWMXl4akVjdTVkcGpZWDN3ZnlRVVIyNXJhWE9Xby9M?=
 =?utf-8?B?UUpUT1dzRndkRUE5V290TzZ2RGRhOWV3V3R1VlFuMXpEWTNmOWtqYXIzd0hS?=
 =?utf-8?B?dUlJS2pEbDYrVGJhVGZQb1gyR2dYN0FCU1FQbHlpVjNaT0kvbUhQaHB6MTRC?=
 =?utf-8?B?TVM0UXZFQkJFSmJDVUpnM09uZzVGQ0FNMkExVjR4RjE5cDM4OUpoeXNpZkQx?=
 =?utf-8?B?cnBrNi9tS2xya0ZYdWtRRjViaWIzc044enE2bHNoZGxCVys4NXF5M1YxdHJP?=
 =?utf-8?B?T08zRkZpOFd4YTJ0elc0NDc3WndSK2hqQkNkdGdjNUgrcHEwQ29OVDI4RFpH?=
 =?utf-8?B?Nm8yUjBiOU1KYkpBeWZkTFV0TzlkV2taOXRDbHcwOGpLRi9vdWtSU2tDYm9u?=
 =?utf-8?B?RU94dThXeW1QbVZaYjN6MHNSUC9BTHVLR1pjVG04MUU2N2tNellnSERiWFc0?=
 =?utf-8?B?ekpKamIzM2pXWUJlVko0a0RyUFNkdldzUVB2YmxWKzVjeWQ4dnFwalhsY3dG?=
 =?utf-8?B?WHYrc0RVM2I3VUJ0Z1FwOWZCVVB5SkFid0J1NkdtTnZHenA5WUFUS1J0RktL?=
 =?utf-8?B?MTg3ajRlUmlqSnFzaDZ4NlpPVlBSZkhvQVhrS1J6dnJlN0dWZ2Y2Z1lNKzRt?=
 =?utf-8?B?czZ1QlpOSS9FWS9ZUGlLZ05hTnZlNjFXYVgxVHV4RFAyektLbTJJcjgzYXBy?=
 =?utf-8?B?Y2Y1cldRVHVDSkZCRnhhazRIeERkNEFWd3BUWE5CYjZQekZlN05iWWVUUDMr?=
 =?utf-8?B?eC9oa3dyR1NJTEFIL3JqRWdKK2hPMEg1K1k5aHRKaWxySjdsbFo2YW94dlNi?=
 =?utf-8?B?RkkzdjhuVm5ETjNkR1V0ZHUvQ0Z6YWIzMHNiS2J6cUVlWEttdEhIelVmMU9s?=
 =?utf-8?B?UlRyN0tGRXhianFZVURBS2Z5TlVFYnBGMVlsTm5RZUQxNFNSN1FNTTNvUWRq?=
 =?utf-8?B?RlBwTXFGSWphVHRKcHdYYi8rQVp4OXJ2RGFNMkpnMzFCOFJwOFRWcmFPb0tl?=
 =?utf-8?B?YW1PZkxKTXZxOHZNYk9lWkpybm9xZDFVV0lDejg2TVdjMlgySnVTeDVpTk92?=
 =?utf-8?B?b0wxcTY1WGh4a0poaTBYaFhpRWoyNEZ1R2xtLzF3bnk2OHkyOVIzWTd6SStr?=
 =?utf-8?B?QXZYaG1BRGxqK1c5dEZFSStjQjF2aVB0VVhhMHA5OGwrSVJya3JXMjBYMzZj?=
 =?utf-8?Q?hxMLTbHNqFxtV2kX55nYYjLYO5uv32kKDV2s8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWM2VnYxdzhYQkRKSGczbU5KRGd4NHNkNytRTTVLUzk2cjJlaFg0MDBFTi9z?=
 =?utf-8?B?bzVOM29ubnlDQWNXbnhrQitJSXZQbVY3b29GOUNzbERQbGw3aUZyaGM3a0NZ?=
 =?utf-8?B?RE5CN0ROYnZzNEJTOUtrMGEzUEtMYkVrMWZ4SkcwOWNGeUJDeC9xOGRXQ1gv?=
 =?utf-8?B?cGRFV1lpZVdTZ0NZSUM4RVBXMlVEeDhmeXJkOUJGVlUzTFl5RnRKUDdqZGJo?=
 =?utf-8?B?YUlFWVZnZWo4QmNVS1NzSVByckM3N2RGWkRqMXIrOEx5a0ZXeVFXNWlpaHNB?=
 =?utf-8?B?THNtUHBjR29JYWVQcTdYMGxxVnhTUmt4dUlJWjNCUEZ2UTVZbE91d2xER1Rn?=
 =?utf-8?B?eENtSi81Q2lGdVFzVWpXc0NMNDhaYmZudElSaVRNU0FDU2syZ3ErYzJKbDJ6?=
 =?utf-8?B?czVaazk0b0pVM29LREV1MTFxQ2UwY0xDYTVIQ216VVV3emlac3dNY0diZDNG?=
 =?utf-8?B?b1I4bEdoeGJ5RlRNcWl2RGpFY0hQdU9tMDZodzJVUHJzUWx2WmlvRzJMSnNV?=
 =?utf-8?B?Vm8xZ1NZdHQ2SkZDVnJxb0UvMGpoNEU2YWhRdkVqcjlXeStsbXFLVlJFOHIz?=
 =?utf-8?B?dnkxMXBMTE1OZmgyaW5RWEQvNU9aTkdYQzlYSmN6TFJOcTY0Skhyc2pWY3N1?=
 =?utf-8?B?eGdiZFdYakRVZUlMQ0I4cGE1TXFuaHJwZ3RncEJ0Z295emdwZWpINUVVanlW?=
 =?utf-8?B?UW90ZzFsR0FzazljZW9rOE44U3lETFJQbWhadUkwMWIxb3IyendhZHhXMStj?=
 =?utf-8?B?WkNQOGhjQm5LQkFtSXZ3V0Q3YU9UNzJWem9odTJySFhTeU0rNWtlOEJBZ3FG?=
 =?utf-8?B?TkYyRHUxMFlrNHFtMVo2MnNnVTZNb3k1cFhZRE9rYTlxeTdXVWo2SjdSYU4y?=
 =?utf-8?B?VGVMaG1vMTRsOGt0RUxYb0t5ekVCZHBIbG9uNC9GandTQlo1RHZYbmd2QkNN?=
 =?utf-8?B?V2hxTEJYWU1GcFlyM0tESjNReHdGTWRrZVlxc2xSWW1aOGJvckxTbVNJd1c5?=
 =?utf-8?B?QVRtWGh1L3cvOEduZm5qby96a0d6cTNiSmhkeHJ3TlliNHlvNmNGV3dMV0M2?=
 =?utf-8?B?YTN5T1VRSlY4Z0pycGNzWjF5cmhJOUl2RXk5bVN1SlFvS2tnTEpKNlhPeHRq?=
 =?utf-8?B?RWM3ZVk3SkFldFQvQ3dvaTFLbDFuYlpiVSszZWNnR1FFRmFjeldjK1E1amNB?=
 =?utf-8?B?YjZmbGlJeklvWWF4VHd1NU1Od3RPOFhwRkpGellyZGlYSHh0YTBHb0ROK2gz?=
 =?utf-8?B?NldTNU1kbnZ6bm5XR05ZeHExTDlSOCt0MzF5NUM2MjVGMWpzQnNXK0xTc1Jr?=
 =?utf-8?B?RjZvL2ErNm9lSkU1ME80Y2NLYjNyY2w1cW82RlBlSDJ3OWZ6cHZWbVZmM3BQ?=
 =?utf-8?B?Ui8zV3JWTDJJY1llczdKREhES05UcjM5MEY4bTJKRklxaUdsbGo2RHd4azdr?=
 =?utf-8?B?QmtCZS9hcXd1bHY4U1FSVVpQZ1owUDFxUWRsYUxYUExxUzRKZ3VkUDR1ajR5?=
 =?utf-8?B?V3BBNWN4OGZtWlorWmFYak9CVDM1ZFBRclF5cmkvbkRRL2k5a3BlYk91b2Yr?=
 =?utf-8?B?d2NzNmF5SVBCVnNqZ1pyemtjV2FCVWhYWnVUcEJPU2lqbUZIdDB4V0VINWtp?=
 =?utf-8?B?Qnp6ZVJvVXVTa2hwVUZpUHZHRlRKTnQ4dzRlRTRTc1NWeHA5VlpMZGVQby9P?=
 =?utf-8?B?WGMxVkI1SzBaNFpXNGZkRGRTNll5a2NNcVh1UTdiQ0JyakdoSktuaFpKR3pH?=
 =?utf-8?B?d2FvRTlFUlNyL1FmRkN5eEhvS29ZUlRlT25VVmphYXA1anZPRnNITGVoOHRI?=
 =?utf-8?B?dUs3TC9RVGsrM0hUMkpjMVI1Vy9HZWxkTnA2QkNWaktXZldzKzZaeGlPSU1v?=
 =?utf-8?B?RWpGTEVibFJiRG9yR0RIVUtjQVI4cXJ4SUhkb0lzMnk4K3E2eERiMzFKYzNE?=
 =?utf-8?B?UmJqNWNiRSsyQVhHd2kzYzBydTZaaWc0VXBRd3J5eWpZemRVWHJ2WENkMzlW?=
 =?utf-8?B?VkFjVGUyTC85OUYvd1R0MzJ1cUwwY2pqc0t6Yi9yMXNNV09aalFTS0p4WXcr?=
 =?utf-8?B?TUFxQUdUSHYrSW5nZ1VlZVo1Z3J2Y0tHb0hGZTJMbmJjdndSYURvK3pJTkVY?=
 =?utf-8?Q?VGkk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb3b20d-afda-4ae1-f692-08dc7f4de982
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:39:38.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pojKYAdk7pH1sdqgZsiDHqjyHbNPleQIDW01QSHE8/qbHLL9a6RbmGBlSRvFLdgkMhQ6zglxlqLFBTHSboQGbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8663

From: Richard Zhu <hongxing.zhu@nxp.com>

Correct occasional MSI triggering failures in i.MX8MP PCIe EP by apply 64KB
hardware alignment requirement.

MSI triggering fail if the outbound MSI memory region (ep->msi_mem) is not
aligned to 64KB.

In dw_pcie_ep_init():

ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
				     epc->mem->window.page_size);

Set ep->page_size to match drvdata::epc_features::align since different
SOCs have different alignment requirements.

Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e9a16083d79d8..282261b2e28e5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1113,6 +1113,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
+	ep->page_size = imx6_pcie->drvdata->epc_features->align;
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");

-- 
2.34.1


