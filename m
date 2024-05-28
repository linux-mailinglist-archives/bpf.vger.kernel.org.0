Return-Path: <bpf+bounces-30774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB55B8D24EF
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353231F24125
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64850178CD9;
	Tue, 28 May 2024 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="efAkKEai"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EC17B50A;
	Tue, 28 May 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925200; cv=fail; b=jJR0ehBCY9YQ3AMOftk14stS2ERw9Hg+rYJHtquz417LwpMNkWrNhDgTmBMc/yGW55B9vxsIHt5AyZ4uSXPwhX0IVoHyEqViJIYbCpOLIX+0ObBVp+99ZEEjP4zw496ip/UYNyLsFI8yq5HrVGQvX5TMB6pZV1T7XYYWn2c3rL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925200; c=relaxed/simple;
	bh=xzQ/sdh6rUEzBlHbjXDB3BdPseMVFXbJTzuQD00Xw3s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m+nt++6wwhZcrf+BXlpqoxlrj0VNxN2EuGRGOJilNE3UFDT7SezX4NQUvt3cu+7/S0/HV/E7H6rupVpzy4DSHOoQ+AI10PQGeF4twD2Sc4g2TLNXdvXuoSlQvR3T8LkX8MojcYvw6/VYlgwr84z7zT5BrIdi0TUP3aYm8XDuXEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=efAkKEai; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npoNHR3XknOGHEdtS/dMnuCsG6cA7A7oTP3UCfon5RpYoMuzs/FUepl41hG4cRGvZUtDOCrlINyUoGI8SrK+R4DKf1KoPldvB6uS2hNaN5k1AR042gWVFfn2aU44OB/OzBXCwVSPfUQCCePvyycUBYJPsDUfbHYjYNLCtpbQoJYDRtVT+CHx6838ytuaDoD5EU7HAeup+DaZo/rZJ8D7PSOqfhPw6/JELVwQnm1iIT78g4ojItoZNNH7+IPFoQjzf/tPcHxWc7dW++BJ1+OLElPBqehe4YV5C54Kvu6X5ql9wxJaRvyA6u4aVxAw7pLJa/eikIlaY0rkgVOmiwulug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc47JLvApIG1K14sltKfahrWUjVx+VnkoPE/T3p+JSs=;
 b=jTYui36vrniRrLLNmfIe/qd1qKbGJbye/5yp75xshzfjcIX2A8Rs6mCAqFep0/ICUu5oB3ZZtbsUNVp0bYkHdSknYvOpYR7iD4x7Eqbq6/lRsd2yB8J0maUyfuR+mWhtCP0SjC203IDL0axwBYou/61uU0sVYz8kdyjZ/HgbKIDB6q+lI6Rr09Ez2DHDvwozyJ8mBvLDZu7sEoXnCoB/6qyBge4m9iqvI1tdoGFMUPqsbpNaLotSfLnanTRL/EIIq/GCS3fjiR5gXjqNm9Tan/erVJB1pFIPQ0dMLa58oc0IbwylGtO2k9ebWpDSAXLhE7Rrv+THAey2jLRAqw+2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc47JLvApIG1K14sltKfahrWUjVx+VnkoPE/T3p+JSs=;
 b=efAkKEailpJp4T2vVn2zHi4jqPBj3mN0tIWXDXN6qNJZTcXC2SI8+Phvrnw9ZfBOMAlBK6erMHF15cI9AFgPdVIvH96eAmbowmDRVYbzaky/Z39eeCmtv1V+y+YnPDbE8DaALt7j+DsAHprPcX6jEBzypcfns1wn8edAC7lJl2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:39:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:39:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:18 -0400
