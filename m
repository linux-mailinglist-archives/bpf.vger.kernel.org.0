Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38E0461A82
	for <lists+bpf@lfdr.de>; Mon, 29 Nov 2021 15:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhK2PB4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 10:01:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238365AbhK2O7z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Nov 2021 09:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638197797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHNWRqIpLHDPYpH7xpvccx6XYrK+C3venxkz4l+xkUI=;
        b=JwFEsFAhCS2B8i8SmBLNt2OCRXQTIqfSs2jDGbanjKRIxiM9Uq0Cu8piKbL66wtVYet0iQ
        Olx/7bgibgEKx90M5dgGpuX2G1JAumUM9pCLQGioY9okEdOyg9SG2jHzioLBdDQLHrUbxC
        +lMUbLztTkB58S99zGPEwRPSBkTXaTQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-MMBlY9BANP2SCoRkqf5tTQ-1; Mon, 29 Nov 2021 09:56:36 -0500
X-MC-Unique: MMBlY9BANP2SCoRkqf5tTQ-1
Received: by mail-ed1-f72.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso13952094edc.7
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 06:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uHNWRqIpLHDPYpH7xpvccx6XYrK+C3venxkz4l+xkUI=;
        b=jonIS9u3+hb3l2y57zCfJgw7I57e9fBAel2FRKvpH6GhOidYlP7yB0a4+aIVOLoomp
         jp+KlbQlsdR0OZ36yjd1Pe9Z+Gqg+eAdOP8saUY9ukqnYQtWlu6hszesOc1dVcF+i079
         tFFHRBEr3Zh7YB1AWPZskK92vE4Tt9tXz++8bf0f2AbQfWDn4QFO3oLlTG4RMKwA9Uty
         5qmWAEzYsyr59QOdWqTAkQ+rOAwExQV2GPo12RFSc8TPc1Pa84KhUOngS9LYfEqY8iNm
         iBrPYhbLXbYxUgh6nzrbMHcfMGJSbw+EQ787ACXDJ6u3cRheN2PWpbfHH91JCL4wua8/
         HAvw==
X-Gm-Message-State: AOAM530uigdXP9QIHn2rHF0ZMBhk47+9b1IjZKWt7xpozIK1EV0qz+ae
        ToBuAhP9QopWU+bYq+qfWMFnSmJFJtrjTdXGn54STGoAH5r86AeDCeIrj4BiXFtEjyAN1Xj1sM2
        F3CMniRCeuyo6
X-Received: by 2002:a17:906:4c56:: with SMTP id d22mr59006331ejw.1.1638197795050;
        Mon, 29 Nov 2021 06:56:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+oPfl/380gc/KofkfkFLf7m9XNmkqRbDujlDyZUcjmJ9z9nBeVFduKGlCx46eN+HxxY/WOw==
X-Received: by 2002:a17:906:4c56:: with SMTP id d22mr59006307ejw.1.1638197794819;
        Mon, 29 Nov 2021 06:56:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-140.dyn.eolo.it. [146.241.97.140])
        by smtp.gmail.com with ESMTPSA id g21sm7468959ejt.87.2021.11.29.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:56:34 -0800 (PST)
Message-ID: <5f96722557fbde5b9711da8d53c709858c03af47.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] bpf: let bpf_warn_invalid_xdp_action()
 report more info
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Date:   Mon, 29 Nov 2021 15:56:33 +0100
In-Reply-To: <8f6f900b2b48aaedf031b20a7831ec193793768b.camel@redhat.com>
References: <cover.1637924200.git.pabeni@redhat.com>
         <277a9483b38f9016bc78ce66707753681684fbd7.1637924200.git.pabeni@redhat.com>
         <20211126101941.029e1d7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <8f6f900b2b48aaedf031b20a7831ec193793768b.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Fri, 2021-11-26 at 19:57 +0100, Paolo Abeni wrote:
> On Fri, 2021-11-26 at 10:19 -0800, Jakub Kicinski wrote:
> > On Fri, 26 Nov 2021 12:19:11 +0100 Paolo Abeni wrote:
> > > -void bpf_warn_invalid_xdp_action(u32 act)
> > > +void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
> > >  {
> > >  	const u32 act_max = XDP_REDIRECT;
> > >  
> > > -	pr_warn_once("%s XDP return value %u, expect packet loss!\n",
> > > +	pr_warn_once("%s XDP return value %u on prog %s (id %d) dev %s, expect packet loss!\n",
> > >  		     act > act_max ? "Illegal" : "Driver unsupported",
> > > -		     act);
> > > +		     act, prog->aux->name, prog->aux->id, dev->name ? dev->name : "");
> > >  }
> > 
> > Since we have to touch all the drivers each time the prototype of this
> > function is changed - would it make sense to pass in rxq instead? It has
> > more info which may become useful at some point.
> 
> I *think* for this specific scenario the device name provides all the
> necessary info - the users need to know the driver causing the issue.
> 
> Others similar xdp helpers - e.g. trace_xdp_exception() - have the same
> arguments list used here. If the rxq is useful I guess we will have to
> change even them, and touch all the drivers anyway.

Following the above reasoning I'm going to post v3 with the same
argument list used here, unless someone stops me soon ;)

Thanks,

Paolo

