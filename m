Return-Path: <bpf+bounces-54143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39545A635ED
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 14:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E6718917B7
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714C21AB530;
	Sun, 16 Mar 2025 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWqidSe0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731818B494;
	Sun, 16 Mar 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133511; cv=none; b=qyT6kQW1RcyZuBCbmmM25jt+tlaN4pla8bz9+Z6ihp211dyICkox97I64UOTFS0pmdaIAN/C8xWEhHU9SXedNxUTV5EF7CLStSI3gy/eC7C81v6IgOk2fJ1QXaDymiOlrVSV97wx4ULhmwaw2xSfiPs4n8EOBa+OM1DcRLeD4O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133511; c=relaxed/simple;
	bh=iyAHxdFTmJaDe07jK8USWVeZcaBnuLQhQ+AuUQmPIfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmYCRlM2JMA3HHkP8QXY0z0QjUp3NDQQ/iCHwzxw4LM7pshJw7sMiiIp4VkDVMIsLD27sPkhzlJx9fqaVs8qwrF9e8eGccKnVKIz32hQhm7BGsrFM4wy8aoGp/cBKwsViuDJJK1fJ6cCV206/iUwCGgMn7jsmj3brm3d0LrfRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWqidSe0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ff1814102aso36794497b3.1;
        Sun, 16 Mar 2025 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742133508; x=1742738308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gevK/+oX9q3Ym7i08KIzA2+gQInl/xd9S7OSBa1COk=;
        b=NWqidSe0QKU+22+3HmuvbXSnjxtdq5EAZzHGGGnCXtfnfevpKK7hKQxhggOqRM34OP
         UCxLTgPa++TidHTKPvlDyam4BoQ54N0X6UYoaxQTTs4xgfCMceVucTNOhp7wGnUqdmJ8
         yqLVhwEgtaPCJ9mUiTjE1UOtHzs810ARnBj2pxPoVAjvoIw+hioBg+jl18cvFux8k/Nw
         HoZUxsEGJJByVXCgaoXzv5xNoRoQnVd6ewDaagGM7L3J/zifC5nkER4rAj37D1ozU6YE
         +4uhnx+MTMHse2JLNr7A5R5CD2ca69zudYuoZXtkZ99MJtMqi4mjbE9nSmPooEuEl2yD
         Nozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742133508; x=1742738308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gevK/+oX9q3Ym7i08KIzA2+gQInl/xd9S7OSBa1COk=;
        b=czWXXzmXbIm4PuaD/nlMAN4lAIJ4eKu1I8ursy3DxYDGKn1Wpm+qkn37UCbteUQNiE
         7oWr0MBugyQXiH2QJY7OUqv3TwnZKX6Y2OBDdTEhHtEdmjdeIgYAOsHNbjZ/D6L2eq0P
         bwUqsObf77S3ChAjTmvqrrfjJbSPE61mXlFdM+YBfTrkujVtSopkVHWAwn8+rj6jAqDm
         w3qDhVu1VSW8QTaDb9TB64RuAU0nmiDKripxwI11JVGngGxvjFJJ1syZwVjziWxkxLKZ
         kcbR6LJbaYPW7kQ78FC+d0TMtY1UN++iaPc5TZRaZahBBIMBmJVUR0bf05g/Y+8HGheu
         tGGA==
X-Forwarded-Encrypted: i=1; AJvYcCXIzYrBWE8XxgpEDbRdr8bowE70hTx3FgWqHXMNqlo82Nf/ELKXaj65dYQUACHfAPiis1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YweKk0S0+Lpj51vpfmo7PvhKBDZmt5MWJAZ24LmyVqDJxCJI/LS
	zJ6xinS6ZWnqsBKOxGO2Fg5XDAa9sMS87jlvc1zKrkHFshIsqT1wDvzQXiz1FxGpInrjx3jlZ5A
	9UydWoISyjB2eyazoeFRsZuYELMA=
