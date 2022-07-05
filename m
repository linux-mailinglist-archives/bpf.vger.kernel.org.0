Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CC1567589
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 19:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiGERYd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiGERYb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 13:24:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A61F2E4
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657041870; x=1688577870;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GHdpSs+ZFr1Q9sR5fIhsOAFFumrq0TS9Nx+ZappXW4M=;
  b=gU6sqwbf245XCY3+SFGnPIyskpvXcTkR+wHmlGnOF3YpF0jfB28cgOtq
   BekpKC7NGJSpCtAvyZH7jf6T78TiGCgeJ9rIOPCzWHfbynVy9XIgBNH23
   sXL35BXNdEtU7h2vDBgimSLSSMoAYU0H3rV7TPwJDYubx3dvIcc1k6Vsp
   0ABg6e1CjtsE1Fpba3+jJCGdSJ9xNA6Im5ULxjr853cEczizoUUE9zMYO
   2qEZxfyCIUYqEmjth5glUN0tGt6BoJQD5BkrMwx0C+plap58c4hRAzPJe
   vJn9LhnSlHzNfFS4B/zeVsAHrwGwm3GUrG961yEf+/0BcImmMAa75lqAa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="345093663"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="345093663"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 10:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="543034666"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2022 10:24:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 10:24:09 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 10:24:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 10:24:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 10:24:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVqTAVz1r7w+yHu2RxpJL1Md7tF7qF5yhMISGQOEKMWTy+JTR6yLOI5H/1nqPQNUYQTaFT1g7BI7vlKjmkYd+2aS551sZMsxU/VJKZ1u+/EbZL7X+0x3e3n97EUaiDhxE7HJlNhwsUNRJFrvpuxWKVFra3XUGKqj21ghL21gUvVr9FyA+TRHWZfUXOx+uMy1aFb/TTbydhp8W7BJ8Q40LD2BROFaIHx9fmUCB3jybKiv44t7kg/DMQ/icex2YE7YreZg4OjRuJQtkX7CZDuGjHA9BUipz6Mfi2Cl9MlRkOuEqknaGw4gf4GtoMCQkNUwyBHNBLgsv9JwfLGQQkTAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWCzwDgjku402XxZU+2V9DkS4m18yZl1HjYxtEn1YvI=;
 b=OlFN2NXnHbsROrFcffGRlJDSwcgTA/sNGZAhkTrcs3szkr0yzczbaFUUgUhaT3pMt9UW1hQo9Of9KvdxIq7v+hXokVMkuDPxQrJLp1+l6hQZKVy2UW+ykW5h/Yt2hJUHp0yOmi8K1EMCzGfRKKNzo1HSKJrGv8nomFvlTlILQcm0J41WxxYbfH6x9K4Fe7WXhSGz8Sg6uIkrERdJxN2S0A0lBB/yrcyvaSRBlJ3bNchOF6YjFN0L7GN7ZONDcxGTSQwji1DU61dsPQcqDp7kIixEoG8o0kHWcDnveJRv/WzkWtfaBKrX8gLTG7F7zq+wgs2gSWB0QG5rijkmvhAWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5460.namprd11.prod.outlook.com (2603:10b6:610:d3::9)
 by BN6PR11MB1298.namprd11.prod.outlook.com (2603:10b6:404:48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 17:24:05 +0000
Received: from CH0PR11MB5460.namprd11.prod.outlook.com
 ([fe80::e091:7098:edc1:feea]) by CH0PR11MB5460.namprd11.prod.outlook.com
 ([fe80::e091:7098:edc1:feea%5]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 17:24:05 +0000
Date:   Tue, 5 Jul 2022 19:07:26 +0200
From:   Larysa Zaremba <larysa.zaremba@intel.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Toke Hoiland-Jorgensen <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, <brouer@redhat.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>
Subject: Re: [PATCH RFC bpf-next 5/9] xdp: controlling XDP-hints from
 BPF-prog via helper
Message-ID: <YsRvzu4/cTmz8xmm@lincoln>
References: <DM4PR11MB54718267242004151337602F97BE9@DM4PR11MB5471.namprd11.prod.outlook.com>
 <b8085a4d-5ede-3cc0-a177-ad97fe08ce25@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8085a4d-5ede-3cc0-a177-ad97fe08ce25@redhat.com>
X-ClientProxiedBy: LO2P265CA0381.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::33) To CH0PR11MB5460.namprd11.prod.outlook.com
 (2603:10b6:610:d3::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6945fa2-14c7-4dd2-f2e7-08da5eab2930
X-MS-TrafficTypeDiagnostic: BN6PR11MB1298:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efsv5UXC2qgWJOKxm6sFqg45Vb0cYb6XB2zq6eHFhbdx/mWBpGPM42d0bPWz1qKg5XcisDsuqrJL967dyFXgC7QhwkCmCUcLnHKxOa/UtidL+1gq4nyqremNoZMnLG1HNAxpq0ILAqC7RV6cjmIWmTb5YcKe6WN2LH0/bj24hB7MP6HnUD1UIifCLQKnxqTOUjh0MITX5NERSO7plFA4zx2knBZNkDXn2Mp5f1etziODCxzya+01pOqooy6bugOAn3Hw5+oEzhXEcgBc2CYJdrDnZ+6Q8O4g1vz5Xii2ydQVH4DhsnIzqgDKr6+z51FEeD1t/+RHswVR838/6UmJP6q1KT8bIu1qVoWdmGGKxZBTtAPkZbSiCSf7bAldJaQYrst1l3K4ISJjQmCX5lSGkUXY7SdGemVgQHhI48R/ClDKsRVm2R3tRqt3sEimejOT0PFGVvx43XJwgNciLwsUQc6hrVddILNOhPJWzAzxWWnllta7KpCJvWInz7ciba/Pa2WKMgbg/gm3qPdIp8iM7+wM5F3Jg6Kz+yQhddt9Frhw1ep8cFx/KmJBief+tHDoSG4tprAcHGTCvpVTym1RqRMC+k2oAGDCqxipOt/gm/8cXepEwLBI7Cn4TvkP7tkT83fiEPkAKFjUv3lx/zvKfC9iHSMcUiRpKWvLQ6PsjFwoNkdWpJWQkP/2fUmPxKr9OA06fMJSb0MUhCHqYaFyYsND18tXKBfreOfPvDAMp5S4WxYqcC4Gx6hTQJG34GEGNz8xqEFJxsfYH//ymZAQL23i1DeM8R6aaJt22OJDGpbZA0wERp+y0VDTPZeFhSNa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5460.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(107886003)(186003)(38100700002)(66574015)(316002)(54906003)(8676002)(4326008)(83380400001)(110136005)(66476007)(66556008)(66946007)(6486002)(5660300002)(8936002)(86362001)(6506007)(9686003)(44832011)(478600001)(966005)(82960400001)(33716001)(26005)(6512007)(41300700001)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZmYJNLY43z31IUwkIUEVs5TvbF5s9DjNf+AJFcdt/7zHPqm2j6JC31qAkn?=
 =?iso-8859-1?Q?/5qwkk0FuybsIIbRqh/6Ephkaxk+nwTWj3wM1DU6yipqu5ePlSH/E5X/Lu?=
 =?iso-8859-1?Q?3kStGuxDBvdI0DGwTlW5VpOOz8OigEZ2c//5ZIoMMenfPb0PrQr6RhWk1P?=
 =?iso-8859-1?Q?wTIQrtr3obLTo1RaFEYvDbODW1rEea1JEMF7Q53tNgl8kuzbcJF6F0X2Ng?=
 =?iso-8859-1?Q?cEGqv4namTBiRiYzm2u1ieMjBxPha7JtJuAswtpECLcXG46tqlAMyBFFxT?=
 =?iso-8859-1?Q?sC1qmBjf+HC+f84NAqCABazk4kO1Y1R32H2bSJMtd+h+IR9gQUSN6K8l5a?=
 =?iso-8859-1?Q?6M7+UtSwByhBzgbWpz4fIkYvemll1qeymlTj7uZbMfXln4487RX++4KgMV?=
 =?iso-8859-1?Q?6FjYsMYoaZqYiFN2s4JXNcpZhCg21Cp8uOgdCmHL9KJ2A0yf+/63Pkisk3?=
 =?iso-8859-1?Q?xPnyEnvEB23ltl8khr4XKCmY6njTD3qy9GFo8VdQSUlDB2nDwPpCrRjRf+?=
 =?iso-8859-1?Q?HiOvQ0TVFo5uTp+us9j7I1Pkkz1dLz8DQ/E5rOZCylv//pYlyxmDgukcQM?=
 =?iso-8859-1?Q?JHvuvRZF1E9kSlzs1dlRrEbPvABqxUaG+RUKlv17Z5kM90jqQS4Wo1tv1G?=
 =?iso-8859-1?Q?3Ogq8qIYzYgJ4R32Dtfp+13ymmXZppRXF4sWVCzFTpWo9HeBYv3hB+FNtq?=
 =?iso-8859-1?Q?wpXGB0bZkkjg7dTrOoN55VY5bd5uApnTe8Cp9hKpZAqZsfjhfY27/eFQYr?=
 =?iso-8859-1?Q?aJiQ+MT1KtShBeFz5W/pQ8hHZ09MOE2ynXpqT3fRF+D6bMmj+UyOXZJYpK?=
 =?iso-8859-1?Q?l0qrK/JEGeO68CE7HTIQfXR5dXcuNDkNILZkNGF5izegNC6N4G3uQkMede?=
 =?iso-8859-1?Q?A4sge/0Md0jNLkq/XPPe7dN5LAnTfwFleeCf2DYXJSPoo4ivoMZJ51EOs/?=
 =?iso-8859-1?Q?FF+8DPyieRu4EzWEYe6Ab8+3nM5FDARV3Ny0YQYsalT7mdZBeSJ6cpx/Ms?=
 =?iso-8859-1?Q?mOXStF6EnbnHHDoV2RInaR7Ur11M454CYg4/A/AvRcr6AuNS4MXbfSRVQP?=
 =?iso-8859-1?Q?ZGZ8eTsuvRy7O4shK/FbN0+T/TgTHa4C+kC9jA09AeMMaySy5J/F7H1cX9?=
 =?iso-8859-1?Q?AAFdt3Z/REWeaZQTrRcWyTB7zOwl+YGtQ3VrrG2pvv5ov+mWwnGD/tk94K?=
 =?iso-8859-1?Q?Fq3ftukKVryqTTbcHpTyYTRxrO20VG1Eyh4IvJWKvtCRQiMrknuNVi7Pkr?=
 =?iso-8859-1?Q?LWz3ur/Nlj97cbFIZMrR/WrBZMS7daT9lMuAY/pkeIy+Bk1baFf1Uvjico?=
 =?iso-8859-1?Q?N+BYHRL/C3uWRcKl5oOQ3E2tICamAhHqI2ZV1aij6EGtNQJ3oro+F/BRxn?=
 =?iso-8859-1?Q?2ZyaDiaofcnEml0y52sTHm+m/zrRbv/zi21O7ysTHdz3SbGAAKyh096Y4d?=
 =?iso-8859-1?Q?CArqz7Q+Gg5BQsI50uQNNlcEnfHQLkxm4x3CeoSEpE5m2FImUvjgTVTXtg?=
 =?iso-8859-1?Q?n06GWMwCnvHIAfsx3dARwRRQBdd6Mk0m6c4x0monkna/v+7zVDGjX7bh4m?=
 =?iso-8859-1?Q?3XHSxCu/6Y4L4s68UaCK0qvq0qVbhN40iK5WiDvLt1aKxPDpYzAg8fQs63?=
 =?iso-8859-1?Q?V7vWmQIY2UrgJZLM+sxrsdrF/2GYxIZsOfnlEwAmsUNyGobVO4lc30EQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6945fa2-14c7-4dd2-f2e7-08da5eab2930
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5460.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 17:24:05.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyaYY4PwYN2VX78d3xPqBv6+eilrAPuKamMc7etOncOs5VtfrjS1n8ushEGFQw1OzwyuWp39uxth+EdfisrfA6s1yxYdGDISrKCg3Ue7WXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1298
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 04, 2022 at 08:26:15PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 04/07/2022 13.00, Zaremba, Larysa wrote:
> > Toke Høiland-Jørgensen <toke@redhat.com> writes:
> > > 
> > > Jesper Dangaard Brouer <jbrouer@redhat.com> writes:
> > > 
> > > > On 29/06/2022 16.20, Toke Høiland-Jørgensen wrote:
> > > > > Jesper Dangaard Brouer <brouer@redhat.com> writes:
> > > > > 
> > > > > > XDP BPF-prog's need a way to interact with the XDP-hints. This
> > > > > > patch introduces a BPF-helper function, that allow XDP BPF-prog's
> > > > > > to interact with the XDP-hints.
> > > > > > 
> > > > > > BPF-prog can query if any XDP-hints have been setup and if this is
> > > > > > compatible with the xdp_hints_common struct. If XDP-hints are
> > > > > > available the BPF "origin" is returned (see enum
> > > > > > xdp_hints_btf_origin) as BTF can come from different sources or
> > > > > > origins e.g. vmlinux, module or local.
> > > > > 
> > > > > I'm not sure I quite understand what this origin is supposed to be
> > > > > good for?
> > > > 
> > > > Some background info on BTF is needed here: BTF_ID numbers are not
> > > > globally unique identifiers, thus we need to know where it originate
> > > > from, to make it unique (as we store this BTF_ID in XDP-hints).
> > > > 
> > > > There is a connection between origin "vmlinux" and "module", which
> > > > is that vmlinux will start at ID=1 and end at a max ID number.
> > > > Modules refer to ID's in "vmlinux", and for this to work, they will
> > > > shift their own numbering to start after ID=max-vmlinux-id.
> > > > 
> > > > Origin "local" is for BTF information stored in the BPF-ELF object file.
> > > > Their numbering starts at ID=1.  The use-case is that a BPF-prog
> > > > want to extend the kernel drivers BTF-layout, and e.g. add a
> > > > RX-timestamp like [1].  Then BPF-prog can check if it knows module's
> > > > BTF_ID and then extend via bpf_xdp_adjust_meta, and update BTF_ID in
> > > > XDP-hints and call the helper (I introduced) marking this as origin
> > > > "local" for kernel to know this is no-longer origin "module".
> > > 
> > > Right, I realise that :)
> > > 
> > > My point was that just knowing "this is a BTF ID coming from a module"
> > > is not terribly useful; you could already figure that out by just
> > > looking at the ID and seeing if it's larger than the maximum ID in vmlinux BTF.
> > > 
> > > Rather, what we need is a way to identify *which* module the BTF ID
> > > comes from; and luckily, the kernel assigns a unique ID to every BTF
> > > *object* as well as to each type ID within that object. These can be
> > > dumped by bpftool:
> > > 
> > > # bpftool btf
> > > bpftool btf
> > > [sudo] password for alrua:
> > > 1: name [vmlinux]  size 4800187B
> > > 2: name [serio]  size 2588B
> > > 3: name [i8042]  size 11786B
> > > 4: name [rng_core]  size 8184B
> > > [...]
> > > 2062: name <anon>  size 36965B
> > > 	pids bpftool(547298)
> > > 
> > > IDs 2-4 are module BTF objects, and that last one is the ID of a BTF
> > > object loaded along with a BPF program by bpftool itself... So we *do*
> > > in fact have a unique ID, by combining the BTF object ID with the type
> > > ID; this is what Alexander is proposing to put into the xdp-hints
> > > struct as well (combining the two IDs into a single u64).
> 
> Thanks for the explanation. I think I understand it now, and I agree
> that we should extend/combining the two IDs into a single u64.
> 
> To Andrii, what is the right terminology when talking about these two
> different BTF-ID's:
> 
> - BTF object ID and BTF type ID?
> 
> - Where BTF *object* ID are the IDs we see above from 'bpftool btf',
>   where vmlinux=1 and module's IDs will start after 1.
> 
> - Where BTF *type* ID are the IDs the individual data "types" within a
>   BTF "object" (e.g. struct xdp_hints_common that BPF-prog's can get
>   via calling bpf_core_type_id_kernel()).
> 

AFAIK, that's the most correct way of distinguish one from another in 
conversation.

Would be still great, if Andrii could confirm that.

I should mention that out patch makes bpf_core_type_id_kernel() return 
u64 (BTF obj ID + BTF type ID), but your statement is true for current 
libbpf version.

> 
> > That's correct, concept was previously discussed [1]. The ID of BTF object wasn't
> > exposed in CO-RE allocations though, we've changed it in the first 4 patches.
> > The main logic is in "libbpf: factor out BTF loading from load_module_btfs()"
> > and "libbpf: patch module BTF ID into BPF insns".
> > 
> > We have a sample that wasn't included eventually, but can possibly
> > give a general understanding of our approach [2].
> > 
> > [1] https://lore.kernel.org/all/CAEf4BzZO=7MKWfx2OCwEc+sKkfPZYzaELuobi4q5p1bOKk4AQQ@mail.gmail.com/
> > [2] https://github.com/alobakin/linux/pull/16/files#diff-c5983904cbe0c280453d59e8a1eefb56c67018c38d5da0c1122abc86225fc7c9
> > 
> (appreciate the links)
> 
> I wonder how these BTF object IDs gets resolved for my "local" category?
> (Origin "local" is for BTF information stored in the BPF-ELF object file)
> 
> Note: For "local" BTF type IDs BPF-prog resolve these via
> bpf_core_type_id_local() (why I choose the term "local").
> 

Every program during CO-RE relocs sees a single local BTF obj, in which 
BTF type IDs start from 1 and correspond to all data types used in 
program. So local BTF obj and type IDs inside are valid only in single 
program, therefore u32 type ID returned by bpf_core_type_id_local() is 
enough.

Local IDs are not resolved, they are just assigned during compilation. 
After program load with CO-RE each local type gets a resolved
vmlinux/module BTF obj pointer and an ID of a type inside this BTF obj 
that is similar enough.

Both local and target type IDs are mainly needed just for comfortable 
iteration inside libbpf, so they are just a side product that is only 
patched in, if we use bpf_core_type_id_local/target() inside a program 
for testing purposes.

> --Jesper
> 
> p.s. For unknown reasons lore.kernel.org did match Larysa's reply with the
> patchset thread here[3].
> 
>  [3] https://lore.kernel.org/bpf/165643378969.449467.13237011812569188299.stgit@firesoul/#r
> 
> 

- Larysa
