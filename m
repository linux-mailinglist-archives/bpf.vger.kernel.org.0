Return-Path: <bpf+bounces-57183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146BAA689E
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 04:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30FC17163A
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 02:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A593B19A;
	Fri,  2 May 2025 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aITFFc1A"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B221195
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746151741; cv=fail; b=sONFW5pTAQQ5PbaieoeWTFwPmItPko/uHiWoPTUhSUYzHke5rBAwugecUw/udRL2JW8oDsZWAod/5jAlu4bWcjHXJ+K9iyRKw80MVEEvHNqqWYSCXLDm5TN9gHSov1y5LL/z0XYEvmckrwtUYlNHFViRuduSAPOIMyZ5mNLIDEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746151741; c=relaxed/simple;
	bh=uHkKgQiUexugQwhhTFqPzY/VDIsAPhwI3uVSvu9L1d8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fIJMkUPLVWTbtIZpByIvm6UL6lQrfeLUh/G+WrNv1A6DBL0etNmJH8GqCLLGtJblgb5hQhBO1glayK3SRwvjjNjbjSlMYthtuh6s5OHbPI/GSLFAOTvKX+Vb6ijWcehbS/zAkmEWHEGLojLRbIzrF4P99BODtgNrE+JObC75vsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aITFFc1A; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746151740; x=1777687740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uHkKgQiUexugQwhhTFqPzY/VDIsAPhwI3uVSvu9L1d8=;
  b=aITFFc1AVOtPJ60zx0Htsaz/G6CHQwSJ74elFxsMxt0r3500J7E0DEvl
   9Jnp+w5MBPxhKJcnjxLMi1Sl6VXQ8Mt168a+rS8P/dOMDTJsTTvQym8TS
   2e/3ZcvdRG0rYDpeX04yF8yshnzhdjCkXgKlkJmLTDpUowGRl27KZTep6
   oCtOTNG1qGGv7s4+EtZ+VjO5e2v1FZBANtWWlT0pRnVbjnVL9saUw4N2W
   7CaRGcrE6f57cvUGXUr0WHM/M+wvCS9m5+ehk4saQ4fda2PZxTIv7KVCw
   q2rDGnxFCMzMaE2gwAKXQA0j6Bq6CODjBcYoujucXpUtyARDgude0dKOa
   A==;
X-CSE-ConnectionGUID: iOvi724VRoqqpOvMfFnFWw==
X-CSE-MsgGUID: sA+U+lMeQFWYgy59ByLv0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="65365195"
X-IronPort-AV: E=Sophos;i="6.15,255,1739865600"; 
   d="scan'208";a="65365195"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 19:08:59 -0700
X-CSE-ConnectionGUID: DHYmTGymS+GWuS6kgS0MwA==
X-CSE-MsgGUID: gxdP2JslRuu2dgSMIBajTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,255,1739865600"; 
   d="scan'208";a="139676777"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 19:08:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 19:08:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 19:08:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 19:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSYO1JJ2Dh0g9/w+0BfFVkkNITk3aTJ76r9Rwr+sjUInvVC0ufgVlK1CP9YEefKZTo9HmzWgNG6Je6KYtGjzUrPp0EyfIBiX7j9CFpu+fAcxLWVfFGszOg3sCS2fzr38O5pjfsZ64jGlBd7ivCbQghe5gkzCKEPedl7KcjyZ0KrZv1/iAUqY7MnvftmYCao65zgbAct9Ioh7yNxKh44x8VPK+0Ip6LMhjV5/iEbq8Sv8rNkTbcu5vQCyxWWOpK9YFJuRf6GL4shN6gk5+Ae7y/QiBeYetTj2wIdnymdN0Izod93tEKxQvkocRtLR/uFXdJbocK9VqKSg8mHy5BytXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHkKgQiUexugQwhhTFqPzY/VDIsAPhwI3uVSvu9L1d8=;
 b=tPT3ZyiXKIfsYZSFy1qMQ2T/nvKovxuUGteYhC9GbB9v969qNljSMJPYPNkaVe8dOAWXTLb1Y3EyQ33pmGIk3Cj2qUbReHRAJWdOqypeP61MHprBYPVf4UMO8BXDlh+cl33XoU/hdMzM4pVbmGAfMUaqpJDYKyAJ++sidaiNHVsVcRKvPDhX9f5VY0x8I4xZ1NwQ2YhDA5IYPhXGyPEDerywIQV1pPc/EnrOkZMVAykEoP+9KvlaleSanM84nputuobxl0QEyXuTfbySZoRwnav8IIzIfmrj6IjPsyH80LEtOIhQlHkzqHHKtSuUUbwlaqVR2wRWWXXOf1p9F9NMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 02:08:52 +0000
