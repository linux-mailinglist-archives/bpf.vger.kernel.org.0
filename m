Return-Path: <bpf+bounces-30886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A18D4265
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 02:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2091C216E7
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 00:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82A8C13;
	Thu, 30 May 2024 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoyYYNfg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA76FDC;
	Thu, 30 May 2024 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717029154; cv=fail; b=gjyPh8KMkexg6XMBaqaT8nbF1/3u1lQQufBcWOu9y934WjKGwzQ9Y3ZlrRrBz50Vv9xWlfWU3u9LwiP6o3EGVBSVwDMdaKBV89yiMVBIfZHqUv08+OGT7EfGguTMUvPEcLZvaQILUcJakkl8sj05NeJqInz/NYPeo8fFjHKIUN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717029154; c=relaxed/simple;
	bh=6JRdx58UPPHOFKNgQw6ddHnZaqIPMOKYeWFNXCDniD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s1z2FkL+VHNXN4dTQUH34npLwXqXuebe7rji7hxpjfonEsDQwqmnCYiFlQSPfWVbS8eF0lSTzdbrXW9aFBsY/6El2VXTpHGIUJ+6Xa0GzQEouEtmrOsaVdMAymUkk5/+d7yk9VM4v1IuLs+HdEujKaMeEHbYw0+/BDPfDDj3x4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoyYYNfg; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717029152; x=1748565152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6JRdx58UPPHOFKNgQw6ddHnZaqIPMOKYeWFNXCDniD8=;
  b=RoyYYNfgnMa3OCjhm66UoZk4QMDvkzWWn96npkC/pnddexu/mcp6NhZ5
   JxyUpKEdjWhpIl9jnN1iLNTPucWlx31I0EOjSm4Ei3c6Xje+lQZ949eQd
   0CuNrp0X3xDkVsgvetVfObviSrcxsLlfLQk17+Jh7mmewRO5HnXB4B41Q
   2LllKGbOCXERBzLcRGQuur44oaoNPR9/HxL0y+x4dksEEoo1xz6MO33uu
   xirstYpqO9byvFxNuKk1/EXcnYx0oT4OitSI1Ckk5Ilj0EE168Y//d38f
   yRPi0CVIODzwEnNPG0KmKp9kRVewb3AUGCGfvL0v0Lb+jUfG8KDcP5l9C
   A==;
X-CSE-ConnectionGUID: 1r7DdXhcRW+EVy8mSIXRew==
X-CSE-MsgGUID: nHYuEL1bRKaPuesycFOCPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13639762"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13639762"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 17:32:31 -0700
X-CSE-ConnectionGUID: R0jJB7z0Tiu8zPV0Cjg8SQ==
X-CSE-MsgGUID: dosfD6M9Si2h9bIFcNhPmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35683299"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 17:32:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 17:32:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 17:32:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:32:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMd7MvBDquTIFwNVGorjWZnGO9CpWfBW09ObKkeTSE9JNhidxTo/HXex49zsYOXOJTKevlNXbcrLmU7fgCZ0tcNASkPzUk0zwTQv7jk6xhl6wrYdavZhBR9KABnHtYy5rY3RLk6qz+JSsGjs2q3kQMmRgIiGTlgh+Es1fhC/MOkP3GLkL3t5GFiHzmWr+7Y315vy46DPQ2p3Yo6LtGlP7k594dDfGsBFUNru4FEe3W8rOq7hgby0dqpyalj7eMXia0b/PCU0tZZCoOztz2qH03nCtEAwv11DeEZw4V+VMJWPN5pm31VZmsJ1onS3oV9Ms7NXDZ1ENLz4eW5qY2/aJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JRdx58UPPHOFKNgQw6ddHnZaqIPMOKYeWFNXCDniD8=;
 b=WOkbwcIl7b0cmqq3tBCJLVdp8lqV9CK3CbWM2h0SfWazBekrezV2pXi5DGeHwJDMXspguFJBJFBsVqSdxQXCoRtK8oRU0kTLCyvs3hqkko9vGbpi4Xz4lbqgpO0z9Hhrv+evU921QE8fmXTH6KfRNaHMqvD+2799h9+K4b3NSZefB1YVjAbqfi25F8QCWfYR/W2dxOSpyYp2SisWaYUOrvULecHwijQgrCJjakR2RAv64xyKiiaR104W3ZBM4B7jPBPRdk8TgmFcsq+OETN6CH3Vg551xy+pvZFYgcVovOuhn0uUztTnlqP3Cnx4E6uTL6ncZQ7Nzhbp4pw94svGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 00:32:28 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 00:32:28 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"luke.r.nels@gmail.com" <luke.r.nels@gmail.com>, "xi.wang@gmail.com"
	<xi.wang@gmail.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>
