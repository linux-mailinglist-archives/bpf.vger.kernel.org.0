Return-Path: <bpf+bounces-42418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2429A3E45
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 14:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B549E1C23D77
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F8940849;
	Fri, 18 Oct 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NosD7+AG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76382C182;
	Fri, 18 Oct 2024 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254238; cv=fail; b=GFbkd1zS2Y80VllMqP9LwP9pww/gmk1AVcPH06nfal9Q+D6t8jzn4mlvZGskUBMT1ZbbePz3zb+K7dSmEhbfiwRs0e8LhOe2m8OmaLsZmOM1MH/QydEomWzhcMY2EHB9ox2KQphPEx5XqvLfyKmkZd+ihPF2qXF+81Z1p60GmUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254238; c=relaxed/simple;
	bh=zge5e/HnxNdCj2R1ohAopkT1Gnzwf7Z0+Zy0woFh2NA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IgXAhesITch+b8GjLu11ygEoOrU3cWyl6WdtSoyVfAo/kG/19tEgyEVmhscTAO+622qmJYxVuvc6833oyXd3aql8i7G+yirBqHyW9tscNU8TxidAOP3aOzh4QiS6r2K4r/i5CeAZVogFRYqA+eA2ZJZhx7hMy63UukfNnylt9dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NosD7+AG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254237; x=1760790237;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zge5e/HnxNdCj2R1ohAopkT1Gnzwf7Z0+Zy0woFh2NA=;
  b=NosD7+AGncC9oxXCbznwSiNlzn2m8T8JZZQKyglv2Vf4R5CQcxCT0816
   FUZZj1Z4wpnakc8K9tZUTp9I+XCc8WfzRSiH5Poa1LVOLpqIuFBnVz6fC
   SUndEtEF7qCp75fNU8MXvcECd/Z8uCeKJ0fD+PuvZI7ninNf9oDDRgif6
   +GR7SLdDVzhn5AI3WXNAVjQm9YIrL8KTWc/FVA9n5EERewum2R7uwPavk
   CRNKpO0sk5aE8+vByp9JdTWLS3b79FPXNjIbAij7WTCKgVC08KHjk4t7z
   VY45rqFOPI0QXfuKjVCnYRxsizQgLtD0RDUaD8gUX8aV7ky1J0MpYEFz7
   w==;
X-CSE-ConnectionGUID: bwfqE7JHScWJbs5+9R1UpA==
X-CSE-MsgGUID: 4IrL+L4vRICyBWp7WWJeoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39325733"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39325733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:23:56 -0700
X-CSE-ConnectionGUID: 53wtSxmwRH2ihY3vDEROVQ==
X-CSE-MsgGUID: bnKhBlxHQDaODDcHzQFn5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79276228"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 05:23:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:23:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:23:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 05:23:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 05:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cITz5wokfirFI69PY4STadVJCurYe6YUqlwiL0rtu96RYAUKm55qAeAsGdQND6wBBJIgiE82hy1K/kkQX7aA7nai9TcDN7yMVDfDn0isdiHf84srRbMUU2ySiLHAeC6Y1t9GCLAXnJWLbTc8Hp/qZHuGWEmlqlnKvgcpDuTw6Qahgpr2Ur2F9S1HEXPUwlDzcUqabEjP4BzDE/wi8qjNNX7j9XDWaeGlJobxewNsfYDrlmExpSAqD6ymKSXnSVNwDhK55O04TPegtQYema0ZvEd1cY7K6M9WytnTnKdvsnaHib38mWPEAYoChwqnS+dUK9xXsdQcs10KESX8J5LSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y97pD0Y2tbdLRLnWX3umJfCs0tjKo4rSnbcYhW+6B38=;
 b=wLIXsEdUmwfSvGFvDEa20Drz9ia50a5RVZ9yz0La+E3mQhQqNZEU1LBdyZSDMuhCqUs/DPkyCiJF7oSc62Oc/MFDpdYMY7lRMbqicaIkir7Y7+zsaY3gUFBAqgAlMThW6K/uDR0wcRm4GeIdT8aTAsAslBkdv0cd2Spb9frUJC87Q1/fOxdBI+ujFNiygasZiHRpudDJvGuxl3l8QaXq78YJ1Dxj2y06i0UBQ8TVqwFaHibeGtr6OrD8oc4Cj5kshZfaexBJjzuyxeSIrmEOyFiA0xHPAN2LNBwwpPtEUAc9VNyG6AZJFsU9qDNUMQc34DY+KFuO27RKM0eNRtqBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB7860.namprd11.prod.outlook.com (2603:10b6:8:e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Fri, 18 Oct 2024 12:23:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 12:23:52 +0000
Date: Fri, 18 Oct 2024 14:23:44 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH v2 net 4/4] ixgbevf: Fix passing 0 to ERR_PTR in
 ixgbevf_run_xdp()
