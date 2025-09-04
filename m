Return-Path: <bpf+bounces-67469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC29B442DA
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8C7A621D3
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0823B63E;
	Thu,  4 Sep 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1UrFUh2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A03090D5;
	Thu,  4 Sep 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003587; cv=fail; b=gzk0Bd7GLleoBPAAutzmBiIBMMkV34jGXN/PYZNYAdCeZUurWB47KPLR+eaA4rATqobqIqGfWhKUIK9z3BwUZUPpAB+Gc7NZFEMa0fz70rxUQKyyvGrOrbD1jZpR7j1DFuItCfdR5vNz6dNmvprkZLUz5SrAo5GrBtiwwrIGrEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003587; c=relaxed/simple;
	bh=WeP0IZMz5aS5LzJnUIJ/K5j0fc5zF1lVOW1QNbt+x1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1KoOBpxcYAMYmi1CSNTTPfmDXY6z/04nU9Hefx5I8DwP9JZhtpHa5n8F4ZS/4MtqCLFzL3MvIVQKBP90wCg0dP4n1Ft0cGkP3ochbbmQFQ0OnyqjjZwfWmJ7SmD6tHFJ4/CMra7xhRAM14HWo9X1r7Scr9pWnJszzP8duCIALg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1UrFUh2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757003586; x=1788539586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WeP0IZMz5aS5LzJnUIJ/K5j0fc5zF1lVOW1QNbt+x1U=;
  b=T1UrFUh2jaQDBRqg8tNMBS7l3jDnSBfGH8N1YlZD3TAK1OgQ2Pb8lvSe
   7ZNeg9NcaVVmxFqV9oF3DVhkB6j3gFWI4UEAAsZ8tbt+nvW+g+dY7Iyfk
   KqDahanBMZoSTuZDp04C76qLqs/Jjf2f58VETdyucxrjtfZltt3h71gJU
   UX7nMStHPVex3Jx+LJgqkScUcCXnyFXQ4NUTH+ZRBDT1LskAEVD+r/5K7
   cszNelupd7doBvrynLOXEJdJ5DUyoLltDRzcuV9gCBHFWeZ13+1RhMm8w
   1f17yDUXUogclusuWNmtik9dfq/Nwdt1LsWK00DyPClSIM2tM7/aDLOc3
   g==;
X-CSE-ConnectionGUID: ioUlQOvOT1y5DJ7HSPZSRQ==
X-CSE-MsgGUID: SCczTEjTTTqTuFTdBvpMGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="63175393"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="63175393"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:33:05 -0700
X-CSE-ConnectionGUID: sLlM5MKDSk6OPkH7JLKPDw==
X-CSE-MsgGUID: a5eeD8vFTKabPJF1nwBzEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="202869509"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:33:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:33:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:33:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.51)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1KJmPhsvptBFfrfFES69UHPr/eMCRFHt7cPPjrIKWLUyvQjEaYczDuemNC9MzwTOnEwSjb5YaJQY4OybV6aqX9KYQDtqROETgWb75U4dP4387cCPs7wTdax56xhkLuc24C/PWYEgzFuH0DaLUhztHL1YpnerNI49kwCPQCpiL4RYMhmQuu2r1iBSTh3TBjgNzH8RK/aaGztsxlMKes9GqZQUIleg2jaBwhdTpvrxzB3Jyc2gaOskkXhiDJ/10Hn57v5DAH02MrsE5ao9aLftVvDMyXTzwxZLwxmZhtPT91GFUesA/CzEPW8jnFdb4ThX2MUMTzhGzrQwyX5tKCzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkF7j7PMyVvp+bhDiAiYKynN/kx63BzYz/70ID7k/nE=;
 b=cDaowyMyApctWZ8icnJWUvrcuJqnJ0y5HIb03Bb5D3AExx5LhkztFF+ODq35lnz4DOH0fakuDYkMjXoOEQGfjusw1L97H1318QeM/e139FksvkvasACA3wyHtzpmD2cUC6oYZuwgQsf0kwxW/oeFwj7RtvvZH5w0Oh+BQYB6Acq+E2ahUYlqGjcLkBqjxoWVclEk1C4utJ3hqKXcSq3wNs5CpFDhfkZUp2ZI28BFHJS2nWizgjREhwp5CpwGdnEQTtDIRXkdDbmcOL/hICB+6moyAPchXrCjzs83xU7r077QkTsGmMBesil0ok4WblPbWr32aUP7SmcmLzcbXHUsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 SJ5PPF8225D2149.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 4 Sep
 2025 16:33:01 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:33:00 +0000
