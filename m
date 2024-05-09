Return-Path: <bpf+bounces-29186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0588C116E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C72E1F22BE9
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4DF3FB87;
	Thu,  9 May 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyWXZHeH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD81A291;
	Thu,  9 May 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265821; cv=fail; b=DDCxsh6DS6PLXUQk0fW5FBM1xtzVGAf59EFKdZhvlEeu4iu49IQ/PEmo0BRKStulqWQg4gCPCALB09bvIEzVOSZZlBPBE5NIPXPGTxtRAnl+mBJWbjQEANmyCq0JPHICdU78+IoUAgxiFcePTuGVEjKkOLYzAsPSTH0yWtAg8n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265821; c=relaxed/simple;
	bh=EHLnZjg1n8uYk+AgWkTD9HVlW6/oEo2LWnIqEBe+yRc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KZiLLQTSxRsQYLv/xiTRw4c/jjiW5HAcwcvxM8wgw7kBNxK5TB6j8dR3ivRysySVsAMs5YEE1aBmwKEeRgm64cvRCPcToQK2rItKtAb1hwVrduXNUddEqGD+y6+jKsaUrmpFWvFU3dtloOiu4gq0J+abdAY62g1lNMW4YyO2Irc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyWXZHeH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715265818; x=1746801818;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EHLnZjg1n8uYk+AgWkTD9HVlW6/oEo2LWnIqEBe+yRc=;
  b=DyWXZHeHZrfrxHb60LUf37HWrkwPUa3D+fXTow9l1kwWwHLDaLzZDY8n
   zS0Cg0kNYW2uoWvgAAkQdHCzPOzkl2LJ8lgTqP/+YbfWLwbApaQcap2iO
   DCyyjUMdYmjx9IchDSO0sfuOLwOeTU2iprHczeow4h0+cMp1YHG3p0Uq1
   UvWKcOiUGCSrj5liIulXtx43UxT0eXS4Qw02qplmJ0YTMJFx5NVIpqLlk
   cj4nb23yzFAtdDXin+AsD0NpF2RQH3luWMhj7ru8UGQIQ0BX83qlQXp69
   TQYd7++crIUUtMIsw3AYuGScuL+Mr64A01nxy8/LQV6qikO7ZHJvsj+1H
   w==;
