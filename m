Return-Path: <bpf+bounces-30982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97418D55F5
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 01:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0A61C242D1
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 23:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315C183A61;
	Thu, 30 May 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dnojee2b"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C731E488;
	Thu, 30 May 2024 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110290; cv=fail; b=qfqSXAj3I0OizH089PAGbfBRHgK7YVmAzHDhfe19cFpbys6J9NHyJT+gjjO55vsdwmnKW72xEHqhJnU1tzs6qki6cvYbPTN5VcPy1wUvPVtrcQei1Ff20ic5+nMR+RJgK1+g1hpYAV/IRbrT3pBugwXg6iOBbDooPq2YCMjIICc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110290; c=relaxed/simple;
	bh=ov4EZGgob86vQpeH/DJFKKEAW+Urn/0vcG01HP17IwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k3XwBpDTZSPjRX8MMBEosEew1UIfbtAhH7sqKaR1GhpCUAuQEMJs0LdNAroGd9hIw+W/wXmMxEvNyfTNgNUMnl2G7/VcbQC0+C4gLBe8Sm5nLKzSvd1PD2OksAy7trAh8m11yldABA6FbpHIx52HKu4Q+ZDfs7/pWFWDjixpUks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dnojee2b; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717110290; x=1748646290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ov4EZGgob86vQpeH/DJFKKEAW+Urn/0vcG01HP17IwA=;
  b=Dnojee2b+rDJAWbYQYRs5KfLWvP3lgSIcjcTwqYsmLfosA4MX8EMtk/6
   JJx2o2QBThA5t+0H7/C69kcdelZVDCn2yKJJaewzKEgOZGmHqomVhnLOM
   Rrpsd9bXSVl8N/WxE1j5ESN5TcCeowUD9iCWqj9y8qymWrF7qLmQebNph
   EMu5Whv2GEAXyQ9fzkQGXDCRFukToWFJGs7ejL24lmT+MU5GPAWkNnLO5
   RkoFvwuEQ+nKG8FGu6hsMKP2nbMG9eIgvbqUQmEFI5jlJErVqLHxYLaIh
   4aV8PdchmJc4bl6ew1EdZBDPPxtamoBRCcBqKhPFy5sfeHuBDh0HIVy7C
   w==;
