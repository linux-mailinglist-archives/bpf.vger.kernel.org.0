Return-Path: <bpf+bounces-47338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE19F821E
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 18:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844001889C17
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227031A0BC5;
	Thu, 19 Dec 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XP7Ke9ez"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E73C30;
	Thu, 19 Dec 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629722; cv=fail; b=eOc3bz8O/ItHvAmivc78uBAs4dx6mNLo7KntGrRhE8VaqA31HkpbLhdWjje2eQpa+FzkytSAQAm2BiECf41ug5qWGc5hXlG7BTndhb6G3PpHVR972LdiODHuzVkjHsr1QIPvLcrvbBLektCeDEkSuU3aPU1psa08Pl6BomVvLh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629722; c=relaxed/simple;
	bh=tJHtoe3pl0wpmPQ62CDAowSIDF1hNJJ2bXpwwqLKM4o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=maG65vXU70oJbi+zJLBRW2eC+3hRsKN5ZXKJyUQsAH7i+2zrBdJEF1giXG4wDtIq3tfMOcoAfhi78lm1uPgA5lTI+St9dIDOQbwYrX4tIMCKdjeMRGqDxnQXSya7jyKLVVH4CMUt6ciLqWdmyVC25e/bSP3k73sknSZg6fRbE5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XP7Ke9ez; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734629720; x=1766165720;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tJHtoe3pl0wpmPQ62CDAowSIDF1hNJJ2bXpwwqLKM4o=;
  b=XP7Ke9ezbPYJxYOdZ4QU9xlgBdfWliFzqXfmPICOfchpH6oWK4q85zJK
   zr357RKkcbIcgECjmEYToSbX2Wyp7JLXh8MbfEp9cktgEL2LQWJIzA3yt
   wd1fFhDqnmdA1Zs8R+AW5w+rzgdZBqXDUlHrUZP0dJ52CECpRi1vt7UxD
   Cz6dlvkk/5lDX3lhW/UpeDfFAZrUruK46ckfbo6VycIhe4GFhlUe1JwKg
   Q1kJksBCKZm6AN7AWNhBmao/BC9YlQulDtXgzx5dsV6xfyeiLLJ2wtR2p
   WVP7F/f9hZpq5e+eNpMFMINLzXVuGZB8z9vqct9ARwbYVVyZruquZPE2P
   g==;
X-CSE-ConnectionGUID: 2snYqqPST0Sy4NuleDSY8A==
X-CSE-MsgGUID: pPy1HFdARQCJqL7ZM3jsTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35304937"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35304937"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 09:35:12 -0800
X-CSE-ConnectionGUID: p4rSL4BQR1+n2vPhPZljyw==
X-CSE-MsgGUID: 95XGGY2NQKK2XrFBZu857A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="98318002"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 09:35:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 09:35:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 09:35:11 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 09:35:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkgmGfJ/en9cPlgIMBEOpS6aRc0zCBHgvGqGYznBML2eOhqdMBxE6DQ/ZQm12xpnY1KeqaEt/541GE2ss4Cabk/lNdkNC9DRI6zjL6E5PRhCGPP0e4d4G2t/kV+py6P9arNeVWPfMziyJAX1cZ1Aqy1IPoNZQhkqlS990EC199pZZbGKDpg/oVCieaUCKaym8H8R68XOjcaqALH0+txXjYdAZAxa80wqcgSIPTFDE507BLZ+CYzseGNxsm+d3cb3bYSNx5AcejxAJko179ERJWzzCwUXY4VnNA0EMz7LGgVVrQJM2ol1UxI5GBFw/YFVC2yoehMNtdW1HXIso7bUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBl0TjzjPKd5ZJTHPlLtfqMMUKrgilp89Eyf4K+tf30=;
 b=kKTGMkPnLF9INaykXSs+0n5qxVd+jzP1PyKIKUbGbBJN/Rg0oTpWl11y02Yzb/9marnYke2viFsv1EsoUZ6pURLDSFu+8Lu6TXGc6oduZsBLad7q468fvXzwh4pS4hWQ7w0SwwJxfb8eGP40J9rh+hREH1frbsZHzPOJ+IKe8lgca3ds1OyfmyTMtU7cySralHTGlvVFtxlU3oMuWwljNJcWsslDwVvouQeYy4yI/DQJOdUimJ0CbaZ7kwA/ZZ8Yt/5/EVFBxZNUWIxz7ssjE5gn7qKZ6G7ddTodVqIQJ8Xs5y2ZnZc4qG6JQPwHnF5bOdxUouBDNuQTXC8Z70PNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB7986.namprd11.prod.outlook.com (2603:10b6:510:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 17:35:08 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 17:35:08 +0000
Date: Thu, 19 Dec 2024 18:34:52 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
CC: <netdev@vger.kernel.org>, <jeroendb@google.com>, <shailend@google.com>,
	<willemb@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <horms@kernel.org>, <hramamurthy@google.com>,
	<joshwash@google.com>, <ziweixiao@google.com>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net 3/5] gve: guard XSK operations on the existence of
 queues
