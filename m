Return-Path: <bpf+bounces-30892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C6D8D44FE
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508511C20B3E
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 05:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A3142E93;
	Thu, 30 May 2024 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoJqyron"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF33A142E85;
	Thu, 30 May 2024 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048427; cv=fail; b=BJicHpUlzdlrlZAyDCBr5P10Ck3DRevItS2cGDJmcarlcpTUWEPKHgdGtkS2Jj2cSYxXs7fxIRAXWUAT9aEDsk+3PyJyID5LcMCOxXJG3K3T8NmCUc+r6CHNm6dFGEAPyv1eKd4F/BHAE7sBl358Pp8XtaBKXjkjcVg/G2RcDq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048427; c=relaxed/simple;
	bh=1bW0rpKMfElgXI+boKz9MmcaOyTkbzfuaM1z5e7Jylg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m4bDNdUFbRstB2lDDWP3xfDYz8PcBJlXjJxOEFxEZwpckYycc2nSgFd994M8gjJjGOX7tckL88OB468cmtdoPRHFaswXJnmUjqtFlidseGtc+Y5lkguez1rAeblMq/fURkTibvoIyHdHYlodepkdxMLYiRqS2mkiBgxSK3wQiP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoJqyron; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717048426; x=1748584426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1bW0rpKMfElgXI+boKz9MmcaOyTkbzfuaM1z5e7Jylg=;
  b=YoJqyronwMOULAN6dQDCl6dAFaKne0mrPRP1/enRU7zlOX4uwXPjID3S
   fDk2rbcqvF0R/VvnOJBTUTwN0TxmMNYpY567Jf3z3GVLz5sLlsfOm/WpB
   aP7KipFdrPoZV0riMpv0co0BEjXnJnRM2v7wL2IJtH8SGcIxJjPPm1l7z
   /z+SrCIesi2E2T3y0arp03sc6YRqc9A1wbbqD7n0jFHCyZGCCLaHT06db
   X9LSGYqOyGoN3QMJJhtgns3u+cYgprABgIrTWuWSYYoyadVrFrf6J/mCh
   RiRsPdIwn1Crti2S28hvCVCpYTVXLtq2TlL4/YrqD0YLQw1i4GTtEvkfM
   w==;
X-CSE-ConnectionGUID: CIX54dQhQ+qSZSK99moN0A==
X-CSE-MsgGUID: WGKjpDLJTp+oOl37p6JYng==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13351600"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13351600"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 22:53:45 -0700
X-CSE-ConnectionGUID: d5Lc/lPmSD+eHObPkG8zKg==
X-CSE-MsgGUID: /K5DR/FJQgCxZw2bC5TDig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35757764"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 22:53:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 22:53:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 22:53:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 22:53:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx+JV+3aZ81bjNUBwr5riDj5fw938gD2LdnNloQO+/0HJFiuN7QRotyti3EwYVKeqM7/XlmFQZjmgGj/3eub0d5I9M7eTzCjZ+IwkRrjG99ZSS8CGWgStQT+eR6cURTukcuAoOnra9bYHn5lv3wbo6B99uttsXKAcGfYtQCsSdht/gNZVPHCkQ0IS5DXm5AI4EspetOcqKV06zDKE1g27vRtRWuYqbNplKVAN1hxAKIr/RF+G8KJvqPal7Zd9ssrVxzejEaO3ebwAkr+6Jm7EaZCpfiQJQMOc4ssUdm86DlIJJPgOncweTjg8JYJo+qhzW+6DMqEZkf7PKmzgyeTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/JBRmre2ffTUkn2hOVW2kQjVREOqdGtxSWD3m2eZJw=;
 b=atnAHXhU9aiG53CEQSVkDsAk2UK08Uk9NY/yzVDttpwiundVOIZW1eDDGUGKn9Qpxp6CQ1/W2sRzeGHoQe+uehWB2i7gNy7zeJCh7ydL/FmvSXg+4px36DCGAzyO31ChIO4qiVKxEU4PlPwEUh/RA9Au4pBW+rrCYHRJbBt5abv91RD08HoZzxMQrQxCeimo5z4Zqk9zej12kjt/l328v6209heWHi6u3mT6/EP/Fn1sVBRb2VCDXWnE5//4LjxUgtHT8RS/N1dVf0ZWh1sfE4p+/OKciQajt2S79oGWZiGP/pl5wIYjryRelWzwLvETOLCmo2vWCds0Fk/GGouIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 05:53:42 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 05:53:42 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, John Fastabend
	<john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, "Bagnucki,
 Igor" <igor.bagnucki@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 1/3] ice: remove af_xdp_zc_qps
 bitmap
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/3] ice: remove af_xdp_zc_qps
 bitmap
