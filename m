Return-Path: <bpf+bounces-48797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1FEA10D7C
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071EE1885177
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BAD1F9AB9;
	Tue, 14 Jan 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhuGirDb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A91D5CD1;
	Tue, 14 Jan 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875229; cv=fail; b=tee3WMWEySY8RBncpoGAkEU6NiNT322/hNrZQpCIhIN5pCeTrDJRqjJrUyzXcZxGOdbWTmpGYjPGqsbL4Z0avmwTMop7Pdijk2B7B8qniRV4wrUK4zaRvow3wdeu4OnpxqtZWDB6QvLhiH42B8EIWEw7d7uob6bmnUWJEs4pkps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875229; c=relaxed/simple;
	bh=eyW0PzBtZ/v0zQjA+j2EsUJotTMlmpf6SS6SGdmylPE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iI0SgkvZ0C9Ia+TvXoMQBbmS3jQsDzWbsO0l84gXGd2EfqRf1Nec2vqhBJxg+HZLrQAmhGBayR9zukLtAmcuUEXCqEQPfrKh9Ssc9U0qQLz0gKtM6DihJ/ZKg6YP2zantjN7WKLHVEPeaBq+dMWL8dDxfZ2RXUEFxLPofrfaPBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhuGirDb; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736875228; x=1768411228;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eyW0PzBtZ/v0zQjA+j2EsUJotTMlmpf6SS6SGdmylPE=;
  b=fhuGirDbBEurbwVegMaMw97fFlPiIwMGD7YFDo35K+yiZlxL5Z8+t7x7
   h57tlgHf1gqYZATXp8YcNr2WpW7FZyqi98hhEOtu1dT+i/sW1lyBL601N
   NM2UEMdEEILjH/+luD9z5DhrkuFORVChp7vQrBKBpEcV0dnzOI3/3mOjq
   NbZDKa6uCXYnHOb28Ie+FT/fdfPky2ohKSAFBVMhzmYSWUWHgAMcAAzl5
   7b6sapazsdOs+8G8bfAUUrHWqYpgi9f1skBUFLTrzq3EgMLZ0FhXxnK56
   boUksISxX5ntK5ckYjzDROi4+DCPl72vQOA++oDgznm7olqV9FSjdt4c/
   w==;
X-CSE-ConnectionGUID: iGbHfiJlTBSQee6JWPi2rA==
X-CSE-MsgGUID: xXHDG3adRCKtkntqS2L5XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="24785708"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="24785708"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:20:27 -0800
X-CSE-ConnectionGUID: DKGh4X3tS6S0xgcgD7PsIw==
X-CSE-MsgGUID: ke/TbOf/TVaggR32mCe9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="109850415"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 09:20:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 09:20:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 09:20:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 09:20:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2vjYR6VmUT5gye1ykab5gePLMU4syn9ntun1M15nOooedmLHEFxz2lZbRJxrFPe/Z4bej09xKvY103RElM8rnplYIbM1TGnKJ7yTAtqjsOQUf4O473V3FTvv/y3aJSriyEle0+EvCwmSVs0Psql8LkjXrA2FNWqNVO9aROeS/6Csb8SbPpC9whBM+HqBoMCCJzSszqBF8jebpkrGld5fjr/dWVYp67xjiQEZGpRQtCNUMZoghrhFuOJ/9F4SkMzHve591xpc7LFoVD8LcUeb1g0X9grCONJbgZwqGSY0MrJGGXG/nCIeNz9DPRHvBkXBiHVbRntFFuMZ9PD0YY5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWe167NbJ4uS+AN8aCYBb/D5lhikvedy2PTANa0OPbc=;
 b=KleDvTRm1C/JHNts69PqtLXmCY0BaxD00An+AG+ugpSQFpu9bLBhjPQrdOkXIjpzxvBGaSlIRvn/RfbNYnb7ufGfDKmQK12b7PG8WpVaWFwycRxDbDuCW4r2RwCuBJ5eATgfpZyRWjrrlw08pyG5LI8LqX5JqVMjty30snim34e4OfUjBXLUeNDRsY3rL20QU6gW6MRbVtESJwC+AX4tEytgn6jLL23N6O4rbpe/dOZtuvBhSCr/kcFq7AGzXZj/dNHc2jQbS6nBl2x/8L0Ry9p+wkj357cCUn2uGAvlg7JqYlKEUIBN4hZ6CHhZxFE+JCuXOL+aciBZl+usGYo88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 17:19:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 17:19:55 +0000
