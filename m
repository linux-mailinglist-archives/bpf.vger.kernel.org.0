Return-Path: <bpf+bounces-62582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81FAAFBF79
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391621680EE
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760C1D54E2;
	Tue,  8 Jul 2025 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/rpl/AE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26024B29;
	Tue,  8 Jul 2025 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935905; cv=none; b=Y6AcU6NHWauYWznVgRjxkB/d23jawQPa4vlLzEdxkQ4h1fCkQd8+4ENvQ6RMEFAYnkCC6wB7Nw2Kzsfkuai2qG1rYSUnIhrmWYmzwMMMMow9CzLKUkAjn4JKvehVIO1zROMFAnpJxFTf+vSlUn4KX1f/MkKkANDfSWEddNu83CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935905; c=relaxed/simple;
	bh=0v9+HqmvzO5X80WLJ3QZXv3qK+/DY0qjXlZskP9CtAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abz5VaOYyPJ8bOT02Jz5TLcxRM1U+89o2fY1e1m4LMSJeRnHe6nXRCLf9x+ftg2Zzvxqj1wlWSSKwVrgdkRjGOfF/+3na5BmJMJE01iwmIzex6GuAwQI3neGlx0Cz4n/IuHNIxcs/qerLS6SPudw0iUj37PyLkJx5ktHtl+pO/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/rpl/AE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-454ac069223so23573505e9.1;
        Mon, 07 Jul 2025 17:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935902; x=1752540702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFOaR/XZ1GjXLQF/aq3r7vt+ZGQQXA2uOV+qGT1+emI=;
        b=J/rpl/AEXdFnVXNQUCcevxGNpN5C6uhK3Jj481XLcsWb86g7Gf5wf9bxpdOQ1pNsfW
         BpqKbjo5BYkwg/Ab4GSJ7tUKFS+wiWO5gBBVgWwZQdvVNkXH3OV+9vqTN0RDyB9RNPiW
         qCSM85+srvMLGW/BRB4Jk5c1ZN8wzYULRj7+LmCrQQH8Pb7lqPtKKxMcXDT0CVbxTGeI
         qHvEWWAiA2Yrdecz42wd+Q5wg7ibyGcc/tZGWkFaH2t2dhcEAF8vacbZTkYzNBazMTeD
         d8U2GgrkTyTooj9vqydpgBzMK186ezLpe/T2hxSNjFLzde6CpSL5xyvRarIutgMHuF39
         YxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935902; x=1752540702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFOaR/XZ1GjXLQF/aq3r7vt+ZGQQXA2uOV+qGT1+emI=;
        b=FpNrGG82Ddb0d832vKQyMpNRXOIxXdRtQBa4lRC42/GtV9m99ooQ9G5JkawNzgGrXk
         3RpCsgR9pY+YSCEMGzBeyY5EDSaeuTqzLy1RR5TQsSUPPfuhD9G94tR7rOU6lH/euayK
         xE5EJz9RyBgXjD4fF7IfR+uFzAmLu40CnZ4x4baCfhmXDMG0gJyhnmfMOThUMwAqtkng
         voK5tW4FsMR4ivQD3qdaG9XDXzS8VRfMZoo9AasbJlOmma4wucwx7upBpLpUl78UCY+R
         EVWFVlG9J9Rqj6hdCTD3z++6XtuZdO/zyAgdOJfjUXvcwhfaJLLOPQXLE66GXPLOdJKY
         4qnA==
X-Forwarded-Encrypted: i=1; AJvYcCVTWsKZkpXaVB4APPnoFJXmpnyomP82EI0l0znCYRXezdZatJcf8pSHp2nsS0jX6gUd1b4=@vger.kernel.org, AJvYcCVWlCtSjM1dcZb/n1ijZyz/t0qa/fDlVsATGbihjWfoZpYokJ49H4YSfocwmcltq5T5Or1JPQWAXoOMCD6d@vger.kernel.org, AJvYcCWfDTHwY+fNi9xuaqtMiNPlcZxC2X27pMFggHonRVZhHQk3AEqzX3d20fZpSgjbGvpEvJl8mnYV@vger.kernel.org
X-Gm-Message-State: AOJu0YwASR/37ngYBHbjDzwsvtmEQ515Wklu7hwXmZsiwD64Vc+yRvzu
	JMWY5cBeRkEaYNeUbX5PJmQakULdUAYMw06tLJ0JM4yZPKyPa0BR89rdC4mwauFb9McDm3ihvLk
	ngmWjztAex7Z28JDHVzwB7wlS4vl1qLI=
X-Gm-Gg: ASbGncvpiqjvmb184/GDNJiiHyAb+WNbS7xOLF0NjLSqIt0EuofUwnLHSt1GsDBAW0N
	1+6wYkPERweORzQ57Q4Fqiqf2jJA+GDXbWlMka+4uczsok0cx2Meufgre6Z2HayWukBTVub67F5
	qTdE9VvYzggXnMTfrarnF08p+QEDoR4lOY/4+jBgKSYPlOFOhGYRf7NLY5APpYulHCjFHIkHrI
