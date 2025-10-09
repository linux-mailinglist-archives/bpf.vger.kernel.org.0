Return-Path: <bpf+bounces-70662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD27ABC9806
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C697819E5F7C
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5289A2EAB70;
	Thu,  9 Oct 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CA7RhjaG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E1252900;
	Thu,  9 Oct 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020092; cv=fail; b=Y9liXHCNDuN8eH1NQT10DP/8m/CpdEqvELXW9aQcFgYQ+7gN5jdpJ6YCX/vGlZ0N8dwYSokTwXEtlgscX1O/5PU982eM3EG42bwn7XiOfuh3zKp2fA5J3Crq1cookEE/4yp8llR3khwhHyNt+qjSPjkmuFFRH2w9Gf7V8PGSOUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020092; c=relaxed/simple;
	bh=4vI3A3hjLPQfxrceTFJ4Qjz2xE8O6pazBlAf0/cyFRE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UEj66+OC0pJ3eQQ8338db1rwWx7L70epF9QOL8vsBI5IVpZz05JMYScO8EJLhuSWTY9r4mChNpTP+R5f+ZQxveV7Ybj/mEXv6C0JoyDFl4bLHKPhBVt/OWehQa7Lb6UrKGlBEdyKUWB7cIz7BfMtpnD8rm1Xh4HcBv1RIFzDMnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CA7RhjaG; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760020091; x=1791556091;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4vI3A3hjLPQfxrceTFJ4Qjz2xE8O6pazBlAf0/cyFRE=;
  b=CA7RhjaGQ5KKH7+1E4aN+pXzaDx4C9WwtxmKIPJFDpgj8KoiBusq/pGo
   sUjEfpeldNZcm2rgkyzoegxXWsH5Vvluw82/KilE949rI90oBxzED+36N
   2JQsGb+MAa4rK6gFJ4Exn6EvRAX1jPmhC4ZdquLnbgJ2nOKWxu0a1obfn
   0p8vM0n+etEDTcEkOHvc7IcanjMPPU2kMAbw0zPyMmmOZ9Cnt8cs1A07h
   wmwSsjWE9th4xOXHwZ3dL98Lmg7LGN01+50I7kY6tuoBkc+ZU3UiP5WH9
   nsjn9xcAgn+xn5UEtF9wZ7TK1CX/S5w0thf+LtAnPIRAryc1KHkcfghxR
   w==;
X-CSE-ConnectionGUID: WJsLg6ePR+uKFmwky0ALTg==
X-CSE-MsgGUID: 2CUF8Gf9RWOWa3fVlDEOfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="61938114"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="61938114"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:28:10 -0700
X-CSE-ConnectionGUID: nAYPfdfnSyuFj5sT+lNIZw==
X-CSE-MsgGUID: HSolZnbWRJ+zCvlNtEohYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="181145514"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:28:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:28:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 07:28:08 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:28:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4iRo4P+WgXyhorT1D1jVUsLXoKrvnEiPGxjPzFofL9JosG48FoiIuN+l6KTGAO1NNmVpWM2MJQoZimgHWL/ET/Lf+BfMGahq8EBldJrf1IVyMHkV2J84pFR7jAwm/Tuiv0OqBJAKh7nKR3MNeMeIblg8PrOi8uxuSVYGsZFQWksfAy4pgQqXmOv/w1z11an2Er+0Ah+MQEL0UGZ2+69cUxDu3h/VQJnIl6y0Y/hJSUVLj5h5hVReYQeeT9Haz1LYe1eMecrJYopSRzZe9QbUtHqAqInkUpJRpIJjkJY5GEboQUDblHFfUUtJrtEP+j/YTgHRSX4NANqkKD+9OM7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV7EvpHaKdUHYrMtnP8WdzH+05rO5taFaXTBPrmj0N8=;
 b=lUg4oZEQQjIZ4HVdt6a7ZXS05zXFwCEVONTNK+JEgbpBCfFWCAavNGXT7dslE2468bs28QkcLKVXZ2fEBVboRm0Nl+33HnrqHQYU/0nBsGfC+aQNCnzKDhIt338Jplr90FL1XZKqhKndyFlksfJzRIs5ciaBuS8osQKjQ936oBBPsbbsTWWgl56UFnS3nSA+lPfSVM+Aea5TV/GwGltoMileWOFiIZJl/azxJ8uDxE56KWij4ssVS5sW8loyQfblcRNGPBIMBO8CPmbaDTAmy0CISvcQxXBonQkCQld3w/ZpcjajLkUaVzSyBzhKwpVzsTowH0MZjshRdwbuEADltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 14:28:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 14:28:06 +0000
