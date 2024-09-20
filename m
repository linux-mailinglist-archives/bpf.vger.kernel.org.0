Return-Path: <bpf+bounces-40133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE7897D5F1
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 15:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20078B2106F
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 13:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8071607A4;
	Fri, 20 Sep 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqq/clcq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E613D52A;
	Fri, 20 Sep 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837507; cv=fail; b=BjLnZolHdDvAJFF/ofCElK77H6L68d4ZTxo9S3ySEukSBleC450BjqO5RDVPrJ2cYuhbCK5Z4OO3OXia/vmahpbTo64wTObbMat0nD+usRJIX4s1gGnC/VoVfOoUA/Qe1RjPFskmV1un9M5hbPE9d4UaD+HrrjedC1XJU2ysC4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837507; c=relaxed/simple;
	bh=AbSrNRTm2FRCuumCIaXy77Al6hr2nHERWljMqGHWbek=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aYBNXqTUiVZyf5xaXUB64RBdZ6/35zNY5N7HS6mUx1pI+13TRYoE6NxThnAzwRYSHybcRyhKnQdUoLVlLKZ6NLPgJGQITw7W+GASddXf5HCFuh2xUiQPzT79lAKaAxAwf7nXiqghMqV0jQyttrhnljG0SQHt1vCJzLK4eozQGVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqq/clcq; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726837505; x=1758373505;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AbSrNRTm2FRCuumCIaXy77Al6hr2nHERWljMqGHWbek=;
  b=dqq/clcqy6ASqAFRIDOztk2RSCNU+j5F0p+RE3Wd83PxdIr2o6LmNBLW
   tWjOjfgV+wKv0ZNPR/6fxB82vlEznvIGrBRK5MO/HKnqarguU3j8OsFZ/
   RsnP07sObB9ojLsAhU9aDh55vbDmMNeGBYnT/gnL++ydYpRMQ7ip2vp53
   V4y0uSOzdMMUxUzmMVr32YcZea1qGCLyLGIsYbVXDAsY7DDbBQvWEdYtb
   aXdGvpulvY6FAyPjGKu0y7Mz6SQ6xDVhk18TaOKNpOvnk5urLMwwF2wNh
   zF0aaLyGUp4OfxumslkA69WVfNpjoq67tgcyhVJFKDw6WYIAPSag23i3Z
   g==;
X-CSE-ConnectionGUID: eEhALF6oQce7Y7YN1w02CA==
X-CSE-MsgGUID: Go9MxSgcSHGAuAL9HRZ9Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="51260582"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="51260582"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 06:05:04 -0700
X-CSE-ConnectionGUID: GA6Cy5D+QVGOr18cHMSHig==
X-CSE-MsgGUID: /nQGrRQ5Q/m7DODLRkMafQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70423134"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 06:05:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 06:05:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 06:05:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 06:05:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 06:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXP9ufSalS5k/RQz61YCBAEIMmS1Z43KJ23IWrHsALQ8LVZCnQ6NFje5eO6zX3ip0Nqw6cUOTOXscspxSYyixB3lL1fc+qtvlslCi82XgWAlrU9ONsucr87WpFHwwxWJ+szVD2734Z4pWEBZwy03EJOvUJgELpFeHXBFLOZW7OiM3CICU4VrvxweO2zqBZ7ruLADKS/jjACJzNnymIWJdnq6fhYEc/zYNQIQk8VOGF7YqH9ytO5Q/fhhflQNseB4oG206zNSasKaW36/E/IPBdYAQ7Q6zZ+NBOi0DxSLpX84VL0MbGpeDaNXOSaemhCo69roPf3yBIefe/hDP53B9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbf5dcXdXAT10J0uKa9jXe5hUmszpUyzdqaZcZrYz4o=;
 b=XE+K3DKR+6vpneOkDGBR3+mIeAGVVTBXFr+fBAIM2BfpflSX2a0tqoMnl3pb2NsuFJeAg21IVbb6k0WMPRD85wI1e2qaL1XaJrlKmGSYkIrlNkdy9wyA9A7C1zVcCQObV2zhVPCNWax8G49lnolC3MhsvAyoof/gj/R3aQnD4Fahmez8UcGXGAcSMgbgBncmc9Ekqt50HHkRWV2wtRbFXoBqu6XAu5vcWFccq/bdM5vqFslglzhznuSQKq+NPaKvuz45p5Cb4gfgXaBih6J2tZgTrzX5PQVvYIQmdrx3J+YKCCTLojbcIuZvSihtP6g9c/tndESyD0DQJsmqqLBGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.21; Fri, 20 Sep 2024 13:05:01 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:05:01 +0000
