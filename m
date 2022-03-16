Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269124DA9D8
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 06:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348564AbiCPFaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 01:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243212AbiCPFaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 01:30:15 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A9333E29
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:28:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id l18so1207630ioj.2
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4ARQQuFqc/6t3iLmmkXreqXQ7Dgdxm1JmyYfMj+Eac=;
        b=B9BFWFNv1Fohb54Zcutmzr3LLWfiupUISBv3QjBFn2gxljCKzcFBytgx5aFeNNIE/E
         WWvPXqYAfgz3b+apQi/edZSOpp5AyEtEr2a/ly9bCL7nE2+HuwnJ+NHt2X9hD99N2AMy
         LgokxnQfFRyp8mDrNQ/ZZRtrmQf5rvt/v+arTstiRVLz4OpohdYySoIk8HCI/TnkiIvl
         BgZ1kyONCv6Td6zAUX6241X/Hego/VaVKNTnOmSiBj/8WzSxOFzAWfAumbZOij1+jDbh
         M+5F78yYGfaV0Gdxi/YPCCLR+a+13KrmJHkaHArxDhBHJ9mP6hDCPF+oKj8hGabEuc6g
         qNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4ARQQuFqc/6t3iLmmkXreqXQ7Dgdxm1JmyYfMj+Eac=;
        b=snTQhWu3774Nmz+q8l2Ws5NcRcksTArPuaZ1ZxPIwBHzkEvNxQQoydlt3/gr3p6xyI
         6f0OcBbz9UadG/+xX9y+NQRCANXPtUxqjmQ6GS6C9SaJzq0DJ8wQOUwuOq85CcDCl9pa
         D9Vo7K7LGPf4F9p+i5nJfWtRnx2YhuBAMwy3IHyECOzKJBipR9pHLcFbA3dFn7Yv0dF0
         yxkUICJoi//oZzsn5wr0eFSV7taQLvg9JNEoiQOvnnlyECtxuL/E7Fwn7sbxOyHdC4DC
         dX0tHB2+R+KbtcMZ8nqMhulECYHRbHhb2Z0/ppk7KQTGVCYkliWF1b977MOr9+sH4ZJv
         VXPg==
X-Gm-Message-State: AOAM53047ThivhNnACc101I4AgxWBZiHllQxXVYTIzRVn4urZ6V6kirC
        tgkTFuRYWLoOjo6X58Jm6P6sWTy2c6B2fFrrzv/EUV2SICc=
X-Google-Smtp-Source: ABdhPJzO046dmHfADKYU/OfMySAuXj6KScEHT1BdROd2fCbaET2Tm/e1G5S6x15y5Tnar28VN8hsRWdjSLt8XhzO8hw=
X-Received: by 2002:a05:6602:185a:b0:645:d914:35e9 with SMTP id
 d26-20020a056602185a00b00645d91435e9mr23424273ioi.154.1647408539009; Tue, 15
 Mar 2022 22:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647382072.git.delyank@fb.com> <efe839eb138d33cb7c6c9971ef79ce12d439753e.1647382072.git.delyank@fb.com>
In-Reply-To: <efe839eb138d33cb7c6c9971ef79ce12d439753e.1647382072.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 22:28:48 -0700
Message-ID: <CAEf4BzY29hy1BcDmgz=MRBn3PcXy+YzZ7qRX44HsH+dVKGMdhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] libbpf: add subskeleton scaffolding
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 3:15 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> In symmetry with bpf_object__open_skeleton(),
> bpf_object__open_subskeleton() performs the actual walking and linking
> of maps, progs, and globals described by bpf_*_skeleton objects.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/libbpf.c   | 136 +++++++++++++++++++++++++++++++++------
>  tools/lib/bpf/libbpf.h   |  29 +++++++++
>  tools/lib/bpf/libbpf.map |   2 +
>  3 files changed, 146 insertions(+), 21 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e98a8381aad8..dac905171aaf 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11812,6 +11812,49 @@ int libbpf_num_possible_cpus(void)
>         return tmp_cpus;
>  }
>

[...]

> +int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
> +{
> +       int err, len, var_idx, i;
> +       const char *var_name;
> +       const struct bpf_map *map;
> +       struct btf *btf;
> +       __u32 map_type_id;
> +       const struct btf_type *map_type, *var_type;
> +       const struct bpf_var_skeleton *var_skel;
> +       struct btf_var_secinfo *var;
> +
> +       if (!s->obj)
> +               return libbpf_err(-EINVAL);
> +
> +       btf = bpf_object__btf(s->obj);
> +       if (!btf)
> +               return libbpf_err(-errno);

can you please add an error message here that subskeletons expect
bpf_object to have BTF? Might be very confusing to users to understand
what's wrong if this happens

> +
> +       err = populate_skeleton_maps(s->obj, s->maps, s->map_cnt);
> +       if (err) {
> +               pr_warn("failed to populate subskeleton maps: %d\n", err);
> +               return libbpf_err(err);
>         }
>
> -       for (i = 0; i < s->prog_cnt; i++) {
> -               struct bpf_program **prog = s->progs[i].prog;
> -               const char *name = s->progs[i].name;
> +       err = populate_skeleton_progs(s->obj, s->progs, s->prog_cnt);
> +       if (err) {
> +               pr_warn("failed to populate subskeleton maps: %d\n", err);
> +               return libbpf_err(err);
> +       }
>
> -               *prog = bpf_object__find_program_by_name(obj, name);
> -               if (!*prog) {
> -                       pr_warn("failed to find skeleton program '%s'\n", name);
> -                       return libbpf_err(-ESRCH);
> +       for (var_idx = 0; var_idx < s->var_cnt; var_idx++) {
> +               var_skel = &s->vars[var_idx];
> +               map = *var_skel->map;
> +               map_type_id = bpf_map__btf_value_type_id(map);
> +               map_type = btf__type_by_id(btf, map_type_id);
> +
> +               if (!btf_is_datasec(map_type)) {
> +                       pr_warn("Type for map '%1$s' is not a datasec: %2$s",
> +                               bpf_map__name(map),
> +                               __btf_kind_str(btf_kind(map_type)));

nit: other messages in this function start with lower case, let's keep
it consistent. But I think this is very unlikely error, so I think it
would be fine without pr_warn() altogether (missing BTF above seems
more probable)

> +                       return libbpf_err(-EINVAL);
>                 }
> -       }
>
> +               len = btf_vlen(map_type);
> +               var = btf_var_secinfos(map_type);
> +               for (i = 0; i < len; i++, var++) {
> +                       var_type = btf__type_by_id(btf, var->type);
> +                       var_name = btf__name_by_offset(btf, var_type->name_off);
> +                       if (strcmp(var_name, var_skel->name) == 0) {
> +                               *var_skel->addr = map->mmaped + var->offset;
> +                               break;
> +                       }
> +               }
> +       }
>         return 0;
>  }
>

[...]
