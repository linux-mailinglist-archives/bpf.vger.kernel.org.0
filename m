Return-Path: <bpf+bounces-69237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45888B921B3
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F363B57C0
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6F13101D5;
	Mon, 22 Sep 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYm3M9WU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A83101C6;
	Mon, 22 Sep 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556885; cv=fail; b=DGGWB2DKVlDAAE8W1QrH03xA5Lc3K1nidluyfx7r0464Qbvm5vdvZk+9a7oiQ9SsVypmqyKduUUTWB3NynkZP393csXkK7WDae8H6BUmjWTpStETLNE9h1Tdriu7gVq3OHjpg+HDy+H+OeaUeJXG5SVnD1FWI75CSVJtImEOSjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556885; c=relaxed/simple;
	bh=jI3JkirzZdDPwNBR89Afg0vTb9ERTQUWPebqUwY0+08=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cdBjuP4EZzpMbKIOjL5Bq9KeiCekwrH5YJry14Ny2ysON9Kuw2zBVabgmbBkRAZe8M4huOuMxRM0I4MLRx8lno/pPUSHhBUvDFo6U7fwHqpRa6HM/17E5FNDq4meRholG5RhskCSR0zTxzEHz9UEcsyDYTEVT0wleX5roOO74lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYm3M9WU; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758556883; x=1790092883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jI3JkirzZdDPwNBR89Afg0vTb9ERTQUWPebqUwY0+08=;
  b=eYm3M9WU7KYwR+5yGrpLAW5At6/202usAITJfY3lvTo3gMq0xRInvqLC
   pLOTfDJ3VikPcZo3vYxjf3FN2k+3YSl2FLvB/4Z1GmdJVzvc1rgZaEziA
   XU/vZPfQfzsxrzwOUMPXZ+oBiBj4dEGsAbVQJq27VjwScDAppPDaa0jzd
   Aq4YDhvpf4H3yVO2lXHRNUaH57NyUSL4hLabV7ObQd/fkVaQ9AOtN2+KM
   E1VtEb7UWB6WsvODBXc66dSJj2eDsHYIciC5X4eCdN8xyQJbmZjohGR1/
   DHG3OqJtg8F/9UHTtlPxDh8xcq3d7lNuGe4MDjnFz5D96s+gplAD7BQZ6
   g==;
X-CSE-ConnectionGUID: nf15fBYURmOaE+Kv1f5ZUA==
X-CSE-MsgGUID: I628irvCRyi9nd9zC1hJIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60877249"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60877249"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 09:01:21 -0700
X-CSE-ConnectionGUID: 1OgbKzudT2K/bwPdNDmgew==
X-CSE-MsgGUID: jUzFuFP9QUak+zi7Uoj5Og==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 09:01:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 09:01:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 09:01:20 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 09:01:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh5LacXlBZM9CeE6kU9zdxCkK7sAmHmFFEpS/Qb0LQdSolDUbaVQPA38wxquRtkgFE27i+D5moafKLSEDx9EXoyf0wh6mdBVpeuXqPXxnGHIoV9zt4NS1XZ0fwxmp1xkWACarNILRvWhuM746dxjaFAwbU/fsGv8CZqVw1ST5lz2DbStBLn2TXfreO3K7Yh9LvGBnQSY5O9m89uQfguzWkFfwnjHvKI7UgC126yL3fAOvnqF+4P8OlHtLiXRSDrHDw1vDXSHQoTsdb852dE2HYYeFeiMsfXCmj8X0Y80qJ5DEvBBS4mu62C9LEY8uxwHKzo5LeLATpBV5Z3JgM6c4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSQpfMhXZ5grhMDffCw1IbJNagSNva1K6kfuivbBzUY=;
 b=r51j0zgOR5OZowktEeOv7D49zeT3CfgDMm7no+e+hPb/wBpHFM3111cSMGhq+VlI2GFQQ9mSySFk2DAe/1reJ5dxDT/aCwti0mls0ulRoeK7eqwAl/CaX0HPurjidb4TgHIz5ubrqxlcsjcs8io1VKG7t8p/CIJlyjJ4SwBZdSmaeyphH5QpGWxPnh7vdqR3DVqfRhKdiKnmPW5t49/ym4baGzriNs65U8g0i80lBkg2ZsAjkiEKrarozzAaf4qGo8d+mY1GpT86PThEnL73UqyaGsd8LNdafRND/jqgwCt30KXOKAP1Aq8VfUf+T7tziInazo01q+JeMWzcHfx8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Mon, 22 Sep
 2025 16:01:14 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 16:01:14 +0000
