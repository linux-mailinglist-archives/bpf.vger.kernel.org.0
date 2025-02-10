Return-Path: <bpf+bounces-50995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F3A2F1D8
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B75164C5B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19C823E236;
	Mon, 10 Feb 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcMMyruw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5923CF09;
	Mon, 10 Feb 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201772; cv=fail; b=DzFUwO/yKE/upsAtbrJHTtoG+NokbEt5Fz/h0s8rMqmrJRBvyHbP9Q6gcxZ2L6WNw8rAzJ1uwIklBYjHAYqQKufmQZmHec48jxsywpnft1K7xf0XzF1Acdfi9sGvz3hj74QsY+fJbCW+oCqROKSqG3HS9C9MhVI8HOQpQ8Swq0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201772; c=relaxed/simple;
	bh=C8yqmqTFj548NgIsBaSSj5O+QVmZ9FSx5VkY/9P5Rnk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i1sEGyKf0vUYUu++YbwB0sAMOGMIB8EJ2hgTl2bILF5kAaq03RQmKMeG/qooxopvVZkwzfyIMPgeArIZwgj/u2ZAQELJwqHcxkvZpR9/zJEcylpbDf08W5oJBRRteRiRa25Vk9YIGV2cYXYJjeLULcFi76KfXyf83XxAY/HPTDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcMMyruw; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739201768; x=1770737768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C8yqmqTFj548NgIsBaSSj5O+QVmZ9FSx5VkY/9P5Rnk=;
  b=hcMMyruwJiuOW7xYUDGRxb8HkT+YQDEQIgQ0Ap92nHCEllHxXeVb22l5
   xQCQUzid9PynvItWdWO2kOkBmvXEnoue5rfb77SePjm50H3BCj48Adz/W
   w46A2kTLtzikOLc/0+EcazwQdqmGr4sAissFrd177Pa4DYP+ViOuSW4lM
   Km9kpMEQLd2HTPY6vnmeOmR4petvc5P8WmxkBzt4WR7tdI9SK9CIIxKu6
   Zs+uR4qCh+CviIu4aqbLcLfSaFTd9QbnWw21T4CNbh9fKi468f63iluQp
   L4KlVKklDco1MtuhTUWl1Cgz7qm2wMdo/UHxLE/9FXEVu3Q5f+GX3YNmu
   w==;
