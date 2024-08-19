Return-Path: <bpf+bounces-37509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F0956CCA
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9611F227F2
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233F16D333;
	Mon, 19 Aug 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hqc1T86J"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0E16CD18;
	Mon, 19 Aug 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076689; cv=fail; b=skgfe8ZlyPQHqMh24EQY7i13AKKY9mqYYsidPh5J4o5sVzn18U3LIq5sK7zARcHSrzmqbT5E187x/5U2WW3A5whcaHFATDCljqOX2StFqSC3ccxVTp2/qZ/FEFkus4G4+ciioCLnzauCUrLpwaHxv4f/l26b74yEtUxRh9h5mn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076689; c=relaxed/simple;
	bh=MEmZnm19YfWGuahyUwbbRk0fpkwQ1+FcoOVpvbQ8SCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1z7slojw/fmVa/sIRhodk/nC+zW4R5vlwnrErHFQlo+z6Nu+8I68hhFQYZY80yPAX4O5dazHw7joARwrdsHePrJaJetGg2edsHnP2WXW0wyTYB4zHPQ6sTdMDmo7tEcJP03gGkSIvPCF7SvFzonvaWLV+90CwWbhxSCYNwEZm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hqc1T86J; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724076687; x=1755612687;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MEmZnm19YfWGuahyUwbbRk0fpkwQ1+FcoOVpvbQ8SCU=;
  b=Hqc1T86JD4UWhbSfHU8W/oDuP8Yxg78Yqpd3e3caXZdYRS0VsHCVmRJn
   XyuekRP8KrnWkAaZzhd+krPtLBKeIyXiPXuqvLvGATf8uBqdoW4GK0YPv
   jqOJkmta11vmM+KfYIjU8YKoyo8maJP+ZxcLvGzjJ8geSfsUSeIrrawwC
   CeZPm1BZDcBJxrN07xSYlfRH2x3ie0tctpjR+D+RdZ0LPysLzY6vgxLOp
   ok8YbPgQBYIYWlbCFQFF6D/Xn4bEze/5TxtStlykNsGX/oE8gm6xp1/tL
   N29v2DoBr3OxeWrvj1hIuS1QdtKS8Mir1kULl2AQnMUj/skWrPROujWxe
   w==;
X-CSE-ConnectionGUID: vZOtRSMXQBGEm59B9IXllw==
X-CSE-MsgGUID: lXm8X16DQ0KbzQAvaUyOcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22208404"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22208404"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:11:23 -0700
X-CSE-ConnectionGUID: o0QDWBKJQZmRyRd+srUK8Q==
X-CSE-MsgGUID: v0jiAgUVTtaDpBsRjIN/6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60223055"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 07:11:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 07:11:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 07:11:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 07:11:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 07:11:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISHLyLG54Ex/LZ5gAff2Gyw0oPqARfnAeHe71oiyolilhYjSmkY5Zrsy6JTsp4GuWavf8yUkPfDNDbpBRBvTZ11JioK/+9dKYmPG4Wpe+3LvVll6bzk2UmOvF82GIRtBFVqwju3mZaQj9pR1ahpbNCEKaaMaA5XM0CgL7hRJtOHiROZjQrLR5fCqZFPculSk5wN/trTJZfOgKMc2oMc1ewDOo42NMvD6jahWfmic2OpusH+N5s5jF5y4P7gZ53sGhTPLuHnqDjuZKOI1qDlULjTP6i6KL8w+1NKRTB3F62jLfQrrCnZI2yPz0AE7cnpTMiEKCXBVHCz7E4sHizR2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILYl1TdaJH7wghKg58r5RWAQRcbTMYWMqgm71r38RZU=;
 b=Pt+ARVygq3Us71GZL3CFZ8vHZ+zo3nakn6E2xWA2le2pfp2R3pxNy3bhV7TawrehnRFF1PGzxszH170PReENS5obOFqWleLuCghlUv2DnQ4cuEkfEQW+gxZE5q+9YrDLoN6XhflYVUxmU+lblfBcqkNXn1U9IdIJlkEJi6qRUsUfIGzHVfnMkVpUfvxhHhX4cmZs1h9R7ehfA/moFI4JatkwYi1FKA8pPYR9SSPo4qXdn3s4tZolW4S4YjuLOCW557U0fIcOdtX+DR6TS5Tim2ABTZBrQxyP7d/Fd1mk04uf7rWZAIZmDuZY3pQk2RArgEBM0Rls+t3OYhXBjkg89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Mon, 19 Aug
 2024 14:11:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:11:17 +0000
