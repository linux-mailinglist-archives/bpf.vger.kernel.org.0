Return-Path: <bpf+bounces-53829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06EA5C785
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC197A9AB7
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CF225E83E;
	Tue, 11 Mar 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RP2GG2ii"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177D1CAA8F;
	Tue, 11 Mar 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707342; cv=fail; b=AxS3aP/cEKzScnof3SVUOYGmKJ4J+2yjFCn1kXAy2iz6gbUIHGXPXY9kLpCdYYLE1+sIXYu8SvFYu/rEFelI257P3NLUkRjfabra9Vd83Hg1PGsg0h8PVvX6EwxU7fjKsBcVuesT6EMos1S4DuTJtNhcX7DHnNXUzEl7xa912Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707342; c=relaxed/simple;
	bh=t3NcgmB8P5s8TL36glcMfuDDEIINp1d6znIgfHNAf4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d74Liu1oh96IDjHcdyzJiZIdoRIncBlbL5BWtG1qU4L6pJuJhTXFBcs23pkaldsn2Q6OZjnvKnUc9BOgZcVPY+TrYI/XVcMViL4EFWHGEDvyjGk1L4EHgAHnpo2b1RyHzZOJWgY4sytZF8XDre/so7ZvosVreXS+9TLrdarn+8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RP2GG2ii; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741707340; x=1773243340;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t3NcgmB8P5s8TL36glcMfuDDEIINp1d6znIgfHNAf4c=;
  b=RP2GG2iiVKN9Z5LqQs6bFR6P0fl8n+Ijk1ukKRYwRZ43l668U/cvKbKG
   nOTvyrxlrfyBB9qXJA9MqvGzlWJmsZpPY/35fT4q0IxGDVWU7z1prAOJI
   Wss4MEIP7KhRvclqBUXaJ2LnS6FXmxEoZE+eeR5zISf+/f3LWfLpYryo1
   weyO9eR7ULehz22q0hCrtpr/NZurgJYQOfnD+nsXGpisjmaRsFgkhuSiZ
   U8MtLns0QcqQdGT8OqfJZJRjZ1wiOWVlaCtWvy4WU2LtpAYtSqeEBEHMt
   5lUdLF39YPmvjUcSCebHLrxUGNi6wpexBLFhIj88LAUVzOmqUo6lVK/Ai
   g==;
X-CSE-ConnectionGUID: 8/gNGMBvQ2SJkqRq0rXfmA==
X-CSE-MsgGUID: Cb5yVnzYSlCkXRgEJXpqnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46665087"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46665087"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:35:39 -0700
X-CSE-ConnectionGUID: HnF7985UQCyFbhVmnyaybw==
X-CSE-MsgGUID: Hdl+SZIRS5KFAY6SKDo3Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120301643"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:35:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 08:35:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 08:35:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 08:35:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kG7l4ea5rPV4MOisu1JAgR2WK7X1dFSq+CNk2itgW6V+rCMgBXz6bmDWHKSCLP+0fVvZpSQBA1kmSlucKzhw74acYvjlo01M2TsGUpnZ9ElwxibS6PBw+L1ORtgDlRE1mZva5QpbPsiOYm+z9E8gLkvF58lIprvS014Ks//z0HYreEyfsM86b8J5HNIeR8O+iA3YCISS6hU26Cr7cd70yWGv83Sk+luDNuVJJrT3hieHtNy74stQs4fIkxu767WzmgDBC319nKwFZXjeVJ37gF224NHKk/OdM+hT6jz3vh38080umltWwWZk5GioHzUf/7mClGCkd256SRUrasab8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CbuRr5uOqznDRhEOJutfqvfHUJ3x+ysoDYfgWJUqWo=;
 b=VbYD3bQOdypnazL59qLbyi7RqjP12T29p/pjI8NpUWODYZENyVdQB5FP92QlkvIuKxnHMZyiF68SmOGtoeuKqKysHQuEFSZgGHSMhSLNxVe2wtmTRQ8ZLQCjg5xKYVPB1Qku+7yEVIRzyhEOjqIks7DvVhXjm8Ys8ju5ycDZqXFTEaFhK7MT+gl1bcvV1WWIUuvPxDe6AsBegVl3fGtO3P27O5jOKodRuIcqnw8Dg+X2YkN45fKke4uEsZHZj4+xteCuPHGMHcumJ39UGimJWTNiAVMaBwm3UZLtDatZ8WGM/tr26pzqtcANm9in8v+HrOX2+bovTzORs7TP9FM0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 15:35:31 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:35:31 +0000
