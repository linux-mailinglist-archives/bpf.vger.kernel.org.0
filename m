Return-Path: <bpf+bounces-73880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71152C3CC0B
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 772D24F4F38
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D0134DCDE;
	Thu,  6 Nov 2025 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvC3V9jI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0734403F
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448930; cv=none; b=F1FjEdzulDFJhxDqTpyisissnslyKnzy8xa8AJJpzqzF+/ZC3k0KS6J2m1rf3UvptS68qvc6f9Sg63ZE5m/mp7zHCNJj5jqfcP4WetlDJvBs/Xz4HrbMMk7PQ3n174GNWhfWj6nhGISABhlGmREOXwEL0QrbghoyhNcks2dftWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448930; c=relaxed/simple;
	bh=FiQEJZHhrgWbk6SdVOwzhO/6yyO4SwtDkkRFnnDVwIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQJZXF5KYw9PdtmzrkzGyUgjGhkygJd2FlgJrHzUCZ17vB22Kzrjw6Jswxtl2ISRVHnJ47bvIZfZuTeMlJofiAI5+JSvd204rFpA6zp6P08rdzN2Hm59Z15edtGw5UDK+yvOwT1ZcnPenRmkjmAWdkXe405AtbO4+KbFEdUor9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvC3V9jI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so891031f8f.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 09:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448927; x=1763053727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKYbclEruhZQm4cb2n/Yq4/t3+D+8hQeq1Nkcv2or2U=;
        b=CvC3V9jIFj6wc6LOa62Db8271DGeizCTrQ/av/u6ovkrqFqp+GUxO7QzuJ9roWSNMR
         aDOwoKyhHuIhusQI/EO8DdI4ASXv95zvNLg+kJagmVe06uLq5J6zh9i1ilVc1ku3yZ5U
         ENYlHm5nAnj5yvDgtVzvkrZ6pCZwHwNY89nkkE/t1hGvSjIfnW+bDFi59APqUF7CEv+9
         fGRS3cHveVX7GR1Il9k6gMRd0P4KAzOy2+yJQeWSI8WteUgh8mUXoiJxzgA1v1ww3vii
         IyjxuQ47P8fF8kk/DsO3aaZiq0mHBJG2EOAwQpBSyzEgGLMGTrsUB4kwX+VURYJ9OjzH
         D/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448927; x=1763053727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKYbclEruhZQm4cb2n/Yq4/t3+D+8hQeq1Nkcv2or2U=;
        b=gNf6KkDsFli8KGDMyyRzJUd5Mj1H/62jJqmXmtvjIFEm0KPfcr8e6g0rQI9zMA/6px
         53DRwBXEK0HAjWh1AaI9Hfnv8A8IKxEyR7S+lbYYC/QPqr9CqoUx4itKYAbKUfboS7Fl
         sVaG59HoACsC+YAr/xe8OjMk5kjWnlcQyA+LLlJQIA0XfaFT1zgrhlWSlDuXKceEU6mZ
         8SHhNStki4fps5ZnsTWW3Am3WM3ObT2AjqstDnuxKlj157fFGpQvW19oL9jMygLa80yn
         n0mK8jRHQuGPf0371Huq+lq7JSilcxHdOr5BPt9zRtUfy+ecu9qpme5qsc38D/GEfSa9
         zHiA==
X-Gm-Message-State: AOJu0YxyamwYPxBqO2S+ye8E6db0mv1Jzi3tSs0IhFry4RnmMiiBVFQv
	tYSIjNMg3NemqKtzH/TFe5WceAqTIzh4cDF5zLk3skY/SUQgm0PxnN7FmLRkfQZtYkLEwQ3U9Ai
	HBX1Klo56xX2ASYkKS8ovao10zysx9oo=
X-Gm-Gg: ASbGncsTQOIojERt33JMZviPl9JnzJ78p1AJvS2Ev8aG9fssQ/zDg9kvhkip55PKGZ8
	UurwhuIHfD5cljyzh/Fs9FJx00hkgnEjbf1p4O+CuFhW3o6IpxIENzefTxlKZqb9koV+vKfXcqI
	Z45dqi+VT/tUjpbXK/OUOtsVPCHyWJXV4gtRgGs4yfxBlzI7lendisLD6A/n3QRItOQRUmB8um4
	MSTiHVtzf4vMQtppQq5frA/fz/ID6FaC8ILzjYAwxIwmBD6dbANWHJ9wLfmQaTQnbJiq6JWqzsp
	Yn0Ohlc4Y7I=
