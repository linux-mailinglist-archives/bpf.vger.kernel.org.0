Return-Path: <bpf+bounces-46576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C409EBE10
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 23:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94F31687DC
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1172451F1;
	Tue, 10 Dec 2024 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HpAEA4OL"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58612451E1;
	Tue, 10 Dec 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870961; cv=fail; b=Z3U9KKFeWQIKUDYJYA5S7WdE11vqerIUmI04hqYjq8xdoCpLSiaW0E/CQdGy9E8jgx8yv7EHoacpLeI+IIVs8+KKC9re71xgD0BKbHnpcXz/p+HLB9pgUCYqtw9ESDQ6rmlt2CDJuFI2yr+VrWvuF0rNjxSzqxJeqyCj8aA46gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870961; c=relaxed/simple;
	bh=r8B7Tc1ehj+CKF3MlXflpe12lppNftec6wtwsw/WefA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TDxLkl3Zo5yd7ce3u+Qo92o95xCl5skHwSiAmRoVV+yOHFod9mLwY52ZXgD2LlYtgMwpCTAcAN6AStbNXVruzu4Dban2iETFwDoVf4zdcfdt8tewXNc9e1aQf4L1YD5oiIzkAKUif07tHEfM7BGHKKc/gRLzkVUcxF/XMYr6szk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HpAEA4OL; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6tPhDNLtNiGgzUDNVxWwSaBp4lr9dZhVej6l2m+inEUFuzkdO9dd4CcPDCzLP0UkmgWbvQb6mQPxUID0RjSMX9Hz5qUKjfcR+Mj/562b1KyVpdidr9nM5hFJjEsl5WPfvGryLh+Bujct7A6Dg728BzER8KkN6IRNOShWGrEniBd/TT10bM4mxp3sa0D+R0oUr8Idf7K/3uS81/FapdB4TJ0eKBj2E6j9uoorl4Myj5e0jkueOVCbbWCrhpMlrNAnUqnynNrTHDQAlaB8J/YfNyqNvVOIIGM6baYHeYBwqcIDB2cdtwBgADEGDLDdxhI6WvuEA4+WDXcA5d9rLRRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUPf9JNxqpyt2sjlc2k/yXvL0Tv4zYS3R7hLyi6TQF8=;
 b=jrULXOnw1SQT575MlrP42/S1AZDV8bQIy4Vq2rp5Z6+JDXQ7T0snJjcm/waz7T5cZTVjyoQzCOPs1nWRMNylSU0/G92iJXqqqcxrSFwQkNfXDFXkzPCj98alMc3NCR9Pza2ieXTZKerwm9BvxIS8vOU8lQaQqT10UjG0d86hO9KFQE+RIoNdagCsDftgyStG6Diy//6phgoEnZu+JYsmXSlFYej794k7OclfD6z0nW9Yx1UX1QhrWb2jMQ+9scaFFXZajsXcilUeL++uT/hV2M+ZUlZwTtWrCMVnd8RNroPl0MkGkepXo/tFj+2kdBoitAnLLP48M6YXs3Omu2rm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUPf9JNxqpyt2sjlc2k/yXvL0Tv4zYS3R7hLyi6TQF8=;
 b=HpAEA4OLKYn55jxaXeLN5LXVd2T5cCELQeUsdoTdEvg9VwcxVxdIoEXTfoYSTal7ubdWmglItElwkjB2tyw2Qaou/qV+3uTj1gmSlf0Cl/Tf93dtK3/hXcDs7GYy7THcrYKVuykvTlyocm1fv+GjZ0O5wHiqLTEDz05Q7zow7Xuh9cMgFkdzMpHDv1mIbehTKbOcR34rwwwxzQa4OJZS8wC57l9WZ6luVDLRXXMe7pCag4J1I1h2OLvaJuWXYYzBYfigfDsfAyFmz5LGXCIyhi7viVbjpOpUzyHNCM1gS7ljHedR0P4jqjTTlsLFnMND0mSjpB8kJlbBWXFIepCbvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6784.eurprd04.prod.outlook.com (2603:10a6:803:13e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:49:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 22:49:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v8 0/2] PCI: add enabe(disable)_device() hook for bridge
