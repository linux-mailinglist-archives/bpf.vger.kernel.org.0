Return-Path: <bpf+bounces-20637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC9D841728
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 00:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A7F1F22145
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 23:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3C53803;
	Mon, 29 Jan 2024 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvX5c6eA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E042AD1D;
	Mon, 29 Jan 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572266; cv=fail; b=Rgj9OjlvRnHG0s9eRWDlLMVe5uv/HErNwZaOaBjHZEsQDC+yjJDcEK+1pVV825dtuHmhhuVW6kSTvE2PJJ51AjmuNP838zfsIBPzfkgEhQzoGHj6yxKwjjOPXJQdfRhwOI29/au7e3Q5V8AUFPl/sNNofP8waFJldCRqAhCJZbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572266; c=relaxed/simple;
	bh=RVzCNaEQOgppJwPancE+ZHCnqcD/QCLasR1KyPjZ0h0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KWW0H8AlTREVgRHR+ZTfIqtthX2ECOOqojusLXiMzP418E5875poBdorqL8AOhtQZX4zvo79wbvMJyzFwdERwGj5JxUbgw05OdTmb1Q9kDbm7ZbqOrFlMSfvcOhafyBHAAWlBK41Dlmf8PjUMJDu17Vdemfzom+1APJy5LrOj0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvX5c6eA; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706572263; x=1738108263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVzCNaEQOgppJwPancE+ZHCnqcD/QCLasR1KyPjZ0h0=;
  b=CvX5c6eARi8F+vDZ87aLR5ZMJ0pWe4YnUnbsxv0564DtUnv91IoCRPFy
   KN3tFNLRB0kisi0NLG5opblXW/Mtq7imJKxS9V51q3a274349r1ewBp91
   IQzK4xbMvWHM5IMEIitkGpc+nBGLaxOxQjONiPXqj/hoejl9ih4ifDOmo
   LQMuSQSHWINFv+lwjw+AjD+VebIsMEa5XGq5WkYSoCBXwQm4c3ObXFaFY
   +3MdI+nGZkNp/PWYxlz5DKl6WA5vDK29eajQC8Ew8A7Uevw5LRMKpJApr
   nh00dq5FVoii/A77GaM1oQDKuVPqmOcL0T6Jo6yseDe5h3x4ZpNZJmJOH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10508965"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="10508965"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 15:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="1119067246"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="1119067246"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 15:51:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 15:51:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 15:51:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 15:51:00 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 15:51:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSFHhKhb6vYwX49MAwcIS8BYh01fF27L9HFv7l+cLGcFPaGAbXFsAR4qrKGo8ONjxNNmGnt6HNNdZAdK0/BRVKuYoPnU2XfsXUr+hircCPFMn4qZQ5SbkdFNxqJKTsC0Q3rlHK25UpY5oGTDoqfNkq9G5dvdsTmglgngilzExmVLZxBUb6URO3HlVDe6TzAYh10/nepCXq16+QlV+DKZ+P7VVZ2cw96HeSf1ogwkm02lYeKEK5CnYQ6idssbwZzMAaH3o3WL4qhKHFtn9XUoWnvhaWuwlVOpj30yJtWbjDhfMa0eaSksrsoyfKTlWSWjfqW8bTcSwVkcoCL/5Y7qXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwdOTMub51kl7e0bKU7FCbcjkNAyxoRwgPRkgCF1HhY=;
 b=Gbjnw9JY+n6KdZpzo+gDbj7JAe4OXtwQNcHwKLaatX5Smdwj1Zlx1LUCdH/31BI49b7DVI3CK5j1ao7lNQATsh1HlDHIImMuNhX1245Dkjk5N+FK9ByMZMjIMpcOQuXfyJNJqzbDxiRjW5YJEo0ZQAETpyVQhz6n49LTu7FXF5Jjw+WTG1KNJRtonBnfUCbMprkjABexCKbC7PZMgYtq/xgpg3Pa4wDB7mpeytutU4GXxWj6u1qtsecnPK5JOe5JzIEdod73oOz/vb3wmpBFdkrTnH4D5b44dQU6KD49rKADqdWIunygH/Zjpe2p3ImquTGPDZ5BaHrwpqyIsk9Ybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 23:50:56 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 23:50:56 +0000
