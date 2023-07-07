Return-Path: <bpf+bounces-4391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7574A9A5
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A256A1C20EC6
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986A1C37;
	Fri,  7 Jul 2023 04:05:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D1210F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:05:39 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB41FD7
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:05:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so4348775e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688702736; x=1691294736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX2rf4XjjA99AIFt/eshyYB4VAfp8oFrPDdMrzjW0FE=;
        b=XfRj0WRwKGa5jGdOA9/vluYWHuFMkfjX3ITFgG+mzR5HEV7MzVpv4AQ9Ldd66zk+Od
         n+9fJrcbXe8TuiI2MBMM/f82eX+CSxzXogLPDNc2lxFHS7xKeBixZAq8XkvCx71eGo0P
         tXCSbYyGkGSQ02Wp3/a/krJOaatXm1fqWgq5blR9q5YpNkXdCgSzw6U49e9sp9G3i7PP
         ZYDE8vr/M9ek68bT03ljwqPDCE8BrGWnMvMhumu0Yw0FgL0ouJEJX+rfTMsC8sJj/tGp
         sb1wSfR/mzUeGT2Lk+JIA+xYCnfhBveyLrIRShPllmYyxyqVrO/yNBsmOoSmEQk8c3uv
         OZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688702736; x=1691294736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JX2rf4XjjA99AIFt/eshyYB4VAfp8oFrPDdMrzjW0FE=;
        b=kZzdMLbFnQu7gYvfy/QxtjvczujE9yvYMlQ4Y7nA2aP0k4gU4TJTCTCNENeWRHpqsW
         FomfeKH61EADdwO6WXNbdywsX2yEjTJWmVmOX67SbsAkR2qJAkBlT40Xa6ob3LWuhbcW
         Qf3OAWxBlmB75wishw3oiE49C920qfLuB6S+g3+0Az4XdB+krGmAD7cVPmBvvubfQqYV
         kkbKGEkKhGZZF4bJoXHNyHYCjRLSVhqK2mP3o49vOa+KnOcw4yAhpmxgyxrMG1v9o+/p
         di9wIm/k2z62rJruWKBIEEapnEiHw4XyWynXB6Np67Isb/xtiHLS+OyUX+bPz25sm9fQ
         CKMw==
X-Gm-Message-State: ABy/qLbV4Xaxs2u1ba58VtguBXzOJu7W56uKTduAdJWr9VDV2XAmdvIR
	kwHNaiPfpDKXUaKy73tLKEYDOl06U5mJZ/PIv+A=
X-Google-Smtp-Source: APBJJlGakmObasvuyza++KrVF6o5w68AXjZZuI9lTTJ8FUKzXrIOToG7HZ0lSGZmbIG+5CMEPiE0ZybnCdCeGwymGqk=
X-Received: by 2002:a05:600c:519a:b0:3fb:b18a:f32d with SMTP id
 fa26-20020a05600c519a00b003fbb18af32dmr6787244wmb.17.1688702735902; Thu, 06
 Jul 2023 21:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-14-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-14-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:05:23 -0700
Message-ID: <CAEf4Bza16nwKNkktW+r-5OoCsAtPhMkRLedWdrQo+2WDvOR8xA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 13/26] libbpf: Add bpf_program__attach_uprobe_multi
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

