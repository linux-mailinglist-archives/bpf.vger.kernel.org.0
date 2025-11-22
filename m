Return-Path: <bpf+bounces-75290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEEDC7C311
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 03:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2665B4E1187
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 02:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D2136D50C;
	Sat, 22 Nov 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQjGRuD9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86660200110
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763779224; cv=none; b=hA47nq3MD0C9bqRheBPzAZ0mxw9X2xrc7j+ZPl/v9d6h1FBZqDRtXGnpna5gsB2+pS2A+2Br5WPzI+8KQzBo3YJsDuBgPuagMeoyVqO9C/LmustlUZXj6NJO9D2AmCYgI7s2lsyxIYbwxl0osR2zOYD3RaVxVDXPPzW8ZII6UuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763779224; c=relaxed/simple;
	bh=hrjdyYQlLNn3yGYWYZZiYS5PIq4P3KsmXlPzGfqgGck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yhhu62Enqn3Xm1ThTiIV70xOqdEnXTXWS+i7jwrBMpwcaiEL+7JG6wK13CasXBOK06yOJzHd9qhuif0nVXqmHjynGvzxXQQE61ifbq9MimA2Zt8w6D6bICy8BZ6SOQzrgzgT6f3mXYeHHFxEoTf/n5ffwGM9zs2zWTc7t6Bd+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQjGRuD9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42bb288c17bso1668608f8f.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 18:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763779221; x=1764384021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEl0BN97wjFwQNpva7nBiMdWVD+0kX1mEzg2DvN/RL8=;
        b=lQjGRuD9lXj5fcHktiMuwQ12NsZatU9Iipv3k39A1WfwA/QGs4MdenRLeTc88ABM25
         XTA/dKhx6YjJXpSH0wvRUTmWyUgNW2fegyZLUzLcFnXHuIV/w4WqcHCvYMD+xtkWzWed
         6lWiIEgcepcnO54BdenEvcTxlQ+O3AA8hLkEUqUr2JQluXEzMgwCpv7PuJAb5TpuXBNP
         Nkr2qYP034bqsw+ycNEmnrc1FmGUXGXmeXuD52K4SW+UU9XjYOAViUeUmRDC4hU4DIfn
         QAyiRJ/WRlTZDdO830hUoNhcYYA9KyTRYKxG+HpnJDaQCPHDK7JcGXRwiWGW4b0PQ/Sy
         p51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763779221; x=1764384021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cEl0BN97wjFwQNpva7nBiMdWVD+0kX1mEzg2DvN/RL8=;
        b=XsRcwaLToL2iPFPHpIY5gefr7at9A1m9K8JgqYSX/6l24+LEa/ftPBwzRsaIytfuhZ
         4KqRsTU7DNyfZ1gM6BOPCrL3Bbgf7wylSnYbn1kGXw438zmGdV5lsxZ4KSE6UgJm8RLD
         Xrymb+zVkS28i4a3lVcD48IWL7iSH1FbseEld7oxUrkUZyDzvTS8QsV4lJmRoD6nsSve
         F+xBRb/P9zZ3Qo2WrPy4p5IiVT5DzDLnPuVq5ysQpPpSnOWXNbgB4ciiiNknQew+g7dr
         g3kzYtZqSmzjtgwZStatrSH5oeHTGiLAErwzZ9g2+jokq8tRaxchdR4pnaKk4BxfU1pq
         mJ5w==
X-Gm-Message-State: AOJu0YyWxpF9Kgf/Vaho1EIkKpz79Dhpv2a7tDLjtAN0AdpBJpk9GloQ
	pI7INuiXgSL6fYh3E2NS7dNjffDuNnaDTrrpxeUUCDKLaDmFptCi3zB9M82SiP4E8HwfWswUFnj
	u7hGh5GoKHG6G5MnFhHKIUn+lpOn2mBI=
X-Gm-Gg: ASbGncvHcGyyyG8mnBY96gtiA8PD+hlVSi+BuElkr5img/MTpfiU4RVSFhU55sH7KsA
	8UM/zn6zFep4CsKSgiTc/7CgH7OzwUmAsq+0A+voRJEDJ5Lg9Oh/SohJ0UaAjAhzw1ufTLN7H9g
	y+LG3ynQiSKKu7akNuTpTh9QH9ChCfC451J768I7G6Z+k9jWW8HCCDGsu/dV8pgE70oKEazSeLJ
	68R5zIjpviXGGjxaDKrKGdKcivPE4s7FvDoRrP7zrfHW5X/aHb5RkTQQkzKPO8BGwYzVMckhV0p
	QfwbeODRJTdE6eSsrSD+zsfwFQRG
