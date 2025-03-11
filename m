Return-Path: <bpf+bounces-53823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36309A5C341
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B468D1891274
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B421A25BAA1;
	Tue, 11 Mar 2025 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiXvZua5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27E25B685;
	Tue, 11 Mar 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701992; cv=fail; b=g3e+lg31R3tWouNg/6E+5OGpE9hYJcMbBsmh2urWJ1/ePo6zUIHn3VWVCTf2ZAvuNglAAP9pMjXSh3SV6Pt0ZUGzM0Rm4lQ6S6RV+Zk2iOcTppy7kIHD9xPu/AoUoxupET6T+XI46mF292hjJmdWeqi5TyE67lunLht9f1i7rHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701992; c=relaxed/simple;
	bh=6frMd9O/tTRIP5OGWQ9dEiHPe3DMjohRm9toecC9dLQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HbTHxGpHLFXdyPmA+DX3ords9hkeHYvp+EU6Qu6fsVXaGQipNgJEwt0Zz2KzUkV73itClriiachpxw+53e3jvT79q6FfhTSo3rk2+h+7+anHg2eLTqYi1+kHzub8K4Zwp6/mpP+MbtdlosEgXRasEB4PFTZ1eXinEYOA+fkRUGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZiXvZua5; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741701988; x=1773237988;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6frMd9O/tTRIP5OGWQ9dEiHPe3DMjohRm9toecC9dLQ=;
  b=ZiXvZua5gBAMEO9UPTWA8Qh9OxZDyt8viL+ycP96ESD0jrruKU1oM8Gq
   4jq7nwnyACh5Y9iFHtyHZNlsI9JNUnOCRfEZeb27P8Zp5nHJl80FQMoXU
   dtGhH9W99+wA5fhcmk5FZY6h5ARj0/zCIE0DlZFuB3EqqAbdQZT5Wr9wK
   bk2Qr6dj9/LNCugQKYO89RbXa8gckxRwxRvvuDh05VdEmQkYEe54ErLCp
   Zo7tYiN++GHFu8F3X7D6m6vLAdvorr6ahEIP/oFyEwuRZTXYz28mjt6XB
   gnV/EIWjBoNTA7ceN9SAnQWexHXR/tUTofJM2BvMlCpnF/ExadZMOYyPz
   Q==;
X-CSE-ConnectionGUID: Sm422iERTcO0tQGb3SUUKQ==
X-CSE-MsgGUID: tlMuBxDaTg+NkE9J1qkADg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46653291"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46653291"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 07:06:26 -0700
X-CSE-ConnectionGUID: p/ei256VSkytPRk0qAAjLw==
X-CSE-MsgGUID: Knp/ny0gRgiuAqhURr1cgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120364252"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2025 07:06:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 07:06:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 07:06:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 07:06:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6B1nNHGljou35NMYy9zq1EMfRHSKbPyy18f3aGWo2lu9r6+b2vgFYK5IkFvoxPNFBEVeR0pVFtd/6UTMXnDJvWnPox5QG6rqPCTS7PdYSagPrn82bI4ymUey4kgouFsX90fTNs/nBoTvjJqMwiIenOusa7rIrxs2ZG9NMT6GArzk566Hhi7oGVqw9OqMhSLN63WQhE4Yvi/3NjL+NuMGvU/TBVmDFlPzv6w0kqhQO2iduy55LLpCXUMRj5aCh4OL0xRuZPF16hNOElv88dax/+9dJQYTjZStF/nme3nTIoaz1myN/AGq6qcVptqZe6H7HYWmaBEwGmCMZTTN3A5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B6/MVoVzPrJcgZuE9bAbGQ8Tq7n0bPdA8J1hL0DSVI=;
 b=we98oxEXac2Ogimj/+enncUn1VjfO6K7+5qI958fsgLqJiYYt4gFav4ec4ateyD2CDxF0vsJ69NvNdsC+eK05/v4tOwqP4LNOy0yn5mW7IK3emv/HIkS4uxiAqY9rSngc5Lr2cj4nTfpacc5L4itImqEMeqFmUEJyIMSVd5a3e5sjPgmYr05GwUcw6mzd4e6ZlQdBdYY+8wlpfLeMD4oO0PCYfuBw3DT1PBbJU2JgnoLwaxSOlrFNgsDwyGrK4L6x2Wj7NoS7Pcj2JeCbpiLOPcBCvk4zX7l/1o/ZXWKF4O9KFU5xIy0gTAR4R6yer+JabaRqvuEzflSfFPrzGmoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4781.namprd11.prod.outlook.com (2603:10b6:a03:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:05:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:05:51 +0000
Date: Tue, 11 Mar 2025 15:05:38 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 03/16] libeth: add a couple of XDP helpers
 (libeth_xdp)
Message-ID: <Z9BDMrydhXrNlhVV@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-4-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305162132.1106080-4-aleksander.lobakin@intel.com>
X-ClientProxiedBy: ZR0P278CA0131.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5d530e-4e7f-4e55-47c6-08dd60a5d48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xfonHRgT5oiE+9qkDFvnd5Z8ILuVqcmE0oH2NcqzXQbW8Gnfs4ntobUWycUJ?=
 =?us-ascii?Q?meweSrCmzJ0m6M2F9MfNy1sy2UbYKxnLAV7WhWKX0wraBD/jpX9DCgwAxHfY?=
 =?us-ascii?Q?Oai9Q7Ns91ryt6Jj3iplibKfIZzknOxwZSmLi9MuvtNhjc/z1vaO84doDw3m?=
 =?us-ascii?Q?Sa/N9+1v0I7ca7nKyhEmxG7zqIUJNy1SHnCrrL2EDC8KjU6LHXMoXptTv1IQ?=
 =?us-ascii?Q?NTsEH+n0CiCeZHRrbPHSBvDTC0tYaqpFJ+oNQoZBDp/j3c9o0Oq+H7Lq9czA?=
 =?us-ascii?Q?WfW6Hz/mk6GQvAaYpbGPizrJxPVPy8+j4LetIJa+3Xrvd72G/CkhGulmIvpd?=
 =?us-ascii?Q?v/ok25vv8zfMl1FdtzfjpwCTg5tn0dv03HaaFYwlZvacU+I4l1pIICVM3RnV?=
 =?us-ascii?Q?g9G9Q0I+9lzSTEFcS09+h1l2FMB+zXJZithcZziysfDC35Q88hRXwMkc+xZV?=
 =?us-ascii?Q?P45mnihl3MX8vX/h9ApbV+Rr+6rqN43LoRpSm5bYmEm5lZRyQ3Uq8S8fagM6?=
 =?us-ascii?Q?WXjNBvGnv5cQNH7zGjKrsyw9JiczoTz6KWqe+tlDiWZ34nkP7VTvAdWBcAPx?=
 =?us-ascii?Q?PHZREljk02tBgMzZB/QYTEgiJiYMdHG1GO2yG7V1k7l/YaYLjcNUSSyublqM?=
 =?us-ascii?Q?khDR9qTuZ4VSAL/DCEplU+nPISgZX2qbnzVq48MH1G/8tbJ4ogC3osP4ipT3?=
 =?us-ascii?Q?M1rm7joHNfSiW6uCuEgyUDZpLOBlkhoRZZqod+Gx4E/LYp7Wcnk6n7kigDwQ?=
 =?us-ascii?Q?Jf3mp4WUy+yziEhdQFkYa4jJ+z/MdTxtwrWav7HwQLWL9EwTovJseV0F6ix6?=
 =?us-ascii?Q?LoEuw2KUa3N2EvbXYU9dP6Hvdi7AbIEp6reRaUt4Ym7IfMSaTZ8rtacDvFMD?=
 =?us-ascii?Q?OOFkQThzLhpJ3JsNp8vpNtHtE/7rJsnUqk9sms9czd40qVgaFvRANOSHQxwf?=
 =?us-ascii?Q?Kjvsrhs+Ry3MB14gOSeQFDqAqWs+RWdPNmqsyRDCEZL3u8gcVPacIXUP434k?=
 =?us-ascii?Q?1Y1T201rm1DFUZ+qSAYcqjsplRSm4EOrBID7WgHKB25yX59/NVD6l3LqBgcn?=
 =?us-ascii?Q?RZagfQzHO5g8kQaWeB/w/Z/zPyrLz1HpqTr9H+8nurBZlWHNKO1vCmvWh/xl?=
 =?us-ascii?Q?FUkKH68ET6K2DJ1SbP2mEnd8ZU8CGV2S0cnaEmfNSFxlEQOInm6z8rfM4Z1H?=
 =?us-ascii?Q?+8aiQig+LuGz0YM05hOh+wODavFRa0KvZM9yL1zusiIfquK4YOBJiZ7OgoMH?=
 =?us-ascii?Q?1271c5M4r4QqeYemEKHKzmCCZHAB9jRBNp5Q/B1PNQaPY8/Ad+xX6C3TBkGi?=
 =?us-ascii?Q?pwZ1WO1Q4UybvK8f6aCrIlAywElq+7i7b9tcCiBK7Y+WwZRe7quHrATClimA?=
 =?us-ascii?Q?coA9/2EXBMC4HkGkI2VxJ/KL9S9l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3IKpxuB7DdY64vIgySckC46GXFmVbYsnM7S0S4xz9qnBglPd9p1/P+bk39Zu?=
 =?us-ascii?Q?/XL812giQ6LzWva0bOAs1TIs922bwZM9QaIT10b76tiSTKEG5VpcXGF8y3rj?=
 =?us-ascii?Q?symBc6582R/Oio/TIYEIA0EyqizTP8xZomL8Kifdasx8YuihqRkTsDJ+Sg4p?=
 =?us-ascii?Q?Ilh0lsLpfXn79VCQDvoFmAobDRiMixWp33FytabU57zXXCoeoa7p55gG/l7+?=
 =?us-ascii?Q?OpXf9SR8Lc6ddb13Cse2GVrmgRrqLI4CfBU+6GzQEk1b4f4ejtf3jGU3alP9?=
 =?us-ascii?Q?psiOU7i7t8o7snUln1mEbIbNQh/Wvfhwk0CdX6N84fYQ7JYChoY0FpnFNPhi?=
 =?us-ascii?Q?0nDHUBbkHYdUwGYqSssr/lzn02J1HZTQ3JmnAmJg+hwLt/p6RnSdmmiX56Vy?=
 =?us-ascii?Q?1PgthHOb5dW/laeyh2iO4XMVDhyYL5OYNSfU58iFZs7Mqu57Eg10+0DXNT3q?=
 =?us-ascii?Q?MUhGKQFdxaUal5t1r3E1oMAAsRjZb7Gmu1XijqOYzVgoB1jKvKY9JOEVrFlG?=
 =?us-ascii?Q?jb72E4toZDfz0ud5hGrfVb6qQ06x52md3KWhnCPY17kkedDWoyD5JsWYekkg?=
 =?us-ascii?Q?USjLPkpvz07Ke6Tox7Cjap6NXn4Q4J9GtQf8qZv9WrBsot30IhEhIJwvGEQh?=
 =?us-ascii?Q?yjKm4OCstjGHnjKT0vg12c8ONN4c096+r9kwIWk6RvZ9oDJDOAxNdWrY1OQo?=
 =?us-ascii?Q?zgUzMI9q0ahBBZuzNcgOB4ieLbKcRuwbvrxulFv5cU8xPgVUnKekwABaitLq?=
 =?us-ascii?Q?zhrWchDkKHDYJOLsYEwU2Re6Vdh1Sp1olV6s6QNkvMoxfvPyvxCJ3pFLVHBD?=
 =?us-ascii?Q?kxIpWxq/j0TMkBsdRi/PWi4j6Qt9p8X3hPv4JSw4uQO9Wgw+RnTj4hI2CyWe?=
 =?us-ascii?Q?COkcj8sewHTOzUDTFkkiZS/fFK/y5GOvqW7Wga3e5cJ/P5zvdQX1LGSCc4hp?=
 =?us-ascii?Q?GnZj4al/ug+ZVtZQb27/mhwVXbDZtVF1ljPnoUkoRXBlbmoZlJQCSI8hdchJ?=
 =?us-ascii?Q?ngAoGutjlBdVbWyI1/txZ8UJG0yjK1bpefbu0sJwHOkj2P7CJlK7MTWJIBK1?=
 =?us-ascii?Q?kw/kweuIxXX9izNCIwOdNQc7S97lTRaJEGXzjNH096zCBSi/mjxqc+4bRScL?=
 =?us-ascii?Q?/gg9xQa4iCRwDa+HyemGgexfhEwdL9QFvVzn42T4vH7de6PKy0Efw/hBH1Jp?=
 =?us-ascii?Q?4S7XsbrfXVcInukvkdTPA+A356RKhqKI04tpp6yNT3GKVMn9ha1ibv5tkdmW?=
 =?us-ascii?Q?zy6dqNZOpjCbZMRI4P7a3Xcj2qh6mYSUrDXw4jQHe2Gchjuw62jg7s56v3Os?=
 =?us-ascii?Q?m96gMQX8LRb0jyEWTz53/DJ3D7myBBFvwBHe8dMtsCBtEzPhhlZ4nDX54l2a?=
 =?us-ascii?Q?0zlVctbppct7kin+DVKZNGB4/0zlMU99D6enXWATh/RyPcXAMtrk1WOXGINH?=
 =?us-ascii?Q?P3i7JAaGaNY9G6ETsU1fNScU/y8WKHDX08dOQPkdga02K0qpktWhzm04W04L?=
 =?us-ascii?Q?zzwxZN3PTl3EzENuGt+sOo+1npRm36Aez3Ko6rRUzAXjVPoR4Casi7EmTrFE?=
 =?us-ascii?Q?5djoYvguEP6aUHHCOxRqln5FkodqqYmud3bfF4OaMu72ZlRgL3G8LDiEMljb?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5d530e-4e7f-4e55-47c6-08dd60a5d48f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:05:51.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnPOK+c9mytAKJiuaN9486MfJbXXsNWXffifwnr1gWfhnRvjPShb5t2Ahe6c9eWq34qHhot6LuXJBJGfbXxd5lwpUwF1PsI91q+Uiw8xF10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4781
