Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9671B3B1A28
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFWMav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 08:30:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:1760 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhFWMaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Jun 2021 08:30:22 -0400
IronPort-SDR: +7V7lCSycYyE7vyVMIe1BPR1I3FljJHsqZsojkP6S+H9slkxnDXT89ESoRhqNhfOh7jiWzaIiH
 c0UCyg0Lvfdg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="204241418"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="204241418"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 05:25:33 -0700
IronPort-SDR: IpEUh/BqE1s7d2MLvGNgjUGcCnS9+fGsmKDjakHij1ImNNwzSk5Xty5Jjgn42/8APV1kP7tyvO
 o76tubu0aUXQ==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="487286243"
Received: from unknown (HELO localhost.localdomain) ([10.102.102.63])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 05:25:31 -0700
Date:   Wed, 23 Jun 2021 04:32:54 -0400
From:   Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Message-ID: <YNLxtsasQSv+YR1w@localhost.localdomain>
References: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk>
 <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon>
 <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk>
 <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain>
 <874kdqqfnm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kdqqfnm.fsf@toke.dk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 22, 2021 at 01:53:33PM +0200, Toke Høiland-Jørgensen wrote:
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
> 
> > On Wed, Jun 02, 2021 at 09:18:37AM -0700, Jakub Kicinski wrote:
> >> On Tue, 01 Jun 2021 17:22:51 -0700 John Fastabend wrote:
> >> > > If we do this, the BPF program obviously needs to know which fields are
> >> > > valid and which are not. AFAICT you're proposing that this should be
> >> > > done out-of-band (i.e., by the system administrator manually ensuring
> >> > > BPF program config fits system config)? I think there are a couple of
> >> > > problems with this:
> >> > > 
> >> > > - It requires the system admin to coordinate device config with all of
> >> > >   their installed XDP applications. This is error-prone, especially as
> >> > >   the number of applications grows (say if different containers have
> >> > >   different XDP programs installed on their virtual devices).  
> >> > 
> >> > A complete "system" will need to be choerent. If I forward into a veth
> >> > device the orchestration component needs to ensure program sending
> >> > bits there is using the same format the program installed there expects.
> >> > 
> >> > If I tailcall/fentry into another program that program the callee and
> >> > caller need to agree on the metadata protocol.
> >> > 
> >> > I don't see any way around this. Someone has to manage the network.
> >> 
> >> FWIW I'd like to +1 Toke's concerns.
> >> 
> >> In large deployments there won't be a single arbiter. Saying there 
> >> is seems to contradict BPF maintainers' previous stand which lead 
> >> to addition of bpf_links for XDP.
> >> 
> >> In practical terms person rolling out an NTP config change may not 
> >> be aware that in some part of the network some BPF program expects
> >> descriptor not to contain time stamps. Besides features may depend 
> >> or conflict so the effects of feature changes may not be obvious 
> >> across multiple drivers in a heterogeneous environment.
> >> 
> >> IMO guarding from obvious mis-configuration provides obvious value.
> >
> > Hi,
> >
> > Thanks for a lot of usefull information about CO-RE. I have read
> > recommended articles, but still don't understand everything, so sorry if
> > my questions are silly.
> >
> > As introduction, I wrote small XDP example using CO-RE (autogenerated
> > vmlinux.h and getting rid of skeleton etc.) based on runqslower
> > implementation. Offset reallocation of hints works great, I built CO-RE
> > application, added new field to hints struct, changed struct layout and
> > without rebuilding application everything still works fine. Is it worth
> > to add XDP sample using CO-RE in kernel or this isn't good place for
> > this kind of sample?
> >
> > First question not stricte related to hints. How to get rid of #define
> > and macro when I am using generated vmlinux.h? For example I wanted to
> > use htons macro and ethtype definition. They are located in headers that
> > also contains few struct definition. Because of that I have redefinition
> > error when I am trying to include them (redefinition in vmlinux.h and
> > this included file). What can I do with this besides coping definitions
> > to bpf code?
> 
> One way is to only include the structs you actually need from vmlinux.h.
> You can even prune struct members, since CO-RE works just fine with
> partial struct definitions as long as the member names match.
> 
> Jesper has an example on how to handle this here:
> https://github.com/netoptimizer/bpf-examples/blob/ktrace01-CO-RE.public/headers/vmlinux_local.h
> 

I see, thanks, I will take a look at other examples.

> > I defined hints struct in driver code, is it right place for that? All
> > vendors will define their own hints struct or the idea is to have one
> > big hints struct with flags informing about availability of each fields?
> >
> > For me defining it in driver code was easier because I can have used
> > module btf to generate vmlinux.h with hints struct inside. However this
> > break portability if other vendors will have different struct name etc,
> > am I right?
> 
> I would expect the easiest is for drivers to just define their own
> structs and maybe have some infrastructure in the core to let userspace
> discover the right BTF IDs to use for a particular netdev. However, as
> you say it's not going to work if every driver just invents their own
> field names, so we'll need to coordinate somehow. We could do this by
> convention, though, it'll need manual intervention to make sure the
> semantics of identically-named fields match anyway.
> 
> Cf the earlier discussion with how many BTF IDs each driver might
> define, I think we *also* need a way to have flags that specify which
> fields of a given BTF ID are currently used; and having some common
> infrastructure for that would be good...
> 

Sounds good. 

Sorry, but I feel that I don't fully understand the idea. Correct me if
I am wrong:

In building CO-RE application step we can defined big struct with
all possible fields or even empty struct (?) and use
bpf_core_field_exists. 

bpf_core_field_exists will be resolve before loading program by libbpf
code. In normal case libbpf will look for btf with hints name in vmlinux
of running kernel and do offset rewrite and exsistence check. But as the
same hints struct will be define in multiple modules we want to add more
logic to libbpf to discover correct BTF ID based on netdev on which program
will be loaded?

> -Toke
> 
