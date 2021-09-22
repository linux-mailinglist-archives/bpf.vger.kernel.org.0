Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4841439C
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhIVIWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 04:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhIVIW2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 04:22:28 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF0C06175F
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 01:20:58 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n71so2406326iod.0
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKG1/AaxqP8LgmIVBGev2T1cmDt5QBf1NjWmmXtVF6A=;
        b=VT8a+fZ8vP6BxFU02v4n1naeqrZ3wy9/Y4z4kiAqSZRXrxlgS8vVz3AYNgRFDTsEh2
         4vltZJDWDw/u1xgUlwTrczbuDMWAjnTqn/jpDPKleeLRcZTY1DTMw+BJAsy4jRNvy94Y
         hraIrilPvR1oD43s/zHgHnP3ABhf6I9mBmgBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKG1/AaxqP8LgmIVBGev2T1cmDt5QBf1NjWmmXtVF6A=;
        b=4kGqPVsi8c5Up6IE/i1L3CKbNEnsyoL31TC1jvJ7rVQv/BLpFQP0jShIxlxg+EY/Gr
         UOxqFRLiSEN7XBagR9rBuaZQZGN/UNpKTYU7nFKO9hBsDhRRVz8EWl+lNIGN2yoBzL2O
         oZ7dyIhUzKwxf6jxJEfumYslK++DWY45LtYiCsPoC11eKhnMxS/aWFYj3JjKOQ70ZJ8F
         ekevOPsdVikJ31oMeLbosVeRnODcW2sBL9wbld4jdxtAHXEPY4iC/5Iyvz5X0zADvGZf
         tZpi3qeBUkTGEoG6i9v8G/crsv0QlYePnFCgwzeCalJe9NJrmwumY+rhpDeVqSaNzqyE
         lVrg==
X-Gm-Message-State: AOAM532QYCu3fwpQJQ43uv0hZfPWxUYMVZOa/FgXFqgYG1HiI8pp0BNQ
        fk+ZaL3TG9edQukZ/J85yRNj2rzlRyoGJhv4jD8yjQ==
X-Google-Smtp-Source: ABdhPJyqZmJLf9Nt3jE558nZ3tIQgo+mCbaDKVO3M5NtcC7pW9QslZVwXDhqVh/5Rr5SbbgiwcwEVSqJOx74gyhlozk=
X-Received: by 2002:a6b:f908:: with SMTP id j8mr3522864iog.22.1632298857908;
 Wed, 22 Sep 2021 01:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
 <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
 <CACAyw9_1s2ZCBWTHvT-rGufW+-m3F722GvhHb_rSR3mEr2gfGA@mail.gmail.com>
 <CABEBQi=WfdJ-h+5+fgFXOptDWSk2Oe_V85gR90G2V+PQh9ME0A@mail.gmail.com> <CAADnVQKX+ngPV=ZD9+Mm-odr=g-Neqm21TtxZ_rHpt+ybs-8RQ@mail.gmail.com>
In-Reply-To: <CAADnVQKX+ngPV=ZD9+Mm-odr=g-Neqm21TtxZ_rHpt+ybs-8RQ@mail.gmail.com>
From:   Frank Hofmann <fhofmann@cloudflare.com>
Date:   Wed, 22 Sep 2021 09:20:47 +0100
Message-ID: <CABEBQi=aZNfOdPH1999sfpD_dvSiOnhnudH3d=XEuQ=0q_bBCA@mail.gmail.com>
Subject: Re: bpf_jit_limit close shave
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 8:59 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 21, 2021 at 12:11 PM Frank Hofmann <fhofmann@cloudflare.com> wrote:
> >
> > Wouldn't that (updating the variable only for unpriv use) also make the leak impossible to notice that we ran into ?
>
> impossible?
> That jit limit is not there on older kernels and doesn't apply to root.
> How would you notice such a kernel bug in such conditions?

I'm talking about bpf_jit_current - it's an "overall gauge" for
allocation, priv and unpriv. I understood Lorenz' note as "change it
so it only tracks unpriv BPF mem usage - since we'll never act on
privileged usage anyway"

FrankH.

>
> > (we have something near to a simple reproducer for https://www.spinics.net/lists/kernel/msg4029472.html ... need to extract the relevant parts of an app of ours, will update separately when there)
> >
> > FrankH.
> >
> > On Tue, Sep 21, 2021 at 4:52 PM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >>
> >> On Tue, 21 Sept 2021 at 15:34, Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >> >
> >> > On Tue, Sep 21, 2021 at 4:50 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >> > >
> >> > > Does it make sense to include !capable(CAP_BPF) in the check?
> >> >
> >> > Good point. Makes sense to add CAP_BPF there.
> >> > Taking down critical networking infrastructure because of this limit
> >> > that supposed to apply to unpriv users only is scary indeed.
> >>
> >> Ok, I'll send a patch. Can I add a Fixes: 2c78ee898d8f ("bpf:
> >> Implement CAP_BPF")?
> >>
> >> Another thought: move the check for bpf_capable before the
> >> atomic_long_add_return? This means we only track JIT allocations from
> >> unprivileged users. As it stands a privileged user can easily "lock
> >> out" unprivileged users, which on our set up is a real concern. We
> >> have several socket filters / SO_REUSEPORT programs which are
> >> critical, and also use lots of XDP from privileged processes as you
> >> know.
> >>
> >> >
> >> > > This limit reminds me a bit of the memlock issue, where a global limit
> >> > > causes coupling between independent systems / processes. Can we remove
> >> > > the limit in favour of something more fine grained?
> >> >
> >> > Right. Unfortunately memcg doesn't distinguish kernel module
> >> > memory vs any other memory. All types of memory are memory.
> >> > Regardless of whether its type is per-cpu, bpf map memory, bpf jit memory, etc.
> >> > That's the main reason for the independent knob for JITed memory.
> >> > Since it's a bit special. It's a crude knob. Certainly not perfect.
> >>
> >> I'm missing context, how is JIT memory different from these other kinds of code?
> >>
> >> Lorenz
> >>
> >> --
> >> Lorenz Bauer  |  Systems Engineer
> >> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
> >>
> >> www.cloudflare.com
