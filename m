Return-Path: <bpf+bounces-46277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5033D9E724C
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB6B2830F8
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3B1FCF5B;
	Fri,  6 Dec 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUEggeI3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950EA53A7;
	Fri,  6 Dec 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497632; cv=fail; b=SLSLC8KTGothPouoijmgW0Vhn1MAe7otl6LZRpA/2CV7K+jUY96oCnEvrFtJ6XBoC5punLPjoHqYu3KoRqXLkSOFPNOmg9prH1RPf+EP2uRUrBaEbbSsZku8oW89RtFgANmEuFiIm+0MB7SPc1MZ4Vsk8xl4Isex8JP68usQwds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497632; c=relaxed/simple;
	bh=/QAPEApep7/02D99Jq3R5EvKMqORYZETQ/FRTvY5Kig=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bOxfYdQAy0tjCLB6N+ntxympLyHG7TWUJGVeu71vR6dv7cUrdcKKnf7oSei1lD+HRhX0A9bSQB5I5OG49Tmdk1iYcUOHF/6GiER9lvYJBL2Yih3Ml9xWiguLATa9G+TxH++otCsCrZ8UNAZUY+vUhJbZ9Jpbgo967FLPMb0JaJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUEggeI3; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733497630; x=1765033630;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/QAPEApep7/02D99Jq3R5EvKMqORYZETQ/FRTvY5Kig=;
  b=CUEggeI38REezfZ8Oi7GwcKBK1klcFyLiYQcKp/ljTMIv7SJfDevcHOT
   DtxHqDzcDYHa26e9yre1TN+BWpYpL33PkFUM5iYcdctL6Q2ctJ0s3sw1Q
   6NTy9cXOWY0ePQlAUruQicbj1vIHHzKcOdvmC6NwlercWa2dvooigBWq+
   tc7DYYbVaR6JBr7+Ae0hb0aPbNapwDzZW39/V/OOEmV5deeA68QuMx9Mq
   h/iU35WqzkwOr8Bg73MYrxtZmeyD44zq3xqlLTMy+dwA0c2bsMGTwq+Vi
   H5evvPpao68Nnl/DExymBD0ghpDqXC7H1RKUzXyAhhCg3yhkWff0Lz88R
   A==;
