Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ECE588F37
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 17:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiHCPR3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiHCPR3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 11:17:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427265F52;
        Wed,  3 Aug 2022 08:17:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d20so9314654pfq.5;
        Wed, 03 Aug 2022 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=oNr9cYrhYYJ71xIwjeGTHZcy87EslxiZzIalDyvPVWc=;
        b=CwYeSEKCKvrVEdtvKHnBCKsNkdIOx9HcWLN6NVQXi85JWEkFg/5BAaVI8bQnVpAR9f
         DfnukQoWDW738z5+6eeKeN9/ZI77LCtLtq77MwfL9Cj2a5JGN/50Ie27Wr7XTmu1gqN2
         p2PB7DdQ/Mc5haRlWmeCS2yWS+c9roPuFKfUL1NI6SDCMu0Ur9RZ0S1oPb9+9TnBFoZs
         vPiehKD6dvc+HOl5aYw+mxrbxR466Rc9WFzL7w2KOlfUhistrUnM0IwppggXlTdFrIYG
         IHP/I9mtcFNUfAjGde1f3nSAl/UYbtEBhMHFCU8KNvdu3XtwMLutyrj2rYrmEtWqMdGR
         4chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=oNr9cYrhYYJ71xIwjeGTHZcy87EslxiZzIalDyvPVWc=;
        b=Ye6fBG+N4NWIwPJmOvwVBg0vKUX/JsLsN+RDyH4rm+0mHoreIuPi+VmKPPNKpK/E9J
         gPJv/pU4L+ARZaIvMRDy6yX1Po1K9zQ1umk2judSOeQ7M3ypK3xYMmmVReI9Nse5yKSL
         sNRl7tNtONkhHlq3cWRWuTOHTOlf4mQ1ZQ67tfdR4mA16j3KX0a5F6veF3WFPJEHI4KU
         +WTYFKw2n2hZ/NGTrlR9iDuaLjPsOLXJ/A21lB8bGZWBjT3wdnR1dWUEtnj2X9RKmDzq
         tnLQQBq4nBNY42ozFwFYqmo0rV1kPIHT4QH3L1rj0eDlI/qAWHCBv6w04TAKpvMHVbRt
         sAcg==
X-Gm-Message-State: AJIora/xOH4rRPomAS2aBe+WWk0zOPkDVO2lO2lmRdj0j8x4dCwjcVb5
        SPQrkQ45VwSdq5BJ93/HLGKwvPMcSEjB+JHply8=
X-Google-Smtp-Source: AGRyM1sDxF9LFw5yhJVEcTicuVVo87n4bzo3w7dEvTUf3KF6IhSgAcbtG0vVoZ9p148276XCHYdfpTsnuXqq2hRjnFc=
X-Received: by 2002:a05:6a00:2282:b0:52a:e79b:16e4 with SMTP id
 f2-20020a056a00228200b0052ae79b16e4mr26012746pfe.79.1659539847508; Wed, 03
 Aug 2022 08:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220802232741.481145-1-james.hilliard1@gmail.com> <Yuovl3ycDfflqV9h@krava>
In-Reply-To: <Yuovl3ycDfflqV9h@krava>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 3 Aug 2022 09:17:14 -0600
Message-ID: <CADvTj4omSZvx1EBAaMCBCqw=wYjEjX6aK57hhfvDA2Nc9P_yVA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: ensure functions with always_inline attribute are inline
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 3, 2022 at 2:19 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Aug 02, 2022 at 05:27:41PM -0600, James Hilliard wrote:
> > GCC expects the always_inline attribute to only be set on inline
> > functions, as such we should make all functions with this attribute
> > inline.
> >
> > Fixes errors like:
> > /home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/=
bpf_tracing.h:439:1: error: =E2=80=98always_inline=E2=80=99 function might =
not be inlinable [-Werror=3Dattributes]
> >   439 | ____##name(unsigned long long *ctx, ##args)
> >       | ^~~~
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 14 +++++++-------
> >  tools/lib/bpf/usdt.bpf.h    |  4 ++--
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index 43ca3aff2292..ae67fcee912c 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -426,7 +426,7 @@ struct pt_regs;
> >   */
> >  #define BPF_PROG(name, args...)                                       =
           \
> >  name(unsigned long long *ctx);                                        =
           \
> > -static __attribute__((always_inline)) typeof(name(0))                 =
           \
> > +static inline __attribute__((always_inline)) typeof(name(0))          =
   \
>
> could you use __always_inline that does exactly that?

Sure, changed to use the __always_inline macro in v2:
https://lore.kernel.org/bpf/20220803151403.793024-1-james.hilliard1@gmail.c=
om/

>
> jirka
>
> >  ____##name(unsigned long long *ctx, ##args);                          =
   \
> >  typeof(name(0)) name(unsigned long long *ctx)                         =
           \