Subject: [PATCH v5 05/12] PCI: imx6: Simplify switch-case logic by involve
 core_reset callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-5-750aa7edb8e2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=7024;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xzQ/sdh6rUEzBlHbjXDB3BdPseMVFXbJTzuQD00Xw3s=;
 b=/IFX7MJ56McmsJfPS4f8VHp38XUN2x1PUemrjH3NqoRV0CVgd2Q0Yjx46mNVyxggFkFKiT+P5
 ulpCC1SK/j7AF0MMHw6GRf27ieJPwGRKbag1PSufJkHwnjTYoF3PlIF
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 57dd02ae-a9d1-43db-2130-08dc7f4df3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|1800799015|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnJpdGJtQ01abURFNjMvRk9LVHkzNFFWZ3JHNlNkRWh3MFBNM1hCcXJxdFk3?=
 =?utf-8?B?bWtpOVczbjhhR3NBcVFvY1BNM1RvYTNlNWx4UnFScXNKVlp4VXRaSEp6bFVN?=
 =?utf-8?B?UW5KZUkrWGxGQStrS2pWdTBieGNXc2drc3lhcTl2dXRoNWhrVm96c1E5S1Q2?=
 =?utf-8?B?aUxRdUF5RGt1alFlUTA4c0NJOHN0ZzRmb3lwV2s2TUpSa2ZZQ05rQUZId3RL?=
 =?utf-8?B?WHJ3QW8rZFV3QnNVVnBReDBxVnZaK01OK2U0OGxSM3dkT3ZwOEpMenFNTmpS?=
 =?utf-8?B?b25yaldWazJhYjdaL3NMM1hDVzdvOThBUHhYYllNZmxGcUM1NFB0MGdYdWFI?=
 =?utf-8?B?YTJWa2lUdVJVbDRoSWI0cTZGaHhFRmEwYUc3Q1VYUWlweGpFUzExTFhobzUv?=
 =?utf-8?B?dCtUbytoYklCSXVqMFpIRjVjZWJCYjdpYXlncnEyNU9CcG5BNVBYUVJqdHdO?=
 =?utf-8?B?ZG8rQXl2YXNlZVZOODhtV3IxN3VDa2pKbFdaL2FyemhvbnJuSkVRYlM0M0Jl?=
 =?utf-8?B?aUdhaG5mUlB6KzhFKzJIS3ZWYncyOFd5cUMrUjhqZGNMMG83ZGp5TFBSb2Mx?=
 =?utf-8?B?SkNOYUNzZzZqdVAwMGs1WnZGU1hjelZ6K1hXOEFmWkFYMHgxL1d5Tm53bUFM?=
 =?utf-8?B?VHRKeFFjZWtNRDBtN3RjRXN0dFBtTCtBdmU4ZUh1Q3V2VndPWmFidngwUlI0?=
 =?utf-8?B?Mk5aMnZxRHRwQm56TFZFblFkYmNrTzFHMnR0bGlYbUZBY01YVnVWQ1ZXbDJE?=
 =?utf-8?B?Zk41aGtCckZQRzhLNmpRdEVPRWhweW8vK3lpZGltaE1iaENUTFk4eHY0ZVNH?=
 =?utf-8?B?dlFFWXd5WmtLM0NDRXY4RHlWL1hIc3FFNUdiSWVJVXBwa0RnWDlLZ2FjT1o0?=
 =?utf-8?B?OTlGK29CNkgyRXJBYlozNEVFSS9HNmdNUkF6T0JBYlFVREI0VU1OS0N4cWxa?=
 =?utf-8?B?R1l3c2ZpejVvL2FhWnI5TXlUaU1NZW1VTmUyZUlkczgraVhoQ0dCaUg1SnFw?=
 =?utf-8?B?U1kzUUNzQTllRjVWOS9ORFpnTFlBdmdBZkNYQys5RGlhczMxZ3QvYkVHc2xH?=
 =?utf-8?B?Z2FDcWZrdVBxOCtJdURYWGNoRVViamRiVnFDelF2K0lYMFUxVHAvZ29CbjM4?=
 =?utf-8?B?Y3c0eGdzeFVCdSt4R3Y0eDlQMXNWbWRCZkdCYUpnV2pqMkVNK0tLZnoxUXZ0?=
 =?utf-8?B?RU1XMURVdDVzQ1VwS1JTb05jY2tNSzk0YlNMc2tnNVZWZlBYYlFUNzQwa0gy?=
 =?utf-8?B?cnlGdC9JUHpNdStNS1ZhUUtpbWlBQ1VqV0FUZDRJNkNENDNxQzA4QXdOdFBT?=
 =?utf-8?B?Y3VlRHczSThaenpiRldZRGFBUEZYNzU1dVB2WHM3eG1paTZqMWtpNjR5Uks2?=
 =?utf-8?B?Sk5Fcmd6Q0ppQWh4SUc5enF2MmpkOTJPZWFQUkxpaEVYcHF5NU1KSzc2Vmph?=
 =?utf-8?B?eU5ydEhuUjBsUnY2VVY3ZUIxY2dRbkg3NjJRQ1AyU3VNMlY0aVJwZXNHWHdE?=
 =?utf-8?B?WjBkV3ExY01zSytKZmh1NHZPMmVoR21odFBCNVBTQkhOcHRWNjBuR3BXWTBJ?=
 =?utf-8?B?RTB1ZVJ3Qk9hdjQwR1BwYVFFdDR6SHN5aFZVemJ0bVRzd09ZRnJZbTd5VUdO?=
 =?utf-8?B?cXptNlJnQThYWkU4WXN2bGswRC96dkczWkJnY214a2ZjZGhCaGh0c3VJb3pP?=
 =?utf-8?B?eEVTN1Q1OTFUSVNHR2JIZ2ovZDhySmJjMVlrVlJmSmVNalhiNTZ4WWlGUTJD?=
 =?utf-8?B?SlEzUlBWaVVSZzJKZ2F0NDBEZWtHMGdweUZRbS9kc3h3MzdDS2VKZWtiaU85?=
 =?utf-8?Q?5vPD1VRQCE+8jV4gWcWupTwDckUs53yf2TCyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjVCY2JqVGZYblZJTEhQbU1Bdm9LOG1oaW9jcDBPU3h6YzVwRi8wSEFjS29J?=
 =?utf-8?B?SnFrSW9nNXlzcndEcWprNXFoSWU3cVcrOVdhQ3ZnOG9rRUxYN2VlRVhFc0tN?=
 =?utf-8?B?ZSt0Q2pjbzdwQnhJMkZyc3dVWnVvSmhtUkVIZzYycTFEd2VjU1k0QVl0OUNj?=
 =?utf-8?B?d2hHTy9GbzI0OTdpcDBESHk4N0owWkpKc2Z2N0hiSTRuSWZudE5Qb0hkOGk5?=
 =?utf-8?B?K2NQTm8wRVhWRFFYemljK2QyNmlnTGNreE8rOXhPNGhOZVV6NWR6ZU1QbFVX?=
 =?utf-8?B?am15UnpUMlpERVFoWG9VOEFuMTRUOC9XZXNvOVpHWkZzM25FVkhxU3hWRjlR?=
 =?utf-8?B?V3A4Y0ZyZzZ3Q1BxL1lGZzl1TGhyTzBRRC96L0h6a1dKdGFEd1ZpeGFsaHNn?=
 =?utf-8?B?N1owYjMrcVRSMFNkREt3a1ZxN3VsVUZVaDQ1a3JHR2FsREZrQ0QwZllOOTV1?=
 =?utf-8?B?WUxQNHRLR0w1bmtvd0hsREs3T3Ftc2xMWFJxMUpoTkkrYXpZOCtlOHl3ejhU?=
 =?utf-8?B?WVNkMjlKdjFzeXdrNlF1QjFJYXpNMGVRa2wrd2lGRzQwa3ZYUmFXYWlzcDU4?=
 =?utf-8?B?MDM2ZlNwbHBObkQ0dk1jOVBGeEd5QzFwd2IycmRkbDh3d2svK0EwMFAyUUo3?=
 =?utf-8?B?Z1RKRVZXbGNENVpaTlRnZ0syS0FlakhYdjBYUHNLazRpZGljY3hWSGltV01j?=
 =?utf-8?B?UWZPTnFJbERReHF4M0xzaWdVbkYwVXAyb2xqSzJqK212NCtqVE91Qi92Zmg0?=
 =?utf-8?B?WW1HM2lWaHlUeHZ5bkRQeG96N21OWERyL1ZrMWpYS2MrbExHdFRNbWU4MS96?=
 =?utf-8?B?QkJjay9nWUhiOE8xTXUySFZYQmh3aWgwRmh4U3puTkNQNVhRZ2t6WFU3VHlz?=
 =?utf-8?B?TzhHb3dhd1Flb2p1SmE3bzcrdGhra2FxK0F1Q2ZGbThodVJ4aldGRC9wbUt2?=
 =?utf-8?B?akp0SndUTFQ4eTl3UHNjRHdxSnI4TkdianB3RjhQbjNMRDRYVFdzcGRlY1NJ?=
 =?utf-8?B?YWdPY25MM1Z0Q2hUWDNnSmVaRENpN0w0dVh4cEhiZ3lNZWhZa2VFS3RvWXRy?=
 =?utf-8?B?RTBmYkJKZXRnQ2hOM2lGaHZQNFlTczVCbnhIMEZ0QndubHJqQ3M2Q2VWaU9N?=
 =?utf-8?B?Rm5KWldBYjVaSWlhdTd5L0FoZjdOc1NnUmxtNHQ2NFdCNVB0L3k3eHFWb0ZQ?=
 =?utf-8?B?YkR1VmxkRHhwZ1pYNWdWZXZJbzdrZ003SUlSMWFDR3V5ekhOYitzSUlndGlM?=
 =?utf-8?B?TXNQcEU5UlF6TitGWEJ0eGZYdUMxNnNrakVrd1Ryd3ZxYXNUQlpkckdNSFhO?=
 =?utf-8?B?SHZheGRLQURLZ1d6VVRRc0p2bEo2VW4rR1NIYUJtOW1KY2FlYjY1bGwzbFNr?=
 =?utf-8?B?QzJLTzQ5cTh5ZXZqd2VlMU5NajN4eE5YWEEvdWZaVElic0JGTWdqdzB1SXdk?=
 =?utf-8?B?c0MxeEhycGx4M0NaYWNQV3I3NkNRR3BoMjB4K1MzOEpBbXZVQWtvVm91Q1cw?=
 =?utf-8?B?NmJOL3dDYTdIS2lPU3FubHEwdTZnMUt4Rk8wWXNWdE9DMGFIT2wzYjFaaGhC?=
 =?utf-8?B?dWZoN210bzVJWHJXNGU3ZHdlMGZDVlJmOTUrUzBEa29OUFhwSVJPYlRBOVNV?=
 =?utf-8?B?bG1KYytGb2RaNUFsNjBRV0dSdUtlc05QUzBrZi9CaHVtZWVpREdRZHduM0lp?=
 =?utf-8?B?U3hDN0sxOGFJUnNuS29QU1FnYzU2NHY5dWt3dzREWkZkQjlrdS9GT1BQTHFN?=
 =?utf-8?B?NURGVHl0UlN6TG9pL1RmZTBSL1RnQ1k2L1ZSeWpYSE1SNDEvY2cyTFdLekI0?=
 =?utf-8?B?cU5jaUs0ekdSRnVwMWxMM0lhallBc0N0MmgrVmFmNjBtMU82VVhPU0E1T3Js?=
 =?utf-8?B?L2RhTmFiQXdvSU9Nc2c2V2UwWXlDOE5xMkt1K2NDZEx0Q0psWXZZZmNrTGpW?=
 =?utf-8?B?eWZUdm80bCtGeVFFV0ZkZk5TaGlMdVBYZE5wOE9JRVd6cVNMR0Rxd0hSQzZF?=
 =?utf-8?B?aHJFVFRDVTAycGhiUXFTRjVCV1BsTk9ZaElRYTlLcENTMVNuMytaZ2w0d2ps?=
 =?utf-8?B?cVNSNGhjaGU3WlJOVm5ZaW1Ub05kRXRUajRIUTR6QVdUaTZMcmtFT2FleUdW?=
 =?utf-8?Q?cDXE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dd02ae-a9d1-43db-2130-08dc7f4df3a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:39:55.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKDnMsHbXnIzYKgIHOB3OD+pUeO+2mVafYHJ3gz+1W1BcqCOgxbJItR7vn8TtNQoQ750cV8b3qabA8h7fvMkaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655

