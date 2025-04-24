Return-Path: <bpf+bounces-56593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E22FBA9ADE8
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6B21B63C6E
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7782127C157;
	Thu, 24 Apr 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiVLDvi2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956D27BF94;
	Thu, 24 Apr 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498975; cv=fail; b=OWgtOKhUeljGtMl+IVVnDzODN7mxX5aZk3eEceObsfRrxX+YZrPr+Bup0LqIsf+GSN3Uvdqs/atsFdX2lJVxO3tIPjTeyLCATrv7d14m/1MdWgUyd5qCb7KG2MqmKO700nQd7aEaAS5nJiQQ+KHa0OUfnOW5yk3GvO7mnJ0KfWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498975; c=relaxed/simple;
	bh=fz6Rh62DNxBScaJd7jMJoY6IQqmS2FPrs4r1yhwTZYc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XIisYCYW5jL/tEhB32qFYzWJhKwyCqNxBR3T8uNDY5xpxmx4Ix4wRd/ZnisJDJUJBbI9QbWWDCKaAkc2wnvXtxYG2M7ZPcfFeG1q8J7xu2nSTXhmlqXQVXHN1R4vTWgEU300jKw1EAJz+mksZdqfNFNP9K4+x/Y3fCTKBtb8M+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiVLDvi2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498973; x=1777034973;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fz6Rh62DNxBScaJd7jMJoY6IQqmS2FPrs4r1yhwTZYc=;
  b=IiVLDvi2sLgAKBB09YMEV49A5UpG7tgqAZWrRAUBisVvQv0L3+S0fEbW
   PUlaMGWLBVnPQhg/IYsdw5QoWhlMyqlkbsEG4/dH/ML68BcY3udOCt+R6
   c6v0ergPnhR/Rt+YdxQdqvpFgdfYICwNIwLF6Gs1u3gSnuGsn7DYZwr75
   dzZZU93Ti3O3VTCMY/k+J6XNdNwJ+FfSnTR8z6MOuMHmDNGYX1Q4T1FLf
   h9+BYAhXPueGMS3OIsyg751fKkOBLCT83kFtT1xpB2c2n/PdSnYzNFcjL
   +yHyj7b+7GghQS2PThtIqHucACbjjbGexKMtwbmR0Z5q6heXemrCUCwlJ
   Q==;
