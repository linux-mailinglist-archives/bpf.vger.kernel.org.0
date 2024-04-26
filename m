Return-Path: <bpf+bounces-27937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F58B3C78
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398202823A3
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF6E14EC5C;
	Fri, 26 Apr 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaoVYbDG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509C1DDD6
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147926; cv=none; b=dOiVlnNn1eoe0MaTo9HSYL4dnhw1RmL2jQd0rsBoJccgjjLrpIcf/drDbudSHpeKfvjh1gvrZv/Y9U7CniNNfnxA56mZAa39YRDWYp4Fl/GgKV9GlD0T/nDetAUmYCbxYk2U7im9DJgcHFVcAd63dt+pNkEXhznxp/znXtJMCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147926; c=relaxed/simple;
	bh=5Gh39NfwYqwAAhBB9s8bqxMJop/xa+U0T9V1g5gcm+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9CP+gTTOdjhLxZ856mVWHhuHURGemyH/E89z9y4yGMAH2441RWukhFZretdfQG28agYgRbrrF6lvDcZfQyWKoiz88203be6XBROF2dsmJiqFH/lHYgj81bnNUshFDT+gzgk1mNbyULN1q0qY5OHC0VhHu1PGGSrwUlkRMwR9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaoVYbDG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso2242200b3a.1
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714147924; x=1714752724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoILQSVXehITz/Mgv4zNItjqU7klAbC5u4uWau3oCjk=;
        b=gaoVYbDGfwWNAiLIwPM3abSpnlQXhKMjWCdCzBWAbOA0Zkdy0eWODRSb86QU6EeE+e
         8fAy2uYU81sT4mVPUyOoKnOA6vj/iqIhXdcnpq/1OJMxFk3VoSHQ4DR7d3Aw6XDOCPi3
         Acl3iCdUx7ySMtbVQ8KMoRintpVegrP6DNiHbhy9CFwtHgbr3Hs5j9Gwcj/su7tMKUsY
         PiJ8s9wtyfVqVO3Eqc9vvpqpVzpidZOs5lNhh57kHdHxbuMKIA8Rwkmma0EPGsC72W7V
         xbqeMIusaDRpTTspKjLOtlC+eHqLsata/LWLIQ5suorh/ElZmqcEg8rFDo/4w+HAEwBw
         3gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147924; x=1714752724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoILQSVXehITz/Mgv4zNItjqU7klAbC5u4uWau3oCjk=;
        b=Oc/CHp1ggqNw3RTGR18kDXbF8YnKtLZgd6i+ov6hl1R6Q8hzvghpIG6AENbXEEwDK3
         d9VzDFS9Jms56e14ZuKKuNsk3X/qq51eWOhGbzUveKKB+OrcR1c4kfg1NH7epcq+yNTT
         5824C6OsPVUhKGu0YALB1ST4/MMHQnnV80ZrADCJS4s8kC3o639IM7N71kSXwFQg3JtV
         ImwO1Q1Cvd/v0itm9p7pGbMBnjafp6G1lPkCN6+ExH31+T1JZblRXErxiMAsFGczFcut
         8QN3csVTXtEOVI5sJeSzAi09ZtUosGYv289gKbsehoKHfjlvQpwcgHD2WgU0rL3V/qtG
         N6pA==
X-Gm-Message-State: AOJu0Yyt1BFNbS8NNjlV8fIxUM9JWtAhc5nZ17V8cnAVEktsneOPfCeS
	fe48vM1hWbj9vekieHnQpCumTAJdvvMLPu3LMsM2v6XF4/LRlppZvN4aoB6JMgIbUDJ8aSzA1Kg
	nJocbjyK95aPk/oHMzCTJgAYyAEs=
X-Google-Smtp-Source: AGHT+IHB2pQ0H8bl/ngqAE7HBt2+4GrpjdTUH5RiHQkxejLW0pEFgIeEHohAciib/Wr5nds8iAyxU2pOZbslRPzjkTk=
X-Received: by 2002:a05:6a21:4995:b0:1a7:64dd:ebe8 with SMTP id
 ax21-20020a056a21499500b001a764ddebe8mr3496750pzc.49.1714147924596; Fri, 26
 Apr 2024 09:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
 <20240424224053.471771-3-cupertino.miranda@oracle.com> <CAEf4BzYuHv7QnSAFVX0JH2YQd8xAR5ZKzWxEY=8yongH9kepng@mail.gmail.com>
 <87edasmnlr.fsf@oracle.com>
