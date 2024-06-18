Return-Path: <bpf+bounces-32415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58B190D843
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 18:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373211F2420A
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E7360B8A;
	Tue, 18 Jun 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7E0QpKa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1CC1CD26;
	Tue, 18 Jun 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726895; cv=fail; b=PKIK5yvTu5HL1RdX1+/wc3xEfY8bxuZ5ww1M6Y8OKDP9ErRn8UjsfgItd+NEWp8IPXZ+AfazBVJsZ2U52N24cMfESovlaqI0nh03Hgbx0YJ8RoH3qibMVsr1YOQYJv2OjwkpXXAZCbtGvx+QcjaOUH7BwvqcVvYu3BWWOy/ka0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726895; c=relaxed/simple;
	bh=wgUFfbMarlbyNK/Gq8uRslsdUez0lMubICQ8URV0cJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FVIdCsTvwQJFtfmegsuG0A9/CFsDjZ6/+A42LJvmGf7ROGx2U+HUeHTn7gUhog1oeQ/wesFTBfjppZ2m7uAWWupq2CZh0FimAQneKcU/WycD/8V0eGk45z7ZdemWrFq6GuocPCmFGacNDJE4HETgH8sBx4h+2SvMuxulV69qHBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7E0QpKa; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718726893; x=1750262893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wgUFfbMarlbyNK/Gq8uRslsdUez0lMubICQ8URV0cJA=;
  b=K7E0QpKau18lNQT2os9Y4Tr5ry65z42SO9iv30RlolSG2UL6kqvlp0yu
   ottjJi1gJpDtJgsSVZBKHoY6hLUejhYLcHwOcyISfvdyazk5qdLA0ksaj
   P/kROVzUOETPTjo/VcgHokLiMUKKcMEJwyN02WUG/JEBni9uD4L4Q7GRD
   zUtPrr/4WsNoHrgu/pK9rZuYFoJ1kK7ISF/cfgykGLno8eIKp2CE2EEz3
   1cc7VyOoY16k1YxVM5Xg1oen4GLI9OpCAOHJBrkibBqO2zi6adNFj6M6L
   2IbUUVcBDiyUl6lly3QQWwZp2+CVGdd6sJfQepfvZGaruFU9jt/57Y40k
   g==;
X-CSE-ConnectionGUID: Jei/R6ctSTGqis/48bOuPA==
X-CSE-MsgGUID: UPv8V8H9RHuMBD5AZrp4pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33158047"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33158047"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:08:07 -0700
X-CSE-ConnectionGUID: BqgC3gd8QaOiwsjDY0Ywew==
X-CSE-MsgGUID: 5I6oB6SaSSGY7rc6WuDbMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41443571"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 09:08:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 09:08:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 09:08:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 09:08:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 09:08:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b489k4uM99DEcssZYNIwa3C9GUMM018O0XS7oiOni0DTLWosmo4z27U2PLApJp1XfbpdSO3S0KHtYP/c6CzN62C6vaAX0Mm13yaPTpuPnyyhFw2eqpIB+l+dzQAKUuScISEx91qZrNVlbrmbyeCVwSg+W/IfG/ZKRjMI+/uuEs/IDDYmZPNPad2LmhPi9pKDl16v58bneELDzhPfUbtXw1izMzNGkqy9ufh9mJhNO4mxIHSpFyQzZjWm064zHa1mI8sWirWuHjwoJ7L8kmpYPArljg37Bh9TpZJhmq2fIyEmfbEZh/XOF7Wej38QlUHu38O9haDw9W5YIc9U9QjzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgUFfbMarlbyNK/Gq8uRslsdUez0lMubICQ8URV0cJA=;
 b=i1cVUiB7q47d5bgz15pbpCQUyjy+0VGHW1w/8h6u/9ws+TWtTgO8tCWo6SIDp8Xy3pHAZ9pa67Ys/qwQL7COGQmO2jYJVZGsEAlmIP9fOPynR3ymKLucznDumAHjIkMua9vmFbUZYuKk/Yf6bPAF/PPATc2gXzQ3LVIl9Xq1mHDJrJkWvrT/TnZJ5hskT6w2vJe2r3VQTz8a0YmsxtVuQYS4OjYDLBmZvEoe60Z05XhdDqUzVfsjXrBi8YAh1vnQ5beWGrBE+sTXtZI4CWtIxl/UFlHhL49ZwqQv0LcsYDlAn4R42qLQbquvwBYNCnPjRAnAC+AjGfVOapT8+nx0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY5PR11MB6344.namprd11.prod.outlook.com (2603:10b6:930:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 16:08:01 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 16:08:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "ycliang@andestech.com" <ycliang@andestech.com>
CC: "lstoakes@gmail.com" <lstoakes@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"patrick@andestech.com" <patrick@andestech.com>, "hch@infradead.org"
	<hch@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC PATCH 1/1] mm/vmalloc: Modify permission reset procedure to
 avoid invalid access
