Return-Path: <bpf+bounces-28657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239A8BCAEE
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 11:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C951C21F23
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793DA14262C;
	Mon,  6 May 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtAUB6vt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640681422AC;
	Mon,  6 May 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988437; cv=fail; b=A7PzNaPBeBd0c+Hez5RGueSDyV2W02kNP8wGfSSQRxLI5lPLSp6e2rzVMWzbhJLO25ZJbCIWH6/fvelxAUdLUIofEV5Yul6mGShTP2l5yF9IQaUG5oGECU7d9LetJog/l9pkwvMwf5azqBfpVXN2rnnwEudTT1ii40ZZKdZ2ZRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988437; c=relaxed/simple;
	bh=eGh8p9cF4642mzc7GrTjfEFwSNc02cqcfVnv3jipOGc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6RLO7KZio62zW9Y1aThRy1kuabolBE17l+q3FX/FaAdF/1cUJ0cV8MBdoD60BanKdFV79u4nersfZ1mkvunXJWJ/BPZizAlXU5YFiFUfos2ft/aFwfbD2dcLVPihsNmG57vUPIiFsNuvQjeWCcdgUOYcgonSnE89muQYpo2pNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtAUB6vt; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714988435; x=1746524435;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eGh8p9cF4642mzc7GrTjfEFwSNc02cqcfVnv3jipOGc=;
  b=PtAUB6vtYQD3ZHQ6L7I2xFE5nzf172Ql9z8Mek3N1gAfdj8Nfh7PLuqo
   kb4/0+uR++4y9yPrz9Q7xnD5ukjvqTr/GfmDidezwR+sq9dDWaQpZxjDl
   mcw8AhbKc7Ua5eh0pmsBm4/9sWo1TFUnaqaPgfcPrBXVI6hy0VtqOJE3A
   yGeAgYS8C2+Yot1MwO41vFi7SJJi4Gpw3QYes13JRpTIoxUP4GL+927aa
   AmQ1RiMoFg+L5DkSfGXhXzD0yK5btPlYRsjGHCpXmRK7ISNBw2WGqLKBp
   joCA9f5s85GWIHW1Lwz6rmri7OAYN0Xq9gc6TghWSOuVW8RKCiWVhhABh
   w==;
X-CSE-ConnectionGUID: f7MOFbZ0SZ+Yxgc02SnXYA==
X-CSE-MsgGUID: mz6g2eJqRnKf+7nCfcuNnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10576127"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10576127"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:40:34 -0700
X-CSE-ConnectionGUID: 05IT7u/vTYacdcChuYZbuQ==
X-CSE-MsgGUID: Tgjy7KbdTciWUpj2yQei1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32712324"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 02:40:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 02:40:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 02:40:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 02:40:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6jFqA0f8qGfeNfWfOo3fLBL5JZuDsKIFif1kWjDTXH/Eyd/j5NbQiH0Mv+6d6wJoGkWHbS/eJjeCO6zz05UzJg6iU5wIHMwe/Qn8xswY9OnVhg9xDzkLnwafvg8s/waya+AfAmAsFMo1JFRo5F6dMXAlNsPzfappKe1/ecg2oUB6K0YH3bojuYCmJvmcQhUWh/sDbaTLT9Wped6PSuwxBiD5ES/DifcRiguLzqJ7OnIorEKtH7lJsffkQZWnkSOikeuydTLq7FUOX126qe7sqPsgELaJd4OCp9tmtiq3T+MFDG2lDsAVNTlVLUb2UdndL+RpnMLwvsW2U16tka3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q81w5Od9YEVy2VYFPWC5N2h8hd6Im8Vlsgi/Or7062U=;
 b=QsHWchjgoQZgBpjKd+Co2dC3HMOqBwnQ/llZ4/qCZxQB1f1m65yA53ao112I+Prd4fFb7J2OHTpki9sUUn43DP4BklDomSenw8gN7AZdmCsjHDBPRBMEfOHE49fyLmV3NJd7aXUvgHStCLlZXDtTWloa/T+fmZTt47qnZbjFmKwMCYE4tzp2mo/dvkEQ7z56NBxlGKa4Fc/B2JXQGjBc7uuaHQgDQDPggbKzXKJCKI3O79kNahVAy8WCmu2oWSbO0yuI8fFmHZW+RqnNEDVpNigBwHDkmX6+Y82MZvzufLOhzH8hrGJBrJ0I2KlkGOxeBQ4NKFUuPkPeFQNIBpOt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 09:40:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 09:40:24 +0000
