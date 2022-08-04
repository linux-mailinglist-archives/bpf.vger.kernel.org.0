Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6258A2D2
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 23:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiHDVnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 17:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiHDVnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 17:43:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3744AD5B
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 14:43:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso1008541pjd.3
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 14:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SigDgeICsRcj0seHNb+zuC4V21V8kqyfwa7pBqI6ReA=;
        b=MiIHhI4x/v/0oAqvqZWmw7caEvsl4n8feHreZZmwnz5qRYuoRNxKuwH2J24lCWam3q
         kXgiq5uag2gW9USp1BhILJxKXOCxEuXO9RfqIqjq0Al9+vdCCVloDZZSsanBzBfDT77d
         gkJjcq2qtpahHn0F4os5LkgQ0u5O8zDr3l1yrM6kMEFqy/2nUooT7RJ4BfJMDYS5E5Oa
         67yRX9SMQsjTZQoE86BkzFWGARwgqZcPQNB6l3uQfgw37TxP4wR6G5wZzPeXWm3T5c+G
         MVu53ULEtvzgf8GfwLcDlmZ4J3lq3PckHXERQAzQypOQZk6vEYG8NpiYKIkCsPT8+NSI
         x0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SigDgeICsRcj0seHNb+zuC4V21V8kqyfwa7pBqI6ReA=;
        b=3jFaDii/kMG+vo7GgfW/yx/xGSQhTPOH6ZrRA1lKAcvcFARO/lK5kzUhZPgAlqWFHY
         RRq2lpstbAkAfegoReKSQMcezLnnPNSDm3/4mxGWd3gL2SISYu6mnVnGt5kkhWISJbay
         xJeabm4F0u7gMqQWuz8etLZwFB7HW6LXdcSJf+r96xZCgQEppoWyR5fjy4ENBK0qHo/l
         Cx2ymtbWLJn0kPiR3RT4bK7iNYP+VbmxJ2XgZAA0PTuKwpS9zjPpTNbZ3BxhcU+cHb70
         Y2CgiqkBLR/uBvkhQEGrI92kT+jV6gnhCsqhYvDidvUDeQMeUzHX5xFpIzfI2Mpe8oL7
         3xFw==
X-Gm-Message-State: ACgBeo299Tnn4ztqZu/WLgti/WelfnhipcKVMftfkcmNLhZsPolPqRbE
        7cMXXS2xOa7CzV9xk7uSEjLY++s/ZHfpAISuOpWMXVy2qr1G6g==
X-Google-Smtp-Source: AA6agR4ig4k7c1mPiLCUq/TtZqbnNibmVCwZ3EPn2R2stIddbDMSuEbX5dwCwgJbRzaaK3wGeXcfdUj887EmNmCTqHw=
X-Received: by 2002:a17:903:2444:b0:16d:baf3:ff06 with SMTP id
 l4-20020a170903244400b0016dbaf3ff06mr3573416pls.148.1659649400337; Thu, 04
 Aug 2022 14:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220803204601.3075863-1-kafai@fb.com> <20220803204614.3077284-1-kafai@fb.com>
 <CAEf4Bzb9js_4UFChVWOjw52ik5TmNJroF5bXSicJtxyNZH8k3A@mail.gmail.com>
 <20220804192924.xmj6k556prcqncvk@kafai-mbp.dhcp.thefacebook.com> <CAEf4BzZiuguQcV4qj_P7AA16O8e9QrvLRgvBbvWeMqnXdJfxoA@mail.gmail.com>
In-Reply-To: <CAEf4BzZiuguQcV4qj_P7AA16O8e9QrvLRgvBbvWeMqnXdJfxoA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 4 Aug 2022 14:43:09 -0700
Message-ID: <CAKH8qBtwcOuzLk_XHksf0yjR6rAgLvSsJN27Frh=pw3LX5AVrw@mail.gmail.com>
Subject: Re: Universally available bpf_ctx WAS: Re: [PATCH v2 bpf-next 02/15]
 bpf: net: Avoid sk_setsockopt() taking sk lock when called from bpf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 4, 2022 at 1:51 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 4, 2022 at 12:29 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Thu, Aug 04, 2022 at 12:03:04PM -0700, Andrii Nakryiko wrote:
> > > On Wed, Aug 3, 2022 at 1:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > Most of the code in bpf_setsockopt(SOL_SOCKET) are duplicated from
> > > > the sk_setsockopt().  The number of supported optnames are
> > > > increasing ever and so as the duplicated code.
> > > >
> > > > One issue in reusing sk_setsockopt() is that the bpf prog
> > > > has already acquired the sk lock.  This patch adds a in_bpf()
> > > > to tell if the sk_setsockopt() is called from a bpf prog.
> > > > The bpf prog calling bpf_setsockopt() is either running in_task()
> > > > or in_serving_softirq().  Both cases have the current->bpf_ctx
> > > > initialized.  Thus, the in_bpf() only needs to test !!current->bpf_ctx.
> > > >
> > > > This patch also adds sockopt_{lock,release}_sock() helpers
> > > > for sk_setsockopt() to use.  These helpers will test in_bpf()
> > > > before acquiring/releasing the lock.  They are in EXPORT_SYMBOL
> > > > for the ipv6 module to use in a latter patch.
> > > >
> > > > Note on the change in sock_setbindtodevice().  sockopt_lock_sock()
> > > > is done in sock_setbindtodevice() instead of doing the lock_sock
> > > > in sock_bindtoindex(..., lock_sk = true).
> > > >
> > > > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > > > ---
> > > >  include/linux/bpf.h |  8 ++++++++
> > > >  include/net/sock.h  |  3 +++
> > > >  net/core/sock.c     | 26 +++++++++++++++++++++++---
> > > >  3 files changed, 34 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 20c26aed7896..b905b1b34fe4 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -1966,6 +1966,10 @@ static inline bool unprivileged_ebpf_enabled(void)
> > > >         return !sysctl_unprivileged_bpf_disabled;
> > > >  }
> > > >
> > > > +static inline bool in_bpf(void)
> > >
> > > I think this function deserves a big comment explaining that it's not
> > > 100% accurate, as not every BPF program type sets bpf_ctx. As it is
> > > named in_bpf() promises a lot more generality than it actually
> > > provides.
> > >
> > > Should this be named either more specific has_current_bpf_ctx() maybe?
> > Stans also made a similar point on this to add comment.
> > Rename makes sense until all bpf prog has bpf_ctx.  in_bpf() was
> > just the name it was used in the v1 discussion for the setsockopt
> > context.
> >
> > > Also, separately, should be make an effort to set bpf_ctx for all
> > > program types (instead or in addition to the above)?
> > I would prefer to separate this as a separate effort.  This set is
> > getting pretty long and the bpf_getsockopt() is still not posted.
>
> Yeah, sure, I don't think you should be blocked on that.
>
> >
> > If you prefer this must be done first, I can do that also.
>
> I wanted to bring this up for discussion. I find bpf_ctx a very useful
> construct, if we had it available universally we could use it
> (reliably) for this in_bpf() check, we could also have a sleepable vs
> non-sleepable flag stored in such context and thus avoid all the
> special handling we have for providing different gfp flags, etc.

+1

> But it's not just up for me to decide if we want to add it for all
> program types (e.g., I wouldn't be surprised if I got push back adding
> this to XDP). Most program types I normally use already have bpf_ctx
> (and bpf_cookie built on top), but I was wondering what others feel
> regarding making this (bpf_ctx in general, bpf_cookie in particular)
> universally available.

If we can get universal bpf_ctx, do we still need bpf_prog_active?
Regarding xdp: assigning a bunch of pointers shouldn't hopefully be
that big of a deal?
