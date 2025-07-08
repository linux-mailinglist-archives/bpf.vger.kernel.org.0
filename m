Return-Path: <bpf+bounces-62584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADE8AFBF90
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13924A2181
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CC51DD889;
	Tue,  8 Jul 2025 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHFnL/dB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C18633F;
	Tue,  8 Jul 2025 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936257; cv=none; b=SVNYN24vIoDOurkCygaMgoHOs+zrCUYH5IJ4fc4MhAqsUpemyWxkKsLrmmRGjPkxIWue/x3EE4yHTlTTPeJGSe96qfHdJ0aMwTiSm8hgSU548qGL2yTdAIhG+pISKHoWOQS/Vo4ff8t0/zTuWgFegjfIDi1rG+niXY1P+puY18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936257; c=relaxed/simple;
	bh=pEWuuzO75FdHQuUBjLHBDVKQP3TK9GJfR6oXQ/qgI+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmSxFZZ4zdWeY2XIEN6lsYHgBtl8uUgEQjvxZ+kfoKhnpNFeYBxJm2jw0A2j9csUqXIeRhLmi1hbWMVE2kqeM39ul39/U7+aaICDvZdvdUt6niDuEmZ0N9qwE7r22QmXSLrfIrKyI2dfbuIKBkOmPbhprfk0n1wBuyFjutjFYX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHFnL/dB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so3841059b3a.0;
        Mon, 07 Jul 2025 17:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751936255; x=1752541055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wNUCviKwg+4KT+O9PcdqMmr4jCZBknZpXaowI9v0jKI=;
        b=HHFnL/dBn8NkQuos5sjCMWqs/lbrbUfjIB8uF8+vpKp/48xpMG0K9t3xVSeUL70mmD
         LNn/87O66Krr17yknBP+0Bm4ZFb9Z53HeRaH5jtSOk5Z64ECcEdaGfDp1f0N9VQRQsTd
         bGI2MoQDluaHpLeqfJMxTRVhZSVEs5BJqYYvCoqA7jjWrXzJV8vxVEAhVgAP9qkOB8z5
         YTZH7uOrKcSsl6n+wS1IcxiquzJtmeDHWTu2Zww+YlNFOUlKm3o2yzqFgejn7xHtgnvH
         OO4fKIjgonyLzMWSZTLSUMkKMox7eUFF/19LbnlKmRqxTj+a6n+VfQCCRZQPkWocM1KV
         tyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751936255; x=1752541055;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNUCviKwg+4KT+O9PcdqMmr4jCZBknZpXaowI9v0jKI=;
        b=EUneObfZUNacIVF1XDYBInzfm0USxo0X8NLfpZPrMMAJXcLFlCFfAv93iI+6Sv9kcb
         KM4VxLQ3/sDgxLKznHqJR4RNXInIXrmjGpyl74TT4kO+nnHQmgL58YqXkVfDBS9EoTRY
         87YLzosimPhpwrJK3qjODmJxyqoNPW2DMyORJg2BmQLUCpAqFCsCJ9UGm78MDT9G2J7N
         XMYxNPcfYNqRXKYV9zAPlv0hRwjA+jj/aOLENbtUGezqw3kcIkLrcUciP9qdb+6z27lo
         CouhhkfL2xdPBjujr7Wat6YFwDV8eMilxfvPt0Dj7ezQzRDDMeTmLatNwgwlhplAEGEt
         Vl0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8d6K9DJe1obY7IVQqR5EESsRkqwK4n5rTTuU9gZvVbKpXG/oH0TWvCXXsJBL0zTXWe17pgd00@vger.kernel.org, AJvYcCW6PNVQvmFxdaCZJLT8bgUghAZoA0t75fLuBcrvT8s0xlBSZPrPCVXr092G/p8TAY9Kbehdfnr5e0X04jAa@vger.kernel.org, AJvYcCWqS0+JOQNftyldBmjNXtqhwTg0zO2P+s2DrdCcxY7c8cJMk9JuGdc2l3VcgFwArev3Pco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAXaHXHuJhLJSiT2PCXMrAMc1OC1JwPHKRL08f0EcsMwFj0Qk
	JP3vruG2esia6zHICAnjad43mCagiAW0/2ZHnIWex4fdWk2YM2K6GImk