X-Gm-Gg: ASbGncukwK6CE3mCD7T9uiWbMHBUWbBUhjYBclK70q0uSjuaTH4kKG9dDw0V3Bi6Joh
	DXraUbfubXPsEa79UUbTj4VgmZ5uQwVJIojT2NL+zZJJzyUGaRCu4qRpMQw0lQp67Mpjr4pQWN0
	/U7IEe/lcFy0KxujDFFd+0zx6+Yg==
X-Google-Smtp-Source: AGHT+IFaUfg93Xnc4BKZa1vN4uq8epYipE4Oga6B0hGhhKVUPwsglgLLVIY8hKhgAJZ4OpAez5XZfRYtTZCU4wQUPmY=
X-Received: by 2002:a05:690c:319:b0:6fd:3153:2010 with SMTP id
 00721157ae682-6ff4624c272mr104962077b3.7.1742133508290; Sun, 16 Mar 2025
 06:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313190309.2545711-1-ameryhung@gmail.com> <20250313190309.2545711-10-ameryhung@gmail.com>
 <CAADnVQJ-kSNw4hiZ5p_fpsVAyYWDSu50OJyY_NGmaxk9+ofiiQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ-kSNw4hiZ5p_fpsVAyYWDSu50OJyY_NGmaxk9+ofiiQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 16 Mar 2025 21:58:16 +0800
X-Gm-Features: AQ5f1JqEBWSsrcUcAG0nkopBUPCbZHZTLh0vxTfpwzfiT38RqvpmM3ZFOxfwDb8
Message-ID: <CAMB2axNQiayH3_UHYFFi-OZ9tK0KmQ-b-k49ep=mio5dcRTGCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 09/13] bpf: net_sched: Disable attaching bpf
 qdisc to non root
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Kui-Feng Lee <sinquersw@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <stfomichev@gmail.com>, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	Peilin Ye <yepeilin.cs@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 4:31=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 13, 2025 at 12:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > Do not allow users to attach bpf qdiscs to classful qdiscs. This is to
> > prevent accidentally breaking existings classful qdiscs if they rely on
> > some data in the child qdisc. This restriction can potentially be lifte=
d
> > in the future. Note that, we still allow bpf qdisc to be attached to mq=
.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  net/sched/bpf_qdisc.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> > index e4e7a5879869..c2f33cd35674 100644
> > --- a/net/sched/bpf_qdisc.c
> > +++ b/net/sched/bpf_qdisc.c
> > @@ -170,8 +170,11 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn =
*insn_buf, bool direct_write,
> >                 return 0;
> >
> >         *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> > +       *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 16);
> >         *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
>
> Both loads need a comment.
> It's st_ops callback specific and not obvious what ends up in r1 and r2.
>

Got it. I will clarify this in the comment.

> >         *insn++ =3D BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);
> > +       *insn++ =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1);
> > +       *insn++ =3D BPF_EXIT_INSN();
> >         *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> >         *insn++ =3D prog->insnsi[0];
> >
> > @@ -239,11 +242,26 @@ __bpf_kfunc void bpf_qdisc_watchdog_schedule(stru=
ct Qdisc *sch, u64 expire, u64
> >  }
> >
> >  /* bpf_qdisc_init_prologue - Hidden kfunc called in prologue of .init.=
 */
> > -__bpf_kfunc void bpf_qdisc_init_prologue(struct Qdisc *sch)
> > +__bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
> > +                                       struct netlink_ext_ack *extack)
> >  {
> >         struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +       struct net_device *dev =3D qdisc_dev(sch);
> > +       struct Qdisc *p;
> > +
> > +       if (sch->parent !=3D TC_H_ROOT) {
> > +               p =3D qdisc_lookup(dev, TC_H_MAJ(sch->parent));
> > +               if (!p)
> > +                       return -ENOENT;
> > +
> > +               if (!(p->flags & TCQ_F_MQROOT)) {
> > +                       NL_SET_ERR_MSG(extack, "BPF qdisc only supporte=
d on root or mq");
> > +                       return -EINVAL;
> > +               }
> > +       }
> >
> >         qdisc_watchdog_init(&q->watchdog, sch);
> > +       return 0;
> >  }
> >
> >  /* bpf_qdisc_reset_destroy_epilogue - Hidden kfunc called in epilogue =
of .reset
> > --
> > 2.47.1
> >

