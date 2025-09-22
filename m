Return-Path: <bpf+bounces-69236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3286B92193
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EF718842BC
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9DF30DD15;
	Mon, 22 Sep 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9HbRpWt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312227B34A;
	Mon, 22 Sep 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556761; cv=fail; b=Z2HTwztYdVi32hV2fZP4EeHM8yfmOQ3YzZ5yHhdIESEWn3Ig3Mx97Z3OceUOwYX0p4RMvz4VIp88UhuPZ1SFjRqLrAv3TydiGVY77YdG6WKrwx5qKelEeBrsyCclAX88LUflFaC6f91NdCxCXdrT6QLWrwvAOmg273fsmccIxT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556761; c=relaxed/simple;
	bh=a6H/C73jOI7R6KoNx37W850TTB3u1vE1u0h2VVEUgmM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yay3sDcY06bEaE6yX0NbpK/YTIKBQTtlX2XFLF5TFuEW/ufJHf6nSr81mlDKkpGxZjZ+0V0ISIM7/Cm5E7IU4rN7xM+lOcEBvSYdTMJQsCINK28HGsi5n/jCSmsAGgyzYazKYtMQDsIRIb4GION8QgVgq0B5ru0xG5RIXWhl5As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9HbRpWt; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758556760; x=1790092760;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a6H/C73jOI7R6KoNx37W850TTB3u1vE1u0h2VVEUgmM=;
  b=b9HbRpWtTJ5TuhxZ0Wp5bNkfsqNCcP0f0ehhskXg+qv56l1raAcDy5xJ
   BfivuOLBKiVFzzUcgotrjQHPwiEt96aEGXl8Lot/FJduBcChM/feah7Av
   XQQ4fPgVt6NxD5QrJLQx707RlzaKfGbuaZl9ogGgFVtFTl6suK+VmaOc4
   TM9i8AZ9Dj644Kmd6GS/457EO4xlA8dPPks4h1nrPaqang9XUAduAMt9y
   U50Dcd3wvX1T2oCCtYr5fXtA64/9b/mj7vR3LbNZyFDEc7n4UgsQEJ0LL
   d6iiaq/mh3+fWSm2tIz7zVO3IwrNFy7O/Adsgrk/bDbIYma1eF9nNS8gW
   g==;
X-CSE-ConnectionGUID: 6QS1uAoPRmWPJVXFXFadhg==
X-CSE-MsgGUID: durvFjteS72eTiZgTjt0NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60876883"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60876883"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:59:18 -0700
X-CSE-ConnectionGUID: qJWk0iSBQmGTsZFQl2O9EQ==
X-CSE-MsgGUID: JmE1dt+PTFmywAI9xgf0RQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:59:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 08:59:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 08:59:17 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 08:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNyPfV3v9jQoClwcz22hlhNKZiT1UmaxgSVeimdOpyoPEPnC4Ul1jKNA003sy1dHcNx2p8r708c6He7MmkvBLKuABAR5i1pxc/XVmqKFndB/JJKPe4J0hVcAdPWeyuNeqqt/1pMroPB4LPunfK/bEl3V+M1x4cOduCtEOOjmEerZ4/7uBn7sMLTi7S68BMsQebSXqRJX16b/9wJATmn1n9aWdYjqfBm53nZ81V++xKb8wEJyoJ2ZdWbsyHkJgmSHHCrPNbumm7hleOV4fNEEdqtF0Vqw6B4Igm9G0SgWVP/UHGhP2Va53qlURcE/weQ8jITkmGNqn2GAMHXp+I8XqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIwVDjLg5AD4/w6N9JMpjLFBgbtCNuBrdb5n/V8dtVA=;
 b=fmwd6zdINMB1iSla108aMIAt7FkWFOR1Ey12zuzbFCf8CXrBdQB9EFW0Rz4YU/Buy5GcCJlpLeLJAoPJD6MNs8dXJJC1UzKmvgwRu2TizsugVOlRxP6DOteFqsV6yvyHJrgA42HVaDmIWfGDzJ03NDZJviJzhsrFHdL7wtiJzZ3xEgVAcSzpXQf80ny4lopRn+2F0zrjsZZz/vjErxH0SK0kc8gaWJmRadwzeT4+8uXEqMwzaNWiz3Hb6tm3YpuN8TaPjO8w+Ak72Vfq3DMlwaN/5+lH8h8NF1wV4S8V4sGMSO0NzFeo8Jf5HAPLvscBSV95M4aNAUKM+sWxICg60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Mon, 22 Sep
 2025 15:59:14 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 15:59:14 +0000
