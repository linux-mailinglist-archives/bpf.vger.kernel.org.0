Return-Path: <bpf+bounces-55338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EFDA7C10C
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788D03AC15E
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01C1FCFC1;
	Fri,  4 Apr 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEUCFgEF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9080F1FCCE7;
	Fri,  4 Apr 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782196; cv=fail; b=k/eO4bRZcYLx0pPnl55+czI6udKLAaMDO2pVCoAB9bonw+MePHrX0SFep5dPlNmADStbYQ/Jvsu6c6I88jp2+D3y8C0Jn7wn8+dp7tP4XWHPhUaryNxC52Dstyej4/av2Y0k+Dy3dEKjuRvhaFdJNXM0QI6G+cFPOC8HrLRT3LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782196; c=relaxed/simple;
	bh=EduIksH94feernF9MB658TYCPKM/lyahTE+KpBkeeic=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T4TRsaagoi4FitgrJgI3mZuwH93bXN7/c3VQJiMdfjwmNYk8vs/hukuNG6x0REZuDdV129gEeNVlcIo8va+bkt71rG9odjmCfUUGsL+BO6CCgTedpFP7ys8jK8lzObOYiOY/6ZRVKJDoy5PcAYrKJUDHOrWZOfHnM9x2DMS/LX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEUCFgEF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743782195; x=1775318195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EduIksH94feernF9MB658TYCPKM/lyahTE+KpBkeeic=;
  b=jEUCFgEFnzpJW/D2A8+JuSss1byycH+Qaf8CVFS7Pt5vTMfizupE4e9Y
   CJikzHDQdDBdL64htRkcfSb1LTKuOcFw+7H1rqH7QfrA3HXynlgJVXTOF
   k8orhZRkNiDVA2Ut8PQt1zNBu0xMI/IwdcPQYwWwrnKBd/bkOQLWpr91k
   o9PQ7N0HCg0OSlQUwEPci6ZXJ/2kLx8Rx3C8IN0BKf25N1pEGK9ai3BQK
   +cz7d7KSDW/CdEaBeq2rqyCLx+KvBM5KNowdZB3jH8ANV/+z68HRJI+Dr
   bN4XiUoq27y/gh3FCZe+1luRX2I+YqIXtxmWJ3RAIsF7tdfXSU8fCIbY8
   g==;
X-CSE-ConnectionGUID: OWuQW8eFQouoOGIydESlpA==
X-CSE-MsgGUID: MRP8UpwjTbyEWSIn2GcOwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="49021553"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="49021553"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 08:55:56 -0700
X-CSE-ConnectionGUID: B4W2HbZ5TEC9BTmQ8afVhg==
X-CSE-MsgGUID: BWc4lq9KQF+nDQOEH+f/aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="164551544"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 08:55:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 4 Apr 2025 08:55:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 4 Apr 2025 08:55:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 08:55:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rleGn/29usm+Ze/bO9Gcio80D+qSXk5urGhYu9y9xBYh/omFUtc1iGMQ6VpxZ08yuSZJS2nIP9EpJo7qPig2t3Z7QoGtZqqVm0XizZtLo/lYsa2+tPwozunAN/FthHNBbyMQ7gSfQc9miE2VpxFy+HaAcbFMzID0z1QaakfNt0bqeVgXbOT7JKIK/kxrJ5oR/qq1o1Q/SHr5nqwgkrOe4csd1n7c9E1lNv+qHwNC4a42YogKBjPywB+6Jec7lxA60A/b9/HI0EB4jdxW2eOQDUDDqjPEZjAKqAr/P3zwHspyGqllg3MMDYqx0DsUFODzAlpB5piGRH/O0hOHxkkcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNuCxgxKPWdc7MZ18Nd0q2EP/aazHV2c8jB3HxxHbeg=;
 b=fsUvoUFDSw3oAkfZV3enYYoOtatYPxHzqrm0rs9fRtGC5JPVwla97qIg8hFXpABVRmhGEfKaEp1DRM+2LL4+NVMF3rgYY6VfJ+JXmyRhnRlnYljirKJVxZ4eW/L0IY/8oW4KOD8spXr36/D0NY+DwLNhsj8yU8H5QNqRgNQR9NJ3Z48S8DJqYacn/WnJ2poTSXSUywVTF0DNRQK9K300kb31ZjdNPZYOmZ7PFBl00ZFexkpMjSd0Cfgh5GK1Fz1yK45yKM3/NgBkj1ct0QEXbpBHNvyF0eUzWjwFF6BebGWR4di9vvqDf56ipc3ctlgBStuGPyPKp6JSZbaEuxUhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by PH0PR11MB4776.namprd11.prod.outlook.com (2603:10b6:510:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 15:55:50 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%7]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 15:55:50 +0000
