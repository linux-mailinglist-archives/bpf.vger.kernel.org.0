Return-Path: <bpf+bounces-52528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF707A44526
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13713861DD1
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440B16C854;
	Tue, 25 Feb 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQff36nO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752D1547E3;
	Tue, 25 Feb 2025 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499108; cv=fail; b=nhb4FjucoCadqkWsxXIoMGEn/nsVQn2Dw+aQon4FItmUk2VjWXUOruaLo7Fg4eSxCYP72rH+oCKEIOCigtT6nYS13RWBTCZlBfJRHKEZfiXMdQwP+AC/9PkxEcC2FQH3M7sJ4ZSfCYKbqmEqGJ+4SWQa+ahmqzYaMm0Z8TOog8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499108; c=relaxed/simple;
	bh=GEzK21YJiMspan9GY+1k1t5wgPsSSaniyy5F9UBSksQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IiTWBJwzLCQg1DwCE9WHvqzU1YQKX0OxdwzZJxaUAnaChWen8SE4OUL8qU9EsfMLTjUR2m3Knb+NefWc3IeFMoV++kdlC/MXbANfzWMqdIFzOLYsSFfSAVfrYjpqFNfL/JrZLeiEEml3khBAR55fPQ54GfetDYvnkr9rMJ4T97Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQff36nO; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740499107; x=1772035107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GEzK21YJiMspan9GY+1k1t5wgPsSSaniyy5F9UBSksQ=;
  b=UQff36nOqqIJojYMIsUyfBB1XseT2qNbkFNhMKVj9i3bu6NKFeZm4ZzZ
   v95mFefkUXoAxDNdHmmIxR/SrXh3U+LLD9qPbt3sv51kOfbQHtD+GlsbI
   ZSO6p8LcTh7MgLTCgqv9PYApEQ+bIkKOC4B6GGNC6LKMdMHWyIDCh69XR
   1IwXQNHm8XlBbrQyqrcSmNOZl0sg8ItuAmvAxDB38DUp+89YwSQhAjJ2f
   8XVxKRCGmY0Rp9dbXiVCuSyFI4Lis9l6oau/QrasetCKF0Ui3L34mpwvR
   JyBhQaLSnSyP+7VbhWqIsuzc8L7A0yisNmpYhqd6AmuYhMBLF6dnKBIWG
   g==;
X-CSE-ConnectionGUID: 2OLfPWBoRk2YmEmik/v0sQ==
X-CSE-MsgGUID: bmGh6T9RRCybMwFnCNDFlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41329965"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41329965"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 07:58:26 -0800
X-CSE-ConnectionGUID: 77X308+XTGCluIaklBP7dQ==
X-CSE-MsgGUID: SqbZ2VX8SyGKDP4OtoBq6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116916021"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 07:58:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 07:58:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 07:58:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 07:58:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcP9fzcgetyjM9l/zU+ncyVFAKqD8OFDO0EqsGIjf0HF3rQPSKhRzKRNGtvcHjhfmaJOpTadM6p8788Eiuu3mkQlBh+ris9CmoQcf4HqWCNGyUv8jeGHQzzgTlqd0YIMguouxTtLZyb3JfHLYOV9cmNxCVRTBEruQAv5NOm86ajM0SHtYT8Rxfo8FbCRBPosfGv9e84gJKU33SU36zot3+DGKzZ/MYqneL9yj/aeomNx1omIngBOTJ0quJ0bpbl6OG7AB0/tVy5h8egCOtT1sj5eqG74VaczpdHkhQlGS0kqMIDd0RMn2dOPGwHY3RspXJlbyJro8enGGSDNFjxQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEzK21YJiMspan9GY+1k1t5wgPsSSaniyy5F9UBSksQ=;
 b=jeqUK1RwaqT62Nw2JMwLyUQ34DnJteYefvYK8hnnlLUb2lxr0FSJDr+GxW4a1KlZMnurQqIPqJ4HLpcBuP117C7StiaAw1FPKGp7Qxb1nBjRUd/dvLyoANwWX11JKmANt8e++4rmZ/IY46mo9nPg3KPngl55L82Oa2+emj+0S1PYcG8JLzs+ofcqHcwdn6XVeSqRU5kCEk90AvqCpwKBdDx8TX56iU6SrJjeDg+2DUSGH1fhZ4d2xkbmL3gAs7uZBgIkuvoKl/+3LfkdDsKvW415suuU4cpnonN2nbJgAdYpRu5ISdgxir5c4AihG7zsf0m/y7FZZIIKSAMD3d4AIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by SA1PR11MB8522.namprd11.prod.outlook.com (2603:10b6:806:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 15:58:22 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef%4]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 15:58:22 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next 2/6] selftests/xsk: Add tail adjustment
 functionality to XDP
