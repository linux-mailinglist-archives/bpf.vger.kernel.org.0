Return-Path: <bpf+bounces-79212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4BFD2D71D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B398B30940C5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281C3203B4;
	Fri, 16 Jan 2026 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BUI6gQzT"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3B3451AF;
	Fri, 16 Jan 2026 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549325; cv=fail; b=Wi3PS2aJvwSztXEAZSwlcsIwHG/U608ji8Rb2mx5VzUpxZXeoFkqSYvTk1IBlRz+F9c4KJErOmBi4XpnEv/evMQ0SNlMhpe7UUX4p/BBYbDP9camJ56KZgzwEM9oRJtojM98102hPPyqT0hpgTye5U9CZRm8FiRIdAtUmZftxwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549325; c=relaxed/simple;
	bh=8b7ORhrJ2yIlndtrkbDioLVkLroKQ8E5coeVYNITjvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PaIpXKP4QYJXVlKsi4Odne/5zhW+mo23etyQOF677o1kw93WkmMoyoV4Y/BK5xj8uBUDDpHpO9q93xPSBepKm+AU667YY/44ktKiv/2qm7NL40oLJImAIpr7/BmHgTZVlGYBlpqpW42ZMmYvH+O99f5orri4IL7UpTBANEmzLyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BUI6gQzT; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhZg1K2moAuRaZt9dWDY8QwYEYn36UgR1pwyhc8Ij2jI01xi4F2x4hpg4ZDnWQHOlqdWTrjhhaBr7HHV0FGseWgUFoKuIgxj4UIyLsluNns55j+zFLIaDxNg+AjfsVtHzTEPc+2GWCfUT/wgKweNOVicNYjCNVxDJnl0iyMqrlrIcTAfWXANu1cKFsiSIcdAz09dfik6T9YSQUjsfLJxdgGPhPDVf+Lp3BXnnnDz+0vXBLuh9eG3DvbOK+oulkSOKaeRdzUys7sxYjdAzIKG5HuWGS3B2wRYCPB8hhF8XrJISuSfSlyKb1oGzi533ruhskelwWoke+gKkxHnVSQ50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTtr5YQoZqJPpslBekqH2x0fAf+Z6FF4857SATOVAXY=;
 b=nZg4dZ1oP93jPzxGJjjtmS1v0ySlpDllwrx2oH42wd8qrjKXHsFvFN7qRVRWKYaKTrhcI8qvJqOyjNEILLqs8KumWtWuzE8sPLw6oxFHkKIAMyLke1Ah3bRTsOZ8HgKO541DldRWA6dIfwKBtqlCGk7RY4daAsz8dpbTmnbQ6aLT9LlqOhxAk+kxKcgDubZfGLzkjyJE8YBJuqctbZK/yXH52qiAACF56PaRTLIQVC6yUrZ8B6aigps8sA+ou/v+m0dBB+ND5R9gZ4C9p8pngJruPZYHZy32XoWQVxQnwLAnY0hSH3XrzYPwZe3pMRjU7g+IQpdPpOXpwRv7FnsH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTtr5YQoZqJPpslBekqH2x0fAf+Z6FF4857SATOVAXY=;
 b=BUI6gQzT3ZXSC8EvzOSJLi5WqylnEE/N5+3Ju/NTe6I03MFyxjYr4KvX6YhdFmALC2iXQZKAjSjTI2/ExaQNXlR+jNmDOPxbGzFNF1oeIERUHtbmtaxZ6gK7cG5D0gL6FequkANExJW4tjmnw+Ruw0/FzHBPeb4feqICxV45sw3DaF/GtTzf9lNmSisCJ6XzgeMH8ZfdBNSZfPfUIlzQPybJxTVFdc4XzuMD+t249v7TvNKSTNeEpvi9s6C7Gjj5AlY83ZCfGB67GaSb/J90Va7aaBhYZ+d5Fc5ehFhuyoB9moIt5byBxsralV/JQPZ3xE1Ym91jkHZYSO58nEvC2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v2 net-next 09/14] net: fec: use switch statement to check the type of tx_buf
