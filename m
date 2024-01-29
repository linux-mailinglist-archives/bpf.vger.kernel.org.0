Return-Path: <bpf+bounces-20638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2484172C
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 00:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23FFB224ED
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A3537FC;
	Mon, 29 Jan 2024 23:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+ayT7GN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D2524AC;
	Mon, 29 Jan 2024 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572603; cv=fail; b=XTsa5hhZ29mKulP1sMCVrGHggXM8N5kcomdCStbjzQitWjOUKhnaQmSi1G1ZTIuFvJPoYHYJ75nKIamlXHjmsxf9M2smPOmevA7NZcOoWt0RUdcCjolHtqfXQKkBsK6atMqDz2QdJQUZvXjUSDNjpZlSOHK3bldHIe9AJLopSmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572603; c=relaxed/simple;
	bh=miVy9vsWt8Fjl7jFLJp5EaE9hF2QwGOHxgcG7FKOiCs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SA3on6DmVWfUrw8tDeo8/8wakCHW0OBnBqi7aHnVYupDS36tA9YI6c/FexMmX66EvYb4vAwI6QmW3vJMRZEzQtsRw8Wx2i2/G6Ln4fA36MMTYKn7sgxYD43PXusThW7vqu+Ca4C+3vcnOJ63F0ErQu8rB9EHUAUErls6CD9SxBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+ayT7GN; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706572601; x=1738108601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=miVy9vsWt8Fjl7jFLJp5EaE9hF2QwGOHxgcG7FKOiCs=;
  b=P+ayT7GN1553WplA7LlqYB0bTeK9WNjnRupjjkHrCsmy7YhuvOnSsfON
   Yh5k5oktau2WQSwIbkV79ghU2kSE76J71zh0WaqoSQjeYD7mSgBWWLtkX
   G6v8uWhKgS55Kzf6VJEwPKlZQuM+KzDZWnxFFfIT5ledLSOMJE4JCPbao
   2/8TeCHRfP65OMUahA+r/YF1PC6LSbLhdWKR6Ubz+3dFa1Xyr5pDewo05
   voWp/ARtimgJy3adDDTBtnZquXbdxlxItTaGUD6MaH9kpr2zooQFbn0Hl
   k7kPa7H0JD/GmN6Gomu7xaPcZE4iGlT9CknDT08qbtcbtpV1Ado6YQFFn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="401989700"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="401989700"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 15:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="787996304"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="787996304"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 15:56:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 15:56:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 15:56:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 15:56:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1USoRCBrALR/ce6jMiCzz6vX4dw3mAG4bfnCEE7mocK9Nv4iLv7+T5CMM2aG7rPcR9eGJXIzVzdIg0fMpnBLWAS716xp7wSDS181L4wtGxaI+H/xRYmdwyo7kRcTCk13oZcmfTGyDRU7FuFBzC738CiPcRPmGo3bZllFwEbu3/zHV9RtloEfn/hBQgv7t8/1lnG2bWlYi6Z+1uEBQ/oZc3mPFwuu9S92Nga1RSQ9V35OLkKdga27QNNs2V7klxm4jfjrIjbJORMAmtZyr1NAoeo4IBGTJEavfSApevI+Nckd9tiTCXSeWD3dCm3evrlO7v++dOE03L3KfPrFNxveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciM+EFBMWMBZo9XoxFbwr/ohzL+GvZXpVuMdBeplanY=;
 b=Vap6TWca2H7Mv9NUcV8BY62BapWIz+pod0dueL65ZX+nUH+v64kDaO2VEgYl3e3HtoZ8JR+tL3NGVQkRMGpb6UNOepm6OKDcUO6HAyCt+upgo8T3vcjUrk1MalK827pP+zGrQhsaKPisr9qzrBxjEXVOnV7JPVLrxiLRz21Gp6RlNRseD2N+AAzNdsuzPmTuU4bIfDZeuEwH4Anw3jRguP8qN2HTHeWuy4Uw47VDe35KFwQC+aXJiHw7SAr/Af3KSST0AnyglR4TAN/Q6tKEBxSF7Wz0wm3NBg0yeY5/yAh+Bsj7USvp4T9c4UEd3nIWflm9Ne0MBJfWOgmRS0/XPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 23:56:31 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 23:56:31 +0000
Message-ID: <76af5d2e-7598-42b4-9ed9-8fec25ece057@intel.com>
Date: Mon, 29 Jan 2024 15:56:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/3] x86/mm: Move is_vsyscall_vaddr() into
 asm/vsyscall.h
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, <x86@kernel.org>, <bpf@vger.kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, xingwei lee <xrivendell7@gmail.com>, "Jann
 Horn" <jannh@google.com>, Yonghong Song <yonghong.song@linux.dev>,
	<houtao1@huawei.com>
