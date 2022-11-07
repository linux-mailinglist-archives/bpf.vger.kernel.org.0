Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7991F61EB21
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 07:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiKGGkj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 01:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKGGki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 01:40:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C064CB
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 22:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667803237; x=1699339237;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7AEIKwa8hEdkivOsABGeJOVWaS+vyRN/SveJhzFsS+Y=;
  b=ByUd0q+A6AuSxr4Ko+wZ9qF0KfMesPsfDIloldVteD/n9HwzskAsoDgx
   efCmgO0aI0G8Plm9uAVnIQc+wnIGokv2aAb110RGgB68W5EZbM9q/c/FK
   Oc5lZbP6k5gU0HFmtts/RlEnA07NhmANPFYTisS7tJfwivREDtekLe8v2
   QCzhCGtUAdGZncUjo2/zTo59By0UYUFN/yiOYz07SkhRh21nl5V86mIoU
   gguuRT4ms/QzjpDoa9LxxO7Vxp17iVZxeZNQzu5hIEGXJHdgh7U8zdFJx
   0Ojbru3YRShayUiNyrGpa75yktd3Pxc4Yv5sru+a9suDCvaAjdnGFConH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="293684731"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="293684731"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 22:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="669028989"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="669028989"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 06 Nov 2022 22:40:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 22:40:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 6 Nov 2022 22:40:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 6 Nov 2022 22:40:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyq0QId/Fh4fKCsJN5zCA6KyoXwdtqC8m3A6oZscDOybGLYI1Unuq3M/fOWNqr0hiSR2PYoNQQ4wtCefmkQhnDfukMytbuxK2mXRIs20tyezbqnYJdlfFbbM+47WYPFI/5Z35wc+kQ15tDctsX01aAAnJJdzDfxqtHA63uc7wd1Tid45p1rN6gRLR/GO974atLnf2uAptWLsmgpf7FkoPloinnmDBY/hyV6wSOvbWR1Zucb08ALrft7JDtLN3a132fe5UU7dZLmaxgA3YgWI4pcmc7bz6LfcuibKIp6JUmrxj4A6HbmLTHjfB713UGjoaWQkx/elrNt+vsnxnnwUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pdJZ1gBdLs2iAzTvICjbf8SLD+UXgroW8T2Kj1fOvM=;
 b=jSPEn0RwOFwtGsU4iyUnEX4ShW58Z59EjMwOZsac1g0TOx1ackX1Jw0Me06LE4uqiVjxdfzUYQrzyhBuBYpfabsByCDnLtSDN26iGNjVO8Mzl7oK43Q0ZmxZqnIfQOmS1Y0zbv5ecv5/CqpNpuSnjySJBFiftDILC+7An6jz5VM/f1vGipYZo66nTxRGlAKhSR8+53oFBzDv9cWhEeu+m+zzFjMN5zQeYOsPw8LxrFGCv5RMsmlDA2UKcO3T34kmOZTE2wQakc/iAin0fevGNsPaymRr6SxX5KKoNfPaFXksxt62Xx3nW04cElklJXmownps3n7keXdqKdvFg6OSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Mon, 7 Nov
 2022 06:40:31 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e%6]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 06:40:31 +0000
Date:   Mon, 7 Nov 2022 14:40:14 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Song Liu <song@kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <x86@kernel.org>, <peterz@infradead.org>, <hch@lst.de>,
        <rick.p.edgecombe@intel.com>, <dave.hansen@intel.com>,
        <rppt@kernel.org>, <zhengjun.xing@linux.intel.com>,
        <kbusch@kernel.org>, <p.raghav@samsung.com>, <dave@stgolabs.net>,
        <vbabka@suse.cz>, <mgorman@suse.de>, <willy@infradead.org>,
        <torvalds@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Message-ID: <Y2ioTodn+mBXdIqp@ziqianlu-desk2>
