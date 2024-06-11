Return-Path: <bpf+bounces-31839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEE903E97
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32244283C3A
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798217D379;
	Tue, 11 Jun 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUhMsZvM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565717CA0B;
	Tue, 11 Jun 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115710; cv=fail; b=mJYPavMyOowpNS80NWNA/3Gc6zO89P39Lin0QYxFd6W4ltIHRexiFLoJHqA/fsjGQz+6waRHp8c7JkcUS8Nun+10CCAAS/jQ79Trv0RQu2Nia0f1UQ1yLpjGzmaWOb+1qdieFARlEHuni/HRJclGnYg+iq4YP04RLgO3wuNHExU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115710; c=relaxed/simple;
	bh=SpK3hi68sSTObD0Pemqv9/GsKg/1o7TQhTTpx6USeqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sgx4/aej9aWpcPJzmYK6nFJLcNvjzNW6m4Lxn4DLbssPtGlEJ9YLVKhtx5QAPNH8mFHP8154bMjfOcupVYonur103fYhZl5+mCwUgTTrblvEJvk+B2joGrtMyTJFvLAbyboIZXCC81fUBYQI0kPPE39jlnLmVb5hFG8KgTeIfF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUhMsZvM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718115709; x=1749651709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SpK3hi68sSTObD0Pemqv9/GsKg/1o7TQhTTpx6USeqE=;
  b=BUhMsZvMBXcl0MQN8YAboS1fgi7kIDhFI7GcwLvbsKA1zHQmBGmKH3DZ
   9yxuOLw0e5XyvbLp4I3leusPKB5ImpOtepAuVGBrWFwy1JGfjF3WJjJyT
   wh0ZhHhcG15UKWm+L3DolSoHDEgMiTUZblN0qBKWCcohWOYPPm/vIy7fV
   2G/P70FZEzUw3mefVhgWp4vrcijrQbmkiKvZ6Y2Sf6NK2q6uo0Iyeo+PL
   gvCTS8/wRdgJA9pkl7YyZYZoc48TKfKKSneCGaL8piEF39D71XV5LxYAP
   ilk2WcdVkTS6ax6Yhxor8PYAO2H2tHMmhGokhsTMXEOCy48FMtjlWFNkm
   g==;
X-CSE-ConnectionGUID: QPMM7XwAQtygTWoR+UjcnA==
X-CSE-MsgGUID: CeWt1EBHSQC28iwR5kp26w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14552636"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14552636"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 07:21:46 -0700
X-CSE-ConnectionGUID: bSv0zq8LTQmEXQlzS/tnOA==
X-CSE-MsgGUID: 8LxoduA6QaSFnKCTYzd3Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39513325"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 07:21:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 07:21:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 07:21:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 07:21:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 07:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boIe2QvmPCsxvWYevK9KvL1k2V5GNjtXKYj14YSI46dIIYiJsZ3usGB661Lf64WhGgZNbJULr2aMg5asiheEtqxBRJRJkU8gTbK0MXPrJ4Vs8q9hgl0xROwlM6Dk/1WW4sSGF/bS7tQgbYWRybg2UzAwuWInBUCDSDu3Sav5KzS/98aHQgr31UXOXlkB+6Qi4IOWMrZ7oXdvg6uQ5wPIo1B5Os2znHGyDOCSr66jdJ/KXyr5sRrX5WGEld171mHOoV7rvcBDEYGHvQCAr0rfPGXKHylXxPr0bG+LJqJmuhsZMxvLR9dEcMkMh+SJLzb6ba4p9NMhDd3ePE5LKt/v6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpK3hi68sSTObD0Pemqv9/GsKg/1o7TQhTTpx6USeqE=;
 b=FnMoXsoiA32/ps+5U0U7ieo4gB9/94ZiE8EE/74F4j3FJ9B877iFrxBb7ujdwp6T7KWHCWN/d9VVfIJXPysB5rWWJcvf++xx+kg72t7J0SW74SwcvtUthpzihtgeWrHDSowh6Mn/WLeiyaHSch/Q0cOOTiqRb9nF9JsLMH1PWEumSBKsnF1DdkIoUPz8tW3JsxDKCwAo98K/+NamwEZ24H4hNLTj+POfgYdd87P2VPXEIeNhZEaUXBFT7nAex1wMMP1Baof7aaoDVSJdA81roVKeaTUxiO0CKdj81bCJxSX3hCIgeF3v9d7el9dSBvVLZ+1WFhbesMzJvT0GIwcXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 14:21:42 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7633.021; Tue, 11 Jun 2024
 14:21:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "lstoakes@gmail.com" <lstoakes@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hch@infradead.org" <hch@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"urezki@gmail.com" <urezki@gmail.com>, "ycliang@andestech.com"
	<ycliang@andestech.com>
