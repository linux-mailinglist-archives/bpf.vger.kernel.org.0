Return-Path: <bpf+bounces-42775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C968B9AA121
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4671F22787
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150FE19C547;
	Tue, 22 Oct 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iebYW6jN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA036F066;
	Tue, 22 Oct 2024 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596450; cv=fail; b=jRHAg95soWnewsHUZIXHkj5lwVhCQXwYzX7Eu9381stp2sVQOfldFrscn6NzAgV9Mg9Lb6FwIGKVAIXSwOG2FIF5rchaEoFDXi5/EQm7dcauNU0sL0hGHVwxrCDJgiZG73j4whPwVtXd9cgeR5n62wiv+mmoFC0Gu2epjqPzqFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596450; c=relaxed/simple;
	bh=hRvxUzocOWIM6IXVlMytvCnHlDafwCDjEpr0ZbzySiQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uqq+az9umlCXBYfxws1mpd6yQhkMnJkqSax4QHkyi8qEQ0m10FfFMoT8WwKPRcDdTw6LDAfLhoXNOgi4/57iu0s45m+WFPSaL9GJg9DZsSrPciSh5Pr3pXLNTeVq+3AqM6WRnPdrHZU3sbZEWTjXDWNS1I26UleH5JlRjvir9MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iebYW6jN; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729596449; x=1761132449;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hRvxUzocOWIM6IXVlMytvCnHlDafwCDjEpr0ZbzySiQ=;
  b=iebYW6jNkEZigqdKu0uoLjJ3B6KlQJxcShK8pPjFazFmQoCYbzA8Ktyv
   P1VIRwbeqfSjiVYqbgkKUgLKWKI1tUWeVoyK3NPHIKHwflRld3rdkan5M
   ij6H4mBH2962kXWZZiB2ygYPdALXl5K/lYMIIAVNUcwf3FmNWPTtXkkAK
   dD438c6TtmqSm7KvY73kkmjIXADvFvfIFVak+l0Ad+W+AjE5VD8zie2wE
   eFYBZHKIcttp1e0sygP6EnPofbPSVef/kaLClcHvbt6ZD9JvIc61+xZrw
   bevEK8Qk5cJhd1SxNIyfwrIK0X0TjeX+yWeqkuWOCczr4R8i0QB2XJBqK
   g==;
X-CSE-ConnectionGUID: Vcogw2RdR+C3pm03m2DIdg==
X-CSE-MsgGUID: SRLYpCsKRO+R/+SK1ng/qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32816928"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32816928"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 04:27:27 -0700
X-CSE-ConnectionGUID: 56LcLbmvSeGjyaLyGEondQ==
X-CSE-MsgGUID: mLl80k2jTxyRy2PQwY3qvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="117274847"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 04:27:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 04:27:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 04:27:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 04:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+T3aiSYVnkk/LZUcBnH/ocNlTRmKEgEtut04aiGyAItbcHS8wzkeF2gWkHoPfsLyXy6YUxrqfSfyjOLjSq+G1sq5mNt13hlSFOyzb7d88w4rAHN0PxcP71N+0t07Yx73xBM+z45TWwNsUuJJY0Y6rZHpb2Nz/q/iT7A798qvn48J5LmFcnqlg3TOdj9JSk52ofCxvCV+Y5MnS+CS5AUrC56DlekwGtiwYvRomfbuK+05zucnfYWZHgAEggLL1Sq8B5IExizv0yzBwUgLZ2PLzYpqzmTzZtgmEqft2xyuCphlYCVQoNFvCNqn0QGSEeM612WMrqZDzuErATFI+VO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10RjmIzIVfWs27z29lDWgcDHj7YSIRTBj5Xu8YyJXTE=;
 b=xQo/WQPUPcbXorBDY5Fz0VTMsZkI8m3/65Qq0LaIw8KpY4//NHribQIbf8Dpq252h1zvATppNvU7rWd/jmgEr80v+HbaytKdkDVcQwNeCCVI9e3DC2gsWil3qi6ieSeGAMlzI8N+B9yY8k8NIiryaTXFpeiPoRcLRh8qFkbQDOh5/F6gMYEZokukACrzQ83HWf80BudWFHUO7VFTyK38KyDQxaemivVGSLxNqwZiXEtezs/FOIM2EDbtz5NfnsLJF12JuMw7bKcIocj3dB/qi86FHVFh4x1Kuz/EjX5AAdhCBK+NLWyqXhUCdK+niiQyZJiCdOxb9sDNoADSIFoXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 11:27:23 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 11:27:23 +0000
