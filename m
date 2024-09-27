Return-Path: <bpf+bounces-40418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B5988714
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43BF1C20B05
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1276012FB1B;
	Fri, 27 Sep 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D9j/MBAu"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2050.outbound.protection.outlook.com [40.107.103.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23E1339A4;
	Fri, 27 Sep 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447126; cv=fail; b=R5w3ZuwHWkIQw1woaSNkmQ5f+Bg5hSfb68jKPsIRoiTxJmuuPsyR1Wes1UoulZBHpdfGdRoCA97fv264Z2vhh3KCZRmaf2c318yvzPPokGMpPivB3o78V0TuEAExKP5dGLhETZ5KXcMJVZmbZ4rzA7rsIEaeb3h1MWfR5w1KaUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447126; c=relaxed/simple;
	bh=0muM12GrV+/T/Hb0Q4B9kSEgly+73ptVBIYLc7hejJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cORmLfcZ/qqlXMiy1ppMWXYkVkKrEstr21SbSKL109L2O+BWAUvcjFqtdVNFdwXqYxPxnrrxNYVPgWBj7SBUBz/UCn4OppQrZuEZyXmmpsDHHEF0PZgdpEdfDP8hms0E4UPoO1vzQ0Nykf6QEMUVme93Ny6nIjBqvXucOOdC1cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D9j/MBAu; arc=fail smtp.client-ip=40.107.103.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdtL7S4UGc514mcxI3c5MNYBnbhvhsph+Jri9rBVRWZ2InmdDetqOVDlmT9GO40ed/33feiy3pblBVgpKV8z3p0r4IIu7uY5Dqv7+2JCy/dL6XO+viZEfU/cRC+wZHejLhMAu6MAyjBq2vjXAPRKj1Cm3C5pY9ksZERfeA3TZ58ijG3SCGXfcXXtkkvarK0AQSvyPcyr9iqCulplFvgeHGOpPcy5J3KfWdPR4nxOoMFS/JFMF2FNgfk3Rc3eik4EjkYNG/seY11k6xORZetyagzX3+9w/TxYdZpyMvlR8E+ZxXrpk2gAKXR/JGVSflInbyilE3q054j8rue2NMLycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVINEDJqxgPHpLuCezfMkspdS+LTzVvereX/MeJ976c=;
 b=N/obidTYnN0u6Dl1QwWo6FZBKKSahsFtE7NcP+MXm5OLixPMluAvmHnrjrnGFXmrsEICsZQmg95MfRdEPlO4Rw9h9wa8Zm1Za94p6nWpm9e36vamD+WMvHhtGFfv4GKYGxGw4Yl4HC9Yv8HcqTEuP2WQt4+1EHDAXqZ1c5/03vrHQYU4SwS4xAwYyh58bgVH9DM08l3481juTPh6nWq7gesGbS63EMZjtnejpQs5no+9DGKCtTHahvev/Fv2HPe4YxwQpjKWYaPq9yUe6ia2/4M21w9eT7QE+3UBEMbBPQLdG1SQ62PwpQbj8WcUU8x5awlryQ7HZEwUD+E995FlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVINEDJqxgPHpLuCezfMkspdS+LTzVvereX/MeJ976c=;
 b=D9j/MBAu+AIW1c3YuA69O5hzSSrJnrsrDAxU8/5uIdqIihF4Mj5cvuzWF2djaikq4+yeQ8h/lu1QGmardbsnT2vr6S2rxzshZm98++ZCFPlhh+pL1damMqi3U0SegkNMRKk5GXgQ4sQbz6Fc/GVbvzusL0/kHJ55taK0Z7gFpnzKUc2k+TyDE6icc9qcRReQb5x5LvtoviKIHW1rfhaHRk9CR+5k51iI89SoJbPOsy+IrFaFh6SBRYQA3XXG4m5covCE8XkmKYFlYoj1oAFu37oFygbUfIMTrUrS6x7I/nGJzKWPKdVhnTYYvu+L/TS6ylE5iGPZet8RqwYFDuw6Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB7171.eurprd04.prod.outlook.com (2603:10a6:208:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 14:25:21 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 14:25:21 +0000
Date: Fri, 27 Sep 2024 17:25:18 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net 1/3] net: enetc: remove xdp_drops statistic from
 enetc_xdp_drop()
