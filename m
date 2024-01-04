Return-Path: <bpf+bounces-19063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE17824981
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6146B286300
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99102C69A;
	Thu,  4 Jan 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6bM/4Bg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF62C682;
	Thu,  4 Jan 2024 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704399530; x=1735935530;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rujT/GAak61dAk+xzwpT/bTzuHPXvk0zX+Np3+88Uvk=;
  b=l6bM/4BgQiveRCZdh63vZYTHo47Cmu9tg9rL6cFXlS4SHP4x4bMLLZjA
   F4Zu29uGoNGsOiOVfG3aDZKJYTZLPUmuwqDmgnou+ICuvYppkX17fb+pl
   l2s5ABIqsLos4iu/fKijhLrYJZ41whteLJLb/JP2XsLXNqWE8HAQ2JL1y
   EfD61mv/2VbmVGS4F2TQHz3W1ZltH+J7eknJ14CNN7zVjoeA/rqVi3Z7X
   TWX32Olio8QBYdGqlRkX5uZ46E9Yow+6X5Xa5Y53U4CfDaNDE5gCOkA2Z
   x3d1wrZ1rf1C9TAAg4t00nPVFbqnmWPh2xowvjrFJajmKBluVaqanXuu5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="376837097"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="376837097"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 12:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="28914151"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 12:18:49 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 12:18:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 12:18:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 12:18:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAe6MNhQNEOUUWJPcNiNaYN18jxM4XwThBJOtzUsdAA5M4ityq9AziHuWZQRsjm6LtV+JexNpiQsnNt5IRte25wVPWuqycQZuvMdNel6E8g9jLylJzCKDCtrAzdS7GTKT+wAopEVGTLhtoJalc602ld/uBXZi4nY02/NKjACgaOmxj9SsL8VioDMfirrsbHYLvCpYvSh/UutOaQI5RAV+TOwi6Pn8JyFRiFYipmIq8FM78jmlyu39AdgsB99eXf+asOzKF8OCnYpU1f3KDhMuihxq6WCj5umsUjcrZLEXkqgOHkb9A5cN2P0ixAmm7mx641DH1/OUaR8zG4UdWrWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jszy5OLRFg6I9R3nIlRgFoo6/QZhQ88LDNkzwCSWTfs=;
 b=bUJZUtW7HTpZi15W9dUp3vZqnz+gWBz0RM6LoxUcHcMH0qdeIhK5JaUm1lfTNAZ1CosxxieksK6462TlQAYAdGA0TfpbGHciSS7H5iQI10ltpLM0StR+bzi2SiRYBfmQ/4DuAyXtysIkzcNmOg3MbEn9sXF1a9ycE2+sSrDlvmHwuU5JU6qtcNVTGJFBMyyNw5Hh+H0fUJrSR9hn67j7fXwPuMpvTDBUhXmgGeUmN6XjVqkFGuiqRDoyejQXSrYbhfMBje+OyDcjnQzXBXdRCSQLStNf8N3oYSbqsmwPQYGhoWqVoouc12I12c/ir7B369Ir8AAqvjZjcG6yQiaOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6448.namprd11.prod.outlook.com (2603:10b6:8:c3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.16; Thu, 4 Jan 2024 20:18:45 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 20:18:44 +0000
Date: Thu, 4 Jan 2024 21:18:33 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: John Fastabend <john.fastabend@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>,
	<tirthendu.sarkar@intel.com>
Subject: Re: [PATCH v3 bpf 2/4] xsk: fix usage of multi-buffer BPF helpers
 for ZC XDP
Message-ID: <ZZcSmXnOY9poWT/L@boxer>
References: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
 <20231221132656.384606-3-maciej.fijalkowski@intel.com>
 <6595c80a83de0_256122088a@john.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6595c80a83de0_256122088a@john.notmuch>
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: f24d49bb-5a19-4002-79ed-08dc0d6259de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNZ+0pg+rMYaciC2tCAvzWFgz45CMm2Wp7L0haILKLEhOBkjMyNk5thGVjyZkVnwEl6yMxXuEnIwHXk3PgoEWQ4rKw2rPsgFdog+pLfZDz+r0rUATKdspiVeeoPWsbWDi3QG7n2WOUrLHA0NV0+kriJmUjD5xcQFvKTPIOcD8baJ36Of0cLzuFYHtdz99d0UILktqNr45Tac223obEWSeK3phood3Vb7kzS94e5Zo4VVR/VDYLPJs6vXaoDjkEzVtj+wugGQpciA3UyPjDkiGUhe/smatlKSLtR6yAxWzLTfh5ZCWrdQvDO7iBqAt/rM1lXXtPM+3u1ombNgvT7gBFVdrtwIDqe/YsXmiqeOlPZC0azRVBlhBeohus4A8HzLbZN076B1eWEX/PV9ubFy1+8+jfqYfjncM33W9me40+808TupXYLXTe54GL1gKRiq7DnhvUYMN0aXVDHI0vW16enmhblNDmJIQy6Ox+9uqOllvjLduRw7pzr93jO2mvz4I3Tq2WM3IfMAU7cwf0nStmApsbH0Jr01lgrN3SAEUMYL/+Fy/v+uhKr9JrEckdiC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6506007)(9686003)(6512007)(66946007)(66476007)(66556008)(6666004)(478600001)(6916009)(6486002)(316002)(26005)(107886003)(83380400001)(33716001)(41300700001)(5660300002)(2906002)(4326008)(44832011)(8936002)(8676002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xj9XGtfzw52+Jf13fblEPr84PpnEekMFza9NJL6f6SjjubCc5L97Pjd8GfkK?=
 =?us-ascii?Q?w4oG+jycwl9nKwS4kq5sxreTTACnQ5jPtTx8/w/mCq9A1jz8YXQwd1qhfvWH?=
 =?us-ascii?Q?j7sVNHq5A88p6ff7Nq1FseuByFyiRo0lN3G6Re+iW9fm56gha4DRF0VWRU/C?=
 =?us-ascii?Q?5y8XEKjHNu6+HlEekCGSrL0+m1ved5X3Wy3TSxpl6LKZp//2p9Z6jCiuVYY7?=
 =?us-ascii?Q?wkB02Au95q06tkiY4ITzXCA4tnR1nUogfd/T/WoHbYoTQ7Y+JFNIWFXggLm4?=
 =?us-ascii?Q?GILJz8DsGADYXJZvhFxF8V/KJUEj5Te/Mr1C6XQ4F3m76DRSYs8+r8vpcXHh?=
 =?us-ascii?Q?2ijmK+hrY3ravXnILZ93HaPDi3F0T38lStUu73r+4khDciq09C2glGvZ43gZ?=
 =?us-ascii?Q?NoKJp3gv7TG/7AK4SXRpLrjdmLeDSwMbLdAO+CriAHUn+F3n4tvfvkPPY7SH?=
 =?us-ascii?Q?1XpzvV62PLZ1ljiscenY9x0s4V1zM9En5nl45vXoARyVHCdKggx5QiEpZPY7?=
 =?us-ascii?Q?haaf9gDxeiyY1B5I6cd+kSDJsr4UayzHty1KQ3rXbaC69YgN+Ui3KcvbQUzd?=
 =?us-ascii?Q?VlCJo7IR/1J8bSyIyAV+VnfqTwQbTG32y1YuSdoR/8FBWplRjuvP7cIAiNGL?=
 =?us-ascii?Q?dQCnTZ2REZeH/vO32zqvTTrrA+DbrcYXA4ri/CEHRG0aY7AZ0+0dqKYe0ES8?=
 =?us-ascii?Q?Wc1XCeAJ0e8o8qfv80sI4HY7etqpU1aOPY9784aZRRFHj5grgfPnUfWZwY1k?=
 =?us-ascii?Q?9ZbX8AbTOy6qvolj977IN6MgpbeNcgxsZDi1RK6tgBIEVNRFnc9MlvU6bYf1?=
 =?us-ascii?Q?uNHdhrZEvHBDaY85YDAb14AsVhsu06clf+WCk4l+aSID0Cr6Vj1fLvXQKRTR?=
 =?us-ascii?Q?9/3aVlIyp6+iTLCQkaSbAfJYW2orhkeUxKaZR3r8BOVvtlVWR+CMRAkp4NgT?=
 =?us-ascii?Q?SwNBu052uJv6xh8YTtIi4YULzN8/dtc8ZqKc1concgrXs4Q52ws1Y/PoWcZE?=
 =?us-ascii?Q?m7aPMTIIWqNxWdTEU87dHZVK6KvO6+p/16md4JVpK4X3KDT3pG0VE1qRO5Se?=
 =?us-ascii?Q?Oxof2VRS5VQ4WfO+uhug9vvxDokJo5qS7jqwNFCVs9UgFv8K2J1OW3jfG7PK?=
 =?us-ascii?Q?1wohuqNkAnhbNqARfkQqhK2V8seTjLvPv405z4fsN1eNhKN45hZyVbESbV7K?=
 =?us-ascii?Q?Hk8Wideh7vJBxTrfN2I97CLxY/CE79UMCWRTdQLRpkDkQLTQktTsfIwXt6eg?=
 =?us-ascii?Q?pQCqy7AwFicGx6bdEpAw2Z2JAUoRQqRE+FChXkPdnqdhw6TdBz2w836xNZ5c?=
 =?us-ascii?Q?wnpcQ5ZyJxfjEsJ1V3qN0R0XP/IXZzmd/jtUEpiaq9kZ/tbPpjB+zCWbRys4?=
 =?us-ascii?Q?XL8cLDAhiLVWz5F2QQ7JBvh2T775A/X+VJbfukkCGQxI+oV2qbg0HfCqDT8I?=
 =?us-ascii?Q?4Ngf0lyZf0wlLYjpUjy0hVMJ/2g1WOZxuslensqRdXaMynmhGvMJV69za1ER?=
 =?us-ascii?Q?d7fG3oC5OIfKnzbUqEoHCnqrLuDBBrQktfKng7K2ykA9BTSzoM3RnE+w5/jU?=
 =?us-ascii?Q?5hUV7pu4i+vS/KP+HhHhxs9d/L0f3Vc2YSkykz0rKiw2PemOykDtNJS/5X3X?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f24d49bb-5a19-4002-79ed-08dc0d6259de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 20:18:44.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3mct+XVNswJ6mRiurrSzDAUSl7/RUNHKA650PdDwk/98m4gQCw2KmB+h32gWhehQvkPCjf++/1MfyrNaETLSLBp4c8sHaD2mijowoLYKrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6448
X-OriginatorOrg: intel.com

On Wed, Jan 03, 2024 at 12:48:10PM -0800, John Fastabend wrote:
> Maciej Fijalkowski wrote:
> > Currently when packet is shrunk via bpf_xdp_adjust_tail(), null ptr
> > dereference happens:
> > 
> > [1136314.192256] BUG: kernel NULL pointer dereference, address:
> > 0000000000000034
> > [1136314.203943] #PF: supervisor read access in kernel mode
> > [1136314.213768] #PF: error_code(0x0000) - not-present page
> > [1136314.223550] PGD 0 P4D 0
> > [1136314.230684] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [1136314.239621] CPU: 8 PID: 54203 Comm: xdpsock Not tainted 6.6.0+ #257
> > [1136314.250469] Hardware name: Intel Corporation S2600WFT/S2600WFT,
> > BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > [1136314.265615] RIP: 0010:__xdp_return+0x6c/0x210
> > [1136314.274653] Code: ad 00 48 8b 47 08 49 89 f8 a8 01 0f 85 9b 01 00 00 0f 1f 44 00 00 f0 41 ff 48 34 75 32 4c 89 c7 e9 79 cd 80 ff 83 fe 03 75 17 <f6> 41 34 01 0f 85 02 01 00 00 48 89 cf e9 22 cc 1e 00 e9 3d d2 86
> > [1136314.302907] RSP: 0018:ffffc900089f8db0 EFLAGS: 00010246
> > [1136314.312967] RAX: ffffc9003168aed0 RBX: ffff8881c3300000 RCX:
> > 0000000000000000
> > [1136314.324953] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
> > ffffc9003168c000
> > [1136314.336929] RBP: 0000000000000ae0 R08: 0000000000000002 R09:
> > 0000000000010000
> > [1136314.348844] R10: ffffc9000e495000 R11: 0000000000000040 R12:
> > 0000000000000001
> > [1136314.360706] R13: 0000000000000524 R14: ffffc9003168aec0 R15:
> > 0000000000000001
> > [1136314.373298] FS:  00007f8df8bbcb80(0000) GS:ffff8897e0e00000(0000)
> > knlGS:0000000000000000
> > [1136314.386105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [1136314.396532] CR2: 0000000000000034 CR3: 00000001aa912002 CR4:
> > 00000000007706f0
> > [1136314.408377] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [1136314.420173] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [1136314.431890] PKRU: 55555554
> > [1136314.439143] Call Trace:
> > [1136314.446058]  <IRQ>
> > [1136314.452465]  ? __die+0x20/0x70
> > [1136314.459881]  ? page_fault_oops+0x15b/0x440
> > [1136314.468305]  ? exc_page_fault+0x6a/0x150
> > [1136314.476491]  ? asm_exc_page_fault+0x22/0x30
> > [1136314.484927]  ? __xdp_return+0x6c/0x210
> > [1136314.492863]  bpf_xdp_adjust_tail+0x155/0x1d0
> > [1136314.501269]  bpf_prog_ccc47ae29d3b6570_xdp_sock_prog+0x15/0x60
> > [1136314.511263]  ice_clean_rx_irq_zc+0x206/0xc60 [ice]
> > [1136314.520222]  ? ice_xmit_zc+0x6e/0x150 [ice]
> > [1136314.528506]  ice_napi_poll+0x467/0x670 [ice]
> > [1136314.536858]  ? ttwu_do_activate.constprop.0+0x8f/0x1a0
> > [1136314.546010]  __napi_poll+0x29/0x1b0
> > [1136314.553462]  net_rx_action+0x133/0x270
> > [1136314.561619]  __do_softirq+0xbe/0x28e
> > [1136314.569303]  do_softirq+0x3f/0x60
> > 
> > This comes from __xdp_return() call with xdp_buff argument passed as
> > NULL which is supposed to be consumed by xsk_buff_free() call.
> > 
> > To address this properly, in ZC case, a node that represents the frag
> > being removed has to be pulled out of xskb_list. Introduce
> 
> hmm it looks like xsk_buff_free() called by __xdp_return would
> pull the frag out of the xskb_list? Or am I wrong?
> 
> Then the issue is primarily the NULL handling?

Hey John, as you see later on it is also about adjusting the size within
xdp_buff that comes from xsk pool, in case when offset is not bigger than
frag size.

> 
> > appriopriate xsk helpers to do such node operation and use them
> > accordingly within bpf_xdp_adjust_tail().
> > 
> > Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com> # For the xsk header part
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  include/net/xdp_sock_drv.h | 26 +++++++++++++++++++++
> >  net/core/filter.c          | 48 +++++++++++++++++++++++++++++++-------
> >  2 files changed, 65 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index b62bb8525a5f..3d35ac0f838b 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -159,6 +159,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
> >  	return ret;
> >  }
> >  
> > +static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> > +{
> > +	struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
> > +
> > +	list_del(&xskb->xskb_list_node);
> > +}
> > +
> > +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> > +{
> > +	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> > +	struct xdp_buff_xsk *frag;
> > +
> > +	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
> > +			       xskb_list_node);
> > +	return &frag->xdp;
> > +}
> > +
> >  static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
> >  {
> >  	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
> > @@ -350,6 +367,15 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
> >  	return NULL;
> >  }
> >  
> > +static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> > +{
> > +}
> > +
> > +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> > +{
> > +	return NULL;
> > +}
> > +
> >  static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
> >  {
> >  }
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 24061f29c9dd..1e20196687fd 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -83,6 +83,7 @@
> >  #include <net/netfilter/nf_conntrack_bpf.h>
> >  #include <net/netkit.h>
> >  #include <linux/un.h>
> > +#include <net/xdp_sock_drv.h>
> >  
> >  #include "dev.h"
> >  
> > @@ -4096,6 +4097,42 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
> >  	return 0;
> >  }
> >  
> > +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
> > +			  skb_frag_t *frag, int shrink)
> > +{
> > +	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> > +		struct xdp_buff *tail = xsk_buff_get_tail(xdp);
> > +
> > +		if (tail)
> > +			tail->data_end -= shrink;
> > +	}
> > +	skb_frag_size_sub(frag, shrink);
> > +}
> > +
> > +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
> > +{
> > +	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
> > +
> > +	if (skb_frag_size(frag) == shrink) {
> > +		struct page *page = skb_frag_page(frag);
> > +		struct xdp_buff *zc_frag = NULL;
> > +
> > +		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> > +			zc_frag = xsk_buff_get_tail(xdp);
> > +
> > +			if (zc_frag) {
> > +				xdp_buff_clear_frags_flag(zc_frag);
> > +				xsk_buff_del_tail(zc_frag);
> > +			}
> > +		}
> 
> Should this be fixed in xdp_return instead of here? The xdp_return
> is doing what xsk_buff_del_tail() does. If we also called clear_frags
> there could this be simpler?

xsk_buff_del_tail() only deletes node from xskb_list and xsk_buff_free()
in the will call xp_free() on frag being deleted.

I think I would be rather leaning towards adding xp_free() to
xsk_buff_del_tail() and skipping __xdp_return() call from ZC case
altogether...

> 
>  if (skb_frag_size(frag) == shrink) {
> 	struct page *page = skb_frag_page(frag);
> 
> 	__xdp_return(page_address(page), mem_info, false, xsk_buff_get_tail(xdp));
>  } else {
>    __shrink_data(xdp, mem_info, frag, shrink);
>  }
> 
> the return will need to have an unlikely(!xdp) to guard the case it
> might be NULL, but also not sure if we would ever expect a NULL
> here if MEM_TYPE_XSK_BUFF_POOL so you might skip that unlikely
> as well?

In that approach you would xp_free() the frag being removed but it would
still be dangling in xskb_list that first xdp_buff carries. Some
adjustments would have to be done within xsk_buff_free().

Regarding the NULLness of zc_frag for MEM_TYPE_XSK_BUFF_POOL that Martin
also brought, you are right, I went too far with this, I misread what
kernel test robot reported :) so on monday I will look into this.

