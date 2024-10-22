Return-Path: <bpf+bounces-42780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5518A9AA2A9
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765191C21776
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6A19DF4F;
	Tue, 22 Oct 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8Vg+455"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18B19ABBD;
	Tue, 22 Oct 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602158; cv=fail; b=mfpsrBjPbqKnRjUyA7bq5epaQRvPjT1aJL/6pAxUBoqOqWPcRf3E3mbVEVU36+HZiNVkw8NgRPMYNiGz1t+LUpRlh21zIW3RDR+BzdtHky3eyMufuNCwf/fExEfw/p1rTRE3YEEcmYi8ZOZhk58VC+iatOYGPYaPhov0gzWlApM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602158; c=relaxed/simple;
	bh=FrbmMdwFvzP66BCmhXL5xqAwToi15fRqg4p621jUc1I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XSmC7T8kGUm3Iu58T0TsgmpZB9hojlWIBXRsPwKrbAfBdUqds4o5BN1n5CWgUPKX1TTj07/SiXXCwL/CITxumHElcfj9S/3VdFMPrn7h3LP9Edy1DP/L3Uj5gkCKO9QLz7u4IelCsXf76g4MNoydcZHXBIYtHarYaelda63GeMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8Vg+455; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729602156; x=1761138156;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FrbmMdwFvzP66BCmhXL5xqAwToi15fRqg4p621jUc1I=;
  b=e8Vg+455VZYymdtEnECc/n0T1MzkyUUlwQLzWLM/jhnCxnMG2MN/DObG
   82MviK3tMzHlfU4/HwmMyGdcsjoYlSBhnFmf5ikrdnTMiXxkj1dPqUbGX
   MtAoHQ4VthAn/g91pK5qBZ6PKZKwJO07Y069JO9qGkrs5gY0B2NfD36vP
   RWmm1dO00zv5cJ6sVq8WDXsJRSgya20ufz+PZIiCOcgWhrhN6K+uHa+7k
   M9TiwkBKvrtJ+Dq3nSKuP6bkwFaGWdBrntM7XYHkX3DKb2LX404gcszk1
   0SU9xTB92b6x0cFwvZn901FRcz/9PVE8XGE0e4wezkqWPAaFJQzQZxr4P
   w==;
