Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E465F38F9
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 00:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJCW0j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 18:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJCW0V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 18:26:21 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DDA58160;
        Mon,  3 Oct 2022 15:22:50 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s9so7432032qkg.4;
        Mon, 03 Oct 2022 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wM7wPD8f79SSFVWRPvP5qUh82VgQ7j1zP1Vww+nENyA=;
        b=Chf2iZovuz4PmA/vCkDRcmYqisz4G7p4IeFY6bIBWq7fd0crQYoeJ8p8pt6aXuPvJr
         FtFOtk0vdtpP3GVtNVRDQEl7uMjjNX3UQ7dMLOx2h6VK1O0iq4x5BApPDgnGS+sbGInc
         6yVETFHQ90ZxHALd3dpIISJ5kSYseoM8f1xBMsCvk8P8NFd1M7cLI2qylbKt+gi704Qx
         i4s15e2i7OoSqVEVumM+RvkdaYDa+6Lf+vSJNCmLv+BNdGGYzadkRQMxWLacMkqpXmzc
         1Te+r6+ajBZyvMDxgFENYe0c3AIRT2eZovGMq3gey3GKKvTPm7qY/l0BxQBonTzHz+p3
         m7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wM7wPD8f79SSFVWRPvP5qUh82VgQ7j1zP1Vww+nENyA=;
        b=38iROXrxGrOyMvQPoIdUDQzYVl0cElHTn6Vw2NmBtlXxiCdfNa4XLxRVAIV2pTcbXZ
         Di5A23ZvA4kQBy0BeKE0MLuioc96HsnGwrcFC7wyMsVOvXPjW7J0Tb9lobsUxC/eTaYV
         /O6jgblpT1RnS8iMbFfI5F1CQLms9oE1JVDp4s0D/tZDTV++mVVivDz4s4KBjx/dHyYH
         wffGkS9nIg79h9mrCq/9CJuniInry+tdkgrEHJfmt3Q9C17wDMBecmRXlAmtNmyid5fb
         9JGFwp59A8xflYk6ua/PAwCLV7ldWfsif87uypsanIwoOTN9e7QyPo1UJwlsXIop/HX4
         4P2g==
X-Gm-Message-State: ACrzQf3dj+5I/9DxE3BXjJ3RoQB1HNJaJ0xzXm+m5jqXMcR2zeqg0JQ1
        4ti7uM/9w5sDLYT9PEoagf+CgJYun5O5mJ0ifyg=
X-Google-Smtp-Source: AMsMyM50HDCQVT+seJ4IHqotPqohFyXEYu4Vh8AuJIwFFrbSqbPahZtbvxTJUv6FM0ZIftmSTpORrFqoevAL5AU1yP4=
X-Received: by 2002:a05:620a:c52:b0:6cf:bce6:54e5 with SMTP id
 u18-20020a05620a0c5200b006cfbce654e5mr15178904qki.63.1664835765223; Mon, 03
 Oct 2022 15:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221001144716.3403120-1-void@manifault.com> <20221001144716.3403120-3-void@manifault.com>
 <CAP01T74TtMARkfYWsYY0+cnsx2w4axB1LtvF-RFMAihW7v=LUw@mail.gmail.com>
 <YzsBSoGnPEIJADSH@maniforge.dhcp.thefacebook.com> <CAP01T76OR3J_P8YMq4ZgKHBpuZyA0zgsPy+tq9htbX=j6AVyOg@mail.gmail.com>
 <fb3e81b7-8360-5132-59ac-0e74483eb25f@linux.dev> <CAP01T77tCdKTJo=sByg5GsW1OrQmNXV4fmBDKUVtbnwEaJBpVA@mail.gmail.com>
 <YztbOo7TgOoN1bVB@maniforge.dhcp.thefacebook.com>
In-Reply-To: <YztbOo7TgOoN1bVB@maniforge.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 4 Oct 2022 00:22:08 +0200
Message-ID: <CAP01T76rCLdExKZ0AdP9L6e_g+sj9D7Ec59rr+ddMJ-KU+h8QQ@mail.gmail.com>
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

