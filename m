Return-Path: <bpf+bounces-42636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC85A9A6B36
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DC71F222B8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309071F8914;
	Mon, 21 Oct 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OM8H2V0c"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7417881E;
	Mon, 21 Oct 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519081; cv=fail; b=BDX06nEOAGK7YXGT5elpFV/CJZW74OY9VwYDpcT7URVWZj13pCLTySHV2GPqlWSeYYhiSyMpc6wUuOB4z8WSnqIzRrsFI2rW0STOKcAEPxStBDGdj+pnLcFMDLNhRXVf4HmLoQiPyO4QsOmZO8oDGy5cvCRsN1tccXiTFay0pLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519081; c=relaxed/simple;
	bh=OLiug2Ua1OfqUxKhH+uh0YEpCqa6Hy8kyQJOKsYvbZA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jLbUs75uqT1wDccsXaRAYwwTeBnVKIaSdVRxIdq7jJDpQvZpq2KPz0rViw6Sej2mTm/1K0DJ68oFyHtvB0miZqEAm7+dpKnkkQUnbQUcAzwZheGsia/l+3KlwGA1hcL7gg9V17JgnFhveTStDmL0KkXfj4ZrVmxJe7/tZrqIR7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OM8H2V0c; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729519080; x=1761055080;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OLiug2Ua1OfqUxKhH+uh0YEpCqa6Hy8kyQJOKsYvbZA=;
  b=OM8H2V0cGBJeRkE1d96XY6mkm7EE/njCbw5wEBo4JJnG5lTzkZ4fnGNx
   i1NvoVh8x+VB6vjZXY0yGc6drZDvutL26DFa7YpyRcsKPXI5/lHEpAJH6
   TTHcR9hXtNsaFdybdx2xX+/XpUZOfxt34bGAFeDkOnHNXnQjnUZHnoYY4
   WzRXYDPdu9GYR/qomCM0d2jI43vIM5j+GvJqbGUBn5RkPegJabYCUyW90
   RuzX36ccD9OmrAByczUfTQ2cg3EB5y/WdwGEIDmVwKXlaI4Nw7GEhFHFC
   h91BIqZ9qQKT4pLhWUSiM+EHRXZa3lqpmDgeYqfXAuazJ12o1B8AD+CvO
   w==;
X-CSE-ConnectionGUID: aKh1yQ4IScSJm7qhE8gO2Q==
X-CSE-MsgGUID: UJQ9XmXRTPKx3viojJr9PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29213229"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29213229"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:57:59 -0700
X-CSE-ConnectionGUID: 7J/+eJrrQBizZMSI8ttLKg==
X-CSE-MsgGUID: ekW6z3MBTGmxsAYWd1hQog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79535222"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 06:57:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 06:57:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 06:57:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 06:57:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTDbBTYsXRXVo3pJB/eex0aM4heTwaGtt1pwxNPZO24BaaFvTmAdlNplwQe8kfCT0R31fu2HqEgd36F+LCabWKBDVohvHCp5xgBDaIBzODXE/bySw353aKPZj6wgSD9TRYaWaF+xx9NvxSxEuqSU0P/F7aDo9JOOZZJImU27XxoWI1Zs92ScFPXudVRChSN/lXRE1B4b8/MCQeF0MywpxguN+8o/3rZPaYqF6e4BcP4Wn2A8OXEpM5F8jD40MgzPwtuYv7qv2qn88FMhrVdYMO40gCko+rR0v9/IYBVu45e6kg82v3s159aDKB5FNagjoQhFQ32BlEGZQukAA5nGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67RARe3vv1n65dfEU+kPJr3tPY6d1pwGmjG3a6l/YCg=;
 b=fXHd53EEIb+W055f8G/iVM5vlbKyeFYF28YEFFClTsuhPJi4AN8e77hYSSfObepzIlG0yARqfgsnnMPk6kTZWOX6Ha8dYvYp4Q10nb+PAeLlJxXyENsFztecgKpG+GgzHe/aLfdbCfe4PJLO+6QMXE/mgbafWXGroW9yj+b2U+ctJimIiaxQm7Nma1gYRhEP90/82EKkfsPNItANfviEse/3K7g3VFbbM70WHxY0rhBn15fxZ2y1vNAx+idI5hhCIKdOYFanoNx15MLrkgyr+NlpHYOJ1uFrbJpI7K6qEsPjuNJRp78ZsrGUeRpOXX5InqTkr90dGu2dWfV1NWz8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 21 Oct
 2024 13:57:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 13:57:55 +0000