Date: Tue, 11 Mar 2025 16:35:16 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Russell King <linux@armlinux.org.uk>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Masahisa Kojima
	<kojima.masahisa@socionext.com>, Sunil Goutham <sgoutham@marvell.com>,
	"Geetha sowjanya" <gakula@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat Bhushan
	<bbhushan2@marvell.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
	<sean.wang@mediatek.com>, "Matthias Brugger" <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Siddharth
 Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-hyperv@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH net-next 0/7] net: xdp: Add missing metadata support for
 some xdp drvs
Message-ID: <Z9BYNBaAGZbtbfa4@localhost.localdomain>
References: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|BL1PR11MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fc82ca-0905-4a42-6cef-08dd60b25ba9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CLjj6Dc6Ga1wF166lr+Ybdr3XbWq+F+An5HZgBHqa2Awfu5nPnome8zNFDQT?=
 =?us-ascii?Q?mzGviN9LJ6VdynCcEzclNFbX7Hce0ZQz4hNq1RA7KFr6Ak1JZbaf1dUGmQ/L?=
 =?us-ascii?Q?lzRRpMwjnvB5rvIIP79ioobXtBYpWcornETqkaBLH3YLtT6k5usKUfKRalrd?=
 =?us-ascii?Q?mhrlRPfHbEABCSfVdD1lhr48eGFKWorpSZA5ZjCyypsaF7gTbQphNy+w0/i4?=
 =?us-ascii?Q?6mFHWY1Aa2pdZxldOBbJ2L+33dyfc7qil+X2icEj7ZYkqo4QA/6qBqx8o3Z7?=
 =?us-ascii?Q?r86qSN+1wfPaIzb9tky4guf2GI2huL/dD4pJoy+Es922dq/TBiLm4KgMqAVe?=
 =?us-ascii?Q?jSeFq2qV3gRNS9LUO4V0pGGWpB87EazZwVJ4umV3y+nTs6T3cs0S1pRi6xiW?=
 =?us-ascii?Q?xRI3K913a7oFRcByGRdsGTUFl+wFsk+8UbHYl7mAmuTwIhDgv5txbfxunM0T?=
 =?us-ascii?Q?6D5aMQpa3RorVEJMRte87Po11wurbE3lh82YkmFClnCZPmy/3rH9f82EvOLK?=
 =?us-ascii?Q?pUrls4+YQsKCwaEn5OHkZNmuUVBDxLXN8aMRVveldtPP3/mJyDh8Nh+uqevL?=
 =?us-ascii?Q?cVrh538CDoQhz8NrHXS8t4VYsejicy+uc3ZUQqEYFXJVIti8nq17PrAHiYUA?=
 =?us-ascii?Q?w91YpkfM+7k9TMLCdNtimnysW3HbnLNIcoQFlg78YvEnhz4Wnc5n1jMgc+Ry?=
 =?us-ascii?Q?XPbL2LRIQx7KWZcrapBFStB3X2/7rcPFRBcEwSb2dF9mMESXilI5wDvbHOb/?=
 =?us-ascii?Q?BBoXoofnTeAOU/+zV0FxUNakOHbPfUO/P6ONUATMeXgHX3miqyLyqsgK54mt?=
 =?us-ascii?Q?xjzjnj+vgXxBjp5/ngqbhdVxHB5s34hlJcAtE0CJGOLVBNcNPLoSNn4LfDaS?=
 =?us-ascii?Q?1clBUo48e8BK+uVHWSBTeSpK9R7XPxsf6wJGl29cCxfEO1kAKdbkWf7E6ta5?=
 =?us-ascii?Q?9dAFDn8fODMy93W5Q4kwi3mCzefGq1uWcFCSlDRSO4kwZKqxKL1gzDBl5+BF?=
 =?us-ascii?Q?M5IDv4MowIW8T+Ympq+V73u0BwRLr5ak/9HQyDyv00sTZ1/2HYTHsHfX+zpC?=
 =?us-ascii?Q?BfdZy8qP8Rc8IyCF+cdbUtCdAptK638tD2LAAABBWVDobTxotMEPYX2cWNN+?=
 =?us-ascii?Q?HlFydg9kGBAa8DhFg/WDrsdrgMbJALeQ5vg76ZubGj/Y11GHr26edf14hZTp?=
 =?us-ascii?Q?LYwW4DQD4egjnYAQVv27rGq8Zp4Q45J4mlye33+LBF9QmX32qH2IaqhXx1Rc?=
 =?us-ascii?Q?6F935UVb8yKAa/lrs+DSFuz2euijAW787M9bJZxn2I3FddlTMBmtFcufrstE?=
 =?us-ascii?Q?GFU2X32UrBD516JrIpy/q+ksG2YZrCy8PU0eilmP3z7f2qb4p0cXBkgKc595?=
 =?us-ascii?Q?PBX8rxpOtqTtPOiZqT9uj4LxrSCE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vBpvgWOrtZPOVNVdGUQ+xVVxVVwDjgfJpJF0qV0jq/kGB4V/jhJFNxlCVmdS?=
 =?us-ascii?Q?s00yWBO41gziaZClknqNmc0FCT2bmG7f8+Z7AgpoBrVzpiu1l+Pxus6WBRAY?=
 =?us-ascii?Q?+w0bWdvUzNNOAqB0vJWXEbBPFNqteQIf6aMpNxZF1ObSLV8jQwm6RpKO6yvh?=
 =?us-ascii?Q?BxBQXFYlupKoNutHmCU+KQ4cZt3I3VUpHFfMhgZ8AF358s6tLP1RMS5wJ0m0?=
 =?us-ascii?Q?cxqlR9ZXmYPQ4bud1V1eDo3Nxl9+Qa9UKbTjXSvnP/bHD2kDlVZP/PqVsuNb?=
 =?us-ascii?Q?SbBsAkYGzjW9i03qNGedRDPEP6h9yJF5OlOnn9785XEZYltIDXCsGAtFlmqn?=
 =?us-ascii?Q?FUyLtmcqB6PY0wChHv9bMkCodI+Oh6mQ5j18dNE3cqiSaYtqQB9YP/jgZ+6g?=
 =?us-ascii?Q?yJH6c3XB4ta+uFSv/2ihqoRWCTJJiMr/s0YYWLPo6LQuSnE3NUnV7tGW+LfJ?=
 =?us-ascii?Q?s618a0SnxDTFAQFccpx1mH9+AoELcembZp3GxJcfQICXWn7w9OJvwEI5obLs?=
 =?us-ascii?Q?Qt9b6w8x2KYMJuzeYI4m1Vsz5OwTzk5RleF3IrI4X1jrW0VZhFkkRgX3O0Mv?=
 =?us-ascii?Q?hoPINEZAqnRiwsQ2y3w+bKp69i6JawaNHcBUuY1iRYH2PJeUCgNiuQ4gCvtL?=
 =?us-ascii?Q?ISoedNxu6CkPLQ8XnHqhN5ZR7AK8s5dG8d0gfxvWfGnBGD2AOjYlBuYsKNzp?=
 =?us-ascii?Q?VRE+ycsv3kpfGh9KZZNoM3hms/eXVpeIidS/G+CWS091lUxB7N45D1bDmGM2?=
 =?us-ascii?Q?LNNSJ4nfe7zL8hjK4vQGEfadcTJak9rZZlCc3nT6r+W6+Q5vDxNL7aZpnY7e?=
 =?us-ascii?Q?LzeC963czubwD1GuLAO7JvNxLRc511YV0V21kj/WEBkxYYsOGR+o+33FQGKs?=
 =?us-ascii?Q?jmSmgyLuq7AIryrxxXXd4gni7tyWTaeT53RMnz0pi2/Sc8JJoTpygzOoQ/CN?=
 =?us-ascii?Q?XqiRUKMRo4OW5FxeBB3QsntrQvoecPm32EJwSS/RGYmQgSKRW54pFf/50yjL?=
 =?us-ascii?Q?uXYfVyEFxUePg6hnJMT5PYgGE/Gzt4w/dwiX08meWiMrHOWfqDVtb4Jin1zc?=
 =?us-ascii?Q?8h8vTCqiGw0IruR2VL936oygCm8FsPm5U+SkbGmQNV7eKo8tcTo0EGAAj1Jf?=
 =?us-ascii?Q?9xgwh06QlPMmsVD3kboDYsiONr/FUBoRRHZb348JFPZZ3CvORt/Z7TK1OOni?=
 =?us-ascii?Q?Cg52FmCFdXLncTlNAxQ73GbMhjfHLK9RdSe3fMDAKrAGA5TkIZuaaDTOA39T?=
 =?us-ascii?Q?jPgM16PMLap2qAYHLMET+KOeo7Zamw3LNSZjhLmVppyanI77ijmJNtp5Rxy/?=
 =?us-ascii?Q?f08gpIfuJZUTVC9BqjcX8i4Qj4tLvDe2LoyUglC7cSQNfdhTPsHnJWF1s8zi?=
 =?us-ascii?Q?xYyHCCnI+SESbOEkahFYCBLyTk/bzaKRaG9vH6c8dx563nW/gOmcGoJHXw/R?=
 =?us-ascii?Q?DLzg+4PLZTlE0Z2KGJYoFlKvFuFrvKGkJsRyLYbZberuBF58BxW7Au5EKF4y?=
 =?us-ascii?Q?hl7ytWdJZxOobwwDpn9P2vn6oPEZ0wCRk56vkOZ9rwq/b3BUbiDFkYonpSfv?=
 =?us-ascii?Q?5rs/REI289piV0kqaadrrtQ83ianz0A91sjlV2Wu7sL4Smcz7iAWtF/rS77l?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fc82ca-0905-4a42-6cef-08dd60b25ba9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 15:35:31.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwj5tEVl74AeBerd+4hB7Pg9UDDSwEsb1JBDPdW8JnpX3SKqTRz8RxtBbY8uvCQaXARzyav2CkSSoakp0Hj28A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5978