X-OriginatorOrg: intel.com

On Wed, Mar 05, 2025 at 05:21:19PM +0100, Alexander Lobakin wrote:
> "Couple" is a bit humbly... Add the following functionality to libeth:
> 
> * XDP shared queues managing
> * XDP_TX bulk sending infra
> * .ndo_xdp_xmit() infra
> * adding buffers to &xdp_buff
> * running XDP prog and managing its verdict
> * completing XDP Tx buffers
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # lots of stuff
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Patch is really big and I'm not sure how to trim this TBH to make my
comments bearable. I know this is highly optimized but it's rather hard to
follow with all of the callbacks, defines/aligns and whatnot. Any chance
to chop this commit a bit?

Timers and locking logic could be pulled out to separate patches I think.
You don't ever say what improvement gave you the __LIBETH_WORD_ACCESS
approach. You've put a lot of thought onto this work and I feel like this
is not explained/described thoroughly. What would be nice to see is to
have this in the separate commit as well with a comment like 'this gave me
+X% performance boost on Y workload'. That would be probably a non-zero
effort to restructure it but generally while jumping back and forth
through this code I had a lot of head-scratching moments.

> ---
>  drivers/net/ethernet/intel/libeth/Kconfig  |   10 +-
>  drivers/net/ethernet/intel/libeth/Makefile |    7 +-
>  include/net/libeth/types.h                 |  106 +-
>  drivers/net/ethernet/intel/libeth/priv.h   |   26 +
>  include/net/libeth/tx.h                    |   30 +-
>  include/net/libeth/xdp.h                   | 1827 ++++++++++++++++++++
>  drivers/net/ethernet/intel/libeth/tx.c     |   38 +
>  drivers/net/ethernet/intel/libeth/xdp.c    |  431 +++++
>  8 files changed, 2467 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
>  create mode 100644 include/net/libeth/xdp.h
>  create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
>  create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
> 
> diff --git a/drivers/net/ethernet/intel/libeth/Kconfig b/drivers/net/ethernet/intel/libeth/Kconfig
> index 480293b71dbc..d8c4926574fb 100644
> --- a/drivers/net/ethernet/intel/libeth/Kconfig
> +++ b/drivers/net/ethernet/intel/libeth/Kconfig
> @@ -1,9 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -# Copyright (C) 2024 Intel Corporation
> +# Copyright (C) 2024-2025 Intel Corporation
>  
>  config LIBETH
> -	tristate
> +	tristate "Common Ethernet library (libeth)" if COMPILE_TEST
>  	select PAGE_POOL
>  	help
>  	  libeth is a common library containing routines shared between several
>  	  drivers, but not yet promoted to the generic kernel API.
> +
> +config LIBETH_XDP
> +	tristate "Common XDP library (libeth_xdp)" if COMPILE_TEST
> +	select LIBETH
> +	help
> +	  XDP helpers based on libeth hotpath management.
> diff --git a/drivers/net/ethernet/intel/libeth/Makefile b/drivers/net/ethernet/intel/libeth/Makefile
> index 52492b081132..51669840ee06 100644
> --- a/drivers/net/ethernet/intel/libeth/Makefile
> +++ b/drivers/net/ethernet/intel/libeth/Makefile
> @@ -1,6 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -# Copyright (C) 2024 Intel Corporation
> +# Copyright (C) 2024-2025 Intel Corporation
>  
>  obj-$(CONFIG_LIBETH)		+= libeth.o
>  
>  libeth-y			:= rx.o
> +libeth-y			+= tx.o
> +
> +obj-$(CONFIG_LIBETH_XDP)	+= libeth_xdp.o
> +
> +libeth_xdp-y			+= xdp.o
> diff --git a/include/net/libeth/types.h b/include/net/libeth/types.h
> index 603825e45133..cf1d78a9dc38 100644
> --- a/include/net/libeth/types.h
> +++ b/include/net/libeth/types.h
> @@ -1,10 +1,32 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/* Copyright (C) 2024 Intel Corporation */
> +/* Copyright (C) 2024-2025 Intel Corporation */
>  
>  #ifndef __LIBETH_TYPES_H
>  #define __LIBETH_TYPES_H
>  
> -#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +/* Stats */
> +
> +/**
> + * struct libeth_rq_napi_stats - "hot" counters to update in Rx polling loop
> + * @packets: received frames counter
> + * @bytes: sum of bytes of received frames above
> + * @fragments: sum of fragments of received S/G frames
> + * @hsplit: number of frames the device performed the header split for
> + * @raw: alias to access all the fields as an array
> + */
> +struct libeth_rq_napi_stats {
> +	union {
> +		struct {
> +							u32 packets;
> +							u32 bytes;
> +							u32 fragments;
> +							u32 hsplit;
> +		};
> +		DECLARE_FLEX_ARRAY(u32, raw);

The @raw approach is never used throughout the patchset, right?
Could you explain the reason for introducing this and potential use case?

> +	};
> +};
>  
>  /**
>   * struct libeth_sq_napi_stats - "hot" counters to update in Tx completion loop
> @@ -22,4 +44,84 @@ struct libeth_sq_napi_stats {
>  	};
>  };
>  
> +/**
> + * struct libeth_xdpsq_napi_stats - "hot" counters to update in XDP Tx
> + *				    completion loop
> + * @packets: completed frames counter
> + * @bytes: sum of bytes of completed frames above
> + * @fragments: sum of fragments of completed S/G frames
> + * @raw: alias to access all the fields as an array
> + */
> +struct libeth_xdpsq_napi_stats {

what's the delta between this and libeth_sq_napi_stats ? couldn't you have
a single struct for purpose of tx napi stats?

> +	union {
> +		struct {
> +							u32 packets;
> +							u32 bytes;
> +							u32 fragments;
> +		};
> +		DECLARE_FLEX_ARRAY(u32, raw);
> +	};
> +};

(...)

