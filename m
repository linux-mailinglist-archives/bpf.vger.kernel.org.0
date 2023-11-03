Return-Path: <bpf+bounces-14146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655C7E0AF8
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E81C210F1
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4524224216;
	Fri,  3 Nov 2023 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lx4B4mAk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF324208
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:13:17 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8DAD53
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:13:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9db6cf8309cso354223766b.0
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699049594; x=1699654394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0smAkhzWi7LQB4O+bnHLFjKF0X/wdZ2cGiNse1b9Nr8=;
        b=Lx4B4mAkNuKBdWI02J0aSajsfe/Kh1b0hyhwgPY62g5UZUxYm5KikJozdLfdfZxT+7
         wt58uev58ffv7Y9xl3sDNQIWr2QtRu+yXJO13SlhVt+dmYfLRViQ1LU5aEP4e3EtM9yH
         DAVaHiCZQn9XC5o7SSo4m6mO7lB5HjB6ThbdHRjXwXyX9plvyv17zava+fmkx5K0wuzY
         i/0G5IH4/U2anzKqpJgIRMHFVUyltjvmR2jL4P7q5B9+aguCppwimttRiCfuqmIsVdy2
         JNP3RkYF0ae6bMaIV5QxnoPKhIlRFeOFleK4VcLJ1tQ9DIV59ijkQ++PoE6ZB6OB5JdU
         UjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049594; x=1699654394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0smAkhzWi7LQB4O+bnHLFjKF0X/wdZ2cGiNse1b9Nr8=;
        b=IYMFv09jbQMm5qrjdqmx/d1f+F92S7Kub2E0najzYB5nf3tZUh91oQ/pAd15EMY/j+
         Hr1LpbTk6qnA5FS8+DFpr+f6mLhBzcRhz010HsMPgc6T8nOCwWLVhThdnMk2gsB5OLi9
         z5smfMVnXVntkVz+H1VXwbx0W4yQLQGDoZhWmLWVNMAt2ygAYGSSU88zxD6Hra0GK87L
         m+0EWkPRUbpO/xmvDNMM8eer9uAZf+L5hFnvASBow+nYOoKhO1+sBQRLQWtuvIujfqkU
         HGjewYLcQECFAWfViv8r+druZJ12syuXmmcqyl8qKz/eAa3n0YemHMHnUEzgmWxvW+c+
         NiTw==
X-Gm-Message-State: AOJu0Ywl+R7spoZ7GxxLWDP92eIL6GQuf69hw18pHBS7h0yeqhwfKkLO
	fcFOBgMw3+sxvBoEAz0X43MFiScCjfEEBaAAc6Y=
X-Google-Smtp-Source: AGHT+IGxcj9zlsTnn23D7rMoNKSCm46NGjxZY9GtKO3L7ajg44Ok3mmi9fe1bXtWaT4kXlcpGz/Ziu3kTiWu58o0yjk=
X-Received: by 2002:a17:907:3685:b0:9bd:a7a5:3a5a with SMTP id
 bi5-20020a170907368500b009bda7a53a5amr8464669ejc.36.1699049593900; Fri, 03
 Nov 2023 15:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103214535.2674059-1-song@kernel.org> <20231103214535.2674059-6-song@kernel.org>
In-Reply-To: <20231103214535.2674059-6-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 15:13:02 -0700
Message-ID: <CAEf4BzbRrVcHxEdR89UMv6aPpF+478WCpCMx7RFknNMexpUGpw@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 5/9] bpf, fsverity: Add kfunc bpf_get_fsverity_digest
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org, vadfed@meta.com, 
	Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 2:46=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> fsverity provides fast and reliable hash of files, namely fsverity_digest=
