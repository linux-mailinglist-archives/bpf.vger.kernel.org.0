Return-Path: <bpf+bounces-35091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A59379E7
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2130D1F219B9
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED914535B;
	Fri, 19 Jul 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asOGzDyQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C68C2D6;
	Fri, 19 Jul 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402993; cv=fail; b=rEg7StlmH0kL81dgh/wKVM5sN2AhYJlB0UADQp/0xKG0bb1C4jAgOsqxvvMYNYKL70NBumgjCWTHan/jGZS++XhLDS3V1tAKpjzGSJ39r0Ww60brsSTfWPOUI0zWq06LAmXKd0rP1b0SX5hGg30tVW6zparAlg7xUs9H/f2yc+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402993; c=relaxed/simple;
	bh=M8A32txsiyXAZHEEt8kJaS40rTnikRNLZQ6GN6xSOlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pfDHl3Nx7psXg7BRne6MDXkv+ZrqhyYPpR842ozYBEGr5JNOkpNREWtLACJtl8Ib28R0VagkQN5u6QXPq37PQSwjPKKktEpl05XFeMqDkKJGRoHkVIFWF+P10Lvh1enEc3OAWIZtLgJufUnT51nxj2dHqZJ7RLGI9cXLOOOgcbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asOGzDyQ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721402991; x=1752938991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M8A32txsiyXAZHEEt8kJaS40rTnikRNLZQ6GN6xSOlY=;
  b=asOGzDyQItLSnW1VItC9V0hSYDbh2FLVPpURZT1csVX5dF8Crz1D36P4
   lb2KdSz7gAliQL8DWSKFdLFeJDPbkCXvzAQp62012n8hh5Cl+3V1pfaRj
   J+sZCf9grYHPqE0R2BWiR3H48uOdEckwx8h66nCF+fgpSbdwdcpq0HGCP
   2CVKyTkBolYNxWEQNgA7oD5dNzPmifr6hodw7BDpWTdtnwKSM6gvHDyDx
   lzf00IJU3GkX+buNo39HI7XWan3SIA6qUQuwfaI8tcBYabsmmJDWl4FAJ
   Oozsdm/YZVyDfbCnPrXSeIxjCfM5LqkYGk2UQhlS9vSFGg/q2HGVpGiMT
   Q==;
X-CSE-ConnectionGUID: NthUmVAxSlenZoq7cKfCVw==
X-CSE-MsgGUID: ELFu3rwXQmqTg3pzNFrOAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="18869002"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="18869002"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 08:29:50 -0700
X-CSE-ConnectionGUID: c016VTBZSE+uo9hneJ9s4Q==
X-CSE-MsgGUID: 7Vj371WjT16afeQxfDhn7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="51038234"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 08:29:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 08:29:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 08:29:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 08:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcaed1cGfioHukh3T/fWpRf8ljd21gLjRVsV/nHdKH7dCYAlQhyKM8RzlcUiFeQtmADA/96kRyR5NuouEKhGWMucaPlvbwJdvkSOgiLIc5DBuA6lxxfcC0k6hLODbIRR2RI5YPHL+J8kHO9DeuB5ycfp6JbGVoJq+FnJz1APvPPvl717e9wB5IhGsyJzJfNcbrfQV6M38Nd2dFRS+cPbxIr1HmVtpxD8Rchpw03BEdrCnzkra6pxBOOzJjog+p+nZllnwLK0UhRnILLoIMN3RfkIa/lV2iQNK81nZP+27LdisHDC+lw+HUZo82pbFBX0kf2mJJpieA9KeealkETlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8A32txsiyXAZHEEt8kJaS40rTnikRNLZQ6GN6xSOlY=;
 b=hUTkGJtdkb0CAn+Pd2/DSh+qbkTGgAW5dmYPgjWphjR0JQRXo7Z7GB3MHtzThNgpa8Uq67aIBuiVNTKjo6x3iL/t1wjYCB/ewJVuJDKNrV5k6tlJsWEEO2oBRPJ3is/OCxo3A137btDZ184C9NIlj8vylL+HH6p4U43py/kMO5k2LpM3F/qGg8IBQb+/d9DG6azGXiODoXxj3cZ0QjWwTv4Bzx0MvrIzLfE4TRzd9mKFXAPAfLpAm6EpxYfn3X88saxk5LLztDQWvSkaqnRCLZ2RdH9wv0E8cJ7TwnEbyyg5m7bt1RPwPqSF+2bB1eDrnXwr5XgEqYFgxD5z5j/r2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 15:29:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 15:29:46 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev
	<sdf@fomichev.me>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, Julian Schindel
	<mail@arctic-alpaca.de>, Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: RE: [PATCH bpf 0/3] xsk: require XDP_UMEM_TX_METADATA_LEN to actuate
 tx_metadata_len
