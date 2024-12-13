Return-Path: <bpf+bounces-46875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0609F13C7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEAB1881764
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559F1E503C;
	Fri, 13 Dec 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvRukeur"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E91EE7DC;
	Fri, 13 Dec 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111186; cv=fail; b=UzVMfz9XMtm90/wNyXveFz5SDmS5+EW4P1UW5vtmgVqzkcE982D76lr5Gh2pTYFlSVk36kLkCTuhQM3/3MNMMVGSwUHH7Qosj6MM/B0bAdbn7TYI2ky6Jf/Tl93RHHUsoX8xJbNHN9lVESqaoIVYt9m/P0bQtCUfv+F3cNKK8rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111186; c=relaxed/simple;
	bh=4EJ2D8MF9PXcScShMBqk7CWZi4hYgi5cQB6BhlNz4PI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eez7FqmlnNwiSNUGyQld7o/2h3h4NvWUN7Wv5PeyvNJg7Ji/yXcBd7wCpHwaYPYBndFm3rgWUPx435dQ3Dcb9jMpokYBnKk25Hnkno0yLXbo8ZfEsvynnka1mMzAiUFAjNsJodRyY3GD3PRhG7CcQqefCAIXw++SIlo+Q6MnGUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvRukeur; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734111185; x=1765647185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4EJ2D8MF9PXcScShMBqk7CWZi4hYgi5cQB6BhlNz4PI=;
  b=WvRukeurU2FsGIvPtvxM62+84LpvDTX+TxbNESS+5MRI4oNjkoTdbGCX
   nZdaLP59HrEq8FKMR0DuyEBxaFwO50RXH7NNieDyLXgiDFcsDjXTp1fxb
   vHKtO0zMEebdbJSndOTpIQ+66CqgT4kdi8kdGXvYsHW8Tnynz/xDUTab+
   qJC3/MnjW2LlNv3ptReUMUW1rUlJIlYGzaG3m4mgx6Q/UTbhQwTTxIBoO
   mugUvJgv7F4cr7KFftZz3PcCSfTLAwYa4UlbcYsYlLF0SA9U60fu7+VAk
   dRZ4FAq76GshMsOuwx19I6juW1voQq1SimWT8qqiQolqXeo8/ot4vcbdz
   A==;
X-CSE-ConnectionGUID: ZP/R7+1ZRTCtdXg2J9V7Cw==
X-CSE-MsgGUID: FP+divb3QQaV6Hmhoe3AoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="33869433"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="33869433"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:33:03 -0800
X-CSE-ConnectionGUID: L76eVBveSW6BPk5vq/sJ5Q==
X-CSE-MsgGUID: bXJm1FyUQUWpd5vFhuSV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="127397102"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 09:33:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 09:33:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 09:33:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 09:33:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6XQY8cTzl6ZFbOdkISLvWAgOpv0FsvxCzQEX1zSj5RkUbE0YvxrH0X3ofWWRGlj0dJ+7AMDTk07vHLdeEyRngtCQ+c7E02BslYGNwqTZDNwnDpe2kRPIvy1VaGC/Fl9VyA/PXJUfzy6QWkcKZIo0zv1pBgsD7y4pA7pgaVqQJBrgOyaG279Irrbgbx5SqhDb8AY1mh3x9We0zUIpI4ZepKUuDUCz3hsOaYOpWtHdjn5PJWRtiXE2PMypU7IiTQiJf+nu6tIAkW2VtkX25yGej1tr1NDLWWldm7cWBciItAxLicP9whqq+dzrUxZNuwvsVmaMhFFDQ6scj/vWl5sQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GstcAC7RxY3NpMuPaY+gvEk9RiBZULoVkGWuSQjqVic=;
 b=CO7NYay6JzDNqFnWY4WqKibsh3AQ0ExO1dgIQ/3YlYTTYdyUM11Z5KPJyTNg1UzGSnCzBLrLIyRguMnir8G+1h5MWZJyurK2BtmeLulINyBvIXpdjCIVb+3q3Cy2/lIvCeL5Xq26jAE6qBY0+Kb3g+yPSw02RPXgYxvsxnCo+9hI9U0FNIxXdgAwx0jALfT/NmtNg6JG/pplUKI4aKHUF8sHfxMWdQy7BPAnRRrc6wN7zPhzvNh8GaBFToWtXfy0q1e+KHi82sSopi61NudQjZKQtcTAQfFj0OeMrTuauzxfXCX7hBuHOi3qDRLIWOWzE3Tc/bx7efrNr5wehFB64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 17:32:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 17:32:18 +0000
