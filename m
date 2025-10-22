Return-Path: <bpf+bounces-71703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D4BBFB9E7
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDED1A05B4D
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1632B99C;
	Wed, 22 Oct 2025 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4QmulHk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9369D335BCC;
	Wed, 22 Oct 2025 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132159; cv=fail; b=md3mUox18xik07zRwiNzs40iGG3/0XBurZWXoJsV9XYD35Qg9WyM4I4akFEEZF0t/Vu/YLLeveNiplf2kN4DA7n5mdN75bzr1qEk3ym0S9Bes1SR/y610bjiYCEua6RH6nduePrnhiZX6rqXEXPJUlmNrnF/hwH5MbM6cg9+uNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132159; c=relaxed/simple;
	bh=bloQRyJ9gauiaZqmEizqtbYojESwh1t9nJlzhFKXoqc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PGSM5nF7+cMvDehEHMMvEXdIM1w0Gz8djjHF40dqJnoZa3kvy6RVX9E1E5JggsCDagRC7J1BtjSUcTYj/ATNHGq26iIe/Ih0+AmW7ZM+U4nKk0iH61c2c9GHx1zyNXlLZMXk+qREOWBKsHsutNEByMw8YTWSFyDiTa0uhaTlyPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4QmulHk; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761132158; x=1792668158;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bloQRyJ9gauiaZqmEizqtbYojESwh1t9nJlzhFKXoqc=;
  b=I4QmulHkupz4zGEaTrSSNb2frY9SxH746s9pk7gnuKTABNvGM28QEfPy
   GuZCEK5T0mfQgaDis1S7j9fEieesms361b19gEMFD+mLCTQpcDZmB3EeL
   WpzEZX4s5k7JCvvrf7jX/AOBxFr7ngVUsL115mOYsNQjWWoL/cB7PjYxt
   CrfhDg/IYOu5rlL01aibZlopUYIK3QTZHxmYomOkA8E7RoXSKwwysK5wu
   QrjldeK3ToQ5x8ut+iks/1MejBt7vlruGPiGnBLR9Jt51WFWkvCXxbZnC
   SAeWF2gOnE6eQrn5xexuUpQ765JEDGsinE3CzLE+LCbLhjIyq5N+yZ++P
   g==;
X-CSE-ConnectionGUID: FBkLgPLHT9e9w01amyvfpg==
X-CSE-MsgGUID: VSkClGsOQ6OdzT8Al84BFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73945572"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="73945572"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 04:22:37 -0700
X-CSE-ConnectionGUID: LHXopp2vRRC8EYavUSL4Vw==
X-CSE-MsgGUID: cgDIVnB5QMuWlUF0uS2aNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="188128329"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 04:22:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 04:22:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 04:22:36 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 04:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrH/4e2y9oGnWZujQJH0Ky3fi2zvmCIhzN6HkGcNty1I0wdXMlR9fZlWezoQ9ySa/zoucV3eaSg5SatarXmZ4bfOgGC/6hRnRKXHNnNoDb4TAUnOHgtx+lnKbp64t1jjFsF4hzK622wjMm4LhaTm4r8JpLEaOFJz639vRD7/P5Ma13HlkoIlS2A4Y0EPl3Co/zhA+s114v9jSe/oqxwywBBE4r/d1yuEQHZ0BJcVZsDLPjW/DafsbDCeVg98n9toIGxJCGKq6/LsdMzyCL8xEyGTZVVycKCBimZkIstDIvUrn5yJ9lTNLwUVXt5MCcz6FAI+ofViiLijeDBlBlhFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KwPyBc5JUVtLdEV9wZNS6VuTaIcZm5X5/kMexonRI0=;
 b=ZhMJwEBfyLggOedyvY8BnRHa3kDOPJmuy9a5JA8vm8XdUBGll91299eE7lZTdnwokXxH7XjKlyCtPm6rYuW1xHonv1k8d6dEzxa6oOVNXG0eXxQ7lt4r3QK2cohe37uGLNonH6oT/C33hlSG93Crb42sZMzAXE6BJdsAlXpkL5wdMWMiEOms8Xk8V79cbJGuKjG5ttJg8oApQQzC7Rldj9x8umDtxlwZwhG45D0Bb+rwlhTCAg83NyXJYyLA7wD1ozTtG1zRY+gCxRi5VyehLgheJTwgHFlsMkMrMxPaH8rHnITNEveNFF2O0qplV2rhJGH0bdGlCikdVWsaIWzMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 11:22:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 11:22:34 +0000
