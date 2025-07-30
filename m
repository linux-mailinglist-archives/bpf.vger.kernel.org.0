Return-Path: <bpf+bounces-64751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B8B16933
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A6D18C73C0
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 23:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FBA22DA0B;
	Wed, 30 Jul 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAa5asOy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84B376;
	Wed, 30 Jul 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916867; cv=none; b=Dz0tsAxxqDc48E1JLDDYCj9lF8VtPUlu+pF508jfu5hfqS+3fAH5+EUhuQmupuuVY7v8EgRpJgWKo+wHZQozK2Be1jT7Wd6KaPKv5r9AuvM5plO+9aSu8xeDtrVXrIhDwJJic4WyJtJRRf/Uqk6pF180abFXWm/mYfxrmuHRdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916867; c=relaxed/simple;
	bh=EfNLOWXvBE08bG9/p57vzz7iXdDjSeYR58OYnGwL/1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gm/lAn6sKAEzCRTDfRHM+vat0WHJCpyXnWN8yjTcq/kOU1KH5y7t/yYMGa4L+FaP8q3PfR+rRSP0h15ytt6XYZ2ncRFcJd65wyV5rPE2Hy8oF3Io9HcPXFLBzymQRzfNJeD9zuHZUOmL2KluPJodrv3czlZW/OqbTmvxkwl6h0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAa5asOy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so217671f8f.3;
        Wed, 30 Jul 2025 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753916864; x=1754521664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3a29EDsVrSzFNpSoYNd5AmoSAvV7ZAJt6iXbSaLdZS0=;
        b=VAa5asOycdTxGArDb6Z66+EmeynnLmTXxKaGzr1X3WlpQm3Sm1RAJdSpeM8xLW3PaE
         94Wh6nVVmCKqwufJvcpFZFXswfeexX2MK7wrA764V1hchIOQEhaesPJxlv3YTfuTuPXx
         uCRE4DtmdAxznY1Du+uTBRonM4tt0CIsQUxYgKjUZ5Kl87SwLB0xn5YxYlJ9jUSxfqhX
         tWGWFYILAfh2UIWrxiehGYXoe37KGmWfBLphLK0KoPbA5YaVybEnVbL+7yKgVQlOtQtS
         FZTN5+yObA85NaN+5i/HIGF3vc9Ps6lojt9SymJZI7RowKKdkEjVRTmmwd1Amsg0qwK1
         Ur2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753916864; x=1754521664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3a29EDsVrSzFNpSoYNd5AmoSAvV7ZAJt6iXbSaLdZS0=;
        b=qAojVDwW2RmkREgHS8vyx1wP9RJWxxVuK3kDT6h/Fqf0Ppam1Xb35UAKMuhlsmBF20
         7YC65d0DRSNW9enPerEgN9+bBqidK39HFHMJc+sZBAMmvJvAsjYNgKy84iNT7eqz2gae
         zziSwJ/zQzkdlKFavTvKomERXONmEvOu7cqTG1vtpLWBh0EFVuPSD/gjDHDhZVQ7HCPH
         VZw6bO1wsUIYHOx+1xPU/GBY4+unokFgzhleoPr95vNcOE+/cbQCgGPzZaQNZs9A2B4y
         L7jh7K0eF8d/RXgcSVFXxjuBOhnlfP4aDMxGV1RRbY056jHs/eT1BPjKzrZnhhPnaDnw
         SngA==
X-Forwarded-Encrypted: i=1; AJvYcCW/4n/fVXug3u1kXfF7471vX0uawyJFvYLlvg3NI8UwcJX4Z/AEPd8/MpdXLDGH1QEB9i0=@vger.kernel.org, AJvYcCWMnGZQNmZ4FhBrS9oYmEaZXsBE0kMX1TDA/JTDCsBuwiOf0rEkVEN4yr9x+M5QKtkAawC5l8JzdZ4j01vTHXd2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyktl+G93r3H9ssmeI6PHZwxMznZpnJKBqu+AzQX1WUTvcXeJVA
	lqbP/Bt0qQW/cDPEQiOS4GtZdoe7vEaWSTO/Gll8LHmJCpcVoGzBMdr5QT4CVl4C3NBRUE/LjeX
	B5smmlMtWcborcG3qqsixCOxvBMY5dnk=
X-Gm-Gg: ASbGncv4hixfX0V1f3XzS7RTG8xmQNFvctYDbmouqtbTqn60nzO8VX3jN2NEW6SyI7s
	b+xfQEEBFhJMgkRs3eI+KfMu4FN7Z/kACv1AfMScK2N4qh/nkIM/YvnVIDLHOeEhz7CGYDKQQQC
	UXoUrcOwcaqzo4BVV6PNLVoZZmLz3/XxeCnd6yi52t/aV//0PrpbT54/HFGsCRcfN4VP9znI0ZX
	/vSBcgtvL6EHICh7r830zz3acXX9oEB8Lx7
X-Google-Smtp-Source: AGHT+IHQV5/abT8DUAvFKoAoHEvtAAN6pPXaSz7JlhGI63gQZdoXWi5CCuUcTGJGtf6ysntRbO3Tt3uFqmZxv12ZUYQ=
X-Received: by 2002:a05:6000:288c:b0:3a4:eae1:a79f with SMTP id
 ffacd0b85a97d-3b794ffd043mr4089073f8f.33.1753916864303; Wed, 30 Jul 2025
 16:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703204818.925464-1-memxor@gmail.com> <20250703204818.925464-9-memxor@gmail.com>
 <202507301559.C832A9C@keescook>
In-Reply-To: <202507301559.C832A9C@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Jul 2025 16:07:33 -0700
X-Gm-Features: Ac12FXy5WZE9AhUIWG7WvOthQEO_WRHYvbJNJwIx-s2v_Bv1pujYc30C0bTsoks
Message-ID: <CAADnVQ+n-o2qeoLqvfJgY4wf9Ms-xs_SyEZhtfgkidqjX=u3qg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 08/12] bpf: Report rqspinlock
 deadlocks/timeout to BPF stderr
To: Kees Cook <kees@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 4:02=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Jul 03, 2025 at 01:48:14PM -0700, Kumar Kartikeya Dwivedi wrote:
> > +static void bpf_prog_report_rqspinlock_violation(const char *str, void=
 *lock, bool irqsave)
> > +{
> > +     struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held_loc=
ks);
> > +     struct bpf_stream_stage ss;
> > +     struct bpf_prog *prog;
> > +
> > +     prog =3D bpf_prog_find_from_stack();
> > +     if (!prog)
> > +             return;
> > +     bpf_stream_stage(ss, prog, BPF_STDERR, ({
> > +             bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\=
n", str, irqsave ? "_irqsave" : "");
> > +             bpf_stream_printk(ss, "Attempted lock   =3D 0x%px\n", loc=
k);
> > +             bpf_stream_printk(ss, "Total held locks =3D %d\n", rqh->c=
nt);
> > +             for (int i =3D 0; i < min(RES_NR_HELD, rqh->cnt); i++)
> > +                     bpf_stream_printk(ss, "Held lock[%2d] =3D 0x%px\n=
", i, rqh->locks[i]);
> > +             bpf_stream_dump_stack(ss);
>
> Please don't include %px in stuff going back to userspace in standard
> error reporting. That's a kernel address leak:
> https://docs.kernel.org/process/deprecated.html#p-format-specifier
>
> I don't see any justification here, please remove the lock address or
> use regular %p to get a hashed value.

There is no leak here.
The prog was loaded by root and error is read by root.