From: "R, Ramu" <ramu.r@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Simon
 Horman" <horms@kernel.org>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 06/13] idpf: remove SW
 marker handling from NAPI
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 06/13] idpf: remove SW
 marker handling from NAPI
Thread-Index: AQHcFqV4xu5iYcQsAUCoANVg1/qUsLSDMzaQgAAR4wA=
Date: Thu, 4 Sep 2025 16:33:00 +0000
Message-ID: <DM4PR11MB6455D1792D2CBB7E83887FCC9800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-7-aleksander.lobakin@intel.com>
 <PH0PR11MB5013310C54F6A0098AC9F45F9600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013310C54F6A0098AC9F45F9600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|SJ5PPF8225D2149:EE_
x-ms-office365-filtering-correlation-id: fb0a9c26-36c9-43d2-d9a8-08ddebd0b6cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?19LovUZVNiSAqOpG/k/C0l7qXmvNZROifbyLjLOo+yLt7TclkB6FHTwUxZUG?=
 =?us-ascii?Q?5UWESgXQa4gekI7P0ujbFdetBkolnMLhoQXVR12z467a/jroBpdHZLAo++7S?=
 =?us-ascii?Q?8mN+Cr5+Vqe7+5CpbG4EzHcoaD38CjHpwkvUilfOIn5trL6W8Cb7D6rMx+T1?=
 =?us-ascii?Q?cyh1onpmug9a2NKVzPIPHPBIp5HjLg6U6lkM18UWQTnfh+SYcal7YjFi7Kcr?=
 =?us-ascii?Q?memQS7Pt2M/Rg3s14oTBD9ie5ugc/UTRGZKttn5kE9kqHoZfd/MKFktryDVp?=
 =?us-ascii?Q?mJ/k77XFDz1zG9NrVbAhUZFDz/y0tD02vDfOqO1ZO+z2adNlS6Yf1w7dQqdg?=
 =?us-ascii?Q?8cr1u1suQlvpEb8pd3VCjQvseXtppMgwTMNO41pLcrBWqO3HQK8hEyxLXvy/?=
 =?us-ascii?Q?bIYs9qgc5yuOAOsq24t6TJbyigztLVrsjFoahYaBlCWeoGFh0qkSRHaGlxci?=
 =?us-ascii?Q?vOqZsR8EHqfbFoBHNrLhd8t6N7smC0MpW4f3iO/ki0SWEiJBte6Qs4qRe4Ri?=
 =?us-ascii?Q?FitbcDjTNUnw8MYxM2WhYTi8T3C4IeLo0jMA7e4UZ5jwBaQbDgMgppGaLADY?=
 =?us-ascii?Q?nUdVo9d3miRbqZngKmmUMHmEvi+uXBvwvKUAA1o4wHTGpIzrF/IpyMo9yLv8?=
 =?us-ascii?Q?BjoEOE1NjONR4/0VUjuVWG6KH52XKXlCFmM+qi/3zhBGDPy5GbBcMsMIX0+y?=
 =?us-ascii?Q?jVdrKo3HS08i45+3TJ+1IhWBQLxAwDH5cwhTeeounwtXP1coDNcJr1qquh7E?=
 =?us-ascii?Q?fG9lIhp2t1/iGwxtAeT7LO0hQgy8ZO/7B+hwMGfXd8+wWJjIIZoCN71U8c8B?=
 =?us-ascii?Q?6eEI43hk3pWFPWNRsYZ2a71T3rzbXdKIgoKzrph1x62wzXKTQsj7oSP6Lnwt?=
 =?us-ascii?Q?FPz5p2apdAXHMkIGWpKa6pq0r5YRJwH6h/AsqdjDS2PoBbqsHN2C6EEyk8Dm?=
 =?us-ascii?Q?5/fPhm9DZsJ4J6MoOzxtWwzeS9W3CaP34gVBgqQaLq8Uq445VYyTIa5V0MgY?=
 =?us-ascii?Q?HL+QjCkn0gB638ZWlkBdGUosJXt/ipvTOoHYO94PLzFX0dwATLr2xJlMQdWE?=
 =?us-ascii?Q?Jl2Omu79YS8Xgr1wdzx4pdBR1i1B4gspq3jdKqCUZnxgfa2gOnOHsmMYw11o?=
 =?us-ascii?Q?+Rbj75wT8Vrq/smrEZIYvDsSRxis8O8X8JRGKQ34Udl2PdgoUnjCss+PPj7p?=
 =?us-ascii?Q?LnDSOP/zQ1UfINxMAZDQPDCOIHRt9tNf1GsCAM4zMhWwkbGzemtg8n3cU9cW?=
 =?us-ascii?Q?nPEY4FfnNwtLQI8EqDlkdE2VY0IU0al/gdsMKSPmV9zwnPcn3jBA8KLl7dEE?=
 =?us-ascii?Q?WwmYGYX3OOjmMn1IvBJIPseQ1OW3JTpewU0VVjaVKZwujAtld6eYRl4XvKin?=
 =?us-ascii?Q?Fvo1qH1FUDTJMmNLaM1VTYBWIr692xEmNXPv3u2yOhMlNyaXnaDPpkDOfAv2?=
 =?us-ascii?Q?1wp2+PBvZaBOo1A459lnZCHbuz9HBNWs3V32d10idPdxawGa4WpuYw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zYGIwOnKggHXT2scqF76Y5jDlLoqgdvKS/rCZtp3XYXHGQ37/LWKnQFumKEw?=
 =?us-ascii?Q?r0Xr1MDb2haqTMjolxxw5hXnKMLu4HIXhAx+hbmvKF1ejcNf0c3O/+11gDGP?=
 =?us-ascii?Q?761hjNw33nvn74DsnofHixaH/d9xxMnv7l7KXC4F2IDsnyZ8NQKV3qfq4oV6?=
 =?us-ascii?Q?TPHnSia2KaTY/BRUoZGTZP6UsQdWzcCjv4DaVeeyr2V3eJ3ivMdHxWj3QbY6?=
 =?us-ascii?Q?vRfpIDsQs3eNrgDLxjz9X/JKSSzDIrDHMGG/ATU542LNYZzpbJ7k/G+4BDMy?=
 =?us-ascii?Q?nNmxUE/+sBRjuSYQYS5c5JTtAeoBp8/PjyVSilNOPOT7+qIxakw6C5F3pI8C?=
 =?us-ascii?Q?tfqjoeK2WAa6Dej65atEu5ZrPRBf+926AZNC9o0OPQQSzYIXSKXCV+ZmylQC?=
 =?us-ascii?Q?688Q87265CebJEd6HrsQGEMosk13nrBpMHCGwfhBkI/YXFWUFMfaCcLKvxX+?=
 =?us-ascii?Q?Oit+EGVLUKo4sho1yHNS4hmGiUMucVSeVy6uSiq+PgHPkED9cUqZrHD/EOgO?=
 =?us-ascii?Q?p5bDd+hM01vdribkhFnK17Phi7ODn4p41rZDX2+KToMOngOaDaU4LYC3SPu7?=
 =?us-ascii?Q?EcVeKYX/5UWgEmBg6yE0vwsRAqo+ECSMxNhaJKP2cbFWpl9P5QqVVZjarfML?=
 =?us-ascii?Q?bP2ZQDZyEoTXkpbaYZPcsPUJDVlXVQGPeViZ5qv1bQXrSvOxu5PmwxbKFUvJ?=
 =?us-ascii?Q?YO+ANk2XkFkC6z8xZfcRtOfDccLYv6bhi8FK8v6UMPeor5djm3Z1F0KemkYl?=
 =?us-ascii?Q?KwQfOTTkXhXu/xl3uTdFyb87aaJPe0MqfcjZ0wuEMobE5Yhha9rkhOCy6GnO?=
 =?us-ascii?Q?fSZ6OebMaoYxa7JlK/JwWRu7gKVhzAxPHNIhQ2pao2LTpxAdV6nZtTKp1/eH?=
 =?us-ascii?Q?fCUf/9rTnS+JAGbko4pj8pFv1ptarQb4c33xpWHM4k7y8Gvcpo4HOQeK/32W?=
 =?us-ascii?Q?paqvcwuJ9qB1SLK/2NBEZDXtH3JaAEsomRd5lcy7EE0BH04h9qJjbNp+26Uo?=
 =?us-ascii?Q?5L3unb25VsFdcRutCjP1dbKQxD/bn2zfsMktEhebB8ssDn/HamO9Qw3zCdeW?=
 =?us-ascii?Q?eF9Kn07JzlAb1xc+KW27Iz4O3XtoqSTZVylfjBnEdIElsvxcmsg3BgTTgijE?=
 =?us-ascii?Q?x1RwVKJ0u+dW7TZjkVPPFY8DsKDnkYWTPptNaxqqYC8twXLha8oLLrEnaUtB?=
 =?us-ascii?Q?ZEH/68UFpZrWz9QtcG5vIVzifiSkJQFniz6fmCwnYpGp+DshqENR+CSi7lUP?=
 =?us-ascii?Q?97YiTiI1njcgIRWougRfzosj8gcxaRIEX/37CR8YDr26dUF0YhowNBHUvBqc?=
 =?us-ascii?Q?xx1O3QFcIzwaefO/EnPrz5zVD/ADmfx2DMndgzw4SeCftVkMzLwqvk5em3pg?=
 =?us-ascii?Q?YPArja8R/1wQzi7p+EmKCocBl4HS7kn1BUvXZuthyMpMEAv5YZjUU5NWxkPT?=
 =?us-ascii?Q?twTZc7/5MTcu+EX9rCqO6T4ldhO2kaieSF+oHzJbBCOdetDR7hAwaBgXKuaP?=
 =?us-ascii?Q?i9pozYp4FTjNtjUVyrDuKno5DiaQtTB/bp+MapOZW5aMcgW7nM9c4HGQFFky?=
 =?us-ascii?Q?YynhtRIdGMg3b1PW/dU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0a9c26-36c9-43d2-d9a8-08ddebd0b6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:33:00.9031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTChtB7Vm7NzbE6tZaLTIrzrqSpcgZws3DXC83PK0uB7VnjHpHAOtnAmkglzrWRuFbrI83KTc0mshD9fxr273Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8225D2149
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Tuesday, August 26, 2025 9:25 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kubiak, Michal
> <michal.kubiak@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Simon Horman <horms@kernel.org>;
> NXNE CNSE OSDT ITP Upstreaming
> <nxne.cnse.osdt.itp.upstreaming@intel.com>; bpf@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 06/13] idpf: remove SW mark=
er
> handling from NAPI
>=20
> From: Michal Kubiak <michal.kubiak@intel.com>
>=20
> SW marker descriptors on completion queues are used only when a queue is
> about to be destroyed. It's far from hotpath and handling it in the hotpa=
th
> NAPI poll makes no sense.
> Instead, run a simple poller after a virtchnl message for destroying the =
queue
> is sent and wait for the replies. If replies for all of the queues are re=
ceived,
> this means the synchronization is done correctly and we can go forth with
> stopping the link.
>=20
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |  7 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  4 +-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 -
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 97 ++++++++++++-------
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 34 ++-----
>  5 files changed, 72 insertions(+), 72 deletions(-)
>=20
Tested-by: R,Ramu <ramu.r@intel.com>

