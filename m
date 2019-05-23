Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA027891
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfEWI4A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 23 May 2019 04:56:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36932 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWI4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 04:56:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so8148364edw.4
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 01:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+xWtgJwp0jYLeeg2jOWSxnZo11hUL3rzj7MfuFTz6CE=;
        b=lHEDdML7KSvtY4Gv4KembUrxOfEkTLxT/AmIbz+wfkRDYlhNljCnDramWipEpL7QT8
         zQnca79J2Tx+HBKX23/Zkr/b5+iD1dUFNYJKqDFv3KQo619SixXCuByt7KNQ40Fezl/V
         b4BFS5YQyzpGq0DJiq9Q+artshs7MXklm1PQVAqyCcmECE0S+jUCgnEk+va4I2tLgwgW
         9CUD2gxkabZaovhyerphQmGaKfEXUJHk8YNikjNRRF/hq8BJhBS/t+Cq1vKjhAnTX7Rm
         IloG8Og+HYHx7jqDvLw288wFP5bVsTuaOs6He+KfvqiXwpVCqkETaNHmFaK3THFMIgxu
         /l4g==
X-Gm-Message-State: APjAAAWK/wDZYpTWvPsw2NSdYCgQ1fwrKs6ykAdlKaoOnmcl2Wd/ExwE
        xLnJ+fKArde2u1++8s7iBcJtpw==
X-Google-Smtp-Source: APXvYqzTboP556mO+baM8FV1DytQuy/JOqipwxjZmJJ9wUwjWJAIBzqnHdZTaZNClUoEcSjtg89NRQ==
X-Received: by 2002:a17:906:61c3:: with SMTP id t3mr56812055ejl.273.1558601758472;
        Thu, 23 May 2019 01:55:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h25sm4284255ejz.10.2019.05.23.01.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 01:55:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E960F1800B1; Thu, 23 May 2019 10:55:56 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        =?utf-8?B?QmrDtnJuIFQ=?= =?utf-8?B?w7ZwZWw=?= 
        <bjorn.topel@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>,
        =?utf-8?B?Qmo=?= =?utf-8?B?w7ZybiBUw7ZwZWw=?= 
        <bjorn.topel@intel.com>,
        "Karlsson\, Magnus" <magnus.karlsson@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] net: xdp: refactor XDP_QUERY_PROG{,_HW} to netdev
In-Reply-To: <20190522140447.53468a2a@cakuba.netronome.com>
References: <20190522125353.6106-1-bjorn.topel@gmail.com> <20190522125353.6106-2-bjorn.topel@gmail.com> <20190522113212.68aea474@cakuba.netronome.com> <CAJ+HfNiz5xbhxshWbLXyiLKDEz3ksU5jg54xxurN17=nVPetyg@mail.gmail.com> <20190522140447.53468a2a@cakuba.netronome.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 23 May 2019 10:55:56 +0200
Message-ID: <87pno935yb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <jakub.kicinski@netronome.com> writes:

> On Wed, 22 May 2019 22:54:44 +0200, Björn Töpel wrote:
>> > > Now, the same commands give:
>> > >
>> > >   # ip link set dev eth0 xdp obj foo.o sec main
>> > >   # ip link set dev eth0 xdpgeneric off
>> > >   Error: native and generic XDP can't be active at the same time.  
>> >
>> > I'm not clear why this change is necessary? It is a change in
>> > behaviour, and if anything returning ENOENT would seem cleaner
>> > in this case.
>> 
>> To me, the existing behavior was non-intuitive. If most people *don't*
>> agree, I'll remove this change. So, what do people think about this?
>> :-)
>
> Having things start to fail after they were successful/ignored
> is one of those ABI breakage types Linux and netdev usually takes
> pretty seriously, unfortunately.  Especially when motivation is 
> "it's more intuitive" :)
>
> If nobody chimes in please break out this behaviour change into 
> a commit of its own.

Björn and I already had this discussion off-list. I think we ended up
concluding that since it's not changing kernel *behaviour*, but just
making an existing error explicit, it might be acceptable from an ABI
breakage PoV. And I'd generally prefer explicit errors over silent
failures.

But yeah, can totally see why it could also be considered a breaking
change...

-Toke
