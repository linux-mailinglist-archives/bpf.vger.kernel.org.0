Return-Path: <bpf+bounces-55816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9FEA86DB4
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 16:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E62B7B5604
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D51EB1B5;
	Sat, 12 Apr 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXbIii3O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9B13AD22;
	Sat, 12 Apr 2025 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468248; cv=none; b=mp/5sU+/gZ7H31+UMcm00czO9d3dtyjT9Bu06/YDdpv5PZJxZtO9vb5LoFkFco1Bjh9UvliumJzbwzjVIEqWxcoUmEX2/Nx+inaBvP7t2fil0gxgqYRUw7HqC1IzsQraYNGnZtkqq7KYIINaRWoC0FOxEvQVQnJz5vY+NOt0YL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468248; c=relaxed/simple;
	bh=89CuY679EakrsgRXvkTZPuXG0MWEAH8SvBTJoe5niJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/dg6ikyeXHhVcNNq0Ye75bLk1eZ/WOU54H7l/7vg//GqYqAPGah11w71ulJF6TzlJLf5nz3GxfGvHIvmnH/eJD4YgvHuloMni1oy86gkSQRPC7tMpTww7K2Tq1iJySkzaOZi0sMMM7OJpTaXIjaFTQxTtZ25sVY5ToD7FlFc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXbIii3O; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-702628e34f2so24918337b3.0;
        Sat, 12 Apr 2025 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744468246; x=1745073046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rp3I/ZjSmQqOkmoMt0iopPyabA+peC8sdF6n/q27d0=;
        b=LXbIii3Ow49C+V1cKVIM2XSKHNOMrMwYM5XoL35tJJ7IE2EosNwJVElGfZMycVmPDB
         xro7qBCGEwM6/oyKFoD05Rwqize3e99szWYdA3YWulv8CWu1TWM4UpqjZZ3kNZY3f3hO
         tz7FLpkbHqxh4I333d4fySDoGrjRMroAOHAboCY3sF1u/oPjt2iIPTMLsGbwWQaAh5IZ
         OPZjZDdZUqMH0u24BmSflDOt1RQ3hI/oMzA02rQw8NLN9sEnhfbbX66lH9ToIQDxZoBY
         RWjb2E8UiXs2+Ff8525vWO1DeqQaUF/dmk7Zbz35nc+2X9dvQa38ruxrgew1SXylGryl
         MCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744468246; x=1745073046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rp3I/ZjSmQqOkmoMt0iopPyabA+peC8sdF6n/q27d0=;
        b=hblN/08DVUiXovIdna7Y7cDzZ9bVsi7Onl3h6KqYRYnb8wSxc4H8ojHluEI+4sLT5H
         8deWGqtGzHil9KI/gD4Mh+dPHy0b05M9mOYSm/1/+iuF4E+aPfe9cX4FFaxC82fv0Q0F
         Hr3nyybLKk+D4a3VGQXaPOfuMnGE4QTBbZeiLaHiw0UXh/en/dJQx4vW4r7mK3wCP75g
         nDab7ZgiZQmTaEslBQhhdBeRDmrzbGwro2v9vQ4s47QyzIemOzZJbuxhdiR3PVeDXK8Q
         a/50hKL3F8T7eK/DwJDfN7XudlyZFZ4Bbqwp69VXbiYM92TfM9UM2Z6XFFNbTFJ6m3lU
         E3iA==
X-Forwarded-Encrypted: i=1; AJvYcCVBero1H4iV7kzPF4n5qsK8hF5VT7smIju6itbtW/gjDZHCAOeSU0N+mAz+v8vCVLeg3lA=@vger.kernel.org, AJvYcCVPRMoZzdUr1Jcmvtrslm/0ofzmKLJ/lGmIeD3Omale+Q/kgK9cR2LA1sosd5Msxs8Me6Ec15AP2p3enNy/YpCCWm+d@vger.kernel.org, AJvYcCXdtLLo6JWrUJjgapEFP0sFYYCJn2yxrk7koRm6yXETNDtlt0p8MbU0MAmI+964gfLmrXeVZ168Ix0o+O7A@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDd7Fa4zPxL08PLCEeRK5GKiS685ggeEUzI9V8zQcckEXX01P
	8kQclV2KEe5qyT7C1yISesfgn8EEFJO/yjUR4E62JLSmITtqaCH+0Uv+lqj4UQd+jBTVcs4pLNC
	Hzd6v0uUWJvZvk7vxjPzsXtHoLaidV6uyPas=
X-Gm-Gg: ASbGncuS09qvnSP4C8PpkuqcJwbxkcJg75fZ6HRR8Em3np9DCbqDFCe9tNB8iTARIiT
	dVxJMxCkvls6CM9M9ZqdICQyz4l4vXE8oqfrhiSdBQ3VrYnZnS8Cdl7XrEBGicHwVKJfP5aJLPb
	Y9xUU8rLb08nTe0L8Y79bTVg==
X-Google-Smtp-Source: AGHT+IHvTiqvSUYKewYRvkxmFA8M0QUmcvMIeCFAMKU6nr2dqeTYXdlODjaLB6l4wp4cnTBtfDFQP1oWmzPcoOWoqYs=
X-Received: by 2002:a05:690c:9a83:b0:6fb:949b:57b with SMTP id
 00721157ae682-7056ef2b3femr25814037b3.12.1744468245559; Sat, 12 Apr 2025
 07:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412133348.92718-1-dongml2@chinatelecom.cn> <20250412100939.7f8dbbb7@batman.local.home>
In-Reply-To: <20250412100939.7f8dbbb7@batman.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 12 Apr 2025 22:32:45 +0800
X-Gm-Features: ATxdqUGgW-DTFyYsf0JlcAnExs6kjK0JPuSqwUDAzEGObDePjaViNcMBWl905vQ
Message-ID: <CADxym3bAy4aV=UJU9ge0vw055C2DzC=zubjhOBSay_88CkW+hQ@mail.gmail.com>
Subject: Re: [PATCH bpf] ftrace: fix incorrect hash size in register_ftrace_direct()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 10:09=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Sat, 12 Apr 2025 21:33:48 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > The max ftrace hash bits is made fls(32) in register_ftrace_direct(),
> > which seems illogical, and it seems to be a spelling mistake.
> >
> > Just fix it.
> >
> > (Do I misunderstand something?)
>
> I think the logic is incorrect and this patch doesn't fix it.
>
> >
> > Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash =
while in use")
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/trace/ftrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 1a48aedb5255..7697605a41e6 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5914,7 +5914,7 @@ int register_ftrace_direct(struct ftrace_ops *ops=
, unsigned long addr)
> >
> >       /* Make a copy hash to place the new and the old entries in */
> >       size =3D hash->count + direct_functions->count;
> > -     if (size > 32)
> > +     if (size < 32)
> >               size =3D 32;
> >       new_hash =3D alloc_ftrace_hash(fls(size));
> >       if (!new_hash)
>
> The above probably should be:
>
>         size =3D hash->count + direct_functions->count
>         size =3D fls(size);
>         if (size > FTRACE_HASH_MAX_BITS)
>                 size =3D FTRACE_HASH_MAX_BITS;
>         new_hash =3D alloc_ftrace_hash(size);

Yeah, this seems to make more sense. And I'll send a V2
later.

BTW, Should we still keep the "size =3D min(size, 32)" logic
to avoid the hash bits being too small, just like the origin
logic in "dup_hash"?

Thanks!
Menglong Dong

>
> -- Steve
>
>

