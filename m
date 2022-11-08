Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5DF6210F0
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 13:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiKHMiy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 07:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiKHMiw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 07:38:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054974C273
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 04:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667911130; x=1699447130;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IsGHRMElrECpiDHDC4FGbX/bM04cNt0cHxoUIGu3RHQ=;
  b=m7dWvbk8ob9CWY0LlTvBlxh5/yq7nyUre63hXRFc6icx2YrHHg5NCYbf
   ZxWopN1I3y8AbeDg0M3pyhkA1UYywKjHs4wQj/uvd5eSekPoEiIXoMDPS
   yhdCnl3Yg7zwW+MxzRI51NFwA+1ENFFXnptJcvrhRmGS8dWZmw1usIMNI
   Q2dVBcAxvbj/fBO6CD0bOqatZhty82fFCx0viKGzzWwB/oVNrOd4WGydY
   dhGWozTaHI5B67mrZz7/tyoqpGYf3QP7YdbaNG3tXKyHm6HadpuitFcP2
   MHh7HeuCjv1Xz7T3L+GbgJ3DMTlTDbQ+H+3l3G2gYtqUGT2lM7kU/qyCK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374954461"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="374954461"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="630857841"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="630857841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 08 Nov 2022 04:38:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 04:38:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 04:38:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 04:38:46 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 04:38:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fmz4BZ6DNq3uUbO6dvckA7Mnzxrq52dB546PzWf+XE64X1ES3Txj7fU8Pg6WHgj6NoBKXEDREx7//lIT4ftb/s/T7SGi0WG5HIQ0hAIgueEUxxSGhIG7nTe4nmMR4A4FETsPP5sKsIyVme177ENgbL3lVsOiOcn1jdk7HEfZOCByOcqiT/q4YKifIYdgmP0U/mhYp5iqO8N8WdLhixvSct0P7RCmLRQSihS81hDRPIKbERH8XmYeGngv+FNQJlw+0s423Co22OCj7EUT/efoKlFS+1ZA17hJvE1Y6UuG2R3Eiy2V/8RI06wVbbO6h02Z/o+9pUyVSPwZjFfsjYeg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD9pJO6x/wEWpT8DgFwqZAWTs3VyGPhTB9T9HNjskfA=;
 b=It6bAmXbcHBonFsPeNvbUo/fTkVXRYAnBhuzDeSNIiqFIDBu5aiMsc2zvnnG4idEX3O7vYa9kA/yEb3EK8q1A2NTrG99/BZCdt3hkWcMUys4jfeDjvUsPIJTUKK6/VXle/tDIUyZPNmIPL2vt9EXI+AxTWIO7WWWxSS1VAsU81+R5yCcfTJ+UBLfsqlEtebSug6sDW31dFfs8J42nClopgIlueBAulhquyFr3QlR18YSEECTJSWHjVPeP96+C4SD91rDg1YYiOk0zo7sw8fewPjog/jxYRtHH9/+d3bZKLG+6TQzVMojnYyoHKYDsWUqC/R0dGHifcMukNJqxD5n7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM6PR11MB4643.namprd11.prod.outlook.com (2603:10b6:5:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 12:38:43 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e%6]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 12:38:43 +0000
