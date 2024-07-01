Return-Path: <bpf+bounces-33509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D543791E55B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044DF1C216C1
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779916D9C9;
	Mon,  1 Jul 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vesn/vYY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B916D320;
	Mon,  1 Jul 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851333; cv=fail; b=n17YF4nuDZMAIUiO9Zgr/qoZ2zYaTgzDh6ek9MW1QduY+Fgz4GTtHPzysIR9F0ywn6BQbWWjHU+TCtlRY5PxmrU4s+8tjnNkYV0PRsOfMxTv0DWy7lR44PJ34r+I3vy1LKHdqAXLpfVOu8AG3/EziVT99mqQxN+EyZpYcqBX3GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851333; c=relaxed/simple;
	bh=i5haNELSK4AMKNLYuRx6JxT6ivixPis/V2iXzCGnL2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DSsAti2t7jacZ+meZ066m3q9ZQZnxOMRf2eErFl4lxyPBESEmYoOzT3EqWb5OXfM8fqjeVTeVAETf4sOZ+8YLDHpoCbM5MSg/DYO6k/nL8Oznu38VOqW/fJ+nDNsFhcd4rJ70gq51CpjxVfZ55GB29a3xicz6RpgawI4Fk+1igc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vesn/vYY; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719851331; x=1751387331;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i5haNELSK4AMKNLYuRx6JxT6ivixPis/V2iXzCGnL2o=;
  b=Vesn/vYYxvBFs411zF+hxXSCqHMvmta21Yi9mp+yYnDqj0Q6frt4HUs4
   vorP1tbw5fJOHbGO5Rxak9rO1slu9EjGSBpO32lnQ7Vb0Ac7BUqvux0Cf
   xymRBLGoxFrseZ7mZf5Z1tz6ZIRnxej8+B09Rt4HBIiG1/gRJIQc5Jnrm
   Wv/gp2y2GEy6zl7UJYePo7gPlS215ctvPRSzMmp/By5xPGiUbnapk9edR
   MnCpvW4Ifgz+O5S2y2P3H11I5HCCkZGvLD6OdMhKBbdi6YVGPV8F3lEBj
   MU/mwj0+ZcvpbPQQDlfnWseEQBRBbwHOIUuXnhwD9G1aI3VATf490zKjw
   w==;
X-CSE-ConnectionGUID: Z8jE+tHyTwG9MyydyflMcA==
X-CSE-MsgGUID: wwWD6T8NQ3u1H61vFCdIdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16944128"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="16944128"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:28:50 -0700
X-CSE-ConnectionGUID: EGw4Vh/BR6KBnQHuiZCQ3w==
X-CSE-MsgGUID: p6RccArLRFuGEpW88slJDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45556033"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 09:28:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 09:28:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 09:28:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 09:28:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 09:28:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ9EAgvfx7RiEzYmCFvaj2JBYI1noLSaQyDQ2e/eUdlgkaICe/4AHpYj6ZM5cAcEDpAHywfKQfZjDLfhPVmiQbwKowE7raktKwafg5HfkXUm8qtZ8NUHwbNzkVZaiHNTTOXfx5OnVTs7jzvpkmIqESpJdZz+UNSAcW73KH5yv6uw/muzEjVdXZMBZVWZEWEt4NLJu8OnM/ZHtXGjBWHvENBRGQNg8/2Q0qkS2e2Cg5RLwWSO01MbwhEK+Z2AIQZXTOpcxJgFt0Lm+F+cotqdyi+4KC5JFAgOJYUP4HX/bUmU7gsVmp74aFedsq58wqcbnOqFce+kjDvEP8RcUnZh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9PqB3KmvTCEE9/oiA9T4QGVpQLCBAd6/V4NAA0/SvQ=;
 b=VsIG35aqLgXUcz8IBWMojF5Q8mLID+lbhRBK5F56zycqGcm4yjfm/drXV/kgWIRvNMnD3SXhtJCDXQp3wrN/l0D3A2qZiMTCCpnyYksrxkx8Fs8HVhhmNv9NhfdOUxm2rc07gY31GWbFNuJAaEhshjrVlgtoSg1Xc/NjUDJQhjBLnqEuFA1nYhc8rbvG1MCb1VG+pfZ+0CR9jGljJY4rmiVUAzTnc8he7DrcXNPzuXpdn7aMGZ4gEuV3iWJNhCjp0efl9S04FrVf028Il0lkWF1Fv2X82Bh8CXXSRlz4UTmeySC24UBctmPP9cqf7DON6tqtHCpiq5ywmWoHcBcn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Mon, 1 Jul 2024 16:28:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 16:28:43 +0000