Message-ID: <674d6cae-b995-4020-9166-bb9309267448@intel.com>
Date: Mon, 21 Oct 2024 15:57:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/18] xdp, xsk: constify read-only arguments
 of some static inline helpers
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
 <20241015145350.4077765-6-aleksander.lobakin@intel.com>
 <ZxDxjj4SPT0Y9KyP@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZxDxjj4SPT0Y9KyP@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0268.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::33) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: b3935101-4c27-41da-f46e-08dcf1d85c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VS9VNENSWDQxdmRwZ1dNM3ZlQzhVQjB0NjdISU1UN2ZKVkdPYkJqTFpqUlRO?=
 =?utf-8?B?K05jcXBCQVNoYmltcEpvVkQwVzJheUtXenhCeHJZQko2V25XOG9rU1BmT2lR?=
 =?utf-8?B?eDVJVFg3MUE1TnoyOExuanlBSTRGMUYrckZ4N0U4ZlIxN0Y4MzVML0o3WXpw?=
 =?utf-8?B?MWJpVHRTWWp6bVBvaHRvRFFnTVlBdXNOaHBKZUJwNkRWWjYyeE05TVlvTFVl?=
 =?utf-8?B?eG91VnFtTm9GNUtRMjhRclRwT3plcTNCOHkwcVFTSGhuWnFvakUyZWpHNDgx?=
 =?utf-8?B?b0hlRTI4YmFNUkt3RFdLUmxVZFYwV3BBMlhUZFRFTSt6TWYvcXBYZFI3Z2hq?=
 =?utf-8?B?MThteTROYkNVVnZnVVd4MGRIdm9WSmw1eHZkUW9HdkRtRllLdkNUSFkzaWdX?=
 =?utf-8?B?eWJaWnJTYmFmZVc1Z0tEWWJ0RjFPOGp5QkZmN3E1WnVoWTV2a0hmZllLcm9y?=
 =?utf-8?B?dFNxbDVNVzBOMnpaMEFaenNydHNlZHcwMVRDa1VMaGp1QjVGZElWazB6QzRv?=
 =?utf-8?B?Rmx2RmVsaGtpQUY1N2kyVVV6YmlqcHp2SSt3UHVFM1VFU3BaUC84aG9na1V4?=
 =?utf-8?B?NFlkbGpnUCtUNlNLeGNMaW50b1JicGJTczQyaDFRNFN4RENDUDRETWk3cGRr?=
 =?utf-8?B?M2JxU0Q4Q1J3ZXlZelh6WWVhZWV2S1o3OHorYmc3UDJ0WU5JQUpGZlVsYkEv?=
 =?utf-8?B?WE0yYVFReEZrNGlBNkJzZWJoZGdoeDhtUWJvcUI5SFRTVVI3Q2owd2laN2F4?=
 =?utf-8?B?OFNqNHMrRU1qR1Z4TGZUZTIrNU1GR2JSaVB5U2pqVXgreEdVQU5tWlVzWmpN?=
 =?utf-8?B?czd4TjFIbXFDV01FcUpPWVNsM01kREUvT3B3akc0MU9ST2JsNkFxbm9US21w?=
 =?utf-8?B?MSswRWJTbmJ5dkhKTGNQNFVyMG9JVGNvOXNoSC9oOHY0cCtqTkI0bGVVSGNq?=
 =?utf-8?B?V0wzVzNHcUx5WGNLZCtTQXN6MTEvSng1T2hkcW41QUZFbW5JcjdCSGRQWGZR?=
 =?utf-8?B?bGh0MWlFanhhclVocnd3Yi9ScmNlcEd2clJtNVFHN0l0eTlVdmFZNW1zbXVk?=
 =?utf-8?B?Tmt5TlIwSHI0SGN0dGY2UFdnOXVDcDNRNTBwWDFMRWtoZXJQNGdoVVhpczIw?=
 =?utf-8?B?T09YZEEzUXRka0QxeFNyeVdmVlU4Rk5HM3RBM0ZkSGRLMFFzYS8waXpTRlVZ?=
 =?utf-8?B?elE5Q0p2NzBZell0b29zd2dna09yZE5rUEtIck0xc0szLzJqVWh3WFNSVnUz?=
 =?utf-8?B?NnZQRU5xQUR3N1VGM2ZhQ1FnUWlTQ0FVblE0NU5lcG1tSEw0RHN3UnFMNEV0?=
 =?utf-8?B?OW5GTHFjM0Z1ZXdZV05aeFJ4ZlRPZDd2d1MyY0x3OXhqUkdFZjJ3N2FBM0hX?=
 =?utf-8?B?TGVIY3lLQkRKSDhkTGl0VVFGdFk2aDYrYkNHSWVpNHpBYVZaaFNDeldEclJy?=
 =?utf-8?B?TlUwQjJXNDVNSmthNWZXTkdjOVMwWmYyUjR3ME1iby9XeHU0OFRVUDBtalhy?=
 =?utf-8?B?VDBRMW56WXRXbDNJdXlZT01FZ08rN0NSc28rbEdzQkdGRTlBMUVrNU52ZEVD?=
 =?utf-8?B?YmZQVnpLMWdsaU12cGhhbjlxMnQ2QjZWQ2h4cFFKOE04YmFEUTdYcU5CdkdP?=
 =?utf-8?B?ZEFsNjR0aGc3ejRwZkJ0WDY0TnRocXNjNmVBT3dZZ3VpSkRJMzY5RHBxVjZs?=
 =?utf-8?B?R3phVEdZRXhPaCt4Mmp0c2N6dTFMR0c2N3duN0FYdUdqNXFqdXF0OERRbVVS?=
 =?utf-8?Q?wfiwyugL4mr6BX27sXYIBCVIFkXizUptp8Ou0Q1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TERJZEhFWUg3bFN1aE9qTGliZUJ5ZFhSSFd2b0lFT2JPalRNSmlVZDBZMVA3?=
 =?utf-8?B?WFRLNGVMMVRxb2VMMURQQWlJa0JuS0tjcjBzelg1QTFKNjFxMlZaMUlxUXda?=
 =?utf-8?B?VG9BdnNkVGRPTFBZbzM1bmZrRmNBNTB6b0J3cTZ3VVJ2MmFTUkN3K3RZQVJ2?=
 =?utf-8?B?c1l6cnhnYmpXNUxVVDNxcWliRGx0bFIvZUs4bnJ0VzhNN2wrdE9ZMjVHWnFa?=
 =?utf-8?B?YlBiZ1VGd0xtUjBMSTdzSGdYTUJ6NnczSkpCS2VMMzlDcmdGTmQ5ejVLeEtR?=
 =?utf-8?B?WW9hVkZmMGtZT2Z1YVdlNU9OM2JkR2lXZWt1WlcwV0ZJU1Z1MXFkV3VHZXJq?=
 =?utf-8?B?bWdrU0xMQWZRbFA3d2ZTVnE3TFJveGxlRVErMXVoUVFYTm5ZUVhVamlLdlZF?=
 =?utf-8?B?OTJ5MUFjalVKZytwVFJ3RTRnNTFTVkc1bXV2cjk5bXRNZkYrWE1yNkxRSGtF?=
 =?utf-8?B?WmpOd1BaaVFhUElMOU9EcW5EWi9UTmN3djJPYmM3SjdWTWVhaHIwejRpTHZP?=
 =?utf-8?B?UEN4bXhTWnZ6OVk3aHFnL0Y2MzV3ZzFOWk44QWg2RTRkdWx2MFpYMm4yRWI2?=
 =?utf-8?B?Qk1KZkY0ZGUrK3NLNXpleVpvUjE2dExva0xIRmh5MlV6MGRHd0tsVXdaK2h5?=
 =?utf-8?B?ZGdUVFV3QlY1UlFYRVN6YXRyR3E5U3ZzNkp0RmVGRzNpQ2tKZzgwdUI1VkRo?=
 =?utf-8?B?T3Buak84OVVmRmxJZDRhRmI3ODFTQmlsTXdNdGprVVVpQjRIdERsdm5TK2xQ?=
 =?utf-8?B?bzU2b3doeWVMdDBYbHBwQXNiTWhpaXVDbWxRMWhZWEtLYXEzcEdVOGQrR05R?=
 =?utf-8?B?MEdUNVRCaEllRmRTU1o4ZmZuU3YvSWplb09pWDgwN3Iydkdhamhnc3R1MFNY?=
 =?utf-8?B?TUJFalUwaW5JcFVzZ1EvOHVWZTZaRG91OGpaVWk5YlR4NnBMUng2YktTWkNp?=
 =?utf-8?B?MlZ5bm1ncXYzVitTdWtYbWV6YWhmQkRXYnJKMXdweGtRNmpuU2NUZVFmUnRv?=
 =?utf-8?B?eC9CZnJMai9vaU9CZ3JBNE44SThVOFRNS2g5WFpia0lSenlab2xnRUoyQU1m?=
 =?utf-8?B?K1lUZDIwM3NkYWFybUJjRWNPNVFKVC9lMDB1NTRPOEFqMk03akMzeER4ejl4?=
 =?utf-8?B?aTFSQ2FTemZVbytMVGdZQnpSRHd6d3V4TjJkQVRKQkJQRmJiT3ZrRXZTS1dO?=
 =?utf-8?B?ZHc3RWVTSWNwVEdnSmlhVTErVkRmZTdVRTZKOTQySUpiQkpUUVk2Q0R1amxF?=
 =?utf-8?B?czBjazB2ZDc3Nlo3bTMrYkw2aSsxQWJqaldseTQyR3hlUlpIZytBQWttemtD?=
 =?utf-8?B?eVQ2UUZrZ0VZZzY3RzB6TkdMN2lNN21SYlluRVRBN3ZQVmlqT0ZWZGRyUUxX?=
 =?utf-8?B?OGdYMDVIRGZzL040RzVFRlZwcnVPeG1kZ1JuRjNITWt0eHlRdnFDU04yNytx?=
 =?utf-8?B?MWFob0QzYXFXWHJJTVA3YnplWFhRN1VzaFBGVTRPbTJyYXZ6Y3Y0bmh0TCtZ?=
 =?utf-8?B?eTdSUHE5b2RINXZDT3Nzc1dyanVnZEJxSERhZzlBcWUyMGF2MUlxbUw1RGo1?=
 =?utf-8?B?VjVETWpKUlorT0pJRWUzZHJyK0VZUXZodW0vN2IxQ2R6RzZ3Q3BlOG5aQWRq?=
 =?utf-8?B?SU1pZkkwRTcvNVZ4SHFFNnk0TUE2VCtNVnBaVFdRbmM1Ris5TGs0M2dSY3JB?=
 =?utf-8?B?NzFBdmtXb3NJK2ExSkg0bG9CMFF4MER0U1lsUUNVUytpdi9reDR4d2lrQ3pn?=
 =?utf-8?B?cXBNU0RTcWFkbHBsZ1p4SitXSHFVNGtYcGlFMFVZSHVQcmJsYjAwbWRnWlhn?=
 =?utf-8?B?OW5EeFYwUW91VmpRQXVTS3FrNCtIcHhlL3dvSU9NQzUrY0VWekgxSzN3NlhW?=
 =?utf-8?B?UW5vYkgwZ3JOaWlJWDNjZmtvYzJBWGV1emtzZ0ZVWEhEeVdvZmRic1RFNlZh?=
 =?utf-8?B?bWJ0N1NOVkpXeC96UVV0c043c0N2dnVocnVkR2t2M3Q1UnM4dmREKzVhWFJP?=
 =?utf-8?B?dHA0NzcxMjBMMlc4WHk1Z2oxRnRIVWUwZlJIb0UvRkYwRGJlZ0dra0pZQkZi?=
 =?utf-8?B?amhRblF4bUtuZ0xmVHNmcUNGMnlDTzZzOFIxdVRyR00yN0F1Z3hrbW9ZQ3Fl?=
 =?utf-8?B?Q0d0SXd1eENieVhuQW9UUVAwQ05qVWttU25HY2Z0YW9KK0hIT0ZKMzJTdXdi?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3935101-4c27-41da-f46e-08dcf1d85c78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:57:54.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/sTGfwxxcAvH9+CTPjJDnOzVfU3QeiMrsgggEO//J6QyOzye3eVCStG3eesQsN+Osz4Vea79FK8n2Gxx+MJjzBHYEdHZ4joSaJyEwC+QGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Oct 2024 13:14:22 +0200

> On Tue, Oct 15, 2024 at 04:53:37PM +0200, Alexander Lobakin wrote:
>> Lots of read-only helpers for &xdp_buff and &xdp_frame, such as getting
>> the frame length, skb_shared_info etc., don't have their arguments
>> marked with `const` for no reason. Add the missing annotations to leave
>> less place for mistakes and more for optimization.
> 
> Same comment as in previous patch.
> Good stuff regardless.

Same comment as in the reply to the previous patch :D

Thanks,
Olek

