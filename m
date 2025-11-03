Return-Path: <bpf+bounces-73358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793FFC2CA22
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 16:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E55418932E4
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233B73385B2;
	Mon,  3 Nov 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eI66bRS5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C43334698;
	Mon,  3 Nov 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181918; cv=fail; b=N2QlyRjCYSIWfgoJxo9YoqG1MGXUDWibskVx+1T8E01m/cI7DItHy9+cIyvD6zFBIXJ3UYMVJl217Pm95Z4kMiWR/08FWKZFktj4bh2C87vp+MmyPGTgRyaKhL6WJl9lw70aoprcFJyzuVDr1bm362X+n0e4h74r/NKXhSqxe+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181918; c=relaxed/simple;
	bh=wVddDXdNC3A9bCpH6tnjpOtbZG2+oXORY9/Xu1SPWGE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T8bikvWJZ6awVIqGebNcCQHCjOUX5HF5xSKTVov5oLZMi4/S9xQOGDrPMuanMSsIP8VLVU13gB8ak5LgJhC3W18l2HwGMTNv1tNa7AIsa88tHXmBBnNOqCn03YeZuYwplL2s+fHPnXQ2l0tLe7EQM+oyEAkT5ozCbl3lbB/f7IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eI66bRS5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762181916; x=1793717916;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wVddDXdNC3A9bCpH6tnjpOtbZG2+oXORY9/Xu1SPWGE=;
  b=eI66bRS56YQUfrvmWiHUa/TrUW+9oJxBuc5ZwOals2lfvBYxMEBz5Cnx
   KUeRnEPtpMYxw6he8raLr5MZl/FGFDLaNcX1Rg/abc9Re0KwnwUhXvx/A
   MjXWYv0P4yhDygflROPHAn1KiLdzXvWM5zWBcj8foxiq97WOWUBAkghmW
   DsKbw/XMYaISYagXk0DlgJFaggqQL4KW3I5a8OYUIm66jW/E5jiwSJ0QO
   x0LUKEqttk07wXE40hhacahMPK6WWa4jR2tCOZKs2NTpQrHklB+iLYEPt
   POUAyE9LCcQGWkJb/ou2EGBDMW95r1M/Q7ShRBZ6pEP2T3aSSZdoQRX7W
   g==;
X-CSE-ConnectionGUID: GBVvzmnXQKq0dcbJJ6Yung==
X-CSE-MsgGUID: wKn1sCF9QgWfM4Byna4J2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64408838"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="64408838"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 06:58:36 -0800
X-CSE-ConnectionGUID: ppopHNBuT/axL0HYnmEQbA==
X-CSE-MsgGUID: tUA1ZD20QOGpwnr3Trxe3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="190982396"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 06:58:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 06:58:35 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 06:58:35 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 06:58:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHwc7Wcf+RkiX2sMAx+qV5DAxeRPfUmMFton6F6xzRf40YniQD6s9R27Qr977lCBcEg1UKaIbu5A6S9yPp6lQcsYz1XpwPd3UlXo+boPnaZ81VUw3Z1vfmQ3Pv0rY17f96CqZIl9N8x+sEggFWoCd2Bq6VXG/noN2X/5DFixMmsZoIwlmoxCB2czB5ClPQ6YToUA3jR+n7np5q+XI/Gf9qEsNdvvELcA7dkajey35VbNtob2SeLvm3/OwN8b5EV4iVNFDm1QAKH2xvYi2I3ZN8m4XeAXwy+5lyVMHMLVY8ywbTCVqrkd4CQLaRediSYNmPn2BIpKO6WAKxt/VOqimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ38trN4k3UlZa00u9TV631R7yd7lkZqnS8NNfCXX/8=;
 b=kg+MY/6Plg2x3hW2hnWjfZrQb6BVMXeeEBmLJtrxKiZgQORsE1hmRIR6rA1yEsGLPD0rRp0CStdas+NyYyJ403QzYziKl9S186t4Hdr+ck0qM/ib73YkKnYmKw0h04zCcRD8hg+tAB57JIMwSovEli6kneGoHC94EsjwxDLIgqsNsVrvfkbHD+kbzzL5T1emQB9m8W68rmojnpJpnHXhSyRMYtBZPzY7YYbGCKbGaY19PFlzJaLmCbDsJgi9epy5sFQTnTW2FffVkwj1xaMiHCWnHBp3b85ie47AvrRS7IzRFJyQ4psBfoHdJ5pAOkNCxXiyDFj6+wYIFXvnI6/EtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4599.namprd11.prod.outlook.com (2603:10b6:208:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:58:32 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 14:58:32 +0000
Date: Mon, 3 Nov 2025 15:58:20 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 2/2] xsk: use a smaller new lock for shared
 pool case
