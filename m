Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ADC61E66C
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 22:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKFVU0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 16:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFVUX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 16:20:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFCC1182A
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 13:20:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i21so14773643edj.10
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 13:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oK5igal3q6ayeZfSf7symOA5kf21Ap76cUtu3OT6iJM=;
        b=VNWJsUvJkZGo1bGouelVFDvxlrNmd3ctchL1nHD1fnWW31ffHEE6DiP9fzXgOyxXq3
         YGxwiG5FNT15TL7SkRLlDIjh0H/WipPp73gJ6nKoFBMmoxTtpPqp0LCDKvJG9NYGk6S4
         /cu2kdP38Hm3SYS1jgbzup3VqEmNuKzQeWx6QwCuCiTCNZLX3hOquro7aHrS7aILPkCr
         fWOcQ1LoQGVME3ChJAFXu0m1x31R41TV6bUYwcbfeekLqAdg17zsyXWZ8DVvUsJCi+/y
         xqPpkTwSwsLSlm3/cQs0IQwpl+79ZYb1TOJmB8ctzOxU46hdcGoGhNg9tNwbEJeCXkcS
         IVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oK5igal3q6ayeZfSf7symOA5kf21Ap76cUtu3OT6iJM=;
        b=m/cYVmwz6S3QwxP81rs+rytiCtso6JJoqTNPffiSpQyjIwH5wZiBdRn1s2H9TchyXm
         5Qfy45owG2au5S9/3AMW4WP4Drd7SlOsmOWotGBZbV9Pi4H4qBqp/ngfi+ir9n8Ue7ih
         SUThT6bJSJ71UxccZ/jUIR9vPksEYqijMvvqugYyovPlUwVvEHXP2l4Fo+4aqNbSeh+S
         INgB4Svo848iKRQUtw/7SmiRN1uLbRlYbsFeRf5JUnKAntWOiIaCzfi4ZhK83Zl7Mv45
         mwKvZy6TbIqA5fEhbldBfe3UZUlDicWKyai3bxh2Ssk2XBuJ7fkhkPLVVk8m1U8EBaR9
         ZXgA==
X-Gm-Message-State: ACrzQf3UO+yQ7rA92bp6o6adwPj+QIdK6uHIaUeB0zLUlZ/T6Wg0Y6tX
        l0GrCyyhLjO+n6LFwwUfhrfFvTqpi+NHlGJDtMs=
X-Google-Smtp-Source: AMsMyM5gHR858R6ASOYIODJC0qNkBx/WwU0frJySrPVZjMXEwG+5nJiZrJo0cUJ57TqbUPqt9MjVsvvK+/q6iK1mpAY=
X-Received: by 2002:a05:6402:2791:b0:461:c5b4:d114 with SMTP id
 b17-20020a056402279100b00461c5b4d114mr46306049ede.357.1667769620458; Sun, 06
 Nov 2022 13:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20221106015152.2556188-1-memxor@gmail.com> <20221106015152.2556188-2-memxor@gmail.com>
In-Reply-To: <20221106015152.2556188-2-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 6 Nov 2022 13:20:08 -0800
Message-ID: <CAADnVQ+iuB6abH0=N0su6DGAW1FnOtgUQ+Zq6x9bH1w5X_6P=w@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 1/2] bpf: Fix deadlock for bpf_timer's spinlock
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Sat, Nov 5, 2022 at 6:52 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Currently, unlike other tracing program types, BPF_PROG_TYPE_TRACING is
> excluded is_tracing_prog_type checks. This means that they can use maps
> containing bpf_spin_lock, bpf_timer, etc. without verification failure.
>
> However, allowing fentry/fexit programs to use maps that have such
> bpf_timer in the map value can lead to deadlock.
>
> Suppose that an fentry program is attached to bpf_prog_put, and a TC
> program executes and does bpf_map_update_elem on an array map that both
> progs share. If the fentry programs calls bpf_map_update_elem for the
> same key, it will lead to acquiring of the same lock from within the
> critical section protecting the timer.
>
> The call chain is:
>
> bpf_prog_test_run_opts() // TC
>   bpf_prog_TC
>     bpf_map_update_elem(array_map, key=0)
>       bpf_obj_free_fields
>         bpf_timer_cancel_and_free
>           __bpf_spin_lock_irqsave
>             drop_prog_refcnt
>               bpf_prog_put
>                 bpf_prog_FENTRY // FENTRY
>                   bpf_map_update_elem(array_map, key=0)
>                     bpf_obj_free_fields
>                       bpf_timer_cancel_and_free
>                         __bpf_spin_lock_irqsave // DEADLOCK
>
> BPF_TRACE_ITER attach type can be excluded because it always executes in
> process context.
>
> Update selftests using bpf_timer in fentry to TC as they will be broken
> by this change.

which is an obvious red flag and the reason why we cannot do
this change.
This specific issue could be addressed with addition of
notrace in drop_prog_refcnt, bpf_prog_put, __bpf_prog_put.
Other calls from __bpf_prog_put can stay as-is,
since they won't be called in this convoluted case.
I frankly don't get why you're spending time digging such
odd corner cases that no one can hit in real use.
There are probably other equally weird corner cases and sooner
or later will just declare them as 'wont-fix'. Not kidding.
Please channel your energy to something that helps.
Positive patches are more pleasant to review.
