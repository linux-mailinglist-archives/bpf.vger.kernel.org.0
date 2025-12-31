Return-Path: <bpf+bounces-77631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D9CEC7BE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 995023016DF6
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC6219A79;
	Wed, 31 Dec 2025 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUYZMPZ0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574912CDBE
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767207669; cv=none; b=c3guho3/JiAUj+IHB2ZlhB+y9d3gkNVJ02hjOHCLSQa8bIQavH63RUotaEwqCi5X/bPQuZQyMGc2MhpjvcvsIEoDsh2j7qutMrkG64Euj1KYmVuCdyqIjxeZr1ySkoTXq8wZJDYRciuYEUY5UredTBJhJdALXtmUouemhqOk1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767207669; c=relaxed/simple;
	bh=KsLou18IVekifh0BOsY0KAVF2PPIHbCMMHwI00m6CUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gog8tQXG0C/zpeTMCsDQnCPZWEuJEydsUZopAtgppJoQNEHOZ2uR1/4c+wDhj/Q/7KJFDWVQa06qZLuKlVbCQrQ67dnVN8Mt65fYSeuYb3zsbhClNxxrtrmn7+7gcBk/xiPy8dxbj31nExQSOzFuED9UCvMchtQkainBwQzikW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUYZMPZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF5C19423
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767207669;
	bh=KsLou18IVekifh0BOsY0KAVF2PPIHbCMMHwI00m6CUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sUYZMPZ0EGgodbxQGnEYsB6zXWDVBNYiP+ZIi0nYcxVNKDBSZ3XDYNFjUmB1u7F1V
	 34JtVgT8ZHJJUw6VmDWcrgGnJG4Wp3R326gWcpQaLISY5DpWYmnJcYskAZmtBiwDFW
	 j/vzIDuVcX6+N0mBJlmJKL3RnKeVoMI0PpsWSgezNxsoAqMJifX5c//x5Cvd8cIu+a
	 MBOAh9lRWsEvFLUSGywj4ueGPu7U+GXtLMWJCpJ1YU3mOr5NX6BPXKIW3KvNGxTSB0
	 OwgT3GITHdRLIiN8Iwgn85LdbZNrYqCgf0dm0/hg4Os6o2oRU8GdHuPYY+xM1g9fH6
	 0aRxmOkq6Yvxw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b728a43e410so2093655366b.1
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:01:09 -0800 (PST)
X-Gm-Message-State: AOJu0YwR2x2IPotNRVsg7ARWMTep3eMm52aJ4gVhrYHMAJN62AASccrJ
	7gG3Qv7R7nqgpj0yee8v2NfGhEsB2+jdm3h1+0p0a0A8fBpFPhi4qVUVkBwKyxDfaWC08DNr3kW
	GRJHZUBVQ3tuKMSnBS6w80O4IjoiqXOM=
X-Google-Smtp-Source: AGHT+IHlha/RwNCjZbzMOl8MsmawYUHVirbTiHLy5kC2KujXiUNK+LH4NJGdRJIOKTY/rfeLI4Vdg/rBd1gJ7vUFzFk=
X-Received: by 2002:a17:907:6d21:b0:b7d:36bc:5fbe with SMTP id
 a640c23a62f3a-b8036f1128emr3540634066b.23.1767207667714; Wed, 31 Dec 2025
 11:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231171118.1174007-1-puranjay@kernel.org> <20251231171118.1174007-2-puranjay@kernel.org>
 <c1204513fe4da235d6b6b45eca9d0260a31e89ec.camel@gmail.com>
In-Reply-To: <c1204513fe4da235d6b6b45eca9d0260a31e89ec.camel@gmail.com>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 31 Dec 2025 19:00:55 +0000
X-Gmail-Original-Message-ID: <CANk7y0js_-wvW281NAbr2eaCmvMxBAyCDd0wtdf+7XGKKRxEVw@mail.gmail.com>
X-Gm-Features: AQt7F2oQ4C4mVFQDczeKVutHG4jtJeZXUTC41WPaDrQcweOjGcog_yt1jXZq_9A
Message-ID: <CANk7y0js_-wvW281NAbr2eaCmvMxBAyCDd0wtdf+7XGKKRxEVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Make KF_TRUSTED_ARGS the default for
 all kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 6:38=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> > Change the verifier to make trusted args the default requirement for
