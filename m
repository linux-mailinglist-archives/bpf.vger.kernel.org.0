Return-Path: <bpf+bounces-77555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D224CEAFB9
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 02:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC793018F73
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 01:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A01DF27F;
	Wed, 31 Dec 2025 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LbFWoDz9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AB717C69
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767143646; cv=none; b=ifjTW41bOwJdJw8eGj/JF0dNZjny9RojxPQXOIuXTSkYnaMwXTlwbt+BaXBkoPs2qhvzFyDolaPHtHntfLTM8OzQcNci4eSypO3ymI8s1Rk2BNMdCRoyaa3dGG8WGkL90wMJ9of141yqkfATCh4N2wryAF3LRWCRGPVi91D8U6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767143646; c=relaxed/simple;
	bh=+nOx0E8TF96iJsJMU7ztUTcxlEy1f+9rRbE2kFljo9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kosag08ACCEBa57LT6GnRBlKm1Zdiv6IE4IhH6H+egUPDkIBRx3LLhEJ36eDK4ZlJuEX3qGrxYQ6vDCQA/JEo6WqaD4tj2SlHJ9pj6wJsC3YkUtyUzI12/gArp/wXFC5jLUdixflvVMkb6yeympw1zVNc0BpY13e3zXYEyQ1b8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LbFWoDz9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34ab8682357so1075223a91.2
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 17:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767143644; x=1767748444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I543esSNoSSXZkx3I2Amxi6N5N67AL2j1fCPiDDeRtE=;
        b=LbFWoDz9WsQ66UBl9TY4E6iETNlmAs5yTJySkBteJl/Q8eEcx1LtqaEkyaIsp5PXBy
         FWmoalauXkv2/uWwQGHs3GTywZZJ0d6GkjUjXEALFzGBgoLu9Rd8MG/AmtZn0Mz+AXyX
         1HkZocZv6Zhek1EylG80Rfq6KKPTlqN43iphCYLxuZ3jOz52Xi/nfNalxjvEwvbO+SYj
         BwPWgdLT1Wn9T6Wd8USrpHod21LnoRhlzY+5cBQ27KW9B1jJ4ICaLhfMZqGQMzkvGt6a
         mndkTbjMeajf3vEbr0QRkOxk2QgRnWBPiq+P0bmOWTKEkCPAYS2MQhUhUv1r4j3Nf+yB
         b4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767143644; x=1767748444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I543esSNoSSXZkx3I2Amxi6N5N67AL2j1fCPiDDeRtE=;
        b=NwahV5z83KCb7FXFpYzFS8hEdK+H/8/X7zP+zcIX1CwScItCiCmrPxR9BpjamJm8ng
         OABbRVNllzVKu+nDlW3qyMO+WVFV7cM+t5bqYK6tjakjVTV7v45az5LA+FOlDfn+knfD
         swVGggQd3Lz5RihCo4YYTPHg4JgtttP0uFg9P5ePcJvQb1Pq0YXtAg8x98NsbHQ2pha7
         34shCGbwqb/0Q9qBX9H5ewRzx/t6CoDOdyu2US+RPmAZ9L5T3w6TSPdJ7N+lyodBq1sr
         HwKJAPmifKVMoCIEaPl2KRRtpUSDRj57N4Sr1gSokLP7Bqd95IcwVhagL4hcRDumAlMw
         6uJw==
X-Forwarded-Encrypted: i=1; AJvYcCW/fxKoijlC+XNZKwZO03mVRUMIq6IK2o+E3MKtiIvxr5jVbeUnWrvONovl3VjiDMaO9Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/7yb2t3Mwxm3+tGer8FzEhl62aJHU5hBu/nh3TkYTLosC+8P
	BYtcVDQY06+DhiL3fvbKKnpS3VIt7AdMscbawzQYp+UdH3elw/wByMMICnmc5Bf0uM6k8juIy+i
	pXlaMWNnLgtD20WSYJ40ux7yz7BC9kX19LsmaI9+Q+w==