Date: Mon, 19 Aug 2024 16:10:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
 helpers
Message-ID: <ZsNSc9moGwySgpcU@boxer>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-4-4bfb68773b18@linutronix.de>
 <ZsNGf66OjbqQSTid@boxer>
 <87r0ak8wan.fsf@kurt.kurt.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87r0ak8wan.fsf@kurt.kurt.home>
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa9556d-b552-4fe1-b7ef-08dcc058ca4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VovxxQ7GJidfk4dxmbkAzEua3y1n428/bNbfwCExFDdQkB52Da8nYxiVce2W?=
 =?us-ascii?Q?HdPIj5RrBh6YyKQwHaCAVShoBKCNpqwiFxkdxwbN2RKn2z29AaSIV0MYqTr8?=
 =?us-ascii?Q?W29PvodyDIuhS+P+8yEphRis+mIvXNARzpEdwCRpNHOZ1qOEqaq6d6GRct5l?=
 =?us-ascii?Q?3bNKw3BcohkWSmz9x1i2P2E1RLprtKMlD+xIxlc+l+gYiC8RijR65v8Vm72D?=
 =?us-ascii?Q?DQ7Ig8v4HZ9p+fIkFT72WbrYo6ZP7WUq3oWruxYgvsAVN6fjSgp0HvTufHrn?=
 =?us-ascii?Q?t367MaOKl30Wq/8rQFuPmLqupTNEnaF057j8XjChZ1LvY+xfxgSZQGlKjZjE?=
 =?us-ascii?Q?QPAA8q32PhrH4n49DwP6KmFiPAXCcskE//Q3Lv8WkcvWZXRsEptrAaI+8zh1?=
 =?us-ascii?Q?ARuaDly+YKycMQP6nbCm80AG857qKFj8kl8glLVPTB09oZnDH3kA0KMu/cXu?=
 =?us-ascii?Q?FzXITtLEaU1RvlS0Doc4tqBJ8jx89OdsHk3r/qlunDpdr5hvdnHI1LhM3Knd?=
 =?us-ascii?Q?2oYBI6i3UE842aMXsHUTY/zRLT4HCDIN0Xo9FYIjy37synN24OfOZT2QsGEs?=
 =?us-ascii?Q?pdHb0rscwoWFzteI77D4ugcUZNhovsqNqgaI+iPhOAKn8KYUzZSycxMU+Bst?=
 =?us-ascii?Q?IRyZ9HS7cKd112kafr9GfLa/+hak4MJ24M71zxYIRQ8XkPe/A42rvW/KLT0c?=
 =?us-ascii?Q?6BBjIR6i2r9DHqnJl/q734uB4n6rFXoZfy3lxH6XBFihf5dtHfQhCrFqOsls?=
 =?us-ascii?Q?PzTd6swgj/qPfXu72b6MZfseswruluGGMwGUVDP088fX4RwjUarsigMDWiso?=
 =?us-ascii?Q?wujJsMgeiHvt5oNojhcagcw+QQs+qEp8gKJZY4z3g8faQ86KcI+79fTL78LS?=
 =?us-ascii?Q?lfAQlwXIlh4dxZwcnIcAryQC49FDbTw0WNAxS0VqRvN4J6JEpURGPhfK2+PD?=
 =?us-ascii?Q?2kgvvD8Ujeywc5FHukWnBh6R7uzyfJKBMcb+pvuAqxbg1LE91pzgYS87RId4?=
 =?us-ascii?Q?hmbJuvGgC8/dQ8IZ4K7/FTWruSAIA5Gx3WrGcUEz/wqGvY33h0ZiKpAA+0o4?=
 =?us-ascii?Q?mJXR44tyzFDY5xyBPug8uEtMfEbbjX+RgGFz8zF4tLUu2kbZSdlvrb/WKheq?=
 =?us-ascii?Q?zRg72Pq1g2spCMnrAva2ZqeFQuBzMVIL1/CPBeeX1kQ/Nlhv7kSRcwt7Wuov?=
 =?us-ascii?Q?CAV6zRyiPaApJAaw7EnwNZX9UOCp9t9AprexJ1vKcSmhqRBHOWGhRMRkYtvP?=
 =?us-ascii?Q?Vs7pFImn57RNMawjuX2att751s7pt/sFBvruOoLD5f9IUmAxciPpFQTuz+0i?=
 =?us-ascii?Q?a411ImVhgXqThYNxXAvgW1PwBDh7O2KArxwZZE3FRmxaAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AsrpWmX2V0njM531vEA/HZ3qZ074aQxngFkm4JLSRgWhNZLSND9nkm3sOV8/?=
 =?us-ascii?Q?tEYfpOAp2ZQgHb1ZtUmRKLOBvJcQPjLfp4og0gUBkW5u8T7LdBrq64dQ7K4t?=
 =?us-ascii?Q?Uiab5YR1GY9LHOlcJb8Jy6YThzNb8CJfy7vn0+mXHjobBhki8Ftm/gv96edT?=
 =?us-ascii?Q?BEReVYXh/Y+XT3b5ioRFc1leDL+pCXVkeq4eF3gVvNbQSl23tvd33ZJYXLtH?=
 =?us-ascii?Q?YEUlYC64cObALFDQKsSRgyU0/O2eKp9kyRDVNkIObcaCgSG1pvdKJ5kt6Ugh?=
 =?us-ascii?Q?XHZETfiPjN6gz+uN6uQZ+ngzSJpBOl09TQk6OeowPNQ2/gzdPXdS0YYzv+Jv?=
 =?us-ascii?Q?kowQ8+d+vXiiAt/4mHpGdVihaMo5KQyXDs0sk3b3diuzcXn+AH6JmnGD5Edp?=
 =?us-ascii?Q?N8kYBijR+/9KCzI0c59iEUr5Kl/gtteADhZyEBXUoMeOvOesma6jJbdcPGVl?=
 =?us-ascii?Q?wbu/AlFtZ99XumDsVNWS4kKk5H74JlQFh7ojcb+q2m4uwtcxwnq0vvfDSmxd?=
 =?us-ascii?Q?9JCMzLn5JhATW6tlkX6zNsHWyE+KCStBMnu3HX7w6/qd04GLVps8dau7rcP0?=
 =?us-ascii?Q?ce+sAHyd8Eb+xDPFY3PxbE7QD7DOChuapVnnpacmYqnS/D98/r+l9KhaWk8d?=
 =?us-ascii?Q?zHoPyZNImKIoazrdehD2wvYDEVA3e/aXchJzP+R6tmPI+7KjDY8ahLMo7SNg?=
 =?us-ascii?Q?eIwWBF4NEvFH9RWJr7D7fDVUSuFaQHJxT3hqWlIHu0cwDy4kX0exdyoE7OW/?=
 =?us-ascii?Q?jEQ3DmNwKZ3VxAifAqjD1JHdtyI13XxKV+pPHmNcoQTqc0kCDJ6bNACBzmJc?=
 =?us-ascii?Q?J14NuG5Rr9I8aG0kIv+fpL4NOswCUpB6pxyXVPzPGr1kHKcroPO12ckviGIJ?=
 =?us-ascii?Q?Bximr1HcvEp674yGcHa9B8Qq+h/UcemaJJo7Wwi+afjZ4PqThsYaQuI1E2He?=
 =?us-ascii?Q?OzIe5fFVDiN/PFnjhLdzJlaYkoq610jUJDTG2TxYHIN42qZzOEhdz+TwQV8/?=
 =?us-ascii?Q?siD7eDlsw0IczPpVThrpbB7tIEbJ1ovxmQ08z4PcyfgyI35ct8LhHP5UB/BT?=
 =?us-ascii?Q?gO9M5n9+g6h59OG7eWTtzHAq8eodmWdL0FG6Ii+FBEUcDw00kBZc4cjbw5dL?=
 =?us-ascii?Q?cuJqi6getAXdlcGB5Q/vdzdTcdK3i8fOa4c0COO+qEufNiPS6JQL7TTe3GMr?=
 =?us-ascii?Q?xCwMs+/rI902jEPPeZvCd/gfXKUiFpRsmAsUWqin6ylTvji0sPSLptCgV+Fl?=
 =?us-ascii?Q?Va6bi92tSB8oInrPPmMTnnfhV/xqRAl9CH3siDmdjz/mMIfDJS6eTpnWsSn3?=
 =?us-ascii?Q?8edenm9nPjveMhodvFNGnLEwGsUF6BXegTOOGTtwOgilN2RUt41WNw6zxMWY?=
 =?us-ascii?Q?wlmrUxUxdQJrAMHzVPWmRSWPYpqZNv7eB+XpXP+dP30iTBr+t2TntF1RjlWL?=
 =?us-ascii?Q?ULnmTmylFiMBVTZ9KsinqS4wiVB+mWEHvO0hgzySzxXX1rmGQPpg9KuhF7g5?=
 =?us-ascii?Q?pt594UpbGAmGHImSOsbNXcY1+OORw+zC0Vgkd8hAN6XkxY6ML35VNPTlQDGz?=
 =?us-ascii?Q?pj//XXF4veYcvo2/WX1Vi4EU9Rv6AJ3xmWeU8LtP2ESU4Z93blAKLAxACg/Y?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa9556d-b552-4fe1-b7ef-08dcc058ca4d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:11:17.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/wM9p9xdrcdAHiEkwlNHetCPJ5H5MFc9k/p3kX/YHlGS3VgxxRTbVfdL75quGXiuCoYn0ulhSMQzcTbnISrNTTkhwxFoXGWzToNJMpJSx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com

