Return-Path: <bpf+bounces-74526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B2C5E3AB
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5890638619A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1901632D7CC;
	Fri, 14 Nov 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgddwB4d"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FC329E6E;
	Fri, 14 Nov 2025 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135597; cv=fail; b=K4sN0MXxL5L5dOOGawKZRUhw4OnAgS+o834ZY5VuY88pibPmoAFR4rqzeykltUyhWm0hxgFmSicMV8NdoYZfc55rolnJ41HCehPsSustihpY2KMOOu6KIZ6A+6jlPd7TQVgJb4+QV066iAVz7avagK8PYmKFZL8kKaPhF/HaxFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135597; c=relaxed/simple;
	bh=ypY4Hb+H74sRIDm+gQqybCEg4F1RT60jLcc5KCorc+Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YcemNpje2bBi9wo0cxlSGUAbM1nutEddma6VWEi1leqgNhgf+vSYzCe9rEMHrL91rQnF8fWntHykUdM7m1GtPR7kW/EC6q+kJH6dPhbdE7W0WAss15zq6oA3n3JYcwWoC8Njzdn9sufvFLr5N+Ow9ousd7bM/RZPKitAVUcJVuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgddwB4d; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763135596; x=1794671596;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ypY4Hb+H74sRIDm+gQqybCEg4F1RT60jLcc5KCorc+Y=;
  b=IgddwB4drmSd8eAdoM+ubnOIrMVK5e860P5L+yAJ0S/pTEX2YAoFi2Vv
   nBgZ6y+ebu5MgZm5hBt2nM7LuV//OtwDxBM6VgiTtMOMh+WAF8FPWDkA6
   AfQp4irNz+rztw+j0eMoSIOmQVycH7JGs3eBtK+dTOHjml9fpm6DeP1+5
   AcG2QNKpZCnK13/SoqAOeJVh3ojxhAD0lK9jTbzTr+WvYuO8n2JSy88vw
   73RKGfma0Lb3+MuGIwURPJ3APYeAnEzb7+UgU5FrgshYtkO0kF/mxSr9l
   +18RZC/+7Axdwqe4XEH/RAT9cspENaN6XRq7MzYw/ygm5UhtlBb2mfhO6
   w==;
X-CSE-ConnectionGUID: EiJneawhSVCKEY3yQxDyfQ==
X-CSE-MsgGUID: VbsvKugnT0K1+7K5fwdVVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="75912670"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="75912670"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:53:15 -0800
X-CSE-ConnectionGUID: ZSTte16gSjChH41QhKF/iA==
X-CSE-MsgGUID: x9MxKLV4QaGAfIoQM3fC9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="220448294"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:53:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 07:53:14 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 07:53:14 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 07:53:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNg62bb3Cl4L4vRGfpCXoIGbmu9eZwdfCHXaMyZGOR4I4AAYE4XOX/EU7uQ1uOkWAHjWitjWw9zzoqme4sbfIwdQYVXoqghLWqw22cqvDfbb8t2nAk2JdB6kfhu2IhsM/m4ZskoQvdhqdVxO58aH848SkgPQYJgsFQOUtCXTofMPtocD37gsfPfuj9/RXk5rkJ7YCPJAfHnGxknlaYtXZdwiAHIAg3c8oGzTCugRjk3wwJ39ZcQ/Uwk/6pknn+TJJijYFlSIykuglCzjrSD3zkcEsGVBH6fQE26bse5IeSgvRzN+viWZIUvBgV5sAlMaPxXiZS/mvVr+ubsLta7v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHQpPxywcv6QbqQd8yS2+klE+0iCCB/5EnzS4/5mB8Q=;
 b=qPZ35xe/FawGsqVMiMjgRnluWywFNclyZCE6uT162jPaIQwH7+zWijYiF6QFwjDzi3f/DB3V6JBWM3swTNSWy9iNm64ZArfGA+S8QK93xlzSRqRmflB/FEjWO0kOgwZdQHY9eNdofoSfWvSr1r3HQ7SqtE0422Jldef6zZgWMXwVGoGDO/GMBTcblW3ApmEc/KNOjovHHDdVAaoptZc6hl/HW1Ot/fQlJvdZOAMVJeca7ba8TuudVLJQjmOmmzLmhoKu69gQbtPPrZxmVEXPBBCeO+z7158pMHgPwTsImJW88KQ4L0AkrojRIiaEBh7lLn3oEFAwPu3JmX4hv5GPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 15:53:09 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 15:53:09 +0000
