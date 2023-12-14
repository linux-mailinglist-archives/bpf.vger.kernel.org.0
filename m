Return-Path: <bpf+bounces-17773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A03812590
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 03:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA55283318
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979AEC2;
	Thu, 14 Dec 2023 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkoTmTSX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C27DAD
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702522620; x=1734058620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LM7w/o+OOeR73rhnMgPYQ1djr0Q1E+3BHF+5Y8uQxRk=;
  b=AkoTmTSXVZWRnN8Ut0WFfchr87HsGgkjoNj2Zfablsa0vyZBaQN3/3y9
   H/mtv+W6zzoSTqxwDjp6ggqLhkJNk3wAYyIDCRDNJOGHJarhWpWwNpdZn
   QZLRS0INxBsNeSlV67/w5IRNsF1dUjmt42ytZwSuGmXv5c777d0YzClDj
   OYFeVQoh4wzMvduxlOQQc/Ry1W2xFeScwhxqP5KFVcW9hr8aaL6ZXhsq4
   ZB5mjJ4y0ZY1esyBnWh8DFiL0aj6m9c9HAWHgL+Fu4RdR59MkgsYQkYFY
   UkrJ7szFRnxNQ+86e7E8XzBO9am0HieaxIV1VrDpFpzOE5WHSzy1qmEUc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13755844"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="13755844"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:57:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750358656"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="750358656"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 18:56:59 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 18:56:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 18:56:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 18:56:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhU0c5hjCgiqptYi6xilYuX94tl/GKLWIK+7iN4zbHdN1cNyDHI6I7QRZeBT7ZklLgBm6Grncwn25nLmF4Z083am5bwtCH+zhaUdxwcoHF3AN8zu6cyJ/wOk9wWKBqCkVgUFGGrt00VBdbV6BlO8GRYdAumsJA44Rcqyi1GyniCb77qHggbgbvLVP41cXg1a9eYILbgX4Gb/2vl3iRG3YTDcKgk5xYxQSCiNEfO3nFoQOKbkOuxF5BmFVDqZoBqprsWNBud2iF1Ua3We0O7izLBArfbTdcNArZOBtTdn3IcnujwWGwfzXhCQCSPejgFgmEWLRcjLpQQQeZaL/s0xYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQhHSypUy+Q8ZS6WrStRFZ+Na83seMVCCHjUW1Zghb4=;
 b=f9uaQA5g/vFL68ualAin+e6QPZBEZp2+DMZoHCOJ4KN9cfxGlw8BgS39BGKxEYsw9RvUzGkXrfPnjR/BLB0ilzbWST6y4nWm5QekKTIuedxNoRo6NS9FUdlvVXdc6IR4JrPMgGavGDR+wsMBpwzHvBpTKp0Pym1Vjg+vfgYUkgVJ+no5riTc0s/21QEiGQHvLIvbYrNNQ3z6t4hmKgud5Rug0fxUd92UldLx2+27JQ4LS55lPgfpQPc9SvpNpR/Izgx8YG/N8KJZ7q0+A74y14Ung47sI+IXScDkr7//Uf+H1A9zLO12Nfy9MhDQuByiMIh9eCXw5FNN9jV9KoNCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ0PR11MB6573.namprd11.prod.outlook.com (2603:10b6:a03:44d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 02:56:57 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 02:56:57 +0000
Date: Thu, 14 Dec 2023 10:51:12 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <heng.su@intel.com>, <pengfei.xu@intel.com>,
	<andrii@kernel.org>, <laoar.shao@gmail.com>, <yonghong.song@linux.dev>,
	<ast@kernel.org>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is KASAN: global-out-of-bounds Read in
 bpf_link_show_fdinfo in v6.7-rc5
Message-ID: <ZXptoKRSLspnk2ie@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ0PR11MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f866c3-a0c9-4436-7418-08dbfc5055ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYEIcv55LSTNfCdAZM4lvyzU7vOtyR+FKYOJLUjtTP9kq0/8EgVriA2AYpMdYUsXPfjTAR8weq1ZO1qbnWGh2Pu7xY/xTPCU+6Z1kxeNmjFY8MB2GvQ+57m8yG3oz9BpskKHrdrku+Mvc0qQL69h+pF0tbMvLzIxFO1zuHRG586dxjARiJmPTh+gPDuvoIGuSXtDYIUU+2Wfw4QwtDOQPUK9/y/OcZXvz5saJWkIikiRk6Z/R9KQFQwoLphnbqEM3vXHu4joLacjvS3KKBVCVLZ+q8VlgfZUV8NFE+2v1ULBlvV86E6kri2pbs/3te7uEP/BRujle9LT++tdJzKuEJgKhd5WkW3YVWTfo0waeTbuBPuLUAGL5/YBuVNIyDM67rtalcf9OOuTYZfi7GyShkWi7ROlONJzwhniVscjs5Ea3la/wML59ib21b/+HEs2ipL5enEruSL2HCiGBiOTGiQ64sv4lehNY2WbDovKA/6f55RN29SxPoEejNEBXMUSop7+Lu9Yf4kzfVXtpUb0fUDr0GAOuyh0kTltCuHMI9uSuD7lyY+h7BnMjE6US1tPeS9OdiSxfge3NnMT4P2VZArZeE6d2Sa4ps/FGhXcbA0GjYMu3Jkau5Z++1Q75HyOxpIMOxcCUxIStwM05ruOlJPrj3qrm2+Brq87QaSW1ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(107886003)(82960400001)(38100700002)(86362001)(83380400001)(44832011)(5660300002)(6512007)(6506007)(6666004)(8936002)(8676002)(6486002)(966005)(6916009)(316002)(66946007)(66476007)(66556008)(4326008)(41300700001)(2906002)(478600001)(21314003)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tTI+qdbJih96Yy5dDoD0fvyX9IaqzWbyceZsE+h37u0W95YgAzXdUGzH8fho?=
 =?us-ascii?Q?V2nPqP+bNm+7xycA3KcRD98F1q+rJPOK67tAwJkfyLy7YuJ/6bjJbHAYDeoX?=
 =?us-ascii?Q?LKI9F/D1kXEdX1J21vTDmIqAtDW4vkJ/sYZy9XXhmjjGco1NDFBf8p92hPY/?=
 =?us-ascii?Q?nq6B6lw601TwJRMZ3/RQMDJSKWr2/dvSoeOsesO+yzhkYLeQ08Tg1MKAnWDU?=
 =?us-ascii?Q?mKFzWUH8FKJS+Oobr5lPgxzFCF//eumm29vPLOH10ip91RFP51stiLeDLKVV?=
 =?us-ascii?Q?VAE8rk33NVJF7fxcG5ANHcJ6FtgAwC4Zeh+iVCSU5wwL3ptjt1RI3ZPHQWJU?=
 =?us-ascii?Q?d37K2m0zf2tYp5AbfM5dzLbhzWg9zAYEvX38zgOMvpB1+SJPKJx5QgWvwqQU?=
 =?us-ascii?Q?9Vp5hM9+edmMKjqBshfNqC//mq/V78CvIvl1s88OjLlJQqO+70CemrNzRvNd?=
 =?us-ascii?Q?17sjzHXO0SViuPZbeMncd1iOF9ZjDTeLsBJ0ln75Rhwb5mKhf/cFH0S3TTyW?=
 =?us-ascii?Q?Q2mlW1d3Y3qPvijndcRthZljwBvvdEdJY/cLGZR40bWycSSE3YkuGT9622Xj?=
 =?us-ascii?Q?zIpVgmvYb4/ETNq/T+vMa6p3Y6YcoQvazS753w64nJUUfP4a3zD091npOUbn?=
 =?us-ascii?Q?tG05aeHMABKT+cnGvTmyyw0fsd4nuMGKvLGWb6yZiXNZ7L9Skk7OMc6dsgxZ?=
 =?us-ascii?Q?/NN64jf2/BDLGkULYQ8gjboy6IJsOIRW7vebsPw8UYxZimSu9IcB1kZ6DA7H?=
 =?us-ascii?Q?YaohXlDRKKWr3S3x13RKYlXujwvoOauBdM4qVOzVNeaiU+YJDJKOvZdRrA8N?=
 =?us-ascii?Q?59vmeE2Lcm7XdcjSjSwkj4jqFaGv1D55U0/+bxa+PjynfXlRKSTlOwC9UTXU?=
 =?us-ascii?Q?K2RXG9yud5jmT4Q/cYTPMAju9yIKxBqnYxby8hc7oKcBXgUmV50xD7xWsNq8?=
 =?us-ascii?Q?kcC/itQmz+zD1Lv0jMIBNMDQIlqgBd6tmqH5JI60Iwf3pM8vqTnS1cJNB4Iq?=
 =?us-ascii?Q?UmpPCZi58w04bjHgeC8gUd3ybLMSUCOorqBYxMG2f9S9wvlC4sEYx5k/adE8?=
 =?us-ascii?Q?6bE2wgTbHniHxD7qlkWLyb/Ii8A862Ts+4cEH5PEpY7eP7EVYFrLbV5ylJEf?=
 =?us-ascii?Q?Akq/j/NLvhLbDP5hsKa8NNXQElRxB7Z3HhedYH1shRRuCXTMP+jUe9w6t9l3?=
 =?us-ascii?Q?Yvy60QTJnkDvYP68SoGloKr3rHjD3L+RBHVKOe8DF4wyl0wV0gmZXBeOUJEr?=
 =?us-ascii?Q?5rlcL+FgBT+gAOF9K90dCvWRrjRO5Luke9A+G0ZhbzmFNGPX/X3z9W5u6LBN?=
 =?us-ascii?Q?nVTDbtX1lV86XMpXgYMyYG6vKJmzuD48cMW15ZB4poXnDwwwClYM8NsHn+oT?=
 =?us-ascii?Q?sCKo3Ugmb6th/JlTyrzrIj63NjkWmgfTkjFtrKh8fycSH1Ymnkq3BapT3xWt?=
 =?us-ascii?Q?leq6Sfxi46+OCswrAuwCTOCm1NHLiLorAvuuReqR3QbjS2tijepGHwSo15tc?=
 =?us-ascii?Q?kVI+d9EVE6+x/IteRIMapwC6EmRpWrNQ653Q2dD6kapRGxGWd41cS8FIc3Nw?=
 =?us-ascii?Q?96ZOWjVupZ1c0BzbECsADM867yT8+a0sltATwoub?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f866c3-a0c9-4436-7418-08dbfc5055ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 02:56:57.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWF5p0vI2ESxpZTNaJ/ugfVmHHQlAWIfOEN0QpU1BmFHHIKqFVWVP+GUSpso9O2WRKRIh2G/B1fWsLIlAjADbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6573
X-OriginatorOrg: intel.com

Hi Jiri Olsa,

Greeting!

There is KASAN: global-out-of-bounds Read in bpf_link_show_fdinfo in v6.7-rc5
kernel in vm.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/231213_090512_bpf_link_show_fdinfo
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/repro.c
Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/repro.prog
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/a39b6ac3781d46ba18193c9dbb2110f31e9bffe9_dmesg.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/231213_090512_bpf_link_show_fdinfo/bzImage_a39b6ac3781d46ba18193c9dbb2110f31e9bffe9.tar.gz

Bisected and related commit is as follows:
"
0b779b61f651 bpf: Add cookies support for uprobe_multi link
"
Make the revert the commit on top of v6.7-rc5 kernel failed, could not double
confirm for the suspected commit.


[   20.624445] repro[731]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
[   20.625349] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.631427] repro[734]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
[   20.632325] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.665797] repro[737]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
[   20.666718] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.671614] ==================================================================
[   20.672115] BUG: KASAN: global-out-of-bounds in bpf_link_show_fdinfo+0x30b/0x330
[   20.672598] Read of size 8 at addr ffffffff8593c9e0 by task systemd-coredum/732
[   20.673066] 
[   20.673179] CPU: 0 PID: 732 Comm: systemd-coredum Not tainted 6.7.0-rc5-a39b6ac3781d+ #1
[   20.673687] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   20.674381] Call Trace:
[   20.674552]  <TASK>
[   20.674701]  dump_stack_lvl+0xaa/0x110
[   20.674964]  print_report+0xcf/0x620
[   20.675209]  ? bpf_link_show_fdinfo+0x30b/0x330
[   20.675514]  ? kasan_addr_to_slab+0x11/0xb0
[   20.675794]  ? bpf_link_show_fdinfo+0x30b/0x330
[   20.676103]  kasan_report+0xcd/0x110
[   20.676342]  ? bpf_link_show_fdinfo+0x30b/0x330
[   20.676651]  __asan_report_load8_noabort+0x18/0x20
[   20.676960]  bpf_link_show_fdinfo+0x30b/0x330
[   20.677253]  ? __pfx_bpf_link_show_fdinfo+0x10/0x10
[   20.677569]  ? locks_remove_file+0x6d0/0x790
[   20.677861]  ? __pfx_bpf_link_show_fdinfo+0x10/0x10
[   20.678169]  seq_show+0x581/0x890
[   20.678402]  seq_read_iter+0x51a/0x1300
[   20.678672]  ? iov_iter_init+0x55/0x200
[   20.678939]  seq_read+0x171/0x210
[   20.679172]  ? __pfx_seq_read+0x10/0x10
[   20.679438]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   20.679784]  ? fsnotify_perm.part.0+0x260/0x5f0
[   20.680087]  ? security_file_permission+0xc5/0xf0
[   20.680399]  vfs_read+0x202/0x930
[   20.680626]  ? __pfx_seq_read+0x10/0x10
[   20.680884]  ? __pfx_vfs_read+0x10/0x10
[   20.681137]  ? __pfx_lock_release+0x10/0x10
[   20.681398]  ? ktime_get_coarse_real_ts64+0x4d/0xf0
[   20.681706]  ? __this_cpu_preempt_check+0x21/0x30
[   20.681997]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   20.682379]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   20.682722]  ksys_read+0x14f/0x290
[   20.682956]  ? __pfx_ksys_read+0x10/0x10
[   20.683226]  __x64_sys_read+0x7b/0xc0
[   20.683473]  ? syscall_enter_from_user_mode+0x53/0x70
[   20.683790]  do_syscall_64+0x42/0xf0
[   20.684027]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   20.684327] RIP: 0033:0x7f688893eaf2
[   20.684556] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ca 0c 08 00 e8 35 eb 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[   20.685647] RSP: 002b:00007ffde2a29e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   20.686108] RAX: ffffffffffffffda RBX: 0000562b794752d0 RCX: 00007f688893eaf2
[   20.686527] RDX: 0000000000000400 RSI: 0000562b79475530 RDI: 0000000000000006
[   20.686964] RBP: 00007f68889f75e0 R08: 0000000000000006 R09: 00007f68889b14e0
[   20.687401] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f688863c9c8
[   20.687837] R13: 0000000000000d68 R14: 00007f68889f69e0 R15: 0000000000000d68
[   20.688309]  </TASK>
[   20.688465] 
[   20.688571] The buggy address belongs to the variable:
[   20.688885]  bpf_link_type_strs+0x60/0x80
[   20.689145] 
[   20.689251] The buggy address belongs to the physical page:
[   20.689611] page:00000000449bb84f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x593c
[   20.690184] flags: 0xfffffc0004000(reserved|node=0|zone=1|lastcpupid=0x1fffff)
[   20.690601] page_type: 0xffffffff()
[   20.690824] raw: 000fffffc0004000 ffffea0000164f08 ffffea0000164f08 0000000000000000
[   20.691307] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   20.691795] page dumped because: kasan: bad access detected
[   20.692152] 
[   20.692254] Memory state around the buggy address:
[   20.692552]  ffffffff8593c880: 04 f9 f9 f9 f9 f9 f9 f9 05 f9 f9 f9 f9 f9 f9 f9
[   20.693008]  ffffffff8593c900: 00 05 f9 f9 f9 f9 f9 f9 00 03 f9 f9 f9 f9 f9 f9
[   20.693432] >ffffffff8593c980: 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
[   20.693877]                                                        ^
[   20.694265]  ffffffff8593ca00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   20.694707]  ffffffff8593ca80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   20.695158] ==================================================================
[   20.695666] Disabling lock debugging due to kernel taint
[   20.720062] repro[741]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
[   20.720827] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.724913] repro[744]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
[   20.725791] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.732282] repro[747]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
[   20.733148] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.770165] repro[750]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
[   20.771018] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.820152] repro[757]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
[   20.820984] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.837880] repro[760]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
[   20.838815] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.839423] repro[755]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
[   20.840255] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   21.068187] Pid 786(repro) over core_pipe_limit
[   21.068503] Skipping core dump

I hope it's helpful.

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

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

