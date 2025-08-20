Return-Path: <bpf+bounces-66100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1076AB2E3D4
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CBA7B3CC7
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9233A02E;
	Wed, 20 Aug 2025 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKto5T+k"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA333A011;
	Wed, 20 Aug 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710810; cv=fail; b=G43Qwyr2q9Hqqq5/dp/N5Wd+9qImUzS7sEb9kqKDO1PPuXd0q50iIYitJV+qlsZAohjItXUsdhKee19QSEqfrGeFcLmoJ0t/eDhovp9rGTZEx/gofv7KV2RGbx99ZLv9cU6Kel97ORoTtHStylwzq0s6qOBLlQAuARzwLzz7fFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710810; c=relaxed/simple;
	bh=n9zj22pJajDFmenkfIzZyC+r6yxQERdRIO52vUISvWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f8lqaWrhN9LzM+OkWCsa4e3TPRJyJeCk5SQbFTQw42vvDwmWZiB+NSuiaeutqRnrPEOXvXMMl7ZAHfev2eWDSivII9V+tQa87sofQpueY+BkSc7K9rBcROo6884HbEZxfdKO/7WKrzNeGKtsQTnGr2w408Zfqmf5R779jXGAWs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKto5T+k; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755710809; x=1787246809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n9zj22pJajDFmenkfIzZyC+r6yxQERdRIO52vUISvWA=;
  b=hKto5T+kkpK6eo/7mYv+r65yBPE707ameYlm/7CUy0gopzOBd9lIfU0v
   b9eoDUOvUTraHkw1jAZX7ESpSZKbUJ9PH62VKCC4EwX2YTlxcUYUn5wIS
   u7GKIeXQTJY25jFrVKJCwSFY4Lwn0ybJrVsnqHRIry95nhDfL+4TP0fM4
   08iP2iwnnTEjGTCOeKWaRclI4HHUQO9TIzkKYt80PF/lPc1KCzskOBpzg
   LHxC0LJiS3YiP11go18+SvJr1B3I2om0aYOz+my8/FPxRr1DlfDvh1Ta4
   +ElxvaaSMLYhG2XLIXxj6SepUpzrsmL0vcOcrBQ0FeyuFd2iyldoBDdaW
   A==;
X-CSE-ConnectionGUID: eiImoFUFSBClDFoCrvmKfA==
X-CSE-MsgGUID: 9LPHTsn/SSyApknGv4gv4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58134238"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58134238"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 10:26:48 -0700
X-CSE-ConnectionGUID: STgdtFU1T6S35zljbvINqw==
X-CSE-MsgGUID: duNuJYCERXKG0Qx9ZEttRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168129116"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 10:26:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 10:26:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 10:26:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 10:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAQknTC1OpvHcCYlHlwwxfB3+bzQIloZBs8snyLDR/m7yFHC/zr7eYiLxLRbPX0e1Io4HXMvH8yzEC0INsGZ4k1xxhWpVmf5QVGht4hGxqQSCyDVe1cbGuVmSBQczGDE2azUKm8PyruhyQ9GObXNPf0s96r9qBweqyVZGEcvwLCDvY+qe/xdLUensin/7gjdB+84iMybC8wTUspvKF6DJkFd6Tde/YEC2Gkk4NZSUR2rWuzZR8JB0sIHLGnog4nVDYS5YXidotwkiEfHb2xMrW96lFdoDF0vXHsfGt+QDWt3mJticOt+Y28pYkVtOiOThl6e7wNzSoU5GTrjALxmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9zj22pJajDFmenkfIzZyC+r6yxQERdRIO52vUISvWA=;
 b=op3cr9DWlm2TvcRJ44ZByoFsrS+nxpBen1Usq6o90hQb+gTjT66ot4C/P5rsydlTZcTgeoP7Xm2dxjCqb0WIkA034bQ2Anl4waH3SDMhjhKXqWTGbytfFd0D+d4hBuZ9hqigjDHRLNsd/1cBS7jIExMXCshDzU5GEh1QfTVDldkOxlRMcVTz75kEl4vH6JPj0t7QWyABhUO/Y405ZB9Y61jcikpXif1bNqszUrzapNScKxq2ZlgkqeU9Qpxes5o3wtX5kAebqcjErOclZEDxcpzqQQx9N9UIQTtCEqs8LaEWqUs/LxBijS3flxG4dCQ37V6qJIrT0rzz0xNvSDKKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 17:26:43 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 17:26:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "alan.maguire@oracle.com"
	<alan.maguire@oracle.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "mingo@kernel.org" <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "David.Laight@aculab.com"
	<David.Laight@aculab.com>, "yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com"
	<oleg@redhat.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"thomas@t-8ch.de" <thomas@t-8ch.de>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Thread-Topic: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Thread-Index: AQHcEc5LWQgc1WQMikmopLJo2+WQ07RrstqAgAAUyoCAAAPpgA==
