Return-Path: <bpf+bounces-40167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF08F97DEC0
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 22:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AA61C20D78
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EC4126BE7;
	Sat, 21 Sep 2024 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2nq3wVU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F07273FC;
	Sat, 21 Sep 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726949845; cv=fail; b=Lg2GHhKvZz2H68mMTt+agAKP5pL+qRP+gVmy33L1HdMt41Rs5z4SZv2RAfNXokS/DeO9314MdmlOMqEJL27/ip9vAanykT6gY9ykldSxIU8AxwM+dSfV5RdhgEKJ7pjtvyVNXbk6Bq6OwiYfsN+EAWYocgEDT7BL25822cYZnDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726949845; c=relaxed/simple;
	bh=aA8yewiK4mCAz5y5HemF8PD2oU2le9TJ4vQRDiUNmo4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TNp/Mwev/Po9/tsy8V8VYRLCTAIv3umTLtMgQqkI3lZtRrqKv4s9H+w/wYrrquNDoxb/T12ROWSLJM55BuA5l6chhJkd9aWxTECWberTYnANf3sQxXVv7Esi8awLTGG+gZjTQmbi/0BCio7bmvl4RQw047DKq/kDUArsnMmSsK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2nq3wVU; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726949843; x=1758485843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aA8yewiK4mCAz5y5HemF8PD2oU2le9TJ4vQRDiUNmo4=;
  b=M2nq3wVUTcdcMdcNmIytxR2//5aJY5qlH3X7wxPaP4wV6thgn1hPHACe
   gsnW8dngmUKjFyI3XdVOTSYSwHvu34rwxGaYnkbrh9viczpZ1Hc89F03G
   fI1nmU3LQJjP0FYrRq9zLjHgbPoOj99Kn2crpbLf2h9JCumX+xXQOqM1H
   asCf9dcEj5uN+jbALPlb4UndrciSPbOZvMt4DMONJ3ZIyIkZaN8BQp1PZ
   VPVcLoSVCGANFS0aYysfRrYzNYLu56msn9QQH/Y8s1w+qTYZ2C0uV3Gb4
   zHRcF3SXTMzI1LE5nfTcHAO91f3vcpv1zvT/JecwUeRVhJuylEtSyri+W
   A==;
