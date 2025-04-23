Return-Path: <bpf+bounces-56511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5A7A9961A
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79336188F863
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863E28A3E4;
	Wed, 23 Apr 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTCyc7Zh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA120F067
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428337; cv=fail; b=SJiyBzv18XYxUHCcLEzzrQYZ3cT2uuh8QCrN9gTR/5oXdUAGhCAL4youiZpZMkxmqxYh2CWQtp9Bk1hA+ud5n+TuR83zwp5HNoueec8BNMbco3NIXGIMttk0FofBnbSJXivdP2en2nCIIWriPEVJLQ+hibMORmjx8ISSctG82k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428337; c=relaxed/simple;
	bh=/KxNqbBAQRBlaaDgrhNywcNXdshjCTPOTUeUK8M27yY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Gi5p0haT54ejE6MM7GpX6qfXikOOUloytwFbEj0A8IbcXuuSou3uiyWQ3k+slsXJaGh1jv6ytx2WFf5SGiBPtUudWAWHWFUj6bQX91AOypL2DLd9S5VGFg+H8MDSAfVpFHDQWnwdjkssUkD/PnGwuToXKqCMK748rm4fS1/Wfos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTCyc7Zh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745428336; x=1776964336;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/KxNqbBAQRBlaaDgrhNywcNXdshjCTPOTUeUK8M27yY=;
  b=gTCyc7ZhpWFEn9GZnEKKVwlFdMiFwIJgIodADIvzd4pNymXobg2CtPNw
   fc6cvb20WfLDU1qMbToLLAdu16cb0jCJ6QYHpOyySVQmzmGiDVZ4hX4qQ
   HvK4nVc+hnyYO3XIokmlIoEtlDwf2x9TfQmPLGozKJGMJ9cprx/H/dUPF
   481GzQj/UnjS2BUM/c/9rCqTowDIJ1tXSMgphuOfFfDWjVF7JFK2xAsCN
   URcNEOhs80wwNMA/j7Wt293lnddz7Xjf2xEthNnffkPf69BKYU2n7l6ft
   z14up0d2a3gsJ+46Bz64ohmGHruxHUPJtNyxj/YpT6raQWq9hl2jbsHwV
   Q==;
X-CSE-ConnectionGUID: 6MC1YycyR0CqHVi3eq2XGQ==
X-CSE-MsgGUID: cmBu/UO0RpqOjmrdLAo/yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="64560318"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="64560318"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:12:15 -0700
X-CSE-ConnectionGUID: IzP5xFFCTFmcKCLFU+hyrw==
X-CSE-MsgGUID: ehPjWwp5Ra6i3yBz87Urqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137458247"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:12:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 10:12:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 10:12:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 10:12:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NK++Q/wh3zE2OqKBcfJajAEV+bBh1Ng9CWJieQLx8zELzlVYaRaj8Hc3aFlxKTBit/X7A9y3xHvqSkdbalLI26NT5ckGVn0maPom3totNWWUWiGuQT0wFLxxI0AaGDNF0jgMZfWUD/iD8MKrcGxQ5/ZiqWsjgF/GUv2K9sUJYWM7y6B6fIXZ1Nc+6PxEJaxzeuoWtPIJls0frBR7F61Am9jgBVtGYg1RQZB5cPYuP2zQkeIms93RyMbz42qZdFraLGSUMIsq7Do2a1qBpgh7y9ECuuY/Koc5T4C/EynKEcrJwcnuVXDeIXu9TPVgjRHXPdJoTdKe3qQh9hkC9CseQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A05EkygFEcSWNp0zW62uEQhylg61mjoxdSuCL3h50A=;
 b=QDa2492MIcZUGZObZZsZMKehM9U6vjmaD/MRZhoxFZRVMMG93K0vj+NyB0k2BDLmlHLS+yxLH999rDIGVx4a/KbmmbGni4Mf7OcLc7FuFyPvlJXbfwP0wCBJ0YM+A6pAD45t+Td/RJgfkp7vJZlMREyeaCVI5j1/JPoqHup3JkcwTyDEQKfURmmpP2ExxcQjYVtkDKvKd5fxyeIpHZs9gdkjbp2Y3bMLdqVby3y1jLRC0aC9I0G/2ClN6PCZrHhFKDYPT6TE0vEukZ6g8iZYoijeQpAeHKjVSMrPlwWD5dEKR6CSdcyNdh2LKQraXXIvrUYYilCdNPaFeYymxoVMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 17:12:03 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 17:12:03 +0000
Date: Wed, 23 Apr 2025 13:12:00 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
CC: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Subject: [PATCH v2 bpf 0/2] bpf: Fix softlock condition in BPF hashmap
 interation
Message-ID: <20250423171159.122478-1-brandon.kammerdiener@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 778ad50d-b9ac-47d9-f57c-08dd8289f753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x5F1kejuN/nByO08STVMIydiIda+Feym7w9iN9jSDonpcMBP4hgOtdFHauRb?=
 =?us-ascii?Q?DW6J9qSzRPpfy5+8HxaYFB/TcqgSC7epx/v2SyGL60VWPvpAzrdK75OymKa7?=
 =?us-ascii?Q?qp6Gg+d/AjNND8YKtyeimwARK1vQo+RrKwnAWRwgVJOpf/e+qqC+WYVltIWm?=
 =?us-ascii?Q?K1eFTzC5hab4uYs1rrqcU/+0cCz/NTHjNyIG3YHSlTEQJhzFWcADT8bbaUAr?=
 =?us-ascii?Q?uan1pAOVcKUiEE1jjXAuc5thwgCR97VgCRli4zp2iiTCsiA8PMwK6aWTqITa?=
 =?us-ascii?Q?E9762yS3/wTzvnw2pUrHwusGaHIJOcwkxQuszFaA6bDN0yquhEQnago8YidC?=
 =?us-ascii?Q?rlZHq7CJT6adY2oxnuIO/gBIR1CI63YohGgW8IgCo1GEsQpu5r9nV8JXasI7?=
 =?us-ascii?Q?SOQWCuvgj57MXBwouAz8fc9rD+O2AuAX/877fbK9McdrF4+Nhrgr2dcT5uaw?=
 =?us-ascii?Q?QpiTfdZ97GsPhMS1yaQ3/TdMjUIwcTITp6MSvCz+FM5gsSJBE7tz3rsRWV7D?=
 =?us-ascii?Q?PE4OKjrTcrfACtIpDhcak/A8ZbT8a8FwmNkWg7EJZCtL3+snJjEpfqxllnD7?=
 =?us-ascii?Q?xdRkLqP2bq6/rIvK5hbWLe11Yzol8UXhzCNfT7SHIJvcAhy/kw1QJRO4s4Sh?=
 =?us-ascii?Q?L758slVLTd+jYWyx0IjWS2DHqRSZ8I/ggCEvrGGPa6hdMCuWqEIlOkXVtgdi?=
 =?us-ascii?Q?AQHoV/MuxdMaHRyajswT5k7TjQTTJ6PHiVbEc9vs6g/ncHzzmSH2fvUaaNXK?=
 =?us-ascii?Q?cAAkDorckEcnAgBUfUvBArxrPVq0Rejkv91z3Gzmvl5mg3ea1giLn4/CbCAC?=
 =?us-ascii?Q?JeZSd51m9eWjo9giY1IJxBpgCdoWH9+XgYCpchyLk/oS7hYkBdx4ofDsfwRc?=
 =?us-ascii?Q?pWMgdukCSDrtXdOfpa9DSQcR/L2tM96RLUgT5C9Gip/XexmxsOoRV9t5EWQV?=
 =?us-ascii?Q?lxCdM6YWmD8xXiJKCVjN6jg/JYwB3OkYAaXUV2H+G8G9JUaNbYtd0tEfRb+G?=
 =?us-ascii?Q?OJoqsYB7QenMjkn9yUA4XUHDOlWaqgG09NRWWR99tA77UolNVy1AHqh/g6kW?=
 =?us-ascii?Q?XAWw91SuX+iIWU1iKc/zGu03oMrw9eebW6suqGBgo/ZFThIWnsC2YrD886Fz?=
 =?us-ascii?Q?S8iwLOITnxgXJXoGkM6N104rS70uy0DhGPXVu2Gcc7IDratogI7l3aFSgG4S?=
 =?us-ascii?Q?jItZIX7m5ll4rpRDev4KqY2RUscJ3rx7q8A5GCCGxwjj9FbT4MUd5uszWaZP?=
 =?us-ascii?Q?t3Zy05zc5zFzqov7wvxHVD1OeUjiV6Q0IPDKGmlXpn1u/8xA+STIL8jJP4H0?=
 =?us-ascii?Q?QBUMgNtEx3IyoTWtHLx2x6rFE7ajrhhVOfNTlcqb8VIlEzDVA5bH9IalEyqQ?=
 =?us-ascii?Q?0jkjoCXGd83I4rfnxvyBE4F0nZpW7KOS2FyO3chGkh913i5YsHNWWUAEwwTf?=
 =?us-ascii?Q?7bOcCE5oLKQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VXGpusMvbpGe0jW6cEdYrc7nLiTwlFGHuQmtqTkLtw2fXGjzScD/s7GXVRfa?=
 =?us-ascii?Q?b2BhvlM4e+l3ARpzOwsZKw60o1K5TvRlek0vXsQZU3awKMxMa+JfMWvr4Us6?=
 =?us-ascii?Q?c5Y82KkeesZ86PiusZqFckDzGh3jxcQ3JuFlxYqWtvUerdU0vGotxjJ2Rymu?=
 =?us-ascii?Q?kfaEFiPuIsdFPXSi2e8TS6eRQa3fEPGRcXJT+iK50I0YpEPZk8iAcj8uDCVg?=
 =?us-ascii?Q?2c754dGmNCPUP27DWbaz9r9AM2sYjBBfNphju+jWIo9jNUtt9KHGZ7FJ3s0C?=
 =?us-ascii?Q?ioZwP1MqV/Sq1cB494oA5oEWUfLA6obyAP62j5Esh6JQlOz5DqFx9qz71HlF?=
 =?us-ascii?Q?40b1/xaYfy+TsvXCglfPo9pjLWxWS/llXl8DmB7WM2zZDF2pbHHTzStTYMcD?=
 =?us-ascii?Q?d/vAHUGmz/lIaduaSAjveANi7OuLOm5YUEZMJ+NLl8fPi1p1ZDB6/G1rxleB?=
 =?us-ascii?Q?zDzPvLcbzXs4Sg39moB6PE/AuvwbN5hrRA9+NCLwHhfehBHYgzayvK4tPPEA?=
 =?us-ascii?Q?UwOXBY1/64D+NH844W5Ykuzn1/TO8kqvjdV4gudqJ2cEobZfId3zRdH7XDcx?=
 =?us-ascii?Q?eb0f6ZhNiEVObRYdqhe35Mc6WYLc1iYSXgCun6DG/o8qvANeFxty1fswoa/B?=
 =?us-ascii?Q?H7sF8XBBUHbq68Jgp5yDh+QUGh2M71hbzwfeYyDqVH7KH0m3yV9cU0Bzo5F7?=
 =?us-ascii?Q?X/NLiPON6mqo633M3TTWW0LoTpwL0va87lZjIEbh5CahHTu3geUrPMjyo8sb?=
 =?us-ascii?Q?vlPQaqaMNhmyWpGyxQ6whDIkRdegdmBjuhg35ezfxX2rr4jIBWzSQmVtgTD1?=
 =?us-ascii?Q?Cog41SuuhX9HBSXaN1FeaPVtDNZ9yYlwheqdkcpzCPLgAGDfWWopmNLljFsq?=
 =?us-ascii?Q?WHYmARjJBh3ps/vS/YklQtLHFzavp6/apLeke+6jscSHNE/baEJGOCw3uZS4?=
 =?us-ascii?Q?zTEy0Yyr02JxxCd1wuLHn4YJ4QoRNXS/4KQuk6LiXlhdUmyrhR8Kyq5H/N+r?=
 =?us-ascii?Q?+RW1calkKQib3s5ROGgBK5OgF/nTZDQZ26VGaKKcDHXRt8ZJtD+OHcmaIm96?=
 =?us-ascii?Q?+4vOOUsxUSOdxVE2xhHb3OWslSMg+T/WxOwXvbBght3XRBuQ+WtMCaj7Ev6p?=
 =?us-ascii?Q?TtIJeR1+HbV2Lj/Q/J2qTrFVHWxSbwPeR3M7xqgKeB8UP3l7sV0qbpb5KDsp?=
 =?us-ascii?Q?PzPWNxUgkHEW9GR3NRtBc+g49KRO2uVNnP5cLIWuXAvw+tJLaFOZKavKW0/j?=
 =?us-ascii?Q?Majec7+VVf2zwv+XSMFBxZz7lsY379n+MCcXcQGCK/pW+v95O6CfSJf7Fvh5?=
 =?us-ascii?Q?epb8iBth6bAsR9ad5MpquqaMeHRbWLqoZRhxmKmMo993asnHPad6waKkBJfj?=
 =?us-ascii?Q?ix8WpxAKFIVVzF7eCLkhwFS/cs4UGVhQUNK34qTrOuYM0mAsDlMjH9/EZAkt?=
 =?us-ascii?Q?AfyGdKw6S6NcFjIWlYGhZvRxDycHGEONh4F+0fASE8a0Vz7PYwUBer/ps7EU?=
 =?us-ascii?Q?BU08AdRYHlWljWHGsdRvte4UudLIw0Qi24/bZTKz063SoJd7MHzmk5xfWVyw?=
 =?us-ascii?Q?dpeLifjZBTbpZ++1Py+8nnUs/0ZSCbaWfHU61ywWMqvIAi422Itah8cIflni?=
 =?us-ascii?Q?EZwkZyE+ukgEbaui3NhILnQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 778ad50d-b9ac-47d9-f57c-08dd8289f753
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 17:12:03.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShVFTZW/+pZAgs80JSQHzDRysiCbXMwpgr0j/zDbofr6hu3wXqsWNmXHj0+E30355wifNYdU8HNTjLVY1PVJ/kv/u/IL7CUwhhfq7NWAONQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

Hi,

This patchset fixes an endless loop condition that can occur in
bpf_for_each_hash_elem, causing the core to softlock. My understanding is
that a combination of RCU list deletion and insertion introduces the new
element after the iteration cursor and that there is a chance that an RCU
reader may in fact use this new element in iteration. The patch uses a
_safe variant of the macro which gets the next element to iterate before
executing the loop body for the current element.

I have also added a subtest in the for_each selftest that can trigger this
condition without the fix.

Changes since v1:
- Added missing Signed-off-by lines to both patches

Thanks,
Brandon Kammerdiener

Brandon Kammerdiener (2):
  bpf: fix possible endless loop in BPF map iteration
  selftests/bpf: add test for softlock when modifying hashmap while
    iterating

 kernel/bpf/hashtab.c                          |  2 +-
 .../selftests/bpf/prog_tests/for_each.c       | 37 +++++++++++++++++++
 .../bpf/progs/for_each_hash_modify.c          | 30 +++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_modify.c

--
2.49.0

