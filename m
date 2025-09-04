Return-Path: <bpf+bounces-67471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB787B442F4
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AF33AE7AD
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48382F99B5;
	Thu,  4 Sep 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1owktfB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4232367D5;
	Thu,  4 Sep 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003827; cv=fail; b=qru+ZqtrDYB/D1WDUrQgZbY/+ecY1pxt4wBq7c8upTWxgqDP3pPdyrR5q0kWooICj4llY8fw4Gt6Zp8bblfKkWWThHyXdF0GPp5+0CzM569cPTnMs93B9FyJKIGuSm97cHoeEB+YdHULf33jXYbxSkzxLqPj3AJa+FT89QAxkDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003827; c=relaxed/simple;
	bh=efZvXkL4t8NO6VKoM4QUQxAGqUoElQ2UaqnGdcy7k7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mysuTk25IpVYD6T+7wyaNpa5CLW/Hte/3UN/CB9jfqOf4/IgJ5+6WBRJ69sTC3P4crYSiuUEKxweQ2YiOvzpGsBq5Ru0Rl2mUrUr0YYedXrc+NvPoqYmOkFIVBi+ChyBfR2NQx5UFOyG9zjeH26bODDh7xKf3WWUb6MVU2j6ZzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1owktfB; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757003825; x=1788539825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=efZvXkL4t8NO6VKoM4QUQxAGqUoElQ2UaqnGdcy7k7c=;
  b=g1owktfBgzwgErNiqAcBLpcapeyta8uWPQgakG8b69ZQDj68iVNENS/G
   loL4v2PtiQfu03rhPxj508Je4WLpE8neaLDwpR00FFU35gLkZgR3YfZ+9
   SLHZI9ziFb+UNlK6EEoE0UDAJy7cH19IXalzxy6swtcSemYsYfa1DD8lA
   EYxOlT8AxexwYWu/NaXuPvJfXjvJlmfDzWbE85+Huzzp+BJunsntdanVF
   P5lW78kLGkeYmzTlWVsx8Y8EkxAvirITkcVVlPUCaiDJOYhwqszDFaQ7M
   2v/kB1QmdpPA4qzb+2B0YuJOrVH7vUW+GMOuMMgl2vVRZIrHNfoZCiNCp
   A==;
X-CSE-ConnectionGUID: hW2qi8eDTH+G/jXZwTqUlQ==
X-CSE-MsgGUID: ooi8uEk9SX6L4Hun7EfiVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59419587"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="59419587"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:37:04 -0700
X-CSE-ConnectionGUID: UjwchH6+RJm36RUrsNyYxA==
X-CSE-MsgGUID: 0iHWET17RAmPIZFLrK3RfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171881284"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:37:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:37:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:37:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.43)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:37:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5+PeYZAyLeQy301FIVtCQf0aWSqaI2FLISeWXEXMUdXs93Pk4YHalqIOv9UTQVE1bhlDpCb1qny3Wk/z/zE6zJu3inu1ZJA7yVXUx2zkbRojYmojPspSwNZdkgHVpqk92OjkOZOCFLkq0WyDvbOd0qIFJPYIrnKXDlpn4kEIBNaQQg7e3WyEW7GUKF7eDLOxpUycmEKjjRQgkRsTYb9/N8X+5zU9fa0HAwTTV21Z72GgLSIX5grYmnxBjwP+EbCpRCIkPcU87oNBkGViPyXaAS6VbTwZ9okS9PXazpL7n1LUQv4bEAId2RnjDIcxymvdm+dD69Ke4zeMIVFF1bcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+en31VyNsY84h1bKIfHwFtjudotaStcYpvUXNEP5SnI=;
 b=d+y9T1LqZ7DZP+lUQOO7EeqhooDXVzgBkcVcwcmMWloPllqA5R4cou0ViqPywv06RKlCYUbniRxFUPOMOoAJY2aQ1V0Qkxt7zWFOeE6mQ3YJuckLie/bqfMC8iFQ4jR5b+wbYuRQ5h8tUeBE+K3NuUf78JUkngEuUSv5HE7NUz8wKMIirA/akkU9M8FHK+t6Lm4PNjGu3hzhkGZ8Bh+IHIRU3SQS3WSMPjTIly5olKjCDHaxf1r5xLNuvqDO2aoIpWLbd9LFeU1rFpZYBgKTTk0mDMQOaa9RzJvIiYmVNP554lkaGTbZ7V2HiS51yV+DZBHvddUYkOXWC688shPpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 16:37:01 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:37:01 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 05/13] idpf: add 4-byte
 completion descriptor definition
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 05/13] idpf: add 4-byte
 completion descriptor definition
