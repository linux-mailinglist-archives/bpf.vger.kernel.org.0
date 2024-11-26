Return-Path: <bpf+bounces-45644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11669D9E15
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67173164D05
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A861DE8AC;
	Tue, 26 Nov 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp2Mctzh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155E1ABED8;
	Tue, 26 Nov 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650285; cv=fail; b=Lm1IZbVsfAxVnBR8lV+zjNyPZurpZg2kvEUEnOSxvEY0LkVUtzPGJPHvsFOQBuhuGLJxymYltqa86EEA9kG0ZOqFFveAE9fAkg/p3+/YnvaZJ3Y4r3qZ4XAlxbmRpamwIrBciSGFvpDkO7aUkAcbITeYbCSrDuvFqJRFhRWDcuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650285; c=relaxed/simple;
	bh=szX5UsEr7FTWr+OVE7Ddb7FF68nBlXTsGwPU4u6F+SU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YSZ3fHeadhWMWJi1EMmFQWdSW2z5lDoXfE2GDrxltA4ZcW0IarQmNMBdXiuA3bc1JiA7XTA63fGDFKiYeTSV0CWlcB95mqxnvDu9htL4z056s0ls90azKofeH47ahO/KVrbN0yydgFanY0M5jnssD2YanJ//7gfnozlvHf27q0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp2Mctzh; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732650283; x=1764186283;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=szX5UsEr7FTWr+OVE7Ddb7FF68nBlXTsGwPU4u6F+SU=;
  b=cp2Mctzhba/zBksAIZnLqWk9i4d1Qmi0dBjxjRqc76ZIwjcTm8gGDcMf
   kZjpp1YSuwJYCkp26slLUh9dkzoohWrElTvXmBmc8CHp3Mlw6CjJ4K/Zj
   s0bdAp8oOecFk+DboxdThSDXXnXdgLsrFY8CiLS0xP5ykhnIVEJt4XApV
   oVxAwCOAdIEcPFg0VrfGKmbsArU8vwdu0fgEKetxCqiD/tNujF+R5/dpn
   DdIUF++sf2UmzOwFiGDfWMNdrf0Zz+70Sut/1WptW5giNWSs9B1VUh2vi
   ZQBRrXWJ71FuapUKTCWgYI2hvdqaaFH0cmfgN4rsUUB/lu2in9Ja2RNGH
   g==;
X-CSE-ConnectionGUID: nM/gyF7oRFmHaIPgArZ0Mw==
X-CSE-MsgGUID: SRphEIRkSFmkcdLMIwhkJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="43448081"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="43448081"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 11:44:42 -0800
X-CSE-ConnectionGUID: EnBuaxI1Qbi8UdBcLHzmdA==
X-CSE-MsgGUID: RxiGR3YiQ2qAIXhR2HyXyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="92129823"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 11:44:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 11:44:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 11:44:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 11:44:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA1CS5G1rTKswDFfLskjp7xUOH6ATeqi1XfbSyNknvHOG/N6c4d6MiQtrPm/1BNJYjJy9z614joo17mOSdwmng2+6VgXMfkn1Udt2Xjx1reOOEovGMYaOkTH/gCJZ9xsRyGOTym2lxvVfUfGY8mah8X2rA/TXP6J4vq1iBuA0ydihkhWMEAdCwIgq183Qdq2oBBs7WbTMSZgmW7daexUbxFnuBusw1CsPUu9MjC3XAf51P375e22sQZGrOiBGx2/jctnVK6bH/gFkpjB6oMwIYXjXBIBxS7FxYvh3GfLPIYvzxJIW/ZKh6O7eeCdwGiCkCtWebYx9pXl9nf2B3naDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD+cnfBvcjCQ7uFkYLMktPcmo5FXSS3w7GXGjsgEqPc=;
 b=kIj4w1KCMjP/d3RVuAxH36aTnorxJxkUQig1ZxqpFMsnanB8GIrYLtmkm4Og6+CnMfZWia+VZJZfVgeaOdEzABMH0zhn5pGftcrBS9aa5KALrY6BxdUJoCSEeLts2CiYCeIb++NkO6DaJV9btIDVb3mTNJZQKRqRMUUHJNd9eWkOP/7FInFJ/fDDUzD/hUBluVrTAF3f/LhH2YKEdnibwAgBodedI4CQgVVVar+4rhlNkGgEwW/CAk53QOvZh62mGZVt1w+RDqahGFUnJT3sXMsEaT+7tYevmP+k+aY5FR5OqktkDVrzkYYA5G4dtP8VB9wVk+EjklfLLhb/ygHaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7446.namprd11.prod.outlook.com (2603:10b6:510:26d::5)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 19:44:38 +0000
