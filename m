Return-Path: <bpf+bounces-49153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE5A147B4
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 02:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34087A2A8B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C472D2EAE5;
	Fri, 17 Jan 2025 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja8UaT2s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E51FC3
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078339; cv=none; b=cy4hB3q2VuaOTVa5e+Yku8EVD65pALirLBJ28Ju5bOAEhKQJSbDPKu1FdpiiCl9WRVMEl5MUmN9tvrngaTowQNYa9EnjtHGz+AoYDKAIKVhVt4RgYdi6Si6MYMnERqPuNp7Xe3abJ9CcyLX+zhUR8Nz3D3VFuqvI/8uk15gpYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078339; c=relaxed/simple;
	bh=GqqHNdzMsvmiN/Oj8VLT+F0gQcRiokRguSFnhQks0FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3SYhCI1L0e8oF+bxWMID30R5SqP6a1vk1ovx5uUadjwAR2QZGEFyGtTZ1kL3njpz/CTutN+rOqM5VXKzilkRTYyAxs8aYd+2NJ1I6BqZUGLwvoj4ST6K9isdp+nwGSdIlTipGQuhXrdLv0ve/iYvULndU0MthJbpeYKkjzwJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja8UaT2s; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d6d5765so932699f8f.3
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 17:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737078336; x=1737683136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpGRof/Fgsf5jaJNL/jU3ufzcFasGyemZ6WIRlPt4x4=;
        b=ja8UaT2sJPIaHXlEThNqqHhA0LaulFWOWMiiCmrCwBpup8MgL1ypyf4aJDCtGz8XTC
         hQGgbj7HzOzlHgUBL2T3n+ojdpHEVbuL0ssqha80/y4dE5zbddiQB7T5iDOKdh0v5lG4
         Aiuru9ZwVcH7bYvOp3v53mXYsXn/hNLb8IHIUVpJ+RVuPf8jqUhwIfJb8h42CBx0WDMS
         Xx+L1pke75VuQksrUfS77WnYRFvCMWK6Nk/hxtTMOxn/FkKl6pvupc03gQmNiYszgqDX
         XP1zoDF/ufUt/03m93bMmYVUIUX9f9eItDn4MGlz/NI0hKtb/InrTwvqbOdyTurm5rqu
         R1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737078336; x=1737683136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpGRof/Fgsf5jaJNL/jU3ufzcFasGyemZ6WIRlPt4x4=;
        b=abq20Xemy+tmOaNtMq4T9N0MQC5YNwia48Rx4TEofaQnB0XslHkPEMwG0uAY2+s3zX
         KmiitjPlFAUKvKhhSMrr1aFD8pHmDqkT/iyQlfN9UH/5u8raxHnhIgoWiqHXw1djVBRB
         qZnx/YqJ2ry4ddBJyOHK9ttRgGrLiquO9J2pA+IPhu0VV6UYO01g9BjTfUF3GdN6/sE0
         RNhFHFQIcxwOXwYbCiTO8WR8Zdt3AvCzC5JQvnls9Kyq5NGN8+EpukxhO/1uEzW8Uwr1
         R52mbKt/GT16DlGdVBlzSZq736jCNkwdqyB25/e0surckpsuwFzPnB5IHUOUxE1CnEeC
         OgOw==
X-Forwarded-Encrypted: i=1; AJvYcCWh/DuT1Uw60N3wR8PXruezuEoQh2rwNJo26jhhstk8uk6ZLdeyqrcKhyKi13Uc1AZTKUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3sizgxSLEu9uabRN6L1hZf4E4bA2Ey6hgcX8R5ymHtqHoXxvm
	4hFQUL/+jICsM7bIDKgOumGF/BSqQb2xctqZW+FHnWsQ+24+vj4b1agfd1H+2ci9/XiRTG0FWpr
	Xr4lihqsNqMkbXL9S63c1CgB9uME=
X-Gm-Gg: ASbGncucSqTK+s+nKNY4CzOS8a7w0kjxGfjlo558F2Ghy7eb2nejxs2axcHjq+4bkbN
	iNS6Pn6KkUn+I4kGo5ffnYzqoDfh/UfS74dK2qGxr3sz/jf+G3IochQ==