Message-ID: <aQjDDJsGIAI5YHBL@boxer>
References: <20251030000646.18859-1-kerneljasonxing@gmail.com>
 <20251030000646.18859-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030000646.18859-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VI1PR06CA0194.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: 47764665-fc67-4e72-21b1-08de1ae974e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TpI+UtR/Mzs6/TkbQpT+hM6CUDZu8AvgTMLN0Zs7R47GqOyxpbCXNtLpNiBs?=
 =?us-ascii?Q?xgStXwa8kkLg2PalVAuM64GVhWUOhuoB9A09eBMpPYplqEkHpMHoElFsTNMg?=
 =?us-ascii?Q?o7zoAdPsfBg4UFeND2Q4QozalEQ8cQKccZv7+4/Fo40PFMhKBHdASl2YtZlA?=
 =?us-ascii?Q?JP7k0HQLbTzF/AP56LC8FWhoAhhmpM+tb/IEfZ/NRHbU0zmBVCcNn+oZOcbb?=
 =?us-ascii?Q?UviyiVKuoBnrtHK5dPNnkRxxesFn7V1Xvbent6v47bbVQjFt5bOc1G+aHtMW?=
 =?us-ascii?Q?xX1QAt1bYGTi3Rvhrr1t07PzpEZQ8kw8vk69s48lfOovfwy5tNyslqy8IY+5?=
 =?us-ascii?Q?SiZfhK2wgpvKlnvO0fDnq1fug9yYsI1vOPzIwwvjmnpIkua+Ih3EWcvNlXfn?=
 =?us-ascii?Q?SbStB4/ndjsUXBkhZXNYfjXmeBriPWqg4kzggU593wdOhsmrGw/jvd2tLZ3q?=
 =?us-ascii?Q?yt5U49Dd6gl8d2gPIYEW47J8lZrQVkSqysBZ5ZBMInQ/XFGM0XS6/Ir3xvQv?=
 =?us-ascii?Q?IUsvphOwKPjNnkaW/qaqoAtc/S/W/8eHMTBLWXYLVwbPQTiu99UkutchHJA9?=
 =?us-ascii?Q?Knvic2ztYvDJtchnsTcc56lTMVSJ5lDLpQSp7vsDICpwNYICwRsZRDjg/Wh9?=
 =?us-ascii?Q?a2AXcT8pfF8cxBNZTdXz5BrKGGkbc5+jxgbO4yKyuQj+nBBHFKoy7in4EI9D?=
 =?us-ascii?Q?XV9SUfEtLAdA8t3T7hJJq/E1iL8grVbwnfN3lHX3c7Ji0xaLiJ1tR9/7oowo?=
 =?us-ascii?Q?fENRwctzEBvnpJhsWw2L8XwxqVxABzlCNUaR3PN1rrnn8LtM1XtPECr1Ywcb?=
 =?us-ascii?Q?sY75Rg96T1Fsonv/buhdglfEP+GkIluSpis67VMcjFlI4aOEOXXwAaAAKgrs?=
 =?us-ascii?Q?rcZDu2I1313mf6gOpOrxXgCAUwHz8rOIWA78uAXcevGP1O/VsqWqQM99Zr29?=
 =?us-ascii?Q?ROiBCwQLTU6KmrBpb1XXbTmbpml14DAla3VmRFQSjXX7Oe4rK4TDpgBvt59T?=
 =?us-ascii?Q?CIsOmf44bINy/7uSNEi1jp0FY5jj5k0nDvlBN8MmBKjt6exTnNEiGXaHC5He?=
 =?us-ascii?Q?uTi7T2NPt6c3vpiJ5efYG1blEGGJEmuAKZweKNSJFFr37mcy2WgrxU3rE5uO?=
 =?us-ascii?Q?5MWwIwvzpbmFoZmmrdB4tmTld0rkTmcjKysbEXFmBDTLqSp7j+0UbLz8gSdG?=
 =?us-ascii?Q?Rqvd5HLbcBYiD/uFMxD3wCM2vqu9yXRPJ74OBzbIfbHq+rvDNbX0DkgOrf0h?=
 =?us-ascii?Q?9SeVGHDORTs0nVjjtT5veYWVPaTQxz9Gx7WKkOM7uwykSiM1n42Lnm6Ijnwf?=
 =?us-ascii?Q?WOwi3yzk/xVw1u3pW5QZW4zkTVkidL8WQvWbno/u0vt0qq0Mn/nNMPAGXciH?=
 =?us-ascii?Q?sC5WdTll+sMAOTJgVxFunr/+0eZZMMuk1uxe1/80G8kltYlTW3opY7slB7Ga?=
 =?us-ascii?Q?P8tyMjNhcj+QoSfP/TdvbuIZqnOiFGTs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XmPmjSyQTmKFArJGl0jPuvsw5ZBuyBMueG8Lwh69hPGWU9k5oVZ9IQXZ/92A?=
 =?us-ascii?Q?9r2pTHRe6EmDvVmfbbRi/HwDMcboC7zbsxCxs8aEn/a287/+Zi1DEa+dPhlv?=
 =?us-ascii?Q?n3kCX/60/bGePMUnjPm98l/u9AGmlAoT5jwWJsj7lCCjQ3mVfQSWzEC+IIms?=
 =?us-ascii?Q?wmHHVKLXdh/BJI6w5V1ECOtnwxgUcKsU3EM5eLaw0PtiuRyHdZsKb5i+HEWQ?=
 =?us-ascii?Q?yfmpM+RwEOnnDkWCbP91N67VzbEdagz4SarMU5cui1g3gFZzppTjYWIW570v?=
 =?us-ascii?Q?kWuQbWMVrEe1mpPdpDiiuOepK4od0ktyvVBTNTcDF54ZvNAlDvCNY5+a6oAH?=
 =?us-ascii?Q?6Ypw3yiHXN6v6Oez2j4T2AxQrMn8K7CB8/UrtzU1gijlh/GgU40qhJI8AD2T?=
 =?us-ascii?Q?yHup1E+iOnQbHEGfkNR2lQOmQCK01EqMIPYR/wdsLCmtVMZce/AxxVoA5F26?=
 =?us-ascii?Q?QGx/NzPKYPDpjUgon4q8LuIKMpZ6oBczpYt3FAcZ6QzvOshCV3vevvshXSPw?=
 =?us-ascii?Q?gT0+Zr7Yf02JGippZV95Puq0T8RLUeVwbk9FBdpTte4v89wWtMux7MxhVX1w?=
 =?us-ascii?Q?B5Avk+dpDr0E5N4oi2+f60gsfGrmCUwCrFMMC5JeEkGP86pAmvimNJZDMWql?=
 =?us-ascii?Q?5lDLAPg6qrnKSzVoNF54/luC9+G2OYWkEZpdrpHeUiDE+1gu6dNZev3o2mTv?=
 =?us-ascii?Q?awS/3i6DZ7A/GVQMgCpApf3m/BSX/8WasR1hl43QsC5ldss84QOdFhjymUMB?=
 =?us-ascii?Q?PNndIUqOkRFszMxfsATVOB4Arar97SsEiU1ctjaVH4ARq6ruvPbEP5wZKLOl?=
 =?us-ascii?Q?oxqwxMUbhUVcs15BssribcEVNvrpiJxqUh0G/6Pqg/KnnQrr1lGa/awaztlx?=
 =?us-ascii?Q?0hpblMLY4JqdbF4UB0EXxgeExrT7BjswOVsKuBL0k1Tmz6+zy2cFoEvC+Iyr?=
 =?us-ascii?Q?EYis66TYsTeI0LaxBgZe1AYtiXmkKcP3uPIMJy+bS6EXx6Dbj6fUiY2JvEM5?=
 =?us-ascii?Q?8gQZ0Rt4RgsxalyDZgZeiBg25qlFGgxn1Yocrfb1jMy3JRgEx55/6XEOFRr6?=
 =?us-ascii?Q?g1xmSPbuPdQwm6BiVDYrgVnJ/w38TP9zreHoX6IX/LfPgdU+hMXAFTJuy942?=
 =?us-ascii?Q?hLx+SgL92K7c4W1dgNSGnSnSB9tig3LR1J4DMfAgfhzUntePrT1BApflY4ko?=
 =?us-ascii?Q?PBpBRWdoIJtsJFuoXj8/cD+4BB58TDyckmTDwUcrvoKy/TsscHURlJpwO1Np?=
 =?us-ascii?Q?ZNbkAs4jOf2xOqZvQ1uOMBYJif6THdUjBsOceRVh4ET+k6agxFZBPqAOEjEZ?=
 =?us-ascii?Q?JsAp2+Mgk0w2XPSbLpNA8XEF/H/rJXkDglnqWGrehJhnnGx/so8xVFok2kdW?=
 =?us-ascii?Q?NnUemolDDHE1fPdBesgn5NJqgMt78GnLvvt+UIrjEcBw0omzC+BAID49dRDM?=
 =?us-ascii?Q?9yuT+oemrzH6YoLL28Irj4SdbFblD1fn6c/WYoFQcJYfjQRIRDY3uKaMsfDG?=
 =?us-ascii?Q?wKi1D97JeRd/kD7/aZJcD4XnP06hRRbrU2UYEcVW8IyLDVN+nWczpPaYBFdE?=
 =?us-ascii?Q?TRChOUMDBoXMyRv5+yFk5gTcWVX2h8mP5X8eBAYCypc1v1vg4CYHG9FRDYht?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47764665-fc67-4e72-21b1-08de1ae974e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:58:32.5970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdnC2fQv+0PGdIk4s2rMfIlcQYnggky9fYArlNrMXi/JhzQ4xt18ZUiCkvm6/VCJammCg8rmth+umHnFdxJSfl6hgdteakiBfoYahlWjcIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4599