> >  {                                                                     =
   \
> > @@ -435,7 +435,7 @@ typeof(name(0)) name(unsigned long long *ctx)      =
                           \
> >       return ____##name(___bpf_ctx_cast(args));                        =
   \
> >       _Pragma("GCC diagnostic pop")                                    =
   \
> >  }                                                                     =
   \
> > -static __attribute__((always_inline)) typeof(name(0))                 =
           \
> > +static inline __attribute__((always_inline)) typeof(name(0))          =
   \
> >  ____##name(unsigned long long *ctx, ##args)
> >
> >  struct pt_regs;
> > @@ -460,7 +460,7 @@ struct pt_regs;
> >   */
> >  #define BPF_KPROBE(name, args...)                                     =
   \
> >  name(struct pt_regs *ctx);                                            =
   \
> > -static __attribute__((always_inline)) typeof(name(0))                 =
           \
> > +static inline __attribute__((always_inline)) typeof(name(0))          =
   \
> >  ____##name(struct pt_regs *ctx, ##args);                              =
   \
> >  typeof(name(0)) name(struct pt_regs *ctx)                             =
   \
> >  {                                                                     =
   \
> > @@ -469,7 +469,7 @@ typeof(name(0)) name(struct pt_regs *ctx)          =
                   \
> >       return ____##name(___bpf_kprobe_args(args));                     =
   \
> >       _Pragma("GCC diagnostic pop")                                    =
   \
> >  }                                                                     =
   \
> > -static __attribute__((always_inline)) typeof(name(0))                 =
           \
> > +static inline __attribute__((always_inline)) typeof(name(0))          =
   \
> >  ____##name(struct pt_regs *ctx, ##args)
> >
> >  #define ___bpf_kretprobe_args0()       ctx
> > @@ -484,7 +484,7 @@ ____##name(struct pt_regs *ctx, ##args)
> >   */
> >  #define BPF_KRETPROBE(name, args...)                                  =
   \
> >  name(struct pt_regs *ctx);                                            =
   \
> > -static __attribute__((always_inline)) typeof(name(0))                 =
           \
> > +static inline __attribute__((always_inline)) typeof(name(0))          =
   \
> >  ____##name(struct pt_regs *ctx, ##args);                              =
   \
> >  typeof(name(0)) name(struct pt_regs *ctx)                             =
   \
> >  {                                                                     =
   \
> > @@ -540,7 +540,7 @@ static __always_inline typeof(name(0)) ____##name(s=
truct pt_regs *ctx, ##args)
> >  #define BPF_KSYSCALL(name, args...)                                   =
   \
> >  name(struct pt_regs *ctx);                                            =
   \
> >  extern _Bool LINUX_HAS_SYSCALL_WRAPPER __kconfig;                     =
   \
> > -static __attribute__((always_inline)) typeof(name(0))                 =
           \
> > +static inline __attribute__((always_inline)) typeof(name(0))          =
   \
> >  ____##name(struct pt_regs *ctx, ##args);                              =
   \
> >  typeof(name(0)) name(struct pt_regs *ctx)                             =
   \
> >  {                                                                     =
   \
> > @@ -555,7 +555,7 @@ typeof(name(0)) name(struct pt_regs *ctx)          =
                   \
> >               return ____##name(___bpf_syscall_args(args));            =
   \
> >       _Pragma("GCC diagnostic pop")                                    =
   \
> >  }                                                                     =
   \
> > -static __attribute__((always_inline)) typeof(name(0))                 =
           \
> > +static inline __attribute__((always_inline)) typeof(name(0))          =
   \
> >  ____##name(struct pt_regs *ctx, ##args)
> >
> >  #define BPF_KPROBE_SYSCALL BPF_KSYSCALL
> > diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> > index 4f2adc0bd6ca..2bd2d80b3751 100644
> > --- a/tools/lib/bpf/usdt.bpf.h
> > +++ b/tools/lib/bpf/usdt.bpf.h
> > @@ -232,7 +232,7 @@ long bpf_usdt_cookie(struct pt_regs *ctx)
> >   */
> >  #define BPF_USDT(name, args...)                                       =
           \
> >  name(struct pt_regs *ctx);                                            =
   \
> > -static __attribute__((always_inline)) typeof(name(0))                 =
           \
> > +static inline __attribute__((always_inline)) typeof(name(0))          =
   \
> >  ____##name(struct pt_regs *ctx, ##args);                              =
   \
> >  typeof(name(0)) name(struct pt_regs *ctx)                             =
   \
> >  {                                                                     =
   \
> > @@ -241,7 +241,7 @@ typeof(name(0)) name(struct pt_regs *ctx)          =
                   \
> >          return ____##name(___bpf_usdt_args(args));                    =
   \
> >          _Pragma("GCC diagnostic pop")                                 =
           \
> >  }                                                                     =
   \
> > -static __attribute__((always_inline)) typeof(name(0))                 =
           \
> > +static inline __attribute__((always_inline)) typeof(name(0))          =
   \
> >  ____##name(struct pt_regs *ctx, ##args)
> >
> >  #endif /* __USDT_BPF_H__ */
> > --
> > 2.34.1
> >
