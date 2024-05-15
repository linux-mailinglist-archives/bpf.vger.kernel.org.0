Return-Path: <bpf+bounces-29718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B798C5EB1
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 03:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211DE282579
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 01:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2B1FB5;
	Wed, 15 May 2024 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9uMAsyr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FDA63A5;
	Wed, 15 May 2024 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715735408; cv=fail; b=OkrghQx471ZGkqiaN9IMMNFjIDS1XJgY/XfFe7XV/bE4b3h2BVyoEyU+h2b8AQZdrKh5sAN9zZcUCdQ7r5hYuxttd1l1hGcvySI+3N7MPvQYxUki2hIv2R3jWJC7fNuiHwyDoq3/8Sw2pROxOrKFQZkxe7aaoHGVLWDw5mWO/+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715735408; c=relaxed/simple;
	bh=lVKGc4LJmoVQYgpTsC/Y4dumuev5YZiRAulxPdnKG3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocINwBmKFxMMeKj8gzxk43svSkCLogXm7y2zKfElpABsIxd0+7qW+MY2Qinp+7YT/RkX01b8CFgdUzbtWyVdr3AJBpYrQSqe8ZIigv+y3lA1dE+g5cDti870k+QVssVd2pIYS5lC2BBpDMukxdVYPVv7yCFLLJ625sLvXIVpvL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9uMAsyr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715735407; x=1747271407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lVKGc4LJmoVQYgpTsC/Y4dumuev5YZiRAulxPdnKG3o=;
  b=T9uMAsyr2hSaeC5wsWNWT028qr5xJvEbbVHTNBilbO1VndqtfeTQyyOC
   yrWxmtbpSB/S1FSJi3ciE3dCAMtRPcI+lzDDVnpqVPGEIc9IM8HcgRtub
   9GpEw2CcQ6+tnqBS5Cf15jFuKnMUfRUhPGEDQIrwT+4yaMv20U7eZElwr
   ha6AzMVSVZwf3t9EHix/R+IvcWWLSTxYs/GXqy4J/PjFIqH8NvU/vlUme
   IqNx1Ru+tI0IHpYiTgdgYgiVPtX8wAGDOQr+w9kl9vNpOz3EM1X6iGtt2
   0e43j83QXSyTnOEnR3jtrFBTLxCnRCCM3dxlzc22YW9pBacIV8pcr3T5z
   Q==;
