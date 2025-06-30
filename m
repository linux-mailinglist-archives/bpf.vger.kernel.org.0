Return-Path: <bpf+bounces-61819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1BBAEDCB6
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86070177712
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D9289E13;
	Mon, 30 Jun 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lp+Dyfcr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA6289815;
	Mon, 30 Jun 2025 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286347; cv=fail; b=J/IRf8VM7a4NlizPsbi80a1Xek4IQPiRyZrYZ3kD073kZUwOkzzJY3dQf6VCVAB9vc4seXkVIKIECF7aDZKpBSf5tN5bLICbh3jiHsEIndgrlKgbB8S7PjXp38ozeKSUE1XsF9NPI6fVOYnicMvFrBB9DDbgjhA70M+KqY0HWHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286347; c=relaxed/simple;
	bh=+564FT5QPQx6xNrz2dn8njZ9sE/o81TiZ3jxzBk1VTk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jYE1JYy2iPlwRELbIFvIr2iLf+SG2gKvZ38EvLAUQYbPYHRdex800zpoqMCQtZyQ9jJylpAQ1yb1e5jlnkQ/TPey+J9AMeC2vCzJRIT8W9LibFTTk48tkvQBLHa1B7hNK764TGXt1Dky2z5frzlqJGoZCIyyRXX+YvE05waeem8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lp+Dyfcr; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751286346; x=1782822346;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+564FT5QPQx6xNrz2dn8njZ9sE/o81TiZ3jxzBk1VTk=;
  b=Lp+DyfcryKXti7U5YeJlh/EHQej19ELsGIuk7jFDe3Ltr5JdJnLdVjHI
   EE37L/at000MCO1QMdROc8KQ6pZMrEJsgUcc0rmxck8EHnsMdyc6h80XP
   jC9XNbnIBMXR3RE38PyQzWyi6d5Xr74bINR8hqE7C9oFfeHOiI1uXYzcm
   txvmb/1Ra4Bo/Y0Lbustd07g29HUJy7rY1BYFPyVXUjJBa+bT2wKHCzJi
   tckzc6cvhdPi5X5XyxC6EKh1gs5u4OYTFhhkIuqoL4DWO5p/UjF/IpiWB
   UDvbHwegqiqHsMNkbx9+Y5ZJ6o+rZHmvd1sisUcayz7bwCvt8Ns08ATOz
   Q==;
X-CSE-ConnectionGUID: /QvQwU2URQuTabbMVvbzVQ==
X-CSE-MsgGUID: EFZ/eWNrRBK0c9eA8OKTRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="76059318"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="76059318"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 05:25:45 -0700
X-CSE-ConnectionGUID: 8BqTW1jERjCVyC9CHIFYsw==
X-CSE-MsgGUID: R4Lvr7XWRUGwPcKFcJHRmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153746929"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 05:25:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 05:25:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 05:25:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 05:25:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuRRmd4JSwYOnCAJc8EKvb8FZL018w9hWJx2ynkZPehlPTgTnW8bv1bSDcgJBMwQIx2m61DvL2OfIFxJOakDsmIYEMXtPy1x/8Ck07tnDo0XWRIKjVZR0DbbdYIV1mLvraBVnFc9zNRcsiBR9jNOUXrxADVEsvs/SVDv0kRTizMcgSejifKyffinpTz8tx98fwXnK6AzMbA/HKdIKRpL+F9i9hU7aS5hpUUNUU01Bj75TZ8Y85qQhFq5iWZhPufIP03sGxwt3iKGyXWC44uTZK9iqBIQdm9qrT2M3s3AOHeOWFPxCJhOicYPnkrCqj6FJAmAG0My7bff/suJOUBHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ3s3pbew7VuHL2E/HM7VyiYm/GdmPfO0CEgp5+Th8g=;
 b=sRF9OdQTvP/vN2et6BBemA71W5PFCJ6+wKuAVX1qPNnpbQWxM5+ku2DLAgjsQC8ry83YuGFr8pPyHHjahEu/COLWicqIAHQiNevZLgaCuYflFc/5+z5wshR+gAETMY2H4lE+EQG6nvyLBZFdelxNwZHKTZJoV97fpWRWNyQYXluz/fQ8gfGpioPvcJn/E85vtK9ITeaIiMESSLiQiYJfaAAHTbZqxmb/IPy/xQ8gtcF6NWvRlK8SqTxVT7eT/34/fdK5yZcEw0HsIabK3U6EgEmeNJWD3kR4gdsbK5BIq/BQCh6r+S+WMU12lNZE7Hculv9ZIK6v3TE+mhK8c8lIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Mon, 30 Jun
 2025 12:25:36 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%2]) with mapi id 15.20.8880.024; Mon, 30 Jun 2025
 12:25:36 +0000
