Return-Path: <bpf+bounces-70531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F2BC282C
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64DA44EDC51
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB51C229B1F;
	Tue,  7 Oct 2025 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHSzOzX/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590B215F5C
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865579; cv=none; b=coNmm33NMIw5bBXSVmBrMgY+vi3h/JBzTesn/S5+SF5jVQuggu/320hpxiQCTy5rye9nC6IXt7wAxqK8klADowECwKlQ/rWeHA7/Q2DHzc1uPcsSmPnH6g1csg5H0rhI0IwqgaNURLQmwNEp7FJjOGsLnsnaqVRDkbwWmiiAVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865579; c=relaxed/simple;
	bh=DF1Jb0VrcpI3epqt75m9g/KkcXfgSpFzDCB7ieVm7PA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ap5BktpDibntRr4nuP64kwpYnfW6SAoi5ofHnOBxUWibhSSfxL+/3dxzyB9Gqamx4ZV0UFtPdBV12JkUcQhJb4Ko1vQpPWqR+jb8ZOTGc4af6X+4iFidAxa2R4Lb+a2ketaD+OeLQVrAjWawfWqFzYw5J7eBJ/4PzAOOqC7+6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHSzOzX/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so2944052b3a.2
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759865577; x=1760470377; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qoKPnC+BWmFbnVihq4ewlglm1vwgPC8XHkbb9LSvAic=;
        b=IHSzOzX/CwFk4p0xmYuXn5rqs5M3J9Vt2ehXjoTFK3nAwGQtyv6/umUKUHq+2/hk1c
         o1SPsv3UHxjfrACNRTNHMU9XjCmJ1QnbzoXQ6oVBdeeXUh53QzpoRNi/7QTGrkpJJvpX
         lt86Ah9dtkR/XuwkB/265mYe9g6Zc3BIF8enXWeIkQJfOgj5kNQLhvTYtXP11M8F+Wnt
         fm/2ilf/HJaBNBQhZXYasWwZfiDgatR5EHePvyhEofoJhHHubWnasquCG80R3lkui199
         0FSmyq1+5Y3P4+Mny7PfSzojqpH8tHFKXxo35PrDQi1xNhjdjzZSfWz97RCZ7v4oT5EC
         jioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865577; x=1760470377;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoKPnC+BWmFbnVihq4ewlglm1vwgPC8XHkbb9LSvAic=;
        b=vAXgFnHGkRpDC46LaTh+ERcpgiVhrLdTM/WuP16p2poeKIrx4lenut8MA91G4NTIiL
         zDY9mbwmNLTYMUKnluK10NB5KFdO/wymDzj+X+wShxvLfuxqaA5OGfdvzAArERMvHAxI
         lEa1+Od7Eh35w5HCRndbqoJIvGgju6zLVGX9f/lrux8DKQ5Dux7aXSWCRjWU10T3NljM
         RZ53Wd60xASQc7HFBj9XgcjSONYVx1OhYCixdSinfAFB5d0Fihylb7mlvnP53Ds2KwtF
         pxeWZHXPY82lJnS1fqtWgsc7RwxWK08XwGWD7qaGJbCgBSeKeT0oYfJWMaz+am2IzUcN
         xt/g==
X-Gm-Message-State: AOJu0YxiraKyPq2mCDB2dJXdUGm2Suyh6LSJhSzEMDy4ka4QfcZo/pNw
	Rc8B3yhrsm2QMDQyye8ZAgeLOp/TRkQ7BO0FKPdFk9O9lgYFr65EurKg
