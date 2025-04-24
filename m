Return-Path: <bpf+bounces-56613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E36A9B26E
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9129A2E0A
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA727BF80;
	Thu, 24 Apr 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLetNoaX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26627BF78
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508786; cv=fail; b=tPGblyUCZ+ULLrY2nZRYjcdFzDG4kRrh2u5NA4zyWpcnd+eXRvBZ/M3CBHiybQe6agDEAuX+8JrKCwbWlqE1lvsDjeTIEOyYsEyk0GdQbkqjDbAusBnZ2pdQskF5IvPjAEU2Jq7MYpo4KqKpyyVMROLzS0OmC1iJ1/+n8jGK14I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508786; c=relaxed/simple;
	bh=ptyLmlFzT0BW0fiAgvV2KJDsj9o8sx100DniMf9zV20=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gg+r43M7v1orpyfRQANMtipBbnAXXFmS4f/YFU2RdbjWwm2BSmqM4oTcoZsmdxT4QBiyMWhPQSQgjv/NjPcaKypTOibnald2iupzcKgaDAKPKaMmb/pJxGG8Gb5qan8J9saTO1LUgqhHGPF97v3xH5Gz5MW+cIYfNpGFeNdYAJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLetNoaX; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745508785; x=1777044785;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ptyLmlFzT0BW0fiAgvV2KJDsj9o8sx100DniMf9zV20=;
  b=WLetNoaXrfdvIluc/hwl7oJmg6v98qVDQfmqXzg81jxd5W9pkVs0xMqN
   E7wxjyljwtGjIPY84gOJwR5FcHY5Evng8GqYzsyqbVtXe5S0XmhY8Z7Hz
   lDI0fMUTMD+ZY16arTf9bbGThSifZsMWIJTB88VJRe3xkheBh6zSZuNj2
   rO9vj9AmVfTVZwbmOB2eQ8d/DLjO/99eLn22mO6IwVsJ1iL/3byJFYw7x
   WcRtDG9IMxfn+yUGl7NHfLTURFUCTSxMORgrk4XdLfm2BAcgQMrxIpmM2
   r7RwUA3b9DUisCkIDM9n0O3NHnvU+oSvjDv4RMkHZgEEYmfNJYiDBS60Q
   w==;
