Return-Path: <bpf+bounces-53561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60DA56657
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 12:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F38A1886194
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FCD2153FA;
	Fri,  7 Mar 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyQg7cXO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90B212B3A;
	Fri,  7 Mar 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345886; cv=fail; b=gSsZgTNpaj3mdQJ8VmKec2qRMPKqY5wdj/iAobDmzNyqnQSXzb/p5t7igLVubR5rinJcujhrsoTzPjhBFRdxmg4LKiZUiGvrtYAKI+2OqnKqHZD5PlzaZxctBWpSB8GbhNbDqFwgQJFfls8fSCU1BF0pkD2n37Q021BRzg+rhck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345886; c=relaxed/simple;
	bh=55FOJ63eHvrOt3eB0VwHw44Cub9HWyKJc7umBPRDp48=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nXtKVjAuDRXhdxXFHDxnKP9iAOtJiv5GQ189kNDjqEH7DDBW1cuxKiOIe13C/Ww0/UtEysqcL5XPocE5hcrmKK8na8yKUrNRpJchi5Vr4y49ZfwlHNXNJ7gZTbdmJI0owCsBmBfSptW8BU9nE/n1Ex94Th9zQAjRHojg9ATiDjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyQg7cXO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741345884; x=1772881884;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=55FOJ63eHvrOt3eB0VwHw44Cub9HWyKJc7umBPRDp48=;
  b=YyQg7cXO00be4SxU1Bu41HUwlN/3/kXMVBPl2zgajAtNrzwpdLNWWnkc
   vkrbqtdr/3A7mDUSxOf5KhqMj71dI7GCuxXkO4WNdNktNbY2Rnmz2Xhcr
   CvY0afKxlon2oQEiYvNwnq+7olpCHEfeyTRd4FoY8XR9opO72P55tWZ7i
   ROj4DHpjBvkK6x2Ktmc9zVbOsCuvr4TEnyX5f5FTpSEHKOBf51dKvYe3o
   iW1jw+l/vTjw/exU6TVglTAfNWTp2hf42/qSXGduVPPwrYZAW0Org4d1B
   /9b0IdY+/k5GiPtb075LOiI+tYk2jlm7LhiljQvXj5jARxeenOSKM7Uns
   Q==;
X-CSE-ConnectionGUID: tzVC6Y4JSlyheiQBM5Nj1Q==
X-CSE-MsgGUID: q88ULn3bSOe7F/Ro+x7ZbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46045391"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="46045391"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:11:23 -0800
X-CSE-ConnectionGUID: WKgbEMV2Q+ip9YegEN3N2w==
X-CSE-MsgGUID: mkr55CtiTLW0FjVUlH8E1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119803681"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 03:11:22 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 03:11:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 03:11:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 03:11:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4WEXg4jU+Z2IdVLVkyLTKiaFIAhaM8IeVmiSQU/+VnXqjDx8Ld/HdigTWh3bUQFFdmslyfqoW38MVMN0yzqBzgkYFoZPFWiJLQb5WaWKoL7tVFHo5mv8Rb0ntBOaO4s5mkEa7koLs7G0nqtJVLCm+Vxh12SovA06Nv5QI86ScBw9B+5MhMiPtcrzQfWsHWTqb7gAadGihVX+Ar7drXDhyJBxyFn60dC+vryFE477bffjh3P2oxbBscFde9dFy/CD0beDRky58PSFf9K40dvaNLxVCD02Utz8wjyTjc4B0hQ/mekfsCh+F9SR6qL21W+Hpgdl2Z25jFDllxHM9NP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ8UFVXQJXepSIDDN2MLe6VLpZdknAbTrBhwLM1o9t8=;
 b=lrvrO9cU+okidJE4924Ybfrzmb8YCq7x9BYRY6Yh4eUQXztFc4mxG3mRsrwH0dJMn8VB9ZsTwTLnRSgPAhPb2wtNw3nS+HtJ0Lo5V8JoNrVVZyQd1cutHjcmE8jORxfIzxpmJQLdlrwxi6ATAicoG7U/JSSqkf7cbgUFgLwGQDlRcsi0TaF2gG5vznrjQrBJPpoZBuZNQA6VealwCFD6rwJcSawDQ+QOd/LMz4lloK+Z4wNmnbfLyLCZpQoNfYS1HGakpc0frQ58nBV3dN3L5lSpL/eMGqbKT5dvuAE33PtV1EOv/6UDpiz2AZ/ABh34Qbjc1XpfR7MlvdxJZE6dUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 11:11:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 11:11:18 +0000