Message-ID: <84711866-7607-4513-bfb3-ff5aa155dc5a@intel.com>
Date: Mon, 6 May 2024 11:40:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/7] page_pool: check for DMA sync shortcut
 earlier
To: Robin Murphy <robin.murphy@arm.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
 <20240423135832.2271696-7-aleksander.lobakin@intel.com>
 <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com>
 <ac0a09f2-5f05-4317-a1cf-b7135791c639@arm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ac0a09f2-5f05-4317-a1cf-b7135791c639@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: bad6f75c-9f9e-4b78-91f8-08dc6db08e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TloyMHg2MS9zeFAxL3dDeGR1Y215bjl6ZGppcGdaMzZNVXltcG9qL1Bqc2d3?=
 =?utf-8?B?cHhEN01NYTJnbGFLd1IyOTA5cjJ0TEhjdEdBNDdwd09BbmxJSlhST2Q5TVJJ?=
 =?utf-8?B?bUgyc1VpZmNsMHhOU2Z3ZTdlc3pSUmZaWE81SVpHc3EyNi9DbmFxa0RNWUI5?=
 =?utf-8?B?NTMwbXRmakl5bTVvakZVR1FWdFlaVW1ma1JOVWVBTXRJZTZJZ2R4ZkdwTHVR?=
 =?utf-8?B?cHBrNlBNSnF6bXVHOHc4bVVBYk1mdUhrSXNmaGl0NUFMQnJFbm5xemgxVEtx?=
 =?utf-8?B?TGI5QW5nd0t4OExtT3JRVEFFK3hHeXcvdnNyT01IVWZJNjRhRUVwbUM2UUo2?=
 =?utf-8?B?UFVUNnhDVDNFeDlYL2djUmdSSEhqTEN5Y1Ivc0M0MktCcUdPMEI3WkFuek5P?=
 =?utf-8?B?RjlPZXk3U2ZlcEhTVUUrSVBJa0Z1Q1lBa2VRNlczTVBUNXlFMEdGUDhZVnB0?=
 =?utf-8?B?NXNZanZlYW8zd2N3amRqT2RtUDVTZytFOWh5R3hIYXQvOWkxbTA5WDFJL1U1?=
 =?utf-8?B?dHlPWDFkOVIvUnVRUTBpTElsVWI1UTk3WjNPQ2Z1cUgyVFROM0tlZ3ljeGto?=
 =?utf-8?B?dER4MmdqdzZQVUN2V2dCelpRLzdHSnQxbzR4dzdrOWt5cWRLUlJ6Vzdmc055?=
 =?utf-8?B?bGlqYXR5bTJ3T2RYakhnTnRNL290RkgrbHRwWWhNQUd4UzBHbTZQUU16dERZ?=
 =?utf-8?B?ZEJPa1NqNVJBUzIyeUVVWUtWbWc5Ni8ySGpVUmIwQVoxM1NuU2pqL1Jnd0d1?=
 =?utf-8?B?S01MN0VaRENXbG8wNlhDNHFFYlpaQUlNOWYyaWpJTGN1R3p5Q0hkd1B2dmU1?=
 =?utf-8?B?Qk5pcUFraGRZRzJiaHF1eVBiVnVrb0VzT3pPQ3prMG5LbFpFOVpxY3psVE1m?=
 =?utf-8?B?SklzaVppTVpQbVRxVFRTSm85NXlJWjVNckpoeGVSdHRabXdFRzhSaEIrQmd5?=
 =?utf-8?B?RVlMZS85OVVkeTRDVlNVU01DV0NxUVBPUmRiR01kZ29KT0wvU0F1SkpzdUtN?=
 =?utf-8?B?d1R6UGZtem1iMGNsOURyZzRzd0ZKTkJkYkgrdTYyTEJiQ3JkdzB6RlVYcUQ1?=
 =?utf-8?B?QWJHaFJ4ZEtLZStHVDJRQWFiT2dueVViSDNoZGV0U2QyeW9va2gvZFlyUXN2?=
 =?utf-8?B?VVF1U2JyVzJYalFKS2ZmRmZJNW1TYUJCM1kvV0Y1SFZCay9IeWMxZjh4RHVo?=
 =?utf-8?B?bXZFNGlsaFNzRENNRGVlR09CNnJuS2hBOGRkdndGLzU4aTQyVll5TTU1SDlz?=
 =?utf-8?B?MkVTd253b2FPbTF5dkdQUnNIMi9zMTlwdUVJN2N1bE9RVDd3Wm9sYTN0NElV?=
 =?utf-8?B?MVdDUEowa215ZERESjlwYTNPUEI2Rk5mMVFSUnU5aHpxQXNFaUIzTDBZcm9x?=
 =?utf-8?B?RmdJUGpLVjBSMVkrcElYcGdDQzk2NWRYODlDdnNzbElJeFZrTllQWDRiczdw?=
 =?utf-8?B?eUJOd1ladzZ2WjVnbWVGOTloaVNKZ2hsazZyTDBITGgxaW92cEFLbngvSXJL?=
 =?utf-8?B?bkxhb0NVYXQySHppVURTWkp1bXcxUmhTcFl0d1VHeGxXM2J5T3E0ZTVYMTdx?=
 =?utf-8?B?aGFwejFsT0ZNakF2NlpwSTN6SUJ3aXZYQ2ZISUZXM1hoVXljaVFmd1ludG1X?=
 =?utf-8?B?cXRsY0hML3JJNzBmOXNNemFzY09pTXp5WHYwODdoY3NtL0U5N3dOY0xKNW1C?=
 =?utf-8?B?V2l3NVUwQnhlVm1XRTVFd0xORkhCZzVFYXNIL2VISXNuektsemNKOHZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTY1bVhwMTBDWGpOVVZOaVFubVJPVCt3M21JOXdTNEtWMmhKTTRKVm1xdjVl?=
 =?utf-8?B?VWxsckJBRWVlajF0QmUyT0dyNTA2ajJuWUcrTEd6OUw4bnFEaDNqeXpRYVlx?=
 =?utf-8?B?VXh5Y3JMM0NhQURBNFA2Y1lpTjFkWlc5U0w2WG96eVpLcnl1a3ROZTVLVU8x?=
 =?utf-8?B?TVAwMkMxeFN6SDFYdEdhcGRCalFxYUVRZGl0R2cxakRaaXhjOGhINFhOMnND?=
 =?utf-8?B?bXJSNHNUTWR3eHhCMWE2a05QaFFsYmtYTDB0bzkyT1JDLzIxcVBFNHBGcDZP?=
 =?utf-8?B?MEpzbFhSRVpMaEZrWUk1eHhWOFZ3bkVZaEU5NjNTNHl6MjFLc3Z3OW9PSFd4?=
 =?utf-8?B?Y0RUQVhFSzVGak9NNlFDY0FVODZ1YXE3dmJHTFpKWEdtb1hnMk9uRG5ZWEJW?=
 =?utf-8?B?ek1Oa0ZJTnZyOWJ0QUNqUGROVXhFd3VPRG42NjJIeGJ3NDdObEt4UGRVTUJv?=
 =?utf-8?B?T0hXblRXWk5sMnNkbTBHVVNPc1UvbUo4NjJjOGpEeWVzNEFyazRqWHprUkln?=
 =?utf-8?B?Vjc5NWJFd3creFJ4V09tTmFQQUhrVHhyUk1sWHE0dkFqaExCcjdSenFzT1M1?=
 =?utf-8?B?b2RiNy9JQnFLWlYvS2NMTE9xUVBxWW5IZDRYTm1RRlE5OGVQTDg0QkgvU29I?=
 =?utf-8?B?WGdpdVpGL1M3R1RtT0tBRkY2c1FialA4VzgycXVMUWcxNnVOMEx3QTVMdHBa?=
 =?utf-8?B?a1pscXlMZGRnUE9kdFJwRXFYQ3Qvam8rN3lkTDJYTEsvR2dDeVFzcDk5a1Q2?=
 =?utf-8?B?WC9lQmlJMEkzSE5NWmNKL2JidFQvdWc0QVVwZUQwN3NUTWhKRUxhQmVwY2pl?=
 =?utf-8?B?b1dRNXN1d0xJNkdrZExiTC84YWY0RXZVeS9Hb0xpc2JNZlNTcUFOVjh1ZnA3?=
 =?utf-8?B?dTBzaGRtbzdSNy8wazFTZllpSGZmZXFkalQxaVBDMmI4NTlzWWpkU3JFT0JT?=
 =?utf-8?B?eDZoS1k1Zmp1WmRnOEZMRU9XMEp0MUU4d0tYWE5SS2h3azMyNkVqcDJ1RDkv?=
 =?utf-8?B?KzFlYlRTTytCakFQSlNQbGsvbDJZVTRMQ2NkUVVncVo2cE1ISnlKM212Nisv?=
 =?utf-8?B?R1pGWS9GSHJmUUtkQzdQYkNiYmN6d00yYk1Vc0MwcmtZaXNidDFYYnIzTHFr?=
 =?utf-8?B?bHMrTkN1L001SkRndjNScFdYN05wZXFVazlZTXNFN0p6MnJNYVJNdmJrdmRa?=
 =?utf-8?B?VExsUVNvZnR0MXVmcno1Ykh4b0tiMldPT0ZBZW8wb0kvVTh4Ry9LREhPeENI?=
 =?utf-8?B?YWdVeWdUK1VHVFNydXh5VW5SdlJKUm5RTFh2NE9VTTdMNEF2c1h3ZkNxNktv?=
 =?utf-8?B?RnpqWFhoYkU4aVk2MEJONHNWZ01NZE05T1pRM1I0MTFPMUxIVVJ4Y0lMdWNS?=
 =?utf-8?B?UFFnZDRqby94Umw5R2RkeUhlNUgvb3JBUDdCR0ZVc3VWTUt5RmFHem5FRTNB?=
 =?utf-8?B?OWtTM3ZURWI1RmhhOTBiNUU3Y1A2Ky9SWjU5WTB5d204UGF3MnZETUgrZjBF?=
 =?utf-8?B?TUt2dFF2RnE5OEpKWXhmZk1ONitqM3FXMkxGN0hPV3pJSEVhN25telo4YVZP?=
 =?utf-8?B?dnY0a0VjeDN3YW90YkxrZVZMZVovN0dDZXhNdVZlcUcxMnlWNXZMaDhMSkZ5?=
 =?utf-8?B?cWE5b0dZaHF5VkFyRzhSYU5MWjlTTVM1bkxaTWd6WWJwdmxod2VkWjJZNTJw?=
 =?utf-8?B?Qmx5MVFPZ3lxMFprOU92cXQva24vdWxVMkQvTTFHWlZmZnF2cXFMY2E5UEtS?=
 =?utf-8?B?U0lMOEVoT013MTVlOVkrQkR4OGM0N0NQSHRTM2orNHpKZFBCMndDTy9xRGVT?=
 =?utf-8?B?dzJ6LzMxbFFaRjU1ZmliMlMzemJiL1FBOUFwZ241NU1wSUdRUG5RN1lBSlZm?=
 =?utf-8?B?UXBoWmMrZmtFTXhMSElneCsxYlJHMnVsZUIzaVU1a3krS0tlaWQ1THYzVlE0?=
 =?utf-8?B?UlJuM0tPRzJRbGVSOWU4UkV6QXZiN0YwMENJUGRCQlI4M3ZlNzRJeEkrbEhw?=
 =?utf-8?B?Q3lnQStSc0ltcUo1b0VnVWpIZFlpbmVCOUcyVE44NmJtMVlJY0tvZExvMjlJ?=
 =?utf-8?B?NFBReWlGZGRsQURtY1Fpc0YwZjBEOGkwZmpkbkJjY3pHNFJrTmU2d2g1eWVj?=
 =?utf-8?B?OUNPU1UvRVdMZVdOV1NSWklWYkJ1bk5YdnhDZG1vdlFNK1oxakF3a2IvVU5H?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bad6f75c-9f9e-4b78-91f8-08dc6db08e2a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 09:40:24.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pZu2qiLB4BcXLgSxw4kCKc5+Ga08ZPiA+KH8IYPojME9sk2DzcP7P8UjJTR4IjvNM9GmsACzPy/bJL28x9cqrPR9enncIqtZRydCcl/LOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7026
