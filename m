Return-Path: <bpf+bounces-60820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4006ADD0CE
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 17:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23FC16AD79
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F52E54AA;
	Tue, 17 Jun 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLQtzXeX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA02E3B1A;
	Tue, 17 Jun 2025 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172512; cv=fail; b=HnUFJMEIljsAiQcS09WkGngHGrR1PLsftr9neS46g0XVQD0I12xJxtNVFrcQvfNwj3XA29Gpp3wmnOBcF49vTx3Chm5WZJsnltzwywhxA874ga3lhFS/S9OkaVY9dTtFCAbhlfoK1GIaxdjkG+2sIw2Qx2MWSxpyx2jpfQGAiN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172512; c=relaxed/simple;
	bh=LprP7yU2KwzmTGDV3S50pl8Y5N3W91BtghW1/rra4CY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BLs7VKI+QS3a8nzKtwqz2Pq8yj1p3WBHzJqQkl8qTqW5MUJjBhCOw4CwY9wZJEpbOIj/U8D03RYr95odlNXaM7nC758csEKikBRTpjQ1kipBAjxohBbLk3A6tsmLS044HrnKjvq0u+meGPQVGiTW7ECumaDFkcqPWw07J9cr0LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLQtzXeX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750172511; x=1781708511;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LprP7yU2KwzmTGDV3S50pl8Y5N3W91BtghW1/rra4CY=;
  b=SLQtzXeXkJuqXnwwYFJnnBGZ/eEJSCacxSIzQNH9xx/jTqH5TTTWArH/
   UKDHxFvBU5UFHe/7d6GYgxaug3Y4iR0/dt453roWPDkxufejvh0FjS7Ib
   9N8RokP3FcGOaYCfA72c/Ca8wK8khRijXHv8FXPsUeknYcenMjVjwJpRY
   jAiCMJ119G95xEMtVcIzSzBRIm6nMVr5PrPdepHFBdbGF9Q2a13tUUi/V
   ZcT1dYEOAasFwdS+8sa6RJ9xZt7rOufrzXuCs9qamV44FGu/pOqBhk+/a
   hnhFZgM3RZKDsvD7tP0Dth0w5CM2OccpuImZT4EHxSaUO+F6wOcBbAK98
   g==;
