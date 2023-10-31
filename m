Return-Path: <bpf+bounces-13723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9B77DD181
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520C7B20F9A
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6320310;
	Tue, 31 Oct 2023 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D88deUM+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4C2030A
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 16:24:10 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542AFA6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 09:24:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507cee17b00so8347630e87.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698769445; x=1699374245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp65UrS5B74DqJkq/LAFSoYWv7YELHUCfDepB8DkX6c=;
        b=D88deUM+/IKSdp0GUH3lH/Zns8mUXMLxS1dVcdNSG0eRFt6AoIiv34vfWtR3Zbo6XH
         UAlwgE/ZmUxX0J2RtRVLbCeeQKw/F049hzEhMUhqqQlZGrAtqDR8TzHH8Y5abMZlv4ZG
         LLpj1/Vpuk9TpugXjK7TV/Xzzoe5PUQlY03GfSUcim0ZtCr6X185loB2/DbpDhp9+tp3
         M2SLqVjD2xN+hW+ps4DVVSl7e9gz7ycrJpTzCf1+2kaPrY0qcpALRIB69wvqsWdZAln6
         nuXvNU7SjIgTRqUleFXZ0Zogchdd7YBRVRB2lGo6SSRc4mHKvRTY3CikD4d1zrN5lry0
         CZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698769445; x=1699374245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp65UrS5B74DqJkq/LAFSoYWv7YELHUCfDepB8DkX6c=;
        b=lJ23Rs/NjapYYndjtIIOPYKLWnPJYHfxVOHDi9sAAIZ7NdsmNRkj0Yw4WU9uEokFCu
         m6EGgUpfBgq7ZEZujGzbcS1iwx5aY0EySyV+T+4OkteybieBk4GtwWh2+MDk+rp3fOe5
         jWaFHlsb8PPr4YXxEmkRUIzHz1OAaQYLKr4Uh9A0Eqm8vU1wdFfXa+WWiAall6xxUubT
         19ee5PNsYnat1hc/3ztetQZmxW9NmCVCkIX86iDLyoX3mCYS6pI7L65TtcibzQo/qIBh
         rsSCOqgIH2BD+psoXjaUvqwQM70tzbiLw5IIBlUPwhf15k/btxM9lXaA+tBiTcNtGlh2
         VDog==
X-Gm-Message-State: AOJu0YyPi4Bdd39OFeTs23NFBeAp1K+wnv2b26GjlBtER3LfrI8OwoGA
	mI1B0bQMws3Ls9raiv1keEPT6hP+6x3HZT+qIFIYO6ERPqY=
X-Google-Smtp-Source: AGHT+IHKtAXZlpSdSxlu77Uww+AFzWJkxqxl5S5xVLZ9r5VgpFR0vWF406AXaCmO7KWIaV9lSk7/SYFxAtcq9A3uBtg=
X-Received: by 2002:ac2:44bc:0:b0:500:b42f:1830 with SMTP id
 c28-20020ac244bc000000b00500b42f1830mr10216512lfm.63.1698769444988; Tue, 31
 Oct 2023 09:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-18-andrii@kernel.org>
 <20231031020248.uo54fkisydzwzgvn@MacBook-Pro-49.local> <CAEf4BzbZT11cYbinnGaqGZPiX2Mq5Taksx=VWOMhpuKEj8cXcA@mail.gmail.com>
In-Reply-To: <CAEf4BzbZT11cYbinnGaqGZPiX2Mq5Taksx=VWOMhpuKEj8cXcA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 09:23:53 -0700
Message-ID: <CAADnVQLADK67wpesGfn=9EoAnXcHV8inBqOt79hjpSdvNS=yiQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 17/23] bpf: generalize reg_set_min_max() to
 handle two sets of two registers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:03=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 30, 2023 at 7:02=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 11:13:40AM -0700, Andrii Nakryiko wrote:
> > >  static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> > > +                         struct bpf_reg_state *true_reg2,
> > >                           struct bpf_reg_state *false_reg1,
> > > -                         u64 val, u32 val32,
> > > +                         struct bpf_reg_state *false_reg2,
> > >                           u8 opcode, bool is_jmp32)
> > >  {
> > > -     struct tnum false_32off =3D tnum_subreg(false_reg1->var_off);
> > > -     struct tnum false_64off =3D false_reg1->var_off;
> > > -     struct tnum true_32off =3D tnum_subreg(true_reg1->var_off);
> > > -     struct tnum true_64off =3D true_reg1->var_off;
> > > -     s64 sval =3D (s64)val;
> > > -     s32 sval32 =3D (s32)val32;
> > > -
> > > -     /* If the dst_reg is a pointer, we can't learn anything about i=
ts
> > > -      * variable offset from the compare (unless src_reg were a poin=
ter into
> > > -      * the same object, but we don't bother with that.
> > > -      * Since false_reg1 and true_reg1 have the same type by constru=
ction, we
> > > -      * only need to check one of them for pointerness.
> > > +     struct tnum false_32off, false_64off;
> > > +     struct tnum true_32off, true_64off;
> > > +     u64 val;
> > > +     u32 val32;
> > > +     s64 sval;
> > > +     s32 sval32;
> > > +
> > > +     /* If either register is a pointer, we can't learn anything abo=
ut its
> > > +      * variable offset from the compare (unless they were a pointer=
 into
> > > +      * the same object, but we don't bother with that).
> > >        */
> > > -     if (__is_pointer_value(false, false_reg1))
> >
> > The removal of the above check, but not the comment was surprising and =
concerning,
> > so I did a bit of git-archaeology.
> > It was added in commit f1174f77b50c ("bpf/verifier: rework value tracki=
ng")
> > back in 2017 !
> > and in that commit reg_set_min_max() was always called with reg =3D=3D =
scalar.
> > It looked like premature check. Then I spotted a comment in that commit=
:
> >   * this is only legit if both are scalars (or pointers to the same
> >   * object, I suppose, but we don't support that right now), because
> >   * otherwise the different base pointers mean the offsets aren't
> >   * comparable.
> > so the intent back then was to generalize reg_set_min_max() to be used =
with pointers too,
> > but we never got around to do that and the comment now reads:
>
> Yeah, it shouldn't be too hard to "generalize" to pointer vs pointer,
> if we ensure they point to exactly the same thing (I haven't thought
> much about how), because beyond that it's still basically SCALAR
> offsets. But I figured it's out of scope for these changes :)
>
> >   * this is only legit if both are scalars (or pointers to the same
> >   * object, I suppose, see the PTR_MAYBE_NULL related if block below),
> >   * because otherwise the different base pointers mean the offsets aren=
't
> >   * comparable.
> >
> > So please remove is_pointer check and remove the comment,
>
> So I'm a bit confused. I did remove __is_pointer_value() check, but I
> still need to guard against having pointers, which is why I have:
>
> if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_VA=
LUE).
>     return;
>
> I think I need this check, because reg_set_min_max() can be called
> from check_cond_jmp_op() with pointer regs, and we shouldn't try to
> adjust them. Or am I missing something? And the comment I have here
> now:

I don't see a code path where reg_set_min_max() is called
with pointers. At least not in the current code base.
Are you saying somewhere in your later patch it happens?

Then the question is whether to do this is_scalar check inside
reg_set_min_max() or outside. Both options are probably fine.

>
> +       /* If either register is a pointer, we can't learn anything about=
 its
> +        * variable offset from the compare (unless they were a pointer i=
nto
> +        * the same object, but we don't bother with that).
>          */
>
> is trying to explain that we don't really adjust two pointers.
>
> > and fixup the comment in check_cond_jmp_op() where reg_set_min_max().
>
> I have this locally for now, please let me know if this is fine or you
> had something else in mind:
>
> -/* Adjusts the register min/max values in the case that the dst_reg is t=
he
> - * variable register that we are working on, and src_reg is a constant o=
r we're
> - * simply doing a BPF_K check.
> - * In JEQ/JNE cases we also adjust the var_off values.
> +/* Adjusts the register min/max values in the case that the dst_reg and
> + * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF=
_K
> + * check, in which case we havea fake SCALAR_VALUE representing insn->im=
m).
> + * Technically we can do similar adjustments for pointers to the same ob=
ject,
> + * but we don't support that right now.

Looks fine. I'm trying to say that we had such comment forever and
it never lead to actually doing the work.
So I'd just remove the last sentence about pointers ...

>   */
>  static void reg_set_min_max(struct bpf_reg_state *true_reg1,
>                             struct bpf_reg_state *true_reg2,
> @@ -14884,13 +14885,6 @@ static int check_cond_jmp_op(struct
> bpf_verifier_env *env,
>                 return -EFAULT;
>         other_branch_regs =3D other_branch->frame[other_branch->curframe]=
->regs;
>
> -       /* detect if we are comparing against a constant value so we can =
adjust
> -        * our min/max values for our dst register.
> -        * this is only legit if both are scalars (or pointers to the sam=
e
> -        * object, I suppose, see the PTR_MAYBE_NULL related if block bel=
ow),
> -        * because otherwise the different base pointers mean the offsets=
 aren't
> -        * comparable.
> -        */

... and removing this comment is good thing too.
In general the comments should be in front of the function body
(as you're doing) instead of the callsite.