Received: from PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::fffc:36ac:37ac:1547]) by PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::fffc:36ac:37ac:1547%6]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 02:08:51 +0000
From: "Preble, Adam C" <adam.c.preble@intel.com>
To: "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Looking for feedback on kfuncs for dentry_path_raw,
 get_dentry_from_kiocb
Thread-Topic: Looking for feedback on kfuncs for dentry_path_raw,
 get_dentry_from_kiocb
Thread-Index: Adu59cWMECpSFptnTYiCDPRb074PbgALdP4AADswP4A=
Date: Fri, 2 May 2025 02:08:51 +0000
Message-ID: <b40406d4b9a3bcc826d68a35af05112fb3bef8c9.camel@intel.com>
References: <PH7PR11MB652381F4B833B4B5CE2AEABAA9832@PH7PR11MB6523.namprd11.prod.outlook.com>
	 <CAADnVQJ0aRud=VeQ7dWhFqEqVQQCozKqtP9mHwuHOj5ua+5J4A@mail.gmail.com>
In-Reply-To: <CAADnVQJ0aRud=VeQ7dWhFqEqVQQCozKqtP9mHwuHOj5ua+5J4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6523:EE_|SN7PR11MB7603:EE_
x-ms-office365-filtering-correlation-id: 9da653d8-2b07-462d-005b-08dd891e48a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UnlXbmhXL3ZzOWs3TU42Z0Mxai9NK1ZPVWUxQTBCZ295eGo2SDU5elVBeU5G?=
 =?utf-8?B?d1ZXeWk3MDNsY29YOXhtUnFjeHlUUTJOTHZxcGF6dk9wei94eFdWeHQrS1Bt?=
 =?utf-8?B?RGNkdVpQeE9mTVlEN3Jza0Uwa3hjQUxFdkd6d1ExNlBSWEthemJBNXh5cDA1?=
 =?utf-8?B?QTVJcDFtT0FRTzBQK2EyTmdCSmo0dHNvUC9JaVU1ckNraXZ4Y0p0T0RRdlVV?=
 =?utf-8?B?UnVlM09XWUZqSkJzTFhXeWtsams1N2N0ck54dWdPaVdDbFkvSEZIMHRBMUNY?=
 =?utf-8?B?VkFxTUMyajA4RG1Zcm9xWGoxZ2orcFF2Zmg4QXhQbTlzdVV6WkRjaW9EMmRZ?=
 =?utf-8?B?c0RxSnRQd0ZGaHYzdkptQXVubHd1RzlYbzBSdm1VbHF5WWlCQ3daMFNVbWow?=
 =?utf-8?B?bDN2ZTRwYTNySGJHZUlvMHBwZXpOcVMvODMrOXpsSkkxbmF6d3diV2RUMzVp?=
 =?utf-8?B?azgvRTdtNXdrZjBUOUtlVFYvRkszbGxLMFJMVTc4Zi9CeHdhcWlQNGM4eTAv?=
 =?utf-8?B?R2NRQjRjNjk5eUI5dldmZmcrM1FNZjNEVDFPOWQ0UTR2bWhDOUNGc3JTV0FF?=
 =?utf-8?B?QkRXV1N0QWVBNkdHQ1BSTGVtTEhOaythVEpuTjlWcnRMbENZelFIcWpVRG1a?=
 =?utf-8?B?aU5MeDZFZThUeHZhMFVXbGQ2MDV4cy9EWG52S2VOYkNENTNSOEFWMHJtMU92?=
 =?utf-8?B?dGIwTURjdXk2ZUZnQ0EwajBqdkcvQ1NtdXIrclVrZHFzWk9EU1JRWEptU29z?=
 =?utf-8?B?Skllc0RPL1lsVlMwd0E1S2c2WjUwK1krb1ptQi9jUGM5ZFBydVdLbUwvMzZi?=
 =?utf-8?B?K013WGhLRnVVWi8rQ1h5bDNXMjVkdkVaYmg4b3hkVDA4cmRuTm9SQzlURlNJ?=
 =?utf-8?B?Tm5YbXBlcXdBZ3Vtb003MnAzeXZJWEdjcitCV1ZqK1lQQWdvTmRNUVNxT3BR?=
 =?utf-8?B?S3paZVR2N0huV1haSHpTdmxSM2hWaEc3TDJjb1V2VnhmMmJZRW1yREZOZGV2?=
 =?utf-8?B?UXltTWZzTm5wU3N5bElHbHdTdFRUMkZ0eG1WM1AyMFVWelJndjVrYmdrUlIv?=
 =?utf-8?B?SW8yQXZSR1NrYXA3aEJNS2JKL25nalhCN2xaaXFCdFc3OHpEbUJIOW9BQ1B2?=
 =?utf-8?B?MU9OWXdsQkJhNmphWSs0My84MGZXWVdmWFFSNjI3QmFPNVpPSTd3SUQ1UnlQ?=
 =?utf-8?B?VjRPMXhTL01DV2FNVnBVUTZxa2htQ01xeEdtb29GdnBkL3A1cE5wQW1ScVl3?=
 =?utf-8?B?aWhlRjMvcCtweEcxODN5S0ZZZHNXRzc5aG1QL0hPd0VpbFhleTJldHhiMHV4?=
 =?utf-8?B?aFltQ1VNVnMybWtsa1FYV2pSbGJpMWplSVFXNVl3cWc1OG96dUtTbDJ1T0U4?=
 =?utf-8?B?bUtGY3BuYzIyRndNWFVlUWFrb1U5OGVCSHlIQ0FYVnkwTjg0Ymp5bXg3OWhH?=
 =?utf-8?B?aWRlQXZBMzdFcFRPcGxQZG15cGtOTnlRWWt3Mko1K3ZmWTBjZDZRSHY5MnJi?=
 =?utf-8?B?NmNrRDdRODJXUEgrNU5XK05yb1ZEZzIzdEk2QjBNUWlEL1RkbmN6bUFWYU03?=
 =?utf-8?B?QkFlSUJkTVZOb0N4cUNxSUNxWXRBUjBNN1hJeFM0RUlFMHRzSHF4NGR3S0dV?=
 =?utf-8?B?bFJxVEcvcTJKM0ZaOWQzRzM3dkc0R3pEL0NFdkh1UkdCajFXTkFMa1lHalZp?=
 =?utf-8?B?Lzg3UnhIdUV3S0VDTEF6VWorUzFKRktTN2kxak1sSWlISlVKUzVSUzR5Y2xJ?=
 =?utf-8?B?M0YzcVI2cVlQUmpWOGY0M2tSak1TbkdLTlVFWVZXUVVPdEtXMUpjY3lZUStV?=
 =?utf-8?B?dWRtRFlBcldWSnVWOG9aMldOd2wzZFRWSUd1Q3lUV1BxejgxTnNZQmlGemJF?=
 =?utf-8?B?NUFaS3JnNTQxN1hPVldyOExkUWV1elk0K3E3R2dXSnlFSjBJMVVSa2xtTkpX?=
 =?utf-8?B?RnRwR09OZnNRQnQxSFdxaVZLY0VFVzZqQ3pjUDc5bmFObThkZEVyK0diVEhS?=
 =?utf-8?B?RGUxT2tTejBBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkUxdXBWZlVqMHRkbUV1K1B0UEdYeXBpUURRTmxMOWM3ZzI1bHlDcnA5NWha?=
 =?utf-8?B?S2JkUGx0bHdYUEhlRzVxaGtpdlpqUlV0N3VzQzRaNGFJcHhvTjNqeUdlSk1F?=
 =?utf-8?B?S1d6bkZMTU9VbUlQT20wUit3Wit2WStKVVcyZ2dZd3BhK3NzQmNJNWRibGlK?=
 =?utf-8?B?bFowcHJzUllMNFhrUzhzajh6U21Ycm5FWW56aytnVU4yOG1GbUpmeEQzczBU?=
 =?utf-8?B?Qzd2T2xsaEd3TkUrV2NrdUF2N1kvS1B4WjVKWGdHSnd3a3o1MGpvdjJDYXZ6?=
 =?utf-8?B?bUdqOHpOKytMcFptVW9pNGgxZU9CYVFTK2RCREdoRS9vWThxM1JoZEdpc1dC?=
 =?utf-8?B?V2FzRkpJSVhidE8zMjJSYVV1MUVuUmJkNUJWclRVK3BpaU12c09MNHVGMm9V?=
 =?utf-8?B?ZTZ4RWlIQmt3Q1NjVjI3YVMxU3J1RjR2Q2xhNVl6QVA3OW1DdHFxVFdTUFdn?=
 =?utf-8?B?YXhuUHU3dUZTMEtXWitqbDl3V0ZMTkIzaWcvTm9Mc08xd2U0azN0SXlZMExF?=
 =?utf-8?B?bVF2ZWFxakJYalBGcWRXK0ZlSk5nK2NJcUlPSGRxU2RJaGZkd2ZhbDN1dktq?=
 =?utf-8?B?SXZpNkVvSWhoUHBGQjFpdWJzckkvY2FJc3creEk5U2hFdVljOTdSeEpsVnZJ?=
 =?utf-8?B?c3liSjhPaEwwaGh1RTBWQU1CZkYxUDA3aWJaTVlVWVY0TjRLN3RDaUVYaVgx?=
 =?utf-8?B?ZTZwdFgvRnd1YTN1VXNmbDRlNHdwRlVWWDRhUGtmaG1ER1VzMkdzdmtuaUg2?=
 =?utf-8?B?OHJjbHprT09DbE1hKzE1eDhwSVVWUjEydkQ4ajdaWmtWdXJVTTVXa1JPSnpY?=
 =?utf-8?B?eWlWbXdFRGFObkRqSUlXQnkrVXc0ajMzdWltNGI2cnQzVVV2bzNnTUY5VEtt?=
 =?utf-8?B?SW1CeEpLdVZpbEt0Mk4wQkZVVENvRk1IMjdDZjNCRjVPL2lFTGI3QXozMnVV?=
 =?utf-8?B?YzVTSlpZY0NRZzlQdHRZSjlWeVd0cmZvR2crYzZ0aFdMeTRZVk85QUMrN0dh?=
 =?utf-8?B?Njk2aUk5bWtLZ0Yrc0NqRmJ3cWE1cndCRzFjR1VSaDFkSUVyU3pFTzdsczJ6?=
 =?utf-8?B?Q2duSTZ4NUNydkRwTkN1eGRmdUlZVWJEMlBaTFdTSkZMSHQwRTRJajIxczhF?=
 =?utf-8?B?MmVnVi9SWjdmc2JOdVBQeFBBazZVUkpEczl2WVpPK0k0cGMrTE1UVWYxWEJp?=
 =?utf-8?B?YUVUMFNOQm1VY2NrMkxQRzlSa1pCNlRlb1JlTFJHK2hrajJoOUxvemwzVHF4?=
 =?utf-8?B?RHAwYUwwU0FBTE5yMitGSGN1YUo1RmlJY1RYK0tmUCtwQnczUXZtaUo5aFNq?=
 =?utf-8?B?N2xwemNvK2FNY3JBajMwRDFQWk1QcDh2WXBKZkZnSjdIek1LRUhmZ1p4aitS?=
 =?utf-8?B?ZHQ3YjZ3YjM2eVNBWUdyMU11bVFyMnkrWjBLYTBOT3M5TjFlRGRxOVdIVmJq?=
 =?utf-8?B?Zlk2NjBhQUZSNkJ6N0txejBzVkN0OTM5bTg2MGEzZS9pUFpoaDl1TzcrSDAw?=
 =?utf-8?B?MHVlT2RKeDNlNXhZY3U1TlAvam9sTjRBYW1lQmlHOEJldWZtZWNrY1QxZWNy?=
 =?utf-8?B?MGZSZFQ4RTNpbGdNOWF1R3RMRUdkdURDZDBKbmdjbzlSakFNSDFwY2VHSUZB?=
 =?utf-8?B?dE9HY3hDaTFrOERQRmErWHlrWnptVVNXS0N6YzBjdlRURzF0QjZvU2hHNExt?=
 =?utf-8?B?dGtqVDJPQnpFUlU2MUFZYWtKaXVERUUzeW5zVWwvOXRoWE5UYzBrVlg0ak9F?=
 =?utf-8?B?QjJkYjMwS3BNQ3R6NzBxWmlZQzloMGlVRW9kU3ltc3liVmNiaFg4Nkg3THdQ?=
 =?utf-8?B?TW1iZ0F5dktPN1cvNGR2cVZlM291cTBPc3lPdVdYS3pMQXlqbmtnc2JYaFN0?=
 =?utf-8?B?b0xoZGJQeU0wM1VXN1J0UkpLa21KZFlCMHJKdHdtUE9tZ1YranNPaEZoemhs?=
 =?utf-8?B?dUQwUmVhUVBEQ3RTd0RLYmZqOHp4ak1Yd2NIVDBMeDFHdUtrR1c1b0EzZ1ls?=
 =?utf-8?B?YXRJd2MxMkw1R1k3T2lDd1NDQm9ncStLSTF2YkV3S3pONUJBMEF5ekhjS1dl?=
 =?utf-8?B?cXJDNlRka05TbDBYWTErbCsrR0x2Unp5U0MxZ1lEc2srSnIyQTRFTXJob2Nr?=
 =?utf-8?B?emJraU9Hd0k2ZTNabWxRZjZnaXlSOTl2Qmc1WmpQMlBZdFNtMVN3ejkwSEgz?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79A1D61606AE9444970A24B4FFA9067B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da653d8-2b07-462d-005b-08dd891e48a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 02:08:51.7253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARQZLqCScEzgMoFelkYPv5d/1FbUhWL4+AvfTHtMC7hOB5uexJMeROOioG92ofyyJcrcdFj0QoOSZYrBiBUddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA0LTMwIGF0IDE2OjAwIC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+ID4gKy8vIFRoZSBkZW50cnkgYXJndW1lbnQgbmVlZHMgdG8gYmUgaWdub3JlZCBiZWNh