X-CSE-ConnectionGUID: fAZQ5WrJRGS7yd3XsvRshg==
X-CSE-MsgGUID: 1dRroEjjRVC+ZfeAtHEo9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11039569"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="11039569"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 07:43:37 -0700
X-CSE-ConnectionGUID: YvqOx7FST6SbxvxKKybnbA==
X-CSE-MsgGUID: xLYziQaQTqSTbIXZXy8zYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="33809952"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 07:43:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 07:43:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 07:43:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 07:43:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 07:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH4iuC0bhQsBQoy6ySSEsNgQLTYb9+UCfdJ2YeYhnS7b1pNwPZIy2TL6JjLZD5uabx76NOA05rq5RN0wCP94+wLuulFQilzQiQTCXB2SOS5l62BlBy972qwR0pCKg8m1EHpUnBXMIdIfbJjjoq5g+K9try16douZxfddre9VnpCRWwLAX37bGQnmViubMZHKQor30yFxftryDTH6uf9HFD0k4H4VBhncBrEOEMNDsnAXZOZ9R4xda3Ng8YoofnXZZHl+xCWvvoVPcFHtH1fOG3j6qBoQxmSlein7Tl5k2xcTBKcs2J64mX3YEtGRmTbkJe/HawojtlLss4Y3pc04rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeF0HeJt4jVOLQTO1lpy7yDGV2E1sLTr7roS6/C5exc=;
 b=GsWa3oz9ltWL0R+k+jhj1DXSLLMIwdDBMEh8W68ObY8tVJU/cX2/SThZRej7M+RxD9MEjhhRwf0H27QzXpmTD1jzpVoKbPQTqN1WTMKzrj1D+8ji3dFuxqPk9yGVkroOk9qEMEUv/K7Y9sAFJ/CrtxkLHa3M/nabXdH6jsv+I/nfI0VZlLvzVNHy6AHojjb4mWNDYWGyv3jm0QQAnktU8szt1f6n2qPVj4H93BIQARg7SAewq2XofHnIyRrbmEqB9qcHGlYzbcuSqp0kQPjMVFFgLKZFrmsaG3i9uWT0aesF1f2BycGYfvrfjG/NOLn7smQKrKsYuWxBPO+4dsWCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8009.namprd11.prod.outlook.com (2603:10b6:510:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 14:43:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 14:43:34 +0000
Message-ID: <f207da41-5222-4d1d-897d-9b288e33a547@intel.com>
Date: Thu, 9 May 2024 16:43:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] dma: avoid redundant calls for sync operations
To: Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
	Christoph Hellwig <hch@lst.de>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
 <20240507112026.1803778-3-aleksander.lobakin@intel.com>
 <010686f5-3049-46a1-8230-7752a1b433ff@arm.com>
 <5d6a26f5-5acb-4c5d-aa11-724399d1348b@arm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <5d6a26f5-5acb-4c5d-aa11-724399d1348b@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0002.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c5bbfa-1e6d-4d1b-db36-08dc703666ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFVINktJOGxDRDRqVGZZT2JXNjU0YloybXhVbDlLdFBoVy8xOGUzdG1pMXFn?=
 =?utf-8?B?QUpOZXFlVXNjT3BMdWtyL3NFMGJxSEE0M3ZvZEdBSjRZME01aG9yenJpWUJE?=
 =?utf-8?B?N3VKbEsxcVE0cFhvUTk1OTJRa2N1d3pYYkMwSUt4WGRsajB4N0hHNlFDbXJz?=
 =?utf-8?B?R1ZSK3BsU1NITnRkQi9kQUxnWkI0M0JBSm5wektLRmxJS1VTTDNSd2tLODAr?=
 =?utf-8?B?a1BJNGRrc3NNRkc2OHcwTEloNG9objhxbm5CZDNpNHVubmtyeFlZS1Ewbm1y?=
 =?utf-8?B?Znc3OEJXQjZIYjR2aFB6OWNST0tFOWQ1NjZGZjl3N1BHQ1Qvd0Q4YWxwWDhT?=
 =?utf-8?B?SnJNTXp0YzYwWWJxQWFTYWFCRUNzUlV4RlJuVlczakhNbDd3aEppeFp1MHFH?=
 =?utf-8?B?Z2RvbStwMm1SRkpNYUxDOHd6VERBZ3ZGL2VveGJTakUxcm01R1hDVXNVdjQ0?=
 =?utf-8?B?V3N2cXMyNTZpRGZKai9neHl4ZFlsUFlpakduKy9QMzlSQ2xFS3lTOW96VjYz?=
 =?utf-8?B?SGRJSmhINndzaVdCdEVxeXcxVkVYMFhoR1JIbk0xMGJ1NW5yREJwbVluREQ3?=
 =?utf-8?B?UWRuaDZCWDhjaFp0OWhRZEZhSUV0Z0I0M3FvQVZrRFpqTUcyQloxR2tHS2dR?=
 =?utf-8?B?dTFFbG1MOCsyZFFJRW9XTmdza2NqS1JpRWk0aTFiQ1k1VWNtQkVHYThJa3NJ?=
 =?utf-8?B?TmluZEZkZ2VicXlMR0FoWFd5THo4djEvK3gyeXA2Q2Rnc1N2eS9kQU5mSlVr?=
 =?utf-8?B?VkprSWlqNkxDdnVETXhuUzQ5Qms0QzRFSGFvakdhVVZsaGtzak1DclRoSE1G?=
 =?utf-8?B?NHEvSTRkdWRPaGJyeTZpVnJkbStOS25oZXd4Wm9vd1hrL1A0dHpQOVR0TWg5?=
 =?utf-8?B?R0VSM0oxL3dYZ0RkNklxQXpsNW9NanJ1cStUM2hSMVdaRXRUUEJMd3M0ckN0?=
 =?utf-8?B?b1l2T0lOSldlUGpxdzhQUXEzMHNkUHNvQ3ZjUU5oTi9KNUlkaUlwdVZwVWMx?=
 =?utf-8?B?UEJ3YlN3dS94ZEYzQTlsQjRzeDRNNzR6TGx3aGx5NDhBVVdCcnM1dEFtSFlP?=
 =?utf-8?B?eEpXeDVySjQxbEY2WjZZTHRuSklkV2VWSHBjRElRdHNsdXVrWS83R3JVWXBP?=
 =?utf-8?B?N0ZkRnllRmk4WUpURW03UmNWRmtsTUVmSXpBRGMzMGk0WEdqb1ZQTWRQbkZo?=
 =?utf-8?B?dzFaV2ROQkhmcytWM2V1ZEdrQk5qazNxK0gwaWc5YWpOcEtEd0pkVmtTcFdv?=
 =?utf-8?B?a2NzTDN5R2E1aTl2QnRQcXdONHY4dXQrOEZjZ2ZTNDB5aEtNTGJRSEFOUWw1?=
 =?utf-8?B?Y3FIOGxxS1BpWms2YjlYUndDa0U5cFhZWDNLZ2NvQVlnODRxWG1XQWM5WmtO?=
 =?utf-8?B?bldWOWhJd0FSTHhZZHlURnBxUFhTUXZST2VCL0taOS9lTm93eWM2OVo3dXpZ?=
 =?utf-8?B?TWJNQzhtVFZzdVNCYVY1cGE1bjJ2eG91eGNnWU8rT0NQT3YvcE1VY1VVbXhw?=
 =?utf-8?B?NVJvZ0x3VGNLd21IeHE5bThQN1J1ekVJSUlRSjhOdjdkVHJ6ajFjbUhoR29I?=
 =?utf-8?B?bGZVUnpoQU4xRVR1NElVeU5oQWpiV08yQmxjT3FwbDc3RURRc3MwOTdsbjJP?=
 =?utf-8?B?Y3JQTjl6eGJQVFBqSE5aR21iY21ML2NkVXIraXVUd0JyQVFmVkIvUGk4ZlAz?=
 =?utf-8?B?TkpiVElhdTcxL3lQQ2NtdmZrV2xJcFpMTWlqdjZLc2VJbGhFK3lCN01RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L001ZTBoN0tWVjRpS3E4VTRnRUNsOVpWOXI5ckZSYjNHK1pYSjNydUNlckpv?=
 =?utf-8?B?OEVOb3NwQ2RnMG5mcWFHcnhXTEtWcWphN1hFVUR0SmtRNGJ2RzBiM2ZUT2gr?=
 =?utf-8?B?SXRDRm5SaWpabERZMmdWcnRGRU95Sm42NTBJcVBVUmRTNTJXZ01CTFBsR0po?=
 =?utf-8?B?R21ma2xOREcvZ0NUSjFpZmNKU2dJTXZVRWlFM2ZhVVJlaTNYbjd3d21vWXBz?=
 =?utf-8?B?S0FJY1BLNXdvSE1iSmlmV3Y0Q0w3YzdEdzEwR0pJYkRSSWVUdEtGR1FuS0RI?=
 =?utf-8?B?a09oekNpS25mUjIvcHVTeVBSM3ZjWHBTaXdtZi9tYWlVVUdyMXJlcW5VR2kz?=
 =?utf-8?B?K3dFQTZkQm9LQ1VpTTNSVDJVNTVGZWxkTEtzc3R4QThHNG1ZV1JXK291YUtE?=
 =?utf-8?B?UUtMN2tKQTkvRnBhNzlLajZGMFBzenJBL1FkMTBZYkUzVkhtZVhReFdzdmtt?=
 =?utf-8?B?OEh1Y3F3dnJhTHJpNFJJeUxJeEhqSmk2SS96K1VGU0FpQlgyeHZVT2g0eFhC?=
 =?utf-8?B?WlZBQmo3WUt6bUV1dDNjUkZGUHFtRzR4MjFvTyt3LzNVeUZ5RVRBeEcrV3pT?=
 =?utf-8?B?bC9SUzBNWC91djdCWXRNbjRRZklhZlROQ0xNc1hGMHBya1RhcjFSWmNsUHBu?=
 =?utf-8?B?aVZIMFJvVjlSOHNQWW9yeFdrY0s4WHlaU1d2Uk9jb3g0MVA0Y2YzaTNXWnVE?=
 =?utf-8?B?R1pFTUNFVExKSk9IR29NYVM4WmYrVGFpdWF5Z0hrc0l3WWRJUUg0dDdrcW00?=
 =?utf-8?B?WnBGclRnT0FvRjkvSm1uZ1FxVlRmb1pLTGlwajAyV3orcXlkQ1RwalUzRG9N?=
 =?utf-8?B?ME1RZVlYM3hEL3dzWkxNb2NaRkFwNnh4a3h0M3BwSzVEZ3RoT2ovOVY3V0U4?=
 =?utf-8?B?K3NqZGFza2dkaFhlbWpxdzFmRDh4Njl4cmZRbzI3K3F1Tlg2alRvMFZYU2ZP?=
 =?utf-8?B?eG1FV0p5T1NZT0NJaFNJT1VqQTU0dU04dEkyclpxbFlRa080WnFETzZoczYv?=
 =?utf-8?B?cVk5RzdsZndXV1BZWXk5ZStaM2RDZmV4U0lreXpOUVExQ1ZkeDRCYzNXMWhx?=
 =?utf-8?B?WGdNV3c3WDhXS3llZGtSdlBWa0taSVc5VStiZHRtd2lhdXpRS1d2TUp2YTJH?=
 =?utf-8?B?bzBEOFJrYUFWOG5pVzNIUkNmK1dLbTZXZGFjc0JmRGpjQVQ0U3dnQXA3M3hZ?=
 =?utf-8?B?d1pVcjYwdTVDdFk5RjdDNkN4cTYvNlRRU3FIMWZtZ043aVg5MU9rcWNCdXRs?=
 =?utf-8?B?NzBBaFdJeUswdUxpREVIK1hoMjNsOG9qb3pQY0kwVHBSQmhqL1NIVUlmVFQ4?=
 =?utf-8?B?ZjE4anBuakwwMklhbTFEUlpQK1hrYUo4Y0JGUTY1ejdobDlIL2xOUWpzNUN6?=
 =?utf-8?B?Qm9BQzNaTjh5OE1UVXFXaTJhZHMweG5aQzhORVd3dTRacHNHLzVMWGtBWFhv?=
 =?utf-8?B?MGQ4ZWVrczVOT1VEamZIWVZMZ2FJQUdDMEVIZkNHZks2U3VUZmZkY0FJb0xu?=
 =?utf-8?B?dUU1dzVuYUV0OGpoQWtpOFlHRGpaSW9pdUJqaFpVUUJuNFlpUmNKTGNDMFZS?=
 =?utf-8?B?RG9EUmpoS0ovUVV4YU5NdEtGZTBGU1pzSXRRenNCUzVjVUhvaGlyR0NaVzFR?=
 =?utf-8?B?VEtCMDBmNisrNkNlemZ5WHdQTm03eXQrVEpFeXZ6WkZMWU5yMnM0RENVYW5u?=
 =?utf-8?B?clFvVFI4SjNZRHRxNmFDRldZTlpuYStTNWZBQ2RKL3pubTIyK29VODgyREZH?=
 =?utf-8?B?b05jUzZseGdVVVlpTzNreVpWYm51QzVaai8vb1lTR1BLMzF6RzczSzhzWVZ0?=
 =?utf-8?B?SWVoOWRjN0V0bjh3bE9KRi9YMEs3RUpCUjV4TUlRWEllcWp5anBwbm8wOXo2?=
 =?utf-8?B?TmFWbWI1WWJaWWRvb2l6aUdkaGtCb3UrTUhXdlpjK2tvRk95OFVpK3RQRmNa?=
 =?utf-8?B?WHlZc2djT2dmRVFpQjFDd3NrWkpEaEhEMVp1OW9xY1BYTi9tbnpmSXhiOElN?=
 =?utf-8?B?U01nTmdPTnVnUk5CdGtiR3I2eUVUQzhMVCtQK2lTL1ZSL0wxQWxZYzlScTJH?=
 =?utf-8?B?NDlWWG80TXROQUF4MjQyNTRqRWdJdldkQUhVTDIzcW1VVVF3NVBpS2U1c0Iw?=
 =?utf-8?B?a24zaFAxUy90TFh1cmFYWjhRdzlUcGJHOVZES1dwaHBWWTB4cm1uUys4RjZa?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c5bbfa-1e6d-4d1b-db36-08dc703666ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 14:43:33.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PaaxB6PVbH1rzb/F9UmMMZPOOn0pLAy2xbSWZxmIzfbDxkyK355azC1w8ZAk3++PrdkObFncPlFXbrrhRMwSQkPWnBqpTxjlDV4TQfr3mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8009
