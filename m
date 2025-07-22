Return-Path: <bpf+bounces-64065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71758B0DFF7
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC0956027D
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E735273809;
	Tue, 22 Jul 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCyH0tYW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F01E9915;
	Tue, 22 Jul 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196604; cv=fail; b=K3VsOMRaBV4yRDPiLXhedR5/pdSKadIb91o6WjUYYVDuLvF3+4Gjmw34IKOmL4zLW0oOLsapK2dzzvzcSs3/wQmxEJMVYr5Nor9xB3fuwf6sI/83G8Bqg6Wane7MIh1JAufHtu4eYIHGoMAKJysBtEQCL1h4nxBkqaTst3zAi1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196604; c=relaxed/simple;
	bh=Dc90ff/LitzYd9ubxZh3FsImhAY/ZhBztST8mUBO7no=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sQcEOy0QENiuLXsAn+0SI/S7o/MSJw2Y/s7dMWe6TMqqPctuTTFZWkI5bXaVbmFHntzMfGZXhi7ojOw1dD+pvkaRl1mwgFP2Nt2xCZUCEeVD4+BKU7hFFj3BrjoJeYqHKydPm4Y2mhdzWlZNXLwHfsiAsJihpHUSLCXObauWnWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCyH0tYW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753196603; x=1784732603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dc90ff/LitzYd9ubxZh3FsImhAY/ZhBztST8mUBO7no=;
  b=OCyH0tYWfpDmFmhjS3Y8lv5/AmPe5JbpQlLkizxj21hTitdLWwKGrN/X
   dM6ZkdUBWIomG4SaioKJ9sT5Lr2ettvoZbC5mpgGLng8FbnYix60EZcwL
   yKmiZunyFls4C+EIDekoMpltMwy8mo4bww3Aa484J+gPUYT2bjETSBrRb
   l6rEBc8cQYHKv6OEobo4cAoB/RXe2hdtFsS3lX8TKTofgF3aknBZZqmW6
   tElbJQqmU2UZdkGacrHRrLShPB+JlqZ4Gvb0VY8LWZe674gXOsn1irJfM
   NYiVuqUPHQhU9wVbVrR6oMNOrgH2GJZmBVr+jz0S9CO6tNpOhLVFMuGLZ
   A==;
X-CSE-ConnectionGUID: sgYmEIZER0aB0odYn24RDQ==
X-CSE-MsgGUID: 2NwLtnZLQZmPi5aP3eAWKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55394362"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55394362"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:03:22 -0700
X-CSE-ConnectionGUID: CCusetCxTSC4+Wl/AeNBuw==
X-CSE-MsgGUID: LMn9d6ryR+KLmWU3Y6vlhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="190127372"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:03:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:03:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:03:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.75)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHGTqB25bpFW4o0yq3JV1dHyQyNEMEhzX5eEjTOXBVQAuAI9eF8cB1XWDQ6vMg1JW6a/1sw64edHx9yqGyBWu6qlIFcoWfwJ3RxOpN+mpnndSbCNtyz36p4wCfqZt/spj2J7lksnk8Ql4zNSXdo2aezm/2wVYWB0SMYeer+PbdAEGYSaBVkmAxeRin8XY7h41oJUkuJz2+1dD6h19EBbJk6ut8JvEUPqjMPG3QRad5qr9KufVqB2UfGRNYWasMB0c9jM70iKeL5q00s4XOkHjqUmTP/bCIax3uJjxU95F1noOINAOAfxj1XUveIIwUIizlDBhkxpYUZG7cKpFbfE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5CduwbxfpEMrrKwdn443+bbPd/R54MrdEWJn0/dQZQ=;
 b=w0PPh/1R64hOjTFPQ5dZbItZ3uv1/cQT6H/qbsajPdjlvuQwt23alaVPc5vHRau+RI1tUKc0rfUGtIPeqPjTNlpK5QysQf0zsS+wNqnhQz0Q8nTpEmVATxtOsO6QlrfU5AFVzxwJn3vbk37+eteD1KtcqWLoRg0RkEX2MgLuxAErdpNb/VkTHc2vF35+YOUyEOxZXpeXsmb3FCVRwqvEngZbQFJDD6KJ6FwWjP27NVJrNeYq5fdJ6a7um/KhSLAKu6bxduZ1F5ijnYpuIdN+5dnLRscoQIlR98G6OLXEFrRUVYszKcKzZysVMWkZEvnEmxXWtcxxKnWsn0Y2b4crvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by SN7PR11MB6947.namprd11.prod.outlook.com
 (2603:10b6:806:2aa::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 15:03:15 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::ac04:7439:8737:a3ff]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::ac04:7439:8737:a3ff%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:03:15 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
