Return-Path: <bpf+bounces-56513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F63A9961C
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C20189F632
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A72289367;
	Wed, 23 Apr 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOaCHYTJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4728A40F
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428344; cv=fail; b=UUCML034m0jTj/xxFDolx+Jb6MMZv/ZoLl5vQ15oUsB2UE+wI47ZZcCwD12n55KIaX2mLM15rdWSTdiwLCmIMfrkE8t3Zqo5He51u3p3Rerhl0lynaTJ4lZg8iejQItMo9hfoRlsnBwmBu2eNnb1Iq5tUqe7F1POGszFXGtNZcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428344; c=relaxed/simple;
	bh=EvNMyQuyJSWHkzazpDcPK4Zsk+qOmcuYT59GDti73xk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hjiEOBlefmzQinsWVKzYPydq0aDdX6ctqpm3KKsQCju2oIYkOsljE4LathlWZSPAUWcGcrBdylxewIsyb+/UX+O8lJ8OTLCSbDsZe0p7tnL2CXlXujHyD8PdZWmomo43xHFxQxFKMo6BN9HMDq+rGYknCF44XQCdqOzfDdSkVfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOaCHYTJ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745428343; x=1776964343;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EvNMyQuyJSWHkzazpDcPK4Zsk+qOmcuYT59GDti73xk=;
  b=eOaCHYTJ465vDo0zJfZ/pTloof77atgn6aMTExk9JLn0dedyJv9r3lFz
   fVOFkwiOiXn2BTTI8YmauDfsejoYnesxxvMhlOK7ymE8km2/aEp+zkaJc
   +o4P3UPWmv4xhH4ojtIL0XyzMCoL9YsQ3+IWHndjWpNKLwUP959kLeWoJ
   wk1awtAHr31md+IZZ1ue7D4gesV+dDCXX7JWRR6ZWUDcLFjLhI+jCgO3A
   MT9ukra/IMfFu9h6z6/yjULrwljxvGJb4Q1bmHpdbP6ckfLpk6AGBI+HK
   FtRhYU1PA6WT7YmNn2odDjL90eaGRJVdMPXJKPkJsY4BS5iag3Xu1ZUX1
   A==;
X-CSE-ConnectionGUID: R12G48mcSlGG9ABAxq9Myw==
X-CSE-MsgGUID: LMSeyPNuRfC5SXRPEZKqLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="64560328"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="64560328"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:12:23 -0700
X-CSE-ConnectionGUID: sFCsw82zTjyfdgkltbDBdw==
X-CSE-MsgGUID: z+R5aBKXTa22sJTqOO3V0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137458307"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:12:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 10:12:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 10:12:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 10:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzJ6hWTP2UawvSw7debU18HRlCqGpW2YN0B5u3xLQ2OwYIBuG5YwTh5h842ssGzl/sgb8oS7b8Nmz2wOAG7GOYhzOca0i+IR3nMheUkZgbtY/meACwUU8lZLfErASLiXPmVzu7VDoZybE/OA8riwlqWXraGMHrNHwOfShO/CbSpZJizZyszGafLhPz+cB0boaMkh3Ac1V+V988BjJdubM47TcYEdQG8740Mi7mj6JMadUz8xl3arotLwhXcoYqMbqeX3Oc63dO17bM/F/yCc+6n+1rVi4Jf8AsKsee9LDPxVwKOHsNpg/f3F0pruLaS0LjGsidnU2Y5rlYb833W0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDeeXwCRjchDzz72f90CAUqPlh3vEbQ450z46nClFfc=;
 b=O95F34BHq5B/G0KsXitDpLTwxNyLliq6xpNe0MZS8fR5CSN2U1sdNxMTAO9coe/vAYHD2oCXNzWw2KUtOMU7jN6ZJR4Cyk2ps+hwKpHPTAyGafRhpMsrtnW42+YdeAq6pwFz93JWC/VKOhVVuWZ0uSw8v5mBUyOTbB6SEvEefd/KNbgBTXPXzGeD045VWLz3ylL2kc1isHINHL4e76oueNjiRfD3Ds/0XMX98k94SxtZGs+PVGeTBSdKcQD35FJJ0I513Z0uwAp9o0YyDjckJiwWMZrvcQFXd0AWUQQ8Nl6ffnHvEAQH0DjQnDfOs+A6B+5v7hUgRkRXPIBXlmiabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 17:12:11 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 17:12:10 +0000
Date: Wed, 23 Apr 2025 13:12:08 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
CC: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Subject: [PATCH v2 bpf 2/2] selftests/bpf: add test for softlock when
 modifying hashmap while iterating