X-Gm-Gg: ASbGncsA/nwrThXU1aTDm+YChCRWEczUVcr+xnszeNaE0NbqivuLo1GepatArZOALli
	P+InF9ZgW/e5hZCmnfsLT8bgMj0OdEEjMNgfoMMswP4EQdseIwycVB3874FEcIkR5cCugd1Jg1L
	7lfPJQ42bCx4MqJldwQeJbzL45vga2N/T2x/uBeGb25qn6t7KPEhGL4eYlLsxf/SFyIGCeowHmh
	a7CCuwUc0Kq0im/hFsdaxqh8dTAUSmcyk9KEL58SwNTlglrETIFKqq2y6EL4W44H3ajcX9Yqyr3
	MBbmw+4LvbLzvsCcdMNZtdujQ3jC0TKgiutC0Tulx3e0TUTMtF6gOgIrRjHh9tdWXQk=
X-Google-Smtp-Source: AGHT+IHXo366oRwc1N3ei11TOtbJeTTLtiBEy4xfBpN/11epTl7eJGrY2mvCVQ9NRC2R0trSH8Z85A==
X-Received: by 2002:a05:6a20:c79a:b0:218:17a2:4421 with SMTP id adf61e73a8af0-22b60db4dc6mr1098705637.10.1751936255061;
        Mon, 07 Jul 2025 17:57:35 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ad])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62c615sm9889836a12.60.2025.07.07.17.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:57:34 -0700 (PDT)
Message-ID: <4ae6fd0d54ff2650d0f6724fb44b33723e26ea49.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, syzbot	
 <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>, Andrii Nakryiko	
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf	
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Hao Luo	
 <haoluo@google.com>, John Fastabend <john.fastabend@gmail.com>, Jiri Olsa	
 <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, LKML	
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Network Development <netdev@vger.kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Song Liu <song@kernel.org>,  syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 07 Jul 2025 17:57:32 -0700
In-Reply-To: <CAADnVQKKdpj-0wXKoKJC4uGhMivdr9FMYvMxZ6jLdPMdva0Vvw@mail.gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
	 <aGa3iOI1IgGuPDYV@Tunnel>
	 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
	 <aGgL_g3wA2w3yRrG@mail.gmail.com>
	 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
	 <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
	 <aGxKcF2Ceany8q7W@mail.gmail.com>
	 <2fb0a354ec117d36a24fe37a3184c1d40849ef1a.camel@gmail.com>
	 <c35d5392b961a4d5b54bdb4b92c4e104bd7857cc.camel@gmail.com>
	 <CAADnVQKKdpj-0wXKoKJC4uGhMivdr9FMYvMxZ6jLdPMdva0Vvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 17:51 -0700, Alexei Starovoitov wrote:
