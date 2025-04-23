Return-Path: <bpf+bounces-56518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0AA996BB
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81562465E38
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ECD2798E3;
	Wed, 23 Apr 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJqmfLbA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DE1F0988;
	Wed, 23 Apr 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429617; cv=none; b=dF2w9RZ9OLTRlZ7Gsl2bMvh8GFDcnzjUZMXQ+JZ9iqGG3OiGDYxocmzkWZi70mFz6jhQLoCisKav4FfKRxKQYz2tRn43Lw2GbOnOOFtKAzIwpZ6tM6HUH2DXm2EQgCpPYuFfiNnko8FFivMRe5PgTQJDnFzuH4MlNOCSa+DKOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429617; c=relaxed/simple;
	bh=JPOBe9g6g94eTDQS9U7ZdFDK4HkeCt1AIzRSPtvN1YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPgLEqe0NJBq/LsP4Nbz3nVA9WFq+Mvp7pmk7Ram0qAXJQWno9Ic5FMLnfmoNSG1sUffg/xum+JSqpVdDBO3arMBezy7hEzsQgevRf1MTUxtlJgy3uYl8Zr5rb1St8S3l0ffpKvNNweNhNV6A+qYzDV2n5XbXfIgk3ZaZVup5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJqmfLbA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acbb85ce788so25740566b.3;
        Wed, 23 Apr 2025 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745429614; x=1746034414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOxS1UQQ3c2fDDVHNEtps3Saq1mNzAZtSfAkoVw7BfU=;
        b=RJqmfLbAECuz/kPRLVPI5dIO7YocQrdhVRU+q1hjS/8kYh0+NJda0RNfGB996IrHgR
         yIJjWU7Kt5fvFM9wIkkm/hg44GbUj+x3bLrx/ibm+INhvgyAYRINoV8FZ5BQBOeXQjoL
         cOvAYRHVuz6jhMeV19xZOWq7J2HEMdSdprAyLsSnc+4n9xte5IiNye73yMUXvyYaM7Qv
         o+wg+Eorypdr9lYhFbLucF1EnLYIBhETO0fJCh220hLJiNj5MFAsTpyHlnze7I584uu6
         G29IhBvONpuxkq1AbYMrfQinPPd7CW/t2IOWx1sn34HVjcVSQwfS+j49Y8d8zruaXxxD
         u0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429614; x=1746034414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOxS1UQQ3c2fDDVHNEtps3Saq1mNzAZtSfAkoVw7BfU=;
        b=gpZ1L+71j5CJvBCI4O0ayQmlsBW0kYJo7PA+Dg6xd90NEAGpHdUXThZZ7hj2y5/zJR
         AiHoNJBIQRrY5uFrAgrbHii5MIyW7qcvBuOx3awf8AftKPz7R0CH+pIhyUOuG39vwWx3
         RgKd5JSMiWvKqwB+4Dr3nh7TvETmEaZZ1VktIETVDVibocwKQS6W9NobvbsoI35cR3BS
         L+gCxZd33GXOChfImqaGS8VlfyHa2ynlUgGjp6MlzygCJ4SsYrI0XRXFiGf+3K6RHR5P
         if/pW1v98D0SmKD3igYYYa0HleOEIkOgn5qtlswSd1Y6XTIh1VZRq8OKoCpv1S7PEQg2
         JK8A==
X-Forwarded-Encrypted: i=1; AJvYcCUTw6DYlgUdKFY+LnHIioe9W1C3o0TfGweiX6Fefu0FJ42HwuHaQeiYRxr5n39uFFtUKJ1ylCsO7uS5DziZDg5jI8fP@vger.kernel.org, AJvYcCVJyKPLTGOCNKaldciobxtQYmQPVHk325Im2iPq+XedqTrfBJ0T6IWfzvc6x8geDwhfr0E5U/+5lCd4sif/@vger.kernel.org, AJvYcCW/0VJadNgIkYuItaZ8kgtjmm7XLMtYAngDB7iYpmqI6PzUIiqNcMQ3oMJ6sP3oCgyie6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTaV0jjyexkQpNZt462uEabQHb8GuJ7NUlwwEwZWX9bMxCDB6
	/RJku6fyb8FZjKiXIyoQnnytS4bV6kZHo+bJzquJ8BagQZW0QaaxPFzCat8O2Y8yf6tv3wODcHK
	N7PvVm+AIQP0hGMoq/065SMxYtps=
