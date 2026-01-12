Return-Path: <bpf+bounces-78543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 680DDD124F1
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCC1C301D6BB
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9C3563EA;
	Mon, 12 Jan 2026 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPwQ91qG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A9929BDA5;
	Mon, 12 Jan 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217510; cv=fail; b=RtQ0cmad6DJfqtmmBqpVDmfuMcLk0u96ktTYINL3oct6MX4DkqvuLngVgrI1Cuh2hjLVYXw+mg7YT9HMvpRhDRWhu92NRtodfJLLtWIxho0ikC1TlRvJ+13H1erx3TLyWZ2uurr8M9OXBpgyTqNLiOpYk9enQguJmcTA8LZP1ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217510; c=relaxed/simple;
	bh=NrMmiUszJXUdMr5qkYk4ABInK2PjrALNaMno/zUj0Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GblUKKD/tvo8A4egPWxggsPdyiUElsZhoqNWcocCPkRf4fpb9KSukUE+XrrSqoJY3z3X9aVZTjX7v+aou4aMYsMh8RIVlKHVou8uYIARydX8KiMJ44gvej9oRhHQZZkPCwTlk/u3ufiWThITWdV7+f4kORH9MYr7o/msM015KAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPwQ91qG; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768217506; x=1799753506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NrMmiUszJXUdMr5qkYk4ABInK2PjrALNaMno/zUj0Fk=;
  b=WPwQ91qGqTNfzY/Zg88A9vG3cIwP3UyvQXmcnlXEVc+PhE1Yq0gMov1V
   L862b0DqbnedGln2zFhzxhRQX1p6yjkwpABcuK2u+0C/dugaK09ZZLG6N
   kACbqCLt/0Nm5Ft4hbSqLhrWKtLtrgkcbcBmkUvoBmNkD2vTdaydmTNRI
   mQ05m1Aej79C3oxpWbvHRgkT8k56iZrrnkZsfdULw0tx+00YWAJr8M7er
   XfqcowWN+GSNp7uuxfWXSeqMG42QHWz0E5340prc8VroWMfWSxQBkRBYW
   1YxjLQ6XNxikHEWLkbXb9DHnSxi+8PiaBBwNzUxufSdteaJCfUYSGioMK
   A==;
X-CSE-ConnectionGUID: K6LPQs3fRz2otKVZbBJ1VQ==
X-CSE-MsgGUID: WDESTHmhQJa7JBLJeR8kEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="57039149"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="57039149"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:31:44 -0800
X-CSE-ConnectionGUID: aQ55LNycTM+fs9ugM+3crQ==
X-CSE-MsgGUID: iD7bAtoiRZOFiz/7b/BIKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="209141061"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:31:44 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:31:43 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:31:43 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:31:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HulgA84fBXWMFd81OB9FofUJFcEBn0SdlqHa44vP4RiwKGDIKcJAp6n0RSdJuWuNb74wqb35odorbOHS/0EErazIbx+AEvOHkug5P6dCVD3EwT+qVwEv8e+O77eEPtbCF5AyxfQATP/lr3+hzRMH/cfesn9GX4vmYOcyY9/+s167iBVddTV+sV1L4u7d4VwomCtfZwRjgaZQFCJC/Dzcs8MUkKCcAHQPz6w1rLY9bng8Tnag2EiN1OUDQNcPhMmqa7L9W+MYtFkNYKdZodI3jN3MR6iJjkDiK7pMGZGQNvqGBaywkar3RU2VGuzW1L6HGEz5OYmhbQk6GW07/JherA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrMmiUszJXUdMr5qkYk4ABInK2PjrALNaMno/zUj0Fk=;
 b=KD6Zx9kJM7F7xD7nx+Q2GLu/KIXc/0OaukaOGw5tik0aNF6BifZtE2yYTsMyxJhLvmOqN2le28UXd2qPvzkjkk3bXUEePHd9r9mJLUA65KA9d7NUDs+LUwtLy07SZnRenf5j/t1rfZm2LR120guTUSHDRxYiiHnUNehFCvwM0SHI72P6M6ohJ2UUMIw/mXfppm2X3t8bADaOQMPSOP6lQRappyvMkORi4JKisrT1PC3hK14svAIyX6IIuv/+GY7uYa8MYb1PuvmLQquO5jctdJsnTlh9MVM2u99Z9Y7BzlB1wtWoK2KWTeKl/xFhOm6MMBOR7zeAja15B3koDgBFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:31:40 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:31:40 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 05/10] igc: Call
 skb_metadata_set when skb->data points past metadata
