Return-Path: <bpf+bounces-73356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F19C2C766
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 15:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC13A5F85
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CA22820C6;
	Mon,  3 Nov 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVJ7Q7Lv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A62836B1;
	Mon,  3 Nov 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180984; cv=fail; b=FF6CDnxupaYNc03FNyRWspaJoJZ+KyHtqKhIXfTZIipBtsWuyirv/uWHrmcpOkuznyAmAlPyvM5F0JEXNpSZrOwEUT6Eu5qd+Rp8sb61laYOfZBDhuU6axhbHdumaciP7+aic98H/ax5CPnmXJNLOZunupmhqbFfGhslM5V+nHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180984; c=relaxed/simple;
	bh=/wExhf7cdY/E1QWIT6SsK5jRTGvkcHBXNdacC72qx6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OaS/oFeB2TocoLCuYOnsho3lJxqmnzjTPY8KbmuQlevjiE1cdJ+YW5pByXRju67Hj7SA7MUr9dDwD0yqZPZgAG+ky2vCiVb/swUs9wyyRt2GhgRB/UO+55ziMU6quKM/d5DidLRf0nF4U46jitqPPh6K6C/bB5mPpj3x07i/Osk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVJ7Q7Lv; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762180983; x=1793716983;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/wExhf7cdY/E1QWIT6SsK5jRTGvkcHBXNdacC72qx6c=;
  b=lVJ7Q7LvXp4xSXezqadDXPw5TB6xzk1712JbAhW1GvDruWct85xHI+Zi
   GBKQbYt2EyfiTM4AhlVNC+X8BG/QJdKpRHZ6ukgC1LJXqRNqMmnxt00lB
   qEEvNKf6nMMcK0ENZaBv7gGU4yzqz9312dj64pWtEgi+Qe2WP8+3PLWqw
   RmiS/MoOHGhFBO4s2YSWS6AZBRIDtbCUty9Cv2gkIOo4wCrLEvMpivgii
   hKN0xz6zLwCSf45MGQ5ZeIgQfAbQddtWK5Mg0wz1zDhZrArUj3w9Xu8F8
   1zjyahXFDWg38nltEGhG+eauV25RYmdpkVHzr02Hq42U8UXXzdQbZies7
   Q==;
X-CSE-ConnectionGUID: 9em5MH8GTa2qgpeC1W5jBA==
X-CSE-MsgGUID: 7zAt5EFzQbyciOfdr5U+ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64407606"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="64407606"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 06:43:02 -0800
X-CSE-ConnectionGUID: 6XITRiKnSqOo2cc8u1YtOQ==
X-CSE-MsgGUID: lr/hOKYWS5eF7zMcelb+KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="217520319"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 06:43:01 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 06:43:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 06:43:01 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 06:43:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec5HRUNSwB20n2R+UzJ4aNo5sAMekaUoiGJWMBRiKLTNGlgdexdaBRIKHBGgeOLYuKuGB1TQtR1c7ytTbqG5LwSbFiNYZRiacXNTjhe58TH4B3rqJUq/qAPV7J+Nf+GMkcO1UO+ubG9hQkRifkt0PBW85cE1nFCgonpibLdvf7to8gkwImJa/NiPyt5DhhqyoMwldNeN8TX3OgwHTQSC6uBh5B2t0nsyDotbnt8kdomtqnST+KfYpld7NpdAweQgu0gTUaJrKuUphHYpDuqO1wjNgbpHdQVBbZRV1qE7eaZfg26JzC/NiJ2CkE5FgBAiuqXMzE5YvXgUeYlXvcKBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gP2rl6iJE8qfxDMa9EgD18/Dj+c/vzhoU/J3ywpxGU=;
 b=wYOEdIsyzdXgic6/ODh6ed3zpIjAOxsBE1qadz7ut2y0lSOUimg7DMWwS10O22P0LjtPzcKtbJr03XmOAQ20sLaUP+v36kwLiBVleGEgBf5Qchwd5ttkqBpjKOAqYNzAilTI6UsE6TnEFaH2XDPR2FjNbdXWWABrNHtGESma85pCNFPZJptK5C3oLmYhYeqYfxJqTT1ibBYogLGSRo5ojtiPkVftUIGigl1UFplo2wDwVYc4LTnz+ENvwn16Evl2PcuwsvQZOLkrm1d50hf+IPHZYI6L3GXOMwUgnljvJk/3Ebvy2RH8mloUDreYKXla36im6Jj+su+r4tnD/bC9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA4PR11MB9395.namprd11.prod.outlook.com (2603:10b6:208:55f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 14:42:58 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 14:42:57 +0000
Date: Mon, 3 Nov 2025 15:42:45 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 1/2] xsk: do not enable/disable irq when
 grabbing/releasing xsk_tx_list_lock
