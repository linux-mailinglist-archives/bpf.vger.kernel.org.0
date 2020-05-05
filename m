Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AEF1C5FEB
	for <lists+bpf@lfdr.de>; Tue,  5 May 2020 20:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgEESTv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgEESTv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 May 2020 14:19:51 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E64C061A0F
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 11:19:50 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id r3so100532qvm.1
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTwdv15S/D2Vz5Kw65NRHJAM8U3omNT/jpqX3z91B0E=;
        b=DTZwnDnHzgKQhmNgiXuwqqMIphTpmzHlIHhxB2jKBm3MD4Py8Sn/DTiyA95N55W3Kp
         lHi50KxWmd7HTtaYAtVEzkgv6rKEkN+I/fY99YcWIk3U0bp7CxrnGcf11BcpBn0AHACc
         e89lnIQM15Xbz3xvetUALqdO4RKdzK9HCDt+xjUnC9GlJ+x4UWhVkQKvxzoJdI6UiTU2
         b3r/Z2lsSxO+dkoQKAY7F1nVrNIX4B2v+znpiBJIyIrb7WULEH0I7zCSTZrPF4bhXG2n
         f4Hs9YBT+UNDcWAVGsvmk7Ze06m+HhDl++HNEP3Hm8qD0sfcObhx6JHS6XSu/EVITzlW
         70RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTwdv15S/D2Vz5Kw65NRHJAM8U3omNT/jpqX3z91B0E=;
        b=qq3hmgwUOEI1lxIfMr1983WxRMe4OXpinpNwVoKVlBfIvFXJepVMN+i31GPaqd2fko
         uglar5+JMeWKdJNgJ5J7Qlcml3g8Xmt0KoX2Zsv/prdq2tz9ddS1aOu/Y/agVzVQLWiV
         1w3t42BxlTrb0KwmMIT3Ix42GDDKCZ20FtZ5arGB8VeQXYkassYH6gs92AVwmNmNPwdC
         MG5f0uozlH8grfKby7ucAhspPv8Du1bezU8RgBswGsdbvy760HBmcCPmwqDdoEyHMBZ6
         IO0I68/O9hyGq5h6tKRJ/pjNhYTlrcgel9Q6FlMVGXah9UqNXHWNATO9mXXhE9fu4T6N
         eFWw==
X-Gm-Message-State: AGi0PuZT+gve8BIiXFqIDlUb/2/PL+qq6sxOYAfvpX+Q1t4k+0nNjG6o
        ZCaoPnaaAHE/QRoY+3//p9ekzKb8emdyigMQJwoov3Bd
X-Google-Smtp-Source: APiQypLShD5cetdUPyEs6u/xsB/iSUOjGYBixyfXMTFuRwlDAsWLK5Ip++gLApfn6rQrZls4RYIMxR8Hy74tSRyQ+IE=
X-Received: by 2002:a0c:8ecf:: with SMTP id y15mr4299235qvb.44.1588702789730;
 Tue, 05 May 2020 11:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200504173430.6629-1-sdf@google.com> <20200504173430.6629-4-sdf@google.com>
 <20200505181634.sd2m63wu7lf22z3x@kafai-mbp>
In-Reply-To: <20200505181634.sd2m63wu7lf22z3x@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 5 May 2020 11:19:38 -0700
Message-ID: <CAKH8qBs1wW8FPe7=1s2wYRWopt_Nnoxs8CMg_myG3npPxQw4CQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] net: refactor arguments of inet{,6}_bind
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 5, 2020 at 11:16 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, May 04, 2020 at 10:34:29AM -0700, Stanislav Fomichev wrote:
> > The intent is to add an additional bind parameter in the next commit.
> > Instead of adding another argument, let's convert all existing
> > flag arguments into an extendable bit field.
> >
> > No functional changes.
> >
> > Cc: Andrey Ignatov <rdna@fb.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/net/inet_common.h |  6 +++++-
> >  include/net/ipv6_stubs.h  |  2 +-
> >  net/core/filter.c         |  6 ++++--
> >  net/ipv4/af_inet.c        | 10 +++++-----
> >  net/ipv6/af_inet6.c       | 10 +++++-----
> >  5 files changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/net/inet_common.h b/include/net/inet_common.h
> > index ae2ba897675c..a0fb68f5bf59 100644
> > --- a/include/net/inet_common.h
> > +++ b/include/net/inet_common.h
> > @@ -35,8 +35,12 @@ int inet_shutdown(struct socket *sock, int how);
> >  int inet_listen(struct socket *sock, int backlog);
> >  void inet_sock_destruct(struct sock *sk);
> >  int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
> > +// Don't allocate port at this moment, defer to connect.
> nit. stay with /* ... */
Oh, good catch, thank you!
