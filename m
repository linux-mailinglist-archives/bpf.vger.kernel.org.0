Return-Path: <bpf+bounces-67628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FCDB4658D
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63057A034CB
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FFA2C3770;
	Fri,  5 Sep 2025 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khNQ+Gc4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5C280325
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107913; cv=none; b=DWeuBN4Yk273+cRyFjfmHAvG4o0YxRkicpFFSqo+Kb1mDMpLyubQGxpAz+wnS/7wgqZs/PMEoyFFzQte6cW8kryOoIIy9JAMhbVtXdUfQeW3C8vw74fIEsCF9ENlK+/x2l//a8TOxL7SfdrEgm6TgGHV6vXIb7KQ/o14VKYRfq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107913; c=relaxed/simple;
	bh=SLK9rr4x11vpEiqE+hHybWqMaPNoDmkfaG/MSpol94A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH2tp2hOX/XkY1iJNnSbCVQh+FwSpEROLPDwiihE1qBwymvW/ALb/6AtuDJ7UJyI/kD+6/55Q2fspZvzKwZFt/uPuQsq3XvB45XRfBbtuUIrtEfGzfjE8s7LTvcH1GhRkBfD98lAjCqiHi2t03r73yczcFyvqHxXhTehZKdgEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khNQ+Gc4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3280264a6e8so1987163a91.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107911; x=1757712711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6iYxxEGAvkeFWpNvrGKAXUXP2TUk++WAmz0ItvoFSA=;
        b=khNQ+Gc4l+RCF2dwmjhmoVtoASeCBXnx2u/0QlM4Kr8p23TVmaoKw1cGOy/fkH2723
         tgCgL4OFUloAphn4v82GOU81NhtnPLJgHNPYjhPL6iuJLSrkZ+xJ0O+2zs8TijrLU3E1
         K0SiJGoX9w/ubwZfEgNgJ3pdZvK7wu4F3gc1GnmN2EdZUyqfftxLy8P9jPNg9r+Ciw9L
         niTnKYS2TLaNFoqdiSwMJ6tAxEemlUMrTocdk7CSALwKPcV+CmOH7nB7JKXAasTa292F
         snxrmwvEF5kB3iJPlFtP0UIZbmGehzL7+nUfZlnUwZszbZppWQvK2BzW2C2VvRdSj5m/
         6fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107911; x=1757712711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6iYxxEGAvkeFWpNvrGKAXUXP2TUk++WAmz0ItvoFSA=;
        b=IiIjLYTju5nDd86/KEIOIb7Bs1pPIE1W9UpUImmPcfCtdDmBn5LmQDgy1QSyDtHb8v
         YCXKtBU3R5Z14MQO4j51BvJ+4HNycwfMw6Qng7hqqhb1L0VAw1N3EXpFiVgknYvb6Rl4
         xT+YnPH7n68SVTVypiYTkNvQ99+EYFeeDDbAFGqCbdTwi/e+/iwfEJpoNb1R49tjlYVW
         1HIzXPG0kz8Z+8B84A7AEiJjI4TXIQ1CNiNtGLmQ7aWxFxfnuZDhYqCuxHnDFJnL9pFd
         uu2gHh2Oxxi1AGdpjhXaL1T1JKo0OVR5LhDI/DyhQXNtEFAQNLL2cEMMkTf0unXADqfF
         spwg==
X-Gm-Message-State: AOJu0YyW6VakccolslhrDl9Kqz7AFkkFidJFwX58SrWwBsJcgHVtqtMV
	hO+hTsZUxRUf/gsXCjIBfrv8dI4b5PgqGgfVQ//7iJ6lCxe0cSvH6zgrkn8/ZFcToCEnK+UEelx
	D/C5N1vw8j/ekojD8PSBxi9xjfxgJWAg=
X-Gm-Gg: ASbGncuW6hYcY/kbWrDag+xnJKDreTLGehebdfAZTL0N0XNPgHM7vtlAwa8n1II0b9d
	SJ7VPD3pUK51u7p9Xvznd0kK9iBZXCD5Y+Vrc49Vs9dFaGYWjjqyZBdnEqRZPxDUQEwSW4D5x6z
	2TvMaoZaYozU9R6fOsDOWDSGdtW69AwwtpdwlVLCezAoKkNdq0ssVGcX0hJYFTZZjOR60UxrtB6
	gl1bry8O0RrZ9M=
X-Google-Smtp-Source: AGHT+IEtygoiUgYDCdxkqTZ2dSWnEiJVvCVC11AofEiIfN5RLbKQ9Tp/sPym+gbmlGv9lfuDkQQX6H5/WWzuRpDQwys=
X-Received: by 2002:a17:90b:1d4c:b0:32c:c40e:db12 with SMTP id
 98e67ed59e1d1-32d43f973e6mr428701a91.17.1757107910821; Fri, 05 Sep 2025
 14:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com> <20250905164508.1489482-5-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250905164508.1489482-5-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:31:33 -0700
X-Gm-Features: Ac12FXz8TuIajHhlf23X05R2rbtA0SEl4gsu-dVN7A8pzJfpLa8P7fbLXCkAKqc
Message-ID: <CAEf4Bzb2u5C2Ckc7RZ4RzHRWDsaTPqxgoVdeQVmX-ddNnuNS6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: bpf task work plumbing
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:45=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> This patch adds necessary plumbing in verifier, syscall and maps to
> support handling new kfunc bpf_task_work_schedule and kernel structure
> bpf_task_work. The idea is similar to how we already handle bpf_wq and
> bpf_timer.
> verifier changes validate calls to bpf_task_work_schedule to make sure
> it is safe and expected invariants hold.
> btf part is required to detect bpf_task_work structure inside map value
> and store its offset, which will be used in the next patch to calculate
> key and value addresses.
> arraymap and hashtab changes are needed to handle freeing of the
> bpf_task_work: run code needed to deinitialize it, for example cancel
> task_work callback if possible.
> The use of bpf_task_work and proper implementation for kfuncs are
> introduced in the next patch.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h            | 11 ++++
>  include/uapi/linux/bpf.h       |  4 ++
>  kernel/bpf/arraymap.c          |  8 +--
>  kernel/bpf/btf.c               |  9 +++-
>  kernel/bpf/hashtab.c           | 19 ++++---
>  kernel/bpf/helpers.c           | 40 ++++++++++++++
>  kernel/bpf/syscall.c           | 16 +++++-
>  kernel/bpf/verifier.c          | 97 +++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h |  4 ++
>  9 files changed, 193 insertions(+), 15 deletions(-)
>

LGMT

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8f6e87f0f3a8..febb4ca68401 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -206,6 +206,7 @@ enum btf_field_type {
>         BPF_WORKQUEUE  =3D (1 << 10),
>         BPF_UPTR       =3D (1 << 11),
>         BPF_RES_SPIN_LOCK =3D (1 << 12),
> +       BPF_TASK_WORK  =3D (1 << 13),
>  };
>

[...]