X-Google-Smtp-Source: AGHT+IEZdzkXy8zo+iICLVyIwQ1aZacbsRfjmPMCMylXGRi2gugIQvTpb9uRjXg+2GnfnkgOB1XfR7jzwAxE4F875xs=
X-Received: by 2002:a05:6000:4210:b0:429:cba7:f773 with SMTP id
 ffacd0b85a97d-429e32e4853mr8592342f8f.19.1762448927249; Thu, 06 Nov 2025
 09:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <20251105090410.1250500-2-a.s.protopopov@gmail.com> <CAADnVQ+MmpDpSsQZW42K3nozcuM5yJMRRZRABjiTiybNQpBJRA@mail.gmail.com>
 <aQxx3Zphpu43l1/p@mail.gmail.com>
In-Reply-To: <aQxx3Zphpu43l1/p@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Nov 2025 09:08:33 -0800
X-Gm-Features: AWmQ_bm3dACkYppIqmqqU83ZavDjmJxXG6oTxITLUSddx1edFf9DoDyGsmZVKr8
Message-ID: <CAADnVQJmg17Z9jWWZ8ejCCNWcnSU0YeRiDHSp__+A0C8QtTMvg@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 1:54=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/11/05 06:03PM, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 12:58=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > > @@ -21695,6 +21736,8 @@ static int jit_subprogs(struct bpf_verifier_e=
nv *env)
> > >                 func[i]->aux->jited_linfo =3D prog->aux->jited_linfo;
> > >                 func[i]->aux->linfo_idx =3D env->subprog_info[i].linf=
o_idx;
> > >                 func[i]->aux->arena =3D prog->aux->arena;
> > > +               func[i]->aux->used_maps =3D env->used_maps;
> > > +               func[i]->aux->used_map_cnt =3D env->used_map_cnt;
> >
> > ...
> >
> > > It might be called before the used_maps are copied into aux...
> >
> > wat?
>
> It is called from fixup_call_arg() which happens before
> the env->prog->aux->used_maps is populated as a copy of
> env->used_maps.
>
> In any case, I will take a closer look and follow up on
> this after Kubecon (which is the next week).

Pls look at the diff
and also
line 22074:
func[i]->aux->main_prog_aux =3D prog->aux;
line 22099:
func[i]->aux->used_maps =3D env->used_maps;

> > on top of the set:
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > index 61ce52882632..97fcde6d7f07 100644
> > --- a/kernel/bpf/bpf_insn_array.c
> > +++ b/kernel/bpf/bpf_insn_array.c
> > @@ -278,8 +278,8 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog
> > *prog, u32 *offsets, void *image)
> >         if (!offsets || !image)
> >                 return;
> >
> > -       for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> > -               map =3D prog->aux->used_maps[i];
> > +       for (i =3D 0; i < prog->aux->main_prog_aux->used_map_cnt; i++) =
{
> > +               map =3D prog->aux->main_prog_aux->used_maps[i];
> >                 if (!is_insn_array(map))
> >                         continue;
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1268fa075d4c..53b9a6cee156 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -22096,8 +22096,6 @@ static int jit_subprogs(struct bpf_verifier_env=
 *env)
> >                 func[i]->aux->jited_linfo =3D prog->aux->jited_linfo;
> >                 func[i]->aux->linfo_idx =3D env->subprog_info[i].linfo_=
idx;
> >                 func[i]->aux->arena =3D prog->aux->arena;
> > -               func[i]->aux->used_maps =3D env->used_maps;
> > -               func[i]->aux->used_map_cnt =3D env->used_map_cnt;
> >                 num_exentries =3D 0;
> >                 insn =3D func[i]->insnsi;
> >                 for (j =3D 0; j < func[i]->len; j++, insn++) {
> >
> >
> > all tests still pass.
> >
> > If I'm not missing anything, please send a follow up.
> >
> > The plan is to split prog_aux into main and subprog,
> > and subprog will be a fraction of main.
> > Right now we copy more and more fields for no good reason.
> > Let's avoid this.

