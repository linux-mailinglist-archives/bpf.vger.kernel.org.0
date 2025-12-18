Return-Path: <bpf+bounces-77065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C9BCCE034
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D992B303018C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207B43093AC;
	Thu, 18 Dec 2025 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTcxBXAj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E77231845
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102373; cv=none; b=L0sF/d/CQTwh2NVxevmrPnRdI7o6emZ1yQbCQuVFlwiEMwY1O0qGai2L5BLRnqbmDk6I9oJkqi5SAuQsLwJBXKLddM7urtl2eUS4O5ZHwsjskkANyPvmIhM22ZN7rIBs39Dh5Yi9lUQrHrirl/MQEMCG8/oei4QRgpuKXaIqM/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102373; c=relaxed/simple;
	bh=nSLlCFXT7umyHHTCSVaAYMNj5w7xbkv7dzyfUdeTkTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8PQGU3r0B0jeYG+Zlqmu+QRq/TC56WjTRZ0+XuvBGtN0vJZ6KeiMDxZw1BLwRzixI2SpBzP134og2K5mrbackZK89EpT8qEbRQBkfsCu6sO1ELoFTad/zdyPEi/wW7C/rzdajHbzZyt28zqwOWH1l5gexaDdrNA2D0aNVoQBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTcxBXAj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c902f6845so1584834a91.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 15:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766102371; x=1766707171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MXQQn1cUmFjEF6nRbbXOOega233YWGjoO4gf90Dsoc=;
        b=LTcxBXAjFvBZ9l1qOz9b27bsztCoQNh76fGAc9+AEBKTocuK4K18wT6cKBh4s9rtiz
         azpuNwkjRjDpkCv+WM5ITuptX2FlikuXFyNN+l0Ecj+jKMCIK43L5MJr9VpqlUTApdn4
         3cKLTrBbInPiLnrhp8gKMmVHGPr1ZsnkBkJAd3/1xq/gZwkH8wTxrli/NO2SbVJLIrmg
         0hSYkj7sVvF5/Uweb2U9BGGf12EBIjIDMvsJaKqBRwsqkU6CFzGVBnfoYlx9w+tr+1L8
         o1iLuVfzjy2NidpQ4VKV2q0VVfemP+O1n7/fUoTiHPo3KseDnfejMnumOIHvqnKeLyz+
         KZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766102371; x=1766707171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/MXQQn1cUmFjEF6nRbbXOOega233YWGjoO4gf90Dsoc=;
        b=c5ZvIS2hpSjeHH3Wx+D1iHGKIy+74NQ1v6B7ox7+Ll+I3Ck4dF+0N0rBFATLs6t9yc
         kHbi9oSNTP6vdQKaa3M5My7Hw9JuqWtVMe/Vcfu4fz7DH0EVKuRUStoHQvbgmlWcFlDp
         EjV/HCFHzsv2/nhOBGjwoS0bTLIrm49eAdqZFw/sobEwvHLn5T7pQFRkl6P7flL2zzhe
         fSz1J4ux/NVGqUQIf9rfGvUGOS5duWopfthP9MpJXhQs7bi1t6a57/8L7Hdfys2Q1NtX
         bKhOjsz54QabVo8C45w/ZeKApPTmCkHmzuzkYG4l5EXRSzNXRT4HgSxj3m/HNDiwgrCp
         Y4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9VeVvC2MejABwkT1mdmMhiKvPtlorzA9Cgwk4uHC/2kuI3H4G9dvBAX37Ty1iZ0Pr6W8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RMjSmiVVRswm/J0+ztaOlKax3pQjW0R91WcQumDW7lEj7vNs
	PU3OCixqTSLTj99eJHjeKu3zpaomgqIIOTAMmW/INmP4nnmTJtgsn+B5Wh/3mBOpoTT+syVXEtb
	p7DyHap/4xz3/abTvbMWNV3cFI+LjLy8=
