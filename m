Return-Path: <bpf+bounces-42296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D81069A2100
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F7C1F274BB
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE01DB92A;
	Thu, 17 Oct 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPoAGeyD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2358146013;
	Thu, 17 Oct 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164833; cv=fail; b=Z1KRLBcsw95LC9SQbENwEmMCqdCUVM2X7czjTzZJ/SlZCp9C+Rj64MD2217zHYFIsfDwfgB5gh/jfcAWYlOo/ELYZQkmPUB9uNtmSehy4J93uX1pPyEHzbPUaRbLX1plNMnSOj9aLX0c6HZzddLyhH1MFeOyGDGeRy5mz4BsAFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164833; c=relaxed/simple;
	bh=7D1J7Zm/l434fp7vlVdUIAaBQdakfsPA7mjPMdHGXfY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R7NKui6Z40O4ItpCHiYiqHAPJVJyPzEjkgDY9GMzuV4FHgNFc1EDVwUJu8fA6597f4rlLb9Zihy3lCDfpWVnaHyLbUKn4dyCetLyBFldsD5MaaAsbk36U7zQv5aYnYJx1vVlZjdnjl3z+XQVs+0ljvB5Xm+s1KhJuaLUv9WmBKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPoAGeyD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729164831; x=1760700831;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7D1J7Zm/l434fp7vlVdUIAaBQdakfsPA7mjPMdHGXfY=;
  b=JPoAGeyDeNN+fZS+NO8lv7XecKfT8rl0axfjAJakOt/vYhO3X5iDCAyY
   LPPLuFQeujgiuG8ssZ8mA53CwG2UvGnam+SwauUXsPeTxPB1Jfzc9AysG
   tVBvtPXNndeSRXSoFGLFzIAd89GvdqATnz7yx9QqPJ4IrfHEXHXtTVnTM
   rxJiBa4p3UXBy1f1Ek44ipSLP3eExSCfspxV2fCKccf5fTfVHKw+2RbYH
   8R4xsUzAKTiv0HdGtEgBNkG1eJhjwvB1YwRr4lQxQNY+q0/h5d3xMXyit
   DFpTbSg6pDpZztOHGHG+5jAbE9EP+oihny0vglw3QcUy/HQKwaNdJRH8T
   Q==;
X-CSE-ConnectionGUID: QZhLdszfTRG2OERTXVoAPQ==
X-CSE-MsgGUID: BaEds5AxSC2QmmUM/z7Iiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32330562"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32330562"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:33:50 -0700
X-CSE-ConnectionGUID: icsLvQ7fQa6W+W2d1tITyg==
X-CSE-MsgGUID: ozO5cnR0SrGdManoNUwIRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78561213"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 04:33:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:33:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 04:33:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 04:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3Dn/uRVpYAKBz5l5IdI9Jl12cv5I1kcP3ejLF9u5fdcHjkdsiUNaioQzHMcjeBBLIGobHpA64VDV0H2owrCt9v4P0Ta/5/S/0DErJkYU8Nb4Ey+5Us5DLeib/VnGiZDW2vYOIxyu9tylBanYi/sxDB1kSbZaALw9f5k//qs8TcJ5F7vWwDO1oK9WELTpyY7HeHZg+RcX36NZtex5TdIAABcTuCrF8UaSi/WOPaqG7bofte8vsiny7b1gorw+0TLcsrssMm5LXJrrHCJ1eSK9AwM/hIJWBhyoLpymPRYVee/KRRwCOoAKJ6SImHfelXwB5f+yYh2yGDTkJLV3L385g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlJQkreY0k1bMUJx3A9WIb7pXxn72PMJ3sxzlcjy7JI=;
 b=Vpjs/fj0zRGPf2EAyNU6xdVz2/PJUz+M/A/7QtNyCFknW+n61qfHSJcr58Clxm2jcdtAyuDOJTWtjrkHm0kv5uWNpRRFLOZdqJpNwx69bg3ST36lhLkl+JpGLSyjmQrq2DKufPIaVbLcjPKvrSCMEje3GG3RwiIUOFVMwlhEQsXG3jIm2JBgjMteOKWDEhnG03StOXBNB+4NKLFGrREwjRUX9ZZWgw7KYRY70JFK5kMTotZyQd6DeWjalxx4CoolDbpylfSPBI0kvpsKwGtnvRnZLP/1fHJl8yS0GFc5VVLcFEgRDKQ3mZrS0PZSsifyE1DfEdENFVeL1/zLxLnvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 11:33:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 11:33:46 +0000
