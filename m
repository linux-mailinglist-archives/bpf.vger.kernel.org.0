Return-Path: <bpf+bounces-53412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EBEA50EA1
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A103AB649
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7697265CA1;
	Wed,  5 Mar 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PdTshvaK"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090212E3375;
	Wed,  5 Mar 2025 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213848; cv=fail; b=mQhbTRn6G7FKWDK98EiFHWs84e8xUMqrhT5drEDx53bq9o5j0hpOHq444KaZRILZY9U8gDfatNdH6mCqyuroiRCzRutehx0rCzsDvKl4OfkXv/vpfgfG/UJSc55q8zgOeF0R47AV/ZrznbgqkdFwHg5KlXec/ZHQXGmni1dTIT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213848; c=relaxed/simple;
	bh=VrMEpwHI3a17AtIkmmOvGAongCcV1fsKJ7OaYMF2fTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nb3+vwXaCW+eNTPwvGBNGkKDdTlSjOpvDpnV1qH3T4xlVzOdRh8PPai1IcT4xywDwXH5VD7CL+uI5i0LxQa7VzUTf859lo13jAK/1tLnuVaRl0Tf50Y7RO3WgYw4S3idvfmxUOvOuM9r1PkjvcK9amkk1Yx30IvzcopeJZEJqj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PdTshvaK; arc=fail smtp.client-ip=40.107.241.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owfs3C3RFMkZyv7Fc/0kwwQV7uiQEUJPe0GtAogQiBpRWtylwx5p9Ka2VHFxXa6H+9Jo0Ps68ReweoDFVVQGRZa6Mr3kTkiZ+l/6Ji8Y45g3DYk6Remd2Xtw4ci/mHypaPSZhoz5806jEYViYBY07lWue/+Lg5tL1iMs0a1qUz1NcNhi2uu73sQ1OmWIsJr9zPE1RZR90xXB959fA5f3lN5GQjUXhVR3GQ9yuGVw4wOPhcsokQwSg8kjSfyA1xvMvLeKDU640B+YRGb01FUYUoTyYrC4Gl8ZcgnCqcBfm0RRDTw0HHFmpPCx8gdbx64xjWaAn+sb0yVPeq3wwF5/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7f8NKm8ADmcOQ5G2oL61+72mQaCQVW3ugjgyMpWZRY=;
 b=P3Au1EhLPPiX+m6ZeeQhDjXG4r2AInRFWToUXwvc5Vz79QxURrUnooc5lsgQ5KDgO1Ov43JYKqwYiasl49D80yxnvPzBBKkL71qU9zmGvU7KmhrFXUlCbMD/JgWZfqe7QWDzqeG9LG1dFKvRV5vTfqnxJ/qh2Ve0Ra0k7TscWbmPEQHExknXamygwHp8orBk/Zc1H29IlCYSKubkypGUdk6AYqQJdMbWfCTEVrEb0moqsxPHx2JB/sft99yC/WCRm22fuiqZAYBvvy5vVPG/zqKBriNERTaxQ74N+0s/xE7hDO3KJr2mSQvSvLziwfg3xf8C/Bhk9ytU6XozEcNEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7f8NKm8ADmcOQ5G2oL61+72mQaCQVW3ugjgyMpWZRY=;
 b=PdTshvaKxf/FTTCP1GYpYBLxG82O2cRx6CHryUrkNP+XLSO0gbZDnz1+3WdhRqGLXvRCVOvHmDma542GhywutDwAOS2MyPrvH2I9oH7OW92+HNNutdX9aTrw1Byzkma9jSjwa7mV9rQ/ZrkI134rG096ygcLTKH+ucVpUUmhvyXKN9eit8qgOaJOEU5U1QUUjZQxtecaVVPRacQnGT9eoU3b1yUxxSXXJ7RHbtmoksLbcFv1/qZXEqThLrIb4up8wbrjIgj8xRLXwNS9fFr0sALjziiqATlJXXX9c7CHXcTFAD9eWXdI6e5irCB3OZseLb+6Ikx+8ozUNQR02BlD4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 22:30:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 22:30:34 +0000
Date: Thu, 6 Mar 2025 00:30:29 +0200
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
Subject: Re: [PATCH iwl-next v8 01/11] net: stmmac: move frag_size handling
 out of spin_lock
