Return-Path: <bpf+bounces-53346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96905A5035F
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228703A974A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D324FC0A;
	Wed,  5 Mar 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3k8a4cd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9320AF66;
	Wed,  5 Mar 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188295; cv=fail; b=WLI7wQtIrVJ4u2TKJIWqjxVDpU5yev3PZVG45MntnPa9U9aLIORW9VsQaInnONLzpQW5UvS7UQ/5ZqdonsatuhrR1zBPQDg4OQV94QJ3/qqnlqHNFUEVeHM5pZ6iG/U7XNAITnlJNJUGXUMtDk9ab3zvIed7mf35xaqzZNTx0AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188295; c=relaxed/simple;
	bh=uhF9dDX46tteA/T6on7Ueb8taYkT/n2417amo4j4kas=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQ8uQm2ND1GaOvHIMaRxdlfJ2Cl5TafCYldPOJdQd1215qnPN3EsVaRjoGvto3IcNZyNH85F/k348OxQQscLQ4YIADeFTgHtqr9mqfuHdycncwXiT3jH8ZOV35x6Oyj5cVVOuMSys4QOCkXuRKVnuEhVB97P/n2o11OD4Vl5T7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3k8a4cd; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741188293; x=1772724293;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uhF9dDX46tteA/T6on7Ueb8taYkT/n2417amo4j4kas=;
  b=F3k8a4cd9QsQa5nBRmBeNADAi5nxfvqF9DQotG0VLaTRG7nXt2pMdF4q
   d4RE2GfI/RcbttzUSovtpdlNevAPUjfquVHwnYV2TjtPr6coLCQ9EGykh
   uJ9GhB6ZbtCfDSDS+MN22Eh+hDteH+hQVgx3cN5nxAgWxm9EnByIsSSrA
   IHctmHfu7Dcw05C0fOFkZK72of3qtZqLVahEckCaf/IJ/3f/hwlCOsNuP
   i9XPC53xOWUBvIZnRu2MLEQSEd1M0tP85o9zEqjl/3UNM1sWDqEgYMGBS
   ie6lSlGjNFjQJ1/fQMllrIAAIWs76eWc9ro6pJy80bPrqTd/ufWsBob66
   A==;
X-CSE-ConnectionGUID: 0VS5smtPQq668wKZ2792SQ==
X-CSE-MsgGUID: WhUnhAAaSOqpSW69in4JAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42044675"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42044675"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:24:53 -0800
X-CSE-ConnectionGUID: bSJZxjJERaOzHtMDVv5xlA==
X-CSE-MsgGUID: Cc3Gbn9uR8ectO4mAc/DEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149663889"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:24:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 07:24:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 07:24:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 07:24:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuMeSiOksU0yEBgU3gnF50j1G6PD+sl/fUgDg8f4znCinUoXi2Yx/xmlIkW579PU4+jzNELfumZpIeHn+AWGQjMjIB5eic0iquGtsC8IiP1auxfvISsbffKJ6guoOPsorvImxTkSvcN9wgQb5Mk3RLgwh/UySwhxQF7oaV21HzSmduQ2GcxS5gCMLyPiUsuqq6UAOimMoW9GKO9q0RZvT0QilvG5smR9MAn813GElCkTS44SA0aqESlkHW6VZRbKCHU6ipB3M2FzZuY/8QGhLtSO5/WxMDXCArcBKyBVi3Yfs8r9JpnZ3zNG1PM3WPnzDw0YyQ5BBQ6LPxtGsSoC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp0sOkuoTQiEtlDVcsFzU8nkuNVkZYMFejsygzaZa3Q=;
 b=qy31US2GXLQpYS5KCZb6OT8PqSTlRnRo1f0Sf2KGTMvxVx9msrTo/xjavwElvK0DwBg0PYTYrg0mJRMq2YJ5A4/x9jJI5BVvMz/+dCHhhNN8v4ycMNWE+6/5JQGc6xxQXyRaZIxSjh5El7Xb63WZKYuv1+XlqiJpLs/BhWY/Q8whK1+CEUw1M6KJEqCxu/j6zLTKUEuACqNWFcyYsjtgS1sFLqBOOsKZNFsCoi0tbIqIHtJaSwGhrbVZ3tD01XNMAoOBOQ5qWQUX3S0OV5tpel81ci5i3sPI74GAqxVm7m5mEV0CDGpDjpj2EiG9+d3c7lDYp0nPzH6tI9dgIbY2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 15:24:48 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 15:24:48 +0000
