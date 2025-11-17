Return-Path: <bpf+bounces-74746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D9FC65079
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D723E28A21
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E32C0266;
	Mon, 17 Nov 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LodNQH1y"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391842BEC30;
	Mon, 17 Nov 2025 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395541; cv=fail; b=cEuDb1KAK+ScgJr2gdOesGa9W9jP/n0w2kEqFAmc/BjyAEMR6Jjk+vOF9pSiQM2pGhGaYxc+4T76xlaQdOErZ8+hOBarg6GEyJs2fYQmCy+hd5xlQKmvp46CZzeEI05kbfXc8cNypMszCXS2S4GRCvCSFcf2Et9XhfxXC3ztBrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395541; c=relaxed/simple;
	bh=BusQxeVi9pyZK+o+RrFi7egdcCOVFEDdkzm/DVLO7dU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gf8XV8DpsTcHQmCJaWkIr/lpDSWzLQnpxckvx5Lfd9gDrSRbQbpfagW0hfELn4doeRhZlbRdKdIcSzRyfRozWeEhSGIyLXVXZgFeg+g5h5dDzNKKXGJg3GWHow7wS4GxiV4Uy0/ShZdOisox9JaT+AGztyc+rnU5mtid3njQGyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LodNQH1y; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763395539; x=1794931539;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BusQxeVi9pyZK+o+RrFi7egdcCOVFEDdkzm/DVLO7dU=;
  b=LodNQH1ynhnv0ADdPdD3BxmxdK1wEnHzAtE/gsxftmYAfyItMQYHUjSR
   aLN6wGID7oifEZyw90P04TaEtZImGGf/Pi7dbuvenUGX0T0qb4888pI7x
   jCxCaPUaCbk4i8Izv9r789y7IXRYyYtn1PI7nVKjjqjCnUfRYtJ7jX92p
   dbYJX7JBVtmZbASi8mR3qycN/u/dgIpaF2Ie4kQ7yFDXSe+kyv2lE9pcW
   ANrj3m+hgtMEfK4Hp3FCdODI8lo8YpF1DoRdEDHnL+petSEnMvl+A8fj1
   fbrmH4xHdge0biI1NV0oZ8Zbf2Y3tvIW8iB3BAxNP+7D3C4KoE5zy/Zxn
   w==;