Thread-Index: AQHapuJRbS/eNf6gdUKKM3kTrFGqCrGvXNrg
Date: Thu, 30 May 2024 05:53:42 +0000
Message-ID: <CH3PR11MB83134F4EC024CDB544040707EAF32@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
 <20240515160246.5181-2-larysa.zaremba@intel.com>
In-Reply-To: <20240515160246.5181-2-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|CH3PR11MB7204:EE_
x-ms-office365-filtering-correlation-id: 368c4fbd-290c-4f80-97e5-08dc806cdc76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?EoKuy26r77tkDRkBJHWukZ4M0Avs8YURv5oxMOhrmhiRTfClwKe1YEcx2KI0?=
 =?us-ascii?Q?RI1NZh40S98zSShwmli7iI7sEAUceGa5Xf49Hw/Kl/eLMqohZ7aChQFTqjp3?=
 =?us-ascii?Q?1IkzmIIYQAbWZaxes0Hf/N9Y2AUcoBgQu7zN5j0lm58TKUf7bnV4QinCk5iK?=
 =?us-ascii?Q?l9ycKeOTF9jgX5YyF/CNosgDHxES8uKksSIn4RRTQ1yD7qtNJnpwLwmuJw4a?=
 =?us-ascii?Q?G3Gnled+PfhzXB70l7f7FepGAn5Ugw/Q2n0jX2cwKNyPJESNpR4imxSYm6ef?=
 =?us-ascii?Q?b9wNXj/+SIguBOWMtxeppkrtoJ+sP6I3pMZEyM5f3Y73WqHkWR2p+KvVF9Ji?=
 =?us-ascii?Q?XoB9miXn85HdWkyi88qL76tevskprJ1HOFNlYIwkpXZYGhpmm2Jom8h1qlMt?=
 =?us-ascii?Q?lyGsZ9t1Ejvxs00459o04vFHSy2yoZ3IiCbagNDVcqOIxPl7bfeiRKNtOEzb?=
 =?us-ascii?Q?3w3/y6dGIyRql/8jabCSemsDHkMIS/5/VHBouTbuhs9gESZLp8rM/buFzK/j?=
 =?us-ascii?Q?ammIbp6dLesUAP4QDBxzzLuM+vLsSRwKKKlEIBSrkb5fQUt+TwC1stzTZwAa?=
 =?us-ascii?Q?ejMgdhQ2fVyoT4D9a6X6Vg7Avy0nHLkDI+L2la19hilirTO7PI5oBLCgICbL?=
 =?us-ascii?Q?qsKSy+XUra0cTQSSbJDTfciy9MomD6eXrb++EGQ0DzY7rn99J2j30oQDqcSW?=
 =?us-ascii?Q?j/2ZRJ4Yne+JQtiPM1MHm1hweyhtJKrbJhpCFC06LwchS/ZKZvlu9MN83lWh?=
 =?us-ascii?Q?g3PithuwnCLztZg47fbj5gWEwiWmq5MdH4LnKUudE9+QzNoCgUjQmYCfIy3n?=
 =?us-ascii?Q?Tk2tCNleph588KutpJVUtNyDsqWOm5IQKp7ODe7V/8HVS9BQlZqSurKbVm/l?=
 =?us-ascii?Q?5dDETe1tF2A7dZNXT2TTCW7J9BENm0wlrirNHHGgGf1eNPWBR58y1kGzlbAC?=
 =?us-ascii?Q?lVU/8Tt9Q8jSou9uL0cy1OSqaLB6necMyBhGwjTBIVy85SGfhnRfEeyGkCTE?=
 =?us-ascii?Q?Ohi7aananS8THe0cC90Z4E77Pw03ZP4hI6H3YhdTh9biKZUCWP5l4magrAzM?=
 =?us-ascii?Q?NOCIZKkrp1t3CdtYUfbbnTVvjXSnnLx88zdJJwcHruuA//dO774ktiOiyQ0p?=
 =?us-ascii?Q?h6B52c89FObOqRB3qB4GUzCugaz0HRGEjJSXzI/ZypHVJJbuHas8BEpiLZ8C?=
 =?us-ascii?Q?ZpTz1IM0BCydUGq5HPN3ibE79kKOU0Of48AGGcrbMdvMLZKfHfyaSrx+uDGV?=
 =?us-ascii?Q?jEiHpmQdV4/A75QanPUsArBh0o2WYl5JENRhk95eUmHNfWUh4WTYcNRKx4nk?=
 =?us-ascii?Q?XnWOu2aMmY/X7E69FXkyCsyaJ2IMdjU977NoRo9ynJmByw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yLsiC2pUMAmJeT5ac4VFfe0R48+wwJ85KRdmcrP0+kTZKG/DUgNtPnSW18Ym?=
 =?us-ascii?Q?7KzGWU1YC761NOA1et5uN3xCaAEpmnQ5mRpZxFJzTPFHaDyeR7CS9c9hfZho?=
 =?us-ascii?Q?tpLuF9sG2Z18dnYK8lcyhpLxB2igNwfOXfuvE5aQmf6N438pQhCyB/dD+LV0?=
 =?us-ascii?Q?yAWq8j+cdJxEaUBOrzibgx0hmVsB6bqJAs5SdOXpAvNFauIVWgL8QEW0b246?=
 =?us-ascii?Q?rjQMJXZXGvl7+MwXgt2pwryLQL0CVPoqTacYA98F9Zu+mflw8Eyia5uVQYSh?=
 =?us-ascii?Q?9K7PUeKamUDpbmgZuXrLaKHfoHSvklWlftCkP6PIpoV5UnTUynFXWCaUOC++?=
 =?us-ascii?Q?Vi1NYwXSTgYNo7BdFsBtq20i4YDXHlYB1jylk3CllWjo96y7fAfwrxJaABcx?=
 =?us-ascii?Q?9a5z+ftnJ6mQBTQzKmmluM6Dsi0NuwojDG5xRmNNs2yRocBgDfULsQYdSHcz?=
 =?us-ascii?Q?LeABugd6DcnlXOmn0C1UKWrO49f3jPI2KSOSkBJw3LecquGAvHT/MxeOKW9Y?=
 =?us-ascii?Q?hlzC9kErU/0Xeub8r8ktoWAIzqs8roBzH2E2cBT49YrGEXEvHa5/AARynqDA?=
 =?us-ascii?Q?mj74PbmQMl7N05Kvb7NXkwrAS6r1WONhPgSfhPsdlUrOto0nXGCv7Qz3E7DN?=
 =?us-ascii?Q?V3H9zE3d3FP/lcGFsYT31GooIa8gkA1ApgXG7hwMzkinqE5nsAqhDHqksIhl?=
 =?us-ascii?Q?6jE/gXJZ/IGbQB04pOS14dQnsl+Ra01gsXX25/BrimN7he8T9hdNPZxcrds8?=
 =?us-ascii?Q?Uu2RVViOgVj2hSZvfmCsZ+ic9Md3V2602weGPOobowGUoSeXwUVK2I/naAKR?=
 =?us-ascii?Q?SiBcO8xdYtS4Jk08iPgXLU8U3tjzUHpDzsvPtj/oKtam1eiiCDRedLabeL/e?=
 =?us-ascii?Q?LgAY7HoL1eKXyiNo1hZw0kn3AyZ741Gzv28uFTfVZAt7DuL0E8t7PsKXYw5w?=
 =?us-ascii?Q?raD43odY56OTodtDl720ZUHSLJP5ox2yggD/8HwvR7Vwyu7Q0Qy5BgndMPc1?=
 =?us-ascii?Q?TSE6SbU9iwkm9+CZopspeibCxEtnk+3tAzar955p1kERGjqdGQ0HVAjOZ/wf?=
 =?us-ascii?Q?PuONWjMo3GQiPNnhuVZ4AlG1T5jF/fiGaHokKEylv93N0Al+WFH9LkcAEPMS?=
 =?us-ascii?Q?djl9cseMD+iN8eEt+cWIwiOrYauuoxL9AO0auGup6FA71dFPfa0MoelLrZrQ?=
 =?us-ascii?Q?9E84JH23CC6QBBke4YcFOpHRSvTURL4lKHCx/nqj7G+lPTG3eBhuVKEJgtFB?=
 =?us-ascii?Q?GuBnyWr3uBYOfmEYxkboutZGWa1oz0RmyOh1zwx8YNALiJb+gh4OEkjS38y3?=
 =?us-ascii?Q?Bkm/kaHvhubXu1gsScR27uYYG5GQ2k+OS3k/n5hEwhyUiXKXFNr2AMo9caLU?=
 =?us-ascii?Q?ly5zSSQBgKZ2WVX/jH4NyQmqdzsEY8VV8d4RkRb4ihHbLxGQqwWW5QM+72GI?=
 =?us-ascii?Q?9K/crYzeNpPa4WdoFf6bSkkUJXehVW7ew8ZLzWP1JrS/0OtzSsPCgG4APPZ1?=
 =?us-ascii?Q?EIJXEFY1hyZUjdssvSkWWWmkutIFQFmHt2gSXclw8AOGI73qwQSTMJDrhU9X?=
 =?us-ascii?Q?Ff+F7I02FttaeViHxrDJl5DbfZwIAssT9pH00aWV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 368c4fbd-290c-4f80-97e5-08dc806cdc76
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 05:53:42.3268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggmupPfZOs0/U+X2l3wjIxzsmkeUgtymN/6H5NMB/LfGW53brGMeGg36W9Md9/ZmR0Y4bG7LMzDS/KlsYmOb1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Zaremba, Larysa
>Sent: Wednesday, May 15, 2024 9:32 PM
>To: intel-wired-lan@lists.osuosl.org; Keller, Jacob E <jacob.e.keller@inte=
l.com>
>Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Jesper Dangaard Br=
ouer
><hawk@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Zaremba,
>Larysa <larysa.zaremba@intel.com>; Kitszel, Przemyslaw
><przemyslaw.kitszel@intel.com>; John Fastabend
><john.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; David S.
>Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>;
>bpf@vger.kernel.org; Paolo Abeni <pabeni@redhat.com>; Magnus Karlsson
><magnus.karlsson@gmail.com>; Bagnucki, Igor <igor.bagnucki@intel.com>;
>linux-kernel@vger.kernel.org
>Subject: [Intel-wired-lan] [PATCH iwl-net 1/3] ice: remove af_xdp_zc_qps
>bitmap
>
>Referenced commit has introduced a bitmap to distinguish between ZC and
>copy-mode AF_XDP queues, because xsk_get_pool_from_qid() does not do
>this for us.
>
>The bitmap would be especially useful when restoring previous state after
>rebuild, if only it was not reallocated in the process. This leads to e.g.
>xdpsock dying after changing number of queues.
>
>Instead of preserving the bitmap during the rebuild, remove it completely =
and
>distinguish between ZC and copy-mode queues based on the presence of a
>device associated with the pool.
>
>Fixes: e102db780e1c ("ice: track AF_XDP ZC enabled queues in bitmap")
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h     | 32 ++++++++++++++++--------
> drivers/net/ethernet/intel/ice/ice_lib.c |  8 ------
>drivers/net/ethernet/intel/ice/ice_xsk.c | 13 +++++-----
> 3 files changed, 27 insertions(+), 26 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


