Return-Path: <bpf+bounces-37630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9F895870F
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 14:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B020B1F20C23
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476FD19046E;
	Tue, 20 Aug 2024 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5tg7/MM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A11C190064;
	Tue, 20 Aug 2024 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157226; cv=fail; b=NopdyD/8dKndnX6a6B1zwbZQcwOJxKz4ELPRyXsjV5mQOUhAvOvbR13vZc22RZHVBL2besJN83xPY60ooI75thQzfH2Ywnrg5CrYogS6IYMyav+Bsm2TQHWzrKcdObbO+bum1RljWLKEM4ifuQQtGeKCO78w3YKWitpbKwDZqBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157226; c=relaxed/simple;
	bh=CroV2LavqEiDCPgdOhSC/bQqzDveKVkiS26Dd5MJIyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AgezXwFgoyMHftzZdaeEZ/lFYkHdZF007gdqVikkj9dOlZuDvQhL7r5OMmGz0NYG0h0XmLQnJR1gyVFBGXIFBuNlmpNXRq+5ZcYVnyz+htn7bYiiNsahrXQKxtl5FgveodEVIe/Da8PYdILFVNfCntjCMW/3/WUAbTXS+LRUvTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5tg7/MM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724157225; x=1755693225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CroV2LavqEiDCPgdOhSC/bQqzDveKVkiS26Dd5MJIyE=;
  b=W5tg7/MMvJr3LrkCI5ssFQt0wLV5IvfS+weyWETwbpejVvM5HikL0RAq
   TSHFS6C0myqi5MHs0fvJGdFouMzT13Eyq71QLHMdMMxEI2YQjAUYvA0Uk
   pNj4chhQcNKGxJ6bYEoSvCSV8iid2OLmYDY4jMGK+8svIQrl3tMPwL9nE
   zsSsZPIdZRoBhhAttnLQgbLt+zl+wC+rrvMdRCCvmQDxRnHbLgo5D8F9F
   oPO9YMbC5d0Yb6u7k6kLcNw6l9YSYg7lswLZifGhC9EOVMikbk3XFhzet
   jiiVKwg47YaSqHny172Fiyb67SqSR7veWVUBOeqwEawzSZJMOdQjuFLCP
   Q==;
X-CSE-ConnectionGUID: L/qayYjzQOWgRUlLJouQMQ==
X-CSE-MsgGUID: CzgtdTx2ToeneWkk1bA+Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33840444"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33840444"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 05:33:44 -0700
X-CSE-ConnectionGUID: 4c5BajykTZiQ0yJnYATOXw==
X-CSE-MsgGUID: PkoRUN5fT0OP7/QnhIjT9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60770500"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 05:33:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 05:33:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 05:33:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 05:33:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 05:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+MGrZghJ2Y9R2mBzlCDiinIoGwVR02sNEbsfcPKw7K44jESwiGk7qdsW4vM8nrIv1u7dqmYLQnw7m7cPnpCiq8RFZQY86sEW1cmoYInzCU5HNYNPdPHESBCM2sKrtPasISOHgThT1XwaOuNubJr7ofmPWJ26SGgRf0faPPK2miosv9lXZpLJFTU8/wr8DGwlUfMERPCE+cJWKNwCOCxbWLTdp7wg2GQ17J44P70usRYbhrpcWxBiCyZ5GIIZIVjeVKBnvvSdcGs4qLuWtBD6kj2NttAf5mdG++FiRNm7U5rBrYxadBkvNkifRQsLZv3o7ACaSQwrfwvtq9o054aXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CroV2LavqEiDCPgdOhSC/bQqzDveKVkiS26Dd5MJIyE=;
 b=Ta/HqID0P1jl1YwoLcNTyn4ZhwfZF8hcmIw72ccQN8dfKXt0dcwQ8EZYUBT/z6Z0OHw5E/6Ea9yhBApk20YCFlleLmYcgE2lrWGxFdjeAKP+KQtB9F33APFSoWPuzo51jLsiStDibTJDTVzokRnov6fderROmA2+2slk0sG+2Qxq4ksiZKW/9mrHfNYcLJE9Z6OIjcVCc6pT/2o02MNa46fGOOTqNWAwgjddd5aYRvgS3S4T43sNeF/4a4YsQMUZ4CYMmxxVLVXr25wc21oRWUNg02bRieEj/gcOY5EW19azCfu8zx70mG8n79dXCHrbxcEBhtJqU77CGOGJN6ZWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 20 Aug
 2024 12:33:40 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 12:33:39 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Georg
 Kunz" <georg.kunz@ericsson.com>
