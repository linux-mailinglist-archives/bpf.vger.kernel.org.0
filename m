Return-Path: <bpf+bounces-55453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F54A80C86
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140008C3FD1
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FCE13665A;
	Tue,  8 Apr 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iup2kIKT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047D3D3B8;
	Tue,  8 Apr 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118913; cv=fail; b=kMZmBvlkkJGJ+2CVP9RbfQEWjyNA+B3kwy7tqWf9OWmE2RG5gHn5gmNrNNPJMmEvOxKpSf99tjpVGy05DM07L3Ok7FKqMJ9n+VDoXvAe6X2spFCAkpANIirxzbA2x/S6vlulIsjEFVepgelTr0FGt4CgM140DuOU+08JdXFrYTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118913; c=relaxed/simple;
	bh=37EDuAKfIfYqPIASHLh8B4ViblVQ7Y1tpJF5lxKiDNs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gE0abTqG0Dl+oVjQgZ3GnMCY0Br0ZgFcF+buqDdhMfSYpHo9J0c+dIByNEYXqQcviqURnsl+qjcaBm2zFk3jlLuTo13MDjdRx1LHJQRj6rmCMPaQEP7cVZtp3jcYnm4I9Kopi/TJEAoVJI7IKBFIQOqzfcLT4tUJiR7lg4RkaoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iup2kIKT; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744118912; x=1775654912;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=37EDuAKfIfYqPIASHLh8B4ViblVQ7Y1tpJF5lxKiDNs=;
  b=iup2kIKTghbpvVZ9DmTQx92Gcbe6kzUR3zmq7HGHOlc78twg+erIOU4a
   4DCKcz+z5LRMrj3bm4SIrgg6Iu0+q/EIJJoRDcPZqn8wjEz9YMXcjFkm5
   C28KoOyXZuPXYQul/ZsIaB3fsZXorqQdWMozhdgc76Mbjk8UAieqbNL/R
   wIw7b3GfxEpUwsUOB1Eo/KAux1SW+eLGML571IYSHH7v8eTBp6l9WHGq0
   PpzHby+gE693JDQ8P5GypkoVjKbL1JZHkOL89egMVum23g45KfUyyI5pa
   N3i4gAXcyO5J5M64Cr/Qg1bv19PpDTqwi3Kqmg7zvimbG8aplZjgSyFIi
   A==;
