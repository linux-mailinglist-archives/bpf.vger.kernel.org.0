Return-Path: <bpf+bounces-58470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42817ABB2CE
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 03:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1BF3B3719
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 01:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C327839F4;
	Mon, 19 May 2025 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBVhEGQP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D64B1E72
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747617671; cv=none; b=NtQevWVd494DONEeAR0ok+MwuHPWSFen3uri124XiGhzuxgYqe3IG1APDemyPWdc0sDXsCTA3ayjmfwXM8L5QFQfL9m5E5bZf76DZIM/e+ydI1SOBmn9SwNUcoSUlP31mJTGowB8uM5Lo0nX8AEvW9OyGJd3MX/TRl723GFcT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747617671; c=relaxed/simple;
	bh=iOCE7jXUjdWXC3q6675tbHXbCDw6h+ZXgy6WyjBYgzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5ax2VLG1KXpPs6sQDbppqrq1GX5RRSTmHoqc8y8h64wgyvlHElSYCJlnwgKfnLakFfson8YGLocm/lHzBNh+cAUocZVYhKN55LghKTbVxw9FC7T1AtZD/9ej8us+4b09hXLoIvZnJ8SDofPqjzub45S9GwR2i1F4N3Hy0U3TcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBVhEGQP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so42365025e9.1
        for <bpf@vger.kernel.org>; Sun, 18 May 2025 18:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747617668; x=1748222468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVN7xQkQwuWaPMsFDmoF/nrkOP3dNOhpGCTceVFz2fk=;
        b=aBVhEGQPVe3ZiOY1BJ9c1GEaViUyCcei87nJpG0xbpsnbRmkeQXL5krwjmYVOvBm+E
         SmUKeFw5SnmnWDwls/xbHF9pWHvOdkukjznxiVYqLZaQD9wBYg2XOHk6HrqbEj2840A1
         h3KZKK/emfCkxTlObLsjZIXLpDO9thVPWExrMAOqChXXgPi/T0Lms/FAROX5rHPlVHoA
         +31F8+ablzu/sUjyF+mK14jH3eMqZIHuleI9GoWy809S7YEgwwsw1SIYHTUKhucg0H69
         jaPSljdLhaeA8fM0NMoxnxgYsW2egG8Axb2WAbBrU59e12YyX8hWLgtoRP+t77TRhkNn
         fTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747617668; x=1748222468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVN7xQkQwuWaPMsFDmoF/nrkOP3dNOhpGCTceVFz2fk=;
        b=txc2FhG07JyauCkhHBFyU+gtmyOW1bR/cIkDRw4fdTbXKDMra1w77EWtR9Ju4V3ZNg
         c5QctYxH5p7xpylJOERomwaLZuzHkDzn57g04ikCCC1HEsOdpI1cWu7inw2EMDc8mtDb
         yt7hFf9DqAKRmpTgXMDY3aoomdTIVNBqV1q/oNlxnIf52b3z8FxUrWXVQWC8bivfkeRE
         4+BHW4StyWELhNIEEFeAtO/GXTaKnVPwvvA7vn8f4AD73MzwOZex2DwaT9jovRTT5mAQ
         2mZtJVDQ+4zY9OFj8sI0Afv09G1jCuw9iTQH4EEUy6Bys+z8qtcD3YbWlerUmwn5ue2x
         FAew==
X-Forwarded-Encrypted: i=1; AJvYcCVeTRe1N2DzW9w/usrZLbmEDo8i1ZoCWTK7pppHe3zWB9rkwupWfg3yfVtUV7JciHbk1hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2z3V+GfCHuaDtYxF6QbJxXoevNfdgfUeCqR2CT2TMhe3m2vA6
	j4K8Mmh+YNgQampohKOU8JNQfYmULOGWLcQG7OrNjVEfL3zfXd70cAKiJadj89OlfRzu1iA3hfC
	vubIHVEC4ny9cpXGBwL3WN1pELEU6w2Y=
X-Gm-Gg: ASbGncvePFmCFEdRjWxhLtGp3YFYVRFKZuH4na+abwqCi+nSNkAgEb+4E0tbO5qtveX
	5VbUfwVwW04ntI6+kPasohtir5KoaXfLhaeo6hsM1Y7uOedeeNOGzBpMcI91pKC/10284rk5k0L
	+IYJPYphH2He3TXuTgPVInCXwq9MG5Q8PKb5QnbfFOzLvIPIloY+23kXwc1kzZyw==
