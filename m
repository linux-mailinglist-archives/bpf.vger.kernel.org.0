Return-Path: <bpf+bounces-47078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8CA9F3FFC
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 02:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E370162EA3
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 01:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36574D8CE;
	Tue, 17 Dec 2024 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChAa0075"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBA2837A;
	Tue, 17 Dec 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398930; cv=fail; b=N3mAi+G6hClwhDDnSN+oqcEA33N3Vka1zNjYfydjmqhqUD/6ZJQfAxAEVtO7tW5G/VPUCQgQS2pRkFhuGeYjirSrPzPRz9x1SJKw3nKXFiL1wRQBa72Q0m9zyC9s59DQ8EACylBKG+DDeBT9IU3kbNQhqOS/LKBwy93ydxohaI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398930; c=relaxed/simple;
	bh=+uuxjqC2ov6M0epObssLdLQbVoQd7dKS8GlxhIcRDLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ayPX0NiOdNLHl9QVFiS4r/Uq8bxZnpclYy3fwQf1DF940Vo8EcWPsJ+2SkylxzM+QMhvepMEYpeMdJBkIAEgAO4fC3w1ZMwfylL2wI/471fAcTNi8j5JD+e4LmoudZFgSGCEte2YUIMDWRgO5A51khGElI2SdCtVd7t9NDMlPcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChAa0075; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734398928; x=1765934928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+uuxjqC2ov6M0epObssLdLQbVoQd7dKS8GlxhIcRDLY=;
  b=ChAa0075Oz+5Bv7EeTKzWNfWgiv841dS5Qk4+NJqEtkhbkZld7+Mq888
   UgdtORNXL5mgJWFiDCQhFTkZarMq4015Gz4pbFAW4lZV8L6UT3GjdL8Hl
   MMoDF/xdDZYyTF4PUcoLLVmPTL/srL3fydQRnjoZvVjupsIQQfn97l/ur
   sFC1tH2cvfZgaRPbDgKEUzoKh9leJikYR8JOSpXSLCizWistQ/H8YnWlj
   TuxS5wFg20amQrDS9uuhmroqBJRdRr3xH7e85dn9w4W/a6BAuvljydo/X
   FqCAxVltIiVJ8E/csANnldFimCwmgtUtbPCHmrt9mArrnIZ2Km7cjGE8C
   w==;
X-CSE-ConnectionGUID: Nw7HT1tGSrCCAImKPpSwlQ==
X-CSE-MsgGUID: tyGxV1siR8ORUpDMA9MYMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="37655988"
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="37655988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 17:28:47 -0800
X-CSE-ConnectionGUID: IZIAhCnxQN+EbpPZlYowIQ==
X-CSE-MsgGUID: APNFk2VVQ4mrA7IMrPAzlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97228321"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 17:28:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 17:28:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 17:28:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 17:28:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TV/UVCF+O5j+XAuMPtv8Nvi8/KEZoZ4e2JJMyS4Ju+sVACtYDEVP/ZSnGsmXDHHbWWeFeAEGD7jpdiKz+ureYoTu16JspSU5oo0vGtCBQ2GJGBZ9M6kN0xf+921F5t5p2G9RYJ1a0CPG5i7rbzqey3Gk3j3SJKHRNRQ1Jk20r3wN3VNh+pnShYDDFpD48nOkd8ElZbUsRNWynoTEBzO6q4/rJ0LrQp+Nbl4ILhcg6tLF8a0bUx80pyw+cYIVSNPpqqj0yQAty1JJ0E9QxCiq8bo5KFOQ3bEyWndkWSA8g4n16Eqe4NHmURU5qzFGmIyolrkQo8wERkvbvzKunvVwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uuxjqC2ov6M0epObssLdLQbVoQd7dKS8GlxhIcRDLY=;
 b=d7hrmXlTi90RVnWFRwV2UYEOYyzqaMGE9HtJINIdtk65zYvrlho7kl1H9ScYFAPrO2o+oB+3N0h9hMj/pZk0EEpa3ZRtr/dboe+d9aMD+PEM+Lq565d5jEIpBC0bKvUKBLrgNZ84KENFKtF7tciR5fPw4vzJkdwRJCFctB1MOjgXe5UWexmJyO53BMNKt4oFk497U7dXdb9j1auol1mMiX/chyyo/95M82YsQiUePPQjgem7ar3LFNv7hPFg6SufYav5naWRQZ4+tAKuhJQtghi+t6PehNcd4WmkR3yCTQ8S4RVnx8xPYqe3ACpUJoVx+DHXkQ0ZkmRVsBJwGQuUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 01:28:44 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 01:28:44 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Gomes, Vinicius"
	<vinicius.gomes@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/1] igc: Improve
 XDP_SETUP_PROG process
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/1] igc: Improve
 XDP_SETUP_PROG process
