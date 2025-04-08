Return-Path: <bpf+bounces-55474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42624A8114A
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03F97B541E
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C9623C8D6;
	Tue,  8 Apr 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b029uuYp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059E23A991
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127948; cv=fail; b=DZvJVJQAWGJFguF+9fFq+CXv4rL9Wb4fIHZk+al5YmqmkMKxOp+bz+h5QkdFShvygXUXNb991oJF3PXPIZNbqdSxO9pb1esCS2fVVt7jgrxeiWSwVYFpBFKYDBl0fVLMRSRDp1vBQVtvTrGU8o0mY8FPbZK5/V4WZQBEuoCFTNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127948; c=relaxed/simple;
	bh=WPo2qPyMR0QFlu0SWZMCql/rPyZQbulQzuBRr/QUCuw=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=OPhqaq1wiPPPiO0KzBxAjPrhWD5o7c/jWY7oz+nza0EFrM8zxiaWSjaF4XS5iU+oJXYcuabWdTBcvHhV0PGL6IbagD0u60hmKtA1i48JytoFqjORnnTF166x/NMtTm2jkj2Hs8jb4SNO3dfK+p6OH2MD0Xm+vB33K+WUBJVvybU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b029uuYp; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744127947; x=1775663947;
  h=date:from:to:subject:message-id:mime-version;
  bh=WPo2qPyMR0QFlu0SWZMCql/rPyZQbulQzuBRr/QUCuw=;
  b=b029uuYp/6RXiTgss5/0oVZCvOcMEniNdRjPYIlRd21HMaR6xfDX4Mf1
   bD+wg44YE4tsxR3/LifSgqYk0dERrwEZIUeRUVYDayCGKil/fNWvIlrVA
   /EKnnPU71i2h3IPHMoCrtPp0pFpc6i5iGO73J6C5TGPRncn6V7ZJPZSeP
   B1iXR30t93TkYQQEQ/7q+X6NwqpCflxC1taTSZDfHY6PCzgah2QE9x1m5
   vENGaMB80CYnQauWO0fA2djfzON/+o99hhFA6ED19e7KS3dpRyldIzp7G
   byxmvpAJR2OtTMI8ogDZDNDp8rCz20phZxymG4p27gXDPGuQl7MO17vwG
   A==;
X-CSE-ConnectionGUID: qVSj+A3WQfCC5rrX3rG9MQ==
X-CSE-MsgGUID: YUOh92xrQ2Gq+90eZir8UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49416454"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="49416454"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 08:59:07 -0700
X-CSE-ConnectionGUID: 7Ntf8DN3QeWL4ROSYmMddA==
X-CSE-MsgGUID: 3DpP6rrMQ2GPtoKlO66I1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="132445450"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 08:59:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 08:59:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 08:59:05 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 08:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCTL3iQk2s/paDSnlgSXt1kA1IF0xHrQUTOe0tFIuY/ghpXOh4BulSB4EooqH8cBB7evA8LCVJzMd4M48mEocdIigL+Bn2SPk4SZnVARZyCkEpYxw/pPqkMkbhKQb9mzrtiMYfsq9T/ftfFU9x3iROj/fNiqdDJ+++2BkseuLAXG/k9/AnX42fnc+bYUnajgdzAklt5KW7TlmjvhLCVl2XdIneUbo0vz2yH2lJN/LzBYn46/FfRZxe/O9dCxpftNYSyXB4U5B+RFzNbk0nGEv+BoH6ekLrJeIT4DfAlqPA8sZHbhX+Pu8MNoWBR3iHikPiCxYcYlm8iV4TLEHPfvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIx0wfWR2POHDuO+z0X1OZnb52N151ikQxyRP0g+4CA=;
 b=WE+zs/JYrCLB45UnVLoVJ9g9YfdPdV9kXeKwua9nwgln5bmEup1UlpQeFYl+6TIT98A+fA9xxv6T+7cWPfl37FxkRqEXq+y6eh212eKsWGu0jYvdTKSRV4Sz8ftwGs4YIOhfB4rGZ/drHuoEaboVEOikHOGMX0lyQYp5AUpm6bIV1G2xDt/gs7vKUqUydCC4hcTJSEmkf8oFeHVP7dpdQcD+w9zCgAEz9Q+5QfbJIQtagG/bhodgAu4sxTDow8j7rpv9utQ4z/vfksR9N32M3V9Y63MqnQhGsm5AUWr8v3UC7XKwQTtKEddQ02z8NXuC+KrSfHhrJWK4gwRHNJRFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 15:58:35 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%6]) with mapi id 15.20.8583.045; Tue, 8 Apr 2025
 15:58:35 +0000
