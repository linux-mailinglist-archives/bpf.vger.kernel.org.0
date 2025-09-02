Return-Path: <bpf+bounces-67162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D88B3FD22
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 12:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B734163ACA
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38B2F617B;
	Tue,  2 Sep 2025 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWE9ooif"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99C2F5485;
	Tue,  2 Sep 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810570; cv=fail; b=Xa0MKi+jAdqar9uYs/th3rg/eA58yQvWi4rP7wXp3INQ3L8tJ2Q+VFbBEUs9P03NO3wRQBEPa9gFOwrxe8cRofab1oxXX6iun2a8mAgO0IcOxV4QyL5WPiynQ4AhZYSyCG/mqrTztmo4OLdcTgdl25yXFz1biMXq4UrFAYoA+ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810570; c=relaxed/simple;
	bh=CFmyCALC9liGSt98tMAoScGsFK/DZRjPYM8wQDVPUb4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tHKW87ZkgJp6CbxcMFKasth3wdkEp6oDHKHklL9ttckbdWtU6aV+Ic9wI8Y7c/0Ac8euT8Yz2sK8Z142iv7KodXCjLv8HGzTclodohLX+vgS9xS0H+ILrE4PtpHsSSWOQdYP22MhyXx6mU1fhRMT1cR7I0gI2Lj5GZltYe/hYxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWE9ooif; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756810568; x=1788346568;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CFmyCALC9liGSt98tMAoScGsFK/DZRjPYM8wQDVPUb4=;
  b=WWE9ooifWSHQ04NEUAKWu90ITkk7MarIS9hqpJEs9Rg/+CU5YNbBK1lS
   gOyW8tedE65JzA+SNEcOq+vl1WYW3ArqC53nyinoffiBLb4XQjN7clv6Z
   w1cKu225/RlCGIQSH0AoP3YQiozV2Txr2LU2q8bYYF0cVbAsHz3Hml5s2
   Bp7KzU9UMTZpl/oEZifXDJpU5O92Bgat9NKJNd/kwPdpGhUznPpaKSUke
   l0U5XEkJbRZ01WQ206BQSp2hFI1MsnvI3KWIWnlPWqxDDUggrTABeLA0o
   Ef+L68maluogFuKSk+hPum/pTdcDi/Pc9Oa64YhSw3LnEmPxKwnGbqCal
   g==;
X-CSE-ConnectionGUID: PjwSSCawTHmBzL/8LJZvww==
X-CSE-MsgGUID: e9hnKbqISa+2fvnps/xnPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59188453"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59188453"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:56:07 -0700
X-CSE-ConnectionGUID: HeZbg9/hS0iRLeEyOEOPlA==
X-CSE-MsgGUID: myoji2qfR8aDu8lrM0kEpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176563960"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:56:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 03:56:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 03:56:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 03:56:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up2qGhOxoHjrk4tG0XgoOSrk8Oz9r6uN++sTf9bq53z1ENMXd5xRC4h3ZVlrG53VhHOp3xi3j2qtAs5H8l7hAMM4VZIuKfZA48d2uMbK4u5kmp+abX9RAqKjGpTH18PstyzW+wVEdC8z/7M0rl1WkT5wncJFHpUzq3XWo3/DWOWby85jgRUVstCN9YH+IfVMozEzlYlz7zNl1gtoow0/8VLSgfjRHHwvakZweZXfJT5cJctxpDF6LjFtojT5HMP6iKiHKgedfnXBpdXzypAhI2De903UtAw/+7V7tQmpCT1JZEg4MB7sXIhxkosVsjyHm+wiG2dcqQG/oKP8prY+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfAchj+hUBZcS2u9bEb8vt4AaympDi5mxJHQ8IuR1Co=;
 b=g3pzAGMAtaMruw9TFnZfCJMI8qleoEsAmpUiuHQvFdoPoVOd8To4iyDRKgKrQFqfjzaglylvLQ7tqsTrwyBCnD8zl2Cbs2tXsVhJK0mWNrS6+FOZ34wqqN321OzqI1P7fNhkFHQwIWtLNcA4YPmChYtffjwd+eR2HODvdOLIL/0NxQx23BSDZoPgF89NIBL3lrXlxP7nWnE6ifhYWW/A9r48ghxbq3BY1q5qNiZTrL1XxDVFVi11JWpwljd6IL9Hi/N3NjYyb/jHysmIMK14YSh9ormit9/VNj05Ib4D7NYC/RPc02vEoqfxBtd8IcobVeKYuHbllcCmOdDFTmKPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4782.namprd11.prod.outlook.com (2603:10b6:a03:2df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 10:55:59 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 10:55:59 +0000
Date: Tue, 2 Sep 2025 12:55:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v7 bpf] xsk: fix immature cq descriptor production
Message-ID: <aLbNNInuSjkC5qbI@boxer>
References: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
 <CAL+tcoA2MK72wWGXL-RR2Rf+01_tKpSZo7x6VFM+N4DthBK+=w@mail.gmail.com>
 <aLYD2iq+traoJZ7R@boxer>
 <CAL+tcoAKVRs9nnAHeOA=2kN3Hf_zSS5z64yUSEVmtiS82zz3-Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAKVRs9nnAHeOA=2kN3Hf_zSS5z64yUSEVmtiS82zz3-Q@mail.gmail.com>
