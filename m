Return-Path: <bpf+bounces-64333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD1B11AC5
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6201416FDCD
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9B2D0C88;
	Fri, 25 Jul 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oI4tBzpL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93046253B5C;
	Fri, 25 Jul 2025 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435410; cv=fail; b=rxU+KiYfvmC/elSTOKIwYFoN1+OehZ160R0bnxd7ZGAGdwqDEhkPeEo7WjdZeV3HuR5X1U+6cpcvx8wlfshw7bK5NuXMTzKRb4uTae6ZdROIbA5AotKsfeCbzSHYOuKzcsOf5ITbDzO/QQydv3Btb2/k7iUy2uHSLazwOysdhHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435410; c=relaxed/simple;
	bh=FZAKFTdqmAJv9CwQozyyaKAXX1mDo8jCU/fEZpYax+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZ/iSzEO7Pi7JDjelGOnvwX4sn6z5UJU623hmiNn/uewZMYNwAIHGZqnzvhUaoW4Nw4yl8Pys5Trf0wyOt4cYML+vNo7Z9SlxHO8CKzbjGWSj3xZ95tYUeJOKZ0QNbfa5Nme4vCma8O7ErZjCzNrrP7/vu25otgCRWdVxwbiqJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oI4tBzpL; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753435408; x=1784971408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FZAKFTdqmAJv9CwQozyyaKAXX1mDo8jCU/fEZpYax+4=;
  b=oI4tBzpLxfB4iiFwFUMHFnLs1vA94ZOCq4jFPsX2qQV30Z10TxQGNlv3
   8S1Ub/jhVILyKb/IWoYfGE+IwUFz167Z2J1/bKwiAYNM2ZtUhYnqaBSob
   yxk6jjOr5J6rjK7i+Dbv57LTjZ071tRYWZrC6lT95veII+8vGjqrWP95E
   mZ0A4YEq67puJDT2efWt/B2WWBfSIe6fxaWLNvQjLbiORPWotva4BEQ2u
   uDMHjUFrnVVSqSGgj5q91RkdlU9Au4gBgQZAovO4qeujP89tUBfA6vA9I
   2oFldrudpM5Okv3ZkfjKaiPscaL9HzwmqeEjzaLaJpHC4AYeFXGQ6xMSy
   Q==;
X-CSE-ConnectionGUID: Ez8Y5bi0QCqqouMWzWVe3w==
X-CSE-MsgGUID: ix3DeSpEQh6OPDtukKVqZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59585477"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59585477"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:23:23 -0700
X-CSE-ConnectionGUID: DMpSxmumRV6RdfctOl0Zeg==
X-CSE-MsgGUID: 9/j67cQPT4KVGhNuav1d8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="165059864"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:23:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:23:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 02:23:22 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSOuuesVob6YtIe3fUqFTZ1uJXBmMStmMxn2fPjXRULLMwy+8YgGNvVewy0CvpKyIkYUmZ/xrLmDgx4tS0B5suziOD43TJ0hjotmbnmCDB4JnrgvNcGOrB0mcNkb7vP2osIgdigWpLXpXFz/q4lKBVSA5MCJ9hQkJvTgLHdocnxAt82cszH0kIGdBdI+qBMqxYmQ3teJKHGfM0QwW59auBjjV9w/V3ax7IrLoRzHuy0HMfKBoSPEGVa6PuIi46wspDM+yBvF7jzhLcUwv1aj2OkVNYTGkEBsHH1HKYnlvLYv4zj58vJ3qXpRg8rTCGs5vCFoVQ+qPDxuefj17Oa/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdT9lfCKH60llpypo1mN7DS7sEhI3Ps65SiyyPl7pB4=;
 b=FhIc6dPoso948lBXbaBrS3eCww/+fbXr4YmOHWWGc2EAsvI4bqHxNKc5sqPnY9aG59Nrb080wNkCDts4J0pgq9ZCu5Hv2VpfCzBOUPjbpapl28hBxx1KB9orl0LffQJPFXRfJKdoMM/n+rfdz4NPVozwJONLcGqXNyW0sDJPelJv1VMQFx6lFkgXlk4o0KA79c9YRIBMmTWxhmNPJxG2h3jCxHgM+oxZ8rAf3T0lUhMr5TGwrZkaHHvjy7uoNsyL+i6XfN/z2iWidB1q5KryvYWEZ9ZcVd12f13GmQfdu/pzAMNW6Y+v9yqDkob9HiW/NrQUvZIxsdUh6a9JEFTzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 09:23:06 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 09:23:06 +0000
