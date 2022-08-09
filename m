Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06058D0F6
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 02:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiHIADE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 20:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiHIADE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 20:03:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6FB16590
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 17:03:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i14so19473860ejg.6
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 17:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AEDWWy2We22Dh2wfoNS245D1UmRnj+HRC1XYk4EGHpc=;
        b=g9DoMGj6qd1xJNI6dbvI3ajj+l8wZ9t302c4Uons/vZT/IZuiULyX2bbCYAp6OmYL6
         GoWxl+OQ3ALSWXgBpAEBSvRY8Eah4IB5zAH7UkrWruQ5dMHMqyaKTEd2f/e9VvgXzzTV
         14hk/34CDm3eb4Gzivo6xLT7MhbhUYiwJ/ygWP88Yc0SWxFajv8G+HjcF4sOImZYTlCg
         n+Pj+QIbhuu4j8/u4b5/cGQfk4TIj8lfv1uTDbSsTGFX6JaNsI2qRAYy/MkBpP65o93P
         08FQCaUpl8Nkj9DDP/2uHhqKXjaQ2FbC4WNEvl9nHs+soHytG6V52jF4wXp8YsrbbnC3
         8+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AEDWWy2We22Dh2wfoNS245D1UmRnj+HRC1XYk4EGHpc=;
        b=Dh0Yh6+ZPxQkBC/5y5s4e/5sVHUo6J3UqMaQdlu7G9JZ6FUc+6a5q5QQqxG/Ape2lt
         ME7C0FipPmx33SPm+qGyyKxQOAoCn2etGo2cITGrXmW4cZvYbjvBKMPq9H71yNu27+sl
         a3+5MZg0mGRujFSFzJNBofRt5i9AViCLpIzrQssYbcwYMGD9HvQcy6+FJnck9/ApnPtw
         ZvWl9qQRll+l97a3qhSR5nvkDqF0z+AIKxKXFc4Gzk1wcRiksc7LzIJ2t8jfXCwvsB6d
         PTatGsYgswCwVLXA1K2klOmhPTvEbkU/321J/U2S7elazhUd4A/UVP4s1RxRuBfEfJXt
         U34A==
X-Gm-Message-State: ACgBeo2rGaFzuvaicQ4xDV2GcUvddCxHldQe5Q6RsfLtkucUr0FBUs3w
        FOd9hFAzI7azWZXwQUJ9jtAU6t7ttKJN+nUN0w8=
X-Google-Smtp-Source: AA6agR56c351cz+ERmoVkeAEPaanV+Lx3HKIr4Agq3czyUQQWdgQu+GSPlYqomfyWfJSZdBngcWouKBTNTZFLBO1gjQ=
X-Received: by 2002:a17:907:6e22:b0:731:152:2504 with SMTP id
 sd34-20020a1709076e2200b0073101522504mr11717534ejc.545.1660003381870; Mon, 08
 Aug 2022 17:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220726171129.708371-1-yhs@fb.com> <20220726171140.710070-1-yhs@fb.com>
In-Reply-To: <20220726171140.710070-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Aug 2022 17:02:50 -0700
Message-ID: <CAEf4Bza1TfpRSZa48Y9zJEi+VBTo9Y7u2YmtEYQZSOnuyJRiHA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/7] bpf: Add struct argument info in btf_func_model
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
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

On Tue, Jul 26, 2022 at 10:11 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add struct argument information in btf_func_model and such information
> will be used in arch specific function arch_prepare_bpf_trampoline()
> to prepare argument access properly in trampoline.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 20c26aed7896..173b42cf3940 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -726,10 +726,19 @@ enum bpf_cgroup_storage_type {
>   */
>  #define MAX_BPF_FUNC_REG_ARGS 5
>
> +/* The maximum number of struct arguments a single function may have. */
> +#define MAX_BPF_FUNC_STRUCT_ARGS 2
> +
>  struct btf_func_model {
>         u8 ret_size;
>         u8 nr_args;
>         u8 arg_size[MAX_BPF_FUNC_ARGS];
> +       /* The struct_arg_idx should be in increasing order like (0, 2, ...).
> +        * The struct_arg_bsize encodes the struct field byte size
> +        * for the corresponding struct argument index.
> +        */
> +       u8 struct_arg_idx[MAX_BPF_FUNC_STRUCT_ARGS];
> +       u8 struct_arg_bsize[MAX_BPF_FUNC_STRUCT_ARGS];

Few questions here. It might be a bad idea, but I thought I'd bring it
up anyway.

So, is there any benefit into having these separate struct_arg_idx and
struct_arg_bsize fields and then processing arg_size completely
separate from struct_arg_idx/struct_arg_bsize in patch #4? Reading
patch #4 it felt like it would be much easier to keep track of things
if we had a single loop going over all the arguments, and then if some
argument is a struct -- do some extra step to copy up to 16 bytes onto
stack and store the pointer there (and skip up to one extra argument).
And if it's not a struct arg -- do what we do right now.

What if instead we keep btf_func_mode definition as is, but for struct
argument we add extra flag to arg_size[struct_arg_idx] value to mark
that it is a struct argument. This limits arg_size to 128 bytes, but I
think it's more than enough for both struct and non-struct cases,
right? Distill function would make sure that nr_args matches number of
logical arguments and not number of registers.

Would that work? Would that make anything harder to implement in
arch-specific code? I don't see what, but I haven't grokked all the
details of patch #4, so I'm sorry if I missed something obvious. The
way I see it, it will make overall logic for saving/restoring
registers more uniform, roughly:

for (int arg_idx = 0; arg_idx < model->arg_size; arg_idx++) {
  if (arg & BTF_FMODEL_STRUCT_ARG) {
    /* handle struct, calc extra registers "consumed" from
arg_size[arg_idx] ~BTF_FMODEL_STRUCT_ARG */
  } else {
    /* just a normal register */
  }
}


If we do stick to current approach, though, let's please
s/struct_arg_bsize/struct_arg_size/. Isn't arg_size also and already
in bytes? It will keep naming and meaning consistent across struct and
non-struct args.

BTW, by not having btf_func_model encode register indices in
struct_arg_idx we keep btf_func_model pretty architecture-agnostic,
right? It will be per each architecture specific implementation to
perform mapping this *model* into actual registers used?




>  };
>
>  /* Restore arguments before returning from trampoline to let original function
> --
> 2.30.2
>