> > all kfuncs by removing is_kfunc_trusted_args() assuming it be to always
> > return true.
> >
> > This works because:
> > 1. Context pointers (xdp_md, __sk_buff, etc.) are handled through their
> >    own KF_ARG_PTR_TO_CTX case label and bypass the trusted check
> > 2. Struct_ops callback arguments are already marked as PTR_TRUSTED duri=
ng
> >    initialization and pass is_trusted_reg()
> > 3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
> >    call sites (always checked with || alongside is_kfunc_trusted_args)
> >
> > This simple change makes all kfuncs require trusted args by default
> > while maintaining correct behavior for all existing special cases.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Nit: I found two more textual appearances for KF_TRUSTED_ARGS:
>
>   File: fs/bpf_fs_kfuncs.c
>   71:65: * used in place of bpf_d_path() whenever possible. It enforces K=
F_TRUSTED_ARGS
>   379:47:/* bpf_[set|remove]_dentry_xattr.* hooks have KF_TRUSTED_ARGS an=
d
>
>   File: include/linux/bpf.h
>   756:15:  * passed to KF_TRUSTED_ARGS kfuncs or BPF helper functions.
>
>   File: kernel/bpf/verifier.c
>   12622:39:        * enforce strict matching for plain KF_TRUSTED_ARGS kf=
uncs by default,
>
>   File: tools/testing/selftests/bpf/progs/cpumask_failure.c
>   113:21:  /* NULL passed to KF_TRUSTED_ARGS kfunc. */
>
> >  Documentation/bpf/kfuncs.rst | 35 +++++++++++++++++------------------
> >  kernel/bpf/verifier.c        | 14 +++-----------
> >  2 files changed, 20 insertions(+), 29 deletions(-)
> >
> > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rs=
t
> > index e38941370b90..22b5a970078c 100644
> > --- a/Documentation/bpf/kfuncs.rst
> > +++ b/Documentation/bpf/kfuncs.rst
> > @@ -241,25 +241,23 @@ both are orthogonal to each other.
> >  The KF_RELEASE flag is used to indicate that the kfunc releases the po=
inter
> >  passed in to it. There can be only one referenced pointer that can be =
passed
> >  in. All copies of the pointer being released are invalidated as a resu=
lt of
> > -invoking kfunc with this flag. KF_RELEASE kfuncs automatically receive=
 the
> > -protection afforded by the KF_TRUSTED_ARGS flag described below.
> > +invoking kfunc with this flag.
> >
> > -2.4.4 KF_TRUSTED_ARGS flag
> > ---------------------------
> > +2.4.4 KF_TRUSTED_ARGS (default behavior)
> > +-----------------------------------------
>
> Nit:
> I think section should be renamed to 'kfunc parameters' and moved to a
> separate section before '2.2 Annotating kfunc parameters'.
> Sorry, should have commented about this yesterday.
>
> [...]

Thanks for finding these, I will make these changes and re-spin after
I get reviews from others too.

There is another aspect I want your opinion one:

Assume a kfunc returns an error when you pass in a NULL pointer for
some parameter, it checks for NULL as if it is not valid usage, it
returns an error. After this change, this kfunc will not return an
error at runtime, rather will be rejected by the verifier itself. This
should not be a problem for real programs right? I think we should
drop the second patch: "bpf: net: netfilter: Mark kfuncs accurately"
because these kfuncs have no real use case with NULL being passed to
them, only a self test tries to call them with NULL parameters, I
think we should change the self test to detect load failure and leave
these kfuncs without __nullable annotation. What do you think?

