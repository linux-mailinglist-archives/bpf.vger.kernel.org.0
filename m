Return-Path: <bpf+bounces-68632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1474AB7DC92
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A151B24B33
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 06:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524829BDAA;
	Wed, 17 Sep 2025 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEBA99pL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A52620E4;
	Wed, 17 Sep 2025 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091070; cv=fail; b=kuXsaX1i6/d9zTa8mWtcjreQZgc6Y+wj5d/ndA+UF23ZDj82QTJYv3ZuZd5FwS23Cc070z9mojDBm1urU434ttIWzRxYGPdG0h2BWdbvmYA+N4Bs5TdXHZcRWEAAE5mpH4hGTNsv/rMFCt+jX+KYDOBlYBkWvLA7bDzf0kCQvUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091070; c=relaxed/simple;
	bh=AjDfeSPUbZp8U4S3+kop0vANALQiM7dpltuFU9s0YsE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YSds9qgN+qMMoL/E+CLTT3YtCL/5i9tZXNxwBIU0UfNFiS2p/9i2HZ9q/Jm1z6Gc4SDER5Ov6D1MzuCqiAfHCWPqdCzzU4+zk7SsTO8xSqNcLwotTL4cWchKiVEn5LEvcU0jas9vT7DkWB/BFvUyWq1y9QwQgTgsz/tg53r3ksI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEBA99pL; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758091067; x=1789627067;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=AjDfeSPUbZp8U4S3+kop0vANALQiM7dpltuFU9s0YsE=;
  b=iEBA99pLcNNHwSpVKV9g3tfkN59pG6BvQW8iFSV48+hT06AmrCatFnTV
   IjmGymlnGiPUCfRgvjdg6IgsVeIlOefT8Fr1KLzvndvgtBctACJjBR2Uk
   YndzJcY3hrVjQHAoOVbKZp5ARSrveOQJj2Mw9KVFFkgbqf+bidN5GPsfF
   o7O8EhXAbfimG6cYhLdx/yAiZATPYh7AwlGVBxAMIFIA3Dz5udISkJa+M
   3ihMojE9sVdWuJkIhv4oDgt+v6dwB9LtiEKQ7wIQ9fT4E7fqjUSiakokX
   qTeN5OBoIjJXnEOvx0BcVPQ8+eKXTtl2cJB/zb9d4n145PkPdkXhPZkP8
   Q==;
X-CSE-ConnectionGUID: R9TtAOP3RnuQMV9qABmYvw==
X-CSE-MsgGUID: tm9x2G2kQbet9iBXijLMqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64022185"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="64022185"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 23:37:46 -0700
X-CSE-ConnectionGUID: nIw7iYpcSu+UDlY5zFSZ9g==
X-CSE-MsgGUID: k3ttnpl9RXOEvHA1sX0KOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="180425273"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 23:37:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 23:37:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 23:37:40 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 23:37:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBgaT528uaEBaiUv3HvbE9LvFoRlXEy1HpIky9KbkKRAEIM4UpPSG3vSHrjsmx9yuT3h5QqnnibQe8nPVX9Xgw8JjiJEHaC2iExx0n3IwmVAHNce9f770ShbSJ/YccVXneZP/QXUu1Sfsu9eOoVYxq+VdWrXbcNF07CsMrmfFCIxP84r7/2n7dl2fYH/Di87oYoV79MKQpSofPkP0Aiz+a9XGqiCOuCLQG8z6ys2kd1MTtoJWj9iCndm1VMZF5uZO9H1eXU2EG2NRHMMRa5MCyGCD6BQWXs7DTngWYwcDcWoWYvysalzSAY75Pr/cYKEJQl2ADTsTytkhIKFTEGHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlmw1D1ZtXV1gUQPCi9gRLPzV1zh4VV+pQmp8/Q82Pw=;
 b=roLFVkue1JelIqB26JchT4UrGQONLFHMwhGoBDyUZWDwKS8CemF3NWrpIAOdJhHocGEHV9/wsUGz43c6BEP8X4gdhGn9Xhp753tc3nHbtbnqKukewb6F12dW50yAICLeCgq2Xcyl9igyzXXALnGeJDzZ0/Sth3vfQcVA5dY6Err79lcduNq4PURZQUlHG6F+ThO2CAqBZ3syeouuBFnwCMHRVD1xQfHbAoXuIMzWpfpY79twYykHzR4eqNnD36OUaYsz/L6yqK0JgPVJEQ+q25+qT8DlWyNw2cayc2RSZfk3/sgndhoJq09+RjMcU3VLEkriAYqKu2J0eqX7SosE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 06:37:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 06:37:31 +0000