Message-ID: <20240927142518.gh3uhq5qvlhh2fta@skbuf>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-2-wei.fang@nxp.com>
 <20240923050230.GB3287263@maili.marvell.com>
 <PAXPR04MB8510259090731BFCABFDD47F886F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB8510259090731BFCABFDD47F886F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BE0P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf5c616-32b2-4a3f-ad6e-08dcdf0037f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG1KbDlMeDE3dExrVjdURFZGbmhZd24wYkV3ZU9zRCtrVmEreGVlUTdSeVQ0?=
 =?utf-8?B?NE43NVlBMnNibWZ0ZTBDZ3RaWHp4MjRuS3pHQnZpUVpPOVVmM25UU0pGMGVs?=
 =?utf-8?B?czZ1TmczL29NUEJzT29RSThvU3NwSHBWTGhNclBiM0dUZ3M2TDNZaDdpYTFM?=
 =?utf-8?B?VmJGSUxUT04vU2hOMXVyYnhIQ3lXUnhnaUJrSHoxdFcxN2hTbVpEbEFvTjlO?=
 =?utf-8?B?amFJUS85YThWbWMzbmJ6dE4rSE9xM0MyeFhuRUpEdXBzbkNtQXhnZlE5dkxO?=
 =?utf-8?B?TzYyQnQ5YUl5WWZnS1l6YldWQXMzNGROTkJuM29hUmxtQVZqczRnZ0hGTEhD?=
 =?utf-8?B?QzlMeTRkbW1rQUlpQjZ0eWc5ZkhoNUZPQ3hrZkxwM3cyOFRvcGpQR0IrTGpa?=
 =?utf-8?B?UHdRcmp1Vnc3dW8reGxsZzJnNkF1M1BMdFRqTGIydm11TlduL1RnRXpQdld1?=
 =?utf-8?B?bmo2V2VqUjlHd09ReXNUdDZ2V3dzK1dqUDhPaWZOQit3TUFIRzREaHhLT1Rh?=
 =?utf-8?B?ZkZGL0RXc1VKWnZUTms0V1o0WnlwN0xaZUFMVGNQVGM0REFlNk4rZmUwWjJh?=
 =?utf-8?B?dlVhU1ZkZnMzV0szcjFiNWNYK0ZLRFBIWFpwcnpSUlM5VGQyMnVmakRQWStj?=
 =?utf-8?B?a1AwUVk3M2pCL2srZE0xcHZzd1pvUDUzMXkwUnFJQW1EODFLRVBZaUFQRjlN?=
 =?utf-8?B?SnR4UWlzTHp1eWFKWUpHV1pPYVFxaGhBK2xyT3BFa1IwdUR0aHZCb1VFU2Na?=
 =?utf-8?B?dDlLQWZxQmlnV1Z0SUJTYk13U3pOZjJhSXl6a1FlMDJEbW5oTkhMRndSdUM3?=
 =?utf-8?B?MGtDNGJlYlJiV2U0SE9Tb21IakZZaHVQZmZ0MWFlOHFFTk5GZWtaaWNHSDk5?=
 =?utf-8?B?QS96Tjg4WHdyeUl5T1oybEJ2MU5Pc1JLS1NBR2FkNHAwQ1ZzUzJBb1E3UUZR?=
 =?utf-8?B?cFdZS0lmWFR0VHlKN1hTSVNvRExrbmtPRmdFSUNMWmw1WmNmRTVJN0g2eE50?=
 =?utf-8?B?U0VuaTVZeHJ4QVJwSUI1Mlh3dWNjeEEwa05acUhDT3A5TFBWRHE2VTdCZFdi?=
 =?utf-8?B?MXZIbFNTV3dpZnphTmhacExuMU9JYlVscVBDTWEzWWc4aWZGaU5CaWkzWTFa?=
 =?utf-8?B?TFdLVzNlMlJuNytrWUtUK3EvN0hQNElpSG5wMjRwRVdJMVZIcFNxTlZTQ3NG?=
 =?utf-8?B?eVl4Z0psZW1kVXRoTkFENjdmTHJDOUY3UUZSN0oza2FXSSsyakcyeFJzS0xX?=
 =?utf-8?B?U05nRmlDdlowWHhYZXYzZHcwYitrazNLTjdwTFFhTGVnQjBzK2I1QmVHMElo?=
 =?utf-8?B?bm9YTjRROVVmSUthVTZ5WHl0djVqVVh5cVFVTUpzTHpGM2p3b2oyV0JGenpV?=
 =?utf-8?B?dExmbGV0aDg2NU1zSTAxVUtZWmYwZWZPVDNyRnlaNUNtWi9OOERGQW5aYmlo?=
 =?utf-8?B?WEo0Z3I2NTBadVg2a082aWFCRkxxYVBSTUlvNFljbWcrMUZENVU2SXdJb01K?=
 =?utf-8?B?clpka3kzRnBURUxiUmVvaXBWQUZDV3ppaENFSENTSjhwRjlKakpDVjhCY2x2?=
 =?utf-8?B?Tm1SUEJnSE5hcTdZbnVzY09tQUJodnFwMWxONFoybm5DUVJ3OVA1OEtRQkdJ?=
 =?utf-8?B?OGJlakhIbXhBSjJLWERkcHZVdTJIdGp6Y2VNc3hWTTk2bGw3RU1hYkFFTWtS?=
 =?utf-8?B?TnB5L0JzMy9zdjc4WGU5YUQ1WHNWSlp0cUVWTUI4bTV1MFR3Nk4yMU5yUVNO?=
 =?utf-8?B?eGVOeG5PQndkRkxJTjlZc0trRHUvL3ZIYUVKNnNmR1BQbWFOY2J6b0cvdlJQ?=
 =?utf-8?B?Y05kT1MxWVNZWVYzQnUzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEZlYkg5WTd1Y1drSkRSMDdROWhLRm5xWGZZUnVacG8yeHk4Z3Q4T1V5cVJ2?=
 =?utf-8?B?anNabFNBSTNjN1Z1M0k2am1Qdm5LVG9aR0dVWmVnNHJRWDJjNW1Da3VyM0dh?=
 =?utf-8?B?bnYxOFcrdEZOQWVxT09CMDdIcS9aK29VVmkrQlNBbjJ4YlYwcUt2MHk0SW8z?=
 =?utf-8?B?YkxVaTVmRk9jeFcrSmVTd3Z5bWpQVHd4dEpIcGpjSFRYMzZSaFdGQ0NPRnRY?=
 =?utf-8?B?d09abTEzeG44UVZzdC9iYld1K0JJaGhMNS9hN1kwZzJjNThwSWpkNGphanVn?=
 =?utf-8?B?dmhMNjN4QzlGcEdvVWxEd1grUFpnQVdESmRwMUJUM25kenBMdUpLVFl6RUZL?=
 =?utf-8?B?d3lNWlJZdDR6RmhyMUVYNHM2NERoaFpWcnF3SjZvSmdkRTlUL3RsdWpSdmo5?=
 =?utf-8?B?dktuRUl4aW5kalVoU2lGei81K1h2M0NkVmh2TURMNDJEMGtNM2dxNVB5Zm44?=
 =?utf-8?B?Sm1pWk1nVjhKM1d6MGlGRTVPUkFGRVBKa1VGMHVrU1R2My9XU21SRFVRK2Nk?=
 =?utf-8?B?UGJpZSthUWtBeFBaK29IWnpWZEduTE1NZFZjWGtIWkZKZ0FhTWNIbXhKUm5P?=
 =?utf-8?B?Z2MvVzFnOEszWW9TMVQzRGEzZUhKK2FERDVoaENtZVFkL0FJUm95dGwxaUo4?=
 =?utf-8?B?RW1xbkcrMHhTSmluRDBRR2pOQXBFVFpLaVN3cjJyU21vRlZoQ3RpdDVUSlRz?=
 =?utf-8?B?LzkrVnlncU85WUYyWFY3TTNKWlZQTWhuU3dNMUZFT3ZjeXMrSzVHMTdFS2dW?=
 =?utf-8?B?OVcrVUQ0bFJMMXpjc2wyQ2J3SDI4Zkh5UnVVMzVEN0JmeUpPZFIydnhaVE5N?=
 =?utf-8?B?bHdQNytOcFVNUEh6OU5YU0xCcFFhV3ZQWGRSZFB3aWQrakxKa2JnTm80MDBO?=
 =?utf-8?B?dEZjeDNxd0tGUUpxelVKY2ZRd3hRYTJqSGhDeHFmMVBvZ0NkSElTMndaUEIv?=
 =?utf-8?B?MnpxbGZxZElhSWlmRlcwTWJkRXFHS0QrY1p3UEpLUlRjbDR1bGpEQjkrSEhK?=
 =?utf-8?B?cWhZWXdEV2tNZ2ZkYUFHZ2JVOGNVeHFoYTU3ZzRsWUxyL1ZFSmZnc2ZVcUdv?=
 =?utf-8?B?NFkxdEpDRUlJTGNaUVkvUzcxbE5waHJaMEdKZG01c21tVmtFNzZWMzFmQzdk?=
 =?utf-8?B?ZE91YWVoMnlJamdTZUZJSVlUV2xLKzJSRmY3VDdSWmYrTzdsRkdmcmFUcTM1?=
 =?utf-8?B?bnRoYkVDclNDam1zTkpjV0JCdk5yZXpvNm5TeWw3VVlZSnQ4VnBZNEI1N00v?=
 =?utf-8?B?Y2psdy94VHFjMzdHRlJEeTBsSkREUzlTckZuRDhubko0bHZFVS84YW9JZDIw?=
 =?utf-8?B?VnVTWU9tT2N2Qmdrc252TXdTK2pUS2U0TXdzM3dSTDVoTElqeklONFNVMkRx?=
 =?utf-8?B?V2dNbFBlVXVyN1M5eE0vbkg0cnNnS004RXJnNy95dXdWU1Vra3FxTHdYYVRl?=
 =?utf-8?B?aTNqRzAxS0piSUdvWStEZmh4UEV4S2NqN0tDUFJRR2FmeXZ5cVpOU2E0OVlt?=
 =?utf-8?B?SzdNelAyV2phaEppT01FWUc0WlZ1SENPY3RNU3h1VmNQWmNtM1pOdFY0TDZC?=
 =?utf-8?B?eUxNdktwWTVjTHpwZkJJZnJQSGJhZ284N0pKYmFLYkNZbkh2RFUxdUVaa2RB?=
 =?utf-8?B?dmt2cDJaKzMzZlJzNHJVd1hBSmFNcy9lcEViTU1OaStyMjBicjByVm9pUnJV?=
 =?utf-8?B?S1dKL2tGTWhoWjI1SDZZU0NwTWFJbU1JREhremN6RG9sQ3NFTkFsc2lzTG03?=
 =?utf-8?B?KzhsS1AybGdCRCtLZVU3K2ZmWmhlNlNZMFFnMFR5U0huUXNPWHl4K09zbFFM?=
 =?utf-8?B?bkxuMnIxYWF5S05RVzVuRGQ4a2dlWVRkVWp1bWVidy9UV1RkQ0tLb2l0SjhX?=
 =?utf-8?B?a2dUSkprZkpYWVVIb1JpUmxZbnZSMDBLNEFFcFljRGc5UGpaZFJack53Wlkr?=
 =?utf-8?B?TUVoY3VXYVFPSWo1T0Frc1lqSzhNZ0F0Q0Y0Q3dLU1FHcDhLY0tOWHJqWnBs?=
 =?utf-8?B?Q0hOa3VZTWNSbDROVHRNZGc2WDRlSmdaNWx0TlhWMktLN0NIVjgwRnNzT0dm?=
 =?utf-8?B?T0NvRU9FaXJmdk5SMmtWczRYMWlRYzc4a3JzWHRzTWVpMmJLWU55ZUpBUngw?=
 =?utf-8?B?Y0FCWmp0Y2ZNcmlzS1R5Wlg3cG1SWkdoOHl1ay83cTRXRkVqSlgvRXl4a0Rx?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf5c616-32b2-4a3f-ad6e-08dcdf0037f1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:25:21.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9Xneqq7X2BiNjVNB2fp+jppKB95gnZ5Lqkg99UAqicWf6tkzqY8sLdqrhooZyQ0ghXcV2m9GHbeTbvowCTezg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7171