Thread-Index: AQHbS9Mj1En7w58Ui0COxbXiho+dnrLj1RSAgAXYb2A=
Date: Tue, 17 Dec 2024 01:28:44 +0000
Message-ID: <PH0PR11MB583035D379A98C44510A7D8ED8042@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20241211134532.3489335-1-yoong.siang.song@intel.com>
 <8d65f680-f5b9-411e-b71c-122d48240b6e@molgen.mpg.de>
In-Reply-To: <8d65f680-f5b9-411e-b71c-122d48240b6e@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|CY8PR11MB7731:EE_
x-ms-office365-filtering-correlation-id: 34d018c4-2d2a-4489-3f75-08dd1e3a25c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TjZVMWh0elUvU0piQ3UyOXk5azF2cGhyY0lXMkI0Ris0eWlndkRLdFZsbnJX?=
 =?utf-8?B?VmRYWWRsRUUxc052YWw2WHZ0Y051UjJPdFNxU2ltN1NnT1Mza090SHVYYTRl?=
 =?utf-8?B?bHhTaVFIL0lFOXpib0syQWV6ODM3T2xwR2dVTHByUFRtc0tZVXZGVUtkR3Vm?=
 =?utf-8?B?ajhVNUNnVWI2dkJMQkJwTG1uYlZPM3B2bGlXNk1HdUdlbjJMU1hGSlMwZ3N0?=
 =?utf-8?B?LzQxR25FY3EzbVpnanoxKyt5dlBnZEgrVWp2UytPellDOGhqb1hBU3RYS2Fz?=
 =?utf-8?B?MzlONG1LaXpQRlFoUmgwZFNMS0pnTWhBVTdKSjZRM1I0Ly9mOVFPWGRocEpH?=
 =?utf-8?B?dmM5MjhqQTJ1VTFkdjJ2VkVOOGplOExOVk9SS1crS3RPMmdxWXdDdFdSVHJo?=
 =?utf-8?B?cTkveVBnSG5DRy8ra0VlMzRhTTEwTEtBY0o0UUZldE9zbUNOaU9rZUNiNnRT?=
 =?utf-8?B?aHdvbEphNGJ2amZZZDczd24rNjZ4N1phaERuM1NJUHdJQ0p1Q0ZPWk9Va2JM?=
 =?utf-8?B?Wk4vdWNSK08vK0k5NDRPY0xYTlBSWTZuY2lUdXpXbjQ4T0w3aWFGb2ZoL1RC?=
 =?utf-8?B?RWxBQlRJWlFQZndhckdyOWNNdVJENWE1WlM4NTNLWTVxa0I0d1pEa0kxUlh3?=
 =?utf-8?B?Smc5RXNwYXVqdFRmQkR3VFlpRWF0WG5MRmpVajZNMTdDS25kbUc3Z1hTZGVY?=
 =?utf-8?B?d2djMi9Qd21CSy9tcTExNUFreWR6NG1BV1lxUk5PTXloRDYwZjNRNVY1R3hv?=
 =?utf-8?B?OEJOWC9oUWZHWENZenNUaDdNNTgvcHRHbVBlMHpVZlk1d3NSWHVlV0RiTXQy?=
 =?utf-8?B?d3BhUFJ2Y0hrUGVTV2xncTRRd3gyNlFscC94UDBhWTJpYytRTStBQ1NJZnZh?=
 =?utf-8?B?d1h5aHp0amJKS3o5MWpXaTYzZzJ3Vk9PSVptTWZ0a00wNlkxUFRDaTZCOElS?=
 =?utf-8?B?R0wzdzdjeVovZnprbTd0MFhjY3JFaXczWGc0ODZWNmtpczFoc2RrQmRiY1VG?=
 =?utf-8?B?NzNlMXUwejd1ajRtV2h3d2dvQWZtUVRUQkJTbTV3eVN5L1RweEtXQlBoeWwz?=
 =?utf-8?B?bkkyRnhvS3o4TGRpQ05yNUNWcTQ1NFZWa0tpam9ZS1RnQmxJQlZuTTRWQlRG?=
 =?utf-8?B?THhiemVRRVVHOThucTJjSUE0SVRyTXBUVW4xbCt4Nnd6MnJUbkZpQThJWTJw?=
 =?utf-8?B?NUZpTWt2QUlhT1A2TDlIdzNTajhnZExtb1d6NlY4TzFmdCtkaHg2VHJReDcz?=
 =?utf-8?B?MVRZSVV3dDFSZXcvZ2g3cmZ2eVlIczRacjBxa2kzSFJTdHdLYU00eTZVMkhC?=
 =?utf-8?B?c1hZcmNIUm1WakNuQTBHSTZtaVpvb0lGSWphKzQxYnJUNmdWMGxHQlIvZGhC?=
 =?utf-8?B?ck5PaG1YczJVMTFsTTgzbEVRSU9KdVVvZzNHcE0yaDZTL0FEVzJEMUtBc0p4?=
 =?utf-8?B?bjFveUp0anoyaFdtWDc3QWZOL0tleEJGUVg1Um1SMFJvVG5nTkE4SkNOMmts?=
 =?utf-8?B?NlBrRU5kbjNZUFlmOXZLQXR3SlJwZWg1QVZlUGVQcjVNQVd4VTlkR1IzWkxZ?=
 =?utf-8?B?T1NEODRtd2VwanFYeXFwUVF2dnNoU3hBQ0lSOGJQbThVRW1La0NZRmU1NXFL?=
 =?utf-8?B?eExSSStYVmtWU3Npa1dManhDeU5HNWhBdXFQSjdoVEpxdVBTVDhMc0xUS2hi?=
 =?utf-8?B?NXJ2NXcxamJoRzYvUzVSL2hCUTJ1cHFnTnJBUjZyZllReDVWK2d5NVE3bjB2?=
 =?utf-8?B?VmVoS1hQZEc5U0ZJMkRBNE53KzBTVk5aU05yS1N4K1EyZHBaYVlUcjNUR2hv?=
 =?utf-8?B?UVhlazRYZ05zZWYxRzBDU3dRbURJQytBaStVMnZtRC9NTnBTVzdzQ1QyNGVa?=
 =?utf-8?B?VlMwa3pPWWJUYlY0Q2VmWURhTm5uMWpkWXhnYXZNMms1L01GOFVCNnptYzgx?=
 =?utf-8?Q?bXyukc5PN4g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXFVY08rU1dEUUtWZVM1V1lOR1ZpLy9hcXZIbVRQR1k4a3lGWTRTa2l5QkRR?=
 =?utf-8?B?OWdjZWJFcTVVUUJzbGkvUUNKTkk3YVdBZDV5bkxZdy9icTJGdjBvSFpSN1JL?=
 =?utf-8?B?Mm92bkFydWZVWXRYQWlZQUJqcUF1bnJxYmtEclRrTzRHM0cwR0ZIMkxSMVEv?=
 =?utf-8?B?ZkZsYjF5Zms4aG50cCtUUFlwN1JOOW9qckdka2JKN0taMGRYanBISGlPZWgr?=
 =?utf-8?B?MGJRVzVINTExSmJFYjdpMzhxUWNndlNKNmZKZkpCNFp3MStXdHJIVlBIR2VD?=
 =?utf-8?B?RTh3SHNkTDBXVmViZ1U2cHYxa3BBcG5ydzFJUTZtS00zb0RMTW9uOWhhQXp4?=
 =?utf-8?B?ZlhWemgzU05BcDNOYjlFZE5ZQ1Q0OGwyY2ZFd3V4dy9FZ09nSWZpYWRaVWw0?=
 =?utf-8?B?dmg3SzFSYlVDaEI4a2NURnVpWTMzNS9xWkFoUVpMOGpOZmlnVDRYY3dhS3Uz?=
 =?utf-8?B?SU82QWNBTkQ0cFQrcytjS1VnbGNXSGd6M0tsWGxiZ3dtcWE2ODFpZmRYRnpr?=
 =?utf-8?B?UFVSMVkrd1NGczYzQis4U3gwSWxGcjEzWG0zUE9obHNkTi9maFJtNnI0bGZj?=
 =?utf-8?B?MlBteGl4dksrQzR6bk1iU0QrZk1lMXJzV3VJL2dMSmNrOEpWU1kyKzBTaFcx?=
 =?utf-8?B?TFQ2Tk9KdlN6MmY0VkkrN0V2VkNBbmJ5dmVhT3Baa0hycFMxWFJFT1M2RDE5?=
 =?utf-8?B?OGc4NHlpa0FvRWRKQXlYTlF0WnlPS3gxTDVwdXQvWjFSUEpDNUdZM2dRcGxB?=
 =?utf-8?B?RnAyMm9tNk9ad3hWeVdUMXNDeWJHK0twV3I0bVd1bVNQQXU0UGFjaWFkaFAw?=
 =?utf-8?B?bDZqYThMNTIyTm5QcTRjaGhpT0xyRGxRa21nUmRGejRJWGtkU0wxaVdwbWhx?=
 =?utf-8?B?TGJlRWhYSXJ6b3F3Y1RPMUVkamR5NmxkTWQ1L1UzcTVQbFhLWDFqTjhaZHZr?=
 =?utf-8?B?NC8xZDQvdm5oNHY0b1lRZGFIdFlYakJNaFR0dWVYZnRJK0lrZWRITWNzc2tK?=
 =?utf-8?B?NjBaOG4zWGJjK2czNldLa3hJa0RqYmUwTGtRaWk1bndZS0M3d0V2QWhvQlFh?=
 =?utf-8?B?M3hIcm4xWFY4enlPQytlVS9tQWR1K3VtZEJ3RDBCREJueU43bFQrc2NlNkY5?=
 =?utf-8?B?TGpwdEFVSmJQNzRyNGNNMjludi9aMkNHNGJ1bWxUTzRtTy9vTWVHVTlhQjBH?=
 =?utf-8?B?emZweW9EVzlpM3RSdmY2SzgzSFpGcFRZWEg5SFVtV2dtVTlQRVBVTkt5czdJ?=
 =?utf-8?B?bW1MQkVuV0tCWW5QY2M0TThMSVhDWGxKeFA4OVpiclRvby9aWDRzeWYwR1FF?=
 =?utf-8?B?SFBEUVFxbFIzTzZtOHpHb0wvTzVYYVBVK3JOMDFrc2gybzA5T05KaTh5bEI0?=
 =?utf-8?B?aTVlR2cweW9ZcEZSd2dNbTNkTE54Vy9ZeDJwRE5KcXQ3Yy9LZ3ppLzkzZk55?=
 =?utf-8?B?YWc1Z0FkdTltR3BZU1ZBRUk2ODVyT3F2OGl3U3JjdFJPaFFHS0tmOURxZlkx?=
 =?utf-8?B?b1pFV1JGdUNjUmttRE5yL1ZYWk5vMldBaXdqdTg3TktaWHpQUmZKTk5uL3ll?=
 =?utf-8?B?bUcxMWFXSVpzQlc4ZDJlSmQxbnlhYTlVVktaM3l2OVdnbDdnUDlnbWdlNmV4?=
 =?utf-8?B?Mnc0L3ZrVENid1lWT0J2K3NoRXhXMVlxbFE2SGptQjZPVWN6czJENHJlQkox?=
 =?utf-8?B?c0NubEs1SGxFWEVRWFFQSExObW11eVlobVZXdGNRM1RVUGRZcE5oWGxXNWx5?=
 =?utf-8?B?RlAyVFpNUktRZ3FsdTdQY0NDQ3BPc1F6Wmd6TlBzL3QzUlpCbTYzcTdjRkpx?=
 =?utf-8?B?bjRLNnNFeDVzY3preWxwUkExV0VwdEJEWkRXa3ZGUitJMSs3bE90eWdpeXJO?=
 =?utf-8?B?NDFyUUNxRUdrZjIxVUdWdFRxZStpdklsRmhiWkJubTRsMnF5NVJZTWdIdHc2?=
 =?utf-8?B?amtDLzhoeG5qbjNOMGVyY1hvS2ZCdHNaaGduV1JTRGxNczdiL2xVRXNMVTho?=
 =?utf-8?B?THo2YUNjSWcyenNDT0JpRWg0YWwwM0Z0UXlUSW13cEs1OVFpd0E5d011TTBv?=
 =?utf-8?B?bjFtRlpuU0U0QnRoT1VSS2F6NmU0T1BpWGJCVDl2WVY1QW9yZTN2TDRWK1Mw?=
 =?utf-8?B?dmxZQWUzUXM4d2xtQ1VpVjNUdVZKSnA3UzRPUndSNkxpUFRGZGh5MWdLbXNV?=
 =?utf-8?B?K3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d018c4-2d2a-4489-3f75-08dd1e3a25c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 01:28:44.6659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3M397UmewaDkKShBvWY0eZmQvNIg9utrEpNZk/m9/1XF/RC77KmbidPpK1lQxFlBCuZi9Xj+ByBda+u0NoYg+2xX8U1dj7MYSBhHUa/ix9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
