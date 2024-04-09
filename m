Return-Path: <bpf+bounces-26260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB5A89D4B9
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B55B281F48
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ACC4EB51;
	Tue,  9 Apr 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdYP2WGY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA31EA6E
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652118; cv=fail; b=bkm+swylDTvY5rwiZFBZabPkUaGHQxiLUCIgKgA10l9jJCldAcHVkD0OhK6EWhi+VXxE0m+bOgP2kxZzCqMqFqNEahZL5MccOG2XfXPZLrNtoj8GldeG1ewxk7pEoGKytlYKdk+/cX47SCZbBtEcO0OHHZjU2s12AXdSua8n+ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652118; c=relaxed/simple;
	bh=OI3++FeHq3JwoF6bWFuVYW2u6uRL+SxpCgC/ac6o0mg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FpLh6PvtUkdM8H7WXZM0krNdNs0jSqzolJuv3bEz8f7iBmP+AvZKNSRZXGPp31IvXOTRvveIgCPxthl6KUHiUuSqDVusjXYizmJgQATrV76vz3C6tRJe/UHiX1i1m6ecNUKrcCv32t64dkla7N8Fc2XHSonkLV06+N/Rz22AuEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdYP2WGY; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712652116; x=1744188116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OI3++FeHq3JwoF6bWFuVYW2u6uRL+SxpCgC/ac6o0mg=;
  b=AdYP2WGYsjKSTIL38PDeSFQCNuLA6+opNqrvvVsQ0y0lZfr4ZqkBZbPz
   L+hWKlzwVI6c9QsEV4hQ6cfUfxYNXQusTvJNMPqV09ylHRWxRl+hGUqIc
   zkvAbi/0S6DTQOuAcMSjvhuN73iMmwIvQcljaOjFcnzNBzHYO3ZUqeYFh
   xJvuBLnGBcpJmNE3/3mJxIBungxhOOwUKENVkjZgyBSpayXcwE01X/U1i
   L59syhyxrsn0khLuC25XvjXWMGyovjzlNr6++Mwp5OVvRpstTsMmnrVxK
   nTuTQwsDp3Yhhvl+WJwrN+UZFKMJYvGrLAr2V3J0LmxB3hBBkeaFdiPcy
   A==;
X-CSE-ConnectionGUID: 0A2/aQzDSum9U4Skl4Gvhg==
X-CSE-MsgGUID: HEJy0H0IQeOafTHdk++CbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="33362425"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="33362425"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 01:41:55 -0700
X-CSE-ConnectionGUID: 9rf6iA7JSomRpT1YgYGwLQ==
X-CSE-MsgGUID: 7e/4jTygRbyhi4LvyUde5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20190679"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 01:41:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 01:41:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 01:41:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 01:41:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 01:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9jQ5fqIW+viPg6DkYgXJO33g5XVou1KYwKkPntiNN/jQpxSk7dOMTckW6UExVVfSPk7pn3FzNPlQX2nx0813PJmXAXpLwZEP/ZXH2x1kxL2kcgX5RbB9rKXs0Oo4XOTBB7HM9GiZndYmXsWIIiqauhEoo/Gu2mc0zDnRJWT5dsEcJzy7cI8au/FtREmxPsrlPRpdlCCiu9HUeX4M3xwomvcSDq3dBq4AXRmG51c2ONJYA+RfiV6AdbbCMBUzQX/x5dUEgu1EhVOX3vInN26+VkPdsgveBUpy+zQupyUU3tEVRNj8k1KcXfGS2vx2ivqGjN1Sc0viyaD+frLVPp6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QrF6fOqBAtnUG2HFfrblPgxt7Qb0YYArHBjLUi7dwE=;
 b=kUs0GYY7e0CFZIPtNz/3vYjqgroeWZQQbv/fWrn9KiAVGI+Duu0IVJb85P7qsUc6dBGzDoxxHWhnJHxvNOBu0wGNM/rNy3zCNAK5K7jy1mT/pFb7KKwY1GDzplg5HZEAFpiMwbz2W9jmOLnoYmn3dC+9avp9ZwEO0KZvtuMOW8AV07ZCqgKmvFgNlBjOEbzJyM5aNzcxEAjtatexy/+dPhImq+nG+HfBt1gHaWbBrawRTaIV+zdvw5w4ydJ6IvCc3VaclQE2FXvhT7RvCT5y+lB35lDcaYDirLKvTK3clA3Fqg2HqB571BuFkBOll6OL+zY+BmKIJUZf0QeUNXgJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW4PR11MB6761.namprd11.prod.outlook.com (2603:10b6:303:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 9 Apr
 2024 08:41:51 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::3637:7937:fc13:5077]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::3637:7937:fc13:5077%7]) with mapi id 15.20.7409.039; Tue, 9 Apr 2024
 08:41:51 +0000
