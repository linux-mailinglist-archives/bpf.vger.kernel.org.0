Return-Path: <bpf+bounces-72137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EE1C07848
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 19:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 583884EA7C3
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA6341AB9;
	Fri, 24 Oct 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLEhMvo8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64829224AE8;
	Fri, 24 Oct 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326413; cv=fail; b=S3rQpRvzjbby4TJFuBm8uDMB33xBRy0wpySoXNeK0cLTBEZF3dBOv1Hhs/mxs2XLE0qTg0ciG7a7k4jod9RpwFGiSOeWiKwOkDGvRfVf15L17nTR+cGFC69yjVMxVwJy6KNGOeg2tv/JJ1+SJ2Txd8hYvR1khVvBNXqQjqHEqpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326413; c=relaxed/simple;
	bh=ezzKh39A7mlfvLFdcu8z1a8heS8GfWtOwJioxmwwJSw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JYfW3snyMQ32QbHoxcpQHzE2s+YzJNpV0JIRL/uKeX1UgFnvN9Xoc384zTT1D0S5vAkEKOcfreoRoAiVdXT9/2GS0J3KnoTDVlKaJVZWD04vKk/8siqOr0i5WA97xRGTQn8HDlhwpQuML4Eo4/LUb9UKEKKjxWs1h9let+vWuNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLEhMvo8; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761326412; x=1792862412;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ezzKh39A7mlfvLFdcu8z1a8heS8GfWtOwJioxmwwJSw=;
  b=WLEhMvo8H+9wevmaRA+og23EmpLEuPgstFrNqaXlylq7jUizaYYFM/pL
   X0txXBpT2l4potD+64yZfROfmVAu54EN4or1fG1G0HUjj+BfbPFow1tpc
   vaHKd4Vjg2dDNQicW/aKlDiUM/WnyT/ZihCUg3cnoUX0jebB/3uDuS9kT
   q8z5m4pPDFWin+KzFS6xpD0SJ0SqzkRada/kNaRDrYH7DkZJsGBr5I37K
   SP/2KxtznK2z35NzUhv6MUSsaSlIla/kq9mQV94194oFE5KtLJHLhWwEB
   hSENucpRL/TBvTgCK3IbksvUyhP9p48ya7rFW2XLO7Q/hW9fqNZ6yQpYx
   A==;
X-CSE-ConnectionGUID: Auakdb5TRLK6W0NRJQNPXA==
X-CSE-MsgGUID: h+pA6TNMRmS8gK8H+Ftbpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63411869"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63411869"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 10:20:10 -0700
X-CSE-ConnectionGUID: CMAgKrd2Qr+8mhaLhykRAQ==
X-CSE-MsgGUID: PIB56CaZQA2DLnQ0dOU8Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="184186860"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 10:20:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 10:20:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 10:20:08 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 10:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szzeSI/CJvzAK9Hvv3TX2eCA29MnykWMP7B9d54VkoG5t2f7pjeMohBdSxZhppBcJFSIMyWFPip4etj7aU8Bs+KD/6eGg9V1ALyQVXN5PzzSQ6BAxtnVJXXouts9nE9y5CHIwJc3UKlaQp7qGzw+1q/JyjVWVEy7aABLWsyB8n5dJjgV+wiRY4n4NLC5gzT1/wHCF5NLlhbb61M0n4e5XcGb3bbxxY5mTn4Mn6mKiR8dZ1SQE7ImWZGnBRoS7pf3/p9S/Z43j89enE1oqQ5/hs3sL2dH7uBuZm/tMzpAVjD2JesbFJ1afxx+bLZ33fJc3k6RjnjwhBrCRkNynsFd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQvXriwE4FP6HWMdS5TwDeIT2DZbn5PvC4IALVwShA8=;
 b=IRtdRQMZMwUezyuFiDCRUfYLXK8+Ky6wUNiYA7yI9nLy8qVeDNC0Kb+/XAPeQEc+VtcCkLQ2utn8dMRH6aoBtQaJ2SchxiAfR+FKDKpJ7/JdsVdsRLrabJlvLOzHjJ2awCp0gU+1FuLj5R8If6v6z3jDAiAHd26cgCc61IgVxwtvaUpQQhTfWH06vGL5dhxcB9PeY0IIQIxhs9O2uzRL8xzi0orpEVYXohvVtUr1lGbSB2H9u/sP5NLJ6T36UrZg4qfIAi2BpWeYJlBmHxvmyrY0Qm+or8CvRUVglPeX8tyXY8Gl5Of3s0ev1mUQcKyl9CmN9ShymrAXyxhorD/bSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:20:07 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:20:07 +0000