Message-ID: <20250423171159.122478-3-brandon.kammerdiener@intel.com>
X-Mailer: git-send-email 2.49.0
References: <20250423171159.122478-1-brandon.kammerdiener@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423171159.122478-1-brandon.kammerdiener@intel.com>
X-ClientProxiedBy: BYAPR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::41) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 41296edd-0a58-40ad-ab47-08dd8289fc13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YzoaRbfvQXBe/PcKa2vVm/s3HhtJnCEc3Op2EiCqZWzEaMdx43D69REnwdjH?=
 =?us-ascii?Q?UI8OuivCg5YZNUutVrLeziFgadcz/BmpCl8NQub6t4FOUJ/fXKtLWx081eeK?=
 =?us-ascii?Q?/wlQf8Ds3lfNrlU0my0sOExvz8+44+CVP5UpRXpC21qiP19wsyc2zRyY0aAT?=
 =?us-ascii?Q?sM1iLWkYNW1ja3m96CGh3B8qh4Z0aXcoEoKi7ZrtexHpMJgophs9oMtWLZ9e?=
 =?us-ascii?Q?mptsTHyd9wYzyF04azt/i3pD/l2vC8YkpuZgRxa0rfEmKroEUNfe2EEsN+cw?=
 =?us-ascii?Q?Fx7o9se0hGzl5xnbjcQYyiBnV6rBCw2jq5o5Wr0IInjGNYrMhbhgO7sGtAt1?=
 =?us-ascii?Q?dlD47IGBRqKOZcc365wZu+Xw1nEhKbDgPhEB16lFA53wVDl7O7xOhb992vhx?=
 =?us-ascii?Q?vYf9VHZrPnOrSWGVROFTBF+2IhNhRYCc0xP8YYdqM8zPdXO2RKgSXUuT5tp6?=
 =?us-ascii?Q?Fybaezq6BCyMFXuY5yAQYw9p8x/ws/jm0KY9iOpN3cS63brRv40F5MxhouHW?=
 =?us-ascii?Q?gVsGrs4V6N3KbEsQ7LGqAu9KVY+tHxinaaBogmalqocLJhgEmLBbvq8vky6S?=
 =?us-ascii?Q?1koaWJnf1Te+4hbjfF0kl/sp6c6MPAOSoAPLAYS+EIHhm2GsYPzAryUCOyAi?=
 =?us-ascii?Q?saBBYPGlSjax/YMRM/07bs56qb5RZOFJYsFu3F8ZDIu5ufgcfc6JfjQmQa4f?=
 =?us-ascii?Q?ELI7+HlaHWVNDHgCnyf091ZeiNjUfS9ADaYCh9NjiEVHk9Acp/dPDWP+LeFo?=
 =?us-ascii?Q?mvBPMvws+oTf1pmu5hIsnTvTwM4hBVs7DtIa3NZbpUgcQ3xlIclcdaDkAdAB?=
 =?us-ascii?Q?r5y+cW5L4aCEgYaRfVTgORZQvyQ7pcIIC1/dJBqk+EfE05dumtqwAudD4iB8?=
 =?us-ascii?Q?Hk+/SvoAyk5HlWl39D307TXZns3auSXQFKgjKZxiISB2sAgGGCbNy+u8pdz+?=
 =?us-ascii?Q?1/BeYly0YzsMs/CVbBcsfZ/dxppghL4zFz4mSf5A3XBt1r2aizQq2Hfs/4PT?=
 =?us-ascii?Q?WFEn/M38VNKrsedrZYweJEBvkUWJHc6pw3b3VgSm/N14qAruobR6UU9fVLXl?=
 =?us-ascii?Q?lYpugzrgEfAk1lWmCZdujzK8uk3F61n1aDVXmfU0kLk3qUSvIXoNhHoZio5I?=
 =?us-ascii?Q?1pEkEKmVWy6ZGc0uhal7AbRQD9PM9I4KMnWLW7dJ6OAf6VrrzHVAp0SHlQQq?=
 =?us-ascii?Q?ndBoVEjRbnfmnp49XNje18kqeupvF+I7AawOJbOfhppAPD24UIO0crX/XWVf?=
 =?us-ascii?Q?qoI2LTGIdzjlDA5ON4enFgsG/naW7jcmj56aXIBBAj4JSeXVt/ACKG9LpDor?=
 =?us-ascii?Q?tUq/vhhC+M3xIGIBJBwsfKmyFIkf2Qqb5w2JO+lXg9TjBL8q/VVVHd7pxUzx?=
 =?us-ascii?Q?mzr2gsvi3ZissyysSSu2aOQIvPRJ3/VEDf2bwFNx5ZS2ha9usuQNZeiYYKl5?=
 =?us-ascii?Q?KKRLU4idbyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?baSbnkUg2bu6tDUHt6kVDtScMmLYGIdkNDegZSpiv8cQNPCQ8AHKs4LabUO7?=
 =?us-ascii?Q?XtcspGa3QGvCgFzsdD3yxoBY/mQEWKtrECXgO2R9G/970muVPPNRa6sDLEYP?=
 =?us-ascii?Q?RckNuw+v7yabeh2p6vct948ypTdOjUsxhcv97iGPwnvQO7IAo2eY8aVICPaV?=
 =?us-ascii?Q?Cy2Y1xLq73CjDo0iCWYPVIJXFkXmLPs/zcU7NnDRdTPxT/omiVDUiGNZnIaa?=
 =?us-ascii?Q?rxQvjT5EqiqT1rZ3UcUoreXbvu4BrKMmeVp28ZgtIepSQJwPjMdv1RVKZw1P?=
 =?us-ascii?Q?EDiYSUVDn886D5hUVcsJIPuwMfOr+gVaZdAzOOU2rlfG+zuCjJpIJFRN2ofk?=
 =?us-ascii?Q?Fl6EyNRrXhRYHtwKqOv7yxZd8WkoAWQtHB4yuh2V+iowbB237KCcqQswxQCZ?=
 =?us-ascii?Q?MDSk0F4hPDqGlYqFrrV61srqc8lxijYsOzk4ja3fu+UlsGAShAzTPV9IyzTl?=
 =?us-ascii?Q?TdG8qai3uvZ0br5Pi3w+q0Uas1tNc5oZx0rfn3UVlwxCVhXCBLN6cFYUcUSu?=
 =?us-ascii?Q?U6WWH+2jxuk4rlpgRKomvjNEzs7+uRKK4qJjzRZ3hFyokxrPtzJK838Nn9dX?=
 =?us-ascii?Q?uKqMZ0buZnLi0iWsWkRB97Hua5ZzuGmEEcgXbOUR43Dmv+cysq6xsc89TgEz?=
 =?us-ascii?Q?Fk3H55LKnwmAEYqrpMmvNfAnN9M+MPpc2gkOB6Qe8sNTRSRqxmaBTUcY3Oqo?=
 =?us-ascii?Q?C3s54vV5bWfeGnaYHG5YWbMoVv0yZow/K25udarr6W8BWRmo9cEXZyXnlx3i?=
 =?us-ascii?Q?VPZFlF4aHX+/iX2GCuwjZpwZcPRePC20DzujGJQ0I4K4unt/RcnvOeOiBExV?=
 =?us-ascii?Q?xYlC+Vok3hnoy0qoa1USlQBqxO9FztWsUe1y1k/bOmUdKdIQCdKxlBYtwojT?=
 =?us-ascii?Q?sUpVMZoAzBYhlVxYTj6U/mXwHfwsThBhLO48sYenaTeixiW4O8M4OOjFXJuR?=
 =?us-ascii?Q?7TEI/dEizftFz1JoCJgI9ODqdKgSzOfePCAZ15Y9XVCrcxT0K3ylhoOZKYXm?=
 =?us-ascii?Q?RC7Z5UoQD3VhJvnH8iXq6Cu2EeTgLj0JyjeCqwHZ71j4P1s9JNCDXkj7kO7H?=
 =?us-ascii?Q?pCQnXByQy8zNiD5aER9SbOKtjC7qS4lqz1E9gyMshmF2jgEkDjdDsTzoi+ez?=
 =?us-ascii?Q?FsqbDEOn1Un1a9WHRUcmG4+2YO/Sup94ClVAkCkAZaPBKpEBP68pMWY157gM?=
 =?us-ascii?Q?YydWJXLd5VY+byDXy61xh6uhJqJvEh5wkx6OBaInbpTRpZzji5dgx4X5kDe9?=
 =?us-ascii?Q?HLLhcAI1raVIAFShy5XOZRoK527uRj9bPpl8n1xPhOErTlN8TUHizO6yFU8o?=
 =?us-ascii?Q?h7a/CCIcdmm4EP17pzuGGKshoVbfG3ietzji5ReeIRpgSoFV8hsOvEhP4asQ?=
 =?us-ascii?Q?kWFC5cum7IBN7/ED5Io/ILmeOCiQMJoIkUMisN7p0urZlM7rM1jT/NXcYDbN?=
 =?us-ascii?Q?lIdWplHmWlvsdtkJHRN08cLXhYY872m8jBP4VPILgUZi7MrX/HhV1/BGgtp3?=
 =?us-ascii?Q?k+o7hXaFRsOwu+C5Fm5Y/WY5p4/gyC9AIgBYeoGASv/u/ICR2IrpPVCavrHO?=
 =?us-ascii?Q?vGUw+G7pnOlV39WJtvVV52rwJ57MBR80t+YbJQLMM964BYW30XX0ii0K2cMb?=
 =?us-ascii?Q?om//KQAYJSKaWv5AUBWmP+E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41296edd-0a58-40ad-ab47-08dd8289fc13
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 17:12:10.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFqrzvMz+6b7BZcwuMNiZCsrf0lAhMsILCp36pbEt7+hObJJQg+ilC4sgnlIUGVLK4+rTbdYrN5mIQKQkLcuPCjNItOMw+MMMmha4xZVtFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

Add test that modifies the map while it's being iterated in such a way that
hangs the kernel thread unless the _safe fix is applied to
bpf_for_each_hash_elem.

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
---
 .../selftests/bpf/prog_tests/for_each.c       | 37 +++++++++++++++++++
 .../bpf/progs/for_each_hash_modify.c          | 30 +++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_modify.c

diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
index 09f6487f58b9..f4092464d75e 100644
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

+static void test_for_each_hash_modify(void)
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
+	duration = topts.duration;
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
+	if (test__start_subtest("for_each_hash_modify"))
+		test_for_each_hash_modify();
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