Message-ID: <51d92a32-3d0b-41c5-96ad-0739c6f80256@intel.com>
Date: Mon, 29 Jan 2024 15:50:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/3] x86/mm: Disallow vsyscall page read for
 copy_from_kernel_nofault()
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
 <20240126115423.3943360-3-houtao@huaweicloud.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240126115423.3943360-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f352e4-4a09-4d4e-75bf-08dc212522bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lztvogJF3HeIbWnlg2ooUqnkt7XoFKX4LbvDGOJ6ZNaPWM0l01VuaAMYD0p863rk3AuN+tvlYKZRTrkrGG+xogWhYSucVCPJ/QZzPQtxfErHwtGBOZbt7lipWK4lIQlvDUOlqmMnSbi/ajQeQu3kp1gCQg0fa0TlzUZNndQ5DOboa68KBKdGcZeGrSYtgLys/KP6vQh5OctgMMrUM9vOIRdKm8k4A/fWmDnqfG+CAIRg48Tl+z4K/wFCUnt/j1yjxKhIb8YybvvrnX039kT+h+kmA4WXD0if1tefK38thW2/LT7i4XKLXyIc1anHp5BiHladxRgnz2PT/UHiK4xlfD70tj8LWExEdm8RdL1kZFYlBC1YS/XxyhXyRt5BWRxqAVEvdv7/oW+U3/Vr1oWWP7exSmEqExK3ayUrqKSZdgxJW0F0T21dOyOZ9m2V7R3LR4Fm9CU8aDgrIreFjAM1jFMG66x/uhErv88Y4vHTh/bLGybWmWfAYWrnvGIIYh0Lda082Dj/clm6h5sJBgWTBUIYOZ3xrgsrVp7SSWP3CJbKWnyIxULHHXCo1dPUIefH6wrUiXkVwcVfUkFoOWCwIKLk83Kl+eD6BbXQfSc9hDwHf3mwJelCxaIk45NUbHNXoA6q5gz7jOvAKWeMoPE1iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2616005)(7416002)(6512007)(38100700002)(26005)(4326008)(5660300002)(8936002)(44832011)(478600001)(8676002)(966005)(66556008)(2906002)(6506007)(6486002)(53546011)(54906003)(66946007)(66476007)(41300700001)(316002)(31696002)(86362001)(82960400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0lPUXlZbHo3Z2c1RFZnemhEUWhxcE1iR1U5cXRSaTY2RXFzMVlPd1hyRjgr?=
 =?utf-8?B?VGxEUHlmeE5RUEN0RGtkT3p3bnNOR2hOb2JnaC9FZTBLL1hMaSszaS84eUZj?=
 =?utf-8?B?Wkh1M2xoREhCdEV2cDN1eUZ5N1g5TW9YdFhEYXRXYTNpUWsralVFSWsxZ3Jl?=
 =?utf-8?B?YXV2eURyRGVseUhUYUx2MERxK2svdWtCbmFCaUZFaFN5N1JOZkhRRlZUWVNK?=
 =?utf-8?B?cEg2emlQd1g4N3dWblZsc0FlUGFvT0JyT21VaFV4eDE3VVRhVm9neHhiNWF0?=
 =?utf-8?B?akhGVWxwMTVSdGNJUTRuRlMyY3U1Z0xmUkx6eHcySHZ2L3g5L0pnczg0dWIr?=
 =?utf-8?B?cGEydzZRSmIxeC9GNXIxZFhPaEFGQkMrL1ZUd00zZXdRaFJwNUlYeXdkRkpM?=
 =?utf-8?B?dTIwSXNzS243Wks3ZzNDQzNneEsza3AzRDhYd0JZMGJsankrZ0dTVGp0dkdh?=
 =?utf-8?B?Wm41NWpkT1RYVUU3S0pnZG9XMitIMHB1d1NLT0RIOTF6OW0wOGhpa1cwSS9n?=
 =?utf-8?B?UmFvb1RaQ3I5dHNPb2Q2bWo1Vkl4d1doREQrK3o5Slprd3Yyb2pVclA0T0hE?=
 =?utf-8?B?ajBaZDJFTTZPZ1NPZGtURk1UdHd4UUJ0MmdCNWVrSG10RGdUUHNqeXVKN2g5?=
 =?utf-8?B?cXJ1V2tOSlZjMnFsU1RpYm5mT3k2aUdYQmpGZlgyTkxNUDA4eEZNb1ptWUhQ?=
 =?utf-8?B?d0s0U2VWK1FJRGk0Rk9oY2JLdlcvbC9Fc0R4RnhrU0FJUUVTZm9IQUpibHFM?=
 =?utf-8?B?TS9Ta01kU1c5amdGcnIxY2RJcGlMa2lZam82N3BLZW9GL1IxRXVPWStKVmZK?=
 =?utf-8?B?U1d0VzNpeGhDbVVGdGh2NzM1VFlMZkNYOU83VjJBZnJPZmFQa29IWjd6UjhH?=
 =?utf-8?B?SHNFZi9EWWhkTnZJV0s0VzhZK0lnbW1RR3l4OUVaSHkxNE1Gam5uRElTTzhR?=
 =?utf-8?B?aU9hUHF2ZDI2aU9LUGErbXJhYjVobkpCdTQwdVZwaERlcHFFWURKY2NXbjJa?=
 =?utf-8?B?SXU4UkdJT05wdm1ZTWh2aVVnakxBenlTQXV5Q1lZMlg1VjkrZGVsc3I1THkr?=
 =?utf-8?B?ZlFUU2FKTTE0MWJDN3RpQ1VYQlRoQUxEZEVWODlETXNSZ0VERlkxeXZQaGUx?=
 =?utf-8?B?SmFSWU5FTGNoT1RhVDdPMnNRcTdMQXdJWUU0UlY5UzBmSTdvcjVGWFY3eVpu?=
 =?utf-8?B?eW1zcTRzclBnWVduUkJDdkNWUkVzYUJlZTd3MFowcnZhMXBQWUZ0UzI0dU1O?=
 =?utf-8?B?ZEhXN1pFcHpHdHVRZXlpaEJBL3ZtcTk0ZmZGc0ZKWHR6SFI5NWYycHhGSGhQ?=
 =?utf-8?B?cVRNSzA0T3JySTZxS3Jsb0dSVjdIUkZDRGFZZXVOL1ZRTGpjdURxMmlacm54?=
 =?utf-8?B?a3U4WDRzMXpoS2h3SjhnTTNFaHdXYyttUHZSbGNCS3g4TXJFcFphNGZhWmMv?=
 =?utf-8?B?U0FaQU8yeUlVb21tSy8rMVkvcEhYU0ZDc2xJTTViUElRSVk5eHdDc1N6VHNq?=
 =?utf-8?B?SUdZY2pqMHJtL0JQYWJ3WnMxSEJzZG9ZblA0aUJhMjBiSllvUVhaVFMyVW03?=
 =?utf-8?B?ZHNqeEdId1FXUUlXbXprMEU2M0VtSjRwYWxBRXVtYzRjZ2tBRG1HeHptTkli?=
 =?utf-8?B?ZTRxbVhTM2xUOS95MXJQK1RnaVM1MkI2c1p1dEdKMVN1Y3M1WUo2YThMdmV2?=
 =?utf-8?B?azQ3T3YxSmE2Z0kvZW5IbHpKZXFVaVlvR0wxTS9OeHIybjdOanIyMEMwZktw?=
 =?utf-8?B?Znc0VytsSXBqUlR4aE8zbS9ZY2FPeFRNTXkvNE4zZkpWK2RiM3lQSGNrbzJE?=
 =?utf-8?B?Wmd0bnpZS0l1UkZISCttQUp4b0tSRE9PVG5seUFoeXlKZE92cG4vbUMzQXN1?=
 =?utf-8?B?Y2NjRGtkMys3RHdQeHU3Mnc1dzI5VzNSeFJaQUNnLytHRUhzeUdrcE5mZm80?=
 =?utf-8?B?WWxGMm9UU241N0UyenRPOGNJOWsvM3JGdTkxSENINC8wbGd1TVh4L3JiL05I?=
 =?utf-8?B?Qm8zYnNRYVFadEFxdjg1QWZpaEJFZlI3dkhESlV3THZDMFpEM2ROVUJHSmFG?=
 =?utf-8?B?Q0lvRE5iT2ZPV3hlVTdCRGlud1lNMWo2VHJIcU8wellDYmR4U3JvRkw0d3lD?=
 =?utf-8?Q?c2vvpXeYJmUmsHdiBZ1t3GyET?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f352e4-4a09-4d4e-75bf-08dc212522bb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:50:56.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45xESWthPKut88OlWnwHGNzSsGcUTIT1Gu5qDbGvsGdVYht6qRYamqd2xRzbMejohqmze5dEzEuL2vqR+yDL7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com

Hi Hou Tao,

I agree to your approach in this patch. Please see some comments below.

On 1/26/2024 3:54 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When trying to use copy_from_kernel_nofault() to read vsyscall page
> through a bpf program, the following oops was reported:
> 
>   BUG: unable to handle page fault for address: ffffffffff600000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 3231067 P4D 3231067 PUD 3233067 PMD 3235067 PTE 0
>   Oops: 0000 [#1] PREEMPT SMP PTI
>   CPU: 1 PID: 20390 Comm: test_progs ...... 6.7.0+ #58
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
>   RIP: 0010:copy_from_kernel_nofault+0x6f/0x110
>   ......
>   Call Trace:
>    <TASK>
>    ? copy_from_kernel_nofault+0x6f/0x110
>    bpf_probe_read_kernel+0x1d/0x50
>    bpf_prog_2061065e56845f08_do_probe_read+0x51/0x8d
>    trace_call_bpf+0xc5/0x1c0
>    perf_call_bpf_enter.isra.0+0x69/0xb0
>    perf_syscall_enter+0x13e/0x200
>    syscall_trace_enter+0x188/0x1c0
>    do_syscall_64+0xb5/0xe0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>    </TASK>
>   ......
>   ---[ end trace 0000000000000000 ]---
> 


> It seems the occurrence of oops depends on SMAP feature of CPU. It
> happens as follow: a bpf program uses bpf_probe_read_kernel() to read
> from vsyscall page, bpf_probe_read_kernel() invokes
> copy_from_kernel_nofault() in turn and then invokes __get_user_asm().
> Because the vsyscall page address is not readable for kernel space,
> a page fault exception is triggered accordingly, handle_page_fault()
> considers the vsyscall page address as a userspace address instead of a
> kernel space address, so the fix-up set-up by bpf isn't applied. Because
> the CPU has SMAP feature and the access happens in kernel mode, so
> page_fault_oops() is invoked and an oops happens. If these is no SMAP
> feature, the fix-up set-up by bpf will be applied and
> copy_from_kernel_nofault() will return -EFAULT instead.
> 

I find this paragraph to be a bit hard to follow. I think we can
minimize the reference to SMAP here since it is only helping detect
cross address space accesses.  How about something like the following:

The oops is triggered when:

1) A bpf program uses bpf_probe_read_kernel() to read from the vsyscall
page and invokes copy_from_kernel_nofault() which in turn calls
__get_user_asm().

2) Because the vsyscall page address is not readable from kernel space,
a page fault exception is triggered accordingly.