X-ClientProxiedBy: WA1P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::22) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbb5534-58a8-4fac-52b4-08ddea0f4cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHh2eXppblhKUHl1SmYwSUdlTWFRMVk2LzN4NGt1QVBuZ0M3VkdqL2ZSMzU3?=
 =?utf-8?B?eDhzM1VQakV1bXE4bEpBcGViVzhJUVgrLzNPaURLUkxqUkV3elhSNWdjeW45?=
 =?utf-8?B?OXhIaWhhbmZ6eGFaU0NNSGN6RFJ6ZWFVd2xYelFEMFdmYU1FRVNnK01obG51?=
 =?utf-8?B?eHdOWkpSR3o4YllrVVdaQ3lIdGpCcllpc2xIaFFnaHlrM1BPT1pKT3FKdTVv?=
 =?utf-8?B?QTB5eFVEVVZFZ0V0Z2E1ZWszYzA0L0laSzF3a1lsWExIaUhNRWtrK3lETXdx?=
 =?utf-8?B?RkFiQTZpa0d0eUkyM0xMKzFETEU5b0ZENCtxczhUeXRUblV3SkJDRkNlUTRV?=
 =?utf-8?B?U0Y4QzdpMENLL1lOR3hOZ0Nxdk5DRkdCR1lhV3Q2RW5LRTF3RFpRMkFCVmhB?=
 =?utf-8?B?ek1CWWxacGtpKzBjSlF6QkNZaHlFNHdjOE1TUVFoc21NcVMxZDZxYXBSUTR5?=
 =?utf-8?B?SUpIVS9DZlkybTFua2lIWTB2eXNxMHBjSjFyQkRRNnIwUzVFWmxuZWpWUUZk?=
 =?utf-8?B?d3RTZTdsN1dJRW9QUXdYTDR3UjVKYmRQalA1TUd2NXp2SVVWVUhYNHhobXdE?=
 =?utf-8?B?aEFaR0UvV0RTd0U5UGRyNlc4dG8vNlMySTJIWHVNN01ORnpSSEhUeGVOeVFT?=
 =?utf-8?B?aFFpK2VoZmtRRkFQSFNkaGczMlh1VUhuRyt3RHZmNzIzdTlWTWJTOTRMUFlw?=
 =?utf-8?B?QUpMNEh0R0hFWEhOTSs3NUY4amExbzhrdytBUWpqY3VZcFdlNkNMbjlId29H?=
 =?utf-8?B?WWd4Qm5YOEtRTmlxYU5vZzBCbHM1UzJ3L3pJcmprM0oxUkVOR0FlV3ppdVNW?=
 =?utf-8?B?RmdGcVlBNlQzSmpNNWhQSkZsUzViUHFCVVFKS0t6SHVGTGFtblpZUTFGMTFa?=
 =?utf-8?B?STFJV014U0I5UlZKditNRGZVQUxKWU1QWWZialBETXhRdUdUbUJDVDRuQUho?=
 =?utf-8?B?d0hyQU54K25McE9SQjNmajIxbmNOK0FnV0R6d292VkJSMzdheDFxT0xyVU5R?=
 =?utf-8?B?VmFrUjNyV253ZXpVVWhsZFFaTTVKQ0d5MDV4ZXVyN2YrVWpvT3EzS0syVExi?=
 =?utf-8?B?YzFRTzY5bWsySFBLd2F1cWRxdlgrbUxxRGMzSnUwaWZpRUdjNS83T3NpbGx2?=
 =?utf-8?B?MWpsa0llS0o1cDJtczRKTktDemRSZmttb084MU42SSs2WTF4aXVmb3R1Nm9n?=
 =?utf-8?B?bzlNMmJHMnN3RnZxS3ZzUVk3QURaQmhWZWl5dS9MZ1ZqOUNBVDhUWm0wbVl1?=
 =?utf-8?B?UFRFVTBTOERuTUw2Z2gxUENjdGo4Nkhjd0tJa2ZJMFFQQ1lzR09NRTFqRTZR?=
 =?utf-8?B?WEJST2VVN0xPeFp0ZVZSK3NPVXNwMUpIQkFHRGtlZ015TnM3dFhiT0Z3ZTZB?=
 =?utf-8?B?aGlBWXUybmRRUENaSi9wNlZ5OFZNMEYwWVpuU2NTK2lWa3lBWlFyUGphcW5Q?=
 =?utf-8?B?cnJPSjFTeUJqR25SQzJJQ044b01XdDkrUTROaDBvZlkwcGZyQ0xUa01LbnNM?=
 =?utf-8?B?TVMrT2wvekx3VXQ2U0tsTElQNkoySmFQTFMvS2ozOEJTQmFqMHJEd3hPWU9B?=
 =?utf-8?B?R01taCt2WHVCazdjQkdTalhvNTBEcE5WQzd0THNkclIwOGdFRFpTbG5FQU5I?=
 =?utf-8?B?ajlPVkVTcCsxQlVMZXRPQ1BoY2FRWVZuUHI2T1RoVUhvdCs4d2V3ZXAwQ25y?=
 =?utf-8?B?bExJZ3NxOG16ci9lYWN4dGs4RitnSytTMjNWSUFpRGNFa1BVZTlQR0lpT3M4?=
 =?utf-8?B?amloV2V6Y0tiUThmRXl1VWNhV1hmT0Y1ekMrVmdRVVI5Ym1mdW9VaEdaSkVi?=
 =?utf-8?B?R0VQcXdTM0U1MHJHK1FZeHhXcVVxS1RSMHgvVHdwMS9JdmlqUE1iTWQ0cjNW?=
 =?utf-8?B?eEZ6WmRYc3cxZURxK2crNE9MRm9XS3lPYXdUeXBuNGR0OS9BWG0rTUdHOXFT?=
 =?utf-8?Q?zvCuSV2JvpY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDZqMGppQXJoRE9WQ0hvSG1lTXNMNnphT1E4c3F4T1JwVVkwU1dtNVYrT0lv?=
 =?utf-8?B?Zk9MZkRzRmlzaXI0TWQwSnR2V2wwbFlDdFVCa0k5cmNNWWVBNjBHV0FqSkUr?=
 =?utf-8?B?TTVJSVBxdnpvRmRVRzBuelFUQW15WlJMajNOMnhvY1lRaGlYSVVsZ0kwMVlF?=
 =?utf-8?B?aU9VRDBqejJ4Z21uZDltbUlCdk1RaXo5Rm95dDZtRzE4cDRKcXh2bUNYU3Ay?=
 =?utf-8?B?M0J4cGtDdlhRcjdKL0JISnBsL0I2bnhWZ3lvZ1NrOTc1NGdKZW9pS2hSYjhZ?=
 =?utf-8?B?MktUUGlYenJFYU1DT1FDYzB5U2x0OUtrOTJtRzBBOWE1M0t1ZVpyeWFMWFlv?=
 =?utf-8?B?Z04weFJiNzYxNjFQTFYwS05vRTB2cWFnSTh4WVZKSmZhRCtleDdHL2ZHVUlK?=
 =?utf-8?B?cnNqaFJtc2pqSW8rOUdaQXhDUjU1cUd5T21aZHlML0svbUdDbk8zNEFnZ3No?=
 =?utf-8?B?MFoydDdUanZ2TVZ0aU5nTlNjMmF6dC9tbWQ4eDYzK2JtTGVQTWNRd0lqT2JI?=
 =?utf-8?B?ZTYxb0lkaDVmSlkwcHFKcDg5b08vVS9hWlRxVHA2eGN4Yk9PS2xQNkZCOCsw?=
 =?utf-8?B?TXc1VUh0c0RWeldOQmd5OXJDcHFnS05tRnVWNTFkV29SblRLMEZNcGtIMXMz?=
 =?utf-8?B?OE0vYzdjR2dxTHNnZ0ZLckplVVNqY3hhMmwxajRUanpEQXNsK3h5d20xTisr?=
 =?utf-8?B?SmFGTzcveTRZZ1U1Y0xtbFVocjBLa05SMkU3UFJIdE5TS2tmQXBtWmZBVkpU?=
 =?utf-8?B?TkdHOWNmZWFjeEliMm9lUWpyQ05hYTlwMVJDL0tDaXFhRE1iUStVbUJ4UlFN?=
 =?utf-8?B?bjBrc3E0eHZ2TUxSYVFkYkhtTmNIK1owTWVITkVmd0ZHWWdJSFpialZVOVUx?=
 =?utf-8?B?a0VsdjVVNkRXc3VLTTRPSy9kRTg3aGJMeUNpVEJ6WWJQckxoT29icGFGbk9L?=
 =?utf-8?B?MkhQNDlQVGdLK1VodWZmRkNoVnNJZzlhZC85OGM5UVI0dUV3RGYwUGRGOSs2?=
 =?utf-8?B?bnlsbVVDaHVMaWhWNHNhaUc0RHd3TG04VEVCTkpuU29jREM4OFRab3NMWUNT?=
 =?utf-8?B?QzQ2T2J2bjk2WHR2eXd5alJpb1VZRDN6bEZNZWVYSjVvbitLOW9yWXFhTWU4?=
 =?utf-8?B?d2xnLzA2VGw0VXRrZnNjT0MxSWgzdjc0d0NTazltOS8zbXdpdnNXV0hUcGlp?=
 =?utf-8?B?ZzVVcDlSU1NJYVgyYm1VMTkrUGNxMVdxMENmQ2I1MHROVktPdVhkT2Q2My94?=
 =?utf-8?B?RzY5LzYyeEZ3ODBZRXplK0FjYTcwdlp6QmJ1d0g1SnB0LzRBWkFzdGtJTkdk?=
 =?utf-8?B?L2cyZHZvSEtQYTZiZmpHdXYwVzRkNDRQNFpkZFZmdGZ4U0F4bmQyZTVlZkxl?=
 =?utf-8?B?aHdiNEQ3UGZKeW5wWE92bW94eDNFMVdmbUtJVWFtcmhaZ2NCZ2FtQlJ3TmdE?=
 =?utf-8?B?bGkvRGwyWm5uOVZ6aDV0UmFGT25MTmkyc2FleC9ZZkFMWExkV0puTHpnNXhi?=
 =?utf-8?B?T3FWUU5oMWdPSXQ2d0tPWmpxZkZPeFVoeHpLT2hWYXQwSmhEc2NiWXNBaW0y?=
 =?utf-8?B?TEZJVkxaM2Q2R1paV2RJYUw5VEVjeUUzMTBQWnBoOGZwalFicnZmMzhLWkZu?=
 =?utf-8?B?Y0hxemZnQXR5RU91WEtnS3dwMk1VOXBIMm16S3lPK0VMNXN5ZEFPZlMrUjdF?=
 =?utf-8?B?RFBQV3p6ZEZWVkJYcTNVeVFKcjRHT0c4NGlqVFQxdWo0d3dER25nTUZSc0pT?=
 =?utf-8?B?UFdpSmlLNWxDNTlBUmVaK2ZMWVFEWHVaUEVOQzhtVWhNRVlNWFBwcWlyS01t?=
 =?utf-8?B?MlRmcEpIdE05N3luMkxhTjUwaG9pRHk3c2t4dUZLZ2FsT0hPTEUzY3lIR0x0?=
 =?utf-8?B?d3pEZE02RFk5MDBMVDcxMnU3M3dreFJ6b1ZJd0EyQnBJWmovQlRwNVlQUGow?=
 =?utf-8?B?alhzdVBrTXpHcUxzRnJoblIzcHBINEsrNFg2dGh4cWwva3E2MGNHd1JXbmp2?=
 =?utf-8?B?QUNUV2FrN0ZGcUhzWmowUjRBZnk2c1FMVU1wQ0pIaWVGOFNSSE5JcFN5cDMv?=
 =?utf-8?B?UW85VlZCWG9pOXlmWVdjR3JpdEt5OTJ2VnJnMTRIQnlYSStYblRMbCsxR1NS?=
 =?utf-8?B?QkFzZ3lqLzB2c1E3cDdxMGN1eEsvZGpaY28zQjJjSERRckdtZDZQTUdCQ05X?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbb5534-58a8-4fac-52b4-08ddea0f4cdf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 10:55:59.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0z587bWgbPu7VRwLhExdEnAVOS/wRf+UjgG7R//nsHigjVGa/tHUui3WQgFbs45Z8WzsogHGcNPsES+HxSm6aBC5Eagb43Z9uZyltojimE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4782
