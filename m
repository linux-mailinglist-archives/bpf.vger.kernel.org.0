Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADE42A8BB1
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 01:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgKFA4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 19:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731965AbgKFA4h (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 19:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604624196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6Xq2enR96jl4WUOQiMevTlqAu+rZdwNjjaaEgtSVIs=;
        b=dHdXs5JR3bDpISXnU5mRiPevQKsRCxm/rNRr9gQmI8JYhN/oONAtu8WzvUzzXGXOptfPSJ
        n7U2zV40xSIH0g+2HILxcfE9crltwVT8ys+y8pUpgKrPEZrGpqEkCz9ON6QwvlzvFV62C+
        90zcOJOKPWHPMp4EL+Znkg3cp6XbH+g=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-KN1DyO0fMVSG6BUf4umJfg-1; Thu, 05 Nov 2020 19:56:34 -0500
X-MC-Unique: KN1DyO0fMVSG6BUf4umJfg-1
Received: by mail-pl1-f200.google.com with SMTP id z11so1999300pln.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 16:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q6Xq2enR96jl4WUOQiMevTlqAu+rZdwNjjaaEgtSVIs=;
        b=Ons9DsLb6F2VQrycBEC91D+Kx7RKp2hSXK4xebS0ABTn+rLO9IKGyCrakjU2n9gvgc
         6+vYa+RL5SzjxGGmakJGaR/DulqwGLIv85O4027sNF+0k6xy8pOkyHJ8oChaEno2K0DT
         3CN9+CrVC98bFQnyzkBM2IJej/XjAqLMTgbSCXpyV9glXcz2m0jPCg3SO2LPahLxaqhC
         eT82zSdpgKiWjinY8MlDgpU/TVDU6g3yuOnbxwXnm89pFlUSArEhVcc4xQbwQWY35Ogx
         aRcSG8aIiNJJ6KbAGUFBE/WtEU1/ZGmutkkWHTT6s3mNlwDNylujCe4VGyP7aa5gIjQB
         BwJA==
X-Gm-Message-State: AOAM530iA+t9BMaNFwnpPtacjRUSQ8tq98VwqFEVSIIyKNzon3bwo7lI
        iphkdcksXha31GPHMfgbL3Fj7nTQsYkJYMZAgo4sBK+HtAp2niYDMKiVePFLykhRXU3oYQEz82U
        v8Ap2YeANGyE=
X-Received: by 2002:a17:90a:b303:: with SMTP id d3mr5093901pjr.207.1604624193536;
        Thu, 05 Nov 2020 16:56:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyskHTQc/RppIay8c301+jkoNYEV5mbh92MAP7axegaJ4oE0SZ0RxDEdS9n6RhTdsdUY1Xy0Q==
X-Received: by 2002:a17:90a:b303:: with SMTP id d3mr5093888pjr.207.1604624193361;
        Thu, 05 Nov 2020 16:56:33 -0800 (PST)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h5sm3693899pfn.12.2020.11.05.16.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:56:32 -0800 (PST)
Date:   Fri, 6 Nov 2020 08:56:23 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCHv3 iproute2-next 3/5] lib: add libbpf support
Message-ID: <20201106005623.GZ2408@dhcp-12-153.nay.redhat.com>
References: <20201028132529.3763875-1-haliu@redhat.com>
 <20201029151146.3810859-1-haliu@redhat.com>
 <20201029151146.3810859-4-haliu@redhat.com>
 <db14a227-1d5e-ed3a-9ada-ecf99b526bf6@gmail.com>
 <20201104082203.GP2408@dhcp-12-153.nay.redhat.com>
 <61a678ce-e4bc-021b-ab4e-feb90e76a66c@gmail.com>
 <20201105075121.GV2408@dhcp-12-153.nay.redhat.com>
 <3c3f892a-6137-d176-0006-e5ddaeeed2b5@gmail.com>
 <87sg9nssn0.fsf@toke.dk>
 <9cd3ed2a-48e2-8d2a-3223-51f47c4f6cbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cd3ed2a-48e2-8d2a-3223-51f47c4f6cbc@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 09:02:15AM -0700, David Ahern wrote:
> On 11/5/20 8:57 AM, Toke Høiland-Jørgensen wrote:
> > I guess we could split it further into lib/bpf_{libbpf,legacy,glue}.c
> > and have the two former ones be completely devoid of ifdefs and
> > conditionally included based on whether or not libbpf support is
> > enabled?
> 
> that sounds reasonable.
> 

OK, I will do this.

Thanks
Hangbin

