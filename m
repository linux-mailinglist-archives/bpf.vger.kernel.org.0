Return-Path: <bpf+bounces-41121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1EA992CB2
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 15:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F681283A0A
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0DC1D414C;
	Mon,  7 Oct 2024 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdPS39y4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410FD1D3573;
	Mon,  7 Oct 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306594; cv=fail; b=rkDBieJETieXCKESaeAeCQ6meIuk6vfal5guBLCskW0bKc1NWCquHxAP65qZHz0gHwCgOhT84tGjhCBi6JbK7r1vpQ50iVJvvemQOxRcx6f7ZOLJn93Lwwez1DNqDqh6Mgn0NlNXJqCZdfVEbsOn/S6/XPmzKsfLXnP0nbK+e+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306594; c=relaxed/simple;
	bh=nIGCtSHmy91i+Jy3SeKVYQ6Xm/7vG9LbgHCh15Snm2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YD30ePhnKvTNmCwSVdnZRahPNG9S6awX3buY5hHlWfDuiVCM5qU0gY4JYrETo4vzzFXte+yDrqmccmFqywS5PHaaC9+eFrpzjD2lumpje8+d0Rh7wMjwQ/ALImGYH1X9KnzPSNc/rMspcR3jzpojK1rCuH9vfWFZQcKP6OzhOdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdPS39y4; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728306591; x=1759842591;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nIGCtSHmy91i+Jy3SeKVYQ6Xm/7vG9LbgHCh15Snm2o=;
  b=gdPS39y4BCtgpbVn4xnv3EmFcggOvQr3fAJl41HP6di2evxvo73BHggO
   EE31FwTJYLkVuFcZvuq/BTF3NykU8teZp+DYxg1Gi9YULcv0v2Rnn5sKl
   R9/SZ3vcrL3TjOSniAFWJRg4kHcHWHFsnqSQ5aaORbWbrIIi74SUuyiq3
   LCwXmkE/QIM2LQqwRTP3eEKaSoRCLK89HDJVcn88YmSI5xULPnBqPwjqQ
   5xhwVCogQkDJ7cvoBFQAcFauSz0bN9TnL3fEMKM5uylqW+VpYeQBqq7tS
   64Xvlv4UxvY27ZzGfxC2+AI2qOvbVSfmHsXHMrmSjdzG8zZNSgw50oz22
   g==;
