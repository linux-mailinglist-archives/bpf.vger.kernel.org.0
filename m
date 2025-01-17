Return-Path: <bpf+bounces-49216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD5A1560A
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB413A34A2
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8C1A2630;
	Fri, 17 Jan 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlOoAvmQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA286324;
	Fri, 17 Jan 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136429; cv=none; b=CP/73HzPYED7nOsrYC25GYKpVhN4JtRhebXdmOk+WzTziiLstwsHgS2LNeyNsDuz/K7xmviZdGVMsp39LDEitvVgN0mrUXYLbKNEY9j39XhvsWgApj2dVeYMJWZ362+1489QVHyCgbaWtcI92a2C4ogh2zkGxsSDWcGm6vk5flU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136429; c=relaxed/simple;
	bh=Vi9ngEbEEJ9tE/5gbN1CRVN0AigKlK07eDeAXByiJfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lp7lcedmK63FHz68m8TfUJ45cGWkiJGWJfZZ1gLHbSpGEpppSocG87HbKKYFjRdyN8L00A6O5ejwpBKuWpY6HGdSaHdXTgMQrving89kSaCml0PhoCvab5aFmHh8snFmZmBoyCG3rE0GifoZl0kMAUelqkpSuBxanS73ojhQsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlOoAvmQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so4390891a91.0;
        Fri, 17 Jan 2025 09:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737136427; x=1737741227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi9ngEbEEJ9tE/5gbN1CRVN0AigKlK07eDeAXByiJfc=;
        b=TlOoAvmQxM/t3ICGddHl1Xl5uhCGJsMsp7nfDnHWWYZUjAJKtwR7G3F1Vcgyy7NmEY
         EkPOlZ+GVuUBnuq2JHHNd2WHT9HKo2coiKr2UdUU2LP8skyDxXzJ+hplrkAAlaVnCKx8
         WbOjWBFR41OsnQvC3HWmAqf3grbraC+H8fP1jE7BDdowHn4mJ1uuITKPN4JctDVoQx23
         8KwpDHIz9t+Fy9ioP3m9x8TaXqz5d0IgJBSq66D7fWHsbPT/KfZdinObMGMqBZcKqeSf
         cpxdWI20uBKX/3vOdx+BdgiFsklI5n0AQ9H3F9ZZRkEB1/FeT+CqC1hXEfik8p5wjrEj
         QksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136427; x=1737741227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi9ngEbEEJ9tE/5gbN1CRVN0AigKlK07eDeAXByiJfc=;
        b=bBXQpO/YWTBXdP9apxtuFi4RE4fvRKfKczbNe32e1lwRJw+sC07qEU4DeqgH+7ocDl
         yTawIHPHeZlxbS0cS1BAgmu7DLRDamks8Lyw9/E4345xF9K1lvR58hVREJvZHhjLRtAy
         m+5/iT+wkPEaLW6WScAPIjgsLQh/ToVO7AiGtIyHG2ElTWv3aZusO9reOE6FO/8rA3Qg
         wHXISmZdBc6FUI+tR39Th1sIEae55IEjDJ3irovUKZSopsV8zZjaU1EnDIPEYwRbz/VX
         y+vh1LFWMS3Gyxb8niHIvgHILKzay0vlPzPKCGRLNm72G9LsV9D3zajsekZ861qscA6B
         r5nw==
X-Forwarded-Encrypted: i=1; AJvYcCV9fVWyMqj0Y6C6J0cg3NKBwrqUa7vLOvxSdy3F2Dnnjj8ze2gIR7TSw9ePjLPNkG3CjAxciQ06kbd6@vger.kernel.org, AJvYcCW/CkgU+zpdS2bORPG/xm2d4ftdLWTTu16MaCtjsyM2ucff7eJUiJyRO0UzBGhIUU4Aj5ldYkwj9rUmn00WfVjxsNG6@vger.kernel.org, AJvYcCWQrvx3mwLBWX5yVHycWet7qCZN8AwNhjLU5fwUJtrMh5lx8yZrleBtrc9Njuo3xrf9Wawav6UUm6MuQIcr@vger.kernel.org, AJvYcCX/3EzqEIfuSuWPyLeHaya5CXfRLlXShb+NzEp2wnJLOhSiMvBfyDetgljlfYxtS4YUAS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CxwW/XRXUYIT7oijN8p0bBj2WUDLIFqpqNaTqYV4X0Jitngx
	Fa5pNZME18MwAO2qWEC9fpXqfMLrl267Wo7ykAH7Vtocvi/zhMMJT3avJ8WDmXzEMq0Xuw2+0wt
	Zj/UD5nlIfMlL10v+Hu4JZBKKdZg=
X-Gm-Gg: ASbGnctBX0couhEq5H11E5G/GjcVaQEMCX7n3IuY6+uFOuWCyOcu9IX6jdr5FRmtsgM
	0O8IK8TWyuZGLtigq7q2WK/blM6SKUsdJnFC7
X-Google-Smtp-Source: AGHT+IFULhbKsE8nTOnbK493yGfAm1R9xZ//f+w/HAcEk+EXHFpP+nrfegB1FpJ2d590FkNXfGNhCO85tr6oatbZUUU=
X-Received: by 2002:a17:90b:2e0b:b0:2ea:83a0:47a5 with SMTP id
 98e67ed59e1d1-2f782c66295mr4983581a91.4.1737136427209; Fri, 17 Jan 2025
 09:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava> <Z4YszJfOvFEAaKjF@krava> <20250114105802.GA19816@redhat.com>
 <Z4ZyYudZSD92DPiF@krava> <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
 <20250114203922.GA5051@redhat.com> <CAEf4BzaRCzWMVvyGC_T52djF7q65yM8=AdBEMOPUU8edG-PLxg@mail.gmail.com>
 <20250117114130.GB8603@noisy.programming.kicks-ass.net>
In-Reply-To: <20250117114130.GB8603@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Jan 2025 09:53:35 -0800
X-Gm-Features: AbW1kvZnRk6vdlhYx8A7dRd_5Pqekb8g8c3ysccwsG7aafc2qTZrOC-S3sly2bA
Message-ID: <CAEf4BzZL9yJa6S7Btr+gqGXR9UGJJonP6c0+MvusTJ3bWKTxSA@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	BPF-dev-list <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, tglx@linutronix.de, bp@alien8.de, x86@kernel.org, 
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 3:41=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jan 14, 2025 at 01:45:11PM -0800, Andrii Nakryiko wrote:
>
> > someday sys_uretprobe will be old as well
>
> And then we'll delete it because everybody that cares about performance
> will have FRED on ;-)

with "then" sufficiently far into the future, sure :)