Thread-Index: AQHcFqV1lY2C6LxJf0WZT93yq0YYYbSDMx5AgAATmjA=
Date: Thu, 4 Sep 2025 16:37:00 +0000
Message-ID: <DM4PR11MB64550E0884B745F3B66B5B409800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-6-aleksander.lobakin@intel.com>
 <PH0PR11MB501349FEDC2D158B29D2BA3F9600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB501349FEDC2D158B29D2BA3F9600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|SJ0PR11MB5216:EE_
x-ms-office365-filtering-correlation-id: f67eeafd-dde0-4f0b-ba65-08ddebd145e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?sXISq/Tbbk/cYvSwCj+ur71/l+XxuxxX9K50PMxw8EcLTyEs0bD72EP3upsw?=
 =?us-ascii?Q?ze+nc2zWKgc6EuDRn5mdwA5Lkg0BuVSnLCC4m1AsjUAYYPmRVv/KzzCDiJLs?=
 =?us-ascii?Q?NM9T/3AtSguV8H82De3MemluWqku48wHy8M/Obt/TqZqmao/dl9I2DK9BNH6?=
 =?us-ascii?Q?rUG8GINL7yH8/lYzca3x1iwfLV9kwOG8Pgrta7qCNiOaTxUEUjzZk3HIinIx?=
 =?us-ascii?Q?gUqzxQUJKetrDcBm9RNWCGt/zfTnvd/4omzbAVqxLbP4SeTg/vkIUh6KDntg?=
 =?us-ascii?Q?Flkf3lw2cAsJ/fN/GyP7GdUMb+er7G4rAfcsgZwqBBU6Ys2I6/vsUDdqA/aM?=
 =?us-ascii?Q?eHDRczwxp/StOpvgeVX+f6m+6ZHrwJDPdYpI406dQRp34zZwpzLNVDVFCjqJ?=
 =?us-ascii?Q?UtLS6Leh627X8njBTtZQ3VY7WZCBp3F8BbVA8awLyuVqaWdEZdYyUZWiMErx?=
 =?us-ascii?Q?C8VtxI3xD2pATNpOIKzxRlDSoRMKm/krkwkbVWNV7Jj4ovLm5N0k77WiMbvc?=
 =?us-ascii?Q?srllBy9PEkS7rbZR26hH5OSgTnELDqow7bJPfPSyqEAbjaQKNfBZtEgDFauz?=
 =?us-ascii?Q?cS7m80HCp04UBQ2FtOMx/qu8Aaj42MQIrRgqImTFFTh4067GRJOb/Cw+V7zR?=
 =?us-ascii?Q?9ZlgKJ8kI4kkX1Gz1KUw3HaZA27Ob4kIpbFtaKxRThpcMfcnXQ/bqvztqRQx?=
 =?us-ascii?Q?gt0uQHyjJhYSGva15qsAfPs/IdLZsfoobNvSDq5tT7ljEx0Q6CgjChKhe23s?=
 =?us-ascii?Q?8qfCZX+h9rbYKm1L4FvO9nVRgOb+HntPRfX1JupIJR4ByZi01SBD2NigQNAA?=
 =?us-ascii?Q?tl2wHph2SmzltgwsEpHJIh7Byx2KFtdk+xD5sPjxzwU7Bn6fpxPOfgErcZ7r?=
 =?us-ascii?Q?S6KYMRuDhYQv2lnL1F+oH/34VBcIBnDseZiFzBvTo40cHNsCILlsAdEC8c/1?=
 =?us-ascii?Q?RSn3XesQLNy2KJZUK5NYnbkm9m3U0y4jxtIa6TE24n58yhVf/RIxOmtoSFg3?=
 =?us-ascii?Q?7xfKrcOOGQJASWbFO30yN2ijd+U8Ma+keAyf0aaqqYFuRmrSLKFze5mSAsUd?=
 =?us-ascii?Q?FLmp+Qgkzh/GdzMBv9ZJuw5PTMVX/r/DXXZ1zfvSITbhYBomvJctZQK465nd?=
 =?us-ascii?Q?sqFEUEOZxuovPKl4723D84omFxEnsyUj9GALJd7YKeM2pqzJvKExtViaoZWW?=
 =?us-ascii?Q?qPbPPNlGqCoUBk8cVojEoVlm+DLZ/cxthr54ary3tthUlt1qFu7XTU9bLn4F?=
 =?us-ascii?Q?cxl77nWvL31FjqfOx4yM0jH70/55xXvYvPvcVsJ6e83Jh11HrnYj8ry0tCiZ?=
 =?us-ascii?Q?4WNBBqbNX9yPdpuz+KhJFOrDtGTF1mVeQYFLyu+AKcgWT/eXMMo03WJLuDWH?=
 =?us-ascii?Q?9HdL2gRhvglx+969H4PkhvJZpvnhP/g+ZUh/0TZMGJhbS1FucuPJ/O/zPX2A?=
 =?us-ascii?Q?G23orp4NZRmvEXRlJgwIAIF4oSNI5F0F90GY2oCiI9+TGsiVX0BozQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WJzoIRz9dyTNcpdLCL4X6kylAwNrFRdJOxAMA34eXxKon8h+hGVwH/Zsl/0n?=
 =?us-ascii?Q?MmKNQqdXfBjf6uHgHTb2O4lBOqFsitDXJdTPGQsqUAGRnRF44HjhqIVtCB4r?=
 =?us-ascii?Q?qNfBAfpiUEuQ2paW259hyK2e9br/Obwm63HST7zggyM1PoKhYC8FHX7LoNGr?=
 =?us-ascii?Q?xu/FQjDZh8cjzYzLq3sqRi2uPXjn9LZke082U5qkhgtN14x+CIQWKT+ABd9X?=
 =?us-ascii?Q?v3ewLvDc/NHh2XCCraLvcRSAtUNaRsnVSdGK2EbQ95a4j7VjjdN2bR/3E8hW?=
 =?us-ascii?Q?jXYKh40Xr67yDUsvDOsdBKgXCXnSWjIW0t6ffDrKrYL/91dvsH8OxpxpFDM3?=
 =?us-ascii?Q?4gJfTH/5MkCkcUi7KYhUKutMMBD05m83UQZYt4CyrbR4zjGv7mTj6X4jGE2Z?=
 =?us-ascii?Q?TML1V/+Y72TYhtYB2uB2Vrc6R0Is2/BnPIQwGB1EcMre6cXUVpcE/jwikmac?=
 =?us-ascii?Q?ajtjIAQEW74beLaUYAvJ6CsgdEuhVQcSYUoaoq6ov6IcxQTFlkUv3oQgEoBP?=
 =?us-ascii?Q?7uCUTdtcgsnHYbV33HhuidbxkvpUx89q89ugfbz2O3mmUNtLQ5HDqnnv4Q/e?=
 =?us-ascii?Q?h4uw1lno8eVBrCTTaaCLobfC19CWvL1cM9Om9mOo3xlgu1H/x5+xhRwCvVvH?=
 =?us-ascii?Q?oj0qWzLyGfh3VeOj1UreCDlKCEMYAangyUFnvTUH7v2DTL3MmhoIgCISt46f?=
 =?us-ascii?Q?jDxr1zUf/g/HM6BVUcgRssZjOlJoKmrKJfrlUPCC3/7GLgk40YR3zqydwiY7?=
 =?us-ascii?Q?Et0po287276xTrnqd4rl2xot6OLCUINFnccTOVygfOklnDONv9QTk96X4O/i?=
 =?us-ascii?Q?JMAyNP22E5FVnTMtwY7mdG/Vhb5zRqPdl/F+JlUHkdNknjYvqfeFCV4N6L/I?=
 =?us-ascii?Q?opn51JV4H0dYhJ424C4VDrpKwvbN6BcAI/Z/3nvOt02NS8ZvHsfh/IHlmaDx?=
 =?us-ascii?Q?T7FQy+YHYxl35LnPpntARjyjV/k7EzbfWW0KMFeY3govmBIlri0qW2/G7FFW?=
 =?us-ascii?Q?7zIaXn6nQ0gwntMPVu+pbp+1AkFrLNxyNJltpa0+CC+ypC1wTL9lTXe8Cu3K?=
 =?us-ascii?Q?op9cTPbI+KxJD8gcUfgNRLtFaHTEBTU8HRTzuEaUvHjLi1jxBHTJ7Mdm3NSU?=
 =?us-ascii?Q?kUp4l56UNaWJ80gRkMKseJk6dvOBsPnQ74FOmU3Arf0XP/fHQr70Q5JyIiZ1?=
 =?us-ascii?Q?pUyKVpa130rgNjN6p+45F/evEBN9AGTvMJo+3uCFQmfWQIe9+dG2WoGcr8wN?=
 =?us-ascii?Q?HgMOSlmD5Zju5EHptN/FfJOd2XYdHVuqAZaaQTTES03auH7u1PaYioYc6n1r?=
 =?us-ascii?Q?ETE86kr/E5bZrUIk1cbUav8+YvX2NO4p+ME5q+cORycnaKwcXUVM1oHggRxH?=
 =?us-ascii?Q?HrgnVeLFMCNlkHBjdA7/8a61Vn+rQGIaRvrnT9gXNTwR+QMQEsvWm3nqzWVb?=
 =?us-ascii?Q?Wq8QQ5XwOESFBOc2bRUhiIbYrLtaPXcv3afvA2sKJytEfxCas8Is/N5fwJvt?=
 =?us-ascii?Q?wCTl4n/WaPIpeZRDbpKL1qujGm5Ai2l3vYfa6/swE/0zACPIzH2VKKEWSESW?=
 =?us-ascii?Q?nN1Ze2iXeIotUxiVnqY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f67eeafd-dde0-4f0b-ba65-08ddebd145e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:37:00.9276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MhCmb12295GiYt4+1gp2QDkIIyCCYeVbusRYixBiiEHpWv0HBmN9XzGAkFGbtjAdqY3QaV8WuR6OphLBQiXiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 05/13] idpf: add 4-byte
> completion descriptor definition
>=20
> From: Michal Kubiak <michal.kubiak@intel.com>
>=20
> In the queue-based scheduling mode, Tx completion descriptor is 4 bytes
> comparing to 8 bytes in flow-based.
> Add definition for it and allocate the corresponding amount of memory for
> the descriptors during the completion queue creation.
> This does not include handling 4-byte completions during Tx polling, as f=
or
> now, the only user of QB will be XDP, which has its own routines.
>=20
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  6 +++-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 11 ++++--
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 34 +++++++++++--------
>  3 files changed, 33 insertions(+), 18 deletions(-)
>=20
Tested-by: R,Ramu <ramu.r@intel.com>