Message-ID: <20250305223029.yh3fglyq5isncjni@skbuf>
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-2-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-2-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305130026.642219-2-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-2-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:803:1::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA2PR04MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: 14303434-503a-4e75-605f-08dd5c355830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRUk/zEjmEWmSoH1K8VQXkEGWucRSkUOSyGKmE0Dlk6hXNwHe7u8vlfD6Dfw?=
 =?us-ascii?Q?tJOsS8EAqd/U+ox5fNZjkP/D4R7DF++QMPaBO3FCuzN8sZM6IFD41M/DK8VV?=
 =?us-ascii?Q?IJp6gsa5sGtpN+Acc5Xl1fJW8sfWZEBuAGNIEP6gEDqguVps2JmhvhqJassV?=
 =?us-ascii?Q?AlbXpzSta6Rkd4nkjw40poGG3qg3w2qYvsVGqKDgXHcQd9IKyo9RwW6jfkPb?=
 =?us-ascii?Q?knmjXpZeSm18RSFYpr0aoSURdCl9/5WF21atx5g0yQtndD86LdMJ7BGRdCXI?=
 =?us-ascii?Q?Rk+aiBLHJG59T2ixAZzr0BoHe65HS88ikQ8lku+sTmDckndIKHoSizMXnvI0?=
 =?us-ascii?Q?aIXYrA2HhcTqhRhMcDlFPCZ5PHdR5HVOr8MCfK5renEBUCg416zwzSR3GHoa?=
 =?us-ascii?Q?Q7z04pDI/PTZP4/HV5M97Hn6daWGFTw+e4ZPP5zLxXlfKGVWbPdSq7Ah3jqv?=
 =?us-ascii?Q?VYVeB4+BhFNeLFlhH88KPncjlwcr5WjdRqNMALdb8tTPXTEHNeRxZ4G5G8KI?=
 =?us-ascii?Q?ZG0hG01l23khDraN5AKHjhCn2B4vlP9cCp31k2JFbI0jIiXXUGPLWiT3tddK?=
 =?us-ascii?Q?ivH4BX2LwTujSzY5fxrdvb+/PJYETcJ0twWeymjZS2SL65UqgL1qwv6+grC7?=
 =?us-ascii?Q?4ackTgBWPvfYCfSr3ik65rnlo1xza+tzaw5al0k+y7brsGpDR9FlfzD3l9Jz?=
 =?us-ascii?Q?FSIrbdHj8F/iqoVNZHRHx6A5BJuMW7FMd+H7ptRL0RFV9Uf+6PbiuX8X38Rh?=
 =?us-ascii?Q?qZd73mzu8OWE2ghHTSANNrT940btEruA6bNz6qmo6Uxf9lu9OKyek2HMmEPf?=
 =?us-ascii?Q?M7UtkYcqzM5SnHe7TImnhdCneh//2zH5c6s0EGMqvYQe7WciLXlVz4E+Piri?=
 =?us-ascii?Q?zoNvN/ahvnLjlFFgSpofrDfG1GVQuaGo8Drd4MsDpzzgD2Orn3UMlxz4kTZq?=
 =?us-ascii?Q?j+JzhRNbsJURsrRKov89Ll4f3GmwBTIYhqB3ai3/1yy19GQ2cStbjuhKbQ57?=
 =?us-ascii?Q?ZWrdZ6HfmNKEESqCB/zK3mBLg4ZBat63Uo7C8scPkQrCpuW9li4Gnfm8Baa1?=
 =?us-ascii?Q?ZozTRTF7TixR4NYW67NXOj9IM4kGSmJdITdycwpn9UZWGrAHI8jL2+9rKmwu?=
 =?us-ascii?Q?lxkqkQz158aDBI66alJXtND1Qi9fLXZQ7cTfG3VNrONrnE46Z152sr6N0+bk?=
 =?us-ascii?Q?pif+9+1/AsmAUoswyrgTshROnBkhMmuLqbphdiPlWakMtfqGhdow3GcNQksw?=
 =?us-ascii?Q?lNudhYfiLTD8wFLM5XLVvQaOVku+R4DYGOwqPvB7SmqMHpiVJyglKqR/wl9F?=
 =?us-ascii?Q?UMjzTw38Ge3vZusQp6MKtt8ykcLus745enMNZjpDHg3973DC+C4B3Uhtl05B?=
 =?us-ascii?Q?k5NBOtYSgvBzZQxszt+yr2hTkWKF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DvD3bY7hKp6e6Ibk8msCJL6Surs2F0MXVWEd2p1+YSFm/M+PgU5XRrG8qN7Z?=
 =?us-ascii?Q?HjYJQJUOqeGPYIkVzJr7m24Rtt1DnkjkiquYQOd1rJyDUxbtV+t1HX6KVV5D?=
 =?us-ascii?Q?o2fhdJOSpZVp2GatoYL4lZ3Ihc495uNbnWG8H5wwucQXd6LD4r9Bixo0wvl5?=
 =?us-ascii?Q?ZFk7ZhEsGsCXRwlO/TYvI69/VXS2/tTmeSjOQb5PkRJpFSvCUNXowV+6vGSi?=
 =?us-ascii?Q?2YduLpWCXbKzif0Gf1yFWkZSOevu+E04AT6TNGGUWlfprWGkWarT2NykOcLB?=
 =?us-ascii?Q?sDUyhAqBKBe4kr7Z4DXwyl/6FoY/ngwYVGWnb3QD+0wDowuSl3SzLm8KOeNL?=
 =?us-ascii?Q?bqDTuCe976QYKhpyNh8Vg5S/3FjeqjOyhPt8bNzSt6A/h1i8GLypM5CdKTdJ?=
 =?us-ascii?Q?pUJ5IaBti1jSttTPnUhVhzLXiDCL8Jrf1+MLsyoSrU0lOhHgGY8kLPy3T1Hi?=
 =?us-ascii?Q?DuEhpIZJ8PvKgy+TeYysxDobW9LxBeFZBGl7QWZl2P+c103woEGegbzr2Ca/?=
 =?us-ascii?Q?lAJSXCLTyVwx2S/qOJHLoqKAALtVs5XZI9F/sCeMOxYw2gMyOvOdJlnxm9eC?=
 =?us-ascii?Q?xGnoCFdMXyRvw5B4pWxAu/Ec4w4JsAwMrtOuGGZOt+9xi1KZId23fdAs3mwq?=
 =?us-ascii?Q?qjNmV+8veFwIgqzUNxaM1WQxRTgeT6iJ7pqKzkuTSAqAx00f34niexs2YZE9?=
 =?us-ascii?Q?kKmcT4OY1EsC2z3wCNk5pCIz1XUJKfiiJS+AmIG5eGoqRu5MlhRytsvoGYNt?=
 =?us-ascii?Q?6aFWFqG9HsdoBYPCT6bd2ppwyNhOPTTh46P9VFTITDpR6gx/j8jw1vn3nQDB?=
 =?us-ascii?Q?zIq+rG3uQyETfYJxun1oBaFLWG/dpoBgY3g+ZYwnRCnHggovtwljzbxkloIY?=
 =?us-ascii?Q?3GrR+OpDvKK8xkp+2O5uPhmADHDVYBtc8NvVYIQl28YOvPwbQ43/NlyzBthj?=
 =?us-ascii?Q?cQK0oeNLW/2vpASRjqP75GiDj7ekYT4UuNmIKcWdbZuec73NsoygGaGSIZA5?=
 =?us-ascii?Q?cHNM7fT7wJBmK7dLpGI7F+HUirZPoRZaYouj+pxyuyHxOjc0zn0hZUyaNFZY?=
 =?us-ascii?Q?cI9qSMA54bg78MURGBJNAv+8EP81K0h6ZeNcxor9b9J6sc99RqALVUh3RWut?=
 =?us-ascii?Q?22raBDF6kYJdiZCIFUfDwBXaIU2GsjJYNLXSW4BWiynWONJHLteo7nVP/5QC?=
 =?us-ascii?Q?TevZvmfaOQ8nbMv5PNhaJRsmEM/nftTUj1e4gG8ES6FdY8nBlCZcweTANfLe?=
 =?us-ascii?Q?vhlLd3S50XYdvybQd3w+8hPWVt/vfGWyvt0QxzN/QcQzpd9ilGijLcrhC4C6?=
 =?us-ascii?Q?QxK7ENAelvENV8/0dKDAT4Su8+6COycIoCpE+WG+bE9Wl3aYS10qpuw92roS?=
 =?us-ascii?Q?FZea8MjBnnq93WnvsR/4kUbtMHgOsGGg55QUBnOsEiAB59MmolS13xjmzo3f?=
 =?us-ascii?Q?mEomwJMjFAimhShKq6//csf01NMceBPnQ41II577L/RSNVScV/r64BgC3Jwx?=
 =?us-ascii?Q?TsAxwuvSj+nwcy5cOo/CQoHEV2M/M7cPoqocGYufO4Pk7umquAD/tKCbmfZS?=
 =?us-ascii?Q?yVCzAAZCWqEvN31gdEBe+9RmBHCfI/OMYmkzx1nwV8PH1vOKzpszIr9euaY+?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14303434-503a-4e75-605f-08dd5c355830
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:30:34.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ci7JeZwoNs9cmJH/SXmCjk4nPXEB/dGVHvs7MwTKEevUJZySUfK+Q11DZrZfN/jl6qMjiRKuTKXAXewB6Wblrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309

On Wed, Mar 05, 2025 at 08:00:16AM -0500, Faizal Rahim wrote:
> The upcoming patch will extract verification logic into a new module,
> MMSV (MAC Merge Software Verification). MMSV will handle most FPE fields,
> except frag_size. It introduces its own lock (mmsv->lock), replacing
> fpe_cfg->lock.
> 
> Since frag_size handling remains in the driver, the existing rtnl_lock()
> is sufficient. Move frag_size handling out of spin_lock_irq_save() to keep
> the upcoming patch a pure refactoring without behavior changes.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

