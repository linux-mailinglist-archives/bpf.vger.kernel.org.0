Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4154712E
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 03:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348917AbiFKBqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 21:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345147AbiFKBqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 21:46:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04EF443E0D
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 18:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45413B837C4
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 01:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00658C341C0
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 01:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654911980;
        bh=w30Kihj1wSWDstep9T3cTNL+OV7zjtcJgR9l8jz4kJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZqBpqYwT93jfDe1IiMMJc3fhRZIyJ/9kZ6XqOTKGVg5q6cBfe15jI+NAwZFsjgzQM
         bbwm2jIKy4jXzNtGjKMptnEdRq8NTnXfd0JKzZGzcQfyNFIQfgJwBVgmTg1j6rBbTg
         O5zdnhOv+AetD0hfpymc6BqBZmDBnXMv3nnrMYuDoO88V6o7+WucTudphMv8ryb1GV
         C/jddKwrLNoHt1zVMJc34kKwMxBjvXg2Gny9dfrgqsvuTcyxYCa04ANSsqkhpJx8LV
         3lYMzf2yu7w5GYUkJhKMuzW4oxaSGf74Pt/V4KWtgrgZQgKIIIB/pQocVFEqa1GJFa
         Qvx4a/6zRh5pw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3137eb64b67so7128327b3.12
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 18:46:19 -0700 (PDT)
X-Gm-Message-State: AOAM532LHrgAX6OkHDmkswgMUuxBs6xIKTThycCLn/s2vw8IXHvDBLY4
        PtQxzLKTBg2geMOc9Pxa7mGb4bTiZrh0PMfbVVY=
X-Google-Smtp-Source: ABdhPJw5hlHlLpdtbQr3YSm3f7k/sAAmwWTZazs5uwF6AD5RO5TRaU3Dyq2VZ4FTpMcv01/5BmOZoOws+QWTe+Rcspw=
X-Received: by 2002:a81:3904:0:b0:310:cc3:15a2 with SMTP id
 g4-20020a813904000000b003100cc315a2mr46724795ywa.447.1654911979034; Fri, 10
 Jun 2022 18:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-4-eddyz87@gmail.com>
 <CAPhsuW6RfokP8U6tDX+Qg+ufxpHfvgm_f=giE0nOUXONmV+iGA@mail.gmail.com>
 <23ad183ee89f016f7b5cbc1f08ff086b44d9fc0d.camel@gmail.com>
 <CAPhsuW7wPz+jwdT01BjLgpr0zPCkhc2gFzXBhph64FDvjh0oCQ@mail.gmail.com>
 <f712fb0e6e0d72542b047f174f8590888d025918.camel@gmail.com>
 <CAPhsuW4MMAFEOWn0ehvOZtt3h0w_Z6HaD0UJ2PH47PLHcExKwQ@mail.gmail.com> <c083c5cb2bc42eb455484cfd9ea803bd6a5e9d77.camel@gmail.com>
In-Reply-To: <c083c5cb2bc42eb455484cfd9ea803bd6a5e9d77.camel@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 18:46:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7GC2fLPCzt8OeSvikoCDR4TU6nFG9CL+ebCZf1urBQvg@mail.gmail.com>
Message-ID: <CAPhsuW7GC2fLPCzt8OeSvikoCDR4TU6nFG9CL+ebCZf1urBQvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 10, 2022 at 4:21 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> > On Fri, 2022-06-10 at 16:01 -0700, Song Liu wrote:
> >
> > In this case, we need to initialize fit_for_inline to true, no?
>
> You are right...
>
> My Last try is below, if you don't like it I'll proceed with your
> version.  I just really don't like the "not-cannot" part in the
> expression "!inline_state->cannot_inline" :)

Yeah, this version looks good to me.

Thanks,
Song

>
> static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
> {
>         struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
>         struct bpf_reg_state *regs = cur_regs(env);
>         struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
>         int flags_is_zero =
>                 register_is_const(flags_reg) && flags_reg->var_off.value == 0;
>
>         if (!state->initialized) {
>                 state->initialized = 1;
>                 state->fit_for_inline = flags_is_zero;
>                 state->callback_subprogno = subprogno;
>                 return;
>         }
>
>         if (!state->fit_for_inline)
>                 return;
>
>         state->fit_for_inline =
>                 flags_is_zero &&
>                 state->callback_subprogno == subprogno;
> }
>
> static int optimize_bpf_loop(struct bpf_verifier_env *env)
> {
>         // ...
>         if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) { ... }
>         // ...
> }
>
> Thanks,
> Eduard
>