Message-ID: <eb2aab4b-ba00-4b9d-ba53-5a5bb544f6fd@intel.com>
Date: Fri, 13 Dec 2024 18:31:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/12] xsk: add generic XSk &xdp_buff -> skb
 conversion
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
 <20241211172649.761483-8-aleksander.lobakin@intel.com>
 <20241212181944.37ca3888@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241212181944.37ca3888@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff0d104-6ef7-4f90-47c1-08dd1b9c1779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3B3b21YUWtrTmhSTXJ0dUkvWDdnVEl3L3BNWXRabWJPM3ExbnJzYktVZlZv?=
 =?utf-8?B?THBhNlA3UERkVHV1ZHZMeUN0UlZPS1ArMERRUFFiL3V5S1NjOTJaR1ZjdTUz?=
 =?utf-8?B?MFJoUUFaSHhUOEVzMi95aXJqVERaYk1rSUhQTFFKVC91S3BDNkJnSFlRWkF3?=
 =?utf-8?B?Z3dpVlJ1NlQ3UkkrMGVtT2R1UlZZVTNQZ0oyWVl2UWJZeUNoczNHZW5ROFBT?=
 =?utf-8?B?V2pIR2ZqZTFVMkxZUzZjeG1SN2Q3ckZRMjVYeHlPbWxmQitQRWV0OTFwMnFB?=
 =?utf-8?B?UjJqSHJVMGxpc1M2b0FUNGM5UHN4eWZKa1l1RGNZb2ZZbmJpblJoNVhWUkIx?=
 =?utf-8?B?cFZuaU1rZGM4RlROcmZlR3BqZTZRZHRMaytPK05sZzVZVnEyY0w4bkZTT2pa?=
 =?utf-8?B?SWlTcnkwVlJnQVpZMmdwUG4vVEd5MHFXVmlzZ2hlVW1Hblh2eTljdm5QN2xH?=
 =?utf-8?B?SzJMVnd5aG5HUGZQNUtWaGloRjFJT0VzSFR5WE15UmZhMEQ5UjhuQXhoOFMv?=
 =?utf-8?B?MVJUYVFKaTZ0VGVIRk5ZNnlQdVdzanlrY2s0RW9qT1AvUTJHQXpHMi91V21r?=
 =?utf-8?B?eVpUeDNSUGd0NEg2T0lzU2hNdFUxbnQyQ0xLVTNNMzI3UDNDZk13S3BYQmNw?=
 =?utf-8?B?OXN6ZzVlVXF2cVhoMWY3dXNiRXNuZzUwdUNZN2NGOTNTR0U3bDB5bS9sN0RT?=
 =?utf-8?B?WXVlVEpQK21HWUh4MVd0MTU4Y2x2QTVwY3lyTEJlUGcrbHZjN2hNeVFzSVZU?=
 =?utf-8?B?bGtXOTd2SWZmV3d6SzNRa2lHYjJPTWZaYjRkM1FQWHgySFpFYjZ0T2F1VDNx?=
 =?utf-8?B?V3ZKdi9BMnlHTS9xRk1MdHI5RzduOEoxS01QUThXMytWNzBEeXFnU2plaXkx?=
 =?utf-8?B?anl0NW1qVDVzQi9yUHZ4RjdaZ3hNZVZTcTlxelZMYXVXUlZPdlpVNFFLVmlD?=
 =?utf-8?B?VkJTNWFVajJXTlpMUEpwRW5QdkN3UnhRRGp6Wm5WVjZ4alVVa3BrMkc3eHh4?=
 =?utf-8?B?WWNwN3NOdDRYNTVvbFpZcjZiSk5JU2tES0NtY3FzZFcwYWtwdWc4Tk9ab0pP?=
 =?utf-8?B?UzRSMnc0Nnl1dUdIOHYvNElCcDhjc0lzS3Y4Vlk4c1UxMklDY1RSdmZYL2VR?=
 =?utf-8?B?U2tXdi9WMmJLOE91K0dVMDhiMmMrN2twT0M1OU56dWxrZGRrZktGa1RsZ0Rx?=
 =?utf-8?B?ekttdnd4dkMyVmpxcm5ITlNOSS9QVVo5Y1hmdyttRVFtRHNmS0x1c3pRVUsw?=
 =?utf-8?B?WjltUGJZSXFLUjN4U3l2K2VZNk9xVGZaSGRxdC9UZTVXTTl0ZmlwZTVicC9j?=
 =?utf-8?B?S1JVTnpIdm0vQkEzRW8yTTk1TWIyWUpZSHFWa1VEUTJXcW9uWXlrRUJPSERC?=
 =?utf-8?B?eEFYMnVYeHdUWU5XT0NXUks2Q1JuU3Z5SGVKR2FiMTVlTlVNYTN0dW5TNHRt?=
 =?utf-8?B?UlZWVlY5bHNBb0FiVjFxV2VwQzNKb2hoeFBZMGtRRnJtZTI3MVNYUGV1cVd0?=
 =?utf-8?B?Wk5VN2lNcDhQaEpBeUMwQUdpeEFVQzJmdTlXa1g4ZUhBQkd0bFc1MG1WUk9K?=
 =?utf-8?B?VGdIMWdkSDY2ZVNkU2pZcE5aczdOTTF0TUl5ZmVDRS95SVdvTkpwaXREWGJL?=
 =?utf-8?B?ZUpKSnJPNUEyWnZjaDBHRlVLNlFNK0hDcXJKbzNPOW1SOTJNNVRjSlVUQ3Ax?=
 =?utf-8?B?eUc2WUVtQnFxQThkamRCU0NObjVWQ2tlMFdvVTRXSnVNa2tRNGJmdDh0OUFD?=
 =?utf-8?B?dUhHZjZ5Y3Jsa0sxZnROQmFka2FnQ0M5TDhsL0FpZU44RzRYK2lCTzRKdnJU?=
 =?utf-8?B?WUVQRE9vMEEyVmNJYnlNQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXVnTVd1WDVyOUoydXBabVVlOVY1SDg0VjN6V3FKUlplVWdOYVZVRy9aZUxm?=
 =?utf-8?B?NDhGTzV6dDlXY0NadDJxcm5kTGRGanViNFlHMkc5UXBJZGxXYnBkS3Z6Mmxv?=
 =?utf-8?B?OWU2bHR1aGExcmZvdUkzc2xxUy9LbC8zMkFaNGEyZjNEdk5IZ0I4NElWVDVl?=
 =?utf-8?B?cHNYbHhBRFhGSlR0Ym5ranVJdHRhYkNmRlh4bmFsZGRRTmVSU1JlK1FUd0pu?=
 =?utf-8?B?cks2Q2dSWGYxY3kwZDVxckNrK3FmemdZQ0ljSTRmR3EyRE9NQnZESmZkeU4y?=
 =?utf-8?B?V0grUXQxUjh6ZHFjVnR1TWNHT2xmbWR6RjlIcC9YWG8xOGUzYXdXMnd2S29M?=
 =?utf-8?B?VVp3Ly9tMmFoYU41SzdwSk5nNnFZdTZBZnArbWZ6SmU5a0Vab3lYc1RtWTdY?=
 =?utf-8?B?TERyQzhMVTNFaVgwcEl4NTh4OVlPUXE1YXIyYWt2cFZwczFZZ2lWaWtxWkVI?=
 =?utf-8?B?Y2FtQlB0NGlLb3hjTVpkVVF1NlNLK05Tby9ZcTlTdGVibmlWclpaRjJaZ0M3?=
 =?utf-8?B?eHN4cytYVU9HcEFMMWFJR2FQZVorSm9ISFdZVXhDRzRCRDVqUk9LRTBIU1Zr?=
 =?utf-8?B?c2lIKzVHNGRscVI1S05DU0FEMzQ5VVh5bDZZOEV0ZGVDMlVGaWJzaDBUT00y?=
 =?utf-8?B?WldJVityWTRRODhpQjltK0d4M1VkZ3l5alJYZVBxZ3MvdEgrZGpJc0FsWUVv?=
 =?utf-8?B?YnM2YzBhbUo1cG1Cb0JYempOZGhnTWZDQmJsNFVXZnRnTFFldjBkVG5oNGZ5?=
 =?utf-8?B?V1g0S1FXL3pGVzdESWYyQ0dEM0k5ZzZacWlqa1NVZWdibmpERnpMMGZ0QnI5?=
 =?utf-8?B?VXZLRlRjYVc3OHlSNjFaVDdCdWNwczZkQnMzOGpUMmVkazRCZjBHWThzYVBq?=
 =?utf-8?B?Z2w3WkZOeTF0ZlV1bitkeU1nRHR2MVNQUnRCQjNNcnB5L0I3eDRQL0tuWTBh?=
 =?utf-8?B?Tm1NRFZYdmdQMzM1WWc1RE1tMjVYclpKNlhZbFlXbC9JVDk2Rlozc1hOMHQz?=
 =?utf-8?B?UVBrRDY4bGZoTStOQUx0SEJKQWRHNHZ5TEZhcFpMTG1LT2NmNmx1MUtnY3lO?=
 =?utf-8?B?eUJvVmdnTVU5cnNrMWpreG5IK2ZPLzAwNW5rWFR6WFRiNSs1dk9WclhZT1p3?=
 =?utf-8?B?MWw5eEptTEJGcXJtY1JjNi8xb1dMOUM1Uk1lTEZaUW1JYjJpZ3pBU09oNUI1?=
 =?utf-8?B?ZmFoMXBrdW1KQTNLditKUXJSTWdETkFqb0FDd0Rtc3RnbURIcHVlRjZpWEc0?=
 =?utf-8?B?RHVHZU40YmpTVUxzWHh4elgvamFLVUhBQ2lWV01iWFo2Q1A0a2t5SDRBSjd4?=
 =?utf-8?B?ejF3b1NCajdPb2lKcUV1akc4elZjMGZUcGRtK2ZXQ3dSSWQ1Y1JBUXdPUTRv?=
 =?utf-8?B?UXhJRURmZnRZa2lDVWtQa2JSYk1Fbi9QbGJXS05xbHlDUVljb1d5S3MvZkgx?=
 =?utf-8?B?MHF2YnA5S0tHdHBzZUh4NXYvZTQxRWNjWnFLbFNhY0F2M1pGc2Jxd0JjUVJq?=
 =?utf-8?B?WEhPM0RPRjlRNHI0ZlorOG5OOGp2bzlIMzN3R2QwKzJGclA4b2tTN3pXUUZK?=
 =?utf-8?B?LzRaN2V0YzkrNEMxNHVOSG8wa014R09WUnUzcThML1N6YmFRbnpGUzBTYnNR?=
 =?utf-8?B?N1NMRFA1NldtcUFwK0dsaGZKZjZaRllCVFFkK05nS2lRQ3dHYkRXRW1tUk9s?=
 =?utf-8?B?dUVZQkd1ZkljQXJmb0owNGFheGl1VVZyN1hsUXVqandkb3k0bEc1TDRtS015?=
 =?utf-8?B?REpNd0ZwMU9ZUGh2b3E1UklnZnd1c2ZwbXlueHg3NFRHWEN4Y0l4U1RSaEhl?=
 =?utf-8?B?dVVzaXhabEoxUlRQMHRzTHlZZDJTakQzNUpvcUF0QXo0RnpiZnpyODA5aWVV?=
 =?utf-8?B?b0tzYjJERzU4L2RzWlRORWdrK1Y0L3kyU0cwM0RXazFoZ0tHQW14YTNmbWl2?=
 =?utf-8?B?OTVjSGI0Q3dqVTlMWmM3SStLUUpIZlE1Q3J2VTd6cjBPR0FaZ1F1aVpldWU3?=
 =?utf-8?B?UGxMdlFYR004MjZEc3gwVFlZVXZwSHhRMDByNWNRU3VtcU9QdHB0Zk1XTlI2?=
 =?utf-8?B?eEpPemVTcEJDa3paSzJkbVFNNzVOK1FZUVZtRTdXVlp4Vllab2t3ZXVMZURS?=
 =?utf-8?B?a1Flc2VuREtkL3VZeXpiaXlNY1VEZWdDZ20xa3lhYkdDUEh6ckZLUTNhRnRT?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff0d104-6ef7-4f90-47c1-08dd1b9c1779
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:32:18.2229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrPnhtNGupQEZObOmAPqV7PIqqMs2tWiRfPIDtbPFOPLOXaopCRGcKx5j/nz0sxkWDHs5Kkzh7+OkyhZtdn9fbVpd4HmIcGpgQn8B8g8/XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 12 Dec 2024 18:19:44 -0800

