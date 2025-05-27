Return-Path: <bpf+bounces-58992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C0AC5037
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C903B5D09
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504D1276050;
	Tue, 27 May 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnlkaR8N"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE5E27602C;
	Tue, 27 May 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353798; cv=fail; b=thrmD51ou61fp1nvGa7YBi1NHk6OX2IXd9nkYkDiDOWOs8RMCFZLj3QHUsKXWt076/1pb1hgLgv+H6z561caBStiYr7bUpwhbPJcGO3EN4+2VO6BZlsi8k0bFv2ytRtWSFrW/9ZAwEBJyKvUE/ckELZeykpOkc1hDk8AkF+2qno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353798; c=relaxed/simple;
	bh=Q8MBiw3DGm4NePE38fRdKqPXkAvJHPrnyA7LHOVH8oY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I5zkJl0LyLq9DX5mHpL5TP8Rc9eYoiAWs1wrsthkTgxkdjOZbbgg9DHdgqtcavpEHjeTezMe4TsE9EsbUP/gvkQWt2qwHWRh20bjjuA+bDi08FceacR8Jw3wKRbjZxkFJ9Tq0VXwR9IVekQBZQHgSSN61z3kspuK7LioOWrSl/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnlkaR8N; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748353797; x=1779889797;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q8MBiw3DGm4NePE38fRdKqPXkAvJHPrnyA7LHOVH8oY=;
  b=GnlkaR8NWFMQDBjmLJ4kn/+TWNOX9DY4JP/yMx9GN/UcpBeVORz8v3i6
   F5sfvMxghImZblBm6mXBmi6Fkx1wh3P26ZwyZvakrSazNeXzUKZKFTwy2
   s6Zzpe4CaVYlI8PqzvGXtF7OEhMyh425ogJTd30T/MooldDfc5h/BbI2i
   mz8fmK5LjXCYAEwuKU5umTH+n7hIPEfNG890bgCzaUbq+h39Yw96SkfOv
   Vo9leWf2RGY8pzPzj9YGGBwNpL6BCQtRw1y1mA08dus4LSt4lTGCsrsH+
   LmXKGwdqEM5maB9u1OzOJIIninMJw9xumdoScdIowuxKGXuqvFAlVXHb5
   w==;
X-CSE-ConnectionGUID: 4aGEmTqxSUKpWhns14TziA==
X-CSE-MsgGUID: PKTwi9XmT9ujI+Yewu1S2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50502337"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="50502337"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 06:49:56 -0700
X-CSE-ConnectionGUID: T7etRac3RNi+4kGm/tQ/WA==
X-CSE-MsgGUID: jwTx+I3hQjaEZQByxRHg0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="173705566"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 06:49:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 06:49:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 06:49:55 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.87)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 06:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcBsgl3E3UZR/YGbaxeefWauL46H6XJ+lt5O2iIxC7CwODRpjZSIDf76crmHlYfv1IBEzHUHJq7yVht6R5fiI+F6SPReW1gsbHU2CDe0s9Ip0LEUK/k92TfNOos29TidRSHl6JQvHUPobBGeS29QyT2+5nsc4/CNCmNAiNOWVAYshY6jYpb7UFC3qPeyAJpMfZHc+7mI9/yuCWVVzOBMzbfWBW6bY0rWf3kWDn4KIQPspke74QlPOTZuASAk4jevcG/+zvSGw70M+NK+uhzC6pH6PAaIbaBIeYkynu1bONqkcowPHdhG+LWL0M0smMqHIUK8h65BHEdInBHXfwwiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb7rEOAVrSh84qQ3gmMnMCQ0rW8jBj/b/UsiNEqdq70=;
 b=In0WF7M5BXrNvzwiHn2uGHgwSOhI9yGlWaZpMR7SrRnyvymMa4khctFS8obvaj/CedwPNPGLMJawwYjF2XNLpdYkRTXck/lAcZXCsfEQSLyWoR21bNmS8Fq7p/Nl9RVJ0tRzc1Ngsk2x8WZkqBNxXszeY+y/GrKtCoQdCjYAj0Kvcg2gEmg/eEq12Q++84yQ+mPTS3Qr/n2/apXykwzIMjL599Sb+a+MoQpXTU6In3H1VaUC67KtNG53yyH9+XxhsCYrB7mbPrZtBJ1gVwhxc5XguR7v5I2UcvxE8CPOrsPUEnvJnzHJe26pW15rW4cdxtqkzJSDp18t1OdlIiPUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 27 May
 2025 13:49:52 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 13:49:52 +0000
