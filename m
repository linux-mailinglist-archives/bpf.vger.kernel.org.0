Return-Path: <bpf+bounces-61510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FEEAE809C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 13:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262C5189ED7B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B92BDC2E;
	Wed, 25 Jun 2025 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuxzGbvl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE201E1C3F;
	Wed, 25 Jun 2025 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849774; cv=fail; b=dwWG6owx+0Rrzd5Kgl2whjKU1SVw9diFGhCJ2SpN5V8lmf+XhrxPuqbDNwFgXZB9totcUfrhFZ+utZhG6nAEauUBJCiE7WDZtUzmnQFTgInMXXgtLnV1eHSCCaHvImrXtCNdinfll9n2r9/UVAMUxwv+pti1tbWshge9tZnvOps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849774; c=relaxed/simple;
	bh=PekJ9kMNUqPmV6TRkxfkWvbWeRyJUP33PWPttgbWU5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N339W2Jt/JlR6kkBAiq4nR6HQuDDyKyk8Fa56znzassMq4AMK9Y68Q7BLrVHGHnLAtG2RUv0KpEJ6bDXgbqhGkyUBnaLvvsY1wsXiHDi3qgKraap8Ehu9NZjW6VX0JQGklUs/TARC7H9aGjszvrQFTo5Gyvqq/cMdy9f/yfJhYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuxzGbvl; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750849773; x=1782385773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PekJ9kMNUqPmV6TRkxfkWvbWeRyJUP33PWPttgbWU5I=;
  b=OuxzGbvlu8hvTIusm+RagxXfd0EFRIt5QD+6819uRrxEiCbo1+TDiTAr
   NNnog2S5dBMfgNq74UNiuPN4dcNiuPpAH0jZXKhXcOHkuriVb//njs06L
   7OTWxiLfVU9mZC3nCV4go8yOvT30earT9Sj6vGOLK8crkTZBWDHM6C9hy
   7xhNVq6OXRDKv5RHmJre7NYbwUw1hA3AN57QHYJDNqSjvPj/NfJKuWjn5
   2odapFp/3shuZ40dQfrM6+2tMpiFxfvEIje0zlIuaokQVx52ccoHjzJ3C
   H7c18vKAIPsDYsrND5f1CnW1z+VagVwlUdmpxMuSc+TMC3xptur+1cCbz
   w==;
X-CSE-ConnectionGUID: 06lc8RxfSNSicx/upFt2Rw==
X-CSE-MsgGUID: om8W/WqQSWe0uOLmaCXgQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70547026"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="70547026"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:09:28 -0700
X-CSE-ConnectionGUID: oO5JCuoKQLO4Ixy8mKtDuQ==
X-CSE-MsgGUID: tnO1WyccTrqiUr2cUi6oLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151609846"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:09:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:09:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 04:09:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:09:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4BkiGHUpBof3C77BeDLAIXngkureclPQZtuUdoD28kWlSkkSkFGBsfEWOvvgj9ijBeyNRSPav1CeqVU/hty3jX2GlB+dy9ArpZgSOVGzraDf2GsMNh3t8HolC9EdnDoMXgclPJDpMzZU2UkIn5Ke+Cc+myfMpxsW6l/wb2a9fezK8cVzR+E4kN+Sm8d3ABMDI5oKHXgFbtwwWj7o4MQ4J+ujeXquk2kdIDXM+2a7NLjAK3NEWyeVUzXPFzG/0F2QRtgV5k3ZGsf4vo0HKzUK9I89GOv9viw+36wR6M5SEf7ztD1LW7X5xjCTGpaGr1VC/ZFtibQZWYjckcQRVRKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6BKvhNIb3NldMlS1zFQjr17Ir3RQFhknBy9WbXFEao=;
 b=HARWntYv7gdFkflXa0iDCvGdkRArn5Vtk3d4dhH3ZqmDDT4Humh58QlVFTmewW/iboFAC/B+LBH/2O66VzdM00vPDMcsxqfTwd6+3fBR10slXo+J3LKF4T1ckAk1GruABG9ahjf7N7UVDL2oHtRtDXvTcQRB5InctTxmnS7IaZ+XQdxfKgR5KrhFRPBjFpVQb629ag0sXEMGRnBG+WE35lgARv9ggl7GiOZ7WjMrd1UBN08l8YVXFYy9icVOk/oN/k7mbzW/EHVzZMHvt96c+BLc2uxcpdoUQnHBp+MGZbtauztCSsk0tpDrJgvJemXXwOcSO3CWUIVQFSpSS6A3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 11:09:24 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:09:24 +0000