Thread-Topic: [PATCH bpf 0/3] xsk: require XDP_UMEM_TX_METADATA_LEN to actuate
 tx_metadata_len
Thread-Index: AQHa1MdsqV3kO186h0atFXZDssof6rH+NWeAgAABpGA=
Date: Fri, 19 Jul 2024 15:29:45 +0000
Message-ID: <DM4PR11MB6117959BE15FCBF84B2A89C982AD2@DM4PR11MB6117.namprd11.prod.outlook.com>
References: <20240713015253.121248-1-sdf@fomichev.me>
 <284c6aba-8872-f971-7adb-60ed5ab3c29c@iogearbox.net>
In-Reply-To: <284c6aba-8872-f971-7adb-60ed5ab3c29c@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6117:EE_|SJ0PR11MB5118:EE_
x-ms-office365-filtering-correlation-id: 4e12c094-05f2-4a47-2517-08dca8079eae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MUFpc2dBejg0clp1NHFycm1Yb0VpaGJYVUNacGdxdHQvV0dyc1VEQUVIdmRD?=
 =?utf-8?B?cGxQQzZ5VG1rVHVuWk8xU1RkZ0hQOGZxMmNzZzdNeTJpeUgzQytxS1FFUVdl?=
 =?utf-8?B?Y0VpUFlXUWxkRUpTcFUxbGtPSkNKZzU5SmtJSlpMaEh6am9GRHF6NlRwQnRM?=
 =?utf-8?B?VHhQOXN4M2VHeEgzTE92WVB4cDBkVGo1dFFWQ2NrQmcycVVFb2ZYN1N6NFlJ?=
 =?utf-8?B?WEtYU25tV3JOV1VKaFR2MU9KK1FqSERlRjVFaVZ6a2tBcjlSYWJ0UWlpV0RU?=
 =?utf-8?B?bVZMc3RJWGJUcXFjb3NZeVY5TW1TYVk3Wi84Z1M4Sng1T1Z3c0VsQllEejVL?=
 =?utf-8?B?VE5yTmxwNzQ3ZkloU0tKKy9HRVlhSy9YbVlXcFg5bmhJRUJUemFPTTRGRUlM?=
 =?utf-8?B?dWpFQ1NtM1ZSSlJDa3BXVHBuNWlwOHVnakp0WUwvZXVBckw0TzJscEFRTlhR?=
 =?utf-8?B?Wjh5U01LVlFYVGczV3VFVWhTbExLN0xheG05Z2IvRkRhRmxwZFppRGo3QW5G?=
 =?utf-8?B?bG51UDM2OTJNMW9pcUVWZWh0RGNYaTZJbHlXNFZxem44K2VyakVQRENiUWR0?=
 =?utf-8?B?Vm9RZTRNRTliYmZsQzdPTXRxTHY3VDFCTmlUdjJPaDJXdDdhMWU3aWVtZnU1?=
 =?utf-8?B?V1g4UThLZ0x5VXFDcnJSY091c2VBY0NManoxcVlUY2d5R1dSWEJYRzl4aXlZ?=
 =?utf-8?B?TkNFZzYzS2dJa3BwUnVYbjY4VHJudkNXV0tXNFhpOStYODlhdzEyYzRkK1hI?=
 =?utf-8?B?ajVDVC94S3doajlnQkdvN3NhaUxpckdrOHNqMENKN2tRV2JzZDdHYjE1bnF2?=
 =?utf-8?B?NUlJWUxMUmZ0OUltOFBlbFFOYWpCYTM0QlBYa2x3N2xXb0l1KzJUei9EZFZP?=
 =?utf-8?B?a3l6TzhDb1pZMDFFNjE4dEMzckdqSjJwSHhPSk5VSi8vWUpRWnJrc0dtU3ht?=
 =?utf-8?B?S0JwT25lUjRpWCt1NlorL0IzUUJZSlh6V3k2OFQ1akNIVjkvZk9VRSs2bGZq?=
 =?utf-8?B?ejNRMnBKUGpJNmlYSWtTVVZSamVUSE85TjhVT2pQUHN2ZmkzZTdLQWZwZjZS?=
 =?utf-8?B?YkFOUnBNajM2YldrazhMOHo1MnQvaFB2TGN1NDdOSHdibmduNThBdXNBblQ4?=
 =?utf-8?B?bkhRbjFLc0NqTUpKTFpCSTJ6TklNak05ekNLOVlONm5JaVpBUzNkOVVaQlda?=
 =?utf-8?B?UVN5TlZlMjVBSWhCOWZJOFZYUUx4WThnU2k3L3preVgrMnB6cWN0R1J3VE5L?=
 =?utf-8?B?eTFBQVpxZXkrUEczMElQeW1OM2E4WC9UKzBoakJpbXFNaXllTWRCM1pVSnFK?=
 =?utf-8?B?UC9CR3hrd3JFR1Z1Ujl6Q2k0eTZCNmRXTlVqYTZUTW5Da29rMEg0eS8wQ2FZ?=
 =?utf-8?B?MmhzbXNud0FSN2VCZGZ2MnY4cDQzaGdrd3hTZWI0SDJHSjdPanpuNFZCbnFR?=
 =?utf-8?B?cXB3cWRFNUlVRXdZSjRsbXk5OWg2M09sZG84Q3V2N2loa01tK0YwL3NXS2JE?=
 =?utf-8?B?eGJVNW1MckZvZnlzaWpvMXdtS1NPUUkvWHh6a0ZnRXE0amZIb0ZWb0UyNmJM?=
 =?utf-8?B?M0x5bFFHVDhTZllrN2MyNmlkZzNjb1VRejFTUHc1ckJRNkhXTGdDRmZxcHlV?=
 =?utf-8?B?bWt0T29tUTE3SEo1anJtUFdPemowQW5JREQ1M1l1RThSZk1JbGtTODN3cGIv?=
 =?utf-8?B?VUozS3Y2bjRtenhDcEM4K2RBeHRzY1o2TGlsK2ZSVVlwbEZxVHVsK0k2aWda?=
 =?utf-8?B?T0gwUllPOFlrYWpRRktiTTQ5c3hHWWQxc3JVeDlhVVpVbWQvUDAxM2VxTEJN?=
 =?utf-8?B?Yk9WK0svTTRHdWc4QVdjU2NhV09vMlRzOU15ZFdOWU5yU0lIUnE0aUJ5dUtW?=
 =?utf-8?B?b0JzaXcyZW0zWGNDbmlsRVVVZUEvd0tFTDliWFpzUjRkWmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmVYeWFOQmZUNEV3bHBsd0J0RjRrODZyYXdreFJNWUpucnRXeWpWa1FENHYw?=
 =?utf-8?B?aVZITFp2OGVIOVNRTmh2d3dtRlNTcnhDYnRDMXZjeFFNTmxuNGhSZFhlcFNy?=
 =?utf-8?B?T3VCQWx0b05VM1RYV0p3MEIwcWdDa0pNY0F5K3pWN0xSVFFqakpIQmluM0xw?=
 =?utf-8?B?V2RwZEd2eThCNFJRaGp5TzhFSE5TVW9xTHZTYzZTWTY0M0tsMW1Ic2VzWUs2?=
 =?utf-8?B?eS85L3pZWC9teHZUOVNta3ZXOHR2QVVwa0psckRwS0t3T3BSbWZyNmc5WGFi?=
 =?utf-8?B?ZGNrM2tUZHJONUN5TXE0VXNJaEJ4eHhzUzl1VjB5VENPRDRBek9WM0xDVEtK?=
 =?utf-8?B?R2pDWW0rYktka25nNFpEUXV6eFpESHNlSEpXVmhNR1J3T3JqZnhTR1NyRERB?=
 =?utf-8?B?aUNRaThaOERFUWg3RHlnVVlrTmxYZXViM0pMUFQ5RVBTbEtPdUZpRGQ4UGRn?=
 =?utf-8?B?V3NSOHVUUTVURzFMR2xTUS9EM1J4SFBEdzdJcTVNRW84RnI4ZCtoa1JyenRB?=
 =?utf-8?B?NEdBbGRVckVDM01oTmdmUzE1cnp5SGxyTGt1eVB4V2kveUlSN1BqRVBWR1Rj?=
 =?utf-8?B?MlJjT2E0Wll3bkhhVU42cW80LzgvZ0JzQm0xVHFYVjFJSzlLV2V3MU91RnZU?=
 =?utf-8?B?WU00RVEvYUt0NWFpRVdQNXFvSEhkOC9oWm05ZGtnWVdjNmc5ZDF6am0yVDJm?=
 =?utf-8?B?Vkt0MS9QTmFwb0V6a20xU1FYN0NaM0FuZDlKRWN1SmVCODRBbGxGU2lxTS9B?=
 =?utf-8?B?YWZ1TFFleVFTSHY2UHdRM1JGWU8wbnRLcXJ2NUJuZkRSK2E2bVFLMHBUVHZJ?=
 =?utf-8?B?ekJMNVh0TlVrajVwc1RudlRyZTVra2pQaTd5MGQzWVMzdlRPVW5LbjYwYzF6?=
 =?utf-8?B?V0FYUW9wZVZWY1ZGSDdrVnpPeUhkOGs5SlVEQlJMZlhsSUhzZUw1R0xmMVlu?=
 =?utf-8?B?a3o4N2ZmdUNXQUJqRTJkUk9nL0dzTHVlWjhBZHgyODVhN3NiL05Ec0g3Q0h4?=
 =?utf-8?B?aVYwc1hsYmZwOEV2bjBjWUtyblIzd0N4Vmd0ajNTcnhpRms1MkVmaTlDVWR5?=
 =?utf-8?B?QVYyTHJCdXJhU2FJbTdPVitTWW44dUozbEJjc2doY1ZXVEFHQ0V5Vk9wOWlV?=
 =?utf-8?B?eUkyRERISzBOaWdDQXdEYXhtU1lCa1cwbUlQaTdyZjYwODdWVko1eXdqNjg3?=
 =?utf-8?B?WUVjQUhOZ3EyZk16ZzhUQVVqSXU5SWtEZW5jTXlMZGNSdFJsL1B0SEFYbVBZ?=
 =?utf-8?B?ZUFreUM3YlhFVngzMEZDelNsM1VsSGsvVzVnUVRkSm9CcHJQdEFyTThhQWIx?=
 =?utf-8?B?ejdJMGVMcmRvSEk0bDhJRUd2dGo0dXVGV2JsNmI3aW1kcXY3ZHZnT21JUnpy?=
 =?utf-8?B?N0Y1NGpSWVg1SkV4dTcrSnA4VnN4WnhXVEJNV1hjdTRrVzhCRnhLOERLcTQ0?=
 =?utf-8?B?dVdpcXNzWmZxM1YwNTUrYjl4WmRBbTJGY2VDQUVKL1QyQUtBeE1rY0dZUjdu?=
 =?utf-8?B?VU5UanJic3N3ZXdBVGhoVzNuTEhmZVA0V2poSUU5Y1EvaFdyTlUxVlgrc1Zy?=
 =?utf-8?B?WDRPeitRbm96TFppRVljSnRlSG1EaS9OZWhFTjMvb3c1WkprT1hLV0o1bUd2?=
 =?utf-8?B?dmpDYStYdVBPUWM0cUJsOW5qd2xLaDVWb3c2MHpad1BKWmFOZklSRFpJVzB2?=
 =?utf-8?B?Q3l0UGxIZW9qZzlKc1ZsOGlDUUpnbUlORjFaUkxnTDVrWVphYTlNLzE3R29V?=
 =?utf-8?B?cytsZC9ya2ljR0ZzR3VROXV6czZsU2JSZHhnNzNTdnpLam10NHN2QVpFbFVs?=
 =?utf-8?B?MW5RbkkzUkhCSlhUWlVRZDU5ZFE4cmYwd3pUS3lPaVBxZW5TdEM4b2hKNTd6?=
 =?utf-8?B?WlRhb0N2NFhWMG8wMFdKWVMzTEdjY1YxandBeDBtYS9Td0FXV3dQbkpiRXZH?=
 =?utf-8?B?NWtkZnI5S0FQQ0tFaCtVemF1S0cvZ2Z0dElyakVsOUVuRXYxcnZTaFY0SnBQ?=
 =?utf-8?B?RkZJWUdZOTBWTkd2RDZnc093bVN0Ly9aUGdPVXNqaWRMVjgvd1pjTThVLy9H?=
 =?utf-8?B?SU01VGZJcnFoUGZaZ1p5SjIxZ0hrUHRDQ0x0V2kwemtjczNBSS9paDNqamx4?=
 =?utf-8?Q?HDeq6ew2A7a+QTV3IkhN3ilke?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e12c094-05f2-4a47-2517-08dca8079eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 15:29:46.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFsHVIsM5cwGzKh8HywC8ewRkKkJGBlopEbEO4KXGxHgCp3ZviD1X6S/CwvbR2WtP/LzgbMPYKR09J5NlMlX75aEin3lJVEjxCypSbUJMVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