Date:   Tue, 8 Nov 2022 20:38:32 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Song Liu <song@kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <x86@kernel.org>, <peterz@infradead.org>, <hch@lst.de>,
        <rick.p.edgecombe@intel.com>, <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y2pNyKmMnOEeongp@ziqianlu-desk2>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2o9Iz30A3Nruqs4@kernel.org>
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM6PR11MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f52818e-279c-4cb6-a526-08dac1862bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1B2omo50KCeJvLxbo1eR3Nwi5LznzCIiup+s0EEBDym5jubvG7QzM4tOwMrTazp5lFXcWoyRmMlZu07sXFRQ4f0Qd3d6Z/uRt9aBexOmWfo0lxmokt3JIdoTmwo2XWuT80CtHyK9SI2OlKl7BG0rahXUOEkylRFmmF6Jy9dWgmYlMYaCte5UVzmqQbQp7WM/goB+v2RMkJ11qvxDpCf0h1AxQuAw3HfLz+0xLTH1IVPYAeBLeWHoqlDIcW+eShZ7qkhdIr6pIYTOwHK2Nip8kVUfvUUbGRQWv/RNL7rWvEfL9/vSbG85nepEOnghkB9CiFK5rcosN3SH21lsEOQF/wY6VeUeBJqsLu5s7l1cYWO+7OFMyDLv75VZ+Fg1k1RWKVrAS/b4Z7A4xDhttRDBPyWwWOb6Oz56nSTGWHtk5gGcB6njIGtAeCa0Yb2IlrSHVKVI7YWncgz2lypworAabSNQCeYkUtNYEBNW4mMbWh1SkSqpE2nic5Mx/8521X4B1JbRgk4ErrP/iw9MOAVyTYa/of7viL7SkOW20inEJdgB1wvnVAw18mfWpnE/wCMmcV8zQk93I2vpicUJyAUCGcrJTPLLj0Zqm8WFFR4ukTnEbf61JHs/zTIpDa+sI5nXrDuoLKuDDWNdq43K+vjpTgr7JjMqYH7/9G5rsA5ht3/2spkKAbX/v8Xt1ll1EwnnV+wQB4lCN03v+NzHvBqk7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(9686003)(83380400001)(26005)(6506007)(6512007)(186003)(38100700002)(82960400001)(2906002)(5660300002)(44832011)(6916009)(6486002)(6666004)(8676002)(478600001)(41300700001)(8936002)(4326008)(33716001)(66556008)(66476007)(316002)(66946007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7iqnVLdpr82AB0lo6YT1RoGGsWBxnBGSHmAGCjoGD2TptQfp8aqQkZiqguH2?=
 =?us-ascii?Q?ebaEqI/+NYMwu8/7bE/lS0W6kt5BF86m8qBSOC7ds/8w2b9T70mYAtPq7byN?=
 =?us-ascii?Q?ar/HV53MROzHlc78YxjcdDfOkEEZTG4Nehy0lKRuTyhk+gC7vKHVpYebNp2B?=
 =?us-ascii?Q?wCJO8x6YskQu7U6HsShNcZCzb6qm59/poouFW4/TUjDN4EPvBaBwUnu0jQmp?=
 =?us-ascii?Q?ncgznlhBAxXbpdqy2DxU1r85LQGqJH0+g6621uKi5iUbrTB9lOjm4i2TUpPz?=
 =?us-ascii?Q?TjXoTzJ3jWNLc2xlbG8QoMbPYBwbODX6jjCZrFmZ6/WPl2I1optSp2x4RLO2?=
 =?us-ascii?Q?+Bp9uF0BzSHjcDqbfULXqx2D7QX6c+CInqoql0ZJET1kCQKleradKKlERjM/?=
 =?us-ascii?Q?9hvrfttARkz8eAo6YIVvSFgXa2/cLVL0ZWpDF5WuHsG3HH/YuYxihtaudQZ7?=
 =?us-ascii?Q?8uxM1BarY/tITbwOxkA+5IGmnfZubqg6ofsTTUcAqZjrpJQyvT/smBbW6QFT?=
 =?us-ascii?Q?9a4alERDIbbKiy5Tn9/cKIFhNQaw4GQ/ztBo/Ia+EA+jk3cZvkN34FZghkbq?=
 =?us-ascii?Q?w7FFENww+BT/A21YdOHEr4axylE7DTsYqYCzt/+OqUicdFXTYxLYeceAhH8Y?=
 =?us-ascii?Q?3klsLlgIJpr4X7662tFxGobzOtARH66vs49uikjhNTZLP6RlBiDxiYo2gvvo?=
 =?us-ascii?Q?But/c1JdI8qZC5hegl6awc5sTbMY16AoEQ1q8p8g5MxlrCErdygzG59R79FI?=
 =?us-ascii?Q?ZHfS5ERfdvJ5gyiTZpS0q0Vf34TY3yFtj6wNvH1cGzN+Q8zB2LnYEGK8tou/?=
 =?us-ascii?Q?eI15mzcMixy1TO83/2FxKcUuBK//TWFM2hNQMNCwTvrx+7ZDZYiJNPNmjJ57?=
 =?us-ascii?Q?PWUW7s4hxxoiu+PclW026UMiNsw3qTZ4PPTBJ4q/unbKLtPWEMTy9u1hL2mD?=
 =?us-ascii?Q?ScLbew3Sts87Fy6m0nnFb6iQa/zzxuiRSUBMpnUSoi4cZio0dATXnTEtuaKE?=
 =?us-ascii?Q?15v7GR68STq5+92K4CTS46tLKG01R/pX1U3GSLwOuFZEHQANLHR7zg7S6fYJ?=
 =?us-ascii?Q?XlOmPwB668LZE5rZOoNw7f8x8nvOr3lYkBHEg7n2B9iCmvP4EddJo2K65Cde?=
 =?us-ascii?Q?rDRWm8KhMqcAC/rch109R3D1zCMAbPLEsVO1bTIB3/2dT31C7x46RFpEJaUi?=
 =?us-ascii?Q?js0egsIq6Mq2vGOw9Dq1TiuJEHFOhFrnd7ni/kANWcgPit+phRln/59dgTqJ?=
 =?us-ascii?Q?fjX6+SPi/FcvCSsV55+vY49vLh7cs/aukCgeFKOcxsPdZHdbtIIlEgTH2uet?=
 =?us-ascii?Q?2Lwx3G5ZvXcyMadyiKhF5gPPH3mfHzn/P8xotIjdh3Wlb4KJPGwG9e6unenQ?=
 =?us-ascii?Q?X4C6v9l+ZHYLZx5Qb3JdNUEULTt5Wa9efuKwFQ35Ms++rJqAe+srcCSFlnIC?=
 =?us-ascii?Q?/cWpjricSED2WJMAibePQQ3CDLGVdz0ukFCebRBLgr/e3TVjTxH2mGqEpKWy?=
 =?us-ascii?Q?eQlA1hGfHg1r//zzVVWRhLYxM1mb/fbBUB7+9GMPB2Dtg4/I3kcsBcLOcvzs?=
 =?us-ascii?Q?1TzLZ9yCXcvVVT3hem6TCSPQVrl164WTVdWUJ//j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f52818e-279c-4cb6-a526-08dac1862bd2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 12:38:43.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orm+jTHylQrIzsrUCFgGazVHiJIW4TmlqAOIdgirJ1T8hYnS61VHPG0rvgNmfxEHd5+JVk60FPYPm7cvsJ7OgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4643
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Mike,

On Tue, Nov 08, 2022 at 01:27:31PM +0200, Mike Rapoport wrote:
> Hi Song,
>  
> On Mon, Nov 07, 2022 at 02:39:16PM -0800, Song Liu wrote:
> > This patchset tries to address the following issues:
> > 
> > 1. Direct map fragmentation
> > 
> > On x86, STRICT_*_RWX requires the direct map of any RO+X memory to be also
> > RO+X. These set_memory_* calls cause 1GB page table entries to be split
> > into 2MB and 4kB ones. This fragmentation in direct map results in bigger
> > and slower page table, and pressure for both instruction and data TLB.
> >
> > Our previous work in bpf_prog_pack tries to address this issue from BPF
> > program side. Based on the experiments by Aaron Lu [4], bpf_prog_pack has
> > greatly reduced direct map fragmentation from BPF programs.
> 
> Usage of set_memory_* APIs with memory allocated from vmalloc/modules
> virtual range does not change the direct map, but only updates the
> permissions in vmalloc range. The direct map splits occur in
> vm_remove_mappings() when the memory is *freed*.

set_memory_nx/x() on a vmalloced range will not affect direct map but
set_memory_ro/rw() will. set_memory_ro/rw() cares about other alias
mappings and will do the same permission change for that alias mapping,
e.g. direct mapping.

For this reason, the bpf prog load can trigger a direct map split. A
sample callstack on x86_64 VM looks like this:

[   40.602450] address=0xffffffffc01e2000 numpages=1 set=0x0 clr=0x2 alias=1
[   40.614566] address=0xffff88816ee1e000 numpages=1 set=0x0 clr=0x2 alias=0
[   40.627641] split: address=0xffff88816ee1e000, level=2
[   40.627981] CPU: 15 PID: 534 Comm: sockex1 Not tainted 5.17.0-dirty #28
[   40.628421] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
[   40.628996] Call Trace:
[   40.629161]  <TASK>
[   40.629304]  dump_stack_lvl+0x45/0x59
[   40.629550]  __change_page_attr_set_clr+0x718/0x8d4
[   40.629872]  ? static_protections+0x1c8/0x1fd
[   40.630160]  ? dump_stack_lvl+0x54/0x59
[   40.630418]  __change_page_attr_set_clr+0x7ff/0x8d4
[   40.630739]  ? _raw_spin_unlock+0x14/0x30
[   40.631004]  ? __purge_vmap_area_lazy+0x323/0x720
[   40.631316]  ? _raw_spin_unlock_irqrestore+0x18/0x40
[   40.631646]  change_page_attr_set_clr.cold+0x2f/0x164
[   40.631979]  set_memory_ro+0x26/0x30
[   40.632215]  bpf_int_jit_compile+0x4a1/0x4e0
[   40.632502]  bpf_prog_select_runtime+0xad/0xf0
[   40.632794]  bpf_prog_load+0x6a1/0xa20
[   40.633044]  ? _raw_spin_trylock_bh+0x1/0x50
[   40.633328]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[   40.633656]  ? free_debug_processing+0x1f8/0x2c0
[   40.633964]  ? __slab_free+0x2f0/0x4f0
[   40.634214]  ? trace_hardirqs_on+0x2b/0xf0
[   40.634492]  __sys_bpf+0xb20/0x2750
[   40.634726]  ? __might_fault+0x1e/0x20
[   40.634978]  __x64_sys_bpf+0x1c/0x20
[   40.635216]  do_syscall_64+0x38/0x90
[   40.635457]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   40.635792] RIP: 0033:0x7fd4f2cacfbd
[   40.636030] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 33 ce 0e 00 f7 d8 64 89 01 48
[   40.637253] RSP: 002b:00007ffddf20b2d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[   40.637752] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fd4f2cacfbd
[   40.638220] RDX: 0000000000000080 RSI: 00007ffddf20b360 RDI: 0000000000000005
[   40.638689] RBP: 0000000000436c48 R08: 0000000000000000 R09: 0000000000000000
[   40.639156] R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000080
[   40.639627] R13: 00007ffddf20b360 R14: 0000000000000000 R15: 0000000000000000
[   40.640096]  </TASK>

Regards,
Aaron
