Return-Path: <bpf+bounces-55460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7FA80D08
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122751731C6
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899A1BC099;
	Tue,  8 Apr 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJDRpReE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10541ADC94;
	Tue,  8 Apr 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120326; cv=fail; b=GNzKKLSzz4Jpja3WU58/Uwc7PTAx850QxLpr1V8fzUsC+as0v+IqHHJLvn1okPRtY/ruWAcwyfIqMxl80tZJJrIfbWxRNtk3v7jp9CYnxLhCr2dXQECRgOL8WoOSJExrN+X6vyM8mSKOt/7jtal0Ouaddf08BkmJ8JOZ+mr3dKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120326; c=relaxed/simple;
	bh=AsrS0BRnnEvYF1nGZgMWLMuuA6HwsI23m2VG/olt9Zg=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gpbq6V3mP/GZ8CXbQc+zbGaMTyPOtF3Tt96d+4m5zd647KEd1+aTehjW0jitMSSunC0q7Pzmr3Z8CxRaVX742ynQ9fIGfczFE7gzqiVTm1QHi7Hm9Kx5xYVRUR5j1gxBrxjvEeMM9X45+RCuB9A5hj91BiVOOzixaB2S5/7NhK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJDRpReE; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744120325; x=1775656325;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AsrS0BRnnEvYF1nGZgMWLMuuA6HwsI23m2VG/olt9Zg=;
  b=IJDRpReEfNHT1+lGSKrFJuGVc5O+/iUeWRm8bf/ve9+V3rBDzjktV73/
   AyyhqTIyfxIE5h8hq6Z2OyMJcX1ql5mSoln7zj6nYn/MPzWtPl55vdZtU
   wl+dc00Yn0OQo4uKwqFuzyVSZhAazLHY9mgqb8BiFAVo8IEvNzeZ9bdZE
   ON858HpwmTnaEfqNpsDplyGTotdrpZ6M8nt9UUwtIeGY2PjdRM1OmdyNb
   hld31F086+EUzjFsOGCwCqtH5WB/+2bY0i8FAvRaX9FHo+CgJMrdZ7wOo
   q/s2t2+V/5mSFQm1UEiF0LxzJMgJMoAXhCHaH66xFopDDld162U8oaceW
   Q==;
X-CSE-ConnectionGUID: jwegVSN5QCW7qFdXxwREJg==
X-CSE-MsgGUID: hZ61kKHpQu2v3uiQh0rdSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56534280"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="56534280"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:52:00 -0700
X-CSE-ConnectionGUID: EjIDq/UORIeirKdSHrp19g==
X-CSE-MsgGUID: jLXXz12OTSu6SLkowi/M8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133428269"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 06:51:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 06:51:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 06:51:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 06:51:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPEupXZRzUbk/jS/CDaK+5FpHM0zdKMkCHzTIAPKDnTlHI36X2zToei6O7WW9PBNerkSQ7F750shJDEEL0dGo6rnuQL3v284AUphD6pM1KYi46FJ36G0tLrDTTVXavdwAosep3jRXl0VlpC81vzt+NOEtBeDNUOm+O5uitq1uEcjsLGniLQ/ZNXR27SzuAh02nUpa0jUj1vVbGukwT/JXkwLcxTYW9GB+h5gjpPSh6ZcjPEGRB8IM4ffFEdXmhtJvf8dw35doVwczDyQHjSO5QRdxzgPN5FjfapYxaT2NI/arq2G6tZdeCoc5p1UWV3jnSv9s5/9Y9e/1AwMEkBwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF8lkR5n1YnhSO3y8xrXg/A4c8zNPlBb5t0JxZH1bvA=;
 b=jt6SaroxgdsdGqUUMaEVhtDgPd5qQ0hP3bK121jPsLIXQ35QRWb0irC27gYqvuFjY56VBR3Iu+aA4PRWIEJwXcwa2mbJCpr2gx2rFBHcqgzsXRHHTk+ibQKvH+jFKupvK7wbT1KM6lrSxG4UdC7fXPjsyJLydTPnFbEQETREsRF6EpFBC5f7CQ409qlhXEtu8G2nBImuhojOB6qJcZV2cKjJk3LNBSuZQ2VRwvLwBZ7BYyTCRfFoNWWC9Fr1NC++j1gbH3RO8Fe9xnqWY4HEYAC/wjI4WrO01h+Tiv++ANI+D/mxck9dKAYjdEp5Qc1saMJhLAG7CocwihL4HlwSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 13:51:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 13:51:54 +0000
