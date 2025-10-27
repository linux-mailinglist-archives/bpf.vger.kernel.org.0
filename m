Return-Path: <bpf+bounces-72344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 007A7C0EF64
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 16:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AD304FB17E
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BA430AD05;
	Mon, 27 Oct 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfZaQPZc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC9321C9E1;
	Mon, 27 Oct 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578484; cv=fail; b=QjrIMLJuAHhbwq1uHx/y05xsxFf5zxDcuMMIDkbnBl12ZxRNaUyoU9XuPunJJGLC0s3wxo65Kw19t4cYYZqC+tXmnD631pW7njowP059E32rXq9rL1PErgya6xwsr7sv6iqPoG9x4obFv5XCtqWgjheNs0RgYPssgDDF3CgCwsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578484; c=relaxed/simple;
	bh=Kz1yJwWf4iKrbJtTNcpshYM61R+DqbESXF56/IYOAxw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fThH2N42yzzmAj8OgkYi89ug/HQjaXGZuqhgG23EaGcWTjNRwyZvttK5/1ns6xjDV3qfMPGzhhPcQa6gJBbVEaU/eK2twMLD1pk8KQw5L3o5gWUQsxS3gEcEEQ/VpKd1H6FIy+XkmGG/4z2kYP7yb4u2LrfaUUWpmoEwC/yAy/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfZaQPZc; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761578484; x=1793114484;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kz1yJwWf4iKrbJtTNcpshYM61R+DqbESXF56/IYOAxw=;
  b=QfZaQPZcqsU0zkaW1ZCzzj9cvxWM6C19uXK9B9nOVkNewvDQWaLJgTBb
   PZLYbQAgH3DwiI4Q4JN89Pz4BzllL6sD3bU2uFuKxlHg8O9O6Bn3KWzJx
   ftbs7mmgAF9zVZSG/XULDR/02emPf28U2kekVtSHRcaocyH+gTTLOB/rx
   3RryxuHTBqwqUCzTSLCYGJWUtVPx3hqsqaOnaCXINMJjZWZ04X+5k/0yH
   x5IVxCZEmTpiPuJYs9LKKtvF60IQT1ln3ZWp97L+lcs1BfEV9jR94akh0
   IQEj0cikcOOT0GYEFfOPceHbftQlQ0kF2xwufnm/T2GJ8HSFHsyWNgEAL
   A==;
