Return-Path: <bpf+bounces-17531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8725680EDC5
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1482D1F216D8
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA661FCC;
	Tue, 12 Dec 2023 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeaLhBgD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DA783;
	Tue, 12 Dec 2023 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702388217; x=1733924217;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D3l7DjTzE2oKZOW3KNwkf29xJLX7KtAX9eyTOEBqz88=;
  b=eeaLhBgDoPQ1KnvyYJBuR7Bt3Q7ijJXdXK8y+wBdRsELNP7aCaULgijr
   dAqfv3gh+6BsQRUBZES8ThsPKq5l508QCpk7C8im0Xy4KgPSYSpGOZ0Vm
   +sSZuwHQQq2Y0Xn6Kx43PphLRyM80x6yj6gxyJ6BjzE7dbsh71YjBH8iu
   MajjkQKnFUg2TtWCSYVKxbU0UknJeqmxin/GwAdt2427seS7BjD2jzLRt
   LPuQRHYAxD+731kzDGCHVTV5qbdFxDoxe+IBCq4B3ADb9s2dWgbn70pZ/
   J1U1b5OhTyDXDyLiyXxsy6O2fhF1b5cakdNqaVh59WMqvkJCLCIrdB0Z7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481004483"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="481004483"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 05:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="807770159"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="807770159"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 05:36:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:36:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 05:36:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 05:36:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBn/XJ2paLVlZoJIm9cCfInBVtYWGLZkzLCBGPYHAhKhoWxGvdoxaxfCqbotQv2MQkMHIZvw/80VNOzMBLhI0nmVqSAOSaJ54Xrg9BVQrJlxj2P4a3SDFNIAuVlMVNDG34PvCUQQuNpOnzrlr2oRcyKkYW0EcpfoMWWqedHOAvoxcy53kFCGJY0m1kEFUzqgmIW2/tuIO391elDg+BrjwOIwjXPmyfOWkiJubyIx+W7LjE+/pJBczydwMtVDjaeJSDbCD9lRf2TgwPAQ1IDgXw9J2wI3nyuj3/onRSPMgfvFCaihvewXuqXlJPPv4jl80rDLg4Bz77mTH/wbBz48jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4khcyyaL6Krrw519HnNfqtCkyjAKdFjzZCnbjJPWE2g=;
 b=U0UjudAU6BWFswuH+/wX7vPiOmqrjUWEvoloigTl2SxbF/bcVctH6f5ypM42kCkC+rA0/hLadL2G4GU3Bnez/o/8D8SIlzrcdIFkA/yuDI0zoiWm441HZNCIGlpQhTw4I7KRbKtM4Qsz8LnxFNJM97dPKNyrpxVZvMbalYCiTCBShzd6JKeMCRVAvZOTmF1BMunX6GqXjSQN6JksKuFxiYbUuYqqLCKideZ0xSKkhu5gP4NIL6zAdXxyBXrM81Z08r7/S2S5c4mzBDrB/+nOB37snpkGjr8iCiFdNn6AMuFZygblOpfiWUjRZ3LkolwF8ulwL/GY+F3PE6TuJ6fqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 13:36:41 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 13:36:40 +0000
Date: Tue, 12 Dec 2023 14:36:29 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>
Subject: Re: [PATCH v2 bpf 2/3] xsk: fix usage of multi-buffer BPF helpers
 for ZC XDP
Message-ID: <ZXhh3U9ZykgN+BGi@boxer>
References: <20231212125713.336271-1-maciej.fijalkowski@intel.com>
 <20231212125713.336271-3-maciej.fijalkowski@intel.com>
 <CAJ8uoz2MAquu8yMgyNAubFB+uj+Dk0jSwwr9GmngK6YTM6sH6A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz2MAquu8yMgyNAubFB+uj+Dk0jSwwr9GmngK6YTM6sH6A@mail.gmail.com>
