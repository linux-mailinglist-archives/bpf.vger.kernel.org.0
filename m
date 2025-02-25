Return-Path: <bpf+bounces-52512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490E7A442CF
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8863B194E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07D26A1BB;
	Tue, 25 Feb 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0YrFnr7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F6269CE0;
	Tue, 25 Feb 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493664; cv=fail; b=axi24MD6sUYOfRUAx2R8/LWvqLaGG81PfPXMWT767OV2WI3nU4njbuG02HMwV1CR1G1UJNMf5GK2FKT7xKao6d1uI/91BIFRZWRh0yJ3zStusSTI97gkXCqdeC280re6WT0DebETEYcxOyeLVHXM6RAEs4RlXcJBDAI5IHNtQUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493664; c=relaxed/simple;
	bh=vny4E/F7yW/iSUFXLrlUZE/9yi22wm2/yB63haix8Lw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ieSzxFQLr69g/u+gm7sK3nsyCsVEctxNWozGGWfP4gLC2S/lH1FzP5y3uMONL8VkKxzm7DpnNTaFJfGqlBdC5Q08Lz84tyeuXmNtIzSIdzJiYsIXH1ydLa0Hjr4JtvkNVwz0IFwDjotJAeDIqsMIzL5enQkSeh7iv46ERfwwP0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0YrFnr7; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740493660; x=1772029660;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vny4E/F7yW/iSUFXLrlUZE/9yi22wm2/yB63haix8Lw=;
  b=Z0YrFnr7vLdMWyKR4Xofgmtf/wOBv+eCOPxYXnnNRzeKVL5im5aA+mAO
   ewTRT0Nr+t3IDqlTL5QBvoCcMD7TZO3yeLEpOo0E6d0HKk9A+QA35z7xo
   sPZTFUcSzNb6LA63w24LXSmfJDH3wOKbK37kVwPQoYJlZE0POS7fzUOAD
   jo6piTHjK8b/gRGjcITflC6dCQvm2Sf5/m9DUD2zd38GAifk1Fkpd/8kI
   7NCfxbKzqW473FMlDTnk/SCSPv+/2kqHGAhZVX1ToffIEsZWnvPP9uqhY
   ooNuZEjq3d/QY/gbK+x7izKzZqOgFTJhM7LTCbq1aHxGGPYldkhAYtDi7
   A==;
