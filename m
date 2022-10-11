Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D05FAA9C
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 04:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJKCaI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 22:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKCaH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 22:30:07 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8483A48E9F;
        Mon, 10 Oct 2022 19:30:06 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id a17so2709361qtw.10;
        Mon, 10 Oct 2022 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H5bopQBfqDPZFFnIWboUojrulpfKzdRY6HL8GaG6Yds=;
        b=P1o8xs/F0bTQnTJiyo+2uNIHcOqB+t4v/qJ+Y1p+dBW39cEG1g5McVLF+NOREsv/Ct
         jRvBz0MzWRzzCUwXmix0XllVvB8ndPlQFuHghAosTVsAZFRECpd13CZrCIrW66ttbE8O
         82RB8uEA9BGagBLCfk6yY0jBtjwjItN8VMGsjh7UauA50nJGTCfYTHzkGxrV/qAuDByt
         APoMj1r9wyomy3ulEPft0hLyloGSL/zelHeKXyD+AO/iif66OLO2asFsQmxI8rNIwQBT
         udphK30lrvc1NLLlWBaH5j4HcSnvFp3YDnuYtJF6O3yNKs2hWvSNhjMDeIdIy7McxVi4
         r8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5bopQBfqDPZFFnIWboUojrulpfKzdRY6HL8GaG6Yds=;
        b=GFOifh9NMtjTKX+Op34ER1maBqmu+eMILp4EJdy0wO872v6xyeQ77ylZDiJq4jJyNd
         tGmg2TlO5v9bBcDvveyUoeDewTFPYr0eR+A2AE9AajC7kJGx7NI8sB8+7cABwphWfKm6
         DAh85mcNamX1EfUvnNOVo52vPDWWxy1Oj8tOYe9M8U+K8VoLheZXprlQEVdq/utE4ejW
         134XsTx1Z8TClxlJzeuM5+0PcuHdaIXAPpjk8uBn0+EC4FQLWD3SB9pVyaZrOBkBVpbO
         YJ2+5UBJHQBWAASKJgklzvRe8/lUjLPpTqam3ubkFshUxBXviRdkhUC2dFi2X0JxI5E6
         s2lw==
X-Gm-Message-State: ACrzQf2HT405mSdEIcB4SBpz31JSffqIuUmbjLfy67LGz48i7d0m2uGf
        IUcHsk93IORhssH8SJjkyTseIutfSwhU6Mju1w4=
X-Google-Smtp-Source: AMsMyM7/cg61IUFDL3Nwh/YHT2gfRHWGh1r1pA2BKHs0R6pK7t2wgEuG2FGcB8bpyS6mmPuyxyyIj9HzBb0cvvhVRUg=
X-Received: by 2002:a05:622a:551:b0:35d:5237:1781 with SMTP id
 m17-20020a05622a055100b0035d52371781mr17502311qtx.566.1665455405572; Mon, 10
 Oct 2022 19:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221001144716.3403120-1-void@manifault.com> <20221001144716.3403120-3-void@manifault.com>
 <CAP01T74TtMARkfYWsYY0+cnsx2w4axB1LtvF-RFMAihW7v=LUw@mail.gmail.com>
 <YzsBSoGnPEIJADSH@maniforge.dhcp.thefacebook.com> <CAP01T76OR3J_P8YMq4ZgKHBpuZyA0zgsPy+tq9htbX=j6AVyOg@mail.gmail.com>
 <fb3e81b7-8360-5132-59ac-0e74483eb25f@linux.dev> <CAP01T77tCdKTJo=sByg5GsW1OrQmNXV4fmBDKUVtbnwEaJBpVA@mail.gmail.com>
 <YztbOo7TgOoN1bVB@maniforge.dhcp.thefacebook.com> <CAP01T76rCLdExKZ0AdP9L6e_g+sj9D7Ec59rr+ddMJ-KU+h8QQ@mail.gmail.com>
 <YzxM+HSSqIDCPCUf@maniforge.lan>
In-Reply-To: <YzxM+HSSqIDCPCUf@maniforge.lan>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 11 Oct 2022 07:59:29 +0530
Message-ID: <CAP01T76zg0kABh36ekC4FTxDsdiYBaP7agErO=YadfFmaJ1LKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf/selftests: Add selftests for new task kfuncs
To:     David Vernet <void@manifault.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yhs@fb.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 4 Oct 2022 at 20:40, David Vernet <void@manifault.com> wrote:
>
> On Tue, Oct 04, 2022 at 12:22:08AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > Thanks for providing additional context, Kumar. So what do we want to do
> > > for this patch set? IMO it doesn't seem useful to restrict
> > > bpf_kfunc_acquire() to only be callable by non-sleepable programs if our
> > > goal is to avoid crashes for nested task structs. We could easily
> > > accidentally crash if e.g. those pointers are NULL, or someone is doing
> > > something weird like stashing some extra flag bits in unused portions of
> > > the pointer which are masked out when it's actually dereferenced
> > > regardless of whether we're in RCU.  Trusting ctx loads sounds like the
> > > right approach, barring some of the challenges you pointed out such as
> > > dealing with fexit paths after free where the object may not be valid
> > > anymore.
> > >
> > > In general, it seems like we should maybe decide on what our policy
> > > should be for kfuncs until we can wire up whatever we need to properly
> > > trust ctx.
> >
> > Well, we could add it now and work towards closing the gaps after
> > this, especially if bpf_task_acquire is really only useful in
> > sleepable programs where it works on the tracing args. A lot of other
> > kfuncs need these fixes as well, so it's a general problem and not
> > specific to this set. I am not very familiar with your exact use case.
> > Hopefully when it is fixed this particular case won't really break, if
> > you only use the tracepoint argument.
>
> I'm also interested in using this with struct_ops, not just tracing. I
> think that struct_ops should be totally fine though, and easier to
> reason about than tracing as we just have to make sure that a few
> specific callbacks are always passed a valid, referenced task, rather
> than e.g. worrying about fexit on __put_task_struct().
>
> I'm fine with adding this now and working towards closing the gaps
> later, though I'd like to hear what Martin, Alexei, and the rest of the
> BPF maintainers think. I think Martin asked if there was any preliminary
> work you'd already done that we could try to tie into this patch set,
> and I'm similarly curious.
>

It's mostly a few experimental patches in my local tree, so nowhere
close to completion. Ofcourse doing it properly will be a lot of work,
but I will be happy to help with reviews if you want to focus on
pointers loaded from ctx for now and make that part of this set, while
not permitting any other cases. It should not be very difficult to add
just that.

So you can set KF_TRUSTED_ARGS for your kfunc, then make it work for
PTR_TO_BTF_ID where it either has PTR_TRUSTED, ref_obj_id > 0, or
both. Just that PTR_TRUSTED is lost for the destination reg as soon as
btf_struct_access is used to walk pointers (unlike PTR_UNTRUSTED which
is inherited). Note that you don't _set_ PTR_UNTRUSTED here for the
dst_reg.

This should enable your immediate use case, while also being useful
for future work that builds on it. It should also preserve backwards
compatibility with existing stable helpers. You set PTR_TRUSTED when
you access ctx of tracing or struct_ops etc. All this will be handled
in is_valid_access callback/btf_ctx_access and setting the flag in
bpf_insn_access_aux. Unless I missed some detail/corner case it won't
be a lot of code.

If that turns out to be too restrictive/coarse for your use case, we
can just go with this as is for now.

Does that sound good? Any other comments/opinions?