Message-ID: <aQi/ZbAoVwBX9VCi@boxer>
References: <20251030000646.18859-1-kerneljasonxing@gmail.com>
 <20251030000646.18859-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030000646.18859-2-kerneljasonxing@gmail.com>
X-ClientProxiedBy: BE1P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA4PR11MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 2223b29b-205a-4094-2dc3-08de1ae747a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?huUYPdgMVZ86kphp74RWSgV0/bCLWTWKAbTaGUrdZdHPlmjxIp4ASrEhBGOg?=
 =?us-ascii?Q?9bhIkny1GfvQrc/CQhew0OJn/Yp9/mvl2D+ErCv9EGZe9kBMUOGUGZX8Huzl?=
 =?us-ascii?Q?eS/WFFbMtGsPLrnbMQbg8MO/2QIlYdjUBavGy/3lTuv28+DUrkaFMuiMPcRg?=
 =?us-ascii?Q?poGbpUfjevdhLeLChcUOL7GPAYxHOwoue//UayTvFCsyA21eNzntoNFhhOnk?=
 =?us-ascii?Q?8Z0qsHKgZh2p/AJhqzOZJFZccQ0XcDKP5a24KNEhnoHX1DJZ9u4sxCFpAwSI?=
 =?us-ascii?Q?Fma+J1K2GG7/vPM4wF7zzCKetyuPgATJ7Cy8sIIuEHk+y8GZuzgQRu9jrh22?=
 =?us-ascii?Q?qG+biliv4xWnQjdppimkkjMan2cOMn55AJMaSvMtCfJkHhci5SRptSv1B+ZW?=
 =?us-ascii?Q?Fp+zTaScF8fzXbgC3gSmiABM4ouyMLqhPvAZ8MFYgCH1Pn8zFtEKTBGZWKD4?=
 =?us-ascii?Q?/7wGHDJjw45BtqA7g3u7QNt/WWo22xnnbXypc8kx4ADfw75FASHdfedVvDgn?=
 =?us-ascii?Q?oJSxBLVi6XpRT732coLpo6ae/FN4wlNDZz52kmdkgADMNNfjWWkQu39lHf86?=
 =?us-ascii?Q?rxkSFq5y3hOy3RKlVp0/Tfzeq3hNUSRXc//ys7KxWyu/55Vs4bz65GTGoC8u?=
 =?us-ascii?Q?x0HzwguQns9T7cAcnd9naSDSlJWOOMp0AiPVRrBpj7Y0a1+aJDA9VaTkul0X?=
 =?us-ascii?Q?Pk3i0CuWop+6XrBrVrqDx2XPSSTzzOJHFCYNv5SqAKUqeTNGiflSrS4tXawp?=
 =?us-ascii?Q?7TDc9XLt7TlOeQuLCK/p8B3rAYKs6/aGhvmFWfezk+/IQ+hT8CXssFdjG0Yz?=
 =?us-ascii?Q?809rxlue6yX2SGBFhKsqBsN4GsKZMHfZ1x1ZNNKODWHWZ7vXd6/Hm10ScW50?=
 =?us-ascii?Q?F5cMaHTxeTZzJLhS55MJ5lhUlC7DFx4sBx/ecSY6rwwPqTJ/NJ24aSoSrfTg?=
 =?us-ascii?Q?HMJzAVQobMtwH8QgCXbxVPPnzqF+9yUqVFqc+nu2ihQYGBWiL+bQ4kBFInXF?=
 =?us-ascii?Q?oCulq33ilFGv1g6sJz6gL8Lv1ewgvhpWD4JF3fgmRP+LIl8Q3BVCxvmOw6Td?=
 =?us-ascii?Q?DwZ8JojThtl46kGDXRmKV1PkqlZMRe942VLuvgwXMRzzGRVGqTqhNpBLU3vc?=
 =?us-ascii?Q?pysUlIIuy07rO9p5XeERmR3/x4kYvz+CVDEEEK4D4vpkvP8+BXg/tFRyGuEP?=
 =?us-ascii?Q?+zm/Gir9es8kJcuIn3Tt43A9sP71MJjM0caAT8ETnB06qt13KZ7e+86i9DlL?=
 =?us-ascii?Q?rjQ3kZH8GYpIofakOr4HZOXEVJrMRgrey5s8y9jE9MBCmNFQAQb2PV5Ny6D8?=
 =?us-ascii?Q?g0tCsFzkRt96SZEInP0LLVxRMZr+r4s7Setji3Yam8W7X8djXqAvkeJ+30/U?=
 =?us-ascii?Q?U611TbK33UotpvMowq+Uf+TyhpIAsuAte0kNj290d0xN10VBv9coavuFpwd9?=
 =?us-ascii?Q?W0Uy8GilKdoM6QK+Q9PMPWPl12+EN0Jx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQRP4A9FQOQSn2UkPckvc8vN90jZPQjXAbJACgAL9ozYlatc+uHuMW/YNj02?=
 =?us-ascii?Q?5+0mTvdQoacMS0iAYUxKi3O0mBUvY8hci8gZbISU7n0Uv32XTtoiCQ1rwULF?=
 =?us-ascii?Q?/OpnbRGvmoy7201ThiW9o/SKGY8011emjreneDiSZe+HMLoev7gzV53QiEDQ?=
 =?us-ascii?Q?b7J1zSj4lw2ffqBYUY4K1m/nQ8ICSMghKPC7E8BlAIPjUFdEPZjllNMFMCbs?=
 =?us-ascii?Q?NhbsHfaEiOpxaLNjVIhAV0a30BnDRP7FqHnX31Cu3aiJPGz+sLoyVmkmCgMC?=
 =?us-ascii?Q?pKkBIHJ1F68gBaRBpQdahxD2tX9KnlvdhSDQxHjtiFNYD7vAvmwbITZO/rsu?=
 =?us-ascii?Q?1zcqjUYcjLbhF2LjDkkigOE+PkXCBmBtmqKM4lpsV/5jROFzmO75gdpzPCD5?=
 =?us-ascii?Q?WMjy/KS2S1IdgI9DT7RzJUf9+h0qg2PEsvD/pfAGZ2VpEEQSs/fRcIhCbpei?=
 =?us-ascii?Q?pj9GQs8bV7fUmamDd7eXX8hD6DsYnYh7Lal6uLRL2ikzrxQm6j5Kt04gmlre?=
 =?us-ascii?Q?ASCwND8MqerR1jm7qS6flDB41elGNl+yJI9qr1lzfKpmJE6QzUP9z4fruQNR?=
 =?us-ascii?Q?zBVkXaDe8kxudjs/BcoAav7BUo55drc0MizL2AsMZbfeXWzK/4yWEL2bKOro?=
 =?us-ascii?Q?SdHUcq8/LMpEiIIfGhCJnBSbOxWKUlZSC20YwU8Hr16qAmvurIdTTIGpsDTm?=
 =?us-ascii?Q?k+J3RdLqQoPjfGZXcVmOW0HzoVd8i+YFbjxKeGIZXMST0HCiONy3amDCN3rJ?=
 =?us-ascii?Q?VZ1XOYleHqHQtb/vuJqK44tiUUK3bo8U0ucjFQBQYMhkzNIDchtEPbORMViT?=
 =?us-ascii?Q?3+ltNk2GWCtDxia0CBYDepDMtqXdpCpjcKYw7WaHuQxyQCOKKRbGAiwNPOjW?=
 =?us-ascii?Q?B8i9x89BDFW8RYyxh1dZP/tEGv0i3EzAsRUU00w4IbsSb+4TGMQDpaEeGfPk?=
 =?us-ascii?Q?u3qOpLd3MfbWx7KI/1WZftSNiSExJiK/ailJD749GJbvvMVR9a9viSHLCa1A?=
 =?us-ascii?Q?TQVGya+jRy6xYeGUz+z8SerHApligKAYQAYjUKCcm5Or4WxmafIaMuphcXZ/?=
 =?us-ascii?Q?3DVPT2ylnD2U6FgOSkSdYWNtFWjNazqGzMKFpkZhIFp2o5GXcCtxT9Z7ipFS?=
 =?us-ascii?Q?xF1nIybYkklCTW0VAsT0snCRd4eVv6NCI8lp+J9CcaR1ogU/IBn3fbFrBAjj?=
 =?us-ascii?Q?g5S/nh1dajRAw4XWwDmKD7b+uoePRvxM5AecYLA39UenzTdt9SP4pYCWVdiX?=
 =?us-ascii?Q?hwomL3gtVYOwCuFanxLU9TzIDtJwPDOLgXmDx5JjENPxZSv06OlOXhGg/3W6?=
 =?us-ascii?Q?vQ4LMKFxy+UWGY2jp42JYb9OZ0nzY0bq6Zi/xS8KJkwSvAzZIX/W05c4BVAb?=
 =?us-ascii?Q?a8XcEY2oBLyT+7af90YMc1cryR9VbogesAXuTtQzw+05Tbsi/2GAfnrpgDRc?=
 =?us-ascii?Q?mkBagXJu/T4IOxdoigRi/72Jl9C1MVbbgCI+ATVm3jYCN4uzfztLT6V5VE9u?=
 =?us-ascii?Q?M6LT5sYrL+wg6MslJMz5smxxHH0VyS4LOy78jsTTICSq9CINIfnKOvv4kQOI?=
 =?us-ascii?Q?im+mQjciNSKDTj+BjbOHzs03Xud7rDNf5UFxjTUtjiol+9wSgPIb7DtXCySe?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2223b29b-205a-4094-2dc3-08de1ae747a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:42:57.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnnHOnWEf51sOI/SqZqgjfOiUX46W3MgEG67y7r3lwyvoEr1PxcnX6DACWEIjxBD5gj/Ebgx1ZxC8UmDRyOm+xQw/jKADVyO+XIDr+hs4d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9395
