Return-Path: <bpf+bounces-75374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0E6C81E66
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5923AA8F5
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612822C0299;
	Mon, 24 Nov 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSEFnz7f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539552BE7BA
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005356; cv=none; b=BRdC0vx8572hJWXPqgHCpJl6GWNOc25Lq96EHb+n6LkEUpIsCj9DsI8XgbWytY1LeqVQSfwdKFjt99wKFEddkOxCOQMphSqDYqs4fNXBm5Eo93W5zarX6FJQaGw3tsyM6KPDuZcQSS5xFfKTKeBy6uew1N+x6rel6G+U6ZKs2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005356; c=relaxed/simple;
	bh=vQIaiItPrd7s4+j9sQD9BtJjnYwflGZSWblq3Wgm1r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcOfZt/cMHeH6N3U4428qxp24zjozAJBWh999Spx7BnaVFc0eV6DQYHW7lIyRqQTtL9K54gzxGaG8ebgZrrBMlwGnD/t6tZfigGugYhteej/o7d6Q8SZCn0SZ9sV9gdvLeLRSDmA287evIr0Kd3U3fXcnIPl1Fhz8HgTI0K6yt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSEFnz7f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29555b384acso56657695ad.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764005354; x=1764610154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyNQHrSogVCZ8/iGLc0RaRTXw46RClVoFosYiQi/xuw=;
        b=MSEFnz7fuYrrbtoNXH76qHwkQjbu4i7OAw+Y3dfvzZJy5xuRJApy1Bk8pRfFVJAgJg
         Bbdy+07u6MFAochgGXDPZP4ULWHOhQRFs9Oo7EAgs4WAd4denkFd9r9Rh94KM9T2psk5
         8CCcQP4eQT+yMM3aKO7uiB9aWnZPQZlzEAf7sEwTY/+4yjWkS31QKH9UXJE0u38NA11h
         D2EHkqKpj6mY6HgKDoBJ/oURclbBkUJJTgvFoFzrgh9Y+4u6ww2EKT5p5u/M9jSBWbpz
         CKFT4Lo1vVWXobR3ElFYZraHZXPgsNzEpSbz4MR6GrewcyTXi2FSxgyT1GQNmpvRjg6u
         yg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764005354; x=1764610154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyNQHrSogVCZ8/iGLc0RaRTXw46RClVoFosYiQi/xuw=;
        b=Vz+jgXINuEpGLKu4tbRXF5okLb5238o9Ok/oLVYZ8tXaAxA54HVRjGz9YEbwh0+B9G
         UmaQnan05IGMnxKTz/neAFvEcFuRBeeaaXXOPax6PPin45OEuMgqa45fTtMoCdwd/W+S
         ckYe4YtUK3sE7n6xnrSAKJxK3mgwhuVUt46HGKGg3x+8FRcbnrC6Ie83q0f9zo/vnf3M
         jX70XDJK+fAFlejkxonbajgz1FBXs2/ZwxsLbFEw7j9cXvgMqLV+J/T/k0X0fVTEP+3+
         JKjg+8KQiZ1Pt7YerNS4UDKeQ/gwURrqiJraOr0Gdfw0fcTzXnkoUMT0ubbNVgBSSwvW
         7+7g==
X-Forwarded-Encrypted: i=1; AJvYcCVStKjCYtK9wY9L+U/tiCOiPcqK7oPnI1PysWJprfHjer09HNyQeV678Phtb4Vbgv0c/aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKY8U8IIMKqfkSTAglzyDn4cXZNbr1tkB69vSlcnSu2vae+Pp
	mxdOGowIhdpK4cmbI2pdVf+m/vtWtD57Zris6Xynkh/gWwwrrJSZZ30VXHr24gQXrfJLppbGdNJ
	aJq4PuPseCNykCoqfMsGn+QwXeq/Ot1zjxg==
X-Gm-Gg: ASbGncuv7AEutQYY2ete/RG/9sHjvUJuib6jRew6PbufFXyQANtFqTcA+ENkSvP4D95
	2Fp7Vc1kreFe/wNpjslZ4M4UOEIHtzx2GEJXLGGJaP/LfQisijamMYUKQE1cA49FAQUoVLZB2le
	4r3hi+aQIxKsEqpr53qoQ88nYKiYV2wCGAMSF0JbGEtf4Uivt1P4Ma+NHgL0FCqjdoLqjL5k1ig
	Yd5eq51edfHRj4s/pK9k5Xl29WTO8j3PnI+c6SLmHUUdQfT7DIlVa10D+OGFrjXb88tks7FJvoY
	0phbvILuAw==
X-Google-Smtp-Source: AGHT+IGQCvnvrVGxu+le6avcfSV1I7c/3cBBKWsXr0j38jLI7WDjEsTFcP5L5MmJOv/oqfOSxfJ38mKjNd9Rb8h0Cw4=
X-Received: by 2002:a17:902:f707:b0:292:fc65:3584 with SMTP id
 d9443c01a7336-29b6c6a667amr136020615ad.50.1764005354444; Mon, 24 Nov 2025
 09:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117083551.517393-1-jolsa@kernel.org> <20251117083551.517393-2-jolsa@kernel.org>
In-Reply-To: <20251117083551.517393-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Nov 2025 09:29:01 -0800
X-Gm-Features: AWmQ_bkLDqBfsvWnE8a5UhmaB22AluL_Ykn1awm8v7ukW6nVB0-DkQx2S5TmQwc
Message-ID: <CAEf4BzaETfgoAOuVgA8r37Aso2yxQRVe8=KxGV7+B9LqPzduXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Emit nop,nop5 instructions
 for x86_64 usdt probe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> We can currently optimize uprobes on top of nop5 instructions,
