Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4756E5B453D
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiIJIbj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 04:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIJIbh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 04:31:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED69F95AFE;
        Sat, 10 Sep 2022 01:31:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e5so3816954pfl.2;
        Sat, 10 Sep 2022 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1gQpQt9P/PRvgYQDj2poIKgpdpCzbzGi10LwLBhdI98=;
        b=CYuI1/EfkJudsXb9TVEtBgOYmz0Rhy+1YEiTbBitUvaoHm7t4fADYIK8M077JIrTlT
         R+SgratayUe9Bjfkw2RB9B9VFX2+7dX6ksYZ2AqRM8IfKeezcw+uvIZA1/Pg/CdbV01K
         bASTBC74FI7E9na1pqcuMrfL3MreuEIc4Uhc2GSpGo4a3BxKD5Cbm1iT37lGVLs1swgW
         mJt/X9WpPn86OytkatIV+g3ZIO2dhU03LPHxZdZRV6ItRKrgZ94MDcWbKvvFF9YvPq1B
         8BL92ZDIGqW9FGqY8hXYPKg2k3lwhM+z2N9cpspVkFusDU4tz7gUD2VMs4G+wt0wg5NB
         NLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1gQpQt9P/PRvgYQDj2poIKgpdpCzbzGi10LwLBhdI98=;
        b=XFh2uG9GFtwr0YuY1i5HOHoZlvnBtgiI7btFosbnd2B/LDjnTHEC3KmbW2aTrAGJSL
         QOYFKEVfDbdA1FXp4Kd5oKdOUAq8IxDahA24iOHfHS9X33ZdjJMYrT/2SB2fdwx/Jf1S
         9cLuCkRd3n3a1ngxDmtD8v6W1tSoi4JmCUMn+QHCR8VHH+PrG0IYpzVkcspfazdwqAB0
         hyAxbDh06tsqHkx/r6g8ZacIGEu5XeeRxQ2ODffiJWg9jIMBmnHvB9YAbdX/+SoWn7o6
         s0OLd2LYVPCfE+s8IeA4EIjIRjVOuxHVN+Fm3mH9ZWtUSZF5cZ1f0MNEjQS6Z+zepOSQ
         GakA==
X-Gm-Message-State: ACgBeo1LUAxRg0ZgfnIljpE4DxyhxcF1I58hKI2xyiR4Ml9e8S8Wa+qc
        b7414dFAgfWG6FE8Q6eROjEEXX+ILuLU0P1RMtQ=
X-Google-Smtp-Source: AA6agR4ztIqEPt35ZW0o9ztqH9GvgKn5e6ny0TAz+JeMdFc19D2iJFC1FOnL7wD71X/h9Nee30liXq2/pxPLVFbVg/0=
X-Received: by 2002:a05:6a00:1390:b0:540:b6b6:e978 with SMTP id
 t16-20020a056a00139000b00540b6b6e978mr10341705pfg.8.1662798692250; Sat, 10
 Sep 2022 01:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220829210546.755377-1-james.hilliard1@gmail.com>
 <CAEf4Bza6g4tZDtuKCaBwVVJSHUrLYh=pbUffPBpmWtR-xyXyqQ@mail.gmail.com>
 <CADvTj4pF=D7PEBF-LK_sKckRUCq-vd9ZjohpiEgLvORg8UaZyw@mail.gmail.com>
 <CAEf4BzbjMWC50J-mn_aNd2BeJWU=nLJmsJCAVvTqLSYsh4RejA@mail.gmail.com>
 <CADvTj4qLhgQ1K30dKoviw10G6f5XTv7T6SChUPvYnNWZGxw4OA@mail.gmail.com> <871qsjyb41.fsf@oracle.com>
In-Reply-To: <871qsjyb41.fsf@oracle.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sat, 10 Sep 2022 02:31:20 -0600
Message-ID: <CADvTj4ov8wnWCGXsKRF5QJn9_+NQ8RspydrGPjE5=9KWZQuNEA@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: add GCC support for bpf_tail_call_static
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, elena.zannoni@oracle.com
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