.
> The digest can be used by security solutions to verify file contents.
>
> Add new kfunc bpf_get_fsverity_digest() so that we can access fsverity fr=
om
> BPF LSM programs. This kfunc is added to fs/verity/measure.c because some
> data structure used in the function is private to fsverity
> (fs/verity/fsverity_private.h).
>
> To avoid recursion, bpf_get_fsverity_digest is only allowed in BPF LSM
> programs.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/fsverity_private.h | 10 +++++
>  fs/verity/init.c             |  1 +
>  fs/verity/measure.c          | 85 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index d071a6e32581..a6a6b2749241 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -100,6 +100,16 @@ fsverity_msg(const struct inode *inode, const char *=
level,
>  #define fsverity_err(inode, fmt, ...)          \
>         fsverity_msg((inode), KERN_ERR, fmt, ##__VA_ARGS__)
>
> +/* measure.c */
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +void __init fsverity_init_bpf(void);
> +#else
> +static inline void fsverity_init_bpf(void)
> +{
> +}
> +#endif
> +
>  /* open.c */
>
>  int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
> diff --git a/fs/verity/init.c b/fs/verity/init.c
> index a29f062f6047..1e207c0f71de 100644
> --- a/fs/verity/init.c
> +++ b/fs/verity/init.c
> @@ -69,6 +69,7 @@ static int __init fsverity_init(void)
>         fsverity_init_workqueue();
>         fsverity_init_sysctl();
>         fsverity_init_signature();
> +       fsverity_init_bpf();
>         return 0;
>  }
>  late_initcall(fsverity_init)
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index eec5956141da..a08177eda96e 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -7,6 +7,8 @@
>
>  #include "fsverity_private.h"
>
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
>  #include <linux/uaccess.h>
>
>  /**
> @@ -100,3 +102,86 @@ int fsverity_get_digest(struct inode *inode,
>         return hash_alg->digest_size;
>  }
>  EXPORT_SYMBOL_GPL(fsverity_get_digest);
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +
> +/* bpf kfuncs */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "kfuncs which will be used in BPF programs");
> +

same as in previous patch, we have dedicated macros for this, please use th=
em


> +/**
> + * bpf_get_fsverity_digest: read fsverity digest of file
> + * @file: file to get digest from
> + * @digest_ptr: (out) dynptr for struct fsverity_digest
> + *
> + * Read fsverity_digest of *file* into *digest_ptr*.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dy=
nptr_kern *digest_ptr)
> +{
> +       const struct inode *inode =3D file_inode(file);
> +       struct fsverity_digest *arg;
> +       const struct fsverity_info *vi;
> +       const struct fsverity_hash_alg *hash_alg;
> +       int out_digest_sz;
> +
> +       arg =3D __bpf_dynptr_data_rw(digest_ptr, __bpf_dynptr_size(digest=
_ptr));
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!IS_ALIGNED((uintptr_t)arg, __alignof__(*arg)))
> +               return -EINVAL;
> +
> +       if (__bpf_dynptr_size(digest_ptr) < sizeof(struct fsverity_digest=
))
> +               return -EINVAL;
> +

similar nit, you call __bpf_dynptr_size(digest_ptr) many times, let's
use `u32 len =3D __bpf_dynptr_size(digest_ptr);` ?

> +       vi =3D fsverity_get_info(inode);
> +       if (!vi)
> +               return -ENODATA; /* not a verity file */
> +
> +       hash_alg =3D vi->tree_params.hash_alg;
> +
> +       arg->digest_algorithm =3D hash_alg - fsverity_hash_algs;
> +       arg->digest_size =3D hash_alg->digest_size;
> +
> +       out_digest_sz =3D __bpf_dynptr_size(digest_ptr) - sizeof(struct f=
sverity_digest);
> +
> +       /* copy digest */
> +       memcpy(arg->digest, vi->file_digest,  min_t(int, hash_alg->digest=
_size, out_digest_sz));
> +
> +       /* fill the extra buffer with zeros */
> +       if (out_digest_sz > hash_alg->digest_size)
> +               memset(arg->digest + arg->digest_size, 0, out_digest_sz -=
 hash_alg->digest_size);
> +
> +       return 0;
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(fsverity_set_ids)
> +BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
> +BTF_SET8_END(fsverity_set_ids)
> +
> +static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u=
32 kfunc_id)
> +{
> +       if (!btf_id_set8_contains(&fsverity_set_ids, kfunc_id))
> +               return 0;
> +
> +       /* Only allow to attach from LSM hooks, to avoid recursion */
> +       return prog->type !=3D BPF_PROG_TYPE_LSM ? -EACCES : 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_fsverity_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &fsverity_set_ids,
> +       .filter =3D bpf_get_fsverity_digest_filter,
> +};
> +
> +void __init fsverity_init_bpf(void)
> +{
> +       register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fsverity_set);
> +}
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> --
> 2.34.1
>