X-CSE-ConnectionGUID: jnhnVvUjRoScXc/VPSwicQ==
X-CSE-MsgGUID: QD4oPB1kSC+vbsnnVJ4uEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57326734"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="57326734"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 07:36:07 -0800
X-CSE-ConnectionGUID: wTELZpEbTquEjbcCOCWqUQ==
X-CSE-MsgGUID: kz/r+5GeQ3WelBfixUzGCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149412148"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 07:36:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 07:36:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 07:36:05 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 07:36:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWrHzbQfx+WcaEEBHU14gP0jTRxbRschMRaiOxb3CJ0JcdT1qkuWYrftcR8BtP57rMCnif/YpzJjNpQ2473JtDcu75Bi/FF0UYHtVTPRi+m/qSh3pX3p/hXKlwxn4tw0EvsjxWeaTD2TB06QcfX6BVt/UMXxdTpj7ERrqlQpswDzD37tpkwsclij+WUr5V45jKFB8uEN8CQliQeJF9pQYg38p/6pqMNnmZ7bLk3kGF0Mqu1eMhYb0GGdwalAlW9reNkg1z0A+tjbm7K8SZ5S3X+gRUU81t0zdsFlcKrdhaNDtpipZjqLZGB+lryGQqsxiPRNO6KB/KvmSGkD7KsCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+WzLjleQqpKL5Gs1BMmV+sZ4hGc1cDjQWJcYClEApE=;
 b=YuU+ENkqpa6vbJIWD6wrWUlU1ZCNXbSLZDI1co/6YpYcXY4M5l49/d+1dnObOLKxcSHXEkd8wBxsT6m76LCJEa8CzkGbsnPATAX0VoBhhJRN0JKP76O1VRQeHC1EC142G5ZQXlKPlXgl6TbIYDE3/ejx8VQuaJBe42rekhlcIHHGIj6Axxp49SDW2r5D5+eipghj38nWsxJMj6sDTvGek63OcZ3yGfVTMweqNIqKWlCztcbwJGumZ+oVLnHxbJVhiGFxG1ph4TeisxnsQTScoSxZYuTAQJkVU+SopSLbmq27VflJbftnTv5z190/Cgm8xPmmvIrX49MCat9+rjTTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6210.namprd11.prod.outlook.com (2603:10b6:930:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 15:35:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 15:35:46 +0000
Message-ID: <7003bc18-bbff-4edd-9db5-dd1c17a88cc0@intel.com>
Date: Mon, 10 Feb 2025 16:31:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
To: Eric Dumazet <edumazet@google.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
	<dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
 <79d05c4b-bcfb-4dd3-84d9-b44e64eb4e66@intel.com>
 <CANn89iLpDW5GK5WJcKezFY17hENaC2EeUW7BkkbJZuzJc5r5bw@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iLpDW5GK5WJcKezFY17hENaC2EeUW7BkkbJZuzJc5r5bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0206.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db4f4c2-f85d-46e4-4139-08dd49e89662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2Y0aXl0d3FGeHBHSjJ5SUdNQUNnNmNuaTY5ZVZDV3RVcHVCYnJYSm5rakIy?=
 =?utf-8?B?dnIxN2ZyaEpYWWVVV3N6eVBrL2NKV2JZVE9iUk5lOHFmVy85RXRnREpNQzJs?=
 =?utf-8?B?cW1YYWlYVTNxR1ROTUxMWVBXeVFtMysrOWVNaTZnMnBBeVBDZTYzWDUxUERN?=
 =?utf-8?B?aFZrZkI1ejJkY25UWjJFVk9NQzJsODBVMFBoTVFyQWMwRzhLVGU1RnUyUnBU?=
 =?utf-8?B?cFVFYUxvRTFiUi9uSFVHblo4a2JQMCtXdTFJcWVmeHNoSnBuaWFvS1IrMHo5?=
 =?utf-8?B?a1pnOXNoc1ZBa2xvSlU0NjFrZW9seFNpMjAraWN4NkxqQUttZVlERytyeU1x?=
 =?utf-8?B?ekF0ZHY2dU5tV0JKUjExWE5zcGIxWTIyemxuZkpqWVdHSHRxSkhKUURURSsz?=
 =?utf-8?B?UVQ1N3o2V1lsT1JyS1pvcTBjU1Zod3k0cDQ5SDVaakpLSWhvZ2FYdHlCUW1R?=
 =?utf-8?B?akgvaENIVzBHbG9SZGxJQnZuYXpiSlFlcEtBMTZoVUxBSXc0TVZqblU0TXBM?=
 =?utf-8?B?L01qUmk5MHo1Y2dyTW5ld3N4UW5XbUpQZUUzYTZYV2R0a1R1clRIYVJYMkdR?=
 =?utf-8?B?eFNvZlc5T08zL3FRVDRUK2lFeVVpNXhvUFc4dW9FSUl2T0tnTk04NTNnVXRh?=
 =?utf-8?B?eWVJVklJdWgzbEZUNkVEMFU1dEtSV1F5cTBVYzM5T3pNWFA3YzZRcHBUazR1?=
 =?utf-8?B?RkZDMXhMZW5nTEdjOWpWTG5KejFhMXliZkdtK3JoSnlQa3ZmSXhVcmpIVTZk?=
 =?utf-8?B?MTl4N2hWd0NGMUpGQXNCNlQxOFdTTUp0a0dVTjlCNEg2NlhxQjZPUTluaVFI?=
 =?utf-8?B?OUphRVBYTnIvUTA5TUo4N0hlenV1LysvcW4xWUxnM01MRENNN1hVOEsvL3RJ?=
 =?utf-8?B?YmdkVHhSY0loV3VsK0ovYnV5dXVIOWtzY1Vka2VHZHEzanA3bFViR1VqTVJi?=
 =?utf-8?B?UGpaeThhWU1ZTlRoMkQrLzV5NWZRNFgwakpwaFJLbE1jKzkzRjM0WjNRdUVl?=
 =?utf-8?B?YXpib0NlRjRXMVk2VzR6aElmaDMwS09DaGpWa3Nrd1RPN09QdkFUZWNqaFlx?=
 =?utf-8?B?SUo1dksxV1FwKzFCY0VZT205MExVbWYxTHREKzJmT01tQ09WTDliRGxYWGFT?=
 =?utf-8?B?c2xXakZJVU5VSkUvY1FKT0RXR1p2Yk5CcGxLZWJBLzk4TDJ6akE3cENaRVJl?=
 =?utf-8?B?b0toZXRPMzdNSVd0bHNxMnFEZE1TS3BHMzV3RTQxc1V1SC92TEdRSHAxakVl?=
 =?utf-8?B?RHNQM2JSU1pSRHM3cTZ5LzYwWVNvaWFNTmhFMjcrdkFpZldQSnJkRi8wTlcv?=
 =?utf-8?B?dVVhMXNuMkJUY3R3TG10dG40Y1NBeGxMaVVPNDdYU3lRTmpYR3htaFNBcm53?=
 =?utf-8?B?UlpoWkZFVVh6VjM1SitZRGtJU1VGY1RoS3VoNG1telJmaUNxczB6VEl5V3hE?=
 =?utf-8?B?YU9SQUFIMXpKUGRORU9vc0VUN2M5dVFrdm5IZm0wTDdWRS9ueCtscGJ5L0kv?=
 =?utf-8?B?Tm1TQlpSREhuN0dCR2JVR21oa1p4cXhhMjhYOE9TMmJFVm5TcWJzUGdTUUFY?=
 =?utf-8?B?VlVJK3huR05jemhFcHpUYkhsMUR3WlMvaFdlaEZmUnVSc3ZtU1grUWQ0eUY1?=
 =?utf-8?B?R3lkc0h2T2g0TU1BWlhOaGlZY081OHZUSHowZmpWMmlEWGRoKzh2eWM0MHF2?=
 =?utf-8?B?VkN6b0ZiYkxHc0ZocHl6blFpekJ6cWlGdzJhWitDU0MrVVMwK3g3L29JeFo5?=
 =?utf-8?B?WlVhcjVzajRxb2dZcWhaWk9yckE1Sm9OTjczcEY2eWRsVCtXVWdZSWJkcUxY?=
 =?utf-8?B?T3hGMmE2Z1pPdmM0WEFlaVlIODdoWjhOWGgxbHFoUkdUd3hPS2tqdVZqVmxM?=
 =?utf-8?Q?qjbhzN6Qf5BJi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFaWjQ3emVlbGdyNWV6OUloU3UrRTFkbFIrbkxkOTFpWjZsY29Gd3RLYjZa?=
 =?utf-8?B?Sm04dmxULzZZOWk5SS9JUEpic2RkUXpOZWlsQ3FxVm9FTDdCczU4Qlg4VVpB?=
 =?utf-8?B?am52a3l6eHJIT0JSNWNxNXJiNy9UU3pYZ0VxUlJnZzJiU3JnRisxZmxzMFVS?=
 =?utf-8?B?dTcxaisrQlFPQ3VEak94ZGlZdUp0a0tHS0RPU01FcGFIUWQzYndsVUxKcFUx?=
 =?utf-8?B?Ty9ma2xwYnc1b3BJZ21QdXR5aktWenpRbDhwYUtOL3N3UCtIQVozamliNEVL?=
 =?utf-8?B?STY3dDNoNy9vbVJJS09oMnNPYTZPbmYrUVZKbm5ZelhkZjlNSEwycGYrMXBT?=
 =?utf-8?B?dWVuT2pOcmYxR0xyYlY5Y2xlajZ1VmVKL1B1eVNISEIxTjVmYUVzTEU1dDBS?=
 =?utf-8?B?L1V2bzBqMFZsUmF5UHA5ZEZ5cXROcGhFNVRjVXNiVGpsOXZXMlk1M2kxMzRS?=
 =?utf-8?B?eVo5MVR1M3NMU1ZsQnpBVkhiTjBNME5tYVFDVXJ5L0lHNHd2V0VqZU5oUVF4?=
 =?utf-8?B?SVg0VGF1SWplQjhtdWRFdmdGZ2g3ODBjeGM4NTBveTBEbTBoNnhwcnlnZDlk?=
 =?utf-8?B?UXI1V0NqajVTMGpBZ2pCL1NVbHU5V1pTWnY5V2wwZWsxS3FwTHRLQmRnUnRh?=
 =?utf-8?B?T3BKdS8wVlpsZGJhN3h3QzBQUkhEQUdDblhLSjBGMm9FcFBtaldTZlMrZ2dD?=
 =?utf-8?B?YWlWY1dRTkZJVXpna1prenhRWXQveGFYTTgxdUZzcmtQa1ZXNW9HT3lOdE9P?=
 =?utf-8?B?YURBZWMySmZXdEgwdXlnRUNOZC9rRHpFUE1EMEs3b0xYa2dKZTdBejB1QWVD?=
 =?utf-8?B?cXlzd21YZTZWWTVDdlRhbjZ4Rkw0RmtzbFhEaUIrSmFya0FYZklER1BHVTJM?=
 =?utf-8?B?ZG1jVnFsbjl2NnR3UTZ1VEt1bVQveG5WVWN4SVE5UFpENmMrZ1djNUxmVjNX?=
 =?utf-8?B?TW0yZ1M4OU5QSjkwVmhYRHVFT0F4Z0JwSERGSzd1cTVEL01oYy9wTERSdDFt?=
 =?utf-8?B?ODZXTTdySGsvSG5pS09jN3VrR0lyRUFEOFJPOHhaUE95eTB0a1BUa3ZiaG5h?=
 =?utf-8?B?a3FqcWVlS2xZRmthczUrS0V4YkwxZlNQRWNxRnN0WEtObUZIeGI5Z21KZ2o3?=
 =?utf-8?B?K29lQXNaVE1xTXJKVXY5d1hTakpCVnMrMGRWamZnalhtRi9LeW1mY0xaZkly?=
 =?utf-8?B?Sm5XaThkVzBzQU1Wbk5NOWNDN01RdHc5TkxDRGVsK3d6V0JsRmN2ZjJQWHls?=
 =?utf-8?B?MkxLaGhna3FSeTI2UXBQdDAwY1F1ek1PY1RhdjdGbzVFYXR5ZUN1eXZyUW80?=
 =?utf-8?B?bzBsNXE0QW8xZTI1bkhpYytQcGJ5WFNZRFlzZHZqQ05QRkRtSkRCUjlxMlNC?=
 =?utf-8?B?aEVJOTI1YnRhWldVRzBaNExPL1Q0REd5VnZPUkQzbFgzRzdXa0lVbUFsS2tP?=
 =?utf-8?B?bXh4cm1Uano2WHMxTndLYWRuYlZESDBjTi9TYkxlN3NYRVhtU0Y2NDN2MWdY?=
 =?utf-8?B?c0NPM2tOK0lTVHR1SFpudnZBRm5LajRFVzJ3aFpQbkp0ZzlrSVViMUdxditN?=
 =?utf-8?B?cTVzSm9VTENSQVpFeGRpYjdEUUt3VlI1YTRPdHg0TFJYbFk2OGxRRGt5VnJk?=
 =?utf-8?B?NkdNajVySzFvL0V3WHlCRkphUitNalVqN1d6NzJmTkpBbTV1Z2xXMFRuaXJw?=
 =?utf-8?B?cGNQeUh0eHZUcEQ3VFo3OWdRejJvZkROKzhjMXc3SGRaNHF5dkxENDBScm13?=
 =?utf-8?B?NW8rdVY2bllQOGFBWW1nN1E0b1UraUFSb3lKbnp4ekZjSjVoTmxNNlBEMjB0?=
 =?utf-8?B?UERxWVN5cVlIci9zOThiejUrYlBJWCsxVWhwaUsvRnJFMlhUK2Nsb0FmS01U?=
 =?utf-8?B?RHpOdkdYTjU0ZFVIOUdqK00vVWEreHlYazJ2dGNLelBWbzMxMVRNTHNWY1ZU?=
 =?utf-8?B?L1gvWDNzSGJnTUg3YldKSmZIeE9Tak8zak05V09sSkNkdGpUM1JFTjVWL2tW?=
 =?utf-8?B?TlNwbTZkcitkTEpzakpyeXZCbUF0V21aam1MUk1XTG5GWWN3VFF5VjYraWRX?=
 =?utf-8?B?bU16K0FWTDFZbUZuaDhQUmRhZWtUZGlOdzVDcUFvZ0h2cGgvTmE2TkNwTW1F?=
 =?utf-8?B?YVQzL2o3SDhjWU9DK21HZ3llUzRZV1dpMmlXMnpqU1R6N1FWSm83RnplMmlr?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db4f4c2-f85d-46e4-4139-08dd49e89662
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:35:46.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh16Opm4BrIeBRDH+DMfGlSlo2zqQneZ6+wfdqywA2OPpb3alNsXKUl8JvUPGuVxotbN90jIB2FuCum4cPsVL8HgBtY2bAZvMey3qafqSGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6210
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 16:31:22 +0100

> On Mon, Feb 10, 2025 at 3:10 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Wed, 5 Feb 2025 17:36:01 +0100
>>
>>> Several months ago, I had been looking through my old XDP hints tree[0]
>>> to check whether some patches not directly related to hints can be sent
>>> standalone. Roughly at the same time, Daniel appeared and asked[1] about
>>> GRO for cpumap from that tree.
>>
>> I see "Changes requested" on Patchwork. Which ones?
>>
>> 1/8 regarding gro_node? Nobody proposed a solution which would be as
>> efficient, but avoid using struct_group(), I don't see such as well.
>> I explain in the commitmsgs and cover letter everything. Jakub gave me
>> Acked-by on struct_group() in the v3 thread.
> 
> One of the points of your nice series is to dissociate GRO from NAPI,
> so defining gro_node inside napi_struct is not appealing.
> 
> I suggested not putting napi_id in the new structure.
> 
> If you need to cache a copy in it for "performance/whatever reason",
> you can cache napi_id, because napi->napi_id is only set once
> in __napi_hash_add_with_id()
> 
> gro->napi_id_cache = napi->napi_id;

This was rejected by Kuba in v2.
He didn't like to have napi_id two times within napi_struct (one inside
gro_node, one outside).

Thanks,
Olek

