Return-Path: <bpf+bounces-34357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1B692CA21
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 07:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352621C222B2
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 05:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9BE4AEF4;
	Wed, 10 Jul 2024 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al3yg0ES"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB417FD
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720589318; cv=none; b=cr5rqg3Oxx52j3xu2IXiLpIEcZEvxXh9SLxDL3c6yNbwyxeyS5SiMJozexMY0ZlV3R/4CAA9r7u68TtsSpVN5avOdcNhjvsqvFxvfQ4OYKaVj5xd9Uf1qZkiyo21LnkMmX/Ll1pB5x39Z+nxdTQq5tbapZEWPsDHu5gTswygVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720589318; c=relaxed/simple;
	bh=FBzwd8gDtH7Nm1XicxIl1F91bqPQdO5zLCU16UeJDq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRaYhpTZOf9Ta2xBBCmBvqLMPaoL5b6Pv05+PbdN5vWNB70bY4r3WtuMZgq8QxEv4MIHfCNKNOItFYZ2ELCZFbEdvgP/E5Q6K8S+FmE9q7DnTwqX8vaUQfLZKaZNuhqEX/TgOSZYr8XIXPQtg+MZE+vm1e/HVst5iYQ75WluSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al3yg0ES; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb1c918860so2890845ad.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 22:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720589316; x=1721194116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrJntrS6ckpLxWkLxKvVcOevR+dJpJgyM7w/DeAqgRo=;
        b=Al3yg0ESpvN9RUb+XKrfn/jSX3F+bei1Z1LtJK/DNXz8s6NQq20ll8gUwlQZwgBG4v
         rFCNNAOVNP+TW3JJ2gaxfZK3WpiaR5Cs5Afsgi5nXrfBEUTydIST2Jv2a+4XAUs9amQJ
         b364UEwknWKfmmOdYSUefQ9yyQweDYm791NG6vFtyVHy/eLP2v8Mtj7+i84najDXPEXr
         RoJx+4K0tvNZAZspsb56dhop64ydwa0ngniuF8ZU6OyfLFStc2jd1wf3VTrpswI18vNT
         Tym/ofyF7v2NSMVdh+1yCUItpn5qMzW9JmxJKUEBo4Jlt/ELXiMoTCZ68tBufZ6M+kMt
         KEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720589316; x=1721194116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrJntrS6ckpLxWkLxKvVcOevR+dJpJgyM7w/DeAqgRo=;
        b=upJ7DnI/C13QqIxW95SHzSmDsexoVaIUKGMNvNSvLv10Y/u9v8NtcKIrUoRzaC2vRn
         WTiMTFChLElxy8y58NfUA+rvV/0ipkUHse6AgzTFpmgbEmStz1Q9oR6biL5ng1rX0Vmk
         p84sClf2s68SsEMOV14ac2tuQJUniqzYGDzebo6UVjFUKAloaf/bth1Gj6h2lZ/6pAnA
         uEdE18CBcxQaTpprNi7/5WTuTHn1wLdabdAfcZfvxIx7prr0y+U37c/qP6AAHqbZCI/3
         NFq2kcexw2/EHXTyWTepINp5V8m3KtGlqpPT70wH7DTsswGFdwDyqx6R+tmuePt0U8T8
         u8zg==
X-Gm-Message-State: AOJu0YwqMKySFKOKDT9AM4mYT6NpqPlJUTmaWxIVtFxj+t/6fWccvbth
	skmzyydV7yMZQH7LX780KQu9CEXM+B2+/xGLxoNztBTx5PLOyHS7v+m7S/Fd9LkQreTuRJgK9Zo
	N+PReVPUCIA6dUR5Omk+3QW7UxB8=
X-Google-Smtp-Source: AGHT+IFDgS+XBoKZS7sSHhzhU3NWeBEa1HkcG0PcbxpwPh556p9o0iACxGguKcu2ChCsUETZ6FQHhgS45o7f1J9S/Ro=
X-Received: by 2002:a17:903:1205:b0:1fb:8e29:621f with SMTP id
 d9443c01a7336-1fbb7fea3d6mr58672835ad.16.1720589315853; Tue, 09 Jul 2024
 22:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705205851.2635794-1-eddyz87@gmail.com> <20240705205851.2635794-2-eddyz87@gmail.com>
 <CAEf4Bzbq8Lg+n1K=V0RjgKh7+PFU5rrwFPP2s0Z+g_nLbUpcPA@mail.gmail.com> <e1551a1e473d0497275f74a005e47841f058cf7b.camel@gmail.com>