Message-ID: <Z2RZPOpPa29z9buo@lzaremba-mobl.ger.corp.intel.com>
References: <20241218133415.3759501-1-pkaligineedi@google.com>
 <20241218133415.3759501-4-pkaligineedi@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241218133415.3759501-4-pkaligineedi@google.com>
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 925c8fff-9c75-459d-7c83-08dd20537b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ogz8tn+zDzPcSF8i8B4j+OQni7Qr1n3hc8FJuTfJqsa2w1gqLoXgw+H0ehM?=
 =?us-ascii?Q?S74GZv01lsM0+eVNwa75j1JTUEKT1zWpoFnHGoMS0KY6Nbkd3xGSECvk5szD?=
 =?us-ascii?Q?mfkfOIhd/xSso8KHODad0+DUqAs8DkaHbFxkb9R3S/+vimeo5THZHmCv55rV?=
 =?us-ascii?Q?C5YKA9GUhsi+8hxSAKyyzKQ1BtkBh8qHrDyclsiEzASl+Qu2DkxhaZWhvbCV?=
 =?us-ascii?Q?186p2Mb1RFbtgVZ1iUJDOKhdBe/eS3XK5lYQwKqZRGXWcJiU4dPJ6cA16Uww?=
 =?us-ascii?Q?jHRCPPq0skPghwMCjn+HSLCBMPe6GyEB9dvmCD+enX3NR8lOOLc54/6H7pTs?=
 =?us-ascii?Q?XRNExh4XVtYyiTlcsrZBULJZ8CleVbtT/78NesyrMHOsNFBxsrJmX9Dr9tbr?=
 =?us-ascii?Q?mW871KKQQJbG8bJUfPWYLB+mOA+FBvKi8kSyK1924XgFIVVfrGrtlvqdxfmB?=
 =?us-ascii?Q?C+fL4nG5YlPaSgrQOd/eFvF/r5P/juQA1IpBJrwSRvG9VH/lbZYebeqr+SlY?=
 =?us-ascii?Q?p1YA/POKk8+Br21QTdMpXbbB7fa2cXVA5qdJOtZlLa/GmIamiqg7H3NB4lRL?=
 =?us-ascii?Q?STUGQSM1ooJLdosE9V/WswxXdAAzb2prcYB5bEzHzdtHup3RYd4XD41ACHgw?=
 =?us-ascii?Q?eMU7wYqTqxosyXGCs6r0uk/+ex/1Q2mmQZvOYAkH/iQG7ziRkFzpVDzlkoz1?=
 =?us-ascii?Q?goBeL75dAjV4ctI80tVEeOUkqeRSVn9nJL/YUAim/t2uG9MwDDVoA9QJMV7N?=
 =?us-ascii?Q?jh5dRDeA93SmAZ7Cqx88o23pCaAOO9wiQLqvJ7bY4DbVvC6WeAxzMt4kPmoc?=
 =?us-ascii?Q?eaEdsS3o+KAwKYtVrUSV7MjZW2CPCNE3SKc71OiKZjbdzpm/wSGA0whAdjs3?=
 =?us-ascii?Q?/dMDx3IxkcW8ur3o/dI93V1FSCA9rSFZ9FQHVC6NTg62S88zVDzXuqXk0hy/?=
 =?us-ascii?Q?gqKRwZmRCivKDzlMqSt4dUzwYKxc1G9wfnLSCIXyDL0hkNIrtXQz3ti5lHJV?=
 =?us-ascii?Q?hVTsoT7RLaZRSjlf9mLZQMKsOyKKf5QblOjAF9GoLhbwApKsc4J40EXUmN9C?=
 =?us-ascii?Q?eq0BmqBhkF8Ip7jNKKT0XD9NiZVl5bU+SIyeeKyf1do32/AZ3hdDHEXZVqOU?=
 =?us-ascii?Q?pMGhvdU59S4mEL3L9Xq6yQJ2DUxeSaErRo2sB/90Y0OuX0rGAnJtxN4JTXoX?=
 =?us-ascii?Q?hSnI8cS5s9mC40UyQYEUjAB5CXJPV+frhrUS+1ZjOOw6OMmDeotfjjOSKjHA?=
 =?us-ascii?Q?LQQJMACPEK0GigmiFfTohzRMfNY9rw070I80k9tp5lruiFdfuHm3Chz34hnU?=
 =?us-ascii?Q?LQ0cYc46SQhAAw1yLXwKrYb02Ka8T/8JyZmYCWQdl+l3x7KumwyFc9XE0Prq?=
 =?us-ascii?Q?TKqgqkuxyQa3JtT/hH0b31T7HCx3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5FzDPNkxqDtX/aRcuGCyr5Tpv6DTfyXQ7vWpC5meBHrN6sZ/7YvP8wZCp23L?=
 =?us-ascii?Q?FfqRsEznCNCNWGUuCmDtdhUatc9ld3NAwdi/3KrHByFYrcFNpVNoP2Q3Nn43?=
 =?us-ascii?Q?mG/8k0Nsq/8ei+TxGkLu5TYiNLZQG60qyP3UpZQyY3h7j79IG8Dmsi+vqjU7?=
 =?us-ascii?Q?WH4220PCUa8pCaTtzwdmkaw06GMn+QUJ4XC2EDYScKEBAJXqk2F0jYT+Fddg?=
 =?us-ascii?Q?+88PYUvrN2IYPQ8TSs7gq7UFVJYzGfCMyseeT/TSdTeNwe7YhmUgl5X8CnCM?=
 =?us-ascii?Q?i795QNBozuDMNwQ7lS8idFkIofHgDAOQhK5rZORaa+n8ddRlNYFkEJy+DB1g?=
 =?us-ascii?Q?era1rQ/ZYzNkr4E+JOIt4C9ad58TPVLULcciuuDtgnPa02tAtMwfadc6uxXp?=
 =?us-ascii?Q?FHqV/V2VaFyoTYM6g2QeL6WMsQKybT93MObC+nSDhRx5hMo+EnAfq8HvqZqY?=
 =?us-ascii?Q?kEo1k1vawF+GnzjBPq+EPVq73mLLbGZpakgH7jG/7T5zYmm3zIa31HXYn5sv?=
 =?us-ascii?Q?5qKWvo+1KIcLTcmgBSOpIzew3UaYoJmDVayu4t2oAyHZXvSTGnEqzDuSyl3D?=
 =?us-ascii?Q?U9NUy6/CyFLiAmyP9FRN4tFDJP4lIzrfWVcJwHdFpSiK4a3/LEtKFuR7P+eJ?=
 =?us-ascii?Q?XS6026OXAP1+VEwu/+lRGV1qmEjA0b7NlzmRMmiymPQOKQMooJzT2PQ/UXZ/?=
 =?us-ascii?Q?UTigqoUDhdu/ymY874ywapqDXAdZGgIQ97t1ujVX5US4u8U9AwmxbejK55pj?=
 =?us-ascii?Q?ZExu3iY4Dnqp89bhl4WXWWkVnayvlS237TYaHOo+wBxrPyG06V4kGDykihtH?=
 =?us-ascii?Q?bckf60GDop0EvxB4+valc15CVTU9tsVpOMsnXCkz839kPM4cNOr4PvDxCgo4?=
 =?us-ascii?Q?4NN/qq5qRXA6CLJIoU1Akz5FJW6ZESLB5RWm47fvjSrqXDtb8VZ70rJhHvP1?=
 =?us-ascii?Q?SuWPu50fH74orpGmcHVx2lATmTcWHWoJrItTno1DrRFhp8cWfErSNiTT5npp?=
 =?us-ascii?Q?k01RgF5X0K5jlwgpmL8zaObTXFMxkLgLJhKcoHxQ8j1rRNU2T8+wcnd+s7KB?=
 =?us-ascii?Q?w60Hp3moo/VW5BVCxAtloq8vwGbgGGP5MOaOYL2C/OCAkPrS0MlU7uaj7ypZ?=
 =?us-ascii?Q?cMCZhwAzvVV8PO87a3TAtptGit+WJZDWfJXL8Oee88qnXyfj5FwaNO86EizP?=
 =?us-ascii?Q?JtfVllwSVOC0UfH9fkNvMNqvQzj2oHR1ptHVHh4SgF3qB0qTIngiYPJc3Cbd?=
 =?us-ascii?Q?vG9NTy6WeICFwJX0xW5aTuvqksyoUTHa4Q7FN/2GjbTf0eJ0p1LdN3wfrP0D?=
 =?us-ascii?Q?IHFzzvwNMTlRtG7mjQoZOVcNkCUefAzQS04QFNMrdr9Wmhn8doZnAuhAmfPA?=
 =?us-ascii?Q?/uL5UCLqUhBUPyfHee1R51PswHqPmn26dGmqS320KV3LSwA4OAptunhWmScn?=
 =?us-ascii?Q?HsF+7KJzdnthbUlNr+kX2JbcealWLQb6EFy0kPZBMChEyRjpAwJ28lMC4PWB?=
 =?us-ascii?Q?ISHiQ4v01yZOriA1TgUnAv5pYo6+yrH4+kwXIFFtUKppHVjkW+uD8alz50R1?=
 =?us-ascii?Q?gANPRPn79QU5NfvoEpRQO/RoBpQqCRExjLQdj8NWmCEJNj+F9mbl45sUbqou?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 925c8fff-9c75-459d-7c83-08dd20537b76
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 17:35:08.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5bzblUJ0Fq+sAUCQRpXFFG8DoCEY8mBr6vndkhrrVpoXEmSToPTiTgNnExG5tFmqpO1GZZ5a7nerEjA983CF0DFszcpYYcwXWEIKDiMg2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7986
X-OriginatorOrg: intel.com