> 
> > +
> > +		__xdp_return(page_address(page), mem_info, false, zc_frag);
> > +		return true;
> > +	}
> > +	__shrink_data(xdp, mem_info, frag, shrink);
> > +	return false;
> > +}
> > +
> >  static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
> >  {
> >  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> > @@ -4110,17 +4147,10 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
> >  
> >  		len_free += shrink;
> >  		offset -= shrink;
> > -
> > -		if (skb_frag_size(frag) == shrink) {
> > -			struct page *page = skb_frag_page(frag);
> > -
> 
> And then I likely would avoid the helper altogether? And code
> example above just lands here?
> 
> > -			__xdp_return(page_address(page), &xdp->rxq->mem,
> > -				     false, NULL);
> > +		if (shrink_data(xdp, frag, shrink))
> >  			n_frags_free++;
> > -		} else {
> > -			skb_frag_size_sub(frag, shrink);
> > +		else
> >  			break;
> > -		}
> >  	}
> 
> I think the fix can be more straight-forward if we just populate
> the NULL field with the xdp_buff using the get_tail() helper
> created above.

I'll think about both approaches, the one you're suggesting and the other
that I wrote up above. Thanks a lot for taking a look!

> 
> >  	sinfo->nr_frags -= n_frags_free;
> >  	sinfo->xdp_frags_size -= len_free;
> > -- 
> > 2.34.1
> > 
> > 
> 
> 
> 

