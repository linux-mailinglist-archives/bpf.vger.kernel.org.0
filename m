Return-Path: <bpf+bounces-28213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62208B6647
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E671F22934
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78192194C6F;
	Mon, 29 Apr 2024 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHzkzMPb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809F17B503;
	Mon, 29 Apr 2024 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433621; cv=none; b=pAVYZNokAkolTe25DUOBvaR+ZIiwG+KGXQAcWAW/OOR+/NrR0Ia0Dl1EKR9jwV3R6kAulwJ9MuQ0zD+juN/EHApCnWU/ALJSlficnX9kDykRPJEErtoUcW9EZkoY9diVVd6/J+FcIsQGpt2kRvFIe3T+Y4mXAzds8l9JesdNWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433621; c=relaxed/simple;
	bh=LOpbprS7VSgPmB3FadLGYcwxHBq+r2EtWuHVRQlITko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLdXmkCnck+FLhbWDWYC+jBmH/WB95WMyeNKAHxDWg7Kl03VUMzENBJNDRcYvqoLHEUwU8a/pRds+fb27mZ3j9fimyLNxCTrt3xw3/7xxoYtac6wlU1bFKBMAOBl3mffU+YRv97CiyrSnc5GTbAkT2Bl9VYEXE8k0c9vZA9spIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHzkzMPb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5872b74c44so568551066b.3;
        Mon, 29 Apr 2024 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714433618; x=1715038418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMYqB0LtWhc+0CjtDjGhsDw8CY6a/Sty9wtvCB7feAw=;
        b=IHzkzMPbd8I++QR/423FMQ1N5HYch9jjvEPtaIBkTsfbUGMf6xREvoUjX20tyABJCg
         bp6H3qoMhBF7p40PKBIt6j7IFN67yGiDgeRfCCsv+gMbMcRpeloW7jDnt0udixF3cKMS
         nyTztCJwfy1bxaOUbQgjRWWYaHNrQQgDUQHuks54/mEBIOMFvr0DOQN/rmJx5gWZGj4O
         QhgE9YWlReHF0wFegxop33WSl8Fl9+br5MddgcU93AtYkdJlO/8JdNuSLB45EexINocc
         Uc5Nq0LmPrDGgTXhWsgwZ+OWV8XJ8xR2H51wAHCpTUBj6waACKoUHc1ulivKFzqLGN8q
         uc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433618; x=1715038418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMYqB0LtWhc+0CjtDjGhsDw8CY6a/Sty9wtvCB7feAw=;
        b=YQotkFF3gFaNC0o7ZlzME5nYJTJ/kB7dL4FMufRQLzj+/Xrn0FrkhOeyOEfTSbZzWf
         rhq+/TGfaFIHcxUqhIay595ffMD2zOo8gOL7CyvvD9Py23wewXcQbrwkY/ha37decLma
         18T7EZLu+v0HSsJWUMM1IhxID3bXwVwrd7tb8risNhUQx5zfR/Eqc80p9UitXchvDT2q
         4TwOxD+r7YH71OwIkcBFEGN4ng76EH1wh6Bq+r1KIdn4nzDjBPUy58UuYkjbqBWz3rz5
         9nU4yquzP46xSyW09oZ3ZmqZO+8oNyj/SoiEYcKfGWzk4cWiKIZx2fRBfuJfk5n7OZNv
         /9+A==
X-Forwarded-Encrypted: i=1; AJvYcCWTllZsi6oUVdvCZwUSM+DYrltp/kAgTtnqPbZgLnV0HhgEMGC9yKD1L0HnKXKc7N3usG6Hxx6YEcBFf4+nzGTdp58xFs4cmRCftB7GKY2KjGm+rUQtpysiA95j6nnmLMnI
X-Gm-Message-State: AOJu0Yzcot5s29Uj161GpWJaFsI8Sh5RnDYIJfTuqbAsdabXo3ODqvvL
	sgGHDfefhknnt7dep8GLt7gFnNmxvnTBJ8GvRYPZC05SYmww8iR9ngdybiHa0+nScg3elgBpfPJ
	icTRU7r/+RCt2iSTlSpbDMyRIgizq/FTS
X-Google-Smtp-Source: AGHT+IEVqKz9kvsOvO79MhK2UfAJ5ErFNWLCvJBQdOpYa0KZl5TSJGZ8SCECViE3b0WK9iLnPRzh+g+Kaj8e/e8iUMc=
X-Received: by 2002:a17:906:ece4:b0:a58:ea99:6709 with SMTP id
 qt4-20020a170906ece400b00a58ea996709mr4906638ejb.3.1714433617560; Mon, 29 Apr
 2024 16:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zh93hKfHgsw5wQAw@krava> <20240420042457.3198883-1-dmitrii.bundin.a@gmail.com>
 <9ca4b5dd-20be-79ac-52eb-a19c0c82280f@iogearbox.net>
In-Reply-To: <9ca4b5dd-20be-79ac-52eb-a19c0c82280f@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 16:33:20 -0700
Message-ID: <CAEf4BzZz6n3FS-mWY1epa4y6RBLJggJ8Y-WEW-uhM11w3qMjCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: btf: include linux/types.h for u32
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>, olsajiri@gmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, dxu@dxuuu.xyz, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, khazhy@chromium.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	ncopa@alpinelinux.org, ndesaulniers@google.com, sdf@google.com, 
	song@kernel.org, vmalik@redhat.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:54=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 4/20/24 6:24 AM, Dmitrii Bundin wrote:
> > Inclusion of the header linux/btf_ids.h relies on indirect inclusion of
> > the header linux/types.h. Including it directly on the top level helps
> > to avoid potential problems if linux/types.h hasn't been included
> > before.
> >
> > The main motiviation to introduce this it is to avoid similar problems =
that
>
> nit: spelling
>
> > was shown up in the bpf tool where GNU libc indirectly pulls
> > linux/types.h causing compile error of the form:
> >
> >     error: unknown type name 'u32'
> >                               u32 cnt;
> >                               ^~~
> >
> > The bpf tool compile error was fixed at 62248b22d01e96a4d669cde0d7005bd=
51ebf9e76
> >
> > Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with t=
ypes from btf_ids.h")
> >
> > Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> > ---
> >
> > Changes in v2: Add bpf-next to the subject
> > Changes in v3: Add Fixes tag and bpf tool commit reference
> >
> >   include/linux/btf_ids.h | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index e24aabfe8ecc..c0e3e1426a82 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -3,6 +3,8 @@
> >   #ifndef _LINUX_BTF_IDS_H
> >   #define _LINUX_BTF_IDS_H
> >
> > +#include <linux/types.h> /* for u32 */
> > +
> >   struct btf_id_set {
> >       u32 cnt;
> >       u32 ids[];
> >
>
> Lgtm, not sure if its worth it but also doesn't hurt and aligns the heade=
r
> from tooling a bit closer to the kernel one. Just to clarify, this does n=
ot
> fix a concrete issue today, so small 'cleanup' rather than 'fix'.
>

Adjusted commit message and pushed to bpf-next, thanks.

> Thanks,
> Daniel

