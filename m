Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425BE59EBE3
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 21:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiHWTLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 15:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiHWTLc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 15:11:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4285481B31
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 10:49:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q9so3852090pgq.6
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7Mlbcp4rl6aWBLgrqM/v+bRZ3+7xqxzN/IXLXiGuKiY=;
        b=Szl1wt3t4V8qjRpuZOjd81h6BHvx3L3Hvo4rZN6kKfteG9t7QuYb64kuGQC/+w09DI
         G58jCiDVJ4H2L2DmGorSDbBRwkt/4rYCxEhPh7uvcWmdyAoJxWQbDEWzCk70ab0wcL5w
         p1qcd22YX6UvlMmzabqxYNNodKGadyTTGz5unWcOZ6WVQLLbuh60eCOj3DH7OqEK6Z3w
         B8190eTcSmODYVLA1O49FzpFrqVd0ApE//4I5fZZwoeYJCtavaZk41k8MKx6tZW4knHw
         QYAN0IEXKgNjgP1wkertaHkjJvzHnEZzHrLXgSqCHQFrpnz7C5sFiCkQJgS1FF40675t
         +NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7Mlbcp4rl6aWBLgrqM/v+bRZ3+7xqxzN/IXLXiGuKiY=;
        b=MAVoyv4t4HjuxkZdVmxuK21LU5AhTVbL/skRMmxql/4gS1BdzCP+nasAcgdnl3YtdJ
         EOeeN++m3YJhQvuLBfpilDOQZXZmp86IurDj0k69Qfqu17XOPc06bxTee5WNPfc0qgPs
         tjHaPSu1vw/USoNMy0ZnrMfuxptB4hK4djGw2MgGEOzppIJGJPWjmoOU1yzYdxiHHkda
         bDavhlkGOC8faE8D6o1/JfkQ2K/cH4bFqP645NiReNHpvnOR0s+tEaEu6NuLoKcCniWU
         yRUdHkrRdfT2c5peayRY5Alo91c6LYe1TgMqtlXGNiT8067ctJEg0CgmW13F4usFurOm
         B9CA==
X-Gm-Message-State: ACgBeo2HuGrMwVtqfsG/774GXOj727+GScOPKrjaX6siZEz3rTY8LnHs
        Itbe+gdSkVlMQZn4NBl2FfO0U2dOOXUQyKLAre/XSJz6
X-Google-Smtp-Source: AA6agR70U8szdsKOkUXnB8w2IYs//np5qnaFBA9co+u74HIJaOpLdBDh9mmDwdoCiB0m8QlyYtkvQHNSzx/qDi9N1Bw=
X-Received: by 2002:a05:6e02:1c04:b0:2df:6b58:5fe8 with SMTP id
 l4-20020a056e021c0400b002df6b585fe8mr350183ilh.68.1661276175627; Tue, 23 Aug
 2022 10:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220822131923.21476-1-memxor@gmail.com> <20220822131923.21476-2-memxor@gmail.com>
 <630490024ded0_2ad4d7208e3@john.notmuch>
In-Reply-To: <630490024ded0_2ad4d7208e3@john.notmuch>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 23 Aug 2022 19:35:39 +0200
Message-ID: <CAP01T75DOMXk0Z6FoOT7n7tcb8f+hMQ-W1HC_VfGqe+hBh+Gcg@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/3] bpf: Move bpf_loop and bpf_for_each_map_elem
 under CAP_BPF
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Tue, 23 Aug 2022 at 10:29, John Fastabend <john.fastabend@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi wrote:
> > They would require func_info which needs prog BTF anyway. Loading BTF
> > and setting the prog btf_fd while loading the prog indirectly requires
> > CAP_BPF, so just to reduce confusion, move both these helpers taking
> > callback under bpf_capable() protection as well, since they cannot be
> > used without CAP_BPF.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> This should have a fixes tag IMO. You'll get unexpected results if we
> don't have get it backported to the right places.
>

Hm, I was unsure if this requires a Fixes tag. It's technically not a
fix, it's a minor reorg in my opinion (could have gone through
bpf-next as well) which has no real resulting change for users loading
programs, and makes things less confusing. The actual fix in patch 2
is independent of this change.

> >  kernel/bpf/helpers.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 1f961f9982d2..d0e80926bac5 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1633,10 +1633,6 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >               return &bpf_ringbuf_submit_dynptr_proto;
> >       case BPF_FUNC_ringbuf_discard_dynptr:
> >               return &bpf_ringbuf_discard_dynptr_proto;
> > -     case BPF_FUNC_for_each_map_elem:
> > -             return &bpf_for_each_map_elem_proto;
> > -     case BPF_FUNC_loop:
> > -             return &bpf_loop_proto;
> >       case BPF_FUNC_strncmp:
> >               return &bpf_strncmp_proto;
> >       case BPF_FUNC_dynptr_from_mem:
> > @@ -1675,6 +1671,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >               return &bpf_timer_cancel_proto;
> >       case BPF_FUNC_kptr_xchg:
> >               return &bpf_kptr_xchg_proto;
> > +     case BPF_FUNC_for_each_map_elem:
> > +             return &bpf_for_each_map_elem_proto;
> > +     case BPF_FUNC_loop:
> > +             return &bpf_loop_proto;
> >       default:
> >               break;
> >       }
> > --
> > 2.34.1
> >
>
>