X-Google-Smtp-Source: AGHT+IEs/4tIpYH6xc6KHipk+1aGDD9eA9CMZjRsKBr0d4sPlNCrVvmnmIUak+3WWOlE13+llIfdEkFkkplNrNnbP38=
X-Received: by 2002:a05:6000:26cc:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3b5de11fc9amr437512f8f.19.1751935902219; Mon, 07 Jul 2025
 17:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com> <aGa3iOI1IgGuPDYV@Tunnel>
 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
 <aGgL_g3wA2w3yRrG@mail.gmail.com> <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
 <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
 <aGxKcF2Ceany8q7W@mail.gmail.com> <2fb0a354ec117d36a24fe37a3184c1d40849ef1a.camel@gmail.com>
 <c35d5392b961a4d5b54bdb4b92c4e104bd7857cc.camel@gmail.com>
In-Reply-To: <c35d5392b961a4d5b54bdb4b92c4e104bd7857cc.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 17:51:31 -0700
X-Gm-Features: Ac12FXy8iRPc0-Gj5GQJyhfjDiBfRhCIqUNNXkxzr9haQouy1gGukXGzveYNYRY
Message-ID: <CAADnVQKKdpj-0wXKoKJC4uGhMivdr9FMYvMxZ6jLdPMdva0Vvw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, 
	syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 5:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2025-07-07 at 16:29 -0700, Eduard Zingerman wrote:
> > On Tue, 2025-07-08 at 00:30 +0200, Paul Chaignon wrote:
> >
> > [...]
> >
> > > This is really nice! I think we can extend it to detect some
> > > always-true branches as well, and thus handle the initial case report=
ed
> > > by syzbot.
> > >
> > > - if a_min =3D=3D 0: we don't deduce anything
> > > - bits that may be set in 'a' are: possible_a =3D or_range(a_min, a_m=
ax)
> > > - bits that are always set in 'b' are: always_b =3D b_value & ~b_mask
> > > - if possible_a & always_b =3D=3D possible_a: only true branch is pos=
sible
> > > - otherwise, we can't deduce anything
> > >
> > > For BPF_X case, we probably want to also check the reverse with
> > > possible_b & always_a.
> >
> > So, this would extend existing predictions:
> > - [old] always_a & always_b -> infer always true
> > - [old] !(possible_a & possible_b) -> infer always false
> > - [new] if possible_a & always_b =3D=3D possible_a -> infer true
> >         (but make sure 0 is not in possible_a)
> >
> > And it so happens, that it covers example at hand.
> > Note that or_range(1, (u64)-1) =3D=3D (u64)-1, so maybe tnum would be
> > sufficient, w/o the need for or_range().
> >
> > The part of the verifier that narrows the range after prediction:
> >
> >   regs_refine_cond_op:
> >
> >          case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see rev_opcode(=
) */
> >                  if (!is_reg_const(reg: reg2, subreg32: is_jmp32))
> >                          swap(reg1, reg2);
> >                  if (!is_reg_const(reg: reg2, subreg32: is_jmp32))
> >                          break;
> >                  val =3D reg_const_value(reg: reg2, subreg32: is_jmp32)=
;
> >                ...
> >                          reg1->var_off =3D tnum_and(a: reg1->var_off, b=
: tnum_const(value: ~val));
> >                ...
> >                  break;
> >
> > And after suggested change this part would be executed only if tnum
> > bounds can be changed by jset. So, this eliminates at-least a
> > sub-class of a problem.
>
> But I think the program below would still be problematic:
>
> SEC("socket")
> __success
> __retval(0)
> __naked void jset_bug1(void)
> {
>         asm volatile ("                                 \
>         call %[bpf_get_prandom_u32];                    \
>         if r0 < 2 goto 1f;                              \
>         r0 |=3D 1;                                        \
>         if r0 & -2 goto 1f;                             \
> 1:      r0 =3D 0;                                         \
>         exit;                                           \
> "       :
>         : __imm(bpf_get_prandom_u32)
>         : __clobber_all);
> }
>
> The possible_r0 would be changed by `if r0 & -2`, so new rule will not hi=
t.
> And the problem remains unsolved. I think we need to reset min/max
> bounds in regs_refine_cond_op for JSET:
> - in some cases range is more precise than tnum
> - in these cases range cannot be compressed to a tnum
> - predictions in jset are done for a tnum
> - to avoid issues when narrowing tnum after prediction, forget the
>   range.

You're digging too deep. llvm doesn't generate JSET insn,
so this is syzbot only issue. Let's address it with minimal changes.
Do not introduce fancy branch taken analysis.
I would be fine with reverting this particular verifier_bug() hunk.

