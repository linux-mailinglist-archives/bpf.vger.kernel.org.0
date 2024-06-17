Return-Path: <bpf+bounces-32338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F5590BBED
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B277028387A
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB3319AD6B;
	Mon, 17 Jun 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XFtfueXI"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2F1991BB;
	Mon, 17 Jun 2024 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655473; cv=fail; b=t/jPgsGbODTQzRwxn2IGjuBzLvXwHVYTg95WL6ZKzXUp8FrcsXaPmucv2m4khCH+CDJPpyCF3eYfnsFeDqkKTabfNc6tyVap3XxqxUxrS5EPb36SALI3SkZIm10qrbxrfg6JCDGLxq/SG0++5Hst4wsqUrIkgTscNZZzrTAwqRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655473; c=relaxed/simple;
	bh=mnFz1Xd8RiST3TqF6ybWEJkLf/FgE3r/PVt/jRqbg2o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OEZp/nYazEpoBTsmNoR2y0mnRzDl5y3gi/E9cH0XuLE/WSu5RwAc17ILX+VZo2StKfUYA5SnWSFv1SQpoyw/0YwqacnyqqJNIK578v0okxfaNhCrFz0UAgyi9CjGq+UsVmtczFK5GZIkEcnSRE4yk83i7iE9/mCjW/BvUbHdb5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XFtfueXI; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THLP7NZqpt8eU92wXI0xMttBQ4PTdBqRvfexAJqMk/SJPZ/o6LSJbiiHH0vzS6kjSwgkr4L1ysSolugAlCjm7GIYcG2SWbU5SRsjAry/IIrTkWtPXi/7mkVXnjvTa2u+ingKgfPtqAedFpTvQFkr+BRtylqAlCbvVms5KJOryKD8e8ov0CcaP7v3jp9v6JQaJTcZxjBO4uToiGyHA2v/uvYAXZXSC7qXOxg5aGeGl3EzkPnCDs1iuXPh8tt+AdobNP2m74NoyHXoye4ITJfWIfEukySUUaTVE537UhT4Z+R2l1aprflXwQJnoXQdVAadT+cDaGtYRU1M5wofc9Ut7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwAMUUjuy8B9SJn+L8NdgbW98Y2i2AV2KsWbe85MDfU=;
 b=V/VKt/pOmXzjVDsLm6fCEhFtzcomlWEfkz7FDghlysfXU6iTWsbmCsnqeE0DZYuEwUTIdHj8NdU7SEfYw7sWs+miw7UXKFiv9W9HM/fBli429mYN5ruN9m45TXD3gxGPh1Fu1tgxPdehukJjGq/0HKI0NYFCtJBBn2/qZELUJYaebLD5Odok1c0owLFpLSKX/zFY+bZn91UwQUxDMoi0vzuilm+B2VF36x2ijwPjPzLRVxGsjljLrCpCRaalsp7zfseSNfdde8wYdgP/hhTpyjl9obbU/ctPOb2Yan1cqwH6gPw8gfIDjCaEY8DZOwrzgJv2lHo76lFlZoom0sOhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwAMUUjuy8B9SJn+L8NdgbW98Y2i2AV2KsWbe85MDfU=;
 b=XFtfueXILBCkErOuPVFdYdIu9sKLASNpTO8X+ckG3+PUTdg77T3QhEUTC7B1+4gHODvSRdpFtKid5yGKd7F2CC0Iw0xq58lewPyHiBCsecuVXyFeIqEKZrFXZeip03/Nd/9mGHDCkaQSLbS+DJGUkGsF1uX9FBGexJHdtQvy3mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:17:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:17:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 17 Jun 2024 16:16:42 -0400