Message-ID: <69d55e46-74a1-4e74-afcd-f724810b40c3@intel.com>
Date: Tue, 8 Apr 2025 15:51:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/16] libeth: add a couple of XDP helpers
 (libeth_xdp)
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-4-aleksander.lobakin@intel.com>
 <Z9BDMrydhXrNlhVV@boxer> <cba0216c-c87a-421d-bc4d-bc199165edbd@intel.com>
Content-Language: en-US
In-Reply-To: <cba0216c-c87a-421d-bc4d-bc199165edbd@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: eb90002f-20e3-4e73-247f-08dd76a485a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmhnYmx4SVg3NzhDZlJCYkVsQXJISE1kWDdkNCtiTytVVk10MWl3VFVQb3Rh?=
 =?utf-8?B?MG5Fa0N4OUx0bkJjU2pJYXR2blEzYTI0cWlJR2ZSMnhXWUpFRjdveWFvcktx?=
 =?utf-8?B?TCtZc3pPTkg5ZjZQalViWEhHUkxCa3hEd1lPOWFYTWtZWHlnZTJLclgrS2xm?=
 =?utf-8?B?UFE2SGUxY1ZPU3RDMWFhQUNIVitmaHM5bjVyektoelJwQ21JMWVlSnZoQ1hX?=
 =?utf-8?B?THV0cGZBbzhvSDdiTjNMSkxjdFR6L3I3Mk1NVC8zUy9vNHVGdHhxRkdscy8x?=
 =?utf-8?B?Ylk1Q0xmeHVhM2VvUm5lTFJHaTVwYkV6TXMva3BlME5ad3dxUU1pRFM4VzFI?=
 =?utf-8?B?RVRSeWEyZVBJZEZCVWJ3OU4vdUVGUTVPT3pFVCtjMithektHNVZERXFqMVFI?=
 =?utf-8?B?V09VcGRvaEEvQWM4dnpiVlUxbjUxRDY4YVhlc0lNa3drOGJabWwzbkVlaWVr?=
 =?utf-8?B?QThRWnR2b2sxZTNqMUJsdlIyTUpGT0ZoUHphcWhscjBLUTlOZUduTS9ZK056?=
 =?utf-8?B?MjRKWEpsRjhIWkVSemJFUTlmOVFnWU1Ba0tuQUgrTTVzaUVQN0JjRG16bmg5?=
 =?utf-8?B?dkttWFowWk9rK2srdmN1Y1V0c0JHNkNLTVEyazh0eU1HMG1TZ1B6Q2Zlb0FI?=
 =?utf-8?B?VkZ0TlFwZmZocjRRNkNPbkQxeXJoaVVoTm9QSEJVRlAvQ2d6UW9zYjl3N1Nt?=
 =?utf-8?B?S3hzVklEZ05LU3E2bnZOSUlQeHlQbHM0S05TOG1DZm9qcXFTYjJhNmNTZ2dV?=
 =?utf-8?B?VFAxRU1td2VDNWI2MFVZd1dzb21qbkF2WWptSHVqKzB1NTMwM2M2NU1JL1hO?=
 =?utf-8?B?NTZzRDVwaHN6bUhQSDl2UmtkTnUwYkxSYlRIRmR3VWxLN29TZDdydzVVVmc4?=
 =?utf-8?B?dTEvS0ZpMGhmTUY5RHJTcHI3UHlldTUwQ25uc2JiZGNYc2lJZExaTHAvVy9x?=
 =?utf-8?B?NUN2YUZ2L2xkZHBtdXlqdmpudUYwVU1nQ0p6eHNDdU5XMnBhTmlST2RHYXBC?=
 =?utf-8?B?ZmQwWHN3RkpHT1FMRWl0aUkxVDl2MVdwQ0MxWkI1YmdoZ282U3hnN1lsRi81?=
 =?utf-8?B?S1BBWjN6bUQ5NWZtZGZyVE10SHdRYlgwYnhuVFE0dVB0SXM3UFc5ZDdXeVhi?=
 =?utf-8?B?VGFXcmRrMlY5YlBMdkxiNU51citlRjlQV0llZmtLTUtjNHBPWmpSTmpXVmha?=
 =?utf-8?B?bm52YTQ5UzNKQXhpM3hXa1BvT1FwUDVpZVRtalVIMHlMSFV4cExxVVUxdzRB?=
 =?utf-8?B?dHZvaDIrRC84K0Qwd1JrUUgzMjhBRkMvUXVHQWRaSVlOQ0hLMTJVdnplcklE?=
 =?utf-8?B?dkNjaHFTaG9jUVdWa0J6c3l2c21nQTArNlZmaWIweGJWMG00ZTl5dkJwekxo?=
 =?utf-8?B?STFUMFh1Vm8ycklCUXRIZkRLdmQ3OXlsTzF0NlVpV2JUaWx6bVhYbW95Qmc0?=
 =?utf-8?B?NmZQREJzc01vek4zUlpyZ21tL3VrendmRUxscG9BNXF4eEN6RGRqVGNnOVB2?=
 =?utf-8?B?cmJOaWh5SmdMTjNRV0xKeUhka1lGTkpvMktMWXpYSnpOY1ZaQ0xzQmVEMklv?=
 =?utf-8?B?azh4S1ZxQVM1NDUxWDhJQlhxajR5Y1pxTDI4anJoQ3dLeUtaa0d3cDRZM1g4?=
 =?utf-8?B?R0M0OFNKMkFYWWZpQWFyZXgyaC9IcTRCLytBMDY1NVNkNi9HYmdqVFhIYy9a?=
 =?utf-8?B?amxkckRvcTZjd3FvakJoaUhsUy81Y2FQQjNmMTRJSFJCY1E0czlVSlZlMXlw?=
 =?utf-8?B?aGRaajg3ck1jUzB1aGZCOHV2OXJMZ0hOSEgwbWNtdXFHS0NENEJNM3VhTjZ3?=
 =?utf-8?B?SnV4dGFyRjNPSXM1b3gyLytvaExob3FtQmtjNEhPdy9BZXRNSUFGMURNZmtC?=
 =?utf-8?Q?ZQkpyqdF0nfHx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG9sdG9sMGhEWTdqOFBCTVVrbmVYajYrNnNMVndNaTlZWEZjTEtZZ21INDBi?=
 =?utf-8?B?OG56cEtsb0JPNDZKTU8zd1FpdkozUlhOcUVKcEQxYkFZZVR0b1JsditLWU5m?=
 =?utf-8?B?ME5kR01uckRZSFhIUzAzVkk3TDBDejJsanc1QmxhM0dXc25laklkSHVkdU9q?=
 =?utf-8?B?M2o4WktKTDJsK0x5VnBWRU84K3Q3NU11UUhZdjZiYlAvckpaM0dwZGE4d3U0?=
 =?utf-8?B?VHFOM1ZkUTgzT1hhN2Z0djdkYWlwTEFjOGFMZWh2Ti9YUkVkMkNWOFBzQTY4?=
 =?utf-8?B?bGIrQ2RyZEUwRDRkVVlmMElidVdJb1lzZDMxQ2MyUHNHSVpGTFRIbDJDbkUr?=
 =?utf-8?B?YlUzUU5NMWFaaGZESWdzSTBtbkNhQk1PNDBhWkVZaFJrc09IVkNOY2JaZlRw?=
 =?utf-8?B?ckFuZk5lRGxLZmtNRGJvSUJ0V3FuMFNwRkRydDE1cENsUWdwWFRnMGovcVA3?=
 =?utf-8?B?dUtnQWxYR2hDS3BvWlF6bU0yNHBkaElESTBTOEdQdGM2d3MybHZhc09sNjhn?=
 =?utf-8?B?WDJsMUE2YnNkYWEvMzdweVF5T2ViaXRodmxEVWQ3ZnNPS1kwWnF0ZW0xR3Uw?=
 =?utf-8?B?dkI2eFQ3YTZWbXBNeFFlL1loZWhGMWhWYjhVL3N1L2hQRCt4ZlNLL3FXdVVm?=
 =?utf-8?B?bEgwT0hmT2JseFBxWWg4ak1QWWNNdG9Rb2tENFhzbThjUzF3czVwQ2R4RUIz?=
 =?utf-8?B?cG5yOHhEN0J5b1YzME1GR1N3b3pYMDI5NFdKN1g2TUdBd1pMd3Zzbmo0TWFM?=
 =?utf-8?B?dUhYSlJaQjJTVnJzOTMrSkkvVkZyelIwVE1hUXhxcTFrWjFJU3RMVUxnK2Zq?=
 =?utf-8?B?a2owQlFhZStXa2M0VHJ3d1ZkSDVWNmFYRXlZNlplQjdvT0tyYXAvRC94dW1G?=
 =?utf-8?B?YjZ5TkNHYlZNZHlyc09WWUNhcTl5TXd6VldhMjVLRkpZQ2RiY0pCaXdRc2dI?=
 =?utf-8?B?Nysyd2dmdEJZMEVxNHZvL0RpUTA0ZTB5VktVKzhVQ1g4OUExQnZGYmxYTE1h?=
 =?utf-8?B?NnVxSnhINVNxZjNiS2h0NVdUeWUxOS9zRWxMT284Z1hKQmZQSXFzdG51NGUv?=
 =?utf-8?B?cGVDc25lL2pGMVlhNHFaMGh3clNiSUp0NVBGcWZZaEJtelZ1amdvVWJjc1Fn?=
 =?utf-8?B?V0w3Sk1GcCtYejZwNWFZZVNvV0w0QUkvS3BNUTU4NjNoeDlCazBhVThEUmFr?=
 =?utf-8?B?NlVhN1g2V3FxQi9WMVB0ZXNJSGFtRW9JZ0pUNHdVTmlmSURiL1Y1b1VuOGU2?=
 =?utf-8?B?STg0bWpDdXFxR2tjblRDdHcybW8zaU1pYXU5NmczaVVNbllGcmZhYk5Lb3Nv?=
 =?utf-8?B?VHpwTFU5WUZ1S1gzTmhEUUJ6dm5JYVNBbEt3MWtRVi9MNzlIeExkanhmTjNX?=
 =?utf-8?B?d0EwZnU5eFlZWCt4NW5YQ1ArMmxUM3FhYnE5cVVnU2FtcWViTitGRkFrRW9w?=
 =?utf-8?B?N3BHV3lNRWEwS2Q5Sk9pcVhWZC9MUk5KOWdrWnJENEdRZTJxUjVpRHhEc05U?=
 =?utf-8?B?N08vUnhEcEdLK09Ca3RKUlp4cCt3a2o2djVDNTRmM09UclNLa0VxRUdNR2xH?=
 =?utf-8?B?Qk1GZWdKV0p1Vk1jWG50dTBKcVlZKzdqeE82QTdvMklvVVIyak9sUFZiWEsy?=
 =?utf-8?B?UGpQR0J3VmQrR1dlZEVLbGZ5WThnelZiam9FZzY4Y1VkMkcvbUVGdkVUVmVr?=
 =?utf-8?B?Q01XaFNGZVhBZHBRaTM4VkZVVFJ4NUlGU3NzZlQva3RPeUhMeGVQQVFBR0lU?=
 =?utf-8?B?T2FYbFgyUVR5QTE3ODdKQzRLRnNFWXNDTGI5VXBneXJCNFBVdzQ0amo4V1F4?=
 =?utf-8?B?QnBXU01sdDY1V0liclZlS2w3RktRSlNkaytJbm1qelBVOStGV3c5eFhrZXFz?=
 =?utf-8?B?dVQrVlV6WDZ5alp4dDVPbkNGZ1lNbmxxS0srSGl0KzFXWGRYaVNGblNIQU41?=
 =?utf-8?B?Q2ZRTXNkM0pORUJyNmFETU56N2syd0VJcFQxMnpGL2pCenhLeVVXVFFtMWw5?=
 =?utf-8?B?bGFQQmhMeDYzUloyQ005ZHVPT1pNNmxjOEJHV1d4bXk5czdnTmkybys5c0dY?=
 =?utf-8?B?WGdjVFU2ZFZXODJFVHZUQ3p0R0lGSmtaWG8wbFRFOXJleHFoank1SzUyVGpY?=
 =?utf-8?B?Yi92UVJNdHBYRXZFUXFKSlVBMmEzUnNRMmZoTUhpS0hSenNOZGNnWXJ2NWxU?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb90002f-20e3-4e73-247f-08dd76a485a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 13:51:54.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaTNEeXf+yur6u5MxCsOsESD97kBAwJSu5/rbjOS7rXVB59xu1irisgFBB+NYMmmHooJLPtlbZ0laVkoj21dZDZBX/I6uZRctjVoO3XWuRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Tue, 8 Apr 2025 15:22:48 +0200

> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Tue, 11 Mar 2025 15:05:38 +0100
> 
>> On Wed, Mar 05, 2025 at 05:21:19PM +0100, Alexander Lobakin wrote:
>>> "Couple" is a bit humbly... Add the following functionality to libeth:

[...]

>>> +/**
>>> + * libeth_xdp_xmit_do_bulk - implement full .ndo_xdp_xmit() in driver
>>> + * @dev: target &net_device
>>> + * @n: number of frames to send
>>> + * @fr: XDP frames to send
>>> + * @f: flags passed by the stack
>>> + * @xqs: array of XDPSQs driver structs
>>> + * @nqs: number of active XDPSQs, the above array length
>>> + * @fl: driver callback to flush an XDP xmit bulk
>>> + * @fin: driver cabback to finalize the queue
>>> + *
>>> + * If the driver has active XDPSQs, perform common checks and send the frames.
>>> + * Finalize the queue, if requested.
>>> + *
>>> + * Return: number of frames sent or -errno on error.
>>> + */
>>> +#define libeth_xdp_xmit_do_bulk(dev, n, fr, f, xqs, nqs, fl, fin)	      \
>>> +	_libeth_xdp_xmit_do_bulk(dev, n, fr, f, xqs, nqs, fl, fin,	      \
>>> +				 __UNIQUE_ID(bq_), __UNIQUE_ID(ret_),	      \
>>> +				 __UNIQUE_ID(nqs_))
>>
>> why __UNIQUE_ID() is needed?
> 
> As above, variable shadowing.
> 
>>
>>> +
>>> +#define _libeth_xdp_xmit_do_bulk(d, n, fr, f, xqs, nqs, fl, fin, ub, ur, un)  \
>>
>> why single underscore? usually we do __ for internal funcs as you did
>> somewhere above.
> 
> Double-underscored is defined above already :D
> So it would be either like this or __ + ___
> 
>>
>> also, why define and not inlined func?
> 
> I'll double check, but if you look at its usage in idpf/xdp.c, you'll
> see that some arguments are non-trivial to obtain, IOW they cost some
> cycles. Macro ensures they won't be fetched prior to
> `likely(number_of_xdpsqs)`.
> I'll convert to an inline and check if the compiler handles this itself.
> It didn't behave in {,__}libeth_xdp_tx_fill_stats() unfortunately, hence
> macro there as well =\

UPD: it can't be an inline func since it's meant to be called like that
from the driver:

	return libeth_xdp_xmit_do_bulk(dev, n, frames, flags,
				       &vport->txqs[vport->xdp_txq_offset],
				       vport->num_xdp_txq,
				       idpf_xdp_xmit_flush_bulk,
				       idpf_xdp_tx_finalize);

The type of `&vport->txqs[vport->xdp_txq_offset]` is undefined from
libeth's perspective. libeth_xdp_xmit_init_bulk() embedded into it picks
the appropriate queue right away in the driver and it's a macro itself.

> 
>>
>>> +({									      \
>>> +	u32 un = (nqs);							      \
>>> +	int ur;								      \
>>> +									      \
>>> +	if (likely(un)) {						      \
>>> +		struct libeth_xdp_tx_bulk ub;				      \
>>> +									      \
>>> +		libeth_xdp_xmit_init_bulk(&ub, d, xqs, un);		      \
>>> +		ur = __libeth_xdp_xmit_do_bulk(&ub, fr, n, f, fl, fin);	      \
>>> +	} else {							      \
>>> +		ur = -ENXIO;						      \
>>> +	}								      \
>>> +									      \
>>> +	ur;								      \
>>> +})

Thanks,
Olek

