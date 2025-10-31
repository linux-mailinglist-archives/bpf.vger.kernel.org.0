Return-Path: <bpf+bounces-73159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E32C2569A
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 15:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C784B4F60CA
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E123FC54;
	Fri, 31 Oct 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZixnfNBE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C834D387;
	Fri, 31 Oct 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919378; cv=fail; b=fIZwXu9P1PODQM1deIABCdAwGWZJkx14Rw+jsgxsFZD8WE6/4rnSV0Y59wWJn352CrCWPOPv64pJ+gbe1B/hEy6od7+Qv4ptyLPTg1GZnlNGO8YheXvCGWgX169zSSew86BVonNy8ogMq8auOUPFZEBisXcEIA68odFPzpzuXr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919378; c=relaxed/simple;
	bh=LxaNjdNDMbnQACa68isb1Edf2ET3QwJoQcfAybTGc+0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zk29h7RUyHWPF6Og8GP9jHBG0wMCY5Eho+iIIz4cMDqVQL+gOwV4zkgpDVXOrsSj0mEXSOsxUrvgjTTtX+JdRKJNP+wyOMl8eb/L2Af/O2QjwNKsAtpR31tAa8YFDBcvbULDAG8/L/sTukShMUT5Y2UJVWbH9WqzzB5w9o5HJt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZixnfNBE; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761919376; x=1793455376;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LxaNjdNDMbnQACa68isb1Edf2ET3QwJoQcfAybTGc+0=;
  b=ZixnfNBE32FHKK/SdEyPuTDtTGgXncpcFV5QMndiq89Gi6dr/bRzHm1P
   7AFaW0gr/u8lXID2ydFjIVfNZvVzs07eFpVnQTppE27lBYCPQSwL5Euor
   cOQZx3uzS0oDprPwdCEaeMgrdNPwOPtXPEOpltJCAea1/Sm2lJc73LyLD
   kIIkiuEooXXRn3irAXzYzAtI1pmoBoD/jnmDenqvIz7Nt7ildvpNgHz6B
   hqTGHy4qDmBMgQFv5ymC/KJnDFoKN8jpqmfhzT/XdMGhVLcO9R7rFIb3X
   VWfDx349Lzoqn1zylEKcGLJjmcob/pos88P1BSV1FTrPwOR6ABhaztrmk
   Q==;
X-CSE-ConnectionGUID: Hxdv/hPJQlKMPFwt0QqXzA==
X-CSE-MsgGUID: F/ZbQe3XR1iIiWJwxCU1ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81708693"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81708693"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:02:56 -0700
X-CSE-ConnectionGUID: XJPl60UUTIadOy+XMFhZgg==
X-CSE-MsgGUID: mCpIfdg8Qo+2KYpcANdIVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="209809381"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:02:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:02:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 07:02:55 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWOvF614h64PRG6tB98NUnuUclhorJGodof/qRiVmVJXNs9Xc0RooxTaB0GFQMB0d1Oh/kTaOobTn87aedmlqs6RKOjkodmWnTc/5yE3PmKterwoNNQWCn86z4Khu/b5PmHB/9L8j0PydgJbsIghRPWDQR9vhu0rkkQKPQN/3VsBSrLAAV60PWv6Fqsala9ymuxzZm3lHkhlDl0MLvKqUdeVxPzpp0e/4NftiDj13EzrkxL8aFu2UoscQ3eF/32rPuFXfMCv3CFoC+hni7ZTQSaubsbf4thQM2ZAYUpsphY/UJ9o5ArjrrGM++/62Wehqcb2u07iTPjwPnXPRALVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tnzZuDXkTk/Y01v33e/0azFnMF+P6zBXU2+DOwLKJg=;
 b=XiTnXOIvCn19RjheLw1LJJeoXwwVYWHin0W49FK+3x/xs04EZ5yMXMaBD2alhMHey4hWRl0X+y+Rla7tK0GiqO+rVIoJbNgIyG78TaaQ2EH3tzthOxrPR+cZLBv6VKG7yyd1tP+EchSFgLp4KG6QcnTV+aoz5g8LcBHHvb+fL53rsAC9S/uw+Y92D0jzG9iaJWIiMEbHoxnhTR0hQAArILUhUDpUYy+eQJmaJWfCSmDpJY7DOPhJRobE/zSdExDAFIHVrUeQdkFqxdATKHRHjcOzf7Fedu+PWt1jhO69wDFD4jRfQCkuMR/fkkUg++yHD9pwIXoW5ClLyXybCdIB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 14:02:53 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:02:53 +0000
