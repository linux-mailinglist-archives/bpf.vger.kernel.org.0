Return-Path: <bpf+bounces-72317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D7C0DA08
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F8D54FCB8A
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061D2310636;
	Mon, 27 Oct 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqMfrIDJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECB30F7F8;
	Mon, 27 Oct 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568338; cv=fail; b=qqpSEAx/UgPitiJbJI2/ZPHSK22wy+42okAm1nsm8twTMWlZeb5ZmkqmtDczng4PebaosfXAqPdysY4odWCNJk7m+TQbZ5mPOzNBiaVm44qOLXjUQ6tfTA4OefyFvA/xwccj/A9vin+TAfXnukHNjsRZ4DrM0WUf5pxtFRs9N/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568338; c=relaxed/simple;
	bh=uRx06ttlGxywyYb+Jh0RVfF3g0o9efyyPLEImSOanPI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XCOZp4HNe1koGwxVwcxsofvv3DnL9pKaE80g1whCY4C6HIaJGOfVlSrLR0D3KkhJhTG+FZi+L0Mf00D1FN/NPtHuzBiQf7hSJzAZ/S/VVXRRrbgIgC3PnXmBatjWpRe1V/ruGi0Xc8cfWTDxITgIKc/H7uGKNMwmfS34Z6ghUio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqMfrIDJ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761568337; x=1793104337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uRx06ttlGxywyYb+Jh0RVfF3g0o9efyyPLEImSOanPI=;
  b=kqMfrIDJk03PpqcXRw3F1Ll7HipyFFXxYpGEbgQxBL+fbMZi6sUk8Spl
   nlAYM1WPxip1Oput1GonwwiUVXDToSoaZCpccAciSFTDTfpvpvQ3M0QjQ
   6Ke1JdNTYyaKUZ8QmqmYGrHtYQqtNNg2+ucXFj1LfMTmkbgjdS/6VEqiL
   +MvWTpng/WJoMFkDq4TfIMovKqqXrC+fBpZ2BNmS1wlQx4wkdKLGmb9i3
   qyw9LzV10q9K0nz1VfYkGRrQlc/Oh09CLY/1aIreK1vhmr1b2/QnMOwCX
   E48QJrtZLlH6+H8uwL7z0S3bJDwFQfgsLagPB+DhR0XpE0tVCDXA+8+xe
   Q==;
X-CSE-ConnectionGUID: hGsV9WXjToaljrjVdfgFXw==
X-CSE-MsgGUID: 0YTITM7nQQWAm1jrklwVQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75090925"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="75090925"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:32:16 -0700
X-CSE-ConnectionGUID: lgM3CRY0T82WLW6AqeX/zA==
X-CSE-MsgGUID: bJtvDT9RSTeW0BuREhBKqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184654365"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:32:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 05:32:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 05:32:16 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 05:32:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaPc/glugV4ZJdWY7z8ncs7tIwzjyFeYHxcjwNB65HIA/vqtylID36fTEP2+eC+qbHxGyQ4PDdLkE4ZZos8usQwfZ4jgo3bbYC9+9aIaYq4TtQxX2MGZw9VAUQCFuLMj6n9Cw9gymSZuF10jXprxp0bDd7DC4sY8D/QT1nlYSijfXOrgTrDzsWuY7EHUeL72CzeEb8sRpCRrtvDyLX4HjL+4nPrJYdBDt77LNGutirp++B7cUmrc2ZPe/tejZsv2DnKq2HpcmIWiv7hcE2/FZ0Eycc72N+kTzhAIc7/YUmn6LiQVWI4TcMEhZ4+Qgv9nYSvPSZNR4t4cbE1hedlhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxKFB584I7baPkwtJCKRn36d4FTItiGfK9YOUUBNBPM=;
 b=LD3GYKaVBdVKXz+xAIszswlgYNa98tkWJcOrR/qJiNiSts91V7njWZ+EJZdtPcN0KnKKgRbU3DCfKJNOZYdlst3cx1/WLj/FFyD+2XwCtCkS04zOt6y7fxqN/kUK3soqhLtKPgtbBe+EK12+IOJ2RVs6ii6UHePBA80Pa5iMmqhLHQfzVk7I3g769tD6FqnD3L3JzKeLb6gjNL9O3RDYJ9swHVoJ3oKk7Eh5/0LYNqg63W2AMXK3W/Z97rPM0ZQiTCO7ZwCD4TxcKlxF7M4asp6BvMOLjd16SjS68dkET5eJV6I+Wj8p/3CMm3kr7uoJIx8xDkS54tEzFBPpfMr1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Mon, 27 Oct 2025 12:32:14 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 12:32:14 +0000
