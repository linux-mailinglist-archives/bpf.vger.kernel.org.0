Return-Path: <bpf+bounces-20058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DAB837C4A
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 02:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F84829691C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 01:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654F145337;
	Tue, 23 Jan 2024 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2VrkRWg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55A23C6;
	Tue, 23 Jan 2024 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969572; cv=fail; b=iQO4Tgf7pacJbq02/tfw7FMrzeEJgFZXFUFU2AI9Wr7tms2+jB3CuBMR6xuNj6kAObCbNGZmn75PJ4LKa4zjFgmhLV1xXEODW9Lh/xhtM1TOa1Oi4HVrOsaEFWSBSqW/512eG+o1ehFF4ctAMAgb0zrvYtQlt6nvsZjaiamdQYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969572; c=relaxed/simple;
	bh=GxDYPEwrS3j+tetyaplKZ8WojOz588hC2Vt3VjE5Voo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AWgn6BxueLdYsF1JdqNjvL9LAhafBWKbSGT0ikc3BBBCfp+/L3hG2PJTnUI3QdxYAmqPu74vuU5iN2hyg1XJd43eCILl8NRojIF6k5J0R5VBVxDDQHujDnOmcP/c7WkmtIHlEHcpRnmXI8Nq1cuNcztUpkCkwbl3dstwomcZnzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2VrkRWg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705969571; x=1737505571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GxDYPEwrS3j+tetyaplKZ8WojOz588hC2Vt3VjE5Voo=;
  b=Y2VrkRWg1RmUOlpB2Aoi2iz6Pc+qmMqdib43YgGTv4GmGApbWdKj4d9J
   fO31CyS/Lvyb3NVYbVDrKhpL4pEzrmTsNInmuOpl5H52d5n3vig4BDLG1
   nYQxXuIvgvZZSVcsloULs38Tems/B3UBI8EPBJBMXdGLfuuoG9YAtirbG
   4sAr/LiRNVj4kokvy39/Me4t+7Xhv/ktGFA1LBEEu/TEXREf5mhPc2imh
   o8OiOgV1eZ01Qjwm+D6Y+OGl152NoNeVQvYOGAJCg3o2deG9Y+l/ZXBV1
   HXbGMUnkkQtlpxp2AC2NJ7jmPVD5Vcs3ywOOdzD4IOi6SR/XM+TYaqFFI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8764707"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="8764707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 16:26:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="819897875"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="819897875"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 16:26:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 16:26:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 16:26:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 16:26:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 16:26:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQMggIE03sj2xb4sgn/ShF/qDWGtoqCuefCynRBMYFx6/rtk4exAwrf53R4joW+/79LYPPUxqIlmpHMmy1DIZOdwtsI/m1uA/GU+X6jxP3/xp9dfWoT4SEM6tq+Iz+5hJ6/AY1csloKJ5yIUzL9kasId/mB8MSECExVSnzR5N8FPmLWo0MBenFpu980PP85A5rfSr6RzCHyk8kcO0vGw31/N17CKBWZWWNVS7ieTuSS1QGTmfuo2ZxCJiLc+ecFOQ7cejzU4YAukJGzQGZ4wBpZVRKEAFdBagGX8XrlpTxekzeL0xt7vYBK76GUb3coG5FEiCqrtMJ2xtRJBjsBETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNtedI4H7v0GJj5Wz0+arXyM4kbipd4b0DcBEs1eoUM=;
 b=cZFbbGLF0vS0n8RJVUHopMXNdYYqK2HcSXSqFtFyP3JgRn+b97aklVySjLdIlZjKY8gOETuBJXc0MAB3ClOMXdO/kKGAvqzvhnz8JINCNQHrXroNl4vPcmfW7CE3MUuQFW9cg+WD9r+hLcTXGqgcMjlHMii1WQZRM1imSDmG2Wpmw0uKWhoiJtVFN0yt/MfPNhSk0H3hTuMA0koMeNF9tx/qgE93IUDe86+vGVGh6LbPXK3fl2Jc6f97cicvvUOeZW/nipxMULgrapcO8eJZ30NzQ0B4qiYZ2+Rlhm6Sq7ev/eFZ4AkvbqNoPc2F2We7oCC+qi8pnjbYY6fXDQ1c0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 00:26:00 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 00:26:00 +0000
Message-ID: <1c260ab1-d4c0-48e6-bf2b-df69bf083d27@intel.com>
Date: Mon, 22 Jan 2024 16:25:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 3/3] selftest/bpf: Test the read of vsyscall page
 under x86-64
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, <x86@kernel.org>, <bpf@vger.kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, xingwei lee <xrivendell7@gmail.com>, "Jann
 Horn" <jannh@google.com>, <houtao1@huawei.com>
