Return-Path: <bpf+bounces-29169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF98C0EFA
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 13:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBB01C21286
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA90B14A4D6;
	Thu,  9 May 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACn0A3S/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE44131750;
	Thu,  9 May 2024 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715255118; cv=fail; b=QxKxA5gKoPLpVSwpVDVmcc9VvCxFXA3+YchE8A9TbwDG+ick2lGtFd76WfVc+B1xBbzwSYbAX7fT+Cg7/+y9GQNdUEkWJksA1nHbujQK/SVDQ1HdQGXM28W6JsDEq5FSKLjUtgCULdTF7DT57EqNakRgi0PnBeIFgKevEFhBIV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715255118; c=relaxed/simple;
	bh=ZI27zjN8mDrs80fJF74iOQlX3Cq8BsNXIJVSjLCccxw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MAAxI3iQ5snC+4gzgv5vlMF3fTqTuNKv/jKaIKvwQEuScQGJiE4N3DsRdcfZ0EQMQyUZLDAYkh1X27yD+IU13cATpnmv9ZooGmrd+OtP0e9/v/uG94hI2kKkc9qT+zVwvyzEJsZ8IaOsLejDtOySnLrvxvhr9MBS4pOK9DCqbO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACn0A3S/; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715255116; x=1746791116;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZI27zjN8mDrs80fJF74iOQlX3Cq8BsNXIJVSjLCccxw=;
  b=ACn0A3S/sZqcGiToExuVCA3yCV5hvyfElemc3jMD7p1nWKPKWJUrtOZy
   q6KTDOYYw7Clesp4YSmezJKepyTP+Y4VRDUm5YqQ+daCka5JcYn7UIt5F
   Pug/L2XdPzSUF1bSvkQYUnn9Hf/nKJuXm0cuxRDXjralQ4KKVRSMTRUqO
   heykcx7MPuIz035XvAEIT5rokfr9pQN685sl00Yj/5u7R67s1iX2nSotg
   rDtITK69xPONKwZ5AyvpscsiquSGwf++RifEgPOnLs/H+/bEJXD6GtK29
   zbhFyoLNXfpYmX6IRqki3K9j+OolwbbeXlsMqGcG3UeiRtkpBbiAydQUK
   Q==;
X-CSE-ConnectionGUID: xKbQKdXzT6qJ1SgmdQqiTQ==
X-CSE-MsgGUID: aFB4aO3kSSO6KtlD83oUTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21766334"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="21766334"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 04:45:15 -0700
X-CSE-ConnectionGUID: js93eVwrTjm/6PQFWZLV1g==
X-CSE-MsgGUID: d9PnLZ0EQYerAqPQBnjMPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="29195903"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 04:45:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 04:45:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 04:45:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 04:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMm7eVdk7/LlYm4LZrvT/R1PyLa9tEYfa2IFPqW00sDMLoUwE4guUtV+/qN2TNiYkt230pBEwZ48wG//mr798cfu48MwEorGp/0qYRtuqAhmPZdKwwkUporem6/BIDNas1xh5aQ5Bxooy6HPpziKKEaYCwZI6a40Nl4S3Zo6y+ny8IERkRHbp9lftJXTk3ZLqwRK7hcOF6Xt/nwFIxmixP32kdPch/kdtTu8aeebW/1h8W9xtMOMlWwhrG8WCLP4ETk8bAUwnr0UZl75zrylZ3Ll9ObZVm40hcV7OzxN9niDqcTggtsdn98IA0EH1RYdqMvHf/55Qz2zw/joayM+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03mH8E2dFaKE6r/wsfZ+ntE6WKOClmnxcLE0SngEk94=;
 b=i9snMG5qBZfM+Qx60KXevKF+LeyTyRiPcxKOajh1peJ68s4A9VW86XNAeIChiNvREG1lobsIYRBvaLIotBDkaIOWz3p38Jb24YBiPlIffBS+pOP3TN+V9xZsvhB0kSIz1Jt/nRGON0iBdHx3mJ3CcnHNVDyoQs3vJ46T1Wa5yZGPap5T2KoAfE4F46ew7iC0PEePZVTJMabz/okVPhwSH2Tkp+9bs/i6QI66bx///v6uxDkHKER84CPoRgynHXWlO5EMC86EduQ+UCVQQ5k+Hqd2cmf/PQ53mEYnL+G78RzbbhHOUVMVsArIPLB4ZwcYrFHeP3yZIDfIS3LZd6Rmzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7848.namprd11.prod.outlook.com (2603:10b6:930:6c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 11:45:10 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 11:45:10 +0000