Date: Mon, 1 Jul 2024 18:28:37 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v2 0/2] selftests/xsk: Enhance traffic
 validation and batch size support
Message-ID: <ZoLZNfZjzyWEQCyy@boxer>
References: <20240627043548.221724-1-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240627043548.221724-1-tushar.vyavahare@intel.com>
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: cd80cd5d-668c-4f2f-d302-08dc99eadfd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rqN1MPzZj2rw7akTcVuYoGQeNjnD+Ii1E5dTlpZLtf6tNWvJQJ+8XyrqoemT?=
 =?us-ascii?Q?cd7imxQ8a4M+RCfB1gl2ESGumZRtbJNp5k+cycKq0rKenIyCuaHj//+i8JcS?=
 =?us-ascii?Q?FHW7bMLKJ84sw2tICLkbJOI3OamPQnI31iIPVBHRVdCQovi7D4dXcsBxN4sr?=
 =?us-ascii?Q?EV3gNeJHf+KCES+dwJ/rxq/6wLoWA0GkrcJ3qBmj+4uk0dLKPsNgcAH6wF+s?=
 =?us-ascii?Q?zm9tPivvpk2UdkiTo1i+K2QAUtB5HcDC3G6H0ikSqHfQfiM7eah86ss343L5?=
 =?us-ascii?Q?d2XVNoLUr9dea4KDm3A7FkbXOzxZCREWCZ6m3YzVH8FgMVU1hn3pJDkz+A9C?=
 =?us-ascii?Q?ggTFYRjiXu2PRM55RPDM4i8uG774Glr6U/NfTLgm8DL+ujkvTrwF/DxM8rX1?=
 =?us-ascii?Q?DCVy/+6xGNvLVVpN0X9/qykYRFV567A24JhplDyug6xgAf0fgQQ0BfhPFKHL?=
 =?us-ascii?Q?kS/NNXw4xAzruzC8I9Ovmno4f2uDM9pVGjpqD0d8taoXsmihJlLWHgPnVyhO?=
 =?us-ascii?Q?kPCn5hi6TrfhoTeDtOhjDN7KELPX3naNp4bs5s8g/gzVA7EUYquFwjmJnD6W?=
 =?us-ascii?Q?rnlu0nRFSGAwib0SXvKPu+61frriWN3BcI3ipoORhfQLsNhLvuPfYQ8wyN3r?=
 =?us-ascii?Q?h8sZPD7rwDJ/pEYkbqkUEDYNtXn13zKV3FXNi97rmJbdkR0R8NvOaLsTQ5t7?=
 =?us-ascii?Q?g+3ww28u0O0W63I4bQleSXbF2Pux/CuyZeM/mW6aoLsybguKgBxNG3WaN1B2?=
 =?us-ascii?Q?Y7vNepPRWc/CvBSkqZ0s/FmQQXqYGCnR+0nEtD2u9GJMKDFC3wwK2y1A+003?=
 =?us-ascii?Q?WRbbClknnbsWmvFHGa++oJpRNfVzIZZ/SE5Q4WYb4I5Y6Oa9i1qNUWvzE8ZR?=
 =?us-ascii?Q?5xDFjNtViqZdCmMeZTQJh6Jrwp/TNo/PKpy03WcwCRObEDnMOxrWRVA1W5gG?=
 =?us-ascii?Q?nxtcRfnESXEccvSyZ+5d+m97DuWhS4fZsJJ7nq5BfYqt1XqU1604jWSYG6zy?=
 =?us-ascii?Q?Sj5Z9RQQdN0AGeCVPr1nS7dNlazfnr8IHg8H5vEioORkly9PnGWM1gX605mR?=
 =?us-ascii?Q?g/uxvUCAU5pNNkQJEnxZDtN0CmsNqgOuuBl1ihA1z+Xjzz3RSaGrH/cD58Dk?=
 =?us-ascii?Q?f/+i5JKEFxinIGLohzjl9i/ZDyxDYZZb0zWgrSmB1SNSN7ozsRo9KtBBpKmN?=
 =?us-ascii?Q?Z8RbH0CFJeq5W3wQCnfikmWI4OKNppZUhTdoCg0ln8uSaQLsUEEq36z8PL97?=
 =?us-ascii?Q?3gPEsHmfpNV6pYdymxdGzH/6DJSKtSzdfDpKTRHJ5xfj1u0HZ5MdwwMLYFrd?=
 =?us-ascii?Q?rB4vS5ZfDOdJznqhY/273OWK1z+hsRMolknxjpfiwTUK6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fv2upNPOgXyfCLkEwZlcQ95DA92m/fx1XEo/f6YbjPm/TM3N+GQdGIf5FeXG?=
 =?us-ascii?Q?Gb9OpGoUoGngp+cGrJ2o0pQpfC4d0j/FLeIaE0D6Af/Tg6tCXlZ/Cb4ByM63?=
 =?us-ascii?Q?v/Tvao7GUcultHRzZP6otu6IzUpNy1D8p7PQv4+7BWIRgoTlhh5Rw42gEcui?=
 =?us-ascii?Q?n15rEwl8H5I14+JnapqVtNzSjSrXrLoEch58Vixx1rGYqW45JcwzVFeghnbx?=
 =?us-ascii?Q?JlzMQay1d9bTjlkTv0DSeswrNoEcuE9/qCWb3o2LMtbi+nIw81TrxpISEeMs?=
 =?us-ascii?Q?iMJ4S+lP96NdRx9zVPwErD9ks05Qx2YuqyB6OWPIIOe/JlPfS/YGR2OnDynu?=
 =?us-ascii?Q?tmORBTWinulxluFQKzsDf/475Ezt60ACbf05+qxRdBS5YeEl2bFpU7hXM/a0?=
 =?us-ascii?Q?D5sCTPfwd10+ebTE0S9mM1iRbJsTihgMiRcJWYvnQhilPkxF6iDSYFZd9LDm?=
 =?us-ascii?Q?1cbyCJWWAxlhVLcDvm0v1o9THptVnVKEev6AA8mofd+frtmsW/lp/NllfblZ?=
 =?us-ascii?Q?zf2pjDzZ6e7v9qVAH5CvcDctRzP7WtwvaXED8f/IHY7+YsER9mBPc7w4MbyX?=
 =?us-ascii?Q?7fBtufpVhlEYN5xF94iiRYsA887WwwLB786XQkAZt7ojnbbr7RnFbhkU70fp?=
 =?us-ascii?Q?qrK47n+qDDPF3KMXUmmsRXTLKe4xxdkj6Dj37bBxgAi4DrVv7qOmqIdQIO1f?=
 =?us-ascii?Q?VaNxkLdM+LaqvpzbriezjJKXK/6BVdYuiMcoMQDvVW6FIWBLe4yqchFaLe13?=
 =?us-ascii?Q?3xX9H+KkU6pyz41JTZiH0RdG1g2MbpfXcY1qN422Mwg0iPqIbQ4UlHbR9ooB?=
 =?us-ascii?Q?Ygc0sN2m7S+/R61jy+YVVE3fN7G563lphj1sjHomqisxGT+AZ7LaAN1fvBI/?=
 =?us-ascii?Q?7ZREZOz53Urv46x9S+XjAocwIcoXv3Ffdj5iKGsUzrOKCh2YDExHO4pdqz6h?=
 =?us-ascii?Q?+119z7lSjeZ4iotPgKhidAlTD9Qmjtxk1+22w4YQ3Nc/r+Or7C8OTLZGIur1?=
 =?us-ascii?Q?UiC/fHaCtFjDLQhuCiv6YRdKqDHFTZIM6iqsWku8oTfIpVnsE1Rv+breBWNV?=
 =?us-ascii?Q?th8NcVXrT3gXAhNjgN/mHzgOhdFz2jxZc49FZOqAGf2WqbjuMP7WVy3/j7GZ?=
 =?us-ascii?Q?A2Lkh/jC69iFtRlHHR+u1/eYq/+K6jcZViVke/P2bPUUiM430XaUQgaACz7h?=
 =?us-ascii?Q?Pnvn6xyi9ulEYgou3AlNb7d/YICwEpuzcjtMEGjKTv+sdASeSk5m1geye8tE?=
 =?us-ascii?Q?2CdjYWdy1XavolGYGQSFB1F3LsX5L+4pzRXL2uw4lFtjEESZUxT9uURVATr5?=
 =?us-ascii?Q?Mx/rgzQtFwZaKYnhh2eIaLmeYfp3dh7DLoPIhb44HAvzvhDcAfw8/vtFr1pN?=
 =?us-ascii?Q?KyyqTERk9hJAGFTX1btSPPCOJ6bPB0YJ0x1cMfB44r1jQF1Legx/ixvNp7CD?=
 =?us-ascii?Q?mwm438z1MoQ6t8VebN7aFrRMGmN2DyhcWlv9Y6jx96D64TquFp+PF5avCUAl?=
 =?us-ascii?Q?lMDETVTwVNDyxjMqzW26XH/BLD2gUcPKNB/n7GtcKe3y1p3FNPJ1dbiAo4f1?=
 =?us-ascii?Q?+JxrCgYQsyK7gboafd47PBHgwMtP5ir9jWebVpngYej8sPO/E18Lq8IGi/KQ?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd80cd5d-668c-4f2f-d302-08dc99eadfd8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:28:43.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlQ6BaUGOOoNA5VnA0srp0BIPFcPUojaf/LvuIfhr0v0ehV44wZ2UZtSgTpFOJ7JDRjG9XFQelRq/VdlUfWWc2sZ/oEMzSzjOIz8oWquFtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com

