Return-Path: <bpf+bounces-36896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E41E94F173
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A366F1C21864
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721A183CC9;
	Mon, 12 Aug 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgUUk1fn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44317E8EA;
	Mon, 12 Aug 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475655; cv=fail; b=i7FBTOqzWJu4bOFq9m/IfaxESvybAqUcO+l9CE1H0QdcSJzlTqm0TjvPdoD5dGNa2QF0vQqSlL+42LAovKywFLN9pTb+yGiN2Wr8rV6FbP19E/J1awB46Z3CvIEvZvmqcftEfBW8qzjpPR1AAaOp5rGGbwwVTvaUYx0+/s7TSi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475655; c=relaxed/simple;
	bh=+mQGCV3MLoSaZnFcYkCRJvQ+7/2usTaLZjS/doG6d6w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eH31i0TuLcvlpD1TDpFIlkGLZ7SYPR1pcthJIEgAo2jV0HAUvMLrXSey/fePjGbchAu8blsIOro9RPxgm6wh2oHboMI8jW3EDVsok64OdyqYlp3bT005AUMA+24sWRnA2aCTG+hWHBvlHtz+UU0MD4Y38c/foi502YS0YrNWQIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgUUk1fn; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723475653; x=1755011653;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+mQGCV3MLoSaZnFcYkCRJvQ+7/2usTaLZjS/doG6d6w=;
  b=OgUUk1fnB631SexyOhOJrV0qCrA0YwiGXhn28tASBQtQ48tnrHa3xocs
   mykKtUDp8xZDAlhQ5tYd/7v3KEB0f0AfrcNIMLIkk6jYYvjGZ4WViSePH
   JwHCy71Kozzbwc3omUKyqjXUm3hpiA0UZhPEi3rx0tQJXDdPYSE6J84bf
   W6JycGF+vNPezbhO9UJilGbHDou0bPC+vBXcaqy0f5/wIiLzSJ52CfGnw
   bcCDpcmurzUqGOyD+7I6xwLA+LN6gOKuufgAdZa9OMjQ9FTjaWQ1HPKr6
   ketLlvL2Ag1vh4qZzzIjAyURNGMAwq+xu+SKPjX/ww5BS1DrtWTQXth6V
   A==;
X-CSE-ConnectionGUID: 7C+Vb2eiRW+DrSNS0VCeNA==
X-CSE-MsgGUID: tgeh7UOiR1SP17wJVlo27A==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32996026"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32996026"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:14:11 -0700
X-CSE-ConnectionGUID: X9gAJXVaSw+ILoCtKC5dfw==
X-CSE-MsgGUID: C8gm2j3jTf6hpfBpNoXQtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58175734"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 08:14:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 08:14:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 08:14:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 08:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqJpHhs270VhwtcD0AvC3g7CIcu+oAcIeI326sDRKszSYNByLkHH6ORtUwSg4/B4iPp1XtIA6XebOSQj5EhdLT1Z2fDL5wa4GPexErpw+JGw8Vu6oNgfjEaASDsYcerYGxKjf8x6zWyCTL0vUXNuOKq8enUjyx+Tp8zTPEAPWruL8RFYvKpdZOqpGhplWPU5gOV/tcCFhR2jVH6LHtSjj53B7KOBAGxmOJAupOwXNg3M/gr0UyO5bAQu94obDlT0sGeOe1aqcNsmilOLbrtSClW7WP9Vr3HnGM2dBjBx8oQ9pTLt1EyEcWcsGXoVBJwjO9AeV6pmy0uSY2MLS/NxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98YmvEyTaYPz6Ao/4aH6xHIukel7x+2QhVP6Eu4MMW0=;
 b=JejYIoa1nP+DnP1GnK5xUHjGfFNqE6TFMRbaEHAd3+r5UFDILHz64VMj7FAoxr+SzxP7btbvMeGP/1oms4HzCblgYQW+9gN0dFOEQQ1GxXsNTvLJl7Br9Iy6d21uf6iLw9ZEZ0EH41mYs6kJSdM76bkg8Xi7uiqvorM6N8W6rHRpU00p1E6flLfH1GI89E6uNgBbLG/ICJFz8bMjQjdXcalpswSvFJaE7WXhLnKRKO70A2yLcX0b2Iw9jLUKtw3vg81Oyojk5F4haN6kpAly1fDcv7N6GVrO1LsVlfnTIwfuL/BRR8dEUznhWAEGZp13SdXMKWU+7QTY5PN204oeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Mon, 12 Aug
 2024 15:14:03 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.7828.030; Mon, 12 Aug 2024
 15:14:02 +0000