Date: Thu, 17 Oct 2024 13:33:40 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 08/18] page_pool: make
 page_pool_put_page_bulk() actually handle array of pages
Message-ID: <ZxD2FJ2rrPoOJWOV@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-9-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-9-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a538c2-bb7c-476a-82f6-08dcee9f9021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g3cOVyPulRIjdbXOtPOxXW/4IlcwDICtsO4JGPp0geDUmxR6D4QOVCt7L4qV?=
 =?us-ascii?Q?843Tv87bnRh+OMuw4owLMK+PtEDKIjWui7NgRwb6eZbP1YeA6rnaSGgasz0J?=
 =?us-ascii?Q?d2jjn4z8CWE1ChQKZsyPab7Lc47KviW3uJQ/2ZlAnyJhWi7xeZ5e5Nh00eYD?=
 =?us-ascii?Q?V2Ry5b1cwNVrFMqjaAmUdlxFeQAPQOLJVkVq2vGdRQN/SUpa88jASI/R85Cz?=
 =?us-ascii?Q?jw1K/ADqoyi253HLOB3tcqzCjz0ofc6x372EgftZmw5YdmPDkwvyqS0b7zxb?=
 =?us-ascii?Q?n8RBHNyG3dwc3l3Dva7+Of6Im7asrWqivgaGtgHk0zTo7JeJu1JbVePIMZN3?=
 =?us-ascii?Q?rt5RGJ2JDhKKbm4XFIkcugq8RL9lBbWnf1ipV8tStrhxquEMYyU3wkwD0fsW?=
 =?us-ascii?Q?hChovFnEfFJeagsBiCeZZMpt56oUWkcKjK4a0KFNt8hh9cqb3nwdKt+1Zfcf?=
 =?us-ascii?Q?cBzCDJofoT1g25zGcVk65xsnfXiBJS+qJToUQW4p1/Rv5zq6+iIqqQDfjX6j?=
 =?us-ascii?Q?ZCvw00K0N4tzkSunS93M6fA2MYSST8WxhNEmSaBOWDmrMsS8GCQO8xOSUI7S?=
 =?us-ascii?Q?ouPjdvczhYu8aGAdZNwMy/e2yhR/9JodCftRPBS2Lskd+6F5lsXLrJobZ5Fv?=
 =?us-ascii?Q?4tXYeIdX4TohqSW2PqBHFAv0Odn+7irTUZSN1cYY/OgZGjbfGegCE60MO0pl?=
 =?us-ascii?Q?gpsi9Wv1Q6N6W2+xF2p/xbfiNSiR+FUqsXuLhM+pJcHaVaTnmy3klkpvVuMU?=
 =?us-ascii?Q?XkcEyduXU2vUxgBuJ9DBw4DL0qMnVUlPMnuvMhRLZcw5xiAxLbeAGTtBIMtN?=
 =?us-ascii?Q?60pEk6WdY5dWjKeLUV5Bc6dvEsnlalpYQMLAxRXBJVE7FMk2VlrodJ/b3Pe+?=
 =?us-ascii?Q?6T6dTQaNHS5Ex+N2DuaBytazNB5jbzVT8eEhH2nuy4FDyH40Cv1cHRvPo2Xy?=
 =?us-ascii?Q?pKPqKX5Q//CSXHAZG/QKZVn5/rhjmcsezCrck5/1bc9XwODdn6MA6BUs1F5s?=
 =?us-ascii?Q?xFVUdiecASdASPiuhX+D9gWmNA+9+lbSOaR1kHHIUN4pzjdUzH6T8NIk7Uld?=
 =?us-ascii?Q?yITZjqqeMUrEUYF16XPxG/MeZ0jEni9hKCzbki94ERltwnzYpSZJXDfPF8a4?=
 =?us-ascii?Q?0RSu5JboVKLCPNMBn+TatfoqGo7haG9H6+HwCiJoJEC9P4Alvh6q2lYATjPX?=
 =?us-ascii?Q?/yppB/h6cLZSqbiCO89CHNgRmJn//ehYUUAT3rel486gByDEnoAfLsbWmdcj?=
 =?us-ascii?Q?wkl7SRiLegJHAkvsKA7TLBpYR4HbdWJJk8BRYRDv+8vv44zXFLMZizOK/6/K?=
 =?us-ascii?Q?FNG80oV7TjBn18Svj+K5zt/5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1bYMrzzaTFjYWBq74LP3PNzz4uGdmUqMzLIBQ/0hsMAr44arzTHH5LUk6M1i?=
 =?us-ascii?Q?8luMzpOkHeVvSCjLCnsquXtpX3Fo3l8nP/6kcUAkCiD78IQwCN+ZUyS0aBHT?=
 =?us-ascii?Q?s0c6v1gy/N+Qve6L5D7hW2pW2LhocB8MmH++2RDAWxxNxF1pv3kxrgwxnejK?=
 =?us-ascii?Q?oz9OPThh9M1S6Fz7aPW8TaN4ewyHmgHsje9utMq9sG3RccNwzcq/W3q/ceFg?=
 =?us-ascii?Q?r8M/aeScoDrfnFFsW1UNdc0RHiIk1FldCQauJU84Rv1WkiIUM6nNBbCzxB6g?=
 =?us-ascii?Q?3X2+f+K0Fh+LgFN0DBm/wjHBHeZhBG/EhmCPIFcTyNoJ6wKIqpU3Qcv/6ZUw?=
 =?us-ascii?Q?2tKGbyOwap97gKuZC0DKN0QO2KyKOaCihxy6YdFA14EP/1+ud0TXDr3tYWVF?=
 =?us-ascii?Q?B10zdspVyw9p7n2NduWPPY9UVdddHYxRheqzrR2eRYeASlW/iIfG9oxxE3UD?=
 =?us-ascii?Q?/xoLhQYtqWbkqiP1Hb+Q0wyHzAnCXd062568MyHjkNBAC6p3RRu9CwLl+6xu?=
 =?us-ascii?Q?fQzDgbgEC7Iciuu46Ay+OZx9flDRsF5/++1lWvRG2OrNjPBZpfTxYvHmmLyc?=
 =?us-ascii?Q?cBLxAOoQQQOFuDETsbgiI1uRzLAvaDckY8BNh5wVHijCYfUn0s6lhD6NPQpD?=
 =?us-ascii?Q?iiRMLM9/6NOvclu5gKNF6AxLfTPS7q2jFPE0aWUG4dYHrXw/od8rZilVKxD/?=
 =?us-ascii?Q?tL0fm1iuRFf4qBeG9Yqy0sFV2ITXyNifw6tBu7CAqLg7cAadDPk+QgjHXC9c?=
 =?us-ascii?Q?LohZPynjeN503WpWPoGaFucg3Iwck6cPzlG33nMbgsdbtOIM9/RKCIN8UyrF?=
 =?us-ascii?Q?14qGxOoZ87DWVnRv0xgaeA/HML4WuIiV7hiImaKLeypfdX5nwAPHhBYMSXoK?=
 =?us-ascii?Q?hs544YHtRGGGNjYiniC6BDAlUfE9uPDkMeYK528vDI0tar5Yx68BDAaPkb6W?=
 =?us-ascii?Q?Q4bKHozRZeCw1OW7zWrMLDS0YexZHdtqXDsQLzLyXGYKoVgwI6zkMT1EouoT?=
 =?us-ascii?Q?dU47P6EAEdR+/DeRunuZfDNCXuVYgph45TDQRLOdDR7rnfJMKSU4JEUDrBQt?=
 =?us-ascii?Q?yFs7+fKLVrxdBj+1de36qO01Uxvn4rIJjj7o3aQCugZuJ+ABi3vakx2ZRUn0?=
 =?us-ascii?Q?H3TrsP0QKqo7jwjuie8F/KZJov8j/WZOZ6Ve1Dcp3g/4TJCVlTy0wYAwXi6P?=
 =?us-ascii?Q?+3SDl2C/ewsC3DE8st7V/GCW457cv3yTwGprb5OSIaqZtBhovoD3pqEIyu8I?=
 =?us-ascii?Q?PVV7J67P4zzo5Xkf85jV5CJTsdEwQXlYrBUSZAI/EiYQeXyxtBBQ1zSqRw75?=
 =?us-ascii?Q?hig7UbKATtK9yFnDW5geQ7H23EtGSGps8/xC8Xrz9S4JLdgtF0zRjw/I1W2e?=
 =?us-ascii?Q?dlJYgI27mkafAJ42p1iXuIiT15usP9oPUj30l0zdeZQmSH8SrhFqX3ZTU7HW?=
 =?us-ascii?Q?l5eonf3riRaEe7OQm1BgdlZkqoXXmyXOGg+Y1Eaupq6OuKuDAHjHbbDRAX5i?=
 =?us-ascii?Q?WSg+Was9BSpc8NWnu/4+83fWp9YDHyLdN7J0GTW1tYjpoTrAqRUBpHeezNq2?=
 =?us-ascii?Q?qHfBcj/xac+AgX4KOFIthTatYUhePH2lksqA40ZxdynpeIdLuKKSPlorYQf1?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a538c2-bb7c-476a-82f6-08dcee9f9021
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 11:33:46.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQNkFbmjQfi1AvKr5NnsdNgTpmQzP1jsYKUmlzOOtalsL5pYRX+KhzLjdo63PAG9gJuCGR5mJtjw4scv3OlHSXTC9i6LO2sNa/W4mQxBnzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:40PM +0200, Alexander Lobakin wrote:
> Currently, page_pool_put_page_bulk() indeed takes an array of pointers
> to the data, not pages, despite the name. As one side effect, when
> you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
> converts page pointers to virtual addresses and then
> page_pool_put_page_bulk() converts them back.
> Make page_pool_put_page_bulk() actually handle array of pages. Pass
> frags directly and use virt_to_page() when freeing xdpf->data, so that
> the PP core will then get the compound head and take care of the rest.

