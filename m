Return-Path: <bpf+bounces-56614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475F1A9B26F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541C09A24C6
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D327CB21;
	Thu, 24 Apr 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXUEGAfk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D3198A1A
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508794; cv=fail; b=eRTT/nJso2qVO65K3+si4yojdnAThAxXjqRkreT8FRZZXlkkWRHq5P8mCehHgldZhQzqlFO01zBS/cTyC/gIhZl14bpXM/iLzKzMcRsdWdnOTFz2CtuYvZ+xvw8E0kdOwhHoxjuBjqzrSBOuWy1ZqcErnEyC/Gas58UphElcHso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508794; c=relaxed/simple;
	bh=2emwSKV/uLvXCeqyBUkBf8q9h3E1e8q/tpyN1HL9d2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T8EXntaCZSuOajrp5NRSTMcUwkdPpNoju+yYgxLopTT9iQz+ycZn/lJxgW4q6b+DgQg11RHBr+doFhO98JEm4e9inJZd3W/g+40MPa+g7peWCtNxm855Q3RIWBSl/+hdm+gYO8Be3ZTl7aI/0LWUyS3vRospOkWVQ6tFv+WFWgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXUEGAfk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745508792; x=1777044792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2emwSKV/uLvXCeqyBUkBf8q9h3E1e8q/tpyN1HL9d2o=;
  b=OXUEGAfkq1K6JOkPHueku5k9ZwlyFkX2+P01E5PQ/7SJjbg3KOJFAHeT
   d/EkbOSflb8+Y0L5o6tRMw82yx0k8niLilsoRbQ2LjPOYJffH7VJ45/3m
   LFNtRj3355Vzpi781QORMJukUrjink1TvB3JgrMcQWcAjMdwEUkac/1Kc
   bEtwh517z/Ci60Dl323kZRr1NLmt+pxr3dKnHdMvSItdETd99VtVgLgJr
   ITums3Q4Da8t1QzrG3dzqnskafLCCPCl5/WJM2K4cZaNHZPVQCd+6U6/K
   /B/TviLizzY0God1D7xzyjeCaf1184Nul0k0582in29j1PmcWFiZ4oDfH
   w==;
X-CSE-ConnectionGUID: 48S63CAlSxSvpUxxjaBfJQ==
X-CSE-MsgGUID: wlhP2fGoTNuGpxKmEu8q8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57798371"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="57798371"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:33:02 -0700
X-CSE-ConnectionGUID: OpfcN9BUSOWdtqzRPZXcHQ==
X-CSE-MsgGUID: BgqoDq/NT2KPS5ECL4KzFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="163705939"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:33:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:33:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:33:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:32:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO77EcB68Ig6asBqyOyL1Pnf2KmIo6UWgZYEWKqoLCriaH8uHZhcNhjRAISE8WDf3FaoF4Cj8JFWJwzn15dEBJYt4og27f/pLt5bnUZyDJG9uW7elhbqagX5MPy7ISllq6JRcARCLUhJD9Mm7gyTQDUKhhBYEdXaUNl+RhxLUIUbUXuxQATOhMzY5FL0EghJIjg+7YGy/Z2NXUXr7h4lRZ0Z4E817lhk1Uv7OCOwba1v7dYzmRM9luunZ9GLGTMP7PLKJvXqlJqibaWXZ5vwUyL0mdBAfBmu6nMAPTFxG8yay63k1zlXCCHTHwfik5Ck4jNQZii5G3b+bww8mZHM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uofvUBNnNyTqpg7acmOadR6sYOMY9Ym2YZky49cuzmQ=;
 b=c11utcZWbSU3eavdywOeKhezVd+BDLKG31/VPT5gohaWJaQW68ZrSDSXTE5IfyGZ82hm7wkM0alGg5/WjAyKTffYyZ7+2DAoK6AGp5nppRfwjrkRsa/QVHkAO7V8o36CGvv6aIIfmNPNBm+nm0NiPttmyltvl9vOTyHXvSbc2o+xpIcNDSLq92t1dHSmO1kTTIeIApeAfsMmcdLmtMjgHtCvIJEBMobhSPKsq9kyQmArTaRT6W1dFRJz3R0ru8fGR4Ow3vTgJbNvH5lt1nqo2ieecSRYE651bipDMQKYUtV4rjMyrhHYGCeFZbOItJQodp6MiwEKG1UUBLSslY3b8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 15:32:54 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 15:32:54 +0000
Date: Thu, 24 Apr 2025 11:32:51 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
CC: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Subject: [PATCH v3 bpf 1/2] bpf: fix possible endless loop in BPF map
 iteration