X-CSE-ConnectionGUID: ygNYbniLRFSxlGs2LXWFxw==
X-CSE-MsgGUID: YW3wcUdOQPCPXrvAG7eFAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47282914"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47282914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:33:05 -0700
X-CSE-ConnectionGUID: N3dbeydKREKgpVvl8fRpgg==
X-CSE-MsgGUID: jVBGVF+eTTq1yq46HniPEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="169866147"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:33:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:33:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:33:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:33:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQSZGfPKTov3Gfh2m/3B7FSJyWoYvptCbMyBPt8e7K1w8vAd60q3d5NTfl5WneagvJUAYVXF6z/ySKuhnK2HSwcqxYETYLdYqY7NzHEJj6t9dv+qIZJwXm7lDp7RTBJkj20g7lW3lJO/Jpy3MbDBZHlU8pDuceEK2OqJKokisHkcbIXS9i7Z5r0sVo6EAuopAtaVh6CYg5bHJdhvcmOVm/nTAxGiuAWuEW30gaE8YNAR92Ct724inBwU3gBi7h+Be9Obdjf9AkBzvPyA7AADkRv1I+/nhog+GzSEm23/t0zUt1RNU4EF3Sd5JdoZYMBQUCvPCE33bhyQwYcBvmOOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKva9brM2tnXMd7nCvsk2AVC2RFaKwWTZuduf5bIF28=;
 b=G7zQYbw2tn99zZ85ISn8OtguNuwDxhR9uoylZ9PqQigZFCbrIcm39ZF6IJG6t8P5n6t+tJKfEhwuptIzr9L6dKGDAzjIaX2I6yTE7LpXQE9eVN4FrM8NRW7mCHrqojw9jArI324nbIhRmSAhAhWRXR6BDhJKliBGZeK8XiyhpgnV2eBpK3vMIvauYlLpg5kCU7tr4s2qoZHb3/KLbi754528ffhZvCKemjaRLkWZ/iMUO+oTa6yBxO6YBftDicqr6oQ6hORh6wzCGTsjzvZ1H8dtvGwocFDlbmuX7161HFW1oyj0r4iJtP4wd/qP1a0qUwvSuv8exxGDRiiqzZSp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by BL3PR11MB6387.namprd11.prod.outlook.com (2603:10b6:208:3b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:32:58 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 15:32:58 +0000
Date: Thu, 24 Apr 2025 11:32:55 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
CC: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Subject: [PATCH v3 bpf 2/2] selftests/bpf: add test for softlock when
 modifying hashmap while iterating
Message-ID: <20250424153246.141677-3-brandon.kammerdiener@intel.com>
X-Mailer: git-send-email 2.49.0
References: <20250424153246.141677-1-brandon.kammerdiener@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250424153246.141677-1-brandon.kammerdiener@intel.com>
X-ClientProxiedBy: BYAPR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:a03:114::31) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|BL3PR11MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c5d3ec-940d-48d4-c0dd-08dd83454a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+raukHq9DcYrexjCX4PeIuUQA/qZBRsVV1jnTa5w/HLLTaJpaDLG2V4nr2d7?=
 =?us-ascii?Q?mebc3oS0VWizcMgGbiM3I46zYm0WWU28Nwx0RUZpbZF2POTTGH/RF7wJ6Lfk?=
 =?us-ascii?Q?Nk8wkVt91NN0Z/nQljO15XiwOfZz7zd5gt9IhAM2kLUlveSpeIFomjqKgdXU?=
 =?us-ascii?Q?BKOaiLC7cGezMLfbVhcSE1twkfaYhW0vGQmGbjjaWccN+c35Ob8yE4ThSZHL?=
 =?us-ascii?Q?KtPK4G0BBE/zbMgQp9+YpZDmPv8seq2KlM0Y/yV+CWhmqDRXU/7sgyGNFmhe?=
 =?us-ascii?Q?OWR8J1gexvnss2ntlIpRiJb4xp/7Q0JQ4rotO5yJKTzTMrXEBUjG7bR1UPSd?=
 =?us-ascii?Q?A7EIxUUo7i9CDw9syMoKAj8t5z7gJGsy0vaPTMxKu2eWzfjEzdpnT6+hdWxu?=
 =?us-ascii?Q?qmQB70EfMzIZiwmCjWVT64N7yU48Qt897FXCtaVHiBuT1mFio/PgWcR8teLo?=
 =?us-ascii?Q?SJp1ATPbWafUe1bDk6AJoBYC4Ir8PAJEp+M/foF0G1QQCoevIqE+YaSO/Jgg?=
 =?us-ascii?Q?4lkSSgnTkINY1mc/MmF61tZuNFetmcRwGrevkRyrVA9xUJNTveCITp6vhmKy?=
 =?us-ascii?Q?1hBtzAnQUnam7DjEYTAl2QeY7QwIer/L5WtrfpM6dB/Ocv6CcNoi1LUWiPFz?=
 =?us-ascii?Q?0OJay+aOnm3x8LRWQJYukZrryf0WEjvrMT3poLg2BmwtsxRSHnjGIkByWVsJ?=
 =?us-ascii?Q?V/94c26EIqmX1qsAxp2sYXLwdq3ZsdNHG/8jeQ0TaOf6BIGXLMG4bXGI0j6Z?=
 =?us-ascii?Q?ZFsAJYMDFLv/F1aE05PJgzkK6m0+y0eNDL61zkzEy/dvf6qjfOg9w12bZH9h?=
 =?us-ascii?Q?hxUgoV3a/9xY6lo91g+lQNXsKPCm0D8ypnp2u+ARtc9hfkgcVFRC9mNHUnNC?=
 =?us-ascii?Q?rewi8DOyA6/AIiDsWyiDvA2KGAUlWSJFXm7iKx9M7ItBZ9+I4pl1DTVKto1N?=
 =?us-ascii?Q?VEJntS5IGkchWTNq1qUXPGbHSY+WfmW5SPmM3eaOITMy86cVqvPZ3vaklKQ2?=
 =?us-ascii?Q?UpJ8vRj4bhLXhytxm7Il7ln5p3Xo77Dt+dl9wgN8wetr7HnDxnO0+q5ftUtJ?=
 =?us-ascii?Q?zu3t4XVCuzer1SIsVMgiKaDqPd58KVY1Gg2hFxKlk/fIJIB+L2+1ZrO7/m6T?=
 =?us-ascii?Q?zKZGSKzr+npS7x7tyh9zPJcIEfREx6Exyd9nQ551u8MGu6TFfdVrn2M2w3qX?=
 =?us-ascii?Q?+fpjnOajQIkRgaZHOPlx4KGQpPVHZI+Gqu+oNTo5V5DnwGxeQFtrXpfHltR2?=
 =?us-ascii?Q?Y4eg0Nw/8s4sjErMzjY4cT0W9uevI/CeWpEIL2fu5JdmgF3imcANL1H7aYBB?=
 =?us-ascii?Q?u7aLBFjA1e+A/35ZY5uI3e3gO2Ki3slXRsTUOs4EHr80eWZ4PE+YAySqOGx1?=
 =?us-ascii?Q?riB2VGFWEXNsRPcoNNNyUfmw0Te/qn418+Vlnyp2cOFd4HgappkTTf6WMOUR?=
 =?us-ascii?Q?9eWVQaMauA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vji9AS+j4T2/j7akuQK8Ij9zqA5hneE8B/Wgn/ibgpwORtwPo2zF/tJR4sZs?=
 =?us-ascii?Q?PM7/QMCBhIak9bv/9+9s4O7VL4pevfN/gS0R0BaovQxR8u8N0VWP4eoN307M?=
 =?us-ascii?Q?ZyuPJrMlDhd8tle85tVzpqYxQ2rtAnZmySitvhj4EOBhJ3fikboAbaiNUTMZ?=
 =?us-ascii?Q?8uklU+KBrBD4zvVb7EPSgRtwEAJbX+DZfMxFVRYtoLmDbunjkD2l2TqffkwU?=
 =?us-ascii?Q?qYoxdWA3HZVjduKMYgyMfKl3MYlWMMTkUZ5sPd55292Eyrq+QtTrBzkoV2Gt?=
 =?us-ascii?Q?hogX1/D6iYwsAzQEsAjHwoizAMZ3Wd4PK37DwvYz6H5CfUfoHU3cHswUFaci?=
 =?us-ascii?Q?Os19heTz0MGbcbZsu7poB3od6o0vmG4hZPbuIx2zkIkwwjrtfHE7eQER84Ae?=
 =?us-ascii?Q?6rWOuXQOLnNazQ51kAOfOEXkxoRdxkfktrpVDrwcnUkx8jYdoF52FchwCrQE?=
 =?us-ascii?Q?fPhw4KYoyB+W+XEjAgmBdnU4/4OzOIxZugcoS+QwAMntR5BTQFvkzzpJjTcO?=
 =?us-ascii?Q?A3qWcfdGHob9FA4cHzvWR6we9iaCpEU4jCVp9pycJj9AUGqrX9IIRwulepG+?=
 =?us-ascii?Q?dyHOIfkXDOGheB2BI/2ii3CHHCj0mcDUPMZVKJZm1hg9RZyMivyWOEjPExR0?=
 =?us-ascii?Q?I6RJsxAivBEO4UNjRsebDqeYhKerCHYTPuCBXKb/bMFOR0h2ZFiBR+VBrh65?=
 =?us-ascii?Q?jAjvtuU2vx/IA/P65J48eWHuYUkzVAqhXQch8lTNbLRgNMWYkDdPwoJZ16em?=
 =?us-ascii?Q?oJXpFmLFwT+DOdIxBzKh7KFjXcxG6xhhGz7aupVCmMfTFWO69n5bciSKsW3U?=
 =?us-ascii?Q?dOrXyW0cpZZ2TF1hqIIVcH708UG3/G6+EC4hxX3b5Zth6fl/2+/rTDu4kSWM?=
 =?us-ascii?Q?9VNxjQbzR5hm06MYK1ZLOqjRxbJ/tJ5gbllOxkkfqLQTFaEYgvLtSArPN7Pg?=
 =?us-ascii?Q?aH/Xm3a7cWehhFdl5kJ13J2NN8dfMOeDPy9N7yOYONykRS25ZVp/vtkvEBup?=
 =?us-ascii?Q?qc2wo3i4OHhLx9tcSm4sC1TWvC+kAV4KwvoFplt+lLZ9EUIYy4xe9AEKuEyd?=
 =?us-ascii?Q?IEnxNaIOOQSjTvRMyYs3tuKRzymO7WQn6IWuGRFKhPQssVPyhOMopTRnDsph?=
 =?us-ascii?Q?CNRq9tnNgo/ylvyLTH2E1acw1HjENxR57NzjlVSiKlOfbTEkcs6HqfT4Cvm6?=
 =?us-ascii?Q?zIRQsAB7A63zQWDw6/IjnWNLYdhEp/xwJeZQEgUXLgMlfxyC5bkzjoJe8DDE?=
 =?us-ascii?Q?LdOf/gM3eHcCPPaBzel6StE51gziGSHOqohm8qWTCCxp4rwRNRJZz3h8q0fJ?=
 =?us-ascii?Q?8D4S/DfdLJEDbLk8nc4abihzxB+hSkiqi0xsA58DRXIP0CS9T/okAGP30dhc?=
 =?us-ascii?Q?wBPF3fL70202BRuNuRRMH0P56DgSpXjVmXqpGF+tDdwxo2bgA0Nv/viYoxjp?=
 =?us-ascii?Q?K2KWsZasyLb4j9VpVRHOvUyKBaxZ079EHsULxN+dy5z4gtfhJZyxDbDmUXZk?=
 =?us-ascii?Q?QZnu6toFyn0UAqkMH8xgtpvW7IUi17/utwyadtDKT8x5MXO3U67T4zxmsHKw?=
 =?us-ascii?Q?jpdat2IR3KPaQ8ud890l/7HZD7FvOedS2ToOOjSb0DQka2COwRjQT2tVwrw9?=
 =?us-ascii?Q?99+eR/zS+oBcteBdmqCyrpc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c5d3ec-940d-48d4-c0dd-08dd83454a54
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:32:58.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yQNeaRAEk+6u2lvJNQ5jJBnpgEl6QHnwU2tSrs0xX9bSoLhHu2h75vuSnNuXh6Z49uIOs/kBxRQy6/oObsfHuVy9vyT/DBN+q4Wvxi3LYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6387
X-OriginatorOrg: intel.com