OTOH this one makes sense to me as a part of this patchset, plus i like
that you are getting rid of virt to page dances.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Any small improvements observed when doing micro benchmarks on your side?

> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/types.h | 8 ++++----
>  include/net/xdp.h             | 2 +-
>  net/core/page_pool.c          | 6 +++---
>  net/core/xdp.c                | 4 ++--
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index c022c410abe3..6c1be99a5959 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -259,8 +259,8 @@ void page_pool_disable_direct_recycling(struct page_pool *pool);
>  void page_pool_destroy(struct page_pool *pool);
>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
>  			   const struct xdp_mem_info *mem);
> -void page_pool_put_page_bulk(struct page_pool *pool, void **data,
> -			     int count);
> +void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
> +			     u32 count);
>  #else
>  static inline void page_pool_destroy(struct page_pool *pool)
>  {
> @@ -272,8 +272,8 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
>  {
>  }
>  
> -static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
> -					   int count)
> +static inline void page_pool_put_page_bulk(struct page_pool *pool,
> +					   struct page **data, u32 count)
>  {
>  }
>  #endif
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 3e748bb916d3..4416cd4b5086 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -194,7 +194,7 @@ xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
>  struct xdp_frame_bulk {
>  	int count;
>  	void *xa;
> -	void *q[XDP_BULK_QUEUE_SIZE];
> +	struct page *q[XDP_BULK_QUEUE_SIZE];
>  };
>  
>  static __always_inline void xdp_frame_bulk_init(struct xdp_frame_bulk *bq)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a813d30d2135..ad219206ee8d 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -854,8 +854,8 @@ EXPORT_SYMBOL(page_pool_put_unrefed_page);
>   * Please note the caller must not use data area after running
>   * page_pool_put_page_bulk(), as this function overwrites it.
>   */
> -void page_pool_put_page_bulk(struct page_pool *pool, void **data,
> -			     int count)
> +void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
> +			     u32 count)
>  {
>  	int i, bulk_len = 0;
>  	bool allow_direct;
> @@ -864,7 +864,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>  	allow_direct = page_pool_napi_local(pool);
>  
>  	for (i = 0; i < count; i++) {
> -		netmem_ref netmem = page_to_netmem(virt_to_head_page(data[i]));
> +		netmem_ref netmem = page_to_netmem(compound_head(data[i]));
>  
>  		/* It is not the last user for the page frag case */
>  		if (!page_pool_is_last_ref(netmem))
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index bd2aa340baad..779e646f347b 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -556,12 +556,12 @@ void xdp_return_frame_bulk(struct xdp_frame *xdpf,
>  		for (i = 0; i < sinfo->nr_frags; i++) {
>  			skb_frag_t *frag = &sinfo->frags[i];
>  
> -			bq->q[bq->count++] = skb_frag_address(frag);
> +			bq->q[bq->count++] = skb_frag_page(frag);
>  			if (bq->count == XDP_BULK_QUEUE_SIZE)
>  				xdp_flush_frame_bulk(bq);
>  		}
>  	}
> -	bq->q[bq->count++] = xdpf->data;
> +	bq->q[bq->count++] = virt_to_page(xdpf->data);
>  }
>  EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
>  
> -- 
> 2.46.2
> 

