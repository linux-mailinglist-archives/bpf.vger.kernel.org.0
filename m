Return-Path: <bpf+bounces-67473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E31B44302
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2051C8672C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399953009DF;
	Thu,  4 Sep 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQFHDIwN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924242F3C38;
	Thu,  4 Sep 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003914; cv=fail; b=c4oyBzgzC9nVcSGtWN4DoybOTGUb6MjbuRuPr7qCXOqEaOiy1f68/6jGp7fXLyMYnGnjTGZ6OujW9r4b1hE7XwuNnVscg9vTZBN/y+XahwfbpSu14omGIaIac4AKl0Kdb83N7pGUyr4JX99LdO9YJ15YqyeT6VCj7l0PI6hiAKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003914; c=relaxed/simple;
	bh=DwKYGM1qNECqc4dPJ+iBvFkdCs9Ybuxam3LnCli+8S8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JPCneE7jCEA/TpzU2reWJuwQ5DsUy8ombb5BYu6PGQ/OfDtOZGw/3Pd9dEz/n84NIyHoLj6n/WTjtIGKR+HNQrO0Z1Ay9u/27mEqSforaoqnm1Ve/ios3fXodmgIgdITwMlWCKtPBgo7qadSkKV2ESqNxI5NqgC84/azFOU8yeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQFHDIwN; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757003913; x=1788539913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DwKYGM1qNECqc4dPJ+iBvFkdCs9Ybuxam3LnCli+8S8=;
  b=YQFHDIwNNuPbS5Ga3Hck5cRdiF2Il7sXFRpOttqjdjJE5suIwNtulcdV
   kgVY+GIurnUJt9GBz1ogYtf8J4zeAcCt8PH9H5HYz1ZSBxU2BtNehWhzr
   6e1QXL5CwhxB5C4ktOAZ52ZVUx4yZLHPDR+CcAZ4ATC3iY8hFdxKvbRdY
   0OkivPiD2fHxMX90lx2LL0AVQfJZOzHPXUzPgB6pcW+V0zA+ekOPvcFLs
   I7NJZPWo5ipeq/R9g0vywzQTTxkpYLXJao0DxjWyMgMsnaM6JYnJUcjC4
   7LNJvVuGmTavOWMp/BnGqXLH/RErQtIo0P+MZNx/FpE+l9iZYDxy2P8ZS
   w==;
X-CSE-ConnectionGUID: VpGEF0dBQSGYp2LPhMVyZA==
X-CSE-MsgGUID: e/aJYGJGQIm0FJT+thXOwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58384265"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="58384265"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:38:32 -0700
X-CSE-ConnectionGUID: yj7hR55DS3iV0DxS46kAhg==
X-CSE-MsgGUID: Y5N5ooK+QBiC692COyaOyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="177166443"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:38:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:38:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:38:31 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.45)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdG0p/7JZmMxbge5ljHAGP4lyXrErcBW/88hn6WyhmQ/tKkqKm8gkWa3oxRksV17EBnIvl8u6lhvGdtEzlPAu/1bOyTBAt2n6RzjQppgrux9xJ7JzKlUaiuG2tHaE/ozzuD3aV9b8zxSM3RQyBSB286zLa/JouYwxGCKHrMoJ5yKQP09RdOb30WfOSD/pzff1xexIfkOH3j21CPFd6KACk/FFy4NrFcfIs+MbS+KQpAjtcrUkIlyL6ekDVJMCLcSHCuNNBXjtJeSzNk5GLttF8Izu3yNDgyat8cEFLCohz+u5wWF0XRJLuhIlbMP/jwtSTATMOYsK6nBvgBXlEXUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+ORR1MYOWfCIfVmAf5xX5JqzAuUEaouPi/YEQT8EBk=;
 b=U0hqEctqb0wsSadi2o/5Ko3zmd57SBHZEKI5VLEW6C8qVPY83/JyZBJin8jGlhWRSRYMXOuHXSbJwt1Pj/SbVe7vwEAURiPcZMcH3fAdWhp4ktDKMP/Uc6VRtPdJRNSfhww3jg+fd0ixZZffVtC10DXRTyqVVmLGWaAm2FHY04RopU8mQYSwbGp+d8CkfOwmWadHj7KbkESH/vW8Kghl/bOpvWKOuBnlf8EYnqEB0tjXvAAvoRZ4S0a22NeXDYc4KJ+s8dAgeTT7JppWS8H2jkaM7sDKYu+NEJgs+9hGvvL7MLU4qcXxJU6G9Q+H2f87v555LQ4gnBUZ0UMeN4kSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 16:38:28 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:38:28 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 04/13] idpf: link NAPIs to
 queues
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 04/13] idpf: link NAPIs to
 queues
