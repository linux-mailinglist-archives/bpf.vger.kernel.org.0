Return-Path: <bpf+bounces-36661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889B94B4F9
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 04:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F431F21838
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 02:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF2341E22;
	Thu,  8 Aug 2024 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC2TdiWp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A46BE5D;
	Thu,  8 Aug 2024 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083459; cv=fail; b=OgaRzL048MlK85Z+HgIFK4iZoPhARXDtnwPl8yQTrLGplTGjnzmQ+RKQLSXoOn/5d+wIDruNbzkFSys+/7FyA7jnLMtGMH/aMR1OAzKmIPnvmT5sDfyIHaVv072BEhU8Dtxuj+kxdKX41hMMdy5Ce2fM6wmXxA3lN+0AQuaePWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083459; c=relaxed/simple;
	bh=D1+sJ2pvxRe11njFYxhoTQIamSKUBIBb/VwXxytfFRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yq7p4uzACXrhh4KDP1cvohyCT5SPs/4AU8lZ/r1tOhX8NjihmaDYKTSFLe05takMetfzU9YMLxYxkC1hQHTz4uWeKed0ksSrUrhuqSoGbwyMer8OlI2elN2VD/5dJRnDjxMdT2amMeiRGFWAvzwn9lAA9hr6Y09Fh9xEJwWclCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC2TdiWp; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723083458; x=1754619458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D1+sJ2pvxRe11njFYxhoTQIamSKUBIBb/VwXxytfFRg=;
  b=iC2TdiWpMdFr4Hx8opnN592NdxmOCmkHYbtsmMwKHhxrKP8Pjga/25TV
   KLd7tLnPQlN2gM35B1zQlH6IDpyxXribj/M7YH2Sr+h9aWz1KY6cd16oZ
   EC1RAre9HtsLwN2CqM4a+WlPvkLjrSaXRRqCDxnj99WKnjMS/jJuT9ROD
   VfNVIbl3F7kRwXVS/YCSMq9YnOAYPlAcv56rLenZ4oUii6AxQotmeBXl0
   GRzjhtqsC8ekoL08cB6kKHbrW59C1a5hbW6/zXU3rOstHzjRQXCt0MjXC
   ICqjdqW4QVmBQdOnrlK/LRt5Pj6aDonHNbAxETpwS69OxcL31Usq0vi/I
   w==;
X-CSE-ConnectionGUID: Kjx+e8z/SJmcbfK78WYVSA==
X-CSE-MsgGUID: fKAFW/ITRjqt033n5SNUdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38645548"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="38645548"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 19:17:37 -0700
X-CSE-ConnectionGUID: 7co/DJuwSq2G1HJ5WPRXrQ==
X-CSE-MsgGUID: 3M7kTuy0R1q1Q9nfShdn+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61469055"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 19:17:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 19:17:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 19:17:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 19:17:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 19:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amR4zmBW67OFPHoVyuUDRW+hMhdGxNVBnUxtU5vYpwk4fYQjxavTYdyLIjywSStJ/qDQZXStIQ1DOFb1vk+rc+dkUhTiQciOFrgzFizhGk3RMOH6zrm3hbmM2ed+uAoEQ6qwR50Wd6fUS4+L/hoab8ZjnNQ5aG4i/rHvfqNSLI/aOJaCfHAURN33MkTNTt32oY/jeJM+6QF9mb7EcnNlhiL/4enYqkKycK8yTUCdL/P70zoxUfpYkkQ2iJ5aLnAaPv+cCrizDchmK0Nyby9Qfen7pT0r1YW+MBHD+JU5/jCE+r9/eksLt230U8u3Q9HHkeNJ4ZQ1A6sNpT2/KwM8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1+sJ2pvxRe11njFYxhoTQIamSKUBIBb/VwXxytfFRg=;
 b=ViPkDjI5wbe3FSAdLOf/H5wMYRTCK9BUx26s2Xi43QbXnBIK+DcGWh4PcxrqlvTj7vfyIOj8uTnT1aBuNaod1jlJWd2gnFw52rf6oPvAKwbII93WzTS4XeA1JpEG22CtPra3Ok5kS4BofTaWA7dErI42QTEmMBbyna7HcwGCrsoxL7J8cXJG9ZOhGDR1mrvWs08UhUwAU+uksB5Ia1iJX/B4pDgbmbU8hMjeVI33Ky9aAVdLeMz2iW6y7kw/ZgB9GCucFe8zaXHKFrJmKi0+qYhndhnah8OvE1I4IbaPLZ4AkDhLZc27WkuZcLytcDc8pqD4ff2lHkDASYdir6/yxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 02:17:33 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%5]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 02:17:33 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Kubiak,
 Michal" <michal.kubiak@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Nambiar, Amritha" <amritha.nambiar@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>,
	"Nagraj, Shravan" <shravan.nagraj@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 5/6] ice: remove ICE_CFG_BUSY
 locking from AF_XDP code
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 5/6] ice: remove
 ICE_CFG_BUSY locking from AF_XDP code