Date: Mon, 22 Sep 2025 18:01:06 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <kuba@kernel.org>,
	<davem@davemloft.net>, <razor@blackwall.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
	<martin.lau@kernel.org>, <jordan@jrife.io>, <magnus.karlsson@intel.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 10/20] xsk: Move pool registration into single
 function
Message-ID: <aNFywr++x9VIgT7W@boxer>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-11-daniel@iogearbox.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-11-daniel@iogearbox.net>
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
X-MS-Office365-Filtering-Correlation-Id: e5ea48f4-4d55-454b-276a-08ddf9f141a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dDvPWzFaz2IUnT9taU42zvI7Eol7Vf5MWUmkKIrHPkQJweczjJtaH3NH1yLL?=
 =?us-ascii?Q?b5N9vpn3a85B4aFgTZToRmsANiQan3+9mPHstq7drRUkMyZFCGjmkw1b6rCb?=
 =?us-ascii?Q?VhsjHpzN6X9u39MQiFlaT/qdUYMCX1sJ/6NuRrcJ1DSHovShbv3kAQwZRAxM?=
 =?us-ascii?Q?ynM7izezbrRvvgLkxR23wAiTg6m8oDnxAth01SEDmZUs0+KLNMMhsK0TJZbj?=
 =?us-ascii?Q?UJT2DjSHWgBb8u+rNtN2DZQ359f4vBWeJQQbLvudlfH2Jq9N7NEEu5vrH9xc?=
 =?us-ascii?Q?btbry5CYlHWP4WQeSOhVLlu9dvp+ABpjFyksvzuU10T0J4bHUHCpq8fv+5cv?=
 =?us-ascii?Q?M9yOhN7B3xxyZNsJxMOSKF90BpOzH5K1EKzfk6KGo7kVPPBpyGxstPkdLfvb?=
 =?us-ascii?Q?mYtpBNZkr7u9dMRv0ORslVxr/twp6l/jmg6chI7Wg/bis9YrrirhRq4/rymm?=
 =?us-ascii?Q?56NpHNHTPRcvLSTcZ0sZ2JYKoPp2cBh3oihORMmSIaHztMywXsMfYSawr43J?=
 =?us-ascii?Q?hWD6lsm/BH42l6+2PQF2Sw++52MeSIk//ZdpxennCqBnbsaCf9CRBIlFjyza?=
 =?us-ascii?Q?FtsHwAkQvextue75BGuTS41qgC4PSZomR4vuUpgIrPlt92Z47sfSk8E/fo2O?=
 =?us-ascii?Q?yNiQCqC7+Jm8pNJ3tZhtlTQOvb5PQPDHUBMzZlwWPYaWW12rYBcTwtAQtHcZ?=
 =?us-ascii?Q?tvOx+RotYYKfxfv1FKK7cOZRbXpIlke9p0TD8AVsPhUWoR4sh6uaIfO6P9WV?=
 =?us-ascii?Q?U6uG80MTle4bGOBABctdzYi9Mj4fDsQy9WZCIJ+gd7YzY2Se2gK6iS7SXEqm?=
 =?us-ascii?Q?hmm24wAygde5cilhGimGHcXMUukg5FhtWHV3qOIRcZy06FK0d31mwy9dKP8X?=
 =?us-ascii?Q?PXO2qhvXRlltg+C97aPV5HblEoMKR4p9Fw9MxN8qlOpsL0VCpdgiLn42jpY8?=
 =?us-ascii?Q?as4EKs6o21jnnH57ZrtQaTYLMVU0fB53RT1ZMLwzovC6luOD4PoVKQHC/eC3?=
 =?us-ascii?Q?uZVI5EXT2IYFv31MKcoq4uJHVyckL0ojwHLq3/jY3yOpqezqDyv8nocDicAR?=
 =?us-ascii?Q?+BEQdMYyBD15C6MSyydNKoSv/MukRysqmG7HMsbXPjwSPj6/+Nm/ijm1Q27N?=
 =?us-ascii?Q?j7G5LFDm8ziunafTi7vsEzfmpPRj9hkIOJRGVF4yb2h1lCzBvD9zzuN/cd6H?=
 =?us-ascii?Q?f5meVTapPDmoJfsctq9OsA6Fck2BgPIdvabjc5eD7pp2GfpkqQVF9tCm6CN6?=
 =?us-ascii?Q?BDIy2mZnEg203gNjSB/rXSiLmoJqmWDrjVR34lpOwvzqcQc57aZn1cJoQBLU?=
 =?us-ascii?Q?nJqFm9HcfjXX5GVoPdlOsikajKBhENQadzY63yKhb3Z9KRtLM/pfzkn7P+wj?=
 =?us-ascii?Q?RSmnlvdTwBqQ/hKM/I7rv+M0szLqKNnrlxjQ/hJsqi+m6GwL7XgmbQ+grcdH?=
 =?us-ascii?Q?/PqNqNKL7Qw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fggCj7etxiTL8gKsA5BpnbAE1OOosZCid+Erw/BaMma2fUt82L/MF4YUZjh9?=
 =?us-ascii?Q?dMphdZ6JXT3dGCbb0LV2ElZbtxKXRua8rxFvX5VLwzT0+VNzHJwQc2uLoffe?=
 =?us-ascii?Q?xNpY0QY8JdJOi/ug05TLC3ax7GhbGxHCRu8COhYNOUYlWUX6MOMrXla8dnCk?=
 =?us-ascii?Q?VzXXJkOOcfOH1csqmypaKnqC4euoSUEpgE+eO83KrYJ0YLUU6Yl0U/WwxFyF?=
 =?us-ascii?Q?T/lP5jRYeU7cbtCi2a7SOzDz2vQCcq1thWhS8ILkngyf/ANFHqno4fGHn4f6?=
 =?us-ascii?Q?6oEAZDGXpZUN30itLtgYImKv+96oFV1Ba3KDi18gNQQBatswm8BMaOKnLm4D?=
 =?us-ascii?Q?wPN4/hyTD6YQIXux+nZPqRT/RYlLw2lAe9v6ZRkggMNPXeAEiTlFRFH7v7Xv?=
 =?us-ascii?Q?6zFW1g+AzP+ASy475gkb0pCGqpGy9ShIZ+KI9/TeVgtEdYUzsXiASPSWeHDp?=
 =?us-ascii?Q?3UHUx03IAGmIl5SF+04vSWhbqf5J75ke4NLpBHXcfCEaVtefQfKbfszSk/+U?=
 =?us-ascii?Q?njGMc3NkUEmOU7kQDUBHPysVd6qCHf4S4xid1zzeaWF1Xba48duLlDlwA8Fo?=
 =?us-ascii?Q?qRiEUbdwsTtCgupbf7Yn4inq6N8s3tFanZHxrUGn906WXIz9Sh4YPofK1z7M?=
 =?us-ascii?Q?Yxxdz1jbzjS6zEvpgxNVXaFjNj8I2rqQ8+PY24aF22ao/Q3g72lBG2WZFPLF?=
 =?us-ascii?Q?grFIKnvG+Jsb7oezieJfruDYhHrAUMpaEA1in7calGoy4qfcV4t+o/A4r7K6?=
 =?us-ascii?Q?SPi4e9uQ9E8/iFCrZnG0S3d4sL645RMjYhiFEAJc7qUSRzFOZbjX1/EGB+b+?=
 =?us-ascii?Q?Q917eKElxabyxeaujQfyXTU8uCX3DhaFgxRb0E+J9w+U9icgB+2WuXeKOGT1?=
 =?us-ascii?Q?15aBHvt0U5Sp+QHXagUbQCs2GrXIKYxrIsdfUEIXyueFSmVFJozXPDxTuA08?=
 =?us-ascii?Q?aaEOLSAp3gXjdHI1pew6X9qrt8Vpl7eGdZFe7iiWl4T4VcHpCBsnp4+GpI7H?=
 =?us-ascii?Q?8ImBP3ImAPWyUMpezFl/qAoClP8tmSCYCahAzq5JgWR+2CZd4RkqZ/DpTAQO?=
 =?us-ascii?Q?YhFhtAfKItOcDzGCDdiZ5zZ1crZErPqJhVHgXwmyqjtR/+AeWthXnyeZ679g?=
 =?us-ascii?Q?UM7eFgOrwq4L52QipjjP1Ca3hu45yLMl81vGQLe2vXAXjM53N6riqvfn5odx?=
 =?us-ascii?Q?ZcrSo25S1FbbXrV2Pw/fwL2cdK610524LxFXKqgkX6yRVNElSu0Lasgx0FKU?=
 =?us-ascii?Q?Jf2VuFuSaivAEKqR/Zf1dyrDS/hl68EEEMlYuPnl66pXlVtwywSJbHe6gG5B?=
 =?us-ascii?Q?ZG5QgG7qVqnzO8QOFFgfl4hoCgHO0Vhcstc+U8xGuz39PVJ2LrucfQuMluc8?=
 =?us-ascii?Q?O/UmvOVHGnsqCrRtcjIs9z/3OsxeyWtZpUGtBdZFGHSmpjdasxupOEQb1nBS?=
 =?us-ascii?Q?zyb2ahqlvsb8mPz8ldkGC3QAbnkhsLKPFG4gdFRwbxQlRQG50KDM+IvCCwmu?=
 =?us-ascii?Q?gdHGXDL8uCww3x2VmLAxUZxct8yvyQGP4vUhdOiXN0nhVHUPypVoDnme7u5F?=
 =?us-ascii?Q?t+GuvJuz0HQJfzeOPK1FLIr0/CBPjKF8uXVSegkdVmnusRHuNbyk+7tSN1mT?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ea48f4-4d55-454b-276a-08ddf9f141a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 16:01:14.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzENlifVs6CziyJljDopZ4AWUYUXwafOYOaoA08VHaGrOg1gRJYZQbJWtINTKzWRT/mU47GrGwogI1rtOTzZ7EXtzQ2allUW2HYGpUVKSao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com