> On Wed, 11 Dec 2024 18:26:44 +0100 Alexander Lobakin wrote:
>> +#else /* !CONFIG_PAGE_POOL */
>> +	struct napi_struct *napi;
>> +
>> +	pp = NULL;
>> +	napi = napi_by_id(rxq->napi_id);
>> +	if (likely(napi))
>> +		skb = napi_alloc_skb(napi, len);
>> +	else
>> +		skb = __netdev_alloc_skb_ip_align(rxq->dev, len,
>> +						  GFP_ATOMIC | __GFP_NOWARN);
>> +	if (unlikely(!skb))
>> +		return NULL;
>> +#endif /* !CONFIG_PAGE_POOL */
> 
> What are the chances of having a driver with AF_XDP support 
> and without page pool support? I think it's zero :S

Right, as CONFIG_BPF_SYSCALL selects PAGE_POOL if NET.

I think I wrote this when it wasn't true (before Lorenzo introduced
generic page_pools) and then just forgot to change that ._.

> Can we kill all the if !CONFIG_PAGE_POOL sections and hide
> the entire helper under if CONFIG_PAGE_POLL ?

We can. But I think I'd need to introduce a return-NULL wrapper in case
of !PAGE_POOL to satisfy the linker, as lots of drivers build their XSk
code unconditionally.

Thanks,
Olek