Date: Fri, 31 Oct 2025 15:02:18 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <fmancera@suse.de>,
	<csmate@nop.hu>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
Message-ID: <aQTBajODN3Nnskta@boxer>
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031093230.82386-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: BE1P281CA0306.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA0PR11MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fe7720-4a01-460e-2efd-08de188623c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q/naHxHBTp26jfEmVu1C/Q98N69YlqhP7bwFA0OosfjZmqOCNQxwilJ0Ix6a?=
 =?us-ascii?Q?5uDk7WXgEpxMnCgOr67xIuzR09yFTd/ewIIKqLLOuBPoYkmj9vnbLheqxC/2?=
 =?us-ascii?Q?g80jK9U9dS3/9xfWPEoAmYmzlH1bbvgf/Xu+5Ke1XcSkERAiWB1aQZwvos/i?=
 =?us-ascii?Q?IwM9Wk2sQGpwyIuqH5IL3hkd6ioJbJUDaNJ9K73Yc1YLxYpt7IQ5hRZ4UdjF?=
 =?us-ascii?Q?ySOGWwZWGZZJKpelfSruvkt7aSlfkeT0BrI1quu/EP21wEQPqjlY5R0UiiY0?=
 =?us-ascii?Q?/KqlVtmhVHMF9DrELD0PfmdLF9Cd0XJl0R/mCnAh+pGxRe+Hpkb/mjSajvn/?=
 =?us-ascii?Q?1GZ0tEhSbxEJKuql02FxJjgHFjB4SEgkoVD+48PWkFJ33rfaOIIOCiKR+BAd?=
 =?us-ascii?Q?QNIz2/AO9rOkXXmNmdrqyMPXMcduL/kM0Sv7vOQ+RLlnLJyx9BAmYFMGoGzt?=
 =?us-ascii?Q?z1YDu7WfresXtPNE19eK3qRmVGeLUZSgP4HgNlHXkKp22NTnJZqsGqDLUQ/o?=
 =?us-ascii?Q?+VAEd6R/2C4SeOh7Krnz0N0MZ2+Df4JE6F8XFbgixCN79RK8HOnh0e8asvux?=
 =?us-ascii?Q?b+/8jbcpMuvVkAGjvQUG+aQKFckeYZM2yFwAL/dJO3JVyqIy/6LMqw7A0CPN?=
 =?us-ascii?Q?428wz0Pdc5rWNd030L1vozKcIdPUYkqk5XqySVES8+OyXdgPHq9ilEsy/JJU?=
 =?us-ascii?Q?49rS4/mluIA7bqkbaUsOQBPs1Tlr5IMJmqAVG/+jJ/uxt7WAt5vxdvcEft68?=
 =?us-ascii?Q?Wyn2wQSddo6w25wxA/sylcvujpbdjDXyCU8j4ah/rSFKG4H3mScz1s1hQcAB?=
 =?us-ascii?Q?hLIWWphnKv5oQC6KJJIi3gl3UToT2l5hruOv9nMtbeeskP0DDB6Hijll1axb?=
 =?us-ascii?Q?eIszOVbNj+qT22bJJtZBYCXne6wxE2d2vgle5Oqm5f+GfF+IbK/EFVBdUgth?=
 =?us-ascii?Q?P4+QK84DlIS5OKZDa0ypxfKtsUzeYxiAPEpcxd7qrAJBz6OEUEz2BHK5fW3R?=
 =?us-ascii?Q?I0EOvzklt5RP2hVDe0abOz8rRSNonEKYHeJJ6cBvsdx+s5r2XRHQQW5ugsii?=
 =?us-ascii?Q?NUMvUD4BJHdM+25LEPDJnE7GLL3zEpHof4cGCZCH+9PI+zGwm6jFtym7gR95?=
 =?us-ascii?Q?rMggE2sJ+1F4h29RbL1ATf1Lgm/agzKSNzmtscJB1UIxCYdWKa2SGYnORI73?=
 =?us-ascii?Q?nP2qobQhI0kVmhGz+no9HKJu6f3Acegc8XT+3Eyie9749RfQ/iJv9hjXdH1g?=
 =?us-ascii?Q?BUOXshBTV9Dcz+vG0se/desyRrrTNOdN3xFprBmMxTffspfC1LbylWzMymrE?=
 =?us-ascii?Q?GlKH5ncvHx+AgveNrSHnj1WK68QF9ywypjZmbzivHKqUSVnbG5vQCkXbW2UP?=
 =?us-ascii?Q?5pI7/c5oKZTTMDN5s8fk68JFhydZ4oZ3cAr0NYZfzManlq2QCrkrUzd/Vshb?=
 =?us-ascii?Q?hvU9u0WRu/V/2G3vgU20wvRPSWmpxUtiXYV/IFNIvtBOH0TaDvjoBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DY3rXxt5+Ffsz1JeFAwKyLB3vrEdflraOal3dhsctU0SnuxC8yCKSfKrF1oO?=
 =?us-ascii?Q?rD/uXhahtQon0E8MwheL3DEMIskFou6YahNDktgDiwT8iT7feNOJtlBQll3M?=
 =?us-ascii?Q?JOjOcgoBoKDlu5jfd0uiiMC3rauP8a16XBwxzNzbTvb0XWyAaFJnLuXBwRwa?=
 =?us-ascii?Q?0EyNcjqWplKkRXKq2Uz+WKt7CbaCv3lVhr/Y/I0UT+mN1q+sKYPYkb3+Rb3F?=
 =?us-ascii?Q?SO0NkPNv9TvyWXKuX4oMP6w8doJnVsaD7MoxjN0yp5Tj7p8B3Uoa8xJi5Bli?=
 =?us-ascii?Q?fXLsnEZKMRbeZVoTa0DbpxyoGvS1OfUUs/9X5Jh2BOtdW0ZquNzR2lFJHt+8?=
 =?us-ascii?Q?qs2BNB4LxUVDfIGW0MwbiNPd1oT7/2syzPAvkb0v7jUl6ZrGdpuh3c0M0dxj?=
 =?us-ascii?Q?bSq1T1l5JQEVWwV7mMlq3I0kKd+ae5H5IoJA3AE0SgNZs72viuF2CWPf7k3U?=
 =?us-ascii?Q?vdIeXYhg6DlLBjC8DDREmHoopby2RCrgMEd42+1UdxJn/9aGSTLMm3vDG8Y+?=
 =?us-ascii?Q?VhepG6KEJ2ObUK6T+YQSn/V3jlvb5Ui62RpR+Ec0kfqbWQVPzcSaATihuffl?=
 =?us-ascii?Q?/8Qx+pjjwUZuIackziAj8GD0HS5FpBEuEDe95aWnqoiL5RU8kNFsHTXPGYAg?=
 =?us-ascii?Q?Q0DOeAlydKBS5G7EgBvphDhs/dqb3npg6JPAsUzjZEClO7t3BbeWIf4SswdK?=
 =?us-ascii?Q?VxjjEAAzYvIMfF6jfwQjSuxYQuTl6Kejq7qFvC0lrVqkzwi8AIyFV7TCZv+K?=
 =?us-ascii?Q?MH1grb0bd8D8yjXA8zOCUdMwqK08QBSGr+HRNIKYFxUsLLeThlcwDoEhpSJG?=
 =?us-ascii?Q?luM8qLZZB3U3/7mdJSk28TIIedh4NcU8lN1Zzcz+FOUDpk0XepGhvvi6yeyt?=
 =?us-ascii?Q?ss/LGt4+Kuw1Kb2infeYKYYlcOcF6sgrX9uyJ85CPuiw2lmOSIJUQAOhJDg0?=
 =?us-ascii?Q?aWQpG7vw1Uh/VqgTs7ZpxoUt/rVhksoheNFY8W5rL7DF+y+l4cc6P0RdbLv6?=
 =?us-ascii?Q?Ih4+WpLRiPSYkpZtahBhp4OTSzALDCBHIz0qQCS1rYOusuZ/1k+8QbZlpeFC?=
 =?us-ascii?Q?yRWQx1Ku1knHWRVjuF7cgkgbo3T8SB6tb3oGbtvuLWxHQo0sjfHlOauiXfF6?=
 =?us-ascii?Q?NJmVHkSUQaHPrnQwQRGy9tCOPUafWuuCdVjCwfaZNnaugcIWJBjYHmW/fCVl?=
 =?us-ascii?Q?hTa00EUcQiiepl+W+XzY458LeEQ+tXvAjMoUrrBF20NF8PczdVm24+35UkG4?=
 =?us-ascii?Q?HxfhaK2GxyVB/s6SssTopgJkmk6zw1nNY24530X052Pcn44P52AtpZdLPNI7?=
 =?us-ascii?Q?a+/ahr0xuNmYcui59JYzGS+QLGVS3SwbyqesPW/4eTpMhxYmIiKPzqsfXHT6?=
 =?us-ascii?Q?grNFW590gCy+qubXaTyml6c9mrQyORpwko2ooTAjfKgMJKp924tSJ8jbHOb1?=
 =?us-ascii?Q?IfgltJWSXB8gBAPPXmUxeWGuXMIMAuuidyze6T9NEIjANzrLIBEf9AWOqmsg?=
 =?us-ascii?Q?pE3HgbHPS8MVVxSGucN9al5tA1ja1db3G808fGbTWHs61tB4zjLuxFfDCbGW?=
 =?us-ascii?Q?Ofu5lkKcGlvxt6fGVWvbqEfUHBjqIoQEYj6SKjZvRXseMQkYKPXjdre6RVgw?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fe7720-4a01-460e-2efd-08de188623c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:02:52.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J01zjduPBnw/Z4UlmCioe3e1P/YUYAgHlVI4ALrvLNcA6g5OqMFfgxbAc7u/geBxhloMb5fuRUetoo/V5+aQBLShiCQvjlF3ZxofL0XbEqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com

