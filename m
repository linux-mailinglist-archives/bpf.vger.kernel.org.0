Return-Path: <bpf+bounces-64210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1720B0FB61
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD8177E5C
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD926232386;
	Wed, 23 Jul 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSnKwJ51"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0B2E3719;
	Wed, 23 Jul 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302141; cv=fail; b=bVVWF3sBDme25P7rhbwReCztkD+w61FTvv++kWF5gNK/8c0xhrrhslUg8p8Jj5+I/nVtKWoir/Mj553Bpv0LPmYA/eOuCgbOX3IGGqw/egOmeUiQkTxRAm6dlk+lZxWOMiFNS6hBrQF2CvvXZpR83ASuQnVIuZUHJjjmv461jbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302141; c=relaxed/simple;
	bh=VaGYPWfar2ttyWT4H7vTgZcBD0kik1XoLxQTBKeBX7U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=juAssfKsKc2gAcBzlGZ/iRfudh7tZzvAA8t78XMhVtcJJcu0IpgbqCy4qT0TaJQgEfzViGqwVhzMGatvRp5Q0N08WwVhWmnwXSJ+LDzWezWYoCVmooYgEjPIsL5ls6FZDPYDDjR7EX2/n0IGKb0KRAxCXgM54eauhQz6pcH0uwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSnKwJ51; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753302139; x=1784838139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=VaGYPWfar2ttyWT4H7vTgZcBD0kik1XoLxQTBKeBX7U=;
  b=lSnKwJ51k3huh8NeV/i6uaXLtfxeFSVo2Wiht3Xwsf/O0IbVfoV5DUOd
   Eflwm/kxwWHzKFB/w8YTSEMasfgcg5bXY41AiOcROwo/cOCgP/xr1RpP3
   htK4KcHQQnNcGsQtTvF+E6gSYITXRdVCddnUs+ZaGegV9tcbwX+MrS+oi
   6hU3C4GKeaFXRLQxZ6GEjVWeE0KrHBzqAowae8tzIpEjKTijJqHRr5uf+
   /BFikY3TpNcELuhrkItZk+q+chcm1Wy7flFvoRsBf1h1ima9TwL7f0OT/
   09kDaVKIeafkdiOzmm7hDlyLvuHmo9Hf49ZhnGs3J1+CbFXxv27n4K9IA
   A==;
X-CSE-ConnectionGUID: mjO82f2RSFqRn5GQyzoSUQ==
X-CSE-MsgGUID: F23ZD9EVTaSEfcO9LHT8gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66671296"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="asc'?scan'208";a="66671296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 13:22:18 -0700
X-CSE-ConnectionGUID: vAwzAS6bTZ2e0wsARJP0NQ==
X-CSE-MsgGUID: YW2+0lCjRYud7TptiwuuUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="asc'?scan'208";a="196825979"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 13:22:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 13:22:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 13:22:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 13:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL8geDyDY0SqimRjqPUgQwiKe2JVu9xkhm47y/91aFFW6FFWwd8XY6sFQbMwefKSP2c/woc/U4cZy1jxIIUJ/D9Ec7QU0FIPj5ucweg/75qo5wD3fmjQrB8PhkNwnTLRAIZ/AjM2DySCJ7QnvvvTYu3x6cRG9cw19qSp759jjRmswzH7pgipulKiZgBstt/mjJh53WHTNWuRmjzUYyL0Qs/TujmAQ2Vr/Yg8NaswaM9DKAzadfWk0/cUQHMZXQCAjR/6XTNqnCBw00Hu1DKwMeGNFkPDAqn9ZaVj1oIYeLDJ/Ma/qhH+os0XvWeysw0MCkoFboCz0q7zN6qCqBhAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaGYPWfar2ttyWT4H7vTgZcBD0kik1XoLxQTBKeBX7U=;
 b=k8V0TDc+LYZIiizCKfjdS1QlcmKtlu8iWaSNsNOFL0/w/0PKctxAHxa+5iV6BEEQB2Q/ppER/8yEOCBSv5UI7lfBD7DADXcYqaYz0vyiIO99mz2wUbFHd3lrXOYhtESkQboO3NfNDSgiliXOF/L1Ew+dRC0N7OP2pEFlpMMxYsjD7uPALdMXfdnRhyspztQUbV5XWWCRu53sZZJQnYltpxSGVbku1pRr3AMy/AOgA+r2DrGFKDDN5vVVsUVsNY0/X5F7mJwTj4I1CQ66efXSwaPQ3ke+M2k2PYAmyHnin/T5C+s+A3AD2orkBkJad3F92Wi/B2NPksQH2p+JsAzF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Wed, 23 Jul 2025 20:22:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 20:22:12 +0000
