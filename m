Return-Path: <bpf+bounces-77554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69998CEAFB3
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 02:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93B123007483
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 01:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EE31E1A3D;
	Wed, 31 Dec 2025 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FkUQIdZL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285CA1C2324
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767143633; cv=none; b=uC05wgLl7EVDs/Pec9wRTUS5NOaO22h5Uaq1j9OiroAg8qsr42sSupOQur/sKPH45x8ICrZcspHU/pcaEfVZqXZV4w3roC+IVYTNS1+mPtkR4Yx1l3Yyxyz+5Kvm97iBNogrm+FTR26Dc+CbkgkVP2t+h7KBiK5Evc4f9peR1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767143633; c=relaxed/simple;
	bh=BHc1lKJE0Lxu8JAlx2hMuiUWIwahFQkcP5p8tpc37Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBzA6WUx7G8Z9ymZ11jeC3A0e85LYrLrWc3sVC94wfec2P0fmOhKM3+qWGxIT5HbHhRQ3n0/X3yewWb9cMUbpeTA3z4LerHzt1ua7MfSgkIWQN96Fg6Kz4l5FcqjlypDlkJKKmsq2xZCiTjVwBYb0JVytxYelvG4fAVE5OFI6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FkUQIdZL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34ab8682357so1075178a91.2
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 17:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767143631; x=1767748431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq10vCygZW6CW+x1mvjXSGXGpQ8JcmNGWdgXeJyge+c=;
        b=FkUQIdZLN6MLUkjYeObh5dGVZlB7LDBNdHC7Ed2TVSapP9ayhg5tglH1wq99VE8pr4
         HdMv8gHdf3iyvtd/0IvGs4qve2DKJ8ZTCRfLRUwK7vlCAEcLvAheFSthpuKI6MvmgyLI
         5529D6cOIR+GiiI+ChCNRALzr1aCYINTrf5MskMteOYXmNuverXWGIsd0rf5tvD/ENJV
         3yU6I8NdpNBaMx9N4x/FeTLZl4G0ncMtwBoC7QdBzfi14KONyQiP8RUQdVubxCaF0d6J
         58xW5uT0ED1vnSvtbsr8CdyJ6lHMRE3IDoEpx5Jc3L+VzvuwRdghGjiGT+yJvEK09Wfx
         CeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767143631; x=1767748431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zq10vCygZW6CW+x1mvjXSGXGpQ8JcmNGWdgXeJyge+c=;
        b=PsatOYTS/GY/FNbXYDbmXUs1II7f69ZxXIkrZyX5r8+K+YuEPku7jUqn2m+YWgCvur
         vZzGBnjIOOM7tih8d1m1u0BvLjIK9lAswvEAbgmcPEWkBXQOG2YEhlNiGIsNCkOoUQ/Z
         LnRJTSJeEHuEw8++EcjzrTyRO1PJreOdAss/+cLs/222CbjN1O3mRv9qo6eJeLrnU+T8
         uaRkmaGmnplX4mp5t3YFJavDvg7FIn6Zi68S7K9mPSuv4u8WrM2lPQpcNrNjml4lcJI9
         sV0aH/w/SdAzboB6+6xlbnQ3ti0g4ZhyeEjuQPSndsWscb+1iEehEQ5lHZY8CxLlvEx/
         yMPA==
X-Forwarded-Encrypted: i=1; AJvYcCUWPYZgGs7dmvi03Mb1+33cndD7PL867O/ICGQbdFh1YZahOag62JFHalL81RqpJypLUPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqi/n8zxWC+GhReQZv1LVs54XQnCI96wcIT/0gDqWhcrr8FTtc
	dJMcfjgpX6qc5FzA2kay8vg7mKn4pnpqRvXvKGaUeE/+iTzCGU7yXjGMBQ6rmCG5waUBIpVqiHb
	BN2Mm3x2XXonyeoHt5qDFBmhE4YSG+rGP5FawOPRwOUTR1kDaq1Qq