X-CSE-ConnectionGUID: sMfDpdGiTRmZxSxuZltnow==
X-CSE-MsgGUID: suCmnWXARzOb36zQ8tSfXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49395065"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="49395065"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:28:31 -0700
X-CSE-ConnectionGUID: sAxBmjwMTAO6QWWlQSXD3Q==
X-CSE-MsgGUID: Q3nEFH93SySK4TReaykoqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133246654"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:28:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 8 Apr 2025 06:28:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 06:28:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 06:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS9aU66VCxFVSpS+2Jme1OKd6gLeKv0k75frYAVZ/jQo2JPAC1RC+p7LRodmIJaVdxlEUlZnCPPl+0Fcswy5XbadtVAh6M2jjcJDeRYkkH4QpSz/mAyyBjPpVA2VOS6Ivi8E0bovlD5r2MVN+/8VNTP0fp0rSjyVvlOMCA83UtdDSQ0qIyzbRPdeoGBw7mhfkYhYFZE8B4QNKQpgUMEvsjLsN3tNE8M/o3JZBZOPSp2iNlnCbhXBYyNw7SjXlk1Q0P6Q3zRA+mg07sZ9ABsgYjEZgWFEy4PM4o7IHU0cNxC05/+p2Xp9H/xThXf8b1ls6s4E7Q37YqcuifH7T+s+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOSCn8gmXQoQXbNBiSgmw4PpRVBG41AfiUvFbRPTSNk=;
 b=wVzOQ6jNUW8y5IpJonnKDwujE3HKClnwMcgMR010s30kJIX7P9/BhBaq22BTuq0cTmqpZwLtjf6v4cTleCMB8Ov8jqrSYAgOhEd9X9HjVY4WOU3/aYWRjUqzMDn+EwWLDLc69XJrMOINF+D61the0IWcbFGV6DrfJaitJJX1MVHKETQkHwLrIIDlOKslEaWBPYbAy4N3Y34JN73i2AaM/M1ZGTLABlfJd1ks8Ds7Aype6YeZ7TdqMlHWi5arKFHkTyj7iigrjGF6IUAml/ZlP4AoaTuFMzpQvh+cnB84IeshyBe8PnkdVAkgIu6z8g9LnwUvpxC8KAWwq491+GafNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV2PR11MB6047.namprd11.prod.outlook.com (2603:10b6:408:179::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Tue, 8 Apr
 2025 13:28:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 13:28:26 +0000
Message-ID: <454272e0-82cf-4f79-be53-a4838dfbbcd7@intel.com>
Date: Tue, 8 Apr 2025 15:28:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/16] idpf: add support for XDP on Rx
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
 <20250305162132.1106080-15-aleksander.lobakin@intel.com>
 <Z9Bbr9b0WLFQZt4Z@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z9Bbr9b0WLFQZt4Z@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV2PR11MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 265dfc47-7bfc-47e5-0f4c-08dd76a13e15
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDV1eGxrbld2dDh6NkdaQ2ZaeUl4emRaUS9Jd1hMV2dIQjlqMWZQbVd4NzlV?=
 =?utf-8?B?SHBSMFpVakJ3RXNXaXpOQXRubmVuMysxWUV4OXNsMzBnYmNqZSs4N3REejh5?=
 =?utf-8?B?WHRHUmZlbjJHRlpRdWRBR3JaRXFMU00yQmV5YmIyenE0OUVCWnZTZTJqd3hG?=
 =?utf-8?B?cmYvSFVuTXN6cVJ4QjhhNUlJNUd3dnA0Ui94cmJyYXdZK016WXd3UVdCOW5n?=
 =?utf-8?B?TXpRa1piVkV6dGxIK05tamI0TlY3ME5sa05vUlRnNVZFYThOenRkTzczQWM5?=
 =?utf-8?B?ZjdrQnJRcFMxVnY4clNWbkc4OHJkM0lUUEhHa3RPREo4bTk4M3FyOWhIMU12?=
 =?utf-8?B?L0d5WCtyOGQ5a01zWlpTUHdxcGx0V3pwdlJLVXhpR2dvVk4rcGxyWFJrdnJn?=
 =?utf-8?B?ZGFtZi9zQktvVnROak9Na1AraVNuNUZnVHNBVDdjTDQrdEZsdG1xR2Z5ci9Y?=
 =?utf-8?B?QXNLV0thc2NqKzNLRThtcHJlZno1REcrRW1XNCtzNHlMbHlieWRIaGFqWmJM?=
 =?utf-8?B?bklsNlJ6cDVZTkFaV255ZUtFMCtVZmM2Rys2eXZJMnpoajdaN3d0cXVJZDUw?=
 =?utf-8?B?RDU3WEhQUk1MRFNSU2thcXVKMmVCejJ1aEF4bWlUYUpHVC9TcndiUGhsVEpl?=
 =?utf-8?B?QUpLQnBtWHpzenhsZVFwRzhRTis3MytXK29LazFGL0pkWndhamdxQk9RNXVH?=
 =?utf-8?B?WUszQXk4OERjWDhkQU5CT0tYMHNjanJCNW5PaVhFbDJrRmtrTUw5bXlnRkVv?=
 =?utf-8?B?M0FoU2tLUHBmWXJscnNhWnovK0c5NzZQbXhRdDU2OG1nU0hMaEF5OTZXVzJP?=
 =?utf-8?B?QU5BS3E0OVdHSzJmMzZGWE9BT0psNWFreE1aQXRGdHpKMndLeDRkVXR2MHdP?=
 =?utf-8?B?WEJyQUNMT2ZsRTNFV0FYY1Q5REVRMDU1RGsrZStFN2Z1VnBKY1R1bmdyZUNR?=
 =?utf-8?B?akxTcklzcllmVk1xYXhoSU05VHZVWitXczl5aGNDNWpScjk0d1kzUDZ1SXJZ?=
 =?utf-8?B?cFhxTDNJMld5MlB3bng2angzeUY1UkV2Nk13UFFhcmZKNTlpNUNPZzQvRTN3?=
 =?utf-8?B?S1RmNGJIVmJRVUhJeldRd1RsTEdCMFRwQzVUL3R3RmFYcENLYkNhWE9wQ1pN?=
 =?utf-8?B?eFU2WTg3amlyZVVZQ1g4MUx0MDlYaGNaaTRmWHNkRkU5TGgrc1NMckp4MC9W?=
 =?utf-8?B?dkRmL2NsRDh6c1RFOXhJeU54UUs5dFY1UUJPcVFwc3g0MkRGc1IzT2h6aXFL?=
 =?utf-8?B?VUpWK0FRYUlHQldoY1RvVFp0Q29MSnRkNk5xQ1RrMG5QbzNqMkx0c0x3RVlq?=
 =?utf-8?B?VVNrbkxxTDhmaFovUlAzK0VrL2FCYXp0MnozcVJUMlpnbnVEK2g3SExzRUVn?=
 =?utf-8?B?VnBmY3AvLzdWMHhDVE0wbzY1VWM1dHRwa3BidWVQSUVqdGN6d0h3REsrZzg5?=
 =?utf-8?B?WHdhZzJXcThRYjRJSmFqejljRUdyVDh2cENZV085VHlzRTcrVDVWazNTNkpH?=
 =?utf-8?B?dE1DZmJCd04vRldqT2RYUlFYclZiZzhZMDZaOEYwUnRGYWk4OVcwd0h6Ylgx?=
 =?utf-8?B?SGNlMVRVaFV3WlVKVStrVlg3ZHFSNmRXWmw3b0VPKytabG5mbVZueUZyMmZT?=
 =?utf-8?B?TmV6U1pmSzZ2WTNIbWRERHZuVlJQc09zNzhuVjhlRlE3VjZtS2dySWF1OUs3?=
 =?utf-8?B?S01QcXVNRHV5T3RnUTBrRmJEek5mMWNZYkNwMll6ZUgxaE00U2RjZERrYnZY?=
 =?utf-8?B?b1lWU0QvYUNHZUcwQy9QZDJYb0N0Y1d4SHdMYmw1aXZGcUlkZjk1Yjd2MGdK?=
 =?utf-8?B?Sk52OVF1VDZHc2thZlNKbU5hckVJS2w5WGl6QlY4T1dBd0RFcVgvR1dEL3Ru?=
 =?utf-8?Q?+4VG3mR3H3OqC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGc4OGpIQjVUYkNuWHZmYi9jTFcyQkJrR29rSHBIOW5HNGdxSTJ3MXY4R1pz?=
 =?utf-8?B?eGFPbis5WWNrWTVHR2wzdllqei9jN2NEd09QZ25EdGRzT0dDRkJtNG5LclZv?=
 =?utf-8?B?S3R5VTMydWYzN3l6elBNclVNckZsRWdKNkxnL25rYW4rNWpUSm02aVpoZUZ5?=
 =?utf-8?B?cDdiWTFHMlJiczhlZSt4WnBJaG5SUS9qdktnbndRQU9wOXFaOHRpTWVybHVQ?=
 =?utf-8?B?UEkzbW9keGZxcFRRYlhVck5DbVQ5d3Z6QllYYS9PbVQ2VmtOOXBpM2o4MXJ2?=
 =?utf-8?B?d0txZWg3VDBxRnB2RHE5UkdnSERwSTAzc1d1Z2puN0QxK3NMdnNNcmRSS1RL?=
 =?utf-8?B?U2RzYWZpMW5DRmgzV3diQ05wN0xUL1BhNjEzaWN5L2Vmb2xVWFVrbGV1a25Q?=
 =?utf-8?B?V0QzSDArOEpEQUtQOGNodjVLeVlEK2xRRityZEU4bldrR3VhVmYyUTAyTzdi?=
 =?utf-8?B?KzhhUGNmM2I4RzRRWTNsZ3oxbTVHRDhnR24rbmtKT3BwbGpuM1Nzdk5mUnp1?=
 =?utf-8?B?K1JKeHBnenBtL01ubkJ2cGM5WEdrYW02WW83NHNlR2hkcFQvSVh2emRzNFdN?=
 =?utf-8?B?Q0tSeGVrSEord3V3SitYWVdVdUxqWmhPNVlrNUxLNzJ2RlhiTnBSU2RXWm0y?=
 =?utf-8?B?NDJ3eDZRUE0wTWJqK0dRRmtNdnVaVkZSR2hTbFVhTCsvWGl2Wnp1US9GS1VZ?=
 =?utf-8?B?T2R1ODJrRVVjT1FJc2ZINTFwdXR0eEtFVFFVdjBGeU1VRy83b0xtaC9pUmNT?=
 =?utf-8?B?eTR5WGZwb0VQREttTWZRYzRqTjJmRWhISWdUeko4eEtGTHN0VTAyMUtpSnRP?=
 =?utf-8?B?eVFYSUVNZGxYRHBZM3hOWW10MTJtMWVNZ0VBNnUyL0s5MEFGTlhxTllONG1r?=
 =?utf-8?B?dndGMFpFZnFkWXJlcGQyZVE0eFlVa1cwMExkcVlYSnRLbmFUd0QxUVlEVXBj?=
 =?utf-8?B?S09RRUVrZ2Y4YzFTUUtsblRvYmNwWFFuRWZ3UjY0cmJPbzNCQmpEWUxuY1Jz?=
 =?utf-8?B?a1RWSlZRWjJvVW0rK2VHWTBwdGw0OVlaQkNUOThKdmUwQVd0Mm0rbU5BVmtq?=
 =?utf-8?B?aTRtUEErYzFTc3dRcTVHR3lRdStUd3JaR0VmM3p4TVZTbXlwOVhwb1ZaeW5h?=
 =?utf-8?B?KytlcmtrK2VpMkJrc2hHOWc1RDVuM1Y1cW9tOFhBRjJyakxObVJJdzBWZTlk?=
 =?utf-8?B?bXJ3RWIxYXI4bkhBQlNDNWVwbk5CTWZxNExUdlJiWS9SWTJVYjJrbGpHZkNN?=
 =?utf-8?B?RXBCZG5iNUdXMXphMVFwdGVGaHRwY2FPbzgyT2VDLzdKdHBRZnZTVEdxQ0V4?=
 =?utf-8?B?eGJiVzBMajFQWWFRMnVSeG9nTE53MTFuakhOTjR2MDBEMXd3K25yeWkvMDJK?=
 =?utf-8?B?NXVsUzFISk85b3BkcjdrUTlFZWZhZUVmOUZqdTcrN21aODdHT1JqRGhUQmlY?=
 =?utf-8?B?L0p2d3RZSExEMVhETEZDclhCYnVRSVR5aVgxWDEwcjFGZktSRWluL0x3blo4?=
 =?utf-8?B?citWWGVmeW5FM3JpVEhDK1pOK0R2Uk5kalZmQVBMRVRjNDF2R2NqaXF1dUFy?=
 =?utf-8?B?eEJCRUIzWEt4VUxEVVlFQ0FoTHRtWktVZ1FVR2F0SkdXQWhVQWd2K05hb25K?=
 =?utf-8?B?VGZMMDlXSzBrRkVkQ3FIcERWVGxJYWhMOHZZYVY2T0ptTU1XbU1lOWhpNHNt?=
 =?utf-8?B?NnRlcUFnR1ZzNTUrMnpVanVCc2NobnFqSyt6TjB6L0dqbUpVam5GdWNRTXpL?=
 =?utf-8?B?SzYyOFB4S29jTzltOUdqOEc0MEhiMkhWbkdvYTZOSjd2OGxUTmdUbjRtbnBm?=
 =?utf-8?B?akJsUVliWDMxYmZVSDZPN1ZzQnlPUFpjKzVKK0piVndiQmpBU1hZM0VUcDN6?=
 =?utf-8?B?bDR3ajFBZG5UNXh1cmNDQnVuTEdWSm41dS9zbmF2M2k5d0t6dm01QU1JVnBk?=
 =?utf-8?B?Y2pONXRpaEIza0xpd2NncmNWQXJweVJrRVdhd1ZTMVlKSUpOcGxPUnBBaXlw?=
 =?utf-8?B?QUFITnJpR3ZDQitHdXE2MTNRSUplRGdZUzVzbmxpbkhRVmlwSkh2U2kzcjNs?=
 =?utf-8?B?SU9raTVxcW5oeHBWTXVkSjlQbVhJOTNERXpsWDdXamFXYVBSNjc2TUJsZlls?=
 =?utf-8?B?aHJhN2hGcmg5dmpsL1ZNSE90U0x5bHp3VVVIK2FMeEl4V0I5S2VJUTRWbFp0?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 265dfc47-7bfc-47e5-0f4c-08dd76a13e15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 13:28:26.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3ts0Mn9Ejpc7rSbPo74A3yK3uoRZOm8CtW0x48dHzsBx/LYvQoyzIsSbhC1bmMlBU5bggQ/u2Skqg29c+2bQyAFZoerkpGivrRxQ0xFEHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 11 Mar 2025 16:50:07 +0100

