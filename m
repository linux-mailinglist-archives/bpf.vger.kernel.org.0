Return-Path: <bpf+bounces-66247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D97B30201
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 20:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DBFAE078C
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0104A343219;
	Thu, 21 Aug 2025 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQ1PrFoE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69025B30E;
	Thu, 21 Aug 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800782; cv=fail; b=d5gGILSQQ9hbTVGSLYe8m6OdN1sBUomX3ixv75CaWZVubciY1WqJxKsokPAF1QKT/0bfg6LQvgyxt0chBrGC9qWTIb6XejCu1WqXeiXwlDFI6XXkNhilDtIimsMSsOznlb0yBOuMaLDe6YUVLsvQCST7JI5y2ucoXnzPhLPQZ28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800782; c=relaxed/simple;
	bh=xlh14FycfZSKZ7WSwy736g3ULyWTLT5GsOUmKno8sgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=reZfjtb8vhpfyPfBW6a4YPo1WLZJ6KdWZuOhEEvWl95AGf9E9nZ6mugI4DvWhOog/XA3fNgCi0qkehFyggXlG5yZN2WJ1S8T4O+MgIjtRilAfhsUB5z6IfID7X+uZYRmkYIj+8Qb5DJYKKcNQQYK7fgOB3+EqEu/rvJt0QN/bE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQ1PrFoE; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755800781; x=1787336781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xlh14FycfZSKZ7WSwy736g3ULyWTLT5GsOUmKno8sgc=;
  b=eQ1PrFoETm+cdEwWy20CgikZby10Vqjb8DCgjyoanHr4QjyVE7LKSKej
   oGnDkLePW4iIzLjfxCi3ewzXJVp6vnXP7wPa8dquTT+TwltIvovibr22v
   wVSEZWAMPI7oleSfTR9QAPPXYNhKoCLGVaaJN7LnstIBSoKjhawLSkzQ1
   XD8K9RBA7TaUXQI+DvP75rQZ4nX9ewrChWzZt7Lfv4kwaL3rMQklXlKe8
   YAKens+tAZJtd4NFnJn2uv2b56WTLPdGyo0sUsF5+fBcT0D+eDMtDGLv/
   lyvUxbGvXrltRe33XaClirToJ0rl25oOMxJKyyYkoDVfwhHPq7eiBjKYe
   Q==;
X-CSE-ConnectionGUID: m5+kEVaOTZ+dS38vpxpu9w==
X-CSE-MsgGUID: +JNcs0i9RzmceqqMNTGU2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58051235"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58051235"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 11:26:17 -0700
X-CSE-ConnectionGUID: hIMXiGjsRGOgnyLkKqI/Zw==
X-CSE-MsgGUID: 7KzcClYHTbCYCcPPpXAJDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199361211"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 11:26:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 11:26:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 11:26:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.43)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 11:26:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzEMm/0BGI42B3uKh9bhxNi4dclJKmv0VCx0Qhb3oUu2ceqB0+/Ih5BzFoDIqCteSSmgdyNn1syQ0DdJczZ+T6auS9hgtRr76iD7e2NZ+l0u3RWwgMqAq4LgaW+cjVz+LblJ/OyiRkNjMEXutRPo2skZLEJ5fCRZ4Fx2w7uVmifhhKp3SidMj44i4ZTlutQsNsaNSsmt9lV1q3kGzHe75Hri1Rl2kQ7+q2FDl/PbCIFlq8fewQ09tVDhlXtq//z094u8YfhE4zJAFbVRCvApOXPk1wmoW5+X8AoSN1LP+1PUyEwyU98w5ilH+DjvpoMpMLp+hRUZmE9ULEeDTgV1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlh14FycfZSKZ7WSwy736g3ULyWTLT5GsOUmKno8sgc=;
 b=Skzb7WzB48K+ivd5YivOmAQHH2tTLHoVDJmjUKATOq0QYINbXr+ck/i/3cqylJJAyOP09dTo3JGci3BJPbGLbzqQcy+J3lCKtIKKuJtFWfQUgyUe/nkIUDLYp+DHXKiDU83ghaOP9SmZ2nwLQxBgkwZwqrzMoeS62PdQ4BmKRVGA95uhwquPs+g1Fg785r/eALgkhTL/M4Nd1CS1XBAIY4+i7xm1a/x5zQ6yvmoSWNjx1I0Rd5mvi2aTBeykPcqfwBTOF1HlUzUr0EB6feRrFIqQczfvieo8/rPA6QQJxCqz+TJJDoT/K226YA7plJa4glQ0rvjkOOLYOOvEqonlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 18:26:13 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 18:26:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "jolsa@kernel.org" <jolsa@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "alx@kernel.org"
	<alx@kernel.org>, "alan.maguire@oracle.com" <alan.maguire@oracle.com>,
	"David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@kernel.org" <mingo@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "yhs@fb.com" <yhs@fb.com>, "eyal.birger@gmail.com"
	<eyal.birger@gmail.com>, "kees@kernel.org" <kees@kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "thomas@t-8ch.de"
	<thomas@t-8ch.de>, "haoluo@google.com" <haoluo@google.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH 4/6] uprobes/x86: Fix uprobe syscall vs shadow stack
