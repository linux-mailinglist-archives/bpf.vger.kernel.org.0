Return-Path: <bpf+bounces-29744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FCA8C61D3
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 09:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D4E1C20C1A
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 07:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D4446AD;
	Wed, 15 May 2024 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Al2nLqeA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803629CEF;
	Wed, 15 May 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758705; cv=fail; b=RrYdSRl4tH//Cc4PI34R/Fy11RHxXHuhfumKilbm49fyGWbmiA79pqMsRqZze6vHNlRZr1d7RuIxxEwYZ5pOZ5k6IlaLVmfx7jgqM23aWMNV1y8+hZMU1ZtiivdPKmOJMufp4Cu5zQX/gh550b47E5dz2hmETRtxuLeX/SfGkRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758705; c=relaxed/simple;
	bh=8TAp7iQjtG/+TwfRG/fL9H4aZIvFbRjsaE7lhiE44Z8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YrojbQCsKDkCmmJKgmXq4w6kaaJGXeOAu+yzm3555gsssl2/68Sp5ShcjZcYBUQUxA5nNJo4KzGXK1B4i9bTyj2WOON42XUHdZV5tSVTIx1JMWqXma9bCQVctJDsja9diFvwB6j/+UXs/vrNvK3mpU9p8KzkhKsIgXv/stuOW8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Al2nLqeA; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715758703; x=1747294703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8TAp7iQjtG/+TwfRG/fL9H4aZIvFbRjsaE7lhiE44Z8=;
  b=Al2nLqeAoVCK6paE3aJ86FJRKmf93//VEj76sGl69HwwRI+JBHbnxHlq
   d0zEA6r0N/RWSDjzUJG4eFkr5kbqNOAaf4CpxlhH8X2F1oRyZ9MZjncDT
   jQ1Vcb5ZKG4pRbTygrqxMtDMyy5tUfYsiZDTCTmdapaioGkjwTkwZjz0j
   Hm3iWqajPx73J2snvxCKssSzf0Q9brb9y5DfpAgK8gbPrbuyTQIGOMEFH
   lv4aSqrPipbEjVggctPZR1lCVt2F202WX1KpTHtbviDjlP735Y69hC3ce
   zYc4TF8J2eEl0moFb1wdQHeawECppH4eWs6HPEHDVpREKftekFHg9Ivfz
   g==;