Date: Tue, 9 Apr 2024 16:37:11 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<martin.lau@kernel.org>, <kernel-team@meta.com>, Stanislav Fomichev
	<sdf@google.com>, <syzkaller-bugs@googlegroups.com>, <pengfei.xu@intel.com>
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: pass whole link instead of prog
 when triggering raw tracepoint
Message-ID: <ZhT+N7CHi47zDzjo@xpf.sh.intel.com>
References: <20240319233852.1977493-1-andrii@kernel.org>
 <20240319233852.1977493-3-andrii@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240319233852.1977493-3-andrii@kernel.org>
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW4PR11MB6761:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +i85JvCkQ0bltH/JokUFMcUK3XOE60lDUTknQMBqET832vITSG74o0iX0Xix9+iCxUyEE1UKD3L/ASKm3DsnSCzC/cHJ+X9AUlQ4JMrg4NaDLvORlviy4Qjh85SXtQyg+yvNcueNgWgkxIX9M5jc+ltlRyYC9bJKYAMqLfmKQ8LIpeWktvk+0nsbYRD/kJL8NvoXW8jLkedqAapfxBAQHHhUFW48A7MD1xBrJZVaVQ+qTa+QQahbfD+xl/V2DkjInv0yGR8p6hYOBGWmr8pMSd0e6KItBj01689UeKvdqyKM50Z/T0oKnsvXt7HCJ4RrQMbvLsZ8iLHkEWGE76k+Yw3tZXp2Sh2hzgLIvABxZhTbnxd0HUnYBc0CVrPPmyETBCgmp9lmtJwagG5TeuHKvxZAfPRUIMFntusfGFd2AQTYpNZMJZUfqa6VeX4uv8BLn/s8ju1ItFXaXdcO8P97PkQEsHTfYZRV5WA6HFGCoYjaxCRksTMfaZQgcoXpYTo16UKIfDGh4UuCSOC1j7Ya1ySFxBEepOjvIsvAIqSxx0r+ky0F+RojKnhuUsiVaBJDIgONUpIP8DWbbvVFsZxudEyX2X0bRWiwxyiAZkceX3oAhEzYpmMAEBhOyNjhMnDAWvQBXMvxkfgLNTsZPtCkJoeQs3lgGeDxyqRwOPL2Tko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lktxTMGFe9qlsvhjbhgUyrYZKmE71IsxCjBG+8P5y+g+yCyYC6VPJgHspUVc?=
 =?us-ascii?Q?MGL+qLv50/HPwmc1bSot3bgRkXmT8Rws7GFHFVRppnxD7PDuWVB5axSFqzc/?=
 =?us-ascii?Q?1Qr+6qCGM8At9BQfxUtokQg0zGNeiiPLus0cvSenUAncpo0tsrfUok3z1t1S?=
 =?us-ascii?Q?eByLkdsOCFz6HDyqfVAl/WTbPJjsAyTh4R2yhCUM073e7g1d71LhUUNGoDYV?=
 =?us-ascii?Q?LCHGQk1pCBkIRCm8RWNSusAyFsusE/tTmJU1gZ/xe5sCpCQia+V6+w9wK+tm?=
 =?us-ascii?Q?0/Ke4fB4WoiD4mRmuYi6rjX9Vz+kjVNmxEWooYtyOxYrAJIgLyva2TYG3W2j?=
 =?us-ascii?Q?pn/YWtryPqeDpUfBZ9QH43STrvDiJOKlL3ipCfgv93MbkH9nIjuWrEI4m6rf?=
 =?us-ascii?Q?5BdwrojCFksCaJi3hM47mTEcmm/QC5IQRhpkfSf92bdGnKdF64CVaxZX4J5r?=
 =?us-ascii?Q?98Qi2tHyTNi+PK5eA/GEEuSsPrXLhJJGKwbKSxfSVOkTSoV2PmcpaGrACZPC?=
 =?us-ascii?Q?RNcdk8TUelAfthsUPCQ2dfOIqXCar6K39Rut9QA7ceW8iL1Jg3Dqp/NWvd8p?=
 =?us-ascii?Q?W4+fmpeveW+yl36cIY7Bnx+bltc5YG4AHQS9N19t7RuDAMNBQfNgCVF+Z1Ek?=
 =?us-ascii?Q?9BlEl/WR2tR13Ug9Oojp2XqFHVTHzY2YAM2wGdTuRF82VhLskId3KeU5wZUy?=
 =?us-ascii?Q?eNRqkdFTMjNn3vQ7sTOJxjSoeWrhSiRC8TOvpzMqbGNmVVK0iNktpALxaP+m?=
 =?us-ascii?Q?WAKcZvhKeLPxsbww13TyonuET8P9z/lzQGBIr8KnnM7wy24SZcDx+LFG6Pnf?=
 =?us-ascii?Q?5/J5Sv6sc7ipuK/YkyyyBLrEFxJ1E+Jo3PtzeyoS4A3pjNdBSBmTCFSLMFSm?=
 =?us-ascii?Q?x1mYtzuemoBIGjuDNbIC8rW49JeBcwXTwK/+G9Jh/bGrP3Q4Hir1Tr4wH7/I?=
 =?us-ascii?Q?5LNY+ttTiaapzJqvk1tKV+7kbxHIREjeI0TMXaweu6poHbS3qyim3JOo6kBE?=
 =?us-ascii?Q?jErflCU6hcjdvBtQB0pIl2hopmkSuc4G5LjiCJyxXP/YOcwIWFiQEqsHGJF4?=
 =?us-ascii?Q?6ELm9c3qIEkQ2aQK5r5xbaEus0DTu3frGJn0fib7GCitAE9Y/umnl2brKhKC?=
 =?us-ascii?Q?NqDLZRAdYK/yOvo0tdzt2G1mSRTp6n4mgrY9nLDCz46TZ1PEydkCr4SWY2xR?=
 =?us-ascii?Q?48fOUh0Bb14vvyTKuVZc9CjX22mwJsIdINHTbJHE8IaFN3111N7PYjKc/9g+?=
 =?us-ascii?Q?nbOC5MtVNQXJnaiDmaU0IIuOnXpU7lgaB8q1XogZblXM8slCf3VFf7OBSCuM?=
 =?us-ascii?Q?V9Oeos/kohIQcLXj7z6H2NnCBwR2sYLKpZVi7dkJtlYulqkiS5GLdWiQOhbj?=
 =?us-ascii?Q?jx7KiwKphzzC2Ja1Wc0UUwDOJSDZfaIHZaD0g+l8qXGD7enghS/4GWll3xDK?=
 =?us-ascii?Q?+LZMOjYwl8U80LhuNdMEJ8Jz0zL0SwCGVvelrYqWNDbIFvaCNIiHh1v/4wsC?=
 =?us-ascii?Q?DM+JoD8f+NuxGh9yG/zlBUyJ7m66vjcWoV+6W8ZM5e0YUcZ1614GLFTrT1Ri?=
 =?us-ascii?Q?wm1bkqbMyytzHX2XJu4rFcqMfa4c1IvLVN0znQlm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 726b11b7-7930-4d6f-0f7b-08dc5870e6a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 08:41:51.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsiBSLvKrFqn6QAT773IDJ2fgRSrvdQE4UM9MJrQThKyEkVVoGYYAqBTmQiyMbwcMW1TMf7MkzXgZnkazyW3RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6761
