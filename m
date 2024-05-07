Return-Path: <bpf+bounces-28776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74A8BDF60
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBFE1C21A9F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BCC14EC4D;
	Tue,  7 May 2024 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MK+gJK9m"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAFF14E2EA;
	Tue,  7 May 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076398; cv=fail; b=B7pKs9X8sMAYrDbh/i/JpD/1YxGUy54NgyAGBMy3tf0nTr8AOL7dZeryhkE693VuUNMyIVxyQKahAjhn/4zRIb6DLiDQBz8BCsSBVceMuH6G/+I4Qo549kXDhDwiOvvu5Z8v5xT2AUnbPI/3QVGsJr9wEW1V2qsQ/FzsAHvL8To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076398; c=relaxed/simple;
	bh=lcAAoOJseEgExv7bR3eH4J6OkNLSzJJU4GmJI8qLGkI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mTNNmWk+xKHCHcDBO6w3cGuIo7lq20k/GbUdeRaCMY4J+l9DXEDr2go55skfpYze8p/qW+5lSkRGRZgRI1oaDlWu30fsZV6cVKx6Rz2qx1+73MkhfXVzdpbI13PaoMyQFJI4CEvHVWgRDOaPY1TDpCnly1b1N8pgLRiVjVVwznQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MK+gJK9m; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715076397; x=1746612397;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lcAAoOJseEgExv7bR3eH4J6OkNLSzJJU4GmJI8qLGkI=;
  b=MK+gJK9mJuOkmr7WyfiZ15uIKZPsn2YgP953ZoJDBAwpxP0HF/BbDEru
   DcQke1IIlwKvImra9LFplQZbEU+tFd8rjhqVTxn4iIAyEKKEi4zTC0CWW
   1PKqMqGhkAdB7FFHO19at7oetzEdL4oiK1OcfljpBRwEAReNpEYtf/J6X
   vJRW3P1nc+8SRm+pToIR/+vWU0fGSL+Czlo1DBB58jK2nkTusgRyC+Z/v
   QP4KTg7Ke+ISr6KPXmicAmOlv+et7aqdkpvIzt8JBKd/aYxHX1oWxaTcr
   xlFBNIHb8a9MVe+uKZApLA91ef1H7YvmWGh2UT7p397Epr/JgIFEadW3R
   g==;
X-CSE-ConnectionGUID: MDPO94QbTxuXekOBxsnPpA==
X-CSE-MsgGUID: 3LwCt7whTpmgnKNM4gnpdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14643722"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="14643722"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:06:36 -0700
X-CSE-ConnectionGUID: WyWBBWNtQXmjOJYNNK7ymQ==
X-CSE-MsgGUID: NeKbGTpNQTqNzk/acZ0y+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="29052462"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 03:06:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 03:06:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 03:06:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 03:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGUPE+EVs1nkGs7kOpeRZRwBO9fpamt22VqZt7l/1e1o70ASPal8LiMOxTsQovgYTnubOVryWsaIAvKoIqw5ZI9TIenerMlrtHcuzW6hIQOB85BLpsWIjgobqxfbQxtuRvc9DXFzwjuW0t2gCxsOylF12PQc4hgXaijdnzk6/z/agFhrzLOCvykd2PmhQqTf1yViSHS8Ylx6cFrE0owTR1hwAjJwVWjI0lrobyxkvr82x5CUHMX7w4DTSC6qsBvrG99rKrY18hxJGL83nJjdpOvXQPdoanreKRyTGF8Ucl6/q9EQKlvM6Wnn7Z/B6XpNrYDN2SLe7xjFInIj7WyLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bckh3qi++ZdWuvXc2dM152tNYjWABWxmWdHYIdIcEQg=;
 b=KN1EeeL+4+T+cE1+0S6izbgz2/SeRwpO+GFlOO3QKDGNoBvGymH5GVXXVncQFwfLp5UOyZZ6PFQkDcnBTmdF9qYTE+PQ0ojf0K9HYvvg/LnsPgjgw/MbbLd7hwUIrIFEjt2ICK7cuyAqW+D/yB27emXB2Hd1C6tzYqOxKmKryNrs37H0r5/GUzmI5KhWsgNrO95dM3tVRKokpwcu34/Dx4xUhMt5blW9ATdahub2wRTCgvcPO3jPbopCJaqCgu+CK8dHOGpwkj00Lu3j+pvh5tksfFTHdEm1XgWW17Dz6Jdiyq/S3Jv2KCXBbMU2kZSEt6RVYaNEpAUfrDi+ZkSWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 10:06:32 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 10:06:32 +0000