> +/* Rx polling path */
> +
> +/**
> + * struct libeth_xdp_buff_stash - struct for stashing &xdp_buff onto a queue
> + * @data: pointer to the start of the frame, xdp_buff.data
> + * @headroom: frame headroom, xdp_buff.data - xdp_buff.data_hard_start
> + * @len: frame linear space length, xdp_buff.data_end - xdp_buff.data
> + * @frame_sz: truesize occupied by the frame, xdp_buff.frame_sz
> + * @flags: xdp_buff.flags
> + *
> + * &xdp_buff is 56 bytes long on x64, &libeth_xdp_buff is 64 bytes. This
> + * structure carries only necessary fields to save/restore a partially built
> + * frame on the queue structure to finish it during the next NAPI poll.
> + */
> +struct libeth_xdp_buff_stash {
> +	void				*data;
> +	u16				headroom;
> +	u16				len;
> +
> +	u32				frame_sz:24;
> +	u32				flags:8;
> +} __aligned_largest;
> +
>  #endif /* __LIBETH_TYPES_H */
> diff --git a/drivers/net/ethernet/intel/libeth/priv.h b/drivers/net/ethernet/intel/libeth/priv.h
> new file mode 100644
> index 000000000000..1bd6e2d7a3e7
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/libeth/priv.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef __LIBETH_PRIV_H
> +#define __LIBETH_PRIV_H
> +
> +#include <linux/types.h>
> +
> +/* XDP */
> +
> +struct skb_shared_info;
> +struct xdp_frame_bulk;
> +
> +struct libeth_xdp_ops {
> +	void	(*bulk)(const struct skb_shared_info *sinfo,
> +			struct xdp_frame_bulk *bq, bool frags);
> +};
> +
> +void libeth_attach_xdp(const struct libeth_xdp_ops *ops);
> +
> +static inline void libeth_detach_xdp(void)
> +{
> +	libeth_attach_xdp(NULL);
> +}
> +
> +#endif /* __LIBETH_PRIV_H */
> diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
> index 35614f9523f6..c3459917330e 100644
> --- a/include/net/libeth/tx.h
> +++ b/include/net/libeth/tx.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/* Copyright (C) 2024 Intel Corporation */
> +/* Copyright (C) 2024-2025 Intel Corporation */
>  
>  #ifndef __LIBETH_TX_H
>  #define __LIBETH_TX_H
> @@ -12,11 +12,15 @@
>  
>  /**
>   * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
> - * @LIBETH_SQE_EMPTY: unused/empty, no action required
> + * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX, no action required
>   * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action required
>   * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
>   * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
>   * @LIBETH_SQE_SKB: &sk_buff, unmap and napi_consume_skb(), update stats
> + * @__LIBETH_SQE_XDP_START: separator between skb and XDP types
> + * @LIBETH_SQE_XDP_TX: &skb_shared_info, libeth_xdp_return_buff_bulk(), stats
> + * @LIBETH_SQE_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame_bulk(), stats
> + * @LIBETH_SQE_XDP_XMIT_FRAG: &xdp_frame frag, only unmap DMA
>   */
>  enum libeth_sqe_type {
>  	LIBETH_SQE_EMPTY		= 0U,
> @@ -24,6 +28,11 @@ enum libeth_sqe_type {
>  	LIBETH_SQE_SLAB,
>  	LIBETH_SQE_FRAG,
>  	LIBETH_SQE_SKB,
> +
> +	__LIBETH_SQE_XDP_START,
> +	LIBETH_SQE_XDP_TX		= __LIBETH_SQE_XDP_START,
> +	LIBETH_SQE_XDP_XMIT,
> +	LIBETH_SQE_XDP_XMIT_FRAG,
>  };
>  
>  /**
> @@ -32,6 +41,8 @@ enum libeth_sqe_type {
>   * @rs_idx: index of the last buffer from the batch this one was sent in
>   * @raw: slab buffer to free via kfree()
>   * @skb: &sk_buff to consume
> + * @sinfo: skb shared info of an XDP_TX frame
> + * @xdpf: XDP frame from ::ndo_xdp_xmit()
>   * @dma: DMA address to unmap
>   * @len: length of the mapped region to unmap
>   * @nr_frags: number of frags in the frame this buffer belongs to
> @@ -46,6 +57,8 @@ struct libeth_sqe {
>  	union {
>  		void				*raw;
>  		struct sk_buff			*skb;
> +		struct skb_shared_info		*sinfo;
> +		struct xdp_frame		*xdpf;
>  	};
>  
>  	DEFINE_DMA_UNMAP_ADDR(dma);
> @@ -71,7 +84,10 @@ struct libeth_sqe {
>  /**
>   * struct libeth_cq_pp - completion queue poll params
>   * @dev: &device to perform DMA unmapping
> + * @bq: XDP frame bulk to combine return operations
>   * @ss: onstack NAPI stats to fill
> + * @xss: onstack XDPSQ NAPI stats to fill
> + * @xdp_tx: number of XDP frames processed
>   * @napi: whether it's called from the NAPI context
>   *
>   * libeth uses this structure to access objects needed for performing full
> @@ -80,7 +96,13 @@ struct libeth_sqe {
>   */
>  struct libeth_cq_pp {
>  	struct device			*dev;
> -	struct libeth_sq_napi_stats	*ss;
> +	struct xdp_frame_bulk		*bq;
> +
> +	union {
> +		struct libeth_sq_napi_stats	*ss;
> +		struct libeth_xdpsq_napi_stats	*xss;
> +	};
> +	u32				xdp_tx;

you have this counted in xss::packets?

>  
>  	bool				napi;
>  };
> @@ -126,4 +148,6 @@ static inline void libeth_tx_complete(struct libeth_sqe *sqe,
>  	sqe->type = LIBETH_SQE_EMPTY;
>  }
>  
> +void libeth_tx_complete_any(struct libeth_sqe *sqe, struct libeth_cq_pp *cp);
> +
>  #endif /* __LIBETH_TX_H */
> diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
> new file mode 100644
> index 000000000000..1039cd5d8a56
> --- /dev/null
> +++ b/include/net/libeth/xdp.h
> @@ -0,0 +1,1827 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef __LIBETH_XDP_H
> +#define __LIBETH_XDP_H
> +
> +#include <linux/bpf_trace.h>
> +#include <linux/unroll.h>
> +
> +#include <net/libeth/rx.h>
> +#include <net/libeth/tx.h>
> +#include <net/xsk_buff_pool.h>
> +
> +/* Defined as bits to be able to use them as a mask */
> +enum {
> +	LIBETH_XDP_PASS			= 0U,
> +	LIBETH_XDP_DROP			= BIT(0),
> +	LIBETH_XDP_ABORTED		= BIT(1),
> +	LIBETH_XDP_TX			= BIT(2),
> +	LIBETH_XDP_REDIRECT		= BIT(3),
> +};
> +
> +/*
> + * &xdp_buff_xsk is the largest structure &libeth_xdp_buff gets casted to,
> + * pick maximum pointer-compatible alignment.
> + */
> +#define __LIBETH_XDP_BUFF_ALIGN						      \
> +	(IS_ALIGNED(sizeof(struct xdp_buff_xsk), 16) ? 16 :		      \
> +	 IS_ALIGNED(sizeof(struct xdp_buff_xsk), 8) ? 8 :		      \
> +	 sizeof(long))
> +
> +/**
> + * struct libeth_xdp_buff - libeth extension over &xdp_buff
> + * @base: main &xdp_buff
> + * @data: shortcut for @base.data
> + * @desc: RQ descriptor containing metadata for this buffer
> + * @priv: driver-private scratchspace
> + *
> + * The main reason for this is to have a pointer to the descriptor to be able
> + * to quickly get frame metadata from xdpmo and driver buff-to-xdp callbacks
> + * (as well as bigger alignment).
> + * Pointer/layout-compatible with &xdp_buff and &xdp_buff_xsk.
> + */
> +struct libeth_xdp_buff {
> +	union {
> +		struct xdp_buff		base;
> +		void			*data;
> +	};
> +
> +	const void			*desc;
> +	unsigned long			priv[]
> +					__aligned(__LIBETH_XDP_BUFF_ALIGN);
> +} __aligned(__LIBETH_XDP_BUFF_ALIGN);
> +static_assert(offsetof(struct libeth_xdp_buff, data) ==
> +	      offsetof(struct xdp_buff_xsk, xdp.data));
> +static_assert(offsetof(struct libeth_xdp_buff, desc) ==
> +	      offsetof(struct xdp_buff_xsk, cb));
> +static_assert(IS_ALIGNED(sizeof(struct xdp_buff_xsk),
> +			 __alignof(struct libeth_xdp_buff)));
> +
> +/**
> + * __LIBETH_XDP_ONSTACK_BUFF - declare a &libeth_xdp_buff on the stack
> + * @name: name of the variable to declare
> + * @...: sizeof() of the driver-private data
> + */
> +#define __LIBETH_XDP_ONSTACK_BUFF(name, ...)				      \
> +	___LIBETH_XDP_ONSTACK_BUFF(name, ##__VA_ARGS__)
> +/**
> + * LIBETH_XDP_ONSTACK_BUFF - declare a &libeth_xdp_buff on the stack
> + * @name: name of the variable to declare
> + * @...: type or variable name of the driver-private data
> + */
> +#define LIBETH_XDP_ONSTACK_BUFF(name, ...)				      \
> +	__LIBETH_XDP_ONSTACK_BUFF(name, __libeth_xdp_priv_sz(__VA_ARGS__))
> +
> +#define ___LIBETH_XDP_ONSTACK_BUFF(name, ...)				      \
> +	_DEFINE_FLEX(struct libeth_xdp_buff, name, priv,		      \
> +		     LIBETH_XDP_PRIV_SZ(__VA_ARGS__ + 0),		      \
> +		     /* no init */);					      \
> +	LIBETH_XDP_ASSERT_PRIV_SZ(__VA_ARGS__ + 0)
> +
> +#define __libeth_xdp_priv_sz(...)					      \
> +	CONCATENATE(__libeth_xdp_psz, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> +
> +#define __libeth_xdp_psz0(...)
> +#define __libeth_xdp_psz1(...)		sizeof(__VA_ARGS__)
> +
> +#define LIBETH_XDP_PRIV_SZ(sz)						      \
> +	(ALIGN(sz, __alignof(struct libeth_xdp_buff)) / sizeof(long))
> +
> +/* Performs XSK_CHECK_PRIV_TYPE() */
> +#define LIBETH_XDP_ASSERT_PRIV_SZ(sz)					      \
> +	static_assert(offsetofend(struct xdp_buff_xsk, cb) >=		      \
> +		      struct_size_t(struct libeth_xdp_buff, priv,	      \
> +				    LIBETH_XDP_PRIV_SZ(sz)))
> +

(...)

> +/* Common Tx bits */
> +
> +/**
> + * enum - libeth_xdp internal Tx flags
> + * @LIBETH_XDP_TX_BULK: one bulk size at which it will be flushed to the queue
> + * @LIBETH_XDP_TX_BATCH: batch size for which the queue fill loop is unrolled
> + * @LIBETH_XDP_TX_DROP: indicates the send function must drop frames not sent
> + * @LIBETH_XDP_TX_NDO: whether the send function is called from .ndo_xdp_xmit()
> + */
> +enum {
> +	LIBETH_XDP_TX_BULK		= DEV_MAP_BULK_SIZE,
> +	LIBETH_XDP_TX_BATCH		= 8,
> +
> +	LIBETH_XDP_TX_DROP		= BIT(0),
> +	LIBETH_XDP_TX_NDO		= BIT(1),

what's the reason to group these random values onto enum?

> +};
> +
> +/**
> + * enum - &libeth_xdp_tx_frame and &libeth_xdp_tx_desc flags
> + * @LIBETH_XDP_TX_LEN: only for ``XDP_TX``, [15:0] of ::len_fl is actual length
> + * @LIBETH_XDP_TX_FIRST: indicates the frag is the first one of the frame
> + * @LIBETH_XDP_TX_LAST: whether the frag is the last one of the frame
> + * @LIBETH_XDP_TX_MULTI: whether the frame contains several frags

would be good to have some extended description around usage of these
flags.

> + * @LIBETH_XDP_TX_FLAGS: only for ``XDP_TX``, [31:16] of ::len_fl is flags
> + */
> +enum {
> +	LIBETH_XDP_TX_LEN		= GENMASK(15, 0),
> +
> +	LIBETH_XDP_TX_FIRST		= BIT(16),
> +	LIBETH_XDP_TX_LAST		= BIT(17),
> +	LIBETH_XDP_TX_MULTI		= BIT(18),
> +
> +	LIBETH_XDP_TX_FLAGS		= GENMASK(31, 16),
> +};
> +
> +/**
> + * struct libeth_xdp_tx_frame - represents one XDP Tx element
> + * @data: frame start pointer for ``XDP_TX``
> + * @len_fl: ``XDP_TX``, combined flags [31:16] and len [15:0] field for speed
> + * @soff: ``XDP_TX``, offset from @data to the start of &skb_shared_info
> + * @frag: one (non-head) frag for ``XDP_TX``
> + * @xdpf: &xdp_frame for the head frag for .ndo_xdp_xmit()
> + * @dma: DMA address of the non-head frag for .ndo_xdp_xmit()
> + * @len: frag length for .ndo_xdp_xmit()
> + * @flags: Tx flags for the above
> + * @opts: combined @len + @flags for the above for speed
> + */
> +struct libeth_xdp_tx_frame {
> +	union {
> +		/* ``XDP_TX`` */
> +		struct {
> +			void				*data;
> +			u32				len_fl;
> +			u32				soff;
> +		};
> +
> +		/* ``XDP_TX`` frag */
> +		skb_frag_t			frag;
> +
> +		/* .ndo_xdp_xmit() */
> +		struct {
> +			union {
> +				struct xdp_frame		*xdpf;
> +				dma_addr_t			dma;
> +			};
> +			union {
> +				struct {
> +					u32				len;
> +					u32				flags;
> +				};
> +				aligned_u64			opts;
> +			};
> +		};
> +	};
> +} __aligned(sizeof(struct xdp_desc));
> +static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
> +	      offsetof(struct libeth_xdp_tx_frame, len_fl));
> +
> +/**
> + * struct libeth_xdp_tx_bulk - XDP Tx frame bulk for bulk sending
> + * @prog: corresponding active XDP program, %NULL for .ndo_xdp_xmit()
> + * @dev: &net_device which the frames are transmitted on
> + * @xdpsq: shortcut to the corresponding driver-specific XDPSQ structure
> + * @act_mask: Rx only, mask of all the XDP prog verdicts for that NAPI session
> + * @count: current number of frames in @bulk
> + * @bulk: array of queued frames for bulk Tx
> + *
> + * All XDP Tx operations queue each frame to the bulk first and flush it
> + * when @count reaches the array end. Bulk is always placed on the stack
> + * for performance. One bulk element contains all the data necessary
> + * for sending a frame and then freeing it on completion.
> + */
> +struct libeth_xdp_tx_bulk {
> +	const struct bpf_prog		*prog;
> +	struct net_device		*dev;
> +	void				*xdpsq;
> +
> +	u32				act_mask;
> +	u32				count;
> +	struct libeth_xdp_tx_frame	bulk[LIBETH_XDP_TX_BULK];
> +} __aligned(sizeof(struct libeth_xdp_tx_frame));
> +
> +/**
> + * struct libeth_xdpsq - abstraction for an XDPSQ
> + * @sqes: array of Tx buffers from the actual queue struct
> + * @descs: opaque pointer to the HW descriptor array
> + * @ntu: pointer to the next free descriptor index
> + * @count: number of descriptors on that queue
> + * @pending: pointer to the number of sent-not-completed descs on that queue
> + * @xdp_tx: pointer to the above
> + * @lock: corresponding XDPSQ lock
> + *
> + * Abstraction for driver-independent implementation of Tx. Placed on the stack
> + * and filled by the driver before the transmission, so that the generic
> + * functions can access and modify driver-specific resources.
> + */
> +struct libeth_xdpsq {
> +	struct libeth_sqe		*sqes;
> +	void				*descs;
> +
> +	u32				*ntu;
> +	u32				count;
> +
> +	u32				*pending;
> +	u32				*xdp_tx;
> +	struct libeth_xdpsq_lock	*lock;
> +};
> +
> +/**
> + * struct libeth_xdp_tx_desc - abstraction for an XDP Tx descriptor
> + * @addr: DMA address of the frame
> + * @len: length of the frame
> + * @flags: XDP Tx flags
> + * @opts: combined @len + @flags for speed
> + *
> + * Filled by the generic functions and then passed to driver-specific functions
> + * to fill a HW Tx descriptor, always placed on the [function] stack.
> + */
> +struct libeth_xdp_tx_desc {
> +	dma_addr_t			addr;
> +	union {
> +		struct {
> +			u32				len;
> +			u32				flags;
> +		};
> +		aligned_u64			opts;
> +	};
> +} __aligned_largest;
> +
> +/**
> + * libeth_xdp_ptr_to_priv - convert pointer to a libeth_xdp u64 priv
> + * @ptr: pointer to convert
> + *
> + * The main sending function passes private data as the largest scalar, u64.
> + * Use this helper when you want to pass a pointer there.
> + */
> +#define libeth_xdp_ptr_to_priv(ptr) ({					      \
> +	typecheck_pointer(ptr);						      \
> +	((u64)(uintptr_t)(ptr));					      \
> +})
> +/**
> + * libeth_xdp_priv_to_ptr - convert libeth_xdp u64 priv to a pointer
> + * @priv: private data to convert
> + *
> + * The main sending function passes private data as the largest scalar, u64.
> + * Use this helper when your callback takes this u64 and you want to convert
> + * it back to a pointer.
> + */
> +#define libeth_xdp_priv_to_ptr(priv) ({					      \
> +	static_assert(__same_type(priv, u64));				      \
> +	((const void *)(uintptr_t)(priv));				      \
> +})
> +
> +/*
> + * On 64-bit systems, assigning one u64 is faster than two u32s. When ::len
> + * occupies lowest 32 bits (LE), whole ::opts can be assigned directly instead.
> + */
> +#ifdef __LITTLE_ENDIAN
> +#define __LIBETH_WORD_ACCESS		1
> +#endif
> +#ifdef __LIBETH_WORD_ACCESS
> +#define __libeth_xdp_tx_len(flen, ...)					      \
> +	.opts = ((flen) | FIELD_PREP(GENMASK_ULL(63, 32), (__VA_ARGS__ + 0)))
> +#else
> +#define __libeth_xdp_tx_len(flen, ...)					      \
> +	.len = (flen), .flags = (__VA_ARGS__ + 0)
> +#endif
> +
> +/**
> + * libeth_xdp_tx_xmit_bulk - main XDP Tx function
> + * @bulk: array of frames to send
> + * @xdpsq: pointer to the driver-specific XDPSQ struct
> + * @n: number of frames to send
> + * @unroll: whether to unroll the queue filling loop for speed
> + * @priv: driver-specific private data
> + * @prep: callback for cleaning the queue and filling abstract &libeth_xdpsq
> + * @fill: internal callback for filling &libeth_sqe and &libeth_xdp_tx_desc
> + * @xmit: callback for filling a HW descriptor with the frame info
> + *
> + * Internal abstraction for placing @n XDP Tx frames on the HW XDPSQ. Used for
> + * all types of frames: ``XDP_TX`` and .ndo_xdp_xmit().
> + * @prep must lock the queue as this function releases it at the end. @unroll
> + * greatly increases the object code size, but also greatly increases
> + * performance.
> + * The compilers inline all those onstack abstractions to direct data accesses.
> + *
> + * Return: number of frames actually placed on the queue, <= @n. The function
> + * can't fail, but can send less frames if there's no enough free descriptors
> + * available. The actual free space is returned by @prep from the driver.
> + */
> +static __always_inline u32
> +libeth_xdp_tx_xmit_bulk(const struct libeth_xdp_tx_frame *bulk, void *xdpsq,
> +			u32 n, bool unroll, u64 priv,
> +			u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),
> +			struct libeth_xdp_tx_desc
> +			(*fill)(struct libeth_xdp_tx_frame frm, u32 i,
> +				const struct libeth_xdpsq *sq, u64 priv),
> +			void (*xmit)(struct libeth_xdp_tx_desc desc, u32 i,
> +				     const struct libeth_xdpsq *sq, u64 priv))
> +{
> +	u32 this, batched, off = 0;
> +	struct libeth_xdpsq sq;
> +	u32 ntu, i = 0;
> +
> +	n = min(n, prep(xdpsq, &sq));
> +	if (unlikely(!n))
> +		goto unlock;
> +
> +	ntu = *sq.ntu;
> +
> +	this = sq.count - ntu;
> +	if (likely(this > n))
> +		this = n;
> +
> +again:
> +	if (!unroll)
> +		goto linear;
> +
> +	batched = ALIGN_DOWN(this, LIBETH_XDP_TX_BATCH);
> +
> +	for ( ; i < off + batched; i += LIBETH_XDP_TX_BATCH) {
> +		u32 base = ntu + i - off;
> +
> +		unrolled_count(LIBETH_XDP_TX_BATCH)
> +		for (u32 j = 0; j < LIBETH_XDP_TX_BATCH; j++)
> +			xmit(fill(bulk[i + j], base + j, &sq, priv),
> +			     base + j, &sq, priv);
> +	}
> +
> +	if (batched < this) {
> +linear:
> +		for ( ; i < off + this; i++)
> +			xmit(fill(bulk[i], ntu + i - off, &sq, priv),
> +			     ntu + i - off, &sq, priv);
> +	}
> +
> +	ntu += this;
> +	if (likely(ntu < sq.count))
> +		goto out;
> +
> +	ntu = 0;
> +
> +	if (i < n) {
> +		this = n - i;
> +		off = i;
> +
> +		goto again;
> +	}
> +
> +out:
> +	*sq.ntu = ntu;
> +	*sq.pending += n;
> +	if (sq.xdp_tx)
> +		*sq.xdp_tx += n;
> +
> +unlock:
> +	libeth_xdpsq_unlock(sq.lock);
> +
> +	return n;
> +}
> +
> +/* ``XDP_TX`` bulking */
> +
> +void libeth_xdp_return_buff_slow(struct libeth_xdp_buff *xdp);
> +
> +/**
> + * libeth_xdp_tx_queue_head - internal helper for queueing one ``XDP_TX`` head
> + * @bq: XDP Tx bulk to queue the head frag to
> + * @xdp: XDP buffer with the head to queue
> + *
> + * Return: false if it's the only frag of the frame, true if it's an S/G frame.
> + */
> +static inline bool libeth_xdp_tx_queue_head(struct libeth_xdp_tx_bulk *bq,
> +					    const struct libeth_xdp_buff *xdp)
> +{
> +	const struct xdp_buff *base = &xdp->base;
> +
> +	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
> +		.data	= xdp->data,
> +		.len_fl	= (base->data_end - xdp->data) | LIBETH_XDP_TX_FIRST,
> +		.soff	= xdp_data_hard_end(base) - xdp->data,
> +	};
> +
> +	if (!xdp_buff_has_frags(base))

likely() ?

> +		return false;
> +
> +	bq->bulk[bq->count - 1].len_fl |= LIBETH_XDP_TX_MULTI;
> +
> +	return true;
> +}
> +
> +/**
> + * libeth_xdp_tx_queue_frag - internal helper for queueing one ``XDP_TX`` frag
> + * @bq: XDP Tx bulk to queue the frag to
> + * @frag: frag to queue
> + */
> +static inline void libeth_xdp_tx_queue_frag(struct libeth_xdp_tx_bulk *bq,
> +					    const skb_frag_t *frag)
> +{
> +	bq->bulk[bq->count++].frag = *frag;

IMHO this helper is not providing anything useful

> +}
> +
> +/**
> + * libeth_xdp_tx_queue_bulk - internal helper for queueing one ``XDP_TX`` frame
> + * @bq: XDP Tx bulk to queue the frame to
> + * @xdp: XDP buffer to queue
> + * @flush_bulk: driver callback to flush the bulk to the HW queue
> + *
> + * Return: true on success, false on flush error.
> + */
> +static __always_inline bool
> +libeth_xdp_tx_queue_bulk(struct libeth_xdp_tx_bulk *bq,
> +			 struct libeth_xdp_buff *xdp,
> +			 bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
> +					    u32 flags))
> +{
> +	const struct skb_shared_info *sinfo;
> +	bool ret = true;
> +	u32 nr_frags;
> +
> +	if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
> +	    unlikely(!flush_bulk(bq, 0))) {
> +		libeth_xdp_return_buff_slow(xdp);
> +		return false;
> +	}
> +
> +	if (!libeth_xdp_tx_queue_head(bq, xdp))
> +		goto out;
> +
> +	sinfo = xdp_get_shared_info_from_buff(&xdp->base);
> +	nr_frags = sinfo->nr_frags;
> +
> +	for (u32 i = 0; i < nr_frags; i++) {
> +		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
> +		    unlikely(!flush_bulk(bq, 0))) {
> +			ret = false;
> +			break;
> +		}
> +
> +		libeth_xdp_tx_queue_frag(bq, &sinfo->frags[i]);
> +	}
> +
> +out:
> +	bq->bulk[bq->count - 1].len_fl |= LIBETH_XDP_TX_LAST;
> +	xdp->data = NULL;
> +
> +	return ret;
> +}
> +
> +/**
> + * libeth_xdp_tx_fill_stats - fill &libeth_sqe with ``XDP_TX`` frame stats
> + * @sqe: SQ element to fill
> + * @desc: libeth_xdp Tx descriptor
> + * @sinfo: &skb_shared_info for this frame
> + *
> + * Internal helper for filling an SQE with the frame stats, do not use in
> + * drivers. Fills the number of frags and bytes for this frame.
> + */
> +#define libeth_xdp_tx_fill_stats(sqe, desc, sinfo)			      \
> +	__libeth_xdp_tx_fill_stats(sqe, desc, sinfo, __UNIQUE_ID(sqe_),	      \
> +				   __UNIQUE_ID(desc_), __UNIQUE_ID(sinfo_))
> +
> +#define __libeth_xdp_tx_fill_stats(sqe, desc, sinfo, ue, ud, us) do {	      \
> +	const struct libeth_xdp_tx_desc *ud = (desc);			      \
> +	const struct skb_shared_info *us;				      \
> +	struct libeth_sqe *ue = (sqe);					      \
> +									      \
> +	ue->nr_frags = 1;						      \
> +	ue->bytes = ud->len;						      \
> +									      \
> +	if (ud->flags & LIBETH_XDP_TX_MULTI) {				      \
> +		us = (sinfo);						      \

why? what 'u' stands for? ue us don't tell the reader much from the first
glance. sinfo tells me everything.

> +		ue->nr_frags += us->nr_frags;				      \
> +		ue->bytes += us->xdp_frags_size;			      \
> +	}								      \
> +} while (0)
> +
> +/**
> + * libeth_xdp_tx_fill_buf - internal helper to fill one ``XDP_TX`` &libeth_sqe
> + * @frm: XDP Tx frame from the bulk
> + * @i: index on the HW queue
> + * @sq: XDPSQ abstraction for the queue
> + * @priv: private data
> + *
> + * Return: XDP Tx descriptor with the synced DMA and other info to pass to
> + * the driver callback.
> + */
> +static inline struct libeth_xdp_tx_desc
> +libeth_xdp_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
> +		       const struct libeth_xdpsq *sq, u64 priv)
> +{
> +	struct libeth_xdp_tx_desc desc;
> +	struct skb_shared_info *sinfo;
> +	skb_frag_t *frag = &frm.frag;
> +	struct libeth_sqe *sqe;
> +	netmem_ref netmem;
> +
> +	if (frm.len_fl & LIBETH_XDP_TX_FIRST) {
> +		sinfo = frm.data + frm.soff;
> +		skb_frag_fill_netmem_desc(frag, virt_to_netmem(frm.data),
> +					  offset_in_page(frm.data),
> +					  frm.len_fl);
> +	} else {
> +		sinfo = NULL;
> +	}
> +
> +	netmem = skb_frag_netmem(frag);
> +	desc = (typeof(desc)){
> +		.addr	= page_pool_get_dma_addr_netmem(netmem) +
> +			  skb_frag_off(frag),
> +		.len	= skb_frag_size(frag) & LIBETH_XDP_TX_LEN,
> +		.flags	= skb_frag_size(frag) & LIBETH_XDP_TX_FLAGS,
> +	};
> +
> +	if (sinfo || !netmem_is_net_iov(netmem)) {
> +		const struct page_pool *pp = __netmem_get_pp(netmem);
> +
> +		dma_sync_single_for_device(pp->p.dev, desc.addr, desc.len,
> +					   DMA_BIDIRECTIONAL);
> +	}
> +
> +	if (!sinfo)
> +		return desc;
> +
> +	sqe = &sq->sqes[i];
> +	sqe->type = LIBETH_SQE_XDP_TX;
> +	sqe->sinfo = sinfo;
> +	libeth_xdp_tx_fill_stats(sqe, &desc, sinfo);
> +
> +	return desc;
> +}
> +
> +void libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
> +			     u32 flags);
> +
> +/**
> + * __libeth_xdp_tx_flush_bulk - internal helper to flush one XDP Tx bulk
> + * @bq: bulk to flush
> + * @flags: XDP TX flags (.ndo_xdp_xmit(), etc.)
> + * @prep: driver-specific callback to prepare the queue for sending
> + * @fill: libeth_xdp callback to fill &libeth_sqe and &libeth_xdp_tx_desc
> + * @xmit: driver callback to fill a HW descriptor
> + *
> + * Internal abstraction to create bulk flush functions for drivers.
> + *
> + * Return: true if anything was sent, false otherwise.
> + */
> +static __always_inline bool
> +__libeth_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags,
> +			   u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),
> +			   struct libeth_xdp_tx_desc
> +			   (*fill)(struct libeth_xdp_tx_frame frm, u32 i,
> +				   const struct libeth_xdpsq *sq, u64 priv),
> +			   void (*xmit)(struct libeth_xdp_tx_desc desc, u32 i,
> +					const struct libeth_xdpsq *sq,
> +					u64 priv))
> +{
> +	u32 sent, drops;
> +	int err = 0;
> +
> +	sent = libeth_xdp_tx_xmit_bulk(bq->bulk, bq->xdpsq,
> +				       min(bq->count, LIBETH_XDP_TX_BULK),
> +				       false, 0, prep, fill, xmit);
> +	drops = bq->count - sent;
> +
> +	if (unlikely(drops)) {
> +		libeth_xdp_tx_exception(bq, sent, flags);
> +		err = -ENXIO;
> +	} else {
> +		bq->count = 0;
> +	}
> +
> +	trace_xdp_bulk_tx(bq->dev, sent, drops, err);
> +
> +	return likely(sent);
> +}
> +
> +/**
> + * libeth_xdp_tx_flush_bulk - wrapper to define flush of one ``XDP_TX`` bulk
> + * @bq: bulk to flush
> + * @flags: Tx flags, see above
> + * @prep: driver callback to prepare the queue
> + * @xmit: driver callback to fill a HW descriptor
> + *
> + * Use via LIBETH_XDP_DEFINE_FLUSH_TX() to define an ``XDP_TX`` driver
> + * callback.
> + */
> +#define libeth_xdp_tx_flush_bulk(bq, flags, prep, xmit)			      \
> +	__libeth_xdp_tx_flush_bulk(bq, flags, prep, libeth_xdp_tx_fill_buf,   \
> +				   xmit)
> +
> +/* .ndo_xdp_xmit() implementation */
> +
> +/**
> + * libeth_xdp_xmit_init_bulk - internal helper to initialize bulk for XDP xmit
> + * @bq: bulk to initialize
> + * @dev: target &net_device
> + * @xdpsqs: array of driver-specific XDPSQ structs
> + * @num: number of active XDPSQs (the above array length)
> + */
> +#define libeth_xdp_xmit_init_bulk(bq, dev, xdpsqs, num)			      \
> +	__libeth_xdp_xmit_init_bulk(bq, dev, (xdpsqs)[libeth_xdpsq_id(num)])
> +
> +static inline void __libeth_xdp_xmit_init_bulk(struct libeth_xdp_tx_bulk *bq,
> +					       struct net_device *dev,
> +					       void *xdpsq)
> +{
> +	bq->dev = dev;
> +	bq->xdpsq = xdpsq;
> +	bq->count = 0;
> +}
> +
> +/**
> + * libeth_xdp_xmit_frame_dma - internal helper to access DMA of an &xdp_frame
> + * @xf: pointer to the XDP frame
> + *
> + * There's no place in &libeth_xdp_tx_frame to store DMA address for an
> + * &xdp_frame head. The headroom is used then, the address is placed right
> + * after the frame struct, naturally aligned.
> + *
> + * Return: pointer to the DMA address to use.
> + */
> +#define libeth_xdp_xmit_frame_dma(xf)					      \
> +	_Generic((xf),							      \
> +		 const struct xdp_frame *:				      \
> +			(const dma_addr_t *)__libeth_xdp_xmit_frame_dma(xf),  \
> +		 struct xdp_frame *:					      \
> +			(dma_addr_t *)__libeth_xdp_xmit_frame_dma(xf)	      \
> +	)
> +
> +static inline void *__libeth_xdp_xmit_frame_dma(const struct xdp_frame *xdpf)
> +{
> +	void *addr = (void *)(xdpf + 1);
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
> +	    __alignof(*xdpf) < sizeof(dma_addr_t))
> +		addr = PTR_ALIGN(addr, sizeof(dma_addr_t));
> +
> +	return addr;
> +}
> +
> +/**
> + * libeth_xdp_xmit_queue_head - internal helper for queueing one XDP xmit head
> + * @bq: XDP Tx bulk to queue the head frag to
> + * @xdpf: XDP frame with the head to queue
> + * @dev: device to perform DMA mapping
> + *
> + * Return: ``LIBETH_XDP_DROP`` on DMA mapping error,
> + *	   ``LIBETH_XDP_PASS`` if it's the only frag in the frame,
> + *	   ``LIBETH_XDP_TX`` if it's an S/G frame.
> + */
> +static inline u32 libeth_xdp_xmit_queue_head(struct libeth_xdp_tx_bulk *bq,
> +					     struct xdp_frame *xdpf,
> +					     struct device *dev)
> +{
> +	dma_addr_t dma;
> +
> +	dma = dma_map_single(dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
> +	if (dma_mapping_error(dev, dma))
> +		return LIBETH_XDP_DROP;
> +
> +	*libeth_xdp_xmit_frame_dma(xdpf) = dma;
> +
> +	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
> +		.xdpf	= xdpf,
> +		__libeth_xdp_tx_len(xdpf->len, LIBETH_XDP_TX_FIRST),
> +	};
> +
> +	if (!xdp_frame_has_frags(xdpf))
> +		return LIBETH_XDP_PASS;
> +
> +	bq->bulk[bq->count - 1].flags |= LIBETH_XDP_TX_MULTI;
> +
> +	return LIBETH_XDP_TX;
> +}
> +
> +/**
> + * libeth_xdp_xmit_queue_frag - internal helper for queueing one XDP xmit frag
> + * @bq: XDP Tx bulk to queue the frag to
> + * @frag: frag to queue
> + * @dev: device to perform DMA mapping
> + *
> + * Return: true on success, false on DMA mapping error.
> + */
> +static inline bool libeth_xdp_xmit_queue_frag(struct libeth_xdp_tx_bulk *bq,
> +					      const skb_frag_t *frag,
> +					      struct device *dev)
> +{
> +	dma_addr_t dma;
> +
> +	dma = skb_frag_dma_map(dev, frag);
> +	if (dma_mapping_error(dev, dma))
> +		return false;
> +
> +	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
> +		.dma	= dma,
> +		__libeth_xdp_tx_len(skb_frag_size(frag)),
> +	};
> +
> +	return true;
> +}
> +
> +/**
> + * libeth_xdp_xmit_queue_bulk - internal helper for queueing one XDP xmit frame
> + * @bq: XDP Tx bulk to queue the frame to
> + * @xdpf: XDP frame to queue
> + * @flush_bulk: driver callback to flush the bulk to the HW queue
> + *
> + * Return: ``LIBETH_XDP_TX`` on success,
> + *	   ``LIBETH_XDP_DROP`` if the frame should be dropped by the stack,
> + *	   ``LIBETH_XDP_ABORTED`` if the frame will be dropped by libeth_xdp.
> + */
> +static __always_inline u32
> +libeth_xdp_xmit_queue_bulk(struct libeth_xdp_tx_bulk *bq,
> +			   struct xdp_frame *xdpf,
> +			   bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
> +					      u32 flags))
> +{
> +	u32 head, nr_frags, i, ret = LIBETH_XDP_TX;
> +	struct device *dev = bq->dev->dev.parent;
> +	const struct skb_shared_info *sinfo;
> +
> +	if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
> +	    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_NDO)))
> +		return LIBETH_XDP_DROP;
> +
> +	head = libeth_xdp_xmit_queue_head(bq, xdpf, dev);
> +	if (head == LIBETH_XDP_PASS)
> +		goto out;
> +	else if (head == LIBETH_XDP_DROP)
> +		return LIBETH_XDP_DROP;
> +
> +	sinfo = xdp_get_shared_info_from_frame(xdpf);
> +	nr_frags = sinfo->nr_frags;
> +
> +	for (i = 0; i < nr_frags; i++) {
> +		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
> +		    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_NDO)))
> +			break;
> +
> +		if (!libeth_xdp_xmit_queue_frag(bq, &sinfo->frags[i], dev))
> +			break;
> +	}
> +
> +	if (unlikely(i < nr_frags))
> +		ret = LIBETH_XDP_ABORTED;
> +
> +out:
> +	bq->bulk[bq->count - 1].flags |= LIBETH_XDP_TX_LAST;
> +
> +	return ret;
> +}
> +
> +/**
> + * libeth_xdp_xmit_fill_buf - internal helper to fill one XDP xmit &libeth_sqe
> + * @frm: XDP Tx frame from the bulk
> + * @i: index on the HW queue
> + * @sq: XDPSQ abstraction for the queue
> + * @priv: private data
> + *
> + * Return: XDP Tx descriptor with the mapped DMA and other info to pass to
> + * the driver callback.
> + */
> +static inline struct libeth_xdp_tx_desc
> +libeth_xdp_xmit_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
> +			 const struct libeth_xdpsq *sq, u64 priv)
> +{
> +	struct libeth_xdp_tx_desc desc;
> +	struct libeth_sqe *sqe;
> +	struct xdp_frame *xdpf;
> +
> +	if (frm.flags & LIBETH_XDP_TX_FIRST) {
> +		xdpf = frm.xdpf;
> +		desc.addr = *libeth_xdp_xmit_frame_dma(xdpf);
> +	} else {
> +		xdpf = NULL;
> +		desc.addr = frm.dma;
> +	}
> +	desc.opts = frm.opts;
> +
> +	sqe = &sq->sqes[i];
> +	dma_unmap_addr_set(sqe, dma, desc.addr);
> +	dma_unmap_len_set(sqe, len, desc.len);
> +
> +	if (!xdpf) {
> +		sqe->type = LIBETH_SQE_XDP_XMIT_FRAG;
> +		return desc;
> +	}
> +
> +	sqe->type = LIBETH_SQE_XDP_XMIT;
> +	sqe->xdpf = xdpf;
> +	libeth_xdp_tx_fill_stats(sqe, &desc,
> +				 xdp_get_shared_info_from_frame(xdpf));
> +
> +	return desc;
> +}
> +
> +/**
> + * libeth_xdp_xmit_flush_bulk - wrapper to define flush of one XDP xmit bulk
> + * @bq: bulk to flush
> + * @flags: Tx flags, see __libeth_xdp_tx_flush_bulk()
> + * @prep: driver callback to prepare the queue
> + * @xmit: driver callback to fill a HW descriptor
> + *
> + * Use via LIBETH_XDP_DEFINE_FLUSH_XMIT() to define an XDP xmit driver
> + * callback.
> + */
> +#define libeth_xdp_xmit_flush_bulk(bq, flags, prep, xmit)		      \
> +	__libeth_xdp_tx_flush_bulk(bq, (flags) | LIBETH_XDP_TX_NDO, prep,     \
> +				   libeth_xdp_xmit_fill_buf, xmit)
> +
> +u32 libeth_xdp_xmit_return_bulk(const struct libeth_xdp_tx_frame *bq,
> +				u32 count, const struct net_device *dev);
> +
> +/**
> + * __libeth_xdp_xmit_do_bulk - internal function to implement .ndo_xdp_xmit()
> + * @bq: XDP Tx bulk to queue frames to
> + * @frames: XDP frames passed by the stack
> + * @n: number of frames
> + * @flags: flags passed by the stack
> + * @flush_bulk: driver callback to flush an XDP xmit bulk
> + * @finalize: driver callback to finalize sending XDP Tx frames on the queue
> + *
> + * Perform common checks, map the frags and queue them to the bulk, then flush
> + * the bulk to the XDPSQ. If requested by the stack, finalize the queue.
> + *
> + * Return: number of frames send or -errno on error.
> + */
> +static __always_inline int
> +__libeth_xdp_xmit_do_bulk(struct libeth_xdp_tx_bulk *bq,
> +			  struct xdp_frame **frames, u32 n, u32 flags,
> +			  bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
> +					     u32 flags),
> +			  void (*finalize)(void *xdpsq, bool sent, bool flush))
> +{
> +	u32 nxmit = 0;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	for (u32 i = 0; likely(i < n); i++) {
> +		u32 ret;
> +
> +		ret = libeth_xdp_xmit_queue_bulk(bq, frames[i], flush_bulk);
> +		if (unlikely(ret != LIBETH_XDP_TX)) {
> +			nxmit += ret == LIBETH_XDP_ABORTED;
> +			break;
> +		}
> +
> +		nxmit++;
> +	}
> +
> +	if (bq->count) {
> +		flush_bulk(bq, LIBETH_XDP_TX_NDO);
> +		if (unlikely(bq->count))
> +			nxmit -= libeth_xdp_xmit_return_bulk(bq->bulk,
> +							     bq->count,
> +							     bq->dev);
> +	}
> +
> +	finalize(bq->xdpsq, nxmit, flags & XDP_XMIT_FLUSH);
> +
> +	return nxmit;
> +}
> +
> +/**
> + * libeth_xdp_xmit_do_bulk - implement full .ndo_xdp_xmit() in driver
> + * @dev: target &net_device
> + * @n: number of frames to send
> + * @fr: XDP frames to send
> + * @f: flags passed by the stack
> + * @xqs: array of XDPSQs driver structs
> + * @nqs: number of active XDPSQs, the above array length
> + * @fl: driver callback to flush an XDP xmit bulk
> + * @fin: driver cabback to finalize the queue
> + *
> + * If the driver has active XDPSQs, perform common checks and send the frames.
> + * Finalize the queue, if requested.
> + *
> + * Return: number of frames sent or -errno on error.
> + */
> +#define libeth_xdp_xmit_do_bulk(dev, n, fr, f, xqs, nqs, fl, fin)	      \
> +	_libeth_xdp_xmit_do_bulk(dev, n, fr, f, xqs, nqs, fl, fin,	      \
> +				 __UNIQUE_ID(bq_), __UNIQUE_ID(ret_),	      \
> +				 __UNIQUE_ID(nqs_))

why __UNIQUE_ID() is needed?

> +
> +#define _libeth_xdp_xmit_do_bulk(d, n, fr, f, xqs, nqs, fl, fin, ub, ur, un)  \

why single underscore? usually we do __ for internal funcs as you did
somewhere above.

also, why define and not inlined func?

> +({									      \
> +	u32 un = (nqs);							      \
> +	int ur;								      \
> +									      \
> +	if (likely(un)) {						      \
> +		struct libeth_xdp_tx_bulk ub;				      \
> +									      \
> +		libeth_xdp_xmit_init_bulk(&ub, d, xqs, un);		      \
> +		ur = __libeth_xdp_xmit_do_bulk(&ub, fr, n, f, fl, fin);	      \
> +	} else {							      \
> +		ur = -ENXIO;						      \
> +	}								      \
> +									      \
> +	ur;								      \
> +})
> +
> +/* Rx polling path */
> +
> +/**
> + * libeth_xdp_tx_init_bulk - initialize an XDP Tx bulk for Rx NAPI poll
> + * @bq: bulk to initialize
> + * @prog: RCU pointer to the XDP program (can be %NULL)
> + * @dev: target &net_device
> + * @xdpsqs: array of driver XDPSQ structs
> + * @num: number of active XDPSQs, the above array length
> + *
> + * Should be called on an onstack XDP Tx bulk before the NAPI polling loop.
> + * Initializes all the needed fields to run libeth_xdp functions. If @num == 0,
> + * assumes XDP is not enabled.
> + */
> +#define libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num)		      \
> +	__libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num,		      \
> +				  __UNIQUE_ID(bq_), __UNIQUE_ID(nqs_))
> +
> +#define __libeth_xdp_tx_init_bulk(bq, pr, d, xdpsqs, num, ub, un) do {	      \
> +	typeof(bq) ub = (bq);						      \
> +	u32 un = (num);							      \
> +									      \
> +	rcu_read_lock();						      \
> +									      \
> +	if (un) {							      \
> +		ub->prog = rcu_dereference(pr);				      \
> +		ub->dev = (d);						      \
> +		ub->xdpsq = (xdpsqs)[libeth_xdpsq_id(un)];		      \
> +	} else {							      \
> +		ub->prog = NULL;					      \
> +	}								      \
> +									      \
> +	ub->act_mask = 0;						      \
> +	ub->count = 0;							      \
> +} while (0)
> +
> +void libeth_xdp_load_stash(struct libeth_xdp_buff *dst,
> +			   const struct libeth_xdp_buff_stash *src);
> +void libeth_xdp_save_stash(struct libeth_xdp_buff_stash *dst,
> +			   const struct libeth_xdp_buff *src);
> +void __libeth_xdp_return_stash(struct libeth_xdp_buff_stash *stash);
> +
> +/**
> + * libeth_xdp_init_buff - initialize a &libeth_xdp_buff for Rx NAPI poll
> + * @dst: onstack buffer to initialize
> + * @src: XDP buffer stash placed on the queue
> + * @rxq: registered &xdp_rxq_info corresponding to this queue
> + *
> + * Should be called before the main NAPI polling loop. Loads the content of
> + * the previously saved stash or initializes the buffer from scratch.
> + */
> +static inline void
> +libeth_xdp_init_buff(struct libeth_xdp_buff *dst,
> +		     const struct libeth_xdp_buff_stash *src,
> +		     struct xdp_rxq_info *rxq)

