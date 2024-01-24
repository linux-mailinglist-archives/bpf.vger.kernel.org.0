Return-Path: <bpf+bounces-20243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C38183AEE8
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8481C22AF1
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7F07F7D2;
	Wed, 24 Jan 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/1nf9uh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CACE7E59A;
	Wed, 24 Jan 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115420; cv=fail; b=amhaxCiRqFaq82vjRApbRp6i+pH4OUNf4JXuOKTHve+4b8Fl1AJspQoytbysPljzcw0z29Y4kxfI3+Li5z4yoFH1zeQNfxT2jUKvEBZjrviWWuZGGKYSX2xrcGPHohrkpHiaBS6ZXRkhw7TmxthNbmRRsv70+SzFsVqimFc3sJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115420; c=relaxed/simple;
	bh=Ia3r3T4xQ3K4ZbKo/m1waxp/UEPJlPvROhJcStdNKSE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VbKNl3DWxu9WM/LGOkTJJa5IMBHqhXzhiQU92FgeQQ06otP4ChyNrtYHvI8UJ+yrKyIsB9FTXQfhbuOXq/hv355VB0lG+50HBbm2D8bpK0aNOq4wnXqgvJIE2rL8jGX+mvS/nKtsBoOM2+uJUc0iDfHYDHJYBAlOVvV8Ssv7Fe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/1nf9uh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706115418; x=1737651418;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ia3r3T4xQ3K4ZbKo/m1waxp/UEPJlPvROhJcStdNKSE=;
  b=f/1nf9uhtAmuWLHhBBVCNz/W90pUnga7JGQU2qvHwwnanGNhhYIIbPgk
   Lp5qNBgMcJoF7p+5/reXD7x8x0q7pruOz6CYsqq6TAX/RsyiQwuh2L/qo
   XRoLbx2DHPuUnqLIveAd/bIH2TdI/nL17mZahFJM4F7tvgiC8GSU0mOej
   wqlfiey2z4qDKDPcfRx4H1HZA1pCtcPfvDLrQV65Oyu1O5MfudjON45A2
   +Z6lqXgRhoR18MmK79Rl0ZX+8Ehgld+i0pqhkCxmMwDIxymURyVqAKCvE
   8xHMFtTjyBOe3stOtUnf7qxAeXjs2cj2KVm1opV3JIVOpfWlkPn9G7hei
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15429629"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15429629"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 08:56:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735987597"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735987597"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 08:56:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 08:56:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 08:56:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 08:56:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 08:56:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itOQ04EXkcOvrJSxiudncN8ckWJeL5lp1I1UOr4Y3MsneJuc7zdhN1l04udT+dth+/9t3PMCQsfTwY1GkvolzW2CecXNgF6aKU93riMpst/Jjq2XhPDdsAz1Cei065ohKEcV1UfQCG6jjgsEemPqCdJqs0Uslqxi91MCk8+kmZZCwfc5ngCgYAWrBrl3Rqr6YQY3+gjFzAFLxQIkkl4w7RZwKay+8V++wLn2C0146RG4qDel3Zlm976OnqI/kns1IQiAoVb03QDhc6W27+Cn1UbkPnm6xaAUtNcqDTE2QDlQNE5jnZQ1FRqlF0Cx3+aIwjto8uCkC3/nnTpgDrsO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcEBsvpt9h88kB5mqhW6+9giUp8kOBO0WFyQRk8ymdA=;
 b=Zx4ogSWNsbGWlSfRaX4MA+p5TTJn98SJAUJe9sHGXz8m68Q/0Ud59OOhXmIB7pczYafY0xUXO6EpE4i4Eio9sNo1a6Cmq0ANYUl6tTe6OgssGNL7A9zK5spiBHRkFYAiacWFSSENWcr3a1B99Ul6HTOAcTpVyNrXvFzs45ezdFDdpJ1lu6uEMmoQqKTz9Dv1ef7gUHQvHWkorH7Sr8Tc1hbFdZPoc6lu0dVW+LoY7dBSigZg2Lh9h1r5RLpcFT09/tIL0hRcDubVePs5uBCG5Jiu4H1hGt03wYEOKPCpkBTeFiDMdSoG0OTKqKcfNlSI2xptznXV4suaCEVdmzfrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 16:56:50 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 16:56:50 +0000
Date: Wed, 24 Jan 2024 17:56:40 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>,
	<martin.lau@linux.dev>, <tirthendu.sarkar@intel.com>,
	<john.fastabend@gmail.com>, <horms@kernel.org>
Subject: Re: [PATCH v5 bpf 03/11] xsk: fix usage of multi-buffer BPF helpers
 for ZC XDP