Date: Fri, 24 Oct 2025 19:19:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
	<lorenzo@kernel.org>, <kuba@kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v3 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <aPu1PjwidRCdVvyv@boxer>
References: <20251022125209.2649287-1-maciej.fijalkowski@intel.com>
 <20251022125209.2649287-2-maciej.fijalkowski@intel.com>
 <87cy6cfy7t.fsf@toke.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cy6cfy7t.fsf@toke.dk>
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA3PR11MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: c50c070d-d656-4173-fde4-08de132193db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?w9FqwdQMQoiB+qX9gKlvCrnHUga9TrEl8pUu+dQlOVkgb/wYaujuvT1GDJ?=
 =?iso-8859-1?Q?TJRfEG++fE6TPWk3FvrNk0yTIK4zyszOXlyBKEbf33J+zDOGK+S6zmNThc?=
 =?iso-8859-1?Q?BYnpXfh4mf7XYHkw9DpKjZ/dR3KXMxezAG6tOErrWitif0/AQXX8/FLqgd?=
 =?iso-8859-1?Q?dpPbiHGpDaffmQEVu3oBlnPps9TirhjLdapWgxgpVL9Wllyyk01UqjN9Xc?=
 =?iso-8859-1?Q?2i1UgJE6yX9zWP3Srg8vgYcMo/AeNZ1MgIzE7402JQgAa7xLxcow+rMusR?=
 =?iso-8859-1?Q?NE3itB1KdIcQsgiRQhdpr+twwSlbSDP8+E9K0wjnlACbslpQ6mlze8bOZe?=
 =?iso-8859-1?Q?JcOA4H5AUiHfF6mCJwxyCQ6W00WkEg19MW9nse0nlRZ2rUrn/jTrjYnOsj?=
 =?iso-8859-1?Q?XZXBUp2k45vODIp2t5zdjFE6mr2JkaVDc4A4RZR5Jw016hzY7NyqZ87PQL?=
 =?iso-8859-1?Q?sCdnt83moQHRnlXd4NufdjVm9aMXMbAVtZ0qWSmBSJ5HXKqnJHYYxStl4B?=
 =?iso-8859-1?Q?2CfCZQHYMMOof2F/xsX43vv4Qb2eKlD5jaI8h1vXcFX5wh9wwQhftn7HVU?=
 =?iso-8859-1?Q?jpfFNAszKJwMBmtgd1RLuZ51eDcZRqTG2GQmDsjkEhzzer7z8V/haOpyFz?=
 =?iso-8859-1?Q?i93NF7LWLXTvtwc9g4RK83ARr8vsrliED2YrerdJbFpoT/72Az9RMGSWa6?=
 =?iso-8859-1?Q?dVi7nknj1qsHpHTTN/GLMdrzS+493XCE9hbiov43fosIjj2TIBWayT67ny?=
 =?iso-8859-1?Q?3lMvTQicfNbXdD+5nh0MYV357FMQvZslPLHprBjgj31eHLr6Wvftbd9ZLk?=
 =?iso-8859-1?Q?XJ5vMsLU2Qb3LEinqmJCyWUsGt2Vg3Jn5r+hnOjzo7n7eu48PbMo4PGAnM?=
 =?iso-8859-1?Q?RogaQb1OTMrLZKyUTXadSA7fLcrwUd/665AZrlXwWtanqI0VVTO/sYZ08N?=
 =?iso-8859-1?Q?lhCwnXn9o1KjrwEuIpPYMxJdtJG50FLhILseZQfN6gf5DaZg6ycFzJjKhZ?=
 =?iso-8859-1?Q?aFf7GxX4WO0CiQDsBuPnsQKxd4z3SC04OispBbJz4CBfSoTeqpl7UHWP+J?=
 =?iso-8859-1?Q?F4BIJ4wkLEiKjNiuYdEe5JogUQME5m155qzQ0zSvJeQpsSR2XKhfvUu2iO?=
 =?iso-8859-1?Q?5YrlLTMTwlNyShKPEgcXoXCPApYl4zMSJPhh/63ZmbL2HoLKTHGAC8A09h?=
 =?iso-8859-1?Q?yIqLRD7aAaiyiuLoDR+Gl/VKQ7aAcsEUrwT1K/3nHBSU//HNf/8BiZlPlJ?=
 =?iso-8859-1?Q?dl5OfLtItsZIqJeO1W4qoi2091pgvQqbORp+5w1USktZ37ntUHFWs736Jo?=
 =?iso-8859-1?Q?Zg1Ek8cAErh0mylTLctJLptdvs3c59kLqNpnjUYnNtf+fbsAl6dAPOs+GY?=
 =?iso-8859-1?Q?TRiBWfQm5MH27LSNPQSS9OgupmCCu2jiS0lmauOU8C+YHH+Bwt4db+K6WZ?=
 =?iso-8859-1?Q?vGTIARsvOpT6/49Ijzl9K8gbnCTtBStQDyYPVNimvBKc1KGgOMkmjzUQMu?=
 =?iso-8859-1?Q?rvs6QDvC1xwiuWActVAIi4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0Obz1El8+6a5dUh9GTFblx68edeJMEBWynYzUOnIxldG9UYfX8I8oMTCnZ?=
 =?iso-8859-1?Q?RS3659Rewnin9/j3A82iQ5C++T7bEmG/kPGYQ/X50MF4HNFxcyr+WeNGjD?=
 =?iso-8859-1?Q?o+9yjyrTlREgs4YGBmqCyQcMRrDEAiiOLiw+wlGYVtPaSleIS+QpEhZxQ3?=
 =?iso-8859-1?Q?PiHx4t62dUZX6CjPT/Mk8uK/D4jlnzT8p2f3XNsLXuNWkc2Iw/MVLYCKp5?=
 =?iso-8859-1?Q?1bqZCUMehq9SLV/it0UFkhzG82fl3t84dTQOmkGCEga0l2cIc4H8Jv501H?=
 =?iso-8859-1?Q?DDSBeqyq+vzcaokAq5CgJqc+vRRTOb+ltQM5GcNxZOtnvjpGeLJp9Mr6sg?=
 =?iso-8859-1?Q?gsK3/2T8n5LoAfsU+kycQH4nZoZ8T7XeYTa9tzk6QXptaQPj2KknLEy0XF?=
 =?iso-8859-1?Q?JqjNRHAd40myHRwRVcJvRLxHMuhzWFuuusylX7V2gXT4rV4Nhrb5VRBASN?=
 =?iso-8859-1?Q?cjwX1V+lyZyxQA4M7drvm64aylV1VQBoTVuZ3sgT1z14rg9EXfER81zhN9?=
 =?iso-8859-1?Q?oOp9P++NMhn8VYYKEmLWZLfOBMkem9L8JMd34Ty7LCHDf3FE9hepsbVrPq?=
 =?iso-8859-1?Q?hUrx1v9yVBLQ+LYw00v+M0PlCkwMUC4VQIDAM1w2TpUn2n/DqfFUWLG3it?=
 =?iso-8859-1?Q?gavJ8Q5LC8DqTN1j9jaKb0PF88XuBw7U8gw6PTUlguvCXXNCYpVzGoOkdS?=
 =?iso-8859-1?Q?92yfxSmnA9UC9ZdAj4TZnmW+HbGbyCF3TlX2tNXpLirbdanz03R3eQj8tr?=
 =?iso-8859-1?Q?te1qZtUecf5HGI7Zs4YweYng76v464/QsyEGKahehKqt0qO2eCRUY3PVPw?=
 =?iso-8859-1?Q?MaIW0/YWk/u24TZYaC5bZafhsi5V4uBv3M/PuOWSyKpFtjofR9KgtRPgxs?=
 =?iso-8859-1?Q?uuaUikyz0zJS5E9dajsJ3WLYFPR4sWWCZi6P7OT8UZBYbDnXMnI5gWA6TY?=
 =?iso-8859-1?Q?eLUjJRrwkI3Fyf7GcyvDrk7iC80VbxyEYNQPe53+3V9uimFHJGNKj5dJe6?=
 =?iso-8859-1?Q?ap7gvADSd8caBwab4zeUGuWJqVjVj/Abyis5mE3kcjf6vcJgOdZdDiZCmN?=
 =?iso-8859-1?Q?T82Q91kBzogDPA0MjoBolYRbqkjIBB2qXRrKR7xas/ybOZYn+BlWrbdMDl?=
 =?iso-8859-1?Q?QcGIMtCKyiyb4RUQcBsAuc2HKefV/PX4+DXJH5A+jmtkSmHSmBRXpwlaMJ?=
 =?iso-8859-1?Q?hWcGu6vHlFJtzvwxEZWLUg5cszO3osHx0xssFacQeqo9OIA3KxtCR8BuRB?=
 =?iso-8859-1?Q?31fbkGCvWYoCQIg/VGyJl6QlAjaiQ7VeIQEG+2IM9mgwD1wepnvTS8uw1w?=
 =?iso-8859-1?Q?qWzgVdGcV/aK/0+7dwF6bk6STns9TmBHMP6LIyFnNPCtQydIZPwG3eo4F4?=
 =?iso-8859-1?Q?raTPOEL7dGeebIoGNfPbunISofQMNDFqLTbPmwYh5+5XiaGH+OqXVCHZqx?=
 =?iso-8859-1?Q?L9kIdf/hMM5d9Ow6w0gqa/yVgL7hcnOwV5bke8qRHOR2f9iY3XJeDOYwOB?=
 =?iso-8859-1?Q?P9R/lkHnz5moVT3IiN7ecDfvUuEGKP96aKipPlWyw402fGa3JLjzEgK3FE?=
 =?iso-8859-1?Q?q0KS7BQAdYU/kWCaTwO2PziDDxNQWP3O710Lii7H/mytj4N3JRyhywYuaW?=
 =?iso-8859-1?Q?YCySMRHAx8AeGrU452nrlul8l7hIma/v3qmQx2fPMsQdPasw+JgjuFNg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c50c070d-d656-4173-fde4-08de132193db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:20:07.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Buh+Xyqp1jc0ZyJISLfmiveu2TxacQTGefX5/Putr1DPH8WZ6Qn1N04Mj91RLBl3oW4kqRWr1Fr4A668m8ZSprwuCVvWaIC9/DOS1r9V3gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8118
