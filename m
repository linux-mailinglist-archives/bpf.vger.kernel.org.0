Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8EE6EFA8C
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjDZTA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDZTA0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:00:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFEAE46
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:00:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-959a626b622so656814966b.0
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682535623; x=1685127623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNiWafIPn2IjbxCCkejn4x2B+QmJ6q7Zckp96FKqAro=;
        b=igFGNIDSUlzlZvFt7cjgXzxaOgZf0gvOyfchRUKvsu5OrJgawppOwIXfsOPa+g2f7T
         gwrokfOSNMOXhyBxF1uoB+zSA/HgJowr83gIUgkxwDimROOSpqYRrhAA1uK+TAApkrY+
         NThYG+s+cpNSZ/j78fCshGiLQNuAKSd8bVes+5mgvGtlau1KtsyR1B9YwZm0Ull8uNTh
         nFs0h+DAe7rSfH6e+UBm16vdo119QvddTN0FWan1ZX4/yn1UVErM8LRAtB6prg+ZYYeD
         fLhYb0HsmkwtpqPzMCXDvCyyDJpx0pQQg/rZrq1FM9uz/w1E3zfabHyfrdnZ80J3ctQ7
         7E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682535623; x=1685127623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNiWafIPn2IjbxCCkejn4x2B+QmJ6q7Zckp96FKqAro=;
        b=f+263OX/zcjWENfbhaYCGpG1Sy7gJvE2+6R6MwpUonX9P+FpN13WZUj5mFeEd0zHpU
         j7N1QlviS/cjYg7tSAOV9x/XQW5LzrM2qnhY2zsuj/m9oRPcXtIawBXl9L3mUtUA59By
         0gHOknEXEWxjAK1jovTDehy/9ykPwbwloG2vu0S792MuQAD+LfEBUEX70Wj43uKIXVtA
         mHrSJrgxP9yIp+ZEyLOBjWw6ZKUgjpzLZUH8i/rhpY7gOhb8VnnevdUQ4w5EiJNSa25g
         7B5jwpSOQtvkM2kUohurtaMDjEjBfAZcneWh/1FYPBR5YLSa1P7V5fFxrqWfc72CjR9f
         R2vg==
X-Gm-Message-State: AAQBX9e3U6dxzKBmtdigb+eV5JcELUCcsa9fsIFExRU6o5bB8Lom0H5z
        OdzWGA2MC3jERlhFvs76YDt+DEjruW69L80y08ECQmdz
X-Google-Smtp-Source: AKy350ZAAqfGz6ZG0VdhvCcY+Kq9T0JFXskSb4/MJGfQM1AiE0Lq4yceWXzwso4GsjMmxIsLllSZRlyPdaCJCQHUIgo=
X-Received: by 2002:a17:906:2897:b0:94e:e092:6eda with SMTP id
 o23-20020a170906289700b0094ee0926edamr18095696ejd.53.1682535623347; Wed, 26
 Apr 2023 12:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-2-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:00:10 -0700
Message-ID: <CAEf4BzZ1C488vfg=Nvqv6wGhm7TEHdG9YEjaEBExYHCLML54cg@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 9:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new multi uprobe link that allows to attach bpf program
> to multiple uprobes.
>
> Uprobes to attach are specified via new link_create uprobe_multi
> union:
>
>   struct {
>           __u32           flags;
>           __u32           cnt;
>           __aligned_u64   paths;
>           __aligned_u64   offsets;
>           __aligned_u64   ref_ctr_offsets;
>   } uprobe_multi;
>
> Uprobes are defined in paths/offsets/ref_ctr_offsets arrays with
> the same 'cnt' length. Each uprobe is defined with a single index
> in all three arrays:
>
>   paths[idx], offsets[idx] and/or ref_ctr_offsets[idx]
>
> The 'flags' supports single bit for now that marks the uprobe as
> return probe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/trace_events.h |   6 +
>  include/uapi/linux/bpf.h     |  14 +++
>  kernel/bpf/syscall.c         |  16 ++-
>  kernel/trace/bpf_trace.c     | 231 +++++++++++++++++++++++++++++++++++
>  4 files changed, 265 insertions(+), 2 deletions(-)
>

