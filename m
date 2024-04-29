Return-Path: <bpf+bounces-28137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C81958B60D3
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4B8B2175F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C76128801;
	Mon, 29 Apr 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m6Jyhjr6"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5301272D3;
	Mon, 29 Apr 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413434; cv=fail; b=tw4DLTXJQKOps0yRqE+2fQ3gS+AL5sZGiEvc9EhTlN58TchfX4Nxzflrk0AGziUZgguYv2ApPsuKToUnlORHrtJy4ISkwIsHSCTwfMSGTl4LQmHQIqLHjt3fxxa6wBQYzPNCZZ/tqFqyrAybnZaOGAL4sZijwOGgXfG1YpWvWP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413434; c=relaxed/simple;
	bh=knpCj5KrQ3FTVNinEpcCU8fvK3p37XvYXEuB591dlkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4KUh6gVIr+oKKvZ4Fsl94U53H1VE/P6O1UDZ5SJgaSdK04D3wxlyfYeov3POiqEAuAdSnCkDJsFiRzrW4TcZwk6xDzERR2Z1Iv85RfGqBiT0LmqwEY+NAlsqbrZ+5PXnZkrXdwlIW4vcxcGlDwsVh7d0raLiMYc3gOyCI1qyXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m6Jyhjr6; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBolvVx8XiGr02FLXOt7Zbyhbbx+3fmqT+OvAyYEVnT3j6xhKPnEXiH3r8KkP3uTXIgUrzBg6HU4kiY+4RT605QiUZIVhfK589+c0+oEo7Ag2SDlnMF5cEvHa+F7PXcAcQrmu8Wk4C8DrABxtvjjVvuWCdIkVY4rhfM+CnFyozzZxHrhSMYm2KilFbAW+95DWH3IqWcKALYR1P7rjRlo4HMAz0pJCOUL0oEAJ952CEedib9vG3FY0zhR06DCXI/oj0OBK13TMnIQ5+SvaRKVlCKB2i3b6hsBzePylrh9GmQJqK50uaailw/hhO6P2aoi3QuCvrMds4BCiYFRBXAWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pVIPnL1T+VffhrUBtg4XejujOxKRvuuxGNxIYcivlg=;
 b=Ys5xfqoSIWWhQ0dAYw5RUMOQbH8tdGEFOAMeOAsmDYAYQ06zIRD45LoIQ41odpLvKVTGx3wlRHXcLGCfn3UIn0DkTfjZNOgU3WBpNSHpwi+q8viaHCWGFkj5XEEGi+CjTqd2JkTBKH4wTfU442qyohBbmWYVTVbSHnozVEpqPq8bYm4rE8PXFX7YBOhl1K/ubjnySB+bTCQ6pRxfycK1XjIr/iMTjXzu3Jqa7rIZTcUD0a4RXNu4yLme9u9M2LFyMAqblH5CYr47GP56pS8iVvM1PSnez5MG8bqd3lajofeMuVwvHIJVxaaMbVT8glS58eXbStQLucvkVfEY1AMOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pVIPnL1T+VffhrUBtg4XejujOxKRvuuxGNxIYcivlg=;
 b=m6Jyhjr6JSKf6Vef4Xi3kFS5qTr7oPOGdZOpI9Gj45Qy+VY/PVCZ/iU9WFuHF2ZyDXHEpsX8cw0UDO2kAOvGBjsKoim1iD1NMTrmOD3eeWybvi3PIIaG4P/tkrNPpy4syoVe3q9iH6J2ewnGBLte+zZBdwt5el+DB7Yw6JCHNAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8042.eurprd04.prod.outlook.com (2603:10a6:10:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:57:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:57:08 +0000
Date: Mon, 29 Apr 2024 13:56:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 11/11] PCI: imx6: Add i.MX8Q PCIe support
Message-ID: <Zi/faud9ZrlsA9us@lizhi-Precision-Tower-5810>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-11-803414bdb430@nxp.com>
 <20240427114736.GO1981@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240427114736.GO1981@thinkpad>