On Mon, Sep 23, 2024 at 08:53:07AM +0300, Wei Fang wrote:
> > -----Original Message-----
> > From: Ratheesh Kannoth <rkannoth@marvell.com>
> > Sent: 2024年9月23日 13:03
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir
> > Oltean <vladimir.oltean@nxp.com>; ast@kernel.org; daniel@iogearbox.net;
> > hawk@kernel.org; john.fastabend@gmail.com; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; bpf@vger.kernel.org; stable@vger.kernel.org;
> > imx@lists.linux.dev
> > Subject: Re: [PATCH net 1/3] net: enetc: remove xdp_drops statistic from
> > enetc_xdp_drop()
> > 
> > On 2024-09-19 at 14:11:02, Wei Fang (wei.fang@nxp.com) wrote:
> > > The xdp_drops statistic indicates the number of XDP frames dropped in
> > > the Rx direction. However, enetc_xdp_drop() is also used in XDP_TX and
> > > XDP_REDIRECT actions. If frame loss occurs in these two actions, the
> > > frames loss count should not be included in xdp_drops, because there
> > > are already xdp_tx_drops and xdp_redirect_failures to count the frame
> > > loss of these two actions, so it's better to remove xdp_drops statistic
> > > from enetc_xdp_drop() and increase xdp_drops in XDP_DROP action.
> > nit: s/xdp_drops/xdp_rx_drops would be appropriate as you have
> > xdp_tx_drops and
> > xdp_redirect_failures.
> 
> Sorry, I don't quite understand what you mean.

I don't understand what he means either. I guess he didn't realize you
aren't proposing any new name, just working with existing concepts in
the driver. Anyway, an ack about this from Ratheesh would be great, to
not leave us hanging.

