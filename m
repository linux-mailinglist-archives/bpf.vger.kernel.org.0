Return-Path: <bpf+bounces-54200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01182A65584
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485DD17482A
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C69248166;
	Mon, 17 Mar 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCVvCDg+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781516E863;
	Mon, 17 Mar 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225206; cv=fail; b=QmBfJpLBnYxZgN+x8KcukN9tRtawPJj4+Io3ECsihbbnFbORI0ChZCaOMDZ9YI9T44e14nVvpZEj/4cDUe8/cYtFMNM0xjb1PRFJGF2RSLbihPx2/M4K9JPe3t5Jy++YJmo3sTE6k1p1PiROXKxIZW2ZsbpikbfpfbcyfyP+Oks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225206; c=relaxed/simple;
	bh=W1eepay6lE4b+JRy548CGUdWIHMweKdbISKLVMjITco=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EnQHQ9Sbb6Kf1m7hSMSwJe/x7ZJVHbzE92ZXj1L1cpDVtMWKfGsodFYTqrTXypU+R5IWA62hjFHuE0N1MksDlJ2Q8WgHm2CeZ1jmVYZb/ep51IxHyRSgmhq5vMrUMLflKv1XLIgXFO295vP4mr8xzAsJ6Xz52DR7yufrawezCCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCVvCDg+; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742225204; x=1773761204;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W1eepay6lE4b+JRy548CGUdWIHMweKdbISKLVMjITco=;
  b=gCVvCDg+/KvI7SeCWysbM+c+Kb4GUcAtNjs3WiChgXZOK7zYdg1blAG0
   EliFjHio8L5oaboTlTVPmixhdpyY7+W2FpoEJxMrBEEz67k6/mhAvdwtX
   D/CyJhOXc9JfRHQGnqZuqT/oRv0KVcQos4Kibky4vmGTEBBQkxFliam+w
   QJD70byseNHpqGNgqwyApa6qtvy5+0ghivczKJ6wFEiMv/thzwpAovyTY
   +2l3B6jOKliZffDw0IeP2Vv+M5GcWkLrT6xryIuIj6nOVN0wKwCZPcGsT
   Y2Uw8B81+Fz3RabpE2qn3g2+COvtMiz0Qtgfo0s/vzuZLlKh3c14yILkw
   w==;
