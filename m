Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65677317478
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 00:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhBJXdv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 18:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhBJXdp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 18:33:45 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82272C061756
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 15:33:00 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y128so3792031ybf.10
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 15:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kumzJLcgEbRNPsb0lnhoHksWFGSDEP1PQxRAQ5CRSmA=;
        b=aURljF9GPidNhabDxamStYgE/Tx8bAdF+Ae5CSTcLRbyZLq6eBNYGNgTJk2uPH/wcl
         Ope6ZoW6aGc8/ta23ATckP3EyhfX6UVqiBaUjgyIKQ44cmLfo9cpDvMHsFts3Yeo8BKX
         DVQZ03kHwFdTFz8qb2vc/x9lcvunENGX4upP1NKbjbpQUcX6YryX0DDeQF28pebl5D7q
         d8hYhxnA89ore3rHMRsSaxy4n9hPH1FEIaXIY0IStxQzMWneQS4niYSxB85TvBitzP9A
         1ZAnF45Hmqy+mqy/TwZ8X76K832x+TAl91AFuj//HMTM7nSE9I6U3GFRvbAUcI8vHly5
         P3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kumzJLcgEbRNPsb0lnhoHksWFGSDEP1PQxRAQ5CRSmA=;
        b=fIBq+0HNee9vrAynjvq8Y92wFf+LgTiVpMzIzsxlHrVux4WTxxewetUZH1gY2BWvi5
         g/rvTSxPLz0sHHvTnNyQy/F+T5rGWRTmiolOt206kE55xLblsdfYVv/a//oA5mNhd40j
         EBLLVjpsyjAmbMiVE+ybbocEcwc5PhImVwdrvGDsQKndd4v9VpIQxXgsHdkZ2t6dCrrZ
         FJF5jqjKcKsQkjBtW3jDCLaWoT9dUa6PZZks9zXGWU7Ni3csAvH89KghwrOF5QbrvVS5
         3VAJlzWoWnMAvt40lS62akKAGxQCc/C9XYZ4AB29MMPhr6drd316W2fOWYQ51bIdaHO5
         3oJg==
X-Gm-Message-State: AOAM532Xr23I3AYkzHF3Yw0cSHl6Eh6mRU/Btcen4BDyABja8Ono7lLN
        tgw0c5rGEUn592lI4uocuV/PaJ3qSlt559D8XPQ=
X-Google-Smtp-Source: ABdhPJw6hfCf+X/t0+q3nA40KHmEeQcJZtu2F0S02s795SEKP9K0Lukp0vilGniXaiMy535YOofDkZa3ykJh4yMk8GQ=
X-Received: by 2002:a25:a183:: with SMTP id a3mr7726338ybi.459.1612999979746;
 Wed, 10 Feb 2021 15:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20210209064421.15222-1-me@ubique.spb.ru> <20210209064421.15222-4-me@ubique.spb.ru>
In-Reply-To: <20210209064421.15222-4-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 15:32:48 -0800
Message-ID: <CAEf4BzZ8nYbBTagycWLVA5bCAsPfAZ8s=yFe3uScB8w+rwPZSA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Support pointers in global func args
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 10:44 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> Add an ability to pass a pointer to a type with known size in arguments
> of a global function. Such pointers may be used to overcome the limit on
> the maximum number of arguments, avoid expensive and tricky workarounds
> and to have multiple output arguments.
>
> A referenced type may contain pointers but indirect access through them
> isn't supported.
>
> The implementation consists of two parts.  If a global function has an
> argument that is a pointer to a type with known size then:
>
>   1) In btf_check_func_arg_match(): check that the corresponding
> register points to NULL or to a valid memory region that is large enough
> to contain the expected argument's type.
>
>   2) In btf_prepare_func_args(): set the corresponding register type to
> PTR_TO_MEM_OR_NULL and its size to the size of the expected type.
>
> A call to a global function may change stack's memory slot type(via
> check_helper_mem_access) similar to a helper function. That is why new
> pointer arguments are allowed only for functions with global linkage.
> Consider a case: stack's memory slot type is changed to STACK_MISC from
> spilled PTR_TO_PACKET(btf_check_func_arg_match() -> check_mem_reg() ->
> check_helper_mem_access() -> check_stack_boundary()) after a call to a
> static function and later verifier cannot infer safety of indirect
> accesses through the stack memory(check_stack_read() ->
> __mark_reg_unknown ()). This will break existing code.

