Return-Path: <bpf+bounces-35452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD70A93A9FF
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 01:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF90282D79
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 23:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3A149C46;
	Tue, 23 Jul 2024 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZ5TMpgV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF984F615;
	Tue, 23 Jul 2024 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721778395; cv=fail; b=hK5nfPyWmjM0XAtrsViYUsTlT9oYEMp1f3fcQAbkYFBj96kCG5v3hnZujob2BfHtqXTAUm3myqY8CdFyuQpPR/cMFWYfIssCDAYKQy+jFK+8tm4laM7KTnuNeADd4ZaAWJctyDVZws1g95zmyHXg3iL0UPwFLv9GsTGztqcAupo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721778395; c=relaxed/simple;
	bh=GaGk9AakvYWVAWIjbHS85dlXDPsIQUdXW3brkW40hqw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TUwua3ayEaK135/K28IiZIX7wKYgFhpKytKZgymYKooi75HKuf/y194ouwVlZWIMk/d3R1MzVC9F5w8AMKquMGvdkNbWeOaxezp0H0BAZDsWuVIY7+1T/wiaTGrDZLHYnOKBwEg0nO5Qg0nsj5fKoFXHJZt4qBj2ybAuRfxi86M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZ5TMpgV; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721778394; x=1753314394;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GaGk9AakvYWVAWIjbHS85dlXDPsIQUdXW3brkW40hqw=;
  b=dZ5TMpgVikgDbrLMPy2fjNecb1L55DQ/xZOXdE3UG9V02/ogz6L11Dv3
   HgrXvwEEGzaxiLg4gA9+ZnNoneU7ObIHVWAWHgliG/QV9uDPtS1CXGaz3
   NPxKqoiNj42ooX567yX4ZpwCgspdX6ODD3CsaE2vniltunIoK8KvNod+6
   CB6ke+rMtxOveuRZoPh8Dk5xCo8sQ7QCPOYptSD5NjQbyPO89AnICPiEq
   QlIcRGfglQxH0uxv0nSe9tXCX1tkh/ah9NsSAxfMvr+62WFEGqMLWNaIA
   CXS94W1TeSr26nDnBa8MOyXplhguOU073kD2cJqqLT3Qa79u8GcibQDMf
   Q==;
X-CSE-ConnectionGUID: a0G37t34R6iNWIEkSjAxvw==
X-CSE-MsgGUID: iGAccCXiTT60yCrBB9M1og==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19045342"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="19045342"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 16:46:33 -0700
X-CSE-ConnectionGUID: FFi43Xr1TEW+5wjUo3VCww==
X-CSE-MsgGUID: a+qKrntvSLSvpWKGu7sfZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="89849574"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 16:46:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 16:46:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 16:46:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 16:46:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 16:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FR3u5sfasFclvxTtghb6XpUQ4AVEBA0AH6tSv7iYRgyA+npm3vxfTV9p58Kcioook1m/6zW8C++qHwIIPPk9IxHJxCyZBqdUbN0TQdHcZSknQ53KKMT7Vhsc7XLs4qbwgScUSxjP+2vuZTcMG4hPMR3tA32xbeIs9EwCbG3MLhlydkJ899mUi1ZHXuIWbRp3bmUOWSZ+EmaLyf0jrrsp5bryd2ZT6igqq9/w7Fd4X1yBhDbk8j7U65da68he7uSrN+gHcS6BJZ/aX/rrhpBDzE/XpxuBOtY7biQS9WE56NZNx1pH8EZuQGl/tV8yxeNbf1m27HKgTLxpOfYx3iPTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCMutm0Xw+XX7EhDqxkk1EvHmlxiTST8xf0ZQ+/h/Ps=;
 b=Z5r7LzSpYjd8stuDX9G7iI/bKNai4TWt529Lsrjzcotov0aILvMwctg92dPFpmtGwb9eihA8F2Tkqmw703AGifFgyVoiSHVuYscsSoABVmU5B6/HxP/PyB51Zf1tnjkAeCLD43jzW0mnBq8j2h3/agTlBT6bUCRbQajkeQfSSC1uKASneQtdmuzu1Ky7rzNRUjKulY+uh0UfneGMzdjnD2rHt8NtPhbNqS3u7Lcj/yxydbqvQKC8NFkDyx5eDLh4Y3S4JK1B0F5u6cNccbNWfAFdmAH1D5RNXAVKuYFBioSQIx278PILQFm6u6xneP9zVp6fM+t9EvKmRNj92HlEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 23:46:29 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 23:46:29 +0000
