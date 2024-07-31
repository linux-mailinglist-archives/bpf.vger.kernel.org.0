Return-Path: <bpf+bounces-36122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9D942843
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 09:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06B5282D5E
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 07:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984DE1A76CD;
	Wed, 31 Jul 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQweXZqD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D7446A2;
	Wed, 31 Jul 2024 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411716; cv=fail; b=uznQYx+xz1zEC97juiOajwa9ItTunN+KTbYAuLIP+krfYDmH8qn0PcMGFjypG3LimMO0hl9xP6MxMF5IVIFCO/eEf93cgvq2CCHA5UOT60WXputsGFuza4ifjolx15U4EJPd6P7dAXh2J9QZEmnwgeE5hgCM9ER8FqSvQ4L+3zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411716; c=relaxed/simple;
	bh=Qn+yqNLGBV6ux2rzGRfC73viPCQewjaV4eYbNZXnguw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tmnASnhqEAB4JEiFwRvk6X0ErXVPBIdMCclQ1GXMDttoXNjMi3IUaLtI0Rfvnaq5RDZvathwyN+PFYwi6QoMWv6YQhMn6Zsv7dbxQKO65EdHuGVL+cxx/ieJSFtNXr1vBw+ngfJszB3mwjbk5rKMHFK0On6k+zX5ocMjGNKvw2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQweXZqD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722411714; x=1753947714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qn+yqNLGBV6ux2rzGRfC73viPCQewjaV4eYbNZXnguw=;
  b=lQweXZqDU9ZkftF07kZYZDYV1rr1TlGjuli5zRhILkKjz2Q/k9vGXtji
   cvNwBUVsiZNX8dWMLD9fS20sg/HKRznXF69ruBHTjiZa3yMovP0PsgTWe
   h1d6/JPLX3PxR+aYsysda10vn+yBRJpQkpdWJUarm3TilTRMLdqRgHpvb
   iMQ8/Y6xibEhoFJeuVuywxzBKO3N7awvps4Vzw0QAQIEK5gOh8QeU738r
   qorsWa8g4BLXw2z7Z4CB4RBRGedWH8R7g1JiQRiXtvu1dbNoMcyrnj+A/
   j5/IKGgHcs8tfD9zNJ8XzHLbIAqk00JUzZUzAPsr0QPOag5CWRK5Nepqy
   g==;
X-CSE-ConnectionGUID: oAfGZ/Z6TNefTNY2bAwJgw==
X-CSE-MsgGUID: amo4Tl3kR6m2mK0IRGvBmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20117557"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="20117557"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 00:41:53 -0700
X-CSE-ConnectionGUID: 4eVNqMWhQd6/pVr9ZbxZ/Q==
X-CSE-MsgGUID: dwc0rEDFTqGj/tbV/DIISA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="59675716"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 00:41:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 00:41:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 00:41:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 00:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd+qHA56f7ipCBGUrjwjVqpl9Tl1ZLzb/TpbLtqunYMs7vsYzx64PLRd0LSltlsEKNjZdFiVEQeSq+Qo4/BWpuiC8diCPLXUNQmVC8V5wknTjuvgs93L//kp3Xn2enuiZKH8Wrnz5GTWJOgyb6sQ5iVJCzG8uF/QeJC9DXDQskc9uBQsnf+2cefh7x+mF211EpX1VNrD5iaiD+vTAiyVoxwe96hNnBeNNLjTPKad4LP1bf8+Iiha16e+Hs/dn0bSp5J8dBs0EzFOg7Yrj5A31eOMhgsJhp7YRfCBLzBDyxKcygpaGUn6lDhMtFGalBEHbVkkiYQoQ0IoTJ/5H6lHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qn+yqNLGBV6ux2rzGRfC73viPCQewjaV4eYbNZXnguw=;
 b=KPqZVhfLl3jRRu7yT7CcXW6EDN7gp3VNk2acLq7w9zEkVN59O499A1cHruq09QRYAiAYH4oHgKMEnMC12Owm4vlKc1nxbh4ZqyMy5XHTOE9wN8H9yDcoV3o1GRC7xZiUxzRDfqduX7m/NXH8Jf8WNMIBPCNtjz9gZuwMFQb/w4/TsxiiFeIo0JNS+c6nvoT4VD9UdwJq9NcKfrAjbKxdO6CL3T6VCv+C0RmsMZpRpjmd6HqvVI/aT0kS4S8GOEdUryZGCfUqylCIVpIfmcPHVpyYCy1AccV1Wt+umvxWz7AN9xpI7S/CgSq2lkdo/iTcJXO3wKYHqpjosFRrq7Yseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SN7PR11MB7437.namprd11.prod.outlook.com (2603:10b6:806:348::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 07:40:30 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 07:40:11 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, Jonathan Corbet
	<corbet@lwn.net>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Shinas Rasheed <srasheed@marvell.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>, "Blanco Alcaine, Hector"
	<hector.blanco.alcaine@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"Neftin, Sasha" <sasha.neftin@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH iwl-next,v1 0/3] Add Default Rx Queue Setting for igc
 driver