References: <20221031222541.1773452-1-song@kernel.org>
 <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2MAR0aj+jcq+15H@bombadil.infradead.org>
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: de4f8ba8-ec52-4e73-1319-08dac08af6be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpdKi75wWXxUEs/XbPUsnbW3GbxXf2eJ4L8N2kM6RbpgbKCP+mFS6ki+GbMxtHnp5iy8yZHZUuV/tZUT48d0xnaT5FTIIGB1YdlDS2sxHb9go42cdSsbbnFsLoVRkG8lZkVlOzL8lRSl1Fj+r9o8HynRNVjq8Gc9qDCznjOur2vYSusahhh8vFyJmxqfcdCjmTUoGmrXlkpz7tA3pePIXxYdOwzPEAH2ficu4SbwRcBMN/BlAm9Lvte3948CpK73QRZ2UBKJZv6xiHqjWsw73EPkeMRYnyIJmKEfFb4t3TxZN6/kOWY9mb+sgL7Yt4LiIP1Rb9VYUK6F4tf2cOy6EPnCjcWBm3Hvl/nnfrBGFkFRHncEjDh+6wNruUQaFns5SiKQY1gkxGtFis2pfa06tTonZmNQn0nyL8BAfzHbd1ocaQ5Ou3Yx67GaBhgT401QnUpKkpQGoXnH0ogK28C4OaoSkvw4GyQbRcaMoUDLuVkyJXtdQr3Scu5wLassWErLGyt77N1C58y4PLAvxa3HPbAmH7xQARcyqAbcn/lG0xyDI0aFT4UwSLSIZWmWt4lcC/LswKmlB5hejIO5eQNyGEY2Yyyn0rKTq7G0XbMHGH/cQbkTG7Od/r1PCBjWe8XxQgzh7RGhzLDqUe0EweStx3Oh/3qcn/dQctZBuVIaZONqo9QMI99BOmVturg5Bc9HSRK7FePI5mtczIkZrKzztAJZFmLbmOUyltu84Uz0pzq5GYRqCvSnYOEWJibIwWLOapVea8iYkBofhuYVQB04AWZxVrD0ism9CLJqDYC3fuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(66899015)(33716001)(41300700001)(82960400001)(6666004)(2906002)(44832011)(4326008)(7416002)(66556008)(66476007)(66946007)(38100700002)(8676002)(6916009)(54906003)(316002)(5660300002)(86362001)(966005)(8936002)(478600001)(26005)(6512007)(9686003)(186003)(83380400001)(6506007)(6486002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3oGsPqUAkq7lb3Yz9AtPObXJsgpysTL2wKxZbby8U+ukGW5L0P9espjZ4rZ7?=
 =?us-ascii?Q?+ZXLusljBbiULTBdrJnpZNfx88VOeYt20w9ejy/GjJz2YtQbjVgr+A+gOgKP?=
 =?us-ascii?Q?5Ki8USO8uXhGhHpH5of/fP93rUTBrzkcSx1ogAWRV36hUCoWhkkZ6wkRl8MO?=
 =?us-ascii?Q?jLWcSVp3iuTmToAn7paf70yteQ3yDAlaUK2NrPF0ofzmIkQwlG0Wh+ISHj3d?=
 =?us-ascii?Q?lar74s/P1Fj0OauqG0MKDBRGT57ByYTOTKGwqCtTyOHh3I1fxOhAyxFcoDg8?=
 =?us-ascii?Q?1vp8Lp+NypvyenPUPdZ7FvbDwr76sSDDcbWeOeDkY2idTB5b5Fpp8KOQfDfo?=
 =?us-ascii?Q?bAeresysL76u3LH2fg0rev2Yx8W9d9JdWUDlT23JzHu9lhADWDE9WnMU/DsX?=
 =?us-ascii?Q?kSHpiNhZWgToFNZ3RkozZlvVWzkzusewyWyMjF8Yr+0CeWMx7qKsA2tZQeIP?=
 =?us-ascii?Q?myjp817+cdpkv3hWSkSAE72XF/QxEMTw2OaAJxaNOebAVXqxmAGHh3keJqYY?=
 =?us-ascii?Q?vyhLWwZpSiR60JDftRY0endQ1v89ca/oSK8zQ/HCB2RhtbBaERgtINQefzUF?=
 =?us-ascii?Q?fqBAURDmgu/veRAqcD/e+skCQaNqOOUBmnSV7OolF82Goc1Aj1RVqv4qzJH8?=
 =?us-ascii?Q?gEDnEGFUKLGmuybIUXrG7t6v+OuiyVzUU3bWL/zvmO7dpWySs6b8Ao3IyFSl?=
 =?us-ascii?Q?ntdrbD926W2zVzbTD6/YldlVJb40Up7Jg7zOwA8nC90tHfxAkLxMtCuG6+WL?=
 =?us-ascii?Q?1CT4ITYAYBchxzdWsGl5kFDksSXQeDEUUCY4ZcRJisJSZ9BKaDCb6s1zU0QM?=
 =?us-ascii?Q?QShtlXllkAMw6VhbNq6tDJhbzgShw7cL380Rn6qS8HMA+rCYfVsPoXsh5Ymz?=
 =?us-ascii?Q?ZNKYyI37bs/RF8DrUnAe2DeIeI2g51/0r8hrHSZPNZCfSpjGc3xtw7X/7ATk?=
 =?us-ascii?Q?bx+KmqXLdiEI1vRFEVoOs0USH9HHFu6riXQ+qK9lPjlYstA51uJDSgj/FTYi?=
 =?us-ascii?Q?sUhGJlEuR+bN7kKMM9o0N5r5pEbHdHKXooN4S/PUVwgN2hZHyfwEZkt25hqp?=
 =?us-ascii?Q?Q3BObXrpS1NfxLjG7Ke4YDTwt8GY/J9lh8H4tYMiuY3QUT3XI7HAFzKzXdy8?=
 =?us-ascii?Q?o5UNbLJ76VZ7xB/fQqb/PDt+K/YdBbQYFVwJgWBoEPZR5sd7bTVnXLBId409?=
 =?us-ascii?Q?RSLCP23RwXtyaBlQizI+ub1uz1IVtS4EoKB4PabF8wJ6pd2jIIGISGbXidht?=
 =?us-ascii?Q?hLggJalAMHxuj4jRbyDPIjUn38QTyEvUoisB2BihhK0t5ShepRdJX3tj8o5N?=
 =?us-ascii?Q?4x1Yac3ylfzKKYjmMu7WalIQaRDhWYE4InaGu9Ouy4I3qY4ThCuWBkRUVT/Z?=
 =?us-ascii?Q?nM8n9fi5PywdK+cuQfeKDvJlN+r4/actcf2ApdMO8mAnhqp+SdGrg/iyV+UZ?=
 =?us-ascii?Q?AAnHNSaSfFkpvIhEGY/D8jtkfXIn3Qv/7bkhjGfP8Jb8cZiyItO03jgcnt4/?=
 =?us-ascii?Q?W3khC/VNnvIMs+QEU7S+Pfy33j+ThHoT4dfrdVdMMKiQexkl5qKLEN8k2+CN?=
 =?us-ascii?Q?xuUA5LR0gJEcjeATDkHvKBtqgvSk9FNng6bVr9HW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de4f8ba8-ec52-4e73-1319-08dac08af6be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 06:40:31.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsCUIj9jD4t04uQ8hCqQ2Mja03tszbhOCM/1rcIknz13bRy4fvBMD2NwujnpLsV4VzoBBNpmFTS03O1xQ4ZpLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Wed, Nov 02, 2022 at 04:41:59PM -0700, Luis Chamberlain wrote:

... ...

> I'm under the impression that the real missed, undocumented, major value-add
> here is that the old "BPF prog pack" strategy helps to reduce the direct map
> fragmentation caused by heavy use of the eBPF JIT programs and this in
> turn helps your overall random system performance (regardless of what
> it is you do). As I see it then the eBPF prog pack is just one strategy to
> try to mitigate memory fragmentation on the direct map caused by the the eBPF
> JIT programs, so the "slow down" your team has obvserved should be due to the
> eventual fragmentation caused on the direct map *while* eBPF programs
> get heavily used.
> 
> Mike Rapoport had presented about the Direct map fragmentation problem
> at Plumbers 2021 [0], and clearly mentioned modules / BPF / ftrace /
> kprobes as possible sources for this. Then Xing Zhengjun's 2021 performance
> evaluation on whether using 2M/1G pages aggressively for the kernel direct map
> help performance [1] ends up generally recommending huge pages. The work by Xing
> though was about using huge pages *alone*, not using a strategy such as in the
> "bpf prog pack" to share one 2 MiB huge page for *all* small eBPF programs,
> and that I think is the real golden nugget here.

I'm interested in how this patchset (further) improves direct map
fragmentation so would like to evaluate it to see if my previous work to
merge small mappings back in architecture layer[1] is still necessary.

I tried to apply this patchset on v6.1-rc3/2/1 and v6.0 but all failed,
so I took one step back and evaluated the existing bpf_prog_pack. I'm
aware of this patchset would make things even better by using order-9
page to backup the vmalloced range.

I used the sample bpf prog: sample/bpf/sockex1 because it looks easy to
run, feel free to let me know a better way to evaluate this.

- In kernels before bpf_prog_pack(v5.17 and earlier), this prog would
cause 3 pages to change protection to RO+X from RW+NX; And if the three
pages are far apart, each would cause a level 3 split then a level 2
split; Reality is, allocated pages tend to stay close physically so
actual result will not be this bad.

- After bpf_prog_pack, the load of this prog will most likely requires
no new page protection change as long as the existing pack pool has space
for it(the common case). The actual space required for this bpf prog that
needs special protection is: 64 * 2 + 192 bytes, it would need 6144 such
progs to use up the cache and trigger another 2MB alloc which can
potentially cause a direct map split. 6144 seems to be pretty large number
to me so I think the direct map split due to bpf is greatly improved
(if not totally solved).

Here are test results on a 8G x86_64 VM.
(on x86_64, 4k is PTE mapping, 2M is PMD mapping and 1G is PUD mapping)
- v5.17
1) right after boot
$ grep Direct /proc/meminfo
DirectMap4k:       87900 kB
DirectMap2M:     5154816 kB
DirectMap1G:     5242880 kB