Message-ID: <b4632761-3ec6-4070-a60e-b74c1bfdd579@intel.com>
Date: Thu, 9 May 2024 13:44:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] dma: avoid redundant calls for sync operations
To: Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig
	<hch@lst.de>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
 <CGME20240507112115eucas1p117bc01652d4cdbe810de841830227f47@eucas1p1.samsung.com>
 <20240507112026.1803778-3-aleksander.lobakin@intel.com>
 <46160534-5003-4809-a408-6b3a3f4921e9@samsung.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <46160534-5003-4809-a408-6b3a3f4921e9@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6d5e46-e30a-4d49-30cd-08dc701d7b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDJkR0ZZSFBWYUR5K2ZxbDU5cHRIK2dPN1ZmZ2VsNkp1djBMUERDVkZ1VnZQ?=
 =?utf-8?B?ellmbmpURjBOYzhSVEk2WTdGeU5DVWRtTTd0ampYMEZETlNIV0hsL29lOVBZ?=
 =?utf-8?B?MWUyR1ltajJMTkM4TEZObHNmYTNTeHo2RUl2S3crN2owdFNHYlNqUVREYUNi?=
 =?utf-8?B?WVVVaXNKTGVTQzU5VVJnME1SbEdNamh3bnJ0dXAzVEM1SFZTem5reFlPamFX?=
 =?utf-8?B?d1VjWHZvQ1lONVQyeGl5dUlCVTRXNVRqN1BNZUJLY3loOGNYaHNKUk9OSkNR?=
 =?utf-8?B?ZWh4cWY0emVDTk1pSkFFQUZPL0lNRXNZbzlFSUw2MG4zRS9CRlR4aVNTVVV0?=
 =?utf-8?B?S2IzMCtqUnNETHpuZTN3b1BNK25keUY3VnRFMVlzRno3dU9ZWGlVeXdyd1cy?=
 =?utf-8?B?ZzNkMWFGZ2FYNjJTcEZ5bXNnY0NkOXBmTTVIaTR0VlBwRkhPbkFuaE43cXV6?=
 =?utf-8?B?WWVOa1J3RklqclMvRSsxTk5LWXgvZE5ORWtHNGQ3N3pHVUE4UXdydTEvQWRI?=
 =?utf-8?B?VjNJWVh5RkVMeUw3dmc1MXZjd29Nb213Ky9rUTlOeWlTU2JhazcvUVgxQzFo?=
 =?utf-8?B?UXVQRk9aY2NWeE01WmlaNlp6UnZvTTZMb2hwbk03a2FoYlZGWVc3U0I0S20y?=
 =?utf-8?B?MHIzcjF6ZzlqWStvKytRcDJZczZ5S3NlUE8yY0g1cTdiSnJlb3BsMElPVDBl?=
 =?utf-8?B?eHRWeDVMRTY1ZzhzU1VBVUJVYytzR3Bqbjlvb05LRFhMU1l6cm9ldVRhQzdJ?=
 =?utf-8?B?bGxyeTlGRXZHTTViZTlrNFhVSE80UmowNDUxNXArcURKVFBVOUVvdHh6bFNh?=
 =?utf-8?B?cEx3VmpyRWY3YkEyMVVya2RGaVo0TTRKelhJaHdhQUhEVHU5M3NJRURmL0dT?=
 =?utf-8?B?bEowZk1yRUhHdUZkQUlkcTdjdUo5bmVXL28yaUJJd25nTDNsay84eUs3WWJT?=
 =?utf-8?B?UVp4OEI0dzBuWTNOWG9tTkxOckEyaTYvMkVNRml1dUxKbFNNZzlHQ0g4dFNz?=
 =?utf-8?B?eEYrYkF0RXVoVGJNSGN6SXcrWCsxOExSNEhvZ3k5MGNhTXZMNTB5OGpwOXBw?=
 =?utf-8?B?Y2RvRXdrMXRrR3ZJZkp5OGJvQU8zKysvYmt6SGp1cnk0NHkrNmxNRHlJSzZv?=
 =?utf-8?B?eEZIL2JzZjkzb2owb0VMc29PSis1RnYzM2I3ZmtPU3lmT0pMZW12WlZESTBS?=
 =?utf-8?B?K3NyUWVURnR3NGxKMytFWHBnN3c0eXEyS3F0T3c3K2dneDhwam1zTHRMallM?=
 =?utf-8?B?NWNCZFVFZkJZK3VEc3hpL3ZpaUd1Z2Yxb1Z1YzFWd1V3NzdCaFZXUURkMUp5?=
 =?utf-8?B?TnNXOUFWNDB4d0MzWGJLNjhVSnZtTjJwRHpqZDVsVzVMM0c3b29YS3FiNlRu?=
 =?utf-8?B?VTZ4anIxaUFOY05uSWp4R1VUZS96U1VwUlQ1RlYvMjZaODI0ZkQ3aFFJRXVw?=
 =?utf-8?B?c0JxLzM2dmtuTCttSFc2amZreUdrWXRCSFdLTHg4RnZDVmttdnN6bXhzRVIy?=
 =?utf-8?B?b3JEV3BIbnY4cWxIMXlLbTlqMDY4N1pZNHU4NUt4UTNqTHpJNmoxWnNkMzRz?=
 =?utf-8?B?am9xNTI4WHNGOW1Rc2tUQ1pxeEpaNTcydldXWG92MUN5eGUxNnFucE9VOHhp?=
 =?utf-8?B?eVJ3dXR6c2R5N0FoSUZ3ak5uMWZNRVJ0S1p2ckpTeElQVkM3dExmOVlpNy9C?=
 =?utf-8?B?V3diYTQ5aDhmSUpLZ3hNVmgwMVlZaWlNaTR0YVA5dU5lYWtrR1JWK3JnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNvTFd5Mkl5S3NuKzZPNkhiaDNteU52VkF3TStYZlhHcVZ2V01hMlpib1dU?=
 =?utf-8?B?T2REVU1SMUVwVWpETThrUmU2Nm9MWStXWm00bjlwaVhPbTE0Y2F2YWhYYWVJ?=
 =?utf-8?B?N3NmcWhmNmxFZlp6YnN2MHFHZURyd1lITWFzMWxXc0RtM0R1S25HQzlXVHZv?=
 =?utf-8?B?bGpjUVFkTk5Vc2tmR1F0YTFkT0tlbzZlblBQaytRUmlUSzVmUk12Z3NwVGpY?=
 =?utf-8?B?aGpDRUF1dHB3UXlWUjd6R2tVL0tEdzJQK2hTY29Fdm0zaXM5MlNiRWg5aVlZ?=
 =?utf-8?B?cFZNWmhzbWxtZ2hydlVmUlo3VkxVeFhtZFpuOHdDZisyTWMvNm1iS1FSZkdp?=
 =?utf-8?B?aTdQWk5iY0tleExIUmlxNTJZKzN0OWJUZVdsczVSN2dVUm0wRnM3SGE1Yzdw?=
 =?utf-8?B?TXpocE5wNEVnK2trTkVjZVNUMnVpckkwMnhoc2lMWU1GNzRuNzF0eUIrYVg1?=
 =?utf-8?B?VHcyNW5pUEs5MTlpM0M5SmY1UytaVUk5NGZVQ3dVV2JzdStXUXdhQnVpSnJ1?=
 =?utf-8?B?ZG56bjFZY1dFNDljSGRpeWlTeGRYS1Y3OTNsRTBmZDdnaUJhM1UwTTNFY2Ux?=
 =?utf-8?B?eTJ0OUxBclM2UFVvZEJkVi9rOHJBSjgycE9zS1pXalZsTzJHWnc3Ym1qN2Q1?=
 =?utf-8?B?UmxVd09iTjRjbVNWUEp4YUdkVUc3OVVQRnVQaUFwdGhndTNWWWZHV3I3UXg5?=
 =?utf-8?B?V1E3d2pVOVl5OVprNlhTekluZ2NSZHU0V21YM3RiZXoxZVN0bzI4RnF3N2d2?=
 =?utf-8?B?bnFoM252bS9HRU9lK2k4ZkQ1NTBKbDd4cEcvU1BBeXhhSWk4SzZUL0dPOURQ?=
 =?utf-8?B?MmExOWo1dEpNTWNTOW0yVlpRTGRtTFlkSTlIa1pUdUJPYnJZeU5vT0VSMGds?=
 =?utf-8?B?TkdDSWxadUhBKzlycHgyZFo5aEQydGhpU2ZUdkYwUko2cjVkVEtRclRIbk83?=
 =?utf-8?B?YlhMWG9ZYTZRbDloQmxSUHg0YWFLWW13R1hxNmFSbDA0cjRqVWg2MzRzU0o1?=
 =?utf-8?B?c0JUbVovZGNVWldmNi9JREdiQ2pKbXM3VXhMS0FPcHZQcTdRTkJWYVRUelEx?=
 =?utf-8?B?SHE4enNwWm55WEg1cHZpaFlDYzBtVEJ6RzQ4NkRTTC9PbUt3WVAxazZaOGZ4?=
 =?utf-8?B?cDliMFJxWXhvSUtsMHlFaG5kOGtDajJMZnNaNjlwc2t2ZC9GRk1BWnBERGVK?=
 =?utf-8?B?M1V4RkhFcHR5bzRjMzFHYmxIQ3BiN2xVb1pIRVcvSWswcTJlcTg4Skpmd1NB?=
 =?utf-8?B?SFBqZmkyQ21HcXRZRFg1TnpORDFld3J6RFFsZGpvcWRUcXZEYXJzayt6MHk1?=
 =?utf-8?B?QW9nVVpYSXdOVnFQcFBJSG0xWkE1TFQ3SEZPbUQvSnZBL0VYT3VZcUlkdGc2?=
 =?utf-8?B?RGFHWmlFU2hCZXFxZXVNWWJxcGpBaDVFNXp1QTJSU0Y1K2UyeWo0UDFzQzZj?=
 =?utf-8?B?MGcxQW5DVEJ5aFpvbGwzanduUXYzUzgrOXMzNGt0WVI1ejZXQjdJSitqcEV4?=
 =?utf-8?B?TkxZNkVlNjh3bWRDblVrMDFnb0FwS0YzcmFvUjBubXNTMGZiaTc2MklCcld4?=
 =?utf-8?B?M3IrMFRYWS9lQ05BM1JZUGVuQ2l3SWhxdFhJYk1jZlVkQlVTekhXeDFMbCtC?=
 =?utf-8?B?ZDZDdDVoamlDMERTRFgremQ0aHFEVS9STUI2K1FQZ3k2WmEvUjBwVjVZbVM0?=
 =?utf-8?B?S2tPLy9qUzN4V080N3RtdEtHWjRjc24rTEF3SUltWTAvY1dBSENoZnZRRFpm?=
 =?utf-8?B?UVI3c09paHVLSU9KUmtpc0txVU9sTjdBRGdDL05DcEE4UEI4cU1TNFpERGlT?=
 =?utf-8?B?U0xlMTIraklkdmF2Qit6UitlaGYrYXBncHNQNFdFNUh6T2xhUGQyTGhaSmor?=
 =?utf-8?B?MnZuaWV3V1YrWHJFa1YvSmltWFJrVlFDc1E4Z091L2lDQzlRbnBKeGUyK1lY?=
 =?utf-8?B?SmwzVTVxVHBjQW01V2R0REc2YVhxU0p0ZWRvUW11dGtXSVZ3dVAvcXEza1Jp?=
 =?utf-8?B?bGluZmxsNTJTaVZ5VDJ0b1RXNEJtQTJacjB6SnNUYlZrK0ZmUTA3WE5zZHJZ?=
 =?utf-8?B?aDdtZVZhZFBsYUQzanZaZkdOOHoyNzJxbWpQbVV0UzNMTDVLdGdkS09yTnhJ?=
 =?utf-8?B?cTJXR1FGajdoRStiYlVuRDE0bSttZFRVM2pzZlQ5eXNEZXVYRVJJeldBQ3Q2?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6d5e46-e30a-4d49-30cd-08dc701d7b37
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 11:45:10.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIkn3X3eG7BruJdiphVxLjIrR7mYm2RnFvrjAtqFZWWTFQPSZmv5q5X26+yg8npDz4G9p/90A318pVfRaNZZAGfWgvYOpq6vYFgUHNWNtTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7848
X-OriginatorOrg: intel.com

