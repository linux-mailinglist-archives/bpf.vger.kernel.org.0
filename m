Return-Path: <bpf+bounces-52440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC230A42FB4
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4417A3632
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F721DD0E7;
	Mon, 24 Feb 2025 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLz7WRnB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953732571C6
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434496; cv=fail; b=O+K9VdF8WZlONkSCIyqK7sua/ePQ/mn8sqwYxiE8coBTUpRGbCw4w+iE2ACrNjoVWf6IEr5lsaPXTR5kNdQ6vPzDzpWthLi+lHMoiX4b1vyxXSXgpp8qIVHGZuaXrP8aE2rTv5F/+cHMnEjJak/iIxMnKzNeRRjhPZsyxKmTU1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434496; c=relaxed/simple;
	bh=28IomPhoX8axa9iBlL52oQRWsw4f4BeBITl8JOVrFQY=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=coRCdf3SbLC8WdUJqzKyn4horGELJwZFA14MduhSSFWcpBT+bqeEs4RrAh2JFoH1ZKq8j7n/B/+FIlAYr8JyUYXdNV43kFW9NZw6Ui9bvwYve3GjD6ozXslkM33UVZzTcyjq6jahE0f1B/ECZqYswHbJWv8h2jLaxpsj9/X5VNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLz7WRnB; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740434495; x=1771970495;
  h=date:from:to:subject:message-id:mime-version;
  bh=28IomPhoX8axa9iBlL52oQRWsw4f4BeBITl8JOVrFQY=;
  b=TLz7WRnBQ+VeuI2QFJMt/IQBpk1N7mhubQ6QDWoVtaL1GQhrQ79UkxqQ
   ivYh923Uz8qsazce1xTHDUy+sqid8TE8L9v/bl3qXj2VB1Crd5JGQG1Wj
   CtoFObqUd6+YvZCltufugKgi/GPFh3w/P5oDiwORv1SWkdYGV9/ETy50r
   7QDRfJe/WJbsrjLY2Y3krrvAo9+pOBoYCfygY71Wn5npNoNE+95MyA2ru
   u5km9WqtK+73NVeis0Qx7Uo+3G56AVVirwT7j/k4449/hY5AA4LILdSpB
   2qsQO85rskmCVfKVKsfmUKQ6tdOMonT8yaXolbjqa/61CbVXUqOj4OTnL
   Q==;
X-CSE-ConnectionGUID: 0GtQ4snERLCixrH96xmLyQ==
X-CSE-MsgGUID: xSevixwCSUaIeb/Yimxlww==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41230566"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41230566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 14:01:35 -0800
X-CSE-ConnectionGUID: 0ODlUp9iRoa4iwr6QnowiQ==
X-CSE-MsgGUID: GHf5qPRUShWKLRq9Vq1WjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="120802880"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 14:01:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 14:01:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 14:01:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 14:01:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbLnlDbQllXV7aqhewdIkH9ZLlqtf97GyevZTtbJ1s+bvpCIecwbs8xmQYKIjshlkw9btrnYFFCafKS8yjIsg4xhLl2YCfjUhNEC8oBJxyd1EyiCQ13PiIvHgS0oFVnH+qbC0DFUxaZ23R9Qp/9r70pBngEySdKTjj/ZhOAMlufIapiSj9m6+YaHJHsG2zbvXOuFI8VGc7vCX8aWtGZ1wG+W6h2ECPubu27rS8DUCc2jluBOAainugJTsGqOPm2qdajbK2R8a2e+jviPNGnsVAy4iJXbkjrfGzup5vq7/+5/YCGY7EZ/utiXiIBrSJ2+lSyjwyKvF1Auj9z/SrimAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcPvpTiLZd4bdGowfzHcZ417t1A/5y6eq6NRP4/fDhc=;
 b=yqmP8D7uDiyhGjJ/sk7UbQ9u9N+DYklDPpddgHsbCHif7TGmZqwK27XXqqQ3G7o3MFUlyMFNg2It+W4NUDCRgAdfLyguhe3unOM92LnnDg5huZxPRoXI0F1Nn7rteX9W7RcLj1jwiwXTXWH6G3Tz834JdeNIIQTkmc3dkIKBFN+V/J47r476p37CrmCsvkI0MtjVZOdbAs91ZXHiYfgLUMez4B6qB/1zdd2KeYtRkPITRKRyZ1x35LSvQEFLqIpk7WIyjdCAwVVIfzKIPL7xoOPZDlAsp6VlIYo3o2qRGW/JT96d3QJ6WXEyzQIfzz6VLxw3Wuvnkm5gMiASQnoxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7043.namprd11.prod.outlook.com (2603:10b6:806:29a::9)
 by SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 22:01:27 +0000