X-CSE-ConnectionGUID: gRYHXQlAQ9S6BcYlXnrhAw==
X-CSE-MsgGUID: /ZSjl0K3RKySavtJDKAuCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52448870"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52448870"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 08:01:46 -0700
X-CSE-ConnectionGUID: ILTHDQRWQ0a4EWPRjxAfDQ==
X-CSE-MsgGUID: T48wOkU0SQmK8a7KbsLlcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149295086"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 08:01:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 08:01:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 08:01:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 08:01:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1ClWTEMvrFvjAc2xV35Yohn/GtvYKc+Dj2qAOFN3wuiNlDLKWKsRhxTjUWMYo/o9KRnBhi/W9Cw5c8qDmjBiqgy/Yn4pzKPfjBqH+bjmk9r401jl0be0FQX8yBTysty+i2P0/AYzhW039U6MQedLG7A1BfJ/3zTXxekvZS8+xLYijZqVmiS4YWzCh4NclAo0pRSUtvse6UDIOtoSf4pv5275U555YdPeLjTczWgiTF6e0C7nuXGh0VP6bpNnhAXv3kWehKOzGul6PJZuVSx6JcJnIHJmJs6WK2W34gdYVo61JsKNp22JW2iKCGgCbWd67rVvRzBjfW1yoGFUT9voQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C9icDAAwI/zpwIou17+S5ZDrjQOYsA7w9r0DgyOLnU=;
 b=FHLq0kGdOdvF3G5N7aYP1ELhumZ+LMG+A50lhgLtYM72ZXVyVQ4tV9EO5i3+SCOwB/bprdWtWC7/u25lDFLQIHmI3GDPfm8poNJM7GlFDtfAmtKeLKLCc4XOxtZt9pj9cas2Lap9WuTu/wsL7QzlL13QxbeoU7EJt9HToHsbFqwhrIW8n2EQbTNYuSaaRPyfN/gBR2lAZD7kkXSy8pcYLvpuxfu3F3Pj8dWF/fjpwbK5CXhUbg/GzctmIjVfSgcdqImZm/SOzdFXcNl2oQ0fp2IN75nMW9/Ceih3rDQaAZib/+M0eSAWVR/fAYl3VBK1pLYn7JAD9bVn/cy0/xzalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH3PPFF8C186950.namprd11.prod.outlook.com (2603:10b6:518:1::d62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Tue, 17 Jun
 2025 15:01:21 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 15:01:20 +0000
Message-ID: <f977f68b-cec5-4ab7-b4bd-2cf6aca46267@intel.com>
Date: Tue, 17 Jun 2025 17:01:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethernet: ionic: Fix DMA mapping test in
 `ionic_xdp_post_frame()`
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley
	<brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Caleb Sander Mateos
	<csander@purestorage.com>, Taehee Yoo <ap420073@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20250617091842.29732-2-fourier.thomas@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250617091842.29732-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0097.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH3PPFF8C186950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5cb2fb-5003-43b8-5db4-08ddadafd1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXhGUU15cit5UVU4RmpWSmNidHloMTNNT1FpUStBZjhkZVVYM012YjlaeGJ2?=
 =?utf-8?B?WVNPc3lQQmpNSXdBOWIzbHVsa3FiUXB6N0JQc3Q2bDhvSHRtREZ0ZUlXVGJV?=
 =?utf-8?B?d2RJZkoyalVTeGo3Vks5Um9KeXg3TVlDQis5NnNUL0dxcC9HMENoTmsyeFB5?=
 =?utf-8?B?eGFONURBWlNxQ1JXTER2RDZ1cHExVFphWkU5ZXFzZ0dUQnVKZVpMNFZiYzhF?=
 =?utf-8?B?Vk82WFkxOFhVNzdKSlBhVVhQVVhtUTJsUXM0UzZWSlJQVXU5WG5IbkVkVWN0?=
 =?utf-8?B?c3hhbndxM2ROeGwzY0JDUWdsTHMxRlZpbzBSL0xqUzh5bjFpQVZnQW5zb3hF?=
 =?utf-8?B?elYvSDk1M21mTjM5SmR5cGY2QitBOVBNMUJ5Qy9NSFdGa3E0WUs2LzRQVkVn?=
 =?utf-8?B?Z0gwVUxvOVBpZUNGci9CM3VjcE5KVVNZVnQ4K2RNRW8yb21OVUNMMEtZQ1B1?=
 =?utf-8?B?c0VsSzAzaC9mUHlsM0dKK2xRNU00YTNqNXN6YXhEdmRhZWg3Y2VGUkhEajNH?=
 =?utf-8?B?ZUZHY00yYmM5cUlTN1FOYnRBYzR6alNQa1ZON1pxZzdCL25VSUp3aFh3WHR3?=
 =?utf-8?B?OFBFaVl1SkRqWCs3VStzOWFRN3NhNGtRMmJKMHo1Ukw4M3FEVmlnZmRUdUQ4?=
 =?utf-8?B?WlJTT0hiY1daczErUlAxQjdLY21nSmFkaWFnZ1F1UkwvVmNuUDJnV3JHTWdG?=
 =?utf-8?B?U3NIWElXV2NNZmlBZ3BYVktOS2ZraStPQzJ3VjhCQ0ZHWDd5L0pQdHZYTVRE?=
 =?utf-8?B?TEgxWndHNGxQMEV6SUI5Mkw5blJLN2t1UFNva0dGeXdqcDdPRnBweitNMHZU?=
 =?utf-8?B?ZnBLSTl0bll4dUZJN2JBSUZFbnVHWUx2dlYxNngrUkUyMGJVUjdsMHVZaE9S?=
 =?utf-8?B?Q21KVExPck1GZEJIeDE1b1Z2RVpuNUdxNnFoUlRzSWJrVGZ3VzJTSkJSczcy?=
 =?utf-8?B?c1dEU2xIVFdGaG1EVGFNSEdoQm1ZRExrSUxyTEt0d1YxcWRXMmM4bzI3c3JB?=
 =?utf-8?B?cmpUWjRERlhNeGc0MnoxQ3o3aW1XZlBkRnRUOHhmbHZNdkpmSjZwamtDREJB?=
 =?utf-8?B?VXp1QU94Sm9ubVBtTVdRUHZnTzlNSXBhWUIrWVRXS2lSMEJZMjJLbVB3MjE0?=
 =?utf-8?B?YlI2ckxOZnpCL3dDWUpZMjk1d21jZ2ZIejc3ZlozNkwxajlGU2lPRnljWXZx?=
 =?utf-8?B?ZDhXbnI4dmJzZ3lYamptd0ZXS01aOUNGb0tabk5CMVpWUHZqMDBGZXQ4LzNF?=
 =?utf-8?B?eFBQd204dGZ5enRwUnEvUlVZUmJxdkFsRndZL09ZaGhjN2xtMFc2dTFlbzRy?=
 =?utf-8?B?RjN4dVladkpFN0x5V3RtVnByT3FoblladFhsTndESEJBei95endKM3dDSkUy?=
 =?utf-8?B?VlYrb0JxYU1tN1ZuREZnQWtIQThuRWZMcHUxR0F6SkxFTlZqRXNmVmdOYXov?=
 =?utf-8?B?enovSXhsczI4b2hKTEhnMXFJMTVsNmQza0lOYXJDWDhDTldYUjZuQU1mcXg4?=
 =?utf-8?B?UHg2cVBpUG9wVm52SUpra0xwNWRlbTc4YXVOU1M5RmorTHVTSFBGZERpRHR6?=
 =?utf-8?B?bUxPbVFxcDVuanBsWmE3M3htZVRVdU84dFMwMHYvN1IxaWJNNXZteVVCdWZZ?=
 =?utf-8?B?dVJycWRJdk45L2ZLNDNXVGpqZ2JkaG10Y1o5Rm1BUjdsVDdOempycHhkczFn?=
 =?utf-8?B?RmpNcy93bU1WMnpvNEZMcHVsTVBrV2lReU5EUDJkU1pSZVlKS0QwQnNVUkUw?=
 =?utf-8?B?TUQxWXhMOVJRQzFwM0hIUmw5Z3JVUDlVV3dKOEVXYVFSLzh3c3E4YW5meHRU?=
 =?utf-8?B?S3U0MmZSWjRlMnFQN1ZCYVBWMmhaVUNER09rRENTSUNJZXRWbWVPVE1XV3lk?=
 =?utf-8?B?MncycmlNL25QKzJpNURHOHFaNW5yUUF3S3B2V1RjYW9GemRtWjZKYWQzRnBm?=
 =?utf-8?Q?MIQZDFsoLNw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emttK3VSTElJcXdGbE83blg0SHlPVHBFZkZiQ2RBcy9scXRIbEgrMEtZZVZz?=
 =?utf-8?B?VHp4Tk9KbGJxRHZXZVVDN2NoL1UzanJvOSt3RVVWclIvSUJrSENPcUh6SlZH?=
 =?utf-8?B?a3h4dVpMQ09ZVHUxT0dnVi9ITlRmcmZkMGRIclFFQXRSdGRJL0NiemxpNmsv?=
 =?utf-8?B?Y2pEYjRCVWFpTlp4b2Q1bFliazJ3TU9hNE1kWFhmZUdRb3N3WWtISmw0cHJY?=
 =?utf-8?B?REUxcW9HdTVtNFQzTWZZUlQxTFRiT0cxUndZTUVva2JjRWsvNWJMMkNMMkhU?=
 =?utf-8?B?MXZjRytQQmxYZmgxQ0FOOTFrNDhicEM4Y3oyaGRmTlNlUHhDY0MzVFJtSU1t?=
 =?utf-8?B?VHRobGNuQmdwTStlR2hvZldPbXdIbmtaNmxlZndGSCtTQzFGTGxQcTR1RnBp?=
 =?utf-8?B?cVk2T20vMC9GVytBZGd3ajRTL09QdDBiM0tOc2MyTEl6dk1iL1ZOWktSOFZZ?=
 =?utf-8?B?cXd6ZVZ2aEZUTlU1Wks1QkE3d3dxRVkvMXpxWk96NCtrUklUOFdRZmJMVHdo?=
 =?utf-8?B?amRnQnI5ZXRoYUlJYW5ZTGJKSTQwck50WURUYXBsVXJOZ2x5N3UxNlRxTzVp?=
 =?utf-8?B?SE1Nd0NQOGhwMTJ6bVlkQTNoNjA1Qyt3MXhXS3RSbi9IY21DMENiTDJDSTZj?=
 =?utf-8?B?c29kRnZKM0FEVW1JUzF4bWs0VzBaWGE0di9TSVRlRndja0ppa0c5Z2lwMG5R?=
 =?utf-8?B?TGExaXgyRU41TzBzYzZGQUFLaDg5V09nY05hdlZncklwU25IWXhWSllnNStG?=
 =?utf-8?B?T3U0Tzc5c3VqQzdKcDRMUjVoOUJrQlAzOHQrRlBoSjVMZzZzY2tJZ1VlWGpE?=
 =?utf-8?B?NVlmSlg0TURDK29vZVEveGVWUDU0TzdrVkQ5c1hMemFCUFo2WU4zdmNSYmEw?=
 =?utf-8?B?WHhPU1pVVjdiMGtrRFJVSTNlTWFXWTBtYUw0K1FaSjdGOWdyeDdiazRNSkZC?=
 =?utf-8?B?Zk1xN1F6aFFDS29VRi9TY3hNSmNqc1RjczNQZGJXSUp6RVJQMFZWNVV0dHBR?=
 =?utf-8?B?RE9pLzBBNUZTd3YySEJ5Z0Fmd1NuSFVIQ094RU5wN1hEbG94LzRESEdRUmcy?=
 =?utf-8?B?azBWcHFGQytod0JpZFdMTjAvN2FZYkhURDVEREtocnhuM3BYd081L1R4R3VW?=
 =?utf-8?B?cllYaE5iSDFYeWhCV3NLZytBbkRFM0R1dVUxZEtDVEg0OTJ0dWxIb1EwRlVa?=
 =?utf-8?B?T3FLby9ZaEJKbXRPdTdsNHovWWlyem5Md3ZVc05vWlJkL3NzMm5GSTQwMitr?=
 =?utf-8?B?aTQ0Sk94RTVydWpvVkZUYkRlMjFQemdoMEF2a2tUUjVQakYzVUhWTjh3WCtO?=
 =?utf-8?B?Z1kxbGZmaXB5cEZ2MEY3dUZJbnBpN1YrQlN0RG43bHJEd3F4aEwzTUt4L0VB?=
 =?utf-8?B?ZmdWWEE1ejB1dXpzZ3hBUGV5TllRaEJnNm9VVUV4dllJWG5JOFJVbTJXc0xl?=
 =?utf-8?B?dVZxZHJiemhWaTE5c0l3Rm1UNEhHenFkVTBPVUE3Yjlkc05uakFWT255aEFT?=
 =?utf-8?B?ek9RczhhRS9EZmdDTzlDZ05XTEdMdVl5aCtTK1V1SVZuVUdqWjIxUkp5Y3Fh?=
 =?utf-8?B?dGgzQ3NiVEdNREExWUFTOEZ2VTVZS2d6ZC9xZGdJRWYyaGFtNmZHYXA1dGVj?=
 =?utf-8?B?Nms1YXVJbFJ1MElzNlNiUHlYelRMeGZ4Mm9MMzNicHhoeHlpd1lWdUdqQVB6?=
 =?utf-8?B?M3NDUnhGeURFajRBYU9nVlJ0bXhVMTExYlZDWGNBbFJnYlFMUXo3WlpjRWdM?=
 =?utf-8?B?YkpaL09nci9ldnNRaG40MG1BNmlJRmsrOUNuWEF6aWd1bmF1WGYzWWl5WEYw?=
 =?utf-8?B?bWdLOTBzYm5udmY5RlFqRHBrZHZMTFlpWThQdUc1VTFkYkpTK3RHMW9lbmNH?=
 =?utf-8?B?anpwNnJiSU4xRW5EOHBEZXQvdTdMMDd1eVdaUVhRRENuMkhvd0tvRGNTYWpN?=
 =?utf-8?B?VE14ZlFhSFo5bk1ranZwNnk2N1FzM0NXVmhRS0IydFMxSjlrWVhLY1ZVUkZs?=
 =?utf-8?B?SGZCeW9veHdLQjd1MkMvaWV3ZmxodUVjSWtOWVE4MEVCL1RFWE5hdzVZdG5j?=
 =?utf-8?B?M1ZYRjFMSStVV1F5eFN6R1FCOUxkRHVxV3JLNllTN2JXQXR4SHFwalV3eWIr?=
 =?utf-8?B?RzBqbmhvMWZnVUxyS0hCeXJFRk5oQlhOR2p0azhFWE15K2hOaExtQmxkUWZ5?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5cb2fb-5003-43b8-5db4-08ddadafd1aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 15:01:20.8227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iR++H0Y0Cym19TA+R5Bl9OpQ+e7AIYkJgYrxAlvBFwztKTYX5dHc60JT5hJzQeh8VMsyb46ajMua3MsuzyO3VqLNiyxQ8WZJpxaLITtgAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF8C186950
X-OriginatorOrg: intel.com

From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Tue, 17 Jun 2025 11:18:36 +0200

> The `ionic_tx_map_frag()` wrapper function is used which returns 0 or a
> valid DMA address.  Testing that pointer with `dma_mapping_error()`could
> be eroneous since the error value exptected by `dma_mapping_error()` is
> not 0 but `DMA_MAPPING_ERROR` which is often ~0.

BTW I remember clearly that Chris wrote that dma_addr == 0 is a
perfectly valid DMA address, that's why ~0 was picked for error checking.
So maybe it's better to fix the driver. I realize that in the real
world, it's almost impossible to get dma_addr == 0 from dma_map_*(), but
still.

> 
> Fixes: ac8813c0ab7d ("ionic: convert Rx queue buffers to use page_pool")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Thanks,
Olek

