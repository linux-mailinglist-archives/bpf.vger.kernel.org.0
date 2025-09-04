Return-Path: <bpf+bounces-67377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF7B42F57
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 04:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FC47B213A
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52A1E3DFE;
	Thu,  4 Sep 2025 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyiTX3k3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062A1DF97C
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951588; cv=none; b=qZSvm/+j2jH7TycHMaEBTed9xQhKt0/pH7udsfvU2kl8gNzTPNSq99A6R2NIcoUlqiayKJpKnJPUURh2JReWGZP/G9SIALTqJmhCv8OuClscKZ7dFh4eLQSs+9oqONvqd+d+w6Hpk0uVwBbgf4SHqDm4h+4o+tKUSMVlj/A2Vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951588; c=relaxed/simple;
	bh=X+ifQrOEZQjTgNZ3nPnfy/Wn3ZFhxoRvcpIuRp67f8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OM0D9KsWobJJgSKUeJ7UT+/yKAh0YFz7GxCF23ESqlIMxXEGEEgwkhGbhC5Mj5Q3EeFJEgLZjQTbnzlSlCeSKzpFtybYRRXFIKcDm6UDgiT20gErx4b0/6iZRziINhPyMCdtZFWusKHMwOStetMswWT/QR/0jzkJysMvQgNe7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyiTX3k3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4F1C4CEF0
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 02:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756951587;
	bh=X+ifQrOEZQjTgNZ3nPnfy/Wn3ZFhxoRvcpIuRp67f8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jyiTX3k3Kl4YcZvrbUjUn3gccv9+xlv6n5GajrCw9h20j10SlDWYxoXuGt4LxH0QK
	 xK/KlVw+8zpoXH7Aq/ZLZuoKk3LlHNhc1szJ1B90xHLXN3V3YBPUjEFCcXU0OexWt4
	 Az9D9Gu38iY8z5H+UEZKTJTMihMPRNcUP1gpQpxztK3bQ1Rwq9lr15pXJBj+7LKEx9
	 bW5vYJrSBWuGQ95XL1TXRnG5eYLs2MhK7eOZtKqhIPpAD8lBFfeONL8/kSrnhf7GwY
	 b8IimHhmEJZDA/4j7Ags6mCehT+p8YFMxVHsJ4az8gVi6oY1pPFtosk4Qhq1NfCKSB
	 M3Fa1wz94mjEA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so824553a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 19:06:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwc4K+HvI0lI/ACT3IvsD4PJrvGrmT3jTpulwNpm2kO7FQ+Kboey+uAXviRCW5Z7QW6j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXFKurUv8he/LloGEBZQPMrDKog7TJJa6UI61bDH68xGSWmLl
	kRwtStY4Q67pjAqpRlDpRDTLVCdyzpSPQV8t1lcFUaaKzDzZLogeA3RI1vQRWFlJ57XEsiPHQA7
	qk/UnZy6WX4lSm0v6RZ/c6x96RgUt6sE=
X-Google-Smtp-Source: AGHT+IGggDybwFwkRg5qeoy1I74TLfEpxyjFlAWqRYtQZO7tNUcYY3GdN0/bPXbCOyO6l4sNLkrCAQQkH5KmXDyfi+k=
X-Received: by 2002:a17:907:3f9f:b0:b04:25ae:6c79 with SMTP id
 a640c23a62f3a-b0425ae72b6mr1487848166b.33.1756951586227; Wed, 03 Sep 2025
 19:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-3-hengqi.chen@gmail.com>
 <CAAhV-H5UUVYnM3TkKujvS2u99NTEK7VCQsVHZkAKzhL5o8jCXA@mail.gmail.com> <CAEyhmHSU4R1XRLy5O=OicvdAAzeSQxo-Hnd5Pm_FazApeydH2Q@mail.gmail.com>
In-Reply-To: <CAEyhmHSU4R1XRLy5O=OicvdAAzeSQxo-Hnd5Pm_FazApeydH2Q@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Sep 2025 10:06:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6nK68K7OBHg6+sLvHXjDdL-fP1aa2Fgj4C5M9dsDctdg@mail.gmail.com>
X-Gm-Features: Ac12FXw6p_726tEWqvABUxOTR3kr3TKVytSHJ6SGKcz1OZaC8lkY-OtWGvX06O0
Message-ID: <CAAhV-H6nK68K7OBHg6+sLvHXjDdL-fP1aa2Fgj4C5M9dsDctdg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] LoongArch: BPF: Remove duplicated bpf_flush_icache()
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:51=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> On Wed, Sep 3, 2025 at 10:58=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Hengqi,
> >
> > On Wed, Sep 3, 2025 at 8:05=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.c=
om> wrote:
> > >
> > > The bpf_flush_icache() is called by bpf_arch_text_copy()
> > > already. So remove it.
> > >
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > ---
> > >  arch/loongarch/net/bpf_jit.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_ji=
t.c
> > > index 77033947f1b2..9155f9e725a1 100644
> > > --- a/arch/loongarch/net/bpf_jit.c
> > > +++ b/arch/loongarch/net/bpf_jit.c
> > > @@ -1721,7 +1721,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tram=
p_image *im, void *ro_image,
> > >                 goto out;
> > >         }
> > >
> > > -       bpf_flush_icache(ro_image, ro_image_end);
> > Both ARM64 and RISC-V do this, so I prefer to keep it.
> >
>
> Then they probably should remove it too, I guess.
I think we should understand why they do so first.

Huacai

>
> > Huacai
> >
> > >  out:
> > >         kvfree(image);
> > >         return ret < 0 ? ret : size;
> > > --
> > > 2.43.5
> > >