3) handle_page_fault() considers the vsyscall page address as a user
space address instead of a kernel space address. This results in the
fix-up setup by bpf not being applied and a page_fault_oops() is invoked
due to SMAP.

> Considering handle_page_fault() has already considered the vsyscall page
> address as a userspace address, fix the problem by disallowing vsyscall
> page read for copy_from_kernel_nofault().
> 

I agree, following the same approach as handle_page_fault() seems
reasonable.

> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Closes: https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  arch/x86/mm/maccess.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
> index 6993f026adec9..d9272e1db5224 100644
> --- a/arch/x86/mm/maccess.c
> +++ b/arch/x86/mm/maccess.c
> @@ -3,6 +3,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/kernel.h>
>  
> +#include <asm/vsyscall.h>
> +
>  #ifdef CONFIG_X86_64
>  bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>  {
> @@ -15,6 +17,13 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>  	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
>  		return false;
>  
> +	/* Also consider the vsyscall page as userspace address. Otherwise,
> +	 * reading the vsyscall page in copy_from_kernel_nofault() may
> +	 * trigger an oops due to an unhandled page fault.
> +	 */

x86 prefers a slightly different style for multi-line comments. Please
refer to https://docs.kernel.org/process/maintainer-tip.html#comment-style.

How about rewording the above as:

/*
 * Reading from the vsyscall page may cause an unhandled fault in
 * certain cases.  Though it is at an address above TASK_SIZE_MAX, it is
 * usually considered as a user space address.
 */


> +	if (is_vsyscall_vaddr(vaddr))
> +		return false;
> +

It would have been convenient if we had a common check for whether a
particular address is a kernel address or not. fault_in_kernel_space()
serves that purpose to an extent in other places.

I thought we could rename fault_in_kernel_space() to
vaddr_in_kernel_space() and use it here. But the check in
copy_from_kernel_nofault_allowed() includes the user guard page as well.
So the checks wouldn't exactly be the same.

I am unsure of the implications if we get rid of that difference. Maybe
we can leave it as-is for now unless someone else chimes in.

Sohil


