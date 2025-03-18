Return-Path: <bpf+bounces-54330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545C1A67881
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 16:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96B83B3D09
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955B20FAA1;
	Tue, 18 Mar 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c29vGxkz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED9209F32
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313429; cv=none; b=aURlf29xWIV/4Y9fYzX1O7EcpBHm3GOvwjlMhoNqA+3Vlt1vUKI07b3/0T/rF10kN1lYfj7XSNQHbg0LnABp1fR0XE25eeJ3Vic8ihCj0kZ35HaOG/+VMcFM2KE63uqf4SemwlGw3FLDhHuDjo8uNdpTvVDLmFsgbLUTBAunyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313429; c=relaxed/simple;
	bh=0YOWFjxjVPYLBOrQGlSnFWFAg/6leUYPfCt68CPj0/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmG85xq0VbmKqFF/PWfjGQyXU4bbWr5Wq8Gobcr0jthwtquy60WHdGaqInu2y9tClt/uhiNEHnmZBdTl9MB40L/RAoS2jOPOhHwH3Ku5O6rOcCq0p9DUYu9Csc6WtuoxgprmorlW5MVlJScedcaeBKZbBk8XI9NNL7nTdcdJ0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c29vGxkz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so35294785e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742313422; x=1742918222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3N0df7kxKMs1BTIJBSiFuJKyXE+UhsE+SBDDKfAU0s=;
        b=c29vGxkzM1bFWUy68zUS0wnvnaodPP7TV5hC+nSyhi305rFdARbqcxySTGDfNxY3rs
         x7Eh1NKxavPtjhnVzuAuGuYCE6mx3LG9M7ywqXyBFK678GZGFkpt6o0M6QRyyaFzRAGO
         xFjqKJ7MOB+MTuWXInsji8JwUfj5wxTtMxu1wjDBEpS70LSyOaoilWQnBefYxUaN2Baf
         6k0Sx5MMzZ+GMTSYrt/um5ScaCm6DIrozpZad6tXFX0ZAIzQ8/hPgTS2osqxOgWayGrY
         wgMWtDSMb/yHfkegetOHL2XZQVqwdrX2IFSqvpzhMEkVjhG0ZFC0bhp1PAYHnwDIdjFE
         taEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313422; x=1742918222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3N0df7kxKMs1BTIJBSiFuJKyXE+UhsE+SBDDKfAU0s=;
        b=M8d7MgaELmKEZiQlnls9brXMJ5OBDk6jD2NyoiBBOD+xN+VnDV1Wi4TS3TykwyUsln
         vYTB4JcV8YYihK3uKsbblB2HS2qRzN8BTwMfUyufn/uxlX1K+V+3KrTOYnXaFC68Djac
         fKRH+K1m/boReWHR2OMGNAQzS4LXyo/WR4ZR2fWuvdQSIEA4wcrQyH4l6KnMzOF/rEHY
         jOiAIV1/4jn3E7bA+imiOrGU9ahsG+9UhdAPcytmTYCQHYDD2uRaSQdlnU3XhfOmBouJ
         xqfwUJZdPR4etswrGI+mU1TPIKF2GSBXcKzVj5JikF2TyHoUJhSsDpY3Ta3qV706+rPr
         6iRg==
X-Forwarded-Encrypted: i=1; AJvYcCX8j4gaW1d0hyk2NUVnm6sioaVaEmzZwL7d4HC9FcYnpE8Zy9jTg7ZRbkiYquY/ulXpsUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ec1D+XfHAp41i8qqyj1YZitd/kVAUBjbp0mtlTBJETZgKYC6
	s6Nh5zn8/QTP9Lc39Xj56wPx9YIEmx/Son4AqwZKWtEIAcfCegI4uZdo8GND4A5q9rqndsmqCqF
	QJtPJfakkXSmB4UdpZbp3G1Z7xhM=
X-Gm-Gg: ASbGncvJIz+iRsjsCKaeS6PKSxh38+LOaePR+uCbaASAD2yuJ8lgInznUsThRRhZJqu
	7JcN9Ui5NHbPVdCNPbmLHl15Mwnedj91ToPpuW0MgP2ln4Vg3eIsf7HiokQAE/Jj/D9BUxWnhEc
	d1oWShvByFBK/S+Dkicpny5Eu8qkuwDgOS3tIg5k+Z4Q==
X-Google-Smtp-Source: AGHT+IG3VFiNbmKos2veg5spdHCaVAg40CQ+bZJnwGEnCzsKEJumXPYr53UGpoXWJqGpPtuRnEnYDp36uHEfmmI8BA8=
X-Received: by 2002:a05:6000:1447:b0:391:3207:2e75 with SMTP id
 ffacd0b85a97d-3996b45f0d3mr4108121f8f.18.1742313422116; Tue, 18 Mar 2025
 08:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317224932.1894918-1-vadfed@meta.com> <20250317224932.1894918-2-vadfed@meta.com>
 <CAADnVQJE89E7pjGK0QzUyX-9oySH8s_YQDibR2Jwt1wP4aT2Tw@mail.gmail.com> <ea824188-cc71-42c7-9a02-355a82eca4c1@linux.dev>
In-Reply-To: <ea824188-cc71-42c7-9a02-355a82eca4c1@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Mar 2025 08:56:50 -0700
X-Gm-Features: AQ5f1JoElGDkpqOHPWPoudfS4IIQHLho3jx1oGkwYZFCvuHD2bXhNiL92QFAF2U
Message-ID: <CAADnVQJOGwBTnDQr1bvj8XZgDULfELYF2pReptw_+h1CkFYoVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 1/4] bpf: add bpf_get_cpu_time_counter kfunc
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>, X86 ML <x86@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 1:17=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> >>
> >> +                       if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL=
 &&
> >> +                           IS_ENABLED(CONFIG_BPF_SYSCALL) &&
> >
> > why?
> >
> > It's true that JIT can be compiled in even when there is no sys_bpf,
> > but why gate this?
>
> Both bpf_get_cpu_time_counter() and bpf_cpu_time_counter_to_ns() are
> defined in helpers.c which is compiled only when CONFIG_BPF_SYSCALL is
> enabled. Otherwise these symbols are absent and compilation fails.
> See kernel test bot report:
> https://lore.kernel.org/bpf/202503131640.opwmXIvU-lkp@intel.com/

put in core.c then?

> >> +__bpf_kfunc u64 bpf_get_cpu_time_counter(void)
> >> +{
> >> +       return ktime_get_raw_fast_ns();
> >
> > Why 'raw' ?
> > Is it faster than 'mono' ?
> > This needs a comment at least.
>
> 'raw' is the closest analogue to what is implemented in JIT. The access
> time is the same as for 'mono', but the slope of 'raw' is not affected
> by NTP adjustments, and with stable tsc it can provide less jitter in
> short term measurements.

fair enough. the comment is needed.