Received: from PH0PR11MB7446.namprd11.prod.outlook.com
 ([fe80::ee69:297e:231d:4d3a]) by PH0PR11MB7446.namprd11.prod.outlook.com
 ([fe80::ee69:297e:231d:4d3a%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 19:44:38 +0000
Date: Tue, 26 Nov 2024 13:39:36 -0600
From: "Olson, Matthew" <matthew.olson@intel.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] libbpf: Improve debug message when the base
 BTF cannot be found
Message-ID: <Z0Yj-CrmRQEildgb@bolson-desk>
References: <Zz-uG3hligqOqAMe@bolson-desk>
 <Zz_YBK3SWnZnze-n@bolson-desk>
 <CAEf4BzZtD2Dge4EV+ehKLk+-DVRNxTc4YfuJ+W5ytTVwgwFHjw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZtD2Dge4EV+ehKLk+-DVRNxTc4YfuJ+W5ytTVwgwFHjw@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::7) To PH0PR11MB7446.namprd11.prod.outlook.com
 (2603:10b6:510:26d::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7446:EE_|PH0PR11MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc14ed9-71c6-4823-06e2-08dd0e52c2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0tBZ0VubktMd0VoUW1FUzdJRlBIViszQVk2QitpL0E1dlB2NlBMVkl3YTBz?=
 =?utf-8?B?cTJibUEvZEtBbjMrNnpOc2l6cEdsVEcxaXppYzBRSkdBVnZjUXVocXpDUmlO?=
 =?utf-8?B?Sks1MjlLTWlUNXNLUGFCUlpkQmZ2UldIVzRxL0xvdGRmbXZIM1FIYlNKcGtE?=
 =?utf-8?B?aXA1c09WdXp1UGl6azZuSk5JaGZ1amR0ZkkxUGhwZWJ6WUlVdFF1eXllblVU?=
 =?utf-8?B?OGd0WW9tSkdobXlvWHp1czIyL1IzUysrQmVIeGJ1d28yM294N1FsYm1yVkNq?=
 =?utf-8?B?WnRiR1N6MTRCcFBHVk54NmZ0dG1mcU94ZkUrSVczR2lUR0RobjFVbU1WaGEv?=
 =?utf-8?B?TEIxaU4yWnpIUURMTkc4R0JqY04zRXRJOEYyTGIyZGlHaFdWTEZ5SEQvUytH?=
 =?utf-8?B?WURmbEc3RHpadUNyNmRyMmZhSnl5RnRoTkY1Ny9WcXkzS01NcWo4UHBWRlRR?=
 =?utf-8?B?MlBZQVN3U21LWVp5aDRKcStQRzRKbWZGaW0wYWFDem9FNnVlbEtXaXRCeXI4?=
 =?utf-8?B?TFNIb3ViTHdqVVVsbEwrNG5wVFU0NG85Sm5aM2tJQnZ5Y3dheFVFakEyby9M?=
 =?utf-8?B?c1kxZjZwVjRnSVlyOW9qTm8vajJCa1doTFVSOEpBTXRmOUt1OC9qdENKQUpG?=
 =?utf-8?B?blR3N2hzbXRrR2kxM01XTHpiaUk5bDBheFhVcjlyaStYdmxvWjFCa3hZYm5P?=
 =?utf-8?B?M3RCYWIxTzFVM0NsaGdhak51QXFSQXozR0loTHFMblBMenBRWWtkVzFBVzB5?=
 =?utf-8?B?MnE2RWRNRW1aMDNKRGJ3MDNPdkI2VmwyajFudlgwRTFaVHZYUUI0Uy85K2JS?=
 =?utf-8?B?eXNKVlN0SVNWekZDaGFRKzJyWGNZc3BlbEYwbXRCcTRPS3ozaEwwVXV5TEZr?=
 =?utf-8?B?S05UWnpaRERNSGNBWHdlTzJOWTdIczI0Z0lIdnc1UGZIUGtQbTlrdVNwbnBN?=
 =?utf-8?B?dGtnV1pMOW83U0pQTXUwU2FPYmZGd3ExTFFqNG90NU81UTdwdDVPL2xRa1Zp?=
 =?utf-8?B?d2psWFhVMVZPQmZwWXZQOWFEUWRoZ2w1Y2tLbC95V1BoN2JnSWE0emlQOVBq?=
 =?utf-8?B?eklZdndUcnlZb1hyaVdKTkNETThCUm1Dand6VXRLM1lOby9ad1I4bkQzeEty?=
 =?utf-8?B?dzJjb25oaUpnY2prRlBSdm5qZGErUVFBSGp5K2JhSENOWThTUktvNS9uT2lK?=
 =?utf-8?B?YmkyaGJ2OHFZZi9rbTF0ZDMxL3FvbWRaS0xyWUFZSzh3dkdEMkJFek5jTHdT?=
 =?utf-8?B?bzQvcHVldGZIMlhoVlVaWkluKzlSRmhULzlpMzRDS3pnMEFXakhZNlZKNzMx?=
 =?utf-8?B?b1BRdjZJUjhiY0hZMVdxdkc1WFFBWUk3UnluWmk0K0IwOWFHVjdCUnlrYkZt?=
 =?utf-8?B?cHFTNDFxeWNZaWErM3dZWUk3a1R5VmxhWEtyZWtzbm96NHhxbXdFWWFYYWpY?=
 =?utf-8?B?L0F6V1VZSHB1YjlOUUt2ckMydHNRRUJtQ05TcGF4N3k2WEZPcFNlU3pvSUhr?=
 =?utf-8?B?RTRJUmVIVnpOU2ZEQnVTcDJiaUUvSjREL0pzQlRGNFhBaUVqZS82dTlra3V0?=
 =?utf-8?B?VjdxelY5VVV1RDhCTm1yd3ZxQlJjZ2wyU0NWUnoweDd1TXc1STRmbnd4OEcz?=
 =?utf-8?B?czRrT2hYM3NnRmI0aVRNYzNWZW5oam01aGhTTzNmOUk0RDZpTWdnalVMNmxJ?=
 =?utf-8?B?TncrLzlBSTQ3MUhjSC9LVCtWY2tSR2VINCtEV3lvN1VYQmE5TUlnM2crM2Rt?=
 =?utf-8?B?bEJSR3VvWVNEYnpGcHB2SW52aVloL21mYnBxcERDQ1NpYUppTUZneEJLS05C?=
 =?utf-8?B?aWIyOUdCWHBMYXRrYjM4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7446.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE4wcFZNYVNySVVReFRtUW9FUEZQaEVJcE40S1lna2xwREhiTnNEM3FhTUQ4?=
 =?utf-8?B?VVlLb0pWVHVkWlAyM1gzMHBRak9LTk9SczRmZUF6OFo0ZUJjWVV1eWpHMEVs?=
 =?utf-8?B?THU3QjQ3US9YZ3pDcGJGcDZLZDRzTncxZTJURU5ZbWlvNG03eC9nNFFLVC9L?=
 =?utf-8?B?WjMvU0pyaXdNaXFnbWV2REVNQVAxV3pxVVFrQTEvUFprWVJIUHFmcTlpY2Zu?=
 =?utf-8?B?blRuTzFQZ1d1ZlJubWZHbW1hVU1GRVZIbWpDNmZkNTdDRnkrV2JzTnk3NTQ4?=
 =?utf-8?B?blhmUTVBVWw3b3JkeDhNRVUvTDhVQXdTdkRmRW9vQTFKV0VtL2VtTHJFZkZw?=
 =?utf-8?B?Z3ZiOUlWRzlUTDhwNG5qSDJVazl1Rmc3MHRBWC80c1Zid1YrM2tlREh3Ymxq?=
 =?utf-8?B?dnB2aVJWYUxVei8xMDQrK011VnEzbStpR2dMRDVqL3R0Z0hHUDl3QlhHcHdG?=
 =?utf-8?B?MUxIbnJoTzNTQS9sSFNLV2FMVzN6NEVmTklwT0hjeFFLQjJkb0ZpdjhlVVJj?=
 =?utf-8?B?bWNIQXB1blBLNDZvTUxjTmZPM3U3V21kV0FmTCtOS3djWVh3VHBpb3JNVml2?=
 =?utf-8?B?VTlYek9QZXRSMWpWNDNJQzdwV3lWUm45Tm81dmk1SWs3VmFPNkNSanN3blRh?=
 =?utf-8?B?alBQSEYyQkRzSTVMMUt6ZDIxNjVmWnlzVnlWYTYwS2dnRUFaWDVMQmpNbVR1?=
 =?utf-8?B?ZVNwam1CYmFOUWJZR3FBY01wbXM5OXZWeEZDQk5yWm1rRDNQRXQ3WjNjanBt?=
 =?utf-8?B?dUhmYWxzN2wxUUNmZzAzVEdaVVMwb1RzUms1UnlpMjBFSGx1dEl0YXkrWXh3?=
 =?utf-8?B?MURSd3NCZlJPVXdwZnVpWUR0VjZVQk1VTCt4VXcvSHBnSXdhbDdoWXd1bUkx?=
 =?utf-8?B?TUNvKzArRkFiT0hLclRrcDhwTHo5dVRaNWZCeGUrU1hMcEk4Z2g0ZElXVVFh?=
 =?utf-8?B?YzBjeXhLVFkrekZMZy9aeFdsNmYxV0hSbnJod1UzZzF6V1dkVHpQOWE0b0NP?=
 =?utf-8?B?Mm5EM1hTUkZQVFcvbytFWi9YRk5HQ092cjU1TXprWUphV0NRSS9FYVZsQU9v?=
 =?utf-8?B?TzM2dTdoa2s2NHNRanVSY2sxMWxUckdTdUk3bnlWTWl1SDVXUjYydVRUSVF5?=
 =?utf-8?B?VGpKck9JbThJd1dHSW9tdml2NTU1elNxcnNzRTNjK3MzQmxRT0NlZDZGVzht?=
 =?utf-8?B?NU53Y2pvNFBuWC8vK3ViQ2VsVDJidzlpVDVmTXd5NjhuWkRvaU9XRkEvTHhy?=
 =?utf-8?B?a0QrU1R2Uk5FcTd3Vm9vcFVlODVMbDBDaVlpcmUyeXM3SjAyZ0grb01oMEZV?=
 =?utf-8?B?cVQrVkJGc3ltakhIdjNMNXdxL1diYmVhS0NYNm1ETnREbFE2N2xsUm9BaWll?=
 =?utf-8?B?Z0hnZGsrMGhFS3B0MDRrSis0Ymxja3VtNWd3UXIra0N3Z0htUkZiWkFEMVIx?=
 =?utf-8?B?RGRyL1A3L2NSdndacGdjUmxlcng1SkFwQjYzRFQyTE5pR2NMSUNHbDJMaG9k?=
 =?utf-8?B?WnVCQ0NOS1ZMNTNhNDdnSTcxbWVTeW9DR0ZmamVWWEtuR25ONXZSRGpuczFT?=
 =?utf-8?B?UmZCcjF5SUhSNFFWYUlDK1JnMjdQL3RpU25pWjkyeFVTSXUyTGVBa3E4b0Vn?=
 =?utf-8?B?S2RTcUpJc3J5SGQ4andkVWtVazZHOW9WQ2RFcXRndTZXM2pma29VQlcyVEZV?=
 =?utf-8?B?bzJ3THlvSTJKTEh2Q24yWERjWUgyYWJUTzU4K2hzL3EvZ2lxNVB2ZDVwbThx?=
 =?utf-8?B?T2xKSzQxUG5JT1Y1UWVDTG5hY3pVSjRQZXBYN3VxU2ZYQ0JPdDRaQlRuV2My?=
 =?utf-8?B?d3pjS2RCcDM2YVlnU1lSUzlWejMyMVdGMXBiOE5ibkJmNW1NdVVMbG1qV3Z1?=
 =?utf-8?B?aFBoaDBnaGtjNkhOSjV2enBQMzVnNkhpTS96dHRIbUpaejlGTDhVWGVOSXk5?=
 =?utf-8?B?eXlyM280M1RESy9BaGlpTENud1pBUE1wdUFiRWsyOG1ncWYvV0ZyU3V2bFNN?=
 =?utf-8?B?ZENJZlZDWDNjV1R2OHhWNy9SREdTbnJKbVBMbEdScGhPT1FiWnNOeXVSNEZ0?=
 =?utf-8?B?QnIySkxnV2prYThRRmh4SjFLOWpUQlloUUxBRWI4RUNwK2gra29SZXFOc01Y?=
 =?utf-8?B?UGZpSFV2MWYxZTZpOFBMc0VOT2p4a2xoeXY5Q3hyaE5pUGxwejIxU2wwMTEy?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc14ed9-71c6-4823-06e2-08dd0e52c2db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7446.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 19:44:37.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSqEfFx8yL3u2jS3/gKB7JNlz1Tf2q29lRfNrZGnqMZIE/Bmvihz8nU6v8KNZxujPEGM54uWbs+PHZ7Sz6WGpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com

On Tue, Nov 26, 2024 at 11:21:21AM -0800, Andrii Nakryiko wrote:
> On Thu, Nov 21, 2024 at 5:07 PM Olson, Matthew <matthew.olson@intel.com> wrote:
> >
> > From 22ed11ee2153fc921987eac7de24f564da9f9230 Mon Sep 17 00:00:00 2001
> > From: Ben Olson <matthew.olson@intel.com>
> > Date: Thu, 21 Nov 2024 11:26:35 -0600
> > Subject: [PATCH v2 bpf-next] libbpf: Improve debug message when the base BTF
> >  cannot be found
> >
> > When running `bpftool` on a kernel module installed in `/lib/modules...`,
> > this error is encountered if the user does not specify `--base-btf` to
> > point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
> > However, looking at the debug output to determine the cause of the error
> > simply says `Invalid BTF string section`, which does not point to the
> > actual source of the error. This just improves that debug message to tell
> > users what happened.
> >
> > Signed-off-by: Ben Olson <matthew.olson@intel.com>
> > ---
> >
> > Changed in v2:
> >   * Made error message better reflect the condition
> >
> >  tools/lib/bpf/btf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 12468ae0d573..a4ae2df68b91 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -283,7 +283,7 @@ static int btf_parse_str_sec(struct btf *btf)
> >      return -EINVAL;
> >    }
> >    if (!btf->base_btf && start[0]) {
> > -    pr_debug("Invalid BTF string section\n");
> > +    pr_debug("Malformed BTF string section, did you forget to provide base BTF?\n");
> 
> I'm not sure why, but this v2 didn't make it into patchworks, so I
> can't apply it. Can you please resend?

Sure thing. Thanks.

> 
> Also please make sure you don't change indentation (tabs -> spaces),
> because it looks like that's what happened here.

Ach, rookie mistake. I'll add clang-format to my git hooks.

> 
> >      return -EINVAL;
> >    }
> >    return 0;
> > --
> > 2.47.0

