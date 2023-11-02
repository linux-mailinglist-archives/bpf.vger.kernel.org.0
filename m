Return-Path: <bpf+bounces-13988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7950E7DF83A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E391C20F80
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F941DDE3;
	Thu,  2 Nov 2023 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGjJkLvo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77191DA5E
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:01:32 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8EF123
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:01:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c41e95efcbso178341366b.3
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698944489; x=1699549289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzN09WMIaiF3E7sVQSKmv7RLms1wIPYoqtDBzP7/1kw=;
        b=PGjJkLvoTEnEbKbFKBA/rdFxmA/ThifKs1ojiAN5Tw6/tVUa2W8ly2cGxDD4Sy34fV
         LaL3VIpdgahk7cEMhO9Pfr4Y3uo6lzDboMGhifjm4kjiWewaOYt1P7qlBYVmNHiv3bTP
         BDRpCOVGJB0cg3Yh6VeKATNkhzyDIAiI+yQwfORr70JRa2rIIBN3hbCSzMHjg1X1GO3d
         io6FtowxiIVvxL5Nb/zZLouZGa18SoGGyJTWVUhV89hJq5uP7ubBYQiU5Jl/yPp3xsmD
         SfJX5WaegKYrrX+qD6KJwF/OEMP5Qa78TK4d9OBVKRggPFEKo2imXNGVYZtVqT5sFAfS
         NETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698944489; x=1699549289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzN09WMIaiF3E7sVQSKmv7RLms1wIPYoqtDBzP7/1kw=;
        b=as68ndvYamsSGq5584uStfeCu3ld5Dg00TzUZiqRz7nMOfwQDvoQgD7Z19g567a3Lb
         V6cGMq07j4Dw5rWZfU0xDxD700rs0BDq/zTgG+Tzrb/1uorzg7rmFBXrghwwfp+N4K1g
         oBwT6DVvOr0VBzO4rvpxJ4Z6QBQ6YENUCG7P79vHymEbcp6e4V6aerX2TY1Jbwhww2LY
         aYRZyeN6QWWpdLC3CgVrT1JUYj7f5UMfedhWVYIpc1mzAmwobOXfWePWThRlkLkT8NMn
         8uZ7RbLnYW8xnP5ChqovhiSvNrBY9rA9vjiTjA/p9UlCT/H/9mVuHYWxiO83QZX4/7ip
         EJ4g==
X-Gm-Message-State: AOJu0YzXbaV55vLKboJgnRE4lXzwB9KBMY5dK9sIDuKIwJ8uIUMxv6IG
	+Aa8COjT4oifkFMklN9CCJ9hCYbTfDVftU0xoemXJJYA
X-Google-Smtp-Source: AGHT+IGG5vWpdJsyZGD7QM+4RAIrmNWizY3RRRubkvSE/zlMLNeESHvZHrCpQUstCH0lKZSlcSJ55k+sSn3bgi2UPF8=
X-Received: by 2002:a17:906:51ce:b0:9ae:52fb:2202 with SMTP id
 v14-20020a17090651ce00b009ae52fb2202mr4397459ejk.40.1698944489036; Thu, 02
 Nov 2023 10:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024235551.2769174-1-song@kernel.org> <20231024235551.2769174-5-song@kernel.org>
In-Reply-To: <20231024235551.2769174-5-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 10:01:17 -0700
Message-ID: <CAEf4Bzbu2YruzOnWDTkua=VTDMJi8P+BZYC_ntrLOC6QkG3oSA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:56=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> It is common practice for security solutions to store tags/labels in
> xattrs. To implement similar functionalities in BPF LSM, add new kfunc
> bpf_get_file_xattr().
>
> To avoid recursion, bpf_get_file_xattr can be only called from LSM hooks.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 59 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2626706b6387..802181986ad3 100644
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
> @@ -1436,6 +1437,64 @@ static int __init bpf_key_sig_kfuncs_init(void)
>  late_initcall(bpf_key_sig_kfuncs_init);
>  #endif /* CONFIG_KEYS */
>
> +/* filesystem kfuncs */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "kfuncs which will be used in BPF programs");

Dave just added convenient macros for kfunc definition regions, please
use them for new code.

> +
> +/**
> + * bpf_get_file_xattr - get xattr of a file
> + * @file: file to get xattr from
> + * @name__const_str: name of the xattr
> + * @value_ptr: output buffer of the xattr value
> + *
> + * Get xattr *name__const_str* of *file* and store the output in *value_=
ptr*.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__=
const_str,
> +                                  struct bpf_dynptr_kern *value_ptr)
> +{
> +       struct dentry *dentry;
> +       void *value;
> +
> +       value =3D bpf_dynptr_slice_rdwr(value_ptr, 0, NULL, 0);

This is very confusing and looks wrong. You are passing requested size
0, which is certainly not the intent of this API.
As I mentioned in previous patch, let's add internal-only dynptr
helper that will return pointer and separately we already have a
helper to get dynptr size, and do that explicitly.

> +       if (IS_ERR_OR_NULL(value))
> +               return PTR_ERR(value);
> +
> +       dentry =3D file_dentry(file);
> +       return __vfs_getxattr(dentry, dentry->d_inode, name__const_str,
> +                             value, __bpf_dynptr_size(value_ptr));
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(fs_kfunc_set_ids)
> +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
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

