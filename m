Return-Path: <bpf+bounces-38879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2896BE1E
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 15:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E30281C3C
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D9C1DA314;
	Wed,  4 Sep 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwwL64SQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4D41D79B2;
	Wed,  4 Sep 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455884; cv=fail; b=TybuIvkaZQCE7e1NrF2t4ra74N/++mzYLolu001RchyTztjYxwZG1wbmpN2e0W+0R1IQJ4prtJwik+Q2XKgMAjBH2RQO01cwnMULPc01VjDHEBOrndh1LGgEJJ9NxxhEJVZFnNzeSAD72cq1qpMFJ+C1DIrSdRIx26+tFXMyF1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455884; c=relaxed/simple;
	bh=c7MRpl9GVU39f6Dwu+XxNIbVBPOw1DPo2I/fX6NYSUc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9ji/tWc8rQVCHZhA6GqHz0mIvYlNweGxrQpkGvg9ZpHphIOKIJAOEHWZgqJUYOC1wHozTmhFQkyhNhE6q2C65JZ4MR7vl/Qjb0b6Qk7CoSVlym5B6UwxuG5rKyLAc0aeph1M8uivf/euYLpi7+s0ZGQSoGREMU6BBfTkqnbwbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwwL64SQ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725455883; x=1756991883;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c7MRpl9GVU39f6Dwu+XxNIbVBPOw1DPo2I/fX6NYSUc=;
  b=DwwL64SQbXF6TfyscZlVhpucvHO1kf9+FAWdRFOlqhAUsZlqZs5shs1m
   kzs4wvOKWpZQ40fHBiycCFp95k5ae2Vn/yCKAa0A6/tq8VK655hf9QS7g
   IGqPdmY3DmUEAGQE0c5KTSPgl0I84y7J/3zR200gWCWeglmxJVTVtNASm
   eH4+NtJhn4Yq6RZP31dA3zyMPQdZdJ3fhuY0sWTgaNSHwqJiEl7Rm6tB+
   Fu1t+qeuJcb1lJV/JNa1Kp7ZjGHrICrJTzwVGeasWAfxIXKP8XarZuiYD
   sWBoJFf/NT/oY2jDWFPr4MOyMgRtERMyrY5cEAppKKTAs5hhtkavEPrww
   A==;
