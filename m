Return-Path: <bpf+bounces-35235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE6C93918C
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817CA1F21D6D
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61116DED1;
	Mon, 22 Jul 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C6nUzWHQ"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013049.outbound.protection.outlook.com [52.101.67.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B31754B;
	Mon, 22 Jul 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661405; cv=fail; b=ShRL2O4A20D+1yz1tJ6SWx+h1HY8wMOCaWRntuXqljRAEB2yWaY5CRuHKvpcf0ZyAre0XcRPEqRLizPNDLxfvqvQaQ1ddTqaQHBjfvrjGotRbsho/e3TmSkASzQgs1UkGUPocZxQj+TUJGguLNKZarxgzEFHdljK6wp7HRSrq08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661405; c=relaxed/simple;
	bh=zv4jDB0hxq582jtsfQjLlLMIAfl/BXUzcJ7MNPgxwXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i29wrlBHYtix2mlG8+QAqA0d853zKH8/2Cc6Nrqvb8ymHfUzFo5KKbyu+64fxHfMiujRfaPtqyH9OvXfVO2LIMPXrJNp+zf/yNDJFuaBPhpYNfB5WOBFObfY0mEUvhOUoD5EOqu2+FtUe0EysgRzRNdO+RELruN25aTtK/LScSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C6nUzWHQ; arc=fail smtp.client-ip=52.101.67.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJneg93Ejk7e11bPWW+0E7JE5vG943J8DpVPraUPODdgFXTP2/dh0zOkSQUx/E7sd7nSylevrjh7HyWEImhX+9YV3fOP3ZMKp7lLW2gCqLP3YvZGj4UIEiIZervZrQTlgmLNZbPxLZhvBGWbNZk/K+HXKiZYbvjFh+kl+KGvH/eu8AzA+e/yriG2nHUZnaEvIVTzqeduw+KuSyzI6/LH0ABePS2PRn6fQ40fEpzQJlsWPvlfr5v2S2iFSnHyeo7A2JYrkGt8ZdgdHM7qXxr2edal3GcF3AzsfIs2D2MmDdN7TuTsEw2cEd56W/U7oRBk2ifGUjiusBVJkycybtFH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkAiBIdZpL4vBh66GKXVdisH2h7KN75QOl0jOoPwgV8=;
 b=ajW4J+FIeOeqK1FP2XBZ6Wxhc5AajH/4Me0LQVVFiZ57ggL4Ys/KySMoHvIMT+nikfn7wyzHdalP8rwAm26PtMUbVSPvq/vn3OKSpagoaQVKaIRbtoMhWfknOKkg4E5ap7sfoDpgKBwyUJ+EwT6TBvy0qra/CE+lerQrsHZSWOYiL2lB02fL7yNg1JuptXFGKBVH7O4U4FtK7pMvNzCyCz6h/C5v8SrCmeoTmQ9+X5U6AO9wQy+JZceLa+DtKRUbikmlmRhF0FpxFiCiml2iXsxf5M3kf3m17v/0YEZ6XH5ov81Qd3/WKaWQe9kJekMctNNH4I3mWIrN336fnFjc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkAiBIdZpL4vBh66GKXVdisH2h7KN75QOl0jOoPwgV8=;
 b=C6nUzWHQ4X8kJmplPrKX92oCcBelPXYFYMkLizN79EScfmw/DVUly6mzEIXGz4vzxx1HxZJ/YugcEyOa6XOiJJDDP747HogjyCiOEy11HoXI0hWSK+GcYwfs/uC6KsrmEEaTCHrimXosNKkKffTHvh6+Kms9MGJkESjEh32z07o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7005.eurprd04.prod.outlook.com (2603:10a6:803:136::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 15:16:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 15:16:36 +0000
Date: Mon, 22 Jul 2024 11:16:25 -0400
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
Subject: Re: [PATCH v7 04/10] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Message-ID: <Zp53yUlVmmEk2rAU@lizhi-Precision-Tower-5810>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
 <20240708-pci2_upstream-v7-4-ac00b8174f89@nxp.com>
 <20240721075634.GC1908@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240721075634.GC1908@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 907f2293-e583-4ada-4ae4-08dcaa614757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2tWSC9IcmhzRysyeGNuZ01UM1VHN2czbmpkVWhTaHdBSVA3QWhLVGgwYjMz?=
 =?utf-8?B?dThkREpYd05QVXpGQWxWSm1oSWtkbW02bTAxUE1JWEJNcis4YnordjhSSUk1?=
 =?utf-8?B?cFB4YjBxTlJBMktwOUhxVnMrYkdhNVNySHpvQzVpT0lRZEhnWWFLNGxkbmFs?=
 =?utf-8?B?UVU0UzNNOU5GZ2o1VmpML3BQZFBYRHBROEkzdCt1a3FiZjJZejE4VmRkQSt3?=
 =?utf-8?B?a05HZzJPMFZGNW9meWFORGJIdlZXUXRsVjlTUHFLU0t1Tjk3T3BSeUF6UHh3?=
 =?utf-8?B?Tyt0VWk2S3Nkczl2dnRoeDZwYWVrcmJoSXFESW9WeFFSWWJzUSs3QXRkempV?=
 =?utf-8?B?ekZGdG1JQXl5TFhQMzZILzNVbGRnWjA4RnIveml4WWFiQnR6OWxSMHIyRmpD?=
 =?utf-8?B?ZVVDMVRzTENJNDJGblg0V3BIZ3lzQjYrZWhHMGNrbnc2YUdYK3FIaFZTLzR1?=
 =?utf-8?B?UnYxdzhLck5PbzhRWE5Sc1VpZENMNk9ZYytMeHpJSmp3blJRQ0s2MzQ2R2hk?=
 =?utf-8?B?anhMZmZjN21EY2xSdTZRU3A0ZWhieldmVGZRM3UwNDJPMHRWcEJtdjBsNTg2?=
 =?utf-8?B?K0xKa1JXRklLUkNjemFsVTA1cUt6VTlIMENWaXl1dlVxZXV3TUQ1ZzRnTGho?=
 =?utf-8?B?UFYyZDdZbGNFWnB6VHd0bUplNW5nNHQ3eXVoVDFnYmhkZGtRWTZSTW4wWUw1?=
 =?utf-8?B?TlRqS1R6eUxuSEpDV2ZYRkVaOGRYc252N0hOK3RHaGdvSEN5L0pEUDVXV2t4?=
 =?utf-8?B?V24zZTZZT2txdDJDaUpXcFBrSXNSTFVWcHdDNzhOMzV3WmZKZ2x6ekxCeE4r?=
 =?utf-8?B?WkpIUWNCOVdER0Mwd2pRV2t6NTRGaWRKbXlmbkdSaExGWGVxT3RoV3A2amZM?=
 =?utf-8?B?b0ZBN1VPbTJQKzMrajJQelZVNG94VlNBby9HdG5BeFBLRFpBanVTTEg3czF1?=
 =?utf-8?B?Q2tGNkZMQ2xNdGZvUTBhMmpPblBuYTcrZkZQQ2htMldGOGNQTXhOYVNSUzRC?=
 =?utf-8?B?aWdmYm1HT1hnOGt3c3RFalkvREx6WmlYQ2xIa3JJdXlCeElLQjdYaCt2NExL?=
 =?utf-8?B?Mng4NURjTWtKTTZzOWIxcVp1V3c3ZUtMejlHNFE5R3I2UG5sWU5IaUdnM21J?=
 =?utf-8?B?dzVLaWh1aU1CUlNVK0pQR3VSQlAwaHR5STN4bEFkY0lYMHYwK0F0WjVkQXNX?=
 =?utf-8?B?cmg0N2JXRm0yeS8zZjBzQzY2SU9zSXJYNDMrSEw2dTVFKzRsQ2R6U2lvazZt?=
 =?utf-8?B?RS8zU0dFWGJXWExJMmxNOW9pdERGZjZzSmRqNVNWWHpmeWc0NFJmWG53S0ZY?=
 =?utf-8?B?OFBUK0hJNldUcXNiWVVLTWlpblNPc2ZRSVAzcFpIOGg0SDhjdVV1a3ByOG8x?=
 =?utf-8?B?S21TQ3o3ZVZRbWppUXZUeDVXQTJSL3NDTE9ZOEI4VVI3SnFsY2czeU1PMmpr?=
 =?utf-8?B?dGkzYTJrZGloNExwMVRieWRSZ3ZuQnNhMVFQN1NJKzNGV2ZtcytYdk9jUnhM?=
 =?utf-8?B?bFVpNVFET25HMGpoU0ZKTU5nQ2k2V3BWVlRMTzQ0MGNLSDVEVTRnVk9DNnpH?=
 =?utf-8?B?L2YwNWJnZ2E3UU1JR1l4ZmZncnpjcUp2R2xTbW01THlOaEM4OHI1ODcxaVpW?=
 =?utf-8?B?WHZ3Q1RHNWR5OTJ6enFFa2ZhNFRNTkY0WnEvSWQwRVowaWk3WGcwcW5UbStD?=
 =?utf-8?B?d2NZSFZ5K2tlYjNnT1Z2bU1iV3VPTWtpdGVNTmVKTjR1QlB6UUhUSDZZQ3NO?=
 =?utf-8?B?MHpIbUJLeW5ubHlUWnp1Vk9JUkJreWZIblRCdzNzTlZQTGJETUJ5YU82MElI?=
 =?utf-8?B?a3J1RjVsbU1EWDZoV0xxZUtvdjBpditsWTBZZjZoRGIyYlEwZldNcVNmRm1u?=
 =?utf-8?B?N2JtRG80VVlmZTdRVFdyODhDaTNVRVNRUUFuOW8zVTFUSmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjVJRkhZbUgvZUFBRUtuOGo4blRoamNZTkJocDNBZEEvMDJ1MGxsQVU0VlEz?=
 =?utf-8?B?T0FZTFRzYVc1cG5xOE41T2xsblR4c1FKTG1RSkg4ZFFpbWRYeFRUZGMrNlpB?=
 =?utf-8?B?NEk0dThKWXZlOG5wV1BBNnJsVDBUQW8zMUhaZmIxMlgzeFVsL0k0RzVkOUhx?=
 =?utf-8?B?YUhNRkszUlFrMk9FTDJkWEI0YWtDMGJjYU1CYnEwenltN1R6RTgzWWsycnFp?=
 =?utf-8?B?ZFUxSERGQUp3Szk4STE5NzJlWkhKWC9Za1RHcHJvREJUeWk0TGZLTGh3N0xE?=
 =?utf-8?B?aG5yaGJVQXJYNGJCcDhBOFozbzJidEI3T1JGR2FBQS9EWW44THRNNkFjUXhi?=
 =?utf-8?B?V1o2T2kwL0JwNDNtUVNsb3A0TmhSbzhmMk83QVBadVFDQ2c0R1dvc1V3REhU?=
 =?utf-8?B?M2x4eWJIVENTUzRnVlA1bzA0bzhPLzY0WG5UNUEwMUVkZGpINGFVOHBTVFpa?=
 =?utf-8?B?ZE9udTVyMHVjcHJYTDRKVkI0cXc1SEdDSyt6SmxlREgxZWJpcEx2ZWtLS2hI?=
 =?utf-8?B?WWFCcjZGQzRXRkE1RGVXL1NnV1ViaHVqcksrUUY5OUxLMjlIYm9FUTluVm5u?=
 =?utf-8?B?M1B2cnFXSFNTalZCaGVaMlBEMXhUdXR0UUNCR0xDSG1OWHJJS3Zqd2NFaFg2?=
 =?utf-8?B?d2ZTMFV1c3N5WTVkamhvN3VRdmhadnk1ZE9CREhWTnVhamxRWDFycVI5Mmto?=
 =?utf-8?B?aTZWYmRxTDdMbzhDQWc3Z0pIV01idHgrRWdoanE3QnpMT2s5TENFSkZ6QWlz?=
 =?utf-8?B?Q0FmeThWcnNDbWFYK1pwNXV0SHUrb0hBYll5VWczL1ZKQjZNai8zUkZ0bGlY?=
 =?utf-8?B?dld3TEQ1bk85bkZGVXdGZkl2Tm9oMXR6TllsOHR0QVhNdHpHSERXYmZmSlYz?=
 =?utf-8?B?TXUyWVZsL290bW1UKzZHUTA1MVV1c0FYa2g2OUxabjZyOVk2bWNPUElrb2VT?=
 =?utf-8?B?ZWJhd05UVEF6amRVSWd5OVZXY3Z1c3IvNTR5cmh2VXNMRWVTOWR6WUNndC9y?=
 =?utf-8?B?Qy94YlpUSEk3Smxad3lVckJHVmhTK1pLNWJ3ZWFrVndrOU9JcmI4eVlBQTBy?=
 =?utf-8?B?dXZsZGN0NkthMDQwM2JVVlFZZlpOSU9iWEpJdzZzVmNqN3JxQjRkM21oZnJE?=
 =?utf-8?B?ZjhWU05FdHQrYlFBT0pxclAzTWptdThKd21Xb281RUtndFRFSlpSc3VONCtF?=
 =?utf-8?B?eXRUdXh1SGs2MTY3dmRaTUNOMFoyZ3ErdFE3c1JWTytCc1l1Y1IxVkxPdkwy?=
 =?utf-8?B?dzlxaTBTdGptRDRGRUFnamdSWFBTTy9OOExyQ2ViRzRUd0hsMkZLalJ1eTVV?=
 =?utf-8?B?RnJhSFMxZ2NuZmpZWTNLYU9lZGxGMFFUUFBRUE90TCtJKzUrNTF1WVNqbFBM?=
 =?utf-8?B?QnZaWHptQkhYaWxBUVFuMTlTeHZNQ3RUdWN2UmNpK0NSZllkSXNMUzJDYUpI?=
 =?utf-8?B?NnpDS2hlRkM0d05nQURoK0htOC9RNEhObGpMUC9KV2IyVHVUSWpXM1dyTnpp?=
 =?utf-8?B?cEJXQ002ZlgwUkNmaEtNdVpROXJtWFl4eXhtdGJ6Y01oNWJNOWw0REdzMWNn?=
 =?utf-8?B?bnZrWVk2SzZ4KytRNEhXMGtHSWI2SGpkTm96TjdaSnUwaXBZNHZzbk1XMHBH?=
 =?utf-8?B?RldWblRPMlJZMXhReHZrT29BUnVGWDBNbEErWTZmWmJScEtOVmxkYXB0cVVY?=
 =?utf-8?B?ZVdJeU4yekdZc1psazhGTUlmN3h1Q2kzNFFKU2hEV09PYnJBN3VRZmwvdDhI?=
 =?utf-8?B?OHZhTkZ5RWFtRnBRaHZaMFgxc3QrZ1NUd2c2VDgya3FwUEhNZGtCL0NOWm1s?=
 =?utf-8?B?SjhrWFd3UmZXLzFKUTZjMDVFVVo5YmhvazByNnRHeU5zbWFwY3F1LytmRmYx?=
 =?utf-8?B?RzI3eURmbnRyOXY5YlBLNFJsWGtxT2NKTkVqT1BsS2locmFYZ3diSjBHajlF?=
 =?utf-8?B?Y1RTaGVGQUJoM0VJdDZOUWJvc0ZvbTMzbnF0cVEzWVZ2RmxpdjdXajB6SVdE?=
 =?utf-8?B?TXVMdU9CT1QxQW9TS3FsdGJXRkx1TXFheThvUFlOUFdldHZJUVEwOHVpZ2x2?=
 =?utf-8?B?WGMxejgwaG16RkJEYWdqRUlNOUFKMGsvVWk3TmNLc2JjNC91b052cStEV2hM?=
 =?utf-8?Q?QnWw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907f2293-e583-4ada-4ae4-08dcaa614757
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:16:36.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WzC9MSlpyplWUh5e3fRtKn3My2aeE8dJ87nTlzSLoVL2Er4kqqG1XM/ZsFQ8mojjE7S5mgqoXJkZTcQItEuhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7005

On Sun, Jul 21, 2024 at 01:26:34PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jul 08, 2024 at 01:08:08PM -0400, Frank Li wrote:
> > Instead of using the switch case statement to enable/disable the reference
> > clock handled by this driver itself, let's introduce a new callback
> > enable_ref_clk() and define it for platforms that require it. This
> > simplifies the code.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 111 ++++++++++++++++------------------
> >  1 file changed, 51 insertions(+), 60 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 47134e2dfecf2..dbcb70186036e 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
> >  	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
> >  	const struct pci_epc_features *epc_features;
> >  	int (*init_phy)(struct imx_pcie *pcie);
> > +	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
> >  };
> >  
> >  struct imx_pcie {
> > @@ -585,21 +586,20 @@ static int imx_pcie_attach_pd(struct device *dev)
> >  	return 0;
> >  }
> >  
> > -static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
> > +static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> >  {
> > -	unsigned int offset;
> > -	int ret = 0;
> > +	if (enable)
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> 
> Since all SoCs except IMX6Q/6QP doesn't have both enable/disable controls (which
> is very weird btw), you can have separate enable/disable callbacks and just
> populate the ones that require.

