Return-Path: <bpf+bounces-64334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDFDB11AD7
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16106168BB2
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293B2D320E;
	Fri, 25 Jul 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6y0vqw1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23602D238F;
	Fri, 25 Jul 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435832; cv=fail; b=bRSWfvhthL7dunZgukSnEMsFxRXrnLTf2na980zflX2mbQN9YtQBZlaeyZ1gs5zBrYWDXSmnEDti5f8E6PI2Ht6kklntmW1yAj12yOUi13F0eRppEhRjuFPEHrLdVMg0UctDvr/D4QEWF+xCQbTjDCmE2Lz5m1hQVOntBXjHgD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435832; c=relaxed/simple;
	bh=LE8vA6PeV5GYeIYZOKqEPVo/qh+ztI5mzFyIHXHeC+0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n/LuTMptoK+AkbaNOctvrDgWQDDYjnuRCfUti4QOGOBQvSoBXoRjmcLy/67KIMk/OL/vTOd0af2TxeTIpyGzb+t2K+Fp4tp61a+cF9P+3XsF08SDCWcLGZ6dkdKphJBh6CRhxsZ7ZPD4x92DjR3qImCsgyanoe07Q8eC0V278Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6y0vqw1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753435830; x=1784971830;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LE8vA6PeV5GYeIYZOKqEPVo/qh+ztI5mzFyIHXHeC+0=;
  b=Y6y0vqw1M79cIfaYFsHugRhf6WaTHpuSQhssZljDGRjxOmVVljodO9Sq
   SOFDs37fN9wbh3K9enBww0+TuZ3/CTgjcjv2arJNmRL5mcdEO+dpp2Sg+
   pVXsYeIqr3sIrgKyepn7E9Q8O+wI+mNx7fIlcYri0Riziz/QfX3CdGDpc
   vpyJkdyR9E/r5V0E+b2UDW0JtC+GDPJ5mz7Uv2XUuI2GhTZrfGlMqW7zl
   evi5p1jEe2MySkmtGlUTXEJpkkuh0rRMVr4/WHk/oe/ePUi2i0gAyayg7
   TtpR2UckRY8EPvMJnsNmew/nt8X0xTC3//6olsVeRyBwcbgQoOwqowk6u
   w==;
X-CSE-ConnectionGUID: hxTIwiULT52qK5v8xlzKhg==
X-CSE-MsgGUID: MfY5myo7Rc21QDMgk6j2xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55707607"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55707607"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:30:29 -0700
X-CSE-ConnectionGUID: DiWlY5O3R3aSe4Y0CSLKpg==
X-CSE-MsgGUID: emyn8ubRTCuxrgrgg6MesA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161094603"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:29:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:29:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 02:29:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:29:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIXRwsiqLipyBrWVUrWI08goPZf9zCHAd+dDSZev5r0hhlXMqI6ujEro92SvoOT0IgLI34KvCuNSTX4U6j+UJlg22hjlC3zHB2T5HaUQOiMIUTxd0of8wZQPqZHH6th2gTFWwpD3j8CI53XH1OosJ9k6rQqIr6jYI1efLGSjU4/JMksMbCy/VuQ1oswmCD7s2GPO1u776qPOjnPa4DVxuXD5XG+oVRfVdyeAQ7PJB/X8hk/FgFcEYltltaY0+CkGw/dbm3Aqwfo+AHoR9q8V2GDWbNAkzcFVP+dhMulOHjSzjDic+0nfkifDWbzVOJphf2sRah6iofAasOQgdUoL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qr2EjDoTY5QCF9LIF2KtTiVNMXMbHbONs3ObBznVeqo=;
 b=Zd9Qw38ThOONEBV0NWWM1cykUg5QhnLzrYpXVVTrTQjAQoMVJR19MilOGqmDQKnT2RmRmt8GA2fjz2GMItuQ6sMcyhF8lZe7WMLH+Z8AMq+Hyq/B4o3nYNWCzUsvd2CUu/61PYXoRz/Mhkm8rJBMJ+wajKgj+iFOPS/Xv4Ry0SC9vW14Yz5ybj/5VyHOSVA9dYkWDnZWGgZaSDoopNEMaL25akzpUy8MOKXejIbD5RhW+96sslPg9bz9ukBRfpuJBSjY7nvba1J2sg40ZR0xdhLOdn0AfP52+nOEyA1c6HGYZwuiwql/OeLkR0i+D8QfjzErKQdRStFx6lyAYxGYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 25 Jul
 2025 09:29:26 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 09:29:25 +0000
