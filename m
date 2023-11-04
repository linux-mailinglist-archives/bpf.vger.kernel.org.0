Return-Path: <bpf+bounces-14208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA27E0FDF
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24E0281D03
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7F11A5A6;
	Sat,  4 Nov 2023 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5z234Va"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3451A591
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 14:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D6C433C9
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699107625;
	bh=wZpOCAU5mY7uFfo9DV98+jAKBckA2RTB7y7ZgaNtx6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o5z234VaMJBz7suMBtcKHsVOLTg23kjAnfPqXscJAnazGXfvzcWBJMA7stFTdPsv2
	 GW/xIk35SQ49DG+gOPmIHqcLZL/URNvpcqls2ec8JdXe7OU0/Gxurs5cPZy4iTSVj8
	 aSa0RqbO7Bd6CcCN05v5AVt/1ANhq1UnW+rrLHN7asRwwZJKy7XFdeFoVnUq+rvKkS
	 12ge45ISZknYpOuor01xU6HCubc4dVxF6H4XQwSNDGpbPmk6hoXSWqJvQZpAAGMIje
	 hE52to7juLuVZLm//5YPZQp2nsHFs1D4G1T5Z5g0K3Sl7hLOizIYRXKX2XX20VrLJX
	 I2KHKFTA/CW5g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so3257296e87.0
        for <bpf@vger.kernel.org>; Sat, 04 Nov 2023 07:20:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxRQvvz9JUNPtSsaTv+L6m8KYnf3RnkJePNPSerx5/+N/RvNZQT
	B2r4N56SWfC6ol2KuIts2LizbcUa6e8wIDxcO7Q=
X-Google-Smtp-Source: AGHT+IH60DHhtEiSeA0J868tqohhwMKB1L+HEPn1/tOmFiUiL+j8HDOny2rPXCqd3v1ghchNr7MVEWeA3LxlC7FdKNs=
X-Received: by 2002:ac2:4d96:0:b0:504:879c:34ac with SMTP id
 g22-20020ac24d96000000b00504879c34acmr1978732lfe.31.1699107623491; Sat, 04
 Nov 2023 07:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104001313.3538201-1-song@kernel.org> <20231104001313.3538201-5-song@kernel.org>
 <CAADnVQJX8E_2vdacqrwgQ9+Hj0ogQJN80UGvOtjxNTQBpZ+eHA@mail.gmail.com>
In-Reply-To: <CAADnVQJX8E_2vdacqrwgQ9+Hj0ogQJN80UGvOtjxNTQBpZ+eHA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Sat, 4 Nov 2023 07:20:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6L8W+L33LWW667=fb=RgCdrPu6tBXEuRpg4E3NUXj6MQ@mail.gmail.com>
Message-ID: <CAPhsuW6L8W+L33LWW667=fb=RgCdrPu6tBXEuRpg4E3NUXj6MQ@mail.gmail.com>
Subject: Re: [PATCH v12 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	KP Singh <kpsingh@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Sat, Nov 4, 2023 at 2:11=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 3, 2023 at 5:13=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > It is common practice for security solutions to store tags/labels in
> > xattrs. To implement similar functionalities in BPF LSM, add new kfunc
> > bpf_get_file_xattr().
> >
> > The first use case of bpf_get_file_xattr() is to implement file
> > verifications with asymmetric keys. Specificially, security application=
s
> > could use fsverity for file hashes and use xattr to store file signatur=
es.
> > (kfunc for fsverity hash will be added in a separate commit.)
> >
> > Currently, only xattrs with "user." prefix can be read with kfunc
> > bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefi=
x
> > for bpf_get_file_xattr().
> >
> > To avoid recursion, bpf_get_file_xattr can be only called from LSM hook=
s.
>
> Song,
>
> have you studied the prior attempt to add this kfunc?
> https://lore.kernel.org/bpf/20220628161948.475097-1-kpsingh@kernel.org/

I studied this thread, and I think I addressed the concerns.

> file instead of (dentry,inode) pair makes sense,
> and restricting to "user." prefix makes sense to me as well,
> but you need to cc vfs experts in the future.

I will cc vfs experts and lists for future versions.

>
> > + * For security reasons, only *name__str* with prefix "user." is allow=
ed.
> > + *
> > + * Return: 0 on success, a negative value on error.
> > + */
> > +__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name=
__str,
> > +                                  struct bpf_dynptr_kern *value_ptr)
> > +{
> > +       struct dentry *dentry;
> > +       u32 value_len;
> > +       void *value;
> > +
> > +       if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN=
))
> > +               return -EPERM;
> > +
> > +       value_len =3D __bpf_dynptr_size(value_ptr);
> > +       value =3D __bpf_dynptr_data_rw(value_ptr, value_len);
> > +       if (!value)
> > +               return -EINVAL;
> > +
> > +       dentry =3D file_dentry(file);
> > +       return __vfs_getxattr(dentry, dentry->d_inode, name__str, value=
, value_len);
> > +}
> > +
> > +__diag_pop();
> > +
> > +BTF_SET8_START(fs_kfunc_set_ids)
> > +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>
> See earlier Al's point. Just sleepable is not enough.

In bpf_get_file_xattr_filter() we only allow calling
bpf_get_file_xattr from LSM hooks.
AFAICT, this is enough to avoid deadlock. We still need KF_SLEEPABLE here
because xattr_handler->get() may block (lock xattr_sem).

Did I miss something?

Thanks,
Song