On Thu, Jun 27, 2024 at 04:35:46AM +0000, Tushar Vyavahare wrote:
> This patch series introduces enhancements to xsk selftests, focusing on
> dynamic batch size configurations and robust traffic validation.
> 
> Patch 1/2: Robust traffic validation post-ring size adjustment
> 
> - Fixed the flow in HW_SW_MIN_RING_SIZE and HW_SW_MAX_RING_SIZE test cases
>   to validate Tx/Rx traffic by checking the return value of
>   set_ring_size(), preventing premature test termination.
> 
> Patch 2/2: Dynamic batch size configuration
> 
> - Overcomes the 2K batch size limit by introducing dynamic adjustments for
>   fill_size and comp_size.
> - Update HW_SW_MAX_RING_SIZE test case that evaluates the maximum ring
>   sizes for AF_XDP, ensuring its reliability under maximum ring utilization.
> 
> Ensure the xsk selftests patches improve overall reliability and
> efficiency, allowing the system to handle larger batch sizes and
> effectively validate traffic after configuration changes.

v1..v2 diff?

> 
> Tushar Vyavahare (2):
>   selftests/xsk: Ensure traffic validation proceeds after ring size
>     adjustment in xskxceiver
>   selftests/xsk: Enhance batch size support with dynamic configurations
> 
>  tools/testing/selftests/bpf/xskxceiver.c | 40 +++++++++++++++++-------
>  tools/testing/selftests/bpf/xskxceiver.h |  2 ++
>  2 files changed, 31 insertions(+), 11 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