X-CSE-ConnectionGUID: WTPm/BRGSJaKkTGc60Z1xw==
X-CSE-MsgGUID: fm06Tx+rTVKLP6gfH9DNlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24195943"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24195943"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 16:04:49 -0700
X-CSE-ConnectionGUID: dwnyYFtCQQOf56J5u6ICRw==
X-CSE-MsgGUID: NDHu51gsSYq/K1TMZMwfHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36069071"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 16:04:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 16:04:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 16:04:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 16:04:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 16:04:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGqwyadiydVxZju9FUm8zqcDKNqPB65tihMfXKNh/cyN06pfNZv7GAQ0yGoHeiQxJsJ5xHDcsf2mIPCzpBdNbddck+0nl6nhXycZ7WJa4dTFExgfJ8zCLcH3htRm7uE/9Pb5/YXQ6VLO9PtKQb7fTQ51qCnWxgsxQepKSR2QplmOWEwkZ8rM9o6wOrWR/t6X43LaRe1uK+lQzJo1x9dJN6eF3bgsOhSn88UAky2e4kQU6etG/GusTxFaqvwqCVpJjrLKjB1k1P4KmtCmoB2Qb0f8nNse0NGpBp73syD9ztdTf0Pw4xxVSYbPmGsXorJTpKIUHqGxWtFzRVwRShMSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov4EZGgob86vQpeH/DJFKKEAW+Urn/0vcG01HP17IwA=;
 b=Tf27U70Quo2BHRYNiH93Gocm0YAXOyYhaxM7GivojOFzC6XM65f/8GHgIHruSsBA+yZDdPpfzaS1ocEt2W01VYXcYDMd376ElSENn27xNCD/jXd2SQld4xfmUXtHjRl4saXZ0TuqEyOkWwd2870I7yNkyOv/DN535Jfo3xkTUYcTRit5GQVBEzi9ZAcoNbgXYAOxFWnyDEVXfH43uEkDS8dpAVFQnvwj7scWIrgy0/hkF/R9VcKdC82eG76cZChUSHpAukmIpPDUHkSPROYTS81e10u4D+MGIqZp7Epw6jIxHKoOKvB6tUE4nNA5Z8APnTxpekecRVzAOrYS6BTSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB6573.namprd11.prod.outlook.com (2603:10b6:a03:44d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 30 May
 2024 23:04:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 23:04:37 +0000
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
Subject: Re: [PATCHv6 bpf-next 1/9] x86/shstk: Make return uprobe work with
 shadow stack
Thread-Topic: [PATCHv6 bpf-next 1/9] x86/shstk: Make return uprobe work with
 shadow stack
Thread-Index: AQHaq2x9FDy849/8iEm3V2kN/KUeoLGwdKIA
Date: Thu, 30 May 2024 23:04:37 +0000
Message-ID: <8b70a995dda46c020c9e7c78f0e68560f0b61441.camel@intel.com>
References: <20240521104825.1060966-1-jolsa@kernel.org>
	 <20240521104825.1060966-2-jolsa@kernel.org>
In-Reply-To: <20240521104825.1060966-2-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB6573:EE_
x-ms-office365-filtering-correlation-id: 847fefed-9543-403a-69c7-08dc80fce0e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YzNHOUw4UHo5WGNRREJpZjIySjdiT0pPdXgzbTJhNTFldktweUpPTjhiL2Y5?=
 =?utf-8?B?WTQ3Q1kwTXRZb25PZElGbUV2bGVjTUxJUHJySEJJbDdnT2RYVTh0bnRZZnZI?=
 =?utf-8?B?R0ZSTFJmbTNwNVF5dDhnb3E5Y3FYQVlJSmppUDZidEdpUVh1U0grWEpGOFhm?=
 =?utf-8?B?RWF6K1lzUjZkUmFPaU1uWU81T3RjTURKbm9kSUhoV3hwaktreUVKQjJVNjMx?=
 =?utf-8?B?TFJSb1c2NEVuWlVzQ3phRGxlbHpBY0Y5dzZ1ZTNuTjhHeFZkWmszVThDL1Ni?=
 =?utf-8?B?NXFsZkRRS0QxaDRjNVBSaUZDVWdFcTBJQVo0OGtmK0xSMzJaNUpoVVFwaVZl?=
 =?utf-8?B?WlZRQk1Yd2JkQnVBc0V5SFBuNmNyZGRMNURSSGpsSEVuS0JQTmY1OXVkU2hk?=
 =?utf-8?B?UzhqZXgwWnl6SVJpRGFoOXhQQmxKS1Bid1ZQUThwUWFCSXd4R1BaajZhQkZ1?=
 =?utf-8?B?NlhHaHQrM2I3a2NtNGdMZjdIY29RVlhKVjNtNTVKTllNeC82aWJtaTA2V3FJ?=
 =?utf-8?B?VlJ6dFFYRWhFTi9iVFQxeC9nMVI2V1NEZmVCNDVKZk5wRWJTU2dsR0lKUG9l?=
 =?utf-8?B?REVVV1BlRXZrSzFRaFJiWEhKcDdmbHJHZnFtRE9zQVkvYWxELzJkL2JMc0pM?=
 =?utf-8?B?TEJQd3ByelZTRjRMbGFIVnVaZW9MSU9JMGlNem0zVU1wa3o0ckVMc2VXU1RL?=
 =?utf-8?B?TUlzSzZ5ZzJnZlpLOEhqNVQ1RGdiSEx0RE1JZTUzUHRpWEdVcFBkOGhUK2tO?=
 =?utf-8?B?dDdTc0RiaGpja2RmY1N2VGlIUmZqMXR4UUJPSHlCcTVSV1Ardkc4YWRxS2l6?=
 =?utf-8?B?d2RpS2wwb0w4ZDB1TC8zRGJIdWVsV3IvWTlGMEZqZWFvK0Z3dVo0WmhlU3ha?=
 =?utf-8?B?OWk5djB4bjE0RkNHWkFpek1pb0tkcmQxODhqaFp6UTNmUWVUenBvbkV4eFg3?=
 =?utf-8?B?eGRGbytBaGJKUm1yRVg3c1Y0bENrVzVxbEgvWkZmakoyN0dhcVgyTERkaWNm?=
 =?utf-8?B?ejZOLzJPR2tLWDJjS2tUcExQNVhRY28zdVh1M01IMmNrK1V4dGJFQ1U0MHlL?=
 =?utf-8?B?WkNiRkw2d3pnSnZGcVE5S1M0Si9aNlNQS1Y4RUJOVmQwcnpxR2NzWkpPeUYr?=
 =?utf-8?B?QjNzUnorUVhUVGRYRk9OaytTaGY1UXZGMjRON2NZMUs5VlVQOHJ0a0xqWmxD?=
 =?utf-8?B?TUNrQ1l6Q0RGQTFidU0rNFczdXZpNHFWWjJNdGRGaUhsMWs5ek9rUHk1K2hK?=
 =?utf-8?B?cExEcEtLOTZkZVNSbzZaaUMzWmdKbHZBKzlUTVM1Q1RKS3R0Wm9GNTg2WWNz?=
 =?utf-8?B?ZnliVmtXeVJqUnN6eDYzWlp6d2FmQXZYUFU1T2lqckdMcnNMTk92bVVLQzRP?=
 =?utf-8?B?ZlNwdndiWDFaMm53WjR3cDVTS3RoUG5GMlRGTmg2ZFJtVlVOUGQySWgwU2s3?=
 =?utf-8?B?M3BKVlV6Y0g2Q2RXUWRDTWhMYnhMWk9BY29FamlieHNIVWl0UjBZY3FGbzdu?=
 =?utf-8?B?Mzg3bzd0ajgzWVFDUDhLSjUxb0dGVzV5NjRLYzlDTkRtWXhhZ1VKZTBFRmhm?=
 =?utf-8?B?MytIRDQzSTFTb1lEOTRxYVlrODYvb3FCb2FWTTF6Um5BRHNpS0hBdVhCajZG?=
 =?utf-8?B?dnBjUTVZR1RadWpYRTBMSjEzOWkyN1pJZTREWnpIZmRqQ0pzcUo1bWxNUGUy?=
 =?utf-8?B?OGJLL0hpWkZxbmRuTWozNHBVUWpzVStuQWlzZS9USzRxak9iRkVIdHc2d3JI?=
 =?utf-8?B?aUhPZk16U3dqbjZ5UUN1cmxHQkd3RmFGQWpPMDRhVEk2RmMvSlNPVW0wczl5?=
 =?utf-8?B?NTVzOTVCZFlmS3VKellFZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkxWeEwrOE8vdHY5QTNPM0MrTS9EK1YvR2xuVnBtWUNxeTFXVXlUWC9leFFn?=
 =?utf-8?B?c0FqNmFEYVBYbHJrZ1hjamRKbi8za1BlbFRuV3JFVUFtWGJtVnhtNmZ0L1pX?=
 =?utf-8?B?dWhNQzBvRzRiMVViZFBWelllV3FvN01ma0RpQVh5dnh3Z3RtY1lLODk4aDlu?=
 =?utf-8?B?RHgyWEliZ2JEUkloNzlUblBKU20zNjRnQXhSdXp0SVEzcnMvU1c4K1NRT0Ro?=
 =?utf-8?B?VUt1azFBY014S1FxTG42SzZQQUJiUVJNUTE1L09VOHlUbEZuNkk5TmkrV3Ro?=
 =?utf-8?B?NlRzbzRHZHFoT29BdFJQVEtKOHlQVFFwaWxpb0VzbEE5enM2MmlEMVVIYXFT?=
 =?utf-8?B?OTFoOWZYUStCUStGV1gzVVIreHhqM0tkYlBSZHczWW5Oci9XaWlLUEowZC8y?=
 =?utf-8?B?QUgxVlcrMFAzSE1pZGJ0aHpxM01EVFlxUmZnUkdmRXZnVkFrYzVJZnBxd2tu?=
 =?utf-8?B?eUV5aGFVOFBBUFJaNFJ4N1oyejZKdm5ZM3E1WXBuVkEwR2lnYXI3ZWhiNms4?=
 =?utf-8?B?YWNlMTg2UUtwUXRjRC96czZxR1YzOVJRM2hpMHAwaG82emN3SEpUYkxqdWVT?=
 =?utf-8?B?QkRvdDJwWVQzWDhPM2xhcmxkN3ZBdzEwTU9nMzMzSnpFQmFxQXcvOHVkc2pV?=
 =?utf-8?B?MFZXSkExc25oSUtBWktDWWkya1d3cjZ2U3ROQVVUVk81T0w5czMxT2h5SUll?=
 =?utf-8?B?a2FaQXh5RDE2YWdka1RkRUlZUTR2ZGxoUzZrUnd4UG5PVFRqazZNb0RVNDc1?=
 =?utf-8?B?MFBPd2ZubVc4VEhhT05BYm9EU1c2ZjhSNW44Ym5ocEF0M3JDSkkrMGdTODRu?=
 =?utf-8?B?OURXZ0xiM0VKNS9GYnlSUzZ3aktWc0t3SmF2bW00OUcvYjB1ZXFza1dONEl2?=
 =?utf-8?B?ODlORlZhL1gwOUh4cmY1S2JDNXVEa3BaNDNUT3JIMTN6c0d4RERDSlZRREIr?=
 =?utf-8?B?RHUweWRCZUJEVDdWeWNJcUExM2RIUHRoSWJ3OThHVHp6THA0UnMwNEhlaWEz?=
 =?utf-8?B?Wmt5K1hOekxXRUo3YUFqaTIrcGtHT2g1eWduNFNrMk5vck1DZ0VmdXd1dnZP?=
 =?utf-8?B?Y2RUTTA3K0ZFeit4OW1ONWY2UnNjWXFSNTk0NThBMVYwc1g3WnVTcXRBZm92?=
 =?utf-8?B?eW1BSlo5ME04ZFQzSFUxL3FtSjJPaGd1VVppZkpjWDdHRDlrSVBDQ2lxMnJN?=
 =?utf-8?B?TFdXNXNSRTFmMHF5SXN6VzRDZm5iT2ovbUVmSmhRdnYyY2JQN1JHM0hCUlFa?=
 =?utf-8?B?RmJwU1ozNVE5VU1RZmRmTGl0aUlyR3hBcm5Qa0RiTkdWeVNVQWlYU0tBOU5H?=
 =?utf-8?B?R3BUM3RYa25ka01YUFY3M25wUjgrMWJXK05CMmZZdW5lNEwxWXY0NHlXMlRH?=
 =?utf-8?B?MWFjMUZVMWpUaUI5TVowaE1HeUVJZTVYakl2ZERPdEhEK0VZNGVCeTRMUDNz?=
 =?utf-8?B?WlMvWXhlM3o5RmM0UzgrTDRJUGNxU1RHODZZVTNEOXdnU1ZMbG85Vll1c3BF?=
 =?utf-8?B?OXZNamdFQktpbmFsWmMwaFlUUlRqakMxZGFjS2tvRDdYMkZqRlBiY29kVXlL?=
 =?utf-8?B?amVoV0dkVm5lcEdLSS85SXJyTlJLNHQ1bVI3MWZieGJtbWMyVmppOXk1OXE4?=
 =?utf-8?B?TDVibEJaeENpTFVadFE2MGtuck8raDB4empsaDBuZGxXTi9Zb1pMOUs3L1hx?=
 =?utf-8?B?ZXoxSldNNG5wdnpOMjA1UnVGejdWalFqd1RjL3krSUJJVEV3aFB2WURsSVRL?=
 =?utf-8?B?U09HRG1DVGh0ZCt1c0M5R0F1cGY5MjNRYU5uL0UxSU5uQzJaWlJlelhNS2xu?=
 =?utf-8?B?azZ5Y2g1YXhMelBFd202MUhGbDdJdGY0aE0xUkNjRGhtZmhJWFl1dVRvQkxJ?=
 =?utf-8?B?R08rNFZ5NEljUGoyams1NkJZd0FDMWpkV0ZrUXA1QTlraXpCMWg3WWlSNHM0?=
 =?utf-8?B?SkFhek9YVEdzeSthZUl1M1g5bWNOMGluUUFSdU5sVjJDK2c4TDh6ZzcrZDc1?=
 =?utf-8?B?MVRNbTA4dFFkbU1Vd2ppUnNHdktQZzdhek1seG5kYWwyVVQxeEVNOUhqdW53?=
 =?utf-8?B?V0wzY2RLNGRGQit3ZmVoYzVrYkkwekVZSU0wUTRJYzc0VUUyRjBNR3pGbVlJ?=
 =?utf-8?B?V2MrampHWExpZjVINTJTRnBObnFPWG53VDh1MnROeDUvcnVnQStmNTdueTRV?=
 =?utf-8?Q?rW2HEw84FXiV9EY2hHe04OM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94D93ABF3869C14DABD919AEEEA576DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847fefed-9543-403a-69c7-08dc80fce0e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 23:04:37.2548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOXFKdvdpOiy7STRau6nk5/UbNkeY08fa6o261WPhzBpiTu17B6uOReBb4xNYEfDcX6sFaE9+wikbz6vvP7ZHqw7KShIxk0rjg/hAHlaquE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6573
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA1LTIxIGF0IDEyOjQ4ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IEN1
cnJlbnRseSB0aGUgYXBwbGljYXRpb24gd2l0aCBlbmFibGVkIHNoYWRvdyBzdGFjayB3aWxsIGNy
YXNoDQo+IGlmIGl0IHNldHMgdXAgcmV0dXJuIHVwcm9iZS4gVGhlIHJlYXNvbiBpcyB0aGUgdXJl
dHByb2JlIGtlcm5lbA0KPiBjb2RlIGNoYW5nZXMgdGhlIHVzZXIgc3BhY2UgdGFzaydzIHN0YWNr
LCBidXQgZG9lcyBub3QgdXBkYXRlDQo+IHNoYWRvdyBzdGFjayBhY2NvcmRpbmdseS4NCj4gDQo+
IEFkZGluZyBuZXcgZnVuY3Rpb25zIHRvIHVwZGF0ZSB2YWx1ZXMgb24gc2hhZG93IHN0YWNrIGFu
ZCB1c2luZw0KPiB0aGVtIGluIHVwcm9iZSBjb2RlIHRvIGtlZXAgc2hhZG93IHN0YWNrIGluIHN5
bmMgd2l0aCB1cmV0cHJvYmUNCj4gY2hhbmdlcyB0byB1c2VyIHN0YWNrLg0KPiANCj4gRml4ZXM6
IDhiMWMyMzU0MzQzNiAoIng4Ni9zaHN0azogQWRkIHJldHVybiB1cHJvYmUgc3VwcG9ydCIpDQo+
IFNpZ25lZC1vZmYtYnk6IEppcmkgT2xzYSA8am9sc2FAa2VybmVsLm9yZz4NCj4gLS0tDQpBY2tl
ZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K

