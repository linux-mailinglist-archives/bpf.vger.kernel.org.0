Return-Path: <bpf+bounces-53251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F197BA4F03C
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 23:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE721188D1C6
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCC2780F3;
	Tue,  4 Mar 2025 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOGi7DLT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996672780E4
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127087; cv=none; b=IY1/Q09u5CoTF62qHvPfGVyvQXmvvtLgOLs93KnhsfL8/Kdld5O0sReifTNq3ClCwiDwy+eL6gUK79k9HfjDT35eD8zhs3XD4Sv4ABL4LgymSbqFpQIdMZWCP/lOBDqfATUyoHyCw2I4UziBPb5YhAQDQa5HiKL7CQheYNDxG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127087; c=relaxed/simple;
	bh=4kQveEt/4bfBSYfOnOo0P/ixp1hpKu8fUzk0410V9Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JA7Tswk1YG+diJNjfY9kaG5lVDx0zBt1sc4Et1VCWouq4yOAry3X0RUebkltI9xfvDNqTPR57H8k2mePs186zkbb88uxHCPV5Lf6rhaqY/kh0kwyZ/3c8gd1D0IPnPIAu6d1IvqQLjdlZZrm5dDyTl2zGcjoGSX1uq6UYgBk/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOGi7DLT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2239f8646f6so62258115ad.2
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 14:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741127084; x=1741731884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8bKnLGaVdLiTlW8QIBv3dZQr08bZYKnLGeGst1RLpw=;
        b=kOGi7DLTQwQK9i/LqEQ0jtIk+94m6KEAHAFUqFZioKIUTlowCoBq6bUka7Z75bRJlE
         AjuGsAjibRBAo/LuzMs96f8zdAP645Fnom7G5H33WG8AR5T+iZQkFGG8GFmrOpEl73MY
         ktPIYHW3Tjht5FFqrjrNa5wT708XB0cOUkBS+OJR/8a8G3WnFrgiyYRCGB0+GyIRbSEY
         iPb6+lv97BkNFkFbcklzWKBjOwvLaI7Au30hpX4TPyP//659qGSJqsByNDkRAfH+G2JC
         aV9UPEYnil6c9WrNkng1c/Muj5jSE+6jPdWpcjQZ9EcBes7mqaxMlRF35zX2GrF+DaqK
         J0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741127084; x=1741731884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8bKnLGaVdLiTlW8QIBv3dZQr08bZYKnLGeGst1RLpw=;
        b=gQ5h7TYxO/As+n9UmoH34GTWbgDKvdoIFA0TN1xMc5RW1vhrLSLqilqNRykNFSHHah
         xjepHW75UhQjyj3RmheNDfLyN/W01FSQU0PYW2BO9G+2LSGlydipNa7pY2BDjVF3gbHU
         VF9hcFREEn7vFT9huuCyNem/+dO8dAuL9aq83TVzNbw/3pwceRMW5lbNENUdnL8yCJUg
         cbiKJIiWenMA9jHlKg9VIIW6JAC3phncY//ZaqCAYZdFWBoAeYUbK5hJ8E4D7cVu7Kjq
         yKQe/ZQFEVUy4tDGsf+qAZCKa0voHB7HziEflPp7WZb3n/r1/e0zFtOHQ10GEcCUhBo9
         tKBQ==
X-Gm-Message-State: AOJu0YyaEMub/qF896ZvEYkoAgzghHYnmR+ZCA6iJmdmJ3nyK67zidzl
	6EEZz2jXSCu2s9uhMNC/TtTwWYSSCt37LwX+udkZDygOwTFH6e9kXQCv7VhBSWPwA6AThUQiQ4p
	1+1oik5EgOPeyNcjyIrIcn2qaLYQ=
X-Gm-Gg: ASbGncvsLRHu5FqsryO4DU6SDX1kD6NxK5dhOYvRiypyjYgC0mUef8feRKRpAa0XpKr
	CyKnAcQlPm69D3UQwbQaSoycluo7SQ8EQGjv44A5c4zeJzN76ySocjF28zX/SNj89vLOSJDdClP
	NK7MWWPTA+Y4TrsRAgTnHwFs16VAHNreDHXpBBqIAjPQ==
X-Google-Smtp-Source: AGHT+IFkMYFt4S/B1q1+mY6YPSWQCXjLEhVTELOJAEC8ntfBuus7FWG5nbgd9lA2lefj1YUGLFQltLEMgQSOwqMSjRE=
X-Received: by 2002:a17:902:e84a:b0:220:faa2:c917 with SMTP id
 d9443c01a7336-223f1cf205cmr12652115ad.34.1741127083916; Tue, 04 Mar 2025
 14:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com> <20250304211500.213073-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250304211500.213073-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Mar 2025 14:24:32 -0800
X-Gm-Features: AQ5f1JqxHPiVWFKcfdQ3bTTsCCLLQakMwrqYZHvRIqEgqJQs3bf-TkyTAyH8_mQ
Message-ID: <CAEf4BzYZSXk-_WQGMNJgeSDotMqRYZKvkOyeESitwpLEQ4PmGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: test freplace from user namespace
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:15=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add selftests to verify that it is possible to load freplace program
> from user namespace if BPF token is initialized by bpf_object__prepare
> before calling bpf_program__set_attach_target.
> Negative test is added as well.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../testing/selftests/bpf/prog_tests/token.c  | 94 +++++++++++++++++++
>  .../selftests/bpf/progs/priv_freplace_prog.c  | 13 +++
>  tools/testing/selftests/bpf/progs/priv_prog.c |  4 +-
>  3 files changed, 109 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.=
c

[...]

> +/* Verify that freplace works from user namespace, because bpf token is =
loaded
> + * in bpf_object__prepare
> + */
> +static int userns_obj_priv_freplace_prog(int mnt_fd, struct token_lsm *l=
sm_skel)
> +{
> +       struct priv_freplace_prog *fr_skel =3D NULL;
> +       struct priv_prog *skel =3D NULL;
> +       int err, tgt_fd;
> +
> +       err =3D userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &=
tgt_fd);
> +       if (!ASSERT_OK(err, "setup"))
> +               goto out;
> +
> +       err =3D bpf_object__prepare(fr_skel->obj);
> +       if (!ASSERT_OK(err, "freplace__prepare"))
> +               goto out;
> +
> +       err =3D bpf_program__set_attach_target(fr_skel->progs.new_kprobe_=
prog, tgt_fd, "kprobe_prog");
> +       if (err)

if (!ASSERT_OK(err, "set_attach_target"))

> +               goto out;
> +
> +       err =3D priv_freplace_prog__load(fr_skel);
> +       ASSERT_OK(err, "priv_freplace_prog__load");
> +out:
> +       priv_freplace_prog__destroy(fr_skel);
> +       priv_prog__destroy(skel);
> +       return err;
> +}
> +

[...]

> diff --git a/tools/testing/selftests/bpf/progs/priv_prog.c b/tools/testin=
g/selftests/bpf/progs/priv_prog.c
> index 3c7b2b618c8a..be9deda38b52 100644
> --- a/tools/testing/selftests/bpf/progs/priv_prog.c
> +++ b/tools/testing/selftests/bpf/progs/priv_prog.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */

you don't need to update copyright year when updating the file, just
leave it as is here and above

>
>  #include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
> @@ -7,7 +7,7 @@
>  char _license[] SEC("license") =3D "GPL";
>
>  SEC("kprobe")
> -int kprobe_prog(void *ctx)
> +int kprobe_prog(struct pt_regs *ctx)
>  {
>         return 1;
>  }
> --
> 2.48.1
>

