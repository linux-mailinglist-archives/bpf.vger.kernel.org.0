Return-Path: <bpf+bounces-33698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D879924B98
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FEB2835C2
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF641DA30D;
	Tue,  2 Jul 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT333BnN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EFF1DA302
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959212; cv=none; b=BYoOY6eIi4dsRn8YZiB1eQl56HOv7HT3YIQN0BF9SGJ7BLqSiLGybC04Jf8imsaKMZTAx/c5hx3BGp4Z5ckds56SPGXtuNMMgBlhzo5dnpyk5DcYFS/Gopz+gRQv0/cbSwxIl/QEgR+p/YXxG6NhgVNFBIB1ZahlQ7vSXLxD6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959212; c=relaxed/simple;
	bh=6oNYHGIYmEjVzX4KnKF6mZ9c69aknwBysBBZU5i1h6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKCtb1w46yMl1R+AuLH363WRdbQhwpUZlna7tLI2XXmwimu638vUKNaSaJ1APNe5f69IHf85/3aLn2/XzDLRIQA7dhxOawwjDPApXMz8cFlE/mofgPAce11RN6xiN/PLOYTAQOdJ6JC1+Y8V5WBr1BfOugjTcGF5myNTxPjrNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT333BnN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-706683e5249so3214521b3a.2
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719959210; x=1720564010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCqD7Tnr9hrUitj9QOu1fuyk2vcvkJY5ZBJCFmgdRzM=;
        b=KT333BnNuNv6k0ky/BNU6rt3x6/UOFYyO6uEoU7TuMoZXQFIiI4vWrk/lu32q2yjoL
         m9qb4rOOhZHe32g22AuW2fzkVDr6HJcJjPmUbjRrDR6FMTbaXfjXBE83aEb+yrr7PFxs
         nHgCWPlj6IQ1bQT1XISPk0b/0vRajLb/rZMuiaQLf7SjTBVAkma0yRBpjnvjPnL3SfW4
         SCxZ5gWk6U7fVcylgBVWlr3cVQThB5Ng48nrIV5c7mYjZpeijaz7CylFsIPKApTgSeDL
         4M3D/I2DwuajcHhl5889aCzWXcOM75xqulvIN/xMs5sbWmfnYejA3fEm7lnN5qh3rAFu
         Ewyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719959210; x=1720564010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCqD7Tnr9hrUitj9QOu1fuyk2vcvkJY5ZBJCFmgdRzM=;
        b=Kqukv0hvuTy3XG/0ScUWGOO9ia8wBCppyPL8MiXQvFSJrf1weOKPfxzynFnv92RiCP
         p4qe1PqYhmoJpfwHlbr5WmMWUx9KTiW8XqkNk4FDiURJFaqMzB0wM69q88pT7XfQS2dy
         t5L6cNt22l3kqBYhArQDfKHbrA3WjH2SIEHBwDFxNqDQOMr+zSxxbrsIMYUqXDvP8l4Q
         GtPLoclljXvCbRbg8rOuinadfrUty5etaen9HGnJmY/SPTfa/UpnPoFpYQ/0/ivGJJHS
         qSoOrUBhsG3HJkJsXA6Pw2SpwpDx8QPQdSFYDwDmIXK6juBaVSPsc+QKpdyT9Cjey6ho
         /kFQ==
X-Gm-Message-State: AOJu0YyH6/RxxBtfr4YQ2I8oAAbClOQt7xx3wjPmSfUomdU8c5O6Ya+8
	GVYFMec82jcWvDrm63qHe3i8z2otoQEe3Lfvd94EtyBd0bbJhKql6HWovxqZV5sYCUch+P3bhQQ
	MeDC5F0uCwAyzquFa8E6KMFA+zMQ=
X-Google-Smtp-Source: AGHT+IFz12PCvODHT1rSLVWaqV1pyFlhEVI2oRnwVy1iNrVl0SPcfLmjlziXwhsQYCughr33SZ9vtUhJpzwJRbIrkrw=
X-Received: by 2002:a05:6a00:190c:b0:706:6c38:31f3 with SMTP id
 d2e1a72fcca58-70aaad46cd3mr9841134b3a.8.1719959210482; Tue, 02 Jul 2024
 15:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702142542.179753-1-bigeasy@linutronix.de> <20240702142542.179753-4-bigeasy@linutronix.de>
In-Reply-To: <20240702142542.179753-4-bigeasy@linutronix.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 15:26:38 -0700
Message-ID: <CAEf4BzYs1bXC1S+nnFLngb03=rcpiCz4-k_Ge=+OvJt9rR5OaA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/3] bpf: Implement bpf_check_basics_ok() as a macro.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:25=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> sparse complains about the argument type for filter that is passed to
> bpf_check_basics_ok(). There are two users of the function where the
> variable is with __user attribute one without. The pointer is only
> checked against NULL so there is no access to the content and so no need
> for any user-wrapper.
>
> Adding the __user to the declaration doesn't solve anything because
> there is one kernel user so it will be wrong again.
> Splitting the function in two seems an overkill because the function is
> small and simple.
>
> Make a macro based on the function which does not trigger a sparse
> warning. The change to a macro and "unsigned int" -> "u16" for `flen'
> alters gcc's code generation a bit.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/core/filter.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3f14c8019f26d..5747533ed5491 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1035,16 +1035,20 @@ static bool chk_code_allowed(u16 code_to_probe)
>         return codes[code_to_probe];
>  }
>
> -static bool bpf_check_basics_ok(const struct sock_filter *filter,
> -                               unsigned int flen)
> -{
> -       if (filter =3D=3D NULL)
> -               return false;
> -       if (flen =3D=3D 0 || flen > BPF_MAXINSNS)
> -               return false;
> -
> -       return true;
> -}

Why not open-code part of it and then have a function for checking length l=
imit:

if (!filter)
    return <error>;
if (!bpf_check_prog_len(flen))
    return <another-error>;

It's all local to a single file, no big deal adding a few if
(!pointer) checks explicitly, IMO. "basics" is super generic and not a
great name either way.

> + /* macro instead of a function to avoid woring about _filter which migh=
t be a
> +  * user or kernel pointer. It does not matter for the NULL check.
> +  */
> +#define bpf_check_basics_ok(fprog_filter, fprog_flen)  \
> +({                                                     \
> +       bool __ret =3D true;                              \
> +       u16 __flen =3D fprog_flen;                        \
> +                                                       \
> +       if (!(fprog_filter))                            \
> +               __ret =3D false;                          \
> +       else if (__flen =3D=3D 0 || __flen > BPF_MAXINSNS)  \
> +               __ret =3D false;                          \
> +       __ret;                                          \
> +})
>
>  /**
>   *     bpf_check_classic - verify socket filter code
> --
> 2.45.2
>

