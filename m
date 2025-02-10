Return-Path: <bpf+bounces-50997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD841A2F279
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6601625E8
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1FB2451EA;
	Mon, 10 Feb 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nynmeA/K"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743032441AD;
	Mon, 10 Feb 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203481; cv=fail; b=kMsZe60ast34j6aDtvJ9lqd+Gl4hTT8TkZA4vHA5OGwyeC+UHnhncvwq6TZbq+aCT+54hbYT9th3jT2TTAgZoRINaYM+hh9lvxF4CRD+EGrL7bDiOTC4OOrd9+TITAol04J8dm5fXgbQdxcYA//5GJ0qF7E5w93bmGjisZlVzKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203481; c=relaxed/simple;
	bh=t8/q4/JhKXMuw4G4fD/N5wOFIoCfRnd3EsRaBlQXd68=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jAnF8hKZOjn8+dIUjqNyEOvWPzR6J2eu0uOXl7/TtMG4XGiV++biPyTjyt+/QwJq+e46eIZ0vAmvoNfMh+T331CWR0iGfnUeq70QXcBpD+D0GCpHJZ4mx2K8L6WuHzfvmgf0bASTvkCOzFbck5PRQeWuPMLCr8ODxHbuS4jVyAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nynmeA/K; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739203480; x=1770739480;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t8/q4/JhKXMuw4G4fD/N5wOFIoCfRnd3EsRaBlQXd68=;
  b=nynmeA/KAIcwDns9SQMw6rvMzSKLAz0Zn0/3yT3utcEGsR+f0OXzDm/b
   M5k5sGXHvJDlAYzJxQ9xz0aC2Av7BdetlN11OuLMgfqQtJS/otiLQ+GtR
   fVL1j7oVo4sWxsjNcorE+u/xLCwY2F5DIFp7cMkOah44GrSitVLcWxB2C
   X4CGHVDB5qeFlUJe9//5EEU9GUyXT1mCUwpmvoLTjv7QnodsYonrVld9p
   RR2W0hXTwOVLDhTraUGWM2eVDgaUaWxJ1NMI94BKq1MH0eglQHscXJ/NZ
   7rO032wD8Vd83wlUzN4hYNHp1X4Sl82GiovfTKBzrdFcMWnXfWSlS7Mp3
   Q==;
X-CSE-ConnectionGUID: QqYXi2qmTJCDPmOg4j/OEg==
X-CSE-MsgGUID: gobor0pYRSmxiCadIA7PyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57203417"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="57203417"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 08:04:39 -0800
X-CSE-ConnectionGUID: vA+PE5ezSTmvuH1YHQAKTw==
X-CSE-MsgGUID: m+DdNsdNSZylIw9axV4JTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135487219"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 08:04:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 08:04:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 08:04:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 08:04:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8YTC9cGO5KWnxZebzD50TA9zxuz3orISYplmxW5Ldwe3Iw7Q851rgcZDIZLSO+UhMZYNvMQAQoaxW3I0x6izHZN7iJGRKIYkeShrSkMIrD6TwEbHI6D80to3+j7ij+57hs8mxcZB+WzS2lWfgauiG+KQqPsZY3NjXsNT1VEdQtS0Tur1ev74k+voDBGp2DzAkfzhNeLC7ase9bDMAjSD94CscW4WBTw1LMZgRCBcJQi8u9K60oSF3X5deWcBat0/fI9PnzRV6avrQeB+h503Jbchi5a8KXjaI2XQp5orVhRItZn0SzhhNYsRUrqMefKQellOw9/M0XuUf5tw7m6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1awoWwxc4FAQOM0T20WrmK+ngMNlY6/YpKDOTxkB7Y=;
 b=bSV/ZYB3VBu7yOf+11y1Ph9P80BAp2yOW7IAv3GEOfOHkWyvFIkGAgIuw8fPEPPpvpkvEwKLrNtBBQ+DCFqVBSey3cGryhbhELejkjNtdLiNowpmB8Hj+7aGKq/nW6TGv+FuUJQJI1KiWHCzu0EueRnW19TIDFpLI/2aUqau+iGhRJH+umDcUQIu8TACLcXvFc4JsSovBVq4fQYiCmoaZOTolgwUpwuKHV9UGDPUU3oMhy0HdKuwqHXs5wYsrufvae6wyyS2BeuvgcQUJKjGEoo6wUc7l1B5qkLjbC2HSYSuwIiVFLFFAzNdheEraUNs9YMVMlpIgamVY6Zje3nSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB8378.namprd11.prod.outlook.com (2603:10b6:208:48e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:04:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:04:31 +0000
Message-ID: <6d247107-5a9a-4ac7-8364-2619fce0c310@intel.com>
Date: Mon, 10 Feb 2025 17:00:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] xsk: add helper to get &xdp_desc's DMA and
 meta pointer in one go
