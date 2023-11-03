Return-Path: <bpf+bounces-14145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 962BB7E0AF6
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6CCB2147C
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2124215;
	Fri,  3 Nov 2023 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5qhgQb1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4F24208
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:10:26 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B9CF
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:10:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c603e2354fso503672866b.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699049423; x=1699654223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48eapHSqB9XT8NL/KrM14oWKGu50UEgduwEpKQtsqT8=;
        b=h5qhgQb1p8aWvrDDN8l06PKDdN2Br4T0J4dc8YRc2TT0/k//n9pyOTsMYVpVQUkT3A
         DNGjrPSHmIf8u/U/AYvQbBTi8ed33Z50nWPDEEZ0JL1nAO/0WsNn9An5cex8nj4F9IZ5
         YKqcNH7s6Eo+57aqwE2nzjTSDAXNQKnAS39U3CftUMTHl5zQ+VDYh6HFqUWCxID7lkHz
         vjdlux8OSyEkPIzCQG6WUL2KqzpY6vJuwCt5bbnDBxhkCphOGb8JgkX2KwDnnvjJQLZ/
         xoVRDNdqgJwnk3uyXBOAoAHI6+bt2joo00NXV51KzvOTjUWL5minpVbSNO8I6Gc2PPj4
         sJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049423; x=1699654223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48eapHSqB9XT8NL/KrM14oWKGu50UEgduwEpKQtsqT8=;
        b=U6m9O82rMcoMLbsYVk+mpt8w7rV2xd64m6OgBO+bhrHqRAP43LQRXtK0Zee+W4GLIe
         cppNpYxs1WnwXcgObWe6+Ipl/fyM9LWHCde3s8IepxJ74o3GJ1dK8IzCSRJnLeGW+a8G
         I/0RmwwIbpvuENsYGt74XjiF7Pbvfex/dNu6xXqReWXiJ74XEF50I7vTcuSXU/FgZ059
         VrrR/HSEpcvAEUk95f4Fhf06VzXIWWcGupCrVoqKCf0x/c3azS0nhLp1vNnMb+jnYatX
         k96OsxdXYOlJPqfwvhBALgYXkBn7/YeF+zEIAxfam87FgphwmsK2+d1bHNpMqjV31R19
         cK1g==
X-Gm-Message-State: AOJu0Yxr6it8dV6jx5CdyqcLPoGIBmihdNYogh1bK+HYfUmF2h5tXa+w
	rkjyto1C/ByTCRdrPzo/M8TOCnwkVh0EK4AetfM=
X-Google-Smtp-Source: AGHT+IFqeA5asuXAa8GEZgAmj23Dr/EkPdEF8Uw4igJcN/p2nkWaBVtK/aY1zJNG4MN+4LxIVna/jGHIIms4+QCCy24=
X-Received: by 2002:a17:907:3e14:b0:9dd:e124:4b39 with SMTP id
 hp20-20020a1709073e1400b009dde1244b39mr734692ejc.10.1699049422615; Fri, 03
 Nov 2023 15:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103214535.2674059-1-song@kernel.org> <20231103214535.2674059-5-song@kernel.org>
In-Reply-To: <20231103214535.2674059-5-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 15:10:11 -0700
Message-ID: <CAEf4BzY2V1Q_V=JMV4uYqHCSnV0ZDsAaLNq6cm0CPt2d8E4XGA@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 2:46=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> It is common practice for security solutions to store tags/labels in
> xattrs. To implement similar functionalities in BPF LSM, add new kfunc
> bpf_get_file_xattr().
>
> The first use case of bpf_get_file_xattr() is to implement file
> verifications with asymmetric keys. Specificially, security applications
> could use fsverity for file hashes and use xattr to store file signatures=
.
> (kfunc for fsverity hash will be added in a separate commit.)
>
> Currently, only xattrs with "user." prefix can be read with kfunc
> bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefix
> for bpf_get_file_xattr().
>
> To avoid recursion, bpf_get_file_xattr can be only called from LSM hooks.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 64 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index bfe6fb83e8d0..82eaa099053b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -24,6 +24,7 @@
>  #include <linux/key.h>
>  #include <linux/verification.h>
>  #include <linux/namei.h>
> +#include <linux/fileattr.h>
>
>  #include <net/bpf_sk_storage.h>
>
> @@ -1431,6 +1432,69 @@ static int __init bpf_key_sig_kfuncs_init(void)
>  late_initcall(bpf_key_sig_kfuncs_init);
>  #endif /* CONFIG_KEYS */
>
> +/* filesystem kfuncs */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "kfuncs which will be used in BPF programs");
> +

please use __bpf_kfunc_{start,end}_defs macros, from [0]

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?i=
d=3D391145ba2acc

> +/**
> + * bpf_get_file_xattr - get xattr of a file
> + * @file: file to get xattr from
> + * @name__str: name of the xattr
> + * @value_ptr: output buffer of the xattr value
> + *
> + * Get xattr *name__str* of *file* and store the output in *value_ptr*.
> + *
> + * For security reasons, only *name__str* with prefix "user." is allowed=
.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__=
str,
> +                                  struct bpf_dynptr_kern *value_ptr)
> +{
> +       struct dentry *dentry;
> +       void *value;
> +
> +       if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +               return -EPERM;
> +
> +       value =3D __bpf_dynptr_data_rw(value_ptr, __bpf_dynptr_size(value=
_ptr));
> +       if (!value)
> +               return -EINVAL;
> +
> +       dentry =3D file_dentry(file);
> +       return __vfs_getxattr(dentry, dentry->d_inode, name__str,
> +                             value, __bpf_dynptr_size(value_ptr));

nit: probably cleaner to get size once into local variable and use
that throughout

> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(fs_kfunc_set_ids)
> +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_SET8_END(fs_kfunc_set_ids)
> +
> +static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kf=
unc_id)
> +{
> +       if (!btf_id_set8_contains(&fs_kfunc_set_ids, kfunc_id))
> +               return 0;
> +
> +       /* Only allow to attach from LSM hooks, to avoid recursion */
> +       return prog->type !=3D BPF_PROG_TYPE_LSM ? -EACCES : 0;
> +}
> +
> +const struct btf_kfunc_id_set bpf_fs_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &fs_kfunc_set_ids,
> +       .filter =3D bpf_get_file_xattr_filter,
> +};
> +
> +static int __init bpf_fs_kfuncs_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc=
_set);
> +}
> +
> +late_initcall(bpf_fs_kfuncs_init);
> +
>  static const struct bpf_func_proto *
>  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
>  {
> --
> 2.34.1
>