In-Reply-To: <87edasmnlr.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 09:11:52 -0700
Message-ID: <CAEf4BzazPWOgXFco=PJnGEAaJgjr2MG12=3Sr3=9gMckwTSDLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf/verifier: refactor checks for range computation
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 3:20=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
>
> Andrii Nakryiko writes:
>
> > On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
> > <cupertino.miranda@oracle.com> wrote:
> >>
> >> Split range computation checks in its own function, isolating pessimit=
ic
> >> range set for dst_reg and failing return to a single point.
> >>
> >> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> >> Cc: Yonghong Song <yonghong.song@linux.dev>
> >> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >> Cc: David Faust <david.faust@oracle.com>
> >> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> >> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> >> ---
> >>  kernel/bpf/verifier.c | 141 +++++++++++++++++++++++------------------=
-
> >>  1 file changed, 77 insertions(+), 64 deletions(-)
> >>
> >
> > I know you are moving around pre-existing code, so a bunch of nits
> > below are to pre-existing code, but let's use this as an opportunity
> > to clean it up a bit.
> >
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 6fe641c8ae33..829a12d263a5 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -13695,6 +13695,82 @@ static void scalar_min_max_arsh(struct bpf_re=
g_state *dst_reg,
> >>         __update_reg_bounds(dst_reg);
> >>  }
> >>
> >> +static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu=
32,
> >
> > hm.. why passing reg_state by value? Use pointer?
> >
> Someone mentioned this in a review already and I forgot to change it.
> Apologies if I did not reply on this.
>
> The reason why I pass by value, is more of an approach to programming.
> I do it as guarantee to the caller that there is no mutation of
> the value.
> If it is better or worst from a performance point of view it is
> arguable, since although it might appear to copy the value it also provid=
es
> more information to the compiler of the intent of the callee function,
> allowing it to optimize further.
> I personally would leave the copy by value, but I understand if you want
> to keep having the same code style.

It's a pretty big 120-byte structure, so maybe the compiler can
optimize it very well, but I'd still be concerned. Hopefully it can
optimize well even with (const) pointer, if inlining.