X-Gm-Gg: AY/fxX5nHXWez2B3yqd7I3spggu4Dp91R22lzqRmaLgboH69ZkSLdSr6sO6ciPr0ttv
	T8cHFbZj9vAuYKzXb6Ssy3hJt4mi/IR1tLz7NZNcqFVBZt7bMYSl0DEGo3lC5BxF1c1/L2qAPxo
	yRzI7omEff7DKeRVmhjS4FqnIWE13ymc3f0MkuxVcApOggxHnmXG+ojI+Va/SZvzp/f0mS+wm3L
	iUmBg51P+7UCTsOfKW0o4ncMu28UkpBbEl2kFncwDO+g+rEZkqbKqOl+SuBfiF3jDjdiPWT
X-Google-Smtp-Source: AGHT+IHVOL97i1S5VSw9V5GP5k90zV6IBOZZrqrM9l80XlerU19R4AfAnz/6XuiJRhvxIX8r9v54wVdPMa43tqcSvz0=
X-Received: by 2002:a05:7022:688c:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-121722b0402mr20358651c88.2.1767143643753; Tue, 30 Dec 2025
 17:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104162123.1086035-1-ming.lei@redhat.com> <20251104162123.1086035-3-ming.lei@redhat.com>
In-Reply-To: <20251104162123.1086035-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 30 Dec 2025 20:13:51 -0500
X-Gm-Features: AQt7F2ovzskSTiZrzQSpI9Ob1CoS9g7a0tP-rIanUj_Vfijlko3lo0SICeKlJ6A
Message-ID: <CADUfDZonj-mn9oOF-cGgw2TS9Emmk0vP=3=+n0bJbhGw43ra3A@mail.gmail.com>
Subject: Re: [PATCH 2/5] io_uring: bpf: add io_uring_ctx setup for BPF into
 one list
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 8:22=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add io_uring_ctx setup for BPF into one list, and prepare for syncing
> bpf struct_ops register and un-register.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/io_uring_types.h |  5 +++++
>  include/uapi/linux/io_uring.h  |  5 +++++
>  io_uring/bpf.c                 | 15 +++++++++++++++
>  io_uring/io_uring.c            |  7 +++++++
>  io_uring/io_uring.h            |  3 ++-
>  io_uring/uring_bpf.h           | 11 +++++++++++
>  6 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_type=
s.h
> index 92780764d5fa..d2e098c3fd2c 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -465,6 +465,11 @@ struct io_ring_ctx {
>         struct io_mapped_region         ring_region;
>         /* used for optimised request parameter and wait argument passing=
  */
>         struct io_mapped_region         param_region;
> +
> +#ifdef CONFIG_IO_URING_BPF
> +       /* added to uring_bpf_ctx_list */
> +       struct list_head                bpf_node;
> +#endif
>  };
>
>  /*
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
> index b167c1d4ce6e..b8c49813b4e5 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -237,6 +237,11 @@ enum io_uring_sqe_flags_bit {
>   */
>  #define IORING_SETUP_SQE_MIXED         (1U << 19)
>
> +/*
> + * Allow to submit bpf IO
> + */
> +#define IORING_SETUP_BPF               (1U << 20)

Is the setup flag really necessary? It doesn't look like there's much
overhead to allowing BPF programs to be used on any io_ring_ctx, so I
would be inclined to avoid needing to set an additional flag to use
it.

Best,
Caleb