Date: Fri, 16 Jan 2026 15:40:22 +0800
Message-Id: <20260116074027.1603841-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116074027.1603841-1-wei.fang@nxp.com>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: beac8c9a-aa0d-4a7f-d801-08de54d2b64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?06X9HGPeQbsk9mk0Mx0VtnKnjcygHsc/S/EKq6L83Gsz/Ys2DC79TSP6hHge?=
 =?us-ascii?Q?DNXqqXcqSjBkFm7EHeY8oevRrIx8IVXw/EHW1wJXa48yNS1a0/Lp6Y7EZ02w?=
 =?us-ascii?Q?orNxU1kA8c1xtsD4DZuRkf2DiKte9PRwEeQetRdSlmD7kPsK5iVrz45Lphbf?=
 =?us-ascii?Q?khrj7LgwOcRWmRxZLZPKZTzNBJLI10etq6XDHmeVO3y2H+zp78lpPS2qvgNN?=
 =?us-ascii?Q?/aCojvsSzJdcXcl0vvkwJBP/2UOO1kyeeDl9m1V6H3C1N6WDVvAPet22vc/C?=
 =?us-ascii?Q?pJhHRihli/mQVmK1jjFjclaRyZFEGEFva8l1fLt5p+YTM44tnZK3ou4COsFi?=
 =?us-ascii?Q?rBq7L8LVbHHtE3px0mB5mKOuuFalVnJ/sleRVcsTcXSQm6B3rNphjZgUph/v?=
 =?us-ascii?Q?6cqiVNwKxEB+SDR5zw4D/lHq3B5rJYa0M1BmDf62lDxqwTIdfpJDVTusJiYH?=
 =?us-ascii?Q?Q+Ctg3gbaVxgkgmkGaUfbuETA0xQTFQU129iWMHGAi6/V35JaMLgdsFAyHwd?=
 =?us-ascii?Q?gs5Z70vi24adI6WUk1tcaUMYZVekCqhm0gL1MzgBskGOa57MG+nhArX1YChQ?=
 =?us-ascii?Q?1xrLvug6MfZ/9naMS+4WozzRXMB5sJW0UocdvTLxM9Ro214X67ODjH2x6JMe?=
 =?us-ascii?Q?i3uauGZip5csmsFCV0YdPpLOzuZMyUJzfwwR3ueEy2LJeMT6yqkyQ4fszbJf?=
 =?us-ascii?Q?C2jilIZ+v8MJV48b6C40uDbTMl2busJAKkGjx+OoccogEREr88Bp6ZXoTywY?=
 =?us-ascii?Q?5bwtDHJfLjyItGhp56n1wGY/DFVWahLdG/1Q9qkjsRnYceJoiZu/DmcpGHcO?=
 =?us-ascii?Q?mlIKJlWd5MJAeB+zA/U4qSZrt86BoOhxN+9oRMFfml3jnceYz1e6NcD3IFms?=
 =?us-ascii?Q?JvTgsCd2BAs+mcIlSb66Wr1Y8j+TW5HksLXP8ob2XS3bHMtrygLunjKGhmvi?=
 =?us-ascii?Q?VI8wY76gqcPmkMb7M5XeqnZE3cvkA7M1J8DqqAd0L1QNQEQ7yhZ6DuXMGusa?=
 =?us-ascii?Q?DW7OM+O1aRbYz3kbgAu8yNdwdOFawBu66tf5RD2FykKJrNzd0Rc6UoASd7lL?=
 =?us-ascii?Q?yZ48gfMj2OHBYraI26+8tUV21wkOopLaaMJAVwwtPXOpI0xH9HolSIbDuRfE?=
 =?us-ascii?Q?fis8+j+0aBRATieYnPIlwa9hmQQlfMbq2HeasUi6aJ6FWtSDnHn+DduFk/Ol?=
 =?us-ascii?Q?9dMiOl1vh4q/2nNOOaf3JcVNbVbJXtGv5GpapOyHV9NCbLW4HHANvLUvbk0w?=
 =?us-ascii?Q?I+qKMjY5p8wwnfeRgCLmNW+O5N/cb9kdVzdJ7DARJg31qZ2lT8EVQP4wpucU?=
 =?us-ascii?Q?9QXoulW8+dVI1AEmILMvoNl1eQMpx7EQTAMrHROIbOx8aOypUgHznPjvnwLH?=
 =?us-ascii?Q?w/Cw41/cLKG67LA7mubo3axDWDYWUg7K1KTjMvAuMR0uwlsdlLcHDv7BRJ7M?=
 =?us-ascii?Q?oKIo0Q4RwenJ1RW1F2GJVtSZGeuEEG7e0GJtJKX79vYeOlq48XEbUc7TAmYF?=
 =?us-ascii?Q?HpyqWFwdixXm6gbqV6+YR9cPw48KhZlSha6AyEcwvvgX8dcHAc/EJpBIEoqT?=
 =?us-ascii?Q?7nAkTyW/zMKfZO9A8ALwjo3mIiJyl4xlsON7cPTFl93YMRheov3XXnIxeyyz?=
 =?us-ascii?Q?yupnAvKxAj+3KQFOAL7OQ2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AdZI9yzd9Oxiv7yxPrJBbkU8G2FMtFp3kKclkKIL+CaCC6gkYjiD7ufjIpRr?=
 =?us-ascii?Q?KxP5UNdqHIaRn/m7b/bM3rhoC8/YVyvmQLVJgisD8Mxk+o6jZBkoAT4sNdYv?=
 =?us-ascii?Q?P1yhVwRok6m5Fh4cY6IlyGJVpHgKjlzewYBcjm2DhySFCdXhb3uduFDdkIGD?=
 =?us-ascii?Q?zQviVn8u2cegLRjY+WJ5iqZmfB//y8X52cIilp4foAW5U7WnIjT34d+nY377?=
 =?us-ascii?Q?mYcaVR12HvMoC1fSJAcR1c63Nrv7Dd8rx9VAn7nPupbbYKXzlZkPqTgcdd2r?=
 =?us-ascii?Q?veN9g0077peEs8Vrfb/x6a3YJ95ZL2nCzXsSBMdjUwhDKI28myut807PvRtz?=
 =?us-ascii?Q?nP+mOEXdHOWR21Eb5AtDK57Sy7b+BeX88KLj8+1L+AfInMe5JFF5iUNGa1W2?=
 =?us-ascii?Q?5kEIAxKQmuVDg9eucsTVY0Bfit2VQBHKfZHcjr5e+RBhwcc0wPVxd0J8d+/S?=
 =?us-ascii?Q?j3wPW1wxLSc6S7IkjY37MJQ5197oROR7L509dfRy+XiN/wmVNoAGp0CNKNwO?=
 =?us-ascii?Q?aXs+tgAf/EF7oa6bpvYhbtdyvVEdnWvgaMvxMxXJ45gCO+hGHlXNF+yb0PUS?=
 =?us-ascii?Q?1O24AdMZMQiDr9zBTjLdSEbhQHT7agNqpJpBjj672pI+IUIP2KJD5ossdWwd?=
 =?us-ascii?Q?2Ro5d+9vztKinJef4jMwcgQ6ypPe8VNx8Xm4ta7jpPgOhIvYdRySFmyN3FYw?=
 =?us-ascii?Q?Vk9eE2YQAtsN87bE9UL1LEFZwRYS8dcZoHLrjTkbtrAR0NVCZIlBSgtU8VR1?=
 =?us-ascii?Q?s40kR3irMQKfbRlQm8jrrHZ8wZ8qzpwFfz6iYz29erqxgb4DwR2JI1EB+kwc?=
 =?us-ascii?Q?nvQdNZwxMHG8W5AZ7075Uno8diguDEEy7F5vKVg4oRNo2gGK4yoSahIcr6W5?=
 =?us-ascii?Q?NbcToCiZYlF+/taArUXyedSsweK4Y9lvo8NEDzESrCRhGE5NS43zp2FhKi/E?=
 =?us-ascii?Q?UvRJ/EeaDE0fMIDng5YPxkhtCJyLqokFvADt9q7+ozqjUvdFIkmwQvidIMp7?=
 =?us-ascii?Q?zaGVf7pb6Hwt8fpI2Qk7FQ6llle784vHy7QjPGoZ/zoMCxEVTr8YtyY8U5JX?=
 =?us-ascii?Q?4mkMiBdq9zmV2F+LbYNka+0XUdqdTEg3U+V39zfxjrNzc7pSHNOH8X4FaWAC?=
 =?us-ascii?Q?c7CoC71Z3UVev6rW4ubkKw1nJzBo6el7FjQGcECuwGA5qiWK2shzkF71RvMp?=
 =?us-ascii?Q?HkeV52dA4HzY7f9IauNWqlWYiqHNVJsLL9hHl0HwAHqrG1yCqsKbsQwJiJzh?=
 =?us-ascii?Q?orwUvcEMtUEGq40BoM1ceLIL3HgV1fzflT51Ax43FVWMuFUP0ULwefyto7G3?=
 =?us-ascii?Q?w+H5M9/Z3Fl5un+bFx60+W075ASlHANu3axHR81cNKec4YCd70T6Dll7mPdj?=
 =?us-ascii?Q?VKvp6uLyyidQhklgfVZUhvpkZVRfBkZEbwtuwkXdElZzFvmAI+sc/+K9s8Cf?=
 =?us-ascii?Q?gzGu8McGtqCTMKKZD81sCZnCfLMVYAY++zN5Nopyi8HUlxgDsxx+6UensJcF?=
 =?us-ascii?Q?2EQ3LtyldJ5OSdgY+BnirqFQS/lu+QdNUi9Pa1Yc6nRMmHEi8++ikwmBsvSq?=
 =?us-ascii?Q?JoyqDHu+I4C/yGMnz25I4UNByVxadbxCS9GXki5VRSOFfWSQIvW58RXh+D2l?=
 =?us-ascii?Q?LdYA9FLhFWtr8CdqaK3TQtW7IAImf070rrXWS0uG8EmA51kK6jrGxgQcrzVU?=
 =?us-ascii?Q?pldgOMmZJo3tz5lRNIJHju+rdheZRsrWQeOw7AKkVW99pMZbpoV+GKy5VBJP?=
 =?us-ascii?Q?pRsvQtHutg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beac8c9a-aa0d-4a7f-d801-08de54d2b64a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:51.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QO1kqY9NcL2JqdKvuRpRr5RV9ECyE50MkCWL6vGCHJxueOV4rs3ZYT8DJoak9XhHeT6wwXErjZBLmw2TpJX8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
