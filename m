Return-Path: <bpf+bounces-53433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D83A53F1B
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 01:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C9E3A5FF4
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 00:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E3BE567;
	Thu,  6 Mar 2025 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WMfNt+vS"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E892EAF6;
	Thu,  6 Mar 2025 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220914; cv=fail; b=H1cF0e4c+RGSWxwIc8M3uzK3DvGAV4C8VU12h5eTcvVVYflDViAWbwyjfx2o61/iB/gkjUUMb34iRp5J8EBuEWCaqbT4JD7VfNxSrIsBZHkPnwepTy1Ipspv5tGM0HQ2n8kSQx7Mnb14XOrpWWkSKxvb5M1Y+uqvENPMgxycc+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220914; c=relaxed/simple;
	bh=rWMXVX/2cKj89gkS9tHFyUKrFCSYUjreuSvBD+RD6zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=geL8iQZWrzfQbU30Z3edC4m0NIJUmx6w3uQYXpUW0VI43DI0Afg0nJyhsodkp13iTKPXgMZL5SaM8MP+GZ6lGA5Qd0Ih5KxekUMs9YJJFVpK/uvdR0+zGRhiPHdnXFIGStxpJ26jZZZF8c1InaPIGHCOzka3ZJaCUm1FulZmZ1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WMfNt+vS; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a130+0RzXCsIqAtvule7B8+oq5CFdMd7pdJU6iEaP+IvEpNEiXLY/90bM3pTzPeqmMSKqSwuXuBd60VvGbX+vQfl3/pAdlkDmTCCE9ILqeSdh/kHAheopvRR2ZkksQ8xneNIMCKDANcHulkEQO5Wmhc5MNcs2nTsYeayx47caQh7Cc3agXP42zn7IBmhz+kukP2odCIPV4d/Sth5Sl/+7j1NljnpGBNTuONT7dSUqYHcSkzbBs50mFu7UOavOh86y6AwJVgJ1R4iX55AJNgrRidq7FB30EaVeKiys4YvEePUjKU5weRl7ddpDQaGMXCSxO+v/SJ2dmo9ybfHvybgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyBPI7WgSnGKSJ5+6AV5y1KAsyM5ZY04dU1HCFQCCug=;
 b=F+CRrsAW4jLIbRJ/BNktptlqDPHPHtQQVoCJjyibiTTolo0TV2lPsZjbP6aclLlYcydoUKSYIKjWbT1XmkfNCkL6tLpscdxrCSCBL0LKFeKWB+ZK14cK8y1tFTiV5STL9Sv5gB+s1DtFGLivC2h8jizZEeM/DgntSkCY6KPJSvHDScDeAaKDCT7Pwu6BJFNvtN143wFn+FYpgKkugwsq4DrdEouSjcFxT7Pv6NJGtdsWXSvWLK9n9XUsA0MAL99VzFlDvHXPofU04tbndiD8QjmfGeZHZjrNJNOjhz3v117N6Wt4yDxi0wQbAf8vGSj12AVLM0KZDVonaie5FG95Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyBPI7WgSnGKSJ5+6AV5y1KAsyM5ZY04dU1HCFQCCug=;
 b=WMfNt+vSM9VPUy8uHuyNKNMHOCGWUwAd/sMg5Jo1Gzo65Tdg+Xu2FYrzkptHramDEFKltgR8jUPDmY3KyHdqIdarJbM9yDY1cndv8WToih2BUnupasIl28ClNhPqQws6Wn/0W3i3xkTomhICs4mB5qZhb3qYLyoF9TZPVpJ00sw+tFikrKJuSPSVshwUOzXU2Cs/P/0b0qmDJz0e+GNYi1gTjt09XnBKrEmOeObZHqs/fnCBtgGwvlSALwRXtSjlLo26SNegxwH/0TZnKgwpKrtDG6g55sj8aSNijrFr6sfHiskrFGloCA/feKc1pzZqig/NnwZg0kUKaKljbvHAqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 00:28:29 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 00:28:29 +0000
Date: Thu, 6 Mar 2025 02:28:25 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
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
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v8 07/11] igc: add support for frame preemption
 verification
