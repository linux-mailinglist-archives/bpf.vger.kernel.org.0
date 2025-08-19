Return-Path: <bpf+bounces-66039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F24B2CE3B
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A186587DB1
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E739343202;
	Tue, 19 Aug 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zj3uYbga"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5858E25F998;
	Tue, 19 Aug 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636318; cv=fail; b=EUwB+2QvXxsrDeAiOshhrD+7+qe5VsClIM/lrECONbOsGHFEKv8LBkh7teK6dsceCwD984uQUrsvNXEJjMCpsNRCRg9j9G9voqK91Ed9vC8DmfS4i89UTnvlifIQmJjJlfpD/HxXkjTZRczKkS7y2fplCEgfTRS/so8dL2azbHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636318; c=relaxed/simple;
	bh=SURCSeUZncdex+vVnNBk2DQ9eGbyaz9A1Es8RAPpVYA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ur/aw/gUxS0/8HmIQ4A/b6cKWM4MbiCuDhM3oYfpOugoAB1kVuxkLd45UM2Rp45jppSk9gK3uh+om485nL6Cm2BmWtEEP3YSq0aOR7LoosL+UQmIOd4qkjJEHjB0SaA+xf1oOyyD2eZ6cKU9y+HF67zJzRzk6aoPFQkfftQABYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zj3uYbga; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755636317; x=1787172317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SURCSeUZncdex+vVnNBk2DQ9eGbyaz9A1Es8RAPpVYA=;
  b=Zj3uYbgapqaGjL90pPlchtf0xfTj9O7HWcSWMdiwoqaIF/FW55nyfkfs
   W7awTYM28+CL6ysfhuFznJhm6AyBC+USuSiv5qwjTldiMnclhH12ZWp7s
   qtU99bdSR3yX8/Y7BbLUNs/xgyl1MeomLNBP6j9VVb4hRaEI64bh8JSIF
   272uDESaeYTtyxwq1ltwf2tq0TGrR3prGlXFoZYlHBGFSlR1q3RWpF65B
   yaKx2/SbYsfczQND29y2GBwV0q/ZT+5YO/mJLbKyjUmFuQYnOfNjGhbcx
   QsrxIqb2xMFxRfIgC4b8WUxo4ckwPocCmzcQaoqSdGQXo4boFd5pE81/f
   A==;
