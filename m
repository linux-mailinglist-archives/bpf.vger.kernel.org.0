Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D791546FCA
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiFJXCM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 19:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345687AbiFJXCL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 19:02:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D226E1CC5D6
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 16:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A810B83776
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 23:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCF5C3411B
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 23:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654902128;
        bh=Kc+qynKga4wSvM09YqGgP77D7fxkIS7Nj0Ip16/Y6K8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nxLqPYaYnGi8vNqowDbpUR/8CInZHUuZ98196JeJBGXs7mBxm88yNbjyvmnDYPV5L
         nrN9r3+eRH5II6O1bEKhjgG5mqsNRCkiK8uHz+cB4toqOt1m7ExD5VVHoTFVM5rpfW
         YGDieJbIJsaBy/vQkMb+p4VObiCtCygvCknosnKQ5uwDLkwPpOqZpNwDcB3ovRqERw
         2g67xvvNWIcik9p4yhQk0Tj773PSV2TA3ITk0OHksT/wcbCkYe3qGdzOvUJiXlgltW
         N4sz9Jkn1jO4dGb4NLes9kOQbj4pQ24J1CMdOpuFIi8SXUHRxnwuEWYAhSxw9Mo2qu
         klcFaQC6oJl2w==
Received: by mail-yb1-f170.google.com with SMTP id k2so1010609ybj.3
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 16:02:07 -0700 (PDT)
X-Gm-Message-State: AOAM533DNbHA1rW5Wj5PMClER3u9IcNQw8e5D0j3m9ovzjudGRIBWqA2
        ULUA4G8D1Jfq7cy+zksqiWJJmcA6YAVnD57oyqA=
X-Google-Smtp-Source: ABdhPJw4rty4qBc5t9FsnWXSXV53S082HnFzymxmFwa+WKv5Q3ItyoHFNW7Lo+vZN6Rujv1gs0A95jOwDvgT//64aEg=
X-Received: by 2002:a05:6902:114c:b0:641:87a7:da90 with SMTP id
 p12-20020a056902114c00b0064187a7da90mr48934032ybu.561.1654902126351; Fri, 10
 Jun 2022 16:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-4-eddyz87@gmail.com>
 <CAPhsuW6RfokP8U6tDX+Qg+ufxpHfvgm_f=giE0nOUXONmV+iGA@mail.gmail.com>
 <23ad183ee89f016f7b5cbc1f08ff086b44d9fc0d.camel@gmail.com>
 <CAPhsuW7wPz+jwdT01BjLgpr0zPCkhc2gFzXBhph64FDvjh0oCQ@mail.gmail.com> <f712fb0e6e0d72542b047f174f8590888d025918.camel@gmail.com>
In-Reply-To: <f712fb0e6e0d72542b047f174f8590888d025918.camel@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 16:01:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4MMAFEOWn0ehvOZtt3h0w_Z6HaD0UJ2PH47PLHcExKwQ@mail.gmail.com>
Message-ID: <CAPhsuW4MMAFEOWn0ehvOZtt3h0w_Z6HaD0UJ2PH47PLHcExKwQ@mail.gmail.com>
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

On Fri, Jun 10, 2022 at 3:49 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
[...]
> >
> >         state->cannot_inline = !flags_is_zero ||
> >                 state->callback_subprogno != subprogno;
> > }
> >
> > What do you think about this version?
>
> Maybe keep `fit_for_inline` to minimize amount of negations?
> As below:
>
> static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
> {
>         struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
>         struct bpf_reg_state *regs = cur_regs(env);
>         struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
>         int flags_is_zero;
>
> /* this should be compiled as a single instruction anyway */
>         if (!state->fit_for_inline)
>                 return;

In this case, we need to initialize fit_for_inline to true, no?

Thanks,
Song

>
>         flags_is_zero = register_is_const(flags_reg) && flags_reg->var_off.value == 0;
>
>         if (!state->initialized) {
>                 state->initialized = 1;
>                 state->fit_for_inline = flags_is_zero;
>                 state->callback_subprogno = subprogno;
>                 return;
>         }
>
>         state->fit_for_inline = flags_is_zero &&
>                 state->callback_subprogno == subprogno;
> }
>
> // ...
>
> static int optimize_bpf_loop(struct bpf_verifier_env *env)
> {
>         if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) { ... }
> // vs
>         if (is_bpf_loop_call(insn) && !inline_state->cannot_inline) { ... }
> }
>
> Thanks,
> Eduard
>
