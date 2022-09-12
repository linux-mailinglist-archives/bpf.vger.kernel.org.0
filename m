Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998CA5B54A9
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 08:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiILGor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiILGoo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 02:44:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E02BD91;
        Sun, 11 Sep 2022 23:44:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n23-20020a17090a091700b00202a51cc78bso5128502pjn.2;
        Sun, 11 Sep 2022 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iMAohkJ88LxPurHRb39tNyriHTx3rqUB1Dm6C5Di/RA=;
        b=KsJQE4+zfarttwkbFAzYmt7ml/SOEiKUuWOf5ARCFNvOn0IPSNTH99aNooJUlFrOUF
         dDxOb5LQMyNogfonNrQ22Q1fhwTDkWYvAJ7swpSuaLvTYQIzk/oyOVVG/St0kqu+TXry
         SqpXG3DMZf/Bg6fcXtjDh2Hm/dY4yUZx2uP6KfeOb62EgkxHpd3qABqK2QUoKoe7Ypvo
         QTWYUxCjlQvMV40Sh4+nzTgTLLu9gCy1MN4HimvkNFwtyE+F/I5kioq2JsxI1TUNn9kB
         9Pp1mKYDv3uUBJjbjV7vqlT/PFU3kH9c+L7tDVBt8/EnmRdCVFCZSCRd/8N03atWEH3+
         91Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iMAohkJ88LxPurHRb39tNyriHTx3rqUB1Dm6C5Di/RA=;
        b=W/9Muy3HzL8jxYpmD91zdLH+7sbbvwxpQsj/flcHRdZnxvCfVugEvIug7xktiBL2NW
         11+ZvfYusUNQLpuRrMqUllVfcTJ/V7uIWA0Lez1Awnmoe2FIC2QyNZxKMGISQ6A98lDn
         u6WqyrF2JYmUT1ZjalyTDuMLVORX37/wzINXyPHCbAIGc6H937Otz0PxqI6X11wW/e2y
         1tRjGDhwJoF6tDMyM2S600mvxBjmz/6why0Fw2TBYh6dAapluh7ajko2XqcsVKoIZ9dW
         FF1XUPOoXpmPfwWj39Gi8PB90swkuw580KCBBhTVjLGPPWrAq954N85c/cxObomTcgbi
         HMSQ==
X-Gm-Message-State: ACgBeo2yUHlGchjMxWhMFG5Aue7f/bZ6kQGI0CM0eS/crK9Qq+hmU8vU
        Jlq6IeQJHxuPyVKbtz+qe8ztnN2ns99KIQutE38=
X-Google-Smtp-Source: AA6agR771WKf4PnOUJygezxSfXmS0OkGPyK3n16p+7DKRc70kqw2E01+3HkWhEdpa3WfArHUBGHlMZlOvM6ni+ezm8s=
X-Received: by 2002:a17:902:f394:b0:176:b7b7:2 with SMTP id
 f20-20020a170902f39400b00176b7b70002mr25269655ple.57.1662965081460; Sun, 11
 Sep 2022 23:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220909224544.3702931-1-james.hilliard1@gmail.com> <CAEf4Bzbm_wq=n8+ve95aBtJkK-WcsUmKM_LT57XU0D9zS9gXuQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzbm_wq=n8+ve95aBtJkK-WcsUmKM_LT57XU0D9zS9gXuQ@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 12 Sep 2022 00:44:28 -0600
Message-ID: <CADvTj4oF7Khci-w8LZPWvOjhKEepd-qG0evZ2_OorU=H2wtpaA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: define bpf_tail_call_static when __clang__ is not defined
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 6:26 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 9, 2022 at 3:46 PM James Hilliard <james.hilliard1@gmail.com> wrote:
> >
> > The bpf_tail_call_static function is currently not defined unless
> > using clang >= 8.
> >
> > To support bpf_tail_call_static on GCC we can check if __clang__ is
> > not defined to enable bpf_tail_call_static.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  tools/lib/bpf/bpf_helpers.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index 7349b16b8e2f..30fc95e7cd76 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -131,7 +131,7 @@
> >  /*
> >   * Helper function to perform a tail call with a constant/immediate map slot.
> >   */
> > -#if __clang_major__ >= 8 && defined(__bpf__)
> > +#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
> >  static __always_inline void
> >  bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> >  {
> > @@ -139,8 +139,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> >                 __bpf_unreachable();
> >
> >         /*
> > -        * Provide a hard guarantee that LLVM won't optimize setting r2 (map
> > -        * pointer) and r3 (constant map index) from _different paths_ ending
> > +        * Provide a hard guarantee that the compiler won't optimize setting r2
> > +        * (map pointer) and r3 (constant map index) from _different paths_ ending
> >          * up at the _same_ call insn as otherwise we won't be able to use the
> >          * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
> >          * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
> > @@ -148,8 +148,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> >          *
> >          * Note on clobber list: we need to stay in-line with BPF calling
> >          * convention, so even if we don't end up using r0, r4, r5, we need
> > -        * to mark them as clobber so that LLVM doesn't end up using them
> > -        * before / after the call.
> > +        * to mark them as clobber so that the compiler doesn't end up using
> > +        * them before / after the call.
> >          */
> >         asm volatile("r1 = %[ctx]\n\t"
> >                      "r2 = %[map]\n\t"
>
> will this compile as is on GCC-BPF? I'm trying to understand what's
> the point. Once GCC supports this ASM syntax we can add similar check
> to __clang_major__, instead of allowing it for all GCC versions?

So, it's a bit different since the ASM syntax issue is more of an
issue with GAS,
we would need a check along these lines I think for a proper migration path:
https://lore.kernel.org/bpf/20220912063514.2824432-1-james.hilliard1@gmail.com/

We would set something like once GAS support for the llvm syntax is added:
.ifdef .gasversion. < 24000

I don't think we can do a compiler version check here like with llvm since GCC
release cycles are out of sync with GAS(llvm assembler is kept in sync with the
compiler AFAIU).

>
> We must have done __clang_major__ check for a reason, old Clangs
> probably had some problems compiling this. Maybe Daniel remembers?
>
> > --
> > 2.34.1
> >