X-OriginatorOrg: intel.com

Hi Andrii Nakryiko,

Greeting!

On 2024-03-19 at 16:38:49 -0700, Andrii Nakryiko wrote:
> Instead of passing prog as an argument to bpf_trace_runX() helpers, that
> are called from tracepoint triggering calls, store BPF link itself
> (struct bpf_raw_tp_link for raw tracepoints). This will allow to pass
> extra information like BPF cookie into raw tracepoint registration.
> 
> Instead of replacing `struct bpf_prog *prog = __data;` with
> corresponding `struct bpf_raw_tp_link *link = __data;` assignment in
> `__bpf_trace_##call` I just passed `__data` through into underlying
> bpf_trace_runX() call. This works well because we implicitly cast `void *`,
> and it also avoids naming clashes with arguments coming from
> tracepoint's "proto" list. We could have run into the same problem with
> "prog", we just happened to not have a tracepoint that has "prog" input
> argument. We are less lucky with "link", as there are tracepoints using
> "link" argument name already. So instead of trying to avoid naming
> conflicts, let's just remove intermediate local variable. It doesn't
> hurt readibility, it's either way a bit of a maze of calls and macros,
> that requires careful reading.
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h          |  5 +++++
>  include/linux/trace_events.h | 36 ++++++++++++++++++++----------------
>  include/trace/bpf_probe.h    |  3 +--
>  kernel/bpf/syscall.c         |  9 ++-------
>  kernel/trace/bpf_trace.c     | 18 ++++++++++--------
>  5 files changed, 38 insertions(+), 33 deletions(-)
> 

