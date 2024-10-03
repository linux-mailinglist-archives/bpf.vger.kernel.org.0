Return-Path: <bpf+bounces-40824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7088D98EE75
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 13:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2ACBB2210D
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC5315667D;
	Thu,  3 Oct 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOqPHg4u"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C313D245;
	Thu,  3 Oct 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956087; cv=fail; b=QFBerB6HVxRMR5wI5J+sfjhoIXRUUDFWlf90fbQx2YfFO9Cuhg1GH+Bj9s9oKwo2lTnYsLeqPOClzM8uxZ0jk7PUB26mqsx3RlYXyDMAri0w8XvKlVN1mwQ2oPFP4hIf/Ne6qjeOTkyt9UUppUOVxXbM8lwjiHN54IpvbiWVTFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956087; c=relaxed/simple;
	bh=ALVEIR4+3AhmY/eePByAK/2tbrwcCTT4hH8bM39yDKc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJiiubpwT/YtP7CbrJ7qp31HZbtm0YwNcU/K8j9LUM4sYbZfoVkaTmqcyPxmocwL8cm1UHB2R3mgM+BQJC3FEtNQtJJAaqP9CeHAV879eLMIR6bOEfJXj4sptfoDGZM9/S2F0k90NrJyhbeQT3r6Gwfa897L1tU4M8cdzOp1LyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOqPHg4u; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727956086; x=1759492086;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ALVEIR4+3AhmY/eePByAK/2tbrwcCTT4hH8bM39yDKc=;
  b=OOqPHg4uy2K4nvI/jYI7I6X4nIYsdlWvCeEnV5HzIvgpg89VrQVCTz+2
   m4hh7gPYly+wmbFHvzOFhXytEQF7J0gSxXc1cB+vwbb+iqpWkkOAL8RSC
   tKp7x8ASzq4gI2503Vxq2KJyr/+W+I+d7uCYsZGK68Vv/bQJ8vD0FMnQ/
   wL1p2e+NrihaxtCp1Myno6f0ykh1a0y8n6yC9SnBqRTx77nrzgjC57kE4
   WfV0lrcew5qW26bZFUsB344HGVV0iwrtNQ8LPl4Q3eCxJCz56YVPEqYfC
   4YxJJ4PlLXdf1BdmE0xdRzTXfkDmpGVcAVFroPj8qdCVt5utgvM+4dmiW
   w==;
X-CSE-ConnectionGUID: qzYhK3FnSxS3dZL9mu6UhA==
X-CSE-MsgGUID: no026SzhQ6ild9N3lg+3pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="26616457"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="26616457"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 04:48:05 -0700
X-CSE-ConnectionGUID: pV3ujcKSRquYdFJ5yr4GjQ==
X-CSE-MsgGUID: /1ww8cTOTOesMVxvKrXF0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74575973"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 04:48:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 04:48:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 04:48:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 04:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Npy0emtlj6Q2nsMltChlQ4xnnx1Io63IcxTI03GgQUU30dy1CNV5qT482V3cAurPSLgEhLxT+Yntz6kWynu+82PXMKQ4cfZ+tP1B68GAWikmq0yXK2xKEBv6A//zytLBMXcjJjfGZXRWMXHLqVNEsSBwSk5NANXCJqbbUtPgc0fViEB1griKCNZfbqcx+6ei8lqPyPIHSOCrkpE6pDUm6d1oQc2h4hoDlT7zkkqAcnS4vGTj5lERYHJdVmKaEvPqd0kfn4ORcXM3LWQN8/fe9SpoBaKhHPWeOndJEvwKOy5Nd/KSV9FbOA6Nc0AsTULMsrEwz9YqGHrKDP3DjePmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vyqIM2e6wYGPDCfxoyifu9IUkGnUZaeIUXhQ5/urdU=;
 b=SGqRTY98uSiZImnMW6wYMuRoK4Chbwh3RqS1T4Qnobi6h570xdU6FiF8dY0OBEaaJgrfW5pzO8/lwVO20DzjgEoAhf+RK+mwtZloy8ZK3fXp17M8I3RBdDcIgYtZEdIXdwiItue5EYTWZ18n5zLh7M5r9oZISU/qIPr7Mf8rMvyfipdMP3qVre+oT46UG7H6vccKpqfzE/uObowRwdML+GYpDg75WDKVyYDZ7U9ulh6EgZ2LJ131Baqjb7dFrKpRSZGbHgKrUcxyXOx83A6UDX5u+t4HNgJsj1fTzHXGioYqTH6WiRy2Lp/uzCnrkmTrBHeliYV61VVvPL6S2RKR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Thu, 3 Oct 2024 11:48:02 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 11:48:01 +0000