X-CSE-ConnectionGUID: gRx5R7y5Sv2fYrYskcOK8w==
X-CSE-MsgGUID: WDEDcZGbRuuPFw6brHq2kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29660874"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="29660874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 13:17:23 -0700
X-CSE-ConnectionGUID: YR8fh8wBRe6wgL3NjyoZ0Q==
X-CSE-MsgGUID: QbQ0jq2GQy6ANBPE6dtmqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="75041857"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2024 13:17:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 13:17:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 21 Sep 2024 13:17:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 21 Sep 2024 13:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvbUAdpa0eVkFUATK94hJj8gfyDmI+tYoegy107ruLni8fnnaqPJjrTcc4ynRWkxyU4Rq5kDRS/tSZzD4wxp9xvZmVzbKEuIERbylYV9zxCE+4V6+os38oJYzdYSBYLsrsBaVQDLC0c/MZl16Ie4+h/BLfyQ0oKiUSwZAztIjsZMiMqaiBCyNS8xBdC2hV7d0Fwqot9Xz7vnbpjH2reyjx1ElVegW9++dVADVmx72/vxyMRwk4MBkkcscCktI/wcPhcbp5ektJT7PITmKRJeAW67hYkNbPF8y1blUccSdJZT9yMZg2zth52sHN9SEBPkXocyadhB6qAJxQk6l44ctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LBWWoOOcIx5+yMzTXP0iQvnUFdX+1w+Jback0fz1yw=;
 b=iJcs3dHaJnmnY8BcgpFr1bEfakkUxoZRSBv9aoPOwFLvj/pUZ1+mT1/I2y2+dHAdICTZiqc0mWzoEoCiQGDxlVhIT3npWGZQPW6VBKihRCrkMRd7RKjLBxVefPRLR5jcSgGL6WcAhC9GK2PWI8OPEEUlDPUzv0NG2hac5GYT+Mn+rOqCDVDn/NB6wqHMOl1rEk66WKE9RUyywUWl2xWOpeYYmDBzTkmC161Jt2l8G7WsZjHHpbqpIbjBUbWW2OdwVTUfOmpfCe0zrPPiwhrFJheDn7YVqm0aYvXhs1crv/FWInQ+Kb9cD8wxOp7Ea1maLO/vNSMVEkWg9B/UhPvkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CYYPR11MB8329.namprd11.prod.outlook.com (2603:10b6:930:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sat, 21 Sep
 2024 20:17:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7982.022; Sat, 21 Sep 2024
 20:17:16 +0000
Message-ID: <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
Date: Sat, 21 Sep 2024 22:17:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <kuba@kernel.org>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <edumazet@google.com>,
	<pabeni@redhat.com>, <lorenzo.bianconi@redhat.com>, <toke@toke.dk>,
	<sdf@google.com>, <tariqt@nvidia.com>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
References: <cover.1726935917.git.lorenzo@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1726935917.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CYYPR11MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: d0754e17-ed32-495b-abe0-08dcda7a62dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkgzdmR0VFZ4R1VXT3l5d05RZ09YN2NQS1ZXUVFjV3VLdHhIcGVmaUdhM3Q4?=
 =?utf-8?B?SngrcEVYMmJDUVljMnplRGpqaGM5cGlTOTRHVVlPb002ZzFidHlnY1RMSUc0?=
 =?utf-8?B?aDl6WnJlbjJUTlA2OUZrVU40OU1BRHJ1MG9RZVVKY0I0eHdnY0hVOUNzREs4?=
 =?utf-8?B?Z2hlNWJPajJVK2duUnBnT3V5dnM3ZFVaNU5lSXBDODdBbE1Dc1VOTG1Wb2Na?=
 =?utf-8?B?Ri9Dd0VXVnM3a3VtQ2dwaE1pNGVndVI2aE4vYXFoVk0rL0NDMEJXbzFCWVBB?=
 =?utf-8?B?dzJIU3NycjgvUWpxL3poMXNiQ05kc2pGZVRvTFFUVE5uLzl2ZWdlZWRZUVNk?=
 =?utf-8?B?R0h0STZjOFRvWnBDalQxcTRNZXJvc0xtWE1iV3I0eU5ITkthWVZQM2VSd3M2?=
 =?utf-8?B?ZDBqTzhuRTBtQVVyS3VldjlaVURPZXplQ0pNTmt0YzRtdko5QVU4REc4Uzhv?=
 =?utf-8?B?dkorNlFmQjZ5RCtvRFY0eDhsMHNhVVY1aWVqRmowakhtQVk5OFhJNFFjeE1a?=
 =?utf-8?B?NHNydWMzd3UvMXZqQ2F6U2FxV2hoRUJTQzVoN1k0Y1ZNdzRsaHVsaGs0WSsz?=
 =?utf-8?B?dnN5OXZabVUvZEs3MjNLcjlDV3FCUEJZV1U1N3Z4NHhMcWlSQ2RBQlNQVm9T?=
 =?utf-8?B?Y0VYcmFQdFB0V1A4WUx6VTBLalJ2RkkxOGhSWi9HTkU1N3VjTkFIZ2tKUUw5?=
 =?utf-8?B?WmNKM0dDSFRnS3YvU3F4QnI0ZHhXajlEWFBkdHdkWnhhTmd5VEdsZm9yazlD?=
 =?utf-8?B?S1ljMG94amtzcG5pL0JoQnlTN05TU2p0Qlh2d2tiN2UzTlpFbDlvSzRtSFVE?=
 =?utf-8?B?WWRWRGI5VlloOWdYam9XbzdWL1IyVytUQ3k5Yk05ZGdsaWdjdnBiS3Q3T04y?=
 =?utf-8?B?bFMyS3dBcm0rZXFZM25ubWsyNHFmdXVwWUphWGtlN3I0TXJOaGExdHFwOXJi?=
 =?utf-8?B?WERnZzJMZXV0ZUYvTWJQTy9rbTl5TEk3cFZaUFFKZGxYb1FSdW5GcEZRSGZU?=
 =?utf-8?B?ZkVDd04vTW1IRVhpU3pvMFVaUnkwS1o3SU5xZk5JNWdJc3g4bnQ3WmRyaXh0?=
 =?utf-8?B?QWlTOE1jT1YrQytoZXR6cWlCMEswUnVtc3lVaUhFc0ZGeHhHV01MNXpmYk01?=
 =?utf-8?B?UFdjMGRGUmo3RWtLeXBtNlVlaFFla2NzdEh3UkY4ZnhRTGIyYzVJTGRvaFhv?=
 =?utf-8?B?R3o0MDhOdTUvNXpJZ3BYVTNOcDNSNmw0YTBRNkwvOUE3WlRqVVF5dWlSWVZi?=
 =?utf-8?B?VUFRQXAydzJsam5sRFZYaHFQUkthUzZuMi9NREFCQlJidUdmL1JkSWlBdDhW?=
 =?utf-8?B?YzVtNGl1a2FyMCtRUjlidXlReUpMUXBJMDBPTVRBQkhOeDVteEFpaHpqM0Zs?=
 =?utf-8?B?aDJTUkloejAxYVc3bkJlazE3ZlE1cllBOHJXeW1XaXVXMkxIVDNZMHNqQlYx?=
 =?utf-8?B?Nm9HeGZsN3JTczdZZlVlRm1IOW9BRFNQLytITW5kbXQ4ZzZZaUZ3Wnp2UWJk?=
 =?utf-8?B?eVpmTEI0bHdxZ2RtMElja21PNU5OK2RaRTVoaUxrWEJCcjZ5M1VSMEdxQ25Z?=
 =?utf-8?B?VlFqemtnV3UwL3hYemFiZWQwTTV3MTBQQWVoU0tlSDJGMkFWMHBRUGNsYmFE?=
 =?utf-8?B?WVdyaFFFc3UzQnBucWFuMmRRQ3ZwZ0ZqMW1mRVFHT1VHa3VFb3ZiWHMxMUNi?=
 =?utf-8?B?WmVFTytjcDdkZjNpSXR3MU1wNzJEL2Z4ZzRhME8vNndOc2dlTEQxSEd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNQYnFwOTNIbitXWDNmZ3VMLy9yMWQ1TnZRWnJMUGU5QUtzdG9sQ2Y4NU9y?=
 =?utf-8?B?amlwV2hxdlJRa3lDR0IzZDc2MGh1Nm1RQThFbFRlMlNRQXM2Y0NXcmlsbWh2?=
 =?utf-8?B?bDVPamxyUmNiUFlObmQyOXdMbXQ4WXhaWC84aGZobkRpRTlpM2hQNE4wYllG?=
 =?utf-8?B?bFFTOWpQcFNUWjNodlh5VEpvbFh1S3JxWHc5YWEvS3RsQkRnY0REOGpWSTRh?=
 =?utf-8?B?RDNzK1BaNzRSa0VOcnZFMDhLQk5LYWswTjYwZlJEcjRHYXhJZ2themVzREdl?=
 =?utf-8?B?aXBrWlBEblY4QWQ4Ky82MHhTYUNNMVU3dUFuWElkY0ZVR2RPR0hKeWJEb0Jm?=
 =?utf-8?B?UnczdHRhNjRJVm00bmpBS2hDOGYzUU9OdlloNWRQdU83QTlNbkMzbHBGVnRs?=
 =?utf-8?B?TllZV0Q4cnNpUlgrRlZaVTFOQWFBWktuQXVQTlgwcjVTaC94dE9HUzlLamJo?=
 =?utf-8?B?QU1maEE2UmNGYXdjWFhYYzR5Q0ppT2VyNWhGODR0UzVzUmFSdFhuaHBaQmlh?=
 =?utf-8?B?LzA0c1VvQ01IWXVoSzAzMHBubDlDamJoa3BpRUU2VXh2aUE1T3gyRlc4YVo4?=
 =?utf-8?B?dWNKb1lDbmVzNnhUcDlES20wMDY5ekZBVTBDTkY2SytRNWlENnVYcFY2SE5h?=
 =?utf-8?B?dmVpUllONVFXdHFxWWV5VmJCWHVuMElmemtPU0lMMit4ZWdjckRhcFFkTHRO?=
 =?utf-8?B?eWRpdjE4NHE5aFRVdzFuRDM4YmkyQ1lZTmFlUW41VXpML1NhUW85WG5oVHFT?=
 =?utf-8?B?MW1xQXQzQVpsTVBSWGJaVTNORG9lcFQ4eE84TTJFelhnTVFVR0k1VEN6SmpV?=
 =?utf-8?B?dFZhZDhyMGRSeDAyeE1rL3ZEK285MExocWQ1ajRaQkpLWTdXcW5pY1JtZ2tP?=
 =?utf-8?B?V1NCTG9CYUkrdXBiOTZTNVVUeVJ4QVJtVzF2SWRNUVkwdjBEMVp4WjI2Z09p?=
 =?utf-8?B?ODdHZGdrYUhmTHIzT0RQdlhpaE1jTnczRERNQlVzZ3VIMDgyUGVtcU5QNXgr?=
 =?utf-8?B?aU5lbGRuVlIxNVdVcmN0dHI5YXBteCs2Wk1jbk1sYnl4dnVlQkUvVWhMUHJM?=
 =?utf-8?B?bC9mNUdxYlVXaWpGcnVMQjdQTXdCYWtEamhOVUkzY3VoS0ZBNzI1bStjY2Vk?=
 =?utf-8?B?M0dpWDBqRmczd0RManl6N1kzMHFzVUwyQnFKamRMK1BTSTZkREZPZ3FVRHdy?=
 =?utf-8?B?bUdaaXRpUHFpckhVcWl5UFl6V0Qwb2JHaEJMUUM4NnFIZkRIbXhsa2ZkeUsy?=
 =?utf-8?B?bG1OcTJFSzl2VFo1N2dTV29XREZuZHQzMGFHS2duVXVLUzZDbWtHdUNvYnVP?=
 =?utf-8?B?dHd1bWpabzdpS2x5NGY4cXdSQmhjWEtyT0MyNDZSUW5LR3I3UWxWMmVpZStU?=
 =?utf-8?B?QWRuc2FvclFGNEVVUEUraVhjc0lDWCtZOTVmYUxOUUdHdWliR3JScFR4YXJs?=
 =?utf-8?B?U2JlQ0RuM1VyNVh2cGoxSXdCN1ZGY0FLZ0JtMWJ5emoxRTBucE9VSFVZeHU2?=
 =?utf-8?B?WFlHckF1TWxlK2I1UHE4eFgzUFk0MEt6amMwVVhNcmN2RmFGYXA5NCtZQVA2?=
 =?utf-8?B?dVZBOFh3TWhyTkM5RDQyNVVHY08zeWZPRSthOUlIMUpZMVlJK0hQR21NblIy?=
 =?utf-8?B?a0dBWUpLR0hUaENGRUZBQ1JxUUEzaENxZ05LdlA0eXRHelpRWnliRWFZMnhk?=
 =?utf-8?B?dEppbTdqeFhyMi9WdXNKVjlqdktXYllwUnJjRmNVeFNVemx6SXhDYUVwS2t4?=
 =?utf-8?B?RkFyZlcrYVJTN2xZOThVL0xtUmo2bVdOVkx6REFXUnN0T1pBdXdWWW5lQlM5?=
 =?utf-8?B?L3lXYzI1WlNaSTJ1QzlrNC9YenlEbUdGVStPdmxtZ1ZEZXI4U1lHQ3ovUXgv?=
 =?utf-8?B?dVJIWmV4OC9xSXE2bGw3OWI4YTczYWwva09vU1doTERNbnNxSFgwd1RWNXJq?=
 =?utf-8?B?eUZxNVhxWDBDNnlMTzlhTHpnWDF0bHFLbWtPSmlkVDYwWndpbnB1VFVKM1Bp?=
 =?utf-8?B?RlROOU82dzZ2c2pZVEtJekZsWXR3ME5neUdhcVkxNHZVbzhSdUJOWlZLZ2Jz?=
 =?utf-8?B?amIvVDdleEVjTHFUYWlSdWRscWxrQmVERE83SGdXMWYvdk1KZWc4MXNSa1BH?=
 =?utf-8?B?OXVIKzdMOUc2MHhITkJTYjk3TjFqUzIxNGsvRUtwRnBJWkIwMUhKV054ZjQ2?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0754e17-ed32-495b-abe0-08dcda7a62dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 20:17:16.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/ZDRR8NslWfOrC4KhGJVPS/NqJKclaKXzu6yXgwnZ9g2f8MTueZdLnqqUATVyD056RDIEvMBEtT3JgRZOpgkKZw5xYFwm1ZLntYl9QV2t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8329
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 21 Sep 2024 18:52:56 +0200

> This series introduces the xdp_rx_meta struct in the xdp_buff/xdp_frame

&xdp_buff is on the stack.
&xdp_frame consumes headroom.

IOW they're size-sensitive and putting metadata directly there might
play bad; if not now, then later.

Our idea (me + Toke) was as follows:

- new BPF kfunc to build generic meta. If called, the driver builds a
  generic meta with hash, csum etc., in the data_meta area.
  Yes, this also consumes headroom, but only when the corresponding func
  is called. Introducing new fields like you're doing will consume it
  unconditionally;
- when &xdp_frame gets converted to sk_buff, the function checks whether
  data_meta contains a generic structure filled with hints.

We also thought about &skb_shared_info, but it's also size-sensitive as
it consumes tailroom.

> one as a container to store the already supported xdp rx hw hints (rx_hash
> and rx_vlan, rx_timestamp will be stored in skb_shared_info area) when the
> eBPF program running on the nic performs XDP_REDIRECT. Doing so, we are able
> to set the skb metadata converting the xdp_buff/xdp_frame to a skb.

Thanks,
Olek

