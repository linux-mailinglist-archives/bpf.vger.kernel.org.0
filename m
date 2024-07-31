Return-Path: <bpf+bounces-36155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616AC943444
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 18:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846D71C21A07
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0443B1BC093;
	Wed, 31 Jul 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDKoVkeH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277A1B14E8;
	Wed, 31 Jul 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444085; cv=fail; b=c8sTA6wzR0jxXhktBaC5L4Azo7eQQpP0zLm9IaLU+FJ2WMU0eCjr8DdTqGgTHp2Sybh9Ia84H0SSjaeOZ53id1uhTAHmh94EKlRgyHp+YHf0BzhxtRMfcQIICD6paPuMPnf5B8rvho5AhCmQmf7vCpn4E03cqjGUA9ofho6A+Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444085; c=relaxed/simple;
	bh=FTmxEPe/xBwvtMWeEX3wn5kPZyA7wKQ+gE1eXkr61U8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p8m9J3DpdbdPapQEb8WSVbFiCoVpWXJK44eZxz5Nib4upjmnv/aUK4QiLY4jTtqory35jqDIPn8cxbfKK3idhaRtfYTi7UtUG5zHM692iW5GCSPK83uqf9rO0IGIwTrAuTEhhwh6IB6mKvE1zppbTKi3tcWyqLoj6kHt5kkVr94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDKoVkeH; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722444084; x=1753980084;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FTmxEPe/xBwvtMWeEX3wn5kPZyA7wKQ+gE1eXkr61U8=;
  b=BDKoVkeHxh0cNJY1XX/Jt6tQq6m5auahNJyG8vQdRU2c3W4SoxNCyKaN
   lHbRRPL5eUT50XkF3BzbaAfOSHSXgB7iQGbWwN5bd0I/F+DjGBJxT3/Vf
   5Ka4YkFFfJs2vWChI2pCcAlqHi8Gn6I2lKW9W71xxGwf+JE5pjDqG+laP
   7Bibhtu7xRcDz2UgnG/OV/50SIZh24RmKguX2InJySC3ZKJQ/vc3lPRTT
   cES05yEj7F0W0+cGSq6YOgYqUhoMd0OdSanX9S/sEP+gs3gj06hZYKShN
   Kgh71jobls2QmSIW1d332bzk9maOUilyXwYGIjdC5XUGwVfnlTDCmRQZn
   g==;
X-CSE-ConnectionGUID: BwSeAg7nR6Gviikf+StxMw==
X-CSE-MsgGUID: rM70vUitSQGWOoE1+C3a8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20497252"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20497252"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 09:41:22 -0700
X-CSE-ConnectionGUID: z6sj9RyxRxm+4sopeonmbA==
X-CSE-MsgGUID: yxumnF4xTwGt8a65bXFMxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54727381"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 09:41:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 09:41:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 09:41:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 09:41:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN/RaPzvQUBFHr/+mw+Ra0Rit5VLFqmHYExIVY7v7MD06RNtw22ONiouPpNJAS2gOuIhk+Gm5KOTOgZcNJl3PSH4nMwlE5+Tc747wF4o5kYwzYWh3iqif6HSJ3Bo8SwwuqrNPz6U9bPyqKDpCOtCjrSAoOwAQI9bUSjKxKG+9gq9py5DcipxuSTT96kxX21bunMip6kVAWFPgqi+RxA50weLKnYOxfZUwN3FkXU0jEl7zAUdXKvFb52+QVXD7sH9ZM8bETnxWJNWK/pYtxU9pabIdJxNIUVe0sH2Baq22+wuiIh0qGGh3SvPzZQgAjLgxSv/fUSKhmFKUJRmThgtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvyZ8kXiJad2cCeZUPSrLy1r5A8rnC1Tp70Alx3fonk=;
 b=duRLj2XyXQBbheAqGeGe90HTJkmDrPSsUp0mewN9jG39IYzVvBmuxfSlgeqdLlt9rKQajwUso5eOSP+KXM6LW1kgOyy0pPGHAFqX4nivWu74orA3CeDQmC5HdnhaeVhohU2RP5OITIru1UNIuxS/7WL6XXqaTEMK4k8AgX4iDiHExpXY/uxIiTIsDfdz+aQ5B4einRBU5uqhMS2SxD1Y8eKCtgIZYVZP0LcyG2b0FKYTalxwV0eJpBX1fhwaDna+s8FzQt6xigqcyN0GxgOK3ZGshL9345prxg3+YSWlBlM+lv7Gu7eACH6OqViGkRJjyJZvaRghRg8ZXHefoG/z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 16:41:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 16:41:19 +0000
Message-ID: <d805bea3-cb2f-4e2c-a07a-27b8b4c5f294@intel.com>
Date: Wed, 31 Jul 2024 09:41:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next, v1 0/3] Add Default Rx Queue
 Setting for igc driver
To: Jakub Kicinski <kuba@kernel.org>, "Song, Yoong Siang"
	<yoong.siang.song@intel.com>
CC: "Neftin, Sasha" <sasha.neftin@intel.com>, Brett Creeley
	<brett.creeley@amd.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Blanco Alcaine, Hector"
	<hector.blanco.alcaine@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>, "Gomes, Vinicius"
	<vinicius.gomes@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, John Fastabend <john.fastabend@gmail.com>,
	Shinas Rasheed <srasheed@marvell.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Paolo Abeni <pabeni@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "David S . Miller"
	<davem@davemloft.net>
References: <20240730012212.775814-1-yoong.siang.song@intel.com>
 <20240730075507.7cf8741f@kernel.org>
 <PH0PR11MB5830E21A96A862B194D4A4A5D8B12@PH0PR11MB5830.namprd11.prod.outlook.com>
 <20240731074351.13676228@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240731074351.13676228@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ea7465-c0e6-48c8-00d2-08dcb17f9aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFU5ZTdaU3FUb2I4UTFhTWhKN2FaZVVoS2xJdmUzTktPNHljNHRCWXJkcTFr?=
 =?utf-8?B?UjFGME5PN2YxRUNNK2Q5dWlHTnRVejVmbzJZN3prTTBvWkxxSXhjcWlucWR3?=
 =?utf-8?B?dDB4RmEvUkdRV0F4WXZJcUJncnpkdGVycUVwOVkyajd2N20vTUU1NUVvN0JH?=
 =?utf-8?B?elVxV3ExWm9DTU9UQk1MR3lSdmpSd2xubVFZeWtDQ3VnbEpML1VOMG05M2Zp?=
 =?utf-8?B?NldjUVcreGl3N2Q0eFF2cnJtRGE5dzJ6TWFLMUxVTDgzamdwdlJhRDdqQ3Zh?=
 =?utf-8?B?UHkycDFwYWJNS1dGZlFCNk1aUzdaNThUS2g2bkpUYVJ0R0IyeDlpSUR1b3JD?=
 =?utf-8?B?cE5GeDcrVEdXM0FDVWM1aEFJWklqOXc3QlRKbndOdEMzWXZiUkFmQTBqSFM4?=
 =?utf-8?B?VWhuazMrRWdqUUlTVi8wMFZZbUN6bk5yazNQVVVuY2crNnVvK1BCTU9jRGJV?=
 =?utf-8?B?UkFmTG5wS3VBS1MwNU80ZUZxM3d5c0RQWFJuV3djcmpQRlRyZVp0WlhKVUtR?=
 =?utf-8?B?UUVLNkVJajhVOXIyVVhwZE5YMmVtOGtaVGRJVmxBbWViRVZoMmJtWHZRUU9V?=
 =?utf-8?B?eTlrMnM2UEREOWhFb1dET3pUeHVHZGZuMkxsZUJyd1VRVmdaaHcvZXVJRUF0?=
 =?utf-8?B?MElTYldkSlE2NG9qK1E5bUpWK3pHc0Z0Z2I5V25BcHFIVEZ6dTRiWDN3MkY3?=
 =?utf-8?B?VzZPVW8wVzEvK0trNlp5VGJyaWJqMmhwczE4THQzN05yQ3R2Y0pQOFdNdUlp?=
 =?utf-8?B?SGFxY0pTQlpNN3czQXorbXZwWTE2Tm9ESzBrSzdSa1BQVGUxRWRta1FETWRO?=
 =?utf-8?B?NW5DalJsSzI0UzMrMVR0YlBNU1M4amQ5ZisxMGlrN2ZkZUtrQUN6K0cvblZS?=
 =?utf-8?B?enY1VDNGQ3VHY1UrNkJjMjU4ZGc4dU9udVUwVC9vQlBManlvWlJJb1RVM3lZ?=
 =?utf-8?B?RzFIQ3p4SHd0QzkxV3JtaFJPRTZJaS9PZVFSMzEyVHFtVU12WmhpeU04UEVj?=
 =?utf-8?B?R2w4anYxWE1hNHlkcTZOdmRweGRFemtBSmdQVkV3dVM4NXR6YUNvYk04cDBL?=
 =?utf-8?B?cnVnSzNiNElTTldSekJoMVFNcDFGb1Y5K3I2ZkhJblJmSU9iSjdsZkZTcnFw?=
 =?utf-8?B?NzRhRzRPc0YvWTlYM3FnZVdlZ280ZFB2TDBOSDZqTndVYWJsQWFaSlF0d0Ns?=
 =?utf-8?B?MXZqemtUQ0JZL05OSm1ET0x6d0VuMm9Kd0hQTTBFWCtWVHBiUFVEeVE4NXpJ?=
 =?utf-8?B?ckJkNVFJZnovc1dvazhVMzhIemNZUjQyNGJaWlB3S2RFNlppeHBianJnNXoz?=
 =?utf-8?B?TUpkcVNsa3ZycHMwWm1KM0hDWU1WVG9pb3R6SE8zQ2dIMllQbFJyRVBDWkI1?=
 =?utf-8?B?ZzUxU1lCZUNJSnNWTW5tQ1NJZXVOL2R4ZnlFcXFOS1I1cHVHeGlxKzhzbll0?=
 =?utf-8?B?ZnR1ZFZRZTcxWjd0elFMVjdJeXBZQ2ZTcE5rTWVtV016eTdmYitHenNDaDBQ?=
 =?utf-8?B?TGplTk91dDhFYjZHaVpKUWNJblVvckY2VkoxeDRrRU94Ykg0czEzUjRmZStP?=
 =?utf-8?B?V2NVR2dRV2JBemdnVzJmbmQxZENDemhobVVEa3FNbU82czNhUnhwOXV1SUNi?=
 =?utf-8?B?UFZOMjZrRTVPMGZ2YjlvTkFRZUx4cGJKMnQzOE9GYnVKZGFxclhlcHB5cHVv?=
 =?utf-8?B?elNWRGpsZVVoV1BxaE84UVRLbHlhR3dLOVZCVFN0dVlNd3lmcWppeDJ5bzNs?=
 =?utf-8?B?dDdPeWc3bTdmQkdCa2MwUUtoUGxMZW9wSjludE1TUS9XU1BNSzkvMWhra2dU?=
 =?utf-8?B?M2QzdG8zNWhteGhPbkhLdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0VHeWRlM3g5eG0xT0tBV1dnMG03S3ZFZ1lHVHc0a042dk9MQkc4a1VJdTVO?=
 =?utf-8?B?WThQQ09nbkxnVzVHOTY1U05rYytCRlNoL1VUK1VsR1pFSFpNajRHWTVzMi83?=
 =?utf-8?B?bnJHQ1VqMjNCSitJQlhzMVhoZnhOckh5eVdZUFJ0STNnLzJneTBSN2xrOGo5?=
 =?utf-8?B?ZHpVaFBOUmhRRXk0ekJrQjJaaE81MjdoM0tXT0FBR2lxSmJjVFVmOC9OZWZq?=
 =?utf-8?B?cE1NeEt2VVQ2aWZhaHJ3aUVMSjIyeTYxWkVtZXdYbTU5czBsaFlMemlpK1J0?=
 =?utf-8?B?cDhyenJGN3EzMEJmRVpwK1BJelRjUTZYd3BBc253NWpCNDNuTXhwUGlCYThJ?=
 =?utf-8?B?SllsWFFHNVVoaTRpcDlZS2pHaDc2MmxuQ2l3Smp0RUxHTDhXMGFkTHlyNjlP?=
 =?utf-8?B?dXliOEE3QzhtZCsycDdQM0pKWFZSWnNQODlUQjE5NGpjNjFTQWxjT2JOeHdJ?=
 =?utf-8?B?YmxHTXFRUDg1V1hrMGp6M0RIK2FjbndXUTdMeE5tT2tldWVFMXRwMmJrRzdi?=
 =?utf-8?B?RUJjc1BLMjJxeEJjNHRUakVMWk1xdHkvRmJNMThRbHRkdmNacllCbTBPQ0Uz?=
 =?utf-8?B?NG52d2NEQzR5NjBaQWxWbzhRTEdNRVBRQ214cGpSd0FnQ3FBS250bkIzOG8v?=
 =?utf-8?B?QjA5SFdUR3o5VWNWVFF2NVR6emtkRzFWR2p5TVNmMitqTmovZmVNSW5oU0l0?=
 =?utf-8?B?NzZjT21sK1o1NGFzOC9yMXU1TThjMXBicWl2cWkyZ0ZBR1Z2blczZnBEeFl1?=
 =?utf-8?B?UjhYeGY2UTg5R09xRVlLZG9FcTFiRTR6cytTT2xWd3J0bjdLdTk5NXhzUDJv?=
 =?utf-8?B?WXV1Y3kvelk3RmtsVDlXYTZRK3N1cGx3MFhpNFp2bFlYeHozWDdjMm4zaFBs?=
 =?utf-8?B?ZmZCVHpKSmFDN0JHejgwd3gwb1dhTkh4cnI5VWU3VStGcU16amF4cEtjbTU1?=
 =?utf-8?B?ZWdKOXRQbFdFejFvUHlaKytHQXlHRmo1RUsrWTYzMVQ0OFBocHc5Y1JBN0FK?=
 =?utf-8?B?aXFLb0luVHlhcDJJblZXWmdvVSt6RkRTY3VieEFxU2V6YlI0TW1YRldLTzRi?=
 =?utf-8?B?VGZIM2VPZ01VVzYrR1ZxY29PV3ZMNDA2dXZldE9VV1BRSTdrWUVFa1dHQ1Fq?=
 =?utf-8?B?Y2k3VHdFSGpOTTlkc3ZCWGpjMjJRcHhuRnNmYnJUSXFhWDcyVjN3QlZrWW8w?=
 =?utf-8?B?b3BYMW8vZ1ZGUWRoOUs4amVsOXpoNWNjY3cycTZaY0ltVWJRWHdzdlBiTjQ0?=
 =?utf-8?B?dVl6aitiMjEvSEFxbUxzKzBQWGxXMGRGOGVWdXI5Tk5EekFIdG1SdU1JeW9v?=
 =?utf-8?B?a1ZadDFrVjdaUEx4YjYwVTVLU1JOZTZlb0tLRmwxWEo3NEU2SDN3bk43ZVpF?=
 =?utf-8?B?UGdybTJFaG1KY2ZkTGR5NlBpOGl6SU5MeHdUd3FDYnlaV1gvNXB3cWRRdGgy?=
 =?utf-8?B?KzBvZmNxQUlRWGN1YWQxN0VXc3NWa2prd2VoMzZrTThwdWRFUUduU2xKK2Jj?=
 =?utf-8?B?UUNMd2EwQ1dtdCtScnF0Tnc2VS8vejlPZ21QRlNSaDZGVFN5Y1UrcGsxTFAy?=
 =?utf-8?B?ZENpcDFzSkZnNG84S2xhb3BsZ1BWUStCZUVEZ2VQYnUwZCtCZGoxZ1dXZ0hR?=
 =?utf-8?B?OVZBZUJiSVBqdkdFdzMvL2s5OGNOWHNKWFA2ZzhiT0JQWTBxam5IZFB6Njk3?=
 =?utf-8?B?dk5VMlIwV2hDd01YaWRDNUZ1WUQzSitVdnhLdUJMSWdOOTNtQVlTdExSdHBa?=
 =?utf-8?B?YldoVm1qRVRTaFJ3aHM5YzFFNFZJYjJlMi9TZ09PZXBrTFlxNkZEemxlcENR?=
 =?utf-8?B?MHJsS0ZvWjdMZDdTU01PenJ6TTA5QXVSbG91dExTY1VFZ0t5UFNacXZBVjdr?=
 =?utf-8?B?a2ZlUi93RUVLaUtRZVdZZk45VG1xb0JrUWFWN0R4Y2haRmZGdDJucXhuZmFN?=
 =?utf-8?B?S0NmaTJ4cDdMUjhsVHJNSldCS29obDhVSVA1bmtuZGE0NXh2ZVE3OE9vRzdJ?=
 =?utf-8?B?UEZQSlhnZGd4dTIxZFM4RDZBV1J4bHRaNDJRNFNaY2JZKzlaYU44Z1lhZ2F3?=
 =?utf-8?B?TUZyOUlOQ0F1ZWJmTjhFMmJlU3prUCt5VlZvSnpkY3pvZVUrSkZseWhvUEht?=
 =?utf-8?B?MEhXb1o0U1NIYjhxczJoUjRjS3JvVUZYb0owU2g0T3o1QXRBaVFmaWMvcmlF?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ea7465-c0e6-48c8-00d2-08dcb17f9aa0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 16:41:19.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUk8087FGf83NSKX9mwkEp74jVjgtEruBXvxtv9YrOaJURjCAjirfmirHNXjdAddtN6gIuE8JKnPBmg/MZEFk9wahApLbH1BO/aGkxHtjps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
X-OriginatorOrg: intel.com



On 7/31/2024 7:43 AM, Jakub Kicinski wrote:
> On Wed, 31 Jul 2024 07:40:11 +0000 Song, Yoong Siang wrote:
>> Regarding your suggestion of implementing a "wildcard rule,"
>> are you suggesting the use of an ethtool command similar to the following?
>>
>> ethtool -U <iface name> flow-type ether action <default queue>
>>
>> I have a concern that users might be not aware that this nfc rule is having lowest priority,
>> as the default queue would only take effect when no other filtering rules match.
> 
> I believe that ethtool n-tuple rules are expected to be executed in
> order. User can use the 'loc' argument to place the rule at the end 
> of the table.
> 
Yes. Some drivers lack support for ordered rules, but instead enforce
that no rule can be added if it would cause such a violation.

In this case, (I haven't dug into the actual patches or code), I suspect
the driver will need to validate the location values when adding rules
to ensure that all rules which don't use the default queue have higher
priority than the wild card rule. The request to add a filter should
reject the rule in the case where a default queue rule was added with a
higher priority location.


>> Do you see this as a potential issue? If not, I am willing to proceed with
>> exploring the ethtool options you've mentioned.