Date: Thu, 3 Oct 2024 13:47:51 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>
Subject: Re: [PATCH bpf-next 4/6] xsk: carry a copy of xdp_zc_max_segs within
 xsk_buff_pool
Message-ID: <Zv6EZybVMBeHluAl@boxer>
References: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
 <20241002155441.253956-5-maciej.fijalkowski@intel.com>
 <4aa21712-2643-42e5-a995-d53cf0a53158@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4aa21712-2643-42e5-a995-d53cf0a53158@linux.dev>
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW3PR11MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c0398c-ade3-46a7-4622-08dce3a13c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6lT8Dq6EAGuWrYVjRcMYXmMiVb7GzvQklOa3WXVix+393NFx+QXdWNsnKdlv?=
 =?us-ascii?Q?IU3KxQ6G3EOaUmzD1emuEH6tQvT38YnxDEiV3uhsO6HWeUp+2bbQc82BA2D6?=
 =?us-ascii?Q?/cjKC6SpJAUs9VhQEZGHmYWYNku4gqlcAQRm2BQeZlMq7qqAi2A9ZlukilxC?=
 =?us-ascii?Q?oo8cF7Zo4vtw9YQbyeVqye23vD4Uvhewfiq0l4FCnPMaMuVwJ3nXgiTLFDQs?=
 =?us-ascii?Q?rzVSjm6dT2SPL4MhGvDmmKx7GIFFHQvFKRzwftCEWnYzDj/F4ufqMnFtJVHU?=
 =?us-ascii?Q?I+a0EZaJpRBhbC3vylwwSlI2kYWH1OWE10j4jLeRFoqx8O6bzNRI8qflwdMC?=
 =?us-ascii?Q?G6Sbh/klIySS/XmP0SmXeMQiPfRWFRw1otNYiWCU8jjiO9IRv0p+eX8Zl02k?=
 =?us-ascii?Q?VVjskXDbXdt3T9qXhDG4kO1hg4mnaXfX7eirzkqfAr/dkwcX09yMzEBnSN/A?=
 =?us-ascii?Q?ok0XwQmnRt+xl+QpuZLumBHHl3oZSbZQlZSDg/gID4gXn3vXAyu3QDnhdqVk?=
 =?us-ascii?Q?3RgS4nhfzaIaN4CE78DciKTvDL6UTGhONIznYDDX7LSsfkH5vCrlV6OAoMgW?=
 =?us-ascii?Q?93POZDWVF6HOvoQmFeDdEanY3VSZ9ELSKk0B7lU5NXJt4sYMLFYSi2iA9xXf?=
 =?us-ascii?Q?AGhN7TanJjpNm1Iy0Ustn7tFOA7MYUStxP7n+Gc+/jdSHXf9RZYVOPDrwRnC?=
 =?us-ascii?Q?JuGcqwvWv/u0fZkpnUqwbWFV6tEjfGytfneKp1L5Q9OcFHxFo7H1iwMwUiqs?=
 =?us-ascii?Q?j7HGRhegqSABbkRt6crOw/7Jplq8fe2yVLZhO0MxYPhg4H256AT2S51tP3S2?=
 =?us-ascii?Q?yG04IEKBaUYYnr7rSmxYjzOhxsNpKVcXPa0ZdO5odorhosZyELYX/kNKo6m0?=
 =?us-ascii?Q?8IBNCbAvpg8zIoa+5o+jVl79opJjZb2x+uXvbJdw38dJVXE5cLzmLBeovYDq?=
 =?us-ascii?Q?fdW4UV/oYy0w8TnzfgRWlO8GJDEU9VTB2z/vDshvzR03+ihDZIv6DtMn/rQO?=
 =?us-ascii?Q?xUSIWBLJ1n+rZLXbQvFyv9296wZZmzd0BcbBFoYyqFz06wjCz8m6AraW43Qo?=
 =?us-ascii?Q?oXk8u2h4ZnxGFlvWcOHnkOII4EElDGc4cJULWmvdvbW6e6+pJxBQp7z5x82C?=
 =?us-ascii?Q?Qfh5dC4P5T+qXRJ4C4Mh24FmqbuOogIzvoNhA9cnnV4havcifLSGGxsNT5KD?=
 =?us-ascii?Q?lx5FP6tBlTSAjlS83x7vdVI7QJrkNureTIXe/a6GRVHZSQi0INEoUZ/Oqcow?=
 =?us-ascii?Q?51dp+0YkPZ0am4+DkGpAeFTIDLMo3pZ+9KzGc4q0gA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2yqYrI0nmzv5nz9yUPglhQqdS6KndTSE0lwfRbKDIefsjHII840F7SSWU6CY?=
 =?us-ascii?Q?wAjJ/jhYzn19GCemKeyxmREFnA3gruOkkzjGV2Cm7dZTPJItt13jsln8LcS1?=
 =?us-ascii?Q?rY/fOo+5Qj95iTenW0INhnjcZunfAbw/UGkwe6KSKqb9Ky2kWuZheA6jyKfo?=
 =?us-ascii?Q?IcvUD3fazT9ez5YsWccEVzYXFtxkLGuJYPOrbslSKQoSupP5SwrcTLmXzgjR?=
 =?us-ascii?Q?bi76AMEo1sOACjIWJzjXvkYvpk/dm5Pe0tq9OdxyAJTyt1VIHI00MT7XUfZy?=
 =?us-ascii?Q?AswP5zlsrkBEEU2oPkVagpwVKhGQy8JfUpLKKELRpFyRztZUmKUS4oGzkMPR?=
 =?us-ascii?Q?fAk+KKbZss0nRRah6fjDUCIw/27yKhT5KGKXAaYA8COrznoYUfP/dRcR1p0g?=
 =?us-ascii?Q?FU65HnhM/oVaMjKcvX+cNLAzIoaP8Sm+lrOSEbrqRqFW8B8WklvlI+vqtdSo?=
 =?us-ascii?Q?TZOBdhzJjoTHz6bz/e6iPvwcbK4bAlLxze1Kg8bAKN+lSBGh4Aq6krzQ9Sn2?=
 =?us-ascii?Q?212sJjWU5DUf5/MCSeMAXV3MZmciwwxT5Y682SDLApOdMPq1JFd/+bgLWr4s?=
 =?us-ascii?Q?gPu3YsOo3E27R9fMPUWxiT7MNrQK5Qv/XV6eAiiQ4qjizRUbtbNIZqmwNe9v?=
 =?us-ascii?Q?L3Pd2Y/gGxuXjt3JBDmjYvQWFiJ7CVbp/wtWa512Ou7KLVk8GFqNbl2N/A7W?=
 =?us-ascii?Q?OOYz9WxdHLPqh7kN+f2sIiHyoZzGgxBxRPezqnrJpiVTfM9AZ5pXc2cZOnoA?=
 =?us-ascii?Q?NH4KYweLgvxIk/YchuI5hmoaP0g0yQYouDQ0fSgMU2tLgXjC0+c4B1rEU1cf?=
 =?us-ascii?Q?sfoOEn4THFUNPZmGnxylta7G077Rx9xguaoT+Jj7jym+vgqCaIbAfcd5siOz?=
 =?us-ascii?Q?cDp1dTS18EP003jb8PVlzdsP0TIoxna2XB5vsSl5VTXl80UCXpr2Pc9AdmrW?=
 =?us-ascii?Q?DjcjkAHVePDJUpLRyOZAfXR/iuwbb2JMIwWh+pfrjC4JcSoBZQJw6Hz5DdgQ?=
 =?us-ascii?Q?N8Ykj97w+SK2d8ftWtsSlGLLbLhZLOEKAiNfvcdtu+ToY0/BaAMbq4MCwIWj?=
 =?us-ascii?Q?0aoemrjQCEsXpJVtpK5FgVnIbcWljiR95ev2WgPVqdiRY30xScJyjuutvMdv?=
 =?us-ascii?Q?muy8qt1piNzMpQkWdhl798GxhKg64lmGR4Fe4LxTzdu8010jiC+55iq7qT3w?=
 =?us-ascii?Q?eTb7RMrAiHtopZCn/4CeJFGytveXncaC0D51PNxlp/hP70qxOYu5jGUnN5XM?=
 =?us-ascii?Q?98liyu0PR9S5rYjdt/lNAqlbzXFEVXj5BIhRhPVNqmVRjv0EfgudDIvnfSZz?=
 =?us-ascii?Q?vj1wW/MCP1BcAJaPOyozoQ5djHQISt2myWz7WYhPeixPoLra/qPt8rm1GjLA?=
 =?us-ascii?Q?qj3kJm0/WzspKZhc787t879qOSp2OymWxqkRS2Tv4veYQNJHV6FjsP0PpaCR?=
 =?us-ascii?Q?A3nbYrTNTKE5PU0Llz7tFPYbz1UI/UxHPncgHesJdnq/aBhi7fJKqEL4/9en?=
 =?us-ascii?Q?W1XeqN+oBybvA1EvyX0I9FL4V+8p7tI8BW7aoZkShQQBC2tshnnNMMlY8tKU?=
 =?us-ascii?Q?LoNya3hPvncNbnyxHmnrBp8JJ1F04yegGnRrSc4amibl73GsMHGBfQ6ykQCW?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c0398c-ade3-46a7-4622-08dce3a13c22
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 11:48:01.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbKMRdfAe5W6xoF9YFy0nJ/Yq66rOkSVyR+/el5+PTyhUCjAmvGSnRNJ+6tVxP3p6dSIHJSYIyAjg6rUYL5r58ycnD3a8mgop7ElQLZVyGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-OriginatorOrg: intel.com

