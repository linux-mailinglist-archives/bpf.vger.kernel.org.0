Return-Path: <bpf+bounces-66096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC162B2E1B0
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 18:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDD95C3BA2
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4790322A01;
	Wed, 20 Aug 2025 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CER8fJ10"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921901DDC33;
	Wed, 20 Aug 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705501; cv=fail; b=k7O7ZIdRe7fJYW6Vra+UFmAwK9zpJzcTXnGNGsTMKoZpCwXDBYwZkWR38fy4i6+OrXwHu05joL3E6JDwBHXDibu29mDShQ1+EOtpLyyMK3KP7pUGqoLkupvPQMtkaIzNJvO5GnVELpdO/QsY2PMTXXIrh+ZNGbZM9nVQAhuyI8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705501; c=relaxed/simple;
	bh=iXvAZIFqPBl3m+uk4MdYej0soRXK00UzIDarZ9jFRdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u2NDgq4pEwlDVRO23SOzMfQ0XzybSm9VF57i5jy0ITJOvN+AuNNLjsPUP8RaF4Ixw+Aid0JINjAhq7+jJUG8+wZzsmgCkDRb61aDoJ0YyGQaMeq8ZSoz1wYChvO6FfEO8caXqfbe/5kptJIZNcgk7AsfQkS12f1zcbNsuGSDDEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CER8fJ10; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755705500; x=1787241500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iXvAZIFqPBl3m+uk4MdYej0soRXK00UzIDarZ9jFRdE=;
  b=CER8fJ10Ul6G2cwW4igl6wEFkQHP/3ygxcNsu3k9CSEio/hd188Km7BE
   s1fAKy/VjEGDX5Z8pxeDadUey634Q9/1ITwxJojLA0ux34eDYHGuCNbHk
   Rl5AEn9ACoh+ktsbNGvTPBO3HBLyzQXINvp5V/HqA/VEa7roFNLA+IMCX
   tJy/K6a8sLdeL9ZF1xkrvYpW8wxNVz/qvb2P3GiMfUb7emq0qAW8Ueu8V
   LOsNi8fV9F/1/ukSUc8+npg6AA8WV9CdSn6YFxF6SaIt7TxCbgl42V1WH
   sLfu387DChVvpknl24t02R0QOGra0+RALXvNQJbNSHWC7Q58YbQQBvr97
   w==;
X-CSE-ConnectionGUID: aViaKSsJQ6CrBFg4TohuUQ==
X-CSE-MsgGUID: f0CQTNciSfag4t/zfvhAXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57176821"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57176821"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:58:18 -0700
X-CSE-ConnectionGUID: I48UoAEYTm+R1rLLqgcE8Q==
X-CSE-MsgGUID: BQOrqZj0Q6y7lLnkCaDehQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168114188"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:58:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 08:58:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 08:58:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.57)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 08:58:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoUBpzX68dPMoCM3z8QMpBp9Z6mKXelWoz4gYPKuzZeFP2Sg4430wdWgtxnEw0f6soYcUnpeZ8uC611KFa+d8ObyfGo1e9MnHxr3UYqjt/jxUui93uq5eemx3CGiLvE64Lo5nAYc9dJsmf8BuEeyaK9i9Io8UU7hlEXGkN2Jkb/FWkZlOd24z5CBnuN4fJeSe/yXe5u0Qgx+xSrXmjy5hesdmddTW7bdoppIkENMxKrNm+727P5RbZZ6F4Nw71jsO9I0FmBDtSqjM61ZLAVTT3UQX3RTMQHIdDzS2r3kYT+MMWuhZDGUhSkwAVmOywriUSMrH2WuJd6CQSfjjRfGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXvAZIFqPBl3m+uk4MdYej0soRXK00UzIDarZ9jFRdE=;
 b=eoNlY83WChD3nvAW0v6Qs1tkAhaoVG0+lf51AWsp6/CwMQZrMZAfUR4DtEB4WwH9qpMlZnsPL5QCJNXhF5KN40zeXHO2OyWvsFaMbnxGfoEAwN/zK1JdcAZ/wDKSEDB/wJ8usJ5U94Mr/Oflb+dKtpCfGu+FLuAFwAz/mkEQB20KIHWbLn0y1+f8hpOc1e9U4BZdoWEp04DleWEqJQIhK+gPkK2bdUJAMwB9bNctlEkqAwneNif9nO5X7tE7M6r/A5wWyxAH7ngf61yxkhnb6Yxi4vzv9B4Sze05FLmZtEcAE/dLmyUYpqPWOv3hhte91Umh1EZhRIeuF61Bn2r9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 15:58:14 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 15:58:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "jolsa@kernel.org" <jolsa@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "alan.maguire@oracle.com"
	<alan.maguire@oracle.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "David.Laight@aculab.com"
	<David.Laight@aculab.com>, "yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com"
	<oleg@redhat.com>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "thomas@t-8ch.de" <thomas@t-8ch.de>,
	"haoluo@google.com" <haoluo@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Thread-Topic: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Thread-Index: AQHcEc5LWQgc1WQMikmopLJo2+WQ07RrstqA
