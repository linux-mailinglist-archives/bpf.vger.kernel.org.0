Return-Path: <bpf+bounces-77347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FDDCD8572
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 08:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A1CA30141E6
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D3308F35;
	Tue, 23 Dec 2025 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzOTyhNi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C425B1D2;
	Tue, 23 Dec 2025 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473393; cv=fail; b=tB1NuHGwwVYqRNJVw990FUDsxTMl+QGk7oKhoOyS96O35dSgzkhd4rExM9jGhTuXih33vaFyZ4CJkN+8rzvJRyrD5OEjCLtrDdlWSSOnmNer9G0v3fBWOfLKWdFiwfeB3mOqpb7Y+ZKEmhiDf1bZlOlqKz6E+akHPJx5GxpYk2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473393; c=relaxed/simple;
	bh=+pE/4OJx3TMsNz0ECM0MRJ3dM3wjQRRIwLAHvyHt0Gk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pX+DgU1GqicChK/0/F7sQpeml5+ggFzHjPDd+Or46VhJ6Kyemyn5RZ84oaS34PK6v/tmVOp2bnvpPFTZ5XbrWVXRsbL44Q1ND3stwhtoW+5nSapzm1envNN48COUTYEj3ImPLb0uicmVykmrUbcf6C8FrYB4uzHUc/AcYfN9aas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzOTyhNi; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766473392; x=1798009392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+pE/4OJx3TMsNz0ECM0MRJ3dM3wjQRRIwLAHvyHt0Gk=;
  b=SzOTyhNifYx3J6QEjjgybzmw5ydQ2J2JsXfM8o/XMsMzPxtsjq+FhLOh
   DqcIuHM0r0oN9jaUOqCQvtcTUSUZ9D4CdEgBQfmDl4TSnipGGzS7f4g4E
   By/03B8dw7uUt8uqj8lX3SZb2zdCP9IJQ/cJQgZf6ECwRsSCeS/DiCIpu
   uQ7dsj9LDvvMYU/MejP/ognak+ATEDz8tx5Ay7KDM/dN9ZXOKyczUDk2V
   W6KIbPZaeADAI+RezNoJz/O6sltuho9ey4oE3uhFkh+L5VgTB9z9lsYTy
   /ykbqqbpc/WkE9SzDIgPI/pEXHlyW7+HNfukL4jP8cQyYq2NyxnusMNjX
   g==;
X-CSE-ConnectionGUID: 0zYnIaWwRJa1bnjVbOwvWg==
X-CSE-MsgGUID: o0xJpJMgTIK7IKWrSebPPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68367337"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="68367337"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 23:03:11 -0800
X-CSE-ConnectionGUID: ah8DQQYxRxuZ3bCaUDlF4g==
X-CSE-MsgGUID: nPgCgtoqRaaT6oBLroKl4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="230377490"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 23:03:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 23:03:09 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 23:03:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 22 Dec 2025 23:03:08 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 23:03:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpqVg+ymm/mnyT3B3eUtNma57ojbhHxcOBTG+XTKl4MRUJK6R95PhhjTfE9p3WqvPlwUjFNfP9V09Dg2r5TNakypVtiLtRE1f2MYaDGerXPsIp367udMi49D6ti7ePNuSKf1TEiIEh9nerFkHxS9nnNhL6TTNFmOpj8CAfjNF/t6JsB15w9j0t2t4WIHG9l/qLFHa5k3gBALHA9p9OzjsZQp0RIECJsmev/pPIrUYv5mYhlkjxjepET2mCdXyrI1TDzAI+pVJ4yQVtIHs0iDb5Wbqmu8UhzCkX36hQy3uzxw4BPmjMD/dr1BEMXkKrdTZNd6vUvr7Cv8Xyj+G3BSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pE/4OJx3TMsNz0ECM0MRJ3dM3wjQRRIwLAHvyHt0Gk=;
 b=iqeTay/hhZRaHBW2TTX5fPFUD+jSME6ZFpqwBF2Z1pxcR417qq2fnw0pKyKd1V5BhrX2E/bFzzhpKc7V81h8OrOcK7zL8Iyp+pjEYWGzWUa2ys4YYHE6oJxBZpbMEDdQvX9fqnKNiv84deVw/b8t1Ub4CIqd980m6mbI/j9HskjL4ogJbmjBvN70vhi0bU/cgiOozYQORj3A3x/1BuBp22jo/94qwDyCeNV5k+XFrT+eLWaESQ7rjvinLrcwQfmq4MQLVDfyO13MDIZHj2LhF3yJGCcPmvwP8hHLdxX2dLk9+5Dk0QyOlQelwcgezLU1UqrpJ2VwPZLRCzP2HpXRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 07:03:06 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 07:03:06 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mina Almasry <almasrymina@google.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, YiFei Zhu <zhuyifei@google.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH net-next v3] idpf: export RX hardware timestamping
 information to XDP