> On Wed, Mar 05, 2025 at 05:21:30PM +0100, Alexander Lobakin wrote:
>> Use libeth XDP infra to support running XDP program on Rx polling.
>> This includes all of the possible verdicts/actions.
>> XDP Tx queues are cleaned only in "lazy" mode when there are less than
>> 1/4 free descriptors left on the ring. libeth helper macros to define
>> driver-specific XDP functions make sure the compiler could uninline
>> them when needed.

[...]

>> +/**
>> + * idpf_clean_xdp_irq - Reclaim a batch of TX resources from completed XDP_TX
>> + * @_xdpq: XDP Tx queue
>> + * @budget: maximum number of descriptors to clean
>> + *
>> + * Returns number of cleaned descriptors.
>> + */
>> +static u32 idpf_clean_xdp_irq(void *_xdpq, u32 budget)
>> +{
>> +	struct libeth_xdpsq_napi_stats ss = { };
>> +	struct idpf_tx_queue *xdpq = _xdpq;
>> +	u32 tx_ntc = xdpq->next_to_clean;
>> +	u32 tx_cnt = xdpq->desc_count;
>> +	struct xdp_frame_bulk bq;
>> +	struct libeth_cq_pp cp = {
>> +		.dev	= xdpq->dev,
>> +		.bq	= &bq,
>> +		.xss	= &ss,
>> +		.napi	= true,
>> +	};
>> +	u32 done_frames;
>> +
>> +	done_frames = idpf_xdpsq_poll(xdpq, budget);
> 
> nit: maybe pass {tx_ntc, tx_cnt} to the above?

Not folloween... =\

> 
>> +	if (unlikely(!done_frames))
>> +		return 0;
>> +
>> +	xdp_frame_bulk_init(&bq);
>> +
>> +	for (u32 i = 0; likely(i < done_frames); i++) {
>> +		libeth_xdp_complete_tx(&xdpq->tx_buf[tx_ntc], &cp);
>> +
>> +		if (unlikely(++tx_ntc == tx_cnt))
>> +			tx_ntc = 0;
>> +	}
>> +
>> +	xdp_flush_frame_bulk(&bq);
>> +
>> +	xdpq->next_to_clean = tx_ntc;
>> +	xdpq->pending -= done_frames;
>> +	xdpq->xdp_tx -= cp.xdp_tx;
> 
> not following this variable. __libeth_xdp_complete_tx() decresases
> libeth_cq_pp::xdp_tx by libeth_sqe::nr_frags. can you shed more light
> what's going on here?

libeth_sqe::nr_frags is not the same as skb_shared_info::nr_frags, it
equals to 1 when there's only 1 fragment.
Basically, xdp_tx field is the number of pending XDP-non-XSk
descriptors. When it's zero, we don't traverse Tx descriptors at all
on XSk completion (thx to splitq).

> 
>> +
>> +	return done_frames;
>> +}
>> +
>> +static u32 idpf_xdp_tx_prep(void *_xdpq, struct libeth_xdpsq *sq)
>> +{
>> +	struct idpf_tx_queue *xdpq = _xdpq;
>> +	u32 free;
>> +
>> +	libeth_xdpsq_lock(&xdpq->xdp_lock);
>> +
>> +	free = xdpq->desc_count - xdpq->pending;
>> +	if (free <= xdpq->thresh)
>> +		free += idpf_clean_xdp_irq(xdpq, xdpq->thresh);
>> +
>> +	*sq = (struct libeth_xdpsq){
> 
> could you have libeth_xdpsq embedded in idpf_tx_queue and avoid that
> initialization?

Not really. &libeth_xdpsq, same as &libeth_fq et al, has only a few
fields grouped together, while in driver's queue structure they can (and
likely will be) be scattered across cachelines.
This initialization is cheap anyway, &libeth_xdpsq exists only inside
__always_inline helpers, so it might not even be present in the bytecode.

> 
>> +		.sqes		= xdpq->tx_buf,
>> +		.descs		= xdpq->desc_ring,
>> +		.count		= xdpq->desc_count,
>> +		.lock		= &xdpq->xdp_lock,
>> +		.ntu		= &xdpq->next_to_use,
>> +		.pending	= &xdpq->pending,
>> +		.xdp_tx		= &xdpq->xdp_tx,
>> +	};
>> +
>> +	return free;
>> +}

Thanks,
Olek

