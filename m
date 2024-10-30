Return-Path: <bpf+bounces-43532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E234B9B5E2D
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D70282E01
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FAF1E1A2C;
	Wed, 30 Oct 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igPK1lxx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA815B0F7;
	Wed, 30 Oct 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278030; cv=fail; b=Mjb+tb9sfDcZUrjYCWEhjOY8ihrmASKGAArIzPDQ+Wz4Ma/zYSM5PV6/TFiNdxdmXk8ou33e/0ReWaXw3mgGabiRt/wjZQ0AECxxjWC5n+3FoQDgRg5CTGY6oWtV4PNh11Lb/A9qA+nVxpvdRScBTwoC7O6U8MxmPwRBFRs6OVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278030; c=relaxed/simple;
	bh=NcIi/ZfWBnITvItECHQr1gKh6VAwo7HuxEIYNH182g0=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=rVSl1kGLnI/mAbfLsypL9XMHiUYxDSBNX2iTDX1n4dbIx/TK0dDIvyD4/B3KzuJiCIYmOAnoymMSb224TF45OF6jndZ7l83SGRuNtb/LpAfGmXtHAOPFTP9C0Hi4cEc+8gW83yW0rQpf/EE6TsBxUMYC818WooGjLBHYAJOykYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igPK1lxx; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730278027; x=1761814027;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NcIi/ZfWBnITvItECHQr1gKh6VAwo7HuxEIYNH182g0=;
  b=igPK1lxxAAZ5xLiW/ZWWXYCI4A6M07eCKIxE8Ffm/NSBpK4j/JYZQ21I
   0VzVielTi6LHrfAcFemxDWGdKnrjG7amDt4yhxEPiV7+n9nj3cZNwpBGi
   vkmC9Ofl1cynQKkZc571mznhGraGbEvZ1A69U3B4B14Fwk+hlIZzaCOWt
   RSCGtro8nlJHkPeNfGmCkZG3hMtJo+VzXfs7ffEV2OGMeMZKaditWHV1U
   IvJyrR2XoOhpHw4b07lxhrNWZXNlEtOOSZL20r6CsPItOi0IhCMgTfoyY
   Mt2aeJ497Ogmyw3p5oGf5WLRg0hqyfbBZ/fLaGa4nbjUa7HtotMZeRcn0
   Q==;
X-CSE-ConnectionGUID: SdqSddWATUSooBRN2y+nBA==
X-CSE-MsgGUID: lxy9ZZwTRWS9on3xdwqt5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="30179221"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="30179221"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 01:47:06 -0700
X-CSE-ConnectionGUID: 49rYw79rRD+r91cR6Slgrw==
X-CSE-MsgGUID: KNY7hLx1TlKvLxJonnsUwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="86847420"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 01:47:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 01:47:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 01:47:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 01:47:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYt8VMQDf+Nv/lwq0SKvW0fo0MKQGXNHlQhhR85LqgYNskmojk6QDCFGVhS/ziz+7OqQHSv3zO/npOpfB24DTLb7B+M2HzvpttMQ4QUXlm6hOwzm1Q8waER673nS3idPDE3ZRuGX/yjA87rm9k2p3cHpvrvw8ilBC5PHVr+F03wfDHU9gHgdVgjYlxzsfx/s4bBTLudiaO7p+a6XXIisuMNQmaJiNJLLljEUMUK7f3WWYWa2NjjbH0xshAWCh286EhuwTlJW438O/VPDNDbLOss9A4fejyYuZCGDJknwD48X63LqSZ3uN3ktZ+eai8F2i1xGMIQn3TV/J+urwHj+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HISlVkUD7b5x0nXpQ1cmNOV6RZjosiyjAtbeyNgWf+8=;
 b=cO3OMHerN+/dTP8H6tpqBdxtI0FmttLMy7DR+IANQ9CifOMERKgN85GM90Q0nUVi72qnhSPs9ZwCiKHScu6vjt+o9nVA7CP4HZzKBhwDmroX6ij+X2NSYBHloLVwmh1og1MwihQL4i0lOj/Ujn7e82QyuhO3otUUGBjBAuFrn+4zmrGx/PoQOmS97ufhq9s2ufLIe/NLKvKPCSPWn4iCbySh/Z4dAN98oRrMG2a96Xow91epftyhRR5tgspWuVkVhe8YTcRMepRJjjCmUUaM/DP6g/lavh0aypw6mqu09SqmIDg9WWnxQwfdl4O69Ez+nOSgt7OUW+1Fvghpd1nfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 08:46:56 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%5]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 08:46:56 +0000