Date: Wed, 20 Aug 2025 17:26:38 +0000
Message-ID: <62574323ba73b0fec42a106ccc29f707b5696094.camel@intel.com>
References: <20250720112133.244369-1-jolsa@kernel.org>
	 <20250720112133.244369-11-jolsa@kernel.org>
	 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
	 <20250820123033.GL3245006@noisy.programming.kicks-ass.net>
	 <9ece46a40ae89925312398780c3bc3518f229aff.camel@intel.com>
	 <20250820171237.GL4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250820171237.GL4067720@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6754:EE_
x-ms-office365-filtering-correlation-id: a0a6af71-a0ed-4013-68ca-08dde00eb84e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?enZRa1BaeVdUWVpFdEVraTZHQ0VvczlKWUE0VHlQWHhBa2JxZU5TdFhRak00?=
 =?utf-8?B?QUNpQWxjbFg0V010TmE0ZVN4eDNNblo4dVM2a1FWclhOZERjRzVOR1l4czhW?=
 =?utf-8?B?Q1dxTXNyZ1BlYmFIb1RqYXpoby9GSU1jWnJVZDMyeUZoamNvMWNwckRaUkpV?=
 =?utf-8?B?TTlFVEVEek9qYVBLVm93SnpWanM4a0p3djRUZjd2M2JZeVY4T20zeDM2QUJO?=
 =?utf-8?B?UzRZNGdEM2JWaXhER2kxRUROaE9wNktzWHptREExd1BXVGxBVkEyN3hTbVJp?=
 =?utf-8?B?VG1CWUh4QTl4RWMwdGdCcEtITTkzRDl5bEVKbUwyUTNuMUZOdmFYb3Yvakkw?=
 =?utf-8?B?VHYvSUd3V2FBQlFpQnBXckVVYXNONkwzU3RwWm91Y24yZmlMNFBtazVON1pC?=
 =?utf-8?B?d2YwV3hLbVFlUnRCSVJvYjN3Y09KQ3dCSTFHbmpXOFo0RzRXaE9hVGUwWGg5?=
 =?utf-8?B?cDhJVUFVeTNLUytnQnVPclhZaWk2QlVWYXJ3dkR0UC9ieVpkcWlnNWdUNjZp?=
 =?utf-8?B?VG10NEZNZUxNWUlrNXUwVDR0R2dZY1lDWVJsY05iZFYzTXdWMU1QYmtmSDlK?=
 =?utf-8?B?MmV4cEpUenNkOTg3L0IyMnhDTGpWSFprcDg2UkZhM3JRRWQ5T1RyMGw1dmdh?=
 =?utf-8?B?Wmk1eWxqc093VWZXSkYxUGlGZFdoYXhWMnRLTXZ1TXIxRXlXRUZ0TzlCb0dm?=
 =?utf-8?B?bUI1SFBBdExHRE8yOVdpY2ZwWmg0OVFVZmIwSUZ3OVRWNWRSc0tVekQzdlF4?=
 =?utf-8?B?UHJSaTEwUGNiOUlxblFFZU9iaUNoVHdMRGVoVzNsMHIxZ2lpVnc4bFNZK1JX?=
 =?utf-8?B?NkZLMHF3d0RhUkVxVFhaajN5ZHN5dVN1NzdxbWdWWmFDdlE3SnBnUzVzdkRV?=
 =?utf-8?B?dTZ3L3paMHU1bVljcW82Zjc2Q0NlcVFUWmh2ZGcvN0ZBS2pEelVoRHp4Um5D?=
 =?utf-8?B?UENBb0VIdGllZm81alVoSExYOWRDYkpIMUZUSUtFZ2Fab0hobnQraHpLbTRT?=
 =?utf-8?B?eHdjRWdIT3VmZmZPM0ZwbGVvVzFZWXNWNUh4NlJqbitlZktuMFBvQ1VvbVhl?=
 =?utf-8?B?MzgrNGtiZjF4Zk55c1Y5ZDJ5MnVDdWlhRlJlcGZ2bkJIMnJSUXp0aEsrQmZN?=
 =?utf-8?B?ZXlsb21la0dKZXUrS0ZTaFhSdUZaYktNV0FTc2R1MVRpWFcvOW9NSmZYdXc4?=
 =?utf-8?B?a3lPNlpIMUpwRENlRUJBVTlLcFNMQTErV2U5VnhEZlNmZFB6MWJac2lNZUNN?=
 =?utf-8?B?SmQrWVFFQWtLUkhRWmIwdk41VVFSdmFPbmhvTnd2T2lYU0lhdWx4R05yQmNM?=
 =?utf-8?B?KzB0QjVZOEdsR1lxTnE1RUlCdGNhU2JQdjE2TnpxK2laWDZqb0FacGRCZHMx?=
 =?utf-8?B?ZXB2VzIzSGxlM3QzMDVtcXcxeWp6KzA1cTdjT3A0dW92cDFzUE1oNFFRN3BS?=
 =?utf-8?B?c25NRUlYYmpiOEw4VEtPSWx2ZEs4TTJDbFRIU0lBczZLenhmVk5PM2JZZVFm?=
 =?utf-8?B?b3REbGZHYkpqSUlWcXVNWS9RT0cySmJabDhoSDMwaExDMHpBaEZtZzJRZGpF?=
 =?utf-8?B?cDlFQ2NDOTMyY0lCTUMvUVpFa25xcGZDYjhSMlFvTUYxSWtjZ1oxVjZaeWd0?=
 =?utf-8?B?clg0b0NkYkpDZHFlWHJ1MHpsamM1L2QzK1V1OHdVTERseXJtRGE1UFBzKy9V?=
 =?utf-8?B?bHZxUlZFTXppYXhwczFma1MvczczUUtxck5BcHo1RHlwRzI1S1NjbW92VDVo?=
 =?utf-8?B?ZkUvTWFoSHI2M0VUQVRTR3RwVGhkdUEwV2JPQ3pGYkVJVFZCenZEdHB6T0l5?=
 =?utf-8?B?cUJBQlVUVkV6UTkwYUhldlRuMXVHL0hFalNKVDBvOWIxVUVlMjEvUmVrdDJW?=
 =?utf-8?B?RGdxMllXRkFWOW15aXdJRHQwSDFGakFIdnA5YkZZTFJIUE83UUhNVjVZemdN?=
 =?utf-8?B?YXZyQldKWTRQajZrVjdyZEs0QmZtamw4V0tONm9KNnNlWklMSVpSekh0TnVp?=
 =?utf-8?B?RDRQM0djdGF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzFtRm15VEUyeU5yQjNPK0diTzBpZWN1aElTaE9KeVJGTWE1Z3Zka1VoQVlR?=
 =?utf-8?B?QXpaWXRGdzd0TU96NjFzcStkaHpQd2RJUzhHRndENGtac0pBcDJTTHNjU1pF?=
 =?utf-8?B?STFHS04vS0xCZncvZE1pNWVYekkzNHJmU080RnJmOWdXWE0yZnhmM1BjcE1P?=
 =?utf-8?B?L090UFhXWEJGQk9YeWUreFR2a2JINm1GdjRicXZ5clZHK3ZzdHlOREp1Yk1j?=
 =?utf-8?B?RWIwWnpTNjVIOE83SmRMNkpmL1lmdXNlbGZFNlAxMVdNdk84QVdBblR1Z3pH?=
 =?utf-8?B?ZVI3bjRKSUd2L0ZCNEo2bXNRQ2lZTFl2SVkxeHNMVDAwY3J2NnJHVnZZV2ZG?=
 =?utf-8?B?ZjhWdTJWdkJEOTBnRWhDK29hNnZmclNXQ1BYeVJ2cUh0VVpTb0VvMDh1WU85?=
 =?utf-8?B?UkNNWlRqTUZYT25aL0lNb2Rzb2dKTVk0NkUyMkZ2MXZTb1FtU1FkdXphTmcw?=
 =?utf-8?B?b2VHNjB4ekVjcndyRjlkSWEvRHVhWWQwZWJaYkc2THBFUm9tZnMxVE9EUkdH?=
 =?utf-8?B?SytPRUpuV2prOEF0VWpXT1lYME1iWXFlbWRubzRNZ0wzQll2VUxqVFhCbnVN?=
 =?utf-8?B?QjFCbFBHYVR0OFRzYm9VM1hpengrVVJVTDRiR3JraWwzWmNJejBaQVdTWm1y?=
 =?utf-8?B?SVhjY0F1MHRTczQvcDZNeUVKWTBNOGhlOGk0bEZXaE5vT3N5emNMK29vblRx?=
 =?utf-8?B?S1V1K1hxWmY5STRrYTZSa0gvUm9IQWRJMER0ZFdTcE9Zc0dPanJscnZ6T016?=
 =?utf-8?B?WEtyNzh0WmJzY0RKdXdhS3JzTStuVVdUUWdpSzNJV0RpekJ1OU1YbXUrL0Ey?=
 =?utf-8?B?dEVqWUkwWFMxVURSWEhVTWVhQnd4WkJQaG80YlhJK1Mzb01RaFZnQWlDY2hp?=
 =?utf-8?B?bUkrcnJ0ZEpiaGJuOHdLUytsdEg2NUtwSmZLTG9zenVpeEdRdFY1N3FWQnEz?=
 =?utf-8?B?eTdzbDM1cFMyZnRzVEdpU2FZbEg4Vm9vdmFRbDRVTG1tVFFza0M4Ull6cTNB?=
 =?utf-8?B?a0hLWEg3eVZmdEZVbFQybFdVMStYNmhucHUxdyt4c1ExQWd6ZmZqS3ZXUzdC?=
 =?utf-8?B?cnFYMUR1T1kxZHNwUW1rbGtCaVVvdUF5aFdkd2o5amttZ2YyR1Z2TEo0ZGw5?=
 =?utf-8?B?TXpLblJuUFpjNlNpUEhkNXJZVUJyUThrVlhDNlZhUlV2eTA4WWhCcUVyb1FE?=
 =?utf-8?B?eXNqN2JDSlNHaE1FZGhLdWZvUU84QjRMa25QVURMMDI0NHhrT1B1SEtTa0s2?=
 =?utf-8?B?WkxJTDhrc1k0cGNTenhYM2Z0Z085NWlpMnlwcEJ0azVRKzdGTFhCSGxwandG?=
 =?utf-8?B?Rm5ITkZmZkd1U1BhcFBsdktSSTVPNGNtOWtiL1ptRTJDeG5XMHZ5WU5vdTN0?=
 =?utf-8?B?RHNCTGw5VHpRNFVYam8xaURSbUUyeFhMSkJ4RG1oN05oNW1LR3RmSWgvWjFi?=
 =?utf-8?B?S042NVdUOFJNV2l2K3YwdHlqOTJyQjhFbklNSnlKL0VxaEFNQUxldnJQaTM4?=
 =?utf-8?B?OXEzZDJjUkFaMXI2QmtPMTBQeVczcm9rUjJwdjdzSDQzZWZRRTc0TEk2OWFS?=
 =?utf-8?B?K2JTVDRaUkpMbnJPMGlMR1dIRHcxeUpKUldDUWwrVjEzQUNjNUd6TTdTMXl1?=
 =?utf-8?B?cSttSEN6RWJUYmd3V3QwU2tMWEpoTFpXYmhJdmFqbzNwbnJSRUdRV09jMTMw?=
 =?utf-8?B?ejZ4MHFFUFFCT0duc1p0UldpWDU3aGp3Y3lLZTJUWTc4OW5yY2dzY3hQT0Jv?=
 =?utf-8?B?aUh0Y0krTkFTdDhGWmFvTWJaUktFbXM1azFUQVZHOHpya2dyMGNBNk1tNDMw?=
 =?utf-8?B?ckRnRExiL281elNWMGN3SDZYdmk0OWpBKzQ4aDNaS0M3T1VaSmxvVFh6TFJY?=
 =?utf-8?B?WWdGMkd4amxJVk85MkhFTWRkamZuYU1XZlY2VXpSQW1VQmlvUE5qOVZvR04z?=
 =?utf-8?B?QXVvcGdtMENjZnM5bkFqUE1aT1VzclpVWjJkQ2M4eU9ZZW5FYUlXeDlXcE9Z?=
 =?utf-8?B?RmRwK2hnREhNWi9pcGdndW1SLzlkakFpV1o4YkhKZGFkZXNFVWsvTzdOalMw?=
 =?utf-8?B?cXIraFh4cnBVS2lmWDZ3TkZLL1p1VVdybThkTXJ5WExPSndVREwzM09MRTRU?=
 =?utf-8?B?L3NHZkZ5blBrd3Y2WXEwQVh1bWhsNktpc2ZsSndJUzgxVnc2eTBVakFhbHUz?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF0A7952F528194D844121D86FE79FFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a6af71-a0ed-4013-68ca-08dde00eb84e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 17:26:38.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNR+KU2P+xpfzx4t3e0e7gifFGSagRRDfoHunR8iCB7XJbDv0wlqHHoJpEODadE8+sR+7seyZ4RvazbMTNwuo3jr61haDiRANVIvJRLlgbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA4LTIwIGF0IDE5OjEyICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gPiBBcmUgd2UgZWZmZWN0aXZlbHkgYWxsb3dpbmcgYXJiaXRyYXJ5IHNoYWRvdyBzdGFjayBw
