Return-Path: <bpf+bounces-8551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D57881FC
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070021C20F4C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1194FAD5A;
	Fri, 25 Aug 2023 08:26:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F78834
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:26:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD04D19AD;
	Fri, 25 Aug 2023 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692952011; x=1724488011;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ID2TFMfnsg60k6fBvq2L/MbrVzCFMaThb1XVHruqSwk=;
  b=JKSbkmYjiKJlRjnr9aMz9arij2pmdojhx45NvK16NMC1d44x8We5dbUC
   57WstyOL7Rf+OAaXSTZQhF+R9oUlyZa2L/z5AauxBzoHdyNKGIa6/w09d
   9aorurhAo8B/uTAsRnusgQ73kwS6ARrq22xhsVWQ6CJ/UUV7v45TTsc+/
   MItHEf847R+ca8BgYvnY9LXc2bR3WsSMvNrrwoduuTvQYRN//WqZKrqFZ
   p+KvfNpsAWJFYThAucoUp9qHTP08mpPF8Rlr2uTIDN03j2kMOPPuLlgdb
   WFfz8uEr5CrNHnWmTx1HAyrHBaJ5mgSCWe6lRK3mW1/CyXpIJsK9vVH3W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="377404749"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="377404749"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 01:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="766882365"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="766882365"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2023 01:26:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 01:26:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 01:26:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 01:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RztI4JH2l4WgzGd3B+V7C7qUF69WKSO2l822agBdHbPIaHy+n+gxaM6low1BFn9Z9qAB81dyeTShlLrNwuXhRXfsmk5jKXZL8eL4s7mMZhw5pnUI7mCN1T/5LPsPSEt1zluNrAgYF7andvIQpemJPUyhAnfMhmPjhSyRvAeChtSmDIq91GvUlzzCIq5Ubn3SKKJmhCJiXTAuQIpdbgZ3ZwGfyAZEaxzfnP/PjyGrT4NmdYCvy9duTPB6vAb9Y4MeFnaIW2BKBply/d6N/DsYiDpAkA4lfImBDjJ8fdxZPiQGq3/sjbU8qbI96vQmZzvR23rva1rOtnnayFOJwX1HKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0Av7+Bxi1pLJXlxeS5calqQybre+eDUEr/tT8x+J+k=;
 b=DXOOyliWFlYcohG8wL+xr5eHVtmtISP2LU8QAgDJb+bkyLs/0RCb+AqlDYxzjFNj9ORFHrmF1VDQYTQQ5WZ2hDvI8yp7UPX9z1rtzd5kGHZ0L4sO4LSKKzqeKc0U9jIf5cBjvmdRqd/7ECNcFCanErS8DralMZI0elCSFcpXWvL59sBpeSuLxCAzCPSU2tTOuljxQwJ2o3drCKiJ/cBd5uKRUB0VD5GgwRdg2JGi5xMnTGLG0N4XTNfImjh/TO9M9merFW+cCt2IJ/InqfUbO1Yn92hOZXPvEp+7ngE3//qAQTjp15vSUmzwgGqRNKzJYo/LfNZEo9ewJ7I5sszbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 08:26:41 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 08:26:41 +0000
Date: Fri, 25 Aug 2023 16:26:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sven Schnelle <svens@linux.ibm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, <bpf@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH RESEND v3 1/3] tracing/synthetic: use union instead of
 casts
