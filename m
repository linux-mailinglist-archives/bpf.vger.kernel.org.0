Return-Path: <bpf+bounces-30790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6278D27D1
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54216287B5B
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7413DDCD;
	Tue, 28 May 2024 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHv2Xpju"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27C28DC7;
	Tue, 28 May 2024 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934678; cv=fail; b=F6qUmv5b++euBtsdgM4JBDbTY1QWQUq1ikOHL9f5xvLmvCFO3PUEeanKCiNf2VSjv6EdgzMw8WKDZWNfgyoTuBQyyxFKR1pU9/ZuohivHtthDcvdgBCLCLbNuybhCmTNi/FIzU6tHcamENAK8qPjsfdpbuzZcm2MGGtKrjy8DuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934678; c=relaxed/simple;
	bh=8SgLSBlzuHD5n70yWZzbDg8H5nH61fnw3a/Miz1zwNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cTj8ZLte3O5cP1dcroxX+c54k0YsKpFYjls0R2CCfgZQ1j62gY96ufis71avvKEXlBlUZ4hHPIyuQLhPU6IZeUOdzcSJ0U7bsLQDZOORapgpbCpNtJY7CWWELG+P/HS0QOW4q4bZ13i4M2a6ZRU7j/pWokPGxYHkomTcg6pPpLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHv2Xpju; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934676; x=1748470676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8SgLSBlzuHD5n70yWZzbDg8H5nH61fnw3a/Miz1zwNw=;
  b=EHv2XpjudgRJ+H1lU8qXm0UjEJbrSNSNN8BlS3rQMLBwFDvUO2l9Ki4Q
   iW1k1d7jivtbdy6Dsk+Fuu5/rv234o8kmpwJhabCBZh3hBxuB27X7yy0c
   Ln9hKsdW0ZqHIsqU7sWMD9q12UtEtOEgUHoTUGvRp5tqYiuQ8u9hQlE9A
   sF1jD7SjZxGLfaKDDmDYLsX6N9SP5Uw4GzeT5KITBaIooOHzb+pFAsyZc
   IgVhqTWHuZ8Qbc8p+j+AZXB9ry+XkO6PsoMd6dn3vQHFTk5NQHXtSA/HM
   gvSqnzlaJFj/waq3ueEd2+WPJrlPlJBvEX3ll1I7/KS3oQ9YlhoS1hO7K
   Q==;
X-CSE-ConnectionGUID: F++OV4yjTBqPKdQjYpDByg==
X-CSE-MsgGUID: vbMqTTecT92BFks4D3TOPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13081552"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13081552"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:17:55 -0700
X-CSE-ConnectionGUID: Oh6Zvad+QnGSydZ4ExwDTQ==
X-CSE-MsgGUID: Q2Y3EgYCRXKcvoCRK2osrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="35287888"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 15:17:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 15:17:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 15:17:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 15:17:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 15:17:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJLvu/FZbQma3l+PS2KtKvwhJSK1aHcRpioDni5Xf8FEo8de4ZXQKgbm5FUSAkTrUy62KxXns9iNlbI1CSO7kd3/bCikLemRs/+FOnFDNgwOiY8/jw1b2HVaF4YX6jJHsBUcbWd3ITc1UOQTaSVYk75okdPJfpuEC/VSjG7H6r6MQeCOGynOZpDb5C1wz09G9W8TmBfvqLnNcu2wAQCuxcjDeZ+NZYZbxT7ajdZzzWFNri9TZlnF7ztgdi0qQsOpBIM4qQPzrziK2twHdxtoxdJeM1DWrH/D7Ss1WSGeLkDRdELr28ECJx/ZXwujrc3Nklt4svyhFxAwmua2vMN8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SgLSBlzuHD5n70yWZzbDg8H5nH61fnw3a/Miz1zwNw=;
 b=FtEz1+k4Wdpv7ChV/NhrG+zvywnk64kN1hkoeUJIsilwPxqTwXsM48QvC3nthUp9zZXHmKZn/bmJG6884qcmzoWWeNYexY8pujIiusS2QigqtYGEEu4xt+Sd3oLlUoWG5yraneHit5bftkEjxye4QZeywSGxJq74c2hSXfoNf5BOdMaePPfyEgtRaUSXu7Aju8v/6arXofr0UnhM7VjRQplxDqfow+heLotT9cQ7lFyX9rHNeu2sWwy5SNHZaWIds2EDCP1aOpt2ixm0OKjTP1o3idCv+zcx7At+FybeRqv7wf6wakGqrMMgyrvPMjXgYnFBRqKZ2ul+0ZxbXbBT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 22:17:49 +0000
