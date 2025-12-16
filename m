Return-Path: <bpf+bounces-76787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4961CC57B7
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 00:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E373302BD1E
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF832DCC13;
	Tue, 16 Dec 2025 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxAACP/S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39858A59
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927936; cv=none; b=FJNJfYnZ18HHjtMVqJau5lG3tdgg8Tf/SILiHu7Ilh6LVCjjN1IsKW+6uVffv1M0FUJfzwub3toVzY57bIBcJA+i0esg6Z2I47gS8Pz892hjj9Ncib3hEJdXIqYzznd1IUn+Q/5F+WLxyuOPmBiCQkvBziEjYsI0nElY71MKt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927936; c=relaxed/simple;
	bh=PMLa6KQ5j9qsZSb9YY/5NixTV13CMcAOYp8zs7JWR6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOOnTl7asYydvP7vOQeyFbgVlsmhlPkFHST8BXy1jfj4TM5Y0pGSau5UmXIefSio5LuHkcDVi4hYePE4eyVSNeJ/C+TFnAou2FbSU7BsnzPBI+vwMcwJMJGiYfA6fl66Hyu6QMtE5Id63gGomi76TFCx2A8KBDpTb2quHKnDgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxAACP/S; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64475c16a11so5996722d50.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 15:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765927934; x=1766532734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCqOJz3/AO+slIUpPaTLb5wuos0u8E1UdxRizYG9U/E=;
        b=cxAACP/SZcZfDFD0SdHbFrlq5DNGB0eIVFV+ti9iVPhU+yO7MMmtTBOoew/wFTH2MJ
         bVWa/vhRH/CyEpLH6J7OzDVGIzPmtvsg6rYcl+LOjbgs4wUkKoCIBw5BNdWBsJcOGwPY
         xUUCTBpiW6/2Da8+UO3RebcIj+BXInUykQ5h3qsxsRmk6xvgV2ywcf17/6vYxvag0hg4
         w206ZVOsweWDXIoO/FkTjTsBsTs1Cj3X2Kdb1Pt2qCM293SjzOLrY4g7PxhcInZoq4WG
         S9heAYN3xEk4RO0OshnSyRrRxfcwScpVWkbMtq2NIgMoIpI9DKWNfLKTr+d6CEMkO9CR
         ivRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765927934; x=1766532734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCqOJz3/AO+slIUpPaTLb5wuos0u8E1UdxRizYG9U/E=;
        b=m7zO+SkzGqOTGEYfC5o0awIax9C5C3hm6lD35P1KIH5RQ5IPCQJSxpB/HrRX814Kjb
         aEXzqo1RKj6y4xEFtsBS4qG/RDyTaQXOsR1VBAizR8n0H9n45GQRf5VAy/zAmd+Z9fj3
         AMsIxxKDqcYnGonQxEyMmm7FO5ijYznVlpgrtU6di4xX5pvvU7FcydvgJXpqratnlROx
         6oHrmE5R6jTlri1GsvTXlsuDFNybwShhI24AVZctf5TY7SnNmK+h5TIzDrkTTHeXmRV2
         gHh6Olp9o1Yu30jVqn/a9rfav7nqtx0pPKUjULGOFKLao0DN7Iv/Fb1gyxHPz7u1F5hH
         npHg==
X-Forwarded-Encrypted: i=1; AJvYcCVC4ONWDdLx8zPQ8P7XOV3hOzk4QS+of8s/WA5rfZtmU5PLlq8Yn3PR8O9UFzYqRifPm+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7lqc2rzhwEQzAKTakzLHcv77SbIdEexWfjqnwz2/r9jNJTWu
	CIhH+O52ffjaGIHT7uNPQMFZ0FPQoPiQgl78xgdqeufa2ppIdWVSryVNdPVeFNQBFVhdffJ8k9V
	If/fmTUPgVB5vIWbozY4T7aYhOY+2218=
X-Gm-Gg: AY/fxX5ou0/r4tjVWjVKDOjHu6Vu6EDzzj0doj0sy8tRvJQjm/3/euVtXWDBpZU/WAE
	448NfuB8/+SR50zRM9PIRARnltVs3IpuLh6f9ODiWvkabM4i7TvIB7OurJW5FJqldb3R29O2Til
	Zire+GF4xt9KySWsux4/kjD0M06roZjZqVRb8I3X5CXPKMF0BLBnQjTfl+l+REPNVQyf6xcB0pi
	HfnjcumrJ2N1RT8PDcuFjpRKX2Wsco6PX+jRY5ts02l+u9dRMLXbRZWZ9plQ3ei6IQPwpw=
