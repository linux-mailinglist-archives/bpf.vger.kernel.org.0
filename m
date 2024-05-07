Return-Path: <bpf+bounces-28928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51C8BEBC0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519D22862AD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4138116D9CB;
	Tue,  7 May 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dfhlR0Vc"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC116D9C9;
	Tue,  7 May 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107607; cv=fail; b=W4Kp+uY/djAKUfeFWIKdccHb2d+HceJ1mw37cVrb9zYD3+qkOF2hS44n65O4oR/uynSyrnnO/LqbqH7pT7YPUlrMTmUv5yGK29QzcmoP+UyILrJt9eoxI0mt+gAbmOp5FajybKwGLPv1Voeo38e7BO1kgjmSH2AOjPX2NuXOhPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107607; c=relaxed/simple;
	bh=HrUWeYVHmrmTKrUKCJaXU6dRl1HPsn7pr8zXgIWX2Cg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VfODdjsciv7DHHmnMlcYrOxQgYrFkE4DucPpYmrVkZPNE0dLuzJx+tUHYfii0EJxWvs0See3rMGFvcVX+qp8wiDCOkTyO5q7OLVo5HPq5oi7ERTOmNfeO4SrcKHCfh317fhya54jRliAtUNY03xJpVQwwiNCvk6UA1j8aiAmnNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dfhlR0Vc; arc=fail smtp.client-ip=40.107.8.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLmTQkOJI2gOR9vb7pKtGWjJrlUM0hZyKEoShUtjyUVmtXYxSlDtLBpHQpIBjzY6YjCCXfHOinh2ZIQ7hnXilWQZO2fuY8J9uSWhRIRv1sV6tFJjeL2ioUKSvO65gVknZNCiVlnvx4S4u5bdXN1N0Pg3mHYLFRtL0UqiBu33KkG+TrLdJqqddVzuWLdn/hoyerHUGDHDBbv3iIHP4qliNT+UqLmRRzNbeiSXbVTWWUNJ9UzPlakIfvVYVmnGTdCtvdeJrBaAImpExgY/2gvu/00o3Vkm/ebzJTTK5wR+hm9ssRHBCk4ZKROU6RmMGSz/JSb75dHipybOc2BU7QgXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOyhcvTM1KJi2/kosZfh6oxXMrJ/Mmmbikrfp4HxhaE=;
 b=oIEUdfdR+nvE2rCUlpBF/8jML/+5TBB47niPO13TvFe831pTaBEKWgy65/XxjIGwfSMhV2x0xUPl8FGqWYEt0Mw8gu1xuXDz00Iy0X2TkmMPuEBgmhqysYZYU3Z5Pys47i5GJqEq/bx+SOIUntY6GA4cjfdpxzuza/v5Q51g+6ubZ1m3Hg2ua463w/n7tQDaZrX9r71iI03jbb5IEMCG1MMS9DbAUEkHn97IUvYP64GTuCokrfYVJN7kQx1qdxlJ7u9UWegckQ126WkYBS7evTo+P2WQNA85gZi1t5LVIoBbMElRlFCKyv43Ehte8Gg8s07EVSIBNru7Ya0KiV1BRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOyhcvTM1KJi2/kosZfh6oxXMrJ/Mmmbikrfp4HxhaE=;
 b=dfhlR0VczfACm3bLo2CX/9CfaDbBSk3FxUt/TpScUyITwg+DvQkPurR8IH7Ccz+K9ZanqAFN5FvCs4jPWyykVUAYg7tZRGd3p6MTBEytGCAgBOIiWL9O/i2yj0CuttJEpXmztk70HTTCHGv5ayisy3An8XALzy9/cH5DeTbLrxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:46:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:46:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:42 -0400
