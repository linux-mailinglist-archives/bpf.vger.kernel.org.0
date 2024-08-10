Return-Path: <bpf+bounces-36838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698E94DD31
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D191C20EE3
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D115FA8A;
	Sat, 10 Aug 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjrjjmpS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D19200A3;
	Sat, 10 Aug 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723299029; cv=fail; b=i7auAiVksDmWD90n6x23MPlxhRm5suz2bBRoKjFgqDhGV6v5JsgaaptZNJlLhkfLrqSZMufGmiqSYVaQrWBPW/tGv/LsOBMNzbV5RsmJcBtkr+2RgwTgzozUCibZeERWyGzZWlzVXoWHBdOToogHu7kpqnAu3v3o3/UQRm22Qv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723299029; c=relaxed/simple;
	bh=/H01/69AO7FPSHsBZp2zQ3LXF8HOmS5vm2N9y7VegjY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I5uLCSY9MAi/GbPnr2UJgT6euN12rEOTQhV2RuEXovTa2+GBGuG1lezNSIP0K62Vk8XONStoo7pz0asB5ZRHY5jv7IaN9Ly+4poOOjDtWUwEX4HFMrO8zv4qIWR+e3zunmbireIX7OgVXEOAyjOvOYFZCZlM+UpZVTj2fq6bwoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjrjjmpS; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723299028; x=1754835028;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/H01/69AO7FPSHsBZp2zQ3LXF8HOmS5vm2N9y7VegjY=;
  b=QjrjjmpSiZxVz5kseGK+WLnj9M+GZd2CV80kMegr0+aYEstflPX4WmHO
   gijcmrVVRf1iuC+SNiurfvLE1FUAVDEJkWWZdqbIbs3D8+Q3EFtz7EeSI
   e1P+acqrNr5TevNQ0LGKJywcEzuVYLKPU80OpZxNuffLPo3trv3SsBMO6
   Uz8HVZvIDSTr5oN/kCZXDhFYYR+UVCUJWAZ82TEjLxkfLDyVgRk/Xri1i
   Kl4jMKkdOLJrwE8kvD89Sxkpp0SCYgsCTgxTynypMUX3TWF6glDd9cNLJ
   9cDoVW65a604Omq66Pb6e9OQUP9xJ/gEWvzR9To5XkfA6lTOVnG3I4tQ4
   Q==;
X-CSE-ConnectionGUID: BkjcrED+R2mi1VNHeX6vnA==
X-CSE-MsgGUID: z+iyKDuVSECUYkLOuRNcMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="21122749"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="21122749"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 07:10:26 -0700
X-CSE-ConnectionGUID: xgcSloHoRGeIIgDmyB/BKg==
X-CSE-MsgGUID: oLEx+q9+SGeG1byYlkCHYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="88682061"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Aug 2024 07:10:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 07:10:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 07:10:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 10 Aug 2024 07:10:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 Aug 2024 07:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssCOXB5JTX+oO4ClqAmnfDOMos9vT9qdbrfx6WTUpQsj6db2exHUp33iewIS3OZb7H8jsh5m8N9H0she8snvLcF6hGKH8MVdw/6qtREnQE80yGrI9PxFcCh32oLvR7/TtK2R49/aaWq5TWp2ocgME+UgF00heCv/yYuYzHT8h6RgzbvdjZPUu5YgGCFa/xpbnUEcBpLG8lz17Nyenl221Yr3FxvDQPLaDIdnr8qAinOZiGUa1LQ1rGWvH+qxWiqtqFJpEmedr6V4+/ephzdEboTh6eN48OHt5rWevGBM1qZshCHZr21k1MvX2OSUPTZwg9GtaqBBwx7NBdtQg3iYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS/zQULUcrCFzPFUeo/woeqV7XkEEWzhg0MsMARjkvg=;
 b=sNWEWf5uch3T8qXAZ5re50qdyojBCctYc2I6QY1rGo8j1RHPOMytFARUsUJUJVr4VJav4gDt/mgVjstKNqWfJjuEGgfD2/zS4b0bReFLlHLGwdNM23NgQc9aQ9FCE9oib3TVcmoxlyELOINtftbivmNYrx3X7x8BFCqvVbtAzx4Cf0pHu9dDFaho+K+h8pkk9+cauwTPc1QFEfX8rZ4KJkhLbKTZHytgEsSQNAC6mNLJ1SDRyGRml3GsbDZWTHpbc4adgIQZLfHqOddhh5KJtYMKb1peumaL6zoh94L795EhrXtvEy5g1NRcxe1Sc/y6QSi41b71aYJEgknqBAXInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6846.namprd11.prod.outlook.com (2603:10b6:806:2b0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.23; Sat, 10 Aug 2024 14:10:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Sat, 10 Aug 2024
 14:10:18 +0000
Date: Sat, 10 Aug 2024 16:10:06 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>, <magnus.karlsson@intel.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <kurt@linutronix.de>,
	<sriram.yagnaraman@ericsson.com>, <richardcochran@gmail.com>,
	<benjamin.steinke@woks-audio.com>, <bigeasy@linutronix.de>, "Chandan Kumar
 Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 4/4] igb: add AF_XDP zero-copy Tx support
Message-ID: <Zrd0vnsU2l0OTsvj@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240808183556.386397-5-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: a842195d-1194-4c93-30bf-08dcb9462a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WiGivi7cWqjbCtMGVnLUKY0RQD45cfG97NhQYveshX33NAinInqVMOVIF9/e?=
 =?us-ascii?Q?xc7iwfayZA8xesNpd4gi51dIAbtKQQGHJw9AHevQ1i1FhoHGDs8KdWY0z6mB?=
 =?us-ascii?Q?GMlryH8fiRtzTzxZRropEq/ulg3bHg9GYH8gEoh0QycpXBi14bu3H/jNPBPY?=
 =?us-ascii?Q?ckdNubNHRMiQMLCay0SRRsWLGvBE5T49SzAuFMC3/VP4vpWqIOV5fj7WXbNc?=
 =?us-ascii?Q?ZIvF1nb2FIMfdLxyZDKiBn02GkiPP2Z92h42TRyqDr9pPh1551HxTRuQSvaV?=
 =?us-ascii?Q?qbKmHQDnlC3ria1mFOp/EjUURAcCUakpaajxB8/47+BaFOAEuCizRdNOcrMY?=
 =?us-ascii?Q?AcuEkqYeYkPYKSSYMu6WdDNoxtoUTXQvWA/4G/MAisi/jGg7p5iV7bPBGf5I?=
 =?us-ascii?Q?k9QG6vAr4dlvy6YuGk60Lm9txL/0l6jHJSFMfZlSoEuZeyPI9FiuUd87MYTX?=
 =?us-ascii?Q?65nOfMe2XgAjj6ItjQpaPetV84xIytguO14poKFO6+C00dlQdVREh5GhGjhD?=
 =?us-ascii?Q?2gJFiDUZeCksBsC3X7a/xlNqwGz6m5UqUzjhW3l3/fQMQqgoR0R2bBJDgWfJ?=
 =?us-ascii?Q?UeVjFXHwJh0kK1CtDARN+1MiAnUASel0bsDYH+/3vQkyFZ1SJk09W3kj6OJL?=
 =?us-ascii?Q?g8s8RnU15sykUFRV8vsNjuVWmNpJmt4FhNYJ60LdTZEhJcwg3X1fEwfYMd2I?=
 =?us-ascii?Q?IvMNFrQvF8khhqdua0JbMwwPopEZECgdFQQd3bfYUIsyH+7gBPD0SdWMCLxq?=
 =?us-ascii?Q?aFBWkVD10MJteENo3jST7J0cUKkYSFk4soS384vlcn3rKRgESI+UmWig3fZN?=
 =?us-ascii?Q?NnKrVIugpBZOe+9cZSl8G4oUGCoqsxYbnkkwIIGrE1qAWs5BaFv4Plph7Eru?=
 =?us-ascii?Q?P0S1wyVGQ96egJRzL+P6ZFv9WBuokqXLIX2saIl05R93cvvV1kiP/+0Q6fEu?=
 =?us-ascii?Q?wSfqa1K/PKH9jxr1FpZm+2ks4LwXcWcueArNYBC0iG6rIRqwLU3yifOeQcxB?=
 =?us-ascii?Q?glp/v1d0Xm1cFvFc8aTRTcx3KTPTO7887H/onhY7idn6ZrqXcQyw5d4RHwNE?=
 =?us-ascii?Q?vI6u2lExo6d5sgu9+Gqv3WrKLOpuyUWjGHvfjrizyCyr1OS0GG3CPjJlDfTe?=
 =?us-ascii?Q?p62B62QghTR6u8XVnA0PDmxfg3doPil2Ef/Mi/IW7FqXtj2gsSiOlETseG4Z?=
 =?us-ascii?Q?H7+NYBTIHEviK/M4QJECE9azIAdHBbFSmyJ0GPblAjFr6d87tWgMO2i0UL0+?=
 =?us-ascii?Q?dmScU9Zae+MK4D5lLYPPwtARRdSEbCpFeyS9WJ312ol4s/Sbqt+mWy03cjAd?=
 =?us-ascii?Q?ruBC0cJwoF1/b4MQ5grc3o6JA7wDBJq3eai8Otxkc4/OTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lmoyNLoLBuLzRHHALGdftlmMVQh8wdKsTew+kybU17LbF+L6ub/3fe8LoXY3?=
 =?us-ascii?Q?XigFxfMfbWEvsZqBiaSyfKN6l/Q9dBP3ksc0qISeg0jgeMwRcIt2LUFA0Tgv?=
 =?us-ascii?Q?EpAonTNkS43Map91MMvcjQ4BKyf9KkNvsULQoIlwvLVp63pAJZoqEClFeLBt?=
 =?us-ascii?Q?ZBxGdAJ/nSBU+9L2TdyAGVoulplaZUJNnx0vKEN3CYs7soVR2or/M+KJeRSr?=
 =?us-ascii?Q?ZihBwj+75LpsK0NL4+pSXnorABqpHBjy9+V6MI6uJE/lF/rGzpfTiv3EaB6O?=
 =?us-ascii?Q?w9ibQnaW1S5V1DSa+OOh8/8WkYt8QQ50VJhmVTD3Pxj28JOHTRw3aEwQXSZY?=
 =?us-ascii?Q?b4MwwEiDgRZAshP8R2Lue4UNqQIR6M62Qvu2C2jJP0BnXbRy75F0yQsq2rvV?=
 =?us-ascii?Q?ERZmHWd+CMC2VdyyKG1jxGukAw4C0dFivaTDuEQ3M/aNUDHqwFkeaThZZS9r?=
 =?us-ascii?Q?xb33Nq2REMi2IgeUqibzhvEeWMswfT9/TQ504fCkgYpOZnefCWtQWw4aLC2+?=
 =?us-ascii?Q?JRdljTOeCOFFBAs9xy65Wofp6H+nzdRoSk6U+jiD5q4aeoaptojFG/NUsJu1?=
 =?us-ascii?Q?eOhf3pKbojB4HCE01yPwS0dkQwfXroZs3RsuIr5eYeneDxA7pBrkBZBm/xa+?=
 =?us-ascii?Q?iEBDYjIBGyT3S4Bga3rwc9r3VsW+VxpAnhkxkhTO/7uP7lV8niIFbpTHglHh?=
 =?us-ascii?Q?AdY9e5MF3Uxae2wmGuy0majablBokRLgvzgMwnlneztYRRDbUOpbZWsFz4Ne?=
 =?us-ascii?Q?KwnX+murw84ei04mPbpo4CXrQu8ISJ2i80K4bJUA1G6oLbDeoTlPoLmrKCrX?=
 =?us-ascii?Q?eClQlUP55EQEXJZNgtvRVytSvWLQCyUGm4qVLxJLQsIMa5Dzx8qWrcp6yPuD?=
 =?us-ascii?Q?6VeNgnS3Nf3heJ1+VQQEDB9IhQOF9RENvti115PIrjDjzv5AR5shq7Mmw88e?=
 =?us-ascii?Q?BGz7FQoqGUdDMhCLjdrcRKEpXjuX7ia+YrLRs0vGLUlz1WsxHUzcL1jnVa9q?=
 =?us-ascii?Q?Qtyf8P3eVk+M65F0eEbcWUO6vZERxh2xBru2tsbEe1LLjHBjtuI3WgQQqcaj?=
 =?us-ascii?Q?kwVabnfQnhu0TgPybKDMqxCZEVtuiem8hOBln2LLjFv1Yb28Cvl9ETv3+rOw?=
 =?us-ascii?Q?bidrY8OBpOHILSdEoZdSwUgkwq6oR3pGQnW0gAykMmo/5YkDL3IetiqsCz4Z?=
 =?us-ascii?Q?CWlgP36CZBypgnc/qcJxTM6fJ/9DPKjkzVw1Z6bDPHXR4SOjfl1ES4MgD5OA?=
 =?us-ascii?Q?vwrxAlW3AQkHK/ur0I7pdKlBqAfQW865QZdoYWkDIzwpzKvt+NX4yOfButO4?=
 =?us-ascii?Q?p/XMfssxz2yxwVMQEj5GbysSGqZQuQv7qlKxglBV4BtlpVZvq/X3qgYVA3D3?=
 =?us-ascii?Q?R9gbUjcBFs9mjEtnfpiBtpThvwnhGQto0XwChiKy15alTVsTX5wK89W7RibE?=
 =?us-ascii?Q?shnv3gLDpbj82CFhqGx0dGeaUZ+4JjMx/7xN4gLTZa7gl2eLLL4EbQWbKDfG?=
 =?us-ascii?Q?ZNxLEOclwzvDkQhgXV61B4iB40lU5fPF/vpLBiiP0WaTF0WtWPBzc9VB5Q/7?=
 =?us-ascii?Q?hVVB0kD6nl5ZBAKK7RJB1oMkLDJmZuZvgCukCWsqkAEuP7hcBweSO3HkNOBw?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a842195d-1194-4c93-30bf-08dcb9462a0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 14:10:18.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MX6M9jBbtl5hzjeoTVI/2MuS7pQQ2QGSDZ7ONeA7+zjeg2VI1bAFYfN5/yoY/aHqR0JYwvunufkdSLFx1yoPmaSa9IxnFWG0YxGiyio1FM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6846
