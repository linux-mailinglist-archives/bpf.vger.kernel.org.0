Return-Path: <bpf+bounces-38783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43C496A339
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FBD282956
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9518890A;
	Tue,  3 Sep 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dn2Qjppd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713F187571;
	Tue,  3 Sep 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378498; cv=fail; b=GV2Ai9if6t1aFR+nra0tpVTV1s9w7s8zehKWum3jzVPGhCKdYKpR7fxTjmwA2V2dLF6ABPS98s8YG9WDuQIYRw76ratFCB0vkjuEQBWK50lLFsGr1xj5tWEs9sm4oYBUFbMB2hyypQxK9N7akRBEnFYpP2DP24TkhAu90eQTKZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378498; c=relaxed/simple;
	bh=ZAMgUtbLzLCScQZHK4fkemSFGWL62hIxeYiIRDtQoa8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/s/8X8y2Ed9yCT+IGiIrWY7CAAy8rfbibk0olCijDM/h1MXvQwMydF9vGuplTHZpvZTf1MzA8byKgNk0vSz3yQ2LqTwBkpxaUGRymusR+kqyWL62dncFWR+nZwHXwH2gi7f5JVHuaouCSqM53giUKiPY02jAqcxU+eN689gTIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dn2Qjppd; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725378497; x=1756914497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZAMgUtbLzLCScQZHK4fkemSFGWL62hIxeYiIRDtQoa8=;
  b=Dn2QjppdgENleX0zISUahnDP0bO3vxSQnB+sd6flZbFjTdn4MiTA2+Py
   v/nx8i9vTTz5cWTTPbGpMnGRxYAexPulabO76yJ211Rb/c/NbG+N1t65i
   pTD6+6eHDiw+vO3C/IYZ74cxGYDO3TjPKaec0K7Rxq9F/ZTZv8JNSagf4
   0Ln3mJmkT4Uw6U5JyLWb5PeeeN/r/vELtoKawe0I+OGm8vwrjl76whJzq
   ux/oJwwSVOxxeFOyr9P1HjSQwIVYXO3/ezaG71dltdFrWpbRLxJgGQqlC
   0/ZHctFcvh0f/Izu5+ptK8Ngk7pYtMpMUpAnC53w1QzzUGMNQ6VqlY+RR
   Q==;
X-CSE-ConnectionGUID: obdL8ciFRRmQLIpJdtNY+g==
X-CSE-MsgGUID: Op5Ac+zwSh+2lZMWfEqWpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="13348028"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="13348028"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:48:02 -0700
X-CSE-ConnectionGUID: ez459G7vSyyeYwAc8MyHnw==
X-CSE-MsgGUID: WGjOLtkFR8isxzm7idgu6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65464096"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 08:48:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 08:48:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 08:48:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 08:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWXRRw8FI00qK/HjO9ThfMeerkDBsPqU9A8MjQxM022E1eFeJ4YJy+Xk07v4RK9MtfdYttgegi8tfUAvk+YqLNxk4cD2vH/Y6nKaO+htjqiXogRDGtvCb2/iTNyfRHVwdF8juv+LDSI7q9g3L4xEgOI1/fZpNbx0GFucoj7AXGzdGHhUtTaYaIVeNJCWTMye5eIV/AbgCo0NMyjuAEgA9o4gO4npwbnc0YTopYkgKbiUudyg0TVvCwi7hDsYrsvkEHgfMTEjiSmmWlVDzFE/iI3i3meWlc+oGm2NtpErueB7MwKdQO0pNBsK9wCIwiQg5JbgV0aA2YpgcDw7FaA4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAMgUtbLzLCScQZHK4fkemSFGWL62hIxeYiIRDtQoa8=;
 b=h+TA0ncOoSEgzfv0YKuJxgX5PMxXkqFy4RAGfnnM/m8WOrzKykCNx4sDt0sJ9+8O6z2V6U/Cnk92qQXl9XdtPGGbTVE250kp/EQUkOzIjSYQPty+nxqfcpSdpIB4lWAWj3azS06UYh5yaiIkDTILP0D/yqcmwzYZdPfgOyNqMj5haQ4CI223vVYemgggo2n+lpc3yU41WMgIBDosUSGQaSfU2dw2L1rRuzTexrhx5OdXq9dpBDIfTxoT2DSr0gECGV82vaMwvJCDv1FSxuzUUy3Xb5L7IKk3su10eEgu9su3MlKz1x4zfHUI4Ks4I+Aj/mtmGRUNO8tlh3DD9Nz5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20)
 by BL3PR11MB6338.namprd11.prod.outlook.com (2603:10b6:208:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 15:47:57 +0000
Received: from PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf]) by PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 15:47:57 +0000
From: "Kuruvinakunnel, George" <george.kuruvinakunnel@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Fastabend
	<john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "Kurt
 Kanzenbach" <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] igb: Always call
 igb_xdp_ring_update_tail() under Tx lock
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] igb: Always call
 igb_xdp_ring_update_tail() under Tx lock
