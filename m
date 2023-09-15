Return-Path: <bpf+bounces-10133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608DC7A1499
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 05:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A313C281823
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 03:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED86E2599;
	Fri, 15 Sep 2023 03:52:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1523DB
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 03:52:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82461BDD
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 20:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694749950; x=1726285950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aMO1MO0K/yPUqhgw029VpoQdMzjSd8SyJ88RblVSFB0=;
  b=N2U3pBiTyfJtji09XM8+EGE/9s/m8OpG7nOFUT15qzQ7E7YCYKdWH+aG
   mLJlGyFqRoPnDMzC8vCoBENvAKZnRldsE2qegWRPQFnsorzt3LvyPHXxh
   UauTuwKEarTNc5h/tZoeIzUL+vUDrSOK/3mkoo+2dKs0s6bgj3rzIb3nB
   TUCnvFg5i0Wx7KaNFtIpzeX11yc+XP7KHB3qoMenvhmuQHZr2RCEL/h57
   bXdsZi6T6UNpO5tDh8zowNqH5u/5RwyO9Zq2QskmOlIKwqqk/WLX/upOm
   ErbTKEgOOvNflT3Bfns7WcWzU9YbvbqDNbZIbJiudZVPOpzIOYkLmYkaA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="379068513"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="379068513"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 20:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="815028420"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="815028420"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 20:52:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 20:52:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 20:52:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 20:52:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 20:52:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKw13KqOjvKwIrebd34XxQ1Z4SwURMJXuCyNEv09BZgXQZ9u4UHvOXLKwEaxcs4+wNt578ypzazX8NhF9YOQQrzmjVPOMUmFPkkhYzQ+o0HBocdoJMf/CyhIOEwqYaY65dCoZeolEu9rx/PNQ7x7v1Rt1NZfMElHiZC6CueBo5xajcyLiEl3uqmrFpyBKR0nlJdtb+Mo4hO+PdSuu0VuVz5RL54Zp5r/jDNPLemWjRPRTO8FnBAYR557koLsXixxTDwRD41ahvU7iu75CAdVKi9BlgXk0vMf2GfIdE9WAcFGYjhMLi3p7rNEcFeco5emgZjo+unNZBd87hsb7O7P4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjAJKpv+FiXQHgQABbWE0rf45XT8vSzS8zMPaJgnD7w=;
 b=in3CbmRdqQEojTriPcP3npDvn0uXvDg59RjWkv+AbyJS4prYQn2AW+hfw9CHw3IpiqOJRF/1W3Yy2v3T/xVzYI6g3bh1no5NjoS9s9t3SuLXPFtCcxoSRWyOUa6LTPRnOMGigvtyv9Y6b8ohYG5+KmuaK24gubcZ0NQsarMGH+YkptbDd+VF8aQMuqI7MwWxE/Os6Q5qPdyTBUKfmtj7VswIuoYK99/1UY5r3p8ozTyew7GCl2MC6J3W3g6h+xbljZnZnRaw0TnEyXsgq0QtJn55bkhZV1s+FmN+2vA2nRD4I7SlCTgMrE8K5NRp0N0QvQLL8qiMGLch9X9i21op/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB6946.namprd11.prod.outlook.com (2603:10b6:806:2a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 03:52:16 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::cb79:a11e:ef:af6c]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::cb79:a11e:ef:af6c%6]) with mapi id 15.20.6768.036; Fri, 15 Sep 2023
 03:52:16 +0000
Date: Fri, 15 Sep 2023 11:46:51 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <sdf@google.com>
CC: <bpf@vger.kernel.org>, <heng.su@intel.com>, <pengfei.xu@intel.com>,
	<lkp@intel.com>
Subject: [Syzkaller & bisect] There is general protection fault in
 bpf_prog_offload_verifier_prep in v6.6-rc1 kernel