Date: Mon, 12 Aug 2024 17:13:50 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>
Subject: Re: [PATCH iwl-net v2 3/6] ice: check for XDP rings instead of bpf
 program when unconfiguring
Message-ID: <ZromrjCGGWn5FcbU@lzaremba-mobl.ger.corp.intel.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-4-larysa.zaremba@intel.com>
 <ZroG2LxHn2Rt+Txx@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZroG2LxHn2Rt+Txx@boxer>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 8760c4ef-b808-407a-e1f8-08dcbae16646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7soEtN716r2ofn6vsmzKzP7ESN5SdEcK7wmg2wGYptGZTsrmYGr9dO/UJX4Y?=
 =?us-ascii?Q?/MaRy4xLwqO9304bHNobALDH1b2AN0G0EcuBvisONMaMh1TqKV7Gjn303u/U?=
 =?us-ascii?Q?nJAPYMs5f10jd0dcAK6jWtfIfJNOXZC5Xz+O3g4Gh3GASHLTqovz4qrbZF+K?=
 =?us-ascii?Q?LD0Y8Y8enaba3EcTdcz0lzWDsaKmGH/ODJIMizhAZyEBPCB7ZqkhHRBmCsa0?=
 =?us-ascii?Q?EyVIEn3ljLkxOAVtSgZTHI4yQ04w4/U7VoNBBkBhF4FT5BHyAszy5GppL7Wz?=
 =?us-ascii?Q?tPaCnayaYX5ap6yeTTK3xsCv3rlGSlxzPkrJtWWWa1C4rj36we135ZSc6XFJ?=
 =?us-ascii?Q?9c2NDEklOmJ7I6R8Xz6aSFo0KbspYjy9yo1ETiJGOSXnkb6JadVBd2GY7Odc?=
 =?us-ascii?Q?itYp+DyMHsbayeI62bO5DyKkk6/WwSovSFp10JaL88MYTywi2sYspdvJNpDY?=
 =?us-ascii?Q?UtOfKvBMVtXLFFM7MmYQweHPDoI6ZY54sQ7VGg9ZJFbwsjAjcyhMEdW3Y896?=
 =?us-ascii?Q?zCaSb751wcy7gAehMdhUYBVCKXgTtCjMmT3NpdQiWIbWE3DAAjT3GX8pdQHT?=
 =?us-ascii?Q?Tgp9F9Qh5qfeFMvkS+LRNp2tjb/YhijPlgJFHRxDnqV2XzQONgtVv78HH+4w?=
 =?us-ascii?Q?facLjuQCzC4a3DcuKSfAGnOTMFgT8lEv/D/QQ+wBYtocMK+UVTx7K5MNEPb3?=
 =?us-ascii?Q?tEHaQRT+k6eWZFnRU2WruDjFe3vQhLHg1MpqraObZZUAmpPPNZmxYZXpBss4?=
 =?us-ascii?Q?qbO+g9kGnIcHo0ojk2XSDENoCIqDKHshAy0sN0SvgKAkUjT93xp6VGKLlbjq?=
 =?us-ascii?Q?vfuX1Mqr3d7X4PlLn8ElKsoIRzZGUhP+FLZHVWLif7MVwnT8ZXZjo3I20TuT?=
 =?us-ascii?Q?a1hngdJYTW5RVfOPpB8k522tg3w2UnL8tOTVQNEX6Matp85TTXvU6SUEOHtZ?=
 =?us-ascii?Q?jDNxcY5xO6YL76BB6R8JTpQJgrQa91EY0/AM9XwmxcSlyuyHa021azkGbkhy?=
 =?us-ascii?Q?qYkNRZxFdJREHmlyiqUR3nT/j1bQ36Q62EcMlrnOT2KJMg1VQXwQZQ1jINKF?=
 =?us-ascii?Q?ipcm2c1RDMnulgNN99neBMHCeZc0eMaepWawCaVckAZfC54RY/nsYzA1Utht?=
 =?us-ascii?Q?R/2Vy2n4xnjwplNF99eTZm02hj8JYezX+CoTQIuxMHCsrVEIPdwStuDA2+we?=
 =?us-ascii?Q?s/eCuyARcSl0V2bo2pW4nHHSzYNIdwaoftzFSPzTsvePMH1YnAMQYp7idkRd?=
 =?us-ascii?Q?qWCfg0NC4swqlhYhlACPx6FJAgD9AKnMk/wpgcQHisN5qyTpEUWJdxVnXTYx?=
 =?us-ascii?Q?iTT5ChEYdWq7uZ/fVbr0LIaXda98yoLdzY1Xf6ePtvhNYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMcKd3PoexZ56ZZ6xMPQ2wr7OGGnhLF/FYI0s6bSuwF0kB/wMD00VcuCU4cV?=
 =?us-ascii?Q?/0b94PEgNgBDLDykZTTaN8rQVutCiRzLFG07Avo4pypQKrm49SZ/ZYKX+Faa?=
 =?us-ascii?Q?w8lXhIj+Z3ydym/5kwKSdVw6JZJyWnSeq74vWmHxwIyf94h32Vi1aFUSqw+x?=
 =?us-ascii?Q?SvccllbsG5SFwmS8mNfeOGoJYxPGdu5DxifkOFRt8XwoF1uXDO4yq3aozobe?=
 =?us-ascii?Q?eReZY/wO3cjWNBYuztAfMDuf7vVUSJEtbf5RZGwbmqhClY1/iQ/dpaLWzuCa?=
 =?us-ascii?Q?Z3wzD6tRGt/NJSEiJ2+A2+vQbMumAL4KNM3ZJZK3UHoFuEc6E3a14MHyLDCm?=
 =?us-ascii?Q?FMC+sl0uU6lEgNp0/g+cp4dA6z7fsC94RFeoxHLPRRIMKFMIlZBPJ/BHWP9B?=
 =?us-ascii?Q?a5klQjkbO4Taimf8GLl4Dg4jKqHYSrTj6qwUxN/bWcqkqRGw1Hww+3kAWVF/?=
 =?us-ascii?Q?WXvJnyU615nrA1g9MmpTQ9qI5DbAwE/zJqnhnSdzaXT0gjOvhAmtzxYTF9Vo?=
 =?us-ascii?Q?5gFjzYvUMPz9FBVyGO1/JsugxwbuqM3v8zDBCpBHT14RQ0FRJIUG0EJTVVL9?=
 =?us-ascii?Q?9ZdWQJfG0cZHDQUymHNLOSNdnadcK9waUSuJs1XU0Rh/n5fOYI0wdIHi0KeX?=
 =?us-ascii?Q?0UpBuI1J3xi9YDTGT/UdxMqqqurV0F2eHwRazZq8Wzal7yLAkNGDTlBqwbth?=
 =?us-ascii?Q?j/KKsJZLHy2ccxKAG7Qd+wKIM/M7oGERVPxEwSJIUUZEy5U73yLarcL1jTsO?=
 =?us-ascii?Q?WzJV6NE5kowRZlTc0w2NrCuLOZ9Bb7H2xfqzJlV1zQJacxJLchm5sc5TadxH?=
 =?us-ascii?Q?aKWe3SHN77EIPZsymwkqjKvEAB13F4aEH4ewfVsZGktm7OkIzZA0vb6xlRIh?=
 =?us-ascii?Q?IW6Au5pt/CvVBPsWbbu73vXGRodPkirMv4qJx3YPToBQMUOAQWa1ZsGLgK4H?=
 =?us-ascii?Q?2FRsnznng7vqXIfyVscrYkXM75OauYTuLiFaMqUpLPxnv3SriQ8AwFa91Awp?=
 =?us-ascii?Q?J46eWB0kZkssLtN9uBGrR3FXDSxWRCrb3sxlFLtTW91ylv89OANp0AuFmSCf?=
 =?us-ascii?Q?ECdQf9SOwcTlLPbHQQbhBWXhqaOujBSKclBYrzz91CSZ8MEKUqsbEZi0z1Kg?=
 =?us-ascii?Q?FQueNTHImuFucfC0xCcV1EuCawrKsCbr0Ge07BUD9Rcjivw7droYttr1o1hw?=
 =?us-ascii?Q?REMdJqgZfx67UF1xQdr17qTIN01fDW8IbCw3BA1IqzO6ScU3IuzFS4a6ynEe?=
 =?us-ascii?Q?aYfEwsA5KiK3AyUZ977RAQ+R8JhbvxqCZkg9JcLioKDeyzBWPxOFeNVesgQT?=
 =?us-ascii?Q?eY59RvjNfRWPNog2IGj4UoTHfJfeREVwP7FE9WVswvzi9/pdQxse5cb4IABm?=
 =?us-ascii?Q?387n+Hgv0mkyXiBGsXlSAZdSoJ1H3V8ImcGR8wLugKCktvgrB+i6hRFh/qI0?=
 =?us-ascii?Q?f4Gbps3nBmdJd1n9pacLsf3nTb34hHk0n4uB2EZ4X0Q9ZHSoqy37sDHv+gww?=
 =?us-ascii?Q?0YMo2QH3GLW04NfCJo4CJ/nKrqBzBs62tBx6vMU/RszlEBdnjJe85EcZpuMC?=
 =?us-ascii?Q?7/sg66rsv9MSma2n9ko5zdlTNd6fdF/bnr6cZfri?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8760c4ef-b808-407a-e1f8-08dcbae16646
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 15:14:02.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjljEr7F6pHEZz9z7Yhl2IlxUc1Nwff5OTIdeuj+wou021xaO0cWVHbntBqSxT7ycY9nI1zONId+XIXktg3xeNYtsGF6QJWFn3WVl9/wDpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
X-OriginatorOrg: intel.com

On Mon, Aug 12, 2024 at 02:58:00PM +0200, Maciej Fijalkowski wrote:
> On Wed, Jul 24, 2024 at 06:48:34PM +0200, Larysa Zaremba wrote:
> > If VSI rebuild is pending, .ndo_bpf() can attach/detach the XDP program on
> > VSI without applying new ring configuration. When unconfiguring the VSI, we
> > can encounter the state in which there is an XDP program but no XDP rings
> > to destroy or there will be XDP rings that need to be destroyed, but no XDP
> > program to indicate their presence.
> > 
> > When unconfiguring, rely on the presence of XDP rings rather then XDP
> > program, as they better represent the current state that has to be
> > destroyed.
> > 
> 
> No Fixes: tag?
>

This is basically a fixup for a previous patch. The need to replace program 
check with a ring check emerges from the existence of an in-between state that 
my synchronization introduces. So it does not fix anything from a referencable 
patch. I have separated this because it was seriously getting in the way when 
trying to read the synchronization logic.

> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++--
> >  drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
> >  drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 +++---
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> [...]
> 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 2c1a843ba200..5dd50a2866cc 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -39,7 +39,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
> >  	       sizeof(vsi_stat->rx_ring_stats[q_idx]->rx_stats));
> >  	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
> >  	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
> > -	if (ice_is_xdp_ena_vsi(vsi))
> > +	if (vsi->xdp_rings)
> >  		memset(&vsi->xdp_rings[q_idx]->ring_stats->stats, 0,
> >  		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
> >  }
> > @@ -52,7 +52,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
> >  static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
> >  {
> >  	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
> > -	if (ice_is_xdp_ena_vsi(vsi)) {
> > +	if (vsi->xdp_rings) {
> >  		synchronize_rcu();
> >  		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
> >  	}
> > @@ -189,7 +189,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
> >  	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
> >  	if (err)
> >  		return err;
> > -	if (ice_is_xdp_ena_vsi(vsi)) {
> > +	if (vsi->xdp_rings) {
> 
> From XSK POV these checks are false positive and I will be sending a patch
> that gets rid of it (I had this on my tree when working on timeout issues
> but I pulled this out as it was not a -net candidate IMHO).
> 
> Just a heads up, this can go as-is currently.
>

Ok, thanks.

> >  		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
> >  
> >  		memset(&txq_meta, 0, sizeof(txq_meta));
> > -- 
> > 2.43.0
> > 

