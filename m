Return-Path: <bpf+bounces-46722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84309EF6D7
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 18:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B957283815
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031B5222D70;
	Thu, 12 Dec 2024 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N59CW8kO"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58221660B;
	Thu, 12 Dec 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024574; cv=fail; b=mZuazZ1uy7aWU32o6ROi1dQPH3ojS/jiV/rbS4Kv4PBoISGN0I97Dq/+KlPfmTOj+IeFsXLh5lhg0wYcxoTvLXU7B74IUyfjZpTH09+uy4cZ54WzYsuYURTmnVBCa4ukzvDYe2e10P0+bTDHHw4y+GfRQmBOo6ICcXo5uHs+H0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024574; c=relaxed/simple;
	bh=DtsqEdmIr4jhGvXxVWmCPKddieI3zy4ItlJNjg/wZtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o++FN4D+NwEW2pj9agjeVM1ppgFj34r2iXmomuxIma4Ie/ryQrvvCko7Kdt0dYUQ4fkaAbb7Yg+TjbDwIXmgmaC8xYuF9ojwBVduXSTReR7+I25Wqigo6WQcdiPX7OalAKL01wtTPRakbX2H/4WMsR+xqEZGMM+VqJdFiDoD2BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N59CW8kO; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVCKigI0NPBjxvS3YJaDHL5iMq6cQy5zAdrfiCeSrqvYksX+tA/ip9KHazEUrG4R8DtQccj9lUkvDppuN5ZlOl11afE8tIfiMnUwebr+5bczDObqA1MsXbgvLDf+ExBXHlo11c2jHnK1GMC4hjkT/zhEa1BJD1PM9v65glS3I2GCc5dfSbt+/IHOrH8Q0tN5JR+2gGaZEYnxaAud/AbPJPC2yJCI9zNm/PeMWxJlEAFFbZbSYISa638IVjc0v9PYYotjsOmaqGdxfvTTfL4QTpbC3zFG2x3Mb0FA5N1K4ACn9L3afqNrSdbQH61kZnteeE6H5AWZjIBFp/iLIEcQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdnwnRgncroPhBXROVl1H4zREjKx5YnNuBJ5F+I4D80=;
 b=VTkojfxW+b+r/zRInVMwovDGY14z4U0apf91McDhTH2eUGIs3HLTyFrT0cn7ExdZr4l50hq8/tSMka7W/BbaW2SefJ5JCVtDGgi/zZZUsl6lnamQXn0r0J2sXVXJMPzLQ5MgADTF7PIS5zZsFJhBnDz8CLwuOyQOS8ktPMABYFOfEkOO7gKIN6quFSaggchyaqIoP1aqesxPkl5mJlksRBoTy0lR10mzfxM8EOR7RfR7xPE3gzHK74+yi9u/4Q+9Vx35y+1qB7wl50SwREgKX4QQAWurVvzCdowncMXW6lulqS1jGsCOex1GW8XHBDRQ5iP+5fmtwMTrcFIxhAszXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdnwnRgncroPhBXROVl1H4zREjKx5YnNuBJ5F+I4D80=;
 b=N59CW8kO4BIqlRflwAc5qTgV5DteleA5h0Qf/PqPgCgowkH5/KCk8Qoptdp0xcszzPInOXFDdnaD24wmZDo4pG8/Z7jBuOtYzmY22/pRdg+mxMidp2blER63+HuKyxkztozRs/Bq1SADzP1j7HJH7cvGQmg2k6ak97xVazR4BnCCFGgPQKa17vAmlStE900pWZkekzuE+SKv9atZXLkOhpYfi3d1u6AuB2dazIlhhu9k5R2kq3UE1Ae4UoeQK52gmBKKZFF55/4Sdtj9xxZwoPV1xNgnM+5R9apjhbJtPE54paqRm9hLrVROIcvvxqTNMjlm3MePqTaf4lIphDxcWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8386.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 17:29:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 17:29:26 +0000