dXNoIGhlcmU/IA0KPiANCj4gWWVhaCwgd2h5IG5vdD8gVXNlcnNwYWNlIHNoYWRvdyBzdGFja3Mg
ZG9lcyBub3QsIGFuZCBjYW5ub3QsIHByb3RlY3QNCj4gZnJvbSB0aGUga2VybmVsIGJlaW5nIGZ1
bm5laC4gSXQgZnVsbHkgcmVsaWVzIG9uIHRoZSBrZXJuZWwgYmVpbmcNCj4gdHJ1c3RlZC4gU28g
dGhlIGtlcm5lbCBkb2luZyBhIHNoc3RrX3twb3AscHVzaH0oKSB0byBtYWtlIHRoaW5ncyBsaW5l
IHVwDQo+IHByb3Blcmx5IHNob3VsZG4ndCBiZSBhIHByb2JsZW0uDQoNCkVtdWxhdGluZyBhIGNh
bGwvcmV0IHNob3VsZCBiZSBmaW5lLg0KDQo+IA0KPiA+IEkgc2VlIHdlIG5lZWQgdG8gYmUgaW4g
aW5fdXByb2JlX3RyYW1wb2xpbmUoKSwgYnV0IHRoZXJlIGlzIG5vIG1tYXANCj4gPiBsb2NrIHRh
a2VuLCBzbyBpdCdzIGEgcmFjeSBjaGVjay4NCj4gDQo+IFJhY3kgaG93PyBJc24ndCB0aGlzIG1v
cmUgb3IgbGVzcyBlcXVpdmFsZW50IHRvIHdoYXQgYSBub3JtYWwgQ0FMTA0KPiBpbnN0cnVjdGlv
biB3b3VsZCBkbz8NCg0KUmFjeSBpbiB0ZXJtcyBvZiB0aGUgImlzIHRyYW1wb2xpbmUiIGNoZWNr
IGhhcHBlbmluZyBiZWZvcmUgdGhlIHdyaXRlIHRvIHRoZQ0Kc2hhZG93IHN0YWNrLiBJIHdhcyB0
aGlua2luZyBsaWtlIGEgVE9DVE9VIHRoaW5nLiBUaGUgIkFsbG93IGV4ZWN1dGlvbiBvbmx5IGZy
b20NCnVwcm9iZSB0cmFtcG9saW5lcyIgY2hlY2sgaXMgbm90IHZlcnkgc3Ryb25nLg0KDQpBcyBm
b3IgY2FsbCBlcXVpdmFsZW5jZSwgYXJncy5yZXRhZGRyIGNvbWVzIGZyb20gdXNlcnNwYWNlLCBy
aWdodD8NCg0KPiANCj4gPiBJJ20gcXVlc3Rpb25pbmcgaWYgdGhlIHNlY3VyaXR5IHBvc3R1cmUg
dHdlYWsgaXMgd29ydGggdGhpbmtpbmcgYWJvdXQgZm9yDQo+ID4gd2hhdGV2ZXIgdGhlIGxldmVs
IG9mIGludGVyc2VjdGlvbiBvZiB1cHJvYmVzIHVzYWdlIGFuZCBzaGFkb3cgc3RhY2sgaXMNCj4g
PiB0b2RheS4NCj4gDQo+IEkgaGF2ZSBubyBpZGVhIGhvdyBtdWNoIGNvZGUgaXMgYnVpbHQgd2l0
aCBzaGFkb3cgc3RhY2sgZW5hYmxlZCB0b2RheTsNCj4gYnV0IEkgc2VlIG5vIHBvaW50IGluIG5v
dCBzdXBwb3J0aW5nIHVwcm9iZXMgb24gaXQuIFRoZSB3aG9sZSBvZg0KPiB1c2Vyc3BhY2Ugc2hh
ZG93IHN0YWNrcyBvbmx5IGV2ZXIgcHJvdGVjdHMgZnJvbSB1c2Vyc3BhY2UgYXR0YWNraW5nDQo+
IG90aGVyIHVzZXJzcGFjZSAtLSBhbmQgdGhhdCBwcm90ZWN0aW9uIGlzbid0IGNoYW5nZWQgYnkg
dGhpcy4NCg0KSXNuJ3QgdGhpcyBqdXN0IGFib3V0IHdoZXRoZXIgdG8gc3VwcG9ydCBhbiBvcHRp
bWl6YXRpb24gZm9yIHVwcm9iZXM/DQo=