Instead of using the switch case statement to assert/dassert the core reset
handled by this driver itself, let's introduce a new callback core_reset()
and define it for platforms that require it. This simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 134 ++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c5d490afa981e..5e21fc942e90e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
+	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 };
 
 struct imx_pcie {
@@ -670,35 +671,75 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
+static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	if (assert)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+
+	/* Force PCIe PHY reset */
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
+			   assert ? IMX6SX_GPR5_PCIE_BTNRST_RESET : 0);
+	return 0;
+}
+
+static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
+			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
+	if (!assert)
+		usleep_range(200, 500);
+
+	return 0;
+}
+
+static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	if (!assert)
+		return 0;
+
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+
+	return 0;
+}
+
+static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+
+	if (assert)
+		return 0;
+
+	/*
+	 * Workaround for ERR010728, failure of PCI-e PLL VCO to
+	 * oscillate, especially when cold. This turns off "Duty-cycle
+	 * Corrector" and other mysterious undocumented things.
+	 */
+
+	if (likely(imx_pcie->phy_base)) {
+		/* De-assert DCC_FB_EN */
+		writel(PCIE_PHY_CMN_REG4_DCC_FB_EN, imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
+		/* Assert RX_EQS and RX_EQS_SEL */
+		writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL | PCIE_PHY_CMN_REG24_RX_EQ,
+		       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
+		/* Assert ATT_MODE */
+		writel(PCIE_PHY_CMN_REG26_ATT_MODE, imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
+	} else {
+		dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
+	}
+	imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
 	reset_control_assert(imx_pcie->apps_reset);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-		/* Force PCIe PHY reset */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST,
-				   IMX6Q_GPR1_PCIE_SW_RST);
-		break;
-	case IMX6Q:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
-		break;
-	default:
-		break;
-	}
+	if (imx_pcie->drvdata->core_reset)
+		imx_pcie->drvdata->core_reset(imx_pcie, true);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
@@ -706,47 +747,10 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx_pcie->pci;
-	struct device *dev = pci->dev;
-
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX7D:
-		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
-		 * oscillate, especially when cold.  This turns off "Duty-cycle
-		 * Corrector" and other mysterious undocumented things.
-		 */
-		if (likely(imx_pcie->phy_base)) {
-			/* De-assert DCC_FB_EN */
-			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
-			/* Assert RX_EQS and RX_EQS_SEL */
-			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
-				| PCIE_PHY_CMN_REG24_RX_EQ,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
-			/* Assert ATT_MODE */
-			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
-		} else {
-			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
-		}
-
-		imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST, 0);
-
-		usleep_range(200, 500);
-		break;
-	default:
-		break;
-	}
+	if (imx_pcie->drvdata->core_reset)
+		imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (imx_pcie->reset_gpiod) {
@@ -1442,6 +1446,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6q_pcie_core_reset,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1457,6 +1462,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
 		.set_ref_clk = imx6sx_pcie_set_ref_clk,
+		.core_reset = imx6sx_pcie_core_reset,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1473,6 +1479,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6qp_pcie_core_reset,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1486,6 +1493,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
 		.set_ref_clk = imx7d_pcie_set_ref_clk,
+		.core_reset = imx7d_pcie_core_reset,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,

-- 
2.34.1