Message-ID: <ZQPTq8LBmwsz4PGg@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cde1a5-87d7-43e5-6488-08dbb59f26db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auMuSX43lCoLuM91zqHrxzUDc5uvf9888pvYMvUb+UZrqwVjkarLMrojWRXVpO1E8ncuu9BAiBRknDNzKETlZD/0QaczOJ6wOqtEzVMww7GcnK1LPXbax8ycIN2NGJFtbn6CLqC8sRlOeAEHH4O5PxxhxGc7BKc2zkZu6/KQEdLFq6k1Sw4ez+v7ayr0pYab+5UOb5n8hSjRWFzSjETYCuWP7P+sNKOhu4fJ2WhHkyoTFYvp9NhtSBZONwpd2kR4C4Q4dh7L1slPKBGKVaKi45paJ2F0w2lmmI9iVkKNinng403SiEaI6ykMH2qYdl59HlCNSve+fz8cAXHv6dXClW1IB/3TH+tk+7Gtlv1s39ondpYUqCTsN3mu0DoLcLcn/XZIZ3+EDnWqG2ERizf+EFuJAba9Os/E6VufI7M0ncQH6sKZGu0iOOB4GytEVHMxy6Vl6rmtX4sEeSi8a20W8CVxTOeBNaGWJxT3T6gNSs8fSwGy4miL0TZhPUkqah7Xav0vTCjtUSZEmKRqHULD8OepwIb37SJOrlm5MnwPGrMMS25722Sq+nhfG+KYAfrIiJ1hzA4cLeSFIw1NZT8NBI85WvNc2rINj6jOUH2jeF5rSGnyvbkXPA/TPpPW1Yk5ChvGT4Za1MBl+XRnUWMMWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(186009)(451199024)(1800799009)(83380400001)(82960400001)(6512007)(66946007)(44832011)(6666004)(2906002)(6916009)(66476007)(6506007)(8676002)(8936002)(4326008)(41300700001)(5660300002)(66556008)(86362001)(6486002)(107886003)(45080400002)(38100700002)(478600001)(316002)(26005)(966005)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tIcuPne9I9a/ufoTWWZRsADFVKkXwFXnJYxnU8wwt/5YDZkAaa/hvAoRUm1?=
 =?us-ascii?Q?nvQUG4JlF5fKtFF+u1bLezWJ8u9ZehUkuDV03+r25JrVuR8upSYwqm9CgNYY?=
 =?us-ascii?Q?nd4UGXg9CtFQR/WUNuJc3PB3jVcIaZyi2/hh5POdPsE+2Qqq2as9keAGn2vw?=
 =?us-ascii?Q?TN2kWDBvrUAAtAydT/INiluoPwtQVvQD6/Auhm0pe5PRwiGO6LyPgh3jCzVF?=
 =?us-ascii?Q?nGsVjjGMH5ErAoujeMdONLXmu64ENuSK3Rgq+OfGqh0hbiKB3rAlIyHQnAIH?=
 =?us-ascii?Q?eAWRN4urBUgiMK9+Zm5qMzcFuIDcmwNlHzzhpk7Qq6AsrYsZVsjD01vjYrik?=
 =?us-ascii?Q?ytzaDXWbePm2JkW8doCQohUgj7iELRQsp/bj2HT84Dd3UN7xIwLTllVSe2gY?=
 =?us-ascii?Q?rAPisbG+iysIRpnYMTVpFn742ACGzr+pa+Oj2J+xywEYdgpIqPZo+zVYOHox?=
 =?us-ascii?Q?K56nKAjnvUYIJwZsHbhvkuKTwhJ12daz9daGziEEW9/bSbyzb2s/O979Zmop?=
 =?us-ascii?Q?g+CqynlAg34qlrpLSgsE5KHr8i03ClskojYz2Af4pxfTqTSW57f3DhcJYMuK?=
 =?us-ascii?Q?ViVccs+p7IhKZFAS2n4PGI++wi1i4AATP4gClb+TvkDqH8xcrxiCQRoQ9ak9?=
 =?us-ascii?Q?s9GnSLf/9iVlcdj6Qj3itjuTLxrWbHD0/d+kdrNhxqODX2c3Yp/zypZlIrLq?=
 =?us-ascii?Q?CN92D8eFqcBnLCl2XAgpXQJoARwYiGgzcgBeQy9o2OmAMg8WcmnC3pZMo1+B?=
 =?us-ascii?Q?d9FvThgzd9qqfrQ4ajM9bi9/Fiuo8NanmmBqxyir/v0L0/tqe+3uaMpOwMYD?=
 =?us-ascii?Q?L3pQNEaXEJtJ2YDOEEE4ygsJE957QDQUi1wEHLhwgbTCyXgwOteA6zEWzTCm?=
 =?us-ascii?Q?Kbn7qwoLPsr0LG42yLnk1w2FcXv04zjXgD5mLt06kgGNoYJVD46IuGj7SHHI?=
 =?us-ascii?Q?b7NqIGSsXzFqWkK2+nGWpOhNzD+j/WfOgZWRrXkuehBOMvpvdVjCkhfdtYmi?=
 =?us-ascii?Q?eVW7pEMVY+9h0/cE1kM1NEh3fH/twO51Gu3ef/p+80DnV92rwZGiPnAV3Uqv?=
 =?us-ascii?Q?qiPPWsc315Eo9qBQu8epyZQW+DNGWRZ+cWqjEESIsldMYGwidGn7v6xk86WW?=
 =?us-ascii?Q?kQQs1Gxizivx4PsHGsQEcl+6udNHdDCtcnFK7z9Rh4irBaMydUKlZd5lXanJ?=
 =?us-ascii?Q?gMuvHJTeNJBKj0w9OLfxVYikL/xFemD4iMGA2JcWSylNraf8C6S+hZUORYge?=
 =?us-ascii?Q?aqZOPuur1XOkNkXFyD3ovQ/S+UU8WlXcZsMU0xQtwGoPkyQ83UQknlPQGx3l?=
 =?us-ascii?Q?v6MfG2lDblDpAHeToHjDwKMrtNwFtdGIvPhXOUTXB3Ha9ejIwJwQdBeU6Wrh?=
 =?us-ascii?Q?bBAtx6LbHQV5Cb82eSdesicPUQDB6DuRc9m4fIRtAxPGiw5TKQnPa4CWRzth?=
 =?us-ascii?Q?49Q0cyVJ5EC/PMXQJpf5ka6aPLiUtBtQFbTq5gGVhcLw0cS1BZl1aK2B0BPx?=
 =?us-ascii?Q?SPvLpRhwj6Mf5bJGJXdLvzmnKXEmyvDNNhteCNPskbwr6oVOvA4GWi7/magk?=
 =?us-ascii?Q?WPrkTSmWBtRt5PIf6HeQXlIwQe0VzfpBKm9kQ5bK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cde1a5-87d7-43e5-6488-08dbb59f26db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:52:16.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biKcSwJrng5zhaTOzDNQPsNMXUL7JvQvEadzO4OKfFNkpnCAUPJAYAyAyEM+bNRk9LtxSWYHB/U6BuSRFyySjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6946
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stanislav,