Message-ID: <bc356c91-5bff-454a-8f87-7415cb7e82b4@intel.com>
Date: Wed, 5 Mar 2025 16:24:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 07/20] xdp: Track if metadata is supported in
 xdp_frame <> xdp_buff conversions
To: <arthur@arthurfabre.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <jakub@cloudflare.com>,
	<hawk@kernel.org>, <yan@cloudflare.com>, <jbrandeburg@cloudflare.com>,
	<thoiland@redhat.com>, <lbiancon@redhat.com>, Arthur Fabre
	<afabre@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-7-d0ecfb869797@cloudflare.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-7-d0ecfb869797@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2587ec-d431-45a5-102f-08dd5bf9dd9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXNVaGlBMmR1TTAyTHZBRXg2YVZyTTByZmlzelhtZEFxTlNjUXNvSnZjK2Nh?=
 =?utf-8?B?c0FKU1loK1lyakJsVzZTL2JlUlNPR0ZzYldiT1J4U2ZXSi92SzFwTWY2ejYy?=
 =?utf-8?B?WFl0ZG1YUDlDM2pQclVWMlUrSkJYNlpTdlhTNnJQOGhBZWpIWHdxRmxFTVAw?=
 =?utf-8?B?SjlJV1RVL2kzSElBQzdkWUs4VzJYdEVicVBMWUJtQzhTYmZxUHU1WEVaZXMy?=
 =?utf-8?B?Ym5XQTY0ekFQQ2tkWWtLTFVvZzFUSFZkbDNVSDFxWjRIQWkwb3ErYmhNWUFl?=
 =?utf-8?B?amJYektnN1kvd2JIbEdZV3Jxais0VUtSSWVtTGd6NU1aR21yVEFxaE5oVE9r?=
 =?utf-8?B?TWVqUEFETGxPMHUxbWcySERQVENPNWlxUUZnZ2l0blo4dlNKNEtuS3NIOFh4?=
 =?utf-8?B?d2tsZHJVdXgwbVp2ZFVOTm1KYjhWYWxZbFdka1BCTXhnWDI2S0ZQaUpON3Vt?=
 =?utf-8?B?ZWY5TVM1NnpQWGJPNXR0WXBGQzBrcXY3bEV2ZDBzbFA4WjBSOHcxY0hrSUFl?=
 =?utf-8?B?RElvMldnRXRqU0tuamZPZmRhbE5ZblI0dFlzYnIvS1JtQnIyRGhXNlVST3lN?=
 =?utf-8?B?VmtBVzUwVlpIQ1lheTZOL01tUnlKK1JlY2tEalJZa3pad3dJSEJBNWp6NTlX?=
 =?utf-8?B?NFVrTWdFa0dNdlFMcGR1TGJ6ek1XTk5xNzh5OERITjVQOG9ISWExdHBVbjUw?=
 =?utf-8?B?ZEpzQkpRQ1R3dHorQWVyTnJJM1FJUEtRNngrZERyMm0wdi9YQXJUeUtIWEov?=
 =?utf-8?B?UFU5TWNpL0xQYlA3elNqNExCMGZ5eWRyRWpqVkRhc3grd3Iva3c5L0dyVmta?=
 =?utf-8?B?bzVxbFVjY2oyU0g0ZGNHczR0bkR6NEJDM1NxbFZQRE5PaWlNS1N0N0d2RFJt?=
 =?utf-8?B?VzZEejB1QnZ4azgrWnZObWtFTlJYa1VQVExpY3Q5SXJrR2lmQ2N4ZmJMcVd3?=
 =?utf-8?B?NkllWlZSTEpmNncwN3N0d2I0dGVWQUt0TWlGZDJkV3NwU0J2dlZmYlpYYko5?=
 =?utf-8?B?NzVEMVVISitBMU91U2VHWGJEZlBnaXBzT3dTd2tZcHNmNXM0ZUZZVWNXeEp3?=
 =?utf-8?B?bzVVbVlxckFaRURTQ1lYZGFGZUhWWHhJcVV0TXBEbVBIS2dvemM0VGR3akFa?=
 =?utf-8?B?ZVI3VklEZGZwREtBdE9Bb3ZDSzVqaytGVHJvQ2IzQnF3RWpKUzBucjQzRkRk?=
 =?utf-8?B?aHhpNVpRM2pSbTArYy9QVUZLdXdRSTVObjVyaG95dXpzdkx4ZmZ1NHY4Y3hy?=
 =?utf-8?B?ckhFZllNcXRnd3FhQzMxSzc4NmZ2YWdkSURqdmt3aExGaEZnbGdHaDczMk5V?=
 =?utf-8?B?Y1IxWXRlZ3lTU0hRdnFuUXJMa1IzTEhtck5IMktSTGUyb1J6b096aWVIclV2?=
 =?utf-8?B?SDM2aXJFZWpNSStWbDlNRjFrNXlNdnEwODBjMnREUkdCSXBjK2ZjajFwT3ZU?=
 =?utf-8?B?aXBHL28yUTl1bTI5dERjYmo3TTdFNWVQZUlYNjBxaXJTYXdvUytzUDZIQjJV?=
 =?utf-8?B?QVRGYS81U0gwVVIrMjA5L0Vnbm45S2o1UmdaZ3YwNEl1bGJhUUJHS1ZLUWRV?=
 =?utf-8?B?eGRYSGtRTEhRc05FWUVuU1RWTWN3d011QVVFREZDeTZTOXRaK1lTVWZyYk1J?=
 =?utf-8?B?NUUybStTbGxRM2d1WkNtdnZPbUNZZmxmTTJBRDJaM3hOTjNkZmhQclE4MHpv?=
 =?utf-8?B?ak1OZklSeTdwcW9mYy94b0ZaL1V1TTA3d1hoc0g1ckJDQytIRTcrUHVTOEJJ?=
 =?utf-8?B?U0d5eDF3emoyRm9LbURHNG44MkMvTGdIM0hFaVUzS08zQWN0cWtQcWlESHpn?=
 =?utf-8?B?cUF4NnI5R25aRStxNHdxcHhuZjhnUU05M2tnSUpuVHRJYkt2Z0pUU1JVZ1dl?=
 =?utf-8?Q?bsqPtIhdulhZb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEhNSFgzdWlFVnR2RUZQM3lkUTVDYUFHVXI2NU9CTHVxV25CY1ZiNkRaZjFR?=
 =?utf-8?B?VVE0U0RxTEhyWWZYdXl2WEdmNkpQOTdScmdMZmp2SGtJcGN1MzZkYnlNRWNN?=
 =?utf-8?B?ZlQzam44bU0rSXQwdy83UHZhcTkxaC9xTXFRQ0RQbFE2RkpPWjFRN3BQMFcy?=
 =?utf-8?B?T2RRdFRKR2d0VEpocUZ2RTMxUTJDeGlhc2w4cDlTRnpTNndRQ1RxYXQ4Vi9j?=
 =?utf-8?B?MnIvYVJDRnRMN3FrOWc4TWllUnk1aXgyejJGNzVNT0pKeUZOQnpmZ0lWbGRR?=
 =?utf-8?B?Z1Q3c3ZIbzlxWGxzL1dZaFFSK1VKTUdhMS93UEE4ZER4S1FSSXoxVjVONU9L?=
 =?utf-8?B?QVhLaDNlMGw0WEpXeXpsbmhnZzFEZURWbDdLNU44TlFmQWcxS1JhVGt4T05x?=
 =?utf-8?B?Y3NKamJ5ZDFPdUwzdWNtd2piMmRlS05RODV0VGRWcXlDL0hYSUdvaVpxMnpO?=
 =?utf-8?B?WnUyYjJEejg1SXZHTjE5aUZOVWFlNzg5ZTNqN2FEMkN2YVFvcHVVV1pmUStQ?=
 =?utf-8?B?MjNXdGZTZmhneGhVdkpBVHB6Y096Z0x6ekc5UXd4NGo5a0lkR2JCaHBHUGhM?=
 =?utf-8?B?R1J1L3BsOXlKUUZTbFhhQWM3WG1UM2pFdm15UktkVTVvOExoT0RsVCtHTmpm?=
 =?utf-8?B?MG4wcjhBWXlJWi9XNEZxdUpOcnlXYTJjbVM1Tm9CTnczRDl3WTY1RVl1ZHNx?=
 =?utf-8?B?cnJsMmRTWWdsTXNMYUFDZi9kK2w2YmJWbUFsOUFjUzV3QmtWWVNLVGVSdnU0?=
 =?utf-8?B?elIxZUtBMVBlZitRSUFWVVJ6NzFleWJ6UW15eCtzcUxDa1BDblE5YkxSOHJq?=
 =?utf-8?B?cE9LUWVaTHZBVEFyMWN2cFhSRGZOZHcyRmxhalJBcnNjYWNwdXBxdTNJR0Q1?=
 =?utf-8?B?WTIxS0J2ZlJxRW1wZW1SMVVSWDFHSmgxUisrWm5YQll3ciszc2FoYkxCSzA0?=
 =?utf-8?B?ekdZdmx1RVFsUGNlWGM4dzMyRUNraVBUOFd6WExLL2ltY2hXRjYzc1BjNjFI?=
 =?utf-8?B?M2VtYXhzQjZrdllWVXFsRE9MU1JWeCtYTllLYTN1TnNBMVBDSTBGRm5CVy9k?=
 =?utf-8?B?QWg5dDhGUjExS2oyTHNuVE1DZjZKemROOS9QcFVGbFdjU3JlMmI3NzRzTUJ5?=
 =?utf-8?B?SU9mekVCemRZUnkwdWxqcjdOLzYzWHdxYndoOVFsSExHMnVpb2g4TnpLS2VI?=
 =?utf-8?B?SEdCdVBRVCtnUC9pSUdUVW41cnA4dlJDVG9WYVgrU1h4ZEh3VzFmUTA1SXVu?=
 =?utf-8?B?VVZkS3dnRWhpdkpoZUgvOFpaOENGUWk2ZmFML3hrbkZLWUQvNFQvbjBwQ0Fr?=
 =?utf-8?B?TDVqcEpZVGx4d3dWQ1pEQjJxL29hQ0szNDJBSUJGdUJjU3VDS3JOR1Bjekt4?=
 =?utf-8?B?TEkwWk9IR21HTlpuaFpvVTF6c0UyRUpGSXlBa3NLREIxbGpMaUVseWM2ZDI5?=
 =?utf-8?B?ZUcrbXdTTHBKMno0bXhXMjNPL2g1c3YrQTNOVE93cWRMbWsvZUsreU9oR2hE?=
 =?utf-8?B?cE5NTzJ1TW0rUXowNWh4anlNS2lCNWV2M1lCVHEwOWt2c1ArM3dFNDZiNXNF?=
 =?utf-8?B?VHA5K3YzNy82VTg0cFpXVW1DVGx3aUVaL3RsTTNoWmRKb3M1QTQwZlkzWTBr?=
 =?utf-8?B?VnNrTEEvSG5kQWlsemtsNkZCa1UwRzlJY3FjdHFhZWtZZGgra0kzMm1QblEz?=
 =?utf-8?B?bFNQdVNPallXMnc1VFlJcjhxREtKeW9zdzJnR2F6T3BlWVlnWEF6bngrcHdU?=
 =?utf-8?B?bUtPRS9mWDcrdytKNTdybDhVRFBHd2hlRFR5RTN1M2ZIY0luV25zMWtRRFpn?=
 =?utf-8?B?TXNUb1RDN0d4TUF5MUdBNUE5ald3VjdzcWRyNjUwVTN1cUdFS3ZCeHdDVThr?=
 =?utf-8?B?Q0JKNkxLSGd1bk5RNG5kdjI3U1hiUFkxL1I5OHJCREZ5UlhmbW5WM3VsQ29w?=
 =?utf-8?B?cHZrTDhXTkZZemNHbkM1blNTeXBSTjJKejRPZzlvZmY4L0E2RXV1SnlWU0do?=
 =?utf-8?B?a0dVL1lxMzJLTzRwTjcxZ3Jhc2lTc3h0M0J6RzVWbG5xTXhjQzhlWm1SbUZt?=
 =?utf-8?B?V1RLbzNoejV6ajd1cExncDFMeUJ0WTFiS1MyWkltejYxYzZ2RTQydHFldzA4?=
 =?utf-8?B?TFBOaHVHU1lCbG1JeW01VEw2VS9XOTRGV09UakZ5M2ZyRkxkMVFiV2dkZExN?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2587ec-d431-45a5-102f-08dd5bf9dd9b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:24:48.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHsPggL6gSY3TlAY/oy3/EE7B4lr1Bj+0UEYb/a40hBAZqHznHwcD22V35dBU+DQ8/esQkdqTzq2/IdL9oIwBt5QkX+JcM0aR35Ew/bFRU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com

