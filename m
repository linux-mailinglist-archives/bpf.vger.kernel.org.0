Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D187546FBE
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 00:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiFJWts (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 18:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiFJWts (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 18:49:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469F13D6E
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 15:49:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h23so600166ljl.3
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jT16PEmliFp9eTUOD0V8gocYnIgpzgvBEMAvU4L9B1o=;
        b=XCAlasstefYHvxtWE5k7j60tRhrzkdcUZrNub+o5GtfZoHozMgZdhXfWcsqShFhxcg
         ABEEDwAgUj7FKD9Ts59RAGDTwzAJVuyI/1nvaPNfjwUsJ46A/zIsIy2Vg8v14/1hzZCz
         f3WVlBuGwOm/O+M4sBUC92Qw1JUCU19H7lxrTGJiDvtVbco/w7J/vHrWYIKg8VxYwa92
         6gjYp1b7rD7Npl8IXeGDZkZwc7WFIyzAjCTjf9QyUKPit+Grt2AoEptY1jZOQMA8IP07
         iRe5TDdmmWE2Hz/8WGEULhfVaBC92k1mS0Hdey1z9O6/jEGB+RfM1fJhWPCu9bQzvK1G
         iFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jT16PEmliFp9eTUOD0V8gocYnIgpzgvBEMAvU4L9B1o=;
        b=OvzP64WEOsLUg++Oles9t+OoSVmwQu+tuAughqd05McauOeT1Nqz7nbouddtMzxsoq
         /AdleLfw06iNS8TOJ4o3lZqmr5I99lwcXS8cE9atn1CxeP5/QmbZMbBq7b7dSrz6Nkw9
         Z6HRIUfsQodFakwneOMvXZhEzMmI3qVE7/gafUEhEJcybMC4seQ/mLZGPmMf6WXJa280
         TGY5j1UFJOPhIM41ZGwrnJhAWM8tnZKdiZwnflOCpqscRGUuex7WM3Fk20fqphbIdD3r
         dhKDHGAl7OHO8Ug8+XJBYMGTs1mdcQ9m1w5xqQqnrS4tWA/eNbtyRb+7uFmnsjDSFlRj
         kbsA==
X-Gm-Message-State: AOAM533uzEIl2sgm2E1We04/3+cLXDvCRbyQinlLd0RgoTpsXjmvc0z1
        lRHZXLuisHwn5S4VURsNLECGbHFC663Eeg==
X-Google-Smtp-Source: ABdhPJz80aXCvIlFRhvJjNPFWOGBbqfVVmsGfXXs6J+tdRhXmobS7TyTbiQVGmEu4snduZsw/kxdQw==
X-Received: by 2002:a2e:8648:0:b0:255:8acd:1e8 with SMTP id i8-20020a2e8648000000b002558acd01e8mr17991410ljj.395.1654901385394;
        Fri, 10 Jun 2022 15:49:45 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id c23-20020a056512325700b00477a287438csm26300lfr.2.2022.06.10.15.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 15:49:44 -0700 (PDT)
Message-ID: <f712fb0e6e0d72542b047f174f8590888d025918.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Date:   Sat, 11 Jun 2022 01:49:43 +0300
In-Reply-To: <CAPhsuW7wPz+jwdT01BjLgpr0zPCkhc2gFzXBhph64FDvjh0oCQ@mail.gmail.com>
References: <20220608192630.3710333-1-eddyz87@gmail.com>
         <20220608192630.3710333-4-eddyz87@gmail.com>
         <CAPhsuW6RfokP8U6tDX+Qg+ufxpHfvgm_f=giE0nOUXONmV+iGA@mail.gmail.com>
         <23ad183ee89f016f7b5cbc1f08ff086b44d9fc0d.camel@gmail.com>
         <CAPhsuW7wPz+jwdT01BjLgpr0zPCkhc2gFzXBhph64FDvjh0oCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Fri, 2022-06-10 at 15:40 -0700, Song Liu wrote:
> Yes, I was thinking about this change. I guess it can also be clear:
> 
> static void update_loop_inline_state(struct bpf_verifier_env *env, u32
> subprogno)
> {
>         struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
>         struct bpf_reg_state *regs = cur_regs(env);
>         struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
>         int flags_is_zero;
> 
>         if (state->cannot_inline)
>                 return;
> 
>         flags_is_zero = register_is_const(flags_reg) &&
> flags_reg->var_off.value == 0;
> 
>         if (!state->initialized) {
>                 state->initialized = 1;
>                 state->cannot_inline = !flags_is_zero;
>                 state->callback_subprogno = subprogno;
>                 return;
>         }
> 
>         state->cannot_inline = !flags_is_zero ||
>                 state->callback_subprogno != subprogno;
> }
> 
> What do you think about this version?

Maybe keep `fit_for_inline` to minimize amount of negations?
As below:

static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
{
        struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
        struct bpf_reg_state *regs = cur_regs(env);
        struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
        int flags_is_zero;

/* this should be compiled as a single instruction anyway */
        if (!state->fit_for_inline)
                return;

        flags_is_zero = register_is_const(flags_reg) && flags_reg->var_off.value == 0;

        if (!state->initialized) {
                state->initialized = 1;
                state->fit_for_inline = flags_is_zero;
                state->callback_subprogno = subprogno;
                return;
        }

        state->fit_for_inline = flags_is_zero &&
                state->callback_subprogno == subprogno;
}

// ...

static int optimize_bpf_loop(struct bpf_verifier_env *env)
{
	if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) { ... }
// vs
	if (is_bpf_loop_call(insn) && !inline_state->cannot_inline) { ... }
}

Thanks,
Eduard