CC: "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: RE: [Intel-wired-lan] [PATCH net v2 2/2] igb: xsk: solve underflow of
 nb_pkts in zerocopy mode
Thread-Topic: [Intel-wired-lan] [PATCH net v2 2/2] igb: xsk: solve underflow
 of nb_pkts in zerocopy mode
Thread-Index: AQHb+w/BEWMBfQk5dUSjevn4tj+qw7Q+PUTw
Date: Tue, 22 Jul 2025 15:03:15 +0000
Message-ID: <PH3PPF7A88A980A42000BD3AE75C833BD6FE55CA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <20250722135057.85386-1-kerneljasonxing@gmail.com>
 <20250722135057.85386-3-kerneljasonxing@gmail.com>
In-Reply-To: <20250722135057.85386-3-kerneljasonxing@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|SN7PR11MB6947:EE_
x-ms-office365-filtering-correlation-id: 8a56cc48-27ab-4831-e7d5-08ddc930e290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?gf1Zm6epN61MVPC3zkJj1F69uNF0Yss8IdyAI2yGmMIKZLaeEFNJX2Y75nVv?=
 =?us-ascii?Q?oFa/zAhpdlYk2HYXk3teTDuLq8P04PeFSo0clb+hPKGm2Oxj4mKbHj0Y87IE?=
 =?us-ascii?Q?3YrtRtiYHxrtQmcSkeyNwDPBMOKdyVurimPB1g3PKVZC7RuD6zSWsYe8VmCb?=
 =?us-ascii?Q?nNr8FSMitKSqd+MNJORfh8HHsJQDJa41OxpeVZVK6TnA/AGux9JYhufkW2bj?=
 =?us-ascii?Q?EngaNjTP5axv1BHYPx1ZmKuZ0L/3SE0AVfA42p3oaWt9U7hcENZBS7FM/p9q?=
 =?us-ascii?Q?/YybXWRWAzZ8V/DRVcubkRRdsgkyaaT9dk3MS+1QBTR7JaqtQjdg+l5f7hJL?=
 =?us-ascii?Q?uyJ9yBE3pIsM3WOzMzPG3GxnpV9XXutD6i604Gid1KxWW+LAZWaNZs72vbU8?=
 =?us-ascii?Q?v1M6myhnZ/a+pl5Sb1vEpuVmBf8Aa+cBO7b2JrK7I6hjAAV8uA7gU+Jlm7Pj?=
 =?us-ascii?Q?RIuBDxTd6ctKwbDNVp7W+Op5x6ndwqw/vdIavZecaLgkeSV6E2FIgFQxxwQb?=
 =?us-ascii?Q?xy/h9WO9/sJedfwcJmBCJLa8zXrUyOXs0uWGFYT/qSG5VaA6zARklbxt7LPZ?=
 =?us-ascii?Q?+B4BiX8eclYWpqc9VyNhhgvXr2zetiI0+MAjVgOiqekXhZ1WvIR+i7CMoUHr?=
 =?us-ascii?Q?mjmNgkPnWru90eqlQTNSn8F2lc88kICtD89/i618hziNEjcJKzKyENTG9v7h?=
 =?us-ascii?Q?MVqbsNY5iUP28Uko+qczO+ze10E2KQ/n/kFxlxrfPrXRDxpklKkqTf8Qy0fJ?=
 =?us-ascii?Q?EtGAISxZhfHPU9fjuygl4IHCO4FvdpTr4s2kUcj/PrJDJPCqJ81jrHN9SVIm?=
 =?us-ascii?Q?eng6HYGxj4CJfnW8XPEzfuOiis4hiM100VpI08+LvvaPqCfvHEZ/vqlrTCdo?=
 =?us-ascii?Q?1JZbdCCafD0ODBlvsEY5ZWLPjS3EErmXCXAZ8sVnZjPl7ca7/SqHgdEZ5tw3?=
 =?us-ascii?Q?w3bCVwtxbgxtb8AcrLzXXfPKUUX6I1ktD/rgTjOkwJM8Hi1sZrwKyNPLr9m/?=
 =?us-ascii?Q?JwurDp2/wvjClH9dM+qb7+tIv0k6nZJ6/88NomTkLLMymZs60FJoWq2dNP3k?=
 =?us-ascii?Q?HEr5bQdR0vVpharMPpOWWwXDI0fiMCj9JN/O0luMs8rVwJUh+7iL2S5565kS?=
 =?us-ascii?Q?Tx4qQLoSp9cg28KTHGUlv1RSZ7aRAC9CzA4mDftrb7jAdGkrnwebr57D07+L?=
 =?us-ascii?Q?kGbvinXDeAy754dcJ4OTi28cexQD228g8qLNh380KlY0dBBZXPUfuEi6kkx9?=
 =?us-ascii?Q?SK4+a9AO8uMz4jitw5aCpUTX+/wr108aNDf9fOWFZwsqiTAuJmEeTW2iWT5k?=
 =?us-ascii?Q?ElL6oieVOPeKb3goH19Bu4zCSuj6SJBgEzXgBiZAa8uSsGz1yzTsg/X8m8Ca?=
 =?us-ascii?Q?RuMzY6hhpJOHXrvP2j3DfUhXqeF4T8wPlWr1h3YKlPCDWUqMQeTLmMwVEPIP?=
 =?us-ascii?Q?hz06NW1MGPKmM4ma/q8GiMrcUF26YFrP93wIJalZ1AN2T3j3AIRPI0bkr4Dy?=
 =?us-ascii?Q?CayfXio5EBnYxFrvxoZ9QVPul0JQAycZOGuH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jQ2eupHiZleXPBH2u/5s3Kf4/Yo5YuBuvUNkBd+sSUM6MGW0fMx5QJayfLS2?=
 =?us-ascii?Q?8E8ZncCIJO3ziSA1AOxj5d5cKZrOCCvzMkAtG5goHFaPOYBHRN0b0orovUp0?=
 =?us-ascii?Q?tS+4580v2PBY3dz3Pyv+nj3TBXbwxwFCGEkJxrUCToX7CY6eY8x/XLmcXME/?=
 =?us-ascii?Q?skh0IcUpwjqMZuE7JH8NRHuUFZTUycaUY6Gojuw1ylt7cXL93HXZdXZ8pPAl?=
 =?us-ascii?Q?z4O2L0HuS9XsdHJxA6g1nBQz9+L3ZqOQ2LFXOyF/3HGM4RwnayaaPAoZXv6D?=
 =?us-ascii?Q?fbCQr1L2CUxiBZHjfv3+sF0IQ3/N+YKOO8FAJhZDsJGLcEOqbmqb9LaKJW9Z?=
 =?us-ascii?Q?+W5KCNgjYAQL3DnBt8NxRvMspFxyPta1iAHAGqkLcajRKp361nLOS9z15fGf?=
 =?us-ascii?Q?T7SSe33ukq/quQ+3JSTrlV9qQijbNQhgRv6sA5sXIG9x8NqsAldhO5h75O8M?=
 =?us-ascii?Q?LyMVVvsk7xZMvq3bzMsd2yTz9ZpBuTShbunqOEFR3sVcPDiwAw6C1CIJjAwv?=
 =?us-ascii?Q?gKTkpFpAtFWN+C1Ibm3hB5OD8zpzP+HTZvJZYr0KKRck5zr2fjRM6X4q5CYB?=
 =?us-ascii?Q?EoEkxi/30+3mqyMX1Q7e+2hI+k6TEqNUGjIbadPLAS0xLkgP67OT+OdzwH0v?=
 =?us-ascii?Q?ZqDFKN2A2i8oaeyhxw3AGh+10HKFpYsXQ+1r0Lz62M/s0OoVnnpOK3lssL0v?=
 =?us-ascii?Q?cxRRnXDSr122xLZLp96XwfggGqNrYjHt6cZR/6XWHa1nFJeycn8XCOYMaWqz?=
 =?us-ascii?Q?G76IyRt3JbXRwzur+vC4lKJ0iLBaIB/W01PnsMH5twvrsTF103grx1lVYwMu?=
 =?us-ascii?Q?qhsgIp6RgA0U/GxjeU2SzeutiSYSytg6LFDjHMMf9gUujJ4Isa/zX9PNcwFN?=
 =?us-ascii?Q?W/IjKi0sioWNdOA0m4qR8296QPrSemmsQlg7AuWheTO8aZDFNiZpPufC0t5k?=
 =?us-ascii?Q?FYFY2WL1T3UHuUql7/Brz9iiafM+zL0sOeLrwcoGwk7MhKsESMZxg0rLL2Eu?=
 =?us-ascii?Q?VN1yzY0gWoNK7KOBk4JRtWqBkU6+qBEeBON8buQe/ONMOO1NdtjeSvpdGPQv?=
 =?us-ascii?Q?OiVtTK3H0n2uARgmpGmf6I+9mLrs6q+r5N/Lp8vQMzS3vM/OVR84Y6T2LHpS?=
 =?us-ascii?Q?EW5wGcKdz1LthF1vrdhZEm/TwfPOn0kPzdGmlkANodTurxtr2dfg2HNfVSPx?=
 =?us-ascii?Q?ct+jCxmpHKSmYt0cgQW23jjZ2TOcuapN/VDgE6/Ko7Bd2EkkuqusTRh3KAdb?=
 =?us-ascii?Q?hz3JCMNsV6mAfOLzVC1RhkPdwxTgFvpPxu5yhQPFGyAhqjWcHRw1bTbVu5Dc?=
 =?us-ascii?Q?a0hMuP4UbOq4drPNGxqetuwmic+SHIZCOq3iAwx33UqNHXgvutUNFYrHHCl3?=
 =?us-ascii?Q?QxKf21/S9kDI3+nFpSz7hEtXwCSMn2ucxMOgDjhr3z+8FsWYpM/+Yzx2rAbq?=
 =?us-ascii?Q?7dtp0j80lqcUgME2FbS1jfbnD6z7u8rtBz/YHc+n646tURC1OgkBVuZpBy9V?=
 =?us-ascii?Q?xV/JBUX10EJ8ILrWVNBSw9Wpw9a60HOVaiih2ju5c26e8ZBQhwkZ4CjWzPCU?=
 =?us-ascii?Q?HuR9Y5e9no0Ix6Hs/y8nzdJcNHHoIooazGuCwH7O4vyIkRp/MFFTnkvZtUxw?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a56cc48-27ab-4831-e7d5-08ddc930e290
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 15:03:15.2834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuuLYPUIU2PyLAjqV83s6AFbXI33AL2xudEu8WkmPoNPTpg/tOABVB275OvefQ4We3ZQC9alVF+ae6q9+rYCV4OB8R/XtAXk1+KSV8QU5/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Jason Xing
> Sent: Tuesday, July 22, 2025 3:51 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; bjorn@kernel.org; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; jonathan.lemon@gmail.com;
> sdf@fomichev.me; ast@kernel.org; daniel@iogearbox.net;
> hawk@kernel.org; john.fastabend@gmail.com; mcoquelin.stm32@gmail.com;
> alexandre.torgue@foss.st.com
> Cc: linux-stm32@st-md-mailman.stormreply.com; bpf@vger.kernel.org;
> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Jason Xing
> <kernelxing@tencent.com>
> Subject: [Intel-wired-lan] [PATCH net v2 2/2] igb: xsk: solve
> underflow of nb_pkts in zerocopy mode
>=20
> From: Jason Xing <kernelxing@tencent.com>
>=20
> There is no break time in the while() loop, so every time at the end
> of igb_xmit_zc(), underflow of nb_pkts will occur, which renders the
> return value always false. But theoretically, the result should be set
> after calling xsk_tx_peek_release_desc_batch(). We can take
> i40e_xmit_zc() as a good example.
>=20
> Returning false means we're not done with transmission and we need one
> more poll, which is exactly what igb_xmit_zc() always did before this
> patch. After this patch, the return value depends on the nb_pkts
> value.
> Two cases might happen then:
> 1. if (nb_pkts < budget), it means we process all the possible data,
> so
>    return true and no more necessary poll will be triggered because of
>    this.
> 2. if (nb_pkts =3D=3D budget), it means we might have more data, so retur=
n
>    false to let another poll run again.
>=20
> Fixes: f8e284a02afc ("igb: Add AF_XDP zero-copy Tx support")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2
> Link: https://lore.kernel.org/all/20250721083343.16482-1-
> kerneljasonxing@gmail.com/
> 1. target net tree instead of net-next
> 2. use for loop instead
> ---
>  drivers/net/ethernet/intel/igb/igb_xsk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c
> b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 5cf67ba29269..30ce5fbb5b77 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -482,7 +482,7 @@ bool igb_xmit_zc(struct igb_ring *tx_ring, struct
> xsk_buff_pool *xsk_pool)
>  	if (!nb_pkts)
>  		return true;
>=20
> -	while (nb_pkts-- > 0) {
> +	for (; i < nb_pkts; i++) {
>  		dma =3D xsk_buff_raw_get_dma(xsk_pool, descs[i].addr);
>  		xsk_buff_raw_dma_sync_for_device(xsk_pool, dma,
> descs[i].len);
>=20
> @@ -512,7 +512,6 @@ bool igb_xmit_zc(struct igb_ring *tx_ring, struct
> xsk_buff_pool *xsk_pool)
>=20
>  		total_bytes +=3D descs[i].len;
>=20
> -		i++;
>  		tx_ring->next_to_use++;
>  		tx_buffer_info->next_to_watch =3D tx_desc;
>  		if (tx_ring->next_to_use =3D=3D tx_ring->count)
> --
> 2.41.3