Ok, so it took me a while (few attempts and some playing around with
static subprogs in selftests) to understand what is this paragraph is
talking about. So let me confirm, and maybe we can use that to
rephrase this into more clear explanation.

So the problem with allowing any (<type> *) argument for static
functions is that in such case static function might get successfully
validated as if it was global (i.e., based on types of its input
arguments). And in such case, corresponding stack slots in the caller
program will be marked with MISC types, because in general case we
can't know what kind of data is stored in the stack.

So here, instead of allowing this for static functions and eventually
optimistically validating it with STACK_MISC slots, we will fail
upfront and will rely on verifier to fallback to "inline" validation
of static functions, which will lead to a proper stack slots marking.
It will be less efficient validation, but would preserve more
information. For global we don't have the fallback case, so we'll just
do our best and will live with MISC slots.

Did I get this right?

>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---

So apart from the very confusing bit about special global func
handling here and some concerns about register ID generation, the
logic looks good, so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> v1 -> v2:
>  - Allow pointers only for global functions
>  - Add support of any type with known size
>  - Use conventional way to generate reg id
>  - Use boolean true/false instead of int 1/0
>  - Fix formatting
>
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/btf.c             | 55 +++++++++++++++++++++++++++++-------
>  kernel/bpf/verifier.c        | 30 ++++++++++++++++++++
>  3 files changed, 77 insertions(+), 10 deletions(-)
>

[...]

> @@ -5470,9 +5488,26 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
>                         reg->type = SCALAR_VALUE;
>                         continue;
>                 }
> -               if (btf_type_is_ptr(t) &&
> -                   btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> -                       reg->type = PTR_TO_CTX;
> +               if (btf_type_is_ptr(t)) {
> +                       if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> +                               reg->type = PTR_TO_CTX;
> +                               continue;
> +                       }
> +
> +                       t = btf_type_skip_modifiers(btf, t->type, NULL);
> +
> +                       ref_t = btf_resolve_size(btf, t, &reg->mem_size);
> +                       if (IS_ERR(ref_t)) {
> +                               bpf_log(log,
> +                                   "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
> +                                   i, btf_type_str(t), btf_name_by_offset(btf, t->name_off),
> +                                       PTR_ERR(ref_t));
> +                               return -EINVAL;
> +                       }
> +
> +                       reg->type = PTR_TO_MEM_OR_NULL;
> +                       reg->id = i + 1;

I see that in a bunch of other places we use reg->id = ++env->id_gen;
to generate register IDs, that looks safer and should avoid any
accidental ID collision. Is there any reason not to do that here?

> +
>                         continue;
>                 }
>                 bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d68ea6eb4f9b..fd423af1cc57 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3942,6 +3942,29 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>         }
>  }
>
> +int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                  u32 regno, u32 mem_size)
> +{
> +       if (register_is_null(reg))
> +               return 0;
> +
> +       if (reg_type_may_be_null(reg->type)) {
> +               /* Assuming that the register contains a value check if the memory
> +                * access is safe. Temorarily save and restore the register's state as

typo: temporarily

> +                * the conversion shouldn't be visible to a caller.
> +                */
> +               const struct bpf_reg_state saved_reg = *reg;
> +               int rv;
> +
> +               mark_ptr_not_null_reg(reg);
> +               rv = check_helper_mem_access(env, regno, mem_size, true, NULL);
> +               *reg = saved_reg;
> +               return rv;
> +       }
> +
> +       return check_helper_mem_access(env, regno, mem_size, true, NULL);
> +}
> +
>  /* Implementation details:
>   * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL
>   * Two bpf_map_lookups (even with the same key) will have different reg->id.
> @@ -11572,6 +11595,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>                                 mark_reg_known_zero(env, regs, i);
>                         else if (regs[i].type == SCALAR_VALUE)
>                                 mark_reg_unknown(env, regs, i);
> +                       else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
> +                               const u32 mem_size = regs[i].mem_size;
> +
> +                               mark_reg_known_zero(env, regs, i);
> +                               regs[i].mem_size = mem_size;
> +                               regs[i].id = ++env->id_gen;
> +                       }
>                 }
>         } else {
>                 /* 1st arg to a function */
> --
> 2.25.1
>