X-CSE-ConnectionGUID: uOZzFq6DTG6BYTBgdOOfuw==
X-CSE-MsgGUID: 6Spzy3qjSOef02goR0WKtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="65789849"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="65789849"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 08:26:38 -0700
X-CSE-ConnectionGUID: Y91+bUq2S7ydf7KjBwpYoA==
X-CSE-MsgGUID: QebGlAERR1u13llFfc1zzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121695841"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 08:26:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 08:26:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 08:26:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 08:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPyRy7ZzsxKYhgFJtpeQN+XXnffrtzUPV0iRVmPjkZD2dd8vpsfP8y2TwD0G2cEuCIPoXqnVEUmKjmu0GZYw17TULYL+kisyD5fALwKGEQM3XZ+KUpQEOy0jyEr5rLDWaqydrjiLJYzI1uSBv91wFGLfP7pEJkIbJscSQm9uRB1JDY/p87uZVdJNhejYYK3xK+BldL0fu3uYMBpK+qdryHzh044d2xT0VZ1cx2lyuI9BsnBRH9/W67r237bx1lCC3yCU9PKULCyDXuldt/fJ+StW6gg264geySoqMHEsFp69i2/R/PiunecGsqrieXUC8mUfloarfwPMAQnF4qpr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQVohaY0LOeTm1pIT8iyKUZ8QHiG8O6GhpkbXYqbPNk=;
 b=uCwMkfm4v2xxf02av7U1ZGA1ZY1pX09cNdjnooZmt722tCBUiQlDRY+HSF67lgxpUiq2DEH20L3ZytppzdrJ+tT1vuSuNPy+kP/8SkYWffgQJQajoWPMmf/1hKo1FvH/QVesE5CZoTvsAWOIJzyxxo2p3tIGFF+KR24RM8H+bP0G8KVPbAhnAJ0LOcZF2SB/FMnRwCfSfGwMD+XZH848G1quDD9pYbMgFWDtoP0nRQ/NglISiHO8NugiC9WLx08qpZvkBVtPzUIg/MDf4YDF1cZOG9Gtc/cox9md6Yn8LzyblY21On1cQI1ugxc4zmdtoR36Sm9iAxp0LG1bSv7SKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN2PR11MB4744.namprd11.prod.outlook.com (2603:10b6:208:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 15:26:10 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:26:10 +0000
Message-ID: <fc94190c-3ea1-4034-a65d-7b5e8684812d@intel.com>
Date: Mon, 17 Mar 2025 16:26:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/16] libeth: add a couple of XDP helpers
 (libeth_xdp)
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-4-aleksander.lobakin@intel.com>
 <Z9BDMrydhXrNlhVV@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z9BDMrydhXrNlhVV@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN2PR11MB4744:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df25010-44cc-4c92-5882-08dd65680b9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUhZMGM3WEZrZUNHQTMrOWhtSEdLaU5EUUdmakoybmsrd0tlZXBjdlNRN0Z2?=
 =?utf-8?B?ZUlkVmNxdXZ1dVFFOFV3Mmd1M1FLQzk5WWlkcXdzU2x3TStiSU1PWjc5Mjdj?=
 =?utf-8?B?eEdNcHNpVEMrb3BEZGNDbDlHL3IzTGpjcExWSjE1ODZ3R0lFbnR6WkFVQ29V?=
 =?utf-8?B?RVhybzVzdTh5K3hxbUYxM1V5MklvV0lCZVFKcGlxWDVGMndKcDlYMFVMUWpU?=
 =?utf-8?B?N3B4RE9NRlBvNzVNMUdjUzBIeWJUYU02Z0NHNGVvdzZaZVF4dlNpa1phdWVU?=
 =?utf-8?B?RHdFc3ZUTnFocFlLZUpOeUJvZy9zY0FqdThtZStrQWk0TmhHMzduS1U2eTcv?=
 =?utf-8?B?ckdLOFF0d3hBMFdET2NJM0lGR0FzNis2WDdEbHp5bnV0SXBNL3RNOEVJSHlo?=
 =?utf-8?B?RU1OQWZseDBRa29HYWNhZVhDUzZ5dWlxSVo1VW9KMUlhZVJLWDc0eGNoUWU1?=
 =?utf-8?B?SHJCd0ovcnVZckpnUHJDZmVqemJUSDRqMStzV3BjOVdrSFNvejNKaVBHTHoy?=
 =?utf-8?B?T0dwSXBsbUs1dExBTmRUWGRkemhvSnRCdFhibFZ4clVObXFrR3VNQnpCazBz?=
 =?utf-8?B?cXVKMHVDU3IwNnIvNFJZWEFTZUZtUmZQSWNTU1p1bXkxdkJPL3dwbytEcXBs?=
 =?utf-8?B?L2RiK3lLYkt3bFR2UkY4dWlrTHBJWWxJc3JRZENRRFhGTFJZTWhydGJlTERE?=
 =?utf-8?B?UTF0NCtvaEpEdlkxVmpVdWN5WC9WZXB2aVNOS0FRL09WeXprL2hjNUQwQWdp?=
 =?utf-8?B?clUxQW5kUHBvdkw2bEovVXJnWTI1UHgyUzc1dzN2ekR2ZnFON0J6ODJweS9Q?=
 =?utf-8?B?M09haUw5KytqZVlJTmpVcUFQSExPSTNxemZBZUp5Ry9CNERRZlkxcGJ5SXdk?=
 =?utf-8?B?YzNoVFNlaThKQmlydlorak1NMGxqMTcrZGljc0g4bndDUWMyYzBMQWJiTEQ2?=
 =?utf-8?B?clhqNmpzMEhDSmhPbjlFVzZmNlh2MGJVYWl2bXcrbzRZZlU2QmVid3B5TXA5?=
 =?utf-8?B?SmwxREI1c2pEbXZVVmYvWkRrSm81Z0toSmY2dUFjTVRmSG9MZlEyVUNrYThS?=
 =?utf-8?B?TU4zQjYyNXNqbjJYQzYzWjRRZnhRZXFHdzFVSmxma2p4Q0tmSlFyTkdKbG1k?=
 =?utf-8?B?TTd0Vi9qa2VsSmgvcEhMR0RRS3dXYUMwdkpCdjZ0eGpkWFdLeWVNYjFBVW5R?=
 =?utf-8?B?c25jUFd1Q2ZaSWRneFcyZUF6QXRnSU1wMDdHeUQxNlBTazBBSTRJTEhPYXdM?=
 =?utf-8?B?eEVWZnYyNC96c3hoTWNSa21uczZPWGxBZTdpa3BWRjByNVh3Z0ZqQm9UWVJa?=
 =?utf-8?B?L1I2U2ttd3k0b2FzWithNXdTbkZ1NCthNGQwT3YwYWJkVzBTQXpMWFZxZkRX?=
 =?utf-8?B?amdxVlJXbzRJc00zNUx0OUMrN0NLd2RUak9ReU5aWnFEZ2JxQ3ZaenBOSmdF?=
 =?utf-8?B?Sk9PYWlKQ0p0Q0ZVeEV1RDBnUlFKeTRtaVl4RW1XaFlvUmwyakZRMzRBMS9N?=
 =?utf-8?B?RjR1WkFJMThQRDgvUDU2RTR6UGpzcHpKRUR1Wjg2VG5jVEUwMjY0V2Z2WnFB?=
 =?utf-8?B?TU91RDBralRab3Q1eXlydmFqaTBEWUUwdFBYT2JXWVdhd1ZSQlM2RFVmVEtx?=
 =?utf-8?B?MGxmdzN4Q2YrTEhrMytYUjF0SmRyczh5Qk1JRkxSY3JVMHVUajZ4SW5mRkVa?=
 =?utf-8?B?SlBjdUg0aCtUaU1qcGZVbGRFSHAwSndEQ1hUbXV5QVNoTzBqQ1k0Y09TQnNS?=
 =?utf-8?B?WmEydSszSHNLTHNEeE84SFdMYzdoWFB0dUM5QzFFQzBUSzN4NWkrQnBtYmY5?=
 =?utf-8?B?YUMzYXhGZkI4cjhKVnBpSVpTcFVjallIeUs3a1pJQ2t3dDNEYjRVb0lMM1M1?=
 =?utf-8?Q?FzSx7UOZz77rR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjYwcFBzVWpvdVlzb2ZndVlxcVBiRnJpVEFiSEFJREVydEJBYkU3RWgxNTdj?=
 =?utf-8?B?NEZDZS9xbzFhaklGZWhEdXVGZGhGTjdFakVVanFacTkrRDVZQ2YzY29lTWlh?=
 =?utf-8?B?UnJoS1k1Z0M2alBCb0xHR25kbGE3ZUlCYkx6YkxyeVRiNjM3engwR20zQnZO?=
 =?utf-8?B?UCt0RTRicHlETXNJOUVXL0ZOU2JqNDN3MXRYS2lXNjJEUEV6bjFJTzlmMnJi?=
 =?utf-8?B?YjhSNXVPQ3FsL1RQWlg4TThZMDRtL0c4aEswQVR5MzA1UWV6M3RTdmlHYnNJ?=
 =?utf-8?B?Z01saFlhQlNkYmpKZXdqV0swa1g1WVdJeG9VZ0Q4N1lIL1IrVkpVMlZ1Z01K?=
 =?utf-8?B?d01HNEZIeVhJQnNSOXRqc0ZUSE1ZQTlQdG9VVjNWeGFlejc3NlpBTnJDTS9i?=
 =?utf-8?B?WnZqdTFnMlNpRkdsYng5NXQrOFNwY29VajRBNGZ6SEE4SjM5QUhwQWtOd3or?=
 =?utf-8?B?em91ZHNHZTg0T3hmOGlxRVZSNHdad29tenZ4NE1MZEpSdFlzeFZhenFaOHBO?=
 =?utf-8?B?RVJMNjgzZStzYThqRllxbVFLb1FJU1E1K0Q5M1JrMVBTNGNtWGYweGRnYm4r?=
 =?utf-8?B?azVTVXZEcXV6WGJiS3VzQW4zeVJiRERZUHZQQnpLaVl2ZHBmZWtUVXl5elJ5?=
 =?utf-8?B?OEROZmNySFJFUElEWTRKK3lzNmN4c0pGTjFiSHhMZFRzK003dC8ycDVEVHF4?=
 =?utf-8?B?Z0k3dUR3eTk2aFVRTlU3c3lFblBaa094Ynl2RFQwRWlnRFdXSWhwME1wV2Q2?=
 =?utf-8?B?V3RjZG1pZHdoTDljS2s4dWNoV0tnZFJSR3VDQlkxU00rNkJlV2VNanR1bFdN?=
 =?utf-8?B?cE9qajFMNXlJMDVGZFBwRkRvUllXZDY5L2MxNFVvT1B0VHFWNGFCM20xU1M2?=
 =?utf-8?B?STR3RnExRVRRZkZGc2paTDVzVDRsa2FSOUlFak1mTGdONUFxZUNNY3ZGT01x?=
 =?utf-8?B?MFEvbmdHTjZvSzlSZmJIZ1kzSlp0bkR5bitMcm5uOE56VDdQN1lYSmdZVmxn?=
 =?utf-8?B?TldRVHhLcDVoQ01tTkhkUkNKdC9JeEJ3eUdDUFRPMG85WWxNdTJ5d3Y1MjhF?=
 =?utf-8?B?eGNhYzBDWGVzWTVSclBMODVIUEhKMFVtMzBZdWJyNU1XZzRIT0dTWldVOTJn?=
 =?utf-8?B?QnQyblAxSy9zaVVqNlAzLy94NGJjS3FTbWlOeTJWYzNvdW00YUc4RDBZcitJ?=
 =?utf-8?B?TVZEdzlmZDZiYmFTamN0WE5tNUJZNlRvOTZkUjhpbEYvQmdONEpXZTdxMWlI?=
 =?utf-8?B?NG5xTnV2bUxlbUF0SHF0dmJTMk5tN0IrcUFpUWxxVTVHQUMwNlA4VzZPcCsz?=
 =?utf-8?B?bHUxMkZyYm1SZmV3dU1iZGE0ZDd2cXpvNjFPMmxCM0dRdWN2RnZvZ2ZWZlJ3?=
 =?utf-8?B?alMyd1pPdU1PTElxdkhSWitXU1JJbzlnam1KN0hZV0IycXAzeVhkYXYvclpm?=
 =?utf-8?B?WFdYSUNrTUo3RVZXOG4rbnVxeUhYaXVJRnA5aElUZHJqWjZkVHFCVkdhQlhr?=
 =?utf-8?B?YWFTTk83VjJzNlNkRFY0OW8wdHVhdmp6RDA4THNRKzZQRkoxc1dYUVZTZk40?=
 =?utf-8?B?NFljT1lodm1mbHNGdnFpK0M4TkI4NXZUc0NZc1kzcitsNkVJVTZ0UjdjbVk4?=
 =?utf-8?B?TFM2dkRFcVc3UU5ocExNYkIrM0FtYUtLY0JNWVU5bGpPa2ZCUXE1Z1NDVlJK?=
 =?utf-8?B?aHAyZ2FkYTd2aTRUb3F4bGJicCs4b2lhajdSd1RjNTcxM1l5cUdKZy9iUlVM?=
 =?utf-8?B?Wkt0ZW5mQWZHeFhRazhCNW1wejlFcllVNXBHRm85ZVRBeTVMR2xpMi8wc0tC?=
 =?utf-8?B?dHpVeHhKS2t5YVFDdnpnSjRYVzE5Z3UyZlNPWkc0ZGgvRzRoZW9BbVVvc1NS?=
 =?utf-8?B?S21JTlAzeUJ6MkxqY2E5SjVZZE9tS3BlM2VCSWVpY0MzWXhhd1lWcTg5cnJ1?=
 =?utf-8?B?c0w2N2l0UWNmalIxSkllWVVvV29OL0owbFZkclBWcElDaitWNGsvaitEUm5T?=
 =?utf-8?B?ZmxIZnlnVW9ERlBmN2d2SXNQQjc2YzNaQzVHWUF1ZlRyT3d5cThYNFNJQW5h?=
 =?utf-8?B?Umx5dlJvbzJMS05jMGY0RFNVVVZ5OU41eGRNOWNQZk5vZGVzL3ZuQ01QL2Nh?=
 =?utf-8?B?eEFOWXFSMHM1MmVscVRsdWFscVlvZlhFUkpZVFZJMjdyNmJPYitJdDZMS0p2?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df25010-44cc-4c92-5882-08dd65680b9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:26:10.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFeCfFRObXd29DlDxBArUeRSoaIro6RxMytbTzXWYBDT/hOnOQuZb1bFHgY5WYda3bAGtI7AzI5+hBCKUConJN5z95fMymV7w18hWS9LB6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4744
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 11 Mar 2025 15:05:38 +0100

