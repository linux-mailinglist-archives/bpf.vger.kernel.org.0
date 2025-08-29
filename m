Return-Path: <bpf+bounces-66994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF291B3C069
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79943A6577
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A71322A0B;
	Fri, 29 Aug 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Am4W/wos"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514552F9C3D;
	Fri, 29 Aug 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484091; cv=fail; b=KQSQyhs1bR1zqQL0Cg591TTtAXr0jrsaycSm8JUj+ZipzB6qVIf+R/ZX2Ky4eS1EZz9wAvtEpetoYWakPy8leXukGAoTi2D8FuBdWx1sro7LvAYbMUE39dTKuLLXD5R7TUxDffbGKO/m98QMM7YrPzyH4IN/A4oQk7rqbGvxfww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484091; c=relaxed/simple;
	bh=pYILJW5tC/qIRyR64AzrJvsjAn8lPN4weaZZ6NzkzL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gV/1JJ1bomB4KncUj+vubhes68EDkjYZDPS3kXYBF/7mHPxC0BTWa9dILVrF4tzI9UP6M8uG/NSXAukoyQVGkJXcGfGJ+NMFxVDzYfItLaOPBKqxxdKdizmPFNbmqjIqZVTyB73hip+7aWUukp/3wMuu3jMg/MqDu1EclojUAjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Am4W/wos; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756484090; x=1788020090;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pYILJW5tC/qIRyR64AzrJvsjAn8lPN4weaZZ6NzkzL4=;
  b=Am4W/wos1icefOpszAHlXwkbx9DjrMHKkM4pat2WuDy2N5oQwb3vZL1g
   NY07tNrWudNNsShwW63Xdf6PepydVWpMLl9TJB2WuJHUdDfzE9jao1D0m
   tcF6tkd13hs89mj8JezpbOD0O43AaEk216qKy3XAyuqShuqY3J1NheZfu
   AgvEYyH2d03aBuCIgY/mKacOF+jT2oiTIu8uTQYpJLfZeT4tImTcumLvz
   w7A35Pna9fHL7jmpHYaELPND5DnAxyAONcCp0/8uGjeR1nQOG2Ilc9aVr
   5ciWXXEbPXe7IIM7OnULH0APC6wxMMu+bqnvqq9dR+JLdRkVEKDGdVZAj
   A==;
X-CSE-ConnectionGUID: Zkp2tN99SzCw5EvyW1uV7g==
X-CSE-MsgGUID: QukGQl76Tm6s3tMi0rTCWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69482189"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69482189"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 09:14:49 -0700
X-CSE-ConnectionGUID: LP91PZddRvqTs2N3Prv0Hw==
X-CSE-MsgGUID: D7z1pCc+Rpy8KixpnVDo6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174586692"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 09:14:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 09:14:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 09:14:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.60)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 09:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4SWmOnUzklENeXEc4ApkNGd8HzHN2QpvuhzcjncCBd8XX+wRmY2ZLy/QzO4tmy5LzqmzDKB9RhZWWu9IXPdTtYmg1R1Y2DZS0ZqJb9Od7dn0ZLQEbF0Da9CJL7w16v3FZhaIgBl24qERRn/JCLf7EhrSjHLUeicqeAK8uXh6jrINEeXqUFRPJZcvD216uszFdXp3oaVGwOMfvylxs259ekft2b5gIha4HPnGre68tl3D6IhPLSGQn8sI66CG0FC9kcrDFUqBUq8VMk8rMWjFV81ZG72Lfrt1Fmmo9OG5/CeD2opG4Tt+spRje7rByeZ4GAZacrxlfBqY50pHUM8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfZxt1NPbr0P5c4V5PiqkBOE80vEe+Hb08Y6DpmvaXc=;
 b=shnxhXXLRZSzo5kq9bgGPzjIR9YWnscM0zo9EzvQrQCHp+cMfSmwtWRSyFJicX09aCwQpi+n20Kaecb98w+UqPvZFMTiXoK9B9Yi94wJCdkBcyf/y1sdUDRSh/Pv3pZgnRmoG/ypXwgYl4vfwlHtfnZX/M6arArkT1nmCSsKCKEFQeQfnXZU09xwJlAeJK/wYfrnvP+ZNgtyk02k8pMqcze7QNsxitoXQeV30uyvyscYJOKtaBX23hiMnTN3eFRLTFoBYUdcCoQ/S7l9ov2Z3Tj7caQ66k3JCE+yLbIuOOQ58OqugaQohDQwEZUMZ35kzxbAJV9UbKuI8m0VbQogcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.28; Fri, 29 Aug
 2025 16:14:39 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 16:14:39 +0000
