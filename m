Return-Path: <bpf+bounces-30452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46348CDF7E
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 04:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336C02817CE
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 02:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BDA2231F;
	Fri, 24 May 2024 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYUIBOn8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C453C0D;
	Fri, 24 May 2024 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716517789; cv=fail; b=WGshZyNrVBUogf5NSLNasBQsMI5hJ4YcbSvgT13+P+ibbLL79O6QmBUm65Tt5QYx1F6ZLm99+G3653XJsnpT0a0kj6cdiQggujnpoglPnhHNZmlTHuP4fXDBrE7ncvfGhoYjJscIkCxgUdTMq6FXmsaDmDq7zAKEjVZ7lOyfbp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716517789; c=relaxed/simple;
	bh=xxuhRG+C1lVjmyPkBWP4SbDV20sAMCvmYZ9wDFqcWZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WbHoYQ0xiCGjromXan7hc4/ONGDcR2zaTzFmfX91V5B8a3b6HCRlFVAt8UPFoqy+X4Lvo3k54D7V7Yy+JulDhybpT5PBBS8fDI7kDK1FVVQBqYns0F8GmeyRxQQ2vr0xJSTuLxY6v6vWQJJY6KMJm3Hfmm9q25pAnCjvKaTOqbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYUIBOn8; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716517788; x=1748053788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xxuhRG+C1lVjmyPkBWP4SbDV20sAMCvmYZ9wDFqcWZY=;
  b=DYUIBOn8uLZ+F3LVjQUw27BuXyzY7Te0HT8Bmnnrt/LGtb9L9lcp+vRi
   f3b49sAMrxYB6XRnEo7r1KWOSy18plDJsefD1i/906AGALJPmVZXg9qTh
   fMy12qVj3PgOtAhkANAyYPKglJvPN9AUgpmqejy/Kcr5j4OvEd0QalZPA
   fTqrSUpwXZqSvgjDKcxCv8g7HXr1u3qVD0y1sAs29epuDlOj0AYRwSBI4
   cxIBB+64CeDtQ8KpH1K7q7YoV7G8lKnEYXm5SU5niyz9cNsOJqvNc0ZaR
   F0SUJM6HKtmSQsTOhEFo0b1+b7yl/iMSwAbMPu1gH2rhMWZEP1w8FIz0s
   A==;
X-CSE-ConnectionGUID: L13BHdXdQzumAVRK7eRsRQ==
X-CSE-MsgGUID: VfmiDIvaTzeQhQJI11MpmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="13109269"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="13109269"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 19:29:47 -0700
X-CSE-ConnectionGUID: p6LkPdNtT9C1gmbNhsLErg==
X-CSE-MsgGUID: nWSTxEUFQpqwZqhTXhHNZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="33986313"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 19:29:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 19:29:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 19:29:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 19:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjCKmEUvpZhnGL7NwH7r4WcVnMJXYJE5r92lb1xOXD8X/PVjaPzCYAKV6K2RlT4vVqwkVWTqvA3QEBxJTRuVZYuralJwRz2PF8PDDPsCoOQ+JaZujJ4KuHzd0tJ3l+cjLEEpXXUGI3XYNsNbdm9e5zX48JUjXczHkgjjjCJAnMVt3sspTmkWYo9qTnryOc7TY8c4AQ4bKDVbgrG+0ZKxyJwnYIr1IpbYqKHRVTj6Brsonav+maE/6x2rVVUyiK91VUx+TWSsn0BTIQpLKKMG4PdHOzA8qmcrZvFcQKxgKLSvR2B4uzu60ujbVwwb60VP+KJw7vrTHtRU1fkgMudAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxuhRG+C1lVjmyPkBWP4SbDV20sAMCvmYZ9wDFqcWZY=;
 b=bcFwgCi2LPu3bdZ5UpVAxv6Vc6WmTDkFk989WVuY6rjuSLaH2csLwLCU7b1hNVfZtHjbJ6YLgaXzxL6K/0Bc0wEgobeIqGECfrf+A0/3R6QY7/GEcFxSUq1qc3AN7cXOo6A5qjxi7dryLD0UBiaWoSiGxpTC9s4gR1Q1RBeRvkZ3RdnTFDgktKZLgMZPnMGDwSOh2ab0oyKsIKgXR2US5O2OagKcpuYl+hixYvHkd0SITZnlNtsWsb5UrJq7MiyrTjLZ4t8g/bFK6+FCIwOWncy4ZcfnoeSEyXRCzncy9woS91EpnWGfe6TM8XDK+HK6GgHpQ/1LTnEax/Rm/L6Xog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Fri, 24 May 2024 02:29:43 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 02:29:43 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"luke.r.nels@gmail.com" <luke.r.nels@gmail.com>, "xi.wang@gmail.com"
	<xi.wang@gmail.com>
