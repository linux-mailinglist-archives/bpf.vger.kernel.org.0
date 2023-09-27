Return-Path: <bpf+bounces-10917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D87AFA11
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 75C63281563
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 05:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270614263;
	Wed, 27 Sep 2023 05:27:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7AE290D
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 05:27:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0820A4EE9;
	Tue, 26 Sep 2023 22:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695792438; x=1727328438;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=rbaeVQvS8VzjwHD1AiYh+hU41+yovYXlnMi0O89HkiM=;
  b=Ds7X7hGdLBvZjTj/EIQ9fjbCNcUl3G7No2dq0UbBw+CfW92ABlAQdDf5
   WC9P0lR622plC4wi1e3QTFjZ0dG2vO+4sutt2QNj5/GJZgPUMQ2DmuCde
   i1hEoHjjpPRNSWQKDve0ssd5yNlDlIvi1FRyqDhD0fE2IRCFywpMdPZoS
   PGb1q3iXcCVm1sSXkfNTWhOJyZDEXerd685HWTe8+ix3LNlZgdlbeSYym
   kHnePjhM4N/qJdsMDFkTk2kgP/Qk4dNdAiQ+LsJYUXPfl041I+zd0VGEh
   txOkAg3guZxpoNPKs/9LICcc2NJwNe3VsykZtJi+68b2o6pjrZOkL/tUM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366796148"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366796148"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 22:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784202600"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="784202600"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 22:27:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 22:27:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 22:27:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 22:27:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTxG4d0C0kiPR+IChx5R2aeYwshpgMhmI2NJuw6THH/OMN1ng4sfLo+qdZQQ0qgE5J6mcQJvAZN8nNgw+pGnslBSxzM7EqvoGJbBaqZ1O3pBxchbo1qwD81ba7VGHhX7UjAM3STHiWsZ8TSkWsFXUljFYgLEdpF6DNKMRVTWCRTAfiLnZpCGlPUzQiTAsBlVOuYFwgTZYawwV8g3KKnuEf1+Mdh9RIpV1GdNK83TQKH1BJXoWrairdJKbjgxwCIZmqo/S3+OgJylsV0KLtypUdrauUzMCXbkAHL9voYP/OohL6TW8qj5tm4WgnMJFujg4r/rszQRjuZhKdrumNa7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGrTjt/kTx3wwF001kTTt3muCvFO0ymgHtxZW9CtZic=;
 b=EYYpsULO9FbPDvv40lnx+hHOGgpK6LH8QzTC9VFNnls9N2an2xSMivlcj8Py2iYn53s4UcARXDBhM0VZDrk/Xao+l/sdEGb4NrsDqutWCLI1ClWvsWqCLCMpBwNJK+PCqqDdI44/P/xzKLagFSf7Lh/u6ZoIDm4gBd3qNd+UQU5DJlgJo5NlkqPSLrStEqXkWDj83veI7HAFQ8hjzQ56nUE2eLKSzrWeGrGiqtde+nLULDfXt64DAiq3TxxtAHP6VCECRD2ispFHl9c6T3HtwNKlrK9lt7orrQalwAJ0XT2KKhZsw/oTRSHyWNt4V2G0ppzgbdCKlxojuMbl4CyPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW4PR11MB8267.namprd11.prod.outlook.com (2603:10b6:303:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 27 Sep
 2023 05:27:08 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 05:26:48 +0000
Date: Wed, 27 Sep 2023 13:26:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: KP Singh <kpsingh@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Casey Schaufler
	<casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, Song Liu
	<song@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>,
	<paul@paul-moore.com>, <daniel@iogearbox.net>, <ast@kernel.org>,
	<kpsingh@kernel.org>, <renauld@google.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v4 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202309271206.d7fb60f9-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-4-kpsingh@kernel.org>
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW4PR11MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: fb114b48-409e-46df-353b-08dbbf1a58d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbL0IjB1nuIvIe57SESjWDqq68945vjLUfKpeR/9ksghyx04+wlrF/7IzrYU+v3N4quMaPGl2dbzPpqkquf07p5YtTSvJsMgO2FcaOHupgKviE0cdRQIqoCC54EUr/cSt57Jvc0qtt8gxbtU7JwWD3njOyoBe5xUljQMz1vRGlw6zxxL0ZcHYLnxuwTqddCzkp5YZlLmAdO4IFd2WG7SFP4sy2RZWB2BaKXGhPWkb6A5hEZZNPGyYn7Z5XLOMFC9gtFh9XrDmhx0swf14EumYrihTV5y/GCw6Wm4HY4/wfVFBZyOS1KDSTkv8X4QyOEf9hVcq0SP5YmaKEo2i8nJjxwRTKikcU8QEbJFOl0dHr7nrqAhrKmMLDwlWu5MKqBE20rMZFEUAIWEAD2MlVsJxU08S8f0RRHzfc+aQf0CDna8qM2eYlN1L+S+twOW7M9E34dQ4yqmwwACtxJ3LuuyUh4go4RqWMXxPXHKxPJVsmJMzD/juX9qDuPaRkLEtJf8LYpPVpOwXuAWRdkIMypx/GLMY0LhvdZiqeWszyhJNQ6ansaoaCmdY6h9d4oGSQ313TdExFNYoptfF6F6TtlAzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(38100700002)(2906002)(6506007)(107886003)(1076003)(6486002)(6666004)(86362001)(2616005)(6512007)(478600001)(966005)(26005)(5660300002)(41300700001)(7416002)(4326008)(8676002)(8936002)(36756003)(83380400001)(15650500001)(82960400001)(316002)(66476007)(66556008)(66946007)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbXHyE04iQ2rsD4BoI6m2/3XiQFbXPpAyV8BolIMye8LR58STqoOUj18LoKb?=
 =?us-ascii?Q?vfoCzNCj4ON5yR54dHKJCCr85O4rMxqnpdh+9M2bhrfbhpN8z3rw4a2fMw/x?=
 =?us-ascii?Q?yszsuVKoefriEdYqdo3mulAxQa4UxFfCPkxMNfn/IEnL1jqkLTWUp6vpTZR5?=
 =?us-ascii?Q?952hecq42u1rb+AqxIwLnCgFJSvimRIe4zIHiU1UZPsLUAV/6XOX9JtJ2X62?=
 =?us-ascii?Q?RR9tMbIi63Jekccm1INXnNjr4YmupkBBvoIh4tU4dDFU5Tu5uduiecS67KwJ?=
 =?us-ascii?Q?nqNCho3SwMb/0FvQrCqBkVrp1NNaUKdrog23k+MMjeG6Y4/EPx2nlH/th6TE?=
 =?us-ascii?Q?yOMW6bwuBENHrHas6D6tRgvqK3y8GXG7bBEk8k4VuZ5SdGIt1x1aJ2RNuFWs?=
 =?us-ascii?Q?x4p5EiKHwrFv1+h5cxuxpEDrifkzYa1HniowTWqLSd289PvJkqdhcW6Qq8RL?=
 =?us-ascii?Q?udFirNXv8mDg0YHcv8+Gq3qYdwPs2LpUpy3zTe6CtBMYbTMTR+IHlsB4vGxM?=
 =?us-ascii?Q?MfbFbum5q3y5z7PJRyPJZUt3EohFfr5ZyO6SxZwCSSd7dm2OhDWW7sulmazh?=
 =?us-ascii?Q?ssgtVXCTF5fc5N0h/oEBwn4fvv6fFELbmz2IhGkVaxbK40wFwYfLsJYQ1Ut/?=
 =?us-ascii?Q?iPYRmifjJRiHFoOWZYtrYQE54bZxC//1/sb966qBqa+ur8yfMvuNFNIlKbm1?=
 =?us-ascii?Q?YUCaP23gW1uIuyMo3JDBaSksKYbP5Awj3pbsn57b2CsToERAQ7VkxpYQwC6P?=
 =?us-ascii?Q?a1knu4TrkKc1P61LnVi7CPYelddoFXqGX7Ewb72+BBMsMZ9RDDPvbv07Skh1?=
 =?us-ascii?Q?ZH7lmzjoHG2dOFG8prPN4SU7fJlOepDM5CiPWELvStLEFHRmjGBGE3Jf4aFV?=
 =?us-ascii?Q?il3GG3IxcRem5RGT5C1EDDMZoBzV+qNLKg3VjIA4dLv2u0HJ7/HmeGXfFqMp?=
 =?us-ascii?Q?DNR19MS3Q/IVf4hO/W2YqS75glMlPUMhrdgQGrjoycMK0+Fp81NzmrOXo5eu?=
 =?us-ascii?Q?TDMxilsBafqUIdlS/b0On1H5huVVogg/q9IXqgBR39UrWXQc3beCdI9PIjEX?=
 =?us-ascii?Q?5AVXfnh1/u4aD35DmyXPv4qLN3h47RPw4bTEBnrXYMwq46w/FJuYERJXQen8?=
 =?us-ascii?Q?FP7n14sDkMWrP6AKSsJk1oBsl8QImZgjCmBbrijT9oggHvtKhEarYk0tTSl0?=
 =?us-ascii?Q?UFaCa6jgPuzP7Ul2NGy5CusFUJO4sua0gkQBuuy6TTp2UamOsqtQ5VTYDFUY?=
 =?us-ascii?Q?+IsG1pQK0tiSOusoghH0fxyZoymHIAPnvSNQ7GQN3cIEpDON1XiUYHE22ilp?=
 =?us-ascii?Q?Y52P75ELpm78Hfij8AeIhrEwlYlZMxCrVsPSmaovlt0nxr+Kjkj5ukl37m8l?=
 =?us-ascii?Q?mAgJM0VauRuZIGEFGECKMPwmpCsAJmCPNprHs/rjgN1o+2J0459JO/460wRA?=
 =?us-ascii?Q?zOAqRA2vZfcYMeNUs6PPN3AbxWKYOAYglm6DvBJEjbtBfv5pVWkMBC2uP4tf?=
 =?us-ascii?Q?2xcjj5zdV5N6wJcOgJmDezZsmUJLf/B/XwzUEhPckT+KcnGypKxxj0NNTKuj?=
 =?us-ascii?Q?KxQULc2yUs8c+6QuG9QUDn1W3z4WhG4IGf8sfwwYKiBGAkv9j0I4TX5XOrLi?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb114b48-409e-46df-353b-08dbbf1a58d8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 05:26:48.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+VnflOzyQqj5ZT1GoQoW1KCSYNwFvbrvbrhO+OOEbIIYKgsVtt4FzYDQjN8ma//nkhijXgAsW3cX7C0sxSERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Hello,

kernel test robot noticed "Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots" on:

commit: e75df0d5718c3d39cd53e2459b04806ed8789253 ("[PATCH v4 3/5] security: Replace indirect LSM hook calls with static calls")
url: https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230922-225925
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git master
patch link: https://lore.kernel.org/all/20230922145505.4044003-4-kpsingh@kernel.org/
patch subject: [PATCH v4 3/5] security: Replace indirect LSM hook calls with static calls

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309271206.d7fb60f9-oliver.sang@intel.com


[    1.002757][    T0] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.006940][    T0] MMIO Stale Data: Unknown: No mitigations
[    1.010166][    T0] x86/fpu: x87 FPU will use FXSAVE
[    1.012429][    T0] pid_max: default: 32768 minimum: 301
[    1.014553][    T0] LSM: initializing lsm=capability,integrity
[    1.016244][    T0] Kernel panic - not syncing: lsm_static_call_init - Ran out of static slots.
[    1.018151][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc2-00661-ge75df0d5718c-dirty #1
[    1.018151][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.018151][    T0] Call Trace:
[ 1.018151][ T0] dump_stack_lvl (??:?) 
[ 1.018151][ T0] dump_stack (??:?) 
[ 1.018151][ T0] panic (??:?) 
[ 1.018151][ T0] security_add_hooks (??:?) 
[ 1.018151][ T0] capability_init (commoncap.c:?) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230927/202309271206.d7fb60f9-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