X-Google-Smtp-Source: AGHT+IHXRazdZ6RBSKstQ7DGd5vHbeQZueD4vD2+izVecpGgSjoaR6i+mmnt2IG6L9kfiLWg/HJoCxNWx3VN++qEkfw=
X-Received: by 2002:a05:6000:2a5:b0:3a3:69ff:4b25 with SMTP id
 ffacd0b85a97d-3a369ff4cefmr3738265f8f.28.1747617667637; Sun, 18 May 2025
 18:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com> <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
 <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com>
 <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com> <CAM6KYssQwOnOqQT6TxHuu1_vDmmuw+OtFB=FwPLqbFcv+QdVrg@mail.gmail.com>
In-Reply-To: <CAM6KYssQwOnOqQT6TxHuu1_vDmmuw+OtFB=FwPLqbFcv+QdVrg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 18 May 2025 18:20:56 -0700
X-Gm-Features: AX0GCFvezIkkhPtTiqyb8hWIb1xwP1G4XksULfQ_6xucNk17r5rTxCWnHznjYkU
Message-ID: <CAADnVQLFM9s_Ss7eqyx47tiY8i2b2dt=RMPHMC_s67Ang1rNBw@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Raj Sahu <rjsu26@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 10:01=E2=80=AFPM Raj Sahu <rjsu26@gmail.com> wrote:
>
> > In terms of detection this is a subset of watchdog.
> > In terms of termination we still need to figure out the best
> > path forward.
> > bpf_loop() may or may not be inlined.
> > If it's still a helper call then we can have per-prog "stop_me" flag,
> > but it will penalize run-time, and won't really work for
> > inlined (unless we force inlining logic to consult that flag
> > as well).
> > One option is to patch the callback subprog to return 1,
> > but the callback might not have a branch that returns 1.
> > Another option is to remember the insn that does:
> >         /* loop header,
> >          * if reg_loop_cnt >=3D reg_loop_max skip the loop body
> >          */
> >         insn_buf[cnt++] =3D BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop=
_max, 5);
> >
> > in inlined bpf_loop() and patch that insn with 'goto +5',
> > so inlined bpf_loop will terminate quickly.
> >
> We indeed thought about modifying the subprog to return 1 but realised
> it would be complex. Currently the design does 2 things:
>    1. For Inlining case we set the R0 =3D 1 which is later checked and fo=
rces
>        the for loop to stop.
>
> @@ -22502,7 +22506,14 @@ static struct bpf_prog
> *inline_bpf_loop(struct bpf_verifier_env *env,
>
> + if (termination_states && termination_states->is_termination_prog) {
> +                 /* In a termination BPF prog, we want to exit - set R0 =
=3D 1 */
> +                 insn_buf[cnt++] =3D BPF_MOV64_IMM(BPF_REG_0, 1);
> + } else {
> +                 insn_buf[cnt++] =3D BPF_CALL_REL(0);
> + }
> +

That's exactly the case I was concerned about earlier.
These two insns might generate different JIT images,
so to prepare patches for text_poke_bp_batch()
the verifier needs to coordinate with JIT.
Replacing call with mov is a danger zone.
iirc "mov %eax, 1" is 5 bytes, just like "call foo" is 5 bytes.
But this is pure luck.
We should only replace a call with a call or a jmp or a nop.
See map_poke_track/untrack/run logic.
Maybe we can reuse some of it.

>
>    2. For non-inlining cases we just modified the bpf_loop helper.
> This implies 2 things:
>             2.1 If bpf_loop is yet to be executed, then bingo. We just re=
turn.
>             2.2 If we are currently inside a bpf_loop, we must be
> iteratively calling the callback function
>                   (which btw is also stubbed out of all helpers and bpf_l=
oop).
>                   So the already running bpf_loop won't be doing any
> expensive helper calls or issuing
>                   further loop calls and the long-running BPF
> program's execution time will be brought down
>                   significantly.
>
> > I mean the verifier should prepare the whole batch with all insns
> > that needs to be patched and apply the whole thing at once
> > with one call to text_poke_bp_batch() that will affect all cpus.
> > It doesn't matter where the program was running on this cpu.
> > It might be running somewhere else on a different cpu.
> > text_poke_bp_batch() won't be atomic, but it doesn't have to be.
> > Every cpu might have a different fast-execute path to exit.
>
> While I was going through the definition of text_poke_bp_batch, I am
> worried if, say, a running
> instruction ends up getting modified midway with another instruction,
> making the CPU read
> half of insn1 and half of insn2. That would end up faulting !?

text_poke_bp() takes care of that.
That's what the "_bp" suffix signifies. It's modifying live text
via 'bp' (breakpoint). It has a multistep process to make it safe.

