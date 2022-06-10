Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EDC546FB0
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 00:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbiFJWlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 18:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbiFJWlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 18:41:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11765234299
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 15:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A02AA61DE9
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 22:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01205C3411B
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 22:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654900867;
        bh=LqsUJEqgt11ycioHOgucsXWjsd4ID62QbzR8vgoC8kI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G7dnv7LcN5+Qxm3WrjskPRcure5wpsTO5EygBI5usUFpDuIFpL4uvrSEPYmiOULZ1
         j4WopCs6/Bqg42mn19oVqbsjLmkNVyKsW5gZpZMxieVF/RMGtLcPBpmZmmd/8wp20D
         XHqtN1OL7ovJ08GaBZQ8p4+f4KRDjuaeljKI5QCu9w6Ol4WZ6lyWs0Rl2IWK780K1y
         Gkc1UkH8Khla8LwvIPyra0B44yk/ZZgvR908gZkS2KTr6YX8yIs/fbgnmOT6nwD+0F
         5ttbaxaMc0eog2EQE5qSZxI4Nr/dDXK5vW8ixH9zPdax8cfSDKnaWsw1w0gVaEdbEL
         tHxrfuMdgzeKg==
Received: by mail-yb1-f177.google.com with SMTP id u99so896000ybi.11
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 15:41:06 -0700 (PDT)
X-Gm-Message-State: AOAM531KfJI7dQ4i0zO9pqZC2vq00p/MjfxhpiF9UXialsKond0WO1+j
        1m3+SZ/frQezcVANMgpZln7AurUMhPugm57kv6I=
X-Google-Smtp-Source: ABdhPJxWYHavZufZQZlI0mj4GwFHgaiwD7pZuJQ360CVCAjCBBQByQXhYseV+rX6IqVcmcM0Eq2y+rGp6tHK7RY7Ca8=
X-Received: by 2002:a25:7e84:0:b0:650:10e0:87bd with SMTP id
 z126-20020a257e84000000b0065010e087bdmr46273639ybc.257.1654900866030; Fri, 10
 Jun 2022 15:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-4-eddyz87@gmail.com>
 <CAPhsuW6RfokP8U6tDX+Qg+ufxpHfvgm_f=giE0nOUXONmV+iGA@mail.gmail.com> <23ad183ee89f016f7b5cbc1f08ff086b44d9fc0d.camel@gmail.com>
In-Reply-To: <23ad183ee89f016f7b5cbc1f08ff086b44d9fc0d.camel@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 15:40:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7wPz+jwdT01BjLgpr0zPCkhc2gFzXBhph64FDvjh0oCQ@mail.gmail.com>
Message-ID: <CAPhsuW7wPz+jwdT01BjLgpr0zPCkhc2gFzXBhph64FDvjh0oCQ@mail.gmail.com>
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

On Fri, Jun 10, 2022 at 2:55 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> > On Fri, 2022-06-10 at 13:54 -0700, Song Liu wrote:
>
> > > +
> > > +void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
> >
> > static void ...
> >
> > > +{
> > > +       struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
> > > +       struct bpf_reg_state *regs = cur_regs(env);
> > > +       struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
> > > +
> >
> > nit: we usually don't have empty lines here.
> >
> > > +       int flags_is_zero =
> > > +               register_is_const(flags_reg) && flags_reg->var_off.value == 0;
> >
> > If we replace "fit_for_inline" with "not_fit_for_inline", we can make the cannot
> > inline case faster with:
> >
> >   if (state->not_fit_for_inline)
> >       return;
> >
> > > +
> > > +       if (state->initialized) {
> > > +               state->fit_for_inline &=
> > > +                       flags_is_zero &&
> > > +                       state->callback_subprogno == subprogno;
> > > +       } else {
> > > +               state->initialized = 1;
> > > +               state->fit_for_inline = flags_is_zero;
> > > +               state->callback_subprogno = subprogno;
> > > +       }
> > > +}
> > > +
>
> Sorry, I'm not sure that I understand you correctly. Do you want me to
> rewrite the code as follows:

Yes, I was thinking about this change. I guess it can also be clear:

static void update_loop_inline_state(struct bpf_verifier_env *env, u32
subprogno)
{
        struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
        struct bpf_reg_state *regs = cur_regs(env);
        struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
        int flags_is_zero;

        if (state->cannot_inline)
                return;

        flags_is_zero = register_is_const(flags_reg) &&
flags_reg->var_off.value == 0;

        if (!state->initialized) {
                state->initialized = 1;
                state->cannot_inline = !flags_is_zero;
                state->callback_subprogno = subprogno;
                return;
        }

        state->cannot_inline = !flags_is_zero ||
                state->callback_subprogno != subprogno;
}

What do you think about this version?

Thanks,
Song