Date: Mon, 30 Jun 2025 14:25:23 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <aGKCM2z1I85AAXFc@boxer>
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
 <CAL+tcoCSd_LA8w9ov7+_sOWLt3EU1rcqK8Sa6UF5S-xgfAGPnA@mail.gmail.com>
 <CAL+tcoCCM+m6eJ1VNoeF2UMdFOhMjJ1z2FVUoMJk=js++hk0RQ@mail.gmail.com>
 <aGJ5DDtFAZ/IsE0B@boxer>
 <CAL+tcoB+_5p4V3WgMmpGnrjj-+axTDkhKoYS=1cMKxTRs68JAA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoB+_5p4V3WgMmpGnrjj-+axTDkhKoYS=1cMKxTRs68JAA@mail.gmail.com>
X-ClientProxiedBy: VE1PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:803:118::47) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN0PR11MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a14d0d-553f-4810-f7d8-08ddb7d1374c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MExibllOWFhaR0tiRnFwSlpnd1B4SUkzaGhOQTZxbi9TbjBuMFhNLys0NWdj?=
 =?utf-8?B?QkJiVkdKOEpMT2gzeWlXVWpSSFg3c3VkblVTVDRWUTFQMDEvRnI1SnhxNXpY?=
 =?utf-8?B?aGFXZnVyR2hCSklJSmozMjNieVAwNnd1a1BLMVZUYU5UTGQzK3BscGtjelJu?=
 =?utf-8?B?dUxpaS9qWkViQWdHWDdscVZpc2FsTXhNb1B0RE9MKzdYTTNud3BFL09jMlF3?=
 =?utf-8?B?OVNWMjlJQ01yOTJpK0swWDBBSXQ0YlJSTElNdUhpQnZoTFBZbUxBYU8vSmVl?=
 =?utf-8?B?ZHY5SU9GRkdlSmlvbWVVK0dvYWRBZk1HK2JCemcrMU5VTEtXWVp3VTdPZjFW?=
 =?utf-8?B?KzhnMjQwTmdWQUJpOTFsOXl3enBoTkh5M081dTU3Q1NhbU9OcmJhM1hUMFVX?=
 =?utf-8?B?V1BuQ3RBMWdBNEJMbUdpOTdOcnl1TStSUVpDVm5IRUxXTHpWL1o5aG5sUEpr?=
 =?utf-8?B?a1FxUW9JMFNhNDdLbDFtTHZDYW5LeHRWWEMwcHlubVVhVEs4WGM0Q254c0Rv?=
 =?utf-8?B?YlVvb1NmL3locFZkOUUvbURMNnFHdlBrRmYzN0tCNHZkYVFTYjl6VUU4d25X?=
 =?utf-8?B?d1YwOXJaV2xYSjdNcGtycDJmSDY0U0JBK0JFcEJXQTlUZmRoeU1YRTFDbjZx?=
 =?utf-8?B?cmhONXF0UUtLYldZODNwcnBtTno4eFl3aHBob1BNYjJiRlZxcnFhRTN3TnNN?=
 =?utf-8?B?d3hmOUhjUXFUb05tWk5LUHhKblFvNnUwR3NKY0JDWFpPd1JSNnV3Y2gybkZm?=
 =?utf-8?B?aCtBZTNkZlFUdlB2MUQ1ZUd5NXZBM01PalhDa0F3YjFxMFMxbzduOTJCcThr?=
 =?utf-8?B?MmRCMjI0NDJINCthMVMxd3pnOExOU21JbmdlekxQZWQ5S1BmOUJ3NnlCcGkw?=
 =?utf-8?B?WEVmZFZGSURLVDd0eFBmVFZ6NW1nVG5NcHFaUU9NTTZuSk44KzJ0V2U0M05V?=
 =?utf-8?B?Q3RNTGczVjVuOFlqV1FuT0dkV2l6U0ROYnJFS2NheXJ2YktzZkwyak5vZ2o3?=
 =?utf-8?B?VkI3MURkaTNMRy95dXZ6VnFZWk1idy9ESmJpTmVQRVoxemVBWXlFcUsveFNx?=
 =?utf-8?B?MGEzSHpDT2Q4ZUdXUU1CVVB5NFp0YzhnbFRPcFJvYWp6ZDRYbUVxOHpXamVP?=
 =?utf-8?B?emEyZ3lCTDRmc3MrMVhjbUdwWXhSMzlRbWpRUlQ4Z1dUYmIwcGRMYUxiOGNk?=
 =?utf-8?B?bkpUVFVvajJRV0l6amNyWGhlTVBVSGw4eDE4OVp6aFk4dkpzTzdmRmcvRE9q?=
 =?utf-8?B?QnNjVktyaXZublVObkh3dkkwR29Ud3UwdkRVS25meDdSNlVudXdCK1FTbUlD?=
 =?utf-8?B?QWhCdjNDQUcxQlg4MGZhcEEyakN4SFQxQkgxQXlRQllQOWoxNnJWc1RVM1RG?=
 =?utf-8?B?TTJpN2pRTTI3YTdQK1B5c05vSXgrN1pGaE83dFRWSkM4UEQ3TkNTS052ZjB3?=
 =?utf-8?B?Znd4UFBUM2s2aUwxODhCVEZoZTByNUNPcDVpVFBQUlAycHdJa2tycGc0b3dy?=
 =?utf-8?B?MndUeU5hbWtNMlhlOVp4clFpaHdEa1o3ellUZmQvcEs4a3pVUkJIWEE2enRH?=
 =?utf-8?B?Rm1FeFJYUkY5aHRaNy96djFWUEpNVkt3L3lrRHJLK0NDQUkwMTkvQzZlMEdO?=
 =?utf-8?B?UnduNnVoMGFiN3l5ck04QVVuTi9UMFpxeWJnS1RpcUlrZ3BXMTJyeU0zakEx?=
 =?utf-8?B?ME9ETlMxbloxZ2FMZTM4VERBSTc5c3VVaE9rVGhTaENKYzlObmIrYXJXOW9G?=
 =?utf-8?B?WXk3Skd0SU9vZ29OL2FuME5RQ2FyRUNaaVBTbFVaVXROc0p4aDl2TjUyWDE4?=
 =?utf-8?B?MkhPR0NjOHdLZWlTQUtTM2g4RGJBeFhyNTNjN0xjcnJxaFpZODFRbjM3Uy91?=
 =?utf-8?B?MXNaRi9PeHEreklLVGRSQ3NseUR1bkNiQkRyN0dCV0R1d0EyNng2cEN3MFdp?=
 =?utf-8?Q?0iOJwFVYR2I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFGaHBYSnUwVjd3eDBNNmJHelJROEFQVlB0bTh0V1NpRW9nVjZtVzQvWVpY?=
 =?utf-8?B?a1F2eHRYN1RDZlJKU0t2TldFdTJEbDJWdWtzVHpQeG1YS29RTS9sVmlEekxD?=
 =?utf-8?B?YXp5RXRUdFMvTEJUamx0Y3JhaEVVTHVuNjFkTVhHTDlCVTBGaWMvVEdpV0NB?=
 =?utf-8?B?RHlGUkc3aG5TWGtGNFpWZDJYd1R3YmdzWXdCSzQwL2dZV2dvQVJLaGlxNkZF?=
 =?utf-8?B?YjAvS1VnMDhTOG5scXE5R2NKcEtmVXZoZjdDUWNQNDZuRThyM2RlUFk3c0ts?=
 =?utf-8?B?RzN1WjhhdVN2aXVzWThpZDZrcHhaNVFrZ2R4OVdBRDJoNjdXdWxtSzQ3OUJr?=
 =?utf-8?B?d0V2UUZuaGxPK0Uzd3FUdG1MNDBRNnBkRGNQNkdXeTA3cFZLWlF5eE5GUTNG?=
 =?utf-8?B?RWhraFEzQUFPeEs2ZTVUNDRuRWJKbmdDcmNRdGVVT3hFalE0WncyRWhBL2Y1?=
 =?utf-8?B?dG1MQXllelhHekQwVkxDZzY2czY0c0RLL0t2ZUMyNkVVWXFCYUpyNmtxTnVE?=
 =?utf-8?B?a2tscVA3ckFObUFzMmowb0pydnBrNVp6NUtrQU4xS0pXYTFwdm1PSnE3eFdr?=
 =?utf-8?B?alJLeTJ5TTZnYWtRMHA4VFdmU1dzMHBOK01EbnNvS2I5SCtIUElGVnhIOXFr?=
 =?utf-8?B?N0FUb1dobHdWY2IyT2hlUCtSZVh1NllBQVdtZmtLRXloYUtNTUhvVXNXTWdI?=
 =?utf-8?B?eTh4MjFHSjlNUzMxQzRIc2w2VU1aMDA5dUVwYS9qL2ttNUV3L2JQeUVCaE52?=
 =?utf-8?B?MHlqVG16elBOT05YR2dNOEhjTmU4eU51QTRFeDgyVkU2TVc3RzRMRDh4aWNv?=
 =?utf-8?B?dDRkUi9hb0JPT1NEMTN2NDIzUTZrWE91OWNaYXdyMkwrMzIxSmg0NFJBVWtR?=
 =?utf-8?B?YnA3aWxvMVA0dExHQVpFaFJNbTNuYWs4VUcyMUY2TW5RN21qR1Z0eXdSWXRD?=
 =?utf-8?B?cHF2RUVYSWlYY1lyZ2JiSHRmODlvS0VlNVBVN1NleXN1R0R0VVJvR3FpTXVj?=
 =?utf-8?B?YWFuZ3hKRlY1dllKSHV4R2xHNlZmd3d3TDRMeTZ0dlFUbWxZVzRIWHVycnFX?=
 =?utf-8?B?S2dzSUFURUFDbHNiNzl4U2p2RDNyZEgrcXpHSElQU2RMb3BMNXNvVU5JQVIy?=
 =?utf-8?B?SnViTEZsVGE0QkJ4QzVLalY3akdTZlg4SnJqd3RkTEdrS2pNT1o1MzdsdDZO?=
 =?utf-8?B?Q1crcDVzZjE2ejVrZmk2cEFJRVJsOUpCZlpwOHM2RUZZOGZZTlg0OXd5ME4w?=
 =?utf-8?B?ZlluQXR4V1R5SGFJNVVYeDcvWjNjbmtpMWd3S0Rnak1xNjFGQzhZeElKalVM?=
 =?utf-8?B?YnJ3a0ZsbmZTeVQzT1lPNnQ0REk0eDZ1a2hQS1cvMXBNUGZ4ZCt0MC9pNC8x?=
 =?utf-8?B?L21ZTXpKVFZQUTZGSjMzU0Q0S1FYTmx4bEZpbDdwTVNPOCsrMzlwc3AxMmVH?=
 =?utf-8?B?b1pucmloVXF5UFRDaGNtdUdYNkIrOEpCMml2Vzhza1JQSlZ2cFNEUWV6TFlY?=
 =?utf-8?B?L21pcUNQNTFTSlZlcVlyNWlrZnNvQS9DbEtQSVA1Q0dwNXdGWUg3bC80SUVT?=
 =?utf-8?B?UDJVY2hYMFpvKzQwVG94WnZWOUZhN1BTTFMzdHpBdWhHa1JWRGxRSTBNV1ZR?=
 =?utf-8?B?bzhpbmd5TXBXVmRkUEVlamxnN2lPbGRhdGxpUVlrOWEzTmVUcEp6d3FSa2Zt?=
 =?utf-8?B?TStzamZHUDJyZmlUSENicXZGS2dRYnRHc1QrRjE5cUpiRmdUTGhaWHJkTmFG?=
 =?utf-8?B?QWZNbmd2ajVGaFFNcGlPblZ1RXZwNzNzR3B0M2xaaUpyeGRhWm1scGpmMlhZ?=
 =?utf-8?B?ZUU2cndvUFZOZFQ2L1RCUGJSbEhLei9ROHdlVllxeDBJVjJXaDl2RFFTT1FU?=
 =?utf-8?B?emx3aGhTUWkybFFISDhibUlwakdZRzBRL0xkMHFsb3BGN3lFYU83bG5YaVFQ?=
 =?utf-8?B?WW5TdkxISm1wckM3c3BEY1pzV0QzK21sNE04bFNOcGNHbHREMzdoeGhhSW5S?=
 =?utf-8?B?TU54VWhXeXF4V3R0N01IZUdKeG9rVlFOZGlwUGpwVDBVSkpsekp2ZzJlaXpa?=
 =?utf-8?B?d0dOaUlsQnI3MGNrUVoxWC92a05Qb1k5ZzZVS0lRcWVyZXpsdjBGOFh3c2R5?=
 =?utf-8?B?aUxVRTgrQTVaUkxKRm54RWlXWVhneUpRN2gwZEhzTVloakhEY25zTE9PVFFi?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a14d0d-553f-4810-f7d8-08ddb7d1374c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:25:36.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtGd55v9IFz7BIc2Tn8xPzIIza1C0zmw5mgryq2VRpNrZJbExMLEKjX3ZZypw3iHAGlvgEn3GJMUEiHLu2Z5/oRDjyapxfRAVDWqwevkRSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6207