Date: Thu, 12 Dec 2024 12:29:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v8 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <Z1sdbH7N1Ly9eXc0@lizhi-Precision-Tower-5810>
References: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
 <20241210-imx95_lut-v8-2-2e730b2e5fde@nxp.com>
 <Z1sTUaoA5yk9RcIc@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1sTUaoA5yk9RcIc@lpieralisi>
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: 167f9839-f8b2-486b-47f2-08dd1ad286be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1AxOW94alNNNGIxcXk5TEh0YlNsQUtmRTV5OUt6V0VneEliUUswZjFGV04v?=
 =?utf-8?B?SlNkMUxEV0w3RVFON0JaQlRpcFUzNklxWFRhc2dmSTJwelp4ZW43b1NQeUZX?=
 =?utf-8?B?RHJrTHdIc1NHY2VzVHhVYnlhZGlCbDlzSjVsS2N3MjhFcmpid2RJWVQ0bnFS?=
 =?utf-8?B?SE5lL3pqakJBYVFKRDBvemQ3N29kYVRMWU5aS2ZHMktnR0ZNZHBTRVQ5SFll?=
 =?utf-8?B?SFBGR09OdzFGTGlLajFsMVJyeU8ybHkyQ1A2L0hGRDB0MHltdVNpQVljSjZS?=
 =?utf-8?B?MUlmcGFLUkFqbVZkSTA1NklnN3VWTkVDdUVvYmNqNk9hUWcrZEZMT09Qalcz?=
 =?utf-8?B?RTBaeUhtS3JXd1RiY0RKR1JRd2FjNGxMb05aTyswdHBMMXpmQXlUT3NySU0x?=
 =?utf-8?B?bHhRaEZHVVRyajVNQjdqbUpFUVN5OFhsZ3E5M1RHbmZhV0lPRXpmQU5GYVRT?=
 =?utf-8?B?cTZweDYxMkVrSFFMems4QjBnV0I4clNHTWxXOW1KRnVPTkU0cnYzU09QT3ZJ?=
 =?utf-8?B?Z05sSXdGSXhQeW5HaFlmc1lTUGNpaTYzVXNMNE5rZVFhWHdsdE1mOGpSRE1z?=
 =?utf-8?B?NERudjRVcy9rSDVlTW5SMG1oVlVKTUZQVG5zdWY5TXo5dGd4bi9NMmtSQkxV?=
 =?utf-8?B?bEpKbmRxK0pXVjYwWGhLWkZyR0NESmVFV1VFM0RqbEN5b09oTkxWdDY5TzRB?=
 =?utf-8?B?c1I1dFNSS2RzdFBVMyt5TVVjeWJEeE5UMURtUlVMcmhQRHdIdDB6ODFtOUNI?=
 =?utf-8?B?Q1duZnFESmlkWmszL21mekRVa2llOXI4NXFZUTRmTlVjOXFEMUE5TmNITkJU?=
 =?utf-8?B?M1FtSURHeWlFYnd2TjhsNWNhcjhtaGRJNXl3a3JOYml5Wi9kQjNiRkFidDNH?=
 =?utf-8?B?SUZVNE5mT0M4SXJKL204Z3dVOXhiYmZvc3FjU0RmenV4Q2k4bWRBTjFBdFIz?=
 =?utf-8?B?djVDWDZwRGI3eEFManlLb3FZSndRMWx3bVVXM00zTGZTVzF1TWVGcGNUTVN6?=
 =?utf-8?B?MXZzY3k3ZEhuUVl1QS80WENYS3R6bzBqQWwrWkh2V2pWcEF6dEIyMGcrZml3?=
 =?utf-8?B?bHhqbEI4Nm5KY1MzNG9RME52elJzcHVNMm9BUW1oRGtWaHR3eWJpbkxvbjlR?=
 =?utf-8?B?MGpUSmY4YjRLRXIzSlNPajlySkFWb1FjTXNrMTdtZTJpUU9weTlScnluWHNz?=
 =?utf-8?B?NlRHTEN5UHpEWW9SY1l0N2RjUUlqZlQrcDNYaTVrSmxpclk0aXlJYUMwQ0ZI?=
 =?utf-8?B?dituaEVkUHBrK3Fnbk5aTHZUbkdIOE5EWUd4K0tDM3NMeGR0RUZQUktDTkpk?=
 =?utf-8?B?MHF3R2ZmR1JvS3c3OU92NVVZWEJ1MXljZjBkZ2kvUkp1T21lL2p5ZHJBSmpE?=
 =?utf-8?B?S043bHVUaDVvRlFhMURoWFU5Mmx1Z0x0ZU0zUVJBSEllR0hBc3JacllQRnB1?=
 =?utf-8?B?SUZNMVRrRVdxUFdPTG5QU2xLZG1YODhxWXpuazFJSzdNTUVrSWF4NVlYZW9W?=
 =?utf-8?B?eTFERElOVGNQcFZGQ0FGaGFWZThvSXk4c0E1cjJxVXJwQTRSK2FyR1ZTU3FF?=
 =?utf-8?B?aWVBSjRiYU5zMStEaHhqNGNQUnJhOHI2bVpMVEpWQ1ZuRk94Wm0vaGdMRGpJ?=
 =?utf-8?B?RTl0bW1wbWVHMjJZTWQzamxZSlNEeW44cVc3a2taS2w0QzBMQjFPbktSbWs5?=
 =?utf-8?B?Vjg2ZnBuYS91eUtUeW1GbzhRLzA5MGw0REhROTl0VlBsZmhSTnRJSlBZV3R0?=
 =?utf-8?B?N3ZQalc1dWdPM2dJbkRQUWdhT25haUgyRXBGNUppdTZsUDBhY2IxNXhBZFps?=
 =?utf-8?B?QUtEZnMrOEF1RlZoNm1BeHBSTTI1VFhUaldZWTlMKytJZWVmY0M1Z0gzSC9z?=
 =?utf-8?B?M0VKbFFTYU0xVWI5VS9lcHVBWWQrbVNnaU00TWx3T2pCUFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGk1OEdGcFhQWk5YVU5VU2M4ZFBxZ2RSaUtocjRUMmVNZ2plVk5JQ1pIL0hL?=
 =?utf-8?B?ZmorcW9KcjNENFAyTmFYOUpDaVlLSDRXQzF2cnVMbUc5Sk9CQmc5VW0veEZz?=
 =?utf-8?B?djAxUUZ1aitMcGRkRFBUd0w2dGNWSXljVFBzU3VlMjk3TmtzSytWZStINnhR?=
 =?utf-8?B?dHFTb0RKaThyV1pOcEJoaTU2ZW1FUnZ2VlhjYWZSWXdIWFh0WVZCSkdTdXlm?=
 =?utf-8?B?cm5vS2JNdmYwWlRuTm9OTGVmMmRpQjM5TmdnTTRvZHpVQXFvb2Uzdll6aDdT?=
 =?utf-8?B?ZDFvNm1jVWlXeTU4ZUk0T25XQXdOSVZ1dlZvZm5QWGJrNHYvdlNudzE5VzBo?=
 =?utf-8?B?UFE2MEwzWmI4ckRGYmNHUEpGVkNNd3BzR1JQdG0yT3MwU1NxdXhOa3QxbVRX?=
 =?utf-8?B?N1k0V2NDQ2xVdk5pOS9aYUphZUFHR29haFlQRnNRTUlGWDN3SzFDNm1HZXJV?=
 =?utf-8?B?UnBQUElMWW83MHBKSzZmekV0Wmw3cndkR3ZmbVJDekgwNUNOUEZRVVJBekR2?=
 =?utf-8?B?KzVoU2h4Skx3WndEd2FPekhncHhmMXpvd0h2QjlrZ1pyOE9wK09BVlpkRzFl?=
 =?utf-8?B?UkJnOUNzOW44RFNud2dtdFNoekh4Zm5haTYxWmdGa29WRFBHaVA5OHdNQWpz?=
 =?utf-8?B?M2l0Uk0xa20wWnlnZ3VXaEpwdEdldEhqUG9yc2RKeHI2V1FsTHI3clVRVjNQ?=
 =?utf-8?B?MkVaWnNzZU1teStlcmFmcDVMV0tXbUUvTWRYTTdXM0hpVTI5MWZsRGJKcURO?=
 =?utf-8?B?UFV2d25jaFR2THlMNVN5WUViN1B5cWdRdFBFaUtlc3QzQUJlWG9iYlAvY0Fj?=
 =?utf-8?B?elVlRVY1ZnpGMjU4eG9rMkdCQ2xHK0U3bXRTdVdycTFjZDZzSVZ5VkhGY0JM?=
 =?utf-8?B?dS95VGZROEx6c0RVcXJwMDV4NmdJbHg0YThxYytVMXNTR01ad0hSSTI1L3FC?=
 =?utf-8?B?RDV4ZVA2eFpPOHlkZEdhYjdpMFhXcFpLZjZhYkh4M3pvWFl6WlAvQW4zRzds?=
 =?utf-8?B?M2lyMWorN1JZeHVMWFhmYWh0QzZXQ2xaeWZ2anBEeStiOVJGT1dPdXNKQm1Z?=
 =?utf-8?B?QlZmdjI0eWRTTXd2NjNZU0ExbW13UDRLc2hmSmF5QzFmY3VKWFl6S3Y2TTFh?=
 =?utf-8?B?NnBLVUw3cU53d2pycEFPcXBXaE1scHhxejU0Nnlhcm5MM01XOEgydjZ5SjZE?=
 =?utf-8?B?RWc1dXJnUHB1ZXFEOGVGaHd0Snd0SmxrU01kd1p0alpJc1RkblVxUnF6K3gr?=
 =?utf-8?B?cVM5Z28yQmZSTzFzMG9wMllwZXZWRVhLUVh1UUpTdkQ2enlieXl4aWVDWDkx?=
 =?utf-8?B?RXF0UXUrU3BJZnZJdFJJSWlqMkJGZGFOMU5LeDBtRjBpK1ZabUN1ejJ3UmE1?=
 =?utf-8?B?aHZkbVhCSU9lc3NVbDZUbG5DME54N1FEMGlENEJSc0JHbXBEc1J1R0lSWC9D?=
 =?utf-8?B?MlRkTW9pdHRKQlNBU2VvMmtGekEzUStGMHp4d1Z5VHh6NGltOC9aMDBIMDUv?=
 =?utf-8?B?amh3YUZGNHVQdWFpTC9GcUJOa21Wa3RKdVF0cExDU1lKNW9zRnBTdTBCNG0v?=
 =?utf-8?B?V2xoMThjWE5GMTdqYXhtY1M0NmFpbDNWN2dZNjRkR04rRlYzU1FsNktpRUEw?=
 =?utf-8?B?ajV1dVpHbGJNY2hpVFA1MW4xZ1gybS94Qm9LRHczZk5aT1p1QkVsUlJqUW5J?=
 =?utf-8?B?b3lLZUlWQ1RoZWwyczNmL1p4OVZlSkJMdWxnbXordVlxSEJHZm13dDhsVE9p?=
 =?utf-8?B?UjJJVUdtWENOZTF1M2FEY09mUEJwSC92V3F0MnB4QVdPa1pUT3dqdDdzMTBT?=
 =?utf-8?B?NWVnOEpZV0NmdXd3TUE4aEg0NXBQbm95WjBsYVN5bGFsMjRiUEora3NLMmdS?=
 =?utf-8?B?dFg2WGNsWm9CVTEvQVoyTStEaWc4ZkR2UnV5YVZZc0llUGV5VE9MSUhNMHVq?=
 =?utf-8?B?RmcxVElXYkMra2d5NTRHYSt0VVRVOXZPY2JUVGJDU0dCWC9xRGtrTEROZGI2?=
 =?utf-8?B?d2duL2t3SWlxVlQ4TXlUQ3g2T3luQTdDNG4zVjk3bkRITlJMZm4zR0cxUEJp?=
 =?utf-8?B?dXFHL29MZ1RTVDJPVW9EMVBnZy9rVjNQcDQ5Rktac0JwTXhQeE1STGhpRC80?=
 =?utf-8?Q?mI9nnfSDmDX1mEe8WwnvO7Ldm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167f9839-f8b2-486b-47f2-08dd1ad286be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 17:29:26.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvlPdjEJeTgyWGmdfWHmN7dm1jd0CeK4exOo3sCUdfjH9Dbotn36CY+AMGgZtr0QngBprwMR90H52Bt9G4U+9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8386

