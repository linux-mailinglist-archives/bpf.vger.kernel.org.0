Return-Path: <bpf+bounces-76966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855FCCB26C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 10:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7057630A5E09
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E380330E0E0;
	Thu, 18 Dec 2025 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj7uOkzL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C91428F4
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049390; cv=none; b=fLKO16bpXIwbC8zv3ZkKBs3M/xEJX2V2GpV14rIt3fiMmt8m9XNbpGMV654Lo2hLHRHfqP6pzJ5alR558rXOJAMZGufxjjUKMGv97a5cPdFnokBMIR7dswzy/pT18OHtASkNUFhiiZNJHp1lpsgEptbPw0j7cKNsTqV7yxUp53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049390; c=relaxed/simple;
	bh=HK5QYa+mDoEisMNXJ9hU9MuGd48q6FfV4w5El4innS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX2HZ/Rv9w+qV34ixhUL+uSQh9lRv8cR6ha3euO1b74yHJTuWv4ZTi5AHfM85VHq6wJGcIlXd1s2Ag21nbXOL6vM8qUcsCHbQuT5lbqZRek6H37oet6BmdkK/RVhG2lTOlGbMFuzP5bTumYzPpx2FMsRF2d0kM2O47Meb69WhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj7uOkzL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64951939e1eso559825a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 01:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766049387; x=1766654187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LerU7cLPxPXTjUuFHeOUHNf4yiShtwF0I9Yaq0SZWk=;
        b=Bj7uOkzLJ+e4qM7COyP+Z5YDEbmuB6/XO1y9Kp6RpOOekmjzCBSZ4hYHTmMDT5fNh+
         Y4Mi+GAe3w2P5GZPO9A80fAX2cBfDM4MrEKp+Aj4clNmCvpIXrPKaQig+0OzgRb7lDFF
         MCgD9DzEskzKuPZhE4ZdUshMsnRlkUUhhjYG6r1HIXM5wV0BRSlqcTjAx3h+MaRACAk/
         l6e5TSgTa3OWqDKty0+XY/OGX9FTkzMUxdeRUfA7fR9RUz5USd8G3NMKXCn1ePzttcOY
         A53m0htS3s6lw4D0yxoZbdXiHu+GnQHrmD5iPKh+dlffMqIcgsvQN9ynRDi8VHJLdrrv
         c0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766049387; x=1766654187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5LerU7cLPxPXTjUuFHeOUHNf4yiShtwF0I9Yaq0SZWk=;
        b=PToFZg59S7vJjDyajjhbZ7zxGn7Qkse1dAC3/oxSKNfd22vJlinybcEBP7zH0n7AFf
         PnPYE3Sks4MSEP2JCGi1N7YxPAZwJjlIx2knaoRrPDE/05E8f2LGGEvQMAvH6szYs4K8
         TTBVdokkHAGjL4w1Q2R6/m7Lad2Qh0xmwzyE0XlWHww4mPcK91RZcdRscKnokumL22x/
         wDx2FOlU7QVyEIh2ifVQWHqHQOoaYGDpdLr28mzki9QuTbNdW4xFG/XgWI79qihc/fS6
         xJwwqsih4gGRnZMFBeg4+lwpSONq4CcJ2OeoUaVto7gmgOvXKsskmsbcb5AD5163wZjC
         t2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWOHMarr4RX2MYV3UQ7b7h+E6QGOaddUA5QQ31Aw7ER7o4OoTjEHbA/Medx65MED9MMAro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUblC3vI5zuoi/cWGDjSsOCuWlrg53x1dZsVPb2hsHpk0PPkr6
	BPVc4dGsLS1Z8918+5Q0e4FWmk46BE0bujK0wd/bUoVI8YiEkAZjVMbHDz9jtC9exdivxgc+JI1
	4Ajbku4LVaD9GmZXSuac1RAbo5yEI7LY=