X-Google-Smtp-Source: AGHT+IFBmJ7NcJkqux+xfCYQIgEYBHsBXDOpTgIjshDPrjuG1PGWiJhNvrlOmdUfdAhk4Sl8n0rUHC+JGTuKL9dklCM=
X-Received: by 2002:a05:690e:1a05:b0:63f:2bc7:706f with SMTP id
 956f58d0204a3-64555650e0cmr10852930d50.57.1765927934104; Tue, 16 Dec 2025
 15:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216173325.98465-3-emil@etsalapatis.com> <0447c47ac58306546a5dbdbad2601f3e77fa8eb24f3a4254dda3a39f6133e68f@mail.kernel.org>
 <CAEf4BzazeSaj5MgF01uDMOdiMDSA=YVU=kvzSDKB_Hx7NOARtw@mail.gmail.com> <18ef13a0b9588cefacc58434bb6a097b92c7d6a7.camel@gmail.com>
In-Reply-To: <18ef13a0b9588cefacc58434bb6a097b92c7d6a7.camel@gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 17 Dec 2025 08:32:03 +0900
X-Gm-Features: AQt7F2r1i3BBHMgL5qUgjVcundeTEj1__6RnuJHnpr0kj4UE7otxXE8Teoovup8
Message-ID: <CAGn_itxuZoZkM7VfY2Lt1Nc25Z8Ss5g3p=QPQduxjSkODqbbiw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] bpf/verifier: do not limit maximum direct offset
 into arena map
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bot+bpf-ci@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 3:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-12-16 at 10:38 -0800, Andrii Nakryiko wrote:
> > On Tue, Dec 16, 2025 at 10:02=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index a31c032b2dd6..d6b8a77fbe3b 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -21132,11 +21132,6 @@ static int resolve_pseudo_ldimm64(struct b=
pf_verifier_env *env)
> > > >               } else {
> > > >                       u32 off =3D insn[1].imm;
> > > >
> > > > -                     if (off >=3D BPF_MAX_VAR_OFF) {
> > > > -                             verbose(env, "direct value offset of =
%u is not allowed\n", off);
> > > > -                             return -EINVAL;
> > > > -                     }
> > > > -
> > > >                       if (!map->ops->map_direct_value_addr) {
> > > >                               verbose(env, "no direct value access =
support for this map type\n");
> > > >                               return -EINVAL;
> > >
> > > The map_direct_value_addr() implementations for array and arena maps
> > > return only the base address, and then resolve_pseudo_ldimm64() adds =
the
> > > offset at line 21148:
> > >
> > >     aux->map_off =3D off;
> > >     addr +=3D off;
> > >
> > > However, insn_array_map_direct_value_addr() (kernel/bpf/bpf_insn_arra=
y.c)
> > > has a different implementation pattern:
> > >
> > >     static int insn_array_map_direct_value_addr(const struct bpf_map =
*map,
> > >                                                  u64 *imm, u32 off)
> > >     {
> > >         struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> > >
> > >         if ((off % sizeof(long)) !=3D 0 ||
> > >             (off / sizeof(long)) >=3D map->max_entries)
> > >             return -EINVAL;
> > >
> > >         /* from BPF's point of view, this map is a jump table */
> > >         *imm =3D (unsigned long)insn_array->ips + off;
> > >
> > >         return 0;
> > >     }
> > >
> > > Notice that insn_array adds the offset to the base address inside the
> > > function (line: *imm =3D (unsigned long)insn_array->ips + off). When
> > > resolve_pseudo_ldimm64() then adds the offset again at line 21148, th=
e
> > > result is:
> > >
> > >     addr =3D (insn_array->ips + off) + off =3D insn_array->ips + 2*of=
f
> > >
> > > Can this cause insn_array maps to access incorrect array elements? Fo=
r
> > > example, if a program requests offset 32 (which passes the bounds che=
ck
> > > since 32/8 =3D 4 < max_entries), the actual offset becomes 64, potent=
ially
> > > accessing insn_array->ips[8] when max_entries is only 10.
> >
> > That's a question to Anton (cc'ed), not really related to this patch.
> > Anton, please check and send a fix, if necessary.
>
> Seem to be a valid concern.
> We don't have tests for BPF_PSEUDO_MAP_VALUE used in combination with
> instruction maps.

Yes, was on my list for a while (llvm does always set off=3D0, so
nothing broke so far).

I will add a fix and selftests when I am back from Japan (next week).

> [...]
>