Message-ID: <20250306002825.rva7wjsymmms7kbd@skbuf>
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-8-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305130026.642219-8-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: e58dbaa2-2030-4217-407d-08dd5c45d19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTJ4OEh3N2RUOXpqR1B1VzgxKzllcHJwNUVFVEp5L3FybHloQzFZRjNWWVJt?=
 =?utf-8?B?WFNyQ1lRRktkcEM5U0poc2I4RUsyQmxhaTYzMTRIRHh2cVdOR0tiRm9iK0tU?=
 =?utf-8?B?UWFsQWxHbTl0b1ZYNHRmWEl3Qi9vY1NiSUNFSFRRdFFPRWdzTFkxN3ZGdERZ?=
 =?utf-8?B?MDI1OGs1NGowS0N1c2hwVVpYWkJ1NWREYlFPdTdtS2gwdGNCSVloSjFWN1Ro?=
 =?utf-8?B?NTd3UitRaE45ZEVzMTFGN2JJTXo4eldQVUMwaDJ6VWtSNWxVazhlVkRpU1ZO?=
 =?utf-8?B?Qi9zV1ZUR2lhKytQLzNHM09mcVdZTi8vUmJNalpucmFLUU9xckdPUFE2SlUz?=
 =?utf-8?B?OWl1V2dYR1hnT3A1UitVMzNHdFJUSkMxaHVmbWFDSW1zc3dZVDBDK2MxdVhW?=
 =?utf-8?B?VlB6cTBZRFBkc1dnZTJjbU9zUGdMMXFZZjQ0SWtKcEpyWnRyNTJNaVpkZy9Y?=
 =?utf-8?B?d2hpTDRadlQrem1WWGpqdTVpMllmeFBCZGZUVmMybDhoeUxCRVpDN0hqNC9B?=
 =?utf-8?B?Q1pJa24xQmluWVhGVFdjZkV5RU1YS1ZqYTJaZ0ZVZmhDMnlGdEF4cUZVK2ta?=
 =?utf-8?B?NWd4eHYxOWxEWUg3UEVMYVRzb1J6UzZvSHRnYlVWSDQrZ25XdFdtQllEMmdJ?=
 =?utf-8?B?OTBycCtPS0tZU1Z3ajZ2Rk82eld4SEZ6YVdCVG5ic1Ywb1VqSGNhRkN1dDVX?=
 =?utf-8?B?YUZlbVNCdml3RVI0Vk9HUGVVWXZTSzV2Um9DOVBQeFliTlhkeUxWT1RVM1Yx?=
 =?utf-8?B?SFJFMFF5MTBZNzY0cm5JbHZhZFJnL3hmTjhVbDR6Rmsrc1FmV3M0Rm1PNzFQ?=
 =?utf-8?B?a2ZMdDgrd0dQenpZanEzTjh4N01xOVhCZk1ZcXBYZW1VWW1HaUc5TysyRHNu?=
 =?utf-8?B?L0lMYXpsSTgwL1JMWDkzYUgvbkxOMitReUFsalNWamFuTWY3SFZSaFRwN1Vy?=
 =?utf-8?B?akpNT3FLY2NWLzlvMVNpRSt5V1RjajRUL2pMbkpWUVhWSnVFRkVGdnd0dVJl?=
 =?utf-8?B?QmhxdjBFOXI1SVQzV2Y5clFZTE5taWs4K0kwUFJ6dTJZSW45MGJTMzJzdmhy?=
 =?utf-8?B?aVZScVRWTnNLbW5mQTFMcDduRmFPa0FWU05SakhkYnl6TGxiZFFrV0lOOG1I?=
 =?utf-8?B?aUlLUTAvN3p3azhUUk8wMEVRWks0ekd6UzNpeithWDU5SlhPeVhsRUxxQU8z?=
 =?utf-8?B?NmYyNkRxdkdjdEdOOEJEYlQxY0c2QVR5Y2JuRkFmRGRTWnVpTG56VjZpZVkv?=
 =?utf-8?B?UGxRU3B5K3QvRXlUSkVLOVVPVlFid3VwWTNrcTVOWlgrVm5NNFhEZkFLejRx?=
 =?utf-8?B?eTkvNEE0YnRKZjFsRzNFZ0NqV2hNdmEvQk1xVVpTVGhXMjNPVTQrRGEwaXdj?=
 =?utf-8?B?c0sxdmwxRHYvMXJvcEdWak83SGZ0Z1JXS1Q0VVNaSkRYM1JYUXBtSy9BQUov?=
 =?utf-8?B?MldpMlU4OGJxY0JWRnkzWmxOM3B6akxyRW83UEV2MkFYb3QyQ1lzZTk4N2I0?=
 =?utf-8?B?RU9QWU5nQzFSMXA2TjFWUTQrSHJxdmxjNEorYlRiUDg1VEJSR1NRV1lkZFRN?=
 =?utf-8?B?R3hvc3k3Rk9YUzFhUWVER3BHbVNmei9pZGZTMmdPTDgrMHBUKzZNbHJSTjVX?=
 =?utf-8?B?eDJIQzdxbGgyc29QVHNLRTRMbVg5TWtkSEl3QjZRUHBuRzNTQzAwOWoxeFJh?=
 =?utf-8?B?aldITmVzcTZKUDhBd080OWh6VzViYzE4OUp1N1VrU2dLelpKSDA0ZGpRTHBN?=
 =?utf-8?B?U2hRa2tUYm91LzBzbTdxK09FNWxram1qV2VZOFU0UnZJN2lDeTAyN0dDWno4?=
 =?utf-8?B?bHloOEVVVFYxNUt1NFBsKytneFRCU3h4MTBEMjFwd1JVYzRFV3FIY0VqQWpQ?=
 =?utf-8?Q?fAw2OgcfHhJdA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFBOWDFCdEcrUHl3Z3FGWG9EU1BxejB1NldRc3FUYnpEMXM3UXJoT2pxbDJt?=
 =?utf-8?B?R2xuS0tVTlhMc3dtT2tuZDc1QTk0Q0N3dWdpaUF4STJOL2tSNkN5enhYZjlr?=
 =?utf-8?B?WDFJVEt0eGlPNmloNVNRSmlNQ3JCbFg3ZFlBcG1tajh3SDR0aVJQS2IzbFQ4?=
 =?utf-8?B?YXRzS3FtNHlsbVVhRG5PT0M3ajk2VWoxNDVpaU1QMnZ3bW0wVWdlQUdtYm93?=
 =?utf-8?B?dERqWFo0U29ZU2ZSZFoyMEoyNmRnQ2F6alhLcm1wVHkza090cVNUQVhlYlRu?=
 =?utf-8?B?TnlzMDd0VUN3REw2YnpFNFpaMnJkcWwyUHowYWJEdmRiKy9ySGsxVkJxdGNF?=
 =?utf-8?B?WDZjalkxVkoyWlpMM1dPS0RnaVZuLzFVSE5BVmdCVjJ2N3FzYkQvL1VSQ3pN?=
 =?utf-8?B?dnJtVU9Ob0crQ3JaM2QwRlhCSXdUQmt5K0doTlNVSUNvNmY2azRaVWd5c3hN?=
 =?utf-8?B?QzBnZk5RVmd3UWVmb0p5WEhRU3JDbzN1SHROZyszN3FiUEU2SHNXY0gza3Fp?=
 =?utf-8?B?S2Q2UGcwMGNzaHF3WDYwbkdnb0dTTWN3NysySGpVNlJhdm9uRE00cDZocXhn?=
 =?utf-8?B?R21JdzB2MzlNMGg2ditBQ3ZVYW5hV280VDlTeHBYelJ0UHdzZ3hDTzdlM1k1?=
 =?utf-8?B?WkowaXNONzlqOHdsZDJLYmM0akJwcG5kNVpISzBybTFCbGRwakY2NGRrMG1w?=
 =?utf-8?B?a3ZJS3pwY3Y1aWJTdjkxVXVXdVQxeVY5b2Q1V3hrRUppRzZ0eGwvSHd3NVNL?=
 =?utf-8?B?Y0IxR0dOclZRRkV2bDVwRVEzZFlRWTY5Skg1MGthS1VYZ2UxTHRkakJRNUFW?=
 =?utf-8?B?cFpMWnpUaWZ3TEREaWpBWXJnc0hHRGtHdjRha25NMFM3bVRJRnplY25zOEcv?=
 =?utf-8?B?Q2JYdXVTQ3BuMWw5NGhUdkhXeG55dXFIS0dlejYrenBhY2ZNTStuNzdkc2hr?=
 =?utf-8?B?QXVTM3VtbWc2amdkQUxEUW5yc3B3SXpEMVVJNG8xd2Vab1pXQmNTOTJaVU05?=
 =?utf-8?B?dW5BdHl0UlcrbjV1akg5WVd5eGZuOVNCS01vLzU3MWpDZ2RQd2d5TlpzR2ho?=
 =?utf-8?B?Z1pzSFEyTGFRVWJWVmkwcWZ1NCtNazVvZmpjd0RCK0R2d0JqakJlK25acFJM?=
 =?utf-8?B?cXpWR2hSSzF1aVhPdmhlTGd6enRaTDFPRitZa1U0YXlUNUF4c0NiVVZPckk5?=
 =?utf-8?B?K01aWjJwZTJ4WEFFVjRjMkNTOXUwMDJ1MHdxY0RKeTFQQmxobDBJQW5PckJq?=
 =?utf-8?B?eVpKZWtaeDRvN0xWY0tZQU9QNXBzR1dVZzIzTjgwQnZhbTAxalQrakdyMVJW?=
 =?utf-8?B?ZUw5WXNITXdqNHNWdFNCSUpEWm8vSVd3TGxhQUFnMFk3ZE1LTlVRRHE1dG5a?=
 =?utf-8?B?RGN3VWo4dWZvaCttNXNoV3RsWnpkRVBxMmIwaVkvQnJaeWFENUxMeWdzaTVD?=
 =?utf-8?B?bi9vRTJBSGh6cEpNc09GazlPdm4xM2pnRW91WWlxbGpSQWZ1TitTSEhyMjRz?=
 =?utf-8?B?VWh2Z1R0V3dHdWZSWUYzdWd2dHNxZGtONVZGekFFbGJaL0FIdmtCYTFLdGtF?=
 =?utf-8?B?enlPRUFVc1JIejJhMWJnRS8yMWpJa2xCM0JhS2J1UStDK01JaTUzUzVjY29Z?=
 =?utf-8?B?aHJLeVgxVFdpSU9NYXAvQUxaY0F2Yzc4Uk5HcTRqM1JMVUhMaGxGQ2ErVFZR?=
 =?utf-8?B?V1hwVkdEekIxS21keG1wN3RFK2RzWWIzT0pJcXJtZ29tNy9sL1RCbzZpeFV3?=
 =?utf-8?B?UXM3Nkk5VUk1NUJpNmZreUNWQ3lySVFqTEU1TGs0UE5Da1JQRlZrN1pMRDFy?=
 =?utf-8?B?OFBwMG9FVVVRek04eW44Z3ZUeUdJVUVYYnlydHVOVkt2RE1UM3N4bGp3bEtM?=
 =?utf-8?B?TU93amxkK0tZWHhQUzVIYk52R001N0pXdFdxelZWeVdyK0VlQTdyQ09iRnc3?=
 =?utf-8?B?ajZucTR4WTRUUjNJWmNvWXNVcEJWY0hwcDA4cU5oVFBtWnczSk8wRHZIZDIy?=
 =?utf-8?B?SnBvUWI2M25UQXZjRkI0bEs0ekRXVDhML1cyNXZ5OXJubHdkSTFNb20zTW5W?=
 =?utf-8?B?N2NDaVBKYmdlTnh0LzlJdEtwaHU5eUFKZHp6YmwzTDBqaEozZ1FteVBMTUsv?=
 =?utf-8?B?VmJpZ1BLQ2RkTk51WDNJQ0tGMHMwcGhHTk1sUmU0ZGlFUkQ0TkRhR1IzcThv?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58dbaa2-2030-4217-407d-08dd5c45d19f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 00:28:29.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJw4GpRh/cKy+5TUGERl0JFtSclUdOG927mrXFRUbNNo7OE50q3CHUY823cn0VD2byX7BwM1Oy7jGnnCORhlew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946

