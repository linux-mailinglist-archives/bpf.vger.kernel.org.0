Return-Path: <bpf+bounces-52176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609F4A3F798
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 15:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578947ACF84
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67C20FABA;
	Fri, 21 Feb 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f16VgNVf"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012039.outbound.protection.outlook.com [52.101.71.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56420D51D;
	Fri, 21 Feb 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149054; cv=fail; b=HXzFRi7G64jcvVKr2QdPRma9F2LKtJeG8+aiRStAxDAKwv+XvoH4MHQM81Kmq7lqwqquPcFmA6AQUEAGaZAqPcFAPcqSjGWVAm6jZ1r42ZCwcHWPUXqP2rc7F3Kb5Tgb1F27lHlCPO262MhEJgVHUP08VAOBJ2Lqkw5fYfX06GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149054; c=relaxed/simple;
	bh=QUOmGJCYKy4+lw+nQlK9gA4pw3EJGp8VcWK/MuxWEno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oJT8CTOcfYbSSR1k1umTpNLQqfnxGCMYzSyZ4/DmEksB1nbG5Yln9ARcaCZ8L8Gwj3xC8RzIrFU5cOqrgDuxQgi6C2JbaWzFZV2wJ6xS01HiceqOe/prusetObxMasaLQjNbXqpbwdisyxBA6jvrygHnIhO8gQjTUXfcEeKp1yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f16VgNVf; arc=fail smtp.client-ip=52.101.71.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tha6mF0ZHn2gd46Z/1sha0NAQ+3otA9/nJpDUw5VAk3U9Q/z5NuhNoJmgmLnkYHu1cch03cD81dpmZVnLZoxfEAFHSsxhxC8srZmvKSzZtKCDaHtvdWKVwRbDgyrbIkNUHx5vYmHduE2KZ9pqFuEByKz4HPC4s9FC8r2AgkHpjcXm4tMtGoV4doHmBKoRbMYndQkmS0MnLHSLtDjwFSX172y1JIlj604Ss1XT02VDX6djpYEfw6r3kvwFEotjy8iyr8rEWpmkmzLWhywcJxd+czY4yWJujvcWOHXdRzcg3Vvef4B5Vy5+x+/hvEgRPiLpSoyJ1cI/d7VHOe7K8yGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1wt5CznjtGFJJIe7h1HZUXT71bcvhI8vV2Y3DhG2V8=;
 b=c9dPIzqboXpIJ/THYJNEOKN5yVW1lt1GHIepLiFqOy49R3JS5GHKf4UeAFHrMMgQr9IE3LZSEn8kteXBeMjFIHRDv/39zBRjwzkKc0kumPohkQADogff8N2JOVO2j1Q8bzQJv7CVyxRqsYZfXeXXRUTzcZtcBjXI/6rrFuOEi4EVrNNR9UI8kjLasSSesqwBNK4YqwuopbzgR6W7rNPi6eVSVwm+hyFAh+n0CIeazNwxh6BkCELirwiJLlpPByOkss3znoBjRgDY4eXchGefjGMwI3Asd4zInLAMPRVnERP9VQR6rVYojCJ45DjWLwrb9Hv0jSor+qQM14GEzw+MTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1wt5CznjtGFJJIe7h1HZUXT71bcvhI8vV2Y3DhG2V8=;
 b=f16VgNVfD+xQGUpKoAznsRfopL5qrIDi99zKXcABY3KIWEvAVPdgxicAwOx1p7IX+BgHCgfqi5zXhab3Mf5Gaaprf7Wyl7++OIhm3aN7pcsWGBrXnfV7c41yLyLul8YiWCkjiOL4w1BIMGB7MHBUCZByKoXrafZSN0Eu+Pphw5ucIA6J72kl+biAEKgPrAhjrX4j9qKiiv+HdNE3Z1z68mtH1fDn2Ghx/kl9gnVHbRVYmkHttXjJI1WFiCPpAk9sNcuOZITLKEhWxosZYwFtfnTHci049LHC/2Tmsf51YbshM0yvzQM6mLYk8ARiCW0/a4S2BKl01BOWKz3B1yMBZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8131.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 14:44:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 14:44:06 +0000
Date: Fri, 21 Feb 2025 16:44:02 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: Furong Xu <0x1207@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 1/9] net: ethtool: mm: extract stmmac
 verification logic into common library
