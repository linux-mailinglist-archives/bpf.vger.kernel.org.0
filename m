Return-Path: <bpf+bounces-53839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B915A5C8D4
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39B07A9BD1
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144725EFB6;
	Tue, 11 Mar 2025 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApOAKZ9Q"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125261E1A32;
	Tue, 11 Mar 2025 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708231; cv=fail; b=WWv7x1RC3JEbnVfTF95A7PaC6DtTZEHJbDTZD2c9WYI8M778e+defTJ69O6dPH0nOEOxfdrFgBcXztBcJyLunskPCqmUP4W6J3OG2SFF29RAkRDHnsh3owoRQ2lU3PknX4uIS4gBzp7K3AEyKj+Ve2IVmwmKLTc8AICJmp32iY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708231; c=relaxed/simple;
	bh=s1iEPJNVNzbjj3yLBG8Ee65BGZVXiO/ynSN5Y/5p578=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDI9XeGYDOID1VS0mU7QadGLa5NiETuH4BB5fWQ8QUh5GAFY6ZuZS4IqSFRAP3Sd55/nw3E+FgX8/BVlqmiYMy4HNJ727l59nbei1nX8v0cuZeoyBxzQc28M/f1m27NQAf9Zu0YDnbiHgwCuTZt+gs6ZYhmJbq68vvqXFzOw6LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApOAKZ9Q; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741708229; x=1773244229;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s1iEPJNVNzbjj3yLBG8Ee65BGZVXiO/ynSN5Y/5p578=;
  b=ApOAKZ9QFBBJxamYL42jyGe2M44qpxhoa8tHYgWK/N8du32UnjzXoLy7
   TA+MUZ6efkf9lBFmlH+qy4F9RKfHUgxA4vQCoiasjyX1Qvm/8NyKIv5Xv
   N/RvIiGcISUl8WrDmG/0FOcVgcn6xH7n7P2p/vTzwhFWph+TblYC1v5JA
   72zfrCQTiTo/6fiYPdn3JNuGD3aogIufwt4XrXse47BKYaSFxA+JPx8ob
   rRAgF+XM2C/P288n08E9L5XL3Noka7jOx+IOo7I8T0o3SvAajhA3+FWLW
   A4RPIQTKogz5P0BLaCcHQzG7xpkUlDMpMK5GiAYdXUk1Zn3KJzQJu5Anm
   A==;
X-CSE-ConnectionGUID: Qr59x2bEQ9mFSBwDBVfy5g==
X-CSE-MsgGUID: V27oy2otTZG+sng6x34dzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="30328713"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="30328713"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:50:25 -0700
X-CSE-ConnectionGUID: n9EXtH0iSuumGY1zvFSWmA==
X-CSE-MsgGUID: kOSd5yVSSqWvTVf1jAeJfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125564766"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:50:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 08:50:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 08:50:24 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 08:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1mNIpJrDXaOU21V7/bFBn/sucKoGT8Z5AQAWumK6PpFjAzcRSUneZvZodHpSKedj3OZSKKSFfvKF0wz3qT/dPQkJRgzfFLe0H/if91tFZ6o3tag1Kel8zXf6O3dIA0m6x2v2/bVkSOBVbyIZZPPxCOexmdxMT5oVvGyoByXT+QmjMYEACxxvF85H9z3cR2Sf5nf5QEHD4tEezIdUu6vXqjOGp0YjBQ3Mf/CYP6D4GvO4zXE4TFiCHQt6Ad07/2t5ZRvbRC+zV31Ws5m1GUyEuwEEAh9y0EtPiiGUCi8vmVVIgmtsjMCUdvL6xUBDtfZZr4aRdiY8Fj1Nh0nA0Z/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNIV+rDmcOVK+I5RBSYXfrLbZ6uQ6WMwwRmNN5GmXiw=;
 b=kC3PTji/aT+yqz62Px/++udBWmJ/dMJY6A1PRqYRmHI0jFEPzcKr+UOV4y9W1D3byqIp4NWgQ0n2dj9bjyviUX8q8tZppVfI3srmohaMdSRu+uTFhCGsNvde066hy3LiVpnhw+Bz/BZAptPBKPx2p/udFmoJXF4KLt7VmXDkFeOWyPcZxiA25egGYvW4bq98hQx44BG3R8QUjWgwMDT4E9kBA1D7ebiIOk+VYDLlWAVaKiLhWEedfdPJexYFvOlhooj7mb9r6lEODbtVHb17Ior89soRr2opoQy3tmk45EfiQwN1uxsPjF1UmCYo6JPgdoMSoJDP+lfN9N5dEfhHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 15:50:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:50:21 +0000
Date: Tue, 11 Mar 2025 16:50:07 +0100
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
Subject: Re: [PATCH net-next 14/16] idpf: add support for XDP on Rx
Message-ID: <Z9Bbr9b0WLFQZt4Z@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-15-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305162132.1106080-15-aleksander.lobakin@intel.com>
X-ClientProxiedBy: ZR0P278CA0091.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 997ef8ab-e0bc-4c69-b1f4-08dd60b46d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YJHc3lKh2FFHMdKxKMHfoBYdFarRwr5aarTKmL9kErsCtSo8sqCA0JnYtUMm?=
 =?us-ascii?Q?VFtYSf6qGab/KJkrhBbbQMnlFRoydv+WNpIZ3GeuBDF8tgRGnOfnS8QRwu6j?=
 =?us-ascii?Q?OGAZ/9lIGwq5uALth2V7t333UYD4QxvBnGpd+1R/u6UQwxqzUwCJEyabeLYK?=
 =?us-ascii?Q?cOh4mNf5KFlF7DunIYo9CHcZpe9aEZRcz/fxlXVSxZC8/Nlcl1NMHndoCMfR?=
 =?us-ascii?Q?nLcl+lXzYBCnyV46C77gpSDTs93GanWr60V29CmBxXE/eruRp+Kn0qJS7OtV?=
 =?us-ascii?Q?aAgrQ6OGK32eIwMCp4EaBtm2elUsIhdkv6Enr3glKRcGn4VraQ8PcEHVARl4?=
 =?us-ascii?Q?qqaMYjFfLcVoFa4NJhmc6EZNmobrRVi/TZjiITfCZ27LH2lf5I5g9QBGBxd8?=
 =?us-ascii?Q?UAHeLQECVPCNRlhjUUDk99F1J68GJh5Ua+jYGtV2e8gt8gGnguQgNgyVlm4N?=
 =?us-ascii?Q?dVUOdVolghOhaFeE/PYp1atBzeNpuadvoz2SSL8yW821lev0NlhM8Fs0ZPib?=
 =?us-ascii?Q?g+zfynmQufiVzA1WbqNRz2KKUsbXEBTyDzADsF0DqvT3ZLK3cN7OCVJv+BMC?=
 =?us-ascii?Q?5VQ1MofxjQqNGbxYwn/mis4FBhxYJ7R7B38aSxRdMMsD2gYnF58EO9a8tm6S?=
 =?us-ascii?Q?qxVUNhP6+C7RUX3j4GX3Bqiz0DBPaG0rrH6NR2RqobpfBagl6dIvVtznGl+7?=
 =?us-ascii?Q?tbc/NfRzu+hL7iwjFw15IQUqiYqKDPgVz/ZFUG5156KO4LXkl5JR2rKmsEar?=
 =?us-ascii?Q?AuPa9UWNKXt65z9IeYUxnfrIXoulL4ztlEEhUc7S7Q1pg3W98lhOCcegUr1v?=
 =?us-ascii?Q?9VoTmzmjGQ+7hWFrfGLKf193sZDFx2/wn314BzVSnV3T7jEmiuUApGPbPKFm?=
 =?us-ascii?Q?ypOvOCe99R5pVjvG4kwDvSJDLli3tAsfAEBmmxKKCVXztwx41oj/yTsmL5Nq?=
 =?us-ascii?Q?S+VxoIBQBt9M4sNqW6KHuI36JfKMauLS7W6tKkRca+XDRe1P8pKAT5i/vLku?=
 =?us-ascii?Q?mjRpFLMTtDt0yW9t/b3oFxhds41Ll2ewgumY9TwhgEdFdIaGg9/u97Gi9EuJ?=
 =?us-ascii?Q?x6z4nlTT/3CB6DG/e1gxt8ZLaNX4gepT9nmUex1I+Y9B/elemj2zJBa37sMY?=
 =?us-ascii?Q?07gjjfotlebC7wHdKNsb2dqD7VlJuiNLWLw5wVhsIeVpRaf9DuLw5UQaQ+nR?=
 =?us-ascii?Q?EWIRwQldTJ4NVE6tlQzvag3AS0pzIPepav40A9kE3XeFMRD9uMhQvcUJEaog?=
 =?us-ascii?Q?8da17IOgF6murS9vc8vpSHtla6rVUJB04CIGBUWDdCNE4v3sCo/qb3ez2q8c?=
 =?us-ascii?Q?QpwslzLpbdi6jfc20H59rgCpSBFKNoGP/P5S1nmTb0dgv0UZ5vl1yExDGEsE?=
 =?us-ascii?Q?DAeaKYcNxqTNAD9YigiI59iHjYyj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSlalXPCxjk2rpgwCDqEInDAwhRp4XZKfE3hcsgZ1AKdcBb0E1dGTnHKoWEc?=
 =?us-ascii?Q?0yX+XPTSnHynByZwlgs8ZD6aMboPF4vfTzHWorBJ/4jaRbdjfLDQoatB4Ke3?=
 =?us-ascii?Q?FavS1yMdeeIBB4bvijgdi6uYqhznE8sqW6cVYVUhcpiEb+kvidcxF3wObdKo?=
 =?us-ascii?Q?rlrRlA3ciw9HJM3A0E7KZUOQ6WcB5QunbdoK25AcbB4p1Ql475BvARuDALfU?=
 =?us-ascii?Q?tCn+o96x5KTAOeWyjILyuS1l8IUcmedKdbs5C5Z0kDonqxSjKcPS0Cffv8Ie?=
 =?us-ascii?Q?qC9XL9dqS8GZLhoOv+E78WG1B6TnRe3dSfniFZIYZTq6IK+r+hNUULVGSNtg?=
 =?us-ascii?Q?eaExd+SCtRJw2ZmUxOZcDFXy9Q0RuObx3VdsbEkQbsCN2f26zFnQRkRN22Jx?=
 =?us-ascii?Q?Np1U6BqHv5tYZ1DhQKkdy7dI8PvaBY3PYgD8dh5CPFIp2Ezy8zLdogiAvp2J?=
 =?us-ascii?Q?cAflGUXi1R/NuAYc+gpBFwKdhr6jGKG3cssmzeIN/HSWTMuE5FE9oQ006tpU?=
 =?us-ascii?Q?TzNyDXHrshQRJAEksVLH5pLli3423uj7H3aQogy8/WmIO0RVWy39SrEBjTkk?=
 =?us-ascii?Q?2gcv+mSqglfH9LkVDI4w55Px/jDxaDnuSCCjaM6ztOUKvZgXbMA3xEwOkyad?=
 =?us-ascii?Q?yamqLSo2SnTUVPYGp7xbcwVYl1vlqak+Gxf0DflCEFuw53B4avDO/IgYr7FM?=
 =?us-ascii?Q?k9Sw7xtYKyb+0kLK3yEqYN1hLiX7JN78acuIAV0a1fga5OiiPMMrTlv+IFZ3?=
 =?us-ascii?Q?AlYSJeJODCljLD8UoEdICdXRgOzqm7Os6AueOJGYKP/MFLuo7gxWBKzgAo4w?=
 =?us-ascii?Q?Ac/cx7ypCeJ7iiqNo4zlBtuVaC+nYqxsODDGVKDxfY9DeGc/Lv4DR74tHioC?=
 =?us-ascii?Q?DDPcT5Xj/pXXKjeVRR0YyXnvVf+4EAMsLxJoman67mEGV5v/sUvtLZs/zB1M?=
 =?us-ascii?Q?shNQsEqJ38JiLnxHk34ioyMJx9mxsE0k1LzOJLX/CCPOg9zszrcylzNrqTur?=
 =?us-ascii?Q?dssjxgSJUvDyVwDCc/GMPwlRIQUqmbuQC5hEgvwDF4644UBeH4KUnr3eVH5S?=
 =?us-ascii?Q?LJTwAIUfkxCyadPw1OjDKHIJk+DANqtd3tBw3LKatFiwQN44UyIzJb/fyqSG?=
 =?us-ascii?Q?cqsn/aXE0B3qROYWFJ7hUSiNSEC0Ev6kAyQvoZhW+VvPjdq/NaIvimxFl8mS?=
 =?us-ascii?Q?HYYNNbqj7bCW1i9EZdtk9NjcZH1xpJfO6iSXvYiVhqeIFuPcz94l+mlj1e2P?=
 =?us-ascii?Q?edkRXd7AV0LK0paHdQRxshEWVhiloc8dnP85GuE5Wdv3gZg6l7ukcdnkxc1S?=
 =?us-ascii?Q?TVzeOoCRSZ9+VQNgPkz2iMrA7hTvKMhjQWOcwwXSqv2YsKf6aqCOUt23QGTp?=
 =?us-ascii?Q?Yqvi2dW6NX6jP8NyrPbtdjKou0vn91rzxGyJq42BX3/+XfLNaNJ6jSNQ/b1R?=
 =?us-ascii?Q?9+ginhkMQrltp8pDQZa3/O/f5CUeQVFvQ1i6eGG4iPr99LE7bIIK5OtETT8+?=
 =?us-ascii?Q?f4+nCC+hb8Zt4kA4bUsN07Mu5cWjNXXJYLte5jsmRfzxRoP11w8d7971HTGT?=
 =?us-ascii?Q?s53kgxuolPY1lVhsF7HA4WS9ZZmXOaLgWiigPM8kXcdA4yAB8Cmf7uPgbl8o?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 997ef8ab-e0bc-4c69-b1f4-08dd60b46d9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 15:50:20.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/3zB9k9mIM6jfn18SMFUJOozs1ajxk/BS7zDAhxHPAb4g9R50pHM8fAJfsUweGAK7fGE84smYkLoB0d/gf7js86IofWwkwdpeTMoAKeuCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com