X-OriginatorOrg: intel.com

On Mon, Jun 30, 2025 at 08:07:01PM +0800, Jason Xing wrote:
> On Mon, Jun 30, 2025 at 7:47 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Sun, Jun 29, 2025 at 06:43:05PM +0800, Jason Xing wrote:
> > > On Sun, Jun 29, 2025 at 10:51 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > > >
> > > > On Fri, Jun 27, 2025 at 7:01 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > This patch provides a setsockopt method to let applications leverage to
> > > > > adjust how many descs to be handled at most in one send syscall. It
> > > > > mitigates the situation where the default value (32) that is too small
> > > > > leads to higher frequency of triggering send syscall.
> > > > >
> > > > > Considering the prosperity/complexity the applications have, there is no
> > > > > absolutely ideal suggestion fitting all cases. So keep 32 as its default
> > > > > value like before.
> > > > >
> > > > > The patch does the following things:
> > > > > - Add XDP_MAX_TX_BUDGET socket option.
> > > > > - Convert TX_BATCH_SIZE to tx_budget_spent.
> > > > > - Set tx_budget_spent to 32 by default in the initialization phase as a
> > > > >   per-socket granular control. 32 is also the min value for
> > > > >   tx_budget_spent.
> > > > > - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> > > > >
> > > > > The idea behind this comes out of real workloads in production. We use a
> > > > > user-level stack with xsk support to accelerate sending packets and
> > > > > minimize triggering syscalls. When the packets are aggregated, it's not
> > > > > hard to hit the upper bound (namely, 32). The moment user-space stack
> > > > > fetches the -EAGAIN error number passed from sendto(), it will loop to try
> > > > > again until all the expected descs from tx ring are sent out to the driver.
> > > > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
> > > > > sendto() and higher throughput/PPS.
> > > > >
> > > > > Here is what I did in production, along with some numbers as follows:
> > > > > For one application I saw lately, I suggested using 128 as max_tx_budget
> > > > > because I saw two limitations without changing any default configuration:
> > > > > 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> > > > > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> > > > > this was I counted how many descs are transmitted to the driver at one
> > > > > time of sendto() based on [1] patch and then I calculated the
> > > > > possibility of hitting the upper bound. Finally I chose 128 as a
> > > > > suitable value because 1) it covers most of the cases, 2) a higher
> > > > > number would not bring evident results. After twisting the parameters,
> > > > > a stable improvement of around 4% for both PPS and throughput and less
> > > > > resources consumption were found to be observed by strace -c -p xxx:
> > > > > 1) %time was decreased by 7.8%
> > > > > 2) error counter was decreased from 18367 to 572
> > > >
> > > > More interesting numbers are arriving here as I run some benchmarks
> > > > from xdp-project/bpf-examples/AF_XDP-example/ in my VM.
> > > >
> > > > Running "sudo taskset -c 2 ./xdpsock -i eth0 -q 1 -l -N -t -b 256"
> >
> > do you have a patch against xdpsock that does setsockopt you're
> > introducing here?
> 
> Sure, I added the following code in the apply_setsockopt():
> if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_XDP, 9, &a, sizeof(a)) < 0)
> ...
> 
> >
> > -B -b 256 was for enabling busy polling and giving it 256 budget, which is
> > not what you wanted to achieve.
> 
> I checked that I can use getsockopt to get the budget value the same
> as what I use setsockopt().
> 
> Sorry, I don't know what you meant here. Could you say more about it?

I meant that -b is for setting SO_BUSY_POLL_BUDGET. just pick different
knob for your use case.

> 
> Thanks,
> Jason
> 
> >
> > > >
> > > > Using the default configure 32 as the max budget iteration:
> > > >  sock0@eth0:1 txonly xdp-drv
> > > >                    pps            pkts           1.01
> > > > rx                 0              0
> > > > tx                 48,574         49,152
> > > >
> > > > Enlarging the value to 256:
> > > >  sock0@eth0:1 txonly xdp-drv
> > > >                    pps            pkts           1.00
> > > > rx                 0              0
> > > > tx                 148,277        148,736
> > > >
> > > > Enlarging the value to 512:
> > > >  sock0@eth0:1 txonly xdp-drv
> > > >                    pps            pkts           1.00
> > > > rx                 0              0
> > > > tx                 226,306        227,072
> > > >
> > > > The performance of pps goes up by 365% (with max budget set as 512)
> > > > which is an incredible number :)
> > >
> > > Weird thing. I purchased another VM and didn't manage to see such a
> > > huge improvement.... Good luck is that I own that good machine which
> > > is still reproducible and I'm still digging in it. So please ignore
> > > this noise for now :|
> > >
> > > Thanks,
> > > Jason