Message-ID: <ZxJTUKmZBAktfWik@boxer>
References: <20241018023734.1912166-1-yuehaibing@huawei.com>
 <20241018023734.1912166-5-yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018023734.1912166-5-yuehaibing@huawei.com>
X-ClientProxiedBy: ZR0P278CA0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 50805b58-a789-4602-14eb-08dcef6fba4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QKvDD/g24VVHnPtxwfePRXEANAXkb9DbtcgzNBA5Mkso+9yR5G2w4cSAFyk7?=
 =?us-ascii?Q?iyuRppURqZdAnTIuYDGPCvW+Fw9G3j2E591tMkPq+8DBhCgsdzLy0EAecjqu?=
 =?us-ascii?Q?yrlZh9jV4TUZNpk9n3IVso17EN+aFASVzL3Y509EIp57DsiDcsJqy7Ah1j/z?=
 =?us-ascii?Q?yp2pbz10feENHrt1oXlVP9NXszagtSwl9NTRZn8oXB0dseMY28ZhVFUpQXUr?=
 =?us-ascii?Q?kBOzXl4T9rgeZjRapT0gHy5F5+xLPj0S1GeVCXRu63mgv59BRMJhTEsptiKz?=
 =?us-ascii?Q?O58kGbYq4ebuOtqIyHAO9JOKAVDMUkWljSLBkkznTECOq9eD9V5LrDzyjyWZ?=
 =?us-ascii?Q?TDcHsXun5MsQf52gC6zhASL6CAugKyt/OqfeB/uUZaXfdJ1yu4c2ndTFGB7J?=
 =?us-ascii?Q?PrPjuGDubxrSCb2twRuPeytA687B3ID4fk7iar8GChaAcjBbtDzraFLSWgU7?=
 =?us-ascii?Q?uISuoRLQbuUBA35uram2zpG9ZJ4GMJwMb6t9eENAtTRiOJanB7QlFJGAZy76?=
 =?us-ascii?Q?pq8gKrhiwfl3BP2VUYxcs4224Bu+GwpLC6oLuDWCw9WTAK369vo5qv7uT1fF?=
 =?us-ascii?Q?oCuOVtEoVqdf3iNrmHo9GH+CeAdY0Ee7RMOpeiCnBPHqzsh6nExWeme6TL+X?=
 =?us-ascii?Q?2NGgloXpDe97Lw1vFPyfwyTT+Dqi+qZ6isVOLCCp9uu6YXskJcsIxE50ifMK?=
 =?us-ascii?Q?I0mLP9QqkNkJPODpFIorcQeuuy7vaDKfxR8oK+ojoLFLWwC+Tr6i0oeq9hnE?=
 =?us-ascii?Q?Yinsh+i3mG9zsz6mwnewkVLvaSILR50Nx5bm+WXYyi0PcZQfQcFmeO9LKfod?=
 =?us-ascii?Q?3InCIAVRGUg/gA8jEv1IaMxf7rfhC5F3qq85/gKCb15dLMnw7mukGTxYrmhw?=
 =?us-ascii?Q?cVhc3k67QMbGRQJRzez7pb8OX2y1XC8Yd9NujFEy42vSGd9e7CRJxTvoKPGR?=
 =?us-ascii?Q?gseJ3oJwIaBn+NT2dAan9hGFFxupaRM1hDSXDzCNYxnWOHJF4uKBfGUK2syw?=
 =?us-ascii?Q?eToVrPjdcK2/MuwMZ7W/8WTqZmtx22OOCtcltDIyXuFxknKxkca2j6MWjYNq?=
 =?us-ascii?Q?gjW3Uws7hTQjGMDZebplsNpngC/EUd4hh4egQoN6RH7Fpjlmq3Jyw39TSrLp?=
 =?us-ascii?Q?asrUDfZOpg3RR8AvctI7kyY3VgY5HYu7ZbKbioDtUMlz+iu7PHZw5H7sBMVe?=
 =?us-ascii?Q?qzYWweWOE3jsdLCq9JGDWptHBw6wxwELsEK653GvEQCii/BW563Pxe2Z5mPI?=
 =?us-ascii?Q?ape2mIiZEHfNtmH8DsgPW8IlW24ZWa11ObBFPDy41Bxqfy0peEkyc5tzmqVM?=
 =?us-ascii?Q?+4xQ+64PwVnynGbCi235O3d3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ccjBCncgCC8Vk0sImYJNoOZWo6F8GVDDmCwA3WnT56ZbhGDPYmKsHvHGCqjG?=
 =?us-ascii?Q?HAXZWFKMD6cJhcm/9A8dSNqkVeMwvpq115s5a3BJOim2dNKyJryv7ttAWPHF?=
 =?us-ascii?Q?ITxKT4kId/i0mWEK/LWmBX88upy8r1QVc4tBQHxC8xUbt616oKwDFjZVd/aq?=
 =?us-ascii?Q?/x3f+ZZSjlT9AYg3O6x8v2HBy6kET/5oEtMIEpKOqt8IqQckYccBa+u9o7/Y?=
 =?us-ascii?Q?JrVkh/3mgr6tCXbslcOwCqR2XlxpvqWDsGGI9bNZLDKXSVpNf4D9gEkPCiDT?=
 =?us-ascii?Q?z6BTBUUl37O4pobrZLmBSIEP3/0o9MbTfXS1Sub4pymh4mYABTYmo0tO2lXG?=
 =?us-ascii?Q?EBzZ5chx77w1vWfhcDh83Ves9o7QT5MgdKd0YWLOXgEKJs3z5GVfArkQURd1?=
 =?us-ascii?Q?gACxjkayqkwKDQcTqTPb1A2XA9ELEXtylT6ng8ZZTLi8T5/bMS67Nqt6LJ1q?=
 =?us-ascii?Q?ha68/70CX5ENqi+lGipdWv2j9D+rjCLCOAC5pwgquOyoK2tC4U9mhrW2+pBQ?=
 =?us-ascii?Q?5IyBaF8WX3tykolbJiDOzR0kjZ74gyvV+QK23VOVyDRh5Xi39G+Ct7pdRpZK?=
 =?us-ascii?Q?/8it0JbtSQl+qeR4R3bYvm8G39DyvMU4ZyVzDtl1XLikgKFkItziROC//XfQ?=
 =?us-ascii?Q?1Ddsg5Vju1LChULtc1/BFRUteabxbLF1zb81Wm4DM3mppgUvElvJ3f+x0JJf?=
 =?us-ascii?Q?rG3RnUtQ9DhdIy05MCAG0qeWPrUBBWoPNmJrbLMgxG7T6ol47VzJ2QdWjPf7?=
 =?us-ascii?Q?6H8ngfOFz4dJXAB+tVOlm4VMYuJsrQ3b4M3m4WcV8Z/X16lpEU9G7+GOze1b?=
 =?us-ascii?Q?lkfcw7Ma+MMdB5Fb9W2m0Femslv64Jk3+ST/PDz7HJiDJQug1LmipgiQjo85?=
 =?us-ascii?Q?4lDvJDfzuTvY1UM9sSnb+XXegCeQrnwfiuEodGCkM2ffKL5njWxDeWWzTpKi?=
 =?us-ascii?Q?Rebr7IMKJHWCWVrL4X/BeOq4ki+OHDzY9MJTfY6qzYK5OZ8j5IVluijqzjwi?=
 =?us-ascii?Q?fnuws9QuPxDNIGuCMGmF9SOjuZNuM5DK8HKmWHpFIYi5s5p+Lu6to133ysXY?=
 =?us-ascii?Q?AY5rWeazKEQGwFVxOk8MF81OZtBPxEgEDDvLMVjkvTJj4hzveiCkAUPp/p9W?=
 =?us-ascii?Q?Ui9nUTtSy+lTgiJKn7QxSCOcs43r7ItPiCHGT0hKyZBknlCfkPx8WDRqSjaR?=
 =?us-ascii?Q?83Xy7FOAXxI6GhAJ/Iwwuhzc9vuNKA+4y5f8xvrWOoOJxsmB0eAa/GqgDUYa?=
 =?us-ascii?Q?Nr77cHPFTW4aeUKkgGOCB4JfKT3XzRU5bfbzXbJq/nwbZ45zqOfsC8Kn7Wf6?=
 =?us-ascii?Q?bZyT5iR3vkjdeCcyM1MWMpvbzmQ/RHQyFQeBX/Hm3fo2P/RJkca6RG+2wIIQ?=
 =?us-ascii?Q?EAl4i1lGeM39bNFIEiRGWBcCnpkXYD9QoghmVj5LTVmJE5sQq13BJW7PIqcP?=
 =?us-ascii?Q?tBF1KtH4yShjLQ4Am6M61QidJpxF+0W5QAXY/XNzJ8UxPXCjTD1VZRuZExmJ?=
 =?us-ascii?Q?CRhGvtHuEUAbW19rHZr8CBTOMlaKjMSPke1bRwtqCJQ60SNMIZgVK2ykR+5q?=
 =?us-ascii?Q?Yh6qIDcs1nNz+Dgn6Wn3crphR+Xmd5uNNrPdU79lct0YpgxvzJKBB5I7qF87?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50805b58-a789-4602-14eb-08dcef6fba4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 12:23:52.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjBr94w36wMPNnvdpVmvSqArDBCHqKAP7ZMc6rfR2eT/UggCkzi3MIqj3/DR6gwHOxC5mmwPwDx4Wwq347LbvUdkBaHuMXOQ0wR8C3FQfRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7860
