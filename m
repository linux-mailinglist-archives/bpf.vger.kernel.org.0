Return-Path: <bpf+bounces-6393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2950768A2F
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 05:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865A7281558
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 03:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F401648;
	Mon, 31 Jul 2023 03:03:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90362D
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 03:03:53 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83654E68
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 20:03:51 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63cfa3e564eso20483356d6.0
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 20:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690772630; x=1691377430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcLITgVnJ0UF+l7be3nuXuLkQjlKpmsAGYW9dWKHHIw=;
        b=TYLu5KTvkU1oyvRXEzplXjeQJg+Fsbl/Fgln6YDI3wrASi5vfymPlGYHpN86UEVfZG
         eM4bvqdhDOtf+MmfPVxrAefeyXaBupFUNEKlW8UcgUBnGmvyI1AVor0PorSnI8YoSgbo
         i54pvvpKOO7eWVwEEW3OBdXnQHCVUAVD5cb6BVVyVYud9zlN6NFb2v74PR/1nqhOmZok
         +/zGBxskdjLKCBFCJFcSOEXM6P4I5SpKyYJvMPtZm6YegwjI35Z+11Qj5gsQ2I8HRbZ/
         l6m3LcQ1TrJYClXz5RYM4b3sbNUzYej84cwRpli+N5B5qZ/b4thhXn8MQvwmxWnJsP1/
         iaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690772630; x=1691377430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcLITgVnJ0UF+l7be3nuXuLkQjlKpmsAGYW9dWKHHIw=;
        b=dTpXzvqpy47tfo+3bk1q/a+ytRhvJAYgqGZflJk2vivf3gD5XlZfmEdQN65/6/G+OT
         JImFmJRNj/MDqlJLJhXzSwxTGNi7pUiFy6SmtriJdCaBGeVV8DeoVd49lJ541G6/WBib
         jPK/thP3OLOuSN28zPGpmuNvekWmLCcd+i8I9e5l+qpVDn9XEbX8vO28OXHV+ahAtDFl
         FXGYXQsPFGT7rd/gQxoQ8IDAtk8tCGkGX0Ql4qaf9DUbRySFdK34va5GxxbzD3rllpRv
         7DlF3U2YIttMAD/qi9Uhzb9A3IyEY5pLMbhPoEkK61Epf+fn06Tpce1hWs8jZo69wp9/
         raiQ==
X-Gm-Message-State: ABy/qLZJ9mQu/N6lk2vG317mJAAVSqjOiSpen7z1m0iD81Y3I6kzbMQb
	tZEykbE1aPa8dSy9BQoY4fHdumweg5rd3HLjSv0=
X-Google-Smtp-Source: APBJJlEKgIOY+J2ddZyAvPCfVrUjm3f2DrWQE4W82ZlybNasi77FoDEUp8KxnCRalAtD66s6PKOhEoPzCm4sDivU/aM=
X-Received: by 2002:a0c:e3d4:0:b0:63d:70f6:8f6f with SMTP id
 e20-20020a0ce3d4000000b0063d70f68f6fmr1353869qvl.43.1690772630575; Sun, 30
 Jul 2023 20:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730134223.94496-1-jolsa@kernel.org> <20230730134223.94496-3-jolsa@kernel.org>
In-Reply-To: <20230730134223.94496-3-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 31 Jul 2023 11:03:14 +0800
Message-ID: <CALOAHbBXpkLK1JiQe+=-wDC54RnOSj-s-LQvCg=9NTDGG12ZnA@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 02/28] bpf: Add attach_type checks under bpf_prog_attach_check_attach_type
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

On Sun, Jul 30, 2023 at 9:42=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add extra attach_type checks from link_create under
> bpf_prog_attach_check_attach_type.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  kernel/bpf/syscall.c | 120 +++++++++++++++++++------------------------
>  1 file changed, 52 insertions(+), 68 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7f4e8c357a6a..7c01186d4078 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3656,34 +3656,6 @@ static int bpf_raw_tracepoint_open(const union bpf=
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
> @@ -3750,6 +3722,58 @@ attach_type_to_prog_type(enum bpf_attach_type atta=
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
> +       case BPF_PROG_TYPE_KPROBE:
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MU=
LTI &&
> +                   attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> +                       return -EINVAL;
> +               if (attach_type !=3D BPF_PERF_EVENT &&
> +                   attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> +                       return -EINVAL;
> +               return 0;
> +       case BPF_PROG_TYPE_SCHED_CLS:
> +               if (attach_type !=3D BPF_TCX_INGRESS &&
> +                   attach_type !=3D BPF_TCX_EGRESS)
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
>  #define BPF_PROG_ATTACH_LAST_FIELD expected_revision
>
>  #define BPF_F_ATTACH_MASK_BASE \
> @@ -4856,7 +4880,6 @@ static int bpf_map_do_batch(const union bpf_attr *a=
ttr,
>  #define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
>  static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>  {
> -       enum bpf_prog_type ptype;
>         struct bpf_prog *prog;
>         int ret;
>
> @@ -4875,45 +4898,6 @@ static int link_create(union bpf_attr *attr, bpfpt=
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
> -       case BPF_PROG_TYPE_SCHED_CLS:
> -               if (attr->link_create.attach_type !=3D BPF_TCX_INGRESS &&
> -                   attr->link_create.attach_type !=3D BPF_TCX_EGRESS) {
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


--=20
Regards
Yafang

