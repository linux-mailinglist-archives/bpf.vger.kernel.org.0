Return-Path: <bpf+bounces-4392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CAC74A9B7
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC77B281658
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAD51FA7;
	Fri,  7 Jul 2023 04:08:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7631876
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:08:34 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7E42D56
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:08:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbf1b82dc7so15190295e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688702877; x=1691294877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NKzEFkavK14Q6pD1V76LbCK4Byd40KDZn0ndwZx9/Y=;
        b=rCgylFgvA2XS5L/6zTACZbZsOubonEZ1tG88Or1tL3y8yqvqM5lQwhmcz/Z2ElUEfx
         rjfNJnYsy9MtsLAPcbGDuZR2Y9Ptis9AO3chQqpBNSWZQDeb9XjX5IXj09/1xfTDvOl9
         B0mi7eFo5fNTxgJ8hDCL7S97QjwTUSYR/0xEjksag977cU5MXULeN0fWrkkfTVmsm4/K
         Bio8ckOc4lIBtPIrR/D2el04rltN+rntE14IlRh3nZ/0Dr6Ja9FOotBRfeGf9hNiIL1k
         ZyglKXeq18gCToZcu9/QN7XkQg+lXL23PFrfXOYBnRUXBdJomOyLQBx/5YXPqy9H9GDK
         QwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688702877; x=1691294877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NKzEFkavK14Q6pD1V76LbCK4Byd40KDZn0ndwZx9/Y=;
        b=OUIMAKjN1QmzVxNdh3GzBmw9jvrmKyrSrWfB08unsIyRQ36FPZIhd2AqeihPkx3ZC8
         3DGJp9MX+0CekTdOd7IAIa41nQjrcn+oj6oUHJJ9Q/1UKpY1/RojDR4qV0XrsHx9fFmY
         mT6UFUsC95LKk1ZfKW1f/nVgI4ReFNG/as2ZHyRfddJ9Ed7nw0hhTmEqle3GLk69Vjb7
         7nZwkJX7k2SAZUQBh083Z9Dph6GgXlfCSVzgyqluJsCxx/OhosRB4cJyv1bti8TFXw+Q
         PXjnUyW2dRdg8sBmpgcG9icHdvBW5ml1zr72zwGYJvf7rWSuBaPNy82wKWcR9OJeGn2A
         JhuA==
X-Gm-Message-State: ABy/qLYNCDRrAdreNMoei/K2wFIDFH/FsbKKuqBlyBitdZBo7dDORWE6
	kzHbN6ni80IxZx0kcK691tkVuFODxZgeuGQCfpQ=
X-Google-Smtp-Source: APBJJlETbxvOQF4XogTSNHJ9oYjwTiKwSj0u4BGQtBKQhle4pFXVe0SEEEo9CjTC1Z4nm3q0EPny/4IkggBSYC22ElM=
X-Received: by 2002:a05:600c:230b:b0:3fb:b3aa:1c8f with SMTP id
 11-20020a05600c230b00b003fbb3aa1c8fmr2772671wmo.28.1688702877180; Thu, 06 Jul
 2023 21:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-15-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-15-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:07:45 -0700
Message-ID: <CAEf4BzbRfSGJLeFAB5wD+grJCz-F=MtK9dvnJPtDKwp48m-5BQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 14/26] libbpf: Add support for
 u[ret]probe.multi[.s] program sections
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
> Adding support for several uprobe_multi program sections
> to allow auto attach of multi_uprobe programs.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b942f248038e..06092b9752f1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8654,6 +8654,7 @@ static int attach_tp(const struct bpf_program *prog=
, long cookie, struct bpf_lin
>  static int attach_raw_tp(const struct bpf_program *prog, long cookie, st=
ruct bpf_link **link);
>  static int attach_trace(const struct bpf_program *prog, long cookie, str=
uct bpf_link **link);
>  static int attach_kprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
> +static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
>  static int attach_lsm(const struct bpf_program *prog, long cookie, struc=
t bpf_link **link);
>  static int attach_iter(const struct bpf_program *prog, long cookie, stru=
ct bpf_link **link);
>
> @@ -8669,6 +8670,10 @@ static const struct bpf_sec_def section_defs[] =3D=
 {
>         SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_=
uprobe),
>         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
>         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
> +       SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
> +       SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
> +       SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
> +       SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
>         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksysc=
all),
>         SEC_DEF("kretsyscall+",         KPROBE, 0, SEC_NONE, attach_ksysc=
all),
>         SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt)=
,
> @@ -10730,6 +10735,37 @@ static int attach_kprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>         return libbpf_get_error(*link);
>  }
>
> +static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link)
> +{
> +       char *probe_type =3D NULL, *binary_path =3D NULL, *func_name =3D =
NULL;
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> +       int n, ret =3D -EINVAL;
> +
> +       *link =3D NULL;
> +
> +       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%ms",
> +                  &probe_type, &binary_path, &func_name);
> +       switch (n) {
> +       case 1:
> +               /* handle SEC("u[ret]probe") - format is valid, but auto-=
attach is impossible. */
> +               ret =3D 0;
> +               break;
> +       case 3:
> +               opts.retprobe =3D strcmp(probe_type, "uretprobe.multi") =
=3D=3D 0;
> +               *link =3D bpf_program__attach_uprobe_multi(prog, -1, bina=
ry_path, func_name, &opts);
> +               ret =3D libbpf_get_error(*link);
> +               break;
> +       default:
> +               pr_warn("prog '%s': invalid format of section definition =
'%s'\n", prog->name,
> +                       prog->sec_name);
> +               break;
> +       }
> +       free(probe_type);
> +       free(binary_path);
> +       free(func_name);
> +       return ret;
> +}
> +
>  static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
>                                          const char *binary_path, uint64_=
t offset)
>  {
> --
> 2.41.0
>