On Wed, Mar 05, 2025 at 08:00:22AM -0500, Faizal Rahim wrote:
> b) configure_pmac() -> not used
>    - this callback dynamically controls pmac_enabled at runtime. For
>      example, mmsv calls configure_pmac() and disables pmac_enabled when
>      the link partner goes down, even if the user previously enabled it.
>      The intention is to save power but it is not feasible in igc
>      because it causes an endless adapter reset loop:
> 
>    1) Board A and Board B complete the verification handshake. Tx mode
>       register for both boards are in TSN mode.
>    2) Board B link goes down.
> 
>    On Board A:
>    3) mmsv calls configure_pmac() with pmac_enabled = false.
>    4) configure_pmac() in igc updates a new field based on pmac_enabled.
>       Driver uses this field in igc_tsn_new_flags() to indicate that the
>       user enabled/disabled FPE.
>    5) configure_pmac() in igc calls igc_tsn_offload_apply() to check
>       whether an adapter reset is needed. Calls existing logic in
>       igc_tsn_will_tx_mode_change() and igc_tsn_new_flags().
>    6) Since pmac_enabled is now disabled and no other TSN feature is
>       active, igc_tsn_will_tx_mode_change() evaluates to true because Tx
>       mode will switch from TSN to Legacy.
>    7) Driver resets the adapter.
>    8) Registers are set, and Tx mode switches to Legacy.
>    9) When link partner is up, steps 3–8 repeat, but this time with
>       pmac_enabled = true, reactivating TSN.
>       igc_tsn_will_tx_mode_change() evaluates to true again, since Tx
>       mode will switch from Legacy to TSN.
>   10) Driver resets the adapter.
>   11) Rest adapter completes, registers are set, and Tx mode switches to