Thread-Topic: [Intel-wired-lan] [PATCH net-next 05/10] igc: Call
 skb_metadata_set when skb->data points past metadata
Thread-Index: AQHcgnTkpOce5ZEsPUWi+helIHIyr7VOaRYQ
Date: Mon, 12 Jan 2026 11:31:40 +0000
Message-ID: <IA3PR11MB89865C61B9CE820EE432221AE581A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-5-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-5-1047878ed1b0@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH3PPFD6B8A798D:EE_
x-ms-office365-filtering-correlation-id: 1908354f-d4b0-4f7a-949e-08de51ce27d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cGNUenRiTzgzdzdneGpQRVJIaUtETGdNTGMrYkhFQ2NnMlk1RTlVem9Pb3g0?=
 =?utf-8?B?Q21lcGkzZDlROHF0UVVrY1AwcFJWcWpzRHhnYnFxbG13dXd2d0NwdEU3aFFW?=
 =?utf-8?B?M1U2cHFMNWx1TWtMSTl3TEMxRHBZc01FblRFVy8waHVtdUVFT2Zxb0xJTGxt?=
 =?utf-8?B?SU1ING9WT1dBWEMxOVVDemJxN2huS0xLakZZTk5QNGRrQ2s3T1NlSkd4WC9Q?=
 =?utf-8?B?V3kvUXplQUZUbUlTS2xsczhQUzEwTTZxUmVUOXRNelpMWUViUWY5NExyUE9m?=
 =?utf-8?B?eUFON3dvTzRiZmNBUlkrbDlZVWhiaE9xWkZ1N1JQTVJXRHhiaVAyN0M2bVlI?=
 =?utf-8?B?N2QxMExVby9CemNyUWlxellJMlNkejdPUWN5NERlNFBoVUxOYWlrMFFITVlp?=
 =?utf-8?B?eThtL0dYZnErdm4rbGMySDJjSUNLZ1FyVk53Qmw3MzVIWkwrN2pwTDk1akUx?=
 =?utf-8?B?OFhlWkFXeE1NL3BSZFhLbEhzVXFnaXBuU0cwY05xSGZ4V0VLdkpzcFNYTEtu?=
 =?utf-8?B?NnV0MHpKYlJHa2RkRlIyaFo4U0xkWWd1MlZUN0hhK1lZcWttM0cwcnFHcmZ6?=
 =?utf-8?B?Ym9KdjFXR3dqUm5aZm92WkJnc1g5dTlxUElUSy9aN00rVGJjM0NEOFl5TWc4?=
 =?utf-8?B?cXN5MFVBT2JPcnlxRnpnendXcWxWZ2tjTlhhSFYxcmpMb1FKT3EyYm90N1Fk?=
 =?utf-8?B?WWhqVDFkVkV0ZTVpRFowUGpiMkZtNjJSaEtVRm5qRW44QWI3UVluRXNtVjFq?=
 =?utf-8?B?UXlISE14anZJZ3krUjJuT21nK2VBekVISFd2MmlkMHhVeGRQcGRaOGc2ZjVE?=
 =?utf-8?B?ZmgvTndjaC9CNTVFRk9CMVFRd3k1MmRIdEJiZGJaQS9VdVpXNkFkdG50bjJr?=
 =?utf-8?B?NHRKekZDbWpkNXN4VUNVM2o4T3FlOTlXSWNUVlk5Z3hNSit0QXBlT3JzRnp2?=
 =?utf-8?B?QVQ4OU5IUW9PUEpQY3FWNUN5Y1A1RUt6ekdrNjhGU05wSTJQUEVESEhhMWtK?=
 =?utf-8?B?MDdOOUtpdDF1TmRxWTFVVkxUWGdXbmpYU1BWVUxlSW50cXpKQUJscXhXVlJw?=
 =?utf-8?B?bjBQVUh6V3h2cDdIMzNPeFJ2OE1HenVjMnpsb29OeTJ1OFNmRThnWXlRMFZS?=
 =?utf-8?B?RitpYlJ4V01VL0dFdzN5ZG1iVVRZdk9LdmNHNURrZk5XNnpRVEpzUE4yU3d5?=
 =?utf-8?B?TzhXQWp0L1NPYjhYbzlsaHk2cVpHQTlreUJ3eDdqV3o4V3V3KzN2c2htbkZR?=
 =?utf-8?B?VDE5UGNPb0lGdmdqMkpPVkZzd0FZV0RtZk56T09aTnl3T3JzR3hOM2xxdUVH?=
 =?utf-8?B?UkpPSXpRczMrcUJEdkpabWtwR3ZBT2t6Zi81Y0lDZW5wWEtXaFJWbWtOa2cr?=
 =?utf-8?B?OXA5Y3hDV0hwYmVqektLOVUrbjhhbk41dk5ubEw0RlJuZjNmTmVXRUhFVzY5?=
 =?utf-8?B?ZDlLQ2QyV2VyNzY4dnhHdEN3V3R4MHdMcXZpaUFMcmFXOEw5eVJ5dWJOa3ZN?=
 =?utf-8?B?RXlYOG1BeVhyekxra2hnbTdMY0phSGN3SlpuUDV1YjBkRnRZQUNqbElxMFVX?=
 =?utf-8?B?ZFhKZXpZK2lCSElvbGFHbi92cEs5dERQVmVjbGFRK1VTVjRDNWdVWWhzVHNh?=
 =?utf-8?B?RTcwa1ZIYy92T1RnZ29waXhxZEY4NjlaTnh5ZWMzN0lQeXBvMjY2UEJ3aXRp?=
 =?utf-8?B?eVlSTzlOVGRQUmFOSStKcmlacit5QmZEdHVGL2sra3IwMysrZnE5RkU4dDZB?=
 =?utf-8?B?M1F2cnZmZkYwYXFHbDkyRVNDemRZS0tZcDJvZGc1U1o2REQrZkgrekxyTE5D?=
 =?utf-8?B?Sm5VUUFaYlZVV0w1Vm5EemJMbjJJMGR1T2FqTnFkYk5FMUZNOEZ0SERlYWFX?=
 =?utf-8?B?S2NLdU94aUNpM0RzZXZNVXJ3VVJ0UzJGY3ByYUFCeGc5UTEwUWpwbTB2dE5T?=
 =?utf-8?B?NVZVamdYRllEOFFuQ1l4VkxRYTB5dGoraE10RzlwdUJtYnI0OU1xdmlxckhP?=
 =?utf-8?B?YjlTQ05NMU0wS2ROS1ZTdGhyb293Sy9UQWhUZG0ybkk4dGlzclRzZThhWWZo?=
 =?utf-8?Q?SX+egv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RCtjT2taNGNQcWpZL3ZMSG9sbEZRSHlqeEIrT0FISGVRS0Z3UHhLeDFka3Jw?=
 =?utf-8?B?b2ovZUs5UStwazMvY1NrcDN0YnMzVkJtL1hoNEMyN0pscDc3Z3NKd0dScWpq?=
 =?utf-8?B?UVJ1UjlmNlp6Vytnb2FJV1UwTkxMVDFXdVJ5bFFxRnVwSFdZa0VaRUVrMzh0?=
 =?utf-8?B?ektkTzdkS2VrY0ZlWU0wdmtGemFtYzFGQ2FNZkx4UEsvL0lzRnk5V0g1VHY3?=
 =?utf-8?B?TzlXUmJLVlJxSTJiQWFMM2lrVlNpZk44U1Y4QllXZEQvZHZSVlVzd1FGblly?=
 =?utf-8?B?azNJaDFRQVNPTXBlcGRXT3g1dnpzRTlPY21JVlhFTmZvdjlYMkZJa2NQKzdL?=
 =?utf-8?B?L0kxeVhSZzRLcWdoNVAzNVFlK2FWOGVCOCt4MWgwbjJ1dnVqelVxbGdqcFdt?=
 =?utf-8?B?WHVqOGJ1cndTSERGUHNCMmhYcVNMMlBGZHRwT2dSSUtaV05xdTZlc0Y1WktG?=
 =?utf-8?B?TW5NVTZHRmhkTFM0M3JLd1hnUVJqVGJQbkN4a1RWS2U5dks3bU0vbGo4a2pC?=
 =?utf-8?B?MFgzR04zZWx0Q3hCdkpBOHlQbWtGTjk2WGk0d0EwRURPT3RsTVZwNnhNTTgy?=
 =?utf-8?B?QmNBeFYwRE1JSmowbmplcWVjMzd5Z3lzeStJRUtjeDFlTXVLd2tyODNFZlNx?=
 =?utf-8?B?WWQzRTNxQk5VLy8vTXI5YzNoUUlOcnVQY0JyelZJVkVrZGhJRzRCMCtEYjNB?=
 =?utf-8?B?azlHMFFJMERod1FhRWVjU3FCSzByUDY1V1g1b0ZWeTk5SnZmcy9nRVdHRHhy?=
 =?utf-8?B?eHFwL2Npd3A1L1lFbE1adzZqUHExVHlrUlNxL3huaGVwM3BBcC9hZ0dSYlN3?=
 =?utf-8?B?Wk1ZVkZZeEFGQ0tGeUpwK3N5MnA3NE5hN0lqVnRlWW42MjM0NURaQnpOSTQ2?=
 =?utf-8?B?clJEaHp1V3hMeVJvVmZMMVcyNHBrdVhuemNCZmdKWUR1RVlOb0RFYlloMmp3?=
 =?utf-8?B?QzQ1MmY0c0VhR3VrNWRXTWFxeWhoZmhNS1BjalhYWXNBalIvZFVwZjEwNS8v?=
 =?utf-8?B?VWFtMXRRNk5GZ0I1dmVQUnl4T0hNbld5dXMrdUh3ZmJEbTIxS3E1eFZtN1RW?=
 =?utf-8?B?YnhaZmtkSXZkSnpURzdJY2dOd24wUWJHTFhZN29vYjUzWnFvU004RGNWYk9N?=
 =?utf-8?B?djd3bmJyU1pUeDVBMWhoY0ZmMEhza2I3SEoxZmR5MDRkWTgvR3lVMnlyUHZx?=
 =?utf-8?B?akQ2Z2E4Z1ZsbGplRXptY05Ec05zMVExeVB2UGd3K2xzTHEyaE5hakl6RXFK?=
 =?utf-8?B?RTFWTElXNjEyYXhRWHBBKytmQW51ZnVlbUdlaE90VFh5NElhZ09EcTNOcjZC?=
 =?utf-8?B?MXVhaHJ1UEJRM3EyRVdrb2hvdTRtOWI2dS9QTGl4YTlKVldiZHFZOWplY2hh?=
 =?utf-8?B?N2tEUm0yTlR0bk56QnQrTlF1OEl6YWY0N1VTa3VNSmF3T0MxRzdqNDZTMTR0?=
 =?utf-8?B?dlJPNU5OMzdpU2Z2VGJFTTNKbHRWL2lPRVNleFVrdit5VWEyaWhxaFpQOVpX?=
 =?utf-8?B?TEpISW90UjlDWVkwb3ZHcTRUNkt1WW1LMGhsMEQ2VWZDU2ZNQjNmN29uQWxM?=
 =?utf-8?B?U0lja05HOWErOGdGdmZpb0xMNFdYeFhkZnBNRk5hdXJMVEVpeXBjNWlmM2xv?=
 =?utf-8?B?M0lLZ1J3U3hjb2hscWFrVGhSajZVTkJBSTJESGw0Sm8vMk5qTk5pdFkrUU1G?=
 =?utf-8?B?MXdreTdBNkhEaVgySjdNMkVubHhCRkZrMnpLQStRamNiUXZVZy9jL0xLeU5P?=
 =?utf-8?B?djRDZlRpVXVVd0JFVTMrV0xrcmJqdzJXZ2dqNGEybnhVOVFuNzlJOHVQRmdw?=
 =?utf-8?B?VTgxdUJOMVRGcXJndlJwZjAwdzlvaVFYQVN0Z0ppUllxYlQ2bng0TEdIcW5p?=
 =?utf-8?B?T1BYZWUwUnhqUHo0YlBCTHk2bTRwTklHaXYrMlZEUFc2WVU2V3J5MXlDajBX?=
 =?utf-8?B?MHZtUEtETktUL1Q1ZkVZd2JHeFh3QmFUVXYweGU0enlnQzVrWVlnR0d3bERR?=
 =?utf-8?B?eHlRQU42aDBncm9kVFhYaHYwSjlaSjc3VnNWa3gza2hubGh0OFhQNWZ0VDVp?=
 =?utf-8?B?Sk1iK29DbW81WjBhc01xTEVDb3ZBS2t3YSttb2RPcU4rVjJWSnJlT0dnRXJ5?=
 =?utf-8?B?MklibERaV2k0ejlxTUJ0QjhlRUtJU2pJZEQ5M3V2L0RjUjRWL0taNE9nSitG?=
 =?utf-8?B?UFB1TmgwVnpkWFZIVUZYZ0dsYnhVbk9SWWlJdG0wdG5UWTh6N0ovM0NObDdN?=
 =?utf-8?B?bjFHaURJTitMSHpLUEcwTmgrQk1Kd1pDN0ozZVo3NTBGZkxzc25DaVh5em9x?=
 =?utf-8?B?TTZpTlBPS0Z0UTh5T0FBbWo4dkVHcmdPSnhDUlQrUVppTDRtejZjZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1908354f-d4b0-4f7a-949e-08de51ce27d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 11:31:40.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/O1x4rAL5Sngzr+nRaICjs1zYGKZnhCVqe+VNzaK5u5sSPozFYVx827XbPmOYkmVVZAr5OZ8U2vrC+lVKBKUuXCnLhGYPcnxGSMtmAJiss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD6B8A798D
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFr
dWIgU2l0bmlja2kgdmlhIEludGVsLXdpcmVkLWxhbg0KPiBTZW50OiBTYXR1cmRheSwgSmFudWFy
eSAxMCwgMjAyNiAxMDowNSBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzog
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz47IE1pY2hhZWwgQ2hhbg0KPiA8bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbT47IFBh
dmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbT47DQo+IEFuZHJldyBMdW5uIDxh
bmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tPjsgU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPjsNCj4gTGVv
biBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlk
aWEuY29tPjsNCj4gTWFyayBCbG9jaCA8bWJsb2NoQG52aWRpYS5jb20+OyBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFy
Ym94Lm5ldD47IEplc3BlciBEYW5nYWFyZCBCcm91ZXINCj4gPGhhd2tAa2VybmVsLm9yZz47IEpv
aG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+Ow0KPiBTdGFuaXNsYXYgRm9t
aWNoZXYgPHNkZkBmb21pY2hldi5tZT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsga2VybmVsLXRlYW1AY2xvdWRmbGFyZS5jb20NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDA1LzEwXSBpZ2M6IENh
bGwNCj4gc2tiX21ldGFkYXRhX3NldCB3aGVuIHNrYi0+ZGF0YSBwb2ludHMgcGFzdCBtZXRhZGF0
YQ0KPiANCj4gUHJlcGFyZSB0byBjb3B5IHRoZSBYRFAgbWV0YWRhdGEgaW50byBhbiBza2IgZXh0
ZW5zaW9uIGluDQo+IHNrYl9tZXRhZGF0YV9zZXQuDQo+IA0KPiBBZGp1c3QgdGhlIGRyaXZlciB0
byBwdWxsIGZyb20gc2tiLT5kYXRhIGJlZm9yZSBjYWxsaW5nDQo+IHNrYl9tZXRhZGF0YV9zZXQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYWt1YiBTaXRuaWNraSA8amFrdWJAY2xvdWRmbGFyZS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMg
fCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2ln
Y19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0K
PiBpbmRleCA3YWFmYTYwYmEwYzguLmJhNzU4Mzk5NjE1YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4gQEAgLTIwMjQsOCArMjAyNCw4IEBAIHN0
YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqaWdjX2NvbnN0cnVjdF9za2Ioc3RydWN0DQo+IGlnY19yaW5n
ICpyeF9yaW5nLA0KPiAgCSAgICAgICBBTElHTihoZWFkbGVuICsgbWV0YXNpemUsIHNpemVvZihs
b25nKSkpOw0KPiANCj4gIAlpZiAobWV0YXNpemUpIHsNCj4gLQkJc2tiX21ldGFkYXRhX3NldChz
a2IsIG1ldGFzaXplKTsNCj4gIAkJX19za2JfcHVsbChza2IsIG1ldGFzaXplKTsNCj4gKwkJc2ti
X21ldGFkYXRhX3NldChza2IsIG1ldGFzaXplKTsNCj4gIAl9DQo+IA0KPiAgCS8qIHVwZGF0ZSBh
bGwgb2YgdGhlIHBvaW50ZXJzICovDQo+IEBAIC0yNzUyLDggKzI3NTIsOCBAQCBzdGF0aWMgc3Ry
dWN0IHNrX2J1ZmYNCj4gKmlnY19jb25zdHJ1Y3Rfc2tiX3pjKHN0cnVjdCBpZ2NfcmluZyAqcmlu
ZywNCj4gIAkgICAgICAgQUxJR04odG90YWxzaXplLCBzaXplb2YobG9uZykpKTsNCj4gDQo+ICAJ
aWYgKG1ldGFzaXplKSB7DQo+IC0JCXNrYl9tZXRhZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7DQo+
ICAJCV9fc2tiX3B1bGwoc2tiLCBtZXRhc2l6ZSk7DQo+ICsJCXNrYl9tZXRhZGF0YV9zZXQoc2ti
LCBtZXRhc2l6ZSk7DQo+ICAJfQ0KPiANCj4gIAlpZiAoY3R4LT5yeF90cykgew0KPiANCj4gLS0N
Cj4gMi40My4wDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxv
a3Rpb25vdkBpbnRlbC5jb20+DQo=