to check the type and perform the corresponding processing. This is very
detrimental to future expansion. To support AF_XDP zero-copy mode, two
new types will be added in the future, continuing to use 'if...else...'
would be a very bad coding style. So the 'if...else...' statements in
the current driver are replaced with switch statements.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 136 ++++++++++++----------
 1 file changed, 74 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0e8947f163a8..2f79ef195a9e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1023,9 +1023,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 		txq->bd.cur = bdp;
 
 		for (i = 0; i < txq->bd.ring_size; i++) {
+			struct page *page;
+
 			/* Initialize the BD for every fragment in the page. */
 			bdp->cbd_sc = cpu_to_fec16(0);
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				if (bdp->cbd_bufaddr &&
 				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 					dma_unmap_single(&fep->pdev->dev,
@@ -1033,19 +1037,22 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
 						 DMA_TO_DEVICE);
-
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
-			}
+				break;
+			default:
+				break;
+			};
 
 			txq->tx_buf[i].buf_p = NULL;
 			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
@@ -1509,39 +1516,69 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			skb = txq->tx_buf[index].buf_p;
+		switch (txq->tx_buf[index].type) {
+		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
+						 frame_len, DMA_TO_DEVICE);
+
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			skb = txq->tx_buf[index].buf_p;
 			if (!skb)
 				goto tx_buf_done;
