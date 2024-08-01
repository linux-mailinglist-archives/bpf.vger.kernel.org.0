Return-Path: <bpf+bounces-36212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F769445F3
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF6E1F22D9F
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30DB16131A;
	Thu,  1 Aug 2024 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9IgorCR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952719478;
	Thu,  1 Aug 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499033; cv=fail; b=vDbZ1E8tmGy/n3nJ+J+O286aaYvshsMoot8jnFsxJIV/FlOidfRPQKdllxoAYF0A/ccUJNPIWM/0qqW+QteLvX9hbYlpcJNuznujZ2Vgq9V3rk/ZnXQ4YSx76jDqnlPuASXv5Exr6kHC2woL/5428tgKA0U1IyYwrIecrYx0S8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499033; c=relaxed/simple;
	bh=BV3h2li+f+Y/sZDFCNPiel/25QXHAff7PKPG1E2LkXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sbR1818DNL+wjL5LKBX1/vsVH7NJdy6PrGWjQooBN7p9xeBd8e6ykdTKGCe+YU9ZYCYefN1oCiFDZW69+AeuuXt51aZBRPCmWI+7IsiHVuaTNDorC+PHLZ6npV1hvS9g7RCinBa/PK76h8B23ftfzFgoFS8JtuLOA7IM/g+NBVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9IgorCR; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722499031; x=1754035031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BV3h2li+f+Y/sZDFCNPiel/25QXHAff7PKPG1E2LkXI=;
  b=H9IgorCRpRDIz8dJWosV9X9OFU6sMSvPnRf/ckz1tuhV5ki8XfR+rkN/
   1Cajg6z4asZszdJqnfr9WFkRqbI1RcysVVMk52jc9Ka0SxKMTmhJxmXKv
   gWApplcO7+q2kSsqKDTo/2doB8LcxNX/2EWSwdu87JDZZYSCNk3b6nBbO
   Ur9nsKPDL/f/uWkQW6/a5CGB94Uw3tEKUJHuoWYTgtQ+ZgxuXmW/x946d
   sbLEhOWL0urnlXu1OhKq76I9u8bogfnbB4zDnXFgeGSrJKMfvexfRmhxC
   IgRRUML2JhvXmJ1iH4Nk5lWc5CN/yVj1W4+bb8xeHk+Hy4/BCpthZndH1
   Q==;
X-CSE-ConnectionGUID: 0EZGqfGhSZ+HwH4qkyEQCg==
X-CSE-MsgGUID: 6X04LdbnRWajacE/EuSCSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31065087"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="31065087"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 00:57:10 -0700
X-CSE-ConnectionGUID: YroXq190QyiX/0joOVbMyw==
X-CSE-MsgGUID: QsoJMVUyRFufjrpb3nR2Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59074457"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 00:56:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 00:56:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 00:56:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 00:56:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 00:56:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7Z3bU3aHuGj+oJlWlmzYypETDlWKI6tItJL5axXlYPNeGow9+UPT5O6vUVTbyWsqR84yLh5lGINCodkwqN0Ucg4+okB3M+3k8ei4GpoKnTMKDruK2P8cgMDxnKQLVBpH0d8Xe0VQzShM6W71C8+RQK9Zu5KBDkfSy0dMUCl80vZUASWFK+SWHtrhf/wfDlxt2BtSGzUbg6tAWBdF8AaQukbURLiGsCW7MrqGbBDN9ZOaS9lc9jsZ0iMKuiWKtgw4307+obsFimQ0iaAPyDiro1TgpTVqc53MAb7LSIlWS6JqKjUyKysEb1jfQsgUZoJQOIljFStUFHqa5fw+VynPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV3h2li+f+Y/sZDFCNPiel/25QXHAff7PKPG1E2LkXI=;
 b=PZIGqNYZmiXCwyuO6a1RC+nc1P4CQTf+F6HqPTZjvrXmA6JeBMhIOvjCHhqlpMd45uW+did6stlG071UR0imn4SsOILi9oRjjRMSDSE9GwjjWnBadsjjyZOhdeRSVTeh99OlUA+Gm2gu8eCvYf6vgd+XXWD7mwafMT3EMk4b9NVWVO9zktdFrygfjA8okKXWHTfNVohXQqdexVbYZubR/lbWnr9itZsVffcfLJEd/ShfIovs2QCMITJDYr5z0qWiT3H+BHiYhyUaMFvnPbTRqQWmSaffXCfQTUQuAqO09T4WDV9HBojnV4A7epv7F508JGA+gNWnS3Y7735IB6Sz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 07:56:47 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%3]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 07:56:47 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Shinas Rasheed <srasheed@marvell.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Brett Creeley <brett.creeley@amd.com>, "Blanco
 Alcaine, Hector" <hector.blanco.alcaine@intel.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>, "Neftin, Sasha" <sasha.neftin@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next, v1 2/3] igc: Add default Rx
 queue configuration via sysfs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next, v1 2/3] igc: Add default Rx
 queue configuration via sysfs
