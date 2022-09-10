Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B075B4362
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 02:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIJA0w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 20:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIJA0u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 20:26:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F874C697A;
        Fri,  9 Sep 2022 17:26:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z97so4839872ede.8;
        Fri, 09 Sep 2022 17:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MbAEJbfBHpl5/eUfL7WvdRsqjkaCRj9mnlfWbPXjzK8=;
        b=iHPFEO7Tl396DvqfM88tOyOzzFEEFGYZzJACKj2gyq3B5EAJMcbDyF2KjIYsvpi80Z
         2as3vpQ5WS97L1DuU+h0CaH25bWiHYaqQRjnEB12YQu0w0bl0IgPEDoa2slkxpWthl4x
         ckjOnAzKxyru1y3iQV8K8vTtBnUx49VtkDgRiKa2h5r3/ChGzxmEWrZmb6ysA/i/mJ9L
         uehYeqRWDsDJobmTh8u0+D1b8kvkzERbdGI9OvWZpN2KF8zVKIkutsuOKffyo3YE8qjM
         jqg0sdSc2zfG0VVSpXx5RDWE1TJp+yn5Pk2YBhds8f9ibSZLqpGeeKG3qL37jGN7JI5o
         jiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MbAEJbfBHpl5/eUfL7WvdRsqjkaCRj9mnlfWbPXjzK8=;
        b=dANyTdQZBLbEK2cjzXvTguHVWQoZclQpbp5Hp/pULAV/C1Sg5l3hiH5Z6PpTJX0s0F
         I/9ZpdxVwQGH+JPVtl+VPlggm7gvk3Yck6lhwC1fAz8y7F0oPaX+g+m9Zri9mn83Fi3I
         mXx/fbSUgU6d9QAC8/VcNoh8mpqaBayrjzkklizBts7izJhidEGozoFBEU4EoaFMOvpi
         tGg87YfLDCzMLIRAs7uN6Mvss/MiH1I+kqzs9u3Spw3fkpt6lRu+8xt3gflxodX/uLHR
         6lp3RUxEK+z0y7wAa3Htu+w8GO+L/uOpxR0odbDoxZsiDr+MRu+5DeTfBfmFXQ3iHZmA
         ++tQ==
X-Gm-Message-State: ACgBeo2jPs9l7ZA+2B4QND/8EesbhbOHBZBMdvGzkpREWXaPvoelmXzB
        v666wxQ5IUNv+O7ocSkznNFn32zbTg7ECRX2ldM=
X-Google-Smtp-Source: AA6agR4wjwViwrsT6LteTG9R0OtH4aRDEJOtpQ/M8vVlx1QtBQX/6uzmfrIS6DwOn7fhvMA/2mF05E/HaHAyESjsTV4=
X-Received: by 2002:a05:6402:1946:b0:44e:a406:5ff5 with SMTP id
 f6-20020a056402194600b0044ea4065ff5mr13666104edz.14.1662769607975; Fri, 09
 Sep 2022 17:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220909224544.3702931-1-james.hilliard1@gmail.com>
In-Reply-To: <20220909224544.3702931-1-james.hilliard1@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 17:26:36 -0700
Message-ID: <CAEf4Bzbm_wq=n8+ve95aBtJkK-WcsUmKM_LT57XU0D9zS9gXuQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: define bpf_tail_call_static when __clang__ is not defined
To:     James Hilliard <james.hilliard1@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 3:46 PM James Hilliard <james.hilliard1@gmail.com> wrote:
>
> The bpf_tail_call_static function is currently not defined unless
> using clang >= 8.
>
> To support bpf_tail_call_static on GCC we can check if __clang__ is
> not defined to enable bpf_tail_call_static.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/lib/bpf/bpf_helpers.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 7349b16b8e2f..30fc95e7cd76 100644
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
> @@ -148,8 +148,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>          *
>          * Note on clobber list: we need to stay in-line with BPF calling
>          * convention, so even if we don't end up using r0, r4, r5, we need
> -        * to mark them as clobber so that LLVM doesn't end up using them
> -        * before / after the call.
> +        * to mark them as clobber so that the compiler doesn't end up using
> +        * them before / after the call.
>          */
>         asm volatile("r1 = %[ctx]\n\t"
>                      "r2 = %[map]\n\t"

will this compile as is on GCC-BPF? I'm trying to understand what's
the point. Once GCC supports this ASM syntax we can add similar check
to __clang_major__, instead of allowing it for all GCC versions?

We must have done __clang_major__ check for a reason, old Clangs
probably had some problems compiling this. Maybe Daniel remembers?

> --
> 2.34.1
>