Message-ID: <202308251530.5bd302e0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816154928.4171614-2-svens@linux.ibm.com>
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: bde65618-3497-425d-8fe2-08dba54501dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcQ32JC1oK4JxD8/pN59toQmguNV6SWdMqZY09qO4/1LXjEAN6j6CB9lCvWfjvOjNIiHURgIqLZLhP8EF6V3lGCX+MZ3ZSNqEkuT2sFgCtpAszG0sxjA69UNcIls2qjoIBJ+9SRfxJrTT1c9mHb9UvNh9GbRXFUKYpGffQbiQFYHcCNRdHGofPdeLItAzdBRb1vsNhlrsPue4jzMCIirugvdDP+zK+uZARuc1ew1rBug0Fn1FI3Q1ONCwyeRzLQ5QgeDDTInziOdzAmL4s85t0htJSLi71VRHLC6TS566w3JIfpbpCesWWUo4ZCoIWPgxnuszFVDWEp14A/1hMIS83RErqnnLt0d3mn9zm/nslI3CKtSIJ6evDQKST+b1yebPVOaP/5QWy23I6cA9Qx+7P/igvbrjxqrhe4dtZGFEFmzw8grQWwh2PhMeqaeDIjgQjFnXv5y8kN5v0o6hMAXBqxjORsC76s0qZr9wR+eWMeAG2et1uI1qdP4rJn70a3tGoaJr7bLN+YCqZ9sZlYK1GjccrB8/ongxSNynglY/zDbPFV9+MGIMvk2GSrGZqkGrtAegjuugnD/wkavokheOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(1800799009)(451199024)(186009)(1076003)(83380400001)(6512007)(26005)(478600001)(2616005)(45080400002)(5660300002)(107886003)(966005)(2906002)(8676002)(8936002)(4326008)(82960400001)(38100700002)(66476007)(66556008)(66946007)(6916009)(86362001)(41300700001)(54906003)(6506007)(6486002)(36756003)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOL5/UYfM95xVAkV45HQLRsoEiPVEPpHaZVI5ri9J3nbKrNMbvPIm0W50Yjl?=
 =?us-ascii?Q?/c9iaLCmN1QHERdGoFArtZRup7QuQIcbPGsWKKTfOfqWFAkcDBuywSgciZWA?=
 =?us-ascii?Q?FUvi5D44y1rbPsLF6QbkxwUL/bxebvQFvNibvJhS4o0dc08zwLWy0vywCMkP?=
 =?us-ascii?Q?DsZJl30GnYvTls/T0NRxJ8uoe5ImeyKa4DovOogrKIBOVuzEaBkm3dfpO3cr?=
 =?us-ascii?Q?0OXYxCwE0WmS+ICivIdU5eDFu4bfZNsiSgm9dxFUZlNrZS01nhv0CP1YFYHX?=
 =?us-ascii?Q?TksHI3gS76Y4He9S3cCHPxWP3qd8LuP/ab2hczvG6eujSiQBWZnBMM3Z+1II?=
 =?us-ascii?Q?DaTxLCEdVxepOOKxt6ez7Dj/gpjENnini5xNj6KheTZk45IskHYnY7z2uU/5?=
 =?us-ascii?Q?FAhhEIp9pbEMZhVbCGeA9J0rUc0HsZIJr2Ex3stdv970+YaIwh1NqzXYb7A3?=
 =?us-ascii?Q?vl6A+aSuy722IBJrrDL2NkYrZFFFTM9yAGVJjEgCNGC7guZcCwC9wHGSyeXM?=
 =?us-ascii?Q?kP2fMga6aq+FrTBTnjmsyFyEtDREpGQ5Yj+ZHazbGPVI4AHOK/vuarRNIYEv?=
 =?us-ascii?Q?K69cqiU1AOy4Oh8blrKbu/v0lgCq9B5cSlsiKhVznOdi1e6zxXp4c2lrfPZw?=
 =?us-ascii?Q?sEVWMUNlj5Om+TJVLUdUhEsekmMMNr8E/1qDC2ZW5WL2f1xLF1OAQchNPwtD?=
 =?us-ascii?Q?m6yyreTZVUMlvOs7riqObohIk92mkGaub8buwXRVQZo7VVTzpcPSEh6okxE3?=
 =?us-ascii?Q?B3/CA3iBUpZZRJ8Ff4ojVlD6unVwvkIS+FySJFW9BKlJsGbQ/oezlEFQoTzR?=
 =?us-ascii?Q?AatEqaiQlcQjAUmkK/QM2ZtlUQB1Dw4wxqJYo9lycQNg82AYbSMQ3bjGndVZ?=
 =?us-ascii?Q?t0ro/q+/rbpIQEPzj13pBvpK15TthFoeRw/LdGceUvz+wzLcLF4zn5IT4jlH?=
 =?us-ascii?Q?pj/fUOiGl7mYNgZRDjmH70PIM7TpBzA2lH6rf4FR57888MfKCLB3GnPDaJe1?=
 =?us-ascii?Q?8grumailjuMO4H1tA4FiVFdDqWJaM2qZ371CwvWqD2RxBXbevpgMPKR3cSMY?=
 =?us-ascii?Q?GvF/VzdZfVOpF7Erwt8dN7+wfJC10FNg/ppIV9Cx8hY00MaC5XCWzBsvPpc5?=
 =?us-ascii?Q?SetnO/Q+7CjqkERzW6NOX05mxXjtfb1qv+l2eWF5wYMDXskeWjVdLUURJ/NH?=
 =?us-ascii?Q?5faLhIWdksBagPaGFrzMwUo+m/wWEl3gBOz6J9/wYKzXBCUhs0Lx42h/gQ9X?=
 =?us-ascii?Q?LrjbKO9sgcWihFiBf57l9qYGLvPxAkx2Ps9BiQUPImdaewJEE4DZZfxugV/X?=
 =?us-ascii?Q?Bt+I1qrq7e4/xUZWykRk40WKPuhplDfYY02M6P9xkhknXZ797asnbvsAfiR3?=
 =?us-ascii?Q?x7qQfMsWk02Ez+vumznqjbasK5XNvyEul9HWUPXiXFn5Kc4Jqns3OFAYXI7B?=
 =?us-ascii?Q?WCbdqhb+noIdICpf1AJaQOB3wZY/E6WuMDoaTSqKt7srKtM+TWDWPR23bvH6?=
 =?us-ascii?Q?zw374G7KbOhMxgAqVs/eIr3qAPWG/MTAiVOnrbIBgFjjKA3TTRE/wmBKzsU8?=
 =?us-ascii?Q?PBn4UN0X+3bpDbYWEyzP8tz3zwGMQdUmUK6EFSYFdmIHQaE++S8cezNHutFZ?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bde65618-3497-425d-8fe2-08dba54501dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 08:26:40.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76zUVLl3LJ9Zivw9E39ZHNaok45dlYPuHkA/o2zvAf5qC6oHubrruR1S9EJUyXBckRaiwnVKVF96neYgFdvU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: e2c9745169808b98f235c09d1366cf8b53ce0d3c ("[PATCH RESEND v3 1/3] tracing/synthetic: use union instead of casts")