Message-ID: <3b933890-7ff2-4aaf-aea5-06e5889ca087@intel.com>
Date: Fri, 4 Apr 2025 17:55:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"Simon Horman" <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Mina Almasry" <almasrymina@google.com>, Yonglong Liu
	<liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-2-ad34f069bc18@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250404-page-pool-track-dma-v7-2-ad34f069bc18@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::20) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|PH0PR11MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b3947d-93ca-4b3b-43af-08dd73912ba3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHlUM0lOZzdYaXR3MTNlR2lwMmlpZWVMOFd6ZkNSbGU4aHNPQytMd2Z2RW4r?=
 =?utf-8?B?cmhFWWVmbDUwalh1YXg1ZDhybERzbHFIdFYwUVF1WmlDWVA1eGgxUk8wdTU5?=
 =?utf-8?B?N3NwLzJoV3R1SjlaQmxrQ0tPSkNPTUpTQlFKWi9BbnNmYjdTOEJrUkJPS0dt?=
 =?utf-8?B?aFdEMW1mNmRiTjQvbHFHdXpydE1CekE4SHlaRlp0U0ZWVXcvczEyTEtHM25k?=
 =?utf-8?B?a3hzdHNURFhXem1qR0J2VzU1U1h2QzVpdWpUMDMyTy9tblNrVURtalRJRkNs?=
 =?utf-8?B?c0NFYTFmaTduTXVZa2hlL2tsajhZbmNVeEhxOXFSS3oxSWJoWGgreElxeEZq?=
 =?utf-8?B?TWZMK1dKc3JYdmd6UWE4L2J1U0x2WHBDUENGUElkQkxRQ3pzS2ZSZlBQS2ZO?=
 =?utf-8?B?QmVpalhLZWpkcXExbVZra2RmV3JKTmVFNXNoc0NjVG5jRlJ5S3FpNlFrczFI?=
 =?utf-8?B?dzBDTGNqTkpQM0h2ZFFXQ3RDa21LbXJvSGZlNFYzYlpqS1ZSc3BBellhR3pq?=
 =?utf-8?B?UjQzYWd1SDlNeUl6QlkvTDJPRytnOWhoTjBVak56WmJieUU5SkdJelVERFVk?=
 =?utf-8?B?M0FlWDExcHVjNFRLeTV5dDF3Y0ZVS0NNMnVJcEs1dFZiWDg5dWVscjB0blRx?=
 =?utf-8?B?QkJqeEtnWnpLY2t0b0hzTHRuQjVWU01QMXBpMTdFMFJHOU9uU3dKTEtvSWZp?=
 =?utf-8?B?cFZ3cTFjblAzWTVwRlBGQ0Y0alg5dFFJQldGYXNhNlBJTzloUmU4UVFGZElV?=
 =?utf-8?B?SEFCZkRLYytHdFF0VVVjMnJBN09nUUFZb3B5bE04VFlKSVFHbmp3bWMzTGVs?=
 =?utf-8?B?eXFhS1k1NEIvRVFpOGZXbytTNXJpelBsUGFGT1Axb09WRzBha1BZa1lVOVI3?=
 =?utf-8?B?RkZTYk1aeEZoTnhETENLamhud2dyYjYvamF0bmo5L2g4OE5CNkJSTG5aaWxI?=
 =?utf-8?B?R0xvRks2NjhPcnpJaU5admxXSGZtTmQzdHpaNytmRjJXVCtYa1dwYThBVXhv?=
 =?utf-8?B?M2JoTXNka0hSaWV4Z0xtbVN5RTVCNndGZXExbDVjNThCU3YxZ0k4RjJES0dE?=
 =?utf-8?B?VmFvQ2FSeElmRXBZWkVCa0R3WGVqdUxVQVBnY2RZQStjb3pyNDNNR1g1NTlj?=
 =?utf-8?B?aVFjUzZ4MG5ibk94T2JvbFlNSU1iSys4TzB2VHBLRlJMMzhUdHlRMzdMZTNY?=
 =?utf-8?B?QU5iRXlGSkZGUDk3dkoxTERXY1pZOFprbTBjR3dlYmNrZDhsU1NONExoN0tY?=
 =?utf-8?B?YnBVRFhNTHpZZnlNYmNMNU9SN2ZhUUlzL0VlNnhPRlprVW0rNmp2Y2diYWhV?=
 =?utf-8?B?dnFXYUZEQnFwdWtWcVp2NE9xT082dDJNbEorYUpYT2ZSbG5yN09BblAzL0N5?=
 =?utf-8?B?dXIxT0cwOXI5TWpaeWQyRmJpbkMrUnovQnd1Q2lmbVdUbFR4WFlZNkxnZjVk?=
 =?utf-8?B?VHdIMjVKTWdsTFJEUHJiMFVGMnZnb3gxRS95VzBXNGhvLzcrNUNOSkU1ajV3?=
 =?utf-8?B?L0NjRGF0U0YzaEF3N2swaExLc0VpM2pFemw3UmlHemczZ3hxSXV1Q3ZYVFNh?=
 =?utf-8?B?YThiSlJaTFAyT3lkRGJkbzJXU0VUWHJoWUZZN0xCbHBoWHF3eGdpQkVRT1h6?=
 =?utf-8?B?b2R4MG5BSXNZZGliaGtabEFPL3FJMDJhTU0wcXNValBYeFZOUi8rVjE5VDB0?=
 =?utf-8?B?NVRTT1FzcXlIV2ExbkM2Rnd0Qk5lWmtjSXpNa2JsQzdWbWxpZExoTjNybmll?=
 =?utf-8?B?MUhuZG0yL1pOdVdxc3hteVJxM1U4bWNyNFRuZlJoT0xnd0ZRdEd4aUJVN0x1?=
 =?utf-8?B?N0Q1VlJxMkdYa0oxRXlnN0pmVVQ4WG95b1hyZm8wamZIVzVpVWgwaE1MRUNi?=
 =?utf-8?B?UC9heEgxTzVwN2NaeENjcnkvdWJQMnI2ZlNrOTR2cG1JZGczZzVteFZoQ2ZL?=
 =?utf-8?Q?MX0a6IQ+FH0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhaZnpDWjNQNVM0dWdNbXF1QjNHaURTR2hOc3NVbERaYXFGNFczTks2T1kr?=
 =?utf-8?B?eE1maDBLcFZjYlIyT3JnUjBadXJwZ3hqclQrZEpNMzNxTXRkeWdjUHVsOFdm?=
 =?utf-8?B?aW1YaVFMUTVLQkpKVDhnQVg2QUE0OWJWWTA1SUVaYVkxWm52N211QXNLREh5?=
 =?utf-8?B?ZlRrc085T3ZkbWl4VzFBSnFnUHhWY2hwa2Z4T3VzVk1pZGovblNpSHlmSm5O?=
 =?utf-8?B?NW0wcWdVTjhkV3RSQ0hwcXI3cnQ5ZHhQSkd1ZDlPOTlYQU5LVGs1eEg0STFk?=
 =?utf-8?B?YjgrK0hIR1RWTkxXYkRiNGFVSHRiTHFnKythTVJuR09UU1hCSjk0cEcyZFVi?=
 =?utf-8?B?K1VKMVNhb1BlMExOdVJaUy93QTM5UnNuUzFqZ05VYWlMNi9oUFFaNGZtNDdZ?=
 =?utf-8?B?ODJoNGRpbHJzMmhtL1dLbysySitNRWxzYWM4cjlVYVEyZzNHY3lRazdIWTBq?=
 =?utf-8?B?eXZrSWNiWWk2ckFKSjVWRDBaRVE2UlE2V3RzTHVYWUVxUDlmM21OWGdudTg3?=
 =?utf-8?B?TTgxYzRnYXdwRFFNb0ZyMjVzVC9RTmIrem4yRk1XTW5zMjU4aTJic3RWZmtS?=
 =?utf-8?B?WnB5SEFXd1Z6Z1dmaHRXSDd1LzkzUUdMNUhYVGw0cGNyd3pScXg2Z0hLZzVO?=
 =?utf-8?B?djRLREpXd29yMGJuazlpV25XMU9lQTNwb21wZzJBM2xUOTBlb29yc0RlQ2Ji?=
 =?utf-8?B?RmNscU80blBrYUtycENPWURGTk5jdFFxZVNOSHY0Q2g3cmk1dTBjeC9sZnc2?=
 =?utf-8?B?SDYrWCs0R3I2Y1k2cWRoY3Q1RFlqS1ZoYkFmVEdPRk5jL1dVU05vVXQyNmU1?=
 =?utf-8?B?SlNJa3I0ckFxMXAxU01nV1BSeEVaK1lFS3FuLzFmMmVHV2hmMHplMDYrVGhE?=
 =?utf-8?B?ZXhraUJuY1l6TTUwcVdlWElWaXJYVUlkNEJMYlhOK2pTeGpTRC9SaElqSEx0?=
 =?utf-8?B?MTNsa1lCVVoyckZ6Zk80NDFrTzd4OVEzSDJtSjY5WDN4d0EvU2ZVa2FOZ3JQ?=
 =?utf-8?B?cEFzZE1DQnI0NU1RUlJnbCtzTXJFQTV0eU9FM0Q5d2s1UXNqc21xUndicGY5?=
 =?utf-8?B?MHU5cmd6QmxjZmdKMUZuSHEvQmhmYjcyN2VPdHRVcUJDYVdVOS8yOXZrS3Fa?=
 =?utf-8?B?WS9PZkYxM0lQbkVUMWJSc2hMaGJSdWp4YjBveGJFeGx4bXNpMnVOUllPdWxw?=
 =?utf-8?B?N0NjSTB2M3NlUFJHYndXcjJ3T3VJdFk3NGRkUUE0WmQ2RHUyekFhUzU1RDRj?=
 =?utf-8?B?czQ5bnZhNTEwZVBvd3o3THFjNHZ5L3JsLzR4bHA5WURQd0xwMEFWMWN1Z1Jt?=
 =?utf-8?B?NmlXb210bE1DbWNFV0dHa2xDQmJ2eUZ4N1NpenQ4Q1pxdHpkaUg3aE9uejJH?=
 =?utf-8?B?TUxhSS9TUmZLL0tmR0IwbmRkUWd4L0tQOVpGM01pZmcyNTdOZW56Y3R0NzhX?=
 =?utf-8?B?OExOYmhpS1lRTkZaLzlwUE95dTJWY09lUWtjVStZWXRKNlFmM3NSK2dOYXhw?=
 =?utf-8?B?cTNiWThuMWRiZWdabmF6MHZMbGhKOUx6cy9VNzJPS2FzNXhManBTQUlpVjcz?=
 =?utf-8?B?NVZveHBOR3M4Smt3Rmh1SjQ3MjZpMUl2dXN6Qi9HV1llRWJvNzE0dDd6dG5L?=
 =?utf-8?B?Nyt0aDBIcmdBYnowbXkzaUFQY1lpTFF0UHorTlhzekR1MmhNQTdSSldzaW9H?=
 =?utf-8?B?bm5YS09mNU9aVHduYlRrdWlzNzJKMGt4bDNPNm13NThpQWNvY3NCUTdRTnRZ?=
 =?utf-8?B?U3RMZldQM2RJZEcrUzNMaUhRK3dIRHdlbkFkNEFpcUxNQjB5VnAyb1l0djBk?=
 =?utf-8?B?UXJDUUcvbWNHaDZIeGl0ZTZkNjJtaDJSeDZJcnJkRHFjamZUTjE4SEZQYnFs?=
 =?utf-8?B?Nnpnb0pFNzZJUkVYa0pNaTRZU2pEM0pTd2YrYkN0bFhZRmxLV2pkN1VBMzJS?=
 =?utf-8?B?MEx2RDZCcFc3anF5Ty9mMmV1RElTSVhtc2owaXJoSS8rRkZIN2RNMjltZ2pY?=
 =?utf-8?B?Nng3VkdWbTJnenRxcFlDSUNYVGtYQmpxNGxaME1LR1lNd0ppbEg2U0ZBT3kx?=
 =?utf-8?B?L09VeVlTczU0RmU0cmErY05iVHVGM3hHYWpRTmVwVGtLSi9sOTdINFZWc2pC?=
 =?utf-8?B?eEhyU2FibEszQWhuQ3B0SVRQZGRVSTNvSG9sZUhXSWtucXdHVy9VZ1BkNnZX?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b3947d-93ca-4b3b-43af-08dd73912ba3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 15:55:49.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNarmgjP+cWp495onZ7VRHq1JoYx5uBEpPdxxvfYkwq8yIZZ2YUdZYf1895L7jrrhj5HgacvVCn0iP9xH5e+4AheYkwkJoT/HucSulsWVIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4776
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Fri, 04 Apr 2025 12:18:36 +0200

> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
> they are released from the pool, to avoid the overhead of re-mapping the
> pages every time they are used. This causes resource leaks and/or
> crashes when there are pages still outstanding while the device is torn
> down, because page_pool will attempt an unmap through a non-existent DMA
> device on the subsequent page return.

[...]

> -#define PP_MAGIC_MASK ~0x3UL
> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>  
>  /**
>   * struct page_pool_params - page pool parameters
> @@ -173,10 +212,10 @@ struct page_pool {
>  	int cpuid;
>  	u32 pages_state_hold_cnt;
>  
> -	bool has_init_callback:1;	/* slow::init_callback is set */
> +	bool dma_sync;			/* Perform DMA sync for device */

Yunsheng said this change to a full bool is redundant in the v6 thread
¯\_(ツ)_/¯
I hope you've read it.

>  	bool dma_map:1;			/* Perform DMA mapping */
> -	bool dma_sync:1;		/* Perform DMA sync for device */
>  	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
> +	bool has_init_callback:1;	/* slow::init_callback is set */
>  #ifdef CONFIG_PAGE_POOL_STATS
>  	bool system:1;			/* This is a global percpu pool */
>  #endif

Thanks,
Olek