X-OriginatorOrg: intel.com

On Fri, Oct 24, 2025 at 11:25:26AM +0200, Toke Høiland-Jørgensen wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> > which do not have its XDP memory model registered. There is a case when
> > XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
> > releases underlying memory. This happens when it consumes enough amount
> > of bytes and when XDP buffer has fragments. For this action the memory
> > model knowledge passed to XDP program is crucial so that core can call
> > suitable function for freeing/recycling the page.
> >
> > For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
> > of mem model registration. The problem we're fixing here is when kernel
> > copied the skb to new buffer backed by system's page_pool and XDP buffer
> > is built around it. Then when bpf_xdp_adjust_tail() calls
> > __xdp_return(), it acts incorrectly due to mem type not being set to
> > MEM_TYPE_PAGE_POOL and causes a page leak.
> >
> > Pull out the existing code from bpf_prog_run_generic_xdp() that
> > init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
> > embed there rxq's mem_type initialization that is assigned to xdp_buff.
> > Make it agnostic to current skb->data position.
> >
> > This problem was triggered by syzbot as well as AF_XDP test suite which
> > is about to be integrated to BPF CI.
> >
> > Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
> > Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> > Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > Co-developed-by: Octavian Purdila <tavip@google.com>
> > Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, testing, initiating a fix
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit msg and proposed more robust fix
> > ---
> >  include/net/xdp.h | 27 +++++++++++++++++++++++++++
> >  net/core/dev.c    | 25 ++++---------------------
> >  2 files changed, 31 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index aa742f413c35..cec43f56ae9a 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -384,6 +384,33 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
> >  					 struct net_device *dev);
> >  struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
> >  
> > +static inline
> > +void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
> > +			     struct xdp_rxq_info *xdp_rxq)
> > +{
> > +	u32 frame_sz, pkt_len;
> > +
> > +	/* SKB "head" area always have tailroom for skb_shared_info */
> > +	frame_sz = skb_end_pointer(skb) - skb->head;
> > +	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +
> > +	DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
> > +	pkt_len =  skb->tail - skb->mac_header;
> 
> Should probably just use the helpers here:
> 
> pkt_len = skb_tail_pointer(skb) - skb_mac_header(skb);
> 
> that way you don't have to open-code the WARN_ON_ONCE, and you get the
> right behaviour even when NET_SKBUFF_DATA_USES_OFFSET is set

Exactly, I thought I could just strip out skb->head out of calculation,
but apparently not ;)

> 
> -Toke
> 