Message-ID: <2b2f6d5f-c38f-460d-aefc-3bf28801d630@intel.com>
Date: Wed, 23 Jul 2025 13:22:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mana: Use page pool fragments for RX buffers instead
 of full pages to improve memory efficiency and throughput.
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
CC: <kuba@kernel.org>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
	<wei.liu@kernel.org>, <decui@microsoft.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<longli@microsoft.com>, <kotaranov@microsoft.com>, <horms@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <lorenzo@kernel.org>,
	<michal.kubiak@intel.com>, <ernis@linux.microsoft.com>,
	<shradhagupta@linux.microsoft.com>, <shirazsaleem@microsoft.com>,
	<rosenp@gmail.com>, <netdev@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <1d18f7dc-eca5-4daa-98fb-5c8d20ef6ac4@intel.com>
 <20250723182224.GA25631@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250723182224.GA25631@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------my3uw5vjMlZ9wMHa20y7qXA7"
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 249c4390-169a-4a51-fcea-08ddca269bc5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1l0bndvNVlRb3VMVFFGZVJYd2E4QWtRNUZhRG8vY0d2bDNXSTFnbXI3RHFX?=
 =?utf-8?B?Smk5NzhjUFZyMWlRUTBDdkZzSld6TGNKSTdJYTV6ekg1M2RTRWE5RGlJSWZL?=
 =?utf-8?B?MXpUZWtGR3hDTVJ4UmlqdTh6cEdEeU9STnhpeko5QVN3WEpMSVA5NnFUYVor?=
 =?utf-8?B?Z1FBeVZnNWNyWmF2TTNuYjB4elEzbXNGemt1YmZrZHV0VUhxVTlrb0c2V0x4?=
 =?utf-8?B?TDc4QTIrYkhYbDQrTG5CNHJaaVRMYUh4MEJYbjYwMjg4Y29ycHh4R2RpNFZG?=
 =?utf-8?B?bnIxMmdDZ0U1Ujg4ZTMyYkhDM2ZRWlJmUHdFTWE5S09CemRsSWZDUFhWdGFE?=
 =?utf-8?B?M1YrbU52WFRRdnVTMXhtL2FKa2w2eHlrWCtIQ1c3ZmhjTnJXaWZqb3FYSVFC?=
 =?utf-8?B?QXpBQ0xMOEZnZlBkak1CVXR0djBhQm1MRjd6S0c0MmI5c0JDWlFXbENtakdL?=
 =?utf-8?B?L0ZzbHZaMEVVQmw3M3A3eWttMGNiZ2JMRVB1T2FoSmlxNEpManpzMFpYdVl3?=
 =?utf-8?B?SDE5VDZTaDJrWk5nOFMweWNMb1JZR1R1NU5zZTh0UzZEREZ3ZlF4cDNVdVlE?=
 =?utf-8?B?VUZXaG1mYjNJajNBZzNpZU5PRC9ZQXNwbFhicjNONVRPMXRITEdISUtaNWFm?=
 =?utf-8?B?ZndMdE5tSEtFRTVucWU4ZmIwOE54aTZ3MkVQeUV5Ny9OZW5YMSt4S2RnN25V?=
 =?utf-8?B?cjQwQ1pwa3hqNmZOMk00eEg2c085K2FhVDBEaENRUWtnZVozazZtb2laZnNG?=
 =?utf-8?B?VVhxV3htSlg2a0kxZ3FOOEkvcE9jMENmd1ZXWVFoczlLejdZRFBpM2ZzeFl6?=
 =?utf-8?B?WjdXa3BNSU9vY2NNU1FWNlY5UHNaRXp0Qk9GZm9MSEFScU9IMkRtd01LcjVh?=
 =?utf-8?B?T2VWcDgyZUdheUZ1RDhnZnZRN0R3TGpBY1E3LzE2MUpXL2VlVGdqSVR1Zkh5?=
 =?utf-8?B?SHljbTFzOU1yeVlyZE00RXBjbklld3QvMU1OZVJDUmVELzN6eCtPb0VVNkZT?=
 =?utf-8?B?cXVNVlRpZmpIMlhGV21Rb0QzZlhXYW1RcWRZc1ZibmgvOFg2OFVGejRyeDFL?=
 =?utf-8?B?ZFRGUW05UEg1MTlXeEgreWs4V296STlweE1UOTVTdFY3L2xLYzVlYlQ4L29S?=
 =?utf-8?B?QUlud0Q4czZsY0xZZFZ1NXRjWHB4N2JxVERQTllzS1BZb1pqR1pXcnMrTmVD?=
 =?utf-8?B?NlJyM21mdmtYdC9ZcnE1NFVXejRkR3VHd0M0ZENWMkU4aWRuaWllV0ROTzhM?=
 =?utf-8?B?NHFhVlNYYmdNenp1S1Y2NHZPWVB5c1F0bWVtNFllY2JSOEtPWTMwTmZrdW5O?=
 =?utf-8?B?M2VHM2ZiZEdNQTVaRldVWHpaZ1FMR3ZGYXJEalc2L3kyYmVkU0UrTlo3Vk9J?=
 =?utf-8?B?WURWeUFxbm1hcUpiOGZVNGFKY2RtaW8xU2FGT2p5TUtqdWtJZEdGdU9SM1lG?=
 =?utf-8?B?SjUyWkQ5L3pRZTB4US9MampYcUN5V2FOcVdOVmx4ZHVqUXFYNllNR1d4eHpP?=
 =?utf-8?B?bGJSa0h5NXhnRkl1UUxFQXRGaFllVC81WGNzSU5zN29kRDBYckpmUm1pV01Q?=
 =?utf-8?B?UzU5TnZKd1hCR0I4S0xjdVJZRTNWTVVOWDhwbXRLalhnYVc3czJvT0hURlZJ?=
 =?utf-8?B?STc3SnNBNHdnMkx4ZEloNVRXK21iRDhxVml2TEQvNTc0Ui9qSjFLK1NCdVg1?=
 =?utf-8?B?NkJMckpaRDZ0RTJjQ2pzTTlITW5FVC9DSWRBSy8rTUFGOEVXVXpwVGplS1ho?=
 =?utf-8?B?QzRXaGxycDBpbW5LdjhyVGtva2U3R1YyQ0EyUXZya0M5Q0lFQmtrK0VDUDZ1?=
 =?utf-8?B?bjhKemtER0pRcHQ2bUpDZ3FHM3pXUzdPcUdDTEk1M2JDRVRHb05LQzFSMktK?=
 =?utf-8?B?RmRRV1BKZGl0dHRVZlE3UzViZHh5UE5kNlFsTURWN2JaRHdxMWg2Z0haN3Mx?=
 =?utf-8?Q?1caKGDQ/+bU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxLc1JpSG9XUnA4cHpnNy80cnJTeTdCaCtjNlA4NjgrZXVQc3VKWUVCd3gx?=
 =?utf-8?B?a2V5VzlZNEhXM1RBSmJ4cUNvQ09jR1hXLzNxRHBUMldEcFBPc21XcFJRMmo1?=
 =?utf-8?B?YkFVcXdBQVdRdDRoZ2FYRkhMR2RrUENJOUN0R0RmZ0UwNEprQ3c2TmQzQUx4?=
 =?utf-8?B?NWlIM2JaMEZnWklNM0tjbmtiOVBDYkd4RklleGxid1AyVTdPdFRCRVUvTVll?=
 =?utf-8?B?M1ZMSS9FWHZmUE82cGxXQ3dzZXZGclZORUFFWDFNZEpFNW4yUllEdFV2dTlF?=
 =?utf-8?B?ekh6U2NWVGZNdm92Vjd2Z1o0ckVxNWR6aTFiR1FrLzNCUlVFWHVCR2pjVVls?=
 =?utf-8?B?NFpIRUxPSWZhQkVBK1BsdHpiR205Z2NYRTZTK3hEOGtFNWsyUVVzQzhjS1ZQ?=
 =?utf-8?B?UUxaaHBpVzVxVHJQY3dUcVpjeUtaSWcyQkxhemlSZmdtV2lrdXJ2R2NvUjhv?=
 =?utf-8?B?K1QxK0tIYTNDRWZKRzg0OXBXMXlHTW05ZDEzN1AwSnR6WS9wNHdmRE9NL2ZH?=
 =?utf-8?B?R2UvNjU4Sm5lVHAvbnZlMVRMU3ExZEdHTDZaK0tPdHoxVFZXdjZDakUrdDk3?=
 =?utf-8?B?Q1dqdU9JSXltZmo2UEg1SzVpNUg3Zkx4dlh5dFNPRWF4Nm1ORk1IN3hUUklD?=
 =?utf-8?B?M1pBcE5kNjN1eTNKaW1EUDcvZVpuSDJKb3F1YUg2Ri9Nb2pLejE5bis4cnR0?=
 =?utf-8?B?NHU2V1ZzMEVrRFVQOUVRMmQrUDNWUVoyUWFRUmJHTHhCWkgvRUNwcVlITFJz?=
 =?utf-8?B?RVJrbDdYOFBycFZUQ0xpZ3ovZEhneUMva3k5YjNNejd5cEFaTG0rN290NjdG?=
 =?utf-8?B?NGFNVUloZU9sSm91TjhaeWxSL1dUSHFLaUExdnhWMmRrMmlPbVJ5ZHM5bHRE?=
 =?utf-8?B?SUxXRjhzQk53eTJQZVMrR3VQeE1ET0tlUkpCWGo5VWtIMTNrVzZjQjMzUnVV?=
 =?utf-8?B?VHo2eVNCOXBKT25ndUV1RU1WdGc3MUJPekw3T0xqZjRndGpTZmMrMUVsTEhB?=
 =?utf-8?B?QkV4QU53S0NLeE1lVThpZCtQeitZR3RnOW5SOHhPTmh3YjdCVXRaQkp1Rk1m?=
 =?utf-8?B?dm45Y0x3QjFFdGJoeWpZTkRGTjVRN3lvNTI3THlza0c0Z2ZsU2RtUjJSb2pz?=
 =?utf-8?B?TzJ5Z3hkbGhYaHlnSmE2NWhzSUdyMVF4dlI3RG1mU3ZxTTlCaUk5dEJPZjh6?=
 =?utf-8?B?L0syRjlpWUZZYUtRRm5JazhtSlVWOTlRb1V5bnJqUDlrbDBzbEh5Mm1XaXJa?=
 =?utf-8?B?R3dNUkRkdjVDMjFudXJzSHBwcjlEZjdiand1T0kzelVibG1zcTdjNDRBL1ll?=
 =?utf-8?B?L2lpc1NyRGxxTFdkYTZmc09tbXJPdnp4UmNMUDdFSXhyN0R4UVVnY1NoNW41?=
 =?utf-8?B?WTVhM054c0lKNlJiTFhsN1lBUEhTcVVmaVFIeCtZV3poV1VVVmhGRXExczZ3?=
 =?utf-8?B?bVI3SG5oazlUOGNWeW53UExHUHdWbS9yUzlEdnZTWFJGTWJWN1NiNWFiT2Y2?=
 =?utf-8?B?dExOVmVDMmhibk5KNHJUNlNUbm85YmVsQzFkdXliVzRaOGdwYjV6QWNUUUYr?=
 =?utf-8?B?amVWL3c5UXNSb2lteGRSWDRsOElYdG10anZmaWYwbVFwelhaYUpQY0Z3SHY5?=
 =?utf-8?B?Nk9ha01nRnR2QlhROG84NTlxU2dpVHdQL25VNE9mU3BvZlJ0b2dscG0vTnlz?=
 =?utf-8?B?UHVLU0Ric3NydUE0ekxNZk9wV3dqKzFYTUs5ZklEWnVZc3R2MVV4VVUrTEN1?=
 =?utf-8?B?M1c0cXRGRkFMTmxsc09TeDl4OHVNTHVxMHdhbkluZlhpRURGWWw3MUJLMW0z?=
 =?utf-8?B?ZFo0d21SWEZBSG1tcTB6cTdWSEc4L1JrL3crdHFISXlSRTE2bldoNllmbmgz?=
 =?utf-8?B?TFdaNUJUQmNHdWI2aE1pT2crNC9JTkZjQlJTVlNRdVdjY28wWGtwbVNGSkZy?=
 =?utf-8?B?cU4xOHhXc3RYVmZoZStERUFnTkhuYWxLNC9EdDNwc0taYktBc0k0OTcxL2E4?=
 =?utf-8?B?a2JFcHk5Ukx3YVc5aXlpNmlObkYvZk5QekgvTUVGSlpUVXdMMXRjcXNnL1V2?=
 =?utf-8?B?ZG5zRlk3Mm5MbUpUTHNFNmFBc2IrQTBPTUw0UTRsQmFkK0NtenhXay9yUlY4?=
 =?utf-8?B?S3VFVHJxK2hHL2pMOHR0NVFCWGVNMWRNOVZjMmJMcExZelBQQ2RwSEpmY0Ur?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 249c4390-169a-4a51-fcea-08ddca269bc5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 20:22:12.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xO9wPZi6tw3i0Eh7wlf28uiPm0rufMvicmgifcjzEQ1cy24/PQx8E7ueqSDm/XrlhGueCsTxAkNL7axFLS2xjKGIdA4cDh8EVvmBRIuf9hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-OriginatorOrg: intel.com