On Wed, Oct 02, 2024 at 08:41:33PM +0100, Vadim Fedorenko wrote:
> On 02/10/2024 16:54, Maciej Fijalkowski wrote:
> > This so we avoid dereferencing struct net_device within hot path.
> > 
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >   include/net/xsk_buff_pool.h | 1 +
> >   net/xdp/xsk_buff_pool.c     | 1 +
> >   net/xdp/xsk_queue.h         | 2 +-
> >   3 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index 468a23b1b4c5..8223581d95f8 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -77,6 +77,7 @@ struct xsk_buff_pool {
> >   	u32 chunk_shift;
> >   	u32 frame_len;
> >   	u8 tx_metadata_len; /* inherited from umem */
> > +	u32 xdp_zc_max_segs;
> 
> It's better not to make holes in the struct. And looks like it's better
> to move it closer to free_list_cnt to put it on the same cache line with
> tx_descs which is accessed earlier in xskq_cons_read_desc_batch()
> (though the last point is not strict because both cache lines should be
> hot at the moment)

Hi Vadim,

Yeah I agree placement is awkward, i'll move this above tx_metadata_len to
keep booleans together. CL is correct though as ::unaligned is accessed
when parsing/validating descs so as you said, both these CLs are supposed
to be hot.

Thanks for review! Will send a v2.

> 
> >   	u8 cached_need_wakeup;
> >   	bool uses_need_wakeup;
> >   	bool unaligned;
> 
> 