Received: from SN7PR11MB7043.namprd11.prod.outlook.com
 ([fe80::ec9b:c524:9d77:f6f7]) by SN7PR11MB7043.namprd11.prod.outlook.com
 ([fe80::ec9b:c524:9d77:f6f7%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:01:26 +0000
Date: Mon, 24 Feb 2025 17:01:18 -0500
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
Subject: [PATCH] bpf: fix possible endless loop in BPF map iteration
Message-ID: <Z7zsLsjrldJAISJY@bkammerd-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To SN7PR11MB7043.namprd11.prod.outlook.com
 (2603:10b6:806:29a::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7043:EE_|SA2PR11MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: ca803521-7d58-4370-499b-08dd551ec915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eWW4hs+yo2XkDk87pwuYkN+4Dh7m4XCxWVNbq56QFs8eGiDBvTQrN5nDK+e/?=
 =?us-ascii?Q?SecLVT3cXA0VCF5oMpJO2sb24ZGYK4o/8gESRDRkRRt7T+J/M5DMbv1e0OYm?=
 =?us-ascii?Q?hG5VvNUBygbedLHSVcBNP8ucmmsLidLGhnB3JYY/AcY4LntQyuHMGbc9OzNs?=
 =?us-ascii?Q?oYEvEKBVQUq7hqubZNIYQ3G11xlax17BnX/n9F/AozbJjJsQzedqz8sJEhUf?=
 =?us-ascii?Q?LnPQPnpet4qTJmG8QVeE/WBCt/UVZvDFTBZWzWzzneCf+wfmqjmaLIkPIuuD?=
 =?us-ascii?Q?Za6QnPfchW3mQMtYJbetJIEd61PA+aIkjeAR0c5cZSPw6mfOeXm0hNvKFcUf?=
 =?us-ascii?Q?WmSQo4G0pOtHzsujdP75EbzIC8LyamFD7wpnGsLRf4zHeW4oKnqg2BnpwoIS?=
 =?us-ascii?Q?qHvZRJgv6nqioaebkuFFdHOrFBAJivVyqCahn2eYwB54nzuxdmGBysWJVsg7?=
 =?us-ascii?Q?j/uA9+WUegYG/ykYfQtn1zcRMOdjmWvbDIx8RMNLMM6ncvmCSabGX+7MED0Z?=
 =?us-ascii?Q?ivDmwj9vIqjGQfYUTdHBkOx8UCYYz1KH4SfZWZzPn8O5wWiy0/Eyuq1yVnJR?=
 =?us-ascii?Q?Pb9vV630a8MNKnHAD8JSZbkZuxbE4VNugptLZVR0VvlNJXalzf3/JQ2EscJy?=
 =?us-ascii?Q?XRjtVw3x6WnmBea0VmmzAXmSb8nyTAkJpxWZu3VEw1AY8ZBTtXI9s41o4mLF?=
 =?us-ascii?Q?bC1SbS5Em1S5oqxP8jcLZOHlht6/7wYTHRKNKRXNENAvHJC/pijzPWshhk3a?=
 =?us-ascii?Q?VbigBdjIQm5Ih8TXNJkn7qedKONImObt0u5+zMy4dGnvaq6KcbxjWo2gCk67?=
 =?us-ascii?Q?iyXobd1weWmOsAA8cxOUTn0eJh2QN5GFXgiOxbG0kTQgD8mUfCEL98vnbTwh?=
 =?us-ascii?Q?AHHmh2Q9HLel/kddNjjy4Durosy6ecll54AYUX+7AA+st3TzAbYulAqPQMR6?=
 =?us-ascii?Q?AY4iJOgi1NLnwW/5IPXLn1uemJrgtDCny7jLMuG+PTpjLrVWje8afqpU/zEF?=
 =?us-ascii?Q?5LLK91JQOHohhfGJ3pBm0UOKFobPTUfO3LcshsSpbtYV4BIg3alLaZEbjmzf?=
 =?us-ascii?Q?AyhRj2L0txLx4u/PQOME3BR4lUcvifnHiVehmu9rmm6acJIDuJpdF6EQEqOn?=
 =?us-ascii?Q?j6VsU1n3yH8kbVRR9ZuUKnJ5rzeorRsBK+VTgfsZehQ7vb1k9v6tEht4GNWp?=
 =?us-ascii?Q?Hghm5QUVn1UA2X4huCWXx35ptFKZFXZzN9PmdESyG803MZMqhz+vCQGh2I8z?=
 =?us-ascii?Q?JmaZMt+YcG/I82vc61znPu6r1txc1unfS2g18TxWwvmVIzeyTCydOzKy5Dma?=
 =?us-ascii?Q?Y9UhTOoXyHvuTEeg16PEiKKxp8CwMdYV/MREwLGHonY+TWOWZo97ttcBwn6D?=
 =?us-ascii?Q?8RDxwtktUMv2iHn/mx6wM89UXSCc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xoMoFS8wCE7qcuz4S2Trd0HoIAcxCorTJjALBLReJbATEaIT1mArY07mZyq?=
 =?us-ascii?Q?JY6QoOKl7QiAd3M8o/k+K8N9t7q5uJesKWXlEiLt3Av3Z2lslO1tIcCylBq4?=
 =?us-ascii?Q?UzME4tnIrQ0BRDRMU936j6VY74q4NS0fdfTLy4nPs7VmxLFbmtrVXf6xwE+R?=
 =?us-ascii?Q?VRLpG+Zc0nW3P/ru1tQhICfVSgo0FL1AdUFsOiQ0H9mhFI+yQ4kEhcvHdM2e?=
 =?us-ascii?Q?YBa21sgEA7QdUcwY8GtE0UpdnS6KySLxco5vFPcPV3DDUXEZEVk3ekpu3Kv1?=
 =?us-ascii?Q?PrChlstIs8XvjFdblXl8m6nb0FxpQwYY9GoyacjOexjKKQh+tQ0pP2AIOPap?=
 =?us-ascii?Q?BkmtxvU1U97SkkHe/M9y1tLOZe39VhtCh0y8P3IC5PZI7SdTpHlIxwkTZWrj?=
 =?us-ascii?Q?gJH7d4TBfcIF4tRneECrWY9Uxw6f7sX5RKPAmRkVdvqSmf6VBj+Za6/Jskn8?=
 =?us-ascii?Q?Y7KYQjc6/meALUpWzRGPr1fwMjk/GZm0G48WexHXEcuueo1Nfg0uUDAqiV5C?=
 =?us-ascii?Q?+veMj+ZDOHbhXWDfjKy9q11Csyl97uDw8ZZunlL5h3sOBePakM3xmdQZk3lA?=
 =?us-ascii?Q?Meh2v9BvIgm1WZiX0tmFzGmyq60xdS1CKjT0Stw529R/MrnXSyk8wJ62W+rB?=
 =?us-ascii?Q?1BN0bvFweFsbnniyiGcyN8JpVIANcXqPAmXnHUkKD4Ghj1XRqWPwRwvCLSad?=
 =?us-ascii?Q?X7bX1tLxOy2oC/liJPoHwTdsy4A9YEBGu/1H66q8TK1M/d25eOGueCFQM+0C?=
 =?us-ascii?Q?nUx0M9zgvIlGrmm5LsV/CqMM6L6pCMvsCYV/xQZZ/cfGPZ75dQf7vF3qRqcL?=
 =?us-ascii?Q?I4ATD4p805DEKqrqxusuUX6te1CemhGD7TZ7p54AxQvP0Kdt6Q8C68YFojMI?=
 =?us-ascii?Q?EHlh1BsQdOydWxw588E9e4cIFQELyuqEWiNLwasBYeENF2gfPxAWG2oXAxmO?=
 =?us-ascii?Q?SczObj3YGPMiVKkgIx+d+mXTzCWK1kWKSBmv1QSjeSDAiXGUYjo/QgDBrhiu?=
 =?us-ascii?Q?tUdM5zhg0WrtgIy/0hiRPVL407ZsnsqUIcCl86Df/if2ZC71eRT+0xgw0ypj?=
 =?us-ascii?Q?Ki+N7WytRXfzK/479HkrIoRRwqaaAwEx7JwIUPI6oclkaF5A/Nt1JyHxnW2Z?=
 =?us-ascii?Q?Cyj/QEIOR0KhEB4SCgJa/u6Qc2vLXqg15sBkd62TOssO/FRagA9RuHjjNMZe?=
 =?us-ascii?Q?q05QyS0RyH6lUTC3keRtPgmWCD9bwjc638T4lHoSv6YFHcWmrgpslDV6MRCq?=
 =?us-ascii?Q?Wo3etDrGGfJx1JBW19L1VCASF8Jt6IUdLpKedsJzMGwsEywb6PNqtutzAO0P?=
 =?us-ascii?Q?cQuPp02PlqKYe4cdLskll+LgHGYccbcngGoZoTPqoorShfqRqh2V0L9WOIDt?=
 =?us-ascii?Q?7AIBLbktVLw8A9bfUuTagK33qg87DV+b0n7s6jMS33bz3NFIPPHvynmDQTTf?=
 =?us-ascii?Q?8A1frzgWWGKVztHttOHsqVKp6i3kAkUBx27QosvkzHLZA3tDGi0hW4c67KiE?=
 =?us-ascii?Q?9L0WHVDXCOxj3sRppr/AlJvaHLWeKf2zpfHiAndzKev9Swi4h0hUW/gHRmqe?=
 =?us-ascii?Q?FVQwkZYZjbSMZlsR4iag9Y3RJAcPmOQz7PQPyXDDzt8gWmGMeWYzZrt2M0B6?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca803521-7d58-4370-499b-08dd551ec915
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 22:01:26.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vknHBN84/+Fx392itVD9VEZ4d1/RW31IzBTaS9LXZj4NLpdltuGqbO/YvH9do3udCX2cvIp4Y8Iq/UTGmhtp6a0Tzu66jIaiFiA97a9VTf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4874
X-OriginatorOrg: intel.com

This patch fixes an endless loop condition that can occur in
bpf_for_each_hash_elem, causing the core to softlock. My understanding is
that a combination of RCU list deletion and insertion introduces the new
element after the iteration cursor and that there is a chance that an RCU
reader may in fact use this new element in iteration. The patch uses a
_safe variant of the macro which gets the next element to iterate before
executing the loop body for the current element. The following simple BPF
program can be used to reproduce the issue:

    #include "vmlinux.h"
    #include <bpf/bpf_helpers.h>
    #include <bpf/bpf_tracing.h>

    #define N (64)

    struct {
        __uint(type,        BPF_MAP_TYPE_HASH);
        __uint(max_entries, N);
        __type(key,         __u64);
        __type(value,       __u64);
    } map SEC(".maps");

    static int cb(struct bpf_map *map, __u64 *key, __u64 *value, void *arg) {
        bpf_map_delete_elem(map, key);
        bpf_map_update_elem(map, &key, &val, 0);
        return 0;
    }

    SEC("uprobe//proc/self/exe:test")
    int BPF_PROG(test) {
        __u64 i;

        bpf_for(i, 0, N) {
            bpf_map_update_elem(&map, &i, &i, 0);
        }

        bpf_for_each_map_elem(&map, cb, NULL, 0);

        return 0;
    }

    char LICENSE[] SEC("license") = "GPL";

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>

---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a9eeb7aef85..43574b0495c3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2224,7 +2224,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 		b = &htab->buckets[i];
 		rcu_read_lock();
 		head = &b->head;
-		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
 			key = elem->key;
 			if (is_percpu) {
 				/* current cpu value for percpu map */
--
2.48.1