Date: Thu, 9 Oct 2025 16:27:50 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>,
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: harden userspace-supplied &xdp_desc validation
Message-ID: <aOfGZvSxC8X2h8Zb@boxer>
References: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW3PR11MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: c690403a-4e1c-4f7e-97c4-08de0740101c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OJE6PiXuA/aKNqtAum9q7BtpmInPOZ4ZZb/8NA8c9YMyZqTP+d1mgsuOnOsP?=
 =?us-ascii?Q?SqoKxUvDXcM5l3MuU+kgsUEMZE6iJ4q7pdkn+d4m1G/90dommTvqe/plxUuZ?=
 =?us-ascii?Q?vFMPulCc/Z9i/IpOldWKW9AUOUgtKYULUsEcxTags1+HqaYTYYN3H3VxpjCN?=
 =?us-ascii?Q?ZkiPh27b2TadMwMSxE4FjiV7zPRDY96gbLTYKBg2P7asS6w24FNEOAcvvN8y?=
 =?us-ascii?Q?B1l/w6nwXnI7SbZ/RDUoucJiprV6laBIRMBNS2iV1eJtTMcDYfpbVnAO6VCF?=
 =?us-ascii?Q?bnYHF/ciUZ/2RLnHPbcG2wYEi6/Ol0XhDMwLkiF1gFG2W/cUCN89ajKU/eRU?=
 =?us-ascii?Q?Rh8lVoFr69pD/95/w9ljVSgzPSZW7uHDUQQWwOAUIPaJaDjvVnELFkroTRdh?=
 =?us-ascii?Q?GUO6qHDvkFgv5LF2cPoF9jupt+s6kGEHS/mYpXw5xTgOZV4bSnOGKpsx65rI?=
 =?us-ascii?Q?hRbQzHqtzt/ZI84HAd9VeiSNZjmgOoTc9JxDHPW38O3jbaNBtYaiGn3AROwQ?=
 =?us-ascii?Q?HG7Uxvl9SGQUvNaERG/c8B1Eu3fqVQS9+xPKSNRo7Z4UYjWRmKzaB3C2/QDN?=
 =?us-ascii?Q?GxCuyqGJL+4Eh6cem+rlx2sK/BT6dXANsSMNhcrae0yu9q0B8aaC14cTS59F?=
 =?us-ascii?Q?3ggRldZrf4TVT0jvinE53k+4lfdnukf2wSUtnfaeS1j0mV1a+2jazK3Ur70E?=
 =?us-ascii?Q?BcxwQtClISzma+zd/KJy3veszwU02Pf723iBkR+2padLPRUBRtSbSXH90Wqm?=
 =?us-ascii?Q?dprMH13gCz9UYjQdRMcV41+jUNNszmpRQzbGsjYha8dx/XVGYMvsw7RcJ1HT?=
 =?us-ascii?Q?ymPVj15obgBdLe/3vXmgGdFc1bCXkdOQISed1tmK/8sCZ9Ysn3j4keoA/SQM?=
 =?us-ascii?Q?AdYQsvmmhhVLqDcBWOxgwUxqa8M5TzrhtclXPZnTcdSIqARifrtM53YqDqig?=
 =?us-ascii?Q?T5urDAW1/Uq2Sa8ja3EWb4yG8LYqEGfPaEN60MNAOIEbZ8xjqOhGghIKriB1?=
 =?us-ascii?Q?ytxZHAM+/0Gzru+kQs3o95kz9Rl0ZfEUZSBnLdx0SJFcXHhoa1xCnZ1YoQkA?=
 =?us-ascii?Q?b9sOIEzm7YRJhZXxM7v0b5/bgtmXn1LRFB6Rz+IBtkmsnmKHtPempd+gPgoS?=
 =?us-ascii?Q?kwjzwa8cQWyFOYTlTzVhFc7Ym6+jSGuO9QZPVP6ybmEcGikXiOwwKrLuPnAf?=
 =?us-ascii?Q?fnb0p+TM1iPTFmE9JvCzPB5ZgzAFzbENy8hABrdZON2/tEjtkslN5lKNEPz7?=
 =?us-ascii?Q?+kDY4LVrDp6nwkMQhmcaVogCJdKAf6DgWZ9Ki9ikPeiobMsROrSyb8V40OY/?=
 =?us-ascii?Q?MC+Gy3MxEumzti/s4KPurvfL0HRwkuUwqz1I157rKdzkusJ3QxWPPm74ha9N?=
 =?us-ascii?Q?i1Zl9HocfEtuQd44LgkatCo5tFvQh/RXaWKF26TTBdyg358pOkSN+RiLD9eK?=
 =?us-ascii?Q?vZRAXKSWMxojt6QKrV7nC2nakzsM6r1u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WBiK3P1zeEUlyyE5OR/VoQbDG7u70A6XS4XJu+rl8W5C/5fLfw3hk5yswEYO?=
 =?us-ascii?Q?kPduxTAY/s80VVWH/g5UJ38o3ZGo03OYqB0YgyEqlIKSn1rzkCrYggeD5ZnN?=
 =?us-ascii?Q?b70hM9ifFwohJHmfncvWkwfmeUtPpXEDEAY7K5L+O1iggmdjCDr3PP+mFv4I?=
 =?us-ascii?Q?ppSxXJUm31MMIXR0RKFAJspqOwu4FrVcysanxigAryaszTqIK8/w9Rv112n6?=
 =?us-ascii?Q?S8/R2IfxxvbNbkY+ZZcgObtd8xFQ5HPFvB6thURwocyw8044NdfvsaaYrQDw?=
 =?us-ascii?Q?qTJMUntWYTSvlhRgy5kwXrN/kTwV1f6TEx2aAVR/2vHPcxU+zhU/O8RvBhR/?=
 =?us-ascii?Q?hrwobQd6AdOsUtz4qI/DWulFWF/sjgC+X3xmJd8vdJhaJraIDIwPkAa+E2hF?=
 =?us-ascii?Q?/Nh+yUh2RBU5YHXCzlUyvDfTREWA+N5pJpzUFAEeJxfhU9Tz/RqFUF/x7YWk?=
 =?us-ascii?Q?6TlMI+PgooMJVRGMxXKCmAXfUP1To7ngBBO6rsttGh208zuAMbpOWHLtSUQ+?=
 =?us-ascii?Q?ramUbqXK8dOY6ew7S2txcPj6quv2s28DsqKaZqRHES2eRxrmucVywwDYFaZa?=
 =?us-ascii?Q?cgCd298FPIJIPYGu0tY7p/xyOWMXNk2iaMV+Sm7stIxSLEQzKfv8Z5KaDAnP?=
 =?us-ascii?Q?5brzZxLT12Sf2X3G07iVbhfY8r2ncR1kelDRvq9ra3OLNFgsBQEupV98RRSJ?=
 =?us-ascii?Q?nKo+2XTwBsGUj1tt2OvSCGlrWg9Vb4Tb3LipDL7Y1FJ8hAiWbBsBfFbZPtMw?=
 =?us-ascii?Q?Szy2wy057W96ILEOFlvLjHDSDQ0Hfu/dsSTFCshrr/w48vs6XrPRvV48FzMq?=
 =?us-ascii?Q?TzgGJRfMfKKBfmtnoEBzEkefL3HTVcuJMjz8mRTZOa46+19o4ZyvCq2RH1ZC?=
 =?us-ascii?Q?QrEbnvHyQ9zNdp+iW6jNj3u3iGbNAJKCd47FjbvXLGoGoA+YkijMcQVfbYlb?=
 =?us-ascii?Q?OlxB7LiV9oH5rnKm2WfPh/Oz0m9CuNlbQ42QhQIR8AxdExBVxSe0Ou0ZI6Un?=
 =?us-ascii?Q?3n5uyIXBoHsdYsHzMbYWkbgQyANz5m+hPfi52RkwN9Dqlt3l/YoJbFHTFjBH?=
 =?us-ascii?Q?2nMEZJqI6BPnl0VQ3/Yk05DOOiiKYYGUCQTjdPjyzhT3PkAvt3Bw+2mdCoB7?=
 =?us-ascii?Q?qY5FH34h5llAjG+qvOiOvW0r7PC9ZviJ+ImeiFy8BDZGHRp0fBOzXJrSyuHP?=
 =?us-ascii?Q?9iD64th19QPA1EVQ6H230HX+Le23a4Ot/9Hzh8t8wKV+hdLis0lf/yj9oUau?=
 =?us-ascii?Q?Jq0p3Rcr18q0iaDaqFS5yII9WRV/T2euAyi8G6dgm59VOOHZKjWakagTFxmh?=
 =?us-ascii?Q?n55ornU3XCLzY9bfQ1OPiyB/VGWYgUg1/Cku55L5wd+0sJA2ibQg99OCGrwI?=
 =?us-ascii?Q?DlxIaGd7pDBciaWhKQjfn8nhR949yzo5q/ljqKfdiAY9vyQ5LHfhPqbbe2OT?=
 =?us-ascii?Q?b9jegz3lIjUExODBUhAUgNBcbGc26ngs+YKaSO3OCtrBXlOmtDCliQGWEmhF?=
 =?us-ascii?Q?k5e4cAYeh+HE+gM9USc85jF7QjpmJW2syKBTJ8Zcvq2tetuCpHY0A9NxM6Bv?=
 =?us-ascii?Q?zn45VszBOA5Nl9x2SzvRTa+DTxB6GYlBj6wqsdtodK+CEj+MGd9ZU9grc8xJ?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c690403a-4e1c-4f7e-97c4-08de0740101c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:28:06.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NURm+GN8ayEccErZfH1sThUcg0SNFhFdql0UrPPBCT0RsNLed6yC/P/DTI1NPuyLYMAdFfbkmEqeHjjDlz4KnJLunZVtirv4xhSuabAt/Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com