Received: from CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be]) by CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be%6]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 22:17:49 +0000
From: "Singhai, Anjali" <anjali.singhai@intel.com>
To: John Fastabend <john.fastabend@gmail.com>, "Jain, Vipin"
	<Vipin.Jain@amd.com>, "Hadi Salim, Jamal" <jhs@mojatatu.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Network Development <netdev@vger.kernel.org>,
	"Chatterjee, Deb" <deb.chatterjee@intel.com>, "Limaye, Namrata"
	<namrata.limaye@intel.com>, tom Herbert <tom@sipanda.io>, "Marcelo Ricardo
 Leitner" <mleitner@redhat.com>, "Shirshyad, Mahesh"
	<Mahesh.Shirshyad@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Vlad
 Buslov" <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, Khalid Manaa
	<khalidm@nvidia.com>, =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?=
	<toke@redhat.com>, Victor Nogueira <victor@mojatatu.com>, "Tammela, Pedro"
	<pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, Andy Fingerhut
	<andy.fingerhut@gmail.com>, "Sommers, Chris" <chris.sommers@keysight.com>,
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>, "lwn@lwn.net"
	<lwn@lwn.net>
Subject: RE: On the NACKs on P4TC patches
Thread-Topic: On the NACKs on P4TC patches
Thread-Index: AQHaq3tgsz8M4mwK5kOt/duOpn0mGLGj1UeAgAAMQQCAABa4EIAC81gAgAFCvgCABPK/AIAABTIw
Date: Tue, 28 May 2024 22:17:49 +0000
Message-ID: <CO1PR11MB49932999F5467416D4F7197693F12@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
 <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
 <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
 <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
 <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
 <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
 <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
 <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
 <20240522151933.6f422e63@kernel.org>
 <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
 <CO1PR11MB499350FC06A5B87E4C770CCE93F42@CO1PR11MB4993.namprd11.prod.outlook.com>
 <MW4PR12MB71927C9E4B94871B45F845DF97F52@MW4PR12MB7192.namprd12.prod.outlook.com>
 <MW4PR12MB719209644426A0F5AE18D2E897F62@MW4PR12MB7192.namprd12.prod.outlook.com>
 <66563bc85f5d0_2f7f2087@john.notmuch>