X-CSE-ConnectionGUID: cyYvLu9ZTIaXZzq1odNgsA==
X-CSE-MsgGUID: ZIRxdnp3ScuPshS9JDC9YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28564656"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="28564656"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 06:02:35 -0700
X-CSE-ConnectionGUID: HjEI/ZhORCyx8xj7F+pNcQ==
X-CSE-MsgGUID: kfQqCufQSAaGcV+vThw8fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84683071"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 06:02:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 06:02:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 06:02:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 06:02:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxSIzU/G5iGkNlC+CFOZimWPxEU4xr0H1bxxKpZZ88MVUSVqFvbjnRM2jr/CKDjjdlzbBZs51PCHU66MeHgHaUfYDVzV4iWCHhSuZ8S0I/HYdno79MD4GfRddhA9u+8LcEC9C7AT2YAvjNVTOWKr+GK507bJQsFweN9oqZmr3utjHUPS6SOSgqRMRbeNc38gjxG0TU86Na3Io4Xs27DaymXwBTWdCWvLugBE1Uo+VhoiJSXCPySG8DjBBChgEdiWB5BjP5mOq8HR5y9GGzeXE+7x8qa6DjOkTBA4ESXSNT+NWUFZitK4UwMX2UEMoNDDGEP+MYSP29ZL1A9f79GP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMODshOTnUb02DxsItxbsoFzH3jL2RMEm1ZWtPYfdnA=;
 b=QWLmHiSIW7IWN7osQT4iJW8QHneZZ4lecDZymiKDTMtDYr1h54D7nvKFsZVwS2U6SmS5ki5RdhfSGixIh1eCGZnNi8tgWhGNHB35xSa3f/nGvvM9fNQFHk9GjdH6WIIgKMKTnLtLAWjU9xdV+2aM274xoMsZyj5a32KAg5RhvC+YfNWcbz2/hu8PsbU0k2MaWXe7uV9PtWOLDlrbtHNOI7vxcN7gSTuvJpAeMPQ4jQIngjzodtpqk8KmfoMM4ZthWOP6kiOnho6TuPediCxuiunCoaxcuN+C4+BstPiT3QFjzjAAn9QfzRpm6hnq/CZIdIJI6LrJlGSOVpnzETaRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB5915.namprd11.prod.outlook.com (2603:10b6:510:13c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 13:01:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 13:01:00 +0000
Date: Tue, 22 Oct 2024 15:00:52 +0200
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
Subject: Re: [PATCH net-next v2 11/18] xdp: add generic xdp_buff_add_frag()
Message-ID: <ZxeiBGQmmIRNlCjB@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-12-aleksander.lobakin@intel.com>
 <ZxECiKa4a4LSq7zq@boxer>
 <fe952ad5-b0f3-4547-95c8-1126411c21d7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe952ad5-b0f3-4547-95c8-1126411c21d7@intel.com>
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: c18c92dd-ae90-4329-5cbf-08dcf2999378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oEAgKcN9npRZjmRt4TgJejGjLyGaLe7B1H+FFjgTLBdYrgRkInH0k1eTz+9c?=
 =?us-ascii?Q?iAMdFUhXzEk+YVFDkoSkiKL1orIDA0esn2XZHUcDYFJLnDjg1+jKCC/YV5V5?=
 =?us-ascii?Q?u8kspZLfAi2TLnFtvyUNQ6yLbd91Gvldhe2fuWBrCfkYCZRDYmwjqJs14MuM?=
 =?us-ascii?Q?zMstjLtAKt65oR+2jt/sJSXuk7cy5VLTmJEP8GSnDrxnDsoJ6Tji2p14PCFm?=
 =?us-ascii?Q?fh7ZKzG6XyDRu2QXHZs7+29kDhVF1YgtCsKyJv7+UA3ZEzDhwmulbVRBbQy1?=
 =?us-ascii?Q?UxVYnD5db+/imX7m7olZaxJUwAAPO+WCgi9lKjBN9Km7JV8nzrijq/+n6tfJ?=
 =?us-ascii?Q?MZVb/sYld4321K1LcLwi2PJodIjxU4UOUaNMPX88zSzm6EaqGh8PpZkHC66c?=
 =?us-ascii?Q?213jLVAmUkMetiAhY3dZAUrMXF6Elc9Vp7pmEsQ1KEj5rtVg0KzS/4NNOOUU?=
 =?us-ascii?Q?I27GMvmKT5+x6EZsqmKSUFAM3nQgnYQmgCN9cMiiGD29e6O0oh+LWGYPkI4A?=
 =?us-ascii?Q?eakTFRESUM3rWflYv89l4QND3vTTKkRgLgs0y/u5vXdUDXXDjpjGyMasNRcW?=
 =?us-ascii?Q?jH0KvsFkQomQ5v70JMKnIa9cc6kZAZD98X/k/CaD05PMsefWAOxgyl5Mrv23?=
 =?us-ascii?Q?VVCIIwhf5KprhDkyfePJnubL+N/ONd8u2YDmjxQSZaSxpFF2QFRYCTWEey7I?=
 =?us-ascii?Q?TY5ZCWVRWrTLOmV+kpfquw+3OKju7jRnr8qZOWtrOisvUCSCdgTeXZHkzD65?=
 =?us-ascii?Q?BnxN37xKfnqcyKWV6gYvRscnMsk3SZAyvJJp/8bGi7UDuz1LgYfnOmugBXBb?=
 =?us-ascii?Q?KYDIcrPfqRVT3ouqUFWs4yA8BrWZVgQS7a5C4SwfntgTu65OiLn6HbAFuXPh?=
 =?us-ascii?Q?cO2w9T7NGNhZZ/BUCu9K82SeYx74/82vYzeF33HhWHDZksJfIX7OtbmPAwkU?=
 =?us-ascii?Q?ghec0002udHDro4QLdS1WEXks7YG2USsfWU+4p5Kfvu1bQyNgQ4AplkSiY+p?=
 =?us-ascii?Q?Rw7rm2oygj2XbZsBTGwW7kkajfvr6FWw94Ha1Yt2hOYoPeK/bsTj9he/dO4B?=
 =?us-ascii?Q?MaxWm9dg2dhcPi7CgQPvdxOnGtIuI3vKAdqbW+CVfE4pxT4DsQSp99+sGXCV?=
 =?us-ascii?Q?22RUEyKCiuqTbjvP/RnIZaaFcSya8tXnCWey2PyfTYxgrZVhJEzBAfj1r15E?=
 =?us-ascii?Q?/gyXGbT5Bn8sI2PH6hOqBx9aGQ63BBv/bnKhoCPuCByh97Ir+0LO14EMH5SY?=
 =?us-ascii?Q?qMzGeW4Lw7F++ILnuIFLf+gGVWOoGwwirJ92nk99x+zag57VPx17n9QI9k9Z?=
 =?us-ascii?Q?4p5GV1YaqH72dE264z7Eyk0t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?osLwNLTvXiZSW2JTVpGNSUZkaUJ5EmPxErwXwwm3NvxzwepKMzmgssyvws4o?=
 =?us-ascii?Q?qswVTfCBZhZwLs62EDPYZMzfQYzvS/PFmBXQGe5PFJSNpeUPaq8TRUtuPE4h?=
 =?us-ascii?Q?4DN81QijnQ/92Q2AedCB6zH8Ctuv++7CgS7DuH2nA0if3DUKo5aoMttcZoO8?=
 =?us-ascii?Q?wAM2K5fZf4vb0lmHl1QTJD8eTFoJ+DSsm0e+pEz/1rIENHC85diFLovwF4/0?=
 =?us-ascii?Q?juxgK+fQIhuyX2fGHy2O0kzBQFqra9TKhKqIb2YDk4kMMyW90skfmtapm1qv?=
 =?us-ascii?Q?DW+2nqUmPZCQqIUkYUS7Zv5HmJgKzSD37Hxs0Yn51IzsAxACwh7UhaFBdZjK?=
 =?us-ascii?Q?9ea0LDtvhCyKzg5WYLvLeKNXjFtdHV2H/1434eQyGJxf5Pv6mN2lTSgu+8fp?=
 =?us-ascii?Q?zKafbJ11VDLo89zuZ3X4G/3oX7u6eRZCPzWyEQCQva8a7h2sfU0UEstnehpl?=
 =?us-ascii?Q?Svfvaw8LjZ5HRaByqeaKuPTVbLrJJtwPQVUeX7tMzNFEkbviHFvzO+xAXEtF?=
 =?us-ascii?Q?mkPXlB56w/1s0XxlBqT8ZSNuYcw7G0p2HOnxsVM7hzIqCkCb5KG1uNzM5WLa?=
 =?us-ascii?Q?cwXpxBEgjziUilyMyjMkcQEDbNIJrAOxrtvDp33W55RuorCXf3nMv/TKt+xp?=
 =?us-ascii?Q?GbpoB7OBXlodKe7dgYR8QXde8/YEis4OAlI3yE9yKhDPStEgtg9+7UE3pyqR?=
 =?us-ascii?Q?X/ktkuo/q0ZNKrKoHqCUjnJF/W8kvu7T2B/+GD7/9X1RAD9cuyQ1ng9nj6Hx?=
 =?us-ascii?Q?sLtN5fCMYC7vkZKP80pArcpblNQksS8RfGI1u/xUho9EBBiTaznlaDvXxh4g?=
 =?us-ascii?Q?scFazR2+D6pdeWte4hmKWJ8Hc63InsHKeKBBNW9tR+diOe/WNV033XvdhBOj?=
 =?us-ascii?Q?JCuf/fxjLmDHEhYcSaM/OMPL1vuQYEbIxtbh4KK3IFNVUM/q0Xt15Wvzi02n?=
 =?us-ascii?Q?82IxsWF8WgZ4N43hc3QAkyAKGrC6Nxzdsq6CQfTP2zmXPZLThxaZXn7jSTY7?=
 =?us-ascii?Q?KPkoRNX8/dOXFoypFVlLtL4kUv/hbOzGtA8oZKr4iqwLx3lbkxcNUi1PD723?=
 =?us-ascii?Q?2KI3Ah0v/M2w11hS1nfZBB7RyGiX4G5mFol4UsjMc4NS0LYVEZ2k7e+vM0jz?=
 =?us-ascii?Q?omp1Olnmh3RKTsNX00ixTVd8K821Vl7+7UzS81RTIadZuTJ1LhHJo7kHdWqL?=
 =?us-ascii?Q?byXyWLFQt5ipOtLaLxJHmzrgY6Nb6u4K+1iVocwzmdsKMr/gYdHuSpkYScM5?=
 =?us-ascii?Q?cMs4tX7/c7GhkZbTLvUq1NT6BXmbnXlewWJSnmJK9LlFRgvEhULHuqWazrQX?=
 =?us-ascii?Q?6BTP4R+5ykQrGEGyzIC5DEq5FeZOsxuVLC4emmx2bV+m0Al20eWbrexjzEMp?=
 =?us-ascii?Q?PJek/cvon0DWBdqEz6bgI/uKvwY3PWfFbRDWuzmApweRaYwFh/GFLd03L2ql?=
 =?us-ascii?Q?GQj3z6mx61eKN5CBjLBZtR8aj0VolvlN/UD8OOxkDME0zdz99MY8/3poatGf?=
 =?us-ascii?Q?BeB7YZJqqc5Z+XVCQ3vznuouTaWJMY35mTkxtqSgD2iSJbFrAeAijwjbzNHJ?=
 =?us-ascii?Q?C24TLCWIDFpwDpIDLrF/eqZrc33qcGkGzsmiq4IL9U3U1dYTOh/Mnz505cum?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c18c92dd-ae90-4329-5cbf-08dcf2999378
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:00:59.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExilABuGvCeTiVjSQqk/s49izBHIesghXWttNapEwocW+joeeOLyCTKnXro547yWFmWTM/IYEqSjVgbHAXWjFmu6vX0/QOfeapjrhEwFDpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5915
X-OriginatorOrg: intel.com

On Mon, Oct 21, 2024 at 04:10:30PM +0200, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Thu, 17 Oct 2024 14:26:48 +0200
> 
> > On Tue, Oct 15, 2024 at 04:53:43PM +0200, Alexander Lobakin wrote:
> >> The code piece which would attach a frag to &xdp_buff is almost
> >> identical across the drivers supporting XDP multi-buffer on Rx.
> >> Make it a generic elegant onelner.
> > 
> > oneliner
> > 
> >> Also, I see lots of drivers calculating frags_truesize as
> >> `xdp->frame_sz * nr_frags`. I can't say this is fully correct, since
> >> frags might be backed by chunks of different sizes, especially with
> >> stuff like the header split. Even page_pool_alloc() can give you two
> >> different truesizes on two subsequent requests to allocate the same
> >> buffer size. Add a field to &skb_shared_info (unionized as there's no
> >> free slot currently on x6_64) to track the "true" truesize. It can be
> > 
> > x86_64
> 
> What a shame from these two typos >_<
> 
> > 
> >> used later when updating an skb.
> 
> [...]
> 
> >> +
> >> +	prev = &sinfo->frags[nr_frags - 1];
> >> +	if (try_coalesce && page == skb_frag_page(prev) &&
> >> +	    offset == skb_frag_off(prev) + skb_frag_size(prev))
> >> +		skb_frag_size_add(prev, size);
> >> +	else
> >> +fill:
> >> +		__skb_fill_page_desc_noacc(sinfo, nr_frags++, page,
> >> +					   offset, size);
> >> +
> >> +	sinfo->nr_frags = nr_frags;
> > 
> > is it really necessary to work on local nr_frags instead of directly
> > update it from sinfo?
> 
> I think you remember the difference when you started to work on ntu and
> ntc locally instead of accessing the ring struct all the time? :>

Right, although impact there was a bit bigger.
Typos are minor, so:

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

unless others have some opinion on union being introduced here.

> 
> > 
> >> +	sinfo->xdp_frags_size += size;
> >> +	sinfo->xdp_frags_truesize += truesize;
> >> +
> >> +	return true;
> >> +}
> 
> [...]
> 
> >> @@ -230,7 +312,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
> >>  			   unsigned int size, unsigned int truesize,
> >>  			   bool pfmemalloc)
> >>  {
> >> -	skb_shinfo(skb)->nr_frags = nr_frags;
> >> +	struct skb_shared_info *sinfo = skb_shinfo(skb);
> >> +
> >> +	sinfo->nr_frags = nr_frags;
> >> +	/* ``destructor_arg`` is unionized with ``xdp_frags_{,true}size``,
> >> +	 * reset it after that these fields aren't used anymore.
> >> +	 */
> >> +	sinfo->destructor_arg = NULL;
> > 
> > wouldn't clearing size and truesize from union be more obvious?
> 
> But here we actually need to reset the destructor arg pointer.
> size/truesize are not needed at this point anymore, but the arg can be
> used/tested later, so I thought clearing it here is more clear to the
> readers?
> 
> > OTOH it's one write vs two :)
> 
> Sometimes the compiler can optimize two subsequent writes (e.g. to addr
> and addr + 4) into one bigger, but I wouldn't rely on it (that's why in
> patch #18 I intensively use casts to u64).
> 
> > 
> >>  
> >>  	skb->len += size;
> >>  	skb->data_len += size;
> >> -- 
> >> 2.46.2
> 
> Thanks,
> Olek

