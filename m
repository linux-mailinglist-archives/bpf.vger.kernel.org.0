Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F152D3A496F
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 21:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFKT3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 15:29:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:16889 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhFKT3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 15:29:35 -0400
IronPort-SDR: K8Q0fBhv1nXW+WSGv/NkSgrQu4An+76fZcHyV4GicVQEPPtiJsC8odfvcX1GJgmowmvUWSrKbq
 9hYOqr5QaJlA==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="202568152"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="202568152"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 12:27:37 -0700
IronPort-SDR: D+f9bDbo6/9xl0kCeaVJkO+ID9hWlT/2kqwaJW3jagr0w15FbVRvY9Qj58XpjlELFrpiH3X+7N
 PWRFbbut/vXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="486693077"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2021 12:27:33 -0700
Received: from alobakin-mobl.ger.corp.intel.com (pcieslak-MOBL.ger.corp.intel.com [10.213.29.156])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 15BJRVNS017951;
        Fri, 11 Jun 2021 20:27:31 +0100
From:   Alexander Lobakin <alobakin@intel.com>
To:     "Desouza, Ederson" <ederson.desouza@intel.com>
Cc:     Alexander Lobakin <alobakin@intel.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Kubiak, Marcin" <marcin.kubiak@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>
Subject: Re: AF_XDP metadata/hints
Date:   Fri, 11 Jun 2021 21:25:45 +0200
Message-Id: <20210611192545.1032-1-alobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <7ca8de6cd52b2aa5f76c447024e1a4906e61d2cd.camel@intel.com>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com> <2226aeaab7a4ca8e4f26413514bf54ab2c81ea36.camel@intel.com> <5c9fd8fbc29d4b21a3279f1122960413@intel.com> <DM6PR11MB2780A8C5410ECB3C9700EAB5CA579@DM6PR11MB2780.namprd11.prod.outlook.com> <PH0PR11MB487034313697F395BB5BA3C5E4579@PH0PR11MB4870.namprd11.prod.outlook.com> <DM4PR11MB5422733A87913EFF8904C17184579@DM4PR11MB5422.namprd11.prod.outlook.com> <20210507131034.5a62ce56@carbon> <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com> <7ca8de6cd52b2aa5f76c447024e1a4906e61d2cd.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Ederson Desouza <ederson.desouza@intel.com>
Date: Sat, 5 Jun 2021 00:32:45 +0000

Hi there,

> On Mon, 2021-05-10 at 15:49 +0000, Lobakin, Alexandr wrote:
> > Hi,
> > 
> > So here it is: https://github.com/alobakin/linux/branches
> 
> Quick question: are you planning any update here (like incorporating
> the CO-RE feedback)? 

Sure, the repo is not dead, neither our work is. I was OOO last
week due to some urgent events and didn't have time to get my
hands on XDP Hints.
And yes, we are planning to rewrite the entire thing upon
the CO-RE. Stay tuned.

> I'm thinking of igc, and wondering if you have something in your
> pipeline already that I could reuse for some tests =D

Not yet, but I'll be keeping my GH mirror in sync with our drafts
anyways.
I mean, you could try to reuse the current implementation from the
ice driver, as it works just fine. But the most juicy things are
to come.

