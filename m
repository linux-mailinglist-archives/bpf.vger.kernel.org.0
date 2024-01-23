Return-Path: <bpf+bounces-20056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9D837ACE
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 01:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A242F1F22C15
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 00:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81E7131E30;
	Tue, 23 Jan 2024 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0KRmlgq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B5130E42;
	Tue, 23 Jan 2024 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969095; cv=fail; b=Hn0jMeFd5nwCxmWjx2iHT59KGmHolR9nzMH7sLa2smvO+3Dnt3iYfgVK4XmxwuOcoSfJ2ji6XkYdflBwY5C4mSjU53AeNzRSsDBnb4AnMZaa+Vrtw1Y8N2AfYENhvl4hvfPCMirFY01DO0SW4OJjkQgrWfhK260yX2kB5PTV2Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969095; c=relaxed/simple;
	bh=EDJiT0ZlNoKRnzdEDcGx1vHp/1YEH4AHGuiVaUK3tG4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7LakGun5OCSxV9M0HQztWUQ+AGyfKk4RfKa0VT2RHzA1kPG2oH1vE5ZfVfTgxFSiE+uXz3M4j3aY6KDOaZjQD8HTNN9bNhxn07rA7Tuif0r29DR8uw9pX/NCzGY1rhisY7wZFFb+I4kZnmerLRc8e54DHFuwKr+4qjF8WWUgIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0KRmlgq; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705969093; x=1737505093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EDJiT0ZlNoKRnzdEDcGx1vHp/1YEH4AHGuiVaUK3tG4=;
  b=D0KRmlgq8o2DxA+7+OQGjF8lfmjzmFDq6EYktp9fge8fPDgli4HIbFUe
   dSAxqrwSPldgUmELKheitJW2T/zrwWBBl2k4PNRiy+9fd1knUIQRdaFrA
   dv0y01PiNTujeIi5Qth0GprNdyemCBEyMXuRfS3iX90NuSE/m1bGm5uHr
   NYgt/Xw61aK0TdAwBihpNpx9/ghMY6+VBaMJUJz2FH/Hu9YQYCe9gunhU
   RiTM90URYHA93opu8I+X16Vel8ZhDmO7Pc6MlWJG1B54ktATXdRMpamh6
   1zvdQYqhileCGCssOAgeTVVKeLuGsI73Y++5Oazd9thxY0s7G2X3MRMf4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="405124578"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="405124578"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 16:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="27823905"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 16:18:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 16:18:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 16:18:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 16:18:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 16:18:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCn02vD5sijt35Kc5PMtIwno6PdW4EpW1ewwn85+j/VWAQn1nDs0sQsvRq16qTr1GVck0cQDaut3rR+nDexEMy8U9zvclPi0taiRwB7KYWR0QWc3YisOaZJkuzma+vX0CHGN4AOOPo3w07Uvs2EC8UMxaXvn3edH8xtrWafQU10pMPUsm4acuqAeXNstrnLirHj+UL3+PICb0S+km7+VzdW0q8MOhGOvR2G87MLtUt7StPqx4Kle914YdRW9f1WgI/UIWhA0XFuEnd7Wnzoa4sPBsIzE1OcmKOE+EZx9QFT/quINIq8NGbD3c9SvjaC/XIZc2m/ITj+H9d2uPntIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IHucuEr9KYUPZK9FjWaSkRU2MlLIamszfLjHunIrNE=;
 b=OQC13/RWV9wYjB4lQ4KGPZp5Vug7FbXuh7iLGB0EDWWbQiQi/jjsYq//EAKVdLcbO2HqndCQb50VpyQxRLwjv4Y8rfLRB0hGkAjrjfN0zVYlTCV1LQVG8nLRvrqDGuM1Xv3JKhg0foWJyEPSzLq5FpN5FdLnrDR9DnKkwXiYwxMsZY31/Ru4mkugD/VvG5tG/1YC6JJ+4HC7i8MADI3qKpbuXjqWq9k9VdnSEXeBsakHC8OaywLu7ltEDPdAA4BVfo7Z1FxSkaR1z9nRrHkOtf2DP65mSKuFojmjcb8qLC6VnLJJx83XCVOxhPYF5Ux6RC2Arc2rMtwSgADuysezng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7901.namprd11.prod.outlook.com (2603:10b6:8:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 00:18:08 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 00:18:08 +0000
