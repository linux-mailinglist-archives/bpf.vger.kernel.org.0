Return-Path: <bpf+bounces-53558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B88A5657B
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7911770B8
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 10:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF82153C7;
	Fri,  7 Mar 2025 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVgP2tSM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486C21322B;
	Fri,  7 Mar 2025 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343558; cv=fail; b=AR4TpQ+TuVHi0Remy6i7muGfkpaLIYnonrG9sWhgIL3akICiWZ14QUkTIwzBnGb1vQ7O2OhRYGGyLwpDus9TZOs4xVZAoglIDhxDl3txkrKZOKmNJDLyy6kau72QQQ8NE/KjJ/ERI5KpJ0wdxZkrdpRVhJSt4rhGqp/mcoBIoBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343558; c=relaxed/simple;
	bh=jwsLAn+JtTpmnxlcWv0GShayG6FJbds5DgjXUSuTlyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Esc8XFI8OvHbY2ELtNyjBrZWSlc7+/nZdSQFLL1J9yqfp/18drCU2v62fM55tLyoOIZYvoUjzovTigUKfCXX/JXYma89xzBOxaiiMkjA4K/DMK1iRZJOvCMzSqszVA/jx6hFlATQQ7xgQJ/VblZHwKIJXHPu2ww1q2+UxlzbQ1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVgP2tSM; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741343557; x=1772879557;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jwsLAn+JtTpmnxlcWv0GShayG6FJbds5DgjXUSuTlyE=;
  b=HVgP2tSMl4/K9e9rYHoItWIlPb7Rk6oirNK84/cSurox51jyT9WAHtZw
   qUEjG6MRT1Wp+dPw78oTCzcmKj89+hrww/Tv1DXTeOqdRoIAYmjz9+o2Z
   SB6RNuh/HOiGAKWUGkiJC75CzvaxSES1pSK6VsCZAAsaA7nXXPjhduImc
   DfRHJUW1M8AzINbO2yUC2RqvgIEBVRs3AsKpqELS2Vd06RpW7ARoNeRMm
   h1ln705v6L5C59/mHslsDOSc4x1t2Cssi8c/9cPQcG453NPyA+o1ke33l
   iF9b8w2XSj4UDtsTO6FUHysLKVSugX2FEVv3Z+2QsZurm2FHMU9nt6kCL
   A==;
X-CSE-ConnectionGUID: RZ3PJWjnTgaGrEKhZww7bw==
X-CSE-MsgGUID: AZZkOH7SRl2EDIx1MZ9IQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46314363"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="46314363"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:32:36 -0800
X-CSE-ConnectionGUID: tZBZmjmPQVquwT6cj635kg==
X-CSE-MsgGUID: S83F4E/FR9SsDRlAXi9sMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156499886"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 02:32:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 02:32:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Mar 2025 02:32:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 02:32:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JO9G1FUMOmxIMsYdn0NL+WGSA2JGVdw7NLkyUlxzBDGbSbgu+RWJesj08fkcjqkWnPFGl2j6+QRzLaKP/Ibnt+BTd0XsVmh9Cfplrl44RooEF8p8MUw6TzN/GwBd1wZMzxL5BkFRLazQdU47+GVlwT/mlQSRvqDzARLmGrKpNtV4YA86KI2frQD/Dm8inDblvMEf+as+T/RWKl1nMXPwy68nRE9kYF73BmCnLi59H8ZGhw8SBgEJoJjkQDDgKHltK2i4ny/GOiCNRmf8goWbuy+yOBEo4bIH2nfaFhcHzlrhJfrjiyYU4/zuAv7aXclL2/9iBDlQQGXKecoYUs9Bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoJD5u/A6CvM7Cy8YaC0mbSZ4h4IOxl3+9AHhBCqaDE=;
 b=JNPpymR6uWUujmllqxRpDmlwiFyZd8WndKZocMwu9nEUNE/fy+bxEkYJ6q75l/I++nPw3/QMkK//4pkLoMluCoW47gO0uiENJC2kNUPeuI7aT2vGDGoTvGGqAMYVnHvC2CnsPE94mCCNFhu0oM0ZJZK6Y9u/zQ+OjUTn8pYFZksG6E6DSV3dgqTeL4MOYUGy7FskjHYzUmFgPZGCba8BLjoV07RN5T9Tyg1Nghe5LsZPQ4DG1yExaAURvYHzxEGIFh9gfs0v6mNfx3uIpJ0MLhH8Kek8HMAdauG4fsEwj/Z/BgWk9ryVj4PRkdcMsV36ulJyKr+jaG6DCrJpWeJyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB5874.namprd11.prod.outlook.com (2603:10b6:806:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 10:32:33 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 10:32:26 +0000
Date: Fri, 7 Mar 2025 11:32:15 +0100
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
Subject: Re: [PATCH net-next 06/16] idpf: a use saner limit for default
 number of queues to allocate
Message-ID: <Z8rLLwZlRACyA49U@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-7-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305162132.1106080-7-aleksander.lobakin@intel.com>
X-ClientProxiedBy: VI1PR09CA0158.eurprd09.prod.outlook.com
 (2603:10a6:800:120::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c49cc4-36fb-4693-02f2-08dd5d635b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uzS5NU9UXtILmWWw8FgkR1DvsuGUu5dAOqdyerX9b1RpBIlbDWlPWNa0kYCV?=
 =?us-ascii?Q?Nmhy9re2nuN28iGv/ssOIUEsiMDSzpdUrDEj9MxAJpldR1+g1yHuMaxt4lEd?=
 =?us-ascii?Q?EETCDzJNA/lGWu77hojj74+G27J8dNsW81j2LEBd0TfYfDwgQWX9dzDiz6/1?=
 =?us-ascii?Q?Q6HqzRSMlDadORMA/0V7Q1vTuBGCIZQMHZC1E2jC1RJGBWgg03Bh1fNoFV76?=
 =?us-ascii?Q?6F/LJyxlX6vP5qy9urijrl6ZFFbJ979kY71OjINNecfl+XnmKmWTCV93NniJ?=
 =?us-ascii?Q?VWBi09o3k+rwtOsfRbkR98YAnn/YEGSOVXgUXwYND3sjDsEtIvRWNbbDzLUm?=
 =?us-ascii?Q?XowDTLirKmn8m6R0H+dYhrwTvsqBJnbKZI88teOI7n+LJPiH3qCCAHgXrzlk?=
 =?us-ascii?Q?d0fdt+9eaGQCa9bwnDyH+8MiHihPcwoxRK/tiqP/LvoKPyLg6bQsi2MX3gEe?=
 =?us-ascii?Q?Da61HHNL7tGz8XFt0IAc5nlYUwIEUX23mqXW7kwAawugGtfcwxLUijaJmkcN?=
 =?us-ascii?Q?JEpNaxOytiqYKUlqaGVwfK6gCitXMATp9m05uHEcgvT1uqYg7Vq08dcWi5K8?=
 =?us-ascii?Q?YfWdDPsz3Bhxiye/ckRDCZuwIqmSP/UzMstPQN8yqfTfLtsSsMjbX15Nqu02?=
 =?us-ascii?Q?LQ9U+xCpQVa5IkpVqoK+TmaKKDyx2hM9SXrs0nN+oJQRFSUWDTOeWTLHTvpG?=
 =?us-ascii?Q?sgUmiu6rpWD/KIfhIVjHOxa+/yrV1wVu58nY7tf3qxB/MWADepsf34UaTDfZ?=
 =?us-ascii?Q?uauxu9gQCzFEeTHWGba8Sj4bf/d3HWHHSi7mmI1BVeLLWkT4UJmCX4ZzIgzV?=
 =?us-ascii?Q?sCG8PFRKZg44F28BeVVDb+DOWD0gFs0MCyVTajXR4UTz3gzkJpBKRPfw+z9g?=
 =?us-ascii?Q?giwvGAXkHhBMTaHWhsXBR4SdWWhyecptxd+Osy5hwH/zpetMNM5eZY4c9E1F?=
 =?us-ascii?Q?qsIcEopsIkfKvpOi+L5zd8Ocp95n2UbHGhwXQNt0Cb1OX/9zg/RbC+GLmW5S?=
 =?us-ascii?Q?w5cOds00eHdiPFnHVfAErA3mwr/40BZtqeHixFGhVC/m3fl4Wz4fZlD4vgjw?=
 =?us-ascii?Q?bB0Y/Fy6OLci80B7KbVDMVVlGEFyu6/FlvxkskvfWVLXDj2FIsN+YypVwBWe?=
 =?us-ascii?Q?e6ePLYmDlCYnRbJegBtZ0axWMevQz0SER42ScM7SZNpYUEqLuZwH79zBUweH?=
 =?us-ascii?Q?xXv81AxY6zgWaAU3ZvGLT4fu5ZSdd8D4fga9dRQAxG9pZouw5wlYSKSAL2uD?=
 =?us-ascii?Q?A2KI6uoqRLzfgsy7oGbBKgWHI3/BMFEbH3sUtLE0NBXphasjaGtn88wIAIPg?=
 =?us-ascii?Q?sy0Ujmcq2WlPpLKZo9YY/JagRJCVq1MC1NiboQVmHB2bzZOZgUERFnvPNwAO?=
 =?us-ascii?Q?LhWflMtK+Enlg9X9Qua2/W5mUhzP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0znQF8WBQWLqyqd4hKuE8HtZ0ViUvnlt2AV7yLnittkwq6YYdfxhjOKI7mL0?=
 =?us-ascii?Q?gDiFRxUdOSamynsBNgJMdqEh13d7rgsFtQmIzZ6znqGLNIe+3zATokHxw/xq?=
 =?us-ascii?Q?kCQn9G4ZW4NSLZm3a/OxA1l1NQhUgQegUqzsIFSbZ9I7HNYp3PAq/wOn+7uD?=
 =?us-ascii?Q?P0Dc7dgWFW5KGMAgjcnoRk7M6B3M0vJx5hD603oXhXGifpIrdZGAJpi3f/+V?=
 =?us-ascii?Q?Xg7Fdh8AAyc6WP6nFQlsahHPzccmAhFCiYVtvr234aVlBhMYODzkQRYHPz/x?=
 =?us-ascii?Q?pta5C0/YCIw2gZnpcjn4cJNvKi6bX6jhPvMGU6UzHPGmoilKNz4fVYwnYiAS?=
 =?us-ascii?Q?RTTqHnmcl7disfUuo7YYZT7a7WeoRceTMOHqR8RYNNYg0hrN62OH7YfTFX/h?=
 =?us-ascii?Q?yEcujO+DvkJqfKx5miOlM5Au9IXbBWPOwPl/tgvWetTXeT7uGBb4iy0UzaXZ?=
 =?us-ascii?Q?MASsSv2NzIh9CejDQEi/Ddc4ugkIkzBo3wSI6A/92bZEkL+1Yk67PR5YgZ2V?=
 =?us-ascii?Q?EuFr4vizxZ5Q1pGbR0qyh+voxvpDAMC+jCFi0BRCuiGU16BIC3YiaX6Y/fGo?=
 =?us-ascii?Q?9A02HkLcbr9h+9RFUCSrGN7UhFoaSYPMQmiwHsmPIARMUXCihzR18DUxfQf1?=
 =?us-ascii?Q?0t8DD44LZkjO8OmrLxAPwC65v+DKEh9n/4mqbJ6sYcNPED5pk8se1JtVrgE7?=
 =?us-ascii?Q?RUYwb+7jQ3By051CwGJqtpFe9KrINoA5SU9jQYrZ2HTt6kq5rI5fArs+WNx2?=
 =?us-ascii?Q?sQIDn/fC6VCdrsSW3MtIh2ZqLR9rETnjkz/enF2a2eOK5iwUNWZg1S4NiXlg?=
 =?us-ascii?Q?m3SXFdmE2oy4OpNe19tCmdwh9dGMsoqqfJ2Xcyw4LgYLS2pYIqQvPI1Woxa7?=
 =?us-ascii?Q?qFUqUqCt823O5JgwPY/t37Iv9s2eblCa1EjkoyIMfozplcVxnKCGWE/Gurra?=
 =?us-ascii?Q?sodptXcg8EkilRQO9XPqtFTDyro68cCeGJiy3tSXbiRvg9WixxPzd851Bl9E?=
 =?us-ascii?Q?lQnfZntthBaNqez1EwrXaZE6sdQarBYuZ+Ofodz2aqlADgAyE4kA1+l06eT5?=
 =?us-ascii?Q?dZrdkYm0xZvIMTeiZtJY7USXissOXMCbCjaNrTlkfs3RJHXvBO8HpCUnamjR?=
 =?us-ascii?Q?ZU7u7G8dsw1Dhb1XRv2Uwy+vTqNgWMLGIg4h9QqmIuoeEEHqWkFQ/NnQuVwC?=
 =?us-ascii?Q?fX7t8vL+So1hiEs9EiXhb9hvwEcLN57KNkpYuy02KuWI59nsw6h7i/lW8Y+n?=
 =?us-ascii?Q?K/PK0bicfW/jslwQBh5Jtq/dejQ2SQxlIiGPi/RKaZnMLXaKp6pYToZnmUXC?=
 =?us-ascii?Q?M4JjWuJ0RUFYOncsB/H18Likq3MLdz7B7lpqD0WizvDKRqOOzs/yI3NmS2a5?=
 =?us-ascii?Q?wkahul3Cp5QjOD5CNzaXUl64Q3Ggb9/c0KmA7d4tJj9VRSzsF+Kn69qSpY3o?=
 =?us-ascii?Q?zBy9eukaBku15cGpVoYzWdDgyDXEqQzAn5Yiv/XMe2N9fEvLCKJaNFT0efuf?=
 =?us-ascii?Q?gx2yj/06TexfZcG8ur8EKdm6N3EBQ2/qvZCkuKEcglTrMkKqkM6QiBePIHqn?=
 =?us-ascii?Q?v/a/jcppjdUy0Ga7S6xVMtoumMg2MGYz3sfV/dSm+BYSSV7K9+jYRd0JZ8o3?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c49cc4-36fb-4693-02f2-08dd5d635b19
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 10:32:26.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Qx8PE+6poqxPtpN3oqL/yVDhvJ793IlvPP719vX0oClJw0zsIEsKEYsMiYVaJ7UJrznjCdG9LrjnfEax8WhrdR84CzsoWyjXggPJ6luOL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5874
X-OriginatorOrg: intel.com

On Wed, Mar 05, 2025 at 05:21:22PM +0100, Alexander Lobakin wrote:
> Currently, the maximum number of queues available for one vport is 16.
> This is hardcoded, but then the function calculating the optimal number
> of queues takes min(16, num_online_cpus()).
> On order to be able to allocate more queues, which will be then used for

nit: s/On/In

> XDP, stop hardcoding 16 and rely on what the device gives us. Instead of
> num_online_cpus(), which is considered suboptimal since at least 2013,
> use netif_get_num_default_rss_queues() to still have free queues in the
> pool.

Should we update older drivers as well?

> nr_cpu_ids number of Tx queues are needed only for lockless XDP sending,
> the regular stack doesn't benefit from that anyhow.
> On a 128-thread Xeon, this now gives me 32 regular Tx queues and leaves
> 224 free for XDP (128 of which will handle XDP_TX, .ndo_xdp_xmit(), and
> XSk xmit when enabled).
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 8 +-------
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 +-
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index c15833928ea1..2f221c0abad8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1234,13 +1234,7 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
>  		num_req_tx_qs = vport_config->user_config.num_req_tx_qs;
>  		num_req_rx_qs = vport_config->user_config.num_req_rx_qs;
>  	} else {
> -		int num_cpus;
> -
> -		/* Restrict num of queues to cpus online as a default
> -		 * configuration to give best performance. User can always
> -		 * override to a max number of queues via ethtool.
> -		 */
> -		num_cpus = num_online_cpus();
> +		u32 num_cpus = netif_get_num_default_rss_queues();
>  
>  		dflt_splitq_txq_grps = min_t(int, max_q->max_txq, num_cpus);
>  		dflt_singleq_txqs = min_t(int, max_q->max_txq, num_cpus);
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 3d2413b8684f..135af3cc243f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -937,7 +937,7 @@ int idpf_vport_alloc_max_qs(struct idpf_adapter *adapter,
>  	max_tx_q = le16_to_cpu(caps->max_tx_q) / default_vports;
>  	if (adapter->num_alloc_vports < default_vports) {
>  		max_q->max_rxq = min_t(u16, max_rx_q, IDPF_MAX_Q);
> -		max_q->max_txq = min_t(u16, max_tx_q, IDPF_MAX_Q);
> +		max_q->max_txq = min_t(u16, max_tx_q, IDPF_LARGE_MAX_Q);
>  	} else {
>  		max_q->max_rxq = IDPF_MIN_Q;
>  		max_q->max_txq = IDPF_MIN_Q;
> -- 
> 2.48.1
> 