> > 
> > Default branch is just merged with v5.13-rc1 without any testing, don't expect much from it. I'll fix it a bit later.
> > 
> > Al
> > 
> > -----Original Message-----
> > From: Jesper Dangaard Brouer <brouer@redhat.com> 
> > Sent: Friday, May 7, 2021 1:11 PM
> > To: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> > Cc: Kubiak, Marcin <marcin.kubiak@intel.com>; Ong, Boon Leong <boon.leong.ong@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; Desouza, Ederson <ederson.desouza@intel.com>; Swiatkowski, Michal <michal.swiatkowski@intel.com>; Gomes, Vinicius <vinicius.gomes@intel.com>; Maloor, Kishen <kishen.maloor@intel.com>; Zhang, Jessica <jessica.zhang@intel.com>; Joseph, Jithu <jithu.joseph@intel.com>; Plantykow, Marta A <marta.a.plantykow@intel.com>; Czapnik, Lukasz <lukasz.czapnik@intel.com>; Raczynski, Piotr <piotr.raczynski@intel.com>; Song, Yoong Siang <yoong.siang.song@intel.com>; brouer@redhat.com
> > Subject: Re: AF_XDP metadata/hints
> > 
> > (Answer inlined below)
> > 
> > On Fri, 7 May 2021 10:08:51 +0000
> > "Lobakin, Alexandr" <alexandr.lobakin@intel.com> wrote:
> > 
> > > + Jesper.
> > 
> > Thanks for including me!  Just see me as a resource that can help out on this project, both coding and (performance) testing.  I have a customer use-case related to LaunchTime mode using AF_XDP, which is one of the more tricky cases (due to XDP lacking a proper TX layer, that can pushback if TX-queue is full/paused).
> > 
> > 
> > > So long story short: driver advertises the XDP hints it supports (Rx:
> > > RSS hash, csum status or complete csum, C/S-VLAN tag if stripped etc., 
> > > Tx: csum offload etc.) on netdev probing so BPF prog could request for 
> > > them.
> > 
> > Yes exactly and veth and devmap also want to consume these e.g. RSS hash + csum status when they create an SKB based on an xdp_frame.
> > 
> > (Note David Ahern and I have patches placing the csum status bits in xdp_frame to transfer that info (xdp_frame is located in memory top).
> > note performance analysis here[1])
> > [1] https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp_frame01_checksum.org
> > 
> > 
> > > There's a plan to provide 2 types of hints: generic ones (that almost 
> > > every NIC is capable to provide) and custom ones (up to 
> > > vendor/developers). Drivers that don't want to support hints at all 
> > > could opt out from the generic ones just by setting their 
> > > xdp.data_meta to xdp.data + 1, just how it's now done in the mainline.
> > 
> > I agree the NIC need to support different types.  And different types per packet as e.g. PTP timestamps might not be in every packet.
> > 
> > > XDP Hints will be obviously stored in metadata,
> > 
> > I have considered[2] storing XDP hints in xdp_frame area (top of memory), but I'm more and more convinced is should be stored in metadata area... mostly because this will allow future hardware to write this data for us.
> > 
> > [2] https://people.netfilter.org/hawk/presentations/KernelRecipes2019/xdp-netstack-concert.pdf
> > 
> > I think there is a small performance problem when writing into metadata area.  Because this is a cacheline that might be (semi)cold.  Hint we prefetch xdp_frame area and we could do the same for metadata, but I still see a slowdown when converting xdp_buff to xdp_frame.
> > 
> > XDP is extremely performance sensitive.  Even if metadata area is in L1 cache it will still cost a couple of nanosec to update the fields.
> > This will be measureable in an XDP_DROP test.  The easiest workaround I see is: that we allow the config interface for XDP-hints to allow disabling this feature.
> > 
> > 
> > > the layout is not written in stone yet.
> > 
> > Exactly, the main reason/motivation for this work is to allow NIC vendors to invent new hardware hints without having to wait for the Linux kernel to adopt these.  Instead they are instant available via BPF and BTF-info that describe this layout.
> > 
> >  
> > > I'll be preparing an open repo with our drafts today, let you know 
> > > once it will be ready and available so you could take a look, review, 
> > > fork and go forth with playing with it.
> > 
> > Great!!! :-)))
> > 
> > > Any of you can also share any bits of code or thoughts that you have 
> > > and may want to share.
> > > 
> > > Thanks,
> > > Al
> > > 
> > > -----Original Message-----
> > > From: Kubiak, Marcin <marcin.kubiak@intel.com>
> > > Sent: Friday, May 7, 2021 9:35 AM
> > > To: Ong, Boon Leong <boon.leong.ong@intel.com>; Brandeburg, Jesse 
> > > <jesse.brandeburg@intel.com>; Desouza, Ederson 
> > > <ederson.desouza@intel.com>; Lobakin, Alexandr 
> > > <alexandr.lobakin@intel.com>; Swiatkowski, Michal 
> > > <michal.swiatkowski@intel.com>
> > > Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Maloor, Kishen 
> > > <kishen.maloor@intel.com>; Zhang, Jessica <jessica.zhang@intel.com>; 
> > > Joseph, Jithu <jithu.joseph@intel.com>; Plantykow, Marta A 
> > > <marta.a.plantykow@intel.com>; Lobakin, Alexandr 
> > > <alexandr.lobakin@intel.com>; Czapnik, Lukasz 
> > > <lukasz.czapnik@intel.com>; Raczynski, Piotr 
> > > <piotr.raczynski@intel.com>; Song, Yoong Siang 
> > > <yoong.siang.song@intel.com>
> > > Subject: RE: AF_XDP metadata/hints
> > > 
> > > + @Swiatkowski, Michal
> > > 
> > > -----Original Message-----
> > > From: Ong, Boon Leong <boon.leong.ong@intel.com>
> > > Sent: Friday, May 7, 2021 3:13 AM
> > > To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Desouza, Ederson 
> > > <ederson.desouza@intel.com>; Lobakin, Alexandr 
> > > <alexandr.lobakin@intel.com>
> > > Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Maloor, Kishen 
> > > <kishen.maloor@intel.com>; Zhang, Jessica <jessica.zhang@intel.com>; 
> > > Joseph, Jithu <jithu.joseph@intel.com>; Plantykow, Marta A 
> > > <marta.a.plantykow@intel.com>; Lobakin, Alexandr 
> > > <alexandr.lobakin@intel.com>; Czapnik, Lukasz 
> > > <lukasz.czapnik@intel.com>; Raczynski, Piotr 
> > > <piotr.raczynski@intel.com>; Kubiak, Marcin <marcin.kubiak@intel.com>; 
> > > Song, Yoong Siang <yoong.siang.song@intel.com>
> > > Subject: RE: AF_XDP metadata/hints
> > > 
> > > + Yoong Siang
> > > 
> > > > -----Original Message-----
> > > > From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> > > > Sent: Friday, May 7, 2021 8:32 AM
> > > > To: Desouza, Ederson <ederson.desouza@intel.com>; Lobakin, Alexandr 
> > > > <alexandr.lobakin@intel.com>; Ong, Boon Leong 
> > > > <boon.leong.ong@intel.com>
> > > > Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Maloor, Kishen 
> > > > <kishen.maloor@intel.com>; Zhang, Jessica <jessica.zhang@intel.com>; 
> > > > Joseph, Jithu <jithu.joseph@intel.com>; Plantykow, Marta A 
> > > > <marta.a.plantykow@intel.com>; Lobakin, Alexandr 
> > > > <alexandr.lobakin@intel.com>; Czapnik, Lukasz 
> > > > <lukasz.czapnik@intel.com>; Raczynski, Piotr 
> > > > <piotr.raczynski@intel.com>; Kubiak, Marcin <marcin.kubiak@intel.com>
> > > > Subject: RE: AF_XDP metadata/hints
> > > > 
> > > > I think our XDP team is on this, and I'll let them answer in detail. 
> > > > Yes, I'm a goof for top posting using outlook....
> > > >  
> > > > > So, I'd like to ask some questions:
> > > > >  - Are you guys also interested in AF_XDP support, or do you care 
> > > > > about XDP only?
> > > > 
> > > > Yes! Both.  
> > > 
> > > For us (BL and Siang) in Penang, Since, we have 3 time-zones and I don't think it is effective for us to run 3 time zone discussion. So, please carry on without us. 
> > > 
> > > However, we would like to follow the RFC and POC so that we can help to implement the stmmac driver part and help test.
> > > 
> > > BL
> > > >  
> > > > >  - Did you already start the work? Could you describe how you 
> > > > > handle the metadata? Can we see some preview? We're planning to 
> > > > > start next week, so not much to show[*].
> > > > >  - I believe there may be opportunities to collaborate here - how 
> > > > > can we help?
> > > > 
> > > > Please folks, get together and talk. Ederson, this team is in Poland 
> > > > so is +9 hours from PST. Keep me informed on what's up, but I don't 
> > > > need to be in the day to day, but you're welcome to consult me anytime.
> > > > 
> > > > -Jesse
> > > > 
> > > > -----Original Message-----
> > > > From: Desouza, Ederson <ederson.desouza@intel.com>
> > > > Sent: Thursday, May 6, 2021 5:08 PM
> > > > To: Lobakin, Alexandr <alexandr.lobakin@intel.com>; Ong, Boon Leong 
> > > > <boon.leong.ong@intel.com>; Brandeburg, Jesse 
> > > > <jesse.brandeburg@intel.com>
> > > > Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Maloor, Kishen 
> > > > <kishen.maloor@intel.com>; Zhang, Jessica <jessica.zhang@intel.com>; 
> > > > Joseph, Jithu <jithu.joseph@intel.com>
> > > > Subject: Re: AF_XDP metadata/hints
> > > > 
> > > > +Jessica
> > > > 
> > > > Gentle ping to check if anyone's interested =D
> > > > 
> > > > On Fri, 2021-04-30 at 19:24 -0700, Ederson de Souza wrote:  
> > > > > Hi folks,
> > > > > 
> > > > > I've noticed that you are some Intel people that mentioned (on a 
> > > > > thread with the community) interest and some development regarding 
> > > > > XDP metadata (for RX/TX timestamp and SO_TXTIME support). And my 
> > > > > team, on IAGS/SSE, is also working on that for the i225 igc driver.
> > > > > 
> > > > > As there's some overlap in this work, I'd like to figure it out 
> > > > > what is the state of these developments and align what we're doing.
> > > > > 
> > > > > I'll talk about our ideas and ask some questions to help in this 
> > > > > alignment.
> > > > > 
> > > > > We want the "SO_TXTIME" support for AF_XDP ZC. Right now, we're 
> > > > > thinking about working on top of Saeed's work that enables BTF for XDP.
> > > > > Our idea is to use BTF and the XDP metadata area (that headroom 
> > > > > area just before the frame data starts) to store the timestamp.
> > > > > 
> > > > > For this to work, we're thinking of adding some new API to 
> > > > > `tools/lib/bpf/xsk.h` to allow userspace application to manipulate 
> > > > > that area and add the metadata (without explicitly subtracting 
> > > > > pointers and such).
> > > > > 
> > > > > Then, add support on both igc driver to extract this metadata and 
> > > > > set the launch time and the generic AF_XDP socket (for copy mode
> > > > > compatibility) to extract and add it to the skb sent down the stack.
> > > > > 
> > > > > Of course, the issue here is how to make this generic enough. 
> > > > > Saeed's work kinda expects a metadata struct per driver, IIUC.
> > > > > 
> > > > > So, I'd like to ask some questions:
> > > > >  - Are you guys also interested in AF_XDP support, or do you care 
> > > > > about XDP only?
> > > > >  - Did you already start the work? Could you describe how you 
> > > > > handle the metadata? Can we see some preview? We're planning to 
> > > > > start next week, so not much to show[*].
> > > > >  - I believe there may be opportunities to collaborate here - how 
> > > > > can we help?
> > > > > 
> > > > > Cheers!
> > > > > 
> > > > > [*] In fact, we're using BTF metadata to get HW RX/TX timestamps 
> > > > > for some internal latency measurements we're doing. It's fairly 
> > > > > hackish (and ugly) at this point, but if you are interested, we 
> > > > > could share what we've done.
> > > 
> > > 
> > > > >  
> > > > 
> > > >  
> > > 
> > 
> > 
> > 
> > --
> > Best regards,
> >   Jesper Dangaard Brouer
> >   MSc.CS, Principal Kernel Engineer at Red Hat
> >   LinkedIn: http://www.linkedin.com/in/brouer

Thanks,
Al