Message-ID: <20250221144402.6nuuosfjmo5tqgmj@skbuf>
References: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
 <20250220025349.3007793-2-faizal.abdul.rahim@linux.intel.com>
 <20250221174249.000000cc@gmail.com>
 <20250221095651.npjpkoy2y6nehusy@skbuf>
 <20250221182409.00006fd1@gmail.com>
 <20250221104333.6s7nvn2wwco3axr3@skbuf>
 <3fbe3955-48b8-449d-93ff-2699a7efcd8d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fbe3955-48b8-449d-93ff-2699a7efcd8d@linux.intel.com>
X-ClientProxiedBy: VI1PR09CA0125.eurprd09.prod.outlook.com
 (2603:10a6:803:78::48) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb93053-253e-444b-149b-08dd5286318b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGJiMTZPK1pvbk43LzlsdS9sV25QMlBsOUpwZWdTOEl1YnpIaDJpTjIrV203?=
 =?utf-8?B?L0k0RitXeDhaejFaSm00Z2Zib1hXdWZTNVBJZVdCdXFTVXQ1bnduanhxckNS?=
 =?utf-8?B?UWhVbjhRZEZ0ZHRnUDdTcGhsS2p1bnA1alZFajdTTDJxN082VlQxUm5xQjd4?=
 =?utf-8?B?ZytINnV2STFhTzhPZm9BTEhaOWh4VE9zQVIrdFloOWg1L0QzSXN5dTdhSkFn?=
 =?utf-8?B?Um5veGJUNUF1SFlLV2xtR0FNVkwxNlBWN09YZkVyWXdnYXBiZlFnaG9tNnNq?=
 =?utf-8?B?T3RoOE45dGp3OGtuT3p4bkZLSUJaczVHSktaODNod1Bmc2FMSjRVTEJmb2RE?=
 =?utf-8?B?UDVmUUtPYnlvcS9DTU1NMmdKWmVKRTRRemlQTHdDUUlUamNJSnpFYjlsWlRU?=
 =?utf-8?B?UC9PNUFrRkxHTW00QytGRGEvRkJFNWN5T2VCSnR3b2RPSEE5Y2RaeENFSzIy?=
 =?utf-8?B?cU5LVy9lRlp3VVBVMmJrVFJhUERrcHBjd0RxSVJTMVlNeEZrR1lndkpmNG9q?=
 =?utf-8?B?NklOUkN3QldDS2V6Rk5pNTZkQ3RlTUpFNDNBNEQ3dXVRclQ5RXhnK2NRWUsv?=
 =?utf-8?B?YnBTUE9ZM0oyRy8wNmhqZk5sclFJK3RHdjJ3MHRMeExwbkJLYkZaZmhrYmpt?=
 =?utf-8?B?RjdONGxJYTZaZjBMK2kzbjhBRXNQS2cvb2EwdWxFZHJESjBWSWZ2VmJJM25Q?=
 =?utf-8?B?K1ExdlNkQnFtZS9RUGpjNFBqbk1GanhZQ2M4YlBxN1Z6a09SZDRqSjVzdlB4?=
 =?utf-8?B?U1haMmMyV0VtRTg4bGFDRnVYbi8wTk9XeDBSNlV3VXM4czBWVmEzUTZ2MDhk?=
 =?utf-8?B?QTZLZ2ZwYnk4aysvQ1lralVFdFlqTHY5Q1ZoeG9jTkpXZ2hoT0h5Mko0UStu?=
 =?utf-8?B?Y3FrVWNuZ081Rm53Zk04bDIzSXlOWERsdnlVaENqbWMvQVFZMDF6aU51NHE4?=
 =?utf-8?B?SUNPVy9ET2hyM2xJTDJnekd5YytEdTFZeFRId1pkeWdqNlp3OHpDSXoyaXF4?=
 =?utf-8?B?WUY5RTY2VTZIaVBzWVlSczhhNFZjcGIzU0hYTXlrK2MyeE1uaC9DQlZUUi9o?=
 =?utf-8?B?ajRpaHVsay85Z3o3dlNkUjF1amp1R2VHS2lQNXlNR25LeEx5Ujl1TDJFRHVx?=
 =?utf-8?B?Y0Rzd0NnTVlGcjdJZlZIRWRGbmRRZ2g5SGxHdWV5OHhPYWFPb1BnTHcwZDRa?=
 =?utf-8?B?NUE3Y2VOdVo1b0RuZ0tXclpkQXhMbnlud2FvVm5aWjZTK3dDajZJbzNJeVVi?=
 =?utf-8?B?OUZYa0NhNE9NU3p5UC9LdVJzUVRFK0xxRkxLNlUvSVJpUERDQlBqRFRaeTdD?=
 =?utf-8?B?VHcxZ3AyWWNTd3J2cnFKRnVjbTUrcWtqdDJCSVRUcSsrUFJnMncxRGt5SFdz?=
 =?utf-8?B?L0JXUCtHUEdPYm8rM3JyMnEvOTJFUm83VkxjVVdJdzA5MFhycFcrTUZZdTFt?=
 =?utf-8?B?QURsRFJiOE1Gd2Z2RGhaRVJoTUtmSzJ0TnhBSk1waFQ1bjNtRFZ1QXo4MjBK?=
 =?utf-8?B?dFlyQWEwY0R1YVVtU00rWVBkUDAwdERLM2lWYzViMHg1QzVIYUxFWjZFNFNy?=
 =?utf-8?B?NzVUQVg4ekVMTEpMM3Q4ZzRkS21nYXRlblVvdlloMkIzRzkxdksrVFBiWlFp?=
 =?utf-8?B?VTVTMGxxRXVld3I5TUNXS0NTMGZnYStUcVJPcC92clF3a0tWUU8weGVyemxa?=
 =?utf-8?B?Z2wveEEzQ25xejZpV2s5NWV0cTBuTlFocHdCYzRBV09HZ3JRNmdHOHBzRW45?=
 =?utf-8?B?VWhjN1dmN1pSY1lEdFk0T3FZb1o2K1V2NEt2OW9XcDgxVVFUTWVJQzFFOVk3?=
 =?utf-8?B?UGJQUW1Mc1NZRDJQWHd3ZlBycVViU010enRBNlU2cGw2S0Nqc3Q2OTNyRmp5?=
 =?utf-8?Q?DEi7ZC7AuKuTc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajhtK0lORm4rM2hBTlJwRmlvaGVqcnpYYXBxSWg4SmFkL0ZWRVkrMVNxdThJ?=
 =?utf-8?B?a1lOQzVKUEE5elJMRFhrNG9wNlRGejZNSi81MGVwcGJBQWwyZ3FwQ0VQbXFY?=
 =?utf-8?B?Y212dTA4TGFyRTRhLytZUDJmVU1tNFh5c3RvN1NkemNmSnduaG14Ykp4YUlZ?=
 =?utf-8?B?aWd6cnl1MHVtZmJlS05QMlFrcDA2Rm4wUWcvSTkrZmNNU3lEL0QvLzl0c3lE?=
 =?utf-8?B?THFEaVVvdE9oODF2Tm9ZWTNFMzdtYWQ5NjBOb2UwTE5FMHdRcWRleDNYaXFo?=
 =?utf-8?B?dUZaNjVvUWRBazhCd3h6d2FOUU93aHFWc1hWb3lDdVI2MEFjZkwrcWQzUzl2?=
 =?utf-8?B?blhveDVxRWp1WXBocmdBTkx6UnV0b1ZMWk5vQy9kRjVWUzBSaU5RNk9hejNX?=
 =?utf-8?B?QVA1d3dSQllBT2xGdlVtbHdmSSt6NDdlODBnL05sMXR4T3RQdWxBWnRXY2Zw?=
 =?utf-8?B?WGc5NExFTXlESkhIa2lDUUxQbkM2cE4xVFEvWkMwRlkzMldlRnRISy9pQ01s?=
 =?utf-8?B?dHkyaUVNaE5pZzJtVm5mL0NLWk5TczJ6Z0thc2Vsc3daUkp3TDZicDF6R0VK?=
 =?utf-8?B?NGozQTNrbmVFdCtKdzR1eWowZUp0RUd0Wmh0SklnakFzbWZqSjNUdEVBZHFB?=
 =?utf-8?B?OWU0amV3RTFZZ2pqYWZYYzhrSDJjNVZEWDFSKzBLTTdwaGtjSUFXeUQyOW5o?=
 =?utf-8?B?RmEwamowdHNKbjdzdWhGYkVTd0NhTjdjQ055M0ZRSTlnR2NORURZVmxGSWU1?=
 =?utf-8?B?RDNjdHNVZkhlanI5TnJuekRJNVVCTjhtWXZUcjFqWlp6SXMzWFQrS0dnQVJ0?=
 =?utf-8?B?c3RkYjlPOXVmbEhQRWRwVHBKYStweTEzRWFScVVwK3ZIeFhHZi9rR2tFUGZZ?=
 =?utf-8?B?SDlrT2JxS3A2enNBTk0ySTZDSFkvdGlvanEveU9ReEsrbk1jWUxRZGpRM2kx?=
 =?utf-8?B?emgrK1VSMk5ZNTJ0c0hFaVVFRFRkL3JBdWkxT0l0UXdGb2toQnA1SzMwZlJo?=
 =?utf-8?B?clU2TU5pdWJJdUpSNHlmTlFldFpScnlxcTFUTmQ1cWJJTys3VU55OUpjbk54?=
 =?utf-8?B?R0xpazNCbVV5NlprdmZJWk1LSXBoM0U4T0JvUG1LVWJMbTcwb0JoUFc2UUhM?=
 =?utf-8?B?c0FySUJOM0U1ZWlyQWhqemEyYXFXSFN4TmZRaGhzcUx6K09PM2hjeGt1M0dV?=
 =?utf-8?B?S1M5WDJzakpQc0V0TVh1OTBhWjZvUnhMZFI3WlNQWjFucHNKWVdVYmdzMVZL?=
 =?utf-8?B?SkR3MFlkeGIzMUg3SUdNc01KTkdzcTlmT2ZvMXBHRWs3RHovZk90S1pWa2Q2?=
 =?utf-8?B?VksyaHpLV3RMQ2k5NEpVUW1xbWlFQnpIOURZeTNqZWZXVDRhendkMW1FSk15?=
 =?utf-8?B?dXJDR3NRUHV2c0tsd1hLWkRKMk5WWjBKQVlBQ3ZVTWZrSStRWmU1MGxuWFMr?=
 =?utf-8?B?RGV5UVJzemFMVGx5QXBWb1p2Qmg3OHdrTzB3OHgyc1ZWcHkxc243cmo4Z1lG?=
 =?utf-8?B?eFVCZGNsWUtoaFg4dGlpT1paZVNXc0M5M0p3WDlUcXBscnZCL1JqYzlZTTRD?=
 =?utf-8?B?dHl1Z3BveXF1cEtHZWdJV2hUZnZDQWtBeUNyN0pNbVJmUTFSUTJVUU1FQlE4?=
 =?utf-8?B?M09vSjFzcUxqcHY0REN3SGh3WS96Y3Bnd2k0RFZCOC8yZ0QwRW5oa3BvY1Zh?=
 =?utf-8?B?bnpaUFdMZ05yUHUydTBkbFJVOE1CR2tKd3ZHeUhFTzBuVFlFb1ZLb3Naalow?=
 =?utf-8?B?ZGV6VlJnOGpjOVppV1hwS3k5MC9vTkg3a1F1aC9TRnhlNEhnbEZRbEZjUmxw?=
 =?utf-8?B?NHl6TU1JcFhkaTJabG4yNDcxVmtWeTROZFN4Z3VoTnpCeHZiZjNWM2lMR1JI?=
 =?utf-8?B?Z3czUTNuR3hVQVljcElYai9xZG5yWVd5NWdlb2VJakZma1BMMlFiK3BDc3lR?=
 =?utf-8?B?STJLdjJySTdhV1JIOUNLdVUrY3gwMU1hYlo2VEJ0WmtFSFh2NlFGNnovUnhS?=
 =?utf-8?B?TmZvbEV1YlJaSFprU2FTU2VRTUFVWVJ2bGhlcHpvRWt1V0ZxRTFHcndWaUdU?=
 =?utf-8?B?L3R1am9xZ3JMcm1Ea0NnbmgzY3FPcjZQcjJ1TTBFNk1IS1g1SXBPam5kcmV3?=
 =?utf-8?B?RzBwU2U4UmhEMXEzTmxsckVQMkpZOUNiL0RpbkU3MXBKeHhkMG5vYXJGS1Aw?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb93053-253e-444b-149b-08dd5286318b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:44:06.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9N1nqXkKTmBiljBqDfFZbzVL5py1s4vje9KsdZr1kHnJCGtzYWxhq/zx92M+P4UZVBc99B5ZgEY5A7xd2lG6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8131