Add test that modifies the map while it's being iterated in such a way that
hangs the kernel thread unless the _safe fix is applied to
bpf_for_each_hash_elem.

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
---
v2->v3: address comments by Hou Tao
- rename for_each_hash_modify to just hash_modify for consistency
- check topts.retval
---
 .../selftests/bpf/prog_tests/for_each.c       | 37 +++++++++++++++++++
 .../bpf/progs/for_each_hash_modify.c          | 30 +++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_modify.c

diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
index 09f6487f58b9..5fea3209566e 100644
--- a/tools/testing/selftests/bpf/prog_tests/for_each.c
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -6,6 +6,7 @@
 #include "for_each_array_map_elem.skel.h"
 #include "for_each_map_elem_write_key.skel.h"
 #include "for_each_multi_maps.skel.h"
+#include "for_each_hash_modify.skel.h"

 static unsigned int duration;

@@ -203,6 +204,40 @@ static void test_multi_maps(void)
 	for_each_multi_maps__destroy(skel);
 }

+static void test_hash_modify(void)
+{
+	struct for_each_hash_modify *skel;
+	int max_entries, i, err;
+	__u64 key, val;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1
+	);
+
+	skel = for_each_hash_modify__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "for_each_hash_modify__open_and_load"))
+		return;
+
+	max_entries = bpf_map__max_entries(skel->maps.hashmap);
+	for (i = 0; i < max_entries; i++) {
+		key = i;
+		val = i;
+		err = bpf_map__update_elem(skel->maps.hashmap, &key, sizeof(key),
+					   &val, sizeof(val), BPF_ANY);
+		if (!ASSERT_OK(err, "map_update"))
+			goto out;
+	}
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_access), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_OK(topts.retval, "retval");
+
+out:
+	for_each_hash_modify__destroy(skel);
+}
+
 void test_for_each(void)
 {
 	if (test__start_subtest("hash_map"))
@@ -213,4 +248,6 @@ void test_for_each(void)
 		test_write_map_key();
 	if (test__start_subtest("multi_maps"))
 		test_multi_maps();
+	if (test__start_subtest("hash_modify"))
+		test_hash_modify();
 }
diff --git a/tools/testing/selftests/bpf/progs/for_each_hash_modify.c b/tools/testing/selftests/bpf/progs/for_each_hash_modify.c
new file mode 100644
index 000000000000..82307166f789
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/for_each_hash_modify.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Intel Corporation */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 128);
+	__type(key, __u64);
+	__type(value, __u64);
+} hashmap SEC(".maps");
+
+static int cb(struct bpf_map *map, __u64 *key, __u64 *val, void *arg)
+{
+	bpf_map_delete_elem(map, key);
+	bpf_map_update_elem(map, key, val, 0);
+	return 0;
+}
+
+SEC("tc")
+int test_pkt_access(struct __sk_buff *skb)
+{
+	(void)skb;
+
+	bpf_for_each_map_elem(&hashmap, cb, NULL, 0);
+
+	return 0;
+}
--
2.49.0

