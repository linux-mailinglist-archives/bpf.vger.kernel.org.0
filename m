Return-Path: <bpf+bounces-35516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6893B38D
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9DE1F22D3E
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B115B13C;
	Wed, 24 Jul 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2p7ArNd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802015B130;
	Wed, 24 Jul 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834646; cv=fail; b=CQ0fQkvLXJNGdUPuf2KqFJuE3FiY6lTUtkbcW6Ig2ptXXn6Z83yiI7iqWx+A/ZeCPMIfB1Ph6GXCL+BCqpHgHR60oAfp27KBbqvOxUAOrF5a4jBn4JnSz7FXgrgBJ+Bb5L0Fptw9wRpZCCHtTbvPXbqCpPDGu4U5FBjwCCtpdLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834646; c=relaxed/simple;
	bh=nT3SreFCE7VzKC6valh0/HMZIv+3m1NMr8GzHSgEmss=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fXQYSV8T/ISMv0iS+ERMCBymfRNsZCe81EQ1SF1jV9sVqMSdUbXcPiJQatQ+S0E1DfE2mGGIMW4Vq9P2MH6HxPqc7yOlC6ZRQZrPxdZHJyf+aqXXZRo84Gj59n1UVIjBvXpqcf1waWh1ae+oCuFepvUix9KWpO5zCWB3sTnQ7IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2p7ArNd; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721834645; x=1753370645;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nT3SreFCE7VzKC6valh0/HMZIv+3m1NMr8GzHSgEmss=;
  b=Z2p7ArNdC5QJo9+G9GiLtbzPLixjCUL+WMfklCW+/SpRs0aw2XxWC1Ag
   mTze4eJRbkQKmkmyoTtgqoCzfsAwFnm6mYaX+i8ju7V7l8wJzmOIAIb0h
   42IwLdGfFbxulr/glmKF8/9LbmVwsJIkJ2FGNsOI4UuCKlK4XwZQXi/R1
   ESdnDm36B/b8bOjXz/ZNAeXzDwhyrBDN/roZJRIsWKplCkcXI8DTYqm3Z
   CdzQk5JpW3bymq4J+17L8S0G6TH7iLiI0y+HtDUBSclwMQSyNQd4R0Qsi
   Foh6tUeb9ry0B1+GaJOGSQOKTu3KmfT1MzlRXOeZgx+jM5PiUBQau73kR
   w==;
X-CSE-ConnectionGUID: KPXIASHKRKmPsXA457P9aQ==
X-CSE-MsgGUID: rmM/W/xvQeWjnqwPZ6F83w==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19134027"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19134027"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 08:24:04 -0700
X-CSE-ConnectionGUID: 20dXDtgeQuiLtIO6A7GIrA==
X-CSE-MsgGUID: 6BkbZM6URqSeFC8jjgE3CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52302182"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 08:24:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 08:24:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 08:24:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 08:24:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 08:24:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8M6C1qE7vgXxUEBONMZIpShwUCAwqkgDqWIqURIENThnTHgxY3brGlEi8fHHjqAETrPmv+1Z/R6pJI1whSLQ9hzw9q+vO6igenxKW3r2/bMiaG+4mdtxyty1v1vhutW8eccE/YLMvOGnl+frounhgX7kzWvbTi3EahRE49uV7XtG8OONPosRqcnT9oi1xZQ7aX+LkL18KRvy7Xyub3c0qSm9spHXo05iXR0HVGzgwGocfr1Vmjo6jW0Px90OxVnzMjAfc9mJgbqGIf74KRm8uWOQJ+0WGAsQoo/opzKcaJgY4aieG1FvEYyJ/5o0lJT12rQ4MDI8rYKwK0czSq8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWH4lDs08+v+4qfewE6yvB1LrBo8Q4DozMvqrQW+JzA=;
 b=PrtuCxtcEJhUrHHPAn+elyhVYKKH+aLRus7QM/9cB5GfOEMIAZL0EkFRVzRcG7KguPyktiLiFkxIvMvQgwjUpNUNwOjdj07pa6U1cotHhi/bZnp0PYhA4z7PPKB0QJFr3E+19fNpnkq59alyBRlJQ47376gjLlly5G7iiLwpjFvaYVsQU+rCZ3Vpo4jNMP16v2H5IfYvkUiolkdOVPmpH8y5rOjCRLAj2OcveD54ekAh/uT2hF4t31p4YHmmY/86FHB39UeH6py/zBYYrzwxWtit5wmnLt9dOBZDIFh47F2RjS4PZCnJsY+V2Q7BLRrU8k0Dt9IY/IBxJte3z54MdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 24 Jul
 2024 15:24:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 15:24:00 +0000
