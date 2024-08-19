Return-Path: <bpf+bounces-37554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C799577F4
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C178B24D6D
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E3A1DF67B;
	Mon, 19 Aug 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWM2k9/L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3D1DC481
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107325; cv=none; b=LKy5kc6DGMWyq7Gt7JEYR7xaL8xWJH79bvOp4coSS/V+H13ljiortf3PEwlYsjIOgY0iR8+dwQtMVzWXNfI9e+aX3M0OH5+BrDL64wd43yjWSQcgf5mWdh2uU5m+NQXCZ9fR7mgh7vne80q8sK1KPgY3w77Sp5cJ1FdczHvPAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107325; c=relaxed/simple;
	bh=jw0v/UB0QV9yq8RLFz0CsyLK7aYBKZz/RGFqG5G2pxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhIdFdJXZTsWziUnxunllNzqXpK89sENd9yMX1vZFQZAyM1hXhNq9epkfHELC+vnS5eJZHxu0Oj+aCLN6+p1EMJWE4i5MxH8ZLp8IY1xPjHBdZR3UPknuJcAMm6PUEEFQz8xGJNn5GVA5HSDqq8iOd2wo5f5mGGISeulHJosJmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWM2k9/L; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so2841241a12.1
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724107323; x=1724712123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAVM9iqrWGjPqnfO8Ys7mOW1MlLbVISkYO7K/L6iqKk=;
        b=OWM2k9/LuHeF1KMKiQvvUW7MI54cdAjmc/X412DqkMuhfjtsKSl8CAfQjMwQ+mKuxN
         +8lxcXIH7qvHAYQ6t8beaSq/Geh2noxyzoIfBVTy8xwErVKAypbfTmufQMtAOXRuUXQ+
         0+WrkbB3bI/clkMhSRUW/24kSc7xkVvh0nerSJ9A+TyqnfEZf+ptBZQVUt2HBACzzive
         wux0RyhkeDDyFAUONB7bOztVY0C2TNM1hlxctoJQb2tHGAUi8U7Jaq/A68KxWUa8r/Qm
         PWriKOSWBgix0jDPxE17n95wi1129UUp6S4tTQxovAX6okwmI/oXFe3VL3yq/PBd+LQ/
         gViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724107323; x=1724712123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAVM9iqrWGjPqnfO8Ys7mOW1MlLbVISkYO7K/L6iqKk=;
        b=cAtOaFg1mDqo3gw1EDTs3lrxrKHAGWBEMigEyvF/7wzkm0/BMQkGz6ij6piZ8AvB+e
         OrFRuxiS9kJIazYHsDOqcAUpfZiSjgl3uP0JZCTGsX0m3g4y8Huj/3iJa4zy4ZwwLTC/
         dm6GMJOxLzOnLf1SJpEP4j2PynVxsJkRUcIei5iTNj68Jto4NlugqzG/f5/pfTKoC9dO
         jUN1OtebVHP9DUW4OaZnWl+/9vdtpoa16xIGCVYE8lJ+IrstpKD246YKnvSvPVKTX6Bs
         2PS64KHvRFfC5ATOGd9S9ojYM6TY0RGj3Jv2iLw8x39qHO9HvXEsmCt95vA3kDTnOWKe
         d6/Q==
X-Gm-Message-State: AOJu0YyYU8rhfL6yPtBbn00yNXsqWd9Oj/ZtqPFnewcLT3loRgrdcEZ4
	B7WyNEeMUoyIf5LFCPCiqzaj1Hr8NAc4x5vr+7pf28Ii21XyOHQqHOQXBV6/pQ+OudvEBsRR5D6
	SAewjyruAA4Lk/tjkpbo0oVEcn58=
X-Google-Smtp-Source: AGHT+IEgybSLbLmzhuRqii0QUflOUoAHV9reRlt/hlqWSt5/XIG1MhaenNhLfn7/Z0MqMmhLzjYcBqvmaqyLtWKEBn8=
X-Received: by 2002:a17:90a:f001:b0:2d3:c87e:b888 with SMTP id
 98e67ed59e1d1-2d3e00f10bamr11292057a91.27.1724107322931; Mon, 19 Aug 2024
 15:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818002350.1401842-1-linux@jordanrome.com> <20240818002350.1401842-2-linux@jordanrome.com>
In-Reply-To: <20240818002350.1401842-2-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Aug 2024 15:41:50 -0700
Message-ID: <CAEf4BzZD0O835HqkJ7vbHHGtJdab3JpXRSsiPF1dA0q=A5tgpg@mail.gmail.com>
Subject: Re: [bpf-next v6 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 5:24=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> This adds tests for both the happy path and
> the error path.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   |  8 ++-
>  .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
>  .../selftests/bpf/progs/read_vsyscall.c       |  9 ++-
>  .../selftests/bpf/progs/test_attach_probe.c   | 57 ++++++++++++++++++-
>  4 files changed, 68 insertions(+), 7 deletions(-)
>

Thanks for adding more test cases! See a small nit below, but otherwise LGT=
M

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

>
> +static __always_inline bool verify_sleepable_user_copy_str(void)
> +{
> +       int ret;
> +       char data_long[20];
> +       char data_long_pad[20];
> +       char data_long_err[20];
> +       char data_short[4];
> +       char data_short_pad[4];
> +
> +       ret =3D bpf_copy_from_user_str(data_short, sizeof(data_short), us=
er_ptr, 0);
> +
> +       if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_short_pad, sizeof(data_short_=
pad), user_ptr, BPF_F_PAD_ZEROS);
> +
> +       if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), user=
_ptr, 0);
> +
> +       if (bpf_strncmp(data_long, 10, "test_data\0") !=3D 0 || ret !=3D =
10)
> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_long_pad, sizeof(data_long_pa=
d), user_ptr, BPF_F_PAD_ZEROS);
> +
> +       if (bpf_strncmp(data_long_pad, 10, "test_data\0") !=3D 0 || ret !=
=3D 10 || data_long_pad[19] !=3D '\0')
> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_long_err, sizeof(data_long_er=
r), (void *)data_long, BPF_F_PAD_ZEROS);
> +
> +       if (ret > 0 || data_long_err[9] !=3D '\0')

shouldn't the condition be something along the data_long_err[0] !=3D
'\0' || data_long_err[19] !=3D '\0' to check that the entire buffer is
zeroed out?

> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), user=
_ptr, 2);
> +
> +       if (ret !=3D -EINVAL)
> +               return false;
> +
> +       return true;
> +}
> +

[...]