X-CSE-ConnectionGUID: Cagivw3ZR1mwFPI/8EmJow==
X-CSE-MsgGUID: odOz2aiHQEuvf0YbwAhohw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47303719"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47303719"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:49:28 -0700
X-CSE-ConnectionGUID: KoJsmm32TCemrnFtXVVH5g==
X-CSE-MsgGUID: 56QnHvxvRJSqFm5dehrzuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133139168"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:49:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 05:49:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 05:49:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 05:49:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbKdkwZ7JrquA9WEBjguUe5QYEteOw90dc5eStKJEqWDks6Lyadq1pUlhfIE0onqeZZzCwVraEv9x9ZdV9WIMGxR+0VHSmtHu22+yXNzEupA3xGs9LlpIDXBTwu2NeXqfsOzRCj2t8pMKy31yr6+67+lT1xGrxJyaZd9/I3f+Bd41vfmKrMOS6tGfp4qWd9oUm8ZMaUD2rWmdY/Yjl/SiQANfJP1cMMx9i5b2eWbxgNY2Za6FAUo8LoerjDpZuJ5wvgTTzGCn+8oc0XCMZf40znIghdRno0UDHnQRFuDGhvxonWhXEHx2HZFB3MGCRxw/DyGxPKv0+1BKHHybm0o6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wj6WCpPtavPkaL3BDPY/Kr+m3+DJFkSQ9CxeAx1RNnI=;
 b=dJAYM+r2dFs71MfDwBDDdE98AZDGJBkArMfWxW9orX3Jxa7V0zNTjP6FP+C0Foz+dYHLDqdvQiyYX9la8xZfoHBaBPBJcPtCguLaBky7EEaRRdGCFgSYpmIgM+rvH/q6SaHbTQvH+S9Gc/DsXZueaiQUf5yX62i8TzUer5PuXwEa/ybdJ3U7DstfiksdQ6dYbxyN1T6Rq0GSUnlSw0AXQYqhG0+oxoA2Y/fboDszQixcJXITmm1H6XUYnLMOgSP8cZ5TdtPRfsH2eYBSsttjKSZBuhVx4neb1FFgmiyojkpOcSZOqouoAE3gAV4AmbL6P4qV8FeiyPOYTdXIQvyRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4990.namprd11.prod.outlook.com (2603:10b6:a03:2d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.24; Thu, 24 Apr
 2025 12:48:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 12:48:52 +0000
Date: Thu, 24 Apr 2025 14:48:39 +0200
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
Subject: Re: [PATCH iwl-next 03/16] libeth: xdp: add XDP_TX buffers sending
Message-ID: <aAozJ5Twq7GidhHr@boxer>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
 <20250415172825.3731091-4-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250415172825.3731091-4-aleksander.lobakin@intel.com>
X-ClientProxiedBy: DU7P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::22) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4990:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6d9150-7c38-4598-c743-08dd832e5dcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bnlg3qh9TtSt4R077dSqn5qKEdcV/bToMG4GsICLGde5U+a1aAxzimjJ1c1R?=
 =?us-ascii?Q?8JTYt5uD1dK0DmVznHiNiXzepCtKeCYlhvJne+MfkNN/Q5AJwuMjTErnPMLb?=
 =?us-ascii?Q?PRo3uRGyVL3WYqJ1HB3Fi+9INIQ7N9JjRiDtihTTbh22GBkYvIxu4rXxpZ1O?=
 =?us-ascii?Q?9s6CLQ0z8DunrDnUqcoVHVTkx4DCDHDCUSLR+DeiCt+cRjNkWDoRg/bch7KR?=
 =?us-ascii?Q?pudc9avk49fqataKqM4KFB9wX3bP6EMsxlI0z/Fux3AHm/fjMWJuf5R/KrTq?=
 =?us-ascii?Q?wEWHvWBDTa0GuWUSW454JOuol5anOSaIvsalF6VCGlk0AJpZ+jDpwc0IBpFP?=
 =?us-ascii?Q?VKA7AcEb19lQnNP7Qpbjr5bG+IuMMi1XG6LcOLowXunXAiqLA+X4IpGdL96i?=
 =?us-ascii?Q?1ZNAejudlzrv7mlXu9vBeEEZvUe1uFFXNCG+eus1d5q+LeXB/qrWMmdG+N3a?=
 =?us-ascii?Q?1T4+X3iuvQMuC/G3n3dHRPr9K/SvvF8WNEjAJZUJVwNRjEGdoFnMzAmHRVls?=
 =?us-ascii?Q?pnVNmmXUr/YH2jVPgxNP92q5XeCIolygc00zxGpLRHOyt/cI7qvCm/EHb+vK?=
 =?us-ascii?Q?9cdma7K65cYsqc6CksEAhRsMzc8+NUjig5YtFPcdUwazvyIgtY4EqjfGz3t8?=
 =?us-ascii?Q?lzBkP2h0wulUldaRYTd1WyQ27c4bqFnoTVECUOLu9BFP7g02xtp3z+Ucm1f5?=
 =?us-ascii?Q?tyNphjd4a/Wl9KeotSRoejscNvZAH4uIiuYdZ4tNoGtmpgK/eRiateitYcjk?=
 =?us-ascii?Q?3SOK3WpbZK0fNeMR+g3zCXQJ2R5yfxSoD9kNvv9iWioeY23UnmAXaReenB/t?=
 =?us-ascii?Q?Zp7RT1skSQ1KlG8MMqpZ7qBZw2db4psgrejJX1rEmNnvcrE1c0nMdNfmoQte?=
 =?us-ascii?Q?O+qx3NLBOv3oaa7hfnifdsczoLViLthboQkiBDlkFPopoL7cjiedoOWaBrVh?=
 =?us-ascii?Q?tT5dDspVkAu4/GjocpJobS5XsU294h/XFF63CWxxKNBN0VGKwv3pIYbfbT+c?=
 =?us-ascii?Q?uYCuTmTfp26tuTEhKakcMCUi2w2ChDpopjcQvNECYHmmIdUD6d54t9/+T2lb?=
 =?us-ascii?Q?oYI2DerC3IUsp9jXVz/iqrFbyckvs0acURPwMgtODEGXZ3jAakcciFi4Czqr?=
 =?us-ascii?Q?XFBwcmFKCUxfmaTeMThJHEPLY1C12oo0X35x1MiyL/sI8QxhpunobmCWIFU/?=
 =?us-ascii?Q?c82Gj7Reh0429HES8cx4Wu+QVHkH/bXAwFGKc4zGLQjsojZ1gLjk2LUSSS5T?=
 =?us-ascii?Q?b/gi8TkgiaUftvN9BJHQHV7PH8kK43DOD11heMLarKOv+1ALEQh7SUcAJrP7?=
 =?us-ascii?Q?8AgezAz7ils8Sj/+ix8hamVwAkAMC4rvEnNRXPpYtcBRbsg0qQTYKBnABiBA?=
 =?us-ascii?Q?lqToRJVe1VbLPb1CiflGPViFhMPKUnbJ/sC96m62/y5a9S6rgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KNe+zkqCC+njORBZnmpbfdO95FY8RYl85QhzXU8YvScqS7WlA9xOKj7dxBL9?=
 =?us-ascii?Q?XRzI73G+1WqB30Lzswx67ou+poj5crIrb2tZq0J8LWcFrsI8Wvj+dBxrjU9h?=
 =?us-ascii?Q?d8YkMhqwTUMPwXnUtv79PusTarWGgceHWlY59t0mF6xmBZasCqeTlT4ed88k?=
 =?us-ascii?Q?+pVplHHmPUK/Gr9juReOs8e25/PIKgm3akRRFqi1Cz/E9na0svk9f6Pa5Kb8?=
 =?us-ascii?Q?6PrvVeNy4eDaiHHiFQwLlY2IAYhZDgXKv7/0TwvrxBcSJGkHhJC3Lg7aUhx2?=
 =?us-ascii?Q?D8xEkfu5eEcIzgDDRZvYZ0ME9+SIy6pwaMze0iyqHag5490jvymRRjjRyKRO?=
 =?us-ascii?Q?+Mz/BYx0mow+Wz412j+jb6lVQm7rEF5dP3UOuybaP4V1G0mp0VGO1iTlXE90?=
 =?us-ascii?Q?cGc3ToL0QEt3QjjZLNjI2EJ6/hqJ9JI0JyLEiOn7OUYL1LdcpY+VZQc/4FMn?=
 =?us-ascii?Q?n5LLCii753kGZ5VBiwbx+hkf2Qc56Q1HVoPntFEnDY8cUk/fDJ+zDInqX6aS?=
 =?us-ascii?Q?a4tfheYijr6SLzGZniN1Y4Cd8L/4e/h+UxPscPDUBFygTeh5dCNrQ3TrhB65?=
 =?us-ascii?Q?gDha8apITjaJs/x2Z7jyMHTuhet81D1KFM7gJWog7yQIBt0CG4e1spEDUflS?=
 =?us-ascii?Q?+Q4J0Q3+o6mjzm4uX/FypY0Vz4mm9UrG0cLx8fdn9veVBD0rpvKq6bHxA7iL?=
 =?us-ascii?Q?FARPiGcWEWE3rGZYqMmZ9yOupSbnIhIrkGKkTHSjQd831Y3jjLo5kHTo50jc?=
 =?us-ascii?Q?phJ444c+KhNZ1A+FCneasWgsEQtfszW8/2MQ1Z+d6b8q5oheYCTnHR1Ztmm7?=
 =?us-ascii?Q?RkhBQlHCW80T9+VX7PqNv0wT9Y/0kKpUVmofXs2pFIezUACx3uR8gn/xzvph?=
 =?us-ascii?Q?6FMXml3pR/pEk1h9Re5tuqFaf9ZBnt/GmCEdEymuRN6vHXq9ihiw75+Oxkja?=
 =?us-ascii?Q?ji+Dyfd41PyHcvPddcWN+HDXdQ2YUNdUs9hDjBZBs1zUe8rAzlKXjk9+hi/5?=
 =?us-ascii?Q?ytJaGRlcYXdyH3ri7tyjlGxflDDNwpJgm4YzVTkrZDWieH+h4QbfzGZGstas?=
 =?us-ascii?Q?BRGX1+pGW/ZHCWXLxdjf9hDmXovaXbLsDdnR6HnkqT+AKdWBXYzXvA3/Zjls?=
 =?us-ascii?Q?k+US8oYla0aXZXxuDgtAoVc/aOPFlTiODfccUgxZGfQuxcSg/7EHr+/hEgnM?=
 =?us-ascii?Q?nsUKs3HOetayHP6bQkBGbnvgxH07RVNMFYplJRumnqQJT/1ppB5u4mAC0O2j?=
 =?us-ascii?Q?aRWkI4y3G5ZKHvaDQk4hOZ9wBhdGVW4ZpMjUJmNdYw/+3be7OEpXx/Bd4+FM?=
 =?us-ascii?Q?pxVAlzEomREWBZg7jAymajYrs2Kd4aEhZyiyKfDG4EqvoQ2QjFciW5HXJGiW?=
 =?us-ascii?Q?G6KjOXy2NAmG5ezJsmM2ETdb6MP9g4N/W2sQ67+hmcZvnUcDSkgFD3vhMt+z?=
 =?us-ascii?Q?2SSM4FGKqHx+kbkV0gHuPlXbRvR52EtOUvxp9ovNjnRuxWUDeISLkij9uYY9?=
 =?us-ascii?Q?XyZNzHN6h76hMvQez05h2JacBwOgNdN+gXjX6ASGKE7+ZstlevtA6Mc1y5y+?=
 =?us-ascii?Q?fj/WvWKd7Wui3xmULLJ2m6NhLLVFOWDvS4A1MIsT4GDGXL4o7OZM+EBT9mPe?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6d9150-7c38-4598-c743-08dd832e5dcf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:48:52.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw2lKmS/hnk4zlkLLs6r4QdNZQNO11RsgoIQwHRgnxx7KqWILqMEvw5j3f75py3yElyH0B1F36k/vVm/V4kil1By+CF39C4MD0y/otJayW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4990