Date: Tue, 10 Dec 2024 17:48:57 -0500
Message-Id: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFnFWGcC/23Q3UrEMBAF4FdZcm1kMpOfxivfQ0SSNnEDbru0a
 6ksfXdnV7CpeJGLE/KdYXIVUxpLmsTT4SrGNJepDD2H5uEg2mPo35MsHWeBgBo8WllOizdvH58
 XqVrbIGICr7Xg9+cx5bLcu15eOR/LdBnGr3v1rG63/7XMSoLsoLUIjetiiM/9cn5sh5O4dcxYO
 YLaITuKVlsXgyEf9o5+neJTO2LnDPjWR57W2L3Tm1OgaqfZQe6yD5iTM3rvTO128wy7nKJ3mCk
 r+rOfrZxqamfZBfRGxaCItNs7tzkEqp37+c/OoidEkza3rus3fxT7R/ABAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733870948; l=5050;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r8B7Tc1ehj+CKF3MlXflpe12lppNftec6wtwsw/WefA=;
 b=y+IX8aI4/B3sOnNwv8/vIQYu2cgYYA9aIR3OUlBWjGtXUya278ZKW+LQC2k7yZXrMg/TG8a8h
 p20BJ5hWvyEDe0ASQ2VNlpaTkh5wSEnnRozko0IFaILyDtq2fpeesZD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: e54d64d3-4def-4f7c-0be1-08dd196cde91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXZ2eitKSitZK2lBa3F4VGZ3Q1FMNk9iUDB0RTJJZW0yRHJ0dUFvZUJTTi8x?=
 =?utf-8?B?M2pubzZBNTlrZG9ldE5naGJ4ZkNRRkJQY0tuVW5GbXBVUU9LV1RtT1hOQUdD?=
 =?utf-8?B?Y01MeWgxTmpqU0dISzhCRU5TQk9lSTM5OWhZVUhQc04vTEtWTExxR1Nybmpp?=
 =?utf-8?B?Yy9TNU8rY2lVSXFOT09qYnRLdk9ER05RWFdWMmsvS1NMTnF1a2JDNURnZTFD?=
 =?utf-8?B?cVpXMTh4NFcvZzJmTHBKT0VQN2p1MG5CVGxjZmJFeEhwYmcxa3owQXJURk5B?=
 =?utf-8?B?aUQxY2VpSnlicWcrMnJOZ0pld0Nuc1p3Nnl5dkFiK1Zsdml1QS9ONDcvYzlO?=
 =?utf-8?B?emJ1Z0VwWWk0cUVMMmEwQkt5aXBWUjJRaDZzcVdmV1RZUnhJV3BMS3FEVkFM?=
 =?utf-8?B?RHM1NEpQS2JSSU9sVmd6SlhBTEpqeURlQXJhd2FpQmtCT3dUQlFYc0RieXMv?=
 =?utf-8?B?d3RFclg1ZHBEZUFaWFVpanJTQ29sQUxEalVkM2xhOTVkUnoyMGtJaFBIWXRw?=
 =?utf-8?B?bVNSOHFUOVV6YUNsczJNZkxXZTVueWtqWTd6N2FxRXJsWmlIeXk5elYvc2U3?=
 =?utf-8?B?bHdnbmdxcnN4VkhJZEtkN01sQjhYTjBMcjZNdVZacXlMWDdnNWw4UlZ4WTlS?=
 =?utf-8?B?VGU1K0hXaEJicnpmNXJ3YmgwSDhxK0prd1FYbkdUUk9XWmMwNElkK0V1MjhE?=
 =?utf-8?B?Nmo3cDlybnpMdUhOTHhpNW9ubng2S2xjWmJTdmpWZ1E5Vm1XSmxZR2JWVDcr?=
 =?utf-8?B?T0JlYTlzaWkzcnV1WEU5eTR5cmlJODRYRkhjQ2NrNVVRMHZ3TWp5Sll3MUp4?=
 =?utf-8?B?dXJBVlRFUDM5SEZrdG40ZlpkWFVCNGJTKy9xc3dCY0tXNEo5dzRvUGswclc5?=
 =?utf-8?B?bWRpSnJmZDkrVmNxRkV1QzQ4Tmt4WkkzbUhGWkV5RzRxRFF0dmFtMldJdU55?=
 =?utf-8?B?cFZLVTloOW9NeU43ZXgzK1hrTVlOakJJbkhkQnZ2NGZ3VXljdjNvZllnRnVs?=
 =?utf-8?B?SXRPNGluQWNsR0tIcmR6K0Y4RVdsTktTcElQWXA1MENUS2dLTTBWK0tVaXNa?=
 =?utf-8?B?eW5uZ2lxK0ZwK3FHS1kzY0ZTZXJHRkNPclE0TkVlTThPZXd0YTZrcHIrQlRm?=
 =?utf-8?B?TEV6dWdGSkNzQnBja3pvdEpkNmV3K05RMVpQbGQ4NEZXanVITkUwcDBXdVEr?=
 =?utf-8?B?Sko0UFhYRnk0N2RrMEE4SjZ3N0JWSnJOTG0zakhCK2hsMit6U3lnbHJBQWxN?=
 =?utf-8?B?YmpnRUNKV054aXZkcktyM2ZjaUhHSGpvNi9BQTJJSzlMTFBwZTAvWFBFekRM?=
 =?utf-8?B?Z0xZU292bzF5YVhRamVMcTA5QjhiY2hYTEFQeFFTWDEvTkFSQURwT0ZrR3I2?=
 =?utf-8?B?Wnh5UTJQakNiYUw4V1c5NjVCeTc4UVpUQjN2RDIzak5MT2V4eTRuWWxPZ3lp?=
 =?utf-8?B?emZiUVBBQUpJSHE5TjBlQmZ6MVZGV3Jza2JBZ09TVndIcE9uNGtIRTFhTkxi?=
 =?utf-8?B?TVhMekpyamlwQWg4ZHFQMG50MEx5YWFoeTBMcmh5V2JkOEtSb0RZQnVqdDhk?=
 =?utf-8?B?bXVHb2JiZStSU2FrdnZzYjRLeWlDMGNPYnowSlVXWGZLWjB5VzcrS2NtOTZ5?=
 =?utf-8?B?U0RVZGE0SVlhUVpuaDd6bWwrYUMwRWR5bzd3VTRocURnVWNhU2NjZDk1cE84?=
 =?utf-8?B?ajk3NmoyWkVLNkYzZ1FvSWZYeTI5cTg3eDdYVlo0RExEblQ5aDhtclJBcE9T?=
 =?utf-8?B?Y3oxS1g2TTBGQ0loTXAvR2ZyMTVNSmNBV3lEMG9oR1drNFZkaFhrbFZDZHhG?=
 =?utf-8?B?cENEd0NlZ3FVSmZEVWd6M3dHVjdnWmtmVmtLanVZU2ticlFqbFVYakt6VVp2?=
 =?utf-8?B?MHpxSys1dkxPYWZvdFFPVHl2TDNhS3RqQnpldXdIQlRoU0pQNW1rMDRTc3hJ?=
 =?utf-8?Q?rshzE4SBVms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjJ1enpNRXE2MHdwUXo0RmNoWlNQK0ZiWmZOQy8yb1hTKzRUc1hJaXRXWHlX?=
 =?utf-8?B?bkc2cy8vNEFTNld3QUdUT2I0UGp3dk02QkRKWlhDbGhFWlJhd1dqaEJXQ0k3?=
 =?utf-8?B?Wk5SS1ErQXNzYUkxTEVIdGNxdXBkWHAwQ0I5cThacWxmbjkvMkRyQmhMTksz?=
 =?utf-8?B?Q0FiS0xid2txU2Y4MTJScit4UGhpbCsrN09iVHJLYmZIcWpkOVJhU2NoSS84?=
 =?utf-8?B?TlM0MUIvd0VWVEczQnVnRXlNNEgyeHF3enlHSlRnY09jbjBGYzhyQW1vR1Y1?=
 =?utf-8?B?OU9FV2ZzYmczSi9kQ3NjaXRwY2FHcnlScnllMDY0eXlwVWZremJMQ0hsTjM5?=
 =?utf-8?B?ekp0Q1NURFFuNDE1VlFLZFluV29HeVNENXRsOWRMVXlXTTBtNFZ0MWtzSHN1?=
 =?utf-8?B?QWI2am52aDdtQWIvTy8wdXRQK1NxYzUvOUo3UzM0bzNYcUxzdWFQNkEzVGJ5?=
 =?utf-8?B?b01sM0ZQQnFpeGxvWEdzdHZBTHpaeUhWczZaQnZ0bWtLZW1hMHRsM3ZPNEU4?=
 =?utf-8?B?SzNlK1RhblBrNitwQmlyNTJtYW5zZFJkMGR0WHhvZERURDBianFMUTFRQ1Yz?=
 =?utf-8?B?YllLQmEraXRCRVBkNmFZUlgybTAvSjRTb2VzRjdDNUxLZ3dJem50TW9saDUz?=
 =?utf-8?B?dFE2QnFnS1p1aTdabm51ekZMdHQxMStudDVoNGFQaUxoeU1lMjVMbmNURWIr?=
 =?utf-8?B?R1NTeXNXbHpPRDdlMFNNYXBMR1JIR0VaL09uUGFRZmMvTDAyOWR5MzdlNFdH?=
 =?utf-8?B?bnRrQkRSRTVWWVF4ZmxlSHlDSUltZ0k3ZDhKRXhlalh0MEM2ZlpFMGdNdjg0?=
 =?utf-8?B?cERuWks0WFlUL29YLzZDdUxza3NxR1lqcEJqKzBVK0NYUlZSS29IdGlwaEpm?=
 =?utf-8?B?QWZSUXpQTnJqYitxV0tVRHZtQTVwUnYxUlJtdGJ6eW4rQ2VwcEd4THAyNnVK?=
 =?utf-8?B?RnpmTUt2WEt6OEtXclZwUXcxWG55SXloajBOQURLbUVQcVJCeVRqWGFqQ3RO?=
 =?utf-8?B?Y0pzWng0OXdoMkpqNUFJOU5RcU9wbGRrTnQrOGFYV0p6WmtjcWZ5K0FsdnB4?=
 =?utf-8?B?ZnRBTUZXWmpDV0RQdmNaS0ZhUHVxQm5LQ3hKa05qR1VBYkZRRmQ1enc0cGhE?=
 =?utf-8?B?NlZrODBhd3hOTS85b01uQUdBTWdlajNUbWVSUFU2RkZoMVhjUi9yczl4d2tE?=
 =?utf-8?B?bmNSYVAvc2NpOTBGR1pNZm5hS0JXS1NNZlZiODlKV2N2cUJ0S0lPU3B3blg5?=
 =?utf-8?B?UW1uM3RWMzN3QU02WXJYZm9EenNvMENuVCtLQVZwTWp2NEJEK2F2akhhaEdP?=
 =?utf-8?B?QmtFeVIwRGlXUXdDZE9RMUlRZXF6QkltZGVXQ1NlUFN5eFYzNHEzdnBEbXpU?=
 =?utf-8?B?WGpYd1JqYTE5eVg4MllCbEZxd3hKWS9WOGQyTThVcS9oR3FNK0d0VGlKa1F3?=
 =?utf-8?B?TnFVK0k5V3VPMzlvSXNqVlg5RXYvWkNPMkl2RnFqMWxmUCtzcHdGQ3YzaDFa?=
 =?utf-8?B?cG5FUDIrZDdCU01EdnZnQm5xNC8ydWNDZmI5Tlk4eXNzbWhaYlhRUmllUUlQ?=
 =?utf-8?B?T3RQUUdlNmtlQWFhWGZFVy9tc3pDcGxPOE43RWdJTEtzN1FmNW9qWW1pY2xv?=
 =?utf-8?B?WDFwSlJyM1JrSmN2Q21Md1ZLelVpQTYwTmJkME15Y1ljZ1dncitkRlVwZWtQ?=
 =?utf-8?B?bHkzSU9ITXp5OFdsaWJjRi9uNnl4UklLU0srb1NHTEtMS1F0QVV2d1lRT1JE?=
 =?utf-8?B?dzA2cmJidkt2WTgzRzhvZUgreHZBR3VRMjI2YjA1dFhiRHVENjYrL1lOVW0y?=
 =?utf-8?B?aTN2V0NNU2ViYXg5cWRpclMxVHlsOXBpc3dqcjZSOVpRV1V5WFAwbE8zNzdL?=
 =?utf-8?B?dFNFbVJ6RkF4dHBEa3gxNDV1bVNRNFZ2cFpXNXZNU21YMmQ2bjlxemRVRlM5?=
 =?utf-8?B?cFVleEJpQ21IOS8vd0UrT2RWRWhlSlJjb2pnRnk0OWV5b010cGw1ZE9ncDVT?=
 =?utf-8?B?UCtDUHZIdm05TFExUnJ3bHJrSjM3WHFuVnhqTENmS041dG03TXUreTUzS0VH?=
 =?utf-8?B?bWRzclRaSmxka0s3d0hKcVdZSGtGY2lXeG04TzRWTEJBTVp5Q2NWeUJqejMx?=
 =?utf-8?Q?UD4+SujbIrVQ3bwN+g2RJeftF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54d64d3-4def-4f7c-0be1-08dd196cde91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:49:13.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIYj2m/1J2PWhH8Wb2DgMdh0O2qcluJ3Bzld13EOn7di7wH4b9EYZqRbDwJVYWnOh8ee5k0c7/JvBtreiRmRVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6784