Date: Fri, 20 Sep 2024 15:04:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <stable@vger.kernel.org>,
	<imx@lists.linux.dev>
Subject: Re: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Message-ID: <Zu1y8DNQWdYI38VA@boxer>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240919084104.661180-4-wei.fang@nxp.com>
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c36ce0-231a-4730-51f9-08dcd974d5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RhdEWGfp8z1Z/LFBojr4Qp18jXnKp8BDEY+DE0Z8SFArC3bIkkWYE0iYrpJi?=
 =?us-ascii?Q?cQdXhjTNtxh5kJPlf8yxD68Hmgp0WHHL8jEel45DVw4Nkk5qWllzOh67N+j3?=
 =?us-ascii?Q?30x5ZLC3Rm+zC6RDBzRJIVBEkvpj4lPMwTUCJkpMIXrZtWPilmdjXCH+Lci4?=
 =?us-ascii?Q?EGv/f3Mq2dOqE5Ct/zpK8wmKOQ5x6VFRI0ZAH9IKTBVVfmmviuJOCwtChbMX?=
 =?us-ascii?Q?BgNhUY96LKrNN1p+r2/Qn9aMvWztaQWrtgu1lavv4Lnz9JPkZAJow1UQAM7v?=
 =?us-ascii?Q?yLguoZeDeEsgLjk46ZewkCjZXyj72c/mMP/JEG8/kzKlADPUdGjaESQQ9ShX?=
 =?us-ascii?Q?o5EdXuK7uz63Nzs6h13V5+FzWKerah5RnwXbh50qphwE0oQWPEmJyIhu5w8u?=
 =?us-ascii?Q?ptP513fXNuY3huX790D4Ff1fYPFrsb8VL9eXWug7ta7HobUOhlN5iNa7CnMA?=
 =?us-ascii?Q?09V7llTGk+52UkoNsMr6SSznytj4c86QpKdKmvyKh0Bw6HDEm7r45VM2f4i7?=
 =?us-ascii?Q?dYn/Zt2/80cSKqEB0ZITLWuNY+zZfkdnIRykVDHz2x95O9ZBFjRsooE01X4Z?=
 =?us-ascii?Q?AogwKQm7Z5UceTmiUQVi0IYWO+8//9A6xaesHgFVprd8RuQL1XZXH1NPMMZ3?=
 =?us-ascii?Q?rcJfsIEkrvvEANymzkIq04VGpu2LgSxDec/sbMWoyUWLTmh+gq0cd+NcPbTZ?=
 =?us-ascii?Q?RuXljF1Mvf0XoaZ4VceUdwYbHsuNnyQTFYpSwtXDKpSLZhMm3G1WuVNsjsSy?=
 =?us-ascii?Q?hP6kRPZUowk19e1YDMLvhRiij+OL/aqa9bHvaDhAQKhN5QNzgFo+eoImrAqJ?=
 =?us-ascii?Q?I2D9ws9NFpwaPjflkc+Nq+R36CTnYlu55Sptsik7FI5swFgFi6E+KwUxzuQg?=
 =?us-ascii?Q?S1UiTdySMkPeOeMeMLuErURYEXJ5H+EKUgjn7xg4bBLhx9T0vXCEcZhb3W8q?=
 =?us-ascii?Q?Ywk7kZVP1VbqqNgdvCN/4IXU+GoJBIZPXzVKG+g/9wFOdvB7cZBohbFjGdyX?=
 =?us-ascii?Q?MkgSHxBYdRHxqYM9kLGA3YYpssnmweXYt6B0n/R5RzZUXV2KQn7N3v0/p893?=
 =?us-ascii?Q?kwU7g2UltMlPcArir3Lmu21lMXuyUJHRaHNlb9B5iGfctZSCRnyDWKgsODuM?=
 =?us-ascii?Q?6uLIsDvtb1w40ST39Y/UPQVU9wIMtBXOcBXBnnyrl00hrNEZX9WzuwQC0dlv?=
 =?us-ascii?Q?iH+GsV8PktPjkwtBnUdqzUSr0B7tAVVBGXk8JqJBZmRY8IpurLe39p7SethQ?=
 =?us-ascii?Q?IMRfmGiEkw33bblRnO0nXMAylL8rHI6P3ypNCg4CA7MQwpUzw4gtDR4RqiG0?=
 =?us-ascii?Q?k+RmsHfqh5eGjAIBmYmfw3X9wh64AuvZABjJFoUMG1OB9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L2yzhPVkV/U0A7/5C+oH6IH1IaXjTSKeinea2Ywmai1m33EEgCXvLBQMFbul?=
 =?us-ascii?Q?fsDT60Saap+QJXXXiExChuO1+RcT7ILGim6ac0mlNuhMUOerAba0JJCGyO23?=
 =?us-ascii?Q?G3WMlWYPcPaZsqzE7yP8YU5knaW+ZyvwU7d/yXb2hRvDdPRmAlUUOyWtGDG6?=
 =?us-ascii?Q?HSFZZUGXUd36cOQhT6N9s/HmwnhDd2fgOzLmZ6ANHsV2aXE42PiL2WLBpxSn?=
 =?us-ascii?Q?4IFPRZq1m5bj3+eBlI8Ss4FBae0XKzeGujR7tLS6yDqQ9C9Hb0zHATAaLeDX?=
 =?us-ascii?Q?OZm3po1qpMyTZigf8MYJAzSnYwaVMvNNTwIQTp0Mqiy/4j9H0f7X8VeYVMtI?=
 =?us-ascii?Q?DaOzWQci/ydfeelJpHI3/qgZfL5581cy9PYLG38ndrv0LvlwcliwgmYTIvDP?=
 =?us-ascii?Q?BdcLeAFa8JE9+08R02N69Et0kqRPZlNn/Awv+ifmqzH8w7WUFeUKB63a3jus?=
 =?us-ascii?Q?muw0T1BfVhLhwu1V2W1bY7Q7t62IhAVUj/qY/oRP/a3FMWYUNvdZqBVbR3T+?=
 =?us-ascii?Q?wTpV1Z7s5RAGij+3yQmMzxM/c+0YfMAgeOAC7uA2LcuunB5AQD2cBiTpC+wJ?=
 =?us-ascii?Q?Z7urvWozQBvCgeVKKwnbzvhL7kjnTf7vx26aw3Fg4DqrRz6TngeQSrwP3/t3?=
 =?us-ascii?Q?SmsaFrtDRpMR0y+j25/0pHwk36GAZaZgMWs0gk8abGN58RZ761v4Q2/NpHLd?=
 =?us-ascii?Q?zSLgvabzcLTGnXLtSGrETmO4SluD+iKCTmLxAmBhhW86oBT+xj6Q2sGvgkoj?=
 =?us-ascii?Q?lLQw7lULiEK++h2TsQVlnfkk9Ts3vNpQ11J5j3bL2WS0aCXfhkq1Iz5dsvFa?=
 =?us-ascii?Q?jFdyV+DqrIjUPPVPgNozT+uXBa/i3CZ/TvZ7F6IKY3xm8+UYup51sqq/iGUI?=
 =?us-ascii?Q?OVtSt79JFfg83XnY//uB4XaJbLAIZZFjKxnWmpKHHLV1yi9mcUZurNiy2vRl?=
 =?us-ascii?Q?itaArK07loqqDuCOjL3jTNA1EDc0K1yajPXpamgHgbpmQm5G3DZdVMhOZtF9?=
 =?us-ascii?Q?Ik8flEWCuXQil9LID7MJ6i4Ch2D6mI4CDKhFYrFKdvAliR+SEBe3PzIjHWGw?=
 =?us-ascii?Q?+t0Z+kZtOnNYGGjnsCiSreR5xYG/j1bsZ9dOln/q1Z1RDc8TQF4tw078o4Wv?=
 =?us-ascii?Q?dj4O3fuPMq05wFlw1V4duhh/PB5z+/aM9z8WbubcrV2WUu9by3q6yDtktBaB?=
 =?us-ascii?Q?asA0srC8fNIS6mxs1PJr0JXs+G9nB1hBCJ1xJiqH/kDkfCCl3EAx3vicMHN1?=
 =?us-ascii?Q?SJQruUbwfd+9vKrmVcxZIpd+HPfJpPblAxQwac/UHS1/BOeLgByHhHP8lya6?=
 =?us-ascii?Q?vqia2yMswn0s/tBNhdNZnJGF27VuwEOGsQBXkEUvuAjjqnvW3+/ssO5xQj//?=
 =?us-ascii?Q?zugIhS8nFa12vphjcUrdUcmFrpDRLCXlmWm9nrevHhQCp+2P4J+C2FMHShGb?=
 =?us-ascii?Q?26YNX0bHMWLKslLq9FkvgKyEkEh55TCRmTg5SEElyuO/IPyxn1xkMkHMFqf0?=
 =?us-ascii?Q?c04JFzRon+Rq0qu6kuExKS24PJV6ILLvLRruYoiuOCL8VPEQ5mbqfMZJblgB?=
 =?us-ascii?Q?M2dxHGyt7Bg8Hxz5pMJrlAwAGM87pPoNIvhm0SFK1t1hU5JQdyb6VsWUyqbS?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c36ce0-231a-4730-51f9-08dcd974d5ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:05:00.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OT6OoSUlQyzVb4mAyMaZJTLNKgRIGfQcrd7rav3aAS2jCLscbzb7QyBFqj5lwDFo5sAZXuypGtAX0M/t4V5vF46kVO4nhFs6EUb7tCjSxYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

