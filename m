Return-Path: <bpf+bounces-32341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C7290BBFC
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452D1283862
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33319CCFE;
	Mon, 17 Jun 2024 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LL8sEZLr"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2053.outbound.protection.outlook.com [40.107.103.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8DF19CCE2;
	Mon, 17 Jun 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655484; cv=fail; b=bPEL3NMxjWdiKxrTm6GIAZGTvAZ39FbyeiyJmjmOI+JoyXaQ31k5ejzj5kVzGMt9K1tupcMAq1Qg/IzhuxEYG9CTZhUQ1g9ZHeBZlUyR+vdap/eR3mlBZEt74LXTCowL2aPR/rpqLSfV0UHsKoGgSgMWbN2A6xJ5DlV8a8nNXyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655484; c=relaxed/simple;
	bh=rdBX9SAsLGGVokztvn5vz/ebdrIJ20HWryji5UtWJnk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Zd50QhgLLxDi67xywUxgSnQ9mPK6jR5gxukXB87kGEobHOFIA0P1GPvuFA/l6IQIxrPmXyZHl2GQpSV9w8I3Sfqip7DbRuScfiYNQY60yxJSmvOgpciqGRmtEko351LRGmkHFlT4cLzOXZufhp3s7hauqpO+XU0iBRE5KB3qMtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LL8sEZLr; arc=fail smtp.client-ip=40.107.103.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0gK0y2+zfrPOwAJIKXo+tOAvb5+hdgBxj8NWSDaHm6MIjVDr0+DUMGziO6/dh7MOvyrxmibOvZ4bz8b9zODqzC3EBResvEs8uXQxbyO76uqlDeDtAJcQ1QjKQf23PC/wkfksYk8DrOiI6mPhrOwsJsgUqPleWWzRCAYmicgjanodmJ2+qE3Z8aCMCLK4Yu5MB/RHfHX+zNIJM25vizQ+mM8RNhRrvED4v47VwbK30iEhSTJvMT15LO+tlzlg+/LHu7p12y61jWBG1Xn63NVr9lk7oQ13Xz5YCqGAGY38DkmyDIDz6AcQA2vdnlIZON7fPcC+eP6cpqK4fCq42cWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MbpA0y8LU8HRpju2DUmQSRJX8UDOWjSKuL8l04o6lQ=;
 b=cOd+4zG5VP8LJr/zth14afVs9g9C6K/5Iq/YrIeHt30ka3rk8qkhLNxln4jZwZWfuK/IN7UzQRi4T/oq9J8Wd5ZRbAuCXgVQjhOGIyUp3ln4wqBFS/mKRfN2FDsCtN0ViEqQuLnOqg3lLbcufj8c6tKU02hlWffAn80NsD/JTSIyS5Wr5NjKcBhz9gRYlJQY0wsvAkynmflV8716P0o9ZpgpZIq/hNEr+Xu6E1PDSB/1GtvmTbszbbJYaIAf2ZR0gGJkfisHV79jAqYAa4euJLhKN57oUxVCFEG18EUEsfmaNytzmVF8G24CzGgQQS0coIQ4XdT1y+2GJi+pZX5YUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MbpA0y8LU8HRpju2DUmQSRJX8UDOWjSKuL8l04o6lQ=;
 b=LL8sEZLrK5E+iaLZYkdsrc+BzuGLQuooe/RcoagPK0AjmbEsjQZijXhJQm9xTsXLiFaJltVP4dPA3W2Fox+tlF3L6fmpae9e/BgeIN7mX+VQ5oVnfZA62OsJoTp2ZPG15PpvNXmo3PoSegBAQVgLWfCvUK6ZcF7qvq+5qYyC8cQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:17:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:17:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 17 Jun 2024 16:16:44 -0400
Subject: [PATCH v6 08/10] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-pci2_upstream-v6-8-e0821238f997@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=1356;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9ZkdHDkA+jFfsgNpx5r6KX8wuw07nzBbE/IHsRQRYtw=;
 b=Ltw8SKUOhXUR/N37ex9tuFEBMGyDTCWWFRsCDE7utCebx8DrKCAg1WscVpZCindlfR1yIcs5I
 e4P6G+RAzCtADzd3Jj9fBuGO7WOn/63jNFDCQ6zmyGqhmTQZyxu/BeW
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
X-MS-Office365-Filtering-Correlation-Id: 35440926-1c41-4e77-0a46-08dc8f0a9531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnJmWmhWdWJEUW9oQm9WbUFlK3B4SFVXU1dWT2JUclNSVytjMFhPZWYzREZ6?=
 =?utf-8?B?L0ZIQnVGcjdiaHlMd1FuUDlZZVdXQ1cxU0wvVnBCMDZXMXNyQm1rL1N3US90?=
 =?utf-8?B?TmNBTWxPMk1lL2xGU3F2aVp2bVZKcWdBNndyNUlTdzJzNkVPSVg5YVcrbE5q?=
 =?utf-8?B?Y3pQT0xMK3RGRTU5MUw4LzNmdm5jWXRLWjBhaEM5WUM5M2kxRjVVcjJKUlR6?=
 =?utf-8?B?eUU3ZFlCMWRlMExTZzN0ZUVMaFZtYW1EWlNiYzRsK29yV3dRelRTUDY4UW1Y?=
 =?utf-8?B?WGh3bGl4MUxNMW9NZGdjNWVQbjNieGNkWHBQNHRlZ3J2RkhxNW95VHZ2dU56?=
 =?utf-8?B?ell3Q28xRzlFTUpYanBDQ2tpKzBTbHFmVWl4NjJuajdKcDhOSkpaeDIxSUJF?=
 =?utf-8?B?WklKU2s0RDMyL3YyMzFCWWdNUUNrWnJFN3lrSkgzVmQvYUtxalppVzNHZ0dJ?=
 =?utf-8?B?citDUE95eUtXaUtRRHdJMm9OaThPMSthQndKQTU1Nk9oYnVtT2UwTnh2cHBa?=
 =?utf-8?B?dnk1czJCZGwxOThxSmg3VDlsRXZxNDJaa2JsTGRJeXBPOG5zU05OcGN0dVlZ?=
 =?utf-8?B?Y01vMjlwekd5dVhFTi90R25USzZGc1cybmN3UkVzL25OZWRaYnd5M2JNV0Na?=
 =?utf-8?B?Z2paRW4vVThVdWtLSGJVV1RxWENHSEgyN05KMytTaE0vcTIvbGR0em5GVEVY?=
 =?utf-8?B?dVdMazRTbUl5c01IWUJiV0x5aWtLQUZBWFMvU0h1blZXUGpRNHlRVEo0OXJY?=
 =?utf-8?B?VTZkeDZ3eFpzK3FkN1hJMVJoejVvQjBoY1BUdEdiT0Z4YmZJblZVRDduLzdu?=
 =?utf-8?B?QjArWmRjRlZIOTN4Vko2aTJZYU85Nnc2NS9EK3VORVZJZHdtQ0VsWkd2ZU9W?=
 =?utf-8?B?dTRMWFgzRzZ5dCtKYVFBYnRNTC9NQmU2Z3VFZkV0QXFhWExhZXZMMmRtTWJX?=
 =?utf-8?B?WHI3YlpTazRhSksvRk9KQlJTaDdkcTRLcHdWZFZEU3ZZbUhGQTEwRTVOQnRJ?=
 =?utf-8?B?K1dvaCtldnVHSGRaaFFEMTNpSk5TWlpHUmxiektuU1VrZ3Y0amdmRXhTZ0Vs?=
 =?utf-8?B?bEx5TjRqTUZXdzhNSWRFbWw0NmtmWDk2M0dPWFgrRUlqVlA0dWJlcEE3bS8w?=
 =?utf-8?B?T25hVjluRWxUaE1yOUdyY3lmaStiQm5vS1N6N3FXWlJhUmJlS0YxNjJLb2ZQ?=
 =?utf-8?B?VDZhMnV3Yit1ZUJuNXZaM0VFTm9jQmtsbld4YWxuaFF0em00UXZ1c0RRT2h0?=
 =?utf-8?B?K0lGOXNROFpyNVFoZzJMb05jcVRsZ3RZWS9qZUFNemt2YkZtbXVJbnlBVVZv?=
 =?utf-8?B?UnoyZWh0a1FtMzg4dEJsK2M1Z2JBMXg4NHp4ODN4MEgvKzZ2SmQ2MHNuMVhI?=
 =?utf-8?B?dDNJWUxwSlRGc1dmMlJXdUVxRkxsUHVBUEVDZDZBQ1ZaelA3RFJRTzQ5Sll2?=
 =?utf-8?B?RFVKVjNqRjJaY0lUMnI4b0NjWE1NOEllVjlpKzMxcFU3eWdlTVRheXM4RE9O?=
 =?utf-8?B?d0xyUk9QcmMwSjFLQlkvVDNwYkxRWElBaXBpNm12VXNSTTE1bEYwU0ZjUGtp?=
 =?utf-8?B?bWdQcVVkd2tHclhLUy85eTVVZGgwSTNJczdpV0ZibW5ZY3QyNE0xQ3RLVnNE?=
 =?utf-8?B?ZEJTSUw1ajBpYjlhUUVKWnN4Y050S3F5anowMUYrUFc5aXQzRmR3c2FZVXht?=
 =?utf-8?B?S3Q4SS9neEFPeHRlU0F3ejZZUk9sS1VKRjI5WU9PZUQrQ01CaHlRQ2JnOWY0?=
 =?utf-8?B?bVF1ZzZydHVGWUszd0JRVktVbDVHZWdQRGJoN05lN295Qm9yNGNQb2tWWGtP?=
 =?utf-8?B?bjNyZDQ3S0JwN0hJaytwbEl3b1dPSy9HL0o4ak10VWExUUcyQXVoTkhmdlZp?=
 =?utf-8?Q?Q4tk+c6jJuloy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUlmQnpiemN2VHhEQ1FvRUs3RmNkVlJmUHJ2VlRIN1JoanFJY1h5dlBpd1Ar?=
 =?utf-8?B?c1l5TjR1cWYrdGMyWkVHVzN4blRjdkdPZ2lPOEYxOHR3SnMzUnBwRmN5Qjdu?=
 =?utf-8?B?STk5NXFTa084RGNqUHlsajZXTWY3N3NYNUJSOVJLNVVSR2JrTlpMVENkTGJN?=
 =?utf-8?B?Z2NXS1NtbTl0MGdRQW5hUC9OWis3QjFKeWNlL0ZPam5zWlVXcUFTOEFqNTB6?=
 =?utf-8?B?UjBOR3hrV1lRLzZBMStpU1JWOEw5KzVXVElCbHZ5aWNxNzhTZEVvQkdQdVhw?=
 =?utf-8?B?UXZETC95VXFVTlJWWEhPSTV0aVp6ekRzWlFmRnYrQVFCRWwycFV2NWRsL2Ju?=
 =?utf-8?B?Q2tsVU9hZDlmMDU1ZUlxdGdOK2I3dTVVN21UOVAwaVc5UkErMEg0S0NqZkJJ?=
 =?utf-8?B?R25qZVAvL1lKNjFMR2dFWWdXSEU5OGZrRTd0LzU2UlRwOHhrbnNRT2x1bzg3?=
 =?utf-8?B?Ky80YVorTkVhdEJrSDlvMW1vaVZaV0g3WlBxNTc5UExwS3lqaTlHRmFWZzFX?=
 =?utf-8?B?dUt5RFNUeCtKU2l0d05xamZJN043ZXQ0VXZXN200QzVFbHNKMjRUQStYTlYy?=
 =?utf-8?B?Q0R0N0RsUlJMaDk4M2pxdjRoV0xVNGNDTkdrTUpjeVRWbXEzY296aTJMTTdm?=
 =?utf-8?B?Q3ZsRUlMNHRHdXBpUEtQUzlFQUc4NE4rRmJzM2JDY3g4eHAySGR6YWpIdFo0?=
 =?utf-8?B?UWZIemhrYjgvOHRtT2pFUDJjayt0dGtDZlZMRTlMMmdwUXlqaUR4bFMzYkcy?=
 =?utf-8?B?TDZtbExBQzRIZFI2UGY3Mzc2UU5lNzN3ODEvR0w4ZzA5ak13ci8xRis4cjdr?=
 =?utf-8?B?ME1OQ1gzMWpKaE9SSmY3TGhPQU5UbUtNcVoyU0p1ZDNTdGdBc2p4aVMrK0Zv?=
 =?utf-8?B?dm9RTXZWVVVsbmJlbzY1WjFkY3RLdUx5cVVybFVvN081RnRwaXI4L3dIUG1U?=
 =?utf-8?B?elcvV3hCY2JxZDcyeW4zNGFFeDhpbUY4ZS81M01SZnc1N2JmRElkU1ZENXNY?=
 =?utf-8?B?c1BQc0RqNlBpQnBqZGRMS3MyQnlqeVBsUGpxWE9DZjJxRkM3U1VuVG1LWHRR?=
 =?utf-8?B?QkZ2bHJvRXdiaWM1RFVyTmw3WW9NcnRoM0lCNjJwMnluQTBrd25BVE9iSk1y?=
 =?utf-8?B?dFc2TndFM0x0VURMM2VYd0ovVmd6VFFWNVptNUt1ckVxOWcwV0xON3hyZUZi?=
 =?utf-8?B?ZWx1VkcxNTZSVEFBajU4a0tNYkNvZWlzY1U0aXRmN2dRY0V1SzBiNFoxMnVJ?=
 =?utf-8?B?UE9rYnlIYklqMHB3WTlDMzFUb2tBbWd5VjZLVGhwQzVKMkZ6OHdUZmZDZVFT?=
 =?utf-8?B?Y0x5MjNmUkVDNDlua0xFL3VidjkwODdMbjZua1RlMW9CZTNyRHVTbnpneFlr?=
 =?utf-8?B?WHJqWFdaR1d5N242S05laENmRnFwdy9SL1lvVUxvSXdpeVFrU3pzS0YyMWNh?=
 =?utf-8?B?MmtvM1lKOU11cXJxd1JISURVSDQySXNQb2l5UzhIK2dVQjVpRkx2NWlaVFNZ?=
 =?utf-8?B?QnA1RVRscnBtYU1LR1A1MHVNUUN6YjF3L2VBYnN6RTZUL3NYamJsbmpLdlhW?=
 =?utf-8?B?QVdWTEE2RnMwK1RMekVpNkhJSmlFdms0ME90RndVYXVCeVMydWlFcmJFREJV?=
 =?utf-8?B?Z0lPZjcwSVRmQVlGMGVJOHQxQStSSzFBYmwrN254bnpaUjZ4ODlCaWorbDNt?=
 =?utf-8?B?bFRsSjNuMWpMTWpXTS9BNXM0TC9DY2dLZ1RxMVRQUm53MU9pMWhCVUc4bitE?=
 =?utf-8?B?V0ZWQWMvWWN0MEl0MkxEZTZIRlk2QlVrK1dtckhmaEY1L1NRTTJXQWdjYVR3?=
 =?utf-8?B?UFBucW1aNFRyOEU4NkZJdmpsZFRxMmVTTTRTeUM2WlBXVmovS1pneFZoVldO?=
 =?utf-8?B?Z05YKzhhcWNEK3lwY1BDY0hqb1ViYzZTVFEvTkorOTMveXJmRVZXQ0FBbEVa?=
 =?utf-8?B?dHpSQ042YzhJcEd1d0c4T0JSSE5rcFJDclJva29GMWRsV09nWWIyUjloVlFs?=
 =?utf-8?B?cU5pbERPNWNZTXpvbENrVmIzek1tY05SNUN6SVB6SHd1RVA0eUlVbkRNaUtO?=
 =?utf-8?B?QWgvWUZpTFo4VmU0d2t2Tks4ZEFaMjA5ektKcSs2ZnErNU1MK2FWT3VlZmZU?=
 =?utf-8?Q?gUDNn9AbP5ANJ3fmeJKvtNJ/3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35440926-1c41-4e77-0a46-08dc8f0a9531
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:17:59.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BExwOTBAoPNdLUAbOp3LjbhcRq0mdIvVyvpdLfd+uZ1chXrfg2t2T18jdSOMrlGW/kUHlSoNLS+xZgZMGx3oWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings. clock-names align dwc
common naming convension.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 8b8d77b1154b5..1e05c560d7975 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -30,6 +30,7 @@ properties:
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
       - fsl,imx95-pcie
+      - fsl,imx8q-pcie
 
   clocks:
     minItems: 3
@@ -184,6 +185,21 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1