On Mon, Aug 19, 2024 at 03:41:20PM +0200, Kurt Kanzenbach wrote:
> On Mon Aug 19 2024, Maciej Fijalkowski wrote:
> > On Fri, Aug 16, 2024 at 11:24:03AM +0200, Kurt Kanzenbach wrote:
> >> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> >> 
> >> Add the following ring flag:
> >> - IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)
> >> 
> >> Add a xdp_buff array for use with XSK receive batch API, and a pointer
> >> to xsk_pool in igb_adapter.
> >> 
> >> Add enable/disable functions for TX and RX rings.
> >> Add enable/disable functions for XSK pool.
> >> Add xsk wakeup function.
> >> 
> >> None of the above functionality will be active until
> >> NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev->xdp_features.
> >> 
> >> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> >
> > Sriram's mail bounces unfortunately, is it possible to grab his current
> > address?
> 
> His current email address is in the Cc list. However, i wasn't sure if
> it's okay to update the From and SoB of these patches?

Okay. Then I believe Sriram should provide a mailmap entry to map his old
mail to a new one.

> 
> >
> > You could also update the copyright date in igb_xsk.c.
> 
> Ditto for the copyright. It probably has to be something like
> Copyright(c) 2023 Ericsson?

It says 2018 Intel. I don't think Sriram was working under E/// employment
as he said he was forbidden to work on this further and that's why you
picked it up, right?

My intent was not stir up the copyright pot, though. It can be left as-is
or have something of a Linutronix/Sriram Yagnamaran mix :P

> 
> Thanks,
> Kurt