Some system's IOMMU stream(master) ID bits(such as 6bits) less than
pci_device_id (16bit). It needs add hardware configuration to enable
pci_device_id to stream ID convert.

https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
This ways use pcie bus notifier (like apple pci controller), when new PCIe
device added, bus notifier will call register specific callback to handle
look up table (LUT) configuration.

https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
table (qcom use this way). This way is rejected by DT maintainer Rob.

Above ways can resolve LUT take or stream id out of usage the problem. If
there are not enough stream id resource, not error return, EP hardware
still issue DMA to do transfer, which may transfer to wrong possition.

Add enable(disable)_device() hook for bridge can return error when not
enough resource, and PCI device can't enabled.

Basicallly this version can match Bjorn's requirement:
1: simple, because it is rare that there are no LUT resource.
2: EP driver probe failure when no LUT, but lspci can see such device.

[    2.164415] nvme nvme0: pci function 0000:01:00.0
[    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
[    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12

> lspci
0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)

To: Bjorn Helgaas <bhelgaas@google.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: Frank.li@nxp.com \
Cc: alyssa@rosenzweig.io \
Cc: bpf@vger.kernel.org \
Cc: broonie@kernel.org \
Cc: jgg@ziepe.ca \
Cc: joro@8bytes.org \
Cc: l.stach@pengutronix.de \
Cc: lgirdwood@gmail.com \
Cc: maz@kernel.org \
Cc: p.zabel@pengutronix.de \
Cc: robin.murphy@arm.com \
Cc: will@kernel.org \
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <maz@kernel.org>

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v8:
- update comment message according to Lorenzo Pieralisi's suggestion.
- rework err target table
- improve err==0 && target ==NULL description, use 1:1 map RID to
stream ID.
- invalidate case -> unexisted case, never happen
- sid_i will not do mask, add comments said only MSI glue layer add
controller id.
- rework iommu map and msi map return value check logic according to
Lorenzo Pieralisi's suggestion
- Link to v7: https://lore.kernel.org/r/20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com

Changes in v7:
- Rebase v6.13-rc1
- Update patch 2 according to mani's feedback
- Link to v6: https://lore.kernel.org/r/20241118-imx95_lut-v6-0-a2951ba13347@nxp.com

Changes in v6:
- Bjorn give review tags at v4, but v5 have big change, drop Bjorn's review
tag.
- Add back Marc Zyngier't review and test tags
- Add mani's ack at first patch
- Mini change for patch 2 according to mani's feedback
- Link to v5: https://lore.kernel.org/r/20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com

Changes in v5:
- Add help function of pci_bridge_enable(disable)_device
- Because big change, removed Bjorn's review tags and have not
added
Marc Zyngier't review and test tags
- Fix pci-imx6.c according to Mani's feedback
- Link to v4: https://lore.kernel.org/r/20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com

Changes in v4:
- Add Bjorn Helgaas review tag for patch1
- check 'target' value for patch2
- detail see each patches
- Link to v3: https://lore.kernel.org/r/20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com

Changes in v3:
- disable_device when error happen
- use target for of_map_id
- Check if rid already in lut table when enable deviced
- Link to v2: https://lore.kernel.org/r/20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com

---
Frank Li (2):
      PCI: Add enable_device() and disable_device() callbacks for bridges
      PCI: imx6: Add IOMMU and ITS MSI support for i.MX95

 drivers/pci/controller/dwc/pci-imx6.c | 186 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                     |  36 ++++++-
 include/linux/pci.h                   |   2 +
 3 files changed, 222 insertions(+), 2 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20240926-imx95_lut-1c68222e0944

Best regards,
---
Frank Li <Frank.Li@nxp.com>