X-OriginatorOrg: intel.com

On Tue, Apr 15, 2025 at 07:28:12PM +0200, Alexander Lobakin wrote:
> Start adding XDP-specific code to libeth, namely handling XDP_TX buffers
> (only sending).
> The idea is that we accumulate up to 16 buffers on the stack, then,
> if either the limit is reached or the polling is finished, flush them
> at once with only one XDPSQ cleaning (if needed). The main sending
> function will be aware of the sending budget and already have all the
> info to send the buffers, so it can't fail.
> Drivers need to provide 2 inline callbacks to the main sending function:
> for cleaning an XDPSQ and for filling descriptors; the library code
> takes care of the rest.
> Note that unlike the generic code, multi-buffer support is not wrapped
> here with unlikely() to not hurt header split setups.
> 
> &libeth_xdp_buff is a simple extension over &xdp_buff which has a direct
> pointer to the corresponding Rx descriptor (and, luckily, precisely 1 CL
> size and 16-byte alignment on x86_64).
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # xmit logic
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

few comments/questions, i didn't trim.

> ---
>  drivers/net/ethernet/intel/libeth/Kconfig  |  10 +-
>  drivers/net/ethernet/intel/libeth/Makefile |   6 +-
>  include/net/libeth/tx.h                    |  11 +-
>  include/net/libeth/xdp.h                   | 534 +++++++++++++++++++++
>  drivers/net/ethernet/intel/libeth/xdp.c    |  87 ++++
>  5 files changed, 643 insertions(+), 5 deletions(-)
>  create mode 100644 include/net/libeth/xdp.h
>  create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
> 
> diff --git a/drivers/net/ethernet/intel/libeth/Kconfig b/drivers/net/ethernet/intel/libeth/Kconfig
> index 480293b71dbc..d8c4926574fb 100644
> --- a/drivers/net/ethernet/intel/libeth/Kconfig
> +++ b/drivers/net/ethernet/intel/libeth/Kconfig
> @@ -1,9 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -# Copyright (C) 2024 Intel Corporation
> +# Copyright (C) 2024-2025 Intel Corporation
>  
>  config LIBETH
> -	tristate
> +	tristate "Common Ethernet library (libeth)" if COMPILE_TEST
>  	select PAGE_POOL
>  	help
>  	  libeth is a common library containing routines shared between several
>  	  drivers, but not yet promoted to the generic kernel API.
> +
> +config LIBETH_XDP
> +	tristate "Common XDP library (libeth_xdp)" if COMPILE_TEST
> +	select LIBETH
> +	help
> +	  XDP helpers based on libeth hotpath management.
> diff --git a/drivers/net/ethernet/intel/libeth/Makefile b/drivers/net/ethernet/intel/libeth/Makefile
> index 52492b081132..9ba78f463f2e 100644
> --- a/drivers/net/ethernet/intel/libeth/Makefile
> +++ b/drivers/net/ethernet/intel/libeth/Makefile
> @@ -1,6 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -# Copyright (C) 2024 Intel Corporation
> +# Copyright (C) 2024-2025 Intel Corporation
>  
>  obj-$(CONFIG_LIBETH)		+= libeth.o
>  
>  libeth-y			:= rx.o
> +
> +obj-$(CONFIG_LIBETH_XDP)	+= libeth_xdp.o
> +
> +libeth_xdp-y			+= xdp.o
> diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
> index 35614f9523f6..3e68d11914f7 100644
> --- a/include/net/libeth/tx.h
> +++ b/include/net/libeth/tx.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/* Copyright (C) 2024 Intel Corporation */
> +/* Copyright (C) 2024-2025 Intel Corporation */
>  
>  #ifndef __LIBETH_TX_H
>  #define __LIBETH_TX_H
> @@ -12,11 +12,13 @@
>  
>  /**
>   * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
> - * @LIBETH_SQE_EMPTY: unused/empty, no action required
> + * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX frag, no action required
>   * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action required
>   * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
>   * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
>   * @LIBETH_SQE_SKB: &sk_buff, unmap and napi_consume_skb(), update stats
> + * @__LIBETH_SQE_XDP_START: separator between skb and XDP types
> + * @LIBETH_SQE_XDP_TX: &skb_shared_info, libeth_xdp_return_buff_bulk(), stats
>   */
>  enum libeth_sqe_type {
>  	LIBETH_SQE_EMPTY		= 0U,
> @@ -24,6 +26,9 @@ enum libeth_sqe_type {
>  	LIBETH_SQE_SLAB,
>  	LIBETH_SQE_FRAG,
>  	LIBETH_SQE_SKB,
> +
> +	__LIBETH_SQE_XDP_START,
> +	LIBETH_SQE_XDP_TX		= __LIBETH_SQE_XDP_START,
>  };
>  
>  /**
> @@ -32,6 +37,7 @@ enum libeth_sqe_type {
>   * @rs_idx: index of the last buffer from the batch this one was sent in
>   * @raw: slab buffer to free via kfree()
>   * @skb: &sk_buff to consume
> + * @sinfo: skb shared info of an XDP_TX frame
>   * @dma: DMA address to unmap
>   * @len: length of the mapped region to unmap
>   * @nr_frags: number of frags in the frame this buffer belongs to
> @@ -46,6 +52,7 @@ struct libeth_sqe {
>  	union {
>  		void				*raw;
>  		struct sk_buff			*skb;
> +		struct skb_shared_info		*sinfo;
>  	};
>  
>  	DEFINE_DMA_UNMAP_ADDR(dma);
> diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
> new file mode 100644
> index 000000000000..946fc8081987
> --- /dev/null
> +++ b/include/net/libeth/xdp.h
> @@ -0,0 +1,534 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef __LIBETH_XDP_H
> +#define __LIBETH_XDP_H
> +
> +#include <linux/bpf_trace.h>
> +#include <linux/unroll.h>
> +
> +#include <net/libeth/rx.h>
> +#include <net/libeth/tx.h>
> +#include <net/xsk_buff_pool.h>
> +
> +/*
> + * &xdp_buff_xsk is the largest structure &libeth_xdp_buff gets casted to,
> + * pick maximum pointer-compatible alignment.
> + */
> +#define __LIBETH_XDP_BUFF_ALIGN						      \
> +	(IS_ALIGNED(sizeof(struct xdp_buff_xsk), 16) ? 16 :		      \
> +	 IS_ALIGNED(sizeof(struct xdp_buff_xsk), 8) ? 8 :		      \
> +	 sizeof(long))
> +
> +/**
> + * struct libeth_xdp_buff - libeth extension over &xdp_buff
> + * @base: main &xdp_buff
> + * @data: shortcut for @base.data
> + * @desc: RQ descriptor containing metadata for this buffer
> + * @priv: driver-private scratchspace
> + *
> + * The main reason for this is to have a pointer to the descriptor to be able
> + * to quickly get frame metadata from xdpmo and driver buff-to-xdp callbacks
> + * (as well as bigger alignment).
> + * Pointer/layout-compatible with &xdp_buff and &xdp_buff_xsk.
> + */
> +struct libeth_xdp_buff {
> +	union {
> +		struct xdp_buff		base;
> +		void			*data;
> +	};
> +
> +	const void			*desc;
> +	unsigned long			priv[]
> +					__aligned(__LIBETH_XDP_BUFF_ALIGN);
> +} __aligned(__LIBETH_XDP_BUFF_ALIGN);
> +static_assert(offsetof(struct libeth_xdp_buff, data) ==
> +	      offsetof(struct xdp_buff_xsk, xdp.data));
> +static_assert(offsetof(struct libeth_xdp_buff, desc) ==
> +	      offsetof(struct xdp_buff_xsk, cb));
> +static_assert(IS_ALIGNED(sizeof(struct xdp_buff_xsk),
> +			 __alignof(struct libeth_xdp_buff)));
> +
> +/* Common Tx bits */
> +
> +/**
> + * enum - libeth_xdp internal Tx flags
> + * @LIBETH_XDP_TX_BULK: one bulk size at which it will be flushed to the queue
> + * @LIBETH_XDP_TX_BATCH: batch size for which the queue fill loop is unrolled
> + * @LIBETH_XDP_TX_DROP: indicates the send function must drop frames not sent
> + */
> +enum {
> +	LIBETH_XDP_TX_BULK		= DEV_MAP_BULK_SIZE,
> +	LIBETH_XDP_TX_BATCH		= 8,
> +
> +	LIBETH_XDP_TX_DROP		= BIT(0),
> +};
> +
> +/**
> + * enum - &libeth_xdp_tx_frame and &libeth_xdp_tx_desc flags
> + * @LIBETH_XDP_TX_LEN: only for ``XDP_TX``, [15:0] of ::len_fl is actual length
> + * @LIBETH_XDP_TX_FIRST: indicates the frag is the first one of the frame
> + * @LIBETH_XDP_TX_LAST: whether the frag is the last one of the frame
> + * @LIBETH_XDP_TX_MULTI: whether the frame contains several frags
> + * @LIBETH_XDP_TX_FLAGS: only for ``XDP_TX``, [31:16] of ::len_fl is flags
> + */
> +enum {
> +	LIBETH_XDP_TX_LEN		= GENMASK(15, 0),
> +
> +	LIBETH_XDP_TX_FIRST		= BIT(16),
> +	LIBETH_XDP_TX_LAST		= BIT(17),
> +	LIBETH_XDP_TX_MULTI		= BIT(18),
> +
> +	LIBETH_XDP_TX_FLAGS		= GENMASK(31, 16),
> +};
> +
> +/**
> + * struct libeth_xdp_tx_frame - represents one XDP Tx element
> + * @data: frame start pointer for ``XDP_TX``
> + * @len_fl: ``XDP_TX``, combined flags [31:16] and len [15:0] field for speed
> + * @soff: ``XDP_TX``, offset from @data to the start of &skb_shared_info
> + * @frag: one (non-head) frag for ``XDP_TX``
> + */
> +struct libeth_xdp_tx_frame {
> +	union {
> +		/* ``XDP_TX`` */
> +		struct {
> +			void				*data;
> +			u32				len_fl;
> +			u32				soff;
> +		};
> +
> +		/* ``XDP_TX`` frag */
> +		skb_frag_t			frag;
> +	};
> +} __aligned_largest;
> +static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
> +	      offsetof(struct libeth_xdp_tx_frame, len_fl));
> +
> +/**
> + * struct libeth_xdp_tx_bulk - XDP Tx frame bulk for bulk sending
> + * @prog: corresponding active XDP program
> + * @dev: &net_device which the frames are transmitted on
> + * @xdpsq: shortcut to the corresponding driver-specific XDPSQ structure
> + * @count: current number of frames in @bulk
> + * @bulk: array of queued frames for bulk Tx
> + *
> + * All XDP Tx operations queue each frame to the bulk first and flush it
> + * when @count reaches the array end. Bulk is always placed on the stack
> + * for performance. One bulk element contains all the data necessary
> + * for sending a frame and then freeing it on completion.
> + */
> +struct libeth_xdp_tx_bulk {
> +	const struct bpf_prog		*prog;
> +	struct net_device		*dev;
> +	void				*xdpsq;
> +
> +	u32				count;
> +	struct libeth_xdp_tx_frame	bulk[LIBETH_XDP_TX_BULK];
> +} __aligned(sizeof(struct libeth_xdp_tx_frame));
> +
> +/**
> + * struct libeth_xdpsq - abstraction for an XDPSQ
> + * @sqes: array of Tx buffers from the actual queue struct
> + * @descs: opaque pointer to the HW descriptor array
> + * @ntu: pointer to the next free descriptor index
> + * @count: number of descriptors on that queue
> + * @pending: pointer to the number of sent-not-completed descs on that queue
> + * @xdp_tx: pointer to the above
> + *
> + * Abstraction for driver-independent implementation of Tx. Placed on the stack
> + * and filled by the driver before the transmission, so that the generic
> + * functions can access and modify driver-specific resources.
> + */
> +struct libeth_xdpsq {
> +	struct libeth_sqe		*sqes;
> +	void				*descs;
> +
> +	u32				*ntu;
> +	u32				count;
> +
> +	u32				*pending;
> +	u32				*xdp_tx;
> +};
> +
> +/**
> + * struct libeth_xdp_tx_desc - abstraction for an XDP Tx descriptor
> + * @addr: DMA address of the frame
> + * @len: length of the frame
> + * @flags: XDP Tx flags
> + * @opts: combined @len + @flags for speed
> + *
> + * Filled by the generic functions and then passed to driver-specific functions
> + * to fill a HW Tx descriptor, always placed on the [function] stack.
> + */
> +struct libeth_xdp_tx_desc {
> +	dma_addr_t			addr;
> +	union {
> +		struct {
> +			u32				len;
> +			u32				flags;
> +		};
> +		aligned_u64			opts;
> +	};
> +} __aligned_largest;
> +
> +/**
> + * libeth_xdp_tx_xmit_bulk - main XDP Tx function
> + * @bulk: array of frames to send
> + * @xdpsq: pointer to the driver-specific XDPSQ struct
> + * @n: number of frames to send
> + * @unroll: whether to unroll the queue filling loop for speed
> + * @priv: driver-specific private data
> + * @prep: callback for cleaning the queue and filling abstract &libeth_xdpsq
> + * @fill: internal callback for filling &libeth_sqe and &libeth_xdp_tx_desc
> + * @xmit: callback for filling a HW descriptor with the frame info
> + *
> + * Internal abstraction for placing @n XDP Tx frames on the HW XDPSQ. Used for
> + * all types of frames.
> + * @unroll greatly increases the object code size, but also greatly increases
> + * performance.
> + * The compilers inline all those onstack abstractions to direct data accesses.
> + *
> + * Return: number of frames actually placed on the queue, <= @n. The function
> + * can't fail, but can send less frames if there's no enough free descriptors
> + * available. The actual free space is returned by @prep from the driver.
> + */
> +static __always_inline u32
> +libeth_xdp_tx_xmit_bulk(const struct libeth_xdp_tx_frame *bulk, void *xdpsq,
> +			u32 n, bool unroll, u64 priv,
> +			u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),
> +			struct libeth_xdp_tx_desc
> +			(*fill)(struct libeth_xdp_tx_frame frm, u32 i,
> +				const struct libeth_xdpsq *sq, u64 priv),
> +			void (*xmit)(struct libeth_xdp_tx_desc desc, u32 i,
> +				     const struct libeth_xdpsq *sq, u64 priv))
> +{
> +	u32 this, batched, off = 0;
> +	struct libeth_xdpsq sq;
> +	u32 ntu, i = 0;
> +
> +	n = min(n, prep(xdpsq, &sq));
> +	if (unlikely(!n))
> +		return 0;
> +
> +	ntu = *sq.ntu;
> +
> +	this = sq.count - ntu;

maybe something more self-descriptive than 'this'? :)
this is available space in sq, right?