Date: Wed, 22 Oct 2025 13:22:25 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <ilias.apalodimas@linaro.org>, <toke@redhat.com>,
	<lorenzo@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<andrii@kernel.org>, <stfomichev@gmail.com>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v2 bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
Message-ID: <aPi+cfwuGq2r+8RZ@boxer>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-2-maciej.fijalkowski@intel.com>
 <50cbda75-9e0c-4d04-8d01-75dc533b8bb9@kernel.org>
 <025d2281-caf0-4f88-8f31-b0bfa5596aec@intel.com>
 <aPZ3FvcIVOPVxQum@boxer>
 <20251021180136.39431ed3@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021180136.39431ed3@kernel.org>
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 186ec49b-1e38-4e40-f46d-08de115d4c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LPuQvBxCIOaB/KnIUIsI+h0QPcxYGgxz0cqVIH3Rp8LAio/1niTMl0zYbq?=
 =?iso-8859-1?Q?WKE4pgiByOKitYhLk7AHstFD7TLtrH+p/VLz3cyrR9m/O6ii8jVIN3wsF9?=
 =?iso-8859-1?Q?NXrw+flYH7gako1jkSCAh6xv+vt+Un+lrXZIVKfANiYhacXTO7aPqcrfFf?=
 =?iso-8859-1?Q?L1cWvjq7xid2q90rUKdaSswYHk8RQdK+7nyC58imm7uwvUHWuzbGk1+QcR?=
 =?iso-8859-1?Q?zEOhXB4WL4HSkiV3XQUOcENeKReE9E3OOwdEq4+ZsG/KV1/hMLVP8zDNYi?=
 =?iso-8859-1?Q?FtnCB8U+AWE03rv1LTDgt8iCRkuj0MJd+oF58rwFJ2sEiADPVxfHX6hkf4?=
 =?iso-8859-1?Q?vt6cy8sKD9IhJi9OXXo0gfkIqiwkC5Ex7NViiNC5lbgPn26+JsYV+vpR2g?=
 =?iso-8859-1?Q?CsAiKIPkHFveMwoHvpo0P5c2lydihee+bnnLn+tHHg3WOqYjlObFR8ZbVn?=
 =?iso-8859-1?Q?bjylBKrc3GV1BlXXK6jZaUF1C2alafPgC/WtHrOv8LWvFBfq6qZ2T7TjZe?=
 =?iso-8859-1?Q?sDEx+k5qIOMD/7d6aG8qj+HYpowKV/VDQGcVifyr3QP4rN6v1vr2nmJ6xW?=
 =?iso-8859-1?Q?XsYv2hAFpqMECxjB39xAbqkkl2jQBY3nXayvLb/E+ItECcijuH2j65p3UK?=
 =?iso-8859-1?Q?dRm+SpJvwrmz1FRWexNph4nV97zyw4LNZGd9rOxuyrrbuZuG9k8i9gN7mg?=
 =?iso-8859-1?Q?klu2UmcYyaml7f516jSDWTtr/ipURtcihYJ8xthoOnpVr54nJg/2q3uRbb?=
 =?iso-8859-1?Q?SURoro7REgYwNi79ZE3py0LH6mJf0Pl4Hnz0TcG2Wr+QROQ5kKajnIHmIq?=
 =?iso-8859-1?Q?skD8dyItLiE1RUPqkBLwtndtQH+zuD1h82HSb82DucCb+RkSziEWlPMF8c?=
 =?iso-8859-1?Q?SSnK8Czg7mGVP49Sgs7xjgydHriDHLfje81zoELDmFPDqu5/6FhThkomU1?=
 =?iso-8859-1?Q?+YPCASEjiFv6M0zmbFdJapEXo9y1FhlDf6aj/b4afo9RhGHi6QgSunpXDS?=
 =?iso-8859-1?Q?dDcby7251+YqON6xcznq0M10oEsIflq71uKR0TT90osQXFEl+UKJMDcwR3?=
 =?iso-8859-1?Q?mtErv1SY1vg57AN5QKuZmB/fqYMB1FRS9X7ZaEw/oWscMcGQJt9v8X/GeX?=
 =?iso-8859-1?Q?E2hfQM9MjTerCo+SUBNWC16J8nwt8i/muG0OxcGscz9YLZS1g6r0zkVkQ8?=
 =?iso-8859-1?Q?uYHz4Xp8Mq5obllhQxNzjivI3D0r+PN483Si5gnPU8FemudXdcQnTDY9pS?=
 =?iso-8859-1?Q?1+2yZym5mvD5R0xbMalwWCova5P4IDFFUl1Qedsge+YRa0ejMjSQpGKIRt?=
 =?iso-8859-1?Q?IWpwQv1L/wWxtuQdLZrdvpESFsOnyDdVR1cnWmWXkAIez1y9ODfglXNaaJ?=
 =?iso-8859-1?Q?b/34PBHSlsSvDaNDMIBWwau83LhtNhmt337Mf5TAZbbtZAAP2ppo0t2um1?=
 =?iso-8859-1?Q?/1eOEfxqf04bk8eJeQV+xCbYVwcj3wlp7c0g4wOpyL+mxVju+xn3YquZAA?=
 =?iso-8859-1?Q?kwz6sRDbeUFHnQJbtxWxpC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CsD6nz8odYSZPRK3u0DHAVWwntQkByRl3smXLLZs2wGbHqwPkDRxZ0H3AT?=
 =?iso-8859-1?Q?7MV7Hn0TQjxhejHnag1QDHMRJwFfLQjvZHvaEdeRoIowvAOuIOg2OO8/TO?=
 =?iso-8859-1?Q?0+rsS7S987spjKQjp9hGdLTJqpDYWxkADWBYsrKmVxUNdFDctx3GmNzALy?=
 =?iso-8859-1?Q?2aPqLtv76YKWhrysU16Gh8UEP2lxzTf6F5F2a49xWznDWW+uEnlgz4UmvH?=
 =?iso-8859-1?Q?FfCmGJpTae57tPcoWVy1f3GIlLQH82+Zlo2iuTAwcfc6XNNyGHWrFZiz1g?=
 =?iso-8859-1?Q?/6Jy+HajBFTLMyaLlVr/SJtHHM4WE6YYI+VdWRBUsOBg3e0nSgmBE1Nhm6?=
 =?iso-8859-1?Q?AL9HN6Zdi2FbIvn/5nlhb8A2raWR6pOexuHkwp1svbyots8MKxYzAhr8zS?=
 =?iso-8859-1?Q?khAZxDJyLILn+Tj9XhbxFRi7PNMBglUjtp6dBRRwPRU6piFfo10Vp6qfM2?=
 =?iso-8859-1?Q?k0oNy/Yya+Zqu6MHfUFuhfTJ4fXHpaMtzSAp4G6hA6909SW0y543dFKsyT?=
 =?iso-8859-1?Q?jHxT4KuDh+R19TiBsiHLLr3CBNofItPJCfdpLg0043mSIr+o9wG096kdgN?=
 =?iso-8859-1?Q?QCCpVAiiPEfkMUYAqagM/ffOxOuXcdEg38FnbiSHMYVDifbhQQTLtpkNMX?=
 =?iso-8859-1?Q?Dao+jzzLmhJDz0oDi76VPoJS78IUaMd/gXJRhbHygvOwMAvX5nN4+vIZQX?=
 =?iso-8859-1?Q?7Tz0yi3geiuWaRb2RyaUwnNJRorwMPC5n/SplPaFVbyyIoM9o9o1fLksco?=
 =?iso-8859-1?Q?CEwp9dhOJAtFzkWlMeFMSnMW8L6RrQe77OC7FtW6xS8216CgfejYb1BAKY?=
 =?iso-8859-1?Q?DQ2e0jBgq8I1Jm5kiKUXpixjAuIVqjHAMy4r7a7AY+vDHO7K8KEfrWpfoH?=
 =?iso-8859-1?Q?EQxpURnCw/k9wbKSa72MGUrFTWiZglJFUnwDBMWXKZpUafaZohQ+cbC6Hc?=
 =?iso-8859-1?Q?PCH5oNf07UX4J29u4IvJqzysDeMg37ZcdTdrYiwPvKIe9MgyUX+lOvWUTo?=
 =?iso-8859-1?Q?noJId5qwVn5jqQMpfuejdMWX+wJ/cyqnrbVR+w/lNzupQWjkmmoz38eQE0?=
 =?iso-8859-1?Q?wK2ECYs7GkOI71m9a927yH1LIlBI/XCwPx+GVl3QPn//8kBcIZDm1jH4N+?=
 =?iso-8859-1?Q?bdo3i8NAdq1E0iKj4PvbukMeVKJB6g4op7EeOTJeNiWMr1IIeUVMuUeqPE?=
 =?iso-8859-1?Q?ms2K3J2pn96k+ukeKtbCXb/oXaajeP/xMnH2OCaVrHADR5fLYiMYjnxxXA?=
 =?iso-8859-1?Q?LqG/ZF4i2QixmyAYDDRaQKgiOyfgPGxHUlcpCyhEjGrX4kJXnWlcZaAbB7?=
 =?iso-8859-1?Q?HdtIWJKjvMnnNRVVgGmniIWRxzoPQeT/JmGn3rhogJxRFk/5GmxKxJYAGU?=
 =?iso-8859-1?Q?1R6A7hAciQSNcnnuWiGAurCqYuH5CUkAXo+6B6o+kH9BqHtS3v4CRK8Kgn?=
 =?iso-8859-1?Q?g8bSN/wlrZKoGOPRHLZQeDEsecXsqXGNScb1tLiSP6AWe4qKxfgquJZza1?=
 =?iso-8859-1?Q?hT/GpCqWZ+y2GQFWmSY5ydlD1y0z2BV8s/2ottY6qbId6suAOBj4ZMAFoD?=
 =?iso-8859-1?Q?sGCcpLijniqmmKDCztVATnGzk7apoOfufAQeCPS5AtcC85CKqcY1G5II4/?=
 =?iso-8859-1?Q?x6tcyF0H3LljgARQlAw0nLKtT95JNDn/WGZu6YOSZf9HT4zn+FBXOOow?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 186ec49b-1e38-4e40-f46d-08de115d4c58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 11:22:34.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49WCeqW4CvrF+bYPip/ODVWIcvYvcuVYJYJYrIlB/MpifrmGGXS/HzV/s/Np7wV5jkBqWS16oOuw+dhwa5tsHgkebb8RlhY3qV08zrhCPGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com

