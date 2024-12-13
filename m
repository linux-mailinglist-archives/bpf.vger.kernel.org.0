Return-Path: <bpf+bounces-46932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E32AA9F193B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2FD1887C4C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A41A8F7F;
	Fri, 13 Dec 2024 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW3lER0n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA041990D3;
	Fri, 13 Dec 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129468; cv=none; b=ZuGWcfAY5BSC1JKCymunpoQYgG0kwt1A3rGtfwtJw4p/AVS1Bt/Wsc/oHvtaVY7Ede8Ebv7G4ks80HE4ApRABtQZv+7/p1jGgXbjNZzk/Uy6AkM59B+Ojejlj6UYFsAJU/x1oCBu3xWJgQxjBhBrJhmahKoOZWSij7n5wiSVumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129468; c=relaxed/simple;
	bh=81jXWzGgVj5P/+Rf/fAGsJWom3OTAo/+o24ZBUE4dlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqBS/sfda+OA1t4hxYYrsV3hrPPMKDQMNgYHiQn1LOEIPPYZU9Yd6039VruPTzMoV0FDbjMdx6rNN0z4MvngqZbWTO/DUzJyFSguc6OqxM8fotcbeDqkOGg1qGMGliMm+m764I8aNMRGu8gNFJwYJl9n/hmjPMdzk90gsJNGpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW3lER0n; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so1793590b3a.2;
        Fri, 13 Dec 2024 14:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734129466; x=1734734266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2XKgZuFQyyfU7RdsoHZM90CbUi6+mpj7bqnOu/9cpc=;
        b=UW3lER0n1xe5c2ZT8jmqH9wSquphMkIx0L6sH53hD9f52GCm6cs7WMHSZtP9r4PXGS
         pIalMvk+lbavUKuTyHj5m3Z+AbWOBIH+i1B45XxOzampO+V1wALF6VYW6BDRM6wBMWWz
         VKj4loA48bsPa+bZ0369SglWO/XhfJpJrh0ewjzdNIR5uE3AQSyiDArDK6XD3TAJAAi0
         ElitXVX98KfPJtGfyabsyBHWaMH09OIVl9a89EDCdbrXUiMO+eqvTIAGr3/L3tBy8cOw
         MKzu2XnnXEwI54wvyA87nI5EW/Rx1Cb8r0shO3WvVPp881f9+/YsDu8BNVukJ9zuah4m
         sLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734129466; x=1734734266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2XKgZuFQyyfU7RdsoHZM90CbUi6+mpj7bqnOu/9cpc=;
        b=vT1L+mob8dO8H/sXDSWd+ZRu17MBWeU6rMU17gUMYh9TRZIMNNysQhnubXi03GsQ9H
         1HTh7fVQd7T/lXKpII1snAMttImLjiudidkGEkhouQYfb/N6bYMbY1blEoWvXIvQhBz8
         NPLR2MEqY2AZfV9a1XjTe7h2abh/V0zGHRGrZ22p28paVFrh5d3WpOEEPSXnHZwRBV+L
         XpmYYefAHSKqO/qtgKdIvMg0wcltMuo7lvDmdFROJ2QUNgTqgcRMHUs9YJNBcIw5B0zi
         tlJrYNsR7WivVdwV3UguFNSVbk/tW5YsA8Zlf89uGh8itwFrWu35Nf6yN0FJDLpOETne
         gIJg==
X-Forwarded-Encrypted: i=1; AJvYcCURpLTkETzo/pgYistw2eMbJpe6aGlNpJSKyszZLv/ixI64FV/AZQIwmwwRv1azdHUoZLAAIng+@vger.kernel.org, AJvYcCUoCNIVvAhBfY5Gd5Gim9CCAhQWJvE+YWrcvk5GsLOZx9PsplNfbzw1OI9aaG2alHTHGVL7Ppdf0t0XlyIa@vger.kernel.org, AJvYcCVfEZMuVDXIH4TX5/kuccPKRoNH3wwhe/wXbjWN8ADUIrkbFanAnGWuuYn7KUO3k04vDxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcyzy7vYmfUcfII5nBkMlc2oKCbgizTU+gLKsCwS1Iqo7enBmb
	IgZvKFlbGLrWfP4YNT0tROShTv5aeMVrLx4kj+3gu8+Q4AtQh+pomcHuSjbufvhhHT7Zi80pHFP
	lvK0orKsBAfTpl3HGxoJga17JfWE=
