Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2841455A5DA
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 03:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiFYB03 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 21:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiFYB02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 21:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3373D4A0
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 18:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94D7E61CF4
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 01:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFE6C385A2
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 01:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656120386;
        bh=nFbdCqWbGQ7vtxnM6PD8XoHmTfIPnH4E4M8xX54ZvPU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=phJ573Z6G+ERIwj8792Jj6C8VOCq+7v5dGYjQpkrp9rnXeVQuMxo81vTNII9vBG1E
         o3AkvKA0yD/0RxWv5YN5W+GsJr2+X6xZHPgDoqlgm1RWgnbtucOC6A/5n7QG6YJEGB
         1ToZWCxzr1yd56kfErn2iLGkMkNHie6S+0BlEwDWCq15575GFCS7/UiYDefpTABQY+
         Hs0sE8y+h4qZXUkUxsm3q8h69Co1I/VjE/xdEavbZ3eiMj/5a+iCLc8uDwrYpqkt4T
         rni7wT64zJGrGzeRPjUmD2WV4tVG7XM+EH/s7R8dqIiLrPqjJ+jMX1OKGUKO5BCazm
         cop6/tj/3GXwg==
Received: by mail-yb1-f174.google.com with SMTP id i7so7227464ybe.11
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 18:26:26 -0700 (PDT)
X-Gm-Message-State: AJIora/KW8tcO3XsplyCq4SNBtX47V5SICQDvu52H3rm2eBvsnpM2Ymh
        s28Srv104Wx5/atDGjzd8M5GDg5roL3duIsCHX58Ug==
X-Google-Smtp-Source: AGRyM1vrTxsboxJ7IVr2GzXRdf64LqO1LwAq+RU6PvgrapD46kggHZtWE16dhqswHGovW/RiYsaWyeU8TS7/DdAjuCI=
X-Received: by 2002:a25:d292:0:b0:66c:8adb:ce55 with SMTP id
 j140-20020a25d292000000b0066c8adbce55mr822566ybg.131.1656120385726; Fri, 24
 Jun 2022 18:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220624045636.3668195-1-kpsingh@kernel.org> <20220624045636.3668195-3-kpsingh@kernel.org>
 <CAEf4Bza_ZWmFN0YreF7Oqj+jerGkydcJc9bKe=+DDT0LJAZLCw@mail.gmail.com>
In-Reply-To: <CAEf4Bza_ZWmFN0YreF7Oqj+jerGkydcJc9bKe=+DDT0LJAZLCw@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 24 Jun 2022 20:26:14 -0500
X-Gmail-Original-Message-ID: <CACYkzJ6aiw9dRrt_YLvJ3x=cok+WiKWCx+X8FkOyO=NV1HF7vA@mail.gmail.com>
Message-ID: <CACYkzJ6aiw9dRrt_YLvJ3x=cok+WiKWCx+X8FkOyO=NV1HF7vA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/5] bpf: kfunc support for ARG_PTR_TO_CONST_STR
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 5:03 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 23, 2022 at 9:56 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > kfuncs can handle pointers to memory when the next argument is
> > the size of the memory that can be read and verify these as
> > ARG_CONST_SIZE_OR_ZERO
> >
> > Similarly add support for string constants (const char *) and
> > verify it similar to ARG_PTR_TO_CONST_STR.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h |  2 +
> >  kernel/bpf/btf.c             | 25 ++++++++++
> >  kernel/bpf/verifier.c        | 89 +++++++++++++++++++++---------------
> >  3 files changed, 78 insertions(+), 38 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 81b19669efba..f6d8898270d5 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -560,6 +560,8 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
> >                              u32 regno);
> >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> >                    u32 regno, u32 mem_size);
> > +int check_const_str(struct bpf_verifier_env *env,
> > +                   const struct bpf_reg_state *reg, int regno);
> >
> >  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> >  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 668ecf61649b..b31e8d8f2d4d 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6162,6 +6162,23 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
> >         return true;
> >  }
> >
> > +static bool btf_param_is_const_str_ptr(const struct btf *btf,
> > +                                      const struct btf_param *param)
> > +{
> > +       const struct btf_type *t;
> > +
> > +       t = btf_type_by_id(btf, param->type);
> > +       if (!btf_type_is_ptr(t))
> > +               return false;
> > +
> > +       t = btf_type_by_id(btf, t->type);
> > +       if (BTF_INFO_KIND(t->info) != BTF_KIND_CONST)
> > +               return false;
> > +
> > +       t = btf_type_skip_modifiers(btf, t->type, NULL);
>
> nit: this looks a bit fragile, you assume CONST comes first and then
> skip the rest of modifiers (including typedefs). Maybe either make it
> more permissive and then check that CONST is somewhere there in the
> chain (you'll have to open-code btf_type_skip_modifiers() loop), or
> make it more restrictive and say that it has to be `const char *` and
> nothing else (no volatile, no restrict, no typedefs)?

I did not bother doing that since they are kfuncs and we have a limited set of
types, but I agree that it will confuse someone, someday. So, I updated it.
Also, while I was at it, I moved the comment for the arg_mem_size below
where it should have.

Does this seem okay to you?


diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9f289b346790..a97e664e4d4d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6166,17 +6166,21 @@ static bool btf_param_is_const_str_ptr(const
struct btf *btf,
                                       const struct btf_param *param)
 {
        const struct btf_type *t;
+       bool is_const = false;

        t = btf_type_by_id(btf, param->type);
        if (!btf_type_is_ptr(t))
                return false;

        t = btf_type_by_id(btf, t->type);
-       if (BTF_INFO_KIND(t->info) != BTF_KIND_CONST)
-               return false;
+       while (btf_type_is_modifier(t)) {
+               if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
+                       is_const = true;
+               t = btf_type_by_id(btf, t->type);
+       }

-       t = btf_type_skip_modifiers(btf, t->type, NULL);
-       return !strcmp(btf_name_by_offset(btf, t->name_off), "char");
+       return (is_const &&
+               !strcmp(btf_name_by_offset(btf, t->name_off), "char"));
 }

 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
@@ -6366,12 +6370,7 @@ static int btf_check_func_arg_match(struct
bpf_verifier_env *env,
                        if (is_kfunc) {
                                bool arg_mem_size = i + 1 < nargs &&
is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);

-                               /* Permit pointer to mem, but only when argument
-                                * type is pointer to scalar, or struct composed
-                                * (recursively) of scalars.
-                                * When arg_mem_size is true, the pointer can be
-                                * void *.
-                                */
+
                                if (btf_param_is_const_str_ptr(btf, &args[i])) {
                                        err = check_const_str(env, reg, regno);
                                        if (err < 0)
@@ -6379,6 +6378,12 @@ static int btf_check_func_arg_match(struct
bpf_verifier_env *env,
                                        continue;
                                }

+                               /* Permit pointer to mem, but only when argument
+                                * type is pointer to scalar, or struct composed
+                                * (recursively) of scalars.
+                                * When arg_mem_size is true, the pointer can be
+                                * void *.
+                                */
                                if (!btf_type_is_scalar(ref_t) &&
                                    !__btf_type_is_scalar_struct(log,
btf, ref_t, 0) &&
                                    (arg_mem_size ?
!btf_type_is_void(ref_t) : 1)) {


>
> > +       return !strcmp(btf_name_by_offset(btf, t->name_off), "char");
> > +}
> > +
>
> [...]
