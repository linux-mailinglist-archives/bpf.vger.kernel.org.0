Return-Path: <bpf+bounces-13993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F17DF8BD
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42589B212B3
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C99200CD;
	Thu,  2 Nov 2023 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqOJMwE4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50620300
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:30:16 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC578E
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:30:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c603e235d1so177987066b.3
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698946213; x=1699551013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Up51e4qSEO9o4VFjSQsvsImS3C6Wbkem5mZTYP8FbI=;
        b=TqOJMwE4iWhtkw2/g/ovMbSVDhcgIL+eAfHbf66TXpv2T+uj1LF+IUUvtRjkub5k2f
         hDwebqDQtAmlJ9fzX2eSTBkYBdYLDmt163cxMlB83B0T6MO5711cc1zqJZvwJtkODmfT
         GwDL+O3Y45xwcyI+0nXibMeBSc6FezQ0/JV9Xv5/Yr1rKqnds4bmZDONih3mhUDAZc4T
         6qUJ8B7c/a6VaXGiKJqaoOdltPSB6bl7hD7PmhnUKh1DQGc6oA84nbrLx17alHyFoQuG
         Gu0tOcy5XP8tdMcflcY/Bd6XJYqxwY5Sycu5mGXtwyg1ef3bSKrE7YNVVAwO46T1+6Ie
         9MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946213; x=1699551013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Up51e4qSEO9o4VFjSQsvsImS3C6Wbkem5mZTYP8FbI=;
        b=BJ3X+DL1IyAYm3UOUMcqINDbamoZJUiGr2uykMURzSfgAhrnwDBlDEZZ4jS8o0Hywu
         +dnQv9vEOtWQ3DXrAqPq6YvXmZCgbDDXId+ZsIx+IBN7dxGBHlnhlf/FQq2wH22n02sn
         cSjJuADOlf5EWVygzkt04m3KbFGLjFFFeWxma8NaXY830i+25Yc6cEX0oTFpS2wD5EDR
         G3nCTql5cBRLuEfgwBsAdc0+SNvSG59FHuwmRjQLjxAiYBsBclTj50KCHPk5MmMRWPT+
         9d2ZnbDSsgG1aKcTF0fsgPgtkeoVx+P6wXDBR6FQsbGRq3lTmNlXIp3jFlatphRopsfI
         eaPw==
X-Gm-Message-State: AOJu0YybLKikBxRBgLw4T4Wa7T3OXL7F9qSVeRlGl3VsbsXf1Hy7rEb5
	fuPPj0yxihFEgK4/YzIsNXVONtGug9rCYMxhL2I=
X-Google-Smtp-Source: AGHT+IHDbsjXxuUldSVn42cP01JncDC6wWIZ7nJ0z+D3sEHfMqGJjuLXV0hXomiS1ysMPCfLgv0wbhedDPnqwTGoD/E=
X-Received: by 2002:a17:907:1c25:b0:9c7:59d1:b2c2 with SMTP id
 nc37-20020a1709071c2500b009c759d1b2c2mr5300666ejc.27.1698946212709; Thu, 02
 Nov 2023 10:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031012407.51371-1-hengqi.chen@gmail.com> <20231031012407.51371-2-hengqi.chen@gmail.com>
In-Reply-To: <20231031012407.51371-2-hengqi.chen@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 10:30:01 -0700
Message-ID: <CAEf4BzZix04=7MNshY5RkYw9xOW1MgXm_O+7OEYLibkZc0zVNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Introduce BPF_PROG_TYPE_SECCOMP
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, keescook@chromium.org, luto@amacapital.net, 
	wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:00=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> This adds minimal support for seccomp eBPF programs
> which can be hooked into the existing seccomp framework.
> This allows users to write seccomp filter in eBPF language
> and enables seccomp filter reuse through bpf prog fd and
> bpffs. Currently, no helper calls are allowed just like
> its cBPF version.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  include/linux/bpf_types.h     |  4 +++
>  include/uapi/linux/bpf.h      |  1 +
>  kernel/seccomp.c              | 54 +++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c        |  2 ++
>  tools/lib/bpf/libbpf_probes.c |  1 +
>  5 files changed, 62 insertions(+)
>

Let's make sure that bpf_prog_load_check_attach() errors out on
non-zero attach type for this new program type?

Ideally, if you can, let's refactor bpf_prog_load_check_attach() in
such a way as to default to failing on non-zero attach type for any
new program type. You'll need to explicitly list program types for
which we don't enforce attach type.

Thanks!

> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index fc0d6f32c687..7c0a9fc0b150 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -83,6 +83,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
>  BPF_PROG_TYPE(BPF_PROG_TYPE_NETFILTER, netfilter,
>               struct bpf_nf_ctx, struct bpf_nf_ctx)
>  #endif
> +#ifdef CONFIG_SECCOMP_FILTER
> +BPF_PROG_TYPE(BPF_PROG_TYPE_SECCOMP, seccomp,
> +             struct seccomp_data, struct seccomp_data)
> +#endif
>
>  BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..f0fcfe0ccb2e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -995,6 +995,7 @@ enum bpf_prog_type {
>         BPF_PROG_TYPE_SK_LOOKUP,
>         BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
>         BPF_PROG_TYPE_NETFILTER,
> +       BPF_PROG_TYPE_SECCOMP,
>  };
>
>  enum bpf_attach_type {
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 255999ba9190..5a6ed8630566 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -15,6 +15,7 @@
>   */
>  #define pr_fmt(fmt) "seccomp: " fmt
>
> +#include <linux/bpf.h>
>  #include <linux/refcount.h>
>  #include <linux/audit.h>
>  #include <linux/compat.h>
> @@ -2513,3 +2514,56 @@ int proc_pid_seccomp_cache(struct seq_file *m, str=
uct pid_namespace *ns,
>         return 0;
>  }
>  #endif /* CONFIG_SECCOMP_CACHE_DEBUG */
> +
> +#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_BPF_SYSCALL)
> +const struct bpf_prog_ops seccomp_prog_ops =3D {
> +};
> +
> +static bool seccomp_is_valid_access(int off, int size, enum bpf_access_t=
ype type,
> +                                   const struct bpf_prog *prog,
> +                                   struct bpf_insn_access_aux *info)
> +{
> +       if (off < 0 || off >=3D sizeof(struct seccomp_data))
> +               return false;
> +
> +       if (off % size !=3D 0)
> +               return false;
> +
> +       if (type =3D=3D BPF_WRITE)
> +               return false;
> +
> +       switch (off) {
> +       case bpf_ctx_range(struct seccomp_data, nr):
> +               if (size !=3D sizeof_field(struct seccomp_data, nr))
> +                       return false;
> +               return true;
> +       case bpf_ctx_range(struct seccomp_data, arch):
> +               if (size !=3D sizeof_field(struct seccomp_data, arch))
> +                       return false;
> +               return true;
> +       case bpf_ctx_range(struct seccomp_data, instruction_pointer):
> +               if (size !=3D sizeof_field(struct seccomp_data, instructi=
on_pointer))
> +                       return false;
> +               return true;
> +       case bpf_ctx_range(struct seccomp_data, args):
> +               if (size !=3D sizeof(__u64))
> +                       return false;
> +               return true;
> +       default:
> +               return false;
> +       }
> +
> +       return false;
> +}
> +
> +static const struct bpf_func_proto *
> +bpf_seccomp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
> +{
> +       return NULL;
> +}
> +
> +const struct bpf_verifier_ops seccomp_verifier_ops =3D {
> +       .is_valid_access =3D seccomp_is_valid_access,
> +       .get_func_proto  =3D bpf_seccomp_func_proto,
> +};
> +#endif /* CONFIG_SECCOMP_FILTER && CONFIG_BPF_SYSCALL */
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e067be95da3c..455d733f7315 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -217,6 +217,7 @@ static const char * const prog_type_name[] =3D {
>         [BPF_PROG_TYPE_SK_LOOKUP]               =3D "sk_lookup",
>         [BPF_PROG_TYPE_SYSCALL]                 =3D "syscall",
>         [BPF_PROG_TYPE_NETFILTER]               =3D "netfilter",
> +       [BPF_PROG_TYPE_SECCOMP]                 =3D "seccomp",
>  };
>
>  static int __base_pr(enum libbpf_print_level level, const char *format,
> @@ -8991,6 +8992,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("struct_ops.s+",        STRUCT_OPS, 0, SEC_SLEEPABLE),
>         SEC_DEF("sk_lookup",            SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATT=
ACHABLE),
>         SEC_DEF("netfilter",            NETFILTER, BPF_NETFILTER, SEC_NON=
E),
> +       SEC_DEF("seccomp",              SECCOMP, 0, SEC_NONE),
>  };
>
>  int libbpf_register_prog_handler(const char *sec,
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index 9c4db90b92b6..b3ef3c0747be 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -180,6 +180,7 @@ static int probe_prog_load(enum bpf_prog_type prog_ty=
pe,
>         case BPF_PROG_TYPE_SK_REUSEPORT:
>         case BPF_PROG_TYPE_FLOW_DISSECTOR:
>         case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +       case BPF_PROG_TYPE_SECCOMP:
>                 break;
>         case BPF_PROG_TYPE_NETFILTER:
>                 opts.expected_attach_type =3D BPF_NETFILTER;
> --
> 2.34.1
>

