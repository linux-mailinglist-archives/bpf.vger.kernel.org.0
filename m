Return-Path: <bpf+bounces-14202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347927E0E82
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 10:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F21CB21443
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C045C8DB;
	Sat,  4 Nov 2023 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC5tGRbS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669B79F5
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 09:11:47 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7291BD
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 02:11:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so38207051fa.0
        for <bpf@vger.kernel.org>; Sat, 04 Nov 2023 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699089101; x=1699693901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH+rQxDmlxFhF26gknrez8QMhw5R6eXMcq3o8Qd5SfA=;
        b=EC5tGRbSV/dWXHAzuoNhRBNwN6H3rtN0YZHiXJrNyU+Xu7UWUyRpiFf8S5KcGYK4DE
         hvRlRU+x3jpSHrDl7cuVPd7It9lskcU1jre0ZRotOGknC8yqKZUOPdtqIuK9hKdM5jWG
         mL2zoa4UiU4geZKwzcBlXB4f3CSUgivEVGukCYUpi8WeBYoClNKj7/XV+BW9GLoH8y9P
         mY/kLQI5BSERj11Uw8xkWKnXl5rC+CUB3MGUcjIu/HJWxtCl3Mj4xXoqit/rboXGP0tJ
         NK862wucjjewKhyoJGPifhuVqMhDle4SAw0WdzryrTImEUpcROdannd4nQRZhYaJw+hH
         CG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089101; x=1699693901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KH+rQxDmlxFhF26gknrez8QMhw5R6eXMcq3o8Qd5SfA=;
        b=QfZEXprjjoinCxLxJDkjuvUXLpAa2w3kXlBxkK9N2W2qk9r2mN1mUmxy0VTdvpoVQP
         YWoLsfOw0KLSHKY5bHBjAQN3k5GF89EPCFtjez9uHnR2ywKIF1pPYtO2AWuziC1Zg4a0
         vd2GN+190Fi3IpiaQUFYfoDxZPPgIVhWt7ZAs6HBshD5BqjCOiCCSZYDYr3hgh+1l+J/
         qMZlQy4fVXhK2VEh1VW+EeucKPsLe+pGdswBfDUl8zrEdCV1DCQ+9GACPgzC0Irz5siH
         OeIwcLODOAowAY/OrmFCKknwnMe/QKxjB8i3IU0prcxdDkrVcTOn2ij9iH5lDUAb93s+
         e2Pw==
X-Gm-Message-State: AOJu0YyxE2bSBVkHdRV1kWqOYGuPk3Gusn3miPF+1T2dJo1MX/+zQfGH
	k1+lVC0I5yUw4Ct0uoiPj04VSz1tEWmO6NRyD9w=
X-Google-Smtp-Source: AGHT+IEipBRBhLM4Hj7N9FEbVXFdTzNKQtnn9sYQBVTJRCCPFLEv8Y1xEb0R6NbEXjUKf/bASDAHLHiHzzyVQUm7llU=
X-Received: by 2002:a19:915b:0:b0:505:8075:7c10 with SMTP id
 y27-20020a19915b000000b0050580757c10mr16879170lfj.25.1699089100630; Sat, 04
 Nov 2023 02:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104001313.3538201-1-song@kernel.org> <20231104001313.3538201-5-song@kernel.org>
In-Reply-To: <20231104001313.3538201-5-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Nov 2023 02:11:28 -0700
Message-ID: <CAADnVQJX8E_2vdacqrwgQ9+Hj0ogQJN80UGvOtjxNTQBpZ+eHA@mail.gmail.com>
Subject: Re: [PATCH v12 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	KP Singh <kpsingh@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 5:13=E2=80=AFPM Song Liu <song@kernel.org> wrote:
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

Song,

have you studied the prior attempt to add this kfunc?
https://lore.kernel.org/bpf/20220628161948.475097-1-kpsingh@kernel.org/

file instead of (dentry,inode) pair makes sense,
and restricting to "user." prefix makes sense to me as well,
but you need to cc vfs experts in the future.

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
> +       u32 value_len;
> +       void *value;
> +
> +       if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +               return -EPERM;
> +
> +       value_len =3D __bpf_dynptr_size(value_ptr);
> +       value =3D __bpf_dynptr_data_rw(value_ptr, value_len);
> +       if (!value)
> +               return -EINVAL;
> +
> +       dentry =3D file_dentry(file);
> +       return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, =
value_len);
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(fs_kfunc_set_ids)
> +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)

See earlier Al's point. Just sleepable is not enough.