On Wed, Mar 05, 2025 at 05:21:30PM +0100, Alexander Lobakin wrote:
> Use libeth XDP infra to support running XDP program on Rx polling.
> This includes all of the possible verdicts/actions.
> XDP Tx queues are cleaned only in "lazy" mode when there are less than
> 1/4 free descriptors left on the ring. libeth helper macros to define
> driver-specific XDP functions make sure the compiler could uninline
> them when needed.
> Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
> applicable. It really gives some good boosts and code size reduction
> on x86_64.
> 
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |   4 +-
>  drivers/net/ethernet/intel/idpf/xdp.h       | 100 ++++++++++++-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c  |   2 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c |  23 +--
>  drivers/net/ethernet/intel/idpf/xdp.c       | 155 +++++++++++++++++++-
>  5 files changed, 264 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index e36c55baf23f..5d62074c94b1 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -684,8 +684,8 @@ struct idpf_tx_queue {
>  	__cacheline_group_end_aligned(read_mostly);
>  
>  	__cacheline_group_begin_aligned(read_write);
> -	u16 next_to_use;
> -	u16 next_to_clean;
> +	u32 next_to_use;
> +	u32 next_to_clean;
>  
>  	union {
>  		struct {
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
> index a72a7638a6ea..fde85528a315 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.h
> +++ b/drivers/net/ethernet/intel/idpf/xdp.h
> @@ -4,12 +4,9 @@
>  #ifndef _IDPF_XDP_H_
>  #define _IDPF_XDP_H_
>  
> -#include <linux/types.h>
> +#include <net/libeth/xdp.h>
>  
> -struct bpf_prog;
> -struct idpf_vport;
> -struct net_device;
> -struct netdev_bpf;
> +#include "idpf_txrx.h"
>  
>  int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport);
>  void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport);
> @@ -19,6 +16,99 @@ void idpf_copy_xdp_prog_to_qs(const struct idpf_vport *vport,
>  int idpf_vport_xdpq_get(const struct idpf_vport *vport);
>  void idpf_vport_xdpq_put(const struct idpf_vport *vport);
>  
> +bool idpf_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags);
> +
> +/**
> + * idpf_xdp_tx_xmit - produce a single HW Tx descriptor out of XDP desc
> + * @desc: XDP descriptor to pull the DMA address and length from
> + * @i: descriptor index on the queue to fill
> + * @sq: XDP queue to produce the HW Tx descriptor on
> + * @priv: &xsk_tx_metadata_ops on XSk xmit or %NULL
> + */
> +static inline void idpf_xdp_tx_xmit(struct libeth_xdp_tx_desc desc, u32 i,
> +				    const struct libeth_xdpsq *sq, u64 priv)
> +{
> +	struct idpf_flex_tx_desc *tx_desc = sq->descs;
> +	u32 cmd;
> +
> +	cmd = FIELD_PREP(IDPF_FLEX_TXD_QW1_DTYPE_M,
> +			 IDPF_TX_DESC_DTYPE_FLEX_L2TAG1_L2TAG2);
> +	if (desc.flags & LIBETH_XDP_TX_LAST)
> +		cmd |= FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M,
> +				  IDPF_TX_DESC_CMD_EOP);
> +	if (priv && (desc.flags & LIBETH_XDP_TX_CSUM))
> +		cmd |= FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M,
> +				  IDPF_TX_FLEX_DESC_CMD_CS_EN);
> +
> +	tx_desc = &tx_desc[i];
> +	tx_desc->buf_addr = cpu_to_le64(desc.addr);
> +#ifdef __LIBETH_WORD_ACCESS
> +	*(u64 *)&tx_desc->qw1 = ((u64)desc.len << 48) | cmd;
> +#else
> +	tx_desc->qw1.buf_size = cpu_to_le16(desc.len);
> +	tx_desc->qw1.cmd_dtype = cpu_to_le16(cmd);
> +#endif
> +}
> +
> +/**
> + * idpf_set_rs_bit - set RS bit on last produced descriptor
> + * @xdpq: XDP queue to produce the HW Tx descriptors on
> + */
> +static inline void idpf_set_rs_bit(const struct idpf_tx_queue *xdpq)
> +{
> +	u32 ntu, cmd;
> +
> +	ntu = xdpq->next_to_use;
> +	if (unlikely(!ntu))
> +		ntu = xdpq->desc_count;
> +
> +	cmd = FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M, IDPF_TX_DESC_CMD_RS);
> +#ifdef __LIBETH_WORD_ACCESS
> +	*(u64 *)&xdpq->flex_tx[ntu - 1].q.qw1 |= cmd;
> +#else
> +	xdpq->flex_tx[ntu - 1].q.qw1.cmd_dtype |= cpu_to_le16(cmd);
> +#endif
> +}
> +
> +/**
> + * idpf_xdpq_update_tail - update the XDP Tx queue tail register
> + * @xdpq: XDP Tx queue
> + */
> +static inline void idpf_xdpq_update_tail(const struct idpf_tx_queue *xdpq)
> +{
> +	dma_wmb();
> +	writel_relaxed(xdpq->next_to_use, xdpq->tail);
> +}
> +
> +/**
> + * idpf_xdp_tx_finalize - Update RS bit and bump XDP Tx tail
> + * @_xdpq: XDP Tx queue
> + * @sent: whether any frames were sent
> + * @flush: whether to update RS bit and the tail register
> + *
> + * This function bumps XDP Tx tail and should be called when a batch of packets
> + * has been processed in the napi loop.
> + */
> +static inline void idpf_xdp_tx_finalize(void *_xdpq, bool sent, bool flush)
> +{
> +	struct idpf_tx_queue *xdpq = _xdpq;
> +
> +	if ((!flush || unlikely(!sent)) &&
> +	    likely(xdpq->desc_count != xdpq->pending))
> +		return;
> +
> +	libeth_xdpsq_lock(&xdpq->xdp_lock);
> +
> +	idpf_set_rs_bit(xdpq);
> +	idpf_xdpq_update_tail(xdpq);
> +
> +	libeth_xdpsq_queue_timer(xdpq->timer);
> +
> +	libeth_xdpsq_unlock(&xdpq->xdp_lock);
> +}
> +
> +void idpf_xdp_set_features(const struct idpf_vport *vport);
> +
>  int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
>  
>  #endif /* _IDPF_XDP_H_ */
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 84ca8c08bd56..2d1efcb854be 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -814,6 +814,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>  	netdev->features |= dflt_features;
>  	netdev->hw_features |= dflt_features | offloads;
>  	netdev->hw_enc_features |= dflt_features | offloads;
> +	idpf_xdp_set_features(vport);
> +
>  	idpf_set_ethtool_ops(netdev);
>  	netif_set_affinity_auto(netdev);
>  	SET_NETDEV_DEV(netdev, &adapter->pdev->dev);
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index f25c50d8947b..cddcc5fc291f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (C) 2023 Intel Corporation */
>  
> -#include <net/libeth/xdp.h>
> -
>  #include "idpf.h"
>  #include "idpf_virtchnl.h"
>  #include "xdp.h"
> @@ -3247,14 +3245,12 @@ static bool idpf_rx_process_skb_fields(struct sk_buff *skb,
>  	return !__idpf_rx_process_skb_fields(rxq, skb, xdp->desc);
>  }
>  
> -static void
> -idpf_xdp_run_pass(struct libeth_xdp_buff *xdp, struct napi_struct *napi,
> -		  struct libeth_rq_napi_stats *ss,
> -		  const struct virtchnl2_rx_flex_desc_adv_nic_3 *desc)
> -{
> -	libeth_xdp_run_pass(xdp, NULL, napi, ss, desc, NULL,
> -			    idpf_rx_process_skb_fields);
> -}
> +LIBETH_XDP_DEFINE_START();
> +LIBETH_XDP_DEFINE_RUN(static idpf_xdp_run_pass, idpf_xdp_run_prog,
> +		      idpf_xdp_tx_flush_bulk, idpf_rx_process_skb_fields);
> +LIBETH_XDP_DEFINE_FINALIZE(static idpf_xdp_finalize_rx, idpf_xdp_tx_flush_bulk,
> +			   idpf_xdp_tx_finalize);
> +LIBETH_XDP_DEFINE_END();
>  
>  /**
>   * idpf_rx_hsplit_wa - handle header buffer overflows and split errors
> @@ -3338,9 +3334,12 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>  {
>  	struct idpf_buf_queue *rx_bufq = NULL;
>  	struct libeth_rq_napi_stats rs = { };
> +	struct libeth_xdp_tx_bulk bq;
>  	LIBETH_XDP_ONSTACK_BUFF(xdp);
>  	u16 ntc = rxq->next_to_clean;
>  
> +	libeth_xdp_tx_init_bulk(&bq, rxq->xdp_prog, rxq->xdp_rxq.dev,
> +				rxq->xdpqs, rxq->num_xdp_txq);
>  	libeth_xdp_init_buff(xdp, &rxq->xdp, &rxq->xdp_rxq);
>  
>  	/* Process Rx packets bounded by budget */
> @@ -3435,11 +3434,13 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>  		if (!idpf_rx_splitq_is_eop(rx_desc) || unlikely(!xdp->data))
>  			continue;
>  
> -		idpf_xdp_run_pass(xdp, rxq->napi, &rs, rx_desc);
> +		idpf_xdp_run_pass(xdp, &bq, rxq->napi, &rs, rx_desc);
>  	}
>  
>  	rxq->next_to_clean = ntc;
> +
>  	libeth_xdp_save_buff(&rxq->xdp, xdp);
> +	idpf_xdp_finalize_rx(&bq);
>  
>  	u64_stats_update_begin(&rxq->stats_sync);
>  	u64_stats_add(&rxq->q_stats.packets, rs.packets);
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> index c0322fa7bfee..abf75e840c0a 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (C) 2024 Intel Corporation */
>  
> -#include <net/libeth/xdp.h>
> -
>  #include "idpf.h"
>  #include "idpf_virtchnl.h"
>  #include "xdp.h"
> @@ -143,6 +141,8 @@ void idpf_copy_xdp_prog_to_qs(const struct idpf_vport *vport,
>  	idpf_rxq_for_each(vport, idpf_xdp_rxq_assign_prog, xdp_prog);
>  }
>  
> +static void idpf_xdp_tx_timer(struct work_struct *work);
> +
>  int idpf_vport_xdpq_get(const struct idpf_vport *vport)
>  {
>  	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
> @@ -183,6 +183,8 @@ int idpf_vport_xdpq_get(const struct idpf_vport *vport)
>  
>  		xdpq->timer = timers[i - sqs];
>  		libeth_xdpsq_get(&xdpq->xdp_lock, dev, vport->xdpq_share);
> +		libeth_xdpsq_init_timer(xdpq->timer, xdpq, &xdpq->xdp_lock,
> +					idpf_xdp_tx_timer);
>  
>  		xdpq->pending = 0;
>  		xdpq->xdp_tx = 0;
> @@ -209,6 +211,7 @@ void idpf_vport_xdpq_put(const struct idpf_vport *vport)
>  		if (!idpf_queue_has_clear(XDP, xdpq))
>  			continue;
>  
> +		libeth_xdpsq_deinit_timer(xdpq->timer);
>  		libeth_xdpsq_put(&xdpq->xdp_lock, dev);
>  
>  		kfree(xdpq->timer);
> @@ -216,6 +219,154 @@ void idpf_vport_xdpq_put(const struct idpf_vport *vport)
>  	}
>  }
>  
> +static int
> +idpf_xdp_parse_compl_desc(const struct idpf_splitq_4b_tx_compl_desc *desc,
> +			  bool gen)
> +{
> +	u32 val;
> +
> +#ifdef __LIBETH_WORD_ACCESS
> +	val = *(const u32 *)desc;
> +#else
> +	val = ((u32)le16_to_cpu(desc->q_head_compl_tag.q_head) << 16) |
> +	      le16_to_cpu(desc->qid_comptype_gen);
> +#endif
> +	if (!!(val & IDPF_TXD_COMPLQ_GEN_M) != gen)
> +		return -ENODATA;
> +
> +	if (unlikely((val & GENMASK(IDPF_TXD_COMPLQ_GEN_S - 1, 0)) !=
> +		     FIELD_PREP(IDPF_TXD_COMPLQ_COMPL_TYPE_M,
> +				IDPF_TXD_COMPLT_RS)))
> +		return -EINVAL;
> +
> +	return upper_16_bits(val);
> +}
> +
> +static u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
> +{
> +	struct idpf_compl_queue *cq = xdpsq->complq;
> +	u32 tx_ntc = xdpsq->next_to_clean;
> +	u32 tx_cnt = xdpsq->desc_count;
> +	u32 ntc = cq->next_to_clean;
> +	u32 cnt = cq->desc_count;
> +	u32 done_frames;
> +	bool gen;
> +
> +	gen = idpf_queue_has(GEN_CHK, cq);
> +
> +	for (done_frames = 0; done_frames < budget; ) {
> +		int ret;
> +
> +		ret = idpf_xdp_parse_compl_desc(&cq->comp_4b[ntc], gen);
> +		if (ret >= 0) {
> +			done_frames = ret > tx_ntc ? ret - tx_ntc :
> +						     ret + tx_cnt - tx_ntc;
> +			goto next;
> +		}
> +
> +		switch (ret) {
> +		case -ENODATA:
> +			goto out;
> +		case -EINVAL:
> +			break;
> +		}
> +
> +next:
> +		if (unlikely(++ntc == cnt)) {
> +			ntc = 0;
> +			gen = !gen;
> +			idpf_queue_change(GEN_CHK, cq);
> +		}
> +	}
> +
> +out:
> +	cq->next_to_clean = ntc;
> +
> +	return done_frames;
> +}
> +
> +/**
> + * idpf_clean_xdp_irq - Reclaim a batch of TX resources from completed XDP_TX
> + * @_xdpq: XDP Tx queue
> + * @budget: maximum number of descriptors to clean
> + *
> + * Returns number of cleaned descriptors.
> + */
> +static u32 idpf_clean_xdp_irq(void *_xdpq, u32 budget)
> +{
> +	struct libeth_xdpsq_napi_stats ss = { };
> +	struct idpf_tx_queue *xdpq = _xdpq;
> +	u32 tx_ntc = xdpq->next_to_clean;
> +	u32 tx_cnt = xdpq->desc_count;
> +	struct xdp_frame_bulk bq;
> +	struct libeth_cq_pp cp = {
> +		.dev	= xdpq->dev,
> +		.bq	= &bq,
> +		.xss	= &ss,
> +		.napi	= true,
> +	};
> +	u32 done_frames;
> +
> +	done_frames = idpf_xdpsq_poll(xdpq, budget);

nit: maybe pass {tx_ntc, tx_cnt} to the above?

> +	if (unlikely(!done_frames))
> +		return 0;
> +
> +	xdp_frame_bulk_init(&bq);
> +
> +	for (u32 i = 0; likely(i < done_frames); i++) {
> +		libeth_xdp_complete_tx(&xdpq->tx_buf[tx_ntc], &cp);
> +
> +		if (unlikely(++tx_ntc == tx_cnt))
> +			tx_ntc = 0;
> +	}
> +
> +	xdp_flush_frame_bulk(&bq);
> +
> +	xdpq->next_to_clean = tx_ntc;
> +	xdpq->pending -= done_frames;
> +	xdpq->xdp_tx -= cp.xdp_tx;

not following this variable. __libeth_xdp_complete_tx() decresases
libeth_cq_pp::xdp_tx by libeth_sqe::nr_frags. can you shed more light
what's going on here?

> +
> +	return done_frames;
> +}
> +
> +static u32 idpf_xdp_tx_prep(void *_xdpq, struct libeth_xdpsq *sq)
> +{
> +	struct idpf_tx_queue *xdpq = _xdpq;
> +	u32 free;
> +
> +	libeth_xdpsq_lock(&xdpq->xdp_lock);
> +
> +	free = xdpq->desc_count - xdpq->pending;
> +	if (free <= xdpq->thresh)
> +		free += idpf_clean_xdp_irq(xdpq, xdpq->thresh);
> +
> +	*sq = (struct libeth_xdpsq){

could you have libeth_xdpsq embedded in idpf_tx_queue and avoid that
initialization?

> +		.sqes		= xdpq->tx_buf,
> +		.descs		= xdpq->desc_ring,
> +		.count		= xdpq->desc_count,
> +		.lock		= &xdpq->xdp_lock,
> +		.ntu		= &xdpq->next_to_use,
> +		.pending	= &xdpq->pending,
> +		.xdp_tx		= &xdpq->xdp_tx,
> +	};
> +
> +	return free;
> +}
> +
> +LIBETH_XDP_DEFINE_START();
> +LIBETH_XDP_DEFINE_TIMER(static idpf_xdp_tx_timer, idpf_clean_xdp_irq);
> +LIBETH_XDP_DEFINE_FLUSH_TX(idpf_xdp_tx_flush_bulk, idpf_xdp_tx_prep,
> +			   idpf_xdp_tx_xmit);
> +LIBETH_XDP_DEFINE_END();
> +
> +void idpf_xdp_set_features(const struct idpf_vport *vport)
> +{
> +	if (!idpf_is_queue_model_split(vport->rxq_model))
> +		return;
> +
> +	libeth_xdp_set_features_noredir(vport->netdev);
> +}
> +
>  /**
>   * idpf_xdp_setup_prog - handle XDP program install/remove requests
>   * @vport: vport to configure
> -- 
> 2.48.1
> 

