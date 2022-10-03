Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565595F376C
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 23:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJCVDl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 17:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJCVDk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 17:03:40 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6279432065;
        Mon,  3 Oct 2022 14:03:38 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id f14so4009211qvo.3;
        Mon, 03 Oct 2022 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aHOOvMRJqEzmzOMYO28gEQig7JroCWhXsbzKWwTUAGc=;
        b=RBSDWyenI5LoVcKHMJJQhYYPf9Cg7I472Df9ENivvD3po2I/eqmQoFzbK6C2Gc731w
         bbS88MmTDb2B3uSAmV20rUANHHA1U/CCTYCYr0lnNfRJQpVbvdL/a1qITQr1/E+FWDMv
         BXx+Ndf+0uyRWr+GqPeYJRWjBOSZfp2UNS9Er7CNOx2aYJkubPT39uVfQMu+hbF29RRo
         jzY31KH7t9V2PReNaRJGRkdeRM3sZdHvrTm+9+wK7pvBWVvnxbXdCUmyVMrP5jHIZl/2
         gsmwUjbLDj5PeK/Ly+cl1O2WIAILfOqJyAmYifVnXhSpi4uLMDQEBM7Ld0FdXcEOt5XV
         /s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aHOOvMRJqEzmzOMYO28gEQig7JroCWhXsbzKWwTUAGc=;
        b=gDXiAaXeJ4vsxCp32yg/e+ft1tndzfBSIW9943oUONhVe/wX7wpmLiOt7QETchLLgW
         o1KU+MUexGfp/0TUNZvAWZv3dJ3ap1KcrthB95O0dPULcL9e/o9ywQFSLblZ7ouHdcDQ
         VEUOSzb3yLPPOjRybAkc+CZB5cZCNQJuAnuJMtlwoqguJNt5XHAKzRpKdJ0TFFAHoJGu
         cBgLsTxF3PdbblyzxGB+Bk19tW8f1umOwwigp738rr9ibrFAhsbNoNmRCcvh/zXcpxIe
         2J2f67gbuWL37xR+41VBHVaP8pIqqHzJ4p+ayF+m5FI+H2qPPO827Q2mMFtOGwPtTvqG
         uVIQ==
X-Gm-Message-State: ACrzQf3whS/dsEU698LH2hq1I6hc0pI/udH7imZW0J9IWedQGgwooZf/
        zjU1vHTeYWpBbndSCG8ZkWhjQNiAP66mmVgh0rWnHSD4
X-Google-Smtp-Source: AMsMyM4balioSf+Rl4+EbrC6gQWHVkeJLP0Maggud2mw8twiq3S0u1u3z9LYI87O/BKh4ZOQyvkL30zEsaSWfvwfUYE=
X-Received: by 2002:ad4:5e8b:0:b0:4b1:8654:f950 with SMTP id
 jl11-20020ad45e8b000000b004b18654f950mr7089290qvb.104.1664831017411; Mon, 03
 Oct 2022 14:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221001144716.3403120-1-void@manifault.com> <20221001144716.3403120-3-void@manifault.com>
 <CAP01T74TtMARkfYWsYY0+cnsx2w4axB1LtvF-RFMAihW7v=LUw@mail.gmail.com>
 <YzsBSoGnPEIJADSH@maniforge.dhcp.thefacebook.com> <CAP01T76OR3J_P8YMq4ZgKHBpuZyA0zgsPy+tq9htbX=j6AVyOg@mail.gmail.com>
 <fb3e81b7-8360-5132-59ac-0e74483eb25f@linux.dev>
In-Reply-To: <fb3e81b7-8360-5132-59ac-0e74483eb25f@linux.dev>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 3 Oct 2022 23:03:01 +0200
Message-ID: <CAP01T77tCdKTJo=sByg5GsW1OrQmNXV4fmBDKUVtbnwEaJBpVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf/selftests: Add selftests for new task kfuncs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     David Vernet <void@manifault.com>, ast@kernel.org,
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

On Mon, 3 Oct 2022 at 21:53, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/3/22 8:56 AM, Kumar Kartikeya Dwivedi wrote:
> >>> Also, could you include a test to make sure sleepable programs cannot
> >>> call bpf_task_acquire? It seems to assume RCU read lock is held while
> >>> that may not be true. If already not possible, maybe a WARN_ON_ONCE
> >>> inside the helper to ensure future cases don't creep in.
> >>
> >> I don't _think_ it's unsafe for a sleepable program to call
> >> bpf_task_acquire(). My understanding is that the struct task_struct *
> >> parameter to bpf_task_acquire() is not PTR_UNTRUSTED, so it's safe to
> >> dereference directly in the kfunc. The implicit assumption here is that
> >> the task was either passed to the BPF program (which is calling
> >> bpf_task_acquire()) from the main kernel in something like a trace or
> >> struct_ops callback, or it was a referenced kptr that was removed from a
> >> map with bpf_kptr_xchg(), and is now owned by the BPF program. Given
> >> that the ptr type is not PTR_UNTRUSTED, it seemed correct to assume that
> >> the task was valid in bpf_task_acquire() regardless of whether we were
> >> in an RCU read region or not, but please let me know if I'm wrong about
> >
> > I don't think it's correct. You can just walk arbitrary structures and
> > obtain a normal PTR_TO_BTF_ID that looks seemingly ok to the verifier
> > but has no lifetime guarantees. It's a separate pre-existing problem
> > unrelated to your series [0]. PTR_UNTRUSTED is not set for those cases
> > currently.
> >
> > So the argument to your bpf_task_acquire may already be freed by then.
> > This issue would be exacerbated in sleepable BPF programs, where RCU
> > read lock is not held, so some cases of pointer walking where it may
> > be safe no longer holds.
> >
> > I am planning to clean this up, but I'd still prefer if we don't allow
> > this helper in sleepable programs, yet. kptr_get is ok to allow.
> > Once you have explicit BPF RCU read sections, sleepable programs can
> > take it, do loads, and operate on the RCU pointer safely until they
> > invalidate it with the outermost bpf_rcu_read_unlock. It's needed for
> > local kptrs as well, not just this. I plan to post this very soon, so
> > we should be able to fix it up in the current cycle after landing your
> > series.
> >
> > __rcu tags in the kernel will automatically be understood by the
> > verifier and for the majority of the correctly annotated cases this
> > will work fine and not break tracing programs.
> >
> > [0]: https://lore.kernel.org/bpf/CAADnVQJxe1QT5bvcsrZQCLeZ6kei6WEESP5bDXf_5qcB2Bb6_Q@mail.gmail.com
> >
> >> that.  Other kfuncs I saw such as bpf_xdp_ct_lookup() assumed that the
> >> parameter passed by the BPF program (which itself was passing on a
> >> pointer given to it by the main kernel) is valid as well.
> >
> > Yeah, but the CT API doesn't assume validity of random PTR_TO_BTF_ID,
> > it requires KF_TRUSTED_ARGS which forces them to have ref_obj_id != 0.
>
> Other than ref_obj_id != 0, could the PTR_TO_BTF_ID obtained through
> btf_ctx_access be marked as trusted (e.g. the ctx[0] in the selftest here)
> and bpf_task_acquire() will require KF_TRUSTED_ARGS? would it be safe in general?
>

Recently eed807f62610 ("bpf: Tweak definition of KF_TRUSTED_ARGS")
relaxed things a bit, now that constraint is only for PTR_TO_BTF_ID
and it allows other types without ref_obj_id > 0.

But you're right, ctx loads should usually be trusted, this is the
current plan (also elaborated a bit in that link [0]), usually that is
true, an exception is free path as you noted in your reply for patch 1
(and especially fexit path where object may not even be alive
anymore). There are some details to work out, but eventually I'd want
to force KF_TRUSTED_ARGS by default for all kfuncs, and we only make
exceptions in some special cases by having some KF_UNSAFE flag or
__unsafe tag for arguments. It's becoming harder to think about all
permutations if we're too permissive by default in terms of acceptable
arguments.
