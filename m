Return-Path: <bpf+bounces-28911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DFA8BEAA7
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A61F25B8D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F116C85B;
	Tue,  7 May 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2kQJXK/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF6E570;
	Tue,  7 May 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103360; cv=fail; b=Onma+T2GH4D0ZoKuc2q35BAC3r/Ba6NJ1kTjakslQeBLzpfBrqHLcUAI+EiWLh66ZyOHxRj2RfaYXhpsDo5zQQ1egd2ttHGqy9fKTcx2KysJp+WRzKWRYWyunzLOg5q5+YBaVUZJMHU4Uyp+y6CqQbhMZ1OK/Ghv7hHfatme4h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103360; c=relaxed/simple;
	bh=mxwzWQ9zxspxeAUnCmpKq4xnFsTJO3Ig6+UCU9TbYwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdHd9p9NgBYIk+rwSUg3ResDc058q4kIMOWZ25ueF6QW/f6yzXEc33i2UIm+kr9vFonpEWTUZEJqHwZ6tWqxbK4MZc6b1hm5zbE8cgQg0bHWysBWTvG6yL/6/HOMtUNA5+Oe8axR/SA6g8bmMIq8VDlPFPYe6Zl1FlR/5GoXWb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2kQJXK/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715103359; x=1746639359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mxwzWQ9zxspxeAUnCmpKq4xnFsTJO3Ig6+UCU9TbYwc=;
  b=I2kQJXK/5mVH9Cj/Ynh47O7ThGBHabhGe977ffAh2CHLZCGtjBgEQnC4
   +JS4X6vD4xly65tsQ5bHvQUmctisjatzi8jEMdjU/e/c2Or8QpI1816PB
   68x4rJzK1cM9BeJjNaVlS89yIVHbW3pcAnLSN2DNwjdRCTIhisCBVceSL
   dVXxQyfOagyGo+lhRbv5QxfaO9VU50CBHgg9HhkLU7IoZOWzqlYd2vNzp
   NeyEIHAJqzaW1EHtio9GI+oiYqwNjq3rqbOlQquZflOXFC1PVN4dpS2VH
   9pg+uh5Y8undlRGzwgZ4jEwV64jnmpKyM59L8jXB9TTFaIQAst+NW6QPV
   w==;
X-CSE-ConnectionGUID: FXsdf2ctQAKjAZ0OVhhLKw==
X-CSE-MsgGUID: eofN/grFTNGLCse12oT9UA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11044106"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11044106"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 10:35:57 -0700
X-CSE-ConnectionGUID: wznEhJRvR06U8XxqrQM/6w==
X-CSE-MsgGUID: 5ZJOoSJGTWCiWjo34ucaag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29008662"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 10:35:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 10:35:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 10:35:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 10:35:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyIlzyK/ljGYcbcug2loYJ5VN4OjfttoOAc6IYfQGNphFII0DuLL2gybQQYBlX4vYOld07t/3CcOPLFGEptrqheS++IFkSyd9f5BAwoE77GRp3ELqN+tXDP+FH/EdHGO/w1isdNPNywE+t9Z2Fm3Q/l/QKKr/ydZXBFTIZWDvnfN4O66yYuPwN85RWdmCCXu5YO+PsmKVSmLyOHDIEnU5so9trxZHLQeBZV/Nv0sr0ojlWuy50j8jrk+8Hy1aIkcP6HFWuJ8aOHeLoFz8O8xmj8b8QNcbmtfhNK8pjpKxgEi07i1MJdhwdfbj5KcPFPTNdnPANaF7zcmgjseanMwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxwzWQ9zxspxeAUnCmpKq4xnFsTJO3Ig6+UCU9TbYwc=;
 b=dC1CE8arPn5L248RZanjSHTOTznpGdS5Sbij6E2s7C08X7YXmjyhs9De6W0zjXYtTS7/bWOl+p2kQrp7+8wnwZiUKcsHfsyy8zRDmXivusG6S+ij/tuZ9VOy3pOQBrfBMK89CkXVKU4XbVG0RLZ6F71TJjLYvsF7T/lFLoldojLHa9SUgdg3r5mXTYo6sxrFJ70sQ/7l5x8ZOaDKJ+6X+D43IFLQstAK+ZIHrC8gMSenmZphmEm+AsLyMzaUK8JR7Yy+uVkCILKfi+56CiE/rzDLZvMP24jPDDNs6MyB8N6ph2rRvkllknUn64KDEbITaYy+YHxXEvKh+ZMejpawtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 17:35:54 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::4f6f:538b:6c36:92f6]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::4f6f:538b:6c36:92f6%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 17:35:54 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "jolsa@kernel.org" <jolsa@kernel.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>
