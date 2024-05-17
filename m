Return-Path: <bpf+bounces-29914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4118C8132
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0549AB216AC
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479B215E85;
	Fri, 17 May 2024 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFYp0Apn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49E15E83;
	Fri, 17 May 2024 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930111; cv=fail; b=BmV2+BP0yLOqv2mVliMTGJ0tgBuFCRAwSH/KikCCORgP+01habd3EHiQ/oFF5/4j0T9Z8uyD1vf9nopg3AaMv2qbN2ykma076UydJxWftLHlnZq0wPaTxx5rXYDGs68KITZ1CZicouNYHmEbvTF/pseYHNBMaLDiz3eK8iIxwVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930111; c=relaxed/simple;
	bh=jZYH7zA5529Gq2GEkgsY66qiJ16QXUC2OV45f5zgNjg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I1usEF0CBpbfyaD3Hzn8bw1IqzH4+nyHrOQidrOFyiODmWCeizzwOiwfj/cY0IKdz2RZX2YtmCeYRSeSC7Fea/LC4yD1VFSDwqLZTCam74r0HqkZ7kGYAtwMp5J0HvgUprBRc6QHmvKW2nzTh7qfMs1MuAAyDe/nbATPtQWMWmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFYp0Apn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715930110; x=1747466110;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jZYH7zA5529Gq2GEkgsY66qiJ16QXUC2OV45f5zgNjg=;
  b=HFYp0Apnk6NoVNGumRIEfJVqbF9LIA0F7BXqcd7VWp1OMj/NPiEBnZpW
   vQeVTMYl+sZ+ojHEuvq+G2NNaC1H/AL5OT8NTISKehLJ0ymKp5Q/2sxJy
   WqQcB6HThuSRqXOFHsqHN+9p4xwU1iaCpC0fhq0pz2X2GdE+qmgmkx3Jf
   qRxh0foQfF1UUDfKs42ft3BKziXFqvJCAY1aU9jzKh7dVybKU5T/1Os58
   bsky6xTaDl4td2nIcu5GQ9qIDFmhfvMVIGWC261KxgKYC710LrqStRNeC
   WNs6SmY8uK+Ba+1ervQLZX72hF2/yUNCEQ6Y6de2vnQd/5Wm1JhAFBorF
   Q==;
