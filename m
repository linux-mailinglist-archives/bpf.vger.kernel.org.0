Return-Path: <bpf+bounces-39434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312369736A9
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203281C24C53
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9D18F2F0;
	Tue, 10 Sep 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKw3EHZb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D718D63B;
	Tue, 10 Sep 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969653; cv=fail; b=dpzRgwW9OGh7H1NxuMJk4gMUYZdKnR/1gQAizEypmGVZ15C2tUIFVX8mhNBQmPcpBoTdS/AbVthV9q0KHU43F+gil1U4DzbKAUITtF88ZFDB3Ut/fnFfQtQl/uEgK1xAOzI0NyUmJvamvyQ1ovLMgK8dXYmPV0JSDb/RcwBqzyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969653; c=relaxed/simple;
	bh=/+9LDXw+lpBanpbw/EjJQLxD1/RrMkgzQyG92DNCp00=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YjKeDD6rpqX41Ec4advLP+Wl7uqH81GEt2HpJeR+1R6Wjj2Rni+e/VrBEdR4THAbDmgiQd4CM7IjWZqL0+vxYXjD9Kx8FtxRvLPCsi7Z9ef3c+Q/cIpFIt4u40MTww9ZstfeAM/6u+2eBh42vSOGhRC9e3gUmdkoZo2kg6zi0jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKw3EHZb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725969651; x=1757505651;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/+9LDXw+lpBanpbw/EjJQLxD1/RrMkgzQyG92DNCp00=;
  b=cKw3EHZbfcVGz5oGnbcUjiVkp8uxdzOvBVvIj9D+vZdr1jev9FlZEByc
   IA1esmdUwZI7TEfUbolnXif5g5wsuaXz2RovQntdGk7dHGyQEP7iy7u2+
   66xvJOpK6ga1Sl78Mbx56tulxsTjNOPewzDnDUCnuVRhI15osZv86koJ/
   rQdj3+WMuVcvscN07rdruTQavP8mvHOBzFMs6Qy3Nao46cFacurgshjsb
   s25fxCye42HLUClZhKyGc+hU3HwIP+L/DaFNm2tWBOsLlKgqBDcxzDLqo
   nM5oRNVSLStQqvaq+5SuoNSjpfedcHPqKvknvWwR8+84rL9dmV7uhI25e
   w==;
X-CSE-ConnectionGUID: hfurtiW0RyWzOUn2qozEtQ==
X-CSE-MsgGUID: GrIqM4XWQ7agOvBQPK9Dlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="36058723"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="36058723"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:00:50 -0700
X-CSE-ConnectionGUID: 9P1R/5L7QwuGHM7rkAFlPw==
X-CSE-MsgGUID: egbP0RFdTuy6dFNFuEs27Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="66625653"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 05:00:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 05:00:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 05:00:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 05:00:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 05:00:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywPV5K+2js8GTHxwN8Cr6uC8xAe+GWuIw0DIHkbVpUGX6+Gzyh4Y3+B/WOyenEvtPdW635t0/m2p10dVatsZ8boAaT5jibNUrQ0ZtH9lQKrb6xGZopLsPhGRErCAZcZsxhbsEana8Yg7vCZADlLLc8lEvReCmjoeP/w73IVnUH/bITOpvf42d2jLMhcXzcbaFLMJ7h0DhSgHATyxM23jbFIgxcSCZbWJN5uM5pZfjJoPXFEbok7fagE4k7FxwMMo4X6ACCcZT5Oq2gVTEY4Iwu/KTPB3YfUWsooBFXrzQnvoqC/qK6Z2R/9Qjq3pjBAxOxEN9q7b/1F4zrzz1Y4SxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExJQ7cnt/mFIcJk+4fkVZMW26tySyrXIedACOZ70c8A=;
 b=t+DNQaBc7OPAUTW3siTS0Wb6b7KJ9U2XfCoM0LaQNWAAX3+lg+sbkRHxYeyll//lpvq+IfkG4uw1Aa6mOcrCY/2thD2S6JI/m5F0Snm2+JGNsDHdqplJ+XEU9Hd8VkrgFVKTQdBBCmD1ODxLxVoYsBF2vhlIh/Sw8EW15MXz8ihooFQ2oToCm0qLCN/VN04O5zM2KaevgnH9elFTi7nNy8EmR63CdwJ0EK1ktawWxNxzqPkB+8qXZGWzrHFNdFPhkA4u+lrm/L0XMxagVDV6UJx2T2XBzdZXYpXYIirck21cb34rostq7nW3r8WDPDvZYgqlqWsUDJ3hLtkBnhlB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.17; Tue, 10 Sep 2024 12:00:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 12:00:46 +0000