References: <20240119073019.1528573-1-houtao@huaweicloud.com>
 <20240119073019.1528573-4-houtao@huaweicloud.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240119073019.1528573-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA3PR11MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: dde707eb-2979-41fd-53f2-08dc1ba9dfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kzTmZ7sJzmoGBBOmrJEnfhPibfTdz/YaGwU0UaHacSxJT+H8mZBA72v+2qVrbaEH7Vo7C2NAHCAEWClcwFGFrZ6T4Yjb7oh8/QyqAyJz6BSnXuCBbomPwkiEjaVWM20fOSKRZej8ax9OqiBYOFQQiMNMOTS9YAXyUC4V3oM8j2jxRWmntoVq7da0y37IrDn6qjdwcTv1dWGwN9WdGzDsWSiOAjsTEj4LCewS6BuxCqzBqLAFT0jgafOHuomiqyHFUSSb4yGtnfCPfvBHZHG4zNuZ6BxlGHIFQpu3/eYoALfy+lp7IWg6rq2P2NXOC42s8eqivKkkNsRpMWLv9WvXo4xgf3+7cQrwEM9WMH1jPFuaXkyPY8CN/WxrGv0dTgo4/uscp9hUmnrHWaOvsouV8XMDmOBNZNlul0mzjKWqnyNkU1/NZDJqJ8Kd6xs3lr1yOzFsw89dFBDPlKm6oiDOsiJubdTDC/RV4u60C7psRhVcua8apVxTbj2N24/tx2ing7FEdKHPxuKJBmM/WRLOskcNNrcZ74xrEjz+AHjaRP9AGyze5gXFOJmd4SJMWo3oqOUD4pQICYnZ8XYV33c5UxJ0rk5YPSgxIcJkw7F0/0tMN1fdFUR3niQ8lutHihPD6Qk2VeICHRP60EcrwihYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4744005)(31696002)(41300700001)(36756003)(86362001)(82960400001)(83380400001)(38100700002)(8676002)(478600001)(6506007)(4326008)(6512007)(316002)(54906003)(66946007)(7416002)(66476007)(26005)(6486002)(66556008)(2906002)(8936002)(53546011)(44832011)(5660300002)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVJhRzBIY1FjYTl6d2taZGpITUdaOVBlcmZ5cnVJRXplMTcwZnp6YUVRclo1?=
 =?utf-8?B?SmFEWVZ4QVRnb1I0RVRQU3RucURqdkNTakNwTHpnQ0Z6WnRCcDFsMytpdWpI?=
 =?utf-8?B?ZEg2bUdnNmRiQ0NTdTFtdTBjS2JBbE5MQ2pjdmJTNzR1Wnc4eVc1TEE0Qytm?=
 =?utf-8?B?b3NPaWdjRmZXK2lYQ002MTNCY0tMdUFWT2FWNmxKdDk4cHVJWVIvc1NWU0Jp?=
 =?utf-8?B?WTcvZ05ua2xZZEVNaWxEaVY5RWpoREFYeWMxRVM4aDdTRnlLbFZQSCtURFlx?=
 =?utf-8?B?VVExTTIreEMxK3ZkTXJPNWd1c25ybWhmVGZXd1RtMTcwWGFLSnNqMnFmcVhM?=
 =?utf-8?B?d2RibHZzRHFaQmlFSXpCb1RUaThrUTZJaE9qV1lURjEySUcrZUZEd0lYMFVL?=
 =?utf-8?B?VmxIbzgzS3hkUkhsdjBjbWZ2OFFQMmVlZllFczVkYTlvcTNtSnZDY3RMd3lm?=
 =?utf-8?B?S3JFU0Fzdm1SUVU2WlZEWlR0TzM0alJlWG1NcW5jZ0RVbCtWaHlGSndWRjYr?=
 =?utf-8?B?RWVIZDRLY0pXbGtzR3MyUEpVYnU0ZUlKZkhsNEdxNEVGYzMxTnB0aTFlUStT?=
 =?utf-8?B?bkpZRS84b056eGRRcjl6aHdTN1RnaFgyTTd1K09hUGl5eGpxdVloU0xjZEJE?=
 =?utf-8?B?UmdGT0NSZjYwZWRZRi9wN2lYQTNZNHFpR0hqYXp5dHpHdGRET2N2RGtnYnk4?=
 =?utf-8?B?Q1NteFJHdU53MGFoQkUxS0s5Ym9kR2Z1SHV1UU5xa0VMY01yMTlRcHN4ckVQ?=
 =?utf-8?B?TVZlY00reDRSZ294SXFjMllMTGxKZVNwcmF1bEtTUnpVUjhGcDZBT3RvWnJu?=
 =?utf-8?B?OU1DUFJOL2sxbDBnY1AzWStsOVhzM2VFTUpNdGVVVGlBNmhaeHFQcFdLcmk3?=
 =?utf-8?B?emxQamx4ZGJnZ3ZDRnV4Yk5NK3hCR2hiMzF4N0RUWnlHa2UrSklLNmoyM3RV?=
 =?utf-8?B?UFhtb1ZYRTlJa2tWN2t3T2NXTTBlMXFUVFRHS2dIY1ViL2ZuTElWUTFrV3Zl?=
 =?utf-8?B?S1B2cTFFODR1MGNBVExNdENDT1M5RkFiZTJRREdFQXAxUjFHS1pTVXZUUDNI?=
 =?utf-8?B?MW43Mnc2WW93YVlMZXhnU0xLeU93SnArRUZJTWpDV0FHb1BsbmxGMGNkS1Fx?=
 =?utf-8?B?azBaYTl2QWhsNWVuRTVJSDk5U0U5eTBkWW4xcHl6Y0NJVkYxaVQ4TU9WRlZj?=
 =?utf-8?B?V2lIN2FlckxGYWVmTGNZV0YvVWJrVUJ4NXlGSkxZUEJnSnJ1Qm9MRXRqeitO?=
 =?utf-8?B?TVdmNjBQUGZBNms2L3IrSGltNTNDZFFsSGJKaTc2aEsvZTdPa1BxbHBEeEFy?=
 =?utf-8?B?ajI1Z09HVEpXLzlNNEJUVHVYdmlhZFlMcmJzTCtmYW53Z3hRN3VpbU5EZU9p?=
 =?utf-8?B?Y2VpSVlXYW8ydVNJdHR3UXMwVGM4cHZoY0JuZENSOHgzK0lJRFZsOElLRW5T?=
 =?utf-8?B?UjVUMlVsNnFPbkVnM0hoL01JNFAxc0dNOGJRN1VzYW1jOGRjWFJEeE9XZWo4?=
 =?utf-8?B?cyt3R1QvUHlMRmJ3Rmg0VGFwYmRXcmEvT3hhSDhoNXk3dldTditYclZ3UjNT?=
 =?utf-8?B?OElKdnUvLzl1dlUzOHJrSU1JUmJsRXVVMGNRajZxaVYrVU9kQ1JTR05ZOGla?=
 =?utf-8?B?a3AzVmwzYTdIQmZ2NVFKV3BZSHA1WE8rTTlFOTY1N2VpOG42N2RuQy9SbVNl?=
 =?utf-8?B?cFJjWEhFcWk5MDJHYnJEaGpiWUliR0MzeGg3NEVXMzc0Qjk0bzFQOVYveGpP?=
 =?utf-8?B?a1FXUzNqQVBFT1JOWEVvZWVXaE9kUnlZUnZ6NDNMNUtRVGZKVndlOTdDejJt?=
 =?utf-8?B?eGFDZ1lBa055cENGTHNjbFpDNTVQaEdCNmsxQU5xd0xEdmlJK1Z4RXNuc2FK?=
 =?utf-8?B?R3pFTXhqR2JybGxiNnlYK2ZOaXNUQUY1WVBzU1BmS0Z4RUpYZWJnbk8vRkFa?=
 =?utf-8?B?cnFOLzg4RkN0ajB2SEUrcTd2VUNJc2t2TDc1di8rWDF6bkNBdEJBbldhdW5o?=
 =?utf-8?B?VHd0NHA0S0ZsSGdlakp6dGNzcjFVcmN5cEdBTkRaaFY4eEhEOFdDeFZRS0lX?=
 =?utf-8?B?VTZqWGJnNEk1ZVZSL0d6QWR4K3JzdVlRdnhsTytTNmROeXhGZVpsdnBveVYv?=
 =?utf-8?Q?bHpOp9bX5aOrTj/c6FM8eXh6U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dde707eb-2979-41fd-53f2-08dc1ba9dfeb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 00:26:00.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLCpmlMWLcqHA7jjVZe6cQbZsJrVpeM0QOyVTQjmERPV3Qiibge7SBYqArRcEO8VC+eQq98U5MHbwb/adTl1Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
X-OriginatorOrg: intel.com

On 1/18/2024 11:30 PM, Hou Tao wrote:

> vsyscall page could be disabled by CONFIG_LEGACY_VSYSCALL_NONE or
> vsyscall=none boot cmd-line, but it doesn't affect the reproduce of the
> problem and the returned error codes.
> 

With vsyscall=emulate a direct read of the vsyscall address from
userspace is expected to go through. This is mode deprecated so maybe it
wouldn't matter much. Without the fix in patch 2/3, do you see the same
behavior with vsyscall=emulate set in the cmdline?

Sohil


