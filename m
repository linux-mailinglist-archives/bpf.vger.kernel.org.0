Return-Path: <bpf+bounces-26953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4108A6D5A
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 16:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726EBB23A45
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801112DD95;
	Tue, 16 Apr 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NcFrXxBs"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C612CDB2;
	Tue, 16 Apr 2024 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276466; cv=fail; b=Icj9ByrXDGfsMlaziTza7W4HCiJ5wYxcHcLbF/1FsuAc7pVb7OnQn9jgKZL2ZF6KUzCpT9HAFmkFkPKYQ/NtEU2RANF/QzDjVNhhdPFmsed3J1f54PtlL2f4KOc747xmAkl5wgWKsyBAi5jirq4v1Cdlw0g1p88aMOsxYdEUaPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276466; c=relaxed/simple;
	bh=Iz2BlTF0VPxWihMRnmVkVjSEvJR5ORV/78YcffebBPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTSf9Kmj3q4aQImk6dYkJl63kePGCyt5xgWC3MVw2yQSsTN9mYcaNUMvGj6xHt/Wg/SIDrFEHAi2l9wgt0tuc/zyqky44WfMcFJPIOxKatXD5bUvqgP9HWvL1cIFot/reZUPWd0hyunjRu2kQcgwGhaTEOZMqadzHfYMRU70/Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NcFrXxBs; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFv2pGvh2hJAYKH8BW2c7rfogAc75vkPoZ47mquIHr0UyfKirwWTtSgYSZB9Cr9KiD0Rv4UnXy/Q1aCAGPBgkLwKVbzxndL+rv0oJDI+yq7hpxtpyjwTE5Fx1Fw26n72DVjdELP70/fouorXRwfZb04giiKeX9v0oDWy9HzTJeqa2mFt1rlTkJqeqS2Cl8zAGZwWeYQUVyS0Ij6V1eiLNqWd2OiD/jQxcItFI/I4qTxDYMD6wS+yqKJ73mU8pdKwrsrTkzmhUsWswCXLOMJs4m/ktA8v6Bb+a3Qr3zZnZ4iXZPpolWAU6dUiTxmWQiSys+XYWhh/P6rI80HCSVvJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GccN7hfp3cs20aVlZarHXNfD7QdlVvWwyNSA3uBh8OI=;
 b=D3qu3OMN5qRao9E5WWY+T/nkkstLe+5XZ6byeU7eO+iQW/v9ryHiF1sYN9oXkFw99MSf4S2jeB57hHxxLSBZGoI3yBgsspD+g6AeynRPG5SbNLaVooBgN6X3C5agZDIIRwOVnm5dqlhJV9/kdS3S8Fi8gWLzIAMwT9vyrzIVTgm44zM3PPqjj9CjjGxviLoY+kyTZ7zE4SAvhyt2bLaC9tPGWsAPpOaZTHFeoc2oJPisZiLU1Fupc6c7g5nXQRr44nGMPIN/r+tEasPqEKY+HJUHSkKVm0ziATn0qM1OUNhy/zllQzJ+9utP3TvS6sbVfO1dzUmn5oPpfqSvw5zCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GccN7hfp3cs20aVlZarHXNfD7QdlVvWwyNSA3uBh8OI=;
 b=NcFrXxBsBRb4zQESdcMWrnw5KDTJjB2VH+mGjWRtPormyO4oYaEY0HOCOLx/3VAC+cevu7Nwx9KFYEmdp448k6D9AEpJxBGJsz+uKtruKxf8VfT1d+WTD+iI1YZIdBwqSJNDLl1TBigfZrG1bsCmTepUAzOGmsrSamyZWYj7TDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9827.eurprd04.prod.outlook.com (2603:10a6:20b:652::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:07:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:07:38 +0000
Date: Tue, 16 Apr 2024 10:07:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, devicetree@vger.kernel.org,
	Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v3 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <Zh6GHcARSmlV/QdS@lizhi-Precision-Tower-5810>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
X-ClientProxiedBy: BYAPR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:a03:80::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: 393dd287-e3c7-4361-8ae5-08dc5e1e92a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tu7Fq60EKu5W4Y2hXVzAuvFTavWdop/4PXDnbHXUmTlXtuBEzhVbEJS5Oqy7mPdW0tdzk0zQYU5e1nIaf5RPNy6+hekRUFAFSJf0I4cgs8jbdfX4VhoRLsKtbyFohnr2LtB26WHA4HwMPOrcRbRtQm3mGEmuse2usK1WRsgHX6Q02wRRGKjA6nsGJL/atpE+/q3C76zJ+M/k+ORelhgh+xVgH9E6X4j8SaVZ6TFbuideQ1Dl4Wx/O6Tp3K8Hr1B7fkkfvfJCocEfC4ST7SsGCoFi8K2QfFmg93Daw0kIB4nwST9Q0niQMSlExw2BzGjsbeNe3+p+vy6/63nnY9ABq7zECwF/9UPAHjoxBcdqWSPYgz/o972u/Fxho8mmj/CP7PVEjDVmuzAxtt9Fn/dqgsJWkjPebb8tewN3O7B2PVKbW9LHSLZ9Mi1mO9DgkyFCZXNtLBuocUQwZuQIKqAnT7+FTgqV8OlakzPHKLq1tsYQkC9EIC9bPtWif8BRn2+BWRnn+HqJvmRlJEnlEo2bk0kOw9OMyJJxydQfvN1GNFptrA+Mw2KOV62bp0n7icIVLdIhCdnN271hG2/LVOWn7kJEB7/9hXpxSBzSpeQwA6cR1Q2hu1Q5eo0Kfq9OtybMzBbCi7483zJn/ofim1iDWgHTXEJdWTe32HOn+o5UKC+bdeGAM3NJkgxPwcPtMN6LURGEXon6N2zc+2ACE7Q7Z3C/zadr/aTuQitM0NLXZr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEpXTjZiVnNhZTEySmRMaU9SRkRQYlBvNzB5U3lKdzZuN3RET2pRNVpEbU9l?=
 =?utf-8?B?K1BuNitZRnUvWU92aUxETnQ1WFdVR01wYTF6MURYUTFhY1VoczJZbU9UTU92?=
 =?utf-8?B?WVNDY2V1M3diMXVvc3Rrd2JFOTNpYnJlOHRhWDNWSEl4TklWM2w2dnVYQm5D?=
 =?utf-8?B?VEMwa1dnSVdSakhMZzhOYWQxb1ZzcUxKWjRCWE1sSzFabWRtK0lER0UrY0lw?=
 =?utf-8?B?UUZkc21BQlUxOVM4YkVsTDd0dnpDVnFmdVNIQTk4TkF2MSsrd0FZdC8vYzZS?=
 =?utf-8?B?TXZPSUx3NUFxZXpaRXo5eFk5WmRHMUY2T3RVSUQ0OVRYaFhod2NOOE5vUzlN?=
 =?utf-8?B?SXp3enFVRUZrRWQ1NlFwbHFJZVdYWEErdXROQlRLWXJ5blZyVVphajIwSEho?=
 =?utf-8?B?T2dkM2FWd0xmMFNHc1Mzdk1DSkF4aGtRc0tJU0lxcnJ1bkNWcDBLOHdyV0Ry?=
 =?utf-8?B?M3dMaU9hUDl0U1oxM0krZmdpWTNPMi9ZdkpDVnROM0gvVmZmVDBNZ1VKUVZE?=
 =?utf-8?B?RGxrY2ZhM2tKcmYzQUZaMzdFbFl2dmpYUklFbUR0TU9WL05INzRTQkRaQ1Jj?=
 =?utf-8?B?NzZMbVoxeTkrVnBtazZ4N2ZQRUd6TG1DZ2gvR0VTWTMyckJCT05mQnZFN1Vn?=
 =?utf-8?B?QnBSK2N1QXBtRVVHdXVqemdqV2dndmZuUDNhbDhSVUtia05qcUsrbVRHaWg5?=
 =?utf-8?B?TUFPeE9Cc1FwRTRJSVlxRmJsOW84bjhmUElENnpodTJHS3VpWGpMUUoyQ2xz?=
 =?utf-8?B?Y1QxQ3dDbjUwd29aWmU0M3lQbWU5S1NsWGxiWVY0S3Z4ZGhJNW1oeThiK01v?=
 =?utf-8?B?WXdjdFZwZ2Q3RFhzWnBYQkFjR0pFTlYzdVE4ZFBmWGdnKzNlcmd4dmpnajhM?=
 =?utf-8?B?L3lMZ2lwc0hyVWVmTmFwT25iekcrdHY0NG1lNzJGN0FWWndhcmpjbk5za051?=
 =?utf-8?B?a0t1TGFSRFE2ckpmaThlbmRNMDB4U3FtZGt2c2xrZDdiQU5ycW9CTCs4L01Q?=
 =?utf-8?B?WWUvTmhnMHhCdDFGQXdTdVhkSnVMRHJ5WEZaa2hqRG0wa0YzUENuS2JFQmdt?=
 =?utf-8?B?WjU0R0ZCZVNaRWpLenB2R1RBTXpMckVPTUtQMHUxMzBXRGNteWEwUjF1UlBY?=
 =?utf-8?B?YVlFb3lYemgrNFROcnBCY3drNWs5Y3RtZ0hML0t4ZUt0VlVyclhEMFNqbEg4?=
 =?utf-8?B?WUE1NDdIWm1KN1Y5TUpYa1V1cUxibWZ4WGNoWGtTaFI5R2JwejBHdnVFYklm?=
 =?utf-8?B?VlFCM0c2S3RlSFhYSXBkTmhwQ2lXUDd3dm5HWHZCRzAwREFaVERWT2lNU1ZH?=
 =?utf-8?B?SFBqb3NjOUJVZUlYZzc1MkYvdUpQcXhPU3JXelNJTGRCMUUvdnphSFo3Ri9y?=
 =?utf-8?B?ZVoxcStaR29vUS9XNGh6cGtZcWI3TkUrNTIySzJCSG5vTnNqZzRmZnQrM0Nu?=
 =?utf-8?B?cGE5WmJJdlppMW1ZYzlXRDJ1OHZ5Mi9pWndGT2xLWG9BQWJOeXQ4YTBFb0RZ?=
 =?utf-8?B?bUpaL0xYZDJ1aGt2NzJvQldHeWNvNjBMVUN2WlU0KzBpK2lpaU9WWkRPS0sw?=
 =?utf-8?B?MXdHUUxyLzlIUFd3RnBqbVFaRlRyeHhzeStmUzVhRGFqU2IzT3owMUtRUnNt?=
 =?utf-8?B?MGgwODlSRGlUYW81REdpNGFndW1tSUU3MnQ5NGNSb1gzcW1DNDVrWTdQM25E?=
 =?utf-8?B?UG1YNHY0WWxobGFMOXhVV1c0cW9iM2ZpQW9Sb0VnTHZRWkRySEJ6SHYrMEps?=
 =?utf-8?B?UDRFRDlNVTNPVFVaVXJqZ1dGcm1obzNIM0w0WE94bFg0K1FmTEg5N28xUFdC?=
 =?utf-8?B?aXpQVVRQaTkwc0tYVjdBclRidnhtMmt4ZDUyQThDWjVkU3hGalZJcGdodkZO?=
 =?utf-8?B?SG4zTnNGdHlYckxLeHhqeXZWNG5sQThaZmc3aGlvUTB3UEYzaUNsNXh2UkxY?=
 =?utf-8?B?OXRqMm93c2dEaEkzNE02QXFGR1NxK2N4NTBBNGVQSWx0NVl0Y3p4cjBKT3JX?=
 =?utf-8?B?VmZsYmQ3U2g1WnFMQ3pxMlI0WlpnK3dRZFdmWks5ZkdpbUl2NFltWGFQaTVL?=
 =?utf-8?B?T2VwWEpzUFpmbnJSTGlHK0krNWRzTFJrMmxOd0ljeG1laUFZZWFQeVVsT1Mw?=
 =?utf-8?Q?O7Q8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393dd287-e3c7-4361-8ae5-08dc5e1e92a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:07:38.3645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeB0nydf6b2wXHuHa2hySmwJtiTKN6pm0bS0FZMNqD5A2jeS6uK+RsX2OfksEhwvulCV0jxFK1n5v/35GZCUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9827

On Tue, Apr 02, 2024 at 10:33:36AM -0400, Frank Li wrote:
> Fixed 8mp EP mode problem.
> 
> imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
> confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
> pci-imx.c to avoid confuse.                                                


Mani and lorenzo:

Do you have chance to look these patches?

Frank

> 
> Using callback to reduce switch case for core reset and refclk.            
> 
> Add imx95 iommux and its stream id information.                            
> 
> Base on linux-pci/controller/imx
> 
> To: Richard Zhu <hongxing.zhu@nxp.com>
> To: Lucas Stach <l.stach@pengutronix.de>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kw@linux.com>
> To: Rob Herring <robh@kernel.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: NXP Linux Team <linux-imx@nxp.com>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Changes in v3:
> - Add an EP fixed patch
>   PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
>   PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
> - Add 8qxp rc support
> dt-bing yaml pass binding check
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb
> 
> - Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com
> 
> Changes in v2:
> - remove file to 'pcie-imx.c'
> - keep CONFIG unchange.
> - Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com
> 
> ---
> Frank Li (7):
>       PCI: imx6: Rename imx6_* with imx_*
>       PCI: imx6: Rename pci-imx6.c to pcie-imx.c
>       MAINTAINERS: pci: imx: update imx6* to imx* since rename driver file
>       PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
>       PCI: imx: Simplify switch-case logic by involve core_reset callback
>       PCI: imx: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
>       PCI: imx: Consolidate redundant if-checks
> 
> Richard Zhu (4):
>       PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
>       PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
>       dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
>       PCI: imx6: Add i.MX8Q PCIe support
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml        |    5 +
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   18 +
>  MAINTAINERS                                        |    4 +-
>  drivers/pci/controller/dwc/Makefile                |    2 +-
>  .../pci/controller/dwc/{pci-imx6.c => pcie-imx.c}  | 1173 ++++++++++++--------
>  5 files changed, 727 insertions(+), 475 deletions(-)
> ---
> base-commit: 2e45e73eebd43365cb585c49b3a671dcfae6b5b5
> change-id: 20240227-pci2_upstream-0cdd19a15163
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

