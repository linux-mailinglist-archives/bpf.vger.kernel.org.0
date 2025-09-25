Return-Path: <bpf+bounces-69769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0577ABA10D5
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B308C4A04FF
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20BA31A57A;
	Thu, 25 Sep 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUE9gCqu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E23128AC
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825672; cv=none; b=ckdlk7mSfnBNmbm9MR68slvSJmT7VgRBEi8o4oluxMHOBeOWC9p8lcdF5CZrxl/DocxEJ5IfVgHkGZgCkvRUO88GN2K/4DsdMY72GUw6fBLpH/9WbjkkcCga2uHBitdxW1QnZtaq4xQre4cpmPz2TAzXe1KiDd7sfTbeXHDGI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825672; c=relaxed/simple;
	bh=4HyO/Omc0vHIbcGIr8eQR588wv9P0GcwZPgiYarPRNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tcj8oaC43uNZZIT2vFRRM1t3k+94JTCrs8oWaqXXjKl0RK+9gCBmz9wVqKVX2i0lGaP2xB4F9O5IDaINwlm4/2ImT5r7N4oT2sy+hAUe/28Soj4/rrmSWTTg7D9s3aT8JqvLl2GgK1LiSTLD9ydvTHw/cuyw2tuR/4u/7ZJrPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUE9gCqu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3322e63602eso1682920a91.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825670; x=1759430470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEVxXuxy2iSH4P0+ikQL58PMDB8CgXAp3tIeCVGBulg=;
        b=aUE9gCquWkY78WVnTKFKVQAruEQAmRQoQo/hME6eATizrCtxhHIO7IYiwddQ9VsI/3
         A229sduPkRgv4LfibQDVu9P6E1WJ4hcp+X6H4yjeRdOJgUIN3dJ7VR30Xt7fEtX97OmW
         ikoUJI+CkB6Tr6LMhPmCBmxePi2obhObTjmiJzUXIyGzfjnzz8XSVI4a+lF1IvDuQpkE
         7uFBlYbuHW97pyl2emPLDS48OiTM7uN7O5QUrYVIvukBO4QFjYQzxMzVwEHrFOhZbLMG
         WSTtX7RAijyieeYneTWjA4TwG2jqbr2ftZg3pj87SjI0gp9fLF6LHX1ryuY3zddQPy/s
         auqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825670; x=1759430470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEVxXuxy2iSH4P0+ikQL58PMDB8CgXAp3tIeCVGBulg=;
        b=jx+3QI+m5swW7aiYz6LPtgA19cu3cwUNR2G9AAFMzDNaM1zU+rRWdvMkApvL+I3tOJ
         dhZtjSyyHP7bjpEDmPUXfLSbijNedjdci5455YMErWm6JiqO/P/rJs+MyIQf4DFWRYzS
         6BZjeY4m5fYAXH8P0VVa140g7oySFX5LDRd37DKC8Syabj7pxKUWIzapRhlzslvXB+Po
         MpFkbT7CQ51iUUzmyrLpLH1SSiCWto970L1yf33zDXMVI0cUGOiivsp423jJ9VUQMtex
         1Z79ITi43cJVi/pCIe7TXXdJ+AJmNLJIQF4CuJqeR121xEOIvPF1xBHe7G0XZ0d2uOLI
         mNSw==
X-Forwarded-Encrypted: i=1; AJvYcCW7VU/OlAqsNBJnhYlkIqCMEJte1WMR9rKl0HUItEloy62Gr7/ZHPEmOF3JChIHI+UX6cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAURRmT1pkonEPrZSeLZHt3KlmFJov5d/nUgP3PPBXv36Tw0NE
	Bb9aQweqKRy17r3Hx2LPLDDNWEo6oQT41Ba6vbAeVCDRCh7QIKwcJ+9MSePBTsZ4uvDq7hji35E
	W4z62HZniiW+oNMqpeTJodThTANWZqKc=
X-Gm-Gg: ASbGncvNK7k2SxZrf35sZYIlxFyhLezQ+nDFadPaDDTklC2W5DiXocab/zOOW3qg46Z
	0Cn86q4LW8u6Yd0omDsGN9OSxxIHfIDm+ZjXcGaVu0/kfThwTA0sVBPdXm9TWPKHdkXeAiuSl/X
	aPe2pe+rVBN4y0SBhfiQfKbW30DhPU7SkG1ftDT5rXetAobL7JaJhfylK5i/oIYe+OAmv7GQsmI
	2uCK3xbpV5ClFhDIlIkTrI=
X-Google-Smtp-Source: AGHT+IGif1F0rH2+wJaNW1qXDTLPrW2/+7ZSS24YvD5gYvwrK7txwD5NgoCPK+1mrFy90rRGnvqMUSh5PdeT8seK+mo=
X-Received: by 2002:a17:90a:a783:b0:330:6c5a:4af4 with SMTP id
 98e67ed59e1d1-3342a2df0e7mr3743478a91.35.1758825669903; Thu, 25 Sep 2025
 11:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop> <20250923142036.112290-19-paulmck@kernel.org>
In-Reply-To: <20250923142036.112290-19-paulmck@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 11:40:54 -0700
X-Gm-Features: AS18NWDkeNOIzlcIpXV73ff3DZBfv87h1AghtZqbjYi5a1vEtT0YGqQqdWBwurE
Message-ID: <CAEf4BzazpB6XHL+HRO0HaegiwCUpXaTi+QSnPAxsW9BHBL=50Q@mail.gmail.com>
Subject: Re: [PATCH 19/34] rcu: Update Requirements.rst for RCU Tasks Trace
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:21=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> This commit updates the documentation to declare that RCU Tasks Trace
> is implemented as a thin wrapper around SRCU-fast.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  .../RCU/Design/Requirements/Requirements.rst         | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Doc=
umentation/RCU/Design/Requirements/Requirements.rst
> index f24b3c0b9b0dc6..4a116d7a564edc 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2779,12 +2779,12 @@ Tasks Trace RCU
>  ~~~~~~~~~~~~~~~
>
>  Some forms of tracing need to sleep in readers, but cannot tolerate
> -SRCU's read-side overhead, which includes a full memory barrier in both
> -srcu_read_lock() and srcu_read_unlock().  This need is handled by a
> -Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
> -readers.  Real-time systems that cannot tolerate IPIs may build their
> -kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=3Dy``, which avoids the IP=
Is at
> -the expense of adding full memory barriers to the read-side primitives.
> +SRCU's read-side overhead, which includes a full memory barrier in
> +both srcu_read_lock() and srcu_read_unlock().  This need is handled by
> +a Tasks Trace RCU API implemented as thin wrappers around SRCU-fast,
> +which avoids the read-side memory barriers, at least for architectures
> +that apply noinstr to kernel entry/exit code (or that build with
> +``CONFIG_TASKS_TRACE_RCU_NO_MB=3Dy``.

For my own education (and due to laziness to try to figure this out on
my own), what's the situation where you'd want to stick to the
old-school "heavy-weight" SRCU vs SRCU-fast variant?

>
>  The tasks-trace-RCU API is also reasonably compact,
>  consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
> --
> 2.40.1
>

