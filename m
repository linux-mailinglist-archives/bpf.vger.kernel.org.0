Return-Path: <bpf+bounces-37855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1982295B408
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 13:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3BF282B1B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF991C93D9;
	Thu, 22 Aug 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyiCetF6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A9F23774;
	Thu, 22 Aug 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326769; cv=fail; b=M7NiZxDMGhycwqa476gDEGdt+MjdyiFasBs/iDNqAJ+xnX2Of+UIblEJI0IiWMYARVtC0qNyQbhBLj3vrHroOAvASvcUfxzxcVl++Z8cPapOr7OCUVpQ+LVuwF1Ntv2VxgwHIotJK2m9gCFI+H+I/wynKKrmsv2VDunuvcQQtiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326769; c=relaxed/simple;
	bh=h0OyhdDkFUVaPTuDqmJ9PIoFnwFMEn3DQuayxNq+Hkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WxjWdVYKgq4d8r+4JTZMac5Q3p/GumlvZKUTtk9bJNP7wt6Q8OaL+4zI/ni7tZCGJ5TV0nO0tJAHRjtJXmprDcfxAzOlzPsCA4swR5jU2holJH1qHswUyUZZCvLvtEkOcAPu6WqGLhQcoJHeiW82nDjLgQ16ftR/p5vvnhEWzXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyiCetF6; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724326767; x=1755862767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h0OyhdDkFUVaPTuDqmJ9PIoFnwFMEn3DQuayxNq+Hkw=;
  b=eyiCetF6Mz5283Oh2cGuh+yFgmBoPdp9P9o1OZdqe5Uf5e5FwYP6WULE
   YjZ24v8ZjgQl3849w6diOQzX/E9eDihBNmW4oactBuQafx29xwEe9+thf
   AdBFhB0J9CNe3MWg4fA2XyANk27iksRLuWkzdi/MECjjU+P7YDrfcGbXb
   +jecv4zjGZZ2K2nnUDNfIJBOxNp23hi89SKpugomc4T8mZJcaRH4J4GjC
   CLLuaRG45x1WG6p41yTIRyqgPGQMF7n7wvn/fLmt1WZQNqIT6uapooQjH
   FKXbQqK668a822x6azgRkPDG8Z5Z0T8n7ZaV+lYlXtSi/+KTdl/0GP2nP
   w==;