X-ClientProxiedBy: WA2P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::27) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: ed500627-a893-46cd-f925-08dbfb175f65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcJ8Ui9ZHiBANHsIjYlyGFVvz5ZlbpYiJvaUkDxvumbrlG5pJvaWA01GIgrflOBh0BYSKbXXwwL/z6wkduVbup3dIa9+wJAk+3wHhzopDPERMj0L9s9fIdLEJwibCxodOWGSGNebhjG6uzp8dg/6S+bsY40S1/eUaMp0u6rwq+0PkBXxrAwasyCtqDdbuFZr41rUNGo23zUNLFHYfq0Ijlnr+TM3+Q056w2Qp7i0pG99B1+9O19gKA6bWU2zF0mqZgZvcLyWAEQ4/RJAWq78WV5lDO8w6xC46GXvaJFE69V6HvfxqGTcBFGngZm0L2lOF2HS/NEFlCzxk3AhyZv2Jb7mGVKbf4aFL7GGpI8CD+4/ziWnXLrmjzVDIkkzibJDCcWDabw4lqs263038SPzce18xdVVHwqSZzer2/mzFFm6lf2raBx4TqB9PWM8Oa6hGM7NEVB26wWahxf4iKAKL3hOxbRvTq8TQVVnOX/I3I4CGIlalWtiktAdE0wRBGAEuXcGFnXkbPOybarvFjD+Ngbygzmsp72p/a3HAYB781c/KOFD/pvHfPkxOlwVLxYDrSVKfnHnvMVZ4Zp3hPXN9VXytlxkFWeYSnUAv8uBtgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(38100700002)(2906002)(44832011)(5660300002)(316002)(4326008)(8936002)(33716001)(66556008)(6916009)(66476007)(8676002)(66946007)(9686003)(86362001)(6512007)(82960400001)(478600001)(26005)(6666004)(83380400001)(6506007)(6486002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWPuCbUpAzzKqmvUF0GUoS1m2u6zs8Rsv5bfmS/A5NvUaHyL1f/nkChm3ORm?=
 =?us-ascii?Q?jdsTdHGqmTXXyZVwsvCI9zai3iAunU1OQQLochG2e65mpKxuCQQB6KP9J9ld?=
 =?us-ascii?Q?SOqkVeBITvd2ZDbLtGoQK8JIB3SwxE9DmOG+gokUeECWfRsniJAWaVwNUeSo?=
 =?us-ascii?Q?rIiGw6Fy4blLp4NX/NnLWUfEAxfUDMZbq9xhzdCOdjMFx+lBexAxjRGlkpnO?=
 =?us-ascii?Q?tYPjYuTxmdI0iqVc6afPBbF7lfNOO1ARgSZch3z7ip1J+vtp1rhxhGKNCXbN?=
 =?us-ascii?Q?nbuqJZ5LP2+7Wvtqbnyqgj1/Qm43miUyQ/hka7G0O3VtFUMjottOCvha5mJ/?=
 =?us-ascii?Q?i+OYKe/O0Tk//0UXfUrVyXjNaGNcLsPv1vgfk0Ks23I/1Lv5e9zaDMkS7+0r?=
 =?us-ascii?Q?aTBgbwv6BQNxRvLhp1J23F8+yi2CnrTIhfcLk4rCITu5hgqX+i0KUAiKpGFI?=
 =?us-ascii?Q?YBUNS+LnErjj2ncOmNhwWRNEYX8W9WX3Y74vIqiUIF9KjOUlxariJvTcVmmz?=
 =?us-ascii?Q?CHhIurBSAxTm23HCglmemQhiCcVKZsa8yRJV4ayuyy8/LC5/IZYqisf2I11b?=
 =?us-ascii?Q?7Ytfuci6dqOzXtEY2E33Xmg5+XZM2yrFCpoEKocFDCNPJbfPGMdpMXtMDi8S?=
 =?us-ascii?Q?c943ZZ7iRvIIjxe4FzVMhFZZcraZL8MLrwo+3gJJva6dcRcF6BZpBvi4eu90?=
 =?us-ascii?Q?M/LnAaSbJ99madV/o0cWiZrKFNbyLwdbOcZJlfHa6dk7S6LPHQ/VGiOziOFa?=
 =?us-ascii?Q?mTNAoM/FkzViofa+AMIFU45C5q4EruoBOl9YEWcoqLY4FDLs/RpzvU+oSY8/?=
 =?us-ascii?Q?5UVT57oJ8FmMCIe+3CnOIOl63baShwYRKkZ8AGP2rKN8BNCyhg4PER2bhuEH?=
 =?us-ascii?Q?fHHHwNR5hiNwswi98l9MuVUPTsHzDGTBmDHmfRfDllBV7CdVo3S8TmZ0gcaS?=
 =?us-ascii?Q?ppP7gMe6PV7v7lQpvuDAtnJ4+MyrTLtjd8OEUyPSFY+1DC5WMOonG40dMJWF?=
 =?us-ascii?Q?vi1YmiiZTMzXeMX9mzNpHav76Tw39nt6c7rSFInVOlW6+aFcgdnr2mXMJ0Xt?=
 =?us-ascii?Q?Wwugp/DJh2Pgwc/WpE8OKDTmoLF1p9kHJ+h2L326iXjYKK9EoiftYQlRvpbg?=
 =?us-ascii?Q?BSphhGtyU0ELjurwX4BYuOGfbwM+voPdIyoTxj1VWL8AKlIHrzFIdLY4x2X5?=
 =?us-ascii?Q?AbfLYvnAJGTLzxYJassTiDG20tGxxschgm8PDEA1TEJ6lVndDPpydtAAO6nC?=
 =?us-ascii?Q?ZzJ4YVZPyRlwnMMXugB0A5vcQ3ZxJmuwHNlrU94n0l0++t5cmWEa0gEvnkO7?=
 =?us-ascii?Q?zHMjCPztQjf9lU+fhtA0cz4nTUxZht+p/GJkBd8GgCr0qYryylcqVqQTH+H5?=
 =?us-ascii?Q?aUE+VnoUXEMiCCGt4hc1ldMAC7l9k+Uw8nqjptnL19RRpnjpywavcIW5/3Xy?=
 =?us-ascii?Q?BUzPYeLItYbfE1EjyTW1CiCx/VKChDIuOJvdatBVud3JCQdp0jyNIpEm+TLp?=
 =?us-ascii?Q?IwjXA9QYbKny6czie4PUuYdj6lJfJnf2E3nkKnLPpIPeMF+YO06mxGK1ituM?=
 =?us-ascii?Q?URs5VkFm37rOOLpZSpGKjYGnELG/hHFVLI+ssRoVS5TtTc1FxugnTC6+h5iU?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed500627-a893-46cd-f925-08dbfb175f65
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:36:40.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHcVF+fAq7xoCGEYASvT1vrHB/m52CcSh8jIk/yWJGsZRrDK/z8qx6PPB/Vmbji9YGAsaNOSwL9Wqv/8v3wK91vzKVHQ3Q8J4f2GQWzgebk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com

On Tue, Dec 12, 2023 at 02:30:50PM +0100, Magnus Karlsson wrote:
> On Tue, 12 Dec 2023 at 13:58, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
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
> > appriopriate xsk helpers to do such node operation and use them
> > accordingly within bpf_xdp_adjust_tail().
> >
> > Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  include/net/xdp_sock_drv.h | 26 +++++++++++++++++++++
> >  net/core/filter.c          | 48 +++++++++++++++++++++++++++++++-------
> >  2 files changed, 65 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index 81e02de3f453..123adc6d68c1 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -147,6 +147,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
> >         return ret;
> >  }
> >
> > +static inline void xsk_buff_tail_del(struct xdp_buff *tail)
> > +{
> 
> I think it would be easier to remember function calls if we are
> consistent in the naming. Most of them are _verb_noun(), so I would
> call it xsk_buff_del_tail().

Sounds good. I can address that once I'll be sure that bots are happy.

> 
> Apart from that:
> 
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com> # For the xsk header part.
> 
> > +       struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
> > +
> > +       list_del(&xskb->xskb_list_node);
> > +}
> > +
> > +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> > +{
> > +       struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> > +       struct xdp_buff_xsk *frag;
> > +
> > +       frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
> > +                              xskb_list_node);
> > +       return &frag->xdp;
> > +}
> > +
> >  static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
> >  {
> >         xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
> > @@ -333,6 +350,15 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
> >         return NULL;
> >  }
> >
> > +static inline void xsk_buff_tail_del(struct xdp_buff *tail)
> > +{
> > +}
> > +
> > +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> > +{
> > +       return NULL;
> > +}
> > +
> >  static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
> >  {
> >  }
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index adcfc2c25754..8ce13d73a660 100644
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
> > @@ -4075,6 +4076,42 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
> >         return 0;
> >  }
> >
> > +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
> > +                         skb_frag_t *frag, int shrink)
> > +{
> > +       if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> > +               struct xdp_buff *tail = xsk_buff_get_tail(xdp);
> > +
> > +               if (tail)
> > +                       tail->data_end -= shrink;
> > +       }
> > +       skb_frag_size_sub(frag, shrink);
> > +}
> > +
> > +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
> > +{
> > +       struct xdp_mem_info *mem_info = &xdp->rxq->mem;
> > +
> > +       if (skb_frag_size(frag) == shrink) {
> > +               struct page *page = skb_frag_page(frag);
> > +               struct xdp_buff *zc_frag = NULL;
> > +
> > +               if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> > +                       zc_frag = xsk_buff_get_tail(xdp);
> > +
> > +                       if (zc_frag) {
> > +                               xdp_buff_clear_frags_flag(zc_frag);
> > +                               xsk_buff_tail_del(zc_frag);
> > +                       }
> > +               }
> > +
> > +               __xdp_return(page_address(page), mem_info, false, zc_frag);
> > +               return true;
> > +       }
> > +       __shrink_data(xdp, mem_info, frag, shrink);
> > +       return false;
> > +}
> > +
> >  static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
> >  {
> >         struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> > @@ -4089,17 +4126,10 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
> >
> >                 len_free += shrink;
> >                 offset -= shrink;
> > -
> > -               if (skb_frag_size(frag) == shrink) {
> > -                       struct page *page = skb_frag_page(frag);
> > -
> > -                       __xdp_return(page_address(page), &xdp->rxq->mem,
> > -                                    false, NULL);
> > +               if (shrink_data(xdp, frag, shrink))
> >                         n_frags_free++;
> > -               } else {
> > -                       skb_frag_size_sub(frag, shrink);
> > +               else
> >                         break;
> > -               }
> >         }
> >         sinfo->nr_frags -= n_frags_free;
> >         sinfo->xdp_frags_size -= len_free;
> > --
> > 2.34.1
> >
> >

