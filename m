Return-Path: <bpf+bounces-62695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F0AFCFCF
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 17:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA68482916
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CAD2E2654;
	Tue,  8 Jul 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4riQ1aD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DE221D87;
	Tue,  8 Jul 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990150; cv=fail; b=vEVFvKYnRmxvCry6xGSaDzFoxapgZZcs3U3cpe+J54L3vyQb/A1x8gD2pnHNcmS9fWM1WTZ1txpKtllzIEG7tnBnfMh+2fMR83HM2zdD0QpdR0VDvsHQqhszkGEu79Huzl5ofER3+b8u+uxMiVkyUQQ4enfVS57feck8+sPjltw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990150; c=relaxed/simple;
	bh=dczJPnRoH+yt4Q+pV6wr1C45IyW3HdpwtUnLzwsWyZw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnotKCF0yrYaB8UaXywZRAy7EzL/jpjAnfWhpztZnX3Hh8UFCwmlZIiLisyXPYi/W4xav1s71siB8WHNzB05eKvxV6e6mF1xuFP5WjCueW430OYwrvBrToLShZI1/5tP2SnfYBVe50GTnbAObDHQHfinexxHzdBAgq/xBzgcqxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4riQ1aD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751990148; x=1783526148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dczJPnRoH+yt4Q+pV6wr1C45IyW3HdpwtUnLzwsWyZw=;
  b=l4riQ1aD2nQKY87xABcDGXwKPKcLjYNe49uBYmh18Mj/kpd0TauOJut9
   Hhd0WD0qvcWWz02YoxW0X5Lpk8gho6deefEy+q/yfZI3AsvXf3pcgQnNY
   OhErkbXh+9425tzRnAM+PZ2U9oMWAltMbs1TfoyD89BXQlfii8Ong2JDZ
   1VUBQAIQpTfD8NDK/zA8v8cHVhOCZb666/cr7L0/qI1mRWXPCBrsE78F7
   T5cifwDQ8ra1wG91qL2MlKMASXQlw02q8vN99l9zCIY8MYSDgiyfyOlO2
   8qAtJ2KgdkjfpEW5QqSgxYw1zEgx+gYM6m1fmpfeF1M85XQDDd7o6BK2j
   A==;