[...]

> @@ -4666,10 +4667,21 @@ static int link_create(union bpf_attr *attr, bpfp=
tr_t uattr)
>                 ret =3D bpf_perf_link_attach(attr, prog);
>                 break;
>         case BPF_PROG_TYPE_KPROBE:
> +               /* Ensure that program with eBPF_TRACE_UPROBE_MULTI attac=
h type can

eBPF_TRACE_UPROBE_MULTI :)

> +                * attach only to uprobe_multi link. It has its own runti=
me context
> +                * which is specific for get_func_ip/get_attach_cookie he=
lpers.
> +                */
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MU=
LTI &&
> +                   attr->link_create.attach_type !=3D BPF_TRACE_UPROBE_M=
ULTI) {
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }

as Yonghong pointed out, you check this condition in
bpf_uprobe_multi_link_attach() already, so why redundant check?

>                 if (attr->link_create.attach_type =3D=3D BPF_PERF_EVENT)
>                         ret =3D bpf_perf_link_attach(attr, prog);
> -               else
> +               else if (attr->link_create.attach_type =3D=3D BPF_TRACE_K=
PROBE_MULTI)
>                         ret =3D bpf_kprobe_multi_link_attach(attr, prog);
> +               else if (attr->link_create.attach_type =3D=3D BPF_TRACE_U=
PROBE_MULTI)
> +                       ret =3D bpf_uprobe_multi_link_attach(attr, prog);
>                 break;
>         default:
>                 ret =3D -EINVAL;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index bcf91bc7bf71..b84a7d01abf4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -23,6 +23,7 @@
>  #include <linux/sort.h>
>  #include <linux/key.h>
>  #include <linux/verification.h>
> +#include <linux/namei.h>
>
>  #include <net/bpf_sk_storage.h>
>
> @@ -2901,3 +2902,233 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_r=
un_ctx *ctx)
>         return 0;
>  }
>  #endif
> +
> +#ifdef CONFIG_UPROBES
> +struct bpf_uprobe_multi_link;
> +
> +struct bpf_uprobe {
> +       struct bpf_uprobe_multi_link *link;
> +       struct inode *inode;
> +       loff_t offset;
> +       loff_t ref_ctr_offset;

you seem to need this only during link creation, so we are wasting 8
bytes here per each instance of bpf_uprobe for no good reason? You
should be able to easily move this out of bpf_uprobe into a temporary
array.

> +       struct uprobe_consumer consumer;
> +};
> +
> +struct bpf_uprobe_multi_link {
> +       struct bpf_link link;
> +       u32 cnt;
> +       struct bpf_uprobe *uprobes;
> +};
> +

[...]

> +       if (prog->expected_attach_type !=3D BPF_TRACE_UPROBE_MULTI)
> +               return -EINVAL;
> +
> +       flags =3D attr->link_create.uprobe_multi.flags;
> +       if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
> +               return -EINVAL;
> +
> +       upaths =3D u64_to_user_ptr(attr->link_create.uprobe_multi.paths);
> +       uoffsets =3D u64_to_user_ptr(attr->link_create.uprobe_multi.offse=
ts);
> +       if (!!upaths !=3D !!uoffsets)
> +               return -EINVAL;

when having these as NULL would be ok? cnt =3D=3D 0? or is there some
valid situation?

> +
> +       uref_ctr_offsets =3D u64_to_user_ptr(attr->link_create.uprobe_mul=
ti.ref_ctr_offsets);

if upaths is NULL, uref_ctr_offsets should be NULL as well?

> +
> +       cnt =3D attr->link_create.uprobe_multi.cnt;
> +       if (!cnt)
> +               return -EINVAL;
> +
> +       uprobes =3D kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> +       if (!uprobes)
> +               return -ENOMEM;
> +

[...]