Date: Fri, 25 Jul 2025 11:29:16 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 2/5] ixgbe: xsk: resolve the underflow of budget
 in ixgbe_xmit_zc
Message-ID: <aINObNKpAzZ0amz0@soc-5CG4396X81.clients.intel.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250720091123.474-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: e966c5d5-98af-407c-de8d-08ddcb5dbf26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p3X2MGMUm1+G3PbP+yYjPHikBi3joddij+qmB7sO69dFU5meCdUct+UlBo6g?=
 =?us-ascii?Q?2SFQmhWEoH01CIaBQ0ch2gb+kXcmpqtt5dT5VWpufrlLt16xgvh2xqq8RIOi?=
 =?us-ascii?Q?mBY6gw/u2REx7d0VFAV+6LyTWgcaztvuT0QgbfMWzlcbXdBCxVrHwF7saIs0?=
 =?us-ascii?Q?LRQHY045rzd2vNIqr2RlwmtfOZ0b7kbX7bn5GdgfmVOhMfAhr2gt82PDKCax?=
 =?us-ascii?Q?+hJdUiaH0MB2HB27nCfMiRp5y3sMbmFrpQ96EI2DgSBoF4Tf8Za14KQj8NZr?=
 =?us-ascii?Q?RwUjPNCZZNY9CilGT2yWAWBCX7kotOYWjLtBK9wJbbvY50e+f08phzKP7Vt5?=
 =?us-ascii?Q?VVzQe2+NHXKQgVHyLzPpGT08ipgtRzbZOJsGP7m2rzwoyMxj3eBl0Jh7JqJ2?=
 =?us-ascii?Q?TsT4bpxz4kSXuJ6rzFwKuf1v6GmUUVrtXDqS0Ifsue0nPbuegqop3BAgQc21?=
 =?us-ascii?Q?BpFT36sGPPBF4hB6LdHZE38/1agsbQyA4pHulfjt79teDZm4F+1Hpig3nhYO?=
 =?us-ascii?Q?/yetJ5ntzBUeHsCU/G1fZjgQCY9fkTmW7rhgD1NI6hqvLn5chiqWAgO4FEPy?=
 =?us-ascii?Q?upopzgS/Bdxe6nCGKRnnQ7fdiZ+FnmhqYfFkSTdR3xjssensC9kOSyzexn4F?=
 =?us-ascii?Q?zxpR3f1waxgI1myTF04nIDE47+ivyRtTjpz/Wkr2IpsT2k5EnwlaiKHRx/sl?=
 =?us-ascii?Q?Q+o8T1ojdPNIIgYa3+ZMsfU73z6nySEWwkOg40w90YwCqHJxiuUwUrchSmg3?=
 =?us-ascii?Q?qUQrRnapJERdhiiMJnjukzwN15/h6bh/XMTGLObNfm4J2L6vZjj2253v9pAJ?=
 =?us-ascii?Q?U0spXEcRylkH/6C6W6GB9Bijkzc/MjF+7yfdENc7wiZucecx+HfKDFr+C/iI?=
 =?us-ascii?Q?awSYoHHQKrJmB69tf7ndhb1vthomUIYQIhCU6TBpJuY9J8K2f9PSEgAfAdO9?=
 =?us-ascii?Q?rEzWb5cikIzjh6jNQfarlqrqnhszW2Ip2aHkb/WGT3kJ5WHlbxhCXVoSSiWr?=
 =?us-ascii?Q?t/AjJfEE8cWjAT9h55YHjMnAzgeDD8CXrT3oIz3FUFwYwNUuY5EPkAHLWw+y?=
 =?us-ascii?Q?0R5xdTi5o8R9805x6GDVH8PwRyAe5ENQbfNAAK2q3mnCMp8g2amZ27LAQldX?=
 =?us-ascii?Q?iBthwWpoIZ4uBdSz/O63You6y+FXGaLvtEIdLeO4sq75ZBdh7zZr3I1DfO1u?=
 =?us-ascii?Q?6cVmmIc4XBmLdvxts6/500Nn+pcSXrZz9YoyU4nbBmfedBy1Dc+gCqLq+omX?=
 =?us-ascii?Q?ONClCwH2jUO5pPDoH1fupdVoDD+ibe1EZQJ6xT5GwA2vY+w8ekb7UU+ezJfA?=
 =?us-ascii?Q?HvFOQUwBT88ycDmsdnojWb+/jPg096BYU7NOu1avBpH8pNsulS1IrBUQ6bcu?=
 =?us-ascii?Q?lbzYYqKRNV+Bw2PVTDVupSypmA9itGaDIf4a2jF2sUsGKdj+kV3A2xFpxYUj?=
 =?us-ascii?Q?guOvN7ruzuU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tt0gHMQldK4QwpiWg98jRePrXCNZFxrultbyd98np1LhLhIRJT2R9r7uAIMo?=
 =?us-ascii?Q?Tuq34/LTG1x2ifGoOAODHLMqU4iv1tGsE6gN8tH/DsFXNcwUA87buQOoRY1B?=
 =?us-ascii?Q?rFOpHYCyP/n1iA3KvxCSTUybp5O1Al8hGkTFCHZ8ixJRlNzg/0P6nsC7UAmU?=
 =?us-ascii?Q?nXBoVlZvJAi2h6A9H1af3I+lmhLpgvCokdvbXmGitmR4tYRgIIqWcYzN2ecX?=
 =?us-ascii?Q?kSnEKDm2jG0erEcazMglICjP3lqscKbRKqbYy7TLtdL0CXXs0QpgG6DvS1XF?=
 =?us-ascii?Q?G2BRGed2NxFbzBfCU6PjQxZ3vWXnuCP4CJKthtm97C6VIjc3mWorC4GBeVdI?=
 =?us-ascii?Q?7Bt2OAFRBC/V+OuIwnfdU2FFVAoShyf7/EFRiRLFcMzEqg+3pgvZY6bDozB2?=
 =?us-ascii?Q?IU1LWHYB9nZ9r41Z0e8WgQVMW1dM5frLkfvVOnZu71+YeXiU3GG0g8BqFZYs?=
 =?us-ascii?Q?pfy8xh6jeELHBEL0oGVccFgar4XE1erPycz7wFYALKRJ4Ikq+aidR1NtNFAv?=
 =?us-ascii?Q?QfD2mz3ovBBeGMDybLBbeCump9dinsIMV/ZhX/HE06eLg5mpd4JpfU8fyItE?=
 =?us-ascii?Q?wj3JMqw0i7TXe64PmEy1N/73uBLjbn9XmQAmvFglTwi//LVIvh/HJRjbZSTd?=
 =?us-ascii?Q?AnNDGUONh5EyeMOZm2d+9eb4nVRtvDsIXOcBeiAUTZxRXAiuWKe09NnwJivN?=
 =?us-ascii?Q?sFnvOFGLI+S+8rXFh4ekGzsuHbFbQOG8ykGC12ySjP2Bu81xsbsD7ESoJokU?=
 =?us-ascii?Q?86yOwag11u4h+RmVl4YF10ObT5gA2XqEnrVpOTjV4EWO1HQuXsqFRcwvQeAQ?=
 =?us-ascii?Q?37k3zkcjghNSwHhVGt4Dx4vknxCvGifHaxi7yliqUfjqnYAv9vRW+AcP3AeD?=
 =?us-ascii?Q?BMod9bF9Xw/DtLfR9dIO8x56/sP1X+Q0xBW5+yHYGbVHrTCISzu1K47cV2wQ?=
 =?us-ascii?Q?V5nRBTa4rDPIBtUrn2ja3uP9ABe8CxkYxg+umXNRWBEDJlnt/IAwYOIk7C9s?=
 =?us-ascii?Q?OiUKS8q/gwBoDxiHQ/58G4iNjrE7N+O/X0XJDLF98Nt6FC2VKV01DDYfS/cH?=
 =?us-ascii?Q?Sk7C5uF0lZWEO8ftd5/U1ygsJra2O+Sr6u4OcPuQwq/f6J1/IH12U9tnLPS/?=
 =?us-ascii?Q?CCFbxCnFyoCA51Fr868+McftbcMoCs9lCNlOqKpsPCLaAud06dPMSKzCHaPA?=
 =?us-ascii?Q?+8LoeCpATDMqKY0Oen0vj8IfMvLKxTn5sH8A0xXYAPt+7WTgaaFElk0UfOD7?=
 =?us-ascii?Q?EGQlyuaaKtyEXKTT4Nw9PiuMxA5qWZ0iaLBeWiBcaoHMg/sKw0lNBkAmWqQC?=
 =?us-ascii?Q?RiA8TbcFdHhX5g1kgXVNaLqcYnInyPbvoGAMJ3268rb1oQcW6fNVyb3cs1hF?=
 =?us-ascii?Q?h2rJ2hc88flVJFyDRk8eI1jh46UJtxfce8G9DWxhpzr6HBeIHcBJxCSytkkR?=
 =?us-ascii?Q?coseHpxy0ciPGoTWFGdOdGEeHT5H7YOmTyBmwSHMqg3YLlBknBMM9ewy52aA?=
 =?us-ascii?Q?8Z4P/wroZLU+gOgNJzcRCahLouk1fsoBZkoM3XqgxcQKq3Dgm/EIzzvUn0in?=
 =?us-ascii?Q?zp9yDlQlSCPsfzHM34whe4louXiOEJer/95Phy3kPtkGvYFdWnNJ4fYaigeh?=
 =?us-ascii?Q?S97nd20kPXW6OfJP/hsdR1eldxxgKUaZQ4e9GZT7mqL+ITgMU2X/CIAFQcln?=
 =?us-ascii?Q?xos9Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e966c5d5-98af-407c-de8d-08ddcb5dbf26
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 09:29:25.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: br04gdzu/5veldiKn13eVnrq7RR8ePS6uiGl2TMz1U/t5EQu2wYYliVLSiHyUe43JknFYXRspwF+avw2QAIenI/p4W1hYPPe8zzuYjYDHuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com

