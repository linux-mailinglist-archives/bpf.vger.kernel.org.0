Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F025B2118
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiIHOqf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiIHOqU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 10:46:20 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918D11211C
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 07:46:13 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a9so9364491ilh.1
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UCDVL8OoRHBjgYS5chUmWKmwirkf1EFKeZCWYXi+vb0=;
        b=CnY7kFBR2AdQ1KPEs2Q9e2H00Jp70UCcY5QgCSqLdKSOkGHUBppoXuftFYt0XuvJw2
         cy1HD6wa4Qwkl9UIxGREdH/MfOjiCe+trH3Jsf8Lf2Zub2Wfqdr1AxYwaYNX9sVgVhXa
         watt78q39ZaUQyHdiSu0EWYlCHQB/YdoAtamZ7Rbn0cahVvbj56yC7ie44iFFjeYOMsl
         IdNhceTNfEPhJxfNlzeyprDVhxmiASzvY5cSUTzLPn/91llU5qVfSt8rvqOMh3S+ag1J
         6J2OHS60AENp3Cek8v60DNPGgWbo61T6kzHE5ztmhzsbuG6Qdlb2g94mae032/ijdNN6
         Ohhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UCDVL8OoRHBjgYS5chUmWKmwirkf1EFKeZCWYXi+vb0=;
        b=zI5i303lIZJ4dO4iXZFk8allog80kL+UM8VXGjLXXfTVdhqCl+lglFZ7NA5eyBhZeS
         c/WMqmhLNgZMhFEha1o5mqdQbxp7TPG2PNbZyjy+eaY1ZHLC1WAa0h4Fc3LB3mGbKi2R
         JPDh4+XvzLvDuHXDosQan79FiQKRjhKzAvv/2Q3avc1z1aQS2yhB2Sj3Cyc78BfWIzum
         tzYxhOJBO4kpiu8hCzeP+FtxS/OBFP77/QZNVoDAmM8CEKYkGP5zxPdw2BweGq8uQ5fm
         W7MiEZuqZYR9cyqM/bgBPXWJ16PvnkEF8cg+mBZZ/EjsY5QYZQbhZ6gAGW6IWO4uB8/h
         seaA==
X-Gm-Message-State: ACgBeo1xOUjoQwm2YgLo7izB1RDs2Tg7+F5++fqmRnejfC0waq6jTMyg
        I2OLU4Jv9dyTZ5PEKTrzQXD01KP8EPu4Ox3yeo0=
X-Google-Smtp-Source: AA6agR7wsq8+CrFdE4eHTTBw0uwICXE5Mskx3kcKB8Xtj1aLBd4M+zTY4i9++gra5VMJ/mvjIGv6Kzm9Fn1pDWPcPA8=
X-Received: by 2002:a05:6e02:1d0b:b0:2eb:73fc:2235 with SMTP id
 i11-20020a056e021d0b00b002eb73fc2235mr2038580ila.164.1662648371568; Thu, 08
 Sep 2022 07:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-17-memxor@gmail.com>
 <20220908003429.wsucvsdcxnkipcja@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T77-ygt+MvvwzRwo+3kDrk_8sCv-ASGT8qL2PvPjL_11jw@mail.gmail.com>
 <20220908033741.l6zhopfhnfrpi72y@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T76YqSKUMFCVz-WqQQL29SFFn4DG6wqwm0HVpN2-DqJuFA@mail.gmail.com> <CAADnVQ+hgprNMCSk0bjZnRveEzv=t8zoZXH44Gy8tVPJKoPt_A@mail.gmail.com>
