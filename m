Return-Path: <bpf+bounces-13876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 139E87DE9F1
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82C9B2111B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC51F15B8;
	Thu,  2 Nov 2023 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQfuta9W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8515AC
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 01:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F387DC433CD
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 01:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698887986;
	bh=L/oIBZWNwYWfO9paAjPVkqSlKsZsAbx1VcI8buvd3Mg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OQfuta9WTZ0CvEjS7PLunS/OJR1TTwZENa5D3KVOqKvT+PUhv3QhOE7cnw+uKQpQE
	 5mJGMxGlL5uDqAxJziEnjtQUEeVtW1lttW737vvns4DpU35TSyx4EuLs/AWpNpjgdm
	 Wpwy1hPLGfjQbzVxqr07yfHIKv0LD7Tax7xHGZoRsiNGszozCR99Omz9MIgG0qspl8
	 mqoroICzcsKXKr9MVfYVoHD0rJBEQefYkSTP3V10wqutgQLhqhlmBrJjU6C19CL1eN
	 L6yBp+aEZq1pdgExPXl1Y8E018zUHuD5FA6PMry+mNxQ5CqDu74DiBDo3ll72QDjTK
	 n/fYZ1297r4zA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so815593a12.1
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 18:19:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YwRHHuZGOUew+p+eBH4zpR+hyxQC6TqkVzjKTiQArtI4mCIUm6M
	KxqcKb4jO8zleSriK/zO98E1as/KV/f8jgW2mKjDOA==
X-Google-Smtp-Source: AGHT+IHRwnrYCM8u0Xkx7s8wzLF8rI7K+5LthsF0HLjZNf92tBCMzXU35cQWCtPEHuewuI5pK9cewkWwT6jVtb0Hhe8=
X-Received: by 2002:a05:6402:3482:b0:52b:db44:79e3 with SMTP id
 v2-20020a056402348200b0052bdb4479e3mr4224453edc.4.1698887984323; Wed, 01 Nov
 2023 18:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013182644.2346458-1-song@kernel.org> <20231013182644.2346458-2-song@kernel.org>
 <CAADnVQLcrxLatupH=i2Q-K8KRF72PqB8wayC=UEKvuMMn3ie7A@mail.gmail.com>
In-Reply-To: <CAADnVQLcrxLatupH=i2Q-K8KRF72PqB8wayC=UEKvuMMn3ie7A@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 2 Nov 2023 02:19:33 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4=8TwRS4xGm3G81LtkYLWtwZY0G2OvK25TTrF5Fyppwg@mail.gmail.com>
Message-ID: <CACYkzJ4=8TwRS4xGm3G81LtkYLWtwZY0G2OvK25TTrF5Fyppwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 9:11=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 13, 2023 at 11:30=E2=80=AFAM Song Liu <song@kernel.org> wrote=
:
> > +__bpf_kfunc int bpf_get_file_xattr(struct file *file, struct bpf_dynpt=
r_kern *name_ptr,
> > +                                  struct bpf_dynptr_kern *value_ptr)
> > +{
> > +       if (!bpf_dynptr_is_string(name_ptr))
> > +               return -EINVAL;
> > +
> > +       return vfs_getxattr(mnt_idmap(file->f_path.mnt), file_dentry(fi=
le), name_ptr->data,
> > +                           value_ptr->data, __bpf_dynptr_size(value_pt=
r));
> > +}
> > +
> > +__diag_pop();
> > +
> > +BTF_SET8_START(fs_kfunc_set)
> > +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>
> I suspect it needs to be allowlisted too.
> Sleepable might not be enough.
>
> KP proposed such kfunc in the past and there were recursion issues.
>
> KP,
> do you remember the details?

yeah, have a look at Al's reply:

https://lore.kernel.org/bpf/Yrs4+ThR4ACb5eD%2F@ZenIV/

it can create deadlocks and potentially UAFs (similar to the situation
Jann mentioned). This will need to be allowlisted.