X-ClientProxiedBy: BYAPR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:a03:54::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: a44e171c-6efb-4571-69aa-08dc6875c9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjVaL0hTZDhyc3pPNG51MVAwNXY3cElodHFMdXhSUC9GTGNaMWRSKzFNVXhm?=
 =?utf-8?B?M3N1RHpIaWpDdzlucVpsVVFWRnVxN1FOYTQ3QWc5NE5MVWVtbXl1aVZ3WUtE?=
 =?utf-8?B?ckR2QmpCczJZcjJPeVRnN1VVUUhRK0tDdS9jdTVrWUlYc0NNVFMzcWRVcXpM?=
 =?utf-8?B?UWJLR2JkK2lZOGtWQ2FlM3pvaHkxemE0OTVXc0pqOHQ5RjRNZlFGQlE1OWp6?=
 =?utf-8?B?ZXhmNWVrRlpLQU5ucDI3RWR3S0VnYmxRYml2cnpCMnBCT21SNHAxa0R6SnlN?=
 =?utf-8?B?dzZiMVRjRCtIcndoblNvR011a1pxbUFkRzdLNGdSUlVQUmY1NEtzenJuME1k?=
 =?utf-8?B?b1FxTUdpUTloMUtyRkM4N3cwL0kvanpvNjhXY29DTVRzc21YbW1uaEQ2MHho?=
 =?utf-8?B?TVpjcWNhdkRhcWtGK25wUlI5YXRwc284MUdaVVkxZG5BM0dRVFVPNFNoTHUw?=
 =?utf-8?B?empSbzFBb3Q3c2wyd0ZrRWY2NHNBL1Z5SC9tSXJYelBTOXRJMXVGT21tL0hT?=
 =?utf-8?B?bEYwSXd3MkEzQzhrc1hYdWMzeG94MGpXbjVrWElrdFlxWG1wU2lLem03RkhM?=
 =?utf-8?B?ZWlhSlJ5eHRQZkhFeTFTM3pxYUlML2hTOW5Ccnh3SkpXRlBsZENmYnR6NEFJ?=
 =?utf-8?B?OTFOYzFEVU9KUWVDMXB6L0pobnRRcDhYZC9CWXM5Wmg3VmVJeVpNa0Rwd2FM?=
 =?utf-8?B?RFkxSDM3Ti91YStKSGJQZ3lldlhXTWdCdWRyYXE2UU91TkZZTjZ3TmhUdmJz?=
 =?utf-8?B?VXIySllJSmpJZFEzNE01dkZUaUxacFJtOExQL0hkai9vVy93NlNpRlpZdnpE?=
 =?utf-8?B?OEN0N2p3aFFUWDJ2M0lXZUhEN3ZtNVlDTGVBaU5pSUN3RFFCK3BQampBMkhy?=
 =?utf-8?B?bXdlWTh0d1RmSkg2Y3hzd215b3Rqczc5TnNYZ0JhS2RDU0NlVDAyMGNoaEpO?=
 =?utf-8?B?UEx0M2RVUWlKVG44bTZITUNXaTVka1E0c2lYTFo3S2lra3JEWUF0Ni8wVUlT?=
 =?utf-8?B?c1JvOGhuUW1QQ3JuQXFWREtUaUNScCtLbEtHYVFBVGY5MDdldzZqT0lhMHh6?=
 =?utf-8?B?RWhCNDZNeWZ4U0NJVEI2Nm9Fa2UvZldPMkJqUGlYYmZyemJKNVRneHpBUjZD?=
 =?utf-8?B?Rk1PQ09mWjBBSXVTcmpvMmhvMjZtY01HaXR5NlBid0R4Y2FtQkU5cG5aemZp?=
 =?utf-8?B?WmJkb2ppNHhPZk9NYmFYaGpwK1krd0h1QWRpV3Y1WTNLNmhueTlONDczSUd6?=
 =?utf-8?B?WDE3R2w5dFFyZmpmVmRoNjFDY0o2NG9qc2JpSEh3bUw0MFdYY0kzMC8yL3BR?=
 =?utf-8?B?MHVFZ0c2anNQSmZ4bW9BMFFjdXQwM1dzY3FKNFBrTGpxb0x3WTNwRWtEUjJn?=
 =?utf-8?B?U2pyd0hob05STGI0MmhEaVN1VHBIVlhmQ3JabmEvMGJNdTh3Sm5LMGp2NDZT?=
 =?utf-8?B?N3hoRUVodERjanRCbU1XRDgzU1RoellIMFRxdEtmSy9MQXZZanBnSXFiNS93?=
 =?utf-8?B?L2xKbHYzMWxWcFdYQU1RcGVKOURGeFdBR1JsWmtEaVJGcmozWGdFbU5jVDlZ?=
 =?utf-8?B?WDF6bVJON2V2ejRtdm5GQmR6NWc0NWdCYjZFQkZkc1Y0RlNsOXNHTGdWYU9r?=
 =?utf-8?B?SUI2and0eTUyVTFTd0lGVFdRaGtjRVBWY3dhcURWZ20rUzRtVkoxY3JPNjNO?=
 =?utf-8?B?NWx1UlFoTTNESmM1RGZ2ZmNlZmp5Ymtwdy9FZ3JXd25aMzQzamZPM3lhWG0w?=
 =?utf-8?B?WTRZRnRoY081TkRRQ2dmTFFhZjZRQlZiWU1Vd1QrS1orT3BXMWtmQXEvazFL?=
 =?utf-8?B?dFVaU01ub3RHcE1waHJ3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmRDM3dQYUpta09zUVJPT0src1JRQjQ1aUdrYlc3V29HSjhPUWN3QWxtcFNZ?=
 =?utf-8?B?SGlncCtKNkJRMHduTDg3ajdVVlRKdHh4b2NDTXpsOFFac0RHTlpjZXVtbWJD?=
 =?utf-8?B?TG9LeENZclVINWU1bldHZUZaeHRIY2hBOXZIVjZ5UktPS1pVbXBCb0NCUzZE?=
 =?utf-8?B?cUYyNUJoZFlYZUNYcmZYdEU5TCtxMUd2UDcwYUFrZnZva0o1YSsxMm1yMEJs?=
 =?utf-8?B?dURkQUJpOXE0Y2l4dm5helNkQ2RLN2s2VzFmQVV5djF4QzZDU0NBSWNyTHUv?=
 =?utf-8?B?WTNicEU1TVJyNHpLT2JOTmNpOFcrbm40QUJoRm04L3RkL2tIWUV6d05VTkor?=
 =?utf-8?B?WTZDYnJZd0ljNmJ4alprSzJBOWFQYjlqNlhVZmE2WXdiWUU2QlYvTzVJb1Bp?=
 =?utf-8?B?c21QNW1nQWd2ZFRpYkJva3V6SkwrWUFvek5UalBTcWJkZ1FJY1N6ZlJlQXBv?=
 =?utf-8?B?Mk9Pa0RiUnh1ZXRxbUwwL1JXMkhqOGtnbjRycFFLaEc2ZEYvWEhTNDVkZTdu?=
 =?utf-8?B?U053RnpLTzZrMDVsQXVOMzQwSGlxVjR5b1dzTk1lZUYxQUNQNGlUSWwraHJI?=
 =?utf-8?B?QVQ5b2d2VlFQQ2NKTnp5YzVOd2VaeW9YYmJncUR5YUpxOHdJRnQ3VUpFRGJJ?=
 =?utf-8?B?NnFJQklFRGtoVUtuTWhueGQrZStIWkg4dXQyZ0NVUEZ6YXA3eVNScXlrTkVs?=
 =?utf-8?B?eXJjVmpqOWpkYWZ3RE85STBsdmZkM1FyS0J0NFVqTElyVEl4NlZ6YzR6UTBG?=
 =?utf-8?B?VzZqZldWMGd1aXM1ZUhOQVg4dU5tYzArVDlma1JuNkdrR2I2Y2xCczBCVGNK?=
 =?utf-8?B?M2RjUWlZWUdhelBRb3ZqUTBlZ3B0eFJiRm4zTk95Q1g2dFpyYkNKSEF3NkhT?=
 =?utf-8?B?ZEVrTnFlWXZ3dVRGNUZMRmFKN0dBc3F0NTZyeEMwLzF2NFhmMVo3RTRDOFM3?=
 =?utf-8?B?NzlCTGxTR3BkTXBEM29zNStNeGhOQnNMRTFzcTE3SDlGQ3VNbnhFc2wvMWlS?=
 =?utf-8?B?MHgxRERuNDJwbHI2UzlyM1kwWmtkTkI0cDd5UnJDdGhEdk1ZbWJvSTRPWThl?=
 =?utf-8?B?TVJTcjN6OUR4bUJtYmNWVjVRK0NydVZkQnErcW41dVc1K2JKajJFTThOU1Bh?=
 =?utf-8?B?T1RrNVJvWGZseUY3clVkSmlMcExqN0xGbnJtM3Q3N0lOb0tPQjkyRjNEMUN0?=
 =?utf-8?B?TVNCQ3QzZ2lUdnVtdEFsd1dnL1ZBR0JZRzFXTkRmWHNZTnhPMGRrRE10MGZK?=
 =?utf-8?B?ZmtJRU4zdXlRMk9COHNYeHZVMUJBMDN3UnlTRHNmNUprd0xISVk5NlF3eUZw?=
 =?utf-8?B?M0VOVGZLY0x4NkV4Q3NvQnZDcGsvSFJhSXVWWW5aN3MxaHdVYWlvMDdQOEM2?=
 =?utf-8?B?UHg2ektrZFViUS9scEJLUm9wT1RoZ0xqa2NZN3E4aXhQNDhac2JOWVRWSUdM?=
 =?utf-8?B?amdNYU1rMHdFWjVjTnd4L3JVZkhaUndvWlBPV2locGNaZlhZdHB2N0FNek9y?=
 =?utf-8?B?TEEvT1JESEVUYmhhbEZ5MHJmRk15VVVNZUU0c1dUdHpkQ1JPVjlMME1XbWE4?=
 =?utf-8?B?aW5Ia09BWnR5Slc0SDZVcVNzL0Y0RkxKeC81c0hOY0s1Y2prZzl5cFY4Sld3?=
 =?utf-8?B?NURpemZhWlgxRmpaUnRjeEtLcXRJSjFHNFVqTVk3WStvdXFrSHZRcXpFZ2RO?=
 =?utf-8?B?aFdpeURpbWFJcU0xYXJpa1QvRkg0dFRBSzVHajd0OWxYU2d1eGZ2VDZ4K3BW?=
 =?utf-8?B?SmpOL0k0T2E2MFF6YjNobWhlMlRpSVZ4WVZlQzlraCtWS0NiTHlwbGxQeUZP?=
 =?utf-8?B?cC9ueCtlTmxhYlk1VkNyTlJUUGpqNzkrU05XaTV2Y05kRHhyZmRoTVVZcXps?=
 =?utf-8?B?UWsxNWxPYnlaREFSU3d6ZEdKb3hkcGRtTHlWb25YL2FlalZxdU9WbmlHbThs?=
 =?utf-8?B?NVRwUHpoU1JUSVhhTHhVNGdYaGFhWHV1VzROY2VTZnVuTEtFUTh1a29weXVx?=
 =?utf-8?B?V1JZcUlFNE5vdnI3cnhVdXhUa3JvaS83YmxyVnRxZm4zd1BsTGJCYkovWWEz?=
 =?utf-8?B?aEV4ZjdxMThKcnBtbGwvQ3ZqR0FIempQa25ab1lTbC9NY1JCNmZUNmhXQmc5?=
 =?utf-8?Q?aCDw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44e171c-6efb-4571-69aa-08dc6875c9b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:57:08.5190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08yrVakjn/kK0Bj6sqdoVZY5AUEROAfewkmPL3bEwe5Ixwps5vx8YP0YmQPGfkVbbDH4t4BRhyJsFIbSC7W/eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8042

