Return-Path: <bpf+bounces-43890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42A9BB7E6
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 15:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4375F1F233ED
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EAE1BC9EB;
	Mon,  4 Nov 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0oLp2kL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE857178CDE;
	Mon,  4 Nov 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730878; cv=fail; b=gScRsmZ+aaI9tNQJLukD8vyBHMN50j/mhxam4loCKkj2Uz8qnOjDG5EIHjlZ3YqSlIBvdZ9CEtkyGih8Az4kgllLVNtfimzXDa/yNcweFlr2cEtwr3ih8+Zfybx3QfnqbWFe0alv5VVbFpDT5ulU6nUYQFl0oIflZKGoWlWCE54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730878; c=relaxed/simple;
	bh=c0//5GC+LJCIB3eM9x+zZHOQj2k1YzncqNf7fq8Ie1w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FpQTNRzYyoaV7RO5E4g/utd1aHCSWHY1ZVGp55lgv58EFHixB2zkChn7Mw0zxWYiRigl3NaucMv8KRyZ4cGZx0KPrRlRpiqXGEAsKwDXYdwsg0QQRPszUPOxAwHkisOUpomF65GkMVS4v9fsr0JN6yF0u6+ckJcrFub8/l6R/Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0oLp2kL; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730730876; x=1762266876;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c0//5GC+LJCIB3eM9x+zZHOQj2k1YzncqNf7fq8Ie1w=;
  b=X0oLp2kLHOvdI0DU2NjKGW2fZSgDnGigU8jhibR9ffXiBTytu/YldmQL
   txzRLJRhrDYg9ssGS8+crJOzgBokiry+2UNH9IK02Ln6TzT403nzAgnQS
   fifCjKuFKSKHmE/r90sFnOhELDk20ln0Li8Ok4/ydz6UaohkKRk7ZicGV
   mf3FmFJQb7Ia70p6BvIRG9OOuoi+pbVBHFG9SP+guV6pGVdKgV8MH0ihl
   4LK4TxRZFzxkVYKqb3b/b/Hf0xjR8PtuPoj65SQc86Le+kqGdQGzrUM+R
   7jDFzxR96FiJdzDsr2rEXghyHgylTPTb9iRNGF2he9JiHrKj0xBMvRUGS
   w==;
