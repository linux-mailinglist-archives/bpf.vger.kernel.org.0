Return-Path: <bpf+bounces-55473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA8A810F7
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0B8420CC6
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138222C35E;
	Tue,  8 Apr 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ski1nDiF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326422ACEE;
	Tue,  8 Apr 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127636; cv=fail; b=eUDznt+Pq0TCdnaF1b8Mc12vjfHTTFkL0rZoFdg5z4c+opBiHxsYIjvahXPaHBZ0xZsGWTA40TyTRG2Zjy2/le2mYuBP3a4hq3ge+3UdDa0l90EKwW+uEqIYb3mIUyBzFu5zJR9GIuu4e/2wjWjkxGLjFComMo5CPzX6hhKxYco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127636; c=relaxed/simple;
	bh=QKJzSHf5obFkNwvyXHV0brHiWQUQAXhZEJCnwkWcXJk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QU2oF45wmxWf4wIyES5kBGHH1d8i101eFF79UcXl4KeL0NjY3xRHB8F5Vpy0BbCHqezY6aPS7zl1kENRCMcI1molHLVNfEKeN8fgr5cgAUOg+to7tNY+d1UvoniYBEAjevbFSa/2BLqf+lxZGivmRUZsManju9LL5UNLxjZWYpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ski1nDiF; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744127634; x=1775663634;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QKJzSHf5obFkNwvyXHV0brHiWQUQAXhZEJCnwkWcXJk=;
  b=Ski1nDiFKYR5ZnPeDVl8o5IQFSwpr+5yXr3l3FjyyR2uZ+pWBDhSPY52
   GTk8aSfiBRLtwMj9wu2uryhuZ6Zf7EMdGX0TAzvea9IkmUteCFAx+Bd3Z
   Dbc1zExcmSdMVdUTrh8GGW86L6+/Ew8KLncjyEoXuU7HANth6XefVXrlh
   wgN1uzPN8F8Pd2FAczHr6QS/4vTZIwBWNMAsv761HI2eXLNiQeqsUw5HA
   988t7x4znWHIiDbsf2XVpnye7VIC/oDoJl2l0lE+xF59lRIFpL1gQsHnp
   pafP7WVVD8UPPUsPfNkxgWQBKMNAhIFai8iAHkMSXf4zZHRi5jhk2LSar
   Q==;
X-CSE-ConnectionGUID: C2i8CwkIQyiTgH+99/PbGQ==
X-CSE-MsgGUID: 9jXsJs84QPKWfELbQVdRAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45286791"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45286791"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 08:53:53 -0700
X-CSE-ConnectionGUID: I3PdAYXOSG6gvYXx2fPIkA==
X-CSE-MsgGUID: o/G1MaJ3TUGr0Ti35mVU2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133169089"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 08:53:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 08:53:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 08:53:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 08:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2mhpif2rhRBiZFC0v2YMJjY6q9wlYMf1Z1sR3StXXd66+mDfkGlAyRzI0eUhp/RtBIAmMsUEacP8FIvgCnhgrFDn0igQhLcX4OvxJUja8AKCvMKlVc6Gf4+KzCdJ6U0N2yGboe5BDTNaN5BrogEFm3zKrlWejNLELQYC5DWV1YfjMGEFn+WVsg+dNOOVHzNHTlbxWip1gPm1Zu1QQHCsfMckFJOlBEOzpaJpP1WB5cNzR0NTZinQcUNgGWopc9A3lkWr/D30RZZuKYceKqiERHNXJh19shjtG3Xz/PCp+0437O9s816jSe08FtgrnTJPRhPRDnjk9ekc8SynFDGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1+F6CgruPRAgH9nQ1BMgCBQVLhJlzQdacOUc9w2xR8=;
 b=ptytHpRmq26znoC2KygV7p8T5ZoHmG3HidPApZM801mhXGX3MEtoSzEeBt4HJUOgqkG4oXwDqnUa6SfGTkzinCZwSt41jTy2gfwVa98F1uFvyvJZ1/e1Kh7JvGUZdo/hyVBQdDps/8CbI7cDrEJkX9xNcqjMIbNc1ww8R4nP7Xj7Hv5e2KyRK18f3VEGP8hfT2Y3WLSIg81pow6k4NX7sLX1NFDvRfFlx9rjsRikgvWRUF/V0Wr79UYvPgZt8dq2ZAqoFoU4QH7Z5aPQE5fuEHevqGG0bl4L4+J+yVX2Zpmpr7rEbkcTX/OX0kpo3mgc+/7UTxbXoY3R0SX6naS4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 15:53:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 15:53:14 +0000