X-Gm-Gg: AY/fxX4ApUCzazonQcea2qdvsF5PdCsDolpQ0mnQtDh4G9aY7j/ukdODZUvflZOkQzi
	3OhcoKsBo6jX4cp9YiZVQnCpidGoBWLIPvkHr0s7W8IcK35S4vPf+RrW+4x+NEews1jZxhDn/zh
	QbsGvWQZxQfDC5Ym/KsVFKpQhgplp1au3bCmdy5UdyRbPLayDkx9ZzQ2ynHQ9GRSd4JmHiMm8FJ
	lrle1BvHqj5mxZ6SIdiYY75JfWUk+zhsKnHg3vxwHyl/uNWK3LDaW3uyhyKURUMVI7q2IKMrIId
	M8y+MdmyoTg=
X-Google-Smtp-Source: AGHT+IHN7gwdhIbCoZanFFzZrndvoArXxF3uEzxXcsLZp/u1QnCDBRBb1P9pNUhbrTqtgZ6nG41PSAOtmRyRrirnWi0=
X-Received: by 2002:a17:90b:28cf:b0:339:ec9c:b275 with SMTP id
 98e67ed59e1d1-34e92121d91mr882072a91.6.1766102371573; Thu, 18 Dec 2025
 15:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-9-dolinux.peng@gmail.com> <eede20e39fa1eb459e6e5174b5a8a5e3ba7db312.camel@gmail.com>
In-Reply-To: <eede20e39fa1eb459e6e5174b5a8a5e3ba7db312.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 15:59:19 -0800
X-Gm-Features: AQt7F2pU0SRjZn2ZJ_DrlX0o5YDWJoMfPgXchC7_IzDgMQ_zA5TM8I9Wm53rxw0
Message-ID: <CAEf4BzY4ANKygJN=aRGHKbooW1Q1ROYgp1A74vgPKOQbW5cghQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 08/13] bpf: Skip anonymous types in type
 lookup for performance
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 2:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Currently, vmlinux and kernel module BTFs are unconditionally
> > sorted during the build phase, with named types placed at the
> > end. Thus, anonymous types should be skipped when starting the
> > search. In my vmlinux BTF, the number of anonymous types is
> > 61,747, which means the loop count can be reduced by 61,747.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  include/linux/btf.h   |  1 +
> >  kernel/bpf/btf.c      | 24 ++++++++++++++++++++----
> >  kernel/bpf/verifier.c |  7 +------
> >  3 files changed, 22 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index f06976ffb63f..2d28f2b22ae5 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -220,6 +220,7 @@ bool btf_is_module(const struct btf *btf);
> >  bool btf_is_vmlinux(const struct btf *btf);
> >  struct module *btf_try_get_module(const struct btf *btf);
> >  u32 btf_nr_types(const struct btf *btf);
> > +u32 btf_sorted_start_id(const struct btf *btf);
> >  struct btf *btf_base_btf(const struct btf *btf);
> >  bool btf_type_is_i32(const struct btf_type *t);
> >  bool btf_type_is_i64(const struct btf_type *t);
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index a9e2345558c0..3aeb4f00cbfe 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
> >       return total;
> >  }
> >
> > +u32 btf_sorted_start_id(const struct btf *btf)
>
> Nit: the name is a bit confusing, given that it not always returns the
>      start id for sorted part. btf_maybe_first_named_id?
>      Can't figure out a good name :(

yeah, I agree, it is quite confusing overall. I think we should at
least add comments why we start with something different than 1 in
those few places where we use this optimization...

let's name it btf_named_start_id() and specify in the comment that for
non-sorted BTFs we conservatively fallback to the first type.

btw, maybe it would be good to have two versions of this (or bool
flag,but we all hate bool flags) to either return own start id (i.e.,
ignoring base BTF) or recursively go down to the base BTF.

Having that

while (base_btf->base_btf)
    base_btf =3D base_btf->base_btf;

logic in a few places looks a bit too low-level and distracting, IMO.

>
> > +{
> > +     return btf->sorted_start_id ?: (btf->start_id ?: 1);
> > +}
> > +
> >  /*
> >   * Assuming that types are sorted by name in ascending order.
> >   */
>
> [...]