On Thu, Sep 19, 2024 at 04:41:04PM +0800, Wei Fang wrote:
> When running "xdp-bench tx eno0" to test the XDP_TX feature of ENETC
> on LS1028A, it was found that if the command was re-run multiple times,
> Rx could not receive the frames, and the result of xdo-bench showed
> that the rx rate was 0.
> 
> root@ls1028ardb:~# ./xdp-bench tx eno0
> Hairpinning (XDP_TX) packets on eno0 (ifindex 3; driver fsl_enetc)
> Summary                      2046 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> 
> By observing the Rx PIR and CIR registers, we found that CIR is always
> equal to 0x7FF and PIR is always 0x7FE, which means that the Rx ring
> is full and can no longer accommodate other Rx frames. Therefore, it
> is obvious that the RX BD ring has not been cleaned up.
> 
> Further analysis of the code revealed that the Rx BD ring will only
> be cleaned if the "cleaned_cnt > xdp_tx_in_flight" condition is met.
> Therefore, some debug logs were added to the driver and the current
> values of cleaned_cnt and xdp_tx_in_flight were printed when the Rx
> BD ring was full. The logs are as follows.
> 
> [  178.762419] [XDP TX] >> cleaned_cnt:1728, xdp_tx_in_flight:2140
> [  178.771387] [XDP TX] >> cleaned_cnt:1941, xdp_tx_in_flight:2110
> [  178.776058] [XDP TX] >> cleaned_cnt:1792, xdp_tx_in_flight:2110
> 
> From the results, we can see that the maximum value of xdp_tx_in_flight
> has reached 2140. However, the size of the Rx BD ring is only 2048. This
> is incredible, so checked the code again and found that the driver did
> not reset xdp_tx_in_flight when installing or uninstalling bpf program,
> resulting in xdp_tx_in_flight still retaining the value after the last
> command was run.
> 
> Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 5830c046cb7d..3cff76923ab9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2769,6 +2769,7 @@ static int enetc_reconfigure_xdp_cb(struct enetc_ndev_priv *priv, void *ctx)
>  	for (i = 0; i < priv->num_rx_rings; i++) {
>  		struct enetc_bdr *rx_ring = priv->rx_ring[i];
>  
> +		rx_ring->xdp.xdp_tx_in_flight = 0;

zero init is good but shouldn't you be draining these buffers when
removing XDP resources at least? what happens with DMA mappings that are
related to these cached buffers?

>  		rx_ring->xdp.prog = prog;
>  
>  		if (prog)
> -- 
> 2.34.1
> 
> 

