Return-Path: <bpf+bounces-29002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6BE8BF3D2
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378D4B22094
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 00:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB1637;
	Wed,  8 May 2024 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtB5jiE9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778438F;
	Wed,  8 May 2024 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129397; cv=fail; b=RES0uY+jGN3N9EQ/4/qBUn0qDmrOeLBXZ7+z2pHiRmyP2JDfv7CbKSx3rqKhjkyOYJ7H8I1CNHMkUz2IO/ycc/x/BItruuF0lzJU4v2BmpeGNH29rDjNWSjxZbafiA5TXtTNBncS10/L3GsY1w1CPdHJQa/oLTQwvJK3/EzbIZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129397; c=relaxed/simple;
	bh=KF9IsxhgyUnLeBzoh4EvCOlJS6dpcsWzE6efe1/Me8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZVFK264iSwrWeNFnfZkOVXW89KQPk59L5bLkgQRutcKkD5kSuBrRcANJFv4muIqoSYB/JozkIaq/mdGiC0lZ9todDNk1QWx5VmWl3AKm23Sz6aSjdKr70HVs3Tq2YBQxjNXWs7DqRcliCwjIag37JAsqfFrtXOLnWg28jJ0ets=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtB5jiE9; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715129397; x=1746665397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KF9IsxhgyUnLeBzoh4EvCOlJS6dpcsWzE6efe1/Me8s=;
  b=LtB5jiE9nOAQqjBFEN+UZ1t3f7RbQJHetf96WV08WV7/QN+TPYTGP6Kj
   CRrQT7rgrgKI30cknDS6CbM2c8vlArahB8u0cqqe3LokIUTdWjXgSedCy
   AxESJhi+zjnXyrM8Uj4t/Pg6U3Rj6XS5pgrAm1TsqxI8zygb079rOMp7P
   hS4u59drcLBCJ3Py74x3S3bTys7VWuukbw2lE0RKn6r7UVWCa7o34sJj6
   KoSR8N7+Y7puUrF5FvVQkq0HixoA0Ee6/RjOsvhLuiC0yqLAiVGtYJL2f
   CMdkr0/fN2orO60PA8h0NZPEEj4Keth/ky48mCOKigZzs94G9enlF4mzN
   g==;
X-CSE-ConnectionGUID: xyc8mSstQT+uof5VFoNCng==
X-CSE-MsgGUID: b72aBKakQSS9a52BLDvbCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21568442"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="21568442"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:49:56 -0700
X-CSE-ConnectionGUID: yBK3ZZSJQ1eWZ7f2F/uHpA==
X-CSE-MsgGUID: C/OvlZe0QGa1U2HsxBdyYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33228312"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 17:49:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:49:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:49:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 17:49:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 17:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkfFN+1zDfpxaLMZgh6C/LBq8mdXQ3Q/+Wvt0j0Lj2nnP/RTY2GUZ6ScKnp6Wv1cifSjdohn/ImypeXILzNQfP3FT0HNlqMTP6tr8Jj80+6SJAS11Z4/4P04YIGrYab5whLKXdLTW/7CSIKrNAB9uM37JRt5xZjoCQ5zQiRvHthNNDapZJH/VS0AwOFjzDz/dZ+T0Hc7qbkiUU3qKs4OFmKkZ9BHRxWz+NVRCDESZ05399PKFrjKpju39WyFhja/lVjPG2t1xEdc+eZn7wXdIT8IrNbNDFQMMnwuQS4GoaMrRKQ9S+cPgyUDEiQGTm3UPhGh4eNNp9PRCu4Ga1S+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF9IsxhgyUnLeBzoh4EvCOlJS6dpcsWzE6efe1/Me8s=;
 b=dakZsYOpKMF7iZJ2R/Uuwxfrf1kDXPUKydjCN1NcytUxBYNwD+TPAIUgaafPtJuX0ClIc/rE4o9pP7kSzmNaOZCbRwvaaR2iik+oPRwlTaW6m6U5Ehf5hslKRcGWW+HecpfCurie064mXChei4LxB8mincKNeGhnLQpgir4mG3uJyGwkqfri6WBAx4oidEN3emryAoqwFfm4AIovGSzmUWQHMTWZbLTthnpqqcuGhQKaY6KJVriuK4h8v2LCACuiMOt7c7MpMO5IOXSDA24ISUGio2WEvjIEBp0mu+2CRPoh9uJ07cDhFJqGoAqH9S44a4NuR9bUnQYT3ZeQXRBm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by SN7PR11MB7116.namprd11.prod.outlook.com (2603:10b6:806:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 00:49:50 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 00:49:50 +0000
From: "Wang, Haiyue" <haiyue.wang@intel.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH bpf-next v1] bpf,arena: Rename the kfunc set variable
Thread-Topic: [PATCH bpf-next v1] bpf,arena: Rename the kfunc set variable
Thread-Index: AQHaoCi3dresz1lSr0KAA1pG3Z8Ys7GL14WAgAAjfQCAAEKwgIAACsUAgAA4K1A=
Date: Wed, 8 May 2024 00:49:50 +0000
Message-ID: <CY8PR11MB77476783A1CB0C7F9534A5BAF7E52@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20240507024952.1590681-1-haiyue.wang@intel.com>
 <CAADnVQK7zD312WRJboMib8HJnNzN=i2FKH2QxkVVy736b7sNTQ@mail.gmail.com>
 <CAEf4Bzbze5D0M2V9d9q90E_XHCMEUa7oXum=wOCVQ_BAugox7A@mail.gmail.com>
 <CAADnVQJuL18Zkyyztkmzm54yvq3CuB4bSjoL331cmcnX_kppeA@mail.gmail.com>
 <CAEf4BzZaGcLTOBL=5nPWx22PKFOD7yg2a-qzV3dJ85S9hpCGjQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZaGcLTOBL=5nPWx22PKFOD7yg2a-qzV3dJ85S9hpCGjQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|SN7PR11MB7116:EE_
