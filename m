Return-Path: <bpf+bounces-61202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1388AE226C
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 20:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784BA4A185A
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB32E8E17;
	Fri, 20 Jun 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByxhSweY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61974136988
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445100; cv=none; b=oLESLfPUrV61KTtdDnhrUCKejpGgX/vDV4LHGQxVvhXv50wflbdCgzkvju3aIIqBfaOI6pcPeOhEWR6yBJr3M59EjOxk6/D1yx3oOuqHSLC6L4vPCcsom0DwIbFKS87u3SyHsq9RnsHjSWnxQPjEjMU+9cDl9+80Duhgkk7m2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445100; c=relaxed/simple;
	bh=5vbD8W5ON9XpQvqYnqZwnDg+jK/SpCYn6G/DdF8JhDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQ0lsCG9elPJDz+NrdhYUP9y+2n5Dz1a2NPjep+oJeV+Ahcp601d3+F/XTijgA0pqy/FS7NI+0IwNVSDt9lQxrxFJYoxBKKig80Y5loQDrk3afRUENVwhXbJpeJh1Elrx+JSnWrEHjf6V2qoMzosWpcmXeDi7KaKSLWa5AE4kLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByxhSweY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4f379662cso1911787f8f.0
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445097; x=1751049897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AMEIfyPVUvAJFqYenKwjIOGas+M/hHgODPnYxiQsUU=;
        b=ByxhSweYiBdPBDY4WYkjhO1fpLgCtjyxtou+QuapuEVWSaOacVGxWgr+eHQ9auH9he
         EycI/ZTE4ORh0aLDlhRBBhDA82v4ziPyYLHh06faQn728wKrSkAjd+/lT6tYgG+eV8me
         LAN/EW9ozbkWUVirHehSFa98DM0osEMIUGelXIGNxN6XZFchvdyhkXqA3cqKY/3GpJTv
         GoS0CohVFaGjLbFoPw5P7m4jEccfBFx4Wvu4SrE3iGIVjKGzNBlroet5L11UMO9eoarv
         TPK4m0a37fl1h1CuQJCZ4MlqeGlIrgvQpULg4O5U52ZLFFyIUS18Crxsvq19DE1dMGKP
         lZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445097; x=1751049897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AMEIfyPVUvAJFqYenKwjIOGas+M/hHgODPnYxiQsUU=;
        b=SLO16ZCAVGL1RB41zFDOkJ5fVz1F+At407dg17pFlHegb9qZKjo0Dz747XtUYwaX7h
         E3zg3ZG99jmov8kNlLDayNKn611/g93/5Wda1dKXgdJQVqvW/lNOklWhaoeVAt8I41lL
         U1prrU2W3aHAh0z502e62kyaGKyHQeEZj+yeWMb0158vU1lA5ZOtK1Df33kFgfOjLPvy
         MAxH2VS42ppHLiKCLPAVpzcLeR3l28IcfNgQ9ET/X26hYCv2Xit3Oa/qElyDmvqSHGjw
         exyhaMiAMyofrTpRoDN0ou5ykKj/KKe1p6L5rCGMh4xlmjGH+oGKsL9J+5CKVon9nbeC
         NNgA==
X-Gm-Message-State: AOJu0YwltIdCrvDupgMI5qe87h5hGFyUR1ZFdZ30ZPGVWnZ0CmNtJe7x
	gBcgURt+PPLy9a5ygSPaE0Xwjmreca6zL7sVJZm2b7L+fK7IjMTztY2QHcVc3u/+muLOGjfgRE5
	W0YaF1HX2hP/9L6BGwdON6Rd/+DpKvMA=
X-Gm-Gg: ASbGnctudjbbfGelCrcSbcHPkLgOUgKq23/J7Uf/nTp8+JKiiNdxW2W2FUky4qk2rOw
	RYib/HvX1AJ7u4jY2/xpIPSaF19lSNQbUGnNfxKfJnhVhjug9lz3rOoXFyQJtirDjJ3Jwyg8zRj
	IzCDk68ZDYlQZLza1Q3kTh5gdMObax4cZn7bpNSDeOZ204vdZhUgU6CafQYIE8/olXP+vqAd5s
X-Google-Smtp-Source: AGHT+IEpqyPJ60L+zKYmsp8uRMK/UuSK/dHiUH45AqdFFWKuN5pXx0SSk2d3em/I+8joQEoOgRMbQAUJrojAYct7b2g=
X-Received: by 2002:a05:6000:4203:b0:3a4:fea6:d49f with SMTP id
 ffacd0b85a97d-3a6d12eb49emr2989572f8f.49.1750445096584; Fri, 20 Jun 2025
 11:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620031118.245601-1-emil@etsalapatis.com> <20250620031118.245601-2-emil@etsalapatis.com>
In-Reply-To: <20250620031118.245601-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Jun 2025 11:44:45 -0700
X-Gm-Features: Ac12FXzplOl-ApR-s16_20y6tgBDzFnRegunreiReCp7MyY-lE4x06pO7hrtTAQ
Message-ID: <CAADnVQ+m3mRoiiFwbYsVb8rbcsTy0dgS7amYn82y7wgyv5U1Yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/arena: add bpf_arena_guard_pages kfunc
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 8:11=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> Add a new BPF arena kfunc from protecting a range of pages. These pages
> cannot be allocated, either explicitly through bpf_arena_alloc_pages()
> or implicitly through userspace page faults.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 92 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 0d56cea71602..2f9293eb7151 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -48,6 +48,7 @@ struct bpf_arena {
>         u64 user_vm_end;
>         struct vm_struct *kern_vm;
>         struct range_tree rt;
> +       struct range_tree rt_guard;

...

>  }
> @@ -282,6 +298,11 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vm=
f)
>                 /* User space requested to segfault when page is not allo=
cated by bpf prog */
>                 return VM_FAULT_SIGSEGV;
>
> +       /* Make sure the page is not guarded. */
> +       ret =3D is_range_tree_set(&arena->rt_guard, vmf->pgoff, 1);
> +       if (ret)
> +               return VM_FAULT_SIGSEGV;
> +
>         ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);

Why complicate things with another tree ?
The logic has to range_tree_clear(&arena->rt, ... anyway
and here check:
is_range_tree_set(&arena->rt, ...

bpf_arena_guard_pages() won't have EALREADY errors, so be it.
Keeping another range_tree and spending kernel memory
just to produce an error to buggy bpf prog is imo wrong trade off.