I used syzkaller and test intel internal kernel and found "KASAN:
slab-use-after-free Read in bpf_trace_run4" problem.

Bisected and found related commit:
d4dfc5700e86 bpf: pass whole link instead of prog when triggering raw tracepoint

Checked that the commit above is the same as this commit.

All detailed info:https://github.com/xupengfe/syzkaller_logs/tree/main/240409_092216_bpf_trace_run4
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240409_092216_bpf_trace_run4/repro.c
Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240409_092216_bpf_trace_run4/repro.prog
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240409_092216_bpf_trace_run4/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240409_092216_bpf_trace_run4/bisect_info.log
issue_bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240409_092216_bpf_trace_run4/bzImage_v6.9-rc2_next.tar.gz
issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240409_092216_bpf_trace_run4/5d8569db0cb982d3c630482c285578e98a75fc90_dmesg.log

"
[   24.977435] ==================================================================
[   24.978307] BUG: KASAN: slab-use-after-free in bpf_trace_run4+0x547/0x5e0
[   24.979138] Read of size 8 at addr ffff888015676218 by task rcu_preempt/16
[   24.979936] 
[   24.980152] CPU: 0 PID: 16 Comm: rcu_preempt Not tainted 6.9.0-rc2-5d8569db0cb9+ #1
[   24.981040] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   24.982352] Call Trace:
[   24.982672]  <TASK>
[   24.982952]  dump_stack_lvl+0xe9/0x150
[   24.983449]  print_report+0xd0/0x610
[   24.983904]  ? bpf_trace_run4+0x547/0x5e0
[   24.984393]  ? kasan_complete_mode_report_info+0x80/0x200
[   24.985039]  ? bpf_trace_run4+0x547/0x5e0
[   24.985528]  kasan_report+0x9f/0xe0
[   24.985961]  ? bpf_trace_run4+0x547/0x5e0
[   24.986457]  __asan_report_load8_noabort+0x18/0x20
[   24.987055]  bpf_trace_run4+0x547/0x5e0
[   24.987532]  ? __pfx_bpf_trace_run4+0x10/0x10
[   24.988061]  ? __this_cpu_preempt_check+0x20/0x30
[   24.988670]  ? lock_is_held_type+0xe5/0x140
[   24.989185]  ? set_next_entity+0x38c/0x630
[   24.989698]  ? put_prev_entity+0x50/0x1f0
[   24.990199]  __bpf_trace_sched_switch+0x14/0x20
[   24.990776]  __traceiter_sched_switch+0x7a/0xd0
[   24.991293]  __schedule+0xc6d/0x2840
[   24.991721]  ? __pfx___schedule+0x10/0x10
[   24.992170]  ? lock_release+0x3f6/0x790
[   24.992616]  ? __this_cpu_preempt_check+0x20/0x30
[   24.993140]  ? schedule+0x1f3/0x290
[   24.993536]  ? __pfx_lock_release+0x10/0x10
[   24.994003]  ? _raw_spin_unlock_irqrestore+0x39/0x70
[   24.994561]  ? schedule_timeout+0x559/0x940
[   24.995021]  ? __this_cpu_preempt_check+0x20/0x30
[   24.995548]  schedule+0xcf/0x290
[   24.995922]  schedule_timeout+0x55e/0x940
[   24.996369]  ? __pfx_schedule_timeout+0x10/0x10
[   24.996870]  ? prepare_to_swait_event+0xff/0x450
[   24.997401]  ? prepare_to_swait_event+0xc4/0x450
[   24.997916]  ? __this_cpu_preempt_check+0x20/0x30
[   24.998445]  ? __pfx_process_timeout+0x10/0x10
[   24.998971]  ? tcp_get_idx+0xd0/0x270
[   24.999408]  ? prepare_to_swait_event+0xff/0x450
[   24.999934]  rcu_gp_fqs_loop+0x661/0xa70
[   25.000399]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
[   25.000913]  ? __pfx_rcu_gp_init+0x10/0x10
[   25.001381]  rcu_gp_kthread+0x25e/0x360
[   25.001822]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   25.002324]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   25.002966]  ? __kthread_parkme+0x146/0x220
[   25.003472]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   25.003995]  kthread+0x354/0x470
[   25.004400]  ? __pfx_kthread+0x10/0x10
[   25.004862]  ret_from_fork+0x57/0x90
[   25.005315]  ? __pfx_kthread+0x10/0x10
[   25.005778]  ret_from_fork_asm+0x1a/0x30
[   25.006282]  </TASK>
[   25.006560] 
[   25.006773] Allocated by task 732:
[   25.007187]  kasan_save_stack+0x2a/0x50
[   25.007660]  kasan_save_track+0x18/0x40
[   25.008124]  kasan_save_alloc_info+0x3b/0x50
[   25.008649]  __kasan_kmalloc+0x86/0xa0
[   25.009107]  kmalloc_trace+0x1c5/0x3d0
[   25.009599]  bpf_raw_tp_link_attach+0x28e/0x5a0
[   25.010163]  __sys_bpf+0x452/0x5550
[   25.010599]  __x64_sys_bpf+0x7e/0xc0
[   25.011054]  do_syscall_64+0x73/0x150
[   25.011523]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   25.012156] 
[   25.012360] Freed by task 732:
[   25.012740]  kasan_save_stack+0x2a/0x50
[   25.013211]  kasan_save_track+0x18/0x40
[   25.013689]  kasan_save_free_info+0x3e/0x60
[   25.014198]  __kasan_slab_free+0x107/0x190
[   25.014694]  kfree+0xf3/0x320
[   25.015085]  bpf_raw_tp_link_dealloc+0x1e/0x30
[   25.015632]  bpf_link_free+0x145/0x1b0
[   25.016094]  bpf_link_put_direct+0x45/0x60
[   25.016593]  bpf_link_release+0x40/0x50
[   25.017064]  __fput+0x273/0xb70
[   25.017489]  ____fput+0x1e/0x30
[   25.017890]  task_work_run+0x1a3/0x2d0
[   25.018356]  do_exit+0xad3/0x31b0
[   25.018800]  do_group_exit+0xdf/0x2b0
[   25.019256]  __x64_sys_exit_group+0x47/0x50
[   25.019763]  do_syscall_64+0x73/0x150
[   25.020215]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   25.020830] 
[   25.021036] The buggy address belongs to the object at ffff888015676200
[   25.021036]  which belongs to the cache kmalloc-128 of size 128
[   25.022465] The buggy address is located 24 bytes inside of
[   25.022465]  freed 128-byte region [ffff888015676200, ffff888015676280)
[   25.023780] 
[   25.023970] The buggy address belongs to the physical page:
[   25.024563] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15676
[   25.025401] flags: 0xfffffe0000800(slab|node=0|zone=1|lastcpupid=0x3fffff)
[   25.026140] page_type: 0xffffffff()
[   25.026535] raw: 000fffffe0000800 ffff88800a0418c0 dead000000000122 0000000000000000
[   25.027363] raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
[   25.028182] page dumped because: kasan: bad access detected
[   25.028773] 
[   25.028957] Memory state around the buggy address:
[   25.029476]  ffff888015676100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.030244]  ffff888015676180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   25.031018] >ffff888015676200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.031780]                             ^
[   25.032221]  ffff888015676280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   25.032992]  ffff888015676300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.033769] ==================================================================
[   25.034571] Disabling lock debugging due to kernel taint
"

