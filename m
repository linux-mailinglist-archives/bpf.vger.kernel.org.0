Return-Path: <bpf+bounces-57363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C88AA9C26
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148337A2D82
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6C25A2AA;
	Mon,  5 May 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxHVV+A1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AE1AA1C4;
	Mon,  5 May 2025 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471707; cv=none; b=jlc/lGwZrSMVna8raHDx7CdicM/WeUXFn9HimivRr6j4VkKXVP8uOJEMaviHmJVedkAR1edIlZe8HcytCqc5P9NOcDnxiN1pVwvmSc60aac1Jp5CUl0AJkbMOnb7CZy3se+lamhF6O4XyeL+18lsH5PBr2IGQLbpys/v4IKcIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471707; c=relaxed/simple;
	bh=8Wc7uyprdPgq681BycmdYdWkla+q6AvvnxWUvzV7j1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myMWcxDzmG73onVxe+8PdsNZ1FpEmLtgjFWeUJYSJD7VEfKnU0Zu5IkKwH/OYO614cEKHXV3/STh8x2W9D5rXOip2uljMwuaHYM3pyJxJUIx5W+Gt7SRYOr8mlF8T8XfSLetXJ1FNBgmb07ugarQ4KBHOoUd62a+Ben7x2SvZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxHVV+A1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26E1C4AF09;
	Mon,  5 May 2025 19:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746471706;
	bh=8Wc7uyprdPgq681BycmdYdWkla+q6AvvnxWUvzV7j1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FxHVV+A1WHqb0zBM1lZAaPs8gAujzWzBSFGOAjG2OFYvmeqOG3Dsr6lcbtLRUMtQR
	 UPrf+OY9OUZX+j8LGTO6KPNaIajAD8tpBdoj4GKrDNf2JejuUfsf8e1iqs8tGaIK56
	 +5UykG6tiIvzbQ9cqlzgRVY/KPaRGa5hp262riO9TzzgkRio1oRcTQLMuZGz0rEqaA
	 ltU3kAFRp26IRiPdq5mdrKdkjSdou7uKj7hUGo4/QSintmgjgMvXk4er+OTOK5wKDQ
	 QCALDRn4S3zGKJGhjMXm2/YULz4ntu42Tq3+uJ9v3I13yE6/LyldrPsKzLh0RlXI/y
	 vlyqKMVVlztJw==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7cad57f88eeso207685085a.2;
        Mon, 05 May 2025 12:01:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5XqqkS1/+81pi16YnqIZan00UpZUrdu/pcw8zNT3MzbysszoOIgsnOcoB2HszXNKEKU5pNwWz+9pNJkNw@vger.kernel.org, AJvYcCXbMUveCqvuCsrsEBGOTdQL68YxqbKqdnG6qfSlUvig7mervi9ajq1H1wAEHeHw0fbqmZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHw3hOJLg+DkDnEutKh+kEVZDPU5o+aEYa9jBhYj2gtfwNwww
	9F6vefGWTANrQlOsA3k1EhGL3R+Q7SobEaQPP3DQCYuYxY24y78FqRKwlwhWKKhv58bh+sZ+/71
	6ZsZRpJcJJAZIDtR5luoSU+iC8H0=
X-Google-Smtp-Source: AGHT+IGOEGYebUMiLyHyCKzdFEYkktrVStQLJfnFBAUA8GBJ7fskaXkgqPKcji3wzHW9G4gUGwc8ikfVgo1j1eRVU9Q=
X-Received: by 2002:a05:620a:17a1:b0:7c7:ad79:a087 with SMTP id
 af79cd13be357-7cae3b05912mr1200371385a.57.1746471706043; Mon, 05 May 2025
 12:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505063918.3320164-1-senozhatsky@chromium.org>
 <aBiJnR5MEL5hVXXC@google.com> <wzxhhoiczrhsosf5bkwqf2yypdrhgrm6wskiusfg7iumpgk7ew@rcegtieelqco>
In-Reply-To: <wzxhhoiczrhsosf5bkwqf2yypdrhgrm6wskiusfg7iumpgk7ew@rcegtieelqco>
From: Song Liu <song@kernel.org>
Date: Mon, 5 May 2025 12:01:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Q7cHyMHemnLtoys6uNgd-tzKARx9gX177PimAEwpszg@mail.gmail.com>
X-Gm-Features: ATxdqUHttljortuCb5IekMVDy25FQvM8YoZL14nwExSXv8Z0qOLBawXihCPkIUk
Message-ID: <CAPhsuW4Q7cHyMHemnLtoys6uNgd-tzKARx9gX177PimAEwpszg@mail.gmail.com>
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 6:27=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/05/05 09:49), Matt Bobrowski wrote:
> > I noticed that you've written the newly proposed BPF helper in the
> > legacy BPF helper form, which I believe is now discouraged, as also
> > stated within the above comment. You probably want to respin this
> > patch series having written this newly proposed BPF helper in BPF
> > kfuncs [0] form instead.
>
> Oh, okay, I didn't know about kfunc.  So I guess it's something like
> the patch below.
>
> > Additionally, as part of your patch series I think you'll also want to
> > include some selftests.
>
> Let me take a look.  Any hints on how to test it?

Please check out tools/testing/selftests/bpf/. The most common way
is to add files to tools/testing/selftests/bpf/progs and
tools/testing/selftests/bpf/prog_tests, and then use test_progs.

>
> ---
>  include/uapi/linux/bpf.h       | 8 ++++++++
>  kernel/bpf/helpers.c           | 6 ++++++
>  tools/include/uapi/linux/bpf.h | 8 ++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 71d5ac83cf5d..8624cb2ac7d9 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5814,6 +5814,14 @@ union bpf_attr {
>   *             0 on success.
>   *
>   *             **-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * unsigned long bpf_msleep_interruptible(unsigned int msecs)
> + *     Description
> + *             Make the current task sleep until *msecs* milliseconds ha=
ve
> + *             elapsed or until a signal is received.
> + *
> + *     Return
> + *             The remaining time of the sleep duration in milliseconds.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \

kfunc shouldn't have any changes in include/uapi/linux/bpf.h.

Thanks,
Song