what is the rationale for storing/loading xdp_buff onto/from driver's Rx
queue? could we work directly on xdp_buff from Rx queue? ice is doing so
currently.

> +{
> +	if (likely(!src->data))
> +		dst->data = NULL;
> +	else
> +		libeth_xdp_load_stash(dst, src);
> +
> +	dst->base.rxq = rxq;
> +}
> +
> +/**
> + * libeth_xdp_save_buff - save a partially built buffer on a queue
> + * @dst: XDP buffer stash placed on the queue
> + * @src: onstack buffer to save
> + *
> + * Should be called after the main NAPI polling loop. If the loop exited before
> + * the buffer was finished, saves its content on the queue, so that it can be
> + * completed during the next poll. Otherwise, clears the stash.
> + */
> +static inline void libeth_xdp_save_buff(struct libeth_xdp_buff_stash *dst,
> +					const struct libeth_xdp_buff *src)
> +{
> +	if (likely(!src->data))
> +		dst->data = NULL;
> +	else
> +		libeth_xdp_save_stash(dst, src);
> +}
> +
> +/**
> + * libeth_xdp_return_stash - free an XDP buffer stash from a queue
> + * @stash: stash to free
> + *
> + * If the queue is about to be destroyed, but it still has an incompleted
> + * buffer stash, this helper should be called to free it.
> + */
> +static inline void libeth_xdp_return_stash(struct libeth_xdp_buff_stash *stash)
> +{
> +	if (stash->data)
> +		__libeth_xdp_return_stash(stash);
> +}
> +
> +static inline void libeth_xdp_return_va(const void *data, bool napi)
> +{
> +	netmem_ref netmem = virt_to_netmem(data);
> +
> +	page_pool_put_full_netmem(__netmem_get_pp(netmem), netmem, napi);
> +}
> +
> +static inline void libeth_xdp_return_frags(const struct skb_shared_info *sinfo,
> +					   bool napi)
> +{
> +	for (u32 i = 0; i < sinfo->nr_frags; i++) {
> +		netmem_ref netmem = skb_frag_netmem(&sinfo->frags[i]);
> +
> +		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, napi);
> +	}
> +}
> +
> +/**
> + * libeth_xdp_return_buff - free/recycle &libeth_xdp_buff
> + * @xdp: buffer to free
> + *
> + * Hotpath helper to free &libeth_xdp_buff. Comparing to xdp_return_buff(),
> + * it's faster as it gets inlined and always assumes order-0 pages and safe
> + * direct recycling. Zeroes @xdp->data to avoid UAFs.
> + */
> +#define libeth_xdp_return_buff(xdp)	__libeth_xdp_return_buff(xdp, true)
> +
> +static inline void __libeth_xdp_return_buff(struct libeth_xdp_buff *xdp,
> +					    bool napi)
> +{
> +	if (!xdp_buff_has_frags(&xdp->base))
> +		goto out;
> +
> +	libeth_xdp_return_frags(xdp_get_shared_info_from_buff(&xdp->base),
> +				napi);
> +
> +out:
> +	libeth_xdp_return_va(xdp->data, napi);
> +	xdp->data = NULL;
> +}
> +
> +bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
> +			      const struct libeth_fqe *fqe,
> +			      u32 len);
> +
> +/**
> + * libeth_xdp_prepare_buff - fill &libeth_xdp_buff with head FQE data
> + * @xdp: XDP buffer to attach the head to
> + * @fqe: FQE containing the head buffer
> + * @len: buffer len passed from HW
> + *
> + * Internal, use libeth_xdp_process_buff() instead. Initializes XDP buffer
> + * head with the Rx buffer data: data pointer, length, headroom, and
> + * truesize/tailroom. Zeroes the flags.
> + * Uses faster single u64 write instead of per-field access.
> + */
> +static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
> +					   const struct libeth_fqe *fqe,
> +					   u32 len)
> +{
> +	const struct page *page = __netmem_to_page(fqe->netmem);
> +
> +#ifdef __LIBETH_WORD_ACCESS
> +	static_assert(offsetofend(typeof(xdp->base), flags) -
> +		      offsetof(typeof(xdp->base), frame_sz) ==
> +		      sizeof(u64));
> +
> +	*(u64 *)&xdp->base.frame_sz = fqe->truesize;
> +#else
> +	xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
> +#endif
> +	xdp_prepare_buff(&xdp->base, page_address(page) + fqe->offset,
> +			 page->pp->p.offset, len, true);
> +}
> +
> +/**
> + * libeth_xdp_process_buff - attach Rx buffer to &libeth_xdp_buff
> + * @xdp: XDP buffer to attach the Rx buffer to
> + * @fqe: Rx buffer to process
> + * @len: received data length from the descriptor
> + *
> + * If the XDP buffer is empty, attaches the Rx buffer as head and initializes
> + * the required fields. Otherwise, attaches the buffer as a frag.
> + * Already performs DMA sync-for-CPU and frame start prefetch
> + * (for head buffers only).
> + *
> + * Return: true on success, false if the descriptor must be skipped (empty or
> + * no space for a new frag).
> + */
> +static inline bool libeth_xdp_process_buff(struct libeth_xdp_buff *xdp,
> +					   const struct libeth_fqe *fqe,
> +					   u32 len)
> +{
> +	if (!libeth_rx_sync_for_cpu(fqe, len))
> +		return false;
> +
> +	if (xdp->data)

unlikely() ?

> +		return libeth_xdp_buff_add_frag(xdp, fqe, len);
> +
> +	libeth_xdp_prepare_buff(xdp, fqe, len);
> +
> +	prefetch(xdp->data);
> +
> +	return true;
> +}
> +
> +/**
> + * libeth_xdp_buff_stats_frags - update onstack RQ stats with XDP frags info
> + * @ss: onstack stats to update
> + * @xdp: buffer to account
> + *
> + * Internal helper used by __libeth_xdp_run_pass(), do not call directly.
> + * Adds buffer's frags count and total len to the onstack stats.
> + */
> +static inline void
> +libeth_xdp_buff_stats_frags(struct libeth_rq_napi_stats *ss,
> +			    const struct libeth_xdp_buff *xdp)
> +{
> +	const struct skb_shared_info *sinfo;
> +
> +	sinfo = xdp_get_shared_info_from_buff(&xdp->base);
> +	ss->bytes += sinfo->xdp_frags_size;
> +	ss->fragments += sinfo->nr_frags + 1;
> +}
> +
> +u32 libeth_xdp_prog_exception(const struct libeth_xdp_tx_bulk *bq,
> +			      struct libeth_xdp_buff *xdp,
> +			      enum xdp_action act, int ret);
> +
> +/**
> + * __libeth_xdp_run_prog - run XDP program on an XDP buffer
> + * @xdp: XDP buffer to run the prog on
> + * @bq: buffer bulk for ``XDP_TX`` queueing
> + *
> + * Internal inline abstraction to run XDP program. Handles ``XDP_DROP``
> + * and ``XDP_REDIRECT`` only, the rest is processed levels up.
> + * Reports an XDP prog exception on errors.
> + *
> + * Return: libeth_xdp prog verdict depending on the prog's verdict.
> + */
> +static __always_inline u32
> +__libeth_xdp_run_prog(struct libeth_xdp_buff *xdp,
> +		      const struct libeth_xdp_tx_bulk *bq)
> +{
> +	enum xdp_action act;
> +
> +	act = bpf_prog_run_xdp(bq->prog, &xdp->base);
> +	if (unlikely(act < XDP_DROP || act > XDP_REDIRECT))
> +		goto out;
> +
> +	switch (act) {
> +	case XDP_PASS:
> +		return LIBETH_XDP_PASS;
> +	case XDP_DROP:
> +		libeth_xdp_return_buff(xdp);
> +
> +		return LIBETH_XDP_DROP;
> +	case XDP_TX:
> +		return LIBETH_XDP_TX;
> +	case XDP_REDIRECT:
> +		if (unlikely(xdp_do_redirect(bq->dev, &xdp->base, bq->prog)))
> +			break;
> +
> +		xdp->data = NULL;
> +
> +		return LIBETH_XDP_REDIRECT;
> +	default:
> +		break;
> +	}
> +
> +out:
> +	return libeth_xdp_prog_exception(bq, xdp, act, 0);
> +}
> +
> +/**
> + * __libeth_xdp_run_flush - run XDP program and handle ``XDP_TX`` verdict
> + * @xdp: XDP buffer to run the prog on
> + * @bq: buffer bulk for ``XDP_TX`` queueing
> + * @run: internal callback for running XDP program
> + * @queue: internal callback for queuing ``XDP_TX`` frame
> + * @flush_bulk: driver callback for flushing a bulk
> + *
> + * Internal inline abstraction to run XDP program and additionally handle
> + * ``XDP_TX`` verdict.
> + * Do not use directly.
> + *
> + * Return: libeth_xdp prog verdict depending on the prog's verdict.
> + */
> +static __always_inline u32
> +__libeth_xdp_run_flush(struct libeth_xdp_buff *xdp,
> +		       struct libeth_xdp_tx_bulk *bq,
> +		       u32 (*run)(struct libeth_xdp_buff *xdp,
> +				  const struct libeth_xdp_tx_bulk *bq),
> +		       bool (*queue)(struct libeth_xdp_tx_bulk *bq,
> +				     struct libeth_xdp_buff *xdp,
> +				     bool (*flush_bulk)
> +					  (struct libeth_xdp_tx_bulk *bq,
> +					   u32 flags)),
> +		       bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
> +					  u32 flags))
> +{
> +	u32 act;
> +
> +	act = run(xdp, bq);
> +	if (act == LIBETH_XDP_TX && unlikely(!queue(bq, xdp, flush_bulk)))
> +		act = LIBETH_XDP_DROP;
> +
> +	bq->act_mask |= act;
> +
> +	return act;
> +}
> +
> +/**
> + * libeth_xdp_run_prog - run XDP program and handle all verdicts
> + * @xdp: XDP buffer to process
> + * @bq: XDP Tx bulk to queue ``XDP_TX`` buffers
> + * @fl: driver ``XDP_TX`` bulk flush callback
> + *
> + * Run the attached XDP program and handle all possible verdicts.
> + * Prefer using it via LIBETH_XDP_DEFINE_RUN{,_PASS,_PROG}().
> + *
> + * Return: true if the buffer should be passed up the stack, false if the poll
> + * should go to the next buffer.
> + */
> +#define libeth_xdp_run_prog(xdp, bq, fl)				      \

is this used in idpf in this patchset?