Date: Wed, 17 Sep 2025 14:37:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Shakeel Butt
	<shakeel.butt@linux.dev>, <netdev@vger.kernel.org>, <ltp@lists.linux.it>,
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
	<martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Neal Cardwell
	<ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, Mina Almasry
	<almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <bpf@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in
 inet_csk_accept().
Message-ID: <202509171359.658ddb38-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250910192057.1045711-2-kuniyu@google.com>
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 424e7be8-cb85-4e57-ad33-08ddf5b4ad59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+5/uropSYobwU/5P40ubOplkBoXkxye9OxjJ+YlWLdhfZZ83UCVzN9/pr5Ua?=
 =?us-ascii?Q?qIKGUfg16v6WrQhro+lZqPSo2k416QJrD6QdsbL0ojg7Q5qzMfGVMXZXxP0Y?=
 =?us-ascii?Q?DWOuivQh5TeaXBumIo0RIdg7LhEuiyTAdUm9nWb0zQY92k96VeQMrCS6JiFD?=
 =?us-ascii?Q?QakBEj/Io8VH9Tb6pQGwBBPIMcsrRJsTwJnC5/wSWBso2I9e09ELFJnIvVqS?=
 =?us-ascii?Q?zV/5aRhPToR1mLctshRHSQA7B//0caAur8IszaRzj2JhKmf9+nngVGmuzFmR?=
 =?us-ascii?Q?5yoFg8ZXaYSQ0K+AYeMSNhcD0L60ywZxlxSNIvjuGgJziQYvkuNcNTkZCTmT?=
 =?us-ascii?Q?RHcKoQ24ov3TztjHgUt3OYAjKY6+09yB0aoNw/PE9jx0I8AKpX56o9iSmHQj?=
 =?us-ascii?Q?5KJki/4Ukg338lh2AQCMVD5L/DBNqgwW2/zlowCmYbFZ2Furby5rA75hYfrB?=
 =?us-ascii?Q?xn0uIDqYS3MbjL7Rl09ny1fSOr0GPmrR02njIlp8Wv/rCSDZUX02eQwXK2B2?=
 =?us-ascii?Q?kENgBwMVGIjkb6zsDU4SZ449E1HjVyyNPt/pFiRffDxV8CsADH0EXCwtcAJ0?=
 =?us-ascii?Q?Gm0No/d9KFL3ZFpETHsN9TkSXvlb6YGFUTWrXKeMEKlisCYLhyZOlBxSB24J?=
 =?us-ascii?Q?uC+jBBJ6NX3pvPiDCbiTn8liP3p+mvvV6anTGyOAHbdXRkpV5lqJTqrRl3/l?=
 =?us-ascii?Q?mR1ZZSI4hQy2WYGJuDw3c4NKNuavlR88YblxmL6hlROt1631HgM5paebNUSh?=
 =?us-ascii?Q?Sx0YmHro6/ZHLFQJuHhCWIs9nmsj7MshQaUpJx8Ynbfg6Wgjn74FpAb0V/Ik?=
 =?us-ascii?Q?uso2arMp7cIWX0feufESSSmxf97yVXRDFqU7ZnypO0Yur3RbhaDmEsEZgoM6?=
 =?us-ascii?Q?e20dZUUMnk0RwZfzsK2Vc+qdJb5C42kPwfAisxbqriOWxUb88cZbBRiHYN59?=
 =?us-ascii?Q?D/4jmVW4BEBKb9IqEc1kX9b4G8IY1xbGbc5t7Qa64NDKwi9IiC2Yhoy/YXgh?=
 =?us-ascii?Q?Uu/ADCODmWjOcVo5PlNrMZix6cbsUEuJT7xwHgDDZQCkjF+bNQ0olTkMxEAo?=
 =?us-ascii?Q?bCSImyJfQhOx/5QDEF6MWqUHaYdMargVJIGvFiLGL5Uy2g1hvmLYmtlLxSaK?=
 =?us-ascii?Q?bo1xN8ZYi+T8zEFDIsYpJZbjlGtahamde7Qqz9JuvZSKG8sedNH7g/mLSvcm?=
 =?us-ascii?Q?YzC3sYxKRiEKmTnQrFbMQaaE6/rjZ8qMf7ctRQZ/2quKk/cqq2BYd6iKOoyL?=
 =?us-ascii?Q?qkgB2UCLZ1g+TyjUBSn/g4VHwwErOGPLpZDuS8R23Q96HYvRoiKW0zjzs148?=
 =?us-ascii?Q?G0A5gRd0MrUvLbOtvrg1ucp4D8Bs+l7sBTlj9bKRPQSST2xvgK5wSEMtjDiR?=
 =?us-ascii?Q?bBQrcmbjSm/N5ejylFT/rpNr9WM7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D85HVYVOoye2DtRF/V/bTu6aYGN4GvcC/bWIGIidP8o/eGKb6DaAKDjVgrfl?=
 =?us-ascii?Q?kK8JozcpB61PIko2gsg9/Yawpavd4E6i0frUELU35zb/5wwmyiFNTy2ka7Bq?=
 =?us-ascii?Q?TZzl03lpX3gb/EUK4g7jLG66rQijye/V/BgMbL7rCbcQ9fjk/8gfMDELULTk?=
 =?us-ascii?Q?nWQkR64VbzvBglZgNxb2dnoa9ipvs34fMV5x2YCqla2eOjaKIOW/Qf6I4Hsb?=
 =?us-ascii?Q?lULRIfFPSkhSSznZA51FLSuLVAqsuDcVJVL+DU7DIItS7BmfTgJwDB2wuUdf?=
 =?us-ascii?Q?eJ4lxjS4qhvdqI91P2LcneOpL3YRhhsZnp9kt7AWELc+ZOEM6w4s1/Dmm6M8?=
 =?us-ascii?Q?lEIVZVKwFJ3cg0ZNXU8OUli0UEsMHQHmPADwC7pcbtHiJEiSehUzLWkaYhjM?=
 =?us-ascii?Q?A4/1+LOHYCrk0oeqAoXcyrPIuWzUyvgRf51Mo8sWT8t1aPZtKvtLUTEZfaQw?=
 =?us-ascii?Q?jPXS6uVub7CG9WN2XRFTeumKnkF85s3meUKIUSao5GKR3osWC65fMKDM8vjf?=
 =?us-ascii?Q?QU9PPCTgPwW88vQ1rzEJtkoHGpd7vD9fryeL6hElx8CQMLRaxobmH4qfHJLv?=
 =?us-ascii?Q?64FjMuNjzzE06i90JQ9SyAAy0bM64rGxv9pusGl68J/R/Izg9BRhakvrtTkh?=
 =?us-ascii?Q?4rnLLFuemN4yg7HMItB1lTnqHWj2Yvo+eihMc09hmLwYvEJUm9iM203+fX5O?=
 =?us-ascii?Q?/HpGd5V0Xa+/yaAlNkoBMI5cU/nzPk4j4EHXQBxLNWpJmL7V4JhqNqnOCSue?=
 =?us-ascii?Q?VbOApptYgFVVDWpClYQHsoswBUTjecNeSA5YT9fz8YyXIAGI/cUdLEYD8LVA?=
 =?us-ascii?Q?n4RQdms8uA8zF4sJ+WKHHQ6Cn93bcnGqX6Q9zA0ps8qP/9ajeSASAtnDHIC+?=
 =?us-ascii?Q?prbn/hTK7QM8lQfKMn85NXaQMoXRMmPSGq0LAnXlyedWYXb+UHYvz5tYbj7Z?=
 =?us-ascii?Q?GCof9NZVVbR7s4OJjFULBziqM0QeXnQ/IjUSVPoIaqHrizbD3dCcyMtBaCxZ?=
 =?us-ascii?Q?9cbIuRsRheeNhyK73P8a354+uPOs5EXCIlgRh2zTK73CWQTPJPiD5FQwb0ut?=
 =?us-ascii?Q?SmSjzddxPWWs3i71gUaNpIq99u+sHDOPcg8df32Ee6tnGmv6kG4FBgRY3mSa?=
 =?us-ascii?Q?igDFk3jDKsR56QFa9q23CYfhabEms0ycThAFvykHkuDTZm0vdl4KmaKBIRyK?=
 =?us-ascii?Q?1NWsRStR4SsqNDA5HJtEOnckx9I/6lrzHxuRnZLXsV8nXwOIXVg2i9JtL4KA?=
 =?us-ascii?Q?Cn8JVgaglqwLVFpw95YZDhiksLh8SjJaeiJz2ObfUUDQyCuTjFq7FiuCK+w9?=
 =?us-ascii?Q?pVrsaRKUNR5L1wWe7kjp9HpbKlm+I2w0LYnKKoFRL7ke7WtphD3t8/dNcS1F?=
 =?us-ascii?Q?XZpidIf6waFtNkQcpFCz7xrjJsEcnOItPj7YD4pOC1PROtiDt05cDjdUN+A3?=
 =?us-ascii?Q?byIvR069TcsCaDP92kMzydoQ+qWV667HFIqbVCF2sR+KEZ2W2yTHAX+yrivb?=
 =?us-ascii?Q?6cSSiKCIo+EaQwzRlZG/yCxiRawD8718IZaf6YXnUco1xgvdt6mUVxHL5LJb?=
 =?us-ascii?Q?4NWbrvuOLXA4l4baZV7TgCxLTw21hAR/W0IXaQLYNayI5B6U+OB0WxaWTKVP?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 424e7be8-cb85-4e57-ad33-08ddf5b4ad59
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 06:37:31.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1g1qUaYjKr03FU6pPZTDLMM4DJ60HXwg/WTF8fRXREdpuhvGnA/7qeIRr/o1n8yVq3b8q3PH7UtnJb4s67iIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7773
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in__inet_accept" on:

commit: d465aa09942825d93a377c3715c464e8f6827f13 ("[PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().")
url: https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Save-lock_sock-for-memcg-in-inet_csk_accept/20250911-032312
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git net
patch link: https://lore.kernel.org/all/20250910192057.1045711-2-kuniyu@google.com/
patch subject: [PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().

in testcase: ltp
version: ltp-x86_64-c6660a3e0-1_20250913
with following parameters:

	test: net.features



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509171359.658ddb38-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250917/202509171359.658ddb38-lkp@intel.com


we saw a lot of "BUG:KASAN:slab-out-of-bounds_in__inet_accept" issue in dmesg
uploaded to above link, below is just one example:


[  468.984291][T30180] ==================================================================
[  468.992753][T30180] BUG: KASAN: slab-out-of-bounds in __inet_accept+0x5c6/0x640
[  469.000550][T30180] Read of size 1 at addr ffff88810df4ea20 by task netstress/30180
[  469.008720][T30180] 
[  469.011389][T30180] CPU: 0 UID: 0 PID: 30180 Comm: netstress Not tainted 6.17.0-rc2-00437-gd465aa099428 #1 PREEMPT(voluntary) 
[  469.011393][T30180] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
[  469.011395][T30180] Call Trace:
[  469.011396][T30180]  <TASK>
[  469.011398][T30180]  dump_stack_lvl+0x47/0x70
[  469.011403][T30180]  print_address_description+0x88/0x320
[  469.011408][T30180]  ? __inet_accept+0x5c6/0x640
[  469.011410][T30180]  print_report+0x106/0x1f4
[  469.011413][T30180]  ? __inet_accept+0x5c6/0x640
[  469.011415][T30180]  ? __inet_accept+0x5c6/0x640
[  469.011417][T30180]  kasan_report+0xb5/0xf0
[  469.011421][T30180]  ? __inet_accept+0x5c6/0x640
[  469.011424][T30180]  __inet_accept+0x5c6/0x640
[  468.992753][T30180] BUG: KASAN: slab-out-of-bounds in __inet_accept+0x5c6/0x640
[  469.011427][T30180]  inet_accept+0xe2/0x170
[  469.000550][T30180] Read of size 1 at addr ffff88810df4ea20 by task netstress/30180
[  469.011430][T30180]  do_accept+0x2e5/0x480
[  469.008720][T30180] 
[  469.011434][T30180]  ? folio_xchg_last_cpupid+0xc5/0x130
[  469.011389][T30180] CPU: 0 UID: 0 PID: 30180 Comm: netstress Not tainted 6.17.0-rc2-00437-gd465aa099428 #1 PREEMPT(voluntary) 
[  469.011393][T30180] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
[  469.011437][T30180]  ? __pfx_do_accept+0x10/0x10
[  469.011395][T30180] Call Trace:
[  469.011441][T30180]  ? _raw_spin_lock+0x80/0xe0
[  469.011396][T30180]  <TASK>
[  469.011444][T30180]  ? __pfx__raw_spin_lock+0x10/0x10
[  469.011398][T30180]  dump_stack_lvl+0x47/0x70
[  469.011447][T30180]  ? alloc_fd+0x266/0x410
[  469.011403][T30180]  print_address_description+0x88/0x320
[  469.011451][T30180]  __sys_accept4+0xc4/0x150
[  469.011454][T30180]  ? __pfx___sys_accept4+0x10/0x10
[  469.011458][T30180]  __x64_sys_accept+0x70/0xb0
[  469.011461][T30180]  do_syscall_64+0x7b/0x2c0
[  469.011466][T30180]  ? __pfx___handle_mm_fault+0x10/0x10
[  469.011468][T30180]  ? __pfx_css_rstat_updated+0x10/0x10
[  469.011471][T30180]  ? count_memcg_events+0x253/0x3f0
[  469.011475][T30180]  ? handle_mm_fault+0x382/0x6c0
[  469.011478][T30180]  ? do_user_addr_fault+0x820/0xd60
[  469.011482][T30180]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  469.011485][T30180] RIP: 0033:0x7f9c169c4687
[  469.011488][T30180] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  469.011490][T30180] RSP: 002b:00007ffff0036ac0 EFLAGS: 00000202 ORIG_RAX: 000000000000002b
[  469.011494][T30180] RAX: ffffffffffffffda RBX: 00007f9c16932740 RCX: 00007f9c169c4687
[  469.011496][T30180] RDX: 00007ffff0036b14 RSI: 00007ffff0036b20 RDI: 0000000000000006
[  469.011498][T30180] RBP: 0000562f1b4e85a0 R08: 0000000000000000 R09: 0000000000000000
[  469.011500][T30180] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffff0036b18
[  469.011501][T30180] R13: 00007ffff0036b20 R14: 00007ffff0036b14 R15: 0000562f1b4d3e5f
[  469.011504][T30180]  </TASK>
[  469.011505][T30180] 
[  469.257645][T30180] The buggy address belongs to the object at ffff88810df4e800
[  469.257645][T30180]  which belongs to the cache SCTPv6 of size 1536
[  469.271959][T30180] The buggy address is located 544 bytes inside of
[  469.271959][T30180]  allocated 1536-byte region [ffff88810df4e800, ffff88810df4ee00)
[  469.286795][T30180] 
[  469.289353][T30180] The buggy address belongs to the physical page:
[  469.296000][T30180] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10df48
[  469.305055][T30180] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  469.313790][T30180] memcg:ffff888223ff8201
[  469.318241][T30180] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[  469.326258][T30180] page_type: f5(slab)
[  469.011408][T30180]  ? __inet_accept+0x5c6/0x640
[  469.330466][T30180] raw: 0017ffffc0000040 ffff888101e08640 dead000000000122 0000000000000000
[  469.011410][T30180]  print_report+0x106/0x1f4
[  469.339270][T30180] raw: 0000000000000000 0000000080130013 00000000f5000000 ffff888223ff8201
[  469.011413][T30180]  ? __inet_accept+0x5c6/0x640
[  469.348078][T30180] head: 0017ffffc0000040 ffff888101e08640 dead000000000122 0000000000000000
[  469.011415][T30180]  ? __inet_accept+0x5c6/0x640
[  469.356993][T30180] head: 0000000000000000 0000000080130013 00000000f5000000 ffff888223ff8201
[  469.011417][T30180]  kasan_report+0xb5/0xf0
[  469.365914][T30180] head: 0017ffffc0000003 ffffea000437d201 00000000ffffffff 00000000ffffffff
[  469.011421][T30180]  ? __inet_accept+0x5c6/0x640
[  469.374851][T30180] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[  469.011424][T30180]  __inet_accept+0x5c6/0x640
[  469.383788][T30180] page dumped because: kasan: bad access detected
[  469.011427][T30180]  inet_accept+0xe2/0x170
[  469.390449][T30180] 
[  469.011430][T30180]  do_accept+0x2e5/0x480
[  469.011434][T30180]  ? folio_xchg_last_cpupid+0xc5/0x130
[  469.393031][T30180] Memory state around the buggy address:
[  469.011437][T30180]  ? __pfx_do_accept+0x10/0x10
[  469.398939][T30180]  ffff88810df4e900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  469.011441][T30180]  ? _raw_spin_lock+0x80/0xe0
[  469.407261][T30180]  ffff88810df4e980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  469.011444][T30180]  ? __pfx__raw_spin_lock+0x10/0x10
[  469.415589][T30180] >ffff88810df4ea00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  469.011447][T30180]  ? alloc_fd+0x266/0x410
[  469.423933][T30180]                                ^
[  469.011451][T30180]  __sys_accept4+0xc4/0x150
[  469.429308][T30180]  ffff88810df4ea80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  469.011454][T30180]  ? __pfx___sys_accept4+0x10/0x10
[  469.437670][T30180]  ffff88810df4eb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  469.011458][T30180]  __x64_sys_accept+0x70/0xb0
[  469.446024][T30180] ==================================================================
[  469.011461][T30180]  do_syscall_64+0x7b/0x2c0
[  469.454415][T30180] Disabling lock debugging due to kernel taint
[  469.011466][T30180]  ? __pfx___handle_mm_fault+0x10/0x10

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


