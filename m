Return-Path: <bpf+bounces-35007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09799934FE8
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8527FB2350D
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16D144315;
	Thu, 18 Jul 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7CSK46n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F637A724;
	Thu, 18 Jul 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316577; cv=none; b=Nnvcdv4UNCsU5yonaTTM/4AXwCvflEBH+9AQpSHv0jjkxitNT255kdn3452irLqqAfE+GOLk7Ax7nEzgDGS+Fz75PZdN9aN2sUGi8ZSrgpAk2tjrDq/A/I4lfYOQm9blpOvOe/9NN/FaOEovU/G3XomQt9TE+sxH9l3TZlXlpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316577; c=relaxed/simple;
	bh=UgMiXpOeAx1GvjfndlczEo6peKjvAwRTgIP2UtrCinw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXAqhFXBrcZIDClvgCYxPBPKcf9JDoEYYHZKNpnuRde1SR7jSi31xyFfKWy18nLBxCvpBm4mZQPYEjJZa3cgdKMgXY3ZeGv/SXcOf8wPgRbV32spAwYmINBdp3vSJ9FnrZ8t1g+kaIBwS7Qs3pBzMN2FKac6E0aqyohzbWP9tWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7CSK46n; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-75a6c290528so629540a12.1;
        Thu, 18 Jul 2024 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721316576; x=1721921376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkIMG8Ff5B1D43lrbNrRALe+o/BMBNiqDHduHrCM/HY=;
        b=b7CSK46n91QXK/tf368I+xwDFdXGvQ5lfXzxq0KiGLQ3j0DFLf6IhF5LMNZHBtEtKx
         TAUbKPzB6Na4jtxj3KmO8C1zH01zXtEicb9IOgt2+tgWsnBP46VoAPUI4iF/hQRI9Nld
         LGwVJivHLNGysEX23hqkhI3tGrJrmDQpcfUucp3p+kZ2NnKNt57YJ31wkjmoCajGSjtx
         xHjYeTsoIVF1JxOfW/5QMOXh9FOyk/A7KfkdaiIOngdrmwlJ6cudB8E9Uo/FDtc5+npU
         MpE1oIpTNV1AbBJWlbSQCGPNTNFEUlX9ZI8j6NcsEZCGsFsbwagK9l22KlPvMGbEQU2g
         DseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721316576; x=1721921376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkIMG8Ff5B1D43lrbNrRALe+o/BMBNiqDHduHrCM/HY=;
        b=riwxI5u9oYbHh+2eQb1+lroNjrfFV64Kw1g+UpXIZLbwonThU+wCNUnQ3WtfJXlrmM
         yh151+BI/iy/7Oh3z7uu3EvNvwavaRETHOUG8MQ4VGIv+nGVhGHil0abyiBTHD/rTw/5
         273ywkEtHSfw280SSZFss1cCGFne7rncJEdam4ocjFoAik+QXzwR/5wu39j9y62G6Z0R
         j02Y9cFjFg//S5k85DlAWca/rlAfkSzuI5djDyhHCGBZ3yaPeSqiW/LWpLoesgI1w7NT
         zOjDpMYMMH0w4JLDBa5Lca/b9Xe6/HIK3AQpD3lKk8Eeyqp3G5ft6WRkPzaDIDzv9MhW
         RldA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7l7+9Y233KZ157hVbOU/64YoUHvyd9FDNYqLDf7GGgx0PwimRThb6Dkb9g+9RCwyWQKkYHruCHRcsuvQ5/fzPT6RiX8UfimuAeigjk3TCDlxTdb1M120ULvR3LeWaOYmmJswDnfHaHyd91Ejvfiw+8TCniUSboTGnhVSQZqLefnUIA==
X-Gm-Message-State: AOJu0YyOTXWGZap57t08ZgrWNiuK9Fcc7MrcskrAO+2wsNUuHvNoVfpW
	8MyRrbJBh89J71z3f9yk279k8IsKEyo1svPKjOlzuUA6t/xvOWtuFFaWb0yfj+40Dnl+2hHgHJI
	HtvCy4RMpCMNNnFvUTBa7bdXYPhI=
X-Google-Smtp-Source: AGHT+IEkeaBR4zHqL2VFNKAB2q09CJ+qNphhqcwQ3sxWK2fxn+rjuWfCLb2/M3yQI68xt22na6UbtV0GCi7LpS3DYOY=
X-Received: by 2002:a05:6a20:3943:b0:1c2:a722:92b2 with SMTP id
 adf61e73a8af0-1c3fdd30824mr5827661637.45.1721316575873; Thu, 18 Jul 2024
 08:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710193653.1175435-1-andrii@kernel.org>
In-Reply-To: <20240710193653.1175435-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Jul 2024 08:29:23 -0700
Message-ID: <CAEf4BzaTEUkRU37fsuGy+-otWk9K0-c9=hs0APRz7pJy7rq-5w@mail.gmail.com>
Subject: Re: [PATCH v5] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com, 
	tglx@linutronix.de, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, rihams@fb.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:36=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> When tracing user functions with uprobe functionality, it's common to
> install the probe (e.g., a BPF program) at the first instruction of the
> function. This is often going to be `push %rbp` instruction in function
> preamble, which means that within that function frame pointer hasn't
> been established yet. This leads to consistently missing an actual
> caller of the traced function, because perf_callchain_user() only
> records current IP (capturing traced function) and then following frame
> pointer chain (which would be caller's frame, containing the address of
> caller's caller).
>
> So when we have target_1 -> target_2 -> target_3 call chain and we are
> tracing an entry to target_3, captured stack trace will report
> target_1 -> target_3 call chain, which is wrong and confusing.
>
> This patch proposes a x86-64-specific heuristic to detect `push %rbp`
> (`push %ebp` on 32-bit architecture) instruction being traced. Given
> entire kernel implementation of user space stack trace capturing works
> under assumption that user space code was compiled with frame pointer
> register (%rbp/%ebp) preservation, it seems pretty reasonable to use
> this instruction as a strong indicator that this is the entry to the
> function. In that case, return address is still pointed to by %rsp/%esp,
> so we fetch it and add to stack trace before proceeding to unwind the
> rest using frame pointer-based logic.
>
> We also check for `endbr64` (for 64-bit modes) as another common pattern
> for function entry, as suggested by Josh Poimboeuf. Even if we get this
> wrong sometimes for uprobes attached not at the function entry, it's OK
> because stack trace will still be overall meaningful, just with one
> extra bogus entry. If we don't detect this, we end up with guaranteed to
> be missing caller function entry in the stack trace, which is worse
> overall.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/events/core.c  | 63 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h |  2 ++
>  kernel/events/uprobes.c |  2 ++
>  3 files changed, 67 insertions(+)
>

Ping. What's the status of this patch? Is it just waiting until after
the merge window, or it got lost?

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5b0dd07b1ef1..780b8dc36f05 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -41,6 +41,8 @@
>  #include <asm/desc.h>
>  #include <asm/ldt.h>
>  #include <asm/unwind.h>
> +#include <asm/uprobes.h>
> +#include <asm/ibt.h>
>
>  #include "perf_event.h"
>
> @@ -2813,6 +2815,46 @@ static unsigned long get_segment_base(unsigned int=
 segment)

[...]