On Thu, Dec 12, 2024 at 05:46:09PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Dec 10, 2024 at 05:48:59PM -0500, Frank Li wrote:
> > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > This involves checking msi-map and iommu-map device tree properties to
> > ensure consistent mapping of PCI BDF to the same stream IDs. Subsequently,
> > LUT-related registers are configured. In the absence of an msi-map, the
> > built-in MSI controller is utilized as a fallback.
>
> This is wrong information. What you want to say is that if an msi-map
> isn't detected this means that the platform relies on DWC built-in
> controller for MSIs (that does not need streamIDs handling).
>
> That's quite different from what you are writing here.

How about ?

"If an msi-map isn't detected, platform relies on DWC built-in controller
for MSIs that does not need streamdIDs"

>
> >
> > Register a PCI bus callback function to handle enable_device() and
> > disable_device() operations, setting up the LUT whenever a new PCI device
> > is enabled.
> >
> > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>

[...]

> > +	int err_i, err_m;
> > +	u32 sid;
> > +
> > +	dev = imx_pcie->pci->dev;
> > +
> > +	target = NULL;
> > +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> > +	if (target) {
> > +		of_node_put(target);
> > +	} else {
> > +		/*
> > +		 * "target == NULL && err_i == 0" means use 1:1 map RID to
>
> Is it what it means ? Or does it mean that the iommu-map property was found
> and RID is out of range ?

yes, if this happen, sid_i will be equal to RID.

>
> Could you point me at a sample dts for this host bridge please ?

https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/arch/arm64/boot/dts/freescale/imx95.dtsi

/* 0x10~0x17 stream id for pci0 */
   iommu-map = <0x000 &smmu 0x10 0x1>,
               <0x100 &smmu 0x11 0x7>;

/* msi part */
   msi-map = <0x000 &its 0x10 0x1>,
             <0x100 &its 0x11 0x7>;

>
> > +		 * stream ID. Hardware can't support this because stream ID
> > +		 * only 5bits
>
> It is 5 or 6 bits ? From GENMASK(5, 0) above it should be 6.

Sorry for typo. it is 6bits.

>
> > +		 */
> > +		err_i = -EINVAL;
> > +	}
> > +
> > +	target = NULL;
> > +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> > +
> > +	/*
> > +	 *   err_m      target
> > +	 *	0	NULL		Use 1:1 map RID to stream ID,
>
> Again, is that what it really means ?
>
> > +	 *				Current hardware can't support it,
> > +	 *				So return -EINVAL.
> > +	 *      != 0    NULL		msi-map not exist, use built-in MSI.
>
> does not exist.
>
> > +	 *	0	!= NULL		Get correct streamID from RID.
> > +	 *	!= 0	!= NULL		Unexisted case, never happen.
>
> "Invalid combination"
>
> > +	 */
> > +	if (!err_m && !target)
> > +		return -EINVAL;
> > +	else if (target)
> > +		of_node_put(target); /* Find stream ID map entry for RID in msi-map */
> > +
> > +	/*
> > +	 * msi-map        iommu-map
> > +	 *   N                N            DWC MSI Ctrl
> > +	 *   Y                Y            ITS + SMMU, require the same sid
> > +	 *   Y                N            ITS
> > +	 *   N                Y            DWC MSI Ctrl + SMMU
> > +	 */
> > +	if (err_i && err_m)
> > +		return 0;
> > +
> > +	if (!err_i && !err_m) {
> > +		/*
> > +		 * MSI glue layer auto add 2 bits controller ID ahead of stream
>
> What's "MSI glue layer" ?

It is common term for IC desgin, which connect IP's signal to platform with
some simple logic. Inside chip, when connect LUT output 6bit streamIDs
to MSI controller, there are 2bits hardcode controller ID information
append to 6 bits streamID.

           Glue Layer
          <==========>
┌─────┐                  ┌──────────┐
│ LUT │ 6bit stream ID   │          │
│     ┼─────────────────►│  MSI     │
└─────┘    2bit ctrl ID  │          │
            ┌───────────►│          │
            │            │          │
 00 PCIe0   │            │          │
 01 ENETC   │            │          │
 10 PCIe1   │            │          │
            │            └──────────┘

>
> > +		 * ID, so mask this 2bits to get stream ID.
> > +		 * But IOMMU glue layer doesn't do that.
>
> and "IOMMU glue layer" ?

See above.

Frank

>
> > +		 */
> > +		if (sid_i != (sid_m & IMX95_SID_MASK)) {
> > +			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	sid = sid_i;
>
> err_i could be != 0 here, I understand that the end result is
> fine given how the code is written but it is misleading.
>
> 	if (!err_i)
> 	else if (!err_m)

Okay

>
> > +	if (!err_m)
> > +		sid = sid_m & IMX95_SID_MASK;
> > +
> > +	return imx_pcie_add_lut(imx_pcie, rid, sid);
> > +}
> > +
> > +static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > +{
> > +	struct imx_pcie *imx_pcie;
> > +
> > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> > +}
> > +
> >  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -946,6 +1122,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  		}
> >  	}
> >
> > +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> > +		pp->bridge->enable_device = imx_pcie_enable_device;
> > +		pp->bridge->disable_device = imx_pcie_disable_device;
> > +	}
> > +
> >  	imx_pcie_assert_core_reset(imx_pcie);
> >
> >  	if (imx_pcie->drvdata->init_phy)
> > @@ -1330,6 +1511,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	imx_pcie->pci = pci;
> >  	imx_pcie->drvdata = of_device_get_match_data(dev);
> >
> > +	mutex_init(&imx_pcie->lock);
> > +
> >  	/* Find the PHY if one is defined, only imx7d uses it */
> >  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> >  	if (np) {
> > @@ -1627,7 +1810,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX95] = {
> >  		.variant = IMX95,
> > -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> > +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> > +			 IMX_PCIE_FLAG_HAS_LUT,
> >  		.clk_names = imx8mq_clks,
> >  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> >  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> >
> > --
> > 2.34.1
> >