Date: Wed, 20 Aug 2025 15:58:14 +0000
Message-ID: <9ece46a40ae89925312398780c3bc3518f229aff.camel@intel.com>
References: <20250720112133.244369-1-jolsa@kernel.org>
	 <20250720112133.244369-11-jolsa@kernel.org>
	 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
	 <20250820123033.GL3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250820123033.GL3245006@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB7956:EE_
x-ms-office365-filtering-correlation-id: 2914035a-0de2-4270-4e99-08dde0025f13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cGp3UEJQMmI0WFg5ZkRNc042Sy9MRmYzWmthRUZBMUN4TUxyQlpWRllqdnlx?=
 =?utf-8?B?VlhtUjh0T2xMOE9uQVBnL1pwWmUvcCttR0hCRERQeWdQSC9tMmE2Wi85VXBF?=
 =?utf-8?B?aVhLK0RBQ0NReGx1bUplb0tQb2svNGRwd0RVWjNLZ2ErOGxESFBxdEVubms2?=
 =?utf-8?B?S0F0NUJIYzhENUdxcVJ5Q0NKbGo4ejRxNzlKQXV3c1dTZHJwWWdqR01ucHY3?=
 =?utf-8?B?NnZXWmJDZytidU9wbGVTam9UV04wQ1ZlY2hmNVhKckQzZzdmSm1reC9MWm8z?=
 =?utf-8?B?VG5xcDJLbVhTdW9CL2JsNHQwZG5IRlVFYXhReFYvTG5zeURCT2ZYMUp2ZHE4?=
 =?utf-8?B?YW1oTFY1SlNSNkl2MnVRZzhnOFpYNThYSSsyMG40QVA5a1F2Smp6blo4SVE0?=
 =?utf-8?B?eTlXLzh2aDNkc2Q2RzFQc0VmcE9ObDdFQUlMMG9uS3JCdUt6TmFkNnk5TXhQ?=
 =?utf-8?B?eXV6aHh5LzE3VDlkRFk3a3lZb0Z0YXlnU2RBbUtIb0tlcjNNaVVkaWFtY3I3?=
 =?utf-8?B?ZUNQdldkaVUxa1VKbVFJaysrNzBES3BPUTJ2TFQ4OWRuZVdWbGs4VjhvdWlz?=
 =?utf-8?B?b0Nsdnh0UUk3MmdkdlpnM1BJMDJiOC9VbTBha2IrMWozQm1FemdPR0dlcTQv?=
 =?utf-8?B?ajY5VVJOUnZOejI4NjlFemtvMXkyRmRtWkIzVVZCbmtISVR1VTV4MFJrUXNQ?=
 =?utf-8?B?bjlmMmNseXE2aEgwYWlKOUhMV0JhelZGYkVva2ZjR3Z3c0RBSEZ5Ykh3TmVw?=
 =?utf-8?B?ZjFTbDJhUnFCdCtUZUg0UEV5aVUzdHU2RnoxakwrcXhhall2dTRVK2Nsb0Jr?=
 =?utf-8?B?eXFLZGhLNWxPMXlxQ3hyK3V2b0FZcURUSEFLVE8ybVRqWU5nYlphRHlZMTFF?=
 =?utf-8?B?VXR0LzQ3RnZKNEFHRzhYN0tkVjlyWnNtenlsOEY1WWNQNEdlYTM0anpzNjNt?=
 =?utf-8?B?ejdSeExIUjhpNVJSdXFLWTRIcTRrdktLNWxZUnpnbHNsdTFQSWtiKy9qUGlj?=
 =?utf-8?B?OGVndExpWUZoSGVDNVgvMWkzT3dnTFhTMU5JbnhrYUlOQkZ4aEhlYS82MGFp?=
 =?utf-8?B?aDNpQzBhMWVZVnhxZW9CSWpNNzJ5TlRVVE9CaytiTUUzTmRvcFJCTHdteUh0?=
 =?utf-8?B?ckpDVWZnTktSS0NEdmVpVUl3Rk92Snh3V0hDMnAySU4yTmYzSHhNU0VtVm1V?=
 =?utf-8?B?aU02c3NwdlhRNExEd21BM0xvTHoyZnpObkhlSWY0ZWZleWd0TUx3dUhXcDBI?=
 =?utf-8?B?N3p0M3ZVRVVSMGtSeXoxT0ZRbEVBVFF4MGdHbysyMUlQYnU2WVVlK041Wk1L?=
 =?utf-8?B?MVJXUTV4LzN2akgvZ0NJYjhncUJUb29xSEErSWt0S0ZkQUc4NlAvTTQ0aHNK?=
 =?utf-8?B?K1FiRFl2blR6ODMzWW5aaDhlMXVIWWF5VU5MRzQ2d3VrK0hhZFJ3NW1DZ0lD?=
 =?utf-8?B?SFAxTGRSeEdKY2lyU2NJdHpaRkJZNnJiOVdEZ1k5SnBaMmpNR2VVQWlCMWpS?=
 =?utf-8?B?SWVTU2JGUXZIOFRsQUdlaTI4d0czbW5aVUpNaTBkUTNaRlM3UFFJbUxnLzcz?=
 =?utf-8?B?L0RTdjhRbUNWTEJrQXhUSk1BM0JKSm9mREI5dVVyeVRLbGxQbXBkc2JwcHJm?=
 =?utf-8?B?Tno4YXpnRm5RZUE1bTJLQWNqck5jc0dkMnFGUkdJNFRTODFLS1pQTEhEeHRt?=
 =?utf-8?B?cEIyQUlsVnQzQ3hxc1UyVi82MkdnS2tueDd0RjYvMGJqbkMxc3R2bEp5WmJB?=
 =?utf-8?B?Z0x4ZDcwcXM5cnIrbnU0bktUWFhwYndLVGRMcDFpWU1Nc0J5ekNyakVSWDBt?=
 =?utf-8?B?TUlFVlF0cWxFaFFOK2hwQndBZzk0VG90VEJaVU5DUWpQZUMxamxkQUxrR2Q3?=
 =?utf-8?B?ckt0a2pwa082a0c2dVczK1dXUFV1TGc1L2d6L2ZtNFdBMUNDM3YxL0VHcG9a?=
 =?utf-8?B?LzVVdmZwY2VlYjZTL3RKK3NmMEdTbWkyOFpSdnRwcS9xKzc4RS95a0t5c092?=
 =?utf-8?B?ME5MaWhSSTF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm1zOFNpN245R0txcnIyQmFjTkVJV0x5OFJGcVNTTnFtYUxBc3VtdUJ4T2Ny?=
 =?utf-8?B?TmdVcDVYeDM0NU9LbllqWkdDamVFdlVMOXJlL2RnQnFtM3lPb2poOGduOXIv?=
 =?utf-8?B?MzFLVVRkZ3VTWlYwc3lwMFcyYXZhMEd0Q3RScFhIOW92Q1oyanY0THZTb0tp?=
 =?utf-8?B?WVhxbmRWWkNzSEVQWkVmL280M0duWUVLNmNVaTYvVzdETFFxdXE2d05oR3Y1?=
 =?utf-8?B?KzFuN1RickdWQkV1NTJreW0xZFdnTGVnaXFWMFQrYVNoQ08rS3M5ZFNFZGs2?=
 =?utf-8?B?L2Z1WjFISFBjZklUQ2NqbmtjV283OVVlUHg2TEZYZ1NjMDlrdGk5Q1FpQ3Zp?=
 =?utf-8?B?NHFOOTRKS0E2cHRieTl1VUtreCsxSHgrdDR1N2lGRE5TSFdtVEpaTURUOUVi?=
 =?utf-8?B?N2xvKzJUMUtLQm0vZHFOaGxYZ2JTL2IxTWtoOUk2bDlDVE13VjkvYzRhRjhD?=
 =?utf-8?B?N3lRK3VFQmNrQmwyS1h4bWozQzk1dGdSbkc3cHBVWHlWMUU3ZEV0cm5zQllh?=
 =?utf-8?B?RFJLRWliTnVZcHpwNkdiOEorNnZEMktrQ3A3Y0phRy9aS2lPTytYUSt3emtX?=
 =?utf-8?B?OE02U0hEYmF5ZDB3LzdyMGRwNW9PNkxnaVl3VnJmcjh5Qy81ZzRZZHFoaHE1?=
 =?utf-8?B?QmRyUEwzSUoyTGVVdWEvZlhzS3VmcHUxekFVWmVhWnpnbG1NMGtVUnJwcERT?=
 =?utf-8?B?Q3FrYXRuN214cWpEakFoUlZPQUVrbHBYZDRJRnBNTTArclMxSHJ3WkZRUFlk?=
 =?utf-8?B?TDk2c3Q3dUJETDIyaGNySE00ZU1sZEMzak5BYzlCaWpUWURFaW10dFpSY1hk?=
 =?utf-8?B?MHY5M3VuUHdJVHp5UytTNUFIK2ovZ2hLVk44ZXBQSjcrRjR4dW1PQ0dRb1Mz?=
 =?utf-8?B?S1VGZmU4ejlBSEZXMnlSakxwWG40OC9UNE5pLytEY3RHcEkvaithVzA0NWpI?=
 =?utf-8?B?bjJVWnI1a3duQTI1NWdVdWhWRHNWckNTaURMZWlJR09Gc1pvQ240dm12OHVK?=
 =?utf-8?B?RXQycVYwa1BFQW1nVFBBV3dKYWUxNjJFZ0VhMllDdWEzRWNFOGd2ZFBJUlR3?=
 =?utf-8?B?V0JGTXBWVUV0M3FJU3lUMmN3aEc0aDlkTnduV3JNQzBUdlppL2ZnT0FsU2ZY?=
 =?utf-8?B?cHR0dzJXNFhYbDhFMGFFazVNQUtNVnUvb3Z6dzdGdHRodFd6RnVRQjhMQlNG?=
 =?utf-8?B?cWVKYkRxNlVtOGFjRWVqZFV3TWtwVVJMbm10RDllTkNINjgxcEJIS2xRNlhJ?=
 =?utf-8?B?OU5HU1BTREgvRldQUDdacTRTODNnVWRDK3ZNZitoRURvU1FqdDZEVS8wYmtw?=
 =?utf-8?B?emw5ODFUK29DbFJmcXczbWJyTGRCS3JPTll1KzE4WXNIMkM5QnVCQitvLzRi?=
 =?utf-8?B?cjBESjRnUHJXS2lER0tOcUlhNGExMys2QnN3OThDRkNTK25zNkNrUzVScnVT?=
 =?utf-8?B?TElDY1AwdFoyYkxXVWdOWFU4ZzdvR00ya3dRWGJtSVRaL3djeFUvM0hNVU5Z?=
 =?utf-8?B?cGI0YnhFQW9TalZsQTV6dVVVTnNiOHc3MHBlcHFRcjhLUllLd3FaVmdWd0VV?=
 =?utf-8?B?RlZLNDkrUTdNb3c4OHdzUjM3eVBSRytiM0IrTUhPb0ExU3lxTHBXWm1Ob05w?=
 =?utf-8?B?ODIzNjFvUEVRc2hvb0FsREFDd21HNnBEOS9DVENrc1RUUHMrRmN2TEl2S3Va?=
 =?utf-8?B?ZXFBYmtCa3FtcGZrMk1wb3hSL2hNcC9FUWtJMWhmSWJtcWJoVUxxTnFCdlV1?=
 =?utf-8?B?Q2NIRUtSS2RBR1lEdWs4empqYjg2Q1l5MkY4OHE1RmVMZ0tRRkZNL0ZMWkZy?=
 =?utf-8?B?RUIxUE9QWVlRNnYyRFAxVThLYVk4RDRyL0R4eCszclp1Rm5IaGxnWUJQN1hv?=
 =?utf-8?B?OUk2OGUrc1ErbVNUUjlndUxiMm9tVUF6N29CcjBiRFVCNGpQUGwxVzFIYTds?=
 =?utf-8?B?akI2VW5wODRxZTdFVjY4blBtRTFXd0NEMGoycHJYem1uMGhWdGQ1WlpKaUJB?=
 =?utf-8?B?enZTcFZVTURSVHdpK1gxOThDRVgyQmRQZFFpU1huTjdtczN5R0lXeE1YVDU4?=
 =?utf-8?B?d0pJa1kySjZMalFmclBLMm9nUVYwUFBQQW1xdGpyazRUZkVXcDByWG9wOWtn?=
 =?utf-8?B?dDlSM09LZ2I5MjBsQlowWEZkNWt3citGYkQ1ZlpWR3AxNTN3UzBRS3lsNi9x?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCA19D07701EAF43BD83EB6F06D04193@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2914035a-0de2-4270-4e99-08dde0025f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 15:58:14.5622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzC46ss5NDG1yYIo23Yt5BTySIAHDWxKR9X+v17XCuvnqnC4HuniJ4Xu1Z/TB7nINLU6YuKX/Xwajnzdh0aegDzKObOKaVvxWJgI5hKVROI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-OriginatorOrg: intel.com

