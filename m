Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B46C1E8D
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 18:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCTRva (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 13:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCTRvB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 13:51:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5758E2A6E1
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679334335; x=1710870335;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+8UF5vHfQucQmJYhFH2m1BNq8uRt5gxZjGMio2rxDUU=;
  b=PCc7YakctloTREKTWkAX3YmQokJEeorrncgEm91npU4aWM3DiqA91Vhg
   vCOMqgmAsy78inU1V13Qc2tPhCArhfrDwOhQIf0BqTQuwt/tUI7rQ+RMJ
   4yvvZZXyi8Gcr1TorjeHjeU89sHlXpKeX4/b8s9Via7j+3kmAr1PYYJOU
   KpyrL08Xh6aiBO2l8f9hrLQ0TriD6GaIMUvX+qMqjmUgp0yJS5HMj7W4k
   eQxTsKud8Zkdr8HxjIgmwwJZwbISOhVdTxl0wH7m80cbmhtdMKSD/srZ7
   Ny3B5dHqcG/Bi2F3DhMLMDbQnQMWXpoKW27JC25GsAYSspKUM5foh9kF3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="318381220"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="318381220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 10:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="745476157"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="745476157"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 20 Mar 2023 10:44:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:44:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 10:44:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 10:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGiWL3QsV2Hpe5vJP/lteaeGbctY2C+KSNZshkof2LWNOU4ReOIrt7VmLvHbovSQwIFw7wLt+MAYYzvXylboy0M7L73QMgxi57h6JixnMnyt8NuZP5ceN9vhvsSzWqJgAVO8JBMOxN5IU+C7CJAPAoiTTT0vxHP0W435uRAiZAHYMQnX4UFlUEF5uBoHcMYPPfFIcOSIRBEj767EQNsvqgnAorefCm3ybG6FdxhTdluz0Z2Tt8dr48Et0/0rbe6TbFx1IjodJyJLoPFcsBwRw81cvmOYGX4ld1QU8GTen3YnVCB8u3YJAnKiOgoytcglBhEdlJ3YWVqesmcYh3CRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMQhwdzEK5TdrdPLHQhCCWUpI5+nLyPW24ZqwmcoxZg=;
 b=eXb8YTLITExG6up4qlLi0cdecA8j+YjV7Cnr9p6Z5rAbu1n2iMyrpyt6gyI/CXbSSZLA/y3scDOyD6nUs9qHKpkJYXtUOn/dFLmPbspTR+ZI5aVo89YugYCBT3AA7cszE4VQea9VX5ilm/CAkZ84ZQWYVh0r/UdHZL5GDzGHiwVun7YRI7xZhUfL2cdue5Utqd0CnNFvi6w9m3huxJXbCsuo/rczSKVKF8VWDxdQu547Ih8Mxw9HwFiXmB0u3/aqEPztEfSj46QPDHqU1NYeFuyj4pDAVP4LUCX1sNDPw3TKqcOF47x44/VRtEms8DhTvklfyggsmSxcaR1QD7izAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 17:44:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::dbd:99dd:96d:3ab3]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::dbd:99dd:96d:3ab3%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:44:51 +0000
Date:   Mon, 20 Mar 2023 18:44:42 +0100
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Tushar Vyavahare <tushar.vyavahare@intel.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <bpf@vger.kernel.org>,
        <magnus.karlsson@intel.com>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next] selftests/xsk: add xdp populate metadata test