X-CSE-ConnectionGUID: sh26saE9R/uQw2PEZHgQRw==
X-CSE-MsgGUID: c86kzynCQC27eXe/4yyDqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="48127480"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="48127480"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 04:39:26 -0700
X-CSE-ConnectionGUID: c1SnhWJBQiCRKT5I6Ws31g==
X-CSE-MsgGUID: 7vlB8o7fRRK+q/V56bvG/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66304484"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 04:39:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 04:39:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 04:39:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 04:39:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 04:39:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a37L5eqiUm0Nxf0e2HDK/+SZOZdLDJT46YFo6kcYK+UY2KE8cAE9uNuvg7+TXq5+Jeh12rTEV15FI/t5dDuGx9hm7r/YK581y0Kd+EfyhbKuS+wU6kk+/LZ14nMZU71vpZGm0DYoNbVNiaJoQijHGn1gt8g1Ub14ttPnUs3OT/WkjOoD/EjydqHXHiV222poURsjKo28M8cV5jEIXIv25igha+KARwd8o63iwdWtlX69OhoyfNiuvcnM8LqfCRVYOLgepAmFuWLo7pB5iN4qq5JLfmtT6wH56fnxlTS5TLqazCDw4+rP6RUYSi6VSXRGp4itEg7rr8M96Bh7+N6HqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9OuaRNANlfviZIqw9bApGHFUEAMgTE91D7Y6jBqzNU=;
 b=rNQ803eL3Em9itXpKAnjZgKvDAI0bqhjusDmLYE+WgaJmbJo0ku1EJkgSL5LswLjsmNGRbRFH4Xtq3uLEMZkZOhDWx5676QhGgv6PaYZbQhteaXeUZvEz0phgV8yKM6tnRnzRwGAe7iUz54pprhBenNUSh6X2Ag5May41DorRYyAmXOO1c84VwCGaYTeOqMDo55ql50INnJrO9AEJWrNULi4XH+UvR16sKykquGgFdLjoYMbLa08nuvm6WTOomGDCRBmY0W7SZBceqTz3127YGM9sU/I43Cyy5XlIpTROkJQyTchi3poe/ZTFCleHzLqZf6JO5FDgxW+5bbBf1Jl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV8PR11MB8583.namprd11.prod.outlook.com (2603:10b6:408:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 11:39:23 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 11:39:23 +0000
Date: Thu, 22 Aug 2024 13:39:15 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>
Subject: Re: [PATCH iwl-net v3 2/6] ice: protect XDP configuration with a
 mutex
Message-ID: <ZscjYwHAv67Tsq2I@boxer>
References: <20240819100606.15383-1-larysa.zaremba@intel.com>
 <20240819100606.15383-3-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819100606.15383-3-larysa.zaremba@intel.com>
X-ClientProxiedBy: ZRAP278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV8PR11MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d94a72a-24bc-4b29-2a55-08dcc29f1194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I/kRXYUmt+el5bcV3Tm0yLS/sq+JBvtMtRibJPG/8fldCuwF79RBEp5nWc9v?=
 =?us-ascii?Q?SaWzGp3omXTXaLXwRk8mkRFuKHIwyt4Ec0rVeaiV9I8rbAYeahdP3PsmjLVQ?=
 =?us-ascii?Q?xMTlswHSllgcGds1xrBidm7wPMGHkaTfMSWVEwrLleR+eu9pHreCyTIe4l94?=
 =?us-ascii?Q?Fw1uhugXO5TF17sWHS9W7kqqkO/kZs6nt8HntKpulLkMuJvpmv2htVDOsqWq?=
 =?us-ascii?Q?Gp3W/sKsDg4FJMVGK/fiwaHE8K76c7sMLDPQcEsMrUTdjmR3oe27lOApaF6g?=
 =?us-ascii?Q?zwP7alImvjsHucYWrvxm6HF8+lAMGvddBNbAUEJWCFjCMUBx6IuZLLgYnKDE?=
 =?us-ascii?Q?l2v68Sw8uYogoWsY/FQJsge5vz3Txxyb1KMIBa8epcgr5I10JDdSSbo4WPEi?=
 =?us-ascii?Q?u1c0rYu1EZ6rUel3BCn60E4G6BoogafDDdOVwX6TtmvVMrVDmAE0hqE4c0ow?=
 =?us-ascii?Q?MZ/kyTISmbnWuYpWvh9fDiOt27zYoNNSXKoPykQJ6Xqwbvo/NKcu6zd5yQah?=
 =?us-ascii?Q?yVWbkwVpF+jSuXe6y8OhXmIvoLmctln1Mocq/N/F9Y0+P0NRnxP4jgEyxsm0?=
 =?us-ascii?Q?2cn0mlxEOh3p5ZN/E/wPCTGRgWDJEcRpaTGOS9y/yov7ASVp9XhKB42jQDQq?=
 =?us-ascii?Q?uzQRt0hWjkIiJokNhEU5HzM9LhE/qcfbXe3A6Se6nWurhI9DicYLV/UAjeyi?=
 =?us-ascii?Q?oUFG+ewGPPxv21Gyu723WKa1un7BNbrihYoOqqtwjbiazRRb1/AcP/Eh3N/J?=
 =?us-ascii?Q?3ur/fwb6DEOikD2P1CHydMtZbSlaB/B+azGhGQJ+8M8TOAc8FW0gpFZYwm/l?=
 =?us-ascii?Q?04hoHPHbKG33QlObTL0PwZJ4gbLYLWfhEguKASfdXQsu/UgiyrNY8GmHM0LT?=
 =?us-ascii?Q?fz6WjOIqhfjETRX6n+yLQB3qqGxXrUoT95JsNscgS8+GhHIf5vnCN7SVJprR?=
 =?us-ascii?Q?8x1GdtRDKiAeFePTSlRvmyBMUNgbmrIPsSzTvKqjxjeYQv4V1Mzisd/TaFjz?=
 =?us-ascii?Q?IT+8+ec0JKr9vftNrkZSixBkEKr6I7lWtp13MycwQSYNewvD1y3z27A0hFsq?=
 =?us-ascii?Q?Ke1bZFthxkk/gp4zfs8u85tzsVa1YNeq3KjntmOmz3z7BkSUe7mjDX+dlQoo?=
 =?us-ascii?Q?YZIjXKYCxw5UU1F9VUfjz3iJhBYxvjwalu2RHk3lswKH8n6e57I8NP9brWYS?=
 =?us-ascii?Q?bD7EllJsdIcueQC6V5T6pEjwTfwQTBF/HvJ6yLDHxyDMXMNOR7M6RJT2ck1A?=
 =?us-ascii?Q?aVZ9Sb/48oD2VMMoUcY76YWzO7vXA7l5rjiK0guzWh+98VXjVBeK1CADws9U?=
 =?us-ascii?Q?jwDBO5MsSAQPcmOAg0SsGF0eui7WdAeQgWSUHldMZ3/eBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R5PWV4zkYKY8VL2i/tQIFw6oJ8B4vb4PqqGuAfyW+804Kj+4irkQOQzQ/guX?=
 =?us-ascii?Q?8lJwxFMEH6U8I/5Q26oxkN/e3eG0S2Iwv1IUqpW4qoLZqG2FisNwAOShHmgJ?=
 =?us-ascii?Q?Pnc6+rbt+d7ZA/723CdXAPgd/XxvQnwd0luHvOlDrBllYNoHA2Xw8ViCeb23?=
 =?us-ascii?Q?lyaUiqSeME48VhcDL77nHhiGrJHwX0v/DPPmLr0bFGNYh0+2fnbGqG7/aFea?=
 =?us-ascii?Q?Tz1owH1Zzlun3QnikGgCUU1dw/VX6BvvnJDQkqB3wXo/GH2+mBVsB426cpme?=
 =?us-ascii?Q?JrFMpoZnZ4wLA6YJel4HE09CapkC5GpdQ/ydYHzCHqWK66BkoccqMbsc2cO9?=
 =?us-ascii?Q?kiO9DL1pipTL8/ZndDfX54EChVGQBxHKHBV7WFe7kRbLsFpFmeheH9dfD/9k?=
 =?us-ascii?Q?iylEfyUEhh1T/LHShm45Dn/taSRTx6MNJxOL9KPnWo4sQ6kYSIUgm9cCM1E5?=
 =?us-ascii?Q?YoJZmkf+i2fVe79K9KfXYQFFpvy0D7g18jWlPaTEeHci5hnorFhoD5L07kwm?=
 =?us-ascii?Q?HOWwIFg5BihV6+7myjP7dwFkI4k4/u9nd5zhzAUvujRWOET12y8lA+LADjUp?=
 =?us-ascii?Q?yMCxmWxjDawcp+Rd7sZ0ayM977Ard+oQDqctU4Ax1n9azsWl3LvyM5QrFsE+?=
 =?us-ascii?Q?+4216WACzfre/MSuhdO3csirv86qFPia6K6wLg2WgaXY27THmcGkUT/zxryj?=
 =?us-ascii?Q?sNDmicQCQ0oZtmrlAlCv6Lvy4RKWVfQL7kN4xaPlk1ZAGMMRJGoXqFVrkErj?=
 =?us-ascii?Q?WJUvqCBnMDpx3eZdG9qV2zN1SM/MlrZub5Yx4cZLtFte80xCzl0hDsJ/1iL+?=
 =?us-ascii?Q?iuZJdbwAqmhKgugZFiwf15+OHnGNqy5yFTafgEmbZGlllP8i8Ked1bwcJqmw?=
 =?us-ascii?Q?lc7lYvjUPlyVtphgtoGMktfv72RxnuE6WyEv6SqbnkNA3F7HJqCp7vlUntke?=
 =?us-ascii?Q?yZ59/RJF13EtK7MJ2pyB+uRyT/xqHXPoCXmc2ql/XN4YUmTf2nDftOJXoJwA?=
 =?us-ascii?Q?R64lEuyRwGyYfwIieIbka37N4aVem9hSM++MqvPdrLhVXIU+eI1u/OFr427b?=
 =?us-ascii?Q?u88UZ8x8diDUEfT/0IYgqXkOfCcCbqFo5ea52PEOsmK/D6VpyZKdVRGojVyV?=
 =?us-ascii?Q?3oTmbfHIJUU0eat54DEPXniMySgpJAW9Mx31QRB/JZ0TgXtYGFyCy6tnkGnA?=
 =?us-ascii?Q?HWC13roj1LLzKSAZDHZoAU7L3wY1BK6NKXEGIxFPFgE9TP3G8eGALBxB3tWt?=
 =?us-ascii?Q?7XarF6a/SDG9XXvRCYF/mnx0C4yIqWRjKkcvbo9KVhUe+D3H3+I1KULL+7Vu?=
 =?us-ascii?Q?eULVNfZ+0Sq54dcAdfwET9yRe2Pa1wtPOrw9NIHlobC0fQdl3TEvl4wu5OnO?=
 =?us-ascii?Q?1gQHrqc0OEDzMewQ6c1LAEEnVy+RVmoXSgo8exIc9nsUrXolBr2WBPUIRUrf?=
 =?us-ascii?Q?XyAz2qfYDs6NCZ2hU4BtVvr+WHnRwRCLWLFvb8tI9O5DU3hY3DWypEW0hKvG?=
 =?us-ascii?Q?1J7uEr0AjiJKcMoKEAPp4JraBxmj7Pfwp7LRp6l2QtP6bXZinLrNefN2OQDI?=
 =?us-ascii?Q?J4oc/8ol+76F0MkcFYTxovU3SvhaawhtminI9PlPj0tc0f+X3Hd7IvzycDbJ?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d94a72a-24bc-4b29-2a55-08dcc29f1194
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 11:39:23.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/9w7er1bxhsii03J2yrk5wCnHP+qM4zPoca5aS6qy/E8C8XRBaqbcv3pZdeOHAAgkiX261EeR2ZGn8s1sNm/gk3C5JnxhbohH3b8uEDeSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8583
X-OriginatorOrg: intel.com

On Mon, Aug 19, 2024 at 12:05:39PM +0200, Larysa Zaremba wrote:
> The main threat to data consistency in ice_xdp() is a possible asynchronous
> PF reset. It can be triggered by a user or by TX timeout handler.
> 
> XDP setup and PF reset code access the same resources in the following
> sections:
> * ice_vsi_close() in ice_prepare_for_reset() - already rtnl-locked
> * ice_vsi_rebuild() for the PF VSI - not protected
> * ice_vsi_open() - already rtnl-locked
> 
> With an unfortunate timing, such accesses can result in a crash such as the
> one below:
> 
> [ +1.999878] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 14
> [ +2.002992] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 18
> [Mar15 18:17] ice 0000:b1:00.0 ens801f0np0: NETDEV WATCHDOG: CPU: 38: transmit queue 14 timed out 80692736 ms
> [ +0.000093] ice 0000:b1:00.0 ens801f0np0: tx_timeout: VSI_num: 6, Q 14, NTC: 0x0, HW_HEAD: 0x0, NTU: 0x0, INT: 0x4000001
> [ +0.000012] ice 0000:b1:00.0 ens801f0np0: tx_timeout recovery level 1, txqueue 14
> [ +0.394718] ice 0000:b1:00.0: PTP reset successful
> [ +0.006184] BUG: kernel NULL pointer dereference, address: 0000000000000098
> [ +0.000045] #PF: supervisor read access in kernel mode
> [ +0.000023] #PF: error_code(0x0000) - not-present page
> [ +0.000023] PGD 0 P4D 0
> [ +0.000018] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ +0.000023] CPU: 38 PID: 7540 Comm: kworker/38:1 Not tainted 6.8.0-rc7 #1
> [ +0.000031] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
> [ +0.000036] Workqueue: ice ice_service_task [ice]
> [ +0.000183] RIP: 0010:ice_clean_tx_ring+0xa/0xd0 [ice]
> [...]
> [ +0.000013] Call Trace:
> [ +0.000016] <TASK>
> [ +0.000014] ? __die+0x1f/0x70
> [ +0.000029] ? page_fault_oops+0x171/0x4f0
> [ +0.000029] ? schedule+0x3b/0xd0
> [ +0.000027] ? exc_page_fault+0x7b/0x180
> [ +0.000022] ? asm_exc_page_fault+0x22/0x30
> [ +0.000031] ? ice_clean_tx_ring+0xa/0xd0 [ice]
> [ +0.000194] ice_free_tx_ring+0xe/0x60 [ice]
> [ +0.000186] ice_destroy_xdp_rings+0x157/0x310 [ice]
> [ +0.000151] ice_vsi_decfg+0x53/0xe0 [ice]
> [ +0.000180] ice_vsi_rebuild+0x239/0x540 [ice]
> [ +0.000186] ice_vsi_rebuild_by_type+0x76/0x180 [ice]
> [ +0.000145] ice_rebuild+0x18c/0x840 [ice]
> [ +0.000145] ? delay_tsc+0x4a/0xc0
> [ +0.000022] ? delay_tsc+0x92/0xc0
> [ +0.000020] ice_do_reset+0x140/0x180 [ice]
> [ +0.000886] ice_service_task+0x404/0x1030 [ice]
> [ +0.000824] process_one_work+0x171/0x340
> [ +0.000685] worker_thread+0x277/0x3a0
> [ +0.000675] ? preempt_count_add+0x6a/0xa0
> [ +0.000677] ? _raw_spin_lock_irqsave+0x23/0x50
> [ +0.000679] ? __pfx_worker_thread+0x10/0x10
> [ +0.000653] kthread+0xf0/0x120
> [ +0.000635] ? __pfx_kthread+0x10/0x10
> [ +0.000616] ret_from_fork+0x2d/0x50
> [ +0.000612] ? __pfx_kthread+0x10/0x10
> [ +0.000604] ret_from_fork_asm+0x1b/0x30
> [ +0.000604] </TASK>
> 
> The previous way of handling this through returning -EBUSY is not viable,
> particularly when destroying AF_XDP socket, because the kernel proceeds
> with removal anyway.
> 
> There is plenty of code between those calls and there is no need to create
> a large critical section that covers all of them, same as there is no need
> to protect ice_vsi_rebuild() with rtnl_lock().
> 
> Add xdp_state_lock mutex to protect ice_vsi_rebuild() and ice_xdp().
> 
> Leaving unprotected sections in between would result in two states that
> have to be considered:
> 1. when the VSI is closed, but not yet rebuild
> 2. when VSI is already rebuild, but not yet open
> 
> The latter case is actually already handled through !netif_running() case,
> we just need to adjust flag checking a little. The former one is not as
> trivial, because between ice_vsi_close() and ice_vsi_rebuild(), a lot of
> hardware interaction happens, this can make adding/deleting rings exit
> with an error. Luckily, VSI rebuild is pending and can apply new
> configuration for us in a managed fashion.
> 
> Therefore, add an additional VSI state flag ICE_VSI_REBUILD_PENDING to
> indicate that ice_xdp() can just hot-swap the program.
> 
> Also, as ice_vsi_rebuild() flow is touched in this patch, make it more
> consistent by deconfiguring VSI when coalesce allocation fails.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  2 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 34 ++++++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_main.c | 19 +++++++++----
>  drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 +-
>  4 files changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index caaa10157909..ce8b5505b16d 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -318,6 +318,7 @@ enum ice_vsi_state {
>  	ICE_VSI_UMAC_FLTR_CHANGED,
>  	ICE_VSI_MMAC_FLTR_CHANGED,
>  	ICE_VSI_PROMISC_CHANGED,
> +	ICE_VSI_REBUILD_PENDING,
>  	ICE_VSI_STATE_NBITS		/* must be last */
>  };
>  
> @@ -411,6 +412,7 @@ struct ice_vsi {
>  	struct ice_tx_ring **xdp_rings;	 /* XDP ring array */
>  	u16 num_xdp_txq;		 /* Used XDP queues */
>  	u8 xdp_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
> +	struct mutex xdp_state_lock;
>  
>  	struct net_device **target_netdevs;
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 5f2ddcaf7031..a8721ecdf2cd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -447,6 +447,7 @@ static void ice_vsi_free(struct ice_vsi *vsi)
>  
>  	ice_vsi_free_stats(vsi);
>  	ice_vsi_free_arrays(vsi);
> +	mutex_destroy(&vsi->xdp_state_lock);
>  	mutex_unlock(&pf->sw_mutex);
>  	devm_kfree(dev, vsi);
>  }
> @@ -626,6 +627,8 @@ static struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf)
>  	pf->next_vsi = ice_get_free_slot(pf->vsi, pf->num_alloc_vsi,
>  					 pf->next_vsi);
>  
> +	mutex_init(&vsi->xdp_state_lock);
> +
>  unlock_pf:
>  	mutex_unlock(&pf->sw_mutex);
>  	return vsi;
> @@ -2973,19 +2976,24 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
>  		return -EINVAL;
>  
> +	mutex_lock(&vsi->xdp_state_lock);
> +	clear_bit(ICE_VSI_REBUILD_PENDING, vsi->state);