X-OriginatorOrg: intel.com

From: Robin Murphy <robin.murphy@arm.com>
Date: Thu, 9 May 2024 15:33:13 +0100

> On 09/05/2024 2:43 pm, Steven Price wrote:
>> On 07/05/2024 12:20, Alexander Lobakin wrote:
>>> Quite often, devices do not need dma_sync operations on x86_64 at least.
>>> Indeed, when dev_is_dma_coherent(dev) is true and
>>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
>>> and friends do nothing.
>>>
>>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
>>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
>>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>>
>>> Add dev->need_dma_sync boolean and turn it off during the device
>>> initialization (dma_set_mask()) depending on the setup:
>>> dev_is_dma_coherent() for the direct DMA, !(sync_single_for_device ||
>>> sync_single_for_cpu) or the new dma_map_ops flag, %DMA_F_CAN_SKIP_SYNC,
>>> advertised for non-NULL DMA ops.
>>> Then later, if/when swiotlb is used for the first time, the flag
>>> is reset back to on, from swiotlb_tbl_map_single().
>>>
>>> On iavf, the UDP trafficgen with XDP_DROP in skb mode test shows
>>> +3-5% increase for direct DMA.
>>>
>>> Suggested-by: Christoph Hellwig <hch@lst.de> # direct DMA shortcut
>>> Co-developed-by: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> I've bisected a boot failure (on a Firefly RK3288) to this commit.
>> AFAICT the problem is that I have (at least) two drivers which don't
>> call dma_set_mask() and therefore never initialise the new dma_need_sync
>> variable.
>>
>> The specific drivers are "rockchip-drm" and "rk_gmac-dwmac". Is it a
>> requirement that all drivers engaging in DMA should call dma_set_mask()
>> - and therefore this has uncovered a bug in those drivers. Or is the
>> assumption that all drivers call dma_set_mask() faulty?
> 
> Historically it's long been documented (at least in DMA-API-HOWTO) that
> a 32-bit DMA mask is assumed by default, so as much as we would prefer
> to shift expectations, there are still going to be a great many drivers
> relying on that :(
> 
> Perhaps its time for dma-debug to start warning about implicit mask
> usage, maybe that might help push the agenda a bit?

I also thought of this, but currently don't know how to detect whether a
driver has called dma_set_mask*().

The fix will arrive in several minutes.

> 
> Thanks,
> Robin.

Thanks,
Olek