> +	(__libeth_xdp_run_flush(xdp, bq, __libeth_xdp_run_prog,		      \
> +				libeth_xdp_tx_queue_bulk,		      \
> +				fl) == LIBETH_XDP_PASS)
> +
> +/**
> + * __libeth_xdp_run_pass - helper to run XDP program and handle the result
> + * @xdp: XDP buffer to process
> + * @bq: XDP Tx bulk to queue ``XDP_TX`` frames
> + * @napi: NAPI to build an skb and pass it up the stack
> + * @rs: onstack libeth RQ stats
> + * @md: metadata that should be filled to the XDP buffer
> + * @prep: callback for filling the metadata
> + * @run: driver wrapper to run XDP program

I see it's NULLed on idpf? why have this?

> + * @populate: driver callback to populate an skb with the HW descriptor data
> + *
> + * Inline abstraction that does the following:
> + * 1) adds frame size and frag number (if needed) to the onstack stats;
> + * 2) fills the descriptor metadata to the onstack &libeth_xdp_buff
> + * 3) runs XDP program if present;
> + * 4) handles all possible verdicts;
> + * 5) on ``XDP_PASS`, builds an skb from the buffer;
> + * 6) populates it with the descriptor metadata;
> + * 7) passes it up the stack.
> + *
> + * In most cases, number 2 means just writing the pointer to the HW descriptor
> + * to the XDP buffer. If so, please use LIBETH_XDP_DEFINE_RUN{,_PASS}()
> + * wrappers to build a driver function.
> + */
> +static __always_inline void
> +__libeth_xdp_run_pass(struct libeth_xdp_buff *xdp,
> +		      struct libeth_xdp_tx_bulk *bq, struct napi_struct *napi,
> +		      struct libeth_rq_napi_stats *rs, const void *md,
> +		      void (*prep)(struct libeth_xdp_buff *xdp,
> +				   const void *md),
> +		      bool (*run)(struct libeth_xdp_buff *xdp,
> +				  struct libeth_xdp_tx_bulk *bq),
> +		      bool (*populate)(struct sk_buff *skb,
> +				       const struct libeth_xdp_buff *xdp,
> +				       struct libeth_rq_napi_stats *rs))
> +{
> +	struct sk_buff *skb;
> +
> +	rs->bytes += xdp->base.data_end - xdp->data;
> +	rs->packets++;
> +
> +	if (xdp_buff_has_frags(&xdp->base))
> +		libeth_xdp_buff_stats_frags(rs, xdp);
> +
> +	if (prep && (!__builtin_constant_p(!!md) || md))
> +		prep(xdp, md);
> +
> +	if (!bq || !run || !bq->prog)
> +		goto build;
> +
> +	if (!run(xdp, bq))
> +		return;
> +
> +build:
> +	skb = xdp_build_skb_from_buff(&xdp->base);
> +	if (unlikely(!skb)) {
> +		libeth_xdp_return_buff_slow(xdp);
> +		return;
> +	}
> +
> +	xdp->data = NULL;
> +
> +	if (unlikely(!populate(skb, xdp, rs))) {
> +		napi_consume_skb(skb, true);
> +		return;
> +	}
> +
> +	napi_gro_receive(napi, skb);
> +}
> +
> +static inline void libeth_xdp_prep_desc(struct libeth_xdp_buff *xdp,
> +					const void *desc)
> +{
> +	xdp->desc = desc;
> +}
> +
> +/**
> + * libeth_xdp_run_pass - helper to run XDP program and handle the result
> + * @xdp: XDP buffer to process
> + * @bq: XDP Tx bulk to queue ``XDP_TX`` frames
> + * @napi: NAPI to build an skb and pass it up the stack
> + * @ss: onstack libeth RQ stats
> + * @desc: pointer to the HW descriptor for that frame
> + * @run: driver wrapper to run XDP program
> + * @populate: driver callback to populate an skb with the HW descriptor data
> + *
> + * Wrapper around the underscored version when "fill the descriptor metadata"
> + * means just writing the pointer to the HW descriptor as @xdp->desc.
> + */
> +#define libeth_xdp_run_pass(xdp, bq, napi, ss, desc, run, populate)	      \
> +	__libeth_xdp_run_pass(xdp, bq, napi, ss, desc, libeth_xdp_prep_desc,  \
> +			      run, populate)
> +
> +/**
> + * libeth_xdp_finalize_rx - finalize XDPSQ after a NAPI polling loop
> + * @bq: ``XDP_TX`` frame bulk
> + * @flush: driver callback to flush the bulk
> + * @finalize: driver callback to start sending the frames and run the timer
> + *
> + * Flush the bulk if there are frames left to send, kick the queue and flush
> + * the XDP maps.
> + */
> +#define libeth_xdp_finalize_rx(bq, flush, finalize)			      \
> +	__libeth_xdp_finalize_rx(bq, 0, flush, finalize)
> +
> +static __always_inline void
> +__libeth_xdp_finalize_rx(struct libeth_xdp_tx_bulk *bq, u32 flags,
> +			 bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
> +					    u32 flags),
> +			 void (*finalize)(void *xdpsq, bool sent, bool flush))
> +{
> +	if (bq->act_mask & LIBETH_XDP_TX) {
> +		if (bq->count)
> +			flush_bulk(bq, flags | LIBETH_XDP_TX_DROP);
> +		finalize(bq->xdpsq, true, true);
> +	}
> +	if (bq->act_mask & LIBETH_XDP_REDIRECT)
> +		xdp_do_flush();
> +
> +	rcu_read_unlock();
> +}

(...)

