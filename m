Return-Path: <bpf+bounces-70515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2658BC1D5D
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 16:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DA9C4E15BC
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 14:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC572E2DDC;
	Tue,  7 Oct 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyCKsYWp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACBA19755B;
	Tue,  7 Oct 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849185; cv=fail; b=ae3SZ4Mh0sn0zoyaYCvckHwQkVztUVxT3akEIn9ytI1fQyDFEgSoiLrW1ndHNZS/ihXx1oOTRs3Ql2mA8+h876U14ozMVGbNwk4CoRddSKv6xpRRof1cZP3vtPwDZqWa1aDSl6LskzzYbmAF0xYBDJpFoTNLMhH7RvcwvIj0U5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849185; c=relaxed/simple;
	bh=UllPRzoXpOqVCbvTVFftoQ9I30RebvI0+pyIs2YIJ40=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lkUFYt5LZhgYnuyicXz/at44UfSrd1QVhLncAaVRPffTPLGnQh+eJCR5rhsIOIJz0+deuyTCR6d/bgq2OjEc3przeWIzht3oPkooeNmef6/KMmPjMdOgOWI3ni0dlyJCWSUYdXmNqveKhSMrALorV1+2aRovuNGcDgd4sjFXemQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyCKsYWp; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759849184; x=1791385184;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UllPRzoXpOqVCbvTVFftoQ9I30RebvI0+pyIs2YIJ40=;
  b=LyCKsYWphGWZ3wQqNtJdp774Eq09BV1QErmaR2OqjBGLkO+bYxX5PjS5
   pK2lX4bi3IQ7xJxeGStRZFLcVQzEOFDo5rkvs4455GaAGGIJoUGekYyDH
   7Cflu//wxitwx8MAdnliminDJGAgo/MNxGFQ8T18UHM2TpsZSQ3rB1hzy
   oEu3zglEmXObSDv5kd9FEOQ8LCcxn2yQvqklZ452JukUnyl9rGBKkabb4
   MhKa90p59GUNODQKUEmV+zgxNAsyAzBmYIaRDvcbLCDnUfJPAn1DmNdwp
   ZfhxQm5z7TuRgRInKk7DJabNXcc2syRbA4+AN5Y7bpFLxzu3Lqfr/NE36
   g==;
X-CSE-ConnectionGUID: d+Xiq7zkSuaEjc8bCWSiLA==
X-CSE-MsgGUID: AuPG6k3wQraIGWxZJVDomg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="73136690"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="73136690"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 07:59:44 -0700
X-CSE-ConnectionGUID: jySAXP8BS5OzfnoIiVt/nA==
X-CSE-MsgGUID: nXOwo8tXTYKoFUvZ/hg7lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184545244"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 07:59:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 07:59:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 07:59:42 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 07:59:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogF7ILAAV/01aGGA3HrKryKfBfvlYjpNZDoc7m17SdZoWfg8QLNuTpwdTVMWuf4Kserh6fTPwVgwjhaiYwVkv9wbkYlXrYqB9mlx9mVbbotPsBFXtOHpX7c2tjLp9TZtQWDsNIE6gyf8WwFM27sQ+vV4WrHknISYOK3uQgE/TFfYK6lCamOq8sAxeK+9q88keOHRGdvmQBjTtIgCHuqDkd3c+Vr+aBc5lj8sHsLZVsPtDdNRNTAq4TiyQrnRGBZjF1glOOzQfCunH1D6ga4UMCqyrzcUYXkYJst27uaw/SZF35LkktpJjDikPYd0j431R7TkSZ9MoWu2d5/qRFzuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp+Jw6mFTFItuUMY/O8zevcpuwR1UeUuzwKumhMrQSg=;
 b=O2Wb+I9kaz9urioY1/jJ9qP4iFb++w2f2xuxcOAhC5Y8XycbamDLQup/InlQqEIFfL9f7dLuhuToWRG5Q25LpR8ED4eWydfbgO/hhXq2GLeVUtdAin4RsLoOTPqKxgaIka2UEwQPb+4nScZR/9D5sr6onYZ3kgNbf5HvcEykZn++o6jb8Tnd7/BeHyYXG1cLzsrqzM9nF1cZ16lE6wc0VeE/Sfq6rDJEwa87Q0kx71qvJknuFaf1+brkL6nwWFfyd3Y1t1qPc49DOh1hkJQH+NLnPpJNM6Z6NhhCekoXdllGrtUQOSMp/0sWAQol4cj9dy2VU3FVeYRaBOA/6Qks6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB7991.namprd11.prod.outlook.com (2603:10b6:510:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 14:59:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 14:59:34 +0000
Date: Tue, 7 Oct 2025 16:59:21 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <toke@redhat.com>,
	<lorenzo@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<andrii@kernel.org>, <stfomichev@gmail.com>, <aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf 2/2] veth: update mem type in xdp_buff