Date: Fri, 7 Mar 2025 12:11:05 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 08/16] idpf: make complq cleaning dependent on
 scheduling mode
Message-ID: <Z8rUSb+XocCGHSrt@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-9-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305162132.1106080-9-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be3367e-1104-43d3-bbec-08dd5d68c873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mkkZwit40+4NuRSAHkfQmj7EovnbhBrH5fmG28zWN/5bPJIYqQJfbhDuTLqh?=
 =?us-ascii?Q?OzT/hAYLUthiEjYRnyyvMLXLUj6F/jtMP+aF6p/0e9BhEATbquEQT9Nglh1f?=
 =?us-ascii?Q?j2L2GgbScbRhpWkLq5YPbttWypJtv0h7c8wUENieUxIhGlI+xfuCYQ0UAANV?=
 =?us-ascii?Q?QbpD3glQzGuys1XbAaB77Cs3tONACigwxKBX+iciXjhE3UfY8aAyPFDNQei9?=
 =?us-ascii?Q?ngTOXNJ+oZTNOj9pAEoPK1EzcAVS5jnfWWE6c4LGR98Tlpcg1wES59OLhoGj?=
 =?us-ascii?Q?+xEFctiWaxrBiqphRM+n+HV6sdBKEndmE2dSsDNoawP+9IqCVj97vLaKqxdM?=
 =?us-ascii?Q?KT/B3td7mGAj3t6dGgzPEh/DWiRZNsgH/Y5CiYfDYgKB9+CfscdfemI+FoNR?=
 =?us-ascii?Q?uQM0E3w/cjGnmW0L+SWLFIsNDlT/kwqflBnXLf5sblBL9vpCjZUPTlgFFrsE?=
 =?us-ascii?Q?jBQ4XhrFgAMitbMFUiEhQXAfJhbfyxL9LYiz9gZ4Mul1wXUTp4PIcYSb1Teu?=
 =?us-ascii?Q?1FvzirLadWPfx45vt28U275+0sktgtYVgIgvCIYYTIbLoJc5cIj1wbhFD9F0?=
 =?us-ascii?Q?TTpAaFbi/MWQHIARMy1jxXf0pn1hjfN6TrIe3xW9xym1mpf+DwUlw2Ju9cd9?=
 =?us-ascii?Q?ODqLoO6FzNQ7q3P7dFpi+hXNaS1VUDyAR/0n4J5RB0F3Al51XCJMWkVVV4Yd?=
 =?us-ascii?Q?EEe2ZT3882tfYucBi4ztgmbZsD/+NZrpcu2yIqyz5ERZK1suZ4qrf34Rb8j8?=
 =?us-ascii?Q?KnEDu3p+kBuIX9uy9pso07xDnmgUnN7/aAkJBuoHahYOVZs4TR8KaJ/1zhI/?=
 =?us-ascii?Q?SMBoNPkMcXHiBaX+hIynK9bkqwm5XnMo7lxPOnH6DmK81rHGhUoZFsc86z3E?=
 =?us-ascii?Q?V8yL1BQbZECCe++ltY8FRv6XFRuhdPHZkDNIOtDwPH39chHdcl/CNoQwOSgW?=
 =?us-ascii?Q?UMdn403wDuLkBJZsl9mfwvFUpKSwexyu7M5d3v/ZguSwx40piSRRk3w/WRFs?=
 =?us-ascii?Q?QrVqpOF4mPysEhyWGnOxYFtCuUh8Mp1yVFYrfrxrAmFmfT+exxwJWdtfMT5P?=
 =?us-ascii?Q?7hpslTfBV2s6O62hLqV/44T6lEMtPi3QfHzFqQDq1tY2SxCH1+mv9C1E0Xk1?=
 =?us-ascii?Q?Xx7dWMr2v9YSmXVgETE3OpOV2A95ZSLtJLYADsSzSg2ybcNngdQB2Ffm/+ub?=
 =?us-ascii?Q?ncrOGMFvIAUnNQ0R0PJZfflfxemhvxNsIKylbOMQSWD29xW+ZsWzjRkhiZgV?=
 =?us-ascii?Q?W9s5Ng/OfqNEXa6VF+61F7Di7VJvqPeSwhwbwnvQykMonicQ9HgSF1jxRbFd?=
 =?us-ascii?Q?GFkogWvjNE+745ZzJi/NCtaw5Me6PW8I5AamiocgpSXzf8P0G3A7hXVvBsG8?=
 =?us-ascii?Q?IGK7YxeNi5cXnaTIj39G/6nnOh/0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cPWjDdePgFtt+HiMuyE2sDv3bmpIhkK9obrnnkt4BPI5LjtKndYglGChuVnI?=
 =?us-ascii?Q?bQU7eHh0OGVFKA8fCw29b/K4F0ANyksKPCJRAg/mhRNbOO4uZZUYoaNaqSkA?=
 =?us-ascii?Q?cSWBYTGXOChr2nhZ6QxB2ttOpbwkTHxUWa1EZN7214b86ziUU3Zb5YxLnlE8?=
 =?us-ascii?Q?/J0YAexdwH7x8JJpFIhmLG2zYYm2ZfeRX+TZ8VRa45j6g1qyVvqCMaiDOfXH?=
 =?us-ascii?Q?QWWZJy0WJi9VPVKUGMY9rCYVd59bxh3Aw+OW/hwi0Rs3ygSDITVQGe4Qy86j?=
 =?us-ascii?Q?KZKXYrTNMoFbcuoqORpPxNOrLbq49W/aERiUETnI5xqVIDjgkE62XWOXE1uZ?=
 =?us-ascii?Q?qeBfk1aOwIv87SGpLgqTZS23HwgCt0+JVl3twhpfh0WZar1rJFe+W+Y1asyS?=
 =?us-ascii?Q?ahkRyw1oan6L3QR8EA/LCSot+hJZj+0I6ZjC1tghkuNB4u2vxV42YGxy5Tho?=
 =?us-ascii?Q?F4F0MiljCJnzH7y7ZLVmQPYSvFe0pp8u1X4Oh1/LGf6pxuMmGUKXr0YRTuun?=
 =?us-ascii?Q?135OkXsuFjuedJ/25rRUeJNUVlSsuVXhP2SpQr1VkvlrhxZ5Htd68zZlKGxQ?=
 =?us-ascii?Q?G2xNWHU3kjdmuLaxnpVWyV0XZWAT/tk7YysvUBgoMFT4SRIZALHckDmIR7KJ?=
 =?us-ascii?Q?BKmpU6LWLMDjqLS/A0TB3Rl4WwdSp/XXVe1tQpps/yKHkMpy+Ykfb8iyqWyq?=
 =?us-ascii?Q?n7KpQ+YHH0K/RLR6VZ/bvTADHD1r+PGx2SIad9LA305XpFM4uSKJIjHP8sMu?=
 =?us-ascii?Q?8Uz6i3JYMa59s3o97rj5Eac1kXDtc/WhbC1+S3SSo0Y1OslZNPgZyolP7j6y?=
 =?us-ascii?Q?lQhMhBc4h3BdRkb535mCA6DGGwmaZkTBoHvVF/hc0LPifQRcsKCTrLBM90ZS?=
 =?us-ascii?Q?XnyFHM0WKNhxsk3MSfaMMsLhIFlqqEnEAKvBXaADBNRgusgjutNAk2CxpXdL?=
 =?us-ascii?Q?14VnwL5BiI+eMZ33XgLPR4UWoKVBmceDUi1Hf9Zqiq1Gcr3qUuj2/aP/1WPD?=
 =?us-ascii?Q?34UZU0lZk0J/k1uPe+PvLEtRAYWNSlMavsL9lOu3MncNS3I7eiVyhE6q+kJF?=
 =?us-ascii?Q?MmgstaskRYrNrPsT0AzJJYOqi0Irxi9uAGLF87k/exkFVpyC3yMIcqyZ6EUZ?=
 =?us-ascii?Q?0eWky2QB8qrgl1H+y9m1v26jpOOlhgYRPHnGTzIqVl8BhpQQS7qlCuCxb/Pn?=
 =?us-ascii?Q?7ZQVG4Iuudq5hxC+Q8tz84BcY/cTnwaSTOFJEy05A4iT/NLGfM8njurJFbFn?=
 =?us-ascii?Q?sqVcWIfx2LV8wPC2Eia9UiAXLX2Xb6uYuL/H6/GHEz5ToCa9NY3qTJow0TqR?=
 =?us-ascii?Q?xWyvZh75MW60LYwpbePP18B74fCSB1ZGBb1Y/PZr4HRiIUlC4tQcap8u4I/j?=
 =?us-ascii?Q?DX/zJzfabvdz51ryKcrpk3BGPQoH0YfRzvgpx72j//bz7Nyn1GBnRTOFqx48?=
 =?us-ascii?Q?gRwrZUKRP2a+cu47F2VUuubuNP/nA2vheIzgxxQ1vl4y7hJDql44St4cThIw?=
 =?us-ascii?Q?99m70Wt4ACnuQ48eaj+eyzv2K7wF/VARcfMa8swabE5sk5c7X64Iz+Gy2Azr?=
 =?us-ascii?Q?ZlHJzhBB3sfLm/oU0gozgqIKkwavLIif7y3Qal6MhDGF750kYS5LLEAyHWcd?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be3367e-1104-43d3-bbec-08dd5d68c873
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 11:11:17.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qO7c3YogXv2BVu9L9vb6z33Equ4bYGDvCIwRuH8dzhUjigLK+o58FDgdK1yrYEWK7kr0BqPI3Qbcjdx6B35C91Km3ijUstC/zGiS7nLBoso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
X-OriginatorOrg: intel.com

