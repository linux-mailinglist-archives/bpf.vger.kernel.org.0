Return-Path: <bpf+bounces-18921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F408782370C
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 22:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926E91F2551A
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989C1D6A7;
	Wed,  3 Jan 2024 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fID/+AY0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6601D691;
	Wed,  3 Jan 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so8685404a12.2;
        Wed, 03 Jan 2024 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704316891; x=1704921691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0iw+hpV8wxgrKsZGg0zSp1wRcZs0IBXJOFpUhcELjs=;
        b=fID/+AY0RC6GMJ95JpqXi0IZF792zZ4L534Dh9w29QH5RcaREhhVstKg4zga/zSFzD
         E94cJUlCEYJDDmLkz6SKdWXrVXxSfHwzaFMoAdNAtBkbxke9tnmonHgahlvQPjt57637
         rCU9tvGDKhDtI7Bt3sp2//tX1cBEt14ALHhUJdGxizbE7dRzF5x+L0Uz7v47FcZgVoCo
         jptN/uhcNMdyY1ktk5kJ6w453hP3Hm1mlNVA1p0XC8CPsHMyjNFIK+G5ODjHSDoUT2CI
         YB2jHSFLKeg/Bo64qbEuz0iD23Li+L3nlXMycMZzqXnFl1Owvr6/7EA5HmCLF0NrpUwS
         dV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704316891; x=1704921691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0iw+hpV8wxgrKsZGg0zSp1wRcZs0IBXJOFpUhcELjs=;
        b=ndMt4Mi6pcwDdtSpHVERs+aRMj/ObD1+F0xm0eoau92y99esuueJ4b3f0l0oe3gKuJ
         A55nMYJrD1VevMEHQj92FQkcWA3NF/2MvkRk4WESK1bwTATGVD++ZVG7W39LwDy2FCea
         JJATt1hpkxikrh3M7OBx/9uiRKK0p4l51NixFadUVrS7/+YhTWdtdlRsFr2lxeZElzuV
         RYbwXobVmT1CNUuoZ5mb6+dmkECw3F5Wrmeg7fxIA9tZ6ZrGu4Jn6aThXuL7oyAyd631
         OciiENXh7qQDRlu+1aky/IVR9tRkJ0GCAgJ/yEMDFPA+f32L6ofKl2GLjE2BmuJbFYEI
         hiyg==
X-Gm-Message-State: AOJu0YzdaF1D16udspU/Xr126xnE7//vbJj0S77vAqDQGYQcPbyhkUQ6
	ZAxN0RkL0PaoBIYwpjEUfkV+zB7pven3TDpv3Lw=
X-Google-Smtp-Source: AGHT+IHs1go4eM8Hlfr9OWmizhOyKEPp1wiBjH9nIBRz0xyFBEGIT50lK4DM1ZpMk0L/BfyytV1V1m1F5jWPlB6/3xk=
X-Received: by 2002:a05:6402:3888:b0:556:38d5:b38a with SMTP id
 fd8-20020a056402388800b0055638d5b38amr3635924edb.54.1704316891184; Wed, 03
 Jan 2024 13:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103153307.553838-1-brho@google.com> <20240103153307.553838-3-brho@google.com>
 <CAEf4BzbKT3LbHQSFwpAfoJuhyGy2NpHk7A6ivkFiutN_jnKHYg@mail.gmail.com> <bedf07d1-2cd5-4bc8-9e59-a96479a7ff14@google.com>
In-Reply-To: <bedf07d1-2cd5-4bc8-9e59-a96479a7ff14@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 13:21:19 -0800
Message-ID: <CAEf4BzauYF4DoQLV6AGfFcq3VgP2yi_Pd6pg2vj2Eb7Rt7j0Pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add inline assembly helpers
 to access array elements
To: Barret Rhoden <brho@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 12:06=E2=80=AFPM Barret Rhoden <brho@google.com> wro=
te:
>
> On 1/3/24 14:51, Andrii Nakryiko wrote:
> > I'm curious how bpf_cmp_likely/bpf_cmp_unlikely (just applied to
> > bpf-next) compares to this?
>
> these work great!
>
> e.g.
>
>          if (bpf_cmp_likely(idx, <, NR_MAP_ELEMS))
>                  map_elems[idx] =3D i;
>
> works fine.  since that's essentially the code that bpf_array_elem() was
> trying to replace, i'd rather just use the new bpf_cmp helpers than have
> the special array_elem helpers.

ok, cool, thanks for checking! The less special macros, the better.

>
> thanks,
>
> barret
>
>