X-OriginatorOrg: intel.com

On Fri, Oct 18, 2024 at 10:37:34AM +0800, Yue Haibing wrote:
> ixgbevf_run_xdp() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> ixgbevf_clean_rx_irq(). Remove this error pointer handing instead use
> plain int return value.
> 
> Fixes: c7aec59657b6 ("ixgbevf: Add XDP support for pass and drop actions")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 149911e3002a..183d2305d058 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -732,10 +732,6 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
>  				    union ixgbe_adv_rx_desc *rx_desc,
>  				    struct sk_buff *skb)
>  {
> -	/* XDP packets use error pointer so abort at this point */
> -	if (IS_ERR(skb))
> -		return true;
> -
>  	/* verify that the packet does not have any known errors */
>  	if (unlikely(ixgbevf_test_staterr(rx_desc,
>  					  IXGBE_RXDADV_ERR_FRAME_ERR_MASK))) {
> @@ -1044,9 +1040,9 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
>  	return IXGBEVF_XDP_TX;
>  }
>  
> -static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
> -				       struct ixgbevf_ring  *rx_ring,
> -				       struct xdp_buff *xdp)
> +static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
> +			   struct ixgbevf_ring *rx_ring,
> +			   struct xdp_buff *xdp)

ditto

>  {
>  	int result = IXGBEVF_XDP_PASS;
>  	struct ixgbevf_ring *xdp_ring;
> @@ -1080,7 +1076,7 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
>  		break;
>  	}
>  xdp_out:
> -	return ERR_PTR(-result);
> +	return result;
>  }
>  
>  static unsigned int ixgbevf_rx_frame_truesize(struct ixgbevf_ring *rx_ring,
> @@ -1122,6 +1118,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  	struct sk_buff *skb = rx_ring->skb;
>  	bool xdp_xmit = false;
>  	struct xdp_buff xdp;
> +	int xdp_res;
>  
>  	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
>  #if (PAGE_SIZE < 8192)
> @@ -1165,11 +1162,11 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  			/* At larger PAGE_SIZE, frame_sz depend on len size */
>  			xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, size);
>  #endif
> -			skb = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
> +			xdp_res = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
>  		}
>  
> -		if (IS_ERR(skb)) {
> -			if (PTR_ERR(skb) == -IXGBEVF_XDP_TX) {
> +		if (xdp_res) {
> +			if (xdp_res == IXGBEVF_XDP_TX) {
>  				xdp_xmit = true;
>  				ixgbevf_rx_buffer_flip(rx_ring, rx_buffer,
>  						       size);
> @@ -1189,7 +1186,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  		}
>  
>  		/* exit if we failed to retrieve a buffer */
> -		if (!skb) {
> +		if (!xdp_res && !skb) {
>  			rx_ring->rx_stats.alloc_rx_buff_failed++;
>  			rx_buffer->pagecnt_bias++;
>  			break;
> @@ -1203,7 +1200,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  			continue;
>  
>  		/* verify the packet layout is correct */
> -		if (ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
> +		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
>  			skb = NULL;
>  			continue;
>  		}
> -- 
> 2.34.1
> 