X-CSE-ConnectionGUID: 64QD+zE5TOuwGTVt/60H0A==
X-CSE-MsgGUID: GZ5GiQQOTkizg6I/qQhN9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27392585"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27392585"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:09:49 -0700
X-CSE-ConnectionGUID: Kh79lBg8QhW0/FiqSA6FEg==
X-CSE-MsgGUID: aQ2bkyLoRuyKfRFcHRL91w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="106215833"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 06:09:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 06:09:47 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 06:09:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 06:09:47 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 06:09:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdBpWw5tjzPHrr8K+awE0mxcUsjYCl6pi7KfLk4x2AdU/HXgNU8crhtz0iSVl0OYbd+FtgaIHneVCiHdertpvexTILM5wmKnI9TVDqZaR2PAxN3o4WU/164eForEXQCVOT/ewNkzbjBoM22QQp2b67NDLTcOkEeH9dnZGlFsI7HXEYVSjso/WvvC10gHDe0pAa3w1Xsvk1V4+VsfPAtGstRbhyj8PNJFFgVYBJXSMRNxpVkAXM3bJVxfiCXH50PZVugSD42qDrKgjJl95x8/UdwphBKsASm3M+UhE9NyeC8wMrmPQN0gCqO1AtaQ0e+St+1jjWBLx9PrWoNcGU0TpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib6SLJ3TzSNU2CaCUEZlJu88J09LMsaWoUmVNJc3nOc=;
 b=K5DRMCCN0yoDuIbFSYG6cUy77M9lxNRe7DcxNipMXXplNReAX1lNG1yBsZFznloEVP95ye5QKuxW/5XzM8B4aSCm8Afmq3xrPYHiWCnHSlznL2v6PC201L9NCQxa/EQM6tiUUbIDE986vaqWcTcE66GOVk+aGY7lvJ/NaovpXBXb1oIl9DZzfZZR4BAgGXukKC6EgXnxBPbKxzv9gaRbHAhUD68CJz6d5Ndwdy0bKSPXYz3RSQroKWUZ8qH/RM8csxoerpbfUJfyknztPHV/por1riLT6gDAisDXTrnlEbq3guVs9hD8Yzegpcq9JiENjHs3Jo77W1ZJJL+nrc71AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB6987.namprd11.prod.outlook.com (2603:10b6:930:55::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Mon, 7 Oct 2024 13:09:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:09:43 +0000
Date: Mon, 7 Oct 2024 15:09:36 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v7 1/5] igb: Remove static qualifiers
Message-ID: <ZwPdkPB1z4CiYCBH@boxer>
References: <20241007-b4-igb_zero_copy-v7-0-23556668adc6@linutronix.de>
 <20241007-b4-igb_zero_copy-v7-1-23556668adc6@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007-b4-igb_zero_copy-v7-1-23556668adc6@linutronix.de>
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a876c66-3d0b-4ae4-bed6-08dce6d14f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X46LYbreinsyrsyMBkvbMZzZeA9NR8+i6sjHeu6su9P8hyaFWcBXTyiarOnu?=
 =?us-ascii?Q?OL7VDHWnBQ2VfE/OdmdXxsYrRvY2YXnomwyrkOMhIKOxpV21Kzp4y4SrMi9F?=
 =?us-ascii?Q?J+Dopt+WHspt1FFv9xwOLLCyzSUWBSsOkQAJdn2pFyFR5OB3aoiub7nS2L8Z?=
 =?us-ascii?Q?R4FGPy4FPQ2j9z5cdPnSBN65Od8lop4d7LfRw5HZpgtHXBDdZvQf3PpcukPS?=
 =?us-ascii?Q?5AgveZaWPPmYtAK1xoR708fQWXY3wYUjmqGsE6mbg3ldvY6OYImD/KTv5Qjn?=
 =?us-ascii?Q?wjDi5uxowFinZKSeTv+iaJ4O35TDKc9FGr0DySGt/6nedWm2IpwN0dwqRk4P?=
 =?us-ascii?Q?oKAwA3YOy/7gMrHvxY9pPnZx4pFEEG0Su/yd0KmJx+copQDjXPxe1711dZve?=
 =?us-ascii?Q?ddjCbf58qObcWDioUxMH+KiulAo1Di2KYFTJucI30voQG+Hqd/GuOjkO3lKc?=
 =?us-ascii?Q?8e1KAHmmzCZ4cKC//TTUjnaobmS/7fSUM791xZ1KtT7Gs8GSV6CxXymcshKu?=
 =?us-ascii?Q?8aRw4Zp46bYpHMwFaZwAX82UBpqHGLQbKpr22WbQX7efjHvRqmW/b10RmDdp?=
 =?us-ascii?Q?VQl/mPbLSDkrtF854C2LP90hAwIQqkPSOoyXlXXb7DGowV9p1otu/o16A1Xq?=
 =?us-ascii?Q?tIOa2iG4ZxzXZua2a04F30x35/MdzxJsF2rFofz60CTNoH4NmcOQNSZZ3Vvt?=
 =?us-ascii?Q?IE1jNZ4P0Qlfrl+o57dE8FdMSv7MLGbeO/lMu40d4GcP78UByAi8UyshNQvm?=
 =?us-ascii?Q?jPk4Tth3EIVBsqJscGfGQmlsOFV0Tdf2gZwWGjF8Lc0xcZ3Jf4V1sSmXtyMm?=
 =?us-ascii?Q?DHX3Gzgp+vY42Qm/ttsFMabMEMN7+skBVO/OcAEaGSenAfIVsmtT5/e/94hl?=
 =?us-ascii?Q?3Tccu5QOSKJqXYI6S+/rE8Q56gGJGNc9njPnhIQCG1s83c2dYIBHhkYzJdVp?=
 =?us-ascii?Q?rI+pVtGvfehDmINSw27Hva9PtPhrFE6r57HqvRhSybuCLomxVkMratqgmZ3J?=
 =?us-ascii?Q?B4tYvDBy3JPGop05IKymBGWcDrpIAaOj/EvJPCrrpscz67FvnJHSGLJ+FPEM?=
 =?us-ascii?Q?F6s2fg0/QJWCuHV9tV01y4X1d5KZY0yNSmaRmsGWpIAXs5YIx1bt0FUB21G8?=
 =?us-ascii?Q?OQCBdJlj9QyoueUvSCZUJnyRzq8pBeczYNdjUE3bbFwF0n71TatsBw/mWtAr?=
 =?us-ascii?Q?J2m+K5EzEs6G2zs/rGh5WVzQbLr9u2CiqqxT7m2bRc5klrD79HmVtBxP/aIT?=
 =?us-ascii?Q?AY+4pkCVtYMVhyDY9NCBuKqCGmrtL5ZdmKVO559ixg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9h5NetQvOLxvXlgRr+gpkcl0CORsKL3Gc07v2p9mv6PUI/0n8BhTfBq32P9L?=
 =?us-ascii?Q?UCvJtZhNeMlDXqbdUjdALIoBeRDpPjR/er2jjs8juhHi+dlyXEBNZBl7FXXc?=
 =?us-ascii?Q?bjKb9CrbHOLDpCcg9KDsKfFJfdQR0o9TgRBJwGMm5ZKp4zaz0O2iR/67YZu2?=
 =?us-ascii?Q?T/FwNDtxAHUw3TOgZbOvzuSV5x9QdC8nZoZq3zqCmOGSkGKFCr2/Io7Ywf6g?=
 =?us-ascii?Q?jfAJUX81jiTjiS45YtCiLMFZDx4XRQjP4J7v3gNtblDo+D1YUSX0OvLilBQ8?=
 =?us-ascii?Q?HG0kR4a0relNNp2fg7eTY4J2CLoe6vBYG5mG4ovkmqh/Qnqs/FoP8AjHEQf8?=
 =?us-ascii?Q?G82ltzsiTf3ufDkbpBjH39NJPKF7EYaHvF4kwnU2TeLv25nPePHf/x1iGHrp?=
 =?us-ascii?Q?eHYlmrThQEGQfdfvR10BvaFrO55ZWrFK3y24g6W0S/co7TnwDamYa67fpxBk?=
 =?us-ascii?Q?Fbqh7ajjlPx/7qPFGrCJsdyQR7ARwz6aSCQF0CN5ec4D9i80CCx0HL2g1dDh?=
 =?us-ascii?Q?r1+47qSg49Vm4TANtNmLQ0GRLZvHv/NbC91ev6H9nPgoJ0yttnamBp6K4f4D?=
 =?us-ascii?Q?3pGAJedWA9VR8Lt9vcay50b7vTvh5oKitJVSjZToLjHZStq0klQ08YJGrnhG?=
 =?us-ascii?Q?7coU39QxpkrfH9EiDdSqjoPQYyku89Ru3Kpc7VTzYEAVWCUN4yoITOqt8sGG?=
 =?us-ascii?Q?313JiFA9QQZFzdxBXYaqHMbAJDkc0+bHmQsJyS0w4M26Tk8pT5d958/xlRuS?=
 =?us-ascii?Q?Wj9iQZkU2hZGeY2fQWv9fuRIhe9TKpQiqtwzKkOzUHPbTfweI+ysO0S0kTHL?=
 =?us-ascii?Q?gBZ0RcMLE3fIWQrZY1V2JdI9REQN5a7LVzNvgMbvzpmXHli9c2P4KvjN4I1Q?=
 =?us-ascii?Q?t78OSMk6i2ivPifi5pnI0F9zZV0w9GxL0LWILiydU/3rHcaboducmEn1QlwG?=
 =?us-ascii?Q?X+A1x7oJX13P1ADbuDMfO+N7vq1CpBz3yh/8s1onGJCIrTY2OtTv3L+YvQcY?=
 =?us-ascii?Q?Wb+xtgKPWP1m5T0ll+d25eooMyEn8ZeTqKR7sMueGQOMes51+8XRXc4on7vs?=
 =?us-ascii?Q?Lp34yauuuuDS7Ay3wriWBZTsoLs1tiGccX6/9GPorpkIzpkGwnX+mVCvUiGw?=
 =?us-ascii?Q?E/ROGPF0tTR+au7vGXJ+xI0pZOR1J3Wjx4gFfVrKjmuWpZuvjPmgdIhgirLK?=
 =?us-ascii?Q?XkqzUa2JDMSQQ8GSPjFbiISISdEDA4SfwhVjmzlolxCLljLWEJ6V/G5BRM00?=
 =?us-ascii?Q?tSEz3YtXlitQyk8T5qBSF/NjxOFYO4CicfQxYH9iaoYlQ3sVwhvUaoZHOZk4?=
 =?us-ascii?Q?M2L3FrnLOrKFdabBNXbYfm8Zw/NzaCrM+bTnmX0hyvOuUccWTB4t5sMQV9B+?=
 =?us-ascii?Q?aLMblBLCm5DGxvrlDuK2fSaSGAZOjKd7I34w5LS1+7rgg4ZN9RxTjwqeTcIU?=
 =?us-ascii?Q?0US7KLyV5KfLaT9jns2D6GodxdKZQ4xTdA+z/0pq/RiA7lNZcnp5tcq7GYEF?=
 =?us-ascii?Q?MCegrpyqlQyM3QB9GSUEb/kXYwe8lZO1Rrjvim1E7pXqWEz16zF2UBoM8D7r?=
 =?us-ascii?Q?JXlbovlSu+IOWHu34U3t5rHyp4li6zCdCjUcrpCm4MSdOCeo/Tne0YgIAH+q?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a876c66-3d0b-4ae4-bed6-08dce6d14f24
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:09:43.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOaQfsMZe1rfrsNe3sdqlmzcx6FnbKzK/QiTLryvoKdA6HMRSmtPOgO/2GNsae70rdcAsPC2iXJymqALVJgumIycbmvl1vUUoiCvSU++QFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6987
X-OriginatorOrg: intel.com