Date: Wed, 25 Jun 2025 13:09:11 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 1/2] net: xsk: update tx queue consumer
 immediately after transmission
Message-ID: <aFvY10KkS9eUbcOw@boxer>
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
 <20250625101014.45066-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250625101014.45066-2-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VI1PR09CA0137.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::21) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1da97c-46b5-4efe-3b88-08ddb3d8be2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dqMDq9v9eHVNfH8n1DdcYLP0rjrZN6oCpyvEYbiiGZy69X/8NyWN8w5jZTWV?=
 =?us-ascii?Q?hnwEiMDut55f+RPe2i7OckV+1x/d8we80tULlR/DNoMOKy/jYXhwvvLYj7ew?=
 =?us-ascii?Q?napZmlk8It15mrQvYFWahUN8IjFxQ13kMZp58YCsFGQMrx5/qolCP8NPSHsa?=
 =?us-ascii?Q?UUgzy0QnCLUc3484gIqcH6HUCjrNDW8Rie8R6uI5oUv3zent/TUVNlvDTFUt?=
 =?us-ascii?Q?oeEGAd+yj6VdSesd6AtTTcS+e5P+U4w7c0PjEQsEaH0lNBdnAVETEOfI9fv7?=
 =?us-ascii?Q?eAmjGx7kQC8T6pucclQYHYyKcjETygcQeQ5CyeAnYlTDfHax0u9yCzeNwFj7?=
 =?us-ascii?Q?gcyZz7REM0m8Oqpz+Or6kSHYhy07q/j69qL+yiAQ+GXLbQMN1K6UDwtXTCyG?=
 =?us-ascii?Q?KQVNF3wU7V4zlAKSVD1LqpBWYZj5xDyp3srqXsuQUHX8FWh1deHpeDz/vnAk?=
 =?us-ascii?Q?RNsWkvUCPbrrzpHOlo1Bo/nrwlP4U/yDy1nXBBQyN3aTse5QePvftwbd7NAH?=
 =?us-ascii?Q?jiwWgJXBWuGx50jNvvd5JemCp2nkOMZfy0fcWmO09bg3o/nCX52rGrcasUya?=
 =?us-ascii?Q?cCMgHI9hNigRdWTRjq9Y3KrJwOea6wuB2jai5W0OyOhZNmNTs5VPEPCfKS0Z?=
 =?us-ascii?Q?HOvlLWjNLPRlf0eJAM1mEzVTgVBD9x1bimmSDEqjrUVQndPkg9jmMVbjuJCY?=
 =?us-ascii?Q?nsrJufNK7AZpH3buK8PKBifny44ZvYJZ+UL9k2tk5aGOJu110meGe80mL142?=
 =?us-ascii?Q?uHBb87WBynCQO4Q3Q39vI2DEDQTD45vJ7G8wJUOi/9vYz9UtDIXF+aDd9yvk?=
 =?us-ascii?Q?UUIoJfnwuIsTuvGgsbHe4ePrVepPWiUZa8KbdkW3gOKQyBK1MEh37RtbfV7U?=
 =?us-ascii?Q?y3piD/jVw6VRm+y/yvl3Lvtr3//lM0fCfcVGSNNsa8rPBZsbbRyQJFQKiH6U?=
 =?us-ascii?Q?txDatW5Z/TLWo0UIBqUrp7EFHe1IL+KWIU1d4QSELpfAQM1AfBmbrDhS2qXb?=
 =?us-ascii?Q?6H8tYnqokCxvI8O+MlK9MJywUEire2636QaTZBaWBBG2SCbJA7hlmJ3Af1xF?=
 =?us-ascii?Q?6ugpSmNrhFagRKtvtl1fZkyMwUH9H35sXoz87C4d3TMmYI410UyF1YdK+j8T?=
 =?us-ascii?Q?9a/7BuA20pq+D0WlUhdUs4ygAEeaQ4BFyVexlQ1jfPpqRrLW3EmKGlFfcB95?=
 =?us-ascii?Q?/CKx/SCuuENr8iAxjMUoroijLw8hQpQaLTbwPJauKyqiWNAnIvqY2+VrjDVo?=
 =?us-ascii?Q?A9Fr+5DhadwcqpWz9aSLk4Z2EgGkNDSrGmoqhg3BTy3Y6wvMHqbG3v30W3sM?=
 =?us-ascii?Q?s/s5oKX1FlI5hXC+/n4XKiWwE0S+RlCvr2zvl4cZoHgmWiOlIV4vrkCTLDes?=
 =?us-ascii?Q?SYlr710w1LD4+i1LkCJvucsVSDivis3AeCq17VhhOpk/NP2lezjaWQ/KS6D1?=
 =?us-ascii?Q?te1r3MD44uI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cRhgDMy6LJyBptla/sv7LDwegemMbbTbvdcmiP4xXlkAEvVm9SyEFYKR699/?=
 =?us-ascii?Q?o5M5B5aCVby43fFKc8bgE6xRlZfdN7Wy82zXY4+82gd/erzNHo7yvmDA5Yt5?=
 =?us-ascii?Q?x1ynuleas/r4s7goPrlvAkDfwNPYCg4y2GzE0oG3+QWwetVsoXTohCn2MnA8?=
 =?us-ascii?Q?Vn8UbBnsjf+CNl7dN7qOTTufCZITvJjnKXMNnfEM6uBvv4Re475zH+S/9Eh3?=
 =?us-ascii?Q?HW3Aotqge2uyMAXmypQ0GuEcCPQvqxjBibSzIsJ3ldTCYjfrn8QAH1pfZr2d?=
 =?us-ascii?Q?NNyZXbtev0/8vpg6jUQKMqu/7DiCq6ZqFauS41XHuhAZu7/Cdk/F6BMFvzN4?=
 =?us-ascii?Q?ueWaMjAJRDKcNZ3kkDGMb3AhYjDiyXTKe2ppbSMMGpSLNzqi60rBabRQhZHA?=
 =?us-ascii?Q?Fhgfpaa4uwTrqhCb8MfOKNkEwnZcWcoCpWYAn079HN3RO9+lCJCyxv0lYyPX?=
 =?us-ascii?Q?TfakVbEOpGpJBmsN2zv9sL3+e+wh2Hm5GoJDucSs6L6rXOa2zl6U2QNDFl5G?=
 =?us-ascii?Q?XoIAuRTjY2+tmHIhsoaCN4LMForlESidiQGBI00zn8ENTIDDlgBuOihRXPcI?=
 =?us-ascii?Q?U5d67BasMzek30L61POcoXvDcfCPK2YvumrrKtXZ2SHKhhkemrlGS74l19M3?=
 =?us-ascii?Q?xYngE+05TNueeUigGSAkb92otB90G96QdbYwmVQKHxM/VHmlOfCXAeTPQYc1?=
 =?us-ascii?Q?4vsT2RVkFJFTvSgq2UKDQTNTt5JFmkwezKeNzZ7y10qmsDgcb6cvEmNne9bl?=
 =?us-ascii?Q?EVels8+6EoLeZXpEienw4hgnbdYJ0fxK4K7+/x0BihwiU4VmWkLLZ9JR9vIc?=
 =?us-ascii?Q?8UJesBla7FiCayiD6JiCOO0pMYEZzHZR1Q7HDmHab3Ii8BtwlnryGtePcA3y?=
 =?us-ascii?Q?Yq4PPr3lSmoNvFXsXasHv3PnGlClGg9Iz83cXKhVxpFC5WYI+SWzEZ6nAHVd?=
 =?us-ascii?Q?3MQS9p0wC7L+Y2cx6maP3C/SuICcKTHVkUo+YrKubxzCyJcZJwl0Oe1r4L6e?=
 =?us-ascii?Q?nwa3krHfNFNBY5YROtr9uQtqNj5+A4z1VUo81G5jYNbNibiF+gyi2Z8j+fXT?=
 =?us-ascii?Q?9/NPsMcYs1MP0G20i63JC3QnXO4q2tTrb2zgEMqRrwisFz/ED8TLbBTtr/6u?=
 =?us-ascii?Q?JmbGGbEN+qcZVduOFt2PtWIPx3h6WG9BNCxADAAHfpb80aAeoLOUwVj3FdDd?=
 =?us-ascii?Q?m6CHZ7+jgIoKwu1Z3e8bCLHdFRVw5e7y/lKCOFTx4h9yLpQWkc3TwwimftU2?=
 =?us-ascii?Q?giRE2RLz4zcVP1v4RGG+R9m4ZKottAxhMOp0sIMtra/udd2zqc0lyWlXFv6A?=
 =?us-ascii?Q?l6479vbTCU/nwriz02/MNTZX8JRyfTYhUGR/tmgDnQxzctSzKAEm9vlH3ORi?=
 =?us-ascii?Q?HIXdrvDHIx7NcmZJoGEGnH+c/OY7d6Hff+KmMrM1cQFSE4LbBx9Ey1yXQ499?=
 =?us-ascii?Q?yDtKAwF39zZzGRGOc0LRqHWNqtJ7Kb5zmpscyuOVu831rQUhnOeWr27+KTQc?=
 =?us-ascii?Q?08Q+loT7GWcw4noegQ2ZIJnh8finuTZ0OaZf4u434tNx+DPBFf9EUc4miWHT?=
 =?us-ascii?Q?dP4OFZqG+5oVkjSKFffu6MsxYiwlFMcX/ONPhC8Ijs9E4ObzkhoA1q/z3GAn?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1da97c-46b5-4efe-3b88-08ddb3d8be2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 11:09:24.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sFRHuFrBNzHeeA3tfqCTIp+sgOhkAgsQVez7ftYVTxulXPSCQ9ADFoSBNy6+qERM7zFWx4acLiMSW7lt/V6hzdsXU5z9xoHrMeewpJIqnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com