X-Gm-Gg: ASbGncvpWsIS1ojQW4lkNxwRg0ceImtSWlJn9389TATgnSUDMLHCli82a+d0rirx3m2
	w446QhJa7Bf8t6SUwgin1FmezD55d2vpybMem4A0YUrYjbikaALTz9620XhdzJpULzQQtXtssk0
	g7KxKrhe2q7d4mfowkKqH81ldGH0rdYbeNo+ADrUimtbvBPcJI6Z+Xe+ryrvM9q10YXwo/8cluL
	2ebzhksGuRB/THTw3to/hbTO/OJXyR/4xtYUdDjQfRJRZzaH96eyCqtG/aMoHq9IKLohwSNsj5h
	h2MDAPiKm60PBcGJlTt9eI5ENQhE10bkp1JtyqnqBTTBzCIwpXFBUBBFHnyxRABfahFFuDvEuja
	kW0jElP6d4g7DNjANLrTy99mVBxxIUk3mOIfJAUf+tvPO8m3DyDY0IGWQ+EfqijSXVy54lIzR
X-Google-Smtp-Source: AGHT+IGcvlyV9XvW7SnQhQqmtqjnNyJWSEKow1u0My2SxeGCC95Bn/eX1AVx6T5FYeHp2IqtKCegpw==
X-Received: by 2002:a05:6a20:7d9f:b0:243:78a:828c with SMTP id adf61e73a8af0-32da8525680mr739433637.51.1759865577257;
        Tue, 07 Oct 2025 12:32:57 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bd3:2c4e:e9b8:4ad1? ([2620:10d:c090:500::5:b7ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01faef46sm16634757b3a.33.2025.10.07.12.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:32:56 -0700 (PDT)
Message-ID: <2e99de696f5a910714100d9e4408d0bf61c55c45.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Fix GFP flags for non-sleepable
 async callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, kkd@meta.com,
 kernel-team@meta.com, 	mykyta.yatsenko5@gmail.com
Date: Tue, 07 Oct 2025 12:32:55 -0700
In-Reply-To: <CAP01T77cYTG8v8LrviWFcptdTh5XanqSvUp5Wx9Hvf-LUGQzBA@mail.gmail.com>
References: <20251007014310.2889183-1-memxor@gmail.com>
	 <20251007014310.2889183-3-memxor@gmail.com>
	 <5ab5aa0dd0a769cfcee7fe9407f95d3956947794.camel@gmail.com>
	 <CAP01T77cYTG8v8LrviWFcptdTh5XanqSvUp5Wx9Hvf-LUGQzBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 21:26 +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue, 7 Oct 2025 at 21:14, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Tue, 2025-10-07 at 01:43 +0000, Kumar Kartikeya Dwivedi wrote:
> >=20
> > [...]
> >=20
> > > @@ -11460,10 +11460,17 @@ static int check_helper_call(struct bpf_ver=
ifier_env *env, struct bpf_insn *insn
> > >                       return -EINVAL;
> > >               }
> > >=20
> > > -             if (in_sleepable(env) && is_storage_get_function(func_i=
d))
> > > +             if (is_storage_get_function(func_id))
> > >                       env->insn_aux_data[insn_idx].storage_get_func_a=
tomic =3D true;
> > >       }
> > >=20
> > > +     /*
> > > +      * Non-sleepable contexts in sleepable programs (e.g., timer ca=
llbacks)
> > > +      * are atomic and must use GFP_ATOMIC for storage_get helpers.
> > > +      */
> > > +     if (!in_sleepable(env) && is_storage_get_function(func_id))
> > > +             env->insn_aux_data[insn_idx].storage_get_func_atomic =
=3D true;
> > > +
> >=20
> > Note this discussion:
> > https://lore.kernel.org/bpf/8e1e6e4e3ae2eb9454a37613f30d883d3f4a7270.ca=
mel@gmail.com/
> >=20
> > It appears there is already a need to have a flag in struct
> > subprog_info, indicating whether subprogram might run in a sleepable
> > context. Maybe add this flag and remove .storage_get_func_atomic
> > altogether? (And check subprog_info in the do_misc_fixups()).
>=20
> Ok, I can add a subprog field and check it that way.

To be useful both here and in Mykyta's case I think the flag should be
tri-state:
- never sleeps
- always sleeps [Mykyta's case]
- sometimes sleeps [this case]

Wdyt?