--------------my3uw5vjMlZ9wMHa20y7qXA7
Content-Type: multipart/mixed; boundary="------------pNgYGvUBkoVhz3GG5Xj28xuj";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kuba@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
 michal.kubiak@intel.com, ernis@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
 rosenp@gmail.com, netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <2b2f6d5f-c38f-460d-aefc-3bf28801d630@intel.com>
Subject: Re: [PATCH] net: mana: Use page pool fragments for RX buffers instead
 of full pages to improve memory efficiency and throughput.
References: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <1d18f7dc-eca5-4daa-98fb-5c8d20ef6ac4@intel.com>
 <20250723182224.GA25631@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250723182224.GA25631@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

--------------pNgYGvUBkoVhz3GG5Xj28xuj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/23/2025 11:22 AM, Dipayaan Roy wrote:
> Hi Jacob,
>=20
> Thanks for the review, I tested this patch previously
> for 4kb page size systems. The throughput improvement is around
> 10 to 15%. Also sligthly better memory utilization as for
> typical 1500 MTU size we are able to fit 2 Rx buffer in
> a single 4kb page as compared to 1 per page previously.
>=20
> Thanks
> Dipayaan Roy=20
>=20

Fantastic

-Jake

--------------pNgYGvUBkoVhz3GG5Xj28xuj--

--------------my3uw5vjMlZ9wMHa20y7qXA7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaIFEcwUDAAAAAAAKCRBqll0+bw8o6LxJ
AQD5TATeEjKH/JhRnR7d9Xe4Zv2t0UnS1WNJOHG0oYIUXAD8CIe+zrWRTnrWhCKCT298gixuNP9t
q/i6xVrM/77dOgI=
=pvSV
-----END PGP SIGNATURE-----

--------------my3uw5vjMlZ9wMHa20y7qXA7--