> +
> +/* XMO */
> +
> +/**
> + * libeth_xdp_buff_to_rq - get RQ pointer from an XDP buffer pointer
> + * @xdp: &libeth_xdp_buff corresponding to the queue
> + * @type: typeof() of the driver Rx queue structure
> + * @member: name of &xdp_rxq_info inside @type
> + *
> + * Often times, pointer to the RQ is needed when reading/filling metadata from
> + * HW descriptors. The helper can be used to quickly jump from an XDP buffer
> + * to the queue corresponding to its &xdp_rxq_info without introducing
> + * additional fields (&libeth_xdp_buff is precisely 1 cacheline long on x64).
> + */
> +#define libeth_xdp_buff_to_rq(xdp, type, member)			      \
> +	container_of_const((xdp)->base.rxq, type, member)
> +
> +/**
> + * libeth_xdpmo_rx_hash - convert &libeth_rx_pt to an XDP RSS hash metadata
> + * @hash: pointer to the variable to write the hash to
> + * @rss_type: pointer to the variable to write the hash type to
> + * @val: hash value from the HW descriptor
> + * @pt: libeth parsed packet type
> + *
> + * Handle zeroed/non-available hash and convert libeth parsed packet type to
> + * the corresponding XDP RSS hash type. To be called at the end of
> + * xdp_metadata_ops idpf_xdpmo::xmo_rx_hash() implementation.
> + * Note that if the driver doesn't use a constant packet type lookup table but
> + * generates it at runtime, it must call libeth_rx_pt_gen_hash_type(pt) to
> + * generate XDP RSS hash type for each packet type.
> + *
> + * Return: 0 on success, -ENODATA when the hash is not available.
> + */
> +static inline int libeth_xdpmo_rx_hash(u32 *hash,
> +				       enum xdp_rss_hash_type *rss_type,
> +				       u32 val, struct libeth_rx_pt pt)
> +{
> +	if (unlikely(!val))
> +		return -ENODATA;
> +
> +	*hash = val;
> +	*rss_type = pt.hash_type;
> +
> +	return 0;
> +}
> +
> +/* Tx buffer completion */
> +
> +void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
> +				 struct xdp_frame_bulk *bq, bool frags);
> +
> +/**
> + * __libeth_xdp_complete_tx - complete sent XDPSQE
> + * @sqe: SQ element / Tx buffer to complete
> + * @cp: Tx polling/completion params
> + * @bulk: internal callback to bulk-free ``XDP_TX`` buffers
> + *
> + * Use the non-underscored version in drivers instead. This one is shared
> + * internally with libeth_tx_complete_any().
> + * Complete an XDPSQE of any type of XDP frame. This includes DMA unmapping
> + * when needed, buffer freeing, stats update, and SQE invalidating.
> + */
> +static __always_inline void
> +__libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
> +			 typeof(libeth_xdp_return_buff_bulk) bulk)
> +{
> +	enum libeth_sqe_type type = sqe->type;
> +
> +	switch (type) {
> +	case LIBETH_SQE_EMPTY:
> +		return;
> +	case LIBETH_SQE_XDP_XMIT:
> +	case LIBETH_SQE_XDP_XMIT_FRAG:
> +		dma_unmap_page(cp->dev, dma_unmap_addr(sqe, dma),
> +			       dma_unmap_len(sqe, len), DMA_TO_DEVICE);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (type) {
> +	case LIBETH_SQE_XDP_TX:
> +		bulk(sqe->sinfo, cp->bq, sqe->nr_frags != 1);
> +		break;
> +	case LIBETH_SQE_XDP_XMIT:
> +		xdp_return_frame_bulk(sqe->xdpf, cp->bq);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (type) {
> +	case LIBETH_SQE_XDP_TX:
> +	case LIBETH_SQE_XDP_XMIT:
> +		cp->xdp_tx -= sqe->nr_frags;
> +
> +		cp->xss->packets++;
> +		cp->xss->bytes += sqe->bytes;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	sqe->type = LIBETH_SQE_EMPTY;
> +}
> +
> +static inline void libeth_xdp_complete_tx(struct libeth_sqe *sqe,
> +					  struct libeth_cq_pp *cp)
> +{
> +	__libeth_xdp_complete_tx(sqe, cp, libeth_xdp_return_buff_bulk);
> +}
> +
> +/* Misc */
> +
> +u32 libeth_xdp_queue_threshold(u32 count);
> +
> +void __libeth_xdp_set_features(struct net_device *dev,
> +			       const struct xdp_metadata_ops *xmo);
> +void libeth_xdp_set_redirect(struct net_device *dev, bool enable);
> +
> +/**
> + * libeth_xdp_set_features - set XDP features for netdev
> + * @dev: &net_device to configure
> + * @...: optional params, see __libeth_xdp_set_features()
> + *
> + * Set all the features libeth_xdp supports, including .ndo_xdp_xmit(). That
> + * said, it should be used only when XDPSQs are always available regardless
> + * of whether an XDP prog is attached to @dev.
> + */
> +#define libeth_xdp_set_features(dev, ...)				      \
> +	CONCATENATE(__libeth_xdp_feat,					      \
> +		    COUNT_ARGS(__VA_ARGS__))(dev, ##__VA_ARGS__)
> +
> +#define __libeth_xdp_feat0(dev)						      \
> +	__libeth_xdp_set_features(dev, NULL)
> +#define __libeth_xdp_feat1(dev, xmo)					      \
> +	__libeth_xdp_set_features(dev, xmo)
> +
> +/**
> + * libeth_xdp_set_features_noredir - enable all libeth_xdp features w/o redir
> + * @dev: target &net_device
> + * @...: optional params, see __libeth_xdp_set_features()
> + *
> + * Enable everything except the .ndo_xdp_xmit() feature, use when XDPSQs are
> + * not available right after netdev registration.
> + */
> +#define libeth_xdp_set_features_noredir(dev, ...)			      \
> +	__libeth_xdp_set_features_noredir(dev, __UNIQUE_ID(dev_),	      \
> +					  ##__VA_ARGS__)
> +
> +#define __libeth_xdp_set_features_noredir(dev, ud, ...) do {		      \
> +	struct net_device *ud = (dev);					      \
> +									      \
> +	libeth_xdp_set_features(ud, ##__VA_ARGS__);			      \
> +	libeth_xdp_set_redirect(ud, false);				      \
> +} while (0)
> +
> +#endif /* __LIBETH_XDP_H */
> diff --git a/drivers/net/ethernet/intel/libeth/tx.c b/drivers/net/ethernet/intel/libeth/tx.c
> new file mode 100644
> index 000000000000..227c841ab16a
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/libeth/tx.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#define DEFAULT_SYMBOL_NAMESPACE	"LIBETH"
> +
> +#include <net/libeth/xdp.h>
> +
> +#include "priv.h"
> +
> +/* Tx buffer completion */
> +
> +DEFINE_STATIC_CALL_NULL(bulk, libeth_xdp_return_buff_bulk);
> +
> +/**
> + * libeth_tx_complete_any - perform Tx completion for one SQE of any type
> + * @sqe: Tx buffer to complete
> + * @cp: polling params
> + *
> + * Can be used to complete both regular and XDP SQEs, for example when
> + * destroying queues.
> + * When libeth_xdp is not loaded, XDPSQEs won't be handled.
> + */
> +void libeth_tx_complete_any(struct libeth_sqe *sqe, struct libeth_cq_pp *cp)
> +{
> +	if (sqe->type >= __LIBETH_SQE_XDP_START)
> +		__libeth_xdp_complete_tx(sqe, cp, static_call(bulk));
> +	else
> +		libeth_tx_complete(sqe, cp);
> +}
> +EXPORT_SYMBOL_GPL(libeth_tx_complete_any);
> +
> +/* Module */
> +
> +void libeth_attach_xdp(const struct libeth_xdp_ops *ops)
> +{
> +	static_call_update(bulk, ops ? ops->bulk : NULL);
> +}
> +EXPORT_SYMBOL_GPL(libeth_attach_xdp);
> diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
> new file mode 100644
> index 000000000000..dbede9a696a7
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/libeth/xdp.c
> @@ -0,0 +1,431 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#define DEFAULT_SYMBOL_NAMESPACE	"LIBETH_XDP"
> +
> +#include <net/libeth/xdp.h>
> +
> +#include "priv.h"
> +
> +/* XDPSQ sharing */
> +
> +DEFINE_STATIC_KEY_FALSE(libeth_xdpsq_share);
> +EXPORT_SYMBOL_GPL(libeth_xdpsq_share);
> +
> +void __libeth_xdpsq_get(struct libeth_xdpsq_lock *lock,
> +			const struct net_device *dev)
> +{
> +	bool warn;
> +
> +	spin_lock_init(&lock->lock);
> +	lock->share = true;
> +
> +	warn = !static_key_enabled(&libeth_xdpsq_share);
> +	static_branch_inc(&libeth_xdpsq_share);
> +
> +	if (warn && net_ratelimit())
> +		netdev_warn(dev, "XDPSQ sharing enabled, possible XDP Tx slowdown\n");
> +}
> +EXPORT_SYMBOL_GPL(__libeth_xdpsq_get);
> +
> +void __libeth_xdpsq_put(struct libeth_xdpsq_lock *lock,
> +			const struct net_device *dev)
> +{
> +	static_branch_dec(&libeth_xdpsq_share);
> +
> +	if (!static_key_enabled(&libeth_xdpsq_share) && net_ratelimit())
> +		netdev_notice(dev, "XDPSQ sharing disabled\n");
> +
> +	lock->share = false;
> +}
> +EXPORT_SYMBOL_GPL(__libeth_xdpsq_put);
> +
> +void __acquires(&lock->lock)
> +__libeth_xdpsq_lock(struct libeth_xdpsq_lock *lock)
> +{
> +	spin_lock(&lock->lock);
> +}
> +EXPORT_SYMBOL_GPL(__libeth_xdpsq_lock);
> +
> +void __releases(&lock->lock)
> +__libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock)
> +{
> +	spin_unlock(&lock->lock);
> +}
> +EXPORT_SYMBOL_GPL(__libeth_xdpsq_unlock);
> +
> +/* XDPSQ clean-up timers */
> +
> +/**
> + * libeth_xdpsq_init_timer - initialize an XDPSQ clean-up timer
> + * @timer: timer to initialize
> + * @xdpsq: queue this timer belongs to
> + * @lock: corresponding XDPSQ lock
> + * @poll: queue polling/completion function
> + *
> + * XDPSQ clean-up timers must be set up before using at the queue configuration
> + * time. Set the required pointers and the cleaning callback.
> + */
> +void libeth_xdpsq_init_timer(struct libeth_xdpsq_timer *timer, void *xdpsq,
> +			     struct libeth_xdpsq_lock *lock,
> +			     void (*poll)(struct work_struct *work))
> +{
> +	timer->xdpsq = xdpsq;
> +	timer->lock = lock;
> +
> +	INIT_DELAYED_WORK(&timer->dwork, poll);
> +}
> +EXPORT_SYMBOL_GPL(libeth_xdpsq_init_timer);
> +
> +/* ``XDP_TX`` bulking */
> +
> +static void __cold
> +libeth_xdp_tx_return_one(const struct libeth_xdp_tx_frame *frm)
> +{
> +	if (frm->len_fl & LIBETH_XDP_TX_MULTI)
> +		libeth_xdp_return_frags(frm->data + frm->soff, true);
> +
> +	libeth_xdp_return_va(frm->data, true);
> +}
> +
> +static void __cold
> +libeth_xdp_tx_return_bulk(const struct libeth_xdp_tx_frame *bq, u32 count)
> +{
> +	for (u32 i = 0; i < count; i++) {
> +		const struct libeth_xdp_tx_frame *frm = &bq[i];
> +
> +		if (!(frm->len_fl & LIBETH_XDP_TX_FIRST))
> +			continue;
> +
> +		libeth_xdp_tx_return_one(frm);
> +	}
> +}
> +
> +static void __cold libeth_trace_xdp_exception(const struct net_device *dev,
> +					      const struct bpf_prog *prog,
> +					      u32 act)
> +{
> +	trace_xdp_exception(dev, prog, act);
> +}
> +
> +/**
> + * libeth_xdp_tx_exception - handle Tx exceptions of XDP frames
> + * @bq: XDP Tx frame bulk
> + * @sent: number of frames sent successfully (from this bulk)
> + * @flags: internal libeth_xdp flags (.ndo_xdp_xmit etc.)
> + *
> + * Cold helper used by __libeth_xdp_tx_flush_bulk(), do not call directly.
> + * Reports XDP Tx exceptions, frees the frames that won't be sent or adjust
> + * the Tx bulk to try again later.
> + */
> +void __cold libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
> +				    u32 flags)
> +{
> +	const struct libeth_xdp_tx_frame *pos = &bq->bulk[sent];
> +	u32 left = bq->count - sent;
> +
> +	if (!(flags & LIBETH_XDP_TX_NDO))
> +		libeth_trace_xdp_exception(bq->dev, bq->prog, XDP_TX);
> +
> +	if (!(flags & LIBETH_XDP_TX_DROP)) {
> +		memmove(bq->bulk, pos, left * sizeof(*bq->bulk));

can this overflow? if queue got stuck for some reason.

> +		bq->count = left;
> +
> +		return;
> +	}
> +
> +	if (!(flags & LIBETH_XDP_TX_NDO))
> +		libeth_xdp_tx_return_bulk(pos, left);
> +	else
> +		libeth_xdp_xmit_return_bulk(pos, left, bq->dev);
> +
> +	bq->count = 0;
> +}
> +EXPORT_SYMBOL_GPL(libeth_xdp_tx_exception);
> +
> +/* .ndo_xdp_xmit() implementation */
> +
> +u32 __cold libeth_xdp_xmit_return_bulk(const struct libeth_xdp_tx_frame *bq,
> +				       u32 count, const struct net_device *dev)
> +{
> +	u32 n = 0;
> +
> +	for (u32 i = 0; i < count; i++) {
> +		const struct libeth_xdp_tx_frame *frm = &bq[i];
> +		dma_addr_t dma;
> +
> +		if (frm->flags & LIBETH_XDP_TX_FIRST)
> +			dma = *libeth_xdp_xmit_frame_dma(frm->xdpf);
> +		else
> +			dma = dma_unmap_addr(frm, dma);
> +
> +		dma_unmap_page(dev->dev.parent, dma, dma_unmap_len(frm, len),
> +			       DMA_TO_DEVICE);
> +
> +		/* Actual xdp_frames are freed by the core */
> +		n += !!(frm->flags & LIBETH_XDP_TX_FIRST);
> +	}
> +
> +	return n;
> +}
> +EXPORT_SYMBOL_GPL(libeth_xdp_xmit_return_bulk);
> +
> +/* Rx polling path */
> +
> +/**
> + * libeth_xdp_load_stash - recreate an &xdp_buff from libeth_xdp buffer stash
> + * @dst: target &libeth_xdp_buff to initialize
> + * @src: source stash
> + *
> + * External helper used by libeth_xdp_init_buff(), do not call directly.
> + * Recreate an onstack &libeth_xdp_buff using the stash saved earlier.
> + * The only field untouched (rxq) is initialized later in the
> + * abovementioned function.
> + */
> +void libeth_xdp_load_stash(struct libeth_xdp_buff *dst,
> +			   const struct libeth_xdp_buff_stash *src)
> +{
> +	dst->data = src->data;
> +	dst->base.data_end = src->data + src->len;
> +	dst->base.data_meta = src->data;
> +	dst->base.data_hard_start = src->data - src->headroom;
> +
> +	dst->base.frame_sz = src->frame_sz;
> +	dst->base.flags = src->flags;
> +}
> +EXPORT_SYMBOL_GPL(libeth_xdp_load_stash);
> +
> +/**
> + * libeth_xdp_save_stash - convert &xdp_buff to a libeth_xdp buffer stash
> + * @dst: target &libeth_xdp_buff_stash to initialize
> + * @src: source XDP buffer
> + *
> + * External helper used by libeth_xdp_save_buff(), do not call directly.
> + * Use the fields from the passed XDP buffer to initialize the stash on the
> + * queue, so that a partially received frame can be finished later during
> + * the next NAPI poll.
> + */
> +void libeth_xdp_save_stash(struct libeth_xdp_buff_stash *dst,
> +			   const struct libeth_xdp_buff *src)
> +{
> +	dst->data = src->data;
> +	dst->headroom = src->data - src->base.data_hard_start;
> +	dst->len = src->base.data_end - src->data;
> +
> +	dst->frame_sz = src->base.frame_sz;
> +	dst->flags = src->base.flags;
> +
> +	WARN_ON_ONCE(dst->flags != src->base.flags);
> +}
> +EXPORT_SYMBOL_GPL(libeth_xdp_save_stash);
> +
> +void __libeth_xdp_return_stash(struct libeth_xdp_buff_stash *stash)
> +{
> +	LIBETH_XDP_ONSTACK_BUFF(xdp);
> +
> +	libeth_xdp_load_stash(xdp, stash);
> +	libeth_xdp_return_buff_slow(xdp);
> +
> +	stash->data = NULL;
> +}
> +EXPORT_SYMBOL_GPL(__libeth_xdp_return_stash);
> +
> +/**
> + * libeth_xdp_return_buff_slow - free &libeth_xdp_buff
> + * @xdp: buffer to free/return
> + *
> + * Slowpath version of libeth_xdp_return_buff() to be called on exceptions,
> + * queue clean-ups etc., without unwanted inlining.
> + */
> +void __cold libeth_xdp_return_buff_slow(struct libeth_xdp_buff *xdp)
> +{
> +	__libeth_xdp_return_buff(xdp, false);
> +}
> +EXPORT_SYMBOL_GPL(libeth_xdp_return_buff_slow);
> +
> +/**
> + * libeth_xdp_buff_add_frag - add frag to XDP buffer
> + * @xdp: head XDP buffer
> + * @fqe: Rx buffer containing the frag
> + * @len: frag length reported by HW
> + *
> + * External helper used by libeth_xdp_process_buff(), do not call directly.
> + * Frees both head and frag buffers on error.
> + *
> + * Return: true success, false on error (no space for a new frag).
> + */
> +bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
> +			      const struct libeth_fqe *fqe,
> +			      u32 len)
> +{
> +	netmem_ref netmem = fqe->netmem;
> +
> +	if (!xdp_buff_add_frag(&xdp->base, netmem,
> +			       fqe->offset + netmem_get_pp(netmem)->p.offset,
> +			       len, fqe->truesize))
> +		goto recycle;
> +
> +	return true;
> +
> +recycle:
> +	libeth_rx_recycle_slow(netmem);
> +	libeth_xdp_return_buff_slow(xdp);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(libeth_xdp_buff_add_frag);
> +
> +/**
> + * libeth_xdp_prog_exception - handle XDP prog exceptions
> + * @bq: XDP Tx bulk
> + * @xdp: buffer to process
> + * @act: original XDP prog verdict
> + * @ret: error code if redirect failed
> + *
> + * External helper used by __libeth_xdp_run_prog(), do not call directly.
> + * Reports invalid @act, XDP exception trace event and frees the buffer.
> + *
> + * Return: libeth_xdp XDP prog verdict.
> + */
> +u32 __cold libeth_xdp_prog_exception(const struct libeth_xdp_tx_bulk *bq,
> +				     struct libeth_xdp_buff *xdp,
> +				     enum xdp_action act, int ret)
> +{
> +	if (act > XDP_REDIRECT)
> +		bpf_warn_invalid_xdp_action(bq->dev, bq->prog, act);
> +
> +	libeth_trace_xdp_exception(bq->dev, bq->prog, act);
> +	libeth_xdp_return_buff_slow(xdp);
> +
> +	return LIBETH_XDP_DROP;
> +}
> +EXPORT_SYMBOL_GPL(libeth_xdp_prog_exception);
> +
> +/* Tx buffer completion */
> +
> +static void libeth_xdp_put_netmem_bulk(netmem_ref netmem,
> +				       struct xdp_frame_bulk *bq)
> +{
> +	if (unlikely(bq->count == XDP_BULK_QUEUE_SIZE))
> +		xdp_flush_frame_bulk(bq);
> +
> +	bq->q[bq->count++] = netmem;
> +}
> +
> +/**
> + * libeth_xdp_return_buff_bulk - free &xdp_buff as part of a bulk
> + * @sinfo: shared info corresponding to the buffer
> + * @bq: XDP frame bulk to store the buffer
> + * @frags: whether the buffer has frags
> + *
> + * Same as xdp_return_frame_bulk(), but for &libeth_xdp_buff, speeds up Tx
> + * completion of ``XDP_TX`` buffers and allows to free them in same bulks
> + * with &xdp_frame buffers.
> + */
> +void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
> +				 struct xdp_frame_bulk *bq, bool frags)
> +{
> +	if (!frags)
> +		goto head;
> +
> +	for (u32 i = 0; i < sinfo->nr_frags; i++)
> +		libeth_xdp_put_netmem_bulk(skb_frag_netmem(&sinfo->frags[i]),
> +					   bq);
> +
> +head:
> +	libeth_xdp_put_netmem_bulk(virt_to_netmem(sinfo), bq);
> +}
> +EXPORT_SYMBOL_GPL(libeth_xdp_return_buff_bulk);

(...)

