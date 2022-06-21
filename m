Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BED155291B
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 03:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiFUBpz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 21:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbiFUBpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 21:45:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB419C1C;
        Mon, 20 Jun 2022 18:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655775953; x=1687311953;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uXVuax5kNi1lt2QvdwVUJDzlj/Lrx9tVlfYlqaeanOU=;
  b=VViDDlLzm2fTUIvTyBvAgRO1FtyPPUdA7OEpD6NaEUYKjKJa2c8kRXvb
   /H5H0gqxZnvszndAhjOcVY4EVADQWEqUF6bMzZ/sbVT7WuX3H4abodoRh
   oHjfwOis8E+41YwuLDKLe7uY46XzCC9darFXjuD028knQQxgQXowCWFtS
   iyHGHSxdRmVub2VuuFxwIPPO1Mj5Cgk2ZR0SmAfwLzDB42WUv/Dp/w1En
   xXKMLuDTg0EirDBJALXGL1Hq4+ElnqvS4ZnICamhQK28c5Hm+3cU+wTrs
   z3P1w7wLtkoI7//NDVj6cUSYAznxVebR9yC0juZ3xeCDPtH16ylR/lfpK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280732919"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="280732919"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="654922735"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2022 18:45:53 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 18:45:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 18:45:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 18:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd8k5MLYG8xmjpX+otmceZd1cUQ2jERapewm5sbV3xmehdnU+paqav5KxPjyzcjjQBr9rufarRE7FLKOoN8takbszW9nZaAXF6Z/SwuuA8+czK8rJTAGES9Ei6XBUAXtbVJn9maSFF7jP7KzwqZN8PjtJx6MCS3dPamlwLBxGQQUsf1CKqoxlo1pS74gKyJUgTOTyH0mdjvrAFQhwRUzE/4OaQadJgkyOxlsdIT+91A1J97tJUpZTmxy1Mxtz7tR+BquLVj5+OupjOK4CT6I3Oo78y8xpYaGJsvBefvvs4t8Jvo+L8femI7B/IfsI+w3fxYxGwV4AgAMl6GNTXSe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNOqJJ+q3uwSDjz+swvD7k/opZRkfOiTQFxa8LjqKL8=;
 b=a+3nVuQoWlm5F1oB7T/+IAthiMcVGqPA27/S/CUKOpItMwLzCO2ym1Hm9ISBrLexAAzx2bV7iGUjLqYGTcey0xO4tqGP8B54+Ihauhv5saP1NklF+1HBx/ZHDLcip0R1Xqc9S71FB9koqFzmr5Y5x+/YXZ4c+Mf+6csgkob8AzpuHBr6HiwDur6J/zpSXJOG8HwvxgRRsCfnf1gzpCs9VldSz0ktHr/DX+ihIz2i6HdVnLHHEiDx0HGfZFEhSlipgn3Cu9oH3ESvZCSfp+rY/ma8s03dXPV6INFZPRH3i7UO5SPjIfiiyEqSYwhN7Vaclf6a9p9c3hjUN5RR2lt86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM5PR1101MB2169.namprd11.prod.outlook.com (2603:10b6:4:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 01:45:50 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::b513:4291:3790:a5a4]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::b513:4291:3790:a5a4%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 01:45:50 +0000
Date:   Tue, 21 Jun 2022 09:45:36 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>, Song Liu <song@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <peterz@infradead.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next 0/8] bpf_prog_pack followup
Message-ID: <YrEiwHGs4vY+wLsx@ziqianlu-Dell-Optiplex7000>
References: <20220520235758.1858153-1-song@kernel.org>
 <YrBV8darrlmUnrHR@ziqianlu-Dell-Optiplex7000>
 <YrC9CyOPamPneUOT@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrC9CyOPamPneUOT@bombadil.infradead.org>