> On Wed, Mar 05, 2025 at 05:21:19PM +0100, Alexander Lobakin wrote:
>> "Couple" is a bit humbly... Add the following functionality to libeth:
>>
>> * XDP shared queues managing
>> * XDP_TX bulk sending infra
>> * .ndo_xdp_xmit() infra
>> * adding buffers to &xdp_buff
>> * running XDP prog and managing its verdict
>> * completing XDP Tx buffers
>>
>> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # lots of stuff
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Patch is really big and I'm not sure how to trim this TBH to make my
> comments bearable. I know this is highly optimized but it's rather hard to
> follow with all of the callbacks, defines/aligns and whatnot. Any chance
> to chop this commit a bit?

Sometimes "highly optimized" code means "not really readable". See
PeterZ's code :D I mean, I'm not able to write it to look more readable
without hurting object code or not provoking code duplications. Maybe
it's an art which I don't possess.
I tried by best and left the documentation, even with pseudo-examples.
Sorry if it doesn't help =\

> 
> Timers and locking logic could be pulled out to separate patches I think.
> You don't ever say what improvement gave you the __LIBETH_WORD_ACCESS
> approach. You've put a lot of thought onto this work and I feel like this

I don't record/remember all of the perf changes. Couple percent for
sure. Plus lighter object code.
I can recall ~ -50-60 bytes in libeth_xdp_process_buff(), even though
there's only 1 64-bit write replacing 2 32-bit writes. When there's a
lot, like descriptor filling, it was 100+ bytes off, esp. when unrolling.

