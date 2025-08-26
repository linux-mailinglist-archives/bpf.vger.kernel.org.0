Return-Path: <bpf+bounces-66589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C6B372E4
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002991BA5BB3
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E33728AF;
	Tue, 26 Aug 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKCkDAib"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2668C2D1F40;
	Tue, 26 Aug 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235602; cv=fail; b=lH2n1UFkCXyhAwYVtXGfs2eftmoJh9s9juprQhqxCQ4pth8kgaH6toL3i7qKhCGBwxlRTUROHLzvyHyA2sWsoDu6vh0Qof+P0n2lQ0qLKs1HrZnJXAQi798DJ6wBVc1lCndJ3ncaZzc5Y1Jp0qXHWbFb2KxhdinCSZ545wiMxtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235602; c=relaxed/simple;
	bh=0cZu7dCXnQLAp0nY5+qO0mw/BzG6XgspadbWUzJzvaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FOdki30CmGqUKsoFplmB9kFgbjkFE4oOkbxjGq1gbBA1MBIBMaT26t1LlZO4de3SWtJVz/mmXRA7FPCCcp4YXcUsOAnRFyq+gWtppYKtfxnQzUs00FT1m2MHoKCX1d8QlKnXCpsdmqVZLoOfENyocAdxhbPSucGcS2NzAtknBIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKCkDAib; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756235600; x=1787771600;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0cZu7dCXnQLAp0nY5+qO0mw/BzG6XgspadbWUzJzvaw=;
  b=PKCkDAibty+bekYeZW8Rz2NE1vakzQgO9UGVNvPktWLqjaDdm81Tw3de
   4l1yA8UxtKzYYRm9vbieEH4oV0KZvsLUDMKJE/mRfTbPfAMsRpAvhk1og
   h27QZp606S/n7vSN4FUOwuf3QaDBTBNbnyp6NjmkCILhOagIosC3oTOX5
   V4x+H7xiajOfGi6tSr1xDeqr8Qc5c2d/A6QuDtnIEacE0DGRuq1c1302j
   oWQu2xfUy3LLMg1i88pdAMjOix6VwF0FBlhZkhyrAJ9Xcm9oOvnZEfQC0
   +SbZ++OoELNZec3pR3K9qqGKqbtKFGqpaenXDw/J7eMhpXwL6jGg7waC4
   g==;