Date: Tue, 8 Apr 2025 17:53:02 +0200
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
Message-ID: <Z/VGXryCFSRk7zOT@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-15-aleksander.lobakin@intel.com>
 <Z9Bbr9b0WLFQZt4Z@boxer>
 <454272e0-82cf-4f79-be53-a4838dfbbcd7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <454272e0-82cf-4f79-be53-a4838dfbbcd7@intel.com>
X-ClientProxiedBy: DUZPR01CA0292.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 537d2144-d9d9-468d-4917-08dd76b578fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J7oYXDzW33JQRIGCi1CPzS3gxBns1IKkPC1ECOKqSCVejtDsCqidAFfHXBqc?=
 =?us-ascii?Q?7aMMieZo6+pUryHe2idBtjQuW587T99jcCeFdisnVwecpk2r3i4LGG2SsL7/?=
 =?us-ascii?Q?OFVY3XWoBpYOT3cXr6pPLyhQmpsbtGi52MBS4sdesG4Ed7zucYZhKGo9AQvq?=
 =?us-ascii?Q?69v24y1joNZKURP1j4ofI6cBlLzGOi0Udnol+zI4UaHoWz/rW3SJQL/B2uOY?=
 =?us-ascii?Q?nCnWPYSgWDdvFUvMFgFvmKyH1XlbdFStzJkTupbp/sdFzD+fQn1/t+mZL+my?=
 =?us-ascii?Q?HCKiJ/4jV3Ac0mDyNRh5sG3R/n1518XNMCcVUISjVGx8kB/lrGpUkRvbKS6w?=
 =?us-ascii?Q?B/0O+Z5c942Bi4kVWBymOjVHsuxYU8dI0tH5gR0tsFMMeWEj6AMTD3A93vlo?=
 =?us-ascii?Q?np7+KB0202CU5BjBXeXGfMcN1GXDnERWOK44G+BgiVSVV5d3siskFugIHt1i?=
 =?us-ascii?Q?wgY4slhywp87GbRcMScefDMinEvCO4/rH6eAZWgiHLM2s5fQJP7rses8ksIs?=
 =?us-ascii?Q?lotyBlBL2QJPRjweCce5RU6jwCRls/ecRO1PFKuMsvbziyTgaXpvFcPe4ncU?=
 =?us-ascii?Q?GWOUfy5YFRlq+Wns6r1DfT2W6iESei8QKdw25tdqFiQDN2UVeKqXWcnwhRK7?=
 =?us-ascii?Q?zCh8NJbshLgfddfEDoBF2J0R5BSbbvagGzK4Rf2tY0bA/ooeIhhTYQ6xCJkZ?=
 =?us-ascii?Q?Q8DiUfcbDOMiRlAcdqPZtd63BK9JgaGpY1SGqbuekLDreTEEIzqCPJppPqk/?=
 =?us-ascii?Q?2IVNpY4mjUzbgqhQ5xtdoG3peMo6mdfCICDmsN869QQyQYBET3dKOBd6zILC?=
 =?us-ascii?Q?w0e1B4ANi8V6LZFGg0bgLpH2AP1n2iqId43Gig1mZEIMU3acPPb/2CNCV1oA?=
 =?us-ascii?Q?3Im6jV0/cDB6t9miUzvK3lcQwo0NbN3t39z8xOkIXzfl0pdcK81pWXc4kgXG?=
 =?us-ascii?Q?12U0qZMhtn7Zb4EJqUdO78PRLzYicqyz8rC/Wb9hotWb4oDyCrmYMKqRmhd9?=
 =?us-ascii?Q?+z+ozxwIM0Ropy+e8xhWUN1LlVa+tZ6GYXAcLhDAdYrRrFNcr3uM5BSSTu/b?=
 =?us-ascii?Q?oM/EcFv0/Kx1qlh/5ipg67MKlwnkhy2BNrmOzpGMJCruzFU5+frV5ZPfVzvn?=
 =?us-ascii?Q?grGIp//GYXPD/5EYnMRuAjc37UE/JcbHKyi7EsuX0zLiRUxtrMiRwk7/e7B3?=
 =?us-ascii?Q?/ZKPl+WePcwwiz08Nhwbp2bdE/4xo+zjYvbqrqO9tM0o/eZGbeXOjMDVS+EW?=
 =?us-ascii?Q?VThHsQb68huk73jNhqth04TmwyIwgkUOOY5OsMZ7/7IR70uHvf5v1RpOYTyB?=
 =?us-ascii?Q?gNwH5gGAc/ixZ1w6vootJchHWYfFjS3dNFjMdDGA+taj8sSeffhOAZo4CJgP?=
 =?us-ascii?Q?j/3Wg1cR/66Z79FOTa8oLEAXc0F1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jH4F5rANbA9ydHEJCKLfTbO2x0zPkhuAy4VUflZlQk8x9hjvOrmRv5RV0cQr?=
 =?us-ascii?Q?Tg7Hm/upolPNe/SXokM1S3zvdmF9AknNpQRshXOTyr6jTueWdl7hhxHZ87tY?=
 =?us-ascii?Q?vW9HL1/c3ygWrqTZp2ad2Un0rFhsinh9pi0S/Cu71QDaGlFUF2nZGi0vd7PE?=
 =?us-ascii?Q?+zx9F7J6aypJaGqEhuuX45i7RJ8KUBP201jxDVL+WnpL0HMZyZbW+ReSphnI?=
 =?us-ascii?Q?7A9o2aZjDnG7aNcUUBnmQ/enRW5ElSfe5Mp0bj99lIgSJ9giSNjbBomwZWvn?=
 =?us-ascii?Q?yqEVPcIGFskcjzIMyLGpHFoJymvnYfD18DRG36zr61AGIcxMWKFwAjVonXnU?=
 =?us-ascii?Q?HC2dAHVc2nSLgicstEoYrF/RPpHXxEUFMeiCTVLaNSQNEhzREYeU4D0RWUwI?=
 =?us-ascii?Q?ZW79vyVq3oi3C/aml3CwdwnPX9aQw692GWjdNYrUxxeBAh9tT7rCyvJdIrjU?=
 =?us-ascii?Q?riL03TmvQVRJWhx/OSaH3X97P5uk+qp60H3T7SkP7LK0x954PxR/kXmX4Ur2?=
 =?us-ascii?Q?6uAIsxcad9aLT+zkv0BxBKlu7+ArRY0XKTvzbePUmPthiSQK5B8SqCGJAWyE?=
 =?us-ascii?Q?KU5FAdTNqJaSqHzZGJTPXqMxOFYVa3+MiI/oClkZZJhd/xCj3TDVfRA5JvGC?=
 =?us-ascii?Q?pP7nn8PMHeq+3drARCyhm+OsSlAKK0wZa0b2HdCSPOx0pL08ykaryx5Kc77q?=
 =?us-ascii?Q?ktrs4wuwg0SJi4GZL28dpHL7C6yTIqmDZXiswDzgbW8HcxjhInY3cRmWv8Ug?=
 =?us-ascii?Q?GaNfrrClkXooY4FXWyRhadiJQA5CYiY5+kXHBD4e36QjFVbHkMlUTrVkcORC?=
 =?us-ascii?Q?aKbXk8pKFPe0skUBGZ8Df/RXIn7l/0fNUYuESiS4FU9qpUfOQktm3xMhYadH?=
 =?us-ascii?Q?ZzYmo+UmyLC9zi98+Xg39ly8YJeF7VOECTcsvPSNKaAh1eVnIig1c36m825n?=
 =?us-ascii?Q?u7Thf4fTgr2R+Rk43xmfB32q/iBZ+vchGixDoQJ/Lqp/tCq0lPQq2akx7XPL?=
 =?us-ascii?Q?1KBRHrNylciBcMU8xrqamkj2mBOwzq1Fo5UWVwjqmX6Wj1ZxNr0phDQ2sSTK?=
 =?us-ascii?Q?ypSqfIvb2cKD3vuQUJikehv/hRtj582r4DpFI0MZo6ae90oEZDe6lYgVhBE2?=
 =?us-ascii?Q?9wYFTsqLv7TEwKNRUhjb5mEo9mb1zEtCZMkO8f2C+JXMXeQYry/6VzoSk/5w?=
 =?us-ascii?Q?DtpBtrmpV6b1cPRQbeOEPK16KFN+0xBxJaZBuIebgAFBU1ua5u6hFkB45Jdt?=
 =?us-ascii?Q?JEOEsJzJtpXf1HHcwvqjRrESJW+hDVKSpkdfWUDXqe4LDRrk3g9OOK06l6Dt?=
 =?us-ascii?Q?PP5WqqMjmPQrboadXwz6AOZYhZduEfukRx1zDCndM5WYKNnfhL9Z1B4u9mNo?=
 =?us-ascii?Q?G7LQGiK873muQ3xtq6bN9Tdt6P04VKJSM/tAoT9YR1Q/M1MpnDHyCQ0t0pAk?=
 =?us-ascii?Q?2LzG+xuizK4bbqwu6DeHeuwOq1MNSg7L5fuPdlIbNuthBUnLYIAHRxPXrzXK?=
 =?us-ascii?Q?tEaSma5br+tC6WULkjQWlAPp0hKorpR15791u7zfBaWpEU1Ra7cNB0Rd/9uh?=
 =?us-ascii?Q?EOpLMg0mwaQQnJQom6n8oqF6nGUEz+WQlOUX1O7IC1wo69a5JM3eYmUey5OX?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 537d2144-d9d9-468d-4917-08dd76b578fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:53:14.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UawQc5tutAM1GYeqIyZ52giAE8qHLwc6bu86sWfeOU1RWCfc9DIpLam7PFo6K6tdXGjzpWmyMBbDLmQ+inT1lUzLCSlY7yU5h0QiGdpAeAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 03:28:21PM +0200, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Tue, 11 Mar 2025 16:50:07 +0100