X-Google-Smtp-Source: AGHT+IEvS2yc5dLlhsE+eFMel9wiAt4o82oC85WdIn/afiRQpE9G7g32CfW5e1BrQIin/dChNpgwA4b98Yu1+hd+SVc=
X-Received: by 2002:a5d:6c6f:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-38bf566e691mr658213f8f.3.1737078335671; Thu, 16 Jan 2025
 17:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116055123.603790-1-yonghong.song@linux.dev>
 <20250116055134.604867-1-yonghong.song@linux.dev> <75bfa14917a3475f60c6fac9d6480320d6f5f005.camel@gmail.com>
In-Reply-To: <75bfa14917a3475f60c6fac9d6480320d6f5f005.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 16 Jan 2025 17:45:22 -0800
X-Gm-Features: AbW1kvaMHk-7hr8LHFz0ONGV79xIPmllx_5MNzu9e_PkgzS_E2mocZw5nPHMDMU
Message-ID: <CAADnVQ+4ZJNdBU0D8kwe75VOp5x9xLrueEQk4hD1RDR_CJ63Fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Remove 'may_goto 0' instruction
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:42=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2025-01-15 at 21:51 -0800, Yonghong Song wrote:
> > Since 'may_goto 0' insns are actually no-op, let us remove them.
> > Otherwise, verifier will generate code like
> >    /* r10 - 8 stores the implicit loop count */
> >    r11 =3D *(u64 *)(r10 -8)
> >    if r11 =3D=3D 0x0 goto pc+2
> >    r11 -=3D 1
> >    *(u64 *)(r10 -8) =3D r11
> >
> > which is the pure overhead.
> >
> > The following code patterns (from the previous commit) are also
> > handled:
> >    may_goto 2
> >    may_goto 1
> >    may_goto 0
> >
> > With this commit, the above three 'may_goto' insns are all
> > eliminated.
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
>
> Technically this is a side-effect, it subtracts 1 from total loop budget.
> An alternative transformation might be:
>
>     r11 =3D *(u64 *)(r10 -8)
>     if r11 =3D=3D 0x0 goto pc+2
>     r11 -=3D 3     <---------------- note 3 here
>     *(u64 *)(r10 -8) =3D r11
>
> On the other hand, it looks like there is no way to trick verifier
> into an infinite loop by removing these statements, so this should be
> safe modulo exceeding the 8M iterations budget.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index edf3cc42a220..72b474bfba2d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20133,6 +20133,40 @@ static int opt_remove_nops(struct bpf_verifier=
_env *env)
> >       return 0;
> >  }
> >
> > +static int opt_remove_useless_may_gotos(struct bpf_verifier_env *env)
> > +{
> > +     struct bpf_insn *insn =3D env->prog->insnsi;
> > +     int i, j, err, last_may_goto, removed_cnt;
> > +     int insn_cnt =3D env->prog->len;
> > +
> > +     for (i =3D 0; i < insn_cnt; i++) {
> > +             if (!is_may_goto_insn(&insn[i]))
> > +                     continue;
> > +
> > +             for (j =3D i + 1; j < insn_cnt; j++) {
> > +                     if (!is_may_goto_insn(&insn[j]))
> > +                             break;
> > +             }
> > +
> > +             last_may_goto =3D --j;
> > +             removed_cnt =3D 0;
> > +             while (j >=3D i) {
> > +                     if (insn[j].off =3D=3D 0) {
> > +                             err =3D verifier_remove_insns(env, j, 1);
>
> Nit: given how ineffective the verifier_remove_insns() is I'd count
>      the number of matching may_goto's and removed them using one call
>      to verifier_remove_insns().

True,
but more generally I don't see why may_goto needs special treatment.
opt_remove_nops() should handle both.

if (memcmp(&insn[i], &ja, sizeof(ja)) &&
    memcmp(&insn[i], &may_goto0, sizeof(ja)))
 continue;

will almost work.
In the sequence of may_goto +2, +1, +0
only the last one will be removed, I think,
but opt_remove_nops() can be tweaked to achieve that as well.
-                 i--;
+                 i -=3D 2;

will do ?

pw-bot: cr