X-CSE-ConnectionGUID: hd4LdqIrQAaV3OlE0qFWdg==
X-CSE-MsgGUID: Nm5Yw0iiTvuQr10DdVILbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="14703007"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="14703007"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 18:10:06 -0700
X-CSE-ConnectionGUID: Veh1SN0dT4Wzrf6TECah9A==
X-CSE-MsgGUID: yKYi0549QcaJPToXclL5QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="68337240"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 18:10:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 18:10:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 18:10:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 18:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgEdWycY1tUoCiPNeOvsyzoprcsRInRuLxuG0NAZBWn48sOHjEfBqFB2q1y4YGEADytH5PtawYsiLEQ7zwUseEaY2iqSpkDE7Cm7+PqWyf/f7AA9i3nPqH16kqlJ8rYIf1dGltVh7OAVnxN3VwxbtgkKjs8e/X4h+CA9LadCr5C+PQtJ95xl6DcrFtDcIGNOmkE49dMZxIqjvE5C7XFimgA66g3ivgHPhdiWhjXgSlc4WNTq2LWA0rqspdCYXw2f6x/FNzOK0qB7q6/H80GFd6Rl0W9ByrZh7uW3nEZgXBMDPZDUMhD54KfpHfv8hovRiC5pxnwcTX2qVKRgDoU8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVKGc4LJmoVQYgpTsC/Y4dumuev5YZiRAulxPdnKG3o=;
 b=DkkGFQ5ixxtuVvyg5d4OU8K0TRfyQLErFy6KvxjHodxbRf07hGAWW3TUHx2hnk/PorYan9zjYW2a19JStULvYy/LJelvOe+sZbjJv0oA75f+LobRQxsE9f/xD9f/Rzn6I0pczz5Nes5Hg1s3GQO1w7v3n2RpU2Igq+FHV+jCtJA5NeNNXSrFOkJN2swm/dQk2cmwYpE3fsMfMkbXAkIz/rOzRUGlDjNLc+dNd31fcmFBo/1a0TIHOz5IFaVReXUj/PS/0NPOn/C/M57M3ewX2ihCDyF8TWp2hqnPPbHlZlkXiFXRMI7eLupAtdUKg90pdNbE6/M9912mcXWS3BE8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB4977.namprd11.prod.outlook.com (2603:10b6:303:6d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 01:10:03 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 01:10:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "olsajiri@gmail.com" <olsajiri@gmail.com>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "luto@kernel.org"
	<luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-man@vger.kernel.org"
	<linux-man@vger.kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
	"yhs@fb.com" <yhs@fb.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Topic: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Index: AQHaoGz/NDbwXOtepku5mG5JmKvX1LGMCSqAgAKMVwCAAIRoAIADdFkAgAJm6gCAAHtzAIAARi8AgAHRkQA=
Date: Wed, 15 May 2024 01:10:03 +0000
Message-ID: <3e15152888d543d2ee4e5a1d75298c80aa946659.camel@intel.com>
References: <20240507105321.71524-1-jolsa@kernel.org>
	 <20240507105321.71524-7-jolsa@kernel.org>
	 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
	 <ZjyJsl_u_FmYHrki@krava>
	 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
	 <Zj_enIB_J6pGJ6Nu@krava>
	 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
	 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
	 <ZkKE3qT1X_Jirb92@krava>
In-Reply-To: <ZkKE3qT1X_Jirb92@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB4977:EE_
x-ms-office365-filtering-correlation-id: ffa9066b-d334-4cb3-7261-08dc747bc008
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Sy9pazlmR0NNOGcwampLNCtVbHRWSDl4Y1JnTzhMblQrU05uWkg1S25GZlJt?=
 =?utf-8?B?Qk5ZZkdqWVhxa3A2eThqbkZTY3gvTzdpVWF2QUpKUWxQVUZnSzU1N2h1blAz?=
 =?utf-8?B?QTRBeG9kMTc5YStFb3JmWmxDb2VpaEhNZ3ZETlJhZUhSc0RHVVN0cVNUc2dP?=
 =?utf-8?B?WnRzTU1OUXhEUlBqNnB3RlBVaC80empJL0dlYnNCSEFWaDdiSlVJWjIwVVpI?=
 =?utf-8?B?SlZkcTRLZVVETG96dkFrT2ZDWHp2K2FhSXlsemx2VS9mRVQxRE5TU1ZoZzFs?=
 =?utf-8?B?OGNQMjNaY3hQRlFsaGZzWEF0b08ybmZvSWpKaTA4SnIzOVl0MTlHY0c2YTJJ?=
 =?utf-8?B?Skh4bXFkNURlOHc4QVdtVHhLRFJzdERHQldmbVhJZ0NXZU5FMTRlNVU0ZDl4?=
 =?utf-8?B?bGR0NHBQUjhTNXRnbFF2NkU1WHJRV3VRT2FYamwvMmhQV3hSdUJka2kwakRv?=
 =?utf-8?B?QVFFL1JlN0JCNk5Tei9MU3gwYzc2Sk1yY2NYOXQ0UXZka2N4WGN4YzZPQ0cy?=
 =?utf-8?B?NHhjRmNmSEpsTEtRUzN6b0V0Ly9qcWczWG52dVhxNjd3Q1JkdXp6cjg3Ykhq?=
 =?utf-8?B?WVIyYWEwUlJMYVVhMXVRU2FrcjEyNC9jYzFwdk1ZL1dJWkVZRWR4NmJQNmpz?=
 =?utf-8?B?T3dpakxxZmhZd3hERFBIUXA0MnVoK04zQnVsSmRDb0lIL3NLN3pSVHdMRUd1?=
 =?utf-8?B?NGp1WnJSTzRJZHFpSjMrQzBOU3pRK3F3NnRCU2tEUHpOWXZXS0hyemNXcDlF?=
 =?utf-8?B?eE1ENFJhN0Q4SEE4eCtNYVdLR3dTRkhJRHpyaHcwY0JoR3I3WEpkL1IzTVl4?=
 =?utf-8?B?a3RQL1l3c1oxMXhIVEpicVN5K1ZWTWo5UTN5REtKd2VmTTNXVU51MWJtbzdY?=
 =?utf-8?B?VkxnYVEyalpjc1JIemFna0hBaThTVUN4dTdVbE9hNjNFby9GYUUvRHYyZjhi?=
 =?utf-8?B?WGxnTmhtMTZ6ekxCejhPZmZGL3J3cXEyTUh1dGJGRHVDdGl1Rk9wTDFkUk91?=
 =?utf-8?B?VTRTdUp5RzQzVnhFTWp2TE8vT09xdkRRVHFIbEhwMTloMHpZZjREUERsYkhv?=
 =?utf-8?B?emtXQ1F0YWFtbTRqd0t1YzJOSENiRDYzbkdaczVEWUttMVE5RGJ6V0lGbmpv?=
 =?utf-8?B?Zm91cDJpbjZDOFc2NkdnUmlFeUxCd1hReGFDSWtaVnV0L2YrNUpyZUROaVhi?=
 =?utf-8?B?MFBseVhZek9xSkt1Qk5xUDlCVlJnbDdnZVFBaHFFWnFqemUwaHF2WkIyMklN?=
 =?utf-8?B?SGhRVlR0TkxwU1dZSUxyRXRKclQ4OWxMVkRrcS8vZjNhME9vRTNPM2tHQWZS?=
 =?utf-8?B?Sm02RVhUOTJrMElKVW5VVTJJMDYvaTdkVk1yUjhIZmRDM0RiL2d4dCtKNDBF?=
 =?utf-8?B?M0FOclJEMnRHYWdlQWk1TitxY1VrdTZialJWMVlsZmpESklYek93NEN3ZWps?=
 =?utf-8?B?bSs4SVBRWndtcmJwUUk0Z2YvMmJxSnFrUmxOM1dURnR5MitYbFdMU0J6cjAx?=
 =?utf-8?B?MmJFdXM4ejdaRFNoQ2tGUTdDQUVIeEZCa3dpczcreUdseUpBQUptMVpHbFIw?=
 =?utf-8?B?a1kzNklSMHdsTG1ndlFYMFlBdGtUODlWVE1COXl3QmRUMm9vQWV4czNHNHZi?=
 =?utf-8?B?RkRyMkIweENrRGplQ0grSVFLZG81dTVlb2lvKy80dE9rWTdOSTFOdXBNdW5O?=
 =?utf-8?B?aThOUzl2aUdCV256QlNGbmtBdFdVRWUrc0JuOXFmc09RQzgwOVFQRW83T3Fv?=
 =?utf-8?B?T1NMNU9kR3ZCN3VpUlZlQlNxcFprSFlYYVBkaG1wcXJiZHZVQ052eXdwQkpU?=
 =?utf-8?B?SU1VR3gyQ1plNWE1YmVuZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTBoSS9vdmhxdWdYTmlzek95WHlHaGExTmh4ejFWUEtaQkVaRVZyZ1V4RjNi?=
 =?utf-8?B?eTZkaW5aRkdJOUZadXB4cjRYY3Z4RVRISUZIU1hqM2FSVEtCUnRFSm1iQjZC?=
 =?utf-8?B?TE9GSENyQTl2TURVQzNhcmx4ME9TZmsyTUtDc0dOT2wxd1hQLzRESElZdkJS?=
 =?utf-8?B?eldmRVBhSlJrSC9jSWtrbHpXSHRRakJBSWJuTkxUZ04reFhvelZtdmtNRzZy?=
 =?utf-8?B?T2psYmRGaTZkSUQ2TC8wWEdBS1Y5T1VSY2tETUdQUkNWL205ekJMTHFtdWVX?=
 =?utf-8?B?Mm1yM0Z4S0k3dFlnL2NZQlExQUZhbTM5VFdacGI4anNod1diYnBSWEJZaGRx?=
 =?utf-8?B?TDdNcmlQVXR3M2xtNGlCYW5GTUJKK0hrZmNBYXZGZXVoZVR6VjhNOElqTDNu?=
 =?utf-8?B?dlA2YTdGSGtJUGFHRGMvS2VvMVZRV2VWY0ViTy9IcXFvbnpkelNOK0t3ajhC?=
 =?utf-8?B?aGNpVk1ZQlYrRDNnQWlsSFBnQ3h2TzNxa1pLM3dWTXhHZUhQUy9RdVlhbWk3?=
 =?utf-8?B?c3pSQitpTElrL0g2enMwOTJjWWZkd2g0ckdtT2t0OW9ZSENpV2RIVDUwRGhX?=
 =?utf-8?B?dWUxMFFJSDNWK3NETmdxeUluTjUrOTZIeEVWdEQ1M1l1U3NaSFlPMC9jY3Jh?=
 =?utf-8?B?R1AvaTZ1b21EbU1pa3ZlSTdBS3NLbE1XTjgrYzhUaFJCcm0zSmF6UmVUME9Y?=
 =?utf-8?B?cmNFb1FjOExsdzRQMjNLY3RkS0RNZUhVblhtakV0QmZaZklPSU5pY2wxeksw?=
 =?utf-8?B?bU5kK0hyeUtPRzBIT21Bd1BndEM5L0wwOFlpWENiOTlQYWNGVUg2a2pUSEw5?=
 =?utf-8?B?U3ZabVZOV3huejdBUGF4MXlwZXl4L21KMFgzaC8rRkxsOTlKYXMreis1Y0ZP?=
 =?utf-8?B?MVN1bXIyWlQvdk1OZTNHOGorK1cyWFp0RVI4L2c0YTZRd05jV2J6ZGhCWlRs?=
 =?utf-8?B?WlZTOXFjaW9aOENFMHZPZHltcjQxSjQvM3I2WTdUeW1vVTRFdTIxMThqMVRT?=
 =?utf-8?B?cTdyMUFlR0ZUOGVESDVwREE4S1VxV0NuMVJyRW5vVXQ3ek1WRWlxaWJQaFNB?=
 =?utf-8?B?Ni94SVJkYlg5U0hocVgxWWEyTHdFZUZycHRCd2drOHF4U1ZmanY4Tm5aeGE1?=
 =?utf-8?B?UmN5Zmx2UkExd214ZVFtL2ZxdDRKTEdIenkwNlZtOWFZaU1lNVU4UU84K21Q?=
 =?utf-8?B?Um12a0E5NnUzUnFueWdTUkNhS05NeXgzOUZCTDZ0RlF2dDZubjR0VkMva0tF?=
 =?utf-8?B?cnR6VlIrM2xnTjdETGVZeU5Jend5dWliMHZzTlc3Q0dLYjlEZnk1T2dCMGFZ?=
 =?utf-8?B?M2VMKzdBZCtnUU12Q3pBMkZqU3BsS1NTNkpCb1pORW16M241akdlZG45TGN0?=
 =?utf-8?B?QllhYWRSQmdOVnhOSzlMQ1kxT1RHclNxMDRNK01CRlhWVmRYVSt5WjZRUGJI?=
 =?utf-8?B?V0hOY0dFSDlqcHJ5Y0xUZUJXM29zSzA3elRyYjdic2tHNXdXdXlSand4T3h5?=
 =?utf-8?B?TENVdDBGcXNnMzJ0NTkrb2huM1NaS3VrT1ZtdVI0eHEyaVVxb0xYb1dzcHly?=
 =?utf-8?B?c0NObXlOSWVnQ1BGTUdGVHRoN0ZieGp2VHlNLzhiZjhFWDlXTmRod1l5ZXdF?=
 =?utf-8?B?c0NUS2FiMEhta2MwUi9LYUh2bnQ5M0lYOTRqWC9iY09MWndmZlUzV0VnZkpt?=
 =?utf-8?B?Y2hLQ0JGUlRRVUpwYVRDNEFkQ1I4c3BQMFhlUFYvY2tFYVZaV2FtdjRUS2sw?=
 =?utf-8?B?em1QL1h4cnZVZ1gzNHMrS0YvOUNWZ1kyVUMwMjBBRlE5azZ1eSs0cHpZamNl?=
 =?utf-8?B?OS82SFJsWi9mbXp1MnFpdWJLWnhycDN0V1ZQSVlpcnZzQVNWS3ZTR3pNM0JO?=
 =?utf-8?B?ZENtTk9jalBzMXBsUE5oWVZJeFBXY2xFNUw0Zlcwcm8zVGN4cmNTWDlvZ0VD?=
 =?utf-8?B?MVIzK0d4WXdwYllEVHkxRXQrQlh5bk5nM1VoenBIUlBHR0tIYjNmTHNIY2Na?=
 =?utf-8?B?UUwvYzByYlN4bThMUlRoc3ptV0k5cWpMbGV5WGoxNzlqOEVwaTR3N1lkeE55?=
 =?utf-8?B?c0c2ZmtkY3ByUWxnS2M2L1hzRW13TWxNQ0VRbWp1bjA2Z3NqdW5qWUZSb25n?=
 =?utf-8?B?dHdPVTEvdVl2c2NtTXJ4L0psamhNcVBWNXhHQzBEV3o3UHRCWm8rU2VEUGZ0?=
 =?utf-8?Q?91a+BF9Jp+wb8EQw1hGIk0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69B9FAEF8A6B8743B71E4EFDDF618721@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa9066b-d334-4cb3-7261-08dc747bc008
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 01:10:03.1000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KW3Gib/7TpMftVylf0g6AEWmybztrtUeamOGzZ/ZSmbUvNPghlI7c8qfGT73BaA40WD2sPr3CTFfznNX+SIZleCR5Wtid/cmrcFWiYmhdOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4977
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDE1OjIzIC0wNjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IHNv
IGF0IHRoZSBtb21lbnQgdGhlIHBhdGNoIDYgY2hhbmdlcyBzaGFkb3cgc3RhY2sgZm9yDQo+IA0K
PiAxKSBjdXJyZW50IHVyZXRwcm9iZSB3aGljaCBhcmUgbm90IHdvcmtpbmcgYXQgdGhlIG1vbWVu
dCBhbmQgd2UgY2hhbmdlDQo+IMKgwqAgdGhlIHRvcCB2YWx1ZSBvZiBzaGFkb3cgc3RhY2sgd2l0
aCBzaHN0a19wdXNoX2ZyYW1lDQo+IDIpIG9wdGltaXplZCB1cmV0cHJvYmUgd2hpY2ggbmVlZHMg
dG8gcHVzaCBuZXcgZnJhbWUgb24gc2hhZG93IHN0YWNrDQo+IMKgwqAgd2l0aCBzaHN0a191cGRh
dGVfbGFzdF9mcmFtZQ0KPiANCj4gSSB0aGluayB3ZSBzaG91bGQgZG8gMSkgYW5kIGhhdmUgY3Vy
cmVudCB1cmV0cHJvYmUgd29ya2luZyB3aXRoIHNoYWRvdw0KPiBzdGFjaywgd2hpY2ggaXMgYnJv
a2VuIGF0IHRoZSBtb21lbnQNCj4gDQo+IEknbSBvayB3aXRoIG5vdCB1c2luZyBvcHRpbWl6ZWQg
dXJldHByb2JlIHdoZW4gc2hhZG93IHN0YWNrIGlzIGRldGVjdGVkDQo+IGFzIGVuYWJsZWQgYW5k
IHdlIGdvIHdpdGggY3VycmVudCB1cmV0cHJvYmUgaW4gdGhhdCBjYXNlDQo+IA0KPiB3b3VsZCB0
aGlzIHdvcmsgZm9yIHlvdT8NCg0KU29ycnkgZm9yIHRoZSBkZWxheS4gSXQgc2VlbXMgcmVhc29u
YWJsZSB0byBtZSBkdWUgdG8gMSBiZWluZyBhdCBhIGZpeGVkIGFkZHJlc3MNCndoZXJlIDIgd2Fz
IGFyYml0cmFyeSBhZGRyZXNzLiBCdXQgUGV0ZXJ6IG1pZ2h0IGhhdmUgZmVsdCB0aGUgb3Bwb3Np
dGUgZWFybGllci4NCk5vdCBzdXJlLg0KDQpJJ2QgYWxzbyBsb3ZlIHRvIGdldCBzb21lIHNlY29u
ZCBvcGluaW9ucyBmcm9tIGJyb29uaWUgKGFybSBzaGFkb3cgc3RhY2spIGFuZA0KRGVlcGFrIChy
aXNjdiBzaGFkb3cgc3RhY2spLg0KDQpEZWVwYWssIGV2ZW4gaWYgcmlzY3YgaGFzIGEgc3BlY2lh
bCBpbnN0cnVjdGlvbiB0aGF0IHB1c2hlcyB0byB0aGUgc2hhZG93IHN0YWNrLA0Kd2lsbCBpdCBi
ZSBvayBpZiB0aGVyZSBpcyBhIGNhbGxhYmxlIG9wZXJhdGlvbiB0aGF0IGRvZXMgdGhlIHNhbWUg
dGhpbmc/IExpa2UsDQphcmVuJ3QgeW91IHJlbHlpbmcgb24gZW5kYnJhbmNoZXMgb3IgdGhlIGNv
bXBpbGVyIG9yIHNvbWV0aGluZyBzdWNoIHRoYXQNCmFyYml0cmFyeSBkYXRhIGNhbid0IGJlIHB1
c2hlZCB2aWEgdGhhdCBpbnN0cnVjdGlvbj8NCg0KQlRXIEppcmksIHRoYW5rcyBmb3IgY29uc2lk
ZXJpbmcgc2hhZG93IHN0YWNrIGluIHlvdXIgd29yay4NCg==