On Wed, Jun 25, 2025 at 06:10:13PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> For afxdp, the return value of sendto() syscall doesn't reflect how many
> descs handled in the kernel. One of use cases is that when user-space
> application tries to know the number of transmitted skbs and then decides
> if it continues to send, say, is it stopped due to max tx budget?
> 
> The following formular can be used after sending to learn how many
> skbs/descs the kernel takes care of:
> 
>   tx_queue.consumers_before - tx_queue.consumers_after
> 
> Prior to the current patch, in non-zc mode, the consumer of tx queue is
> not immediately updated at the end of each sendto syscall when error
> occurs, which leads to the consumer value out-of-dated from the perspective
> of user space. So this patch requires store operation to pass the cached
> value to the shared value to handle the problem.
> 
> More than those explicit errors appearing in the while() loop in
> __xsk_generic_xmit(), there are a few possible error cases that might
> be neglected in the following call trace:
> __xsk_generic_xmit()
>     xskq_cons_peek_desc()
>         xskq_cons_read_desc()
> 	    xskq_cons_is_valid_desc()
> It will also cause the premature exit in the while() loop even if not
> all the descs are consumed.
> 
> Based on the above analysis, using 'cached_prod != cached_cons' could
> cover all the possible cases because it represents there are remaining
> descs that are not handled and cached_cons are not updated to the global
> state of consumer at this time.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v3
> Link: https://lore.kernel.org/all/20250623073129.23290-1-kerneljasonxing@gmail.com/
> 1. use xskq_has_descs helper.
> 2. add selftest
> 
> V2
> Link: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> 1. filter out those good cases because only those that return error need
> updates.
> Side note:
> 1. in non-batched zero copy mode, at the end of every caller of
> xsk_tx_peek_desc(), there is always a xsk_tx_release() function that used
> to update the local consumer to the global state of consumer. So for the
> zero copy mode, no need to change at all.
> 2. Actually I have no strong preference between v1 (see the above link)
> and v2 because smp_store_release() shouldn't cause side effect.
> Considering the exactitude of writing code, v2 is a more preferable
> one.
> ---
>  net/xdp/xsk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 5542675dffa9..ab6351b24ac8 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -856,6 +856,9 @@ static int __xsk_generic_xmit(struct sock *sk)
>  	}
>  
>  out:
> +	if (xskq_has_descs(xs->tx))
> +		__xskq_cons_release(xs->tx);
> +
>  	if (sent_frame)
>  		if (xsk_tx_writeable(xs))
>  			sk->sk_write_space(sk);

Hi Jason,
IMHO below should be enough to address the issue:

	if (sent_frame) {
		__xskq_cons_release(xs->tx);
		if (xsk_tx_writeable(xs))
			sk->sk_write_space(sk);
	}

which basically is what xsk_tx_release() does for each tx socket in list.
zc drivers call it whenever there was a single descriptor produced to HW
ring. So should we on generic xmit side, based on @sent_frame.

We could even wrap these 3 lines onto internal function, say
__xsk_tx_release() and use it in xsk_tx_release() as well.

> -- 
> 2.41.3
> 