Subject: [PATCH v4 04/12] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-4-e8c80d874057@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=8294;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HrUWeYVHmrmTKrUKCJaXU6dRl1HPsn7pr8zXgIWX2Cg=;
 b=zr+Tq+E2eWIJb0kq+osrJSOtneDvx5fVh1GaNBh9txRy090jx1RPQ04ivfZ4LVyFUNDYd4yeS
 3oqP9xlIoeQA81OHLh7MQ7IOZcHLtenATKREK/8VbNyd+zOTJhkUeT2
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
X-MS-Office365-Filtering-Correlation-Id: d0843cc9-2c3f-4b09-3072-08dc6ec609c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mmt5N1djcHI1YU10QU82QTNncW4xd1daWDBoaUtJL0NET0gxVEhaaE1DQi9V?=
 =?utf-8?B?RFBSV253WjdvN05iNXdTZEZCQ2hFckVzRzVBTXN3c3REMEFTVUdOeiszWmxi?=
 =?utf-8?B?NGJYN0U4KzlFQjlEQWlFWUF3YWgwTXQwMm9VWlJsQjZCWUprVkM4L2REcUxX?=
 =?utf-8?B?UDlxUElkUW84KzVnWUN5Sk9ZMDhnWU03aGFGOU9FZ0dya0E4U09yb0RKOXB6?=
 =?utf-8?B?cWREZTNvKzFqVlVYMWZjenNLRUZiS0R1YXhjNFdpSnRoY09HN3VuanhqUUtx?=
 =?utf-8?B?a3IxTzJXSlBVc1BVOVVtMkhuS1VIazJIVDJVK2RzZTRVcURpUXBxTUVuODZD?=
 =?utf-8?B?U1pwU005RytPN2JBUyt6YmpNMndVTnpDYTlkR2RuUE5uNGFzblllbEIrRHdr?=
 =?utf-8?B?dUF6V2thb3dQTXRUT3ZhWFZ2N3ZRZWlnUC9XY0NBbEcxUXNua1YwTFZCaEQ4?=
 =?utf-8?B?Q2c0akhQVXo0MW5MbWoxb2xsaGZBL1U3MjNyUHVzV3l2RnIrK0JlVVR6QVZI?=
 =?utf-8?B?WWlRZHozZWNES01rWU1SWTZwN2JBdXJGTEZBQTd1Q2kxbzlsaWpXMk5DM0tt?=
 =?utf-8?B?SEx2ZEhnM2xxdlNlanVmOVJWaDJyZTVodXdNc2d1R3pqeW1xU0dxNE5EUmU3?=
 =?utf-8?B?enNQVlhhbGpFTWhuUTNUZXRwNnBTemNBaDQ5MEc2bm4wVHQxU1pyKzJrdkll?=
 =?utf-8?B?ZXdsOHRjSXQ2cmVUcjFoQ0kvRm9wYVMvRDNKMVd1c1JadThvSGNqdGJHMDhC?=
 =?utf-8?B?SFNYWUNHMUVraWQweWMrbVJrbjhzdFB4UCtqNUszQ0NQaldFbGxROVd0d2dS?=
 =?utf-8?B?WTZpaC9Fa0wyWDI2SWN0MEp0M3FIWDNVTDNGQkUwcFl4ZE9USXJGWGE5K0Jz?=
 =?utf-8?B?TVlEYXpmaDVHaVdrYTQ5QzM0VnZaclVUN2dXelVIRUhIN29nVmw2TzFnTWVy?=
 =?utf-8?B?OGNrTDl5R1VCV3c4Mm9XUHNaR1g2SWlZZko4dHFUS21jNjFjL1lWYWo4ZHRw?=
 =?utf-8?B?aG9FQ3I5VzBydkd0T0R5WUNVck9IUWs1NnlmbGdoWlR1c0hSZ2p2dFlBY3dm?=
 =?utf-8?B?TWdWYUF4eGkwSnh0bkVzQWxnakVPNEpvRGk0ZFB1T2VCbWtFOVc3OTBXNS9X?=
 =?utf-8?B?Z2RDVC9MYjdBRVdDTUUrTjdkTnY1V212QnlnTFQ2ZlgybjFPZWgzditSVUhO?=
 =?utf-8?B?dzdFamJUV2htWStiQy9DOUhFbGg0djZxNFltOXpNa0pBTngzTUk4ZzJNOHhT?=
 =?utf-8?B?dlRyMFBnZGxnS3dycmg1b2YxUTZTRTZySmVqNTdzTWU1bS9iNEJ5NnVPOTJO?=
 =?utf-8?B?dThvS254dUpjUDBEeEpHZkU1TjZVTXdRTXJ4YUNvbWN4NzJsWlhNZVBvcnMv?=
 =?utf-8?B?T1Jpd255OXJ5VS9nNnYzc1U0aDYyb2dLZi9sZW05Q1YvK0M0UTE4SEJkcEIx?=
 =?utf-8?B?YjVIVXZYWEZCUlRNM2ZnZ25SRzZBeGx2a2RBU1hOZVRlVmNETVhKa3phTnJy?=
 =?utf-8?B?WmVpSXVQdkR5bDNnM0czVlpsTCtEWXpid1VScTFwYllvWEF4VXp2am5JYWFw?=
 =?utf-8?B?TjJBdUZCMFJ4eHowODhWamVRdDU5QnVpdzR5Ris0eStMS2NQb243R1FLVGxY?=
 =?utf-8?B?QisrdXhESFJTRXd4V0NlMWVwY3NsWXA0ZjlONmdrVTB5dlVrcXI0TjM1N1Rm?=
 =?utf-8?B?bW96Vk9mamcyU1U0eFk1STREc1d2cWdvQjdLbDQxUll1emI0dmFFQUJrazZh?=
 =?utf-8?B?SVNBMzRlcDJUTnRLamlRWXcwelRScSt0YXo5c0ozOEZ2eWhhUmRrcmNVeXBx?=
 =?utf-8?Q?PywL5uhAVdbQqsD5kR2hzWz+Z6XH8AVFwBPks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0lGWkloeC83ZGRqQjRiZUhYUGhKbDRRRjJVMW5IK2JxYUdnSHlHS1F6cUFN?=
 =?utf-8?B?T3BEVnoyRkRBUmR6MXo1R3FpVUNLQS9leU9PQ1pzaFdPWVFOY1RRd1NYbDFB?=
 =?utf-8?B?YnN4dGRKS1hxdlplNDZRcG1VVDlqZmZZOWpYaWV3L2lqN2dzSDdkK2NTcGVl?=
 =?utf-8?B?Vi81R21UN2lUc3JhbmpURzFqYmlHTDVEZ243eUFzZnY1b041Z3dnYzRqQ3Z5?=
 =?utf-8?B?UG9iMytzV0wvUDNNTlQ3TEMzemI0cFRTWTlkaWVvMTlzWk1sWlB4cnY4bG4v?=
 =?utf-8?B?bFo2VDZTWmVRRElsMFBUZU5sT1NQNkVSNE1DanlWRi9WTGh6Y0FYMWl0a0R4?=
 =?utf-8?B?ZlBHbUkrb01hTG5RYlp2Q2NKWnJSTEJwTDZOa2JFZ0JIYXozUG1aZ2ZRb040?=
 =?utf-8?B?WlpZb2lkV3o0SThvRnFzRk1HNk9wTmpRODRNZWZMVXdmcHNTZjF5WERlay9W?=
 =?utf-8?B?RzJicXdVMXpCUUNyRFF5Mi9pcmsrbklTNTV5dTlya2kwYUJTbml5Vllsb0Q1?=
 =?utf-8?B?eGN6NVIyWHhERnZVZXVlVXpNenFpUTZFNHdKd3V2MVBNcU9NQmp6aXBTNGl4?=
 =?utf-8?B?azFBaVo1N0xmKzUxQy9HczZvdGFYWnBhemxWbW9YenFjTG5td0FFc2RhUXM4?=
 =?utf-8?B?K0o0YktucEFIMVhQSWpQdkwwV0h3K21mZ2dHemNJbzN2VndRNDQ0Y3RsSEdG?=
 =?utf-8?B?TTVJVkY1ZWVkVVBucTZaQ0lickFlMnVxUDVtZHRXZWNuVm90YzVENFU0Ri9a?=
 =?utf-8?B?Qm5CYkxEd1RaNCs5eDBkN0FGalRBSlBUNW95MnJyeHNWL0tDWWRXaUM3Y2Va?=
 =?utf-8?B?Mk9xbEFORXByNFlLUW5Kd3hnM0luUXp2UGRXVzRYQkJkV1JOYW50MGNNeVJv?=
 =?utf-8?B?anU0dml0Z1I5ZmY1S2R1RWUvcUVHaG5mN2F0anVjTTgyL0J0ZFZZRW9kcDJw?=
 =?utf-8?B?N3daZklJZTlBQTNSY20wWGlXRURubnhHVUpOcWxkSTNYRHFkcFFxOVBiSlM3?=
 =?utf-8?B?a0F2UW1VdlprNzhVRCtYbnU3UklTYlR1aWZwWGxremNMbXJvZEFyL3o4SmYw?=
 =?utf-8?B?MlJQVFYxT2hqbGw2SmNHb0JaV0FucWlrRmNiMTNiZDF1Z3RjNjZLQkdjY2tO?=
 =?utf-8?B?cHEyZThVd3hLcXE1eFJKbUlQaldzcEZtcE5tTjJoTEJGVjd3WVJQaEVuMXJF?=
 =?utf-8?B?clJBQis4NTBRTDdjemtGR0JNOFlKckpIRFVDODlNV05wMmtTYWdMNUFvaEdV?=
 =?utf-8?B?SXhlSHZEUndNT0Jtem9PM09uaUNtUFQxaDdpYnVpZFdGa1N1SWlMZkYvRDB4?=
 =?utf-8?B?azUvT0c3NS95R2svcGhMbEpBZGMreEJtM0xGTkNCK1NGdEVodjYvZzZTWFI5?=
 =?utf-8?B?WkM4azR2T2NXNnRkZCtGSThDYmtJbkQyRmpGN2xHNVJoRW1HSS82TkQ2TGhS?=
 =?utf-8?B?ajVnS0FsYWJGaVlZdDJiL2NoZTE4aXN5VUNnamxjQzhpcGRGNlJ5VXcvUVFP?=
 =?utf-8?B?Ly8ybm9qdEhTb1MvYVgvVjNHeURuS1BuYy8rNE5WVFZ6NGNSVmpRVTNnWmx0?=
 =?utf-8?B?NnUwdE9CQ1l5VlY2TEVhV28zbFZld2JwVmZkOGUrays5YWw4UXhOblMvSDZS?=
 =?utf-8?B?MEZhRlBPUmRCMENHYTBUZ0JOV0dlbW9oRjg2b1hBd0pqRHVpb1BqR1VCWjM0?=
 =?utf-8?B?T042c010TDlaaGZUTElwY3NzNUlhc3EzTHBDMmtRZU4vdDlzQ1lWOFNVWFpF?=
 =?utf-8?B?TWpiZThrZU5IRGs4ZUl5VUc4Rlp6cWloWkRyUCt6aTBReUd3K3NSV3VWZmNk?=
 =?utf-8?B?Qk0xQVR0UzVwcHdqVG1RZTRlRi9pc0tDdzhBWHpZVDNBRmdGOGFYY08yNENN?=
 =?utf-8?B?Y2ErZXZRNi9wM3lEemtWM0JQRHRUdDJoR0NaekRVblJBaG5PTUF2YUZMZDRw?=
 =?utf-8?B?eDI2NC90MVk0V1k1Q3BLRERlZng4NEFhNUJDT1pDUnRPY0cwOTgvNWlWd1VQ?=
 =?utf-8?B?ZjJhclpTTXBpcjB3dzJwc0FBU3FiREZqWkNnV1EyNUY3S3doV0tHUXpaUm5Z?=
 =?utf-8?B?Z3d1VWJOdW9PdHp4YzhySjJranNMMUFYUDVIdlRKRnNiditzQVArZXVZRG42?=
 =?utf-8?Q?UO6DMuoOhpRthEcKqiN5SY1LR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0843cc9-2c3f-4b09-3072-08dc6ec609c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:46:42.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkswfPf+UoRNCVdho15zEYg5FlSeCe7E93rrhHop2aKj9KTUEGTc/oMNpkP0Ocu7lcYxZ6HOLOITgOD2i/SLCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

Instead of using the switch case statement to enable/disable the reference
clock handled by this driver itself, let's introduce a new callback
set_ref_clk() and define it for platforms that require it. This simplifies
the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 112 ++++++++++++++++------------------
 1 file changed, 52 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e93070d60df52..cf1b487b3f625 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
+	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
 };
 
 struct imx_pcie {
@@ -585,21 +586,19 @@ static int imx_pcie_attach_pd(struct device *dev)
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
@@ -608,54 +607,34 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
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
@@ -668,10 +647,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
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
@@ -686,7 +667,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 
 static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx_pcie_disable_ref_clk(imx_pcie);
+	if (imx_pcie->drvdata->set_ref_clk)
+		imx_pcie->drvdata->set_ref_clk(imx_pcie, false);
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
@@ -1465,6 +1447,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1479,6 +1462,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
+		.set_ref_clk = imx6sx_pcie_set_ref_clk,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1494,6 +1478,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1506,6 +1491,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
+		.set_ref_clk = imx7d_pcie_set_ref_clk,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1519,6 +1505,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1530,6 +1517,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1541,6 +1529,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95] = {
 		.variant = IMX95,
@@ -1567,6 +1556,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1579,6 +1569,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1591,6 +1582,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,

-- 
2.34.1