Thread-Topic: [PATCH 4/6] uprobes/x86: Fix uprobe syscall vs shadow stack
Thread-Index: AQHcEpklla5yewRC7kOy0AgJQ8GaBbRtbPIA
Date: Thu, 21 Aug 2025 18:26:13 +0000
Message-ID: <09238f699d47d92ef93a7621e28e7b1c0c2b7114.camel@intel.com>
References: <20250821122822.671515652@infradead.org>
	 <20250821123657.055790090@infradead.org>
In-Reply-To: <20250821123657.055790090@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB7807:EE_
x-ms-office365-filtering-correlation-id: bbcd6f54-d3ec-4123-8cc5-08dde0e035b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q1IvU2txc1ZST2F4WkdaN0UzQ205VnpTb2w1WFNCNVhHaXBZelNGK3N2TXJr?=
 =?utf-8?B?VlZleFovNW1qVmJEekFnSERTZGRETTlma0JPR1EvWEdUNlpmOVQzM05Ec2t1?=
 =?utf-8?B?bm12eW4va2hrRG1EUmhHQXhTVXpaVk5reXlWSlVpYkF3QmlFZ3pqS3NheXVi?=
 =?utf-8?B?L253Sm44aXpQUXdjWElDaHNIQ3lxVjM4R2FoLzdueHZjd0tmMFI1NjRFdUlw?=
 =?utf-8?B?NXhTQkZ1RDNDT0RKaVJkNU4reW5GYmtodDFZZkZNbFJjM2tHZUlBOVozOU9L?=
 =?utf-8?B?aHBSVkJqWG1PYmVjMGRpVXg0ZkZvRlB3WmtrQUtDMW94TVl3M2FtNkhPNGti?=
 =?utf-8?B?QzByYWxVMjMrN2ZHeXNTR1pxVXNlUkk1ZDkvRXdnUkc5c3hrVWlqZHBxcmlT?=
 =?utf-8?B?ay9veWNwbmVmSlphbXdCUjQ3MkxIRkJyUFBuYjlsay9zR1Rra0FsTnEvUVE0?=
 =?utf-8?B?WXlpNjRBc21OM1cxbU1IM2piRXVwUkpHVGVnZzBRUVQ0WU9rdWJDQXp2SmlO?=
 =?utf-8?B?d25jNTZ0TFIyY0FaOVEzYW9qekYweGVzUmRGUU9xTWwzSzZLdklnUEIxM0ZK?=
 =?utf-8?B?cGlaTWdmTWpXWkQ4RGkyRTMzYXJwVFFLUktwQ1IrSEI2M2F4WGpwb1FMZll4?=
 =?utf-8?B?b2s0bmFUN3RJazVUckRRNStldnlWZUxRc0kxcFhkSzJFSFgyS09lSWVjNC9H?=
 =?utf-8?B?YTBGK0NMc3cyM2gvRUx3SE5xYThteHc2d0kvcVZ1cWdwY3pReGFoYjVZbElQ?=
 =?utf-8?B?Z0tTbkhsQ1F4eDhVSEZmdDNzNFh5MVpMZHBGVE11WFdsUXZ5dERvZ3dFdExu?=
 =?utf-8?B?Y0hwcW5aams3U3VXdjdZNXdrK0pTbHprODcvbE4zVFQrZlZxSzdBZnRXN3B4?=
 =?utf-8?B?a3FGR3ZSZ2N4aG1UaXArRjZ1NW5OU0lvaUR4OE1zZnZpMUFZMkdLQ0JoWElH?=
 =?utf-8?B?UGpZdTNCVGdUdEMwc2FvTDFXamtHaU9tVU1BSHl5Rjh6cndUcHN1M2djY3JZ?=
 =?utf-8?B?SGM3TU1oQm9rc1hMRXBMaUlYU1VPYkNJb0hDOUNHMWJXYVA4b0JzcjdhUUpT?=
 =?utf-8?B?TU9PcmJsWEMycTJNL0N4aDZKbTAycytzNk9WNW5TYVpXblJ6Ym1wYzdOSXFk?=
 =?utf-8?B?UG5QZTNxQXVQVi8wT2pjTzhzNUZrNExudjdIdHNtdkw3SXJBU0xuazhPQlNO?=
 =?utf-8?B?eWljZS9XVFk3Tm9IQk51SE5SVnoxSXZNc3BIc3pPd2dRcFRYdWRKSWRKOE1i?=
 =?utf-8?B?QzdGL0h6RGxKYjMvK01LTVkza3hWOXl6eU1NdjFVdzl3Ukh3MU5DWlFxOWNY?=
 =?utf-8?B?aHZwWm5OK3RlUWhBdEhiMGQ1Zmg3bm84TGl2K0d1K09tRGFDR0hnWTUweG1u?=
 =?utf-8?B?ZkF2d1dRMzh1ZEp5NXVSMExwMnpzajQ5cDQzUkNNWGhRSnh3WFBYTWVTTW1K?=
 =?utf-8?B?NlMzblRhSDg4TjNycjV0ZGtDbC9rNkdRYSt3dHg4U0kzRjJxV0I4ckZkYVBH?=
 =?utf-8?B?elEzWHJoalBuYTRRODZNdllGeGczWnlEWmk0WWtkNmdQRVFEUjI3VnlIcmQ2?=
 =?utf-8?B?cXA1Yjk3M0hIOStKREwzbGFaNVRyZk1KVlMxK1htZWlYbWRkelZUa1pBdVdx?=
 =?utf-8?B?NjhnS2JWdHB0ZXg3cGZid2FWd1djaHRqTDhXR0RBd3JzSWljMGZhQStTZzJ0?=
 =?utf-8?B?QitXTUtWdW4wU08rR1hHMUovOWtEQ0VEam9TT09HRXlyczlVSncyS0ZIeEc5?=
 =?utf-8?B?dFY1ajl0eXFsTmI4Ym5kYlRseUdoVTBRenVhZXRYekxDU2pIVEduaXRtN2xF?=
 =?utf-8?B?QlhIOG9MWHhOdzkwZlFjU0xJS214UjE2VmhwT0t6OS85TkE0U3BGbWFqc3Jk?=
 =?utf-8?B?RHRoUHhmN01pRzF5UWZzNWpTaUpYSWlYd3BpcFdjQVBpSVFlemxHbVBsT1Jx?=
 =?utf-8?B?bUZYODZoYUpvNTFsandQYWc0Wlhoc0tGa01kdWY4RmpwR0xPK3RkUS9obHJj?=
 =?utf-8?B?NThWaTVuTmxRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODBoZUxBNjhkVDZjUEZEV3lUTDRyYkhpaGVxL0t2VEJEQzBVZkdRUXpkMDlj?=
 =?utf-8?B?U29RdXp0cm0wSDNYWlpDMUFVc3lXMkVIMFREdDBUWlVtVjMzTW9ZVFlWNGhO?=
 =?utf-8?B?WjRMd3d3c1RkUFlwS3NGdklZckRwUkpCa0YxRWtMOWk4bDBmbXROTjBvZDIx?=
 =?utf-8?B?MUM0ZTJ0bGQ5TW82ZW00MGJ2Rk1taEVuTnN2TU9NcVJxVW5rVUErYUM3aTZF?=
 =?utf-8?B?M1lrYUlnTlFjT24wTmIwQTlkcUd1bDZDelU0MWlZZURXajFzem9PM0JMK2xn?=
 =?utf-8?B?YkJCUTJOSmdOMWRVYVZXaktraUNKOUQzajY1RGJtYnNsVFdYT2JCa0x3d2V5?=
 =?utf-8?B?OWNhZHBBbWJqK2xiY21Vbnd4bHVZQ0J2VjZ0TEZnM0J6dVh6bFM1QmFzZFNY?=
 =?utf-8?B?YWpVaklaVUJ4TXV3cG1WVTRBVlBQOWpWMW90UGJ5UDErcjRGdEJhM3ppZ2NV?=
 =?utf-8?B?Z1J3R0hrajdzdjF4SGJzZ1I0OU5kaGdZalVScGVUK25MYXNTSWRjM2JGVU1Q?=
 =?utf-8?B?V2c4SXlVMFZOZFlETDNDejJ2LzRuc0M2RlkrbkEvQUlmYVlGbVhvNVJuaU5j?=
 =?utf-8?B?bzZrTk5Jc1RFMHdFeUZmS01NejF0Z3dSUUNHOWhCYXcySEprRXhKZEVudEI1?=
 =?utf-8?B?dWNHSEt6NzNQL2lkOE5KdTF6STFaRFp0NHl3S3BIYitJUFNRUUVtVlJMclpW?=
 =?utf-8?B?YmY3Z2cyWGFpOHArOWpld3ZDaTgyWDFSNUY3WWhBVFJDSTFUMjJ3YlVQOWFl?=
 =?utf-8?B?UjJWTlZpREFsVmczOFMvSlB0bzlheEg1UXZncnNqVy9kT1FCbitLUHV4TXZH?=
 =?utf-8?B?WU14ZTkxMVZuL1U2aDEyMjlaTE9uV0ppbFAvVnNTazFZWUFWUklSc1FVVkFQ?=
 =?utf-8?B?MXc3WTc0NjFuelFTTDl3ckc5Z2ExTVlITXVWVURPUTdzd3NtV05EQ2tvT04r?=
 =?utf-8?B?WmVieEg5Nnk4ajFBVXNkYmxWcExHRE5hemFYemhNTlZrQkJTeVowVnFnM080?=
 =?utf-8?B?WlVsREJ2UE1Xb05Ha2VybXM3MC95Zy9KYkR0bUE1aEVFQi9SRkdaY3VOODRB?=
 =?utf-8?B?K3JndS9Tanc1cUhPalRWT09YVnNsS2xNTTVzdVIxbDhueHZLK2xwcGNxcjZL?=
 =?utf-8?B?aTE2WTZhVmhsS1hqbGFzSGp4WVF5a1AwRTR2VDlZUlJHMHhPaitIY3EyOXZG?=
 =?utf-8?B?Y3JqTmdhdDVjSkdzWmdZaW9mWjkzRElKQW8rRno4NTN4TVd6RHMxblN0eUdC?=
 =?utf-8?B?VTZpNytIRjZLaG96OTBFRlVYVERuNkZocmN3Qy9HSGMwSmVtVzVPOEN5YnFw?=
 =?utf-8?B?d0VRWTNzSkFoa255WVhNVDBZRXc5RFkrYnJkNUZVT01laFc5L3FMUFhqK2tC?=
 =?utf-8?B?TEs0Q3gxTUs5Y1B1Z3pNSzJ3S25VZloyTzBCOUduSkk2OHRYWDluei9xK3lv?=
 =?utf-8?B?SXhUdFFUTFJQdE9DVHpOZlFHdU1jakdkS0FMa2I0OHE4bnZ0RDErcktPaEs0?=
 =?utf-8?B?UTBsNVZtQXV3RFJnTjBNajJZNmdlUUpwRGdLRUFrUFZScWgxeG5GNXBobHgv?=
 =?utf-8?B?MGNqbXdaTkF5NHBlTmNXYkxLZmE0WUs4VDllVTI4ZUF4dXRqclg3TjhNbmVm?=
 =?utf-8?B?LzJKcndmallHd2JKMlBwckxTamZLTnJpNmRUUHVYYVF4MWp2cGtudlptZmFF?=
 =?utf-8?B?aVJKWXgxOWFDLzVnSmZjWHA2SFhQajhZZmtSV2VKQ2hCYzFSWWxnaGFKaUt5?=
 =?utf-8?B?S1c1ZjhtM1ZvZWJqVmhYWXFSRGM3dnpDemplSzBvVXpEcTNCT2tSZWxqOFFH?=
 =?utf-8?B?aThDSGYzVU9zN3FmYnIrZXFXOVZQMlB0eTlJUk12VkZhUEVrRVBlWklldXFn?=
 =?utf-8?B?N01FMVZqZzVyYW42U24rak5FT3RPL2RTVno0czBWUGVvMjI0TWlnWm1xaVla?=
 =?utf-8?B?anluTUxGSnBWYUlhZi8yL3dNWEVOQ3B6T3Rrek1sR1FsMXNBUEg0b3c2WmNQ?=
 =?utf-8?B?YTh3bHVpZnQ3cmpLQ3VReENOWDlIZHpuZCtSSDdla3dwdjdmeTdxZUNMYmRH?=
 =?utf-8?B?TU1pbDVJdkJyc1A1cU8xd3h5QVdaSGpPdzVXZEd4MFJZM052a0FndzRORGt2?=
 =?utf-8?B?bGJqTkhvcGRRMmdvOGNoeml3NWUzOVMxYjc5QUZlcnNpcmNsTlNYNkF1OFdh?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C823CE41B46C6C40B37797A7EA2C9339@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcd6f54-d3ec-4123-8cc5-08dde0e035b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 18:26:13.4943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lfiLpk1UWcKHOjkT7MyrANkrWzbBGhSdLUlgKezYxLq75zQoD5DJZDCzbO9ffXbJGGnCJE7yvDKwuxN2dH1hef0AhV/dOIxRRpZ2bsVspQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA4LTIxIGF0IDE0OjI4ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gVGhlIHVwcm9iZSBzeXNjYWxsIHN0b3JlcyBhbmQgc3RyaXBzIHRoZSB0cmFtcG9saW5lIHN0