X-Gm-Gg: ASbGncvvAAE72Kh23lD73XbOWNbzXKq8Du6fLGi1bawUSlin/uIHDPHVJwhSLVly231
	/ZCiJVBoqWincRhbTikWJeJhHobLxsol1iXYB0Vx6dKpMwAkMLpTfrw==
X-Google-Smtp-Source: AGHT+IG28L89pez1ix4a3KmgU7/9lQ5A+1K/3u8JoEQN9raWn9zR8hFl8irzXrnUyBtmlD/nfb06qVpU86x5S1ekrN0=
X-Received: by 2002:a17:90b:6cc:b0:2ee:a76a:830 with SMTP id
 98e67ed59e1d1-2f290d9876bmr7249119a91.24.1734129466120; Fri, 13 Dec 2024
 14:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-bpf-cond-ids-v1-1-881849997219@weissschuh.net>
 <CAEf4BzYTYDcf7J0jhJP3cW5489jWXdfJcw-f-8yuTHcNmQ0cbw@mail.gmail.com> <a19b5fb2-9a82-42f2-81dd-17d96bb6ec9e@t-8ch.de>
In-Reply-To: <a19b5fb2-9a82-42f2-81dd-17d96bb6ec9e@t-8ch.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 14:37:32 -0800
Message-ID: <CAEf4BzY22-ZEOgwuvCY-UKYza-OFAfDwh4Sno6o8iBfi_VNGyg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix configuration-dependent BTF function references
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 3:37=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-12-12 15:27:12-0800, Andrii Nakryiko wrote:
> > On Thu, Dec 12, 2024 at 3:00=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@we=
issschuh.net> wrote:
> > >
> > > These BTF functions are not available unconditionally,
> > > only reference them when they are available.
> > >
> > > Avoid the following build warnings:
> > >
> > >   BTF     .tmp_vmlinux1.btf.o
> > > btf_encoder__tag_kfunc: failed to find kfunc 'bpf_send_signal_task' i=
n BTF
> > > btf_encoder__tag_kfuncs: failed to tag kfunc 'bpf_send_signal_task'
> > >   NM      .tmp_vmlinux1.syms
> > >   KSYMS   .tmp_vmlinux1.kallsyms.S
> > >   AS      .tmp_vmlinux1.kallsyms.o
> > >   LD      .tmp_vmlinux2
> > >   NM      .tmp_vmlinux2.syms
> > >   KSYMS   .tmp_vmlinux2.kallsyms.S
> > >   AS      .tmp_vmlinux2.kallsyms.o
> > >   LD      vmlinux
> > >   BTFIDS  vmlinux
> > > WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
> > > WARN: resolve_btfids: unresolved symbol bpf_crypto_ctx
> > > WARN: resolve_btfids: unresolved symbol bpf_send_signal_task
> > > WARN: resolve_btfids: unresolved symbol bpf_modify_return_test_tp
> > > WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
> > > WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > ---
> > >  kernel/bpf/helpers.c  | 4 ++++
> > >  kernel/bpf/verifier.c | 8 ++++++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 751c150f9e1cd7f56e6a2b68a7ebb4ae89a30d2d..5edf5436a7804816b7dcf=
1bbef2624d71a985f20 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -3089,7 +3089,9 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQ=
UIRE | KF_RCU | KF_RET_NULL)
> > >  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
> > >  BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
> > >  BTF_ID_FLAGS(func, bpf_throw)
> > > +#ifdef CONFIG_BPF_EVENTS
> > >  BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
> > > +#endif
> > >  BTF_KFUNCS_END(generic_btf_ids)
> > >
> > >  static const struct btf_kfunc_id_set generic_kfunc_set =3D {
> > > @@ -3135,7 +3137,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> > >  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> > >  BTF_ID_FLAGS(func, bpf_dynptr_size)
> > >  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> > > +#ifdef CONFIG_NET
> > >  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
> > > +#endif
> >
> > It makes little sense to have bpf_prog_test_run_tracing() and
> > bpf_modify_return_test_tp() depend on CONFIG_NET... It's just
> > historically where BPF_PROG_TEST_RUN functionality was implemented,
> > but it seems like we need to move bpf_prog_test_run_tracing() and
> > other tracing-related testing stuff into kernel/trace/bpf_trace.c or
> > somewhere under kernel/bpf/ (core.c? helpers.c?)
>
> I agree. But today these are the config values which are in effect.
> When the functions get moved, the config values can be adapted.
> With my commit "kbuild/btf: Propagate CONFIG_WERROR to resolve_btfids"
> in bpf-next the warnings can actually become errors.
> So I'd propose to apply this fix to avoid issues in the near future and
> then do a proper move without any urgency.
>

Fair enough.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> > >  BTF_ID_FLAGS(func, bpf_wq_init)
> > >  BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> > >  BTF_ID_FLAGS(func, bpf_wq_start)
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 5e541339b2f6d1870561033fd55cca7144db14bc..77bbf58418fee7533bce5=
39c8e005d2342ee1a48 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -5526,7 +5526,9 @@ static bool in_rcu_cs(struct bpf_verifier_env *=
env)
> > >
> > >  /* Once GCC supports btf_type_tag the following mechanism will be re=
placed with tag check */
> > >  BTF_SET_START(rcu_protected_types)
> > > +#ifdef CONFIG_NET
> > >  BTF_ID(struct, prog_test_ref_kfunc)
> > > +#endif
> > >  #ifdef CONFIG_CGROUPS
> > >  BTF_ID(struct, cgroup)
> > >  #endif
> > > @@ -5534,7 +5536,9 @@ BTF_ID(struct, cgroup)
> > >  BTF_ID(struct, bpf_cpumask)
> > >  #endif
> > >  BTF_ID(struct, task_struct)
> > > +#ifdef CONFIG_CRYPTO
> > >  BTF_ID(struct, bpf_crypto_ctx)
> > > +#endif
> > >  BTF_SET_END(rcu_protected_types)
> > >
> > >  static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
> > > @@ -11529,8 +11533,10 @@ BTF_ID(func, bpf_rdonly_cast)
> > >  BTF_ID(func, bpf_rbtree_remove)
> > >  BTF_ID(func, bpf_rbtree_add_impl)
> > >  BTF_ID(func, bpf_rbtree_first)
> > > +#ifdef CONFIG_NET
> > >  BTF_ID(func, bpf_dynptr_from_skb)
> > >  BTF_ID(func, bpf_dynptr_from_xdp)
> > > +#endif
> > >  BTF_ID(func, bpf_dynptr_slice)
> > >  BTF_ID(func, bpf_dynptr_slice_rdwr)
> > >  BTF_ID(func, bpf_dynptr_clone)
> > > @@ -11558,8 +11564,10 @@ BTF_ID(func, bpf_rcu_read_unlock)
> > >  BTF_ID(func, bpf_rbtree_remove)
> > >  BTF_ID(func, bpf_rbtree_add_impl)
> > >  BTF_ID(func, bpf_rbtree_first)
> > > +#ifdef CONFIG_NET
> > >  BTF_ID(func, bpf_dynptr_from_skb)
> > >  BTF_ID(func, bpf_dynptr_from_xdp)
> > > +#endif
> > >  BTF_ID(func, bpf_dynptr_slice)
> > >  BTF_ID(func, bpf_dynptr_slice_rdwr)
> > >  BTF_ID(func, bpf_dynptr_clone)
> > >
> > > ---
> > > base-commit: 5d287a7de3c95b78946e71d17d15ec9c87fffe7f
> > > change-id: 20241212-bpf-cond-ids-9bfbc64dd77b
> > >
> > > Best regards,
> > > --
> > > Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > >

