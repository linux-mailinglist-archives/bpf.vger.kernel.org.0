Return-Path: <bpf+bounces-10198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0BC7A2DB8
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 05:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7AA1C20B7A
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 03:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79FC613A;
	Sat, 16 Sep 2023 03:35:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A51117
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 03:35:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E21C7
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694835327; x=1726371327;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3OHuCJfN1FQTbVy1Sv+AP+VFJx+nR7RL0Kq/rbuOu0Q=;
  b=l6G1BlGv5KNJkziPXi5iIgK9BBEGOKUkm23GUx6gtEB6vQDjYy4VEIX6
   IGkyURtYEKQn4KNxOp6m3o4pSF4wIkkdJcLZpysKxBopN3ARHpBhgJc3E
   H+paYjliLoaeGgn9wvlB8Xeh/eV4xrCT0tdil0Sq9ebs+u1az7HYdEWS3
   dwHW9SYl8YeQoTW98pILmdT6juumRJM3R4IvP8D8UjqOqVw6iXc2amD1h
   zstJBbRJcnPldojcZxEQ68l8jDTZOF7nwXkKY1WdZ+90CQ6/gsIEUDoKx
   6/FpoWvBifTWQ6tK2UpJQoPkjbr8dGeCbTOeYu5kVWnjmGx+zGp9PH3MP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="445854681"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="445854681"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 20:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="992077901"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="992077901"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 20:35:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 20:35:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 20:35:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 20:35:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 20:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFWKcKfhW7NpdJ9Zc6GNMeVRBGhPYYSOjQLbAtFphlFxYDFyjCLUST25rmIuSQjxKWn1fCYX+kyULYmRDiZbgxynA9s9K9/bae+1FmwIvtlRKKvtftouB7doyyWlFH5FvQWel8bYTnofz3awUNbQ480sIaHXRZ/YK4z1QmptDMu95nUaaDbhA3S6ICDxtpRARiaXqC1iTd9Pv+QIwB06do74PFq5ZBQwxHPfSQHoNsm37zkmoM/8P2C3Y0Cv8zqg10ur6+VUhcp1VTiFyfTXEpKlruBj0Y5ZGk8qRAjllTrPOXuK7g6U6pCVY6lVBkS3ym/g5T78pAOJZVNzrlKqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4u18aTQOgA0QufiTf7THpsmO3CbvZHqwko6Ukp7JmY=;
 b=hCXRrCkx53kKuf+WzW8UJVWAgI8c2AawR57j36S0KXwvow3JM5jT6BjKqEWA0scDI07Gu47QMuB6x7tNq/LQvkTVE31CYDxXEOfj1Xua4taPRQ8UyrTr/4SCZGR8IT29YJxwdk/qlXhj+hOdQOho3t4wTrElpyK8ZB4KloSLnyhdVQCgbCaHSs2dc1xECabWBXB0wREQ4buFy+J2lA8jS6H7XNU2cwipt5I6raXdceocAlF5c1k0DpzpP9jiyOUt4GhDewDjSwBp6WtPX2MuHOvgYEQYNrcOP6lNCDod4v3pY/tqPTL6V/A/nvW24CyJoS8kDB+icOZa1s2D9aBnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MN2PR11MB4725.namprd11.prod.outlook.com (2603:10b6:208:263::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Sat, 16 Sep
 2023 03:35:16 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::cb79:a11e:ef:af6c]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::cb79:a11e:ef:af6c%6]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 03:35:15 +0000
Date: Sat, 16 Sep 2023 11:29:52 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, <heng.su@intel.com>, <lkp@intel.com>,
	<sdf@google.com>
Subject: Re: [Syzkaller & bisect] There is general protection fault in
 bpf_prog_offload_verifier_prep in v6.6-rc1 kernel
Message-ID: <ZQUhMC3zy0jqZAwc@xpf.sh.intel.com>
References: <ZQPTq8LBmwsz4PGg@xpf.sh.intel.com>
 <01584fd4-6f51-ebae-f8a2-d05965d7c075@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <01584fd4-6f51-ebae-f8a2-d05965d7c075@linux.dev>
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MN2PR11MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebacaca-aaff-4b39-e066-08dbb665f023
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CB9nEFnZoHbI9NVoudBeOcf815X5yOXz0jH6kJcayag8lqO/5Ez1GzEyis58E4dmCzT6a2YI3hFTqifKYaFD4sbLr9tIA4C4VLCMQP6WMaGD8tp3Dfh7a3l8dpUD4yZL7UDADZ+frDut8tVXQmDynmqcnLU9kDrHeHVzlb4uFhi28dJdy3rAkBVeDguYLvA/ubDHgrN++KvSTiBMy0o463R2gmX9leE23/ZsdRnYUUIxgZ3rSxR2YHViNP0WA4VFqG8eStxMOmrXvPNrFgHLG8UrbhiTB/orwXM1GmCQ+aVbW82Iz4sRprpKkWyC3Y/ZfODpgJ4F4ya1as4smLBlrwSkAbHUUxEXuyC3Rz9ijQCgTomWBgWuAYpz9nG/SWXs8m8ul95u4DXV48xg/YmNYKsBmRFgAbLi27fQ9nzd0lk86d98SRjlMG3+jQ0YIWlMnSATYgEX9pBrjVKC45sxy28iCbP2FAP/nMqVpzEDDbLAEewTrVCfTZhJN6DLBI4H33ZuhdWFBfJDHz/mxF6cSCIGvALVL0StkXJHKUwGP1pDMwle6YgjtvSTF/jrKbCIRdOfwJpljaXqE8UyC7NDcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(186009)(1800799009)(451199024)(44832011)(5660300002)(8936002)(8676002)(41300700001)(316002)(66476007)(6916009)(4326008)(66946007)(6512007)(66556008)(38100700002)(83380400001)(6666004)(2906002)(6486002)(6506007)(82960400001)(53546011)(86362001)(26005)(966005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZE5RObhsAXjU21/fdym13GV8IwsO93yJoQnjByWdb0xA/fiVATtwqxhGtsZU?=
 =?us-ascii?Q?8vi9YyBq0sYRIjyiScj6qheTNZyThfrXcW7O9HnNAVyRULuU5BvkFju8u6j/?=
 =?us-ascii?Q?7VRGpjQEy9W+BtM5qDd8KrL4b0guPYxoHUGKWHlW9tLrwfwCFMUFzplV1Ydr?=
 =?us-ascii?Q?iID2vjNmCM+DJRkVpcrTZo3J5pa4VoaBoUIcqyScJLV3nkq5ZTmVxxDZAQ4v?=
 =?us-ascii?Q?JnDYiLw00X63z8iEbpr3CDrZTeQyryxkrnbjep8DFGnyx0ABUwfZLfmAQie2?=
 =?us-ascii?Q?kTiY/5ZYiUKqtnPmHU1P83HkfgieX99fDBTQseo67eDygkV2HOpR8EzAbuyi?=
 =?us-ascii?Q?+6si8KHaSMklkOxoZkCyo3zrQL8S9efJcQJ+nQsScRQv9B5WOmFMczcxRKj9?=
 =?us-ascii?Q?K08eaU4ZhGHasRb0mlwLdOywUKBaRFwcrZ0SmsQuwCkriZWZ4Z3diueQ1sXS?=
 =?us-ascii?Q?zXlOR7mXihd2+AoylRgUqCRv8hJFpoqJXH75W7SCwmkcjg3J/5w5Iapeo1/x?=
 =?us-ascii?Q?jWIhmClS+Ja/xU00k6EYgtEt3v3eez/1AlFaKIpuxsZ5LFP/+w0VsaCiQ3k4?=
 =?us-ascii?Q?Ktyoy8NRGhj0EQDrL19hrtYziRN9BvTxSRvQKmOnyzDFOUmIegeIrG7T9XmC?=
 =?us-ascii?Q?gHrl3P53iVmcuTpPG0oxMgJ6f+lIAubYCTjjwD2MMY3sEm3FpvsgpShTa5jh?=
 =?us-ascii?Q?UDSrpHG4I8n6u1pfsnOTMf2u0cDOwN5cwf/iQofpi3CmyVGU03Tmd+OGiWGZ?=
 =?us-ascii?Q?e2m/TsRtc3Omsf88nf8GT7xJZI0gN0GaDt4H1pNhv0wk5RSNYAdCeN8zc5I7?=
 =?us-ascii?Q?gYHW2/bAnIdXaDow9Y5Bq5QaS+gDWV4T/xPVllKfN81yzcVL48Y4taiH4Kc9?=
 =?us-ascii?Q?AUHG+ZywxmNRfSB2CTj6QJSDHLzQ5ecl1Wv0VA0oIUI07wbudlZnjKuhOWAB?=
 =?us-ascii?Q?bxPKVCZTPEg9ncu6vgea0WIC9qlV2fzogoEW5Cwvhwg01kQyCFsp/VyW+qyZ?=
 =?us-ascii?Q?gigFejgjee0WajdQnS4C/0IKC5itQxHzAXizpzv1P97ykcRcnswLGQse/YiK?=
 =?us-ascii?Q?vz0isjlwAoMzX/a/EVa85eIq+4S6vF67Qtl1atc9xkSZkO4AhP393rf2xDTB?=
 =?us-ascii?Q?R/C+e7HC4XFDwbf6c6sUuyqdenfAlM4GqbgEq2rf2S3Te2fLNdCzsk7z2+PY?=
 =?us-ascii?Q?CrKs0im1iHWTJfvc+Pd3I8fWaBSUh7MWVoX1WlgZWSyoB77+gWesdlFjzHBR?=
 =?us-ascii?Q?7ZVW5qDxgiJeD1wQjVXvsPk/jDoZjbdH6dXqYOdnfr+TxkwgD71hyK5e08EY?=
 =?us-ascii?Q?lJf40jQgDJxTQkGXKhda7/3Eeh/jBecpSeM8kMl+UINW0kAWMXRcP41cyUD9?=
 =?us-ascii?Q?eyOBcYMmaABF+jNnoo2afO3EtrJzHLXNuMjWxhkeO5xhYZwu5D7+3V10jzms?=
 =?us-ascii?Q?W2VDcwi/lZRVjWQeB1ftKsv2i0h5FEYi7RAjuVYmP3k+lunVv2+WHs9FnKgr?=
 =?us-ascii?Q?PWA/tFNAfxAN1D7tVpat5bJQ9RWEHHsEWoauEQc1K7iCULVNsPD3dUwvanEf?=
 =?us-ascii?Q?utDUqP8Ua3WQpMLhZu4XbYVBiQEt61HcoMGu18t+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebacaca-aaff-4b39-e066-08dbb665f023
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 03:35:14.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PZw22dl/ePBp1cKgTAamAVJqcyc801Nr4aU34qhBGSvsC/EAv1CBp+6J1GoKzyFq4aWSP4ZFNwnc7NswZU0TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4725
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Martin,

On 2023-09-15 at 09:02:18 -0700, Martin KaFai Lau wrote:
> On 9/14/23 8:46 PM, Pengfei Xu wrote:
> > Hi Stanislav,
> > 
> > Greeting!
> > 
> > There is general protection fault in bpf_prog_offload_verifier_prep in
> > v6.6-rc1 kernel.
> > 
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230914_154711_bpf_prog_offload_verifier_prep
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/repro.c
> > Syzkaller reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/repro.prog
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/bisect_info.log
> > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/0bb80ecc33a8fb5a682236443c1e740d5c917d1d_dmesg.log
> > bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/230914_154711_bpf_prog_offload_verifier_prep/bzImage_0bb80ecc33a8fb5a682236443c1e740d5c917d1d.tar.gz
> > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/kconfig_origin
> > 
> > Bisected and found suspected commit is:
> > 2b3486bc2d23 bpf: Introduce device-bound XDP programs
> 
> Thanks for the report.
> 
> It has just been fixed in the following commit in the bpf tree:

  Thanks for hints!
  I will check Linux kernel community email carefully for the same issue
  report next time.
  I have tested the below fixed patch on top of v6.6-rc1 by kernel:
  6.6.0-rc1-kvm-bpf-dirty, this issue in this email was gone, it's fixed by
  below patch.

  Best Regards,
  Thanks!

> 
> commit 1a49f4195d3498fe458a7f5ff7ec5385da70d92e
> Author: Eduard Zingerman <eddyz87@gmail.com>
> Date:   Mon Sep 11 17:55:37 2023
> 
>     bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
> 
>     Fix for a bug observable under the following sequence of events:
>     1. Create a network device that does not support XDP offload.
>     2. Load a device bound XDP program with BPF_F_XDP_DEV_BOUND_ONLY flag
>        (such programs are not offloaded).
>     3. Load a device bound XDP program with zero flags
>        (such programs are offloaded).
> 
>     At step (2) __bpf_prog_dev_bound_init() associates with device (1)
>     a dummy bpf_offload_netdev struct with .offdev field set to NULL.
>     At step (3) __bpf_prog_dev_bound_init() would reuse dummy struct
>     allocated at step (2).
>     However, downstream usage of the bpf_offload_netdev assumes that
>     .offdev field can't be NULL, e.g. in bpf_prog_offload_verifier_prep().
> 
>     Adjust __bpf_prog_dev_bound_init() to require bpf_offload_netdev
>     with non-NULL .offdev for offloaded BPF programs.
> 
>     Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
>     Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
>     Closes: https://lore.kernel.org/bpf/000000000000d97f3c060479c4f8@google.com/
>     Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>     Link: https://lore.kernel.org/r/20230912005539.2248244-2-eddyz87@gmail.com
>     Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> 