x-ms-office365-filtering-correlation-id: ec5be8ae-75f4-4f3e-0e13-08dc6ef8c476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?M0gxZVBLWURxN1lYUHBtRExOUjZZY0UrRUZqSWg4UmVQdGJqNHZMR2x4dVRY?=
 =?utf-8?B?L29sWm5sRlRta2V4ZDNhdzYvaGs4enhJMnA1SklmaFBFc1l0RXRaZHBZbFBB?=
 =?utf-8?B?YkpLWEdyT2lnUkp3OWw4TkFkMW9RNDdzN2RVYjFhY0lkQ25wcUZEQVhWeG5a?=
 =?utf-8?B?VW5JNVA4TWJsQnJOcEFUd0U0LzBxaWFqT0xacFUzNysydHVCaXV6dUlUcWRo?=
 =?utf-8?B?ZzRzZks3bld3WVJyNjVEaFduY0EzbXdkRERzMkZSKzZORy85eVNNajZZVlpP?=
 =?utf-8?B?c2Zaenk1VW0yTWtmVnRHR2xLYWdtVWcxWHRPQitOL2ttR0hoT1BETE95RGdL?=
 =?utf-8?B?bGs3cGFTNGJyaGhjajZZL09WL2g4eWx4aGR1Z1l5UU1mSVZWOWVEVk85eThQ?=
 =?utf-8?B?R29NcTV2TVZ2bXZHWWZNNElFandJa09udXppd3VLL0h5ZVBhUElHZXJMMjBC?=
 =?utf-8?B?RjlDdkU1Znh3TE9OV2N5dXBZYmttTFRhTVUrNk1EeVJ2TitKTWhRUjgrdElD?=
 =?utf-8?B?ZmcrT3U2WWFLT2JoU2JMR2k1VEQzZlgrdG5iYUIxZmNhN09IMU9ZM1cyamhB?=
 =?utf-8?B?dUUwbVVnMEVqeFJ4eXN5Q3pWNzN5RU1tY2lKK1h4S3VwYU5uL2hnd3BTTmJz?=
 =?utf-8?B?N0I0MlpZRVJGN1NzVjh5OGYxNytYWCtENWI3YlZkUmVsckhUUVlOVStFR1p1?=
 =?utf-8?B?aVROdFhST2I5WVljcS80RkU5M2J1NWlPR1hBeFhqNXhxU2wvaUl0cFViRXJp?=
 =?utf-8?B?NHJmcFhJZFZicmIydUdrNFNDak9GRnoyS3l1ZStpRjNTWmZ3dXErMDlOS2d2?=
 =?utf-8?B?SFlHOEJRYTZ1UXBibUhVdDlKaERVY0pLYk5xWnhxaHhTdDdmVFpTRDE1Qkox?=
 =?utf-8?B?enA3Wm5KQi8rditCZXNqUU5YSXhsT2JneHh3SHJPZjRFczdNbUpJa29QbFdl?=
 =?utf-8?B?MUEvWnI5VjF0Rk04UVpKVnIxa093R05XVVRDdzQ2aFZ1VGlpaFp5akROZFdy?=
 =?utf-8?B?aVkvRGtMeFZFSzM3RkVRcTkyL050SHFPQ0s1aXdIV3JrSUsvRk1EYktUb2RE?=
 =?utf-8?B?LzU2L2dyNjF2bXgvVXRxMHNZQXA2ajlpZDU3WUhUZ0VEa3JtV1o2UnNlTmFI?=
 =?utf-8?B?WVFZcW83TGswTmdXV25xc0xhWFgvRW1uL0dUTE1XRmZHNERBNFAzNlpzMURy?=
 =?utf-8?B?R0dYTVpGcnM2NloxQm5RQVdzandBUGJJZ3RobDVVeGFVVm9iVWJlbjR0SzVD?=
 =?utf-8?B?dzNqZEtZNWlYV0dxUFVpaGpHd1JyZC9LbjIvR2o3Zk1uSFF2aC9KMmJBaFZT?=
 =?utf-8?B?TGtnWjNkU2VYZm03SGNRSWRNbjJKL0psQUx3VFozUzR2N1pyU0oxb25BM09n?=
 =?utf-8?B?SzAyMUJRWEszVjEzTkNqdnNKSDEreGtGZC9NMEFhWkgwQVRxMytBZHZleVdJ?=
 =?utf-8?B?dnFCUGt1UU5FRndBcE1tcE1ITUZkSUpQQVM3WTIrQytsc1FIRHlHdlAvVTJM?=
 =?utf-8?B?Y1dnLzIxNnNRWWgvNzMxUW1UWVNGZUdJbzBSbUhBbzgvOWdweElDaENYR1Mv?=
 =?utf-8?B?VDZUZlNMTGxSNGVVMjlPMURaM1JMWFRrN2lRSjBEdGUraFUrMktPNW9tdEs4?=
 =?utf-8?B?N1RtZ1J5NjlyYUhXcFVXRzRMbmxYU2ZWV05qWGdBYThJUlZDZTJHSVYzQXdu?=
 =?utf-8?B?ZHZBS24rNzJINndmem5TSjBzcHhGZVV3cjlYVlFaM1pBVXF4RE1RK2RGeWNk?=
 =?utf-8?B?OXdEOEdpMm5YSnNTYmtRL3ExL0htQjQ2a3laZDc4cmhSdWl4ZHNtRHJ4NVhB?=
 =?utf-8?B?UWZPYVN0d05Ia2hVcXhZUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGRZelNYQ0lrY2FPZjZJTnJhSk05V01UYXZ0dmlMdWlIdjQxQkw0TmlKZTRv?=
 =?utf-8?B?Qk1NejRKRDBZL3BYVjJBSTVmQjdSVGNGZlNrK1V4bkZIMHJBaGgvc2IwTzVJ?=
 =?utf-8?B?R09VK3ltdnM3a1QzN1NNNU4xZWhqTzUyNXNVeFRTNkt5OFlFOThXNU5Lb3VT?=
 =?utf-8?B?MkNJQjdaM3ZnNzBjZ1ZtM0xDUzlDNVl3OUYyT1ZTdGV6MmgxOVNWck16TWNa?=
 =?utf-8?B?c1RKODVpU1c0TnFZb20zb09XZG9kZWxxcldPbXlQQnVJa0dzZ01oL3dlVHE4?=
 =?utf-8?B?MDg1ZEVRaGUwS3FSbVRoZ0l5ZEcvRituam85T3ZpaUliNEtoQmQxTGdXQVg1?=
 =?utf-8?B?NjFYR0JTZ0dPNDJlNzZSZktRR21yWGh5WkZTbG5sYXlSYUVqZVBla2NxUjY2?=
 =?utf-8?B?bk9hUGZqdFQ2VGY3TUdHM2t0TS9sNDdIMkgwRXNvNzZzOXJiYUtTeDVhcU1z?=
 =?utf-8?B?elB0RkxnUGQ1ZkFZQ21RL3pHb0VPdUxjOFVXZHZwZW9GdzVBK0Q3L3FRMk05?=
 =?utf-8?B?NmUwc0Q2WFdQblU4WHFrVC9QeEpFcXdrSGFZK0VQVUNaSUVnZCt3SUd0K0Ry?=
 =?utf-8?B?TjJ2R3JRVlprdmk2YlFNb0lGOFFTUlRrbXcxV1lHRHgvNlVCZzZhaklDeXR2?=
 =?utf-8?B?SFV1WU1KSXQ3d09wTWg4Q1JhUVdaMzR4MTZFTVVRM2dsVWtiVzAxZENOb0N6?=
 =?utf-8?B?djYzRDZna1NIdnRLZlJ0a1QwcWppL01nL2ZpTGdYc2JkY0hMOC9wczQrR1RT?=
 =?utf-8?B?Q1FhanQyakRuV2tJYlV3d29sOGo5WmViUlBHZFRQOEUvWnZhZEdZQW9YajI1?=
 =?utf-8?B?TWRSL2FWbjhxWENsZmFTb0JhZDZDaWlmRjFqVkgwOTNicWk5clpTRFYxckJC?=
 =?utf-8?B?WUNQcG9GdTl5eFNocDkwWm5tZTlZcVVURHVKdjRFeDlYbzhQNFRRUVB5MkRs?=
 =?utf-8?B?YU1UVUpsMzJLajNhcWxhcWU0Q1g3dit0ZndQejhLWk9Fa1E2RmtSK1RKRFFu?=
 =?utf-8?B?VThXeVVaR2FPcVNCY0p5anlQdGkvY21GMFU2aXhON2xqRExYMDIyMk4xWXpC?=
 =?utf-8?B?ci95ZEp1TGpDendZZkRwZVFzNks2eXgwQmF1WFFxK3U5dXJmc3FQRC9XdEZB?=
 =?utf-8?B?QlVsUE9LTStTQm4zMXVQek9zZE5GNndRYnZqT1JXblRFRnF4L1Q4OHhVbitq?=
 =?utf-8?B?RUlLSTNEWG8rOFA4aENLckFvUDYwdk5mcXZtaDlCclJOWHVzVDNvZUN3SU4x?=
 =?utf-8?B?VGxnclJoclZzSjYzWVM3QitLdTF5M1c0Mm1VWTdncGU2bEtQZGtVZXhaNlVM?=
 =?utf-8?B?NkxaV3RqeCtneVEwb3VDU2pwT0hTUnVGdWMwdis2c2RRSk5QaWYyckZreEtR?=
 =?utf-8?B?c1UzV0ZjeGVvT3ZrUkJFdGR3WVNRZm9WS2I0WXNpSUZwOEtkWndlb2Y5Vkc5?=
 =?utf-8?B?VUMxUFpIOTkvVlMwbXBXTjJ4NXRqYXJhQTVmT1R3YWtVeHRFRmU2bkdZUUZY?=
 =?utf-8?B?WjcxYVJEVDFCUFlKN3cvZmNWNXBxc3c2c3d1ZlluZnJFckw5cWpQMThNWkZW?=
 =?utf-8?B?WGZtcXBZV3VTemV1d1RiT3BkZ3pBMEIrR3dVYjl4WHpKTys3NkNtMUxRMTli?=
 =?utf-8?B?MUVCZXFUNzRKN0x0Rmc2cUtyLzBNeGFKQ0Fxem45Z0lEVXQ2R1ZTTWhvZmFp?=
 =?utf-8?B?aU81MFhhYTdCempQcW5BcFZGZTJGL1FodktSR0xxN1pYOWRsU2NpUEpWWjE5?=
 =?utf-8?B?MHBnYmpMdkJIUXhpNGdocWNLVzRLc01neDJHcW5kZ1VpVHA5bmhuaEd5NC82?=
 =?utf-8?B?aFZxU3VTdTFtQkJpWFpucFduL1dGZE5admRiSHBuSkJjMzF3UzhuS3V4aXBh?=
 =?utf-8?B?aFVWRkhuL25qaXkvTTMyMDJadzhhQitFZ2dTNks1UU1HOG9OMmw0bzh0Zkp1?=
 =?utf-8?B?aGNvYTduL1pFREM1RXBHSlhWZHFZZ08zb3dDeUdBNjYvMG15bENJNi9zcXYy?=
 =?utf-8?B?Z3UwKzlFSkZ2RWNYdHVHVTFjR2RCUjNVY1RUVWgyQmhJUW9nTDdCdVVGNjVO?=
 =?utf-8?B?TFpOVjN5QVdGWUEzOTNuVktzdHp5RWRVQzJNQ3Y5bTR6cGQyUmhhT0lOSzI5?=
 =?utf-8?Q?xp91tnlCG5gwkd24etRHEV2qY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5be8ae-75f4-4f3e-0e13-08dc6ef8c476
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 00:49:50.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTyD+XsAXfpI/1nwYe//W46rzKkA7O9Kdt7mL6ZGCd7exn3jz0ovI7ekccMjR6flrKnq6fXTGiD24XLM0cCVjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7116
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyaWkgTmFrcnlpa28gPGFu
ZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDgsIDIwMjQg
MDU6MjENCj4gVG86IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWls
LmNvbT4NCj4gQ2M6IFdhbmcsIEhhaXl1ZSA8aGFpeXVlLndhbmdAaW50ZWwuY29tPjsgYnBmIDxi
cGZAdmdlci5rZXJuZWwub3JnPjsgQWxleGVpIFN0YXJvdm9pdG92DQo+IDxhc3RAa2VybmVsLm9y
Zz47IERhbmllbCBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyBBbmRyaWkgTmFrcnlp
a28gPGFuZHJpaUBrZXJuZWwub3JnPjsgTWFydGluDQo+IEthRmFpIExhdSA8bWFydGluLmxhdUBs
aW51eC5kZXY+OyBFZHVhcmQgWmluZ2VybWFuIDxlZGR5ejg3QGdtYWlsLmNvbT47IFNvbmcgTGl1
IDxzb25nQGtlcm5lbC5vcmc+Ow0KPiBZb25naG9uZyBTb25nIDx5b25naG9uZy5zb25nQGxpbnV4
LmRldj47IEpvaG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+OyBLUCBTaW5n
aA0KPiA8a3BzaW5naEBrZXJuZWwub3JnPjsgU3RhbmlzbGF2IEZvbWljaGV2IDxzZGZAZ29vZ2xl
LmNvbT47IEhhbyBMdW8gPGhhb2x1b0Bnb29nbGUuY29tPjsgSmlyaSBPbHNhDQo+IDxqb2xzYUBr
ZXJuZWwub3JnPjsgb3BlbiBsaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIGJwZi1uZXh0IHYxXSBicGYsYXJlbmE6IFJlbmFtZSB0aGUga2Z1
bmMgc2V0IHZhcmlhYmxlDQo+IA0KPiBPbiBUdWUsIE1heSA3LCAyMDI0IGF0IDE6NDLigK9QTSBB
bGV4ZWkgU3Rhcm92b2l0b3YNCj4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gT24gVHVlLCBNYXkgNywgMjAyNCBhdCA5OjQz4oCvQU0gQW5kcmlpIE5ha3J5
aWtvDQo+ID4gPGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+
IE9uIFR1ZSwgTWF5IDcsIDIwMjQgYXQgNzozNuKAr0FNIEFsZXhlaSBTdGFyb3ZvaXRvdg0KPiA+
ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiBPbiBNb24sIE1heSA2LCAyMDI0IGF0IDc6NDbigK9QTSBIYWl5dWUgV2FuZyA8aGFpeXVlLndh
bmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFJlbmFtZSB0aGUga2Z1
bmMgc2V0IHZhcmlhYmxlIHRvIHNwZWNpZnkgdGhlICdhcmVuYScgZnVuY3Rpb24gc2NvcGUsDQo+
ID4gPiA+ID4gYWx0aG91Z2ggdGhlICdVTlNQRUMnIHR5cGUgQlBGIHByb2dyYW0gaXMgbWFwcGVk
IHRvICdDT01NT04nIGhvb2suDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbmQgdGhlcmUgaXMgJ2Nv
bW1vbl9rZnVuY19zZXQnIGRlZmluZWQgZm9yIHJlYWwgJ2NvbW1vbicgZnVuY3Rpb24gaW4NCj4g
PiA+ID4gPiBmaWxlICdrZXJuZWwvYnBmL2hlbHBlcnMuYycuDQo+ID4gPiA+DQo+ID4gPiA+IEkg
dGhpbmsgY29tbW9uX2tmdW5jX3NldCBpcyBhIGJldHRlciBuYW1lIHRvIGRlc2NyaWJlIHRoYXQg
dGhlc2UNCj4gPiA+ID4gdHdvIGtmdW5jcyBhcmUgaW4gYSBjb21tb24gY2F0ZWdvcnkuDQo+ID4g
PiA+IEJQRl9QUk9HX1RZUEVfVU5TUEVDIGlzIGEgbG90IGxlc3Mgb2J2aW91cy4NCj4gPiA+ID4N
Cj4gPiA+ID4gVGhlcmUgYXJlIHR3byBzdGF0aWMgY29tbW9uX2tmdW5jX3NldCBpbiBoZWxwZXJz
LmMgYW5kIGFyZW5hLmMNCj4gPiA+ID4gYW5kIHRoYXQncyBmaW5lLg0KPiA+ID4NCj4gPiA+IGl0
IGlzIGFjdHVhbGx5IGNvbmZ1c2luZyB3aGVuIHJlYWRpbmcvZ3JlcHBpbmcgY29kZSwgdGhvdWdo
LCBzbyB3aHkNCj4gPg0KPiA+IFdoYXQncyB0aGUgY29uZnVzaW9uPyBTYW1lIG5hbWUgc3RhdGlj
IHZhciBpbiBkaWZmZXJlbnQgZmlsZXM/DQo+IA0KPiBOb3QgaW4gZ2VuZXJhbCwgYnV0IGluIHRo
aXMgY2FzZSBpdCdzIGFyZW5hLXNwZWNpZmljIGtmdW5jcyBmb3IgYWxsDQo+IHByb2dyYW0gdHlw
ZXMsIGFuZCBpdCdzIGluaXRpYWxpemVkIHdpdGggJmFyZW5hX2tmdW5jcywgc28gaXQgd291bGQg
YmUNCg0KWWVzLCB0aGUgb3JpZ2luYWwgaWRlYSBpcyB0byB0cnkgbWF0Y2ggc29tZSBraW5kIG9m
IG1hcCBzdHlsZToNCgljb21tb25fa2Z1bmNfc2V0LnNldCA9ICZjb21tb25fYnRmX2lkcw0KDQo+
IG1hdGNoaW5nIHRvIGhhdmUgc29tZSAiYXJlbmEiIG1lbnRpb24gaW4gdGhlIG5hbWUuIEJ1dCBp
dCdzIG1pbm9yLA0KPiBsZXQncyBrZWVwIGl0Lg0KPiANCj4gPiBUaGVyZSBhcmUgdG9ucyBvZiBz
dWNoIGNhc2VzIGluIHRoZSBrZXJuZWwgc3JjIHRyZWUuDQo+ID4NCj4gPiA+IG5vdCBoYXZlIGFy
ZW5hX2NvbW1vbl9rZnVuY19zZXQgYW5kIHdoYXRldmVyIHRoZSBtZWFuaW5nZnVsDQo+ID4gPiAi
cXVhbGlmaWVyIiBuYW1lIGZvciB0aGUgb3RoZXIgb25lPw0KPiA+DQo+ID4gYXJlbmFfY29tbW9u
X2tmdW5jX3NldCBpcyBjZXJ0YWlubHkgYmV0dGVyIHRoYW4gYXJlbmFfa2Z1bmNfc2V0LA0KPiA+
IGJ1dCBJIGRvbid0IGxpa2UgdG8gbWFrZSB0aGUgcHJlY2VkZW50IHRvIHN0YXJ0IHJlbmFtaW5n
IHN0YXRpYyB2YXJzDQo+ID4gYmVjYXVzZSB0aGV5IGhhdmUgdGhlIHNhbWUgbmFtZS4NCg0KRnJv
bSB0aGUgY2F0ZWdvcnkgcG9pbnQgb2YgdmlldywgImFyZW5hIiBzaG91bGQgYmUgImNvbW1vbiIg
ZnVuY3Rpb24sIGFuZA0KbWFrZSBzZW5zZSB0byBuYW1lICJjb21tb25fa2Z1bmNfc2V0Ii4gOy0p
DQoNCj4gPg0KPiA+ID4gPg0KPiA+ID4gPiBwdy1ib3Q6IGNyDQo=