In-Reply-To: <66563bc85f5d0_2f7f2087@john.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4993:EE_|IA1PR11MB6099:EE_
x-ms-office365-filtering-correlation-id: aa1c6b66-9b96-4872-afae-08dc7f64025e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TkhRU2ZieE1WY0svT3pNelAxbUhFQXVpMkpkQTUzQ0daemdtUTBGMXFCTHVa?=
 =?utf-8?B?NWhMUTFpTWRQOEVpTlZYRDRiZGxxZWhmUVZEdVlRT0NXTnZtUHZDdERHY2pD?=
 =?utf-8?B?UWtkQ051Ym00eE9sTDBCY2txMzRGRFpPWEVqR2ttUzY4ckFUYmJxUW8rNm5l?=
 =?utf-8?B?dlRMREt0L2Q2L1pXREFIQUUxcVY0SDBTbjVHc0FTLzFwOWttUWc4aTVQK2ky?=
 =?utf-8?B?Z2p5UXdsQ21Id3RtdDcyV2xVNzhHY21NY09xVHNPNzN1d2FHNTRuaE81OEV4?=
 =?utf-8?B?ZGxHWW5rOXk5aVpVU2dObGh5RkdVN2Q1cjJLYXo3QWl1OCtaNUxES25rcU5w?=
 =?utf-8?B?eXB5M3BTUDBxT203K1lwNXlVODF3TFFHK1ZTVHA2bkxndHh1YzlrZ21sMFAy?=
 =?utf-8?B?Q3ZVaGlVNCtXdC9seTVyMjJDTUN2eUxZMU1LQlVmazdmZUwrR1pYZWFzQ3dp?=
 =?utf-8?B?NFhHQWJ4c0ZOekt1L3BNN1llb0IvUjFrQ0QxdmQ3TkZUeS9DZkdJV0o2WFpi?=
 =?utf-8?B?b09FdjRPNHUzaEdQdCtoWkduOFB3ZjV2RlNSeTlsUnhRcDF3d1duYUdZak5C?=
 =?utf-8?B?NzZXb2NKWk15ZHRCU05aNEhwVkVnK09pcE9EUGJRQ3pJNGIweTZicTZpd1Mr?=
 =?utf-8?B?S3A4Y3VTNWVPVEJ6UzZHeThLYlVWL1JZL3Bxb0wyOHErVnYxMmI2U2pyZGt4?=
 =?utf-8?B?byt4VTQ5aHJBOUpyL1l1ellQVG9HVmtEajdqWnRNazRlTnJEVTFsZXc3RnVo?=
 =?utf-8?B?S3RVWkVna1orT25jTzhjOWtPQVREUFVXVUZRTFRERGpRa3lkMzBSeHBvZG1m?=
 =?utf-8?B?RGVzcVdhdGxWbXJFQ2VrY2QyWC8wTy9sUy9URnU1cW9EWHl5d3hZWCs3MDlN?=
 =?utf-8?B?cmUyNTVQWldoUitPL0FOWlpKZXdvWGhnNUFMQnQ5ZXBISkxjVFhBUFFUN2th?=
 =?utf-8?B?NjlkMmd1QXN5YVhaOWRBSUE2SStaR0VVVHlCTk9ka1ZnYmx2emZIUjlKZ1ZH?=
 =?utf-8?B?LytYKzhBdmtLZnFzeit1cDV2ZTlxQU4yR25IRjJPeFY3OHp2NXFoVk9wQmpX?=
 =?utf-8?B?ZFQrZVpKcFdiNlZYaUdhMUlIZUtiL0xGbHNsSmtmZDZKSjVYV1lIZ1dxT3F4?=
 =?utf-8?B?OXNXcWFuNE1KV1VlMHk3ZkJDSnlUOWNoMTZZc1NLdU9tNnJ6ckl1VHhvaFpV?=
 =?utf-8?B?cmpiNUxmdVNEaFBDU3A1em1pQmJFcGtWOFZ2ajUxYXBOb2tRWnFtRmF3N1Zi?=
 =?utf-8?B?U3BVdnZLd2NacGdXMThuUkNmZW5KMWdmTEtDOXVWakpEek5qaU5lZGZyVEpV?=
 =?utf-8?B?NVpHbStydkhqU0VGWjk2V1h4TXR4elNFSHBHYTZ2dC9FTExTazdKeFJsaHF1?=
 =?utf-8?B?RGNlWVU2T0FIRU96QjJpQzVNSnEwQnh0OFBNaWpZQzlLUDRUcHZwMC8zYThP?=
 =?utf-8?B?ekJmVy9LV1dheDMyYkhHVDlyYlkvOGUxVzd6S2pSaFNvbWZKeTYxazhOalVv?=
 =?utf-8?B?NUJKekhmaThkc2s5QVQzUys4YXRSNHg4akVtSzhCMTJnMzNJWkljbThSQ2p0?=
 =?utf-8?B?QnFKdE5ZMmRocWNWd2gxNGNpRlJuVDBrejJDQUxORFZ6WmJYbVhUaDFiZEps?=
 =?utf-8?B?TzI4K01vMXRoUDBINldGdWhzZndoeDVrakhGZG1TT3pISW91NW1mR1dIb2RE?=
 =?utf-8?B?aC9rUDcybGU4ZzY3QjNvRzg3UE5jbDQ0UEVQNXhQK1h6YmZuZEd2VVRVOThv?=
 =?utf-8?B?c2NIcmltZ1BsK3pXVHZiSExoWVVYKy9NbmZ0WUNJb2RMWUIwZnFlaHdDTzRP?=
 =?utf-8?B?emZNcXY4UC82end3MEVTZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4993.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnFWUTcyS2tVOEQ1OG5keEJ2ZnZJK21LQkl1R0p2UXcvQmxHS3V4K0RFRmI5?=
 =?utf-8?B?SlRJYmw1dFhWejRaaDFuZXVYc3EyNE94Z294VVFZVXlZbG5uY0VzWkJGai9W?=
 =?utf-8?B?a29wYkk0Z0lsdDFkck5ISnFOaDQxM0E4U1BuMG5PclBGOExic3dyZnVSUlV3?=
 =?utf-8?B?ZWxlZlY2L29RcnZ5bEhIaGxKQzJoT1ZEdUI2MzQ1bE82WE5rVXp2eHZaeWEy?=
 =?utf-8?B?eXdrMWpaQWtHVG9xTXZmL09LZlpabmRXT3VuVmNyL21QTnZ3WG9BWEwzUGx1?=
 =?utf-8?B?WkdNalJpVDJabFdJcFVTaW5uSXpnTHpFcmpubElBdlpHUEQzUjcxOEc3T1VS?=
 =?utf-8?B?MTUvdkl2dXZCRTRoZUF0S0FCT1VtRDU5WTRTYy9sbzJPSCsrVmJqandrcFNO?=
 =?utf-8?B?cWxLcDViMWlQbUdCZ2c0bjFuTjYrdXlNQnhMMXhWdGk3VFJadHpOSXp1R250?=
 =?utf-8?B?dld3RlNTcGZUYVdqY0lROWpSaWdkeGI1NlZQaGtiMjMyZHhTb1RMUXl1LzhT?=
 =?utf-8?B?MDNKUjd2QU5jaE1IbUFRYk14YTNPM3BsUjk3OGRyYzR1ZUNnbDNaY0ZoeDlv?=
 =?utf-8?B?cnhqR0xlZG9RbDFGYnBNZ0dyT0dINDYrNTZlOVV5dXN1M0J2MEFOWURSQ1Bp?=
 =?utf-8?B?S0tKdGZTSkJaTURUbUd4b045dU9vOFZseXZTQlVvUFo5NHNhTFRmMkJadm96?=
 =?utf-8?B?WUdUNUZuYmRQQW4zbFZVMjZ6WFN3anJrSFNRZ2luaHRsZXhlU2h3NXI2ZDEr?=
 =?utf-8?B?QnNDd01DNnNMTFA2OUF0SG5YNTV5SWdpZnFSTTBMVnJVcGFzMEIrL0RIWlNP?=
 =?utf-8?B?TXZodVd2WGlubkJIWCtRZG1uY1VjY0Vsbk5uVUVWS0xhcmlCT0g0SFdvK0Y5?=
 =?utf-8?B?aEM2NEc3ck5KanhEK1BLTkxVRzZlQzU0YkR0N2FVQUNYZzVnekhKVmdmS0ZO?=
 =?utf-8?B?WitaUkVOSDhINVBLRXdDcmx4Yk93aDA2SnB1Q2hqamJzL094MEVjQzdsdnND?=
 =?utf-8?B?eGlBbngyWU9EMlBVZnc3akxyK3ZqWUtmUVB1OVBzWFgrMGFHZjdCNHZCUmtu?=
 =?utf-8?B?UEk3K3QvSjgzb0dZc2d0RG4ySHEyd1BOS2wvNDhQWTMvOE1sWmVpSTZXWjM4?=
 =?utf-8?B?VEJ1RzFiTUQ5MzJIV0xPdFhMSEtxRnZ6QlZ5VDgrM2V2Z0puWU1vSzdoaTN1?=
 =?utf-8?B?cFRsc3VmZzAwYmVYbk1FdDJGVitkT2VDSXhyT1FGNGVDOHFRZDJXRkFvODc4?=
 =?utf-8?B?bkZPYTNmRjVvdEtqOXJGam1IV1hQVkpidXZKWHh0U3pHRzRJZVVLNlFTa2xU?=
 =?utf-8?B?b0JMOXlJdTFJclgzSklPZERaampuVWRhQzZ4WVJTa1BwdFpiTFJCYnFBNHdn?=
 =?utf-8?B?OXFWSkZhcXZEcDVqbDI4ODZkemUxMVloWVptdkxEUngrZXBxWHF6b3VJREZV?=
 =?utf-8?B?YWNKeSs1YlFnTjFwL2tNdXVaUHlud2ZHbHVsSXpIT01naU9CTU9RUzBRSXpJ?=
 =?utf-8?B?VFA1Mk9wTEVwcHA1ZS9PMnI0SUZnSGRLSWExNEZ0VDRuVktNdGhGNFlaTVJ1?=
 =?utf-8?B?OGhLL3FOSlFrWTF3ZkM3MXBHYlhmSHV0cmErSC93N2hGdG9DSmZDNkJXSVNP?=
 =?utf-8?B?SjFaU1FwU3BxTDVmTGlRTmlWMSt2S1JodFI0UW1LM1ZaV3VDTFNvVnBQYXNU?=
 =?utf-8?B?bU16Ync2NitMU204WURRM2F5MThPZDdxREVoZEgwcjJyNk8xbDFyRXNlWkNm?=
 =?utf-8?B?ZGppSUVYVmlmSEhQaU1HSE9TK21mK1BNc25HZlhLa0RDdXI5eDcyblpZeWdG?=
 =?utf-8?B?aUVaSFNVcks0WTQrb3BnRmZMS0NrWnEzYWlrcC9NeEs4cFZGMERHakZaWmQ3?=
 =?utf-8?B?a3RRTm5OUmdxOW81elF0QWJDZ1Q2bERXSUdZb0V5ZDgwTDM3UXd0VHJTekZ5?=
 =?utf-8?B?anlTQlc1dWxVNUFBdnEzZ3ZZR1hMWCtPQ3F1aiszYWtBLzJnUHlpR01OWmZJ?=
 =?utf-8?B?NDlRbGE0TU9XamwrcVlaVkNmSlhiMGI1QkVIc2VqN24zYVI0d1doQzA0U3hS?=
 =?utf-8?B?SEk0UHB0Y3RYd0V4dVRvekNMejFmZHpBdEZUdTgwVHBiUiswQXlkeS9SelZZ?=
 =?utf-8?Q?SpWAA+JkdH33W/hkdN4wHD7xI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1c6b66-9b96-4872-afae-08dc7f64025e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 22:17:49.2626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VUmbLhwBh+8KNgC4hiUdkb+ZsNSp1A0w0cQ57c0RGgnozyhvxyqOmb/jrajFsFhnFxQ5weVqycSch157DMTHZxDZZ+qci/cSAWuOEzNLYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-OriginatorOrg: intel.com