url: https://github.com/intel-lab-lkp/linux/commits/Sven-Schnelle/tracing-synthetic-use-union-instead-of-casts/20230817-002758
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
patch link: https://lore.kernel.org/all/20230816154928.4171614-2-svens@linux.ibm.com/
patch subject: [PATCH RESEND v3 1/3] tracing/synthetic: use union instead of casts

in testcase: boot

compiler: clang-16
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308251530.5bd302e0-oliver.sang@intel.com



[   64.204176][   T48] Dumping ftrace buffer:
[   64.204632][   T48] ---------------------------------
[   64.205082][   T48] BUG: unable to handle page fault for address: 001c24ca
[   64.205641][   T48] #PF: supervisor read access in kernel mode
[   64.206115][   T48] #PF: error_code(0x0000) - not-present page
[   64.206588][   T48] *pde = 00000000
[   64.206897][   T48] Oops: 0000 [#1] SMP
[   64.207221][   T48] CPU: 0 PID: 48 Comm: rcu_scale_write Tainted: G                T  6.5.0-rc6-00037-ge2c974516980 #1
[   64.208074][   T48] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   64.208892][   T48] EIP: string+0x98/0x100
[   64.209237][   T48] Code: 94 c2 75 b4 a1 8c c2 75 b4 40 89 44 24 18 31 d2 eb 0e 47 89 3d 94 c2 75 b4 42 39 54 24 0c 74 32 8b 44 24 08 8d 0c 10 8b 45 08 <0f> b6 04
 10 84 c0 74 2c 8b 74 24 18 01 d6 89 35 8c c2 75 b4 3b 0c