On Fri, Feb 21, 2025 at 09:30:09PM +0800, Abdul Rahim, Faizal wrote:
> On 21/2/2025 6:43 pm, Vladimir Oltean wrote:
> > On Fri, Feb 21, 2025 at 06:24:09PM +0800, Furong Xu wrote:
> > > Your fix is better when link is up/down, so I vote verify_enabled.
> > 
> > Hmmm... I thought this was a bug in stmmac that was carried over to
> > ethtool_mmsv, but it looks like it isn't.
> > 
> > In fact, looking at the original refactoring patch I had attached in
> > this email:
> > https://lore.kernel.org/netdev/20241217002254.lyakuia32jbnva46@skbuf/
> > 
> > these 2 lines in ethtool_mmsv_link_state_handle() didn't exist at all.
> > 
> > 	} else {
> > > > > > 		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
> > > > > > 		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
> > 
> > 		/* No link or pMAC not enabled */
> > 		ethtool_mmsv_configure_pmac(mmsv, false);
> > 		ethtool_mmsv_configure_tx(mmsv, false);
> > 	}
> > 
> > Faizal, could you remind me why they were added? I don't see this
> > explained in change logs.
> > 
> 
> Hi Vladimir,
> 
> Yeah, it wasn’t there originally. I added that change because it failed the
> link down/link up test.
> After a successful verification, if the link partner goes down, the status
> still shows ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED, which isn’t correct—so
> that’s why I added it.
> 
> Sorry for not mentioning it earlier. I assumed you’d check the delta between
> the original patch and the upstream one, my bad, should have mentioned this
> logic change.
> 
> Should I update it to the latest suggestion?

