Return-Path: <bpf+bounces-67464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7621DB4429D
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E391C83E0A
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913D22E3F0;
	Thu,  4 Sep 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1tWMB6P"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A42248AF;
	Thu,  4 Sep 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003024; cv=fail; b=CT1BOr9f9Af1SgRIVXos1+T8wWXLZcjh11PO1Pcg7bziOVMRE6biUZiocUeVkt1dW+V2QJBzjlJ4GoykWDjxS3QuGV1Whk4D7Es4z/uVwJQkeVi6AAT1sd0W4JV8sM3IqN+BluEwonLXz42qQ81mUoPH6z0FrkAdhJMYvcPmblo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003024; c=relaxed/simple;
	bh=Vc2Z3IW3EceQPR+t8h8mvl1A4/62rdvTy08NXf4krJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xo/KRAevlgnTfkr+BxdiNYHHa2j1fph66EqrWGeYn6F7/CoJyAtusaYpygFJSn4KwPflRTZ4HQocTYuJjR0wL4mVhxEvMrB77JF8qVdtTFyjQX1359x1vjOLfSPU5U5G7PF2uJ0f9pdJvAsz0TqDnZTR/v8ET/xkt80E+Kx5AgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1tWMB6P; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757003023; x=1788539023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vc2Z3IW3EceQPR+t8h8mvl1A4/62rdvTy08NXf4krJM=;
  b=G1tWMB6PaKU2kAi2zrkATFS3mNUAIDCdeXuS7tc25gDe/Jb1aGCxBOir
   5HZduiGHfOasBwiZZVkOXCL/NSTngzizBG6qZngoosQJxoCcUmb+G0XKM
   8OsQtcgahyK4+1xHPMSIB9ElKWxvjhgbs9mmWZ1zXh0tJY27rZxUnWK+U
   kFnOpQYZJkJENORB3n1ZKLEdripfCi5W21nO0akekiNH3jWGD7TY5t/Fd
   v0+/8n7/YvRY6xyKsfAwIl0f4snAateGLu6gGNPcoM0okyCH/TGwWGuKb
   CbMyd3XhIlluYYULDngncWClia6ald/tCIOm5B27Mb+B8UyDKkglpe9X6
   g==;
X-CSE-ConnectionGUID: unzlbP3TRB2hMtoJetNzEA==
X-CSE-MsgGUID: X8JuNBEXTeiyzsAxQ/Kl1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="84780423"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="84780423"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:23:43 -0700
X-CSE-ConnectionGUID: X4YzaqSLQgKWvO4B62rkRQ==
X-CSE-MsgGUID: 09IpIBrDTTuLiBWuEWg3+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="172747930"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:23:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:23:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:23:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:23:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jePvFeDtM2jZzWN3hvGG95TJThm02TEslQUHp8BayFSUPO0kGXt1tvSOyqqUxZQLxbx80OCcXbMunnvklOyqFrM7cHBnCc4Pl9I5jvXpuWWjCCdO5Ly1RBQPOVlas/aoxr3EpaxZVMzkbbZjwrs9rDpNGBebxONDpgAiuFq8+ctN/OhH8I1uGl5wvBTi+IgXoQVH+Xx3w3dXlXPKSafXRHOtc/hpQqSyXNbptRYHD+81iJcdJbAIMhQw8kNuYqOF/aXewOXgggKt1tZS6eJrgOowgJYd1YSOpzc9LcCKX8JVrG36O+baJ2OgW6wGDEGDkIrD93UUFTiTQmdE2+OLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZlGga6Y8STenY48Zm8P6kvk8N+gEnskZefiFe57ZwQ=;
 b=mHY802d86Xk8tAxRNVYk0c3GZISwhzgq2UFQPQPEzhWHACEjLlC5SWENQSGFq/WdluK7mP62RjxsvDcQkXxOyZh2QrzKfdBfq50thZl9ELD/SoX3gNa1Ukt49lcdPxtZQYkkGnLD3lWpeSVzOGlJNMaEcG4foq5to7/7z59sdRtlQHptFRa/Rz4f+PxWED9TBt9kBRhG0/K7y/GMvPvumS8HgnvZs9XrVQRin08HxSTrLxb260T0keUV92opZ8EdbPcIdTXsxEKKV98ovO3ygRoMooRij0e0YNEC09uQjt9Wtgum+A0fBHo/yZqNfFf4e4O7960lab7JW5lpWznSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.16; Thu, 4 Sep 2025 16:23:38 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:23:38 +0000
