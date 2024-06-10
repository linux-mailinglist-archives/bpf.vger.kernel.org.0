Return-Path: <bpf+bounces-31748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443A902A8B
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1581C210BE
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 21:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6B558A5;
	Mon, 10 Jun 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="misJVQ8Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA2339A8
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054743; cv=none; b=HzzGE1aKmcfwjWNNrs9QbZL0BknxUirL6fYgcZRf8rbl1zL56zrCcv+s8cK5UzObe4jRAZy1EIh//YINnCPsmSZKjgD/chIvxj4jmaJXGmWzpPqy5PT9GGzZfs3RXn+rqHRIQEEhs0hoOpWj9kmOL/tI+nySeBmY2zkoWs+nSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054743; c=relaxed/simple;
	bh=ZAe7f0cL+kGVBf0mcJckNzsWG989BKwXZBnyL54hF/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGqttbDtB/L9ZRG+2Si4wlP6czWXRN0t3HiICRoqJ9uKR445rWDHGYsuZ3LuZZr1WRkSzCCNGNqaXk+519Xr+OotFb3xsLXb0LncWX44PyV6wZyLLtYbhZYXTDdGpna3+Fp6jShC4JI9ov5GWbGfjr0Y7BxI7eM39kI1C+C9oqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=misJVQ8Z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso15825135e9.2
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718054740; x=1718659540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXZujGY/wINdh5piXbOHxGyMa7SvwFZ5xb3152OkVFs=;
        b=misJVQ8ZW5/IwY+4N6EXAQWvKlWw3D5SX8HbIpY03o6CVSI8ldbHBl54Xp85ZYrZO2
         QaOP7gdNXX+LrSAg1SqsSd+z1Bc5sijd5Lm64q09G5f5/1hvcQNbn6UnWb/ODi1ytlei
         AzpO/CWqk91fJ7fRR3VYui0a7l/EcyG3by8ohsOIl9CcBNOD3DStGPQf4C5TeAwTx+Af
         uVEJB2YUWeYCwc1EDRO/DB00gkkIV6OkZuvzJWhLiZqvqDtp1WoDJxoZ2ZCOS7xzAYVs
         oTMzDk+fzqymy/OY7XNy/miJVaJSyMtyXAAgohHzTTK3KR3SpQN4nLvkPwSf9rfqj5H8
         jwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718054740; x=1718659540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXZujGY/wINdh5piXbOHxGyMa7SvwFZ5xb3152OkVFs=;
        b=GUrwH+d2NsodDUyrgQ7ouLoWYLeGDGdQj8KMgfR6IsXhJQlEGqoxd9uyil4qrz2Kl7
         o74l4IdrTxqAla3wU7IF/UKfT7PcSEwNJ3drzfEiBfWD7dfsm7EWmiAQHIWydQprQJVn
         UcQ+EY3hJ6hTd7g7axsAU5nJmtHsbsUV+SlyR6btbcEbHf0j6RFb0xKfi/2Xh12tQ2pY
         dkWOH+DHh6oD9VlXvvT4yL94awWgc4jvKbyxg1Spb3Tg68EEkBCGDqd0YYp+8vXjQqQ4
         Eguav3A20mR6KA1QvXBWxtECiQisdqcWkN5JQjoDuaMwqvf3Px6g8bEjH4dKZMDlR1wY
         CzFA==
X-Gm-Message-State: AOJu0YyQ7BFh3xJpkmkhdNjmUsuehrtEem1+L/Sc1DKt9T6cjASh0BLD
	W4BdF+pM8v2Qeb/zmP6hmWlCTuCFKywpJEio/qHjEjiV6/Enl0rI8xlNDHDBdSDqcmp7Vl/hUjk
	9gEzWwqr0+vDW2T/FGRy8RRWoEfM=
X-Google-Smtp-Source: AGHT+IG3MOdS3gmGHj6yZuKsaw3F8anpC/R5yW+sd06gG1rmO3ApPcKAU5bc9psNeW/QcPTI+vF9VjQQiwlTuaoklzI=
X-Received: by 2002:a05:600c:4748:b0:421:edf4:1e89 with SMTP id
 5b1f17b1804b1-421edf42181mr36497925e9.4.1718054739549; Mon, 10 Jun 2024
 14:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
 <20240608004446.54199-3-alexei.starovoitov@gmail.com> <8ed1937f85f1f2b701ff70dd7b1429ffc9d250f6.camel@gmail.com>
 <CAADnVQLHPX8X7WyrO8g-Gf-LwdbdNTyBk_gegAzofB4yyv+ERQ@mail.gmail.com>