On Sun, Jul 20, 2025 at 05:11:20PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Resolve the budget underflow which leads to returning true in ixgbe_xmit_zc
> even when the budget of descs are thoroughly consumed.
> 
> Before this patch, when the budget is decreased to zero and finishes
> sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
> and enter into the while() statement to see if it should keep processing
> packets, but in the meantime it unexpectedly decreases the value again to
> 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
> true, showing 'we complete cleaning the budget'. That also means
> 'clean_complete = true' in ixgbe_poll.
> 
> The true theory behind this is if that budget number of descs are consumed,
> it implies that we might have more descs to be done. So we should return
> false in ixgbe_xmit_zc to tell napi poll to find another chance to start
> polling to handle the rest of descs. On the contrary, returning true here
> means job done and we know we finish all the possible descs this time and
> we don't intend to start a new napi poll.
> 
> It is apparently against our expectations. Please also see how
> ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
> to make sure the budget can be decreased to zero at most and the underflow
> never happens.
> 
> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Right, it is possible to decrement a zero in the current state of code.

Should target iwl-net, otherwise fine. You could include info why do you add 
likely, as such change is questionable in something that goes into a stable 
tree, but should be fine, as the standard budget is 256, so we rarely would not 
hit the loop codition.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index 0ade15058d98..a463c5ac9c7c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
>  	dma_addr_t dma;
>  	u32 cmd_type;
>  
> -	while (budget-- > 0) {
> +	while (likely(budget)) {
>  		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
>  			work_done = false;
>  			break;
> @@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
>  		xdp_ring->next_to_use++;
>  		if (xdp_ring->next_to_use == xdp_ring->count)
>  			xdp_ring->next_to_use = 0;
> +
> +		budget--;
>  	}
>  
>  	if (tx_desc) {
> -- 
> 2.41.3
> 
> 