On Mon, Oct 07, 2024 at 02:31:23PM +0200, Kurt Kanzenbach wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Remove static qualifiers on the following functions to be able to call
> from XSK specific file that is added in the later patches:
> - igb_xdp_tx_queue_mapping()
> - igb_xdp_ring_update_tail()
> - igb_clean_tx_ring()
> - igb_clean_rx_ring()
> - igb_xdp_xmit_back()
> - igb_process_skb_fields()
> 
> While at it, inline igb_xdp_tx_queue_mapping() and
> igb_xdp_ring_update_tail(). These functions are small enough and used in
> XDP hot paths.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> [Kurt: Split patches, inline small XDP functions]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/igb/igb.h      | 29 ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c | 37 +++++--------------------------
>  2 files changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 3c2dc7bdebb5..1bfe703e73d9 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -18,6 +18,7 @@
>  #include <linux/i2c-algo-bit.h>
>  #include <linux/pci.h>
>  #include <linux/mdio.h>
> +#include <linux/lockdep.h>
>  
>  #include <net/xdp.h>
>  
> @@ -731,12 +732,18 @@ int igb_setup_tx_resources(struct igb_ring *);
>  int igb_setup_rx_resources(struct igb_ring *);
>  void igb_free_tx_resources(struct igb_ring *);
>  void igb_free_rx_resources(struct igb_ring *);
> +void igb_clean_tx_ring(struct igb_ring *tx_ring);
> +void igb_clean_rx_ring(struct igb_ring *rx_ring);
>  void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_setup_tctl(struct igb_adapter *);
>  void igb_setup_rctl(struct igb_adapter *);
>  void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
>  netdev_tx_t igb_xmit_frame_ring(struct sk_buff *, struct igb_ring *);
> +int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp);
> +void igb_process_skb_fields(struct igb_ring *rx_ring,
> +			    union e1000_adv_rx_desc *rx_desc,
> +			    struct sk_buff *skb);
>  void igb_alloc_rx_buffers(struct igb_ring *, u16);
>  void igb_update_stats(struct igb_adapter *);
>  bool igb_has_link(struct igb_adapter *adapter);
> @@ -797,6 +804,28 @@ static inline struct netdev_queue *txring_txq(const struct igb_ring *tx_ring)
>  	return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
>  }
>  
> +/* This function assumes __netif_tx_lock is held by the caller. */
> +static inline void igb_xdp_ring_update_tail(struct igb_ring *ring)
> +{
> +	lockdep_assert_held(&txring_txq(ring)->_xmit_lock);
> +
> +	/* Force memory writes to complete before letting h/w know there
> +	 * are new descriptors to fetch.
> +	 */
> +	wmb();
> +	writel(ring->next_to_use, ring->tail);
> +}
> +
> +static inline struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
> +{
> +	unsigned int r_idx = smp_processor_id();
> +
> +	if (r_idx >= adapter->num_tx_queues)
> +		r_idx = r_idx % adapter->num_tx_queues;
> +
> +	return adapter->tx_ring[r_idx];
> +}
> +
>  int igb_add_filter(struct igb_adapter *adapter,
>  		   struct igb_nfc_filter *input);
>  int igb_erase_filter(struct igb_adapter *adapter,
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 1ef4cb871452..71addc0eac96 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -33,7 +33,6 @@
>  #include <linux/bpf_trace.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/etherdevice.h>
> -#include <linux/lockdep.h>
>  #ifdef CONFIG_IGB_DCA
>  #include <linux/dca.h>
>  #endif
> @@ -116,8 +115,6 @@ static void igb_configure_tx(struct igb_adapter *);
>  static void igb_configure_rx(struct igb_adapter *);
>  static void igb_clean_all_tx_rings(struct igb_adapter *);
>  static void igb_clean_all_rx_rings(struct igb_adapter *);
> -static void igb_clean_tx_ring(struct igb_ring *);
> -static void igb_clean_rx_ring(struct igb_ring *);
>  static void igb_set_rx_mode(struct net_device *);
>  static void igb_update_phy_info(struct timer_list *);
>  static void igb_watchdog(struct timer_list *);
> @@ -2915,29 +2912,7 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  	}
>  }
>  
> -/* This function assumes __netif_tx_lock is held by the caller. */
> -static void igb_xdp_ring_update_tail(struct igb_ring *ring)
> -{
> -	lockdep_assert_held(&txring_txq(ring)->_xmit_lock);
> -
> -	/* Force memory writes to complete before letting h/w know there
> -	 * are new descriptors to fetch.
> -	 */
> -	wmb();
> -	writel(ring->next_to_use, ring->tail);
> -}
> -
> -static struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
> -{
> -	unsigned int r_idx = smp_processor_id();
> -
> -	if (r_idx >= adapter->num_tx_queues)
> -		r_idx = r_idx % adapter->num_tx_queues;
> -
> -	return adapter->tx_ring[r_idx];
> -}
> -
> -static int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
> +int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
>  {
>  	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
>  	int cpu = smp_processor_id();
> @@ -4884,7 +4859,7 @@ static void igb_free_all_tx_resources(struct igb_adapter *adapter)
>   *  igb_clean_tx_ring - Free Tx Buffers
>   *  @tx_ring: ring to be cleaned
>   **/
> -static void igb_clean_tx_ring(struct igb_ring *tx_ring)
> +void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  {
>  	u16 i = tx_ring->next_to_clean;
>  	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
> @@ -5003,7 +4978,7 @@ static void igb_free_all_rx_resources(struct igb_adapter *adapter)
>   *  igb_clean_rx_ring - Free Rx Buffers per Queue
>   *  @rx_ring: ring to free buffers from
>   **/
> -static void igb_clean_rx_ring(struct igb_ring *rx_ring)
> +void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  {
>  	u16 i = rx_ring->next_to_clean;
>  
> @@ -8782,9 +8757,9 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
>   *  order to populate the hash, checksum, VLAN, timestamp, protocol, and
>   *  other fields within the skb.
>   **/
> -static void igb_process_skb_fields(struct igb_ring *rx_ring,
> -				   union e1000_adv_rx_desc *rx_desc,
> -				   struct sk_buff *skb)
> +void igb_process_skb_fields(struct igb_ring *rx_ring,
> +			    union e1000_adv_rx_desc *rx_desc,
> +			    struct sk_buff *skb)
>  {
>  	struct net_device *dev = rx_ring->netdev;
>  
> 
> -- 
> 2.39.5
> 
> 