Date: Tue, 10 Sep 2024 14:00:40 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>
Subject: Re: [PATCH bpf-next] selftests: xsk: read current MAX_SKB_FRAGS from
 sysctl knob
Message-ID: <ZuA06PPYp2Jblg56@boxer>
References: <20240909141110.284967-1-maciej.fijalkowski@intel.com>
 <CAJ8uoz0BDJ=y-5M3=Wrz7F1LtT8AUVCyNh1G88SaKv+yEYL-Bg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz0BDJ=y-5M3=Wrz7F1LtT8AUVCyNh1G88SaKv+yEYL-Bg@mail.gmail.com>
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: b99c1c98-0234-4df9-1107-08dcd190342d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EIVB8qOLnhU5BDMeP0HcMuTUU6Bw1OHHpg2Peeb03QPjSCRVBT3KmN5oLIUT?=
 =?us-ascii?Q?+f494TcL9JKffnyEuqbuil8xIw2OIjTHbCgQbLFJlwrnq5LBUP4D2r3yI2zG?=
 =?us-ascii?Q?9TlbipcgocyeOYmMm8jcZKrbRasVFyIEhkQ4STc52IRkv5Nu2OcGatklp918?=
 =?us-ascii?Q?bt9DXWq2pgKtPh9P4Sm5hDw8A/136e/RUwjfH8KTRS644Xmb8nAiHEzYjHf7?=
 =?us-ascii?Q?hs584PFjRkyq4PUvyxKvZPG1tG1AyckZ8OmABHKjQVxFnOUH4A1gZhb1fQIo?=
 =?us-ascii?Q?S+FVtN3voSK1Q/xwL9CE07rBPTYrY+VPDTDPq9Tm5eh60icDs1h5sCHI8SFZ?=
 =?us-ascii?Q?FmSdNiAZCSGmf6vavuXedBM1yzQeSXsuzQbuYdfFi11cOOb1KArgE57r5zX+?=
 =?us-ascii?Q?YBI9WZdmCSn52FTCLXITA0W8z8q2LaKo+i3N1YTtwrFqlf0f1dkP72nd7JDn?=
 =?us-ascii?Q?3f7Vb8zJnxnEykKzPqKnEyT4WPTbjVv1P6L/caKuE1h8uhwswFSig/kVZA7V?=
 =?us-ascii?Q?8VhJv16TqHAlAZ0X9XTATNsuQuI6rYgjXo16vLwGYqYMYecxgBX+2KGTp5Qs?=
 =?us-ascii?Q?s7/a7oG6rJTFTeAeLVAx30EZ5I5Cthlfw5SWEiGsaWzQoI0AWM1vEzqx59mw?=
 =?us-ascii?Q?34v9CyNEi7pvg59zjJFSqNUyfILw5TUdoZgPOLoc630YsUtd6a5dHZxgfsA7?=
 =?us-ascii?Q?u5V7S4GywdWIC4Cusq26YXWPttcETRrXN5NG5ENXO7kub9KOi7hWfh0lW9J8?=
 =?us-ascii?Q?HEcboa31VRPs7BpLrBQB265cQ0bNGFe2xvHDlDL+jESrYXN2ztGt2+RzFiC6?=
 =?us-ascii?Q?9dB/A/8EdK1FrDeCdC1KbT/XnuRN7q5KRnvIN+Tdk4JdQnXfQlK8P8Bcn3++?=
 =?us-ascii?Q?ITN2DuSpevRXx4yGzW81lS2CYs541G9oTpLFlik/vCOegyvBDkFylEjc11LC?=
 =?us-ascii?Q?Ea6NO3cefDkg3eIDx3fuCHGm3Y08Rr7RzVzN3ePgcjVdXJ9k/HutkVqTjB93?=
 =?us-ascii?Q?bfL642kbkXV88cc8kyrpuItAUR27Esz2WpnAekvaYJCaLec9YLdyz9SUAH3k?=
 =?us-ascii?Q?jB2rKpqKlCjwrJSwY5Gb3vEmwqUoLEUWie1nBginb2DLLcd73f5rnoD8Us0H?=
 =?us-ascii?Q?lSvqcsPHEs4d5q+pVgsXwTZiFvJGV2VdV4//INFfsHe1xqiSXdEz4b81fHJr?=
 =?us-ascii?Q?JldbaFbbNQEVmgscO+LkykH/ZDM9mkU5NXtSI2D7xfQD8b//C2pc2r1YQkfC?=
 =?us-ascii?Q?q54igeNzdKtXnaLy1hqWQ9LF7IifNTcyjuPldWLefoyDoimchjrd5IvpD1tc?=
 =?us-ascii?Q?0t0yfgbRdcXmeTHIW1zJRKgn9pglSruB3m09AIYmlShacw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JPJlOAzHekNYEURlIvCFpPnG/AeGXPgvDUWyrGteH8sSd8+GgqS6WooGBt0r?=
 =?us-ascii?Q?JdYEOGpW69M0vQaYdsy9l6CZwa6Oggx8YolovSo4UchrexZviZADupk4PUug?=
 =?us-ascii?Q?HZYNChQZgqQPQDn7nKmGRET8foTpVeSKpW0cJ/2FYoeQw/OZVJvF3vRyhAKO?=
 =?us-ascii?Q?kyzUZeQN+c8qmP7naO2nnu/gRMeFTlGoN06KC/3gwNfV2TaRJhXk9v5s4ebG?=
 =?us-ascii?Q?/WoiqgW4T5tGoAkEjSRZAMCiJWmOrsWi5D/3pCuqRiVeIJlmFcBV0VluSI31?=
 =?us-ascii?Q?xzIV0j+PSYCkaSJlsKDs3MA+iFcSOxHg91945oLYb71CpPsOg7nLP9bJdJ2O?=
 =?us-ascii?Q?66Pjj/UGGc86hP4Pn6yel+cyb95i1I6NJZc1DivCh2ypfoZtjl+aaZhzkBzW?=
 =?us-ascii?Q?Pja/27/VSH3/eKGthuH7ZGA4Y7s2UnY9d3GU9xS2J8Yvo2347FZ5krfT6a0C?=
 =?us-ascii?Q?c0DQqqHGOuN9CKGLWch98Kdk7AoAIljwpP2oVnn0w9pmLa6gCTjDFkSxbgb7?=
 =?us-ascii?Q?VxwbBoqyNL0MpKE+7ZKtdJTvWS30I1CaCSh5cHhF5X/rOs/6RrQdZ5VwuVqO?=
 =?us-ascii?Q?XGoy5Bwvvmns/YXd7NCrFJuJVnbHbQgkZVKFKTvdNpYgiSw7HwdZ/FED/YMj?=
 =?us-ascii?Q?69MKKDJb1xLOFo5wQySr0B+S+YaxFSVsCDVkIdf7FhLJ/NkCHN5RZFvywf7O?=
 =?us-ascii?Q?RpTDH0iP9KAxwreyaIYX/mEkaBN52o8cKmjWv+1R/a+ZJoMbn3B5q4EbBNyK?=
 =?us-ascii?Q?63nfpajSdplXeWVav6GRNvkLxrDM90eAVp0KCCn/OtUmA25yVr3Os1+h/vfE?=
 =?us-ascii?Q?a/DeMFYzi2Qx2jCrl5Xoi68BoZwdnEJi68yYNYkW+VAjCMaJWjvRvGpVT7kv?=
 =?us-ascii?Q?CWQjynNTb1nVqkGPB0ec3YoI1ZLPbagfmD34mBXet4vnrSVf1g3dk6hZTLX3?=
 =?us-ascii?Q?ksD4Ih0e4ehjKSU66f0zhhc2Mve9tj+adET41gRemG3/M2+cez0DztQVEeG2?=
 =?us-ascii?Q?bBW3idDiBdZNp4loutIztCT6AeFvxN90m+LGQ9vpt22AmZL6bp1gt0JZdUU4?=
 =?us-ascii?Q?TJ9Y4CmXrVwPKT4kgBaZjhP22JxWIvUncHD5BAN1dEndaJ+RFeX6Qkt5jJPd?=
 =?us-ascii?Q?tqIxLSvv+LyjoNQrEFawufLBARlPGF5rffe/aGlYE5RZ/y/lJxV5ypdiL9ZE?=
 =?us-ascii?Q?J+C/UPesf0T52DTYtpPXW2znbUvdWeXZaCfY5+5F4cgCeZzUlXLeYTz1aQ8n?=
 =?us-ascii?Q?obbZQ1kIe+oHbxlHOSmJ6tmZ/Wp8vkPuE2Fd+384/z15TxjYKeDdVPoS/BzP?=
 =?us-ascii?Q?Ufl2c/jLr2RGQeH7LMvtHIOGbdgXACX3D/e2sHzAg1Zdmx9SvrYmb8j/i4KT?=
 =?us-ascii?Q?sxM4yHLyznyx7cA9IH1cLlSGoE1fDOvqBL4EZceCkemM4ysUe9pq/nUhi9ML?=
 =?us-ascii?Q?2Qra4SSlKlrGd6D9RKYtaKj0f6W3MdnhhcuCR0yWOBDtpjETF1kiXZVm/WDb?=
 =?us-ascii?Q?rv53zzDCr73EK/Ug2Blcwbpyj26qXUrY82W15ga0IobFYJO3h1JslmqVShAi?=
 =?us-ascii?Q?y6+juSz+LoZDZgDwnqUb0u364Rblhxl6KL1hylrHFqq+PSTGaU64XqcR6nMx?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b99c1c98-0234-4df9-1107-08dcd190342d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 12:00:46.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDNbcR+lTNSvKvqGSMbeJPxSdKjJegmtsUJlmFi3XKFZxazZUDt+3paTkTXHmU84YNZLziA+skxzcfcVsvd2PsvQUclVVNqOTSFrVpoh6Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com

