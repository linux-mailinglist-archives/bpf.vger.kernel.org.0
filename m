Return-Path: <bpf+bounces-43927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6949BBDF1
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CE4B229F2
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6E618CC1B;
	Mon,  4 Nov 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="juJcFmgG"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D21CDFC0;
	Mon,  4 Nov 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748216; cv=fail; b=EHusY7PEm05WPwZ8nS5iXDg9U3sh5pCUFv1UfLhjv0jE8G8kk9CMSy7Y7bKpK5CdAmL/4CCblCGHFGdzbviyOUIIYAjlfG531OeEizTKO5CUtNf9W1FoCPdvko54YbOR/+YQ1S7CLz8sOgsWBRuhSSEaGljdXWpVYm+mfH1fI60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748216; c=relaxed/simple;
	bh=+aIiIuuWGwNys2L38Y01Wb94GgVrnLzwlwttSKeybKc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=esYTb7phFpMxVyjM/GMZHT8zntMng3b49S1Dz7oxfOsjv0UVVRtsK0qrBBTwYWkBwQHoPxxz+iPujJZ535I/kmsDy8U0Rof/+85Xzgq3XTSPHFcc+jkHLRHMLludLWPNlfk4g5CLAeOm+/CO9rqKlfs1Scfi1G9cLMRP3Hz9D5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=juJcFmgG; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnbi08pdQR5Sjv0tzl90CFj1pduCEPM2/WDkpU3EwfObk4uThHn9EwoPTfLE20xmHAYSe9vCr8/enkwb4f8o/B5Rh0a2a9go0sH8Y51zJqXDGGJnbzzFhlE8B86HexHX4RE32M1FtKOFVSH2AgmhJpHkd3y+P54wKCIuTPt9GVQRWXXStU/1msCOweBql/CQtwJqn6ntVkkdQYLK1JsLoXY57rkesC94V0BT0pq7mugpBEvEPqt37eEkGRmPi/Ule0eWR3hsCBksEyOq3Lbj+xiyiwVv9v41ICsDCzfRtmJ4jN5CEqUah7b3JU5McTCVFe+11LWhf0V7rf/hxr1sYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQjjFi3dBR7ct2082uGxiptRJvIFAG5bMc0X6N5857c=;
 b=ywtpIUbQtKc1NY+VSWVg8TRLEe05TXI8RUPDUoix+hd+YyirDD05NjMeNMK9kawModW+9KQSrzQhjt+mpa7G4uMdm+tiGRcNY63NH7lSUPSAbzVVGnkVG0ezYoYh5NvSeR7k/rWMCXzrwAUUrWIG/kaKeyxLKRe7CUbp+UCViSWPuhj2XgzynfXlx1O+qDFijrdJX3hdz3B+cSWGZb3mzmOh9CZADqLzHGgVZPw10IE5KyIpiBh6VtXUTx4EZIOZcWYEimagGC7tcrHamyaXm0xN7PXv+ohfNvMBDNqoYEMo5LFuJTpH2p7w3ql6RtX/94nsreencyiMrNxz/gwaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQjjFi3dBR7ct2082uGxiptRJvIFAG5bMc0X6N5857c=;
 b=juJcFmgG7BxPH3Uhv+zCvYVL7VKML83JoSWmE3wfFO6dXJ1NhaR3kVJLXFbJJKxlkxD/bqKCX94hHUp+XfJjVVKrabg+mmDg1edud0OUyuDP90dQBqiLRpkddrlx2SVrzrdw/70qGwFVIug+3rA1nf4DAp/4ZmkjRkCu1DjmPNZN1GZYe7o4aOpcxYJXEG2G0BqPzVAl2csanrYA1eXLOUAscd9F74g0+tN/kFzN+F6zqHhEe9OuMjqyFhP+NtHb/oUd6PSySjz89bGmQbyJF9ockmANbnZfONkTFhIRa0sel4/r6OGjhZOBk4Iv9NeSN2cyEYBHc9w5IJMq2v35Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 19:23:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 19:23:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 04 Nov 2024 14:23:00 -0500
