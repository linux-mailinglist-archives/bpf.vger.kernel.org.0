Return-Path: <bpf+bounces-46873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600989F1388
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B65B2816CA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343D11E5018;
	Fri, 13 Dec 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaimGpjY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8772364D6;
	Fri, 13 Dec 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110602; cv=fail; b=R7rhbSBgVWbKmCUlsWbH9pqNAKVFkvYXh7iSwTeeHnHW0NdX7/7qjl4N2jt2cw3oPgTQ3ToqIFwShFSvT4Rd2hqecNr0vrWKKyLtWFIIezTSRm58MSV4MNZOTP8K6El8KtTNuDgBB6EXjXi9UUtNPPx1cOP2FsntWJBCuw0XYZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110602; c=relaxed/simple;
	bh=VUBn5D+YrYElSK2hxVGIPSygrPaWu0kg598j9LP7dk4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rjBk+PJrIAW4dOY1fl0WAYWXAi1RpHi3PLYT95XMYaZsbGZOdJ/Vm5IDz3J0+F00YWyKbctU6LE17usvHU1cCpk4Grp76SXAwKj2eYWkHXVOlOvHsCC30B4vwGmtF8ZaABDiRaYwBCnT8gY7ZZRYLYggnT7jspZ9ekLtCVWJyvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaimGpjY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734110601; x=1765646601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VUBn5D+YrYElSK2hxVGIPSygrPaWu0kg598j9LP7dk4=;
  b=aaimGpjYJNvGToKVEzzj1pD7Pj/AcPDFTDoAVO/ss1FR0t2Oac2y3hl2
   ZvlsmhTbxk5/RXYtamzZMZfzgTuvoBj5NnD6uQXy0PUJgCsNb8OKNBbwB
   makV4r8ae9l52P39YH6h9LsDwr9udnKmNEPGA18Y97C8ytIb7FVM8kktK
   XTaGgo0JP4YDBVmj4z2Vj2s60T+Q5MXVUZ7NTcj7KygKltR3hrlJ27Au2
   24ZsLvwnI4b1Vyu4o+8E86IklhcHEDRGA/eXq5sWlYoz9EPs8LjOtWJah
   WJU8elgx56abZNS4MBhaPnIEI6thK0q7axmYXqFMebQOoqR1pgI2GaylL
   w==;
X-CSE-ConnectionGUID: 36bCwdj9R+G/wyCrYWen5g==
X-CSE-MsgGUID: HF3pQseMR9+k2oBaTAZ/Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="45178685"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="45178685"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:23:19 -0800
X-CSE-ConnectionGUID: dNJj3K9LQZyAymCGDgYGJw==
X-CSE-MsgGUID: /L4+x3ccQHWBkJ/IelP9jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96456321"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 09:23:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 09:23:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 09:23:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 09:23:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6p1kQRfTDSyqapcww+e4ZQd4rUZXvzrap+AIUo3BFTdI3eiySnmPZOs8Y7wCVO2RHtjNzPVHs2gubNuNJvulbSapT8iMhu4vZNU1/CdU1gAENPihKM5ffAzN3qAfqPFGAbH8FFMi0447RdHHuOgbYWO3s+yEKiDKyNBvsM1+9RW3+EYBV+pOCi04jKkrSpzd7HgkunjEVZY5GMU5pDIPt/RCY9GC3Mf6+cD01eSg6cNrDQpM07c7HcVPkLAWH9J5/F5zhPYvWkdPvcx7nKhewU4u9L4ZNVQuxVO/4uwODzSUxAz2z0T/MjHoY7DLVCWwTwWAVokjlbx5woOHlJuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szpbwASe8dMCCm29gU4Ah8D8jD+WHjzIQx/grK4qZQc=;
 b=nCtcz/D2O+1I6aBkwQb/J6OLvy5KoQrSFiaku843yeIMPtC5+cN45CdBZYsFZ5xY0E4WYOPGcJYlHdNCOOg+Nw2SkmwlBAmNz0MEdwaTG4D9jgvUTVEptyiyB+0oEcWTqXbCvn5otejZiXmDs8eLSsNhdrOQqhP93eWU2gG/KSYiLPw/rHWdpwU1EzRzwnLJoMN9/LjOfFkifr9LTijjQJvIHKYl70It10QOxVXZd7ZbvbAnW2CIaQ7197JKlqf0R6GDuZ/sBWlN29HW80c6+8qmICjJFdhJNakyB40wWNkNXjpNNd64oq5rKHj5Qt6LMhPHpcjgB60GB9p+5z0BHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 17:23:11 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 17:23:11 +0000
