Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5A646134
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 19:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLGShC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 13:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiLGSgt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 13:36:49 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F59DF92
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 10:36:47 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gh17so16072289ejb.6
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 10:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OhsYKMwoyWu4uQOQmpJi0NwXTTsu5iLcwfxQiuDkCDM=;
        b=BKNzZZcfiH6OU7c+nK3yA7nKQ4d4uIa7SFQDYjh2hB9ZKmvWfPPwaG7HoToQ0AI+BR
         3mZ1O6dbNRt7UXcZNxqjc3gRtHdgRtCrdyXqk5O78h1FRU4+TdcI34CUrkP+u+GLftjd
         Xhl4FRB8Ay+dp/xcxrpl0U46VkhgjfK9uBikwtXs2hEU6LCBHrD6XHrLypnOc3+EqU6I
         Vdo2B+gJ5jHdCWlS94RAuu1wJ29j/7zErbPm174ZaHs/pFsoePGLet8dWRFxBOkN5tZP
         RQdeiSLHiRbGj9hI6BbGdvmwlA8yjXKVT4xGqOiuiHHfPwyZhz0VzN9BH/K8ysLV+w9o
         +IOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhsYKMwoyWu4uQOQmpJi0NwXTTsu5iLcwfxQiuDkCDM=;
        b=b71KEWw4xnwcn6WjOsefXrDOP/1lckZDmjOnnswSD6cKdt5mtV3tTbg4RgcHNDLYnH
         qzO59hIjRpRqVorruIb3i18EKUd7e7giDSvQGglaZ9PqhvEyVS4IA3rFjCB1IoPELF0a
         IiIyPZqvkMgjIVigrH1iDDwqKFaM7pRlNVDiqSgkh63cgMUXaDH3O/AoJZwg+nHhVjar
         6iOB/buetZuXkad6LfH3O+YXqXRCxj6WG6S5EaVElXUg2CvQkZH5hXQ3V/5e5RhFior1
         rk1KKX4ksZPysYzlrfkqILEvmsCNQw8IHKIFbMTT5O8d217ER/S8G4y1Ng5qlcsLLTpE
         CpJQ==
X-Gm-Message-State: ANoB5pkD27ARj9+oiA1s6t3axQto5uNOPHg+5f6uq0W1s8kN5/0Q3Bjq
        OWGDW4y3FkDK/8Ss2XRlth3MBlMbiijCWFf752o=
X-Google-Smtp-Source: AA0mqf6YHL8fVD0HM9V+uiWVLai8pVaU6oPQ5BVWxgpzcr8AadR7pCMkQmR7dSKU5Vb4APuEbJmdHwyqJyFOdQS+ObE=
X-Received: by 2002:a17:906:30c1:b0:7b7:eaa9:c1cb with SMTP id
 b1-20020a17090630c100b007b7eaa9c1cbmr6314798ejb.745.1670438206097; Wed, 07
 Dec 2022 10:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20221206233345.438540-1-andrii@kernel.org> <20221206233345.438540-4-andrii@kernel.org>
 <20221207031739.nvxsahedtr2ogv6j@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20221207031739.nvxsahedtr2ogv6j@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Dec 2022 10:36:34 -0800
Message-ID: <CAEf4BzY0rKAPgj7skj5fvOAjN-R1=255L3J=OeiNBz1mzvBSeQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/3] bpf: remove unnecessary prune and jump points
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Tue, Dec 6, 2022 at 7:17 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 06, 2022 at 03:33:45PM -0800, Andrii Nakryiko wrote:
> > Don't mark some instructions as jump points when there are actually no
> > jumps and instructions are just processed sequentially. Such case is
> > handled naturally by precision backtracking logic without the need to
> > update jump history. See get_prev_insn_idx(). It goes back linearly by
> > one instruction, unless current top of jmp_history is pointing to
> > current instruction. In such case we use `st->jmp_history[cnt - 1].prev_idx`
> > to find instruction from which we jumped to the current instruction
> > non-linearly.
> >
> > Also remove both jump and prune point marking for instruction right
> > after unconditional jumps, as program flow can get to the instruction
> > right after unconditional jump instruction only if there is a jump to
> > that instruction from somewhere else in the program. In such case we'll
> > mark such instruction as prune/jump point because it's a destination of
> > a jump.
> >
> > This change has no changes in terms of number of instructions or states
> > processes across Cilium and selftests programs.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 34 ++++++++++------------------------
> >  1 file changed, 10 insertions(+), 24 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b1feb8d3c42e..4f163a28ab59 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12228,13 +12228,12 @@ static int visit_func_call_insn(int t, int insn_cnt,
> >       if (ret)
> >               return ret;
> >
> > -     if (t + 1 < insn_cnt) {
> > -             mark_prune_point(env, t + 1);
> > -             mark_jmp_point(env, t + 1);
> > -     }
> > +     mark_prune_point(env, t + 1);
> > +     /* when we exit from subprog, we need to record non-linear history */
> > +     mark_jmp_point(env, t + 1);
> > +
>
> With this we probably should remove 'insn_cnt' from visit_func_call_insn().
> and in-turn from visit_insn() as well.
> Pls consider as a follow up.

Yep, will do, didn't notice it's not needed anymore.

BTW, no one asked why it was ok to drop the `if (t + 1 < insns_cnt)`
check, I was a bit surprised. But this is because push_insns() already
validates that t+1 is correct and doesn't go beyond the insns array,
so this was not needed in the first place.