s/Rest adapter/Adapter reset/

>       TSN.
> 
>   On Board B:
>   12) Adapter reset on Board A at step 10 causes it to detect its link
>       partner as down.
>   13) Repeats steps 3–8.
>   14) Once reset adapter on Board A is completed at step 11, it detects
>       its link partner as up.
>   15) Repeats steps 9–11.
> 
>    - this cycle repeats indefinitely. To avoid this issue, igc only uses
>      mmsv.pmac_enabled to track whether FPE is enabled or disabled.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Co-developed-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
> +static inline bool igc_fpe_is_pmac_enabled(struct igc_adapter *adapter)
> +{
> +	return static_branch_unlikely(&igc_fpe_enabled) &&
> +	       adapter->fpe.mmsv.pmac_enabled;
> +}
> +
> +static inline bool igc_fpe_is_verify_or_response(union igc_adv_rx_desc *rx_desc,
> +						 unsigned int size, void *pktbuf)
> +{
> +	u32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
> +	static const u8 zero_payload[SMD_FRAME_SIZE] = {0};
> +	int smd;
> +
> +	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
> +
> +	return (smd == IGC_RXD_STAT_SMD_TYPE_V || smd == IGC_RXD_STAT_SMD_TYPE_R) &&
> +		size == SMD_FRAME_SIZE &&
> +		!memcmp(pktbuf, zero_payload, SMD_FRAME_SIZE); /* Buffer is all zeros */

Using this definition...

> +}
> +
> +static inline void igc_fpe_lp_event_status(union igc_adv_rx_desc *rx_desc,
> +					   struct ethtool_mmsv *mmsv)
> +{
> +	u32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
> +	int smd;
> +
> +	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
> +
> +	if (smd == IGC_RXD_STAT_SMD_TYPE_V)
> +		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET);
> +	else if (smd == IGC_RXD_STAT_SMD_TYPE_R)
> +		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET);
> +}
> @@ -2617,6 +2617,15 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  			size -= IGC_TS_HDR_LEN;
>  		}
>  
> +		if (igc_fpe_is_pmac_enabled(adapter) &&
> +		    igc_fpe_is_verify_or_response(rx_desc, size, pktbuf)) {

... invalid SMD-R and SMD-V frames will skip this code block altogether, and
will be passed up the network stack, and visible at least in tcpdump, correct?
Essentially, if the link partner would craft an ICMP request packet with
an SMD-V or SMD-R, your station would respond to it, which is incorrect.

A bit strange, the behavior in this case seems a bit under-specified in
the standard, and I don't see any counter that should be incremented.

> +			igc_fpe_lp_event_status(rx_desc, &adapter->fpe.mmsv);
> +			/* Advance the ring next-to-clean */
> +			igc_is_non_eop(rx_ring, rx_desc);
> +			cleaned_count++;
> +			continue;
> +		}