> +
>  enum io_uring_op {
>         IORING_OP_NOP,
>         IORING_OP_READV,
> diff --git a/io_uring/bpf.c b/io_uring/bpf.c
> index 8c47df13c7b5..bb1e37d1e804 100644
> --- a/io_uring/bpf.c
> +++ b/io_uring/bpf.c
> @@ -7,6 +7,9 @@
>  #include "io_uring.h"
>  #include "uring_bpf.h"
>
> +static DEFINE_MUTEX(uring_bpf_ctx_lock);
> +static LIST_HEAD(uring_bpf_ctx_list);
> +
>  int io_uring_bpf_issue(struct io_kiocb *req, unsigned int issue_flags)
>  {
>         return -ECANCELED;
> @@ -24,3 +27,15 @@ void io_uring_bpf_fail(struct io_kiocb *req)
>  void io_uring_bpf_cleanup(struct io_kiocb *req)
>  {
>  }
> +
> +void uring_bpf_add_ctx(struct io_ring_ctx *ctx)
> +{
> +       guard(mutex)(&uring_bpf_ctx_lock);
> +       list_add(&ctx->bpf_node, &uring_bpf_ctx_list);
> +}
> +
> +void uring_bpf_del_ctx(struct io_ring_ctx *ctx)
> +{
> +       guard(mutex)(&uring_bpf_ctx_lock);
> +       list_del(&ctx->bpf_node);
> +}
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 3f0489261d11..38f03f6c28cb 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -105,6 +105,7 @@
>  #include "rw.h"
>  #include "alloc_cache.h"
>  #include "eventfd.h"
> +#include "uring_bpf.h"
>
>  #define SQE_COMMON_FLAGS (IOSQE_FIXED_FILE | IOSQE_IO_LINK | \
>                           IOSQE_IO_HARDLINK | IOSQE_ASYNC)
> @@ -352,6 +353,9 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(s=
truct io_uring_params *p)
>         io_napi_init(ctx);
>         mutex_init(&ctx->mmap_lock);
>
> +       if (ctx->flags & IORING_SETUP_BPF)
> +               uring_bpf_add_ctx(ctx);
> +
>         return ctx;
>
>  free_ref:
> @@ -2855,6 +2859,9 @@ static __cold void io_ring_ctx_free(struct io_ring_=
ctx *ctx)
>         if (!(ctx->flags & IORING_SETUP_NO_SQARRAY))
>                 static_branch_dec(&io_key_has_sqarray);
>
> +       if (ctx->flags & IORING_SETUP_BPF)
> +               uring_bpf_del_ctx(ctx);
> +
>         percpu_ref_exit(&ctx->refs);
>         free_uid(ctx->user);
>         io_req_caches_free(ctx);
> diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
> index 23c268ab1c8f..4baf21a9e1ee 100644
> --- a/io_uring/io_uring.h
> +++ b/io_uring/io_uring.h
> @@ -55,7 +55,8 @@
>                         IORING_SETUP_NO_SQARRAY |\
>                         IORING_SETUP_HYBRID_IOPOLL |\
>                         IORING_SETUP_CQE_MIXED |\
> -                       IORING_SETUP_SQE_MIXED)
> +                       IORING_SETUP_SQE_MIXED |\
> +                       IORING_SETUP_BPF)
>
>  #define IORING_ENTER_FLAGS (IORING_ENTER_GETEVENTS |\
>                         IORING_ENTER_SQ_WAKEUP |\
> diff --git a/io_uring/uring_bpf.h b/io_uring/uring_bpf.h
> index bde774ce6ac0..b6cda6df99b1 100644
> --- a/io_uring/uring_bpf.h
> +++ b/io_uring/uring_bpf.h
> @@ -7,6 +7,10 @@ int io_uring_bpf_issue(struct io_kiocb *req, unsigned in=
t issue_flags);
>  int io_uring_bpf_prep(struct io_kiocb *req, const struct io_uring_sqe *s=
qe);
>  void io_uring_bpf_fail(struct io_kiocb *req);
>  void io_uring_bpf_cleanup(struct io_kiocb *req);
> +
> +void uring_bpf_add_ctx(struct io_ring_ctx *ctx);
> +void uring_bpf_del_ctx(struct io_ring_ctx *ctx);
> +
>  #else
>  static inline int io_uring_bpf_issue(struct io_kiocb *req, unsigned int =
issue_flags)
>  {
> @@ -22,5 +26,12 @@ static inline void io_uring_bpf_fail(struct io_kiocb *=
req)
>  static inline void io_uring_bpf_cleanup(struct io_kiocb *req)
>  {
>  }
> +
> +static inline void uring_bpf_add_ctx(struct io_ring_ctx *ctx)
> +{
> +}
> +static inline void uring_bpf_del_ctx(struct io_ring_ctx *ctx)
> +{
> +}
>  #endif
>  #endif
> --
> 2.47.0
>