From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Thu, 9 May 2024 13:41:16 +0200

> Dear All,
> 
> On 07.05.2024 13:20, Alexander Lobakin wrote:
>> Quite often, devices do not need dma_sync operations on x86_64 at least.
>> Indeed, when dev_is_dma_coherent(dev) is true and
>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
>> and friends do nothing.
>>
>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>
>> Add dev->need_dma_sync boolean and turn it off during the device
>> initialization (dma_set_mask()) depending on the setup:
>> dev_is_dma_coherent() for the direct DMA, !(sync_single_for_device ||
>> sync_single_for_cpu) or the new dma_map_ops flag, %DMA_F_CAN_SKIP_SYNC,
>> advertised for non-NULL DMA ops.
>> Then later, if/when swiotlb is used for the first time, the flag
>> is reset back to on, from swiotlb_tbl_map_single().
>>
>> On iavf, the UDP trafficgen with XDP_DROP in skb mode test shows
>> +3-5% increase for direct DMA.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de> # direct DMA shortcut
>> Co-developed-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>   include/linux/device.h      |  4 +++
>>   include/linux/dma-map-ops.h | 12 ++++++++
>>   include/linux/dma-mapping.h | 53 +++++++++++++++++++++++++++++++----
>>   kernel/dma/mapping.c        | 55 +++++++++++++++++++++++++++++--------
>>   kernel/dma/swiotlb.c        |  6 ++++
>>   5 files changed, 113 insertions(+), 17 deletions(-)
> 
> 
> This patch landed in today's linux-next as commit f406c8e4b770 ("dma: 
> avoid redundant calls for sync operations"). Unfortunately I found that 
> it breaks some of the ARM 32bit boards by forcing skipping DMA sync 
> operations on non-coherent systems. This happens because this patch 
> hooks dma_need_sync=true initialization into set_dma_mask(), but 
> set_dma_mask() is not called from all device drivers, especially from 
> those which operates properly with the default 32bit dma mask (like most 
> of the platform devices created by the OF layer).
> 
> Frankly speaking I have no idea how this should be fixed. I expect that 
> there are lots of broken devices after this change, because I don't 
> remember that calling set_dma_mask() is mandatory for device drivers.
> 
> After adding dma_set_mask(dev, DMA_BIT_MASK(32)) to the drivers relevant 
> for my boards the issues are gone, but I'm not sure this is the right 
> approach...

If I remember correctly, *all* device drivers which use DMA *must* call
dma_set_*mask() on probe. That's why we added it there and didn't care.
Alternatively, if it really breaks a lot of drivers, we can set
dma_need_sync = true by default before the driver probing. I thought of
this, but the correct approach would be to call dma_set_*mask() from the
respective drivers.

> 
> 
>> ...
> 
> Best regards

Thanks,
Olek