References: <20240126115423.3943360-1-houtao@huaweicloud.com>
 <20240126115423.3943360-2-houtao@huaweicloud.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240126115423.3943360-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: c14897dd-c7eb-4d86-5795-08dc2125ea58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pvm1dKfFubxyrpQvTpMqVdTONtYeQqDPnjUao8bAlV1O9vkmKwkHqkADI/yuyTk8wGw3VTVK7Up+6lGBhboF6AWSorkt8YqpR4kvt11T5AqfR4gdIX7nA9nwGTAF970BRGbhaLjDF+hu+63jmpFTUmqgPDWa6+Eb7P4not8JDMf49gfj4MhOX+mNevkIVble5zMZGpobPFZ5Hka8icQK8Axx+PCvIpY4dzww9sLE0GRSOE4r+bhQ+VG9gaHXmrFSGYYIyNrHCedxeMHqJ12Ia0hcZuSPcFK1WUBEZJHU5RXriJmIHaj+bEXZcYRnvchQCmAQJsCtj9hoUKsyr0P6+5sHAsBa+NtPwdHb0QylxiUMowkS2ZPV3QqvfcrGUtHivbWMnTJLS12o7lJRQmmfr3iREk4bW+asp8xyK2GDaVkaONRy6xAqUXVsPqG9aj4iFAPH5n2wbSF8sEEskWwPuiGpVccE6aMyw/3/iUlJDKLvRTfhjQ9dlIhvaCDCi1/1CfMUEHD6w7fjsYrRqR9pKzAzhYvWl64onr4BWTqCZW/a+BEsvlephCQnkpVJ8L20Fwc5Uh2WyCqGDTVVkdmnWHw8OzOCvByph+TJA7nHFMwgs1s3RlH5wtDoKxj4sI1OizH4XwSxZAjPUX8Ue6Y/bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(83380400001)(86362001)(82960400001)(36756003)(31696002)(38100700002)(26005)(7416002)(2616005)(6512007)(2906002)(66556008)(6506007)(53546011)(6486002)(8676002)(4744005)(478600001)(316002)(66946007)(54906003)(41300700001)(66476007)(4326008)(8936002)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEhZL3JFUy9QT1owK2VQQ3hiU2FjWjQxMFZhcC9UMHRSYXpOU0Z0dlRkc3Iy?=
 =?utf-8?B?SkxBalVMemJTVGo0YmtmWThmNFd2V3NteFI0OTFIQ2FjQk1BOWloN2lMcDgw?=
 =?utf-8?B?ZHVVdnNXMkh6bU9OQmxyOVN1TU8vcGwyNjVBRy9ITWF6QjBIVExWeGtac0tN?=
 =?utf-8?B?dzZPVGo4MGh5dXVxOThNMUw0QlNndTlOMzdXc3dvQ05ZV0F2S2pxQjA1WCtD?=
 =?utf-8?B?T29qQmtUSHZpUGRLdkVVaEJ3R0Z1ZnEzR29aRGtlMlBabnV3N1dSMUxjQ0ZM?=
 =?utf-8?B?RnIzVFpzcjArU1hBTnRJZWdqN2R5bll5TnBpVUdGVk85V2NTb0NOYjd1SytB?=
 =?utf-8?B?SHV0b2xLQ2l6cVV3Y1owOXlzcGFTUHM3amIwTHRMNU4zVXJvQ0NZbVBVWFVL?=
 =?utf-8?B?STE1MkRjb3FTeisrZjRJRUw1Y3ZoNkpWWnUzUG1BTG9PV3diOE5GdDJiaFZI?=
 =?utf-8?B?eSt5QzBsWVFHTEVHT1V5WWFFdnJBeTlKeXJ5dEduYzFaVTcvWnE4OTJ3enZY?=
 =?utf-8?B?TUVELzVGVzhMQ1NCUDlUV1VoNUNzNUdYSE5CVkRGMUpmSldYQTlJaU5KMkpK?=
 =?utf-8?B?Q0R2NTY4TkNBWEd3STFtOG45UzBsTkhjZThEU0ZrdnRGNlllK0VaVVp0TSt5?=
 =?utf-8?B?Tjd6WWhFY2ZUUVgxdGZrK1FwVzNqNFJYMU1JcXNGQ3hnbDR0bEN2YVhUampW?=
 =?utf-8?B?UnRuNDgwZUE2aDBxWkF4MEtULzJWWDlOSkNOem9GOGNZcjRyR3R4bEtYMkE5?=
 =?utf-8?B?aGtjYWNzemhJN1c0RW9UaCt0NTU0aGtSZzNCcUFVYjQ0WCtiNncwZHhic0Qr?=
 =?utf-8?B?c1lUNFJuUkhhQUpScFBiUk9LOGZmczN3ajBaU0M1eWU2MEprSUJxZm93RVhU?=
 =?utf-8?B?M2pDaHZoeTZBdHZIdE91MGdIeFo1OCtrNW1nR3gvUTMxN2E1UWxRTVJtU3pR?=
 =?utf-8?B?M0MybFdvUDBZejU3TzRFRytmM2RoMW5pTU1lWmpJZzZocGZZazNmNGNGUUhY?=
 =?utf-8?B?cmdmU3pxQm1xeU04TXpPN3lCOThhdHJwbm8vOGwrVGJvOUxGZGRtOEtWUkpP?=
 =?utf-8?B?MHI4ZFR1RE5CbE5FZTJzd0dhQnRpVXh1VzRMMFUzbkUwNUQvbmZraHl0SkFs?=
 =?utf-8?B?UCtlelBNY1FxNEM4VnUvQk1mMkE2MXRIZmt6MnJScUxpSExPRGdVSzJQVnZY?=
 =?utf-8?B?Z3Vub1B6QVRsQnV0ampkQTV1Wk9HVGptRDV1KzdxVk1vZkFBME9qQmIzM1Uw?=
 =?utf-8?B?T0tWVUxnbXlWNzNBQTJ1QTRpMTAxckFuRW9TenBhNUdKelU4TFdhK2liYlpT?=
 =?utf-8?B?QW1IRTBneThvOEJ4WDh5YzJPL3YrWmdUaHRIMXJpSk5VcTZGc0o5MHJFSzZS?=
 =?utf-8?B?Y0FQRUZqV0ZQbGdGdTBCVW9mRllWR1cxSnI3T3J2NlB2S3hqRU9pZlNPN2ha?=
 =?utf-8?B?QkVvUUpEY053enpzNTF6VEp5YTd3VTkwU0YvTEdWbHM3d2tsOTdob1BFT1o1?=
 =?utf-8?B?SWFONnZJRitCTzZSOUVGOEpjREx6RjNubU1pc0I5RXEyNkZpUGRjRmRMSkVZ?=
 =?utf-8?B?K1huekJtV2J2SkMzRVJJZGlOZkczSytXVFRoWWZ6czRXOVYzRUs4eGQ4Smly?=
 =?utf-8?B?bzJPR2pOMUZnRThlUWlLTEd5TmhoUjRjTE9sbFN3NVVKR1ZLRGMydTVpNlo1?=
 =?utf-8?B?cTVNZ0pOUlJZVFgyNWRVNUtsd1ZDUUlDSFVISk9hVVNKZGlrK0hUMW5lZWt2?=
 =?utf-8?B?RTlCeHBqclpDYmpldXBNcU41ZjAra2lHL0dZSGI2ZUh5bVVWNUxvYTNCQzF3?=
 =?utf-8?B?YTE2bVAzYVU2SFdZSUNuZkgydDFIZzlUaEN3RVFTaFoxbEIrMDRPcVFLK2Nw?=
 =?utf-8?B?ZHNoQ2tibUtaK3o4T1I3eDZIYjYrNHVFNHI1ZTRRWFF2aFp0YVR0OEI3bGZp?=
 =?utf-8?B?WVQ3ZnZMYmxqeE53anlHSGJCTDVMR2h6dXZITFcyL1R0d0NTTDRrbmtQYStF?=
 =?utf-8?B?RFNvWkpHbGxBdWI1NVpJQU4rNS9UZjk5emRRUXFvcUd0WVFyNWNxRFN4Rmhs?=
 =?utf-8?B?WS9ncVlUSE9rdDkzR1ZiRWJDT29UZDlneVNzMzdBd1hORFN0WTc4ZkVYVWY0?=
 =?utf-8?Q?1tdx7ij6/UplBdH9bqsarrfHb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c14897dd-c7eb-4d86-5795-08dc2125ea58
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:56:31.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5k9fa7lxy4ffF9j5wornGOrFbV+cRDTJonLojiOdi8rIoro98QWjZvhpolovJWSsGvtLhbxLJqyRaMIrnmUbMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com

On 1/26/2024 3:54 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Moving is_vsyscall_vaddr() into asm/vsyscall.h to make it available for

s/Moving/Move

> copy_from_kernel_nofault_allowed() in arch/x86/mm/maccess.c.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  arch/x86/include/asm/vsyscall.h | 10 ++++++++++
>  arch/x86/mm/fault.c             |  9 ---------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 


Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

