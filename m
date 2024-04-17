Return-Path: <bpf+bounces-27034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD18A814E
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CE31F223A4
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868C13C818;
	Wed, 17 Apr 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vn99foIo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D913C681;
	Wed, 17 Apr 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351088; cv=fail; b=KOT7MTKpJEXi6thLHg33RBFFaRAsbv1rdcyh4sfF8iiMPWklyz++hzOG9E4HigyXWmEsiZBLQGrKdyp/Mfkz3CwjLyzCbikgIGFVk5b23lSzOEO8VBmP2ol2zZhc0iQQ7EPJ0yzr3MZGTwRZVK+4XuKplqa4l+ue+teGwUGZEvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351088; c=relaxed/simple;
	bh=Ia7MXYsd1uJPiWmFQWjfpzBjxLTOCLJNWjZznaC21b8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QjWdNSyx9CZVk377DUuQlNr5DmXF0ep4XGx4x/Oo0RmHiwLYFc8hv3s7JJ1+UAERx57PcETRYQBcVmpiFL9aL1mroLsUKs7hz2MMUizXUVJTxTiBGpVhEc0H6A7M6FWXw0nf6D9tOKMEa0GCQKZrhkCZi2S3KUVorAWsVr1CO+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vn99foIo; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351087; x=1744887087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ia7MXYsd1uJPiWmFQWjfpzBjxLTOCLJNWjZznaC21b8=;
  b=Vn99foIoSxRAgwxbnFk6fG8uBcPFuSWQMlaDflfanUr3+QbzkM7xtz7v
   mWYX7U7TD3Feh/5/Hnnsj79WsriHMqrUdY+555nxntia7JrzN7QOibVhk
   uEz7pWFckC8T/gsaAuTGnh2DtnTUnA3ngntx5H6ZuPR5XUMNJppDM81RO
   3JcMZL2dneEewWSUgSpMpKMqsroO0oOP9mOc63RbkUiAf7O7hpSZ51yJ8
   z2NYFBfw2aSuNIRsEaw8LcZGj/4uba61W6hf4q4DLqwg19JgS3PY/PBgy
   l2K6hLbrMMJwF/13vMvD97H7v3itEBHbEmLi90896v+95IaDUGFYHz3B6
   w==;
X-CSE-ConnectionGUID: JrFG8Ha3R2CcTQRgalJljQ==
X-CSE-MsgGUID: 9uwuRqJRR8yEH78r/hq+UA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8694287"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8694287"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:51:25 -0700
X-CSE-ConnectionGUID: M0LVTSGWTEWE5XXjZyjAHQ==
X-CSE-MsgGUID: VxzZ9oDCTgSei2/jnLTddw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27020681"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 03:51:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 03:51:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 03:51:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 03:51:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 03:51:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I++ztPF+XUUCBKTaSbSgye4S8De1WVJ4ZRyJ9bBCYooAUEJ7SX/wkvw94U197qwkLo1GbFq2OmUfQHiTNWM7dsNM5GzoYya7IkIuWLJ+zpIgvtQhf973WGrncMLqFu/JP37jQBiybzOJmawSyFv0YeS5U7nt1l9jfK3aM9YcSZGyNC2Icgcyk2bHp7lbADIlgsgGTj0qzzC3CVw5SvB7zekS2CxLAqLBe1uQvuqNvY4mWKB7v0VTZh30MN/u+5FyGOfNcxgSpAJGMUsG+eKcr2/zasonETB1D6I2wDaxWGOTp/B3Iungm/IHSw7LF3WjQ93LvXDVcDmfv79G8OJqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9Mvm2yerUHplXHw/kjYOLBj8wSB3MUEFmc2wqRvQe4=;
 b=FZh7TCis0A9xLtEZjP4A8lovFiyxD0YTKDAbjur00pgOr+XxxOOKo5MCV2NxOJgDQ7DWaU4gw4P7O3TC+SIWnwlXFNx9Yy7P6JCRbY+6zrisPZ1PspmP0ut6ocxmFLYG6eCpiiSE+mj9jfmdULf9LplGJ9Vp29itW8fv1hP4yE2gVz4f7Vg1H/IHo3SyYzFJ1fYc3zjEGopqWJKJgU/qa8BsGXDfe3XtS7P+QHkhowuH9oV9Wibrau3ig0Qm5DDBy0tWJt+10EsvQg9WrZgTDnI/9U6cEjGeJ5l1Zb6qrHvofTK6VhMKoUOaYglJeZS2+BtUFmMLUspnTIRZBqdz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8597.namprd11.prod.outlook.com (2603:10b6:510:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Wed, 17 Apr
 2024 10:51:21 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 10:51:20 +0000
Message-ID: <ebe80c29-4884-488d-ab83-c020f9c3bc81@intel.com>
Date: Wed, 17 Apr 2024 12:51:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/10] net: create a dummy net_device
 allocator
To: Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<elder@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <nbd@nbd.name>,
	<sean.wang@mediatek.com>, <Mark-MC.Lee@mediatek.com>, <lorenzo@kernel.org>,
	<taras.chornyi@plvision.eu>, <ath11k@lists.infradead.org>,
	<ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	<geomatsi@gmail.com>, <kvalo@kernel.org>, <quic_jjohnson@quicinc.com>,
	<leon@kernel.org>, <dennis.dalessandro@cornelisnetworks.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <idosch@idosch.org>, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
References: <20240411135952.1096696-1-leitao@debian.org>
 <20240411135952.1096696-4-leitao@debian.org>
 <20240412191626.2e9bfb4a@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240412191626.2e9bfb4a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 8801ad41-d2e4-43f9-afbc-08dc5ecc511f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcuzjObDAXDrImcdlT+8QKXlXk01t1h3lTXugVAwl4O6bbbg368r04Rz4rAfwuHMAsIKIeu73OxNo5iTU8dO22f9rmgacqAOGPHhbJ0wC1JqyL5niMeNy9ONu+vs0K9gt+tnbBBKUi7ko8P4N+LZH0TeJaGixuHiuNSKReRk/5iLZBK8AjI+uqvO9OBJfT2aUyXUr7dSb7q5Lafd+o/mmc6JQZwls7Sy79QKvnyy+jH1/O5WWBNaorYdCwaDE5nr01eEhW5B71pXiQfh5Ct7rzqrpFCqjiZGl2wOPyOvwll1RdSpArjHSLMiQcvLhcXGtSWrc1bTw0EWE436oPaDMpUaUoJ7rQUZ7V7v7Fh0lcf6ZQ0cl37/Ylh7hNDY40yRNPEdle8So2tkxT5fviWCWaa16WL51zFlOlz+kFW/2+uBbNTLIzh9cB0C8x7N2P4eYT9sOzpR4qskbhhU83V0UBVpzdnRoyQjKpX8IRNX4Vw3Sq/K2vabLdJQ9zQsuj7oaK1bpdr2lE9fUEu4HCdh1dWFKZUY1PVDUeXzon9rmq6I0qCKpMDiw+czD8Hw9lq/XuEEupd4s7H6ZDH1haLEDwGHxRXenFNm6Ug76QcnQwV4bZ0HvmT9uH49K+qtipCWBKUHCzN9wKfLXm7Q8nctiA9Vk7x253XxEeEnTpBo48o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ditEbXNvOHNxbVJ6ellkY3E3UGVRNlN0T29JZ3BQaExBYjlMVFErTnRrSHRi?=
 =?utf-8?B?SHM0Y3JBR2dwODNyeCtYZnBHcVVtN0J6STlYWUhuV2VVRVVPNkhoYmMzamx3?=
 =?utf-8?B?eENDSHUzQTF1cUtTbFNFNlMwQ0VyZXhXaG1YTG1oTFpReTJUcjIrdXo4L1JQ?=
 =?utf-8?B?L2c0bXlmdDJnd2dQQjFsNzMyUDVLTjVjd3E5d3ByTHF2aTRNSHI0NnlBMHRE?=
 =?utf-8?B?TEF6cHZLZjlHTmJKTHY5V3o4T1Foc0FMTFBuQ3JrbzZNR2hIUmJYa0Nqc1I5?=
 =?utf-8?B?VndTblBWUEM1T0RibElqdnJKSU1LRHRUSmxqWVVoQ0FBMHpNOFBTSzh2SVB4?=
 =?utf-8?B?V3QzanB3SDdud2R5bll1eFRlaEhTMkZKYlNTMlp3V3VIUVhKMkN0OGFHTmpL?=
 =?utf-8?B?ci90dGhxRjgwUUg4UHRtR0xKMzFteDV4c1IwTFJIc0s5dGFORGh2OHpUd1Vs?=
 =?utf-8?B?WldaKzZjdGUvME5jby9KZStMN0ZMdVBTS3lJWU1WNjd5US9uUk9GZlVOeGta?=
 =?utf-8?B?VGtTaFpWdlN5SlIrSXFKV0dKbkRyc3ducE9oYXhzYkhFa0ZSdHdwMUxOK2xp?=
 =?utf-8?B?YzBLaG03MkZlb0xQSHRlMnl3YWNwWE9RZGt4aURiSk1URkVIQUhnd2QrK0hB?=
 =?utf-8?B?OG9kYWlMWExYMzM1bVFZVitIeE1mK1VZeHZNdWRZNEZPSENBYXlpZVRpTE5P?=
 =?utf-8?B?VGNHSkl6cEhrcW1aaTR2YkdwVVhFdDBDQ05Fd3Z3blhpd2d2VVNjZzUxNHNz?=
 =?utf-8?B?dmdWSFNGWDR0dWc2cWpWQ2k4Rm1VVEM1SXpld25kM0l4c0w5bkFyOGdOWGgz?=
 =?utf-8?B?ajN5d2tNWjAzbnVrUVVHRHA1dTRoZmUzdE1ENmlvVXQ4bkFqNDc4YUYwMGRE?=
 =?utf-8?B?SW9EMnhJbnVvZ0JuTHlSZzNWTm1TMUZ2eDYzQUdvMDZramhtNXNOa2YrTWVp?=
 =?utf-8?B?bTNOcGxZWjB0REI5TStoczcvNzIvNWJIVXJqMkNTOTZlM3VwSTNmWWlKckEz?=
 =?utf-8?B?cjQzUkJRSU9XK0tnZzFwUDlhM3g1bENxMzV1ZWNGT3JXVWU3T0hDSlpUQlda?=
 =?utf-8?B?SkJsUndRdVZmSktPdlkxM2x3cGVGbE52ZVRReFdNS0lKTFJtRy9aQjg1SHpp?=
 =?utf-8?B?YTZOb29YUU5GUnRnODlqTUJwNHdFbkcxWGszdFYyRi9LMzBFWUo4Qnl2TUp4?=
 =?utf-8?B?cGx2YTUrbmlqVUdaQkYvNXVpekFVaE5sMWs5ZzBrWTlJenVqeGVxSUplOWtD?=
 =?utf-8?B?K2dMR1h5L0xCWWltWUFtanVYQXJMcEQyeFVtaFRlMGpiQ3BlOGtjU3lLcm41?=
 =?utf-8?B?ZHdHQ2sxd21FNFgzeXpLc0JBU3NSclBZMjhBL1FWYWtoZlVWdXVKY3AvN3Js?=
 =?utf-8?B?QUViUkpRQWwrY1JVQjZOMCtoQnFZelhMM1BFS0dlODZYcGJUcVh3Z3QrUWRi?=
 =?utf-8?B?ZTVjc0NINmtIUWQzbk41RkFKdWNDS0dvSjlTVlZVcUIzQjkwWHNHK3lqMi9F?=
 =?utf-8?B?RUE3NU00K05XRmNlSklNY0UyZXBCbjZ5UTkyeGxseEN3U2Qxa1NTYjBIQzZR?=
 =?utf-8?B?djF6eUw1MkRBdW4wL3Z1RGRkMUk0V0dLMk93ZHZOWTNwNUwrcUtLMHZ1NzdP?=
 =?utf-8?B?bG1EN1IwUWZkVlFhYjBvZ2tEaGZkNE11LzNjMEVYRVdEa2ZSc09KeTZjWmVo?=
 =?utf-8?B?RDM0RGdlTXZYQWNzemhGOTY5OHUrOFhPemFBbWZGL09OaDl2NUlvSGVRL1pQ?=
 =?utf-8?B?T0NIU1M0NUVTczJnWWhMdEFuemhGZUFzTmtRSERvd28zV1pIMFJPQlYwUGcv?=
 =?utf-8?B?MjU5R1p5b3BXUUlWaWMwS0h2dmcvK01SS0lLU0c0TXR1Nkd3TmN4Rm5ld0xI?=
 =?utf-8?B?bEN2Z3hCVkluenhjTHBjaHlmN0U2b1MyaGpmNnlKY01RWUkwVHVFejZQVVZn?=
 =?utf-8?B?SU5vRzJScnVENnZrdm5ZR2tISFFLdlEycVZoeXl5QmlTR1FLcFhLZ3hoeGpt?=
 =?utf-8?B?N1pVajd0QXAzb1orL3RKUXNZbkFBNmtCWkI1VUt0d2gza3FpMzl6eWdsbGtX?=
 =?utf-8?B?REM4T2k1Z1QrOHc3N3pWM2pPdXUxektyZms3cmExVzhaeXNsYVNKeUVwajJm?=
 =?utf-8?B?NTQvRzl6dTA4VGRBSnRMMWtOWDAwUGlrVUF3UUwwdmRxM1A0dlgxN1VFL0x6?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8801ad41-d2e4-43f9-afbc-08dc5ecc511f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 10:51:20.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Espmzm32iVn2wmUVDEHZMgtFOxyusDNyneO/o7USCOAWF5qsOftquwlxz4JALuQaIXZxtLRyDLVey0IDqQQG0j00tiL4l1rnBZEVA0EVS7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8597
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 12 Apr 2024 19:16:26 -0700

> On Thu, 11 Apr 2024 06:59:27 -0700 Breno Leitao wrote:
>> +/**
>> + * alloc_netdev_dummy - Allocate and initialize a dummy net device.
>> + * @sizeof_priv: size of private data to allocate space for
>> + */
>> +struct net_device *alloc_netdev_dummy(int sizeof_priv)
> 
> Sorry, one more round :)
> 
> We started using -Wall for kdoc (./scripts/kernel-doc -Wall $files)
> recently and it now complains about missing return values...

Just FYI: kdoc accepts only this pattern:

 * @last_param: blah
 *
 * Return: blah

NOT

 * Returns: blah

neither

 * Returns blah

Only "Return: blah" with a blank newline between it and the last
argument (or extended description).

Thanks,
Olek