I think old code is wrong, which depended on hardware reset value. It
should paired between enable/disable. I just want to keep the same logic
here as old code. I have another patches to improve these. This patch
series were already big, I want to do it after these patch merged.

Is it okay?

Frank
 
> 
> This way it becomes clear which SoC is supporting what. If you have a common
> helper and just toggle based on a bool, then it becomes hard to follow.
> 
> - Mani
> 
> >  
> > -	switch (imx_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> > -		break;
> > -	case IMX6QP:
> > -	case IMX6Q:
> > +	return 0;
> > +}
> > +
> > +static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> > +{
> > +	if (enable) {
> >  		/* power up core phy and enable ref clock */
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> >  		/*
> >  		 * the async reset input need ref clock to sync internally,
> >  		 * when the ref clock comes after reset, internal synced
> > @@ -607,55 +607,33 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
> >  		 * add one ~10us delay here.
> >  		 */
> >  		usleep_range(10, 100);
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> > -		break;
> > -	case IMX7D:
> > -	case IMX95:
> > -	case IMX95_EP:
> > -		break;
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > -		offset = imx_pcie_grp_offset(imx_pcie);
> > -		/*
> > -		 * Set the over ride low and enabled
> > -		 * make sure that REF_CLK is turned on.
> > -		 */
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> > -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> > -				   0);
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> > -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> > -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> > -		break;
> > +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> > +	} else {
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> > +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> >  	}
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> > -static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
> > +static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> >  {
> > -	switch (imx_pcie->drvdata->variant) {
> > -	case IMX6QP:
> > -	case IMX6Q:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -				IMX6Q_GPR1_PCIE_TEST_PD,
> > -				IMX6Q_GPR1_PCIE_TEST_PD);
> > -		break;
> > -	case IMX7D:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > -		break;
> > -	default:
> > -		break;
> > +	int offset = imx_pcie_grp_offset(imx_pcie);
> > +
> > +	if (enable) {
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> > +		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> >  	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> > +{
> > +	if (!enable)
> > +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > +	return 0;
> >  }
> >  
> >  static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
> > @@ -668,10 +646,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = imx_pcie_enable_ref_clk(imx_pcie);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie ref clock\n");
> > -		goto err_ref_clk;
> > +	if (imx_pcie->drvdata->enable_ref_clk) {
> > +		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to enable PCIe REFCLK\n");
> > +			goto err_ref_clk;
> > +		}
> >  	}
> >  
> >  	/* allow the clocks to stabilize */
> > @@ -686,7 +666,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
> >  
> >  static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
> >  {
> > -	imx_pcie_disable_ref_clk(imx_pcie);
> > +	if (imx_pcie->drvdata->enable_ref_clk)
> > +		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
> >  	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
> >  }
> >  
> > @@ -1475,6 +1456,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.init_phy = imx_pcie_init_phy,
> > +		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
> >  	},
> >  	[IMX6SX] = {
> >  		.variant = IMX6SX,
> > @@ -1489,6 +1471,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.init_phy = imx6sx_pcie_init_phy,
> > +		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
> >  	},
> >  	[IMX6QP] = {
> >  		.variant = IMX6QP,
> > @@ -1504,6 +1487,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.init_phy = imx_pcie_init_phy,
> > +		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
> >  	},
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
> > @@ -1516,6 +1500,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.init_phy = imx7d_pcie_init_phy,
> > +		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
> >  	},
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
> > @@ -1529,6 +1514,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[1] = IOMUXC_GPR12,
> >  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> >  		.init_phy = imx8mq_pcie_init_phy,
> > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> > @@ -1540,6 +1526,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> > @@ -1551,6 +1538,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> >  	},
> >  	[IMX95] = {
> >  		.variant = IMX95,
> > @@ -1577,6 +1565,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> >  		.epc_features = &imx8m_pcie_epc_features,
> >  		.init_phy = imx8mq_pcie_init_phy,
> > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> > @@ -1589,6 +1578,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.epc_features = &imx8m_pcie_epc_features,
> > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> > @@ -1601,6 +1591,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.epc_features = &imx8m_pcie_epc_features,
> > +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> >  	},
> >  	[IMX95_EP] = {
> >  		.variant = IMX95_EP,
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

