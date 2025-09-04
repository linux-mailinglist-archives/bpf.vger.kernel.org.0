Return-Path: <bpf+bounces-67384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328FEB42FB1
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3F5189C460
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EF2356BD;
	Thu,  4 Sep 2025 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd7wdNXF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A823507B
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952294; cv=none; b=Qv95juwk6mAucJIuVgGQ35j9AyxuRtG/dgT9Gg1tuGE05FumOmmfioEpmpAYe2B8kJ5ZfGDAcCV89LoCNGUVJ6aRYj6DhbqDvM4asdTZU/b3PmSxW/E+8G4s+uFN/VWpw3qED5X8Dr0BPwgrhOydaRUvK98qJjMAJAm30QmN/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952294; c=relaxed/simple;
	bh=gtUtYQQ5ThUv2l1cwoJGAROpSbgWqRG2S5VatDnKpeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aN1AmWrL2F5DHCiu/rsPaGvhnXNCFWQdPhp+JUyGN+aJ6nSuM0hL1kwndIHOL9eE7dzbEHm/zabVrYV0IfhdqF22MYs53PwDE3uRYBpXP2QmbhOODGD2mcAQsl1jdQlSSRqKnQapgIO2dq/3WW+Hb5ZuE1ukCcHYUwRoMI0tReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd7wdNXF; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-31973960b70so446721fac.2
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 19:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952291; x=1757557091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ED6z+k1JMbU2lVgAQbGDOb/Q56p1lzAkdaBUq9H/7I=;
        b=nd7wdNXFLovWSvUb1CS2ktxug798JjzMP7JKCqEJURRhaFWKGSlryntiMGp0aBQGSM
         Ws4v5LlCTZcRX5YQ6mvhw2lQgCgmv6Gmf/bj3W7lV5FoMhPcw/FwtMACi0x0H8vS68ZD
         uqZaLrpf8zM7nny9XKuDYEkKMK560/qvlfGQSGbyeXejCgy0SpU9DCBHRiaACctUi2Dg
         EOJOCSDjZXxGXZM6rrxAmQO2Z0io7JSpAPbBX8y3ILlaQwgR6ONFHNus1Le6DH4ipKAT
         TGGAjRtFhUYzcyjO59oMKkBI3WpHoy9XapQKKL1XXd0eONVwOHLc4S/ywo6cBJi/GuyP
         hnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952291; x=1757557091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ED6z+k1JMbU2lVgAQbGDOb/Q56p1lzAkdaBUq9H/7I=;
        b=qVZLzHTRQvbBeVtKTHxn9xdkej/gps85BkRjZOfEbnoHXLD9uCT1k2VwQ4N5uHQ8rK
         NgOqB8VcncwAVAOymAuAUiVVKgyyvhR9tjM/O964S7/BntXCFKkKn7ziGZQxxzuB/U+o
         Px+W+cWh6FTpXGHruL6SaBRCgpOu6ElB7qAQwIj+KQIT2jIvzvdkXbyoBCTmmTPITD78
         pFSjk0gueVs40SG7CsVFVXdqbA629T1E5g3Caz/qvtGKooJSSTYQKyop1RTKbL5Nnmt9
         PwDAPadC8bH1/kfDfb4MsIfqZuPc4PE+atgoZUdz6hIE28qJEPOINHI7AwU06tCDcjYx
         BG3w==
X-Forwarded-Encrypted: i=1; AJvYcCXyxaGaSYryYzvGprH+JSZ/Nyj1C1T22HQiiLRZkQsYudUPDNBdpcEvyT69lwB0M1Mc+fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsxBIoThWIcwytQ21EJDH/ARjifM7KnIsVtJNQwV4/DQRh0QG
	RVOUEj4N+WLb9i7AcNxg9pxjlNQpVdcLzxSiS/iDtbdc/k2vEiejzFr41OCNfPL7qhLgtz380UB
	nYqX3Oos51RfKQRkFsaWe5+xcQWeu5VY=
X-Gm-Gg: ASbGnctSvNRRqLnu3x0PP3zJGaV1vNvpDkHCuJfx/khcaRI52J9/EtKyOS05+IrRpOk
	yuUw/XWCuXzviU5j3G8eklSVDvxkg5SYAHz7xZSUjg7Y7dU1SaZPUSPYRzUd75RBRQIeHd/0FWF
	xVb6XM+SIJW4rbq3utqmmDH9S3Jy2kqZy0BMQBfiHFT+A09HPvo91uqDx7jCrqn7k1GlJBvd/PM
	TnuJ5w=
X-Google-Smtp-Source: AGHT+IEjXx4bo+qNzhj7ga8ad3vpjEJVPo6vTEqWqcLxnPhivXwi0Q2C+D88tcEV9Hy52u4SFbqXqLTem4/x15aBaww=
X-Received: by 2002:a05:6808:30a7:b0:438:3b4c:c414 with SMTP id
 5614622812f47-4383b4cc5c3mr699615b6e.18.1756952290808; Wed, 03 Sep 2025
 19:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-3-hengqi.chen@gmail.com>
 <CAAhV-H5UUVYnM3TkKujvS2u99NTEK7VCQsVHZkAKzhL5o8jCXA@mail.gmail.com>
 <CAEyhmHSU4R1XRLy5O=OicvdAAzeSQxo-Hnd5Pm_FazApeydH2Q@mail.gmail.com> <CAAhV-H6nK68K7OBHg6+sLvHXjDdL-fP1aa2Fgj4C5M9dsDctdg@mail.gmail.com>
In-Reply-To: <CAAhV-H6nK68K7OBHg6+sLvHXjDdL-fP1aa2Fgj4C5M9dsDctdg@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 4 Sep 2025 10:17:59 +0800
X-Gm-Features: Ac12FXwHNKyXdBDiLtZdadfoTD1yN7LDGe-g8Cis6pcwYeFhR_sT-fBRweH741Y
Message-ID: <CAEyhmHQpNq=nDX-6FuRreVtmBDn6O6NTWv=PGZXDtEhU8symPA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] LoongArch: BPF: Remove duplicated bpf_flush_icache()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:06=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Thu, Sep 4, 2025 at 9:51=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
> >
> > On Wed, Sep 3, 2025 at 10:58=E2=80=AFPM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >
> > > Hi, Hengqi,
> > >
> > > On Wed, Sep 3, 2025 at 8:05=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail=
.com> wrote:
> > > >
> > > > The bpf_flush_icache() is called by bpf_arch_text_copy()
> > > > already. So remove it.
> > > >
> > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > ---
> > > >  arch/loongarch/net/bpf_jit.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_=
jit.c
> > > > index 77033947f1b2..9155f9e725a1 100644
> > > > --- a/arch/loongarch/net/bpf_jit.c
> > > > +++ b/arch/loongarch/net/bpf_jit.c
> > > > @@ -1721,7 +1721,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tr=
amp_image *im, void *ro_image,
> > > >                 goto out;
> > > >         }
> > > >
> > > > -       bpf_flush_icache(ro_image, ro_image_end);
> > > Both ARM64 and RISC-V do this, so I prefer to keep it.
> > >
> >
> > Then they probably should remove it too, I guess.
> I think we should understand why they do so first.
>

Just got confirmation (offlist) from Huawei folk, we could remove it.

> Huacai
>
> >
> > > Huacai
> > >
> > > >  out:
> > > >         kvfree(image);
> > > >         return ret < 0 ? ret : size;
> > > > --
> > > > 2.43.5
> > > >

