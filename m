Return-Path: <bpf+bounces-4345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0074A71F
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31966281569
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8AB15AE4;
	Thu,  6 Jul 2023 22:34:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8153C2CF
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:34:26 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6648F10F5
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:34:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbf7fbe722so10087275e9.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688682856; x=1691274856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU5RRfclQQT+qf4rj9diknCMMAMX13dHY9L9lfoA/ns=;
        b=BdYQ4C0FqACmVL6p4/QOQlEWosUKWRZIsPhyMZnLV+2sfo6Sdozo7i89kjo9Z3gAlQ
         mZC0txOQ4+lxJGuPTb2+7+6P2uIX4PCVOKgeHK2sqwQv4ozyKTyU6bdDaT8E0IBnKz+H
         V6TCNOalRD2MaU6YsjrDV/PCYJ7HsPhsSmgq18JEkqU865mjNGvwZFsGh0Oi3e1sLbr+
         +neQEs+QvyMmFEzBLOJYuerImfLiD3DlEfMcNUde0hBQOFq/jZGa0zNRQyGTbEMoRdoJ
         BZ3/4Hchvvayn5hynJ7DL2SgVLJ+ydS+GsHcQ+AAr4GG95OcpulUODOKfuDTJVPitVkI
         k2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682856; x=1691274856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU5RRfclQQT+qf4rj9diknCMMAMX13dHY9L9lfoA/ns=;
        b=YUh1gFVVriHzxcns8Be4Ff6f1fUVFR/CVsAC1QfuSxRn/BFwyKlTpAJIIvWIcv13Bv
         kAJPnQalI20924a48QNxTFC1XNG7OlIJb4AmQ1paJQa7OSE9hhKU8aDWgBuOPGY2Hj6V
         1ELftB5zAEEHa8B6rljdikCnn20Rf9w0Rj3fg+X3oTOOwx8Adje+kOHDPTodJ0GhNbGV
         3wgIOMMNJzAHWQO2Kd2xXf+ORJYD7atCjHiLzadDqjqJZkWvCPfj2XEHweWSVP645WGL
         tB9bsvlBiNQjvVAGjBuDapPtluPNsiuw32JeK/0xQloPc5upJR5UT2ZqsP+TxotPnDWX
         SfPQ==
X-Gm-Message-State: ABy/qLbmQqQFzg4cIfyNxBsAC1DKXYKVMQ6zNipAj5W9qDwd9Fci5Ecy
	rYH1bnr3LC0wMx9R3LDQFO3fruyeZb/GWUQLc/c=
X-Google-Smtp-Source: APBJJlGfVpTP+qxK6Ew1HjUNwpcg7otqTbuuzMfWP9k/fyBUQE0SDTRk7rIrxtqpvuOV2HYCnBbQ4V50/Aja/4gqo9I=
X-Received: by 2002:a1c:7404:0:b0:3fb:424b:ef6e with SMTP id
 p4-20020a1c7404000000b003fb424bef6emr3372412wmc.23.1688682855598; Thu, 06 Jul
 2023 15:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-2-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 15:34:03 -0700
Message-ID: <CAEf4Bza0XykLWAYCiAzHHH1HKBquFeVLN30Y5fqPQ8=s_5CwgQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 01/26] bpf: Add attach_type checks under bpf_prog_attach_check_attach_type
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