Message-ID: <267e3a85-1538-4181-89b4-4bf50a72b047@intel.com>
Date: Tue, 27 May 2025 15:49:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/16][pull request] libeth: add libeth_xdp
 helper lib
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <maciej.fijalkowski@intel.com>,
	<magnus.karlsson@intel.com>, <michal.kubiak@intel.com>,
	<przemyslaw.kitszel@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <horms@kernel.org>,
	<bpf@vger.kernel.org>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0063.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eeffd37-5f7e-4a83-138f-08dd9d255abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUNBWnNpRnVjK2Q4WWVENUVyS3pBNzU0bm1obXJUUlhTc3NvWGNibmlKVUdX?=
 =?utf-8?B?di9kdGJzZVBlbVZ0bEh6V2pSZ0FRamxhdjFvRFp2UXlQYzEyQVZSUm02Z1JI?=
 =?utf-8?B?QmxIdGd6STRhdXptV3BQa05jNDF2TWJ6TmF4ekh0WEpKb3NncC9FTEgzbisz?=
 =?utf-8?B?REhmdmo5TXZOdlkvWVB1YXlxQ0lhZnRHME5hbjFjNk83QzFHR0ZuOVVqUVVq?=
 =?utf-8?B?bkpkU082OURtckc1NHdtL0RNc1l0VW1iZ08xWlEreUhJdWhlMCtYV05iTkY3?=
 =?utf-8?B?VW9XZnlLOFZFRm9PNlZETlhxbXNqUmNsb1JETWtJaXhzQ0dJUDcweTl6VW9k?=
 =?utf-8?B?dnEzbDhnLzJOaFR6OFBMZW1Zbk1WS0JndXRhcFhaZ2J3eklGNnRzdUZQTkRM?=
 =?utf-8?B?V21nMWFKaVNzNkZFcmNtcmoxVVVBZFJ3UkprZm9lbjJSYzl0dGsxR0taclFT?=
 =?utf-8?B?TlFPYnJVTjk1cWNOOTQ5TktUalNjendyT0oxOGZIMFk5VGpJcTQ1QzZKR3dT?=
 =?utf-8?B?NWw0Z2JmUlFUUkErUTRnSzdJa0tMMVZFTzRFdXJvNjVRclJHenZaUDlGNjNz?=
 =?utf-8?B?cWtOQmkrVzk2djN6MkxvRXA0QWhvTFA2NHF6a1hUNkE3bnRiUWRzb0t2bGxK?=
 =?utf-8?B?bTFTZ1dETEk4RlZiUElFTTF3Qkk2MzJ0eDQ0RDZicmNsVnBUa2l0d3k3MlZ6?=
 =?utf-8?B?QUhMd054WnBxOHp0TTRSQ0JURmFPNEZ4VXN5R0NYRmlVaXlHWVp5eUNPUUtY?=
 =?utf-8?B?R1JGZUVIMzRjcGxBZHRqSzN5MXJheUpZSXNqekdReHBzUjJQeHdNNStxQ3hF?=
 =?utf-8?B?Znc4RWdJaDk0US9CakpMT2tnVVM1TzdRVlVsckRZb3hPM21HeW1nMnYwOTcv?=
 =?utf-8?B?QytJY1NqRGs2K2szOFZ4UCsvcWRDY09FQy9xa2hFanladFNGNHV0OGpZb3RT?=
 =?utf-8?B?VnFHQmtmdDFXaWlzN2w2Z0NmUzJoNDJWREhsWm5DRHEySkZvbmRFd3NKd0dP?=
 =?utf-8?B?WnhQNGZCRnVsS2orVzdCT29pME1tQU5rNTRFelJlVFZ6Q1kwdEtLTWVOZzN6?=
 =?utf-8?B?N2IzQW1hWWJCeXAxL0VIelF2NFRPeGd4cDlqTzZZc2k4b05LSnI1eWR2TFox?=
 =?utf-8?B?dVQ1eGU3NGRLZDRqbWlMS2J2TStjYmF6ZGM2R1BnZ0U2eWJIL3Z3ckhYb0NX?=
 =?utf-8?B?b3Y4amJtbEl6K2dLUTNVQkpRTVQ1cUlCS0Z1ZzlOTEM5TmtxNEdHbjlISjA5?=
 =?utf-8?B?RmpIQ291WEVIbndiZ28zMnFHWlZ6UCtFanNycXV4OTFHQ0xSSUtUTnluN3hv?=
 =?utf-8?B?Q2RScVQweVJObDJLMXpldzBoYVB0bjVWcHhiUVBpaVNYdmpocGVCMGVSd00x?=
 =?utf-8?B?UHBzRW5VLyticVlYdmZ3QThldmU2ZjZYVUwvNjBvQkRIaXlMMkFPS29uazcw?=
 =?utf-8?B?aXVtaExXRm1maGtmUndRTjRrR3ovSWlQOUdYYldFY3lqeXdpYmVuTGZVTlc1?=
 =?utf-8?B?eVZsRkl5Z1FuMVIxeFlZWG5nVjNpUXZIbnBHdERkTGpmZDc5aGhTV3gvQitu?=
 =?utf-8?B?czc4YUlZMSszWHVwODEzZmsva3lzS3doQzBvVEFSSTBmbWxvbnFDdEtyUzAw?=
 =?utf-8?B?cEFzdC90Q0x5ajB0dk05VXJyQTlWSTFXWkRkVFlMQmY5cWc3bUlsQUZrZkQw?=
 =?utf-8?B?cGNFdERROFQ2VkwwZmFMVzExTFg1eFZaUXFjek1DaHY4WnEwVUtXNGZLaTk0?=
 =?utf-8?B?NVByV1lwODkySzFMWDY1WTUwOTJTMG44N21vYmRicWxjdHJvMFpJMmFoUGxB?=
 =?utf-8?B?NWlzMmtHdWtwRjgvK1U1Vkx5NUwvTXVJQTRXSDFIcHl4Wm5BWVRaaXY0OFFE?=
 =?utf-8?B?VG9TL3JXOVNUdWovd21uRWVvczRQNlNRWU14aVZDRWVzQ3FEWDk2cmVzK1Vs?=
 =?utf-8?Q?aoG0veE2/3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTJNcHM2eG1xdjAxOXZTMGp5c2w2bnZlZE1VNkd5bDVHNExnQVBlenZHakE2?=
 =?utf-8?B?d2xqbWl6M1Z6M3RSaXFUNi9RbFYyQUVtdk12aEx2cEFNbWlMb0tFUmVrZVNE?=
 =?utf-8?B?M2psVWMwWENZZ1VoM2pwZVJLZFYxemUwYndsYkpTeC9objFsTlNLVFhrY3o2?=
 =?utf-8?B?YTQydE82Q0ZMMjBqa3hEcGxhQTRYZVd0TmQxQURKQ0pwVTNMZUxnM2NsRGdZ?=
 =?utf-8?B?a1M5aHhlSDB5OVIybUVxM2lFL0UxekFuVWRDaU1NZjJUbEFIc1RJSkExdzVM?=
 =?utf-8?B?QWZZbkgxMkhkNERRVDhSWDIvSXNJdytVSVBrU2VKamw5NWloeGs0TUhTMXh6?=
 =?utf-8?B?YlNZYTB4NGx3OUFDNGd5c3pidW9LZ1NzbUhRcVdBUEN4YVdObkt1VkFqR0dh?=
 =?utf-8?B?d1paT2xPa0laeGgxMUFMdVFvODl6MXIza2VHcktFYlVtcGZyTXN3N3I0OS9r?=
 =?utf-8?B?T1hsMFAreVBnTzk1c1ZTNlhlaEo4K20wemhtSlIxQjM3WXRwTGJFZXlkTlZJ?=
 =?utf-8?B?K09hQ0pOTGp3VjMxK3lqUlQ3L0tSc2pJUUd0cDJ2UFFGTE5KZ1VNZjhENFVX?=
 =?utf-8?B?cUYrZ1NlZUVwcjArRUdoTjgweHZkeGdsbFhjMGpKZVY4Q3BOV1ZsMmRDbW9n?=
 =?utf-8?B?aXpxRk1FUFplakg0TVVxYlNZeEZFcWc2dDdJR1BmTUIvb0JOaFpzMEZRUDQ2?=
 =?utf-8?B?NmRPcEpCQzJjN0wyc2I5ZWN6Nk5ZaExZa3g1Rk1LYWFvWHk0NFI5ZSsyL092?=
 =?utf-8?B?QmdkM1BNSHY3SFNRdExNbE51b2tWZUJ4N2VyNGdzMkZVNEREdXpaZUJNMC9l?=
 =?utf-8?B?WlFRQ2JQTVpaQysxT3FCbTBDUlpyTlBlcVlOQktyN3had2kxTmt5VFNMb2lx?=
 =?utf-8?B?aTBiVnVIREp4em5jTDBrdFFTZDZSdmthNVdzOE5tRTQwREpXTXpTWENBSmMr?=
 =?utf-8?B?ZncrVyt0dFA1amNCZU45ZVh2S1A0VTllK2pOaXdJVzlBc2lrTnRLeHFYWFZj?=
 =?utf-8?B?U2tialpXK2RzQ3AvTk10RklzWXdzWU9pbUxNWlVGTDlpMUswVnFKVVB1UVN4?=
 =?utf-8?B?TWlpSWtGOXZkL05LTkpVMVNuWUdaQW9RODVpZTVxYzdpSDZXdTYrbFVkdU52?=
 =?utf-8?B?V0VPY3d2L1g1Yi9xN25MQTJ5WFZUNm9LUnlFK3Z5ZDVvWEh6aHdkajVWdm9K?=
 =?utf-8?B?anY1a010bnVoajg0UVZQRlhlUFZGVDV4eERCMGxFVW5OQy9wemVXeFQrZ2JQ?=
 =?utf-8?B?dGpqYU5XSGduYWNlKzZJYTN6b0pwamV3eDhVSlgrcGkzbVArSUNqamIwSExi?=
 =?utf-8?B?c1dmZTJrZEovcVFJVHpwa3MrMkNxaWtpUGN3N1hKeXE0aEJ5N0ZLaldyYzRW?=
 =?utf-8?B?aWl2TmF0eFROSVFNY2JKSEpMVm03QUFsS1IvUnk2WlRNbkZraDBLTXhPTy8w?=
 =?utf-8?B?WEVrYm10TzY3aXM5RTdLTDlVU2V1VWwxNG85ZDZoa0xBcGZldzNVREZrVW40?=
 =?utf-8?B?N2lPT3FNZm0vNFVDZ3VIdS9FbHc1WnNsREV6Tmt5bE8ySy90TGNkYjJ3Z2Ex?=
 =?utf-8?B?NjNvZ0tiUGVxalltcXZMdTlUTFRTYkdkaTJqK0F4aitTL1h2QkNLMTRyUFkw?=
 =?utf-8?B?VTNuenNncExGcTB0V2RxeVA0T1ptZVU3cEt2Mkl4aVdmMUxUeU9zak40cWNB?=
 =?utf-8?B?WVM4dFFNRlVZelMzQTlSTHdPNUpnc1lDVlVBdFp2S05oRHhaYkxreDlvbUZZ?=
 =?utf-8?B?djJsbXBFQlZDKzNlVVFnMWd6TWVnbkRNVnVDcUM2TVlVMVR6UEhqQjdHOGZQ?=
 =?utf-8?B?ZGZjanZQUFVJejBmWW5rcFFVOU1PS3pSNHgxQ1gxdVFSNkdydFNyczMzRGJ5?=
 =?utf-8?B?TDlUT0RZU0gyRHg2WVJ3YWRSZkxPdHAwcVV3SktTcUluditYclZCeXdtYUJ6?=
 =?utf-8?B?UHJMbVNaQ05EVm9zZ0VSR0FSNzFIc0N4d0VpMWFDOFVqRTNEVllBT2pwZG9H?=
 =?utf-8?B?bG1kMDUwMEZ6NkZIM0luVFpjTkYyaldHYUN3ZzJ5cE9td051cVMwZkg0ajVM?=
 =?utf-8?B?SjJBbUhRVGpyZy9GaEtxWW9nb0pKTm1vU1QwUVRmcStDMmdoWmdsTVVJWTdi?=
 =?utf-8?B?YnJWK1ZqMzI1RVMyeHNZeC96dzJkN0pjYUszdmZzOHUyZ3FqUkFRMkZITE5z?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eeffd37-5f7e-4a83-138f-08dd9d255abb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:49:52.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQsPNxSKsm2gSu0s8mCeXq1Fxx+3ceg+4K8wUFtPoy0/A19iGhCBLvUMMVF4r9COdYcFtgytLM1JincNA4RMXoa2fUhxx+tfZ1HuV9ZNnh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
X-OriginatorOrg: intel.com

From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 20 May 2025 13:59:01 -0700

> Alexander Lobakin says:
> 
> Time to add XDP helpers infra to libeth to greatly simplify adding
> XDP to idpf and iavf, as well as improve and extend XDP in ice and
> i40e. Any vendor is free to reuse helpers. If this happens, I'm fine
> with moving the folder of out intel/.

I hope it wasn't overlooked and maybe will squeeze into...

Thanks,
Olek