Could you take a look is it useful?

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!



> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 17843e66a1d3..2ea8ce59f582 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1607,6 +1607,11 @@ struct bpf_tracing_link {
>  	struct bpf_prog *tgt_prog;
>  };
>  
> +struct bpf_raw_tp_link {
> +	struct bpf_link link;
> +	struct bpf_raw_event_map *btp;
> +};
> +
>  struct bpf_link_primer {
>  	struct bpf_link *link;
>  	struct file *file;
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d68ff9b1247f..a7fc6fb6de3c 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -759,8 +759,11 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
>  int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
>  void perf_event_detach_bpf_prog(struct perf_event *event);
>  int perf_event_query_prog_array(struct perf_event *event, void __user *info);
> -int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
> -int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
> +
> +struct bpf_raw_tp_link;
> +int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link);
> +int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link);
> +
>  struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
>  void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
>  int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
> @@ -788,11 +791,12 @@ perf_event_query_prog_array(struct perf_event *event, void __user *info)
>  {
>  	return -EOPNOTSUPP;
>  }
> -static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p)
> +struct bpf_raw_tp_link;
> +static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
>  {
>  	return -EOPNOTSUPP;
>  }
> -static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *p)
> +static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
>  {
>  	return -EOPNOTSUPP;
>  }
> @@ -903,31 +907,31 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
>  int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
>  void perf_event_free_bpf_prog(struct perf_event *event);
>  
> -void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
> -void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
> -void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run1(struct bpf_raw_tp_link *link, u64 arg1);
> +void bpf_trace_run2(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2);
> +void bpf_trace_run3(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		    u64 arg3);
> -void bpf_trace_run4(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run4(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		    u64 arg3, u64 arg4);
> -void bpf_trace_run5(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run5(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		    u64 arg3, u64 arg4, u64 arg5);
> -void bpf_trace_run6(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run6(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		    u64 arg3, u64 arg4, u64 arg5, u64 arg6);
> -void bpf_trace_run7(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run7(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		    u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7);
> -void bpf_trace_run8(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run8(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		    u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
>  		    u64 arg8);
> -void bpf_trace_run9(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run9(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		    u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
>  		    u64 arg8, u64 arg9);
> -void bpf_trace_run10(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run10(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		     u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
>  		     u64 arg8, u64 arg9, u64 arg10);
> -void bpf_trace_run11(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run11(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		     u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
>  		     u64 arg8, u64 arg9, u64 arg10, u64 arg11);
> -void bpf_trace_run12(struct bpf_prog *prog, u64 arg1, u64 arg2,
> +void bpf_trace_run12(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
>  		     u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
>  		     u64 arg8, u64 arg9, u64 arg10, u64 arg11, u64 arg12);
>  void perf_trace_run_bpf_submit(void *raw_data, int size, int rctx,
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index e609cd7da47e..a2ea11cc912e 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -46,8 +46,7 @@
>  static notrace void							\
>  __bpf_trace_##call(void *__data, proto)					\
>  {									\
> -	struct bpf_prog *prog = __data;					\
> -	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
> +	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
>  }
>  
>  #undef DECLARE_EVENT_CLASS
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ae2ff73bde7e..1cb4c3809af4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3469,17 +3469,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  	return err;
>  }
>  
> -struct bpf_raw_tp_link {
> -	struct bpf_link link;
> -	struct bpf_raw_event_map *btp;
> -};
> -
>  static void bpf_raw_tp_link_release(struct bpf_link *link)
>  {
>  	struct bpf_raw_tp_link *raw_tp =
>  		container_of(link, struct bpf_raw_tp_link, link);
>  
> -	bpf_probe_unregister(raw_tp->btp, raw_tp->link.prog);
> +	bpf_probe_unregister(raw_tp->btp, raw_tp);
>  	bpf_put_raw_tracepoint(raw_tp->btp);
>  }
>  
> @@ -3833,7 +3828,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
>  		goto out_put_btp;
>  	}
>  
> -	err = bpf_probe_register(link->btp, prog);
> +	err = bpf_probe_register(link->btp, link);
>  	if (err) {
>  		bpf_link_cleanup(&link_primer);
>  		goto out_put_btp;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 30ecf62f8a17..17de91ad4a1f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2366,8 +2366,10 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
>  }
>  
>  static __always_inline
> -void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
> +void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>  {
> +	struct bpf_prog *prog = link->link.prog;
> +
>  	cant_sleep();
>  	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
>  		bpf_prog_inc_misses_counter(prog);
> @@ -2404,12 +2406,12 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>  #define __SEQ_0_11	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
>  
>  #define BPF_TRACE_DEFN_x(x)						\
> -	void bpf_trace_run##x(struct bpf_prog *prog,			\
> +	void bpf_trace_run##x(struct bpf_raw_tp_link *link,		\
>  			      REPEAT(x, SARG, __DL_COM, __SEQ_0_11))	\
>  	{								\
>  		u64 args[x];						\
>  		REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);			\
> -		__bpf_trace_run(prog, args);				\
> +		__bpf_trace_run(link, args);				\
>  	}								\
>  	EXPORT_SYMBOL_GPL(bpf_trace_run##x)
>  BPF_TRACE_DEFN_x(1);
> @@ -2425,9 +2427,10 @@ BPF_TRACE_DEFN_x(10);
>  BPF_TRACE_DEFN_x(11);
>  BPF_TRACE_DEFN_x(12);
>  
> -int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> +int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
>  {
>  	struct tracepoint *tp = btp->tp;
> +	struct bpf_prog *prog = link->link.prog;
>  
>  	/*
>  	 * check that program doesn't access arguments beyond what's
> @@ -2439,13 +2442,12 @@ int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
>  	if (prog->aux->max_tp_access > btp->writable_size)
>  		return -EINVAL;
>  
> -	return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
> -						   prog);
> +	return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func, link);
>  }
>  
> -int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> +int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
>  {
> -	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
> +	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, link);
>  }
>  
>  int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
> -- 
> 2.43.0
> 

