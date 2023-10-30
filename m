Return-Path: <bpf+bounces-13608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB647DBB79
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 15:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF641C20979
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAF31798E;
	Mon, 30 Oct 2023 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hITnL+Oz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F991773C
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:11:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C841F3;
	Mon, 30 Oct 2023 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698675107; x=1730211107;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IW9WbtExFJHc79mWRqHs2875FeWttdSj2D2WQDW637Q=;
  b=hITnL+OzF/llaNIDAxBmmA3fQPppJqn5ps04CNhuLDA4xfHKgHykQ9q9
   8YazMJgl0LCF6EYVZKMmCBAr2Fo+gwrcrQGpXjLba65iu2zjTwM9PU4mb
   926w08zI6WsJIosQCgQ7EC5C58Bfu6tG3EtqYmTp+HFtwZ1axw8uJCPId
   8T3g9DY0Xhx07a5uNRvKIxqs7Jx5WPCASaqt0brZIWJWE9SeQh659uZR2
   8KrJtAX82OPNPVTteNupbGq9jo+k74+W+EwgGrUY5srZ0PrOiAELvP6if
   Ne8ahG8V6uoavcDMvO9dSOQqUDxJMHG9Fjyh8l7sDhKfoudXwzuNkCGlV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="454541586"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="454541586"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 07:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="826066187"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="826066187"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 07:11:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 07:11:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 07:11:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 07:11:44 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 07:11:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHMryj1DtmQeAkkc3o1lVPuCM8fA/kw9hIeOOsJBsYYNA08WET1yZZb+z4V8g+aSz7tvG8fFrgs9FCExSAq/rtSk+VkGhERPZ/vurlpFz78XDCUSXLHiTrvxrfZgrUmqIsjqzJbhlhyMNBOmO1Mds6/TVeDBXklcP/1++CVfD1CwscJEy4VLNgDQja3kxHlBYMs4AyktZC70QPMvn5QQ9yla40WByg2udfuy5PLL/8/GTXCDyrPi12AncAzeGxstKtJnLKqJpz/xwbfoswCES4J7tRZ6oNVlZxcg5WQJMU1k5rMyqtaCdJaJA1tLA0cP6t0pR1ijjYEYJQkOlZH2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rNIlwQ2OzOeYMyfVdnom5TSkvRZZmjM+yo3KdpYwUY=;
 b=fKjKM+96TJegqvtfJA4jtaugQuIxLfK7qu7ZxQ1u4r8mYQ7d5QSOvIEL+6A/ZCSAOgGZ0ImntOeGSgVvM35YuJFyhq7IZ2b1Q7MAjhm1V3o+R8aUIs1rpshIKt0ZC+aG1xrF1xC4U8HzqrZEv/AwA60N6LGyZET8Hdri6MaCE5NoqhK+rWAX7amOxK/QAxXfQk7sWsw4tzamO5f46ANB6l0svMSebhUIme1vbm7wAJ/TjVUzzy7FBY+i/Ft3Uda5aPxsVGmsJCR5EiuVbkczgFpGKXnZxWYr8VuUFDgm8jwa/hWRhv4ozpnyhBx4KSs+mCZD9q77Iq50kmkmzwUqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB7996.namprd11.prod.outlook.com (2603:10b6:806:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 14:11:42 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 14:11:42 +0000
Date: Mon, 30 Oct 2023 22:11:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Hou Tao <houtao1@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [bpf]  c930472552:
 WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init
Message-ID: <202310302113.9f8fe705-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR0401CA0032.apcprd04.prod.outlook.com
 (2603:1096:820:e::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f50d1b1-22aa-47a9-0bda-08dbd9522445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRyrLJhGXColrIW8xaRFqVcwk8nrkz/7Oopfdgnxa51UtBpI6Fk2onUp0RZJA9xxx0YSjkJvnFxuZE2TYkeTyUP2qNv79QQ0ux95tNih60fCJowx68OxOxxs5ZPDJwNrHfBjaoaURIrcvbXvJ977RxcM9iOIoDYin+SWvgloFCbkSUMKfBMbYOHb9EduwEre/FDxeghZDJg3M4wsQv9V0Ge3G52fvQkm/xkbQJKLe6Vxb3n6Yycxpw7iLIbPSFwLmqGnHjwzG3amHi7S+RcQdqL/0gvDj+2jqzAmbSigeuu4/PILZ++HgEkTgM0eMBSzky5T88gTyOsCqTWkqLzzqxhu+Hp00E7S3jlDKndxepbtBMa4NYw1ie4K8bLOU8cIpec+yTncLNrS/Dxhy+uOyT5RAI2RF7hG81TpnWVdka00zVmQmORsALNofYjRWvKF3G4DF+i3yo6jzwgzys4AHI4v1ebgejRaVkdNODVBstz1q0ha9qUPXJpP84NTGLwVcn1rIaR1Ka3SXxBrcNVFhTFiUHmjsTxWOcOIhaKaHrBWfLLRY6rC+5q10KOG1XjhBKoL33vla/vbgv29jC3mQE4bYaQ+hT4xl4fKDOktDp+w5gges4xwFzX+6G30eQv0pg0n/h5WyqipAgJ3JD3TfS73XlDgoEWW8rPsuAifE7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(6512007)(2616005)(26005)(1076003)(107886003)(45080400002)(6666004)(4326008)(478600001)(6506007)(2906002)(83380400001)(6486002)(66556008)(966005)(66946007)(5660300002)(41300700001)(8936002)(66476007)(8676002)(6916009)(316002)(38100700002)(82960400001)(86362001)(36756003)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wPQHyDqT3KHGeOuS8tASxDIyL3ZD2NCso+72pNxlbOR4hY1jiTYFnrwRdYsP?=
 =?us-ascii?Q?7uVmGYmYK3xwP6roFJH5093wvxWHE/l2Vw4ENPf7WL3ngPzVGbFMlvqVQ6+f?=
 =?us-ascii?Q?LzhMnVEatygoh9TXOma1UUhXxXp9W/8xmoB8HPUHaRMc04zwhDWeVS0jyDn5?=
 =?us-ascii?Q?dxV+liiRV2PK9LI7Ve7O39X6aJdHIwEs+KLdDLv4jQ3E64BNI6oMgWmHRf84?=
 =?us-ascii?Q?iSulxiRu75zOqr5MQjWJZL/zJC5a9DMBuDAjLQG0ATLI0wztAV7eF8M+5h0K?=
 =?us-ascii?Q?tp+PCYuU6RECtSiGwgZw9TyXFp6rACMzS6qlIIwMP54vgvCzcvWveS7Qjg7I?=
 =?us-ascii?Q?8DdkS6UBtcVJwJkWtNH9Lb932X5RE+DwTPJiuJz6e9dC2WTFGPiiLiu6N/9e?=
 =?us-ascii?Q?9RhcKq9CtsmYP5wqghipSUY8cy43LxttD9F3Qe1WgsW6rEURPn9BOqo3Bif1?=
 =?us-ascii?Q?LfD8FfrhT8kWTZOsZpuAMY1pXCBpjcMpTcHnNbDaSsWO7pTHArMQNial64Ny?=
 =?us-ascii?Q?hoLN7ljpkBiHGel7HOkzkBp3zMmNCSxHSc7z7caK9a/49O5D545g5+ITsIJZ?=
 =?us-ascii?Q?JgeivJ8y/0ubaEFWOviJnxCqRVh7+3cjwuTRDwRc12USGy1YygbLjAYEm4nm?=
 =?us-ascii?Q?+HBxcCimBm/BCSyVf/Q387y2nVH7h2N25U/G8eqcRkTfk5b17+FyLHjsEf56?=
 =?us-ascii?Q?QcAZa5d48DD6LY/4JuqMV7bmQAHzidIHl/4kU1lvgIQZC2rf0v89fE6/aaGs?=
 =?us-ascii?Q?7fFclmrSayU10LfQLZdbDBXoylTOnt+crf0kUP0YDu5tQ1WewhMTF4XbOQb1?=
 =?us-ascii?Q?x5cQ6PR61QGRYBmySvQ+20yETiCUEk7gGktrdxJXXfVl2yCvAKx9Hj1e/13h?=
 =?us-ascii?Q?LCyDeS/3n9W9EHVRkZAOpfEeI2fsvcVTpL6a7nxrI63HhygXwW3SXu6gPR3l?=
 =?us-ascii?Q?kKhXxekG5VTl/G2zSk1AdcxROqa3BsjqYX7unNHNywAedLVj4lvzdwy8doZF?=
 =?us-ascii?Q?AcavGax2khYMWpoWnZtRqC4Lqm7ulOp0RBHC0ACTdZtu/MUIjpMac6uSWCFG?=
 =?us-ascii?Q?ptjiZb2Rmcwe7QhjnvzfN/xuG0oDbax/tgGv81jvXza7I7SrqkG77j7Hq8lT?=
 =?us-ascii?Q?m9HOiAay5Y1+0RAuEYuxG5Y2+HueAFJy7HQvLAqw1MBJUvaFpTPsIxh2Z1rJ?=
 =?us-ascii?Q?LbDpecEDzgGRu/rN5esbZgK6i+06sYzdxeywlc2gK8+11/GDspzLjjR3QGR+?=
 =?us-ascii?Q?04uH24vBBpogUTUOV11DxXotFuz2N/Y7YljygnEQPB32Z3sOOmdYwLnbV0m0?=
 =?us-ascii?Q?iQiT6XcKHD7JPHCdBAbGZ9sz1t1oL259LhLrqfOlvFxZC81nPF3YbsMXV0cL?=
 =?us-ascii?Q?jOk1UDljvf+fxaTcLVZ7yrTj8128XJpjZGUeHXn6+62uB3xWwx5SuGjZvID+?=
 =?us-ascii?Q?qmpk760W1WKFQH5H2/IIvYEKvkN6dFJtQco60WOrLMwIhwcTl2qAgo7gvq9x?=
 =?us-ascii?Q?gK2Ry00JsjWtFHh5sG8R/Y5/5zjIRg3rxc9RUVV2WWC2R2O+NiEGMoaBHSyr?=
 =?us-ascii?Q?aG9P5I+DIkH3wdsJvO7/WfvPUzy5R9zUeh7USTQFcWiGEZoEankvL76je3h9?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f50d1b1-22aa-47a9-0bda-08dbd9522445
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:11:42.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pcgothOiTxQoBk1s5o9rQjo3loa03+FEW6l0nUe9zVI+0+01t/8BFn9JcDhONR0JEvf/oxXv+AGPXUqfonxVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7996
X-OriginatorOrg: intel.com


hi, Hou Tao,

we noticed a WARN_ONCE added in this commit was hit in our tests. FYI.


Hello,

kernel test robot noticed "WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init" on:

commit: c930472552022bd09aab3cd946ba3f243070d5c7 ("bpf: Ensure unit_size is matched with slab cache object size")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master ffc253263a1375a65fa6c9f62a893e9767fbebfa]
[test failed on linux-next/master c503e3eec382ac708ee7adf874add37b77c5d312]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------+------------+------------+
|                                                             | b1d53958b6 | c930472552 |
+-------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init        | 0          | 14         |
| EIP:bpf_mem_alloc_init                                      | 0          | 14         |
+-------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310302113.9f8fe705-oliver.sang@intel.com


[   32.249545][    T1] ------------[ cut here ]------------
[   32.250152][    T1] bpf_mem_cache[0]: unexpected object size 128, expect 96
[ 32.250953][ T1] WARNING: CPU: 1 PID: 1 at kernel/bpf/memalloc.c:500 bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
[   32.252065][    T1] Modules linked in:
[   32.252548][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-12679-gc93047255202 #1
[ 32.253767][ T1] EIP: bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
[ 32.254439][ T1] Code: 30 e8 7e 22 04 00 8b 56 20 39 d0 74 24 80 3d 18 c0 cc c2 00 75 3b c6 05 18 c0 cc c2 01 52 50 53 68 df 53 57 c2 e8 47 70 ef ff <0f> 0b 83 c4 10 eb 20 43 83 c6 74 83 fb 0b 0f 85 6a ff ff ff 8b 45
All code
========
   0:	30 e8                	xor    %ch,%al
   2:	7e 22                	jle    0x26
   4:	04 00                	add    $0x0,%al
   6:	8b 56 20             	mov    0x20(%rsi),%edx
   9:	39 d0                	cmp    %edx,%eax
   b:	74 24                	je     0x31
   d:	80 3d 18 c0 cc c2 00 	cmpb   $0x0,-0x3d333fe8(%rip)        # 0xffffffffc2ccc02c
  14:	75 3b                	jne    0x51
  16:	c6 05 18 c0 cc c2 01 	movb   $0x1,-0x3d333fe8(%rip)        # 0xffffffffc2ccc035
  1d:	52                   	push   %rdx
  1e:	50                   	push   %rax
  1f:	53                   	push   %rbx
  20:	68 df 53 57 c2       	push   $0xffffffffc25753df
  25:	e8 47 70 ef ff       	call   0xffffffffffef7071
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	83 c4 10             	add    $0x10,%esp
  2f:	eb 20                	jmp    0x51
  31:	43 83 c6 74          	rex.XB add $0x74,%r14d
  35:	83 fb 0b             	cmp    $0xb,%ebx
  38:	0f 85 6a ff ff ff    	jne    0xffffffffffffffa8
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	83 c4 10             	add    $0x10,%esp
   5:	eb 20                	jmp    0x27
   7:	43 83 c6 74          	rex.XB add $0x74,%r14d
   b:	83 fb 0b             	cmp    $0xb,%ebx
   e:	0f 85 6a ff ff ff    	jne    0xffffffffffffff7e
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB
[   32.256641][    T1] EAX: 00000037 EBX: 00000000 ECX: 00000002 EDX: 80000002
[   32.257402][    T1] ESI: fefbda30 EDI: da953a30 EBP: c3d49ef0 ESP: c3d49ec0
[   32.258176][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[   32.259000][    T1] CR0: 80050033 CR2: 00000000 CR3: 02dd5000 CR4: 000406d0
[   32.259768][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   32.260526][    T1] DR6: fffe0ff0 DR7: 00000400
[   32.261021][    T1] Call Trace:
[ 32.261376][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 32.261835][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
[ 32.262395][ T1] ? __warn (kernel/panic.c:673) 
[ 32.262840][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 32.263327][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
[ 32.263884][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 32.264368][ T1] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 32.264833][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 32.265333][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 32.265903][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 32.266392][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
[ 32.266982][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 32.267476][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
[ 32.268050][ T1] ? irq_work_init_threads (kernel/bpf/core.c:2919) 
[ 32.268610][ T1] bpf_global_ma_init (kernel/bpf/core.c:2923) 
[ 32.269142][ T1] do_one_initcall (init/main.c:1232) 
[ 32.269657][ T1] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 32.270243][ T1] ? rcu_is_watching (include/linux/context_tracking.h:122 kernel/rcu/tree.c:699) 
[ 32.270770][ T1] do_initcalls (init/main.c:1293 init/main.c:1310) 
[ 32.271275][ T1] kernel_init_freeable (init/main.c:1549) 
[ 32.271841][ T1] ? rest_init (init/main.c:1429) 
[ 32.272324][ T1] kernel_init (init/main.c:1439) 
[ 32.272785][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 32.273272][ T1] ? rest_init (init/main.c:1429) 
[ 32.273752][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 32.274272][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[   32.274803][    T1] irq event stamp: 16968005
[ 32.275293][ T1] hardirqs last enabled at (16968013): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:347 kernel/printk/printk.c:2720 kernel/printk/printk.c:3039) 
[ 32.276277][ T1] hardirqs last disabled at (16968022): console_unlock (kernel/printk/printk.c:345 kernel/printk/printk.c:2720 kernel/printk/printk.c:3039) 
[ 32.277242][ T1] softirqs last enabled at (16967866): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 32.278202][ T1] softirqs last disabled at (16967861): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[   32.279228][    T1] ---[ end trace 0000000000000000 ]---
[   32.280294][    T1] kmemleak: Kernel memory leak detector initialized (mem pool available: 15783)
[   32.281276][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   32.285847][   T74] kmemleak: Automatic memory scanning thread started
[   32.290289][    T1] UBI error: cannot create "ubi" debugfs directory, error -2
[   32.291558][    T1] UBI error: cannot initialize UBI, error -2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231030/202310302113.9f8fe705-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