Date: Wed, 24 Jul 2024 17:23:54 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yhs@fb.com>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, Julian Schindel <mail@arctic-alpaca.de>, Magnus Karlsson
	<magnus.karlsson@gmail.com>
Subject: Re: [PATCH bpf 0/3] xsk: require XDP_UMEM_TX_METADATA_LEN to actuate
 tx_metadata_len
Message-ID: <ZqEcim8E0qK8MRQO@boxer>
References: <20240713015253.121248-1-sdf@fomichev.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240713015253.121248-1-sdf@fomichev.me>
X-ClientProxiedBy: DUZP191CA0046.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ce82a2-9bb5-45bb-30ed-08dcabf4a4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Y6tLoJIudpO/5a+tq+fJbGxDfiTd9l3clVbE0dwEFa9jBKyvAcYCgDr10dp?=
 =?us-ascii?Q?ykw6Xydk0r5CeMwN7MiTC3PbIiPMgDlF3cnIzUb+nK6Pwc6bhlyV/BuQf/W0?=
 =?us-ascii?Q?ZU21DxF8DPuwY6IN36DLurl5IyPMlNNJlWbjk8CRYMkhptu0Tb2cX3sW8c1H?=
 =?us-ascii?Q?5e0FiYXuXGdF7ZM89Rx/vI6/Rjg9Szm5qnywDGNVPeCqOOcq93XKRESFdNCh?=
 =?us-ascii?Q?+CVz2kJxIb6Mf7FfuuDrYqY9SympI05rkIGGWZCSgomCN90nfgtnpzSs+2Ti?=
 =?us-ascii?Q?W5Dg6yht5izg9TZ3VfApbio6Tfy98ckXzLzIl+lQ4IbAv+GTU5iYvG31oTo0?=
 =?us-ascii?Q?PvpEXr94xLN7HFvGprt1xTkAKTwM4G6SqKfkhJ0ZlY0quiGuIC1hRVJ7VBYK?=
 =?us-ascii?Q?LA7CVjDCgacjZ8Ky5iht6ZvHNG9Ls4a/ONz1UbTu7wp1rv7QEO+thAqIHTZa?=
 =?us-ascii?Q?gSVdAPsQuqFNyUngkdZ9N6HeZ+kgheLtl+Znj8DYNly9q9GbHY74pDQa4Ex2?=
 =?us-ascii?Q?KHbH3LFd006PipsDHVj3soDFSR6keW3ahabk0EkptGkkXGbCS/H/S2nFZRvj?=
 =?us-ascii?Q?blrO4nmJuZOzKa5n495yFje9KAhBrWqNbKPFJvd1Nw/iHGlmeqeyp1oruofS?=
 =?us-ascii?Q?dvmK93UjF3y4SclgiOydixHrlsucdn7M+y+IwvnBUU3tnS2KRvPBiADwhoP1?=
 =?us-ascii?Q?0lRtpUKkCgGn9krUGCkIu8OLhOUoWzBUNpSJv+u2q8LxGNfhA6iJN+XRgp6w?=
 =?us-ascii?Q?hNT06SmOC5TzcABr5Z5mT7otWEkUJMxQXNEck3Mvcefch/hZmzHSVgoR/5eL?=
 =?us-ascii?Q?zqC7MrMD6/Eu7ymrzbvbEhPL2pig7z+byjBZwYQ//EW3AjkjbxPr7Fi44Ffv?=
 =?us-ascii?Q?40lZ6+INBroKRfFd1CmZsyGtQOC7jbSN5b2praBXwX6zwxhQKgWd56IDt4XL?=
 =?us-ascii?Q?rUUPqLwirssagGvM0vyKhSvvVI1E5/5RdODrKGsK+0YfbsbyOeOEStq2OofT?=
 =?us-ascii?Q?VZkumqrHSR+8Z04tuQXdsURv+JaFe6sgvnXiS5mx8qVBr1wKLcczWp6qYtT1?=
 =?us-ascii?Q?BsTfBCzsHzQjEQ480/TZM5zGWJ7HiymTlwfTxiqmVCASskzpCqcU0EzAKoEl?=
 =?us-ascii?Q?vkh66PvtyaLChPvw2i6YSR9eHrEAuHsARfCfNaNQaUAZmlaTY7bNY7+sRJ9x?=
 =?us-ascii?Q?u9YYkdovJNjmbCXJmxLn83blgCwFcizZaVmRkREyHBmy5b97GWO+F1Va/kDr?=
 =?us-ascii?Q?fZbwAT0JZMWLO0M2ywbGXNlEfJu2nUSClWxYEn0rMnT5uwaNdVB1ldbPCO95?=
 =?us-ascii?Q?uNsr7amI2VQbvYLuP1LMRDtePyXdsnX8Y8d9MspIX84Oew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ob+xazawEVm1FuN0iS6bKEiSOvPo9EcaaB2REUe9tQ0y4lBqaVaZE4LDm4j6?=
 =?us-ascii?Q?6lLhYo0ttmbzCrACm5VvF+phBjFu8tsre6o3OFxiwlSCfa6oTIdwKrBB70vW?=
 =?us-ascii?Q?V4iDLLZS2Ndfp3HvWHYStJe99pMODt4Y9J1Q7mHcvHnKEQPfNBp5o6bSVksr?=
 =?us-ascii?Q?Ver9z749bXo7xf+hCCu9F6QUMaNO79d75DooWHKr17qVoaEsDrRjVV4VPeII?=
 =?us-ascii?Q?HXMad4Vt3UDOEuY6jykbHyt37QRMx5ZzemO2tcfPOhDjF5W4dhN6pSPudhbJ?=
 =?us-ascii?Q?vSIabj2rJbN0UHP8fHdjSe2URRS6eqLSEAZaRGAbHDDNVKTSjaj/NprOTSDu?=
 =?us-ascii?Q?HK6/ZszUDX4aw2CEKrmF5rIrCKSD0E8dsLvdbqSk6gqRfxh110E4L0tCm237?=
 =?us-ascii?Q?xOt6uySd04hoNLTv2+b7JVndrBhvtFeCcylnMWj3Td19taLwbAs830bgPLnJ?=
 =?us-ascii?Q?h8QghBtnBfPLJWMCmUEb5/wtwvUUHMVz16edHpcEcCpaGJfQFUbq7Tb0nCN5?=
 =?us-ascii?Q?4yY7KYly+JdjlVB399+SojCTEgqeV9l2RK3LpVJUkQj2WSL9l4GMOTfL2pID?=
 =?us-ascii?Q?7Eln70U+c7dIE9a8m/o9Z+IDM1RZZlWhH+ERmn49xK1qKD8CF3DjXDX4VHj9?=
 =?us-ascii?Q?bX1VWBV2dQu5hAwLnSEkB8kCPGv75mRMYxiUABVwi1GWNa/LTUhzRghrKrSc?=
 =?us-ascii?Q?tAfhSShZMbvZuZOe66tDIwQcuzvpMzU8W9Em6WhH+7rGlrEIdqhNH1yl8JCg?=
 =?us-ascii?Q?zY2l7ebaT9EnQWxiGmkmFWekuKVHg8N8bj2t0wMebGVVMjidqxlXtc2ylmNi?=
 =?us-ascii?Q?3AtHFwhWo5Zq+Yzc0QOGV656bQAsDFcQh7a6DOFhNuCfeG3A5fMtd0gY3Ux1?=
 =?us-ascii?Q?CIVmnwhi0TonkntdwFQNslQ+3pftqU4RzABdbBEyq0Inwpz56o9s55Uk3jAN?=
 =?us-ascii?Q?PIZCRoSbpdGbNBYr2yuew2qwaqwdqpws354uO8n3qu7uHbnX5tF+CrBxEkfI?=
 =?us-ascii?Q?MFixA0h5R8f5HvqVvM/2ehEqFsZWwe/HXWLS15hKTzHvUN09GlceuVlQPDf7?=
 =?us-ascii?Q?QKWxSuDb4O4Las21kNkg4uMSWFqif/drGoES4dHcVxTrYb46bEHkbkTwFHob?=
 =?us-ascii?Q?ceDdmpMZTrmGxq4qtx7l5xEJbevCzJa8s09LCEtHiMRSZcppxHr69fBHDwhl?=
 =?us-ascii?Q?sScVmEphfxBoWWcnCvoXmu4muwRvmUksFgPksB19vEQJWAbY+0Vn392Oizgr?=
 =?us-ascii?Q?7ia6d9SQ3Wj/JZe+ciap+rekmL3Qckeqcgo7A7/V1cCUcXZG7HmS8wRL2UeC?=
 =?us-ascii?Q?rI+ogS+w9DFEfkXD49yv1M7ogje1Ue9LwOHh8HVyrl8EO3EM5saNPZSnToQh?=
 =?us-ascii?Q?xPCC3p6no8jFrRVR3vKO6a1bo597D+jozFEyR8HWu2RK66I6JBgXmcYQTEzV?=
 =?us-ascii?Q?TlceWCLjIHk5gKnkQBZwXa85LTmsJ8Z2dhmDlZUsXebMtjBtyCrYf21AUxO2?=
 =?us-ascii?Q?T8D5KnCVrcrSqdL7OSeeZ0d+krjD/y8O3eAk2WSOy6GhT95GQSGWOuC0JAvJ?=
 =?us-ascii?Q?viJtGBUNavLGCmYxot1F4JQDs3snYjovLmcsrXHYEr4JxESM+N1MuHYQ1mh/?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ce82a2-9bb5-45bb-30ed-08dcabf4a4db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:24:00.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdJ2IrHeVIx9nPyNt+frLyjEVWoOBWFDvbWmnQnXuSHuiT1Penl8xG6dz/2+O41bih0vgPFaJjgCDoFO6t1oRWTxDltkzEK1G4KpxO6+Hek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
