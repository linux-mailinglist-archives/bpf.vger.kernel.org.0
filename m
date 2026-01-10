Return-Path: <bpf+bounces-78433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC033D0CA2D
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 01:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E43730386B5
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E31E8320;
	Sat, 10 Jan 2026 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWynJcuz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902FBE5E
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005408; cv=none; b=Zc5KC6+MeGX7OYA+uzcmCFy/nYfv42809/7UUqzxKP6cXRJkB4vqJGWRycAr6H/KSu7jPZz/9LvjRMs6k9nC1UfO8DTJkcAJKPLS1RMjcafWuA/GTR2JLVjQJjdzT7s6O41a07xopfsXCP12lZGoYlO5sr2DRZ/sdHUu480uaJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005408; c=relaxed/simple;
	bh=1t8DvjGFetfoU7h6Ld/GQvVam8q9XAieIKTtI6rzuDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGTHTh22BMA2bNCR+adevm4KkLFhnPFcJUQ7dySFvOXGFymx8/L/STOwIX2vb0u/J/lJeWf8qOwhyUaUGjoKTuXNohP063yBq+o/XrTianBnMEcIXmmI8lHoHLfwaDM4ExgLyXCiHr/5hYrl6hFcKIe9uEBgA+d5To8lk9fwLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWynJcuz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f30233d8aso33521365ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 16:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768005407; x=1768610207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/Sig1MBWGXUoKxfbOCjXxu2jOEYhW1igfHgGui3UHs=;
        b=dWynJcuziVoEuXraGdyQueA4ySefy5O1/bGWXvCtzodFWWmLjre/VZNQMiFxZuMFG/
         jCdSxhGmR9AIX/RnMnROH4SSmA/MdNwBaHB9WdY+sYVF67PAmf8+fOEXSY4+/AKEB9Qn
         DN23tH+xB+kF0dmyvPJeGx1Kt3yvzs7Gj17w9UFEuD/OHbzmYs5FNdbkFayaNHw/MsjG
         LRM8Pt+aCVxSYlVlFQntZTWchvVDsWD41bWupPNuKJiXB3A9hWpX1ppnIR0xqhNrKBO0
         Kaakn/soh/Gnb58cJr5CNjxnWCnaPtxiJyR3AISya/qbueFI19Pai1iOzhpbcvJCTlO3
         Gpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768005407; x=1768610207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/Sig1MBWGXUoKxfbOCjXxu2jOEYhW1igfHgGui3UHs=;
        b=mq5AipXixsUfDFQtxS1QDDE3jyVVxjwv+GiQyMR86Pnr78q6AvW4/crCWOx2KMsxAz
         Jkk0G6Cl5GfaNlfNsjmetlwFUTQGsfr1vKCZqJsMQAYSmGODxtz9DNGksjbLxwup/Sbc
         qu+fxYeQN3gQQp5fTdnHSSPkkLHAHXyAf+cYazfLSk9xhNCF7bAVEisUx4KE7oEKsMRu
         oeT6yIw6JVzVh33fluxO8uyoEZ0QQa8dJGN+hNTLnNGzW0kIuC/ZzPhXg5t0OY9YZVLV
         ZzzH8dDSwSfoI0BGA2QTlU/+FKJCmhPdx1obufvYa7omTN267WXGbP+IxWOQRdzbiclp
         FPIA==
X-Forwarded-Encrypted: i=1; AJvYcCUl0weyX0hfVnc7vKW/0mmnYcwY321LuCESpzW3F1DHjVjznZOG/Qdo/auB5bEV7oeIK2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgknZO0LtIl6+rGOUXtfeBBZ/T1lRmwH9FLSBOcusPjmZgVDX0
	kN9CI+wp6+c2nzbNt1hzXMgHQrF9xlTA7TXTypPaiDDyQgkDqK5T3shd2CzAtblWqmihhXmEZZt
	8fI8YCpKa4e5zfOsaTlrOIMEl8LWkZGiTQA==
X-Gm-Gg: AY/fxX4s/Eykq4OJaFqw8h7NaCsM/s+QIRbY6jiRUUkYMjot3LVTJjxvqgdMWXzQzVz
	bYcKL9xivqHRAfDznJPltWcxQ4J2LbhMlIRdgEBq6gCp0Hcv1scN2xWknFBHgt+PWMvBdDyatCD
	Kk3Tg90gy7T8UthSpX918YcAVc1Cpa0UJtnZGYx1cd77nry4AgXuk+n7BAf/tL2iDOESyQ6YujS
	LiSqdQnZitlWKWGxWTLDxOv38FulX8QtQc9LGMadWRhJOsyEEyPGhXj54m4Mb8eT5nPcxRprSq2
	vIi27nqn
X-Google-Smtp-Source: AGHT+IGW3LMlWa2LmuUzjL0YHhtRZgvX3i/6GcmeqaYqFFGz/azPPBWHL55nnnOgoHySU2SkfToBfgTRNf9D9hzsw5Q=
X-Received: by 2002:a17:903:196b:b0:297:f09a:51cd with SMTP id
 d9443c01a7336-2a3ee442293mr104729985ad.14.1768005406895; Fri, 09 Jan 2026
 16:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230145010.103439-1-jolsa@kernel.org> <20251230145010.103439-2-jolsa@kernel.org>
In-Reply-To: <20251230145010.103439-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 16:36:34 -0800
X-Gm-Features: AQt7F2qRw6Vu7cN5U47qL95oQ7_OEFPKSuwkEVWj2hjYGj3mzII7GsGmQwymQFg
Message-ID: <CAEf4BzY6vVCk_XohdYVmjma4k=QvGb+h+rzOe7hmRLoUL7ZXOg@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP
 ftrace_ops flag
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:50=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> At the moment the we allow the jmp attach only for ftrace_ops that
> has FTRACE_OPS_FL_JMP set. This conflicts with following changes
> where we use single ftrace_ops object for all direct call sites,
> so all could be be attached via just call or jmp.
>
> We already limit the jmp attach support with config option and bit
> (LSB) set on the trampoline address. It turns out that's actually
> enough to limit the jmp attach for architecture and only for chosen
> addresses (with LSB bit set).
>
> Each user of register_ftrace_direct or modify_ftrace_direct can set
> the trampoline bit (LSB) to indicate it has to be attached by jmp.
>
> The bpf trampoline generation code uses trampoline flags to generate
> jmp-attach specific code and ftrace inner code uses the trampoline
> bit (LSB) to handle return from jmp attachment, so there's no harm
> to remove the FTRACE_OPS_FL_JMP bit.
>
> The fexit/fmodret performance stays the same (did not drop),
> current code:
>
>   fentry         :   77.904 =C2=B1 0.546M/s
>   fexit          :   62.430 =C2=B1 0.554M/s
>   fmodret        :   66.503 =C2=B1 0.902M/s
>
> with this change:
>
>   fentry         :   80.472 =C2=B1 0.061M/s
>   fexit          :   63.995 =C2=B1 0.127M/s
>   fmodret        :   67.362 =C2=B1 0.175M/s
>
> Fixes: 25e4e3565d45 ("ftrace: Introduce FTRACE_OPS_FL_JMP")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/ftrace.h  |  1 -
>  kernel/bpf/trampoline.c | 32 ++++++++++++++------------------
>  kernel/trace/ftrace.c   | 14 --------------
>  3 files changed, 14 insertions(+), 33 deletions(-)
>

I don't see anything wrong with this from BPF side

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

