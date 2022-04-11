Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5B04FC5AE
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 22:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiDKUW6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 16:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349833AbiDKUW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 16:22:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED034658
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 13:20:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j9so20572112lfe.9
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfxuQU6ZOSp9R4rmA4wOjsZy3hwyplVEIRku6u+qoXY=;
        b=Qn9RJLp3MZGvA4aW4SZ6BH+6G05ef8xTfH2ssBPI+qm1EtW9tulszcLuAXK22qT5vK
         +LWbSm+9KOInCxGMyLiGOozxpYj1M1YQWL8lEXdyGA3PR8hwAJdujVz0vJCTmKBBTSlV
         n8tzujwpx3/OjZFEndUirdojj1ddtW9aDHldwieQLEWynqp6aL45Nn1x6cm45sd6uZko
         QmZRojmzEJyVguH7zObSlpeOeIYRFMR7KS3RPK+OM5pBUfYwm4TboiR5jWiGf14oAiHI
         iEi1Dvd37eWar4hy/3Hqsns3jxMmpOjW2HB4911fP2E3q24IkZAE0BszPXcaZiZyaFtZ
         CFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfxuQU6ZOSp9R4rmA4wOjsZy3hwyplVEIRku6u+qoXY=;
        b=bdMxxfc2Xi3/8yLQ64arV44eoFjB8NsJ9atlAVySCDaRpfHLzOuUHhOBTCN63ree/Q
         f7tKC4jw68pjK99OBIdAXyw4OKKWfhHRS+L9eA47A8SpHF8IFA9vxCv29+ZGgoz/E2iQ
         KwuIZrZKibL/nde5cAPxhBLtJSEh0pP5ilap9VxYgvkTMEfHsiixSJDWjyXbKVH1nWdo
         XU6fKXgqXWKrl6blp8GGvkLoOyQwSUirvNR0hirJHgSOtjgRwhl7FBsXfjWKr8JewZE5
         kCsnXhr2bzyzyOSRVlZhD/TmQQQbFsHjE0YQ9xUr0bvrHWJmb3KY7Bq/5Vxgl9Nfeg59
         Ikog==
X-Gm-Message-State: AOAM5315rIoU1svlD7iCjzXc3fuJhLbc971IB3R6d5mw7wudc+vGaG0U
        bw9Z3bCxo3AmZ2hNazcbg7uLV6Lju06HJm6PIgJZk4F8t1k=
X-Google-Smtp-Source: ABdhPJzeCsu1Bj21uNBU0j5F3BiNa3BaJfjjgs01cMYEj/3LrPgc6Uggs8bb6z/o6YzYcxv1abSGIGAdlj9NvRVt0iA=
X-Received: by 2002:a05:6512:c18:b0:44a:9992:28bc with SMTP id
 z24-20020a0565120c1800b0044a999228bcmr23065565lfu.641.1649708439323; Mon, 11
 Apr 2022 13:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220409093303.499196-1-memxor@gmail.com> <20220409093303.499196-2-memxor@gmail.com>
In-Reply-To: <20220409093303.499196-2-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 11 Apr 2022 13:20:28 -0700
Message-ID: <CAJnrk1Z2tKHXxj1do31DfhZqBck21dSCEZhBCXOP9hkyOv1EpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/13] bpf: Make btf_find_field more generic
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Sat, Apr 9, 2022 at 2:32 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Next commit introduces field type 'kptr' whose kind will not be struct,
> but pointer, and it will not be limited to one offset, but multiple
> ones. Make existing btf_find_struct_field and btf_find_datasec_var
> functions amenable to use for finding kptrs in map value, by moving
> spin_lock and timer specific checks into their own function.
>
> The alignment, and name are checked before the function is called, so it
> is the last point where we can skip field or return an error before the
> next loop iteration happens. The name parameter is now optional, and
> only checked if it is not NULL. Size of the field and type is meant to
> be checked inside the function, and base type will need to be obtained
> by skipping modifiers.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/btf.c | 129 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 96 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0918a39279f6..db7bf05adfc5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3163,71 +3163,126 @@ static void btf_struct_log(struct btf_verifier_env *env,
>         btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
>  }
>
> +enum {
> +       BTF_FIELD_SPIN_LOCK,
> +       BTF_FIELD_TIMER,
> +};
> +
> +struct btf_field_info {
> +       u32 off;
> +};
> +
> +static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
> +                                u32 off, int sz, struct btf_field_info *info)
> +{
> +       if (!__btf_type_is_struct(t))
> +               return 0;
> +       if (t->size != sz)
> +               return 0;
Do we need these two checks? I think in the original version we did
because we were checking this before doing the name comparison, but
now that the name comparison check is first, if the struct name is a
match, then won't these two things always be true (or if not, then it
seems like we should return -EINVAL)? But maybe I'm missing something
here - I'm still getting more familiar with BTF :)

