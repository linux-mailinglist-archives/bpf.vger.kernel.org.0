Return-Path: <bpf+bounces-71436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D27BF2D01
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 19:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D42C4F440D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97463321D0;
	Mon, 20 Oct 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXr4dKuD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E223321CF;
	Mon, 20 Oct 2025 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982821; cv=fail; b=LmhzM78IknKYhdcseEkQro4DWoeCu9/bfBplTyAxWE0ifaVopf+x/g9JOO806d0Vw+7NH4ZJndOX5j6SAKxPup9paBs7do6Jos0S+X9KrCKmttBKpRTM5fWC1vMKNNozYApdyIALeRK1GDdHe4pyVBENhyOWVWybC7yH+VVV+eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982821; c=relaxed/simple;
	bh=YvI/zQpQ2OqGp9dC9hZwnbhlOQzyJsRrgQyoptCMj5A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Egzjrk8b9E0v2ZehAcbenuN0vm6IcJ5Gut9oqW6Io8HD1QbKg6ZqSNpN4oVPzgPqsJcL1Glq+zbHKFtiJ/CG7Tw8EOYGd0P3q4JGIj+KclDV6h7lXImiJSY89NFfaMZBS/osFKg2rYToBO8sdQ1Rh63pyPpPTej0FhOinfFZJo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXr4dKuD; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760982819; x=1792518819;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YvI/zQpQ2OqGp9dC9hZwnbhlOQzyJsRrgQyoptCMj5A=;
  b=OXr4dKuDSyShjWnH16/FF6+n4zKXceoqUrPrZv3+nYpc5tzr4wfkEbto
   mnOy5CtQWbR7ZWcZkAOGk+IuCke1mXBsGaAmUa3da0ch+2sV5D413MdJ4
   qBr/ta4bLRvdbLTuVD9lrhgSfBpJOXPSyI4fxgy2QeH1viDoWoDPopJ+T
   7ElOTWnhMfAdOoazvb1mS+Qmawn6Og7hAhXOtDfGBMrkODwbuwhDl9A4t
   ad0lfcL64JmNbxJRie9UcG6bn01zFbOorUbpFnlv9wbvJSrK4aAe3wxZ9
   FXKv6S1ydAgYySkVq6j7jlcJX8qGAXq6Be+/PLj00RGo8AqkngBV4GyIH
   g==;