> so application can define USDT_NOP to nop5 and use USDT macro
> to define optimized usdt probes.

Thanks for working on this and sorry for the delay, I've been
travelling last week.

>
> This works fine on new kernels, but could have performance penalty
> on older kernels, that do not have the support to optimize and to
> emulate nop5 instruction.
>
>   execution of the usdt probe on top of nop:
>   - nop -> trigger usdt -> emulate nop -> continue
>
>   execution of the usdt probe on top of nop5:
>   - nop5 -> trigger usdt -> single step nop5 -> continue
>
> Note the 'single step nop5' as the source of performance regression.

nit: I get what you are saying, but I don't think the above
explanation is actually as clear as it could be. Try to simplify the
reasoning maybe by saying that until Linux vX.Y kerne's uprobe
implementation treated nop5 as an instruction that needs to be
single-stepped. Newer kernels, on the other hand, can handle nop5
very-very fast (when uprobe is installed on top of them). Which
creates a dilemma where we want nop5 on new kernels, nop1 on old ones,
but we can't know upfront which kernel we'll run on. And thus the
whole patch set that's trying to have the cake and eat it too ;)

>
> To workaround that we change the USDT macro to emit nop,nop5 for
> the probe (instead of default nop) and make record of that in
> USDT record (more on that below).
>
> This can be detected by application (libbpf) and it can place the
> uprobe either on nop or nop5 based on the optimization support in
> the kernel.
>
> We make record of using the nop,nop5 instructions in the USDT ELF
> note data.
>
> Current elf note format is as follows:
>
>   namesz (4B) | descsz (4B) | type (4B) | name | desc
>
> And current usdt record (with "stapsdt" name) placed in the note's
> desc data look like:
>
>   loc_addr  | 8 bytes
>   base_addr | 8 bytes
>   sema_addr | 8 bytes
>   provider  | zero terminated string
>   name      | zero terminated string
>   args      | zero terminated string
>
> None of the tested parsers (bpftrace-bcc, libbpf) checked that the args
> zero terminated byte is the actual end of the 'desc' data. As Andrii
> suggested we could use this and place extra zero byte right there as an
> indication for the parser we use the nop,nop5 instructions.
>
> It's bit tricky, but the other way would be to introduce new elf note typ=
e
> or note name and change all existing parsers to recognize it. With the ch=
ange
> above the existing parsers would still recognize such usdt probes.

... and use safer (performance-wise) nop1 as uprobe target.

We can treat this extra zero as a backwards-compatible extension of
provider+name+args section. If we ever need to have some extra flags
or extra information (e.g., argument names or whatnot), we can treat
this as either a fourth string or think about this as a single-byte
length prefix for a fixed binary extra information that should follow
(right now it's zero, so forward-compatible). For now just extra zero
is the least amount of work but good enough to solve the problem,
while being extendable for the future.

>
> Note we do not emit this extra byte if app defined its own nop through
> USDT_NOP macro.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/usdt.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests=
/bpf/usdt.h
> index 549d1f774810..57fa2902136c 100644
> --- a/tools/testing/selftests/bpf/usdt.h
> +++ b/tools/testing/selftests/bpf/usdt.h
> @@ -312,9 +312,16 @@ struct usdt_sema { volatile unsigned short active; }=
;
>  #ifndef USDT_NOP
>  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
>  #define USDT_NOP                       nop 0
> +#elif defined(__x86_64__)
> +#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x0=
0, 0x0 /* nop, nop5 */
>  #else
>  #define USDT_NOP                       nop
>  #endif
> +#else
> +/*
> + * User define its own nop instruction, do not emit extra note data.
> + */
> +#define __usdt_asm_extra

I'd guard this with ifndef, just in case user do want custom USDT_NOP
while emitting that extra zero (e.g., if they have nop1 + nop5 + some
extra they need for logging or whatever).

>  #endif /* USDT_NOP */
>
>  /*
> @@ -403,6 +410,15 @@ struct usdt_sema { volatile unsigned short active; }=
;
>         __asm__ __volatile__ ("" :: "m" (sema));
>  #endif
>
> +#ifndef __usdt_asm_extra
> +#ifdef __x86_64__
> +#define __usdt_asm_extra                                                =
                       \
> +       __usdt_asm1(            .ascii "\0")

nit: keep it single line


btw, the source of truth for usdt.h is at Github, please send a proper
PR with these change there, and then we can just sync upstream version
into selftests?

pw-bot: cr




> +#else
> +#define __usdt_asm_extra
> +#endif
> +#endif
> +
>  /* main USDT definition (nop and .note.stapsdt metadata) */
>  #define __usdt_probe(group, name, sema_def, sema, ...) do {             =
                       \
>         sema_def(sema)                                                   =
                       \
> @@ -420,6 +436,7 @@ struct usdt_sema { volatile unsigned short active; };
>         __usdt_asm_strz(name)                                            =
                       \
>         __usdt_asm_args(__VA_ARGS__)                                     =
                       \
>         __usdt_asm1(            .ascii "\0")                             =
                       \
> +       __usdt_asm_extra                                                 =
                       \
>         __usdt_asm1(994:        .balign 4)                               =
                       \
>         __usdt_asm1(            .popsection)                             =
                       \
>         __usdt_asm1(.ifndef _.stapsdt.base)                              =
                       \
> --
> 2.51.1
>