Never, ever modify logic in the same commit as you are moving code.
I was wondering what's with the Co-developed-by: tags, but I had just
assumed fixups were made to code I had improperly moved because I
didn't have hardware to test. Always structure patches to be one single
logical change per patch, well justified and trivially correct.

I had assumed, in good faith, changes like this wouldn't sneak in, but I
guess thanks for letting me know I should check next time :)

I think it's a slightly open question which state should the verification
be in when the link fails, but in any case, your argument could be made
that the state of the previous verification should be lost.

If I look at figure 99-8 in the Verify state diagram, I see that
whenever the condition "begin || link_fail || disableVerify || !pEnable"
is true, we transition to the state INIT_VERIFICATION. From there, there
is a UCT (unconditional transition) to VERIFICATION_IDLE, and from there,
a transition to state SEND_VERIFY based on "pEnable && !disableVerify".
In principle what this is telling me is that as long as management
software doesn't set pEnable (tx_enable in Linux) to false, verification
would be attempted even with link down, and should eventually fail.

But the mmsv state machine does call ethtool_mmsv_configure_tx(mmsv, false),
and in that case, if I were to interpret the standard state machine very
strictly, it would remain blocked in state VERIFICATION_IDLE until a
link up (thus, we should report the state as "verifying").

But, to be honest, I think the existence of the VERIFICATION_IDLE state
doesn't make a lot of sense. The state machine should just transition on
"!link_fail && !disable_verify && pEnable" to SEND_VERIFY directly, and
from state WAIT_FOR_RESPONSE it should cycle back to SEND_VERIFY if the
verify timer expired but we still have retries, or to INIT_VERIFICATION
if link_fail, disableVerify or pEnable change. One more reason why I
believe the VERIFICATION_IDLE state is redundant and under-specified is
because it gives the user no chance to even _see_ the "initial" state
being reported ever, given the unconditional transition to VERIFICATION_IDLE.

So in that sense, I agree with your proposal, and in terms of code,
I would recommend just this:

 } else {
+	/* Reset the reported verification state while the link is down */
+	if (mmsv->verify_enabled)
+		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
 
 	/* No link or pMAC not enabled */
 	ethtool_mmsv_configure_pmac(mmsv, false);
 	ethtool_mmsv_configure_tx(mmsv, false);
 }

Because this is just for reporting to user space, resetting
"mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;" doesn't matter,
we'll do it on link up anyway.

Also note that there's no ternary operator like in the discussion with
Furong. If mmsv->verify_enabled is false, the mmsv->status should
already be DISABLED, no need for us to re-assign it.