> 
> > On Wed, Mar 05, 2025 at 05:21:30PM +0100, Alexander Lobakin wrote:
> >> Use libeth XDP infra to support running XDP program on Rx polling.
> >> This includes all of the possible verdicts/actions.
> >> XDP Tx queues are cleaned only in "lazy" mode when there are less than
> >> 1/4 free descriptors left on the ring. libeth helper macros to define
> >> driver-specific XDP functions make sure the compiler could uninline
> >> them when needed.
> 
> [...]
> 
> >> +/**
> >> + * idpf_clean_xdp_irq - Reclaim a batch of TX resources from completed XDP_TX
> >> + * @_xdpq: XDP Tx queue
> >> + * @budget: maximum number of descriptors to clean
> >> + *
> >> + * Returns number of cleaned descriptors.
> >> + */
> >> +static u32 idpf_clean_xdp_irq(void *_xdpq, u32 budget)
> >> +{
> >> +	struct libeth_xdpsq_napi_stats ss = { };
> >> +	struct idpf_tx_queue *xdpq = _xdpq;
> >> +	u32 tx_ntc = xdpq->next_to_clean;
> >> +	u32 tx_cnt = xdpq->desc_count;
> >> +	struct xdp_frame_bulk bq;
> >> +	struct libeth_cq_pp cp = {
> >> +		.dev	= xdpq->dev,
> >> +		.bq	= &bq,
> >> +		.xss	= &ss,
> >> +		.napi	= true,
> >> +	};
> >> +	u32 done_frames;
> >> +
> >> +	done_frames = idpf_xdpsq_poll(xdpq, budget);
> > 
> > nit: maybe pass {tx_ntc, tx_cnt} to the above?
> 
> Not folloween... =\

you deref ::next_to_clean and ::desc_count again in idpf_xdpsq_poll() and
you have them derefd here in local vars already so i was just suggesting
to maybe pass them as args but not a big deal

> 
> > 
> >> +	if (unlikely(!done_frames))
> >> +		return 0;
> >> +
> >> +	xdp_frame_bulk_init(&bq);
> >> +
> >> +	for (u32 i = 0; likely(i < done_frames); i++) {
> >> +		libeth_xdp_complete_tx(&xdpq->tx_buf[tx_ntc], &cp);
> >> +
> >> +		if (unlikely(++tx_ntc == tx_cnt))
> >> +			tx_ntc = 0;
> >> +	}
> >> +
> >> +	xdp_flush_frame_bulk(&bq);
> >> +
> >> +	xdpq->next_to_clean = tx_ntc;
> >> +	xdpq->pending -= done_frames;
> >> +	xdpq->xdp_tx -= cp.xdp_tx;
> > 
> > not following this variable. __libeth_xdp_complete_tx() decresases
> > libeth_cq_pp::xdp_tx by libeth_sqe::nr_frags. can you shed more light
> > what's going on here?
> 
> libeth_sqe::nr_frags is not the same as skb_shared_info::nr_frags, it
> equals to 1 when there's only 1 fragment.
> Basically, xdp_tx field is the number of pending XDP-non-XSk
> descriptors. When it's zero, we don't traverse Tx descriptors at all
> on XSk completion (thx to splitq).
> 
> > 
> >> +
> >> +	return done_frames;
> >> +}
> >> +