From: Arthur <arthur@arthurfabre.com>
Date: Wed, 05 Mar 2025 15:32:04 +0100

> From: Arthur Fabre <afabre@cloudflare.com>
> 
> xdp_buff stores whether metadata is supported by a NIC by setting
> data_meta to be greater than data.
> 
> But xdp_frame only stores the metadata size (as metasize), so converting
> between xdp_frame and xdp_buff is lossy.
> 
> Steal an unused bit in xdp_frame to track whether metadata is supported
> or not.
> 
> This will lets us have "generic" functions for setting skb fields from
> either xdp_frame or xdp_buff from drivers.
> 
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> ---
>  include/net/xdp.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 58019fa299b56dbd45c104fdfa807f73af6e4fa4..84afe07d09efdb2ab0cb78b904f02cb74f9a56b6 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -116,6 +116,9 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
>  	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
>  }
>  
> +static bool xdp_data_meta_unsupported(const struct xdp_buff *xdp);
> +static void xdp_set_data_meta_invalid(struct xdp_buff *xdp);
> +
>  static __always_inline void *xdp_buff_traits(const struct xdp_buff *xdp)
>  {
>  	return xdp->data_hard_start + _XDP_FRAME_SIZE;
> @@ -270,7 +273,9 @@ struct xdp_frame {
>  	void *data;
>  	u32 len;
>  	u32 headroom;
> -	u32 metasize; /* uses lower 8-bits */
> +	u32	:23, /* unused */
> +		meta_unsupported:1,
> +		metasize:8;

See the history of this structure how we got rid of using bitfields here
and why.

...because of performance.

Even though metasize uses only 8 bits, 1-byte access is slower than
32-byte access.

I was going to write "you can use the fact that metasize is always a
multiple of 4 or that it's never > 252, for example, you could reuse LSB
as a flag indicating that meta is not supported", but first of all

Do we still have drivers which don't support metadata?
Why don't they do that? It's not HW-specific or even driver-specific.
They don't reserve headroom? Then they're invalid, at least XDP_REDIRECT
won't work.

So maybe we need to fix those drivers first, if there are any.

>  	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
>  	 * while mem_type is valid on remote CPU.
>  	 */
> @@ -369,6 +374,8 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
>  	xdp->data = frame->data;
>  	xdp->data_end = frame->data + frame->len;
>  	xdp->data_meta = frame->data - frame->metasize;
> +	if (frame->meta_unsupported)
> +		xdp_set_data_meta_invalid(xdp);
>  	xdp->frame_sz = frame->frame_sz;
>  	xdp->flags = frame->flags;
>  }
> @@ -396,6 +403,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
>  	xdp_frame->len  = xdp->data_end - xdp->data;
>  	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
>  	xdp_frame->metasize = metasize;
> +	xdp_frame->meta_unsupported = xdp_data_meta_unsupported(xdp);
>  	xdp_frame->frame_sz = xdp->frame_sz;
>  	xdp_frame->flags = xdp->flags;

Thanks,
Olek

