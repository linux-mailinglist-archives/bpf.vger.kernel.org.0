Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9228561E86A
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 02:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiKGBs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 20:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGBs6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 20:48:58 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EFDD2E5
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 17:48:57 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v17so9815299plo.1
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 17:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+556Pw/utBrUGVFQVyN/6fa22oMBnD9AcpTznLjS4o=;
        b=XB7c6RVdM+71Zi/nu75qfByjk3SAUygLGgedbq7E8tAgKXgXGVn3FlM61HovHZ4fdz
         JgzbaGyvRo3PS6EERwAKbW7STJrbF64j+KrkiYOxRdk71pvXeMZ7BHzRISi8UDos/Mom
         2pEfe6+nCLSjVmOG7DPmJdNURpoi1rDIAgU+iFiS6TlpkAePmxK08r/zLpawuxcSGBLU
         4Ba/AtXmL/1gvC2EtfGclkEhbPgo5hdFFzdmF239Kxvg17h/IiYV8JTBF0HI+Nh0JWBZ
         gXpG50mi9LwrAOXrEEqACxwX5foZQv0QSf7YaKjQNvpktM3RIbJ+G9d/NosDv+Hc4l27
         VThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+556Pw/utBrUGVFQVyN/6fa22oMBnD9AcpTznLjS4o=;
        b=bKc+k1x4jT9VNUtRxaHoaZkRkzZt3VREQvwKmZc1y85hx8js9MRRjKFw6Vn0nyFPfu
         wsILy6on76H5lyJFN+lwm59eQG7GloOXz3b7OJAYahgXrbRJybttrQQzd9z8J4jIe6Wk
         jGfJXO8ojwPXNR+xKeJ8onNd9NK509yhKDYB1zf3DbBzQrx4+6VCoZO+/9t1J2Lyc9eD
         ZVKEH5pntSajyfNnDTw2NH9krfz1AEei3/vCFUtn3gx4mM7ZMU5esMcurP0wsdhCluUo
         cxi1bMNMxeYFDTrUKVyijPQp3QVhfUWSQb8ArF7DU95MiuSLRzL9v9+SWnFeJLdEATxi
         EuJQ==
X-Gm-Message-State: ACrzQf1OljlcMiVp1wDIAL2ZlouTwZrAIBpAEgTT93Nq97SN/VIRT18B
        eDEqf0V4zbjVjjtBOanBCQg=
X-Google-Smtp-Source: AMsMyM64v3Vy1/SvdisC6OvwxVrZGErfBN26WU6kO5HiyrmqRL1gt1e44HSckerqWr6HVegDJSnnaQ==
X-Received: by 2002:a17:90a:6742:b0:20a:f735:ab with SMTP id c2-20020a17090a674200b0020af73500abmr689100pjm.100.1667785736356;
        Sun, 06 Nov 2022 17:48:56 -0800 (PST)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id p18-20020a63f452000000b0047079cb8875sm511391pgk.42.2022.11.06.17.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 17:48:56 -0800 (PST)
Date:   Mon, 7 Nov 2022 07:18:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH RFC bpf-next v1 1/2] bpf: Fix deadlock for bpf_timer's
 spinlock
Message-ID: <20221107014851.fofi3xxqlludjgez@apollo>
References: <20221106015152.2556188-1-memxor@gmail.com>
 <20221106015152.2556188-2-memxor@gmail.com>
 <CAADnVQ+iuB6abH0=N0su6DGAW1FnOtgUQ+Zq6x9bH1w5X_6P=w@mail.gmail.com>
 <20221106214444.nbqh4qdpsoaj5t7s@apollo>
 <CAADnVQLiPdCZSiGsy7rUWttpM+iuXp+2BJoaHqR_ajc4K-xuWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLiPdCZSiGsy7rUWttpM+iuXp+2BJoaHqR_ajc4K-xuWw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 07, 2022 at 06:01:44AM IST, Alexei Starovoitov wrote:
> On Sun, Nov 6, 2022 at 1:44 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Mon, Nov 07, 2022 at 02:50:08AM IST, Alexei Starovoitov wrote:
> > > On Sat, Nov 5, 2022 at 6:52 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > >
> > > > Currently, unlike other tracing program types, BPF_PROG_TYPE_TRACING is
> > > > excluded is_tracing_prog_type checks. This means that they can use maps
> > > > containing bpf_spin_lock, bpf_timer, etc. without verification failure.
> > > >
> > > > However, allowing fentry/fexit programs to use maps that have such
> > > > bpf_timer in the map value can lead to deadlock.
> > > >
> > > > Suppose that an fentry program is attached to bpf_prog_put, and a TC
> > > > program executes and does bpf_map_update_elem on an array map that both
> > > > progs share. If the fentry programs calls bpf_map_update_elem for the
> > > > same key, it will lead to acquiring of the same lock from within the
> > > > critical section protecting the timer.
> > > >
> > > > The call chain is:
> > > >
> > > > bpf_prog_test_run_opts() // TC
> > > >   bpf_prog_TC
> > > >     bpf_map_update_elem(array_map, key=0)
> > > >       bpf_obj_free_fields
> > > >         bpf_timer_cancel_and_free
> > > >           __bpf_spin_lock_irqsave
> > > >             drop_prog_refcnt
> > > >               bpf_prog_put
> > > >                 bpf_prog_FENTRY // FENTRY
> > > >                   bpf_map_update_elem(array_map, key=0)
> > > >                     bpf_obj_free_fields
> > > >                       bpf_timer_cancel_and_free
> > > >                         __bpf_spin_lock_irqsave // DEADLOCK
> > > >
> > > > BPF_TRACE_ITER attach type can be excluded because it always executes in
> > > > process context.
> > > >
> > > > Update selftests using bpf_timer in fentry to TC as they will be broken
> > > > by this change.
> > >
> > > which is an obvious red flag and the reason why we cannot do
> > > this change.
> > > This specific issue could be addressed with addition of
> > > notrace in drop_prog_refcnt, bpf_prog_put, __bpf_prog_put.
> > > Other calls from __bpf_prog_put can stay as-is,
> > > since they won't be called in this convoluted case.
> > > I frankly don't get why you're spending time digging such
> > > odd corner cases that no one can hit in real use.
> >
> > I was trying to figure out whether bpf_list_head_free would be safe to call all
> > the time in map updates from bpf_obj_free_fields, since it takes the very same
> > spin lock that BPF program can also take to update the list.
> >
> > Map update ops are not allowed in the critical section, so this particular kind
> > of recurisve map update call should not be possible. perf event is already
> > prevented using is_tracing_prog_type, so NMI prog cannot interrupt and update
> > the same map.
> >
> > But then I went looking whether it was a problem elsewhere...
> >
> > FWIW I have updated my patch to do:
> >
> >   if (btf_record_has_field(map->record, BPF_LIST_HEAD)) { ‣rec: map->record ‣type: BPF_LIST_HEAD
> >         if (is_tracing_prog_type(prog_type) || ‣type: prog_type
> >             (prog_type == BPF_PROG_TYPE_TRACING &&
> >              env->prog->expected_attach_type != BPF_TRACE_ITER)) {
> >                 verbose(env, "tracing progs cannot use bpf_list_head yet\n"); ‣private_data: env ‣fmt: "tracing progs cannot use bp
> >                 return -EINVAL;
> >         }
> >   }
>
> That is a severe limitation.
> Why cannot you use notrace approach?

Yes, notrace is indeed an option, but the problem is that everything within that
critical section needs to be notrace. bpf_list_head_free also ends up calling
bpf_obj_free_fields again (the level of recursion however won't exceed 3, since
we clamp list_head -> list_head till 2 levels).

So the notrace needs to be applied to everything within it, which is not a
problem now. It can be done. BPF_TIMER and BPF_KPTR_REF (the indirect call to
dtor) won't be triggered, so it probably just needs to be bpf_list_head_free
and bpf_obj_free_fields.

But it can break silently in the future, if e.g. kptr is allowed. Same for
drop_prog_refcnt if something changes. Every change to anything they call (and
called by functions they call) needs to keep the restriction in mind.

I was wondering if in both cases of bpf_timer and bpf_list_head, we can simply
swap out the object locally while holding the lock, and then do everything
outside the spin lock.

For bpf_timer, it would mean moving drop_prog_refcnt outside spin lock critical
section. hrtimer_cancel is already done after the unlock. For bpf_list_head, it
would mean swapping out the list_head and then draining it outside the lock.

Then we hopefully don't need to use notrace, and it wouldn't be possible for any
tracing prog to execute while we hold the bpf_spin_lock (unless I missed
something).