Date: Fri, 14 Nov 2025 16:52:58 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <joe@dama.to>,
	<willemdebruijn.kernel@gmail.com>, <fmancera@suse.de>, <csmate@nop.hu>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
Message-ID: <aRdQWqKs29U7moXq@boxer>
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com>
 <aQTBajODN3Nnskta@boxer>
 <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
 <aQjDjaQzv+Y4U6NL@boxer>
 <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
 <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
X-ClientProxiedBy: DB8P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::37) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a5b0eb-dd6c-493b-82cf-08de2395e8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW5DbU9sQlh6eEhlaFJud2dGVjNuOEZMeU9CYXB2VXQ3OVIxTE5vODVxS0Vv?=
 =?utf-8?B?SnNqVWNseDlwdDJadWZCL1VQRUo2emlqYUFPbWNvdTRGcXY3TkpmbkpvZU1J?=
 =?utf-8?B?cDRkdFJJNmJZQkEzY0IyYmlnUW0yeGFDUk10Vk5oaStxUVFTUTlOdUMyV1Rx?=
 =?utf-8?B?WVE4aXFuSzNycE0zYkNRR0JoUEJ4WG02cWxpRlFKdUFvWkpyU2VYSjFua0tk?=
 =?utf-8?B?cHVOMWJ3dFNHR1VWN3c1UkRwV2c5U1pVYVUyV0twOFpHWkhZRHFCQ1lWSENj?=
 =?utf-8?B?YnNPcWlUeUVRL3pSODJVbld0TXlIRWZxU0hEU0pHZTJhN1JGL3pnaURQeXJJ?=
 =?utf-8?B?YlpmaHV5cHpnL01QK3dLS1IvZktLTkd6bGgyb2lBdjRYN2l2ejExTllOeTBt?=
 =?utf-8?B?b2xrSlM3T3BZc1VMOEk0R29OQWJ4MmNEeHpKbHBXanNwMlZ3MDZxWlF3emR2?=
 =?utf-8?B?UUdjYlgySTVzWGtrSGozdHZ5ZlZUN2VTS1dwaHBBcGdMZ1ZZS0lQSC9yRERt?=
 =?utf-8?B?ZUxteUhEUVMxdzRjTUNDdWErdTNvMS84VGxWbTZYek5RbGZVdWM4WVp5SW0x?=
 =?utf-8?B?NExSVUFYcWJtbEVpMll2NUo5cFRWbE90dUczWUNtK3B6M1JzSTBmY1VsNHdC?=
 =?utf-8?B?N1ViN3RrSEpZWUtDZE1lUXdnV0oyMFVFdG1TOThKeFRYS0JJNEdNVEFsemRD?=
 =?utf-8?B?Mm56Z21mYVE2cGtRWVdMOEZTY2Q3V3VUZkZGdlRlazdIYVRZQmhaVm92b0lz?=
 =?utf-8?B?QlU1OG00TXlPcFAyQ3ZOdjExbHV4VmtBSW0yaXVTNGVKbDJxVHo0Ty8vbCtZ?=
 =?utf-8?B?Y3p5OVVmK0NyazZJa1VvZ1pzZHFpbk1HV1NSMGtURllLQTVXRlozQUY4ZFdC?=
 =?utf-8?B?dExwVWo4UUszbjNPLzR3OUVMVUJIN1lIOUxRaTZYSDc3cDNHNzhTWmlwVCtR?=
 =?utf-8?B?Vkl1WjNCclBzVzh0RTAzbjZ3bDQ4ZzV1UCtvYlR5dnNNb0pRSlV2dUt6eXJS?=
 =?utf-8?B?TVZqK2h0Z0RNKzhpbGt6YVhtdXZYUTlzNDQxZnhGeXRSZ0xSZnpuZVByUUFM?=
 =?utf-8?B?bTVUekk0d1ZraGZwMnV0ejVXc0R0MjZ3cmJheGQvYlBESFozaVp5K2hjMytX?=
 =?utf-8?B?c0h3ZlZicTZINUlvK0xYQ211U05nOVlieEZ1SEQ5T0RoYndKS3dVb2YycUtm?=
 =?utf-8?B?VllUL2ppRTdHM2hMNkh3L3RlaFVQOVkwVkdpMlJmQnZqckJNN0FyNTlxdzEv?=
 =?utf-8?B?SHlNRDRvRm9IWGs0c2FLdEFyOVEybnVBY0dnc0lKZERyRTI5NktnTEdnSnpZ?=
 =?utf-8?B?bnNadFJVZ3RMdEhCbkhheWErQTFKZUtUSlVLVXdLK0w0QVBnUFZCTjhvdjJT?=
 =?utf-8?B?NDcxS1J6cjJIYmlwQUE1ZnRxM3FTSXRiVzArdUtXU05QM2ZKNjlYWFJ4U2py?=
 =?utf-8?B?OFJuZFVLbk5RNjByQUFxbld1NG92cy8rYmFEc2ZuVks3RW5oZ2lpaERqYkEz?=
 =?utf-8?B?N2ZUWklTMWNoV1pDNkFJMHRvVVpmUHZnNndQT05jd09OM3NCbU10MEZWN2hW?=
 =?utf-8?B?RjFLSEFwSFFCVWhDd0QzaFg1UWJFQTNLbCtpSUJIQ1YremdnZVV2SXFIeHdJ?=
 =?utf-8?B?TE5uMEx1YVdVV2NpYWw3Z2ZPZjEyWnp6MjFqUEk2ZzE0NkNUUzlLYm1ObFJK?=
 =?utf-8?B?blFrajdNTXNZdXJhdm5aOXU5b2pCTi9BMFUyM3ZqU1dTUEFVSW5Ld0k4TStW?=
 =?utf-8?B?b3lmamIxbmIzYnN1Qy9WelhxM1lyUjNuWng1ZW0yamYrSiszUTBSMXNNbWs1?=
 =?utf-8?B?b3poMHBDM3NWeXpVdStmekNQVFE3NVlMY1FXbHkwVmdtSVV4OU1EdTBSL0N5?=
 =?utf-8?B?d0RTeHB4WkhhOU9DRjFIUS8rYy8zU1VLZlFocWtzUTlHSDlKOTZtaXlzcEdn?=
 =?utf-8?B?enFYM21laGFLNktkekh2Sk1vcjVUOTBTbTBjd0JCNkNhdkxRTjBUdWRWa2FB?=
 =?utf-8?B?SFJEcVNTczBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1JsMFdIOHR0QnVaYlYrUGpTNVNVMmprTGhGOE9BUC9ZUWFyZEFvaElwTC9s?=
 =?utf-8?B?THRvRGdVaytjdWwwbSthQU5kSHVhYUkxMzJ6UGFlVFFNbDd1V0RINzNnZ3Rx?=
 =?utf-8?B?allJQWpGL1NTTTYra2FySXhKVE5MZWFaWGkvUHlHMWhmUTNpUTZ4ZEJSeUwx?=
 =?utf-8?B?YUMxYzRpU3haSjl6UUwvRDdaR0grVzFac2tLcmtXSSs2aitRNWFuUzI0Tk9T?=
 =?utf-8?B?ZnMyL1JXZUxXZVVrVnYwdlF4QmtLOW5oVmREcTdqWnlwYW9XQTE3QTg1ck03?=
 =?utf-8?B?UHpEOEFoQXF2UUp0TXZVaXdZVE5FY0xrUXRSNkNkdU9va05XaWszL1ZWRDdz?=
 =?utf-8?B?V1NBSWU3OWZ2cWdHUjlldHF6WmFRK3Nxd0VzU1FuMDVPcjVQdFp5WGhLdDVk?=
 =?utf-8?B?UGtpdlZPOTFZQzZ1cXEzOE1YMUJRYkpWUllkVmVUNjdESVFnRkdaWHBBV0Vx?=
 =?utf-8?B?L3dEcll6OERGQ2VneDh0SVVVYmxDbFBLb1R6RmpEM3V3S010VGxmdW5WMWlG?=
 =?utf-8?B?SXprUnlJaWtOUEVDa0owNTdwNTNRTzJGTEtZVHg5QWd2OFFTODNvak5TMi80?=
 =?utf-8?B?enlWTk9ONEJDTEw2b255YmlhZThvaWdaVTVHaWt4TVNRK011OGZGZ2dCaG80?=
 =?utf-8?B?WkJBNmxjYS9pRWNscklsRmZYZ3liWDJrbzVVdzNnc0d4bXZMY25hTEI0UXg1?=
 =?utf-8?B?amI5WDUxSFZReG1KMEZRSFBNMUZQUVdpWlRDZEQ5dWc4TVFvakVTYkhlVndB?=
 =?utf-8?B?SkNoNXZiVjZHRGtIdTZvK0N5blg5VmN2V0h4S0UzWTdXT3FCckR5c0FOMmVE?=
 =?utf-8?B?ZmpobkhyZncwdXZEZTRTWEU0eUFuNjhkUlJOeFFmTEtKQjFvRGNmbUpPUHli?=
 =?utf-8?B?dFBoRjdFLzJxWk96VDIzVWNEMEgrOHV6V0gzY2ZjWWlMTXBVNjEyWEZnc0Z6?=
 =?utf-8?B?VTJPS09PZ1FzR2JFVzlaQStkNGw0ZnRpVSttMmZkL2FUWm5vRE1mQ1doMlhP?=
 =?utf-8?B?UnhvRndFVE5yVEJRaExhMjlPRkVKSk1JMi96cVBTaVVZeTlyWENyTDdjaUFv?=
 =?utf-8?B?R3B5OGM3SitsRWZ2MTdiUTBia2RFVUZHS1NrSHR1OXBXWm90RDZyUVA5cWtJ?=
 =?utf-8?B?QlZkWUFnazhyZ3JSdUdRVWhNMzJRTkwxK09jclp5Q0VRaGhoRGJINitweXYz?=
 =?utf-8?B?RFB3QUNQNDU0eU1BM1JZWU51SFVFblMrdDNwb1VPdzBMM0tLYnZmQTBvc0li?=
 =?utf-8?B?UlRRNkxsTEpHS3loQVU3S0xUVEpaZ010N1ZMcTdWaWVEK1RzKzcwUFpEYWhL?=
 =?utf-8?B?d0loK2ZZQ21oYjdFL1B1Y2F0U0gxMDVsUExKaUV6K1RtMjh5TDVnYW1mRU8w?=
 =?utf-8?B?UzVBc0lqUTRqTHFubXFaNEJWaFFmai95VXFwMFRBUVYvSG5KOFNaYkZLY3E5?=
 =?utf-8?B?ZG1rZ08vZEFRVjJmOXY0STRucFVQSnZUYVpVMTFkc1N3cVhzM2c0RFNlNnBY?=
 =?utf-8?B?S3lLM0cyMmMzNHRQRXp2VC9Uby9aenpUMkZBN29kL1ZlV29XdWlNdXJiUTZ6?=
 =?utf-8?B?Mml5QW9OcHVSMjg0YVVXclBkeUxUMEp1Q3ZXdHFsVHNvYnVIWDVYMW5LaG95?=
 =?utf-8?B?c3l3L2syT3Fxd2NDcGRVcHVnTCtQaU5HRGNYcEJDNXRmWld6U05tQ3gzeElO?=
 =?utf-8?B?akdoNDZWQVJ6WklZN0ZkSlQ5a3Z3UmZJdnlPYkUvM3RNcnRoWmptbkhWOGlr?=
 =?utf-8?B?ZGtQdlIwY1hkRk5NV09HTllxTTFDSHh5L00wekwwb2dhSUltcTRQT1hKY0x1?=
 =?utf-8?B?ZE9BZEk0MUE4eXhTZjk0TVp2dG5kN2JCcUlnU3lWRFZQUnAzQ1BUWEdYZE1N?=
 =?utf-8?B?emJSUUJRMmh3OGNMZ0RJU3BtZnhmQzRNQkh1R1VCVTVDRllSb3dLZk5Dc0w0?=
 =?utf-8?B?RXFab2RuZGh1bGsvV2Flcm83NnZYVmhSS3BkLy84dENTZ3VGU242M09EV29W?=
 =?utf-8?B?amNsdWkyWGtQVmpNRGl2Y1hZeVZxWmtKM3ZJQUR1MTRVQXlNZm5EZ0pBQ1pa?=
 =?utf-8?B?MjFmRzFnSGkvU01xaE80bmoxSDI1cEI1WGZKMkl5c25GZW80RnJKSkM4Z1ZC?=
 =?utf-8?B?UEIxV1BmOGYzQThYNUVsdWEzV3BDeXJkTkViYUxKMUJnb3prb1p0N3N2MEEw?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a5b0eb-dd6c-493b-82cf-08de2395e8ab
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 15:53:09.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfb4noajm2se+tslG9UfUkyrr176wv6OQJq7mwXrh6xFqQ6LPl3rjEF+Txq09kZVv7RIWKd8VmFaBtcqLWFtkVIdo436YHpGqXa2BziZRxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com

