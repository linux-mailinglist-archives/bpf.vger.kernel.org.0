Return-Path: <bpf+bounces-71671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A47ABFA45A
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC1F3B6B8C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 06:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09222EF66A;
	Wed, 22 Oct 2025 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdvveMnv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824502ED14C;
	Wed, 22 Oct 2025 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115275; cv=fail; b=hyQYzDKfYierdP+fF8435uC4yfHjGSvcWq9bT/PT7MSUEptcIgp5HT1Z7luQPrRWo8ME3+cj810jLi3AUaT3AS1h8jcp8v/yXALsLo8yeQ70pPxIOFE8coJWuUT4STwW5yYEENVXR3+9p2K82SLBx+cPOHXJRLcrPRY6O8rQup0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115275; c=relaxed/simple;
	bh=bON9y+kgvGsijCR9SjiTBCqcvQ/1+kCGtE0Lg3tCLU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pD/WBTtd1K7qhsHQ5NoLOZA7QLH4Sji1R4ZQgjUxQcaZOAUIM6FF3l4EdLPQ5gwWHCSZmiEy3D07ktPsozkUpPcyejFVNf5ojVWBfidp2j0tb2OsaTYlYJX18IwJIBw8B90kt0ji+Yslg+G4gQYK0w55p2ZXs6TdIKYmppJdnBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdvveMnv; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761115273; x=1792651273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bON9y+kgvGsijCR9SjiTBCqcvQ/1+kCGtE0Lg3tCLU0=;
  b=EdvveMnv2vw+sxvPmrVP2Ln7ttDOuiC6i4M7Bz4g9moD0Q+MDdoZWf4m
   m6+NCWlNuCSWesOscZYFrN1q/HjleekBPVKSwT+pjvKGMFEjGhu7P1+LI
   4NO1ob/LEuohCeKu5W/Iy8aA0F5zDIKkkt9hYffG9b7LZL3fLPW2cOHeH
   22tT8lxUODasIoVxJvR8n7WKbNldEJn884k/vaE9L16/qJRlIedwUSHH1
   6Sqx4GcXePzZfYZQRojiRrYcSm4CbSb76V+mP05PtVYQWypELDk3j/v9h
   i1d5SpboUXNOe4j6Ew7jcmIZuDc5rHNpvo835gtl+cGlrjeuTOZc2JZcf
   Q==;