X-CSE-ConnectionGUID: cDvONOAOR2e6MC/t5c7c4Q==
X-CSE-MsgGUID: ekzQDxHdTVGvdHYETJz/IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="52968744"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="52968744"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:05:38 -0800
X-CSE-ConnectionGUID: fosLecWwRkqyToV5F3btgQ==
X-CSE-MsgGUID: 33X5pO+LTUGmqTepvgbQOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="194957438"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:05:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:05:37 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 08:05:37 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:05:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O67FQ6sdQzkhWE2jR9KdXAhJPxRCFc+xEeTBMa9P3viFO0+BfUU5DLaX78wm//xp9bjXMCb6Whfw1aEaZ8/2Vl7IDMOi2kmcfbcypZ4+XOT2GlCfarYFe+xD8ZXfJdS8EQ1dMpxft3uEU827qd+iWmWQtildJtwHOjbwZMrjD0mJqjxy8xDca6LLPUy59UljzWd7dSvQ7Q3wKMZjgx3dxv1OExB4IK2EU2tR51ziIvZkkwFopPNThKsXYk45QABkYKiV2lPlRL6zKbov4A/byr/wdHlPt4ZCr6J6SmyRuZ7ezuMv0VSgk2QwhOOttlBQvGFEeXLiRPhwneq+QVfdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpLsCZcCoNAjaUdDbnAgVocVspmFklDIEdvyWe8kP10=;
 b=ymsLjKHMKCpifGNxzR9yLwn2WpTaUkmVIrmwzDT1828vHQuYdaFOBv4HxoWDnXeo2IstVtrV5imRdW82jBW+5kzvvBbVClA7DbFEXOJ+eHM7QXNrJDNXQmwWlQ+PH6QPUf3u+UvWTjndX6LWd/3REZQ2H8ZAMleT3J0SVW+V1imGTZehY0RkSBOjrX/hKJ6Rc37eJCN2Iuy8b92E9hI+yzC/BSCpHxz+iW5asnIF5pyLH8Cg5K8jhUP5eMNF6BPDFibRXerkWn3FXED4C/+SAXRs+9IV4ugffik1GxyGeF2SPVnOdVcr4UHo7uKxPvncqABvqGt7ltzmmcEPiWY9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4810.namprd11.prod.outlook.com (2603:10b6:806:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 16:05:33 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 16:05:32 +0000
Date: Mon, 17 Nov 2025 17:05:18 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <joe@dama.to>,
	<willemdebruijn.kernel@gmail.com>, <fmancera@suse.de>, <csmate@nop.hu>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
Message-ID: <aRtHvooD0IWWb4Cx@boxer>
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com>
 <aQTBajODN3Nnskta@boxer>
 <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
 <aQjDjaQzv+Y4U6NL@boxer>
 <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
 <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
 <aRdQWqKs29U7moXq@boxer>
 <CAL+tcoAv+dTK-Z=HNGUJNohxRu_oWCPQ4L1BRQT9nvB4WZMd7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAv+dTK-Z=HNGUJNohxRu_oWCPQ4L1BRQT9nvB4WZMd7Q@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB4810:EE_
X-MS-Office365-Filtering-Correlation-Id: 70031381-3973-4738-f39d-08de25f32204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEtvRFdoMHdtR3Z2V0Y2NWxwaC9aZHV4NTZoVFRUTFNPTFlHZmtsRFdFNVhT?=
 =?utf-8?B?dndzUXJyYXhKVGtRS3dUWDJuQVJJRThZWi9EWkkxRElDL1MzK2tEVzkzNjBr?=
 =?utf-8?B?S1RtbmdvMmo0aTBhWnA0NERIN1ZybU9BWXRjN3AxZVNsVDVSNUVES1k3UDRW?=
 =?utf-8?B?WkdqZGQvbEZySjdON2JjTEhuNDIxVUNKUXg3emVWS3NmT0kzRWxYS1d2RitF?=
 =?utf-8?B?WXc1NDErdEU0eTc1amFkMzJ4Zkh3dGRnd3J0dS96eE9Za2RQLzl1Tng0Y3V5?=
 =?utf-8?B?V3JCbkVWMDZmVkl4TnVscDRkR2hCRGk0cmh5ckhrYjNFd1ZPVnQyaFgrMlB3?=
 =?utf-8?B?L0lpb05ZUFJwNzc3U3RCcjdhbjhHTC81QmYvVklCRzIxOW8yeUFVQXlMZEI3?=
 =?utf-8?B?R3dlLzhOZVB3d1NVdzVQa1BDZVIrNUlaWEN4N2RGdjJhcGhzWkdpNU4xV3Zt?=
 =?utf-8?B?NmZFOWlWVWhQOEtTVjdPamUwUDFHZzVzN3JOVDh2emVoRVhrdzNoalM2TlYw?=
 =?utf-8?B?c2VMbXNONElBbGdyOGFPWFdVTUI4TXhmVEloVjY3NTNUaElpcm9CdFpZR1lM?=
 =?utf-8?B?V2Z3TzFaQ1lUMzlmNXlLdCtpRWw4Mjk0dGtCamJkZWhlRVVsVEJtSkdIQnhr?=
 =?utf-8?B?RTZ3Yk10MkZMTXlpeFhUUmovMnVlWnYxZm5rYkxZMFRDd0ROT29VNmc2ekIx?=
 =?utf-8?B?SmVWUHM0OGFPUVhFMnQ0V01nVm1jZFljRlVHd0RyNUlEZHFpSzlqVEZod2tZ?=
 =?utf-8?B?MDdhVm9FL3JiRGRLelRva0dSK3lJVkdrRHRZSUM1bk91bkx2WGJ6cmJwL0Nh?=
 =?utf-8?B?NVpLMjc0YTR6RWxpQ25HeHpXbjc5QlJETVhCc2JkNFhMajNCMFNzWHZrQ2tz?=
 =?utf-8?B?RXdMUk93bGViQjgraEF2YnRtRWZuaWY2OXFvcnNTV3VNbmd6WmRIMEtLTDVo?=
 =?utf-8?B?K2dYNlpsT3lURm9GaDVHY1VueHdQZjhrS08zblBONTRSb25mR3k0dGhaQ1Vn?=
 =?utf-8?B?WVlCbVpPN2xWU2ZQNVliUlNzdm5ycXIrUWNka05XZ2hUWnRUSlhlRnNNVXly?=
 =?utf-8?B?a2RDdFhwR1Vkb0U4SWtKdXhMTVpkVnBWU3RXd1crb2wvdUphbUhZek5vZTFt?=
 =?utf-8?B?c1haekVJaWxicGpkS1hYSEw0UUtGVE5hUjRQNnZjbnNtckh6SS91VjhkNXh0?=
 =?utf-8?B?akdqSXNQa0RCVEl0WThBN2dIV2JIN21CZlVWWjd2Q2dyWDZwdEVQUkpHQi9t?=
 =?utf-8?B?dms5Tzk5bmx3OUdjU3UycXpCTmR6UThadFlJSTFIQ2d5MU1WaWE2Z1djR2pm?=
 =?utf-8?B?Q2d5QkJGTklGUlpTRG5aYi9vVk1hemNHa1ZVaGlacHdYaGZLS1FHRUZtTjlY?=
 =?utf-8?B?cTcxbTNJbzJaRlV6RWhoclpHbklzaTJHdHA2b0xDdWZ2bGhEWGRHdUJFVExp?=
 =?utf-8?B?VFcwNEtRblFiM3h1RzFDbmpsUnBmUmNxR0FvN3E0SVVOYVZtQyt1QnVVRmJR?=
 =?utf-8?B?UnRlekFZR2RySVRYYklVNVNoZ3phK09sTFA3L2RuUFRHMXY4T3dNYUsrc0h0?=
 =?utf-8?B?emczOStBUGtOazVmbklMSW9pR3BMam9rU0dnRGdoRm1sTm5KNFJSTGU2eStY?=
 =?utf-8?B?cWl3MHlnZ3dXTnhhcUhpZ1U1VUMvd29RVkJzMllpbnRLR1BXeDd3WnF3Tkt2?=
 =?utf-8?B?T0tpSXRRaUhFMDhvRE5SV2ZrMTBMS0FGM1owQzlLT1UzUStRNll0QnNaKzdt?=
 =?utf-8?B?S0FsNjdTcWJSOVVaa0t2OVVBSUgxcXprL3ZmeFRYN3lYRFZmRG5Zc2VNT0tI?=
 =?utf-8?B?MTdtUFRQRlIzQWZLaTR0cys1bkFwcW11T0FFam5zVzhaUGUxdnB0NzRDNnN5?=
 =?utf-8?B?SVNkODEvWEsreWtMdENEQ2pibThFUlpEZ0lvcEFGdU40ZG5KSm5SWWZhV3p2?=
 =?utf-8?B?NGVNUytnMEFuTGRxc1c4U2JreGVDOVpBeWl3Y1FUdWRQd1M4eUphbTVlZk1Y?=
 =?utf-8?B?ODFua1A3cHZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHViTUw3UGpGcGhuR3BIaWJoNzNKOUhlWlBjNWFhWE9ZY3RXYkFvVGd0RVho?=
 =?utf-8?B?cXFUNTVZNWE1andRL3B4eUgva1phUXVTZ2wyc1hhVEtpSFBGb1lDQTFzalU3?=
 =?utf-8?B?SkxqRlU3ZWtSZVY3akNzL3dxTXBVVnhld2MvYm9pWE8yeVA5TkFVUy9OYnVT?=
 =?utf-8?B?NS9sVGNlVUkzeTZqV2htTzNYcFRLcHhFSzNIWldUVlZ5MHZSL2N3NEVtYUZ2?=
 =?utf-8?B?TVNSb2ZsY2ZYR3JZSzltUVhNd0lvL1grUFBMZ1MxUGxMeWRSVDc3UFJpNzM3?=
 =?utf-8?B?UXZCVGRCMzV4aXRpSHgvZ2pnSmlDSGF1TmFmdDA5NWtSL1Y2dzUxaklmSTFI?=
 =?utf-8?B?MjdDMWVicWtxTC9nb29iYnVJUHpCd0ZUa0VqeHBnbkc3cjZocC9mcTNJcE5i?=
 =?utf-8?B?eTBpamUrS3RNMkp6OW5sQ0hxM3VzMTU0SnNrbU00NWxBRmlvckN0azdjSEtB?=
 =?utf-8?B?NzNIQXZZY1YzVkpLRDJ3eXpnZ2xyMnhmZkxsVVIwUXRmU21nTzRkcnhsZTdM?=
 =?utf-8?B?eHliL0pnQVNxZ2pxQTZDUDJLT21seEU2K05jV1U1WExaWTVuMXNWT2NmRktu?=
 =?utf-8?B?SUZLNjJFaFZ4T2FjUXcyVlhqZzQ3MHlGMGpkSlFYSHlWOFphMStIYWExb0xQ?=
 =?utf-8?B?NnQvc0grRW8yTDVSdktPL2ZhWE54RXlqUU5FU2h2TVk4ekw1WWRBaDRjS3Fs?=
 =?utf-8?B?K1p6alJ2RW9vbjAzeFZiOXc3aWtVZHJvVWU5dFY2Z1g4Z0dDbzZ1YXBLNXFV?=
 =?utf-8?B?bTBzckNBSjZxNW5WYnozNUNkSzFsL1FwVXhVc0FyZlFzeVZLSTFyajBJY0dR?=
 =?utf-8?B?bklYdzd0akE5UmxRaXk1aVFMSXdnK0dlNEE4bmxSZ3VYc2E4cWdpUW1VTG9i?=
 =?utf-8?B?bHBpcTBjUnFwR1NiT3NWTkZTT3lPS2R4ckJrVm1QeG5uTWFlQVNrbS9IdFlN?=
 =?utf-8?B?ZnZIeW4wZ3FVckwrN3laQ3M5Q2NSNDVYdVUyMzUzY3I1UUhtOHZ4THZzTW1o?=
 =?utf-8?B?UGNia1gzZHJmSjVxcXdMUmV0UHlEblRZT1VldHZ4QkNweE5nZHZwNDNCNUN6?=
 =?utf-8?B?QjRlbHlVQzBuU3FEVHlZdFpub3ZjdkdpTWhTcFF5dWhyU1V3c1ZGZ3FTY0FH?=
 =?utf-8?B?bE5KeFVDL3FnOXNTVTEwdHNEeVhrK1lJV09xdE1QV0JCeGsxeVBIWmxzK3ZC?=
 =?utf-8?B?OFJ2OW15MDRNMjVwajdBaEMxeXdEc1g2TGVONE4wdEhqWWl3RzFmTTNVMStI?=
 =?utf-8?B?SG04aVdpb01aNVB5SVhmTmFBcUJ6cWpEVXEvaXdxekVlWTFQOGJ3S0NWMVZH?=
 =?utf-8?B?SkxTbFNCdTBSVWdnWmRCWW1oengzeTRvUG81Y0RpOU50K3lac2piTVNJTmNK?=
 =?utf-8?B?Q0NVNG0vaDFEZ1lxcE1SbkpQOUl1ZS9rUW5LeEdrZFhrY3FVUS9IeXRhdTdu?=
 =?utf-8?B?SzNxMVA3Y1NJbFVSZTRwYUQrZU1XcWJqS3Yzc0tDRHlENys0MkFhNERDR3Rz?=
 =?utf-8?B?MVdMRUVUajNqVVJORnlIczFNN0NoK3dyUHFDb2xUcjNKc1BIVTZjLzg4VFNN?=
 =?utf-8?B?clVLbUZRR0w1N1VhZnQrVnNNQ05jc0ZBWVRHTkQ4cGtqQSthOHV0V1ZJTU5I?=
 =?utf-8?B?c3dDR1FXU2RWQjcyRUxidnhXdWNCUEUxbzU4UHh1SXl2cUw4N1U1WUNRQkYz?=
 =?utf-8?B?YzdidWI3MEVOcGJ0bjY3MTcyNS9aVnNlR2NiZThnYkxDUko5Q0NKeUtOOG40?=
 =?utf-8?B?ZklkbzdZdjgrOVpsSUlFTWpuN3R0VjhOVTk0cVJzcGw2R0UzRUR4TWY0N3M0?=
 =?utf-8?B?Z0hGaVQrQkdOalFjZGJybm1tdkRxclJnZU1DWjloSEp4d00xNzNWOFI0bmd4?=
 =?utf-8?B?V2UvV0xvUXRmSHhHbTZDU3NEZXVqRmsxVUVOZGpvbmJTaEgyMjdKQ3UyeDhJ?=
 =?utf-8?B?MEZjRUNXR0FaVFIrY2VFYTBMby9LREp4eHVEVkl4cmdaZWNWckpJcFpDZnRB?=
 =?utf-8?B?VXdDZzltd1lNNFdyRDNnN1ZJTjI0bjN6NUhrYi9jNG5SV3lydTdlQWN6aEQr?=
 =?utf-8?B?RlFUeWlhbEtHV2UvL3hERUExaWUvMlpKb2JJNTREYWJkLy9kWXVTdHZKVjZp?=
 =?utf-8?B?QkYrY3YxbTZwNFBIRU40VHB5NmYzZHhDRTRVeUdaUjZ5OGRTb1p5Yit4SHpm?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70031381-3973-4738-f39d-08de25f32204
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:05:31.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRcZ7SjruogF7kIgT91rM9yluLenvVCdshjLOnkEHRFY0jpUBoJSrcj+kwCuOH2vLrrcLI75uNRfkGHr31LoMpJ6iVuWMMRU1F8E0AGWQnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4810
X-OriginatorOrg: intel.com

On Sat, Nov 15, 2025 at 07:46:40AM +0800, Jason Xing wrote:
> On Fri, Nov 14, 2025 at 11:53 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Tue, Nov 11, 2025 at 10:02:58PM +0800, Jason Xing wrote:
> > > Hi Magnus,
> > >
> > > On Tue, Nov 11, 2025 at 9:44 PM Magnus Karlsson
> > > <magnus.karlsson@gmail.com> wrote:
> > > >
> > > > On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gmail.com> wrote:
> > > > >
> > > > > Hi Maciej,
> > > > >
> > > > > On Mon, Nov 3, 2025 at 11:00 PM Maciej Fijalkowski
> > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > >
> > > > > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > > > > > > On Fri, Oct 31, 2025 at 10:02 PM Maciej Fijalkowski
> > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > >
> > > > > > > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > > > > > > > > production"), there is one issue[1] which causes the wrong publish
> > > > > > > > > of descriptors in race condidtion. The above commit fixes the issue
> > > > > > > > > but adds more memory operations in the xmit hot path and interrupt
> > > > > > > > > context, which can cause side effect in performance.
> > > > > > > > >
> > > > > > > > > This patch tries to propose a new solution to fix the problem
> > > > > > > > > without manipulating the allocation and deallocation of memory. One
> > > > > > > > > of the key points is that I borrowed the idea from the above commit
> > > > > > > > > that postpones updating the ring->descs in xsk_destruct_skb()
> > > > > > > > > instead of in __xsk_generic_xmit().
> > > > > > > > >
> > > > > > > > > The core logics are as show below:
> > > > > > > > > 1. allocate a new local queue. Only its cached_prod member is used.
> > > > > > > > > 2. write the descriptors into the local queue in the xmit path. And
> > > > > > > > >    record the cached_prod as @start_addr that reflects the
> > > > > > > > >    start position of this queue so that later the skb can easily
> > > > > > > > >    find where its addrs are written in the destruction phase.
> > > > > > > > > 3. initialize the upper 24 bits of destructor_arg to store @start_addr
> > > > > > > > >    in xsk_skb_init_misc().
> > > > > > > > > 4. Initialize the lower 8 bits of destructor_arg to store how many
> > > > > > > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > > > > > > 5. write the desc addr(s) from the @start_addr from the cached cq
> > > > > > > > >    one by one into the real cq in xsk_destruct_skb(). In turn sync
> > > > > > > > >    the global state of the cq.
> > > > > > > > >
> > > > > > > > > The format of destructor_arg is designed as:
> > > > > > > > >  ------------------------ --------
> > > > > > > > > |       start_addr       |  num   |
> > > > > > > > >  ------------------------ --------
> > > > > > > > > Using upper 24 bits is enough to keep the temporary descriptors. And
> > > > > > > > > it's also enough to use lower 8 bits to show the number of descriptors
> > > > > > > > > that one skb owns.
> > > > > > > > >
> > > > > > > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@partner.samsung.com/
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > ---
> > > > > > > > > I posted the series as an RFC because I'd like to hear more opinions on
> > > > > > > > > the current rought approach so that the fix[2] can be avoided and
> > > > > > > > > mitigate the impact of performance. This patch might have bugs because
> > > > > > > > > I decided to spend more time on it after we come to an agreement. Please
> > > > > > > > > review the overall concepts. Thanks!
> > > > > > > > >
> > > > > > > > > Maciej, could you share with me the way you tested jumbo frame? I used
> > > > > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes the
> > > > > > > > > nic more than 90%, which means I cannot see the performance impact.
> > > > > > >
> > > > > > > Could you provide the command you used? Thanks :)
> > > > > > >
> > > > > > > > >
> > > > > > > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse.de/
> > > > > > > > > ---
> > > > > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--------
> > > > > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > > > > > >
> > > > > > > > (...)
> > > > > > > >
> > > > > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> > > > > > > > >
> > > > > > > > >       pool->fq = xs->fq_tmp;
> > > > > > > > >       pool->cq = xs->cq_tmp;
> > > > > > > > > +     pool->cached_cq = xs->cached_cq;
> > > > > > > >
> > > > > > > > Jason,
> > > > > > > >
> > > > > > > > pool can be shared between multiple sockets that bind to same <netdev,qid>
> > > > > > > > tuple. I believe here you're opening up for the very same issue Eryk
> > > > > > > > initially reported.
> > > > > > >
> > > > > > > Actually it shouldn't happen because the cached_cq is more of the
> > > > > > > temporary array that helps the skb store its start position. The
> > > > > > > cached_prod of cached_cq can only be increased, not decreased. In the
> > > > > > > skb destruction phase, only those skbs that go to the end of life need
> > > > > > > to sync its desc from cached_cq to cq. For some skbs that are released
> > > > > > > before the tx completion, we don't need to clear its record in
> > > > > > > cached_cq at all and cq remains untouched.
> > > > > > >
> > > > > > > To put it in a simple way, the patch you proposed uses kmem_cached*
> > > > > > > helpers to store the addr and write the addr into cq at the end of
> > > > > > > lifecycle while the current patch uses a pre-allocated memory to
> > > > > > > store. So it avoids the allocation and deallocation.
> > > > > > >
> > > > > > > Unless I'm missing something important. If so, I'm still convinced
> > > > > > > this temporary queue can solve the problem since essentially it's a
> > > > > > > better substitute for kmem cache to retain high performance.
> >
> > Back after health issues!
> 
> Hi Maciej,
> 
> Hope you're fully recovered:)
> 
> >
> > Jason, I am still not convinced about this solution.
> >
> > In shared pool setups, the temp cq will also be shared, which means that
> > two parallel processes can produce addresses onto temp cq and therefore
> > expose address to a socket that it does not belong to. In order to make
> > this work you would have to know upfront the descriptor count of given
> > frame and reserve this during processing the first descriptor.
> >
> > socket 0                        socket 1
> > prod addr 0xAA
> > prod addr 0xBB
> >                                 prod addr 0xDD
> > prod addr 0xCC
> >                                 prod addr 0xEE
> >
> > socket 0 calls skb destructor with num desc == 3, placing 0xDD onto cq
> > which has not been sent yet, therefore potentially corrupting it.
> 
> Thanks for spotting this case!
> 
> Yes, it can happen, so let's turn into a per-xsk granularity? If each
> xsk has its own temp queue, then the problem would disappear and good
> news is that we don't need extra locks like pool->cq_lock to prevent
> multiple parallel xsks accessing the temp queue.

