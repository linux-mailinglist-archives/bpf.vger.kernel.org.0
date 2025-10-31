Return-Path: <bpf+bounces-73156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F13C24CF1
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 12:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F5304F082F
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8453469E4;
	Fri, 31 Oct 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tmo9p6Co"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC68336EDE;
	Fri, 31 Oct 2025 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910673; cv=fail; b=u34EIRJO19vqHev+ka9OOARCmG12Y7maB+lHc/y+NFm3DmKO1OMrr1hygOyhVbGdzXaTqpyiGY/P6MB3+31QE75mAKi4mib48paq7e2/dLzsHcLeG0TW/4R37QafqR22IU3pbeHST1adE2JF63N2uc8byNrk9oDC8Tg9wV+2UDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910673; c=relaxed/simple;
	bh=ZaLUc9f5xaaq5coq80Dx0hx0dpw3mQjl2g2hzg4DUD0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ar8wDrYoEeh2vlpIR4lnR2Uao5tKHc+vXCDVgggY2inyWGhNcW4zxsVrkSsipFncN8J3I9BZmDYMsS0ojJ+4Kfg9CQSCGpKLcABuPxR8cSH6X1eqXJrGyfSf6rKDSiPEIqllZ7BZ7AZpiwDp1SSQ5nKgD8i4Yz6gOaPHuKa6JuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tmo9p6Co; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761910671; x=1793446671;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZaLUc9f5xaaq5coq80Dx0hx0dpw3mQjl2g2hzg4DUD0=;
  b=Tmo9p6CoxvTEVa3xfBTXxgZVXqMtYMw9BEJE3jnb1kcSLwYRIolOxMKq
   mFH1WdktFCB6k7WT1TUyAgRtfVMEyrqE1mSbbGQ6+M2kisHu05lLnl1Oi
   w5Opg1UlicEaW4G/veewsanI/00iMuw6f1FCb4Cu+I9ur9HCJY1pMhC0t
   dKPr0bfWA3Mrsa8EeWKxOU7tLqvVzsQybeR9xyUiLRyB26f3QOuA+5iEM
   MJWNuzbGOhuAF4sdti6IxYaLhnhUFHB2HF52fww6/bX2r/FptTp3y9jxk
   u4rq7RF3crkq6B8qC+cQ4wo0P+KRCJijbIgFQZZ+JJILOnT3rMENkAtJk
   Q==;