On Mon, 3 Oct 2022 at 23:59, David Vernet <void@manifault.com> wrote:
>
> On Mon, Oct 03, 2022 at 11:03:01PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 3 Oct 2022 at 21:53, Martin KaFai Lau <martin.lau@linux.dev> wrote:
> > >
> > > On 10/3/22 8:56 AM, Kumar Kartikeya Dwivedi wrote:
> > > >>> Also, could you include a test to make sure sleepable programs cannot
> > > >>> call bpf_task_acquire? It seems to assume RCU read lock is held while
> > > >>> that may not be true. If already not possible, maybe a WARN_ON_ONCE
> > > >>> inside the helper to ensure future cases don't creep in.
> > > >>
> > > >> I don't _think_ it's unsafe for a sleepable program to call
> > > >> bpf_task_acquire(). My understanding is that the struct task_struct *
> > > >> parameter to bpf_task_acquire() is not PTR_UNTRUSTED, so it's safe to
> > > >> dereference directly in the kfunc. The implicit assumption here is that
> > > >> the task was either passed to the BPF program (which is calling
> > > >> bpf_task_acquire()) from the main kernel in something like a trace or
> > > >> struct_ops callback, or it was a referenced kptr that was removed from a
> > > >> map with bpf_kptr_xchg(), and is now owned by the BPF program. Given
> > > >> that the ptr type is not PTR_UNTRUSTED, it seemed correct to assume that
> > > >> the task was valid in bpf_task_acquire() regardless of whether we were
> > > >> in an RCU read region or not, but please let me know if I'm wrong about
> > > >
> > > > I don't think it's correct. You can just walk arbitrary structures and
> > > > obtain a normal PTR_TO_BTF_ID that looks seemingly ok to the verifier
> > > > but has no lifetime guarantees. It's a separate pre-existing problem
> > > > unrelated to your series [0]. PTR_UNTRUSTED is not set for those cases
> > > > currently.
> > > >
> > > > So the argument to your bpf_task_acquire may already be freed by then.
> > > > This issue would be exacerbated in sleepable BPF programs, where RCU
> > > > read lock is not held, so some cases of pointer walking where it may
> > > > be safe no longer holds.
> > > >
> > > > I am planning to clean this up, but I'd still prefer if we don't allow
> > > > this helper in sleepable programs, yet. kptr_get is ok to allow.
> > > > Once you have explicit BPF RCU read sections, sleepable programs can
> > > > take it, do loads, and operate on the RCU pointer safely until they
> > > > invalidate it with the outermost bpf_rcu_read_unlock. It's needed for
> > > > local kptrs as well, not just this. I plan to post this very soon, so
> > > > we should be able to fix it up in the current cycle after landing your
> > > > series.
> > > >
> > > > __rcu tags in the kernel will automatically be understood by the
> > > > verifier and for the majority of the correctly annotated cases this
> > > > will work fine and not break tracing programs.
> > > >
> > > > [0]: https://lore.kernel.org/bpf/CAADnVQJxe1QT5bvcsrZQCLeZ6kei6WEESP5bDXf_5qcB2Bb6_Q@mail.gmail.com
> > > >
> > > >> that.  Other kfuncs I saw such as bpf_xdp_ct_lookup() assumed that the
> > > >> parameter passed by the BPF program (which itself was passing on a
> > > >> pointer given to it by the main kernel) is valid as well.
> > > >
> > > > Yeah, but the CT API doesn't assume validity of random PTR_TO_BTF_ID,
> > > > it requires KF_TRUSTED_ARGS which forces them to have ref_obj_id != 0.
> > >
> > > Other than ref_obj_id != 0, could the PTR_TO_BTF_ID obtained through
> > > btf_ctx_access be marked as trusted (e.g. the ctx[0] in the selftest here)
> > > and bpf_task_acquire() will require KF_TRUSTED_ARGS? would it be safe in general?
> > >
> >
> > Recently eed807f62610 ("bpf: Tweak definition of KF_TRUSTED_ARGS")
> > relaxed things a bit, now that constraint is only for PTR_TO_BTF_ID
> > and it allows other types without ref_obj_id > 0.
> >
> > But you're right, ctx loads should usually be trusted, this is the
> > current plan (also elaborated a bit in that link [0]), usually that is
> > true, an exception is free path as you noted in your reply for patch 1
> > (and especially fexit path where object may not even be alive
> > anymore). There are some details to work out, but eventually I'd want
> > to force KF_TRUSTED_ARGS by default for all kfuncs, and we only make
> > exceptions in some special cases by having some KF_UNSAFE flag or
> > __unsafe tag for arguments. It's becoming harder to think about all
> > permutations if we're too permissive by default in terms of acceptable
> > arguments.
>
> Thanks for providing additional context, Kumar. So what do we want to do
> for this patch set? IMO it doesn't seem useful to restrict
> bpf_kfunc_acquire() to only be callable by non-sleepable programs if our
> goal is to avoid crashes for nested task structs. We could easily
> accidentally crash if e.g. those pointers are NULL, or someone is doing
> something weird like stashing some extra flag bits in unused portions of
> the pointer which are masked out when it's actually dereferenced
> regardless of whether we're in RCU.  Trusting ctx loads sounds like the
> right approach, barring some of the challenges you pointed out such as
> dealing with fexit paths after free where the object may not be valid
> anymore.
>
> In general, it seems like we should maybe decide on what our policy
> should be for kfuncs until we can wire up whatever we need to properly
> trust ctx.

Well, we could add it now and work towards closing the gaps after
this, especially if bpf_task_acquire is really only useful in
sleepable programs where it works on the tracing args. A lot of other
kfuncs need these fixes as well, so it's a general problem and not
specific to this set. I am not very familiar with your exact use case.
Hopefully when it is fixed this particular case won't really break, if
you only use the tracepoint argument.

It is true that waiting for all the fixes will unnecessarily stall
this, it is not clear how each of the issues will be addressed either.

Later its use can be made conditional in sleepable programs for
trusted and rcu tagged pointers under appropriate RCU read lock. I
will try to prioritize sending it out so that we resolve this soon.
