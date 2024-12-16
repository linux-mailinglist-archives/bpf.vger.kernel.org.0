Return-Path: <bpf+bounces-47041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE19F3522
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 16:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500001889BC8
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1FF1547EE;
	Mon, 16 Dec 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2ZKAGGb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1553E23;
	Mon, 16 Dec 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364742; cv=fail; b=dwIrwmbpKiKxwZg4LJDhgWEyB452p5LoCE4bL5dE3CqQtLrGAOGwIDwBT5l9k7pXRokC7+uaCvlWyDPpIjV4DpRiRgiLag/xCQakeQfgNXbhsBeJMNqaUXtsUR1ngNnQtT/EDVwzDE4yA03sGDK5iUOkmNq7rLwP0RwpVtXksjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364742; c=relaxed/simple;
	bh=o2zM47/iD/FDVmZ9WgsOevde3G9WccH+LOYWHK/u8z0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EwVs5QaxZT01Ud5bqQ7SRedYbTKfNpraowJAGsvEhlqGOo0kdObFMZ/K9bkkTRTBc/T/XePbh3r7ucDOY6nEP5uWyZssVbak3J8nqSvb3ZIHnuqgfVJtQ2ggnzE08pS9u69y5k7sAf+QL7C3kdADlJwanzmB7MUD2TfsRUqUTO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2ZKAGGb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734364740; x=1765900740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o2zM47/iD/FDVmZ9WgsOevde3G9WccH+LOYWHK/u8z0=;
  b=H2ZKAGGbBp/fKJHxnCL8WAz36e6O6GyLoHH6IQsy4T1UKfWMaL/LjTOE
   5fERxZbYfd5uO06S5Va6fi6Y7UvZsVFr8xGmcsl2tg8YqysM9Tl+ECOBt
   ccQC6P/2lyHJfvUm04kUjcCAzD6X1jVK5eiGARcMRAXoJAkCei4GMX411
   ysmXUPxgsFuGcN4Er77Vy7PFFGkt6h30AqZyHnvfB3IFZxgrgqup+yXe8
   lHQgN7brBf8tsS9Fu5ga05EB41IkzgpUvOFYuN9LNBiVUQw+d/PM57eLX
   f6lmkCvbRfiL9OrCUOofs4KIkxcpT2YnbxXQq42BI9vp4xhwGvfLV0HWg
   g==;
X-CSE-ConnectionGUID: bjdVgxocRFOdv+4RVW8Gkw==
X-CSE-MsgGUID: ULSL7v8MRVm+vLhJt30g+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38434372"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="38434372"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:58:58 -0800
X-CSE-ConnectionGUID: QdpFfkkOQ5a2YmWxn00lqQ==
X-CSE-MsgGUID: DHYvjoDyTA+77xJGt1SNcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="102260700"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 07:58:59 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 07:58:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 07:58:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 07:58:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFvqCkokHWibRaZ0+n9mJOs4bYj6roOhSf2dRleNTEejSABHZP3t0bWYJ0t8Yeune4hlPuWpIgx7VvzdVLO8uNHrN4j4Vql1Siy7+NewBZ1hBeeKWxZibv6zVCXMFM2uidAebysk5DhXpI8cWV4UP0PnHPPc+B8c5Q81e3+P8Wpiht38NRKWq6jgRGdB/5H3mDDYhSE6hbJTO1qZXXUV07LJDhew+S3Ol1vVpMPyrQbF0vxW91R2iPWbx1EAnvzEYwRhcMAiYK8tsiXd7fLEa34ITGdQTfo8JJwq+9FCPrG7Ba5OLWD5auIlLIkghm6XWZewMFWwI5XGwDzy4lJpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBV/yema94SuR0sOAtvTUy97Gs3E7SdpBZOyl0v9wwM=;
 b=j2MllX5Z6O4GxEKk2iV789M3RzoIdIAbuliAFxFWEoLD+qOowCmfH6QrR+43K+VlWJ75J1xyo2qwsZn+5bAWbD1LJ3WBAd9tunTG8Gc1HTEvRd61sUyTxYEQV4c4Mdz3qj9TluPhGIxVYn73I4i0ixvsbNIU9twS686OHtrep9BK8s2MKzX9f/S1ZZpJ9GMTpQIoN/W0KZ3V/7IHtuMhqkijSeTY4C2emUEr2oxThCOlBxByRF8odO82w0kHRJsCZCxvYvJ8KDehYdikF8JUaKogPUQenF5FJV5gvwxHkfNlyZdA7rBoyB+kY1ePBszWGcmnKgHvZZ+eC7wsbNX/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 15:58:50 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:58:50 +0000
Message-ID: <56406174-8c77-413e-812d-2639b115a2a3@intel.com>
Date: Mon, 16 Dec 2024 16:58:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/12] page_pool: add a couple of netmem
 counterparts