CC: "patrick@andestech.com" <patrick@andestech.com>
Subject: Re: [RFC PATCH 1/1] mm/vmalloc: Modify permission reset procedure to
 avoid invalid access
Thread-Topic: [RFC PATCH 1/1] mm/vmalloc: Modify permission reset procedure to
 avoid invalid access
Thread-Index: AQHavAEpf8TIVvQH2keQ+FOXqYrmzrHCnViA
Date: Tue, 11 Jun 2024 14:21:42 +0000
Message-ID: <5e603eedf9e8fbd6efe1d118706dd82666e54251.camel@intel.com>
References: <20240611131301.2988047-1-ycliang@andestech.com>
In-Reply-To: <20240611131301.2988047-1-ycliang@andestech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM3PR11MB8735:EE_
x-ms-office365-filtering-correlation-id: 9fd71437-7a4e-4521-51c2-08dc8a21d130
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SUc4YjZsajM2cWlWcEgwRHJtWng3b1hXa1Nnay9FaUk0WTdONVhGaUYyVW9u?=
 =?utf-8?B?R1RKN2NFZFZBaVhnN0RESXFMcFFybThGM2ZsQW1lSDZDcWx2bDF5ZXVLSHNz?=
 =?utf-8?B?Q2FjOXpzeUFreVlyczRFcHdFWlo2aEVwQzRUd0U4VmFIQTYrdVk4Yzd1NG1F?=
 =?utf-8?B?SVZYUkhpb3BIUUZWaXBMQ21IL1hMRjI3dW84ZGo3QlU3TktUNlNYOWxMcGtl?=
 =?utf-8?B?K3VqcDRtcUdGSzdhVHVZSWljbXRodEgrSStLUkF0UzJHcG1qSjAxOUY4K3dt?=
 =?utf-8?B?WjdSSjlzdEtHNmMrelE2Q2YwQklteWhrMGxGM0lpQ1B3b1lpcHd3Smk2SnRC?=
 =?utf-8?B?QkQ3dkZteWptcHdnalNVNmF0cWt5eUVKTkdTb0ZSaTJWempPVVZOVHlESXZM?=
 =?utf-8?B?TzJ3TXJUenBNZjdLaUovMUNxRGpoek5ONFdxcE9QVWlNRW0wc3IxYms1V3FO?=
 =?utf-8?B?WngwbngvTS9FSWpYMUlCbHB5STZQeDA5Q3d6eHB4Zkg1MDBhN1ViUkt3OXBM?=
 =?utf-8?B?UjdwbVFSbi9OQ1F0M1JuUlBZbWJvOGlLb1o2TU1CU0VJcG0rT2gyZ29iRERS?=
 =?utf-8?B?aFBRb1ZQSFpqcjNQWEFBREk4NFd1cUFDR0VYMDdzTjkvc1p1YjBwdXJTRlhC?=
 =?utf-8?B?VVNCbWxoTi9WY05KaWk3TTRWKzh0ZzU0WDVEUDBjRVhwZlQ2UnJKSy9YVlJk?=
 =?utf-8?B?YzRYc2lTdjZlSHpicDZZNDBzT1B5ZTNscnVFaVNvdDZwTWF2VXkwTFBqN1hQ?=
 =?utf-8?B?RU9kZnRyemdMc2psVDVoU2ZVQ0dEMnVJQkVHTVdqSHdwS2RQRlJVNnBNbDlB?=
 =?utf-8?B?bmFGZUVqNHN4VDhYRzhIaTBzYjlOMkZFZmFlZURVRzc1WDkyQ2cxT1Zhem05?=
 =?utf-8?B?UWFWTnZYTFRDc1hmVS9KSWFGcjg3NHo2UTliRDBxR09raGFaNm9QWWp0T3NO?=
 =?utf-8?B?RGFMY050S3RWditLUmhWSFgzR3p4bndqTlh5MVBGME1SSlpwNTNXMWRLVUxE?=
 =?utf-8?B?WjlFeEM2Z3BINWNSZE5LNExlSmlGLzBIM2JVcmgwbUtua1ZpZkFpazV1TkE5?=
 =?utf-8?B?RDJUbUVOVXZGT0Z5VXY2aTN6SGxrcXZNdXpuUFBVa0hVaVlWaHZ4NWRXM3BO?=
 =?utf-8?B?TytaZDROUmlZRTY5ejAySUkvYW5kMnk4WWlPaVpaeEVXZHlnZHlaVkZEWkhz?=
 =?utf-8?B?Q3JLVWpiV2FITkhncjdsVlRaQXJOVFgvOWVZNVVkU3FzMTlRRWZJeTBkMjdH?=
 =?utf-8?B?M2IrNXdOQkVDMzFSM2ZxMTQyNWQvL1RucW4xdlhmVzMyb0hZQTlIbHNxZW9n?=
 =?utf-8?B?SkdBS2tCRXVDdXRDanBYT3Z1Mk1ySHgxRGxYSUhHeVZQNWN3ZDc3WjNzUEhP?=
 =?utf-8?B?SGFVRXJxM1MyVmZjU2s5ZjYrNzJKN3R6YWdLN2hwYnZ1WFQ5UGhLTXFhSXRw?=
 =?utf-8?B?NCtSaTl4aHhycGYrYStoWW1SUmxmVEpJeUJEN1dwMzdSYU9lRjR3NWZKaGFh?=
 =?utf-8?B?bGZ4Z0IvN1Azc3daSjgwZnRYSHFKMUdmZUhjakxYNVY4QjJhc0xVeDFSeWNJ?=
 =?utf-8?B?UDIwaHl0L2N0UDdjdG9TQ0JqV1NCZTZPbUVwMy90V0ZPTDMyYXp5LzMwUW5M?=
 =?utf-8?B?L0QxcEh0QmFuRTFZbmNFOE1NdTF1TEtlZE1xOFpqdFFyQzY5L1N5STVuMWI3?=
 =?utf-8?B?c0FSWitzNHpsb2dnWTVoTktxMXFVV01semk1cFZxOEQ4QndUdDFwM0t3Q0w4?=
 =?utf-8?B?cUJXSnY5TTZDNFV3MnBpck04TExod204TGtydVliY1hYSHFSWVhmRnIwRWZa?=
 =?utf-8?Q?MrDxu1EDHBQG7tvAKWJLuY7AV7kSk1KosROTU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE5YNW1FNHh0Q2tnL1pDOVN6MmhmOWhyZ0t2RzJOQXAxOGtsR2RiZ3NGTHlE?=
 =?utf-8?B?R0JNbmQwR0ZpdXBVMjBzdzBsTndrQVhzZ0xIVjZ5ZEtTQ1dhSmRvOTB2SW1N?=
 =?utf-8?B?d05LektVc1pyQTVLQTNEZGpwU1hqZDdxTGhXcW5uSjVxaHhmb1diYUhxQ295?=
 =?utf-8?B?aUNVQWcxV1FzeXd3dE9QU2p0b3daRDhkWU1BZTh3ejZ5MDU3cURSQjErS0U1?=
 =?utf-8?B?SHJjb2t5Zm9Vai9jN1FsVnY0dUtVMUJsb3pKTmdHZnRpczZQQ1IvY2FuMTNh?=
 =?utf-8?B?LzZ4ZFYzYUJQMjJPcXZSRk1vNGovbHFBNmV0aDd2QTlUK0RCWkxZUmxSWWRr?=
 =?utf-8?B?U29yQms4YUROSlNaenJEb3QrTXBzem1qL290b1paTlJNU0J5YnZVd0JqQVBV?=
 =?utf-8?B?U0xkR2RIV2lLNGVEK0N1R2lMUmFTSjRudUMzeVZnQXE1eG9sRzI0cXNod0J0?=
 =?utf-8?B?d0dSODQvU3Y0SjFJVDVxTDdXVXN2cGI0RFRZQitML0xKaDU0SUh6ZVNPUlUr?=
 =?utf-8?B?ZEpHQWsrZVZqWnlDVThEUmpJL045aC9QSkkyWVVZQTIreWMrOWxXTHB5aUhU?=
 =?utf-8?B?MTM3bllzRTcrN3UvWjBYQlFheHpFcTRjNnhXMkZ5T1dJWDZIZFIzeHhKdEFx?=
 =?utf-8?B?WmlJM0d5NDlMZ3I5M1NTcG9yYWZoejNGQ1F0aVBQMm1NM29QenBZdXdSd0s5?=
 =?utf-8?B?RndDTUlRS2NMNW91aFhMQi8zVENRcnNrS0Z2RDlzeXdsT1VQWkR6RkhkZXoz?=
 =?utf-8?B?YStFNDBBSUdScnAzL3ZxTVF3RlhKbkJjNjJEN2RCd1FmNHNrNzZVUzRuK3N6?=
 =?utf-8?B?R0oxN0phWjhLVkVpNmpEL0NoRGlpRDJSTVlWVVp5dmV6azhxdXBRK3NiOGtl?=
 =?utf-8?B?L3ZyUS9GUHAxOUxLZDJHTXhRVHpyTlRieVRlK0I4UzR0S0E2TlphT2thRFB3?=
 =?utf-8?B?T2dzVWR5VENzMnVDTmQ1Q2ZUaFVLV0dKWWNIVEVlc3Fwb0EzTnZxRkpxcU5a?=
 =?utf-8?B?dDZITkU3UDFuQzJ3UENuSWpxUE0xOXZ5bzNTa1NWQ2NFQ0NiMERDcnh3U2JY?=
 =?utf-8?B?UDMwTENWekhhWERWc3ZIM0h0N3UxRWJmVFBKZ0hibHc4Z1cvTnFmN2FWUWsv?=
 =?utf-8?B?cHpQVVByRVprOFBaUHAwZEJHZGJwYUZiVHVWSkhWY0RhbW9JMHJJLzVOUFpY?=
 =?utf-8?B?cmM3ZGlzdVcwamQ5ZjMzbnJicEl2NFIxc0ttQlFqOWtxMFdOeldrNjZtRXRV?=
 =?utf-8?B?ZVVpZHpmemFTeEorOWI3c1dxQkFYZUpMU1lNK2FobHlTYjVZRWhRNG9XMUtl?=
 =?utf-8?B?cDBEbTR2UVRuaUplVUorNUQwbHIzeVkxZ1U1ZzJEdWhCcm9VSU10UndKUWRy?=
 =?utf-8?B?QldyKzVsR0gzZStUTkYvNGVvNlR3YURwWmtOb3pVOVAycnVaTXgwQ0VzUGww?=
 =?utf-8?B?ZEtXMGliVDhEM1BMVXpwVkQreE9pRDZBUkJ5MFgwRW9CZit4blFRVjhhUko3?=
 =?utf-8?B?Z2dUZThNVUxEeWJXeHUwa2ZNZnl0SDVVRmROS1Q4WnFBL0o5WXBEZEduTGtI?=
 =?utf-8?B?NUJCTVZ2NlY1NzFpRWlSYWVhS3lvdjJZRjlvOGQ3VXUvMFBWMFJSdzdWRDB1?=
 =?utf-8?B?dUVEbUJFNTZTdWpObE15OVRwRTMzYno2Q1dQU2xCejVLZEU4RFFNc0dtdjAy?=
 =?utf-8?B?ZDR5a0R6SEJrSFhyb0pPZ1d4R25oYVducnhlZnRaWXo1K2ZUb3ZBSmlyQnJ1?=
 =?utf-8?B?RWNqZ3VwZWxQSVNVajFpM2JlR1RZZnQvdDhYV2htQzdmTnljUGhEZlpiMXJT?=
 =?utf-8?B?NlFwOUZqSmZMN2tIMldqR3ZwYmJNM1BzUmpzSHZ1S0tKd251UERtOW55S3cv?=
 =?utf-8?B?THVGVndMeUdzQU0yMisrQ0ZkdnFsaStzZ1YwcGF6RE9aR0dTS0wrVTBQZ1Z0?=
 =?utf-8?B?a3A1b3FVR3VPcGtrUmFxRmUxZVR2MWFUMnJzRUNyK2hrZUwxU2dQeFV0V0sr?=
 =?utf-8?B?YjdyK3MyRnl3Wk5neHJVdnE3aVRwUzdheDgvY0lsT2VtdlpDN1k5SXVZZTdq?=
 =?utf-8?B?NVViaTZTb0U1ejQxODZWdythcVNmdGk2dnp0WkhwMmZpVHNnc1ZTNFFnbmF6?=
 =?utf-8?B?bGdOVXRkOVBwT29Na1doeVRnd1V0Q1ptZk14VEJLN0JlY1J2T0VicFk2cFJ5?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15E029610203004C9A04648E43AECE49@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd71437-7a4e-4521-51c2-08dc8a21d130
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 14:21:42.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGEvnJY6+EGfZZ/UPw8o6pD5uTI/vZ09QSzFX+wB1WZCBPpg24g+/fh+U01EV0Va582A9+UT2ZbKYiPPtqom5lcb5fdm27pVng8khj6JRt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8735
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA2LTExIGF0IDIxOjEzICswODAwLCBMZW8gWXUtQ2hpIExpYW5nIHdyb3Rl
Og0KPiBUaGUgcHJldmlvdXMgcmVzZXQgcHJvY2VkdXJlIGlzDQo+IDEuIFNldCBkaXJlY3QgbWFw
IGF0dHJpYnV0ZSB0byBpbnZhbGlkDQo+IDIuIEZsdXNoIFRMQg0KPiAzLiBSZXNldCBkaXJlY3Qg
bWFwIGF0dHJpYnV0ZSB0byBkZWZhdWx0DQo+IA0KPiBJdCBpcyBwb3NzaWJsZSB0aGF0IGtlcm5l
bCBmb3JrcyBhbm90aGVyIHByb2Nlc3MNCj4gb24gYW5vdGhlciBjb3JlIHRoYXQgYWNjZXNzIHRo
ZSBpbnZhbGlkIG1hcHBpbmdzIGFmdGVyDQo+IHN5bmNfa2VybmVsX21hcHBpbmdzLg0KPiANCj4g
V2UgY291bGQgcmVwcm9kdWNlIHRoaXMgc2NlbmFyaW8gYnkgcnVubmluZyBMVFAvYnBmX3Byb2cN
Cj4gbXVsdGlwbGUgdGltZXMgb24gUlYzMiBrZXJuZWwgb24gUUVNVS4NCj4gDQo+IFRoZXJlZm9y
ZSwgdGhlIGZvbGxvd2luZyBwcm9jZWR1cmUgaXMgcHJvcG9zZWQNCj4gdG8gYXZvaWQgbWFwcGlu
Z3MgYmVpbmcgaW52YWxpZC4NCj4gMS4gUmVzZXQgZGlyZWN0IG1hcCBhdHRyaWJ1dGUgdG8gZGVm
YXVsdA0KPiAyLiBGbHVzaCBUTEINCg0KQ2FuIHlvdSBleHBsYWluIG1vcmUgYWJvdXQgd2hhdCBp
cyBoYXBwZW5pbmcgaW4gdGhpcyBzY2VuYXJpbz8gTG9va2luZyBicmllZmx5LA0KcmlzY3YgaXMg
ZG9pbmcgc29tZXRoaW5nIHVuaXF1ZSBhcm91bmQgc3luY19rZXJuZWxfbWFwcGluZ3MoKS4gSWYg
YSBSTyBtYXBwaW5nDQppcyBjb3BpZWQgaW5zdGVhZCBvZiBhIE5QL2ludmFsaWQgbWFwcGluZywg
aG93IGlzIHRoZSBwcm9ibGVtIGF2b2lkZWQ/DQo=