X-OriginatorOrg: intel.com

PiBPbiA3LzEzLzI0IDM6NTIgQU0sIFN0YW5pc2xhdiBGb21pY2hldiB3cm90ZToNCj4gPiBKdWxp
YW4gcmVwb3J0cyB0aGF0IGNvbW1pdCAzNDFhYzk4MGVhYjkgKCJ4c2s6IFN1cHBvcnQgdHhfbWV0
YWRhdGFfbGVuIikNCj4gPiBjYW4gYnJlYWsgZXhpc3RpbmcgdXNlIGNhc2VzIHdoaWNoIGRvbid0
IHplcm8taW5pdGlhbGl6ZSB4ZHBfdW1lbV9yZWcNCj4gPiBwYWRkaW5nLiBGaXggaXQgKHdoaWxl
IHN0aWxsIGJyZWFraW5nIGEgbWlub3JpdHkgb2YgbmV3IHVzZXJzIG9mIHR4DQo+ID4gbWV0YWRh
dGEpLCB1cGRhdGUgdGhlIGRvY3MsIHVwZGF0ZSB0aGUgc2VsZnRlc3QgYW5kIHNwcmlua2xlIHNv
bWUNCj4gPiBCVUlMRF9CVUdfT05zIHRvIGhvcGVmdWxseSBjYXRjaCBzaW1pbGFyIGlzc3VlcyBp
biB0aGUgZnV0dXJlLg0KPiA+DQo+ID4gVGhhbmsgeW91IEp1bGlhbiBmb3IgdGhlIHJlcG9ydCBh
bmQgZm9yIGhlbHBpbmcgdG8gY2hhc2UgaXQgZG93biENCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBK
dWxpYW4gU2NoaW5kZWwgPG1haWxAYXJjdGljLWFscGFjYS5kZT4NCj4gPiBDYzogTWFnbnVzIEth
cmxzc29uIDxtYWdudXMua2FybHNzb25AZ21haWwuY29tPg0KPiA+DQo+ID4gU3RhbmlzbGF2IEZv
bWljaGV2ICgzKToNCj4gPiAgICB4c2s6IHJlcXVpcmUgWERQX1VNRU1fVFhfTUVUQURBVEFfTEVO
IHRvIGFjdHVhdGUgdHhfbWV0YWRhdGFfbGVuDQo+ID4gICAgc2VsZnRlc3RzL2JwZjogQWRkIFhE
UF9VTUVNX1RYX01FVEFEQVRBX0xFTiB0byBYU0sgVFggbWV0YWRhdGEgdGVzdA0KPiA+ICAgIHhz
azogVHJ5IHRvIG1ha2UgeGRwX3VtZW1fcmVnIGV4dGVuc2lvbiBhIGJpdCBtb3JlIGZ1dHVyZS1w
cm9vZg0KPiA+DQo+ID4gICBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcveHNrLXR4LW1ldGFkYXRh
LnJzdCAgfCAxNiArKysrKysrKy0tLS0tDQo+ID4gICBpbmNsdWRlL3VhcGkvbGludXgvaWZfeGRw
LmggICAgICAgICAgICAgICAgICAgfCAgNCArKysrDQo+ID4gICBuZXQveGRwL3hkcF91bWVtLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgOSArKysrKy0tLQ0KPiA+ICAgbmV0L3hkcC94
c2suYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKy0tLS0t
LS0tLQ0KPiA+ICAgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2lmX3hkcC5oICAgICAgICAgICAg
IHwgIDQgKysrKw0KPiA+ICAgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy94ZHBfbWV0YWRh
dGEuYyAgIHwgIDMgKystDQo+ID4gICA2IGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyks
IDIxIGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiBNYWdudXMgb3IgTWFjaWVqLCBwdGFsIHdoZW4g
eW91IGdldCBhIGNoYW5jZS4NCg0KSSdsbCBkbyBzbyBvbiBNb25kYXkgYXMgSSdsbCBiZSBiYWNr
IGZyb20gdmFjYXRpb24sIE1hZ251cyB3aWxsIGJlIG91dCBmb3INCnlldCBhbm90aGVyIHdlZWsu
IEhvcGUgaXQgd29ya3MgZm9yIHlvdT8NCg0KPiANCj4gVGhhbmtzLA0KPiBEYW5pZWwNCg0K

