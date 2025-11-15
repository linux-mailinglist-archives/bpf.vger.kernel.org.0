Return-Path: <bpf+bounces-74628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC10BC5FEB8
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 998D24E4C1A
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799313A244;
	Sat, 15 Nov 2025 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsaboFvS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980B14A60C
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174391; cv=none; b=a2gunGzoy7mnFmCu6WWhNugVtwk/ylgWvHkCG6hHeAb68PNC300LPmqoU9Y5v1LpuJ7Rv8pDx4W7/DlR7bOXS5Fb/3cCpzex2trWnEcP3VWsxX+Mb5f3BjDU4Rn/BDhoP4WMQpSc/9IcpE38XfE/XbwoP2vf7b3r5kA1EKEx5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174391; c=relaxed/simple;
	bh=gqysG4ug2z8wG5aRkdFy1JFZ/fXY6FPON2mpAtQGFfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzGUnQGEw61srTPDuoVoSInB2oJVGcKKE/nB44HX3LTGIL95zp+wUePAGMTGkj4L+FzkTM8d7gzczrZaXna43xpvXHTi7K7LDVUmPRLBbcvjGOV6sK784PBRoFHAq88+2XNfaR1Rc2+mHL/jjAqlnNz7WwAiwJGh4ZgSmseWZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsaboFvS; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78677ff31c2so22365067b3.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174389; x=1763779189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpFfOEHt1yzt3Q9cYV8WgHC2Py1Yh2XlB5O8fzKjYvE=;
        b=CsaboFvSBfWSYNRWkJ03ywp0+jhckhLxX3NnUe7qTZQfYMFWbSXu2M5x+aw5vSjKgJ
         hxMs0jsHVnAZMc/j/ABjHxa8HefZVQoXaOjub8oOe728XUJwy0pdOds0Dv+L5Q4mR8nI
         LQH3R0sbCF4BVEb2jhQP8wdtFNphjeoAn6htq3bEI5gNIPVOOOhfxV+mu9VGtJVg1JQd
         xnmRgaYEZsoTJY6QLUDPb6wrdYbbtN01F0sbtgC9KT3AtiXIiZorYkbKNmkqd0LpZBDf
         sNrERBr9M1wDuLqQW0c8ZFCkCluF0CkJisn0ygOV7h4mj8DwHSAsvMlR0ZtIV531hFIt
         234g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174389; x=1763779189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpFfOEHt1yzt3Q9cYV8WgHC2Py1Yh2XlB5O8fzKjYvE=;
        b=egER+oyKJb1p71xDKzn4Fl0qjOMCm/4XysUiN3PuGwy5cE/ZkOO36jgWOXUt2I3God
         SXuyrREnfReWL2aclPNHRq67icZxe6lOdz0HFOTuf0Kv/FdZW2j8cpNApSPTyNIQ7SIb
         N70I/EFtIzN2JIudJ85nMZeuF+uNmFXUpvVJZTQQkOEJVgDSj6y9eJ8gWJWWRy1tmI3C
         AaLZ06CazVyP0F5/fD+CVL40jgbt029QM10cGkWCUkOWO/crbhsHNu3CMp7wVqJ1C1oO
         v7MeR34DfqZlpjqFw1+4qqNNQ+tYJVZgnrZA0TK/RR/8blbfczrdUyLhAI+yXL88W7LL
         PYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa/mqmgM6BK3lywRFcrFd+JDZwYGECLWK7zFnXVhJGuQNrdPKZsTeCi03STcfN7KoLmdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZbOltOzCiZvORtaSMUgLnL7NYeEk2Lp7WQMdG7siNpgVWPyn
	BYghzL7lXIwFv4nY7gC4iKyFzkGkoN335/9v87XYSmcw5p/sgUbyAwYf+wwNY8P8/i/28u/2vI8
	vHjNIbgFAp+5yiLhSzrsqjZAN36IzP0U=
X-Gm-Gg: ASbGncstgjtMKeeRpsGmNS65GPytcO/O8ZDq7N1xrjFfM/RKm6q4qtvfaK3Dz9Bbrhb
	qW9SzqaMGoU6MaCVf1r6OGwuuyOB3UqTaxBnOXa2Oe856rrpdV/xAFch+yWGCp4X/6WGJtAiq7d
	aBrqoQV1Vvj3Bn9qf2iv07FiY11HB6d5Ir46ylZnONfLsXHDU8bi96q/jwsM8L4GttBCWSD+Iwu
	8AoE+JX5TJ+0ALdCFvi8BzivFf/tTTSBc/MSpPxXhcQM5oJuD57Fj3spi85CN31SfNGcCg=
