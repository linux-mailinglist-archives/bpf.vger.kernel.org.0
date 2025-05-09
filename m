Return-Path: <bpf+bounces-57905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD59AB1C2E
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED573504C8C
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F323C50E;
	Fri,  9 May 2025 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k29KyEDc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BA23717F;
	Fri,  9 May 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814864; cv=none; b=Pz5Fw7cVSVe+LoGu9vMI3gmVBTqhknzEzYEveO/neQpibMcVClg2DoBzi98cO53tvjqkG0yVe6JGiPG5x0QhLV0nTd+iclQI+wUwLkRMSbPnXNc+dAM+TQX2nAioUVXu4cZDPX7x5utSJdANoP1fbOek13Y1pqsbJq3uoDOmjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814864; c=relaxed/simple;
	bh=4qGf+LVCHq9Re0HaJNst9Sr+cVcbEf1KtVPrSG6+e7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWgA5Pj2kDoLTZtDPioS9ItXcoBFbl0JZnp3GsrG9brlCAWLjMaXwfRJ7n1C3e3oetTbEw/RmNdPi1egTFL+xZLMesPoL4ldXLLV8OcRwSypHyCGO07/tpHIpHy1XtywcdLMabeMTgk/AAhOpJbgr/7B5YQEiv65DtFjqCficRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k29KyEDc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30ac55f595fso2401247a91.2;
        Fri, 09 May 2025 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746814862; x=1747419662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5E5gBHYUotVCXygYJ7CZEIFVsARQjSCRuzkPt94fVY=;
        b=k29KyEDcWsTabm3nNJL7PdrSTbSKjuTvrdN2nLu2wk0Rx4dT4Vg7Wwrr17mE0M4wsm
         gZsoFV7PtwDpVbacyleuZCQCBZkL4j3Qs6NNqRZO0qCrMJvMrMkJKK/ljN9fkJI8Mb3D
         9BeX4ZU1MG6IjVBkvQOUTAXvp0XuMZ2Hf0HcqGjygghtlOfoUaITMH6CX9R4WBZ9X8M5
         XTLTPpXDc+L1yKiIhXnLz/5o3EOtraE+Mv8XLcPmKKSfAQc72GJWaPqHgLiSmzCfP4g9
         1HhXOkwdFjHpoUpJwEuWf6i0cfu2XvXxMfJfs0AyrBJBzfh5zj4Bnabpd/Rh60BP8K8c
         H6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746814862; x=1747419662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5E5gBHYUotVCXygYJ7CZEIFVsARQjSCRuzkPt94fVY=;
        b=pAO2SnrYH5bwKb2LI+kB6AIV9g8+PQ1H7D+86LX7dgQZZeVR+3hNDZYZxrochSX8b+
         F9NGv5sUWusl662rfQnlxywQsEvHw3yyqlvLUd1IHofmo5d225IxDP/a3f7QPRTWJ5RE
         xIA/fshvvtOJAyb6r+Yn8s9CuQGEZVwtcTaSGSSdMcRa7LJfBlgMiXrS91hnpsZze+4w
         RzBuXUaQ3uB07GgCwtcXGmqL5k0I8ikmfdLV2qRuFqIY9LWDrbKcSGzE8g2Efk6xHA/E
         KGKbgE3PEMYC47SbOvLvUFdc+dSPV0zNT1obzV2kzjKg94Z2l7qM9qUGT/KRVmxxSTOd
         f4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVcRaSHdQ0huNT/48PVDOK1sf6l4cWLu4zlNd37ffDLVnLo3Sv0SIY6+FcnMC4B40N8OGHMy8DWjhzauPiS@vger.kernel.org, AJvYcCXqY0JUO1SUrSEk43r93hb1EGHqrmZhudKJ+O2YkxGfl3CzdNAUKCUY8oJ5uu2JyPt4bv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwciU7jfLYbTCSLooYDHqrDDkLJm9y/QhxdxWYS9rvLG/1Q3T50
	8SC6/3lFGKwMIDz0SCwvZ6RMYwI9fmY6HSefp3Qwvs1d8C3hxVNkR0TLvkAAzz3b8m78LbzdDt5
	xMe9lWgkouzs4DqGGOGMYiFMwrIEJ5qdglL4=
X-Gm-Gg: ASbGncuzIaI6J5akZqZu3jhKYtj1BLVWEj5lw0pzy01gOHgvjd+ZXI74XDWQ2jXzcHe
	BzaCU+sOawZ+B5XrlRfeMiLI8vDAiN8GcW8AtjuH8waaQ2R2D3MiQxNDSGZDb5TbaTcyQN/7wjy
	lLQSVwcvtcHhRIAEeNEl7ja0qyRXo2K1ZvLuuomwGhx/D/G/t7
X-Google-Smtp-Source: AGHT+IEp8o0jmBeHS6EkmRW9IH2ThKoCdRcI6N4ukVYGmrH04cq4u3PUUlIdplw1/VK6DrAHolZFw/HzQy7XzBcG53E=
X-Received: by 2002:a17:90b:1fcd:b0:305:5f25:59a5 with SMTP id
 98e67ed59e1d1-30c3d65e740mr6497432a91.35.1746814862365; Fri, 09 May 2025
 11:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746598898.git.vmalik@redhat.com> <39416cac1d011661601caffc6ac38195c82ede86.1746598898.git.vmalik@redhat.com>
 <aByA1wael6H4tMo8@google.com>
In-Reply-To: <aByA1wael6H4tMo8@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 11:20:48 -0700
X-Gm-Features: ATxdqUF9WK-pNGPDCZayEa-Xkx20a9zhOeb-2sf3yHNgsZfGklVmpEfNjfiQrqM
Message-ID: <CAEf4BzbggjOmEziyLjSRSsEQzLMMXQGoEJ6SODVF2exLR1S9UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] uaccess: Define pagefault lock guard
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 3:01=E2=80=AFAM Matt Bobrowski <mattbobrowski@google=
.com> wrote:
>
> On Wed, May 07, 2025 at 08:40:37AM +0200, Viktor Malik wrote:
> > Define a pagefault lock guard which allows to simplify functions that
> > need to disable page faults.
> >
> > Signed-off-by: Viktor Malik <vmalik@redhat.com>
> > ---
> >  include/linux/uaccess.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index 7c06f4795670..1beb5b395d81 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -296,6 +296,8 @@ static inline bool pagefault_disabled(void)
> >   */
> >  #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
> >
> > +DEFINE_LOCK_GUARD_0(pagefault, pagefault_disable(), pagefault_enable()=
)
>
> I can't help but mention that naming this scope-based cleanup helper
> `pagefault` just seems overly ambiguous. That's just me though...

I do see the concern, but

DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())

so we are just staying consistent here? But also "guard (against) the
pagefault" does (internally) read somewhat meaningfully, no?