X-ClientProxiedBy: CO2PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:104:7::32) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23be053c-f048-4a86-c484-08da5327c52a
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2169:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1101MB216999033220BC2983A9C35A8BB39@DM5PR1101MB2169.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJLZjz2K/b8FhJINO0QB6usmPfgrl5o92tBiE5F3EF5ZhdWi+zr3vXejMH8F3q8KOpj4bc7iUs8KKndZx5d6I3mmiEQA/xmAKe7LPOs2rR8VUblxmwkSxDU05qccY84BU7YQ6Lr0bI2zFV7fuX1ismp+AyK8Ts9rzZo8VsF432mG7FrFJ1SbwxgUX/4kfOWNhPoQ2XG6QSRKiOHnYlIGCIa7HtyBxv5q4nqiOKaVANto4EQlXg42B6hFTBrWYjjF+buqpqOvo94gMjndMhCXgG6weHV2AUAtgfWO4eZ5l9fym6SjEUdB1vz35ZwQO/7Re8jItP1lvPtX03rhbmMwvF6eVrmZOaVB7V4zXKfvRPoYYv6VHnv9CY4X+nbFiPYFxAEsHSSQDUMDzFz3SLkcKU7/p6T81vVNuSkmJhQ88RKy6cdNI++pcxtZf/9E+WuaIGN0U4Hw+/wg890aIAsh+r3tOW0CiM4bf2Rybv594g0Bb4McMgrso+MIwC/MICZn1O3lgs+eg/qbzcJZ3APa7N696M3RmFSfRrO1Ovk0MhmHE++rb469/mqPW9RgLLdwNgCmnxSM1euIePIKa34Ga4W5QMQprpKvvvingMAWVkqzlbsg5gCv1KoCO6XevPUwYKzWuu2twq/auBTdd7wxQGK3OfYM059AC05T/feF5x+rxcQDUlnNZ1cRPkhlUIwPmD65tAQy+yLoye2eLJX08EGhW3h//pX44K1L+V3d1JTmfAg1r7gDvbwYAEmlpotVueMZQYtUMvMickhOwBJL2o/Zxq+7Aec99FgUHBLmdt4Z+dJDsvNB8aJE3z2SehsORgaKkUW7viTxLuhz2PEhVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(376002)(346002)(366004)(396003)(8676002)(66946007)(478600001)(82960400001)(4326008)(6486002)(54906003)(6916009)(66476007)(966005)(66556008)(186003)(86362001)(316002)(38100700002)(26005)(41300700001)(2906002)(6512007)(6666004)(9686003)(8936002)(44832011)(33716001)(5660300002)(7416002)(6506007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZrIhpxiR/CJurQpcDaB1irr6LMdld/hxrDsQFxcn1S6l0DVZHE3uyi/bcEnh?=
 =?us-ascii?Q?bH4GwiOA8N/spBbHxqU6HpYMGn1jnA9pL0B+B/bPfXPr4IYEb9AYgVODKcjx?=
 =?us-ascii?Q?tRb/PFnS7Xnuz0/kki1PCwp1+7K31RwhcAypOOr65BwDKQVqd/wBRfDDqAZv?=
 =?us-ascii?Q?EXggTFXbVBCOfMinuCrfekuGHKibIxiHtBbPWrahNQe4c2fLRCnYgBQUBbnU?=
 =?us-ascii?Q?Q9sIn9IlCX5lL0tuGwuvXFb9FGTIHkX3Ib4Lglu1E8CnS9iH8iqE0+Z73SpN?=
 =?us-ascii?Q?a1PrRr75MF2naUhEa1wvoqeunykybNwifJ9VFawBA9n1DnnYoT75Ns9UBz3m?=
 =?us-ascii?Q?QbEf1U0+8e5rk2RUh4s3BCvX9YQ/Ba3bbqNnlYDCEixxoWYi1pGN0i7Blzxl?=
 =?us-ascii?Q?05vfXsiLhV1ZWaONaWdlTpYQLaBe1PftOCV14lt8ICku4/BhaxlmYV0oChQj?=
 =?us-ascii?Q?dJ0Qbo/8NI1H/6vJnt4lErmYhKnlAWHsL47D5wjbUgry1PcxnAj70Pjr70Ai?=
 =?us-ascii?Q?XQTIWKooOw7dtL40D/h/iWzqKRsjqrz7Z9X1sCJzzkRidIvxy0FPJ9kjAiUx?=
 =?us-ascii?Q?xDQAASX7BUGAX809lCZFvIG9zBh0jTjEvXjKGj5Y2MROZF50aG7oFglk8Mt1?=
 =?us-ascii?Q?jiAfIYjcojERfLKWiyOrTP3ytVRftcO0UZbArmlZbdYuOL4ub0DfbfpZTeL7?=
 =?us-ascii?Q?9xwB2XrWkUkpT7mrX+T/Z+ISdy8d4VF6VF/vMicnX0FuCN3UMxUlQK82W/cU?=
 =?us-ascii?Q?tOjVZ52GC7FOYgu0QLjTZgOxAY96krliy0uNodFuWD5QzS3zoFs0SxJefG+w?=
 =?us-ascii?Q?QUJpga+26I2cmVa9vRumiQQW27NK0TJWLYRjYPS1EQHwJA0loJ9GAJ/fU0da?=
 =?us-ascii?Q?+v5LGS8hDFXPxmzFrjrY5jVsOBrfFEzuI955EOsUr6LfPiChmksyoq98e2ct?=
 =?us-ascii?Q?57tGPVyl0ix7iGDWboZiUxSI+OVFlSGoPAcLCUNJzzl+rEXlvZSQWkijzBI/?=
 =?us-ascii?Q?NDipCESUDgR48Z4zyEQh+LUux0rV8kG2HkAUPYJYnh1++cGImGxJI7fijYxW?=
 =?us-ascii?Q?yzM2n7zA9EoJTAYZO5wxsISyRUi+FcaK7V6RIKu7kSwT3v/PSgEwHjNSTw6l?=
 =?us-ascii?Q?TR1v8JJkxj1TGkA3YnjSuUnYMF7FD8TgLV2w2BEemXu4BoG/U94DcnTrZxzT?=
 =?us-ascii?Q?kKmCJlPBVRun5y8hAwTvwjWx+qqDQxlJLpxM71U9LS5FXbGmpiVvpYBvIakU?=
 =?us-ascii?Q?gjppEgs1gDvSW4fbfvIbw78oohXBZhMZ292/tzAndw4nVTNZsVOFzGFH6+xI?=
 =?us-ascii?Q?/w5zok4mEij9VNptoepDl3H+zfwN77AimHC7+MmDc/r4p4lEnArRLkvaTCMR?=
 =?us-ascii?Q?kxIxxSCihKaryUAPsf89OiFCSDv14gpTVACaSr9MbKM26zmJHIwr96ECClHv?=
 =?us-ascii?Q?4a5AqX3woCgJdQFF2uLM3EaPBNshh+Tt+rH8WTzXUFPk0D8GNHd/zSkZfheX?=
 =?us-ascii?Q?YN65CcPrKc9kqR/0iLorMuYPN/Ehx26qz9WHuWyT4NpGVVyVum6IBkZiAuNP?=
 =?us-ascii?Q?o+fP7MCMtLf+sSABy9m6Fjc7FJrTOyZ5KEar/pbBVuLzeLABUBoOE+DjI2IU?=
 =?us-ascii?Q?enOWYmr0yvw3fWKUZsDG+l9SlzPFkbQKYj1SrCIUEB7ihLuFxhLX5qRdEYyU?=
 =?us-ascii?Q?k7UD91PvsgIYa4jx+ER1IhUeH8Ilre0YVUlQAZQN7pAS+tbKdu9r9MaJs3Az?=
 =?us-ascii?Q?nA8z+tRRqA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23be053c-f048-4a86-c484-08da5327c52a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 01:45:50.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvxuNiUiKO2PYarSiAeEwgc67hGNFPamgItoME6JA3bAEJ/tQzCbhOMuwlTTpOlQbMC31qh2tAtqj53Rz8DUxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2169
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 20, 2022 at 11:31:39AM -0700, Luis Chamberlain wrote:
> On Mon, Jun 20, 2022 at 07:11:45PM +0800, Aaron Lu wrote:
> > Hi Song,
> > 
> > On Fri, May 20, 2022 at 04:57:50PM -0700, Song Liu wrote:
> > 
> > ... ...
> > 
> > > The primary goal of bpf_prog_pack is to reduce iTLB miss rate and reduce
> > > direct memory mapping fragmentation. This leads to non-trivial performance
> > > improvements.
> > >
> > > For our web service production benchmark, bpf_prog_pack on 4kB pages
> > > gives 0.5% to 0.7% more throughput than not using bpf_prog_pack.
> > > bpf_prog_pack on 2MB pages 0.6% to 0.9% more throughput than not using
> > > bpf_prog_pack. Note that 0.5% is a huge improvement for our fleet. I
> > > believe this is also significant for other companies with many thousand
> > > servers.
> > >
> > 
> > I'm evaluationg performance impact due to direct memory mapping
> > fragmentation 
> 
> BTW how exactly are you doing this?

Right now I'm mostly collecting materials from the web :-)

Zhengjun has run some extensive microbenmarks with different page size
for direct mapping and on different server machines a while ago, here
is his report:
https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/
Quoting part of the conclusion:
"
This leads us to conclude that although 1G mappings are a 
good default choice, there is no compelling evidence that it must be the 
only choice, or that folks deriving benefits (like hardening) from 
smaller mapping sizes should avoid the smaller mapping sizes.
"

I searched the archive and found there is performance problem when
kernel text huge mapping gets splitted:
https://lore.kernel.org/lkml/20190823052335.572133-1-songliubraving@fb.com/

But I haven't found a report complaining direct mapping fragmentation yet.
