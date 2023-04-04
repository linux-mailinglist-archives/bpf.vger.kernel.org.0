Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87F06D6FD6
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 00:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjDDWEy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjDDWEv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 18:04:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C8D3C0E
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 15:04:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so136395461edb.4
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680645888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ca1cC/rljsajQmShol/TXskYPCQzZo8VonqeqmFzC8=;
        b=SfCitx+rBqVCT0csmo+lY7ONT4MDrDBb6rjtNxD4kXdEyo1rviWBTFbfJ3gBV+wqy7
         NEmUyx0rpT5V4rK55Wge6afUqdJndFvvru4xlr3vgj2Qyldiy6iJGaZlYJpk5pj9Lf8h
         QmWVFZnSWPYKp/7wP8jcT6H5cctEx/lYFhajhAnGrtR7Es92lW95AsBKyHx1cxvd+uMu
         TGpr6WywcR4Jwg5kE5l4rnC6dzDFYhaibXtINLX+M6ILyqFHSGGdIGW8Fq7kAy9snDKc
         DBw7Ii4oRtgZC4ZfqMm3YniDRuswvwpPjUYW/dGPh4EaB5Or+QsHOkWS+0FPnTiD5x76
         QqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680645888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ca1cC/rljsajQmShol/TXskYPCQzZo8VonqeqmFzC8=;
        b=zq9e2VedDXCSJMnR0ANc8KZetAD3ybrvONT6a0UsFNoo/MmaT/u+6evtnbpAu06MSd
         PtzgzeDdCE0fiOkqIDZGBUsCtMuDC9gwaYBHEHbahZL9cfi13B9bS6x5xtAeJSyDBtVK
         C3PzLV1SoYnrFYONGG7HZjecgCEkO7J7Z1pt6ymWTG4jkB21/e9/S4OYUOj36A8VRmGE
         MoEb2DpQsuuoY334lZPhz9AGDyL6NAy6vJ74HbBjRbHCbu5eOgHqQdh2nwuC0F+wEBD/
         vztbHcbPTytxg9gMfizFUKboSj7i7Yk46VN72QVNBuhZA7LhM2NAwq5nlxMXg3qY4/+o
         AaYQ==
X-Gm-Message-State: AAQBX9ceQ9j5csEE3R3v7vjiQqSZNuc1UAWXtKB5YrSqU0BCxd5inD/a
        bXSZmkozV0wU0tVSP0kjtclRcDcqA41ryagrk1pB+FIz
X-Google-Smtp-Source: AKy350afc/ZNUlwzsT13eVWQ+N0TugSOP8/ph77Gm0QnnBm7V9xz1Jq+dlN3sPgYvKOPpYhZMQqSC1PItoe4VYpWhNA=
X-Received: by 2002:a17:907:2112:b0:8ab:b606:9728 with SMTP id
 qn18-20020a170907211200b008abb6069728mr543545ejb.5.1680645887982; Tue, 04 Apr
 2023 15:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230330055600.86870-1-yhs@fb.com> <20230330055615.89935-1-yhs@fb.com>
 <57694299-9960-0ab7-be61-4f6ba903b72b@meta.com>
In-Reply-To: <57694299-9960-0ab7-be61-4f6ba903b72b@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 Apr 2023 15:04:35 -0700
Message-ID: <CAEf4BzYLchw-SKxStofoq0bZYAHwGxrOXO-YY17UOMXZW41yeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Improve handling of pattern '<const>
 <cond_op> <non_const>' in verifier
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 3:55=E2=80=AFPM Dave Marchevsky <davemarchevsky@met=
a.com> wrote:
>
> On 3/30/23 1:56 AM, Yonghong Song wrote:
> > Currently, the verifier does not handle '<const> <cond_op> <non_const>'=
 well.
> > For example,
> >   ...
> >   10: (79) r1 =3D *(u64 *)(r10 -16)       ; R1_w=3Dscalar() R10=3Dfp0
> >   11: (b7) r2 =3D 0                       ; R2_w=3D0
> >   12: (2d) if r2 > r1 goto pc+2
> >   13: (b7) r0 =3D 0
> >   14: (95) exit
> >   15: (65) if r1 s> 0x1 goto pc+3
> >   16: (0f) r0 +=3D r1
> >   ...
> > At insn 12, verifier decides both true and false branch are possible, b=
ut
> > actually only false branch is possible.
> >
> > Currently, the verifier already supports patterns '<non_const> <cond_op=
> <const>.
> > Add support for patterns '<const> <cond_op> <non_const>' in a similar w=
ay.
> >
> > Also fix selftest 'verifier_bounds_mix_sign_unsign/bounds checks mixing=
 signed and unsigned, variant 10'
