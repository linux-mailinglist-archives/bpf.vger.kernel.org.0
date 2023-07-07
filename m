Return-Path: <bpf+bounces-4394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713874A9E0
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B371C20F2E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C95C1FAB;
	Fri,  7 Jul 2023 04:20:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D481876
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:20:58 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F49E
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:20:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fba74870abso2108618e87.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688703655; x=1691295655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SFajTxWzW8aCG8C22wep5wSeWb1fdNZ2/RG8fRVI4g=;
        b=Y5TqYhsljfNx4Xe/xNyuiJ9crrmTSxCPLdsZTifCqEVEMO+m9p9AkH7ZMnoS+H9XRl
         zyQumiLWSHXaEJzJld7Y7wX8jmF0n0DrLiGjQ57JXA7uyMqNzoiXwTByjbYQyADji+Z+
         5W34/z5JsHARTDbFNIg1msCuD8n/kqfw7iPgSQxhQQ/So9m9lxWSGClSYuY3ZGMEl87F
         ov0G7O7k+iVySmYIUjUrCerS5ao4UhEzcWeJVmky+wRGRggTJS4FQmH0EghLy/YjEZHq
         jCaZXo2W1qG8hQYMOB55qQ+i3JX7rbpeO1To+p0/LMOnzxEclm8cfddTfuUyLylS6ND0
         zKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688703655; x=1691295655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SFajTxWzW8aCG8C22wep5wSeWb1fdNZ2/RG8fRVI4g=;
        b=I1nQpbu1iwNxOn37QwoUYlEY+V64scWxrYfuUZFfSLCGq/sbwlRuwhnt1qoxaLGo7D
         ejMFOkOqpRbYPsIwLDMFq15Ufd6HYQLkq8TMLrU5fiGp3MaQEyIxPgN12kDbANkRjusD
         tv0GjnBduSJPVGfJPdD4nXz33uhElzGYR77KJQKh/xIvtPylogTY3mNuaxGajKZ31fSg
         58TjvwzxWfhFjiwP7MR9K2jqeZ4MMaZsk+GKQ9tTsK640Qt+uyBs1qJAz7IXpOD2+6F3
         bYh7cqzFsViokY4gb4cmoBqCkW7pJ7/2JF9RGGpCAaUwh34Ks8ysnj7VZWDhUaWKvof+
         rwsQ==
X-Gm-Message-State: ABy/qLaTR5RasHAPWdK8iwxSsOcxkAcSfyTuMx3GUZsa+ud6058Ihb0L
	lBPNE6zYLksw/fD/JPCAw5ofeGXUMi/As+lrXd0=
X-Google-Smtp-Source: APBJJlGvt5kCD7tgBecw3DkeXAZF+hcEqc/DpVOKdTqhG3jPpiPJEq3jvtZzlH8nFCYSfGV3CmclyO8laxp1PBJvOrQ=
X-Received: by 2002:ac2:4c4b:0:b0:4f8:72fd:ed95 with SMTP id
 o11-20020ac24c4b000000b004f872fded95mr3280518lfk.22.1688703654777; Thu, 06
 Jul 2023 21:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-16-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-16-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:20:42 -0700
Message-ID: <CAEf4BzZtmfxFrvvEG+7ZhsSnDGR20u+bjjbQsG5pn0zDQZC9yg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 15/26] libbpf: Add uprobe multi link detection
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe-multi link detection. It will be used later in
> bpf_program__attach_usdt function to check and use uprobe_multi
> link over standard uprobe links.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c          | 35 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  2 files changed, 37 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 06092b9752f1..4f61f9dc1748 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4817,6 +4817,38 @@ static int probe_perf_link(void)
>         return link_fd < 0 && err =3D=3D -EBADF;
>  }
>
> +static int probe_uprobe_multi_link(void)
> +{
> +       LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
> +               .expected_attach_type =3D BPF_TRACE_UPROBE_MULTI,
> +       );
> +       LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> +       struct bpf_insn insns[] =3D {
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       unsigned long offset =3D 0;
> +       int prog_fd, link_fd;
> +
> +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
> +                               insns, ARRAY_SIZE(insns), &load_opts);
> +       if (prog_fd < 0)
> +               return -errno;
> +
> +       /* create single uprobe on offset 0 in current process */
> +       link_opts.uprobe_multi.path =3D "/proc/self/exe";
> +       link_opts.uprobe_multi.offsets =3D &offset;
> +       link_opts.uprobe_multi.cnt =3D 1;
> +
> +       link_fd =3D bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, =
&link_opts);
> +

so I'd like us to avoid successfully attaching anything. This might
have unintended consequences (e.g., unintentionally breaking backing
huge pages into normal pages, just because we happen to successfully
attach briefly). So let's work on feature detection that fails to
create a link, but does it in a way that we know that the feature
itself is supported by the kernel

Some ideas we could do:

1. Pass invalid file (e.g., just root, "/" as path), but modify
kernel-side logic to return not -EINVAL, but -EBADF (and I think it
would be good to do this anyway). Then expect -EBADF as a signal that
the feature is supported.

2. Also, we can return -EPROTO instead of -EINVAL on invalid
combination of paramers or something like that

I'd start with -EBADF change.

In general, we should write kernel-side code in such a way that allows
simple and efficient feature-detection. We shouldn't repeat the
nightmare of memcg-based mem accounting :(

> +       if (link_fd >=3D 0)
> +               close(link_fd);
> +       close(prog_fd);
> +
> +       return link_fd >=3D 0;
> +}
> +
>  static int probe_kern_bpf_cookie(void)
>  {
>         struct bpf_insn insns[] =3D {
> @@ -4913,6 +4945,9 @@ static struct kern_feature_desc {
>         [FEAT_SYSCALL_WRAPPER] =3D {
>                 "Kernel using syscall wrapper", probe_kern_syscall_wrappe=
r,
>         },
> +       [FEAT_UPROBE_MULTI_LINK] =3D {
> +               "BPF uprobe multi link support", probe_uprobe_multi_link,

nit: BPF multi-uprobe link support

> +       },
>  };
>
>  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 7d75b92e531a..9c04b3fe1207 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -354,6 +354,8 @@ enum kern_feature_id {
>         FEAT_BTF_ENUM64,
>         /* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPPER) =
*/
>         FEAT_SYSCALL_WRAPPER,
> +       /* BPF uprobe_multi link support */

same, multi-uprobe link support



> +       FEAT_UPROBE_MULTI_LINK,
>         __FEAT_CNT,
>  };
>
> --
> 2.41.0
>