X-CSE-ConnectionGUID: hHqlazhxRmOYUAiSZ99NIw==
X-CSE-MsgGUID: bX3F8lBwQ82lOzKUIDGGcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15039095"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="15039095"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 00:15:04 -0700
X-CSE-ConnectionGUID: aj1u4Ig0T/CopJC1fXoIXA==
X-CSE-MsgGUID: GvGp9gJBSyeXTJ9COsxaig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="54915912"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 00:15:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 00:15:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 00:15:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 00:15:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 00:15:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ3gHqFJahNb5TFA0a6RgBEauYqiXoS5wkMl19XeYto1hRtbRGasJpE/vuOQLPincw9K0nm83ZY/8lvlfhYpDAXVWvGlUDeM8VD/2+TpI83YdV2nyeycqs1270Xon2HKKlYTqAzkeA76wsR2HY484Apmf+XN1Z0xHBvBpsR503PluXGmsJdF2fHwY8uGwk1sp21e9vVvsGHOhgpKcUh/2pjhIob3dT2tRFEH5Zf/f/Cnx5Y7cNoMlT7eia7DAmuRCy/AGo++TXcSL5D2V3FJs0fhXAl4DG6AcTW9ymsDbMzhg/HTJpRE8rEYuOgeY7gHxfadfx8+iFPjYPYf0D9L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2wpOwpVbRqNZue350CKvQe4s27zh+WZxKHuY5FmHaE=;
 b=Tx2uUIyyjsuRjyex0dK9yzGi1b2oLiALhqNQ0pKYnt/JK0kxSgQRi2IYUiwegkFsIEfAU0T3CJkb0rt0E6U9Gl3zgpWTaRVBYLcyxlaY3XO2sO62Y30cbnxVCit3vZ+bpfWwDaeGnuDUqfncyEnPBfuDomVem3wEPWWwZwu1kZ2j/HTC1XnKEH2jydfSLrxZP5M9rBSh7QNPLGhqmdUaAzPFBjThgB/nCEKmxfK9/b7CLSxMPbifG2AhJ5uVBwJwx4mHSvBWNJMC+ZUN5rWMbwLUzEHHEWy8sj9BHadMQeJQ4BTvaJJoEquuka/t6hRHn7vILWvh4U4ZDo00xC/gUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA3PR11MB7486.namprd11.prod.outlook.com (2603:10b6:806:314::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 07:14:53 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 07:14:53 +0000
Date: Fri, 17 May 2024 15:15:00 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: syzbot <syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com>,
	<ytcoode@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <eddyz87@gmail.com>, <haoluo@google.com>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <martin.lau@linux.dev>, <sdf@google.com>,
	<song@kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<yonghong.song@linux.dev>, <akpm@linux-foundation.org>
Subject: Re: [syzbot] [bpf?] possible deadlock in get_page_from_freelist
Message-ID: <ZkcD9H0P8O7Me5Do@xpf.sh.intel.com>
References: <000000000000c051d80616195f15@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <000000000000c051d80616195f15@google.com>
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA3PR11MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c0d744-6cec-437d-e221-08dc76410c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3NVRE14aTAyQytDYTNaSlRaNVF3NlhCZVhqWDA5ZzF6dXFHcnN5S1JGaVR5?=
 =?utf-8?B?RWhMNm4xSzlzd05ueHVjM0Q5cTN3dXZsUk51cTNxV3B2azhvYklUSloxVjlZ?=
 =?utf-8?B?eUxwVVJreGFWbnFTMklDdm1xN2NhWWJxaUFOcXl1Z1cxejJEbDRjbGV0R3o3?=
 =?utf-8?B?bXJMR0Y4N1JZUmExcVVuVTA0bFNpZUpGNW9aMEhPU3dWZVRib3pvMEd4aFdY?=
 =?utf-8?B?V2VkWXkxSlg2RG1IRVo0dC8zR1l2RFJ6aDBGVUJ0Y0llZ1hEeno5b0owZkJS?=
 =?utf-8?B?bDNGbTV1SFh5K2FmQVc4bUNMN3YxTXlxS3FYaDFhU0srcGJVeHFmWkVvOHB1?=
 =?utf-8?B?dkNVOWJuUnN6eDA2NEJBczdIcGdidlJPa1UrL2FDMWUxcjYyKzFER01CbW9q?=
 =?utf-8?B?ZVBqM2lsQXB4M25WTFo2RUxvWkg0QUl6NFUwY3AzWjI5ODd1N3l2RURBcC8x?=
 =?utf-8?B?SnZlZ0Q3TCsvS2xVNWRDWkRQRDFzcng3aEEva1pMVFc3MDhQSVJJOE16cjd4?=
 =?utf-8?B?aEZoYjlMNzdzTFNwaUwvVlNEdnpSV0hGNkhsT2NyUGpadzRWdUtLNG1ObUtH?=
 =?utf-8?B?YkI4ZEZjcWhHLytCbjZpVGtGcjNkSlJJK2pJZDZKenVzUHhYdktnYnR0TGdS?=
 =?utf-8?B?YXpIeEQwREJoN0JKZnY2Tk00elpoSFBOK2c0b3JISjVJckxiNi8yeVRkRVB5?=
 =?utf-8?B?aHYrTm45TjNacjB3VURubk0vTDJFVTkvRmFKbEFKbXNwdXJYMUxTSmJnakhn?=
 =?utf-8?B?cWJib2tpbXh1UTNCSk9yYTVGNjlqWkRhNGYwUm5KSXhOZnVoMnJxS3R2RGx0?=
 =?utf-8?B?bmdqTlhuNHlqNzJTdlNPUVRRNXY4b3o5VDVLTDR4L1NTd2dLSEJERlZSc3JV?=
 =?utf-8?B?d0w4dk1DVzdvazFOUHZGRE9GK1lrNTV6UkRCKzZOL2swZ1dkSElhbllRUDdF?=
 =?utf-8?B?RGFzczJ0S2luMnVDSlBxV3A3TEFQT0QvNW5uUnZiOWIxTHZSaGNPSnBIZlY4?=
 =?utf-8?B?Q2NhZGVvaU5HcGR4N1dieHlQNmJQaWhlSUdtRmNCOXRjTWQ1VkZVaXA4UGl6?=
 =?utf-8?B?ancwd21ISHZqV3FadUhpWjBqbDZOTWlyM0t1TkhvallrSUVpU2xTSnJSai9k?=
 =?utf-8?B?WkJvRktCVEhMTTJuWXFoQjFqNGRBMnlNKzJUYzVhL1FCUWUwWUNCTUViOXVr?=
 =?utf-8?B?M0ZGTE5lSzUxOVpScUVKOHhwK2w0NXNEK25XeDBHUndZd1UzYzA5U0diSHFl?=
 =?utf-8?B?c0NmdXpna256d3cySVBZTnJSN1ExaHZKL2ZwbFc5d1dKdFM0b29NNHNJTlZi?=
 =?utf-8?B?SU5lVEV0WXJrdUxYNzM0MTJvTEJmb2NkdVJuMEN4dzMvWDZNSVNZU0NpNStO?=
 =?utf-8?B?YjRlRXp4NUJKTlh5azM1MmI4ZWx3Wlg4Vlh2WXJPTXJHR0phUXBkS0N6YklT?=
 =?utf-8?B?VHRVb2Jzd014WCtNS2RITHVvblgrMnB4Sy9zdklOazZVbXVKNDZBY2t0aVVo?=
 =?utf-8?B?N1JXcG5XRkg4UzRuSkl0TGhFMWRqZ1dpZVZTTE9oZEhHUVQwbmwyNjV0WW9Y?=
 =?utf-8?B?aVVsQmlGTjhvWEhDNWpJYlBFVHNhTHp2VTR4bHhrVmdtNThlelZ2ZTRTZnFK?=
 =?utf-8?Q?zloZEZ+ADMQvvNk5m812Nbsh4E6EjudgP7OCkY/VfJEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lQZll6Ykt4TEozMkJTOXA0bTFYWURDNGViRmRFTHZDR3NiYzJycTZtWWRu?=
 =?utf-8?B?VyszMWFJaVVZQlNFV0p0UjhYOFM3TXFDanorMFhvakM2a0hoRUlKZ1BjNnlq?=
 =?utf-8?B?WGlibkpZN2NWN0k4Z0xxYjJGRGdXS2FYNHJNMWlxZ0xPSitqV3haV0FWUS9r?=
 =?utf-8?B?UzEwU3ZJbEQ3R0tsL1VCeWdqWkVuLzlvcU5qNXVRdEQwNElFRmNqZEdraXFB?=
 =?utf-8?B?Sm9vczIwaGtSUktqM1Y2bHpwdkpOcS93eWVnUGNOeDVkVnhlcHJQR2JYa1lO?=
 =?utf-8?B?V2pFQkxHRzIrT2ozdE1XS292NUduN1ZEUlNWWDg0S0NhWmluaCtoS0U0NTJF?=
 =?utf-8?B?UHpoQzRrSUE1cm9qTUk5dnpXczJaWVYrWjBXS0FlZTBvZit6RkFjMGlLVnhY?=
 =?utf-8?B?V3c1d1dtUDh6Q1NmbFQxNHQvZHBxRDhOTzNnaTFOZmxtcnBORjNLeWI2VG9s?=
 =?utf-8?B?R3VnbEsvZ3NNY3ozNG4zczNtOHg2TU5xa3kzNHRlN0ptQzN3eURHZ01YTGpE?=
 =?utf-8?B?cUhwbjNrVDExTENTSiszUitQMjZFRjNnUkJMSDJCYXFWQ0MwYTRDMVl3UTUv?=
 =?utf-8?B?N2tzZjVSN2NCR1Avb0hSb1k4L1BMZFNkUCt3TFJJYUpMS0JPWURLdXpxSUZn?=
 =?utf-8?B?cndHcDhqK2JFRnRkTFRRK3QxOG0xRUFtYTkvZjlFUERrV0JJekJaYnc1QUIy?=
 =?utf-8?B?NEFWajdlUGJNSUEzeFhTRVJSbnEzeTBvUzZCVnFMS3psVUtubDVmNk1na2ZL?=
 =?utf-8?B?U2pLZEVSNkhpTFk2WXR0alFlK1BGZVl3di9aTWN4Z1lEdnV6RENBTlk4RVhJ?=
 =?utf-8?B?ZzQrMWFxeWxpM0tXOWtvREs0TnVTNExzUUZ4bHcydkthdkJFbHJPUXJVMTZM?=
 =?utf-8?B?bXZnNXlEcUU5RlgrUDk0MkVmWnlYYTRDL1BEeCt0VUNBbkpiU3oxVHh2SjNs?=
 =?utf-8?B?Q0l3MVAzQ3JrL2dlWjNUYVpBRFFhdC9WYjhCRFZ0a0I2L1ZHYlRVdFJTSkNO?=
 =?utf-8?B?ekFwcGJvQ05NSnJuckhaditYc0p3VkgyeGNIN2lRM3dxS2h1S0JDb2c4WXRu?=
 =?utf-8?B?bHgxMVZ1K1JGdWNHckZsSlNhMDNXWi9PbVhpYVRsOFordVU1bWhyNUdWcWNQ?=
 =?utf-8?B?VEF4THJBSWsxM0VpbDdURDlLY2hDUWNFYS9OR0RaU1lwQUxhY2d0UUMzejRh?=
 =?utf-8?B?VTg3enNrSlpPT3ZTWTFuWFEyZGEwM0poVzMwUG9PVUNFMmQ4dkVjUUMwMDBM?=
 =?utf-8?B?L2ttYWJOOUhCU3pHNEZZNzVZVmF1Q1pZMWxQMWR4SERxdnBRd2hlZEN0aVQ3?=
 =?utf-8?B?WVQwNERIWmlvazFaOVdrWldqUHdndGZxaUoyRDNIYXVBN3pMK3h6YzhQZ2hP?=
 =?utf-8?B?TTh1T0xNeDJWWjA1WVo5TVB6K0NpeGN1Sm9iWUpVem43dGh1dHJCMCtvZEhl?=
 =?utf-8?B?anpXbWJNWTVpUHJ3SE1IZTVJRUtuaTNXdmo3OHdkYm93VzNvMDVvSjVTK0Zh?=
 =?utf-8?B?SWNpZU9MbmlhTXdDL0ZwSXVNK0VlY0t6TVQwTlZxem1IdENTY0dSckF1RWxk?=
 =?utf-8?B?QkRURWVHNUdQTDFyWnoya00ySC9NNXdyMmtGQ0lIbThxOTZ3YWtLaktWcDVT?=
 =?utf-8?B?NHo2UU5zWndaR0xMYm8rcm5pTTh5Z1crYmNPcXJldHZmdHZheVB6WjZrYXNU?=
 =?utf-8?B?RlI1UEtZa3UyakdDVHJicmJsTVNjTjczZWdJMXZhUDkrK2NEUXJEeWpRckJL?=
 =?utf-8?B?YWFzbElhUW1ZbjcwaUhCd00yQXVqSHg1MGhoRGEyZ0NMNTJweGZlKzQzbUFX?=
 =?utf-8?B?WnVneGlqeHZPOEF1bjF4LzR2TmVlS2RnMkhhUFp2aWVra2M5djZqNlNXQllZ?=
 =?utf-8?B?cUJWeHl2UXRkYkt0aW5JcWVvb1VCNGpFYWNBS1NCVjloQW5tSTZMME1KSjFW?=
 =?utf-8?B?TUYwVnNiUlJDMzd6SzE2cXZFcXZpdjMxT1p5UUVkbStEdmVtcHdCT2duTjA5?=
 =?utf-8?B?Q3BIT3duN0xqcVRydm00RHpRWHh6OVFNTzlGK1V6dDhXWG5nTXFJRFhyZG9x?=
 =?utf-8?B?ZnI3LzNoeHczOFdBbEFnL2d2MUZWL3ZqakUxOGkwbXdiV29PbENJL2daYkc0?=
 =?utf-8?B?UnJxcDhUTDJzS2QwMUc1eGVvWDloSFZHdVFOWXpWYmMrcktMQlJCODVEZmFF?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c0d744-6cec-437d-e221-08dc76410c46
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 07:14:53.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Ib8maq9Bh87yVZCbi3OMto1Ge63szUGdUngqM11Kz8HBQV68KZm0agFbP7ouiMYhCZ3lRnRuPUBy2sCj2ZFtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7486
X-OriginatorOrg: intel.com

Hi Yuntao,

Greeting!

On 2024-04-14 at 19:28:16 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    7efd0a74039f Merge tag 'ata-6.9-rc4' of git://git.kernel.=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1358aeed18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D285be8dd6baeb=
438
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da7f061d2d161545=
38c58
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20

I used syzkaller and could reproduce the similar issue "WARNING in
get_page_from_freelist" in v6.9 mainline kernel.

Bisected and found first bad commit:
"
816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_de=
stination_range()
"
Revert above commit on top of v6.9 kernel this issue was gone.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240=
517_085953_get_page_from_freelist
mount_*.gz are in above link.
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/=
main/240517_085953_get_page_from_freelist/rep.c
Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/b=
lob/main/240517_085953_get_page_from_freelist/repro.prog
Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/2405=
17_085953_get_page_from_freelist/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob=
/main/240517_085953_get_page_from_freelist/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_08=
5953_get_page_from_freelist/bisect_info.log
v6.9 dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085=
953_get_page_from_freelist/a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6_dmesg.l=
og
v6.9 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240517_08=
5953_get_page_from_freelist/bzImage_a38297e3fb012ddfa7ce0321a7e5a8daeb1872b=
6.tar.gz

[   17.436013] loop0: detected capacity change from 0 to 1024
[   17.456160] I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 p=
hys_seg 1 prio class 0
[   17.456746] loop0: detected capacity change from 0 to 1024
[   17.456809] I/O error, dev loop0, sector 16 op 0x0:(READ) flags 0x80700 =
phys_seg 1 prio class 0
[   17.457548] EXT4-fs: Invalid want_extra_isize 0
[   17.575984] repro: page allocation failure: order:1, mode:0x10cc0(GFP_KE=
RNEL|__GFP_NORETRY), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
[   17.576621] CPU: 1 PID: 726 Comm: repro Not tainted 6.9.0-a38297e3fb01+ =
#1
[   17.576930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.577412] Call Trace:
[   17.577526]  <TASK>
[   17.577626]  dump_stack_lvl+0x121/0x150
[   17.577813]  dump_stack+0x19/0x20
[   17.577969]  warn_alloc+0x218/0x350
[   17.578133]  ? __pfx_warn_alloc+0x10/0x10
[   17.578317]  ? __alloc_pages_direct_compact+0x130/0xa00
[   17.578552]  ? __pfx___alloc_pages_direct_compact+0x10/0x10
[   17.578803]  ? __drain_all_pages+0x27b/0x480
[   17.579021]  __alloc_pages_slowpath.constprop.0+0x1b62/0x2160
[   17.579291]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
[   17.579569]  ? __pfx_get_page_from_freelist+0x10/0x10
[   17.579802]  ? prepare_alloc_pages.constprop.0+0x15b/0x4f0
[   17.580032]  __alloc_pages+0x48f/0x580
[   17.580212]  ? __pfx___alloc_pages+0x10/0x10
[   17.580392]  ? kasan_save_stack+0x40/0x60
[   17.580583]  ? kasan_save_stack+0x2c/0x60
[   17.580772]  ? kasan_save_track+0x18/0x40
[   17.580946]  ? _find_first_bit+0x95/0xc0
[   17.581114]  ? policy_nodemask+0xf9/0x450
[   17.581300]  alloc_pages_mpol+0x296/0x590
[   17.581487]  ? __pfx_alloc_pages_mpol+0x10/0x10
[   17.581695]  ? arch_kexec_post_alloc_pages+0x37/0x70
[   17.581924]  ? __pfx_write_comp_data+0x10/0x10
[   17.582133]  alloc_pages+0x13f/0x160
[   17.582302]  kimage_alloc_pages+0x79/0x240
[   17.582498]  kimage_alloc_control_pages+0x1cb/0xa60
[   17.582727]  ? __pfx_kimage_alloc_control_pages+0x10/0x10
[   17.582973]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   17.583224]  do_kexec_load+0x337/0x750
[   17.583406]  __x64_sys_kexec_load+0x1cc/0x240
[   17.583619]  x64_sys_call+0x1aa2/0x20c0
[   17.583807]  do_syscall_64+0x6f/0x150
[   17.583988]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.584217] RIP: 0033:0x7f4f2ec3ee5d
[   17.584382] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   17.585171] RSP: 002b:00007ffd101da888 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000f6
[   17.585500] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4f2ec=
3ee5d
[   17.585985] RDX: 00000000200003c0 RSI: 0000000000000002 RDI: 00000000000=
00000
[   17.586346] RBP: 00007ffd101da8a0 R08: 0000000000000800 R09: 00000000000=
00800
[   17.586656] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd101=
da9b8
[   17.587001] R13: 0000000000402862 R14: 0000000000412e08 R15: 00007f4f2ef=
30000
[   17.587381]  </TASK>
[   17.587559] Mem-Info:
[   17.587667] active_anon:117 inactive_anon:14235 isolated_anon:0
[   17.587667]  active_file:25278 inactive_file:25394 isolated_file:0
[   17.587667]  unevictable:0 dirty:82 writeback:189
[   17.587667]  slab_reclaimable:14774 slab_unreclaimable:23678
[   17.587667]  mapped:13500 shmem:1187 pagetables:846
[   17.587667]  sec_pagetables:0 bounce:0
[   17.587667]  kernel_misc_reclaimable:0
[   17.587667]  free:13396 free_pcp:37 free_cma:0
[   17.589349] Node 0 active_anon:468kB inactive_anon:56940kB active_file:1=
01112kB inactive_file:101576kB unevictable:0kB isolated(anon):0kB isolated(=
file):0kB mapped:54000kB dirty:328kB writeback:756kB shmem:4748kB shmem_thp=
:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:5504kB=
 pagetables:3384kB sec_pagetables:0kB all_unreclaimable? no