X-OriginatorOrg: intel.com

On Tue, Mar 11, 2025 at 01:18:32PM +0100, Lorenzo Bianconi wrote:
> Introduce missing metadata support for some xdp drivers setting metadata
> size building the skb from xdp_buff.
> Please note most of the drivers are just compile tested.
> 
> ---
> Lorenzo Bianconi (7):
>       net: mvneta: Add metadata support for xdp mode
>       net: mvpp2: Add metadata support for xdp mode
>       net: netsec: Add metadata support for xdp mode
>       net: octeontx2: Add metadata support for xdp mode
>       net: ethernet: mediatek: Add metadata support for xdp mode
>       net: mana: Add metadata support for xdp mode
>       net: ti: cpsw: Add metadata support for xdp mode
> 
>  drivers/net/ethernet/marvell/mvneta.c                  |  5 ++++-
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c        |  8 ++++++--
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 13 +++++++++----
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c            |  7 +++++--
>  drivers/net/ethernet/microsoft/mana/mana_bpf.c         |  2 +-
>  drivers/net/ethernet/microsoft/mana/mana_en.c          |  4 ++++
>  drivers/net/ethernet/socionext/netsec.c                |  7 +++++--
>  drivers/net/ethernet/ti/cpsw.c                         |  6 +++++-
>  drivers/net/ethernet/ti/cpsw_new.c                     |  6 +++++-
>  9 files changed, 44 insertions(+), 14 deletions(-)
> ---
> base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
> change-id: 20250310-mvneta-xdp-meta-3e0da8ef4498
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>
> 
> 

As far as I checked, all modified drivers use the Page Pool and set the XDP
headroom. So, a necessary space for metadata seems to be assured for all
of the drivers.
In summary, the series looks OK.

Thanks,
Michal

For the series:
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