In-Reply-To: <CAADnVQ+hgprNMCSk0bjZnRveEzv=t8zoZXH44Gy8tVPJKoPt_A@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 8 Sep 2022 16:45:33 +0200
Message-ID: <CAP01T74cHVp4SNfyS+XERU-51z+Sr2L=HMRKaQWRHn5ZKREpzg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 16/32] bpf: Introduce BPF memory object model
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 8 Sept 2022 at 16:18, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 8, 2022 at 4:50 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > I slept over this. I think I can get behind this idea of implicit
> > ctor/dtor. We might have open coded construction/destruction later if
> > we want.
> >
> > I am however thinking of naming these helpers:
> > bpf_kptr_new
> > bpf_kptr_delete
> > to make it clear it does a little more than just allocating the type.
> > The open coded cases can later derive their allocation from the more
> > bare bones bpf_kptr_alloc instead in the future.
>
> New names make complete sense. Good idea.
>
> > The main reason to have open coded-ness was being able to 'manage'
> > resources once visibility reduces to current CPU (bpf_refcount_put,
> > single ownership after xchg, etc.). Even with RCU, we won't allow
> > touching the BPF special fields without refcount. bpf_spin_lock is
> > different, as it protects more than just bpf special fields.
> >
> > But one can still splice or kptr_xchg before passing to bpf_kptr_free
> > to do that. bpf_kptr_free is basically cleaning up whatever is left by
> > then, forcefully. In the future, we might even be able to do elision
> > of implicit dtors based on the seen data flow (splicing in single
> > ownership implies list is empty, any other op will undo that, etc.) if
> > there are big structs with too many fields. Can also support that in
> > open coded cases.
>
> Right.
>
> >
> > What I want to think about more is whether we should still force
> > calling bpf_refcount_set vs always setting it to 1.
> >
> > I know we don't agree about whether list_add in shared mode should
> > take ref vs transfer ref. I'm leaning towards transfer since that will
> > be most intuitive. It then works the same way in both cases, single
> > ownership only transfers the sole reference you have, so you lose
> > access, but in shared you may have more than one. If you have just one
> > you will still lose access.
> >
> > It will be odd for list_add to consume it in one case and not the
> > other. People should already be fully conscious of how they are
> > managing the lifetime of their object.
> >
> > It then seems better to require users to set the initial refcount
> > themselves. When doing the initial linking it can be very cheap.
> > Later get/put/inc are always available.
> >
> > But forcing it to be called is going to be much simpler than this patch.
>
> I'm not convinced yet :)
> Pls hold on implementing one way or another.
> Let's land the single ownership case for locks, lists,
> rbtrees, allocators. That's plenty of patches.
> Then we can start a deeper discussion into the shared case.
> Whether it will be different in terms of 'lose access after list_add'
> is not critical to decide now. It can change in the future too.
>

Right, I'm not implementing it yet. There's a lot of work left to even
finish single ownership structures, then lots of testing.
But it's helpful to keep thinking about future use cases while working
on the current stuff, just to make sure we're not
digging ourselves into a design hole.

We have the option to undo damage here, since this is all
experimental, but there's still an expectation that the API is not
broken at whim. That wouldn't be very useful for users.

> The other reason to do implicit inits and ref count sets is to

I am not contesting implicit construction.
Other lists already work with zero initialization so list_head seems
more of an exception.
But it's done for good reasons to avoid extra NULL checks
unnecessarily, and make the implementation of list helpers more
efficient and simple at the same time.

> avoid fighting llvm.
> obj = bpf_kptr_new();
> obj->var1 = 1;
> some_func(&obj->var2);
> In many cases the compiler is allowed to sink stores.
> If there are two calls that "init" two different fields
> the compiler is allowed to change the order as well
> even if it doesn't see the body of the function and the function is
> marked as __pure. Technically initializers as pure functions.

But bpf_refcount_set won't be marked __pure, neither am I proposing to
allow direct stores to 'set' it.
I'm not a compiler expert by any means, but AFAIK it should not be
doing such reordering for functions otherwise.
What if the function inside has a memory barrier? That would
completely screw up things.
It's going to have external linkage, so I don't think it can assume
anything about side effects or not. So IMO this is not a good point.

Unless you're talking about some new way of inlining such helpers from
the compiler side that doesn't exist yet.

> The verifier and llvm already "fight" a lot.
> We gotta be very careful in the verifier and not assume
> that the code stays as written in C.

So will these implicit zero stores be done when we enter != NULL
branch, or lazily on first access (helper arg, load, store)?
This is the flip side: rewritings insns to add stores to local kptr
can only happen after the NULL check, in the != NULL branch, at that
point we cannot assume R1-R5 are free for use, so complicated field
initialization will be uglier to do implicitly (e.g. if it involves
calling functions etc.).
There are pros and cons for both.
