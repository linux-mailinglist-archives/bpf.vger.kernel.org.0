Return-Path: <bpf+bounces-67475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CADDB4437C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76A23AADFB
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA030CDB0;
	Thu,  4 Sep 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZYrru3s"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C82D46AF;
	Thu,  4 Sep 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004213; cv=fail; b=sSV+5b0n+M4dALgr29wC6JLeg8j4fEhnREjgOahKD0yICTuSz5HYQKhMy645yNO3ZMkKs3T8P1mS50IHcXNobMtLRFgdWsR5k5JwXdWo5ZBvKPBpelsPGioxVKOqlOib6yw37osHZzMN//MxHs0pknBdMlACZVqEPYQtlMtcOBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004213; c=relaxed/simple;
	bh=7B56DioEgkPEq4ijSdUGNMTyZEgUnt5nGDHWSYnCaYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPTNdaM5Bper/ys4FjDtmVLT4O32tkId8kC0k4ik4g7ul7CmT0Zy3SM1uFGZqqamTvjkNBstvApjBx1bOrhCLT+8W5OlfnWUe31KAy/9GD2wxeoAyXXBV1VnL7EWq+UXjE2nEHHZml7IjgswSkrRb1lGL+FEkoSrUoLZ9KdgbRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZYrru3s; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757004212; x=1788540212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7B56DioEgkPEq4ijSdUGNMTyZEgUnt5nGDHWSYnCaYc=;
  b=EZYrru3sml69PQFPtgT0hIT9d02AxG2Ml5eWIry2VLsp1z1mRdzaDFTz
   ZznPpos+pZOFYHCk3D0XgcNU1ng4LKBCynip7M/kWUqbKwzdf3HjNBV4c
   OjBQq+MP1P918uFgXs8PedbW5+kFdkcbmlJTumnfdQR2xUWudCndWLq7w
   mD01PdYDXFS+5RbRgZxJDOdJ5uOVvgbWt7LdiAZSSJo5sM9wmWWV80b6n
   37sZm58Orfat+ONpYTRE4uWa80CXlmmCx8ak9UOu19bT80F635hsUEE/t
   uUuE2fYpjnAnOvm6t6ePuBx4FdZzj9cqTvhRgZrujwDSeDPeWtRHFR/wt
   w==;
X-CSE-ConnectionGUID: tXLtCbnrSuqeB+0xA8XJJw==
X-CSE-MsgGUID: ES/J2kEsReSizQoAiWl8ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59460422"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="59460422"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:43:31 -0700
X-CSE-ConnectionGUID: pwpoeiexRbWObpytOLdhdg==
X-CSE-MsgGUID: XI490XT2RnK2fPqwaW7DGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="176281591"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:43:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:43:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:43:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.62)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqb98JOy89IatJcETVQldqZyOhdpPpy2m/jTwQltpEFy8nDLu7ao49TV+MTUA2DrEwJqAkpcgVqTU3BiZyznttB+vPYsu1OWoWr2QCPoHP/i59bWKIvX8xoHPbVv59+FvdGWmjJrfbl5saCTkPMgRTz/RMgWLVjN9j/sbgvy0+Ge6y4qXAcQV4uQcrOYELn24PmzqKGFndVCJNSoflWPI2m1JeW2w1CXhu18mntKJSPcSo/j8Gqs1PuUoRC3AP1t2ix0QqR1sUjXT0NL6xk/Tq8cQBvQzZPDNxyxGH2uPj89W/zbjM8rb2gYpiFxEhXk81YCsgi5kpKSCx+thE4xcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NgtZLJQMgeIoT0yzeZvrXcBgsL4UYPMvtBfVyaJOoA=;
 b=uSGv9N1lpW/ppvoU0tbyULxLgtyW+eY5zjnHDEHNiHaOYnUyL1n4bbwXzl3a00ObvNlrxaNHZ483iRnMZ0alPXfBrn+pby5oyRu08dckzUs8Psj+IQf3PdHrfL+SGD7cMARmufuWu8N6RTJzQjPBq+NlIPmWJDP8IbEcmZoan5rjdpJ71LLY0IrhdigR/a5QMc/OiM0WBm7/csCy5aZQgbrFiwF7AkwYBL1PrvIoODy0du6byoprZ4MnbVIjYzMMM9kt+FH+VjjcwQBhPVndK7H6fFLusaRsI1HfvOBafKeughqTh/YiurVOfMyVSH2Vx93sI08UdCjS1QsakU3UsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 16:43:24 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:43:24 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 02/13] idpf: fix Rx
 descriptor ready check barrier in splitq
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 02/13] idpf: fix Rx
 descriptor ready check barrier in splitq
Thread-Index: AQHcFqVv3zJ5tvXgVk6z0OS4dr88irSDMvPQgAAVi+A=
Date: Thu, 4 Sep 2025 16:43:24 +0000
Message-ID: <DM4PR11MB64551BDC0C6DE8AA57C4542B9800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-3-aleksander.lobakin@intel.com>
 <PH0PR11MB501389C85BEE4E0550FCBD139600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB501389C85BEE4E0550FCBD139600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|PH3PPF9E162731D:EE_