To fix this, don't you want to merge the unnaturally split
igc_fpe_is_verify_or_response() and igc_fpe_lp_event_status() into a
single function, which returns true whenever the mPacket should be
consumed by the driver, but decides whether to emit a mmsv event on its
own? Merging the two would also avoid reading rx_desc->wb.upper.status_error
twice.

Something like this:

static inline bool igc_fpe_handle_mpacket(struct igc_adapter *adapter,
					  union igc_adv_rx_desc *rx_desc,
					  unsigned int size, void *pktbuf)
{
	u32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
	int smd;

	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
	if (smd != IGC_RXD_STAT_SMD_TYPE_V && smd != IGC_RXD_STAT_SMD_TYPE_R)
		return false;

	if (size == SMD_FRAME_SIZE && mem_is_zero(pktbuf, SMD_FRAME_SIZE)) {
		struct ethtool_mmsv *mmsv = &adapter->fpe.mmsv;
		enum ethtool_mmsv_event event;

		if (smd == IGC_RXD_STAT_SMD_TYPE_V)
			event = ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET;
		else
			event = ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET;

		ethtool_mmsv_event_handle(mmsv, event);
	}

	return true;
}

		if (igc_fpe_is_pmac_enabled(adapter) &&
		    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf)) {
			/* Advance the ring next-to-clean */
			igc_is_non_eop(rx_ring, rx_desc);
			cleaned_count++;
			continue;
		}

[ also remark the use of mem_is_zero() instead of memcmp() with a buffer
  pre-filled with zeroes. It should be more efficient, for the simple
  reason that it's accessing a single memory buffer and not two. Though
  I'm surprised how widespread the memcmp() pattern is throughout the
  kernel. ]