To: Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
 <20250206182630.3914318-5-aleksander.lobakin@intel.com>
 <20250209110344.GA554665@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250209110344.GA554665@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::40) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: c221a50b-c347-4723-dea3-08dd49ec9ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3BENEd4QzVST0hVMko5MW03RUdEemVzNDdTWGxTY0tmTENISEFwT0pldUNP?=
 =?utf-8?B?bnRCbWd6bmorSU85d0g1eE9tVkgrVG1MWFZsMUpsbUJsR0JUcFJ3eGk0L1Zi?=
 =?utf-8?B?dERmWFcwdlV5MmhQQTJBaVE2dVlPSnpYZGNCb29SdmJqMUFObWJJV2JGRHdt?=
 =?utf-8?B?Mi9id2grdTJmN1pRYzRDTzl3MU9rTDVkSWJDQUpBcGxUWjlXVTVyOWZDRDJU?=
 =?utf-8?B?aFlJTytFK0FTMHBHekdlTnJRUW5pNWt3aHNvVFduT2NoSFI1NXdiaFp1c1JK?=
 =?utf-8?B?MUt0V1lFNVcwLzRraC9DNHE2UWVQVkpDamhFWDlpUk5TOGpHTDJrTnNPblIr?=
 =?utf-8?B?YTRLVFhXVXEvU29jNGErM0p2S25jRnFRbndYNE44aHlsaDNndk9qY2hhRUpp?=
 =?utf-8?B?OXJtZTQ3YVNFYkUvME90dStoOHA5SFVIQzBtY1kyRnV3L0dzcFNwTE1ta01U?=
 =?utf-8?B?cmlPbTRGeFl1Z2xLZ0xTTnhZNGZ0VHArTUNhcm9NUEVYZDJvclo4am95V3I1?=
 =?utf-8?B?SWt5dWlmckltcXhwa1ZhNjNwQ2JPZWtIYWhYRFJQZGJjeUo3eW9sSVdWdUJS?=
 =?utf-8?B?VDJMaFNlTUpNWjBPdkQrNkUxSmFKQzZxV1dZODUxRng2eGJjdTN3US83Ukhj?=
 =?utf-8?B?ZzNhVnJ5eVhubUdwWHhKcUZGd0FqbGQyYlo0V1VmTnVKZXNoM2RvSHlMamFX?=
 =?utf-8?B?d2tXVHc3SWpmcjJOa3Azb09td2dPTldxWmI4UXpvc1Q1ZG1jQm54NDVjSUF0?=
 =?utf-8?B?M2JYVXRCVDJISlhWc3lvY2xjWnJnUzhKUE1NQXI2R1RZMVloNUk2UkEwVDgx?=
 =?utf-8?B?QXd2RjZ3Tk10akwvMzBDY0w5RnpEYmE5YjlOT29iQmUrdmczVlFINmNGODBq?=
 =?utf-8?B?V2lLWERoM21JSkphcTFURGdQU2RlVVRxYWllQW9jT2NtaHBzdloreitYTWxC?=
 =?utf-8?B?Q0Z2RGNrNGcvQ0xER0tZd2hmdkNHVDNxbUZROVQ1OEl1L0VjWk12V0hRbnRo?=
 =?utf-8?B?N3FUcjRoZWo0bUtXaEdJbjE2Wk9jc05La29ERFo0ZWlET0czUVlpcHdROGRn?=
 =?utf-8?B?bUl6Y0Z0ODJ2N3RPeDBpTzBES0drdFRacEVtTVgyVHFkWVM4OUZ1OCtUQXpr?=
 =?utf-8?B?N2FobzM2bDFiK2tMckExSzJtWVhSQlhmQmFCZGhndzEvRUIvTm1xZmNTbHFN?=
 =?utf-8?B?UnFUZURJN1J3b2Z6bWYzRkg1cWlqcndpOTV3YktjRjdJWlk0ejBDeVBMbDM0?=
 =?utf-8?B?YjJkK3BIZDFRcVExcWZoaDVYaGlLTmRvNWNaTVJBcnU2WTVlanJNODJnTklM?=
 =?utf-8?B?VnhBQVRySTFDWEt1N2Z1ZGtvU3I5dTljaEdlUElvMTF4MEFCQnBMQmpJU2Jp?=
 =?utf-8?B?cFpwZGhjMVRacGJVcE5hMEtFOHlGYU1PUXVsVjFUc3gyd3c3eDk5ekFHbmJE?=
 =?utf-8?B?TUNvTzRJakFyQTFRUlI3L2xiTEtNYWN0SnNJNU1GMGVWdUpocktOZFhnbi9D?=
 =?utf-8?B?aWhvRENvSi8wdHN6b01BVkpHYm9QOTdLMWRkWVczdFU5ejNVdHRVZS9jNlRS?=
 =?utf-8?B?SkRTdTlHM3BWVlNuSTZyWU5QSlp5N0Z3enkrRFJ5Vk9SOGE3Skd3Mk1nUVFz?=
 =?utf-8?B?cnB1cnJibERpM3V0Vm8vRm41Nk02MnF6TFVRNzVQUnF1SkFnOW0veVZMVnQ4?=
 =?utf-8?B?NlkzWDlPLzZLc1dRTnF4M0NDZEJnSVNsS2lYNGNrSHhHYmpQSENXTGRHL0d4?=
 =?utf-8?B?Q3plTENMdHlqRElidXRTak5oV1ZjWldKcmRZK2pIU0RWaklwVDI5Zkl0SHpv?=
 =?utf-8?B?SzNkUU5yZ25MT1lYOEdRQnlmSHhKUzY3eWlIY2F6dHNGWlFBeGFUYjMwWXRZ?=
 =?utf-8?Q?oW2Ou0thomrfC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVpUUZTazRDVncrc2dmb0ZNdEE4akJndFBIL0wwMzB3S1BKYVlad3QyN2o1?=
 =?utf-8?B?QklzU1VHaEozNU9aaTF3L1M3TnlKTHE2QjBpSGY4MzBuODNWN0xCMG4zWnQx?=
 =?utf-8?B?L1JabS8xenR3eXdSa29QNkl1QmNJRTF6ZVFYUkFrQVR5STBzM0JZMHRhVXlP?=
 =?utf-8?B?UkNUOVJFQlRKTzVsQXNOSnExSmNDYU83ZklsRFk5d08xVlFUdEdraVVvS2Za?=
 =?utf-8?B?REFvanJRc1lZY3d4TjFKOVhuYWVlNGEwY2FIay9kRFR6WjJoTWZMQ3U2Z3kw?=
 =?utf-8?B?Q1dCZU9QdUZkMzRaNk9WNkt6N29oY2ZoQjNsOW5QeTBYRUlNYStMTkliazdP?=
 =?utf-8?B?SUpBVXI5MEFXNUw5aHpmK0tPK240eW1yVXduaHhaZkdNUHltcUs4TVNzZjFB?=
 =?utf-8?B?ZFZObWZoSVBmS2x6WnNCVkVYQzZMN1ZNQTM5UTRDK3VDdFNSMzVmQWRDeExC?=
 =?utf-8?B?cHIyZTRXRldVZk1PazhwbVZrRjRaQ1g3UGRRZ2NtemE4SHFSWXdRY05FU3hh?=
 =?utf-8?B?ajNlMUp3OVVCRkI5bDFQT0ozYVd6cEg1cFl4Q1dxQXdaU1VlZzg3M1QrM1Ay?=
 =?utf-8?B?OElqcm00Q3IweE1IMkZ4dGVUSmN4eTYraUFaWElERHRFUmZpazduRG51TTZ1?=
 =?utf-8?B?Nm4wZ01zSXRRZGpDTGF2bEdQVXg3SkNmQUpHYUhqbzVVdHBhanFENk14WEsx?=
 =?utf-8?B?aFFzNHI4TFNEVC9kdHV4czE1UDRPRGFiNXo2cDFPYkZEOC90M0Q5dlUwVTVB?=
 =?utf-8?B?ejU1SHNxd1NQdFRSTm9KMkZCVmZkWnRUbkt2MW9vVis2NXRPeTRqWDNJS2dV?=
 =?utf-8?B?bWVOelJ1S2FrancvUEswa3JSNEduMGtacWtMUXdnaDFwMENuQmFjZDlsUHZY?=
 =?utf-8?B?aVVkdmdwbHBQSUZRdk8zOEpBbENQdVVNRDBJQ2ZwdHoyelIyZ1czVHo3ME1E?=
 =?utf-8?B?ZVVZamNRVUczMDlvNEZSSytNay8rdE5LTXNzemE4Z0wyNm15UitaODFPQVF3?=
 =?utf-8?B?L3ZzUmlyZ2VmUnlSRWQzcHM3VldqMjV5dzA5TWZ3UkhSMisrWW5DSlQ3cHdi?=
 =?utf-8?B?VnZVN0hFRkhJbXR1OFBtMHpxbUJITFpmaDk5bkpNZ2lKQndwamRZUHAzcjh1?=
 =?utf-8?B?eVJhUGw3SzV4WXdBbnhhTDNQaWRqZThrZnA4WjlmdTQ2UHJTQk5pWnlYNkpx?=
 =?utf-8?B?a0RhWmlBYTcrdUF0TlhzTEJkKzBSa1BTY3AxcGZMSXFiUmZYSDR2V0tFeWsz?=
 =?utf-8?B?cExLMldRRitFam5XM3o0Z3R1M0pyUlljeXdCT0ozRisvd0s4MU44ZmhVbUtV?=
 =?utf-8?B?Tk5ERnRwRWY5dTBqY0dtU2lCQzNnOU5rM1QxeXkxMXNJRkZHWkt0SW5RZ3BP?=
 =?utf-8?B?a0MwbkwzRXNqcklYbFZQTmRKcEdZYkZHZkErbXZxZkFVVXprb044aDlzRmVY?=
 =?utf-8?B?azZpWm16UGppc2tHbHU1MjRFNEI5NVZSQWk5UHBVVGtpQ1NIcjIvUi9RcmVJ?=
 =?utf-8?B?KzlqNVlub1BTYmFidkFTMjM1MVhMbzE1WC9yN1BkTnBLS1BWUmJHaERzL2l2?=
 =?utf-8?B?Q0plbU5qaHNOYWdmMU1WWURuVEYweWp2bXRmdzhVcmlRZ3lIUXJ2TDZ6VWFx?=
 =?utf-8?B?RnVyWXN2blU4bUErTmprZ3ZYdGJQK3JFa0VBTzlDcE9qckxZWkpXZ1FOcDQ2?=
 =?utf-8?B?YWRib2tsa3VMRFFrNVoxNGZzckhJVjNKZEQzL2FselU2YWFHZXhRVjN3WW9V?=
 =?utf-8?B?OWg3MmNJend6ejhvRTVkazdPZjk5SERYOUIzcGZldk1iRjlNVVVMRkMvYUtH?=
 =?utf-8?B?SGhJanI3dTdqQjhDOXpYWGJwS2U1dnpFTk1VSlB5VEtqM204ak9zVXpkSVcz?=
 =?utf-8?B?RUliUkQ4VStNTjZzMjdkZzFFQ1lDQmtUUHF3OGcwUm90Y1pqanBIYXJwVWw3?=
 =?utf-8?B?RGxSa3BSUk5ydlhML0FTY3lhYTRXOEtMSC83b3NuS3J2ZEQyaUYxUE1aRmNZ?=
 =?utf-8?B?T2w0Qm5EMHA3ejNPVlVsK0x4Q3dlcG44QUVGVDdkc2RrbC9ZSk4vZEFNdFZW?=
 =?utf-8?B?dFhIckFFdUViSjhUWWQ3S2xNTWZWaGF3SUhOekpXeGo3T0V4REVweUVFWVNs?=
 =?utf-8?B?NVp5M0pZM2tWSHQ1bGY3Q2pBQXNTckMvQ3N5RGZqc2dWcGlzWXhya3kwR253?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c221a50b-c347-4723-dea3-08dd49ec9ac4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:04:31.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2n+NqR650mnX43yBYnVdvegfyACnMsGDp+wwQmhyl2fpwM3Tlj4S3Jowr479H4fBuvpD4jC8d8VnPcvr6WZu6hdnMNgK0I+tpwfu/saVRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8378
