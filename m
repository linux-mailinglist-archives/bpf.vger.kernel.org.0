Return-Path: <bpf+bounces-42639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D99A6B7C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3571F20990
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F91F8933;
	Mon, 21 Oct 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHdePWR/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728EE1EB9EF;
	Mon, 21 Oct 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519466; cv=fail; b=KufOztz3B4/quDx0chcmz6IRshLCODP83tkiDBSp5ymHx/tRERUPHjskerSD/rJLOWDAT1Nr//98zdMmM2sFbbzvRHnINDSH59Su0rm5sIOTSM21mfV+Y7tiz4NXBCIGAchvwPoVJgOPtgEuWbFicXQ1GfY9GkI9E1jLLBondfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519466; c=relaxed/simple;
	bh=oN3/TQjm+Fm7Kjng7mW01fCcNgcGK+hSdeZM5W+jsbg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+o1Y5UpvsmQNORSFqgaBVWwL7kwI8rDsXaHJY+X4oJTJZIxL7+XDlH7tBAeHQE8vdaA75QC8nFC2FywZbqDLbZKRWyF6b43QGP8/KccxVUTv23NVFfFpJk8shzokw+fPys/RUDXJqecK9hNWkjOniurrLTc7FEKzCud9SLhMaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHdePWR/; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729519464; x=1761055464;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oN3/TQjm+Fm7Kjng7mW01fCcNgcGK+hSdeZM5W+jsbg=;
  b=fHdePWR/HZRd+6ZvuIBme1vl4Gg8J3aau0o5uEZztn46BnZdBJCWdW/q
   r5nkbuD5yRsbX/bceE9ZhCD243SXmSZHVj6EbCRWDoP9QG4OLwGj1o0kj
   rINd+5zyDOOu+pQJ5vPWtbPvIC7LgPWvIEpwhkn5MAXhsz1zfXS0eITTI
   hYu8Fs6cCP/Dkk1Bad7rDM3GZRwOt5M93uFZsngL8W/zTSyaaWPdGuI8q
   OuETU58mlfQ+J6dgvsQrCJ+HSUkOaNCdd+qcocTrqE9SN4/P/OA08i12G
   VwC3GGTngbF5bh4EG4NnT5g488Ikn4Aq1lwBB0nSVS/Rvvq2+USADJRwr
   w==;
X-CSE-ConnectionGUID: fPlWmOLgRjGKr1eOhANJOw==
X-CSE-MsgGUID: Lh/swHAmSCWU8syFkS4Hsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40129629"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40129629"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:04:15 -0700
X-CSE-ConnectionGUID: kOZL7WUxQwSjMBET6K1hhQ==
X-CSE-MsgGUID: eMDL83VyRoiaeYQmSIYa0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79936577"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 07:04:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 07:04:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 07:04:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 07:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8RcBnRhw1tfmkfwSC8fgfP0Z8b3BuN1JFt1ePJlSzY2Ejpdcyvi2tsd8vhj7beTrSghbn5+HDmuGLAMxu8aN8iwDv95C1m5OMvg/X07U8AUcZWt+0funue2oGiDX++mPYo4Lhh64Cp6KpzJeKqlX7+15xMtyKzDQdc/q+wBc1GhYXR+HuBSpE1g05R1jse+V+84SoeeR7wbKqHirJTOFoHOdFI+rKO6RPbsDaYWZyY0t+/obIXvkV2eeJnpq97sXfJyDoh6KRdDMKk5ggWTKSzJdPnLO2zsDxAGiCuu02+4E4VKetjIRX7tgNYt9shs92HWiDriTRllbQnN8QqniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2BNjOs/Ul/oPi9TKn8R+PtXRYbqAQx6ffS+27z2wL4=;
 b=yIK+tshL+bzXxF++RsZHSd5SogV56UT6yRyRefqA8Xq25E0HFPVdytZvO9JlFuyPJOFa/LYfFnzBZ3dkQwIeSx2Vmtk6KVHKRopvPtXiZ/3j8w6S8yo3tdv+0NOgh1DnSAskL5otBK8XDSfznDANM4Ni9nzSOa0cjbO+ZkBMYx4s5WrBNbX4MmxiidV4m5zjHwdNX0Rfj+g/BC20M4Ff5vA2g24v5aCrfsa7TayTY1bvqPK5t/Ze5gm3336sH5GcKS+QbyBff4kNxXSYYVMsvczuBXQ7pkHzdYadrhW1lA+pDWAxmufEqcPpWychXaETDfqxrDtnAf3AIAhk7MztEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:04:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:04:09 +0000