CC: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "pulehui@huawei.com"
	<pulehui@huawei.com>, "puranjay@kernel.org" <puranjay@kernel.org>, "Li,
 Haicheng" <haicheng.li@intel.com>
Subject: RE: [PATCH bpf-next v4 2/2] riscv, bpf: Introduce shift add helper
 with Zba optimization
Thread-Topic: [PATCH bpf-next v4 2/2] riscv, bpf: Introduce shift add helper
 with Zba optimization
Thread-Index: AQHara9yI2FU219CNE+YjwdJ0fq2L7Gt/WMAgAD4tEA=
Date: Thu, 30 May 2024 00:32:28 +0000
Message-ID: <DM8PR11MB5751F3EF15EFD82AD713AF61B8F32@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240524075543.4050464-1-xiao.w.wang@intel.com>
 <20240524075543.4050464-3-xiao.w.wang@intel.com>
 <87ikyx2bw7.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ikyx2bw7.fsf@all.your.base.are.belong.to.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|LV2PR11MB6024:EE_
x-ms-office365-filtering-correlation-id: fe264689-edbf-4d39-7648-08dc803ffc4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?S29xKy9nTER4NTBaY2ppYXFqOTlGcTYwTFVuOWNLdy9STW5ScFk2dFlCbHNK?=
 =?utf-8?B?TXZVN1F6c054cVh1TWphQTNoTTJqenYwSnZDVnc4K3czTXpveDVlQWFmWDlr?=
 =?utf-8?B?V09IME9TRm1CTWRwM1NPNWtOMUc3N0YxWmdNU3B4eStWbkFFdC9makcvME9t?=
 =?utf-8?B?MmVzekVrZXhLUGN0bjl5VjAwcTBTR1ljcGtLbVNld2E3cTlxbTIyL3NnQXBj?=
 =?utf-8?B?ck8wZ0VJZUZzSXVYNTV4bzc2S2NWSk43YTlkWmEvL1VuYmEydndVeHpUQmFF?=
 =?utf-8?B?ZG5jZHg5NU1wSUY5VEs2SmcvWFJIMWdNZlYxd1JwcE5tSmd5eUsxOXo5K1l5?=
 =?utf-8?B?dkd0N1ZXMy84SjZkNDdoWTVOMFBnQmM1WjJPdUU0SW5NSUdOQVJ2RHUrUW9y?=
 =?utf-8?B?amVweHNwaExQTlQ1eEJXK25GekRpTnFSOGwzNGxSTFAwa3dScWgxSGpuTVE5?=
 =?utf-8?B?S0VhNE9ITVpqWmJHNlM2UFQvN25uT1FkM1FMa0I0TXcvZjdDZzZrVDhnTWxv?=
 =?utf-8?B?TnBvQ05XemUyVmQ4NlZ5bG05ZVJpYjl0VUpwKzBKQWVqSWRaOGwxQklsYWZT?=
 =?utf-8?B?a3l3dnNEVzNkdHRtLzlkVVdnWnpvQzNUUlpCbEVkdHVKaDdiNVFaSSt2bFJL?=
 =?utf-8?B?QVo1WDc0VFhJZG92RGNBbzZIM1RUL3FtVjlMNmViSWtSZkxvai9UZko2d3o0?=
 =?utf-8?B?Y1JuOVVLUDJwWlR2WG1DOXhjcS80Ylp5UkR0Rzd5Z1BRT3dwenY5czFaNmkw?=
 =?utf-8?B?TVdiYlZmN2ZobGhMS3RvajZ4c1NNTG4vUncwMmxTWTd0VXZ4ZDJ3dzZobDhF?=
 =?utf-8?B?T2NmcDd3K1R4U09YSzBIVHp5ZlRWQ3VTWjVEMWZWeWpRWWZ1SmEyUTFvQ1Qr?=
 =?utf-8?B?MTI5QncyZUpDNWp5Z3pzK1Z1S00zRmkxdUYvQi9wVnI3MU8wY29zdDdBSHVK?=
 =?utf-8?B?aDZzZSt2T0pGcFBkRk9UemNZUW5nRTlqbVhLaFhQb3dmdmlzRnNwZEFsbi9J?=
 =?utf-8?B?U3lDUWJ3Um9pbGVNUGJZc2tvNG5yc3hSQmFwVWUzbWFVQkZIK0RaaXcvYXlW?=
 =?utf-8?B?N3pJT1h0T3lPWjI0Mmx1a2tIN01QV2NLR1lqZk5hcU5OenBJampTRXhXaEZB?=
 =?utf-8?B?ZEdPYnd1VzJaSzdYSllqaktlWTJEQnVZVVp4TTdBM21DN0REZlpobUx0STJi?=
 =?utf-8?B?MC9vMnpDNVNhOFYzdGl4OE51b0xUbFRTd3F0YVh3NEFlUVJKZEUyQVF0SUI3?=
 =?utf-8?B?UUpzQzk0QXRBODNneHBpaHJWY2hzek1xakxRczZKL01VKzYvMmhrS21CYnZp?=
 =?utf-8?B?RStlbVd1ckN3blB1RFZkYTZwMTlTYTV3dGNzb251dVcrMmxRR1liNHdXS2E2?=
 =?utf-8?B?NUFQaVpYcGtLUUhuY0ZSSE80YnR4cEtYVnBoN2hhc09qK01GMUdYZ2R6dUN3?=
 =?utf-8?B?RmJmUG1ncW9mWjhJc1pwcnZQVDJxbVl1VlFNVmhEeGhGQms3dHExbmYrUHcz?=
 =?utf-8?B?SkZKSHJWbjhhWEVFM2pSWlZhR3BLZnB2dm1qY01rRnd2TFRhRnpvMlUrS05M?=
 =?utf-8?B?WGx6Ui83Uld3SU5HZyttaGtvNVNpYW50bW9icThQcmluZWNNYnpqU3hnaklV?=
 =?utf-8?B?WnFjNUlXQk9adHhaZCsyOVg2Z0t0VXNjNEduWG0yVTc5RHN4TS96eWRCV01r?=
 =?utf-8?B?akpjQTZKYUYvQXBWVXJVbG1YTVk2SnVzakU0SmhEZWc4VnlTYXFDWXN5dk8w?=
 =?utf-8?B?cDJTbzNiOS9SNExKVEN5a2kxVTlpWGpvUTFZY3JUd3VZMGVpYkkyc3ZSc2JQ?=
 =?utf-8?B?TkRzMDJIMnQzVHdEVjNQZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJJMGF4SVNOVVFCWWVCdTgvMldqanpmbHJNRVJUNTFWU202SDFoVjNvMkVL?=
 =?utf-8?B?RzhwUXU2dis4d1puSXhqeFJSYjFWN0llVWFpSUZ6anUvRUJWMkd3TXgvSGwv?=
 =?utf-8?B?dVRsZ25MQ2VNbFM2OEgra09uSHIycUJNd3pZbkNaMzUxTUV4ZVk2dkRGTFNQ?=
 =?utf-8?B?VG9pSHE5a0N6QUpXQmRwU2poVFI0bGxQY1BHNkJrZk94OC9iTWVNei90RFpj?=
 =?utf-8?B?UnROMmtjdzA3dWxKRDJJMm8xd1dLYWhYUWZ5eFRJQ3ptaVpTTitsSlhhSDFR?=
 =?utf-8?B?Z2JwclVLL0Z6eTBlRDZJZGo1QUVieURjcGQxU3pxUHRlUkNhQS9EYVZ3Vkhk?=
 =?utf-8?B?Vlh1TERoUS9nTFQ5Ym1RQjJGdnJmcEVjYW9oTndNNHBoWXZQLzBjNmw3UW5r?=
 =?utf-8?B?T0oyUkJCRDNRN3Z6WHNNcHJVSERmZGdTV2RxVjFkazB6azNCR1ArOFAzb0Ew?=
 =?utf-8?B?Y2pSVm9laURjZUJLa0FTbllCSjN6VEFRQXZwOVJEdlpCMDR6TzJQTklLUUdW?=
 =?utf-8?B?ODRsekh0YkFhWFlvbWlMdXZyMXpOeVZ6ZUc0NmVRSEo5TnZodlhhUjYyUDM4?=
 =?utf-8?B?RjhRS3UvRkM5ZU5weGZLQnhrU2lvN2dRUy9KMWJGdFA5R2ttREJwWkZzYWZC?=
 =?utf-8?B?MmtBc0tjZEZHSUZ0dzQxNEcweWdNVWpsdlQzN1NaSmo4OVI5VmtPWTJWMnhh?=
 =?utf-8?B?TWNCTWFFdGZUWW9UQkhYOE5KekhrWGY0dldDeCtEYVUrL1R2WjZ5STgyeFdJ?=
 =?utf-8?B?SVBXaTNJaWFPaTM2djFyQ1E4V3NEVlRHVTI3RndnVnRwUTRyMFVINnY4Unhy?=
 =?utf-8?B?R2hqeWc1cTZFTzlNRVFvcWRIbU12Zkd0YkR4cmdkOWtJR2VVb2Z6QTF1M1l6?=
 =?utf-8?B?c010dUNNb2g3M3RhTVMrZEFVN0l3aVFGd1JleVJFWVJhbElPOTk3S0R1V2tx?=
 =?utf-8?B?ajZreUVsMmVpSCtkM0t3RnRwNDdSS05DRXVEazlaYVJxQkZGdExBWWFKOWxW?=
 =?utf-8?B?NGdMYTM5bjhHUms2MUMvNEYxYWZGZlRFYllQWFZ5bFpjMTNmNXhKVGkvKzkx?=
 =?utf-8?B?N1VVdzk2Yys2Z2dzcVlhRXMveEQ1M1ZIanRydU1lc2JRd3FaUUpCV0h6MWlS?=
 =?utf-8?B?WWM0V09GK0ZIb1FmQmtCOC9aRlE3WmM0MGI2VG9hNitNdzNqY3daZnNab0xm?=
 =?utf-8?B?emppSDFkcW03WjVrZVdoK0dvdlowaEd6OE5tdEZkS2lnVXFtSWEzMkxOUmJJ?=
 =?utf-8?B?L3A5MjRXUDNKbVVWZ0w3UGcyMU45bWY2Vk8rWU9CNS93c3NMaFljVFh2aStu?=
 =?utf-8?B?cE5ZMVhTM3lPaE1scFpCdStLa3lGQWNTZUczS1dSNmt5VnFJdUpKRHpIbnJE?=
 =?utf-8?B?dWFFcHpyemhLbk16YVpFZWkrMzBRVUM5OXh3SkY3L3JUWGlKZ0NUM25QK0c0?=
 =?utf-8?B?bnE0NkgyR3JGR2NRMVZveDNpcXJoYXlHenYxNDNBemNJRURGdk5CNUd2dTlL?=
 =?utf-8?B?M09DYklVZHhyR2FtS0xlVlkyaVZ1dFdwaU92VU8vM0V4amNkYXB1Q2ZLbGtS?=
 =?utf-8?B?Y3dNZHBtZWZrMmhJUVZ6NHQ1SmhjaXBhTG53MDRUMFBMZWRsbWx0N2J6V3Rv?=
 =?utf-8?B?eFpGaDAzdFNkQ0hROElVWFZwQVRXTndvVjdRZjRwQmVja2dYN2JhRHAzY3RT?=
 =?utf-8?B?RXJnSy9JR1JxaGJHaUFyUE1uMzBNQmdHSzIveGVzeERGZ3JlZTVnQk5xOFE4?=
 =?utf-8?B?U2VlNnprRHRUc0pScmY1WENCNTZqeS94Sk81b3htWUpFd2xFNnBYNTRwZ295?=
 =?utf-8?B?SXdIQ1Q4TkJnemc3SDBUWXFHSWhSaHZzT2tta0tWRjJRR2habHk1ODFJaGc2?=
 =?utf-8?B?K2xGbllOVW1qbmZLdlg1YWZKWXo0ZTFRK2pIZkJvU3lxNjFMQms4eFlnUjJP?=
 =?utf-8?B?eEtKaGFEbGI5dVA4endLSm1JNnQwZG5naElvenFqbHdtTGVOVnpUdzg0ODlG?=
 =?utf-8?B?bTgzWDVaWkZ3VWxBd3FXT09UU0ppT21uTXluMVo4eG1nbStDNUN3SlZyR3lH?=
 =?utf-8?B?Y2x2ZkhXWVRyZ0VuZ213VmRRUVVQK3V1aWRoWDBxV2RiLzJJRFRjeDRTVFpJ?=
 =?utf-8?Q?RIr5VSlPppC1Fqk1r4VsSUxFQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe264689-edbf-4d39-7648-08dc803ffc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 00:32:28.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AFGBGdOGNC4mJYaozXa86Xz2kyXgQJ+JeRfmiqAdLW7w2YISD8eZEgj+mor5ImtgMj5gmgPc+5ZhuOe6qDRzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmrDtnJuIFTDtnBlbCA8
Ympvcm5Aa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjksIDIwMjQgNTo0MSBQ
TQ0KPiBUbzogV2FuZywgWGlhbyBXIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+OyBwYXVsLndhbG1z
bGV5QHNpZml2ZS5jb207DQo+IHBhbG1lckBkYWJiZWx0LmNvbTsgYW91QGVlY3MuYmVya2VsZXku
ZWR1OyBsdWtlLnIubmVsc0BnbWFpbC5jb207DQo+IHhpLndhbmdAZ21haWwuY29tOyBkYW5pZWxA
aW9nZWFyYm94Lm5ldA0KPiBDYzogYXN0QGtlcm5lbC5vcmc7IGFuZHJpaUBrZXJuZWwub3JnOyBt
YXJ0aW4ubGF1QGxpbnV4LmRldjsNCj4gZWRkeXo4N0BnbWFpbC5jb207IHNvbmdAa2VybmVsLm9y
ZzsgeW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY7DQo+IGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbTsg
a3BzaW5naEBrZXJuZWwub3JnOyBzZGZAZ29vZ2xlLmNvbTsNCj4gaGFvbHVvQGdvb2dsZS5jb207
IGpvbHNhQGtlcm5lbC5vcmc7IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBwdWxlaHVp
QGh1YXdlaS5jb207DQo+IHB1cmFuamF5QGtlcm5lbC5vcmc7IExpLCBIYWljaGVuZyA8aGFpY2hl
bmcubGlAaW50ZWwuY29tPjsgV2FuZywgWGlhbyBXDQo+IDx4aWFvLncud2FuZ0BpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggYnBmLW5leHQgdjQgMi8yXSByaXNjdiwgYnBmOiBJbnRy
b2R1Y2Ugc2hpZnQgYWRkIGhlbHBlcg0KPiB3aXRoIFpiYSBvcHRpbWl6YXRpb24NCj4gDQo+IFhp
YW8sDQo+IA0KPiBYaWFvIFdhbmcgPHhpYW8udy53YW5nQGludGVsLmNvbT4gd3JpdGVzOg0KPiAN
Cj4gPiBaYmEgZXh0ZW5zaW9uIGlzIHZlcnkgdXNlZnVsIGZvciBnZW5lcmF0aW5nIGFkZHJlc3Nl
cyB0aGF0IGluZGV4IGludG8gYXJyYXkNCj4gPiBvZiBiYXNpYyBkYXRhIHR5cGVzLiBUaGlzIHBh
dGNoIGludHJvZHVjZXMgc2gyYWRkIGFuZCBzaDNhZGQgaGVscGVycyBmb3INCj4gPiBSVjMyIGFu
ZCBSVjY0IHJlc3BlY3RpdmVseSwgdG8gYWNjZWxlcmF0ZSBhZGRyZXNzaW5nIGZvciBhcnJheSBv
ZiB1bnNpZ25lZA0KPiA+IGxvbmcgZGF0YS4NCj4gDQo+IFRoaXMgcGF0Y2hlZCBzbGlwcGVkISBB
cG9sb2dpZXMgZm9yIHRoZSBzbG93IHJlcGx5Lg0KDQpObyB3b3JyeS4gVGhhbmtzIGZvciBwaWNr
aW5nIGl0IHVwLg0KDQpCUnMsDQpYaWFvDQoNCj4gDQo+IEFja2VkLWJ5OiBCasO2cm4gVMO2cGVs
IDxiam9ybkBrZXJuZWwub3JnPg0K