SSdtIG5vdCBzdXJlIHdlIHNob3VsZCBvcHRpbWl6ZSBmb3Igc2hhZG93IHN0YWNrIHlldC4gVW5s
ZXNzIGl0J3MgZWFzeSB0byB0aGluaw0KYWJvdXQuLi4gKGJlbG93KQ0KDQpPbiBXZWQsIDIwMjUt
MDgtMjAgYXQgMTQ6MzAgKzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiAtLS0gYS9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9zaHN0ay5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3No
c3RrLmgNCj4gQEAgLTIzLDYgKzIzLDggQEAgaW50IHNldHVwX3NpZ25hbF9zaGFkb3dfc3RhY2so
c3RydWN0IGtzaQ0KPiDCoGludCByZXN0b3JlX3NpZ25hbF9zaGFkb3dfc3RhY2sodm9pZCk7DQo+
IMKgaW50IHNoc3RrX3VwZGF0ZV9sYXN0X2ZyYW1lKHVuc2lnbmVkIGxvbmcgdmFsKTsNCj4gwqBi
b29sIHNoc3RrX2lzX2VuYWJsZWQodm9pZCk7DQo+ICtpbnQgc2hzdGtfcG9wKHU2NCAqdmFsKTsN
Cj4gK2ludCBzaHN0a19wdXNoKHU2NCB2YWwpOw0KPiDCoCNlbHNlDQo+IMKgc3RhdGljIGlubGlu
ZSBsb25nIHNoc3RrX3ByY3RsKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgaW50IG9wdGlvbiwN
Cj4gwqAJCQnCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBhcmcyKSB7IHJldHVybiAtRUlOVkFM
OyB9DQo+IEBAIC0zNSw2ICszNyw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNldHVwX3NpZ25hbF9z
aGFkb3dfc3QNCj4gwqBzdGF0aWMgaW5saW5lIGludCByZXN0b3JlX3NpZ25hbF9zaGFkb3dfc3Rh
Y2sodm9pZCkgeyByZXR1cm4gMDsgfQ0KPiDCoHN0YXRpYyBpbmxpbmUgaW50IHNoc3RrX3VwZGF0
ZV9sYXN0X2ZyYW1lKHVuc2lnbmVkIGxvbmcgdmFsKSB7IHJldHVybiAwOyB9DQo+IMKgc3RhdGlj
IGlubGluZSBib29sIHNoc3RrX2lzX2VuYWJsZWQodm9pZCkgeyByZXR1cm4gZmFsc2U7IH0NCj4g
K3N0YXRpYyBpbmxpbmUgaW50IHNoc3RrX3BvcCh1NjQgKnZhbCkgeyByZXR1cm4gLUVOT1RTVVBQ
OyB9DQo+ICtzdGF0aWMgaW5saW5lIGludCBzaHN0a19wdXNoKHU2NCB2YWwpIHsgcmV0dXJuIC1F
Tk9UU1VQUDsgfQ0KPiDCoCNlbmRpZiAvKiBDT05GSUdfWDg2X1VTRVJfU0hBRE9XX1NUQUNLICov
DQo+IMKgDQo+IMKgI2VuZGlmIC8qIF9fQVNTRU1CTEVSX18gKi8NCj4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL3Noc3RrLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3Noc3RrLmMNCj4gQEAgLTI0
Niw2ICsyNDYsNDYgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgZ2V0X3VzZXJfc2hzdGtfYWRkcg0K
PiDCoAlyZXR1cm4gc3NwOw0KPiDCoH0NCj4gwqANCj4gK2ludCBzaHN0a19wb3AodTY0ICp2YWwp
DQo+ICt7DQo+ICsJaW50IHJldCA9IDA7DQo+ICsJdTY0IHNzcDsNCj4gKw0KPiArCWlmICghZmVh
dHVyZXNfZW5hYmxlZChBUkNIX1NIU1RLX1NIU1RLKSkNCj4gKwkJcmV0dXJuIC1FTk9UU1VQUDsN
Cj4gKw0KPiArCWZwcmVnc19sb2NrX2FuZF9sb2FkKCk7DQo+ICsNCj4gKwlyZG1zcnEoTVNSX0lB
MzJfUEwzX1NTUCwgc3NwKTsNCj4gKwlpZiAodmFsICYmIGdldF91c2VyKCp2YWwsIChfX3VzZXIg
dTY0ICopc3NwKSkNCj4gKwnCoMKgwqAgcmV0ID0gLUVGQVVMVDsNCj4gKwlzc3AgKz0gU1NfRlJB
TUVfU0laRTsNCj4gKwl3cm1zcnEoTVNSX0lBMzJfUEwzX1NTUCwgc3NwKTsNCj4gKw0KPiArCWZw
cmVnc191bmxvY2soKTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gK2ludCBz
aHN0a19wdXNoKHU2NCB2YWwpDQo+ICt7DQo+ICsJdTY0IHNzcDsNCj4gKwlpbnQgcmV0Ow0KPiAr
DQo+ICsJaWYgKCFmZWF0dXJlc19lbmFibGVkKEFSQ0hfU0hTVEtfU0hTVEspKQ0KPiArCQlyZXR1
cm4gLUVOT1RTVVBQOw0KPiArDQo+ICsJZnByZWdzX2xvY2tfYW5kX2xvYWQoKTsNCj4gKw0KPiAr
CXJkbXNycShNU1JfSUEzMl9QTDNfU1NQLCBzc3ApOw0KPiArCXNzcCAtPSBTU19GUkFNRV9TSVpF
Ow0KPiArCXdybXNycShNU1JfSUEzMl9QTDNfU1NQLCBzc3ApOw0KPiArCXJldCA9IHdyaXRlX3Vz
ZXJfc2hzdGtfNjQoKF9fdXNlciB2b2lkICopc3NwLCB2YWwpOw0KDQpTaG91bGQgd2Ugcm9sZSBi
YWNrIHNzcCBpZiB0aGVyZSBpcyBhIGZhdWx0Pw0KDQo+ICsJZnByZWdzX3VubG9jaygpOw0KPiAr
DQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiDCoCNkZWZpbmUgU0hTVEtfREFUQV9CSVQg
QklUKDYzKQ0KPiDCoA0KPiDCoHN0YXRpYyBpbnQgcHV0X3Noc3RrX2RhdGEodTY0IF9fdXNlciAq
YWRkciwgdTY0IGRhdGEpDQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC91cHJvYmVzLmMNCj4gKysr
IGIvYXJjaC94ODYva2VybmVsL3Vwcm9iZXMuYw0KPiBAQCAtODA0LDcgKzgwNCw3IEBAIFNZU0NB
TExfREVGSU5FMCh1cHJvYmUpDQo+IMKgew0KPiDCoAlzdHJ1Y3QgcHRfcmVncyAqcmVncyA9IHRh
c2tfcHRfcmVncyhjdXJyZW50KTsNCj4gwqAJc3RydWN0IHVwcm9iZV9zeXNjYWxsX2FyZ3MgYXJn
czsNCj4gLQl1bnNpZ25lZCBsb25nIGlwLCBzcDsNCj4gKwl1bnNpZ25lZCBsb25nIGlwLCBzcCwg
c3JldDsNCj4gwqAJaW50IGVycjsNCj4gwqANCj4gwqAJLyogQWxsb3cgZXhlY3V0aW9uIG9ubHkg
ZnJvbSB1cHJvYmUgdHJhbXBvbGluZXMuICovDQo+IEBAIC04MzEsNiArODMxLDkgQEAgU1lTQ0FM
TF9ERUZJTkUwKHVwcm9iZSkNCj4gwqANCj4gwqAJc3AgPSByZWdzLT5zcDsNCj4gwqANCj4gKwlp
ZiAoc2hzdGtfcG9wKCZzcmV0KSA9PSAwICYmIHNyZXQgIT0gYXJncy5yZXRhZGRyKQ0KPiArCQln
b3RvIHNpZ2lsbDsNCj4gKw0KPiDCoAloYW5kbGVfc3lzY2FsbF91cHJvYmUocmVncywgcmVncy0+
aXApOw0KPiDCoA0KPiDCoAkvKg0KPiBAQCAtODU1LDYgKzg1OCw5IEBAIFNZU0NBTExfREVGSU5F
MCh1cHJvYmUpDQo+IMKgCWlmIChhcmdzLnJldGFkZHIgLSA1ICE9IHJlZ3MtPmlwKQ0KPiDCoAkJ
YXJncy5yZXRhZGRyID0gcmVncy0+aXA7DQo+IMKgDQo+ICsJaWYgKHNoc3RrX3B1c2goYXJncy5y
ZXRhZGRyKSA9PSAtRUZBVUxUKQ0KPiArCQlnb3RvIHNpZ2lsbDsNCj4gKw0KDQpBcmUgd2UgZWZm
ZWN0aXZlbHkgYWxsb3dpbmcgYXJiaXRyYXJ5IHNoYWRvdyBzdGFjayBwdXNoIGhlcmU/IEkgc2Vl
IHdlIG5lZWQgdG8NCmJlIGluIGluX3Vwcm9iZV90cmFtcG9saW5lKCksIGJ1dCB0aGVyZSBpcyBu
byBtbWFwIGxvY2sgdGFrZW4sIHNvIGl0J3MgYSByYWN5DQpjaGVjay4gSSdtIHF1ZXN0aW9uaW5n
IGlmIHRoZSBzZWN1cml0eSBwb3N0dXJlIHR3ZWFrIGlzIHdvcnRoIHRoaW5raW5nIGFib3V0IGZv
cg0Kd2hhdGV2ZXIgdGhlIGxldmVsIG9mIGludGVyc2VjdGlvbiBvZiB1cHJvYmVzIHVzYWdlIGFu
ZCBzaGFkb3cgc3RhY2sgaXMgdG9kYXkuDQoNCj4gwqAJcmVncy0+aXAgPSBpcDsNCj4gwqANCj4g
wqAJZXJyID0gY29weV90b191c2VyKCh2b2lkIF9fdXNlciAqKXJlZ3MtPnNwLCAmYXJncywgc2l6
ZW9mKGFyZ3MpKTsNCj4gQEAgLTExMjQsMTQgKzExMzAsNiBAQCB2b2lkIGFyY2hfdXByb2JlX29w
dGltaXplKHN0cnVjdCBhcmNoX3VwDQo+IMKgCXN0cnVjdCBtbV9zdHJ1Y3QgKm1tID0gY3VycmVu
dC0+bW07DQo+IMKgCXVwcm9iZV9vcGNvZGVfdCBpbnNuWzVdOw0KPiDCoA0KPiAtCS8qDQo+IC0J
ICogRG8gbm90IG9wdGltaXplIGlmIHNoYWRvdyBzdGFjayBpcyBlbmFibGVkLCB0aGUgcmV0dXJu
IGFkZHJlc3MgaGlqYWNrDQo+IC0JICogY29kZSBpbiBhcmNoX3VyZXRwcm9iZV9oaWphY2tfcmV0
dXJuX2FkZHIgdXBkYXRlcyB3cm9uZyBmcmFtZSB3aGVuDQo+IC0JICogdGhlIGVudHJ5IHVwcm9i
ZSBpcyBvcHRpbWl6ZWQgYW5kIHRoZSBzaGFkb3cgc3RhY2sgY3Jhc2hlcyB0aGUgYXBwLg0KPiAt
CSAqLw0KPiAtCWlmIChzaHN0a19pc19lbmFibGVkKCkpDQo+IC0JCXJldHVybjsNCj4gLQ0KPiDC
oAlpZiAoIXNob3VsZF9vcHRpbWl6ZShhdXByb2JlKSkNCj4gwqAJCXJldHVybjsNCj4gwqANCg0K

