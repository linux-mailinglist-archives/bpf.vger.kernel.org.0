Return-Path: <bpf+bounces-37082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31251950D29
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B502FB21848
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 19:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97744C61;
	Tue, 13 Aug 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKPr5lOp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DE1DDF4
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577591; cv=none; b=cGuwOQIacwMfUjicp8vlTWL/WGOFTcQ23fVyqr9AxXnd9BqLGOcG1JZIOjwa5vEHkh16WhunRlPx5o6yBNqKiI5vTEyvQ71yOE4px743oXSkWlVYr2gdVK7Wjxza7NQkjrBdEIO2XTyATPDJOqWdBCZfEn0O+4/uzEZzFEzgJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577591; c=relaxed/simple;
	bh=Inc1lRdW8XrxJm0FL+RZnOzl+qxivV8dxVl8nnBPfuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrnXVCsnQzrPntTtUvqnDTY+sPOaq8sBG/4bSIp7UTcyw0nPojWIGLtVhxeVoPB+eOttI+cCIMeoIApXcSdM9iZc/cgo0UMGgnvqsKZfWq5KCIAWm668IGaNd4dn4MDAQ45qhP3AY2d608Whi3dVZypx5dAUzMe1jLbfjBnwIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKPr5lOp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so58305701fa.0
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723577587; x=1724182387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ8j3gFxD985T8nrOtS0UMb+u8eXiueJqOp5IR7j1hg=;
        b=MKPr5lOp6jUy5SbZJuTbKuBXTVsd9RVHM0VzN+ren/mUc23LAx6hJTUbKyuHjPKlaR
         2q8G2YZdy7ppGWLeZHvnZGmvk5rBhUUTy4tqs1coOjS5/nO1tI1u91/L8JJf5g66XfKX
         WqK8G8o2KbJqkZ8mlPPjALbhfuqUPJ8gXRPFHe2Ai1dOER3/nlSNarkhjgVeIQMQqAWd
         ulmT88xcsd5dtIqt/DsRrw/v06rpySximG5V6UumoKwrTLVcFVhbhZMnIU/F2xhceP0q
         ZJCIg/y25cRUtuh8lZ+1bYguBBE5F1gd9ow5PNnDTHa383inMizvbwIBtrqMnxjD7q5N
         vahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723577587; x=1724182387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ8j3gFxD985T8nrOtS0UMb+u8eXiueJqOp5IR7j1hg=;
        b=hYd/n7ykeRWCR3PHt5E0uFEHbmFYVQ/aHR+bqNZoSiR6uCb4D6agyA86mZxeXBfVJm
         t3yfn7Mmd2n9gl9tCdMkptjipo4isGcLGq2o28IsZOacqTJOqVPr2tQMOXYcfiI0J4z3
         F+zzBDtpLfjxe99/f62x75nu7tnIW05DbyDuK8YfQqGIQZVDziVd3AKTz/RDlluzPRWo
         WNMfCvtan9mup6h3cjsNZpBYjpgLSJCi9e5py/jajOyRsbjmZN5TEu3M+0B5B7ukxfrI
         NcGYnCNYgT1SlZbpmec8q3QlFkauMLYWTA9d1+xU9svSXn5H+YexB4E0Vg8r4zqNvYBf
         ha4Q==
X-Gm-Message-State: AOJu0YwEHAPE/nYEkPtNfbLtNF3AjPV7H2LcY+vbF0ZzzXLW0HTo7W7v
	KqSpHfunstehVsChbt0ZwTUBkgUbtmVcpcPafKDjJoZ6px1cHZ+qd+eqLyqVIC6HSa9yG4A4Kzl
	oe3JhPFgOuFlkTXYVinnYaw+x75xmEtlo+so=
X-Google-Smtp-Source: AGHT+IFRUBPV9U1fq5rUt1mNiWASG7xYAyOXoeHz+WgZJ+ZKJyV2pcmw097edviw6Ee/6/Vyv63k2iCIBblHY4865Lk=
X-Received: by 2002:a2e:9d41:0:b0:2f2:9dc1:af33 with SMTP id
 38308e7fff4ca-2f3aa1dd191mr2204941fa.19.1723577586797; Tue, 13 Aug 2024
 12:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811161414.56744-1-ubizjak@gmail.com> <ed81500f96d0272662150047768be5a96373bdf7.camel@gmail.com>
In-Reply-To: <ed81500f96d0272662150047768be5a96373bdf7.camel@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 13 Aug 2024 21:32:54 +0200
Message-ID: <CAFULd4b_ukNUoez+P8O92GMoUSk+tuR_+q7XpqHEUYx9BgtgAA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix percpu address space issues
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 9:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sun, 2024-08-11 at 18:13 +0200, Uros Bizjak wrote:
> > In arraymap.c:
> >
> > In bpf_array_map_seq_start() and bpf_array_map_seq_next()
> > cast return values from the __percpu address space to
> > the generic address space via uintptr_t [1].
> >
> > Correct the declaration of pptr pointer in __bpf_array_map_seq_show()
> > to void __percpu * and cast the value from the generic address
> > space to the __percpu address space via uintptr_t [1].
> >
> > In hashtab.c:
> >
> > Assign the return value from bpf_mem_cache_alloc() to void pointer
> > and cast the value to void __percpu ** (void pointer to percpu void
> > pointer) before dereferencing.
> >
> > In memalloc.c:
> >
> > Explicitly declare __percpu variables.
> >
> > Cast obj to void __percpu **.
> >
> > In helpers.c:
> >
> > Cast ptr in BPF_CALL_1 and BPF_CALL_2 from generic address space
> > to __percpu address space via const uintptr_t [1].
> >
> > Found by GCC's named address space checks.
> >
> > There were no changes in the resulting object files.
> >
> > [1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-s=
pace-name
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > ---
> > v2: - cast return values from the __percpu address space to
> >     the generic address space in bpf_array_map_seq_{start,next}().
> >     - correct the declaration of pptr pointer in
> >     __bpf_array_map_seq_show() to void __percpu *
> > ---
>
> Looks ok, thank you for applying suggested changes.
> The only nit I have is that '(void *)(uintptr_t)p' (and it's inverse)
> looks quite bulky, hiding it behind some macro might make some sense.

True, but as argued in [1], the macro wouldn't be flexible enough to
cover all possible variants of the casts. Fortunately, this casting
pattern appears only a few times, and perhaps its bulky appearance
would motivate developers to rethink the cast.

[1] https://lore.kernel.org/lkml/CAFULd4YOf0Mz-JbR6LEWxM2M=3D4GTxqC9m-q_QAZ=
Jw8Ws16yrTA@mail.gmail.com/

> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks!

BR,
Uros.