Thread-Index: AQHa4oNHE35HaQQ+uEqUaQ2UVmsl47ISCetQ
Date: Thu, 1 Aug 2024 07:56:47 +0000
Message-ID: <PH0PR11MB5830F3526D9A3213D736D045D8B22@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240730012312.775893-1-yoong.siang.song@intel.com>
 <9216e5a5-c2aa-4f08-8c53-7622b95b92ca@linux.intel.com>
In-Reply-To: <9216e5a5-c2aa-4f08-8c53-7622b95b92ca@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH0PR11MB4824:EE_
x-ms-office365-filtering-correlation-id: d6b27566-cb2b-4a2a-d9ca-08dcb1ff7ea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?MW1idHRYVkE4bG1tbXpxWDVrYTRBM3dNMDRQUEpUUUJtdjBHdGNQb1lab1Qz?=
 =?utf-8?B?dWNtVDBOZXdweGxsMWtqbHhveUJDUGhISTNEb2czY3NFN28wMGpqRU5vUDFa?=
 =?utf-8?B?WGdkSU85K01NS1lVSXJ4bndmd3RxYjArOWQvUTZqQXBrR1hHRk9aZ21tL1RZ?=
 =?utf-8?B?RlVudlN6VmJsaElxYWlFbTN0bUZEajh3Mmx0S2pSdGhITkNtQng1R2pzV2hG?=
 =?utf-8?B?MUxURVltL2xFaGRXWGdUbmJEemp1Q0luMDhldXI1YWRHZkh4b0N3dVlJT2pq?=
 =?utf-8?B?RldOR1Vvai9kV3oxa2VhaE1HazNyKzd0ZFM5SEc3L0Z3V2ZTdXN3MzJjOGtX?=
 =?utf-8?B?R3M5S0V2NThDOTI1UVQxWktmTElxODJSSG9GanBjRExGMGZqQjMycGpabDNa?=
 =?utf-8?B?MndnK3lxVnJTYXV0RWE0VkYrNGVSKzJPc2lUR3lSOEFEQy9WZUxSOFFEM3lw?=
 =?utf-8?B?ZjB3VlN6VXg5ckpmdFltTmZNWVZ0cThFVnV6TFhrQk4veHdkbklqT24wTmZJ?=
 =?utf-8?B?T0s4dnIrNDdQS1dLbmhYSlpoZTE2SnNVNEp6YXFoV2FFWHRLa3RaenQ2ekJ4?=
 =?utf-8?B?NG5WTCtOK2JGVlpVdFZFRlBvbjRUS0s2SjdBdWZ0d05ja3MwSzRCaFZuOWta?=
 =?utf-8?B?NEhFaEFSejdwbk1hWlR4UzFkRk5BU0ZrNXBFT01jSGNBTjVPZ0M0R1h4MjBh?=
 =?utf-8?B?Z09XRzVXU0dtT3VMdUpuMXFRMTBzVVBnYVluVSt0cXY4YmRzYjFZZEtQeVFO?=
 =?utf-8?B?YW5UTGRoSGszdmZqd2hHM0UyMkZCaUhLMTJ4UlJDN3lUR1pudlY4WTRXZmQ3?=
 =?utf-8?B?MHdnSm4xbGhkRkZXZWh3RWV1a0lBUTFEZjJGM0JPeWNrS2tnbWZzaDZZSWVj?=
 =?utf-8?B?dDg3bWFXOVlsek1FOUV1UDYvN09LTUVPV2ZsUkc2SGs2MUhwV2hVY3hiYmtL?=
 =?utf-8?B?QlNNWE9yWXZObk9ZSGNlLzgydnFaY2IyK1hBejRZWWgxa3NMRENocnBLSjJa?=
 =?utf-8?B?VlgwU3p2V0pYbzJLMHNQdnBEOVhZa2JuNDJuYzc0L3BwT2FvaWE5NW9iQ3Rr?=
 =?utf-8?B?eHFjSjZxMHFHNVNjV042OFVDTkpINkRDL1BaTERuWUQ0RlVPNGV5NmpDZVVQ?=
 =?utf-8?B?UDdkZWs4a21Wc1RYQXMxbEVlUzFyeHlrNFA4RTVYaUZPaUxjRDFkMXVLUHhv?=
 =?utf-8?B?d3hEYk5JeXRRNHB3bW96U290bkhJVDZuM2x0cVBhT3loSzU5VHYxZWo1OEVU?=
 =?utf-8?B?Y2dOZ3RsQWNhS2hpZTFRTUxmcWRadVB3YzVYcFVPVVpiRVBvT3E1Q1VUeXYy?=
 =?utf-8?B?Vm03eHUyOWp0T3dDVFc3UXNkb25BVmlqWUdoMDByVjdHM21oM21jV3l5L0Zl?=
 =?utf-8?B?Szc4SVpQc1FRcTMvOVkwY0ZTT21VUmtvZnd5MlRnWE1zVG05Q1M5elVSdlZK?=
 =?utf-8?B?NmZSK3NuVUJld01COU9OSmE3SlQxYmJaNUF3UXVlN2svZkdWZ09jdy85cGo4?=
 =?utf-8?B?MXpNWEt5Z3NjWXNCZC9hVnJUaUE0K0kvUy9MR1NVbXNHbHB1M1BqeE5FWllG?=
 =?utf-8?B?Q0lLalR6SUpuSTBhemdKc25NVkg5K3REWHdCYkFNclRVaE96S2xVS2xWTkJh?=
 =?utf-8?B?YXZhTUVCMGRVdk0raUt2WFdGUnA5OXhtNnovaWZxc0xhcmpqZDMzaWhOc0xO?=
 =?utf-8?B?ekt4Q0RTS28vVE1xMmRJQU1NSCtkN2xwLzlCVTQ4dW5qdzFFZWlvc1o0TjZz?=
 =?utf-8?B?YkZBS0dZaGR2UW4xNUVtR2swWDJFUnB6UUV2cXA2a2xaK2lrbHgrM0dEeGgw?=
 =?utf-8?B?WFQ1aURkdmh4bWFySVU2UWRaMExsMkhEb0d6eGgvaXEvOG0rSGxiOGllWnFF?=
 =?utf-8?B?MnFnbUdIaDdlRzFBR3ZWYzAzODVtSUlxb2hLSUF6aG1YajRJdVA3NTJsbVc5?=
 =?utf-8?Q?kopwp9pq+v0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWZWTG9ad3pyYkkrdEpOMWNkVnRsSW9XdWMrdHo3aGd5T2IvdTlzWGl2QlBs?=
 =?utf-8?B?OUMySGxiZXozK0tERUJSK0xDZHJJTzczS0xZcDhqWGcxTEM0c2s1cm43RVMz?=
 =?utf-8?B?VERmZFF0bWhsVWhoMnAvaG5xVUd1QnY1eEpzYXJiYkNCUkg4dTBQdzBsdVd3?=
 =?utf-8?B?V09xWmk0ekMwWEdQMTAweitjRzFQUkltSWcyRklWelhLUkFiQTZLUjJwQ1li?=
 =?utf-8?B?aXUwVzFGNjBOekpnOG9uaS9HRjIxTWh2cXNiTDd1RkJBTnJYMXY3eElGTkh3?=
 =?utf-8?B?bTBoNENyQk53YlBpU0tYcjZVaG9sWTkwRjVocWtYNjQxTktOQXVSNkdMRCtW?=
 =?utf-8?B?RTFVakNqdDRMTWh1MTJ2SExWK21KdXlFMXpCYkVnM2FLTXJPVXluZ2lDY3Uv?=
 =?utf-8?B?VjJPazZYRFhIcGRXQ0RUd052TXVJc1p0SHFlOTBWcVdiaVpETlpkYkxtRzF5?=
 =?utf-8?B?S1pUdzNEbmduK1RTcVVZQ21pb1RweDI2elBMZ3RFYzRLb3pHU0F1anVGWTV3?=
 =?utf-8?B?WFNnQTBQMXA4ODZpbHRGelkyN3puLyticThNeXJFZ09TNEJ4VFp2TGpTRlMw?=
 =?utf-8?B?SklFZUVFK3NzL01aRDZDZFpRSUlZUTlvdzUwdUMxQlNEWUlPeHBrTXhyZVVu?=
 =?utf-8?B?cFEyd0dOaHpuZS9zQVl4V3RuTlIrUVB1Z0RvREc4Z0theWdzUEZpT1FjLzVF?=
 =?utf-8?B?WTJpeUxZVmFkSjJETW1NTXJ5dE53RWd2czIyQnkwL0ZYb0hmcWVFU0dPZStH?=
 =?utf-8?B?OHFnYjlMWlZSTkRSa1VVTnpIVHBLSExFK0l1bXpyY3JUOUZBUVM0RFg4U3l3?=
 =?utf-8?B?bWlsWFBseEhUN3R1bm9TVERCSXNOZDgzajRrZHdqQ0lYRU9hajc2bDJSSXZ6?=
 =?utf-8?B?K3I2OG4zVVM1ejFoOW81R0cwb25Va25xd29YcXZoS2ZzeDZPbnI1TUNLaWty?=
 =?utf-8?B?QWdBNUh1RDh4angydzBSWHVvVmtjSlprOTI2UWdWaUFFekZSd1ltU1dWb1dD?=
 =?utf-8?B?THd1WGpQZ1FvY1l1cHlFcFNoUnpNVmxWeVpscWxuM3RHYzM1cm1ZWEM2SXRv?=
 =?utf-8?B?TEh5NURlU3JDVmlXYVZGODc3N084SjQwYlV2OXBONDk0cC9ydFp1QmprUTZj?=
 =?utf-8?B?a2loSUZpT1VlKzZYNWZ1eTAzV2ZjTW9JbGs0cUpZS1VncTVaTE1EcHlPYVFL?=
 =?utf-8?B?ekUvOHpJUWE4Nk9rYnlsTHh0N05HZjFiTjdZVUs5VUU0Z29ybWYzN3hVU3g3?=
 =?utf-8?B?UE9kcVdQRTROSkZEM0F0VG8yWHhybm92OUVjRWJWeFZwUEJsYlQrYjVjYWVB?=
 =?utf-8?B?OE91bU1JMFN3YXZIODBNcTFtZmZFNnVOb1JCQ3FRdUIyWnRlRzdmQVFiMDVG?=
 =?utf-8?B?SXJTeFR3ME4zMERvSHE3aFoxaTd6UTJua3pQK3U0WFFUNXRNOXhrclRaY3hP?=
 =?utf-8?B?T0ZZZ2FWTjRyak0yY0gvYytrblpRNWU2M2IvMXR1SmpPMkNEeFVOWXBIZHNO?=
 =?utf-8?B?azJXQWRyR3RnaWlOOFV1RU1iSG4zaE1RcGxvMHpQTTBqSzVRYnN0cUMxSVR0?=
 =?utf-8?B?TW4zYlNNWjNlSDg2TnBkbW5ZdXdiUGlsZ3BOdVUwQ1p1dHJGMEtMdWJGUzRo?=
 =?utf-8?B?aG5SdzJ3YXdDb3g1SzRldk15bU9SRjZBR0pUZmVIWGhHMlp2TjhIcjg5dkZU?=
 =?utf-8?B?RU90WXRKUzROMlVQek5TeThPNWg2bitSOUhUUVloVmRBUUtSQ3I2WUU3c01E?=
 =?utf-8?B?cVM4NDhnS3NEODhHd1VWbVN5eTlLTmJJWjNJL0lVVExkS3JLSUVZMWRlcFZp?=
 =?utf-8?B?WGtBNEJNdmtwNUtLdjc3K2VVcFZnZEI2MUJzNEMreXRkbGFEQUdoeGhFSk5t?=
 =?utf-8?B?TEFjWUdjMWR3cmpuV1JydTNrL1JTZHp1Z1JlMTduVXhOTjJaTGtTaVd4enk4?=
 =?utf-8?B?cXVxeWxrd1c5RGNVQUJhVlBxM3BLdTF6VktXd0ZLV0hLeG8vb2RKU2oxMnRP?=
 =?utf-8?B?WUE4eWtnWVo4ZmNacW5zZE42OTRndzAvcHVuMERDTzBuMXVNODUzdUZ6SUpN?=
 =?utf-8?B?VXBKK2x5eWJVRGtaeDd1Z0x6RS9XKzhZVFJoR0o4V0IybjhENTZPR2c3a0Zs?=
 =?utf-8?B?QW5LV1NSWE90K3pVd3JDaUhrdVBvTjhXZm0vbkpXYlZnbTN2K1NMUUZzMVQw?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b27566-cb2b-4a2a-d9ca-08dcb1ff7ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 07:56:47.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSyNyVjKGMuebm+ndPBd8O6NvVNCxwbFEiBS2D0IaNfH3dTyFQ3VLAAPHAht7lySl9VYvJEJkM5f7TZ5UyScJMoR1q0iJtv7VVnO5TivjwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com