X-CSE-ConnectionGUID: goFL3q03RSiDvkrNdCjmRQ==
X-CSE-MsgGUID: Kw7fTNyISBW3FsjTYF3XPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="34300683"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="34300683"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:38:21 -0700
X-CSE-ConnectionGUID: /XZEcogxQKC1T9GIKil5Sg==
X-CSE-MsgGUID: lHDzN7XnSBax2KHN1Q+WdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31545955"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 00:38:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:38:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:38:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 00:38:20 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 00:38:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1zrtuFn64lxgsBj+Q2LEEhDwiDRLkfu/M14yPJbnMP++uDo98s/fR1V7JlXWLXz/+eJRvzmg2lhCVitykThJ0gWPjVfh52rCwiKEUNTWTXfImsSu9JeQQrCHFtJe9P6lmjHFC97gIs4yufhE8PA8MjMfsEjLYf9aDH6emo2mSIPt9+xslT+/UBzUjDLh+aO/NDx02BWp32AY26JbpQT2i2zjm5EvZE5XAXaapEUXOWqmZZ3FdcWMJAuhs/D/wrqIXea7/N+F8dDcsBWt1YRJTwJMudvgh/Q4Y8EblHUdmI4S93lBQxtV2FzAGJwe2WVIwpFUaUWyudPVuucxFHKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSgWs6rjou2LivDB8+F2k9g250w2rHhWX5YDD8mvVn4=;
 b=DScJk8vzH5SNNeskuO2nEJo/zI327FKLdivITkKz0Y8FKXHHXC3ohlBfa4CzXqrCjTq7gpGulFAyHXgQtpIFfJ0s0Sg/99mHmuA6hFBTiQWKuMq1l2ujIEmCS+pNbX7gisHaBYrIjWLuZUzhqA8u+grNVt46gbZMjx2h6byJ425oZWAaewa5waaSxbQVg9GjyhBixOqfkLn7WLKa+igXLQIjYFhZSY2uDzKCRLpKngJvN+hCr5RW9oJT5I+T+xE0/ohi8YU0zWZhBLgH4lqJ9swGobn1M07zequ8yMPIqRd6PL7ds/uIizI839pNGhIdCVfKm38IFPZKaWuzBt8fLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ2PR11MB8568.namprd11.prod.outlook.com (2603:10b6:a03:56c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:38:18 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 07:38:18 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Andrew Jones <ajones@ventanamicro.com>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "luke.r.nels@gmail.com" <luke.r.nels@gmail.com>,
	"xi.wang@gmail.com" <xi.wang@gmail.com>, "bjorn@kernel.org"
	<bjorn@kernel.org>, "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "pulehui@huawei.com"
	<pulehui@huawei.com>, "Li, Haicheng" <haicheng.li@intel.com>,
	"conor@kernel.org" <conor@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: RE: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Topic: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Index: AQHao0tSYAL6LqZaWUWtv7jZE6ZoR7GVZY4AgADuVMCAAG0hAIABKwRQ
Date: Wed, 15 May 2024 07:38:17 +0000
Message-ID: <DM8PR11MB5751626DA9EFDD7F2DB8D7B1B8EC2@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240511023436.3282285-1-xiao.w.wang@intel.com>
 <20240513-5c6f04fb4a29963c63d09aa2@orel>
 <DM8PR11MB575179A3EB8D056B3EEECA74B8E32@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20240514-944dec90b2c531d8b6c783f7@orel>
In-Reply-To: <20240514-944dec90b2c531d8b6c783f7@orel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ2PR11MB8568:EE_
x-ms-office365-filtering-correlation-id: 4cb1ac95-3891-45d6-c28b-08dc74b1fc6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?Windows-1252?Q?2lYIoUzQcsN+2klKO3v2YY+sEibWUM8B6SHD9rkI1mzs4tIn1F7NeMnJ?=
 =?Windows-1252?Q?tm0v6WxF6UeE6Y06KRG9N07WAHpDQjMT6ZfYdRDH93XL2NTvO3OHTVYZ?=
 =?Windows-1252?Q?TupcUP2LfcufIZR3xoArL996HlLuiS68rGUn2kwh+pJ1Gg0kVoGAK6Ke?=
 =?Windows-1252?Q?a3FIO065AGWNk+nlBL/CI15xgTQn9ZCxCj+FgUDA5XXWxTGkZFuA4H2H?=
 =?Windows-1252?Q?o2B3Evcm2vhvavwp+4R36qLK4sN3oQsVphsNWwobRpHsMYPuBtWPrk8k?=
 =?Windows-1252?Q?ZltDWXdu9OZp+MHjJICiHthxDy9GGmuGgjwASXduYKj4akC9N/VExus+?=
 =?Windows-1252?Q?YXYTzgo+vVqNV5oOPLuiR1Y4q+/sMVOEdDziLr/pisILS93mMlF7lZyG?=
 =?Windows-1252?Q?txziRQWtFrI7qcYrVtIcMWlY9f7zbCjWCNPL9RzYOs7JMKbfFb+95D04?=
 =?Windows-1252?Q?kJT0cldkYHIUjLmLOss7O6WkrTz7Ont02Hr6P/88irQ3jfnq4ta3O+tD?=
 =?Windows-1252?Q?oD1U5OVBgNZ+TpHsEqg2hkyWsh/xrufQCG9NDo00I/+JeHL4uu1H5u4r?=
 =?Windows-1252?Q?vSkBs4aGKueXL22+DfheWwvC6wS5xo/iphk6tWyKibTg8FyUT2DDRNFf?=
 =?Windows-1252?Q?FYRkk9F112YBb5VRRqfJEb/sXa5H+E/FFJYVioplTfSH7PHw5mkxsXNb?=
 =?Windows-1252?Q?njFZvpTHc2JfQDaOQGQmsJDThyAXTA8u8oajhMF3RkyZv7HYM7sRWxq1?=
 =?Windows-1252?Q?7xIrx57wKE67G+4WAhyQd0UepZgqEuMrw0j50r9a1jULn1wtHTSj/BP2?=
 =?Windows-1252?Q?BOpv+uh+sy+eOaGG5FLuAxOXzoxvPie0z0hkHvhIEtVM3a2knXURuT8h?=
 =?Windows-1252?Q?eFGA6SRHdqTQib0QsGfsOe2f232TpIAwNijFzByVzQPm+UtNjXr1NdJ3?=
 =?Windows-1252?Q?rvbQ/HVGAEaok/LRYaOD+tuIu+6uo7OZIikjdmYw64OxWM21ATMgQGQa?=
 =?Windows-1252?Q?CFkJk7NRS1D3hswdXJ9wKIV+jAuAXjnb49o7g2/Vv3oZwfKYEzRgmEZD?=
 =?Windows-1252?Q?GoZKexyHmQG5Ew/ROQJ2lPpx8AvMDQcM2ydiJR3sQ2CZATee8VsbMFqt?=
 =?Windows-1252?Q?IjjyKK0Fk4e1kpQpFJUvnGeDQB2CEYZ+iNEhUmjIuHtLfpiN18k1mKar?=
 =?Windows-1252?Q?Mv8bnt+DLt7C7ZDzEaJBhWXPgzhq+1lByFumbpcHAMKDv/sWsU1yMeAn?=
 =?Windows-1252?Q?ego8rxm99EKBJG4uc3lx7VaVF/SFzgd++GtDg6QkE11OlrHKUjE/ybBH?=
 =?Windows-1252?Q?6WDTo03P9Um0J+tNP54KGnVh9qBTNbBthTb0mdEhkQJoP1d5YEyKCrOh?=
 =?Windows-1252?Q?PCRHGHaGpVoB7fjpMjB9ju04F6TpiZWhcnEqnDSRU6jQWscblp7uF7MU?=
 =?Windows-1252?Q?pHRDM899CQWealz8GIFY4A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?jwoCXtKxsjg06I+KQKQKYwNwwKQLEeILr7RfOWN8+gRsg7XkImGJjjd7?=
 =?Windows-1252?Q?lo/kk2jTNohQgR+uXWhOMb5RJfDLnTt+GNBb+mGQx6TrZ1LEyf4yZ5jM?=
 =?Windows-1252?Q?HuFcs6kQSvhsEh+S9N8CFbhnI0wVSF8/l7VzyuULFZkCHrWDCPYBw9aE?=
 =?Windows-1252?Q?ED26NwjqGhc5196sPgNjix5aXkycM9jSyutoNevfiXgDAuNcqqS9nhXV?=
 =?Windows-1252?Q?q+f05XG5xpQvzkZ8v1rjNmY4JDsuJ8fXkH0KBO3gDPU8MuMNTANlXTo2?=
 =?Windows-1252?Q?narGSJVyXVlmi/0HWtALyn9CIPwl01kMyz/eWm3xCAo/CuIq0Q9FhPx3?=
 =?Windows-1252?Q?wJwxE4gMkE/Xapy92Z7UgZfKnU2idLzd7jLgHsWEvKkfML/lUs5RD266?=
 =?Windows-1252?Q?GMi25KDwPiYCh+m1vkY8Z1lqtDC11BZ3imn8CCFDG0qGDvztY6/e2f3s?=
 =?Windows-1252?Q?LFwOk8x6OfTN4FyfgTWy8K9fER/Q6MhOONx4g7l0Fh7du5tgviqMIyeA?=
 =?Windows-1252?Q?YsDVk1vfkJgf7UjYLWsxXVMbZ7rzUN3j2+fLi7DsGFIEylKMt72UQ1Ws?=
 =?Windows-1252?Q?12txWwC/nu0hxBYuSY6s9tgNSIZzCmxWImo0KhHzVPIzD/WoBV9XHz0l?=
 =?Windows-1252?Q?TboBoRSbD+MGF7LytB704YgFjvPBqNq3y2zkXcmPW7UGOZlwpbdlvZ79?=
 =?Windows-1252?Q?HKSzY9DTj3bL9bDZB/NobZkhpQUnhY1ogXMYkeJ+p7qd4ra0HPENYMcd?=
 =?Windows-1252?Q?SEHNuYZyYZXqviTWe7+jHROZ0YXtAx+KcG3I7o1JieeJ1e6D8QTyWgAM?=
 =?Windows-1252?Q?ypSDvpzz9nytxqsDOEc9aBezpgGmI5RgFYAbowQWwqO2mvfgR93SgxGP?=
 =?Windows-1252?Q?0GKvn63gjmrEpzfmyfhy7YyyzHX82zEitAO8XA27H7fL0FhSr8X2USFI?=
 =?Windows-1252?Q?3merHI0BXiNKR50xe5ZhLROMG15C44twViPdNU9BSGXiDxKcWk7aUhyr?=
 =?Windows-1252?Q?diZ/4n4bscTtWpZwfYbtuXqHAO69/YaEqQUzC77tX7iE6nVcXlH4BTgU?=
 =?Windows-1252?Q?Z3z71nOCH3yF5JVspLjzzM0wmBiK/Q0sO3qtPafQA8uZ8k45//eYukjz?=
 =?Windows-1252?Q?DtYF39HBDUcbOOIIJJboNOCYdmC5mW54IDfjp/m8uWKP2feHmnA05t8K?=
 =?Windows-1252?Q?Qg6kDIMKAAqzaS0EoHwVpCrWykLhcHIohyUrEE9wfxXvtsigTJA/H1uk?=
 =?Windows-1252?Q?U8YoKuIEZG6FTb9a2dzmaVDS3M/+aPMIuKHR0LJnCJe6B2r0nqN/9iYK?=
 =?Windows-1252?Q?AP8S39+XdqZvlWTItiz85UCo4hGXQ7lUkcbs71gIvyci5C44eoQAAFY2?=
 =?Windows-1252?Q?u39BylBIVBtB2xf3+p5ATJhB6IJLzOKAJh6e8BKIL1GOn53c8P6NlDwu?=
 =?Windows-1252?Q?Rpp/16x40r70yiTc9vMs0lk2FcFqlOCKCa1UEB09Fb8oOHGaTNy2xCiE?=
 =?Windows-1252?Q?FoRE0eeDsApR/ekbLEFDzDOYIs6G2bGVewG86yO6wrexf0f/YZrDkBaM?=
 =?Windows-1252?Q?wZhsVcGxlq+oFsLoUfiSal9tSsNa8DzKiPZ77zw+ui+2W7fX5/2KFNGb?=
 =?Windows-1252?Q?aIz4tkg8VvVUXuqOa4GwYHRu/9XAPjvik1xhr5NkfuRwpQCv7pF0RkEQ?=
 =?Windows-1252?Q?HkLZHVcs1n7VfuD4iR76RpLyCkKz6WXA?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb1ac95-3891-45d6-c28b-08dc74b1fc6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:38:17.2810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAaLkHDHqKCUb5kDB4BXaqrzR1V6Jq5aZuJ9EJ0TYrkVxuXGxsdMgQvSxbS7uxUBFCU35QnLHpJzvozLN8dnIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8568
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Tuesday, May 14, 2024 9:37 PM
> To: Wang, Xiao W <xiao.w.wang@intel.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; luke.r.nels@gmail.com; xi.wang@gmail.com;
> bjorn@kernel.org; ast@kernel.org; daniel@iogearbox.net; andrii@kernel.org=
;
> martin.lau@linux.dev; eddyz87@gmail.com; song@kernel.org;
> yonghong.song@linux.dev; john.fastabend@gmail.com; kpsingh@kernel.org;
> sdf@google.com; haoluo@google.com; jolsa@kernel.org; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; bpf@vger.kernel.=
org;
> pulehui@huawei.com; Li, Haicheng <haicheng.li@intel.com>;
> conor@kernel.org; Ben Dooks <ben.dooks@codethink.co.uk>
> Subject: Re: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extensio=
n
>=20
> On Tue, May 14, 2024 at 07:36:04AM GMT, Wang, Xiao W wrote:
> >
> >
> > > -----Original Message-----
> > > From: Andrew Jones <ajones@ventanamicro.com>
> > > Sent: Tuesday, May 14, 2024 12:53 AM
> > > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > > aou@eecs.berkeley.edu; luke.r.nels@gmail.com; xi.wang@gmail.com;
> > > bjorn@kernel.org; ast@kernel.org; daniel@iogearbox.net;
> andrii@kernel.org;
> > > martin.lau@linux.dev; eddyz87@gmail.com; song@kernel.org;
> > > yonghong.song@linux.dev; john.fastabend@gmail.com;
> kpsingh@kernel.org;
> > > sdf@google.com; haoluo@google.com; jolsa@kernel.org; linux-
> > > riscv@lists.infradead.org; linux-kernel@vger.kernel.org;
> bpf@vger.kernel.org;
> > > pulehui@huawei.com; Li, Haicheng <haicheng.li@intel.com>;
> > > conor@kernel.org
> > > Subject: Re: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba exte=
nsion
> > >
> > > On Sat, May 11, 2024 at 10:34:36AM GMT, Xiao Wang wrote:
> > > > The Zba extension provides add.uw insn which can be used to impleme=
nt
> > > > zext.w with rs2 set as ZERO.
> > > >
> > > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > > ---
> > > > v2:
> > > > * Add Zba description in the Kconfig. (Lehui)
> > > > * Reword the Kconfig help message to make it clearer. (Conor)
> > > > ---
> > > >  arch/riscv/Kconfig       | 22 ++++++++++++++++++++++
> > > >  arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
> > > >  2 files changed, 40 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 6bec1bce6586..e262a8668b41 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -586,6 +586,14 @@ config RISCV_ISA_V_PREEMPTIVE
> > > >  	  preemption. Enabling this config will result in higher memory
> > > >  	  consumption due to the allocation of per-task's kernel Vector
> > > context.
> > > >
> > > > +config TOOLCHAIN_HAS_ZBA
> > > > +	bool
> > > > +	default y
> > > > +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zb=
a)
> > > > +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_z=
ba)
> > > > +	depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23900
> > > > +	depends on AS_HAS_OPTION_ARCH
> > > > +
> > > >  config TOOLCHAIN_HAS_ZBB
> > > >  	bool
> > > >  	default y
> > > > @@ -601,6 +609,20 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
> > > >  	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
> > > >  	depends on AS_HAS_OPTION_ARCH
> > > >
> > > > +config RISCV_ISA_ZBA
> > > > +	bool "Zba extension support for bit manipulation instructions"
> > > > +	depends on TOOLCHAIN_HAS_ZBA
> > >
> > > We handcraft the instruction, so why do we need toolchain support?
> >
> > Good point, we don't need toolchain support for this bpf jit case.
> >
> > >
> > > > +	depends on RISCV_ALTERNATIVE
> > >
> > > Also, while riscv_has_extension_likely() will be accelerated with
> > > RISCV_ALTERNATIVE, it's not required.
> >
> > Agree, it's not required. For this bpf jit case, we should drop these t=
wo
> dependencies.
> >
> > BTW, Zbb is used in bpf jit, the usage there also doesn't depend on too=
lchain
> and
> > RISCV_ALTERNATIVE, but the Kconfig for RISCV_ISA_ZBB has forced the
> dependencies
> > due to Zbb assembly programming elsewhere.
> > Maybe we could just dynamically check the existence of RISCV_ISA_ZB*
> before jit code
> > emission? or introduce new config options for bpf jit? I prefer the fir=
st
> method and
> > welcome any comments.
>=20
> My preferences is to remove as much of the TOOLCHAIN_HAS_ stuff as
> possible. We should audit the extensions which have them to see if
> they're really necessary. I don't mind depending on RISCV_ALTERNATIVE,
> since it's almost required for riscv at this point anyway.

I go through all the existing TOOLCHAIN_HAS_* stuff, all of them are
helpful for compiling the corresponding assembly code. So they're really
necessary.

For this patch, I would drop the two dependencies for RISCV_ISA_ZBA Kconfig=
,
as the jit doesn't depend on them.

BRs,
Xiao

>=20
> Thanks,
> drew
>=20
> >
> > Thanks,
> > Xiao
> >
> > [...]
> > > >  {
> > > > +	if (rvzba_enabled()) {
> > > > +		emit(rvzba_zextw(rd, rs), ctx);
> > > > +		return;
> > > > +	}
> > > > +
> > > >  	emit_slli(rd, rs, 32, ctx);
> > > >  	emit_srli(rd, rd, 32, ctx);
> > > >  }
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Thanks,
> > > drew