Thread-Topic: [PATCH iwl-next,v1 0/3] Add Default Rx Queue Setting for igc
 driver
Thread-Index: AQHa4h8PLg7tcvdq706oyoxDPBv147IPXLGAgAEDg/A=
Date: Wed, 31 Jul 2024 07:40:11 +0000
Message-ID: <PH0PR11MB5830E21A96A862B194D4A4A5D8B12@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240730012212.775814-1-yoong.siang.song@intel.com>
 <20240730075507.7cf8741f@kernel.org>
In-Reply-To: <20240730075507.7cf8741f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SN7PR11MB7437:EE_
x-ms-office365-filtering-correlation-id: 56918329-6c41-4fc7-fba0-08dcb134025d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SmWiO+YO+kvBxnWbLj2lB8LTyqca3v73LB/MoFyLUHQjgoZGSElhztsiLRDW?=
 =?us-ascii?Q?FFWzQPLLLbCibuw/uZwBWt4hvtV4Oz9KLLh1HTVzIjXwCiQ/bmejvvTRoAok?=
 =?us-ascii?Q?89zIBchd08ZTKh4a7RRn1tWE/Re1LLrDGU7icHlVDRchr68SRPDWu3hvbn6e?=
 =?us-ascii?Q?qSuR01Q6TdYHO7A6sYi6i/TobhiJe2xjSxk7Mk1jPXOfqshDB4T0Qy6p/wnQ?=
 =?us-ascii?Q?apzrBOOf6xTYPxZZhrAK1FKs0YBCmWpywOYKo4ecQJaDYzyhUJ6tx9YrM2v7?=
 =?us-ascii?Q?SaHQDJ18W63ZkfO5cmtgE7OD4Aux75F59pmjtvEG9C9sU+Ajd76N7vwJgC2w?=
 =?us-ascii?Q?JNVFm72myoQb4EvmBGeOOLgBPProvsQ+R6914Hmu/oQa9McQspAKwaptJ60D?=
 =?us-ascii?Q?1CUMEb2CLZGJTxZxQzKdqNxf7n4zs7Wg5ykizdKkps2wwert+KI24oHsxWU1?=
 =?us-ascii?Q?iOjbYjtCeeytefR66mOJyV3cQY/taAIqX54y0TglPwFa2tqkYPB/yH9/nay4?=
 =?us-ascii?Q?/mF5WbG2n+ohMFcR88hFnjIyGPFN4GNvvN2/kEifdRyd23Wh/vKn0JvljBGy?=
 =?us-ascii?Q?8Xd4StCGffbpBGk2cKvFLzDwZRhj8e1UGvhaKnqA6qn0F/3L+FqBVAMltypV?=
 =?us-ascii?Q?PmVVh77sxD8PW8dgHUEMaCn31RCzpMAtkuLC8e/iyJhN50lRlK7jdW5acFm4?=
 =?us-ascii?Q?iyXv0rvU4pNWb8TP7WEyTTunxCzHwW+5mzIOO/ekcp8HjJinYOnfFoNMG13Z?=
 =?us-ascii?Q?F1vjpFQ/i8of8RFCTJ04o32qtdq/C9mdqZGu8TsZ8lHJs1lV5s2C8fU2Qk7t?=
 =?us-ascii?Q?ZVFIUZii/POWF1Nc3qhOQXfEaO66jSotYps2Oa8vr/zl5wt5g4PzVGWvAGP8?=
 =?us-ascii?Q?P8ZdAEweNjfA/ndV9XS8EoBxCWpBBH+sAagOD3Q/zlwq3GnCLvX39P7pNMUF?=
 =?us-ascii?Q?5mlFVATSeHhkLtk7myMIuS+I8gRLWiMGunk0yCZS7/YI/Ow/EFVFD/RB4SYk?=
 =?us-ascii?Q?fapB8fXSf2nktoH7zRNwuPyPP/rIiRrS1ddYZOU4OIbFiMST5A2nXJH6FcNh?=
 =?us-ascii?Q?ZHGcOHAkoNwoIf53EJwfBZvOZxInargExekL0gmiY3mQBRtpqx5d6g2VLAzw?=
 =?us-ascii?Q?Xa0o1jt1YUeACz1RpNysjsL0X4v3fUlE9FxbmQa/x0dELG05X/3hh6wGM6aL?=
 =?us-ascii?Q?SJZ6qdqmHosZa9t9dP7AhpZQp0XPTPBwZ07NKVTvppbfZOAYwcB/79aqNPRS?=
 =?us-ascii?Q?RiTZ+/XscIZcOKoaALI0Lmmjqnmvh0UlZkuS6wOpYnzSrWhKKp8Nx89uCIoh?=
 =?us-ascii?Q?2KjAkgaJyUg8EILO76ODo8/x0AglRlASHv4yfFlLcZFeR/yVgCuA3Wct7Fvc?=
 =?us-ascii?Q?QFiy7+nF6rD8pB6TI+ayR5sZv+hRFHi2hTCTHSduSmkD+lIHHw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UFGtlFtShWaweFeO6XZhFNvvW/Fi0C6dgBspMaTwyuF5iWzBfhYHvh1csaiY?=
 =?us-ascii?Q?0G0wZLBx4EcnJLfICubOGUiHmYzuwUrhS9rrD3JdZMkuJSzDgQ60+ntgEfv4?=
 =?us-ascii?Q?6OJgAC/zF2M1VB7BRpNuqnDDr2d3hD0iSlfeQDIxA8+3gKpWv1d/yDusq9Ek?=
 =?us-ascii?Q?UHg7Kak/tjIRxsQMAa5+NPkfj5bgqxsMBvoWNEAHb3Js1lWoxBeOX1wYR/r3?=
 =?us-ascii?Q?uJhN1WRzR+ZEOVZLgKgm9qJtZ73hfvBFrEboyc8E6IjydXDGJcjO/nn2Ryfi?=
 =?us-ascii?Q?IZoVxJsHoRKlx01SC/rS8cNwyTTlel71h6vYW4784vaD+L8jfuDCJ8RSFbGX?=
 =?us-ascii?Q?jJb6URduaAQMZluxGcDLIJcvoTPO8YsUsGM6v4MTZIBK4bMoQ+hrX5u5Q7X4?=
 =?us-ascii?Q?7c6nFBBYbCTHiEN5uarjvsOF60Y8L3T8aKQKmVmOwoNSIs3JH+Cpjp1RoZXl?=
 =?us-ascii?Q?PVYkZH4Bv5o/UM3u0C98E1wWkxMXMIx5tiTUHck9NHajG9Lci1Y48HFKWXw6?=
 =?us-ascii?Q?4QbIUdOZb9t65ZCgNtLKG56wkjJ/2FmIpdP0Fy/6YCNFqpwcpmPsbfp4chC+?=
 =?us-ascii?Q?Uh96NdJ8EcJuVByvHmeEZsE4m7Vh5SCCGh4yDLbXf82H5S70iXgnMnqL+vDP?=
 =?us-ascii?Q?BODmvsYKoZtFmy8Bu9FYFhbnG7Nz7jpJrpBErA3BM/CxGxPKQsHbGgTZhoNH?=
 =?us-ascii?Q?M0v7gKsoT2gKyAjyRLDkw8Y1ztSuI0OdrddyYdjyZBpqKIIIDR+/j5uY6VWs?=
 =?us-ascii?Q?xuBGKptaXGww9UcJ70UNN43Kmeth6Pqb3nkez9wPD29/iHeRXjWXb1K4qbsU?=
 =?us-ascii?Q?gcjXUziuT0geJWWH5d94IxxkgSnBvpVqIUJEHUolIMPN/vEQCx38pK1sZjTZ?=
 =?us-ascii?Q?iOnaYacIHuftJkOHzQz2LmmT+ttpBzOZi8UeLYhuqOrh4N5wEx4IeWMacZ27?=
 =?us-ascii?Q?dPn+AwyA9WyPnzFwyaZmPYzxmtNUoMtWMa+3KxiP3BKMvBcYf2g5rO6gp1Eo?=
 =?us-ascii?Q?pN+fIAdc/UXMUhZh/4Zi2B8bBr3zNJZ2heopWE3Z8KrHApbCsHuIytwjv1fZ?=
 =?us-ascii?Q?q1R8py867gFDmX/QUC0bcmTaFbKozTe47DSzt1XX2MQ+gTB1SBqqFlAPD99w?=
 =?us-ascii?Q?4Zln7D1wkr0x7kOyRepC5yR2dCAaLFYBlibSpHfWMaxX0josbjjvhXx5cWYh?=
 =?us-ascii?Q?wtOoOJors7aclTKiCt6NLL3zEtpq+O0rgcGNj8muhQXiWH/h9Hp9xk3+bd9E?=
 =?us-ascii?Q?2WRpZBEOBfuUDWeci3zv3QZxVb4/ZCfV90mc7mOQjBXX4xz+P6gEmY594rrS?=
 =?us-ascii?Q?n9tljuUBv0WAOTb8JrzEtEINGo8yhVRz6DwvNBMxvHPde02Vnk0kk8QfNaxJ?=
 =?us-ascii?Q?pjqRP27CUivOXJJbVlHpy3w7p2tJNm8ygTG5Z6GjustbN2ooEskltKcCf35r?=
 =?us-ascii?Q?qNexzN6aCVrIbotv0a7kBRfFoRkIpSMZ7p0qWqgZdm26i79Qhpnzw/QC/wAg?=
 =?us-ascii?Q?LZ2U2IRkLtQQZEy43yFCCWhseqyvBMbrhTcBPnoO4GAc25uNBzJKq8zIgKFe?=
 =?us-ascii?Q?7VJQxBttFCPsY7D563B3eybERrV2ju22Ca1MzY9VISeGPbwWKHbmf9pOGoFm?=
 =?us-ascii?Q?1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56918329-6c41-4fc7-fba0-08dcb134025d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 07:40:11.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgP9xNtlkXWVmgkQi+enJLAmeDdwW861tIkD8SbCnbEdPzfQFlrrR84s7TriHxaHOK1yfLR5vPH6lg+aFRU9s0CFE+O5bXmiq2uEu9j5SnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7437
X-OriginatorOrg: intel.com

On Tuesday, July 30, 2024 10:55 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>On Tue, 30 Jul 2024 09:22:12 +0800 Song Yoong Siang wrote:
>> This patch set introduces the support to configure default Rx queue duri=
ng
>runtime.
>> A new sysfs attribute "default_rx_queue" has been added, allowing users =
to
>check
>> and modify the default Rx queue.
>
>Why the extra uAPI.. a wildcard rule directing traffic to the "default"
>queue should do.

Hi Jakub Kicinski,

Regarding your suggestion of implementing a "wildcard rule,"
are you suggesting the use of an ethtool command similar to the following?

ethtool -U <iface name> flow-type ether action <default queue>

I have a concern that users might be not aware that this nfc rule is having=
 lowest priority,
as the default queue would only take effect when no other filtering rules m=
atch.

Do you see this as a potential issue? If not, I am willing to proceed with
exploring the ethtool options you've mentioned.

Thank you for your guidance.

Regards
Siang

