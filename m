Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A694B2443
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 18:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfIMQmc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 12:42:32 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:33546 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387695AbfIMQmc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Sep 2019 12:42:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 641DF100E86C3;
        Fri, 13 Sep 2019 16:42:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2736:2828:2859:2917:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:5007:8957:8985:9025:10004:10400:10562:10848:11232:11473:11658:11914:12043:12297:12555:12663:12740:12760:12895:12986:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21433:21627:21771:21811:21819:30022:30054:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: work92_8a11f0cf4e453
X-Filterd-Recvd-Size: 3136
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Sep 2019 16:42:28 +0000 (UTC)
Message-ID: <f0ad46a34078a2c1eaa013f9b1a5a52becbcd1c5.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robherring2@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Date:   Fri, 13 Sep 2019 09:42:27 -0700
In-Reply-To: <CAL_JsqLo9-zQYGj2vaEWppbioO0rXu-QNbHhydYdMgrZo0_ESg@mail.gmail.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
         <20190911184332.GL20699@kadam>
         <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
         <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam>
         <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org>
         <CAL_JsqLo9-zQYGj2vaEWppbioO0rXu-QNbHhydYdMgrZo0_ESg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2019-09-13 at 16:46 +0100, Rob Herring wrote:
> On Fri, Sep 13, 2019 at 4:00 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 9/13/19 4:48 AM, Dan Carpenter wrote:
> > 
> > > > So I'm expecting to take this kind of stuff into Documentation/.  My own
> > > > personal hope is that it can maybe serve to shame some of these "local
> > > > quirks" out of existence.  The evidence from this brief discussion suggests
> > > > that this might indeed happen.
> > > 
> > > I don't think it's shaming, I think it's validating.  Everyone just
> > > insists that since it's written in the Book of Rules then it's our fault
> > > for not reading it.  It's like those EULA things where there is more
> > > text than anyone can physically read in a life time.
> > 
> > Yes, agreed.
> > 
> > > And the documentation doesn't help.  For example, I knew people's rules
> > > about capitalizing the subject but I'd just forget.  I say that if you
> > > can't be bothered to add it to checkpatch then it means you don't really
> > > care that strongly.
> > 
> > If a subsystem requires a certain spelling/capitalization in patch email
> > subjects, it should be added to MAINTAINERS IMO.  E.g.,
> > E:      NuBus
> 
> +1
> 
> Better make this a regex to deal with (net|net-next).
> 
> We could probably script populating MAINTAINERS with this using how it
> is done manually: git log --oneline <dir>

I made a similar proposal nearly a decade ago to add a grammar
to MAINTAINERS sections for patch subject prefixes.

https://lore.kernel.org/lkml/1289919077.28741.50.camel@Joe-Laptop/


