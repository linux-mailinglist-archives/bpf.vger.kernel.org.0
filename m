Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C03552901
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 03:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiFUBcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 21:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiFUBcI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 21:32:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D0C1928B;
        Mon, 20 Jun 2022 18:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655775125; x=1687311125;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q8EhQWiAviO9a39jCuse2nrwzh4Jxetco+8PyvCwXzE=;
  b=R2gKOXZN4T6zjGmsS4+oPHvhVJLiMGpAJUgr7EmAQCFbCO/UPI8xfFmZ
   XOBEaoTgKagrAxxVtI3OcqEIkhp9579oe+/ZmMI+C4g53KEt1Hiv7Y09R
   RZgPn7J6cbQ1qbiKV8b2brOu8ZOqUosLR2YXrQsR8T17hfnlc8h3jraZC
   p83+Rute2469IG37HTfeMnaG4oe2eevEAiMKgYsx6p6HNr0+xtmGwERPK
   RI6FPe/DjOC85zOuzCWcT9xbVrDtAKVz+7X1hsipWBK+jqSKdxOfRd7pn
   RhVGe7dynf9H8fvnTee+OTDiwZDFqKN94lc4V1jpo9Ws6vLDNhZ9yecoG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="305437905"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="305437905"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="643368641"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2022 18:32:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 18:32:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 18:32:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 18:32:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 18:32:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH7/oAxhlu/KIq5S2FSpcl1Db85bKOmfOulBbeztBZ1Pnh8IQMijdncOS2XwGqs+WvKMMemwS9N04DEYf6g3nG4rkXkFV+wbfU2cCek74ckzdKekKzOlonXG9Av3+Kgy5vxNv3HUwlYn6sYKy1Dx8P/t2dQo0SoFzgu7ZWfD3mcGzbKoM793ONcJFkKmrzV+r6FK0oFLoQ2SuX8MvkgibBrBBt9GHAipOuoD9W2poVctuusNvP/HPbOxFksMpf6BXLDhT8dlH0N5FQuPRPNrRYJKcMcT0A+B6orNGTG2c72GRS8R8LX2I3LiGVvYYcai5M/tEtNvwfzPl7VNO6MN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U36ytHc5OmDM1RubUdHdVQHo6uARF18FyxKJqCxKaNU=;
 b=gKuPQidFaMtTP3bfyizJZBquA5IrJkwqmbX7wddyaavAmsvaIg2b+AcfsPs9mj5HQ9yZ4LPlvaZbTKnfJCkzPSKSr8LPfzaeZO/E2jkKCtL1veZ7MGTOKitwWM7/yAZFo6u5Ht4yYVuOU/y7jFRp/pOV9shcBHboXRw9CKEBougYaNHf3LrQx3ruEHX69G3DE33LEavp4HjsXdOMGHNrQAoiMC/1fhXKehELpfJyd8Wewr7DcjfjQcu5173sn8b+hcjELDhHd7jSH2iM2aF6T3wzcoZ88GiF3c7al/euD3+Ygs+VtIAdJjw6jopIDK7JGYGvu9fWw9WejaYv52eXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM6PR11MB2617.namprd11.prod.outlook.com (2603:10b6:5:ce::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 01:32:02 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::b513:4291:3790:a5a4]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::b513:4291:3790:a5a4%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 01:32:02 +0000
Date:   Tue, 21 Jun 2022 09:31:46 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Song Liu <song@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next 0/8] bpf_prog_pack followup
Message-ID: <YrEfghUwr+IO2MM1@ziqianlu-Dell-Optiplex7000>
References: <20220520235758.1858153-1-song@kernel.org>
 <YrBV8darrlmUnrHR@ziqianlu-Dell-Optiplex7000>
 <CAPhsuW5oqJKHUr6wwbFyC8DFyawKr8djuv5Bjk7FEQ5dnKDGyw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPhsuW5oqJKHUr6wwbFyC8DFyawKr8djuv5Bjk7FEQ5dnKDGyw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::35) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d7a51bc-92ab-4aef-be99-08da5325d7a3