On Fri, Jun 30, 2023 at 1:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add extra attach_type checks from link_create under
> bpf_prog_attach_check_attach_type.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/syscall.c | 108 +++++++++++++++++++------------------------
>  1 file changed, 47 insertions(+), 61 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a2aef900519c..9046ad0f9b4e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3502,34 +3502,6 @@ static int bpf_raw_tracepoint_open(const union bpf=
_attr *attr)
>         return fd;
>  }
>
> -static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog=
,
> -                                            enum bpf_attach_type attach_=
type)
> -{
> -       switch (prog->type) {
> -       case BPF_PROG_TYPE_CGROUP_SOCK:
> -       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> -       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> -       case BPF_PROG_TYPE_SK_LOOKUP:
> -               return attach_type =3D=3D prog->expected_attach_type ? 0 =
: -EINVAL;
> -       case BPF_PROG_TYPE_CGROUP_SKB:
> -               if (!capable(CAP_NET_ADMIN))
> -                       /* cg-skb progs can be loaded by unpriv user.
> -                        * check permissions at attach time.
> -                        */
> -                       return -EPERM;
> -               return prog->enforce_expected_attach_type &&
> -                       prog->expected_attach_type !=3D attach_type ?
> -                       -EINVAL : 0;
> -       case BPF_PROG_TYPE_KPROBE:
> -               if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MU=
LTI &&
> -                   attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> -                       return -EINVAL;
> -               return 0;
> -       default:
> -               return 0;
> -       }
> -}
> -
>  static enum bpf_prog_type
>  attach_type_to_prog_type(enum bpf_attach_type attach_type)
>  {
> @@ -3593,6 +3565,53 @@ attach_type_to_prog_type(enum bpf_attach_type atta=
ch_type)
>         }
>  }
>
> +static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog=
,
> +                                            enum bpf_attach_type attach_=
type)
> +{
> +       enum bpf_prog_type ptype;
> +
> +       switch (prog->type) {
> +       case BPF_PROG_TYPE_CGROUP_SOCK:
> +       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> +       case BPF_PROG_TYPE_SK_LOOKUP:
> +               return attach_type =3D=3D prog->expected_attach_type ? 0 =
: -EINVAL;
> +       case BPF_PROG_TYPE_CGROUP_SKB:
> +               if (!capable(CAP_NET_ADMIN))
> +                       /* cg-skb progs can be loaded by unpriv user.
> +                        * check permissions at attach time.
> +                        */
> +                       return -EPERM;
> +               return prog->enforce_expected_attach_type &&
> +                       prog->expected_attach_type !=3D attach_type ?
> +                       -EINVAL : 0;
> +       case BPF_PROG_TYPE_KPROBE:

nit, I'd keep KPROBE, TRACEPOINT and PERF_EVENT next to each other in
this switch (that will just grow larger over time), as they are pretty
closely related

otherwise lgtm:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MU=
LTI &&
> +                   attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> +                       return -EINVAL;
> +               if (attach_type !=3D BPF_PERF_EVENT &&
> +                   attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> +                       return -EINVAL;
> +               return 0;
> +       case BPF_PROG_TYPE_EXT:
> +               return 0;
> +       case BPF_PROG_TYPE_NETFILTER:
> +               if (attach_type !=3D BPF_NETFILTER)
> +                       return -EINVAL;
> +               return 0;
> +       case BPF_PROG_TYPE_PERF_EVENT:
> +       case BPF_PROG_TYPE_TRACEPOINT:
> +               if (attach_type !=3D BPF_PERF_EVENT)
> +                       return -EINVAL;
> +               return 0;
> +       default:
> +               ptype =3D attach_type_to_prog_type(attach_type);
> +               if (ptype =3D=3D BPF_PROG_TYPE_UNSPEC || ptype !=3D prog-=
>type)
> +                       return -EINVAL;
> +               return 0;
> +       }
> +}
> +
>  #define BPF_PROG_ATTACH_LAST_FIELD replace_bpf_fd
>
>  #define BPF_F_ATTACH_MASK \
> @@ -4658,7 +4677,6 @@ static int bpf_map_do_batch(const union bpf_attr *a=
ttr,
>  #define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
>  static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>  {
> -       enum bpf_prog_type ptype;
>         struct bpf_prog *prog;
>         int ret;
>
> @@ -4677,38 +4695,6 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>         if (ret)
>                 goto out;
>
> -       switch (prog->type) {
> -       case BPF_PROG_TYPE_EXT:
> -               break;
> -       case BPF_PROG_TYPE_NETFILTER:
> -               if (attr->link_create.attach_type !=3D BPF_NETFILTER) {
> -                       ret =3D -EINVAL;
> -                       goto out;
> -               }
> -               break;
> -       case BPF_PROG_TYPE_PERF_EVENT:
> -       case BPF_PROG_TYPE_TRACEPOINT:
> -               if (attr->link_create.attach_type !=3D BPF_PERF_EVENT) {
> -                       ret =3D -EINVAL;
> -                       goto out;
> -               }
> -               break;
> -       case BPF_PROG_TYPE_KPROBE:
> -               if (attr->link_create.attach_type !=3D BPF_PERF_EVENT &&
> -                   attr->link_create.attach_type !=3D BPF_TRACE_KPROBE_M=
ULTI) {
> -                       ret =3D -EINVAL;
> -                       goto out;
> -               }
> -               break;
> -       default:
> -               ptype =3D attach_type_to_prog_type(attr->link_create.atta=
ch_type);
> -               if (ptype =3D=3D BPF_PROG_TYPE_UNSPEC || ptype !=3D prog-=
>type) {
> -                       ret =3D -EINVAL;
> -                       goto out;
> -               }
> -               break;
> -       }
> -
>         switch (prog->type) {
>         case BPF_PROG_TYPE_CGROUP_SKB:
>         case BPF_PROG_TYPE_CGROUP_SOCK:
> --
> 2.41.0
>

