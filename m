Return-Path: <bpf+bounces-12478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1647CCC93
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 21:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CE32819E1
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878B4447A;
	Tue, 17 Oct 2023 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8Lhvyqe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4182DF95
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 19:50:32 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F0CC4
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:50:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso10743518a12.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697572229; x=1698177029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiAfMO8Yugl8IggqSvmRx+k1gube6Jyh/Cc5OXvA1/g=;
        b=G8LhvyqexNQDfnxsUI3jbd2IqgKpEjOm2J6fhlwNIAHL0l772ks/Vfu8ijFvqqEWpU
         GeYx+MzMviZOSPDX6Vdk2Cxuvs3hjsvHoPTZSujG98qR6gh/2Onqrw7+Y6TPWS+IAFbY
         OVK6KZUhf5YugoMYQ2sjP8YL4YE1gao+wBvaGGkc//TSAqKMdt3vtxivRKk8jeU6CfJc
         88Ni6ccvEfZKCGLXbEMDXx7QoG63rPyz3NSBeK4luNa+OFiPxWGyfrGEm5RrvpZCFBqe
         E8ksHpppNxhClMUz/CerQdw4zG5yRsmDI9WaSDDd1FhtF3T5hT/nNnW/sxYAhIO9iJ2a
         eYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572229; x=1698177029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiAfMO8Yugl8IggqSvmRx+k1gube6Jyh/Cc5OXvA1/g=;
        b=FGsPfFblUJHG3YIvlLVFNXN6A3FuGECQzVXIT8MgbjTgG7zSYROJT2EG19M9PPKQR5
         jXCfCkA+mRqFVGkW8HJxHFczUeTEclFaN5Sf7DT0AsB5OBstVwYEpeFZDh2VbHY11us2
         CFHuWB/7ZMhK+lSlX1DTVM5KI8syejLWF46HxB+uia7wO/iF/tDZ334fvqCHwBxbcRc/
         xmffe73XatJDy8RdHxMq1jjfMjkFAdAz4t+fYAP3Ahjd2NqG8SwQTMpkarYuW0L/pAKU
         Q6AS6B7k8h3CSZyysPmxZVmD6M0ZKeJ/x2xML3ZpVUhIyIiihKmeFHoxgxVhsjPFY39V
         /v/A==
X-Gm-Message-State: AOJu0Ywtsat5XaJzbRweFLFoBqa44iHE+bnpql6r01kE5hav1LO7oPBZ
	Yzip4IDRdzkpaWgS3XoIqQuBxmDd9siOr6zvNJs=
X-Google-Smtp-Source: AGHT+IGHguOehkLc0Vq8S+Qs8vFHEGViFzjDhHg6jRfYIrUTrsBxcj4WmObk1SZjGfT6kbHabJzXQTi9WFPEidxfd4I=
X-Received: by 2002:a50:d5d4:0:b0:53e:6624:5aeb with SMTP id
 g20-20020a50d5d4000000b0053e66245aebmr2512294edj.11.1697572229531; Tue, 17
 Oct 2023 12:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013182644.2346458-1-song@kernel.org> <20231013182644.2346458-3-song@kernel.org>
In-Reply-To: <20231013182644.2346458-3-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Oct 2023 12:50:17 -0700
Message-ID: <CAEf4BzbM0Ru4NpHNfn5Y=vQgfFAmeb+8Z+O6unuFkNr=9BrvKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf, fsverity: Add kfunc bpf_get_fsverity_digest
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 11:29=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> The kfunc can be used to read fsverity_digest, so that we can verify
> signature in BPF LSM.
>
> This kfunc is added to fs/verity/measure.c because some data structure us=
ed
> in the function is private to fsverity (fs/verity/fsverity_private.h).
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/verity/measure.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index eec5956141da..2d4b2e6f5a5d 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -8,6 +8,8 @@
>  #include "fsverity_private.h"
>
>  #include <linux/uaccess.h>
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
>
>  /**
>   * fsverity_ioctl_measure() - get a verity file's digest
> @@ -100,3 +102,67 @@ int fsverity_get_digest(struct inode *inode,
>         return hash_alg->digest_size;
>  }
>  EXPORT_SYMBOL_GPL(fsverity_get_digest);
> +
> +/* bpf kfuncs */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "kfuncs which will be used in BPF programs");
> +
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
> +       struct fsverity_digest *arg =3D digest_ptr->data;

this can be null

I think we need some internal helpers that are similar to
bpf_dynptr_slice() that would handle invalid dynptr cases, as well as
abstract away potentially non-contiguous memory dynptr points to.
WDYT?

> +       const struct fsverity_info *vi;
> +       const struct fsverity_hash_alg *hash_alg;
> +       int out_digest_sz;
> +
> +       if (__bpf_dynptr_size(digest_ptr) < sizeof(struct fsverity_digest=
))
> +               return -EINVAL;
> +
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
> +       memset(arg->digest + arg->digest_size, 0, out_digest_sz - hash_al=
g->digest_size);
> +
> +       return 0;
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(fsverity_set)
> +BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_SLEEPABLE)
> +BTF_SET8_END(fsverity_set)
> +
> +const struct btf_kfunc_id_set bpf_fsverity_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &fsverity_set,
> +};
> +
> +static int __init bpf_fsverity_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +                                        &bpf_fsverity_set);
> +}
> +
> +late_initcall(bpf_fsverity_init);
> --
> 2.34.1
>