Message-ID: <a3a0c162-9226-4bab-98ec-56e2da95fff1@intel.com>
Date: Tue, 7 May 2024 12:06:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 7/7] xsk: use generic DMA sync shortcut
 instead of a custom one
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240506094855.12944-1-aleksander.lobakin@intel.com>
 <20240506094855.12944-8-aleksander.lobakin@intel.com>
 <20240506112931.39614ff0@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240506112931.39614ff0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BN9PR11MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c9b98d-31bd-4952-69c3-08dc6e7d5f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0d2a2lOeW84N3hLUXZ6UUJyb2ZsVVgrNW5TcjZweDBzMFhhcFYyZEtuRXN1?=
 =?utf-8?B?bnVIM2lGck1nRXlsODg3QzMyMlI2ckVibVFUTGp6bG42RGoyZkZqcU14MlZj?=
 =?utf-8?B?UFdiRGl4enpWMGRkWGtzK0E5dW8vbmwwVDFpd3Y5UDVMRFhkeDVobCtPYnVn?=
 =?utf-8?B?MUpnMGNvM3lWVkdYcld3RDJUY3BURFdiSVFPWkh4dmUrWDJyT3JPR0xDZHpt?=
 =?utf-8?B?RFN4ZmpJUThIUHJ1WmE0MDJMRnNvQmNEckRjSFI1NlZ5c2pYKzlkQlZ6T1oz?=
 =?utf-8?B?UlZTREhVMTVkdVN5NGFrT0JuV00xdU92ZTNoWlhWS0JHL3lEbDRaZmFnYU9K?=
 =?utf-8?B?QXpkUHQvOEZFKzBEU3hUc05IRmd6dHB3RHJSUTYxOVBlbHhpang2SlFRYTZ1?=
 =?utf-8?B?TGw2NDVTbm4vVU1TK1owVEIxYzFaUG1Ka0FWR2c0RGY5Y1dSOG5MaWdqem13?=
 =?utf-8?B?UFV1MXdnYjA4eG5aek11bDVqcitPblFGYWRmTGlaeXBOSEVickVBbFQ1M2pJ?=
 =?utf-8?B?eVF1Y25kM29HWC9RTU5FaEQ1Vm1ONGFVNGx0Z1d1LzduTVVFUUFubERIMENi?=
 =?utf-8?B?RTdjVGZKRi9GWFhzSlJDYzFVRnNqbWF6Q1dkeU9UeDBqQXJzSlhjK3I4MFRM?=
 =?utf-8?B?azBRWThRQklvWkhPL1pxd3lSRko0MnRQc2VmbHpmbmdRZWhsTmpzOUZLTit2?=
 =?utf-8?B?WDk3RGY3REx6V25JNUdlcjVUaldsVVJEWTBPMUZHdWVFQU9yNG1UZzRBTnN1?=
 =?utf-8?B?Nzc3R0J4RXozOVJYcS81VXA3WW1JcGVHU0VXc0RDOU5OOUtqMHkwVjFuSDdy?=
 =?utf-8?B?c1U0N1l3YUtnL0dxTzd1WXI1d3l5TG5YeXdYMG1IWlhXZ2VDc1RWM3Q4bmhC?=
 =?utf-8?B?UFlTYWhzWG9XVFlLNlhNSzF3L1F2MXF3T3EweDJmTUFSdXcyK3RXWmJJQ3J0?=
 =?utf-8?B?T2NkVUl6Y0NrMDlmNm5Bd0U0aVd6ekZtOGZNeDFlN1lVKzZteitnakdEZmFn?=
 =?utf-8?B?UWdjNmNtcDA3N2RXeTM1YUc0WjRYVHVNdkw0MjdXTkhSa3l1RXJxZnpncGo5?=
 =?utf-8?B?SVYyS1ZiZmdSRG1za1YvRHBiWHJON0NYVFk2dmI1VENmVmhjMC9zYlI1SHgz?=
 =?utf-8?B?M0o1RmZVWGY3azRTUUJiRXAvdWF0Rm5pSUQ4VUdHZDY4a20rTE9rZmZjMUda?=
 =?utf-8?B?THFkZDdYMVlTWXN3SHFkdER4RTM3TEFyUEJDVTBNOU5kQjJwdVRldkQ0cmU4?=
 =?utf-8?B?NU1MTExDVEJRVmRWSHROdWVMZUJ2Qkdyd2pCYXFaM2Q2VlFrVVc0b0c4a2hE?=
 =?utf-8?B?eTNZUURTWEkwQUErbE1odlIwYXRzT05pN0FPWlpSdW5qWEZKRW9ldUc4TVdy?=
 =?utf-8?B?VnQ0bXZJdzVJdS9PbDJUTXpWNjBPNWZDM2gzcUdWWFUraU5rZERHTHdWaEpZ?=
 =?utf-8?B?ZjV1OU0vcHJQUU02T3ByTjlYalJONkh3T2toSlVuZnlTMkhxZldKeWdKSmZm?=
 =?utf-8?B?Q3VKY3lnUTc3M1FZSTN6d1h3TWg0V1FUWkc0NVJLOVM3L2lCNCtFY0czKzBX?=
 =?utf-8?B?QVdWa3pTZm1Nb3p3KzRpQUc3L2ZyR3VoYVJ6SmFob2xrOC9xN1lkMm53OHdO?=
 =?utf-8?B?RjFuTzcxNTNQa3g2OGp5bG1uZ29RcGo0TlRjdnVjTGg3RkNNSmdtbEtZNWc0?=
 =?utf-8?B?RitCZ2JXSVR6bE4rb0dsV1crVUgzOURRajlYb0VLMWxzeEpvTXp6am9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdOSERCbTRhRHNHWWZveDNsWXFFQnVUSXZvamxvN3pNZ2t2RkhxdktlTXFu?=
 =?utf-8?B?dHlXYU9TemZkdy9vK3N4ZnA4OWxjQlc5OW9HeGtYSi9xc0l4SDJjVjZEZWJV?=
 =?utf-8?B?U0g4aWN5YmJUSzZyMDF1YTlWRW5iakEramJUOXNCaWZGWERSQjc2Njg5T1ZR?=
 =?utf-8?B?V0JQbUZBb0R2clloSUlkR3QrckU2WXIrZ3ZDZi9VNjAwbExCdTVNRTRhQlZE?=
 =?utf-8?B?eG0zZFJzRnRmOGZzcEx2YkpTT2xhS3hIYzFiU0VHYUp6N0E0RjR5M2lMVVhw?=
 =?utf-8?B?VTZTN01rTUJ4S3JCL0pRVEh4NytmekFxd1JPc1o3Z0FwRXdweUZicmpFbnJt?=
 =?utf-8?B?ak5IdHdLNVlBdzlvVHZHTXBUNzVwbjhZdFBDMHNTTkdCT1lWY3F0eXNYU1M5?=
 =?utf-8?B?VnlEK25CV01pTU8xUGJmMlYwSnlRdnRhTXBoZER1MzYzVyt1YW8xa2d6YU1F?=
 =?utf-8?B?UlgxK1plY29LV1QxU1dRZ0UvR0lXdFh1Y1czdTVKcmFQc1BBWGxIejVNbVlt?=
 =?utf-8?B?UUYvVElSUnVkdmtHdXlLZ0VveWl6UDlpeGk3RitDWTlERVZwazlHWVJPSTdo?=
 =?utf-8?B?QzgxWnFnYjhVRUdQUkw5OGp1Mk0rODhSZTRqdElSaWhSQlZsR2JRWXl4SWJY?=
 =?utf-8?B?N2E1d0Q0b3lOQnA5Nm1FQ1NseU1UNmF5NHNwMURRak0xd1FVaS9OZ3FYZU9N?=
 =?utf-8?B?OENQb2ZqVGNuQkZzc3N1SUFTZ0dub0IxakJnbThQalpIK1UvR3pnYWpWb1gx?=
 =?utf-8?B?UjcwUlNZU3pLQlNCM3VPUXdiV1lESlVoV0tMTjBROHVpaGw1bHlSZWo5c1JY?=
 =?utf-8?B?T0VrT3RqVFlpQllzdzcyRlJzSXNjK1owNnJ0SGxzQXFGQlZiY0wySHZVbkNm?=
 =?utf-8?B?QldqY3BhTmFPMHNHbHd5YUJiNFFuVmd2SUp4bXU0b3dCMFVMU1E0dTUrbFNm?=
 =?utf-8?B?VlV0TkR3OGtGaTNNd0VCNEJMSmoyWTUzZ2VpbWk4dmpkeStBbG82NS9PSnBB?=
 =?utf-8?B?YUlDVU1veW8zbmhsTGxObUtKK0hlS2hTb3RvZFY3YUQrdFpDb1ZiYTBxWkI4?=
 =?utf-8?B?OWhWcFU1eExoUzE3ZlZKdElVdEgyT2lvTzlkbUR3bWxndzJjTmxOcmVJcHBH?=
 =?utf-8?B?a1hodStXWElhUlcxN3RDaVlYdDBna3pWZ2ZqWVgxNnRUV3lvanRoWkxpRmts?=
 =?utf-8?B?bDlNV2RhbHRHRTJKM1Zycko0c0R4ZzJpM05RSndCbUNENnE2R2t6RXM2THhH?=
 =?utf-8?B?K1A0aEo2TFovRVNmdFI0Ri94L0FvTnVab1BUM1ZhL0Fmcmc0Mnc5cmc0ajdx?=
 =?utf-8?B?K1dNRTE1VFZrSDZaNzBlc05zREErTEpCMEZwUE4vWkRIUXh3S0xPRHJkTHhF?=
 =?utf-8?B?d2U5UUZuallFazgzcHZvVEJCNVZ5WjBndVNpczBXT3pYTGxYb1lGT2k5S0hR?=
 =?utf-8?B?YkdXdVNQeTRaTytpSi9tenBjazRMbWx5QzNyTnpHVmNQaXpZYU15eE9Ma1Z6?=
 =?utf-8?B?Q2paMEptMWx2RktuN0trNU5XYjcxMGJSYmJOUzc2QnQ4K1BnK2drYVl1cG9w?=
 =?utf-8?B?MElBTzZtWTBQWlJlSTBGMEZ1aHE1TFp0U1VaU3ZkUFI4bVZiWFpHQ21FYkFX?=
 =?utf-8?B?QXlvK0pUcCtneCswL3VyVFRqbmw2aXFDVTBjNnBxQ1NzQW0zeFBIWmdWbFBP?=
 =?utf-8?B?ekI5Y09WQkFQSXJIa0tsWGE3S1RHcTA3cm1lVVZ3UmdEa1MxTFJsUyt2Qit4?=
 =?utf-8?B?ellBekNYbDd0cEtLU2JvUjRRYkgySDJRb05vaWxWZ2QrSzNPUXMzVHh1UkU1?=
 =?utf-8?B?TGhCeXpFWUJlTVlmOFR4cWkraml2WHAzaXdDbW5rUHpBQ01VMkxHcDhGUDFz?=
 =?utf-8?B?N2p1RkVhNFBndjR5VW9wRzBGN3o5c0ExY3lwbVVmRndxTFVjcVNpUEs3UHlw?=
 =?utf-8?B?TnZEYmdjbWpGZ0tkOEJEa2ZpamprYXlmRThZKzU5cjN0cW9oekdWNEVLZ1Nr?=
 =?utf-8?B?Wk1FamVMNHp6NFo0S3dJaDJ0OUZpcnJQZ3E3SFFkU3dGSlN1cEowWWJqUytz?=
 =?utf-8?B?cUhTT2NuWllDcmhlekdxWGswbGU1Vi9JeHY3Q3UrL040bnZlbE96Y0lRQy9Z?=
 =?utf-8?B?R2hjcFZ3WmlCNUtPdytYZTdZRmF3UEd0cVdTV2pjamhaYXp1bWk4bktYRU5S?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c9b98d-31bd-4952-69c3-08dc6e7d5f21
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 10:06:32.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owftXkl9o+sWcHM9BdGm/2oD1jpoOQqAwQ4Og7ot/LGV3n7/ZmmBK2VE6zk3Z8lysL8EbcLQ656mRa+m9vBEPhG4ZKypSFfzAFwceVv8f1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 6 May 2024 11:29:31 -0700

