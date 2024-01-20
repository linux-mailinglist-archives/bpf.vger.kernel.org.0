Return-Path: <bpf+bounces-19959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF808331D8
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 01:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 775DEB21EEA
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A010A65B;
	Sat, 20 Jan 2024 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6R2SfdW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43C392;
	Sat, 20 Jan 2024 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705710918; cv=fail; b=MQqeWzN1uld5MX7WvjArgkhNc+L7dzrDuPW7+saM/htK0EaC4ipAq1hm1InmPJ8JwPXyVH8hW7vHYkARXdnuf7Rm61p+8wC9lbxCQDRTDFS6DnxKHlJE1tqxJAzhpqzRce5Tjwi9OT6BkZrwjNhs+9GXMenGT4kmdPmwILxM/C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705710918; c=relaxed/simple;
	bh=x1cwYpIE3A/VdZBLWpoLkOEnPcQjNEyIVLkpwWBeX+0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UTH3q1q9dslZKD41CgkicThHZstGPJwvorbMYCAzQ7k5nft8IiptyB/q1u58mkIXaLMbFjqPCnZqoxVPwJ8wCokO9QM1VjrQffTzEld1RLYHs/FADv9p17rThzlbZ6It4unBaU+mapSoX9/OLfG/qthpcdJ86UdEsOjJNf9KLQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6R2SfdW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705710916; x=1737246916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x1cwYpIE3A/VdZBLWpoLkOEnPcQjNEyIVLkpwWBeX+0=;
  b=R6R2SfdWVyVyKJI6elWLeqRJBnEaRrkpkzK3k+gRmZ3Rs65je8WQ8YR1
   febL7RJcccVc1YCRsvTflTcdTBqE6/Cgs5rbvisIV5pEMfSDUvXHoPTXK
   Cw22F4/ZdvPagJ8ihx6cJF6vuy6ga08S+OX5Ak4udHx1wsSUydJUyYDTT
   DRdqJ5/RNr+hvA6CFUzHbSOZ3lTkLDPkR+5GfvmfD1NoCf5kfFGsyiyyT
   Gad4Pvb1sdqYMQ8NC8uKVWHiNFtqU3S0AAds54BsWXYp4v9DrFQTlddxt
   JZKfQFWL8nXHX2AlgMSQ73p78N+SmIOKQZViW2qyM9mOJFpLTyviQQvTk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="8258081"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="8258081"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 16:35:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="713282"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 16:35:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 16:35:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 16:35:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 16:35:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 16:35:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaWPfUq5zXmaktPoU4zkfHZ891+7Y2olPoKjJIa7x6uRZvrImTr+96jlEN4DAUz5u3jb4raWhHJvikiF8nutLWU5uSz1TKFKFR0ytZAI5xLNyEdM/zyORDUlQ1LJPOgHPUCiSWXrIwuZXHmvWHj1KLZtwhZM0hVTCilYoRAmg4f+I9vbG/8KwKdR/LzEmrh/wpnxZMuj+/2DuUpVl/R+5Tfl8kuqPomRsvyzKUnIxTOLBa78x81FKv9x30fdHy2P1Kd6oRKhjn5jmOBWhYc//83G7rHYwlo+H1eczr3lqf68nkNw7mWUVS/qOwrPCay5MTbk2/PvF/39v1ya1r9pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKt1I2zNuNj9xJ6P+qEvZ4jDaJcJaljDxU/hFPkWXc8=;
 b=X8hz9XRNXqxOkRlpfDdY77Q8gUyv8bPSukJEAw/3MXbPtCIx54OTPuQLGiTe1qWTD4t8N3ei7VRapwr3pExymek/bE7ZoXgK++aFXeW3Z7KeQZY+UqqbkJ/Av6qipx5kFwFp7wXPnuEn//i+EyvVtvO/oytEms4VxMimOaiRoP9fD7pmP5VMf+ti1jzfqDj/e7j33h5qUjV2/HfXexVotITMVdyzRqY2NhwkheQ+1RbelGz1D+t8rwAzdieIkwDwnJyK7mVv/FY1xNYRyJmumX62PyOYVZUVEOJHWyjPG1dJbWdBVjomcEBkhABvX+IeqB/USMXq4jku+9qykwbZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Sat, 20 Jan
 2024 00:35:11 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7202.024; Sat, 20 Jan 2024
 00:35:10 +0000
Message-ID: <8511e5c6-eddb-4deb-932e-125e34cddba6@intel.com>
Date: Fri, 19 Jan 2024 16:35:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/3] x86/mm: Move is_vsyscall_vaddr() into
 mm_internal.h
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, <x86@kernel.org>, <bpf@vger.kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, xingwei lee <xrivendell7@gmail.com>, "Jann
 Horn" <jannh@google.com>, <houtao1@huawei.com>