X-OriginatorOrg: intel.com

From: Robin Murphy <robin.murphy@arm.com>
Date: Thu, 2 May 2024 16:49:48 +0100

> On 24/04/2024 9:52 am, Alexander Lobakin wrote:
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Tue, 23 Apr 2024 15:58:31 +0200
>>
>>> We can save a couple more function calls in the Page Pool code if we
>>> check for dma_need_sync() earlier, just when we test pp->p.dma_sync.
>>> Move both these checks into an inline wrapper and call the PP wrapper
>>> over the generic DMA sync function only when both are true.
>>> You can't cache the result of dma_need_sync() in &page_pool, as it may
>>> change anytime if an SWIOTLB buffer is allocated or mapped.
>>>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> ---
>>>   net/core/page_pool.c | 31 +++++++++++++++++--------------
>>>   1 file changed, 17 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>> index 6cf26a68fa91..87319c6365e0 100644
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -398,16 +398,24 @@ static struct page
>>> *__page_pool_get_cached(struct page_pool *pool)
>>>       return page;
>>>   }
>>>   -static void page_pool_dma_sync_for_device(const struct page_pool
>>> *pool,
>>> -                      const struct page *page,
>>> -                      unsigned int dma_sync_size)
>>> +static void __page_pool_dma_sync_for_device(const struct page_pool
>>> *pool,
>>> +                        const struct page *page,
>>> +                        u32 dma_sync_size)
>>>   {
>>>       dma_addr_t dma_addr = page_pool_get_dma_addr(page);
>>>         dma_sync_size = min(dma_sync_size, pool->p.max_len);
>>> -    dma_sync_single_range_for_device(pool->p.dev, dma_addr,
>>> -                     pool->p.offset, dma_sync_size,
>>> -                     pool->p.dma_dir);
>>> +    __dma_sync_single_for_device(pool->p.dev, dma_addr +
>>> pool->p.offset,
>>> +                     dma_sync_size, pool->p.dma_dir);
>>
>> Breh, this breaks builds on !DMA_NEED_SYNC systems, as this function
>> isn't defined there, and my CI didn't catch it in time... I'll ifdef
>> this in the next spin after some reviews for this one.
> 
> Hmm, the way things have ended up, do we even need this change? (Other
> than factoring out the pool->dma_sync check, which is clearly nice)
> 
> Since __page_pool_dma_sync_for_device() is never called directly, the
> flow we always get is:
> 
> page_pool_dma_sync_for_device()
>     dma_dev_need_sync()
>         __page_pool_dma_sync_for_device()
>             ... // a handful of trivial arithmetic
>             __dma_sync_single_for_device()
> 
> i.e. still effectively the same order of
> "if (dma_dev_need_sync()) __dma_sync()" invocations as if we'd just used
> the standard dma_sync(), so referencing the unwrapped internals only
> spreads it out a bit more for no real benefit. As an experiment I tried
> the diff below on top, effectively undoing this problematic part, and it
> doesn't seem to make any appreciable difference in a before-and-after
> comparison of the object code, at least for my arm64 build.
> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 27f3b6db800e..b8ab7d4ca229 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -398,24 +398,20 @@ static struct page *__page_pool_get_cached(struct
> page_pool *pool)
>      return page;
>  }
>  
> -static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
> -                        const struct page *page,
> -                        u32 dma_sync_size)
> -{
> -    dma_addr_t dma_addr = page_pool_get_dma_addr(page);
> -
> -    dma_sync_size = min(dma_sync_size, pool->p.max_len);
> -    __dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
> -                     dma_sync_size, pool->p.dma_dir);
> -}
> -
>  static __always_inline void

So this would unconditionally inline the whole sync code into the call
sites, while I wanted to give a chance for the compilers to uninline
__page_pool_dma_sync_for_device().

>  page_pool_dma_sync_for_device(const struct page_pool *pool,
>                    const struct page *page,
>                    u32 dma_sync_size)
>  {
> -    if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> -        __page_pool_dma_sync_for_device(pool, page, dma_sync_size);
> +    dma_addr_t dma_addr = page_pool_get_dma_addr(page);
> +
> +    if (!pool->dma_sync)
> +        return;
> +
> +    dma_sync_size = min(dma_sync_size, pool->p.max_len);
> +    dma_sync_single_range_for_device(pool->p.dev, dma_addr,
> +                     pool->p.offset, dma_sync_size,
> +                     pool->p.dma_dir);
>  }
>  
>  static bool page_pool_dma_map(struct page_pool *pool, struct page *page)

Thanks,
Olek