Message-ID: <8301d5b6-2ff6-40c0-b505-97e9eb341991@intel.com>
Date: Mon, 21 Oct 2024 16:03:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/18] page_pool: make
 page_pool_put_page_bulk() actually handle array of pages
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-9-aleksander.lobakin@intel.com>
 <ZxD2FJ2rrPoOJWOV@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZxD2FJ2rrPoOJWOV@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0013.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: f419159b-af2f-42d8-dae3-08dcf1d93b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTdVNHV3UzkvRzlMWkJOenBreGJVSjkyMnM3VTdMY3NPaTBhdjFNa2N3QTEr?=
 =?utf-8?B?NVFWYnQwVElVdlgzSVc1UW54aVU2OUVlRU42MitoUmZlME0wTmJlbk04YWVy?=
 =?utf-8?B?dUJIQWhLMlFqbGJFZnQ1WE5RWjQvOEV1ZCtjSFNWRFlMUmZDMjR1Vis1c2ox?=
 =?utf-8?B?L3dMZ1BzV0hXRWVpR1RLRHJDSjFFdkoxVnpMczFyS2EyMVFieGdGOWtESzJ3?=
 =?utf-8?B?ZTFyVmYvSnVsWlJOR3pFZXZuODV6VU85TW4rRXJpSk9LQUtFZ2FZRytFczlV?=
 =?utf-8?B?blJaMm9LTlBPRC8yS0l5bDZ2U3pvNnVtR0ttQnQ5UnRveVU5cWE5Y1FLQy9U?=
 =?utf-8?B?TCtISUFHT3VDdHNaR0xRNG5DNS8reFNBKzZLZGNBZjZYYkxPMERFZFVqV0gz?=
 =?utf-8?B?RllKR21MR1lydHVjM05BQlc1M1M3QzhZcU9xT3VXWHM1ZjlsNkVkTTQ2VzBl?=
 =?utf-8?B?bEg4YVdVOHJudjdnOEY2M0hzN3JnSlZMdGEwWDFma3Uya2V1VG1DYk5ZQXRH?=
 =?utf-8?B?YjBXVFBRU0NJU243NjFZbXJCaDdGRlFlcnYxT1lWdmJKM2pYWElkdWJsajRS?=
 =?utf-8?B?MXh3bkt6eitrbWFDME5XSnJpK2pUdnlZbjc0a3UxYkQrRWc1RG1meWQ5SXE4?=
 =?utf-8?B?YVNHTy9jVHNLL0RKdnBNNDNWd0pFZmJhbnVwZUZPSFNZN3lVL1NKUU5Tcmhr?=
 =?utf-8?B?bnRtN0tsQWs3WUlBMERGTTNYZ2N6bXNFUnR0d3Z0NitVMmNuMzR3OWNvZ1FH?=
 =?utf-8?B?a2dGWVdsYjFvOUJiUGI2TFdFblBKdVMvNGNEUkdUOXJQVWFxZk52NDRBeVZq?=
 =?utf-8?B?VFlXelpmT3VlRTFyQ3F4Z0FlMzV6RTdzRDlMT2JNdjFDQUNidkFqa0trREdN?=
 =?utf-8?B?RmVpNHp2M3RQcnR2UzIyY3Y2YmNQR2twWW0zRTlsckZkQzNQRE9FWUJlR29L?=
 =?utf-8?B?eFZNTHJ3cENwbm5GclNUOTdGdU51WmhlRHpLOUhLb3E2cThOd0kwNDh4bVVz?=
 =?utf-8?B?ajRQakp2VzJnZnVIR2wvUkhpQ2pmTk9BZmxHUlFIUHVNclJkZFE5Uk1lYy9W?=
 =?utf-8?B?RlZzM3lSdTByZmhWRG5nZk05dGU5a2d6eTB1R3A3QzBZNTlBQjJBRkdKU1JR?=
 =?utf-8?B?U3dxci9ncExXSGpxSE9mVWpEdjIvbStoUzNvYk9MM0J5RUNxeTRCU05vMlI3?=
 =?utf-8?B?UE9oVWg1WUJUVVI2cEhldmFyUENDVkhuenpBSlpOakpyU0ZQdFM4ellYYXBp?=
 =?utf-8?B?dHNtcG9lVFpISTN6NzAzZGRkY1lsbDRmWjA0V0xoWTdVWGVOanFxTzVsaVNC?=
 =?utf-8?B?dmRHM3VDWFZzTzA1bFdGdGxHdkVHa2Fla05rc3FqenhRV3JFYmRWaUJLRTNN?=
 =?utf-8?B?SGl0bWFtQ3FZZnVDRG5nUk1VcHp5RXRNbDA1OC90SUQ4RVdOMDFST3N2KzFt?=
 =?utf-8?B?Q1BMZzB5cmd1TjBPOXg2Zlg0MkhDR3RpZ1hQeDB4b1Z2WmFxcDJFbHJXRHFs?=
 =?utf-8?B?cXp5SDB0NmRIaWdWejBkQVIxOGZTeHREdmw1d3hOUnUvbFM2M2Nva25zbjR1?=
 =?utf-8?B?UDRVVVZDcTJROFIwa1VqMW42RlNwYU9IUzF6bkxOOW9mS05ZdWtwQ1h2dkU0?=
 =?utf-8?B?RDd4WS94SWc1bW53MHhhZ3ZDY2pmMlB4MmE2QWNZTGNRMFNFaTlsbVZwN2xk?=
 =?utf-8?B?YlpBUjhpM09EUG9ZTEZDSGNQYUdac0trLzZJUEgyazZrSDBrSzhCQjBOeEI3?=
 =?utf-8?Q?e8fz4PXsK96uQCchpCGhcPItvqpVBKhV3WeH/AD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c05zK2NLdEZRZXZuNXJSU3VHNnVzOGRZVDlackpVT3NOeTNORFd1YlMyZEJi?=
 =?utf-8?B?NWpQWlpoZEw0bC9peUFmZlA1VGxVeEFVYkFNWTgwcVdzUERGTVUwMTJmU29u?=
 =?utf-8?B?REs1RFc1NndWRWJHd2Q4VWxJZWNlVkNockQ2SG5tMTZKQ2loa2dzTys4NWZl?=
 =?utf-8?B?dHdCdGlFbFF3ak8rcUFqZ2t2MGVsL0JhaEJFcGxWNmpXd0hBOUVrVTRjQXYz?=
 =?utf-8?B?Z0xrZ0R1MTBUV25BTEtQSXE2anl5V2kvTFdRQjM1RitCSWNZSFdYZ3VoNkJp?=
 =?utf-8?B?SG5nU1hub25rRmxHNVBzcTQwV0h5Z3Zabm1kbW45MTVSazF5REpnUzBoYStT?=
 =?utf-8?B?SG9iblpqbnJTNllzRHF3NllZMEhjU2FtRVVnRURpL0o4bEZ5aFlUMmdEbjNl?=
 =?utf-8?B?b3hPMklNQnNmd2JSclNjUXc3UnkxTmExd2xwRkk4SUZ1MUZFMmJCaEhIOHR5?=
 =?utf-8?B?YjFXNjVldndoSVYzMS8rQm5GY3drR2JhUG8yVTc4RHo4bElneU96Q09vSzRw?=
 =?utf-8?B?MXJDaEZwekJMUWFZcWpEbnpuNm0xMW92MThIK2xBa0F4czI4QStMTllzclE3?=
 =?utf-8?B?VjVnT0x3d3ZLckl1OFBTeGtEb1dpUWp4NkxJS0VkeFFYTFkxdXNKMDhhTzlm?=
 =?utf-8?B?WGpZVXZGcU9hay96NzBVNzJBeitSaGtGWmJnaW9MT3JlZ0Y2d2JFL0FrajRx?=
 =?utf-8?B?eHdXdFVGRU8xaytoam9xUGxZOXRBclUvdkpOYnBpZEt4d1o1NzJMQjVUK3RW?=
 =?utf-8?B?aWdpMUtxUkhIbzViZ3phS1RueTR5T2Q4ZmZ6a0c4MU0ycm9WNDdXbGh6NHBm?=
 =?utf-8?B?ZWRnSjlBa3BrWGdENXh3cTZkOHJCU211Szg0Um15T3Uza2dKNmVrSVZkY0Vz?=
 =?utf-8?B?dTNtRG1qZHdPMHh0YlZVbS8waGIyeVExMzl2UmZlTGFPRlB2dlovZmdWczFQ?=
 =?utf-8?B?OHBvQ1Q0bWl1QlJZUUVMaGtWMEgvQzArSHBBNzRObEI1aW5Ib3gyMTVzTWJV?=
 =?utf-8?B?Vno1a2ZZRDlVbTJ5Rkp4K0x1SEJIdG51S1duUmdqUTl3OENnNTYzRkJXeGFB?=
 =?utf-8?B?d1gxMjc1VC9aVU5sc0luZ0ptZFg0bjlKdjM2WEJ6WmZJajZBYzBaVEZtTTUz?=
 =?utf-8?B?c3VwZWpGTnQzTjBDd2hpUjkzWjVGK3Rka3pWSmdiRXBKYWlld0hsdkg3aTYx?=
 =?utf-8?B?SGNhRktzUFNTd3RhUmNjUE9mSjlrVDdiOGZLemRLcVNpZ05ybjhORHdDKyt6?=
 =?utf-8?B?WCtpdXY2VjNaR0Qza1V6RjFkSjhsTjVMOGlUSlowU0dUNWd1dU5VS0d0Qmt0?=
 =?utf-8?B?VjJuWjJjeXk5VllxbWU0SDFQemNTRnhXWWlWMFNUbmJWb1RkZ2R4NjlhTzM1?=
 =?utf-8?B?Y1RWUkFTazc4dmYzOEFqbERWSEVlenVXbFJpR1k5cUJaYmFyKzJJUEVQU2gr?=
 =?utf-8?B?ejR6RDYxS3BXRGlOZ1ZjaGJMREZvR25WckdzcGxCNFZIZUt6VE9GU0pMZllh?=
 =?utf-8?B?Q3N5dlNSdnlpc0JUMk5yRUJWdWlKTkRGYytFeEROeU1DM2xCc21ZZndGcFR0?=
 =?utf-8?B?YmxQRDAyTjEwRDRnUjNtaVRac0h5czlUTEFIdWxZdmZEdmlpQjRtN2wwQUdE?=
 =?utf-8?B?OWZxY2xmak1WMDVwN0x1Y1k4WnhhNElIMi9kbmxqUVFwSmY1aStoQUhBdWVC?=
 =?utf-8?B?K2ZWRjVmMjU5N3l3SFJuVHhDMEMrUE5ERVhDUHhrQ250RXhXOFUyS2ZCU21x?=
 =?utf-8?B?TWxJREFsMTV1N3FNNDY0T01mL24wNVN6TnFkenQwRkdrRnorVko5TDhnTTNN?=
 =?utf-8?B?aXlqdDU1QnhMejR0RUhySDZnZWo5TmprTmZrZlkzNWJkbDdHSGJhKzdWYzJp?=
 =?utf-8?B?WEQ2emtYcjRhT1NXZDJtN09ua3hLcHNFek11THdvRnVtZU9Mc2U3MXk5MTlm?=
 =?utf-8?B?dEhnMEVFZ0JBS0d5YjN5ZGpVZG5VRm1GVExydFkwWndaSU5jOXY5M1dHUUhx?=
 =?utf-8?B?dmUwYjJaSndyNDRtZjhqWFludUx1MFlEMk1qRXNyUWt6NC9teFJqZDd2YUdD?=
 =?utf-8?B?WHA5SGJGTzBOS0ZGbVRsdy8yeGxmRGcvTlA0eGE0S0dNUnJZR1BPYVVGWnZy?=
 =?utf-8?B?SUpGYmpJWW5qTUVnTHBEdVB1bkpLK0RXSXpLL21mODVsbEgrZGwxSkVEU1JF?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f419159b-af2f-42d8-dae3-08dcf1d93b83
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:04:09.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8Dpd1Z0AZ7aDywqb4FDkFtL1wC4szldITlniq4FAijnZ8SeH/wFnvnl/mxFyEe1uqLm794tQKT2Sl/j8LxHBNWp3ywGLFP4safjcQiV6l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Oct 2024 13:33:40 +0200

> On Tue, Oct 15, 2024 at 04:53:40PM +0200, Alexander Lobakin wrote:
>> Currently, page_pool_put_page_bulk() indeed takes an array of pointers
>> to the data, not pages, despite the name. As one side effect, when
>> you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
>> converts page pointers to virtual addresses and then
>> page_pool_put_page_bulk() converts them back.
>> Make page_pool_put_page_bulk() actually handle array of pages. Pass
>> frags directly and use virt_to_page() when freeing xdpf->data, so that
>> the PP core will then get the compound head and take care of the rest.
> 
> OTOH this one makes sense to me as a part of this patchset, plus i like
> that you are getting rid of virt to page dances.
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Any small improvements observed when doing micro benchmarks on your side?

I didn't test the perf on this one without patch 9, so dunno =\

BTW this one is needed for #9, while #9 is needed for idpf as idpf can
mix up to 3 page_pools within one frame (1 for the header, 1 for a large
frag, 1 for a small frag).

Thanks,
Olek