Message-ID: <e83eb3e8-6d08-462b-9ffe-d843e439d7da@intel.com>
Date: Mon, 22 Jan 2024 16:18:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/3] x86/mm: Disallow vsyscall page read for
 copy_from_kernel_nofault()
To: Hou Tao <houtao@huaweicloud.com>, <x86@kernel.org>, <bpf@vger.kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, xingwei lee <xrivendell7@gmail.com>, "Jann
 Horn" <jannh@google.com>, <houtao1@huawei.com>
References: <20240119073019.1528573-1-houtao@huaweicloud.com>
 <20240119073019.1528573-3-houtao@huaweicloud.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240119073019.1528573-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a741c60-44a9-4e95-dad2-08dc1ba8c6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxe/V3ZLfNnKI2f6L1OtsMiBx/+4R2xHgXVV8AkUzitY+vNW5deVKk676A05i3VkItdGEaHnUtSud18q+YqN+J6pA7iserw566JwPjMljKkdQEUt2ZdwpmsDTUsaBpOwziHhgr9KdEhqVjNO7tVkcYB/SnQyfMbbooDvQUoj3GkeNYwuuHX6W/1PDWZ+EHDBhZFXsrspobPkT/a8nvL+mRrMUzA2B9txT4yOSd0yRWvpvRkVf1S2c7clbLJxp0aOKYajgZ54ovI7FOPg6MFSus4K6CKsKiEjLG4sw695UkXWDPvESuHMMI24GaTQVsjwgL+RCLBxTynFXAlqRv0sHALPQMH5LiuKNhyJOjKL+Asu/rqCbkbYKIVFwB5riWxCvtTbtBbt2yZl0MBZqr5ftvAYMv5x4Rvmiymz1jCk/4QHU74LQ/6zkk6e9EBVJnlEQ5VWStCUnsbIfqFZTFNn2f365f3OyJY8h2Xc8t1+bkHJe6dioLxQ7G7tcus5baOGNoaUB9OSyqx+0WB64JM2+5ZnQr7QVE5uWVM0Xa5nvMZS9y2KFURsNe56Lbygcey6R/OSVaooelaHfYXn3vu78dnlzPzlcabIQFo9UhYG6Zgj39MMGVUsLONVe9zwqNnDLCDBPpJMsQyt4p5GjBQtnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(31696002)(86362001)(82960400001)(36756003)(38100700002)(26005)(2616005)(83380400001)(66476007)(8936002)(6486002)(8676002)(6512007)(6506007)(316002)(53546011)(66556008)(54906003)(66946007)(44832011)(4326008)(5660300002)(7416002)(2906002)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzM4OUlkbHhzRmZhenMrNzZrNmc0T2hSMnN5Y3daQkx3N2dpZ05vMk1kUi9s?=
 =?utf-8?B?cHBnVmFVemY5TG9XYmFKdWREVC92cG5HbDNKN0IzdjdtODlPOWR6NEtUT2pP?=
 =?utf-8?B?WC90R3hvQ0szZFRjZTFhaE9mbmV1cXpKVFRCa3R2T3FIZ0FyTFprbm8wRE9Y?=
 =?utf-8?B?akpYOTRWSjJlc1ZVLzVsWFRaVHN5ODdDNGRzdFZRa3FFOFVITFdDV2lLVmw0?=
 =?utf-8?B?a2g2b0FrN0RVbXpzQkgzaDlFK0ZVWmRxN3FsNkIzbzF2L0VQbkxCZGhvL1NU?=
 =?utf-8?B?b1hkOU80ZDJvQndQMFhoVHVTYlVueS82TklYN2orbHhjTC91bGtJZEpldUtv?=
 =?utf-8?B?NFREKys3TWRWb0FQQ2FuZGlXYit1cGVEQW4vbU4zd280NXdvK1kvQ2VrL1ZL?=
 =?utf-8?B?Y0g0OHpmSzNRNGYyU1Y5bEFOZ2JuT2hrYU5OY2MvOXVKQithMGZCTlkvUnlE?=
 =?utf-8?B?SmR3N2VES1A3UStsQXZxa0hnc0JHWElPQXJDamZVKzRScHNCVGJhZFJsc09I?=
 =?utf-8?B?SktBTHFrOVR6U1ZlcWp1TzAxNDM0QXFURXp6enVieWQxSUxuYzNxbnVibmlI?=
 =?utf-8?B?SzlFejZTZlg2YnJmbnJTak1XSGp2dUhRM3ZybEY5eFRnWE9hb1FSaXdPOGtp?=
 =?utf-8?B?RDhINFd0bklRRDVYUEgzcVc2d2lMOVdsWHVEa0xrc2dEdUxpY0dpK2FhY2RN?=
 =?utf-8?B?dFR2Y25XemtueHhLdXNFNEs3QTY2NDc3eGxSN01lV3dTY054eVRWaDhUVVlM?=
 =?utf-8?B?M3pMME8rQ2tUUGM4VTNZM1ZsSzkrQlpsK21PUS9NQW91UHptUkJwRllYeVA4?=
 =?utf-8?B?N1YyT1VDejJJQWE5QktJOG81c1VRa1JOSmZhRlQvRXpPckpOeTdRRHdqVUEy?=
 =?utf-8?B?TFlqaitzMmdCSnhZbnF2UitEY1NMb0tGSFFJUzNaS3ZmVWEyb0d1TEE3L2pi?=
 =?utf-8?B?OHVSTklSSUxPNUNYSlc2cXhMbldIbG5udlVJRS80a3p6MVY0TllYekQrWVhn?=
 =?utf-8?B?SytGU2xFZ2MrQWxrQVZuMnJvMXVaTkFmMk9weGNjaTJaN1pMVEpaT2tyN2to?=
 =?utf-8?B?RHN2MFdhSG9xL3RRcHhMdTYxaTRWYXQ2cVQ1bVNUT2F4RFdDUjUzMDBzNE9t?=
 =?utf-8?B?KzQ0VEdWaG4zcXpvcWd2WUU5c010ZkNtV1luaDlpcTF5STJTYnlmMENBNVRy?=
 =?utf-8?B?OFRDT1JSaUlacWJWSVBXK3NoUnVyODJaMEJrREJHRWkwQ3c0QWJLSS9GS1Bp?=
 =?utf-8?B?TEZPWGVBVEFyam5LbUtxb09ZN1JNVFBjTkx2MHQ1RFltbTlBOHJ6YWpzc2Yr?=
 =?utf-8?B?TVIxcDdOUE9TalhVM2tCekcxWWY1dzFnQ1k5cWVIQ2YvQktKVUlwSk9jdkRa?=
 =?utf-8?B?cm03RzJZc3NVcjRGNXdxUGxIcERGeU43MjI5UEpzU2ZEK1hIMVl2UUFrNi9C?=
 =?utf-8?B?dG9xVzdtckdPemVSSWQzb3oxemlFK3lla1V5QkY3WlJjdlppTXdhVitiV0hs?=
 =?utf-8?B?T0M1VU9ZTDM3R3V3MzVCZFFyWHgrRS92VzBXNHY3NEhGNTNLR3BBSmpPTHky?=
 =?utf-8?B?WENvMG9SUzkxeXE3TmtHY1B2STdicEIveFBteWRMYnp2RzlmUzlzSGpnN1Nk?=
 =?utf-8?B?WnFrazFkK0pRb3h3MUFaeTJCeUpsVnpQTVpsOXBXSUVQVHk0eGJBN1phcTE3?=
 =?utf-8?B?d0MvREtsRlNyb0FuZHFZSkRCSFluZ3gyT2VKTXpDblZZdjRyOG1PNVEyNG9w?=
 =?utf-8?B?STcrMUNYNnBXVjhDMG1oTWJZdTd2dm9xY1dIVDVxUEJTdkNLVitqMzBkZmxw?=
 =?utf-8?B?UnNsTWpSei9YUWdqT2VEak9GQXo1Q20rQXowWWVmbnl5cW4xMkpHUHROVDdE?=
 =?utf-8?B?Q1dDMzlQbHpoa0lTeHJYYUI1bjBmMGJQTEZQaEZtSExSWXp5Mmk0czljRlRF?=
 =?utf-8?B?VEZwNkJITks2aVUxUXorU2lXUER5anZVVVJ3ZGpZZWtERE8yNlhpMXN0NE9a?=
 =?utf-8?B?NnFWZTU2TFBhT3V6aU52V0N3WCtDakJNbGJqYVRSeS85RDJQZ2ZaalVlMVJw?=
 =?utf-8?B?UkdaMmVsYkhpT20reUN6V1RLeFdQVzF4YUhCa001MGdydlhuYmR4YkRIbC9B?=
 =?utf-8?Q?LVqIcvxU3SeSnNJi2iBeF9o6G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a741c60-44a9-4e95-dad2-08dc1ba8c6a7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 00:18:08.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1lSPeTXb0MuKSM2dRqKwt1c5pEr3Fp1ImjOllzqNRXUMne7tctLk1fNaSY7EqkA9nIG0Azp2IHV/hrqfU6h6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7901
X-OriginatorOrg: intel.com

On 1/18/2024 11:30 PM, Hou Tao wrote:
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
> The oops happens as follows: A bpf program uses bpf_probe_read_kernel()
> to read from vsyscall page, bpf_probe_read_kernel() invokes
> copy_from_kernel_nofault() in turn and then invokes __get_user_asm(). A
> page fault exception is triggered accordingly, but handle_page_fault()
> considers the vsyscall page address as a userspace address instead of
> a kernel space address, so the fix-up set-up by bpf isn't applied.

This comment and the one in the code below seem contradictory and
confusing. Do we want the vsyscall page address to be considered as a
userspace address or not?

IIUC, the issue here is that the vsyscall page (in xonly mode) is not
really mapped and therefore running copy_from_kernel_nofault() on this
address is incorrect. This patch fixes this by making
copy_from_kernel_nofault() return an error for a vsyscall address.


> Because the exception happens in kernel space and page fault handling is
> disabled, page_fault_oops() is invoked and an oops happens.
> 
> Fix it by disallowing vsyscall page read for copy_from_kernel_nofault().
> 

[Maybe I have misunderstood the issue here and following questions are
not even relevant.]

But, what about vsyscall=emulate? In that mode the page is actually
mapped. Would we want the page read to go through then?

> Originally-from: Thomas Gleixner <tglx@linutronix.de>

Documentation/process/maintainer-tip.rst says to use "Originally-by:"


> diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
> index 6993f026adec9..bb454e0abbfcf 100644
> --- a/arch/x86/mm/maccess.c
> +++ b/arch/x86/mm/maccess.c
> @@ -3,6 +3,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/kernel.h>
>  
> +#include "mm_internal.h"
> +
>  #ifdef CONFIG_X86_64
>  bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>  {
> @@ -15,6 +17,10 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>  	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
>  		return false;
>  
> +	/* vsyscall page is also considered as userspace address. */

A bit more explanation about why this should happen might be useful.

> +	if (is_vsyscall_vaddr(vaddr))
> +		return false;
> +
>  	/*
>  	 * Allow everything during early boot before 'x86_virt_bits'
>  	 * is initialized.  Needed for instruction decoding in early