I am not sure what we be the state of interface if rebuild wouldn't
succeed but it feels like clearing this bit should happen at the end of
rebuild when we are sure it was succesful?

> +
>  	ret = ice_vsi_realloc_stat_arrays(vsi);
>  	if (ret)
> -		goto err_vsi_cfg;
> +		goto unlock;
>  
>  	ice_vsi_decfg(vsi);
>  	ret = ice_vsi_cfg_def(vsi);
>  	if (ret)
> -		goto err_vsi_cfg;
> +		goto unlock;
>  
>  	coalesce = kcalloc(vsi->num_q_vectors,
>  			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
> -	if (!coalesce)
> -		return -ENOMEM;
> +	if (!coalesce) {
> +		ret = -ENOMEM;
> +		goto decfg;
> +	}
>  
>  	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
>  
> @@ -2993,22 +3001,22 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  	if (ret) {
>  		if (vsi_flags & ICE_VSI_FLAG_INIT) {
>  			ret = -EIO;
> -			goto err_vsi_cfg_tc_lan;
> +			goto free_coalesce;
>  		}
>  
> -		kfree(coalesce);
> -		return ice_schedule_reset(pf, ICE_RESET_PFR);
> +		ret = ice_schedule_reset(pf, ICE_RESET_PFR);
> +		goto free_coalesce;
>  	}
>  
>  	ice_vsi_rebuild_set_coalesce(vsi, coalesce, prev_num_q_vectors);
> -	kfree(coalesce);
>  
> -	return 0;
> -
> -err_vsi_cfg_tc_lan:
> -	ice_vsi_decfg(vsi);
> +free_coalesce:
>  	kfree(coalesce);
> -err_vsi_cfg:
> +decfg:
> +	if (ret)
> +		ice_vsi_decfg(vsi);
> +unlock:
> +	mutex_unlock(&vsi->xdp_state_lock);
>  	return ret;
>  }
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 2d286a4609a5..e92f43850671 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -595,6 +595,7 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	/* clear SW filtering DB */
>  	ice_clear_hw_tbls(hw);
>  	/* disable the VSIs and their queues that are not already DOWN */
> +	set_bit(ICE_VSI_REBUILD_PENDING, ice_get_main_vsi(pf)->state);
>  	ice_pf_dis_all_vsi(pf, false);
>  
>  	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
> @@ -2995,7 +2996,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
>  	}
>  
>  	/* hot swap progs and avoid toggling link */
> -	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
> +	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
> +	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
>  		ice_vsi_assign_bpf_prog(vsi, prog);
>  		return 0;
>  	}
> @@ -3067,21 +3069,28 @@ static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(dev);
>  	struct ice_vsi *vsi = np->vsi;
> +	int ret;
>  
>  	if (vsi->type != ICE_VSI_PF) {
>  		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF VSI");
>  		return -EINVAL;
>  	}
>  
> +	mutex_lock(&vsi->xdp_state_lock);
> +
>  	switch (xdp->command) {
>  	case XDP_SETUP_PROG:
> -		return ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
> +		ret = ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
> +		break;
>  	case XDP_SETUP_XSK_POOL:
> -		return ice_xsk_pool_setup(vsi, xdp->xsk.pool,
> -					  xdp->xsk.queue_id);
> +		ret = ice_xsk_pool_setup(vsi, xdp->xsk.pool, xdp->xsk.queue_id);
> +		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
> +
> +	mutex_unlock(&vsi->xdp_state_lock);
> +	return ret;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 240a7bec242b..a659951fa987 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -390,7 +390,8 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
>  		goto failure;
>  	}
>  
> -	if_running = netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
> +	if_running = !test_bit(ICE_VSI_DOWN, vsi->state) &&
> +		     ice_is_xdp_ena_vsi(vsi);
>  
>  	if (if_running) {
>  		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
> -- 
> 2.43.0
> 