> +	if (likely(this > n))
> +		this = n;
> +
> +again:
> +	if (!unroll)

who takes this decision? a caller or is this dependent on some constraints
of underlying system? when would you like to not unroll?

> +		goto linear;
> +
> +	batched = ALIGN_DOWN(this, LIBETH_XDP_TX_BATCH);
> +
> +	for ( ; i < off + batched; i += LIBETH_XDP_TX_BATCH) {
> +		u32 base = ntu + i - off;
> +
> +		unrolled_count(LIBETH_XDP_TX_BATCH)
> +		for (u32 j = 0; j < LIBETH_XDP_TX_BATCH; j++)
> +			xmit(fill(bulk[i + j], base + j, &sq, priv),
> +			     base + j, &sq, priv);
> +	}
> +
> +	if (batched < this) {
> +linear:
> +		for ( ; i < off + this; i++)
> +			xmit(fill(bulk[i], ntu + i - off, &sq, priv),
> +			     ntu + i - off, &sq, priv);
> +	}
> +
> +	ntu += this;
> +	if (likely(ntu < sq.count))
> +		goto out;
> +
> +	ntu = 0;
> +
> +	if (i < n) {
> +		this = n - i;
> +		off = i;
> +
> +		goto again;
> +	}
> +
> +out:
> +	*sq.ntu = ntu;
> +	*sq.pending += n;
> +	if (sq.xdp_tx)
> +		*sq.xdp_tx += n;
> +
> +	return n;
> +}
> +
> +/* ``XDP_TX`` bulking */
> +
> +void libeth_xdp_return_buff_slow(struct libeth_xdp_buff *xdp);
> +
> +/**
> + * libeth_xdp_tx_queue_head - internal helper for queueing one ``XDP_TX`` head
> + * @bq: XDP Tx bulk to queue the head frag to
> + * @xdp: XDP buffer with the head to queue
> + *
> + * Return: false if it's the only frag of the frame, true if it's an S/G frame.
> + */
> +static inline bool libeth_xdp_tx_queue_head(struct libeth_xdp_tx_bulk *bq,
> +					    const struct libeth_xdp_buff *xdp)
> +{
> +	const struct xdp_buff *base = &xdp->base;
> +
> +	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
> +		.data	= xdp->data,
> +		.len_fl	= (base->data_end - xdp->data) | LIBETH_XDP_TX_FIRST,
> +		.soff	= xdp_data_hard_end(base) - xdp->data,
> +	};
> +
> +	if (!xdp_buff_has_frags(base))
> +		return false;
> +
> +	bq->bulk[bq->count - 1].len_fl |= LIBETH_XDP_TX_MULTI;
> +
> +	return true;
> +}
> +
> +/**
> + * libeth_xdp_tx_queue_frag - internal helper for queueing one ``XDP_TX`` frag
> + * @bq: XDP Tx bulk to queue the frag to
> + * @frag: frag to queue
> + */
> +static inline void libeth_xdp_tx_queue_frag(struct libeth_xdp_tx_bulk *bq,
> +					    const skb_frag_t *frag)
> +{
> +	bq->bulk[bq->count++].frag = *frag;
> +}
> +
> +/**
> + * libeth_xdp_tx_queue_bulk - internal helper for queueing one ``XDP_TX`` frame
> + * @bq: XDP Tx bulk to queue the frame to
> + * @xdp: XDP buffer to queue
> + * @flush_bulk: driver callback to flush the bulk to the HW queue
> + *
> + * Return: true on success, false on flush error.
> + */
> +static __always_inline bool
> +libeth_xdp_tx_queue_bulk(struct libeth_xdp_tx_bulk *bq,
> +			 struct libeth_xdp_buff *xdp,
> +			 bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
> +					    u32 flags))
> +{
> +	const struct skb_shared_info *sinfo;
> +	bool ret = true;
> +	u32 nr_frags;
> +
> +	if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
> +	    unlikely(!flush_bulk(bq, 0))) {
> +		libeth_xdp_return_buff_slow(xdp);
> +		return false;
> +	}
> +
> +	if (!libeth_xdp_tx_queue_head(bq, xdp))
> +		goto out;
> +
> +	sinfo = xdp_get_shared_info_from_buff(&xdp->base);
> +	nr_frags = sinfo->nr_frags;
> +
> +	for (u32 i = 0; i < nr_frags; i++) {
> +		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
> +		    unlikely(!flush_bulk(bq, 0))) {
> +			ret = false;
> +			break;
> +		}
> +
> +		libeth_xdp_tx_queue_frag(bq, &sinfo->frags[i]);
> +	}
> +
> +out:
> +	bq->bulk[bq->count - 1].len_fl |= LIBETH_XDP_TX_LAST;
> +	xdp->data = NULL;
> +
> +	return ret;
> +}
> +
> +/**
> + * libeth_xdp_tx_fill_stats - fill &libeth_sqe with ``XDP_TX`` frame stats
> + * @sqe: SQ element to fill
> + * @desc: libeth_xdp Tx descriptor
> + * @sinfo: &skb_shared_info for this frame
> + *
> + * Internal helper for filling an SQE with the frame stats, do not use in
> + * drivers. Fills the number of frags and bytes for this frame.
> + */
> +#define libeth_xdp_tx_fill_stats(sqe, desc, sinfo)			      \
> +	__libeth_xdp_tx_fill_stats(sqe, desc, sinfo, __UNIQUE_ID(sqe_),	      \
> +				   __UNIQUE_ID(desc_), __UNIQUE_ID(sinfo_))
> +
> +#define __libeth_xdp_tx_fill_stats(sqe, desc, sinfo, ue, ud, us) do {	      \
> +	const struct libeth_xdp_tx_desc *ud = (desc);			      \
> +	const struct skb_shared_info *us;				      \
> +	struct libeth_sqe *ue = (sqe);					      \
> +									      \
> +	ue->nr_frags = 1;						      \
> +	ue->bytes = ud->len;						      \
> +									      \
> +	if (ud->flags & LIBETH_XDP_TX_MULTI) {				      \
> +		us = (sinfo);						      \
> +		ue->nr_frags += us->nr_frags;				      \
> +		ue->bytes += us->xdp_frags_size;			      \
> +	}								      \
> +} while (0)
> +
> +/**
> + * libeth_xdp_tx_fill_buf - internal helper to fill one ``XDP_TX`` &libeth_sqe
> + * @frm: XDP Tx frame from the bulk
> + * @i: index on the HW queue
> + * @sq: XDPSQ abstraction for the queue
> + * @priv: private data
> + *
> + * Return: XDP Tx descriptor with the synced DMA and other info to pass to
> + * the driver callback.
> + */
> +static inline struct libeth_xdp_tx_desc
> +libeth_xdp_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
> +		       const struct libeth_xdpsq *sq, u64 priv)
> +{
> +	struct libeth_xdp_tx_desc desc;
> +	struct skb_shared_info *sinfo;
> +	skb_frag_t *frag = &frm.frag;
> +	struct libeth_sqe *sqe;
> +	netmem_ref netmem;
> +
> +	if (frm.len_fl & LIBETH_XDP_TX_FIRST) {
> +		sinfo = frm.data + frm.soff;
> +		skb_frag_fill_netmem_desc(frag, virt_to_netmem(frm.data),
> +					  offset_in_page(frm.data),
> +					  frm.len_fl);
> +	} else {
> +		sinfo = NULL;
> +	}
> +
> +	netmem = skb_frag_netmem(frag);
> +	desc = (typeof(desc)){
> +		.addr	= page_pool_get_dma_addr_netmem(netmem) +
> +			  skb_frag_off(frag),
> +		.len	= skb_frag_size(frag) & LIBETH_XDP_TX_LEN,
> +		.flags	= skb_frag_size(frag) & LIBETH_XDP_TX_FLAGS,
> +	};
> +
> +	if (sinfo || !netmem_is_net_iov(netmem)) {
> +		const struct page_pool *pp = __netmem_get_pp(netmem);
> +
> +		dma_sync_single_for_device(pp->p.dev, desc.addr, desc.len,
> +					   DMA_BIDIRECTIONAL);
> +	}
> +
> +	if (!sinfo)
> +		return desc;
> +
> +	sqe = &sq->sqes[i];
> +	sqe->type = LIBETH_SQE_XDP_TX;
> +	sqe->sinfo = sinfo;
> +	libeth_xdp_tx_fill_stats(sqe, &desc, sinfo);
> +
> +	return desc;
> +}
> +
> +void libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
> +			     u32 flags);
> +
> +/**
> + * __libeth_xdp_tx_flush_bulk - internal helper to flush one XDP Tx bulk
> + * @bq: bulk to flush
> + * @flags: XDP TX flags
> + * @prep: driver-specific callback to prepare the queue for sending
> + * @fill: libeth_xdp callback to fill &libeth_sqe and &libeth_xdp_tx_desc

Could you explain why this has to be implemented as a callback? for now
this might just be directly called within libeth_xdp_tx_xmit_bulk() ?

What I currently understand is this is not something that driver would
provide. If its libeth internal routine then call this directly and
simplify the code.

Besides, thanks a lot for this series and split up! I think we're on a
good path.

> + * @xmit: driver callback to fill a HW descriptor
> + *
> + * Internal abstraction to create bulk flush functions for drivers.
> + *
> + * Return: true if anything was sent, false otherwise.
> + */
> +static __always_inline bool
> +__libeth_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags,
> +			   u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),
> +			   struct libeth_xdp_tx_desc
> +			   (*fill)(struct libeth_xdp_tx_frame frm, u32 i,
> +				   const struct libeth_xdpsq *sq, u64 priv),
> +			   void (*xmit)(struct libeth_xdp_tx_desc desc, u32 i,
> +					const struct libeth_xdpsq *sq,
> +					u64 priv))
> +{
> +	u32 sent, drops;
> +	int err = 0;
> +
> +	sent = libeth_xdp_tx_xmit_bulk(bq->bulk, bq->xdpsq,
> +				       min(bq->count, LIBETH_XDP_TX_BULK),
> +				       false, 0, prep, fill, xmit);
> +	drops = bq->count - sent;
> +
> +	if (unlikely(drops)) {
> +		libeth_xdp_tx_exception(bq, sent, flags);
> +		err = -ENXIO;
> +	} else {
> +		bq->count = 0;
> +	}
> +
> +	trace_xdp_bulk_tx(bq->dev, sent, drops, err);
> +
> +	return likely(sent);
> +}
> +
> +/**
> + * libeth_xdp_tx_flush_bulk - wrapper to define flush of one ``XDP_TX`` bulk
> + * @bq: bulk to flush
> + * @flags: Tx flags, see above
> + * @prep: driver callback to prepare the queue
> + * @xmit: driver callback to fill a HW descriptor
> + */
> +#define libeth_xdp_tx_flush_bulk(bq, flags, prep, xmit)			      \
> +	__libeth_xdp_tx_flush_bulk(bq, flags, prep, libeth_xdp_tx_fill_buf,   \
> +				   xmit)

(...)

> +MODULE_DESCRIPTION("Common Ethernet library - XDP infra");

tiny nit: maybe spell out 'infrastructure'

> +MODULE_IMPORT_NS("LIBETH");
> +MODULE_LICENSE("GPL");
> -- 
> 2.49.0
> 

