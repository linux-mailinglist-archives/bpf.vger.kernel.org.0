Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8562D31C3B4
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 22:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhBOVkZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 16:40:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhBOVkZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Feb 2021 16:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613425137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IxpTKqSAJdujWUQZD0dx8MvcWVHfhoD9kdfrZZUHBAg=;
        b=OuvfuS8Oq+/Uf46fqQR6c9Q/t/WKBqCLPobSbAHQzy7Bfn8dEsrzfLp/yl3TvWxIsGHC9Z
        t+oRa5rhT+xU1aFSY5tkBBwbzDOwokhX1SDKJI16Xc7XWdHo7UlWy2HALUio/dpa2fPci4
        UZqQhigGx+/BKBvZPeXGeedJ0XzWm74=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-RxnB5rWvPt6raLYiHGKHOQ-1; Mon, 15 Feb 2021 16:38:55 -0500
X-MC-Unique: RxnB5rWvPt6raLYiHGKHOQ-1
Received: by mail-ed1-f69.google.com with SMTP id e17so6239923eds.12
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 13:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IxpTKqSAJdujWUQZD0dx8MvcWVHfhoD9kdfrZZUHBAg=;
        b=fFUAahoE0iYlIljsDyC0dydUVbzR5ISZj2I2C1ds7pdewo40F4z8+OshVDPKvqkyGh
         nbS82S0Da8D0QLIJxEy/D39VLcoE/76YJb7lmpfnYcwMEu+x7iGPekxFLS7u3Go/2TzE
         3/k5RSOMgL2w109yWR0/ni0l/NzrY+AB8O620pXQOcf8d/QusjFP/oSXbkoiptIuB8LR
         UY0XOT1t/ft6QSyNvim9Q4JzrxkvKOrBe80YDWkGsOz3J7ntU3dkZ54SuH//bVjkttfL
         vztYoDAMt2V8TGzR1xIcW1HPwdEpXiZXBHHPlQBN/Gh1UmKMVqB+woeJzXhnlUshTmYa
         RwNQ==
X-Gm-Message-State: AOAM5325hfuN3HMX5Ar7en1UhPgBBCz9QRKr+l51puQZDue8VwrwuZee
        t0uWM2qCEK+VpavVtj2NGCMnaot9pbhPg9bC/QMyQe8+jQVOyRn/iMgfeEe4XRBpXbcqVgrQP6v
        pM71rLW8Z3qfd
X-Received: by 2002:a17:906:a2d2:: with SMTP id by18mr16904292ejb.262.1613425134552;
        Mon, 15 Feb 2021 13:38:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynqSW4LP5F4oENAIG0stNeQBZsPNLQhzZNRr7kHjGfnf95VTpSx5CnFqXU+fRs1OdlW4E9IQ==
X-Received: by 2002:a17:906:a2d2:: with SMTP id by18mr16904277ejb.262.1613425134386;
        Mon, 15 Feb 2021 13:38:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q3sm2956861eja.22.2021.02.15.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 13:38:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 848BE1805FB; Mon, 15 Feb 2021 22:38:52 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBl?= =?utf-8?B?bA==?= 
        <bjorn.topel@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     andrii@kernel.org, magnus.karlsson@intel.com,
        ciara.loftus@intel.com
Subject: Re: [PATCH bpf-next 1/3] libbpf: xsk: use bpf_link
In-Reply-To: <602ad80c566ea_3ed4120871@john-XPS-13-9370.notmuch>
References: <20210215154638.4627-1-maciej.fijalkowski@intel.com>
 <20210215154638.4627-2-maciej.fijalkowski@intel.com>
 <87eehhcl9x.fsf@toke.dk> <fe0c957e-d212-4265-a271-ba301c3c5eca@intel.com>
 <602ad80c566ea_3ed4120871@john-XPS-13-9370.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 15 Feb 2021 22:38:52 +0100
Message-ID: <8735xxc8pf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

>> > However, in libxdp we can solve the original problem in a different way,
>> > and in fact I already suggested to Magnus that we should do this (see
>> > [1]); so one way forward could be to address it during the merge in
>> > libxdp? It should be possible to address the original issue (two
>> > instances of xdpsock breaking each other when they exit), but
>> > applications will still need to do an explicit unload operation before
>> > exiting (i.e., the automatic detach on bpf_link fd closure will take
>> > more work, and likely require extending the bpf_link kernel support)...
>> >
>> 
>> I'd say it's depending on the libbpf 1.0/libxdp merge timeframe. If
>> we're months ahead, then I'd really like to see this in libbpf until the
>> merge. However, I'll leave that for Magnus/you to decide!
>
> Did I miss some thread? What does this mean libbpf 1.0/libxdp merge?

The idea is to keep libbpf focused on bpf, and move the AF_XDP stuff to
libxdp (so the socket stuff in xsk.h). We're adding the existing code
wholesale, and keeping API compatibility during the move, so all that's
needed is adding -lxdp when compiling. And obviously the existing libbpf
code isn't going anywhere until such a time as there's a general
backwards compatibility-breaking deprecation in libbpf (which I believe
Andrii is planning to do in an upcoming and as-of-yet unannounced v1.0
release).

While integrating the XSK code into libxdp we're trying to make it
compatible with the rest of the library (i.e., multi-prog). Hence my
preference to avoid introducing something that makes this harder :)

-Toke