[   64.210761][   T48] EAX: 001c24ca EBX: 000405c2 ECX: b516e406 EDX: 00000000
[   64.211325][   T48] ESI: ffff0a00 EDI: 00005af2 EBP: b600bcd4 ESP: b600bca8
[   64.211876][   T48] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
[   64.212468][   T48] CR0: 80050033 CR2: 001c24ca CR3: 08d2a000 CR4: 000406d0
[   64.213022][   T48] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   64.213577][   T48] DR6: fffe0ff0 DR7: 00000400
[   64.213945][   T48] Call Trace:
[   64.214208][   T48]  ? __die_body+0x69/0xc0
[   64.214546][   T48]  ? __die+0x7e/0x90
[   64.214863][   T48]  ? page_fault_oops+0x22d/0x2b0
[   64.215242][   T48]  ? is_prefetch+0x4a/0x220
[   64.215605][   T48]  ? kernelmode_fixup_or_oops+0xfa/0x140
[   64.216051][   T48]  ? __bad_area_nosemaphore+0x64/0x2a0
[   64.216485][   T48]  ? bad_area_nosemaphore+0x12/0x20
[   64.216899][   T48]  ? do_user_addr_fault+0x650/0x7e0
[   64.217313][   T48]  ? pvclock_clocksource_read_nowd+0x7c/0x230
[   64.217800][   T48]  ? exc_page_fault+0xc5/0x358
[   64.218183][   T48]  ? pvclock_clocksource_read_nowd+0x230/0x230
[   64.218666][   T48]  ? handle_exception+0x14b/0x14b
[   64.219059][   T48]  ? number+0x9b/0x630
[   64.219378][   T48]  ? pvclock_clocksource_read_nowd+0x230/0x230
[   64.219866][   T48]  ? string+0x98/0x100
[   64.220187][   T48]  ? pvclock_clocksource_read_nowd+0x230/0x230
[   64.220656][   T48]  ? string+0x98/0x100
[   64.220986][   T48]  vsnprintf+0x420/0x580
[   64.221323][   T48]  ? vsnprintf+0x3e7/0x580
[   64.221669][   T48]  seq_buf_vprintf+0x79/0xc0
[   64.222029][   T48]  trace_seq_printf+0x35/0xa0
[   64.222400][   T48]  print_synth_event+0x26f/0x300
[   64.222805][   T48]  ? trace_event_raw_event_synth+0x410/0x410
[   64.223272][   T48]  print_trace_fmt+0xfe/0x170
[   64.223651][   T48]  print_trace_line+0x10d/0x1c0
[   64.224046][   T48]  ftrace_dump+0x2fa/0x410
[   64.224407][   T48]  rcu_scale_writer+0x59c/0x640
[   64.224808][   T48]  kthread+0x158/0x170
[   64.225146][   T48]  ? rcu_scale_reader+0x180/0x180
[   64.225559][   T48]  ? kthread_unuse_mm+0x160/0x160
[   64.225968][   T48]  ? kthread_unuse_mm+0x160/0x160
[   64.226379][   T48]  ret_from_fork+0x43/0x70
[   64.226742][   T48]  ret_from_fork_asm+0x12/0x1c
[   64.227130][   T48]  entry_INT80_32+0x108/0x108
[   64.227516][   T48] Modules linked in:
[   64.227832][   T48] CR2: 00000000001c24ca
[   64.228166][   T48] ---[ end trace 0000000000000000 ]---
[   64.228586][   T48] EIP: string+0x98/0x100
[   64.228921][   T48] Code: 94 c2 75 b4 a1 8c c2 75 b4 40 89 44 24 18 31 d2 eb 0e 47 89 3d 94 c2 75 b4 42 39 54 24 0c 74 32 8b 44 24 08 8d 0c 10 8b 45 08 <0f> b6 04
 10 84 c0 74 2c 8b 74 24 18 01 d6 89 35 8c c2 75 b4 3b 0c
[   64.230401][   T48] EAX: 001c24ca EBX: 000405c2 ECX: b516e406 EDX: 00000000
[   64.230918][   T48] ESI: ffff0a00 EDI: 00005af2 EBP: b600bcd4 ESP: b600bca8
[   64.231432][   T48] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
[   64.231993][   T48] CR0: 80050033 CR2: 001c24ca CR3: 08d2a000 CR4: 000406d0
[   64.232527][   T48] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   64.233094][   T48] DR6: fffe0ff0 DR7: 00000400
[   64.233474][   T48] Kernel panic - not syncing: Fatal exception
[   64.234050][   T48] Kernel Offset: disabled



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230825/202308251530.5bd302e0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