In-Reply-To: <CAADnVQLHPX8X7WyrO8g-Gf-LwdbdNTyBk_gegAzofB4yyv+ERQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jun 2024 14:25:28 -0700
Message-ID: <CAADnVQLCFHr3VaGZSNgR3R+RTKZsCivAxqr1w-TqXCjVQL9h0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Track delta between "linked" registers.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 1:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 10, 2024 at 11:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >
> > On Fri, 2024-06-07 at 17:44 -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Compilers can generate the code
> > >   r1 =3D r2
> > >   r1 +=3D 0x1
> > >   if r2 < 1000 goto ...
> > >   use knowledge of r2 range in subsequent r1 operations
> > >
> > > So remember constant delta between r2 and r1 and update r1 after 'if'=
 condition.
> > >
> > > Unfortunately LLVM still uses this pattern for loops with 'can_loop' =
construct:
> > > for (i =3D 0; i < 1000 && can_loop; i++)
> > >
> > > The "undo" pass was introduced in LLVM
> > > https://reviews.llvm.org/D121937
> > > to prevent this optimization, but it cannot cover all cases.
> > > Instead of fighting middle end optimizer in BPF backend teach the ver=
ifier
> > > about this pattern.
> >
> > I like this idea.
> > In theory it could be generalized to handle situations when LLVM
> > uses two counters in parallel:
> >
> > r0 =3D 0 // as an index
> > r1 =3D 0 // as a pointer
> > ...
> > r0 +=3D 1
> > r1 +=3D 8
>
> I don't see how the verifier can associate r0 and r1.
> In this example r0 with be a scalar while
> r1 =3D ld_imm64 map
>
> One reg will be counting loops.
> Another adding fixed offset to map value.
>
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> >
> > [...]
> >
> > > @@ -15088,13 +15130,43 @@ static bool try_match_pkt_pointers(const st=
ruct bpf_insn *insn,
> > >  static void find_equal_scalars(struct bpf_verifier_state *vstate,
> > >                              struct bpf_reg_state *known_reg)
> > >  {
> > > +     struct bpf_reg_state fake_reg;
> > >       struct bpf_func_state *state;
> > >       struct bpf_reg_state *reg;
> > >
> > >       bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > > -             if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D kno=
wn_reg->id)
> > > +             if (reg->type !=3D SCALAR_VALUE || reg =3D=3D known_reg=
)
> > > +                     continue;
> > > +             if ((reg->id & ~BPF_ADD_CONST) !=3D (known_reg->id & ~B=
PF_ADD_CONST))
> > > +                     continue;
> > > +             if ((reg->id & BPF_ADD_CONST) =3D=3D (known_reg->id & B=
PF_ADD_CONST)) {
> > >                       copy_register_state(reg, known_reg);
> > > +             } else if ((reg->id & BPF_ADD_CONST) && reg->off) {
> > > +                     /* reg =3D known_reg; reg +=3D const */
> > > +                     copy_register_state(reg, known_reg);
> > > +
> > > +                     fake_reg.type =3D SCALAR_VALUE;
> > > +                     __mark_reg_known(&fake_reg, reg->off);
> > > +                     scalar32_min_max_add(reg, &fake_reg);
> > > +                     scalar_min_max_add(reg, &fake_reg);
> > > +                     reg->var_off =3D tnum_add(reg->var_off, fake_re=
g.var_off);
> > > +                     reg->off =3D 0;
> > > +                     reg->id &=3D ~BPF_ADD_CONST;
> > > +             } else if ((known_reg->id & BPF_ADD_CONST) && known_reg=
->off) {
> > > +                     /* reg =3D known_reg; reg -=3D const' */
> > > +                     copy_register_state(reg, known_reg);
> > > +
> > > +                     fake_reg.type =3D SCALAR_VALUE;
> > > +                     __mark_reg_known(&fake_reg, known_reg->off);
> > > +                     scalar32_min_max_sub(reg, &fake_reg);
> > > +                     scalar_min_max_sub(reg, &fake_reg);
> > > +                     reg->var_off =3D tnum_sub(reg->var_off, fake_re=
g.var_off);
> > > +             }
> >
> > I think that copy_register_state logic is off here,
> > the copy overwrites reg->off before it is used to update the value.
>
> Right. Last minute refactoring got bad :(
> I had 'u32 off =3D reg->off' all along and then "refactored".

Realized that reg->off !=3D known_reg->off where both have add_const bit
set is actually possible.
This case is mishandled in the above. Will fix it too.
pw-bot: cr