dXNlIHRoZSB2ZXJpZmllcg0KPiA+IGNhbid0IHZlcmlmeQ0KPiA+ICsvLyB0aGUgaW50ZWdyaXR5
IG9mIHRoZSBwb2ludGVyIGNvbWluZyBpbiBmcm9tIGtwcm9iZXMuDQo+IA0KPiBFeGFjdGx5Lg0K
PiBJdCdzIHByb2JhYmx5IG9idmlvdXMgdGhhdCB3ZSdyZSBub3QgZ29pbmcgdG8gYWxsb3cNCj4g
dW5zYWZlIGtmdW5jcyB0aGF0IGNhbiBlYXNpbHkgY3Jhc2ggdGhlIGtlcm5lbC4NCg0KWWVzLS1J
IHdhbnRlZCB0aGlzIGNvbmZpcm1hdGlvbi4gSSB3YXMga2lja2luZyBteXNlbGYgZm9yIGxlYXZp
bmcgdGhhdA0KY29tbWVudCBpbiB0aGUgcGF0Y2gsIGJ1dCBJJ20gZ2xhZCBpdCB0dXJuZWQgb3V0
IHRvIGJlIHVzZWZ1bC4NCg0KPiANCj4gPiArX19icGZfa2Z1bmMgY2hhciAqYnBmX2RlbnRyeV9w
YXRoX3JhdyhzdHJ1Y3QgZGVudHJ5ICpkZW50cnlfX2lnbiwNCj4gDQo+IFdlIGNhbiBjb25zaWRl
ciBzb21ldGhpbmcgbGlrZSB0aGlzICh3aXRob3V0IF9faWduLCBvZiBjb3Vyc2UpLA0KPiBidXQg
aWYgeW91IGluc2lzdCBvbiB1c2luZyBrcHJvYmVzIHdlIGNhbm5vdCBoZWxwLg0KDQpJIGRvbid0
IGtub3cgaG93IEkgY291bGQgY2FsbCBkZW50cnlfcGF0aF9yYXcgd2l0aG91dCBzdXBwcmVzc2lu
Zw0KY2hlY2tzIG9uIHRoZSBwb2ludGVyLiBNeSBwcmV2aW91cyBleHBlcmllbmNlIHdpdGggYW55
IGtpbmQgb2YgbWFuYWdlZA0KcnVudGltZSBzdHVmZiB3b3VsZCBpbXBseSB3cmFwcGluZyB0aGUg
ZGVudHJ5IHBvaW50ZXIgaW4gYSBzYWZlDQpjb250YWluZXIsIGJ1dCBkb2luZyB0aGF0IGZyb20g
YSBwb2ludGVyIGNvbWluZyBzdHJhaWdodCBmcm9tIGEga3Byb2JlDQpqdXN0IGtpY2tzIHRoZSBj
YW4gZG93biB0byB3aGVyZXZlciBpdCBnZXRzIHdyYXBwZWQuDQoNCkkgd291bGRuJ3Qgc2F5IEkg
YW0gaW5zaXN0aW5nIG9uIHVzaW5nIGtwcm9iZXMsIGJ1dCBpdCdzIGFsbCBJIGNvdWxkDQpmaWd1
cmUgb3V0IHRvIGdldCBhbGwgdGhlIGV2ZW50cyBmb3IgdGhlIGZpbGUvZGlyZWN0b3J5DQpjcmVh
dGUvb3Blbi9tb2RpZnkvZGVsZXRlIGV2ZW50cyB0aGF0IEkgd2FudGVkLiBJIHdhcyBzdXJwcmlz
ZWQgdGhlcmUNCmFscmVhZHkgd2Fzbid0IHNvbWUga2luZCBvZiBzcGVjaWFsIGV2ZW50IHR5cGUg
Zm9yIHRoYXQgYWxyZWFkeS4gSXMNCnRoZXJlPyBTaG91bGQgdGhlcmUgYmU/DQoNCkkgaGF2ZSB0
aGlzIGZ1dHVyZSBzY2llbmNlIHByb2plY3QgdG8gdHJ5IHRvIGV4dHJhY3QgUENJIHRyYWZmaWMs
IHNvIGlmDQp0aGVyZSBuZWVkcyB0byBiZSBhIGRpZmZlcmVudCB0eXBlIG9mIHRyYWNlIGZvciBm
aWxlIHN5c3RlbSBhY2Nlc3NlcywNCm1heWJlIHRoYXQgbWFrZXMgZm9yIGEgd2FybXVwLg0KDQo+
IFlvdSBjYW4gd2FsayBkZW50cnkgd2l0aCBwcm9iZV9yZWFkLXMgaW5zdGVhZCwNCj4gYnV0IGRv
bid0IGV4cGVjdCBjb3JyZWN0IHBhdGhzIGFsbCB0aGUgdGltZS4NCg0KTGV0IG1lIG1ha2Ugc3Vy
ZSBJIHVuZGVyc3RhbmQgdGhlbi4gSXMgdGhlIGlkZWEgdG8gYmFzaWNhbGx5IHNhZmVseQ0KZGVy
ZWZlbmNlIHRoZSBwb2ludGVyIGJ5IHVzaW5nIHRoZSBwcm9iZV9yZWFkIGZ1bmN0aW9ucyB0byBh
Y3F1aXJlIHRoZQ0KbWVtb3J5PyBTbyBwcmVzdW1hYmx5IEknZCBiZSB3cml0aW5nIGFuIGVxdWl2
YWxlbnQgb2YgZGVudHJ5X3BhdGhfcmF3DQppbiBteSBicGYgcHJvZ3JhbSB1c2luZyB0aG9zZSBj
b3B5IG9wZXJhdGlvbnMuIEknbSBndWVzc2luZyBpdCdzIGEgbG90DQpsaWtlIHVzaW5nIGNvcHlf
ZnJvbV91c2VyIGluIGlvY3RscyBvbiBhbnkgcG9pbnRlcnMgdGhhdCBhcmUgY29taW5nIGluLg0K
DQpJIGNhbiBnaXZlIHRoaXMgYSBzaG90LCBidXQgSSBkb24ndCB0aGluayBJIHdhcyBhYmxlIHRv
IGdldCBhbnkgcGF0aHMNCm9uIHRoZSBkZW50cnkgcG9pbnRlcnMgdW50aWwgSSBmaXJzdCBjYWxs
ZWQgZGdldCgpIG9uIHRoZSBkZW50cnkuIEknbQ0Kbm90IGFjdHVhbGx5IGEgZmlsZXN5c3RlbSBn
dXkgc28gSSBkb24ndCBrbm93IGlmIHRoaXMgaXMgYWN0dWFsbHkNCnJlcXVpcmVkLg0KDQo=

