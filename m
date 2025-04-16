Return-Path: <bpf+bounces-56069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13285A90E67
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 00:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40407A3533
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 22:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E12356C1;
	Wed, 16 Apr 2025 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agmn3N//"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A61A2658
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841003; cv=none; b=YFEj0bXXTVxr3r52M8U553jR33aKnFD0laVn7KdsnJpzy5H/6cSydKF/5tb220qpZxT7ZJUjI3UsesWIvsdyJlWXyax+RrbS+fklmkiHFoJyLwi+8M11hifcc48qUDuSauWDlCoGHVKmwxeMJH2+7CJSSXmw58rFr0CaYG90V0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841003; c=relaxed/simple;
	bh=IQvxOqmGCdFuE6TMWHsE71vGWn+D8CL8wUMUbFkZeaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VN2r1W5ApfAThQaW9UxWCxRvpwhAZSmDTRnK4UwHWQO5+F/aKOj+Onjd6oUlYplDuiH3vS3sHJicjH9v8ycfHZtLvzRkJ6ncFqNKtP3FZY4Y/czL4RLjrkumWSsSEEnKbX7FLc2aZpjt+TF5Mn4rFcvWAhyY1Zk3eN/Hg4x2s+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agmn3N//; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3081f72c271so82362a91.0
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744841001; x=1745445801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue1ALbfdf7Z4x+3bQ+PsOxQcddwvyBDZCEZj4gdLtLE=;
        b=agmn3N//BgEZrogMA+DJjS6R3qpavlyX30aWErr88rEBn/V8ec4drJDn8e5353y63M
         JQm4Fu2NZQz3XpE8j46rGO++sU8iiLCgCazLdogUcDpokj4oF8P0CZ429sQWglgk0Kmi
         224EbUutqi3+JfaanYP4NphhfMVgtVtA0F0VvyvzF4V+czeTgJSw0UQ5dZjDQqCMUhD6
         mjOzOnd+aLWOIBy9QSAdyxeQFNfuvy/w9FMa5u/0lFeBHwPGYGeX/zG85HRjy8a2uWnZ
         cQc+tnBfShk21jGvAPxhuFGL0Drr/HT9hS9HlYCWSA/tta533uXLhbIqm9+X9BxvktNz
         yrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841001; x=1745445801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue1ALbfdf7Z4x+3bQ+PsOxQcddwvyBDZCEZj4gdLtLE=;
        b=C3FOrLC9FQVxAq99aNXYUfXXzrBXcJQP6jrUyct/gfNYXfkYO7tZiIBZjdXYpi6N6m
         31NZ6p8zMAyjV2kumvpR8iKoDn0I4eGn17eYyFpvWV7PsjQvs89181UotoTcSpqf+opJ
         tdezDAMOJEWZ3WlsCUbXvY+kspxB06PzVX7gtLxQFMFVur0v91byRhaPuwoZG5uq8LZ7
         sN5LQMuUDGZugzyrg2XgiQtrv5Czlflf1uF1jC2055h9ZrjXhsoigEhshFLPntHYo2kX
         6X4oKDfSjcC3ENwtXUuYSYDI0IIv2UTAuX31tot1LecgNAViTD65Uy2/w0sEAltFc2SC
         9CpA==
X-Forwarded-Encrypted: i=1; AJvYcCWQIlE2hGBgp9xXbux1+6rUrLvCrFUhm/yTMdWAgXY/unqMP6MBYFC/TCG0M1+1hGUcTFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUsIjTN+CJK5b3V5VKdF3qYp9nNUZd/CBCSSvaUypwCsKjQJ/
	udEhsZx5yK3was8mHdUzFtBYRMYJlEdlR2DXxtUNoIOU0Lf0la72gow81xhVgt0bWwsUY8o1jng
	2NfYBzFiVoPj07cg+3PI4LMnzR/U=
X-Gm-Gg: ASbGnctZQ3nT1wDPwMja9glPJMUD6ChJEahoYh8GvXsjs1+8WWjNP6mimOMI0pcLWsq
	ZVEHIzu9m7YBzH5Vg5V9Ym/tQjfQUuW1rnEy4XJ7mCuQEimozsNvKNBnQMPwUzgTs8GR6EykmXE
	C8Tr3hDjGiNCTdkGCLZCbJrS9ZW13noKeUtVC3mg==
X-Google-Smtp-Source: AGHT+IEfCYj/gpEUCG/GkN5laWFY8AdmFLS1a35qNsZJOF9m8XBJq1KqKwKOKNiVounGr/EhkVDcdiTaaS3GKyLntoA=
X-Received: by 2002:a17:90b:5188:b0:2fe:ba7f:8032 with SMTP id
 98e67ed59e1d1-30863f1840amr5371034a91.9.1744841001177; Wed, 16 Apr 2025
 15:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzbjeuMkJZnqL-E4x+mb744=sNWyaFaboKHY-V5ovWhqTQ@mail.gmail.com>
 <20250415232448.7066-1-kuniyu@amazon.com>
In-Reply-To: <20250415232448.7066-1-kuniyu@amazon.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Apr 2025 15:03:09 -0700
X-Gm-Features: ATxdqUF3yiEs9Q1EN2uCA4JASjdrEUgSFOXDx6FNbFotEo3H9KZa5Nmmp8yo3os
Message-ID: <CAEf4Bzbzo_bh-qq1pfjShAsY_6t_G+Aq+P31kYybBeN_XMN1=Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Allow bpf_int_jit_compile() to set errno.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	christophe.leroy@csgroup.eu, daniel@iogearbox.net, davem@davemloft.net, 
	gor@linux.ibm.com, hbathini@linux.ibm.com, hca@linux.ibm.com, 
	iii@linux.ibm.com, johan.almbladh@anyfinetworks.com, kuni1840@gmail.com, 
	linux@armlinux.org.uk, list+bpf@vahedi.org, luke.r.nels@gmail.com, 
	paulburton@kernel.org, puranjay@kernel.org, udknight@gmail.com, 
	xi.wang@gmail.com, xukuohai@huaweicloud.com, yangtiezhu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 4:25=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Date: Tue, 15 Apr 2025 16:10:42 -0700
> > On Mon, Apr 14, 2025 at 2:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > There are some failure paths in bpf_int_jit_compile() that are not
> > > worth triggering a warning in __bpf_prog_ret0_warn().
> > >
> > > For example, if we fail to allocate memory in bpf_int_jit_compile(),
> > > we should propagate -ENOMEM to userspace instead of attaching
> > > __bpf_prog_ret0_warn().
> > >
> > > Let's pass &err to bpf_int_jit_compile() to propagate errno.
> >
> > Is there any reason we are not just returning ERR_PTR() instead of the
> > approach in this patch? That seems more canonical within BPF
> > subsystem, if we need to return error for pointer-returning functions?
>
> From the comment in __bpf_prog_ret0_warn(), I thought BPF folks wanted
> to catch any JIT failure as a warning for syzbot etc, instead of returnin=
g
> an error to user.  Even it can be done by adding WARN_ON() to the caller
> of bpf_int_jit_compile() though.
>
> That's why I only set error in the -ENOMEM paths in patch 2, which is
> not a BPF problem at least.
>
> With Alexei's suggestion, we can suppress that case, but as -ENOTSUPP.
>
> What do you think ?

I'm not sure I follow this completely. My only suggestion is the
*mechanics* of delivering error code. Instead of setting error by
pointer, we can just return it as ERR_PTR(). The callers of
bpf_int_jit_compile() (verifier and core.c) can still swallow any
errors, if necessary and revert to original pointer. E.g., in
verifier, instead of:

func[i] =3D bpf_int_jit_compile(func[i]);
if (!func[i]->jited) {
    err =3D -ENOTSUPP;
    goto out_free;
}

you'd do:

struct bpf_prog *jit_prog =3D bpf_int_jit_compile(func[i]);
if (IS_ERR(jit_prog) || !jit_prog->jited) {
    err =3D -ENOTSUPP;
    goto out_free;
}
func[i] =3D jit_prog;


Again, it's just weird to pass error as an extra out parameter, that's all.

But I don't feel strongly about this, was just trying to suggest a
cleaner alternative.

