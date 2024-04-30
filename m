Return-Path: <bpf+bounces-28229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6E8B6C6C
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3711F23123
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B946845026;
	Tue, 30 Apr 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjymvCu+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609D405F2;
	Tue, 30 Apr 2024 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464245; cv=fail; b=l7dsBhwfJ0A+PFKpvQlypUmIJfL+Jm1KPIKjAaZ+QzTs+TQSMl3NYGeymH7Dr2z2nJZeVtDf+WFOyYMDTl6TbZ6LDu0iuFky8FvnV2pBhLmJToMK5WvPExpxQO+1P9u1BDmc7VFUSNhEJHUHo8+9pjoDjr090Qnhp3sxq5+B5Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464245; c=relaxed/simple;
	bh=yryIbg5N9fgRM4qS/ao3BKY6guUPc9PtoH/jrD14kCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tvhy6b7Q+MSsGh0EHvCIFH32GGhyZacwzJMDPvEbFrYWl8gfE8LJQbnllEaLBRtXcuFD7yQ0TgDWAwIoq8tcSW18m2Dq+1DBwlA16qF3HAM5Yfn1UUPTljLiloXb1HgIzVGHqC5hFlpNKMq+jGLBMDXpCTU/QfDaDrabqm923ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjymvCu+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714464243; x=1746000243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yryIbg5N9fgRM4qS/ao3BKY6guUPc9PtoH/jrD14kCA=;
  b=LjymvCu+IGafoiT/kiRkKEf+xvjRoHYZPGRIwsrwaSYfu8yFbdRH3m2f
   i+OYVQYhRxVSZXzj2/q/QgmxU5qIv+DPerX2ANnpej3K5QlSkfYYX0vDX
   2BEXalIDrgYPocI8uCAQlmAkoCFCcH9XJNDAD+T++yI61LPlYC/h2DWwe
   MJPQKwKXXKQpDQhSzXbAGQ3AHdEIQ8EL1R0m2EQdCBeHIlk+fUXugjb/K
   E3VWwnQslJzzoEZoTUbk94dLbwuwY4ZMysC1lAZxW9yqqCnQuaj9/oSJj
   chscFf1x4AQbic8pe1jcre0XH/p8hnHbXcdZssXWW4ihbWnYX9iED0qEh
   A==;
X-CSE-ConnectionGUID: IzeC6d8XTSuI727ohVw3fg==
X-CSE-MsgGUID: kLJfWerbQPeAt9sDyCtg1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13949935"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="13949935"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:03:56 -0700
X-CSE-ConnectionGUID: a5nyohuHTDyLIre5PEOXUg==
X-CSE-MsgGUID: puvMnuvIQ2GzDfsGwRlU7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="31181783"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 01:03:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 01:03:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 01:03:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 01:03:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 01:03:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHwIrNfOTV1uzFpzLjTUL1gP68WplWDzhmXVH/9/WPpXT0xEJ3bNhB2JQO4bTpA8bw1iyhbWvMUZ+2jF/Gt7ukEe028zfaLQuE2a+J2t1ZwSYz5tUSlXYV9yX47KzXeSs/gOKmM8gp/OQkqzhmnHe9Pa6vD0GksLv+RB9R/FsV94ELImAopBcvFd+h7y2hTNW4OfQLuGPQIb2+rxsO8gyHLZ1I48C0mbCuoLGyet5pIcBMFEbun/WG9lhTfaBDMRDY5yxlpn4Uzrg1PtzxwwzDODY/+06kS/1GeXRqcODW7lxqUTFtu5yCrq22GJzlFBIH1Y7isUDaL+S0ll1qj8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yryIbg5N9fgRM4qS/ao3BKY6guUPc9PtoH/jrD14kCA=;
 b=ET09JP4gWn8/tujgg4/eqHdZcGC0GatatFbt5QHGHNWHNB6QST+YSYPVZvI9JlfNhf9NMXohyEdrC/dKCnZHnFPLQQ6NT+GeK7JvAUbG/YB1lF0WOii5w1XRYak/3cBZCSl7NtNdMOtnGZwrBDaFQ6jF4fjz6vlYwivCVcx1iuLbmy3QaMN4QQgz4evoobmPAM04CyslRtxDdUPqYv5dmFj3AWjAe714R5TwFvox1UmQI0SNYTp0kjzlWt2aGmvZANF0OXdV7vXYxAM6FQ03Ff8IB7g00y1zBk7znrpsWAVJp18ijmMp/k7wQGNtzS8Eg2Jk2Z8wuUfxgUHNncml1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 08:03:53 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::8d5:f5fa:18e4:fd1]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::8d5:f5fa:18e4:fd1%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 08:03:53 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: RE: pull-request: bpf-next 2024-04-29
Thread-Topic: pull-request: bpf-next 2024-04-29
Thread-Index: AQHamnpEOFI10V+QdEGn4h+3Mk4UOrGAdBsw
Date: Tue, 30 Apr 2024 08:03:53 +0000
Message-ID: <IA1PR11MB651407F2096883B6C22888CE8F1A2@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20240429131657.19423-1-daniel@iogearbox.net>
 <20240429132207.58ecf430@kernel.org>
 <799ac0bf-30ba-c9ab-ae10-1a941fa0f90f@iogearbox.net>
In-Reply-To: <799ac0bf-30ba-c9ab-ae10-1a941fa0f90f@iogearbox.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|SA1PR11MB8255:EE_
x-ms-office365-filtering-correlation-id: c873ed20-43ac-4d4d-0a3f-08dc68ec13c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VkdySkRLbFF3VHVaZy9XbHlYeldhRWVCNmJOeVFwdC9CODF6YjJoY3dyMko2?=
 =?utf-8?B?YWhYbk91dEUxNlhIOWNIU0JsQVNkVXRTbHpkQ1RnK2NTWlRueWpJbWNIazgw?=
 =?utf-8?B?cEFmb1BuK1RjZVkyTTlwNTVrT1NGNE8rcXRBYXZVS202UU1oVlZzdUkvdWZO?=
 =?utf-8?B?SWViQTNvSnRjQmlYTlZWNmxIYy81SzIwWWg0a1N3WkxSSE0wSG0yeVhoa2lC?=
 =?utf-8?B?WGtvMVQyYUYwbmU2MGJNVDRjczJ2K29rRW00STgrb3dlaDNYNVkxUEgrMVpW?=
 =?utf-8?B?ZVg3bndRUkg5c29tdkpSeU1PbVQrcjY5bjBNdTN1b1dJeEYyaFpYV2w0MkZn?=
 =?utf-8?B?eGc3VDhsVHdUanVsODJ0MFIzWncxYis0TnIrZ2EwNEVweFhwWkZzU01FdEVx?=
 =?utf-8?B?ZGNCcURndkVQdUlyY29DMjdIbGgycDZDRUdoSkxXblB2L0dwWmdxQnFLcVVv?=
 =?utf-8?B?dHBZWkQrcUlRZGEwOXh3SGtoMndSVnc1QUFuU1pTYy9pa05EWG9PNFROcGlW?=
 =?utf-8?B?ZndkVXYyRnN1RnlrZWxiR1FFYmV5c0JwbHZMdG1Mb3N4SHBFeVlSMUpUbG1S?=
 =?utf-8?B?blRSSjErYnU2SXZTS05NWWJ6UnJjSkRFR2d6UDRKYUpvcDZscVc5UkNWM0xh?=
 =?utf-8?B?akxKVnNsTkJ5VjVhdU4xbnNJM29JREY1azdXMGRoMkNXeGJKRnV4WGZ5UTBL?=
 =?utf-8?B?dGZZRmlWQkZyMlVvN2RWS0s2L05EUlBmekt2STlPLzIrQ3kwRkNTQjFhZ2V3?=
 =?utf-8?B?OFVqYzVWbFVPdTc0WC9xbS9SNk1LQzBVNUZJT2E3M25sdU9KSjBVZzhDMkVG?=
 =?utf-8?B?ajRUbzhpUVZCYUczcWsvWDJtbEZpQ3Yzc3FvalkzSGZ5MTU5U0lUZ0JhZFJT?=
 =?utf-8?B?bW1kVEN0SGR1SUZPbmQySnRIYTJSK0dBQ3ZwdU0vY0JNNkVVL0phZWRiR25I?=
 =?utf-8?B?K2V2cXJxcEJaZTlSekdWUERnWGFPZmY0NzRZbjVtcmsyVlA3MlhNN20wemNq?=
 =?utf-8?B?R1dYU0hZZGhMdWRVa3J4MUVmNEZKcS9wNXdxekpxWDVkdW93R2orUE0vRGRE?=
 =?utf-8?B?UVBta2VJOVk3T09ZTytJVnRiVkFRdDV3UXdlZDRGNTNrTU5jb0NGcnFSR0VD?=
 =?utf-8?B?Z2VJY2Q5NDdjOGFvUFdsUXZjczFMWlVCamZvNkNyUFgxc0xXVGYrU01lcFcx?=
 =?utf-8?B?NkhMUTR0RDhXVUwySlVKWVA1NlVWSzFKb3paOUwyYTBML1hHSXRaM2d0MytT?=
 =?utf-8?B?Y3BMRlg0cE5DUEs2Y0dkVUl0d3ZwQWw0cFg1Ujhta3hkV1Z4OFdZcjloVEUz?=
 =?utf-8?B?a1pXZ2Z0akRRc1ZMQXNKNitwZ3U4ZUxSdXBYcisrOWN0QXFPMXBoQ21sWGhz?=
 =?utf-8?B?RVYyMWF2T0FyWU9SNmpmMFByZStOeVVwdEtpWGEyNFcwY0MyMG95UjR2aXlJ?=
 =?utf-8?B?WGdyblkwcmZ1MWZGbzBuOS8xdE5VVmc2alhGTFJuek5ndFhaZGVLNU44U21i?=
 =?utf-8?B?ekxvVjJuVGs4bGcrQnFvSEJYWTl2b0hVdWw5djBnMmd1a3JpLzI5QXdaQlh1?=
 =?utf-8?B?UE5kKzVNc2NoT2xtVEVCbmRCdUxwOVJteEFYU0tVcWY5WDBrRjltWk1TbU1q?=
 =?utf-8?B?ZExaT2owRU5LU0ZPQWpUM2tXT1BuRmV0UGNvL3NUOFJUS2ltSm1SY0hUMUdx?=
 =?utf-8?B?bTRpK3pBd3JreHIycXpUd2U4SEpMMUptVWFlSG9Kc3g3RUpLZjZNZzkreHE2?=
 =?utf-8?B?VG9DR3MrTnU1eWJpQWszK2lma3lvRExzTXhUK08wZVlndnRNVEVoZTJUZXd5?=
 =?utf-8?B?Tkw5S2pEcG9OUDFjU0ZVdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0pyaHJLaFlKOG1xeGN0bjRrUlJIaE4va1ErUFgzQ05Ta1d6WTAzQjJYVXhr?=
 =?utf-8?B?SUZ6QUlLa0c3NWwxL2g5VHl6STVkaGVQWkhJeEhUdWZGZEc0NFNyMjBKSHNy?=
 =?utf-8?B?V0RmSGxxaUJ1M0c5T3R1ZU0xU25TU1JyYWppbk9tTTJvZHU0eGxsNkExMUhZ?=
 =?utf-8?B?ZUFRdzJqYzEvaG9xbVFpRDVlcjFTWEg5NDd3TzltRkFzTWNPNnBnTXJqSUZR?=
 =?utf-8?B?ZW5iSGRITFJqMFkzWTJMV1k2eEZNRU9vaGU5b0RETjRJVVJTTS9yaDR3WDVX?=
 =?utf-8?B?SzlKSU5qbEtKcno3SDFKUjVIMitQVTdVdk9haTl1RUg4UXBVQ1pCSm03VW9T?=
 =?utf-8?B?aE5aTGc4QVBtbnZ4TkY5a0tMc0doOXlIZmNrcVd6L0YyZ0RVek5kbmZZQnhV?=
 =?utf-8?B?NlpXUkZCd2xabU42VFRWK0NiMTBUYWl4M01ReTBUZlNTQ3RRTjJkSGpzWDdi?=
 =?utf-8?B?d1lPb1lVWEpHV2l5OWtieVlVdlVYRVViNXRQbC9FNjlTNzhvUTJOY01LRWJV?=
 =?utf-8?B?WlZ3RlU1dXJ4Y3BiM3pZTVNLMjJIclRjOUVNdkhlYkIzWmFmZ0VYRWRwcjFG?=
 =?utf-8?B?bVpEbGpKVEFITE91KzU0NmRKUGIzU0swS0pBMzFZc3NZaEsrZi9FYWtOcFJ2?=
 =?utf-8?B?Qll4N0ZkT3JIck5JZDAydnBZNzVSSmNqT1lkZ3BFSWU3TEhYNnF6eWZDcEkr?=
 =?utf-8?B?a216ZXIyZ0w3RDBLemhMak5iOXpNY3BhcCs1alY4STBxWE9tMERkY1E5V0ZK?=
 =?utf-8?B?aGUxQS9CcFF6Y3R1RmJIR3Z4OTVyQnlyakZBRUd2eFhKVGl1RzRCcjRMeDhV?=
 =?utf-8?B?clRyQk1xdkIreTFSRGIrR2hQQTRhYUtGcU5rR2Y4Y3kwdmtMcG45dkZvdUFI?=
 =?utf-8?B?U2NDdUtYWnk3aFRpTWVWSHpSU2FOVTB4TEFaTUtBQUMxMDB4UzJsTUtSYklv?=
 =?utf-8?B?MTVGZkgxd2FVUzZaNy9DbU9EUGZFMTh4YjFBcmpKU2xmQW9UbGt2TlRsaERI?=
 =?utf-8?B?b3RoMTkxOGFReWhMQm5JRWU4c1VkN05Zc3BJUlIzUmVxdUJVdStGZWc0Qkx6?=
 =?utf-8?B?NG5rOVlkVitORTNLUHM2U2kxaWc1Y1FESThOYmoxbG8yOVl4ZTU2dCt2aDVy?=
 =?utf-8?B?T2RVUkQrVUxXWTBMWGdMb2Rlc1lHNzhZNWVjTWJiblhsK2ZHb2dLOUk5RWpX?=
 =?utf-8?B?RTFzdk9JMXdhQVd3OVYvWTd3bTZYTTU5aXN5WjZYS3hCTUpIUzdPbk43K1pt?=
 =?utf-8?B?dDZqUzNCTmMrODRjUTcyLzFzQU85cEt5RSs3Yy91QWF3aTd0RDBFcGduNVNs?=
 =?utf-8?B?c0I2a3pWOTNjYlFDNTZJS1g4QXpKUkkwc2tUZGdFcU1oNG52NzVHMU9iYnZF?=
 =?utf-8?B?OEJ2aGlUNllqampYU1pIbmE1VVdMOEJvSHlRajlzZE9oMndNR0FtRlJvd3Y1?=
 =?utf-8?B?cld0WWROc29GZGFHd2NvWTdhS0tOZldjTWlVNVpRL1BKUVdpdFgxMG5vL0p2?=
 =?utf-8?B?RHF0dm1xWHB3TG9SRk5xOE1ldlRTRXJJbHN1TjIvRVZmQkVXcytkL3JsaE54?=
 =?utf-8?B?MDNBQUNKV0tVQTkvU2s4UHl6TzFTNUQ2NUV5NGs3bnREbVNvL3NBbCtwUjQ4?=
 =?utf-8?B?K3lNZ2JOQVMwd2Zrb3A2alJvRy81SU1MSU9RZEtMZVo4RVFqZEF3ZkVLR0tO?=
 =?utf-8?B?T1o3dEVSNjk1ZzBQd3FlVVNlQmNqRU5xZkxPMVZNc2x4bS8zckYvMDVMZGk2?=
 =?utf-8?B?cjc1SGNGMERTUE9GSFBxeUZSTzZOV2lrdGtXa2tLKzFzNTcwajhKZS9JKzJD?=
 =?utf-8?B?SzlrNEJIUG1oTmZWUDNUdm9wVmE0d21WaFdZY3FLblk3aUpHaExzQnVCNy9k?=
 =?utf-8?B?VkZXRVA4TGpzRUVyWnlua2E0T1lqK21aeThTTTRTelU5dnFieXZBL2plcTJk?=
 =?utf-8?B?ZVVyTnRCWi9uRlMrQ21WdEp3K3g4MEl5eXlDTEtRZm01aG1Ya3ppb0tRMnNz?=
 =?utf-8?B?RUwxc0FWZnhmcVkvaG9wUTd4b3N0UitHbVhLV0Z4RERiSENXV1BLRURZKzNI?=
 =?utf-8?B?d3I5Y2Fnd0g4RlJYelk0RXc2UGhPZEtKcHBubzd3Rk13ZFZhVjlDWW9MRkQ0?=
 =?utf-8?Q?fpi33AhtIl2DRqpm8AhTLUBVG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c873ed20-43ac-4d4d-0a3f-08dc68ec13c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 08:03:53.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oc4Spy24UELxSch6oeSP5kIS055yQiOEvOoVwhuLWyV5ocot4O9ntp+Rfgv5uUA3Uk3Qhus8QX04TMIkCafzq9bPAx5NnPgLZXw17cAgYBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIEJvcmttYW5u
IDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMzAsIDIwMjQg
Mjo0NCBBTQ0KPiBUbzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4NCj4gQ2M6IGRh
dmVtQGRhdmVtbG9mdC5uZXQ7IHBhYmVuaUByZWRoYXQuY29tOyBlZHVtYXpldEBnb29nbGUuY29t
Ow0KPiBhc3RAa2VybmVsLm9yZzsgYW5kcmlpQGtlcm5lbC5vcmc7IG1hcnRpbi5sYXVAbGludXgu
ZGV2Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBWeWF2
YWhhcmUsIFR1c2hhcg0KPiA8dHVzaGFyLnZ5YXZhaGFyZUBpbnRlbC5jb20+OyBLYXJsc3Nvbiwg
TWFnbnVzDQo+IDxtYWdudXMua2FybHNzb25AaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogcHVs
bC1yZXF1ZXN0OiBicGYtbmV4dCAyMDI0LTA0LTI5DQo+IA0KPiBPbiA0LzI5LzI0IDEwOjIyIFBN
LCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gPiBPbiBNb24sIDI5IEFwciAyMDI0IDE1OjE2OjU3
ICswMjAwIERhbmllbCBCb3JrbWFubiB3cm90ZToNCj4gPj4gICAgICAgIHRvb2xzOiBBZGQgZXRo
dG9vbC5oIGhlYWRlciB0byB0b29saW5nIGluZnJhDQo+ID4NCj4gPiBDb3VsZCB5b3UgZm9sbG93
IHVwIHRvIHJlbW92ZSB0aGlzIGhlYWRlcj8NCj4gPiBIYXZpbmcgdG8ga2VlcCBtdWx0aXBsZSBo
ZWFkZXJzIGluIHN5bmMgaXMgYW5ub3lpbmcsIGFuZCB1c2luZyAnbWFrZQ0KPiA+IGhlYWRlcnMn
IG9yIGluY2x1ZGluZyBpbi10cmVlIGhlYWRlcnMgZGlyZWN0bHkgaXMgbm90IHJvY2tldCBzY2ll
bmNlLg0KPiANCj4gWyBBZGRpbmcgVHVzaGFyL01hZ251cywgcHRhbC4gXQ0KDQpTdXJlICwgd2Ug
YXJlIGxvb2tpbmcgaW50byBpdC4NCg==