Subject: Re: [PATCH iwl-next v6 2/2] igc: Link queues to NAPI instances
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <jacob.e.keller@intel.com>, <kurt@linutronix.de>,
	<vinicius.gomes@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
References: <20241029201218.355714-1-jdamato@fastly.com>
 <20241029201218.355714-3-jdamato@fastly.com>
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Message-ID: <0514fcdd-abb7-185c-9304-6a8ed9f8275e@intel.com>
Date: Wed, 30 Oct 2024 10:46:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20241029201218.355714-3-jdamato@fastly.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To PH0PR11MB5949.namprd11.prod.outlook.com
 (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|IA1PR11MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e6d66e-003d-4940-de51-08dcf8bf68a4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjBtcVlxMHJ3dlpkZnVsUFQ3NXZTRzhRSmVlWUJVMU9KcUZBVVVMZzhJWXRz?=
 =?utf-8?B?b3Y4N1ExaGNSZWNhU1lOclZsS2FFOEkvUFcrcFI3eU1ZOGU4UGVUTzNBa0ZN?=
 =?utf-8?B?Nm8yTXpvbDF3L2g0c3JqMTZWTFdIQjk0UG5RTjZ3L1V1VnVWN3ZsWnM1WW1Q?=
 =?utf-8?B?UUp4WXE3UFBVeU93a0JnbTlZRmh6RmhxYVZxN1dNMEhCTXhIVnRkVEE2bTlk?=
 =?utf-8?B?cWRQWjkrN2Z0OVRHNDlqS3puM3NwVjg4OFgxWGtzK3NTeUtiN1NBUjJUM0lq?=
 =?utf-8?B?Z3J2aVQzQUEyT1hjR2dYR2lza21EekZMUHlCVkd2L2dLOXZqVjFObllWQWR6?=
 =?utf-8?B?RFc2bjkrSENTTXpQeG5Xa1NDWGJySGtXdExWZGFaNU5MOEtMMVpHZzY2ZWxP?=
 =?utf-8?B?WHBHVkx5T3dwT00rNnc5akUzaTRuU3dJTmgxZVYxNUNlRXJQcmdxNk8wdGVs?=
 =?utf-8?B?SjhEMjlRTTNlcnhzc3pZNWNiczlxekFjeG1OMlpEaTk1SGZpckRuZFp3Nm9n?=
 =?utf-8?B?ejlXVUxmZ3BnMHF6WU1zQTV3NTBJejhUSVJwcDVtOTY5QkZ3Tm9EM05vdmdO?=
 =?utf-8?B?Rmo0Zm5aaVl4V28wK29ISGRvL3d2d1JmR3lrRzhjNDk3Lzk4dENrS2tONGNk?=
 =?utf-8?B?QXN1YnhNZzBTWkV4ZzJPNllPcUpFTG5vR1cxYjRlL3NwQ3FKcnhxYkcxNGIr?=
 =?utf-8?B?RW16T2J5ejR3dHF1cjZUVWdVR09DZXBuNjhHYzh5OWJwS0lRTWJXTFFOZUFN?=
 =?utf-8?B?NkxJNmV3R04xUXFEaXlnWTJPUFJTM1lGaUtyQ2dkbWk0b3M2cDhzNFAvdHRv?=
 =?utf-8?B?TDhKU2p1TGhzUk5vbE9mRE1URk5rZ3lxM0pteTRQUStYMWwydWltMUVIOS9I?=
 =?utf-8?B?eStJR3BBQXYyUDluNlJoeVBsSGlEUHd1VndEZHdmNmdzZ29DWHE5T25jSlkw?=
 =?utf-8?B?NytiM0xFN0RTRTZzcC9qSFF3WWlIQVJJTzRhVG1DVUNHS2prdDg2RnhnMExr?=
 =?utf-8?B?K2EydU03US83aytDRlFoMGw3SXdhYmJjanYydDZlMit3NUlydXJHK2lZK25M?=
 =?utf-8?B?VUVjaWpJZzhHVkpWbUFTY1UvcU1IdURJa2tFcW9KbHBKTUtrdm5VWWNKWmJ5?=
 =?utf-8?B?eVdCMXhDTVBOdGtkK3dGWGtnN2t2RTc4WmdEYUc3eXk3cVdJSExhcHJlN0N3?=
 =?utf-8?B?SHhObHFhcGgvNXppRWNuT050a1F0dUNRZTQ5L3hCVVZlVG5uVTM4WFRITW9D?=
 =?utf-8?B?K2hhQjJxYWtxcVk2RVBCai9uelFVV2U1TVZwNFkyOUR0S3NnWDhhZkw0ZFNk?=
 =?utf-8?B?WE5PcVoxNUJSOXpXYUk2K1RmR2tUaGFxQkxnblhPb3BmbWg2QjlENFc2L00y?=
 =?utf-8?B?c2R6NmlaNUZ2b2pacmJlbkVNdkhPYzRicVhKbW9odkdIVitsbEZOOUR6VXh3?=
 =?utf-8?B?ZFFLMWRtRWI3MHZyUUlBM29DQTY1WDlLWjVzMVdpeVR4cWVxY24vSkVYcXFD?=
 =?utf-8?B?SVFHWGtjWDBjNDI4UzBqdStValZXcDBScmFFR2h2K1pIb2NkVmNsdUkyVzVq?=
 =?utf-8?B?K2VpSVVkbW9jTkRIUWVXU1BZdjFVNHJHV1IybC8wUjB1SDBrZTJMTmRJKy9k?=
 =?utf-8?B?SEF6VEh2ckFtcUNjVmNsemhMT1lTSW81UnFIam1CSTRSbitJTDlNU0xpaGtW?=
 =?utf-8?B?bjUrTnU4emg3ZWovZXFkQUxCa2VOWng2ZDVhTjAxR0F4dlRDZmJQOWNlMnZY?=
 =?utf-8?Q?NxQ/VX7kLbt8ICns6xBoQodTSX7eZH/zVkH6CsU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2F6UXhxamVQZVpwNEU4NmNKbUQvQWZrcENFakRIM3Q2R3JsZkpSU3BmODlG?=
 =?utf-8?B?TFFFd0hSejduaXN3b1FKd2JUUldCVHVUcTBlMUpINExuTUlQN0U4ZGNDQXlZ?=
 =?utf-8?B?SzNsSWpkSDhtdEsyVXBwS2N2bVEzd2ZHVGljWFJ1blhvNGlaZ25wR1hUeDR0?=
 =?utf-8?B?NzVoVG9WZWVqR2E5UGFBL3FVV2lmd09KcEhVRkNxZGVHZFdxMlBJUE1TWnpv?=
 =?utf-8?B?RXZrWGYwdmU5aE5oWjJVUjk1UEFiaDJsVEkzNmJET1UwMDBBZ2NYbXp1UHBs?=
 =?utf-8?B?L2tXZDJtU2VhK0dNOHZ2d0FpMG1SYnhDYlJLd1M5eHp1Q2tCYS9pVzArUjdw?=
 =?utf-8?B?TGUzQXRiR1ZWT2VRTHBXRjA3RHliVzlkK3RvcXZDN0RDajVhZDFrWjF0bEEv?=
 =?utf-8?B?MkVZMnlJUk91cU5SalMza2F4KzM1QVBwUm9OSFM1UENiSFd2RFRVbll6OWY3?=
 =?utf-8?B?dnU5M0c2L3VwcUxyZDNaWEFWWHlxQTNEdTVmUXNGWC9oYjIySUtacURQZ052?=
 =?utf-8?B?bEE2dnV1Yzd2V2c4VUJ6U3JCLzRVdTlKcjgxdlBLRW9OZTRUQmkwcXdPeEFi?=
 =?utf-8?B?RVEwMjB4R2ZXSjhKeDY5WDM2OW1yanBtWG12eUNwS0pQSG1mWitVdHFOd2JR?=
 =?utf-8?B?N2kySjNpNTdDT1VIRCt4ZytHV3JQRjFveWRkSU1wK2ZwMVRRZW14Tk5jNnJE?=
 =?utf-8?B?N2ZaMDExZ0hSbkZXMTBBbC9QVzNucDIxN1pwbDRYWjBKZ1R3blJ6bWtYdVZu?=
 =?utf-8?B?VE82QTZQNWZkY1dvbTN4eXhvSEdPQVRrU3VzSjR3STBIeU5Qd3RxYit3b0N1?=
 =?utf-8?B?SUlRR25wNXVXMmhqZFV1b0VkdXYyUGgxQnlwSWNoSFBjZFFuWEVUQlVOcVBK?=
 =?utf-8?B?VnRyQisxOFRlTVhEZEIySlZwc0hkc1pINEl4TC9Wdk9iWUlSVnJBN0RjL2sr?=
 =?utf-8?B?dDdoMDJCVmNyY3hwZ3dDSHZyeWNqZ3lGbm8wWmZVajRoKzdoeXA1clNBN2VW?=
 =?utf-8?B?Tmp5NG8rcnJiZzN6SXU5TXlnMnUrS0lqK3NmcVI0K0ZIK05JWnNxVzV2YVgr?=
 =?utf-8?B?M2R3RUJYNzFOeEdIck5lT2Q5TERWSTQvTTQ4Yzd4NEdXRUwwOTMrY0d3U1VG?=
 =?utf-8?B?OEZEYjRJSnJkcWo1eUg4U1lSdEtoZDNabzJ3OXZWOXpvc1VYTFM0VEJCbTVl?=
 =?utf-8?B?dGFYREIyNGhQT1RpMzV1MllaMlJpNlRDOUZnbnM5cUo1eWxvUzZHRXpiZ1RS?=
 =?utf-8?B?M0ZROWdUUlk1OU1kL1dYb0dOZEVycURqL0NWczZiaWlIRHlzSFdzYXNwTnFR?=
 =?utf-8?B?dXNGRjhjRnJDRXNhVzhFYmRuMnJlcEh6azBjQ1RiWkxLVzBZZGIza3pMcXAr?=
 =?utf-8?B?ZEFad1E3cGJCejdUbHQyVjZjSSt1cVRsMVplTXBsRkxibkZBTmxSQVptNWlO?=
 =?utf-8?B?UFcxM3pnSktoUExqekJrMnE1RVd3VHF2Ymd3WmlMNDBCKzl5UkMzb0JSS3FU?=
 =?utf-8?B?REl3K2lheFhRcDNZUVVZQmtaQk0vVjM2YmwxMjJYR0VrQUhnQ3ZESUZkS2cx?=
 =?utf-8?B?Ly9wK0J5YkVGV2N2ZE9SUFR4YlA2bDNGSm83TUFVQy94L0dva0EvYWV2WHN2?=
 =?utf-8?B?d3dZS2pZWit3eWc4eWJrQWNkQjNaUE1jR0h1am52b3ljQ1NVeFFpamRIYjdS?=
 =?utf-8?B?M0FtTXJBU2lFcTlWdkYvY1hVRmZ4dTJHbFVnOUF0VGJsSDd3WGZScmF3NUI5?=
 =?utf-8?B?V1RwZlBpNCtocTZwc2dzWFBTUUhLbGdwck1JamU5VHNBOExPcitmQXJiL3lo?=
 =?utf-8?B?RUJtNVJNenA5UzY2S3pGdUhDakJhZkVjL3dvYTRVdS8xNUtFZGtBSEIweUlX?=
 =?utf-8?B?d09nZmxsandlZDB2em1LZVBNSnZFUnAzRVlpWWJzSUJ1ckZxZjd3YWZiaFha?=
 =?utf-8?B?SGhRREttcEJHWmRqMHdJc3hlSlNJZUV2cjJ0bHk2V2E0N1QzZHN2LzVGZmxu?=
 =?utf-8?B?THpPOHBpY0hmajl4NFZmRWlnWFBxYWlES1dJdEs2UUxRU09zRUhwWUxWMnFY?=
 =?utf-8?B?TXJ1RThaWXltRkVQSnJaMFl6UkU2YzQ5ZWVQWkZGQUw3RDk5TnhJSHNzTzVP?=
 =?utf-8?B?Yld5YWR5aXdLM1VMa1Q4NlFTRTdmZXNNcExoQ2tMMFNPUHhSZ09aTzh6clVI?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e6d66e-003d-4940-de51-08dcf8bf68a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 08:46:55.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yjOaVcPU5X7cdjMwozSbcvEsY7Py2OYC4AfT/B/1SwEmdo6LOWBpxtfj+rNf0EuFYCBzFSaZAM/K9o5iPKSrP1wTZle6wJ/r8qSiFyWN7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com



On 10/29/2024 10:12 PM, Joe Damato wrote:
> Link queues to NAPI instances via netdev-genl API so that users can
> query this information with netlink. Handle a few cases in the driver:
>    1. Link/unlink the NAPIs when XDP is enabled/disabled
>    2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled
> 
> Example output when IGC_FLAG_QUEUE_PAIRS is enabled:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                           --dump queue-get --json='{"ifindex": 2}'
> 
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>   {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
>   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> 
> Since IGC_FLAG_QUEUE_PAIRS is enabled, you'll note that the same NAPI ID
> is present for both rx and tx queues at the same index, for example
> index 0:
> 
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> 
> To test IGC_FLAG_QUEUE_PAIRS disabled, a test system was booted using
> the grub command line option "maxcpus=2" to force
> igc_set_interrupt_capability to disable IGC_FLAG_QUEUE_PAIRS.
> 
> Example output when IGC_FLAG_QUEUE_PAIRS is disabled:
> 
> $ lscpu | grep "On-line CPU"
> On-line CPU(s) list:      0,2
> 
> $ ethtool -l enp86s0  | tail -5
> Current hardware settings:
> RX:		n/a
> TX:		n/a
> Other:		1
> Combined:	2
> 
> $ cat /proc/interrupts  | grep enp
>   144: [...] enp86s0
>   145: [...] enp86s0-rx-0
>   146: [...] enp86s0-rx-1
>   147: [...] enp86s0-tx-0
>   148: [...] enp86s0-tx-1
> 
> 1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
> report 4 IRQs with unique NAPI IDs:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                           --dump napi-get --json='{"ifindex": 2}'
> [{'id': 8196, 'ifindex': 2, 'irq': 148},
>   {'id': 8195, 'ifindex': 2, 'irq': 147},
>   {'id': 8194, 'ifindex': 2, 'irq': 146},
>   {'id': 8193, 'ifindex': 2, 'irq': 145}]
> 
> Now we examine which queues these NAPIs are associated with, expecting
> that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
> have its own NAPI instance:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                           --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>   {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

> ---
>   v6:
>     - Rename __igc_do_resume to __igc_resume and rename the boolean
>       argument "need_rtnl" to "rpm" as seen in igb, as per Vitaly's
>       feedback to make the code look more like commit ac8c58f5b535 ("igb:
>       fix deadlock caused by taking RTNL in RPM resume path").
> 
>   v5:
>     - Rename igc_resume to __igc_do_resume and pass in a boolean
>       "need_rtnl" to signal whether or not rtnl should be held before
>       caling __igc_open. Call this new function from igc_runtime_resume
>       and igc_resume passing in false (for igc_runtime_resume) and true
>       (igc_resume), respectively. This is done to avoid reintroducing a
>       bug fixed in commit: 6f31d6b: "igc: Refactor runtime power
>       management flow" where rtnl is held in runtime_resume causing a
>       deadlock.
> 
>   v4:
>     - Add rtnl_lock/rtnl_unlock in two paths: igc_resume and
>       igc_io_error_detected. The code added to the latter is inspired by
>       a similar implementation in ixgbe's ixgbe_io_error_detected.
> 
>   v3:
>     - Replace igc_unset_queue_napi with igc_set_queue_napi(adapater, i,
>       NULL), as suggested by Vinicius Costa Gomes
>     - Simplify implemention of igc_set_queue_napi as suggested by Kurt
>       Kanzenbach, with a tweak to use ring->queue_index
> 
>   v2:
>     - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
>       disabled
>     - Refactored code to move napi queue mapping and unmapping to helper
>       functions igc_set_queue_napi and igc_unset_queue_napi
>     - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
>     - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
>       igc_xdp_enable_pool, and igc_xdp_disable_pool
> 
>   drivers/net/ethernet/intel/igc/igc.h      |  2 +
>   drivers/net/ethernet/intel/igc/igc_main.c | 56 +++++++++++++++++++----
>   drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
>   3 files changed, 51 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index eac0f966e0e4..b8111ad9a9a8 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -337,6 +337,8 @@ struct igc_adapter {
>   	struct igc_led_classdev *leds;
>   };
>   
> +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> +			struct napi_struct *napi);
>   void igc_up(struct igc_adapter *adapter);
>   void igc_down(struct igc_adapter *adapter);
>   int igc_open(struct net_device *netdev);
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 7964bbedb16c..9a5ece12e9d4 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -4948,6 +4948,22 @@ static int igc_sw_init(struct igc_adapter *adapter)
>   	return 0;
>   }
>   
> +void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
> +			struct napi_struct *napi)
> +{
> +	struct igc_q_vector *q_vector = adapter->q_vector[vector];
> +
> +	if (q_vector->rx.ring)
> +		netif_queue_set_napi(adapter->netdev,
> +				     q_vector->rx.ring->queue_index,
> +				     NETDEV_QUEUE_TYPE_RX, napi);
> +
> +	if (q_vector->tx.ring)
> +		netif_queue_set_napi(adapter->netdev,
> +				     q_vector->tx.ring->queue_index,
> +				     NETDEV_QUEUE_TYPE_TX, napi);
> +}
> +
>   /**
>    * igc_up - Open the interface and prepare it to handle traffic
>    * @adapter: board private structure
> @@ -4955,6 +4971,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
>   void igc_up(struct igc_adapter *adapter)
>   {
>   	struct igc_hw *hw = &adapter->hw;
> +	struct napi_struct *napi;
>   	int i = 0;
>   
>   	/* hardware has been reset, we need to reload some things */
> @@ -4962,8 +4979,11 @@ void igc_up(struct igc_adapter *adapter)
>   
>   	clear_bit(__IGC_DOWN, &adapter->state);
>   
> -	for (i = 0; i < adapter->num_q_vectors; i++)
> -		napi_enable(&adapter->q_vector[i]->napi);
> +	for (i = 0; i < adapter->num_q_vectors; i++) {
> +		napi = &adapter->q_vector[i]->napi;
> +		napi_enable(napi);
> +		igc_set_queue_napi(adapter, i, napi);
> +	}
>   
>   	if (adapter->msix_entries)
>   		igc_configure_msix(adapter);
> @@ -5192,6 +5212,7 @@ void igc_down(struct igc_adapter *adapter)
>   	for (i = 0; i < adapter->num_q_vectors; i++) {
>   		if (adapter->q_vector[i]) {
>   			napi_synchronize(&adapter->q_vector[i]->napi);
> +			igc_set_queue_napi(adapter, i, NULL);
>   			napi_disable(&adapter->q_vector[i]->napi);
>   		}
>   	}
> @@ -6021,6 +6042,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>   	struct igc_adapter *adapter = netdev_priv(netdev);
>   	struct pci_dev *pdev = adapter->pdev;
>   	struct igc_hw *hw = &adapter->hw;
> +	struct napi_struct *napi;
>   	int err = 0;
>   	int i = 0;
>   
> @@ -6056,8 +6078,11 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>   
>   	clear_bit(__IGC_DOWN, &adapter->state);
>   
> -	for (i = 0; i < adapter->num_q_vectors; i++)
> -		napi_enable(&adapter->q_vector[i]->napi);
> +	for (i = 0; i < adapter->num_q_vectors; i++) {
> +		napi = &adapter->q_vector[i]->napi;
> +		napi_enable(napi);
> +		igc_set_queue_napi(adapter, i, napi);
> +	}
>   
>   	/* Clear any pending interrupts. */
>   	rd32(IGC_ICR);
> @@ -7342,7 +7367,7 @@ static void igc_deliver_wake_packet(struct net_device *netdev)
>   	netif_rx(skb);
>   }
>   
> -static int igc_resume(struct device *dev)
> +static int __igc_resume(struct device *dev, bool rpm)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct net_device *netdev = pci_get_drvdata(pdev);
> @@ -7385,7 +7410,11 @@ static int igc_resume(struct device *dev)
>   	wr32(IGC_WUS, ~0);
>   
>   	if (netif_running(netdev)) {
> +		if (!rpm)
> +			rtnl_lock();
>   		err = __igc_open(netdev, true);
> +		if (!rpm)
> +			rtnl_unlock();
>   		if (!err)
>   			netif_device_attach(netdev);
>   	}
> @@ -7393,9 +7422,14 @@ static int igc_resume(struct device *dev)
>   	return err;
>   }
>   
> +static int igc_resume(struct device *dev)
> +{
> +	return __igc_resume(dev, false);
> +}
> +
>   static int igc_runtime_resume(struct device *dev)
>   {
> -	return igc_resume(dev);
> +	return __igc_resume(dev, true);
>   }
>   
>   static int igc_suspend(struct device *dev)
> @@ -7440,14 +7474,18 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
>   	struct net_device *netdev = pci_get_drvdata(pdev);
>   	struct igc_adapter *adapter = netdev_priv(netdev);
>   
> +	rtnl_lock();
>   	netif_device_detach(netdev);
>   
> -	if (state == pci_channel_io_perm_failure)
> +	if (state == pci_channel_io_perm_failure) {
> +		rtnl_unlock();
>   		return PCI_ERS_RESULT_DISCONNECT;
> +	}
>   
>   	if (netif_running(netdev))
>   		igc_down(adapter);
>   	pci_disable_device(pdev);
> +	rtnl_unlock();
>   
>   	/* Request a slot reset. */
>   	return PCI_ERS_RESULT_NEED_RESET;
> @@ -7458,7 +7496,7 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
>    *  @pdev: Pointer to PCI device
>    *
>    *  Restart the card from scratch, as if from a cold-boot. Implementation
> - *  resembles the first-half of the igc_resume routine.
> + *  resembles the first-half of the __igc_resume routine.
>    **/
>   static pci_ers_result_t igc_io_slot_reset(struct pci_dev *pdev)
>   {
> @@ -7497,7 +7535,7 @@ static pci_ers_result_t igc_io_slot_reset(struct pci_dev *pdev)
>    *
>    *  This callback is called when the error recovery driver tells us that
>    *  its OK to resume normal operation. Implementation resembles the
> - *  second-half of the igc_resume routine.
> + *  second-half of the __igc_resume routine.
>    */
>   static void igc_io_resume(struct pci_dev *pdev)
>   {
> diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
> index e27af72aada8..4da633430b80 100644
> --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> @@ -84,6 +84,7 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
>   		napi_disable(napi);
>   	}
>   
> +	igc_set_queue_napi(adapter, queue_id, NULL);
>   	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>   	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
>   
> @@ -133,6 +134,7 @@ static int igc_xdp_disable_pool(struct igc_adapter *adapter, u16 queue_id)
>   	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
>   	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>   	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> +	igc_set_queue_napi(adapter, queue_id, napi);
>   
>   	if (needs_reset) {
>   		napi_enable(napi);
> 