Date: Tue, 8 Apr 2025 11:58:32 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
Subject: [PATCH v2] bpf: fix possible endless loop in BPF map iteration
Message-ID: <Z_VHqKdPYm0DhyRQ@bkammerd-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e5ee2f-069e-4c74-3c28-08dd76b637f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qEd6g+7L8opOzgA/1wkXjvrfUqBsX/9f9Lo3aJ2sv3RKQVwsE/X4eCYtWULF?=
 =?us-ascii?Q?hpO83AG0GCn9Svkyd1EjrAHo0IjWqcHpLl2Rh0wMpaQwEq7GiZ/w5JLFw55C?=
 =?us-ascii?Q?uzYVlFeOYMvVIhRQdAsjdwRAp83mAV2H2mBqVc5buZuYigwhZJnM77YwH5w2?=
 =?us-ascii?Q?4LqhOI0NxMQpSwEWRbDgMnuT95/M53UiAESg3t+/eJaCi6SYjXcHtYGrObaq?=
 =?us-ascii?Q?jbjI+kn9NYKMyJr4nztRmG5N9chXfzPimxoPR1/wJncc30LSMGAFFOeA9G8Y?=
 =?us-ascii?Q?jOJ4qty215nyJVXfkgH0cSgkWDjn2IaS94Qj2Cx952rXesKIoN5q8yPoEIY4?=
 =?us-ascii?Q?R1OERzzyYD6WXAjWe7RrORC4hx7ROVYp6JhAmAojOHeiryA7yB6iKHMKyhvR?=
 =?us-ascii?Q?9rIK8a7V1cYAzCSKT/+SicJ1asyOwGNAxuknAwgVNLSrgh5+nYGJEUzdZxRd?=
 =?us-ascii?Q?+06C72S7xxqjRYA4LtKNdQC84nCyTGutya0G53v9lyCNLuAm2VXFKqEq61VP?=
 =?us-ascii?Q?5nRwI5GBG36An14MX5JE4pYkKO+uJDnSFQCFQlTURWNSn+rCoS96nWXvmDOF?=
 =?us-ascii?Q?kJjyGDBW9AgOmwEih4AuQoa8CWSq+Vg9seEnAHUQ7kTeNwzz09aC+qvO1miF?=
 =?us-ascii?Q?V5apa9ZjGR0KeUph5k2e/Bq8h8Y7gqpKhVO+7f00N+mi1wmkGbaW1IgITBYg?=
 =?us-ascii?Q?yCqMhe3464LCTCwSjr3OnvREsKDNNg+wGxNXRN9eMkbj8o/DOJ/AlfC3Q4mS?=
 =?us-ascii?Q?/WJ/92OwhX559Q451dN9cvyv0vSW62NdtNxVFy+eAWSX5KtYuWBH7Kycxebi?=
 =?us-ascii?Q?bGRvkNwUyR9pxzYtZn3I5qqco78NZ1E1c+YCCBH0/uQwiZU4WBZ6OAAQjTPs?=
 =?us-ascii?Q?d4wYxdAmG/wflHxR7I4Rj4CAMyDDOuGGE+UuC+SgC0+K1LBlaVBtTCYIG+dL?=
 =?us-ascii?Q?cXd6hXnHYyhB6O9KzHfrNsuel3xN1PQZKuFq6ONdR7dO4oC2A/2O/xKxyUdk?=
 =?us-ascii?Q?Tvwi0UOqEj3ozFK3p6Tt6pdOO4gxiX5pr+UH+Q5ZoY2Vg/cP/d7TFfVPTt4l?=
 =?us-ascii?Q?tHHM2qjgtc5aeOUiV8f8XRkyIvkB8DuhQZgoyeKpNMVhtZOQyLVrflzkqSVK?=
 =?us-ascii?Q?li5QluuS5cpckVUE4HpkcmE1s52xy+ZQtJ3EhwKI87O0s/8IpbP0h9j4UdWj?=
 =?us-ascii?Q?EupsauGU0Sb39LzJYYMO3zL3li574iVJ4pvBk8nNfGCgTp1kr8pYRS/30wSe?=
 =?us-ascii?Q?1ovJFs4iO5xJ4DZNhkVLw+Ws6KLn/4cV1LqmbXBT46icSIXH0aeGCDDJCFTa?=
 =?us-ascii?Q?0mPfk3SPKMF5RPR85Ifw3uhRwfggeSFEs25PRONJDa4zI/OzlsU1JibDBw7E?=
 =?us-ascii?Q?0YSPq7+/pi2rpVo8/NeGGr74ES2K+OzTz39tIegYYUMH1vo4swFX5tJokswi?=
 =?us-ascii?Q?j9nnYljRwLk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vRBqxjpPyE5BBbQThk7+z7hSUa//BHgytvlMU4oc9nbmXPHkDSbx3nsVZkma?=
 =?us-ascii?Q?peTCCz9TlvWl2HtlFDdoQmonyAEUOcEFOrX9dF7oLcc33j837++vhaydGLb9?=
 =?us-ascii?Q?mbqULr1jeQvCveE3VBXZgJUsuPpbktIYGwKLLilqgQ9r+vKqXVdriwPvbpAZ?=
 =?us-ascii?Q?MwHHDx0/thmId1B9m7pWHhbSO2/hhTV23XjqzFmZ96WgiKVY8ZZYw6xMBEM/?=
 =?us-ascii?Q?CjQwDDoeOh1w75C2ZGflaoW91XSY260xMp8y/TN45Q0k2Kc38coHlkzjOHt9?=
 =?us-ascii?Q?dowJ1D4R/pEJkz7SZBsjk8UsL/iDI40kuNu8ddq9d1kmTyUlZaUiF1UP/O1k?=
 =?us-ascii?Q?NlZdpT5QxBtIQhgAwNiZthfWRL4REtRfWS2Yhm5VoTeN8dLm8H7NRQM9U6ph?=
 =?us-ascii?Q?qVXH3iDmR1/VvupgHm/sYCiLvIB53zvVqinom5XyleAobwQm2shCb3ZwjD2q?=
 =?us-ascii?Q?RGIdi16Fkkru3AXZH3UD73eQyD7qdgj5RQLO7FYWoUd39u7y1Gv5ID86Oqcg?=
 =?us-ascii?Q?CaqeghjLa1gp8zbCr9Gkpy2ca1c7n4jlUOpXhna84Idt8CBGy83Cuw5eDo7W?=
 =?us-ascii?Q?ibikpRFCtwE2vj+bPoszI1zvMXcvnEmZayQ7WpQ2d/bcoh+DtBkLgNo57uCP?=
 =?us-ascii?Q?G+bbzax2LEoVkQJprQO/wdIdK422mPwRZilhV0YbZTv91bPFSWKhQPwavMx5?=
 =?us-ascii?Q?Vh5I2CKYx8Wa60VpimukhCAisc2yLVN2ufMk5e+SQQj/w7G0WY4xDeJ/4JVp?=
 =?us-ascii?Q?8CQUwNv9B2BXlbWu8+CmKB4J/64ej6Koj15IR0tGG0G3apU9wPGGDmdeXpiR?=
 =?us-ascii?Q?twY+eqURfOZkcKDbWzMad00MZ5oUnD9RC1/5J2kelJd1kYsyi4EKT46eI5FK?=
 =?us-ascii?Q?ISoTAAT/EBQoWTnnslgpo34wUmC5PLaZ+Ek3VXdtoG9ug9nQjKw5i/wiJrhe?=
 =?us-ascii?Q?ORiQ8RByggQBmpIXX6QTc+slcowF2SO4KpY/R1r0Utr2/SfgxjSNAOh+AL1M?=
 =?us-ascii?Q?ZV/PjZtGP2d69yoS7DzpxPvBS9MnjLoSO5gXYJQ8ecTSYC619Xe+TsenXM3M?=
 =?us-ascii?Q?b2QZACfqgvCy+MSXAh6/I4pq+2OhlP5ntVJPiCg0V+H0Yn+9sD8PCLVQe1AA?=
 =?us-ascii?Q?BQP0V+RT+3hlZrPHVfJ13KVppfH6q9NufvuLuMuy6TgMH+cR51wVdnXvF9oO?=
 =?us-ascii?Q?wFT81ZJj3tXfB365c71BsdWPKe7IM6u+s36gELmqFY6+MyO+M+l8xaiRNyAR?=
 =?us-ascii?Q?HD/B41otlBdkvi6cHETYsyoUGIJpisDfoSiMWgZrSrACxdyFejF1R62LOSZ/?=
 =?us-ascii?Q?tw9BAVhx6cvLbq7nBMEODwgo/Xk6JN9vLLeQ4/vPzcCpEGxP0xGeqmRM0cqC?=
 =?us-ascii?Q?MUgnyGiV7Alf6t5k4Rm1z6Q5O2OUyzZKZznzUbYu//rVLsHMfGo3/dIg2y2k?=
 =?us-ascii?Q?sTFSfk65sos/dHxWX7X/ZtdozFs8WkGOVEyUWQeH/KxykHI0ejX1s4ogu72k?=
 =?us-ascii?Q?p0VLJZaGOSOpvnnQl8apUUHC0YceGdB4X+kWEIkxaH8h++NMRqQ2sp89UI1J?=
 =?us-ascii?Q?PkpIF8zNMYH+nd4fkXXmCKVaVVvdibF6ctiUhDt9Em3rndkbyLi/OF6x1Rj6?=
 =?us-ascii?Q?t0kknmph53PsS1sTSll2vsE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e5ee2f-069e-4c74-3c28-08dd76b637f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:58:35.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIfEaiDGFK3Oolt9+dcSpnDcuyRJW0aipWStLPSs06u1qXGbxIjGBQTsLDI6o/wnNW8vUVo5k6sqpm28LdVqG+7aKo0RD1Dt6f2sVRTf0V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