From: "R, Ramu" <ramu.r@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Simon
 Horman" <horms@kernel.org>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 09/13] idpf: implement
 XDP_SETUP_PROG in ndo_bpf for splitq
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 09/13] idpf: implement
 XDP_SETUP_PROG in ndo_bpf for splitq
Thread-Index: AQHcFqWAu9c+Mgx7QUqpbn7R7WlmbLSDM00AgAAPduA=
Date: Thu, 4 Sep 2025 16:23:38 +0000
Message-ID: <DM4PR11MB645585459A220BDE380A25BF9800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-10-aleksander.lobakin@intel.com>
 <PH0PR11MB5013593A9866105499C7ACC79600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013593A9866105499C7ACC79600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|MN2PR11MB4646:EE_
x-ms-office365-filtering-correlation-id: 8226cac2-c917-48bc-8d27-08ddebcf678c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?oo52yqWgKlyboAWq0xMQ35TfGBu9R+jonKQGYs4OQSxO1Z6myOgQw7P7yFY2?=
 =?us-ascii?Q?V47Tk5VpZOPnKLu9LKKlDg1GMUgYKRrA/OHCkiaOnZ5Fb8+0G83p+ULirPjr?=
 =?us-ascii?Q?8qQkWOUfdu5wNOS3R3kvjHEmFtLX+pTCivDSlRN1nI7QH3oq5sw0YoI5Adnb?=
 =?us-ascii?Q?nphfwjeh/gb3LODOcnZZwqxJsxZtxpODRRBvlXK/E39dREOoz88L5V7S78wf?=
 =?us-ascii?Q?uEWy0P8GMj5CdiSWEQDDqJxxCMiyEf8jGgo1GSimkAoLaHhxIylZwNbRiGVN?=
 =?us-ascii?Q?G0USGspzWX3ajamdzDqGCHimNVvK2pthbDLK62cVdRuxyev8DYlkbr2dP3c7?=
 =?us-ascii?Q?mXF4mSj/sj+BEh/YI7jS90bR9OL63f9vMeEQuAnkUUvTPUYCcMd8UeO1Yr3T?=
 =?us-ascii?Q?y5hQwK/ioYxjqLFkEnjnNa1PC1Kav8wSRQh3oampTikSAVDdhQVi39Ai1zib?=
 =?us-ascii?Q?CXEyIDRC2aVRgpi94snoQbrHseSrzM1UOxmVT4z5GC9LBUMjwE6/T1R9XhAB?=
 =?us-ascii?Q?xR0Kp+KxklqDG2KRRwulFYBcOEMNU67tK00MF+v0VTkZMDdTQc3v3zfnQlpb?=
 =?us-ascii?Q?E/R5WG7eBQC9jYqwEoARRabJ5NTc6FmUili8/dq02kfI6dY90WozfV91ysud?=
 =?us-ascii?Q?s+RRGTPNHHVfwZyUJ1Mc7m5XpdwkEaQKB8ZN6CBUTMV+R6jZRwN3RfOgldwm?=
 =?us-ascii?Q?qrXwN0e38J3JDuINHwBTnv9ni6rENwaRjfUve5aK1iMaV8BocHsQOvNM/e4L?=
 =?us-ascii?Q?bj1z9WMI1HzvCvM3cejC/FWsow1msIays2MZvIWhFNF4bkfF6MSKpQiLPVZA?=
 =?us-ascii?Q?8CSjodo9OiaqXzUIcq75ROk4bxTjFuuzhRyU+VDgbmuxssr6U5ZN0iPKn7zl?=
 =?us-ascii?Q?IdHMuEsSh5K45Ef7C9hSC5/i705YJO0caSsp3dRGgjMG6+Rl5XEz5Iwn0RPq?=
 =?us-ascii?Q?f1OBFwUDWrzAofufdf3AEjZ/gAVhDjFLi8Uv4J+0eLZCmQVI6ptxSkiel87j?=
 =?us-ascii?Q?vjTRbxAxbCEQFK9baW5xj2ut/Gf0TAZOyrtURk4f1TMax33I8w2KTkPvDdqM?=
 =?us-ascii?Q?/ff4eVvrEDxtmrteyXRUeCAnf1kPZ8gdj7+n58ArMwBqXRv6/ZHgxewv9y9T?=
 =?us-ascii?Q?MDsv/AFZ3c3wx9jwzZfPblI1pHcgmn2V4a5HihAx7as0S1N4EPpoUIU3UQhn?=
 =?us-ascii?Q?/1UIvZbAW34tTN6TDtH9C0Cp8C/mO0fj2E3Ed9bm07peN0wAYVXuP8Nbb0v4?=
 =?us-ascii?Q?ZZgcvbAmEKLuR0qnayRC2FQTwKgcOaOhXb1iGh7TbcsVLcyGNUWRxFF39BFo?=
 =?us-ascii?Q?kOlEm6irGnrjeZ00PODOkpD6ck7m1E+/znWmk7uWkHLYqllqBVoBIpI7FRYz?=
 =?us-ascii?Q?/EM1rDyR4G9uNEtVPUfaR9+EypQ6SzfvcczeYS1Ha+jiTww+6w4XSYV0E3EL?=
 =?us-ascii?Q?1fmzzHVl1rMrTJB1bSTF94JEDL4U5qRb32ZucWeZVYFbBvbLdoJdwQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5UJO77w88mUFfs8AViAOhrEL4gxsL32xJhhNeQsAKuS2h+TzwCgWjc6HPj97?=
 =?us-ascii?Q?kQaCJEIpZlhfbAasBW1bizJ4rxhz2zVI2dgmZNpsK7NfgB9uHgd6LIbKpDNo?=
 =?us-ascii?Q?g8Jk7E9MuZ5hr4CCpu7+HJx6IwtD+u3tRDqC+z88iXXs2hLPbjHnd7rCyVMu?=
 =?us-ascii?Q?QUyceFiWDNbaIcXb70wQL99xytlvZfl7oil1Y8ZK/RJfHLqtBjY+x2X86xX2?=
 =?us-ascii?Q?G5P3+5C+5Nv8+EKXtcMwTiptwxUZaFUreeQvsN9pxRshTr4k/BAJHtryDZNz?=
 =?us-ascii?Q?VDJX+kBEBl2wb5Fi1h1nmE6x3sSIZoeK1Ac600xJWdfUvAw1Cha4u0LDAW9A?=
 =?us-ascii?Q?y0bmRVcVb5tEbxrnpkemygwqwighqvsD8ORzOYdg5fohaeVdoRjS7LP+zG+t?=
 =?us-ascii?Q?eJNWLlsMnA4Gw7PJDvG5MVL8NHHf05fmCOvf/a8q/Gy08UAqnfYLF486WNFJ?=
 =?us-ascii?Q?wFOslVNxyVqGOXs1mNK5yk9ydKVxWjvI9qFn4XsMLowE5xW0RUlB5GUarJsM?=
 =?us-ascii?Q?z2ofhf3NLqr/svDXkbkKkUYNivakVjp2gr+leGWrXXo6df0u0OdF2GRB1RWq?=
 =?us-ascii?Q?qppJkOWQobS8hM25HoEFafzn6+lit/3oOVXMUD66mWFtrRb3Lb0ULWnQLJes?=
 =?us-ascii?Q?qtzhenQnMAXb5VUNaS5dovRuKzRyARiWuqY4u/Jj1c8smTnHa6mw8+znD/OM?=
 =?us-ascii?Q?quHBqkonGvXr3IGX6WGqrprOah6f+Oc1FLhH6ZZPVuI7zD8saCMul9LTJ2cp?=
 =?us-ascii?Q?yKyNGoBIqM66HjPmCSONaX8ccHxyv+JkVRXHikv+SSBQjESdoygz84D1dWjz?=
 =?us-ascii?Q?UDtkLqrff/seJCYH4QnfOENiijuKQtYec6+kKZXk7i7aAg5ScAy6XB76gF4Z?=
 =?us-ascii?Q?NROycCO4Ni57vBFhiCKlavtoXaXC//MyUwKBNncc2eHIvh9nI8ilvVZ0aLO/?=
 =?us-ascii?Q?UBxA8SrluLKrHHcBWsx2UXnQUdDPWhpWi5POfeR0XudePw5jnWEYi3sxjrNI?=
 =?us-ascii?Q?PNEcbfUYt/a8HWifL+p9HevqoOO/kQxZEcRfi/JkeRdISsRPU7dyVc7eM82p?=
 =?us-ascii?Q?u2vFqMw+LcOdoNDceDr4zGaeU3mmxiR8rDP/g7WZdmtRhl0wilq2nOGJYS2n?=
 =?us-ascii?Q?+EO1lzujV9ysUq8l9dNLHxHGc2hj097B+bRz2GcYmovxCRhZwz+CuXyASSt6?=
 =?us-ascii?Q?520WgZAdiazlfQu8m2FeOAFiPpqTpsXh1KTF9MY7qEaqqP49RDTx9yMY1cTE?=
 =?us-ascii?Q?d6XRpoueFb3HU21xUT5GF62F98jdpzyFYU4pL4YzA96RRbK6oSMpYgphFenE?=
 =?us-ascii?Q?vcItCstfRiu5eNaSQmh9iNMv4ngSxxpCzeDQqszrdsJwHV+9k8RtuzBEhqjq?=
 =?us-ascii?Q?MDKaPgcP5RNBPtZ7wzb9tVMCEroYSDOyN+K1efUL/DRVpzcF4OgsvwiEnYTo?=
 =?us-ascii?Q?ZaA0I9fVynITcM869Cpp9Em3B/EUnWoLB8C/MjjZg0VIzyp045uMAZThvwjK?=
 =?us-ascii?Q?QWlEMaDMSvE4yUCbJYxMl/ViyhNk6l4iF5mysTfyNrtpq6t78WgvEXxv0GGN?=
 =?us-ascii?Q?RSQb7zTuKpGFyX0JzZ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8226cac2-c917-48bc-8d27-08ddebcf678c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:23:38.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19fLLbDYlwzflVEBBLrjjq/VYVrZXJmj+eIjaApjsNzviQcnd7ZbPtNG9BW9nDbT4g9MUq6gydYyzW2hV1pBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Tuesday, August 26, 2025 9:25 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kubiak, Michal
> <michal.kubiak@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Simon Horman <horms@kernel.org>;
> NXNE CNSE OSDT ITP Upstreaming
> <nxne.cnse.osdt.itp.upstreaming@intel.com>; bpf@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 09/13] idpf: implement
> XDP_SETUP_PROG in ndo_bpf for splitq
>=20
> From: Michal Kubiak <michal.kubiak@intel.com>
>=20
> Implement loading/removing XDP program using .ndo_bpf callback in the
> split queue mode. Reconfigure and restart the queues if needed (!!old_pro=
g
> !=3D !!new_prog), otherwise, just update the pointers.
>=20
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |  4 +-
>  drivers/net/ethernet/intel/idpf/xdp.h       |  7 ++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c  |  1 +
> drivers/net/ethernet/intel/idpf/idpf_txrx.c |  4 +
>  drivers/net/ethernet/intel/idpf/xdp.c       | 97 +++++++++++++++++++++
>  5 files changed, 112 insertions(+), 1 deletion(-)
>=20
Tested-by: R,Ramu <ramu.r@intel.com>