On Fri, Sep 19, 2025 at 11:31:43PM +0200, Daniel Borkmann wrote:
> Small refactor to move the pool registration into xsk_reg_pool_at_qid,
> such that the netdev and queue_id can be registered there. No change
> in functionality.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/xdp/xsk.c           |  5 +++++
>  net/xdp/xsk_buff_pool.c | 16 +++-------------
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72e34bd2d925..82ad89f6ba35 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -141,6 +141,11 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
>  			      dev->real_num_rx_queues,
>  			      dev->real_num_tx_queues))
>  		return -EINVAL;
> +	if (xsk_get_pool_from_qid(dev, queue_id))
> +		return -EBUSY;
> +
> +	pool->netdev = dev;
> +	pool->queue_id = queue_id;
>  
>  	if (queue_id < dev->real_num_rx_queues)
>  		dev->_rx[queue_id].pool = pool;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 26165baf99f4..375696f895d4 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -169,32 +169,24 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  
>  	force_zc = flags & XDP_ZEROCOPY;
>  	force_copy = flags & XDP_COPY;
> -
>  	if (force_zc && force_copy)
>  		return -EINVAL;
>  
> -	if (xsk_get_pool_from_qid(netdev, queue_id))
> -		return -EBUSY;
> -
> -	pool->netdev = netdev;
> -	pool->queue_id = queue_id;
>  	err = xsk_reg_pool_at_qid(netdev, pool, queue_id);
>  	if (err)
>  		return err;
>  
>  	if (flags & XDP_USE_SG)
>  		pool->umem->flags |= XDP_UMEM_SG_FLAG;
> -

IMHO all of the stuff below looks like unnecessary code churn.

>  	if (flags & XDP_USE_NEED_WAKEUP)
>  		pool->uses_need_wakeup = true;
> -	/* Tx needs to be explicitly woken up the first time.  Also
> -	 * for supporting drivers that do not implement this
> -	 * feature. They will always have to call sendto() or poll().
> +	/* Tx needs to be explicitly woken up the first time. Also
> +	 * for supporting drivers that do not implement this feature.
> +	 * They will always have to call sendto() or poll().
>  	 */
>  	pool->cached_need_wakeup = XDP_WAKEUP_TX;
>  
>  	dev_hold(netdev);
> -
>  	if (force_copy)
>  		/* For copy-mode, we are done. */
>  		return 0;
> @@ -203,12 +195,10 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		err = -EOPNOTSUPP;
>  		goto err_unreg_pool;
>  	}
> -
>  	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
>  		err = -EOPNOTSUPP;
>  		goto err_unreg_pool;
>  	}
> -
>  	if (dev_get_min_mp_channel_count(netdev)) {
>  		err = -EBUSY;
>  		goto err_unreg_pool;
> -- 
> 2.43.0
> 