Message-ID: <20250424153246.141677-2-brandon.kammerdiener@intel.com>
X-Mailer: git-send-email 2.49.0
References: <20250424153246.141677-1-brandon.kammerdiener@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250424153246.141677-1-brandon.kammerdiener@intel.com>
X-ClientProxiedBy: BYAPR11CA0083.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::24) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|MW6PR11MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cca5ed7-d06c-422b-a154-08dd8345480d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JxjOFGxYD9d6gEY0Z+TIlAbgN+Urp1VvVcMPI7hFVG1/YlCsmBQLXUDOQiuu?=
 =?us-ascii?Q?EGGMFAhuAOmrFCw/NrvipTiV/w/Qx2halPjwJPcohfwjfmuIXfJj45jRqQPq?=
 =?us-ascii?Q?2wpFZYFotHetBtbmU9zJJ2ECzb2pxln1T80XDxnWRjP+fpy8F9zqN9A6MBIk?=
 =?us-ascii?Q?H9b8uEfZBQO1KKdKdxZfHzE3T8B0/OiwzP5a56tuyZuFVxvRIiYHxxP8d0Qq?=
 =?us-ascii?Q?41Nk7c1714Jrevkgg+2xZ9fFv3YYPMouj/5sHMRLSjjMtiLk+0sQ6Ylhs4bT?=
 =?us-ascii?Q?ev4L9ekazOOMBVpXM7BHxkaPjYxXhlkun8e9YqQWdBuICFAZQ0n2NvBSzdZe?=
 =?us-ascii?Q?huOmQykc9mNbqyPB7s7KE7X0lKn7k9CE1T4sv8V9iDP8V9mJNHtdd0z66sih?=
 =?us-ascii?Q?Sc7Pb3D8WeDi8sziGQort1mQ/bJD+uCunIfuGY1wR+KKD54rPMEonRxr5628?=
 =?us-ascii?Q?3AOMghCUZiwEQfSCZ4lD6wQ511FJjmLrKZsz4qEn4tkvBlfDb8JGQ4hoeiX6?=
 =?us-ascii?Q?fxLqsLPGHxuaybHWpuOIg+aNBqWYQ3h4uychjxHHVJ2j3D+/ufytuFmybL7T?=
 =?us-ascii?Q?+TFCu4EElkYaQ1x0qGz3RQK3nlsMjxzwmNxkkrCr7o6J77r6I4EzGAKYFMwQ?=
 =?us-ascii?Q?aR/viHMcpy1mc5C2DimbP8H39tKAGpSXY1dye5SopA/BaNYzq6WIiSIdQPzN?=
 =?us-ascii?Q?cS6PxBRT7RtSDQHBSlJDeJQ5mmPx6R7e9rI+T4yJlTJJKyz7lg4Q4O/fTkoF?=
 =?us-ascii?Q?j0u4dCWsGOvIDGo90/Hgzo9PymAfga49FtxxveGzXJyZbbKqyHq4Ll8UwLlS?=
 =?us-ascii?Q?RRLTFQPH+ddFShWByd/ZynrSYhH97iPVGem43mz6bG1bwsC0k1xDS6EGni59?=
 =?us-ascii?Q?/Bv7c1wdtBcKaZ8kBUpId/m7RszTe/8BjIDlMBI/j1keKkOuYNfUIvvrPy4f?=
 =?us-ascii?Q?+M5Pt2pYdgT8T0wEDU/cNa2BsxP9meWP0/zhi+Qu788kmOAWUiuXfOAtaheX?=
 =?us-ascii?Q?sA2AVyhRy7lExmd4g6JoOPdVUPZjgnRVDHp+GRKEs7G9e+hdeQBwqqwj6Me5?=
 =?us-ascii?Q?PsCQpj6+qPED6uPbga1OPePI/yzU8xOIyXcl5kpzuS5rZ5hMGDT2DgswDo5w?=
 =?us-ascii?Q?DahxFgSZSo2CU39q/wKpnn07+HTN8XDqoq03gV2YurvlT8gPiluvW+NZjDcN?=
 =?us-ascii?Q?dYgIQSfsj4lF8/OD85uJe/opq3TjVSpaYPmgxO1mnt/0ky5IYYLgi2kKtvTj?=
 =?us-ascii?Q?e6+UEZA/GTQuyLL4sWj+LADMwd2oBcTRvaHEiueeSr7EDGcClOPMhb2PDqAh?=
 =?us-ascii?Q?yI4QIMfMOxooHRELty8N1nXRgEK/k2CII1pHraymQxz+yIGlb7k+HUvHLOQy?=
 =?us-ascii?Q?kadWiJgHPnsCllPDzesy2Q4qH5cAisX2I9cMRyFHVz49nn/oj5xWP4rT/kh6?=
 =?us-ascii?Q?GmLkfkAKb7Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51sM3mSTVpiPn4Aht07lVrFZVSGp9ZxfBV/ORb2Fw9fEMKfijS71/9vHSMAz?=
 =?us-ascii?Q?cyPE5Uv/tg1DvQ7QpWx2wRvUqd+jssIHwOaHvQgmAF+knCyQBWHevzmQ1mtt?=
 =?us-ascii?Q?EJVU6J4eOi6h6s8oWll92ce03u+sjjiz7/55xQOpM5OS5aj/2asq6fnlDU5u?=
 =?us-ascii?Q?fkZczZje5xcjoqzCHBLVILBobBlWuVshG56gG5eKzqFYf1KSKp9Y3UuCt9YJ?=
 =?us-ascii?Q?lxGlhmHXUCCGHn2QSD3RFVs8MEhxoq/FLMcFM9/DGa0g4Lt3l4b4JGhpIYXN?=
 =?us-ascii?Q?ppRGmqRM5RIY1CjxjRyX8qDN5n61Z0EvUa9asYeBctdqBtEkksNCVOxboE31?=
 =?us-ascii?Q?qcZHGP2qss/LpWnfcRrGzZmzlVpIXGBoibbBjROWRiFRfdQHSrrHLU1A21Fr?=
 =?us-ascii?Q?ImMMxrQ/eZpWweLRQZ4OQsZ7vDhhROlekUtcIvCDb+0DNmbdbKBKKniIENz/?=
 =?us-ascii?Q?AnSsif6AzoApmjrAas4JzqJ0LhsbTO8SP6giIPBzd7lfgwgDx8k2VSj/eEBP?=
 =?us-ascii?Q?kLNxY3uvrk9s8FvVh6oiHV/h3x0vUhIBzmvVxZWLjHgGehL+KdAtcGD7VQLH?=
 =?us-ascii?Q?iFASD2WIu44c6IcPXiYKzNOO97PDutntC0qj8MV3qXXD4FOILMnQ04CMm4vP?=
 =?us-ascii?Q?QbgLMt0VqL4vkArZwxG7jcGclVrEuDi83CKtkY+yzCOzYgso2lgcMQKHyjup?=
 =?us-ascii?Q?jbumcKgApMIZlQf+TlHYQ8s9NpiuJ0jck1Ihz5yyQ916lz80HZ31/scBilP8?=
 =?us-ascii?Q?+PVt7NMOd3z4yMbSj12kcviCn1o86bOdTGvOqQYdojoyPcX6zMu7ywWhXSlT?=
 =?us-ascii?Q?nyvTKaDEwpIfGGiTAEhmeDeZJKyxg4Qq7BsrRRNNLUjyhWrxsEEl+RnwMeIA?=
 =?us-ascii?Q?Sk/0dnkBCj1QQ4xuqT6OrJs/QlcfeOoW9n7uQVeHPg5WhcSbdC2WTqPJqdoc?=
 =?us-ascii?Q?YCYTRU7aaXZCjLiYspjBjHQn8VQSwP4O1FoqoyuGS4Zj2+EXY2hh5ni8i7LF?=
 =?us-ascii?Q?WK0vHWSlye+cMnnO/LSY5LX/9zV42cYeUDYRSbaju3snZxKMYa5mjexVQY80?=
 =?us-ascii?Q?BTabwN5gi2vAXm9mJsVEBKUYFY8HVA7JAcrStEUgg3OQ2w96QlAUJ7KLrAyi?=
 =?us-ascii?Q?oa3dgDMXGhSpj4FGe3wMVDoY/xqyxXQg27FhGXfiPiMohSfKOf0M8lCOfAv+?=
 =?us-ascii?Q?hlC1CWE82TmIFChHF6RfoUOPB8VxyRirYZ1BlXyx8i1SP4eaVufquGEPutQu?=
 =?us-ascii?Q?r5JzwoCuExVdgXYRCXdjAK/tu1tS1f2Vz6mK6awmHSX5xIgMP4HOlpXbi7P3?=
 =?us-ascii?Q?h8ky9BZyBPYgYE70K0/NG4v9ti0oOP5G9zzX9iTvlNEbZmOue3UjkH0v6oav?=
 =?us-ascii?Q?MXro+9lYcFXuGmqhrQosXqKmM7FzgCrL4D3BPCmDjO7VnPWS2IT+0sZOSFm5?=
 =?us-ascii?Q?oUJVNKEqxM4fpd22t+i5FXmFOCJlvqKh6M2ukfuIq2sPwoo68RjMCT91do2W?=
 =?us-ascii?Q?bWLncc5mkurtj+BbEAkVvO/W3TO+1TEm38F7yH4WpMQvrJIlRT4Jmi2OVOn4?=
 =?us-ascii?Q?rZjvcGo8t4OyK3LloCnV0mHgPp0qpJRej7wa6b8t1ID5cmRyFPOPzzMahBuz?=
 =?us-ascii?Q?CEDI9aqzxUUkSk6gLmqCr2E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cca5ed7-d06c-422b-a154-08dd8345480d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:32:54.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eHLZ/oGETHjSmmPS5tXPxIR8ljBX9+XixBWsr8FT6Yo0QzN34Kk01f0fDhquC0NA5tqwT1P3JnaRX3qBx61F7x7e8H2Svv2oNVk1ccLUCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
X-OriginatorOrg: intel.com

The _safe variant used here gets the next element before running the callback,
avoiding the endless loop condition.

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5a5adc66b8e2..92b606d60020 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2189,7 +2189,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 		b = &htab->buckets[i];
 		rcu_read_lock();
 		head = &b->head;
-		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
 			key = elem->key;
 			if (is_percpu) {
 				/* current cpu value for percpu map */
--
2.49.0

