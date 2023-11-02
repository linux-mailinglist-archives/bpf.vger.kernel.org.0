Return-Path: <bpf+bounces-13878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B007DEA01
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 02:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6178D2819B8
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B415BA;
	Thu,  2 Nov 2023 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp6fqneF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A1111F
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 01:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3BDC433CD
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 01:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698888471;
	bh=/MTeM9OXTTKZ4ju4/4YY4chRCXEamfIwXV7Rv7qDHBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fp6fqneFN+UhXbcy2dexdHhPjgIFau5BLdQR0N1rfUUCwcEqgX3/+JXbQIa7aMgoA
	 zC0STOF59U/5UVdA4GKgGkWQ3YDAyCE6i3kEp8lFede+j15vg+7G9CSm2a4WQQiS82
	 LWhFa+wdWN/C9W3wmefIX350YScYoYGgDvADUSg19ua7qiE8ESPa5Cx7uYUqO0FdZ4
	 0vVWSXFgBT5qSGgDcsWNBdRqA274bFSK18ea13F95CuWSwhsEaq8aMRCyL9JDwBJHl
	 LGyKBK/xtlV3zUoqvHAL8o1nYvRHfg2JGsShr1kVTJdc5BkdP5V6XqXP+0tYEBM5ql
	 3Wvuls/HAKRcA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-507a62d4788so468117e87.0
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 18:27:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YwWsdr8OBCkM4vox9NH/C4TYUn/UCkWciWF1aWz20rGrNPukU7l
	b/HhLeNeENxx0yw4s8M3VKXjsUqi6/47BscWHeLI/w==
X-Google-Smtp-Source: AGHT+IGl+owG4HyE+kq6BBVOXDiFxSFk1o2PQKEGPiU38rVzSstMo8Yqq9ZlAR9kvKYw/VN4FezIyMmMoi+YJYTvMAQ=
X-Received: by 2002:a05:6512:2248:b0:4fe:7e7f:1328 with SMTP id
 i8-20020a056512224800b004fe7e7f1328mr16546233lfu.16.1698888469382; Wed, 01
 Nov 2023 18:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023061354.941552-1-song@kernel.org> <20231023061354.941552-5-song@kernel.org>
In-Reply-To: <20231023061354.941552-5-song@kernel.org>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 2 Nov 2023 02:27:38 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7mz91WuvC=9CWA-ewh6ywCHseiH5-dY0jOA0Piw3jQ-g@mail.gmail.com>
Message-ID: <CACYkzJ7mz91WuvC=9CWA-ewh6ywCHseiH5-dY0jOA0Piw3jQ-g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 8:14=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> This kfunc can be used to read xattr of a file. To avoid recursion, only
> allow calling this kfunc from LSM hooks.

I think this needs a bit more explanation in the commit message (some
details on what it could be used for, we can explain the use case
about persistent LSM policy and LSM signatures with FSVerity). I know
you add a selftest but some more details in the commit message would
help.

What about adding the KF_TRUSTED_ARGS for the kfunc?



>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 56 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 43ed45a83ee2..4178d0e339d3 100644
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
> @@ -1436,6 +1437,61 @@ static int __init bpf_key_sig_kfuncs_init(void)
>  late_initcall(bpf_key_sig_kfuncs_init);
>  #endif /* CONFIG_KEYS */
>
> +/* filesystem kfuncs */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "kfuncs which will be used in BPF programs");
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
> +static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kf=
unc_id)
> +{
> +       /* Only allow to attach from LSM hooks, to avoid recursion */
> +       return prog->type !=3D BPF_PROG_TYPE_LSM ? -EACCES : 0;
> +}
> +
> +BTF_SET8_START(fs_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
> +BTF_SET8_END(fs_kfunc_set)
> +
> +const struct btf_kfunc_id_set bpf_fs_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &fs_kfunc_set,
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
>