Subject: [PATCH v5 2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-imx95_lut-v5-2-feb972f3f13b@nxp.com>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
In-Reply-To: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730748193; l=8517;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+aIiIuuWGwNys2L38Y01Wb94GgVrnLzwlwttSKeybKc=;
 b=bH+v7y/ABezCJFM7lwh4MoCDxsYBRmAGhqGn+M70SXZ2LTSsZcO5wimcUJwldWy2gmJmHmw2V
 khKjjjEW8T7CVNV1Q5e43DJgBuHEYj6X1kPbUoT8mViWcsImisp7LBu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 272d4d66-a657-4464-3fb3-08dcfd062b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzFpQjZMWEI5WWRwNWxyTk0yRlc2b01OSG9mMzdTQmZMU0tOSFp2dzd1eklz?=
 =?utf-8?B?eXE5ZFRRaDVaU0VyLzBXa3JobDRhc3gxTTd6ZG5oeVdjWmhxc3lyV2lSc2I5?=
 =?utf-8?B?eFVxVGVTcXJRS2Rqdkd1aVUrZVNYOVltakxsQjNUUFlnWjFjNDRLemVtemla?=
 =?utf-8?B?TFlBY0FKY2NlNGFmU2tmZ0pKVEdsNVpYZkFnN01kZzB0Rms4dy9SSTBrZHhZ?=
 =?utf-8?B?K1Jza3R1NVpDK2RTbk9DZGR1enI1dTdUZmdNTzRKYWNwNW1vTlk3R0h6bm1R?=
 =?utf-8?B?N3hOQVU2bUNEbEN3OURuMlJ4NGdob2ZHdG9EaThjdFU5RFlWeTMzOHBDTjZU?=
 =?utf-8?B?bnN2ZEsvOEV6VEpjUW85amR4U1JBMzMyOGNCTXU3aHRKWnFNOVNKbTBxYVR3?=
 =?utf-8?B?N2ZFcUgvaUNPdDQrRWxUK050TmN3ck53NUNlYUJZQmVRaTViWkVVcTJMMTVa?=
 =?utf-8?B?OXZjQXpXNXNCa1lWeThzbDhVcWxpSjA1UklQbHVlZ3orWksxS2E5T250c2RL?=
 =?utf-8?B?UER6VWh3V1c1eTRKeXY4dkg1VWhYTEtGY09Wd25GdG5VWEJROHVjTDQ3M3Vy?=
 =?utf-8?B?MkRialVVRnM4YmJSTTRsM2ZIUjhBeC93V3cyUXp3SlRYeWJyVk5wYTkwSUVV?=
 =?utf-8?B?N1BGTVJXZFM1ZDcwUWRETk9DV1c5WDhYZkpRY3Z0ems2ZkF6cVd4L1hjeGNT?=
 =?utf-8?B?Z2xWTEJHREZUUUpERU16U3dRVzFxck5IVmkwSkttMC9XRndhWis0RmRMbE53?=
 =?utf-8?B?clo4dVNoNWRKRGFMS0lkV2dCUmZ4YUN0bFpNSHVudDRzQ2ZyL1RzUG5hek45?=
 =?utf-8?B?UnBmWUlDbHR5QlVaaWJsazA3WUlzOE9vdTdzdTlHRXN1blZydnVyV0w4UXZD?=
 =?utf-8?B?ODNvaWVaSjJPckxnMzRjNE5tbWhuOHRlakZaL3dlTHdadWVuSEdSbEFPS05N?=
 =?utf-8?B?VzJxaFlZM1dSQnhhei9VVi9Wa0svYUdZV1hyTWZ0TW40eDdxSmFTSUUvS21P?=
 =?utf-8?B?SUxxbGVEWmZQUVhNVkdDakp6dzVONlBGU0t6dlM0QStjVW5TbmZDS2drSVZX?=
 =?utf-8?B?dDQ0alZOVWlIbmdKaTRVRkVRbUJkV2RrVm5tRnhsclQvc1VmaHFmcjRSSVVh?=
 =?utf-8?B?QnBUUE1tcUxycFJ3L1REbk1uWVpnOSs2UjQ5TDJZeGkyQWNtTU44SEdRbGZO?=
 =?utf-8?B?Wm52YXhFUWZ2SjlqNnBNdFdYUnViOXBFQUhhdGdEd0VYVXY3TG5pNHlDdmdD?=
 =?utf-8?B?VExLQ2ozZ1M0UXJiOEtOSGwwazRNYWlrRlpBZGNpdzdYbTZtRlY2MDJoZ0l5?=
 =?utf-8?B?UTB6RXJ1TTFhU01QWDlzemlORThiME52QTZiTm9TcTFRZDNBMHN1RGM1TUFa?=
 =?utf-8?B?UFhjWm5jVVlrN2RjYlBwaTV5ZWtlNlRIQjZSZ0JBb3l6NEdTQWhpYWg3SnNS?=
 =?utf-8?B?L0RBNFhMWUR3MDAxcXVqdWtYR2ZjNStlSytqMHViaXFlbmJSWGhsZ1NFSDdN?=
 =?utf-8?B?ZHp1ZDhlVEgvVmh6bkY2U2VmeWVMZTBHUzJsWG5VaGJadVJQTE92allmQTRs?=
 =?utf-8?B?b0JpZE1vZ1B6ditqRzU3KzR2TklZNWN6Ukd1WjlZM1RWaTBTZWI1cDhBMFhX?=
 =?utf-8?B?WnVIYS8rYmZyM25TcXk4MGZEcWYwUFYxeW93L0RWRTFHM0V6KzFxWjIwMko0?=
 =?utf-8?B?d0IwNTBiT2s2T1gzVXM1eWxnVDgzeXFFM2VOeFVEWUJ0MDhTclNhWmM5Q21h?=
 =?utf-8?B?UkpaeHQ0STFyR0FXdXdaM2ZVWldOR2ROSS9UZVcrMld4Rlc2ZFhhN3FOVjJS?=
 =?utf-8?B?czZnYlFiZ1U5M0IzWEh3ZlBoSHk4T2NDc2l2ZVlnRXYybW5XUVFzN2NqL3hB?=
 =?utf-8?Q?+1YVN4K1pEQNG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWdWaWNNZmg0VStUcHhJN3EvcW1ua0ZRdm0rOHUwL2orRGNhVVNLOVR6cnRZ?=
 =?utf-8?B?eURTbWJ5aUJkWGRLRUtJNWlSNWZESzZmemhUMzJ0NlpzQk0yc0pzVWRLMm9j?=
 =?utf-8?B?Z21uYXN5YXZrTEcrTi9abnRGb3FNa3NMZm1aTEErd1Q5UzV4K0JrVmtRbFll?=
 =?utf-8?B?V01lN2E2SHNDVmxHZnRrSmNLOWdsalh6ZFZDaHBPdHVoc2RBVmNheERCQWhY?=
 =?utf-8?B?cS9KYU9IM2hhMzBFTjNPbnRUMUl3SVlFZUNGS1RmK3A4cVV0NjdZVGFhT21y?=
 =?utf-8?B?OUl6dUFJUU5hbTBkRS9BVzR5Sm5EakZjNnVBT3NPcGgrZ1JSY3BDZmppTFFx?=
 =?utf-8?B?NDZ2T1hBa0lXeXRGc0g4ODNmUXlxYzY3d0Zva1dmOUJacEZwSjVTMVJTUElO?=
 =?utf-8?B?MVhDU0JlMnpMTmpIcTNyMlE0T250blBYNVpPUGw2V2o4cWlRRDFkM2Rhd1Ji?=
 =?utf-8?B?Vlh1N0QvaC9ORUtBL0VxUUxJbzYxWkRrbUM5ejJraElRci9OZHhOeGpDODUz?=
 =?utf-8?B?bHpzdE1DbHRMeFRUM2lCNTZtREI0VFQxZjFIbGQvc3o0aEtJbmVaeGNJUHRX?=
 =?utf-8?B?aHRZK3hVK3NWOVJSV3YzcDE0YkhsOVZ4bElta2lLU0pmQlhlYitWZG5Yb1Ru?=
 =?utf-8?B?bDRBaWlRWkE5aUlRYTJiTHN3eThnVmFmWTBEa2NPeENaZVB6d2h5enVFTlQ4?=
 =?utf-8?B?NTlDcVV1MFcyQnZWQXAxYmxIMi8xNVAxM0MzU3QvQUdVNjJoTmM0a1hzcFdX?=
 =?utf-8?B?bm5tdnJoR2RCQ1NhbzUrNnVJK3l6YmFMT2k0MHBWaE1QS2EwQllmTndnTnN6?=
 =?utf-8?B?dzNMcXhoWVBJNEQybkNaUFQ5RXNISGdYUDMzWmlaMXdzYytFZ210WnhWZFZM?=
 =?utf-8?B?MWFqci9pbTcvdWVDQjFQL0VwS2JZV1hSTS9MaVZ1QXo1aTJib2dGa1dIN1lH?=
 =?utf-8?B?Nzh4ZWNMa1pXcG94aTV2L1FDTGoySithRVB6QkVhMUV3S0ljaUlWdUlCaDFG?=
 =?utf-8?B?Y1A3eGVmL1daOWZXK1c2czlKc0xyekRDMVIzQmtDc0hWOUFzSytxWklQZU13?=
 =?utf-8?B?bjRHU2V6dXV3SzNNRTBReXJrc2ZLVTZSR1cyUXF5bi9mVkFXbGc2L2V2Y1Q3?=
 =?utf-8?B?MFdkbExYay9HV0lrWGF6RVdlZWhsN0Q4OGNGamoyamUzS2hDT2lETCtqWnpk?=
 =?utf-8?B?WDhPZGVpczB5aE9yQlJRc2dnZFRkb0o0dFFYYTJ1cVNnYnNvN1psNXRnSWRP?=
 =?utf-8?B?L3JoYTB5MzIwblIyazRWWW15UStZNG5BRk1vOWpSTUwvdzNQMmQyWnJVOE56?=
 =?utf-8?B?M2pKeTU3YjV4Sm1DNm9nc0x1UW81bU9jWGh0TVVkaXB5MzNIQzhXbHVhTDll?=
 =?utf-8?B?M1J4YmlVbWJac09CRWtiUFZjcTRJcmhVWmNBZGUyV2ltMlFheXVmcVI4VWlW?=
 =?utf-8?B?cVJOQVpnU0lSRXFLalJTcXo0eEVjSlZkS3RhS0t0emg0aDA4UUw4NGFYcWpV?=
 =?utf-8?B?cWdFK2pxTm9NQjA5Y3BTdzdRdzdiU21wU3VORUl0eEljS0djR3lKK0ltZE5J?=
 =?utf-8?B?THpSMGZQTjZQa0tUMmdiVytNUnVHU2kzTXUxYlpvL2JpY1FjT2p5bHNZeHh4?=
 =?utf-8?B?eHJvamR1THdQR2tLbDdiaXhKaTMzeTdHOUxmU2pQT1ovQUtaUS9qdUl5SjZq?=
 =?utf-8?B?MnQyMWh3Um1YaHRKaWdlTFZZaTNVNE5LdXZ5VVlGdEJYa0IralpRUXIxaGxX?=
 =?utf-8?B?ODBFUFZyZjEreDRRMHR5THd3TWhNeXZTS29qb1Uwa1cwZzZFeVdZUDdrMER5?=
 =?utf-8?B?dzFrVUNrOWN6ZlJlZXcvbGMyWGJvbGhMU2taQlQ1T0R6RzAyVnJDMzVVdmxD?=
 =?utf-8?B?b0I5YlEvSkN1Q2dwM2hSZ2lXN01PekJqQm4zczlCdkV3NU1BT0o3YkVqZzdZ?=
 =?utf-8?B?cUQwbzkxckd5b2dOd1kxcEZrcUxXM1FWVmRnSmdDeEM1ZFErd0NKTE9ISjcw?=
 =?utf-8?B?VGNkYlNiSzNCZHY4dEZDbnQwTmRSaVlmeTF3ZkF0OGVwUHUza1B4blFYUlNT?=
 =?utf-8?B?L050NGVmQ1hCdXlpbjljOERLWWFTSlQwVEg2dXJ2MlFvZkVZL0pacVNhWERz?=
 =?utf-8?Q?0d5g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272d4d66-a657-4464-3fb3-08dcfd062b1e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 19:23:31.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgnyzpVLsObcU/OSN0wNt/9IaBWWsoFKv2V2zL801v3wVmOK4G4QzQRgqGfDJMv/zrLZNvXOTZAKL+qhNs57fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves examining the msi-map and smmu-map to ensure consistent
mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
registers are configured. In the absence of an msi-map, the built-in MSI
controller is utilized as a fallback.

Register a PCI bus callback function to handle enable_device() and
disable_device() operations, setting up the LUT whenever a new PCI device
is enabled.

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- rework commt message
- add comment for mutex
- s/reqid/rid/
- keep only one loop when enable lut
- add warning when try to add duplicate rid
- Replace hardcode 0xffff with IMX95_PE0_LUT_MASK
- Fix some error message

Change from v3 to v4
- Check target value at of_map_id().
- of_node_put() for target.
- add case for msi-map exist, but rid entry is not exist.

Change from v2 to v3
- Use the "target" argument of of_map_id()
- Check if rid already in lut table when enable device

change from v1 to v2
- set callback to pci_host_bridge instead pci->ops.
---
 drivers/pci/controller/dwc/pci-imx6.c | 176 +++++++++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 94f3411352bf0..e75dc361e284e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -55,6 +55,22 @@
 #define IMX95_PE0_GEN_CTRL_3			0x1058
 #define IMX95_PCIE_LTSSM_EN			BIT(0)
 
+#define IMX95_PE0_LUT_ACSCTRL			0x1008
+#define IMX95_PEO_LUT_RWA			BIT(16)
+#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
+
+#define IMX95_PE0_LUT_DATA1			0x100c
+#define IMX95_PE0_LUT_VLD			BIT(31)
+#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
+#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
+
+#define IMX95_PE0_LUT_DATA2			0x1010
+#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
+#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
+
+#define IMX95_SID_MASK				GENMASK(5, 0)
+#define IMX95_MAX_LUT				32
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -82,6 +98,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_HAS_LUT			BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -134,6 +151,9 @@ struct imx_pcie {
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
+
+	/* Ensure that only one device's LUT is configured at any given time */
+	struct mutex		lock;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -925,6 +945,152 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
 	imx_pcie_ltssm_disable(dev);
 }
 
+static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+	int free = -1;
+	int i;
+
+	if (sid >= 64) {
+		dev_err(dev, "Invalid SID for index %d\n", sid);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+
+		if (!(data1 & IMX95_PE0_LUT_VLD)) {
+			if (free < 0)
+				free = i;
+			continue;
+		}
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+
+		/* Needn't add duplicated Request ID */
+		if (rid == FIELD_GET(IMX95_PE0_LUT_REQID, data2)) {
+			dev_warn(dev, "Try to enable rid(%d) twice without disable it\n", rid);
+			return 0;
+		}
+	}
+
+	if (free < 0) {
+		dev_err(dev, "LUT entry is not available\n");
+		return -EINVAL;
+	}
+
+	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+	data1 |= IMX95_PE0_LUT_VLD;
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of rid */
+	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, free);
+
+	return 0;
+}
+
+static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
+{
+	u32 data2;
+	int i;
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == rid) {
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+
+			break;
+		}
+	}
+}
+
+static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
+	struct device_node *target;
+	struct device *dev;
+	int err_i, err_m;
+
+	dev = imx_pcie->pci->dev;
+
+	target = NULL;
+	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
+	if (target)
+		of_node_put(target);
+	else
+		err_i = -EINVAL;
+
+	target = NULL;
+	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
+
+	/*
+	 * Return failure if msi-map exist and no entry for rid because dwc common
+	 * driver will skip setting up built-in MSI controller if msi-map existed.
+	 *
+	 *   err_m      target
+	 *	0	NULL		Return failure, function not work.
+	 *      !0      NULL		msi-map not exist, use built-in MSI.
+	 *	0	!NULL		Find one entry.
+	 *	!0	!NULL		Invalidate case.
+	 */
+	if (!err_m && !target)
+		return -EINVAL;
+	else if (target)
+		of_node_put(target); /* Find entry for rid in msi-map */
+
+	/*
+	 * msi-map        iommu-map
+	 *   Y                Y            ITS + SMMU, require the same sid
+	 *   Y                N            ITS
+	 *   N                Y            DWC MSI Ctrl + SMMU
+	 *   N                N            DWC MSI Ctrl
+	 */
+	if (!err_i && !err_m)
+		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
+			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
+			return -EINVAL;
+		}
+
+	/*
+	 * Both iommu-map and msi-map not exist, use dwc built-in MSI
+	 * controller, do nothing here.
+	 */
+	if (err_i && err_m)
+		return 0;
+
+	if (!err_i)
+		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
+	else if (!err_m)
+		/* Hardware auto add 2 bit controller id ahead of stream ID */
+		return imx_pcie_add_lut(imx_pcie, rid, sid_m & IMX95_SID_MASK);
+
+	return 0;
+}
+
+static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -941,6 +1107,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->enable_device = imx_pcie_enable_device;
+		pp->bridge->disable_device = imx_pcie_disable_device;
+	}
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1292,6 +1463,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1587,7 +1760,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX_PCIE_FLAG_HAS_SERDES,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_HAS_LUT,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,

-- 
2.34.1