X-Gm-Gg: AY/fxX6e6Td3qR5cy++aBe5un1j6ngsRpbzQylN/xoXzfeY5yLRq5i271s2Np1gaBkI
	U/bh23tnf+A4ooSrBaEusl0CX0VJiZnTGbM6JiCPSUU86GJaf/8Z6n78CluzXILHc8zQyyCeF17
	MZQN9SYuV4j7M7d2jze/1co2xdDsVX7XeUXebdCv+25izEDGwLdLaa1AjxHLRjpMXNjT3pu1EMu
	gCHseF6aYF06uQzGBWHW3XvPxgbmq5/7PmKPs7zCQtUbGcjFUSkTjHvg8ZVsWgo35/aiQANc2Fs
	qgdVZlI=
X-Google-Smtp-Source: AGHT+IGnvMYgLoUGqsdwvwcCTmeb80f7fpsbnkwKmZCezaIlRVuiT4QB92DpekjrbVoFg73H82rkpFpgzOai8JtsV7M=
X-Received: by 2002:a05:7022:3718:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-121722efb56mr12235293c88.4.1767143631160; Tue, 30 Dec 2025
 17:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104162123.1086035-1-ming.lei@redhat.com> <20251104162123.1086035-2-ming.lei@redhat.com>
In-Reply-To: <20251104162123.1086035-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 30 Dec 2025 20:13:40 -0500
X-Gm-Features: AQt7F2o-Y_rqaK5zCZt0RytXUMHSDtgxGJhRCzo2ZGnMMj7QX-y9iFE46-9NNDY
Message-ID: <CADUfDZoTWvDspuyLRsHXZRa3D__dffyAptF=BpaF+h6pREbPug@mail.gmail.com>
Subject: Re: [PATCH 1/5] io_uring: prepare for extending io_uring with bpf
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 8:22=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add one bpf operation & related framework and prepare for extending io_ur=
ing
> with bpf.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/uapi/linux/io_uring.h |  1 +
>  init/Kconfig                  |  7 +++++++
>  io_uring/Makefile             |  1 +
>  io_uring/bpf.c                | 26 ++++++++++++++++++++++++++
>  io_uring/opdef.c              | 10 ++++++++++
>  io_uring/uring_bpf.h          | 26 ++++++++++++++++++++++++++
>  6 files changed, 71 insertions(+)
>  create mode 100644 io_uring/bpf.c
>  create mode 100644 io_uring/uring_bpf.h
>
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
> index 04797a9b76bc..b167c1d4ce6e 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -303,6 +303,7 @@ enum io_uring_op {
>         IORING_OP_PIPE,
>         IORING_OP_NOP128,
>         IORING_OP_URING_CMD128,
> +       IORING_OP_BPF,
>
>         /* this goes last, obviously */
>         IORING_OP_LAST,
> diff --git a/init/Kconfig b/init/Kconfig
> index cab3ad28ca49..14d566516643 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1843,6 +1843,13 @@ config IO_URING
>           applications to submit and complete IO through submission and
>           completion rings that are shared between the kernel and applica=
tion.
>
> +config IO_URING_BPF
> +       bool "Enable IO uring bpf extension" if EXPERT
> +       depends on IO_URING && BPF
> +       help
> +         This option enables bpf extension for the io_uring interface, s=
o
> +         application can define its own io_uring operation by bpf progra=
m.
> +
>  config GCOV_PROFILE_URING
>         bool "Enable GCOV profiling on the io_uring subsystem"
>         depends on IO_URING && GCOV_KERNEL
> diff --git a/io_uring/Makefile b/io_uring/Makefile
> index bc4e4a3fa0a5..35eeeaf64489 100644
> --- a/io_uring/Makefile
> +++ b/io_uring/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_NET_RX_BUSY_POLL)        +=3D napi.o
>  obj-$(CONFIG_NET) +=3D net.o cmd_net.o
>  obj-$(CONFIG_PROC_FS) +=3D fdinfo.o
>  obj-$(CONFIG_IO_URING_MOCK_FILE) +=3D mock_file.o
> +obj-$(CONFIG_IO_URING_BPF)     +=3D bpf.o
> diff --git a/io_uring/bpf.c b/io_uring/bpf.c
> new file mode 100644
> index 000000000000..8c47df13c7b5
> --- /dev/null
> +++ b/io_uring/bpf.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Red Hat */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <uapi/linux/io_uring.h>
> +#include "io_uring.h"
> +#include "uring_bpf.h"
> +
> +int io_uring_bpf_issue(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +       return -ECANCELED;
> +}
> +
> +int io_uring_bpf_prep(struct io_kiocb *req, const struct io_uring_sqe *s=
qe)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +void io_uring_bpf_fail(struct io_kiocb *req)
> +{
> +}
> +
> +void io_uring_bpf_cleanup(struct io_kiocb *req)
> +{
> +}
> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> index df52d760240e..d93ee3d577d4 100644
> --- a/io_uring/opdef.c
> +++ b/io_uring/opdef.c
> @@ -38,6 +38,7 @@
>  #include "futex.h"
>  #include "truncate.h"
>  #include "zcrx.h"
> +#include "uring_bpf.h"
>
>  static int io_no_issue(struct io_kiocb *req, unsigned int issue_flags)
>  {
> @@ -593,6 +594,10 @@ const struct io_issue_def io_issue_defs[] =3D {
>                 .prep                   =3D io_uring_cmd_prep,
>                 .issue                  =3D io_uring_cmd,
>         },
> +       [IORING_OP_BPF] =3D {
> +               .prep                   =3D io_uring_bpf_prep,
> +               .issue                  =3D io_uring_bpf_issue,

Should this set .prep =3D io_eopnotsupp_prep for !CONFIG_IO_URING_BPF
and remove the stub implementations? That would be more consistent
with the other opcodes when they are configured out, and ensure
io_uring_op_supported(IORING_OP_BPF) returns false for
!CONFIG_IO_URING_BPF.

Best,
Caleb


> +       },
>  };
>
>  const struct io_cold_def io_cold_defs[] =3D {
> @@ -851,6 +856,11 @@ const struct io_cold_def io_cold_defs[] =3D {
>                 .sqe_copy               =3D io_uring_cmd_sqe_copy,
>                 .cleanup                =3D io_uring_cmd_cleanup,
>         },
> +       [IORING_OP_BPF] =3D {
> +               .name                   =3D "BPF",
> +               .cleanup                =3D io_uring_bpf_cleanup,
> +               .fail                   =3D io_uring_bpf_fail,
> +       },
>  };
>
>  const char *io_uring_get_opcode(u8 opcode)
> diff --git a/io_uring/uring_bpf.h b/io_uring/uring_bpf.h
> new file mode 100644
> index 000000000000..bde774ce6ac0
> --- /dev/null
> +++ b/io_uring/uring_bpf.h
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef IOU_BPF_H
> +#define IOU_BPF_H
> +
> +#ifdef CONFIG_IO_URING_BPF
> +int io_uring_bpf_issue(struct io_kiocb *req, unsigned int issue_flags);
> +int io_uring_bpf_prep(struct io_kiocb *req, const struct io_uring_sqe *s=
qe);
> +void io_uring_bpf_fail(struct io_kiocb *req);
> +void io_uring_bpf_cleanup(struct io_kiocb *req);
> +#else
> +static inline int io_uring_bpf_issue(struct io_kiocb *req, unsigned int =
issue_flags)
> +{
> +       return -ECANCELED;
> +}
> +static inline int io_uring_bpf_prep(struct io_kiocb *req, const struct i=
o_uring_sqe *sqe)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline void io_uring_bpf_fail(struct io_kiocb *req)
> +{
> +}
> +static inline void io_uring_bpf_cleanup(struct io_kiocb *req)
> +{
> +}
> +#endif
> +#endif
> --
> 2.47.0
>

