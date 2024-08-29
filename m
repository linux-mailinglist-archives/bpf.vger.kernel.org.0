Return-Path: <bpf+bounces-38488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475C39651DF
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D3B20B60
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D231B653D;
	Thu, 29 Aug 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A6R5bz/6"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDA18950B;
	Thu, 29 Aug 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966745; cv=fail; b=srAe1CRInPGgtSLmp/cIUT80++6owdoUrKin3eqNyNUUJx5m/qpJTb/zgakO1ucBr31y2/TXZbyyx7+zp1IWvftDJX9uS3WNzNt+T9fWkNZg4NGU9eIecNJsnax6BqAqGeyWrsJRl29XQlAgAHWWVQCV8aiYvrzXDQsiYbNIs9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966745; c=relaxed/simple;
	bh=J8QR180sxvk/HqWq9qMgpGi/efdEOjyiUodaPhBY9KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czhR0CGgMGdixwziJ68qNAC5I78ivXBirJIcumkprYcEEkA9PHBSdjGANnwtEHNkUGpnbHjZJqzA17krgh9pdkF5ce8vVrA8Nhu/8TkaNVz5ljeooU0NhagiYhQvHNbgm5fDqMy2hBt08nFBOGj0lW9vUakVd3OCpbURn7b2i0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A6R5bz/6; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMjayZLy/t7axly7d+gaFM21+IIk0nebI9Frk+yBWYJbCgFaFaXNjTX7FO56j+VCeAu/o6kZcwHA+SsQN0doQrmS9DEFVS/d9p2m9G2yG1eOGLiYVpZGzPJai3wlqpuQCE5J3qG3V1SJrqajPuN3Uj8xNwkkIZrytO0ntaXFggaHmekQteK5QnAeZrozKvPns8M7ZampvCQUBzitRi29cpE+Wp9UY2qCnDkfiXo089USN5zEjwrc31mflgCLVrgiu7W56oiTRnDUfbuXaIdnox3pQO4wzdgp8GIxBei+E4XlxF1IZXrFXp/S+QyUSYW76VZNl5l6bKiiQzM4fH+nbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UkkzeG/EjqljiJwQslxw9u+DHDtTce8imYrEAghU6s=;
 b=I/fzMaDU+9zdN1wGijOL2SKcaCH0HbfHdthwLJRhP9+jM20rvL+qGHAaUqEGvUWIU06ASP0riTUCn9AFJWXadZCo1h0OoPf+8H1CrmnwmphegoHXJP9kGKqGpHMD+8cR8i45TiYNZZoSdRhIVnwiwS/kWg/CcnwxGOHKSgdIdn75BsST3R8ioQwsS1eoWnFUZoKlxQ9nEndKh3Z8tYawdet7XxA7BPaUQ4c/bAjD3NXYqfIeHb6ePKbqMyMkOkKiP8ZTYH8SmN9haBDwVZWu5TVTQ1+PR5PNCwPfeagurftAxK1FgJlQa6jl/MoFGvxhJBz/UYRR1/X6VO9gK5oXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UkkzeG/EjqljiJwQslxw9u+DHDtTce8imYrEAghU6s=;
 b=A6R5bz/6mNyqCLTHK0ZCvwfFGX7Ie4qDjRfS0cEho3HYlzowdiybOstTSF2q9/ww65Qyhsxe6EBivIC2pdJ8udzWrDEB68y/KwPu7SIYISEan6OP+oTVgwhqlujXHlKuNapifoWV+6TKQlNsGHjONmmZ1klAPPSWZaCpIhGX3MZ4/acfrHh+NXwdn9Ncn0RJe0VMsjvdnyn+AZ6giZFjIg9Lnnc0CsQXtT4XvMTtun86aUDekJtOmL+nG8O1aqDdxou7VnvHygdjIEdf33TjiRsvQL2KbcmpEAZGpiWiIx2oAVpFf0BOm3r89IF7CB4aFQF+2vJC37Wi80rLq3ARRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 21:25:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:25:38 +0000