> On Mon, Jul 7, 2025 at 5:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Mon, 2025-07-07 at 16:29 -0700, Eduard Zingerman wrote:
> > > On Tue, 2025-07-08 at 00:30 +0200, Paul Chaignon wrote:
> > >
> > > [...]
> > >
> > > > This is really nice! I think we can extend it to detect some
> > > > always-true branches as well, and thus handle the initial case repo=
rted
> > > > by syzbot.
> > > >
> > > > - if a_min =3D=3D 0: we don't deduce anything
> > > > - bits that may be set in 'a' are: possible_a =3D or_range(a_min, a=
_max)
> > > > - bits that are always set in 'b' are: always_b =3D b_value & ~b_ma=
sk
> > > > - if possible_a & always_b =3D=3D possible_a: only true branch is p=
ossible
> > > > - otherwise, we can't deduce anything
> > > >
> > > > For BPF_X case, we probably want to also check the reverse with
> > > > possible_b & always_a.
> > >
> > > So, this would extend existing predictions:
> > > - [old] always_a & always_b -> infer always true
> > > - [old] !(possible_a & possible_b) -> infer always false
> > > - [new] if possible_a & always_b =3D=3D possible_a -> infer true
> > >         (but make sure 0 is not in possible_a)
> > >
> > > And it so happens, that it covers example at hand.
> > > Note that or_range(1, (u64)-1) =3D=3D (u64)-1, so maybe tnum would be
> > > sufficient, w/o the need for or_range().
> > >
> > > The part of the verifier that narrows the range after prediction:
> > >
> > >   regs_refine_cond_op:
> > >
> > >          case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see rev_opcod=
e() */
> > >                  if (!is_reg_const(reg: reg2, subreg32: is_jmp32))
> > >                          swap(reg1, reg2);
> > >                  if (!is_reg_const(reg: reg2, subreg32: is_jmp32))
> > >                          break;
> > >                  val =3D reg_const_value(reg: reg2, subreg32: is_jmp3=
2);
> > >                ...
> > >                          reg1->var_off =3D tnum_and(a: reg1->var_off,=
 b: tnum_const(value: ~val));
> > >                ...
> > >                  break;
> > >
> > > And after suggested change this part would be executed only if tnum
> > > bounds can be changed by jset. So, this eliminates at-least a
> > > sub-class of a problem.
> >
> > But I think the program below would still be problematic:
> >
> > SEC("socket")
> > __success
> > __retval(0)
> > __naked void jset_bug1(void)
> > {
> >         asm volatile ("                                 \
> >         call %[bpf_get_prandom_u32];                    \
> >         if r0 < 2 goto 1f;                              \
> >         r0 |=3D 1;                                        \
> >         if r0 & -2 goto 1f;                             \
> > 1:      r0 =3D 0;                                         \
> >         exit;                                           \
> > "       :
> >         : __imm(bpf_get_prandom_u32)
> >         : __clobber_all);
> > }
> >
> > The possible_r0 would be changed by `if r0 & -2`, so new rule will not =
hit.
> > And the problem remains unsolved. I think we need to reset min/max
> > bounds in regs_refine_cond_op for JSET:
> > - in some cases range is more precise than tnum
> > - in these cases range cannot be compressed to a tnum
> > - predictions in jset are done for a tnum
> > - to avoid issues when narrowing tnum after prediction, forget the
> >   range.
>
> You're digging too deep. llvm doesn't generate JSET insn,
> so this is syzbot only issue. Let's address it with minimal changes.
> Do not introduce fancy branch taken analysis.
> I would be fine with reverting this particular verifier_bug() hunk.

My point is that the fix should look as below (but extract it as a
utility function):

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53007182b46b..b2fe665901b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16207,6 +16207,14 @@ static void regs_refine_cond_op(struct bpf_reg_sta=
te *reg1, struct bpf_reg_state
                        swap(reg1, reg2);
                if (!is_reg_const(reg2, is_jmp32))
                        break;
+               reg1->u32_max_value =3D U32_MAX;
+               reg1->u32_min_value =3D 0;
+               reg1->s32_max_value =3D S32_MAX;
+               reg1->s32_min_value =3D S32_MIN;
+               reg1->umax_value =3D U64_MAX;
+               reg1->umin_value =3D 0;
+               reg1->smax_value =3D S64_MAX;
+               reg1->smin_value =3D S32_MIN;
                val =3D reg_const_value(reg2, is_jmp32);
                if (is_jmp32) {
                        t =3D tnum_and(tnum_subreg(reg1->var_off), tnum_con=
st(~val));

----

Because of irreconcilable differences in what can be represented as a
tnum and what can be represented as a range.

