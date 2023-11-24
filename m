Return-Path: <bpf+bounces-15787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA14B7F69E5
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 01:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2237B1C20BBE
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A24659;
	Fri, 24 Nov 2023 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCWsY2Uq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD1DD73;
	Thu, 23 Nov 2023 16:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700786465; x=1732322465;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=vyxEMVywhMjY+t+bSw8vwJK6A4OwhlpwYtB95/0yRuI=;
  b=NCWsY2Uqri3pBzZlmzQkeEEbDHbaH8s9/gHhFSOSgEQCQ0wyxXffFopT
   CcEyPkXYSLraCvY6fb1x/GKH6Ic6do0esoyV1g56KJR5s0lI2mkkhL3du
   ZAWK/Otq/lA/2HNw1706xX3Y406xouMU4PyaPhyG3t1lmTj+59djZmdel
   42tm2rJaFkJyITIvmwrSZXg26MbGkmafXDxKWczvnWuuWBpB7eoxoSi5N
   euWuZhRNQx+mCFkaoJ2D2x+wNi3SAvx5FmyOKEMxWnUy4txRqmsDI9v3a
   j174CHrur1KF1gAb/Hro7PdWkfNzq7hfaQRTTXRs1soaQ4bycln9qJP+J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389498401"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="389498401"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 16:41:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="796443100"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="796443100"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 16:41:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 16:41:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 16:41:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 16:41:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0XGhD2qriomyfEqNCYGrOOwQnuagy1GT3/b5eo9Om1oiT1VpkmlPEdlYpQETyKzXYqqCMlAet6PNGSpIvMTVeMpOLq8fO8Gn5SJrWFkkxic32bH3bTS0LglfyM/uym5bPQa5jLu0uWdnREyHC0p0cwH4k6kyNwbnc086ecLPJBtxy2jAnf/Ysp+1sKLYHZEHfTYYjqaRt2D0Ax6tJA0cb4cCqrOLzwyLS1+MaiQepQEss3gMOjSIohlE2GsVDkSCFlPRqfeFHLJdn0wdGzjD7o0lkdO5reP1W0h9ZoDa+fM3nlsaOPJIpbp/eToNP/0AeqTYvVwewoM38UUWcxQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7hzeaBXK5+uR7wPcl6hOYOFIAnRP3Vcs6xEKtmyTwk=;
 b=iL5ZOajahL/ZKtlEaok5rE2oGxWQYBqUPq3cESsz2yIW5ismDuGtI+JdWqD5Ami0yniwbZDwtEg3L/bziznPSzWkiz44PWM6FOI8b1Et3kRTMlniex9ZkQviPGYqBeBn+ExcerODANhDUi5ZO91tyQ0B20Iz8NGMC9Cx/2/+VYD8JTcUWWBaE/kkFFSUlQpqbPg5BObegwXQmQWpJEmMFQBWTSw7SstoTPC5LLTTsdlv8SCFG3U4GvAyZIKlSPIzqWmgOfE5cGQhBF9rc46n8Js4gSD0czQeC9tUHnL0zI4Zxh31o/BCkuONJ19yUP1C8D+zXumSCB8U+VcRXk3Yog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8499.namprd11.prod.outlook.com (2603:10b6:a03:578::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 00:41:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Fri, 24 Nov 2023
 00:41:02 +0000
Date: Fri, 24 Nov 2023 08:40:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [bpf]  f18b03faba:  stress-ng.seccomp.ops_per_sec
 -2.0% regression
Message-ID: <202311231458.61e2502f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc6f552-8778-452d-0a00-08dbec86084a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUafct/St5o0unfWjO9uydfEg1OruSyb1U+hXzDPBkz0+7vISzEazvvNujZfBaIt6SgfWavdreV146ooZ5KKEk1ifiHKHY5XWOilT17U+eLGwf7eL/4VxSTJIKyFSmxSgSOA2tTF9OyJHKz7Qg6ENPlxI1ZM85vGGXGkh2tS9HrP2M8dzyFXdKt9UOPeNnmJNn1D5F4VFfUMtqokXKeLXDfyS29ntjI/RC2IbxXh5S7FxcpKGH5tm/V+BQqcKgYUQ/H9Q/1+TV7duhaqK0dMLGDGAUmlKp/bBdbRQn80X1gKbUVmN7XK+qoxnZJHQdd5rrREuTmgpZRFt3njjcrvj0E9A44k+QBbTo6ess0L83GvA8V78wYP/mDn1/8h+vvj4bUSeKEzWZjeD0DfaWN2tjwzSUIG617f2zz02e1QXv6STPNjTxy9mK9sDdjzVdUwTQeBnfh/0HRamh0v9AeyXzEQqiPNU7ngMdQWPzbBSp6oKmsbgMCMyy+oTVCLvo1SZSvlzaBl2aDkB7Y2cwAaHxPDldrUXdMqaG231/JxqPah+p55LpAI7I4qrGQb9EAEHTNgGIh/NEkONlynqzjarGgrm5oi1pJIgjD3pPiatfOfe1yq+844B0BNDqluRqVS6P4zHzHDWMW9MkCt7s+t+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230373577357003)(230473577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(36756003)(41300700001)(5660300002)(86362001)(2906002)(82960400001)(6506007)(26005)(6512007)(2616005)(107886003)(1076003)(6486002)(966005)(83380400001)(478600001)(6666004)(8936002)(38100700002)(66946007)(66556008)(66476007)(316002)(6916009)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aqrCwlKnMB3q5RWgRX0jH4jYzfpVnjj/pDgurzR7xjuwzTAI4AW0AfMxQS?=
 =?iso-8859-1?Q?/kp3uqDd6gtprQNuAxrlJA1VxYXsYvk5wX1dXybIHdpVtGZENFixX2ylMG?=
 =?iso-8859-1?Q?xhuRhOqB0ITHS1S78oCvO6O4xWmCgX6KmrwZZU7M+bZP6zzuGsD34rEd6n?=
 =?iso-8859-1?Q?Ix0tEZIvGpSDy0fQj+1jMe4m5l5AdTxKRxF3XNANmCyXrhveA7Ht+iuFsL?=
 =?iso-8859-1?Q?gmnVU8bmK7RNAnSkP/wqeq4yQg2c9wKosygI6xCHAvQRCI6fx5ELcPpWqE?=
 =?iso-8859-1?Q?M9SO+LbYEl3mRCWFvHs94huoX7Co4PzAqscmUffngqCYgB2s6iR7qWyL3a?=
 =?iso-8859-1?Q?tVPLJpn4Y8GS9eD5FHLlB3vprSD0in5gMbLZcWxRgzc5Mbpg5YezGU2yWE?=
 =?iso-8859-1?Q?8z5Zk09fmPkHIyLfrgN5+XSDMGpKFGFLwmYxiRri5/jj5x5W5BmZzNMFpI?=
 =?iso-8859-1?Q?4JxWeURaTUYXdue4dpMdVUZvpsGzTaCXpq4cJ9/dyN9GY8L8g3dh+UqAIR?=
 =?iso-8859-1?Q?CiiCNNlxsuzCrdAkJLamaABLWAfk0UoKZJE+GfHolKHRjN5wBSnunrXh5O?=
 =?iso-8859-1?Q?Uwsa7wk2gF8bCfSrQeVQDfEI6wrxImbhtfVulkTKQtDJi6qAHODoewCrhi?=
 =?iso-8859-1?Q?HYTC7zba4huK++v0+tlC3jMtoWOnPncXhdiOPuoNrUuPy0VMhnY7fhCs/F?=
 =?iso-8859-1?Q?zs8/MDTbgM5z7jyOuNgjm354U1GkNJ1cm9U92+UVmGv72KnaWk8HaB1ALU?=
 =?iso-8859-1?Q?cy0lMmjEZX4/7AehM3ZCYYyuiM6z+kzg5IoROe/NKCLxpw+aIbMOkm/id3?=
 =?iso-8859-1?Q?h6uG9RFG2pAJdy43/0f0kAHHNHV5wO1yDkkoV9xtc1U+kQHYviy/qdF6jO?=
 =?iso-8859-1?Q?WL1ZaHgFHzoiw6ka3mUt87LadBp3O/ygCxM0x7sODRQsTsD2j9OUajUIA/?=
 =?iso-8859-1?Q?6bE1WX7ylEz6kvjaER442xKyrWThgsBVSc64tlKQOLhO3PAlolM6ThkUIG?=
 =?iso-8859-1?Q?govnkHiiTL4kbTTaTTHyoDiFCmoIHd73TkM6cp4qYAV7b36Qeg/jj6LtEo?=
 =?iso-8859-1?Q?oIpPIOaGH8NUj8zwwrP/uCK7G3f9n4jOpNCNvUO+CUrc79YHCddyjnd5Mo?=
 =?iso-8859-1?Q?+Y3JFATa+VU5s7mVdlunAAx/SnVkmJnvT9IofXJyTu4JSh/7hZdoNX/siU?=
 =?iso-8859-1?Q?5qc5NdX+09qd3nXavLPPiqpAVFuVun991wx+9mZH/ZW1CKyTQIFD25m3rd?=
 =?iso-8859-1?Q?/3bvV7yeEslNcfw4bM0dMOwAZ5mkN6Q1EqlWWRVTbV9qvvnTFQ2Xz9cRxK?=
 =?iso-8859-1?Q?0szYhjIwIsfdV5Qd4D83mgz9c6bW5lMOKokBh7u6JhsBmx17Uoq5nMZ6Pc?=
 =?iso-8859-1?Q?RH0y9BkrGSYRxNqrhbY9EqTuyCKMmT9E1vKnRGUBTFxDXZZ4GVWrYO+VUr?=
 =?iso-8859-1?Q?K61f82fzYZWrTHj8l46BX7wPEXZ7lYm5wMzrIAnYan/ULfQ/Xwy6znUvV+?=
 =?iso-8859-1?Q?knuGLBoPgeWIKQ25x2xM+SW4+q6wuHWR5Yad7c+Cx1IreA6W/ZSK2kzzIL?=
 =?iso-8859-1?Q?gGhLLl+E/8x+vi3/NKcRR+VkM/tkll/miYSDvPFvsqCalnfAMDEn/DARGn?=
 =?iso-8859-1?Q?ivxC6r7aEDJAGOLsBMyMdoRnKHsr3nLPyaJoq+gaCLudZvmoNKluvkrQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc6f552-8778-452d-0a00-08dbec86084a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 00:41:01.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSIJ+zdVucL6LvrumDQ2Q9hLx+hKPWy9SLeS1HQ1+1ZZ/U30X1adm+M6YgHFUDGRChg1m7cRaCilPu9/v28NLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8499
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -2.0% regression of stress-ng.seccomp.ops_per_sec on:


commit: f18b03fabaa9b7c80e80b72a621f481f0d706ae0 ("bpf: Implement BPF exceptions")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
parameters:

	nr_threads: 1
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: seccomp
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311231458.61e2502f-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231123/202311231458.61e2502f-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/seccomp/stress-ng/60s

commit: 
  335d1c5b54 ("bpf: Implement support for adding hidden subprogs")
  f18b03faba ("bpf: Implement BPF exceptions")

335d1c5b545284d7 f18b03fabaa9b7c80e80b72a621 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     13890 ±  7%      -9.4%      12579 ±  3%  turbostat.POLL
      0.01 ± 13%     +48.4%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ± 11%     +70.3%       0.01 ± 16%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.78 ± 23%      -0.2        0.55 ± 11%  mpstat.cpu.all.irq%
      0.05 ± 17%      -0.0        0.03 ± 12%  mpstat.cpu.all.soft%
      2.39 ±  8%      +0.3        2.65 ±  2%  mpstat.cpu.all.sys%
     27256            -2.0%      26712        stress-ng.seccomp.ops
    454.26            -2.0%     445.19        stress-ng.seccomp.ops_per_sec
     54565            -1.9%      53516        stress-ng.time.voluntary_context_switches
      7.07 ±  4%      -1.7        5.36 ± 11%  perf-profile.calltrace.cycles-pp.emit_mov_imm32.do_jit.bpf_int_jit_compile.bpf_prog_select_runtime.bpf_prepare_filter
      6.01 ±  5%      -1.4        4.64 ± 10%  perf-profile.children.cycles-pp.emit_mov_imm32
      0.21 ± 15%      -0.0        0.16 ± 15%  perf-profile.children.cycles-pp.mod_objcg_state
      4.91 ±  5%      -1.0        3.90 ± 10%  perf-profile.self.cycles-pp.emit_mov_imm32
   3921440            -2.3%    3831836        proc-vmstat.numa_hit
   3921405            -2.3%    3829327        proc-vmstat.numa_local
  19214848            -2.1%   18810333        proc-vmstat.pgalloc_normal
  19165012            -2.1%   18760451        proc-vmstat.pgfree
    116766 ±  8%      -6.0%     109716        proc-vmstat.pgreuse
     25902            -2.0%      25381        proc-vmstat.thp_fault_alloc
      1.73 ± 59%      -1.3        0.48 ± 41%  perf-stat.i.branch-miss-rate%
  23564234 ±  2%      -5.6%   22236469        perf-stat.i.cache-references
    331079 ± 18%     -27.3%     240834 ±  9%  perf-stat.i.dTLB-load-misses
      0.07 ± 45%      -0.0        0.03 ± 26%  perf-stat.i.dTLB-store-miss-rate%
     53.82 ±  4%      -4.7       49.17        perf-stat.i.iTLB-load-miss-rate%
    679766 ±  6%     +11.1%     755158        perf-stat.i.iTLB-loads
      9620 ±  7%     +13.6%      10932 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      2454 ±  2%      +4.3%       2560        perf-stat.overall.cycles-between-cache-misses
      0.03 ±  6%      -0.0        0.03 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
     52.10            -2.3       49.76        perf-stat.overall.iTLB-load-miss-rate%
      9654 ±  3%      +6.5%      10286        perf-stat.overall.instructions-per-iTLB-miss
  23233597 ±  2%      -5.8%   21887967        perf-stat.ps.cache-references
    326645 ± 18%     -27.4%     237090 ±  9%  perf-stat.ps.dTLB-load-misses
    669939 ±  6%     +10.9%     743269        perf-stat.ps.iTLB-loads
 4.987e+11            -3.2%  4.829e+11        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