X-OriginatorOrg: intel.com

On Tue, Sep 02, 2025 at 08:02:30AM +0800, Jason Xing wrote:
> On Tue, Sep 2, 2025 at 4:37 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Tue, Sep 02, 2025 at 12:09:39AM +0800, Jason Xing wrote:
> > > On Sat, Aug 30, 2025 at 2:10 AM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > Eryk reported an issue that I have put under Closes: tag, related to
> > > > umem addrs being prematurely produced onto pool's completion queue.
> > > > Let us make the skb's destructor responsible for producing all addrs
> > > > that given skb used.
> > > >
> > > > Commit from fixes tag introduced the buggy behavior, it was not broken
> > > > from day 1, but rather when XSK multi-buffer got introduced.
> > > >
> > > > In order to mitigate performance impact as much as possible, mimic the
> > > > linear and frag parts within skb by storing the first address from XSK
> > > > descriptor at sk_buff::destructor_arg. For fragments, store them at ::cb
> > > > via list. The nodes that will go onto list will be allocated via
> > > > kmem_cache. xsk_destruct_skb() will consume address stored at
> > > > ::destructor_arg and optionally go through list from ::cb, if count of
> > > > descriptors associated with this particular skb is bigger than 1.
> > > >
> > > > Previous approach where whole array for storing UMEM addresses from XSK
> > > > descriptors was pre-allocated during first fragment processing yielded
> > > > too big performance regression for 64b traffic. In current approach
> > > > impact is much reduced on my tests and for jumbo frames I observed
> > > > traffic being slower by at most 9%.
> > > >
> > > > Magnus suggested to have this way of processing special cased for
> > > > XDP_SHARED_UMEM, so we would identify this during bind and set different
> > > > hooks for 'backpressure mechanism' on CQ and for skb destructor, but
> > > > given that results looked promising on my side I decided to have a
> > > > single data path for XSK generic Tx. I suppose other auxiliary stuff
> > > > such as helpers introduced in this patch would have to land as well in
> > > > order to make it work, so we might have ended up with more noisy diff.
> > > >
> > > > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > > > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > > > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > ---
> > > >
> > > > Jason, please test this v7 on your setup, I would appreciate if you
> > > > would report results from your testbed. Thanks!
> > > >
> > > > v1:
> > > > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > > > v2:
> > > > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> > > > v3:
> > > > https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
> > > > v4:
> > > > https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@intel.com/
> > > > v5:
> > > > https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> > > > v6:
> > > > https://lore.kernel.org/bpf/20250820154416.2248012-1-maciej.fijalkowski@intel.com/
> > > >
> > > > v1->v2:
> > > > * store addrs in array carried via destructor_arg instead having them
> > > >   stored in skb headroom; cleaner and less hacky approach;
> > > > v2->v3:
> > > > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > > > * set err when xsk_addrs allocation fails (Dan)
> > > > * change xsk_addrs layout to avoid holes
> > > > * free xsk_addrs on error path
> > > > * rebase
> > > > v3->v4:
> > > > * have kmem_cache as percpu vars
> > > > * don't drop unnecessary braces (unrelated) (Stan)
> > > > * use idx + i in xskq_prod_write_addr (Stan)
> > > > * alloc kmem_cache on bind (Stan)
> > > > * keep num_descs as first member in xsk_addrs (Magnus)
> > > > * add ack from Magnus
> > > > v4->v5:
> > > > * have a single kmem_cache per xsk subsystem (Stan)
> > > > v5->v6:
> > > > * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fails
> > > >   (Stan)
> > > > * unregister netdev notifier if creating kmem_cache fails (Stan)
> > > > v6->v7:
> > > > * don't include Acks from Magnus/Stan; let them review the new
> > > >   approach:)
> > > > * store first desc at sk_buff::destructor_arg and rest of frags in list
> > > >   stored at sk_buff::cb
> > > > * keep the kmem_cache but don't use it for allocation of whole array at
> > > >   one shot but rather alloc single nodes of list
> > > >
> > > > ---
> > > >  net/xdp/xsk.c       | 99 ++++++++++++++++++++++++++++++++++++++-------
> > > >  net/xdp/xsk_queue.h | 12 ++++++
> > > >  2 files changed, 97 insertions(+), 14 deletions(-)
> > > >

