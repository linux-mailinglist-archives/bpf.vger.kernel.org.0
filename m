Return-Path: <bpf+bounces-30773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96E8D24EA
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA741C2671D
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03517B4F8;
	Tue, 28 May 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahh8OiZh"
X-Original-To: bpf@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC64178395;
	Tue, 28 May 2024 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925193; cv=fail; b=Q+Hj1uwcbBvm4uojrY2/ZNSFWKSAEdSdPdaiTvsN3Sh7OS9D3GtX5hFu7WJmhcDIHv672AGmkdfkUWeyGSCvcRjeiiXG9P0YRhxTeXo/s7hUNrMlf6zzc5HzWpg4g61nLToQaCu04iSmxnJwCVi+S/yFSe6Y7F9hidL/W/PvSCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925193; c=relaxed/simple;
	bh=uVycvYKF9FbcM4J26/0fGgPxT4dBZOyMSszVrgcFckw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nejHpDOiymFTBS0s1RMOJslZz9Tb+WjHdJtENv1q0t9pKmF/pzyLmgqdP07ZTemZu64jo8s4qYGPop8RN1oXQLWj+PfJ7lKefEdu5nHeARztAlfCnrOhPSWWzDO73b8pGcDoAJbYAa8uuINMx1jZr/4UiFj3kpU86QVEOt1WXY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahh8OiZh; arc=fail smtp.client-ip=40.107.15.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndYyou8g64WWso8Tblsjr6c9zumSXkatzyKLm9N/eN3fmMS1S+/2LmDA5GJyn2Dg7IUm1qrnPr8Ix6DybL2qfRD+hq9+elzv31aDVUfeBn0cgMGgWjBc5IBN1COVoas90Cb2Y4T3bmia45zo2lwGXoZyxwjBB4TGjJSHYOT8AaZ8CsngotzEuieRXTUCRcecm+JP+Ac1k7UQeo4Hqs9tIGM3IQZ0D3el3QHDFmtmR5j52d+V9HjuwlN4OOLuyyqkR2DMoEUfhO3vAiHWGvniAKG/eCKvfwyVBkTcq+QT59AhpZTA71bOtEAwSWzVzaOnO//T9mxgqnfG9d7Kyq4GcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XrA0LI3S6lI8lMmP9q8jfBHI3r86VK5vf/jA3slmco=;
 b=OjecnZ7CsEXQXhohfe0qGzTUsjeFMJ+rPDEVtBxH2HEFAIoeASstL9mjE+lTnCZkm0x0C9YsLiXNd35NcuW67wIcogkmrxlJeejKTN7wLmsgBJQjPTjVYQYBcEemayEOKj8+7s1q1fNFiLCqmCd7LeV82LDEInJ8w0KXfx33D4lsAZ+GvMzBtBbVKwAUrCB/fH6dsP7S2IQ1zbwJFdmHk12T4RuMuwGuIwlw9EkQCNRc+XkxhbR6sJp0+sfkmm/iejiIRZ3vVK2GRumMovx3WEbLYy1M9wXy5UPzfwb9AFIrTe01PkW65YeJA+HI5waNrnOlsMneojd4coPOL94YQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XrA0LI3S6lI8lMmP9q8jfBHI3r86VK5vf/jA3slmco=;
 b=ahh8OiZhVMGZ5m6qxf9ylrcjP/Sh9hQdgK6/Ji7FXAxIivO1hbV+dC6ibmck15LMwpmV6d7K9nPcLEvZa7RXL80X62s3IHRF8MPOftFW+VwZNUWkIh/8j9L+pZz8CvG2XP9zgqVzMzFB4EIlimaYYG+4hio0YSyOf6JSSfqhOBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8663.eurprd04.prod.outlook.com (2603:10a6:10:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:39:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:39:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:17 -0400
Subject: [PATCH v5 04/12] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-4-750aa7edb8e2@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=8294;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uVycvYKF9FbcM4J26/0fGgPxT4dBZOyMSszVrgcFckw=;
 b=odTATAD5k6ayQYWiquc9kJXRRrmKbdI9TBGzu42GKzFryO68gM+vr9AoC7HuluSNT4Ha+m6/N
 V3zfajsk1mqAkCrx0U7SFb15GfvLf6ZC6F87WRMDjYjPwsxS5Psp2F8
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
X-MS-Office365-Filtering-Correlation-Id: 91ab0a38-338d-4297-0205-08dc7f4df04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|366007|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjZhbFNKcTlhT3piV1RrODRzSzRhVU5KY1EzWloxUzd3dGN1ZGZoRFZyQXBK?=
 =?utf-8?B?dFhMbWgyMHJoUHhMaVhzTEowRmcxZ0ttQVN0QUM1Q052SWVQaDZuMm9qM3d4?=
 =?utf-8?B?TE1aNDEyQVoxMFZkVU5OWS9IWWd1QXVRd0lveGJ5QjI1U2tzMkpxV2pVYUU2?=
 =?utf-8?B?em1KVlFtenVNRHRhMVZLN0ZlSUJVUHNTdExsM1FGK2lXVG9MMVdhelR5QlVh?=
 =?utf-8?B?NDJjQWliMTN1Nko2c2VMbitJN2w1MWZVN2pYTDJIeWFBSXczUis4bHdFZytj?=
 =?utf-8?B?ZEFXUE94ZFJrc0dpN2ZyUnpseDcranhjV2xUZEgwMVhVeWRDOHQxdHZMbXJa?=
 =?utf-8?B?UEU0SEFxWVB2b0p3TVZqeW83d2ZjQUJUN0dFYklmejEvWUtFQUdyQnRVZG8z?=
 =?utf-8?B?R21UNDNjTGppOUV3bkhKemFCRC9kejVNZEhFb29nRXRwNUEvOUYvQTFBVHRz?=
 =?utf-8?B?a2NtYUI5TDFodU9aOGFCM3VMdDJYM1hhekdpeURjZVd1TEJkK043QnVXOHNu?=
 =?utf-8?B?NlczOWJsTXRtZ2VyNkUvajcyakZKMkdGYk1BbGdoZDJseE53RUtTMFhIRU9P?=
 =?utf-8?B?Vy9UNFNRM0FiLzBQWVhaV0Y3RlE2THZGaHRNc2pNU3E0ZTlMeXlERWlJRDFl?=
 =?utf-8?B?ZjFpS0QyZEpRaEZ6V3J6TXZPTmUwTm1vMU1nTTM0UTZoOGQwcjY0d2ViYTYv?=
 =?utf-8?B?QkYydHF4Q0xLRFU0SEZCSStoYVNwZWp1MlFJNk95Y2pQbzAxa09CTkQzNytX?=
 =?utf-8?B?dU9ScTkxa1BBVG1LZFRnaExDK2pNNnZZMDBzS0lrcmpSS2pqL1JGUnI2bEVt?=
 =?utf-8?B?WDFuUERhalM2ZE1JeWtQYXBibkIvaWlraEI4Y2xmejFlcVdJRCtDZXg0cU15?=
 =?utf-8?B?S1BmTTlteXZSVkVjenZzdURuL2tPS2hFN0hyY3Arb2pPUmpiRnJlc2hBNTRu?=
 =?utf-8?B?Uy8ybkVITnZyY2NJdnNReXZzNXJWSDFQVlRhMWpXYm5oUEtpVG9hS2ZqTEdV?=
 =?utf-8?B?b0VJaEhjdEpNb2VDT2kydi9FTDQ4V3NhOXlqTitSR28zVnMrNXJGZXU2N2h2?=
 =?utf-8?B?MXE4cjJScFhXT2dSdHF6TVVaQkt4TXF1WW10KzUwdmc1bW9keUhBejhxUXRD?=
 =?utf-8?B?NVByQmpxcmhSMVhsM0VjUy9RWkxPWENodVQwbHNQbzV5citFWjIwVk84SnZM?=
 =?utf-8?B?S09SOXFZQWxUWjNzRUJ6S2MvWk8ycDhibGlGM09BTWxFT3dXZWtoODFyTGlW?=
 =?utf-8?B?V3BUU3VaZkN5QWxQUjl1R09aaUtWRFczTkV4WE56MnN4Y2ZoZy9YM3J6dHcr?=
 =?utf-8?B?WDVDazZBbjV2bG5WMWlmMVJBOTRjbEdjU1Jhb2RUQVBIdDFxcmpuQVQzWUMx?=
 =?utf-8?B?UmRNQjgzTFFOOTRVYjJGOXRTSmRTc2pxRzhmZGFIc291ejcvemZtcHh4Q1VZ?=
 =?utf-8?B?UHpOSWhsYUU4UTdqZmJIVFBhT2xlcmo2ZkJEZkRvSTYySjlYa0YrdExJNDB3?=
 =?utf-8?B?VXpwUVdkTmlxRUdjZU5aWUltK0RlZHlndXpickhaeXVqUTVnWWxFUVBWNDZT?=
 =?utf-8?B?eGZWT01nOWhqZ3FqZGxneXZ1eStzeStCaHQvdExWWm9SV3FMc3RTbkJaRHBG?=
 =?utf-8?B?cW5HQ2pjQUZoMVF3ZGlzS0pIQWRQTW54NjFNMmpQdkREYUUvbHRpNHFpTGFp?=
 =?utf-8?B?a2x0ZFl0VWFValhIVTJRcVFjUUUwUnJLTkZLUC9ReWZxYzdnQWhCLzF4dW1J?=
 =?utf-8?B?OGNONTcwYlRHQ3piVGpob3AxL29UVEFlR2NHcFY5YmE5YXlKRzIzTmhvN2ta?=
 =?utf-8?Q?/sc4NjUH1Kvafe7A/+BoFS9RbrKnaBu1Imohk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NC9LK3JmMVZWYkJSQjhPZFIwWmtzYWwrVGFtc3ZXK3AzNGdDaWRuVnF5NUdu?=
 =?utf-8?B?d0pCMnFEV1lram92MC93c1FGSWt2WXVQT1A1N1c4ZWt4RVhIWko0MWJsS1Fq?=
 =?utf-8?B?cnNHeE56TW1TcVdrdXFnQXVQZi9mTFZtMVBydFlYR3c5MmpMbjgxTCtiT0N6?=
 =?utf-8?B?Q2ZKeldTUjh4R3c3bkV2Q1pKdXJWVHRLOEFUd015aXJ4U0JWamhucytIY0ZJ?=
 =?utf-8?B?REZHWFBtcnVuZnp2UlhHc09NTkt4NytLYkVreXNNRC9NM051N0t0SEpPcldE?=
 =?utf-8?B?Qi9iTk5uV1NjeTdBNUk2MXRzOXNFZXNCdVJFZjdCelNjLzdGcmpncHI1MGQ4?=
 =?utf-8?B?aFJxV3B4Q3BYbzdkVkdKOHNhQ2ZGaHdHZkxvZm13djVsbVRQdTVOYWZiVGJl?=
 =?utf-8?B?V1dzUDBqTU9OTHd3R2p2Tk80cDhsUTJITVRKNElWM1JNYWZqOEdrKzN1THBM?=
 =?utf-8?B?di9RRU5GODg0d0Rkd0VHM1B3dWFhMnI1Z01GY0NyY002SmF0RkxSR28yRFZj?=
 =?utf-8?B?YWg1RisyZXJob1NjbzBNOVZJMHJoOHVNSEYrSVJxZ295OTN2dmlOY2V4dnhq?=
 =?utf-8?B?aUdLa3FGcjZ3R2h3WWNVeXQzaWdUbWxyV3pVc2VTR2FTRlFKbW5PekZaL3ZI?=
 =?utf-8?B?bndnNHdWYXp4ci9WVzlZZDJaQkw3MkhoQmFqR2JxcUVrYllQRDMvM0tXMCts?=
 =?utf-8?B?TUdLekwwOFk5TzZMS0RvMFltRm9Wdys3WWljampGZFdNd25YNXZ4WndVNldt?=
 =?utf-8?B?bzVzeVd6SkxjTjhETTJqVktFZGRVRWpSWVgrVnpkaVRsSXVjUllXYWFaVnF2?=
 =?utf-8?B?TVZuQjRtSkxBRnVGWWF0ekJtMDNlVGZidDIyVkNWWitnLzBVZkJGK0sxUlpT?=
 =?utf-8?B?WXBRMncxckxqWmRwbzEwV3JGOWFPazlWQmVpRERQc1hpbXd0c0lhY25FUjdI?=
 =?utf-8?B?RHhDTForc29NVC9Mc0k5S1JpME1pck1GbkRQNUUzWTQ2aXVjY3NWaUc1bUFN?=
 =?utf-8?B?SXMxNWJxbUhEdW5lTjliK2lqcUVZR0hwTjd1bEpUYyt0OS9YNHFCSmZ2emFm?=
 =?utf-8?B?bHhsZDhFYTdYb2Jmbk1pN21HOElQeU9TeUVLVmdncUtJeEpDM1JqRDVybUNn?=
 =?utf-8?B?aWlyVWl2RWJ3bTlCL2lnZ1B3c2ZmZU5qOHhqZnBIVG5UVWJ2a3FlZkVPSEx3?=
 =?utf-8?B?R3V0Z0RKWXJNMlZiUWhUdUxHMUxrSnZNM1hrTHVhS1RHOGt4dVFCVm9HK3RV?=
 =?utf-8?B?TkJrZTNHRHFFWHBIVys0NVVZTS9pQjNZYTVKZG1Da2ZScnZTcStLZUVINEZy?=
 =?utf-8?B?RjhBRDZickFRenFFTDRJZ0ZEclFxZGJDeWRybXNTblUwT2YyR092ZWMxeExO?=
 =?utf-8?B?ak82aHluNVQzZHNhZCtCYlBUL01Kd3EvTVNNY0pNU1QxWFQvT09ZWEZQTDM3?=
 =?utf-8?B?T2NxSFFscUdmQytaTkJwQTFFQkFSNFRlN0pEMEMyVzJnbWo1SWk3cml3Z3Ft?=
 =?utf-8?B?eUJqQkJTNUc5NzNmU1UxeU9pQnBMK2E1d0pycytnanlBWWFkeGtNSTdISXgr?=
 =?utf-8?B?TktJcy9laEJsWmpwUnppTGQ2ZnhGZHdZaEd2QlEzNXNUdE1XbjFqWHhQQmdo?=
 =?utf-8?B?b3dYekJnNmEraXhaUEwvMDJpeTVVVUNMYXFoYzlURG9wL2wxNEx2bVlzNDE3?=
 =?utf-8?B?MnAxbVRjd0s0ZlIrYTE1bE1QcHhYWVpNSTlwMCtEQzh3VG1hdXdjZ2Q5SERv?=
 =?utf-8?B?MHhSNndHTWtNZVlPQnM3c21WSnoxSUlQR1d0SjhsK3YwamFBUVlhbFlJbXFp?=
 =?utf-8?B?RkNmcUkyQjZvRElPWWJmMkNNeDRvMFVPZnViQmtJTEg2Wkc5L0REM2NCdFh3?=
 =?utf-8?B?dW5CQ1IwbzZJVEFncGswZzhxU1FyQUVmYXViR2xYMTMwOFZtd21hMGVZWHFG?=
 =?utf-8?B?Zm1kZEt5M1ZOTmM3dEdudXRqN21SVDFrNTJ6eVpPbFk5MkVZK09vV2kwTDRh?=
 =?utf-8?B?Skc1VDIrWFJOVWgzNjlBKzlSV0l5S0xsMlVqQlJYcU1WWFlRRmtMeW5meTlV?=
 =?utf-8?B?WUZsNnBiTFZyVnZjaUZjdVB5dE1CeFR4dFU0MVlHU2lsQzRieWRnZzdsSm16?=
 =?utf-8?Q?t82Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ab0a38-338d-4297-0205-08dc7f4df04c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:39:50.1324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SR2E9rS3ribPZDaPgshXe59FD++uolZOzXOOMtqWo+0AGEIZn81LkVntSxU4EvCCbe6PLfnPHNBPWz5+Hid+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8663

Instead of using the switch case statement to enable/disable the reference
clock handled by this driver itself, let's introduce a new callback
set_ref_clk() and define it for platforms that require it. This simplifies
the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 112 ++++++++++++++++------------------
 1 file changed, 52 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 72e973312d203..c5d490afa981e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -102,6 +102,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
+	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
 };
 
 struct imx_pcie {
@@ -583,21 +584,19 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx6sx_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	unsigned int offset;
-	int ret = 0;
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
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
+static int imx6q_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	if (enable) {
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD, 0);
 		/*
 		 * the async reset input need ref clock to sync internally,
 		 * when the ref clock comes after reset, internal synced
@@ -606,54 +605,34 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
 		 */
 		usleep_range(10, 100);
 		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
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
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	} else {
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_TEST_PD, IMX6Q_GPR1_PCIE_TEST_PD);
 	}
 