To: Mina Almasry <almasrymina@google.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, "Jose
 E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
 <20241211172649.761483-10-aleksander.lobakin@intel.com>
 <CAHS8izNEzoeuAQieg9=v7rHp8TCWXyw60UbrZgEm5LCKhtCEAg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAHS8izNEzoeuAQieg9=v7rHp8TCWXyw60UbrZgEm5LCKhtCEAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f21485-459f-44bb-0909-08dd1dea8827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTlpdkp0anlqQjIrdE5TN3JlM3dBZElUbEVqS0RSZmZZUWI1WHlBMnUyOEFU?=
 =?utf-8?B?L1NFY1dwVkhpUzZWRWVOM2c5T1Nqbk44czM3aW9SYmNSQXdRNzZNa0UxMlRT?=
 =?utf-8?B?ZW5td01HMU9aeFN5OFQ3NVV5WXRNcldEdlgvMC9XWHZwajJNclZaSjZPODUy?=
 =?utf-8?B?aHUwWEVhQXh4b2lWUDV5QlJPMVpuL2piWTJwNjY2U3ZQT0pEelVGMXFLeWdF?=
 =?utf-8?B?emtDR0pGckthMjBsaDhORkRrRXJqOU03c01FVWU1T0djdTNLcWlZa1FtZW9M?=
 =?utf-8?B?VFl6YVBKRjMrcnJnczY4eEUwaHh5MVFNcDRhWHJvN3MwNGNodCtDSVdMNHBr?=
 =?utf-8?B?L2ttTTdYSGxyV1dnQ3FpOFpmZ3Qvd3VxcFZLQUp2ZUIra012b3ZwRkhrZHRq?=
 =?utf-8?B?TkFWZUMyRVJRaU5mbE9jMnIwYjliWFo4QVdSM1dwS1VPalNlaGNiTWFtN0Zx?=
 =?utf-8?B?QldyS25IemFpR1lhYmVCV3Jka2RjNFRsV3JDM1E3bGswODBualRJUmVEVzJT?=
 =?utf-8?B?U0VZc3JvNUVMcTdzZkM0ZFBCanVGczdPNTJSQUZ4Y1hEaWdzenJUNmttOUZZ?=
 =?utf-8?B?di8xYWNUNmErQ3BNOHBnYW9EekFCbkZlQTRHMzJZdlNaVlpPd05rQXVPKzd1?=
 =?utf-8?B?eXREZUxGTjZSeFVOZHI2RUU3MGNML3JyK1JOdEJRWlRMYUwxelh6Um0ydDVS?=
 =?utf-8?B?dCtnVnJiN1QxNzVIZ2FOVVo0N3ZUdi9PVnF3Ym5WYjlqQjNZTXhQZDJZSTk3?=
 =?utf-8?B?clF3VytRNEZ3dGR0cUxTWkFqTkhLU1lXWGFLekpYYmpVVVBRRnhZL2dEQ1RV?=
 =?utf-8?B?V1pwMUg0U0l5TWFVZjY3UkRydVc3bEQrVmpSVCtEeTU2UkdienUyMzVLTlBz?=
 =?utf-8?B?VXh4clZ0d20yZGd2M0hvUmllcFlrdDB3c1VaNXQycFRQekJDL0xRazNkTUhY?=
 =?utf-8?B?bnVZWitERTd0UjNzU2MwV2tiRGFHR1ZvUWFDYmIrTUl5SWdlcHB5Vy9PM2oy?=
 =?utf-8?B?ekZMTzlDZzNUanFCeUtKUStqSlQzTFRPbTlYcmRmNEh1MytpMUJKT0lzRjdZ?=
 =?utf-8?B?RXdSZUl3MXAwd200YjBqZnNPYnRVcE5VQXJaMzRuZG9MbEVKMkhMS2p2WWxl?=
 =?utf-8?B?ZW5YWEtMTk9uUGtjUzN0ankvSnMyK25oUmoyczlmRUwwbzVzV1dKKzF0K3gr?=
 =?utf-8?B?RmluOVpvU3RHU0tmMEtHVmxTOWc2U2o1bXQ2UHlUODlXOVpQdTJCbm1Oa3Jz?=
 =?utf-8?B?YjR5MmFOUVY5aGFUMm8wdHdUejV5QkFzUXRFZ3I1QW9LOWNjMU1CREZxMUVp?=
 =?utf-8?B?YmJucGkrbDVJTXIzdGtVV1Q4NTNhbXhYb2ltSTQzM2Jvb2F1YSt1RWVUVzE4?=
 =?utf-8?B?aTI1RGc3WHhiTWowc3B6bTRCVkhVU1VJN2lNeE12Njh2b0M0NUtWYlNUU2Ry?=
 =?utf-8?B?U2tVQThqVDA5dFRMUUtJa3pHdVlvMVhobFhkUGpkblp6KzVpUGxocTE2bDRy?=
 =?utf-8?B?Mk9YckdzMXhiVnFKRXhLU1FpOGt1VUxtMHdOWEI4Vk1jTjJCNWZMdlRSMFFI?=
 =?utf-8?B?RXJkTGRxSmE5VTMrWXNCUVppMW9Oa0JyUzl5Wk81NzhCWFQ1YXR5bGF1S3dn?=
 =?utf-8?B?UjFjNFRacU90S2Q2NWdhb1lUaTRiRHorREFHLzA3c3ZNeHhQVGlkV2lmQzVs?=
 =?utf-8?B?aW9JZXcwY0x3VzZpeVMzV0t5aHFzSy9vVnBtSDNYN0M0UVY2T1Vnc3o4d2hG?=
 =?utf-8?B?NlVrMllKd2E0V2E3eVR4YVRzaDR3S05ndXZVdHRmS24zNzhGclBsb01uNVpS?=
 =?utf-8?B?azV2ZFRReGxsUm4raUhZVXRpYm83MFAyejA5ZWpLSHRKeEEyQkxUNTJEZWhw?=
 =?utf-8?Q?wXjKGIZ+MY/cb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjJGZFdnVFpucERMUUxid2JBcEtmSWRyVUxwUEJsWFZqMDNDK2Zqd2VBazdj?=
 =?utf-8?B?SU1uMXNtYTh4cmQ4cVpvKzhHSmZ0WDRyRHJOZzJ4eTBScHBQWUZsd0hiUmN6?=
 =?utf-8?B?ZnMvYkNOMkxUcEl6a3ZWVmRjV2lackNmWC92QUFTalUrU3ptWk9xa204SG40?=
 =?utf-8?B?QU5LNjJCNHJ6VVhmMmZYTHo5aE9DR2NCYTUzcW5ybEtiN0sweEN3MzFNeXlL?=
 =?utf-8?B?d0psUTN1MXVIN2YxYlJVYkJZbmZlOFNocThIZC90Y0Vmb2RKaWliZW4yVWJL?=
 =?utf-8?B?T25QWFpUNlNEczJRcGlTZjNoelpIKzcySC9hdzBUSmpyQ3BNdExnaCtNR2Jx?=
 =?utf-8?B?bnQ4TEVJejF6VkhGNnk3c1RkbHNKellmaHNYMmZZbm5CYkZhcDZxcnhYeVB3?=
 =?utf-8?B?MzZta2FUWEgxS1ZuSWw2bzYyeXN2THF6QjhWOFFVMndWV3hjeFYwSDBHRTJN?=
 =?utf-8?B?U0RaSnIvMWdFU1N4U2g3VW5WTW81VnpHMmY3aGZGWGdMK0lrUThnVG1zaU5l?=
 =?utf-8?B?Sk85WmpBMmNuZ0NVY3ZoOXBIQ1FtL2hCdDZ4YWNmenBGYmI4MXJTSGs4K1pm?=
 =?utf-8?B?aDMxenhUdTJFQkovMEtIN0UvdXZoVysxb0lVaG1wVDM5T29UeDV2RFQzdkVo?=
 =?utf-8?B?ZVhHRkNIN2kycHhPeXk0bmVEZXVmNWYzQ0pFWTdBSnlyT2JyTGdueWdMallB?=
 =?utf-8?B?Z1gxUndEaytwcWwwS05ueDVYUzJOT0F4Vng1ZFN2RkFURXNVeVdPOG5qMkZ6?=
 =?utf-8?B?cEF3a0ZVUFZYR3FsREFuR1VqQU5wVXJpcTJzc2dkWDlJUFVqM0traUNkb2g1?=
 =?utf-8?B?Q3FhS3JnckZvZHlHbUlmRHhBREdNamNlMEhnTklUZmVtNTRWSUkvQXJxS1p6?=
 =?utf-8?B?NkFxNlZ6S3FoREo0V3BiZ1BkejUrb3Z0SFVrYXBOWlc4YjNsZ1ZabjExSW82?=
 =?utf-8?B?U3d0VnlHMk1Cd2pxbjJNY05yd3VWOGxQUXNJNHFkVk1EWWhrejBZMmRvNkpI?=
 =?utf-8?B?ZnludU1Xck4xWXpzMVk0YzRrei80dCtFcFpVakJOTHZveUN5cXFDNUg1UXdV?=
 =?utf-8?B?S2l1YUZMMGZ1QzRiLzdad2lYTGlQWnYzd2pZcC80ZGhjTDVFeGJ2eXVTYitN?=
 =?utf-8?B?MnYweC9hVFROdkMwLzc5YWxHdHoxM0lVVC83dnJ2MjU3TUZYQXJGNmdtL0NI?=
 =?utf-8?B?NW1DZnZ3ZGl3UkNUYjI5M1F0RVltMjZuM09pcDk1SEZ3cTAraVZYZWZQVVRI?=
 =?utf-8?B?T0k3K1dnV2dkV3pCMUZGWW1aUUpYeG0rd2QyZmtoZWcyYVR3a0VraG5FYjZi?=
 =?utf-8?B?dDdkQnBBMkhkQmplUXNPL3RBOG9TS1RZUk81TU0zK3RxMVdteXlJZ1FDVnNa?=
 =?utf-8?B?VW93YzdLdmNWVC9QMWozZk8xQ1NSeEhrZGtib2g5SmdhOWZxNGswbDNkYXNa?=
 =?utf-8?B?c0FwVndjZjhIOXVKazl2RStiMUZZbTJ3YjBxeFp1V2JhWHpNZUpwZ0dCRXhF?=
 =?utf-8?B?eUtXNDF5VGpxMUIwRWRWeFJMNFFzUWFvNzMzNW9QZGp3K0lRUTFBMHVzbUFE?=
 =?utf-8?B?c0lXSjV0ZGZnSUYySFg3T3kvZzljWXovSXdEMCtmVXgwajhJZ0FlK3RUbFp0?=
 =?utf-8?B?c2t6eHB3ckVrTk5Xd1VyK2dqQ1ZZL2xHbWJSbnFCNjJTdm16MUZ1QnhMS3lX?=
 =?utf-8?B?NmFVVkE2RHI0UGVrcWtkOW5CamV4RjI5cHFKNk8wRSt5Qkt5Z21HRUVBNDNV?=
 =?utf-8?B?TjE2OW0rUEd6cVJUTEIvMFJucFI4cDhEeFlZaWpVMUVNVWtUQVFnT0hJbyts?=
 =?utf-8?B?RlpCNkx4VlJTLzl3dEs5SHRSS0gvTFpBZ2pYbzVKd0JSanYwaitBbFlaYUd5?=
 =?utf-8?B?Zy9UVkpNaS93b0toNGExVGUyYW9vQWxUOWo3ekxmSTB5UnZVeXdWRWNqblR5?=
 =?utf-8?B?UnU2eW9Lem0wSkMwR21DTDFaYjF1ZVhFa2hGWHNWMnBkdDRJcnQ2UE8wOEdI?=
 =?utf-8?B?R0hkWHdScnNjMGpUYUdUYU1FUWFuakVMbGxHNXRGQWU2eXpIdm9aU1JmaUFa?=
 =?utf-8?B?OXdzVnl4QWZEZHJkbGNGUFJnWE9wRUJkQ1gxbGpKWjhkMk54NzZ2a29sdllE?=
 =?utf-8?B?Nm0xTnMyakh6MkEzWENHdzd0c0tIQ1F2NzZmQzByMFJKYUw1Q0xKQk10U3Yx?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f21485-459f-44bb-0909-08dd1dea8827
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:58:50.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sp2qVr9yy+ksYjRQVtKnux7DcUf4jYhYmdXiP5spBvoZQk1Ek1DHKx8KJqxP8fJW+/eoro56fzy+4HJIe9VS1onZVn8Uz/Lk28H8/7KHdLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com