X-OriginatorOrg: intel.com

On Thu, Oct 30, 2025 at 08:06:45AM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The commit ac98d8aab61b ("xsk: wire upp Tx zero-copy functions")
> originally introducing this lock put the deletion process in the
> sk_destruct which can run in irq context obviously, so the
> xxx_irqsave()/xxx_irqrestore() pair was used. But later another
> commit 541d7fdd7694 ("xsk: proper AF_XDP socket teardown ordering")
> moved the deletion into xsk_release() that only happens in process
> context. It means that since this commit, it doesn't necessarily
> need that pair.
> 
> Now, there are two places that use this xsk_tx_list_lock and only
> run in the process context. So avoid manipulating the irq then.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  net/xdp/xsk_buff_pool.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index aa9788f20d0d..309075050b2a 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -12,26 +12,22 @@
>  
>  void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
>  {
> -	unsigned long flags;
> -
>  	if (!xs->tx)
>  		return;
>  
> -	spin_lock_irqsave(&pool->xsk_tx_list_lock, flags);
> +	spin_lock(&pool->xsk_tx_list_lock);
>  	list_add_rcu(&xs->tx_list, &pool->xsk_tx_list);
> -	spin_unlock_irqrestore(&pool->xsk_tx_list_lock, flags);
> +	spin_unlock(&pool->xsk_tx_list_lock);
>  }
>  
>  void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
>  {
> -	unsigned long flags;
> -
>  	if (!xs->tx)
>  		return;
>  
> -	spin_lock_irqsave(&pool->xsk_tx_list_lock, flags);
> +	spin_lock(&pool->xsk_tx_list_lock);
>  	list_del_rcu(&xs->tx_list);
> -	spin_unlock_irqrestore(&pool->xsk_tx_list_lock, flags);
> +	spin_unlock(&pool->xsk_tx_list_lock);
>  }
>  
>  void xp_destroy(struct xsk_buff_pool *pool)
> -- 
> 2.41.3
> 