On Tue, Sep 10, 2024 at 01:48:35PM +0200, Magnus Karlsson wrote:
> On Mon, 9 Sept 2024 at 16:12, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Currently, xskxceiver assumes that MAX_SKB_FRAGS value is always 17
> > which is not true - since the introduction of BIG TCP this can now take
> > any value between 17 to 45 via CONFIG_MAX_SKB_FRAGS.
> >
> > Adjust the TOO_MANY_FRAGS test case to read the currently configured
> > MAX_SKB_FRAGS value by reading it from /proc/sys/net/core/max_skb_frags.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 41 +++++++++++++++++++++---
> >  tools/testing/selftests/bpf/xskxceiver.h |  1 -
> >  2 files changed, 36 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > index 92af633faea8..595b6da26897 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -325,6 +325,25 @@ static bool ifobj_zc_avail(struct ifobject *ifobject)
> >         return zc_avail;
> >  }
> >
> > +#define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
> > +static unsigned int get_max_skb_frags(void)
> > +{
> > +       unsigned int max_skb_frags = 0;
> > +       FILE *file;
> > +
> > +       file = fopen(MAX_SKB_FRAGS_PATH, "r");
> > +       if (!file) {
> > +               ksft_print_msg("Error opening %s\n", MAX_SKB_FRAGS_PATH);
> > +               return 0;
> > +       }
> > +
> > +       if (fscanf(file, "%u", &max_skb_frags) != 1)
> > +               ksft_print_msg("Error reading %s\n", MAX_SKB_FRAGS_PATH);
> > +
> > +       fclose(file);
> > +       return max_skb_frags;
> > +}
> > +
> >  static struct option long_options[] = {
> >         {"interface", required_argument, 0, 'i'},
> >         {"busy-poll", no_argument, 0, 'b'},
> > @@ -2245,13 +2264,22 @@ static int testapp_poll_rxq_tmout(struct test_spec *test)
> >
> >  static int testapp_too_many_frags(struct test_spec *test)
> >  {
> > -       struct pkt pkts[2 * XSK_DESC__MAX_SKB_FRAGS + 2] = {};
> > +       struct pkt *pkts;
> >         u32 max_frags, i;
> > +       int ret;
> >
> > -       if (test->mode == TEST_MODE_ZC)
> > +       if (test->mode == TEST_MODE_ZC) {
> >                 max_frags = test->ifobj_tx->xdp_zc_max_segs;
> > -       else
> > -               max_frags = XSK_DESC__MAX_SKB_FRAGS;
> > +       } else {
> > +               max_frags = get_max_skb_frags();
> > +               if (!max_frags)
> > +                       return TEST_FAILURE;
> 
> Thanks for this fix Maciej. However, I think failing the test here is
> a little bit too drastic. How about just returning TEST_SKIP and print
> out that the max number of skbs is unknown as the reason for the skip?
> Or even more optimistically, print out a warning that we could not
> read the max number of skb but we are guessing 17 and then run the
> test? If it passes, great we guessed correctly, but if it fails we are
> not worse off than the current code.

makes sense to default to 17 if we couldn't read it from file. will fix in
v2.

> Do not know how often a file
> system does not contain /proc/sys/net/core/max_skb_frags though.

A mix of CONFIG_NET, CONFIG_PROC_FS and CONFIG_SYSCTL i think.

> 
> > +               max_frags += 1;
> > +       }
> > +
> > +       pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
> > +       if (!pkts)
> > +               return TEST_FAILURE;
> >
> >         test->mtu = MAX_ETH_JUMBO_SIZE;
> >
> > @@ -2281,7 +2309,10 @@ static int testapp_too_many_frags(struct test_spec *test)
> >         pkts[2 * max_frags + 1].valid = true;
> >
> >         pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2);
> > -       return testapp_validate_traffic(test);
> > +       ret = testapp_validate_traffic(test);
> > +
> > +       free(pkts);
> > +       return ret;
> >  }
> >
> >  static int xsk_load_xdp_programs(struct ifobject *ifobj)
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> > index 885c948c5d83..e46e823f6a1a 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.h
> > +++ b/tools/testing/selftests/bpf/xskxceiver.h
> > @@ -55,7 +55,6 @@
> >  #define XSK_UMEM__LARGE_FRAME_SIZE (3 * 1024)
> >  #define XSK_UMEM__MAX_FRAME_SIZE (4 * 1024)
> >  #define XSK_DESC__INVALID_OPTION (0xffff)
> > -#define XSK_DESC__MAX_SKB_FRAGS 18
> >  #define HUGEPAGE_SIZE (2 * 1024 * 1024)
> >  #define PKT_DUMP_NB_TO_PRINT 16
> >  #define RUN_ALL_TESTS UINT_MAX
> > --
> > 2.34.1
> >
> >