Sure, when you're confident this is working solution then you can post it.
But from my POV we should go with Fernando's patch and then you can send
patches to bpf-next as improvements. There are people out there with
broken xsk waiting for a fix.

> 
> Hope you can agree with this method. It borrows your idea and then
> only uses a _pre-allocated buffer_ to replace kmem_cache_alloc() in
> the hot path. This solution will direct us more to a high performance
> direction. IMHO, I‘d rather not see any degradation in performance
> because of some issues.

I have to disagree here even though my work was around perf improvements
in the past. Code has to be correct and we have to respect bug reports. So
clarity and correctness comes before performance. If we silently accept
some breakage then in the future nothing would spot syzbot from preparing
a bug reproducer. Addressing this consumes developer's/maintainer's time.

> 
> Thanks,
> Jason
> 
> >
> > For now, I think we should move forward with Fernando's fix as there have
> > been multiple reports already regarding broken state of xsk copy mode.
> >
> > > > > >
> > > > > > I need a bit more time on this, probably I'll respond tomorrow.
> > > > >
> > > > > I'd like to know if you have any further comments on this? And should
> > > > > I continue to post as an official series?
> > > >
> > > > Hi Jason,
> > > >
> > > > Maciej has been out-of-office for a couple of days. He should
> > > > hopefully be back later this week, so please wait for his comments.
> > >
> > > Thanks for letting me know. I will wait :)
> > >
> > > Thanks,
> > > Jason