Subject: RE: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
 helpers
Thread-Topic: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
 helpers
Thread-Index: AQHa774yuHk6dVxMp0yVid1EycfUSrIulX6AgAAF9wCAAAhJgIAAWk4AgAEaOACAAAJc4A==
Date: Tue, 20 Aug 2024 12:33:39 +0000
Message-ID: <DM4PR11MB611732376D8E671D7C513633828D2@DM4PR11MB6117.namprd11.prod.outlook.com>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-4-4bfb68773b18@linutronix.de>
 <ZsNGf66OjbqQSTid@boxer> <87r0ak8wan.fsf@kurt.kurt.home>
 <ZsNSc9moGwySgpcU@boxer>
 <AS4PR07MB84123D29A27BEB30CECC5FAA908C2@AS4PR07MB8412.eurprd07.prod.outlook.com>
 <87frqzidql.fsf@kurt.kurt.home>
In-Reply-To: <87frqzidql.fsf@kurt.kurt.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6117:EE_|IA1PR11MB6194:EE_
x-ms-office365-filtering-correlation-id: 014eda4f-da6d-49b6-65db-08dcc1145201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DNjgZkFd4SRDGNLZIHOQM84suTH2xVZmTXD124vNkTk4gwNlyKe6kbRlb7GX?=
 =?us-ascii?Q?G1Oy2O3EipVFzqQfYyJ6WDixo4Lh2+lNhh/lHsErjHAGg5q7/eCrUms309cl?=
 =?us-ascii?Q?9dNzje4D5/k7eU1erLVyylvMPAZyn2wH/PSNYt6M033e1h97VNmaHbtFEbOA?=
 =?us-ascii?Q?4dNrk2EtzaYnR3F7ELD4Yl/FwECsAHAGSPpM8vL4CTIpjxw/jrbnajI8Es3/?=
 =?us-ascii?Q?dnVtlAaPDcHVgLfx/+zr6Rzmy29BXA53dhPGt7tn5rNL/TUSLdUiAc9PdlFA?=
 =?us-ascii?Q?SuPgEWLvYl6HEgdTj25sWDQSk/6QmORvlm/J5wzJNTgQXaLbYhg2XhIwOVkM?=
 =?us-ascii?Q?XzOR5dJQ1uRiGjh/f+r8kmHVsQI+2j71VVaWXOIqTu4QDIB0pj5sz91Dk4sK?=
 =?us-ascii?Q?044xv1DqUa0TFEiurjAWLfqhj72z0kKHthwOpj8oessMIDqC9+AVg0X0e0qc?=
 =?us-ascii?Q?op+CSW8M7ZU8QG58WIO4a4zHfyPWHotTD+G1Tr6aFSEdBkC0B4qqpGLEP9QQ?=
 =?us-ascii?Q?/Ww5yH7PijHm83zJwo59rbfb1OPaM1vf2wAeEnijuoSwEmOLEPYNs3TTnxJ9?=
 =?us-ascii?Q?NOqzk0iPrQLUUpzNEweTQl2VWCpie0lA7Gzb8Z71ApLNs6ec7ARLkruorVhM?=
 =?us-ascii?Q?YDZOpMVwn03zMdIEbYO7EQjpwWUtdUfXXp66FLFWlAmR0s9Z4S4sPW/slPqq?=
 =?us-ascii?Q?fLtYcTh+Za9qpr6q64gJlWcaPKPWdji3zAnzG9QzBC3XThk6uvBkExinJ3V+?=
 =?us-ascii?Q?0Uo/JYFOdv5kbJQ3Il88afcwZgEe1njlZu2H3Zw8gEI8ixhRG8YfkddfN0V+?=
 =?us-ascii?Q?z/IHbnrpNyoGcGTGLpGlIpXYvWqliWxU8hXFaDIXdg6lQnPMsF4qbvpjkta+?=
 =?us-ascii?Q?Qk3hnUcFMzpnU5/yP1dRle+3k7KKb3L+hJLJJK1nm0z0EdM5sdzMDhYYAAPz?=
 =?us-ascii?Q?EBuguGkMg3GQQTwznKGeMPnuVTly6h/2Y2R5CXV9zqWjmxitLr2nho9bGwBU?=
 =?us-ascii?Q?LrEZpchcTaLiIcfhw8HuK1oriqMCUWFZsAQeor4KWqJqAlnUEhA3F520JkzF?=
 =?us-ascii?Q?nNd6JQQIYju1wolKYKx4QSWSvU6IF8MYrtQ67OLgqD1oG3sK2hbQcDfvf+XS?=
 =?us-ascii?Q?DsCyogtIRgty1nJ5BLtlQRNl8sJiLD9M8sn1Fr0RA7iYcPY+oJJl4uJ7xZdp?=
 =?us-ascii?Q?4GPu0PHhgVDrRcDKtaLSxH0HQ37afk7/KCe37Gv2v8SQFK4R+d4rUXlo+DiN?=
 =?us-ascii?Q?8hz6DCqyh2ll2LKFLew4xd2ryHAk3z8aTY7/rzwFaWkohWIyTfetdJkQ4dVZ?=
 =?us-ascii?Q?ZTtsRtqeGnZQRkOPkujwZEQLwIwixoHCl+ok98AoYK0LIkfcn1lD4f7Er/PZ?=
 =?us-ascii?Q?pkUqiLD7xam2aJnnb0SSQ1FYYWs9Vm2Ost0+n8t6daoVP+p1lA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?koEb2x+QB+mdQpon3vN/HGB9RWVpb9w8Mb734MJjkfOVhERe2SPdOlGbpPtt?=
 =?us-ascii?Q?LEM6vkwVt+aCfRQxowY8tvaM0Nsa/R9dWzazNAr0GdMd9rhM8uXEJ3ZTo5yP?=
 =?us-ascii?Q?o9E2xrmgjI8aWlSi6U3ilaeZ532WEz8l2V0cX6nH73CQ9v1W9jYF+FKqbheL?=
 =?us-ascii?Q?X+eDfYpL9uq4M6PZ3dN3aPjrmHXN/NIP4YFoQR4BX6STgIcWRK023aUg2LVN?=
 =?us-ascii?Q?oeEICr/elYGF6rAnYnQQUnSJ2efo4E1QAdf6Vo+tSwciG4KqqGQhs9Sr9f24?=
 =?us-ascii?Q?nk6dmu/Dhfj99iUoEiTYGRVyLCfx0n4O0W00mGd5CwYuO4HljXoyK/C6sHTD?=
 =?us-ascii?Q?C4H4yEph/COmXMHxLmBI9klLNvD63Sij+If+BCHqPfmQs10JoyJmIS65pAOV?=
 =?us-ascii?Q?E6ho1EbDatjkl2KMBYpW6CRTxu/jb0yDduUFWO9033lgD4vFFFFFugL8ZWVJ?=
 =?us-ascii?Q?qCkzceCp926TmMk1CHbIY72Q8kKeQO841EhGgmpPBmnT6DZGjUvW8G9d5RjM?=
 =?us-ascii?Q?OgVRMFadiVrTfjhIQTJKG1tbXkAKsm3VI7KupEMRLU3Jm18BHxOwvHPAyjqC?=
 =?us-ascii?Q?34NXkHNdj/WvNdu1+t0Umaa/qfEvfM/YnlSZURQgnbwkgPnTVLRp8DfvWzzf?=
 =?us-ascii?Q?Co4gPmuEDtAFXUYQN4lwfdheTYNsvaO5WV4snGRfS0h5jQ4srbsL3I4IZHb2?=
 =?us-ascii?Q?Oxs7Omnu/ZtopjPrjnvBDM6vGYelXLxTDVxuqavn7lzl6kBQ7jPeKnStI8p/?=
 =?us-ascii?Q?UwawH4+exLfeiXvmUq/Q9WHsHVg78xoFw2cyZ1UlFl53IkVRFwnlOtQEeW6T?=
 =?us-ascii?Q?fK0z4NjznOYWmzezFkHLc6YuxIQ69jBRsvMZfbdw1CW1gseg92MlKJq3V3Hz?=
 =?us-ascii?Q?6bL0kDZfBMYo+fAx3N4cdEZiw3tLbIa1/ks3JTzd7spDuapHNijcEnQQVHZ8?=
 =?us-ascii?Q?9xGlUXeml2ciHwxuR+qpdVmuereUn7c+tD10lM9j/qPqNpl5UBE44o+Zqv2R?=
 =?us-ascii?Q?4ZP9GMNZKAr2mEPDommv92Fad4v42kxfqK4F/8+X81/L5FQDD1JDhmseZFLf?=
 =?us-ascii?Q?rK9viFGUy6UJgscbJsUfjaK1EWtXBHUVNO4breav1Uv81T2U3KOd9Qiy7rWz?=
 =?us-ascii?Q?EW7xLhCreUSDH6h8yy2owsg+kK0AXIm/ygv0pusR9bKn+aV8A52BDMKYwLKP?=
 =?us-ascii?Q?DuBVR4qCzsUe905MEZlkLXLcPimc5TMJlvWCL7QiRBzVsf+ly2pSVraE/sLw?=
 =?us-ascii?Q?YxsyGXp+EQWL39bt/wkVstFtmYP131PE8l8Mmp/6h+9W6bBD7vzQ0Kw1qT2s?=
 =?us-ascii?Q?N6duw05BoklbrqAPooui2w6GcjZgFoKSkvpkfzCFj/iZc8AeaTHEqFgNSCrc?=
 =?us-ascii?Q?TMJ+SATP3RdrsCm3UrBJPegPMtW+H1Vb6CrWow2EqSU3QkAiu0RkYm7yQPF4?=
 =?us-ascii?Q?7m9+7jMeCpzletrL9lY6c65RRQxTOyTC40h6VWk7SdF9lNNwglWXbwcwKzx4?=
 =?us-ascii?Q?Hce5tSVRv7C7Y7DLYQGfWCWeKOwoyhQNZDL3+zVC30tJxFcZLuepgTNf8LR3?=
 =?us-ascii?Q?hzl5mWi21F1NwQf1dYq86jzC9VIEA6SGUzlrVBUp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014eda4f-da6d-49b6-65db-08dcc1145201
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 12:33:39.8896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkRd/ibzb+ICRG6gwsagTBRE6WdrxNtxNbjA3o3Y/+qK21M34A9OQObprCdhDNVkpVvnGvB6Rgz5i6n+DLIqZL1Q49xpX6tn399iC5eca8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com