-		} else {
+
+			frame_len = skb->len;
+
+			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
+			 * are to time stamp the packet, so we still need to check time
+			 * stamping enabled flag.
+			 */
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+				     fep->hwts_tx_en) && fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+				struct skb_shared_hwtstamps shhwtstamps;
+
+				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			napi_consume_skb(skb, budget);
+			break;
+		case FEC_TXBUF_T_XDP_NDO:
 			/* Tx processing cannot call any XDP (or page pool) APIs if
 			 * the "budget" is 0. Because NAPI is called with budget of
 			 * 0 (such as netpoll) indicates we may be in an IRQ context,
 			 * however, we can't use the page pool from IRQ context.
 			 */
 			if (unlikely(!budget))
-				break;
+				goto out;
 
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-				xdpf = txq->tx_buf[index].buf_p;
-				dma_unmap_single(&fep->pdev->dev,
-						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
-			} else {
-				page = txq->tx_buf[index].buf_p;
-			}
+			xdpf = txq->tx_buf[index].buf_p;
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(bdp->cbd_bufaddr),
+					 frame_len,  DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xdp_return_frame_rx_napi(xdpf);
+			break;
+		case FEC_TXBUF_T_XDP_TX:
+			if (unlikely(!budget))
+				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			frame_len = fec16_to_cpu(bdp->cbd_datlen);
+			page = txq->tx_buf[index].buf_p;
+			/* The dma_sync_size = 0 as XDP_TX has already synced
+			 * DMA for_device
+			 */
+			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
+					   0, true);
+			break;
+		default:
+			break;
 		}
 
 		/* Check for errors. */
@@ -1561,11 +1598,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
-				ndev->stats.tx_bytes += skb->len;
-			else
-				ndev->stats.tx_bytes += frame_len;
+			ndev->stats.tx_bytes += frame_len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1574,30 +1607,6 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
-			 * are to time stamp the packet, so we still need to check time
-			 * stamping enabled flag.
-			 */
-			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
-				     fep->hwts_tx_en) && fep->bufdesc_ex) {
-				struct skb_shared_hwtstamps shhwtstamps;
-				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
-				skb_tstamp_tx(skb, &shhwtstamps);
-			}
-
-			/* Free the sk buffer associated with this last transmit */
-			napi_consume_skb(skb, budget);
-		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-			xdp_return_frame_rx_napi(xdpf);
-		} else { /* recycle pages of XDP_TX frames */
-			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
-					   0, true);
-		}
-
 		txq->tx_buf[index].buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
 		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
@@ -1621,6 +1630,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		}
 	}
 
+out:
+
 	/* ERR006358: Keep the transmitter going */
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
@@ -3414,6 +3425,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	unsigned int i;
 	struct fec_enet_priv_tx_q *txq;
 	struct fec_enet_priv_rx_q *rxq;
+	struct page *page;
 	unsigned int q;
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
@@ -3437,20 +3449,20 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
 
-			if (!txq->tx_buf[i].buf_p) {
-				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
-				continue;
-			}
-
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				dev_kfree_skb(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
-- 
2.34.1