x-ms-office365-filtering-correlation-id: 0ddae3e7-b9cf-432a-84cc-08ddebd22aa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bqnLeFxNCmHh1HWwWQhueXCuVILNz0DZeaCRc9mTEX2oJXclZrprhdwf6V1x?=
 =?us-ascii?Q?NuubIO3stpESIfIcrh91kDJyDEzFHyW9GW+wWk2mbnt4qw6QzURwhuuNQXpl?=
 =?us-ascii?Q?/cZ6+9Kn2SwnIZCM2bPh41wZd2qlXsJYLw4AMbIl595p8MpRjoNJdSUsR8Qa?=
 =?us-ascii?Q?QS5w2WEIVR73ZA0q1hrRTSgrD5HZqXZInslprCaagP8o0wKwLVeffZ+YHBvw?=
 =?us-ascii?Q?A0TNHyIs6c4Mw6XvAtDZabx/pjZSt3I/mz2bqhFc+2VWZV54dVvLOHE6HMqI?=
 =?us-ascii?Q?8Znw15PBIFtGK3QOrpvGfLcry2AzXbwbavqFRRdls43yI2M3tEhXyLh8koYD?=
 =?us-ascii?Q?RQaCKz48jzmG7nqXxIRXYRGupT605zYiSzuE4UhDBbp3yBkIlc6rTvLmyZtD?=
 =?us-ascii?Q?omy8U2V02CdycJUFM3NcRelX/j5GEDYgISzUVH03Vaq9/IVN59QG6ciRmaAZ?=
 =?us-ascii?Q?VKdCxf/aGvIgbEig0rUnmRCdlorUUebACwsOI/YjeWhfd/vd9VkH4BUbI8Xd?=
 =?us-ascii?Q?vzi6/+syinqYug9cmEgdESuG09GC5yaNgcO7B3PEWIN1XsuMt+KunVdErm2k?=
 =?us-ascii?Q?H5dRoyt9ETRy1IqKsp75BMcGbvmxQ7lTbunIKpKcAZkev+40gslHtO5AhRXl?=
 =?us-ascii?Q?rPGHce18K8aJKsP72djuMaSY5foHEhxrzcYJbvsKhp9roft9cDh4LX/sSjfd?=
 =?us-ascii?Q?iK9sK+ZYXT7cvITCwbcQFn18VgTJIvFAAuB0fZpSmG7yVL17In92Ky//jBMu?=
 =?us-ascii?Q?bfH6hhTRDJRJ0Tyir/YRvgWy4mxkdMIUTcHq0iF9cXpSVOc3jNt/4N8X402R?=
 =?us-ascii?Q?FE5DZgwbV03WZK1gEQgq8AvLpI3LPlMKHxCzuoJ0itVBJl9y3wzjZoo/21ge?=
 =?us-ascii?Q?e5XRr/ZMJsvgheqoNbbcdYDSSpXoqNn+f8ttRVFtf6fv9Itm1w7zxhZQ7tmi?=
 =?us-ascii?Q?im4AIJDM21svRzfcXDTtWpP/cSm5BC5K2bAATjBYlEsYoMIxZVkrOWddbkcm?=
 =?us-ascii?Q?2D793rbp0GyJ4DREygTM12a6q09nuOKsZSKie7767bFzc9GRp+TCZAzCmzcs?=
 =?us-ascii?Q?oAj/OiHDXt+4eQWiy3S/TvL0xMMhgMHvjcZXGQt1VCCkkwu/MTha3e/4aqW5?=
 =?us-ascii?Q?vDprhtPdnY319zXvFGB2ZuqX2xygYZayph9L1EvqFp5WbqRcya7Socgzr3Hm?=
 =?us-ascii?Q?MHOLn5U3M1Df4avTyzh80acnjcX3im2UdYAfW/tTjJgOceF9rkDz0hRef5g7?=
 =?us-ascii?Q?FjdaRNl+BplRYgd4kYQ2XYZW+kBSJDvYikX1Ed8UwS2MP5IJaom5ElbKry+y?=
 =?us-ascii?Q?aIb0yG2Ovr+R9PU7j+jHffR6KezlaBmJlcfxxW5uPCehURBFZJK19F0Q7bx1?=
 =?us-ascii?Q?eo2GpIKGzQwrzG+RVIfxQyob3++w2AYQJhxOmu5sSGQ66ntiCE14PSARsd6m?=
 =?us-ascii?Q?KhFgUSHQluZAQ+tlhFK7Z26AHgWURyyHVhTl2lOhfosi+L3hmcflMQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8d+JAXrioUcut+1rcMe6lMyrIoO/b09yyMmI2pOnWuYh0oRmJhpBx4xWIWJq?=
 =?us-ascii?Q?LAxIGroykHwioZ7CPu0SFPqCcRvTMmnSA/0U9DJ5yjK6MGnhCUmAy2cF+ce2?=
 =?us-ascii?Q?bv7vedBQgN248bCGTPbeo6qQhR/U4qfgh9MyRZK0zY42/ZQV26DmKnhiFK9A?=
 =?us-ascii?Q?dNLfYDFbgzPvo2Hxl1ivlBmHMRxE6HgKGcWeMxW64wvUaKsDHjnIFPiFom7e?=
 =?us-ascii?Q?YgyP+aqHknqby4QTgkX/vGckNeHfHcckWPObtkm2rQmnbY0VWkqZE0pGxhJz?=
 =?us-ascii?Q?4NX0u5EKJL2ibnseJQzlrOYDOVJmEQh77ONXVZ2fEtRaXBiDRebuizCOTRBa?=
 =?us-ascii?Q?c9YP5BwBR0ckvrSwe4LvpyLmvYnujrwNj7wEThZ8lRhKfRwxZEr64+O+JCJk?=
 =?us-ascii?Q?0ypoqHLsskppcfCUfrqzTkZw+4hGrCdZy+UMfTScygkyFr61Ci1jifoTPHCd?=
 =?us-ascii?Q?Ky1hLFglRAcEV1uEC7sMMZyGsTuzK1oND2DVL1+yLy+ydUNWsebODKdzw5qO?=
 =?us-ascii?Q?3V3keMJKrUkFI+JxEjUxe/Za1IWmmitOvyN7c47NTcuApNP2lX016IQqGiux?=
 =?us-ascii?Q?/uMi1hj5gXmtGgH+FIrmQlS2DywNUAvebQcN6QBRk3J034q0leT+0zlq1TIz?=
 =?us-ascii?Q?LWDHitcMp5GBdXl9/lT3QBnfeUqlyjsqU7KTes/FTDiuSGMmsu/FXl49c8Q1?=
 =?us-ascii?Q?EdEJkRfUjFaXJ1zrDCekbcxgx9VCHgsO4aagKaJYxFmHQgLiSrAzQ1f/UrFP?=
 =?us-ascii?Q?IojkK9tIriVuXAOs6MFF27Gb6EGAC0JnfxeYbfNIrXmvkXH6ki396Ic7ZlDv?=
 =?us-ascii?Q?Y9EBz9GL2s8QJMGtL28AD29p0nvi/W8w7vLTK1i+Ah+AAM+FK1ZA3DzBuGLp?=
 =?us-ascii?Q?KQJniutdT6RPUPt7EkyGgmQf2TCpQrEagHR2Thndw1R/rTNfCTrYALoVdmfZ?=
 =?us-ascii?Q?WtbEVuOHuq2R/jONmClqikh9J58mXqc9b0RzJd3Oq8/e17OKdn6YJ1JYzqJr?=
 =?us-ascii?Q?ZI6147KQ7t5JvcxACBK0bJEN/+KRugslfItZqKEZ1BkcN75aQeFvbjHNvAHe?=
 =?us-ascii?Q?jDRVyVEtxDaf+i1bBKxWZVqTHxb3tq2qU3wc/qcfMpntytMtcWRbHszgcBgs?=
 =?us-ascii?Q?PG3HnihvUUREkUFlTXOD3fQXOAGGGYyEtdN4EeczCI7MHuP1Azgj9Jfu0EMl?=
 =?us-ascii?Q?14rgySESjE17mV13vaXbTQxLklB8RKMMKMwzfya44FEKBlSMKqiKMn5WnBz/?=
 =?us-ascii?Q?zwZU82Ubsa09xzO1iLdmjJDTTiEiJYAMWs5FwUaz5Yt19VwFyLbE3g9pyYeG?=
 =?us-ascii?Q?ffz7qdJzA1IaG5sPfxV5okPstx5/+gARXLo644OFox7qMllVKmjuWn300JzX?=
 =?us-ascii?Q?ScgiZDzzeZTDInYla7jSelFlojsQvyxHddzQ9gUZtvDQgH+CmW+MWOk62SKR?=
 =?us-ascii?Q?+AJMYWb8b7TrlLXzP+eXYdqJxiv6PzxQWmQncsemd0nOXdSfbrVKLXni8an5?=
 =?us-ascii?Q?eiOO/ubrLVlq4WCiFh+qZZm7n2pfNaBRvU/68wXEVB7Wk8PWwGY4/y3+sD2M?=
 =?us-ascii?Q?dlfvPlv7TtAjuKcZuMY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddae3e7-b9cf-432a-84cc-08ddebd22aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:43:24.7594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dW4+3a2n7f+YNprOMIq0B1YeEn5HWUMh4+9DujziRHuTPrQGIf4VvlRIOjsow9eYNe8JWbS2Q2rvAo+1+1LLtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9E162731D
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 02/13] idpf: fix Rx descrip=
tor
> ready check barrier in splitq
>=20
> No idea what the current barrier position was meant for. At that point,
> nothing is read from the descriptor, only the pointer to the actual one i=
s
> fetched.
> The correct barrier usage here is after the generation check, so that onl=
y the
> first qword is read if the descriptor is not yet ready and we need to sto=
p
> polling. Debatable on coherent DMA as the Rx descriptor size is <=3D cach=
eline
> size, but anyway, the current barrier position only makes the codegen wor=
se.
>=20
> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
Tested-by: R,Ramu <ramu.r@intel.com>


