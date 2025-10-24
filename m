Return-Path: <bpf+bounces-72002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E4AC04E7E
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 10:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0173AB79B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDC2F39A1;
	Fri, 24 Oct 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi2oG8yn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84926FD84
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292564; cv=none; b=OTdP0MNDrTidzR04MZPjYrcp5dA08RAgLxv6GbBwfXzSrmFmXjhe0xyCfUDhTSANMtp7R40FMnzi1uVQETHRcbCwz7KrYIFzPnf7TTS/HxkmjDYd/QIfboncFAUcj+oTUWq+eVAoz69GIMxtG8jnQwZ6RlygmXSb0d+V/njTFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292564; c=relaxed/simple;
	bh=ijNMXAGHEloq3MWzjWdu519b1yKZRu4keumrCc47LMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuaLAbVFj4o5XSqsGcT8FBlwr2wKP6+Fs1CZK3yT2XqDtGwBFjwq/95vzFt7J0+bD9zW1qvbduCx6NXBejGR9oQKjh1Vktbu6b8xnZ1ggxjHgQpNvQfZV9qcnPm6iM++2dNDpQZSO1aoCEtJfnJGSXvzCUPYhlJn18IxMNK/rYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi2oG8yn; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso1211055a12.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761292562; x=1761897362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uRO27mPvjlq1Gmjws1js7XoJW9NFcThjF4sz95gEPw=;
        b=Wi2oG8ynRH1k1lgIQ71f+1CprFEpH9ecIGdu3xd/Q81yEbkWTBH99pkyABzXrCsrij
         LN5M4UZo1GWEFLDZSTtJPLfEVtpoONf2DvLUunyig7RC/G+YUk0Bgo02jtFoH2pCgGnj
         5St9w2GjiDJ3ZHS+xkgKAqGjB7eA15it6W5/JoMVN1gTj1qSd62GS4lZOru1ApZ62Snj
         rTiOSrLzIr+uxdqEzp4bNjgBw6joSlI/1YF+5BLFLKvV2oiPxKCHSjgObeZ05BamESLU
         7Q0YOR4s2hwOJ/MKC87ImQgxRkUiyCQDpHIJkQWq/jjtSBPQ5dX/Gb0S+7QFx8Z+Jhbk
         xeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292562; x=1761897362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uRO27mPvjlq1Gmjws1js7XoJW9NFcThjF4sz95gEPw=;
        b=NzEzbwgWI1jBSPmA1O6ohxkCN0kGlci7diI18/inTJK5O+pn+Z1oyqp4KQ4+JM+MdP
         Sdiz/Ze7kAWJXrSKPIg3Yi9SApxQsS3+GWuOhv9T7y88N8WlIDuaIxIS/jp8geLsYCiC
         +/FtWHoo06lxoLcIP3nKqNF5soRSHWe0/9QXxVfgZSDp+5VHloMnJ2VjWYDodmTJd6Cn
         Lb1MoaGTdf1lFcT79Am5/mcC4e3hteft+/PtyE32j/9yP9OkZpfaB9Swdsxu7jIiBqII
         0c0LNa7yj8t3pjnaJi6BsSnRrDZI1IFu1z0hUJA+PP5tAE5EmldxgP8MIMK4byqwygNe
         rGrw==
X-Forwarded-Encrypted: i=1; AJvYcCV1VsA9OUFXbJgpaOz4diSUgxJTyFoapeHz/Jop0y5HccePM1cLV3Aw5YsoZuxfJjuKJ1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfdaDKPlrb6x9FYe3sFXmYzWzivNzUF3iy9Yom7Ys82stsv8x
	UZIUfTwLJ1dZHKp6QdZYBPyKofq+ekzjqiT1vD9NN0D9OnvauaqWMLOTpoar4XnASByQz2LN6aL
	MNhUV5ey4lqF8v6/ZIynVaFVBE0TijHU=
X-Gm-Gg: ASbGncsL8FqMv2UnwKDzoZvAL0tn8xAfBTYUl0pnqninkCxerdce7E6pt1G4BUEhIVB
	jD3gxzGvO/EaePWeY8ZOu/4DLjtBHHLOjySldmmXK5siS9jLJAJVlP/2hcSXR9d9i4TpJzvBffK
	yfXh5S5FOjH/Xb/i9x1dASdd6AoYDMlleODwzts6aI7orGAyfFz5w99luT+GQ6bTMzg/OOJxWjb
	lF3FlqMkYPJDqyEMFQW4l9SRhg9XXay9ugw8f95BUreI9sLKIny46SamJ2UMBZu1clm4SQ=
X-Google-Smtp-Source: AGHT+IHK8ra9yfzuc4UzCuPOPCF0a9fkZ6OHOYa7+1mzZSw8cgx/k2AvqlS08ZKXCgOl+bU90FQCGSikyL5fPfxHaF8=
X-Received: by 2002:a17:902:c411:b0:249:71f5:4e5a with SMTP id
 d9443c01a7336-29489e619a7mr22649315ad.26.1761292562492; Fri, 24 Oct 2025
 00:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024060720.634826-1-jianyungao89@gmail.com> <aPsjSZtNxeQK239J@krava>
In-Reply-To: <aPsjSZtNxeQK239J@krava>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Fri, 24 Oct 2025 15:55:51 +0800
X-Gm-Features: AS18NWBZaG0Ysv0zopji-OZrXuo35dlHz4dN9X8MiEYrk2THM63xKhszYGw9le0
Message-ID: <CAHP3+4Dg7aBqaVWs5vfydtWuSpuRS+p43XNJk9TwxAPrVm=7NQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: optimize the redundant code in the
 bpf_object__init_user_btf_maps() function.
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, thank you for your review. And I have realized my mistake in
this patch. I will fix it in the next patch!

On Fri, Oct 24, 2025 at 2:57=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Oct 24, 2025 at 02:07:20PM +0800, Jianyun Gao wrote:
> > In the elf_sec_data() function, the input parameter 'scn' will be
> > evaluated. If it is NULL, then it will directly return NULL. Therefore,
> > the return value of the elf_sec_data() function already takes into
> > account the case where the input parameter scn is NULL. Therefore,
> > subsequently, the code only needs to check whether the return value of
> > the elf_sec_data() function is NULL.
> >
> > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b90574f39d1c..9e66104a61eb 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2988,15 +2988,15 @@ static int bpf_object__init_user_btf_maps(struc=
t bpf_object *obj, bool strict,
> >       int nr_types, i, vlen, err;
> >       const struct btf_type *t;
> >       const char *name;
> > -     Elf_Data *data;
> > +     Elf_Data *scn_data;
>
> makes sense to me, but this rename breaks compilation later on
>
> libbpf.c:3027:53: error: =E2=80=98data=E2=80=99 undeclared (first use in =
this function)
>
> jirka
>
> >       Elf_Scn *scn;
> >
> >       if (obj->efile.btf_maps_shndx < 0)
> >               return 0;
> >
> >       scn =3D elf_sec_by_idx(obj, obj->efile.btf_maps_shndx);
> > -     data =3D elf_sec_data(obj, scn);
> > -     if (!scn || !data) {
> > +     scn_data =3D elf_sec_data(obj, scn);
> > +     if (!scn_data) {
> >               pr_warn("elf: failed to get %s map definitions for %s\n",
> >                       MAPS_ELF_SEC, obj->path);
> >               return -EINVAL;
> > --
> > 2.34.1
> >