2) after running 512 sockex1 instances concurrently
$ grep Direct /proc/meminfo
DirectMap4k:      462684 kB
DirectMap2M:     4780032 kB
DirectMap1G:     5242880 kB
PUD mapping survived, some PMD mappings are splitted.

3) after running 1024 sockex1 instances concurrently
$ grep Direct /proc/meminfo
DirectMap4k:      884572 kB
DirectMap2M:     6455296 kB
DirectMap1G:     3145728 kB
2 PUD mappings and some PMD mappings splitted.

4) after run 2048 sockex1 instances concurrently
$ grep Direct /proc/meminfo
DirectMap4k:     1654620 kB
DirectMap2M:     6733824 kB
DirectMap1G:     2097152 kB
Another PUD mapping and some PMD mappings spliited.
At the end, 2 PUD mappings survived.

- v6.1-rc3
The direct map number doesn't change for "right after boot", "after
running 512/1024/2048" sockex1 instances. I also tried running 5120
instances but it would consume all available memory when it runs about
4000 instances and even then, the direct map number doesn't change, i.e.
not a single split happened. This is understandable because as I
calculated above, it would need 6144 such progs to cause another
alloc/split. Here is its number:
$ grep Direct /proc/meminfo
DirectMap4k:       22364 kB
DirectMap2M:     3123200 kB
DirectMap1G:     7340032 kB