Date: Wed, 24 Jul 2024 01:46:11 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Shannon Nelson
	<shannon.nelson@amd.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 6/8] ice: improve updating ice_{t, r}x_ring::xsk_pool
Message-ID: <ZqBAw0AEkieW+y4b@boxer>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
 <20240708221416.625850-7-anthony.l.nguyen@intel.com>
 <20240709184524.232b9f57@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240709184524.232b9f57@kernel.org>
X-ClientProxiedBy: DUZPR01CA0148.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe6584a-79f4-4f3b-6352-08dcab71ac5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FmJYzC53LxVECS7fqyf0HxZvYQnXdePR9m/gPaZE2yGQWknTCA50vu2oTRG+?=
 =?us-ascii?Q?w8wmcwPKeU+Mfjw9bkCpG5DdY1DpGNd9IlzPli2+PSlJGkjSa65jKqSMpOhi?=
 =?us-ascii?Q?Ie+tLR/kelp9cHU6QeaBepzNhqO/z7tofopGsTeWGmPA8xjWzioqfDnLpyp3?=
 =?us-ascii?Q?JIbaqTCMVudUGEeQoCVBCMTfURE9mQxjn++AjhHidmN9dBrYtkbWaBmF4CfN?=
 =?us-ascii?Q?cezthQ6F++OCBqakbNtQlMt2XYShM0N3kO45iQGO1oLu0vxWIpSfli6hz2jA?=
 =?us-ascii?Q?yG5Ev1lap6pz2B4981Tfe28a6DbE0o53PDgRDL/LhYk1WfI/q4b88bO9fL+X?=
 =?us-ascii?Q?+1QVnLHoUcDLccTzOnrz2ejkm46JKXLZFVB64jrKY/RJ331DnypjC6A9sKhR?=
 =?us-ascii?Q?9R6oyrXYNeMdJFk0x6huezXvDdGc+O5d+X41m43a+3kVxvKZBJ5qmCeyBB02?=
 =?us-ascii?Q?41wkygGO2gDfxnUoDJkHI52XZiNhSjT1vTzRWhoZfQ2kfOd45m8YF/DI/MmD?=
 =?us-ascii?Q?7MypNKOdmVgwH5TbEw3snOGapvamRWjjHTy4h3J/idpbotlgu4xUBfZkY0Rx?=
 =?us-ascii?Q?UhI6h61q+qAA22Afdp4VUT4JBboeF72t1K6ENu70pfpb4RovK24zTwodoiTu?=
 =?us-ascii?Q?1KtH0oPAFdP7f+IW8ZkyGX/3UCk3SbwL6/mUU1IbbzeUb//EFftrF1DeXh7f?=
 =?us-ascii?Q?9XtHKTJbu9YZmK2ef9vBs/ZxLXaJsvdN26SU5NVYZAvr9IP8wzlcIiVNVPdV?=
 =?us-ascii?Q?NGWZiaD3Kp8ZbTO+ibddicuTFoLyFw8+Efkcyq1LWtKVyi7Z00fzAQv40NVC?=
 =?us-ascii?Q?ALjjRacnLmJq9fP//g9SI+szTenCypZPt/tK/ZWPENbkTeNXvrqhkpemvGLB?=
 =?us-ascii?Q?NTPHaH48BgZtB4z7neKgBKH+oND82EJy5bsjiBM2VrsWMQn4FkZ34SEYBk4U?=
 =?us-ascii?Q?cODJNmc96tg1PngnujHWDK25mjTEH4AUAQKNZRksUJe3BownP9YXSguEYFq2?=
 =?us-ascii?Q?W1d8REj9HnTl+uQ66m8q2huNlUllz9NZKRMqhk8lNciLdbfAIctZkV7IL8/C?=
 =?us-ascii?Q?CUfIO3CZnIld0iC20n+NT8jJbCDm5w1JTOkaXeAJ2V5aEYCbc9KuRFSqxOi8?=
 =?us-ascii?Q?z9Qlp9hRgEHXOnfaB8Vld0Oaflz9Oh3RfKCsbL2+59SO51Mu1RoOZ1j+qE99?=
 =?us-ascii?Q?rZhG5gak/dL19uz3+zxvoy+F4CPhQ2O4nu4P/fH+tFnXXtTbUJUo6vefALwx?=
 =?us-ascii?Q?9QfCefT5rxFzxZocHD3UlFY9esDyaUlnEP+ri3OXD9YqsMM3WfCmxSs2t/zt?=
 =?us-ascii?Q?G0NscAaY951F6my0HmpmFlYuYzSsh83d+d7sZZW+HtoDuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tmDefFrQe+zV89S6HhmcHgiW4L7G/eI/6auLDLMK2mlhf4XAbi7M/Ivgklqt?=
 =?us-ascii?Q?xhq4pnAXoS0FH4YKjBjSQM2mFDuXoiKPfHtDc59uiuPuSfLPx9iwCtLTa8Dv?=
 =?us-ascii?Q?j5CFlZI+TkzBLumJrl1ovOyizSDd9xKD74kjHFAvthg1wgH+Pl7BSnpVq/rB?=
 =?us-ascii?Q?CY39Z6sLbBsYIqU4DAi+Vf0Pu8AFo14y0RzfFbVtZz3Eog6jDc+zr3kVOmI4?=
 =?us-ascii?Q?8mvz0RPRjymfRumjWMi+IkPilW+t4Zes2tDxB8jqTcI0vu62lIl3ao8+Q4si?=
 =?us-ascii?Q?gXULMsuCBzP3ZDAxpZkxoABRlu3zmgf8osaRtS4G8Dg3xqY31wLaEHLNL/zL?=
 =?us-ascii?Q?2NVmOO2F5LlM+73vegp5QQn8MohgjJ3OwJhsVP518l1ZO2ozsAr5vG9B9Op0?=
 =?us-ascii?Q?ZbO7BWlYsGddFOggjrKIdougM26sVp0Mtpggpo0bZv2dSnHNgrLHI15mAH+a?=
 =?us-ascii?Q?SK9gYQDpbw0h9/NHN/zcdJDZyVD87OE5iEXtkwCOzzw0F6Q9IMVF3iKplyS6?=
 =?us-ascii?Q?8l4XNfQKD0VA4w6/J4vdL9NFOT9MipPmB1dKlfSY0advuUmhs2diKXpVh1Hq?=
 =?us-ascii?Q?zkglR94xQM7iCPI34BtJKexDhXNOWtccZM99zANIT7X0qFC3MIKI/6OAsR+T?=
 =?us-ascii?Q?ES1cqzMKkqA3k0EiPZsynZrENOPGIXqHys7/mFfWZSuOD0Hbxllqjcgntbn/?=
 =?us-ascii?Q?ucO5KvnSRAQr+gs7llzxHOygTIPYfRfnI/8i0blxE0SXNclnxpSq7OnsX1md?=
 =?us-ascii?Q?sMpTNQjzl5M0krHwvd24wkzVH+2Np/10wAjbHEdYgmEHJlUf10krHgqgQYDC?=
 =?us-ascii?Q?ATtAWmUHO5rylVgVEdt3qZwLo2UVQuj6bvDvYrBT4Vq/1N0P1IqiVWH84PRI?=
 =?us-ascii?Q?7Oh2VxoghzVBHBAjmp2zaVqO+Xf3+aAAT+4WoRjx0PBk05IcVtV6RKHe4sRn?=
 =?us-ascii?Q?mOWURP9SQgRvsGWjnh5JdfZGgK/G5nYdmdb3YTpnfKCmA0aJww68UacUt6Kc?=
 =?us-ascii?Q?NWqVQJFjOH9aFZztcYjAzdv+YGhdO8spal8FePhG3pldpnNCjjmJVI6oveqK?=
 =?us-ascii?Q?m1lbSIQRM4DFpKV925Qow9LzEsupgNBAqXxMUmxgkCnSrNSq2pnkd/GIVXAu?=
 =?us-ascii?Q?GbilD20FmNwP0xWUnOZEYowH0GcstLY1LAchHBjdBaWVHorPDAq39BgIMJlx?=
 =?us-ascii?Q?87Ak2VBtUPKB4gu4ZonyxDLtHarIn9jK7w90iGEiYz4/wAKdUQnuyjmsk1Lt?=
 =?us-ascii?Q?VzU2P77pC6fVlLOxYwp+qeufN0zFpDM5WpqdCnPWARq74qpFL9N1mNTjxsiL?=
 =?us-ascii?Q?rbT/FfFhQiCyPtCCm60xy+la8+3rJctQeF9QMHzGuQdDR1s2I6FmqhwWrqy7?=
 =?us-ascii?Q?0fjFdxyrBcaxWyWEmDD6Z1xbS9BIc0UrZtTSwX83Cr16VGF/Tu3W3nKlzKiv?=
 =?us-ascii?Q?LfYpvCF7jCwZXOAz78fowBZbxNby+vlMgj1ZHKMTHPkclk+eLuSsheIDHXWA?=
 =?us-ascii?Q?QLaaOYLrukYn+olweEc+pn3Pq1Vit/ILiCPSC6LGQKRBF92XRylFrJ2wVqDJ?=
 =?us-ascii?Q?2XAOquneJEwoWx7Q2mvp66nhBtIUbAozVLx8Nr5cF6h9qNJY+/gCN5C3+/MA?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe6584a-79f4-4f3b-6352-08dcab71ac5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 23:46:29.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzn+VHUP7FsWo8zR4BVj58ruDk8DBFjdDxuBTAILdTAAqKtopPXaehimuNwYucXsyn81a+LtjQ1c/x7ylfcBxI9imvMpVLn9wMarpAUUQf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com

