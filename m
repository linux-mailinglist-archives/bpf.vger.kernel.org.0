Return-Path: <bpf+bounces-63394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E01B06B87
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C941762BA
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D99272E75;
	Wed, 16 Jul 2025 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOv7W2yl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAC2E36F9;
	Wed, 16 Jul 2025 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631471; cv=fail; b=sgY1cVc3EjxjEjmYbq2ArZq1CvT5PJJwIohzUC81QytlUBXHv2rrumtDqRXrHv8bkXGEMIW7C50RHubX47ameGTgX8OAw5D/b/Lx19oaTZiGPlL1N9cZNSXUCQaKxLZCVzZ0z0Qu56wjHa4xDMZiOHgA4mGOlYN2F1MJyzVBgg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631471; c=relaxed/simple;
	bh=IzvRxsMLgnrGAKqSoYnykl7UaMNofm/bn3tlQ1qJHg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/6onL+lsFnCP/1kf7AA1HQB8FrjBFlkNluDAAU9TeVFpj1qN8XhFnFk70FRJk8k+SeVqmn0uUyMfRBVgJD+tX+jtpalPCvuGsvOx504OuoyDMMB5K6lMvI/AEfXBrbIcrsJYIhtakF/0jI9sEiZiQR97hVVYwZakkhay3tGKFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOv7W2yl; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631469; x=1784167469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IzvRxsMLgnrGAKqSoYnykl7UaMNofm/bn3tlQ1qJHg0=;
  b=cOv7W2yl8vgkrog/sLqGQ17odRpsRxk8pT/ZAcQXsFp9+BJeindVJr04
   FSYY+/MoQ+GobgE5ttwAMatjV3E/XW/zvz3iMSwn316b5rwwMnZ4ouaGj
   pet+FCHKK9bYej83zG46lCcexa4ztvsxacr8NRr1PXHpt+s6sUHFoO8eu
   61lv1VmKxm/Ng/rtWFWwm8b/BYz3bmaCJMVWJ/D6RrjlEV1h8QmkCCcVQ
   uCgQlqWLId46W4Pngy9fn4AXKRfC1C1dEsFYAbIGf1eFOYDmlxJA4rgZK
   qGgH4//D88VxeBg4Hqwu1rW/VHAjku2ynfgQauJArFEBrQaYGS9MeR7ed
   Q==;
X-CSE-ConnectionGUID: tPfTX39BTbG+mLB1IvIRQA==
X-CSE-MsgGUID: LRKio6RVSDe27Hw92oZjeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54839134"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54839134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:04:28 -0700
X-CSE-ConnectionGUID: gNTiPNABSYaaIF5muYOiPw==
X-CSE-MsgGUID: if7daydiS9iIkwYwc3FcSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="181061571"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:04:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:04:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 19:04:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 19:04:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz6gj8QY6faRFWWchiqVtqfYVERU7D9jl7YOgEIhaofKn5j7WGN6z3q3rRQDZhPm9EQod+6zD/7dhLBydLm4/Os0p7zGWStAhp6oT5iJN9cdbKvpxtavijiRCD5UQkcFLAD5nvBfJpwBIErr7xlxgSucHGg0TG1z/rX+a9oxgPf4NELZOBk8raDchwjYqLlBMNfaqtM1fRzjS44E/eaadEMfkjn/N2sGc6+HttJw8/jafzUuBOmXs6N3sd5saedr/nsiHkkiEfneEsU8QFJbDaehu4B7UmwXK62tGZlYqjlI1qA55cG1NfvCqRLkcE8h4pwDnaf5HzrG+mN2tfubBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzvRxsMLgnrGAKqSoYnykl7UaMNofm/bn3tlQ1qJHg0=;
 b=wrO+P7PpVKGrNo6yaU/6tKndsTrEa4DfCgAJRvv8qu1b2olPMgHkF28RiCYp45Nenh/3//Sq5Ee0BkHmLZ2YqCE+9awzHhIYsqg/0f4e2WhKob7itA3mzqO/5tC5777SBmX+O1vnd96GRhGWqTZRne6HheYQjrMeGsGc/NbzMt69SkQbEz0IzwUWITVgeqZ6ytwndYkESMBDMl2I7b9RAbhTYXO/5RrOAomGgMM7FUuPcpiUgQBDs85P4jQZHiD7cXutbhNq7vRFk8oTc3EDlD/us8yfjMovlQ02FL3iCowM11fLMWHBYEsUPOOZWGFKBWDf/BZLuaWbnCUzJCF1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Wed, 16 Jul
 2025 02:04:23 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 02:04:23 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH bpf-next,v4 1/1] doc: clarify XDP Rx metadata handling and
 driver requirements
Thread-Topic: [PATCH bpf-next,v4 1/1] doc: clarify XDP Rx metadata handling
 and driver requirements
Thread-Index: AQHb9Vhr0Aafvgr6uUyDGhiaxQBAhLQzqS2AgABXXKA=
Date: Wed, 16 Jul 2025 02:04:23 +0000
Message-ID: <IA3PR11MB9254057C82D0CEAFDF58BA73D856A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250715071502.3503440-1-yoong.siang.song@intel.com>
 <aHa-zwLmFSLDKeBA@mini-arch>
In-Reply-To: <aHa-zwLmFSLDKeBA@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|BL3PR11MB6507:EE_
x-ms-office365-filtering-correlation-id: 397d4b65-d6de-43ca-2d0c-08ddc40d15b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WE5IZ0p1ejZ0NUVCVFlDQWZPOFBETklOZS9GR2NTeVc5UUpWcG9nbFVYK0l1?=
 =?utf-8?B?dzM1RmlYUVY3UzBvR0pMUE50c0NBZVdNRzEreW5vSlpiSU1HeGpFTjZoYTVh?=
 =?utf-8?B?RnhSektGcXVmRHhrb20yamt2U0RkbFcxL2VZSVdqMW41NmlZbEF3ek1ocUs2?=
 =?utf-8?B?Vkp5OTkwd3JaejVhR3NMZDdIMmV2Nzl5SmlhSWRoUVBEZDQzM3dLM09xb1Jv?=
 =?utf-8?B?cUpnTXgxWGxHbG83WHpWc0s5b3g4Wis3VnlaSlZ2NVNPd2lmNldsb0h4RWVL?=
 =?utf-8?B?VUVaamRWTDhjUFJnNnArdk1iVmZTSGk5ekF0cHJoZVFWQW0zSEdsaWxCTU82?=
 =?utf-8?B?My84aU56VGdWSDkvU3dNNU5DMEE0WUhZemlrZmJtd0pSMXVGcis5ZjlQbXZh?=
 =?utf-8?B?U3JCVHVyOHNZRlJ2VnVzM2pOdG1SU3FkMDUwRjFPbFhBc1BEdFJteDF4S3VS?=
 =?utf-8?B?c2paSTVWb3hSSkFMZGNqODVnTEtUV3pKOXVZR3R6UlJCbEpiWWNwKzB0VXFO?=
 =?utf-8?B?Z0hlc2ZnbGcxcFRKdm9TQzUzaERTdUZNZ2g3VzNMaEhiNWpvNE5iUHA0ZmMr?=
 =?utf-8?B?Y2lDYnVycUtoRlhtYWtqT2crVEQzYkNKZXdGOGExNUc4Y1lzQkFPNXNXaVRw?=
 =?utf-8?B?MWFsNlFSQUZTK0NOWWhVLzJmT0k0aVd4VUdobjZqWEVxeE95eHYzT216ams2?=
 =?utf-8?B?di9ybncxbW5maFpKaDkvTkdpc0tueWo3VXJSdFdEWGZQazdNWkRtSitwTEZM?=
 =?utf-8?B?K0xQc3NnaUlZWVRBZ21KM1lmVTRqRTRLTVdXTE8vMzh1bm0xbDJ4SmdIa1Zz?=
 =?utf-8?B?RGJzTmc1YndHa0F3UW9ROTlZL082WHd1WnhhOU5EQ3ZXOThkOWtISG04ZHBh?=
 =?utf-8?B?TVhLd2RsVVB2VW43L21SYkNXVUI4eVh4bzJJV3lldlRoaW5wa1dLeWJDUmhI?=
 =?utf-8?B?dDh0cWQwMFhySzR1MUVSSnhkZHFIMVJSUlhNREdvVnJNUFdUWCtKTUNWUEI3?=
 =?utf-8?B?dXRzWEYvUWVpZXRCRThSUXFObmRzbTJod2huTkxhMTFjVDZsandBditJQlU2?=
 =?utf-8?B?RHMzR0hPYWxJWnExcE5xRklBWEFvU1dGRVNaTUVsMFFCbGJqL0ZMR2FNWHRE?=
 =?utf-8?B?MHFVOGM4WXVCR3FlT05FSjFaMU5IdXhiMFdmVGRvNXRqSjN0c3BKaDZrM2VX?=
 =?utf-8?B?UjN0UHUraFQ0enpyeXRvVE9CS2owZGlBUTgrWDdwUExiZnA4YUgvZm11V0ov?=
 =?utf-8?B?clhQODRoanIvUmtYaFJyNXlGaE9aMVRFTVFSbmFhYzMxTjQ0c0d6VkJ3cDZz?=
 =?utf-8?B?ZjBsUFdhRUh4RWdSSEM0ei9MQlJheFBEckNqQ2xIUmNlK2M4NS91ZmdjdjJP?=
 =?utf-8?B?cjVxOUp2TjI5aysrcjZLZHZScFFhYm9FbEJabzlIVWIyMzFuZERvcWhFeSt4?=
 =?utf-8?B?UFhER3phUUV2YXp3WTFrS0hublVLS2p0NTgwOEorYjNJdVpZa0hMQzNoVFpU?=
 =?utf-8?B?MjZQYmVXVU1BRHhjMlRUS2tVZVdtMGFFWmtRaEpiUkRBcVVJbnhHVnBQYXli?=
 =?utf-8?B?Z2dWUGJyU1B3NGcwb3o3aEdMMXNhMnljVUJEeEtRK2F2c2ljcmVNZlJYL3JV?=
 =?utf-8?B?RjZkZGovZjg5N2lKTy93dCttYk1hNUw0YStYL0xveHlKbDBjcFg1QSttT0gw?=
 =?utf-8?B?ajJOMFh0ZXQxWFlGSXlmYXQzYWNqU1pUR2RZVnVqcktOT0M4M3RyMXg1bVRy?=
 =?utf-8?B?LzBWZ28vSUVsNEJ0cnBrSWMzSmxQL1FqQUZiZXFUS3VDa3N2YjNKOXo1VUlq?=
 =?utf-8?B?U2xSVGN1cHBCNjZNbVZzT3lVOWVyb3RhUGVDRFZVS3ltcWlXWnBFSEhQb3FW?=
 =?utf-8?B?RnFtTVBtajBPME5KMmFoeWd2TmMvWFRDeEFxV0FWSFdZcitoN0lvYmREbTFJ?=
 =?utf-8?B?VklWN1QxSDNNd0hQSzQvNHp6RGhBOW1SZDBEcTkrZkc1enF3OC9EQTNkcW4z?=
 =?utf-8?Q?rpl0HHtUM5TqU1JdLS0RhpLV/UID0s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qng2dWdnWlZKMGZJR2ErdWtWSW43Y0M1T3dTRTdqS0JFMUFOdWRLTU1RY2R2?=
 =?utf-8?B?TWZDbTk4TmdsNDNIbVBMeFFYaDE2bjhwQUFNNmNkMGVmdGJ0aU16V3lEOG1a?=
 =?utf-8?B?SGFSd2JhNUh1RTZxamZMTUM2QWV2Rjcrb0pBT2s2RzkyNlFacDZnZGRURXJT?=
 =?utf-8?B?RVM0UGxBRHBTc2trcW9GZXU5b3kydDFqVXR1RHVuMW5vc2JzdFJSVXNVT2lQ?=
 =?utf-8?B?cDdkM2F0S0hmMVNrMjRDTGNrVXdiVFRjcnk5c2J3Y3NvS0JBdmJTWTVzaVhm?=
 =?utf-8?B?dzN2clZ1RytxeWM5cDBiQzgyZUZWVm5nNHZBR1B6WDZlSWRaUHpGNDZ2SHhK?=
 =?utf-8?B?NHF6Mk8xcWhpUWFOaGRZaXBjVUNnMVFVQmF4aXpCMk41a1luT2pqK09yd2lT?=
 =?utf-8?B?VW1FUDd6R283M1c2YUFHa0l1MVAvYzN3K2M2cW5Nb2w2UHNyWWoyd1pVM1Bo?=
 =?utf-8?B?NlVZTmNlMEtLM1k4aWVHOTZQMk8zUFA3VnVBdHFWS0RBdHJGa0s2NElzc1F3?=
 =?utf-8?B?UUloSHZuVVM5aG5MU3VkaXVld1k1aW5OODNoOStpTVkxT0I2RzBnTEVqeUM1?=
 =?utf-8?B?NmVkWDB5QW44dlhsaVVLazZlT0wzZlIzTVFxbjZQNGxqUG9mWGFPTFVqRGZF?=
 =?utf-8?B?Sjk2Y1NzZGVyNmFMdGdPa1hVY0RTRGl0ZW5rclc5VnFYdlhzcDc4RDZSNWI2?=
 =?utf-8?B?TmNlaW14OWdVU0Fkbi9zbVpoaWgzSm5jR2JCVGlteC9xaURZbFFuVzkzTDBC?=
 =?utf-8?B?ajlJSGhOZWZ2N3RsMVhLZUhlTi9qaVEydHJ4clN1OEE5N0NmSGowRGZSVmg3?=
 =?utf-8?B?eE56dy9MR0traTYzTWdDUks1ZXBGK1FvN2ZuQ2hGMGRuQ1JFVjNTV1VQb3NE?=
 =?utf-8?B?ZkZiUzdYNEVIcU54WEtBSXFBSm9CaTRjZHRuelUvUTI3NDBEZFIzR1B4SzYw?=
 =?utf-8?B?WnZWbC9wc1FTT3IvK0E1MEt4bWlGZWNUUjJ3bGJyTkdtQjhvWHI3V2VIeVU0?=
 =?utf-8?B?c2M4aHRIZWNBWXVWM3p0aGo5bkFEV1N1VnJndC9pTFRodngvYmx3WFV4SVNE?=
 =?utf-8?B?b0ZBUWU0U2hadkJGM29udGJ6RWNyUGZsek56eE5neFFPVjQyNWpUTTRsNlM5?=
 =?utf-8?B?ckJra3pQZ2FFMi9aZnJYUGRweWE4d3BHcVVGTWo4d3RISzI5UUxYNSt2Wm02?=
 =?utf-8?B?MmN4ejdEa2ovajViSGNOTlFZWFhjZVZEWWtZcWhMMkZNSFloenNldWlxRXN0?=
 =?utf-8?B?RENUVDJIMDhmbFp3V3hqLzdpbVYzYXdJSEFvVDdFOTFxRkFKWG1zK1RMb2to?=
 =?utf-8?B?RkJCaWxoYmF6eFJoZTZRekEzV1NPWU5DRGFtV0I2NGNyWnhHOEVhQmNFc0hm?=
 =?utf-8?B?QzUzeXBFRmlZQmN4cGZxSy9Uc0NFYllMeTBKQUMvaU8yemVCVy9ERWpYN2p2?=
 =?utf-8?B?bG92U3RkNXVJNEJBM1Y5OTlWb2ZUWXRHNk4vTXBQVUVlVFZNNHNTL2Z5YUZt?=
 =?utf-8?B?ZkdDeGx4ZUhTMzU5VXpTcE5CT2t2cG5acWNUNlhCbHQ1QUJITk9iZFI0d0Rv?=
 =?utf-8?B?K0VxcmE3QjhBUVBEejJweFRyV21ZazNSeHJXZHdpemV3SzlrT0FyZHYrYnNk?=
 =?utf-8?B?L2xqUnNMT29UMkNHeTJ4U3B2bjV5elVCbFR5dmh1YWdNWXdvNUExaUJhZjVO?=
 =?utf-8?B?SWhqWWExR0xnMzVJVFEzRTNIbXZxRlVtbHBhcXZiMnltMkxSUW94TWxEOTBi?=
 =?utf-8?B?U0ZZZGQwdHBrMDZ6eW1Cb2ZIZkh0SlRBUXRJcWhET1pFalF1WUg1TTU5WnpP?=
 =?utf-8?B?TXJvTXFLdUgxNkloM2M1ZktKc1NzQ3NFRllhTjhGUGZFNVc5eGl6TFh1QTlo?=
 =?utf-8?B?MmFldlVuc0dRQVdGa1NTNHNlaCtrNWI3OFRVanIyUmhsb2V2eER1dGNyR0Y1?=
 =?utf-8?B?dDJnaU1aUzlnempiSHRrNUpvZHlyYjFVbkcyM0ZSdFY5bHdsMnBUL3hncHdI?=
 =?utf-8?B?ZjBtMGVpd3RmeHRObFhwMm5nMFQwR2VwZVhUeFUwbTNpSllMMC90WGR2YXpn?=
 =?utf-8?B?bTh4UW4wMzVjVjYrUm95SGtHM2JMWXRDK2pyanZEd2FZMmY0MVFIOVVEOXZT?=
 =?utf-8?B?SUZoREJJcFYzeHNNZFd6aHhFZW9tc040bTRGZDVhZ29KZEppeWo0bHoyRGR1?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397d4b65-d6de-43ca-2d0c-08ddc40d15b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 02:04:23.3407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +LCkbmhRC2FGxXsism6lw1SOKOSlEwZx54b3rHv2/EDwGBX0BLhDia/ZD+N/1V2k+iuSNubv8ncZ+XPqSTXgMTwWNZ3aJXpqWVSiNbwc2CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBKdWx5IDE2LCAyMDI1IDQ6NDkgQU0sIFN0YW5pc2xhdiBGb21pY2hldiA8
c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPk9uIDA3LzE1LCBTb25nIFlvb25nIFNpYW5n
IHdyb3RlOg0KPj4gSW1wcm92ZXMgdGhlIGRvY3VtZW50YXRpb24gZm9yIFhEUCBSeCBtZXRhZGF0
YSBoYW5kbGluZywgZXNwZWNpYWxseSBmb3INCj4+IEFGX1hEUCB1c2UgY2FzZXMuIEl0IGNsYXJp
ZmllcyB0aGF0IGRyaXZlcnMgbXVzdCByZW1vdmUgYW55IGRldmljZS1yZXNlcnZlZA0KPj4gbWV0
YWRhdGEgZnJvbSB0aGUgZGF0YV9tZXRhIGFyZWEgYmVmb3JlIHBhc3NpbmcgdGhlIGZyYW1lIHRv
IHRoZSBYRFANCj4+IHByb2dyYW0uDQo+Pg0KPj4gQmVzaWRlcywgZXhwYW5kIHRoZSBleHBsYW5h
dGlvbiBvZiBob3cgdXNlcnNwYWNlIGFuZCBCUEYgcHJvZ3JhbXMgc2hvdWxkDQo+PiBjb29yZGlu
YXRlIHRoZSB1c2Ugb2YgTUVUQURBVEFfU0laRSwgYW5kIGFkZHMgYSBkZXRhaWxlZCBkaWFncmFt
IHRvDQo+PiBpbGx1c3RyYXRlIHBvaW50ZXIgYWRqdXN0bWVudHMgYW5kIG1ldGFkYXRhIGxheW91
dC4NCj4+DQo+PiBBZGRpdGlvbmFsLCBkZXNjcmliZSB0aGUgcmVxdWlyZW1lbnRzIGFuZCBjb25z
dHJhaW50cyBlbmZvcmNlZCBieQ0KPj4gYnBmX3hkcF9hZGp1c3RfbWV0YSgpLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFNvbmcgWW9vbmcgU2lhbmcgPHlvb25nLnNpYW5nLnNvbmdAaW50ZWwuY29t
Pg0KPj4gLS0tDQo+Pg0KPj4gVjQ6DQo+PiAgIC0gdXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uIHRv
IGluZGljYXRlIHRoYXQgZHJpdmVycyBhcmUgZXhwZWN0ZWQgdG8gY29weQ0KPj4gICAgIGFueSBk
ZXZpY2UtcmVzZXJ2ZWQgbWV0YWRhdGEgZnJvbSB0aGUgbWV0YWRhdGEgYXJlYSAoSmFrdWIpDQo+
PiAgIC0gcmVtb3ZlIHNlbGZ0ZXN0IHRvb2wgY2hhbmdlcy4NCj4+DQo+PiBWMzogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjUwNzAyMTY1NzU3LjMyNzg2MjUtMS0NCj55b29uZy5z
aWFuZy5zb25nQGludGVsLmNvbS8NCj4+ICAgLSB1cGRhdGUgZG9jIGFuZCBjb21taXQgbXNnIGFj
Y29yZGluZ2x5Lg0KPj4NCj4+IFYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAy
NTA3MDIwMzAzNDkuMzI3NTM2OC0xLQ0KPnlvb25nLnNpYW5nLnNvbmdAaW50ZWwuY29tLw0KPj4g
ICAtIHVuY29uZGl0aW9uYWxseSBkbyBicGZfeGRwX2FkanVzdF9tZXRhIHdpdGggLVhEUF9NRVRB
REFUQV9TSVpFIChTdGFuaXNsYXYpDQo+Pg0KPj4gVjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L25ldGRldi8yMDI1MDcwMTA0Mjk0MC4zMjcyMzI1LTEtDQo+eW9vbmcuc2lhbmcuc29uZ0BpbnRl
bC5jb20vDQo+PiAtLS0NCj4+ICBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcveGRwLXJ4LW1ldGFk
YXRhLnJzdCB8IDQ3ICsrKysrKysrKysrKysrLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDM0
IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL25ldHdvcmtpbmcveGRwLXJ4LW1ldGFkYXRhLnJzdA0KPmIvRG9jdW1lbnRhdGlv
bi9uZXR3b3JraW5nL3hkcC1yeC1tZXRhZGF0YS5yc3QNCj4+IGluZGV4IGE2ZTBlY2UxOGJlNS4u
MmUwNjdlYjZjNWQ2IDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL3hk
cC1yeC1tZXRhZGF0YS5yc3QNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy94ZHAt
cngtbWV0YWRhdGEucnN0DQo+PiBAQCAtNDksNyArNDksMTAgQEAgYXMgZm9sbG93czo6DQo+PiAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgIHwNCj4+ICAgICB4ZHBfYnVmZi0+ZGF0YV9t
ZXRhICAgeGRwX2J1ZmYtPmRhdGENCj4+DQo+PiAtQW4gWERQIHByb2dyYW0gY2FuIHN0b3JlIGlu
ZGl2aWR1YWwgbWV0YWRhdGEgaXRlbXMgaW50byB0aGlzIGBgZGF0YV9tZXRhYGANCj4+ICtDZXJ0
YWluIGRldmljZXMgbWF5IHV0aWxpemUgdGhlIGBgZGF0YV9tZXRhYGAgYXJlYSBmb3Igc3BlY2lm
aWMgcHVycG9zZXMuDQo+PiArRHJpdmVycyBmb3IgdGhlc2UgZGV2aWNlcyBtdXN0IG1vdmUgYW55
IGhhcmR3YXJlLXJlbGF0ZWQgbWV0YWRhdGEgb3V0IGZyb20NCj50aGUNCj4+ICtgYGRhdGFfbWV0
YWBgIGFyZWEgYmVmb3JlIHByZXNlbnRpbmcgdGhlIGZyYW1lIHRvIHRoZSBYRFAgcHJvZ3JhbS4g
VGhpcyBlbnN1cmVzDQo+PiArdGhhdCB0aGUgWERQIHByb2dyYW0gY2FuIHN0b3JlIGluZGl2aWR1
YWwgbWV0YWRhdGEgaXRlbXMgaW50byB0aGlzIGBgZGF0YV9tZXRhYGANCj4+ICBhcmVhIGluIHdo
aWNoZXZlciBmb3JtYXQgaXQgY2hvb3Nlcy4gTGF0ZXIgY29uc3VtZXJzIG9mIHRoZSBtZXRhZGF0
YQ0KPj4gIHdpbGwgaGF2ZSB0byBhZ3JlZSBvbiB0aGUgZm9ybWF0IGJ5IHNvbWUgb3V0IG9mIGJh
bmQgY29udHJhY3QgKGxpa2UgZm9yDQo+PiAgdGhlIEFGX1hEUCB1c2UgY2FzZSwgc2VlIGJlbG93
KS4NCj4+IEBAIC02MywxOCArNjYsMzYgQEAgdGhlIGZpbmFsIGNvbnN1bWVyLiBUaHVzIHRoZSBC
UEYgcHJvZ3JhbSBtYW51YWxseQ0KPmFsbG9jYXRlcyBhIGZpeGVkIG51bWJlciBvZg0KPj4gIGJ5
dGVzIG91dCBvZiBtZXRhZGF0YSB2aWEgYGBicGZfeGRwX2FkanVzdF9tZXRhYGAgYW5kIGNhbGxz
IGEgc3Vic2V0DQo+PiAgb2Yga2Z1bmNzIHRvIHBvcHVsYXRlIGl0LiBUaGUgdXNlcnNwYWNlIGBg
WFNLYGAgY29uc3VtZXIgY29tcHV0ZXMNCj4+ICBgYHhza191bWVtX19nZXRfZGF0YSgpIC0gTUVU
QURBVEFfU0laRWBgIHRvIGxvY2F0ZSB0aGF0IG1ldGFkYXRhLg0KPj4gLU5vdGUsIGBgeHNrX3Vt
ZW1fX2dldF9kYXRhYGAgaXMgZGVmaW5lZCBpbiBgYGxpYnhkcGBgIGFuZA0KPj4gLWBgTUVUQURB
VEFfU0laRWBgIGlzIGFuIGFwcGxpY2F0aW9uLXNwZWNpZmljIGNvbnN0YW50IChgYEFGX1hEUGBg
IHJlY2VpdmUNCj4+IC1kZXNjcmlwdG9yIGRvZXMgX25vdF8gZXhwbGljaXRseSBjYXJyeSB0aGUg
c2l6ZSBvZiB0aGUgbWV0YWRhdGEpLg0KPj4gLQ0KPj4gLUhlcmUgaXMgdGhlIGBgQUZfWERQYGAg
Y29uc3VtZXIgbGF5b3V0IChub3RlIG1pc3NpbmcgYGBkYXRhX21ldGFgYCBwb2ludGVyKTo6DQo+
PiAtDQo+PiAtICArLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0rDQo+PiAtICB8
IGhlYWRyb29tIHwgY3VzdG9tIG1ldGFkYXRhIHwgZGF0YSB8DQo+PiAtICArLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0tLS0tLSstLS0tLS0rDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF4NCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgIHJ4X2Rlc2MtPmFkZHJlc3MNCj4+ICtOb3RlLCBgYHhza191bWVtX19n
ZXRfZGF0YWBgIGlzIGRlZmluZWQgaW4gYGBsaWJ4ZHBgYCBhbmQgYGBNRVRBREFUQV9TSVpFYGAg
aXMNCj4+ICthbiBhcHBsaWNhdGlvbi1zcGVjaWZpYyBjb25zdGFudC4gU2luY2UgdGhlIGBgQUZf
WERQYGAgcmVjZWl2ZSBkZXNjcmlwdG9yIGRvZXMNCj4+ICtfbm90XyBleHBsaWNpdGx5IGNhcnJ5
IHRoZSBzaXplIG9mIHRoZSBtZXRhZGF0YSwgaXQgaXMgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIHRo
ZQ0KPj4gK2RyaXZlciB0byBjb3B5IGFueSBkZXZpY2UtcmVzZXJ2ZWQgbWV0YWRhdGEgb3V0IGZy
b20gdGhlIG1ldGFkYXRhIGFyZWEgYW5kDQo+PiArZW5zdXJlIHRoYXQgYGB4ZHBfYnVmZi0+ZGF0
YV9tZXRhYGAgaXMgc2V0IGVxdWFsIHRvIGBgeGRwX2J1ZmYtPmRhdGFgYCBiZWZvcmUgYQ0KPj4g
K0JQRiBwcm9ncmFtIGlzIGV4ZWN1dGVkLiBUaGlzIGlzIG5lY2Vzc2FyeSBzbyB0aGF0LCBhZnRl
ciB0aGUgQlBGIHByb2dyYW0NCj4+ICthZGp1c3RzIHRoZSBtZXRhZGF0YSBhcmVhLCB0aGUgY29u
c3VtZXIgY2FuIHJlbGlhYmx5IHJldHJpZXZlIHRoZSBtZXRhZGF0YQ0KPj4gK2FkZHJlc3MgdXNp
bmcgYGBNRVRBREFUQV9TSVpFYGAgb2Zmc2V0Lg0KPj4gKw0KPj4gK1RoZSBmb2xsb3dpbmcgZGlh
Z3JhbSBzaG93cyBob3cgY3VzdG9tIG1ldGFkYXRhIGlzIHBvc2l0aW9uZWQgcmVsYXRpdmUgdG8g
dGhlDQo+PiArcGFja2V0IGRhdGEgYW5kIGhvdyBwb2ludGVycyBhcmUgYWRqdXN0ZWQgZm9yIG1l
dGFkYXRhIGFjY2VzcyAobm90ZSB0aGUNCj5hYnNlbmNlDQo+PiArb2YgdGhlIGBgZGF0YV9tZXRh
YGAgcG9pbnRlciBpbiBgYHhkcF9kZXNjYGApOjoNCj4+ICsNCj4+ICsgICAgICAgICAgICAgIHw8
LS0gYnBmX3hkcF9hZGp1c3RfbWV0YSh4ZHBfYnVmZiwgLU1FVEFEQVRBX1NJWkUpIC0tfA0KPj4g
KyAgbmV3IHhkcF9idWZmLT5kYXRhX21ldGEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBv
bGQgeGRwX2J1ZmYtPmRhdGFfbWV0YQ0KPj4gKyAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+PiArICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4ZHBfYnVmZi0+
ZGF0YQ0KPj4gKyAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8DQo+PiArICAgKy0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0rDQo+PiArICAgfCBo
ZWFkcm9vbSB8ICAgICAgICAgICAgICAgICAgY3VzdG9tIG1ldGFkYXRhICAgICAgICAgICAgICAg
ICAgIHwgZGF0YSB8DQo+PiArICAgKy0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0rDQo+PiArICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+
ICsgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHhkcF9kZXNjLT5hZGRyDQo+PiArICAgICAgICAgICAgICB8PC0tLS0tLSB4c2tfdW1lbV9f
Z2V0X2RhdGEoKSAtIE1FVEFEQVRBX1NJWkUgLS0tLS0tLXwNCj4+ICsNCj4+ICtgYGJwZl94ZHBf
YWRqdXN0X21ldGFgYCBlbnN1cmVzIHRoYXQgYGBNRVRBREFUQV9TSVpFYGAgaXMgYWxpZ25lZCB0
byA0IGJ5dGVzLA0KPj4gK2RvZXMgbm90IGV4Y2VlZCAyNTIgYnl0ZXMsIGFuZCBsZWF2ZXMgc3Vm
ZmljaWVudCBzcGFjZSBmb3IgYnVpbGRpbmcgdGhlDQo+PiAreGRwX2ZyYW1lLiBJZiB0aGVzZSBj
b25kaXRpb25zIGFyZSBub3QgbWV0LCBpdCByZXR1cm5zIGEgbmVnYXRpdmUgZXJyb3IuIEluIHRo
aXMNCj4+ICtjYXNlLCB0aGUgQlBGIHByb2dyYW0gc2hvdWxkIG5vdCBwcm9jZWVkIHRvIHBvcHVs
YXRlIGRhdGEgaW50byB0aGUNCj5gYGRhdGFfbWV0YWBgDQo+PiArYXJlYS4NCj4+DQo+PiAgWERQ
X1BBU1MNCj4+ICA9PT09PT09PQ0KPg0KPkNhbiB3ZSBtb3ZlIHRoZXNlIGRldGFpbHMgaW50byBh
IG5ldyBzZWN0aW9uPyBDYWxsIGl0ICdEcml2ZXIgaW1wbGVtZW50YXRpb24nDQo+b3Igc29tZXRo
aW5nIHNpbWlsYXIgYW5kIGV4cGxhaW4gYWxsIHRoZSBhYm92ZS4gQmVjYXVzZSB0aGUgb3JpZ2lu
YWwNCj5wdXJwb3NlIG9mIHRoZSBkb2Mgd2FzIHRvIGV4cGxhaW4gdGhlIEFQSSB0byB0aGUgdXNl
ciBhcHBsaWNhdGlvbnMuDQo+U2luY2Ugd2UgYXJlIGhpZGluZyB0aGVzZSBkZXRhaWxzIGZyb20g
dGhlIHVzZXJzLCBleHBsYWluaW5nIHRoZW0NCj5zZXBhcmF0ZWx5IHNlZW1zIG1vcmUgY2xlYXIu
DQoNClN1cmUuIEkgd2lsbCBtb3ZlIGFsbCB0byBuZXcgc2VjdGlvbiBhbmQgbmFtZSB0aGUgc2Vj
dGlvbiAnRHJpdmVyIGltcGxlbWVudGF0aW9uJw0K

