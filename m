Return-Path: <bpf+bounces-57953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F13AB1F71
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF40616A107
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA92609EB;
	Fri,  9 May 2025 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb40qvkT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59425D1FC;
	Fri,  9 May 2025 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827632; cv=none; b=a3fwbLK+XOX+wx+KZqL4ostwltCCLotqraey5ibIQJUxuIsMzfguAMJzZIk/zzAZCFM/JFPgqyFQPaJ0zhGtNWAv9G3jMPRpYm4Pi0tD+Io9vGhmXkUlVZPcDQfeeSxTFqJn44tz9Y8iyAcGyIZa3xzp+tf6hG1iZ9aZT7KTVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827632; c=relaxed/simple;
	bh=NiH+k6IfoKNrv7kJjvq02SqgFB+0uIsB7zsh4/p7lUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udPRXC7X1Ghenr3Puig3sDoHBIq6voeJHPJ8idBymSoLGGErnuSRogG9Ircu6rni+Y6CfDC6SsrW6GHl2vhJYHoAX3wh5Ef04ZvyU8k3gV3VP35z2nRrbHufVrHtaDN2CgWya2mOXwLlMajtbjazy8vO3IV+/E/rdFSH5GR+Wf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb40qvkT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30c35ac35dfso1763033a91.1;
        Fri, 09 May 2025 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746827630; x=1747432430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHkbQJC2vfZe+igN8ZKegJaL309MbUilfmbTINeRmN0=;
        b=Nb40qvkT96ockENj/wdkrX39vXT3XOeTwxNnYKGpQLUtm0haWz3iV3RUf3mos9W3t6
         DZNyqW4eAhb4GSanA6F3beQiofcY3uVPOPIrvSW+n3Hct71jKmpwFZUklRHJ1HSl+5aw
         HAbM+F2iy/jTQtBI3WQh6haYJY2rR8+1/YwIPbOuOfdMXf8bSyfI4rtvlIN+uPz+ggPt
         X7wDMckMedYHDU7D9i7u2lhOm3gJNbDyd4xG8Rd6Wdqz7avabEsFcLeLhpKPKMh4hz3T
         d85EC1S8lvNZujndGQFHlXkUQP3rOG8dTDnqxhNa5ZxN0SBMbxTe3F9qnJ9Yz0LlRkuz
         DjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746827630; x=1747432430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHkbQJC2vfZe+igN8ZKegJaL309MbUilfmbTINeRmN0=;
        b=U+FMNe+hKyeEZ1M5wLzyz1QP2OK4gHF2GjIUi8h855wF/i7SxHfjxAK++Ji7wcv6Bx
         Sxz1/JQhgLEtTOzaf2lw/IyyPn50hKh0S5W3SYbF/GNiJCp2e/3njmcvUOomCfX3mcBQ
         2Alpax9jLJAGoHnGecYC/2hdtjRYPWDGRQxFcwVEsgWKI63KFVENmgq4qnA70xIasIRk
         5yrYtk58cMzE3Jo9C+COsiIKJH8SNYyQUaCgoKhr0R7ll4sCctLyUkfTtRCWz9tjbzyZ
         CYK0EJv/IECNXl5cdB2izESyWKR7QWyR7VeSm/thAUIHi7itv/YMHxNanZgw6FU0o6A3
         jeHw==
X-Forwarded-Encrypted: i=1; AJvYcCWTfNhr57gmXxqdEy1jC3WxKordTvdGvlM69ddTDGBTEEsdA1eIszUs0XdWFLwxXqE6rn8TJGTQDFLvLd7YdzlWKHZf@vger.kernel.org, AJvYcCWjv9RjItfB6f7ml+KRbhg8xirldeEvnkz4PN8tc9jcJxwq9Pv1pvSQ/4zi4vMh0CGZVCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91Il2HT+T6GsNY5gEPeTrI28GYfeS9P5HDl2fLhYMjQJ8NfbX
	G6F9gm/jtmlbm6omm7efZZb8++7nKJNHK04udQYWZdutPzsCh5czR+P8crEbC1eamEVbc8N//qS
	cdTPqs+JFxbtFTU1YYm6LsUKVeEA=
X-Gm-Gg: ASbGncsY9yTIrUG4ONIiNVrqiPqMq07gXJRhmo8ogUHSSzhUAwHf+NSfls+ZyskVnCE
	bWOJ9I15TA/lpcMyJhcxEdPnSGjM7Ihw47YApLhjW3bUhE+Ldx9PjCHLEdLu/Zt3Ms3j5GWT9dO
	ywHH6AZsugUdPT0SS2dij04KVbtBfyC0WZQdGxl3cUPzCRyJ8k
X-Google-Smtp-Source: AGHT+IHOtgUxXnIkOjOIbpTNdvhRDUXpWuB9CdApfqdlPxp6khEaQW6lLupeh/DHx2cTjBU6h2YZAVwr8RxMvgysjME=
X-Received: by 2002:a17:90a:e7ce:b0:30a:fe:140f with SMTP id
 98e67ed59e1d1-30c3d62c6dcmr7476368a91.28.1746827630268; Fri, 09 May 2025
 14:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509164524.448387100@goodmis.org> <20250509165156.135430576@goodmis.org>
In-Reply-To: <20250509165156.135430576@goodmis.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 14:53:38 -0700
X-Gm-Features: ATxdqUG7vyKh6ckuiVc80QVrYGdO5Dyfg62nDuY0zs4zFQaHfF1xoIZCrXuqiWQ
Message-ID: <CAEf4BzaKfvCu2T+jJ2e-CCt0N50urfx+p6kQfV899_jkmT_XKQ@mail.gmail.com>
Subject: Re: [PATCH v8 15/18] perf: Have get_perf_callchain() return NULL if
 crosstask and user are set
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 9:52=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: Josh Poimboeuf <jpoimboe@kernel.org>
>
> get_perf_callchain() doesn't support cross-task unwinding for user space
> stacks, have it return NULL if both the crosstask and user arguments are
> set.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/events/callchain.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index b0f5bd228cd8..abf258913ab6 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel=
, bool user,
>         struct perf_callchain_entry_ctx ctx;
>         int rctx, start_entry_idx;
>
> +       /* crosstask is not supported for user stacks */
> +       if (crosstask && user)
> +               return NULL;

I think get_perf_callchain() supports requesting both user and kernel
stack traces, and if it's crosstask, you can still get kernel (but not
user) stack, if I'm reading the code correctly.

So by just returning NULL early you will change this behavior, no?

> +
>         entry =3D get_callchain_entry(&rctx);
>         if (!entry)
>                 return NULL;
> @@ -249,9 +253,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel,=
 bool user,
>                 }
>
>                 if (regs) {
> -                       if (crosstask)
> -                               goto exit_put;
> -
>                         if (add_mark)
>                                 perf_callchain_store_context(&ctx, PERF_C=
ONTEXT_USER);
>
> @@ -261,7 +262,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel,=
 bool user,
>                 }
>         }
>
> -exit_put:
>         put_callchain_entry(rctx);
>
>         return entry;
> --
> 2.47.2
>
>
>