Also, as a side-note: I personally find this function name
"btf_find_field_struct" confusing since there's also the
"btf_find_struct_field" function that exists. I wonder whether we
should just keep the logic inside btf_find_struct_field instead of
putting it in this separate function?

> +       if (info->off != -ENOENT)
> +               /* only one such field is allowed */
> +               return -E2BIG;
In the future, do you plan to add support for multiple fields? I think
this would be useful for dynptrs as well, so just curious what your
plans for this are.
> +       info->off = off;
> +       return 0;
> +}
> +
>  static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
> -                                const char *name, int sz, int align)
> +                                const char *name, int sz, int align, int field_type,

What are your thoughts on just passing in field_type in place of name,
sz, and align? As in a function signature like:

static int btf_find_struct_field(const struct btf *btf, const struct
btf_type *t, int field_type, struct btf_field_info *info);

where inside btf_find_struct_field when we do the switch statement on
field_type, we can have the name, sz, and align for each of the
different field types there? That to me seems a bit cleaner where the
descriptors for the field types are all in one place (instead of also
in btf_find_spin_lock() and btf_find_timer() functions) and the
function definition for btf_find_struct_field is more straightforward.
At that point, I don't think we'd even need btf_find_spin_lock() and
btf_find_timer() as functions since it'd be just a straightforward
"btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK/BTF_FIELD_TIMER)" call
instead. Curious to hear your thoughts.

nit: should field_type be a u32 since it's an enum? Or should we be
explicit and give the enum a name and define this as something like
"enum btf_field_type type"?