X-Gm-Gg: ASbGncuueCbEEZ7qMrEnGluzoJrx6r4MG6G3M1JD3XpGo/RSPeEv51WD79y2aPPh/Dz
	a/da0nZWEHwDhQAclpTbcPvY+Q/NPGw1lWl0BNy2pE/ZsO2Al6vUrlMKKNdQQU31BXSOZcMmGDM
	pABtoOwppyaGcPH4muh0XxhM7dmWVZvLsdM24qNQ==
X-Google-Smtp-Source: AGHT+IFYXcl6J+Mo4CdXHQUsaQdz3iB0dtTGgvwpmqh4GA7rcN3cSmqr9npM5wY3l/J3KUQGPBg4Sg0XkJT7uz/us4E=
X-Received: by 2002:a17:907:d29:b0:aca:d4af:39ed with SMTP id
 a640c23a62f3a-acb74af4362mr1901996266b.4.1745429613339; Wed, 23 Apr 2025
 10:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-12-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-12-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:33:18 -0700
X-Gm-Features: ATxdqUFqRXEcECOhlq4qXwN-uOpHfxEANQ5tes4UmS53WhUB_RLht1fRyGG4QoY
Message-ID: <CAEf4BzbxCqgPErQVBV7Ojz23ZEqYKvxi0Y4j8hq6FgXVvdQo9A@mail.gmail.com>
Subject: Re: [PATCH perf/core 11/22] selftests/bpf: Use 5-byte nop for x86
 usdt probes
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

On Mon, Apr 21, 2025 at 2:46=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Using 5-byte nop for x86 usdt probes so we can switch
> to optimized uprobe them.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/sdt.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>

So sdt.h is an exact copy/paste from systemtap-sdt sources. I'd prefer
to not modify it unnecessarily.

How about we copy/paste usdt.h ([0]) and use *that* for your
benchmarks? I've already anticipated the need to change nop
instruction, so you won't even need to modify the usdt.h file itself,
just

#define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00

before #include "usdt.h"


  [0] https://github.com/libbpf/usdt/blob/main/usdt.h

> diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/=
bpf/sdt.h
> index 1fcfa5160231..1d62c06f5ddc 100644
> --- a/tools/testing/selftests/bpf/sdt.h
> +++ b/tools/testing/selftests/bpf/sdt.h
> @@ -236,6 +236,13 @@ __extension__ extern unsigned long long __sdt_unsp;
>  #define _SDT_NOP       nop
>  #endif
>
> +/* Use 5 byte nop for x86_64 to allow optimizing uprobes. */
> +#if defined(__x86_64__)
> +# define _SDT_DEF_NOP _SDT_ASM_5(990:  .byte 0x0f, 0x1f, 0x44, 0x00, 0x0=
0)
> +#else
> +# define _SDT_DEF_NOP _SDT_ASM_1(990:  _SDT_NOP)
> +#endif
> +
>  #define _SDT_NOTE_NAME "stapsdt"
>  #define _SDT_NOTE_TYPE 3
>
> @@ -288,7 +295,7 @@ __extension__ extern unsigned long long __sdt_unsp;
>
>  #define _SDT_ASM_BODY(provider, name, pack_args, args, ...)             =
     \
>    _SDT_DEF_MACROS                                                       =
     \
> -  _SDT_ASM_1(990:      _SDT_NOP)                                        =
     \
> +  _SDT_DEF_NOP                                                          =
     \
>    _SDT_ASM_3(          .pushsection .note.stapsdt,_SDT_ASM_AUTOGROUP,"no=
te") \
>    _SDT_ASM_1(          .balign 4)                                       =
     \
>    _SDT_ASM_3(          .4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE)     =
     \
> --
> 2.49.0
>