Greeting!

There is general protection fault in bpf_prog_offload_verifier_prep in
v6.6-rc1 kernel.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230914_154711_bpf_prog_offload_verifier_prep
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/repro.c
Syzkaller reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/repro.prog
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/0bb80ecc33a8fb5a682236443c1e740d5c917d1d_dmesg.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/230914_154711_bpf_prog_offload_verifier_prep/bzImage_0bb80ecc33a8fb5a682236443c1e740d5c917d1d.tar.gz
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/kconfig_origin

Bisected and found suspected commit is:
2b3486bc2d23 bpf: Introduce device-bound XDP programs

"
[   24.157409] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   24.158244] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   24.158778] CPU: 0 PID: 721 Comm: repro Not tainted 6.6.0-rc1-0bb80ecc33a8 #1
[   24.159284] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   24.160075] RIP: 0010:bpf_prog_offload_verifier_prep+0xb6/0x190
[   24.160510] Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 ae 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6b 10 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 a3 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
[   24.161793] RSP: 0018:ffff8880103275e8 EFLAGS: 00010246
[   24.162164] RAX: dffffc0000000000 RBX: ffff88801a707800 RCX: 0000000000000000
[   24.162661] RDX: 0000000000000000 RSI: ffff8880146b8000 RDI: ffff88801a707810
[   24.163158] RBP: ffff888010327600 R08: fffffbfff0db8716 R09: fffffbfff0db8716
[   24.163656] R10: fffffbfff0db8715 R11: ffffffff86dc38af R12: ffffc900008f8000
[   24.164153] R13: 0000000000000000 R14: ffffc900008f8004 R15: ffffc900008f8038
[   24.164651] FS:  00007fce2a150740(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
[   24.165212] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.165619] CR2: 0000000020000440 CR3: 00000000223ec005 CR4: 0000000000770ef0
[   24.166118] PKRU: 55555554
[   24.166317] Call Trace:
[   24.166497]  <TASK>
[   24.166656]  ? show_regs+0xa2/0xb0
[   24.166920]  ? __die_body+0x28/0x80
[   24.167191]  ? die_addr+0x5f/0xb0
[   24.167447]  ? exc_general_protection+0x190/0x340
[   24.167805]  ? asm_exc_general_protection+0x2b/0x30
[   24.168171]  ? bpf_prog_offload_verifier_prep+0xb6/0x190
[   24.168573]  ? bpf_prog_offload_verifier_prep+0x82/0x190
[   24.168983]  bpf_check+0x55ab/0xb270
[   24.169283]  ? __pfx_bpf_check+0x10/0x10
[   24.169586]  ? __pfx___lock_acquire+0x10/0x10
[   24.169920]  ? __this_cpu_preempt_check+0x20/0x30
[   24.170271]  ? lock_release+0x3f8/0x770
[   24.170557]  ? bpf_prog_load+0x1630/0x2370
[   24.170859]  ? __pfx_lock_release+0x10/0x10
[   24.171174]  ? __pfx_lock_acquire+0x10/0x10
[   24.171490]  ? ktime_get_with_offset+0x24a/0x290
[   24.171836]  ? bpf_prog_load+0x1630/0x2370
[   24.172143]  ? write_comp_data+0x2f/0x90
[   24.172444]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   24.172804]  bpf_prog_load+0x1732/0x2370
[   24.173100]  ? bpf_prog_load+0x1732/0x2370
[   24.173411]  ? __pfx_bpf_prog_load+0x10/0x10
[   24.173738]  ? lock_release+0x3f8/0x770
[   24.174028]  ? __this_cpu_preempt_check+0x20/0x30
[   24.174380]  ? __might_fault+0x102/0x1b0
[   24.174683]  ? __pfx_lock_release+0x10/0x10
[   24.174998]  ? __pfx_lock_acquire+0x10/0x10
[   24.175319]  ? write_comp_data+0x2f/0x90
[   24.175614]  ? write_comp_data+0x2f/0x90
[   24.175913]  __sys_bpf+0x18e7/0x66a0
[   24.176185]  ? __kasan_check_read+0x15/0x20
[   24.176502]  ? __pfx___sys_bpf+0x10/0x10
[   24.176804]  ? write_comp_data+0x2f/0x90
[   24.177108]  ? __pfx___lock_acquire+0x10/0x10
[   24.177429]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   24.177780]  ? __this_cpu_preempt_check+0x20/0x30
[   24.178132]  ? lock_release+0x3f8/0x770
[   24.178423]  ? __audit_syscall_entry+0x3d5/0x540
[   24.178773]  ? __pfx_lock_release+0x10/0x10
[   24.179089]  ? __pfx_lock_acquire+0x10/0x10
[   24.179405]  ? ktime_get_coarse_real_ts64+0x181/0x1b0
[   24.179778]  ? __audit_syscall_entry+0x3d5/0x540
[   24.180126]  ? __this_cpu_preempt_check+0x20/0x30
[   24.180476]  ? write_comp_data+0x2f/0x90
[   24.180776]  __x64_sys_bpf+0x7e/0xc0
[   24.180982]  ? syscall_enter_from_user_mode+0x51/0x60
[   24.181277]  do_syscall_64+0x3b/0x90
[   24.181499]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   24.181796] RIP: 0033:0x7fce29e3ee5d
[   24.182014] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   24.183052] RSP: 002b:00007fffb9a02958 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
[   24.183485] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fce29e3ee5d
[   24.183892] RDX: 0000000000000090 RSI: 0000000020000380 RDI: 0000000000000005
[   24.184298] RBP: 00007fffb9a02970 R08: 00007fffb9a02970 R09: 00007fffb9a02970
[   24.184709] R10: 00007fffb9a02970 R11: 0000000000000202 R12: 00007fffb9a02ae8
[   24.185121] R13: 0000000000402bf3 R14: 0000000000404e08 R15: 00007fce2a195000
[   24.185537]  </TASK>
[   24.185670] Modules linked in:
[   24.185884] ---[ end trace 0000000000000000 ]---
[   24.186155] RIP: 0010:bpf_prog_offload_verifier_prep+0xb6/0x190
[   24.186507] Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 ae 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6b 10 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 a3 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
[   24.188245] RSP: 0018:ffff8880103275e8 EFLAGS: 00010246
[   24.188553] RAX: dffffc0000000000 RBX: ffff88801a707800 RCX: 0000000000000000
[   24.188965] RDX: 0000000000000000 RSI: ffff8880146b8000 RDI: ffff88801a707810
[   24.189373] RBP: ffff888010327600 R08: fffffbfff0db8716 R09: fffffbfff0db8716
[   24.189779] R10: fffffbfff0db8715 R11: ffffffff86dc38af R12: ffffc900008f8000
[   24.190188] R13: 0000000000000000 R14: ffffc900008f8004 R15: ffffc900008f8038
[   24.190596] FS:  00007fce2a150740(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
[   24.191079] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.191417] CR2: 0000000020000440 CR3: 00000000223ec005 CR4: 0000000000770ef0
[   24.191829] PKRU: 55555554
"

I hope above info is helpful.

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

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