-	return ret;
+	return 0;
 }
 
-static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx8mm_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
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
-	}
+	int offset = imx_pcie_grp_offset(imx_pcie);
+
+	/* Set the over ride low and enabled make sure that REF_CLK is turned on.*/
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
+	return 0;
+}
+
+static int imx7d_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			    enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	return 0;
 }
 
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
@@ -666,10 +645,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 	if (ret)
 		return ret;
 
-	ret = imx_pcie_enable_ref_clk(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie ref clock\n");
-		goto err_ref_clk;
+	if (imx_pcie->drvdata->set_ref_clk) {
+		ret = imx_pcie->drvdata->set_ref_clk(imx_pcie, true);
+		if (ret) {
+			dev_err(dev, "Failed to enable PCIe REFCLK\n");
+			goto err_ref_clk;
+		}
 	}
 
 	/* allow the clocks to stabilize */
@@ -684,7 +665,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 
 static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx_pcie_disable_ref_clk(imx_pcie);
+	if (imx_pcie->drvdata->set_ref_clk)
+		imx_pcie->drvdata->set_ref_clk(imx_pcie, false);
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
@@ -1459,6 +1441,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1473,6 +1456,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
+		.set_ref_clk = imx6sx_pcie_set_ref_clk,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1488,6 +1472,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1500,6 +1485,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
+		.set_ref_clk = imx7d_pcie_set_ref_clk,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1513,6 +1499,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1524,6 +1511,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1535,6 +1523,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95] = {
 		.variant = IMX95,
@@ -1561,6 +1550,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1573,6 +1563,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1585,6 +1576,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,

-- 
2.34.1


