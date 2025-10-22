Return-Path: <bpf+bounces-71670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A485CBFA178
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 07:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E3CA4EF961
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 05:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A29D2F0C7B;
	Wed, 22 Oct 2025 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDqsovbs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACA2EFDB5;
	Wed, 22 Oct 2025 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111679; cv=fail; b=Q9xTvx6Uc8LSdsAMvRx5/VVb8nUpscDJ1Mv89dLoGoyd6aFBxTptMejTJXpraP5D5PYB5T3fUclSKtgYWFPqhu2YqNGT2DsFNJprXt0RfSV8rJTnCiPMGnD0qS4P0dlBu3b2sPBmftyBhlKxnBO64kHgowFBJfZ6sGzZPzq97fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111679; c=relaxed/simple;
	bh=qrt/ZtRcYNrTh75t7OFHepTDK2EqguQHkUHGcIa5b1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jW7/8D9tpMQtemkaJNc9VJx2ZysQNJ6Gq97dhDI6Txm4Sc42PrCexiVoWGRYGSvVl2oitv+0rPGp9QOufuQwTEdMPufFjYmZnrm5/B7JyLbl12RhiRJSAyit4x9UegQp7cqg53t1elpzXjaOdhzYcVK2uuA3/IyF7wDLFZf2yC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDqsovbs; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761111676; x=1792647676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qrt/ZtRcYNrTh75t7OFHepTDK2EqguQHkUHGcIa5b1Q=;
  b=jDqsovbst9J1Ln5iV7YHXd/uRmv899rIpspNR2x2I2dxqReJxNy30Ei6
   D+7tiRG39rLhagyjhJfyllZeqULPHGiSRWnyH9IOb7GKwpkRxRH1Uoo+u
   fsFTpI+tyGKzfut78ISENm+MZpwITi0BA9pBatYA+Jtrp3Rnkvt7726Y3
   HgkusPOfC9tMonUqs57h+45hyJkxthpsuH0D6fYocTJH3tBAwOyNNLjWD
   wuivrtZRc2cN4h5ZU+WBtiWNQRZe/aCPsFjWVyxmgSuMg+DIIxgb7DHDn
   E2AdbuiBhYGDNEZNyvT3fGbdZCD/zh49y1b/Fjxy3kZLmLe4tZDe9x1ah
   g==;
X-CSE-ConnectionGUID: qUkiz6vpTzSJPbgDfFG/kg==
X-CSE-MsgGUID: Afwwawr4RD++4yfJZJffnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73855032"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="73855032"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:41:15 -0700
X-CSE-ConnectionGUID: wqMmoSPPS9qTUaux4awcLQ==
X-CSE-MsgGUID: 8MxBVgIYRJOuY4GUOmINbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="220964506"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:41:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 22:41:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 22:41:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 22:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MelRbM+P74Lk+4OC1XdJgUOoP0DhsWRPNPjNo5vP30Eevkc4BI0N82LAAEXscBEyda3Q+5thoPas9ftVzcYKpkPNSLRwpxCqSnKr3KIBDhuOE3HD8PlSw1jYrtd8Jtv/UZUatqGd4VwsVKAm+OyfWpnCPGtjS0qNxRq1xZHzAn0z8B+p9r+QgWPV1LKOJkgDip/O+dr6cMOmvS8PE5wJW2YpjJ4cpJoBb7HFLamc8Dh344u5QIdrw7WgCWfyIvivMyIYLJeBGzXO26qRpaTxREZD3rTUiLkn6Q9jL+Rcmn/6aWsDEi72kEbnJb6b7mXFdLku6oZ6GYQNobKQjuuS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrt/ZtRcYNrTh75t7OFHepTDK2EqguQHkUHGcIa5b1Q=;
 b=KV/HH/03pomrv/lTBuT1QeK0GyteKtz43PPEKyYYil0QjSsvHwuy4B4v9h0qLLoq7MUoBWzVYcWQGs/x4y5GxYO6dU7YdtJ2rVaN/kzYM+7Vnkq17gSwrNa1V2y+02Z35gCzrS8Tdio5B4zczCI997GYNOr/7uoxu4D4B61Jd1JgqfKVrtgZloeVULwozCk22WVFNn7zo/gfpu2fatfOTgYoTdqQvf1I3JsxVJljUQ3WWbtgmV/au0ixqgrJ6WHNEGjYxROovW0GlPr7w5gJ4WdLjd7ioCVe/GyfUxlP8gDcVIQpmAkYrkKJr2GmHCHHbiBALfZCWzz5DmeLx07Nig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1SPRMB0026.namprd11.prod.outlook.com (2603:10b6:806:250::13)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 05:41:07 +0000