Date: Fri, 29 Aug 2025 18:14:26 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: Dan Carpenter <dan.carpenter@linaro.org>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <andrii@kernel.org>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<aleksander.lobakin@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
Message-ID: <aLHR4qMphDdG43l2@boxer>
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
 <aK1sz42QLX42u6Eo@stanley.mountain>
 <089fa206-1511-4fd9-bc12-f73ab8a08bb6@iogearbox.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <089fa206-1511-4fd9-bc12-f73ab8a08bb6@iogearbox.net>
X-ClientProxiedBy: WA1P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ1PR11MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 0714dc11-8b30-4bcc-f1c4-08dde71727c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XtXbeieONIFkBWn2HSNDihSdpyPMj+R5Whd3wLsYfIAnfORQ2rJiQyQ6kb0D?=
 =?us-ascii?Q?aFDEcZDV0Qwf0PHAlQ9c9HJQvKYSGVwHcGKlD2b7u0P3ofNfkaJ+MrYXKVPN?=
 =?us-ascii?Q?6onnZ/QR66oYRri2bGsDHG4DQFL5tgMeLYkiAARAe6n3ZEssrO0sskZ4ByE+?=
 =?us-ascii?Q?B0porPPo69hS5zW9Mhf+1HpXagEP+ggYYwgIYIz+EMkeswGaJZweHq9UldpW?=
 =?us-ascii?Q?wGBO8Ri+WZwpu4Kh2ULJDCyIbEEyswQFvTmZXC8XRlgbgkvarw2T/vP7vjhB?=
 =?us-ascii?Q?UDBOyWukBbTwokPQ6p4H0/gWqekZA3FuJNkKqvqidzStiqzevVcc9wP8sebW?=
 =?us-ascii?Q?Da5tPVQgAMuu1qCP1Y7kRTRpvq6a9SyFOkqPPTk4EvDnmFzpxEqQCPn7anrd?=
 =?us-ascii?Q?AflbG7HxXWnHWSw9dqg0aLvkWPts1iqBW1znWobZnjVpTWGR73biTlCJ1KdS?=
 =?us-ascii?Q?iGBUtH7EPAlXWZhuNiu8ByxPDH64vJx8wpztTm90h/psav6ONrPXv/HNoSLT?=
 =?us-ascii?Q?owDisOx/zr5GrEnU4ZVHlbHAHJdguHWh4fjcXrR5LBX3XdGIssu4mp4iWKXc?=
 =?us-ascii?Q?LQ6F3ZhV/z6NZAUh8cF1cARGbQCFlDDAfFYXSbjXm7hMIpP2Uq7WPPnnsgPC?=
 =?us-ascii?Q?kKF6xHg2n83DJwCu6cHKu+oXlxOhk0DqRyH87Qo8xNfAxx3eMYqJArk2jq3f?=
 =?us-ascii?Q?MuY/TtRVVsnLiqi1v9FBN2MsaMDEOdC29H1nggeC2k5aQx9LTi4B9//Q0Q9Z?=
 =?us-ascii?Q?wLBWUzg6LbF5WiksMckCQ3oRL2mNOpKPPklfQKF3sFW+2ze/RdYlmdLywhlN?=
 =?us-ascii?Q?D+nkHXDdQgxOgdTRdKRqGfQ8k2QP4/SM7CaMpdsvD5VPHiP9pC3qO6WSdLHn?=
 =?us-ascii?Q?PlPItxIZlCHiVxEI8wS629Giw7JHqu/RS9s/3yS8RbNVwbsSjSoUO96zlezS?=
 =?us-ascii?Q?a6sKL8sHgHxXH2AsjVO4fXX25FqBZfewIkOCbZngl3sX6j7JBEQ87JK8jPW/?=
 =?us-ascii?Q?DJj71YVMzKFkmRLhc1NzUuj6hK46y/WtL8/mww5an+k1cV/J3R45VipShphx?=
 =?us-ascii?Q?6VSAIlr+e0pI3aJg11yv4e1ubVJrsos6uFx/PcEtZzXHCR8vzX/CSZARUUcN?=
 =?us-ascii?Q?/84fT+UCg5lfjqEt7A554ToDNCJZtuxpKiDdKvgy/29n8nJhoGs1kemEfNc2?=
 =?us-ascii?Q?voT3XPwprFwXVIyEgpKrT9PrsheShvK371Va4Pkgyy+dPxLdi2j4BCWekftk?=
 =?us-ascii?Q?ueIeEVOPnX6PNMBghrOqe83L6QF7POfkyTAr9AUT/k218DAsAQ2DXbY9qziu?=
 =?us-ascii?Q?Qt+AE5hlFd9HsCr7W3tvGLZBDrRUwJnkO9bSXYhX+multNJ9T73kDJoAGKvk?=
 =?us-ascii?Q?cPDcK/2vM2gYwkLAuSQV8md8BazxX7zReDgH8sDZtzMPRuBvHyqUx/7z5dq4?=
 =?us-ascii?Q?a5ZC5OAp8ho=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3bUUbYW47pJOdSUzBs+3RYuEGhLSY67tTLIjfgCI0rsYJ5DsL6V18WNcoTfr?=
 =?us-ascii?Q?dAMzDwOTaKoVs1YmeP6LpeBXPa9NCppshm24oyNeqP8Hti9RE5FkST1E0oip?=
 =?us-ascii?Q?IWjF5eZCmMha84Rx2oeNXcfTtMJcyse3NgfIFDDXDWP2oyirF6LgjhfRGNsJ?=
 =?us-ascii?Q?P22MAKNfnKpqavcVQLH2O2lZ1qKd0Sy47TeILQN6ShWULlysv42XHB0cWZEu?=
 =?us-ascii?Q?msuMRO+UQcvZMnRYJqauWuIm9WaAf/FuVWQXj86g0jatS5jcBOQu4vM/3IWQ?=
 =?us-ascii?Q?2I4kZBDO1wHcNmnqdQv1sIeUxPDCS87qRDdgegv6Tb8mz4LzFvtS5D7x7DDn?=
 =?us-ascii?Q?TGFuD7AW9VAn/cIo1+LokQPhw7n0z32RXfcFPQEjgw/k9sJJLWTxfhfKxSJK?=
 =?us-ascii?Q?4xZKTdU4nvP3QhWV/z0Jp4iWZfPHJs3OLy+6hlqG2BwzHrYLP6aapZtLTSfL?=
 =?us-ascii?Q?T7j96Rd7A3uIx9PVCFE2IdBAc8bJMFcI7bJB+fhM/LoX8r8w4PexpnkKrekp?=
 =?us-ascii?Q?rD5s7IDkDYwbeCTUB8CcuGk3W47da/CVkxR0blKvcUYMFfFhRLrNq3I5jKL9?=
 =?us-ascii?Q?iEcDTaptwuRL67NvJHJtXooi0wfRxuZVBaivfPsc0IOEJOiYkZLAj/Z/fpRF?=
 =?us-ascii?Q?DxAFmsGN8gr3HWASm4Pz83gSAR75abG7X+3Csehwx+HZFK7s+NhQtyIHLWc0?=
 =?us-ascii?Q?oCXsrLENK3WOnDVyAJk03/vl14hfJV129B0p9Y5MPRB/5X3+44S6DbrUEg2n?=
 =?us-ascii?Q?xMqjqTu9O1iRr1IUVwEAzs6Hj4TBiw4n6sbvzAFf4abra8B1rJQrAKxej3hD?=
 =?us-ascii?Q?uwztFynf1ecgSMlj906hafkIIIdExFYjzw7zkDBO5+XjPCqKmoDShzVdHhSP?=
 =?us-ascii?Q?sVu/XCPTCsQzgqZSNu8viMNohfO2J2eU+OjuNBqae8AlIuGsP9SUDuDL96pO?=
 =?us-ascii?Q?2tmjSsuZTDCqhZsLaXPERvarzVV4zNEv3VwfGxCIi/rl4EkClOMtBGMo9LVA?=
 =?us-ascii?Q?Q+0ASZxQlNs0Pr3u2V1X5/FAuaT/zHXI7XqazAoOFblGD3agPAh1EEfLI+gf?=
 =?us-ascii?Q?eU0YXd1x9LWpBW77LcGCmjBsU/Sd2NTMoDfiqTlUkgBXyO7ywL76Hd2ocUka?=
 =?us-ascii?Q?LZfF6MsyNtECIccyBERkWzBzNQxgZ3WQFxISEmsbfsqSNCxNQxX71ugdngMF?=
 =?us-ascii?Q?/8Koqbi67CO24hwItYR7B/7J4xEcRI1xGn9n5w8Zpn+NGG8V6HoMxOx3nnf4?=
 =?us-ascii?Q?Rnk6DoKx8NE66DicMzh8s7TFdvXUNB8DFxFqjknUDqu7k9Fly3Lill4tp5as?=
 =?us-ascii?Q?5uVwiCZ+gtAGyr32rDw+BbiurBzYx+PCWWXYASQkE+TWmyCcuuUkGPuCtGGD?=
 =?us-ascii?Q?mIaEi7I9J0CaHDAM3MEZ9g605hkGdCnTSfzOfEwZskIWzOFOtkMKRbB+g2FU?=
 =?us-ascii?Q?kF2gSwtZPueVXvUzwlIneZhZrQ3e6WYB/YLAMmeNHzsYg+Zzzk7snsaruPEn?=
 =?us-ascii?Q?8kPHLf8BGIAHKfz+M4cbho6OGKemJxELQmu/uFMuoRdYmPQN845yAwBRv9Iy?=
 =?us-ascii?Q?ESlTEOOjIHO3mMqndfWooJxlwXcWIbDN4qmxCJm2YJuYNTsEfqIgWHSNCcs9?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0714dc11-8b30-4bcc-f1c4-08dde71727c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 16:14:39.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDPdbk2xCdBFJdWfCwbfp/xgn+zvvjpEZF2IginqTTFSLzifKiW2ZAyjrbRsecuHZ2mGTF9CrkeS4VTlj+B2PjqlTevviLUmHVtSHN6odw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
X-OriginatorOrg: intel.com

On Tue, Aug 26, 2025 at 02:23:34PM +0200, Daniel Borkmann wrote:
> On 8/26/25 10:14 AM, Dan Carpenter wrote:
> > On Wed, Aug 20, 2025 at 05:44:16PM +0200, Maciej Fijalkowski wrote:
> > >   			return ERR_PTR(err);
> > >   		skb_reserve(skb, hr);
> > > +
> > > +		addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > +		if (!addrs) {
> > > +			kfree(skb);
> > 
> > This needs to be kfree_skb(skb);
> 
> Oh well, good catch! Maciej, given this commit did not land yet in Linus' tree,
> I can toss the commit from bpf tree assuming you send a v7?
> 
> Also, looking at xsk_build_skb(), do we similarly need to free that allocated
> skb when we hit the ERR_PTR(-EOVERFLOW) ? Mentioned function has the following
> in the free_err path:
> 
>         if (first_frag && skb)
>                 kfree_skb(skb);
> 
> Pls double check.

for EOVERFLOW we drop skb and then we continue with consuming next
descriptors from XSK Tx queue. Every other errno causes this loop
processing to stop and give the control back to application side. skb
pointer is kept within xdp_sock and on next syscall we will retry with
sending it.

	if (err == -EOVERFLOW) {
		xsk_drop_skb(xs->skb);
		-> xsk_consume_skb(skb);
		   -> consume_skb(skb);

since it's a drop, i wonder if we should have a kfree_skb() with proper
drop reason for XSK subsystem, but that's for a different discussion.

I will now send a v7 which is supposed to address the reported perf impact
by Jason...keep your fingers crossed for me not messing anything again
around this code base:D

> 
> > regards,
> > dan carpenter
> > 
> > > +			return ERR_PTR(-ENOMEM);
> > > +		}
> > > +
> > > +		xsk_set_destructor_arg(skb, addrs);
> > >   	}
> > >   	addr = desc->addr;
> > 
> 