YWNrIGZyYW1lIGZyb20NCj4gdGhlIHVzZXIgY29udGV4dCwgdG8gbWFrZSBpdCBhcHBlYXIgc2lt
aWxhciB0byBhbiBleGNlcHRpb24gYXQgdGhlDQo+IG9yaWdpbmFsIGluc3RydWN0aW9uLiBJdCB0
aGVuIHJlc3RvcmVzIHRoZSB0cmFtcG9saW5lIHN0YWNrIHdoZW4gaXQNCj4gY2FuIGV4aXQgdXNp
bmcgc3lzZXhpdC4NCj4gDQo+IE1ha2Ugc3VyZSB0byBtYXRjaCB0aGUgcmVndWxhciBzdGFjayBt
YW5pcHVsYXRpb24gd2l0aCBzaGFkb3cgc3RhY2sNCj4gb3BlcmF0aW9ucyBzdWNoIHRoYXQgcmVn
dWxhciBhbmQgc2hhZG93IHN0YWNrIGRvbid0IGdldCBvdXQgb2Ygc3luYw0KPiBhbmQgY2F1c2Vz
IHRyb3VibGUuDQo+IA0KPiBUaGlzIGVuYWJsZXMgdXNpbmcgdGhlIG9wdGltaXphdGlvbiB3aGVu
IHNoYWRvdyBzdGFjayBpcyBpbiB1c2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBaaWps
c3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9zaHN0ay5oIHwgICAgNCArKysrDQo+ICBhcmNoL3g4Ni9rZXJuZWwvc2hzdGsu
YyAgICAgIHwgICA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICBhcmNoL3g4Ni9rZXJuZWwvdXByb2Jlcy5jICAgIHwgICAxNyArKysrKysrKy0tLS0tLS0tLQ0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc2hzdGsuaA0KPiArKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9zaHN0ay5oDQo+IEBAIC0yMyw2ICsyMyw4IEBAIGludCBzZXR1cF9zaWduYWxf
c2hhZG93X3N0YWNrKHN0cnVjdCBrc2kNCj4gIGludCByZXN0b3JlX3NpZ25hbF9zaGFkb3dfc3Rh
Y2sodm9pZCk7DQo+ICBpbnQgc2hzdGtfdXBkYXRlX2xhc3RfZnJhbWUodW5zaWduZWQgbG9uZyB2
YWwpOw0KPiAgYm9vbCBzaHN0a19pc19lbmFibGVkKHZvaWQpOw0KPiAraW50IHNoc3RrX3BvcCh1
NjQgKnZhbCk7DQo+ICtpbnQgc2hzdGtfcHVzaCh1NjQgdmFsKTsNCj4gICNlbHNlDQo+ICBzdGF0
aWMgaW5saW5lIGxvbmcgc2hzdGtfcHJjdGwoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBpbnQg
b3B0aW9uLA0KPiAgCQkJICAgICAgIHVuc2lnbmVkIGxvbmcgYXJnMikgeyByZXR1cm4gLUVJTlZB
TDsgfQ0KPiBAQCAtMzUsNiArMzcsOCBAQCBzdGF0aWMgaW5saW5lIGludCBzZXR1cF9zaWduYWxf
c2hhZG93X3N0DQo+ICBzdGF0aWMgaW5saW5lIGludCByZXN0b3JlX3NpZ25hbF9zaGFkb3dfc3Rh
Y2sodm9pZCkgeyByZXR1cm4gMDsgfQ0KPiAgc3RhdGljIGlubGluZSBpbnQgc2hzdGtfdXBkYXRl
X2xhc3RfZnJhbWUodW5zaWduZWQgbG9uZyB2YWwpIHsgcmV0dXJuIDA7IH0NCj4gIHN0YXRpYyBp
bmxpbmUgYm9vbCBzaHN0a19pc19lbmFibGVkKHZvaWQpIHsgcmV0dXJuIGZhbHNlOyB9DQo+ICtz
dGF0aWMgaW5saW5lIGludCBzaHN0a19wb3AodTY0ICp2YWwpIHsgcmV0dXJuIC1FTk9UU1VQUDsg
fQ0KPiArc3RhdGljIGlubGluZSBpbnQgc2hzdGtfcHVzaCh1NjQgdmFsKSB7IHJldHVybiAtRU5P
VFNVUFA7IH0NCj4gICNlbmRpZiAvKiBDT05GSUdfWDg2X1VTRVJfU0hBRE9XX1NUQUNLICovDQo+
ICANCj4gICNlbmRpZiAvKiBfX0FTU0VNQkxFUl9fICovDQo+IC0tLSBhL2FyY2gveDg2L2tlcm5l
bC9zaHN0ay5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9zaHN0ay5jDQo+IEBAIC0yNDYsNiAr
MjQ2LDQ2IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGdldF91c2VyX3Noc3RrX2FkZHINCj4gIAly
ZXR1cm4gc3NwOw0KPiAgfQ0KPiAgDQo+ICtpbnQgc2hzdGtfcG9wKHU2NCAqdmFsKQ0KPiArew0K
PiArCWludCByZXQgPSAwOw0KPiArCXU2NCBzc3A7DQo+ICsNCj4gKwlpZiAoIWZlYXR1cmVzX2Vu
YWJsZWQoQVJDSF9TSFNUS19TSFNUSykpDQo+ICsJCXJldHVybiAtRU5PVFNVUFA7DQo+ICsNCj4g
KwlmcHJlZ3NfbG9ja19hbmRfbG9hZCgpOw0KPiArDQo+ICsJcmRtc3JxKE1TUl9JQTMyX1BMM19T
U1AsIHNzcCk7DQo+ICsJaWYgKHZhbCAmJiBnZXRfdXNlcigqdmFsLCAoX191c2VyIHU2NCAqKXNz
cCkpDQoNCkl0IG1ha2VzIGl0IHNvIHNoc3RrX3BvcCgpIGNhbiBpbmNzc3Agd2l0aG91dCBwdXNo
aW5nIGFueXRoaW5nIHRvIHRoZSBzaGFkb3cNCnN0YWNrLCBidXQgbm90aGluZyB1c2VzIHRoaXMu
DQoNCkFsc28sIHNpbmNlIHRoZXJlIGlzIG5vIHJlYWRfdXNlcl9zaHN0a182NCgpIGl0IHNob3Vs
ZCBwcm9iYWJseSBjaGVjayB0aGF0IHRoZQ0KVk1BIGlzIGFjdHVhbGx5IHNoYWRvdyBzdGFjaywg
bGlrZSBob3cgaXQgZG9lcyBpbiBzaHN0a19wb3Bfc2lnZnJhbWUoKS4gV2hhdA0KdGhpcyBhY3R1
YWxseSB3b3VsZCBleHBvc2UsIEknbSBub3Qgc3VyZS4gSXQgbWlnaHQgYmUgb2suIFRoZXJlIHdv
dWxkIGp1c3QgYmUgYQ0KZmF1bHQgbGF0ZXIgZHVyaW5nIHNoc3RrX3B1c2goYXJncy5yZXRhZGRy
KSBJIGd1ZXNzLg0KDQpIbW0sIEkgZ3Vlc3Mgbm8gc3Ryb25nIG9iamVjdGlvbnMsIGJ1dCBJJ20g
c3RpbGwgbm90IHN1cmUgaXQncyB3b3J0aCBzdXBwb3J0aW5nDQp0aGUgb3B0aW1pemF0aW9uLg0K
DQoNCj4gKwkJcmV0ID0gLUVGQVVMVDsNCj4gKwllbHNlDQo+ICsJCXdybXNycShNU1JfSUEzMl9Q
TDNfU1NQLCBzc3AgKyBTU19GUkFNRV9TSVpFKTsNCj4gKwlmcHJlZ3NfdW5sb2NrKCk7DQo+ICsN
Cj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtpbnQgc2hzdGtfcHVzaCh1NjQgdmFsKQ0K
PiArew0KPiArCXU2NCBzc3A7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWlmICghZmVhdHVyZXNf
ZW5hYmxlZChBUkNIX1NIU1RLX1NIU1RLKSkNCj4gKwkJcmV0dXJuIC1FTk9UU1VQUDsNCj4gKw0K
PiArCWZwcmVnc19sb2NrX2FuZF9sb2FkKCk7DQo+ICsNCj4gKwlyZG1zcnEoTVNSX0lBMzJfUEwz
X1NTUCwgc3NwKTsNCj4gKwlzc3AgLT0gU1NfRlJBTUVfU0laRTsNCj4gKwlyZXQgPSB3cml0ZV91
c2VyX3Noc3RrXzY0KChfX3VzZXIgdm9pZCAqKXNzcCwgdmFsKTsNCj4gKwlpZiAoIXJldCkNCj4g
KwkJd3Jtc3JxKE1TUl9JQTMyX1BMM19TU1AsIHNzcCk7DQo+ICsJZnByZWdzX3VubG9jaygpOw0K
PiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgI2RlZmluZSBTSFNUS19EQVRBX0JJ
VCBCSVQoNjMpDQo+ICANCj4gIHN0YXRpYyBpbnQgcHV0X3Noc3RrX2RhdGEodTY0IF9fdXNlciAq
YWRkciwgdTY0IGRhdGEpDQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC91cHJvYmVzLmMNCj4gKysr
IGIvYXJjaC94ODYva2VybmVsL3Vwcm9iZXMuYw0KPiBAQCAtODA0LDcgKzgwNCw3IEBAIFNZU0NB
TExfREVGSU5FMCh1cHJvYmUpDQo+ICB7DQo+ICAJc3RydWN0IHB0X3JlZ3MgKnJlZ3MgPSB0YXNr
X3B0X3JlZ3MoY3VycmVudCk7DQo+ICAJc3RydWN0IHVwcm9iZV9zeXNjYWxsX2FyZ3MgYXJnczsN
Cj4gLQl1bnNpZ25lZCBsb25nIGlwLCBzcDsNCj4gKwl1bnNpZ25lZCBsb25nIGlwLCBzcCwgc3Jl
dDsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+ICAJLyogQWxsb3cgZXhlY3V0aW9uIG9ubHkgZnJvbSB1
cHJvYmUgdHJhbXBvbGluZXMuICovDQo+IEBAIC04MzEsNiArODMxLDEwIEBAIFNZU0NBTExfREVG
SU5FMCh1cHJvYmUpDQo+ICANCj4gIAlzcCA9IHJlZ3MtPnNwOw0KPiAgDQo+ICsJZXJyID0gc2hz
dGtfcG9wKCh1NjQgKikmc3JldCk7DQo+ICsJaWYgKGVyciA9PSAtRUZBVUxUIHx8ICghZXJyICYm
IHNyZXQgIT0gYXJncy5yZXRhZGRyKSkNCj4gKwkJZ290byBzaWdpbGw7DQo+ICsNCj4gIAloYW5k
bGVfc3lzY2FsbF91cHJvYmUocmVncywgcmVncy0+aXApOw0KPiAgDQo+ICAJLyoNCj4gQEAgLTg1
NSw2ICs4NTksOSBAQCBTWVNDQUxMX0RFRklORTAodXByb2JlKQ0KPiAgCWlmIChhcmdzLnJldGFk
ZHIgLSA1ICE9IHJlZ3MtPmlwKQ0KPiAgCQlhcmdzLnJldGFkZHIgPSByZWdzLT5pcDsNCj4gIA0K
PiArCWlmIChzaHN0a19wdXNoKGFyZ3MucmV0YWRkcikgPT0gLUVGQVVMVCkNCj4gKwkJZ290byBz
aWdpbGw7DQo+ICsNCj4gIAlyZWdzLT5pcCA9IGlwOw0KPiAgDQo+ICAJZXJyID0gY29weV90b191
c2VyKCh2b2lkIF9fdXNlciAqKXJlZ3MtPnNwLCAmYXJncywgc2l6ZW9mKGFyZ3MpKTsNCj4gQEAg
LTExMjQsMTQgKzExMzEsNiBAQCB2b2lkIGFyY2hfdXByb2JlX29wdGltaXplKHN0cnVjdCBhcmNo
X3VwDQo+ICAJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50LT5tbTsNCj4gIAl1cHJvYmVf
b3Bjb2RlX3QgaW5zbls1XTsNCj4gIA0KPiAtCS8qDQo+IC0JICogRG8gbm90IG9wdGltaXplIGlm
IHNoYWRvdyBzdGFjayBpcyBlbmFibGVkLCB0aGUgcmV0dXJuIGFkZHJlc3MgaGlqYWNrDQo+IC0J
ICogY29kZSBpbiBhcmNoX3VyZXRwcm9iZV9oaWphY2tfcmV0dXJuX2FkZHIgdXBkYXRlcyB3cm9u
ZyBmcmFtZSB3aGVuDQo+IC0JICogdGhlIGVudHJ5IHVwcm9iZSBpcyBvcHRpbWl6ZWQgYW5kIHRo
ZSBzaGFkb3cgc3RhY2sgY3Jhc2hlcyB0aGUgYXBwLg0KPiAtCSAqLw0KPiAtCWlmIChzaHN0a19p
c19lbmFibGVkKCkpDQo+IC0JCXJldHVybjsNCj4gLQ0KPiAgCWlmICghc2hvdWxkX29wdGltaXpl
KGF1cHJvYmUpKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gDQo+IA0KDQo=