Date: Mon, 27 Oct 2025 13:32:00 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
CC: <netdev@vger.kernel.org>, <csmate@nop.hu>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>, <sdf@fomichev.me>, <jonathan.lemon@gmail.com>,
	<bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH net v2] xsk: avoid data corruption on cq descriptor number
Message-ID: <aP9mQG4dRvPxUJhj@boxer>
References: <20251024104049.20902-1-fmancera@suse.de>
 <aPu0WdUqZCB3xQgb@boxer>
 <4723fa89-17d3-4204-b490-979df9182454@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4723fa89-17d3-4204-b490-979df9182454@suse.de>
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW3PR11MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 8151832b-99d1-486e-a6de-08de1554dbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7BuiuRYhLgojbnmN2TGgHZzgGOpC6Ai3KGccdNvAAvycxn00hxw2KoHFABAz?=
 =?us-ascii?Q?ev/VdRKTMzluRnKsleAZemPeMDtx+HGAlUuGlhKMddrbRgeaIki8L6AEbsHP?=
 =?us-ascii?Q?hr2Dt+BhIwhLI1isw/6TZUj14M6CZJOPS3D3+IhjVdQJsvuGXJXKOohnW79e?=
 =?us-ascii?Q?JuGqYrQqNOXXZcOezfaB6cm+N2bJ3I27id1IW/Zbi+Bd5+qPvcRbv3LAK6eS?=
 =?us-ascii?Q?XfTHwxuEC+Q8UGO4eZBxQgm5vHGvyDcurd/+MAyS91x5NcgduSSwdrDcBjyr?=
 =?us-ascii?Q?wGJK5Lkomu2QAz/9F5BoVANjkkD39T0zPcUlxApxmmevMVzfZ/1csz5WLW2W?=
 =?us-ascii?Q?T+Z5lOkeCWXw0kfv3Xn4W6D1oTDsYH4zruC102vsyq4GfcNY3nBRDg4XDOK9?=
 =?us-ascii?Q?apLACJB11KyPzuBncjMSqA1IQNkZdozBR8XQO0g3nzn1mQn1VUCCyJ27iiIM?=
 =?us-ascii?Q?8Ww1/AU/6OqFKRkhymuG1csA5C3i5bYAinJI5OVtkxGHDEje2hu+vvVz9ZxK?=
 =?us-ascii?Q?6Nhf3jfHErItsZ81Sq6gl4wAOMnnnp6P7MCgu2XnHuYQqxgdpifGTd2WOemy?=
 =?us-ascii?Q?sQOdfqITOID6BPbSK40BfMm+YHmOE2G5Oh4U+sUNB3frAEVcMDaruT4E5jU7?=
 =?us-ascii?Q?INlDvK3vmdjuoKozU42slQd7IkQKu37TPwLpY6KPidKUk4dTLDcA8ZJEf74u?=
 =?us-ascii?Q?UjUSdE382GWO32vZDHzGuhGKC5HvVWzi4oSysCV+VrfP+Jpu9DsMwHLyxEP2?=
 =?us-ascii?Q?uTwBJhS1VP9YQ8+L2DhXupm7KOZj94Vs2coJ6SKKXe9HIR3S7iqitwfwp8NX?=
 =?us-ascii?Q?TN7aJJswnCQ4mqMhvkuJlKYfLfXKAEIyzr3JY3oj8USYdRUXCzdB8JEe6ET+?=
 =?us-ascii?Q?7PAZWCVk/x2PG+BnSlmEIAerT1j4i3FLLUkLimPkDUfcEqorPF42wX2fH42u?=
 =?us-ascii?Q?ACM38mnkF3lhoz4ZocY53gwUtUXNe/FHL6EHDIEFwMrtYqOeKDTKE3GaAe1E?=
 =?us-ascii?Q?y8N1WDpyCSZ0TED39uWWIEpbZ9x9+GvzcuGrwGS5v8E8/lUYBdUKs5N6ub3l?=
 =?us-ascii?Q?jb09f31Lg5OqjOrcwQsyVOM8a+HIYR1/z3/AXRfb0V6S1irOo6A01sfb+rEG?=
 =?us-ascii?Q?SSSbVtXQH9W9t8eg/Pycr5wfnbqqyWiOXaYF/yp+tndGUEMRkoPDNYvCvJE0?=
 =?us-ascii?Q?a7abjw6icOwfkIdi2i9uTlabvuXRF3w8yZpxV6QuFGd2kW+F9kf2dRrJ3N0A?=
 =?us-ascii?Q?+vWENr15fmioMWDhsvoQX7CMM87GfWKlYcEpdgSGE9qCxeDTnYpVV5NrlgAS?=
 =?us-ascii?Q?aowokuM78aR54x8RyJGBGapBbk94IIjNCQk8Z8scXrgzpLPCrs8tId+BF5vy?=
 =?us-ascii?Q?eFQURPwhR+y9IgRM1oQL4WFJfXAbMtKZAHc7WTDULdoG12YGzDmNwKKXAn76?=
 =?us-ascii?Q?1+Wn7hOAV6GrLdNsJ6tWff808VY4nYSIkNj5FyfhEGmApweozQGEZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9bnmmCIfaGSW49xD54R+0eXp/Vx2aOTprA2yBeE1zbQ4+gi84f6e46Sw1xk/?=
 =?us-ascii?Q?XXYYlktsvRZ9NYTxW5suOvgYTOH7ZBd+JY+W5CqD7lhoU/IU5iff8qcbBaQ/?=
 =?us-ascii?Q?/cVRfYUYl23M1hlGhL4rcs+Dgsfmp90BHxD12u9KMcnxbp3Uau+Bdi41Zd8X?=
 =?us-ascii?Q?9pysgUJWHvK5IolyBnW6juoIWiFIABjfEJm/qOoKU1YcqsanypgGel4Ozn2R?=
 =?us-ascii?Q?ejNhBibuEVU0qXU9EExjst9cG3qH1iVokHEkDr/R04CoiG3IAZICainE2cvl?=
 =?us-ascii?Q?hXnHxQjqbNzBNQSsgBYYyQovH5Ihw4Yp50QwJ57qGQAO9Qy6kP02QlRLlOpj?=
 =?us-ascii?Q?UUxElVP6neS8XZHsPqLhRZNQfaqshN+wy01i63oNQo/87eVdBtSo6ebEqCWO?=
 =?us-ascii?Q?f9p0hh0kSct2q4vHeloMmbyBO1wBMIMSNaqoiSmjmApRNAZ9GJpDaIrHQpgJ?=
 =?us-ascii?Q?mi9iI/G3BhIZK1q4kTvxpSskcMJXIQkFfrjRKVUhymmY1GmOgGNSMSqob6xW?=
 =?us-ascii?Q?gP3/YlVzyx/3FRDpqsB6bUjgIXl6QazIl519z9BhB3RR1flfbZ3PLlW4VjeF?=
 =?us-ascii?Q?dX6AyTEqzRQ+WFBlb0wEnxE1wpEGLsOAzO7CAQaTdPUPgwDLX0tBm8ThJJ8n?=
 =?us-ascii?Q?BeysU9n32M4XgcAjwuime1gQuPzzkEMnqt+c9RjddSe2DDk/RFLI+Z4sCn3s?=
 =?us-ascii?Q?mGwpEjzGeInrY/J6tkbywJ48sF4cS/HibmfwtQriCnF3BszkVWlYSHvEFInd?=
 =?us-ascii?Q?AAbqorAN7wF9pxQ8GZ+TOcyYVTt7V2ivaE+5GcSjETLNCI9CUDBHYYMmZ0Kj?=
 =?us-ascii?Q?vawt31tzbh1Q3AgE6Ax4CV3xo3tZwoy7o7F0dxCSHUUBvQmgSNyRn1qyecNN?=
 =?us-ascii?Q?vuOaMxP11E65HKUhnksP+Ypzg9IzrhaaQCzWuOjwrapQZueaFoENUVK/qebp?=
 =?us-ascii?Q?PpZPsCBwoxgK/AnfC04qkGvPbyl6vavFdtROJ33wh882QuCE/pbrHteuGW05?=
 =?us-ascii?Q?hPNt5Oyk0ge0FBm8BhIu6eT0vzQ8Lhms9XY9FCjQv928MpnypTeUCmEwBf+t?=
 =?us-ascii?Q?plPugmbqKo4QevLtA6Wh2/PB9HYkmaRONXrnMUE5YrmrTPUZAHWPJHDzp94P?=
 =?us-ascii?Q?kXE/TkXH+tTZ1FOoxNnm0VMyHcGY+RdzUOHyijCIhfr6GjPJjR6Bzcb+3ZIE?=
 =?us-ascii?Q?K17jEXOlmldL5I5/FnBZ8yYwjZtC6hFAxZnhA09MJbDyZfLCF71JXYfnXm8H?=
 =?us-ascii?Q?zaMcYdUt+JvpZCK2pvPxVXZa+eWXT0O0czGMzZvLZ1F/Q70wAacWrkSe7/VF?=
 =?us-ascii?Q?iXEJ5jTFHg8topVYufpSKoBttb0oXZ45XOH8mWobV1AItW19CVbNRUlx+Hq7?=
 =?us-ascii?Q?ZH34XGgtq3ctNpt6CSzpvG2iaQHzuE+qNypK9lIu6cbiNjZJJn1f/nj0Bb5P?=
 =?us-ascii?Q?o6XX7kqCxkbNjeopSMRnhHFFz/P0J/xNCMVxJ0qHxjyIdgoP5p/dMSF/i+Gx?=
 =?us-ascii?Q?xUKOazAR7CKHXB/YsretDhgJNgwempsL+dH9kDrqCDNiy9tuayfc5qL8hmIT?=
 =?us-ascii?Q?ord5DEnjLs+LqKL++8ll/NfhDze36bXtaSKJFrpch5XuYN6AnyWQSQqN0/WP?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8151832b-99d1-486e-a6de-08de1554dbb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:32:14.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bAECZbItmQB3zQ0IJm+G2BEPEm/oESq2bv7E8+AIHDpL/JlpkL4wNRvxSXB154XbNS7O1MELdEOCsjuqBWpEybqJC8gQ2Ly91ZBTX0PNYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com