PkZyb206IEpvaG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+IA0KPlNlbnQ6
IFR1ZXNkYXksIE1heSAyOCwgMjAyNCAxOjE3IFBNDQoNCj5KYWluLCBWaXBpbiB3cm90ZToNCj4+
IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHld
DQo+PiANCj4+IE15IGFwb2xvZ2llcywgZWFybGllciBlbWFpbCB1c2VkIGh0bWwgYW5kIHdhcyBi
bG9ja2VkIGJ5IHRoZSBsaXN0Li4uDQo+PiBNeSByZXNwb25zZSBhdCB0aGUgYm90dG9tIGFzICJW
Sj4iDQo+Pg0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQo+
QW5qYWxpIGFuZCBWaXBpbiBpcyB5b3VyIHN1cHBvcnQgZm9yIEhXIHN1cHBvcnQgb2YgUDQgb3Ig
YSBMaW51eCBTVyBpbXBsZW1lbnRhdGlvbiBvZiBQNC4gSWYgaXRzIGZvciBIVyBzdXBwb3J0IHdo
YXQgZHJpdmVycyB3b3VsZCB3ZSB3YW50IHRvIHN1cHBvcnQ/IENhbiB5b3UgZGVzY3JpYmUgaG93
IHRvIHByb2dyYW0gPnRoZXNlIGRldmljZXM/DQoNCj5BdCB0aGUgbW9tZW50IHRoZXJlIGhhc24n
dCBiZWVuIGFueSBtb3ZlbWVudCBvbiBMaW51eCBoYXJkd2FyZSBQNCBzdXBwb3J0IHNpZGUgYXMg
ZmFyIGFzIEkgY2FuIHRlbGwuIFllcyB0aGVyZSBhcmUgc29tZSBTREtzIGFuZCBidWlsZCBraXRz
IGZsb2F0aW5nIGFyb3VuZCBmb3IgRlBHQXMuIEZvciBleGFtcGxlID5tYXliZSBzdGFydCB3aXRo
IHdoYXQgZHJpdmVycyBpbiBrZXJuZWwgdHJlZSBydW4gdGhlIERQVXMgdGhhdCBoYXZlIHRoaXMg
c3VwcG9ydD8gSSB0aGluayB0aGlzIHdvdWxkIGJlIGEgcHJvZHVjdGl2ZSBkaXJlY3Rpb24gdG8g
Z28gaWYgd2UgaW4gZmFjdCBoYXZlIGhhcmR3YXJlIHN1cHBvcnQgaW4gdGhlIHdvcmtzLg0KDQo+
SWYgeW91IHdhbnQgYSBTVyBpbXBsZW1lbnRhdGlvbiBpbiBMaW51eCBteSBvcGluaW9uIGlzIHN0
aWxsIHB1c2hpbmcgYSBEU0wgaW50byB0aGUga2VybmVsIGRhdGFwYXRoIHZpYSBxZGlzYy90YyBp
cyB0aGUgd3JvbmcgZGlyZWN0aW9uLiBNYXBwaW5nIFA0IG9udG8gaGFyZHdhcmUgYmxvY2tzIGlz
IGZ1bmRhbWVudGFsbHkgPmRpZmZlcmVudCBhcmNoaXRlY3R1cmUgZnJvbSBtYXBwaW5nDQo+UDQg
b250byBnZW5lcmFsIHB1cnBvc2UgQ1BVIGFuZCByZWdpc3RlcnMuIE15IG9waW5pb24gLS0gdG8g
aGFuZGxlIHRoaXMgeW91IG5lZWQgYSBwZXIgYXJjaGl0ZWN0dXJlIGJhY2tlbmQvSklUIHRvIGNv
bXBpbGUgdGhlIFA0IHRvIG5hdGl2ZSBpbnN0cnVjdGlvbnMuDQo+VGhpcyB3aWxsIGdpdmUgeW91
IHRoZSBtb3N0IGZsZXhpYmlsaXR5IHRvIGRlZmluZSBuZXcgY29uc3RydWN0cywgYmVzdCBwZXJm
b3JtYW5jZSwgYW5kIGxvd2VzdCBvdmVyaGVhZCBydW50aW1lLiBXZSBoYXZlIGEgUDQgQlBGIGJh
Y2tlbmQgYWxyZWFkeSBhbmQgSklUcyBmb3IgbW9zdCBhcmNoaXRlY3R1cmVzIEkgZG9uJ3QgPnNl
ZSB0aGUgbmVlZCBmb3IgUDRUQyBpbiB0aGlzIGNvbnRleHQuDQoNCj5JZiB0aGUgZW5kIGdvYWwg
aXMgYSBoYXJkd2FyZSBvZmZsb2FkIGNvbnRyb2wgcGxhbmUgSSdtIHNrZXB0aWNhbCB3ZSBldmVu
IG5lZWQgc29tZXRoaW5nIHNwZWNpZmljIGp1c3QgZm9yIFNXIGRhdGFwYXRoLiBJIHdvdWxkIHBy
b3Bvc2UgYSBkZXZsaW5rIG9yIG5ldyBpbmZyYSB0byBwcm9ncmFtIHRoZSBkZXZpY2UgZGlyZWN0
bHkgPnZzIG92ZXJoZWFkIGFuZCBjb21wbGV4aXR5IG9mIGFic3RyYWN0aW5nIHRocm91Z2ggJ3Rj
Jy4gSWYgeW91IHdhbnQgdG8gZW11bGF0ZSB5b3VyIGRldmljZSB1c2UgQlBGIG9yIHVzZXIgc3Bh
Y2UgZGF0YXBhdGguDQoNCj4uSm9obg0KDQoNCkpvaG4sICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KTGV0
IG1lIHN0YXJ0IGJ5IHNheWluZyBwcm9kdWN0aW9uIGhhcmR3YXJlIGV4aXN0cyBpIHRoaW5rIEph
bWFsIHBvc3RlZCBzb21lIGxpbmtzIGJ1dCBpIGNhbiBwb2ludCB5b3UgdG8gb3VyIGhhcmR3YXJl
Lg0KVGhlIGhhcmR3YXJlIGRldmljZXMgdW5kZXIgZGlzY3Vzc2lvbiBhcmUgY2FwYWJsZSBvZiBi
ZWluZyBhYnN0cmFjdGVkIHVzaW5nIHRoZSBQNCBtYXRjaC1hY3Rpb24gcGFyYWRpZ20gc28gdGhh
dCdzIHdoeSB3ZSBjaG9zZSBUQy4NClRoZXNlIGRldmljZXMgYXJlIHByb2dyYW1tZWQgdXNpbmcg
dGhlIFRDL25ldGxpbmsgaW50ZXJmYWNlIGkuZSB0aGUgc3RhbmRhcmQgVEMgY29udHJvbC1kcml2
ZXIgb3BzIGFwcGx5LiBXaGlsZSBpdCBpcyBjbGVhciB0byB1cyB0aGF0IHRoZSBQNFRDIGFic3Ry
YWN0aW9uIHN1ZmZpY2VzLCB3ZSBhcmUgY3VycmVudGx5IGRpc2N1c3NpbmcgZGV0YWlscyB0aGF0
IHdpbGwgY2F0ZXIgZm9yIGFsbCB2ZW5kb3JzIGluIG91ciBiaXdlZWtseSBtZWV0aW5ncy4NCk9u
ZSBiaWcgcmVxdWlyZW1lbnQgaXMgd2Ugd2FudCB0byBhdm9pZCB0aGUgZmxvd2VyIHRyYXAgLSB3
ZSBkb250IHdhbnQgdG8gYmUgY2hhbmdpbmcga2VybmVsL3VzZXIvZHJpdmVyIGNvZGUgZXZlcnkg
dGltZSB3ZSBhZGQgbmV3IGRhdGFwYXRocy4NCldlIGZlZWwgUDRUQyBhcHByb2FjaCBpcyB0aGUg
cGF0aCB0byBhZGQgTGludXgga2VybmVsIHN1cHBvcnQuICAgICAgICAgICAgICAgICAgIA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgDQpUaGUgcy93IHBhdGggaXMgbmVlZGVkIGFzIHdlbGwgZm9y
IHNldmVyYWwgcmVhc29ucy4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCldlIG5lZWQg
dGhlIHNhbWUgUDQgcHJvZ3JhbSB0byBydW4gZWl0aGVyIGluIHNvZnR3YXJlIG9yIGhhcmR3YXJl
IG9yIGluIGJvdGggdXNpbmcgc2tpcF9zdy9za2lwX2h3LiBJdCBjb3VsZCBiZSBlaXRoZXIgaW4g
c3BsaXQgbW9kZSBvciBhcyBhbiBleGNlcHRpb24gcGF0aCBhcyBpdCBpcyBkb25lIHRvZGF5IGlu
IGZsb3dlciBvciB1MzIuIEFsc28gaXQgaXMgY29tbW9uIG5vdyBpbiB0aGUgUDQgY29tbXVuaXR5
IHRoYXQgcGVvcGxlIGRlZmluZSB0aGVpciBkYXRhcGF0aCB1c2luZyB0aGVpciBwcm9ncmFtIGFu
ZCB3aWxsIHdyaXRlIGEgY29udHJvbCBhcHBsaWNhdGlvbiB0aGF0IHdvcmtzIGZvciBib3RoIGhh
cmR3YXJlIGFuZCBzb2Z0d2FyZSBkYXRhcGF0aHMuIFRoZXkgY291bGQgYmUgdXNpbmcgdGhlIHNv
ZnR3YXJlIGRhdGFwYXRoIGZvciB0ZXN0aW5nIGFzIHlvdSBzYWlkIGJ1dCBhbHNvIGZvciB0aGUg
c3BsaXQvZXhjZXB0aW9uIHBhdGguIENocmlzIGNhbiBwcm9iYWJseSBhZGQgbW9yZSBjb21tZW50
cyBvbiB0aGUgc29mdHdhcmUgZGF0YXBhdGguDQoNCg0KQW5qYWxpDQoNCg==

