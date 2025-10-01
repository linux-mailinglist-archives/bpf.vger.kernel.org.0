Return-Path: <bpf+bounces-70175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8983DBB215E
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 01:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655E57AAE13
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 23:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194C28641F;
	Wed,  1 Oct 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G151zavg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852454918
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759362601; cv=none; b=ZOT4OEs3SqtIpbYleEnvBlnn8VWDgxcNHi6lVb8Uu1QbVzuJZSDpxnWWXejVKPb6Hi3BreTSf2EWEzck/d1EUZL9UNiODwY6IqZrzY9kemRbT1xHAcyTRMpSbyq4MqUPM53/MXLeIJcwDDRRVeE6phqdHDwu/bXLKgJXla02pWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759362601; c=relaxed/simple;
	bh=57bLEy5449KCyJJ8aY5tyTOwG24X0fMdlZmN3mmYJKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLWibyhKDqA+IA3OJwleTdxg4yq+Ka09lwJMeYyCxi9rFe+0a+mW/exf8o3eEl3rkejzet3CWuntMXgsNwRNfnq3ZXYn4v+Jq/VNAiECAkXl3wKltKjlYCWn43RHiB3Ag0/J1+FUDKT5fK4hiFaBgKS2dtxGhRQI9whlcZWYs9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G151zavg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso214151f8f.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 16:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759362598; x=1759967398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iH3PCCPEFctCl2XBWJlKZP7VRcRnGvWFKEin5Np52GE=;
        b=G151zavggRNsXHYsg8v4n1OmfYF/Volu7iKCcX5k2FBghINKH0GtUMzkesggqDwIkE
         QUo8HWlEZIMAKJF+UvWei2bXEACb2bjFMcIVaispcBXJToVEJhLWTUlIY0O8fQbQFA/4
         jh2bmOBtsMh8p9kDJVxOZAQ8Q8s7eUb6PT1r7gju2Qa4Qg0P79czCCPBfcYB7C7Ts1J/
         /uPNvwGHnY4LsL3MOy4352F/YdfVmb7XH2tUaXHXQ1AwM6jGskbjE+iPEVUdE4e3WeJo
         KUZNl42tv9oDrkB7CRw+Odx9W5GiFExx4lOkxU9Lg8lrP6GWR5g2l4m6RX8j2VTq9OsF
         SYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759362598; x=1759967398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH3PCCPEFctCl2XBWJlKZP7VRcRnGvWFKEin5Np52GE=;
        b=LFw+pIrLvUaBvYlQxukfZDdlGcVxKCxZDhIeRATALyv8ZGqAQ8nlRQb/C8N7dPZUew
         f/RgQZZJFobKjVC0XnjJHHZkvwhrYUU2WdR9NmWaI3+0hy1WO4RoXqCpy0zN4At1jkX4
         XcwWeg78yRX/ClTFGoFzULdhTvqmWwn13rrYA73b4ZloBtpGyavQ/4UszgrofxmcuP/t
         unl3GQ8IH4xilEuB8+4mhlZptpq0Ga7sWMGz5bIW4lkfPgyzlUEwA0mAi7Z+T8qnuaz7
         ossnx26STt2dkKCRClxVgikqDuCONGKT/OSxa8CoQetTKVhkfTxudy6wp5m936/N91MT
         Ic0g==
X-Forwarded-Encrypted: i=1; AJvYcCVIMQv1wLdxG4VPc8IXBhjZsF1s92P3vc6gUeosaF4PU58cPElX7lIupjh62oNOhZ9pudc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEhNYk5f4opELxxbm34OAZODVrZ11Zn4OCqllOCXxua9F/Tnq8
	N9BzMA47BWfjzGS2ZVV7efvPavyTGr9gp1T19+5Piza+avoQR7O8WgsW5PuXONcMvBC60YDj8d5
	5NqohtT7KP3VF1Hiedc32S140s1EajmY=
X-Gm-Gg: ASbGncsCgPD8lOs5OeZlrsQSyleyC6tcXNcNJCVM90VjzAEQatJ8iw3Iuqq145dLOA2
	32aXYsLrMRsGyPG2EohepNpXG1qEgFOdN+5KCiY5lMK2T+KedNM5YKBPD4fYNBT2Mfn9dARKH8H
	Ly5eVzk4DwzVul3Ndq05ELbmmMnwyEj0wIfC8Dwax6/FZRlm7uz7FRyyJa/zTKQaREjLkLY4l4T
	V04MF1vYs9I3LWnNLcd/WsIwNLSTEadULHyt86hyju3dCUOqgcYoWK640sq
