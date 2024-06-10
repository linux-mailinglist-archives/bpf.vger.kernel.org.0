Return-Path: <bpf+bounces-31742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ABE9029EE
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 22:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D861C20CCF
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D447F60;
	Mon, 10 Jun 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRHo76G8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B98B65E
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051273; cv=none; b=mHkJTZ1YX/z57KXfGc7KtRLqm/51ekE7rxnAA7MSXJDTpMAHf/jZL4stA3KXZx9M0YlBL1NdojbcAEwyeIIteCVKvWsvODs+V08fZc2POumVBmjzSEQZuqfaqFec2HVvBMpJSLsw1PRGWJHY1wIsrU2UZ5g8LVTEC4jcbOdiHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051273; c=relaxed/simple;
	bh=cwWkUZKAuhIGDpe7REltLQeHigskgj2+wJiRW2BnWCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyp+G8CJu3P+MkFwFYPC1nD6NcbITdpherFXS5tnczVnuyJsXbESXVP3PtCAwjn+bj+oTrLLBXd4Z5ARw/xszBIbMZv/+syiHFzoKLrDwJfSu3WKl1LIL0Skf2oISqZIgreuYfsjJE1wzGW9/K6z9+YcXk9merQvZR4DSMtDMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRHo76G8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso3156045e9.3
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 13:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718051269; x=1718656069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQwaRkxPFdr6YsHIO6ajnNImkxPQwBsKQj5uUc4mxdA=;
        b=SRHo76G8um0ka2syMbZ/yddIsqLZ//xlZLa1qfcMfXKqIYAWzCPszSUR/h19hHRost
         KT2lMWLobhSAxohBU8E9faFm6YFc/PY+VVxASecrPt7X+t2hjgoZA2wcEPNFcC+32YfQ
         1p5626iwxjmkzXQL4NXVB6cz0/j8maM+ocWUyPbdJpwUuN3vSxTHHd/4Y0K53c9EQAJu
         OBIhsn3OXD3zz4zDYXlaja7Hq3fNSYORmSNmAmyP+xYwUsVuxSpW8zpDqO6cs4BEAd0f
         ZcgjDNf0iTZltww3Egnnj3V0ZMk4C2mVNf6URK0MvWNJPR+az+llwtK20fQd5gLa+miV
         41Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718051269; x=1718656069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQwaRkxPFdr6YsHIO6ajnNImkxPQwBsKQj5uUc4mxdA=;
        b=HW6YVDt6aJpqaWP3q5Xt+yZj2hJQUAGDPQkaYLgxcnyc+/U7b33z9uytN2rVbTCZEX
         a7IjzjBmrBY2pGdE5Vcb4ObjTeTO6uh047G5KmHKDLqWXGFk/6wy9ea5DgZinSk7ufhr
         DmwBZbXiTUcHnFbp7ohzDECJh9Pg5xParnryeJlmdubFMpENjM4jxzm1cgylMV3RWFbn
         nRGX3U8MfJ5910TQhRO2MBia7K73AxkqaMXEDa/jNuJRxO9NrtYjw0lwA9Jhc2JGJjL5
         YFD1e4ZdMmVNX5yAEc+YgYikHIMrP4OxXCDDd7L6lVfs+/oxipCgGRPoIbysVmHIkSh4
         ewEQ==
X-Gm-Message-State: AOJu0YzUPXmCxeWfUZDNquZJzFFYtu8VYJdkj6ECoYIkx5m/KQ2+DHm9
	yK8cPikpDg7Z5StlGLollVjJ9lN6ZTyIyGc1edcexCFJ5kLil5S/DWbcE3iRNJqBN1WdoePjjoT
	8OlVwv9T4LkNhkCJ2ktVlOGR0yCg=
X-Google-Smtp-Source: AGHT+IHbcQ0VH7ajW9qYUD6pTcLqyIjVO6VXBnj3fK+i/2BmRVNaM1p/MKTZA5G8S2YwXnYLSg3lnnOHKolRaj6Rpf8=
X-Received: by 2002:adf:fe51:0:b0:35f:bcc:98e4 with SMTP id
 ffacd0b85a97d-35f0bcc9a59mr5962080f8f.9.1718051269363; Mon, 10 Jun 2024
 13:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
 <20240608004446.54199-3-alexei.starovoitov@gmail.com> <8ed1937f85f1f2b701ff70dd7b1429ffc9d250f6.camel@gmail.com>