Thread-Topic: [PATCH net-next v3] idpf: export RX hardware timestamping
 information to XDP
Thread-Index: AQHccSZKUqft1eQ84k26lGfaUYKV97Utod2AgACpSYCAAIVZEA==
Date: Tue, 23 Dec 2025 07:03:06 +0000
Message-ID: <IA3PR11MB89869D66D321FA1C1E5CA23FE5B5A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251219202957.2309698-1-almasrymina@google.com>
 <870f89e4-aec2-4eb2-8a93-c80484866c6d@intel.com>
 <CAHS8izOOyGTYkMct=VJM8jHmzQgXR7y143erxfMvkPOkVJrXJg@mail.gmail.com>
In-Reply-To: <CAHS8izOOyGTYkMct=VJM8jHmzQgXR7y143erxfMvkPOkVJrXJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7485:EE_
x-ms-office365-filtering-correlation-id: d4c2514a-07dd-466c-6a2d-08de41f15288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cTVPUzZMSU5MQllDcDJNK0cwMUpDWWV3NHVRaUhlSnRoRzJuQTkyOTgycUhj?=
 =?utf-8?B?ZVZucUlIeEo2NWNjcEZLNEVqRFlMS3dIcHRqVzZ0STFjaHh3ZEhOL01uOGQ1?=
 =?utf-8?B?KzZxd29oQ0g3VllIQkRCc1I4Y2tvZTB1VVpvaHZFZUhFSUVFT0hDQkl0V05k?=
 =?utf-8?B?a1BPSjRKTjdmd0ZsdkZ0OXVMMThudXNTb1ExZHdaMXlBeUtTRFVvUStKUEVF?=
 =?utf-8?B?UERQMG1QZDVYcEZWWThHaFJiWEpzL2pwQ1VmZDljd3plOGJWcWswdGtoUWd4?=
 =?utf-8?B?MVJZM3ZOS3l6a0ppT2w3QSt6K0d2aGlib2p0bk1pOVFtRVp1ZWNqL21Qcnlv?=
 =?utf-8?B?M2hjQmZYWE9EUFVxMTVHdmNiMmViRy9RZTEwcitHUjVFY0dDb3VHaHRxcTYr?=
 =?utf-8?B?MXZhMWtsZVdvS0RUa0JqWm9uUkcrbTZvMUY3cnVoNFdMOHJVZ2NScENBaG9O?=
 =?utf-8?B?RVpnVE1MYk1HNW5Ld0NLMDhUQ0ZlVGkwbmFVUFFISXJML2JuSWQ0bUxlVjZH?=
 =?utf-8?B?NTVTUlJXNGN0WjhzOWhEREc1aFNZT1daV0pCY3RiMUNWRUhDb1FSdHgvQVAx?=
 =?utf-8?B?N3NkTmhIaTU2bEpDMy9vU24yUllOdHl1TlRoeXc2OTJEdU5vNTEzSHkzaU9T?=
 =?utf-8?B?UDZVOHl2Q1hYSTlPS0lmbHozSElxMjZUZzN6YkdzMGk0UFJNQmtrTmg4Si91?=
 =?utf-8?B?cXFQRDF6ZWZudVpnU3ZiR0o1QzQzWHdtT2FSbllCUkY4VXNvN2Fqd2FwRDhw?=
 =?utf-8?B?VUsyWkhXc0tReUJoK3gwbWkyeVBUQ3FCL1h3RWNEQmhGOHZja2E2YytjenJX?=
 =?utf-8?B?clVIdlpoSFYwWUgyYWxUc1VoR2FCc2J0dDZCcnJVb3FSVnk2ZGNNV21LNjhI?=
 =?utf-8?B?allsMnF1MVJjUDNaREIycENWVUpyM2IycXpmdVNMbUtkV2NOWFFzYlhSUXNU?=
 =?utf-8?B?OExidFQxZkJvZW0vRjVTZEVCNVNVWnY1cVpGWXBlV3lPZ0NwSnlVUkE4SXd1?=
 =?utf-8?B?REZkQmVLN2pUYTQrSXNaYmZHaWlpWEMzdWZaMlh0eldqYWtUMllxM1dPUjZP?=
 =?utf-8?B?TG9sS001a3E0RDFYdEc1SEhBZ01obk44dDVmdW10NFlyWXRidS9Mck9YYUdo?=
 =?utf-8?B?TzBMQUczYzF5R01wd3RoZ2FTWVFEYXhYd1NYOHExWktiUWpCTlZWTnZaMjZw?=
 =?utf-8?B?SXlqWmFXSllnQWFSYjlGTFl6d3VwaWVURnNpdHVBcE5xRnYzYTAxdzJEMEZR?=
 =?utf-8?B?NGJ2aHllV1lVOE0yeFFMbGZITEgwZkVteE9xM0MweDdaaDFBNlJjQ0RMc252?=
 =?utf-8?B?RnNzMkEvcGZMeksyei92M0h0UmhlbVNNSjVoUTZ5cWlzeWFzaENHVnMzTHk3?=
 =?utf-8?B?RndjSGt5cFBqc25iOXJSL1hkVHlWTlFCeldQdzE4Zzh4UzJkcDFqa1pOYlJh?=
 =?utf-8?B?V0o0QUE0eVBRMWI0Mzc5ek05azJLOUhxREVLS2M4d2QrRjdRcHJrZVFIU0VY?=
 =?utf-8?B?WWZ5RVdNMWczZkRKK2EyR0JVTkpUS3dKRWwwbXZweTBFT05UZWZOM0pyL3pa?=
 =?utf-8?B?WXZoZFN4TjQvWkdwMGUrNGN1Wld5MktqVjdhWEROd2VpaFRXcEhyYjArWThq?=
 =?utf-8?B?Ym9zbHZrYVpSeFZUdFpack83WGVpS3dHdTFMSW1RYVZXeU85N2pqYURmL2JQ?=
 =?utf-8?B?OWZMWHJMR0I3UEV1bVBpeDBoZTlCK0h1cE5ZaVRHQkhyV2JGSGJnRXVLVTNV?=
 =?utf-8?B?ZmdXNGVQSWdaOFowY3NuUVBNOVNuS1NrVFhTTmFqL01KREtRSytEVHcrcUxI?=
 =?utf-8?B?WTJJWHBsbm45Tkk1aDhaR1hpYWxGQ3lSZFF5amJ4dHc4MFJXTThpdlJhbHhH?=
 =?utf-8?B?OEsvdkU5Qnd2Skx2Z3FrdmZtYWdkYk9sWmFHVkNyM3lmN3JjYzNKbVY2TlB6?=
 =?utf-8?B?Ly9FR1BBMnNYZ0JRZmNqY00vWEQ0dTdkZVdqTElSS0JVejlJeTF1NENLY29Y?=
 =?utf-8?B?amVxdHg0Zk9lMzVzNE84V3dmWEo4UzZHVkc3Q1FZQkdEeU9wc2ZBc3NaWEVB?=
 =?utf-8?B?a3h3L2I1M1BNcGxJVSs4bUFaSnlva1dsWWpiZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTdtRURrRjJNbDlzV2laWFpWeFg0clhBTVpoa2FUWGZvcktDbyt5Q0sxMXFa?=
 =?utf-8?B?WnBoUVo1Q2lPTUswaDluNjIyMDN0dXZrV1BTNDdlV0dBaTZDenJHTmNLa2ZC?=
 =?utf-8?B?OGI4dnZmemNPeHZWU0FYdE1GQ25TQ1dYMWxhRzV4aU14citpUkNITjRNQjhs?=
 =?utf-8?B?ekZFNVZxeFRXdnhnR0JwSWdDL2lKYTFVMUVYVEdhczJtdUpRYjA2aiswUEVD?=
 =?utf-8?B?dk5nWVBGd0E0N1g4WEx6MmxseE1pMHpJejk1R0V4RnNqSnZDcXdBQ0drSkRn?=
 =?utf-8?B?eVQ0dmxKMHA0amhhQlh1YW80Z2hvNEtsaXp0M21LV2k3L29hbW4vMis5RHVp?=
 =?utf-8?B?dHZTMmxWT25tSHBlNzZoNGNZbEt1UlFMd3EzT1pJUUpLTVNHZ3lYWmI2ZEMz?=
 =?utf-8?B?Y3BDd1dyZXlQN2l2b0x6cWhkaXM2U0dza21pY3RSeXUvbG51QlhYOWYwSEk4?=
 =?utf-8?B?cCsxY04wOUJGdzMwQVdNeE5pRTVjZ2RUUEx3UmE0VkZVZEdPdkxWTVMyR210?=
 =?utf-8?B?bC81bFFwMkd0eGtONEtuNVF3MEdCQ00rOVZQSHJ6T3BpNG1vc0d4c3ZEYWM5?=
 =?utf-8?B?YkFqM3p0RnZ3N1BXbVlZK1ZWeVBIQnhFdHZZSm9LZjRMMjV5UTQ5NHBhT2s5?=
 =?utf-8?B?anZ6bWVIZEZYTVpuY1p6REhlSC8reEJYZVhTY2I1bTBGd2ZYc1RLRkxDL09t?=
 =?utf-8?B?U2hPRXpHKzdDYjVSVmU4YzAyb1RBY2FlTjhOYklpZU5IT0Z4UTNJSEszVzBY?=
 =?utf-8?B?eEkrVWY5VytwMGRCclVtYnM0MlI5N1hpWCtZZmhBRkF0SzI4NnY2aFVyMTZo?=
 =?utf-8?B?YWdXMlNvdGFTeURncThWWHNqOHZpd1Vyclc2aHpCOXFHNktZK1UyS1FBd2Zx?=
 =?utf-8?B?U2FwcFcvTW9OMnFkdFlQUnJ0Snd1QXkxSFQvOXNtbENWbytaMG1ydmVXUWd3?=
 =?utf-8?B?Und0RG1CQmRNbnRGdzk1eWtiMGJ4LzRqSGNiRUpsZVh3eTFTNGJjS21zUld5?=
 =?utf-8?B?TXBtZlNjR0x6VVF6TU9WZVNvdFBXTGJvdzZPeGhYWm1IT0p2NWlYN3hCemNK?=
 =?utf-8?B?L0JaTEhibFpTYlQ3NmJvRXI4RXQ5bnhiMUR0cXYwU2ZOelFhMFJBcEx0TVRG?=
 =?utf-8?B?Yzk0dE5wR1lhK2JzQVplaDJ4RHh1NFdlZUZ6WXI4M3FnSEZ1RVNjbkV1ZldH?=
 =?utf-8?B?NVFiUWJpc1liZ1dQZE5WeFRva1FYZENzU2tpVUxaT2xVL2hOanZ1UHRRRkhw?=
 =?utf-8?B?bTU3Q1V3VVBaMFVTY0JxWkVYTTdXTWJyM2oyd0hBM2dicjFiRGgydGVoU05U?=
 =?utf-8?B?b2pTelNVK2dIZ2x1Wk1pK2xJcG4zNTFHN1dTazZjQnEybmpBZXU3enJoblcr?=
 =?utf-8?B?N09GVTNPTnBrWGx0ZmNvMkpkODRHNlRURmhVVkNzZ2ZMWUdYN3ZUeFIvQlY0?=
 =?utf-8?B?QmV2QThFbjN0TS9xNmkrN3R6WjMzdUtNbktQRTBjYW16TDVXd01LTXBqZjBx?=
 =?utf-8?B?NzlaZ2kzbk9sRnB5N3JrMlI3YW4vdDJ0UlMwR01NOU9WQUtaakJwOGFia1ZZ?=
 =?utf-8?B?N1FOYzFKeFBaazBzRWlHTjU3RzFBYnJNNDAvVXNxQS9sRmJta3lTSE9XYlps?=
 =?utf-8?B?MHRYTkYxSkZhSHhTd2NXNmhqMW1CWURvRnRCZXJsOE1xRHZpZHRvK2x3eXVp?=
 =?utf-8?B?Q1REUmlQYVpKZ0p1NzBhU1N3RHVnRkpkcmhZSjNwYXl3aGhTYU5rdnlKY2Za?=
 =?utf-8?B?YzBQV0dJdU10eVhoRjVjc05NekhnQ0ljVkxRVW5DRmdZanQ0OFRJWnQ0QVJk?=
 =?utf-8?B?NG5ZUDludEp4SjNBOW94cVg4NlF1a3AxSjQyTjN3c3lBOGl0Nk5pWmtXTVN2?=
 =?utf-8?B?MzFtdGdndTU3SG04VDZDVmhTWlhNWFJNc1NJeUxndU1IcEdJQXdoUDNoNW1G?=
 =?utf-8?B?WEtteVNBenlORmNRS1BIVmtudVU5czBFTm9mNnByZ0Zrb0E3UG1pcXlYY0ZX?=
 =?utf-8?B?eVBsZDZ6aVRWSDQzN2Y5d2pQdHJlc3psek8rU1dsNUR3VzAydXNpQTJzSUI1?=
 =?utf-8?B?S1JRa0duZGdpZWkxMkNScno2MXRXOHNkak4xVld2RHQ3VkMwQnFheEVOektp?=
 =?utf-8?B?bnprdGxmaGxLVTdobVY0TzZzYWxsYXBUcEpualhUREsvU2loOEpzNTcwb1M5?=
 =?utf-8?B?aDg2TEhzVlBZN214QklJMUN3ejBvd3ErcnBUOEM4UldGaHdreEFmUys2U3ov?=
 =?utf-8?B?S0YvQUpjd09FZVBYQTZWamVwcjEzWTVLa3QxcWhWQ0R4dTl4a2FwL3hsaSt3?=
 =?utf-8?B?elhwTUJLQ3cvazFZUllyUVBhL3lwRm0zWWx2aE1MdmEvQndRMlo3OXBZOTM2?=
 =?utf-8?Q?q6B9xzMg+Qy6qTzs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c2514a-07dd-466c-6a2d-08de41f15288
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 07:03:06.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRGhjWTg+rZqsSGI3XIwRZi3nXjh4Najc1kpd0P9plc69i+4qUTW3vlorIxEUdRcMl3d83ooX/lLByNPqP5K1H0FigsLw/ILV9g2AWb2maQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWluYSBBbG1hc3J5IDxh
bG1hc3J5bWluYUBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAyMywgMjAy
NSAxMjowMCBBTQ0KPiBUbzogTG9iYWtpbiwgQWxla3NhbmRlciA8YWxla3NhbmRlci5sb2Jha2lu
QGludGVsLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGJwZkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBZaUZlaSBaaHUgPHpodXlp
ZmVpQGdvb2dsZS5jb20+OyBBbGV4ZWkNCj4gU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsg
RGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD47DQo+IERhdmlkIFMuIE1pbGxl
ciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEpha3ViIEtpY2luc2tpDQo+IDxrdWJhQGtlcm5lbC5v
cmc+OyBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxoYXdrQGtlcm5lbC5vcmc+OyBKb2huDQo+IEZh
c3RhYmVuZCA8am9obi5mYXN0YWJlbmRAZ21haWwuY29tPjsgU3RhbmlzbGF2IEZvbWljaGV2DQo+
IDxzZGZAZm9taWNoZXYubWU+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBp
bnRlbC5jb20+Ow0KPiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50
ZWwuY29tPjsgQW5kcmV3IEx1bm4NCj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IEVyaWMgRHVt
YXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IFBhb2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0
LmNvbT47IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5AZ21haWwuY29tPjsNCj4gaW50
ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IExva3Rpb25vdiwgQWxla3NhbmRyDQo+IDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQt
bmV4dCB2M10gaWRwZjogZXhwb3J0IFJYIGhhcmR3YXJlIHRpbWVzdGFtcGluZw0KPiBpbmZvcm1h
dGlvbiB0byBYRFANCj4gDQo+IE9uIE1vbiwgRGVjIDIyLCAyMDI1IGF0IDQ6NTXigK9BTSBBbGV4
YW5kZXIgTG9iYWtpbg0KPiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBGcm9tOiBNaW5hIEFsbWFzcnkgPGFsbWFzcnltaW5hQGdvb2dsZS5jb20+DQo+ID4g
RGF0ZTogRnJpLCAxOSBEZWMgMjAyNSAyMDoyOTo1NCArMDAwMA0KPiA+DQo+ID4gPiBGcm9tOiBZ
aUZlaSBaaHUgPHpodXlpZmVpQGdvb2dsZS5jb20+DQo+ID4gPg0KPiA+ID4gVGhlIGxvZ2ljIGlz
IHNpbWlsYXIgdG8gaWRwZl9yeF9od3RzdGFtcCwgYnV0IHRoZSBkYXRhIGlzIGV4cG9ydGVkDQo+
ID4gPiBhcyBhIEJQRiBrZnVuYyBpbnN0ZWFkIG9mIGFwcGVuZGVkIHRvIGFuIHNrYi4NCj4gPiA+
DQo+ID4gPiBBIGlkcGZfcXVldWVfaGFzKFBUUCwgcnhxKSBjb25kaXRpb24gaXMgYWRkZWQgdG8g
Y2hlY2sgdGhlIHF1ZXVlDQo+ID4gPiBzdXBwb3J0cyBQVFAgc2ltaWxhciB0byBpZHBmX3J4X3By
b2Nlc3Nfc2tiX2ZpZWxkcy4NCj4gPiA+DQo+ID4gPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3Rz
Lm9zdW9zbC5vcmcNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaUZlaSBaaHUgPHpodXlp
ZmVpQGdvb2dsZS5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5hIEFsbWFzcnkgPGFsbWFz
cnltaW5hQGdvb2dsZS5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25v
diA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+ID4gPg0KPiA+ID4gLS0tDQo+ID4g
Pg0KPiA+ID4gdjM6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNTEy
MTgwMjI5NDguMzI4ODg5Ny0xLQ0KPiBhbG1hc3J5bWluYUANCj4gPiA+IGdvb2dsZS5jb20vDQo+
ID4gPiAtIERvIHRoZSBpZHBmX3F1ZXVlX2hhcyhQVFApIGNoZWNrIGJlZm9yZSB3ZSByZWFkIHF3
MSAobG9iYWtpbikNCj4gPiA+IC0gRml4IF9xdzEgbm90IGNvcHlpbmcgb3ZlciB0c19sb3cgb24g
b24gIV9fTElCRVRIX1dPUkRfQUNDRVNTDQo+IHN5c3RlbXMNCj4gPiA+ICAgKEFJKQ0KPiA+ID4N
Cj4gPiA+IHYyOg0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjUxMTIy
MTQwODM5LjM5MjIwMTUtMS0NCj4gYWxtYXNyeW1pbmFADQo+ID4gPiBnb29nbGUuY29tLw0KPiA+
ID4gLSBGaXhlZCBhbHBoYWJldGljYWwgb3JkZXJpbmcNCj4gPiA+IC0gVXNlIHRoZSB4ZHAgZGVz
YyB0eXBlIGluc3RlYWQgb2YgdmlydGNobmwgb25lIChyZXF1aXJlZCBzb21lDQo+IGFkZGVkDQo+
ID4gPiAgIGhlbHBlcnMpDQo+ID4gPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWRwZi94ZHAuYyB8IDMxDQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYveGRwLmgNCj4gfA0KPiA+ID4g
MjIgKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL3hkcC5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2lkcGYveGRwLmMNCj4gPiA+IGluZGV4IDk1OGQxNmY4NzQyNC4uMDkxNmQyMDFi
Zjk4IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi94
ZHAuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi94ZHAuYw0K
PiA+ID4gQEAgLTIsNiArMiw3IEBADQo+ID4gPiAgLyogQ29weXJpZ2h0IChDKSAyMDI1IEludGVs
IENvcnBvcmF0aW9uICovDQo+ID4gPg0KPiA+ID4gICNpbmNsdWRlICJpZHBmLmgiDQo+ID4gPiAr
I2luY2x1ZGUgImlkcGZfcHRwLmgiDQo+ID4gPiAgI2luY2x1ZGUgImlkcGZfdmlydGNobmwuaCIN
Cj4gPiA+ICAjaW5jbHVkZSAieGRwLmgiDQo+ID4gPiAgI2luY2x1ZGUgInhzay5oIg0KPiA+ID4g
QEAgLTM5MSw4ICszOTIsMzggQEAgc3RhdGljIGludCBpZHBmX3hkcG1vX3J4X2hhc2goY29uc3Qg
c3RydWN0DQo+IHhkcF9tZCAqY3R4LCB1MzIgKmhhc2gsDQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcHQpOyAgfQ0KPiA+ID4NCj4gPiA+ICtzdGF0aWMgaW50IGlkcGZf
eGRwbW9fcnhfdGltZXN0YW1wKGNvbnN0IHN0cnVjdCB4ZHBfbWQgKmN0eCwgdTY0DQo+ID4gPiAr
KnRpbWVzdGFtcCkgew0KPiA+ID4gKyAgICAgY29uc3Qgc3RydWN0IGxpYmV0aF94ZHBfYnVmZiAq
eGRwID0gKHR5cGVvZih4ZHApKWN0eDsNCj4gPiA+ICsgICAgIHN0cnVjdCBpZHBmX3hkcF9yeF9k
ZXNjIGRlc2MgX191bmluaXRpYWxpemVkOw0KPiA+ID4gKyAgICAgY29uc3Qgc3RydWN0IGlkcGZf
cnhfcXVldWUgKnJ4cTsNCj4gPiA+ICsgICAgIHU2NCBjYWNoZWRfdGltZSwgdHNfbnM7DQo+ID4g
PiArICAgICB1MzIgdHNfaGlnaDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHJ4cSA9IGxpYmV0aF94
ZHBfYnVmZl90b19ycSh4ZHAsIHR5cGVvZigqcnhxKSwgeGRwX3J4cSk7DQo+ID4gPiArDQo+ID4g
PiArICAgICBpZiAoIWlkcGZfcXVldWVfaGFzKFBUUCwgcnhxKSkNCj4gPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9EQVRBOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgaWRwZl94ZHBfZ2V0X3F3
MSgmZGVzYywgeGRwLT5kZXNjKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIGlmICghKGlkcGZfeGRw
X3J4X3RzX2xvdygmZGVzYykgJg0KPiBWSVJUQ0hOTDJfUlhfRkxFWF9UU1RBTVBfVkFMSUQpKQ0K
PiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT0RBVEE7DQo+ID4gPiArDQo+ID4gPiArICAg
ICBjYWNoZWRfdGltZSA9IFJFQURfT05DRShyeHEtPmNhY2hlZF9waGNfdGltZSk7DQo+ID4gPiAr
DQo+ID4gPiArICAgICBpZHBmX3hkcF9nZXRfcXczKCZkZXNjLCB4ZHAtPmRlc2MpOw0KPiA+ID4g
Kw0KPiA+ID4gKyAgICAgdHNfaGlnaCA9IGlkcGZfeGRwX3J4X3RzX2hpZ2goJmRlc2MpOw0KPiA+
ID4gKyAgICAgdHNfbnMgPSBpZHBmX3B0cF90c3RhbXBfZXh0ZW5kXzMyYl90b182NGIoY2FjaGVk
X3RpbWUsDQo+ID4gPiArIHRzX2hpZ2gpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgKnRpbWVzdGFt
cCA9IHRzX25zOw0KPiA+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+
ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgeGRwX21ldGFkYXRhX29wcyBpZHBmX3hkcG1vID0gew0K
PiA+ID4gICAgICAgLnhtb19yeF9oYXNoICAgICAgICAgICAgPSBpZHBmX3hkcG1vX3J4X2hhc2gs
DQo+ID4gPiArICAgICAueG1vX3J4X3RpbWVzdGFtcCAgICAgICA9IGlkcGZfeGRwbW9fcnhfdGlt
ZXN0YW1wLA0KPiA+ID4gIH07DQo+ID4gPg0KPiA+ID4gIHZvaWQgaWRwZl94ZHBfc2V0X2ZlYXR1
cmVzKGNvbnN0IHN0cnVjdCBpZHBmX3Zwb3J0ICp2cG9ydCkgZGlmZg0KPiA+ID4gLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL3hkcC5oDQo+ID4gPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lkcGYveGRwLmgNCj4gPiA+IGluZGV4IDQ3OWY1ZWYzYzYwNC4uOWRh
YWU0NDViZGU0IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWRwZi94ZHAuaA0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi94
ZHAuaA0KPiA+ID4gQEAgLTExMiwxMSArMTEyLDEzIEBAIHN0cnVjdCBpZHBmX3hkcF9yeF9kZXNj
IHsNCj4gPiA+ICAgICAgIGFsaWduZWRfdTY0ICAgICAgICAgICAgIHF3MTsNCj4gPiA+ICAjZGVm
aW5lIElEUEZfWERQX1JYX0JVRiAgICAgICAgICAgICAgR0VOTUFTS19VTEwoNDcsIDMyKQ0KPiA+
ID4gICNkZWZpbmUgSURQRl9YRFBfUlhfRU9QICAgICAgICAgICAgICBCSVRfVUxMKDEpDQo+ID4g
PiArI2RlZmluZSBJRFBGX1hEUF9SWF9UU19MT1cgICBHRU5NQVNLX1VMTCgzMSwgMjQpDQo+ID4g
Pg0KPiA+ID4gICAgICAgYWxpZ25lZF91NjQgICAgICAgICAgICAgcXcyOw0KPiA+ID4gICNkZWZp
bmUgSURQRl9YRFBfUlhfSEFTSCAgICAgR0VOTUFTS19VTEwoMzEsIDApDQo+ID4gPg0KPiA+ID4g
ICAgICAgYWxpZ25lZF91NjQgICAgICAgICAgICAgcXczOw0KPiA+ID4gKyNkZWZpbmUgSURQRl9Y
RFBfUlhfVFNfSElHSCAgR0VOTUFTS19VTEwoNjMsIDMyKQ0KPiA+ID4gIH0gX19hbGlnbmVkKDQg
KiBzaXplb2YodTY0KSk7DQo+ID4gPiAgc3RhdGljX2Fzc2VydChzaXplb2Yoc3RydWN0IGlkcGZf
eGRwX3J4X2Rlc2MpID09DQo+ID4gPiAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IHZpcnRjaG5s
Ml9yeF9mbGV4X2Rlc2NfYWR2X25pY18zKSk7DQo+ID4gPiBAQCAtMTI4LDYgKzEzMCw4IEBAIHN0
YXRpY19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBpZHBmX3hkcF9yeF9kZXNjKQ0KPiA9PQ0KPiA+ID4g
ICNkZWZpbmUgaWRwZl94ZHBfcnhfYnVmKGRlc2MpICAgICAgICBGSUVMRF9HRVQoSURQRl9YRFBf
UlhfQlVGLA0KPiAoZGVzYyktPnF3MSkNCj4gPiA+ICAjZGVmaW5lIGlkcGZfeGRwX3J4X2VvcChk
ZXNjKSAgICAgICAgISEoKGRlc2MpLT5xdzEgJg0KPiBJRFBGX1hEUF9SWF9FT1ApDQo+ID4gPiAg
I2RlZmluZSBpZHBmX3hkcF9yeF9oYXNoKGRlc2MpICAgICAgIEZJRUxEX0dFVChJRFBGX1hEUF9S
WF9IQVNILA0KPiAoZGVzYyktPnF3MikNCj4gPiA+ICsjZGVmaW5lIGlkcGZfeGRwX3J4X3RzX2xv
dyhkZXNjKQ0KPiBGSUVMRF9HRVQoSURQRl9YRFBfUlhfVFNfTE9XLCAoZGVzYyktPnF3MSkNCj4g
PiA+ICsjZGVmaW5lIGlkcGZfeGRwX3J4X3RzX2hpZ2goZGVzYykNCj4gRklFTERfR0VUKElEUEZf
WERQX1JYX1RTX0hJR0gsIChkZXNjKS0+cXczKQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgaW5saW5l
IHZvaWQNCj4gPiA+ICBpZHBmX3hkcF9nZXRfcXcwKHN0cnVjdCBpZHBmX3hkcF9yeF9kZXNjICpk
ZXNjLCBAQCAtMTQ5LDcgKzE1MywxMA0KPiA+ID4gQEAgaWRwZl94ZHBfZ2V0X3F3MShzdHJ1Y3Qg
aWRwZl94ZHBfcnhfZGVzYyAqZGVzYywNCj4gPiA+ICAgICAgIGRlc2MtPnF3MSA9ICgoY29uc3Qg
dHlwZW9mKGRlc2MpKXJ4ZCktPnF3MTsgICNlbHNlDQo+ID4gPiAgICAgICBkZXNjLT5xdzEgPSAo
KHU2NClsZTE2X3RvX2NwdShyeGQtPmJ1Zl9pZCkgPDwgMzIpIHwNCj4gPiA+IC0gICAgICAgICAg
ICAgICAgIHJ4ZC0+c3RhdHVzX2VycjBfcXcxOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICgodTY0KXJ4ZC0+dHNfbG93IDw8IDI0KSB8DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
KCh1NjQpcnhkLT5mZmxhZ3MxIDw8IDE2KSB8DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
KCh1NjQpcnhkLT5zdGF0dXNfZXJyMSA8PCA4KSB8DQo+ID4NCj4gPiBJJ20gbm90IHN1cmUgeW91
IG5lZWQgY2FzdHMgdG8gdTY0IGhlcmUuIFBscyByZWJ1aWxkIHdpdGhvdXQgdGhlbQ0KPiBhbmQN
Cj4gPiBjaGVjayB0aGUgb2JqZGlmZiAvIGNvbXBpbGVyIHdhcm5pbmdzLg0KPiA+IEl0J3MgcmVx
dWlyZWQgZm9yIGJ1Zl9pZCBhcyB3ZSBzaGlmdCBieSAzMi4NCj4gPg0KPiANCj4gVGhlIGNvbXBp
bGVyIGRvZXMgbm90IHdhcm4gaWYgSSBkcm9wIHRoZSB1NjQgY2FzdHMsIGJ1dCBhcmUgeW91IHN1
cmUNCj4geW91IHdhbnQgdGhlbSBkcm9wcGVkPyBZb3UncmUgYWxyZWFkeSBkb2luZyB1NjQgY2Fz
dHMgaW4gYWxsIHRoZQ0KPiBlbnRyaWVzIHRoYXQgeW91IGJpdC1zaGlmdCBpbiBxdzAgYW5kIHF3
Mi4gSXQgbWFrZXMgdGhlIGNvZGUgY2xlYXJlcg0KPiBpbW8uIEJ1dCB1cCB0byB5b3UuDQo+IA0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJ4ZC0+c3RhdHVzX2VycjBfcXcxOw0KSU1ITyAg
RklFTERfUFJFUCgpIGxvb2tzIGJldHRlciwganVzdCBpbiBjYXNlOg0KDQpkZXNjLT5xdzEgPQ0K
ICAgIEZJRUxEX1BSRVAoUlhEX1FXMV9CVUZfSUQsICAgICAgbGUxNl90b19jcHUocnhkLT5idWZf
aWQpKSB8DQogICAgRklFTERfUFJFUChSWERfUVcxX1RTX0xPVywgICAgICByeGQtPnRzX2xvdykg
fA0KICAgIEZJRUxEX1BSRVAoUlhEX1FXMV9GRkxBR1MxLCAgICAgcnhkLT5mZmxhZ3MxKSB8DQog
ICAgRklFTERfUFJFUChSWERfUVcxX1NUQVRVU19FUlIxLCByeGQtPnN0YXR1c19lcnIxKSB8DQog
ICAgRklFTERfUFJFUChSWERfUVcxX1NUQVRVU19FUlIwLCByeGQtPnN0YXR1c19lcnIwKTsNCg0K
PiA+DQo+ID4gV2h5IGRpZCB5b3UgcmVwbGFjZSB0aGUgcHJvcGVyIGluZGVudGF0aW9uIHdpdGgg
dHdvIHRhYnMgaW4gYWxsIDQNCj4gPiBsaW5lcyBhYm92ZT8NCj4gPg0KPiANCj4gU3VyZSwgd2ls
bCBmaXguDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IE1pbmENCg==