X-MS-TrafficTypeDiagnostic: DM6PR11MB2617:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB2617531718D412BF2C2C97148BB39@DM6PR11MB2617.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNI4CD9uDKkjGyqzgzGPC4c0O7JgxFQS28Dquon7dQRv/aV3Bu7FBFata2Mdy8DfSHgTUjUPz9psIL+pwBAxukRUXqxM/tLMmdRHJGWKDRlkp0Xpv3bYhY0XmiDKwDPSdeHydVsZH7+UdzCBSgGTR6qXP9Vpfi3h4tPXwgp/1xYE1FtRozKhUb0OQXOQvXcIM2rWrOEx+ktVZVVsL37jEW7n6ek6/i5q6MtmOSyjal0IxB0VaeIyIoEjy2li8L6N4aLMSOB6bgqrN9wYBQ+N+O4Jum+wE/dMqpKYwDsu7joMPMb2snQXRlQDfSj6m9XyWaZsu3W4P3p6BZT1w7m+at9Mv6qF+X7pl+RdC8Go8A2DfwFc5Qa4mX/bfGKbzAGCbxvIlmPhrAFcKK0IJ5aNoPIyWptCmZfmq747aWE2dBwn6Z47wMh6qxnltsa3keU6K+AD0mLhdWfVOwYJ5WGAVbF1JNbhSGTFrBRlDsD9gpAnSCh7l9L/6nZlAgMsb/gSOCZaaAFzQJlZFvlYS5bqyB8vx289tDAJxxhVMhZWA42vGHlaF6oQXcH3PTrpJKHkUJhG6s8Ww5nJFKWTuJ0n78If9vIwC57Qrho5qGQwv0iwkuoSLP3TOJS9Qt9mus4oZ+xQiTso6gnGKoYdhBFeluAb0hpAPZ0sLFlw14HzWyzTDZTp7nBULK8FI6jLrssL5gZuZWEHwwwm9MsIIf6d8HHGR8TpsbEJO63wLDd0k84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(366004)(346002)(39860400002)(396003)(53546011)(44832011)(4326008)(66946007)(8676002)(33716001)(6666004)(66476007)(54906003)(66556008)(6506007)(8936002)(86362001)(82960400001)(5660300002)(7416002)(6916009)(316002)(6486002)(38100700002)(41300700001)(478600001)(2906002)(186003)(6512007)(9686003)(83380400001)(26005)(21314003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OdFuG9bDwh5LOjgOTQkv/xjSDilzotYC1zayu4QXFYQB30Xja015NpiJZa4U?=
 =?us-ascii?Q?T95zla81Sr8YsHo8btsinpmWYtIGsZQTD8mG9OrEcsyRkbo16012XO3NOSB5?=
 =?us-ascii?Q?0K79fuLjudObd9+1OCnBnAvCxez44/9p6IXwM/pTikFPFCuy/S+cdyrZqLfH?=
 =?us-ascii?Q?m4maM2/O0A0Tntu2kARufKoM2pTzq97WdxE5Af21mthwyL/ZzmkcWNJfQoQS?=
 =?us-ascii?Q?Mko5Sx+w3vIaHxQfzr/leHQd36zFnr6OIq6jvcCLO6GthYjMPnpS/qbZTmSA?=
 =?us-ascii?Q?2X4Mds2urv/Jcldvr8MRA9QmLMpYSnboDIrJksQ4wbOo8sYC2q/0ZK0u+ta1?=
 =?us-ascii?Q?xp7+S8btKD+tOvbyjbaXKjJTryFvU7a+gRYBy+S3ogGE55spmDZjPHKzG5MW?=
 =?us-ascii?Q?Hr1LBjkmn1fVk48VBaJKg3VgcnrAys9X1ozgRNZrKYwitLIyL00tFOPrmrN0?=
 =?us-ascii?Q?pqzdwd+knGhoWX9l9Tf0Q2M9LD3IEKncc2eQExVje/47g0Vm+6/fEpmH+bR0?=
 =?us-ascii?Q?BviFI2P4A8hfq/+kM7qF6Hgt/BkloB6/2W1p74ZbjwE2xvUQMN2BT5NSgSs2?=
 =?us-ascii?Q?Bxfz0RtMrGMIXZYsLR/12YaYRAhPhjHyHZFUkhTWPukf/hJgRZEEOF5FViuC?=
 =?us-ascii?Q?ZOrNRq4p5Q1j7Q7VZilDcLb7kbVqGzxXnWAzoSoqQsUxPqHuF6310ZBlhOWH?=
 =?us-ascii?Q?gDtc9NMCXqTKWtaeirTiG1DBZLBkAeSd2OYFccHMP9MVuydVpjB6d4ehDkvp?=
 =?us-ascii?Q?CXwNNJLTJEc4kzgh5kIwUiXodwoFD3R08LLNfmWnmuZeScnqnMxeHilbGkIe?=
 =?us-ascii?Q?eh4NKNoZwpEOvmqbndbah/sF1x5+pvzT5T7P7omoE1g229ziglO/SMf+ldaS?=
 =?us-ascii?Q?nfs4HIzs7ZhyQzGZ23QE2eUHKtC1YuQuXKZ75SJvgwlcQkKGpd2y879tusL3?=
 =?us-ascii?Q?VzoGXvdVPBsAgidzxsxRsNCrwUvCCmIqWO23Xu0A2wzEZgXfSq0303EP88T2?=
 =?us-ascii?Q?Ef2pVUv9yK5te7+AG/44bxmkbQPQAIDKfPvRmSHz2Y6trMIRJ0v+dpHmzgN7?=
 =?us-ascii?Q?eBbUl6hQTPEkcpgYfv3ev6IJUvy7vE255wLnXRp00Eb0PBb/iBlmzutaeq0j?=
 =?us-ascii?Q?jmVWl126bSHlNSwuxyth7SW0juK1Sgs5Kq2HqstVK9buKg5FgsnLvSM4LUMy?=
 =?us-ascii?Q?MK6r9R0GXNEDP8alXpLwuEYQHfRR+B2PDtppylnWNde8KtRh2Ujsks7rgxOk?=
 =?us-ascii?Q?qUxlwPcyBWi5o+4jW34lc6DknKKTlPt8GIaZXo6o6OrO0+nqwtagX+D/BGCT?=
 =?us-ascii?Q?eLly4WT6w5XS4qAftEbuAQBtN+9aWix8Uzxbzgfayn3COLM+d32lgXJGc8Sj?=
 =?us-ascii?Q?zY583H1b7Y3Ju5QVZcsLcCMGIzOJWE5ILNIJ8rvq9I5WZwMBV4eorMxL64mD?=
 =?us-ascii?Q?mxwyNMvmZ3zQHLb1xsVvjCM0CrnuT4OlkQ8mxt9KFTQfS8iKyF7hudhAtq9J?=
 =?us-ascii?Q?j87GMTkwh0vE0/kOfoFW2q45PMVZtUYuPCFVeZBG4i+nzIs/Wycr9594t4pI?=
 =?us-ascii?Q?kz2BjTrp/ic6FPi9bA1oD0MNdVX5xzFP5udPwGSvU6JA1eKipXuM1vuXdxMv?=
 =?us-ascii?Q?XQGYlUFtHmxneIls0eTfgL6BXWA5sf3+RWG+DDJHf3i12iyivcMXgMXej84j?=
 =?us-ascii?Q?cPERtU8CWvfqkw6QUTp7Lw2gXsXh9QEJto5VxLto+dB6Z4STuIho/Zoq4Rya?=
 =?us-ascii?Q?tfGwGXi2lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7a51bc-92ab-4aef-be99-08da5325d7a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 01:32:02.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zspN84/KB+M5cW9cQTlII6mfdSkYyrFwLYSZZkvLhSg5vH/UckKjjpXt+cVSsbOixteEjA6/CCgx8CvzY5HaQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2617
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 20, 2022 at 09:03:52AM -0700, Song Liu wrote:
> Hi Aaron,
> 
> On Mon, Jun 20, 2022 at 4:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> >
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
> > fragmentation and seeing the above, I wonder: is the performance improve
> > mostly due to prog pack and hugepage instead of less direct mapping
> > fragmentation?
> >
> > I can understand that when progs are packed together, iTLB miss rate will
> > be reduced and thus, performance can be improved. But I don't see
> > immediately how direct mapping fragmentation can impact performance since
> > the bpf code are running from the module alias addresses, not the direct
> > mapping addresses IIUC?
> 
> You are right that BPF code runs from module alias addresses. However, to
> protect text from overwrites, we use set_memory_x() and set_memory_ro()
> for the BPF code. These two functions will set permissions for all aliases
> of the memory, including the direct map, and thus cause fragmentation of
> the direct map. Does this make sense?

Guess I didn't make it clear.

I understand that set_memory_XXX() will cause direct mapping split and
thus, fragmented. What is not clear to me is, how much impact does
direct mapping fragmentation have on performance, in your case and in
general?

In your case, I guess the performance gain is due to code gets packed
together and iTLB gets reduced. When code are a lot, packing them
together as a hugepage is a further gain. In the meantime, direct
mapping split (or not) seems to be a side effect of this packing, but it
doesn't have a direct impact on performance.

One thing I can imagine is, when an area of direct mapping gets splited
due to permission reason, when that reason is gone(like module unload
or bpf code unload), those areas will remain fragmented and that can
cause later operations that touch these same areas using more dTLBs
and that can be bad for performance, but it's hard to say how much
impact this can cause though.

Regards,
Aaron