> Hi Sriram,
>=20
> On Mon Aug 19 2024, Sriram Yagnaraman wrote:
> >> -----Original Message-----
> >> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >> Sent: Monday, 19 August 2024 16:11
> >> To: Kurt Kanzenbach <kurt@linutronix.de>
> >> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>; Przemek Kitszel
> >> <przemyslaw.kitszel@intel.com>; David S. Miller <davem@davemloft.net>;
> >> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> >> Paolo Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>;
> >> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> >> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Richard
> >> Cochran <richardcochran@gmail.com>; Sriram Yagnaraman
> >> <sriram.yagnaraman@ericsson.com>; Benjamin Steinke
> >> <benjamin.steinke@woks-audio.com>; Sebastian Andrzej Siewior
> >> <bigeasy@linutronix.de>; intel-wired-lan@lists.osuosl.org;
> >> netdev@vger.kernel.org; bpf@vger.kernel.org; Sriram Yagnaraman
> >> <sriram.yagnaraman@est.tech>
> >> Subject: Re: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structure=
s and
> >> helpers
> >>
> >> On Mon, Aug 19, 2024 at 03:41:20PM +0200, Kurt Kanzenbach wrote:
> >> > On Mon Aug 19 2024, Maciej Fijalkowski wrote:
> >> > > On Fri, Aug 16, 2024 at 11:24:03AM +0200, Kurt Kanzenbach wrote:
> >> > >> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> >> > >>
> >> > >> Add the following ring flag:
> >> > >> - IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)
> >> > >>
> >> > >> Add a xdp_buff array for use with XSK receive batch API, and a
> >> > >> pointer to xsk_pool in igb_adapter.
> >> > >>
> >> > >> Add enable/disable functions for TX and RX rings.
> >> > >> Add enable/disable functions for XSK pool.
> >> > >> Add xsk wakeup function.
> >> > >>
> >> > >> None of the above functionality will be active until
> >> > >> NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev-
> >> >xdp_features.
> >> > >>
> >> > >> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> >> > >
> >> > > Sriram's mail bounces unfortunately, is it possible to grab his
> >> > > current address?
> >> >
> >> > His current email address is in the Cc list. However, i wasn't sure =
if
> >> > it's okay to update the From and SoB of these patches?
> >>
> >> Okay. Then I believe Sriram should provide a mailmap entry to map his =
old
> >> mail to a new one.
> >
> > Please feel free to remove my "est.tech" address from From: and
> > Signed-of-By:
>=20
> Ok, I'll replace your est.tech email address with your ericsson one in
> all patches. Or do you have a personal address (like gmail), which you
> prefer?

Personal mail is probably best choice.

>=20
> What about the copyright in igb_xsk.c? Does it belong to you, or Intel
> or to your previous employer?
>=20
> > I am just glad that my work has not gone to waste. Thank you for that.
>=20
> You're welcome.
>=20
> > I will check with my company's *lawyers* to see if I can provide a
> > mailmap to my current address :(
>=20
> Good luck with that :-).
>=20
> Thanks,
> Kurt