On Wed, Mar 05, 2025 at 05:21:24PM +0100, Alexander Lobakin wrote:
> From: Michal Kubiak <michal.kubiak@intel.com>
> 
> Extend completion queue cleaning function to support queue-based
> scheduling mode needed for XDP queues.
> Add 4-byte descriptor for queue-based scheduling mode and
> perform some refactoring to extract the common code for
> both scheduling modes.
> 
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |   6 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  11 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 256 +++++++++++-------
>  3 files changed, 177 insertions(+), 96 deletions(-)

some comments inline, i didn't trim though.

> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
> index 8c7f8ef8f1a1..7f12c7f2e70e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
> @@ -186,13 +186,17 @@ struct idpf_base_tx_desc {
>  	__le64 qw1; /* type_cmd_offset_bsz_l2tag1 */
>  }; /* read used with buffer queues */
>  
> -struct idpf_splitq_tx_compl_desc {
> +struct idpf_splitq_4b_tx_compl_desc {
>  	/* qid=[10:0] comptype=[13:11] rsvd=[14] gen=[15] */
>  	__le16 qid_comptype_gen;
>  	union {
>  		__le16 q_head; /* Queue head */
>  		__le16 compl_tag; /* Completion tag */
>  	} q_head_compl_tag;
> +}; /* writeback used with completion queues */
> +
> +struct idpf_splitq_tx_compl_desc {
> +	struct idpf_splitq_4b_tx_compl_desc common;
>  	u8 ts[3];
>  	u8 rsvd; /* Reserved */
>  }; /* writeback used with completion queues */
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index b029f566e57c..9f938301b2c5 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -743,7 +743,9 @@ libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 24, 32);
>  
>  /**
>   * struct idpf_compl_queue - software structure representing a completion queue
> - * @comp: completion descriptor array
> + * @comp: 8-byte completion descriptor array
> + * @comp_4b: 4-byte completion descriptor array
> + * @desc_ring: virtual descriptor ring address
>   * @txq_grp: See struct idpf_txq_group
>   * @flags: See enum idpf_queue_flags_t
>   * @desc_count: Number of descriptors
> @@ -763,7 +765,12 @@ libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 24, 32);
>   */
>  struct idpf_compl_queue {
>  	__cacheline_group_begin_aligned(read_mostly);
> -	struct idpf_splitq_tx_compl_desc *comp;
> +	union {
> +		struct idpf_splitq_tx_compl_desc *comp;
> +		struct idpf_splitq_4b_tx_compl_desc *comp_4b;
> +
> +		void *desc_ring;
> +	};
>  	struct idpf_txq_group *txq_grp;
>  
>  	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index a3f6e8cff7a0..a240ed115e3e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -156,8 +156,8 @@ static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
>  		return;
>  
>  	dma_free_coherent(complq->netdev->dev.parent, complq->size,
> -			  complq->comp, complq->dma);
> -	complq->comp = NULL;
> +			  complq->desc_ring, complq->dma);
> +	complq->desc_ring = NULL;
>  	complq->next_to_use = 0;
>  	complq->next_to_clean = 0;
>  }
> @@ -284,12 +284,16 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
>  static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
>  				 struct idpf_compl_queue *complq)
>  {
> -	complq->size = array_size(complq->desc_count, sizeof(*complq->comp));
> +	u32 desc_size;
>  
> -	complq->comp = dma_alloc_coherent(complq->netdev->dev.parent,
> -					  complq->size, &complq->dma,
> -					  GFP_KERNEL);
> -	if (!complq->comp)
> +	desc_size = idpf_queue_has(FLOW_SCH_EN, complq) ?
> +		    sizeof(*complq->comp) : sizeof(*complq->comp_4b);
> +	complq->size = array_size(complq->desc_count, desc_size);
> +
> +	complq->desc_ring = dma_alloc_coherent(complq->netdev->dev.parent,
> +					       complq->size, &complq->dma,
> +					       GFP_KERNEL);
> +	if (!complq->desc_ring)
>  		return -ENOMEM;
>  
>  	complq->next_to_use = 0;
> @@ -1921,8 +1925,46 @@ static bool idpf_tx_clean_buf_ring(struct idpf_tx_queue *txq, u16 compl_tag,
>  }
>  
>  /**
> - * idpf_tx_handle_rs_completion - clean a single packet and all of its buffers
> - * whether on the buffer ring or in the hash table
> + * idpf_parse_compl_desc - Parse the completion descriptor
> + * @desc: completion descriptor to be parsed
> + * @complq: completion queue containing the descriptor
> + * @txq: returns corresponding Tx queue for a given descriptor
> + * @gen_flag: current generation flag in the completion queue
> + *
> + * Return: completion type from descriptor or negative value in case of error:
> + *	   -ENODATA if there is no completion descriptor to be cleaned,
> + *	   -EINVAL if no Tx queue has been found for the completion queue.
> + */
> +static int
> +idpf_parse_compl_desc(const struct idpf_splitq_4b_tx_compl_desc *desc,
> +		      const struct idpf_compl_queue *complq,
> +		      struct idpf_tx_queue **txq, bool gen_flag)
> +{
> +	struct idpf_tx_queue *target;
> +	u32 rel_tx_qid, comptype;
> +
> +	/* if the descriptor isn't done, no work yet to do */
> +	comptype = le16_to_cpu(desc->qid_comptype_gen);
> +	if (!!(comptype & IDPF_TXD_COMPLQ_GEN_M) != gen_flag)
> +		return -ENODATA;
> +
> +	/* Find necessary info of TX queue to clean buffers */
> +	rel_tx_qid = FIELD_GET(IDPF_TXD_COMPLQ_QID_M, comptype);
> +	target = likely(rel_tx_qid < complq->txq_grp->num_txq) ?
> +		 complq->txq_grp->txqs[rel_tx_qid] : NULL;
> +
> +	if (!target)
> +		return -EINVAL;
> +
> +	*txq = target;
> +
> +	/* Determine completion type */
> +	return FIELD_GET(IDPF_TXD_COMPLQ_COMPL_TYPE_M, comptype);
> +}
> +
> +/**
> + * idpf_tx_handle_rs_cmpl_qb - clean a single packet and all of its buffers
> + * whether the Tx queue is working in queue-based scheduling
>   * @txq: Tx ring to clean
>   * @desc: pointer to completion queue descriptor to extract completion
>   * information from
> @@ -1931,21 +1973,33 @@ static bool idpf_tx_clean_buf_ring(struct idpf_tx_queue *txq, u16 compl_tag,
>   *
>   * Returns bytes/packets cleaned
>   */
> -static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
> -					 struct idpf_splitq_tx_compl_desc *desc,
> -					 struct libeth_sq_napi_stats *cleaned,
> -					 int budget)
> +static void
> +idpf_tx_handle_rs_cmpl_qb(struct idpf_tx_queue *txq,
> +			  const struct idpf_splitq_4b_tx_compl_desc *desc,
> +			  struct libeth_sq_napi_stats *cleaned, int budget)
>  {
> -	u16 compl_tag;
> +	u16 head = le16_to_cpu(desc->q_head_compl_tag.q_head);
>  
> -	if (!idpf_queue_has(FLOW_SCH_EN, txq)) {
> -		u16 head = le16_to_cpu(desc->q_head_compl_tag.q_head);
> -
> -		idpf_tx_splitq_clean(txq, head, budget, cleaned, false);
> -		return;
> -	}
> +	idpf_tx_splitq_clean(txq, head, budget, cleaned, false);
> +}
>  
> -	compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
> +/**
> + * idpf_tx_handle_rs_cmpl_fb - clean a single packet and all of its buffers
> + * whether on the buffer ring or in the hash table (flow-based scheduling only)
> + * @txq: Tx ring to clean
> + * @desc: pointer to completion queue descriptor to extract completion
> + * information from
> + * @cleaned: pointer to stats struct to track cleaned packets/bytes
> + * @budget: Used to determine if we are in netpoll
> + *
> + * Returns bytes/packets cleaned
> + */
> +static void
> +idpf_tx_handle_rs_cmpl_fb(struct idpf_tx_queue *txq,
> +			  const struct idpf_splitq_4b_tx_compl_desc *desc,
> +			  struct libeth_sq_napi_stats *cleaned, int budget)
> +{
> +	u16 compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
>  
>  	/* If we didn't clean anything on the ring, this packet must be
>  	 * in the hash table. Go clean it there.
> @@ -1954,6 +2008,61 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
>  		idpf_tx_clean_stashed_bufs(txq, compl_tag, cleaned, budget);
>  }
>  
> +/**
> + * idpf_tx_finalize_complq - Finalize completion queue cleaning
> + * @complq: completion queue to finalize
> + * @ntc: next to complete index
> + * @gen_flag: current state of generation flag
> + * @cleaned: returns number of packets cleaned
> + */
> +static void idpf_tx_finalize_complq(struct idpf_compl_queue *complq, int ntc,
> +				    bool gen_flag, int *cleaned)
> +{
> +	struct idpf_netdev_priv *np;
> +	bool complq_ok = true;
> +	int i;
> +
> +	/* Store the state of the complq to be used later in deciding if a
> +	 * TXQ can be started again
> +	 */
> +	if (unlikely(IDPF_TX_COMPLQ_PENDING(complq->txq_grp) >
> +		     IDPF_TX_COMPLQ_OVERFLOW_THRESH(complq)))
> +		complq_ok = false;
> +
> +	np = netdev_priv(complq->netdev);
> +	for (i = 0; i < complq->txq_grp->num_txq; ++i) {

All of your new code tends to scope the iterators within loop, would be
good to stay consistent maybe?

Also, looks like
	struct idpf_txq_group *txq_grp = complq->txq_grp;
would be handy in this function.

> +		struct idpf_tx_queue *tx_q = complq->txq_grp->txqs[i];
> +		struct netdev_queue *nq;
> +		bool dont_wake;
> +
> +		/* We didn't clean anything on this queue, move along */
> +		if (!tx_q->cleaned_bytes)
> +			continue;
> +
> +		*cleaned += tx_q->cleaned_pkts;
> +
> +		/* Update BQL */
> +		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
> +
> +		dont_wake = !complq_ok || IDPF_TX_BUF_RSV_LOW(tx_q) ||
> +			    np->state != __IDPF_VPORT_UP ||
> +			    !netif_carrier_ok(tx_q->netdev);
> +		/* Check if the TXQ needs to and can be restarted */
> +		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
> +					   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
> +					   dont_wake);
> +
> +		/* Reset cleaned stats for the next time this queue is
> +		 * cleaned
> +		 */
> +		tx_q->cleaned_bytes = 0;
> +		tx_q->cleaned_pkts = 0;
> +	}
> +
> +	complq->next_to_clean = ntc + complq->desc_count;

don't you have to handle the >= count case?

> +	idpf_queue_assign(GEN_CHK, complq, gen_flag);
> +}
> +
>  /**
>   * idpf_tx_clean_complq - Reclaim resources on completion queue
>   * @complq: Tx ring to clean
> @@ -1965,60 +2074,56 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
>  static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
>  				 int *cleaned)
>  {
> -	struct idpf_splitq_tx_compl_desc *tx_desc;
> +	struct idpf_splitq_4b_tx_compl_desc *tx_desc;
>  	s16 ntc = complq->next_to_clean;
> -	struct idpf_netdev_priv *np;
>  	unsigned int complq_budget;
> -	bool complq_ok = true;
> -	int i;
> +	bool flow, gen_flag;
> +	u32 pos = ntc;
> +
> +	flow = idpf_queue_has(FLOW_SCH_EN, complq);
> +	gen_flag = idpf_queue_has(GEN_CHK, complq);
>  
>  	complq_budget = complq->clean_budget;
> -	tx_desc = &complq->comp[ntc];
> +	tx_desc = flow ? &complq->comp[pos].common : &complq->comp_4b[pos];
>  	ntc -= complq->desc_count;
>  
>  	do {
>  		struct libeth_sq_napi_stats cleaned_stats = { };
>  		struct idpf_tx_queue *tx_q;
> -		int rel_tx_qid;
>  		u16 hw_head;
> -		u8 ctype;	/* completion type */
> -		u16 gen;
> -
> -		/* if the descriptor isn't done, no work yet to do */
> -		gen = le16_get_bits(tx_desc->qid_comptype_gen,
> -				    IDPF_TXD_COMPLQ_GEN_M);
> -		if (idpf_queue_has(GEN_CHK, complq) != gen)
> -			break;
> -
> -		/* Find necessary info of TX queue to clean buffers */
> -		rel_tx_qid = le16_get_bits(tx_desc->qid_comptype_gen,
> -					   IDPF_TXD_COMPLQ_QID_M);
> -		if (rel_tx_qid >= complq->txq_grp->num_txq ||
> -		    !complq->txq_grp->txqs[rel_tx_qid]) {
> -			netdev_err(complq->netdev, "TxQ not found\n");
> -			goto fetch_next_desc;
> -		}
> -		tx_q = complq->txq_grp->txqs[rel_tx_qid];
> +		int ctype;
>  
> -		/* Determine completion type */
> -		ctype = le16_get_bits(tx_desc->qid_comptype_gen,
> -				      IDPF_TXD_COMPLQ_COMPL_TYPE_M);
> +		ctype = idpf_parse_compl_desc(tx_desc, complq, &tx_q,
> +					      gen_flag);
>  		switch (ctype) {
>  		case IDPF_TXD_COMPLT_RE:
> +			if (unlikely(!flow))
> +				goto fetch_next_desc;
> +
>  			hw_head = le16_to_cpu(tx_desc->q_head_compl_tag.q_head);
>  
>  			idpf_tx_splitq_clean(tx_q, hw_head, budget,
>  					     &cleaned_stats, true);
>  			break;
>  		case IDPF_TXD_COMPLT_RS:
> -			idpf_tx_handle_rs_completion(tx_q, tx_desc,
> -						     &cleaned_stats, budget);
> +			if (flow)
> +				idpf_tx_handle_rs_cmpl_fb(tx_q, tx_desc,
> +							  &cleaned_stats,
> +							  budget);
> +			else
> +				idpf_tx_handle_rs_cmpl_qb(tx_q, tx_desc,

I'd rather have 'queue' and 'flow' spelled out in these functions, they
differ by single char and take the same args on input so it's an eye
exercise to follow this. However, nothing better comes to my mind now.

> +							  &cleaned_stats,
> +							  budget);
>  			break;
>  		case IDPF_TXD_COMPLT_SW_MARKER:
>  			idpf_tx_handle_sw_marker(tx_q);
>  			break;
> +		case -ENODATA:
> +			goto exit_clean_complq;
> +		case -EINVAL:
> +			goto fetch_next_desc;
>  		default:
> -			netdev_err(tx_q->netdev,
> +			netdev_err(complq->netdev,
>  				   "Unknown TX completion type: %d\n", ctype);
>  			goto fetch_next_desc;
>  		}
> @@ -2032,59 +2137,24 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
>  		u64_stats_update_end(&tx_q->stats_sync);
>  
>  fetch_next_desc:
> -		tx_desc++;
> +		pos++;
>  		ntc++;
>  		if (unlikely(!ntc)) {
>  			ntc -= complq->desc_count;
> -			tx_desc = &complq->comp[0];
> -			idpf_queue_change(GEN_CHK, complq);
> +			pos = 0;
> +			gen_flag = !gen_flag;
>  		}
>  
> +		tx_desc = flow ? &complq->comp[pos].common :
> +			  &complq->comp_4b[pos];
>  		prefetch(tx_desc);
>  
>  		/* update budget accounting */
>  		complq_budget--;
>  	} while (likely(complq_budget));
>  
> -	/* Store the state of the complq to be used later in deciding if a
> -	 * TXQ can be started again
> -	 */
> -	if (unlikely(IDPF_TX_COMPLQ_PENDING(complq->txq_grp) >
> -		     IDPF_TX_COMPLQ_OVERFLOW_THRESH(complq)))
> -		complq_ok = false;
> -
> -	np = netdev_priv(complq->netdev);
> -	for (i = 0; i < complq->txq_grp->num_txq; ++i) {
> -		struct idpf_tx_queue *tx_q = complq->txq_grp->txqs[i];
> -		struct netdev_queue *nq;
> -		bool dont_wake;
> -
> -		/* We didn't clean anything on this queue, move along */
> -		if (!tx_q->cleaned_bytes)
> -			continue;
> -
> -		*cleaned += tx_q->cleaned_pkts;
> -
> -		/* Update BQL */
> -		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
> -
> -		dont_wake = !complq_ok || IDPF_TX_BUF_RSV_LOW(tx_q) ||
> -			    np->state != __IDPF_VPORT_UP ||
> -			    !netif_carrier_ok(tx_q->netdev);
> -		/* Check if the TXQ needs to and can be restarted */
> -		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
> -					   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
> -					   dont_wake);
> -
> -		/* Reset cleaned stats for the next time this queue is
> -		 * cleaned
> -		 */
> -		tx_q->cleaned_bytes = 0;
> -		tx_q->cleaned_pkts = 0;
> -	}
> -
> -	ntc += complq->desc_count;
> -	complq->next_to_clean = ntc;
> +exit_clean_complq:
> +	idpf_tx_finalize_complq(complq, ntc, gen_flag, cleaned);
>  
>  	return !!complq_budget;
>  }
> -- 
> 2.48.1
> 