Date: Fri, 25 Jul 2025 11:22:57 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 1/5] ixgbe: xsk: remove budget from
 ixgbe_clean_xdp_tx_irq
Message-ID: <aINM8UdNOjqqdLHw@soc-5CG4396X81.clients.intel.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250720091123.474-2-kerneljasonxing@gmail.com>
X-ClientProxiedBy: WA2P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 25865a5d-cdcd-4f2e-662e-08ddcb5cdd3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TxEU1IThRexEnZteQ/ZhxvYri9NduhxS8QS1/cDPB9ndMCrb6wnzkuHuBqad?=
 =?us-ascii?Q?tzeY1KoZkgos+Qs1aRGnsGfPi9K3e/B9YTn9ACmL+l+WY5fGZgEoCcgQnopn?=
 =?us-ascii?Q?XZGXy23kTt74IuStmDC2eWcSyKWUvpWOmYwa98HIOpRSm3UbOleG7StyRK/Z?=
 =?us-ascii?Q?5xCIC3oMxob8fv5ITaS1ssB/txz1FKQ31GE6XXLzlr5k1cYCN9E2t+Wr4vxA?=
 =?us-ascii?Q?LcMDMyjxbIq+JVMMpFBhAFMh0J1FxA2kJGf2AZH7g1WXTOA4uEc48v6T354r?=
 =?us-ascii?Q?GUWmn759anpslUNs6ygq/IkIiPilBiVa4PqKgm9bKSIhDTU9K0+sfDvOkAmI?=
 =?us-ascii?Q?gEcxjeFfd0hc1kM6cwmGJ4/i4IXdkiqdRXk46QvxEf3PgGy3vaR85E1JxR0J?=
 =?us-ascii?Q?kS3tkj3CRt4GxuM8vsBj/tMY36fY2ZqBzJT5YYc4hXVMA/4xBdbVSjaDaxqv?=
 =?us-ascii?Q?bAzOKo8raBLYmQKB1/51zIMX/wS8ZQrSEpW/pdlSMhJcjZ9b62BBdUn8yL8T?=
 =?us-ascii?Q?MI+d1kMXiMYwLjy+5cU4miiupApx87xhGo/pt+R26jVoq0JkvITvCZM0PV43?=
 =?us-ascii?Q?UWsHbAuxgyRzzAAvDGI7MigvuvL5ZSF79B9191kCN+YyiswRPSkzntlulgRM?=
 =?us-ascii?Q?xD6bJUSr2cNsdlxpe58hnsMOYWdsnuQGobgmhkAQmPjzG4Hkcnb6y7O2LHc4?=
 =?us-ascii?Q?/LkS1BL0DrPoBUYnYHAk9OXrzoVVzR3ynDsfu7iTJuJCM7pVFkoy9Lq2RXYq?=
 =?us-ascii?Q?xJ3NbWPeeywsjtEKue1KyI7dfE9oc715m8RPKS5clm8jhFHrMJZ/vCOkBsYx?=
 =?us-ascii?Q?d/ZaqUdITfYCCf89hiaLSGak0O61z4O4Szf7RAzqmVqbmLs6ze4YPefeHeln?=
 =?us-ascii?Q?i7OXwKVz9ovQhXfQcKUftSHBqdeB38igR5R4AAmad8wSVKV4X2xXEBdg1U5H?=
 =?us-ascii?Q?KjKKEyQ12OdCe0UQ2OsfOSCx/bE/MtPF5EIFPNrVd0uHvYhnb6vWcOgDsuEL?=
 =?us-ascii?Q?k0vKqmYXwyfO8mLwELbWX68PwW1BpmJEk8Vt2e5zXFDhWJjOj+oIjarQ3z4j?=
 =?us-ascii?Q?CK0pdQzr5A0WILcPW8JSuwsPyaBP9kDrsssxFwZZ4IFrmNcX/HJ0fZA1Mi0x?=
 =?us-ascii?Q?gz09lHi3zWOnbON4f412cC1XXEtUGMwRV4yHQExqfByvByf4h6v+T/+Ifit5?=
 =?us-ascii?Q?il/oqYqu5hxmk7rvx/sz1AMk375oG9Y+9yE13tHhZ8KS7xGvpRJaG6TIiGz0?=
 =?us-ascii?Q?EfLJM54+1BVapNhP3jZ5S/zCpWY/9QiY7ntDlnbh8BOvFJMaznKmnAf8Bvcl?=
 =?us-ascii?Q?orT/ArMzhDcbF6JP3rBckpzMHUX3Wd+liRWfburJz4gK9JKaBX1RR5uDC5jc?=
 =?us-ascii?Q?Dab3OIeZG+6aUl63bNxt3V6yOOkKc1kePgzbjmHsu82Z+7dsIKzPFo4Hcr0S?=
 =?us-ascii?Q?TEpMnBh0QGU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3jkqkT+o7fhCTj7vQ64MhpCAZINdG0bY2ANqf+EvZV3bo2yrVl3VFFcHEyd0?=
 =?us-ascii?Q?GlZgAm9TzzLB2kAbSXFI8fRbjjm3TxgCZ06956L2I0PdrntSWG5M/x1mL5mY?=
 =?us-ascii?Q?t6bpV8g5G/skifKis6WRMiqo6hH1gQnUS9QuZJut3TFymz0NhRIeyvXtmXEI?=
 =?us-ascii?Q?0LtCYzFzOfSZzSMmbPmtdJ+7/G76LXdVvl7T5M7kgr0iDKnOn2i/oSIUCLSu?=
 =?us-ascii?Q?6Dq9MlBmjpOoOP47mmPG2TWH3L4G9qF50maPCoFemGujfpejH5VJ63ACv3Dp?=
 =?us-ascii?Q?8EdmlkUBaXkoiZADooN4ir0ja8m1z1UjfV8Wdn/wM473tOpob9qZWPAvAGe5?=
 =?us-ascii?Q?UhVdFgtS35+u8UJw9nCM0zbHNuTmQaCJSuA3CSngsHzOxR+0ivQw2czhiVZz?=
 =?us-ascii?Q?uutqBwdzcixYgFRztqqSiF6JH/RkvBy2sET7DaxrZDdoj9eZdvB+NJqs+pmj?=
 =?us-ascii?Q?tyvZp1wct3mbVmj22pwVzWjzOaop1ptrCIKLmqQOyR4iGQDvNjeo6AGbGCYT?=
 =?us-ascii?Q?WQL876Qe1R3RzH798FCJE877aFt2mIeDbks34YtC1tWowvVhxgnPsye8jcOh?=
 =?us-ascii?Q?g4A3SZvisJtOfXEstwkL9FfAQmdT48fTSvXljRyM2rT1xQMjnE/kXD6gV3/N?=
 =?us-ascii?Q?AazaTFyLAK3AtChQ0lnOzj2kbayWwAT7a3cF00QUR+nIvLiuAhmr60wg9SyQ?=
 =?us-ascii?Q?Spcrg1+igwEDpfY2qh7Vi8rZqBfrZEKsAb7zFvDqXTGOsqThs/75oQIktRKk?=
 =?us-ascii?Q?Ars5HUYvi/8ZDvcZ2THEYGfSgfyJwZWcd3SCT7SrU1fdaDu7JXezjrX6eZtu?=
 =?us-ascii?Q?qjmHkbRQkhVHtFL6Qt0CEOF9s5yqV2OAHQ5JYKQkzAB2hQXLVSrsQIhYnwNl?=
 =?us-ascii?Q?5pVhcjvyhZMdr07LhIvSle/FQh/ppStpsQSWW47Qy+pQV3+KtcoeA2Z3osvc?=
 =?us-ascii?Q?WG+icNmY3RvrGIcLO+NFHp12z2Xbrjn9xVE6TCLgFJBwYWrQS63aQhEPDlpa?=
 =?us-ascii?Q?G2+wEWRAqIWXPRmhZMCzYHRwu785noFDqpG6CAbCGnPFzwoTORw4GkiOSRzB?=
 =?us-ascii?Q?W3K/Su9BkBlfH1526AH9YtBRYQqaYF1/iiT95usefMAzK9opQvbOJryLRHc4?=
 =?us-ascii?Q?iaf+wIKtnGyTi+wmEjNNhO+CjeItZh9wwTBgqEWxcuvfRqYWAXtr81TqQn2j?=
 =?us-ascii?Q?UP4p0vEA+t0Y5kV39iyzhd5y0GrizzkFrgiDgzjxQI4DK0O1K2u9SOzLLPeE?=
 =?us-ascii?Q?HuTGO+cU9MlTRpX9JvEJ6fFYVXKu9WJ1ylx61fcEuISsQ7gaMnlA63sbbwoy?=
 =?us-ascii?Q?LK5YJbz02Xt9Nxv2eL+PTxyh1HlUpRVsjveEN3g/hWCwOSNyhLSffcb9UupL?=
 =?us-ascii?Q?8AYwMmu6TAU9De4bqnNY3MmV4yyHYUEwujYYCieNljj+omcIpTOeJi8i9gIe?=
 =?us-ascii?Q?7t/6fSXu7z0+hqigeZcZ0la8zDn6MZIQoqZqCbCn5a9+KePE64a4fTQJWcMR?=
 =?us-ascii?Q?NEgUWx6f8cJEgd1J6GWOTD1QkT6KMHPY7agBdzV2H3s53REWwpB5Wa7Fokpk?=
 =?us-ascii?Q?M2aH8nsbDeSTSDSbn/x3ef8RMApaJFV/nNxTTputNq458/saUP34rZ52Mejb?=
 =?us-ascii?Q?2+K/fOCiNstvFDoKRv3CpVguIyqLg5MiXpmUr11miMGFlwSd0tpmyV1emuKd?=
 =?us-ascii?Q?FPtlGA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25865a5d-cdcd-4f2e-662e-08ddcb5cdd3c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 09:23:06.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBgXAVa82tMbkUM31D4odcoe+sOtlzJ4B7DqPtEvi716JxJVbzNTkWcYstX5EJfb6wxGnmHG+fNSx20JTwUxywyllXGLhi4OhobXHOlNUAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com