Thread-Index: AQHcFqVzm/4yuSBVOUiCwSRcDaReq7SDMwuwgAAUGOA=
Date: Thu, 4 Sep 2025 16:38:28 +0000
Message-ID: <DM4PR11MB645524232024596740D7DDFD9800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-5-aleksander.lobakin@intel.com>
 <PH0PR11MB5013A0358A8D847F0E757A959600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013A0358A8D847F0E757A959600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|SJ0PR11MB5216:EE_
x-ms-office365-filtering-correlation-id: 15b11c1e-e7f0-4a2d-d571-08ddebd17a1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?e1J95sg8zGR5Sg0UiVCSk8p0WS5dfktX9gngczb2zLMLH2OiD/ek26IIyvS9?=
 =?us-ascii?Q?Fb05pXWpRArWHzF+frdQlgILW+bM6RN7RBdS+conZ5OJcQSz0WPvqr4qBdKa?=
 =?us-ascii?Q?NmQoWbp/kmcO2KljfdKFl8d8j48u7LlmHyPgxqBKzYQrc1FyPU3fj0YZ+uLW?=
 =?us-ascii?Q?Ovnrsc98hcRhy9us99NBnKjgSK4MChHp19G8BlFtX7jbUI+lWt8WOLGTrgP/?=
 =?us-ascii?Q?GoHxkc8ccQJDsaX0h1r/jZC2MoR8QuRFFL0yQLqWHoEFYx3/saCQ8NnjvcTS?=
 =?us-ascii?Q?h1CGX7rK0hgdDG5/0r7CrIUhFgi44JNY7H/beh/KKtlFRztr0dCc+gZ4P1mt?=
 =?us-ascii?Q?lebTaCwhbvMSLcMmGKpuzYGbUkGO4u4asfCE1o6xuCXOMUndS5ixNFO2fgxM?=
 =?us-ascii?Q?YDGTYzswQsd3DMnoCtzKqWtQavz9eRo9aYTSvaCgJq1Lg1zXDQQ06I4hHqId?=
 =?us-ascii?Q?aNR2EoCPmSYPdOrjpEl4PxZZeagPi3fOl1G6HZDHRwx6mxwDc5VQb3xcFCce?=
 =?us-ascii?Q?C7fo1mofbwSNvNBTjrKt4qqUgfCyGvc3RMgvgGMWgW0mS53JjVIsBwRou7BI?=
 =?us-ascii?Q?HVSqnwkuakhdyUpUJ5xHk2JJNjQDZUNM2m8lGnglbqi1IoZ6StG0T5X7JF5E?=
 =?us-ascii?Q?/Dco6pCTyjqro5KJCaiob8eiqpgv5gs5iNWZg8AFr5XEpSFsLD2QJ5yWmRGS?=
 =?us-ascii?Q?tVipvYsN+vux6fXIudTa1qMD/EvLxKzoIgQqW3apCcxfdKzXhMpEpa6R+jPW?=
 =?us-ascii?Q?tmK9EvN31BaexLOnxzgwiznTctCh5EnPTA9G2vaCAAEYYzAkiKPXDfeNYDvS?=
 =?us-ascii?Q?aGrTmhN13FgGWKAJ4FswFfhE0Byxxwc1yCLGWLDDiHbDlS/nZPtW4Pp4RZRh?=
 =?us-ascii?Q?AZJQQh71p16QPNFHUuvbPUZitcXiqyi8iJZzhJ/KHlxscGYJrP7TYQf+K8F8?=
 =?us-ascii?Q?GaXqzSsjjYD22vqyUCKfVmbxLfNZFFQA6Xj1V9A9G4P6eah8DsMy5DeanGsV?=
 =?us-ascii?Q?01Bo/uES3seD7jD/LaO2Jk8g/dWRjAa3xqb/dKHIYJba48eOuGTaBbWYnqo2?=
 =?us-ascii?Q?oUEA5wPBvOLocmq/t980F9IItUZRXdsUd8AYEVJlzoK/sMo95Z+fWrkRG8zv?=
 =?us-ascii?Q?wD8PZCMPPWakpmCKus8Y41wvGfr1eGCRtIfIRCoIIE3snYzoaIJSLeTrmBLg?=
 =?us-ascii?Q?O0FQ0AVJ2F1f0NpnOMfgK+HnQLxRj3D8KeC9vzPHoHgQUg3snDjJU1rec5uA?=
 =?us-ascii?Q?ysDc5/bURVQ7OvgecrmeiOjCV2J1kxaipyqW8Ss4JLNUxfxHQQAUkxG1+IQW?=
 =?us-ascii?Q?Roq56LM+dt4oLU4HqwESNs8GLEU7hRC1VmTTS5X/X30ZBSuzY78Q1Z+tUWBX?=
 =?us-ascii?Q?ioMUlO7eTe95SDRr6NfGxzaGZFdlWNvqV8S6tBI3aSW++CY843j7Cfwb4hyb?=
 =?us-ascii?Q?+qYAipRo+etIokkL5UNaS2/PNxjyultO4n04pHezFyTkMqX5G9J43A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zmgMwKyU6kh0xcErXVZaOvepVlzNbBOemJcN05bm9Nc4K7gurSY9DrnOeYpw?=
 =?us-ascii?Q?KW5KxB6p/PlTuCPhhx7tpKxc/qNIT5OalVGLHDiUkZqXXKo0aFJObRqmYqlm?=
 =?us-ascii?Q?cBigEmpOsooYO9Nk2O1jw4A/wsGmfolZGj/jR8b3r4clytP5udc0v89esHCn?=
 =?us-ascii?Q?fBJL5cSJDTnShpKiEpdR8oFmveeK3Pur9blGvGuCe+81AE5a3xcILC6LMIM4?=
 =?us-ascii?Q?wOGt+YsQivlDBWC/JL/x/ilmSblShefiZ1rAlfd0zp2yLGPJqbEckDgLi88/?=
 =?us-ascii?Q?l2qkzT3Z80rbF+cwCyaBcWS2FCGFOJfmrQX0Yer6vfsaty7SVwkXe2QQ0hYg?=
 =?us-ascii?Q?CQKI1M/z98QcxmTscflkX7v7ALnwtaI926wofKzTDi9aohBrSnyv3O/AXjBV?=
 =?us-ascii?Q?kmTeewl/BOdV5W1H19YbHFDbm+4oHBoPVoxnEpLBUzYs6424v4i8OElnpM3c?=
 =?us-ascii?Q?GZwAfdUvuGlpaEtLW9nqXLgY/UyAUC7fZn2G5ACVnFdn4r+WM8jJ3c7bRoso?=
 =?us-ascii?Q?V5o0lNs6ZY6LkeTPCBCA+hd2HMpLXZ1K3hh6QNOr41keYrBQDA7BwiDsU8d/?=
 =?us-ascii?Q?h9dLiC/XvnnzFJXlHIh7VZJ6QWTK88WO1o20yMq124vvDLjI3/dwJxwalzdk?=
 =?us-ascii?Q?I6sMJ233CqADR5WAJBFXmLxzWvQIxT4dBIQL4Y3CyTZ0mUHP8FiJrS9FyUcM?=
 =?us-ascii?Q?qoGy7FfJ/QbW0YY1V/TgbQ/1qWWt0Nl3zShqhbtEPOBTe8+7VOx209NtYeF1?=
 =?us-ascii?Q?4DmWKlGPWsxirrpK8pnCFEI6yjUiGIbc3jm1Tz9w/dqlW74Mt7jg6jQWpeuw?=
 =?us-ascii?Q?s+kr4NcRR+792e2AxvgZ9Nlmd3BGJcX7PspD1Q4ISlJD2E0Evky0VD8bzxpE?=
 =?us-ascii?Q?KmsHArnvt7k41K2ll+QKBPWWukQY4J/OkNlXU7OZstj9mm8zizPYyXWjavyV?=
 =?us-ascii?Q?ya/VfQKpj31f8vlESGyM/BBRN27FD/Q6z9WiM+zwvc1LyCoRDTCh0Qs9BvWD?=
 =?us-ascii?Q?17urXLmYamBaov8sBXdtqftLhqgHMxuGqghJCqHaLFGMH+vlIU/PRbcqH0xf?=
 =?us-ascii?Q?zgNFPtiCfHTxAbJ/1TTKL1FRASJEaaHBIEzNajNaiq/xL2SyWV9TE8Q+tyFs?=
 =?us-ascii?Q?uz/aj+dUeY6rfxuUPmWEmo24OKBSCSS9OJnzEAH9oqvMx92SkPW39XKFZRxg?=
 =?us-ascii?Q?PuIYsAiOSebThfirEf7oJnTCUkt+65rqsaxhwE2zpeIq/JRiX0bphS3zWKhc?=
 =?us-ascii?Q?MVMGhPAj9OdD1jzW+k+XZDKGFPnnZ1LjInseYW7AEJPSjhT9PhVmbZ7x6zGL?=
 =?us-ascii?Q?HHnouTXBbrqv4FWQgHL5CCNaYJY4dfy+koGiGjvVrzKVdc+FN8Vyl/25A4mc?=
 =?us-ascii?Q?TmAT0POSr1UGkTUvylMZ4pAM+Yqs6/l0KkO+IL16Dw57g7KuovzVBtYb0GFA?=
 =?us-ascii?Q?GW8k0I0zy+Ds5rOTOpNAckW2m1nLDHBX0xZfGfnhj8dgRNq07s8jQa897I4v?=
 =?us-ascii?Q?3QeGLy49ATllkJ/niuJI3EDDriJsPEuOAZs+dyRa/tingzn6E0eBRRzLtsy7?=
 =?us-ascii?Q?HSsLJCqY0WfzNM5fp/k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b11c1e-e7f0-4a2d-d571-08ddebd17a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:38:28.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8wMyWoEOAWZDQAUIA0naT1wAnUObtZhdUNBXUV1zU62uMq6PJXm99XdG4LYN3DOjstxM9uRRW+Aqf8mp7RQmg==
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 04/13] idpf: link NAPIs to =
queues
>=20
> Add the missing linking of NAPIs to netdev queues when enabling interrupt
> vectors in order to support NAPI configuration and interfaces requiring
> get_rx_queue()->napi to be set (like XSk busy polling).
>=20
> As currently, idpf_vport_{start,stop}() is called from several flows with
> inconsistent RTNL locking, we need to synchronize them to avoid runtime
> assertions. Notably:
>=20
> * idpf_{open,stop}() -- regular NDOs, RTNL is always taken;
> * idpf_initiate_soft_reset() -- usually called under RTNL;
> * idpf_init_task -- called from the init work, needs RTNL;
> * idpf_vport_dealloc -- called without RTNL taken, needs it.
>=20
> Expand common idpf_vport_{start,stop}() to take an additional bool tellin=
g
> whether we need to manually take the RTNL lock.
>=20
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # helper
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c  | 38 +++++++++++++++------
> drivers/net/ethernet/intel/idpf/idpf_txrx.c | 17 +++++++++
>  2 files changed, 45 insertions(+), 10 deletions(-)
>=20
Tested-by: R,Ramu <ramu.r@intel.com>