On Fri, Jun 30, 2023 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding bpf_program__attach_uprobe_multi function that
> allows to attach multiple uprobes with uprobe_multi link.
>
> The user can specify uprobes with direct arguments:
>
>   binary_path/func_pattern/pid
>
> or with struct bpf_uprobe_multi_opts opts argument fields:
>
>   const char **syms;
>   const unsigned long *offsets;
>   const unsigned long *ref_ctr_offsets;
>   const __u64 *cookies;
>
> User can specify 2 mutually exclusive set of inputs:
>
>  1) use only path/func_pattern/pid arguments
>
>  2) use path/pid with allowed combinations of:
>     syms/offsets/ref_ctr_offsets/cookies/cnt
>
>     - syms and offsets are mutually exclusive
>     - ref_ctr_offsets and cookies are optional
>
> Any other usage results in error.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c   | 122 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  27 +++++++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 150 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f33ef7cb1adc..b942f248038e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10954,6 +10954,128 @@ static int resolve_full_path(const char *file, =
char *result, size_t result_sz)
>         return -ENOENT;
>  }
>
> +struct bpf_link *
> +bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
> +                                pid_t pid,
> +                                const char *path,
> +                                const char *func_pattern,
> +                                const struct bpf_uprobe_multi_opts *opts=
)
> +{
> +       const unsigned long *ref_ctr_offsets =3D NULL, *offsets =3D NULL;
> +       LIBBPF_OPTS(bpf_link_create_opts, lopts);
> +       unsigned long *resolved_offsets =3D NULL;
> +       int err =3D 0, link_fd, prog_fd;
> +       struct bpf_link *link =3D NULL;
> +       char errmsg[STRERR_BUFSIZE];
> +       char full_path[PATH_MAX];
> +       const __u64 *cookies;
> +       const char **syms;
> +       bool has_pattern;
> +       bool retprobe;
> +       size_t cnt;
> +
> +       if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       syms =3D OPTS_GET(opts, syms, NULL);
> +       offsets =3D OPTS_GET(opts, offsets, NULL);
> +       ref_ctr_offsets =3D OPTS_GET(opts, ref_ctr_offsets, NULL);
> +       cookies =3D OPTS_GET(opts, cookies, NULL);
> +       cnt =3D OPTS_GET(opts, cnt, 0);
> +
> +       /*
> +        * User can specify 2 mutually exclusive set of inputs:
> +        *
> +        * 1) use only path/func_pattern/pid arguments
> +        *
> +        * 2) use path/pid with allowed combinations of:
> +        *    syms/offsets/ref_ctr_offsets/cookies/cnt
> +        *
> +        *    - syms and offsets are mutually exclusive
> +        *    - ref_ctr_offsets and cookies are optional
> +        *
> +        * Any other usage results in error.
> +        */
> +
> +       if (!path && !func_pattern && !cnt)

weird, I'd expect separate if (!path) return error (already bad,
regardless of func_pattern or cnt)

then if (!func_pattern && cnt =3D=3D 0) return error

> +               return libbpf_err_ptr(-EINVAL);
> +       if (func_pattern && !path)
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       has_pattern =3D path && func_pattern;

this and above check must be some leftovers from previous version.
path should always be present. and so you don't need has_pattern
variable, just use "func_pattern" check

> +
> +       if (has_pattern) {
> +               if (syms || offsets || ref_ctr_offsets || cookies || cnt)
> +                       return libbpf_err_ptr(-EINVAL);
> +       } else {
> +               if (!cnt)
> +                       return libbpf_err_ptr(-EINVAL);
> +               if (!!syms =3D=3D !!offsets)
> +                       return libbpf_err_ptr(-EINVAL);
> +       }
> +
> +       if (has_pattern) {
> +               if (!strchr(path, '/')) {
> +                       err =3D resolve_full_path(path, full_path, sizeof=
(full_path));
> +                       if (err) {
> +                               pr_warn("prog '%s': failed to resolve ful=
l path for '%s': %d\n",
> +                                       prog->name, path, err);
> +                               return libbpf_err_ptr(err);
> +                       }
> +                       path =3D full_path;
> +               }
> +
> +               err =3D elf_resolve_pattern_offsets(path, func_pattern,
> +                                                 &resolved_offsets, &cnt=
);
> +               if (err < 0)
> +                       return libbpf_err_ptr(err);
> +               offsets =3D resolved_offsets;
> +       } else if (syms) {
> +               err =3D elf_resolve_syms_offsets(path, cnt, syms, &resolv=
ed_offsets);
> +               if (err < 0)
> +                       return libbpf_err_ptr(err);
> +               offsets =3D resolved_offsets;

you can extract this common error checking and `offsets =3D
resolved_offsets;` to after if, it's common for both branches
> +       }
> +
> +       retprobe =3D OPTS_GET(opts, retprobe, false);
> +
> +       lopts.uprobe_multi.path =3D path;
> +       lopts.uprobe_multi.offsets =3D offsets;
> +       lopts.uprobe_multi.ref_ctr_offsets =3D ref_ctr_offsets;
> +       lopts.uprobe_multi.cookies =3D cookies;
> +       lopts.uprobe_multi.cnt =3D cnt;
> +       lopts.uprobe_multi.flags =3D retprobe ? BPF_F_UPROBE_MULTI_RETURN=
 : 0;

