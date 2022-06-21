Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFDC55395C
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 20:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352345AbiFUSEX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 14:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352655AbiFUSET (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 14:04:19 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E4222A3
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 11:04:18 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id j26so2051780vki.12
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhT1HWYUA3J9St0d2yJp7CrZzV5NgcNJLF3mhYyaLrM=;
        b=TS54QlO7LG11YjwIOKwZgXuOB3hnx+zKZa1qiJVZysfGQ+PFO3et6u1GrWVdyAth4J
         zt5Z01C9fakd8L/uE6gnDSHlKImV17ydpZYJDuANCD0q4Pykgez7jOSL4f6irZ7DeLxE
         kMoMvLvFYDlC+mDoYf5qoINYKs9TbcykA0/8imgnyeqBe/4ZAiI9y1aX3KliRsw48yBg
         djDWM3H1EFJrsrAn6ctyFF2jQUlZU9x/li/CxDFFYoKGryffiq1lHESVsikLgnHR1csp
         oBq0JfXg6dhHw6FOuvfV0LTa7DyDx34FxiJ5jxCFyreCgtG7acKUxhMf8bKkO18GkrcO
         Gi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhT1HWYUA3J9St0d2yJp7CrZzV5NgcNJLF3mhYyaLrM=;
        b=tJFqvDzmVOpUhtCxP6dqpjemVVfxDI44kjna6+w3uMwbUvgbNRcoNZr9X96ylhzip3
         wWq/eTm+9fX8bj+Iq1VlF9joP4bishit4p1m82EAJvPW6rglbdpDaZWznGKcvKTz7mQz
         d6TE6MXiBwLKODA4qFnRDWBsv1IAP+YnnR3KIpWWOrjKxXbi03Z2pfj5oo2OnApIgAl2
         hhdodo/33JRrb57aWEOstXl1+yD1rKbwHQGfEGOeRwzBb/ADK0X2mG7PURXD6FmPitV7
         aY7ABtMJ5T/I5/c4uS9xaYsuLFRvtJ6je79HbG6cHdI/a1Dypo/TeBfG3hwwMhpqAnml
         Cpjw==
X-Gm-Message-State: AJIora8dTpXMjBGrMyyS6/ZFTazd5NAjwzmu5N/F94s5v+GMhjQJ8uzl
        WnAVoZ4vt29wSl8TjeZB/SlKNOiOd2ATl/UuAL8=
X-Google-Smtp-Source: AGRyM1vsbfa5agxB+F8pRtK8MLgiRCFXTqSd68CjLzkxpB5GEoat4lZ7TTdq8+Fmu5++V8EVVgXbh5Ow/GAzzPYe/lk=
X-Received: by 2002:a05:6122:1990:b0:36b:f70c:ba55 with SMTP id
 bv16-20020a056122199000b0036bf70cba55mr6496225vkb.12.1655834656722; Tue, 21
 Jun 2022 11:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220621012811.2683313-1-kpsingh@kernel.org> <20220621012811.2683313-3-kpsingh@kernel.org>
In-Reply-To: <20220621012811.2683313-3-kpsingh@kernel.org>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 21 Jun 2022 11:04:05 -0700
Message-ID: <CAJnrk1ZzvocB8i5iBrbEQBFnbSw9ek423ps9uOmm4ahp5z3bVg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: kfunc support for ARG_PTR_TO_CONST_STR
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
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

On Mon, Jun 20, 2022 at 6:29 PM KP Singh <kpsingh@kernel.org> wrote:
>
> kfuncs can handle pointers to memory when the next argument is
> the size of the memory that can be read and verify these as
> ARG_CONST_SIZE_OR_ZERO
>
> Similarly add support for string constants (const char *) and
> verify it similar to ARG_PTR_TO_CONST_STR.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/btf.c             | 29 ++++++++++++
>  kernel/bpf/verifier.c        | 85 ++++++++++++++++++++----------------
>  3 files changed, 79 insertions(+), 37 deletions(-)
>
[...]
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 668ecf61649b..02d7951591ae 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6162,6 +6162,26 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
>         return true;
>  }
>
> +static bool btf_param_is_const_str_ptr(const struct btf *btf,
> +                                      const struct btf_param *param)
> +{
> +       const struct btf_type *t;
> +
> +       t = btf_type_by_id(btf, param->type);
> +       if (!btf_type_is_ptr(t))
> +               return false;
> +
> +       t = btf_type_by_id(btf, t->type);
> +       if (!(BTF_INFO_KIND(t->info) == BTF_KIND_CONST))
"if (BTF_INFO_KIND(t->info) != BTF_KIND_CONST)" looks clearer to me
> +               return false;
> +
> +       t = btf_type_skip_modifiers(btf, t->type, NULL);
> +       if (!strcmp(btf_name_by_offset(btf, t->name_off), "char"))
"return !strcmp(btf_name_by_offset(btf, t->name_off), "char")" looks
clearer to me here too
> +               return true;
> +
> +       return false;
> +}
> +
>  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>                                     const struct btf *btf, u32 func_id,
>                                     struct bpf_reg_state *regs,
> @@ -6344,6 +6364,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>                 } else if (ptr_to_mem_ok) {
>                         const struct btf_type *resolve_ret;
>                         u32 type_size;
> +                       int err;
>
>                         if (is_kfunc) {
>                                 bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> @@ -6354,6 +6375,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>                                  * When arg_mem_size is true, the pointer can be
>                                  * void *.
>                                  */
> +                               if (btf_param_is_const_str_ptr(btf, &args[i])) {
> +                                       err = check_const_str(env, reg, regno);
> +                                       if (err < 0)
> +                                               return err;
> +                                       i++;
> +                                       continue;
If I'm understanding it correctly, this patch is intended to allow
helper functions to take in a kfunc as an arg as long as the next arg
is the size of the memory. Do we need to check the memory size access
here (eg like a call to check_mem_size_reg() in the verifier) to
ensure that memory accesses of that size are safe?
> +                               }
> +
>                                 if (!btf_type_is_scalar(ref_t) &&
>                                     !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
>                                     (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2859901ffbe3..14a434792d7b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5840,6 +5840,52 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
>         return state->stack[spi].spilled_ptr.id;
>  }
[...]
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                           struct bpf_call_arg_meta *meta,
>                           const struct bpf_func_proto *fn)
> @@ -6074,44 +6120,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                         return err;
>                 err = check_ptr_alignment(env, reg, 0, size, true);
>         } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> -               struct bpf_map *map = reg->map_ptr;
> -               int map_off;
> -               u64 map_addr;
> -               char *str_ptr;
> -
> -               if (!bpf_map_is_rdonly(map)) {
> -                       verbose(env, "R%d does not point to a readonly map'\n", regno);
> -                       return -EACCES;
> -               }
> -
> -               if (!tnum_is_const(reg->var_off)) {
> -                       verbose(env, "R%d is not a constant address'\n", regno);
> -                       return -EACCES;
> -               }
> -
> -               if (!map->ops->map_direct_value_addr) {
> -                       verbose(env, "no direct value access support for this map type\n");
> -                       return -EACCES;
> -               }
> -
> -               err = check_map_access(env, regno, reg->off,
> -                                      map->value_size - reg->off, false,
> -                                      ACCESS_HELPER);
> -               if (err)
> -                       return err;
> -
> -               map_off = reg->off + reg->var_off.value;
> -               err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> -               if (err) {
> -                       verbose(env, "direct value access on string failed\n");
> +               err = check_const_str(env, reg, regno);
> +               if (err < 0)
>                         return err;
nit: I don't think you need the if check here since thsi function will
return err automatically in the next line

> -               }
> -
> -               str_ptr = (char *)(long)(map_addr);
> -               if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> -                       verbose(env, "string is not zero-terminated\n");
> -                       return -EINVAL;
> -               }
>         } else if (arg_type == ARG_PTR_TO_KPTR) {
>                 if (process_kptr_func(env, regno, meta))
>                         return -EACCES;
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