Consider that production system will have memory mostly consumed and when
CPU allocates pages, the page can be far apart than systems right after
boot, causing more mapping split, so I also tested to firstly consume all
memory to page cache by reading some sparse files and then run this test.
I expect this time v5.17 would become worse. Here it is:

- v5.17
1) right after boot
$ grep Direct /proc/meminfo
DirectMap4k:       94044 kB
DirectMap2M:     4100096 kB
DirectMap1G:     6291456 kB
More mappings are in PUD for this boot.

2) after run 512 sockex1 instances concurrently
$ grep Direct /proc/meminfo
DirectMap4k:      538460 kB
DirectMap2M:     7849984 kB
DirectMap1G:     2097152 kB
4 PUD mappings and some PMD mappings are splitted this time, more than
last time.

3) after run 1024 sockex1 instances concurrently
$ grep Direct /proc/meminfo
DirectMap4k:     1083228 kB
DirectMap2M:     7305216 kB
DirectMap1G:     2097152 kB
Some PMD mappings split.

4) after running 2048 sockex1 instances concurrently
$ grep Direct /proc/meminfo
DirectMap4k:     2340700 kB
DirectMap2M:     6047744 kB
DirectMap1G:     2097152 kB
The end result is about the same as before.

- v6.1-rc3
There is no difference because I can't trigger another pack alloc before
system is OOMed.

Conclusion: I think bpf_prog_pack is very good at reducing direct map
fragmentation and this patchset can further improve this situation on
large machines(with huge amount of memory) or with more large bpf progs
loaded etc.

Some imperfect things I can think of are(not related to this patchset):
1 Once a split happened, it remains happened. This may not be a big deal
now with bpf_prog_pack and this patchset because the need to allocate a
new order-9 page and thus cause a potential split should happen much much
less;
2 When a new order-9 page has to be allocated, there is no way to tell
the allocator to allocate this order-9 page from an already splitted PUD
range to avoid another PUD mapping split;
3 As Mike and others have mentioned, there are other users that can also
cause direct map split.

[1]: https://lore.kernel.org/lkml/20220808145649.2261258-1-aaron.lu@intel.com/

Regards,
Aaron