X-OriginatorOrg: intel.com

On Thu, Oct 30, 2025 at 08:06:46AM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> - Split cq_lock into two smaller locks: cq_prod_lock and
>   cq_cached_prod_lock
> - Avoid disabling/enabling interrupts in the hot xmit path
> 
> In either xsk_cq_cancel_locked() or xsk_cq_reserve_locked() function,
> the race condition is only between multiple xsks sharing the same
> pool. They are all in the process context rather than interrupt context,
> so now the small lock named cq_cached_prod_lock can be used without
> handling interrupts.
> 
> While cq_cached_prod_lock ensures the exclusive modification of
> @cached_prod, cq_prod_lock in xsk_cq_submit_addr_locked() only cares
> about @producer and corresponding @desc. Both of them don't necessarily
> be consistent with @cached_prod protected by cq_cached_prod_lock.
> That's the reason why the previous big lock can be split into two
> smaller ones. Please note that SPSC rule is all about the global state
> of producer and consumer that can affect both layers instead of local
> or cached ones.
> 
> Frequently disabling and enabling interrupt are very time consuming
> in some cases, especially in a per-descriptor granularity, which now
> can be avoided after this optimization, even when the pool is shared by
> multiple xsks.
> 
> With this patch, the performance number[1] could go from 1,872,565 pps
> to 1,961,009 pps. It's a minor rise of around 5%.
> 
> [1]: taskset -c 1 ./xdpsock -i enp2s0f1 -q 0 -t -S -s 64
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/xsk_buff_pool.h | 13 +++++++++----
>  net/xdp/xsk.c               | 15 ++++++---------
>  net/xdp/xsk_buff_pool.c     |  3 ++-
>  3 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index cac56e6b0869..92a2358c6ce3 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -85,11 +85,16 @@ struct xsk_buff_pool {
>  	bool unaligned;
>  	bool tx_sw_csum;
>  	void *addrs;
> -	/* Mutual exclusion of the completion ring in the SKB mode. Two cases to protect:
> -	 * NAPI TX thread and sendmsg error paths in the SKB destructor callback and when
> -	 * sockets share a single cq when the same netdev and queue id is shared.
> +	/* Mutual exclusion of the completion ring in the SKB mode.
> +	 * Protect: NAPI TX thread and sendmsg error paths in the SKB
> +	 * destructor callback.
>  	 */
> -	spinlock_t cq_lock;
> +	spinlock_t cq_prod_lock;
> +	/* Mutual exclusion of the completion ring in the SKB mode.
> +	 * Protect: when sockets share a single cq when the same netdev
> +	 * and queue id is shared.
> +	 */
> +	spinlock_t cq_cached_prod_lock;

Nice that existing hole is utilized here.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

>  	struct xdp_buff_xsk *free_heads[];
>  };
>  
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..2f26c918d448 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -548,12 +548,11 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
>  
>  static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  {
> -	unsigned long flags;
>  	int ret;
>  
> -	spin_lock_irqsave(&pool->cq_lock, flags);
> +	spin_lock(&pool->cq_cached_prod_lock);
>  	ret = xskq_prod_reserve(pool->cq);
> -	spin_unlock_irqrestore(&pool->cq_lock, flags);
> +	spin_unlock(&pool->cq_cached_prod_lock);
>  
>  	return ret;
>  }
> @@ -566,7 +565,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  	unsigned long flags;
>  	u32 idx;
>  
> -	spin_lock_irqsave(&pool->cq_lock, flags);
> +	spin_lock_irqsave(&pool->cq_prod_lock, flags);
>  	idx = xskq_get_prod(pool->cq);
>  
>  	xskq_prod_write_addr(pool->cq, idx,
> @@ -583,16 +582,14 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  		}
>  	}
>  	xskq_prod_submit_n(pool->cq, descs_processed);
> -	spin_unlock_irqrestore(&pool->cq_lock, flags);
> +	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
>  }
>  
>  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&pool->cq_lock, flags);
> +	spin_lock(&pool->cq_cached_prod_lock);
>  	xskq_prod_cancel_n(pool->cq, n);
> -	spin_unlock_irqrestore(&pool->cq_lock, flags);
> +	spin_unlock(&pool->cq_cached_prod_lock);
>  }
>  
>  static void xsk_inc_num_desc(struct sk_buff *skb)
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 309075050b2a..00a4eddaa0cd 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -90,7 +90,8 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  	INIT_LIST_HEAD(&pool->xskb_list);
>  	INIT_LIST_HEAD(&pool->xsk_tx_list);
>  	spin_lock_init(&pool->xsk_tx_list_lock);
> -	spin_lock_init(&pool->cq_lock);
> +	spin_lock_init(&pool->cq_prod_lock);
> +	spin_lock_init(&pool->cq_cached_prod_lock);
>  	refcount_set(&pool->users, 1);
>  
>  	pool->fq = xs->fq_tmp;
> -- 
> 2.41.3
> 