X-OriginatorOrg: intel.com

On Thu, Aug 08, 2024 at 11:35:54AM -0700, Tony Nguyen wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Add support for AF_XDP zero-copy transmit path.
> 
> A new TX buffer type IGB_TYPE_XSK is introduced to indicate that the Tx
> frame was allocated from the xsk buff pool, so igb_clean_tx_ring and
> igb_clean_tx_irq can clean the buffers correctly based on type.
> 
> igb_xmit_zc performs the actual packet transmit when AF_XDP zero-copy is
> enabled. We share the TX ring between slow path, XDP and AF_XDP
> zero-copy, so we use the netdev queue lock to ensure mutual exclusion.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> [Kurt: Set olinfo_status in igb_xmit_zc() so that frames are transmitted]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  2 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 56 +++++++++++++++++++----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 53 +++++++++++++++++++++
>  3 files changed, 102 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 4983a6ec718e..9ee18ac1ba47 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -257,6 +257,7 @@ enum igb_tx_flags {
>  enum igb_tx_buf_type {
>  	IGB_TYPE_SKB = 0,
>  	IGB_TYPE_XDP,
> +	IGB_TYPE_XSK
>  };
>  
>  /* wrapper around a pointer to a socket buffer,
> @@ -836,6 +837,7 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
>  bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
>  void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
>  int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget);
> +bool igb_xmit_zc(struct igb_ring *tx_ring);
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
>  
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 0b779b2ca9ea..1ebd67981978 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2996,6 +2996,9 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
>  	if (unlikely(!tx_ring))
>  		return -ENXIO;
>  
> +	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
> +		return -ENXIO;
> +
>  	nq = txring_txq(tx_ring);
>  	__netif_tx_lock(nq, cpu);
>  
> @@ -4917,15 +4920,20 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  {
>  	u16 i = tx_ring->next_to_clean;
>  	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
> +	u32 xsk_frames = 0;
>  
>  	while (i != tx_ring->next_to_use) {
>  		union e1000_adv_tx_desc *eop_desc, *tx_desc;
>  
>  		/* Free all the Tx ring sk_buffs or xdp frames */
> -		if (tx_buffer->type == IGB_TYPE_SKB)
> +		if (tx_buffer->type == IGB_TYPE_SKB) {
>  			dev_kfree_skb_any(tx_buffer->skb);
> -		else
> +		} else if (tx_buffer->type == IGB_TYPE_XDP) {
>  			xdp_return_frame(tx_buffer->xdpf);
> +		} else if (tx_buffer->type == IGB_TYPE_XSK) {
> +			xsk_frames++;
> +			goto skip_for_xsk;
> +		}
>  
>  		/* unmap skb header data */
>  		dma_unmap_single(tx_ring->dev,
> @@ -4956,6 +4964,7 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  					       DMA_TO_DEVICE);
>  		}
>  
> +skip_for_xsk:
>  		tx_buffer->next_to_watch = NULL;
>  
>  		/* move us one more past the eop_desc for start of next pkt */
> @@ -4970,6 +4979,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  	/* reset BQL for queue */
>  	netdev_tx_reset_queue(txring_txq(tx_ring));
>  
> +	if (tx_ring->xsk_pool && xsk_frames)
> +		xsk_tx_completed(tx_ring->xsk_pool, xsk_frames);
> +
>  	/* reset next_to_use and next_to_clean */
>  	tx_ring->next_to_use = 0;
>  	tx_ring->next_to_clean = 0;
> @@ -6503,6 +6515,9 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
>  		return NETDEV_TX_BUSY;
>  	}
>  
> +	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
> +		return NETDEV_TX_BUSY;
> +
>  	/* record the location of the first descriptor for this packet */
>  	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>  	first->type = IGB_TYPE_SKB;
> @@ -8263,13 +8278,17 @@ static int igb_poll(struct napi_struct *napi, int budget)
>   **/
>  static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  {
> -	struct igb_adapter *adapter = q_vector->adapter;
> -	struct igb_ring *tx_ring = q_vector->tx.ring;
> -	struct igb_tx_buffer *tx_buffer;
> -	union e1000_adv_tx_desc *tx_desc;
>  	unsigned int total_bytes = 0, total_packets = 0;
> +	struct igb_adapter *adapter = q_vector->adapter;
>  	unsigned int budget = q_vector->tx.work_limit;
> +	struct igb_ring *tx_ring = q_vector->tx.ring;
>  	unsigned int i = tx_ring->next_to_clean;
> +	union e1000_adv_tx_desc *tx_desc;
> +	struct igb_tx_buffer *tx_buffer;
> +	int cpu = smp_processor_id();
> +	bool xsk_xmit_done = true;
> +	struct netdev_queue *nq;
> +	u32 xsk_frames = 0;
>  
>  	if (test_bit(__IGB_DOWN, &adapter->state))
>  		return true;
> @@ -8300,10 +8319,14 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  		total_packets += tx_buffer->gso_segs;
>  
>  		/* free the skb */
> -		if (tx_buffer->type == IGB_TYPE_SKB)
> +		if (tx_buffer->type == IGB_TYPE_SKB) {
>  			napi_consume_skb(tx_buffer->skb, napi_budget);
> -		else
> +		} else if (tx_buffer->type == IGB_TYPE_XDP) {
>  			xdp_return_frame(tx_buffer->xdpf);
> +		} else if (tx_buffer->type == IGB_TYPE_XSK) {
> +			xsk_frames++;
> +			goto skip_for_xsk;
> +		}
>  
>  		/* unmap skb header data */
>  		dma_unmap_single(tx_ring->dev,
> @@ -8335,6 +8358,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  			}
>  		}
>  
> +skip_for_xsk:
>  		/* move us one more past the eop_desc for start of next pkt */
>  		tx_buffer++;
>  		tx_desc++;
> @@ -8363,6 +8387,20 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  	q_vector->tx.total_bytes += total_bytes;
>  	q_vector->tx.total_packets += total_packets;
>  
> +	if (tx_ring->xsk_pool) {

READ_ONCE()

> +		if (xsk_frames)
> +			xsk_tx_completed(tx_ring->xsk_pool, xsk_frames);
> +		if (xsk_uses_need_wakeup(tx_ring->xsk_pool))
> +			xsk_set_tx_need_wakeup(tx_ring->xsk_pool);
> +
> +		nq = txring_txq(tx_ring);
> +		__netif_tx_lock(nq, cpu);
> +		/* Avoid transmit queue timeout since we share it with the slow path */
> +		txq_trans_cond_update(nq);
> +		xsk_xmit_done = igb_xmit_zc(tx_ring);
> +		__netif_tx_unlock(nq);
> +	}
> +
>  	if (test_bit(IGB_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags)) {
>  		struct e1000_hw *hw = &adapter->hw;
>  
> @@ -8425,7 +8463,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  		}
>  	}
>  
> -	return !!budget;
> +	return !!budget && xsk_xmit_done;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 66cdc30e9b6e..4e530e1eb3c0 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -431,6 +431,59 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget)
>  	return failure ? budget : (int)total_packets;
>  }
>  
> +bool igb_xmit_zc(struct igb_ring *tx_ring)
> +{
> +	unsigned int budget = igb_desc_unused(tx_ring);
> +	struct xsk_buff_pool *pool = tx_ring->xsk_pool;
> +	u32 cmd_type, olinfo_status, nb_pkts, i = 0;
> +	struct xdp_desc *descs = pool->tx_descs;
> +	union e1000_adv_tx_desc *tx_desc = NULL;
> +	struct igb_tx_buffer *tx_buffer_info;
> +	unsigned int total_bytes = 0;
> +	dma_addr_t dma;

check IGB_RING_FLAG_TX_DISABLED?

> +
> +	nb_pkts = xsk_tx_peek_release_desc_batch(pool, budget);
> +	if (!nb_pkts)
> +		return true;
> +
> +	while (nb_pkts-- > 0) {
> +		dma = xsk_buff_raw_get_dma(pool, descs[i].addr);
> +		xsk_buff_raw_dma_sync_for_device(pool, dma, descs[i].len);
> +
> +		tx_buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +		tx_buffer_info->bytecount = descs[i].len;
> +		tx_buffer_info->type = IGB_TYPE_XSK;
> +		tx_buffer_info->xdpf = NULL;
> +		tx_buffer_info->gso_segs = 1;
> +		tx_buffer_info->time_stamp = jiffies;
> +
> +		tx_desc = IGB_TX_DESC(tx_ring, tx_ring->next_to_use);
> +		tx_desc->read.buffer_addr = cpu_to_le64(dma);
> +
> +		/* put descriptor type bits */
> +		cmd_type = E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
> +			   E1000_ADVTXD_DCMD_IFCS;
> +		olinfo_status = descs[i].len << E1000_ADVTXD_PAYLEN_SHIFT;
> +
> +		cmd_type |= descs[i].len | IGB_TXD_DCMD;

This is also sub-optimal as you are setting RS bit on each Tx descriptor,
which will in turn raise a lot of irqs. See how ice sets RS bit only on
last desc from a batch and then, on cleaning side, how it finds a
descriptor that is supposed to have DD bit written by HW.

> +		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> +
> +		total_bytes += descs[i].len;
> +
> +		i++;
> +		tx_ring->next_to_use++;
> +		tx_buffer_info->next_to_watch = tx_desc;
> +		if (tx_ring->next_to_use == tx_ring->count)
> +			tx_ring->next_to_use = 0;
> +	}
> +
> +	netdev_tx_sent_queue(txring_txq(tx_ring), total_bytes);
> +	igb_xdp_ring_update_tail(tx_ring);
> +
> +	return nb_pkts < budget;
> +}
> +
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>  {
>  	struct igb_adapter *adapter = netdev_priv(dev);
> -- 
> 2.42.0
> 

