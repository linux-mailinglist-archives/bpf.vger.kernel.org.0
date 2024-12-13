Return-Path: <bpf+bounces-46872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C69F1380
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5822832D1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1C1E47C6;
	Fri, 13 Dec 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HEgAQzmV"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5081E47AD;
	Fri, 13 Dec 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110458; cv=fail; b=JYUSRhX0wDOtEQZMm9kcZs44cteLbxTmKlrqWqcDbdPcSAsEJzn5B5iAIRN68LPNdeABr0XN0usMxBidg1Y/qbocYx9ynE/s5/UoaFmvpHz8gKNFFyS5IVw+7xHcAz6W7bXs4ZiOQJ6HpNZsO8fIrZiqELcJ9u4jwMRAZ+Y4J/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110458; c=relaxed/simple;
	bh=jmvduMD2Kbnf6IZ/gKudgbBNOMLrKcTW85xEjFrORkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SVuH/JKI4gmNCrBD5ijktozGknkqZVfoRbqdQH3I8itvrslV0MIQl/mMQZ6ivWDj3kFofJjOj9tIvf6kBh/XzPz3gv01QQ6cDezN14FMIrCI2RgC9J8fX7oVQjIjIIQsJbGJoMmj/E1oOp/D0KC/evAH1vtzDQ6mIVcrN+HRMiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HEgAQzmV; arc=fail smtp.client-ip=40.107.241.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVRGBIJMsmI5lk3WtA2lie6/4eDfxhBYhApcyg4i7C/TxaDmjU6oYMGeBygPTH38CWSnb76V5Hduy3OmY9x/38BhUc9zHMPDR1YRAe8cCph5gdQlXfvm2zTmcZ+Iwdx4yKMNh+RqOHYnCuhzCkPq2pRPt4rrHICsPrdoRK0Ralu/sL/ekm+yOFfLEEDaLgs12D+AAKDtnPXJlsuaWahp+zw/kb/Gt6TP8/hd5f/4ALvSUtPXJ38ImVD1UaRaFgxzwIa3cVrj1KDx4HI3Hy0vGPIIlrGUb5OX4o+uELtPaGxFiT+uW36ar+N8lclzlgC8pdFnGbMpFWDEorR5gxyc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxt5b6tXm/iGDPvHHPAzIttFKWv/r0zIVV43Trqtg+Q=;
 b=C+6CMbSrJkezN88XG0N+mYD88reVZBKW96LwmXrw9Anhde5rWWncHmPUsYXpxdG62PKribupyuppPfMyoqNLs4BzAmcD7oTFTmHmKgvlAYjnEjZSG42yAk4h6wIzY9L92UEYzthp97PBBv4ArtT8waNLJusDe1pSCdn/I0Xoy3dvHJZeHigPlxuaB11FMgMs2YEKZ/0tVK3T8bplpWSaE7W/0h6hhrxnVdlkhGYGoQxNyzCJrD4NgtbqtUm1PbWrCqZhlrHEf/AJMHhQvtWuqOOhEptWUzr7xjd3x+sQ6J2rSJ57L6XiC6UjQw+srGgzROcyzPBF7ycZU12eRydTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxt5b6tXm/iGDPvHHPAzIttFKWv/r0zIVV43Trqtg+Q=;
 b=HEgAQzmVTlfxA90vGt4MOaubX5nMC9Kl+06ZO59cH3XelT57BwPxLZttc33JG5XLr+3dhqtU6vYilBGuy6r9oyuk17io0kHiO/RSLczoawZuZMbUPb91AlUJIkQ/t99kf0p353KQq5SAyenv3ouUO/1LCXEypEGRpphGk4xloozRqxmXVTmc/frVGKJ++jux8Q6o9Fwc+Lu7kiCLeUnexyo+/RzZ0qP/+136bly/KUxCGUmY4tkSncI+CB+z1xZn0ViXBG6tjzlBn2FzGGKmKfQe4Kvr7MWYSwwdse5cXOf2cyPY6XBkwuTX8UD/97dZ/QwbTMiNS1UuzzCJn8xaHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10298.eurprd04.prod.outlook.com (2603:10a6:800:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 17:20:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 17:20:52 +0000
Date: Fri, 13 Dec 2024 12:20:40 -0500
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
Message-ID: <Z1xs6GkcdTg2c73F@lizhi-Precision-Tower-5810>
References: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
 <20241210-imx95_lut-v8-2-2e730b2e5fde@nxp.com>
 <Z1sTUaoA5yk9RcIc@lpieralisi>
 <Z1sdbH7N1Ly9eXc0@lizhi-Precision-Tower-5810>
 <Z1v/LCHsGOgnasuf@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1v/LCHsGOgnasuf@lpieralisi>
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10298:EE_
X-MS-Office365-Filtering-Correlation-Id: 027045de-6bf5-4bdf-ce85-08dd1b9a7ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFV6cGlQU21peHh5VjhFT2hEQmZCUjRNS1c2SGxzdG9MWUFvZ0xhZ2RIVGFx?=
 =?utf-8?B?MDQ2bGt1Y0xyOHpkWWpZbUxtbkZIMm14YjIyOG5rdTBWV3lsTE8wdFFDZ3Vh?=
 =?utf-8?B?dkdKdGxKLzdOVGtmQ3hoZmVTNUtGbTBkK1RndlM5VWFiVW5OakhtQi9BaGxp?=
 =?utf-8?B?L0VKQ0g4WHMyQlNHdjZaMnhZMFA5bW05dGtheUxEd2g2VU9TcmhGTGRZREhB?=
 =?utf-8?B?cjZnMjFVZ1lkOGhxQVI2NmRyOG9lc2RQWE1SR0UxdE51OUxScDBKbXB1SFlV?=
 =?utf-8?B?ZERpVzVVemV6eDdEYmQzRFdPbW5GSWtpYUhpa1p4cGM2UXFNeTg4UVJsc3dQ?=
 =?utf-8?B?R0U0dHEvYkIyNm1oZHlCL1JQQ2t1UnBLN2tVQ1dEZWk3WE9nM3dsaE9SVk1s?=
 =?utf-8?B?Wkt0VnZ1K2puWFVVSDJVWkI4Sjk2N0VUaE1KTVltMU9Cc0Z5blF1Q1dUR1Qz?=
 =?utf-8?B?U3YwV09YbGhhdHhTMFUraURwRlFkN2VkRFgrNmtWN2lnTjQxT0FSY1BDNmVV?=
 =?utf-8?B?K1R2VGU1Z0l0Wk5uU0J4NXZ3OHMvT0c1WXlZRXBoM091aFI0TUs2YUhDTUxj?=
 =?utf-8?B?cklWenhaWEZhaVRNS1NDNHJHaHVhbmFLMlQvSVFUM3o4RS9uMXlyNnN6QjJH?=
 =?utf-8?B?R04zVVNXWUV0OFU3aDdvaVFYb1B6eXpCeFBRcml3N21NT2pyQzVET1p1RTgr?=
 =?utf-8?B?MUZBQ2pjc2FWcXNQVkZBN1F5eVFDejA2cTI5QkZQUGhsUnJESjJENy95azN4?=
 =?utf-8?B?YW9NSXhtNmczUDVoMVZHWWU5Szhsb1UveEVkeUFIN2E1ZkllZDBMMmVkM3cw?=
 =?utf-8?B?VnNEaEJXTUg4TjEyNWxKTGZlbWxGRG5HMWlRS0tqZ29qcHc3MmJhWFAzcC9N?=
 =?utf-8?B?WHl2NGxZUDRjWlhacStCOXV5Q0Q4Y2J0NGpEUklnZWtkdjZMdnM5SzNTYlRP?=
 =?utf-8?B?c1NyN1NNZ015TUNhUjZWN0dSOUF3b3pQc3kyTTRyenI3WnUxeTMrdmRZVkVX?=
 =?utf-8?B?VjlaUFkycjVBL2xpbGtuZTJiRFl6d3pOM01rSVg0TDNrTERmNDBoNnRxbThE?=
 =?utf-8?B?emhxL0R3OFp5cVBXZUhYcjZhRHNjOExFL2xvdVN0eXB1STJqTzVQVzh4M25M?=
 =?utf-8?B?ZHNYanByY2MwZjdqSFl4dEgvcGZucGxVK1hjWmlyWDY3Wm9mUEtUSXhsTGhN?=
 =?utf-8?B?VE1ucFNGRUNuSUx6MW5kaXAyMGsyNkM4azZ4R0ltOThDUW8wQVhKSDYwSXNX?=
 =?utf-8?B?L3VBbkNNeURkcm9xNjRja1dsRzJSNk5MMk93MFBuMXJBeXRkRTZJb0V5emV3?=
 =?utf-8?B?bW5ad1R1b0dJSGpQQ3VOQkRMUHJYcVhzV1ZuQk1udDVxeU1hSzYvaDg2RG5B?=
 =?utf-8?B?TEgvcVh4c3RPWUV6MXcvQml1N0x3ZUQ2QVU0eDIzanpjWTk2TFI3enhRa2lt?=
 =?utf-8?B?dGdtUlhIRkFlVU16SnJSTGhmcHl2cVBKcG5RUDRUME5iVmJmNlRQYmswVUZZ?=
 =?utf-8?B?UkRnOXJWMzRFYmxZczBuKzhDaVpOYmhhbHFrYzgzSVhmS0RIdU9TQ0pkTkhZ?=
 =?utf-8?B?d1ZpWWdoTktYZVA0T09HMTdPOHZ0Qzd6OU1OSkpVdVFEZXhzSVc5TWhXNnNk?=
 =?utf-8?B?eGNBM1BWRm5MMkRQUEdLS0ZQcXAxdEE4Y3dSQzZ6K2xabjNXSllwVGJMMTVt?=
 =?utf-8?B?a2tRY1grbWdSeFBiY0FlUTNFeENjOWFsSTR3K1JlNXg2LzNBblgyU1JDUjZJ?=
 =?utf-8?B?K2JKRlB1TE5HaFVVWThFbzhxM3JFaTFoRklTRzNYTzc1M0IrUUpHSXhRdnFx?=
 =?utf-8?B?dmtlOGFmcDAwb2lZNjdPUGtlTlJNcTdkK0ZXcXJZblZFWlA1ZURTRmZhNHEx?=
 =?utf-8?B?d3plTE1HQ2hKRFFKSFkwSHk3YjFPTzQyVHpVNFlNc1Vvc3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2Jja1NXOVJOd1BsTWVCUHh6d3dYREk0cE5Pc3dSVkMzbkt1cy9raW9hb0do?=
 =?utf-8?B?ZVhIbnQ0L3IvZDBHa2UwTThlekNITUpIQkNaM3hsUnV0cTIzdjhHRkV0YUJW?=
 =?utf-8?B?OHdOYTBjSzk3a3NaZWhoZzQ0OVIxanhsVktHMUt2S1NJN0JsTmpvd2FMUU1J?=
 =?utf-8?B?ZjNPYzZXMnhjL0V0UG1mNVRqN2tDL0o4b0wwem96ZWNnTzcyK2hIZEVjc0NI?=
 =?utf-8?B?R1UrRVJOT0xiNC9wZ2Uza3h4M2E3Vi9zSXJNMlMwdFFGV3cvTnBRUXNmWUtq?=
 =?utf-8?B?WVhHYmRTMnFOdkwwbDB6R0QzWWRYUHREVTBRWUhqTUlsbmI3ZUxTMVZVZ0pY?=
 =?utf-8?B?RG9LV2NXajBaRmgyaFV3THJwbmwrOTNBdzZPWktwQlAvaWkyL3dTd0dlcStP?=
 =?utf-8?B?OWxUejh1b2YrbC9abnF2TEtvaVVMc2dRYnhKVUZaTDI0SThsVXBnVDNjUTN0?=
 =?utf-8?B?NzluYklnNHprVEZPdi9iL05DeHFaSG5QNnl2bzlQWnlNdlBYNzZxTEQ1dmJz?=
 =?utf-8?B?NGYxK1dObGh5RzV4OVJhengrQVNvbmpDNjZGNXlyZlM5RWJNc2QyQU42NEJ1?=
 =?utf-8?B?ZHBqcTNIbmtuZkxGbTVka3d0V2hDMzY3RmdpbU9pcUN4QUNXZlU0RkpnSlVv?=
 =?utf-8?B?b0hBbDExUVRRTm00UzZHcFViUHBYcjVHMXFMZmVBYlIrN0ZJdjdLMjVRaFNE?=
 =?utf-8?B?YkxUbGNXV2lXdllmdnE5b0dPYTJUSXExRVJmcEFrUTFNOUhVYkZEMnFxTCtt?=
 =?utf-8?B?dzlUbWlHc1hQSGNlNmYyZ0UvMDNZeHp0WWhucDM5ZEw4TzdNTmVkK0c1RWRL?=
 =?utf-8?B?WjFyWnB3WmpvUllDVWFXOWtZcDNwTFp4S3ZYOHdCU1JwNEVQTUN2VFpqeTYv?=
 =?utf-8?B?aHdWdmpDeXJiY0h5ZTdUYlVZeUZ4Nnk0M1V4emVuUy9aOXdIQ1RHcDVvVmRV?=
 =?utf-8?B?OFRmbFlCdFRjTE5oMlIxdVI0bkJUTEl3TjJaOWdaTTR3cDNnU3pTb2tlYmtj?=
 =?utf-8?B?aXlNaUVEOEhpeG4xbk1nWkJXamgxWFlhaTB1SnZoSjQ4VFU5TmtCWmtITmcr?=
 =?utf-8?B?U0pGL2pZUmY4T1BOc0lsVjZKNjhCeURLMTFwT1JDZGl4bG4zU0QyeVFtK2N4?=
 =?utf-8?B?MS9xdEdMU2pIRkpubDgxYnYyMkYrUnpFNzM1RWtienNJSkI4T3JyNGx4dHI5?=
 =?utf-8?B?aGtkWGduMWlDQWVmY1BxbGhydGxoQUZWWWI3OUxOR2s2c0ZsM3dvNEpnRzRF?=
 =?utf-8?B?Vy93STVCOEIvYnZBZDY4a3FsWWp3SXRCMDhJc2xIMlhEY0Y1Zk92MnhQa1Z0?=
 =?utf-8?B?dDhKN0NEMzBXZFRSN29WS1dSU1I1elFXUG1tUGxoSUF5MUdjRGNKS0t4bnkx?=
 =?utf-8?B?UjFBdUROaDVhb1ZVOFhuM0F4d0RmOEZUNmR0bmNJd0wrS2hHbVYrYm1HbVNH?=
 =?utf-8?B?R1g5YnpCN1NSZUdsdlNxWE5SR0NmM0JkQUd5R2pNajFpUGpmOTZVdTA4dTV2?=
 =?utf-8?B?L2RDRzl2Y09GNWQ5SFN3Yzd6ZjliN29xNTczQkVKK3Q0Sk1sMFNmcFVxdlhH?=
 =?utf-8?B?K05wNS9BY3Ixak1QKzBaN2syaFFZOUlhRTBJRWJDR3FuMmtkNnpsZUVlcmUr?=
 =?utf-8?B?VCtlTWFXRzg4TVVWbnByaGhMaDFaaFlnUDZHNUkvdmp4cWJGT0wrMnY1WXNz?=
 =?utf-8?B?NFF4OTRCZktPdXpwNXdYM2V6NjFnNW54emFVQ1BITVV5WFJlaC9IYnN6aGJ5?=
 =?utf-8?B?Z3VZN2NlS2NYZndZMjZGVmM2ZzJLMVFlYjdJWWczQ2VRa3ZITkxickJBYmEr?=
 =?utf-8?B?ckxOMWdNenpEZlQ4MFovcm5yZDQxZytob21sY2FQc2pxMDZELy9MVUxiaEJB?=
 =?utf-8?B?U0x2QmI1bXQvN0p1MEdlRkFGZG1TTHc4VVdZSXFjcVBEVjZ0aXBLNVU0RXVS?=
 =?utf-8?B?cUpBVVBCZTlLSHhzeXhMclRvcnpCbzJXT2h1cmdKN2JvaXVBd2E0R2Ixb2Zk?=
 =?utf-8?B?dnhsSSs4WXlFalVheHVCeHJ6RHg3ZklWQldMT2pvUWZrVDFLeDNzc3ZLWE1V?=
 =?utf-8?B?MFF1bVYvSktKZDZvT0IzNkN1RXJuTzQyY2kzUWJ3d21vMEdnbHpSSFNlSG9s?=
 =?utf-8?Q?NH8Y9VLXWvtRjC0cGNSiP9hCQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027045de-6bf5-4bdf-ce85-08dd1b9a7ef5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:20:52.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPfQ7JwlXqPyysvdHQ60jWvL30wt++fTUCeq8utuDx+JP8RsSXza+4WHANuroR6XBtSGojVtsALVwO5+IxKXqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10298

On Fri, Dec 13, 2024 at 10:32:28AM +0100, Lorenzo Pieralisi wrote:
> On Thu, Dec 12, 2024 at 12:29:16PM -0500, Frank Li wrote:
> > On Thu, Dec 12, 2024 at 05:46:09PM +0100, Lorenzo Pieralisi wrote:
> > > On Tue, Dec 10, 2024 at 05:48:59PM -0500, Frank Li wrote:
> > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > This involves checking msi-map and iommu-map device tree properties to
> > > > ensure consistent mapping of PCI BDF to the same stream IDs. Subsequently,
> > > > LUT-related registers are configured. In the absence of an msi-map, the
> > > > built-in MSI controller is utilized as a fallback.
> > >
> > > This is wrong information. What you want to say is that if an msi-map
> > > isn't detected this means that the platform relies on DWC built-in
> > > controller for MSIs (that does not need streamIDs handling).
> > >
> > > That's quite different from what you are writing here.
> >
> > How about ?
> >
> > "If an msi-map isn't detected, platform relies on DWC built-in controller
> > for MSIs that does not need streamdIDs"
>
> Right. Question: what happens if DT shows that there are SMMU and/or
> ITS bindings/mappings but the SMMU driver and ITS driver are either not
> enabled or have not probed ?

It is little bit complex.
iommu:
Case 1:
	iommu{
		status = "disabled"
	};

	PCI driver normal probed. if RID is in range of iommu-map, not
any functional impact and harmless.
	If RID is out of range of iommu-map, "false alarm" will return.
enable PCI EP device failure, but actually it can work without IOMMU.

Case 2:
	iommu {
		status = "Okay"
	}
	but iommu driver have not probed yet.  PCI Host bridge driver
should defer till iommu probed.

Worst case is "false alarm". But this happen is very rare if DTS is
correct.

MSI:
case 1:
	msi-controller {
		status = "disabled";
	}
	Whole all dwc drivers will be broken.

case 2:
	msi-controller {
		status = "Okay"
	}
	if msi driver have not probed yet, PCI Host bridge driver will
defer.

Frank

>
> I assume the LUT programming makes no difference (it is useless yes but
> should be harmless too) in this case but wanted to check with you.
>
> Thanks,
> Lorenzo
>
> >
> > >
> > > >
> > > > Register a PCI bus callback function to handle enable_device() and
> > > > disable_device() operations, setting up the LUT whenever a new PCI device
> > > > is enabled.
> > > >
> > > > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >
> > [...]
> >
> > > > +	int err_i, err_m;
> > > > +	u32 sid;
> > > > +
> > > > +	dev = imx_pcie->pci->dev;
> > > > +
> > > > +	target = NULL;
> > > > +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> > > > +	if (target) {
> > > > +		of_node_put(target);
> > > > +	} else {
> > > > +		/*
> > > > +		 * "target == NULL && err_i == 0" means use 1:1 map RID to
> > >
> > > Is it what it means ? Or does it mean that the iommu-map property was found
> > > and RID is out of range ?
> >
> > yes, if this happen, sid_i will be equal to RID.
> >
> > >
> > > Could you point me at a sample dts for this host bridge please ?
> >
> > https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/arch/arm64/boot/dts/freescale/imx95.dtsi
> >
> > /* 0x10~0x17 stream id for pci0 */
> >    iommu-map = <0x000 &smmu 0x10 0x1>,
> >                <0x100 &smmu 0x11 0x7>;
> >
> > /* msi part */
> >    msi-map = <0x000 &its 0x10 0x1>,
> >              <0x100 &its 0x11 0x7>;
> >
> > >
> > > > +		 * stream ID. Hardware can't support this because stream ID
> > > > +		 * only 5bits
> > >
> > > It is 5 or 6 bits ? From GENMASK(5, 0) above it should be 6.
> >
> > Sorry for typo. it is 6bits.
> >
> > >
> > > > +		 */
> > > > +		err_i = -EINVAL;
> > > > +	}
> > > > +
> > > > +	target = NULL;
> > > > +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> > > > +
> > > > +	/*
> > > > +	 *   err_m      target
> > > > +	 *	0	NULL		Use 1:1 map RID to stream ID,
> > >
> > > Again, is that what it really means ?
> > >
> > > > +	 *				Current hardware can't support it,
> > > > +	 *				So return -EINVAL.
> > > > +	 *      != 0    NULL		msi-map not exist, use built-in MSI.
> > >
> > > does not exist.
> > >
> > > > +	 *	0	!= NULL		Get correct streamID from RID.
> > > > +	 *	!= 0	!= NULL		Unexisted case, never happen.
> > >
> > > "Invalid combination"
> > >
> > > > +	 */
> > > > +	if (!err_m && !target)
> > > > +		return -EINVAL;
> > > > +	else if (target)
> > > > +		of_node_put(target); /* Find stream ID map entry for RID in msi-map */
> > > > +
> > > > +	/*
> > > > +	 * msi-map        iommu-map
> > > > +	 *   N                N            DWC MSI Ctrl
> > > > +	 *   Y                Y            ITS + SMMU, require the same sid
> > > > +	 *   Y                N            ITS
> > > > +	 *   N                Y            DWC MSI Ctrl + SMMU
> > > > +	 */
> > > > +	if (err_i && err_m)
> > > > +		return 0;
> > > > +
> > > > +	if (!err_i && !err_m) {
> > > > +		/*
> > > > +		 * MSI glue layer auto add 2 bits controller ID ahead of stream
> > >
> > > What's "MSI glue layer" ?
> >
> > It is common term for IC desgin, which connect IP's signal to platform with
> > some simple logic. Inside chip, when connect LUT output 6bit streamIDs
> > to MSI controller, there are 2bits hardcode controller ID information
> > append to 6 bits streamID.
> >
> >            Glue Layer
> >           <==========>
> > ┌─────┐                  ┌──────────┐
> > │ LUT │ 6bit stream ID   │          │
> > │     ┼─────────────────►│  MSI     │
> > └─────┘    2bit ctrl ID  │          │
> >             ┌───────────►│          │
> >             │            │          │
> >  00 PCIe0   │            │          │
> >  01 ENETC   │            │          │
> >  10 PCIe1   │            │          │
> >             │            └──────────┘
> >
> > >
> > > > +		 * ID, so mask this 2bits to get stream ID.
> > > > +		 * But IOMMU glue layer doesn't do that.
> > >
> > > and "IOMMU glue layer" ?
> >
> > See above.
> >
> > Frank
> >
> > >
> > > > +		 */
> > > > +		if (sid_i != (sid_m & IMX95_SID_MASK)) {
> > > > +			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	sid = sid_i;
> > >
> > > err_i could be != 0 here, I understand that the end result is
> > > fine given how the code is written but it is misleading.
> > >
> > > 	if (!err_i)
> > > 	else if (!err_m)
> >
> > Okay
> >
> > >
> > > > +	if (!err_m)
> > > > +		sid = sid_m & IMX95_SID_MASK;
> > > > +
> > > > +	return imx_pcie_add_lut(imx_pcie, rid, sid);
> > > > +}
> > > > +
> > > > +static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > > > +{
> > > > +	struct imx_pcie *imx_pcie;
> > > > +
> > > > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > > > +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> > > > +}
> > > > +
> > > >  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > > >  {
> > > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > @@ -946,6 +1122,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > > >  		}
> > > >  	}
> > > >
> > > > +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> > > > +		pp->bridge->enable_device = imx_pcie_enable_device;
> > > > +		pp->bridge->disable_device = imx_pcie_disable_device;
> > > > +	}
> > > > +
> > > >  	imx_pcie_assert_core_reset(imx_pcie);
> > > >
> > > >  	if (imx_pcie->drvdata->init_phy)
> > > > @@ -1330,6 +1511,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> > > >  	imx_pcie->pci = pci;
> > > >  	imx_pcie->drvdata = of_device_get_match_data(dev);
> > > >
> > > > +	mutex_init(&imx_pcie->lock);
> > > > +
> > > >  	/* Find the PHY if one is defined, only imx7d uses it */
> > > >  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> > > >  	if (np) {
> > > > @@ -1627,7 +1810,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > > >  	},
> > > >  	[IMX95] = {
> > > >  		.variant = IMX95,
> > > > -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> > > > +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> > > > +			 IMX_PCIE_FLAG_HAS_LUT,
> > > >  		.clk_names = imx8mq_clks,
> > > >  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> > > >  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> > > >
> > > > --
> > > > 2.34.1
> > > >