Subject: [PATCH v6 06/10] PCI: imx6: Improve comment for workaround
 ERR010728
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-pci2_upstream-v6-6-e0821238f997@nxp.com>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
In-Reply-To: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=1779;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mnFz1Xd8RiST3TqF6ybWEJkLf/FgE3r/PVt/jRqbg2o=;
 b=d7kv+4s8ZI9/jGyk1E9QJq1B8H2e4cB59kq2tnocyN10+2CQAvCxmX3bTWC7ZW+c/UCvrbCHX
 c6wP9zr7l7bBWYEC5uXlDkTKv6bw+p5NBKpL3KZ3Nv92zW34pDMxrI0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b3b580-7441-4305-980b-08dc8f0a8db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDliVjdxQXdsM2RWNUp1anIwOVRlaHNHTHdQWXVCdmpsT1VxS0hxczgwWWd5?=
 =?utf-8?B?Z1Z6SlJINGt0eHZsSTRqTjZTT1drT0JwSWNxMFNvYnFDLzhsMHQ0N2QxUmRz?=
 =?utf-8?B?ZThhSzRmeUpncUdnYlYycjRCWi9mU2I1RSs0WTZlSHU3WUw1OXJSYnV5ZWli?=
 =?utf-8?B?d3gzbno3b2dYWTdOVncyeTdpNEE0T3VYRXRhMlVHWlhhRzdEVkxabS9lOVNX?=
 =?utf-8?B?b0FpWnAwOHhCaCthOVhxMnk0Y3dQWm9MRzFVUzQ0THM4UENCYzRJTTNQZE8y?=
 =?utf-8?B?U1hwbUJNV1NmaVVNYTdINVR2REhmMHJJYWJHQUU2QVIvYkZNRy9UUmRMVjFJ?=
 =?utf-8?B?bnYzZlRMMVliYUpSMWxYNkxxNGJXd3hML2x2SGxVdm1lUzg0NWkzWXBtUWhG?=
 =?utf-8?B?QU9RT2NhZ0NzSFVDUER3T0dkVmhRWlZ3SHRNT0d6S1p3dUJoTDIvWVBIeXlW?=
 =?utf-8?B?TVJPMzBtRXVxamI2c0YvOFBYWERzUWp1ZVhPY1d1WWk1R0hrZjI4UVlwOTVn?=
 =?utf-8?B?b1gxWVJnM2RaeEtmMERVZHhmQ0pqYUJPdjgzbHorV1lWSmNEeldqdS8yd2l2?=
 =?utf-8?B?Um1CSlhoZml1VzJFaEpFUndxVzdKcE9PSU9ldEhGMmdFcDRWQSthVnlHOEJm?=
 =?utf-8?B?eFJOdzNrd2hHdVhOeUc0YUIvcWxTcFNKblg1cWE4QjNmK2crMElQaTBnSlQx?=
 =?utf-8?B?N3E0dlMzWWFaMnhUbGlSRENQUmFmMTZZWk5SWHE4bHNxUk4zVzNqRDEvRDV3?=
 =?utf-8?B?eVRDaGNuV1RFU2VZZGZDRmpkQXJvNU80dFlrN2lyYnRRR0FSRmVmSndaL0s0?=
 =?utf-8?B?cFl4UWxGODlRMGoyQVVoOGdLREZ6TkJvL2JNQS94MkRJYjkrTThJOEc2TEds?=
 =?utf-8?B?eEZpYnBDNXdGcmdMejhrOVVlcUl4S3Q4Uk9tT2xjcGg1aGxTMWRrRnBVV1E3?=
 =?utf-8?B?TDRSeCt6eldDTTAwVkdxejdXWVdFZElFWUd3c04rMy9UNEVJOTNheHVobVNW?=
 =?utf-8?B?Q0dJWmxuUTJMSi9XVENQSk91bFprbFpZZDFEc2oxNXNjMGw0NUs3K1Q0bFZ3?=
 =?utf-8?B?WlRGemNmUkg3OEpwMDM0QjVSMGtFZmNVUnV2MU1aOEtya0VwWkI3Q09NWFpW?=
 =?utf-8?B?dk5idHpyNWQ4Lzd2d2w3MkZZekRDL2syOGNvT3VYdE5IZldJM1d5amlITk5C?=
 =?utf-8?B?RE5rOTdERlYyc1hxTTc1SlgyZi9nMlpjVlhheTVzdFVKTXJGL1FuR1hhVkRG?=
 =?utf-8?B?eVpGN2JLdnVJRzgzYTBQYklXQWZtUStMQXphSGdNbWptaUVHaE9Fc2xtNWpP?=
 =?utf-8?B?K3hDRE9TUEZIL1RIL1gySE9ucXZOM0YwVVl1WWUvSWZmQUMrc1ExSUZrZktM?=
 =?utf-8?B?SUpiUmpsbVRSYTlsNFNwaE1vcnllWjVSSVNQOXMzUVNRQVkxMjhJSW1sQ28y?=
 =?utf-8?B?OFJYbGh6WEJ2eVFDWjB0a1FvZTArYWJ2TGZpMmdHd3hLTVA2a2ZpTFFJZjYw?=
 =?utf-8?B?cWIvNTRUQUhqaml1YTJwV0Z3YXpybkU0dktoUDdvVS9IbXBwUEM3c3JDcVNm?=
 =?utf-8?B?RUdxeTlLNndDYzd2aTNQZm1jUzNCVzFFeW9raWxORUlhOVFiUWxuMUkzTnBk?=
 =?utf-8?B?cGJXZW5oRXJHc0RXZHZrZDhPN2ZNUloyeXhCcDBrQTAwS2EwQ3MvRHJ0d1pX?=
 =?utf-8?B?TVJ5Yno1UG9tZm1OQWVFTyt1L0x4VENHb3pqdEg4MGMrOHZMR2lCRyt6eUhr?=
 =?utf-8?B?V0hDbHRLOE5QRXRaMDhCdTExV1Z5K3g0YU9YcUVsL2t0aDB1c2tZOGlXdXB2?=
 =?utf-8?B?cHFNZjc2eUpoYThQL3ZsZkV0bWFGdXNmVDJ5clllUW9QZmZmdEo3Uys4eVFI?=
 =?utf-8?Q?FuLVDYkcEx4j4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em13K0ljdW1GS0dBQ1lvY1VhUUpTL1ptME5IOWdvWVFIZyt3U00ycDl2cDNG?=
 =?utf-8?B?TmZBYTYxZllJY01HWkdqT2wweEZmOFArbkMwcTRwM0VVMUFyTnVVaXR0Zjd4?=
 =?utf-8?B?MStuSkU4cUQwWDVKOUc0Y1ZRM2RPTndpZWRmSXIwelB2RUJGMDlqb0RWVG1L?=
 =?utf-8?B?RG5ySnhia0dHRW5tc2R3b0krb244SEZPaDUwejMxQWk4U0NDZk1mbjlPblNp?=
 =?utf-8?B?T09HL2VldXEyZkt1dnFyRkNvamlTNE9uc2E4ZG54OHBsbnNLaVNBQmozY1o2?=
 =?utf-8?B?ZFZUWVJ4OXZwNmtjL1k1c2l2VkF3OERwWnZWR2ZicjF1VkFSYkRCTTR2YlMx?=
 =?utf-8?B?amdiVy91c0dBZFZockROSTBoQVIxdlVGK3pHT3JDdVV1ckxpVGdFb1VXV3l2?=
 =?utf-8?B?R096VVBoWVdlWjRtSURYNmoyOEowQU1GdWRqYWFOUUFlYkpyTGI2Q3pvMlBj?=
 =?utf-8?B?UDhNdU5mM1c5cmwwZ0dvc0NGYWNVN2NNdmkyMERhMndYQ1FZMk8zd2szUXJX?=
 =?utf-8?B?N0EzY2lXQmI0Rjd3N0dPQ1VUQTFhWTJ2R0RKYngwMWg4T0tSNXpBNXJBQVZ2?=
 =?utf-8?B?TUZaZ2lxanFXVzhiKyttZmlHNFB3S3k2anI3YkNVVC9QZHdhNll2M1F2OUJo?=
 =?utf-8?B?ejBkWVJPcXJ1NGJLbEozbzdDV1BiN2d6NFNyNnllOW16clgwcFRMVmJQWWJI?=
 =?utf-8?B?Y3kwR2ZRcnB2SkpNMVIyRHBxUlpiSXdSK1U0OUJNYWNzdGdPVlc5NFY4dnhr?=
 =?utf-8?B?VFN6ZlVXOE0yTWs3K3M3TURUVm5sOC9pZlFyb3dzRHkwWGI5dlpZMkpORTRO?=
 =?utf-8?B?U1ZwZENRRDFoM05RMy9FdWhMWXk0cSthMVBDRlpncEF5c0c0bkkvK1lDay9Q?=
 =?utf-8?B?YldlWFdNSytrQk5RSkR1RWNlaktraWIzWjhwdTBycUp4OWxmWnZJWWYrRW01?=
 =?utf-8?B?M0F1TTIydEdiQmRhcVhtR2RMN3ZGYjdlZ3lxZ1dFL1I0Q0FHQW9NbUN1bUlW?=
 =?utf-8?B?bFZNUVhrc1BiT013K1R0bGZQU1FxWEVqMUNOK3dzRFlha0lhRVJuNWNGK1k4?=
 =?utf-8?B?MHR1STQyK3k2eFJtOHlvRHNBTjllbTVDUEZwWmJiQUV3djlZSmFNclBCd3o4?=
 =?utf-8?B?RkcvRjR6bGhGeGFvQjExTmdHa3pscjVZMlBhaWptNG1reW5xSENTSFZmSGh2?=
 =?utf-8?B?QUxtdTI0NmlFeHZyeEcxRXpIYVdBWnIxdi9TVi9kNW96OEFpRDhPcmZGQ1RC?=
 =?utf-8?B?RElOUzRzZGc2bkhCMDN5UlJOV0dpN256aFhaM2JNYnVQSE05YkRzSjFKNVB3?=
 =?utf-8?B?WThPNEdPTURmTzZNQ3c1aGYyTGlEcnRvc1NQNWs3MjBKcmpucVJ2blJzanhB?=
 =?utf-8?B?L3JaaFV4S3B0YUVKaWRiZ2JxWUcxN2pZbXNrNW1XZEp3aTAxVnRiUThnL2R2?=
 =?utf-8?B?UGVmMk8zR1dxN05oMktFVmo0TUFWYzVhOFl5TmwvcmFKRGlKK0R5ejF5ZmlZ?=
 =?utf-8?B?YS84SlcxdW1oaWp2S0ZrbzBja0xueHVDQy95aEdWYktjdHI2SHlPcW5vcWNU?=
 =?utf-8?B?Nldjem1qRG04dUJDMnp2cGFPdmh5MjBIYTFwNllmVXg5S01NdlZJSCtLTWdQ?=
 =?utf-8?B?MmIrQ25IR0JwRDBZSUdBK1hlTGtNWHBWTVMvZ1pLRnhvZi83YS9SSjU5aUZL?=
 =?utf-8?B?Wlg3alY5UVh1K1pQc0hyQXFRZ1Rpc3pyWk1tT1pKNlNsK1pTaVVLVnpSb3V5?=
 =?utf-8?B?cWE0eWFLbDJYYTl5N3lNS0UzSUZtdS84YkZCb0g2TXFFaDJIR0EyQjBDMzFW?=
 =?utf-8?B?OU1OejlKOHlTMWlXNEFoZzFKd0dUYW1NRjJ0VmRlclpuSWNscXo4b3VKa1Zt?=
 =?utf-8?B?Z0hUeU5Wa0tQbjIvblphYVRjUktBdWdCb0UwSjhwNFdsYkdTV2llRmRvdWt5?=
 =?utf-8?B?SC8ySXVnRnIyb1B2Q3llQkh1NC8yNGJJR3RQN2JGQS9oT1JYK1BHbEswNTJv?=
 =?utf-8?B?RC8zbVJUajJFd2pVTUxTdU1lS2dNSG0vQWRjUjlPQkpSejFQZ0g1UnlTUmNp?=
 =?utf-8?B?MXE5RmVtKzFDaTkvU1J6bXFkL1ZLMG1BS0J2aklqdHpQTFNsWHhtd3RoMjV5?=
 =?utf-8?Q?ri5lNTjSPHw7hYUQ+JAqwsC5Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b3b580-7441-4305-980b-08dc8f0a8db7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:17:47.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipr5kw5ZRNMFsRDRgfjOvpMBztyVFzKeRVGFs50aiaWTWwfTkV6skjWKNyRtxcubBVIYI6MZiv89lL/eFINBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

