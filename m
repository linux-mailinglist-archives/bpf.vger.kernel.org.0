Return-Path: <bpf+bounces-56465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC9A97B3F
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973147A6BD1
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219E220699;
	Tue, 22 Apr 2025 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGvtO5Bz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337B21C176;
	Tue, 22 Apr 2025 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365718; cv=none; b=THG5h5UL3F5QYegCNiozpm8XlyPWQSIY8YTR2viNDhNcxlF0ApBPgF1R4R99BNg6Dsxvty7CTd0VPpwt0jFWY+/qPMvmsQoK9gO+veiU+sshiQkUsoczyk1ocgdliTP1Ws/G0zIKJu5Aeypgmpnp4cNJ5sz+vhcwXIaxQ4HF3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365718; c=relaxed/simple;
	bh=jz42MlIKhtm94v2zdrmyWguLYxer1bUQEKTQjrZnkh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIsf1MymWBYEi7BSFWymymkjyP8mHg7hHYl6OP9o7qA2I8RQZxweDpCl9nBPMIUblmHDyRxDFeUdzXkOhyBcf1417nTajLP1b9S7Qy4H7dsBUkn4vy5Lg8xGL7rPv9f2mq/KKzR7iJIaLLCkehYnfN3uGq7sbTLumOuSLUoriDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGvtO5Bz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33677183so68157445ad.2;
        Tue, 22 Apr 2025 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745365716; x=1745970516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T4n7eT2yvThTB4kxOGVUmvDFNy5zFwlyk//MmWtzN8=;
        b=GGvtO5BznzMDrCdUrOFR92W3rDWYVr6kY7eZk2+KS7ZyHES4eqTgCY/9GbK+t2Dwom
         PaVEkzLR6JOwlKQ/T5VFf/tdu9izEoUdQ5H+VWyAJpUoENFWAxe37t4S/W6nj0/1H4nb
         VSqtdVjdp/60HwSQHvJ6D+0Tpi9ozjbGRE8HUbWw+zJnoONv1/XOUea0RwxtWeuHfoUy
         dyI1+bTJm4MLvtHDAc+xVgnVsr9RgIRmS+GrFJuiW7ks2cnsi27f2I7gp8JWeW/d+6XY
         uI4Nlq1MhbRPWTsLWIU9AKbT1DtW4OkUNe8cx3siynw8DBwtrw5yFx1LfoMkFT+eUDoi
         p0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365716; x=1745970516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/T4n7eT2yvThTB4kxOGVUmvDFNy5zFwlyk//MmWtzN8=;
        b=J383FH66E18MJhwW5y+pULtUG3yKEaa6TlVFJg9xbZ+68IXAv5Hj/9+Hwb263vLzp4
         a+OAUO67IWDCun/V0kOSXBk8rj59QvN8u+4X2IjWLvZJcdNt8wg40eBggYmx7i52cMUX
         qYsh6UOPRaTSOfAdHMihC2A7IR3wSqGjWCcY6eJeuLBKuA3uCg3yUm5qF43cOiIsVHqZ
         L1uFVhEhioaMhWUdTZTw1Gkib3+S7Hj4knsoiyr7ZfpT7fAZoPOMo3+BK6F4BF4zodI5
         RJrwoz5Km/7atWRoN+SEYjWygRcb8NTHG2JDTz7RsOCY/w61NkYAcdYWxPU92PqGAM7n
         EcNw==
X-Forwarded-Encrypted: i=1; AJvYcCU2gY90jre/FmvmQd6fACr8Zqdcqyg5a/3EytnzUFuMCjdlE1Hy0OC8QzCKFwewYQVU9rQV3rL5QKUku7Ey6OisJv7s@vger.kernel.org, AJvYcCVKbVej5njMAy1p8Q1DJdOvpl/sZTf1I/C3kDJ7w/yVjpAYMjoe8mxEnhJRPoGz/gY30Fs=@vger.kernel.org, AJvYcCVQvmk5YouQaYMdBqNpis4lXgLpzXrg+qKsL3wdODRaA+0CSqb5EJsAyHuUToTCXI/xXTL1dj9tLd2M8H0W@vger.kernel.org
X-Gm-Message-State: AOJu0YzExomLMbUwH+oxG7BNFb8vtTw/So+Up97JDMwSyMvEK958XKxF
	1lmKRVidHUu3bqyxh7hVWnHRaJKAYvsP/p2wlIgZ9E4xmhdnbZF+ewcyBtL7BP9dL8vdNRCuDaB
	m/NpAmW8IRBDeJUzVaQanbkSC/dc=
X-Gm-Gg: ASbGnctdJloYWFr/lDV6ObHMcY5Jw2ualr0AGFAiiQQv1IBX3JIwSYAAkDVqbdmky9a
	iL0b7/cKoMV0F+LX3jfH6+9yeHVHHNxeJKma0IgjdkpZHaINi7nRIu18DyHSR/hCFGm6FLs4W2K
	yXembeW+Yn6e9bP0/UTxY8iIlj2RnTUtZGy7w02CKXtZKVt/xd
X-Google-Smtp-Source: AGHT+IE/cfyW320QN7e2YH8z4VwCt+2g17zoxlHkihvKARmmChOcfHoT1nkyOotigKo3cVljNO16ENdC/KODxI5jmmk=
X-Received: by 2002:a17:902:f682:b0:224:912:153 with SMTP id
 d9443c01a7336-22c53573d25mr279635655ad.5.1745365716243; Tue, 22 Apr 2025
 16:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-7-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 16:48:19 -0700
X-Gm-Features: ATxdqUGKqzGrekv4T_CT4GfXqWxqXqp67BVlWdwUn5g5QkGiHwxAY7ax8NyaRKI
Message-ID: <CAEf4Bza9e1ixnLZgNjWrMZYZwrz2pByVnyfDywX7bUe5p5Kw3g@mail.gmail.com>
Subject: Re: [PATCH perf/core 06/22] uprobes: Add is_register argument to
 uprobe_write and uprobe_write_opcode
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:45=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The uprobe_write has special path to restore the original page when we
> write original instruction back. This happens when uprobe_write detects
> that we want to write anything else but breakpoint instruction.
>
> Moving the detection away and passing it to uprobe_write as argument,
> so it's possible to write different instructions (other than just
> breakpoint and rest).
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/arm/probes/uprobes/core.c |  2 +-
>  include/linux/uprobes.h        |  5 +++--
>  kernel/events/uprobes.c        | 22 +++++++++++-----------
>  3 files changed, 15 insertions(+), 14 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]