X-CSE-ConnectionGUID: NnFO9SVvTp2LpfTzSlyEQQ==
X-CSE-MsgGUID: 8LBLORACQkybGezCwMI5tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62320418"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62320418"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 12:13:18 -0700
X-CSE-ConnectionGUID: wAKq3Iz7QR+VZD/74jcGFw==
X-CSE-MsgGUID: YPIdX80xSguY5FhO98kbBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173810313"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 12:13:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 12:13:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 12:13:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 12:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1QFxVgwLvkOJ4NHM6dpKBfOKWi2GgmQiKk93WRQIRX2k80y6zcpq/dIEduHZ0RjXvvUV9cBhU0V1AvU6NOyMlFGPOdIgqWXqp7yxS8ZhOnIIDxQiemdQTHL7AYpv8LcXI7eAdjN08C6TyNcWlR1YvfJVTLKpL5rOVzF1AK6Yf499Gq+4Dq2eT01qmmaQPnPAYY/Kb3eBWSAI3hbL5KKD0fOlAJF7jexdxX0vfxmUyNxiDGAiV+KS0pJP1mJVh2F2HUMKyEEeK0dY74nqGA9Y9KqBCVAf0x8AtcwUPsYNGhU5sTZoZQ74h6W7aUg0uGFJU/1ImAsO+oaLTMpBSB99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBW7wgiKWq+O/R9zO1YBk4Ch1ZP+GT+QbV3UJG2V/5s=;
 b=deIvwKK3S1yVz4MTfR9vT3/j5TarZl+SsO72NXvwt2KEj9sYFi+anb/dx9OqsLwIhfosoJSqXXKdSUM8HXm5mkVoU5f4bWyJ1Nog9us8hPGee87HAVCdveSdMJg843aMCmeSXuWvCy6B8iz99unTYvLHnwf1rhUv5iHd1lcetc4NdxM3WVRcK4DKaUz7fSL7J/i4WB3u5g2BqwY7KzbPEmsbbOHaiyjfzyVp+uBwmPb1DFZu9IwZqWqOLmqslVENlEmPb1CzhsyKmlJQjF5kaSZ9MJnVCpw3ByBcGxnrvkc3/neZGiMltE3aNEtdtYX5WwRTJoxeFqDrNXM3miMxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH3PPF37A184CA6.namprd11.prod.outlook.com (2603:10b6:518:1::d15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 19:13:09 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 19:13:08 +0000
Date: Tue, 26 Aug 2025 21:13:03 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Jason Xing <kerneljasonxing@gmail.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <aleksander.lobakin@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
Message-ID: <aK4HP0LxJvfEhugu@boxer>
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
 <CAL+tcoD3Kj6h=RvkEJ_9vmJPWKGVcaLj4ws=JqRbE0TiyjDDWg@mail.gmail.com>
 <CAJ8uoz0v4sdj8YwadpCKpDSpY1JrJnO_kkEfHHyv+qAFMiKOOQ@mail.gmail.com>
 <aK4FEXMHOd2MLqmC@boxer>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK4FEXMHOd2MLqmC@boxer>
X-ClientProxiedBy: DB7PR05CA0008.eurprd05.prod.outlook.com
 (2603:10a6:10:36::21) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH3PPF37A184CA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d61664b-312b-4d7a-60e1-08dde4d497bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEhvTVRUeEt5N09lL0F5WXArNFZjSXpSVWRvVHgyODZUV2RhQUk1SW5mcWpI?=
 =?utf-8?B?VXJkSndmWFhWNGk5VlZtWnZaVkNyNEl0clV1ZGRJalV4WjhlZW1EcFVrWmE3?=
 =?utf-8?B?NEVuSitqT3Q3SVIyWkhlVVNNekI5K1NBTFlUVng2TFlxaGtnQ0pHS0NrdW9Y?=
 =?utf-8?B?QVNhVE5ZT1NhSnlLWTFKZGcyY2dvRXFyelRrU1dYVHR0b2x4QWJneWtKWGs2?=
 =?utf-8?B?OGc1T2o0UmhDQmZ3ZGw2d0dqaXExNDdiemtQaTk4N3kvdytXU3o4THVJaUVn?=
 =?utf-8?B?OU9SYlJuakdnSjlicHBrZU80SmdKbk9lcEFBdk82YkMrQjVpazg0dkJYT0dS?=
 =?utf-8?B?TjkzbkViaW8zT0JiMno4WU5TblhJWTczeitRcGtxZXlvUTVCdnREL2JkMjZu?=
 =?utf-8?B?dzdWYkxUQ0ZiaFBSV1czTTI4eXNjUzR1YmtodGcvbThtN0ZJSHVmNWw1TkZu?=
 =?utf-8?B?SVBDc2VvUjZoSlJpUUFwM1JRNzBLSlErVXZiSnROdUtkZ2hYMkRta2dIbC9j?=
 =?utf-8?B?cVd1TnRvWjUwZnVMQkx0dTE4aHIwYjU0Vjc5RmhDbWpvd2RUc2JXU2xoY1Fu?=
 =?utf-8?B?T2JXbWQ4ajJpUHNleGhTRG9FaFQ2dXNRV0ZmMjN6OUN3aDlGUnJPWXRPZTVw?=
 =?utf-8?B?Z3BieVdqaUlPcVVSVGptSEZoUkJpb01JTGFmM29leHpyamdVUmtZRmp4dmNE?=
 =?utf-8?B?WU1ZWXFCZGkvK3NQMUg4M1lnaFFPU0pyQkxmN1hJYk1JRi9RR1NtRE16bXhH?=
 =?utf-8?B?cjRRV3JLTUdOVDNlYTJ4a1psUUFOcDlMMTNvRDlKRkFyblkwaGFMYXBPRDJw?=
 =?utf-8?B?cXRvU0NKalFadE5SN3cyYU9PMXVGb3NNVzRKb3doMENDay9ZWit5Rkw4VEI3?=
 =?utf-8?B?dXpMc25OelUwN0dONGtIeXk5MExjK054ZjZYdjluYkdGTWg1NlIzQ0NiNzBp?=
 =?utf-8?B?TXlaYWptVXFzRC9LQk02T3pYTExPNm1xUkFUakVwWUdDOXJmaGpsM09SSVlP?=
 =?utf-8?B?WHF2Sm41TnRxejYwaXhWbTg3cUZzbXRjaVlBYTNBV1hDYjFVR2JhcENCV3hY?=
 =?utf-8?B?T0RJSllud3BCSi9zM21mcUJyZUZvK2VhNXlzanRYeFdmT3RwSnRQbEJQR1B0?=
 =?utf-8?B?RlBjWm1aQXAwUmgySnRJTFhYN3hicThqYys0SkxsRC9nQk9aUmVJOFF3Nlds?=
 =?utf-8?B?NDV1U2ZkbnRtUXMwUkNkMVp4cmkvcldyTVFyb0JPUXJOd2JrSUZtUGZ1TUF3?=
 =?utf-8?B?czJDdkdXUnJBclFCak96TnNMUmRlZnhWczRqdEhNRlYxRStkeW1SZG5YaUd1?=
 =?utf-8?B?cEpEWjl4T1FHbExCdUFIUFNkV0ZPci92TTgvK3N3WjRRT0JsdWcycHErSEJz?=
 =?utf-8?B?dUJkVE0vZXhrUlViamxpUWJWeE1wMC9OajRybTdjVUFLdkxsVmVEMzBjdWpN?=
 =?utf-8?B?QVBsSnh1Mjhnc0tZMTVScWk5UnpDVU1kZ2ducm5BcjJzNXQ5aE1sWjlaOE14?=
 =?utf-8?B?MzdyVTZFdllpOUtLbzZUMmJZNnVoay80T0hPQkhMdU1JVGthTlhhVVFvYjli?=
 =?utf-8?B?QlMrNWI2clV6bHJ3WVhvTXRPYXRsYksxMHZWTzBhZmlyK21FRStOOHlUUkpu?=
 =?utf-8?B?UlZKbFhjcytXZ21PalM2dkhHMkRlTCtWek56cHIyd0I1cUhoM1M5T0dlS1Jq?=
 =?utf-8?B?SmdnLzhtaG9TV1pwVFhuZnRzZmVhWVQ0U3Y2bWZXcWJ1SWhCckhMOUsvOXlX?=
 =?utf-8?B?VzcyeHhqNGdZYTJOUmhrdGpxdFYzWGt5MGwwYmY0TWYwdUkxQStySlFId2tk?=
 =?utf-8?B?QVQ5UGJiZG9xRWVnZDBicVJIUEl5Y21mMnA3UUx1V3Q0YkhYcERBRnlDWG9i?=
 =?utf-8?B?KzdqbVZGbXBmelNLNVcraGNZZ2VxTjFIcm5XalNQYWVkOEtpbUdWMXU4T3hv?=
 =?utf-8?Q?FihryVbQdUg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEw3eGNoYUhodUM0cUZKNm8wNm44aktzQzNpTTV0VWdqVjlFeUhHaDVvZExa?=
 =?utf-8?B?MVpBOEMrV29zQUlHZmJQVWhQK2NaTE9UUStDWjZ4WnJCeTdEUHIwNmExTlBN?=
 =?utf-8?B?UkdjOEhvVytQWVBuTmpjMFIxRHlGS1B1YlI3b3FVcXBvNzIwZS9Dd2RodGtu?=
 =?utf-8?B?bjJmZ1pCQklPamVIK1NDRHpZOWdqK2tTanR0YTVDc21lMVkrdWZtZjF4VHZh?=
 =?utf-8?B?UTN3YzJRVVBzM0pEUXNIcWRMaGh4VEhCR3EwUTVBNW9EQ2kwY2VnRVFPYTZT?=
 =?utf-8?B?YmFFLzdJbDhSK29mcVZZOVFoUk1hdG5jcUxmZVptZU03aml5ODdhZzUvdDdi?=
 =?utf-8?B?UUdveEw2cVV0TWpEVWtsNlhoeFRtUmZWcVZqVFpBZllJd0IvcEVSbTdmbEUw?=
 =?utf-8?B?SGRMbEE2ak1nNjhYSWlkN3dJTDN1REZocnlEcFkxam5lOXI3NGs5aHZ1eE9F?=
 =?utf-8?B?L2NTakZPTElQTXVkWkpZQjZUNkdydlAzSnlCU0hRdEs4Qis2WU9nR2JmNTVE?=
 =?utf-8?B?dVhYVzBiWUgyTkx5TUlrVERkc2ZOWks2eUx4U0h1b29wblkyckY2cExXZytE?=
 =?utf-8?B?d1F6SmdmTFVDLzZyNjhjeEordlVMcEl4UnQyNXcxckpkcUdZNVBQNFFHOTFn?=
 =?utf-8?B?YmxOTzk1Z0VHTjdYTXBEcDBTS0pWUHJYZ2Nvd0hHV09wdzFQNGxqUlRUMlFY?=
 =?utf-8?B?ZUR4SVhabkFWWUlIalpkTkFIc2FBdWdVR2VzWXF0bnBpNEJLZ2VmbWV6Wks5?=
 =?utf-8?B?M2MwSnM4NHkzUk5zcU0rT29DK3RNSE5JSXdHRkJVWFN2RDgxT0FhZXgwY0Za?=
 =?utf-8?B?am5XSlpsUjM4VFMrQjErN3ZNNHlWMklGVTZxTVJvcWpsZlhKbVBBODFodU1n?=
 =?utf-8?B?QlNmRjRyUEh6bTZBc0VMcjRzN0I0TjhiNjhOZE5XSlVZZHZQWXJ2TEpwZnZl?=
 =?utf-8?B?ZlJFd3lLaWpsNnFWcm5kRTkrWUkyUW83M3h2dm5wZmdaSlhMNU9tVXVXUUdW?=
 =?utf-8?B?VWZ6NHRlK3RidmRvNGZtR0xncUpmQThHN0NGbHlSWjU3dkl4TDRjWVg0UXhL?=
 =?utf-8?B?ZzNRdzdFMVVTWk0yeHRicklyTWNVc2lzdnJGa0pZWWNlNXloRGlLYmdPN0Js?=
 =?utf-8?B?T3hyTjh5SG9tNDVUTUdmNmhWRWpNUVlTYk9FMVhaSndLTGtJUFd3dFdsZ1Z1?=
 =?utf-8?B?SXNUd3ZWS2dkeTk2emhmelhMTWdjTDZqb202S0x5SVV6ci9zZStPcFByN294?=
 =?utf-8?B?R200V1ZJdks2cWVadG9TZGwzU0FxeE50eTJybHdtbW9CeUM2VGFPY2dKbVgr?=
 =?utf-8?B?b2Y3eUdPQjFzN3lmVDZpUFdTaDlnRWh1SnlNcDA3VzgwWjA5MTJxc1dDM3Z0?=
 =?utf-8?B?d01PeWZ4MDBLczVhbjZTOU9seVBoTGJTOXc0SEhNaEh5Ymx5aGIzWThyV1Vn?=
 =?utf-8?B?L3BFTUN6ODFKSUkvWDN1cElJQlVvci9JT3F0N0RmVUI3R3FGZGd6WXIyNkpm?=
 =?utf-8?B?WVpSL3BkaHd6ZzZ2THE5ekYyVU1YeFB0ZjlRVFJvMFE1RTNycWRqWnNlVFVS?=
 =?utf-8?B?U040d1oyUjNyUE5ZWHM0cVNGTUVSZ2Rnc1pHa0tRYndYNEYrVkFTUWt2cGZI?=
 =?utf-8?B?MjBNeERVaElZdE5PUnU5a3ZYREQzbHBtdUl6OTN1WWxvZnQxMXhkS0JtN0xB?=
 =?utf-8?B?TXlIZ3A1c2ZIU04zUDNPbVhwOHdrd1BCYnYrVkdLcHRxanhXSUczcmJqMlB1?=
 =?utf-8?B?b0JlNlNSN3ZlcTk0bkJ1MDhvVjBzWGFDMDlVV21hdFJiUjNnbkpWU0ErZC9s?=
 =?utf-8?B?Wlp2YXArNmNINEY0NlVFWVRHK2dhSXpaNlpVTEZnQVFBcnRkWXpTS2E2dXZu?=
 =?utf-8?B?anE1cG9wZkVyTnRJTEMybTJkUTluU2pjK3Z1U0JqRXl2S1RPVW94YlJHbFpW?=
 =?utf-8?B?a01id2xURG5VVTJmZkZrblJWaFVaMWNCaU5FRFh3b3ZRMlBmTWkvRjQwdjdn?=
 =?utf-8?B?TjNLZ0t5dklNQXpmTGRXcjBSa0FmQjJOdk1keUVqcEVUQVlxY3d4WndnT0w2?=
 =?utf-8?B?WmNGNmdkQitWdVdZRVcxcDJTdGJtcGM0NTRkVEUyVG1scExLc3VCa1JPQkZE?=
 =?utf-8?B?RDVCU0hBQXNIcFFZZFVmSnhadXJYcUFLMCs2MDZjbUhBV3c4ckpUeEdZY25Z?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d61664b-312b-4d7a-60e1-08dde4d497bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:13:08.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wI7INenvppMu9RTviW6uTh6BgO+tgQiC33Jjgp57GhfDmGTDO92YCS/ouzom9we7EtDWrd4s5FG1ibOTfC1mCbHuaLX3Y7JnzNw3M4AIvy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF37A184CA6
X-OriginatorOrg: intel.com

On Tue, Aug 26, 2025 at 09:03:45PM +0200, Maciej Fijalkowski wrote:
> On Tue, Aug 26, 2025 at 08:23:04PM +0200, Magnus Karlsson wrote:
> > On Tue, 26 Aug 2025 at 18:07, Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > On Wed, Aug 20, 2025 at 11:49 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > Eryk reported an issue that I have put under Closes: tag, related to
> > > > umem addrs being prematurely produced onto pool's completion queue.
> > > > Let us make the skb's destructor responsible for producing all addrs
> > > > that given skb used.
> > > >
> > > > Introduce struct xsk_addrs which will carry descriptor count with array
> > > > of addresses taken from processed descriptors that will be carried via
> > > > skb_shared_info::destructor_arg. This way we can refer to it within
> > > > xsk_destruct_skb(). In order to mitigate the overhead that will be
> > > > coming from memory allocations, let us introduce kmem_cache of
> > > > xsk_addrs. There will be a single kmem_cache for xsk generic xmit on the
> > > > system.
> > > >
> > > > Commit from fixes tag introduced the buggy behavior, it was not broken
> > > > from day 1, but rather when xsk multi-buffer got introduced.
> > > >
> > > > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > > > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > > > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > > > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > ---
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
> > > >
> > > > ---
> > > >  net/xdp/xsk.c       | 95 +++++++++++++++++++++++++++++++++++++--------
> > > >  net/xdp/xsk_queue.h | 12 ++++++
> > > >  2 files changed, 91 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 9c3acecc14b1..989d5ffb4273 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -36,6 +36,13 @@
> > > >  #define TX_BATCH_SIZE 32
> > > >  #define MAX_PER_SOCKET_BUDGET 32
> > > >
> > > > +struct xsk_addrs {
> > > > +       u32 num_descs;
> > > > +       u64 addrs[MAX_SKB_FRAGS + 1];
> > > > +};
> > > > +
> > > > +static struct kmem_cache *xsk_tx_generic_cache;
> > >
> > > IMHO, adding a few heavy operations of allocating and freeing from
> > > cache in the hot path is not a good choice. What I've been trying so
> > > hard lately is to minimize the times of manipulating memory as much as
> > > possible :( Memory hotspot can be easily captured by perf.
> > >
> > > We might provide an new option in setsockopt() to let users
> > > specifically support this use case since it does harm to normal cases?
> > 
> > Agree with you that we should not harm the normal case here. Instead
> > of introducing a setsockopt, how about we detect the case when this
> > can happen in the code? If I remember correctly, it can only occur in
> > the XDP_SHARED_UMEM mode were the xsk pool is shared between
> > processes. If this can be tested (by introducing a new bit in the xsk
> > pool if that is necessary), we could have two potential skb
> > destructors: the old one for the "normal" case and the new one with
> > the list of addresses to complete (using the expensive allocations and
> > deallocations) when it is strictly required i.e., when the xsk pool is
> > shared. Maciej, you are more in to the details of this, so what do you
> > think? Would something like this be a potential path forward?
> 
> Meh, i was focused on 9k mtu impact, it was about 5% on my machine but now
> i checked small packets and indeed i see 12-14% perf regression.
> 
> I'll look into this so Daniel, for now let's drop this unfortunate
> patch...

One more thing - Jason, you still need to focus your work on this approach
where we produce cq entries from destructor. I just need to come up with
smarter way of producing descs to be consumed by destructor :<

> 
> > 
> > >
> > > > +
> > > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > > >  {
> > > >         if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > > > @@ -532,25 +539,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
> > > >         return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
> > > >  }
> > > >
> > > > -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
> > > > +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > > >  {
> > > >         unsigned long flags;
> > > >         int ret;
> > > >
> > > >         spin_lock_irqsave(&pool->cq_lock, flags);
> > > > -       ret = xskq_prod_reserve_addr(pool->cq, addr);
> > > > +       ret = xskq_prod_reserve(pool->cq);
> > > >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > > >
> > > >         return ret;
> > > >  }
> > > >
> > > > -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> > > > +static void xsk_cq_submit_addr_locked(struct xdp_sock *xs,
> > > > +                                     struct sk_buff *skb)
> > > >  {
> > > > +       struct xsk_buff_pool *pool = xs->pool;
> > > > +       struct xsk_addrs *xsk_addrs;
> > > >         unsigned long flags;
> > > > +       u32 num_desc, i;
> > > > +       u32 idx;
> > > > +
> > > > +       xsk_addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > > +       num_desc = xsk_addrs->num_descs;
> > > >
> > > >         spin_lock_irqsave(&pool->cq_lock, flags);
> > > > -       xskq_prod_submit_n(pool->cq, n);
> > > > +       idx = xskq_get_prod(pool->cq);
> > > > +
> > > > +       for (i = 0; i < num_desc; i++)
> > > > +               xskq_prod_write_addr(pool->cq, idx + i, xsk_addrs->addrs[i]);
> > > > +       xskq_prod_submit_n(pool->cq, num_desc);
> > > > +
> > > >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > > > +       kmem_cache_free(xsk_tx_generic_cache, xsk_addrs);
> > > >  }
> > > >
> > > >  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > > > @@ -562,11 +583,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > > >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > > >  }
> > > >
> > > > -static u32 xsk_get_num_desc(struct sk_buff *skb)
> > > > -{
> > > > -       return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> > > > -}
> > > > -
> > > >  static void xsk_destruct_skb(struct sk_buff *skb)
> > > >  {
> > > >         struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> > > > @@ -576,21 +592,37 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> > > >                 *compl->tx_timestamp = ktime_get_tai_fast_ns();
> > > >         }
> > > >
> > > > -       xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> > > > +       xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
> > > >         sock_wfree(skb);
> > > >  }
> > > >
> > > > -static void xsk_set_destructor_arg(struct sk_buff *skb)
> > > > +static u32 xsk_get_num_desc(struct sk_buff *skb)
> > > >  {
> > > > -       long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > > > +       struct xsk_addrs *addrs;
> > > >
> > > > -       skb_shinfo(skb)->destructor_arg = (void *)num;
> > > > +       addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > > +       return addrs->num_descs;
> > > > +}
> > > > +
> > > > +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
> > > > +{
> > > > +       skb_shinfo(skb)->destructor_arg = (void *)addrs;
> > > > +}
> > > > +
> > > > +static void xsk_inc_skb_descs(struct sk_buff *skb)
> > > > +{
> > > > +       struct xsk_addrs *addrs;
> > > > +
> > > > +       addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > > +       addrs->num_descs++;
> > > >  }
> > > >
> > > >  static void xsk_consume_skb(struct sk_buff *skb)
> > > >  {
> > > >         struct xdp_sock *xs = xdp_sk(skb->sk);
> > > >
> > > > +       kmem_cache_free(xsk_tx_generic_cache,
> > > > +                       (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
> > >
> > > Replying to Daniel here: when EOVERFLOW occurs, it will finally go to
> > > above function and clear the allocated memory and skb.
> > >
> > > >         skb->destructor = sock_wfree;
> > > >         xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> > > >         /* Free skb without triggering the perf drop trace */
> > > > @@ -609,6 +641,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > > >  {
> > > >         struct xsk_buff_pool *pool = xs->pool;
> > > >         u32 hr, len, ts, offset, copy, copied;
> > > > +       struct xsk_addrs *addrs = NULL;
> > >
> > > nit: no need to set to "NULL" at the begining.
> > >
> > > >         struct sk_buff *skb = xs->skb;
> > > >         struct page *page;
> > > >         void *buffer;
> > > > @@ -623,6 +656,14 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > > >                         return ERR_PTR(err);
> > > >
> > > >                 skb_reserve(skb, hr);
> > > > +
> > > > +               addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > > +               if (!addrs) {
> > > > +                       kfree(skb);
> > > > +                       return ERR_PTR(-ENOMEM);
> > > > +               }
> > > > +
> > > > +               xsk_set_destructor_arg(skb, addrs);
> > > >         }
> > > >
> > > >         addr = desc->addr;
> > > > @@ -662,6 +703,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >  {
> > > >         struct xsk_tx_metadata *meta = NULL;
> > > >         struct net_device *dev = xs->dev;
> > > > +       struct xsk_addrs *addrs = NULL;
> > > >         struct sk_buff *skb = xs->skb;
> > > >         bool first_frag = false;
> > > >         int err;
> > > > @@ -694,6 +736,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >                         err = skb_store_bits(skb, 0, buffer, len);
> > > >                         if (unlikely(err))
> > > >                                 goto free_err;
> > > > +
> > > > +                       addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > > +                       if (!addrs) {
> > > > +                               err = -ENOMEM;
> > > > +                               goto free_err;
> > > > +                       }
> > > > +
> > > > +                       xsk_set_destructor_arg(skb, addrs);
> > > > +
> > > >                 } else {
> > > >                         int nr_frags = skb_shinfo(skb)->nr_frags;
> > > >                         struct page *page;
> > > > @@ -759,7 +810,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >         skb->mark = READ_ONCE(xs->sk.sk_mark);
> > > >         skb->destructor = xsk_destruct_skb;
> > > >         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> > > > -       xsk_set_destructor_arg(skb);
> > > > +
> > > > +       addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > > +       addrs->addrs[addrs->num_descs++] = desc->addr;
> > > >
> > > >         return skb;
> > > >
> > > > @@ -769,7 +822,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >
> > > >         if (err == -EOVERFLOW) {
> > > >                 /* Drop the packet */
> > > > -               xsk_set_destructor_arg(xs->skb);
> > > > +               xsk_inc_skb_descs(xs->skb);
> > > >                 xsk_drop_skb(xs->skb);
> > > >                 xskq_cons_release(xs->tx);
> > > >         } else {
> > > > @@ -812,7 +865,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > >                  * if there is space in it. This avoids having to implement
> > > >                  * any buffering in the Tx path.
> > > >                  */
> > > > -               err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> > > > +               err = xsk_cq_reserve_locked(xs->pool);
> > > >                 if (err) {
> > > >                         err = -EAGAIN;
> > > >                         goto out;
> > > > @@ -1815,8 +1868,18 @@ static int __init xsk_init(void)
> > > >         if (err)
> > > >                 goto out_pernet;
> > > >
> > > > +       xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
> > > > +                                                sizeof(struct xsk_addrs), 0,
> > > > +                                                SLAB_HWCACHE_ALIGN, NULL);
> > > > +       if (!xsk_tx_generic_cache) {
> > > > +               err = -ENOMEM;
> > > > +               goto out_unreg_notif;
> > > > +       }
> > > > +
> > > >         return 0;
> > > >
> > > > +out_unreg_notif:
> > > > +       unregister_netdevice_notifier(&xsk_netdev_notifier);
> > > >  out_pernet:
> > > >         unregister_pernet_subsys(&xsk_net_ops);
> > > >  out_sk:
> > > > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > > > index 46d87e961ad6..f16f390370dc 100644
> > > > --- a/net/xdp/xsk_queue.h
> > > > +++ b/net/xdp/xsk_queue.h
> > > > @@ -344,6 +344,11 @@ static inline u32 xskq_cons_present_entries(struct xsk_queue *q)
> > > >
> > > >  /* Functions for producers */
> > > >
> > > > +static inline u32 xskq_get_prod(struct xsk_queue *q)
> > > > +{
> > > > +       return READ_ONCE(q->ring->producer);
> > > > +}
> > > > +
> > > >  static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
> > > >  {
> > > >         u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
> > > > @@ -390,6 +395,13 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, u64 addr)
> > > > +{
> > > > +       struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
> > > > +
> > > > +       ring->desc[idx & q->ring_mask] = addr;
> > > > +}
> > > > +
> > > >  static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
> > > >                                               u32 nb_entries)
> > > >  {
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > >

