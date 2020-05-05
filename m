Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07E1C5CD3
	for <lists+bpf@lfdr.de>; Tue,  5 May 2020 18:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgEEQCI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 12:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgEEQCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 May 2020 12:02:08 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA2C061A0F
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 09:02:07 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id j21so2161622qtq.8
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4TpoaWOfIMzmYuVNUIcM8L6z3F6N2eWr0N5QkQaPvjQ=;
        b=G7tdmrsu+zxRxidc70dCpsGkxiilgCmO48j6ceb5nrDTv3ar2ISjTE7RObtySznkV7
         ooe2q9aBupInIcOAaUwGF8tP8x0MOQKDkMikK7GDLd46EgxfSMXpza+/sHLGiinJUpL+
         ik4/qzPh8ywmG7BxoyqGypf4ykWhBJ5OcIesAcV7lemPIewW6qr3aVQbW9UvxnRGPOLD
         L0ahpH35GQMiMeWdTzwu6L73GbPgu/wSpDKVI71AzVAZpN20aXZ4x+2r2dvJNDOFMl+R
         6bmYqjlwdSJYy3XY1n8FlH6w38U+IMNhr9uLxYVoMUPkUnc9HBp9PPuqjZ3JTZBneIlL
         AlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4TpoaWOfIMzmYuVNUIcM8L6z3F6N2eWr0N5QkQaPvjQ=;
        b=Nb5+TuuneVHe55J5KHop5T0xLIFgWblUOCvEprfk7QFqTZf/5p3FqO0r2fw03u+Hy4
         /0cEU7apxGd1qWYp2StmI029Ffgbga0AkyjewxhrnDs1f60Dlv7bb4GW1rvvV8mY0nj3
         nA++zgHEmVrWomIXhMWwUzJdH+Xj8o/ijhv1tk7zpjs8/YQz7lu/RdzAKFjGjF2w3TXK
         HlrfnLZED8TG6GLBs/nwL2kIpG1gA0N6roVWyMa/jorsq9H2RfJ23lFmdLQ89Fr3MHht
         OS+PMCvNWjsiCFVbP9vcaYflhMaPMfgCoigsFkwu4Asd1EXUn8BtsLnYD66MUgwat4rF
         n7Lw==
X-Gm-Message-State: AGi0PubdRtRZX7xHvyH+ssPkmZirB0YHTsUvge8Alo/pWREYHkwbK9af
        e3L6q1MFIesDfxwPG08VnhdVb9k=
X-Google-Smtp-Source: APiQypIF0ddYHy8xsgRXU78QVTDeS4HKsMC8JKxV12udHEG/wHma1l60yxM2yg+6mjSEPRGivfB1oKw=
X-Received: by 2002:a0c:b601:: with SMTP id f1mr3237273qve.99.1588694526978;
 Tue, 05 May 2020 09:02:06 -0700 (PDT)
Date:   Tue, 5 May 2020 09:02:05 -0700
In-Reply-To: <20200504232247.GA20087@rdna-mbp>
Message-Id: <20200505160205.GC241848@google.com>
Mime-Version: 1.0
References: <20200504173430.6629-1-sdf@google.com> <20200504173430.6629-5-sdf@google.com>
 <20200504232247.GA20087@rdna-mbp>
Subject: Re: [PATCH bpf-next 4/4] bpf: allow any port in bpf_bind helper
From:   sdf@google.com
To:     Andrey Ignatov <rdna@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/04, Andrey Ignatov wrote:
> Stanislav Fomichev <sdf@google.com> [Mon, 2020-05-04 10:34 -0700]:
> > We want to have a tighter control on what ports we bind to in
> > the BPF_CGROUP_INET{4,6}_CONNECT hooks even if it means
> > connect() becomes slightly more expensive. The expensive part
> > comes from the fact that we now need to call inet_csk_get_port()
> > that verifies that the port is not used and allocates an entry
> > in the hash table for it.

> FWIW: Initially that IP_BIND_ADDRESS_NO_PORT limitation came from the
> fact that on my specific use-case (mysql client making 200-500 connects
> per sec to mysql server) disabling the option was making application
> pretty much unusable (inet_csk_get_port was taking more time than mysql
> client connect timeout == 3sec).

> But I guess for some use-cases that call sys_connect not too often it
> makes sense.
Yeah, I don't think we plan to reach those QPS numbers.
But, for the record, did you try to bind to a random port in that
case? And did you bail out on error or did a couple of retries?

> > Since we can't rely on "snum || !bind_address_no_port" to prevent
> > us from calling POST_BIND hook anymore, let's add another bind flag
> > to indicate that the call site is BPF program.
> >
> > Cc: Andrey Ignatov <rdna@fb.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/net/inet_common.h                     |   2 +
> >  net/core/filter.c                             |   9 +-
> >  net/ipv4/af_inet.c                            |  10 +-
> >  net/ipv6/af_inet6.c                           |  12 +-
> >  .../bpf/prog_tests/connect_force_port.c       | 104 ++++++++++++++++++
> >  .../selftests/bpf/progs/connect_force_port4.c |  28 +++++
> >  .../selftests/bpf/progs/connect_force_port6.c |  28 +++++
> >  7 files changed, 177 insertions(+), 16 deletions(-)
> >  create mode 100644  
> tools/testing/selftests/bpf/prog_tests/connect_force_port.c
> >  create mode 100644  
> tools/testing/selftests/bpf/progs/connect_force_port4.c
> >  create mode 100644  
> tools/testing/selftests/bpf/progs/connect_force_port6.c

> Documentation in include/uapi/linux/bpf.h should be updated as well
> since now it states this:


>   *              **AF_INET6**). Looking for a free port to bind to can be
>   *              expensive, therefore binding to port is not permitted by  
> the
>   *              helper: *addr*\ **->sin_port** (or **sin6_port**,  
> respectively)
>   *              must be set to zero.

> IMO it's also worth to keep a note on performance implications of
> setting port to non zero.
Ah, thank you, will do!

> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index fa9ddab5dd1f..fc5161b9ff6a 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -4527,29 +4527,24 @@ BPF_CALL_3(bpf_bind, struct bpf_sock_addr_kern  
> *, ctx, struct sockaddr *, addr,
> >  	struct sock *sk = ctx->sk;
> >  	int err;
> >
> > -	/* Binding to port can be expensive so it's prohibited in the helper.
> > -	 * Only binding to IP is supported.
> > -	 */
> >  	err = -EINVAL;
> >  	if (addr_len < offsetofend(struct sockaddr, sa_family))
> >  		return err;
> >  	if (addr->sa_family == AF_INET) {
> >  		if (addr_len < sizeof(struct sockaddr_in))
> >  			return err;
> > -		if (((struct sockaddr_in *)addr)->sin_port != htons(0))
> > -			return err;
> >  		return __inet_bind(sk, addr, addr_len,
> > +				   BIND_FROM_BPF |
> >  				   BIND_FORCE_ADDRESS_NO_PORT);

> Should BIND_FORCE_ADDRESS_NO_PORT be passed only if port is zero?
> Passing non zero port and BIND_FORCE_ADDRESS_NO_PORT at the same time
> looks confusing (even though it works).
Makes sense, will remove it here, thx.