X-CSE-ConnectionGUID: LthUBCsjQnC17hI7ulsqnw==
X-CSE-MsgGUID: QYZlltGgQH6yMQCQa26KzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75105607"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="75105607"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 08:21:23 -0700
X-CSE-ConnectionGUID: cuPnspJgRg+u1Y+d5FOMeg==
X-CSE-MsgGUID: tSDRPh7iQUmpsaGcGeztwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="189105649"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 08:21:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 08:21:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 08:21:21 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 08:21:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEhA+ms4UvsUPXzjX3HGSPGRjXkOFEPCeDINmpXotLfrTW9YHG0xSalq5tbDS5N7Ulx+v6d3VsFwGvkQYghRXONPqOLn9yCQj0Bgjpc8oE85VT01stOX3t8f4+4T2toEKlZpJqYOVfRxj7u6ZW8MmctGuoN3K4g9WrcPdobo1igOiYJf8ovlKBDwKjKIxSfSxsD1cVIATGH4UgYxwRFGbemOjHLK9oAcywYGQDP51nj0XiVNpZWi8o2fzlKlE7QZScP0Y0blBH3SCJydXU9nLow/s8DU5613FTN48D1oNLENODdUygFMZ35zXPQ1G+Xe2m6+36iEuKjX8h2RXoKYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOvZwU0b+53zpza4QC3KoWs2qCZaJpgkENZ9IG864mU=;
 b=XzdzSsAPaNNB8Jcnp+1x8ebeSHxgOCn15wNK9Ig4RSJig+MxWtWUa7NNIzaQwgRIE+k9D2tMNzUQtABfhUQ3s67s7drGggcZMWca6t2eUPk73Q/dDQTQ7cRDmVL50lLxn4d4bdbr3kJv5T8/lfkCYtT7MA4yPZUZqcfNrNbSDTk1ClTHJ9Rayy36oR1Z8F2aWeIcmdvtMnhF+Zw5ALPmqSs7l8Gekb6tF/lGkUxHrrd+MBY10boCfbRjQSdpUnaeF786wduEKwhioc+OMALlrahfqJj/5MGdvcJSs9Omflbmx2jXA2RPzYNwvVNw41o37blZnURmRAFQcmEQ3D6Xpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL1PR11MB5240.namprd11.prod.outlook.com (2603:10b6:208:30a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 15:21:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 15:21:17 +0000
Message-ID: <27083bbd-1ae0-4cd7-ad30-9353dadf2093@intel.com>
Date: Mon, 27 Oct 2025 16:21:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <joe@dama.to>,
	<willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
References: <20251026145824.81675-1-kerneljasonxing@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251026145824.81675-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0169.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::24) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL1PR11MB5240:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3ff501-8285-4a93-607f-08de156c79be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MW9jK1VzV3pyMlcvU2dpeGQrNUI2dUs5eXdJWWhWNFAvWHB0dllmeDNWTWti?=
 =?utf-8?B?YUJvZzlTRDlGUW9Ub1lzQUova25MdktyTWZhN0tBRDI5VHFyNkdwM1NHa3RW?=
 =?utf-8?B?eDVrSGtYN09XV3MxRnlaTnlRWEM4NTg4b2pBeGY4T0IxV3NKRDk1UU5mNm9L?=
 =?utf-8?B?b3gzYTRSYTVIaEw0dlFPNWkzMzlsNi9yQVNJUHBJTFV4eEFPYTdLYUs1QVVD?=
 =?utf-8?B?cmpYdVpTTWFrbituZXJQZW0rc05ySnZ0cU9rYlpCYW1xQVVjbHMrRzROK3pE?=
 =?utf-8?B?UURYWjVEdUljV01RSlNpKy9xb1o0SUpyTVJpbDdGL0IwVW5JeHZIWGZ3WENj?=
 =?utf-8?B?QUlOSW1WaUxUejkzaExBTitEOEhtbjZDbVBHTm1GZU5kdWgxWWRsNEd1YTVX?=
 =?utf-8?B?YUxjVFh1Yk9ZdWpRR0xZa2psZ1Bpd0l6MGV6S2gveWEwbnlaRnVOZy8xd3J5?=
 =?utf-8?B?WWh2TC9aQTFVWWpoUjhZS3ZkcFNZdlM2T3RRK251WEhzWGFQRTJ5OExVTDdJ?=
 =?utf-8?B?SFRObS9EN1pLb0VCRGc1WjkzZnA3TUhjbFQvSFV5UHVVNTQzN2lIakExeHIx?=
 =?utf-8?B?RElWcUVuMzdmMGNRbDNGSXExM3RHTHpqN1NxbEJNSkx5NWNoK0QrUUQzUTNm?=
 =?utf-8?B?eFlUTU42WGtDSXBPeWtBZUJONkpyN3JWY2I1TFN1RUNwTVNrc1VWNlAxNEpU?=
 =?utf-8?B?a0tIVUpuL25tK1ladzZPWHBKY091S0RNeTM5QU4raDdmcGpCaHlJcDNQbjMv?=
 =?utf-8?B?QUNTcGdIM1RXSzNyZW96T2x5bVhCZUVKbEo4M2lpTmhBVmE5b0pVMEtMcnc2?=
 =?utf-8?B?L1dhY3dkK2V3YWVnWkwzYUVOZzB2bXkwSmRCZmVha1czbWpvOUhDQkN1QTJQ?=
 =?utf-8?B?empTUmYwRjNla0ltQUtVWWg3SGNTSFRHU1JnMU1qeUNEc1VPTEdEeDdvYUhp?=
 =?utf-8?B?SzIxK0lkVDd1cGZrREtuR1RxTVBCNUxyR0hoUHozMitEbzlJRE1jY3UrbSs0?=
 =?utf-8?B?VE9GL3Q4azZXb09NMkZJVTFZZXNURStWMFdEbHBKQlU4V1kzd2QrSHFSL1I5?=
 =?utf-8?B?VFdQbENmeFlaY3g4SzFZUVB0ckx5amdYcy9uRVA3V2txQjI5Z28vcXFoWnM3?=
 =?utf-8?B?YXgvaXJXc1pCV0wwNTFkU0M4N0pGaUFBTjNFWUQ1bGVNMWZrellaWlVpRjlj?=
 =?utf-8?B?cWRqS2xQMjN4QkZka2lxU2VaeXJ1L25JR1I0cVRBeGxQTWJKUEN5QmpIaHdC?=
 =?utf-8?B?YmpjUzc2cVovRXQ0cjNVQkMxOXF5Z2ZoRDMvekJLOTVGTXdsYkVJS2xWYm5Q?=
 =?utf-8?B?V3JicFNqT25uelhGQS9aTWFSNVpQR0hBNFpkS3RNVFRydGFrYkVXYUc3OUtS?=
 =?utf-8?B?TGxJajc3VVZWYm1GdU1YbU9DWmpWRzRTSkpHNFpUeDUwSWZRQmVyRnJ4amkx?=
 =?utf-8?B?S2JudGdWT0xwRFpVQ1lUSXRYVXA0enRFZE02a2dVUUNsM3FmQXl4enR1R2RX?=
 =?utf-8?B?QUJzRDhrNjd0WjVlV1h0aTZSRzRoOWtDR253WEVwNmNpRU9mUytDQ3dDR096?=
 =?utf-8?B?OVdDS3RleVJhZFdoRGNoa0pEeG5mR1JaYXExN3F2NE5LNDJ1QXNxQUVKcWFP?=
 =?utf-8?B?STRsN2hIcks0OWJFY3l6SEVMeCtvTnZBUm1ldllLVVpMeUd1aHJUcWpSU0FP?=
 =?utf-8?B?WlRwWkpIbkZXYVhNK0k5b0kzVlUydjV3ZEJkM1JIZzdvZEJPblozakFBUmQ4?=
 =?utf-8?B?bmIzb0xmS0ZiWDZ4TkRzTWNKdDNJYXFOYVZZU01SZU1CMXlVRXVrdVl3L0ox?=
 =?utf-8?B?RXhuMG5UanR5cms0YkR6WmtCL3ZXTEk0MExubGZOcmRJREFHZUMwcmpLQjV0?=
 =?utf-8?B?QjRERjhlZWZGWHFXdEpYWU0zT0oyejg1cWRxU3NJc241NkliQjA1b1J4TDd3?=
 =?utf-8?B?QU9QK3BkM1JQcDRDblIxN0FLN1FWWElnVFNoOGJnaFE2WGg4UlVIdW10Uksy?=
 =?utf-8?B?UXljNFg5MzRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnY2SlUxMzdSdFFLSUlWQ2dGTVpzTzBvTkVUb2h2eEpnMkpzZkJwbUJ3aHht?=
 =?utf-8?B?Kzd2a1I2Mm5aSHRSdlkxYzdJT0tDOTQxUk43di9jbTFRVjNhRUpFdXZlWFVx?=
 =?utf-8?B?OVI3SUtwK2YxS21JWEV2U0JWc1VjSUJQMDZxcktTdDRFVk5WN3Q1NUIwcUti?=
 =?utf-8?B?WGh3V05BMEZtNjRqMjJ3VzQ0SE1jRlBYOENTYmVmTTEyMldUNElDeGw0NkJj?=
 =?utf-8?B?WXRDeENxbTVBUXpHbWFQNldxRDYrSDNGNHUzZElTdHJpd3RVdGt3UG1ySDV1?=
 =?utf-8?B?a2x1a1pRNnFXZVZYeHlmaTJlRitPZGNWUUh1cnhjUDVteUF5N3lEWCtmcWkz?=
 =?utf-8?B?SjN2ZGhqYTR5ZnhldGIvdmtXMlE0M2hqa3pzeWpnRFNJenJ3RGRxa3g4ZG96?=
 =?utf-8?B?eE9hazNnUEpBY05ZNE4yVVpndTY3MUlOYkhCMkZlSll4RWVPZWw3UzRCcEZu?=
 =?utf-8?B?dzdEaTFpcjFET01aSmV3eDhUN0hwck5iSkwyYVFvR1Zwb0NMZjE1Zkk0ZDZP?=
 =?utf-8?B?M3YzZ0RiUFIxbk5yYUJiLzRwcndENUNpdjRaSktHUzE1QUFhZVBLZ2FPV241?=
 =?utf-8?B?QUp0M2JOOUh6Ri93Syt0UFRzOEhyWTRlYUJmNjk3TktUelM3OWY1Z0J0ZitL?=
 =?utf-8?B?MjRhYlliVEVrVTdjeDZKbjdIZWt0Y2pETjhjU3A4VWVZL3UzdjBQVm1LcWlE?=
 =?utf-8?B?d0EvT1N4TzNxYVdFZzYyTDJtNElybzlpdXUzTncyVzY3Q0JHdE5rN2hVQ2p4?=
 =?utf-8?B?eHR1UTNlRDNTdHBkakhEQkRvTVVkYVBsdmdqbzRPK3ZNaktpNVRiTkFibHZ4?=
 =?utf-8?B?SUlaR2RTRmtkNWhKM3FzSVd6QlpQRTBlYStweEw0K2FDKzNNY2orN0VLUkpL?=
 =?utf-8?B?QU1hUk8vSlRzdytUMittR25mRmtXbGRNblNoZFpzWE9WTFNydFYxK1djZWNZ?=
 =?utf-8?B?WVNjRXhleE1jNEhjNUw4dVVMK2l2eThxN0krZzFqa0l2R2o4RVZMV3RiUXVL?=
 =?utf-8?B?ck5IdlRmendiN0tlQ1doYXNEZGdmRzdTQzUvdGhlWGcwc1FDNXZIVThiZnIr?=
 =?utf-8?B?TGRGVk9PbXFjMFRUME9jOTdXTEpWT1EraDA5c2phTVlWQTJuSzhGSWljUTlH?=
 =?utf-8?B?QUVoVytYUHIrVzR0bDRycHlweklaYkN6NjJJMHhCZWNRdWRXL3BaZDNCQ3g5?=
 =?utf-8?B?bVZBZzAxYU1kQzYweGVnaCtVNmhMZUVMUHphSStVcDZqSXFOSTJGaGVOaHNm?=
 =?utf-8?B?WVlaaTRlYXNiSkJQYmV4Kzd3U05Mc016NjZxMkFjYk9MMEN1alpNRGtaZFhR?=
 =?utf-8?B?SER0ekZEcGFsbFp5ajRsdWtLSU5RcURpVVBEOHlJQmNJbUJ5TkxOZ1pCRXkw?=
 =?utf-8?B?YmxyTyt3bnVoQ3JnYjVPVFJjbEFFK1pMSUg0b1luYkhEVlJUU1c3b0dEY1B3?=
 =?utf-8?B?MmhNYVMxVjZMS2FkbzRLSTd6dUdJeDNmK0Y4TFNDOXZweks3cnJuRTZvVWpj?=
 =?utf-8?B?eVBpaWt1ODYraVpNU3FuSDUxbDA2MUo4TXRBNDNSZ3ZEZDYyeFBzTGptRU5q?=
 =?utf-8?B?SWwyMGtPY29yRDl5NFJaOElEenNzNlNqeDBkaDMwQWhFdGQ0TnJiTWVZeGF1?=
 =?utf-8?B?K2t6bXh6ZVJQdkQzZUNPNUF5SE5vVk5UWEZncytnbzkyWFVSK1BOaGk1RWpx?=
 =?utf-8?B?eGNvcVpxS01WRWZuODFiaFM5NVllRXhWK0dSQTdDeDFFMFZNSjgxVWZNUHU5?=
 =?utf-8?B?KzVYY1krQnNRV1cwZW1BUkoxRjI3U0tETVJudlJiN0p3N0pIeWZpMERyOWp3?=
 =?utf-8?B?dWdCRWpqeEd1WlJoL3RmcWFEWmViTjhDcGpPTmRzeFdrblVIdmgyZTRvMFhr?=
 =?utf-8?B?aW1vQk14bnppakxqK0N2VmF4QTY4emxpSlNoYkVobUprbU51WmtmWGp0a29u?=
 =?utf-8?B?SG5ZaWp1MnEzdWlCREhpNXg2elNBSllhY01mc2xzRkRzcFpwM01rUDdWT085?=
 =?utf-8?B?QWlEVDR6ZEVRV3UvRmp4U1NIYUlaRkdMSFdSMUx4WGF5Q2hNcGJiZVFFdm9m?=
 =?utf-8?B?MitHRXBYRTNyU1Z1bGdSMng2cE9XQnhJTGRISHBBaDRsWC96TTZCZGJqTUVN?=
 =?utf-8?B?bnIwNnJSZkNWUEF4NnY5UXBWQ3haSlp2U3dyU3E5b0cvQzlBNlJsY1hkc051?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3ff501-8285-4a93-607f-08de156c79be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 15:21:17.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VztuJyialmwA/axT1HQLFvkbYA2kQUEi4T8fKkMpMyRBeNgXYjLa0MuqRjZkoXAM5vSc0Yny3eWsKnoCGttwF32yt0tPx/lPoRzd6Yk2Op0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5240
X-OriginatorOrg: intel.com

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 26 Oct 2025 22:58:24 +0800

> From: Jason Xing <kernelxing@tencent.com>
> 
> Since Eric proposed an idea about adding indirect call for UDP and
> managed to see a huge improvement[1], the same situation can also be
> applied in xsk scenario.
> 
> This patch adds an indirect call for xsk and helps current copy mode
> improve the performance by around 1% stably which was observed with
> IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> will be magnified. I applied this patch on top of batch xmit series[2],
> and was able to see <5% improvement from our internal application
> which is a little bit unstable though.
> 
> Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
> be when the mitigation config is off.
> 
> [1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@google.com/
> [2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> v2
> Link: https://lore.kernel.org/all/20251023085843.25619-1-kerneljasonxing@gmail.com/
> 1. use INDIRECT helpers (Alexander)
> ---
>  include/net/xdp_sock.h | 7 +++++++
>  net/core/skbuff.c      | 8 +++++---
>  net/xdp/xsk.c          | 3 ++-
>  3 files changed, 14 insertions(+), 4 deletions(-)
Thanks,
Olek

