Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5883B398FC7
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhFBQUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 12:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhFBQUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 12:20:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10B1761947;
        Wed,  2 Jun 2021 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622650719;
        bh=sWkOcXyNxln8ni5dnbEU7OELUj1tqJ+xyc/ErmXbC/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r8L+a4Y61R0vbecDGRbpLPttsNygM/jWwWdpug9hNCB1Ctx5QgydLdvE6oIg31T/D
         yQ++4k8iYAJvDC1NWesbSr87mPuKQncMkQvGt/bTCcx8XLNoAodkeGVB4MHePbiOkI
         01+ZT4ieaJj3pEQyS0uLYEVzetI7V46ai5vp3Mmjvx0hxx0CWY9d34xLgazEh8e3SC
         2CFBXyALBtgkCbFR5hCzmL610nFyKQA0OT+9YRDStu2sDo4TkV0//L8vwHA3lLGfwE
         YvGjZ0SpWVhUyZl9J3TbiYvKy7xZlpNbatJL+sYJ6RtLh2yV3M+F/7hVpnormmp3EG
         kE//BbQq5zmtw==
Date:   Wed, 2 Jun 2021 09:18:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Message-ID: <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
References: <20210526125848.1c7adbb0@carbon>
        <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
        <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
        <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
        <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
        <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
        <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
        <87fsy7gqv7.fsf@toke.dk>
        <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
        <20210528180214.3b427837@carbon>
        <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
        <8735u3dv2l.fsf@toke.dk>
        <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 01 Jun 2021 17:22:51 -0700 John Fastabend wrote:
> > If we do this, the BPF program obviously needs to know which fields are
> > valid and which are not. AFAICT you're proposing that this should be
> > done out-of-band (i.e., by the system administrator manually ensuring
> > BPF program config fits system config)? I think there are a couple of
> > problems with this:
> > 
> > - It requires the system admin to coordinate device config with all of
> >   their installed XDP applications. This is error-prone, especially as
> >   the number of applications grows (say if different containers have
> >   different XDP programs installed on their virtual devices).  
> 
> A complete "system" will need to be choerent. If I forward into a veth
> device the orchestration component needs to ensure program sending
> bits there is using the same format the program installed there expects.
> 
> If I tailcall/fentry into another program that program the callee and
> caller need to agree on the metadata protocol.
> 
> I don't see any way around this. Someone has to manage the network.

FWIW I'd like to +1 Toke's concerns.

In large deployments there won't be a single arbiter. Saying there 
is seems to contradict BPF maintainers' previous stand which lead 
to addition of bpf_links for XDP.

In practical terms person rolling out an NTP config change may not 
be aware that in some part of the network some BPF program expects
descriptor not to contain time stamps. Besides features may depend 
or conflict so the effects of feature changes may not be obvious 
across multiple drivers in a heterogeneous environment.

IMO guarding from obvious mis-configuration provides obvious value.
