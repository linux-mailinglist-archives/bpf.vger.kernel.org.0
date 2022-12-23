Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B351E655209
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 16:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiLWPaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 10:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLWPaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 10:30:24 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8214228E39
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 07:30:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d82so3528720pfd.11
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sC5sLWXn+hX58uHQr6oilZ1kqWbaxgV442Q41BCVgn4=;
        b=KQjx15fZY76D4vCOgrb7ehKhOoZtkTIHI6836wKVwELp3edX+6FF5ROQI/sEldumYF
         2SJFHB5KOH0Xsxj3KV4HE81I3eneyh14kQIJdPXFM4zwIYbAl23jN9/10zoehwHF83Cf
         IepkRtd9J28bcF7y4gX5DFBcT9j1Mmdz75ww9LIwPYCBGVAvP2YFCFiwrrIpqO6K8/Ys
         tT3COJRzzowd5N+6L51kO8FZ1dHQ33JIzWLbmiStBBAH4pFX4J3luHojjDn4Z5ZzI7PV
         5ZT9Fswf3skYvFA+U337yCBVrw5oIOKOXMpCpDr/5UJj4Nz+uw/V3O7tfaqv9Z9K2AnD
         QI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sC5sLWXn+hX58uHQr6oilZ1kqWbaxgV442Q41BCVgn4=;
        b=hmTMmd2VDMDYfk/jNkSMWcatRHjZHtm0ve4rGLep4/DO9tdsdKkZCHVrIhH2gQG0ZR
         tpcmjgK1TSv1U/4n3O2yWNf3C1DNqt9r/JT4d9trP0asLCQXDpBHcS8vA4gqiKE/73Yy
         9DLqD2fYSTHmRRsFMOWU/yTFitf9LTKmKIUjVyu+KuC7VAOxBRAVpLhdzLWeYNIZeREr
         FZus+LAqV9sc9HI7Z6tlPZW0QkUQO9XprFlPBCXZxyYs4HcaGAc/UdQepqwMkWTcWg3K
         R0zkFqZTF5rXJxWeAAkXx0Ns+fL72pasmwz1vYeOx2mQ0O3UnuFhx0EfhFqeXs0mkl27
         hYNg==
X-Gm-Message-State: AFqh2kqU7BVfTDRjn55AHkoIpAvmySAIZ+USSe1RW2XdMyJ61u4agn75
        8exfz8nSHyELibdutENilZT73C1fYRPoyFo363sm
X-Google-Smtp-Source: AMrXdXsvxEs8bgnHBFHsKDnWAw8jymmyXBBkiyYSYU7VEXbwec1PAe5vQfQpStJhaVLRuHJR4U5y8uL32gQXxMfQ7i8=
X-Received: by 2002:a05:6a00:1f1a:b0:576:af2d:4c5f with SMTP id
 be26-20020a056a001f1a00b00576af2d4c5fmr631350pfb.23.1671809419937; Fri, 23
 Dec 2022 07:30:19 -0800 (PST)
MIME-Version: 1.0
References: <20221222001343.489117-1-paul@paul-moore.com> <Y6SRiv+FloijdETe@google.com>
 <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
 <Y6SysZgKKEPL5ZE5@google.com> <CAHC9VhQ4EPzQ56ix9he4ZTo7eYpMdLBPpb+3vNsng_9vD2t=RQ@mail.gmail.com>
 <CAHC9VhSwpV80pPjzc2w9r--16LXuG7vYxE1eg5MCz2ytn2TH7g@mail.gmail.com> <CAKH8qBszD=PYO_nVjYUTnj7UXVcBvA95meULQGs53eyo9xfD+A@mail.gmail.com>
In-Reply-To: <CAKH8qBszD=PYO_nVjYUTnj7UXVcBvA95meULQGs53eyo9xfD+A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Dec 2022 10:30:08 -0500
Message-ID: <CAHC9VhTdRC8VqrnnHaM=jBtrgdb2KrqM7-4Z==qcQTosbXfJMg@mail.gmail.com>
Subject: Re: [PATCH] bpf: restore the ebpf audit UNLOAD id field
To:     Stanislav Fomichev <sdf@google.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 4:28 PM Stanislav Fomichev <sdf@google.com> wrote:
> On Thu, Dec 22, 2022 at 12:07 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Dec 22, 2022 at 2:59 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Dec 22, 2022 at 2:40 PM <sdf@google.com> wrote:
> > > > On 12/22, Paul Moore wrote:
> > > > > On Thu, Dec 22, 2022 at 12:19 PM <sdf@google.com> wrote:
> > > > > > On 12/21, Paul Moore wrote:

...

> > > FWIW, the currently-work-in-progress v2 patch adds a getter for the ID
> > > with a WARN() check to flag callers who are trying to access a
> > > bad/free'd bpf_prog.  Unfortunately it touches a decent chunk of code,
> > > but I think it might be a nice additional check at runtime.
> > >
> > > +u32 bpf_prog_get_id(const struct bpf_prog *prog)
> > > +{
> > > +       if (WARN(!prog->valid_id, "Attempting to use invalid eBPF program"))
> > > +               return 0;
> > > +       return prog->aux->__id;
> > > +}
> >
> > I should add that the getter is currently a static inline in bpf.h.
>
> I don't see why we need to WARN on !valid_id, but I might be missing something.
> There are no places currently where we report 'id == 0' to the
> userspace, so we only need to take care of the offloaded case that
> resets id to zero early (instead of resetting it during regular
> __bpf_prog_put path).

I put the WARN there, in place of a normal 'if (!prog->valid_id)', as
an extra runtime check/debug-tool for those who have CONFIG_BUG
enabled.  I'm sure everything works properly now with respect to not
using a bpf_prog reference after it has been free'd/released, but
mistakes do happen - look at the regression/bug that started this
thread :)

If you really don't want the WARN() there, I can replace it with the
simple '!prog->valid_id' check, let me know.  It's your code, you
should maintain it how you want; I just want to make sure we are
generating audit records correctly.

> > > > > I'm not seeing any other comments, so I'll go ahead with putting
> > > > > together a v2 that sets an invalid flag/bit and I'll post that for
> > > > > further discussion/review.

-- 
paul-moore.com