From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Dec 2024 11:13:33 -0800

> On Wed, Dec 11, 2024 at 9:31 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> Add the following Page Pool netmem wrappers to be able to implement
>> an MP-agnostic driver:
>>
> 
> Sorry, we raced a bit here. Jakub merged my "page_pool_alloc_netmem",
> which does similar to what this patch does.
> 
>> * page_pool{,_dev}_alloc_best_fit_netmem()
>>
>> Same as page_pool{,_dev}_alloc(). Make the latter a wrapper around
>> the new helper (as a page is always a netmem, but not vice versa).
>> 'page_pool_alloc_netmem' is already busy, hence '_best_fit' (which
>> also says what the helper tries to do).
>>
> 
> I freed the page_pool_alloc_netmem name by doing a rename, and now
> page_pool_alloc_netmem is the netmem counterpart to page_pool_alloc. I
> did not however add a page_pool_dev_alloc equivalent.
> 
>> * page_pool_dma_sync_for_cpu_netmem()
>>
>> Same as page_pool_dma_sync_for_cpu(). Performs DMA sync only if
>> the netmem comes from the host.
>>
> 
> My series also adds page_pool_dma_sync_netmem_for_cpu, which should be
> the same as your page_pool_dma_sync_for_cpu_netmem.

Yep, I saw your changes, rebasing soon.

Thanks,
Olek