Date: Thu, 29 Aug 2024 17:25:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
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
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <ZtDnRrXB6VmbMOBn@lizhi-Precision-Tower-5810>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
 <ZrKIotkhvAnt87fX@lizhi-Precision-Tower-5810>
 <20240807023814.GD3412@thinkpad>
 <Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810>
 <ZsdvUwuvmW/+Agwd@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsdvUwuvmW/+Agwd@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 322a0408-51da-43a4-01a2-08dcc8712051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTFiTUV2MW1rL3U4VjdBNER5Sm9qWi9neFVmNmI3ZklUQS9kZXd5Z1hKaWlP?=
 =?utf-8?B?MkpSUExnK1BOTjhCRXdCWVNzWlhQMzdJZGk3TFdXVWIwTitsWERmaDZkUENQ?=
 =?utf-8?B?MXFCdXA1V1BVNW5KNUt1NXFmZ1BMU21XNmJMdXU4Nlg3NkhJK0hvcUNPMXRj?=
 =?utf-8?B?c3FsS0M2RThQVi91MWVOTHdxUlIxQ25jVmZpdS8vSDQvUEZQTkFUK1dsUGZG?=
 =?utf-8?B?Ni9JU3JsYmF3bVVZc0hBVVphMDVEN1l5U2htTjlGTnBtSzZNOGxPYVJIRGJT?=
 =?utf-8?B?eVV5T0hNS3FFWkJVSVA0MGNIcmpWbHMxWWJ0Nm1YSS9NUkt1NUhLMmhrUzYx?=
 =?utf-8?B?M3BmZGlaRmVRRGRZRHByZWVOdlBsUC9WZ1VicFA5aWZub3dGSmsrSlRtNk1a?=
 =?utf-8?B?K2dwSkg5eTkzaThSR2dnMkRGajdLL1BqU1ViYWI0dlJsUzhPL0RnQ3BrOTB3?=
 =?utf-8?B?YmRZVnVxTkFtaHlWS1duamZkRFh0UWhBWC9wa1BqVjFYeXRSUXB3SHMrUE4v?=
 =?utf-8?B?elU3ZkdDbnNpcmR1UHNjazAxNlV5UEJDb1cxdGZBbVVobHlnMlZHemhCckpx?=
 =?utf-8?B?dVFLRDBwMC9ZTlVwbDdlcVJ0bTdmMW4vTUlma2kwYjdsTGRSV3hIc0lvYnRW?=
 =?utf-8?B?c0RlMTl3OUVCdnVOTG41T0dKaW5VdU01blVqRi8vQXcvZS8wMVNYeTRTQk1Q?=
 =?utf-8?B?RnkwL2lQUk16SWxSOVVRUHNYcmZtS0VaUUplTlpOc0t6WWdNSVJmTGI0dWhr?=
 =?utf-8?B?U0MwUE1wOUg3aW9TNTVnL3dSL2Q5aFZkK0RkaURiWnl1NG1ldXk0Vlo4UnNh?=
 =?utf-8?B?d0FQUDJYdkt5aWJ4TktkZE94R2gzaE42bzNpSU5ySDVONWFNQTRUc1VHQTg5?=
 =?utf-8?B?MXpzZU9IZ2ZHeVp0SlBCZU1NNWp2UkV1T0Z6S055UG9xM205SlV5QjdUUzJx?=
 =?utf-8?B?dE5PQzNLNE1vTjJPeTJtU0VrQUlVSXJuS3FURldDbVlaNHNzNWpqOHZaMG0y?=
 =?utf-8?B?RVBCdi9kTm1hcTB3T3ZUcWkvaERmUlRuY0x1Z1hkaGV6bkpEdk1sYnl6Q3JO?=
 =?utf-8?B?YlU0czZSVEMvMEt0clN5WWgwcjlNdWZBaVZHSFBqbi9tVGFTQzZqYkxBVGNw?=
 =?utf-8?B?UHFpUEk2ZW4vL2FEc3h2VWxkR3hsZDJvVllSUnMyYmdUbVJaRlFOYnhzQmM0?=
 =?utf-8?B?bkdPWXRpalRZcytCZ2xOMEJ0WGM4Y3A4TWQrdzFWNW4xKzFNbi9OMWZDTDI3?=
 =?utf-8?B?bGZlT3RpbXIyaVdmdjVBeVg2Y3FXQVoyZThnd29kbXBSVkVxcW1jbnNNVkR5?=
 =?utf-8?B?VjhGa01RUmtxM0NJeGVud1I1a3FoVXlXMy9tSEE2QllmaUdDUGUzejVDRHZm?=
 =?utf-8?B?QnM2U1BWcy9IRm5TNDlJd1BLTzJoQUI5Q2tLOUdkWTluUnZ2Q0dpd1Q3QkFo?=
 =?utf-8?B?RUFlRVJXdDJGRzd0U1ZJUTNBSTBnU3JMdmJ0NUFMSEhoTmtJOTQ3Mlh0Y05H?=
 =?utf-8?B?R1ZZOXl6OVBsUlorR2FyK3lodml6MDlWTi9FM0F5cTJLeGI1MzV0Qlo1TlAz?=
 =?utf-8?B?OXZESlZrV1dhSHFrKzJvNGNBQ1liWFZycVJLeXlmajREdnJpTkNZK05sR2gr?=
 =?utf-8?B?ZUdCa0t3djQzcnkweUwxQWdUWk1QaVFBbjRMNlFQRkt4ZWlRYmZzdmlMY2d2?=
 =?utf-8?B?NERmVGIvUnFXb2JpSWcvSkc4WjJBdng0M3l6dXlOcGl2WTNhM2JPam84enhN?=
 =?utf-8?B?RmplQ2RQZEtNVDNXOEU1OWtOZ3FmZUY3Wkl2ZFVyNkV2eEFVRnhsVXhYUHhX?=
 =?utf-8?B?dlROUGtNeUlJNzBuQ1IyNkU3bmFDL2pnVUs1Sld3OVBRbTJ2bFRScGNEUXF5?=
 =?utf-8?B?RDRJdlV5bzY3YmUrRVlNNXJNeFpBRXJ3aVM1TVp4ZE9CNkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1FiYjdBandGUzJoNUNFc0VXVmdhcU95ZXV4dXJOenNWQ3NwemJtVkdsazlp?=
 =?utf-8?B?LzVSVzFocWEvK0NiQ2huK05lUmpzNzFBdTdYUWwza2Vsd3dyNTFjdXlQUnVF?=
 =?utf-8?B?OGxhSG1vVXdVd1BYVjB4OGkyK21NRDhGTVNMWTVNWWVKNUd1b1dxOGNMMHhz?=
 =?utf-8?B?TnlKYkNZTVgzZGpSbWxVQWF2aHFGT0ZCMXVZRWl4cGNvcStCbUtJaWNUZ2Zr?=
 =?utf-8?B?OTdiNnVYV2NQY3hCNVozS1ZRT2dJOFF3R3hSN3hrUXE5RXRvRHN3dlByWDlO?=
 =?utf-8?B?WmoxNGN5QVVNNUxjVWVlMk9BVTVIeFdvdTFjNGlHNHpuK3FNc1UzYkp1R0Iy?=
 =?utf-8?B?Qy9PbWJwQkc4cnpEUUhaeHcwdG5SQjBRelBtM0JiL042MVZiR05jbVJMRGF1?=
 =?utf-8?B?RXVPSDc3MTBYbEQySDhvdWVkb1ZSYnFEMG1KMDdpUUZJOHlxUzJVTXAzUVY3?=
 =?utf-8?B?RDJ0S1ByUHNEOWRZR2xZUEY2VFAwSDlNWkQxWlJYQm1tWktqcm93dmtJNWZK?=
 =?utf-8?B?MjZUdUJZRFczTHZLNXpQTGttZGlMR09FQ0R6YkZEVXQ0cjVvbjFvekUwMUFI?=
 =?utf-8?B?SkU1UHljV0gzTkRTbWs0NzZhdkgzbDJKWHR3TEtRWWRwNDlmYjJsQklKZVN1?=
 =?utf-8?B?WUxiVm81OHZaaHk5dk5jdmZGUklaaXNSaXVtQWZ3YXNua0hTNTA0SFJaaEZp?=
 =?utf-8?B?cFBTcjJpcHhjMHZ1eGN1aTZDMWoxU1ppZWtmTWUybGwrMkFlSkxxSGppN21Q?=
 =?utf-8?B?TVUrREJEUnJSTFlrWm5wT0Vva1hYbGFSZXZNZUoyMDFwMjJYUzBQa3JjZ0Vm?=
 =?utf-8?B?Z3FpWitHc3FNTGNXcFZaT1Qra1laT3lnZDExRkpmUzNpdXI2b0ZMSXRIK3Jp?=
 =?utf-8?B?Tkdxc2VPL2ZDNXozWElaSXFlcHN1SkpJL3M2U3hPcHlXM0RmRE1vNTlMNmg4?=
 =?utf-8?B?eTdWVG9tT0p5OVBRN0VXYkEzL25RNTFCRlN5akEwS1ZXR1ZEWEQ4M2xYNE1k?=
 =?utf-8?B?WU5BNUdCNUVmSXFEdGZyTXlFYmdubW0wVStvbVVEcy9PdjJRUE1Cak4zdDNX?=
 =?utf-8?B?bXE2U2xJOE8yc3VwKzNYYXhhbHFQZzlZak9CK21MN0ZvWTFmeThSWG5wRlVr?=
 =?utf-8?B?ZkJxSmh0M09XYTFUdlo5K2VtTXdFTW1meVZSSFVCa0xDOU1MdGxHQ2d0N2ly?=
 =?utf-8?B?Lzk5a0VIUDlYTTdlVndwRGpiTXNPKzRBR3dDTkpGc3lzSWk4UzNMRTdnejFj?=
 =?utf-8?B?OG9tcnpaczI4S1QvYithK2NDZnJMck11Z2ZNYjYxRUpTSlZuU2t0S1BFcHhN?=
 =?utf-8?B?Sy9wakdsOGZNSnZlQW1lU2JWUlIwWW0ya0ZTT3doU1BKR3B3VWZ2L2JNd2xG?=
 =?utf-8?B?cTJkUTF2N0toNnJtUnUrY0ZZVE5VZlVQU1ZrWENkelFHbEFyR1UvMW9mVTJs?=
 =?utf-8?B?U3Z3SGxzQ2prN3VWcDNBZm9SVzhBenNkRC9lakE4cVhVT2hFNGRjdVNycUJE?=
 =?utf-8?B?R2p3WVYvTWZPZEcraC9GTnN0U04xSEl4cWsyTFN0Q0dYODljMEVIQWtxakgz?=
 =?utf-8?B?STZNZERtUEhFNmVLSEJuS2xXT1ovZXV4VUllYi94dVpjRlBCNnh4enI3RjRn?=
 =?utf-8?B?VjlPMXliYWVQazBXdWtkSko4akdxWmUyb0ZQVlYwUmdWVE1OUFNGNGs5VU84?=
 =?utf-8?B?Rmg2MlFqZllpakR0UU5MTEVWQXZ0VmR5aGcvUVU3WTlKbWtQdWE3ZG54eFdH?=
 =?utf-8?B?bEJueXpXY0wrRTZlbU5jM3llWTlndFdVeGJqU25PQlpiaTFQam83UXRnMW8r?=
 =?utf-8?B?L3NxSVk2UzZFcllFZDZhZEVUbk9Wd3VLUjRYZHVpVTlaM0h0VXk0djJod1RS?=
 =?utf-8?B?NTZUb3h3bDZtSWV2aDJPRThKUmd1bmx0QXRmeldEWkVocHAycld6RHZvcmZ3?=
 =?utf-8?B?dmtCNi9idUptQXc1aXlTUVpGSzFJK0JIc0pnK1F3bXdLQUJnOWFRSmFMU3B0?=
 =?utf-8?B?K0FCcDZGT2FWTDJGZHlrRGpGM2dzNll6Qnl1cGdobWdVS29KN2NDQ3Nwd0hR?=
 =?utf-8?B?Q2E0WkYvNGxHSW45dDFYaFdiQnZjYnB4TmFIR3hBeEVBbmJrREtkaEFSUWVk?=
 =?utf-8?Q?YLTU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322a0408-51da-43a4-01a2-08dcc8712051
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:25:38.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c56iuPHf+bNVCqn+5D1JrAhFebWQBhR6aE/hac34nFhPM3RdHl9NOqKe7tBDvCql8pLBJ7Cz5TgsyX2H1+zIKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718