On Tue, Nov 11, 2025 at 10:02:58PM +0800, Jason Xing wrote:
> Hi Magnus,
> 
> On Tue, Nov 11, 2025 at 9:44 PM Magnus Karlsson
> <magnus.karlsson@gmail.com> wrote:
> >
> > On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > Hi Maciej,
> > >
> > > On Mon, Nov 3, 2025 at 11:00 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > > > > On Fri, Oct 31, 2025 at 10:02 PM Maciej Fijalkowski
> > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > > > > > > production"), there is one issue[1] which causes the wrong publish
> > > > > > > of descriptors in race condidtion. The above commit fixes the issue
> > > > > > > but adds more memory operations in the xmit hot path and interrupt
> > > > > > > context, which can cause side effect in performance.
> > > > > > >
> > > > > > > This patch tries to propose a new solution to fix the problem
> > > > > > > without manipulating the allocation and deallocation of memory. One
> > > > > > > of the key points is that I borrowed the idea from the above commit
> > > > > > > that postpones updating the ring->descs in xsk_destruct_skb()
> > > > > > > instead of in __xsk_generic_xmit().
> > > > > > >
> > > > > > > The core logics are as show below:
> > > > > > > 1. allocate a new local queue. Only its cached_prod member is used.
> > > > > > > 2. write the descriptors into the local queue in the xmit path. And
> > > > > > >    record the cached_prod as @start_addr that reflects the
> > > > > > >    start position of this queue so that later the skb can easily
> > > > > > >    find where its addrs are written in the destruction phase.
> > > > > > > 3. initialize the upper 24 bits of destructor_arg to store @start_addr
> > > > > > >    in xsk_skb_init_misc().
> > > > > > > 4. Initialize the lower 8 bits of destructor_arg to store how many
> > > > > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > > > > 5. write the desc addr(s) from the @start_addr from the cached cq
> > > > > > >    one by one into the real cq in xsk_destruct_skb(). In turn sync
> > > > > > >    the global state of the cq.
> > > > > > >
> > > > > > > The format of destructor_arg is designed as:
> > > > > > >  ------------------------ --------
> > > > > > > |       start_addr       |  num   |
> > > > > > >  ------------------------ --------
> > > > > > > Using upper 24 bits is enough to keep the temporary descriptors. And
> > > > > > > it's also enough to use lower 8 bits to show the number of descriptors
> > > > > > > that one skb owns.
> > > > > > >
> > > > > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@partner.samsung.com/
> > > > > > >
> > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > ---
> > > > > > > I posted the series as an RFC because I'd like to hear more opinions on
> > > > > > > the current rought approach so that the fix[2] can be avoided and
> > > > > > > mitigate the impact of performance. This patch might have bugs because
> > > > > > > I decided to spend more time on it after we come to an agreement. Please
> > > > > > > review the overall concepts. Thanks!
> > > > > > >
> > > > > > > Maciej, could you share with me the way you tested jumbo frame? I used
> > > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes the
> > > > > > > nic more than 90%, which means I cannot see the performance impact.
> > > > >
> > > > > Could you provide the command you used? Thanks :)
> > > > >
> > > > > > >
> > > > > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse.de/
> > > > > > > ---
> > > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--------
> > > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > > > >
> > > > > > (...)
> > > > > >
> > > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> > > > > > >
> > > > > > >       pool->fq = xs->fq_tmp;
> > > > > > >       pool->cq = xs->cq_tmp;
> > > > > > > +     pool->cached_cq = xs->cached_cq;
> > > > > >
> > > > > > Jason,
> > > > > >
> > > > > > pool can be shared between multiple sockets that bind to same <netdev,qid>
> > > > > > tuple. I believe here you're opening up for the very same issue Eryk
> > > > > > initially reported.
> > > > >
> > > > > Actually it shouldn't happen because the cached_cq is more of the
> > > > > temporary array that helps the skb store its start position. The
> > > > > cached_prod of cached_cq can only be increased, not decreased. In the
> > > > > skb destruction phase, only those skbs that go to the end of life need
> > > > > to sync its desc from cached_cq to cq. For some skbs that are released
> > > > > before the tx completion, we don't need to clear its record in
> > > > > cached_cq at all and cq remains untouched.
> > > > >
> > > > > To put it in a simple way, the patch you proposed uses kmem_cached*
> > > > > helpers to store the addr and write the addr into cq at the end of
> > > > > lifecycle while the current patch uses a pre-allocated memory to
> > > > > store. So it avoids the allocation and deallocation.
> > > > >
> > > > > Unless I'm missing something important. If so, I'm still convinced
> > > > > this temporary queue can solve the problem since essentially it's a
> > > > > better substitute for kmem cache to retain high performance.

Back after health issues!

Jason, I am still not convinced about this solution.

In shared pool setups, the temp cq will also be shared, which means that
two parallel processes can produce addresses onto temp cq and therefore
expose address to a socket that it does not belong to. In order to make
this work you would have to know upfront the descriptor count of given
frame and reserve this during processing the first descriptor.

socket 0			socket 1
prod addr 0xAA
prod addr 0xBB
				prod addr 0xDD
prod addr 0xCC
				prod addr 0xEE

socket 0 calls skb destructor with num desc == 3, placing 0xDD onto cq
which has not been sent yet, therefore potentially corrupting it.

For now, I think we should move forward with Fernando's fix as there have
been multiple reports already regarding broken state of xsk copy mode.

> > > >
> > > > I need a bit more time on this, probably I'll respond tomorrow.
> > >
> > > I'd like to know if you have any further comments on this? And should
> > > I continue to post as an official series?
> >
> > Hi Jason,
> >
> > Maciej has been out-of-office for a couple of days. He should
> > hopefully be back later this week, so please wait for his comments.
> 
> Thanks for letting me know. I will wait :)
> 
> Thanks,
> Jason