Message-ID: <a4af5958-38bd-44c3-b539-8e112a0c0be6@intel.com>
Date: Fri, 13 Dec 2024 18:22:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] jump_label: export
 static_key_slow_{inc,dec}_cpuslocked()
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Jose E. Marchesi"
	<jose.marchesi@oracle.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
 <20241211172649.761483-12-aleksander.lobakin@intel.com>
 <20241211174000.tpnavd77pyfq7hw3@jpoimboe>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241211174000.tpnavd77pyfq7hw3@jpoimboe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::46) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f8c3b7-0edc-41e4-c3c0-08dd1b9ad17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1ZBRE03czk0V2R2ZkVESFd4Um1rTDlLa3pTZU95VUFqQUNTNkFRRjdMUXB6?=
 =?utf-8?B?VUorKzE5QUtTdWw4MjFRcStFWkxJU3REdGo0UjEzUnBNb3I2a3lEVDVqd3NV?=
 =?utf-8?B?MDRqTWJTRmlwVnVjajlJK0o1b3FIT2RhNTRVZjZ2OXM2ZHIxRTUvTUFBTUV4?=
 =?utf-8?B?eE9hSFppWHF2U0tVaWJGT093MndGb2huMVh1emxkUG5PZlpSV1orNjdsQkdR?=
 =?utf-8?B?aXNnK1dxN2p1NjErOHdSYnBmSCtEaEloTEcwM0RHZHIvQThhV0tmTWxHa1ZM?=
 =?utf-8?B?bzFIZlUyZXN5cEw3c3NWZzU1UHJra3RlUUF0U1FETnh2dmRWZTFBMlFZazZl?=
 =?utf-8?B?akhJVHBPeFZsS3lXRjZSaXRMbE9BSks3TUI0dmxPVFRQY0dzYlFkbmU2MzND?=
 =?utf-8?B?Zm5wMzFidXV5RjFXbVI2b0UvS3BFQmJMVkE2Mlo3cjlhT3RNcTE4VjZORlkw?=
 =?utf-8?B?eFZHOXcvOEMxc0ViSmYzZW5RZTBQdUM4czJWOVhmTURkYkxhV1ZuVVJjc2Zs?=
 =?utf-8?B?dVBKVG81Tk9RNWlGeFFMYjNHOHZINW1lWTdmNW9wL21Gdkl2WTNQR09NLzU2?=
 =?utf-8?B?Tk5BM2ZCWE84N1dRbGFTaDB5TEdPL3BuU0pNUGlhNWd6aEVrYzZQUjI5eDVn?=
 =?utf-8?B?dTBrTW9FTmdQZkNNZk00dUpIZzZjVXJUdDZadU9rQ3ROUnFpeFlpLzNKSVd2?=
 =?utf-8?B?RE4wSGVZTG14dVFNNVBYY2hEWWNQUG0wR3BWdHdZN1MrbG9TendXMFk0cTdI?=
 =?utf-8?B?TFh5aEUxcVZSa2hDV0ZFSUIwQ3BYV3Z1QlNXWHhoVWRNVzl0ZDhiWHRUOFh4?=
 =?utf-8?B?VzRucXA0d01lNlk1NFkwQnJaR3E4NTVtNGUycTBDOWdLUXJrVTNHT0E2REFL?=
 =?utf-8?B?djZiWGRuUmgwcVlmYUFWam5Qdk8wYVA4dXg5cG1zcFYvOW9JTmVMRTNNVnpP?=
 =?utf-8?B?dExhZG4ycVFrdWx0QlpYYzFGcmdxZGtESnRTdG1vUjg2QkxyOHVvZXNmREcw?=
 =?utf-8?B?L1BVeXZCRUM1dlRZeUthdUhzKzhIdVhIN3o0c3B0V2VGSG1aZ2dMaVVFaldB?=
 =?utf-8?B?VEZzN3JHczJYU1ZUOVlwMDQxdURsdWtYMkE3QUszbGprSms5WGNUQXk4OFBs?=
 =?utf-8?B?RHFZNGdGNEFGN1ZKenFnOE1LczZWWHlsZlpac0RCeWlRVVVmdll4YkpTcGlw?=
 =?utf-8?B?UHJQSUozbmphUlJiUUJldDRNZ1BtaVRlMk80N2RmT3liSkpkV2xsUEw0NzVH?=
 =?utf-8?B?Y2NBRFR2SlZiZXh1V2NybjNudlYyekVvYnNENXpodEo4TXlvcUFnMHllMFR5?=
 =?utf-8?B?T3hMczc2ZE9ud00zdDBua3A1VnVJcVc3WmVkcmlIUHFuVi95Nlg2Q0hLS0Vw?=
 =?utf-8?B?b2lVSWl5NEpocWV6My8rMExDajhOUVRyMHRKT2VLK3ViWWFqYW5Gd0E3d2Iy?=
 =?utf-8?B?MkZjc09DMWRTNjJJT1RsOFlISGpnVUlkek1iWHh5dDFVVmM1aXlld21Va1hN?=
 =?utf-8?B?VmlyWTdHZ1Y0Q3NVOEt3N3VMVFRrWXhFb3dZVHE5TnlRZjN4eFBNMmhsVEQx?=
 =?utf-8?B?ZE9Pc1dCeDJrRkRjVE5EOTN3NXJIQTBOS0FmSVlkWlJZU09CcTRmVXVkbGdz?=
 =?utf-8?B?TStMak5DSVRXVFNlaHJHY0tjN2IweW96SHBNK2I3aDZQak0xaGVldWxZNUlU?=
 =?utf-8?B?bHcwd3c3V1JhVS9oQVZINnB4U3hNSDBNTzVrWCtHWVlHdE5UNklncS8rRzZM?=
 =?utf-8?B?ZzFBb3Z6VC9FcjRWNWg1VndFOXVtZDUxckJwMVpOc0ZudzJPZnRQYWtERGtj?=
 =?utf-8?B?bDJHZTExNjRJZ3dOZkVBUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdSTXBqbm5VODBaclZEUjN1ZUpHaDlCODlUQjhWVFgvV1IzMkQ0K3lTT1kz?=
 =?utf-8?B?TUczdkM5d3VUSXgyU2EwNnZ5RTlNSEE0RS82cGVzOHZ1T3NzOTF5c1J4OVlz?=
 =?utf-8?B?OUdDdlQyU0c1WGYvZGlSSHFiTENqVVhmWXY4WlFhYWhPalNBeHhBQkF5NlJ0?=
 =?utf-8?B?ZGNuakFXb1d6MnVtVC8wSWZCWFplSzJJNFZ2dW9xWUNrSWJQdm1ybGs2UXgz?=
 =?utf-8?B?OXFNemFRZ0FTYzZ1STUvdXhIMVJJcDBsaWh6b2d4dXBSc3dmclgwb2Y3Nk9w?=
 =?utf-8?B?ME1vRDhxS0ExSGpxQnh3V2FJcFIxZkp1QUVscXUzdDV6a3Y4YU16cloyZmhj?=
 =?utf-8?B?d3MvY1RRWHk5Q01SdzYvd2c4NERVc2ZIcmJPbk1VVnhSWk5RaWZROHNYT0w1?=
 =?utf-8?B?MkV4c0ZsemtQeTJuSjZOUkp1ZE1yS255cG4zT3kxN3ZQaWNqdHQyVlBCL0hI?=
 =?utf-8?B?cEdBVDVCS2R5RXI3OG5NWkVEZGo4RnZIVklRa1dpOW96bXdHMnlQQkhiSFVI?=
 =?utf-8?B?N1o1WXh0MDFRSXNtVngwSjB4eFpYRjdYL3p3ek1GZHhaVkRWTzcrTGxxKzVE?=
 =?utf-8?B?eXpGTzJ2cmVBNjdwdk5JNUVNa290TkIza0NKTEVYaXFTeGV2eUhKek9FS2RR?=
 =?utf-8?B?SnlPWEZ2NXU1dnVUNVgyd3FpNU84YkNHK0poQUJzcDU2MWZXaG5JVjZTMVRW?=
 =?utf-8?B?MGxTRTlZZk9kNzVIM2tHakYreHdtbkM0ZnBzR3FOWWZvYkNlSjlnZTdhOVhy?=
 =?utf-8?B?MlFrVS9XR2ZMUjRlbUtYYnFDYkszYk5mYnAvQmRBeWZKbDdEL3NlMGo1a2tI?=
 =?utf-8?B?WVBVRVdpdDJ1ODdRbXVQQVlhN2dGNzdIM2lNSjJuV3QvTDdQVU1HNGtQTnpT?=
 =?utf-8?B?NXNpSGVqanhPc0U5aitheHl6NFlwbklkaXd2dloyZGhxWWk2NTBOY1Mwb0c4?=
 =?utf-8?B?eFE2QjdFblpXS3hJdWd3SFg3VGdBVktTYnk3WWdHSEpiT05iaVBDYnNYNGtp?=
 =?utf-8?B?YjBJd2oxc25QV1MwYW0rTTJwaEUzOEw4TjVvZyt6My8vcloxK0JiSWxNOFFC?=
 =?utf-8?B?MzdUUE9MVWVHdVBZZTZydHFwSkFkeGU3M1kxWHFjVTlYM0Rydm05V3VJQW4y?=
 =?utf-8?B?OUNHYzQ1NmwwUlVFU3JsaHUrb2gzb2V6QkJ4dmh3eVA4ZjhEdW05QnppOE9z?=
 =?utf-8?B?cHU2ZzB1OXZxLzhhWlZ3NDV5c1pBVXBGbkdKcWVYRzIxMWxUTjhGOUp1RkZ5?=
 =?utf-8?B?aUt6N2VOQWcxZmpZWDNXQ3NNYjh0aVJPTzNzTUFDMWJwVjFQa2hCTGE1QzRw?=
 =?utf-8?B?eTEvdWVNWUo4KzBIZllOL0RJYVEyWHM1SEtRZTlsS0FQSk51VzNUYkQ0aUpl?=
 =?utf-8?B?c0R1VDNza1h1VVNCRUhLNHpOcE1WSkw0Mng2VDJTc2p0WmF1dW96RGg2djBv?=
 =?utf-8?B?aUlad3V3QzNJUTlSWllmOWVrZkNlSit3US83WlQ4SlRBc2NxNFFNdnNLbVZJ?=
 =?utf-8?B?c1ZsMms0TGVHVTMvNUNpMXRCdU5JcFNXMTZzM1ZOSUZNcnN3TkhmQUM1S0hl?=
 =?utf-8?B?MGVQeDFPczFxVlBQaEFUMDhKUThqMkRXWUE5T1dMYW5lc1V2OFgxZFNBemcz?=
 =?utf-8?B?cWJTenA0YTE5SWdDWXVGTklFMVRnaW92bFRZb28yU0ZVaHEwMisxUjhMODEw?=
 =?utf-8?B?b0xBY3VxUmpRUytmMWhsTTlNUmFwT3FKbmhRSlh2ZFM3S0QzWkNLMEJqL0FI?=
 =?utf-8?B?cGFKOWJHMVVIMXU5bkdYcG55a2xVTHBLTWFMcFhodmNQUnhHQ3RmRWlrbTFW?=
 =?utf-8?B?Y2VaTERzVkVvb2F5OXNpQk9aejBLcnc4djlvSzdRelowcmVqN0RvY1o0TlJS?=
 =?utf-8?B?VnhsUU9uYTFrcjQ0OGpMNXI4VVZJYzcxUm1sMVVvNUtPUm51ZkFSOTRNdWYz?=
 =?utf-8?B?TWtpWnlVRkZTWUg5bU52RldMSkhNeDdoWmt4RUFOcWVURDl6ZTdSeUY5K2d6?=
 =?utf-8?B?SndPZFRhbGFId2RpTWR6dW5tSHp0TTMzTU5weUc1UG5FM0s3UloyZUU2Nmdy?=
 =?utf-8?B?aE94SFhPN0tiaGxiT2VxREZJS0pLckp3OTMyMFBnYTVKMm9tWnVYQWNDSk5v?=
 =?utf-8?B?L1NYSDVnc1Fxcy9hMzR3UWtWSXU3bzEvRWc4YlNXYXlYR0JaZzRpeXlPemtI?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f8c3b7-0edc-41e4-c3c0-08dd1b9ad17f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:23:11.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsRh+qMRi8/Qti5BP5iyC3q+QX7l9QtLgpGjkkNyUsH9QcTW3Ug+8xCPdPo9BuruGq32g99YOwghuzcoCq11yVg7UwcMmzI+0flfUQgDnGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com

From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Wed, 11 Dec 2024 09:40:00 -0800

> On Wed, Dec 11, 2024 at 06:26:48PM +0100, Alexander Lobakin wrote:
>> Sometimes, there's a need to modify a lot of static keys or modify the
>> same key multiple times in a loop. In that case, it seems more optimal
>> to lock cpu_read_lock once and then call _cpuslocked() variants.
>> The enable/disable functions are already exported, the refcounted
>> counterparts however are not. Fix that to allow modules to save some
>> cycles.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  kernel/jump_label.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
>> index 93a822d3c468..1034c0348995 100644
>> --- a/kernel/jump_label.c
>> +++ b/kernel/jump_label.c
>> @@ -182,6 +182,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
>>  	}
>>  	return true;
>>  }
>> +EXPORT_SYMBOL_GPL(static_key_slow_inc_cpuslocked);
>>  
>>  bool static_key_slow_inc(struct static_key *key)
>>  {
>> @@ -342,6 +343,7 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
>>  	STATIC_KEY_CHECK_USE(key);
>>  	__static_key_slow_dec_cpuslocked(key);
>>  }
>> +EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);
> 
> Where's the code which uses this?

It's not in this series -- the initial one was too large, so it was split.

Thanks,
Olek