> > due to this change.
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  kernel/bpf/verifier.c                                | 12 ++++++++++++
> >  .../bpf/progs/verifier_bounds_mix_sign_unsign.c      |  2 +-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 90bb6d25bc9c..d070943a8ba1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13302,6 +13302,18 @@ static int check_cond_jmp_op(struct bpf_verifi=
er_env *env,
> >                                      src_reg->var_off.value,
> >                                      opcode,
> >                                      is_jmp32);
> > +     } else if (dst_reg->type =3D=3D SCALAR_VALUE &&
> > +                is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off=
))) {
> > +             pred =3D is_branch_taken(src_reg,
> > +                                    tnum_subreg(dst_reg->var_off).valu=
e,
> > +                                    flip_opcode(opcode),
> > +                                    is_jmp32);
> > +     } else if (dst_reg->type =3D=3D SCALAR_VALUE &&
> > +                !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
> > +             pred =3D is_branch_taken(src_reg,
> > +                                    dst_reg->var_off.value,
> > +                                    flip_opcode(opcode),
> > +                                    is_jmp32);
> >       } else if (reg_is_pkt_pointer_any(dst_reg) &&
> >                  reg_is_pkt_pointer_any(src_reg) &&
> >                  !is_jmp32) {
>
> Looking at the two SCALAR_VALUE 'else if's above these added lines, these
> additions make sense. Having four separate 'else if' checks for essential=
ly
> similar logic makes this hard to read, though, maybe it's an opportunity =
to
> refactor a bit.
>
> While trying to make sense of the logic here I attempted to simplify with
> a helper:
>
> @@ -13234,6 +13234,21 @@ static void find_equal_scalars(struct bpf_verifi=
er_state *vstate,
>         }));
>  }
>
> +static int maybe_const_operand_branch(struct tnum maybe_const_op,
> +                                     struct bpf_reg_state *other_op_reg,
> +                                     u8 opcode, bool is_jmp32)
> +{
> +       struct tnum jmp_tnum =3D is_jmp32 ? tnum_subreg(maybe_const_op) :
> +                                         maybe_const_op;
> +       if (!tnum_is_const(jmp_tnum))
> +               return -1;
> +
> +       return is_branch_taken(other_op_reg,
> +                              jmp_tnum.value,
> +                              opcode,
> +                              is_jmp32);
> +}
> +
>  static int check_cond_jmp_op(struct bpf_verifier_env *env,
>                              struct bpf_insn *insn, int *insn_idx)
>  {
> @@ -13287,18 +13302,12 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>
>         if (BPF_SRC(insn->code) =3D=3D BPF_K) {
>                 pred =3D is_branch_taken(dst_reg, insn->imm, opcode, is_j=
mp32);
> -       } else if (src_reg->type =3D=3D SCALAR_VALUE &&
> -                  is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off=
))) {
> -               pred =3D is_branch_taken(dst_reg,
> -                                      tnum_subreg(src_reg->var_off).valu=
e,
> -                                      opcode,
> -                                      is_jmp32);
> -       } else if (src_reg->type =3D=3D SCALAR_VALUE &&
> -                  !is_jmp32 && tnum_is_const(src_reg->var_off)) {
> -               pred =3D is_branch_taken(dst_reg,
> -                                      src_reg->var_off.value,
> -                                      opcode,
> -                                      is_jmp32);
> +       } else if (src_reg->type =3D=3D SCALAR_VALUE) {
> +               pred =3D maybe_const_operand_branch(src_reg->var_off, dst=
_reg,
> +                                                 opcode, is_jmp32);
> +       } else if (dst_reg->type =3D=3D SCALAR_VALUE) {
> +               pred =3D maybe_const_operand_branch(dst_reg->var_off, src=
_reg,
> +                                                 flip_opcode(opcode), is=
_jmp32);
>         } else if (reg_is_pkt_pointer_any(dst_reg) &&
>                    reg_is_pkt_pointer_any(src_reg) &&
>                    !is_jmp32) {
>
>
> I think the resultant logic is the same as your patch, but it's easier to
> understand, for me at least. Note that I didn't test the above.

should we push it half a step further and have

if (src_reg->type =3D=3D SCALAR_VALUE || dst_reg->type =3D=3D SCALAR_VALUE)
  pred =3D is_branch_taken_regs(src_reg, dst_reg, opcode, is_jmp32)

seems even clearer like that. All the tnum subreg, const vs non-const,
and dst/src flip can be handled internally in one nicely isolated
place.