References: <20240119073019.1528573-1-houtao@huaweicloud.com>
 <20240119073019.1528573-2-houtao@huaweicloud.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240119073019.1528573-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6df397-93e4-4747-8d78-08dc194fa8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zM+6HT5PwKE3YU92iur3O2JChfCatbHOII7ZzIrIolBGl0vn+4iLP3NJZQJx4VGBHJYoYvP93JlYuQlqvsy6JI/JhTfCDuL7PyFE7RWBPcqzmvzBa/3ZY5bn7ULjHnENd9hBochBjd+druT/47mJb956NXE4OfRfQTrj9Rzf/yOyNVRmX4xKRaBVHHf9TQRF9GFLhUs8EJuWqDoZACvgnKH8r3tVakfPhqY0IDm6EzYAfzLIlSIXkytxLyBRQ1/6ZvIad+BtqpaEBjtcs8/51tH2czw3CmdlGdL0Yqluw82RCRSWON6HaTwL1Hgyf7a7ZG084ZaHsQKBQ3fk9tKqxzNgHzU4Bgo4kSTmJWqNJ1BFULkO80ge7kmpZ5mPtY1eOI/ZPaWGWmxgDtPBNNzRg2rtiZOmWGuAGip+rd6q9fuGBHuExMa1pRP1QZhvXKv9yp3zg6niex/+EOazNGLom3h+EWDEVjNpFR2TZDRjDbSOh+BPj20/FTwKtcq6rxdLJUDu/Dm/FT/vi7vPCZQD3lne+MQ2zeUxO4arWF6EwBTddENFZH0Xn+ocj7egdsNjMAnaIV70K+IauM4uNGK5LDhKLqjq9hPvh2DluOXWnnrT9ALaTTrcpNPr0NpkfuAiZxX5F+TKFpjqFDjhbzw+Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(6506007)(2616005)(26005)(53546011)(5660300002)(7416002)(41300700001)(4744005)(44832011)(2906002)(6486002)(478600001)(83380400001)(54906003)(66946007)(66476007)(66556008)(316002)(4326008)(8936002)(8676002)(82960400001)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEhiU21QWW10MHViM2Q2cEg3Uzh6d1UxNlBGVEVHdUsyaEdGNWc5Yitoci9U?=
 =?utf-8?B?M1RJSGlIVzNsTTNUQnpTRWJqYTJYMVdoQXZEMGVFMm9tSkE4N2JVcjljQlli?=
 =?utf-8?B?K3VhcVZCaFd2UVcyR0ViY0N6b2NwNGQ5Sm1zVVlybm1FVGxpZVJza2I3RTJp?=
 =?utf-8?B?dXlQM1NhalprMExVQW1pUGFYMmk1V1VuVmFoQzBzVzlTeTR2anFvTEZqZnJX?=
 =?utf-8?B?QzUrSkxONDBqU3NxUnZDb0FHUThNbDEwNHFNalVqTlMxQ0tBa0NxL0xlL0No?=
 =?utf-8?B?d2Z0SjVRalNuRHVpU05seUFNYjhyQ3FZdHBBdzdlUEl4ak92SWN5K1pPaVdD?=
 =?utf-8?B?UFBLZzJab3pPWGdPaHhGZlI5U0pjM01TRHRIcVhpTDBzYUU1RDlrQUJyZjZj?=
 =?utf-8?B?T1pFZ0J3VDlLTERmMVY2bDFvTEJ3K1k4K1JNMG9vMERNc2REZVN0K1hldWxS?=
 =?utf-8?B?R1RqaytwN0RXaVFWOU5yQTNzOFMrMnM0ZnEza3cyMDJ5S1JkREF2My9hZFF4?=
 =?utf-8?B?UDUxdlo1dHdlNWViWGlaK0dWbk5CSnlwZk1OMlhNVklIcHNRUmpNeWx1Y0ZM?=
 =?utf-8?B?d0N0TzhtMXZEbENVblM1MHBRVmIraTh3NW9uSU5wS1QweHozYkdZYktBZ1pD?=
 =?utf-8?B?SGdTTTZqbnNBL0k2dUo1b1BQajlldkw2NE9RaFp5WG5LYTBBWEdFdlplayt5?=
 =?utf-8?B?TllRalRqQTY1dG5vS0VpTVpSRUJJU0xSY2Q0VUJrMnlZN09hZlpHcjFZaTk2?=
 =?utf-8?B?NitzY054bVppRTNaNzJjQkhBL3p5K3BHMWpTaG9jZGV6V1h3d0tXdWtSUUt1?=
 =?utf-8?B?UStBd0xiRDY4aE5iZFpBckgvTTI4RnpMc3Q5U0Eyb1QxaXJRRkhlZFZJRzcw?=
 =?utf-8?B?dVE3WmpaZGlLYlAyMTFmSG5nQng4MlNWOElzY3hldTJ1NHJ1NXhYOWMrNitP?=
 =?utf-8?B?Y0NWVWVFT1VOZ2xzZWROYStpU1ZJTGwzZjZuV2IzVjFCeU9TOEMzN0thUy9l?=
 =?utf-8?B?QkhUREpVNEx1UnpEbzZkeFB1MnlPS1FvMnJFRkFLL1VrV2xZZ2JCU0NFR3Jz?=
 =?utf-8?B?V1R6ZllubmdNdlIvMHYrV2MwVFNKOTdwOFN3MldlRzdrMlZ3R3kwdHMrL3BD?=
 =?utf-8?B?a21CZjBHMTdHc3JEZXFKY0tBYlhpcWNVMHJZdWRUU284NSszWVl2V0c1bUty?=
 =?utf-8?B?c1ZSdUE0RWlscG9nUWdSbmdUQkdYaHZoWHJCV2piNWZ4a1FXdlNXN0xrQ2RR?=
 =?utf-8?B?OFVjSFh5NVI3S1ZZYWRQcVJVWldla0J0VGZPWVRwMURjNDU1YmNKY3hhWTdt?=
 =?utf-8?B?RDNhSXBKaXYwY3AxZVZWQmRxTm80TGIxWXRwbStGUkVpNkdrRjdMcjVTWlZE?=
 =?utf-8?B?TWczUU1zQVl1eXBjYVRLR1hRak1vWnhPVm9NYWt5bHUvL0VPQkJzYmQ2MjZs?=
 =?utf-8?B?RVMzVDlnOTJJb01HZ09kRjFrU2N0aGhUTEFRS0JPUEsyVHNUdnJwOFpnYURq?=
 =?utf-8?B?YjFvZTFpZnNGWE1JU1k5V3dCc0NZRS9hV3dqR25sak16Z2J3Vk9yMkJUMlNV?=
 =?utf-8?B?eWlKMm0xWE54VElLcnpuNDhmMW54RVhnOHFqazVKOCtGK0ZTYVJpVnFKM050?=
 =?utf-8?B?OGQ2c0tWekpkWjMvNnhlZER1dm03RW1kNEVKNHNGbVUwalhDY3FZSFpKLzhp?=
 =?utf-8?B?SmFFMEFHU2owYkZQSHZMTDNmS2NtTWN5bFlhLzFKSzZxOUNudnFIOVdUZ1NK?=
 =?utf-8?B?Tm5sV1g1Y0pEb1NDRzF1KzF1QnlJcTF3Rml3WXBNWDRNVElJdTVoSndXaDFT?=
 =?utf-8?B?d0ZBS1pTMGtMdVorQkZEeGc3QklNVzgvZjl1cWJ3ZGZVU1YvQmJNdnJOVWNF?=
 =?utf-8?B?WEM3NTVFQWo2T0MvUStqM2h2aEcyRFZaNTlLN1dXaUJMMFp5Ni9hWTFyMGZQ?=
 =?utf-8?B?emtRL2VyZjYzWHJHZVBOWmZhODlEYWM0VFpiNVBJL1pTRzhhVFQwZ3dlNFdC?=
 =?utf-8?B?WjRtMEgvSG93aTlRUE5HT1NDSHpjTmdySWIyVnFDeGxQYlhHcXZ5VWovbEVw?=
 =?utf-8?B?M1l4Y0doNzdYZS9oSkJvQk1aQnJESlhDYkpLSFNGR1B3enFSQVVsVkR0UlFt?=
 =?utf-8?Q?n7+EXDIoVIa6Qvyynx8/kCSTA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6df397-93e4-4747-8d78-08dc194fa8a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 00:35:10.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTNwUhEEg4bAtS9h7gaEyUWVwG6UMS6UFBUmpJFjZH4iAdUC9ZMvvltkDMEBCsj5S4wTNWnzc3JOYTTUjtoL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com

On 1/18/2024 11:30 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Moving is_vsyscall_vaddr() into mm_internal.h to make it available for
> copy_from_kernel_nofault_allowed() in arch/x86/mm/maccess.c.
> 

Instead of mm_internal.h would a better place for is_vsyscall_vaddr() be
arch/x86/include/asm/vsyscall.h?

Sohil

