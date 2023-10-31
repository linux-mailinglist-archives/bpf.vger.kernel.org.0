Return-Path: <bpf+bounces-13686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902DE7DC66C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EFD28160B
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263A31097E;
	Tue, 31 Oct 2023 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbQfRBzq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D539107AF
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:18:53 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BDF126
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:12:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32f87b1c725so1443531f8f.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732737; x=1699337537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ+NgD/53kymwXjtLyFwA23cddBFxJ32rTfDf4UtgzU=;
        b=HbQfRBzq6bM328QdXcjK+GfhbIyR0HyQIFJOp606HuoQBpQaGps+yq0PPBsqLnzydk
         +QvpXdx68PwQ0p3IpxX98koQLq1gaXjvaSyL2IpKqGrblSsT/axc26llnFNc5XGxyL4r
         ki9vcA8zKxpUUJreI8WOBM7wCmTmbm+qJTI8wXOVrkeX7ug6JbpEodfEjx8bdGFouCxc
         QbGk30KpE6lxLYg+WbmCfC79Xo7RT9VxYB6YPfW+AaIWC4kKlB5TuRlv17STD8bxdnXx
         beebHKM6ASX9z/obdNA275+LojSoEgxbv7k9SY1sSds6vhpbTC16yZQ29jZWfyYU8pSq
         sqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732737; x=1699337537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ+NgD/53kymwXjtLyFwA23cddBFxJ32rTfDf4UtgzU=;
        b=pOHTu28Y+LBj8nXALhtCmGrqAZVYGGchlOX/fSSs44LfjoR+eYJvdvii84sg3DyhWT
         GqD6VOY1oePEBepNO6LwuyY1IZ78+di3+Mb7n2FBQY/uX18iW4sBhM7O01r2n5kD7BZV
         4O7PKDJUlw+UusztHXOWLxWfGur/ZVxu7/aLQ6MFFXtOkyAaNHnpllDMIGN16pD+EOeP
         qkiO4+HHG+7Yn7b/+JAnPq5k+rhVY0s6/+UhzSSnY2R7vIlmFg98rRnFJBoj292HJc5W
         VGdSWRkbivba4KvXXhxl5xAikqjHlWL/i27nikerVXdjre8zPfi4iLeOaJ5DNtORpgTt
         SYWQ==
X-Gm-Message-State: AOJu0YxIhaM4sjZzQbGJTI6yvivnX1uO/rs0O9t0lpPnShBfPnUqLqFN
	VN0UDEGr4WO2cHDkcqQI+xM8InMQTeN8t49uqHQ37Y5ii00=
X-Google-Smtp-Source: AGHT+IHEPYUWPIhD8f4c4sEo7bKKKRRz4jXRiuYDC+OiJTn+uqNqGDvpKp+7yQ75csDOOazNYl3OkRJnQ28g+3t+Nww=
X-Received: by 2002:a17:906:6a24:b0:9c5:ea33:7bf9 with SMTP id
 qw36-20020a1709066a2400b009c5ea337bf9mr9627173ejc.51.1698732197643; Mon, 30
 Oct 2023 23:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-18-andrii@kernel.org>
 <20231031020248.uo54fkisydzwzgvn@MacBook-Pro-49.local>
In-Reply-To: <20231031020248.uo54fkisydzwzgvn@MacBook-Pro-49.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 23:03:05 -0700
Message-ID: <CAEf4BzbZT11cYbinnGaqGZPiX2Mq5Taksx=VWOMhpuKEj8cXcA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 17/23] bpf: generalize reg_set_min_max() to
 handle two sets of two registers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 7:02=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 27, 2023 at 11:13:40AM -0700, Andrii Nakryiko wrote:
> >  static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> > +                         struct bpf_reg_state *true_reg2,
> >                           struct bpf_reg_state *false_reg1,
> > -                         u64 val, u32 val32,
> > +                         struct bpf_reg_state *false_reg2,
> >                           u8 opcode, bool is_jmp32)
> >  {
> > -     struct tnum false_32off =3D tnum_subreg(false_reg1->var_off);
> > -     struct tnum false_64off =3D false_reg1->var_off;
> > -     struct tnum true_32off =3D tnum_subreg(true_reg1->var_off);
> > -     struct tnum true_64off =3D true_reg1->var_off;
> > -     s64 sval =3D (s64)val;
> > -     s32 sval32 =3D (s32)val32;
> > -
> > -     /* If the dst_reg is a pointer, we can't learn anything about its
> > -      * variable offset from the compare (unless src_reg were a pointe=
r into
> > -      * the same object, but we don't bother with that.
> > -      * Since false_reg1 and true_reg1 have the same type by construct=
ion, we
> > -      * only need to check one of them for pointerness.
> > +     struct tnum false_32off, false_64off;
> > +     struct tnum true_32off, true_64off;
> > +     u64 val;
> > +     u32 val32;
> > +     s64 sval;
> > +     s32 sval32;
> > +
> > +     /* If either register is a pointer, we can't learn anything about=
 its
> > +      * variable offset from the compare (unless they were a pointer i=
nto
> > +      * the same object, but we don't bother with that).
> >        */
> > -     if (__is_pointer_value(false, false_reg1))
>
> The removal of the above check, but not the comment was surprising and co=
ncerning,
> so I did a bit of git-archaeology.
> It was added in commit f1174f77b50c ("bpf/verifier: rework value tracking=
")
> back in 2017 !
> and in that commit reg_set_min_max() was always called with reg =3D=3D sc=
alar.
> It looked like premature check. Then I spotted a comment in that commit:
>   * this is only legit if both are scalars (or pointers to the same
>   * object, I suppose, but we don't support that right now), because
>   * otherwise the different base pointers mean the offsets aren't
>   * comparable.
> so the intent back then was to generalize reg_set_min_max() to be used wi=
th pointers too,
> but we never got around to do that and the comment now reads:

Yeah, it shouldn't be too hard to "generalize" to pointer vs pointer,
if we ensure they point to exactly the same thing (I haven't thought
much about how), because beyond that it's still basically SCALAR
offsets. But I figured it's out of scope for these changes :)

>   * this is only legit if both are scalars (or pointers to the same
>   * object, I suppose, see the PTR_MAYBE_NULL related if block below),
>   * because otherwise the different base pointers mean the offsets aren't
>   * comparable.
>
> So please remove is_pointer check and remove the comment,

So I'm a bit confused. I did remove __is_pointer_value() check, but I
still need to guard against having pointers, which is why I have:

if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_VALU=
E).
    return;

I think I need this check, because reg_set_min_max() can be called
from check_cond_jmp_op() with pointer regs, and we shouldn't try to
adjust them. Or am I missing something? And the comment I have here
now:

+       /* If either register is a pointer, we can't learn anything about i=
ts
+        * variable offset from the compare (unless they were a pointer int=
o
+        * the same object, but we don't bother with that).
         */

is trying to explain that we don't really adjust two pointers.

> and fixup the comment in check_cond_jmp_op() where reg_set_min_max().

I have this locally for now, please let me know if this is fine or you
had something else in mind:

-/* Adjusts the register min/max values in the case that the dst_reg is the
- * variable register that we are working on, and src_reg is a constant or =
we're
- * simply doing a BPF_K check.
- * In JEQ/JNE cases we also adjust the var_off values.
+/* Adjusts the register min/max values in the case that the dst_reg and
+ * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
+ * check, in which case we havea fake SCALAR_VALUE representing insn->imm)=
.
+ * Technically we can do similar adjustments for pointers to the same obje=
ct,
+ * but we don't support that right now.
  */
 static void reg_set_min_max(struct bpf_reg_state *true_reg1,
                            struct bpf_reg_state *true_reg2,
@@ -14884,13 +14885,6 @@ static int check_cond_jmp_op(struct
bpf_verifier_env *env,
                return -EFAULT;
        other_branch_regs =3D other_branch->frame[other_branch->curframe]->=
regs;

-       /* detect if we are comparing against a constant value so we can ad=
just
-        * our min/max values for our dst register.
-        * this is only legit if both are scalars (or pointers to the same
-        * object, I suppose, see the PTR_MAYBE_NULL related if block below=
),
-        * because otherwise the different base pointers mean the offsets a=
ren't
-        * comparable.
-        */
        if (BPF_SRC(insn->code) =3D=3D BPF_X) {
                reg_set_min_max(&other_branch_regs[insn->dst_reg],
                                &other_branch_regs[insn->src_reg],