X-Google-Smtp-Source: AGHT+IGwhC0z2f3fnnhVNzJ7UE+nzSJSaxsE09tBPhw1fP1SEI+vcUOTsYfQdfzDSf+dMhU18E7YL7sF1g4BX1ccC4k=
X-Received: by 2002:a05:6000:2303:b0:429:c14f:5f7d with SMTP id
 ffacd0b85a97d-42cc1cf3b24mr4341898f8f.29.1763779220753; Fri, 21 Nov 2025
 18:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <20251105090410.1250500-2-a.s.protopopov@gmail.com> <CAADnVQ+MmpDpSsQZW42K3nozcuM5yJMRRZRABjiTiybNQpBJRA@mail.gmail.com>
 <aQxx3Zphpu43l1/p@mail.gmail.com> <CAADnVQJmg17Z9jWWZ8ejCCNWcnSU0YeRiDHSp__+A0C8QtTMvg@mail.gmail.com>
 <aRnKXNPkENDiRcnO@mail.gmail.com>
In-Reply-To: <aRnKXNPkENDiRcnO@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 18:40:09 -0800
X-Gm-Features: AWmQ_bmjNXUKgSUmu8fuH-2IlaoYU3hUSFRGkxVXgEUCaYhAp5B6DnKaM4_r94A
Message-ID: <CAADnVQLTi6-jCxyGub3eQydf00238LuFdM2e_iXx=GtjZedKcQ@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 4:51=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/11/06 09:08AM, Alexei Starovoitov wrote:
> > On Thu, Nov 6, 2025 at 1:54=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > On 25/11/05 06:03PM, Alexei Starovoitov wrote:
> > > > On Wed, Nov 5, 2025 at 12:58=E2=80=AFAM Anton Protopopov
> > > > <a.s.protopopov@gmail.com> wrote:
> > > > > @@ -21695,6 +21736,8 @@ static int jit_subprogs(struct bpf_verifi=
er_env *env)
> > > > >                 func[i]->aux->jited_linfo =3D prog->aux->jited_li=
nfo;
> > > > >                 func[i]->aux->linfo_idx =3D env->subprog_info[i].=
linfo_idx;
> > > > >                 func[i]->aux->arena =3D prog->aux->arena;
> > > > > +               func[i]->aux->used_maps =3D env->used_maps;
> > > > > +               func[i]->aux->used_map_cnt =3D env->used_map_cnt;
> > > >
> > > > ...
> > > >
> > > > > It might be called before the used_maps are copied into aux...
> > > >
> > > > wat?
> > >
> > > It is called from fixup_call_arg() which happens before
> > > the env->prog->aux->used_maps is populated as a copy of
> > > env->used_maps.
> > >
> > > In any case, I will take a closer look and follow up on
> > > this after Kubecon (which is the next week).
> >
> > Pls look at the diff
> > and also
> > line 22074:
> > func[i]->aux->main_prog_aux =3D prog->aux;
> > line 22099:
> > func[i]->aux->used_maps =3D env->used_maps;
>
> [Sorry for the delay, I was travelling and didn't have access to my lab.]
>
> I've seen this diff and tested it before sending the previous reply.
> It didn't work, and it doesn't work now on bpf-next/master: the
> "./test_progs -a bpf_insn_array/deletions-with-functions" test
> still breaks.
>
> The reason is as follows. There are two cases for which JIT is called
> differently.
>
> 1) For a program without sub-functions the JIT is called from the
> bpf_prog_select_runtime() function. By this time
> aux->main_prog_aux->used_maps are populated and thus
> aux->main_prog_aux could be used; or just aux, as there is only one
> prog.
>
> 2) When program has sub-functions, say one, the jit is called from
> jit_subprogs() and later the call in bpf_prog_select_runtime() is
> skipped. The jit_subprogs() is called before the bpf_check()
> epilogue, and thus not func[i]->aux nor aux->main_prog_aux
> contain a copy of used_maps, it is only copied later.
>
> To make two cases look the same ("aux->used_maps is correct"), I've
> added
>
>     func[i]->aux->used_maps =3D env->used_maps;
>     func[i]->aux->used_map_cnt =3D env->used_map_cnt;
>
> Note, again, that in case 2, without this copy, no functions will
> have used_maps set, even main_prog.

I see. Thanks for explaining. That's one more reason to split prog and subp=
rog.
Could you please follow up with the patch to clear them back
after JITing:
func[i]->aux->used_maps =3D NULL;

it's not great to have pointers to freed memory sitting there
for the lifetime of the program. I suspect it might confuse
tools like kmemleak that simply scan 8 byte values.