T24gVHVlc2RheSwgSnVseSAzMCwgMjAyNCA5OjIwIFBNLCBNYXJjaW4gU3p5Y2lrIDxtYXJjaW4u
c3p5Y2lrQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+T24gMzAuMDcuMjAyNCAwMzoyMywgU29u
ZyBZb29uZyBTaWFuZyB3cm90ZToNCj4+IEZyb206IEJsYW5jbyBBbGNhaW5lIEhlY3RvciA8aGVj
dG9yLmJsYW5jby5hbGNhaW5lQGludGVsLmNvbT4NCj4+DQo+PiBUaGlzIGNvbW1pdCBpbnRyb2R1
Y2VzIHRoZSBzdXBwb3J0IHRvIGNvbmZpZ3VyZSBkZWZhdWx0IFJ4IHF1ZXVlIGR1cmluZw0KPg0K
PlVzZSBpbXBlcmF0aXZlIG1vb2QuDQo+DQoNCkhpIE1hcmNpbiBTenljaWssDQpUaGFua3MgZm9y
IHlvdXIgcmV2aWV3IGNvbW1lbnRzLg0KU3VyZSwgSSB3aWxsIHVzZSBpbXBlcmF0aXZlIG1vb2Qg
aW4gdGhlIGNvbW1pdCBtc2cuDQpbLi4uXQ0KDQo+PiArLyogTVJRQyByZWdpc3RlciBiaXQgZGVm
aW5pdGlvbnMgKi8NCj4+ICsjZGVmaW5lIElHQ19NUlFDX0VOQUJMRV9NUQkJMHgwMDAwMDAwMA0K
Pg0KPkp1c3QgMC4NCj4NCg0KTm90ZWQuDQpbLi4uXQ0KDQo+PiArCWlmIChxdWV1ZSA+IGFkYXB0
ZXItPnJzc19xdWV1ZXMgLSAxKSB7DQo+DQo+aWYgKHF1ZXVlID49IGFkYXB0ZXItPnJzc19xdWV1
ZXMpDQo+DQoNCk5vdGVkLg0KWy4uLl0NCg0KPj4gK3N0YXRpYyBzc2l6ZV90IGRlZmF1bHRfcnhf
cXVldWVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiArCQkJCSAgICAgc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgKmF0dHIsDQo+PiArCQkJCSAgICAgY2hhciAqYnVmKQ0KPg0KPldoeSBubyBp
Z2NfIHByZWZpeCAoYW5kIGZ1bmN0aW9uIGRvYyk/DQo+DQoNClN1cmUuIFdpbGwgYWRkIGlnYyBw
cmVmaXggaW4gdGhlIGZ1bmN0aW9uIG5hbWUuDQpbLi4uXQ0KDQo+PiArc3RhdGljIHNzaXplX3Qg
ZGVmYXVsdF9yeF9xdWV1ZV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiArCQkJCSAgICAg
IHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPj4gKwkJCQkgICAgICBjb25zdCBjaGFy
ICpidWYsIHNpemVfdCBjb3VudCkNCj4NCj5EaXR0bw0KPg0KDQpOb3RlZC4NClsuLi5dDQoNCj4+
ICsJZXJyID0gaWdjX3NldF9kZWZhdWx0X3J4X3F1ZXVlKGFkYXB0ZXIsIGRlZmF1bHRfcnhfcXVl
dWUpOw0KPj4gKwlpZiAoZXJyIDwgMCkNCj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPg0KPldoeSBk
aXNjYXJkIHJldHVybiBlcnJvciBoZXJlPw0KPg0KDQpXaWxsIHVzZSAicmV0dXJuIGVyciIgaW4g
djIgc3VibWlzc2lvbi4NClsuLi5dDQoNCj4NCj5UaGFua3MsDQo+TWFyY2luDQoNClRoYW5rcyAm
IFJlZ2FyZHMNClNpYW5nDQo=