On Tue, Jul 09, 2024 at 06:45:24PM -0700, Jakub Kicinski wrote:
> On Mon,  8 Jul 2024 15:14:12 -0700 Tony Nguyen wrote:
> > @@ -1556,7 +1556,7 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
> >  		 * comparison in the irq context instead of many inside the
> >  		 * ice_clean_rx_irq function and makes the codebase cleaner.
> >  		 */
> > -		cleaned = rx_ring->xsk_pool ?
> > +		cleaned = READ_ONCE(rx_ring->xsk_pool) ?
> >  			  ice_clean_rx_irq_zc(rx_ring, budget_per_ring) :
> >  			  ice_clean_rx_irq(rx_ring, budget_per_ring);
> >  		work_done += cleaned;
> 
> 
> > @@ -832,8 +839,8 @@ ice_add_xsk_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *first,
> >   */
> >  int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> >  {
> > +	struct xsk_buff_pool *xsk_pool = READ_ONCE(rx_ring->xsk_pool);
> >  	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> > -	struct xsk_buff_pool *xsk_pool = rx_ring->xsk_pool;
> >  	u32 ntc = rx_ring->next_to_clean;
> >  	u32 ntu = rx_ring->next_to_use;
> >  	struct xdp_buff *first = NULL;
> 
> This looks suspicious, you need to at least explain why it's correct.
> READ_ONCE() means one access per critical section, usually.
> You access it at least twice in a single NAPI pool.

Hey after break! Comebacks are tough, vacation was followed by flu so bear
with me please...

Actually xsk_pool *can* be accessed multiple times during the refill of HW
Rx ring (at the end of napi poll Rx side). I thought it would be safe to
follow the scheme of xdp prog pointer handling, where we read it from ring
once per napi loop then work on local pointer.

Goal of this commit was to prevent compiler from code reoder such as NAPI
is launched before update of xsk_buff_pool pointer which is achieved with
WRITE_ONCE()/synchronize_net() pair. Then per my understanding single
READ_ONCE() within NAPI was sufficient, the one that makes the decision
which Rx routine should be called (zc or standard one). Given that bh are
disabled and updater respects RCU grace period IMHO pointer is valid for
current NAPI cycle.

If you're saying it's not correct and each and every xsk_pool reference
within NAPI has to be decorated with READ_ONCE() then so is the xdp_prog
pointer, but I'd like to hear more about this.

