Return-Path: <bpf+bounces-32238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C897909B61
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 05:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1731C2113E
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D83416C6B8;
	Sun, 16 Jun 2024 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdmISVR4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE62F26;
	Sun, 16 Jun 2024 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718507578; cv=fail; b=cOKJKnQVmjkKVUnD2OkkEiZMQo4FgkjR3q1C4lqVkQyib5NNQ7LR1BTYHMy9cR6ibW8yTPB/jeZnYcODuwotTYFQEMpgcC831Ei9kUiVXnBzL3KyNh+YJ3xgdGFW8kvNWO4RIbbZXnlGNU4gX8oQxbWX0KSQmPiJtucuGXVeMyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718507578; c=relaxed/simple;
	bh=WWIDrcZGabfv6EhPv99ZGNknTXv/jiOAwUPSIDRbc+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t7LYp4l+NEW7XJDO+BQlpDXoGJ7tryG918Beg+0cLaBSNL9lBDvikhUzCjMtuhQv92uiUfzn9jP16DN88mtTTrCxRoeI2wo1CBZM+Sgvn5HTAQJWJBwpfKwd6uCLbTu6kb/I/eCjo1IURvPGnSAK2ANBSeMbUixiMWeF2axtCoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdmISVR4; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718507576; x=1750043576;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WWIDrcZGabfv6EhPv99ZGNknTXv/jiOAwUPSIDRbc+w=;
  b=IdmISVR4kFWW1MQtn0EE+39Jb5jBC1TzqImSbYTaRGpIcHg/IqR+taQu
   5HGJuowK7Th5W0rNJd9I4RTtEPPupXmuRTY8atLgnnnAEDgEaELabZlUh
   8a61Dbis6N/xvlyU87jZs4AsuD4HL/0NnD9geVimj7F2RZpPhl29taPve
   GDMQ/TsujLblPo5iXk/6GGJ2eccO2AAXoIRK6/ajQrj5L/lHOJc07KXkn
   zKaVhpXktM6N3F2SyjcN4INh52zOhIOxOM26PHn7J38AfQUFz8Q5a0j4g
   eWklZ0H685TlpkT27XV959Oz3Vzg4X4tG599p40zgIqxlydAQVsAnToxI
   g==;
X-CSE-ConnectionGUID: cZC2DuUST8qiEOuhLrrCIg==
X-CSE-MsgGUID: fA9b81+RQsiAsr5A3YAnag==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15240374"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="15240374"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 20:12:55 -0700
X-CSE-ConnectionGUID: WNVFqCbaSRuEMvtrR8w4fw==
X-CSE-MsgGUID: t85izYgtQjGsaeTBLEayIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40727744"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jun 2024 20:12:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Jun 2024 20:12:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 15 Jun 2024 20:12:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 15 Jun 2024 20:12:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw9DqLMW+Anyif5d8OfaPsU6cTOUiEAIWetNAyO7XXJ0PDjyrcGxzo2iJrO+Iv/RsYOC8axvhkqvEGr6TnnRMjzYW+hGM0jj1BEHN9QieLthnMTtqt+Y4OLOxMcnrVo13EbIoKQIgh0a8u2BzlaM0K6jbV7TbC1BS+UCa49eCWzmEBQzGWTWgQ4CBAP4UEsFgsfxd3vQawbhTTr4rbnSJodTa7IgBHqVccMZfOouaoLY8PtCN7wYWwAjqAzD6ztU6laYBQBYDu+JRgisM7Zd5vRAb5qt3Ly0G7D+sp07Q3z3J//B7/m5pAPrN7P5Xf8fGpL4XiBzYwttl+7Hpfj72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADaW/ieSqHWtCeWElOVWaUgkM4piiKy2xCjzPvm5awA=;
 b=TkaVxFXs8SRxasRvAQdlZbja3u3r2pmr4Plz/Bnuxr1+9qN8qzDAOd+8h80WkMyyDBvxHfHvIq0kYec7ktSpwjdm9GF15LkoZFwPP/rSjbJzrJq32igle79MKvKTYcbAnNh/ROgobcxq46I3aEiLQlGqwWfmlvAzN4mLBlY1C2ZSSpudC8OFBJdwReNQk0StTffzVEaI65dJUwtevJ/122nbCDNwaitDF7QhNnVg6sYgviWksQ068TziKA9a+nvCe2qYbgPNkPJmjdcM4Tmu8e3ojG9nyw2LAfm91SJ/91LzVa9rfpdzB0Y76opPskpOUxyP7p/YPhFbf+1qTDDZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Sun, 16 Jun
 2024 03:12:53 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c%6]) with mapi id 15.20.7677.026; Sun, 16 Jun 2024
 03:12:52 +0000