On Sat, Sep 10, 2022 at 12:53 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Fri, Sep 9, 2022 at 12:56 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Fri, Sep 9, 2022 at 11:23 AM James Hilliard
> >> <james.hilliard1@gmail.com> wrote:
> >> >
> >> > On Fri, Sep 9, 2022 at 12:05 PM Andrii Nakryiko
> >> > <andrii.nakryiko@gmail.com> wrote:
> >> > >
> >> > > On Mon, Aug 29, 2022 at 2:05 PM James Hilliard
> >> > > <james.hilliard1@gmail.com> wrote:
> >> > > >
> >> > > > The bpf_tail_call_static function is currently not defined unless
> >> > > > using clang >= 8.
> >> > > >
> >> > > > To support bpf_tail_call_static on GCC we can check if __clang__ is
> >> > > > not defined to enable bpf_tail_call_static.
> >> > > >
> >> > > > We need to use GCC assembly syntax when the compiler does not define
> >> > > > __clang__ as LLVM inline assembly is not fully compatible with GCC.
> >> > > >
> >> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >> > > > ---
> >> > > > Changes v1 -> v2:
> >> > > >   - drop __BPF__ check as GCC now defines __bpf__
> >> > > > ---
> >> > > >  tools/lib/bpf/bpf_helpers.h | 19 +++++++++++++------
> >> > > >  1 file changed, 13 insertions(+), 6 deletions(-)
> >> > > >
> >> > > > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> >> > > > index 7349b16b8e2f..867b734839dd 100644
> >> > > > --- a/tools/lib/bpf/bpf_helpers.h
> >> > > > +++ b/tools/lib/bpf/bpf_helpers.h
> >> > > > @@ -131,7 +131,7 @@
> >> > > >  /*
> >> > > >   * Helper function to perform a tail call with a constant/immediate map slot.
> >> > > >   */
> >> > > > -#if __clang_major__ >= 8 && defined(__bpf__)
> >> > > > +#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
> >> > > >  static __always_inline void
> >> > > >  bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> >> > > >  {
> >> > > > @@ -139,8 +139,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> >> > > >                 __bpf_unreachable();
> >> > > >
> >> > > >         /*
> >> > > > -        * Provide a hard guarantee that LLVM won't optimize setting r2 (map
> >> > > > -        * pointer) and r3 (constant map index) from _different paths_ ending
> >> > > > +        * Provide a hard guarantee that the compiler won't optimize setting r2
> >> > > > +        * (map pointer) and r3 (constant map index) from _different paths_ ending
> >> > > >          * up at the _same_ call insn as otherwise we won't be able to use the
> >> > > >          * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
> >> > > >          * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
> >> > > > @@ -148,12 +148,19 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> >> > > >          *
> >> > > >          * Note on clobber list: we need to stay in-line with BPF calling
> >> > > >          * convention, so even if we don't end up using r0, r4, r5, we need
> >> > > > -        * to mark them as clobber so that LLVM doesn't end up using them
> >> > > > -        * before / after the call.
> >> > > > +        * to mark them as clobber so that the compiler doesn't end up using
> >> > > > +        * them before / after the call.
> >> > > >          */
> >> > > > -       asm volatile("r1 = %[ctx]\n\t"
> >> > > > +       asm volatile(
> >> > > > +#ifdef __clang__
> >> > > > +                    "r1 = %[ctx]\n\t"
> >> > > >                      "r2 = %[map]\n\t"
> >> > > >                      "r3 = %[slot]\n\t"
> >> > > > +#else
> >> > > > +                    "mov %%r1,%[ctx]\n\t"
> >> > > > +                    "mov %%r2,%[map]\n\t"
> >> > > > +                    "mov %%r3,%[slot]\n\t"
> >> > > > +#endif
> >> > >
> >> > > Hey James,
> >> > >
> >> > > I don't think it's a good idea to have a completely different BPF asm
> >> > > syntax in GCC-BPF vs what Clang is supporting. Note that Clang syntax
> >> > > is also what BPF users see in BPF verifier log and in llvm-objdump
> >> > > output, so that's what BPF users are familiar with.
> >> >
> >> > Is the difference a BPF specific assembly format deviation or a generic
> >> > deviation in assembler template syntax between GCC/llvm?
> >> > https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#AssemblerTemplate
> >> >
> >>
> >> Sorry, I don't understand the question. I'm talking about the above
> >> snippet with "r1 = %[ctx]" vs "mov %%r1,%[ctx]". Seems like the rest
> >> stayed the same. So this would be a "BPF specific assembly format"
> >> case, right? I don't know what else could be different with GCC-BPF
> >> assembly.
> >
> > I mean it's unclear if it's a generic assembly template format difference
> > that applies to all targets or one that's BPF target specific.
>
> It is certainly BPF specific.
>
> I think that when I first wrote the BPF GNU toolchain port the assembly
> format used by LLVM was different than it is now: I certainly didn't
> invent the syntax the GNU assembler uses for BPF.
>
> It seems LLVM settled with that C-like syntax for assembly instead,
> which is very unconventional.
>
> > Anyways for now I sent a new patch so that bpf_tail_call_static is defined
> > on non-clang compilers so that it will work when GCC-BPF supports the
> > existing asm format.
> > https://lore.kernel.org/bpf/20220909224544.3702931-1-james.hilliard1@gmail.com/
>
> I don't think this patch makes much sense: these guards are designed to
> avoid compilers that do not support the inline assembly (as presumably
> happen with clang < 8) to choke on the header file.  That's also the
> case of GCC BPF at the moment.
>
> With this patch, people won't be currentty able to use bpf_helpers.h
> with GCC BPF even if they don't use bpf_tail_call_static.

That doesn't seem to be an issue here, from what I can tell it's not
a failure in the compiler but a failure in the assembler, so having
bpf_tail_call_static unguarded in GCC doesn't break anything
that isn't already broken.

>
> >> > >
> >> > > This will cause constant and unavoidable maintenance burden both for
> >> > > libraries like libbpf and end users and their BPF apps as well.
> >> > >
> >> > > Given you are trying to make GCC-BPF part of the BPF ecosystem, please
> >> > > think about how to help the ecosystem, move it forward and unify it,
> >> > > not how to branch out and have Clang vs GCC differences everywhere.
> >> > > There is a lot of embedded BPF asm in production applications, having
> >> > > to write something as trivial as `r1 = X` in GCC or Clang-specific
> >> > > ways is a huge burden.
> >> > >
> >> > > As such, we've reverted your patch ([0]). Please add de facto BPF asm
> >> > > syntax support to GCC-BPF and this change won't be necessary.
> >> > >
> >> > >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=665f5d3577ef43e929d59cf39683037887c351bf
> >> > >
> >> > > >                      "call 12"
> >> > > >                      :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
> >> > > >                      : "r0", "r1", "r2", "r3", "r4", "r5");
> >> > > > --
> >> > > > 2.34.1
> >> > > >
