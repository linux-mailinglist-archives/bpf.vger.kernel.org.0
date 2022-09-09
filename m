Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23235B3E7B
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 20:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIISFO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 14:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiIISFL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 14:05:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B14B0FA;
        Fri,  9 Sep 2022 11:05:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so5864415ejc.1;
        Fri, 09 Sep 2022 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PRi5c+744JgXz7r9GuZCijMImqB0eIkuk0+iSaMrpvM=;
        b=Ynq/dlNKNVDIzzbnzG46hZDxhfEdxgRb+cFXx402hqOIdhi2Ra4HrDsGEyYDwzxGK5
         q8zryMdSGYJtehI9TrM1vnoN0fmCDMrnuESlsmC96HIub3jLNKuQwTd/gVvcZf7s27WB
         sHPx6mF+Mwr+q7lwuX9/pgwadgb2qypXBAMje/r5Udk7fq7fWGOggMOyAG8M9fpfwScv
         1kS1yoUB8MtudRILMEf/2iYk+3wvzIvZrnGXUvvp4Ip55JrUm4ykmbwSQLXXgqGZ0h3u
         1u8bo80J5Mx8MhCWo3KNspts+i4ojiMFOUyuZk1DYGBhZIyI9Fz5DysMj/llalvTErOe
         cN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PRi5c+744JgXz7r9GuZCijMImqB0eIkuk0+iSaMrpvM=;
        b=iha3LNQJi0JmIjttET4NRXg9pGKGGQYWy5UJp3A4HCLoqWfj5hsfzFtdKn+752UWCI
         XmNinph4Ea/dMgN1cSTzsOQ/7zPT1eC1YkCHreqAs2Sy9ZzrqLYRZJX1nYWSw/see0HJ
         9XUxyRrB9YDAmYrLnB0tYwGF+K112ax4RyX39IFfYNYppii5s8d7d9tKb1vfP67YhjEY
         +/Uivl8zIF7g41U2XwmS3XrVw3b65v9MlKFzPeaQXA47fmC9xBhVdXky+MvoDNnBjzJD
         cnse0Q8ZjgmWzBs7wYqQxULAhDqMm7dOcul0iZOmRs8CYnQrcMok5VUsIzaZRh4aQL5D
         8q2Q==
X-Gm-Message-State: ACgBeo1kGACFjWvSit2MKwk6DYp2UmEwtk7vQ+g7CiwPxLBaNtoCcEmA
        JdxlQ7CETCmEOm+Xn4ACKsVUjCZy4fvR/ERrt38=
X-Google-Smtp-Source: AA6agR7gAQlMU7PvFtUri4wvw9gT1MAU2Zq02UggAkByil9IIEFpMj73H8AUVhCfGLBkRRHrWGfKGRrVaVaaYT5SD7k=
X-Received: by 2002:a17:907:2bd8:b0:770:77f2:b7af with SMTP id
 gv24-20020a1709072bd800b0077077f2b7afmr1250011ejc.545.1662746703412; Fri, 09
 Sep 2022 11:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220829210546.755377-1-james.hilliard1@gmail.com>
In-Reply-To: <20220829210546.755377-1-james.hilliard1@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 11:04:51 -0700
Message-ID: <CAEf4Bza6g4tZDtuKCaBwVVJSHUrLYh=pbUffPBpmWtR-xyXyqQ@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: add GCC support for bpf_tail_call_static
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
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
        llvm@lists.linux.dev
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

On Mon, Aug 29, 2022 at 2:05 PM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> The bpf_tail_call_static function is currently not defined unless
> using clang >= 8.
>
> To support bpf_tail_call_static on GCC we can check if __clang__ is
> not defined to enable bpf_tail_call_static.
>
> We need to use GCC assembly syntax when the compiler does not define
> __clang__ as LLVM inline assembly is not fully compatible with GCC.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - drop __BPF__ check as GCC now defines __bpf__
> ---
>  tools/lib/bpf/bpf_helpers.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 7349b16b8e2f..867b734839dd 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -131,7 +131,7 @@
>  /*
>   * Helper function to perform a tail call with a constant/immediate map slot.
>   */
> -#if __clang_major__ >= 8 && defined(__bpf__)
> +#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
>  static __always_inline void
>  bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>  {
> @@ -139,8 +139,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>                 __bpf_unreachable();
>
>         /*
> -        * Provide a hard guarantee that LLVM won't optimize setting r2 (map
> -        * pointer) and r3 (constant map index) from _different paths_ ending
> +        * Provide a hard guarantee that the compiler won't optimize setting r2
> +        * (map pointer) and r3 (constant map index) from _different paths_ ending
>          * up at the _same_ call insn as otherwise we won't be able to use the
>          * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
>          * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
> @@ -148,12 +148,19 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>          *
>          * Note on clobber list: we need to stay in-line with BPF calling
>          * convention, so even if we don't end up using r0, r4, r5, we need
> -        * to mark them as clobber so that LLVM doesn't end up using them
> -        * before / after the call.
> +        * to mark them as clobber so that the compiler doesn't end up using
> +        * them before / after the call.
>          */
> -       asm volatile("r1 = %[ctx]\n\t"
> +       asm volatile(
> +#ifdef __clang__
> +                    "r1 = %[ctx]\n\t"
>                      "r2 = %[map]\n\t"
>                      "r3 = %[slot]\n\t"
> +#else
> +                    "mov %%r1,%[ctx]\n\t"
> +                    "mov %%r2,%[map]\n\t"
> +                    "mov %%r3,%[slot]\n\t"
> +#endif

Hey James,

I don't think it's a good idea to have a completely different BPF asm
syntax in GCC-BPF vs what Clang is supporting. Note that Clang syntax
is also what BPF users see in BPF verifier log and in llvm-objdump
output, so that's what BPF users are familiar with.

This will cause constant and unavoidable maintenance burden both for
libraries like libbpf and end users and their BPF apps as well.

Given you are trying to make GCC-BPF part of the BPF ecosystem, please
think about how to help the ecosystem, move it forward and unify it,
not how to branch out and have Clang vs GCC differences everywhere.
There is a lot of embedded BPF asm in production applications, having
to write something as trivial as `r1 = X` in GCC or Clang-specific
ways is a huge burden.

As such, we've reverted your patch ([0]). Please add de facto BPF asm
syntax support to GCC-BPF and this change won't be necessary.

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=665f5d3577ef43e929d59cf39683037887c351bf

>                      "call 12"
>                      :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>                      : "r0", "r1", "r2", "r3", "r4", "r5");
> --
> 2.34.1
>