X-Google-Smtp-Source: AGHT+IGfagwp//rncdVUW1mF0urxcAmyi9/IcU4r9KohrF8kakINErDwPtbo5UHJLkHyFF/HZq8LlTK3gz5fEr3CPKw=
X-Received: by 2002:a5d:5d85:0:b0:3b9:148b:e78 with SMTP id
 ffacd0b85a97d-4255781c7b6mr4363571f8f.53.1759362597946; Wed, 01 Oct 2025
 16:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-10-a.s.protopopov@gmail.com> <eddce884140f3df9e6c3c7e1b873a570b163ce1d.camel@gmail.com>
In-Reply-To: <eddce884140f3df9e6c3c7e1b873a570b163ce1d.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 16:49:46 -0700
X-Gm-Features: AS18NWAGF_I_YP_2PSm_a71hFu08_ZXMFit2pIEqvtqLU_LWZJfUO5azqoZxv2s
Message-ID: <CAADnVQ+K9hYhwxLO3+2xAcm04=SeyCQuYZtHmKMkmkKTUDQG4Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 09/15] bpf: make bpf_insn_successors to return
 a pointer
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 3:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> > The bpf_insn_successors() function is used to return successors
> > to a BPF instruction. So far, an instruction could have 0, 1 or 2
> > successors. Prepare the verifier code to introduction of instructions
> > with more than 2 successors (namely, indirect jumps).
> >
> > To do this, introduce a new struct, struct bpf_iarray, containing
> > an array of bpf instruction indexes and make bpf_insn_successors
> > to return a pointer of that type. The storage for all instructions
> > is allocated in the env->succ, which holds an array of size 2,
> > to be used for all instructions.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> (but please fix the IS_ERR things, see below).
>
> [...]
>
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -509,6 +509,15 @@ struct bpf_map_ptr_state {
> >  #define BPF_ALU_SANITIZE             (BPF_ALU_SANITIZE_SRC | \
> >                                        BPF_ALU_SANITIZE_DST)
> >
> > +/*
> > + * An array of BPF instructions.
> > + * Primary usage: return value of bpf_insn_successors.
> > + */
> > +struct bpf_iarray {
> > +     int off_cnt;
> > +     u32 off[];
> > +};
> > +
>
> Tbh, the names `off` and `off_cnt` are a bit strange in context of
> instruction successors.
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 705535711d10..6c742d2f4c04 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17770,6 +17770,22 @@ static int mark_fastcall_patterns(struct bpf_v=
erifier_env *env)
> >       return 0;
> >  }
> >
> > +static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_=
t n_elem)
> > +{
> > +     size_t new_size =3D sizeof(struct bpf_iarray) + n_elem * 4;
>
> Nit: n_elem * 4 -> n_elem * sizeof(*old->off) ?
>
> > +     struct bpf_iarray *new;
> > +
> > +     new =3D kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
> > +     if (!new) {
> > +             /* this is what callers always want, so simplify the call=
 site */
> > +             kvfree(old);
> > +             return NULL;
> > +     }
> > +
> > +     new->off_cnt =3D n_elem;
> > +     return new;
> > +}
>
> [...]
>
> > @@ -24325,14 +24342,18 @@ static int compute_live_registers(struct bpf_=
verifier_env *env)
> >               for (i =3D 0; i < env->cfg.cur_postorder; ++i) {
> >                       int insn_idx =3D env->cfg.insn_postorder[i];
> >                       struct insn_live_regs *live =3D &state[insn_idx];
> > -                     int succ_num;
> > -                     u32 succ[2];
> > +                     struct bpf_iarray *succ;
> >                       u16 new_out =3D 0;
> >                       u16 new_in =3D 0;
> >
> > -                     succ_num =3D bpf_insn_successors(env->prog, insn_=
idx, succ);
> > -                     for (int s =3D 0; s < succ_num; ++s)
> > -                             new_out |=3D state[succ[s]].in;
> > +                     succ =3D bpf_insn_successors(env, insn_idx);
> > +                     if (IS_ERR(succ)) {
>
> This error check is no longer necessary.

Speaking of IS_ERR checks...
https://github.com/kernel-patches/bpf/pull/9895#issuecomment-3352016682

AI for-the-win!