On Wed, Oct 08, 2025 at 06:56:59PM +0200, Alexander Lobakin wrote:
> Turned out certain clearly invalid values passed in &xdp_desc from
> userspace can pass xp_{,un}aligned_validate_desc() and then lead
> to UBs or just invalid frames to be queued for xmit.
> 
> desc->len close to ``U32_MAX`` with a non-zero pool->tx_metadata_len
> can cause positive integer overflow and wraparound, the same way low
> enough desc->addr with a non-zero pool->tx_metadata_len can cause
> negative integer overflow. Both scenarios can then pass the
> validation successfully.

Hmm, when underflow happens the addr would be enormous, passing
existing validation would really be rare. However let us fix it while at
it.

> This doesn't happen with valid XSk applications, but can be used
> to perform attacks.
> 
> Always promote desc->len to ``u64`` first to exclude positive
> overflows of it. Use explicit check_{add,sub}_overflow() when
> validating desc->addr (which is ``u64`` already).
> 
> bloat-o-meter reports a little growth of the code size:
> 
> add/remove: 0/0 grow/shrink: 2/1 up/down: 60/-16 (44)
> Function                                     old     new   delta
> xskq_cons_peek_desc                          299     330     +31
> xsk_tx_peek_release_desc_batch               973    1002     +29
> xsk_generic_xmit                            3148    3132     -16
> 
> but hopefully this doesn't hurt the performance much.