X-Gm-Gg: AY/fxX7e1VKkBpHk+pOInlBiyu6GjSo1XSNJtA/QSJmH0fWGojDRo0qtMuCZpFGm8wA
	RcvgISHAaZhdXA/K8WvKEU5Te8V2Pf5mcR3mxU4JLz86vqeMPA5S30SBwy6WGfNqc9tPBHzt9fF
	p8qcp8hmZo1l8gYWiQAN4JyXkTjaugLfmHR4Tklt4ePcBG7p13RvENImuQH08RNJ5rSjWeZmB0v
	g4Q2uXSsGiPiO4xGF+t9TLutMqryoJbPpoILHGgJ/Q0dvCVFdZ9oXc2BdGfNXVgERs1FkyD
X-Google-Smtp-Source: AGHT+IFDeHdRp64gSTnqkILl0AEzQqW3WoNhTCxT8K3AMyCbOO8YDpvu2kVTH5RZlT8MeAsrfG81cPRR5yjM9h10YwQ=
X-Received: by 2002:a17:907:94c3:b0:b73:806c:bab7 with SMTP id
 a640c23a62f3a-b7d2362876fmr2027096966b.19.1766049386832; Thu, 18 Dec 2025
 01:16:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-9-dolinux.peng@gmail.com> <695de859b8af88ddcf53bca22a3ae57d7026b3af.camel@gmail.com>
 <CAErzpmt9HKPfyrc_iW5QjT1=E5mUwFcKJihga0s-WBhqE6uiwg@mail.gmail.com> <239e3861b030a8d68f24a5be72346ffedffb8843.camel@gmail.com>
In-Reply-To: <239e3861b030a8d68f24a5be72346ffedffb8843.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 18 Dec 2025 17:16:15 +0800
X-Gm-Features: AQt7F2phBLPXukgY-AlhtGQBp4OTnwB8ZVTbj2DZXndzgZvdnc9b4-BvZUyWSWA
Message-ID: <CAErzpmuaRop+Sg84WW_h9hL-fbOHwxqd0BuNQQRSSxu1TJnPLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 08/10] bpf: Skip anonymous types in type
 lookup for performance
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 1:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-12-17 at 17:21 +0800, Donglin Peng wrote:
> > On Wed, Dec 17, 2025 at 2:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> > >
> > > [...]
> > >
> > > > @@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
> > > >       return total;
> > > >  }
> > > >
> > > > +u32 btf_sorted_start_id(const struct btf *btf)
> > > > +{
> > > > +     return btf->sorted_start_id ?: (btf->start_id ?: 1);
> > > > +}
> > > > +
> > >
> > > I think that changes in this patch are correct.  However, it seems
> >
> > Thanks, I think the changes to btf_find_decl_tag_value and
> > btf_prepare_func_args will cause issues if the input btf is a
> > split BTF. We should search from its base BTF. Like this:
> >
> > const struct btf *base_btf =3D btf;
> > while (btf_base_btf(base_btf))
> >         base_btf =3D btf_base_btf(base_btf);
> > id =3D base_btf->sorted_start_id > 0 ? base_btf->sorted_start_id - 1 : =
0;
>
> Missed that, makes sense.
>
> > > error prone to remember that sorted_start_id is always set for
> > > vmlinux/module BTF and might not be set for program BTF.
> > > Wdyt about using the above function everywhere instead of directly
> > > reading the field?
> >
> > Agreed. If so, I think we need to add another helper function to check
> > whether the input BTF is sorted to improve code clarity.
> >
> > bool btf_is_sorted(const struct btf *btf)
> > {
> >         return btf->sorted_start_id > 0;
> > }
>
> Sure, as you see fit.
>
> > Besides, do you think we should reject loading a  kernel module that is
> > not sorted?
>
> Not my strong side. As far as I understand, when external modules are
> built for production use-cases DKMS is used. DKMS will use same
> resolve_btfids as the kernel module is built for. Hence reject the
> modules with not sorted BTFs should be fine. Are there other use-cases
> when mismatch between resolve_btfids versions is allowed?

Thanks. I found that RHEL supports loading a kernel module between
different kernel versions with stable KABI. So I think we should not reject
loading modules with unsorted BTFs.

