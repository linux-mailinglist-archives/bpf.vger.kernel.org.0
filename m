Return-Path: <bpf+bounces-31871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD75904417
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970771F24DE6
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E89A770EA;
	Tue, 11 Jun 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzapOuij"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294E386;
	Tue, 11 Jun 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132244; cv=fail; b=imm4Gq2NOsV/vGiHklbVLOY+aeiSDw/lPPlOW/1hjpG3SB9Jlw4Aw/Q8tgaSxQRMlDA4sey4HxB7UtjoQgA9vfet+mQ9pJGL5w+YzlijX4tOpx15Y/DgJmW6WLKKvR05JhnUbndB/K/pa/0ngryYOUOSPrkApphhcJkmZkMhNwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132244; c=relaxed/simple;
	bh=aCGKwdzanAOSDTlY1J/42Ws4vVSf4WOfq4qZQlDBF10=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pqR6szeZIQhX0nGtvTaZxivujLFeL/cv/ZERjOns2Ip8Yl3F2O3KA0t4GdUES+GWO0C21ksWe7o+w0lkfSYpkTpIT526unbVGkk2aGJWrNg3SE/h3jheW6AbtX9oIhvZYyQ8dtZUHslxZZjLYAJEMvXCkJiYUSEDGpP14H6vw04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzapOuij; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718132241; x=1749668241;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aCGKwdzanAOSDTlY1J/42Ws4vVSf4WOfq4qZQlDBF10=;
  b=QzapOuijTg0SeLrt+XZsPfMAYyPD0JZGYPI4BLG3ZQ3Jkimh83nMK1Ua
   OGa3BV3CjPAB9DBWG3O4e46FZOazi4bBmbpeBiTf1H0G2Mxf2ygd/cnX4
   eKy/cAU1oAEgUULYF4Qzn6SPWf05IUyQ1N9KDH/y+TFInOHUP1onHXd6D
   UhLLKiqm0ciMDr+gwGy/jaZWgSrnbmZ8p95gl5lBkkDGhC2ARXKDnHJY7
   1+Cuk+DZotVT2sEr658eQNxgKol3wWa6f+5/oU2YZh34/b5VdOL/GqGJ/
   wEPpqH1HPSyDOrN1Zit/w25X2FH5BKWycfEaD47I/t2FFsJyMJjwSwy1b
   A==;
X-CSE-ConnectionGUID: 1EQo72+cSg6Mdju62v8aTQ==
X-CSE-MsgGUID: ukA5NqmGT8+iKf1Kk8aQmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25543412"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="25543412"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:57:20 -0700
X-CSE-ConnectionGUID: MysAE6ZxQu2v0CqvfRzATA==
X-CSE-MsgGUID: CTd81VVEQCqluK7WSX7V4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="43941091"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 11:57:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 11:57:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 11:57:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 11:57:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 11:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LknJqJ9TOa6T9+sQghWJb4InnL+wSc77CbI5t9kl+4/1+WHUZG5RuBmeWlqCDk8PgYdMcML5o93f9XjwK3PaUCrpKRnVn+563uLb0SlJgc12ziOaaoZKVyWGXq9i4UZ/t6oRB0TYZW72Kz/y7xGESy/YDFE+sJznhNWvA7zv4OMXcpCUu6n6r0U4LykjXRxh78pdVKK6cSu89Y2SaBJieUnrmNAUI3F/pQY+jtjP9VEg2GI4pFGadETm06stniezxCIhN3VVXWXUfuxgzILR1R/Fv2P+Y9wOQJo7rpg1yEtni2crTKI79qwOwuzP11agTdwsByaYNOOTqL9MTqAx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgkWit50Fmv+aqlD+3Wb7Jg2n6VKrC3Hu39zVli73lo=;
 b=hYvLgq7IpKvIdS/cWxw150b93aTcls8kq1wFs5B/LQR3QIh+kcFnC+PZNeJu0PJ5gIn9denPziEfGSoNoKQn+7VF2gRa494ob6aaffsdnZPXQ/tlZbXTc0Xi3UB+qMBatuu/dH7bwnm7qUOdGfnoQqp4SJFNI+/S1kMsfgrcfjwLsxj8w9C4LzgaTovCwaiscYG9iN+Spx2UYvowpvpjEeD9oFTTpx/LxR69MKOgAs2/S4bmAY4v9ExAX7aaz9a6wQctKl8p+JDsuHEZLc0Q2XGoU6jbqSk/utQXxCn/1hmnT9Unkx5eJeczgLypDg36coKx5BJItFn8XmVrPXQ2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SN7PR11MB6922.namprd11.prod.outlook.com (2603:10b6:806:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 11 Jun
 2024 18:57:17 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 18:57:17 +0000
Date: Tue, 11 Jun 2024 20:57:09 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>,
	<maciej.fijalkowski@intel.com>, <magnus.karlsson@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Wojciech Drewek
	<wojciech.drewek@intel.com>, George Kuruvinakunnel
	<george.kuruvinakunnel@intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 1/4] i40e: Fix XDP program unloading while removing
 the driver
Message-ID: <ZmieBWzCg1yR7R73@localhost.localdomain>
References: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
 <20240611184239.1518418-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240611184239.1518418-2-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SN7PR11MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0f6166-3b3d-446f-f185-08dc8a485044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006|7416006;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DMiizIZLp3Yq/ZhMS+28EajgT2ZkKtpLYxaoxO69pRhmyn00reBAF4WbCYwf?=
 =?us-ascii?Q?ZCWkAcYkVNGGj1qt9or5mAXwhRFzLDNKHt/xc2izSPL2gXfXOvgPK8SGQAxG?=
 =?us-ascii?Q?nqe0vlb25WPnBeq0wxpkct2D9SOA4MqVgejQKC4wZ1pke0B+6A43UVzx35w5?=
 =?us-ascii?Q?xRkFtQA6Be8yP5rr3S4+kEX103SVja+2fxeMeBSznwvRm1zAPooJtM1Yemgj?=
 =?us-ascii?Q?Q1xGWVUtToClA5VugvAeg3JONRWAhEm7Hxl9+gqPTiZScfYYhaKtYm/DuTdr?=
 =?us-ascii?Q?NRbtUni8VUbWeo7mZSJYJfg9WK1gX3UaqAON/W5IQ8ih7mKQLjbZfCzphzMK?=
 =?us-ascii?Q?bOguNp76SDtlcH0KxRTLc8NhKCZvE+7ICWeV6jrPH203OxjPXM8clx0vU0Sy?=
 =?us-ascii?Q?IK2B3udPEEQIn7SIiiDuLR2ME8Z9K/QNOZD27Vn3Xik+Zn+g/iccBGB+a0u5?=
 =?us-ascii?Q?RJ23zHv+IdMZocA3ArCTkLxvpN1nm6XkrXL3X+UWxITBMvETxl7STPqM95ap?=
 =?us-ascii?Q?wbcMmZZnk0rDvIYfRH1sCzZexxZVSNd5yeKpd378TwpWqRcNLUlKfP96v0DC?=
 =?us-ascii?Q?y5UvTu5HRFw2sS8raM7H3EMV0nXRKXriB0MNu0VRpHpeFw84a8h0L+rVjmyX?=
 =?us-ascii?Q?Rkz6SePkfEUeAwLOmBpfL8nREJADyl3B6zJRgnp/Gn7H1cJ4vIOTxJaCzZHl?=
 =?us-ascii?Q?vIrV0boAFhxJg/GnYlPpMNzskcmLMme1jeQsHy2pDJsy7AJxUbD7/dhYOqTA?=
 =?us-ascii?Q?cSbtyaewHYEv+ymJcTUOABZiA9+qwl8eNa2FNnHtyfxudibxj0AyM0O1wilg?=
 =?us-ascii?Q?WL6Ibw5MdLn658TYdj0B13o4r2Yl42ZdPSQe+AnPndR0/qRFxgHWCTVFastB?=
 =?us-ascii?Q?wI0L5Kg0Oj74TygPXf0dg3lSwY2NmMQk/wNgESgQ4ntNpzyu/bwftv/Gpnil?=
 =?us-ascii?Q?QggMZItWOfeOgMeJn2VHpA7oguQHlkHfDOqLcs8aCY85VCyS2S8eSAtXaK9D?=
 =?us-ascii?Q?nLAon3ioPv7vRQSypMyXwxbvyn+OKsDOF90U2OBmLUpfaNyBlGn8OD/x3dxB?=
 =?us-ascii?Q?1IlYy3x6/dW9VMUfu6NIYTFlQiWuV5Clz9uAIC5hNwD8gbvsY8tvfO/BYQLK?=
 =?us-ascii?Q?QVog7YnIzeDxTbF5N3Ld0L3bn2a84gRHmkMgR2qIVLv6UgkFEOPU0UFHgke3?=
 =?us-ascii?Q?aSJy3/7kpB9iJ66eB8DGYAjAC41Z5rtf0lMQ8CHiHGHeuBeg7ylztTFDgwi1?=
 =?us-ascii?Q?1tR5OC1XHhre9tNZJmK/yJGKo5N/dQ/7GNlowLNb39AezUpyIWTOImGmTwjM?=
 =?us-ascii?Q?iAqie7g9pStYn9+Ddurf2oxF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(7416006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qGdEb5QjEwvjVsx0UjcCUusIUiXPem5w5FZjUJiTFMqGUhpZQQks9VC9GwzD?=
 =?us-ascii?Q?4Y8UGfJq1vH8Bjp4KP8k7iICV1y2NcDKQo803pwiyTrtA1wcc5qCEunu2WDu?=
 =?us-ascii?Q?3HTRd6xXxW8RTSqBcKNFY3vhwBVGl12OeADY/4bwCBRu6Aj1PVfu6rgwqLHW?=
 =?us-ascii?Q?e0zxxPVYEaR045JcfImE3yhU/UYfQeNupDyPtTMbdspTnXkYUj8BwkDLnSd1?=
 =?us-ascii?Q?2CODQtTplPGVm2G87XHooZnqquKpW6s9lEStFlCCAofggo+xUkfU/VQRC8cH?=
 =?us-ascii?Q?yV4dTT2/OB5HU3EI9UQ+lW1p5yQvoD9XzsYiusrfCP86DVjHwmbSX0D4hQYB?=
 =?us-ascii?Q?8YlvmhRK96I0LzIIzm9mH5mBikE1tsX2Mb8RWDqmk4RDvnFLl+scARy+RHYO?=
 =?us-ascii?Q?cjSrV2olOgAFpxgxGw498T85jFaOiiRxnd6dyNBAipQYDjocjHa1e9Y2DNcY?=
 =?us-ascii?Q?GlDtcewSE9cOzrnAZ8KHJf44L620Vvf6NnpTOHwojBMnN0IdshIMiZP6tcxE?=
 =?us-ascii?Q?2IFWf891MlCnp2WCaYgpOduUV1ZKq04y/irIH3cyjcmIM06vxFYqaWrKXSDE?=
 =?us-ascii?Q?1zj26wUwiVRlSjym51Ryf4S3eTIwVMHTq2Yd8ph4mRlEuPONwVV1nbrbpz84?=
 =?us-ascii?Q?JlB6mSltzsROKN7pKIzYSMktKKC2prz+nU5/mBCEUsVFjCQ00UWFhmXpBmLF?=
 =?us-ascii?Q?j+mXVtOXGC5drickgLHB71musY4fEjkiIX+Be4z8L+BNm512yQ0lUrX9JJLA?=
 =?us-ascii?Q?7FoYU7R2+1CeAMijzfd/Ka+x6tBBpeNYdBtb2XmqbyZNFeZeJYG/yf7HhPEZ?=
 =?us-ascii?Q?H6zt7kRXFFsa95OIhKvlp5JJeYJmaWc739dQeZ0XhGfQ8TC2eSwL2Ho6/U1e?=
 =?us-ascii?Q?O53177m8gkyw1xzOyjCYvZ0SRMQ2P5JkN7qS1IMMbiroqdXpVqXxUDh+RhGX?=
 =?us-ascii?Q?zlghvtvKM+thymDt6SrPNQpxjn77pP44p4EjcpTzoMQ5OmzxLTFup49+KVXa?=
 =?us-ascii?Q?AJYn2i4YPCpiBjBGjdOTs8QqTURjIV3SLFbMs93tGJCfa5MhmJtbLcjVE0i9?=
 =?us-ascii?Q?3IqQ85aTsEjSsB8/z+pX0m4qaTmuA1QySlEog2Pu2dDbFgm7u/J2mI9NNY/j?=
 =?us-ascii?Q?sur4aFSisO8G7ARSG/YOp7y4EmPAo0SjgZ86KnsENw6Kf1fVuKUwa6ZeLFc9?=
 =?us-ascii?Q?/c7pJQSBYZHnpO/WAkc+hnYroePHP9PNLhetT8F6gmmnLL6SoTtkbFw1PNv3?=
 =?us-ascii?Q?S1PZO2msRf2BUc5gObwvHPvjrMM/0SlIMK3gEzkhZODjF6INF6nQpfkkyW/w?=
 =?us-ascii?Q?MzGgl6sKOAV8L9wSBbdebtcWhXzmIm0qeZBp6zMwz9/wmtm0rfS0D9fNfrK1?=
 =?us-ascii?Q?XgOfv+WLKJ/U98DoUX8Tj/zmywmiS8Dvnqn1Bsv29EwcaF/fO0QVzVe4oxui?=
 =?us-ascii?Q?btjH3sKM4JcARpsANOgvu1JvxfgSshdcnPt9r66Vz9aqQar4ufHhGZKAaSNZ?=
 =?us-ascii?Q?cpuw984OTsaJp+RVxHtNT3LAC9BxcLbrmhSYjdt8i6ly441INug/pPiInIE1?=
 =?us-ascii?Q?vEsc1EFaXrActYi6j2BxQZaXnMfpZpkGOSyEcoP4cQKW3Ef0b+fZV8jUyXju?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0f6166-3b3d-446f-f185-08dc8a485044
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:57:17.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7bFuymNFn263AQthulMcNtKa5Zu0qCGQ5kaogH7UfDu7NlCLpis8Fdw1mHJeuytvjyRkgpUF3Nnm//UZ5Rcuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6922
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 11:42:35AM -0700, Tony Nguyen wrote:
> From: Michal Kubiak <michal.kubiak@intel.com>
> 
> The commit 6533e558c650 ("i40e: Fix reset path while removing
> the driver") introduced a new PF state "__I40E_IN_REMOVE" to block
> modifying the XDP program while the driver is being removed.
> Unfortunately, such a change is useful only if the ".ndo_bpf()"
> callback was called out of the rmmod context because unloading the
> existing XDP program is also a part of driver removing procedure.
> In other words, from the rmmod context the driver is expected to
> unload the XDP program without reporting any errors. Otherwise,
> the kernel warning with callstack is printed out to dmesg.
> 
> Example failing scenario:
>  1. Load the i40e driver.
>  2. Load the XDP program.
>  3. Unload the i40e driver (using "rmmod" command).
> 
> Fix this by improving checks in ".ndo_bpf()" to determine if that
> callback was called from the removing context and if the kernel
> wants to unload the XDP program. Allow for unloading the XDP program
> in such a case.
> 
> Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---


Hi Tony,

After my conversation with Kuba in a separate thread, I analyzed that
patch one more time and it seems the fix can be implemented in a simpler
way, so I am going to send the v2.
Therefore, please ignore this patch.

Thanks,
Michal