> is not explained/described thoroughly. What would be nice to see is to
> have this in the separate commit as well with a comment like 'this gave me
> +X% performance boost on Y workload'. That would be probably a non-zero
> effort to restructure it but generally while jumping back and forth

Yeah it would be quite a big. I had a bit of hard time splitting it into
2 commits (XDP and XSk) from one, that request would cost a bunch more.

Dunno if it would make sense at all? Defines, alignments etc, won't go
away. Same for "head-scratching moments". Moreover, sometimes splitting
the code borns more questions as it feels incomplete until the last
patch and then there'll be a train of replies like "this will be
added/changes in patch number X", which I don't like to do :s
I mean, I would like to not sacrifice time splitting it only for the
sake of split, depends on how critical this is and what it would give.

> through this code I had a lot of head-scratching moments.
> 
>> ---
>>  drivers/net/ethernet/intel/libeth/Kconfig  |   10 +-
>>  drivers/net/ethernet/intel/libeth/Makefile |    7 +-
>>  include/net/libeth/types.h                 |  106 +-
>>  drivers/net/ethernet/intel/libeth/priv.h   |   26 +
>>  include/net/libeth/tx.h                    |   30 +-
>>  include/net/libeth/xdp.h                   | 1827 ++++++++++++++++++++
>>  drivers/net/ethernet/intel/libeth/tx.c     |   38 +
>>  drivers/net/ethernet/intel/libeth/xdp.c    |  431 +++++
>>  8 files changed, 2467 insertions(+), 8 deletions(-)
>>  create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
>>  create mode 100644 include/net/libeth/xdp.h
>>  create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
>>  create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c

Thanks,
Olek