retprobe is another unnecessary var, just inline check here to keep it simp=
ler

> +
> +       if (pid =3D=3D 0)
> +               pid =3D getpid();
> +       if (pid > 0)
> +               lopts.uprobe_multi.pid =3D pid;
> +
> +       link =3D calloc(1, sizeof(*link));
> +       if (!link) {
> +               err =3D -ENOMEM;
> +               goto error;
> +       }
> +       link->detach =3D &bpf_link__detach_fd;
> +
> +       prog_fd =3D bpf_program__fd(prog);
> +       link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &=
lopts);
> +       if (link_fd < 0) {
> +               err =3D -errno;
> +               pr_warn("prog '%s': failed to attach: %s\n",

"failed to attach multi-uprobe"? We probably should have added "failed
to attach multi-kprobe" in bpf_program__attach_kprobe_multi_opts as
well?

> +                       prog->name, libbpf_strerror_r(err, errmsg, sizeof=
(errmsg)));
> +               goto error;
> +       }
> +       link->fd =3D link_fd;
> +       free(resolved_offsets);
> +       return link;
> +
> +error:
> +       free(resolved_offsets);
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
> index 754da73c643b..7c218f610210 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -529,6 +529,33 @@ bpf_program__attach_kprobe_multi_opts(const struct b=
pf_program *prog,
>                                       const char *pattern,
>                                       const struct bpf_kprobe_multi_opts =
*opts);
>
> +struct bpf_uprobe_multi_opts {
> +       /* size of this struct, for forward/backward compatibility */
> +       size_t sz;
> +       /* array of function symbols to attach */

attach to?

> +       const char **syms;
> +       /* array of function addresses to attach */

attach to?

> +       const unsigned long *offsets;
> +       /* array of refctr offsets to attach */

we don't really attach to ref counters, so maybe "optional, array of
associated ref counter offsets" or something along those lines ?

> +       const unsigned long *ref_ctr_offsets;
> +       /* array of user-provided values fetchable through bpf_get_attach=
_cookie */

"array of associated BPF cookies"? we can't keep explaining what BPF
cookie is in every possible API :)

> +       const __u64 *cookies;
> +       /* number of elements in syms/addrs/cookies arrays */
> +       size_t cnt;
> +       /* create return uprobes */
> +       bool retprobe;
> +       size_t :0;
> +};
> +
> +#define bpf_uprobe_multi_opts__last_field retprobe
> +
> +LIBBPF_API struct bpf_link *
> +bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
> +                                pid_t pid,
> +                                const char *binary_path,
> +                                const char *func_pattern,
> +                                const struct bpf_uprobe_multi_opts *opts=
);
> +

ok, let's be good citizens and add documentation for this new API.
Those comments about valid combinations belong here as well. Please
take a look at existing doccomments for the format and conventions.
Thanks!

>  struct bpf_ksyscall_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7521a2fb7626..d8d11ea6c35e 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -395,4 +395,5 @@ LIBBPF_1.2.0 {
>  LIBBPF_1.3.0 {
>         global:
>                 bpf_obj_pin_opts;
> +               bpf_program__attach_uprobe_multi;
>  } LIBBPF_1.2.0;
> --
> 2.41.0
>

