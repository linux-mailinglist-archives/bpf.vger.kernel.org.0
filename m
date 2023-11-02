Return-Path: <bpf+bounces-13994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1ED7DF8BF
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97301B212AF
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA75200D4;
	Thu,  2 Nov 2023 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD4+4k0e"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A90F1D559
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:32:17 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43FA10E
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:32:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso198659966b.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 10:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698946334; x=1699551134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrWLe78aXDgyveUO0udzfpaae5CxHrxpIcyR0jKOKFA=;
        b=FD4+4k0egAOd+bosw0jQFBjX2oblDD5x2gQQieIrd+F148K6okA3Uf8l9zHs8iUQOd
         JrwhTdSemWFcITogl+T4swKvcLHu7xxXxtzvyc8ohazaWnce+d9PvPISXjzmL8OAyEIN
         wPYPtBrT/ZWrFdyJkwFUDlcEznx8iVbsgh3dV11CNHgpCDqSMyGlBGp4gVk11mahL9v8
         sdGr8eTN/kTVqJHuWQ6nAHk6OzTx3BNrvD8rRqJ8CHCd3dGqSQ/x89K2Lm8ergBEPCRY
         N8a/mXpl/7CRESaX7ZrEd/lNxi1zl2Qb69pjxBf6EemaZzCDFg+f8Qlf06Samuj7p9bY
         rp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946334; x=1699551134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrWLe78aXDgyveUO0udzfpaae5CxHrxpIcyR0jKOKFA=;
        b=XQR18cqB0B1oLOwhhXkEMDp7KqlZHnh9lhX2y28TRddW1/oxJtXyUQETj66C5PnGZU
         ByPJpumVLMIXLqGrSeKm4kIod832AhcbEnB0JpwSBt3QB8bgu03Pugvf6H/E8WLd8bkS
         mkSdkPyWldBDZeo7LcIiOwjgRIliZPiDQeBxNbyX/qhxJl0uJ0vIzFoTjEUc/Z320r18
         znbANdHei4YQUkskXqNO+GeRsvY34WjcYqjkRoyFMIMAUyxD06OfXyyLiaNP5vB3jo4o
         GXMSwAZ0jO6dZZ3vYfs95YtXI2lHOH66GFa6kcCy5o16VATX0DISdTMTvRdvt8QnLiDE
         aZGQ==
X-Gm-Message-State: AOJu0YxlVuCj+EU4WLLK0MiocuHJBMV5khPvrVDkyZJGAFGBqH0FCcf1
	tq+81FEzvpZ9Fff5jTFt9Vd/qQN58+FVghK7aDA=
X-Google-Smtp-Source: AGHT+IGs872hP0uS0HAmqp2oj9HRdBxSYSTxu7vfrYwsdT10QOPzGMbP/mZK96moh0SIV1avDOEiXFOFr1/kHgR6f3I=
X-Received: by 2002:a17:907:7255:b0:9c3:8242:e665 with SMTP id
 ds21-20020a170907725500b009c38242e665mr5175852ejc.8.1698946334108; Thu, 02
 Nov 2023 10:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031012407.51371-1-hengqi.chen@gmail.com> <20231031012407.51371-3-hengqi.chen@gmail.com>
In-Reply-To: <20231031012407.51371-3-hengqi.chen@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 10:32:02 -0700
Message-ID: <CAEf4BzbqwrM0oXJw5moha-M38HDH68pdGFbu-zJPfR4mA66m8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add test_run support for seccomp
 program type
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, keescook@chromium.org, luto@amacapital.net, 
	wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:00=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> Implement test_run for seccomp program type. Default
> is to use an empty struct seccomp_data as bpf_context,
> but can be overridden by userspace. This will be used
> in selftests.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  include/linux/bpf.h |  3 +++
>  kernel/seccomp.c    |  1 +
>  net/bpf/test_run.c  | 27 +++++++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4825d3cdb29..e25338e67ec4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2376,6 +2376,9 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *pr=
og,
>  int bpf_prog_test_run_nf(struct bpf_prog *prog,
>                          const union bpf_attr *kattr,
>                          union bpf_attr __user *uattr);
> +int bpf_prog_test_run_seccomp(struct bpf_prog *prog,
> +                             const union bpf_attr *kattr,
> +                             union bpf_attr __user *uattr);
>  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>                     const struct bpf_prog *prog,
>                     struct bpf_insn_access_aux *info);
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 5a6ed8630566..1fa2312654a5 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -2517,6 +2517,7 @@ int proc_pid_seccomp_cache(struct seq_file *m, stru=
ct pid_namespace *ns,
>
>  #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_BPF_SYSCALL)
>  const struct bpf_prog_ops seccomp_prog_ops =3D {
> +       .test_run =3D bpf_prog_test_run_seccomp,
>  };
>
>  static bool seccomp_is_valid_access(int off, int size, enum bpf_access_t=
ype type,
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 0841f8d82419..db159b9c56ca 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -20,6 +20,7 @@
>  #include <linux/smp.h>
>  #include <linux/sock_diag.h>
>  #include <linux/netfilter.h>
> +#include <linux/seccomp.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/xdp.h>
>  #include <net/netfilter/nf_bpf_link.h>
> @@ -1665,6 +1666,32 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
>         return ret;
>  }
>
> +int bpf_prog_test_run_seccomp(struct bpf_prog *prog,
> +                             const union bpf_attr *kattr,
> +                             union bpf_attr __user *uattr)
> +{
> +       void __user *ctx_in =3D u64_to_user_ptr(kattr->test.ctx_in);
> +       __u32 ctx_size_in =3D kattr->test.ctx_size_in;
> +       struct seccomp_data ctx =3D {};
> +       __u32 retval;
> +
> +       if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_siz=
e)
> +               return -EINVAL;
> +

what about ctx_out, ctx_size_out, data_size_in/data_size_out, etc,
etc. Should we enforce that they all stay zero? Similar questions to
repeat and duration.

> +       if (ctx_size_in && ctx_size_in < sizeof(ctx))
> +               return -EINVAL;
> +
> +       if (ctx_size_in && copy_from_user(&ctx, ctx_in, sizeof(ctx)))
> +               return -EFAULT;
> +
> +       retval =3D bpf_prog_run_pin_on_cpu(prog, &ctx);
> +
> +       if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  static const struct btf_kfunc_id_set bpf_prog_test_kfunc_set =3D {
>         .owner =3D THIS_MODULE,
>         .set   =3D &test_sk_check_kfunc_ids,
> --
> 2.34.1
>