Message-ID: <aOUqyXZvmxjhJnEe@boxer>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
 <20251003140243.2534865-3-maciej.fijalkowski@intel.com>
 <20251003161026.5190fcd2@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251003161026.5190fcd2@kernel.org>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd2b3c3-da7e-475f-9c84-08de05b220d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LGbupBGgWMSozrxSWJ3qyDK48shcLU7y18GZU0FilUHP0auPWrTngDft2M8I?=
 =?us-ascii?Q?q+ItxQzqLaJhueDScPYNgwrDBemf1nQ2ykOxIu/uqhvQ/XHXF9Je5XD/xk5o?=
 =?us-ascii?Q?Fp43Mj99TWV0VDg/fSJgVxMetf1UYD7zHDodTprdG7jqggTS0Vl9pL+IhNRB?=
 =?us-ascii?Q?5xEGGkhO5c1VnCJ/pw5Ev0RRXCeSNft1J1X8cV4dhjLkc73knS97+L5qTNUm?=
 =?us-ascii?Q?0e1kCDx49P3Gw0aQamzLUjQaNFTPFrJcGx0VPIB970E63/eob28SVJF2h3pT?=
 =?us-ascii?Q?FF836ElmCiulPS9vZCE2Pjvm/n649lMpstwM0qf/kEqHEj7kP3JgCzfH2ZqT?=
 =?us-ascii?Q?xpcRIT+7zPW4NJQilngdUDjmgQD2TaeP8zZVBP1ko2Z3hEVfSeLWCEZPNXx3?=
 =?us-ascii?Q?xpx9p8YzzFOsRzPWRPkRjapPHA9u1GtrhlrBoCkp2Lm8VcFaDY6O3PYBTfo5?=
 =?us-ascii?Q?vhyeE15FT3CvRiUeb6f9k8DfdsgK4meLRbfC/7zGM4431Cm3YTDjYi+twGfh?=
 =?us-ascii?Q?XAR1qhbtoZmFRqRVBSj19g2FiY/gm4ej7jxv2HDlV5PVpRNkJ2otMSNuoRR2?=
 =?us-ascii?Q?6/Qe+MuuTx7yxOWphIM8a/OvDVl/0ZpizgofJwn6BFdxtJdu3T+5PYjOD1uU?=
 =?us-ascii?Q?X0edFiQixpPO0Lc+V35wuAV8nPlsJk3bCDAa9WJeuzfJeNJOVcI/uARFYLmA?=
 =?us-ascii?Q?DmkA4sfK/G9FmHQfAw8YvG6zpHUnqEK2jhyrv90mXMaYsD5+7eqIYh3kyiS0?=
 =?us-ascii?Q?q1YhanbsH8D+bmuXFkMZcF6Z2W2DNP+h3vhzJXaFsGloysvb51RbFh9F0yls?=
 =?us-ascii?Q?0UvMiI+mPKEFsUb9WzGZa2MSp0BYwwTgYdJyKE+ORg+WvLRK+ya/zs+TXTQj?=
 =?us-ascii?Q?jvMbI+MfisZW1s49FrhI+tDZWvZ7nG1CR3/4KBkNagjHV5I42qY/L81KVoho?=
 =?us-ascii?Q?f03Ha3M+R+8QyBIPQr7Gb3rs156PGrO5wWXTFGNZsYOyenbhv8f3KN/YbY/2?=
 =?us-ascii?Q?NOexksgdiG6gt3f8C5a+lhvzg3gr8x1lblW1jJsYsqDIRcCjs5Qy+LNy3MHm?=
 =?us-ascii?Q?/a5i8/2npRL6BI/uFb7B2SvzNUmv7KDxxfzkesdGPL9URHsfx0LogGwIM3Ec?=
 =?us-ascii?Q?4TItruNff4sSvzmR3j4Zmm+bccWy/+AvSwzm4T2O+s6qpu33o3G4PQo+xmy0?=
 =?us-ascii?Q?unfDJwq+VhMnUVfZNQLYJANx1E4tZ1eL/u25NLRk37h7Dsi7yBDdO3j3HSVy?=
 =?us-ascii?Q?vIxzwFhrmfv2cFpt3UeqHgUDh4U6QfL4NYiOh54VH1XFJflIgGaypCvczKQU?=
 =?us-ascii?Q?eo6w/ffwq2cT40ibPdpkKqq8TcCnSUK0kZ1wqS94uxrLet0HcM6vZXctgfOZ?=
 =?us-ascii?Q?xl14pi++fpHu0dtpiu2zrj1EbF1Y37UGL4y7ehJiL9pZm/6rTbgFFWOS1xe6?=
 =?us-ascii?Q?QNVR+dCrjpcHaRh5/QbYWtooG2dMTygZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dva7xvZcw378qpKpfmdVDSj9qqOAzU9YxWRcggEAFniZINmgbIF7Cjt4owUR?=
 =?us-ascii?Q?dQXRHKFw7Gx+URYfAMzW9k9urjIbNlg0tzMhnsFoI8JMTn8JoUuTCf5rt+rq?=
 =?us-ascii?Q?eqVUBAXSHqb4kJjeZa+uDxXEW9/UPnO1XCTiQxwIr5hT5nqemqL5fkZWwcgv?=
 =?us-ascii?Q?iAoV3TG3bgppCXhLqSrL9RKXaOvfdLN2SJIPtE0zvQ74cGfOh4w8AgPcqOZV?=
 =?us-ascii?Q?tr+8xMZ1x22P47WUUyXccYzXyHShIVzICJYWzWJKfl2YIf7qtdFQKRhIjQ13?=
 =?us-ascii?Q?068jze+ouWqoljIW+zlJYcMvCfCmz7L8lSEdxBfa/rLwsfBkoetkwd313fWf?=
 =?us-ascii?Q?kBXbGixG/TXMB3H4SsGVvTwC3qIRN4NQcQjR7DVv1CaqbQpoFub4P2IH52l9?=
 =?us-ascii?Q?Oq+frEsHzxpIlWgSazWycavd6qnZAg3htCSuADTRYN+76DLUk3CRyv/Nx/jF?=
 =?us-ascii?Q?ApZgv6ScipcmKWZ/H1qtwioNdBcmoNpynwtahxtd7oJyyiTHPz5X0mUr/PXi?=
 =?us-ascii?Q?izIqiuUZ//SOulWzp+j00+CZ8Eesvo6JeycPfbicvga0iQw8k6iF2AiCqibw?=
 =?us-ascii?Q?RQXBgGI0pSAGZuD8hhIjU2VD6mavc/YCxMDxuUfMjjUHt2g0Grb6r/ExjkB3?=
 =?us-ascii?Q?/DTj5Qke7jXhoXXv1GuN3jOI4phbsFqCsrtgKEUbiQcLTmvGTqRxeq6Uqktv?=
 =?us-ascii?Q?ihcIAqhxY76ZZdi6oKVrxt4rJxoT6zGOQWJ2EPGZ7DuhaZcUciI1EsEaEYBI?=
 =?us-ascii?Q?Tpx+4EVZSpW84AE2+u8s3aWRpO/iAThfnIzXxs8cJe3Pe/VtT31ZocIMMSja?=
 =?us-ascii?Q?7F/92NZIMPGVLkwu57k6Hx8M7U0gedLTO8Rziy1ZHDqDEC+pjV9X04Y+POYQ?=
 =?us-ascii?Q?u41txjnDUX7CLoLSwmi/8QBxQMKjO/IstFzc1O14yVZchH4xY+fu1xKJn5br?=
 =?us-ascii?Q?n9fxwycpmxFKMUjH7jGPufGl9wQtKfywmsJo4oD+2IoehZDJSeV/pyBrUXkt?=
 =?us-ascii?Q?4dx4d4cryDQ1l6o+/pgmf1V6sgebB+gwkPOT29SwNShm68JWkTMt8J7NpPRW?=
 =?us-ascii?Q?b/OGpp2mqUnFTSFi3ijis+/WWSa8MFS1DzkFviq1n24NeZtWthZblwNfSwD1?=
 =?us-ascii?Q?b+P9JUTotf6a8frGhVuo7wUrbU8rirQxhWuLr5EFlP6ha6Dy8owSzidz/Zlc?=
 =?us-ascii?Q?o69O8kbE+NMiQuKvFVeJaPxcrEu4Fy0F62FE6ii4yzelfMQfXKO1/zGHqtMR?=
 =?us-ascii?Q?3hvsIrlQHxwB+0+KudhG2ieonYSs8Yev6mFbAULfWdROatru6Fq/VZMEJFwR?=
 =?us-ascii?Q?PDrdI2VfDJ8CebhjEBc7KJoW6w+kT0p8ovQE6SjKQduOdxfDkSqMjFs0a6ls?=
 =?us-ascii?Q?bJZ+ezmdXAY79X75RI7i+I2nBOxCUaIP2EJBZelN+n0xxrSVmNMKqoKAUypI?=
 =?us-ascii?Q?84wtA+9BZDLYhaBZUg+3uRTq3P/zkM3RJ9m5kKrlIsV+3Y0Q8FtIrAIpRNS6?=
 =?us-ascii?Q?u0GhAjjNJSHfTRcfmA3nWsZSUlPKafR8BtFsvFF5ero6gna8WdsYIDqryhCu?=
 =?us-ascii?Q?hPxUVOfZL9rT1doj/qIlNOof7vpdbHOQz0KIbAiOdben9OWV/HFMpsvM6Ilu?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd2b3c3-da7e-475f-9c84-08de05b220d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 14:59:34.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t50Dvzgt7RuvIAIaHQYq0Q/rvUX6dk+lBsMAhkSM4HDXzrq4gDjYS+7xCt0G0IaRLSJo//spF1O5Ug4HURf2Wy0Ze9De41VhuJUjrO9WPuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7991