In-Reply-To: <e1551a1e473d0497275f74a005e47841f058cf7b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 22:28:23 -0700
Message-ID: <CAEf4BzbnduEs50kcFbN=jR1otTBtbqxrQrtRHo8iF4b=j_onUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: track find_equal_scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2024-07-09 at 17:34 -0700, Andrii Nakryiko wrote:
> > On Fri, Jul 5, 2024 at 1:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > Use bpf_verifier_state->jmp_history to track which registers were
> > > updated by find_equal_scalars() when conditional jump was verified.
> > > Use recorded information in backtrack_insn() to propagate precision.
> > >
> > > E.g. for the following program:
> > >
> > >             while verifying instructions
> > >   r1 =3D r0              |
> > >   if r1 < 8  goto ...  | push r0,r1 as equal_scalars in jmp_history
> > >   if r0 > 16 goto ...  | push r0,r1 as equal_scalars in jmp_history
> >
> > linked_scalars? especially now that Alexei added offsets between
> > linked registers
>
> Missed this, will update.
>
> >
> > >   r2 =3D r10             |
> > >   r2 +=3D r0             v mark_chain_precision(r0)
> > >
> > >             while doing mark_chain_precision(r0)
> > >   r1 =3D r0              ^
> > >   if r1 < 8  goto ...  | mark r0,r1 as precise
> > >   if r0 > 16 goto ...  | mark r0,r1 as precise
> > >   r2 =3D r10             |
> > >   r2 +=3D r0             | mark r0 precise
> >
> > let's reverse the order here so it's linear in how the algorithm
> > actually works (backwards)?
>
> I thought the arrow would be enough. Ok, can reverse.

it's the reverse order compared to what you'd see in the verifier log.
I did see the arrow (though it wasn't all that clear on the first
reading), but still feels like it would be better to have consistent
order with verifier log

[...]

> > > @@ -3844,6 +3974,7 @@ static int backtrack_insn(struct bpf_verifier_e=
nv *env, int idx, int subseq_idx,
> > >                          */
> > >                         bt_set_reg(bt, dreg);
> > >                         bt_set_reg(bt, sreg);
> > > +               } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> > >                          /* else dreg <cond> K
> >
> > drop "else" from the comment then? I like this change.
>
> This is actually a leftover from v1. I can drop "else" from the
> comment or drop this hunk as it is not necessary for the series.

I'd keep explicit `else if`

>
> > >                           * Only dreg still needs precision before
> > >                           * this insn, so for the K-based conditional
> > > @@ -3862,6 +3993,10 @@ static int backtrack_insn(struct bpf_verifier_=
env *env, int idx, int subseq_idx,
> > >                         /* to be analyzed */
> > >                         return -ENOTSUPP;
> > >         }
> > > +       /* Propagate precision marks to linked registers, to account =
for
> > > +        * registers marked as precise in this function.
> > > +        */
> > > +       bt_sync_linked_regs(bt, hist);
> >
> > Radical Andrii is fine with this, though I wonder if there is some
> > place outside of backtrack_insn() where the first
> > bt_sync_linked_regs() could be called just once?
>
> The problem here is that:
> - in theory linked_regs could be present for any instruction, thus
>   sync() is needed after get_jmp_hist_entry call in
>   __mark_chain_precision();
> - backtrack_insn() might both remove and add some registers in bt,
>   hence, to correctly handle bt_empty() call in __mark_chain_precision
>   the sync() is also needed after backtrack_insn().
>
> So, current placement is the simplest I could come up with.

agreed, let's keep it as is

[...]

> > > @@ -15312,6 +15500,21 @@ static int check_cond_jmp_op(struct bpf_veri=
fier_env *env,
> > >                 return 0;
> > >         }
> > >
> > > +       /* Push scalar registers sharing same ID to jump history,
> > > +        * do this before creating 'other_branch', so that both
> > > +        * 'this_branch' and 'other_branch' share this history
> > > +        * if parent state is created.
> > > +        */
> > > +       if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=3D =
SCALAR_VALUE && src_reg->id)
> > > +               find_equal_scalars(this_branch, src_reg->id, &linked_=
regs);
> > > +       if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
> > > +               find_equal_scalars(this_branch, dst_reg->id, &linked_=
regs);
> > > +       if (linked_regs.cnt > 1) {
> >
> > if we have just one, should it be even marked as linked?
>
> Sorry, I don't understand. Do you suggest to add an additional check
> in find_equal_scalars/collect_linked_regs and reset it if 'cnt' equals 1?

I find `if (linked_regs.cnt > 1)` check a bit weird and it feels like
it should be unnecessary. As soon as we are left with just one
"linked" register (linked with what? with itself?) it shouldn't be
linked anymore. Is there a point where we break the link between
registers where we can/should drop ID from the singularly linked
register? Why keep that scalar register ID set?

>
> [...]
> >
> > > +               err =3D push_jmp_history(env, this_branch, 0, linked_=
regs_pack(&linked_regs));
> > > +               if (err)
> > > +                       return err;
> > > +       }
> > > +
> > >         other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *=
insn_idx,
> > >                                   false);
> > >         if (!other_branch)
> > > @@ -15336,13 +15539,13 @@ static int check_cond_jmp_op(struct bpf_ver=
ifier_env *env,
> > >         if (BPF_SRC(insn->code) =3D=3D BPF_X &&
> > >             src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
> > >             !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->sr=
c_reg].id)) {
> > > -               find_equal_scalars(this_branch, src_reg);
> > > -               find_equal_scalars(other_branch, &other_branch_regs[i=
nsn->src_reg]);
> > > +               copy_known_reg(this_branch, src_reg, &linked_regs);
> > > +               copy_known_reg(other_branch, &other_branch_regs[insn-=
>src_reg], &linked_regs);
> >
> > I liked the "sync" terminology you used for bt, so why not call this
> > "sync_linked_regs" ?
>
> I kept the current name for the function.
> Suggested name makes sense, though.
>
> [...]

