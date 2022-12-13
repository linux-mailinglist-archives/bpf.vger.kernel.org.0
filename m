Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8194C64BF21
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 23:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiLMWJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 17:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiLMWJi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 17:09:38 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DEC19292
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:09:36 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gh17so40177596ejb.6
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DaMg1DiIRH6f59mkp3t8CX1Dd9cPi5W9j45NZIHeSRM=;
        b=Hr+pgD4T+XXGS4ra2tk9vEdeMcyxEmtH+5j4Kk+G5+6lEYodegu4I8XxUPeFBtTd7K
         kfRakqJ5jWH9mnUoI0KcdtJ9SCFmdxhZwWFljuYYG+eRXbM73fnz9fO/Z74EU1JAh6JK
         jwGx0YDsl/E8mfoV6D7pn9x7mAtR8MWklqfjOJ9zo/f20UNMBcy6eOeTH4IAzvqHpA0m
         6kTlQXr82K96ObFghYWvIXtJBj8lmx81P036YhClcDTMtwn4BbuG1meY2RC/LdRucmxK
         FiNCJfXPj3ie/T6F/cAy1e+PtoiM3WYme924MKTFcRDYjdaVH7RojXhc1VBA9lW3ryT2
         J4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaMg1DiIRH6f59mkp3t8CX1Dd9cPi5W9j45NZIHeSRM=;
        b=19fMwa7io7vxRvo8NxCFXJiJr4Wr4wDjZ90D8MBkhfUT0v5iABXbZmFQNrBLd6VPtE
         qfzQtfeB+0TvXlwS4G+JvfCkvj+Cy8UHEmOWT+8GfLws0k/jklA02JFh9lvWptrQJWRO
         zsviKfvcjjszPBHizIaDcF0w9pkSuA/EUwL5aWsYT2XUr55lfKmDv4S+ApjehyrenXTZ
         98cUICDvdYtpYjbWc+se85jX/yYTEhj1FeaDpNCSo19tG7dN4NrpuZrhI7qPHIp2vYNJ
         nOK1gLkHEbOB1aJVn6UOhksvZVOKUnZEc22HUQpjQ3Utaz552mzCaZbofqdZud6AXVRD
         4idQ==
X-Gm-Message-State: ANoB5pnERZ9E4QkizQz++kg3IceG5UYf/q06n81iOVovuiKICvRo54vs
        mSjB4/vf4qffga1KBMgY8KsTp6SIDo59wE+oga8=
X-Google-Smtp-Source: AA0mqf5NJrt/fahi0e+G6LKGkR/gsNLbI/z6PUpHlXtMvlEYquaz7FSfsaoKYIyD5pd4nljhheOSBrJCiY/8Pia9cX8=
X-Received: by 2002:a17:906:6403:b0:7b2:9667:241e with SMTP id
 d3-20020a170906640300b007b29667241emr81962865ejm.115.1670969374868; Tue, 13
 Dec 2022 14:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20221212091136.969960-1-hengqi.chen@gmail.com> <CAEf4BzaxYmBxYx=rfAyOn0kBHf3qOt6mPCPsyfrM+3rYcQ8MMQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaxYmBxYx=rfAyOn0kBHf3qOt6mPCPsyfrM+3rYcQ8MMQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Dec 2022 14:09:22 -0800
Message-ID: <CAEf4BzbX-DCvjvJsHgZC+TbLnru5R-0Oy3GfVkw7rjdtSR8e8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, yangtiezhu@loongson.cn
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

On Mon, Dec 12, 2022 at 4:17 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 12, 2022 at 1:11 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >
> > Add PT_REGS macros for LoongArch64.
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index 2972dc25ff72..2d7da1caa961 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -32,6 +32,9 @@
> >  #elif defined(__TARGET_ARCH_arc)
> >         #define bpf_target_arc
> >         #define bpf_target_defined
> > +#elif defined(__TARGET_ARCH_loongarch)
> > +       #define bpf_target_loongarch
> > +       #define bpf_target_defined
> >  #else
> >
> >  /* Fall back to what the compiler says */
> > @@ -62,6 +65,9 @@
> >  #elif defined(__arc__)
> >         #define bpf_target_arc
> >         #define bpf_target_defined
> > +#elif defined(__loongarch__) && __loongarch_grlen == 64
> > +       #define bpf_target_loongarch
> > +       #define bpf_target_defined
> >  #endif /* no compiler target */
> >
> >  #endif
> > @@ -258,6 +264,21 @@ struct pt_regs___arm64 {
> >  /* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
> >  #define PT_REGS_SYSCALL_REGS(ctx) ctx
> >
> > +#elif defined(bpf_target_loongarch)
> > +
> > +#define __PT_PARM1_REG regs[5]
> > +#define __PT_PARM2_REG regs[6]
> > +#define __PT_PARM3_REG regs[7]
> > +#define __PT_PARM4_REG regs[8]
> > +#define __PT_PARM5_REG regs[9]
> > +#define __PT_RET_REG regs[1]
> > +#define __PT_FP_REG regs[22]
> > +#define __PT_RC_REG regs[4]
> > +#define __PT_SP_REG regs[3]
> > +#define __PT_IP_REG csr_era
> > +/* loongarch does not select ARCH_HAS_SYSCALL_WRAPPER. */
> > +#define PT_REGS_SYSCALL_REGS(ctx) ctx
>
> Is there some online documentation explaining this architecture's
> calling conventions? It would be useful to include that as a comment
> to be able to refer back to it. On a related note, are there any
> syscall specific calling convention differences, similar to
> PT_REGS_PARM1_SYSCALL for arm64 or PT_REGS_PARM4_SYSCALL for x86-64?
>

Ok, I think [0] would be a good resource, please add a link to it in
the comment. But also it seems like PARM1-5 should map to regs[6]
through regs[10] (not regs[5] - regs[9] that you have here). And BTW,
seems like architecture supports passing more than five, PARM6 would
be regs[11]. I've been wanting to add 6th+ argument to libbpf macros'
for a while (it came up in x86-64 world for uprobes as well), so if
you have cycles, please consider helping with that as well.

Also I see orig_a0 in struct pt_regs, which seems suspiciously similar
to arm64's PT_REGS_PARM1_SYSCALL's use of orig_x0, please check about
that as well. As I said, syscalls usually have some additional quirks.


  [0] https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html


> > +
> >  #endif
> >
> >  #if defined(bpf_target_defined)
> > --
> > 2.31.1
