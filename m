Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B804F6939
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbiDFSTe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241494AbiDFSTT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 14:19:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9810781D;
        Wed,  6 Apr 2022 10:01:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bx5so3117507pjb.3;
        Wed, 06 Apr 2022 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tji3uryA80ryL0v5i/4cJLB5FmNIif56xmTcuZ+KJ1E=;
        b=VKGbuIMCQkgcPN2TDBgIhQ0kOQ5fkECxM375spzc9MjKK3AH4Ss+8I8/w0TwxzGZbr
         yjEIW1kMpL5UwR1ByOoQuTEmwmZ5ihewS3bXAPBrTmZkNtFo/Exj6Z4QOoPDVpOXqEa+
         X6FPILUSP6D3YB7DWDU7Jdw37z5u1JX1ojLmwZ30eY/6ono4+TJeSEqks+f77pJx0VNb
         P38COxMVPO4tGwAxAg43DcCXd9MVWqpad9quPgVZEwgn1qtOLFcsnQjMln6foAhj/yzm
         uiJHXRrTqlM5gty/vGc5IrBp7CctkWXdH8jJIGMgwp35/mg7Zn/xYnraYhXVa0RUc0rg
         fV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tji3uryA80ryL0v5i/4cJLB5FmNIif56xmTcuZ+KJ1E=;
        b=VR42+s8nWqdxOLTmFXzomEQuyirTtRfFL132GEXsRNHflgozZkblSlNRlZH+7Ggvg+
         0/KfFem5XGSzX+4qA3y9FGo9zHpKzAeiZDWc3n/W7DXyCakHpPmedrOkej07m0QzQpDR
         RIgviZjdva5CGrum1DVYVJaWdNNLBCaFPo7EiEjaiNnw5PQvfNDOkKVm3IVrF4oCV8jd
         kJ+r/GVNoBpet6sTVgtrmQu/k+hGfIu/udDWRAnmQLaZQRSWjBaK3NMHkfyP5v23YDLD
         BDKUJtD1zfi+vq67GHDsCslmMU61kk+hEuOSoImhubDkvPzYo7T9BCaqT94TSvFS04H0
         bslg==
X-Gm-Message-State: AOAM533c/jtMy6uoLjK8TiGdGDFgoI4RxW4ysIjt6IiBXx3ul67Y7OUq
        5Es7JOwP2EZZw3SaPxPHzdAQVFrhw+UUJvT5e1mngQul
X-Google-Smtp-Source: ABdhPJwnrYWN+wCHETrUl7CszfjDyZfqz3h5NA96wUGgNIvVDzoB+9XhRVEIkQ3LYGAY8vAr6aG3dWoV31bu/qaLbk0=
X-Received: by 2002:a17:903:32c5:b0:156:b466:c8ed with SMTP id
 i5-20020a17090332c500b00156b466c8edmr9561560plr.34.1649264510205; Wed, 06 Apr
 2022 10:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220405075531.GB30877@worktop.programming.kicks-ass.net>
 <CAADnVQJ1_9sBqRngG_J+84whx9j7d7qOSzMaJvhc0evDBQfE3w@mail.gmail.com> <20220406104643.GB2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220406104643.GB2731@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 Apr 2022 10:01:39 -0700
Message-ID: <CAADnVQLnHYQDM650v7JBw4TkmWOR5FMyEbTw31ySEyccM8QDCg@mail.gmail.com>
Subject: Re: [PATCH] x86,bpf: Avoid IBT objtool warning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Apr 6, 2022 at 3:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 05, 2022 at 09:58:28AM -0700, Alexei Starovoitov wrote:
> > On Tue, Apr 5, 2022 at 12:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > >
> > > Clang can inline emit_indirect_jump() and then folds constants, which
> > > results in:
> > >
> > >   | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x6a4: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
> > >   | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x67d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
> > >   | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x386: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20
> > >   | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x35d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20
> > >
> > > Suppress the optimization such that it must emit a code reference to
> > > the __x86_indirect_thunk_array[] base.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -412,6 +412,7 @@ static void emit_indirect_jump(u8 **ppro
> > >                 EMIT_LFENCE();
> > >                 EMIT2(0xFF, 0xE0 + reg);
> > >         } else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> > > +               OPTIMIZER_HIDE_VAR(reg);
> > >                 emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
> > >         } else
> > >  #endif
> >
> > Looks good. Please cc bpf@vger and all bpf maintainers in the future.
>
> Oh right, I'll go add an alias for that.
>
> > We can take it through the bpf tree if you prefer.
>
> I'll take it through the x86/urgent tree if you don't mind.

Sure. Then pls add:
Acked-by: Alexei Starovoitov <ast@kernel.org>
