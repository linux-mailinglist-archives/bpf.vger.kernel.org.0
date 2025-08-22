Return-Path: <bpf+bounces-66285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB92B31EAB
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 17:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A8C179D4B
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392F212550;
	Fri, 22 Aug 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVYx8cp9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3601F91E3;
	Fri, 22 Aug 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876608; cv=fail; b=fYRzbyL/RlCSUnPpxKIFVFPuDaSyhvlPkpN07niLkr2elGFdLSBSSdxUWr5QFMdrb9YwfuxGVCqN8DVEw/WXaCNK9LDo3fwaPeoXxMPq0ycn2rR+7wcJojfmghoS8yoEhuRIMWmZ7UtY8+yRQ9d7a+Vor5dmoGyS6UfCU0GChFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876608; c=relaxed/simple;
	bh=lTbFMAZRNeOrWXKRKBixYePJ919W7m7DnbpLGRJruxY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0+ULxSoIh3ZysW8gmeTOra9ZTBisGwqSMkAMfkHD/bLDQf/W972FGZJhvf0zolKZEhSCWwz9Uv8IEYMtIi3SKTJkRtIvMCWLvOHJDpFI5rjRI1uVxa1mPrCILNRhc98nZ29oJConr6Y/0aoBZrNboopGpEivVaAKfIyl0Po/rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVYx8cp9; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755876607; x=1787412607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lTbFMAZRNeOrWXKRKBixYePJ919W7m7DnbpLGRJruxY=;
  b=hVYx8cp9lJp8ymQHBNDjv4M7qEtGjqnKax1hXgW7XQYCycM7zuVPQjmV
   V1jBKzxWX+GLI8KPYyiS7agttXXFFvGB1NfVLNuceIW7MdMyQvl8zzIUc
   qxn6/OX0VymSiL2WzlgugUDgY5VdIhR2Kdy++qdmQyAruw0zPHcxMplQI
   FtXRwiRHkknfABit01c1wZQWrfXzUShW2pzz7Tut32yKZh55QhubZonnT
   5lyIkdRw6LC4QZu6XI48moJAqU52r0vZV13CIl/n23d5QKd9lHSLMzHKV
   3EQpGIpWj6ez2yfAGYqRM6rB5vnn2EERQmkNzyJVRHdS4NnfO70qrU8oT
   Q==;
X-CSE-ConnectionGUID: fbc++4quSZCp+y8/6qKSTg==
X-CSE-MsgGUID: o0ghCl1jSJWzSWA5uhXDNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57896855"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57896855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:30:06 -0700
X-CSE-ConnectionGUID: eEPzUChgSzS56XS2jBopug==
X-CSE-MsgGUID: 97LSy0o6SqabahhOYzT1hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169556666"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:30:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 08:30:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 08:30:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.53)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 08:30:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE7BU5j4vH8tR8e16cU37UtJpoUVAX1D4x0z0clXTWZ1Gg8ICbEyjdJ+GL26tHnJmwKXwXKvVbTE1kCnqNGfq8bzX6dMDi2y1wE0uTsHviBf/l4WvhPPefGXZVlHfXw5hviHdSrOT3wxDu22+oPxa4zsGf4xhpq89kDCJZcHp9CPBEb6oC6Qa0GuAsHYRSLavsUc1A1xO166i0mmDBVo8cvN/VqZsQNMGWpeflhvdSbH1u83ca8Cua+OoLvcn/YyWBzplsH3AMlGnvVV7HCsGNeTFDugrC6JipKDu9XWyyXHQjJso2WDaomTrBjvMzp3Ceg2Uvd/OlULCoJzyB1B0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTbFMAZRNeOrWXKRKBixYePJ919W7m7DnbpLGRJruxY=;
 b=gPGyeaGtnTMDKbQBD22G96t2IWGPGWftfARWeyVqqMJqShPtWiKvWEHYA5hDxOF5zM7RxPhbDxrmhg3jpJTy+DCF3Z3RIVGjE3HlZt0J9Ykt59EI7hsJsOOSrAQi1zflwOZSNvRvxyk6XTLn/5jkobpzcKq4N0meQzrDZ3+UEypZ/Up8yyBY5jAJgeu3o3yFkQELiEZvj9fVET0ADPKkbSlCCTDKT5/iEaTLD0fqXka5dIiuRbOgfjxcW1gj/MKCH4grwGC0SpNSNpJoMZnTKshRbSlBG7RC0VnXyN0wtMfm82S+dqJRKzn9X+5FKdpJThGGtpEuAF136hpe3WoQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 22 Aug
 2025 15:30:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 15:30:01 +0000
Message-ID: <554a93a2-8831-4403-aa0d-31c212bc27a4@intel.com>
Date: Fri, 22 Aug 2025 17:26:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 00/13] idpf: add XDP support
To: <intel-wired-lan@lists.osuosl.org>
CC: Michal Kubiak <michal.kubiak@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Simon Horman <horms@kernel.org>,
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250811161044.32329-1-aleksander.lobakin@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250811161044.32329-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: a93558c1-194e-4325-93cd-08dde190c29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck5vRko0dHhNenNCOXA4VkFSclQ3WDdETmZBZk5Ld1NxQktCd3pKcE9JRkpm?=
 =?utf-8?B?OGhJMzVuQnF3alU1V3lkcUZnNFRheFFmdFZOMmNqWVRWTFc0THByM0M5OHM0?=
 =?utf-8?B?Rm8zbjdqeHkwS01oYWt0T0Z0RGV0ODYvOTBiVnd3TFhCRXB0OW81OWtoMnZt?=
 =?utf-8?B?NWwwbmp0RHdXb0VxRUd1K25taUM4Y3hsTnMvTlk2eFk3cFMyNmZqNXFEbSt6?=
 =?utf-8?B?d0RqSHZiVTIxbUk0Wk4vVWNPTTVFK0Q3Y3ozTWNXRXFiYmtWNDlqb29jZ0s1?=
 =?utf-8?B?b2ZYdHlTRFZtdlRablNqeDNzcGZrNkNZSWxYSG9PMFZQdW1yVG1MeTNPTGN6?=
 =?utf-8?B?d3JjN2Z3THBoWFN4S3NjYlRESFJpcVhsZWFoZEVCVEdOOTRhTFZpZ2t1YWtL?=
 =?utf-8?B?VUh5OXJ4SlFtWTcvYTE1SDJoRU1PNDFUaEdvR2tPQlBEQmxranhnZC9yYmhz?=
 =?utf-8?B?N1BZSGZmZi9PbzBLL0FIWFkyd3A1SWcySU5NN2ZpNUJIeVJ4S21IMDJTMlln?=
 =?utf-8?B?ODBJL1RkT0ErSW1vdEFST0FSTE9yZUNtTWxvSXhmb0tqdm13bFJKczRpcnNq?=
 =?utf-8?B?RG43YS9Dd0tXYjRQeVZtN2FJUGVTOU55dm52Z2hVR211eWQ1eHNyd0M3dDhQ?=
 =?utf-8?B?cjhNRFlvQWg0Qzl3MTMyYnVwZEpkVnZXT3R3RE1SRTV5RGw2QlJNdVp4K0hk?=
 =?utf-8?B?UTF4QkVGdkdjTHVMLzROS0hZNUhiS2dobnZwUU5jTk9QL1czV3FWTHJ3bmE2?=
 =?utf-8?B?ZWovMUNGZzNUNFVETE9KUEpQdTBuWlFhTUFtZDJTTHltVXFXTzFmbXVsR2hV?=
 =?utf-8?B?cUttNVBJLzFMRjB0TVMrTmUwSEtoS2N6cW9xUHNzNUk3aGZzT0hJakg2d3dC?=
 =?utf-8?B?OG80ekNXby9lQmM5NXlRN29uWFF6dmRGbzl2di91S2c0VERWRm5hRzhMNE5N?=
 =?utf-8?B?c2ZTMzUrMElJeVk1NWwvN2dGSzg1cVBmYTFJeHhqMCtnN3Rqb0NSNmExWjMy?=
 =?utf-8?B?VVJBYXR2SXlBNnpMVVhGb25FdmRXSkhOdzdKUUdXeGlVN2hlcFBha0ZBalJl?=
 =?utf-8?B?eVFVWVJwaHNicFM3Z2NRMEt1dXIwbFNhQmdiWitSdW1DYjZ2VE9VYkxDZHh5?=
 =?utf-8?B?S3R5UjQ0MmJld3FQRk1ud09HTUtDT1hGL2s1WW8wQU9OZUwxbUpOUGNPYS9C?=
 =?utf-8?B?SmVrM2FaYnVvTTlPbjlTTHQ1aDVpci9jbTAvVU0wbEZPM2xRZFNZVnl6b1lt?=
 =?utf-8?B?S3NWNUx4RlI1d0poekpRT0gvc1UrOVNPTmJLU1hqYUVSMGJ5dk9zTE5NQktQ?=
 =?utf-8?B?M0pmYm5KMVV6MHZOU1d4ZXNBWmFHdVFyNXk2YTNKYkNQb29GcFhzcExFUlJu?=
 =?utf-8?B?WlNuWjREQ3pUVTRMM0QwWk1MY1VNTnNDNktQTDZnc0l4QlQ0Qk1nZ2YrNXoz?=
 =?utf-8?B?SjV1REFGWXFlQ2Nla3pURW1UcnBpUXNkWlF2am0rckhqdHhvV3BJb051RzhD?=
 =?utf-8?B?Z0IvVWlqT0YyZjIyMjFjZi9QTUY0RklFUmx2SW5pZVRiZ1lUY1EwanhTWHV6?=
 =?utf-8?B?TXhER25xc1hVVytuUGYraVp0RlRjWG9sdFRraHVXYnN4ZzIzWHZQb0l0QWFh?=
 =?utf-8?B?NnF5aTJDa0tvZUkyZFcrOEpaTExqN0pSd2MxeFFpdXlodGgxZWg5ODhPOTJO?=
 =?utf-8?B?ek1ZSE5Kd0RRMFNWcWEwRy9PVTl3ZjU5cjZiYUtOU3hlUGxQZDVIMjlJeUNQ?=
 =?utf-8?B?QlVVa1h4UkZLSTBNUUNiUkVxYlRVZ0lFNk1KdXRpNDFzZHlwMUJmOXpzTG1L?=
 =?utf-8?B?TXloalQreEZ0WEFDeldTUHVGRHJQcTRmM3FlSHFTT21sMUNXVG8vRHd1VEtj?=
 =?utf-8?B?ZjBtRWpNQlgzTjMySmtSSlVoQm9QeHBZMjJoNHBqa0wwSGl6ZVZoSW1Xam9X?=
 =?utf-8?Q?KQ4Sd1nXGQg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFFUmc4dWs5dTc3Q2VlbkdWMSs0T3RhT3h5c2QxdlRqQnc0UG5FcHg5Q0Rw?=
 =?utf-8?B?UUpJc3drVHBlenV3VzRHZVNFQ05WaktEcStXbCtQMkwxSjY3VW5GZUE1dUpE?=
 =?utf-8?B?aVcwN3I3NDhUVXp1dm9jMGp6VjArUk03SXJBd2xDSk9SRXNDeW5kcVh5dCtk?=
 =?utf-8?B?TExYYWZwM2l5QWc3Wk1rSUxGY0xSeUloWGZocDh6WjNHeW1Hd0t0L0NDaEN2?=
 =?utf-8?B?Q2pWVVNHbEFZclRwcm1lOWpFZXZYMTc4Q1p4ZVUxSVBCTkJUZm9FSWdIelNY?=
 =?utf-8?B?eXUvcm43WnU1Qk9LOUJZTk54Y1p0TjVDREFSNnAreEhIdmFjc2d3VmNvL3ZN?=
 =?utf-8?B?MjBIZTlLN1hMaFlrVU82aEFGUW1DVFRLWjA3dm1Va0NtVENYVEtjSUZnV0tW?=
 =?utf-8?B?SFkyNDR6YmVpby92WXpzTmdqTEw4VUJaTTZKMjdaZHJVTUpSdGpCUkcrYysv?=
 =?utf-8?B?ZVNNNlc3N2ExUHFRajFvZmNDbWNVVGc1RUJFaXZ0RHJybXdmV3F2TXoxQnpo?=
 =?utf-8?B?TWlTbkZURDcwNHY0OHBFNFdHamxBaGdPZ05xWElRQ202TVo2V3RhN1Jxck03?=
 =?utf-8?B?M2xLSExQMVBOWHBIZEhxUVJIbG5Iai9rc0xVT3JrQ2szUXQwVzIrMHI1dzZU?=
 =?utf-8?B?NVJqNVVIWXY5dDNBY1Q1SnZRTDNXeXViVE1GbUxrWUdNL2NTaDFmTFFEVFE4?=
 =?utf-8?B?UzRPaDdzNGxCNUpuWW1Sd3JPNkNXYlIzR0g2NGhyd0lldTY3bi9tNnQrOE9C?=
 =?utf-8?B?UmQ1U1o4WEtyakxQWCs1dkhlR0hGcHVTczJhWVBtd0NYamVFdkdBQmZWRUxk?=
 =?utf-8?B?RTUyMitOaWZKTzhVWURHSlVQM0pEMTFxcU1aaDFXUFUzdDZ2UDVDZU81cTI3?=
 =?utf-8?B?dFplZEZPNHVweUFpUnZUdDZJNE1HRUJCb3hma2ZtNWpvL0FYbUhoZ3Q0ZG1q?=
 =?utf-8?B?NDlNSEc5ZlAxbkhzbTBBWWdLNGJ1VEZLUkg3S0VyaEJpWjRiTUxMMWd0NGRV?=
 =?utf-8?B?akVUd3ViY1BvRjRwWDQwSWJZZ214TVR3YkJpL3dpTlMrWlR1WUJyN1BraUg4?=
 =?utf-8?B?V1hIQVRhYkorRVFHSnZvQmNaSk4ySkFsN2xiN1JIampCeHFqM1lxdlI2VmRs?=
 =?utf-8?B?QmRIQ0FoWTJCRWVnUEVjbXRkTC9nTVlkWWw0SVVUMm0xVkpJOUYyb2t3OHhq?=
 =?utf-8?B?OWwwa2VVRUVuVEwyM09nc1BQQ1V5azVBOXd5SzFreUZ2QkhJNDVtK1c1M3Bo?=
 =?utf-8?B?U0ZOUSs1dWFIaE1OZW9ORlBTbWREM0FCKzltR05QcU9sZUErNXdaZGtQN0Qv?=
 =?utf-8?B?bTZCdkNiZ3dsbVRReWQwcXZSd2UvTEF1N0dibVZPWE9QQXlPR0RwYWJjUXRB?=
 =?utf-8?B?L2YranlKdzhmajhQa1NQK3hGRWVCdGRic0JRR1VlVE9TanpPd3VzNlJ1em54?=
 =?utf-8?B?N0p5YitBVVQ1Mk1zaWJmdVp4eEYvMitodTB1dkNBODJSQjY0dllzQUt3OVVH?=
 =?utf-8?B?eWtlekY4WG5HaWVQeXhuTDErK1c3bHZIQ2tqczBXVk9haFJabG85VEFQa0d0?=
 =?utf-8?B?K1FHUDU5ditOaFpjb08zZnFDYkp0SDlGOENWT0syOGN2MGRVQ2x2K0x6WHdw?=
 =?utf-8?B?dDZCWU56WE1GMXd6b21aM0tYblRlWE5uSXkwVnVQM1F4MVdSeUZwWW9BMHBJ?=
 =?utf-8?B?V3ltYmdra0kvSXhqUnFDYXNMSWZiMUs1ZTlVY29LWWdLb2cvWlVtUUliYzlV?=
 =?utf-8?B?Y1BNZjNWRnRnSjFST0VTQ1FJdk5uSlJQWlg0clp5a2swUEpsUWp1ejNCR1ZR?=
 =?utf-8?B?cm5BemZWNHlQQWdFNjNROGZ0K3BxTy9XUUdjK0VuNzA3cFNReWdPbmhyN3U5?=
 =?utf-8?B?UmpzUk9sOW1YYzRXSUF2OVJiclFmbzN0cElyTGJXdEd4RlkySnlYWCtUS0JM?=
 =?utf-8?B?Q1dSaVBEUjVpckVsVHVMRmFRT0JUQXQ4UmkycmxwUmlNYkIwZU0waGR5UEhS?=
 =?utf-8?B?ZEdNVDZiYmRtN0lRRUF2dGtoNEo5aHByTkZrSDhPb0Q5MVErcmVJR1ByQ2Jn?=
 =?utf-8?B?ckppdHJVVUFWdkQ4V3ZmVURxSFRzUHNQWDMrNEFkeWVIcFIvSEZhbGVyWkI2?=
 =?utf-8?B?ckZFbjFlNlVTUWVJZEFIZTZ3KzJ0a0hJQkt0TnI4bDVIZ3ZlbEhtVnYzaUk0?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a93558c1-194e-4325-93cd-08dde190c29f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:30:01.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrUCnjmMCkAK/a52EAWZ0Kl7WAbqINC5Oe0mYPhpfFv8y5b1y1JUcTr5xoIbZtNTwui5L7ODKFJmfqdAfjclosr8TGb685VS64jSLFOBOKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Mon, 11 Aug 2025 18:10:31 +0200

> Add XDP support (w/o XSk for now) to the idpf driver using the libeth_xdp
> sublib. All possible verdicts, .ndo_xdp_xmit(), multi-buffer etc. are here.
> In general, nothing outstanding comparing to ice, except performance --
> let's say, up to 2x for .ndo_xdp_xmit() on certain platforms and
> scenarios.
> idpf doesn't support VLAN Rx offload, so only the hash hint is
> available for now.

Our validation found a couple minor issues when working on a VF, need to
fix them =\

Thanks,
Olek