Message-ID: <ZbFBSJY6nEpw+5VA@boxer>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
 <20240122221610.556746-4-maciej.fijalkowski@intel.com>
 <20240123175317.730c2e21@kernel.org>
 <ZbD8TWLihi4SZTwR@boxer>
 <20240124085349.3e610e24@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124085349.3e610e24@kernel.org>
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 008b1dd6-0370-4f25-8d77-08dc1cfd759c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLMgRAb3cbrYjoWzYx70iIt7Tm1qY6jS8xpTb0ivYE5NeTPRYnRbi9aoUXlCUlFZskvEK2L/7rTi8yj4EI+hUbunYgcKyhAbzGmsyuZSmNbcNzjEGf+72N/gLmTdiFTfU3qyEQZ41ztzMLOVEfSOAdZQzTfmrzoNsXahb+D3bfeC9GWfWHYhP3HKen+5EFSnuu3LtjXUM22wlXyxx4/PGQLMRWNRxiW8GJUQGvjv+jtqI9jMXqMdv34XfvByPm+XDO0eKhahQLlbzRZPD7xuEW7dXnBtQiHpPhFZvhAb7JmPOJ+XWf+Z03S6OUNVRRnp4xWazbZxk1nMQIKlU3wkwqDgD8uHEWpk0RUHCK8ExnevRosh469wWQFFL83b1/4P9hcYxA6uUZffFzdws2TLU7kULPFkcrYHD7TXFjDsmWQ+0fqtt+gM5LpQEJU67LWRtBFuHOzVvXMeB76uoOkUZPaLA3H6j/KS1GL7TaTzC2TXWjf/kfSIYKlVWA++FWPhFFKTfM3B4bIhMu5cO4yCqVxEdATMRvIXIxqylDKhXY1FtIcgOFQStWseMLcdmbJ76JSkRurQ5qqrBUB2CL7pBg/dV70JDQc4fC8fHFZ2Mv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6486002)(44832011)(478600001)(7416002)(5660300002)(6916009)(66946007)(66476007)(66556008)(316002)(4326008)(86362001)(8936002)(41300700001)(8676002)(2906002)(4744005)(33716001)(9686003)(6512007)(6506007)(82960400001)(26005)(38100700002)(6666004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRSUGllSFFhUkhzNjQ5TWFId0d6eGxPSERtZ2FhdXBnMlU1S1Nmc1IrMlNj?=
 =?utf-8?B?ODQ4MkQrUjV5N0RuTFlrUVR0VHhaNG9NV3VrdnpvY29IOU5zSzRQeHlJZzFS?=
 =?utf-8?B?QnZvZWgyNTdzMzBzSUs1UExRZDl2b3VRajIwVjFNT0lSYnRpWGEvaXpJbDA1?=
 =?utf-8?B?TlBYOFFkU1hURWQ1RUNGbElWMDV6OVp3SWk1MEhJd05takhwL3NvN1g1eHkr?=
 =?utf-8?B?azFwN3BkV1A4c1FGS3Ayb3B5Vk11T2hkVjVTcVJjamx5akpGTG8xYVJtV2NZ?=
 =?utf-8?B?Z1Nxd0ZhL3RuSFh6MW9LTmxTdlh6M05tRHRKYzZhL3U1enlFZzNuYXBXeDhK?=
 =?utf-8?B?L3g1ZjBocFdwUGc1cUlESDZKNkw3RllSTEFDSEh0Mytwc25jNjIzbUovdmVo?=
 =?utf-8?B?NFlQazJ1QmtEVkJsY0x0YXNRVUdiSitzNVZxeW0vMjc1a09nKzNGaE9pREk4?=
 =?utf-8?B?ZXVlSk9uU2lsS2Rpd1FvN0hGTGthUURBcjNONmNOYURKK21La2JmSkUzbDhC?=
 =?utf-8?B?MzlYZlFOOUppMGIyVFpVZ2RhWTZVMTFlck0rQ3JYdFkxWFJwVXpSdXNsSHAy?=
 =?utf-8?B?VjFsQlVWL3lST1lZNGJRRUMyN0VVOFhZbU5NQVNiaWVYUnkwUVN3bjF1TXpO?=
 =?utf-8?B?NXFmZUNlazdBK05IcmlYbUQyQjlWTXRnbnFvTVAyWWdTcXdpb0dqNnFtMDFp?=
 =?utf-8?B?OWVUSnJMbFM3WDdpRnFnUmVNZ3lxSW96SURxeHhzTE8rOXJNcHpldUNSS3dW?=
 =?utf-8?B?VWFTSUZCYk9yVzhVckhVY21mdkIycHVQNWFpOWdkcU1ZV3NSNGlhT3YwMG5z?=
 =?utf-8?B?MEZSaHVTaGRQVHpHRmxHUkl2empQQVRuWGpTb0lkNXAvSmxqcFZuUmlmR09k?=
 =?utf-8?B?SGkyVVBXWHRNazN4MXdQQ01FbjZ2Nzk5SDdRTVhURjEzWnVybzZZTU45b1JE?=
 =?utf-8?B?citjUFF2Rll0UTZiYlRUR3kxV1NwWGt6R1p3K0l4THgrRlFabnFMWEx2bFZ3?=
 =?utf-8?B?NmtPdTlaeG9VdWN0ZzQ1Z0tyMEc4Sjlzbng4S2F1Zm1JYkpuUnNxc0IydG96?=
 =?utf-8?B?SGVNRS9NdW1XaEF3ZVIxbHlLTENYOVNOYlJ6eHY3MVRWeEV1V1dDNEc1SUhu?=
 =?utf-8?B?dUFmeEp2UU1TY0c2Zk9rcVNNV2l3cWx0N3pyVE1ZbmpENzVoaVczVE9pdnRo?=
 =?utf-8?B?SDMvYzRzRmtLWWhybUFVUFlXWmc1cTlVeTl4bks2YzB4ZkZuZXRwZjVuc05a?=
 =?utf-8?B?M203bXdsZ0hBYTVva2ZzOFBSaHpOQVlMWkRmY29DZ3ZVVkFWaktYeEt5aUZC?=
 =?utf-8?B?SCtUVjk5MlduVTlFVmtPUWNTTWFwclFjT2o1T0I3K0tvaTBoaEZoK25VbmVE?=
 =?utf-8?B?c3l3QmNTcERUVEZreVpFYTVLREJzY00xdlBscUZ5UHNDYzNXeXlVT29Dc0tu?=
 =?utf-8?B?alY0QzV1b3BJbkorL1FJRncyNHhCVVA0NVREN3M1eTN0VERzaC9nQXM4MjU0?=
 =?utf-8?B?MHBEYVhFdUpzY0k1N2Ruakd6cktTYy8ySXo5QitlS21xRlplUE1DQndLTm41?=
 =?utf-8?B?Y2RUOUJuN2FxMHh4ZlYvcW1tR3czRDhNSjREUmJYMnRhcGpPZE0vbEhTTlJ0?=
 =?utf-8?B?MFhDcGd4ZGo0dVZuVTR1ZVMyeHMwN3FuZm01VWVReFBVMVQza3JXRFBacm1D?=
 =?utf-8?B?WWk2ZTROdERtRSttdHRMS1BoV2sydjlrUUp2TnZNSEtYSkZFL1pNeHZieTI5?=
 =?utf-8?B?SGd0TWdLakNSNXkvN0plUVN5M2N4VjVRWllVZjhtanFabkZackhLWURFUkNx?=
 =?utf-8?B?YkxWZ3FtaTBIRVdZY3FwSnd2ODBLYjhCWHhicVZDZlJpTnI4TlUyNDdXZldQ?=
 =?utf-8?B?MDkxdElENkowYk9ZR095am5iTWZHQzlJTmI4Z1lvQ0NDQjhYZUhLUWpwTEw0?=
 =?utf-8?B?N1dPeHEwK1JJcmIzeEVXYWFlYUFCbWVNY05uZzgwbmJ4elMzb2R1aUg4YVlV?=
 =?utf-8?B?TXlXM2NhUTNOeGhrdjRWVU1nTDlXWEFBTlNmL0ljSFM4ZWtRaXloWjJ3QitF?=
 =?utf-8?B?RE5wWCs2VGpKTllyK3MxZnJ4WDdpMXNsLzNEZFQweFFPeHM3K1JKM2EvUk4r?=
 =?utf-8?B?Q3k1QWhvUlhZTVNFNkNlOGpEQ0dFY0E3RXBEVko0amVFdFNMMEk5TEprU0c5?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 008b1dd6-0370-4f25-8d77-08dc1cfd759c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 16:56:50.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2AxuCI2nyrE+QrWios4tpSY/erE/nYczuyP3qURxS8grkDGhDDBQvFw1dZh0fY041RynvU+DbOcX6pQzpeXWfNuoTKv3G6sWHX1eoHJudM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com

On Wed, Jan 24, 2024 at 08:53:49AM -0800, Jakub Kicinski wrote:
> On Wed, 24 Jan 2024 13:02:21 +0100 Maciej Fijalkowski wrote:
> > > nit: this has just one caller, why not inline these 3 lines?  
> > 
> > we usually rely on compiler to do that, we have the rule "no inlines in
> > source files", no?
> 
> I mean Ctrl-x Ctrl-v the code, the function has 3 LoC and one caller.
> And a semi-meaningless name. I'm not sure why this code was factored
> out.

Ummm. Probably some previous version was heavier, now I see the point :)
Will fix.

> 
> > > nit: prefix the function name, please  
> > 
> > will rename to bpf_xdp_shrink_data(). Thanks for taking a look!
> 
> 👍️