[   17.590712] Node 0 DMA free:6664kB boost:0kB min:424kB low:528kB high:63=
2kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0=
kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB manag=
ed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   17.591848] lowmem_reserve[]: 0 1564 1564 1564 1564
[   17.592075] Node 0 DMA32 free:46920kB boost:0kB min:44628kB low:55784kB =
high:66940kB reserved_highatomic:0KB active_anon:468kB inactive_anon:56940k=
B active_file:101072kB inactive_file:101568kB unevictable:0kB writepending:=
1504kB present:2080640kB managed:1620324kB mlocked:0kB bounce:0kB free_pcp:=
468kB local_pcp:0kB free_cma:0kB
[   17.593443] lowmem_reserve[]: 0 0 0 0 0
[   17.593624] Node 0 DMA: 0*4kB 2*8kB (UM) 1*16kB (M) 1*32kB (M) 1*64kB (M=
) 1*128kB (M) 1*256kB (M) 2*512kB (UM) 1*1024kB (M) 0*2048kB 1*4096kB (M) =
=3D 6656kB
[   17.594261] Node 0 DMA32: 770*4kB (UME) 193*8kB (UME) 121*16kB (UME) 72*=
32kB (UME) 39*64kB (UME) 15*128kB (ME) 7*256kB (UM) 4*512kB (ME) 2*1024kB (=
UM) 4*2048kB (UME) 5*4096kB (M) =3D 47840kB
[   17.595020] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D1048576kB
[   17.595399] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=
=3D0 hugepages_size=3D2048kB
[   17.595774] 51855 total pagecache pages
[   17.595949] 0 pages in swap cache
[   17.596170] Free swap  =3D 0kB
[   17.596304] Total swap =3D 0kB
[   17.596440] 524158 pages RAM
[   17.596589] 0 pages HighMem/MovableOnly
[   17.596767] 115237 pages reserved
[   17.596934] 0 pages cma reserved
[   17.597149] 0 pages hwpoisoned
[   17.645660] kexec: Could not allocate control_code_buffer
[   17.785654] loop0: detected capacity change from 0 to 65536
[   17.787652] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   17.787652] WARNING: The mand mount option has been deprecated and
[   17.787652]          and is ignored by this kernel. Remove the mand
[   17.787652]          option from the mount to silence this warning.
[   17.787652] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   17.801532] XFS (loop0): cannot change alignment: superblock does not su=
pport data alignment
[   17.878479] loop0: detected capacity change from 0 to 1024
[   17.888666] I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 p=
hys_seg 1 prio class 0
[   17.894988] loop0: detected capacity change from 0 to 1024
[   17.895613] EXT4-fs: Invalid want_extra_isize 0
[   17.909948] loop0: detected capacity change from 0 to 128
[   18.105190] kexec: Could not allocate control_code_buffer

Hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if =
you
already have one reproduced environment, please ignore the following inform=
ation.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.=
1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v=
6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,readonl=
y=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc ha=
s

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --ena=
ble-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!


> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
bc7510fe41f/non_bootable_disk-7efd0a74.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/39eb4e17e7f0/vmlinu=
x-7efd0a74.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b9a08c36e0ca/b=
zImage-7efd0a74.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.9.0-rc3-syzkaller-00355-g7efd0a74039f #0 Not tainted
> ------------------------------------------------------
> syz-executor.2/7645 is trying to acquire lock:
> ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: rmqueue_buddy mm/page_all=
oc.c:2730 [inline]
> ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: rmqueue mm/page_alloc.c:2=
911 [inline]
> ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: get_page_from_freelist+0x=
4b9/0x3780 mm/page_alloc.c:3314
>=20
> but task is already holding lock:
> ffff88802c8739f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xd=
d0 kernel/bpf/lpm_trie.c:324
>=20
> which lock already depends on the new lock.
>=20
>=20
> the existing dependency chain (in reverse order) is:
>=20
> -> #1 (&trie->lock){-.-.}-{2:2}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inli=
ne]
>        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>        trie_delete_elem+0xb0/0x7e0 kernel/bpf/lpm_trie.c:451
>        ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
>        __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
>        bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>        __bpf_prog_run include/linux/filter.h:657 [inline]
>        bpf_prog_run include/linux/filter.h:664 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>        bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
>        __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:=
122
>        trace_contention_end.constprop.0+0xea/0x170 include/trace/events/l=
ock.h:122
>        __pv_queued_spin_lock_slowpath+0x266/0xc80 kernel/locking/qspinloc=
k.c:560
>        pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [=
inline]
>        queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inl=
ine]
>        queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>        do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inli=
ne]
>        _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
>        rmqueue_bulk mm/page_alloc.c:2131 [inline]
>        __rmqueue_pcplist+0x5a8/0x1b00 mm/page_alloc.c:2826
>        rmqueue_pcplist mm/page_alloc.c:2868 [inline]
>        rmqueue mm/page_alloc.c:2905 [inline]
>        get_page_from_freelist+0xbaa/0x3780 mm/page_alloc.c:3314
>        __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
>        __alloc_pages_node include/linux/gfp.h:238 [inline]
>        alloc_pages_node include/linux/gfp.h:261 [inline]
>        alloc_slab_page mm/slub.c:2175 [inline]
>        allocate_slab mm/slub.c:2338 [inline]
>        new_slab+0xcc/0x3a0 mm/slub.c:2391
>        ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
>        __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
>        __slab_alloc_node mm/slub.c:3663 [inline]
>        slab_alloc_node mm/slub.c:3835 [inline]
>        __do_kmalloc_node mm/slub.c:3965 [inline]
>        __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:3986
>        kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
>        __alloc_skb+0x164/0x380 net/core/skbuff.c:668
>        alloc_skb include/linux/skbuff.h:1313 [inline]
>        nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
>        nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
>        nsim_dev_trap_report_work+0x2a4/0xc80 drivers/net/netdevsim/dev.c:=
850
>        process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
>        process_scheduled_works kernel/workqueue.c:3335 [inline]
>        worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
>        kthread+0x2c1/0x3a0 kernel/kthread.c:388
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>=20
> -> #0 (&zone->lock){-.-.}-{2:2}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain kernel/locking/lockdep.c:3869 [inline]
>        __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>        lock_acquire kernel/locking/lockdep.c:5754 [inline]
>        lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inli=
ne]
>        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>        rmqueue_buddy mm/page_alloc.c:2730 [inline]
>        rmqueue mm/page_alloc.c:2911 [inline]
>        get_page_from_freelist+0x4b9/0x3780 mm/page_alloc.c:3314
>        __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
>        __alloc_pages_node include/linux/gfp.h:238 [inline]
>        alloc_pages_node include/linux/gfp.h:261 [inline]
>        __kmalloc_large_node+0x7f/0x1a0 mm/slub.c:3911
>        __do_kmalloc_node mm/slub.c:3954 [inline]
>        __kmalloc_node.cold+0x5/0x5f mm/slub.c:3973
>        kmalloc_node include/linux/slab.h:648 [inline]
>        bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
>        lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
>        trie_update_elem+0x1ef/0xdd0 kernel/bpf/lpm_trie.c:333
>        bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
>        map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
>        __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5648
>        __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
>        __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
>        __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> other info that might help us debug this:
>=20
>  Possible unsafe locking scenario:
>=20
>        CPU0                    CPU1
>        ----                    ----
>   lock(&trie->lock);
>                                lock(&zone->lock);
>                                lock(&trie->lock);
>   lock(&zone->lock);
>=20
>  *** DEADLOCK ***
>=20
> 2 locks held by syz-executor.2/7645:
>  #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:329 [inline]
>  #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:781 [inline]
>  #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_val=
ue+0x24b/0x6c0 kernel/bpf/syscall.c:202
>  #1: ffff88802c8739f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc=
8/0xdd0 kernel/bpf/lpm_trie.c:324
>=20
> stack backtrace:
> CPU: 1 PID: 7645 Comm: syz-executor.2 Not tainted 6.9.0-rc3-syzkaller-003=
55-g7efd0a74039f #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
>  check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain kernel/locking/lockdep.c:3869 [inline]
>  __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>  lock_acquire kernel/locking/lockdep.c:5754 [inline]
>  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>  rmqueue_buddy mm/page_alloc.c:2730 [inline]
>  rmqueue mm/page_alloc.c:2911 [inline]
>  get_page_from_freelist+0x4b9/0x3780 mm/page_alloc.c:3314
>  __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
>  alloc_pages_node include/linux/gfp.h:261 [inline]
>  __kmalloc_large_node+0x7f/0x1a0 mm/slub.c:3911
>  __do_kmalloc_node mm/slub.c:3954 [inline]
>  __kmalloc_node.cold+0x5/0x5f mm/slub.c:3973
>  kmalloc_node include/linux/slab.h:648 [inline]
>  bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
>  lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
>  trie_update_elem+0x1ef/0xdd0 kernel/bpf/lpm_trie.c:333
>  bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
>  map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
>  __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5648
>  __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fdb1c27de69
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdb1d0210c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fdb1c3abf80 RCX: 00007fdb1c27de69
> RDX: 0000000000000020 RSI: 0000000020001400 RDI: 0000000000000002
> RBP: 00007fdb1c2ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fdb1c3abf80 R15: 00007ffe7cd30f08
>  </TASK>
> loop2: detected capacity change from 0 to 512
> ext4: Unknown parameter '=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD3;=EF=BF=BD{\C	_r=EF=BF=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BDgD=19Z*=
=EF=BF=BD=EF=BF=BD=D7=92=EF=BF=BDMd=EF=BF=BD;=EF=BF=BDs=EF=BF=BD8)V=1B=EF=
=BF=BDZ=EF=BF=BD-#=EF=BF=BD=EF=BF=BDS%=19=EF=BF=BDSY=EF=BF=BDE`1t=10AS=EF=
=BF=BD>=EF=BF=BD>=EF=BF=BD=EF=BF=BD=EF=BF=BD=0Ed]=EF=BF=BDx=EF=BF=BD=EF=BF=
=BDh'
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