Date: Mon, 22 Sep 2025 17:59:06 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <kuba@kernel.org>,
	<davem@davemloft.net>, <razor@blackwall.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
	<martin.lau@kernel.org>, <jordan@jrife.io>, <magnus.karlsson@intel.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 09/20] xsk: Move NETDEV_XDP_ACT_ZC into generic
 header
Message-ID: <aNFySqVqc7K8GDSR@boxer>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-10-daniel@iogearbox.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-10-daniel@iogearbox.net>
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 8295fb7e-633e-4f17-286e-08ddf9f0fa0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uK480tp6dt/GlnZHd8YpMJttNoslRTBpRHO2t3I21rGR+FFULT9p8uKvMAC1?=
 =?us-ascii?Q?cj80B112FlFJ1KpSXnOZxX477Mlew7BebBAf+Ya16SUWenTHC940b/7mDWqv?=
 =?us-ascii?Q?zgaYTxqiCCnd+3s71sr6V2MIXIHfQOOGrh/rtkPn8ZHdX7HWVZbZicU2GOCw?=
 =?us-ascii?Q?bnABUtBnOXXxuamvImzVR0Tbw/u9hbQwltVxgmGG/b8/JlBvy/xbwf8Nsv+s?=
 =?us-ascii?Q?S4TaIbdkaWKc3BTQq8hlBZFvfnxybeVolwGD3nna5HGPhqPpcwG1iVN3gCyK?=
 =?us-ascii?Q?BHURWjgYBaIhvNdqAITInjZkA1LXnM/uEAGaIMFav8fnqEhqLf+mg4iprwLu?=
 =?us-ascii?Q?9kEhtNzyEhORhU4KDi6zqiNAIvgYCfiPm7NOwPF7PEUEq/07QFeM69q41SLS?=
 =?us-ascii?Q?JCw5Ka6oOVay+dh7Kf+38jxxUSJhx7y/YYlq2Xd5+XIwTNDn1xkXhEDM9sar?=
 =?us-ascii?Q?c2Vx2Qowi3Es72xt7uy7u4JLy2KmIeUGomfBoE6TdnaXeUqyrQ22gYz3Hi9Z?=
 =?us-ascii?Q?zBAU38iS1iwJHVyJIFSnjZXyPCJa5f/QSKw1AV6lqEV61+AsrXC1nyTN54eA?=
 =?us-ascii?Q?C5d/aDQ+d42NhO4Bl/29A6d6k3nDH1eWCWINMiicU9EJFTdsTrRGdX8FgOD7?=
 =?us-ascii?Q?XoQSrxO2rJl9bgB9HxKyYUl8osCWBlNr52mrtdGuvR4arG1TC8FIoUI5+p1b?=
 =?us-ascii?Q?IZfX5Oj/oxbSoYpCUodQ+m2MdFbwoZyhGB3MXbV1umKMasOP5cHTEltBS5c6?=
 =?us-ascii?Q?s4I6sQaqKFEAxe51b61ERP1OrabsUfCxAOcB/lo4ZvN63LLTS08eopz3IYQ8?=
 =?us-ascii?Q?mmbPWtWyXk59sElJXfr50sXRb7kEpHqI/brJFpUdc9iysIgkClmEuvRpdLJy?=
 =?us-ascii?Q?N7oXsfsgQrivbXG/nmPPw2fz+p36oy9RWxgdRU+LywaVq9Pp6ob3BA+V4L1V?=
 =?us-ascii?Q?u0TAxU59Yd/C2J9AbZY+RDYgFJIS0k6cdjFCjDDzU8f7f3DE6D+eVpkdQB+y?=
 =?us-ascii?Q?PPBSIEYiwzPE48TvQXr47Y/mivYUxxSonkC6C36x+NrQOa/hwI6feHGrdLlW?=
 =?us-ascii?Q?juSOZLgZJO6lZuPIKHY2/F9yakUZWocECVFyodcX4k3NNT9XcXbNS6RVURrn?=
 =?us-ascii?Q?o4gq6cRHA2FAGFjZ9gIvOKbDklF8g1B21anbUD0bGotsVi7wNAaqaEoEMIi7?=
 =?us-ascii?Q?NCDFFKN0Pxh+mZ0rWUvX1Nv3alqGVDdNWs2rvGJufjO0HMzmCdGYEFOK/dzQ?=
 =?us-ascii?Q?WfR3Jp/l/Zh8mI80Ygk/W8VH9JuZGgS5lIhJNB5AIyodwTIAxFbFeuGJ89Kd?=
 =?us-ascii?Q?VPULayeTkUa0dqxDhMAM6Hgf69gV3kQC/MScFXXI3uKMzn6QnO66qRRBpHt6?=
 =?us-ascii?Q?fH028efELwSajSgeBqPEPKGiAhkKmctrdRFJYrqwL3AR7psn+rXT3ii73iYB?=
 =?us-ascii?Q?3VSeM5CBymc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?roN6ZggZekmvQvZl23cYg/ZXG2oVjkmpSSXaOyxRBI707oE+oybLl51Ggx5i?=
 =?us-ascii?Q?cezRY70XrJ/z0C4CTCVujowXSt9737uLSHcQnk9IvUHkJPtDuyP13JguSNXw?=
 =?us-ascii?Q?LEarVbKwMGgWAIXgEN79mgPGz4fz+yyRWEoSSzipICpsuSPDcLXP0gFPiqiH?=
 =?us-ascii?Q?n+DH6X8pF+xSAXfPAGVzDZh8TFpy20pbBLGgFbK/+jeTeDJAi5r8Xqkjko71?=
 =?us-ascii?Q?WWcfhrW5Lu+5KiNXB2dWv9iEAZRyOj1Bu1S6Of6zM2i9lbLJSdvDZXMbhsem?=
 =?us-ascii?Q?HnqTIYwZVzcT8iqeMSc7Vv1t5t7py8WQwfuruiRZhMtNWr8o16ONbWzhD+B9?=
 =?us-ascii?Q?DZ45p6KudMgV3t9plY5IEDEDScxjQ8fK3nWMWInnVZFnFid7Y4bZJZqrwfKX?=
 =?us-ascii?Q?XMdJPEcg2Q34HIByj+ngmVpFWt3squSbkplViJ5QEVXsz6ZtgIJ/WEszKJOa?=
 =?us-ascii?Q?KaI1Cc/6iZq0VGjXnaVICWRuIGU+BJyALIHCwOMdF8iQXUkf2XKuBc0OJTDs?=
 =?us-ascii?Q?W7KpTvPNmxA9tQ1ncqIQZwGO7RTQRELeOiQRKh0F+5zDdex6iqmrlZAV2dSU?=
 =?us-ascii?Q?nEBAkfkRi+hNTmukOPC6DoRFLRze6cs45Mr8CkUDJRZFPG6iqJKlq+cgOiN8?=
 =?us-ascii?Q?3zDWcjGOMxn/XAB9eQQCn1jHOPY6or+Zy3kAjP4svr2R16OpAgP22m3ljpzu?=
 =?us-ascii?Q?IKbrjAsyR05UhxuMUPfs9a8lzCTxmd0bUQdKvNugigsSIlroPAwvvXnR1zT2?=
 =?us-ascii?Q?SFMqWic/ZNDCikrqYODu/u/cth2g4j2QQYmEIJ/0B9wBz54Jd2AybkuP3brb?=
 =?us-ascii?Q?8qslJHpMHmpShRuvud/86g/lYpFe2kNkZsL6Sf5kUM2PQZJmoq4ZYVf0FYBO?=
 =?us-ascii?Q?xbKB01SkeOuCdED8Oweh/D3y4oPQf7EWg96kO+2na4MMu5z5bcgOD3KYRwgO?=
 =?us-ascii?Q?fkzc1rjMfZlyF+ZtRtsjyUAPyFmBcwjn5q2+U3R6EHLGpDSwyon7T2+LSmMq?=
 =?us-ascii?Q?k+lL2F6WIPMtQkK5y6+gzbaVcl7pjBBqcE/eJPdCMg3+1No8GHDrRvBo538A?=
 =?us-ascii?Q?54Fl8b1LrgPazHlPxidV40JQQuhGe6yBYsmszM2LrQNVo1RfoDAOdT07mt4m?=
 =?us-ascii?Q?mEfvCgaJD23c7jKP22x7yzq5CRT73yBB7SjGj1S6f/5azrL510gVZm/M1ON9?=
 =?us-ascii?Q?6Kj3/iBZcPxTaRjJ3aEGDrak5TTHXBgCDH2dxolA5hZEhpcIum3QijvJitga?=
 =?us-ascii?Q?UTmYOmXIY2qvNuseS5bi/NZ4ypqSOHPTTjEUotZe08c2cKWEeXFLCLGd3qio?=
 =?us-ascii?Q?lCdcG2Z1Fw8HRT/bK0aK5LsCxjR77iwzZXa72K2gKivgUtPe2IbpUHdKzcqM?=
 =?us-ascii?Q?YZX291B2SPDnkvD3xrYAnk2EO0gEHyotSvykx2F+MELndWeJGMaHT3SXbkYs?=
 =?us-ascii?Q?oGh+LZpMxGoqz1+Js7f/a/dWUD5RUpq9YnowNWXTldcvc46kEuDBzQtbRLlu?=
 =?us-ascii?Q?ydm6xt+gyEnxCkL/eeIG6H4068d1xeJ1hBRpQTxAKbJwJrSnlxzzl7bfJNUb?=
 =?us-ascii?Q?ixxupTD5hhNrZtiQecQ/64kcKWRwCX3TAJ23HYAGNAKqYAVXvz2N2qKESGUE?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8295fb7e-633e-4f17-286e-08ddf9f0fa0a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 15:59:14.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eZTDBmqi+fb96jOprsjLwnjbcYHU0Wziqsd8QPMmePVfhNj8n8hozHjo+jGbvCL8nckIx++MrnxDASfmfF1JdlYVH0AcGfmaYDXKOftXmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com

