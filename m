Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272223903CB
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 16:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhEYOWY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 10:22:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:21725 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233401AbhEYOWV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 10:22:21 -0400
IronPort-SDR: KMRGm6+GbOz9S5ud2XrskwDHqHmbn9oAnk7iCFHp3ZFYXXcfLrx3EaNHPDmHQ4b8DOXtUJl3uo
 yhbJb5+QvF7w==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="182526074"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="182526074"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 07:20:49 -0700
IronPort-SDR: a/ucslzu/pf29G3EpehzGiPIQpcK/YqozMsNAoZ0ndRCxzJiJe0gADLezjcWQj+gflG9z8X2Gr
 7RL6+ur7DfeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="546795089"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga004.jf.intel.com with ESMTP; 25 May 2021 07:20:44 -0700
Received: from alobakin-mobl.ger.corp.intel.com (hskrzypc-MOBL.ger.corp.intel.com [10.213.6.192])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 14PEKgAb015423;
        Tue, 25 May 2021 15:20:42 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Saeed Mahameed <saeed@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Kubiak, Marcin" <marcin.kubiak@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, bpf@vger.kernel.org
Subject: Re: AF_XDP metadata/hints
Date:   Tue, 25 May 2021 16:20:27 +0200
Message-Id: <20210525142027.1432-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <87lf85zmuw.fsf@toke.dk>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com> <DM6PR11MB2780A8C5410ECB3C9700EAB5CA579@DM6PR11MB2780.namprd11.prod.outlook.com> <PH0PR11MB487034313697F395BB5BA3C5E4579@PH0PR11MB4870.namprd11.prod.outlook.com> <DM4PR11MB5422733A87913EFF8904C17184579@DM4PR11MB5422.namprd11.prod.outlook.com> <20210507131034.5a62ce56@carbon> <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com> <20210510185029.1ca6f872@carbon> <DM4PR11MB54227C25DFD4E882CB03BD3884539@DM4PR11MB5422.namprd11.prod.outlook.com> <20210512102546.5c098483@carbon> <DM4PR11MB542273C9D8BF63505DC6E21784519@DM4PR11MB5422.namprd11.prod.outlook.com> <7b347a985e590e2a422f837971b30bd83f9c7ac3.camel@nvidia.com> <DM4PR11MB5422762E82C0531B92BDF09A842B9@DM4PR11MB5422.namprd11.prod.outlook.com> <DM4PR11MB5422269F6113268172B9E26A842A9@DM4PR11MB5422.namprd11.prod.outlook.com> <DM4PR11MB54224769926B06EE76635A6484299@DM4PR11MB5422.namprd11.prod.outlook.com> <20210521153110.207cb231@carbon> <1426bc91c6c6ee3aaf3d85c4291a12968634e521.camel@kernel.org> <87lf85zmuw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Sun, 23 May 2021 13:54:47 +0200

> Saeed Mahameed <saeed@kernel.org> writes:
> 
> > On Fri, 2021-05-21 at 15:31 +0200, Jesper Dangaard Brouer wrote:
> >> On Fri, 21 May 2021 10:53:40 +0000
> >> "Lobakin, Alexandr" <alexandr.lobakin@intel.com> wrote:
> >>
> >> > I've opened two discussions at https://github.com/alobakin/linux,
> >> > feel free to join them and/or create new ones to share your thoughts
> >> > and concerns.
> >>
> >> Thanks Alexandr for keeping the thread/subject alive.
> >>
> >> I guess this is a new GitHub features "Discussions".  I've never used
> >> that in a project before, lets see how this goes.  The usual approach
> >> is discussions over email on netdev (Cc. netdev@vger.kernel.org).
> >
> > I agree we need full visibility and transparency, i actually recommend:
> > bpf@vger.kernel.org
> 
> +1, please keep this on the list :)

Sure, let's keep it the classic way.
I removed the netdev ML from the CCs and added bpf there.

Regarding the comments from GitHub discussions:

alobakin:

> Since 5.11, it's now possible to obtain a BTF not only for vmlinux,
> but also for modules.
> This will eliminate a need for manually composing and registering a
> BTF inside the driver code, which is 100+ locs for ice for example.
> 
> That's obviously not the most straightforward and trivial way, but
> could help a lot.

saeedtx:

> the point of registering BTF directly from the driver is to allow
> "Flex metadata" meaning that meta data format can be constructed on
> the fly according to user demand.
> BTF for modules is constructed only at compilation time and
> registered only on module load. so there is no way to implement flex
> metadata with vmlinux BTF. we still need a dynamic registration API
> for current and future HW where the HW will provide the BTF
> dynamically.
> 
> I am sure we can find mutliple ways to reduce the 100+ LOC, but the
> goal is to have the dynamic btf_register/unregister API

We initially planned to register just one (or several) predefined
BTF(s) per module/netdevice that would provide a full list of
supported fields. The flexibility of metadata then is in that BPF
core calls for netdevice's ndo_bpf() on BPF program setup and
provides a metadata layout requested by that BPF prog to the driver,
so it could configure its hotpath (current NICs) or a hardware
(future NICs) to build metadata accordingly.
Driver can declare several BTFs (e.g. a "generic" one with things
like hashes and csums one and a custom one) and it would work either
through dynamic registering or through /sys approach.

This is all discussable anyways, we're happy to hear different
opinions and thoughts to collectively choose the optimal way.

> -Toke

Thanks,
Al