X-OriginatorOrg: intel.com

From: Simon Horman <horms@kernel.org>
Date: Sun, 9 Feb 2025 11:03:44 +0000

> On Thu, Feb 06, 2025 at 07:26:29PM +0100, Alexander Lobakin wrote:
>> Currently, when your driver supports XSk Tx metadata and you want to
>> send an XSk frame, you need to do the following:
>>
>> * call external xsk_buff_raw_get_dma();
>> * call inline xsk_buff_get_metadata(), which calls external
>>   xsk_buff_raw_get_data() and then do some inline checks.
>>
>> This effectively means that the following piece:
>>
>> addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
>>
>> is done twice per frame, plus you have 2 external calls per frame, plus
>> this:
>>
>> 	meta = pool->addrs + addr - pool->tx_metadata_len;
>> 	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
>>
>> is always inlined, even if there's no meta or it's invalid.
>>
>> Add xsk_buff_raw_get_ctx() (xp_raw_get_ctx() to be precise) to do that
>> in one go. It returns a small structure with 2 fields: DMA address,
>> filled unconditionally, and metadata pointer, non-NULL only if it's
>> present and valid. The address correction is performed only once and
>> you also have only 1 external call per XSk frame, which does all the
>> calculations and checks outside of your hotpath. You only need to
>> check `if (ctx.meta)` for the metadata presence.
>> To not copy any existing code, derive address correction and getting
>> virtual and DMA address into small helpers. bloat-o-meter reports no
>> object code changes for the existing functionality.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Hi Alexander,
> 
> I think that this patch needs to be accompanied by at least one
> patch that uses xsk_buff_raw_get_ctx() in a driver.

This mini-series is the final part of my Chapter III, which was all
about prereqs in order to add libeth_xdp and then XDP for idpf.
This helper will be used in the next series (Chapter IV) I'll send once
this lands.

> 
> Also, as this seems to be an optimisation, some performance data would
> be nice too.

-1 Kb of object code which has an unrolled-by-8 loop which used this
function each iteration. I don't remember the perf numbers since it was
a year ago and since then I've been using this helper only, but it was
something around a couple procent (which is several hundred Kpps when it
comes to XSk).

> 
> Which brings me to my last point. I'd always understood that
> returning a struct was discouraged due to performance implications.

Rather stack usage, not perf implications. Compound returns are used
heavily throughout the kernel code when sizeof(result) <= 16 bytes.
Here it's also 16 bytes. Just the same as one __u128. Plus this function
doesn't recurse, so the stack won't blow up.

> Perhaps that information is out of date, doesn't apply because
> the returned struct is so small in this case, or just plain wrong.
> But I'd appreciate it if you could add some colour to this.

Moreover, the function is global, not inline, so passing a pointer here
instead of returning a struct may even behave worse in this case.

(and we'll save basically only 8 bytes on the stack, which I don't
 believe is worth it).

Thanks,
Olek

