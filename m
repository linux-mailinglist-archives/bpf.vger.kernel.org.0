Return-Path: <bpf+bounces-3312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAACE73C095
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F87281DCE
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4011CAB;
	Fri, 23 Jun 2023 20:41:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1911C80
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 20:41:02 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FEE30E0
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa7eb35a13so8233825e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687552822; x=1690144822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAInyVb8oldt7b3iVyJ3AYnbTwWIh/SMH0yry1INRU0=;
        b=BDYnwb9Rj6P/Fj/mSXp54CzomEtKe5F/y1ul43xqMPo47LB2Ff4dCZA45gtJ+B4lHP
         hz27LUWrFr8Bp6gI3IL6j8v0mr+FfBgzW9H3fE7Va759tYTbFFhVyIetalBrP3xZmmai
         wT2kVLd7nuwlPhjq1TBPhOYGBfkYIbQg785JmcAceE75JGbtp57Go+IUPFOyaL8aMjul
         JLEr5360OoxFue70ndJ7CcqxsEYHuF3vnn7Equ5mqdvRrO54mwRaOvMWX9Dcd6cNCpvX
         reJm+xaiYC+gHswM6g6gnLI392vPxTyj/6RhBYRC8jnO09UxV2kb4s8i/HiwGEbaH7lC
         au/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552822; x=1690144822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAInyVb8oldt7b3iVyJ3AYnbTwWIh/SMH0yry1INRU0=;
        b=IM/Y1ddcNlx1upDqevs07TSL3v23yKZmHl2JrbwRHNTG8GopdU0Y0nPhOpaUf649FD
         +xgGpreOndNvfCtLg/QEUOqaCnwHxic6tx8BydKDQmOrCnoj9eOFjgmmevoXVNBlVy+m
         UQ60v298PrMv3OfjQ2/STvmLit5qXR2qdkp9ANvbGWUvapTfSI6zqgvuJjvgdXSIoy9p
         vawCsM5QaxlzQVhGZqXiqOV0igjN+2jxrSGXscqvudOYcytQVuTTTBIAzQXx5CKr9KvG
         D+IjTgwyGQdfS7VHzILjhKYYLa0o4vh3uMdP4ggEx7DP855PcrZYnMnpMqsldZw6+ww6
         wJuA==
X-Gm-Message-State: AC+VfDzE8ebJuPxKfgWPx31Fu0bWdbjuLKRVU6WF1FB+W0LXx2joHSzr
	x5WeOU31CG/6rlLzmPOY49HfpuiB0NJK2teG0VE=
X-Google-Smtp-Source: ACHHUZ5JMWxBOnM6qscz88KiR3sVPBMl+0cBqQ1fMbGYbE/5yrnEXc7bbvjDDWymmtwgv/ozCI48Q//vq/7ClHcZU9Q=
X-Received: by 2002:a1c:750a:0:b0:3f5:878:c0c2 with SMTP id
 o10-20020a1c750a000000b003f50878c0c2mr16083324wmc.3.1687552822171; Fri, 23
 Jun 2023 13:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-12-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-12-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 13:40:08 -0700
Message-ID: <CAEf4BzbqLTfBmGkogfVhTsunCvaX_VdNb46PqXAx8Sff1u_Ahg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 11/24] libbpf: Add bpf_program__attach_uprobe_multi_opts
 function
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 1:37=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding bpf_program__attach_uprobe_multi_opts function that
> allows to attach multiple uprobes with uprobe_multi link.
>
> The user can specify uprobes with direct arguments:
>
>   binary_path/func_pattern
>
> or with struct bpf_uprobe_multi_opts opts argument fields:
>
>   const char *path;
>   const char **syms;
>   const unsigned long *offsets;
>   const unsigned long *ref_ctr_offsets;
>
> User can specify 3 mutually exclusive set of incputs:

typo: inputs

>
>  1) use only binary_path/func_pattern aruments

typo: arguments

>
>  2) use only opts argument with allowed combinations of:
>     path/offsets/ref_ctr_offsets/cookies/cnt
>
>  3) use binary_path with allowed combinations of:
>     syms/offsets/ref_ctr_offsets/cookies/cnt
>

why do we need this duplication of binary_path and opts.path? same for
pid and opts.pid?