X-CSE-ConnectionGUID: UCciu6+fQAKJjdek5Y9m2Q==
X-CSE-MsgGUID: NoeSbOS/ST2pD5OB26AVdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="45469548"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="45469548"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:45:13 -0700
X-CSE-ConnectionGUID: UpIbGlUYRJGEflJpKOEr1A==
X-CSE-MsgGUID: tn3R6spxRUKIWoI+qJ160g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168199495"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:45:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 13:45:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 13:45:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 13:45:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZH51lZXMNFbpTqRlziH08uYpRnFR+r0mmV8phE+HYrRobq96uX5v7kR5yoZ6g3TqHKHV1KFwkw7syFH/KGGsv1x0YcrE4JDcS7o6K8UXaqRUOmkIwug4arsTMe5QHfoLEczvbPJyvGTf6Fo8NyREWPuhAvZGqMTFa9Ika4+tS+UkCJnqy+ND/qI5h1RFHnxP8Tf2Y+ldaAej87JLkyJtMrwEp3LQaYmGFgh0krgVxxLCL6SvO+iRueG8lUMtRjwb0ezAzszrgAOWYjgHG54dVgk2IUSr6UywLM8UdUj9GiveiSlkSPBSvl8N1at4fHHUyaFAPI8SFyNnISMBFslwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Icqg6kPH0T0koanW2w9x98Gm94hqs/q79Io/+VEaeUY=;
 b=KjoIAg+VK/05dMH5qbWwpaDsT1Cn4yAiT06TQazxneb4xOt8F0IkVyquuHfrHZRkI/KVlA+ZLE/v5a49nf1UztKDR1YMb7ylkCeIY5mrf5MBcmmetfXVk5BUn60RNaxfupb+PCfparlN7DNpchPGFWfE2+J7j2K15pLX3PtIubRcHFvy/5LOIF08UgrdjN2Ap4eCrKJZHPc7V0K2hr2bnKVmNBJWnQzOJ9ydnv3RIdcIOTEKOYJVY0doD4vkP9YHQT+ULejiHcE6jU/s7g+IbXm8ogYPbvMRL9Wg67xxB9CT99eaO0SXoXmuuknqqR3uoQxkqbmeMva8eWlGMe+znA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SJ0PR11MB5071.namprd11.prod.outlook.com (2603:10b6:a03:2d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 20:45:03 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9009.013; Tue, 19 Aug 2025
 20:45:03 +0000
Message-ID: <60c21410-2622-4533-a186-f704fadede2c@intel.com>
Date: Tue, 19 Aug 2025 13:44:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] ice: fix Rx page leak on multi-buffer frames
To: Jacob Keller <jacob.e.keller@intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, <ast@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <maciej.fijalkowski@intel.com>, <magnus.karlsson@intel.com>,
	<andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <bpf@vger.kernel.org>, <horms@kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<jaroslav.pulchart@gooddata.com>, <jdamato@fastly.com>,
	<christoph.petrausch@deepl.com>, Rinitha S <sx.rinitha@intel.com>, "Priya
 Singh" <priyax.singh@intel.com>, Eelco Chaudron <echaudro@redhat.com>,
	<edumazet@google.com>
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
 <20250815204205.1407768-4-anthony.l.nguyen@intel.com>
 <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>
 <dd8703a5-7597-493c-a5c7-73eac7ed67d5@intel.com>
 <6e2cbea1-8c70-4bfa-9ce4-1d07b545a705@kernel.org>
 <9f9331ac-2ae0-4a92-b57b-d63bac858379@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <9f9331ac-2ae0-4a92-b57b-d63bac858379@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SJ0PR11MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: ec54f1b4-1a7c-489e-ba9c-08dddf6145c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHdNcXA2QVp1aVJCZG9mL1hMN3hHZ3QzV0tDTkE2N3A5YThNMDZuNS92WjNz?=
 =?utf-8?B?ZWxnT2ZZS05JK0RlVnk1Uy9CTEVqYktNcnVqUFZLVUJOTE5mWWtNVmZMZlFn?=
 =?utf-8?B?TWtyTVNaRXBvd3BFZEtEZUt0YmNvQ252U1dGUEhqTzREd0lYUzY1RmxSRHEr?=
 =?utf-8?B?aXNPRkU0YWdqK2o3Vml1bTVlM2FuMFlyM1RVcktQRVVwS2JzYW9iZnJmdFk3?=
 =?utf-8?B?bUl4dmZLUElOTENoTGlVREJGZFJ4R1VPbURaZ2lxL21OZVR4dUZGR0ozaVFo?=
 =?utf-8?B?Njlha3l2T1N6Q29YVTVBdU9GUDl2YU9QMk9hQUdYOUsrc0hnZ0JxMms4RDZB?=
 =?utf-8?B?UUUwZWR1RjUxc1BhQ3VXdHNSZEhtbXBZbTBUbGowNndaWW1vRWt6eGJZWU43?=
 =?utf-8?B?OGpUUWg3cHJuZ3VIS29ISmJtZ0E5TzY0Mk14c1pIRnUxUWFSNWtwKzRIUHYr?=
 =?utf-8?B?TkVNS0JieXdGUWRoTEtJeTdSWnJpZjhaMWVXelhrZ0NBTitoVVc5S1ZpaXRL?=
 =?utf-8?B?RDNhM2RNelBjSElXdGxGOEUzZzZXR01ZN24xOTZDUG5DeXArZWVsUkw5dzha?=
 =?utf-8?B?VHdMSm91YVlhRkZrb1hheGR1aGt3dE9XcE5uUGFZSFEyOTRRYk5FcXA4UE5M?=
 =?utf-8?B?b1FuMi9Bb2NhUUZlajd0TUZGcVZ6K0RnV29oa3VNa1MzUVkxR21QZVJyOENK?=
 =?utf-8?B?R0xJT0xaaWVWcTNES0h3SXVURkZBYUlUWXl0dHdHelRqenF6L01XY2xkRk4v?=
 =?utf-8?B?R0RDbGZBT0tBS0YvUnB1K290WGFtd2NoVEQ3d0JyZzBvelNoVXFTY01uc3Jq?=
 =?utf-8?B?VFYyWHJYTUpFTGRuWlByN254ejNJR2dYVld6RlFHUlBvWVFDL0RtdzA5Yjhv?=
 =?utf-8?B?NEdwOW8zYXkzdW1MbHNCQWFabUtvcEpkeUQ1RVFWOGU0V0FjTGc1TUlpWVlJ?=
 =?utf-8?B?QlZ5VE5PRTRiSVMxelFjUHdSenNiMVBVbDc2UnRsUkhYUTR1VVlqd3NrZFJN?=
 =?utf-8?B?YVRHVGd3Y3FGMVFkU1BsRENTcjVOeHZNZXRjM294cmtnSnh0MitRY1NFcUhi?=
 =?utf-8?B?T0xXLzFGb1o5ek9CbmpsM2FFN3dWelVqcUEwanNHelJXNzc0Wkp2RXdEVWtR?=
 =?utf-8?B?S1Axbk9xbmdpcFNDTTRVaWxXdUFjenp3VTE2RVAzdE84OG9OSjJPSHcvempz?=
 =?utf-8?B?K0J1eHZSQ3E5QXZCdk1CUzJ6R1RVRExNdTE1NTZ2Q1AwN1U5NUhYTVlQVldk?=
 =?utf-8?B?REpERHNTcEU3Q2tPY3JMK09qc0JGdHBFSUFiWTQ2WVJldkFBQ0VFWVRoT3pB?=
 =?utf-8?B?WUpSQjhXekh6aFZhME1hV2lLODJ6ZDFUVlJhVkdhWXNQRnpUMFJseHlFL25w?=
 =?utf-8?B?akVIUFpDMFlYV2oxODdVMkJ0eWNVZDRyUnZiZ1NWcFVvcnJXU0MzZXhpNStT?=
 =?utf-8?B?bkRaNSthOUthc1BHRzg0WlZUK200dlFLM2lWKzQ0NGdCdHFMYnJHblFpSlhq?=
 =?utf-8?B?QmNhVVk1Q25STXYwb3pJUXcvSXN5cC9ITzBZRG9qZmZQaWZLcXFBUjduajBh?=
 =?utf-8?B?TVZDcVJuWmwxM2I4S3pMMU1UZ0d5ZFkvbGNsOUpVRG9RNllKZHppZnpob3M3?=
 =?utf-8?B?UlVkY290OG5ZcU8vTHlXeU5xdkdoQWx6THBmRHo5NFhFcXRjT2hDUWg2SmJI?=
 =?utf-8?B?MDRmYVoxUE1QZEY1eVoxeFRlWFEwU0RTbFdGMm9DT2Z2OFZ4N3ZsL2ViWXZz?=
 =?utf-8?B?NXhsS3E0V3hETXFubVZpd1RaOXJ5M3JVM1FmT0RCQWRBcVZod1NsSExQc1RI?=
 =?utf-8?B?dGtxT1pxS3ord01QK2lhSWRBZ1lOSXFBRXU4Y2Nnai80cmpuOUdpdnRldTlq?=
 =?utf-8?B?VzluRlpIQmo0aVRRK293V1FuSzgydm83dGlOVXcwSDhidE5JdTlTVlBkeEN6?=
 =?utf-8?Q?EXZTkQ322TI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ukx0Rmc4RXZPaDNsZ1M3MDcrVzl3aXVPWGNxNnBxY3RuYXkxUlo4VFlqMUdm?=
 =?utf-8?B?SWxsQi9JMVZQN3Z2bWNSeEZHRUVTSm5iZ0pjbG1SVUVESEErWEZld1E3TVQ1?=
 =?utf-8?B?cEdzbWhFOWVCL1kwazJ3bFQxREV0WnpDdWFOVWdSaE9lakM3NUtpVlMxQjcy?=
 =?utf-8?B?a2V1cFo0d0phN1FuYytwZk1adlpHdGg1bmxKb1NBaE52eVFaSWw0V09hU0xD?=
 =?utf-8?B?L2VIMWxmbEcxZmtGNUJIRlRTY0luMlBia2R5YlpVR1VrL01nMk9TamFaaVFp?=
 =?utf-8?B?a05TVERqbGNuTk53bzBCaE83bFdKV01YVGp3bkcvZXJhSFJlOFE3WnJCQzZm?=
 =?utf-8?B?Ky9kVlNlb3FXZTdvZlBSWWkvRTFhQlNBcEgwdXNuMGczMkJ0Wk1hdFhTUnM3?=
 =?utf-8?B?NDNRQmZaSkJKc2dINU9vcFNPcTA5TVpUbzh0WmsraGd0cDA1bGJxN09sVnBi?=
 =?utf-8?B?cW5CSUszTlM3TVRqcEloRkN1YyttVjlVOXVEZkZtVzc2ZWYveVFGRFQwV2ls?=
 =?utf-8?B?eGNVNC9VZDFjbG9pQlRwUnU1SGhpY2o1b0FTbUpzTVA5SXV2MW5DTDV4Vjhk?=
 =?utf-8?B?R1NSYk5KY2MwMGFBd21VOURoby9vTFdNTmYyd2RSQ1NlMFdCbjJCeCtic0hX?=
 =?utf-8?B?SFlxSUJ4cG9tUzk5OEJGZ3JKOE5henN6R2RRSGkzajI5YjhBSG1WalV1RXVk?=
 =?utf-8?B?MWN3R25FWDZRSks4T2hMQld1Q2RiTGR3QVFVMnZ4b2hWYkI5RlVhcnErZmsz?=
 =?utf-8?B?N096dWU4QlhLbXd4U29UR0Y4YmpXbnBQZmkrU0hMelU2S2tZbWp6eXVoTEln?=
 =?utf-8?B?c2loemtXN1hEQUVQMXdZUEJKVXZkSFRuclcvRXlYYlZmVkJ4ZGloa0dnQk02?=
 =?utf-8?B?dVJLMi9XZFk3SzViOEpteU90QTl4d1ByQnFZYlpXdjVrb0pWUWVVa3phajc1?=
 =?utf-8?B?em9Cd200b1ByZ2p4M1N6MDY1U09GSTNxMmNOaXZHVUM0WDdHRWhsd1paL2tw?=
 =?utf-8?B?aE54NEt2UTkyNC81RysvR3ZJVlNaT2t2djFEZkZMNUJRYkE0QWJ4R3NpNDk3?=
 =?utf-8?B?Wi85dzhHaEFzRFo5eWEweHA3SGdndzZhcTVxQmoxbWl3T2RHck5LNjhaYjNa?=
 =?utf-8?B?OUhRQnpPVHVVdC9HYWxaTC96eVlYRGlvNTcxSHVFTTd0SVlVMW9ZNllka3Yw?=
 =?utf-8?B?bnVMK3I1eTQwNlN5RE52WDdlWTZ0elRuazlhb1NGbWhMYzVvMnRNV05QVkVi?=
 =?utf-8?B?NEorSndROWhHdVpGTVhSZ080L2RiVzM5Y0VjWTBnNEZYWnR6NXh2NldHakhi?=
 =?utf-8?B?UUlOWkl0dGpIL0RYbmpyeVlIRjY2b3RNcW5VY0RBeCtoYWE3MldsM1VkSkxZ?=
 =?utf-8?B?RFRqM0ErMlZIUlFPM0FrOXcraXBuTlVTZVgyZFVQcGxYYm1KQVF5dGxGbHNX?=
 =?utf-8?B?cDNGTUhKK2JkOUl2V3hrQlB1U1g0MlM3R2R2K0ZidjBIZGl1UFdDU0xNeDlo?=
 =?utf-8?B?NkV4amxDOUVXeGtQUGEzOG12MVJrYWZsUVJqMFhyUVlsVk1CSGtRb0doMkpk?=
 =?utf-8?B?cUVTb1QwWXl1eTlUUHF3RWtTd1JqVFoyUjU4OTlrYUhsOC9PKzAvR25Yb3Qx?=
 =?utf-8?B?UUpxUHgrNjJxNlVzME9JVllrZ2tNSENSS1FTRnkzVUIyTUppNkZybTFhSXpo?=
 =?utf-8?B?M1VFaVJSMzRzRDEyYWdGR2NVM2o5VUFDZm9xVWFWM1RuZjJka1lRT0xTL3hC?=
 =?utf-8?B?aVdUcjVBOWxiNitWbTZmbmNjZ1dnT3JoSWdTQTdBbGtpdGgrY2tlWWhnWlZ0?=
 =?utf-8?B?SjlFZWZjWWplSG1GRGZpdENSbUJiK3ozZGNzWXZjS2ZFdUhPUVBrL0Z5bkNo?=
 =?utf-8?B?TTBERDBDZHoxQlppZWVkaDZYSWt2ZkoxcWRwUnJDMGdTN3V5T2o4WG1MV2Rm?=
 =?utf-8?B?NHJ2Um55bWRnVHJEWU5WN09sQ1BBaGFEUTRHc1RHYkh1aUpZaHB3dW1lOWhm?=
 =?utf-8?B?Ui9OQzNad0F4L053cGp3MVhGK3R4V29tc3VZWWFJYjdoZXBiUVNDN0Nqd1o1?=
 =?utf-8?B?UjNES0lXV3F6Y1p2NER5ekhwVExxLzRYaFZ0T0EwOEM4OUMwVjBvRTY5SFpO?=
 =?utf-8?B?YXcxQVBTTnB2VTRBYk03blIyMlBKSEpEZm4yWEJnSXMrUGVPbHhUaTBMdS93?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec54f1b4-1a7c-489e-ba9c-08dddf6145c5
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:45:03.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gLP39ktsGFNjYIYCQ92QvXJ6/c7afkim5ojA/uk6n/lG+fd/ry2F8kSXD8GChXyAX9ocil8lmsc9gifX6THce6WGnC2Y6QPIBsZlitaNms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5071
X-OriginatorOrg: intel.com



On 8/19/2025 12:53 PM, Jacob Keller wrote:
> On 8/19/2025 9:44 AM, Jesper Dangaard Brouer wrote:

...

> 
> @Jakub, @Tony, I guess we'll have to drop this patch from the series,
> and I'll work on a v2 to avoid this regression.

Ok. I'll re-send the rest of the series with this dropped.

Thanks,
Tony

>> pw-bot: cr

I don't think the bot picked this up so...

pw-bot: changes-requested

>>
>> --Jesper
>>
> 