X-CSE-ConnectionGUID: fVjcthQnRHC4bapqelNpGw==
X-CSE-MsgGUID: ksQbhn+NQ+CMNLmEkV1a2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30313101"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="30313101"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 06:34:35 -0800
X-CSE-ConnectionGUID: iNR5l2tqSiKh+LE/IgbFbQ==
X-CSE-MsgGUID: gv3b108SQ/mhYksXXouDCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84497105"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 06:34:36 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 06:34:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 06:34:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 06:34:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOVp5RvfjKIYtFX8EtXDkS8wLvkK1EWvENrw6QhOj4DLUX5uguNq88RlbIvgiQwEr/wnnC1NxSLb/jVTIXR+JnkjoQR9Bz0ZDxm3u/W45DAE9bDiNTDUC2LTZ5tcheKboLVBqBpbXmCGS0N/6o//r6f577gJvvjuEoZZqbAgdJYUsCG9gQufpNMK0BusNOEU22mPS/biMkIxTvu63IL9Y/XtTHFrlMlaDZeJqIhenW4nrmFTZJm24MZKIAsbNxGX+en9mnXq5PP7U5oWiQBS1sfV+riqVI4iW6YGESJik6zydalNJhHwCr4jSSE04RfgeadFgj7WD4MQJ43frncf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0d3NAKygFfmD5WacbbxfMpEv7VwI/012JLM43t9WJc=;
 b=yfx7+tMxExI/2JC39nXENkIhDtQgqlWT8rPkvMZsYI3JAUY7+G1WoyZk1zxUZ1ml8F+FO98NYSPP0nw1zkfliFC2DhCTAj/3002hONVUHONDSCMuIKANB6p47mr32qum8s3wRsUj/SLWPeFbpTE/bSn3UZUtM9wzpRZArmF/yjA87Ax7ffFUkGSpLYdckV1+WyFeC/EO19cthlGulQMp7AGZu7l3LHqhV8/ST1ftp2I+2bH/W8tedX2tNiezgkvNP74gTFfz3g+Yqe8XSmWrRykEurQ48isk99YKK1rRBruYuPIaJhdTTr+ZnFKVafRb7HqBbjUQU7Koo2t+cGFvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7820.namprd11.prod.outlook.com (2603:10b6:610:120::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 14:34:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 14:34:31 +0000
Message-ID: <1c32ebcd-ae94-42fb-9b18-726da532161f@intel.com>
Date: Mon, 4 Nov 2024 15:32:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 09/18] page_pool: allow mixing PPs within one
 bulk
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-10-aleksander.lobakin@intel.com>
 <87ldy39k2g.fsf@toke.dk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <87ldy39k2g.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 165f8f19-a6ce-4fa4-8789-08dcfcddcb37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG9WWFhWMzN6V0hPUnRSdGxManhOamtQaFNhSVVoQ3pocWV2R0F5QkUrLzRr?=
 =?utf-8?B?UitPS1AwaDUvYlI0Njhjd0J5RW9MMStwTGJGOTVIbFJrUWF6V3BTcklTSHlr?=
 =?utf-8?B?am4yYVVoSDdBUTJ2S0JvUkVnMXduNHJwODhrNERLTzhHZUVhMFZqWHpkN05t?=
 =?utf-8?B?MHJDZDFLN3hybXBiNW5BZ0xab0NrQUJNTUg4azZFbXlYQkVjSk5ROC9xcHRI?=
 =?utf-8?B?R2xHQy9LQUFJS2Q4OWxGRDlwdVdkTVFQNUVuQUlPYTBUSzVGS3c3SUlPYXhS?=
 =?utf-8?B?VUxBTCtPeEZsSUdyUko5TGJ6L3dBQ1hHaGdVdXB4V2x0RVZtdVpXaWRmcVBP?=
 =?utf-8?B?YjhDTE54ZW9ZckpuM0I2ODJMTmJOTXFzdEEvNk5wR0Q1OU90TUhXNUZxNmxV?=
 =?utf-8?B?VHloY0JTSXVZSFhWNm5nSE9za1NxQ0pSaTVPblJuYVdHR21tSVBSYTZvUzRQ?=
 =?utf-8?B?NUNGd3RhNFU0WGhWNlNITzhIcStabk90NEsxWjc3YUZpcXVrM2M3MjNIaW02?=
 =?utf-8?B?N2xvWDJjOXp4NFVXVEJzL28rYnVDRkVySkMxZC9YUkFaQVprUTVibVNaQmRE?=
 =?utf-8?B?ZFlJWWZCZzJTVTRXMnEzNVpvb2o3U3NzOGlWM0dIZkFETzFHdEtLdDVQMlNp?=
 =?utf-8?B?ekhVekFKc3NTYTZWUEJ4T1M3UkFlRFRTdHNaMFJjejMya3htM2VoamJrZU9O?=
 =?utf-8?B?SENVa3dCdnVaRHRETkxqWUZZQVpJOHFJdHlqWE11YTF3clhnZ1hGa09aSVRF?=
 =?utf-8?B?Wm5yblArQzNOc3dIYndFeGFYM0RodjRUUDUwQ0YrVFlDeDMxNlJZNVNBUWEy?=
 =?utf-8?B?K3pTbFNwTU9aUVR1UUk4NWpneTc2Qm45Z0w5bDRVd21FQlk4NnM3emFZR3dB?=
 =?utf-8?B?a1JjSk1EOEo0b3NQMTVJLzJGRlBRdlhGSUp4NHd0WTBNOCtJWDBRZWw1aEt2?=
 =?utf-8?B?a0RzRk11dWF5Rk14VFNwMWhqd2ZiNUVtZXF0MkdDUXY5SW9GWEZTNmUzWkRn?=
 =?utf-8?B?cHJidExqc05OUjM2UVU5eU5WczNhb1NraTF4enhQVXNEMFBXZ3JYU0FFVkM0?=
 =?utf-8?B?elJiMVZWbDdFa1hoU2F6aWFJa043NEpSNmpid1kyczc1TGJJdjVaWndKTW9H?=
 =?utf-8?B?ZENEQVlhUk1uNEFpUDJmUENXK3VTcXpPNTN0TVBNQVRoTzYybEpHd0gzUFQ2?=
 =?utf-8?B?SWNaMTJESjVrMHgwYmF2ZjBsdXdXREJXT3ZlSkpPOW1QL2oyUTB0cks5cmJN?=
 =?utf-8?B?blJoRlJvN2Q1RUZpK3BHUU85ME9rdmZPb2dnTU90Y3NLanBEZW9abzl2QVZD?=
 =?utf-8?B?NDlOTWtPeWlEUGNEUnFMMjBmOEpvWkcwbmdMbzA5V1NnY09pZndYQ01tTTFR?=
 =?utf-8?B?YWVjZVd6VS9naUprVkUrZ1NBYWsxZ1RDYXkrWi8rUzFjVUp0QWpST3hYMzh5?=
 =?utf-8?B?QXpUNE9GdTJQSlZhMStIRUUvSUU1S2MwWFVPQmF0Q0hZL1I1aEZqbGg5ajhv?=
 =?utf-8?B?MkwyakovdC9YM241T3dNN2I3RXVtUFl3UXVDM2VZNmZmQmlvS0NxL2FEVWFn?=
 =?utf-8?B?R3pxTFNBSEhwQ3MyMEVGOXZiUktmZDFWTkZHZ0JLdVlZaW9Oc01CbjMxb28v?=
 =?utf-8?B?eEprZlBhWWdKM3RqNHRMYXgrNUdnb0doekIycFFXcnJXeVc5VXB3VzJRSXh5?=
 =?utf-8?B?NHZzcEIvOW5SUURyRmxVdzgxaGZBdlZtbmRjY2VyaVRHNWFKdUhheXQ3cFln?=
 =?utf-8?Q?rnpKSDa7pbsJxcXKl8sx1/zVvwhHGUDsm2AxTae?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUprWHVqMkNSbWthWW9QSFMzNzJvT3A0cXFkK1JGRkFIL1BCczFqT2xUVWVY?=
 =?utf-8?B?eWtJSkI3VVZWY2d6MW90SDI4c0VTU3BOblY2UjRUTjhyV0laZ3E2ck8yTnRH?=
 =?utf-8?B?bFFJUko4R0lpL25LWHNYK1IweVYxTmpZTnltbGYwRXFwUWw2MXNUanY5SVlI?=
 =?utf-8?B?T1VpK0hyS0pIL2VJL0Erc0pUQ01ycUVYcFl5MXA5SUZmWnZnQnl5Y0d0d2RK?=
 =?utf-8?B?ZE5GcThxZEFUcE1saDlFWWp6TmdKREtIcTgxSkV5blJSbXJEdGVKM2JCcUJr?=
 =?utf-8?B?OUNrWURTQU4zWFZGcHZzWDArSkxuZDRHU3Z3UVd6aHN6RW9PcmVCdTRscGpS?=
 =?utf-8?B?a3R6eEFHZlYrUHpFVDVUMVl2V0N3SjRsRzhoOFIrd3dhZjFBMHNYc2RJV1hi?=
 =?utf-8?B?YU9SSXZoSmx2NytwSjFtREIvY1hwNE5YTEdoemUxQW51N3RsbDFqSFpma0ND?=
 =?utf-8?B?bWt0NlRQbVRhK1VlY3NSMWk5cENiVTZsbEJ3RUNXNDZHNkhVcmp0eGlUamo4?=
 =?utf-8?B?YU04dVJyWXd5cHVrampwR3Y1b1pmNm9EWnU1eEJ5V0tjbWF2VmNBWkdONm12?=
 =?utf-8?B?R3BLL1YxVG1HWXBPUFpiTkgwOFNBV3hYbjFNekVFQmNsWDRORjNBVzgwTWdR?=
 =?utf-8?B?RGI3NnNMZkptY0lqNUpOTHBqZjZWNDFGMk5BMXJJK01VRElMSkVEa0syZ1Qx?=
 =?utf-8?B?ckNyQVVOR2xLVGJqeHg1V2NpV0RCMnB2a2d1UVQ3SURHWXFKV3dpZ2RRSTlY?=
 =?utf-8?B?Z2k3SCt6aWlFVG9nZW5xTVFSUUlvb2poVGd6STFxbmxNOWhRR3hJb2VFYW1E?=
 =?utf-8?B?YjRiSEJqOFBkK3VpYldjMlhPb2JlS0FIdlNxK0RHdXdQSDgybiticFZkRUVa?=
 =?utf-8?B?S2pYTjlJNUNoMUJ3MG9CZ0ZVL1VONDFRVEZOa2I5ZnU4RFVOL2k3N0FMNXlO?=
 =?utf-8?B?OGpJRkZhWkV1TzN5WFVXdzJVOS9OancxV00rZ0h3SjVKMHpMQWpKd3RGU0Jp?=
 =?utf-8?B?d3poTkNMRzNIMmpxcFlTOWZYUVZMZmhWSlExVm5tVGovN29FVDNuTUk3N3Zm?=
 =?utf-8?B?WWZJaUl4TnlwWEtQNkVjTEx0eE9yN252Zy9XS0dCM2R2ekthdGtZeEtKbzFa?=
 =?utf-8?B?S0o3dTc0Mnc3KzdDOGQvdVkyelowTTcvcytEeSs5eE4wcjMxWUFjc0tJYUNR?=
 =?utf-8?B?aE1uYS9lVEpOUjRmWEF5RGsrSC93d2Z2bHEwakV4MDlKSlNDUTdDS055MGc5?=
 =?utf-8?B?NXE4M0xBT1dSd3JWNDIwQ1NNR0ZDS0s2ai9qR2lXVXJQSTZ6M0JTTkkrTDNm?=
 =?utf-8?B?ZE9iQzl3MHVVc0pTeU8wSjBlWFhiSUhtb3B0RjlUTWpIVURtQVpTTk85Unk0?=
 =?utf-8?B?TTRiNWxVNW9pVWRiazQxWXRVVWZtM2M4c1hWV25BUEtPM0EwTjIrMkd5ODFz?=
 =?utf-8?B?TzJGQ3JoU2VxN2dnTUpSa1hHdmlJb0c4dnRaRUpUbVphRUxZMHh2UU1hYXV2?=
 =?utf-8?B?c2YvbHR1cEJBL1d4T2QyWWlDa21Mdkc5Z21uaFdNNFdYQlJwQzRBUExYNUJx?=
 =?utf-8?B?N1llaytrUHgybkVSQ09hc1c4K3FJQU5jUzRraWFKcnlNMEpndTYrZDQvVldP?=
 =?utf-8?B?TzlTSERpTFl0a1hqbUsxOXdPdzZXWGpKY29KR2tUMTdwNnlUS3hXUG1LUXVU?=
 =?utf-8?B?cENkUTVwUzdrVWgyeVVjTUpJL2xwZGYwUlJoRlBGWGhxNjFhRUVSTlhqNUlK?=
 =?utf-8?B?RzcrMC9Eb2d3TEdBV1FPMXlVOWpzUnJRdkxGYjZVY0dHVDJncFVoWktYQ2hI?=
 =?utf-8?B?ZHpaNzVSWk8zTFRlbzJ2UUpFcFNtR2VGK1drbUppcFo3bzhsa1BUdFVGQjdR?=
 =?utf-8?B?WFVKMFl2OGdjSmZtd2paTnBmRFNmTWphbUlUU0IrRmR3K2xlQjdScVBXaEFj?=
 =?utf-8?B?QU1OTENzdUVWbU9YcTdFUUs4M01rVE1lMUg4ei9DNUlDR2pXS0kvWlQ1dDlH?=
 =?utf-8?B?UW5RTFdHSW4yTVUwWHBPVzB6NUJZSzgzL2VSQVBaRmdvekJ5ZnNyckdJbm0r?=
 =?utf-8?B?WmxFeFJzTHhkY1pPdXNFVWQ3NHk5bkRxU0trbVF1cTZjT2YxUjBvTVNScCt5?=
 =?utf-8?B?bm4vUzNpMEwwM1l5SmJpVjE4aC9yTnRRcnp0MG01Q0lKQmIyZTRzOE1MVDZJ?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 165f8f19-a6ce-4fa4-8789-08dcfcddcb37
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 14:34:31.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67nb2vHLWY0+ZpfpiURMACY/NjoMnV0W46mED2+E5bOsT2FfS/zNtriOGH9TncRT6mMqBntWjJ73ZEWtvaHPdN+PAWCR8KtA37dNFQRRbLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7820
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Fri, 01 Nov 2024 14:09:59 +0100

> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> The main reason for this change was to allow mixing pages from different
>> &page_pools within one &xdp_buff/&xdp_frame. Why not?
>> Adjust xdp_return_frame_bulk() and page_pool_put_page_bulk(), so that
>> they won't be tied to a particular pool. Let the latter create a
>> separate bulk of pages which's PP is different and flush it recursively.
>> This greatly optimizes xdp_return_frame_bulk(): no more hashtable
>> lookups. Also make xdp_flush_frame_bulk() inline, as it's just one if +
>> function call + one u32 read, not worth extending the call ladder.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Neat idea, but one comment, see below:

[...]

>> +	if (sub.count)
>> +		page_pool_put_page_bulk(sub.q, sub.count, true);
>> +
> 
> In the worst case here, this function can recursively call itself
> XDP_BULK_QUEUE_SIZE (=16) times. Which will blow ~2.5k of stack size,
> and lots of function call overhead. I'm not saying this level of
> recursion is likely to happen today, but who knows about future uses? So
> why not make it iterative instead of recursive (same basic idea, but
> some kind of 'goto begin', or loop, instead of the recursive call)?

Oh, great idea!
I was also unsure about the recursion here. Initially, I wanted header
split frames, which usually have linear/header part from one PP and
frag/payload part from second PP, to be efficiently recycled in bulks.
Currently, it's not possible, as a bulk will look like [1, 2, 1, 2, ...]
IOW will be flush every frame.
But I realize the recursion is not really optimal here, just the first
that came to my mind. I'll give you Suggested-by here (or
Co-developed-by?), really liked your approach :>

Thanks,
Olek