On Tue, Oct 21, 2025 at 06:01:36PM -0700, Jakub Kicinski wrote:
> On Mon, 20 Oct 2025 19:53:26 +0200 Maciej Fijalkowski wrote:
> > > > The SKB should be marked via skb->pp_recycle, but I guess you are trying
> > > > to catch code that doesn't set this correctly?
> > > > (Slightly worried this will "paper-over" some other buggy code?)
> > > >   
> > > >> +    xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?  
> > > 
> > > BTW this may return incorrect results if the page is not order-0.
> > > IIRC system PPs always return order-0 pages, what about veth code etc?  
> > 
> > veth's pp works on order-0 pages well, however I agree it would be better
> > to use virt_to_head_page() here.
> 
> In this case the mem.type update is for consuming frags only, right?
> We can't free the head itself since the skb is attached to it.
> So running the predicates on xdp->data is probably wrong.

See the veth patch where we bump refcount of related pages in order to
keep the data as skb is consumed.

> 
> Is it possible to get to bpf_prog_run_generic_xdp() (with frags)
> and without going thru netif_skb_check_for_xdp() ? If no then
> frags must have come from skb_pp_cow(). 
> And the type is always MEM_TYPE_PAGE_POOL ?

We have a fallback path netif_skb_check_for_xdp() that linearizes skb, in
case COW code failed. But bare in mind that bpf_prog_run_generic_xdp() has
other callsites, besides generic XDP itself (cpumap and devmap). That is
why I wouldn't like to base this helper on assumptions such as frags
presence -> mem_type is pp.

