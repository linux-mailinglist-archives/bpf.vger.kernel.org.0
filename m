Return-Path: <bpf+bounces-46874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C889F1391
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039D8282EA4
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE981E47D4;
	Fri, 13 Dec 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cx+EQQxf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49257C9F;
	Fri, 13 Dec 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110771; cv=fail; b=r/z3oY0NUS3LW4UESYazNWUv5lzMAKvJjiXrCptWpM9m39XDlnd0yVoX5/YbXxWZwKeXK2GN6wvvu5QoD+gSZTSui48Ssnx5NYRwt50GBRhnrBHrYYZX58zC6SOrHZAJBm671syAssTnZegJ1uztYTkkENjx+UYOh3Zq2vyDP5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110771; c=relaxed/simple;
	bh=Rr7kfDWzticDnNCFIRDU6Z8kRHoW9bEIY824HjtDFo8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X3CG2MEDMK2JrpVlGfLcyPMrcxGwtM5O2rVWRzO5VQP36leSsajXTWfx0nT86FqKfZjTUqoH6a5eturnpAJGHVBdX4ReioWfAMgsULuuy2rABFsJ9cLGCoo1+GURlkjkWJPpqaI1ARBzX+keUknJY8XkYGSg6gEaibNimzt1bH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cx+EQQxf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734110770; x=1765646770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rr7kfDWzticDnNCFIRDU6Z8kRHoW9bEIY824HjtDFo8=;
  b=cx+EQQxfzWz673X1XJAdYsFmJplndWPeiMP2LhEfD9Q0eYUpQqN7SoJJ
   hUpI+3sPsYTkVkxknw/aVl7pq0X/WzpRD85fT/WjWwo2vxF/LQB3L+cSL
   qnWipxfbbkx+avtVuuW7n5O/Ee9EPdl8UvwppDzcRJDS+QBfChbf1JJ+6
   h8cokGvT40CnQt2RdaOvbu1MG+v97QHblGcWiEI67vRuyrd1LsbC6ZNuh
   fWoBW4oWYwFkS7DSCYbmrHCzsgbdq2DZTmEve2+2NGpglX16BNCwqSTqp
   uLIJcmhmVSv2GNz3Vo9ob/7bsaHxrTwtVzd7UmubGaf4wpBvD3NGMVLDC
   Q==;
X-CSE-ConnectionGUID: xNxVns5/QFmhVUOy/1UDdQ==
X-CSE-MsgGUID: g8SZPUNWT6CtwW68tFPZ0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45956233"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45956233"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:26:09 -0800
X-CSE-ConnectionGUID: Bx3DSMIWTRu214O2ESFOBA==
X-CSE-MsgGUID: FXGu2V7WRPyHEpCvYGu6Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="96472690"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 09:26:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 09:26:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 09:26:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 09:26:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiO9LrEDWxqNB2z1QJarrg25mW7KJZ//hd39nUraLV8bA35wu/PiV2Zde1qqkRyNZG+K3pNRJ3wvKY0lTD6Vv4bSm6CPnjr+i8V0/r9jXkVl9SOAGGLTnaMnoiLOreLCqvRJZd4YnRkXWlCOAzGFyP3P2XHN0DaatIMLLEu8hI1Is7aVIWPO3+VPlo/TerWqaUsFQWVaEnFa4PNsQr+NaTiASIqna72Eo56Vsandx0+XwCgUy4mfCzm2m3/fOt+zTlSAJiymfTDxVf0sMeuIC14slexc4Zn3nWfFiIcE0eXAaNJwrMqOm7zMpq7UmZRTng23o6qzme8BRGD4uX1s+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haCy4nkTMWO7VaQ056how5AbckhpAhURRQPMHjoBqFY=;
 b=pvUFNOoFyqP5OLcUovIbhqpu9DSHb6CeG+qPIEnjTM7EC2+0tsop2bz82dMRtkfkc+1lEvol1HLb/ACuu2e80P0m/UKxkS1b2U2qqVtn2rIXXasiiY6T2bjmPeZFzd/IhLwrRMzD0bLcy38kccK40NxAoK8GCFSN9TjXuknDcJvwtn+IaIFDPcYPJ1sh0T6Vw5AsEy5gW7RrVoSwpWbKIdYHQb/Xu7VS7UQ7zfKa2Lml0gePETj9qOve8ouWYktPzyj6T0YoWpHEcvxyLIiLvjdgJW4oGQkngrQ0ma7JQFydoGoVXpAMKnHh2s+wzGIVUyu6+um6jbXTUg0n6HzwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 17:26:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 17:26:05 +0000
Message-ID: <1fa637fd-c29e-42ef-9221-023693353d23@intel.com>
Date: Fri, 13 Dec 2024 18:25:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/12] xdp: add generic xdp_build_skb_from_buff()
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Jose E. Marchesi"
	<jose.marchesi@oracle.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
 <20241211172649.761483-6-aleksander.lobakin@intel.com>
 <20241212181129.7156d39b@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241212181129.7156d39b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0222.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::43) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7577e7-448d-430c-1b7a-08dd1b9b391a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0g2TlIwTU83MUtvRHFtZzBQRS9vWkZFQnh1TFlDVHFrVnNLeTFRM0RGaElm?=
 =?utf-8?B?UDI5Z3pqQld0aEo1UTVnTjdjRlNRS1ZKWlNseURrSUdKMUwrN2JFQ1dCUmtG?=
 =?utf-8?B?b0NHamFERnVHRCszcVNlSFM4azFtK1l0Rk1jZVE0aXZlNWpTMjJGTUxEK1ND?=
 =?utf-8?B?TERWc1FCQ3czWjRKM1IzSGFMUnhVMk1yZTU0aEFZMWt5emtXQnlRVFdjeVNV?=
 =?utf-8?B?MklzcGlwN1pLYWV3QngzN1h6SmJ4Tkx6YUdMUWNRV0hKQ1Y1aFk0THB0VFZW?=
 =?utf-8?B?cHplNVQ5NnJmRFZleHJiYXB5NmI4MkxpUUg4WjVUN2lxSjY4aVgvOHRQQktq?=
 =?utf-8?B?bTlIVlV0Vk9RNnZKRTd6SEtGU1dFRDlzZmcrWVFBbmx0MmtIR1RGYnpqZlI2?=
 =?utf-8?B?cXFNWWVMOE9zaitQNVYvRWtJVmtQR2c1TzBtL3huaUFORHhiUlJ3VjF2QXZp?=
 =?utf-8?B?TGxtdjdsemlJME0zL0k5MXFwdHZZZEcvT0Q0ZVVlbmFDWllYWWdiVUR6YkVx?=
 =?utf-8?B?OGZLbTVvay9OZ05SczJLRndRdUNkSExuYThucy9jazB0b25LUm5VUVkxVUlT?=
 =?utf-8?B?djNacXpKNFI1bmpYUHpEOU45ZGhqMXVyS1FJNDZkdmc2cmxUbjNvbDgveGZz?=
 =?utf-8?B?T25aZHNIZDg2dG51RTZsZGRnUE1MNXRwQkVFQW5XQkJ1V29lQ0xCSzZHZndz?=
 =?utf-8?B?OHZnVm5EdEUrZERycDhtMVRKcUZENnNuZ3A3NlhSVU9OUUN4RWgwOERpOUJq?=
 =?utf-8?B?VzFZK0lCa3dvWHZoWGRTcENNNi9kOTloQ0YzdWU2eExrWmtvR1FRbW5LRWpC?=
 =?utf-8?B?WndIRndMbkhlZkdWZU1uaUloQjd3R2hwRFVGeVZUMDdYM25DOVdvbXgyTDdu?=
 =?utf-8?B?YmhmcmQ0dGtnZ0pob2RvNllQVDF4Z1c4NVVTL1kwNmxYMnQvaVBhKzh4R1NT?=
 =?utf-8?B?akJEOWFLOGRlWXNiMDlOZmprUkVJOFZ0R0FJUkFsQjBIdkY4MVNYN1ZuTE8x?=
 =?utf-8?B?Sk85NWVkRnNoaldWOGNodXFCWmF4enpScU9mWkswY2V4MHZVRUIwd2hIY1JF?=
 =?utf-8?B?YU1qS3VCMWhERWRBQ2NEOVNBL1dkR3JUdlhlL1BIdytNdSs2NmZVMnM5bmxL?=
 =?utf-8?B?eElTTGRnTXUzeCtnUzVKYVR2SEcrRmxGdFBEMG1Vb1c3Z3d0MEVra0xpb1dQ?=
 =?utf-8?B?aWV4MUtVemx1eU1Oa0Zqek1sU0plLzE0aTRvcWxiL0ZDcXhUclRpY0E1SDM4?=
 =?utf-8?B?M3czL3dXNFMzMERIS1hLNWVWN3ZCeExmU1FIKy9ENUNCbCtSVHg3OUZlMHVP?=
 =?utf-8?B?eWgrNmg2aW43VWc0OStDRmJ3aHYzSEx2SXBIRTNSZ0x0cE1VRVlBRFlxZU9F?=
 =?utf-8?B?SlVMSHlaVmtvdjZFK1VXdE5QKzVTbGExa3dmUkhSVXF3Rm10Y3RFUnh5RUV0?=
 =?utf-8?B?bEpOcHVPbXdxTHhKMmJuQ1BIWmdURzRDYjVUUzBVUmFjMjJXMjNFNGFEYmVz?=
 =?utf-8?B?akhrZGdLbGt5bWxrOS80WUVuZnd6Q2tDWHZKL2tvQ0Z1U1dCL2tBOXFLSk0r?=
 =?utf-8?B?Qll5YzIxbzd6TDJiQmlsbytacFJBS3BsZmk0ckdOVU9XUk5EMi9rQTZrL1VI?=
 =?utf-8?B?U25mMlRhQytIVkpZckR5NmY5RlBLSXlXZm5EZlFkTzNCSGYwd01wZnpjcmNu?=
 =?utf-8?B?R1E1dlFTL1ZaTnJWWnRtU0MxTDlYMFhMbk9JVzZkMUg3SWpHRVlIalBrVEhX?=
 =?utf-8?B?dTRxbEVCYmZ3Y0dXKzJkTUN2OW5JOWxMVEYzT1BPTEtDQ09KbW5yUmt1WjZz?=
 =?utf-8?B?dmp1b2lGbmFPWDFmZTBnZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amRTT0trWDQrRFdnTzBxdVZkV2NXRTlnQksyaGFzemc0ck0xbUtIakZUM0No?=
 =?utf-8?B?OXEwMjh1NEFPQnAxd2pjUzV4WGZFRXhUbXppN2FiZHcwNnM0RVorMTB6VjhG?=
 =?utf-8?B?OTBacTlISkYyS1NING93U0tjT0tORU5Fc2lnaE5RQ21CQjBkdU1CNnUzUkFY?=
 =?utf-8?B?VFd3VFJucytpcU5vcFVQKzczUGo1aVZXUWx6QVg3c09jekhNTWtyRDk4WDZS?=
 =?utf-8?B?V0tFZXpSSHZERzkyNkxmQ2QrMGoxWFJRZUlFSFk2cFh0RTNwVUYzdXlLbFNz?=
 =?utf-8?B?MWdFRlE1eU03QlNRWnMxQWVSLy8reTlRSWc2a21HMElXdStNOXFMdC9SeVBu?=
 =?utf-8?B?ZkNaZWxlalRLbFAyT2hpRGF6MWdsTTBNTmRHaGVONC9sUnU1b3UvdGg0SS9G?=
 =?utf-8?B?RGV4K3BaUGNYY09lcHdSdWc3T3ZXL2hvZGliT0l1eitBKzRZbjZiRkpyWHdJ?=
 =?utf-8?B?RGNpSzNDZFNmTUJ6N3BiOXNUbXRyOTJiamVQeE01U2xuNGhhdGpPVkt4TFM1?=
 =?utf-8?B?K1JiOHNXMHFIcWJ0TTJ2clBmSEcrRUtGVGZpaW03VW8yOHBoYlJFemRCalgr?=
 =?utf-8?B?MFZWNURJN2wvbEsrVkZEcWRZUGNHUmZjT3hqdDVjS0VOU2dudjdnemxUck1P?=
 =?utf-8?B?bldpbFladGkwK2tpQTg4TjFyamk1blJCYnVGWGd5NWcwb3U4SG40cS9sRVQ2?=
 =?utf-8?B?aEJVTXFrR3dUTmR6ZnVpUFIvSnM3TXRvcjgrVXczaitNcXhtTjZ5Z1UvclZ1?=
 =?utf-8?B?a1NDeUZxdHpOb25QU0pRS21WVm1zSGJXUWxWVER0TDltUjMxMUJvdk01a2FU?=
 =?utf-8?B?Y1g5TjJVc2dQQ3RUTHhEeWdYN2FJNXZwc3k3YkhNQWFNTGkxenZuZjgxYlor?=
 =?utf-8?B?RkRQYjNqSXJuOEdkUmYrUlpWUmpBTU91dmZhQUJaUWlORTlFQmlVcjVaTjdo?=
 =?utf-8?B?ZjhXelIzUXZkMGYzUFN0cUwvbDZZWkdtY2hvN28ydXp3b2NvZWtOeFhrUHhS?=
 =?utf-8?B?WW8xNU44TEs4a0hpZzZIc2kvc1FUMFRKa3BkSkppeVNBVjlydTRCaERJNnky?=
 =?utf-8?B?M0dCTUdqUURtOVYxNkd5TDNSb1lrbkRsV0NraGRMNEl3TUZqZUlibk5GRDc0?=
 =?utf-8?B?VUo4a014UlVwS1VDL1MzWUhwaFlVb1FJekVpMTJldzh0MjFuS3lrb1VQUTNM?=
 =?utf-8?B?TTV0SGhPaTdJN0hMSjE0MHZMa0NXTzZVM3lsM2M5MjN2WXhwTmQ3S2ZZWHJ3?=
 =?utf-8?B?UDRQRUxXc0RlQUJnRnoyQ3Q1VnZteVloekExU01uZnlGMFVBcW1CQnNRdXpi?=
 =?utf-8?B?RVAxUmNRTWZFbmFnYk9RTkl0QlR5R2FyTDVFTC9Pdzk1V1M5ZzhSZlZucUsv?=
 =?utf-8?B?MENkSExGMjZGaFRSNEx1YlJlbHVDdVpWMWVZVWVJOGpYNldzV0d3UGN4UHE5?=
 =?utf-8?B?VXo0YlZzNStqUzJjRlFPdTJXalc3S3FGUnNnNW1BV0x2YTdvYkVtOUpMTEhs?=
 =?utf-8?B?N2I5NllsQTRDaSt1eDBnMk5FdVhmSnJTYWRudjhidU0xNHNnTXlPNkxoZnhP?=
 =?utf-8?B?dlgwUEZFNzJpOFpLU21SMjA3VHFWaU04NTA2YTZkbFJsZVArWktucm5VNndC?=
 =?utf-8?B?Wkw0emJpMXAyZzhtbFJJVTNwcytsQ1JEVmJXcXVUTTRYMzFCb2tWazM3bk5M?=
 =?utf-8?B?UFk0b0cyc05qMjBDZk5JVUpsdlFxSDZIREszbFpOZ3pHMk1uL0kzQ2JXL3FW?=
 =?utf-8?B?cis5T1pJSnRrSEVIMlJUeFJneG1Jc3NYVG9JN2dBendPYUkzaXJIdTVid0Nm?=
 =?utf-8?B?RWlkWTFtMk5zV0J5ZnNTWHFTNTc0Y1hZUHVsdGlCQkF4TTZLWnFJakxnNXAr?=
 =?utf-8?B?VitiRUZjaUxjSWQ1ZTZCdkRSbXNSTFowbGtPNCs4Z0FSM2FQSkwrdk42WWwy?=
 =?utf-8?B?NUdaMVVVR0ZLb29keUFIekJJWjIyallaQWp5RG5Bd2xacFQrbGJ1MVdQSmRT?=
 =?utf-8?B?TDBaUzl0bm5RNlArUExRcTRzZzRJWmE4OEY1bkVIVjdzdnVBQmJGdXAxOUtB?=
 =?utf-8?B?anJ6TkRLOG9HckJ0Zi9Ua0UxNGE5RlhLTmxuVlJnQXp1UHhGMkZNTVFHb0Qz?=
 =?utf-8?B?T1ZrWGZhT3d0eDRjZU9lVFRONWxuRjhOSUhqYjZWVUtTOGtIWHBwK0FUUVBX?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7577e7-448d-430c-1b7a-08dd1b9b391a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:26:05.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPeZIowDEU0Q2idyQoSqr+0yxVY2gJeWDYi1CeyvRxMhZUGnnUYHZXKXHks2qfWVWprUBycD/PTjCgDEA6WWj0Xvw69FmFsIHe4Bi/J+xqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 12 Dec 2024 18:11:29 -0800

> On Wed, 11 Dec 2024 18:26:42 +0100 Alexander Lobakin wrote:
>> +	if (rxq->mem.type == MEM_TYPE_PAGE_POOL && is_page_pool_compiled_in())
>> +		skb_mark_for_recycle(skb);
> 
> I feel like the check for mem.type is unnecessary. I can't think of 
> a driver that would build a skb out of pp pages, and not own pp

But there's no restriction that this function is limited to PP pages.

> refs on those pages. Setting pp_recycle on non-pp skb should be safe,
> even if slightly wasteful.
> 
> Also:
> 
> static inline void skb_mark_for_recycle(struct sk_buff *skb)
> {
> #ifdef CONFIG_PAGE_POOL
> 	skb->pp_recycle = 1;
> #endif
> }
> 
> You don't have to check if PP is complied in explicitly.

Ah I see ._. My idea was to compile-out this check/branch at all when
the PP is not compiled in, but I think that it would be optimized out
anyway by the compiler, so correct.

Thanks,
Olek

