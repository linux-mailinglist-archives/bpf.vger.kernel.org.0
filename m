Return-Path: <bpf+bounces-78540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 167B6D124FE
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2AB730C26B2
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B233563E8;
	Mon, 12 Jan 2026 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g74wllGJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDBE3128BD;
	Mon, 12 Jan 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217397; cv=fail; b=ms0JK5pC67uHgSnOrUx+qCBL5Dk5ALVkfNPK1Tm8bHmI+nJDu2MKlYsLz+mdnlRkpZWzZqi/WsZUJ7byQXpxVl7MVtN451jMcxFaVhnb1tHszy4x8J+VBFOoykJNOM7xIwKhd2WD9bCtz9G2REbaKUuZnuVwRxE6VWS84bQ6lGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217397; c=relaxed/simple;
	bh=5F0psuu5HMeX67STblZ8M+97JgpleFt6vnmbgtW6V8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oIrV3qr+IvGIMVBi6XhKXqSHkOL27kKc1RlXgaL3EHx6+sPcna7JjElhrSVfIcUGbMZYGHrzfDu7FKy1gMkcp+PQPZJHrT2PJ0GaYJ+ZnCoTR9wHbs69e+/VK53nTiDxkZgquc9k+ZgCviTKYYXCrOSEgn0cV5oRLb/PwpilU20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g74wllGJ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768217395; x=1799753395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5F0psuu5HMeX67STblZ8M+97JgpleFt6vnmbgtW6V8o=;
  b=g74wllGJJlWiLXacbEdyCOxco+PCZOorRVS6VJAz1FHKd8lt6SKb7HuV
   P5V2NDJggcoy8f2hLEslQI3zFbWFbfg7k/SkDnk6siyn9mFTX5A8W/Yzu
   m5GqEuQeCG3Y36lNgeO6g93ZFffIOMBOo4aFYXzxmLO8+Wzkw9iwK04m8
   Y12REE/ZL9+5x6S8MPHtiR5eOuQcDY83TUUQZI5bidDzT6j5P28y40JRc
   /qS2I3BNaTVEWoRpLe3f7x9at2VJhUI+2q6Y2MApgpPaHIOmZ+Awg04SO
   fm9jCt9zEo52oPnVHjURniupmDfWhXczlG67Qr20t7jO5Bz2NJttLb6Ra
   w==;
X-CSE-ConnectionGUID: KAdFVl2kSAO8sb0JE56R0A==
X-CSE-MsgGUID: nsa/GxakR0GWtoPZ/Adsfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="72067060"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="72067060"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:29:54 -0800
X-CSE-ConnectionGUID: +/o6GHqST8e31rOJd0ea1w==
X-CSE-MsgGUID: pySOcQ2PQHy1PSPXxAgHkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="203871129"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:29:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:29:53 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:29:52 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:29:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YivimoDvkqolqXOpz9VfWSLUo5JXwZzFSsSvwTFGVUfaZkNeYRoa3AS3UOwADpLPKy8OUjTxmtCwY+1WVzLJSq9Qf1v8JLeZoSWAPLVY3fAWQARlaV+9TV38AGF7jPO3CuEKcbemcqZ+tApZLj6TdT0++3cqj/1mdborPXGL2b8NYLRaRbHTas6aCjcLlHnZJl0oEdWAFhgK9CCKPfczmKBUBTbctR0RuKJC4Ja2t/p5JoYZ7pq4EJgOlx6Vcc2SOd1FIw8B82eq0ww0qIp5aobZfPrcEkCEu2KB3JriZew6d6CC7p0gkrzOy2/rY73pK8CeDEIPp/qH3zoIeJ0Llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F0psuu5HMeX67STblZ8M+97JgpleFt6vnmbgtW6V8o=;
 b=N4AqXsLRRzeTscZw0uUyC5mrBzvZpsg9R3lZiEXMBI/lEYTHMCAI4EL4f29ToMoTo1bnMlUEhqNokg7bbbbQxY0lhk4wzce1xhTUzcjPrZIFIQQ22REdjfzTgfxHmSICfqRQHVekSA82wO09sc9eYK97uWvNfxRH0kpn3bcYfiAJBBAVmRx6I3x7EA9Li8gWjT1MrALDgk1n7yVeV8kUEgn5yuoUQVUl00rBE/gSDj2WZMPfmNNNZ/xx3uAl2No2kOxS3Z7NfPNXUtYxRxiQ5ahtDcDJhjvrHWj9cVGuYrETxLyeqGYxAhZwc24BDlgQJuuRPS5HL+9liCit1bpcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:29:50 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:29:50 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next 02/10] bnxt_en: Call
 skb_metadata_set when skb->data points past metadata
Thread-Topic: [Intel-wired-lan] [PATCH net-next 02/10] bnxt_en: Call
 skb_metadata_set when skb->data points past metadata
Thread-Index: AQHcgnThb3j4SjI72kaC/GilcK4AvLVOaIzg
Date: Mon, 12 Jan 2026 11:29:50 +0000
Message-ID: <IA3PR11MB8986048EA519C7E26E1CB361E581A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-2-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-2-1047878ed1b0@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH3PPFD6B8A798D:EE_
x-ms-office365-filtering-correlation-id: a6ba7e9d-16a8-4abf-71c5-08de51cde620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TEVFNVBPUDJHRk1kS3oreCtZVEFqTVE0R3grSTlpSklPaE8yV0huQVNnY1hj?=
 =?utf-8?B?YUtJOXVTNlJkZXFlN2c5UjNXeXdkZER6dEdvc05kc0c0UThSUlRNb2J5QnJC?=
 =?utf-8?B?ZVdURGRoMUNCUjNtS1VXK3FwcnQwK2pNOTZpUzVoRFVFK1lmUkpndm5WY3cz?=
 =?utf-8?B?NzJCeEZ6aERLeTNYcnZQMTRvUEF0aE5vWUc0dzVqV0lsa0hUTkViZFF4ZFU2?=
 =?utf-8?B?NWMzMkhBZ2NGZzQ1NW40dS9tUjU0YWZBZFlabHBTRkNNRy83R1Fwei9mSDNM?=
 =?utf-8?B?cXhhcE1salYwUE1ONlNEdUF1L21mUTNVZFk3Z2JjY3dDZVcyRmF4V2ZqczA2?=
 =?utf-8?B?WnMxNWpmS0l1Y093RVlsL09ZN2w1eE90U2V3VGtlQ2VkMUQ0dTVKNlo4QU95?=
 =?utf-8?B?Y3FMY0tpL3BROWZ6SnNFaVFZR2NENnE5d3AzcmxRN3p1eXN2WjRsVGJ1Y25z?=
 =?utf-8?B?L0d2Wk8xSnc1VGIzNGFnaXJYZXBaekhaN21VZTd4eGl0aGVaQ0tMbG8vcjhi?=
 =?utf-8?B?RERNQWxCanJIR21tc3B6Rk50aDdkWVY4ZnovWUdRejZoclg0Y1p2ZXR1N2t1?=
 =?utf-8?B?Um15OGhQdGFtdXZQSDQrZTUxNTQ2MTVtdnVzSXp2YWNYb0NVUnAyajFmYXha?=
 =?utf-8?B?dUtXYm1SajR0bjZQbGtkdHgvT2JBYlhQaUt0dEV0b2Z2NVNtVjUyVnI3U29i?=
 =?utf-8?B?NWlVQXAzMUxhQkJjMW9qWEt6YkJ4WlZmRzNuRVE0WUlnOVViQXN1Uk9TaHhO?=
 =?utf-8?B?WlNSbVNiSm5MSEZLSVB1UVhteUY0Z3R3TU5HaEpScFJvN0ZxMFU0Sk1Pa2Rp?=
 =?utf-8?B?a2tleHhicXRNUGoxQVdNa0wxeVVjNEp5Y1VmaHNrYVZUMHRtV3JlN29iNmNZ?=
 =?utf-8?B?Z3hEVUs3VjR2U2w5MVJHWjNLcUE3TDZwLzlMTFRkSWhEZVg4aHA5MHNBYTd5?=
 =?utf-8?B?RTJrNnA0aVFxb2NSRmhpR1VuSEh3dWxTc1VMRkpwc3NZQ1BiOW1jTTNOclVN?=
 =?utf-8?B?ekdYdVpEZXkvVmU0WkJPdVFtMzViWk1VZWpNM0ZSSXJkYk1GREMwQ2JXWmdj?=
 =?utf-8?B?eGkzd1JlNXFvQWFLbGJhUFNMYlRicUhzU2dhenE0Um45MFJxU0lXTGpKN0Rk?=
 =?utf-8?B?ZWRQZHY5NkdHcU5OREhCQmRjZnBQTDhHNlhDRzlCcW1Wc2Q3dE96NGVFOXB2?=
 =?utf-8?B?SkdFMmJsQTFPS0RZYkFyR1ZFQm4vMGNLejJKczZ2SlRZRTFIc3RYWGlubVNT?=
 =?utf-8?B?bmgyY0Q2VFBiV2tJaVVQUHNPeUNMWjhpMDBaREJiS0lqNzhsRVJVMk5ETmgw?=
 =?utf-8?B?TVA1OG5pYUFIYTlyNU9uSXE3bENpdjAwNFN0TGRqTTFaYjdNcGxXWm9zSWFP?=
 =?utf-8?B?Qmt3VFhoTEU3bVo5V1FRNnFaVGVlRW1GZ1Q2UWF6SitOQjBZYVdLOVJ0K2pO?=
 =?utf-8?B?R0VUd0VLVGVaNFpCa2JXVk5PN0cyUU1TNHhvKzVOdVJFUVVzcDNoaTB1alBi?=
 =?utf-8?B?VFJzTkFZbm1KY2NFWFNVRHZIZU5PZmtYaXF0ak9xYW5SK2J1cUFGZjBJSVJ0?=
 =?utf-8?B?dXpqZzV4dXdtaGk3aWRELytxRGNUazN5cGtmbkpVREdPNDFvMW42cWZLOGpp?=
 =?utf-8?B?bGVJTGVlS3dhZTZMSFZ1ZkQwYzVXVzBld3hGZmlzaHBJbVZlTllpY2hsbXpL?=
 =?utf-8?B?akJOdWNIYklld0x1b3paODZ5NFNYczMwSU4rTndVK0I1VmNZY2J4NUx5QmFk?=
 =?utf-8?B?bEtJTWVRdnovZnBiODNISGZJVnZQSyt5ZmlGOGJYaHNwMmxXVThRQy82TGx3?=
 =?utf-8?B?djYxN2dCb1R3TENHYURwbTNhWW13Uy9yUEV2SlB0WHkvKys3UTBjNG9XRFl1?=
 =?utf-8?B?QWU5V0xJQWx3K3VVekoyL2VPYWRjbSswcU8vWnZ0VEFEbnI3UFNXQmlERUxD?=
 =?utf-8?B?MWtlMjdiOGpDaTVrY3dlSEFab3VOekFQZFdKK0FRR21wMGZvQVp6L292NHgy?=
 =?utf-8?B?aHpXbGR6TW9IYnZRLzNCQ2ZiUXZycGxoYS9vVGpFbzdsdkhNODBEM3ZxeEZS?=
 =?utf-8?Q?O5bEyB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0YzR0xCdlJNN3FxYlZ0MTd2OHNQRDFST2dXQ1k5SU1yY0NoT2lYWmtqbFVL?=
 =?utf-8?B?NHpMcjA0UDN3dWdaU3V2ejIyWDNEK1hiNXVKaU5iYThISmZINjB5QXFWZGZG?=
 =?utf-8?B?L3J3Z0F4VlhDYUV5UDVLSUkxcU5zTFcyUVpkU3BUWUFIZHRxamR6ei91ZzZE?=
 =?utf-8?B?TUYyc1k5Ymt4SCtyYndycW1tMmlMU29YbWNyc1BIaXQybWRpR3g0MStmL2Fw?=
 =?utf-8?B?cEJCV015NFdsRGZ0ZXpOdlptMWVyRTZDWGZFTHlSNE1uZW03WXN1bnllT09n?=
 =?utf-8?B?RGFIVkRmeFN0Q2dsN0pvakFPRStZVEpvZDQ1emxrazBhYWlnVW5DR1hpT2dR?=
 =?utf-8?B?Vm1jZnNkUndaazNJWlRoQVd5YmJSZnU3RlZFNzRacUpZdWN1Zk1jYUp2Mm8v?=
 =?utf-8?B?anZwMmdtWktzNUkvTFo2UHJFeHZNQTBBbWhmdkNwTHc3SlAyTGNEU1BXZm96?=
 =?utf-8?B?Tmx5enhTcHpEK1E4Q01aK2xSN2l2c0VWS1o2UVZwZFpiV2RIYldyMFpQTm92?=
 =?utf-8?B?czlUZWo3eXVkYVB2a3ByTFJ3TElmZHVwSFZ3Ky9XNlNIanpoZFNpbDhML0Rw?=
 =?utf-8?B?bkN5eXhrYXMxUVNrTXkyMUtwN29GSjJGWlIxbTNGK01mRWZiTnppd0w3Z1Jz?=
 =?utf-8?B?dVYvTlVtTEw0UjRtMjBYc1o2LzZlYWNrV3NmVDRiOVBKeHpxcUNsSlFlUmtL?=
 =?utf-8?B?ZlVQZFd1QUVYMEZ1L05oTGJkR1o5K0RNei9GRkgvdHB1UGpwaWE1VVdJT1FQ?=
 =?utf-8?B?dHVGZmNEdVpXYUI3RmpISzNDMGttb1I2SXgxbk5iWnJka2dVZHBORUlVZlpV?=
 =?utf-8?B?NExtVnR1cFc4UDcrVFQ1SXMxaWdPZ05vaFVXeWhFcGhERkdWMURiWW1uMXlG?=
 =?utf-8?B?K1FYQW1sREVTMitUVi9LV3VSUWhGVk0zSlF4UkFsbitHZFJ1SW4rZzFTdFox?=
 =?utf-8?B?TU03WkpnTDlDVHFKd0JrV2F0VXloVCtqVWErSzVwL1ZudFkwWTVnd2lvNi9r?=
 =?utf-8?B?emE4YXRveDI5RG9VQS93aG5uOTN1eWE4aWxJSCtESkdiVTRZQ1gzc3pVczFB?=
 =?utf-8?B?ZFdkL2NBUE5XMCtpeFM3NVhCL1M3aGJ2Qmx2eE9WV0JQNVB4OXRIRGpodGNk?=
 =?utf-8?B?cDhnUy91VGpDbklEclpDdFRJYlJGald3MWQ5THVlQUptYkJQMzZlWFo3ZUdS?=
 =?utf-8?B?MzFqaytDOEZSazVwZ2ZhTUpIK3JOdnpsNU1mNVFpc09GWGVWWWlHNTVpM1ZC?=
 =?utf-8?B?c1FDeVlaZ3VvbG9oclF2RlM3T3JvUVViM2RjcDRSaGNKRHNmdGxwQ2swYnd3?=
 =?utf-8?B?OEg5VzNYUkQ5dHR6SHZnMXgxTTlYZm9FL2JnbEZnUXhyODduM2Z5RWdOeURz?=
 =?utf-8?B?U3hkc3JHK2wwUHFZZUp2V1IrbGNoWGorNzBwTTRveUpXb2NkMGQ3VjFsNnpk?=
 =?utf-8?B?NlRnK2V6Mk9ITlRDNGh6cW80bjQ4ZExya2h2bHpzSjNOaFpidGpwR3A3U2J0?=
 =?utf-8?B?ODhILytnSjBEZ0JLcFVXZng2ZzJtY3lWSGg5MVdaUmhFcXZ3aDlkTllpUUZl?=
 =?utf-8?B?TjJ2WXBVRlFuQWNVL2hrUGhWKzE4WGJtZXNsZEpmUDNCVlBxK1huRm1yS09l?=
 =?utf-8?B?RHpqQnp2SmQrcFFNWWJpc2hXSzZBVHlQT0ozTkh1YWk1Umxac1dmdldocEpt?=
 =?utf-8?B?b1NrejFicGVkT1pnbFlmQmp3cjhZMC9GblNBME1qZEI1UVdoTlFrMUZnOEdD?=
 =?utf-8?B?bnROdWFLcmppenVpVjhvNUhsZ0U1RVJjN0NxMkdKWG4yMzdQUDhLcCswY25o?=
 =?utf-8?B?WU9KbUdQaEdYR21NZUk0UngrTzNLb3RqVEIwY295QWNHZUx5emhTZ0dNaEhF?=
 =?utf-8?B?V3ZCV2V5eDkwL05Rdjkvb3d3OW56ZHI4dWJaMFRtdnFmODZiQWg2YUltL1pJ?=
 =?utf-8?B?eTllL2dLOVo4WlVweHczazJ1RXJmVW1sQ2lTZldEbnMvRW03V2ZOVHg2M1Bk?=
 =?utf-8?B?bnhXZG81NjhyUmVnZkN6TWR6b2tqYURVdHNnVFBXSS9mRkYwa2VmZHhBMEtI?=
 =?utf-8?B?cnVVU0tHaUszSmJ3Wkp6VWNCQk90NTZUMmNRWWUzQ2JXMEwrSWFVZnZRTWQ3?=
 =?utf-8?B?eXVsazAyZG94S2JJZnJUMHNDY0EvRUMxYXJUYWxqY1AvcUVob0pPMFRzOEVa?=
 =?utf-8?B?ZENqMmZJbG1qbzlWSHEyZjg2clhVZEU2dE1WVG16N3AzQVZaL3FteGx4VklH?=
 =?utf-8?B?VXZiK015NXpsS1dyRjg5Z3J4VXU3RExJM0xYbWQ3Y0lZUVpDSkZHeW1hdXF4?=
 =?utf-8?B?VGdFcjB6YkhqOTB5bmlkM2pmUlJOYzJjL2E4TkVXOGt1a21GU2RFdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ba7e9d-16a8-4abf-71c5-08de51cde620
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 11:29:50.4119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/j8tyK2nJBANvvk1bNgTBlxnjVhDnbf0kNyLYUjLe8QvBypnn89NoBEjhVABV6yZM6OSmyVj7lky4mNZGXKPAS7H5LUlEAB7RREkigEDl0=
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
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDAyLzEwXSBibnh0X2Vu
OiBDYWxsDQo+IHNrYl9tZXRhZGF0YV9zZXQgd2hlbiBza2ItPmRhdGEgcG9pbnRzIHBhc3QgbWV0
YWRhdGENCj4gDQo+IFByZXBhcmUgdG8gY29weSB0aGUgWERQIG1ldGFkYXRhIGludG8gYW4gc2ti
IGV4dGVuc2lvbiBpbg0KPiBza2JfbWV0YWRhdGFfc2V0Lg0KPiANCj4gQWRqdXN0IHRoZSBkcml2
ZXIgdG8gcHVsbCBmcm9tIHNrYi0+ZGF0YSBiZWZvcmUgY2FsbGluZw0KPiBza2JfbWV0YWRhdGFf
c2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFrdWIgU2l0bmlja2kgPGpha3ViQGNsb3VkZmxh
cmUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2JueHQvYm54
dC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vYm54
dC9ibnh0LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9ibnh0L2JueHQuYw0K
PiBpbmRleCA4NDE5ZDFlYjQwMzUuLjdkMGQ4MWQyOTE2NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vYm54dC9ibnh0LmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvYnJvYWRjb20vYm54dC9ibnh0LmMNCj4gQEAgLTE0NDAsOCArMTQ0MCw4IEBAIHN0
YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqYm54dF9jb3B5X3hkcChzdHJ1Y3QNCj4gYm54dF9uYXBpICpi
bmFwaSwNCj4gIAkJcmV0dXJuIHNrYjsNCj4gDQo+ICAJaWYgKG1ldGFzaXplKSB7DQo+IC0JCXNr
Yl9tZXRhZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7DQo+ICAJCV9fc2tiX3B1bGwoc2tiLCBtZXRh
c2l6ZSk7DQo+ICsJCXNrYl9tZXRhZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7DQo+ICAJfQ0KPiAN
Cj4gIAlyZXR1cm4gc2tiOw0KPiANCj4gLS0NCj4gMi40My4wDQpSZXZpZXdlZC1ieTogQWxla3Nh
bmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