X-CSE-ConnectionGUID: jPNoIFUNS9eI8IlqK+O/0A==
X-CSE-MsgGUID: MjpzaloxQXSSSHjCVVAxCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79668760"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="79668760"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 08:55:47 -0700
X-CSE-ConnectionGUID: Qiznk/sOQfmj/yQC443s1A==
X-CSE-MsgGUID: cjhH9u8dQ36Kx6+haO/vMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="156275838"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 08:55:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 08:55:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 08:55:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 08:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LP8r/EivUj4ET6bs016KB2G6gBNFE+4jSm5ULC7MGRH7jVLI/lXB2HnUsisEG7yvDRqt+bxrvE7CPgC2BHEocIWmBBqdIaGkFmSeogiazQE8ovXfGIadwC+W82MTAZgUJWHOyQVYFgdunAd12vPPA1R6HqhMKxj0EgbLbva1b3QZq2MNaF99Azi+zapjTh4Zy4vEW2kcWJtisY2NBAZeEP9TtLweU1/SHBAnlcu+ZuOt5t6QjIBYmwANDJknP76DrtNjAEcF4lmHBxLPOz0xPw4W5wHMh3R/jmzLma0PNMtA7Lw+jSEz9Nftuk6ZOvGSyqgUEJxstHjeJ0Ssf6Gs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFIE9xbncNvQynP1riFypDHhWaf3HOBYHfCKrHLxO8E=;
 b=LW6Fss8vDqEuPwPawJo+ADLme8N8mV8tw6UFSVOn44L2uozFdGW0IrhYpuJmmyNZjeELJt3AOM7asV01SWsWd+8bV9kQkNKRbwCcpqvUbPQx8vyBORYyReCMPBppprwy3qj4DP/bVOnoRDYGTh+CfIta+0UlbsjTxF77YSn2ZqREwCPLFMUWntwycI7gQhoJNqEtMPuwSNDkJCfg021JmrPTylaolJbYfe/dx+q18VV2ps3K4lNCmRjfwN7ijxw2Vq3LbOGc9bK9DdjJTmBEgHiGWpFGghXvmKy1uDStD3OtyWDc8/4dqD99wM7yEM8at2s29gvun0THYD80ljGRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB5230.namprd11.prod.outlook.com (2603:10b6:5:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 15:55:44 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:55:44 +0000
Message-ID: <beaab8ec-d11a-4147-b7f4-487a4c3fe45b@intel.com>
Date: Tue, 8 Jul 2025 17:54:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
References: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
 <d0e7fe46-1b9d-4228-bb0f-358e8360ee7b@intel.com> <aGvibV5TkUBEmdWV@mini-arch>
 <a113fe79-fa76-4952-81e4-f011147de8a3@intel.com> <aGwUsDK0u3vegaYq@mini-arch>
 <aG0nz2W/rBIbB7Bl@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <aG0nz2W/rBIbB7Bl@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::24) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB5230:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a4bc7e-a303-465b-1222-08ddbe37e557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmZrTkpES09zM0JYb2tYckFHeGRuM2RZYS9TYzlGa2F2VTlRaHBMZnN2SURl?=
 =?utf-8?B?WXU4QXpndG43Qmw1NjkrNGxxRWNPRmprNmt3S2pESHhhNE1PNW1PTkpMTVVO?=
 =?utf-8?B?Q0RabzI3a0lndWRPdzZZZnpYN2JRbnBQa0ZFN1AvZ3FUdWlJOW1kSUM2TzF6?=
 =?utf-8?B?K0tzOElRU1R0Rk1GVEhyK2p3SjNtQlNyOXJ6TDFxVENkWERwS3k5QzZ5VnZP?=
 =?utf-8?B?dWNPYzlMaFVmWktuM0tHSmJxZGFHTzdBaHhPZU5lQlV6anBQKzgvMXh6bTlX?=
 =?utf-8?B?UU1hM1FZVmczSFRETUMvb09SYTdKMTlTbEtXMzlIRWlRcUdkYXUxNGU1U0Y5?=
 =?utf-8?B?WW43M3IybDQ3dkhKVlRpSkNYMWRIRVBqTEhHRURtTkxXR1loZEQxNDhuQXJv?=
 =?utf-8?B?VktZQk10VEVwNHFhVGw4UlBZcWFmMHhOWHZYa0Z5YlVWdkI4YWhPb2xXSS9p?=
 =?utf-8?B?N3k3Y2N5endiSjBwZkYrb1FjT1IvTnVXSDRhZnc1eE00V0ROaDNLUmt4MVlK?=
 =?utf-8?B?L3B5QjkrZW5JSmVxV3JGaEpGNDJIWjJVSG9ZUTBYV3dWNDdSVFJWdlJhWDNZ?=
 =?utf-8?B?UXhleVlRdkZOYUNnc05vRUxncjhrSVpCWkJDckJpOVMzcWgybFg2TjhWUUJP?=
 =?utf-8?B?STdkelRkWkFZYlM4K1lhYmN0QmlBcVM5V0ExcWVJQytMQ2srbTJaaUFlL1hS?=
 =?utf-8?B?dWpzNG9oTHdtcVZvdDBWbmRyL2M4ZEtYdVJHOW83UzRqb2FHUjVMRnU4bzZ1?=
 =?utf-8?B?eStrcW0xY2g5dDZpK3FSSVFSaDBzMEZLV2liTE5PaFVCbnhnekZCUDNjNjIw?=
 =?utf-8?B?SE00YmR2Q1MvbTBkVVQvV1RidDl6c2YzVnEwdktMUHNDQ1JWL3lyKzRSZDhM?=
 =?utf-8?B?WmlrTU1jUHpGMXZuc3VxcmxTMmhNcEpEaml1U0h6VUlGQUFyKzg5YnN3T3da?=
 =?utf-8?B?SUFxOUZ2ZlZrTHdEcEdaZ3hnd1YxN2NlSjNsMFMrWjlCbTUzdktDZzhOYUEw?=
 =?utf-8?B?ekVOckZJMFNrRGlaZkE0K0F3RlRvMnI2WklFZGNkVDJlR2dwbWlvV0FBNkdJ?=
 =?utf-8?B?THZFNXhneGxxd0tCNmNMWnJ6Zjc0MnN6eDN2dndvdUpFUVkvUkxNaW5YUFhW?=
 =?utf-8?B?UG42WXZ6eG1nREVaSHIvY1p0anE1YS9oK0hpTVpGcXFXTTQ1amlyOXZMNmkw?=
 =?utf-8?B?Y2YxbmZIVElWMzNqUDQ0MTdLSlZMTmNLR3dZNW02Um5KS0xWY29DVkNzVFdT?=
 =?utf-8?B?UkgyVU5MMHBRUVpwMEROaGFOWXp3NzRNbTcwR29sZmkwdUhrRDV1YWhjQU9O?=
 =?utf-8?B?SHBhamhkY3NQeGZHNUZpRFRuQkluRUFHQlNSRFRwMHduZVQxRTNoUFh5b1hx?=
 =?utf-8?B?cys4MlZzUlR3enRmR0w3QUR4RXV6WXVVYmJuam5weWkrNmZ3cHE1WU02WmNW?=
 =?utf-8?B?dXEyQWFZN3hZRTE5RWJ5MmVwRWxSdlJId3hkekZmMGcraTk2d2VESkRCb2d0?=
 =?utf-8?B?dU51dUFuSHpQK1NFcjU3T25jcTIyTTE3QUtmS0NzTEFoTXhyZldxZE44SmF2?=
 =?utf-8?B?VnlMQ28zdk5MUkg0OExlUkxCSlJwc0JUVHk5Y0RTWGF5NjhnUkZUTDh1Vm5n?=
 =?utf-8?B?eTdqTWk4RXZNbW5ibkw0SkNkV3cxUDBCM1h6OEhnTU50aUJzcmFJWWpoNHo0?=
 =?utf-8?B?VVVQdjNQR3NhdDRQUGk2WUo1blh3Q3JXcU1GUzJrM0dxRmttQUNaVU1TY2lq?=
 =?utf-8?B?VkZnYlQ5cENtRGlqTG5pT2JkYzNEaXNybGd0ZWV4RzFBVGRZaEFEOEhzZExo?=
 =?utf-8?B?c2tSUmJHVVQ2QlVNOTdHeTQzRWZIRVc3U1V3RzJDSERCSUNnZHp1ZWhnanUr?=
 =?utf-8?B?dDRHRTlEQjhrczdPQnYwQlVEN1dJanNyT1VVLzZ4YVpmbzhla2FMM1NrYUNS?=
 =?utf-8?Q?0xY5PFJk1vA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUNZUUozMWFiSVE0bWUycm91YTg0OFFhN0h4aUtwb2kxdWRac1pTYkovd2xi?=
 =?utf-8?B?d3hVbTUwQmF4Ryt2ZHYvTTduUkk1bDBoTmJhMllrOEI4ZXhHSmU3dFdCQjkz?=
 =?utf-8?B?bzN2dCsvd01BVktONmJpK0tURmxWanZ3UGtYZGNhZ004UTAwQzl6NjV1OStN?=
 =?utf-8?B?RUx5MkxzdFZXbkd3SVQ0dURxVmtTWWdqNXhhZks2TTR3NVU2N3lXWWdhRmNh?=
 =?utf-8?B?MFNWcjE1L0R3ZEIxcUp3ZThLdUxaVzkzNk1TaFF4dFVkSG1uRjUxeDVLMkw0?=
 =?utf-8?B?N281cjZpdEZEZVZaeExuWm51c2t1VzR3S09Qdit5Nlk1K3RaMnY3ZURPN3Jx?=
 =?utf-8?B?T05yQmVMbnFYOG9ad1JXcFRCT0JyMS9Na3g5NlgrVXVmaHROaTlyZkFRdUdH?=
 =?utf-8?B?aUFUd0Z4WkZrcHpEclZSS1hJYU9YYVd4S2hYRm03V0VLd1lVQXUwWHZmeTdM?=
 =?utf-8?B?aXR1QmMwcTZiOFI4dGZTL2pkSVJBQ3FjMEN5c0tsRFdURjJWMHY4NG12MVU5?=
 =?utf-8?B?alh6eXdLS2RwUXVOTU5pWG9xb3RUdjRmMDBnWFdnUFl1aVU0aVN1RHFJVXBY?=
 =?utf-8?B?cmJLbVBBZDlOaUNTRVFvVzlaSjlOYmE5OGNGbVlhYlZyRnpka2owV0pRY0dL?=
 =?utf-8?B?OWwwNmdsdklJcmxWaDRSTElHZllJdGZuai9OOWZ3TUI5cXN0WENncHJoV1Bp?=
 =?utf-8?B?Sm5jK2ZMQmRVQmdJTUZXTWtXbHhaMlU4bUliMGtRcnBldHVEQWJNbUpBYjJa?=
 =?utf-8?B?ZWhBQVJRZjJ0NysvWURBTEFDQkRFdS9yV1JFVzdxb293UVQ2RXVYTUhvSDJ6?=
 =?utf-8?B?Z2VHQmEzRG1lZjVFaTJEWFc4Y3ZYaWpZVUJBa3Y2WkdLS0tvWTFlSm1FcTRX?=
 =?utf-8?B?QTlOYkVrWHFPZnFFNll1dWRLWW95K1ZzTG0ydlFDSG1tSEt1OFhxMlJVY2No?=
 =?utf-8?B?aGZNV2gyM2FnaVcvUldPeW11OU9sNFlFVmhJcXh2WWlsTGxrVTZMRXQ1Q2tE?=
 =?utf-8?B?T1hrbldpczBFU1NjcHdxU2Jta2VTRllqVDZudVgzcFdXcmRUMGgwczJsVU4r?=
 =?utf-8?B?WU42b2JBYlMvSGpwVUo5YjMrNDZHMGxiMC9OUkVDWGpPZ0RxNGNhT2ErQXNa?=
 =?utf-8?B?WGxHaXJhNDVUbXhqK1hNejhxRXpacnd6b0tKbE1BT2ExUjAxVUsvc0g1NFVz?=
 =?utf-8?B?Z1dZVGFtVmhrbEtHWHRGN3gxWFFFdTlkSFpsUTR3V0M0eTRwbzFXanliTXVX?=
 =?utf-8?B?NVMxUCtlZ1JBQzlrZDkwcmFxZ3ZVbHBqSURueEZYcEIrRThJUGxNaSszT0lV?=
 =?utf-8?B?bzMwUDgvaWEwMy9sRzBJMFlHVnVrT2E2amlQZDk4Wlo5S1J1VlZLR1dkZVFW?=
 =?utf-8?B?VnZTQnAvTHhuZCtCVEYvelpWTE9Xcm52K1k4QWJtQXZCeFA0RENEa0w1U25i?=
 =?utf-8?B?RHdQWHR4allTbkxQUnppcEJvVHhrb0xNWkFpVnBEK3BzcytDS0NOaXRpU2g2?=
 =?utf-8?B?OXdnS1F2QXBmbW5DMnpEemQxUDI2T0tCTFo1aXdCRm9TaEZYTnV4K0toUE41?=
 =?utf-8?B?cDZ3R1VHbCtwd25HUUdiNEJqWE5xaEZlaC84N3JPQnY1RXpmd3dYMFZ1bE1L?=
 =?utf-8?B?TVpvS2NRK3BMMzZpSWNDUGp1bVVzUFVzdWtnOEhHRjhFZDg4UW9wVUN0S3R5?=
 =?utf-8?B?OXl4dGtOMldJV2RPZGVCREd6ZjFneEpMQmVBV1UrbWZKMmpncCthZFZZSWN4?=
 =?utf-8?B?NkRBQk95cHpLblZEVDdocGlQZlM3NzlucDVveHBrZnNTbFlRcFd1ZmorUXRP?=
 =?utf-8?B?eG1HL1JzRkUzdDdsd1lJVHJnQm12RnA2YW9lMmcwMHBZNnJ3S0N3RGhWdUda?=
 =?utf-8?B?UFBNOVo2RlByS0YrVng0RndpVWJqM0V0MjNPQ21UOGF1bzgvMVQ0U1VpaUpI?=
 =?utf-8?B?enhVdFZ2aXdYOTFQRlVuWGNtMkF3aC8rUDdZYUV4OEJvbk5PbTR4L29LWnRQ?=
 =?utf-8?B?MlVrM3dtcXhsWk5WeEFPOFI3V1JKOHNnamNHSUxnc2dpemd1UjYxVDRrSmtv?=
 =?utf-8?B?TUpjS01UUGwybS9mMVo3d09OZGRlRElJODhaVDlVcSt2bWRnNS9VTjhTbHZX?=
 =?utf-8?B?ZkxNK091ai9WTFJZY1RrVUE1MU9qM3NLNUxZdHliSFlEUGNVT2tyaHUrVUZs?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a4bc7e-a303-465b-1222-08ddbe37e557
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:55:43.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtesvDnvJB56IUjDADIFdagVw2iFvrnntIPtAcCmqHr6LY1wxLLY9lnrltTsmLmXOClA5PhiCzmkFikXM+Z8VefmffZgN+SK4gUPQxQpkWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5230
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 8 Jul 2025 16:14:39 +0200