Date: Sun, 16 Jun 2024 11:13:19 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Barret Rhoden
	<brho@google.com>, kbuild test robot <lkp@intel.com>, syzkaller-bugs
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [Syzkaller & bisect] There is KASAN: slab-use-after-free Read in
 arena_vm_close in v6.10-rc3 kernel
Message-ID: <Zm5YT8f/zGTIpAvr@xpf.sh.intel.com>
References: <Zmuw29IhgyPNKnIM@xpf.sh.intel.com>
 <CAADnVQLf1P=qfA7CBxwB_0ecm9edBg=QrN1PS2QnfP7xJhDWNQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLf1P=qfA7CBxwB_0ecm9edBg=QrN1PS2QnfP7xJhDWNQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 04db6188-7797-4cf3-88bd-08dc8db235ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emMyNVRuMmE0T2hrK1JQekU0cW1veGhENklrVDhaME1FdW5md2djZmtDcCty?=
 =?utf-8?B?bGFmQWhLL2VsYmxUUlloY0paV3Z6OXZ5ZXVOOEtnV0RPMUhkNTRLS1o2blZB?=
 =?utf-8?B?Z1lKTStyZlJFdjBST0ZkeHBzRzJCcHYxSm5Jd2hwSlZrZlJlajEzeWFPRGZ0?=
 =?utf-8?B?K2FaL0lXcTZnOVdDeiswemVyRXlwLzQzdnUrcTdpSENWZVhiRzdUOEVQZVZ5?=
 =?utf-8?B?Sm5JMVNZRGk4WEIva0h2ZzJwWlF5dXNuQndHdTlQV0RsQm02aTJ3c0RMMk1C?=
 =?utf-8?B?d2N3YnBjeC8veExOZlZScVpMNU5VeVoxVG9FcTZuRFU5eFZORG80NG5Caksy?=
 =?utf-8?B?WG1UTGRvTTN1MXByVGJLQ1dZZjNicEh2dmR5L0FFbk9KK01lUzVmRnI1MWtP?=
 =?utf-8?B?Y2F6NGNLdXRGc0JDTlZPSTVtTkJMQmNqcE1tU1dISE9tK1ZmaHhQOURQdC90?=
 =?utf-8?B?UWI0OXZvQU91T3pHa25na1JuUFBqWm1kajFaaVRSVytSNlkxdnk5V1cxVmdv?=
 =?utf-8?B?dTMwSTFUWTdSUXREVTVNeitVQ1R2SVNVNDlwMGpJakN1Zk9iUlkvK1JXMzBy?=
 =?utf-8?B?NmVEMytxNjhqVXdYYzI3UGJodHBTSW9rU0dpRFpPR2dQUnBzaHpHMjVObjJv?=
 =?utf-8?B?RngvSkRJME5oU1o5ek9MOS90VlhWTWlqN0xsS25QaEJKdlZFWUtTUWdmN3Ro?=
 =?utf-8?B?SWRYTUliMTB6bmZvMVpXQXZLUGRXWi9BdVRTbDdWMjRsdlNXRkFYRzI3Yzgw?=
 =?utf-8?B?a0l4VzVvOXpYMWVab29pVWFBa3J4eVNwaU01SnZteGEvVFdJUTZxRWNLQVc3?=
 =?utf-8?B?ODFkRnhON3laaGRGTGlNWnlKaE0xWHlONTJzWUYvaFlQOThGRXdXbkJDdFNR?=
 =?utf-8?B?c2ZKWi9DWXIrZFpmakdzb0lobVIyK1V5SnhXTmM2eGZHTnI5bTlkTFlRY3Rz?=
 =?utf-8?B?c0plczFxa2p2T0VVallwQTZNT1pTRjBRQWt2TEtIKzVxejVjM2psRDZ2V0Yy?=
 =?utf-8?B?cjlxN1JxTk1NamZrK1RiV0IzOTMrdnNxUDZ3eFM1eXl6THpHMjdBWDVDeG93?=
 =?utf-8?B?VnpZWHB2RTg0Y0kySGJSZ3hOVXhyeGNma2NnOVRXRWM0VUVLNEkrVjNpQVQ1?=
 =?utf-8?B?MThhN3lFMndPZDAzNGhjSzdMSnFGNTlteGxzQUlPUEM5eXRaSmJHeHFyRkM0?=
 =?utf-8?B?dEl2ZzQ0VFFpc01CRWZmUUh3L1AwZFN1WlMzZEN1QUgyMlFqSWVQdzUrNjUw?=
 =?utf-8?B?VDR4QVZyT1J6ZFJmV21WMWdJZXU1YUZxcjBHL0lncHpWVXplYi9KQlUxWnU0?=
 =?utf-8?B?ZTNDMFFuRGFkS1VQRXRleXQzK1l0MHVVZlhvYUMxbVZJWUV3ekJQSDlVQlh0?=
 =?utf-8?B?QWVnUnZEZ0dZMnc4cjVXd0drbVdjeFo1eTc2N2IvYjROZ0RYcDVHQTVFckpY?=
 =?utf-8?B?L0RxWHRxbEN4bnZuYVFPNE1ZTTQxd2hybU1WNzRlZkhUbWVzaC8wRGd4RVd2?=
 =?utf-8?B?ZnZsRWJyZVhXMDNxYnJjZTRHWlg3Z2RCQ1BpWUl2WHhTdG8wQytIdUVscWln?=
 =?utf-8?B?L1ROMzhiV1lnQXA2WHF6Vm5VUkRoVlNLWVQ4M09RdWpkdzBidkNRUXNRR3BD?=
 =?utf-8?B?ZEdoRSs0VWpnM2dyZlRaRHphVHB3bVQxOHlqdGxHZVpvNkwxR2JVeXJWMkVu?=
 =?utf-8?B?UGQ4QXg2ZXdGKzJPa0hMbGRlaFRFaUx5alU2aDE1NFFvWDZoMVpCa0tEcmRi?=
 =?utf-8?Q?eFp/68HBnH7ximY5hMv2gI2Xk4Btdg3J5kA6VY+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktIMmppUDJTaGpFQ2VlZzB4Z1dXMUplVG01bkN5WkpidmdoWHk4V0pxUHJS?=
 =?utf-8?B?YkpwdlF6dkE1QURza2xhNU9wQ2VleDZ0c2p5TlNtdUwzbzV2b1kyVUVuTjlY?=
 =?utf-8?B?L056THJ0MEdQMEdjdzBEMFVma2hMaFhEWE0vdEp0RjhDWDY0TW1yZkZLUHky?=
 =?utf-8?B?N1BwR0hieHlYd2pwYWlFVkVSSnZ1S0UxQml1dFRUQzJ3U1ArVFpDT0FXVjY2?=
 =?utf-8?B?bVNiSHpZTEJvVndVQ0s4ODlVRG1EZHlIRzhGRUF5SXQ4eHd0c3diTjBzQ29O?=
 =?utf-8?B?QWtmUUd4S0lLSWJEVXdGbHlQdXpMQ3pCcitjaG01TXo3aUFmZFZhV29od0VS?=
 =?utf-8?B?bVFnUVZPVG10VkRjOXNscWtnR0tETXZWWFA0bE0rLzFrcERGOE9xQmpTaEdn?=
 =?utf-8?B?MlhVd0JTUHZaZEdVSGwzaXdyaS9wbVJwSEQ4M3Z3KzlLRWR0WFhCUmdjYXBL?=
 =?utf-8?B?dmJ5TFlLc3l3QTRlckI2d0dmdzR0bjVhMnpsdzlmKzE3VXF3Wndwd2lzd0pj?=
 =?utf-8?B?QUo0SEdtSTRhZHdUVG1UMEwvZmNZckEvbERxd1NjMFkyN2VUSWw0MWYvMnQy?=
 =?utf-8?B?bFh2c2p2Q1I5OGN4T1poS01HeGZWQXQ2bU9GZmhGYkJtMjYrS0FONkpIUWo3?=
 =?utf-8?B?ckFtVnlVWlR5Rzg5N1R4L04wTnI5WnN3dnpNT3Q1ek9paHR6cnRiS1VraDBU?=
 =?utf-8?B?NzVIOGE4VTdEd3BWZXVRNWFzVW1IYng3NklIaXg0UTVEMHNGSzl4YkQrdzlx?=
 =?utf-8?B?Q0tvWm1tOTAwbzBpaGlpblNYVGxZN2JzTUp3dFQvTkxaK2xOWXpDUDhwMjhC?=
 =?utf-8?B?Y0d1UnRBVlNRUFFnRzZqRFhpaEl5NkxUcGhHb3g0Y1ZFSVdRUHQxbGZQZkx5?=
 =?utf-8?B?MlVYbUY5Tm4wRlU2QXZaL3B5OHpsU3Y4enE3QnBPMmtvSkJ4aGVJVjVmMmdY?=
 =?utf-8?B?ZHMzZ2xUVE9oRXpSdncvUHNiUWZ2RWtIb3AvcGUxN0RhTUJFNkkzN2F1bS9k?=
 =?utf-8?B?ZEtkZlRuOWY4MElFVXpKb3VGNGVVZUt3WWx6bGM1Vkg2SEc5YzlFTlcxb0hK?=
 =?utf-8?B?TThBT05Cdk50QjgrMUp3WmxjcTJBeGZoUTltejJNUms5VENpeWVFU2FuZzlM?=
 =?utf-8?B?TCtKS1RvNjV3dkpnZG9jWUxnMlZsMkFBZFFlNmc1d1dWL3lzVGt4MHozcnZK?=
 =?utf-8?B?K3g4ZmhOZmlDL0xWZXVJNWRNdHoyd1NaNk96ak4wY0t4Mm1WTUZXSnBCcE5v?=
 =?utf-8?B?bUNTTjh0dVh4R2ZDTFViOUFTZkVER3JqZmlwMnFMSVE4dHlqWTQ5TVVRb01a?=
 =?utf-8?B?dDBZa2NZODZvTVB5Z1NlanBSd1hDdDJWMnQ3MUxVVk1SaEFlaUpWaE9jZ2Vu?=
 =?utf-8?B?WTR0TFgxYityaEo5cXpaZlhWVWxzRWZhS2xnWU5qSE1PbjIrZ0pxSWNLMWhH?=
 =?utf-8?B?MURTNFp2c25xc1VnUGNKcCtUTDdOZisydmg4ZFhxbS93Z25GelBrUW1QeERV?=
 =?utf-8?B?dVp6SVRSOXFzTHNxR2l3emQycFBWOXpRNVUyTWFZSFdJWURqd3JvMUh5OU00?=
 =?utf-8?B?UHlNYkRld0ZNZzM3bWFJOHNtZUlSRkhKVGp3SC9yeXVPQXpwR0x0QzNrL0tz?=
 =?utf-8?B?MlpiMUk3Y2FCbWUvSmRURHpHTmFiSDZXQjJJamp1RDMxTHkvQko2VnU0YlVQ?=
 =?utf-8?B?VXBhbVdDNTY2RGpjclhqNDROcjBOZ29RSFdsRDVmQWxSTXZpS0xyOWpQeEIr?=
 =?utf-8?B?QjgzMWxWdEFQZGJweVBNSWQ2NlY5Z25rVUR3QXBJa2NwUndnSXR2a3FjSDdi?=
 =?utf-8?B?NkJpWmQ4YTVVSnIwSW9rdXFDSExxUmhHN2NJQ2l0UmlhR3Btam0rRGdpMnhN?=
 =?utf-8?B?V1FNTnZ4TXU3aXpWWGFCRk5PREZBMDVkSmFLRFpHOHZtYkdpa0RodW4wUWll?=
 =?utf-8?B?MmZDNzZtWnYxajNlZzFTRjN5Zk4wMEpoNjBoVjF5VkJJVHF6aldha0llVHNW?=
 =?utf-8?B?SzI2Y2VUMEN1Z2tydTNnTHkrTXpBeHA1b21uSVlpZi9rOC9YVTJ6RzJKbHV1?=
 =?utf-8?B?OE50cjhabGxaZ1JBdXpuWVcxU3hWZGZVQllIZWxKYU52Ymh5ak1TWGxTLzY1?=
 =?utf-8?Q?wv+ichWPomDVb1dd0XpOBqJA+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04db6188-7797-4cf3-88bd-08dc8db235ab
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 03:12:52.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygNuyuZQ28uKLNPvUfQezt5gZH/wBfWWwjSBnCQj6rSSk9Yhk18B1Z27kg2KLNlU6gmwrmhmKOEyMXl2324Ong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com

Hi Alexei,

On 2024-06-15 at 11:21:05 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 13, 2024 at 7:54 PM Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > Hi Alexei Starovoitov and bpf expert,
> >
> > Greeting!
> >
> > There is KASAN: slab-use-after-free Read in arena_vm_close in v6.10-rc3 kernel.
> 
> Thanks for the report.
> Please test the fix:
> https://lore.kernel.org/bpf/20240615181935.76049-1-alexei.starovoitov@gmail.com/

Thanks for your fixed patch!
I have tested the patch in above link and the above patch fixed this issue.
I have replied test result in above link also.

Best Regards,
Thank you!