Date: Tue, 22 Oct 2024 13:27:15 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH v3 net 4/4] ixgbevf: Fix passing 0 to ERR_PTR in
 ixgbevf_run_xdp()
Message-ID: <ZxeME2QozMGEM290@boxer>
References: <20241022065623.1282224-1-yuehaibing@huawei.com>
 <20241022065623.1282224-5-yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241022065623.1282224-5-yuehaibing@huawei.com>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: bb369f83-6f6e-484b-e079-08dcf28c7faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dxJ0NOvcv8IWK1CkXEh+wj/Nzi9RME04Lx0oKhUxOqUF6RT+Dus9uOa8lqEb?=
 =?us-ascii?Q?EUQVJDTLkzCZN9I9MEi7HKXb8pijF7LIX10JF3euUwaI6Fw+jv91N3sPHnQj?=
 =?us-ascii?Q?fEuq2fdXNRQaRJR6EGodSaLW5gsaQHJ8LWioukX1sIYR9Aa0ijPFdIkYLTAa?=
 =?us-ascii?Q?FDLziQ+H0o6zzolXzGDXW2nX0rTFDU6J6S/yKOx/rwM9/RAn7DIyRBI0gAan?=
 =?us-ascii?Q?1XIV4ZMaN95XOidNzFREq18NYDxnRK2lWPiHUNNN486aoiyjglb37UR0MfLg?=
 =?us-ascii?Q?IhpZZ6Qnk2uqg/AESLG7wF4EmorJLkh/iufbsQHarLo3MZaFED90MTMShliz?=
 =?us-ascii?Q?JUN1NL5KM2snkParOAAOUZXYP7dAKbMessP2Mnb4EqQHVtzREyjEEaJMV3Bs?=
 =?us-ascii?Q?u0ARqwWCgi0ohsiq8f7HO5GTkojBWRChmToIvA4ou+Rf2OTgbHrUmwk2OnAL?=
 =?us-ascii?Q?onqE7lo5kCSFktlmZl4cC6RJmvYYoiHiWmhvVjZPwhZURP+IEFsc85726/P5?=
 =?us-ascii?Q?i+gdrZh9Vnn2O3On0DPZAdTY+46jTBU9wqACyC1FV9gA2uXzFW0E3jqgkLwQ?=
 =?us-ascii?Q?ib6HjIPXL9Gd6dEOfsT3V9uh++xYuya7q3fsgiKt1aw8DMvKS9shv39IjI8b?=
 =?us-ascii?Q?Kky0d4vdQY/gX6tN4lPx+0WTAhM2RV5DZtC3iRamzuAj0EWS3v7nRIequuzM?=
 =?us-ascii?Q?oS/T2/sto+2Xct2A+O1/Yd0sv7fX+332cREmvf88ebXXuyuY7p3uCjqRqYrx?=
 =?us-ascii?Q?AnA6BNVxE/bhPsa8nSxV759zoSveGiq0/1XBK8Cr+mFRrWf2pVxn/YS4FEx3?=
 =?us-ascii?Q?cb6zNf2swakezySRmmCPtJIl5C9wBsOBp+IS4N1Obqju3BueK7er7nkbUObQ?=
 =?us-ascii?Q?bLQrgeRzBh3Bi+lNgdXF46eMcCs/9B/wseJoKN8VQdgBXZrwfZg6TOeGAy3x?=
 =?us-ascii?Q?POizLuC9Nd03W83LOoSh2dRHPV4gqDXdNWMOsPOHtGDMnMQb0uE8Hk9GKgQT?=
 =?us-ascii?Q?EVzJfR/fja/tDBm05p/Za5h+O+Ma1SbBoMTmqxtE0PWR7Zdv4hKxyrIaNlKU?=
 =?us-ascii?Q?45B0ejcPaIwoJ4pW+2AkfLrI7/US2RzKDSqH0T3S1rI/6rM8za6l3igLkYpJ?=
 =?us-ascii?Q?RQwXpWbDSmSO6gNtVexi1Inyiw51XYLhCPzyhJRaWFjf3hCVQnu97x+rWLW5?=
 =?us-ascii?Q?0OIerPsvnxuiLB1X0FlbMfcqx05LuD/uQ6z/moYXdGcM1g0c7L1dd+GMXQ9h?=
 =?us-ascii?Q?KI+VhT4GIukLl/uHKsc+c0fWVXPzeY27BUOatmLFK7edk3sI1ZClpjzySt9D?=
 =?us-ascii?Q?OxavD5JK2/js9ei2LOmCDrJM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRbD0NHzD/9BNDcEFZHYrre6YlxtdSt/1cY3Avt3UDUzXQIIuzNHlAZ4fKQ2?=
 =?us-ascii?Q?g7blvTecPxPXIF8mHwRnrRnGZepqISiQ6+1S9zfJkrgEJ8gqfveMLRGDGew4?=
 =?us-ascii?Q?1iKQwoWjG8sBUNMNWzdi/8yg/sR0pZZrd6p6+v6jwxG8dDAo+qGS0rvdbzRj?=
 =?us-ascii?Q?7ydF6wbasgpiyz/nlhj8K0mN7HEifRnc6GLBE9vZf5FBwdT3hZOk1ETu/Mtq?=
 =?us-ascii?Q?mB9iphFkFEbGDodKo3iiUSCLgqxA2zrxjCueCYVf3n9mlOLBKAeCcD5DkldZ?=
 =?us-ascii?Q?nUQpTtEyLP7ma8k8BAaO1sR0XDVNuAOmfz9tqwCawYEb08Fej8XXpahHjCvy?=
 =?us-ascii?Q?/iYRZsmcN5aA8MFDQNMlhp0JpdD/pxQCbd2/NZVP4GmdJ34jvLWHu+QXVYMU?=
 =?us-ascii?Q?wNzTFxb7MFVVJd5FpOq5kPl8QG/Leiu0dsZxDOgnNvYlIl04Pfw9ulVJmjEh?=
 =?us-ascii?Q?xRxNe0sCD5/uOaUuMw4WSkI68hmI2v42cox49i2znm6NHS7JLVndLAW9K75+?=
 =?us-ascii?Q?N8wk4UbP9FZYaXIB/Qgi4asN4dnN9fWs5m6jRSdaSp8JNki+faFqtHn4Ul3u?=
 =?us-ascii?Q?Jkd19dUOwh35t0LPpr1QRCNm/yWrcPllk4UCm8Huk/g0Drq/9MVPtQ95st3U?=
 =?us-ascii?Q?mMXpuSMBMeMW7KIjG0+5rNXTV4PJhU2TySTG0yRoQ/UiIn2d7UqeEkdp7RPU?=
 =?us-ascii?Q?dGej+Ljb+sa1oXUKs6tbi8yAV7vYMCDvJDIq48fWzU+ltHWRdsNJgQs8bWBl?=
 =?us-ascii?Q?wIT71oUvn9eY1JNCWHH/DvMu1G+pMIXNiu2FVJCzGG1+sMHMOh0n81t3GPKw?=
 =?us-ascii?Q?9wNZMgYPjlN6qaKS7peAy3iulbKF+0nrDOfBsEBuZ8Z02HzaXnE5ypG0JAk7?=
 =?us-ascii?Q?C0QyoWkWHNKjpojRAZBFOigtXSFcUl8uUkEkZNYrNXRYRj5R9HX8K/h9HIGc?=
 =?us-ascii?Q?pIAlCjEkzf9R0X71OfaHxKCEjgZ2xoBKOvjyCW+h8HcIBlQmJfnYT6eMmdi6?=
 =?us-ascii?Q?pNl41wtr+Ed7bwnxpvH/ftM5oZR3MaMw4XXox/yTHnyCyh3oMW2GheSqezkq?=
 =?us-ascii?Q?T/l8jevVDwiKVHGksRNaaKYxi5i6Y9ZsDHO9wlxM+fVspUE4WVa9NGko1zpt?=
 =?us-ascii?Q?0ttCdEfPsBsdR7/bsxZvWmZ1K9vgxGo07kY/SkP9l4xPwJdv7NkjywqJSNjD?=
 =?us-ascii?Q?6alvOA4s5E2cJTFrEAyeJNvkK/6kDtFlgFVhbEfq14xGwCvBaSAEvQPCykdz?=
 =?us-ascii?Q?oGDf2Qb4US2xDMelZjLfGhcev/dncxV3XLIu0bp+UkP1yRjV+Z1vPdujJ3Bq?=
 =?us-ascii?Q?2vDiOIgevoOELVlMUN5X18sIK67Dk2MVW9eWmJDrkWyI/ij4dVVgfFZEmBR7?=
 =?us-ascii?Q?D93uoCCFcvf4aQzkLIL3j8Pa2IK3T+6YzAj0o5VYaXSuco0VwcJZh3RkFGWa?=
 =?us-ascii?Q?TOlSei0qtwgPNNb+K2PZqtyrJY08NlnWY1mb8vinG79xgnopvtLn6ZbyaYON?=
 =?us-ascii?Q?wThefDyE9Xr/59VxioD+8hcZrzui4DtWrtSi7MLY9n3VgIlckc9t2GZzB2fN?=
 =?us-ascii?Q?3ziIJDUc36H6yLdVyC/O8dyL7asdv9AsvySr5iJM7lEIySPh1bqtqILKIb0X?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb369f83-6f6e-484b-e079-08dcf28c7faa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 11:27:23.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhHf94WdSAvqGn70Hr/xXtU9/4/TnOeFdkWkmn4ZShb4mY2vohU3LTnC9cDh14OdbYoA3kkgnx5IOHtHGKjXyeLzqbeSL9ns9hgepFygHME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com