X-CSE-ConnectionGUID: dabKExI8TBKg7BLP+Gz9fQ==
X-CSE-MsgGUID: RHqzeWzxSompz63obiv03A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80877585"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="80877585"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 23:41:12 -0700
X-CSE-ConnectionGUID: SoMdebzxT5CF9WrLEyrgvw==
X-CSE-MsgGUID: iaJV6UMDQDaxdtB4Dm5oLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="184272193"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 23:41:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 23:41:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 23:41:10 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 23:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRVHUPBZnxdDSZ7MG0PUZvdSRUOTXvmy2r61f+fmeoFLv+oqjEeRMlf+dMUDUhTugBmtYnmmK7+iD4sdxWH21/v+AccawrdfvKla7yIHKrnWhZjrXtrVALeofMpHuIFkCTPngnVo2MK8dWgLoN9Ho6DXiOPoGZz6f/2uPfbo1Ovd1SFdLxs9AxGfi7sbnQqdTeCssa3A6RdPNIHjir7Bh4IAD5m4YnCK2UUEKKuqQlIxVtl1+nQVaBtYRJ+yeRQuOZrCzYgwi1UM0+q4S3xNSCNbZEehRFMmy4SUYzMOnTQvF2nSZS+ZQeujWLH9mZ7saXmDr7IPXR6wNi+Q8kak5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pgzS4EM7NPz3DiKzwBezB7ZEv5+AYr7eDPbU5qfryM=;
 b=KWw3sYxWaH1zPYWMw6umaBp8jrBTcPeo0gDEHvZ949lVdE6P0CASu0WR1H/DLYbP3gKYLbLhlocMJR8Sj3/QI7FwSExGPkPRLcrgqRUlzz5FBER4kSqkadu8KP2kUo+J4Fwwa4/APMmSX4cQXMU/hoJS+Dt5phOWWjoCcXnqje8xFhYkPFmiEescqVPa/FA6kW4WvsLka/EvM+Wb3boGoMoK6y+G7QRmzTbgdvh5mP11VHwGuwo1O3Y/N0uwwYHj2RsFzfYVo0YgXiVK2WfKq2+PjSW7YQR7KUXL1HPfxEVsuhZ387KfnDhJoUHXevKjtnGozfg17qijCO0cUjukxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:41:06 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 06:41:06 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alessandro Decina <alessandro.d@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Thread-Topic: [Intel-wired-lan] [PATCH net v2 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Thread-Index: AQHcQrEAYw5QTEkmhU6uJRbf7EnwSrTNuDdQ
Date: Wed, 22 Oct 2025 06:41:06 +0000
Message-ID: <IA3PR11MB898659A68BE96823DE45B892E5F3A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
In-Reply-To: <20251021173200.7908-2-alessandro.d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ1PR11MB6155:EE_
x-ms-office365-filtering-correlation-id: 95eac996-067e-40b1-b682-08de1135fa84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?JdOGWAfUNLTETGnI1gkbX1UV59ZdfYIQWonTUphM0ufdQz1nfMEBtipFfD39?=
 =?us-ascii?Q?cw0KUcoh4T66INmndgg0obrZcTNx0/kzuX6DKZOQwBUtWUffoSH4lcQ6t0eX?=
 =?us-ascii?Q?51x1w6yq7RHs6inP1BjwBbiCbQOCKEafsVdNWmWpk3LcQ/5bPrVzBHEBFOi9?=
 =?us-ascii?Q?LnuF3BYmvvYGtw8Y3ZsYRRX+5nuAJxukA4jsfj8c3hxTJ/657b+qPbPLggob?=
 =?us-ascii?Q?2gtyWUQEEaMpZJ+hM5sT2uMVszVqGvk9yiRIq8PXKI52OJqZTuWrktqe5IbX?=
 =?us-ascii?Q?NDJAC42gr3lsChb0NWf27WB88rTsei/OipD2yAvVPFLO2DLWH5Wfg/vQ0rLe?=
 =?us-ascii?Q?TDBXnV1KnDqYyu8wY77ODOnDn9T/ZfKNAB9aWSSQHjckRVG6ESvahLjz6XgZ?=
 =?us-ascii?Q?iqI/4hUmTZt3mgeS2Rk/2TMOfQosaUuHC0n8KGKhzbpCLGi0GWD+HX1O9vct?=
 =?us-ascii?Q?tRdic/iXfkjOa2WgYl7VLizE99X0QTHZD1hjGKloH0bFWw31sFBD+mm0VDV+?=
 =?us-ascii?Q?BOdjErrwcamfwlFFddsKwykz7Zpo8GcdjvEeNPTf+to0Y/0t61E+wiIlxjnf?=
 =?us-ascii?Q?OoY/yF0G1PUvmwxBv9VCiNDnkYx5z8XMLJsVUA4+dUWoboF9PtApXNZc7Ntv?=
 =?us-ascii?Q?5WIplZhvA7/oqyxzAx6Ey5bxxe/OKByMoUUe85NstZCRa8klao7RPJXYNt8H?=
 =?us-ascii?Q?6LTV0sWA/ittcdvsiiqssuG9scYEXW1/lfZfWYMyl26Cb3o0X5PAVfRhDBF3?=
 =?us-ascii?Q?AeT9zINeSnQD5n847/4nd51mlvLY/yUAgM7V8Yl9aQ/vfaOO58S8rrhnWJhE?=
 =?us-ascii?Q?vkEsWGtPSB1XasssgqSxB4L7jNjIcbNnGyIOJlshXLUKcdSCnUXJ5UBsIoNm?=
 =?us-ascii?Q?GyB3GRHdhA/fh9tYN1Ape6iKmGkaOABQg4paUU+BIRbUuJ1CRmpW6JSOZiwi?=
 =?us-ascii?Q?WpBiS5eVineVtzp9DRumrWsP2E8GpEsD9KV87Gd4fvu+s9e8vbLA5SAiW2Xg?=
 =?us-ascii?Q?rsr76uMrRDCleX3viTlPywKqcKUJEI0kc5r2OB+iBQ/NGc+1oWae5bRiy0Tp?=
 =?us-ascii?Q?wfcgUw/clhzC4RkEhaZTk0B7oUYShxr0gxYbvhbGWbXX+/f2FGjei6D2Mwta?=
 =?us-ascii?Q?JO+MVcGfuPTj3oEkWgZwIloinEaOcv3an/qu6rhxt/a01XCf2o6RaovIKDko?=
 =?us-ascii?Q?Al2801+POScorQ5mRFBqojMvixhuiq56erV/zQuJv/Mx7v25pRNyAAu1dVHr?=
 =?us-ascii?Q?IkEvQN/uavZhqOaJe/qZ+3OpF17lcf/RmpPdGid0NcjnkOq6rROVQkg8QMG+?=
 =?us-ascii?Q?36xev4mi1W/yj5XGfvcPzZwrgIFNQ+V0FVosIWfUM3++Jvx9w913i0WkCFmC?=
 =?us-ascii?Q?WUCTB9LDc1XAKbjNPwfOfB7z3vsY+bFvE81/w0IWJzOqkBUUTf640TBQVWy3?=
 =?us-ascii?Q?GClLkgQSQpePI3K65j2I2Chfcaw7Q8lC9kHJsQf3Iqw3FcEcT6wOONT9B88h?=
 =?us-ascii?Q?AljSLoPzmsclUKo9K11wvdQ7Fw9AxAg6Pi9N?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TY3nEBQCHt/fVz5SOV+lL4G3CeBuKxXWTZdLnWHMoJTA6KfEm19Ii78enS52?=
 =?us-ascii?Q?t3r6Of6zWRQl13bvTseEzS8cwu2Os41knoHBbhJ1xJmsuYP0yJXA38vgLyTd?=
 =?us-ascii?Q?/OdZRGyI6LpnV+5Pdw4XmnW9z6waeBr4OGfJa2zuPNU1tMBFWNwpW3nw3lVo?=
 =?us-ascii?Q?KXOvfHGkCiTYkVVfFP69J+Xdc2bowDo/7Psopi4y5v3nDVQWBF4eGLEKe516?=
 =?us-ascii?Q?jmLmHkVdKRBM6UKUp/elRvhbMDtrA6/KAqcUJBFk+pi2VV54Pn8gtY9Mc0qL?=
 =?us-ascii?Q?Gl3mCW7zouhROxSU8OxVRoBTf86b/436HRM1jiLdDsozR+uxfFBnk6Ev2QGt?=
 =?us-ascii?Q?7LqsdcvWUYYWUzeMQ6TgQkb6MqTSzlAKZ6Tp2etRn0uHNDu8NvGbiOlQF2C7?=
 =?us-ascii?Q?nur/8MO66eQUWiNWteuOVDKIu1dztJAgSLH3ObqI8pcnhsGeDod1rsvrHrMs?=
 =?us-ascii?Q?ffs+VOy47HRV5yImJU8CrWJUz9AFWi9QkKpXjQ4/z1PsSfwN+2DoZ4MAvERl?=
 =?us-ascii?Q?BcOxVGUs8Zcc7JPZ+1tMbg8ODhTRQEAlw5RtFUW46DuceL8i2zd2eyHwAd9q?=
 =?us-ascii?Q?obE1FDaYOcTRKKrI87ygiQHSKbjCuUmJa1vAxJMTyPMV5P8cB37GrQjgrmXl?=
 =?us-ascii?Q?PnQjVUL5s73XAAJJDNFiKMXACHUnPE30iUgQ9KGonsnUfwwipJbDKthgeByW?=
 =?us-ascii?Q?BNJwu49vTMTLz1uKUPjkNlX0orqy/CZq8ff4CGyz5BDcZeJPUu6E8etBHYqb?=
 =?us-ascii?Q?bb8CKw2wd/e+J8b8FCwSng4luK+3YMT1ooMnuLGry2ow7joMWONYAipESXMQ?=
 =?us-ascii?Q?K1rrKP5YsvNI96nEHokFD3lZsQoJJKgMAGE6w/4go0Di0pX+zyErbsPz6idG?=
 =?us-ascii?Q?8FUVhYbQ8ffUk9aV11M4eBU/+DlbWEmlzpa5QWXLkfaTHdODd8O8Q7Ti4SoE?=
 =?us-ascii?Q?TAPJg91bOW6aoQk5c8K7w2/ftUjd3aOPARDjd8XGAzsyBn09fDvQykO/+ODq?=
 =?us-ascii?Q?CGp2KkO8MlBy3m3SsiLlfNu8NAjTma22AYjZIgzkKYMDof39SzO05mXa92+v?=
 =?us-ascii?Q?cWQbD3ZOinBmz31ZdRK+xtIhPRF+KONro0wx3aCFs+YTWOOKHQ8Sa1pPk8ZM?=
 =?us-ascii?Q?1O7o9VYBI05mmrGARDvrHX1QdTh33q4OZlryZKyegZtt6oHzZwhAyjFHBQDL?=
 =?us-ascii?Q?L+nFvK87a6SjfSJ6sFm5V/ciPEifePkax6bTxnkwGT8vXau/537iGojp8aGI?=
 =?us-ascii?Q?HKQ6ABlyT2vc4WZu4p1GyheaTt8yAxkdDJiNiWQWtWsRtfTSEfZ9ZVMVtpNH?=
 =?us-ascii?Q?ZBTouw+L/EkXmCh6HHE26Q0MX0ltTGGKcZuOU4E68Dsa25dQvvfYSA1bDEBK?=
 =?us-ascii?Q?cHkMoo7QEaoyGcEprPO5gUWeyjrGYJNQ5LKhWIw+wh7fzz4hWO7z9KeTntUj?=
 =?us-ascii?Q?Qxj7VZUMH815Z0bLqYIaoAMHG/6eUqhHsCCsnC68U1Opw3+Cgf9XPPH5V6nT?=
 =?us-ascii?Q?qewKV2DVSqkESvNjwS1o3Q8pSdbHruiZqYAwCRJScz1BlLEbNCGSx2oL4DSy?=
 =?us-ascii?Q?44kgRc1Mj2p9SD+zpFABIfnc2YNRXi1HOVxqUkqeAui/LhAvv2o2L5lRv5U4?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95eac996-067e-40b1-b682-08de1135fa84
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 06:41:06.7079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4l6ie2xiRM533ryKG20Q/mi998ccplg5cj3nzejmfguP7ce6huE9Yibt0jeLWyPM7vJOwG6IRe04sgelFIoaf6KVABQhsgdLGxtdO81t++0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alessandro Decina
> Sent: Tuesday, October 21, 2025 7:32 PM
> To: netdev@vger.kernel.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; David S.
> Miller <davem@davemloft.net>; Alexei Starovoitov <ast@kernel.org>;
> Andrew Lunn <andrew+netdev@lunn.ch>; Daniel Borkmann
> <daniel@iogearbox.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Jesper Dangaard Brouer <hawk@kernel.org>;
> John Fastabend <john.fastabend@gmail.com>; Paolo Abeni
> <pabeni@redhat.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Stanislav Fomichev <sdf@fomichev.me>;
> Sarkar, Tirthendu <tirthendu.sarkar@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; bpf@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-kernel@vger.kernel.org; Alessandro Decina
> <alessandro.d@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net v2 1/1] i40e: xsk: advance
> next_to_clean on status descriptors
>=20
> Whenever a status descriptor is received, i40e processes and skips
> over it, correctly updating next_to_process but forgetting to update
> next_to_clean. In the next iteration this accidentally causes the
> creation of an invalid multi-buffer xdp_buff where the first fragment
> is the status descriptor.
>=20
> If then a skb is constructed from such an invalid buffer - because the
> eBPF program returns XDP_PASS - a panic occurs:
>=20
> [ 5866.367317] BUG: unable to handle page fault for address:
> ffd31c37eab1c980 [ 5866.375050] #PF: supervisor read access in kernel
> mode [ 5866.380825] #PF: error_code(0x0000) - not-present page [
> 5866.386602] PGD 0 [ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI [
> 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted
> 6.17.0-custom #1 PREEMPT(voluntary) [ 5866.403740] Hardware name:
> Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025 [
> 5866.412339] RIP: 0010:memcpy+0x8/0x10 [ 5866.416454] Code: cc cc 90
> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe
> 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 [ 5866.437538] RSP:
> 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286 [ 5866.443415] RAX:
> ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1 [
> 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI:
> ff2dd26dbd8f0000 [ 5866.459454] RBP: ff428d9ec0bb0d40 R08:
> 0000000000000000 R09: 0000000000000000 [ 5866.467470] R10:
> 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8 [
> 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15:
> ff2dd26548548b80 [ 5866.483509] FS:  0000000000000000(0000)
> GS:ff2dd2c363592000(0000) knlGS:0000000000000000 [ 5866.492600] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 5866.499060] CR2:
> ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0 [
> 5866.507079] PKRU: 55555554 [ 5866.510125] Call Trace:
> [ 5866.512867]  <IRQ>
> [ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e] [
> 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e] [ 5866.526022]  ?
> srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.531408]  ? raise_softirq+0x24/0x70 [ 5866.535623]  ?
> srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800 [ 5866.551493]
> __napi_poll+0x30/0x230 [ 5866.555423]  net_rx_action+0x20b/0x3f0 [
> 5866.559643]  handle_softirqs+0xe4/0x340 [ 5866.563962]
> __irq_exit_rcu+0x10e/0x130 [ 5866.568283]  irq_exit_rcu+0xe/0x20 [
> 5866.572110]  common_interrupt+0xb6/0xe0 [ 5866.576425]  </IRQ> [
> 5866.578791]  <TASK>
>=20
> Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
>=20
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..dbc19083bbb7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring
> *rx_ring, int budget)
>  		dma_rmb();
>=20
>  		if (i40e_rx_is_programming_status(qword)) {
> +			u16 ntp;
> +
>  			i40e_clean_programming_status(rx_ring,
>  						      rx_desc->raw.qword[0],
>  						      qword);
>  			bi =3D *i40e_rx_bi(rx_ring, next_to_process);
>  			xsk_buff_free(bi);
> -			if (++next_to_process =3D=3D count)
> +			ntp =3D next_to_process++;
> +			if (next_to_process =3D=3D count)
>  				next_to_process =3D 0;
> +			if (next_to_clean =3D=3D ntp)
> +				next_to_clean =3D next_to_process;
>  			continue;
>  		}
>=20
> --
> 2.43.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