X-CSE-ConnectionGUID: c8jjIWGwShSI81BRHLxEdQ==
X-CSE-MsgGUID: 5ByiSHBqRoOJ5qfcwIEyMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74670434"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="74670434"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 04:37:51 -0700
X-CSE-ConnectionGUID: LgJZDpg4QnyAgdZLI2088g==
X-CSE-MsgGUID: BsTIS9UNSr+3yKAlnMmuHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="216871340"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 04:37:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 04:37:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 04:37:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 04:37:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDCr9VocQnm5Iy2e6r5vkyykGc2Ae9aRvKtfQycH5r4jfejCJh9Zs5tB4avNonIgCX2Smv4PeDnZOsXt7Ou9knoQpxa6qSqoc7fjW8WaIC3MATGAx8uafZVovfN9a80SKUHvtLSx7daJ9Wkw/6x8SCRuJlUjv15r9sbtzCYZ9L5ZkQrl7wkB8RhsS+pRriV6YOVZgrKBePEboHYLKAT/voI/Tg+duerrVF8g6/lOCqAx5jeWigti/4JGWqCME82otjdufSlli7vY/vfq34t6/DDfKvR7g8NOXrzDwZjnhRYDtEdUvzh7mNzZ9f1Sxm7Ze08C96Jbco0NYIovRVFJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9shH8NGqTQDcuHWGuul9LMLZwm/XJNd4+iUYA842u0=;
 b=LSE+5tyzr8jSfjsiZ5bVkOXZrfwxnz6WkgfFF8fL8YnTfK+LCYbhvX7j6dM8TMiWBOX5uD6fhrgxOyUgFYE/GRRMl/Lk0jlmTdFiPjh+aGlbSXC73j1ijPHj+MUI5SuASEK9f3hAgfWElUJTscH1vx30sxAs3ONM75pkCCbsK113jS8pT9sDZGyglbAfzr3Vjw5kXO5auyiVZNiOhGpqqhzqKeaUlqxmZJTYHo5pCTkRFppxsD3979zrgf8r7IalmzS7MUEekSU8i+ATv3mFmDNhmO3OrSqRH4cpsuKsqVF86e8sQa3kj6XoHJ6Mj3uOfJkbUqpq6me9nCo9ehvabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB8245.namprd11.prod.outlook.com (2603:10b6:208:448::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 31 Oct 2025 11:37:48 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 11:37:48 +0000
Date: Fri, 31 Oct 2025 12:37:37 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
	<toke@redhat.com>, <lorenzo@kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <aQSfgQ9+Jc8dkdhg@boxer>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
 <20251029221315.2694841-2-maciej.fijalkowski@intel.com>
 <20251029165020.26b5dd90@kernel.org>
 <aQNWlB5UL+rK8ZE5@boxer>
 <20251030082519.5db297f3@kernel.org>
 <aQPJCvBgR3d7lY+g@boxer>
 <20251030190511.62575480@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030190511.62575480@kernel.org>
X-ClientProxiedBy: BE1P281CA0478.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7c5340-fdc8-4de9-7848-08de1871eaac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AOgk2K99g6FUUBAmGluRR6EKUFac0XX6GzP2uveUCJnW4RRwJLOmpHx7mNg0?=
 =?us-ascii?Q?FhGjfN3yFlCBRFBSme+kYZ8qTnN3ZafOeBd7gNU9d0d8n4/Vnhvv2/FzWAsP?=
 =?us-ascii?Q?3VlRVCHkP3z52uUBYluecprUf2goz1ArwxFDIhtdXyEduzYW4ijjKcTpX1UB?=
 =?us-ascii?Q?M3ZDtVOtZqypmJrxinwBC7fa4WrX83B287E+8QkbTzZoJmQ1c00nqopgDYYe?=
 =?us-ascii?Q?5E39olWvmOZi7bysyKYw57lEvKpwG8JsA5am7qQu+to0Qh+WqWSxu/tNIXb8?=
 =?us-ascii?Q?kQXHjGHex1s7WOZ/sIQlh0EM2QgMOyApf2l/Lv1YQrb5qE09kQJiUmWWa9Rg?=
 =?us-ascii?Q?PY+vr8O4uLg+8+aigxTpHqZeZujOPlJmes/lpDsY84LYBOnu3ecTStDNhc7O?=
 =?us-ascii?Q?6DBsqJOr7DmaX+PnSIrYUn1C5jgnKHZb659QRhMLHonagvSgBttXDZRlAp9a?=
 =?us-ascii?Q?hF8dYQpXVr2JcIVXiUtOtooplIoztoClcjjv+bi+fZHrnybAr59OEUXNhJk0?=
 =?us-ascii?Q?LGYdR8QWuORJ40mbQV+FD23nk0/az50Qr/SR0JLVPpvdQAIsO7dn1Jt3emvS?=
 =?us-ascii?Q?niOm0GvYKTlrLfoHUK4JkrI2/lbuXNiFp1ID0IIOvB9Su29jJmR2qOCELMnw?=
 =?us-ascii?Q?/VJ2uvDAwN7pV4G3Hx68JDXE4yr0rBOPNc9cK4jIOVjxPCizHum3ULE7AjCl?=
 =?us-ascii?Q?7vJOg20HWNokeLiNw3ty0frkPz9fPEFC+MuWJQp8B++BjUR0nHDlqzNNJ1lu?=
 =?us-ascii?Q?BwyDV/aCarNgSvHyrM8v2yCzSH2pqJqTbU9sAP8qcpwUuWH5R2akUTUVk8Je?=
 =?us-ascii?Q?38qxE/126/SbvFGcOtuT+qG9x1XM/6/3GOvQrJr+2zDAyQptUF8KYZtihdu6?=
 =?us-ascii?Q?oAS0yVlRfme4NNOx06ttUh3P1Gou/KUVR1IM6EAaVpffwBcikA8LFWJ/KSSl?=
 =?us-ascii?Q?oDINyIXFhhxXcX93vuddfZeJdl1qZHADAebhD9bUkOBk/+Ogc6AsUx1fET3W?=
 =?us-ascii?Q?O8duRmCiTR+zAlAI38rAvJnL5+DsTTp55HzGAVoT/oNjRnx2A4endrPEbK1Q?=
 =?us-ascii?Q?gstwIrX9/2Rf7kMr+lsZLsnCbP+WrZc2dGomkS+JF5FuNzPTCNhaBak4wntA?=
 =?us-ascii?Q?3S5aePpO+pntBVGi6wiqOYmGgGuw19pmGFmCcBUrOEX7+v98QjaGsM6ZVVKa?=
 =?us-ascii?Q?6Cs3bUaiXYWc62sxpArMt5WB19slhVE8930Q1flU4IVHY89pwEqwzu0L65PL?=
 =?us-ascii?Q?21dl50TBjN2+Rlj3nRvyeNYWzRK9qAjfBdmR2B6+hODpYT76VyhtsWBQ9fPm?=
 =?us-ascii?Q?xNfelWlOo4PbK83rEWFh3121Uy0Qu65+poHP0LCf7Az0ZX2BjWrIr+47osTk?=
 =?us-ascii?Q?b63cC2LoPTnJOIWo37TWRrzN/QvX+Q8cEov31j7irP3Qs1zCLlFWtBkYsav4?=
 =?us-ascii?Q?Lboqibmxo5pw3HvS7d1/I4tyIir9mG53?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2JrPpKW6uC+6Ev5ZKAPkSh1FmABOPEYV2wh4KKRexTjHoWU+stWa+JnlPX7?=
 =?us-ascii?Q?pHE8Mm4R8ATeZpN+xxxnxMpS110YxwTQanmDpheS01Y3/tYmk8ddNOXpgerr?=
 =?us-ascii?Q?etCojpDPEI74sMnAXa4JcTJJZrj7t6YzVjU4WomQ+GQVz+LQwFkpGVfjraOF?=
 =?us-ascii?Q?8cTzDzBoFTLAIlLe4wd7LL+fmR2Aer8cQAC0Mdw6OpU17Z0wx/SQBhiW/O2p?=
 =?us-ascii?Q?YSzPhFd5F5IEBU8qCrYvNwVgLFrDEFhVycAfTlnqJ3mPlFt3QOUFdjDV6lHs?=
 =?us-ascii?Q?hOBwo4apsWKe3gxXFlgF7jhGvGt6t4JA5hlm+nTIdV6OP4iwBxL8zu3vwB+M?=
 =?us-ascii?Q?h+qLmd87uTKSk4gsdxjLXSWAquPKQ82mmVBPTNjOF8mNpZUX5AWDoUNisR7u?=
 =?us-ascii?Q?lfs2NS8w4IoCj5Iz50EbQEGKKw3onIYC2F0z/HvOXP6y1/XeYSieaKMpINAv?=
 =?us-ascii?Q?hw5FKzx2WM3zhxAuSwXgWG86m96uB6iklqcUNPA+s/Mf3l8pGndUftAfOICM?=
 =?us-ascii?Q?7l+hf97ki5icuz+PNppzHf9sKcIap4qvfdJr2YvodvrfORFhX75rPzLfNSRH?=
 =?us-ascii?Q?8+/7usk/KT9GGZGNPTSpyVWSvjjC7EbDpM8KSXXI0/60ja0FUo0y7TcJak3s?=
 =?us-ascii?Q?cc2nYaH5IDCNhW0DZfFFFudJkOV3ufCB1Ny2W6gDz2MP0WbNAN2PPeKJiq+F?=
 =?us-ascii?Q?WMPE4ZZ9Vqw0xcHpChfW+Zbxdyp02Ims1GILwHIke+V4nmo4NAc/W5k+1rMt?=
 =?us-ascii?Q?iKnbg7n6HO4QWcuMlSkYeGMek5KASdnfzzuhf1xXTDFRp9lfWMNwrsanWCN/?=
 =?us-ascii?Q?+zegtAM2JDUjZSHLAjrB+OQ2/DwfKMFs9PGEqqlVhTZxVNqrrYJ+hjCPB1n6?=
 =?us-ascii?Q?NQz6mV08nm8jERbPL+xfq12Y+UwkfLp71SaPPKOXClFuPv9w20ZphuxliYeg?=
 =?us-ascii?Q?rXB1pVSkH3wdyRdUVUO9p6VlrXNNFt1oharLEBE9n2sLdfwec00nDkX6c54Y?=
 =?us-ascii?Q?EyUKCigCQVRkxUMFqtxxVausvaN9bgSo/Zm7WFdAYgHC83OK+FbMVYpQqQn+?=
 =?us-ascii?Q?ur6KsgxDMu5cuMYU9qi8zHo2RVHsP8tv6kXVyque71jAlHCuxKs0zalJa2aW?=
 =?us-ascii?Q?yFcDC7za5Ua2wVi83MaBXBDOtBxqRpVy7vT244dT1px7yHHMAojTxq/lOVm8?=
 =?us-ascii?Q?HpPKJHnfiBc35rrCwi/img8DPPI1WX6mlpaUI/5Z2IekyOApmM9EJ/0Vxib8?=
 =?us-ascii?Q?ZakdszJWE8Ze3SFU/oeR9yhhrss5J7o2O09K6Q2LdzsE3QNOHL5U9ZaU1p72?=
 =?us-ascii?Q?a94+LSPQ4eJUrlSGarol3l7jizrSJvGCa0jROLzFHsTq/+empw4E2UZjyK5m?=
 =?us-ascii?Q?1prmFfV9l+05hSbwwHUbxdAzQFWsva6Eb8h5I8y73zwcW2mg+Y0cC2ASmUkA?=
 =?us-ascii?Q?hdkisNfHVqillxWSWs2Nlo8g75h0q5OBG2UnSEpxH6ottArf5MpO+eJ8Ttl4?=
 =?us-ascii?Q?PbjDKlTMR2xicCIYwcDmUVSXug2yNNPI3eQyfk+ZRrMPsiurPE4PfhD3YQUn?=
 =?us-ascii?Q?OV0nVxRcSlRnVbXLM+6gYvZCnXiu5glBnp5hJtZ/6dJxzSsWAEKP7abpqvOX?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7c5340-fdc8-4de9-7848-08de1871eaac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:37:48.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfjeNcmPHJtiZJS92AlSY8jWoR+Bmzrslz/jobXzpvS9LFUQJ8881+f+JVIWJweabb28h2oSZgByit4oUnP3+vC+e+ecspaftrxnmEBzfaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8245
X-OriginatorOrg: intel.com

On Thu, Oct 30, 2025 at 07:05:11PM -0700, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 21:22:34 +0100 Maciej Fijalkowski wrote:
> > > > Why do you say so?
> > > > 
> > > > netif_receive_generic_xdp()
> > > > 	netif_skb_check_for_xdp()
> > > > 	skb_cow_data_for_xdp() failed
> > > > 		go through skb linearize path
> > > > 			returned skb data is backed by kmalloc, not page_pool,
> > > > 			means mem type for this particular xdp_buff has to be
> > > > 			MEM_TYPE_PAGE_SHARED
> > > > 
> > > > Are we on the same page now?  
> > > 
> > > No, I think I already covered this, maybe you disagreed and I missed it.
> > > 
> > > The mem_type set here is expected to be used only for freeing pages. 
> > > XDP can only free fagments (when pkt is trimmed), it cannot free the
> > > head from under the skb. So only fragments matter here, we can ignore
> > > the head.  
> > 
> > ...and given that linearize path would make skb a frag-less one...okay -
> > I'm buying this! :D I have some other thoughts, but I would like to
> > finally close this pandora's box, you probably have similar feelings.
> > 
> > So plain assignment like:
> > xdp->rxq->mem.type = MEM_TYPE_PAGE_POOL;
> 
> Yes, LGTM.
> 
> > would be fine for you? Plus AI reviewer has kicked me in the nuts on veth
> > patch so have to send v6 anyways.
> 
> The veth side unfortunately needs more work than Mr Robot points out.
> For some reason veth tries to turn skb into an xdp_frame..

That is beyond the scope of the fix that I started doing as you're
undermining overall XDP support in veth, IMHO.

I can follow up on this on some undefined future but right now I will
have to switch to some other work.

If you disagree and insist on addressing skb->xdp_frame in veth within
this patchset then I'm sorry but I will have to postpone my activities
here.

> 
> Either we have to make it not do that - we could probably call
> xdp_do_generic_redirect() and for Tx .. figure out the right incantation 
> to give the frame back to the peer veth.
> 
> Or, if we didn't hit CoW, you need to actually add the incantation we
> removed here, there:
> 
> 	xdp->rxq->mem.type = skb->pp_recycle && page_pool_page_is_pp(..) ?
> 		MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> 
> Or CoW the head retroactively if we hit the Tx/Redir path.
> 
> My intuition is that first option (making the handling as similar to
> XDP generic as possible) is going to be least buggy long term.