On Fri, Sep 19, 2025 at 11:31:42PM +0200, Daniel Borkmann wrote:
> Move NETDEV_XDP_ACT_ZC into xdp_sock_drv.h header such that external code
> can reuse it, and rename it into more generic NETDEV_XDP_ACT_XSK.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  include/net/xdp_sock_drv.h | 4 ++++
>  net/xdp/xsk_buff_pool.c    | 6 +-----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 513c8e9704f6..47120666d8d6 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -12,6 +12,10 @@
>  #define XDP_UMEM_MIN_CHUNK_SHIFT 11
>  #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
>  
> +#define NETDEV_XDP_ACT_XSK	(NETDEV_XDP_ACT_BASIC |		\
> +				 NETDEV_XDP_ACT_REDIRECT |	\
> +				 NETDEV_XDP_ACT_XSK_ZEROCOPY)
> +
>  struct xsk_cb_desc {
>  	void *src;
>  	u8 off;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index aa9788f20d0d..26165baf99f4 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -158,10 +158,6 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
>  	}
>  }
>  
> -#define NETDEV_XDP_ACT_ZC	(NETDEV_XDP_ACT_BASIC |		\
> -				 NETDEV_XDP_ACT_REDIRECT |	\
> -				 NETDEV_XDP_ACT_XSK_ZEROCOPY)
> -
>  int xp_assign_dev(struct xsk_buff_pool *pool,
>  		  struct net_device *netdev, u16 queue_id, u16 flags)
>  {
> @@ -203,7 +199,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		/* For copy-mode, we are done. */
>  		return 0;
>  
> -	if ((netdev->xdp_features & NETDEV_XDP_ACT_ZC) != NETDEV_XDP_ACT_ZC) {
> +	if ((netdev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK) {
>  		err = -EOPNOTSUPP;
>  		goto err_unreg_pool;
>  	}
> -- 
> 2.43.0
> 