On Sat, Oct 25, 2025 at 08:18:17PM +0200, Fernando Fernandez Mancera wrote:
> 
> 
> On 10/24/25 7:16 PM, Maciej Fijalkowski wrote:
> > On Fri, Oct 24, 2025 at 12:40:49PM +0200, Fernando Fernandez Mancera wrote:
> > > Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > > production"), the descriptor number is stored in skb control block and
> > > xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> > > pool's completion queue.
> > > 
> > > skb control block shouldn't be used for this purpose as after transmit
> > > xsk doesn't have control over it and other subsystems could use it. This
> > > leads to the following kernel panic due to a NULL pointer dereference.
> > > 
> > >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> > >   #PF: supervisor read access in kernel mode
> > >   #PF: error_code(0x0000) - not-present page
> > >   PGD 0 P4D 0
> > >   Oops: Oops: 0000 [#1] SMP NOPTI
> > >   CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> > >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> > >   RIP: 0010:xsk_destruct_skb+0xd0/0x180
> > >   [...]
> > >   Call Trace:
> > >    <IRQ>
> > >    ? napi_complete_done+0x7a/0x1a0
> > >    ip_rcv_core+0x1bb/0x340
> > >    ip_rcv+0x30/0x1f0
> > >    __netif_receive_skb_one_core+0x85/0xa0
> > >    process_backlog+0x87/0x130
> > >    __napi_poll+0x28/0x180
> > >    net_rx_action+0x339/0x420
> > >    handle_softirqs+0xdc/0x320
> > >    ? handle_edge_irq+0x90/0x1e0
> > >    do_softirq.part.0+0x3b/0x60
> > >    </IRQ>
> > >    <TASK>
> > >    __local_bh_enable_ip+0x60/0x70
> > >    __dev_direct_xmit+0x14e/0x1f0
> > >    __xsk_generic_xmit+0x482/0xb70
> > >    ? __remove_hrtimer+0x41/0xa0
> > >    ? __xsk_generic_xmit+0x51/0xb70
> > >    ? _raw_spin_unlock_irqrestore+0xe/0x40
> > >    xsk_sendmsg+0xda/0x1c0
> > >    __sys_sendto+0x1ee/0x200
> > >    __x64_sys_sendto+0x24/0x30
> > >    do_syscall_64+0x84/0x2f0
> > >    ? __pfx_pollwake+0x10/0x10
> > >    ? __rseq_handle_notify_resume+0xad/0x4c0
> > >    ? restore_fpregs_from_fpstate+0x3c/0x90
> > >    ? switch_fpu_return+0x5b/0xe0
> > >    ? do_syscall_64+0x204/0x2f0
> > >    ? do_syscall_64+0x204/0x2f0
> > >    ? do_syscall_64+0x204/0x2f0
> > >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >    </TASK>
> > >   [...]
> > >   Kernel panic - not syncing: Fatal exception in interrupt
> > >   Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > 
> > > The approach proposed stores the first address also in the xsk_addr_node
> > > along with the number of descriptors. The head xsk_addr_node is
> > > referenced in skb_shinfo(skb)->destructor_arg. The rest of the fragments
> > > store the address on the list.
> > > 
> > > This is less efficient as 4 bytes are wasted when storing each address.
> > 
> > Hi Fernando,
> > it's not about 4 bytes being wasted but rather memory allocation that you
> > introduce here. I tried hard to avoid hurting non-fragmented traffic,
> > below you can find impact reported by Jason from similar approach as
> > yours:
> > https://lore.kernel.org/bpf/CAL+tcoD=Gn6ZmJ+_Y48vPRyHVHmP-7irsx=fRVRnyhDrpTrEtQ@mail.gmail.com/
> > 
> > I assume this patch will yield a similar performance degradation...
> > 
> 
> It does, thank you for explaining Maciej. I have been thinking about
> possible solutions and remembered skb extensions. If I am not wrong, it
> shouldn't yield a performance degratation or at least it should be a much
> less severe one. Although, XDP_SOCKETS Kconfig would require "select
> SKB_EXTENSIONS".

SGTM. However I have not used this feature in the past, so I'm looking
forward for your implementation.

> 
> What do you think about this approach? I could draft a series for net-next..

That should be targetted to 'bpf' as a fix, still.

> I am just looking for different options other than using skb control block
> because I believe similar issues will arise in the future even if we fix the
> current one on ip_rcv..

Yes I agree. Heart says 'just fix the IP layer' but as you said, we never
know if other layer would wipe out the cb.

> 
> Thanks,
> Fernando.