X-OriginatorOrg: intel.com

On Fri, Oct 03, 2025 at 04:10:26PM -0700, Jakub Kicinski wrote:
> On Fri,  3 Oct 2025 16:02:43 +0200 Maciej Fijalkowski wrote:
> > +	xdp_update_mem_type(xdp);
> > +
> >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> 
> The new helper doesn't really express what's going on. Developers
> won't know what are we updating mem_type() to, and why. Right?

Hey sorry for delay.

Agree that it lacks sufficient comment explaining the purpose behind it.

> 
> My thinking was that we should try to bake the rxq into "conversion"
> APIs, draft diff below, very much unfinished and I'm probably missing
> some cases but hopefully gets the point across:

That is not related IMHO. The bugs being fixed have existing rxqs. It's
just the mem type that needs to be correctly set per packet.

Plus we do *not* convert frame to buff here which was your initial (on
point) comment WRT onstack rxqs. Traffic comes as skbs from peer's
ndo_start_xmit(). What you're referring to is when source is xdp_frame (in
veth case this is when ndo_xdp_xmit or XDP_TX is used).

However the problem pointed out by AI (!) is something we should fix as
for XDP_{TX,REDIRECT} xdp_rxq_info is overwritten and mem type update is
lost.

> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..e7f75d551d8f 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -384,9 +384,21 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>  					 struct net_device *dev);
>  struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
>  
> +/* Initialize rxq struct on the stack for processing @frame.
> + * Not necessary when processing in context of a driver which has a real rxq,
> + * and passes it to xdp_convert_frame_to_buff().
> + */
> +static inline
> +void xdp_rxq_prep_on_stack(const struct xdp_frame *frame,
> +			   struct xdp_rxq_info *rxq)
> +{
> +	rxq->dev = xdpf->dev_rx;
> +	/* TODO: report queue_index to xdp_rxq_info */
> +}
> +
>  static inline
>  void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
> -			       struct xdp_buff *xdp)
> +			       struct xdp_buff *xdp, struct xdp_rxq_info *rxq)
>  {
>  	xdp->data_hard_start = frame->data - frame->headroom - sizeof(*frame);
>  	xdp->data = frame->data;
> @@ -394,6 +406,22 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
>  	xdp->data_meta = frame->data - frame->metasize;
>  	xdp->frame_sz = frame->frame_sz;
>  	xdp->flags = frame->flags;
> +
> +	rxq->mem.type = xdpf->mem_type;
> +}
> +
> +/* Initialize an xdp_buff from an skb.
> + *
> + * Note: if skb has frags skb_cow_data_for_xdp() must be called first,
> + * or caller must otherwise guarantee that the frags come from a page pool
> + */
> +static inline
> +void xdp_convert_skb_to_buff(const struct xdp_frame *frame,
> +			     struct xdp_buff *xdp, struct xdp_rxq_info *rxq)

I would expect to get skb as an input here

> +{
> +	// copy the init_buff / prep_buff here
> +
> +	rxq->mem.type = MEM_TYPE_PAGE_POOL; /* see note above the function */
>  }
>  
>  static inline
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 703e5df1f4ef..60ba15bbec59 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -193,11 +193,8 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>  		u32 act;
>  		int err;
>  
> -		rxq.dev = xdpf->dev_rx;
> -		rxq.mem.type = xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> -
> -		xdp_convert_frame_to_buff(xdpf, &xdp);
> +		xdp_rxq_prep_on_stack(xdpf, &rxq);
> +		xdp_convert_frame_to_buff(xdpf, &xdp, &rxq);
>  
>  		act = bpf_prog_run_xdp(rcpu->prog, &xdp);
>  		switch (act) {
> 
> 

