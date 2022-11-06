Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E155161E6A6
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 22:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKFVov (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 16:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKFVou (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 16:44:50 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CAB101E9
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 13:44:49 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so8712503pjk.1
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 13:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wD5+CBP3/1WrOwk8PnUpixdQgVoa4M8TS8t2CtprVk8=;
        b=B9kLQgJwT443imHLYGm0kyQzyCq0JqLTd23aCUh1/0tCuk6E2f1S1Ys009+bOY7LBD
         nmDQuq//MxQMKJkZfNouCrnVd/k1cqJfs7Pp7aMtfAIQZf3wQ8r/QLYB/NsbVVN0C0EZ
         ddSM9dz6mdLUffsSlc4PbtS/4jPz00bIu62sJyh/+acOhzwTmum2lfSB2B9qe6bju8OG
         4L87AGwTlCc6D5schOmO52aBcPEABc5R/s3DyA9QVIgMdzOh93e9mQX7/irtUuGTCvs+
         Wt7rHOsWfBTDSCUbDSH653yOi/ePaGH6pw2aFI6EvUZxiiB3pmjqeTzokpaHrSuMdVwN
         kWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wD5+CBP3/1WrOwk8PnUpixdQgVoa4M8TS8t2CtprVk8=;
        b=zGUtBtd2z3wEW0/INJ4x6tfLvHSfL67K15mTURr7jkVULrTnpMK4qVezNVVylU3PZw
         we/vkVMj8uDg2tROADnTvZBxTEkl6rfk+QiDqiAIjU0zHxYGcF/eBn2ZuQx1hJxqT6VD
         m+IJDAVbfbpkPFGNj1RxcpGA2yEMhxAZBMHL/AQ5OqHx6Ti9mzOV1Ap/UaZbSFYYWM6s
         hUdlNFyi3C1OTbi7xCS3uItlp+I63rKJy5otclXi7ycDagvC3jae6rsJYbDpJS/xlkP/
         4M1wUhoDLmchGNdx8a73N+HyNkJU+GJwS6tRupSwlmuFhdv3iV2n3KE04bSBP7dUoOuB
         dnAQ==
X-Gm-Message-State: ACrzQf379pPoFb7PAoHeQSTbEaqBFhgFeIkj3Bfx49/N0llOSb97KuMU
        CSZoE/4hIlEkYyAsMWzy17Q=
X-Google-Smtp-Source: AMsMyM6UT9DTLFVOW0doGlPV2l2rWHAxujBpLszABhPLsPL2w/ylkUxCQsE2ohElPng4F79p153cTA==
X-Received: by 2002:a17:902:ed85:b0:186:f151:de7d with SMTP id e5-20020a170902ed8500b00186f151de7dmr47328628plj.73.1667771089191;
        Sun, 06 Nov 2022 13:44:49 -0800 (PST)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id t7-20020a635f07000000b0046a1c832e9fsm2895188pgb.34.2022.11.06.13.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 13:44:48 -0800 (PST)
Date:   Mon, 7 Nov 2022 03:14:44 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH RFC bpf-next v1 1/2] bpf: Fix deadlock for bpf_timer's
 spinlock
Message-ID: <20221106214444.nbqh4qdpsoaj5t7s@apollo>
References: <20221106015152.2556188-1-memxor@gmail.com>
 <20221106015152.2556188-2-memxor@gmail.com>
 <CAADnVQ+iuB6abH0=N0su6DGAW1FnOtgUQ+Zq6x9bH1w5X_6P=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+iuB6abH0=N0su6DGAW1FnOtgUQ+Zq6x9bH1w5X_6P=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 07, 2022 at 02:50:08AM IST, Alexei Starovoitov wrote:
> On Sat, Nov 5, 2022 at 6:52 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Currently, unlike other tracing program types, BPF_PROG_TYPE_TRACING is
> > excluded is_tracing_prog_type checks. This means that they can use maps
> > containing bpf_spin_lock, bpf_timer, etc. without verification failure.
> >
> > However, allowing fentry/fexit programs to use maps that have such
> > bpf_timer in the map value can lead to deadlock.
> >
> > Suppose that an fentry program is attached to bpf_prog_put, and a TC
> > program executes and does bpf_map_update_elem on an array map that both
> > progs share. If the fentry programs calls bpf_map_update_elem for the
> > same key, it will lead to acquiring of the same lock from within the
> > critical section protecting the timer.
> >
> > The call chain is:
> >
> > bpf_prog_test_run_opts() // TC
> >   bpf_prog_TC
> >     bpf_map_update_elem(array_map, key=0)
> >       bpf_obj_free_fields
> >         bpf_timer_cancel_and_free
> >           __bpf_spin_lock_irqsave
> >             drop_prog_refcnt
> >               bpf_prog_put
> >                 bpf_prog_FENTRY // FENTRY
> >                   bpf_map_update_elem(array_map, key=0)
> >                     bpf_obj_free_fields
> >                       bpf_timer_cancel_and_free
> >                         __bpf_spin_lock_irqsave // DEADLOCK
> >
> > BPF_TRACE_ITER attach type can be excluded because it always executes in
> > process context.
> >
> > Update selftests using bpf_timer in fentry to TC as they will be broken
> > by this change.
>
> which is an obvious red flag and the reason why we cannot do
> this change.
> This specific issue could be addressed with addition of
> notrace in drop_prog_refcnt, bpf_prog_put, __bpf_prog_put.
> Other calls from __bpf_prog_put can stay as-is,
> since they won't be called in this convoluted case.
> I frankly don't get why you're spending time digging such
> odd corner cases that no one can hit in real use.

I was trying to figure out whether bpf_list_head_free would be safe to call all
the time in map updates from bpf_obj_free_fields, since it takes the very same
spin lock that BPF program can also take to update the list.

Map update ops are not allowed in the critical section, so this particular kind
of recurisve map update call should not be possible. perf event is already
prevented using is_tracing_prog_type, so NMI prog cannot interrupt and update
the same map.

But then I went looking whether it was a problem elsewhere...

FWIW I have updated my patch to do:

  if (btf_record_has_field(map->record, BPF_LIST_HEAD)) { ‣rec: map->record ‣type: BPF_LIST_HEAD
	if (is_tracing_prog_type(prog_type) || ‣type: prog_type
	    (prog_type == BPF_PROG_TYPE_TRACING &&
	     env->prog->expected_attach_type != BPF_TRACE_ITER)) {
		verbose(env, "tracing progs cannot use bpf_list_head yet\n"); ‣private_data: env ‣fmt: "tracing progs cannot use bp
		return -EINVAL;
	}
  }

v5 coming soon.

> There are probably other equally weird corner cases and sooner
> or later will just declare them as 'wont-fix'. Not kidding.

Understood.

> Please channel your energy to something that helps.
> Positive patches are more pleasant to review.

Understood.