Thread-Index: AQHa3erd4XBjYsBqWkmK+Vg7s4CeOLIctjiQ
Date: Thu, 8 Aug 2024 02:17:33 +0000
Message-ID: <CH3PR11MB8313BD787514A71C6A2E39D1EAB92@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-6-larysa.zaremba@intel.com>
In-Reply-To: <20240724164840.2536605-6-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|SA0PR11MB4621:EE_
x-ms-office365-filtering-correlation-id: 58772a4b-5a5e-44ce-26b7-08dcb7504353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?N2+zGEpQKrLNLkUPgigMxotLTv3uPflp+F14rhKmxEETPIZmn6t53MXaTKqE?=
 =?us-ascii?Q?VClM6mx5qc/y2U0xFQgNCkxhoN2SDcagYazF21Cyj90/aaazAOVborQNALOX?=
 =?us-ascii?Q?O45Mfpqc8nG3Zu+xLU9D8FecFNPWl/eDnIdwLltcvmuELOuKdPyG5/K6icMx?=
 =?us-ascii?Q?qRJgNParpsEbCJJvWxxgUcKv1dNv+2dnmS6HnY5O38ielF2KQ1xuTX63vgB1?=
 =?us-ascii?Q?gvnpOsW5DdEHDT6hsBvC1dTn0Bk9RYOUodCsDW8+Eh8X4H4Zws3XopDYjYPA?=
 =?us-ascii?Q?R7PEv8u3AD0lSsv0mdODYca4MZdDAHB9AB30kbswrk6U/yGCWX2vwhfERhbX?=
 =?us-ascii?Q?B5Gi18P5aSJYWxoSYiX1pfkzelQ2sA2jZJ2d0LR6aFbS6Q+H/LdyxgZafgT+?=
 =?us-ascii?Q?jR0twti1Sd4pGjk90scMxEZNOR4ddEKPGAy7LdbWjx0u2e5NCPGQsIquiA/C?=
 =?us-ascii?Q?/uhd56rlWrXVEXZchxkCVwyzTIprkhmWr8tShKK+GreigihioY/ZvbQtGFVf?=
 =?us-ascii?Q?ypyaJrBmD8Z3gsKdw8A9faQFEVKKPjUuPHMpMYde3jloUFE+QGEGbFw+Np4B?=
 =?us-ascii?Q?lpnFR+LsgcdR8k/q/KOSxnZCf7WIedQgaHV7qXYdR8ds2eu8rCq8VCQVlOyr?=
 =?us-ascii?Q?t80s1mwEUIAbZARdEmJzohLorfUaYGZbkdbi807g7txmsq1brU3m2KFwiQ4Z?=
 =?us-ascii?Q?5wXRfhKj865BEkfz8nQGZnANHXFXZlF4Jxfi59cQjWVXBVc06wTs+vX4oUKa?=
 =?us-ascii?Q?IizzJb7watucloDk6XRHzPdScdFQ0vwHavoTFQhhedjxwB0P+55uSgLukurJ?=
 =?us-ascii?Q?w52Ib0hG6eV6O2GBPk3TifgmlX1psG8p5e/ORE8TikhF275aVS3vmN0sKhGm?=
 =?us-ascii?Q?AqUHl62tT42ViqCRsLbAmFgJDuy+S/yV7PEmlkhZA4VWIJou45y/f16NyWZx?=
 =?us-ascii?Q?KHN3vBgWysmf8VyHyT3OYk9B4dwm09tycgIECX2srUp6wibx9RUub3sB2L6K?=
 =?us-ascii?Q?B/AF3GkDz1F60k8A7/UzAf7o7wf8cUTqv3+0mcYg0ozF2snAuKkMBAPbpD3k?=
 =?us-ascii?Q?XCbBKBFIO4ZhhSUcVg7EUejPBysZk3ss+agc5lFTRb5nsLQxbrR8CXkbKHsy?=
 =?us-ascii?Q?Jcw4bFWxXY6eqUsHsLigiZYyL85lzIBPKqqbK0bIN7BpLc+DYh0HU2j1QmZb?=
 =?us-ascii?Q?T7iQEdPhFNJzCoatAROXvT/1SvbOD9PmqBlYVFLwa5F03tPDBNamrH6JZpmN?=
 =?us-ascii?Q?2LdXBIiKpvZ79kuugKqDWiwd6DSUExliZkvjzshfPkI7i+ldbkb/LO++vXuD?=
 =?us-ascii?Q?mLKianrTvygvvYUTjQyx4pe0MSA+6HBJWfGMV/VBueVrJMlweRDD8P8F2hYf?=
 =?us-ascii?Q?zQWx4GleqxTSFK6l1IO6Yo8+SpbV/QVf/h0Teut7ArZt4KG2pw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z6Gof9gaBcn7Nace9vIR5gf1sc5rUeSJJzSBU2PiJ+eP6HKdS3DcUHssW6M9?=
 =?us-ascii?Q?HW904FTv9+WfKapee4gvCiFZici82T0TxiGLg/8xiOFW9woFdNxgPxCXdCMo?=
 =?us-ascii?Q?MtJFLEwXdw64FZ9IgRmDBmXBcxFtApo4nx2TDbYrSprWdwRu91CgJc+3jNMv?=
 =?us-ascii?Q?LKNq0HLJLNsdY/b9UF7K9465/XtctNckND5YwIuaPK7/B9l/GhHaJpbvaNhk?=
 =?us-ascii?Q?qM4okRYAvkODdVx5YF/3NLyYIFRYzsfDoH7yx+TYKvHKrpjOTQ2YgoPTEFPH?=
 =?us-ascii?Q?TPiQ0WOI7Etwe71m++ChnErbTVj4SXlvz3foAxq/EpM8NviGq3WHS/IOAGdq?=
 =?us-ascii?Q?MTGtn3buxUhNglGTtBj5zYsLAHD6MAyJoJWs8IOARn1tQD9IanWZltvyKwqp?=
 =?us-ascii?Q?SL+hphEfCbAtFBohnm2Pm+wzd8R3ddqGcHFaiVlUvZjiM+ZeYSdQ9LWmcyQy?=
 =?us-ascii?Q?oWAbbcv7EYUIcRPhcAb4nUxm5H1JHD0nD+RrFBee6wwspo2e4gOzjCAm7Fdo?=
 =?us-ascii?Q?WXrQlQvZeqtJfohT5cy1EfPMc9eoMxQ3xyvoXltH0kgJ+a8dpstlhKEn5tHR?=
 =?us-ascii?Q?cl3NnzjR04Ake/FhjiGdpB1CPLwUjSithe31z75Pwg9bdyKciKlpdDjZPgyc?=
 =?us-ascii?Q?6PRIoVT0hyPrb7Sd6a3N6ruMVeBvbCiyHIjxCXz5nKcSALYRdgpe9HDt9MQv?=
 =?us-ascii?Q?QLYB0liEXWPrr0RpciMaKH1W0YcwmBoZ4FeoKz5F/lD2nKR03dBSUED1vWpJ?=
 =?us-ascii?Q?/dnCS52M0h3MpZiN8ZOyOh3Do9Q8Om5Q1GMe2MQj2M7/3I/wA/zRiImd/RZE?=
 =?us-ascii?Q?e7S1rURiQyE66vus7sSLt4Jo8UQM9c4i3CxQGYnGi8rugs1VH77O95YlRywg?=
 =?us-ascii?Q?g0MvZDF7TRIoi+aYEbC92W39E9dMTnGpH01GPghDUH9nktKhhwsUlHz21kck?=
 =?us-ascii?Q?28UXacDiOgzUSmi1nRUqKOY74rSYepPWCUxCkXWKT5GVcMdwPXUvxJDMbkdM?=
 =?us-ascii?Q?xsJJ2hJwzu+0N/ws3NARM810W0ogfBo++XWdE2wKtTO/K1GEsf0ql6Q3K2Ba?=
 =?us-ascii?Q?7II4NKiiEYCK/07bHKvm1aSq1L6QjOVQYCuNDeroG8gECk2QJVE4aHA6orW5?=
 =?us-ascii?Q?l8TjoNAVEQ4PC5bJtk8DrbEMQ/EYKqXtADDqejVXMETNQIhYVmgLkIIrAlZI?=
 =?us-ascii?Q?AmgJur/DWeWkfv/ai0ipTYU0G+VorOQFrFbNV7ZBighZ2qiK7QkV8ln4EL+g?=
 =?us-ascii?Q?bOcC5Qz18b+M5e0ErboKhb4yWUnEw0tdcHAYRs/uvZHvtB4tY9/Iuw/1vhdi?=
 =?us-ascii?Q?tzdEeg75y8g21DUtNfnfEt5wnDhmWzdZWNrXTmCNrMqsgyOgEKlgP6q9nYT9?=
 =?us-ascii?Q?c+WebdtFQ4vaCZy8eecsmt7KyQpHGNDALbwpmWhx26Fdk7nUSUj+oQaBUhsV?=
 =?us-ascii?Q?GuumBvkamIgiEkT7qmfFBL4NLVZqq0oKC0iHcTfP5pwR4n2E54SFzEQLRp7C?=
 =?us-ascii?Q?ARPmCc82aTSJupg2vdy4AwULweUK2meOiAkC0RV+SrtE+Qzvb2/qa2V7UBKh?=
 =?us-ascii?Q?VCdFDofRCBnow6xyUUodsXQPTzeMXRqQc0/M0S/v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58772a4b-5a5e-44ce-26b7-08dcb7504353
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:17:33.3965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MpOtYmRKa0UtmIpxiK8Fu8RFNyb7SL1r9Bq4gU7xp12ciKQTDRn9pecZmu98I83ClpJK1WrABJQMj72HjBRuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Zaremba, Larysa
>Sent: Wednesday, July 24, 2024 10:19 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Fijalkowski, Maciej
><maciej.fijalkowski@intel.com>; Jesper Dangaard Brouer <hawk@kernel.org>;
>Daniel Borkmann <daniel@iogearbox.net>; Zaremba, Larysa
><larysa.zaremba@intel.com>; netdev@vger.kernel.org; John Fastabend
><john.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; linux-
>kernel@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Kubiak,
>Michal <michal.kubiak@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Nambiar, Amritha
><amritha.nambiar@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
>Jakub Kicinski <kuba@kernel.org>; bpf@vger.kernel.org; Paolo Abeni
><pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; Karlsson,
>Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH iwl-net v2 5/6] ice: remove ICE_CFG_BUSY
>locking from AF_XDP code
>
>Locking used in ice_qp_ena() and ice_qp_dis() does pretty much nothing,
>because ICE_CFG_BUSY is a state flag that is supposed to be set in a PF st=
ate,
>not VSI one. Therefore it does not protect the queue pair from e.g. reset.
>
>Despite being useless, it still can deadlock the unfortunate functions tha=
t have
>fell into the same ICE_CFG_BUSY-VSI trap. This happens if ice_qp_ena retur=
ns
>an error.
>
>Remove ICE_CFG_BUSY locking from ice_qp_dis() and ice_qp_ena().
>
>Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ---------
> 1 file changed, 9 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