X-CSE-ConnectionGUID: +zTLvNavQbqXSTSnyBAsPw==
X-CSE-MsgGUID: J30qr7W2Qc+T0GxJ/bUZpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37529289"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="37529289"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:07:08 -0800
X-CSE-ConnectionGUID: LyDo7EpxT3Gvg0cds7Q77w==
X-CSE-MsgGUID: ZelAO6cDQli2qgWT6VH07Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="99379711"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 07:07:08 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 07:07:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 07:07:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 07:07:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFinI9aWOor9URvCvbJbwOwrAYaUgukf3FzHQscLoOcsWHZu0Lk21e3KyEAJlwJCEe8hEry/i6BCuryJhystXIbzBuyBCaMZRfpoUkbZy3dJlo26rtOSyw4A/hvysfO3bZlv2kJJjYa/fxGlPB72ppPHLp2fvDkqVJmyJDuCw45ejXRz/XQzHSEwSUKtHyljsHQOn9FLS2gxrdVDbNIiu0XFaaH4UOpqK715Di3qpeFU1vkJsV0Rv7FB2dRDqa6AZXJnam5D2VGLS4C/ggwcmzexr8gaXAG4ymxix5oaS0bD/ZPsKykURBbRkRQTiEDsMRFRNl7OQQEGlfqvS+4rXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eReHBG2ce6kSU0mUiSg1QTOJ1XY3xrdl50I+0o71xAs=;
 b=DLevorQjPZj8Yg41D+N5jSEUj+q1cvmjpknxjmNL0mG8ZfiwTTa2GAvvi7/4skrtyMTLFRnzgmqzPgPlPoGyfSFVdW1tUcr9XNhE4a0E5UeJ67KfmxEv5ThLQVDgBiwLxMRzgdPnXVfH27qpTUgqr210cwZHVmM1H7bppkoQp1Ud+ybIs/GvT73c01rdSzqaFKlB7uXp4WO4/fBfvpB7dUj9Lvf2PnNx2soif8PhSrbzZrIOIo9mNkum0qUXiDXVhNiwqjjmP307RDQMzJHUYv1GUpffrqOy4Qv8bCkBnU2ltbZ4FSECvA4NrDG+CTik9z65WUsVYtGXO9By8LOTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB8807.namprd11.prod.outlook.com (2603:10b6:8:255::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 15:07:04 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 15:07:04 +0000
Message-ID: <012d8975-13a4-4056-a6bf-f9140878cbdb@intel.com>
Date: Fri, 6 Dec 2024 16:06:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Daniel Xu <dxu@dxuuu.xyz>
CC: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
 <20241202144739.7314172d@kernel.org>
 <4f49d319-bd12-4e81-9516-afd1f1a1d345@intel.com>
 <20241203165157.19a85915@kernel.org>
 <a0f4d9d8-86da-41f1-848d-32e53c092b34@intel.com>
 <ad43f37e-6e39-4443-9d42-61ebe8f78c54@app.fastmail.com>
 <51c6e099-b915-4597-9f5a-3c51b1a4e2c6@intel.com>
 <27b2c3d4-c866-471c-ab33-e132370751e3@intel.com>
 <yzda66wro5twmzpmjoxvy4si5zvkehlmgtpi6brheek3sj73tj@o7kd6nurr3o6>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <yzda66wro5twmzpmjoxvy4si5zvkehlmgtpi6brheek3sj73tj@o7kd6nurr3o6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2e4a0a-e2dd-4568-c12c-08dd1607a496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFRkWkx2S1hrRVJCSFQyTjRQb3J2eTZVNWkzcmxwM3dpWi8ydmhVRC9JRldQ?=
 =?utf-8?B?QWYvMnNYSzFPTmNmaGN6ZlpvVWN4RDA0OUNiOVJYb1JRdzlvTUJXa3poSEpD?=
 =?utf-8?B?S2JxcHM3MmtTRFVHQnRYbzV0aXZObjkvbVlQb0JhMzM4Q2M3RmpWY1dxN2lJ?=
 =?utf-8?B?akI5NHVCbmdNN0xnRnRQajRKT1lMcURYYWs2c01TYmNEQ0V0UUJLWHMzc0Rx?=
 =?utf-8?B?YjB4T0paN3hISDBrenhnRC84RFExQXh4YnhBRGUyMU5QNVU3OW5KNTNnTjhm?=
 =?utf-8?B?R3B6UnZvTEZhTGRiTldIUlFYS2FXdFBBaFMycXNhdFpXdjZQRDl2WC84ajNr?=
 =?utf-8?B?WUpocGRQYzhyNkxmNnVwOEYwNmRrLzB2NkpzU09keFRSRDdRY3NwV3RraWpN?=
 =?utf-8?B?WXRQOXpJWkFiQlcyVGJZbjFGajliVFQxRlozdU00WkloSnpjRjF5SHNBbG90?=
 =?utf-8?B?WEZhM3R2SnYwVVI1cm41VHV6bytCWW05RnJscVE2OXJaZlkvQU9xZ2pDcnVq?=
 =?utf-8?B?SkpHN3dRVkpWNDJvVE5sK1VNZjYvVFhnNkpSY0V0b2x0K09zRHBHNis1QTRN?=
 =?utf-8?B?OVp2QTFPSzZkYzVZNit0ci9McDVlUnBPMDhJVThPczlQYWhHeEtFY2Fmc09r?=
 =?utf-8?B?d3IyQ052TW5kTE9UbkQxT1FJY2hXc1lia0w5OEVCZG03WGlabzAwQ2Y1WFhV?=
 =?utf-8?B?aFl1T01kbitIWkFnYjUvK296NFNJWnRCZWQrVHlrYzBIZHF2eHZyQmZhNVZa?=
 =?utf-8?B?QkpIbGJ0NzZscVIzTGluOW5Yak1EcnZmcDhXMmtxL0twLzdwdnByRHJKSHBC?=
 =?utf-8?B?WUQyWGsrcUNWRkV0UWE4TnBpakRWWjBBUmY0N2JRRGliazhHZ3BkVUpLR2FL?=
 =?utf-8?B?QlJsaXo5TmFwZ1lSeThFVW5uR3IzMnlpMnA2YzdSUkNkSXM2dUxHM3hRVlU5?=
 =?utf-8?B?SDlSV0pvbHR6SGFGNUNVWFJWeTZONEVyTVJlRFhKTVZSR3VUcGNtYm1WL2Qy?=
 =?utf-8?B?MXVaVDh3cUJJb2RPeENwM2c5SERQajI1LzdwcHRLVUI3OVdtczZKQVpJbFpB?=
 =?utf-8?B?WVNpR2FYYkJrMUtkVXpuWEZ4cjdtUFQyVmp3cUg1bHFSRlBOTHVocmxCVFpa?=
 =?utf-8?B?d3l4eGtCaWpRWnF3ZFZCMVlzQ3F4QjhXSStHMnptV3dwQkhFY05NbDg3VzZS?=
 =?utf-8?B?bjErZWFWSFNUUGpnenlhalFRQ2VSbFpJeS9BZ1QrWEZKS2RjUllYSGxIUUMr?=
 =?utf-8?B?L3dxNDFBN0NoQU9ham5VMG91RGt5bEhqSkFqOHdTVS9ybktkaG0vVTQwNVBZ?=
 =?utf-8?B?R1M4RmFKeUJYYnhtNkVBc3M0N2dtU2x4bnVnMmdCY0JvWjdHT2IwcmNzM2pM?=
 =?utf-8?B?cmFSbGIza1JkUE55aFUvcTd3ZjBlZWo5TmZyR3dVWkN2MGYyMXVIU3ZZL0hV?=
 =?utf-8?B?dU50bE1PQlNaWVNqMDdxelZaVmR5b1EzckxiSHA2T0Z0TVFXRTlBWVpDVmht?=
 =?utf-8?B?YmFqK3RuSHJxMERna2htTGNJOEJPS2RrengyU0FVNUNRSnk4UkRvNFdJem5V?=
 =?utf-8?B?cnlwOU1hcHhCSUUvSE1UT280WmZFdTVtckJUc2dZMnRmaU9pMFRXaFBuc25o?=
 =?utf-8?B?a05ScG1FVy93d0JBYWJLbUwxdlQ5MG8vRkw0YXhzbVJQdkllZC9aY2d3Qm54?=
 =?utf-8?B?RmNTZk5oVUc1enllN2wrdmRvWm5SMGtoM3h5OUg3bVgzVmZrYkJzVVVtQ3JL?=
 =?utf-8?B?eE5OTWUzUkNTMkM0UHRMK1hzTmdDSWthZFAxVWNDbHNkemNtZlVKYkxJMzNk?=
 =?utf-8?B?MEFBT053YVdLRGE5ZnZXdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVNsN0tqcTVVeGZsWWhFclNhZ0N2UjlqRWNZVUJWd2NaNmdjR1hJQlRob0tT?=
 =?utf-8?B?dDNiWVlYYzZndVJYVW4rZzlKZXJPdUNLV1d1bkx3UklHTFJKbjUrajZMU29m?=
 =?utf-8?B?NDVpT2xCdVhYWVVwblphckdERHB6MHdzVTVESm5vZWZWVGI4Q2pUNWNxblVl?=
 =?utf-8?B?WmlBOFAwMWthYUhJUWh4SzFxMFRwOTN4RmFPQlBVOVZ4QlFMU0tKMXJiRWxC?=
 =?utf-8?B?TEw4T3k1dEpXdVVBOHJhcldKWW9kbm9XcmVEWEFzVG5iTDI0UFpKN1h1UmxS?=
 =?utf-8?B?UTVSN0ZqdUc2cVRUNkpWTVFmMW15NzBTUjI4SUdLZHhlOUtYVHRZKzVaK2FW?=
 =?utf-8?B?K3Biams5VUJJZTUyVjM0VTFhVm5iT1dnWHpVYno4bk1CaXdIcVBuNkxDOXJZ?=
 =?utf-8?B?bWp2ZUxmUWNscExPdXFWTGs4YnZLekg4OXNWakFhQWVROXQ4UWQ1dm5raGY0?=
 =?utf-8?B?VEh2Q0MyQWVHNVNlRC85UzVqNWlCWGY5Yzc4TWQrQiswUHg4cDVaT1VKRnlx?=
 =?utf-8?B?Zll3Mk1QQ1JpMGZkTFB1enc3R2VhcmN4dWhMOWM3U2g1L01iVTlMS25DOFdE?=
 =?utf-8?B?YTYrejVFbE1IRHpEd0Z3ZDhnTGtMK1FZWUJxRDU3bzlBcGVzQXB1VmZrcDIx?=
 =?utf-8?B?UGdzTGNyZ3Y0VlR5dWxpTU1udXRZbm4wOXlXZkwzR0F1TEkzbXFwZVJ3ZjJs?=
 =?utf-8?B?ZGlLcVVRTzhUN3lMZ0pBbExrbDhyWmcwQUMvTG1na1phc1dyUExwZ29DZGs5?=
 =?utf-8?B?MHdaRGdKZitWd25lcHZiTjB4dFdCN3kybWJ2UGN4K2gzTEdtTTBYeUZOL2h0?=
 =?utf-8?B?Tmlua1h1QTk4Mys0K0NjSzFBemo3S2lvbE94NTlnZUlTZlR0Q2ZGdVViTVFM?=
 =?utf-8?B?MDVzNTV3a2lDTVUwUHRTZkVrVGZWakZxbzZJbG1GRUlPbFdLbFVhTHZjdGx4?=
 =?utf-8?B?ZmRhSzNyczNPaCtZbThDeXZVd3EvV1U0Zi9QZDBLZXpCakgvc1hiMFA3dVR2?=
 =?utf-8?B?VkR4TDJWRU1nMVo2VTR5c1JYRzM2Y2tiL1BHcjFJRmR1YjZuMDAvd1NuOWMy?=
 =?utf-8?B?UzVsdWg3NG95T0lNV3hkWldtb1BPaFVTSWhCTE83RHJhNzB5ekt4ZmZLZG9j?=
 =?utf-8?B?UHE2U2xXOTZSQTNZU2FKRHdlZXJQRU5qMkZZM0YwY3RKLzhqOGNQbXJEbmxW?=
 =?utf-8?B?aHQ5QXdBMVRESGI1RUsvMDZUc1hxMndKWTRJaFlKaWZVMERXbjcwd0VHb0Vp?=
 =?utf-8?B?OHYxSXBHV3paUGhnTUpBa20zRzlZY1AxYVhKUzd3NDlCTzRZKzhNOXNBWGIv?=
 =?utf-8?B?VnJodkwxZ0orMWExOFlVOXlTL0xkcEhJaERKV081ek1OOXRPdVlkRHVlK0FN?=
 =?utf-8?B?aHlacGl4a3BUVjBMOVBmYXJEbnVuSHlxczljek03OUw5OHZuRWd3bWJGVWtu?=
 =?utf-8?B?QnJJR1ZwWEEzOTc5TlVVdDlQcnZZb0JpTDRyRGN0TElvSEtMRVE4Q1A1OWdn?=
 =?utf-8?B?SzdoZHBCVkFrNmxqODhSMTV6T241ZkZUM3JRS2hmTGZ2bjgxYWF2YklETmJ6?=
 =?utf-8?B?WGZaZW85Z1hiT3hNcnpjbmw1czNBR085WFdqY0dpeU1sdFdWYnY1c2czaG1q?=
 =?utf-8?B?UUhnbTJhOTJYUk1NWEJ1SVNtMENlZDYydkxYTXZTWjAzU3dsWXU5dEx6Qkx6?=
 =?utf-8?B?MGdrQ1ovQ1VRYlFUN1ZYNm42UGV1RDBReGNBUEF1a01rSTBiT1JXZWtGbG9J?=
 =?utf-8?B?YlpHMWpkRy9OdElaa1BvYWZuNjF3YzNha0drOVVLaFlnZld5N09jUlhEUlVC?=
 =?utf-8?B?MHRac21LUE9wWGlnWWRUVTVaU1VXdko2MEpGdGV3VWpwUng1ZGVTTUlFcmhr?=
 =?utf-8?B?U2VzQnBoVTJ0SFJ3QWErS29lcTFmM2t1ZG5yNVdCYTFROHp6a3lNTDVxMFIr?=
 =?utf-8?B?bXljUHc2OTdmQmh3emJ0aWJ4ampkclVqNTAxdlJLNDdHL2dKdVM2cnYvTHNP?=
 =?utf-8?B?bDBjSnFIRkVka2cwZ1ptSXlKaWxIL0dvMXRyQmFzUjRJYzczOUVFOTMyNXI1?=
 =?utf-8?B?TGVwTCtlV1BhU1AvN3dBa0wxb0VvZytPL2ZaSkdxV3dwY254ajVxQm80NXRh?=
 =?utf-8?B?RjRuNXFxRHFOWVFSUktMMXU3TCtsbkswMjJvOHR1SnhBZUJuSXYrUUxHSkQ3?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2e4a0a-e2dd-4568-c12c-08dd1607a496
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 15:07:04.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIBiaVOGN9YTrjbvUqewcCvOmpv3rqUS1BKsAgzJv7dnT340QhuYW45YWVZY29U0B3BJUpqKmNg+i9m5D3LCGQoOHIYa+Zc3mqL6OOlzAqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8807
X-OriginatorOrg: intel.com

From: Daniel Xu <dxu@dxuuu.xyz>
Date: Thu, 5 Dec 2024 17:41:27 -0700

> On Thu, Dec 05, 2024 at 12:06:29PM GMT, Alexander Lobakin wrote:
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Thu, 5 Dec 2024 11:38:11 +0100
>>
>>> From: Daniel Xu <dxu@dxuuu.xyz>
>>> Date: Wed, 04 Dec 2024 13:51:08 -0800
>>>
>>>>
>>>>
>>>> On Wed, Dec 4, 2024, at 8:42 AM, Alexander Lobakin wrote:
>>>>> From: Jakub Kicinski <kuba@kernel.org>
>>>>> Date: Tue, 3 Dec 2024 16:51:57 -0800
>>>>>
>>>>>> On Tue, 3 Dec 2024 12:01:16 +0100 Alexander Lobakin wrote:
>>>>>>>>> @ Jakub,  
>>>>>>>>
>>>>>>>> Context? What doesn't work and why?  
>>>>>>>
>>>>>>> My tests show the same perf as on Lorenzo's series, but I test with UDP
>>>>>>> trafficgen. Daniel tests TCP and the results are much worse than with
>>>>>>> Lorenzo's implementation.
>>>>>>> I suspect this is related to that how NAPI performs flushes / decides
>>>>>>> whether to repoll again or exit vs how kthread does that (even though I
>>>>>>> also try to flush only every 64 frames or when the ring is empty). Or
>>>>>>> maybe to that part of the kthread happens in process context outside any
>>>>>>> softirq, while when using NAPI, the whole loop is inside RX softirq.
>>>>>>>
>>>>>>> Jesper said that he'd like to see cpumap still using own kthread, so
>>>>>>> that its priority can be boosted separately from the backlog. That's why
>>>>>>> we asked you whether it would be fine to have cpumap as threaded NAPI in
>>>>>>> regards to all this :D
>>>>>>
>>>>>> Certainly not without a clear understanding what the problem with 
>>>>>> a kthread is.
>>>>>
>>>>> Yes, sure thing.
>>>>>
>>>>> Bad thing's that I can't reproduce Daniel's problem >_< Previously, I
>>>>> was testing with the UDP trafficgen and got up to 80% improvement over
>>>>> the baseline. Now I tested TCP and got up to 70% improvement, no
>>>>> regressions whatsoever =\
>>>>>
>>>>> I don't know where this regression on Daniel's setup comes from. Is it
>>>>> multi-thread or single-thread test? 
>>>>
>>>> 8 threads with 16 flows over them (-T8 -F16)
>>>>
>>>>> What app do you use: iperf, netperf,
>>>>> neper, Microsoft's app (forgot the name)?
>>>>
>>>> neper, tcp_stream.
>>>
>>> Let me recheck with neper -T8 -F16, I'll post my results soon.
>>
>> kernel     direct T1    direct T8F16    cpumap    cpumap T8F16
>> clean      28           51              13        9               Gbps
>> GRO        28           51              26        18              Gbps
>>
>> 100% gain, no regressions =\
>>
>> My XDP prog is simple (upstream xdp-tools repo with no changes):
>>
>> numactl -N 0 xdp-tools/xdp-bench/xdp-bench redirect-cpu -c 23 -s -p
>> no-touch ens802f0np0
>>
>> IOW it simply redirects everything to CPU 23 (same NUMA node) from any
>> Rx queue without looking into headers or packet.
>> Do you test with more sophisticated XDP prog?
> 
> Great reminder... my prog is a bit more sophisticated. I forgot we were
> doing latency tracking by inserting a timestamp into frame metadata. But
> not clearing it after it was read on remote CPU, which disables GRO. So
> previous test was paying the penalty of fixed GRO overhead without
> getting any packet merges.
> 
> Once I fixed up prog to reset metadata pointer I could see the wins.
> Went from 21621.126 Mbps -> 25546.47 Mbps for a ~18% win in tput. No
> latency changes.
> 
> Sorry about the churn.

No problem, crap happens sometimes :)

Let me send my implementation on Monday-Wednesday. I'll include my UDP
and TCP test results, as well as yours (+18%).

BTW would be great if you could give me a Tested-by tag, as I assume the
tests were fine and it works for you?

Thanks,
Olek