On Tue, Oct 22, 2024 at 02:56:23PM +0800, Yue Haibing wrote:
> ixgbevf_run_xdp() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> ixgbevf_clean_rx_irq(). Remove this error pointer handing instead use
> plain int return value.
> 
> Fixes: c7aec59657b6 ("ixgbevf: Add XDP support for pass and drop actions")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 149911e3002a..183d2305d058 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -732,10 +732,6 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
>  				    union ixgbe_adv_rx_desc *rx_desc,
>  				    struct sk_buff *skb)
>  {
> -	/* XDP packets use error pointer so abort at this point */
> -	if (IS_ERR(skb))
> -		return true;
> -
>  	/* verify that the packet does not have any known errors */
>  	if (unlikely(ixgbevf_test_staterr(rx_desc,
>  					  IXGBE_RXDADV_ERR_FRAME_ERR_MASK))) {
> @@ -1044,9 +1040,9 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
>  	return IXGBEVF_XDP_TX;
>  }
>  
> -static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
> -				       struct ixgbevf_ring  *rx_ring,
> -				       struct xdp_buff *xdp)
> +static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
> +			   struct ixgbevf_ring *rx_ring,
> +			   struct xdp_buff *xdp)
>  {
>  	int result = IXGBEVF_XDP_PASS;
>  	struct ixgbevf_ring *xdp_ring;
> @@ -1080,7 +1076,7 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
>  		break;
>  	}
>  xdp_out:
> -	return ERR_PTR(-result);
> +	return result;
>  }
>  
>  static unsigned int ixgbevf_rx_frame_truesize(struct ixgbevf_ring *rx_ring,
> @@ -1122,6 +1118,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  	struct sk_buff *skb = rx_ring->skb;
>  	bool xdp_xmit = false;
>  	struct xdp_buff xdp;
> +	int xdp_res = 0;
>  
>  	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
>  #if (PAGE_SIZE < 8192)
> @@ -1165,11 +1162,11 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  			/* At larger PAGE_SIZE, frame_sz depend on len size */
>  			xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, size);
>  #endif
> -			skb = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
> +			xdp_res = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
>  		}
>  
> -		if (IS_ERR(skb)) {
> -			if (PTR_ERR(skb) == -IXGBEVF_XDP_TX) {
> +		if (xdp_res) {
> +			if (xdp_res == IXGBEVF_XDP_TX) {
>  				xdp_xmit = true;
>  				ixgbevf_rx_buffer_flip(rx_ring, rx_buffer,
>  						       size);
> @@ -1189,7 +1186,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  		}
>  
>  		/* exit if we failed to retrieve a buffer */
> -		if (!skb) {
> +		if (!xdp_res && !skb) {
>  			rx_ring->rx_stats.alloc_rx_buff_failed++;
>  			rx_buffer->pagecnt_bias++;
>  			break;
> @@ -1203,7 +1200,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  			continue;
>  
>  		/* verify the packet layout is correct */
> -		if (ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
> +		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
>  			skb = NULL;
>  			continue;
>  		}
> -- 
> 2.34.1
> 