> On Mon,  6 May 2024 11:48:55 +0200 Alexander Lobakin wrote:
>> XSk infra's been using its own DMA sync shortcut to try avoiding
>> redundant function calls. Now that there is a generic one, remove
>> the custom implementation and rely on the generic helpers.
>> xsk_buff_dma_sync_for_cpu() doesn't need the second argument anymore,
>> remove it.
> 
> I think this is crashing xsk tests:
> 
>   [   91.048963] BUG: kernel NULL pointer dereference, address: 0000000000000464
>   [   91.049412] #PF: supervisor read access in kernel mode
>   [   91.049739] #PF: error_code(0x0000) - not-present page
>   [   91.050057] PGD 0 P4D 0
>   [   91.050221] Oops: 0000 [#1] PREEMPT SMP NOPTI
>   [   91.050500] CPU: 1 PID: 114 Comm: new_name Tainted: G           OE      6.9.0-rc6-gad3c108348fd-dirty #372
>   [   91.051088] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>   [   91.051649] RIP: 0010:xp_alloc+0x76/0x240

Ah okay. Didn't account generic (non-ZC) XSk. Will fix in v6.
Thanks for the report!

>   [   91.051903] Code: 48 89 0a 48 89 00 48 89 40 08 41 c7 44 24 34 00 00 00 00 49 8b 44 24 18 48 05 00 01 00 00 49 89 04 24 49 89 44 24 10 48 8b 3b <f6> 87 64 04 00 00 20 0f 85 16 01 00 00 48 8b 44 24 08 65 48 33 04
>   [   91.053055] RSP: 0018:ffff99e7c00f0b00 EFLAGS: 00010286
>   [   91.053400] RAX: ffff99e7c0c9d100 RBX: ffff89a400901c00 RCX: 0000000000010000
>   [   91.053838] RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000000000000
>   [   91.054277] RBP: ffff89a4026e30e0 R08: 0000000000000001 R09: 0000000000009000
>   [   91.054716] R10: 779660ad50f0d4e6 R11: 79b5ce88640fb4f7 R12: ffff89a40c31d870
>   [   91.055156] R13: 0000000000000020 R14: 0000000000000000 R15: ffff89a4068c6000
>   [   91.055596] FS:  00007f87685bef80(0000) GS:ffff89a43bd00000(0000) knlGS:0000000000000000
>   [   91.056090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [   91.056458] CR2: 0000000000000464 CR3: 000000010229c001 CR4: 0000000000770ef0
>   [   91.056904] PKRU: 55555554
>   [   91.057079] Call Trace:
>   [   91.057237]  <IRQ>
>   [   91.057371]  ? __die_body+0x1f/0x70
>   [   91.057595]  ? page_fault_oops+0x15a/0x460
>   [   91.057852]  ? find_held_lock+0x2b/0x80
>   [   91.058093]  ? __skb_flow_dissect+0x30f/0x1f10
>   [   91.058374]  ? lock_release+0xbd/0x280
>   [   91.058610]  ? exc_page_fault+0x67/0x1e0
>   [   91.058859]  ? asm_exc_page_fault+0x26/0x30
>   [   91.059126]  ? xp_alloc+0x76/0x240
>   [   91.059341]  __xsk_rcv+0x1f0/0x360
>   [   91.059558]  ? __skb_get_hash+0x5b/0x1f0
>   [   91.059804]  ? __skb_get_hash+0x5b/0x1f0
>   [   91.060050]  __xsk_map_redirect+0x7c/0x2c0
>   [   91.060315]  ? rcu_read_lock_held_common+0x2e/0x50
>   [   91.060622]  xdp_do_redirect+0x28f/0x4b0
>   [   91.060871]  veth_xdp_rcv_skb+0x29e/0x930
>   [   91.061126]  veth_xdp_rcv+0x184/0x290
>   [   91.061358]  ? update_load_avg+0x8c/0x8c0
>   [   91.061609]  ? select_task_rq_fair+0x1ff/0x15a0
>   [   91.061894]  ? place_entity+0x19/0x100
>   [   91.062131]  veth_poll+0x6c/0x2f0
>   [   91.062343]  ? _raw_spin_unlock_irqrestore+0x27/0x50
>   [   91.062653]  ? try_to_wake_up+0x261/0x8d0
>   [   91.062905]  ? find_held_lock+0x2b/0x80
>   [   91.063147]  __napi_poll+0x27/0x200
>   [   91.063376]  net_rx_action+0x172/0x320
>   [   91.063617]  __do_softirq+0xb6/0x3a3
>   [   91.063843]  ? __dev_direct_xmit+0x167/0x1b0
>   [   91.064114]  do_softirq.part.0+0x3b/0x70
>   [   91.064373]  </IRQ>
>   [   91.064511]  <TASK>
>   [   91.064650]  __local_bh_enable_ip+0xbd/0xe0
>   [   91.064913]  __dev_direct_xmit+0x16c/0x1b0
>   [   91.065171]  xsk_generic_xmit+0x703/0xb10
>   [   91.065425]  xsk_sendmsg+0x21f/0x2f0

Olek