Message-ID: <e0753deb-022b-4c97-bc67-177e12872436@intel.com>
Date: Tue, 14 Jan 2025 18:19:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] net: gro: decouple GRO from the NAPI
 layer
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <20250107152940.26530-2-aleksander.lobakin@intel.com>
 <4669c0e0-9ba3-4215-a937-efaad3f71754@redhat.com>
 <a222a26b-9b1e-416e-a304-fd9742372c7c@intel.com>
 <20250113130104.5c2c02e0@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250113130104.5c2c02e0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a60a087-6678-4f64-2650-08dd34bfaa1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3E4bHd6eHArOERmZUJxNlVINXhiMmlWaHB1Vjl2MHJPV2lCVjEyY3c4TXFH?=
 =?utf-8?B?RmcyWDZIUzdTNko4UExFalJQL3BONVZLd2ZhcklRY1JiKy82OFNMZkF4YlFm?=
 =?utf-8?B?ZllpakdDOERWa085U1hyV2RFQlhsSFltZm4zOGNMQUlXOU5JRVZpaEZubEQ0?=
 =?utf-8?B?MzdCUlhKT0pyN1h2OW1Eejd1dS9zQlh3TXBwU3hrVTdGbGsvT2dSK3dEaHhE?=
 =?utf-8?B?bUYvV2k5bkx4YmFMTkNiZ0JxVnhXeTNtSWoycS90UWpTZUJJcnIzdTlldFZH?=
 =?utf-8?B?dnJMYjVTK3FBNm93eDBiN05MT3Q1SGRnbXloamJhcXRxR0pab1d2ekh5Y0Zk?=
 =?utf-8?B?RWlURFRrM2ZLamlIcVBmSW9TME1UU1huN0NlUzhTWjJHYzNvVGk2cU0wd3pp?=
 =?utf-8?B?Wm16MU1LOE5neHdXRm1kUTBmaXdiSkthY25JNUFWNTNhL3BFL3hlY1dqS1Bx?=
 =?utf-8?B?K2t5KzV6dVg5WXNKNk9RRHhNeDI0Y0RQSmVLVVd0THp1dlJMcWM3dTBUSUNC?=
 =?utf-8?B?TVdCK0RhV1MwcDdUYjlqeXdCVkVYck0wVnI3dHYzWnBBQUZRL2k4T1piZ1RH?=
 =?utf-8?B?VTRnWE9mOGhVaDZITVpUNVJHTzJaVGMyTXVyM0VyUjdqWXREQmR3VENjV0ZG?=
 =?utf-8?B?TG5XSXVTT1pRR3V6Ymd5Wkt5c1N6S0tkNk01SWdlVGU3YmtVT1NsUnJGT2NN?=
 =?utf-8?B?SjVUZjlMcmhqQnhFTUhYWXlkTVAwQVBuMk5YY1RXdk5sZTdERjMxbnFac2NR?=
 =?utf-8?B?enlTYld6WVJaK1NlbmwzODFJN3VoaEpMNUpaRFF3cWxReFkxbFowQlBVQjAz?=
 =?utf-8?B?bUlsRGhFbm9SNVNpTHhlaGU2Vlhiek9qaGhEdjZZWGNuUG0rRGV5TFpNREFm?=
 =?utf-8?B?TS9IK295SkJ0SEV4VklFZjNhQ0N6MW10RXl2WEZQY2FRMkVsSU56ODJiUkZm?=
 =?utf-8?B?ZGNDcDlyZnhMU2pjampyaVJrNXBMaXJLc0wxWGhFZWNIekVRUU1SNWJaQ0Fr?=
 =?utf-8?B?eDN6djFvclY1SW03VVlnUkV2alowaGlmMG1qUWpQZFdGTCtmZ3dEbVNvWk1B?=
 =?utf-8?B?THNMM2t2UVp0NXl5ckU5aDRRc1RkN0REdVZINDJFajEzOFZ4ZHhYZWp5T0ZU?=
 =?utf-8?B?a3pzU0tDOHM4dDZDMGpFVHpwQVBidUNCQ3lFbzRadWVpNW1rUnJ0MUMrWkI5?=
 =?utf-8?B?UWJjNk1JSmVzVzc0aldLQ1dmQjE4Ui9wdTJ2VWNTMDFSblRibVJwd3J6aU54?=
 =?utf-8?B?RktCWjVhcDJ5TFNBaXllVDdVWmhiL09kMVl0enlxalFNOUlDd0NHYURTdjQv?=
 =?utf-8?B?dFFyNUY0SndBUEE3c0NmWTJDbjlOVGgyejFqQVBIajhCaXBsVzdsQ2dzbU9v?=
 =?utf-8?B?OHlwN2wxRGlYYVREdFVFdnNDb0pXQ05UMHR2YUt3NTdEVW5VNE1FcEVxL0lk?=
 =?utf-8?B?RmkrWGJLRnl1bFFibVMyNnpNRlIyYlN6MFFxQXhhay9Na2ZKbUp1SndYWm1J?=
 =?utf-8?B?NnVEMFNZMlU4aENUVW5XaUdjaDdVdUZUZ1FMRUtpK0NGSURrditLZXR4am9t?=
 =?utf-8?B?bTdiUlVuMjVYWmtZeTA4S0h6SURGclorQlFkakthUERuYWozNmVvRW14MmVo?=
 =?utf-8?B?dDBIL2dZdElnU3ZnRWxEREJrcTUxYjdFTEtnUS9tdGRScEFaWkVnMGJmcFVi?=
 =?utf-8?B?MXBCWFlydW13OEpYQ3V4ZlgvTWdtYUJUUXZSYm52aVpMNHYxY21WaHpsRC9T?=
 =?utf-8?B?cGNJR21QMk04aFNUaHFTakY0dFpQcHh3bm5FWTRmdVJDU3lJSGZCdEkveXJY?=
 =?utf-8?B?aytRTmJEbG5BT3NOYm8vVjZUUnBoZjhqd1BSMzZIeVd6VHcrSmxoL0h6NXVL?=
 =?utf-8?Q?mnWzf2/F/SWOH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmlaelFnZGh4Z09zd2V5Ky9wNFdMaXBaRldndGRwazF6ajJBeGhFMkVsV1Mx?=
 =?utf-8?B?Ym5GdkZWZm1OSlNKOVZxeTFFclBQbVZnUVpJVExRSTRORG1hTUtvNG0vYlBO?=
 =?utf-8?B?cDB1THJwNG5GRGFUSmptSDFIRDNHWkdOVUpSM3RybUw2ZXAvQll1aGpKN3VR?=
 =?utf-8?B?ZjAvQkw4eUhFWkhzbmh0aEMzS1k0QmREZWdvY3JnZWZTVXlrM0hzU3A0R3VV?=
 =?utf-8?B?MFI3WTNQT1gvZFdZSEswTlRZTVlYZzF5bFcwQTYyZGJRVWE2SVJCeGx4d3Vr?=
 =?utf-8?B?TnhGM2RzbURDQ0tIb0k3YVJiRjFGMnpuYWxnWnd6WGpmYU5FZm9GMWFYZXpT?=
 =?utf-8?B?QVJidkZGUVlwTlA5TWd1UUxET3NjMU5wWkJjY2N2ZXZpSnFTbEx1b3hhM1FX?=
 =?utf-8?B?eGdSZ0ZIenNoa0U2RjNndDBoczBLSWtDaGl5U2lwNVlOL2dHb2tyMzU3czdZ?=
 =?utf-8?B?dlB6OURiU3QyVnhJM0tvTFVLQ1pTZ3I2ZTJXaWQ4dVd4YnNKU1liVFZEQ2pp?=
 =?utf-8?B?Y3lIUnZGR2Z6Y3hFaW41UW4wbW10Zi9JQTVPT1RKWXU5U1laV04zV0ZRdXJt?=
 =?utf-8?B?bFMvS0JmUEtIRGRZNE01MVp5VDBCU2FsTkxzdWJhU1YraHE2WlROOSs3MVhQ?=
 =?utf-8?B?RTVFbVpUY0UxRllQTVJyWW1rVEpKVkxKQVAxUTNkTkhndmdnSlAvUGhhZlRH?=
 =?utf-8?B?RnpPVzZ3Vys0ME5odTN3M2RmeWdHbktmVnZvb2dQY2VTT0YxWWN1dHBKRk9H?=
 =?utf-8?B?T1RSNFl4czFpYWFWN1k2ZDl2M0tyRU51ZENCclEzRkd2cERGSEtZZVliU3U2?=
 =?utf-8?B?MnJlT2Z0LzUyWjhCQmF6b0lyNUtrSmtZUktqSEF3cXltdmNmTENNeUw3eDk1?=
 =?utf-8?B?ZzdXanJ5dEFJOUZLbHkxN3NxME9hbStDVi9iTWdPSjNLKzB3bDlNTlQ2c1ZD?=
 =?utf-8?B?VC9TaW9BRC9RenR1SklLb0x0NjRrMnp5bnhsQi94czZnQjU0eHdtaFRSZUVX?=
 =?utf-8?B?dWFwSCtmUnR6QTA0QTZTN3RLa0NRMVQ5MXlxeUtnNTdHYWtoZ0dWV2VTVVJH?=
 =?utf-8?B?VFh2RVZxNU9WSlU3NU11Y2d5VkJNVWwyN0JrZzlXQ3NvRUtRNXBjQkk1UWpE?=
 =?utf-8?B?eWkxSGppMkR0SnpLYXpqY1FCOFBBUXh4ME4rYTRWTnJZdU40Nk0rQi9aTDlH?=
 =?utf-8?B?aWFCK2dZeDJQSHAvZjBONldweGR4TllTS0NYazdibk15SDZ6SnJ4Njc4Qnli?=
 =?utf-8?B?VmxGNXhmMGY3ODNJNXVCSmcwWEFYdkd4Q2N3Z2RHVmxvS1g2NFUrZ0FMaE9D?=
 =?utf-8?B?cGthRGk5YlBFMnRmU2hVZmpwV1RqeklMK3d2UFJFQnk4bWRkUWlQOXljSEFJ?=
 =?utf-8?B?R05FN2h6RkprYlIwK1drNVhJWW5xWGdzUGdKVlpQNHFXNFpwU1JlR2E4Tm1l?=
 =?utf-8?B?aXd2ZDRuVHY3dHMyNzBLeUFidzIxQWhBVFBVK21IT04yRkxrMW0vTmpKb1Vm?=
 =?utf-8?B?MldMbFJMVjFnTE5OM3pmTWZhR21pa3BaODN6QmgrSmUrKy8zS1B2UzZQdWRw?=
 =?utf-8?B?THZwZ0RYaGwxcVd0SG9naHZCRnFWdnh1OWNkOXFnQlhKdUlVRWhJR0piV0dZ?=
 =?utf-8?B?S2MyelE1M04wa0k5L25kLzJUa3JuQ09XcU9aekk4a1ByY0RSNUI5RkxVWHA4?=
 =?utf-8?B?K0d3UFRBQ1R2anFhb2RmZzVseGpNOEJYa2ZSVUVORHRCTDJwY0tyQVRhemRL?=
 =?utf-8?B?ZURuTG4yeDZOdDd0N3BYdkozWU9sR0VUMHRvOVlNdklOWFptekVJbzJ0Q3JH?=
 =?utf-8?B?R3Nqc0dpbzZJeUZsNVMzT1JDMlR0NW1OWG5hdHJPRTBJYzZSVmxSRXBIeWox?=
 =?utf-8?B?bkwvb3V5VkdkelN5NjZPMGtzOFJoWVdia0hTeWV1dUR5L09kRHE4c0pZUU53?=
 =?utf-8?B?bkFwRWVmOXBZb0w4MmRTZTlXc3NaaFUxbklYaU9Uczc0bHlxVFAvQjlnSlVL?=
 =?utf-8?B?V0tJSGlabEQvSUcvekFJY1M1V1FFSFJCQnY4bHNCdHQ0L0lWYkRXdUVQZDhy?=
 =?utf-8?B?WWlmN2w2aWsyUG45VkRaY2VuK0QwdjR3eHhydDUzaE9pUFZFT1d6azNsNklZ?=
 =?utf-8?B?Q1czWjdXU3FYTVVoV0dYWE1PeWFZdzB6N0ZxV21KZHJDU2t3bFVWN3ZqWjUx?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a60a087-6678-4f64-2650-08dd34bfaa1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 17:19:55.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fzs1D/C6Iyy0eZRlq+mmGIflI52LzAicPlhgG/YUTfx/Dqdl8A4zdSMllY9QoRW4Lg92xK1FPpqjKTl5SWoxCkZjlYtdzC/y4MA7Ljrjxn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 13 Jan 2025 13:01:04 -0800

> On Mon, 13 Jan 2025 14:50:02 +0100 Alexander Lobakin wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>> Date: Thu, 9 Jan 2025 15:24:16 +0100
>>
>>> On 1/7/25 4:29 PM, Alexander Lobakin wrote:  
>>>> @@ -623,21 +622,21 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
>>>> +gro_result_t gro_receive_skb(struct gro_node *gro, struct sk_buff *skb)
>>>>  {
>>>>  	gro_result_t ret;
>>>>  
>>>> -	skb_mark_napi_id(skb, napi);
>>>> +	__skb_mark_napi_id(skb, gro->napi_id);  
>>>
>>> Is this the only place where gro->napi_id is needed? If so, what about
>>> moving skb_mark_napi_id() in napi_gro_receive() and remove such field?  
>>
>> Yes, only here. I thought of this, too. But this will increase the
>> object code of each napi_gro_receive() caller as it's now inline. So I
>> stopped on this one.
>> What do you think?
> 
> What if we make napi_gro_receive() a real function (not inline) 
> and tail call gro_receive_skb()? Is the compiler not clever 
> enough too optimize that?

Worth trying. I'll be glad to do it that way if perf doesn't regress.

> 
> Very nice work in general, the napi_id is gro sticks out..

Thanks,
Olek