On Thu, Aug 22, 2024 at 01:03:15PM -0400, Frank Li wrote:
> On Thu, Aug 15, 2024 at 10:56:27AM -0400, Frank Li wrote:
> > On Wed, Aug 07, 2024 at 08:08:14AM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Aug 06, 2024 at 04:33:38PM -0400, Frank Li wrote:
> > > > On Mon, Jul 29, 2024 at 04:18:07PM -0400, Frank Li wrote:
> > > > > Fixed 8mp EP mode problem.
> > > > >
> > > > > imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid
> > > > > confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to
> > > > > pci-imx.c to avoid confuse.
> > > > >
> > > > > Using callback to reduce switch case for core reset and refclk.
> > > > >
> > > > > Base on linux 6.11-rc1
> > > > >
> > ....
> > > >
> > > > Manivannan:
> > > >
> > > > 	Do you have chance to review these again? Only few patch without
> > > > your review tag.
> > > >
> > >
> > > Done, series LGTM.
> >
> > Krzysztof Wilczyński and Bjorn Helgaas
> >
> > Could you please take care these patches, which Mani already reviewed?
> > I still have some, which depend on these.
> >
> > Frank
>
> Krzysztof Wilczyński:
> 	Any update?

Ping?

>
> Frank
>
> >
> >
> > >
> > > - Mani
> > >
> > > > Frank
> > > >
> > > > >
> > ...
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்