> On Mon, Jul 07, 2025 at 11:40:48AM -0700, Stanislav Fomichev wrote:
>> On 07/07, Alexander Lobakin wrote:

[...]

>>> BTW isn't num_descs from that new structure would be the same as
>>> shinfo->nr_frags + 1 (or just nr_frags for xsk_build_skb_zerocopy())?
>>
>> So you're saying we don't need to store it? Agreed. But storing the rest
>> in cb still might be problematic with kconfig-configurable MAX_SKB_FRAGS?

For sure skb->cb is too small for 17+ u64s.

> 
> Hi Stan & Olek,
> 
> no, as said in v1 drivers might linearize the skb and all frags will be
> lost. This storage is needed unfortunately.

Aaah sorry. In this case yeah, you need this separate frag count.

> 
>>
>>>> Can we pre-allocate an array of xsk_addrs during xsk_bind (the number of
>>>> xsk_addrs is bound by the tx ring size)? Then we can remove the alloc on tx
>>>> and replace it with some code to manage that pool of xsk_addrs..
> 
> That would be pool-bound which makes it a shared resource so I believe
> that we would repeat the problem being fixed here ;)

Except the system Page Pool idea right below maybe :>

> 
>>>
>>> Nice idea BTW.
>>>
>>> We could even use system per-cpu Page Pools to allocate these structs*
>>> :D It wouldn't waste 1 page per one struct as PP is frag-aware and has
>>> API for allocating only a small frag.
>>>
>>> Headroom stuff was also ok to me: we either way allocate a new skb, so
>>> we could allocate it with a bit bigger headroom and put that table there
>>> being sure that nobody will overwrite it (some drivers insert special
>>> headers or descriptors in front of the actual skb->data).
> 
> headroom approach was causing one of bpf selftests to fail, but I didn't
> check in-depth the reason. I didn't really like the check in destructor if
> addr array was corrupted in v1 and I came up with v2 which seems to me a
> cleaner fix.
> 
>>>
>>> [*] Offtop: we could also use system PP to allocate skbs in
>>> xsk_build_skb() just like it's done in xdp_build_skb_from_zc() +
>>> xdp_copy_frags_from_zc() -- no way to avoid memcpy(), but the payload
>>> buffers would be recycled then.
>>
>> Or maybe kmem_cache_alloc_node with a custom cache is good enough?
>> Headroom also feels ok if we store the whole xsk_addrs struct in it.
> 
> Yep both of these approaches was something I considered, but keep in mind
> it's a bugfix so I didn't want to go with something flashy. I have not
> observed big performance impact but I checked only MAX_SKB_FRAGS being set
> to standard value.
> 
> Would you guys be ok if I do the follow-up with possible optimization
> after my vacation which would be a -next candidate?

As a fix, it's totally fine for me to go in the current form, sure.

> 
> Thanks,
> MF

Thanks,
Olek