Thread-Topic: [RFC PATCH 1/1] mm/vmalloc: Modify permission reset procedure to
 avoid invalid access
Thread-Index: AQHavAEpf8TIVvQH2keQ+FOXqYrmzrHCnViAgArbNgCAAELRAA==
Date: Tue, 18 Jun 2024 16:08:01 +0000
Message-ID: <7b9ebf0b787222fc4e83382066a6f4e918881cf9.camel@intel.com>
References: <20240611131301.2988047-1-ycliang@andestech.com>
	 <5e603eedf9e8fbd6efe1d118706dd82666e54251.camel@intel.com>
	 <ZnF41EAK06FYog27@swlinux02>
In-Reply-To: <ZnF41EAK06FYog27@swlinux02>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY5PR11MB6344:EE_
x-ms-office365-filtering-correlation-id: efe63da0-bb82-4336-230c-08dc8fb0d437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?ZDRuejZ1eWZLdUdmRHA4YkFhYStxcm9aem5xMFc5Z25rRkppTmh3SG9GOFFX?=
 =?utf-8?B?by9wVkdic1QxaEhzb0pHMnk1TlV5eDlrd2dpdXZXdCtId2djYi9wRDhCOUVn?=
 =?utf-8?B?NDZObmdQalRybjQ1bmVoOXl3VUxlNmtOOHJRSzNpQ3FEQ2dBVS9rVnNVYi9L?=
 =?utf-8?B?VjhxV2N2Q0pxcDVnQkN5WjVrSExtWlp1Z1VpTzlmQlJRbDQ5Y2pSZ1Bqdlhv?=
 =?utf-8?B?MktzUEt4K0w4VWFzU0dYb3hFZEVCamNhcURmaTNoNDRIcFB0QnVnK3AzZzUx?=
 =?utf-8?B?c042QmVGSGsxek1lczBZajQvUTd1TFhrRldrK2lJYW1saDg2YUFKc3Yrd2Fr?=
 =?utf-8?B?aUdCTkNBQlB0OGswVXlvc0hXUG9lckxoakN5aUJMNVVMOVcxRHQ5MW9yQmZ4?=
 =?utf-8?B?T2xCUmxtYlpOWEtnOU9vaStCVXFPVStxVkNOODB0eUdqVUtoSGVDU1RzWXR5?=
 =?utf-8?B?ZVdkbmw2YWhTRGJRanVYdWphRFYyaXYwVW9iQVIySkxxWWtxdTRieG43ZWV2?=
 =?utf-8?B?Z0x5MkpyQ1hkVy9OaHBNVGwxWXhPSnptdWl3dUlOT0NOL3VZQ3hiYlFDV0Rw?=
 =?utf-8?B?aTNJR2xqZDdjNXhyTi9CNWJGckV3WXhNeElsV0Y1WGFQYVFVV3k5aVdqZzhh?=
 =?utf-8?B?cTZ3c1JNN1pUSmFWclFGTjczV05ab2M5eGQ4K1d6QURNZEdxNWxVaXpOeHk4?=
 =?utf-8?B?QlUrZHF1eDdvYmdLT2FjaStUZDV2Y2JwUmkzQ0J6RXJORmpBSmVNeVhJR2RY?=
 =?utf-8?B?SlhyQlhwcllKTGY1d3V0R00wNmRNL1I2NTJGbzRibzFDdmVycmt5SWNNaC9r?=
 =?utf-8?B?dnorZENZWkdpdmpETHk1YjZKTlQ0MGxyT0p1YWlmMEk2aUo2cnpaU0hLKzE5?=
 =?utf-8?B?bmZ6MGR5UjV1NVVtWXBHcHRoUDFZMW5yMnZ3MmVRWUhuTm5oK1JYMXU3M0dP?=
 =?utf-8?B?NnY2by9BaVhtTXdrZkxCWUlYVG0yYnF5QWFBSmptREFoU3c0YWRsMUt4Wmt1?=
 =?utf-8?B?T3FuWkM3U055TWF1MEk5NGtZaWtHMy91SVFSckhNV3VCOEJibys4RHUvbFo2?=
 =?utf-8?B?WDZZYUlQOExFbnpiQm1aRU5Wam5XWTdtWGVBV1Z1WkxZUG1yRG9LUEphOXNh?=
 =?utf-8?B?WEVqWXVPK3RnWUxnQnNUbUEzZ29ic0diVHl4OENrYU9MYXFiTGYyQWNUTFVS?=
 =?utf-8?B?N3lwbFdibERyVm5PblJaY3BMUExXWHpqZ1l6UGV6eDNFMWI0Q1Z0cWxsY0tH?=
 =?utf-8?B?SkxSZlg2R1VxNDd2NTNmM1k4K2w2eUYzclpBeFVuelRDUlAwK2JMQVl4WFRT?=
 =?utf-8?B?RG9heW13RTZ4Y0RCT2h3bkI1eis3T3B6dHpBUHh5STk0TjlSOEgwcnFNYWVx?=
 =?utf-8?B?dmlDQVpZY0FXam50cE5sVjhyMVlyRFJBVGF1dVNPMlJJT1lSeWpWZjVBbjBt?=
 =?utf-8?B?cUFObzl3S3VIU01MaXE2TGsyQ2V3cU9GNzJuRVZvU2RpOFRQb1liOTN4eHZE?=
 =?utf-8?B?UTNtb0V1UVhyekc5TzJBby9Pbjk3dXlIOUNJV2hyRGU0eXkrazBuWXNLRVpK?=
 =?utf-8?B?RzZkNlpzQk11Ykt2UHo3Rjh1WmtKeUMvUnhEci9lelFSOWFmNGFJc3hUM2wv?=
 =?utf-8?B?OFc3TDFXWS9CeVMwc1pTUjlSdk96enBNVTdFZjRRV1NrZG1qc1dZZmJsYlJ6?=
 =?utf-8?B?R1R6L2tDUmJLSnphQzFpNzlPbkdiUVU2RzZTZmI5QnZUbnNJQ0RoWkZCZVFm?=
 =?utf-8?Q?Oh27I2MqlWWFN1+vHj7rQQ9iEcaZLkM5jWKCpV8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUgyQnFuc2VRMThoMGNsTXdwdTVsbnhKR3JHN2xnaXdWWEtWcnZ1cTdmQ2xM?=
 =?utf-8?B?TGtnTTNrTmp4clBFbHRTNTFUbHU0SVgwRnZLbTV3dU8wc0tpZk5XOUVwK201?=
 =?utf-8?B?cTNCcktkV0xPem1RaS9aZXJwVzB3U1psTnV4RGsvT3hTUXIvcFNqRkZRd0F6?=
 =?utf-8?B?MWRieTBlcVZGVHJYbVg4REF2V2FaTWJ5QXNDUm4vTFN0M0p0NEhaSzVRemtj?=
 =?utf-8?B?QXZaNXlySnpMN2pmRDZLcTR0YzRMYXpoaldsZTFhVFZjY2x4akRHeEIvK25r?=
 =?utf-8?B?UXRYdzVLOFQ4L1p4NEVhYmlFQWVHcjdrb01QTjlIZVpxdmZFMW5FUFpBQXp3?=
 =?utf-8?B?Sjg2MjBIaDlUTTdoMWpkMTJwdjIyQlhOemQ1QndabEd2cnZVbENkNEpjSUFo?=
 =?utf-8?B?d3VuMCszaHlZOEZoZE43RVVYQllOODhDenM2Ny9PYkFqTXRLVmhYaGYzYnJB?=
 =?utf-8?B?V0lJWHR4Y2psd2xWK2VRbmFhcldGTzlZcGE1VnVjNUIyREZtbXA4d3pYVUpN?=
 =?utf-8?B?U2Fyckd3UXJnb0RzUXhneWo4NXdiZ1RITHpPanFjWG5FZzEybi9sUDdqSG5I?=
 =?utf-8?B?K0ZYNTlzT1htYnpZUVU0cVE2RWJWYzJxaFVhd3VWUVhKdjRkL2xSbnJpVnNk?=
 =?utf-8?B?MWEzdWN5U0RiVklYYmNtd2NVekpvcmwwN3BRYVQ3VmVWbXlad2ZyTFdjM0p5?=
 =?utf-8?B?c0dzNlpQUDl3eTQ2NVJnYndxcFJKa1ZHZ0pSUXprbC9Ndkx0UlNXK3N3OUNq?=
 =?utf-8?B?bWMrWHZUcDZCT0Z5cTA1YW01ZDNHTFZaV2FtbGVCUDZlUkdNb3ZoYmRDai9l?=
 =?utf-8?B?WFQxVit4dE1CQjNnc1VNemZ6SlQvUEhOZ2tSU2liWXN2ckRCWE9pZ3FxWWdl?=
 =?utf-8?B?d3haeURpRS83eUMrWTh4ZDRuOHNncXV6eWRpTlBhdUhQeCtCRFdzalljQk9u?=
 =?utf-8?B?a1BuYUR2RjRZbEpWc0N2S1BJRHVxVDlheGxTcGtMMFR1SGtqS1Q1aWJsenF1?=
 =?utf-8?B?ZHVJL3pBSXkxMHVkY3Flb2F4cmI3RHNEaDkrbkN1UEZ5R0E1WktWQ3ZPSi9E?=
 =?utf-8?B?a3lyUkNMRGdoOHJYMW9DbXdsWEtOZVZqeEV2REZnWFRIellxTmRwS2kyZkgz?=
 =?utf-8?B?ZkllTTAvRkNxaTlTenMzc0JkclBBRG92LzhzZVYzeUxHY0pzWEgzRktBa3o1?=
 =?utf-8?B?VnZLS0dCay9UWTdTYmdxL2hnNVNjdWw1QTk4Vk0rVkkzektqbXUyUE8zMXpM?=
 =?utf-8?B?ZTYxOWtSZmIzR0FTT0ZIemhaNDd2ZnZJNG8rK3hReTBCR0FOaGNESHB3djY4?=
 =?utf-8?B?bitxVkVmNXhOcHJkdTRNbjhSNExGZVRTU0YyYWpLL21GUlBsdWdLaDQwVHFM?=
 =?utf-8?B?Q0ZFQlI5YnBqVUNtM2ZQVmVjbVF1NnFBM284ZTJoK1NGYlA5OFdHY1JOeHEv?=
 =?utf-8?B?NFIwcE9Vb2o0WnlSaTNnR3pJSTVKN0s2ckphTktXbU50WDJFYWZDWUZHWUll?=
 =?utf-8?B?SlFSWTdkTHp4Z0ZEQmdGbnQ2QUE2UkhSeFNkTGlOVTMrUnk0U00yWTRXRCs4?=
 =?utf-8?B?TlprcDR1NW1aMFgxVTEwRWxSeWd3WTRJU1Buc2RpU01RSGVXUGhGd3VvNkx6?=
 =?utf-8?B?N3dyZ1hUeDJuUzNDbHJzWWpFWnM3SmdRWXV1bDU1SlVsdW51M3F5VDN0NWM3?=
 =?utf-8?B?c1pMcmErd1dhdVErWk9tWDJzNS9ybWVubXFEbC81WTRBQkhKeUlNYXBHWjVF?=
 =?utf-8?B?M0EvVk5xS2hCRnJuZWhFLytwL1JQT2pHQXpLVFNTYWd6MWpSZElVYU9XVm1l?=
 =?utf-8?B?K3JSd1F4VHNhZ0lvUGsvVW9IVmphaW01bm1aRmNYb0RZTjVsaWxzbTlGRzd1?=
 =?utf-8?B?NW1YcStEend5dGZ3ZlF2R0l6MG9yYkxvWVIzemlrNXYvcFM1L0laTVN6TW1m?=
 =?utf-8?B?cndXMVdKOWhSWDFISzJqS3o1MVVhdlhScVZJajRWZm1IdkpDcFgxamhtNjJi?=
 =?utf-8?B?TzE3WUpaZCtrbnlpQ2pjT1RnVytyeGlxTE0vbUo5UWl0Y3JjQU5hRCtTaHox?=
 =?utf-8?B?VGt5TDJTVmt6VytjVEppdjRna0xTUGpIOTYvWVIvMW1SZkJPQmVaRDh3UTFT?=
 =?utf-8?B?SktlcEdpbWkreTBmN3hpdkV4VnovSVR2eHE1MHc0RTAwbVZCOC9sWXljMjZT?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F0043914E80DC4BA7252F26AD0BCC4E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe63da0-bb82-4336-230c-08dc8fb0d437
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 16:08:01.6557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIKvRSNm/74t1HzHjajSgrjfu0RyZsZjZf5pqAwIEPpXe4JkLsaMbJup/uIQIsXk2Xj9GFSz9eGjy8qfYscKNM/dlslCnJbH1u/o9s7UcUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDIwOjA4ICswODAwLCBMZW8gTGlhbmcgd3JvdGU6DQo+IFdo
YXQgd2UgYXJlIHNlZWluZyBhdCBmaXJzdCBpcyB0aGF0IHJ1bm5pbmcgTFRQIGJwZl9wcm9nMDMg
dGVzdCBmYWlscyByYW5kb21seQ0KPiBvbiBSVjMyIFNNUCBRRU1VIHdpdGgga2VybmVsIDYuMSBh
bmQgdGhlIGZhaWxlZCBjYXVzZSBpcyBhIGxvYWQgcGFnZSBmYXVsdC4NCj4gDQo+IEFmdGVyIGEg
Yml0IG9mIGluc3BlY3Rpb24sIHdlIGZvdW5kIHRoYXQgdGhlIGZhdWx0aW5nIHBhZ2UgaXMgYSBw
YXJ0IG9mDQo+IGtlcm5lbCdzIHBhZ2UgdGFibGUgYW5kIHRoZSB2YWxpZCBiaXQgb2YgdGhhdCBw
YWdlJ3MgUFRFIGlzIGNsZWFyZWQgZHVlIHRvIHRoaXMgcmVzZXQgcHJvY2VkdXJlLg0KPiANCj4g
VGhlIHNjZW5hcmlvIG9mIHRoaXMgZmF1bHQgaXMgc3VzcGVjdGVkIHRvIGJlIHRoZSBmb2xsb3dp
bmc6DQo+IDEuIFJ1bm5pbmcgYnBmX3Byb2cwMzogQ3JlYXRlcyBrZXJuZWwgcGFnZXMgd2l0aCBl
bGV2YXRlZCAnWCcgcGVybWlzc2lvbiBzbyB0aGF0IGJwZiBwcm9ncmFtIGNhbg0KPiBiZSBleGVj
dXRlZC4NCj4gMi4gRmluaXNoaW5nIGJwZl9wcm9nMDM6IHZmcmVlIGNvZGUgcGF0aCB0byByZXNl
dCBwZXJtaXNzaW9uIHRvIGRlZmF1bHQ6IA0KPiDCoMKgwqDCoMKgwqDCoMKgYS4gU2V0IHRoZSBw
YWdlcyB0byBpbnZhbGlkIGZpcnN0DQo+IMKgwqDCoMKgwqDCoMKgwqBiLiBVbm1hcCB0aGUgcGFn
ZXMgYW5kIGZsdXNoIFRMQg0KPiDCoMKgwqDCoMKgwqDCoMKgYy4gUmVzZXQgdGhlbSB0byBkZWZh
dWx0IHBlcm1pc3Npb24NCj4gMy4gT3RoZXIgY29yZSBmb3JrZXMgbmV3IHByb2Nlc3Nlczogc3lu
Y19rZXJuZWxfbWFwcGluZ3MgY29waWVzIHRoZSBrZXJuZWwgcGFnZSB0YWJsZS4NCj4gDQo+IElm
IHRoZSAzcmQgc3RlcCBoYXBwZW5zIGR1cmluZyAyYSwgdGhlbiB3ZSBnZXQgYSBrZXJuZWwgbWFw
cGluZyB3aXRoIGludmFsaWQgUFRFIHBlcm1pc3Npb24sDQo+IFRoZXJlZm9yZSwgaWYgdGhlIGlu
dmFsaWQgcGFnZSBpcyBhY2Nlc3NlZCwgd2UnZCBnZXQgYSBwYWdlIGZhdWx0IGV4Y2VwdGlvbiBh
bmQgdGhlIGtlcm5lbCBwYW5pY3MuDQoNClNvIHNvbWUgb3RoZXIgbm9uLUJQRiByZWxhdGVkIGFj
Y2VzcyB0YWtlcyB0aGUgI1BGIEkgZ3Vlc3M/IEhvdyBpcyB0aGlzIG5vdCBhIGdlbmVyaWMgcHJv
YmxlbSB3aXRoDQprZXJuZWwgbWVtb3J5IHBlcm1pc3Npb25zPyBUaGVyZSBhcmUgb3RoZXIgc2V0
X2RpcmVjdF9tYXAoKSBjYWxsZXJzLg0KDQpQZXJoYXBzIDMyIGJpdCByaXNjdiBzaG91bGQgbm90
IHN1cHBvcnQgdGhlIHNldF9kaXJlY3RfbWFwKCkgZnVuY3Rpb25zIGlmIHRoZSBpbXBsZW1lbnRh
dGlvbiBpcw0KcHJvYmxlbWF0aWMgbGlrZSB0aGlzLiBBcyBpbiwgc29tZXRoaW5nIGxpa2U6DQpk
aWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9LY29uZmlnIGIvYXJjaC9yaXNjdi9LY29uZmlnDQppbmRl
eCBiZTA5Yzg4MzZkNTYuLjEyNWJhODdkM2M5ZCAxMDA2NDQNCi0tLSBhL2FyY2gvcmlzY3YvS2Nv
bmZpZw0KKysrIGIvYXJjaC9yaXNjdi9LY29uZmlnDQpAQCAtMzQsNyArMzQsNyBAQCBjb25maWcg
UklTQ1YNCiAgICAgICAgc2VsZWN0IEFSQ0hfSEFTX1BNRU1fQVBJDQogICAgICAgIHNlbGVjdCBB
UkNIX0hBU19QUkVQQVJFX1NZTkNfQ09SRV9DTUQNCiAgICAgICAgc2VsZWN0IEFSQ0hfSEFTX1BU
RV9TUEVDSUFMDQotICAgICAgIHNlbGVjdCBBUkNIX0hBU19TRVRfRElSRUNUX01BUCBpZiBNTVUN
CisgICAgICAgc2VsZWN0IEFSQ0hfSEFTX1NFVF9ESVJFQ1RfTUFQIGlmIE1NVSAmJiA2NEJJVA0K
ICAgICAgICBzZWxlY3QgQVJDSF9IQVNfU0VUX01FTU9SWSBpZiBNTVUNCiAgICAgICAgc2VsZWN0
IEFSQ0hfSEFTX1NUUklDVF9LRVJORUxfUldYIGlmIE1NVSAmJiAhWElQX0tFUk5FTA0KICAgICAg
ICBzZWxlY3QgQVJDSF9IQVNfU1RSSUNUX01PRFVMRV9SV1ggaWYgTU1VICYmICFYSVBfS0VSTkVM
DQoNCg0KPiANCj4gQnV0IGRlc3BpdGUgYWxsIG9mIHRoZSBhYm92ZSBjb25qZWN0dXJlLA0KPiB3
ZSBzdGlsbCBhcmUgd29uZGVyaW5nIGlmIHNldHRpbmcgdGhlIG1hcHBpbmdzIHRvIGJlIGludmFs
aWQgZmlyc3QgaXMgbmVjZXNzYXJ5Lg0KPiBJTUhPLCAic2V0IHRvIGludmFsaWQgLS0+IHVubWFw
ICYgZmx1c2ggVExCIC0tPiBzZXQgdG8gZGVmYXVsdCIgaXMgaWRlbnRpY2FsIHRvICJzZXQgdG8g
ZGVmYXVsdCAtLQ0KPiA+IHVubWFwICYgZmx1c2ggVExCIi4NCj4gQ291bGQgd2Ugbm90IGp1c3Qg
cmVzZXQgdGhlbSB0byBkZWZhdWx0IGZpcnN0IGFuZCB0aGVuIGZsdXNoIFRMQiAmIGZyZWUgbWVt
b3J5Pw0KDQpJdCBpcyB0cnlpbmcgdG8gcmVzZXQgdGhlIHBlcm1pc3Npb25zIGZyb20gUk9YIHRv
IFJXIHdpdGhvdXQgbGVhdmluZyBhIHRyYW5zaWVudCB3cml0YWJsZSBhbGlhcw0Kd2hpbGUgdGhl
cmUgcmVtYWlucyBhbiBleGVjdXRhYmxlIG9uZSwgYW5kIGRvaW5nIGl0IGFsbCB3aXRoIGEgc2lu
Z2xlIGZsdXNoLg0KDQpPbiB4ODYgYW5kIGFybSwgdGhlIEpJVCBwYWdlcyB3aWxsIGhhdmUgYSBk
aXJlY3QgbWFwIGFsaWFzIHRoYXQgaXMgcmVhZCBvbmx5IGFuZCBhIG1vZHVsZSBhZGRyZXNzIGlz
DQpSTytYLsKgV2hlbiBjbGVhbmluZyB1cCwgdGhlIE5QIFBURXMgY2FuIHByZXZlbnQgYW55IHdy
aXRhYmxlIFRMQnMgZnJvbSBiZWluZyBjcmVhdGVkIGJlZm9yZSB0aGUNCmV4ZWN1dGFibGUgb25l
cyBhcmUgZmx1c2hlZC4NCg0KU2VlIGhlcmUgZm9yIHRoZSBvcmlnaW5hbCBkaXNjdXNzaW9uOg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4MTEyODAwMDc1NC4xODA1Ni0xLXJpY2su
cC5lZGdlY29tYmVAaW50ZWwuY29tLw0K