Thread-Index: AQHa9GbcnFLruls9k0KM5tePm3IOSLJGPIRQ
Date: Tue, 3 Sep 2024 15:47:57 +0000
Message-ID: <PH0PR11MB51444D404D662D5C63F06C47E2932@PH0PR11MB5144.namprd11.prod.outlook.com>
References: <20240822-igb_xdp_tx_lock-v1-1-718aecc753da@linutronix.de>
In-Reply-To: <20240822-igb_xdp_tx_lock-v1-1-718aecc753da@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5144:EE_|BL3PR11MB6338:EE_
x-ms-office365-filtering-correlation-id: 4ccfe76c-c1c3-4c18-9e59-08dccc2fc84c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aVdBTEFsZzZ3QlVkdjZTQTM5alluRWNDdnRYL1FXR2ZhSHVXQVlkWnViRUlG?=
 =?utf-8?B?b1JueFNRNGE5RjVLbGtFOWFIVDFremtJWTFLVWJubFB5QjNiWHBZSmZEVGY3?=
 =?utf-8?B?amVncjZlWTVkQlRoWTNmMVVLRy8xNE1JWjRpLzNXdnpjUkFkcnNxQis1elNh?=
 =?utf-8?B?UnpqUnlSQmZ6S1AxZ0paT0JHdXh6UExick9tQ0NEZi9ZaGNYSDZoZnB4aDRi?=
 =?utf-8?B?REpWMGVCWW5EQkpVcVMyWURONVNaYUpheHB3VFBVcHIrMWxhNHlBdHorWU5v?=
 =?utf-8?B?YnU5UEN1L1h3b2tVQTR2MnpsdkhwMDVPaExnR0lpZHlqd2lIeFFKcVVLMEhr?=
 =?utf-8?B?ZHBhTFEyQWgrdlNvR1NHeS9wUlBrUm42Mm5yTk4xczZQQVFlRUpmUHFtMUd2?=
 =?utf-8?B?WFNkQ20yeFJEM0NFQmxMUjZaTUdlOENENE50L0dYblVlZ2tXUHdKa2NTdlow?=
 =?utf-8?B?M0FMUGNxU29SYlU3RGZuS3VkTldtaG1nelNOSlBrcmxybFF2K3pOQ1BnOEVC?=
 =?utf-8?B?anlWaFJNUTN1cEYxc2FCT1lJc2czV0d0SUZWdGo5V2J0Z1R6T3ptWUlRWXlT?=
 =?utf-8?B?Zno5alJuU0JuY25iREJqZ3gvNEtMa2p2ZGxpWHFwcHh1NnNJMkltaU1lcnhi?=
 =?utf-8?B?bkpzb1Z1eEtrQWFRUnBqOHpMZEJxMXVhR1Rzb2EwYkVuWmFuTXN4UmEyclBD?=
 =?utf-8?B?a1lTc0kxN0xEV3ZwdjkyZmtxY1pxYkg2V1F0a3d1WVhZbThnci80TmxLZFB5?=
 =?utf-8?B?Y0MzNE96RXF4eG1lL21VREVJdzB5QnFRcUJtR2pPWlBxVS9wdjZ2OXBpZTRu?=
 =?utf-8?B?NFhMQk9TLzBkN2xubGsvQUprRGNHdXkxNG1lNHlidmNDaTRUUTNPVTFGdEx6?=
 =?utf-8?B?UXE1N2pwNU9lZFVyR1JmYVovVkpFZzM0NklORmx5NDJQZGp0VjhrK1czbXJE?=
 =?utf-8?B?anZKRWdjblpaSWlMaGNURDZuMmEvV1NJZy9MS2kzWTRFemdScTFJdk5CRllF?=
 =?utf-8?B?TGJZdkhtZlNnTHpJUTg2VFQrVTRkSWVNdG4yMXZWVVI5QUZlc2NDYVNNdlcy?=
 =?utf-8?B?clZBL3pwMFJ2MVFHbURLSk9TUEI0UytpWFNIeWNjU0d4SkVycFhzeTZnSVVE?=
 =?utf-8?B?NDNxMi9CYkxSL3luRzhCUzgzTXJybGwxc25qazNSVkhvckcyQU56d2ltWTd1?=
 =?utf-8?B?VFBqRy8xZ2ZhQkJWa25zTktjY282YVIvR0FoMml3TVFkWXBmekJmeFJNQ2FV?=
 =?utf-8?B?ZUh1OUU0V2hXQkc3T0JWeVdjMVdGeHlUZExIa1VVaDR5WFNXVXJIQXFLdWV6?=
 =?utf-8?B?VmdpNDN5ZTJLS0s0RmRpdW1HMXZFVDhLTkU1QVdCUzdkUlZqOHlFYWczTyth?=
 =?utf-8?B?TjVpbmJINGJaOVNZbHY4SmFsUmZyVy8xU1k0L0czbTVMTHZzQnpiSHZHUGcw?=
 =?utf-8?B?SnJvdDFtQ1FaNWRBN25kdnJ0Z0kveGhpZm94WkF2eFF2ZkU2ZHJlaWd0NU1J?=
 =?utf-8?B?a09BSTlLTlNxSDNDSHF0REFEZHpNZGowdUxWUERCVkt6cDlnZzRxY09mYThD?=
 =?utf-8?B?RnhLbmlaeHRQMXJHcUFOWEduVkJIWFQ1THBERXVWRTNBbkhqMUkyMkQrcU5J?=
 =?utf-8?B?d1RmeU4zR3lTQ09hdmd4YWVuenQvWE5jSFdnUVRSWWI1NjlYSjBqU01NNTVx?=
 =?utf-8?B?UDExNE40RGk4cmVzZCs0cHBBM3M5ekJ2a1M3czJiS2ZGMmtGWmdWTGM4OCtl?=
 =?utf-8?B?cXBvY3F2S3FMZzBKQW9iWkhTNmZqQzlOM0Jzbk1ZbHhoOURsUlNkWXNOd1Jx?=
 =?utf-8?B?aXJTc2tDbE5DMk5KVXo4KzlndHJOUHh4eVo4UTlSZlJzNy90aHhBTHA4enJV?=
 =?utf-8?B?QktUQm9UNHZ1bDhFaEo2S2cwWTFJd21zT0hZd3R1N0Mzcnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5144.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzVMbW0wcDk4d3N6UDFjdi8vb3IwL0gvRWREKy92T1BIb3N4dnZISGY1YllF?=
 =?utf-8?B?YXVlUUIzUkxQYUNlYmxsK1ZhQUpTWVNPc1NzUTQyZXZCUjR5ZjdCdFVEMW8r?=
 =?utf-8?B?czZjbndBYmRFeVA3Q3BhSFV5elF6dVBuUmhaV2JmZndTNEdhYTlVUTkvb01a?=
 =?utf-8?B?Q0ZKSXlGZ0JJSGtkRU1uVFRrWTUxTWdIQWdnZ0JvUXU2Q1B3R3FNbjk2Yjl3?=
 =?utf-8?B?OGcwRWZyL04wUUxxclVVQ2ptakJIVWptT2J6MXJPc0hVb1FnTnlGNTJhT0dJ?=
 =?utf-8?B?VkRvV0FBTWFlMVkrZU91NjVXYVc3ZU0vVGQrUnM4SWVmMlFXMnZycEE1NURV?=
 =?utf-8?B?eTZCbWZXVGNvR0NXTWFmQXpSMHFTZEpIbnZybVJkc29VRkpKY3hmSTlBRzAy?=
 =?utf-8?B?SFp3aXpweDRqTTZ3dzFMNURPMTdSK3lWL2VEUGJFNW81L3ZhaUpIeUE0bDlI?=
 =?utf-8?B?bzZ4TWQzM0xuN3Z6WEMrZm5PWVlqdkN3am4xbjJWVzBrcU9Zczcycm45dk5Z?=
 =?utf-8?B?alRncXpvV1k2cDZlZ2pSei8rbk43bEJWdXp0YkxvMGIrTjZKOFJ4M1MyZ2Fq?=
 =?utf-8?B?TG1PZzl0eUJwOW1rb2lIQXlrMXRqUmZ3RVVnSk80YzVHNTBNN3orNnBFTWJL?=
 =?utf-8?B?UytVeXVoZEkwc1RIMkZPRG4rekN1Ukg4Z0syZkdObG8zcmFqbkJNNlZva3hl?=
 =?utf-8?B?eWdzQmNkTnRRTmNQWVEzL29BL2x5MHhPRkV5dHRxYUpUVjZRY1ROQVhxb0xG?=
 =?utf-8?B?TjArVWtjRzdhbkQrdmNBNTVsU05YYVQxTEdwOWhkaG5IbmNWYXdUM3h2WkQr?=
 =?utf-8?B?RjNOSkYwNEtaUE9TaklSSEdsTzM0Sm56MFFhY2JDKzNnVU5sdWVSK0pCc0pn?=
 =?utf-8?B?VktSNkY2WnZpMHlLZUNjclliUjJMMWNyMGRFeFA3YTg2a2dyc25VYWJuOElh?=
 =?utf-8?B?VFRBRVlZVXNGcEF6RldxSVJxK1NIQ0ZKdFhqaGdPem40YW1wc1dOK3ZHSVZI?=
 =?utf-8?B?dE9vRWhSaHI3dXd5T0xxeGxOS1laTmJ0TXFzelFvRlZtNW01ZndRdzh4T2w4?=
 =?utf-8?B?VnlJbmxTUkwxWm9PcFNRREZnaSsrN2JsUE8raFhvYVZNS2ZBelRuL3NxZGRv?=
 =?utf-8?B?SEdLcGM1ZTlEQW1FN0RMZldFblBHc3VtelJRLzlIa1Zsekx0bWV4TGJRNlRa?=
 =?utf-8?B?UVlGUGYvdnk3OUZtc2lWbHF3SHJVOUFVVmVWNGNoellxaDZhNDJIYVVsbmVT?=
 =?utf-8?B?NEV1UzNWeGNBekYrVDVJMFdoODVwaSt2SCtmQkxTYm1LdDFNVmVoQjVzNndl?=
 =?utf-8?B?MDduOU81bEpRekhUdG5RYTlFSnZERElNYnllK1gwYW5ZcUxPNWRnWXhZc1p4?=
 =?utf-8?B?K2lLY2syaThjbnF4aEpjaExPcGZqS0FuZzJBanIxV3RrZTRkcURwRE9mRmJV?=
 =?utf-8?B?c0psSkdTcjlEWGgvVXk0VW9BVUpFdGlhNkFOU0RKR1FHSHZ5NjdqQTBPcUZk?=
 =?utf-8?B?Z3FXKzRMc1FHaHV6Q21Ib1FtblRnMmw1dWhrd3ZnOEtSQnptYnZpbEVXb1JL?=
 =?utf-8?B?NnkxN0V1WVh5OUtWQnhYY3VlNTBTS3RKY2NYcnZuZEJFcU03ODJ5dmZZNWJj?=
 =?utf-8?B?TG92T0M4N3cyL0l6K2FaZVBIN1hFZmEvL0diUXB5RTF5SDNZUkdHRXoxOHB2?=
 =?utf-8?B?Unp0Y1p1cThzR0N0TEhTRHlQdFAyMnZZY0lBMEllVVRsZVZaNjVLdGF0SDMw?=
 =?utf-8?B?L3BCeXNabWEyUGV2R2x6Z2htUFhyQ2EwSnNkcEM5Sk11SjAxUnphZFRqcU5z?=
 =?utf-8?B?UVdseFJ5amVhMEhwV1U4NS9BaW5nRDBueHk0QVp1MGdTbU9US29ySlluUGlv?=
 =?utf-8?B?US9jdzRCUG9nTU80a3ZNNjVzU05oVHVNM0toMkdjTCt5T3dIQWVxbFBPek9P?=
 =?utf-8?B?TGVxVFhUYzNmVzBCVDZmUlZIRU4vUk1KRlErdzk3U3FqZmFTcDFDa3pUNHFP?=
 =?utf-8?B?RHNaQkVVQm16R2UwNlpteDhGcnNOS2h4ZHZ4SjAxRlhqT0c2bW4rSjByWkFB?=
 =?utf-8?B?RnhmdmFITmNpdXZZS3Byd1hVV1FFYmttTlJlMFlMaUg0cCtNaWZRZENhMkk2?=
 =?utf-8?B?Nk9ESVhwRHI4VGZmR2pHQXJhdmk1c1R6c2lkNkUyNXV6OHpuQkthL2pyQ3ZM?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5144.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccfe76c-c1c3-4c18-9e59-08dccc2fc84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 15:47:57.5239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74kDQ7KCErCNfE/XQsnbGrWFxJnRP+WV8r5jI0iuYmfkoywYnMNDpjcAYZoJhot0LL2Gw7PNXRVp+vK2HnxUWjZWaG+qEZ8NMSNHLesLJqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6338
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBLdXJ0DQo+IEth
bnplbmJhY2gNCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAyNCAxMjo0MiBBTQ0KPiBU
bzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3pl
bCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gQ2M6IEpl
c3BlciBEYW5nYWFyZCBCcm91ZXIgPGhhd2tAa2VybmVsLm9yZz47IERhbmllbCBCb3JrbWFubg0K
PiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyBTcmlyYW0gWWFnbmFyYW1hbg0KPiA8c3JpcmFtLnlh
Z25hcmFtYW5AZXJpY3Nzb24uY29tPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0KPiA8Ymln
ZWFzeUBsaW51dHJvbml4LmRlPjsgS3VydCBLYW56ZW5iYWNoIDxrdXJ0QGxpbnV0cm9uaXguZGU+
OyBKb2huIEZhc3RhYmVuZA0KPiA8am9obi5mYXN0YWJlbmRAZ21haWwuY29tPjsgQWxleGVpIFN0
YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz47IFNyaXJhbQ0KPiBZYWduYXJhbWFuIDxzcmlyYW0u
eWFnbmFyYW1hbkBlc3QudGVjaD47IEJlbmphbWluIFN0ZWlua2UNCj4gPGJlbmphbWluLnN0ZWlu
a2VAd29rcy1hdWRpby5jb20+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Ow0K
PiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBGaWphbGtvd3NraSwgTWFjaWVqIDxtYWNpZWouZmlq
YWxrb3dza2lAaW50ZWwuY29tPjsgaW50ZWwtDQo+IHdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsNCj4gYnBmQHZnZXIua2VybmVsLm9y
ZzsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxk
YXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0gg
aXdsLW5ldF0gaWdiOiBBbHdheXMgY2FsbCBpZ2JfeGRwX3JpbmdfdXBkYXRlX3RhaWwoKQ0KPiB1
bmRlciBUeCBsb2NrDQo+IA0KPiBGcm9tOiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25h
cmFtYW5AZXN0LnRlY2g+DQo+IA0KPiBBbHdheXMgY2FsbCBpZ2JfeGRwX3JpbmdfdXBkYXRlX3Rh
aWwoKSB1bmRlciBfX25ldGlmX3R4X2xvY2ssIGFkZCBhIGNvbW1lbnQgYW5kDQo+IGxvY2tkZXAg
YXNzZXJ0IHRvIGluZGljYXRlIHRoYXQuIFRoaXMgaXMgbmVlZGVkIHRvIHNoYXJlIHRoZSBzYW1l
IFRYIHJpbmcgYmV0d2Vlbg0KPiBYRFAsIFhTSyBhbmQgc2xvdyBwYXRocy4gRnVydGhlcm1vcmUs
IHRoZSBjdXJyZW50IFhEUCBpbXBsZW1lbnRhdGlvbiBpcyByYWN5IG9uDQo+IHRhaWwgdXBkYXRl
cy4NCj4gDQo+IEZpeGVzOiA5Y2JjOTQ4YjVhMjAgKCJpZ2I6IGFkZCBYRFAgc3VwcG9ydCIpDQo+
IFNpZ25lZC1vZmYtYnk6IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBlc3Qu
dGVjaD4NCj4gW0t1cnQ6IEFkZCBsb2NrZGVwIGFzc2VydCBhbmQgZml4ZXMgdGFnXQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLdXJ0IEthbnplbmJhY2ggPGt1cnRAbGludXRyb25peC5kZT4NCj4gLS0tDQo+
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYyB8IDE3ICsrKysrKysr
KysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gDQoNClRlc3RlZC1ieTogR2VvcmdlIEt1cnV2aW5ha3VubmVsIDxnZW9yZ2Uua3Vy
dXZpbmFrdW5uZWxAaW50ZWwuY29tPg0K