On Sat, Apr 27, 2024 at 05:17:36PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 02, 2024 at 10:33:47AM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Add i.MX8Q (i.MX8QM, i.MX8QXP and i.MX8DXL) PCIe support.
> > 
> 
> Add some info like IP version, PCIe Gen, how different the code support
> comparted to previous SoCs etc...
> 
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-imx.c | 54 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
> > index 378808262d16b..af7c79e869e70 100644
> > --- a/drivers/pci/controller/dwc/pcie-imx.c
> > +++ b/drivers/pci/controller/dwc/pcie-imx.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/reset.h>
> >  #include <linux/phy/phy.h>
> > +#include <linux/phy/pcie.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  
> > @@ -81,6 +82,7 @@ enum imx_pcie_variants {
> >  	IMX8MQ,
> >  	IMX8MM,
> >  	IMX8MP,
> > +	IMX8Q,
> >  	IMX95,
> >  	IMX8MQ_EP,
> >  	IMX8MM_EP,
> > @@ -96,6 +98,7 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
> >  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > +#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
> >  
> >  #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
> >  
> > @@ -132,6 +135,7 @@ struct imx_pcie {
> >  	struct regmap		*iomuxc_gpr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> > +	u32			local_addr;
> >  	struct reset_control	*pciephy_reset;
> >  	struct reset_control	*apps_reset;
> >  	struct reset_control	*turnoff_reset;
> > @@ -402,6 +406,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
> >  	if (!drvdata->mode_mask[id])
> >  		id = 0;
> >  
> > +	/* If mode_mask is 0, means use phy driver to set mode */
> > +	if (!drvdata->mode_mask[id])
> > +		return;
> 
> There is already a check above for 0 mode_mask. Please consolidate.
> 
> > +
> >  	mask = drvdata->mode_mask[id];
> >  	val = mode << (ffs(mask) - 1);
> >  
> > @@ -957,6 +965,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
> >  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> >  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> >  
> > +	phy_set_speed(imx_pcie->phy, PCI_EXP_LNKCAP_SLS_2_5GB);
> >  	if (drvdata->ltssm_mask)
> >  		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
> >  				   drvdata->ltssm_mask);
> > @@ -969,6 +978,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
> >  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> >  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> >  
> > +	phy_set_speed(imx_pcie->phy, 0);
> >  	if (drvdata->ltssm_mask)
> >  		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
> >  				   drvdata->ltssm_mask, 0);
> > @@ -1104,6 +1114,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  			goto err_clk_disable;
> >  		}
> >  
> > +		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> > +		if (ret) {
> > +			dev_err(dev, "unable to set pcie PHY mode\n");
> > +			goto err_phy_off;
> > +		}
> 
> This is not i.MX8Q specific. Please add it in a separate patch.
> 
> > +
> >  		ret = phy_power_on(imx_pcie->phy);
> >  		if (ret) {
> >  			dev_err(dev, "waiting for PHY ready timeout!\n");
> > @@ -1154,6 +1170,28 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
> >  		regulator_disable(imx_pcie->vpcie);
> >  }
> >  
> > +static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> > +{
> > +	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> > +	struct dw_pcie_ep *ep = &pcie->ep;
> > +	struct dw_pcie_rp *pp = &pcie->pp;
> > +	struct resource_entry *entry;
> > +	unsigned int offset;
> > +
> > +	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> 
> This flag should be documented in the commit message.
> 
> > +		return cpu_addr;
> > +
> > +	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
> > +		offset = ep->phys_base;
> > +	} else {
> > +		entry = resource_list_first_type(&pp->bridge->windows,
> > +						 IORESOURCE_MEM);
> 
> Check for NULL entry.
> 
> > +		offset = entry->res->start;
> > +	}
> > +
> > +	return (cpu_addr + imx_pcie->local_addr - offset);
> > +}
> > +
> >  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
> >  	.init = imx_pcie_host_init,
> >  	.deinit = imx_pcie_host_exit,
> > @@ -1162,6 +1200,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
> >  static const struct dw_pcie_ops dw_pcie_ops = {
> >  	.start_link = imx_pcie_start_link,
> >  	.stop_link = imx_pcie_stop_link,
> > +	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
> >  };
> >  
> >  static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
> > @@ -1481,6 +1520,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  					     "Failed to get PCIEPHY reset control\n");
> >  	}
> >  
> > +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CPU_ADDR_FIXUP)) {
> > +		ret = of_property_read_u32(node, "fsl,local-address", &imx_pcie->local_addr);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Failed to get local-address");
> 
> Is it OK to continue?

No, if no "fsl,local-address" for iMX8QM/QXP, address map will be wrong. 

Frank

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