X-CSE-ConnectionGUID: q37maCs2TZqudKR/qbbWCw==
X-CSE-MsgGUID: Nss68fYlQJKIilzejA1wGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41214447"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41214447"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:27:39 -0800
X-CSE-ConnectionGUID: PFP0y+9DQj2G69bI977SLg==
X-CSE-MsgGUID: 40Vs/4uQRWeZNOUy0G/qeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153590889"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:27:40 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 06:27:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 06:27:39 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 06:27:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWp+mijti5//f4WcuOriqmZksWBG15bwmn7UumK+XjU6nlRMbtSpyEef/hh7Vim00mkUPqy35dW+q2/kTdLT34rJYbPe22oPkbkVPhLoHL+o9nTJR6Aihr/dZjAVfH38t11kLs0uJUjKM0aXT1az5FD/Y2p/d1Xs3TOe+QVPev1sxkJvKU3sxBhx1SmKFiwkJj0p38jH0BCx1A95cED8YynRi40mosxdSGJBlWIcmvqiTu+342AaXejyW395eX+mJzXJ1EQcZ+iy2cAeQ6j2jXrlXcU91Nqdckny1sH4w6PuLf9tG4+hpH0knWoX7u9n2+sE66Tv3X50+LRdyuYwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5kmfFSmIj4f5BGA4Yad2SW/od1ldlcrbnRB7tNHzHw=;
 b=Z1qOQhMv76Bt6wPUaIJ33VHgqTG3A0WhguLjuBSugbr43Ixcw9Wb+iUyuMCWHBz2SZ0ilgsM18r2IHPiMHOJ/6V5RyM+Cv8NQ+T4C/J6SCZvHkSi1X185khew8bPCACpIPYeLUsCVds4L1Xb5SAidKQnyztfq8UfNYTbInCaO6sNocRXr9nXcOcFEGBpkZzPl7I5hMl23n8YP6IkGs1kZklHZESE762u+33Vqpk3Dh5I7YwX0EBjrlhoa7JkoaAwR5BX/5DhmLnLiz6/qKk1I/uXJkQ3mFGiWfvP0pcwGjXSJjVPmPDSX2H+9I+dvpLJu578oSkPgpRDNf0LuuPEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB5870.namprd11.prod.outlook.com (2603:10b6:303:187::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Tue, 25 Feb 2025 14:27:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 14:27:35 +0000
Date: Tue, 25 Feb 2025 15:27:23 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Network Development" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next 0/3] bpf: introduce skb refcount kfuncs
Message-ID: <Z73TS/tjk9okSqlC@boxer>
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
 <CAADnVQKYkwV1jc3aLwWqzgP7TKaPvq_NjpwvYdOXOgDQ3QZfeA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKYkwV1jc3aLwWqzgP7TKaPvq_NjpwvYdOXOgDQ3QZfeA@mail.gmail.com>
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: b23f7d1f-61bc-4fbe-8227-08dd55a88c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OURaYk5IT0ZhRi9PL2dwWmlmYkFMbGZSZ3NYVGc0UGlxSWN4QlhtT0VQZWsz?=
 =?utf-8?B?aWZPVmg5WnNBajZjN2ttS3UvNUg2OTBJblp2c2lQTEd5bndrSW9mNVkzYXRn?=
 =?utf-8?B?YWh5eHRaby9uYjJ3RmlvWThicWVOakdvMlhzS3phS2g4Rk1vT3dtSk55ZDRL?=
 =?utf-8?B?a0FuM0JKRUE3bC9aWmg1cHRTYWw1aFo4OXZQMWF5RVZWZ3BmV1R5a0dLb2hj?=
 =?utf-8?B?U3BqZGJpOGdMUHF1NE1sTitGQ08xVmJnd2xyV0d2WGIyRStDT1U0a2NZcFRx?=
 =?utf-8?B?M2xnQW5TeWJ1RUJWbklQNmFDcTJCUTMxMG9abFVLZWhvYUx6aGNoL3hUSEJG?=
 =?utf-8?B?ME5BbEwrbVp5UVRtaUtNQkdzUjcxK2RqN05kclQ4YjBxM21zOHUyUTNhaW5S?=
 =?utf-8?B?cDhnYnFUa3QrUmpOV3diWktleVV5SWkwamFKSFJ2cld4bE5MdGFXL3hTalNv?=
 =?utf-8?B?WWwxa29TWEdrV2tYTkFLbkRZY1BiMlM0Ui8wMlNFNkNTR081TXphTit2aERE?=
 =?utf-8?B?ckx3Nm1JV3JvTUZpTzhueURTM2d3VFpIamYrczNWYm1kcmVYYWkxeno5c0l0?=
 =?utf-8?B?dU9aMnBGME9aeUw1Z1JwcWlIT1B1SXBldHc2ZFpub2s3OVdwU0tLU2N1eVR0?=
 =?utf-8?B?RjkxQWNyZllPSHdIYWdJZU5Fb0tLbFdTbmVTSTNmRUdmS0lkQyt6M3pQUHdp?=
 =?utf-8?B?M2FsdmsxbjJCdGZPeWcwclRjR0hmbUZRNytVNlRvT2N6ajhUQ0d1SlR2VXpD?=
 =?utf-8?B?clg4c3VaeEo2cXhqaXk3d1JjRFBEZ3BGQlNMMjkvNERSUDMrNEJQaWc3b0lk?=
 =?utf-8?B?emlPaGIzaDl1V1JjZ0JndXRrMzlZREZ2THVkMExndCs5WVFjSHg0VjJnR0d3?=
 =?utf-8?B?UUVqQVVLZ2FtUGxCWjB2WlRZS2V0eUFWNTVVTS9XaVMyanRmVmN4RCtoUm5K?=
 =?utf-8?B?eXpib0lFT0lMelU4VDhnbXZaWW4xWkFPS3YrOHdRT0s4eUxMTDdiV2RjTXZ1?=
 =?utf-8?B?RWQ4UlE0U3hic1NsbEJBTHZTc3l2SThhVXQ2WXVKWTdDNk9keUxjSWVhYlZZ?=
 =?utf-8?B?b215TVNwNExOS2pyd1loU1MxS2JmeDJjN1Z0SjZjWVpWeDlTUTVkcUNmR0M1?=
 =?utf-8?B?b1BQSWw2NHk4MUgrdEFHVmF6NUpYMlI0Z2V5NS9xYXJ1bmdmUXE1U3NqSDFG?=
 =?utf-8?B?RnF2YnBsRzBWYTNZZFEwWjdsalRub2xEVGFtZ0l0NGpiWTMzWU5uYkZCaWxy?=
 =?utf-8?B?RzJDYU1ibkEyd1dMQkViUXZIaWRrbjIvVERoNUNaT3d3VHpWQ3JLejROZUJY?=
 =?utf-8?B?dEFqQ3M1S3VaRkJaR1JjNi9IbXUrcTlSUnpWcDJNaWNYb2JzeVhrUDhEbUto?=
 =?utf-8?B?eFZGK1V2RkxqZWJJbDZGREo4d3M2WE9yRDVISXd4OEd5bEpGcTByMVhLUERk?=
 =?utf-8?B?UGVQTmN2cUZFNXJZTlZsakl0TU1Zb1pkSUoySmNlRGI0ZFdCQmQxZ005Y3o5?=
 =?utf-8?B?QVJaQTJDc1hUZm1mUnNTR0F5ZUJzMU43RTdvcjBiRkh3ZG5qZHlYd3VPcURi?=
 =?utf-8?B?cGJCOXNzeXZrcjNpdGpqTE1ESTZpdlFGSjZKcnlOWkxHeW12TlBtSU9tTE5N?=
 =?utf-8?B?b0ZzNnJPQ1lpTEFXQ01vdGtBYnZZLy95b2ZRQmgwSVhJVE5oWlpTdDBwQkVz?=
 =?utf-8?B?cEwrbThlUWV4WVBBMDM4N3h2WlhWUG52UWhRMGxzVlp6V3pTUUcxMlVTRS9G?=
 =?utf-8?B?ZHBWMEFwR0N0TllNRStWakI4QUhWbVlYTzNpVHJGVjVRSmdJWnMydFNiUjdV?=
 =?utf-8?B?Ty9ZQk9zaExNcHpDZHA2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0trKzV6TEliOHE4blhSOXFQTnoyQmcySUtKMi8vY1F3bG81cm5mTjZ3Slgy?=
 =?utf-8?B?b0xJTnBsYyt0NnNLU2NwcHMrTDhNWGRab2NsZW41ZnJ0TFFjc09NZThjZGFr?=
 =?utf-8?B?TlA3bjhKM2ZIRG90MUlENVBNeVF5RUJLa3ZpWThlZzRYajJld2k4d3phTWxH?=
 =?utf-8?B?Y0ZLUzlnUVgvSUR5eG1sNjNFWE8vbm5xZFBzenYrendhZkx0bld5TG9Vb05M?=
 =?utf-8?B?dktCZUt3dTVCZlRGSHBTNW55bmNIajduYkxVZy9RdFR6c3NPek53REY0ejVO?=
 =?utf-8?B?dUNhVTl0UTBnTlN6NXRnelB3UWpQS2loTXlMZjFwTHN0d1M3ZkhtcnFXdTRx?=
 =?utf-8?B?R3JEMEcwNTFoUXdPQVNKb1docm92SDVzbjQ3ZkgrbVJVUERaMjllREIvWkFn?=
 =?utf-8?B?Q0FJNXk0MTRZQ0JwTHM5NkNOcFRWbEYwQVBIMVRjTHZxa1VubTFYY3BHR0JK?=
 =?utf-8?B?cTNxMHF2QTd4RmY0eGdQekEzd0pZUDlIenUxU1F3MlBWWjRLaExPdFk4a1hD?=
 =?utf-8?B?TFRFNFJveHJ3OWVjRTkxbURxSXhuVm1DWWh5Z0x4TG90Ly8vWGlPVDZEbEJj?=
 =?utf-8?B?UGxUcmhyRE9NekJhODFCdngvY2lVelpOU0NWWnlmVHlxOW1yUjYwYXBMVnFW?=
 =?utf-8?B?bG15Q3N6bWFzb3BTNkVmMXN5dGhkU3VUS1dKWE5TNDlyLy9ZRDB3QndhMWdr?=
 =?utf-8?B?R2tRNXhXajNVOGUyZ05XeEtnd2hDdllKUUd4aWhGTFl3TGdOSllPY3ovbGF5?=
 =?utf-8?B?aTRtVjRya25wZnhVdS9mSVBIc1IwbHVmd2FYdGlKT2tQb0ttbUZNWitzQkx1?=
 =?utf-8?B?VVRJalJLdWhmUEZFZGZLTlJtdkd0aGZHZmlibzhEMGdMdmVWeEJmNUtzaWFm?=
 =?utf-8?B?RlEwZDdwaHozNjVtckhuR05SVy9DSnIvT2lxNm1EQkEzVXdtYTBONlByMzl2?=
 =?utf-8?B?djlqMFRaTEhxdnVzczYyOHVMSk55VGhUVGJWNVRpZ3pGZ1JySk9vdi92OUox?=
 =?utf-8?B?WU1ISmpML3EvK0pndVk4UUpRWXJqTXNDalIxdlFibDBraGZnaGpVdVM1a1dy?=
 =?utf-8?B?dGpqc3JIYm42U1ZFYUtLYlFXRGVSMDFvbTZ1VzZIN0pYK09aK1I3a1JCZjlU?=
 =?utf-8?B?LzUwWk4rZ1o4MlM3MVF6OWFocSt0ODFVZDJOaGJZNEVibDEwbCsxajhvYUNF?=
 =?utf-8?B?L0pueG5JMDVUQTBMY3g2MEY1cGUzMS9PNmxIT0ppZWpvRGJIeVJMejlOeEh4?=
 =?utf-8?B?bmR6Y0lkMUQxUlNCRUNNNUpRbThJYWFSelBXSFcwdFdXTFFucTQzVHg1V1k1?=
 =?utf-8?B?bWU4b25XekNMciswcUx2V1UzTWJ5ek1uT1JFbFYvLzFXa1dVYUdTUHlhelNs?=
 =?utf-8?B?ZW5Zb0QzMkM5Sjc2TnNJNmpjeWNYS2VMT1hKTUVLRFl6OHJINXRpMG9SMHFC?=
 =?utf-8?B?SmMxM0RHOGVJdmhTc2FVaSs4bXRZZ2dhQmliejQwS2VTdUVxWW9PYzMrSlRx?=
 =?utf-8?B?Wk1tSHNWTXVEZ1NZeEZvN3B4NDIzVWxwbzFobThnZnNZeWZIVTJmTUc3US9E?=
 =?utf-8?B?YzBTYTNBTWpIN2VtSmMvWTVaQnQ5Q3BQTXdiZHFKMG05QjBLRFJONUVlUzlZ?=
 =?utf-8?B?T3cxdlBWdDBJNDY2YkUrUGE4T0NhcUR2aGdKNDF6UjFicW1SOHlvYmlJUldi?=
 =?utf-8?B?aTBHSVRGV0tsKzBIUFBmejhjVkVJQmFzcXBFY2Fqdk5oRjdNNHV2VlgxdXU5?=
 =?utf-8?B?QkI2TEhkY1NwL0R1N2hpTEZHeUljUjI4MTZ6dlFTeTdqK3pqR0ZKaTVUK0Fm?=
 =?utf-8?B?NmpjUGNyTGhJU1NXbjM0ckhNZjl4R29pVG1SK0JtNzZiN3RET2FVZkJpd2lq?=
 =?utf-8?B?ZXdINjBKL21rZGpJdktOOXpEY3Q3RERtU2hvb3RrcXVJSit5TkQ1Vnh4UklO?=
 =?utf-8?B?dHd1VWF3NWpOc2lFak1MUkYzaXh2cFlXUzgwdHJrVXRzQzVmN3pRaTM3UUZs?=
 =?utf-8?B?aEk5ZHpaSDVWQ2RrbzlaVmlGRTFHZDdMek9aQ1lqeFRwY21QbzJBZC9pUDVm?=
 =?utf-8?B?T2U4M0lQMHJ3VFJlS2IzcVlEQzB3RzlXeXA2UGppYzlybVZqT09UR3plNnBF?=
 =?utf-8?B?clVhY0lLL0s2ZTRmMys3UzRiMWc0R1JSV0pOclJwWHRpa2QxTlFjSTR3VWZW?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b23f7d1f-61bc-4fbe-8227-08dd55a88c47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 14:27:35.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34zWu7vIqC5mfVU+mv70InUrhiV0sWoynoa5wsLOvWGw770jJ3a3Haf0LRrJVYcXUPSW1mC43rMYyhaP2pSAVaAOeCGQKN0PPk65XtxGYnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5870
X-OriginatorOrg: intel.com

On Fri, Feb 21, 2025 at 05:55:57PM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 20, 2025 at 5:45 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Hi!
> >
> > This patchset provides what is needed for storing skbs as kptrs in bpf
> > maps. We start with necessary kernel change as discussed at [0] with
> > Martin, then next patch adds kfuncs for handling skb refcount and on top
> > of that a test case is added where one program stores skbs and then next
> > program is able to retrieve them from map.
> >
> > Martin, regarding the kernel change I decided to go with boolean
> > approach instead of what you initially suggested. Let me know if it
> > works for you.
> >
> > Thanks,
> > Maciej
> >
> > [0]: https://lore.kernel.org/bpf/Z0X%2F9PhIhvQwsgfW@boxer/
> 
> Before we go further we need a lot more details on "why" part.
> In the old thread I was able to find:
> 
> > On TC egress hook skb is stored in a map ...
> > During TC ingress hook on the same interface, the skb that was previously
> stored in map is retrieved ...
> 
> This is too cryptic. I see several concerns with such use case
> including netns crossing, L2/L3 mismatch, skb_scrub.
> 
> I doubt we can make such "skb stash in a map" safe without
> restricting the usage, so please provide detailed
> description of the use case.

Hi Alexei,

We have a system with two nodes: one is a fully fledged Linux system (big node)
and the other one a smaller embedded system. The big node runs Linux PTP for
time synchronization, the smaller node we have no control over (might run Linux
or something else). The problem is that we would like to use the Tx timestamps
from the small node in the Linux PTP application on the big node. When a packet
is sent out from the big node it arrives at the small node that send it out one
of its interfaces. It then replies with another packet back to the big node
with the Tx timestamp in it.

Our current PoC for attacking this is to store the skb in a map (using this
patch set) when it is sent out from the big node then retrieve it from the map
when the reply from the small node is received. We then take the timestamp from
the packet and put it in the skb and send it up to the socket error queue so
that Linux PTP works out of the box.

Note that for the purpose of setting skb->hwtstamp and sending it up to the
error queue we are adding a kfunc (bpf_tx_tstamp) responsible for it, which is
not included in this set, so I understand it is not obvious what we achieved
with the current form of this patch set being discussed.

We did not consider the restrictions that should be implemented from netns POV,
so that is a good point. How would you see this being fixed?