In-Reply-To: <8ed1937f85f1f2b701ff70dd7b1429ffc9d250f6.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jun 2024 13:27:37 -0700
Message-ID: <CAADnVQLHPX8X7WyrO8g-Gf-LwdbdNTyBk_gegAzofB4yyv+ERQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Track delta between "linked" registers.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-06-07 at 17:44 -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Compilers can generate the code
> >   r1 =3D r2
> >   r1 +=3D 0x1
> >   if r2 < 1000 goto ...
> >   use knowledge of r2 range in subsequent r1 operations
> >
> > So remember constant delta between r2 and r1 and update r1 after 'if' c=
ondition.
> >
> > Unfortunately LLVM still uses this pattern for loops with 'can_loop' co=
nstruct:
> > for (i =3D 0; i < 1000 && can_loop; i++)
> >
> > The "undo" pass was introduced in LLVM
> > https://reviews.llvm.org/D121937
> > to prevent this optimization, but it cannot cover all cases.
> > Instead of fighting middle end optimizer in BPF backend teach the verif=
ier
> > about this pattern.
>
> I like this idea.
> In theory it could be generalized to handle situations when LLVM
> uses two counters in parallel:
>
> r0 =3D 0 // as an index
> r1 =3D 0 // as a pointer
> ...
> r0 +=3D 1
> r1 +=3D 8

I don't see how the verifier can associate r0 and r1.
In this example r0 with be a scalar while
r1 =3D ld_imm64 map

One reg will be counting loops.
Another adding fixed offset to map value.

> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> [...]
>
> > @@ -15088,13 +15130,43 @@ static bool try_match_pkt_pointers(const stru=
ct bpf_insn *insn,
> >  static void find_equal_scalars(struct bpf_verifier_state *vstate,
> >                              struct bpf_reg_state *known_reg)
> >  {
> > +     struct bpf_reg_state fake_reg;
> >       struct bpf_func_state *state;
> >       struct bpf_reg_state *reg;
> >
> >       bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > -             if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D known=
_reg->id)
> > +             if (reg->type !=3D SCALAR_VALUE || reg =3D=3D known_reg)
> > +                     continue;
> > +             if ((reg->id & ~BPF_ADD_CONST) !=3D (known_reg->id & ~BPF=
_ADD_CONST))
> > +                     continue;
> > +             if ((reg->id & BPF_ADD_CONST) =3D=3D (known_reg->id & BPF=
_ADD_CONST)) {
> >                       copy_register_state(reg, known_reg);
> > +             } else if ((reg->id & BPF_ADD_CONST) && reg->off) {
> > +                     /* reg =3D known_reg; reg +=3D const */
> > +                     copy_register_state(reg, known_reg);
> > +
> > +                     fake_reg.type =3D SCALAR_VALUE;
> > +                     __mark_reg_known(&fake_reg, reg->off);
> > +                     scalar32_min_max_add(reg, &fake_reg);
> > +                     scalar_min_max_add(reg, &fake_reg);
> > +                     reg->var_off =3D tnum_add(reg->var_off, fake_reg.=
var_off);
> > +                     reg->off =3D 0;
> > +                     reg->id &=3D ~BPF_ADD_CONST;
> > +             } else if ((known_reg->id & BPF_ADD_CONST) && known_reg->=
off) {
> > +                     /* reg =3D known_reg; reg -=3D const' */
> > +                     copy_register_state(reg, known_reg);
> > +
> > +                     fake_reg.type =3D SCALAR_VALUE;
> > +                     __mark_reg_known(&fake_reg, known_reg->off);
> > +                     scalar32_min_max_sub(reg, &fake_reg);
> > +                     scalar_min_max_sub(reg, &fake_reg);
> > +                     reg->var_off =3D tnum_sub(reg->var_off, fake_reg.=
var_off);
> > +             }
>
> I think that copy_register_state logic is off here,
> the copy overwrites reg->off before it is used to update the value.

Right. Last minute refactoring got bad :(
I had 'u32 off =3D reg->off' all along and then "refactored".

> The following test is marked as safe for me, while it should not:

Thanks for the test. Will incorporate.