On Sun, Jul 20, 2025 at 05:11:19PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since 'budget' parameter in ixgbe_clean_xdp_tx_irq() takes no effect,
> the patch removes it. No functional change here.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Should target iwl-next, but otherwise fine.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c        | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 6122a0abb41f..a59fd8f74b5e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -3591,7 +3591,7 @@ int ixgbe_poll(struct napi_struct *napi, int budget)
>  
>  	ixgbe_for_each_ring(ring, q_vector->tx) {
>  		bool wd = ring->xsk_pool ?
> -			  ixgbe_clean_xdp_tx_irq(q_vector, ring, budget) :
> +			  ixgbe_clean_xdp_tx_irq(q_vector, ring) :
>  			  ixgbe_clean_tx_irq(q_vector, ring, budget);
>  
>  		if (!wd)
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
> index 78deea5ec536..788722fe527a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
> @@ -42,7 +42,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
>  			  const int budget);
>  void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring);
>  bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
> -			    struct ixgbe_ring *tx_ring, int napi_budget);
> +			    struct ixgbe_ring *tx_ring);
>  int ixgbe_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
>  void ixgbe_xsk_clean_tx_ring(struct ixgbe_ring *tx_ring);
>  
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index ac58964b2f08..0ade15058d98 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -454,7 +454,7 @@ static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
>  }
>  
>  bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
> -			    struct ixgbe_ring *tx_ring, int napi_budget)
> +			    struct ixgbe_ring *tx_ring)
>  {
>  	u16 ntc = tx_ring->next_to_clean, ntu = tx_ring->next_to_use;
>  	unsigned int total_packets = 0, total_bytes = 0;
> -- 
> 2.41.3
> 
> 