> +                                struct btf_field_info *info)
>  {
>         const struct btf_member *member;
> -       u32 i, off = -ENOENT;
> +       u32 i, off;
> +       int ret;
>
>         for_each_member(i, t, member) {
>                 const struct btf_type *member_type = btf_type_by_id(btf,
>                                                                     member->type);
> -               if (!__btf_type_is_struct(member_type))
> -                       continue;
> -               if (member_type->size != sz)
> -                       continue;
> -               if (strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
> -                       continue;
> -               if (off != -ENOENT)
> -                       /* only one such field is allowed */
> -                       return -E2BIG;
> +
>                 off = __btf_member_bit_offset(t, member);
nit: should this be moved to after the strcmp on the name? Since if
the name doesn't match, there's no point in doing this
__btf_member_bit_offset call
> +
> +               if (name && strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
I'm confused by the if (name) part of the check. If name is NULL, then
won't this "btf_find_struct_field" function always return the offset
to the first struct? I don't think name will ever be NULL so maybe we
should just remove this? Or do something like if (name) return
-EINVAL; before doing the strcmp?

> +                       continue;
>                 if (off % 8)
>                         /* valid C code cannot generate such BTF */
>                         return -EINVAL;
>                 off /= 8;
>                 if (off % align)
>                         return -EINVAL;
> +
> +               switch (field_type) {
> +               case BTF_FIELD_SPIN_LOCK:
> +               case BTF_FIELD_TIMER:
> +                       ret = btf_find_field_struct(btf, member_type, off, sz, info);
nit: I think we can just do "return btf_find_field_struct(btf,
member_type, off, sz, info);" here and remove the "int ret;"
declaration a few lines above.

> +                       if (ret < 0)
> +                               return ret;
> +                       break;
> +               default:
> +                       return -EFAULT;
> +               }
>         }
> -       return off;
> +       return 0;
>  }
>
>  static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> -                               const char *name, int sz, int align)
> +                               const char *name, int sz, int align, int field_type,
> +                               struct btf_field_info *info)
The same comments for the btf_find_struct_field function also apply to
this function
>  {
>         const struct btf_var_secinfo *vsi;
> -       u32 i, off = -ENOENT;
> +       u32 i, off;
> +       int ret;
>
>         for_each_vsi(i, t, vsi) {
>                 const struct btf_type *var = btf_type_by_id(btf, vsi->type);
>                 const struct btf_type *var_type = btf_type_by_id(btf, var->type);
>
> -               if (!__btf_type_is_struct(var_type))
> -                       continue;
> -               if (var_type->size != sz)
> +               off = vsi->offset;
> +
> +               if (name && strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
>                         continue;
>                 if (vsi->size != sz)
>                         continue;
> -               if (strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
> -                       continue;
> -               if (off != -ENOENT)
> -                       /* only one such field is allowed */
> -                       return -E2BIG;
> -               off = vsi->offset;
>                 if (off % align)
>                         return -EINVAL;
> +
> +               switch (field_type) {
> +               case BTF_FIELD_SPIN_LOCK:
> +               case BTF_FIELD_TIMER:
> +                       ret = btf_find_field_struct(btf, var_type, off, sz, info);
> +                       if (ret < 0)
> +                               return ret;
> +                       break;
> +               default:
> +                       return -EFAULT;
> +               }
>         }
> -       return off;
> +       return 0;
>  }
>
>  static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> -                         const char *name, int sz, int align)
> +                         int field_type, struct btf_field_info *info)
>  {
> +       const char *name;
> +       int sz, align;
> +
> +       switch (field_type) {
> +       case BTF_FIELD_SPIN_LOCK:
> +               name = "bpf_spin_lock";
> +               sz = sizeof(struct bpf_spin_lock);
> +               align = __alignof__(struct bpf_spin_lock);
> +               break;
> +       case BTF_FIELD_TIMER:
> +               name = "bpf_timer";
> +               sz = sizeof(struct bpf_timer);
> +               align = __alignof__(struct bpf_timer);
> +               break;
> +       default:
> +               return -EFAULT;
> +       }
>
>         if (__btf_type_is_struct(t))
> -               return btf_find_struct_field(btf, t, name, sz, align);
> +               return btf_find_struct_field(btf, t, name, sz, align, field_type, info);
>         else if (btf_type_is_datasec(t))
> -               return btf_find_datasec_var(btf, t, name, sz, align);
> +               return btf_find_datasec_var(btf, t, name, sz, align, field_type, info);
>         return -EINVAL;
>  }
>
> @@ -3237,16 +3292,24 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
>   */
>  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
>  {
> -       return btf_find_field(btf, t, "bpf_spin_lock",
> -                             sizeof(struct bpf_spin_lock),
> -                             __alignof__(struct bpf_spin_lock));
> +       struct btf_field_info info = { .off = -ENOENT };
> +       int ret;
> +
> +       ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, &info);
I'm confused about why we pass in "struct btf_field_info" as the out
parameter. Maybe I'm missing something here, but why can't
"btf_find_field" just return back the offset?
> +       if (ret < 0)
> +               return ret;
> +       return info.off;
>  }
>
>  int btf_find_timer(const struct btf *btf, const struct btf_type *t)
>  {
> -       return btf_find_field(btf, t, "bpf_timer",
> -                             sizeof(struct bpf_timer),
> -                             __alignof__(struct bpf_timer));
> +       struct btf_field_info info = { .off = -ENOENT };
> +       int ret;
> +
> +       ret = btf_find_field(btf, t, BTF_FIELD_TIMER, &info);
> +       if (ret < 0)
> +               return ret;
> +       return info.off;
>  }
>
>  static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
> --
> 2.35.1
>