CC: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "pulehui@huawei.com"
	<pulehui@huawei.com>, "Li, Haicheng" <haicheng.li@intel.com>
Subject: RE: [PATCH] riscv, bpf: Introduce shift add helper with Zba
 optimization
Thread-Topic: [PATCH] riscv, bpf: Introduce shift add helper with Zba
 optimization
Thread-Index: AQHaqoU4So+/Ofm/MkiJcz41dcDMTrGh5fsAgAPH3MA=
Date: Fri, 24 May 2024 02:29:43 +0000
Message-ID: <DM8PR11MB5751217E922FE7CC4D58646CB8F52@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240520071631.2980798-1-xiao.w.wang@intel.com>
 <874jardspv.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <874jardspv.fsf@all.your.base.are.belong.to.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|MW3PR11MB4634:EE_
x-ms-office365-filtering-correlation-id: f8043d2a-df4f-4666-36ab-08dc7b995f0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MHNkdG1lNnNoVFc1dmRuaEJNVTJTQXo0K2c3NkFvUjlIb3I0WVlVNEpvcGF0?=
 =?utf-8?B?ZStjUEVuN2kxcGh4N2RadU5VQ3U4TEhjUGx3cFRVTjFpbmh4VDBqTm92MzZn?=
 =?utf-8?B?eHNJcUFSdHRKSnllbUNZV05oTFhOQjR6bG5QWVN1WEIxRnRqZFpkK09ZbzdG?=
 =?utf-8?B?NEx1QUpyQ3NydnNHVzF6Ky9wVHlDMWtLTmVNSjA3UjVLSjZod0pkeW1HWEMy?=
 =?utf-8?B?NGdMQS9yUk9WNkRXMWlyeEdUNU95VjN6RTRpV2hTd1VZb2hpeXJPMnkwUjZZ?=
 =?utf-8?B?bTUwbWVrYjFuVC9uU25jSWdhM1puVFYrVkpXM0dtbWRCemtlSWJ3Nk55MlEw?=
 =?utf-8?B?a2hKYjZOU0g3Q1prck40alBWakFlc3o2TUd0NStkMWRxVXRJYXZaTklqbkxV?=
 =?utf-8?B?cEltYVArSUtEV0RhM2w2amxROTY3Ly9tNHF0VGtjQzB1OE0xKzErUzVOU0F4?=
 =?utf-8?B?aTJqZDFRVHA5RXFQU1JFbG1zZGRkWWg0V0l4cTlQNW83WDlMdG1iekZkZTFL?=
 =?utf-8?B?RlRna3VBZW5mR3I0R3gzaVVoVS9HakpPNk9CR214TkM3K0c2am1KR2pOKy92?=
 =?utf-8?B?SVFwbk5tUVdXL0pQSmxCUkJXWGJ6R3dNNkxMaW9XRVlpMWJqS3QycXNEYlFO?=
 =?utf-8?B?aXNLZnI2cm1HdVlBQVFUOCtkVHFoL25raVdiMk1mdENpN0NmMnMvc1Rub0o5?=
 =?utf-8?B?ZFJYVjFmRVh6M0ZyQUk5WXI3SHh3UjBDR0h1TmN1TEg2ZlRvemJwWjNxT3Jn?=
 =?utf-8?B?WDYvemx5dmtyZjZHYUwzbFl0UDJpVmgyeHNwNUtQaGtnRXB4cTJ6TW81M05Y?=
 =?utf-8?B?NWE2b2RWQ1FkdStuMWdRdkJSZU1WNEkwS2tZbHFnZnE4VDFpRXpUdjNZMk15?=
 =?utf-8?B?YUxOVGtFcFlsNnFQcndPeEl4amg1NUZsT2tFUit5bkVzRFRRSjAyck0zSEVI?=
 =?utf-8?B?eG9IbUhWODExbnhpcGljNnRHZ0kxSlFkb3lPM3ozc2xVMWk5eW0ybnBoVm42?=
 =?utf-8?B?Um4xNEMxOXozbUZjQS9pY0dOY2wwbFpXaDZ2cFBTUlBiK3lHYzZ4by9mamNE?=
 =?utf-8?B?aEJZZW1yZ2Y4NjQ2S3NOV3NodEpRd0pZRFlWRDFuamVBZ1RweUtTNTN0UWo4?=
 =?utf-8?B?U1c5RkVqS0Y3aUR4R1c0RkNpRDAzWFdKZEQ0dmFOeGdXNWpMUEFQMkIrdEtJ?=
 =?utf-8?B?Tml5a3NZZGI1QW16Q3NObFF3WHZaVjRUdDBSL2hUZTk3dDE2VzVMcWg4Zmk0?=
 =?utf-8?B?T1pPdktJdVM3OTU3NnkvM2xQWUxlUEVTREt5Z1B4NnNIUnhwT2NYWnlGYmlY?=
 =?utf-8?B?YmNKeEYxS0lYWWhHOVAzWWVLMEFQQ3c1R3o4bCtSQXM2MHRFYmN5MjNFdXhi?=
 =?utf-8?B?SDJWYW1nZ2ZlcjFDc25uSmF5Ym4yNWUvdFV3YTUxSUNKSllkeFlsYlNIejVU?=
 =?utf-8?B?Mk5KeFRFdnlJT0pUM1B2VDIvWU9KV0g3SGplUVpFNTdEeGhiR2M5bWx3cHZj?=
 =?utf-8?B?aDE5OXc5VzZRSDJFc0J0RkhQS1U1MkRpZUJBaFFzVjhJRDdGd0dhVUtCTDBW?=
 =?utf-8?B?QnREQVlDMVd5QzNmbnhhOTMzWVBJTXYyMmF2UkNQV1F2enhRa1lCN0YwazNQ?=
 =?utf-8?B?UGoyeXd0VjJxc2xBMlNMTG9tcjU4RDJmRG9EcUMxVWw5UjYyNk5CQ2xsT2Vq?=
 =?utf-8?B?eHUrQWRBY2xPS2VRamFmY3I2VnlKaEZzdnJ0US9UcEI1MFVFNndoK2J3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3NYYjRqYXpPbVpnV1h2UXUremlzL1g3OG1RVXl0V0Eyay9IRW1MdEpuVW9h?=
 =?utf-8?B?OWkxYmZHVm5EdHYweEJOVWJnTmptbWptdVJuVkhvK0ZyWTZKWVRmelIva0Iv?=
 =?utf-8?B?SFhxRXhTdVRvVWpNQytITU5VeUZ0QVF0clVlWjd0Qk94NDIvNk9wZzMwdHBl?=
 =?utf-8?B?cytEREd1MldJVFplZGlWZ1laVEJ0d3pNUjFTWEYyRmFpanBYWk1xTHBEUzBx?=
 =?utf-8?B?d09EUzRkaWlXY2d1YU13UTNsRDdKbWNwRFlheUtPaVVJNE04WWRLS3dCa053?=
 =?utf-8?B?dUhRcm5QN0FvajZTWTMvc3dBTzErTXNBOHNETlNTemlGWFhTMkFOMzRYY09s?=
 =?utf-8?B?NndaR29zOEt1dExZenRueU5SUngwQUlocmZTVlJSUzZacXdESUNpa0JQUFNW?=
 =?utf-8?B?UUlVWVZNNk53M2dqWW1OQmUyN05wMm9yUjVadnFsZ09yUzlnTWhHdG9qeDhm?=
 =?utf-8?B?RlEyUllULzltV3czdmovd2MrZitDVkJldExUOHd6OU1VaktxMVBaT2pSQzZa?=
 =?utf-8?B?cjMzWUJKMVJtaytONDlvR3JSQmk0QVZjdzVEWGlNZ2JtOTR5NTZKbXVpTXhu?=
 =?utf-8?B?cnRPcWZVMk9ieUJHNVB1bGw0RU43RVNuNzdzWEdLNEdzb2V5Y2hkdFMwM200?=
 =?utf-8?B?VHNaZi81Z3V6SVM4ZGZmMUxJcGlNWVpLbm9TbEZyUXlJUHJaOVg1NTh1Zit6?=
 =?utf-8?B?S0tNMWRua3VpU2xkYVc4SmthTDgrVHM1eWp1RTlzdlp0SkFaSDE1Rml1OWtS?=
 =?utf-8?B?OHhyUlExaUlERkhEMWVsdm1wWTZCd0U2VldBUjlEOUtNcGdnc0dhYlcxZytW?=
 =?utf-8?B?UXNveHNRam9qdkd6NmlWY2VsVWp4MGJTa0hJWGd1cnJQUG9HSXZqeVQ5Qndk?=
 =?utf-8?B?b0g3dU54T2RENHNUYldpNVdNZ3NvOXd6YlR5RDFZaUF0WU9GQ0I0MmhCd3ZM?=
 =?utf-8?B?cm1NbWYyYlhUeCs3TnY4OXI2UUxsSm5BWE91MExQU0NjTkJRNk5zOHVnbUpq?=
 =?utf-8?B?TTV6dTZOR3Q1ZTFUblhOQ0NQTkxldXJNL3ZHUUtFV2ZNRCtIMFkwaTN0ZGli?=
 =?utf-8?B?bkZtRWc4T2lKZmZGRGlEUlhIQWd3dXgxdFE5S1JEWk5Zd3grTnJEZzY3aUta?=
 =?utf-8?B?RzhNb3pIWGJVdFhpbGYxc05hM0pkYlZiQWVvRzFEM2RGMEVLT2hLRUNQMGFo?=
 =?utf-8?B?S25ZeGwzRjJFUU5tajZJSEp4akZEcGIwcngxVFZENGdHSDB1bkY3U3JUSjdv?=
 =?utf-8?B?bVBrRnBMWmlzMm1OZmRRSFZxK1hObm9WQUNEWnZWNkhuL0hZUkhmaGRieU1N?=
 =?utf-8?B?TG9JMzl5YXJiZSttczdDa1pwWkhkZjE2REZEV3E1amc0TCsxQXJqR0MrZlly?=
 =?utf-8?B?QXl1N1M2QzNZLzFScWtEeVNJb0VjOWcvRXRXNnhlVDNBQis4akx0aU1CaitL?=
 =?utf-8?B?NUF0SXdSY1VNVWJnejVPYmlmN1F1VmZNbElwSDc2TmsycGJMeStNZHVNY09H?=
 =?utf-8?B?Wm1Ybzdnalc4VGd5OFNtWWpIL1FkdnZNdlNDcGZVcDVrRmw2Q1dEa2kxTkhN?=
 =?utf-8?B?d3hqeEdFTG4rcjR3QUVkSWM0Y2VpQ3lYMExsRlJ6dGhxVkJoRjhMeEVhbERh?=
 =?utf-8?B?ZHcwK0ZpVGFzVVJUaC9LUmxFWm5CZUpBYUVINFpNdkNQeEFTb3orM2EyMDVj?=
 =?utf-8?B?eUwvUW1adFFaNXBVb3VjdmMySnpSc3VJM21kVHlPazVaOGE0K1RQaGpEalZD?=
 =?utf-8?B?anZXM2plZlp5Zm9SQy81MVowK1VoaC85Q3NNVWZ0cmczTkZNRzNpYjEwdXZw?=
 =?utf-8?B?Z0xER2p4c2ExVENjS2RzL3RhTVZsVEdObk9IdldGOEN6UXhJaStpYnVhazhZ?=
 =?utf-8?B?UXBOcjFZUEFEZCtJMGNZRjB2MDJNNGtTV3JrTFVBemJFQ3pXQ3JSbDlxRlFB?=
 =?utf-8?B?aGJBUW5XQjk1ZVVwcy8xbzJvQkIrdWRDR29ZT1d5SVBCbzEwVGlabytiRXpm?=
 =?utf-8?B?VGRvUHcwN1MxZFA0djE4ZHBWdlU1d3VSbHRub1UwQU1DcWIzL1JOMkZSTU9l?=
 =?utf-8?B?dlZqVFd1aHZTdXRyRVpoN29pVE4yQzZoS3g1S0hFWVdKWWIvd0N2dTNCejFP?=
 =?utf-8?Q?f3ieer8Mje1JZBhe4tmRbEmRD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8043d2a-df4f-4666-36ab-08dc7b995f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 02:29:43.4304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHpzLpZn5U13oAm6PqdvPJx50ML/qNIr/+6M+3pzhGEU3yCsWGfpbM1TNMaexn3DJpPHz5xNYcWB9hwsP6b3ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmrDtnJuIFTDtnBlbCA8
Ympvcm5Aa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjIsIDIwMjQgMTI6NDAg
QU0NCj4gVG86IFdhbmcsIFhpYW8gVyA8eGlhby53LndhbmdAaW50ZWwuY29tPjsgcGF1bC53YWxt
c2xleUBzaWZpdmUuY29tOw0KPiBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5
LmVkdTsgbHVrZS5yLm5lbHNAZ21haWwuY29tOw0KPiB4aS53YW5nQGdtYWlsLmNvbQ0KPiBDYzog
YXN0QGtlcm5lbC5vcmc7IGRhbmllbEBpb2dlYXJib3gubmV0OyBhbmRyaWlAa2VybmVsLm9yZzsN
Cj4gbWFydGluLmxhdUBsaW51eC5kZXY7IGVkZHl6ODdAZ21haWwuY29tOyBzb25nQGtlcm5lbC5v
cmc7DQo+IHlvbmdob25nLnNvbmdAbGludXguZGV2OyBqb2huLmZhc3RhYmVuZEBnbWFpbC5jb207
IGtwc2luZ2hAa2VybmVsLm9yZzsNCj4gc2RmQGdvb2dsZS5jb207IGhhb2x1b0Bnb29nbGUuY29t
OyBqb2xzYUBrZXJuZWwub3JnOyBsaW51eC0NCj4gcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsNCj4gcHVs
ZWh1aUBodWF3ZWkuY29tOyBMaSwgSGFpY2hlbmcgPGhhaWNoZW5nLmxpQGludGVsLmNvbT47IFdh
bmcsIFhpYW8gVw0KPiA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSByaXNjdiwgYnBmOiBJbnRyb2R1Y2Ugc2hpZnQgYWRkIGhlbHBlciB3aXRoIFpiYQ0KPiBv
cHRpbWl6YXRpb24NCj4gDQo+IFhpYW8gV2FuZyA8eGlhby53LndhbmdAaW50ZWwuY29tPiB3cml0
ZXM6DQo+IA0KPiA+IFpiYSBleHRlbnNpb24gaXMgdmVyeSB1c2VmdWwgZm9yIGdlbmVyYXRpbmcg
YWRkcmVzc2VzIHRoYXQgaW5kZXggaW50byBhcnJheQ0KPiA+IG9mIGJhc2ljIGRhdGEgdHlwZXMu
IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBzaDJhZGQgYW5kIHNoM2FkZCBoZWxwZXJzIGZvcg0KPiA+
IFJWMzIgYW5kIFJWNjQgcmVzcGVjdGl2ZWx5LCB0byBhY2NlbGVyYXRlIHBvaW50ZXIgYXJyYXkg
YWRkcmVzc2luZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW8gV2FuZyA8eGlhby53Lndh
bmdAaW50ZWwuY29tPg0KPiANCj4gVGhpcyBpcyBkZXBlbmRlbnQgb24gWzFdLCBhbmQgZ2l2ZW4g
aXQgaGFzbid0IGJlZW4gYWNjZXB0ZWQgeWV0LCBJJ2QNCj4gbWFrZSB0aGlzIHBhdGNoIHBhcnQg
b2YgdGhhdCBzZXJpZXMuDQoNCkkgd291bGQgbWFrZSBhIG5ldyB2ZXJzaW9uLCBjb21iaW5pbmcg
dGhlbSBhcyBhIHNlcmllcy4gTWVhbndoaWxlDQp0aGlzIHBhdGNoIG5lZWRzIHJlYmFzZSBvbiB0
b3Agb2YgYnBmLW5leHQgYW5kIGVuYWJsZSBvbmUgbW9yZSBzaDNhZGQNCnVzZSBjYXNlcy4NCg0K
QlJzLA0KWGlhbw0KDQo+IA0KPiANCj4gQmrDtnJuDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtcmlzY3YvMjAyNDA1MTYwOTA0MzAuNDkzMTIyLTEtDQo+IHhpYW8udy53
YW5nQGludGVsLmNvbS8NCg==