But I do insist, if you look at (most? I haven't checked every single
function, of course) other uses in verifier.c, we pass things like
that by pointer. I understand the desire to specify the intent to not
modify it, but that's why you are passing `const struct bpf_reg_state
*reg`, so I think you don't lose anything with that.

>
>
> >> +                                  bool *valid)
> >> +{
> >> +       s64 smin_val =3D reg.smin_value;
> >> +       s64 smax_val =3D reg.smax_value;
> >> +       u64 umin_val =3D reg.umin_value;
> >> +       u64 umax_val =3D reg.umax_value;
> >> +
> >
> > don't add empty line between variable declarations, all variables
> > should be in a single continuous block
> >
> >> +       s32 s32_min_val =3D reg.s32_min_value;
> >> +       s32 s32_max_val =3D reg.s32_max_value;
> >> +       u32 u32_min_val =3D reg.u32_min_value;
> >> +       u32 u32_max_val =3D reg.u32_max_value;
> >> +
> >
> > but see below, I'm not sure we even need these local variables, they
> > don't save all that much typing
> >
> >> +       bool known =3D alu32 ? tnum_subreg_is_const(reg.var_off) :
> >> +                            tnum_is_const(reg.var_off);
> >
> > "known" is a misnomer, imo. It's `is_const`.
> >
> >> +
> >> +       if (alu32) {
> >> +               if ((known &&
> >> +                    (s32_min_val !=3D s32_max_val || u32_min_val !=3D=
 u32_max_val)) ||
> >> +                     s32_min_val > s32_max_val || u32_min_val > u32_m=
ax_val)
> >> +                       *valid =3D false;
> >> +       } else {
> >> +               if ((known &&
> >> +                    (smin_val !=3D smax_val || umin_val !=3D umax_val=
)) ||
> >> +                   smin_val > smax_val || umin_val > umax_val)
> >> +                       *valid =3D false;
> >> +       }
> >> +
> >> +       return known;
> >
> >
> > The above is really hard to follow, especially how known && !known
> > cases are being handled is very easy to misinterpret. How about we
> > rewrite the equivalent logic in a few steps:
> >
> > if (alu32) {
> >     if (tnum_subreg_is_const(reg.var_off)) {
> >         return reg->s32_min_value =3D=3D reg->s32_max_value &&
> >                reg->u32_min_value =3D=3D reg->u32_max_value;
> >     } else {
> >         return reg->s32_min_value <=3D reg->s32_max_value &&
> >                reg->u32_min_value <=3D reg->u32_max_value;
> >     }
> > } else {
> >    /* same as above for 64-bit bounds */
> > }
> >
> > And you don't even need any local variables, while all the important
> > conditions are a bit more easy to follow? Or is it just me?
> >
>
> With current state of the code, indeed, it seems you don't need the extra
> valid argument to pass the extra information.
> Considering that the KNOWN value is now only used in the shift
> operators, it seems now safe to merge both valid and the return value
> from the function, since the logic will result in the same behaviour.
>

cool, let's do it then

> >> +}
> >> +
> >> +static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
> >> +                                            struct bpf_reg_state src_=
reg)
> >> +{
> >> +       bool src_known;
> >> +       u64 insn_bitness =3D (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) =
? 64 : 32;
> >
> > whole u64 for this seems like an overkill, I'd just stick to `int`
> >
> >> +       bool alu32 =3D (BPF_CLASS(insn->code) !=3D BPF_ALU64);
> >
> > insn_bitness =3D=3D 32 ?
> >
> >> +       u8 opcode =3D BPF_OP(insn->code);
> >> +
> >
> > nit: don't split variables block with empty line
> >
> >> +       bool valid_known =3D true;
> >
> > need an empty line between variable declarations and the rest
> >
> >> +       src_known =3D is_const_reg_and_valid(src_reg, alu32, &valid_kn=
own);
> >> +
> >> +       /* Taint dst register if offset had invalid bounds
> >> +        * derived from e.g. dead branches.
> >> +        */
> >> +       if (valid_known =3D=3D false)
> >
> > nit: !valid_known
> >
> >> +               return false;
> >
> > given this logic/handling, why not just return false from
> > is_const_reg_and_valid() if it's a constant, but it's not
> > valid/consistent? It's simpler and fits the logic and function's name,
> > no? See my suggestion above
> >
> >> +
> >> +       switch (opcode) {
> >
> > inline opcode variable here, you use it just once
> >
> >> +       case BPF_ADD:
> >> +       case BPF_SUB:
> >> +       case BPF_AND:
> >> +               return true;
> >> +
> >> +       /* Compute range for the following only if the src_reg is know=
n.
> >> +        */
> >> +       case BPF_XOR:
> >> +       case BPF_OR:
> >> +       case BPF_MUL:
> >> +               return src_known;
> >> +
> >> +       /* Shift operators range is only computable if shift dimension=
 operand
> >> +        * is known. Also, shifts greater than 31 or 63 are undefined.=
 This
> >> +        * includes shifts by a negative number.
> >> +        */
> >> +       case BPF_LSH:
> >> +       case BPF_RSH:
> >> +       case BPF_ARSH:
> >
> > preserve original comment?
> >
> >> -                       /* Shifts greater than 31 or 63 are undefined.
> >> -                        * This includes shifts by a negative number.
> >> -                        */
> >
> >> +               return (src_known && src_reg.umax_value < insn_bitness=
);
> >
> > nit: unnecessary ()
> >
> >> +       default:
> >> +               break;
> >
> > return false here, and drop return below
> >
> >> +       }
> >> +
> >> +       return false;
> >> +}
> >> +
> >>  /* WARNING: This function does calculations on 64-bit values, but the=
 actual
> >>   * execution may occur on 32-bit values. Therefore, things like bitsh=
ifts
> >>   * need extra checks in the 32-bit case.
> >
> > [...]
>
> Apart from the obvious coding style problems I will address those optimiz=
ations
> in an independent patch in the end, if you agree with. I would prefer to
> separate the improvements to avoid to change semantics in the
> refactoring patch, as previously requested by Yonghong.

sure