X-CSE-ConnectionGUID: 985ob5AgSW6XSKGu/tNHuw==
X-CSE-MsgGUID: oPHkGR6+TXOUizyqckgUIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35275832"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35275832"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 06:18:02 -0700
X-CSE-ConnectionGUID: Yi92vIVYRZa+Ah324brI2Q==
X-CSE-MsgGUID: n+wS5N+hTiun9Cj/8/e62g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65610051"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 06:18:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 06:18:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 06:18:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 06:18:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypfrhX+r9WycSeol06kbCg4Hm3/BrVgR7vTFKKyCRKsShkORjmqAp8rRqXgS+uFGZI1MQfgIE5eO8bbaakSuEpAWuIy0dyrxFWn0ERYzp0sJq3D3llyv80bqf1Hnx0QKFq4MYW2p1M8E+pJA9Vox9u4W1FOhq8gj+3LwbsckRBTo9jUVTD3MourFULEBVbd9XCCNw95yaSDm+CQT3n+GvQAcq3B/47ehB3lvKfaY5CKKsiNaF2oWaW/IOtINpp4iBJ6tYe87MakvpGfXUty7PEpOXoeLXatrAkDQ5S9/8YjPmKM62HQbnkGyYMu488180sdZ9hVAUBIscIsizTgtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRaKUgt+O/kXFomXpQZL96z9+TsJAu5xS+g8C8edc7Q=;
 b=AEkw2VrvjgfFbraidLaFRU2enyhZA6DxIl3vkLniJcfHyImiS+JwooRzJJsxiqLbQ10sT3qXR6tCZV+rYBmlDUAtA4Kk4vs9Zn+VmmhxeGpy8oRT65lUbO7I1XyoU4UKwo/MF/YagDhUhWcsSJd3UdPSmzlDBWsDPyY/HguUEDoSiL84hc2M1Cg8qdcyb6cumZTMunke+SAb9EWALfXIllqyKO0pOW1rXZDUU0iVUN2pYsYmemxceG3MkujrcXGDtxeuqgGNpkkXSafIMwruxxgHJlFqh6hfIIQtS2XzbtWk/3CrZ89Kw1qK6oYpUUOl3xnX3nORHyfjJdPGt80PYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6551.namprd11.prod.outlook.com (2603:10b6:8:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 13:17:59 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Wed, 4 Sep 2024
 13:17:59 +0000
Message-ID: <4ede8b00-aab9-4be6-a589-98cc0d98b929@intel.com>
Date: Wed, 4 Sep 2024 15:16:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the bpf-next tree with the net-next
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, bpf <bpf@vger.kernel.org>, Networking
	<netdev@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240904120221.54e6cfcb@canb.auug.org.au>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240904120221.54e6cfcb@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::28) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b2e063-3e44-48f2-582c-08dccce3ff73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1FTZythT0l3aUZZV2Jia1kwSjFQTXFrTGFCeHVaMFZCZjdSek4vb29JRGxH?=
 =?utf-8?B?K1liQi80cExPbFViWkowcXVhMDlCY3hhT3kzRmVGWW44UGc4Y3Q0ZkN2STMz?=
 =?utf-8?B?Qnd4a3J2T1B4KzRvZEtmSkIxOWJ4NGhWNHVSeXJjWTNSVHdEWVRTQzBTSDk4?=
 =?utf-8?B?WUJpejN6SXJ5bndPYnJIWVQzVVlkK2V4cjBjZ3VEYy8rVjUxMC9nYkpJS1Iy?=
 =?utf-8?B?QjBnK1hwZEFyVkdmNExFK3k4YjRpNlVUVVJLV0Nkb05tYXZMb0FTOWN1cFo2?=
 =?utf-8?B?MzdWcHRvRm9tUmdCQlZ3YmdwZzVLeWdZWC8zWkZSdkJZQ3hLR3JVOVg4YTlM?=
 =?utf-8?B?Rlg5ZWRBZ1Q5NTQ1dlBGRkgvUzQxNDhGc2xSTFJvMnBFZDBSRUpTMlZHNElW?=
 =?utf-8?B?a1o3WXA5MEhETTkrYmw4OVBGQVRwbjhXWm9GZnFDUzA0bkxzZHVkOFJTS2VY?=
 =?utf-8?B?QXN4d3ArK0gxYjFQbjN6VjZXVUowRzlsWUIyTitzT3ZBSjNHRkJlanhrRk45?=
 =?utf-8?B?d3FJeWgrMjFGQ0hnYmVQdEJGU1NLVjByb1JCQ1FkWHFRWCswOGYxMXBTWlRW?=
 =?utf-8?B?Vk9tVnRkTXZsSTBnZ05JQ2U5OHhIY2RPWDAyQlhIR240NHBqdnlSdFdTU1Fs?=
 =?utf-8?B?UFppL2pQQlNGNUh0M1lBeXliejBJRm1SanZqNkY0b3ZrMjI0b0xYS2Fadm1L?=
 =?utf-8?B?aTJDZjE1QVpRM2Vxb0p6MFlyaDgyd085Z0lTQXY0VDJxSC96VjQyTzhDUW5r?=
 =?utf-8?B?bjgvSG43QkN2YUxEbUlSUlZSeW14Wi93Y3FvVDhGZVRPQTJZcnBLYS9SS3hw?=
 =?utf-8?B?SjVRVlpNS0tBZWM2ZHkyc0VEczloeCtFaTRqeHJ3VzVsU3orak1OcC9DcFVN?=
 =?utf-8?B?WC95c0lMcjNMeS9SVWRPSlRVeFFsVzRwcXQ2QUZBSFpNZ01TOE5Yb3pCd0Fy?=
 =?utf-8?B?WVFkSTZpc2xzYkY5STBCOCtBUjJQRnpJaE1PNHFLOExsV0R1ekdwVmo2emY2?=
 =?utf-8?B?SEk3MUZtMkZJUUpGSGV1emdOLzVZTXpYam1iQXRDUFAzUEZ5dDYzYU1jVWIx?=
 =?utf-8?B?aC96VzI5bXlFNEcrVU81M3MwTHlmcjdKUysxTjVCUEV6UVNTTEd5Z296czht?=
 =?utf-8?B?VkZmWUdUUHV3UkdoYUhqVzlPWlZLQThRVmJZVThZc3VUM09vQndnZERQWk9U?=
 =?utf-8?B?V1RXTytnRUFzRHJ0ajNRanZrb0c4UHhZR2dGNmlUSis0TFFtRnVzMFJBZUV4?=
 =?utf-8?B?QVNJUnhLTVhqNHZnMUlNZlpycG9mclZodm1yaEE0UkhOM2pwL0t5Y2ZYTHQ5?=
 =?utf-8?B?WDFXempBaWRici9SMHBKTTRUME9pV3NaQ1RuVEhOWXJyWDVqWmlPT0FqT2tv?=
 =?utf-8?B?bDNIMkFleWo2cmVuNk5YTzltOVhROU9WMGFERUtCRmNkT3Arb3R2blhQYity?=
 =?utf-8?B?K2s2VlNxWERVMW9uZUloVTJKako2QkxPR0tKWDZKS09qU2hOejhGUy96R3NV?=
 =?utf-8?B?cUNORGNxVWVXZzNlaUNnWlZrZW5Fdk0rcEwwRnBMcTlHSDZSb1lsdnZSVHNt?=
 =?utf-8?B?NVJPa2F2MTIwUWhLbmE5ZUVyTTZuREp0YzVxTUJuVlgwZXMwYllhbkJDSGpv?=
 =?utf-8?B?V1AyajlSRE5BbnJaaXdCdnArd1lvSS9oc0VaU0NCYTl3UStUSkFVLzYrZ1Np?=
 =?utf-8?B?SnoybXQzYTV4ZlltTjVpVHk0V0hISnpFN1NiWXA4L2wwbVU3NXRSUWZGMllI?=
 =?utf-8?B?d0EzSXRoVGM4L1BJZVpKczJvQ0JDTE5nMUFPQmRUVHoyMnNOWFJGWEN1LzFt?=
 =?utf-8?B?SG9CWU1FaDBub1dwVk9kQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVJaMHNiZ1pOTTZIeGo0OS90eUpXa2lJbUg0Q2lwankrV2d6Mm9renJkT29y?=
 =?utf-8?B?V3k1VlJtaXBTN3Z5eFh6UXN5aGhwbnAzd04ycFVCNHJCaUppRW5GTEhxcmpB?=
 =?utf-8?B?bVJaUHAya3J3QnljWjdjcC9aRW9WRm95aFAyYllxRjlsVTFrSXkrdVhYUmYz?=
 =?utf-8?B?RjlvaDRKZUg3b1lzTkY2WFBBUWNwVXRIN0xiN2QzYlh5VkJaMnVzbE82S1Ry?=
 =?utf-8?B?cFdlZTBheURDRndUaDU3dlFGWkNERzZjY1hCNU8reFduNHExQTdzWVZhaG1K?=
 =?utf-8?B?SWwvWTlRb1FxcVBOVWRmYm1NL21QdGQ4VDBqbHU3OFgraXd5S3BlSWZ1VzFn?=
 =?utf-8?B?RHBuL2NudXdYV3l5MHA5b1FONG15L0o0VzNVeTZyWVNYWkdPMTBXVWM5SjY5?=
 =?utf-8?B?TUFTMTNUNkE0NGo1czM0Y3VuMjRHTzI0QmhCaDk4ZVZ1ZUZMY0pZZ0dxaEZD?=
 =?utf-8?B?Y3dtZURRWnlFYm9mS05oVVBDV3IwNmlpRStVeW1mYW5pMHpwVDNoNU5HZGdY?=
 =?utf-8?B?R3FOTDFkTUlTUEdKSUZkYWZtVkVhYU41dEtsVzJOeHhlK0NTWWZYUmJNNUdq?=
 =?utf-8?B?SzVuK05pRjhwb2IvVmxkK1ozNTdHQUViKzlzdmd5UTlWZGtjV2crcC9JNlVM?=
 =?utf-8?B?MEZZa0hXME5Ka0pmWWhDZTZIa1dQN2EzaWpTS1pxLzNKeUtGVmpMSGR2bmRU?=
 =?utf-8?B?N3J4WW5rODRjclNscnpNSmxzSXB3SnNNY0ZSU0JvVC9naWRsQnFSM3RxL0VU?=
 =?utf-8?B?UU1EcG5TOUhidTdZS1U0bGIrcEIyZVpaOXhLNGtXcCtnem9qQXVsditnQWRY?=
 =?utf-8?B?ZEw4UytZR1NXQnhoajdYZTkzS01OQnZ4K200OGFPYXBiL2ZxcXErS1FEMFhF?=
 =?utf-8?B?VlVkd3l6bzUxMnUrelJKREZRMi9IazVka0NWZGZDZWY1Y25wUkFSNFEyN1lG?=
 =?utf-8?B?cVJUbHk0d2Y4VC9HMmU5VkZYbEJaUXFveW1tZkFHWHhaemFmVnhlNjkyWUs3?=
 =?utf-8?B?K3NJbklpd2dKMHZTNWpYU21jV0RBRkljVllvVVVnNkxWdUt2MEdHMU9BZlhH?=
 =?utf-8?B?Y1RHSnJ4YkFRRER0d3lxU0w3STZ6bFNsc0VXVlRrUlVqVnJ6enB3aHM3eWtW?=
 =?utf-8?B?L1A4a0hZNUYwZzk4QTVJQzhrb3UwMmhGdlo0UXIybFNIbjNoMllYUEJXQkR0?=
 =?utf-8?B?MDBrTUdtdnBKWXhFS2g0U3p2eUFSYzE1Nk5wMno1djhMa3d2a1psV2JLd3U1?=
 =?utf-8?B?R3RTUXNlTXJvV0gyb2JMdTA2UE5CdllhemY3MUFaV1hNelZ3eFA5dHFmdzFY?=
 =?utf-8?B?RTBSRGRQd1JkQVNvakExK2NPNlJMeDRYcjRMZU5QRFM5VUlyTkdFOGNqeUNi?=
 =?utf-8?B?SHZTMVlWQjliS2hwMzhZa2dqZS9FNjhGSkVhVTF6R0ZSTHNOdmhPVDNvRXUv?=
 =?utf-8?B?Z2JYcjJVN24wY0wzZlNIaVJ5azYyWFFUMGdySjhIK1BpZlFLWERYWmV1Vm84?=
 =?utf-8?B?TjhGdDdVbjJ3cE92MmJwMW1XeXVTcjRLdU9wZTRobDhYVHNsbmhBSWsxUXpy?=
 =?utf-8?B?V2hXSVAzZUhWY2pPa0gySTV0SElVWEhlSlVNS3FNZHp6VmFKa0VtbnBvMVUx?=
 =?utf-8?B?Y0cxMGZGQlp0dGkvcUdkend3Z3NubmgwVldsWUQxUXJac3h6OUNRV2NqVDdQ?=
 =?utf-8?B?V0s0aEZxS3FRWGg5YUFUakxib0Iwc0ZwaGV5VnQ0SHUxRk5Gb2MrQWJlWlA4?=
 =?utf-8?B?TTk3VXFvWWV5emxDQ21aMHI3NHlrQ0VCN3NHZTEzb1hObGNOcTUxdHcwYVYr?=
 =?utf-8?B?WGpPMTNQRlVuWVR4SnArL25RT1ZWYW5sb1F6am51QVIxZmFsMVRablQ0a3ZV?=
 =?utf-8?B?dnNra0pZLzQwZ200RkpXRkdpYzh0a29ZVDNXaHlzemNOaU5qNG5vZm5vNkdC?=
 =?utf-8?B?Y3FLSlIvUUtvSkNJbmlhNlErVmpoaFdyTy9LN25MVjU5ajd5QkFlYkNuQWtq?=
 =?utf-8?B?a3dwMXBicC9RTkM1elFVYjhBa0RDU0tNRFJGMkJtaDJWaU9JTkdGbG9zck52?=
 =?utf-8?B?cWJQMEpwL21RQ2s4TVN6VnU3ZGozekIzS3JuRmZFR2gwOHV6UnlYRE5oNVlL?=
 =?utf-8?B?SFdwTjFlK3NBNk45V2ZraVRlRlIxMDlqWGpiLzdhTUM3bE9QRW9nMGt0RXdJ?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b2e063-3e44-48f2-582c-08dccce3ff73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:17:59.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dr99dbQ/WzKKoEommQi+3+Ucjf4ef/JvPP7+qWX2cKmGI9vQAkVDKvUZWtmEE94VkB2vy0yTV67GB+3Hh65iaimeNrsl6xtHN7i7NFH0DmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6551
X-OriginatorOrg: intel.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 4 Sep 2024 12:02:21 +1000

> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   drivers/net/netkit.c
> 
> between commit:
> 
>   00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to dev->lltx")
> 
> from the net-next tree and commit:
> 
>   d96608794889 ("netkit: Disable netpoll support")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Your fix is technically correct, but maybe swap the lines?

 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_DISABLE_NETPOLL;
+	dev->lltx = true;

Looks more natural I'd say...

Thanks,
Olek