X-CSE-ConnectionGUID: ak25XaGXSQONlxCjeU2y7A==
X-CSE-MsgGUID: P1QZP2iwRba2qNU41ZR53A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62311457"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="62311457"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:53:38 -0700
X-CSE-ConnectionGUID: GzJEAmXcQaOoTwrxrKuQZQ==
X-CSE-MsgGUID: dn2uIeRcS3eVojxPfBO6iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="182573550"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:53:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 10:53:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 10:53:37 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 10:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amoIPO4DZIWjgn45tpQ33jUJivkdqWuBqWMPpY/iq3NER5Dt+ewjrN+AHezEddRJ3nriLOQTwf8dfiv6DQrwIgAie6JrBSLEa4YbqU2NjLTUfb1ytvuoTwifDIWAp0M+58fpqpsrKwweAXEEEYKbJWQxIhjp00vRAZBDnxu7XqVGBvFhr/C7s1rn5CEUlafc78OJl8S3fsDAvyzDXV+vt2ClyjWcejVpel+VKXU0HAsVSB+6Ghbl7AbBl4vkJ+ezfV7yAmmJkbw29Mq2+FJjJRhwnpWoQhTSgQ1TkTNUGrFZ7LRc5dBlozpgBXogJq4Y9/mMURhsCHDrnU3RB8NpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=craPWY8zQdvKiw/mfK5LNFomHx2jWh5XgfYQWvnBIzE=;
 b=GS9mdPMNI5nNSMhYXvXO7GX47VPScxMs8MleQE74Q0a6W82Qp0RW/uU4GJ5smAxXTpFq8jfF0rP8kY9M5f9MKM5buJYrstgTxfAvbq0L89LBkpkp48bXYSSMWJmNcNxwxYrOzvbHqn+udKzhORrpiJo/0IDT+igdWsZM+H8WESgInSWBwfkUu8Wmb9o348htDVYtbB8fFbJcfa0Vsf7feR54pVinVzRVRGspSd8+oluTwnjRH7spT5YXPIlpyJKZfiKkcCxTxXqMKRhz1yzqjRVEVACDW617tBx3oNHqGJIwlMzUNBlz6pj9FFibjixFwG3PlZvqBXuJdReKCXNfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH3PPFB8E59DF50.namprd11.prod.outlook.com (2603:10b6:518:1::d44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 17:53:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 17:53:35 +0000
Date: Mon, 20 Oct 2025 19:53:26 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <ilias.apalodimas@linaro.org>,
	<toke@redhat.com>, <lorenzo@kernel.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <andrii@kernel.org>,
	<stfomichev@gmail.com>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v2 bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
Message-ID: <aPZ3FvcIVOPVxQum@boxer>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-2-maciej.fijalkowski@intel.com>
 <50cbda75-9e0c-4d04-8d01-75dc533b8bb9@kernel.org>
 <025d2281-caf0-4f88-8f31-b0bfa5596aec@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <025d2281-caf0-4f88-8f31-b0bfa5596aec@intel.com>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH3PPFB8E59DF50:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bfb5ef-f162-4a93-8e9a-08de10019727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?EmdJLrsAs0ePGuPQoopta83lraB76V11m8aFr01w1KhwKYaLETmftsWx2p?=
 =?iso-8859-1?Q?hm8kBKyCRoY/7rXmmCEtu+nGwpJMNHZqLocuwJbS39iC+duh499P9hRvJn?=
 =?iso-8859-1?Q?b1eIB0IlWDuEjxEGoojDpYioq/1D1M/bP/zthATenb3+ParaHuxTJ2HIX2?=
 =?iso-8859-1?Q?59U2s2/c+SrF8ppXNSe+wo/jx1arjUL92jV9F1SgMIBPBTsFw/s/FkGp2Z?=
 =?iso-8859-1?Q?dcdqFDpvwHbpAVHSg1y1iC8puGmniHDwb2kLvOUvVtzXd7FmxSifGwCc3u?=
 =?iso-8859-1?Q?eTuzX3ryFOFsbMBnB0esoHhCHv13Sv/aTTC5UocEfKmYh/QTlf5K6p4ub3?=
 =?iso-8859-1?Q?UJoprwI644hMdxAnj9GbRInoPlKwigFUGTozUgUMHACdeSmeumWZZFhdwt?=
 =?iso-8859-1?Q?HV0UNwhwZl/sI3YHP9PTtja8MsH2vhPEfYgWASjdSMTtO2/BXxgDdcZs1/?=
 =?iso-8859-1?Q?BzYC9wM5PscRiJ1BcQovrjEkZ74ccP8NH9Sdu2o7xRHx7Wk+1RfDVD/WLv?=
 =?iso-8859-1?Q?bYCw9f7o+fhzhnD+SaqagASBgNXz3PEHiwZxmfwiPeh50kLe4RRLnJiewA?=
 =?iso-8859-1?Q?WEYH7NPwGrIrpeacTQJdx21EH2/cV5hrT3BmBYBHbfX3OqKggYVbTMb765?=
 =?iso-8859-1?Q?y0LrCktTVeV/W981NOLCQCbprywnF4z/4XGb2d+81PnNyU9iZK1hTy6+lG?=
 =?iso-8859-1?Q?EFopHF7tD/kzlRO3YPCpP7LL0zI5+MpdcDpa2swqWu8faZ1qSUhwAoj/F4?=
 =?iso-8859-1?Q?l5sp/NRc2vwxfyBWxi68WofXDzGyqNfg9Ah8Osp8r2rISQtIqR4VhxHl3s?=
 =?iso-8859-1?Q?OS/91RxJduukXdxv3jfihrUi/AgIszlK/aeCYEko1xH6Ov4/xfBWxnvQ9C?=
 =?iso-8859-1?Q?+Adyogu6gX6GLXnRNXfe+IGzKIAH94PSsPOqEtUlxRJma7VlUnVVy2fRpy?=
 =?iso-8859-1?Q?U4NZpLJYxlmvnOE8CaA6v5n3tqEC3WphyoabmNIAZE2bg1nzzgbyn8Z59U?=
 =?iso-8859-1?Q?dECQ8u8Q745Bx2Fki+RP61wiwCJnsW/uoNlMdkYeREayus9voOBHLeYEC5?=
 =?iso-8859-1?Q?BKFkDmqOJiec+PdcYXs+WNWcc9wTyjykGAusqqnLLipZfsdytko8AvOehJ?=
 =?iso-8859-1?Q?+Lc5Yz11a5Ljh45ijhnhtaGHfCqt01XpRUsRRlSnvfcQf5/GpNV5TxmlGp?=
 =?iso-8859-1?Q?kL7RJHYJn6wsnulPB4IVhFy61anbCff25x0/2fGFOZBzVW7Kp3wbxoVh4A?=
 =?iso-8859-1?Q?vUxbQHIql7bAFh3XhWZ4f8s6X5vdkaqdpTcQdBakf2l5ObCKmBo8edopaN?=
 =?iso-8859-1?Q?AQHLxMJbhu3MyOPOe9EwQEzk97nC7wrl3PrNkHAFI+Q9PiSJvPJ+7akx3R?=
 =?iso-8859-1?Q?GBOA98Gcml0Qj9/Zmw+zhCWRMAO9EzwEwATkoiEk9YXQ4aQYt/oqNwa/Xc?=
 =?iso-8859-1?Q?O7fBIghL0L+Vs6rcm4IWAVHaBGoY3+Zl3hKqzfboxpg0NvnWtnG/BEj68k?=
 =?iso-8859-1?Q?lr3I76KxTe0oRtumcnlVt0PkUDjcX1T3UoEoqhDyEZeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yMPuGFj4chMXwqbJZd6Sf6SS73zQM5Dx1hgBbl5H55Glxoh50SskFgxOTI?=
 =?iso-8859-1?Q?TdFkverda6UzrSHsQ0p6raZC9U1ZFrD93Nja8Cp/78R/1uLtaHD78AQCpT?=
 =?iso-8859-1?Q?0zjbIiKVHfEBhK+bTm3PjhYXF1QF/NEidQ0k/fgSUA5XgNoN+16/oynD1s?=
 =?iso-8859-1?Q?BOhhA9hwLUHbp4PanfGZKKeYGiOZB0QvB0UufGBtgsEfzBAD7cPS3wgF4u?=
 =?iso-8859-1?Q?V8QMVGd7/4FXQweagBPewlR0iFyzMdSHkalh2fOYJrjbgZClIInoiCcgoJ?=
 =?iso-8859-1?Q?Y9Nllgbyg0UIv9yiePhWhXZRZ6IpqHR6+gqPPaXXe12WlPiIsOJpZ6iNW1?=
 =?iso-8859-1?Q?GjPImozROlgIDyvLG4DaAenv9lcivoPc9Ddr6483gDCJWGCY+FhUjmX9h6?=
 =?iso-8859-1?Q?ye9IKdqSP/Ral+pXumXuoXiWCrvRAvncGaR7NwT67BoG0/lnhR9LEOx27D?=
 =?iso-8859-1?Q?AHvshsiFXlSKsFSdfYeUFOpblKntGiQYqIkRKE7n73n8Cvq/uU7ITb0vrg?=
 =?iso-8859-1?Q?Rj2C1lKcZKK0h9bkvrMnb7NAFCNLm4ZgHEhtct8O1x280aiqP9Z2amq0n7?=
 =?iso-8859-1?Q?Ix9iQu3m9xW8GrRgH3B2V88enpteW8tBngKMNOcCShSyuV0Pkt8fhsQ4iJ?=
 =?iso-8859-1?Q?i7lFsXJt7mkAq5bbTsGvEyp79xUJpObv89BEO7UZ/5eevFjMG+tdy0mnX8?=
 =?iso-8859-1?Q?upZWfPeOhippjUz3w9rJdmE+ROHUtn2Cg+p9H6JuXYCSr2QJQcC68W4++J?=
 =?iso-8859-1?Q?RVyZiiEFG6WW+bGlgw9vFtDA8Sn3khyCroSCLmYK0fREe/G1TuZeoxUbIY?=
 =?iso-8859-1?Q?dqJ82LL6TKhtDFRXydAz016WRfUh9/j0XoXojAX5+7XITXj9Qeu8y/P+ms?=
 =?iso-8859-1?Q?H9kmlriHyAEZ/7hxoVoK5dPjiomBr6IJ2fWcaZ+qK1zPFWb9XJxtsWJYHc?=
 =?iso-8859-1?Q?omLP1RcDkayxMR82PyVPxgAdWK0Z7ZSib07Jhve5twvMcCVYxDOS5ZaFpK?=
 =?iso-8859-1?Q?Qs4zXYTX7lljvnSkhpyw4AU1nVJAor3P1rQeWyXTsIFTigVJhrZfDXNTOL?=
 =?iso-8859-1?Q?2/3dBPOt4aXzoRI55mkKsFDybLVp187yDVRkezS5F2F+d/cn6jXahXRlSV?=
 =?iso-8859-1?Q?dUJo9rLiw+ZQqua6YAGifJB5XBJlqW8YVN0cWabxJ6IUqAPA0rfFyVpZu6?=
 =?iso-8859-1?Q?dwZPjrv6uNMjtCaw7VzwzNRVRnCgS9A4C4O1xgPN5+epWefGt7bx1/YWWu?=
 =?iso-8859-1?Q?Fi02NRqIHX/dujtftc85LO6rIoFuLG2+GBnof4a8shxdWiLVq0//BSG4Tp?=
 =?iso-8859-1?Q?q1e4FfPVoUV9ZYKNRIAbnKxm8TkAaADgF+Zy0a1Cd4Yl8ECGuR6obAbL9f?=
 =?iso-8859-1?Q?yrA9vJOOZbproEVuAUFAX+KNvFQMSm4weGQBUNHl/z210VkjqjxX1hi47c?=
 =?iso-8859-1?Q?+xm+1dB8ul9EsxBI/1VZQJd6F2U6LL10a1SUDzip4Pb+pOBa6cx2pXKcIE?=
 =?iso-8859-1?Q?CnNJNLyXjsASPpV7kSmdh+QTtEL3bGXCGLc5TSRNBqPHnoozn38tnnAOEU?=
 =?iso-8859-1?Q?R2fFR/YTAMlUR5ALngmGepUsnm45EBkIusSCBX1gUROcU6+F/VQntz9Owk?=
 =?iso-8859-1?Q?olMQthazT8+TmodJcMlT8mdLKfPJk+CyDukZF9YLlI+z9Ppmhk+Br6Mw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bfb5ef-f162-4a93-8e9a-08de10019727
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 17:53:35.2481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoDVlJllku5XkpUgb4bYqVBs6WyvBTp+onhd6tBknSvocu781fapd9oa6C2x04WWyh5W6lvq9PPtrsGduaLRDw3dLbSUgrKntW62nYd6peo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB8E59DF50
X-OriginatorOrg: intel.com

On Mon, Oct 20, 2025 at 05:36:06PM +0200, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
> Date: Mon, 20 Oct 2025 13:20:57 +0200
> 
> > 
> > 
> > On 17/10/2025 16.31, Maciej Fijalkowski wrote:
> >> Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> >> which do not have its XDP memory model registered. There is a case when
> >> XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
> >> releases underlying memory. This happens when it consumes enough amount
> >> of bytes and when XDP buffer has fragments. For this action the memory
> >> model knowledge passed to XDP program is crucial so that core can call
> >> suitable function for freeing/recycling the page.
> >>
> >> For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
> >> of mem model registration. The problem we're fixing here is when kernel
> >> copied the skb to new buffer backed by system's page_pool and XDP buffer
> >> is built around it. Then when bpf_xdp_adjust_tail() calls
> >> __xdp_return(), it acts incorrectly due to mem type not being set to
> >> MEM_TYPE_PAGE_POOL and causes a page leak.
> >>
> > 
> > Does the code not set the skb->pp_recycle ?

Hi Jesper,

yes it does and I based on this my initial solution, however Jakub had
concerns:

https://lore.kernel.org/bpf/20251001082737.23f5037f@kernel.org/

> 
> You mean this CoW code which replaces the buffers in the skb with system
> PP-backed ones?

skb_pp_cow_data() takes arbitrary page_pool as an input, it does not imply
we're gonna be dealing with system pp only. veth provides its own and
generic xdp uses system pp (the two existing skb_pp_cow_data() callsites).

> Maybe that's the problem (I don't remember the details of the function)?
> 
> > 
> >> Pull out the existing code from bpf_prog_run_generic_xdp() that
> >> init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
> >> embed there rxq's mem_type initialization that is assigned to xdp_buff.
> 
> [...]
> 
> >> +    if (skb_is_nonlinear(skb)) {
> >> +        skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> >> +        xdp_buff_set_frags_flag(xdp);
> >> +    } else {
> >> +        xdp_buff_clear_frags_flag(xdp);
> >> +    }
> >> +
> > 
> > The SKB should be marked via skb->pp_recycle, but I guess you are trying
> > to catch code that doesn't set this correctly?
> > (Slightly worried this will "paper-over" some other buggy code?)
> > 
> >> +    xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?
> 
> BTW this may return incorrect results if the page is not order-0.
> IIRC system PPs always return order-0 pages, what about veth code etc?

veth's pp works on order-0 pages well, however I agree it would be better
to use virt_to_head_page() here.

> 
> >> +                MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> >> +}
> > 
> > In the beginning PP_MAGIC / PP_SIGNATURE was primarily used as a
> > debugging feature to catch faulty code that released pp pages to the
> > real page allocator.  It seems to have evolved into something more
> > critical.  Someone also tried to elevate this into a page flag, which
> > would make this more reliable.

exactly here we have the very same issue and we need to correctly return
pages back to their originating page pool.

> Thanks,
> Olek