CC: "debug@rivosinc.com" <debug@rivosinc.com>, "luto@kernel.org"
	<luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "yhs@fb.com" <yhs@fb.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-man@vger.kernel.org"
	<linux-man@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Topic: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Index: AQHaoGz/NDbwXOtepku5mG5JmKvX1LGMCSqA
Date: Tue, 7 May 2024 17:35:54 +0000
Message-ID: <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
References: <20240507105321.71524-1-jolsa@kernel.org>
	 <20240507105321.71524-7-jolsa@kernel.org>
In-Reply-To: <20240507105321.71524-7-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|SA2PR11MB5196:EE_
x-ms-office365-filtering-correlation-id: 2aca7104-fc5a-451d-77b1-08dc6ebc2595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eUZxVVg2cEl2QkptZFR1dVdVelYybXN5eUdFbGozeC84NFVIblhOWmxWcGhE?=
 =?utf-8?B?dU5mSjV4Ykp5am5TUmZZUmxxRXBGVzdNOURJKzN1M2htK3pMaUllREp1Y2k0?=
 =?utf-8?B?d0FzY3Zzem1iYnZBMGRhRUxvNkVWZDVzcmJyQWJPOWl0YllkUXUveWM2UWNN?=
 =?utf-8?B?NG1DcHVPUWhrOGw3MDBDT1M5OGRrRlNqOW0wQXc5Q3lqSWNocVJxZVRna1Vi?=
 =?utf-8?B?S2VkYzRrSUhTb2J2Nk5BU3lScDFKUzRFc2o5Q09lTjBiQ2hvYmNaUHZxL3ZZ?=
 =?utf-8?B?Wjl2RVlVVk1uclhhOUo4VlVWMmNzTnhrNzY1NTJCV0ZLMk44UDBjUDRmODd5?=
 =?utf-8?B?Y3JpL1dkZU5tZkg1eVJNVVQxbDNWU2pZdGh2dy80Z2YvMHordldUS3JwcHp3?=
 =?utf-8?B?cG10MHdvcHNoTWtwMytGSVl4L05QMm41bGRZOVluU2cvaFJ3amc4c3hiMzhr?=
 =?utf-8?B?K1hqTkdobXpMZWE3YkZKM1ZvZktJa2syNjJLQTZDLzVObktjeG9ycHJsSy8z?=
 =?utf-8?B?b1BCUTFoUGdLcjhnbXNMdXBNQ2p1aFJNNmpYWExBWGlLTmY0cGM0aEtjRTM1?=
 =?utf-8?B?cThDTjFRMFg1ZmdFNjNVeHIxdDh5VjAwMlkvdGc0empHUDZyanhWM2NqaVh2?=
 =?utf-8?B?aUFxdnRsU0dqUEVYUjZMV2xIV3JlZkJzTlhTNDYyK2E3RTVIdDVqTzViQkNZ?=
 =?utf-8?B?T21DUzEwZnlPL1VlK2lQSmNGUGl3eUZ6UFRFR2ZFa0xySjBXU1pvd0hqOVkw?=
 =?utf-8?B?K1pmL0c5ajh4K2lLUDNBb1AyOHh4ZjVOeGg4SVNxVlNtdU5GNWp1WHdWK29F?=
 =?utf-8?B?RC8wZ3FRM0VxUGZxdzZNWGZjWW1iUU5TdXF3aTVHUUR2R1JjOEhGYTlPQXhn?=
 =?utf-8?B?Z0VzY2U4V3ZnS3J6Mm9XT21SUlJlcm5seU1yZmx4Qm1laTZ2ZzQ5OVRaejJj?=
 =?utf-8?B?SlVtWmJ2NGIyTmg3cHkzOFhUSkQxbEhLK3lhWFYwcDFjcHJlU3dWV3I5UmJs?=
 =?utf-8?B?RkhPRWpuSE8yWTdMRjkzWTEzeGcxZldZL1JGdE0ybDF3b0FXMG9yVDBTY1kr?=
 =?utf-8?B?VWlLQXNhOXdHMW4zZTVtUkdBYm1GNVkvWGY4eWhpVnVzMU5weENIa3oyRjBZ?=
 =?utf-8?B?WUJjKzhXMzJ1b0xNVGhHbUN3a2ZWUVk3QUx1R2g4THZ1UmpkNDA2RTVmWVF5?=
 =?utf-8?B?ZHVqVC91TnZBTWNyZDZjZVFxeGxFTmdqYUtGRzNxOUMyNFo4eWsyb2tUZHhw?=
 =?utf-8?B?ODMvYytqcjQwYnlFV0tQaVZxNHpqUFBUSFdycVp3aEV3SHBnelFSa3p6MXli?=
 =?utf-8?B?Q04wQlh2WDVDNXE5QjZsNklxeFJKOFRyL1QxQjYzVGg2aUhUOXd0UDFBZ2Iz?=
 =?utf-8?B?S3RuQlVKUGVLdE92V3Q0d3pqRFl2bXdkb1JOS0tNU3JEenRHOXJJWUhSMG5R?=
 =?utf-8?B?K0VyNFRmS09SQkY4ZDFWbWZmOXRLbjEvMkl5UDR1Y2FzU0EvVzk1T1hoTVJo?=
 =?utf-8?B?K0Y3L1M5aVVtWFg5K3c1Z1ZNblhHTGhNa3N6Nk4xbElSTlIwMmgvNk5qekdK?=
 =?utf-8?B?MExtMWt2K2lNQUtIS3pSTVg1U21aM2ZJb2V3R3FZMGNoQW00NXRRbXZDWEpT?=
 =?utf-8?B?UEVkRlNRcU8xRSs0TUZMMlhuRXFDUXJHbW1OVVc0R2xVSFU5WjNoT0drTkZX?=
 =?utf-8?B?U29HOGV1TFdxYTRnQVJEYWtnQnFXblUwVnp3aU5SeFVoWThST0VFU0VXV25N?=
 =?utf-8?B?bGtHejMyMXJQUWhqNXQvMk5RNkNCM0grTDVsZmNXZXRsWnRvQis4WjdhaWJT?=
 =?utf-8?B?emQ4aHBLUUltZWxvOEUyZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3pQdDBDMWJtQVB6NjRaenZUMnRtYmI5MlJrMVhFd1o3aitGT1h4TGdDei9Q?=
 =?utf-8?B?bDFFK3dZaVBMYW9yci83REV6Y0xBazNXRFdJRXgvRXo5RmYwaTB0OTN5cGNx?=
 =?utf-8?B?eWtyK2RYVTU2bXcyNGN0M3NoTUNKTkRJRGtpa0ZDZlFlaU8wam43c2d6czE3?=
 =?utf-8?B?d1BXRENoai9XUjZWZklBNEpLeDJKOFRzYjNyQi9vaGM1aGc0S3FyOXBSeXh0?=
 =?utf-8?B?MFRaTXk2TTNyK2dIenFuT0lEN01sNzh0MkpYRktpMGlNMytvTFoxSXVqMFVH?=
 =?utf-8?B?SEh0M21SWUFndTViTmdwcEhnSUhIVVZ0ZGx2TDk0SXE4bFJIR081c1ByZ2Zv?=
 =?utf-8?B?c1FFMnYxekt1b0lWL3ptN1lPWmlhMXVKWExJVmR2WkdVWmpmN21WVGtPZzk0?=
 =?utf-8?B?dEVONTlhZDdOd1Jxc2dOc1huMHlLRWUzWXUxWC8rTUVCQ25wV2ErNzdFV1d5?=
 =?utf-8?B?Ymh5UGs2b1ZFNUd4RjcyREI0QXZ0UHg3N3krdzBoV1FJSzkvTHhXcnFMYTFM?=
 =?utf-8?B?alJmc2IydWhFbWN4NkRRNmhTenptM09zWHBYRm5ULzlTUUlyckRUQUg2emNR?=
 =?utf-8?B?RlZsQmVPMld4enJxM1l4YXY5dGN2L1ovTWJwbTcraUhodHU5Q3JHbTVWdEsz?=
 =?utf-8?B?RkMzeVpOaUgrUVdCWkpNUzFuOE1lMDQ2cG5iWTByOGNJS09RRFpST21IRzJn?=
 =?utf-8?B?MUVKeFlHMWgwM3VxcXlxUU91NVlLS3VVcmF3emkzUnkrR09Od3VtTVNhZ0RN?=
 =?utf-8?B?VFI3amNyUnYwTFcvQjJ1YndTdWtRZ0RGbHh2a2l3eURTYXBqemJSbzM0NFE5?=
 =?utf-8?B?ekVMZHp2cStzK1dzTXczMEhvTm9RT1JQaXlPVnI3cVQ2MmU3MXZXMW42YUM1?=
 =?utf-8?B?dFIrYW5uSzlQNExPWFVwV2NZSmRha2NWNmlJSWR2TXBNc0hRWGxoSmhSZzZo?=
 =?utf-8?B?NGN5SkxheXpRNGxqUC9hdXZGOXhCbG5LMWwvTVozdHJsSmJkTXZobU10UjZ3?=
 =?utf-8?B?UWo0ZlYzK25lWWZPeGhqR01LaWNyd2NreTYycmdaSnlFS2ZheUh2T25WSm4x?=
 =?utf-8?B?NFhhR0U4Z0l3M3NLK2tpTmtVUXBjMVB3eE9xaHRJbmpkQi85VlVFQ0NjUE5P?=
 =?utf-8?B?RjZ0NVp5MFNNN1d1c2k1alovMW5pbEx3VWU3QXlscWV5SENkQUZHcmI3UXZo?=
 =?utf-8?B?Y05wdUhWQ2VxUWx3UzlaOWhkOHlBT2lOUVdHMDVkZnNOelA5ampkcHBXNmlm?=
 =?utf-8?B?UG1yTWpveUZjUUdFb3N5aUs4RjNKQXBwaDdSNlhNM2pEYTlkUElWOHhic2kr?=
 =?utf-8?B?QkFwRkFWMEZxaFV3NUMvRTJabkhySjBra2tHSFlzZHBNN3E0VnZhNkZWb200?=
 =?utf-8?B?eWxyOXI4L0pGc2NpbE1DRjh0L1B2UEVkUWxyWUNaZGdYTnVvakxaYlpGYi91?=
 =?utf-8?B?ZHNWVVdmalZwTHpHaXpTWWt5ZE56YzhLMXZVS0NUT2tHQjZqcGxlUWFBZ1pk?=
 =?utf-8?B?cnhtVzdvSWtVekQxL2JXRjUwa2dpbzFkZmswOThsdkUrNmRmbVVzeTZyWWh3?=
 =?utf-8?B?SlBPV3k3aStINC9lUmdoWnZwMzVpVGJTTnFMZzVRZDdlVGpqUlpJV0xpV1Iw?=
 =?utf-8?B?TmhNaVBlZFFoWmcrc01mTC9DQzRBM1FNK1d2UE1oZkd5eWEyeThZT3lodm5k?=
 =?utf-8?B?OVZ5ZUxjem9qREVESmlYd2s2OW8zQ0pRVU5BaHZQYTRsYVZ3dXY5NUVLeWQr?=
 =?utf-8?B?bU9vR0hmVjlVUEhIWGk4bGcxaEg1ZmFYN001bURzQ010RW0zYW1ydVVmcmMz?=
 =?utf-8?B?YnpvTGtYb1NtWWo4RlQwWFJvQWVydm9CQUZUZGtkWXQrdXBxS1FKRncyQ0M4?=
 =?utf-8?B?cnd4ZEdFN2JLZGJCTzVuUHFJb2JKVFR1TG5tT3lqVFpXYnoyQktGb0tZMlRY?=
 =?utf-8?B?MVliRUNTSExRNzhyQWZ1RDJ6UHVpVFEyMWhoMXllNEdORCswenIweHpjMS8x?=
 =?utf-8?B?eUw2MHlmZ1pnbGpLQVJxa3VIYXpnWG40RDBLZDJBbzJtcUJpTDY1Y2JHQ1ls?=
 =?utf-8?B?WHp1NTVGYUtURnMyR2U4a1dmZkFaeGhKL3dpOTB1K1JnSWgrL3FGa0lvMk5L?=
 =?utf-8?B?VDlnb0s2TE5iS2JGTHBvQ2FqbTBLRk1qNmQ2UU9tYm9GaGN5SmZVcG90MThh?=
 =?utf-8?Q?v9KHc5GHIDXrygnPnLL6qlo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94E68AE920765B4B80BFB4BD89872783@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aca7104-fc5a-451d-77b1-08dc6ebc2595
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 17:35:54.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWGZLUQkijGPNXablvlatFRbjyqh8c9mrvL0amAhAFpTBuY+Q/s+rCXtrpwFE6FA83R0IcVDMd+8SzQ4t6ARGfl28doJVgb645QIm1i3Dls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA1LTA3IGF0IDEyOjUzICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvdXByb2Jlcy5jIGIvYXJjaC94ODYva2VybmVsL3Vw
cm9iZXMuYw0KPiBpbmRleCA4MWU2ZWU5NTc4NGQuLmFlNmMzNDU4YTY3NSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC94ODYva2VybmVsL3Vwcm9iZXMuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvdXBy
b2Jlcy5jDQo+IEBAIC00MDYsNiArNDA2LDExIEBAIFNZU0NBTExfREVGSU5FMCh1cmV0cHJvYmUp
DQo+IMKgwqDCoMKgwqDCoMKgwqAgKiB0cmFtcG9saW5lJ3MgcmV0IGluc3RydWN0aW9uDQo+IMKg
wqDCoMKgwqDCoMKgwqAgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoHIxMV9jeF9heFsyXSA9IHJlZ3Mt
PmlwOw0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoC8qIG1ha2UgdGhlIHNoYWRvdyBzdGFjayBmb2xs
b3cgdGhhdCAqLw0KPiArwqDCoMKgwqDCoMKgwqBpZiAoc2hzdGtfcHVzaF9mcmFtZShyZWdzLT5p
cCkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHNpZ2lsbDsNCj4gKw0K
PiDCoMKgwqDCoMKgwqDCoMKgcmVncy0+aXAgPSBpcDsNCj4gwqANCg0KUGVyIHRoZSBlYXJsaWVy
IGRpc2N1c3Npb24sIHRoaXMgY2Fubm90IGJlIHJlYWNoZWQgdW5sZXNzIHVyZXRwcm9iZXMgYXJl
IGluIHVzZSwNCndoaWNoIGNhbm5vdCBoYXBwZW4gd2l0aG91dCBzb21ldGhpbmcgd2l0aCBwcml2
aWxlZ2VzIHRha2luZyBhbiBhY3Rpb24uIEJ1dCBhcmUNCnVyZXRwcm9iZXMgZXZlciB1c2VkIGZv
ciBtb25pdG9yaW5nIGFwcGxpY2F0aW9ucyB3aGVyZSBzZWN1cml0eSBpcyBpbXBvcnRhbnQ/IE9y
DQppcyBpdCBzdHJpY3RseSBhIGRlYnVnLXRpbWUgdGhpbmc/DQo=