On Wed, Dec 18, 2024 at 05:34:13AM -0800, Praveen Kaligineedi wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> This patch predicates the enabling and disabling of XSK pools on the
> existence of queues. As it stands, if the interface is down, disabling
> or enabling XSK pools would result in a crash, as the RX queue pointer
> would be NULL. XSK pool registration will occur as part of the next
> interface up.
> 
> Similarly, xsk_wakeup needs be guarded against queues disappearing
> while the function is executing, so a check against the
> GVE_PRIV_FLAGS_NAPI_ENABLED flag is added to synchronize with the
> disabling of the bit and the synchronize_net() in gve_turndown.
> 
> Fixes: fd8e40321a12 ("gve: Add AF_XDP zero-copy support for GQI-QPL format")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

I think the sender's SoB still should be last, but otherwise looks good.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 5d7b0cc59959..e4e8ff4f9f80 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1623,8 +1623,8 @@ static int gve_xsk_pool_enable(struct net_device *dev,
>  	if (err)
>  		return err;
>  
> -	/* If XDP prog is not installed, return */
> -	if (!priv->xdp_prog)
> +	/* If XDP prog is not installed or interface is down, return. */
> +	if (!priv->xdp_prog || !netif_running(dev))
>  		return 0;
>  
>  	rx = &priv->rx[qid];
> @@ -1669,21 +1669,16 @@ static int gve_xsk_pool_disable(struct net_device *dev,
>  	if (qid >= priv->rx_cfg.num_queues)
>  		return -EINVAL;
>  
> -	/* If XDP prog is not installed, unmap DMA and return */
> -	if (!priv->xdp_prog)
> +	/* If XDP prog is not installed or interface is down, unmap DMA and
> +	 * return.
> +	 */
> +	if (!priv->xdp_prog || !netif_running(dev))
>  		goto done;
>  
> -	tx_qid = gve_xdp_tx_queue_id(priv, qid);
> -	if (!netif_running(dev)) {
> -		priv->rx[qid].xsk_pool = NULL;
> -		xdp_rxq_info_unreg(&priv->rx[qid].xsk_rxq);
> -		priv->tx[tx_qid].xsk_pool = NULL;
> -		goto done;
> -	}
> -
>  	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
>  	napi_disable(napi_rx); /* make sure current rx poll is done */
>  
> +	tx_qid = gve_xdp_tx_queue_id(priv, qid);
>  	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
>  	napi_disable(napi_tx); /* make sure current tx poll is done */
>  
> @@ -1711,6 +1706,9 @@ static int gve_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
>  	struct gve_priv *priv = netdev_priv(dev);
>  	int tx_queue_id = gve_xdp_tx_queue_id(priv, queue_id);
>  
> +	if (!gve_get_napi_enabled(priv))
> +		return -ENETDOWN;
> +
>  	if (queue_id >= priv->rx_cfg.num_queues || !priv->xdp_prog)
>  		return -EINVAL;
>  
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
> 