Improve comment about workaround ERR010727 by using official errata
document content.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6f68bee111029..6e3ac3fc33745 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -715,9 +715,25 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 		return 0;
 
 	/*
-	 * Workaround for ERR010728, failure of PCI-e PLL VCO to
-	 * oscillate, especially when cold. This turns off "Duty-cycle
-	 * Corrector" and other mysterious undocumented things.
+	 * Workaround for ERR010728 (IMX7DS_2N09P, Rev. 1.1, 4/2023):
+	 *
+	 * PCIe: PLL may fail to lock under corner conditions Initial VCO
+	 * oscillation may fail under corner conditions such as cold
+	 * temperature which will cause the PCIe PLL fail to lock in the
+	 * initialization phase.
+	 *
+	 * The Duty-cycle Corrector calibration must be disabled.
+	 *
+	 * 1. De-assert the G_RST signal by clearing
+	 *    SRC_PCIEPHY_RCR[PCIEPHY_G_RST].
+	 * 2. De-assert DCC_FB_EN by writing data “0x29” to the register
+	 *    address 0x306d0014 (PCIE_PHY_CMN_REG4).
+	 * 3. Assert RX_EQS, RX_EQ_SEL by writing data “0x48” to the register
+	 *    address 0x306d0090 (PCIE_PHY_CMN_REG24).
+	 * 4. Assert ATT_MODE by writing data “0xbc” to the register
+	 *    address 0x306d0098 (PCIE_PHY_CMN_REG26).
+	 * 5. De-assert the CMN_RST signal by clearing register bit
+	 *    SRC_PCIEPHY_RCR[PCIEPHY_BTN]
 	 */
 
 	if (likely(imx_pcie->phy_base)) {

-- 
2.34.1