> Any other usage results in error.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c   | 131 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  31 +++++++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 163 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3e5c88caf5d5..d972cea4c658 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11402,6 +11402,137 @@ static int resolve_full_path(const char *file, =
char *result, size_t result_sz)
>         return -ENOENT;
>  }
>
> +struct bpf_link *
> +bpf_program__attach_uprobe_multi_opts(const struct bpf_program *prog,

let's call it just bpf_program__attach_uprobe_multi()

we should have done that with bpf_program__attach_kprobe_multi_opts()
as well. Generally, if the only variant of API is the one with opts,
then there is no point in adding "_opts" suffix to the API name, IMO


> +                                     pid_t pid,
> +                                     const char *binary_path,
> +                                     const char *func_pattern,
> +                                     const struct bpf_uprobe_multi_opts =
*opts)
> +{
> +       const unsigned long *ref_ctr_offsets =3D NULL, *offsets =3D NULL;
> +       LIBBPF_OPTS(bpf_link_create_opts, lopts);
> +       unsigned long *resolved_offsets =3D NULL;
> +       const char **resolved_symbols =3D NULL;
> +       int err =3D 0, link_fd, prog_fd;
> +       struct bpf_link *link =3D NULL;
> +       char errmsg[STRERR_BUFSIZE];
> +       const char *path, **syms;
> +       char full_path[PATH_MAX];
> +       const __u64 *cookies;
> +       bool has_pattern;
> +       bool retprobe;
> +       size_t cnt;
> +
> +       if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       path =3D OPTS_GET(opts, path, NULL);
> +       syms =3D OPTS_GET(opts, syms, NULL);
> +       offsets =3D OPTS_GET(opts, offsets, NULL);
> +       ref_ctr_offsets =3D OPTS_GET(opts, ref_ctr_offsets, NULL);
> +       cookies =3D OPTS_GET(opts, cookies, NULL);
> +       cnt =3D OPTS_GET(opts, cnt, 0);
> +
> +       /*
> +        * User can specify 3 mutually exclusive set of incputs:
> +        *
> +        * 1) use only binary_path/func_pattern aruments

same typos

> +        *
> +        * 2) use only opts argument with allowed combinations of:
> +        *    path/offsets/ref_ctr_offsets/cookies/cnt
> +        *
> +        * 3) use binary_path with allowed combinations of:
> +        *    syms/offsets/ref_ctr_offsets/cookies/cnt
> +        *
> +        * Any other usage results in error.
> +        */
> +


Looking at this part (sorry, I already trimmed reply before realizing
I want to comment on this):


+               err =3D elf_find_pattern_func_offset(binary_path, func_patt=
ern,
+                                                  &resolved_symbols,
&resolved_offsets,
+                                                  &cnt);
+               if (err < 0)
+                       return libbpf_err_ptr(err);
+               offsets =3D resolved_offsets;
+       } else if (syms) {
+               err =3D elf_find_multi_func_offset(binary_path, cnt,
syms, &resolved_offsets);

Few thoughts.

First, we are not using resolved_symbols returned from
elf_find_pattern_func_offset(), do we? If not, let's drop it.

Second, I'm not a big fan of chosen naming. Maybe something like
elf_resolve_{pattern,syms}_offsets?


[...]

> +error:
> +       free(resolved_offsets);
> +       free(resolved_symbols);
> +       free(link);
> +       return libbpf_err_ptr(err);
> +}
> +
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pi=
d,
>                                 const char *binary_path, size_t func_offs=
et,
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 754da73c643b..b6ff7d69a1d7 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -529,6 +529,37 @@ bpf_program__attach_kprobe_multi_opts(const struct b=
pf_program *prog,
>                                       const char *pattern,
>                                       const struct bpf_kprobe_multi_opts =
*opts);
>
> +struct bpf_uprobe_multi_opts {
> +       /* size of this struct, for forward/backward compatibility */
> +       size_t sz;
> +       /* path to attach */
> +       const char *path;

how is this different from binary_path? not clear why we need to paths

> +       /* array of function symbols to attach */
> +       const char **syms;
> +       /* array of function addresses to attach */
> +       const unsigned long *offsets;
> +       /* array of refctr offsets to attach */
> +       const unsigned long *ref_ctr_offsets;
> +       /* array of user-provided values fetchable through bpf_get_attach=
_cookie */
> +       const __u64 *cookies;
> +       /* number of elements in syms/addrs/cookies arrays */
> +       size_t cnt;
> +       /* create return uprobes */
> +       bool retprobe;
> +       /* pid filter */
> +       int pid;

another duplicate, we already pass pid argument


> +       size_t :0;
> +};
> +
> +#define bpf_uprobe_multi_opts__last_field pid
> +
> +LIBBPF_API struct bpf_link *
> +bpf_program__attach_uprobe_multi_opts(const struct bpf_program *prog,
> +                                     pid_t pid,
> +                                     const char *binary_path,
> +                                     const char *func_pattern,
> +                                     const struct bpf_uprobe_multi_opts =
*opts);
> +
>  struct bpf_ksyscall_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7521a2fb7626..81558ef1bc38 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -390,6 +390,7 @@ LIBBPF_1.2.0 {
>                 bpf_link_get_info_by_fd;
>                 bpf_map_get_info_by_fd;
>                 bpf_prog_get_info_by_fd;
> +               bpf_program__attach_uprobe_multi_opts;

should be in 1.3.0?

>  } LIBBPF_1.1.0;
>
>  LIBBPF_1.3.0 {


> --
> 2.41.0
>