(...)

> > > >  {
> > > > -       long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > > > -
> > > > -       skb_shinfo(skb)->destructor_arg = (void *)num;
> > > > +       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > > +       XSKCB(skb)->num_descs = 0;
> > > > +       skb_shinfo(skb)->destructor_arg = (void *)addr;
> > > >  }
> > > >
> > > >  static void xsk_consume_skb(struct sk_buff *skb)
> > > >  {
> > > >         struct xdp_sock *xs = xdp_sk(skb->sk);
> > > > +       u32 num_descs = xsk_get_num_desc(skb);
> > > > +       struct xsk_addr_node *pos, *tmp;
> > > > +
> > > > +       if (unlikely(num_descs > 1)) {
> > >
> > > I suspect the use of 'unlikely'. For some application turning on the
> > > multi-buffer feature, if it tries to transmit a large chunk of data,
> > > it can become 'likely' then. So it depends how people use it.
> >
> > This pattern is used in major of XDP multi-buffer related code, for
> > example:
> > $ grep -irn "xdp_buff_has_frags" net/core/xdp.c
> > 553:    if (likely(!xdp_buff_has_frags(xdp)))
> > 641:    if (unlikely(xdp_buff_has_frags(xdp))) {
> > 777:    if (unlikely(xdp_buff_has_frags(xdp)) &&
> >
> > Drivers however tend to be mixed around this.
> 
> I see. And I have no strong opinion on this.
> 
> >
> > >
> > > > +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> > >
> > > It seems no need to use xxx_safe() since the whole process (from
> > > allocating skb to freeing skb) makes sure each skb can be processed
> > > atomically?
> >
> > We're deleting nodes from linked list so we need the @tmp for further list
> > traversal, I'm not following your statement about atomicity here?
> 
> I mean this list is chained around each skb. It's not possible for one
> skb to do the allocation operation and free operation at the same
> time, right? That means it's not possible for one list to do the
> delete operation and add operation at the same time. If so, the
> xxx_safe() seems unneeded.

_safe() variants are meant to allow you to delete nodes while traversing
the list.
You wouldn't be able to traverse the list when in body of the loop nodes
are deleted as the ->next pointer is poisoned by list_del(). _safe()
variant utilizes additional 'tmp' parameter to allow you doing this
operation.

I feel like you misunderstood these macros as they would provide some kind
of serialization mechanism.

> 
> >
> > >
> > > > +                       list_del(&pos->addr_node);
> > > > +                       kmem_cache_free(xsk_tx_generic_cache, pos);
> > > > +               }
> > > > +       }
> > > >
> > > >         skb->destructor = sock_wfree;
> > > > -       xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> > > > +       xsk_cq_cancel_locked(xs->pool, num_descs);
> > > >         /* Free skb without triggering the perf drop trace */
> > > >         consume_skb(skb);
> > > >         xs->skb = NULL;
> > > > @@ -623,6 +668,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > > >                         return ERR_PTR(err);
> > > >
> > > >                 skb_reserve(skb, hr);
> > > > +
> > > > +               xsk_set_destructor_arg(skb, desc->addr);
> > > >         }
> > > >
> > > >         addr = desc->addr;
> > > > @@ -694,6 +741,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >                         err = skb_store_bits(skb, 0, buffer, len);
> > > >                         if (unlikely(err))
> > > >                                 goto free_err;
> > > > +
> > > > +                       xsk_set_destructor_arg(skb, desc->addr);
> > > >                 } else {
> > > >                         int nr_frags = skb_shinfo(skb)->nr_frags;
> > > >                         struct page *page;
> > > > @@ -759,7 +808,19 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >         skb->mark = READ_ONCE(xs->sk.sk_mark);
> > > >         skb->destructor = xsk_destruct_skb;
> > > >         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> > > > -       xsk_set_destructor_arg(skb);
> > > > +
> > > > +       xsk_inc_num_desc(skb);
> > > > +       if (unlikely(xsk_get_num_desc(skb) > 1)) {
> > > > +               struct xsk_addr_node *xsk_addr;
> > > > +
> > > > +               xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > > +               if (!xsk_addr) {
> > >
> > > num of descs needs to be decreased by one here? We probably miss the
> > > chance to add this addr node into the list this time. Sorry, I'm not
> > > so sure if this err path handles correctly.
> >
> > In theory yes, but xsk_consume_skb() will not crash without this by any
> > means. If we would have a case where we failed on second frag, @num_descs
> > would indeed by 2 but addrs_list would just be empty.
> 
> I wasn't stating very clearly. If the second frag fails on the above
> step, next time in xsk_consume_skb() the same skb will try to revisit

you meant xsk_build_skb() I assume?

> the second frag/desc because of xsk_cq_cancel_locked(xs->pool, 1); in
> xsk_build_skb(). Then it will try to re-allocate the page for the
> second desc by calling alloc_page() in xsk_consume_skb()? IIUC, it
> will be messy around this skb. Finally, the descs of this skb will be
> increased to 3, which should be 2 actually if the skb only needs to
> carry two frags/descs?

You're correct here! Even though it would not hurt later successful send
case, other paths that use xsk_get_num_desc() would be broken - say that
you failed at one point with kmem_cache_zalloc() and then you succeed, you
have your full skb that is passed to ndo_start_xmit() but it ends with
NETDEV_TX_BUSY - then even xskq_cons_cancel_n() is fed with wrong value.
And regarding alloc_page - skb would carry doubled frag in
skb_shared_info.

This is rather unlikely to happen, but needs to be addressed of course.
There are two approaches, either we do the allocations upfront or free
whole skb when kmem cache allocation fails.

I'll send a v8 with this fixed, but overall this path needs a refactor...

> 
> Thanks,
> Jason

