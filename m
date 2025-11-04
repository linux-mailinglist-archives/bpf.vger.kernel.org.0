Return-Path: <bpf+bounces-73425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FB5C3073F
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 11:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74EFD4ED9D4
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 10:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B265F314D34;
	Tue,  4 Nov 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw7wXOsN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D03314B71
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251444; cv=none; b=sYbvvrYHKlR02smDjG36INBg8gd8hQTLb1AaB94T/Mf9rwKCBtn+68bwOnbjilX8BMELSf9OMiG70xSF9+evhMmzuLU60avwSJGCizWifb92LipEGdh5QWh6o1LAAhWrE7t2Xz5IuEgnkMwyZoGXOYa+PWDun16ImiIRD365u7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251444; c=relaxed/simple;
	bh=q7HMCA38PwYniGDXa1KCkOKwA61MyWAUgpePuUcCTLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp3MZVcsCoarqDOFXbOAvgjOskVW3yQdio8pafGc4HsjYVH6MPRuizacksxhYGkrIJk5o9+2xs/jdw1vXZ/HHjDpzlgCuHSUPYkVjsE8g019vgPi0Ke+fZEmzV+ddtsGMqkH0DOqEGy0B4xLA6K5fe3p/vhrz83xqF3lsGGd+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw7wXOsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB161C4CEF7
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762251443;
	bh=q7HMCA38PwYniGDXa1KCkOKwA61MyWAUgpePuUcCTLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uw7wXOsNQPKf5d+/M97x9eEBGbyJssv7SNYI0k7OwS6BtFVTmwa6/4lg7ZgyMzezp
	 IpZ+7OHAmYPRe+pAv3GWeb+j3pgUdHBHQ5izY9COD2V7VAMtmR6fuNTbUdgHlG/PjW
	 S+q6GdYXHTVhXnxoM3dGPOiyZ9jOldjpnQHBttBuKJCltC4pKbLBBaxAVpHqnho8ot
	 2P7fbMJa3AeJsoKcwd4OjwDt6GawE7HWJ4aT3OEVFbJlaHnXRFydhfFKbR39cpVrRM
	 uDb2mFYcuAdoDrocET4BaLaljssDDra/GOyUcZcmTigbqExtqp9jC2U+gr0wgZbrk4
	 D3oJ0frfjKE+w==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso71869875e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 02:17:23 -0800 (PST)
X-Gm-Message-State: AOJu0YwZTGBloPESquOcMaRx7gdLMWrveDMCjNpQ0exwAbGPL9we59Df
	BRSmNTbUkorKmceS2efK0CTOjHivvUb9tg+x6RYdI1MsHUOJXJWPto/mjXGEc7dibTK9z29/aeE
	8QTV4xxw1ZD8uRLgX88aNShvKG8pMOpPyvto7Tens
X-Google-Smtp-Source: AGHT+IH3+qkFyDFL+KPolFRSwG83M8ikeehPPfUTJxJWmhUaoo4y7ofHPjRfupDxsQLXJwfwai0tkttJB2D48R/KF74=
X-Received: by 2002:a05:600c:1d86:b0:471:1c48:7c5d with SMTP id
 5b1f17b1804b1-477347bfd5emr120161835e9.5.1762251442268; Tue, 04 Nov 2025
 02:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102113742.34908-1-kpsingh@kernel.org> <b93a5e30149d8ad43f64f8f0d61b3c89e0a694ec.camel@HansenPartnership.com>
In-Reply-To: <b93a5e30149d8ad43f64f8f0d61b3c89e0a694ec.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 4 Nov 2025 11:17:11 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5CgPJ5E3PgxsRAAaWLpNhG3DJSFSPCEfKM7ybVFgT8BA@mail.gmail.com>
X-Gm-Features: AWmQ_bn-KVsOr4Kfy3cJA9y63cfyNnlPdP7vubxz70qlMdUSQMpFyss3tEQrRxk
Message-ID: <CACYkzJ5CgPJ5E3PgxsRAAaWLpNhG3DJSFSPCEfKM7ybVFgT8BA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Check size of the signature buffer
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 1:36=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sun, 2025-11-02 at 12:37 +0100, KP Singh wrote:
> > Accept only a SHA256 sized buffer.
> >
> > Fixes: 349271568303 ("bpf: Implement signature verification for BPF
> > programs")
> > Reported-by: Chris Mason <clm@meta.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 8a129746bd6c..cc5bce20ec86 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2826,6 +2826,9 @@ static int bpf_prog_verify_signature(struct
> > bpf_prog *prog, union bpf_attr *attr
> >       void *sig;
> >       int err =3D 0;
> >
> > +     if (attr->signature_size !=3D SHA256_DIGEST_SIZE)
> > +             return -EINVAL;
> > +
>
> That's not going to work unless something really strange is going on: a
> pkcs7 signature is way bigger than a simple hash.  I believe Chris was
> thinking we should do something like modules do: check to see that the
> signature is not bigger than the total size of the passed in file data
> size less the program data before doing the vmalloc.

Ah, duh, yes. Apologies.

Will respin.

- KP

>
> Regards,
>
> James
>
>
>