Received: from SA1SPRMB0026.namprd11.prod.outlook.com
 ([fe80::fcb1:8fb0:105:9364]) by SA1SPRMB0026.namprd11.prod.outlook.com
 ([fe80::fcb1:8fb0:105:9364%7]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 05:41:06 +0000
From: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, Alessandro Decina
	<alessandro.d@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Thread-Topic: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Thread-Index: AQHcQrC93ElBT1jzGkCik6J1gjAaa7TNfZuAgAAjr/A=
Date: Wed, 22 Oct 2025 05:41:06 +0000
Message-ID: <SA1SPRMB0026CD60501E3684B5EC67F290F3A@SA1SPRMB0026.namprd11.prod.outlook.com>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
 <CAL+tcoCwGQyNSv9BZ_jfsia6YFoyT790iknqxG7bB7wVi3C_vQ@mail.gmail.com>
In-Reply-To: <CAL+tcoCwGQyNSv9BZ_jfsia6YFoyT790iknqxG7bB7wVi3C_vQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1SPRMB0026:EE_|DS0PR11MB7622:EE_
x-ms-office365-filtering-correlation-id: 294fac5d-90f1-4c36-254c-08de112d98df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Zk1FZHN6OXdKcUtTTER6bUdqODQwZFJkSG9iT1Yzb3JhWTZueXd2RnUvSzdM?=
 =?utf-8?B?MUZBdjR3U2l0UFY2RXMreFBzbGxvT1FSSkczcHNCbUllZzdyR2ptNDQ5VUhI?=
 =?utf-8?B?Zy9TM2I0c0ZNa0xPMkFJQ2xiTEZZTmozVm0vcWRCcnFiY1pjZ1gydDVpOGc3?=
 =?utf-8?B?TzNsc3BVZFEvVjQ4cTR3NVIzdnVlZm9jUUNFcnpUY1JLdS9kZnJBTlFCb2dt?=
 =?utf-8?B?bnZaR3pvWlFrcS9JMjNLQzNwcFE4V2Z1SloxbCs0ejFadmUyM2o1cFRsV2ZR?=
 =?utf-8?B?ZDNlSTJzY2RYUEwzbzNsR0RkV0JDbFZMVFZqM2E3WkdrTEE4cW8yWWdmdnNv?=
 =?utf-8?B?bnNHK0ttUVNuSkVrb2ZwVmpCajcwWkRkWjNjTmw5aGJuczRPbmVEZU1OVVUv?=
 =?utf-8?B?R1JWdzBvQVNuVmJIVFJpZWlBeDFqUlhVMzNaamFRay9SYlNGTEtrTk9pZGpk?=
 =?utf-8?B?SjFBWTM0TkJtbzN1NWY1aW4waDVkWDYwZ09oZ3l1L01yLzlaQnN1SUJKWThD?=
 =?utf-8?B?Wnh5NkdDNjk3aVhlMjFmN1hYVU5xUE1JT2Q3Mm0rcHFkekhmRjJ0SUJQN1BH?=
 =?utf-8?B?akdJVnRFdlVNUzZ3WUlFeXNTMFlsNzQ5TlBVOXc0S3NLQzl3MCtDSGhMbEFv?=
 =?utf-8?B?TkFPanhsMVc5N1RBcCtzM0lSRTVVK2VhYVcwQXhubmZqS1htUFJYQkV0Rktt?=
 =?utf-8?B?cmNEVjRpdTRpbnNLTGxISERoVnh6NEl1bHhtYnR4K3d3Y0RkUmFnSjMvQkdF?=
 =?utf-8?B?WjFWbjFEc0l1VHlhWkR6TDN4QW1kSXBWSU5YYWQ0MDVtR1RxaGpPV29VUysw?=
 =?utf-8?B?TVAvQ3krWjhNVThESlFSODNpakExTFVrWHlqNEt6emw1V01zNTFXQUdMbC9t?=
 =?utf-8?B?M09QYWRkTTdFWXJsNTh3L0J5N3JkUkZDUkxtenRla1dGbzN1aHBUeW90OEVq?=
 =?utf-8?B?dnQxYVpEUlVEU3lUR0tzZHJtMUcvanVrclRvQTlPdlUzSG9JYVBrS0JFaGpW?=
 =?utf-8?B?Z1pGR2Z5eXY2b2dQZ3lXamxBQ0x5eGt4K29ySGF4Q3crNjBpOXFTNmY3VWZI?=
 =?utf-8?B?bkNoVFViNU1YWEJVenpiMURLeEYwRVBmcXlBTGw2TGVaUDUvNElHSWYxNk4z?=
 =?utf-8?B?RTdIZnV6Ky9hRklPTHc5Tnl2RGh0Ri9jTHlub3FUQk9OYTA1TEd5S0xOQ2Rt?=
 =?utf-8?B?dHRKejRLNjkveThHZE43S2svMVdnY3JXU2R2N3lmUHVkR1dJUCtKdXVFbk44?=
 =?utf-8?B?SG5xWVFDTE81U1ZidEtnN25qQzVvcy9GU3JqN2VvdlIrd3FKeHVFUUZQWGFh?=
 =?utf-8?B?Z2Vod1FaNkdadENYSEVoYmhQSjB4Q3NVNllEZ0RDS2h4bE1YMlFuTzVOYTBx?=
 =?utf-8?B?LzhudjNMa1QvMW8xb21VeSt6N3pGTWx1OWt2TVdlczUwR0xXTzFHOFZPN1ow?=
 =?utf-8?B?aDk1ejlkTFFsMFhndkxGK2c0ZGRNbzhFTjJyVmtkUnd6TnllUnQwQXBPRzlD?=
 =?utf-8?B?V0FoN1o2Y25vU3RraDlHb2I3Vy9ZZjJFZ2R2ZWRWcXU0NUQwNldSQ1lRckV1?=
 =?utf-8?B?T1ppL0kwa3g2SGJxY1BlQUU1TmRiMFFGTC9LUG9RTVlOMzZ3QThpcExRS1dQ?=
 =?utf-8?B?VzV6NDRPSjFMeGNOY2d0cUdRaStZZFJzTDJ5elR1dmhTZXZ4dFo1WXEybnoy?=
 =?utf-8?B?djIrd09sSG4wZ2pVdWtkbkFNNXJQVHhSVVJxaVVFQzhpYTMzTHhYYVdBMk9w?=
 =?utf-8?B?dGU3cFNiMGhFVHBvY3FFbkZ6SnhURUVvWm4zYWJ3cXZzVk1GbWRVWFFZcmFY?=
 =?utf-8?B?eEVOY0pBMXozQjRSRDRxZ2Fvb2FtUWRab0U1b1BSNnNkR3UvZVlSMTM3a2ZY?=
 =?utf-8?B?UU44d0RwalZWalpYekRYV0tkVDIvdnZWbVkwTGRSYUQvVVhraXdyNjhDMjVB?=
 =?utf-8?B?eVdmaEoyNHI1bVl5MVJuTFdjSFR3djY5ZDNMekpCcmd5MnJEQThvOGpvdDls?=
 =?utf-8?B?WGVpcW0wWXhLakdGU0lMc3BqRUpuZm92Tmx4cHcxMEw5KzJBbVBDVkhteUU3?=
 =?utf-8?Q?PlzKVJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1SPRMB0026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejh0b2lnV0NHdHZhWkdJa0d4V1BLWWltR3ZiY3BnQjluWlYvOGpJcGd4MUhF?=
 =?utf-8?B?azNLWFFIa0NDVU94cHFUNTh1cHhzUk1vRUlvUE4xdjJJTXZ6WG1DdVcwS2sr?=
 =?utf-8?B?R04yRzgyOEE5QW9OczlENXVxS1RDZ01zcUw1SjY1U25BT1YrL0VkTkVicTU4?=
 =?utf-8?B?TVZhTEt1OVRxSXlUdXJuNERmSGF4KzA3OEVuTEJISCtMa20wKzdzRXluVzYr?=
 =?utf-8?B?L0Uzcm85SEtkVG1CeFBKOHJBZ2QxdWoyNUJSVnRvZTNaS2hha1ZtMHZ2TFB6?=
 =?utf-8?B?aWxKOC9SR2g0c1NoanN6bk96QlQ5R2xRTGZ4eFU3OTFwbDk0bk9mMy9md0ZQ?=
 =?utf-8?B?c2ZYcFYzMW9Qd3FoSmJKM2YrRjE1OGV2K3VIWlJQdFU1YmswbjRSeStZSTJD?=
 =?utf-8?B?M1hCaWxOWittM1VIaGwzUkxvWFRmeVExMC9wWEdLZHFmUUZXZGxnYXg0VEJj?=
 =?utf-8?B?VzdHeVFDZFc5NzYzWmJsS3FoMnNiWHh6OE5PUnN6VjdqL2IwaUx3eDVGSi9u?=
 =?utf-8?B?M0FucnVlUWtnR1dBQUNzcy9iVzBjUjN4cGhzV2xyWVA2ckVQaFRlK2dVcFo5?=
 =?utf-8?B?WWU2ZnZnZlFoQ3JscUxZdkFJN0J3aVZSalp4bDlMUnI1Sk9DRUs5ZE9IZ3Jm?=
 =?utf-8?B?Q0tKMk5oNlhwSkM1OXRWdkdKeUpvODBxZWd3a0hYRFo0RCtpMGlyTlFmUlR2?=
 =?utf-8?B?dkFrNDU0RGJRcWFsU3B2amdsV2g1c29nbTBycDFmRnBkbDZRRGppL3pnNnpq?=
 =?utf-8?B?M3BCeGZSeDJ4ZWo2TnpvVStMTlpEN2F4eGh0MG9MbVVEVW1CRE9MamhuUnpI?=
 =?utf-8?B?bUQ5YmN2cEFta0FUWExwNWhjY1diTHV2aHhWcXNYWlJCOW1Ea1dWcTlzNHhx?=
 =?utf-8?B?M2d5b2FBNnNNbUNPRk5wQ1VsRmVGYmhDN0pCcGJoWDg2QkpUL3AyalBuZmRK?=
 =?utf-8?B?QmVja2dLM1Z3eUJWcElmaW5iV1RpeEZOUjFHbHJZZ204K3VqbnJVSEtEQ3JM?=
 =?utf-8?B?Nzh1SUYwbmh2V2czVGZYMjVJaVBNSjJyTmlBdGt3KzRYRExlOVpzQlNUNEFi?=
 =?utf-8?B?NnJacllHdE1ZVjA2OXY5YWxZMGRQWWtlUUwwOTQybUEzUDFVZm1rRnR2c21G?=
 =?utf-8?B?RTAxbmE2S2F5VFFTK2orREFySVpJT3VNTHJ0cCtzcTdsRU0yUGh3UDlKQUFL?=
 =?utf-8?B?WEJYWmRVN21WSnZjc2g3TWlWL0RIN1dOUjhWRFBNOXY0TUVEc2RNV3ZGMzJs?=
 =?utf-8?B?OHFtWERyZ29nRUxUU1R1SjgrLzI0RUFjQ3VTNmFJVTZFZ0crUmR4dStOU0Zq?=
 =?utf-8?B?eVlIKzJRVnZjWXRwbDNYTEY0WEJYOGZuampmdnphZGdFaXpNNmEwTjJuTXJF?=
 =?utf-8?B?cWljMVBzaEVTVzl4eFRuWGt6b3I1cHlaMlhVVWtMa0VtY1c2MFFUYVByaHg1?=
 =?utf-8?B?L0tIOTNGY3M2KzloYU9kMmxVWUkxUUhOdk1lOStqYWJYc1FXU1hjZWZucXZV?=
 =?utf-8?B?RE1GOTJOZnB3bVJBTTl1MUhCYjAvTDF4YlBmODRMQW5mOVp3UE1ZdUEyTjVP?=
 =?utf-8?B?dy9sdXhVSHdTdHREQUxNcDZSUUZvRjhlRlUwNXI3bmlwUS9lZU12clQzUm1K?=
 =?utf-8?B?YXhkMWhPVlBGbFdpODRDenZMWWl0MktDaTdmN25aRldoNDd3cE5CTUJjYkM0?=
 =?utf-8?B?SldpdDdldklqZjArTUdQMHQ5cFE0WUtDbG1ibVJ3UHVOcWk3MW5udElLMW4v?=
 =?utf-8?B?YVpsb2ZkbGJsWXhFY3BjYW9yWWJjU3VpekhSREFVQTNPNUdtajd2YTNYZ0k1?=
 =?utf-8?B?NXFQTHZ0QzBKclQydnFiRXNlUWxUZkp5OUtneS9tcGZEQURiejlnNytjQ2c1?=
 =?utf-8?B?aXMyTlRBcTBJOEZWcEFrUTV6ZVBNQW1xTU44YXpjcnJ6UjBodkZ3dkllK1Fm?=
 =?utf-8?B?YmxNczBoSHZSMUtFZnVKdzArNmNRVGIyUW9KZi9yUHRMN1RyOGR6ZDhPU0My?=
 =?utf-8?B?VWZLSnZKSEE4MVdYd2VISXZ6MlpkRzBicmJqYXBBSFp1aUoyNndWeEQrekVq?=
 =?utf-8?B?S2tkTjRBcTMyTEVhSVBpTFlvWGJNTVlza2M2QkQ0eERhdG94ei81U25RVy9O?=
 =?utf-8?Q?6IDK8GBVDl4qDYTxPkmU28K5z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294fac5d-90f1-4c36-254c-08de112d98df
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 05:41:06.8862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMvDQtQWweKkrBYGJFlFROPGegvqC/WOOlhmi0dbtilw0/lW5MEMEgt1k0djrnJFFG6vGRg2qFIQv8dnt5ZfOLSXWyidojlKrS4JOFsjqpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBYaW5nIDxrZXJuZWxqYXNvbnhpbmdAZ21haWwuY29tPg0KPiBTZW50OiAy
MiBPY3RvYmVyIDIwMjUgMDg6NDENCj4gT24gV2VkLCBPY3QgMjIsIDIwMjUgYXQgMTozM+KAr0FN
IEFsZXNzYW5kcm8gRGVjaW5hDQo+IDxhbGVzc2FuZHJvLmRAZ21haWwuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IFdoZW5ldmVyIGEgc3RhdHVzIGRlc2NyaXB0b3IgaXMgcmVjZWl2ZWQsIGk0MGUgcHJv
Y2Vzc2VzIGFuZCBza2lwcyBvdmVyDQo+ID4gaXQsIGNvcnJlY3RseSB1cGRhdGluZyBuZXh0X3Rv
X3Byb2Nlc3MgYnV0IGZvcmdldHRpbmcgdG8gdXBkYXRlDQo+ID4gbmV4dF90b19jbGVhbi4gSW4g
dGhlIG5leHQgaXRlcmF0aW9uIHRoaXMgYWNjaWRlbnRhbGx5IGNhdXNlcyB0aGUNCj4gPiBjcmVh
dGlvbiBvZiBhbiBpbnZhbGlkIG11bHRpLWJ1ZmZlciB4ZHBfYnVmZiB3aGVyZSB0aGUgZmlyc3Qg
ZnJhZ21lbnQNCj4gPiBpcyB0aGUgc3RhdHVzIGRlc2NyaXB0b3IuDQo+ID4NCj4gPiBJZiB0aGVu
IGEgc2tiIGlzIGNvbnN0cnVjdGVkIGZyb20gc3VjaCBhbiBpbnZhbGlkIGJ1ZmZlciAtIGJlY2F1
c2UgdGhlDQo+ID4gZUJQRiBwcm9ncmFtIHJldHVybnMgWERQX1BBU1MgLSBhIHBhbmljIG9jY3Vy
czoNCj4gPg0KPiA+IFsgNTg2Ni4zNjczMTddIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdlIGZh
dWx0IGZvciBhZGRyZXNzOg0KPiBmZmQzMWMzN2VhYjFjOTgwDQo+ID4gWyA1ODY2LjM3NTA1MF0g
I1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+ID4gWyA1ODY2LjM4
MDgyNV0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlDQo+ID4gWyA1
ODY2LjM4NjYwMl0gUEdEIDANCj4gPiBbIDU4NjYuMzg4ODY3XSBPb3BzOiBPb3BzOiAwMDAwIFsj
MV0gU01QIE5PUFRJDQo+ID4gWyA1ODY2LjM5MzU3NV0gQ1BVOiAzNCBVSUQ6IDAgUElEOiAwIENv
bW06IHN3YXBwZXIvMzQgTm90IHRhaW50ZWQNCj4gNi4xNy4wLWN1c3RvbSAjMSBQUkVFTVBUKHZv
bHVudGFyeSkNCj4gPiBbIDU4NjYuNDAzNzQwXSBIYXJkd2FyZSBuYW1lOiBTdXBlcm1pY3JvIEFT
IC0yMTE1R1QtSE5UUi9IMTNTU1QtRywNCj4gQklPUyAzLjIgMDMvMjAvMjAyNQ0KPiA+IFsgNTg2
Ni40MTIzMzldIFJJUDogMDAxMDptZW1jcHkrMHg4LzB4MTANCj4gPiBbIDU4NjYuNDE2NDU0XSBD
b2RlOiBjYyBjYyA5MCBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBj
YyA5MCA5MA0KPiA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA2NiA5
MCA0OCA4OSBmOCA0OCA4OSBkMSA8ZjM+IGE0DQo+IGU5IGZjIDI2IGMwIGZlIDkwIDkwIDkwIDkw
IDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwDQo+ID4gWyA1ODY2LjQzNzUzOF0gUlNQ
OiAwMDE4OmZmNDI4ZDllYzBiYjBjYTggRUZMQUdTOiAwMDAxMDI4Ng0KPiA+IFsgNTg2Ni40NDM0
MTVdIFJBWDogZmYyZGQyNmRiZDhmMDAwMCBSQlg6IGZmMmRkMjY1YWQxNjE0MDAgUkNYOg0KPiAw
MDAwMDAwMDAwMDAwNGUxDQo+ID4gWyA1ODY2LjQ1MTQzNV0gUkRYOiAwMDAwMDAwMDAwMDAwNGUx
IFJTSTogZmZkMzFjMzdlYWIxYzk4MCBSREk6DQo+IGZmMmRkMjZkYmQ4ZjAwMDANCj4gPiBbIDU4
NjYuNDU5NDU0XSBSQlA6IGZmNDI4ZDllYzBiYjBkNDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIw
OToNCj4gMDAwMDAwMDAwMDAwMDAwMA0KPiA+IFsgNTg2Ni40Njc0NzBdIFIxMDogMDAwMDAwMDAw
MDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOg0KPiBmZjQyOGQ5ZWVjNzI2ZWY4DQo+
ID4gWyA1ODY2LjQ3NTQ5MF0gUjEzOiBmZjJkZDI2ZGJkOGYwMDAwIFIxNDogZmYyZGQyNjVjYTJm
OWZjMCBSMTU6DQo+IGZmMmRkMjY1NDg1NDhiODANCj4gPiBbIDU4NjYuNDgzNTA5XSBGUzogIDAw
MDAwMDAwMDAwMDAwMDAoMDAwMCkNCj4gR1M6ZmYyZGQyYzM2MzU5MjAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwDQo+ID4gWyA1ODY2LjQ5MjYwMF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVT
OiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiA+IFsgNTg2Ni40OTkwNjBdIENSMjogZmZk
MzFjMzdlYWIxYzk4MCBDUjM6IDAwMDAwMDAxNzhkN2IwNDAgQ1I0Og0KPiAwMDAwMDAwMDAwZjcx
ZWYwDQo+ID4gWyA1ODY2LjUwNzA3OV0gUEtSVTogNTU1NTU1NTQNCj4gPiBbIDU4NjYuNTEwMTI1
XSBDYWxsIFRyYWNlOg0KPiA+IFsgNTg2Ni41MTI4NjddICA8SVJRPg0KPiA+IFsgNTg2Ni41MTUx
MzJdICA/IGk0MGVfY2xlYW5fcnhfaXJxX3pjKzB4YzUwLzB4ZTYwIFtpNDBlXQ0KPiA+IFsgNTg2
Ni41MjA5MjFdICBpNDBlX25hcGlfcG9sbCsweDJkOC8weDE4OTAgW2k0MGVdDQo+ID4gWyA1ODY2
LjUyNjAyMl0gID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUNCj4gPiBbIDU4
NjYuNTMxNDA4XSAgPyByYWlzZV9zb2Z0aXJxKzB4MjQvMHg3MA0KPiA+IFsgNTg2Ni41MzU2MjNd
ICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1DQo+ID4gWyA1ODY2LjU0MTAx
MV0gID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUNCj4gPiBbIDU4NjYuNTQ2
Mzk3XSAgPyByY3Vfc2NoZWRfY2xvY2tfaXJxKzB4MjI1LzB4MTgwMA0KPiA+IFsgNTg2Ni41NTE0
OTNdICBfX25hcGlfcG9sbCsweDMwLzB4MjMwDQo+ID4gWyA1ODY2LjU1NTQyM10gIG5ldF9yeF9h
Y3Rpb24rMHgyMGIvMHgzZjANCj4gPiBbIDU4NjYuNTU5NjQzXSAgaGFuZGxlX3NvZnRpcnFzKzB4
ZTQvMHgzNDANCj4gPiBbIDU4NjYuNTYzOTYyXSAgX19pcnFfZXhpdF9yY3UrMHgxMGUvMHgxMzAN
Cj4gPiBbIDU4NjYuNTY4MjgzXSAgaXJxX2V4aXRfcmN1KzB4ZS8weDIwDQo+ID4gWyA1ODY2LjU3
MjExMF0gIGNvbW1vbl9pbnRlcnJ1cHQrMHhiNi8weGUwDQo+ID4gWyA1ODY2LjU3NjQyNV0gIDwv
SVJRPg0KPiA+IFsgNTg2Ni41Nzg3OTFdICA8VEFTSz4NCj4gPg0KPiA+IEFkdmFuY2UgbmV4dF90
b19jbGVhbiB0byBlbnN1cmUgaW52YWxpZCB4ZHBfYnVmZihzKSBhcmVuJ3QgY3JlYXRlZC4NCj4g
Pg0KPiA+IEZpeGVzOiAxYzliYTljMTQ2NTggKCJpNDBlOiB4c2s6IGFkZCBSWCBtdWx0aS1idWZm
ZXIgc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxlc3NhbmRybyBEZWNpbmEgPGFsZXNz
YW5kcm8uZEBnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2k0MGUvaTQwZV94c2suYyB8IDcgKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3hzay5jDQo+IGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3hzay5jDQo+ID4gaW5kZXggOWY0NzM4OGVhYmE1Li5kYmMx
OTA4M2JiYjcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQw
ZS9pNDBlX3hzay5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9p
NDBlX3hzay5jDQo+ID4gQEAgLTQ0MSwxMyArNDQxLDE4IEBAIGludCBpNDBlX2NsZWFuX3J4X2ly
cV96YyhzdHJ1Y3QgaTQwZV9yaW5nDQo+ICpyeF9yaW5nLCBpbnQgYnVkZ2V0KQ0KPiA+ICAgICAg
ICAgICAgICAgICBkbWFfcm1iKCk7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgaWYgKGk0MGVf
cnhfaXNfcHJvZ3JhbW1pbmdfc3RhdHVzKHF3b3JkKSkgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHUxNiBudHA7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGk0MGVf
Y2xlYW5fcHJvZ3JhbW1pbmdfc3RhdHVzKHJ4X3JpbmcsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnhfZGVzYy0+cmF3LnF3b3JkWzBd
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHF3b3JkKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBiaSA9ICppNDBlX3J4X2Jp
KHJ4X3JpbmcsIG5leHRfdG9fcHJvY2Vzcyk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
eHNrX2J1ZmZfZnJlZShiaSk7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKCsrbmV4
dF90b19wcm9jZXNzID09IGNvdW50KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG50cCA9
IG5leHRfdG9fcHJvY2VzcysrOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChuZXh0
X3RvX3Byb2Nlc3MgPT0gY291bnQpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBuZXh0X3RvX3Byb2Nlc3MgPSAwOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChu
ZXh0X3RvX2NsZWFuID09IG50cCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG5leHRfdG9fY2xlYW4gPSBuZXh0X3RvX3Byb2Nlc3M7DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+IC0tDQo+ID4g
Mi40My4wDQo+ID4NCj4gPg0KPiANCj4gSSdtIGNvcHlpbmcgeW91ciByZXBseSBmcm9tIHYxIGFz
IHNob3duIGJlbG93IHNvIHRoYXQgd2UgY2FuIGNvbnRpbnVlDQo+IHdpdGggdGhlIGRpc2N1c3Np
b24gOikNCj4gDQo+ID4gSXQgcmVhbGx5IGRlcGVuZHMgb24gd2hldGhlciBhIHN0YXR1cyBkZXNj
cmlwdG9yIGNhbiBiZSByZWNlaXZlZCBpbiB0aGUNCj4gPiBtaWRkbGUgb2YgbXVsdGktYnVmZmVy
IHBhY2tldC4gQmFzZWQgb24gdGhlIGV4aXN0aW5nIGNvZGUsIEkgYXNzdW1lZCBpdA0KPiA+IGNh
bi4gVGhlcmVmb3JlLCBjb25zaWRlciB0aGlzIGNhc2U6DQo+ID4NCj4gPiBbdmFsaWRfMXN0X3Bh
Y2tldF1bc3RhdHVzX2Rlc2NyaXB0b3JdW3ZhbGlkXzJuZF9wYWNrZXRdDQo+ID4NCj4gPiBJbiB0
aGlzIGNhc2UgeW91IHdhbnQgdG8gc2tpcCBzdGF0dXNfZGVzY3JpcHRvciBidXQga2VlcCB0aGUg
ZXhpc3RpbmcNCj4gPiBsb2dpYyB0aGF0IGxlYWRzIHRvOg0KPiA+DQo+ID4gICAgIGZpcnN0ID0g
bmV4dF90b19jbGVhbiA9IHZhbGlkXzFzdF9wYWNrZXQNCj4gPg0KPiA+IHNvIHRoZW4geW91IGNh
biBnbyBhbmQgYWRkIHZhbGlkXzJuZF9wYWNrZXQgYXMgYSBmcmFnbWVudCB0byB0aGUgZmlyc3Qu
DQo+IA0KPiBTb3JyeSwgaG9uZXN0bHksIEkgc3RpbGwgZG9uJ3QgZm9sbG93IHlvdS4NCj4gDQo+
IExvb2tpbmcgYXQgdGhlIGNhc2UgeW91IHByb3ZpZGVkLCBJIHRoaW5rIEBmaXJzdCBhbHdheXMg
cG9pbnRpbmcgdG8NCj4gdmFsaWRfMXN0X3BhY2tldCBpcyB2YWxpZCB3aGljaCBkb2VzIG5vdCBi
cmluZyBhbnkgdHJvdWJsZS4gWW91IG1lYW4NCj4gdGhlIGNhc2UgaXMgd2hhdCB5b3UncmUgdHJ5
aW5nIHRvIGhhbmRsZT8NCj4gDQo+IFlvdSBwYXRjaCB1cGRhdGVzIG5leHRfdG9fY2xlYW4gdGhh
dCBpcyBvbmx5IHVzZWQgYXQgdGhlIHZlcnkNCj4gYmVnaW5uaW5nLCBzbyBpdCB3aWxsIG5vdCBh
ZmZlY3QgQGZpcnN0LiBJbWFnaW5nIHRoZSBmb2xsb3dpbmcgY2FzZToNCj4gDQo+ICAgICAgW3N0
YXR1c19kZXNjcmlwdG9yXVt2YWxpZF8xc3RfcGFja2V0XVt2YWxpZF8ybmRfcGFja2V0XQ0KPiAN
Cj4gRXZlbiBpZiB0aGUgbmV4dF90b19jbGVhbiBpcyB1cGRhdGVkLCB0aGUgQGZpcnN0IHN0aWxs
IHBvaW50cyB0bw0KPiBbc3RhdHVzX2Rlc2NyaXB0b3JdIHRoYXQgaXMgaW52YWxpZCBhbmQgdGhh
dCB3aWxsIGxhdGVyIGNhdXNlIHRoZQ0KPiBwYW5pYyB3aGVuIGNvbnN0cnVjdGluZyB0aGUgc2ti
Lg0KPiANCj4gSSdtIGFmcmFpZCB0aGF0IHdlJ3JlIG5vdCBvbiB0aGUgc2FtZSBwYWdlLiBMZXQg
bWUgY29uZmlybSB0aGF0IGl0IGlzDQo+IEBmaXJzdCB0aGF0IHBvaW50cyB0byB0aGUgc3RhdHVz
IGRlc2NyaXB0b3IgdGhhdCBjYXVzZXMgdGhlIHBhbmljLA0KPiByaWdodD8gQ291bGQgeW91IHNo
YXJlIHdpdGggdXMgdGhlIGV4YWN0IGNhc2UganVzdCBsaWtlIHlvdSBkaWQgYXMNCj4gYWJvdmUu
IFRoYW5rIHlvdS4NCj4gDQo+IFRoYW5rcywNCj4gSmFzb24NCg0KSSBiZWxpZXZlIHRoZSBpc3N1
ZSBpcyBub3QgdGhhdCBzdGF0dXNfZGVzY3JpcHRvciBpcyBnZXR0aW5nIGludG8gbXVsdGktYnVm
ZmVyIHBhY2tldCBidXQgbm90IHVwZGF0aW5nIG5leHRfdG9fY2xlYW4gcmVzdWx0cyBpbiBJNDBF
X0RFU0NfVU5VU0VEKCkgdG8gcmV0dXJuIGluY29ycmVjdCB2YWx1ZXMuDQpBIHNpbWlsYXIgaXNz
dWUgd2FzIHJlcG9ydGVkIGFuZCBmaXhlZCBvbiB0aGUgbm9uLVpDIHBhdGg6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL25ldGRldi8yMDIzMTAwNDA4MzQ1NC4yMDE0My0xLXRpcnRoZW5kdS5zYXJr
YXJAaW50ZWwuY29tLw0KDQpUaGFua3MsDQpUaXJ0aGVuZHUNCg==