Let us be fully transparent and link the previous discussion here?

I was commenting that breaking up single statement to multiple branches
might affect subtly performance as this code is executed per each
descriptor. Jason tested copy+aligned mode, let us see if zc+unaligned
mode is affected.

<rant>
I am also thinking about test side, but xsk tx metadata came with a
separate test (xdp_hw_metadata), which was rather about testing positive
cases. That is probably a separate discussion, but metadata negative
tests should appear somewhere, I suppose xskxceiver would be a good fit,
but then, should we merge the existing logic from xdp_hw_metadata?
</rant>

> 
> Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
> Cc: stable@vger.kernel.org # 6.8+
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  net/xdp/xsk_queue.h | 45 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index f16f390370dc..1eb8d9f8b104 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -143,14 +143,24 @@ static inline bool xp_unused_options_set(u32 options)
>  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>  					    struct xdp_desc *desc)
>  {
> -	u64 addr = desc->addr - pool->tx_metadata_len;
> -	u64 len = desc->len + pool->tx_metadata_len;
> -	u64 offset = addr & (pool->chunk_size - 1);
> +	u64 len = desc->len;
> +	u64 addr, offset;
>  
> -	if (!desc->len)
> +	if (!len)

This is yet another thing being fixed here as for non-zero tx_metadata_len
we were allowing 0 length descriptors... :< overall feels like we relied
too much on contract with userspace WRT descriptor layout.

If zc perf is fine, then:
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

>  		return false;
>  
> -	if (offset + len > pool->chunk_size)
> +	/* Can overflow if desc->addr < pool->tx_metadata_len */
> +	if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
> +		return false;
> +
> +	offset = addr & (pool->chunk_size - 1);
> +
> +	/*
> +	 * Can't overflow: @offset is guaranteed to be < ``U32_MAX``
> +	 * (pool->chunk_size is ``u32``), @len is guaranteed
> +	 * to be <= ``U32_MAX``.
> +	 */
> +	if (offset + len + pool->tx_metadata_len > pool->chunk_size)
>  		return false;
>  
>  	if (addr >= pool->addrs_cnt)
> @@ -158,27 +168,42 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>  
>  	if (xp_unused_options_set(desc->options))
>  		return false;
> +
>  	return true;
>  }
>  
>  static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
>  					      struct xdp_desc *desc)
>  {
> -	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
> -	u64 len = desc->len + pool->tx_metadata_len;
> +	u64 len = desc->len;
> +	u64 addr, end;
>  
> -	if (!desc->len)
> +	if (!len)
>  		return false;
>  
> +	/* Can't overflow: @len is guaranteed to be <= ``U32_MAX`` */
> +	len += pool->tx_metadata_len;
>  	if (len > pool->chunk_size)
>  		return false;
>  
> -	if (addr >= pool->addrs_cnt || addr + len > pool->addrs_cnt ||
> -	    xp_desc_crosses_non_contig_pg(pool, addr, len))
> +	/* Can overflow if desc->addr is close to 0 */
> +	if (check_sub_overflow(xp_unaligned_add_offset_to_addr(desc->addr),
> +			       pool->tx_metadata_len, &addr))
> +		return false;
> +
> +	if (addr >= pool->addrs_cnt)
> +		return false;
> +
> +	/* Can overflow if pool->addrs_cnt is high enough */
> +	if (check_add_overflow(addr, len, &end) || end > pool->addrs_cnt)
> +		return false;
> +
> +	if (xp_desc_crosses_non_contig_pg(pool, addr, len))
>  		return false;
>  
>  	if (xp_unused_options_set(desc->options))
>  		return false;
> +
>  	return true;
>  }
>  
> -- 
> 2.51.0
> 