X-OriginatorOrg: intel.com

On Fri, Jul 12, 2024 at 06:52:50PM -0700, Stanislav Fomichev wrote:
> Julian reports that commit 341ac980eab9 ("xsk: Support tx_metadata_len")
> can break existing use cases which don't zero-initialize xdp_umem_reg
> padding. Fix it (while still breaking a minority of new users of tx
> metadata), update the docs, update the selftest and sprinkle some
> BUILD_BUG_ONs to hopefully catch similar issues in the future.
> 
> Thank you Julian for the report and for helping to chase it down!
> 
> Reported-by: Julian Schindel <mail@arctic-alpaca.de>
> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>

For the content series,

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

However I was not sure about handling patch 3/3.

Thanks!

> 
> Stanislav Fomichev (3):
>   xsk: require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len
>   selftests/bpf: Add XDP_UMEM_TX_METADATA_LEN to XSK TX metadata test
>   xsk: Try to make xdp_umem_reg extension a bit more future-proof
> 
>  Documentation/networking/xsk-tx-metadata.rst  | 16 ++++++++-----
>  include/uapi/linux/if_xdp.h                   |  4 ++++
>  net/xdp/xdp_umem.c                            |  9 +++++---
>  net/xdp/xsk.c                                 | 23 ++++++++++---------
>  tools/include/uapi/linux/if_xdp.h             |  4 ++++
>  .../selftests/bpf/prog_tests/xdp_metadata.c   |  3 ++-
>  6 files changed, 38 insertions(+), 21 deletions(-)
> 
> -- 
> 2.45.2
> 
> 