Thread-Topic: [PATCH bpf-next 2/6] selftests/xsk: Add tail adjustment
 functionality to XDP
Thread-Index: AQHbg3dCpV4PPO9/ZkGLxtNR2ycpWbNQd+MAgAe9OyA=
Date: Tue, 25 Feb 2025 15:58:22 +0000
Message-ID: <IA1PR11MB651473D6A9F11317CA7A01778FC32@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20250220084147.94494-1-tushar.vyavahare@intel.com>
 <20250220084147.94494-3-tushar.vyavahare@intel.com>
 <Z7dqhiWcXDszRSYF@mini-arch>
In-Reply-To: <Z7dqhiWcXDszRSYF@mini-arch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|SA1PR11MB8522:EE_
x-ms-office365-filtering-correlation-id: fb48a229-1670-46c7-bc16-08dd55b53b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDJhdUFNdHFvempKRlpnNFBDMzI1SVVoWUhQMnVrS3krWTRFZGJ6TGFqTHhZ?=
 =?utf-8?B?U3h3bTdoMC9wN0RtUlV3VlhhRGhadTdZRlo0dkJJQVVzOEhaYjUxalVCcFZD?=
 =?utf-8?B?cXMvd1NCSmlwVU9scGh5VFI2ZFBjQzc1N1UxMytDVVo5OUplVFVJYUVzN0k2?=
 =?utf-8?B?L0xiQTlINS9zbzFBQnNmYkVIVU5aWmNzNEpuOW9SWnNxRTlUaEREdWJ0Y3U3?=
 =?utf-8?B?bTB6RFRmQjc1Z2c1NUhrYXpIZ2lSY00yajFPa0pYcndDTjlnWmhua0NBNksy?=
 =?utf-8?B?UUNhUGRrYjNEM3RWRjYzY1V4b0NMcWRzR0xIWk9nTGIvM1VsdGtDTzFTbVJw?=
 =?utf-8?B?V0hsTXRyWTBYMGp2UXd0VThTUzNOc2swb3diMERHMC9oZEFqMHNIU1lRNnlI?=
 =?utf-8?B?UUpiMjF5SDcvMXkxek9DQ2xYMGkzVnZyTHA0Y3lLSlJucGdHcS9tTmtXZU1Z?=
 =?utf-8?B?OWdsOVBhaERWZHpHWlJnaDFRbFJ6U0lhYmVBMlF0dW9ObUNLU3R1Q0VXQ1Vp?=
 =?utf-8?B?Ty9NUUZRUlQzV2Z1cEYwTWRKYmgrMTdwRUFSajZydlhXWWUxa0NNM251eGhu?=
 =?utf-8?B?YVFReVlnUVRaelpDVWNYaFFocC8wanVlR1k2cXl5L0xtN1U2NlV1MjhoMUN4?=
 =?utf-8?B?ZEthUjdnWUh0M0ttd0xqV0NrWFZOZXhlVVFMVis3clFpQUoxWDV3L1pQVm9y?=
 =?utf-8?B?aTVYY0lJV0p0bXM0QVZzc2JnN1dXMGJ4Q21KUE53LzVndTYxc1kydXNYTnJT?=
 =?utf-8?B?MEczTFRsUzNsTEF2R0lneXRkNGp3azAzZWkrRWVMZFJsRDNEWEtidEI2QjB0?=
 =?utf-8?B?TjkreFNzdHE0cVhEeE5XUFFpdi9pa1BoVlNobzFhTGgxcGpqZWZQZXh5ZEd5?=
 =?utf-8?B?NVBUc2lRVmJLT0grWHoySXA5MUNudWZBNGUzWTVYT1lNUWNaakl2SXRxSUNv?=
 =?utf-8?B?d3o2ZzRzK0FLQ28zRkhka0xyK0wyM09nSUJUZDh4VmJDZ2VhU2lkQWVKbk5D?=
 =?utf-8?B?MUo3ZXBseEpJcTE4eUJCUDRIcHM0VkZRVVB2UnIxZlFVRU91emE3ZUFpdC9P?=
 =?utf-8?B?bDd2bzdTeHlKZlA2WTYrNjFkeFNYci9KWDVDY0VOWEV3K1ZZdk5GbHVmdkp0?=
 =?utf-8?B?WVpXSHV6QlA4MmM0YU5qdDAwN2Z3ZU9UeGVBZG5RdVo2ZVJPeFRtOFprNjZu?=
 =?utf-8?B?dXFSKy9OdHd2SVlRZElBMEE2MDIzZjkvVE1OYWZjL0tMcGhhd3EzR2NEeUdv?=
 =?utf-8?B?MUR1NHNPZGVJN0Y3T21Ic0k4VFJSZHYvRTZwdHErSUdTU3VCeUNQRHVCZm5K?=
 =?utf-8?B?cGEwQVFmZGU0bEVOa294S0p2L3lrVEhRczUvUW5SK0NyR3grT1liOGtNNlVn?=
 =?utf-8?B?RFoySS9TTGVzcmlPWUxvSTZJTTRHRm9GK3NKbE0rRFJLNDBjYjU2TnpZY0RR?=
 =?utf-8?B?R1BOMU04cUIyeXRuOUJlejFpajFsdnBrVzY0L3lTM0lQTFkvemllRGdyT24x?=
 =?utf-8?B?U1FpSXNxYUloaHBxSzYvQW05TnpkN0ZvT2dIL1ZzZGVhRjV1eDJLQzlDbzFX?=
 =?utf-8?B?WTU3dEtmeGJTT09rQzB1ZHprenc3RjZMS1lHa2ZPT3R0a3ZoRExJRUVRRlRJ?=
 =?utf-8?B?dmpFMWhwZlZ3WkFSVGRJWTFZcnhQN2QranhMZHhESTlqM1o0azdwM1VLZTZZ?=
 =?utf-8?B?RGVzbzk0Z1JvNHBzN2tTN0R4RFVtODF3OTFBWit1NmIvRDZLOFNaRkppWjI5?=
 =?utf-8?B?T0RiRmZTN3M4b2tXeG8wOHdsT2tna2wwYlZYQTlFT095bm5haHYxVEhreHY2?=
 =?utf-8?B?OEdLS1BqRTc5TEhlOG1mMG4yT2lHbTJLKyswbUYxMkt1K041R3JSQ1NXVUZv?=
 =?utf-8?B?QTBjaDhDSGs5clBHelg4ZHpmOTR6c04zWDVCbEN5MUVleEs5VFA5WG5mMWlI?=
 =?utf-8?Q?6336wOTL7oKOU8zYKJV+9s387izWJkjS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVJqSy85MTF2V0RUSkQyMzhkUFYyNUtQN1dPRFlYSEpaTnFtbzhZTXlUSDVt?=
 =?utf-8?B?cG5lc1BzemJPVkwyTkdPakJYN0ZSVHRIVUREb0luU2RScWM1aEh2OWRZMUNl?=
 =?utf-8?B?ZFRkb2ZJWi9yekl3cjVFMEtpZFAwTGFJUHUrMHdaaGN1WDIvNkNrYndWamps?=
 =?utf-8?B?a2t0TzRhcW5VdjVuSFNQb3ViOUxlbDhZMzlDS0YycEhxaGNOcU1UYVZ5MTN6?=
 =?utf-8?B?ZHVLREwwZFVUSVZQQVBUYU9OZjN4eEtuaXBma0VCR3Yzcjc3Ny8zTHpROHZL?=
 =?utf-8?B?TndCdjc4eU96OWpkd0hML2tQZ096OHVqMzhBajVGbVMxbU1oemZKRk5MdGNV?=
 =?utf-8?B?VWhuMm1TeWJjR2Nva3N6Ylc2TXdmcFhQdzhPNnBLK3lDUjZCWTRPWkorOEdk?=
 =?utf-8?B?Y3ZzZFZ3bHcvSnR1RFVxSjRMdWVzMFkySGJjaW9ibk85dlpheWxLd3o2RERY?=
 =?utf-8?B?TVB6a0FBMzg3c2hUVFZSbm1WclhIYVkrMjNWS0RlbzltZndNUTN1TFlXK2FF?=
 =?utf-8?B?ZWxYbURnVG9yOERETVQ2SEhldWV5dTNsT2lBc3NiOGZheXdTYmRkU0N4OHZO?=
 =?utf-8?B?ZUpoYlVTWDFUMGVoUThQZFYzUnNmam5UQVFaamdLNldKZUs1UXlwS0tDdmQ3?=
 =?utf-8?B?dUl5cnhJQ0E4WXRmaTdyZjFxQUNtZTZIL1FQMzRYcUtvZ3pvWldkTi9rTHFl?=
 =?utf-8?B?N3IzMFZRcy9mamJZTWtrMXVqYUM2dTVZaUM0aUNRVklZKzdCNVIzNnJMRmxx?=
 =?utf-8?B?RDNkbHdtVkRNNnA1Z3VEN2ErNmpjS1hkendweEtvUnFzNUZNT1d3RnowOStw?=
 =?utf-8?B?d3RoRjkvaWlmWEdrakM3YUJNVnM4WmtuSjFkUTdQYmh0Qjk1Z0RKaUh4MVV3?=
 =?utf-8?B?V1dNSzNaYXhQQytuSVVkbGYzZVFBTlNWME5OQTlNQXhEeE1jMlVLTjhxc2Rh?=
 =?utf-8?B?UXJabXFrZGRJaHF0SkFJWFh3ZUEyQ3M0MnlxRHJBQ3djWHg0MTNxYVdRN3Bv?=
 =?utf-8?B?YlR1Qjg3bmF4TTlnbTlRakt0MHF3NEI3b3ZDK2k5WDlwclY2N0ZNNE5UczZS?=
 =?utf-8?B?ejFkaWVJWHJCbnVJVk1nZXo1SlFIVGRsRmgzL05qaFlZZXBqSzZCZTR5Z0dv?=
 =?utf-8?B?cy9jSUVqVERjeDRyall6dXpJcDRFRHVJRWhrbzFWN1FkQkw3ZDZ2dE1LcWds?=
 =?utf-8?B?Z0J6ZlR0Z3lTVmdyeno2SVlKY2N6Q2YxeFBTVzE1OE1WM0E2cWtVcUlkTy9h?=
 =?utf-8?B?SkdtQVpNWmVxSzA2QXlya3F5OG4wZzhNczF0b2JNdTNVeGZBbjBkeTVpVmFP?=
 =?utf-8?B?b1lpRnRxdDBLZllMR3lJaldPTzVKZFFMZkpGNE03aWNtcDVmWXBWdEV5b0Mr?=
 =?utf-8?B?aDZJUFY5ZGNXUmxxOTVxRXNmZ0hPZkkyVURYcGFyTTFtZkJ3SENiU2orQklx?=
 =?utf-8?B?c2NhNWFaN0ZZMTlqM1NUV1lhbjdwZ1JOditUeCttZzJZQjgwWlFMTEVmeFRh?=
 =?utf-8?B?a1JKb21SazY5eW1vZnNBVUR3a2p4NloxdlMvVGNFSEx1dDBqNVVEbHlUK1ZQ?=
 =?utf-8?B?Z3RhK0ZDb0J2azF6K3pab2VqakNoNjJJcmoweWZEZVVlc0FhUThHZTB6RjMy?=
 =?utf-8?B?SHBmSTNWWUVod2FrZXJidDhOdXZOeDlxNllJSGRmQ0tLY1Y4N2M4WTV3UmZB?=
 =?utf-8?B?Y3hyQ2Z1bWNMa21HUWdCV205N1pOQ2JZTzZKS1d6eHV4VTJZYnhRdU5oVmRu?=
 =?utf-8?B?OGFOZzZSUTRrWklnd1l0TnlPNEdxQVpSanpQZkJQbG4vSFllVHZhaCtSalZ6?=
 =?utf-8?B?ZGdxODRiTFRRc1YwV1NJd3JTNzR5b0Z1ZURqVmxzclJXL3BvbjUvZUROaUFR?=
 =?utf-8?B?MmVKMXhRNXJSc0V2Y2pDMlUva21nSWcrdEduUGYrT3IzcytXRXBvSmQ5VVJX?=
 =?utf-8?B?TS9SNkEzMmNJa2JydjlmU1RyWVJOejBwTDJBNTVLaVUwRU9RK2RWdVVaVDlL?=
 =?utf-8?B?TkF4ODhEV1dNb21WQnd4cysxOW9PbTRsUjVQSzFrRnkxV0ZBSlNIa1pDOFpO?=
 =?utf-8?B?OGFwSUFuSU1FV25DRTUxbkpHc2s1d29PTkZ6eHdlcExRSm5NUjIxbnZDdTY5?=
 =?utf-8?B?K3RNZ1g1SjVoVjBiOHZqVFlKT3RsM0ROeG1hM1dweUtZMmNablA2a0VxaUJU?=
 =?utf-8?B?Q1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb48a229-1670-46c7-bc16-08dd55b53b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 15:58:22.4407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZKkBT52ei0nuvBc/S21Qsm1ass9/AH+pmYnAv4meUXVfdUPnXuHbOEW5QztSa+Eu1NbyXirEsx2oZNqfxkfVc1Bo9DGepmacxYy8q15fLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8522
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RhbmlzbGF2IEZvbWlj
aGV2IDxzdGZvbWljaGV2QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDIw
LCAyMDI1IDExOjE3IFBNDQo+IFRvOiBWeWF2YWhhcmUsIFR1c2hhciA8dHVzaGFyLnZ5YXZhaGFy
ZUBpbnRlbC5jb20+DQo+IENjOiBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBiam9ybkBrZXJuZWwub3JnOyBLYXJsc3NvbiwNCj4gTWFnbnVzIDxtYWdudXMua2Fy
bHNzb25AaW50ZWwuY29tPjsgRmlqYWxrb3dza2ksIE1hY2llag0KPiA8bWFjaWVqLmZpamFsa293
c2tpQGludGVsLmNvbT47IGpvbmF0aGFuLmxlbW9uQGdtYWlsLmNvbTsNCj4gZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgYXN0QGtlcm5lbC5v
cmc7DQo+IGRhbmllbEBpb2dlYXJib3gubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggYnBmLW5l
eHQgMi82XSBzZWxmdGVzdHMveHNrOiBBZGQgdGFpbCBhZGp1c3RtZW50IGZ1bmN0aW9uYWxpdHkN
Cj4gdG8gWERQDQo+IA0KPiBPbiAwMi8yMCwgVHVzaGFyIFZ5YXZhaGFyZSB3cm90ZToNCj4gPiBJ
bnRyb2R1Y2UgYSBuZXcgZnVuY3Rpb24sIHhza194ZHBfYWRqdXN0X3RhaWwsIHdpdGhpbiB0aGUg
WERQIHByb2dyYW0NCj4gPiB0byBhZGp1c3QgdGhlIHRhaWwgb2YgcGFja2V0cy4gVGhpcyBmdW5j
dGlvbiB1dGlsaXplcw0KPiA+IGJwZl94ZHBfYWRqdXN0X3RhaWwgdG8gbW9kaWZ5IHRoZSBwYWNr
ZXQgc2l6ZSBkeW5hbWljYWxseSBiYXNlZCBvbiB0aGUgJ2NvdW50Jw0KPiB2YXJpYWJsZS4NCj4g
Pg0KPiA+IElmIHRoZSBhZGp1c3RtZW50IGZhaWxzLCB0aGUgcGFja2V0IGlzIGRyb3BwZWQgdXNp
bmcgWERQX0RST1AgdG8NCj4gPiBlbnN1cmUgcHJvY2Vzc2luZyBvZiBvbmx5IGNvcnJlY3RseSBt
b2RpZmllZCBwYWNrZXRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVHVzaGFyIFZ5YXZhaGFy
ZSA8dHVzaGFyLnZ5YXZhaGFyZUBpbnRlbC5jb20+DQo+IA0KPiBBbnkgcmVhc29uIG5vdCB0byBj
b21iaW5lIHBhdGNoZXMgMi4uNSBpbnRvIGEgc2luZ2xlIG9uZT8gSSBsb29rZWQgdGhyb3VnaCBl
YWNoDQo+IG9uZSBicmllZmx5IGFuZCBpdCdzIGEgYml0IGhhcmQgdG8gZm9sbG93IHdoZW4gdHJ5
aW5nIHRvIHB1dCBldmVyeXRoaW5nIHRvZ2V0aGVyLi4NCg0KTWF5YmUgdGhhdCB3YXMgdG9vIG1h
bnkgcGF0Y2hlcy4gSG93IGFib3V0IHRoaXM/DQogDQojMTogc2VsZnRlc3RzL3hzazogQWRkIHBh
Y2tldCBzdHJlYW0gcmVwbGFjZW1lbnQgZnVuY3Rpb24NCiMyOiBzZWxmdGVzdHMveHNrOiBBZGQg
dGFpbCBhZGp1c3RtZW50IHRlc3QgZnVuY3Rpb25hbGl0eSB0byBBRl9YRFAuDQojMzogc2VsZnRl
c3RzL3hzazogQWRkIHN1cHBvcnQgY2hlY2sgZm9yIGJwZl94ZHBfYWRqdXN0X3RhaWwoKSBoZWxw
ZXIgaW4NCiAgICB4c2t4Y2VpdmVyDQojNDogc2VsZnRlc3RzL3hzazogSW1wbGVtZW50IGFuZCB0
ZXN0IHBhY2tldCByZXNpemluZyB3aXRoDQogICAgYnBmX3hkcF9hZGp1c3RfdGFpbA0KDQo=