X-OriginatorOrg: intel.com

This patch fixes an endless loop condition that can occur in
bpf_for_each_hash_elem, causing the core to softlock. My understanding is
that a combination of RCU list deletion and insertion introduces the new
element after the iteration cursor and that there is a chance that an RCU
reader may in fact use this new element in iteration. The patch uses a
_safe variant of the macro which gets the next element to iterate before
executing the loop body for the current element. The following simple BPF
program can be used to reproduce the issue (v1 typos fixed):

    #include "vmlinux.h"
    #include <bpf/bpf_helpers.h>
    #include <bpf/bpf_tracing.h>

    #define N (64)

    struct {
        __uint(type,        BPF_MAP_TYPE_HASH);
        __uint(max_entries, N);
        __type(key,         __u64);
        __type(value,       __u64);
    } map SEC(".maps");

    static int cb(struct bpf_map *map, __u64 *key, __u64 *value, void *arg) {
        bpf_map_delete_elem(map, key);
        bpf_map_update_elem(map, key, value, 0);
        return 0;
    }

    SEC("uprobe//proc/self/exe:test")
    int BPF_PROG(test) {
        __u64 i;

        bpf_for(i, 0, N) {
            bpf_map_update_elem(&map, &i, &i, 0);
        }

        bpf_for_each_map_elem(&map, cb, NULL, 0);

        return 0;
    }

    char LICENSE[] SEC("license") = "GPL";

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>

---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a9eeb7aef85..43574b0495c3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2224,7 +2224,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
                b = &htab->buckets[i];
                rcu_read_lock();
                head = &b->head;
-               hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+               hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
                        key = elem->key;
                        if (is_percpu) {
                                /* current cpu value for percpu map */
--
2.48.1