Message-ID: <ZBibislAFvhYhcxV@boxer>
References: <20230320102705.306187-1-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230320102705.306187-1-tushar.vyavahare@intel.com>
X-ClientProxiedBy: DB7PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:10:52::41) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO6PR11MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 35195e65-e344-494b-bec7-08db296ace76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcFEueRp2/yZaXl0Am0qLDUfK7BeqC5jslonDS/rwKCiI0keMFGgiNLb6cryhscAxyhXmwwzJ9/zuD5TxB5QseloeM3oJeRQ9ulyXLc6UsbskQcwhPDGp0H/AuoK6S8crOKaegkg/FWJTfHdddxzOSDsX2FRMWpHdcdayO8HGGkhphE030vr/h2/s7HIzzXgJOdEFjbZAkS54WXBfAZOa5w7J77EbPwFQ/iGc/o6Eb+6LkH3AN0437fRWNZiYL9JvXgHNaiDdrfQol/5PLbk6BMQ3PCKH6o7jz529GdaNA+exmhBNK+2VIs6DQ2ShnzH+Kxvr2Wd0cJtqcLsK8k7Xe9XA+DI4jDj1jR9J4JdiOJ13m3a+nxHNsnzzaLOAuv2v+d1YBX2ijG1+Y1mJEYsnTf6ODfXXumKgmG0+V9pAlvKSMENxJkBCd9nOIE43TN7f3A094l+acyhtinCZmg7O4Xqt89cMv89TvaIxDjEa6svR6/sSDIJ9tv9kn6DugSQV+vfVcEyK7SbUN8XdRSSG+8ECcr+nvuxvIRodtWUApDmlW3lYklbLbqrjh5miQ/rwNA9CF1zyuFvvfWCVCWP/5DoXzCf1yx7KSyaDnM4gSOLl0tI/Yd6HNWHcDUBbpL53H3I6nh7wgy/mTwif64RGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199018)(33716001)(6636002)(83380400001)(316002)(6486002)(478600001)(6512007)(5660300002)(6506007)(9686003)(186003)(26005)(6666004)(7416002)(107886003)(38100700002)(82960400001)(86362001)(44832011)(8936002)(4326008)(6862004)(66476007)(2906002)(8676002)(41300700001)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wSLlYk+88z8HnliPRge+xwGLFIfArsPVSQ9va8xZJQOBRxoamiA9d1S4QGSH?=
 =?us-ascii?Q?W4DOYMePaY1+N6cH6TrdinWMA+WamAtzBf8J69C2e317aIlwzy5K3LoqOmO/?=
 =?us-ascii?Q?Pkhwma7VSncPD//tYyRkthwGCcC5yZbS/7S31jhDolTyareT7eoxT+u6Bfcf?=
 =?us-ascii?Q?G+MiTAmXBELxEktnDb5VN5hpr3ZrvhJBzOejtKpl+NKarxvQns8DqZwz/uIq?=
 =?us-ascii?Q?EqjRy/SNr3yy6FPX9nslQdq2Mw5SY19RMrfF5eqp/3ljRL+Rg6WqySgA9gHB?=
 =?us-ascii?Q?FpKeUikiX54lnqLK/xuZgcu908M5/7Fhsd4vX2RthgtCLnWy1aVxBFWJABIK?=
 =?us-ascii?Q?zK3xNEvPldqRM1hhulpsTE+Z9IjOF04Hwf8xU1NDJlUltp/JY7Q5Y0Lo5BFg?=
 =?us-ascii?Q?aMS/Z21wVE7ctVoZT7AqIWhpaLTGMwFIYBNXQ47vXUEkg3MDiolw2FwKqDLh?=
 =?us-ascii?Q?7+/xXxB3Lewr9blrkNWf8RCB+OiUm+jMwQmcuYdKpn6L8FH5Rq4L0jjQy0RX?=
 =?us-ascii?Q?2oAwWUmRtmiNwpEG6swmOlXGNREWYDvyYbcQFRCU98Akm1ZS2Cl5t2Iz7PcH?=
 =?us-ascii?Q?+ie404yGrHdIgUz9/G1zB2gjlX3JZ17+FV5itzNTWIKbKdmCL/bGCk2BLi88?=
 =?us-ascii?Q?WilhZ7RZ6VLHVjFQ5DWeM2JFazoMhzTiKcWuVaEP2iMHX8QyV62Qj7Kw2s1S?=
 =?us-ascii?Q?/u1BlZsbkDlBqUUwKjrpbhZK0n0Fvezc3seQnd1rdawRUthY1I6YqUKhGNl9?=
 =?us-ascii?Q?wiUgFsIETK7DHkJ6NFqOfvwUXld/5OBVwvMgejChbPiZok8Q2G8xQe/zo/Hl?=
 =?us-ascii?Q?DpotgvXCmDSh6uJ4bzfn4o4G8IObtzVyB/7zD5M2aAONZjHDqHp5I9xaKuLw?=
 =?us-ascii?Q?cC3T7pLXPFwDL21Ce12IfmV4RDA5PMkiqUmCwYjSaUuBXUJXG90F5z+cYkUn?=
 =?us-ascii?Q?AahR5vYgtQv7aerXfX9jqi7u1UJAqVzftwhHuGhW2/4vbPirhBE/nLom8bAB?=
 =?us-ascii?Q?GPCTY9mffmlV/+GI9mA6dqVSric6N7lIZVNUoTkUBQjStA0cIsM5Lo8M1Ct+?=
 =?us-ascii?Q?5v71iLwfRilrAoxMdhPBUTqX3zk6KuE1Kuw4hOgHb9wIuWWP5HYv9Ffg4vSC?=
 =?us-ascii?Q?Z01jNDU8dlcuYbcVGBEFdD+KRXtRuWXMX7qq/N/NeT5Yyo+j681HcOaf4a9z?=
 =?us-ascii?Q?e+WnDqbz+kNxOGVQC9x28ezkjMaKWKN/m6eXAkjaVObLex9q1CDfeJTrT725?=
 =?us-ascii?Q?Ehf0QcByDfcjTUQ7L0ftcbkJgoTVFftzBWzW7qe3GFQ5gi1gdupdJYnM4MvK?=
 =?us-ascii?Q?dQCkD6DACeQUGvsR7ZCLgheX4UROglzoI05GteoAZ0EACYSy7Vd7qVaM7jzQ?=
 =?us-ascii?Q?uKQp4SQCASRNqDlaqW1xnyiQ0s26fOnOfYysGRWZIByw9UU8mtBG7E1QwFv7?=
 =?us-ascii?Q?1pvAJ7GIERoKiL935obglPTaCVt3imeCS2cGzJwRiRJpWJEOtDMoNy+fIDsW?=
 =?us-ascii?Q?4VvXaAuo0KpUZ/2221h3TwWedZAUgG8Nkt8UqrTrKLV4k7L86z2K/uFGBS7o?=
 =?us-ascii?Q?IQlIPvhgIIMUz7KcuOi2XF/Uc0nrgbidB7u/iOKViZwLINGKrTMXtTmQXX3w?=
 =?us-ascii?Q?rTf3iiZkClX8fIFPX9j/h58=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35195e65-e344-494b-bec7-08db296ace76
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:44:51.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hmp8kTtnw3vRbEckfODy0hM5Nm0GwttVK8MzOmSlIbMghUVCmI8s467cJwWm21tAqjzPhQV1CF2fz0P4SWqFOfiUmVIgHCvG0pVuNFPf7z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 20, 2023 at 03:57:05PM +0530, Tushar Vyavahare wrote:
> Add a new test in copy-mode for testing the copying of metadata from the
> buffer in kernel-space to user-space. This is accomplished by adding a
> new XDP program and using the bss map to store a counter that is written
> to the metadata field. This counter is incremented for every packet so
> that the number becomes unique and should be the same as the payload. It
> is store in the bss so the value can be reset between runs.
> 
> The XDP program populates the metadata and the userspace program checks
> the value stored in the metadata field against the payload using the new
> is_metadata_correct() function. To turn this verification on or off, add
> a new parameter (use_metadata) to the ifobject structure.
> 

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  .../selftests/bpf/progs/xsk_xdp_progs.c       | 25 ++++++++++
>  .../testing/selftests/bpf/xsk_xdp_metadata.h  |  5 ++
>  tools/testing/selftests/bpf/xskxceiver.c      | 46 ++++++++++++++++++-
>  tools/testing/selftests/bpf/xskxceiver.h      |  2 +
>  4 files changed, 77 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/xsk_xdp_metadata.h
> 
> diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> index 744a01d0e57d..a630c95c7471 100644
> --- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> +++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> +#include "xsk_xdp_metadata.h"
>  
>  struct {
>  	__uint(type, BPF_MAP_TYPE_XSKMAP);
> @@ -12,6 +13,7 @@ struct {
>  } xsk SEC(".maps");
>  
>  static unsigned int idx;
> +int count = 0;
>  
>  SEC("xdp") int xsk_def_prog(struct xdp_md *xdp)
>  {
> @@ -27,4 +29,27 @@ SEC("xdp") int xsk_xdp_drop(struct xdp_md *xdp)
>  	return bpf_redirect_map(&xsk, 0, XDP_DROP);
>  }
>  
> +SEC("xdp") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
> +{
> +	void *data, *data_meta;
> +	struct xdp_info *meta;
> +	int err;
> +
> +	/* Reserve enough for all custom metadata. */
> +	err = bpf_xdp_adjust_meta(xdp, -(int)sizeof(struct xdp_info));
> +	if (err)
> +		return XDP_DROP;
> +
> +	data = (void *)(long)xdp->data;
> +	data_meta = (void *)(long)xdp->data_meta;
> +
> +	if (data_meta + sizeof(struct xdp_info) > data)
> +		return XDP_DROP;
> +
> +	meta = data_meta;
> +	meta->count = count++;
> +
> +	return bpf_redirect_map(&xsk, 0, XDP_DROP);
> +}
> +
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/xsk_xdp_metadata.h b/tools/testing/selftests/bpf/xsk_xdp_metadata.h
> new file mode 100644
> index 000000000000..943133da378a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/xsk_xdp_metadata.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +struct xdp_info {
> +	__u64 count;
> +} __attribute__((aligned(32)));
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index a17655107a94..b65e0645b0cd 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -103,6 +103,7 @@
>  #include <bpf/bpf.h>
>  #include <linux/filter.h>
>  #include "../kselftest.h"
> +#include "xsk_xdp_metadata.h"
>  
>  static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
>  static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
> @@ -464,6 +465,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  		ifobj->use_fill_ring = true;
>  		ifobj->release_rx = true;
>  		ifobj->validation_func = NULL;
> +		ifobj->use_metadata = false;
>  
>  		if (i == 0) {
>  			ifobj->rx_on = false;
> @@ -798,6 +800,20 @@ static bool is_offset_correct(struct xsk_umem_info *umem, struct pkt_stream *pkt
>  	return false;
>  }
>  
> +static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
> +{
> +	void *data = xsk_umem__get_data(buffer, addr);
> +	struct xdp_info *meta = data - sizeof(struct xdp_info);
> +
> +	if (meta->count != pkt->payload) {
> +		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
> +			       __func__, pkt->payload, meta->count);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
>  {
>  	void *data = xsk_umem__get_data(buffer, addr);
> @@ -959,7 +975,8 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
>  			addr = xsk_umem__add_offset_to_addr(addr);
>  
>  			if (!is_pkt_valid(pkt, umem->buffer, addr, desc->len) ||
> -			    !is_offset_correct(umem, pkt_stream, addr, pkt->addr))
> +			    !is_offset_correct(umem, pkt_stream, addr, pkt->addr) ||
> +			    (ifobj->use_metadata && !is_metadata_correct(pkt, umem->buffer, addr)))
>  				return TEST_FAILURE;
>  
>  			if (ifobj->use_fill_ring)
> @@ -1686,6 +1703,30 @@ static void testapp_xdp_drop(struct test_spec *test)
>  	testapp_validate_traffic(test);
>  }
>  
> +static void testapp_xdp_metadata_count(struct test_spec *test)
> +{
> +	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
> +	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
> +	struct bpf_map *data_map;
> +	int count = 0;
> +	int key = 0;
> +
> +	test_spec_set_name(test, "XDP_METADATA_COUNT");
> +	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_populate_metadata,
> +			       skel_tx->progs.xsk_xdp_populate_metadata,
> +			       skel_rx->maps.xsk, skel_tx->maps.xsk);
> +	test->ifobj_rx->use_metadata = true;
> +
> +	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
> +	if (!data_map || !bpf_map__is_internal(data_map))
> +		exit_with_error(ENOMEM);
> +
> +	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count, BPF_ANY))
> +		exit_with_error(errno);
> +
> +	testapp_validate_traffic(test);
> +}
> +
>  static void testapp_poll_txq_tmout(struct test_spec *test)
>  {
>  	test_spec_set_name(test, "POLL_TXQ_FULL");
> @@ -1835,6 +1876,9 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
>  	case TEST_TYPE_XDP_DROP_HALF:
>  		testapp_xdp_drop(test);
>  		break;
> +	case TEST_TYPE_XDP_METADATA_COUNT:
> +		testapp_xdp_metadata_count(test);
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 3e8ec7d8ec32..bdb4efedf3a9 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -88,6 +88,7 @@ enum test_type {
>  	TEST_TYPE_STATS_FILL_EMPTY,
>  	TEST_TYPE_BPF_RES,
>  	TEST_TYPE_XDP_DROP_HALF,
> +	TEST_TYPE_XDP_METADATA_COUNT,
>  	TEST_TYPE_MAX
>  };
>  
> @@ -158,6 +159,7 @@ struct ifobject {
>  	bool use_fill_ring;
>  	bool release_rx;
>  	bool shared_umem;
> +	bool use_metadata;
>  	u8 dst_mac[ETH_ALEN];
>  	u8 src_mac[ETH_ALEN];
>  };
> -- 
> 2.25.1
> 