On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), there is one issue[1] which causes the wrong publish
> of descriptors in race condidtion. The above commit fixes the issue
> but adds more memory operations in the xmit hot path and interrupt
> context, which can cause side effect in performance.
> 
> This patch tries to propose a new solution to fix the problem
> without manipulating the allocation and deallocation of memory. One
> of the key points is that I borrowed the idea from the above commit
> that postpones updating the ring->descs in xsk_destruct_skb()
> instead of in __xsk_generic_xmit().
> 
> The core logics are as show below:
> 1. allocate a new local queue. Only its cached_prod member is used.
> 2. write the descriptors into the local queue in the xmit path. And
>    record the cached_prod as @start_addr that reflects the
>    start position of this queue so that later the skb can easily
>    find where its addrs are written in the destruction phase.
> 3. initialize the upper 24 bits of destructor_arg to store @start_addr
>    in xsk_skb_init_misc().
> 4. Initialize the lower 8 bits of destructor_arg to store how many
>    descriptors the skb owns in xsk_update_num_desc().
> 5. write the desc addr(s) from the @start_addr from the cached cq
>    one by one into the real cq in xsk_destruct_skb(). In turn sync
>    the global state of the cq.
> 
> The format of destructor_arg is designed as:
>  ------------------------ --------
> |       start_addr       |  num   |
>  ------------------------ --------
> Using upper 24 bits is enough to keep the temporary descriptors. And
> it's also enough to use lower 8 bits to show the number of descriptors
> that one skb owns.
> 
> [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@partner.samsung.com/
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> I posted the series as an RFC because I'd like to hear more opinions on
> the current rought approach so that the fix[2] can be avoided and
> mitigate the impact of performance. This patch might have bugs because
> I decided to spend more time on it after we come to an agreement. Please
> review the overall concepts. Thanks!
> 
> Maciej, could you share with me the way you tested jumbo frame? I used
> ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes the
> nic more than 90%, which means I cannot see the performance impact.
> 
> [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse.de/
> ---
>  include/net/xdp_sock.h      |   1 +
>  include/net/xsk_buff_pool.h |   1 +
>  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--------
>  net/xdp/xsk_buff_pool.c     |   1 +
>  4 files changed, 84 insertions(+), 23 deletions(-)

(...)

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index aa9788f20d0d..6e170107dec7 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  
>  	pool->fq = xs->fq_tmp;
>  	pool->cq = xs->cq_tmp;
> +	pool->cached_cq = xs->cached_cq;

Jason,

pool can be shared between multiple sockets that bind to same <netdev,qid>
tuple. I believe here you're opening up for the very same issue Eryk
initially reported.

>  
>  	for (i = 0; i < pool->free_heads_cnt; i++) {
>  		xskb = &pool->heads[i];
> -- 
> 2.41.3
> 