X-OriginatorOrg: intel.com

T24gRnJpZGF5LCBEZWNlbWJlciAxMywgMjAyNCA0OjEwIFBNLCBQYXVsIE1lbnplbCA8cG1lbnpl
bEBtb2xnZW4ubXBnLmRlPiB3cm90ZToNCj5EZWFyIFNvbmcsDQo+DQo+DQo+VGhhbmsgeW91IGZv
ciB5b3VyIHBhdGNoLiBNYXliZSBmb3IgdGhlIHN1bW1hcnkvdGl0bGUgeW91IGNvdWxkIGJlIG1v
cmUNCj5zcGVjaWZpYzoNCj4NCj5pZ2M6IEF2b2lkIHVubmVjZXNzYXJ5IGxpbmsgZG93biBldmVu
dCBpbiBYRFBfU0VUVVBfUFJPRyBwcm9jZXNzDQo+DQo+DQo+QW0gMTEuMTIuMjQgdW0gMTQ6NDUg
c2NocmllYiBTb25nIFlvb25nIFNpYW5nOg0KPj4gSW1wcm92ZSBYRFBfU0VUVVBfUFJPRyBwcm9j
ZXNzIGJ5IGF2b2lkaW5nIHVubmVjZXNzYXJ5IGxpbmsgZG93biBldmVudC4NCj4+DQo+PiBUaGlz
IHBhdGNoIGlzIHRlc3RlZCBieSB1c2luZyBpcCBsaW5rIHNldCB4ZHBkcnYgY29tbWFuZCB0byBh
dHRhY2ggYSBzaW1wbGUNCj4+IFhEUCBwcm9ncmFtIHdoaWNoIGFsd2F5cyByZXR1cm4gWERQX1BB
U1MuDQo+DQo+cmV0dXJuKnMqDQo+DQo+PiBCZWZvcmUgdGhpcyBwYXRjaCwgYXR0YWNoaW5nIHhk
cCBwcm9ncmFtIHdpbGwgY2F1c2UgcHRwNGwgdG8gbG9zdCBzeW5jIGZvcg0KPg0KPnRvIGxvc2UN
Cj4NCj4+IGZldyBzZWNvbmRzLCBhcyBzaG93biBpbiBwdHA0bCBsb2cgYmVsb3c6DQo+PiAgICBw
dHA0bFsxOTguMDgyXTogcm1zICAgIDQgbWF4ICAgIDggZnJlcSAgICs5MDYgKy8tICAgMiBkZWxh
eSAgICAxMiArLy0gICAwDQo+PiAgICBwdHA0bFsxOTkuMDgyXTogcm1zICAgIDMgbWF4ICAgIDQg
ZnJlcSAgICs5MDYgKy8tICAgMyBkZWxheSAgICAxMiArLy0gICAwDQo+PiAgICBwdHA0bFsxOTku
NTM2XTogcG9ydCAxIChlbnAyczApOiBsaW5rIGRvd24NCj4+ICAgIHB0cDRsWzE5OS41MzZdOiBw
b3J0IDEgKGVucDJzMCk6IFNMQVZFIHRvIEZBVUxUWSBvbiBGQVVMVF9ERVRFQ1RFRA0KPihGVF9V
TlNQRUNJRklFRCkNCj4+ICAgIHB0cDRsWzE5OS42MDBdOiBzZWxlY3RlZCBsb2NhbCBjbG9jayAy
MmFiYmMuZmZmZS5iYjEyMzQgYXMgYmVzdCBtYXN0ZXINCj4+ICAgIHB0cDRsWzE5OS42MDBdOiBw
b3J0IDEgKGVucDJzMCk6IGFzc3VtaW5nIHRoZSBncmFuZCBtYXN0ZXIgcm9sZQ0KPj4gICAgcHRw
NGxbMTk5LjYwMF06IHBvcnQgMSAoZW5wMnMwKTogbWFzdGVyIHN0YXRlIHJlY29tbWVuZGVkIGlu
IHNsYXZlIG9ubHkgbW9kZQ0KPj4gICAgcHRwNGxbMTk5LjYwMF06IHBvcnQgMSAoZW5wMnMwKTog
ZGVmYXVsdERTLnByaW9yaXR5MSBwcm9iYWJseSBtaXNjb25maWd1cmVkDQo+PiAgICBwdHA0bFsy
MDIuMjY2XTogcG9ydCAxIChlbnAyczApOiBsaW5rIHVwDQo+PiAgICBwdHA0bFsyMDIuMzAwXTog
cG9ydCAxIChlbnAyczApOiBGQVVMVFkgdG8gTElTVEVOSU5HIG9uIElOSVRfQ09NUExFVEUNCj4+
ICAgIHB0cDRsWzIwNS41NThdOiBwb3J0IDEgKGVucDJzMCk6IG5ldyBmb3JlaWduIG1hc3RlciA0
NGFiYmMuZmZmZS5iYjIxNDQtMQ0KPj4gICAgcHRwNGxbMjA3LjU1OF06IHNlbGVjdGVkIGJlc3Qg
bWFzdGVyIGNsb2NrIDQ0YWJiYy5mZmZlLmJiMjE0NA0KPj4gICAgcHRwNGxbMjA3LjU1OV06IHBv
cnQgMSAoZW5wMnMwKTogTElTVEVOSU5HIHRvIFVOQ0FMSUJSQVRFRCBvbiBSU19TTEFWRQ0KPj4g
ICAgcHRwNGxbMjA4LjMwOF06IHBvcnQgMSAoZW5wMnMwKTogVU5DQUxJQlJBVEVEIHRvIFNMQVZF
IG9uDQo+TUFTVEVSX0NMT0NLX1NFTEVDVEVEDQo+PiAgICBwdHA0bFsyMDguOTMzXTogcm1zICA3
NDIgbWF4IDEzMDMgZnJlcSAgIC0xOTUgKy8tIDY4MiBkZWxheSAgICAxMiArLy0gICAwDQo+PiAg
ICBwdHA0bFsyMDkuOTMzXTogcm1zICAxNzggbWF4ICAyNzQgZnJlcSAgICszODcgKy8tIDI0MyBk
ZWxheSAgICAxMiArLy0gICAwDQo+Pg0KPj4gQWZ0ZXIgdGhpcyBwYXRjaCwgYXR0YWNoaW5nIHhk
cCBwcm9ncmFtIG5vIGxvbmdlciBjYXVzZSBwdHA0bCB0byBsb3N0IHN5bmMsDQo+DQo+dG8gbG9z
ZQ0KPg0KPj4gYXMgc2hvd24gb24gcHRwNGwgbG9nIGJlbG93Og0KPj4gICAgcHRwNGxbMjAxLjE4
M106IHJtcyAgICAxIG1heCAgICAzIGZyZXEgICArOTU5ICsvLSAgIDEgZGVsYXkgICAgIDggKy8t
ICAgMA0KPj4gICAgcHRwNGxbMjAyLjE4M106IHJtcyAgICAxIG1heCAgICAzIGZyZXEgICArOTYx
ICsvLSAgIDIgZGVsYXkgICAgIDggKy8tICAgMA0KPj4gICAgcHRwNGxbMjAzLjE4M106IHJtcyAg
ICAyIG1heCAgICAzIGZyZXEgICArOTU4ICsvLSAgIDIgZGVsYXkgICAgIDggKy8tICAgMA0KPj4g
ICAgcHRwNGxbMjA0LjE4M106IHJtcyAgICAzIG1heCAgICA1IGZyZXEgICArOTYxICsvLSAgIDMg
ZGVsYXkgICAgIDggKy8tICAgMA0KPj4gICAgcHRwNGxbMjA1LjE4M106IHJtcyAgICAyIG1heCAg
ICA0IGZyZXEgICArOTY0ICsvLSAgIDMgZGVsYXkgICAgIDggKy8tICAgMA0KPj4NCj4+IEJlc2lk
ZXMsIGJlZm9yZSB0aGlzIHBhdGNoLCBhdHRhY2hpbmcgeGRwIHByb2dyYW0gd2lsbCBjYXVzZSBm
bG9vZCBwaW5nIHRvDQo+PiBsb3NzIDEwIHBhY2tldHMsIGFzIHNob3duIGluIHBpbmcgc3RhdGlz
dGljcyBiZWxvdzoNCj4NCj50byBsb3NlDQo+DQo+PiAgICAtLS0gMTY5LjI1NC4xLjIgcGluZyBz
dGF0aXN0aWNzIC0tLQ0KPj4gICAgMTAwMDAwIHBhY2tldHMgdHJhbnNtaXR0ZWQsIDk5OTkwIHJl
Y2VpdmVkLCArNiBlcnJvcnMsIDAuMDElIHBhY2tldCBsb3NzLCB0aW1lDQo+MzQwMDFtcw0KPj4g
ICAgcnR0IG1pbi9hdmcvbWF4L21kZXYgPSAwLjAyOC8wLjMwMS8zMTA0LjM2MC8xMy44MzggbXMs
IHBpcGUgMTAsIGlwZy9ld21hDQo+MC4zNDAvMC4yNDMgbXMNCj4+DQo+PiBBZnRlciB0aGlzIHBh
dGNoLCBhdHRhY2hpbmcgeGRwIHByb2dyYW0gbm8gbG9uZ2VyIGNhdXNlIGZsb29kIHBpbmcgdG8g
bG9zcw0KPg0KPmNhdXNlKnMqLCB0byBsb3NlDQo+DQo+PiBhbnkgcGFja2V0cywgYXMgc2hvd24g
aW4gcGluZyBzdGF0aXN0aWNzIGJlbG93Og0KPj4gICAgLS0tIDE2OS4yNTQuMS4yIHBpbmcgc3Rh
dGlzdGljcyAtLS0NCj4+ICAgIDEwMDAwMCBwYWNrZXRzIHRyYW5zbWl0dGVkLCAxMDAwMDAgcmVj
ZWl2ZWQsIDAlIHBhY2tldCBsb3NzLCB0aW1lIDMyMzI2bXMNCj4+ICAgIHJ0dCBtaW4vYXZnL21h
eC9tZGV2ID0gMC4wMjcvMC4yMzEvMTkuNTg5LzAuMTU1IG1zLCBwaXBlIDIsIGlwZy9ld21hDQo+
MC4zMjMvMC4zMjIgbXMNCj4+DQo+PiBPbiB0aGUgb3RoZXIgaGFuZCwgdGhpcyBwYXRjaCBpcyBh
bHNvIHRlc3RlZCB3aXRoIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzLw0KPj4gYnBmL3hkcF9od19t
ZXRhZGF0YSBhcHAgdG8gbWFrZSBzdXJlIFhEUCB6ZXJvLWNvcHkgaXMgd29ya2luZyBmaW5lIHdp
dGgNCj4+IFhEUCBUeCBhbmQgUnggbWV0YWRhdGEuIEJlbG93IGlzIHRoZSByZXN1bHQgb2YgbGFz
dCBwYWNrZXQgYWZ0ZXIgcmVjZWl2ZWQNCj4+IDEwMDAwIFVEUCBwYWNrZXRzIHdpdGggaW50ZXJ2
YWwgMSBtczoNCj4+ICAgIHBvbGw6IDEgKDApIHNraXA9MCBmYWlsPTAgcmVkaXI9MTAwMDANCj4+
ICAgIHhza19yaW5nX2NvbnNfX3BlZWs6IDENCj4+ICAgIDB4NTU4ODFjN2VmN2E4OiByeF9kZXNj
Wzk5OTldLT5hZGRyPThmMTEwIGFkZHI9OGYxMTAgY29tcF9hZGRyPThmMTEwIEVvUA0KPj4gICAg
cnhfaGFzaDogMHhGQjlCQjZBMyB3aXRoIFJTUyB0eXBlOjB4MQ0KPj4gICAgSFcgUlgtdGltZTog
ICAxNzMzOTIzMTM2MjY5NDcwODY2IChzZWM6MTczMzkyMzEzNi4yNjk1KSBkZWx0YSB0byBVc2Vy
IFJYLQ0KPnRpbWUgc2VjOjAuMDAwMCAoNDMuMjgwIHVzZWMpDQo+PiAgICBYRFAgUlgtdGltZTog
ICAxNzMzOTIzMTM2MjY5NDgyNDgyIChzZWM6MTczMzkyMzEzNi4yNjk1KSBkZWx0YSB0byBVc2Vy
IFJYLQ0KPnRpbWUgc2VjOjAuMDAwMCAoMzEuNjY0IHVzZWMpDQo+PiAgICBObyByeF92bGFuX3Rj
aSBvciByeF92bGFuX3Byb3RvLCBlcnI9LTk1DQo+PiAgICAweDU1ODgxYzdlZjdhODogcGluZy1w
b25nIHdpdGggY3N1bT1hYjE5ICh3YW50IDMxNWIpIGNzdW1fc3RhcnQ9MzQNCj5jc3VtX29mZnNl
dD02DQo+PiAgICAweDU1ODgxYzdlZjdhODogY29tcGxldGUgdHggaWR4PTk5OTkgYWRkcj1mMDEw
DQo+PiAgICBIVyBUWC1jb21wbGV0ZS10aW1lOiAgIDE3MzM5MjMxMzYyNjk1OTE2MzcgKHNlYzox
NzMzOTIzMTM2LjI2OTYpIGRlbHRhIHRvDQo+VXNlciBUWC1jb21wbGV0ZS10aW1lIHNlYzowLjAw
MDEgKDEwOC41NzEgdXNlYykNCj4+ICAgIFhEUCBSWC10aW1lOiAgIDE3MzM5MjMxMzYyNjk0ODI0
ODIgKHNlYzoxNzMzOTIzMTM2LjI2OTUpIGRlbHRhIHRvIFVzZXIgVFgtDQo+Y29tcGxldGUtdGlt
ZSBzZWM6MC4wMDAyICgyMTcuNzI2IHVzZWMpDQo+PiAgICBIVyBSWC10aW1lOiAgIDE3MzM5MjMx
MzYyNjk0NzA4NjYgKHNlYzoxNzMzOTIzMTM2LjI2OTUpIGRlbHRhIHRvIEhXIFRYLQ0KPmNvbXBs
ZXRlLXRpbWUgc2VjOjAuMDAwMSAoMTIwLjc3MSB1c2VjKQ0KPj4gICAgMHg1NTg4MWM3ZWY3YTg6
IGNvbXBsZXRlIHJ4IGlkeD0xMDEyNyBhZGRyPThmMTEwDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
U29uZyBZb29uZyBTaWFuZyA8eW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20+DQo+PiAtLS0NCj4+
IFYyIGNoYW5nZWxvZzoNCj4+ICAgLSBzaG93IHNvbWUgZXhhbXBsZXMgb2YgcHJvYmxlbSBpbiBj
b21taXQgbXNnLiAoVmluaWNpdXMpDQo+PiAgIC0gaWdjX2Nsb3NlKCkvaWdjX29wZW4oKSBhcmUg
dG9vIGJpZyBhIGhhbW1lciBmb3IgaW5zdGFsbGluZyBhIG5ldyBYRFANCj4+ICAgICBwcm9ncmFt
LiBPbmx5IGRvIHdlIHdlIHJlYWxseSBuZWVkLiAoVmluaWNpdXMpDQo+DQo+VGhlIGZpcnN0IHNl
bnRlbmNlIG9mIHRoZSBzZWNvbmQgaXRlbSBjb3VsZCBnbyBpbnRvIHRoZSBjb21taXQgbWVzc2Fn
ZQ0KPndpdGggYSBub3RlLCB3aHkgYGlnY19jbG9zZSgpYC9gaWdjX29wZW4oKWAgYXJlIG5vdCBu
ZWVkZWQuDQo+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2ln
Y194ZHAuYyB8IDE5ICsrKysrKysrKysrKysrKy0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfeGRwLmMNCj5iL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2lnYy9pZ2NfeGRwLmMNCj4+IGluZGV4IDg2OTgxNWY0OGFjMS4uNjRiMDRhYWQ2
MTRjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY194
ZHAuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY194ZHAuYw0K
Pj4gQEAgLTE0LDYgKzE0LDcgQEAgaW50IGlnY194ZHBfc2V0X3Byb2coc3RydWN0IGlnY19hZGFw
dGVyICphZGFwdGVyLCBzdHJ1Y3QNCj5icGZfcHJvZyAqcHJvZywNCj4+ICAgCWJvb2wgaWZfcnVu
bmluZyA9IG5ldGlmX3J1bm5pbmcoZGV2KTsNCj4+ICAgCXN0cnVjdCBicGZfcHJvZyAqb2xkX3By
b2c7DQo+PiAgIAlib29sIG5lZWRfdXBkYXRlOw0KPj4gKwlpbnQgaTsNCj4NCj5J4oCZZCB1c2Ug
dW5zaWduZWQgaW50IGFzIGl04oCZcyB1c2VkIHRvIGFjY2VzcyBhcnJheSBlbGVtZW50cy4NCj4N
Cj4+DQo+PiAgIAlpZiAoZGV2LT5tdHUgPiBFVEhfREFUQV9MRU4pIHsNCj4+ICAgCQkvKiBGb3Ig
bm93LCB0aGUgZHJpdmVyIGRvZXNuJ3Qgc3VwcG9ydCBYRFAgZnVuY3Rpb25hbGl0eSB3aXRoDQo+
PiBAQCAtMjQsOCArMjUsMTMgQEAgaW50IGlnY194ZHBfc2V0X3Byb2coc3RydWN0IGlnY19hZGFw
dGVyICphZGFwdGVyLCBzdHJ1Y3QNCj5icGZfcHJvZyAqcHJvZywNCj4+ICAgCX0NCj4+DQo+PiAg
IAluZWVkX3VwZGF0ZSA9ICEhYWRhcHRlci0+eGRwX3Byb2cgIT0gISFwcm9nOw0KPj4gLQlpZiAo
aWZfcnVubmluZyAmJiBuZWVkX3VwZGF0ZSkNCj4+IC0JCWlnY19jbG9zZShkZXYpOw0KPj4gKwlp
ZiAoaWZfcnVubmluZyAmJiBuZWVkX3VwZGF0ZSkgew0KPj4gKwkJZm9yIChpID0gMDsgaSA8IGFk
YXB0ZXItPm51bV9yeF9xdWV1ZXM7IGkrKykgew0KPj4gKwkJCWlnY19kaXNhYmxlX3J4X3Jpbmco
YWRhcHRlci0+cnhfcmluZ1tpXSk7DQo+PiArCQkJaWdjX2Rpc2FibGVfdHhfcmluZyhhZGFwdGVy
LT50eF9yaW5nW2ldKTsNCj4+ICsJCQluYXBpX2Rpc2FibGUoJmFkYXB0ZXItPnJ4X3JpbmdbaV0t
PnFfdmVjdG9yLT5uYXBpKTsNCj4+ICsJCX0NCj4+ICsJfQ0KPj4NCj4+ICAgCW9sZF9wcm9nID0g
eGNoZygmYWRhcHRlci0+eGRwX3Byb2csIHByb2cpOw0KPj4gICAJaWYgKG9sZF9wcm9nKQ0KPj4g
QEAgLTM2LDggKzQyLDEzIEBAIGludCBpZ2NfeGRwX3NldF9wcm9nKHN0cnVjdCBpZ2NfYWRhcHRl
ciAqYWRhcHRlciwgc3RydWN0DQo+YnBmX3Byb2cgKnByb2csDQo+PiAgIAllbHNlDQo+PiAgIAkJ
eGRwX2ZlYXR1cmVzX2NsZWFyX3JlZGlyZWN0X3RhcmdldChkZXYpOw0KPj4NCj4+IC0JaWYgKGlm
X3J1bm5pbmcgJiYgbmVlZF91cGRhdGUpDQo+PiAtCQlpZ2Nfb3BlbihkZXYpOw0KPj4gKwlpZiAo
aWZfcnVubmluZyAmJiBuZWVkX3VwZGF0ZSkgew0KPj4gKwkJZm9yIChpID0gMDsgaSA8IGFkYXB0
ZXItPm51bV9yeF9xdWV1ZXM7IGkrKykgew0KPj4gKwkJCW5hcGlfZW5hYmxlKCZhZGFwdGVyLT5y
eF9yaW5nW2ldLT5xX3ZlY3Rvci0+bmFwaSk7DQo+PiArCQkJaWdjX2VuYWJsZV90eF9yaW5nKGFk
YXB0ZXItPnR4X3JpbmdbaV0pOw0KPj4gKwkJCWlnY19lbmFibGVfcnhfcmluZyhhZGFwdGVyLT5y
eF9yaW5nW2ldKTsNCj4+ICsJCX0NCj4+ICsJfQ0KPj4NCj4+ICAgCXJldHVybiAwOw0KPj4gICB9
DQo+DQo+DQo+S2luZCByZWdhcmRzLA0KPg0KPlBhdWwNCg0KSGkgUGF1bCwNCg0KVGhhbmsgeW91
IGZvciB5b3VyIHZhbHVhYmxlIHJldmlldyBjb21tZW50cy4NCkZZSSwgSSBzdWJtaXR0ZWQgdjMg
WzFdIHRvIGFkZHJlc3MgeW91ciBjb21tZW50cy4NClBsZWFzZSBmZWVsIGZyZWUgdG8gcmV2aWV3
IGFnYWluLg0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2ludGVs
LXdpcmVkLWxhbi9wYXRjaC8yMDI0MTIxNjA3Mzg0OS4zNTU1ODI1LTEteW9vbmcuc2lhbmcuc29u
Z0BpbnRlbC5jb20vDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNpYW5nDQo=