X-Google-Smtp-Source: AGHT+IH9DYY1lEwS+EOIcaPqX+5gOOxWet3rXc5XuQvWVm1J+6hFlHeq5NVMW5p3eQdYscXliQ3No3u/mXn51VBFNwI=
X-Received: by 2002:a05:690c:724a:b0:786:7aaa:a04f with SMTP id
 00721157ae682-78929e01443mr47780157b3.8.1763174389288; Fri, 14 Nov 2025
 18:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-8-dongml2@chinatelecom.cn> <CAADnVQKw9PtRYooO+qKQ70xgNusEn8qusBFfzU+bZ7WXRg3-3A@mail.gmail.com>
In-Reply-To: <CAADnVQKw9PtRYooO+qKQ70xgNusEn8qusBFfzU+bZ7WXRg3-3A@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 15 Nov 2025 10:39:38 +0800
X-Gm-Features: AWmQ_bmgLFOwAJbHNJYZ4FX17GgYxKCY245TEOD8ciu-UCZuXrVOg-cZbkoq6oI
Message-ID: <CADxym3bKsw=mrG+wNErLouhPSeobuqY7sTZRS=HrNeQ=0=p4Jg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 7/7] bpf: implement "jmp" mode for trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 2:50=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Implement the "jmp" mode for the bpf trampoline. For the ftrace_managed
> > case, we need only to set the FTRACE_OPS_FL_JMP on the tr->fops if "jmp=
"
> > is needed.
> >
> > For the bpf poke case, the new flag BPF_TRAMP_F_JMPED is introduced to
> > store and check if the trampoline is in the "jmp" mode.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/bpf.h     |  6 +++++
> >  kernel/bpf/trampoline.c | 53 ++++++++++++++++++++++++++++++++++-------
> >  2 files changed, 50 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index aec7c65539f5..3598785ac8d1 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1201,6 +1201,12 @@ struct btf_func_model {
> >   */
> >  #define BPF_TRAMP_F_INDIRECT           BIT(8)
> >
> > +/*
> > + * Indicate that the trampoline is using "jmp" instead of "call". This=
 flag
> > + * is only used in the !ftrace_managed case.
> > + */
> > +#define BPF_TRAMP_F_JMPED              BIT(9)
> > +
> >  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit i=
s ~50
> >   * bytes on x86.
> >   */
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 5949095e51c3..02a9f33d8f6c 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -175,15 +175,37 @@ static struct bpf_trampoline *bpf_trampoline_look=
up(u64 key)
> >         return tr;
> >  }
> >
> > -static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr=
)
> > +static int bpf_text_poke(struct bpf_trampoline *tr, void *old_addr,
> > +                        void *new_addr)
>
> The bpf_text_poke is a generic name. It really doesn't fit here.
> Use bpf_trampoline_update_fentry() or something along those lines.

ACK.

>
> >  {
> > +       enum bpf_text_poke_type new_t =3D BPF_MOD_CALL, old_t =3D BPF_M=
OD_CALL;
> >         void *ip =3D tr->func.addr;
> >         int ret;
> >
> > +       if (bpf_trampoline_need_jmp(tr->flags))
> > +               new_t =3D BPF_MOD_JUMP;
> > +       if (tr->flags & BPF_TRAMP_F_JMPED)
> > +               old_t =3D BPF_MOD_JUMP;
>
> Now I see why you picked _need_jmp().. to alternate with F_JMPED ?
> _uses_jmp() suggestions isn't quite right.

Ah, some kind. The flags BPF_TRAMP_F_CALL_ORIG and
BPF_TRAMP_F_SKIP_FRAME are reset during the trampoline update,
and they are not stored. So the "_need_jmp" means that use "jmp"
for the new trampoline that we are going to update.

The BPF_TRAMP_F_JMPED is used to store if the current trampoline
is in "jmp" mode.

>
> How about bpf_trampoline_must_jmp() ?
> and drop if (!ret) fallback and BPF_TRAMP_F_JMPED bit.
> It doesn't look to be necessary.

I think you are right. We can check if current trampoline is in "jmp"
mode with the "orig_flags" instead, and remove the
BPF_TRAMP_F_JMPED. That means that I need to pass the
"orig_flags" to
modify_fentry -> bpf_trampoline_update_fentry(bpf_text_poke).

Thanks!
Menglong Dong

