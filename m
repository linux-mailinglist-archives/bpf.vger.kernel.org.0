Return-Path: <bpf+bounces-76352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C12CAF6A9
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 10:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75CA930806B3
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32212D3EFC;
	Tue,  9 Dec 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFz9+BWn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95BE2D0C82
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271580; cv=none; b=hSEYrPA/CV6ykYX9OXL99vTF19/gFSSDLolG3hwrY/0B9jOi0mGYyi+429pX+6Pfpke3oqu1iWSOcyUcfXKSjNH6PaNgbmFRQ2EXVGsCO4e39+buREUUxcepMgIoFzp2XW5Ey5roNj13NYsk/oN6WIEQ3Ywh30x1FR3dRS5+6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271580; c=relaxed/simple;
	bh=WbjSnsSd33oZ10Vp+FiT/SiX4TqZ5YsvDPQWRG1Gi44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDAcew8vAp7zG7wQnM6ElFgaYjqvegtryt8wk/2Nd5k7ff5bzj1Nqcz/35y0i4xtFMnaRYFrQV/Mjk85Sgc4GooycKGQK9CXtpgCvK+xk/Vp12E0lwE6miyongli12v16NbSZEwvPjimjyVEXvRL0uLlD41c/VkIJHXALZaZZAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFz9+BWn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2e08b27eso2276986f8f.1
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 01:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765271577; x=1765876377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQderxayc1i8kv0d6XpdXnYLfhnPqtEDACO4gC3cqIk=;
        b=iFz9+BWnMnWy+ScRC92LKfXIc9+qSyNvuVCkmdwMlmK+WfM07NSlWbLSmuPUJc0Ur2
         Oxu6jdxuLq1mmmJxUfPy+8Kf9K61ngeOvVqZNbFd4zwu95WhMYLDqH5VgnV6FSz12GU4
         gFUzdJ4KbpCvAiO2RKwY85AoyD3qXX+dPyyKwjHr4TozVNuHdufAGDodillIg9WWH0TH
         lyEPqpyd7Or0fJ/y3HIQBzfm4YUzEKJmQKEhtS7nnVIr8TCn7ZK5IrLXjN+AjCsZoUIV
         iYWxsibEusQE1Il4nkh0/genjATFCUB3fS7Y8NCk844NwakXK9Lup6jYZ6hK9Tggpk1d
         /g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765271577; x=1765876377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQderxayc1i8kv0d6XpdXnYLfhnPqtEDACO4gC3cqIk=;
        b=o40pM7ilBkpd1PGu0ThCqdBfzrbEyacOEIiC3dsZUSDIj21lGH3mW/E3GKLi5MNIoy
         rl2oW48ROO6oKko9oKCLRHycPWNMOcKhlaqegygn+1JwyLhi56vwJ0+zKn3KGolr4WHf
         8dIuRDUTWNf4QCod5m9PaVyq7TcGI9gYJONYaRJwmY7Ygkex7DUCcl44yGW2mAyUqzSD
         UtC3rYgz1O/TQUi0ZeQtVHV+xixkbz2ks9IXQ3mTy4bQUwSWdcppjKJueDbKhDOY+rzS
         +O2kkFnk4xoNDJErRtZDfjjxgMGfJUFpWF7eyvG8AfFOMIP7EkPXw5JS53zieUZ+w+Q9
         TyAg==
X-Forwarded-Encrypted: i=1; AJvYcCUR15hWDwipBFAi+reRpcFnyNEcOC2cxMPcEFGiD9pyle7N8l8Ivc5pAH/M7Bmt6EFJ0uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQM8QY7g4wqijFJqSLsrZ9A7MTLBW47Hx2wUS6TD4LGkB+Azkm
	NRoIUtUQJoZVCT1FwvZcsgWro1s6Ji17npSWHQ3z240xV+ATXyF3+resTCHsToRx48QxFq/6ERi
	cwDh8sp8q54TCAIgx9rt2LniwlP3Kxn8=
X-Gm-Gg: ASbGncsG9TfTFyj4CnUmx+BR7BSfphkX3RR3OOUxSkO5KFgVIFp+/wAu7ou0tP3Pgct
	tVW6TSETU+HZpODGpAoWfozweVbScKFw2SvJpina/F8IWFbnXZni+HdciRy3AesidqOqEt2HE0K
	VzFiyhnRz8c3/KYYoxzhOOEzmMqt+TM7Fhb2c/bWGTZNyn/6MiM6c8vTEAasieU+dghVvGAoC94
	4/cSd5kllm/EvJEKLZMVXEmGO15gN6FEGqE+mXTLSUNB5Noa88h50GfhWnh7Wuk4ZTd4tyL
X-Google-Smtp-Source: AGHT+IHMPiOvMS5xkT5acnPdKwIr4Tg5qejZsjCuXKHCYW4PO11QPd+DovXYlNPYVGWaJfVNhGm3RaCkEXpB0MKLqsg=
X-Received: by 2002:a05:6000:2c0e:b0:42b:549d:cdfd with SMTP id
 ffacd0b85a97d-42f89f0ab9fmr8988199f8f.2.1765271576957; Tue, 09 Dec 2025
 01:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208161800.2902699-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251208161800.2902699-2-andriy.shevchenko@linux.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Dec 2025 18:12:46 +0900
X-Gm-Features: AQt7F2oWRPxR4yuALpg3IMkY1pGJDDbqEWRCZ-GSXaWTFmq2Ke5N7YWyBUkov1s
Message-ID: <CAADnVQ+SXe-CsPHnYkB4SOKct6iMN=PkexaKRd-MJFhC3i8M0A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bpf: Mark BPF printing functions with __printf() attribute
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alan Maguire <alan.maguire@oracle.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 1:21=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The printing functions in BPF code are using printf() type of format,
> and compiler is not happy about them as is:
>
> kernel/bpf/helpers.c:1069:9: error: function =E2=80=98____bpf_snprintf=E2=
=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribu=
te [-Werror=3Dsuggest-attribute=3Dformat]
>  1069 |         err =3D bstr_printf(str, str_size, fmt, data.bin_args);
>       |         ^~~
>
> kernel/trace/bpf_trace.c:377:9: error: function =E2=80=98____bpf_trace_pr=
intk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format =
attribute [-Werror=3Dsuggest-attribute=3Dformat]
>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.=
bin_args);
>       |         ^~~
>
> kernel/trace/bpf_trace.c:433:9: error: function =E2=80=98____bpf_trace_vp=
rintk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format=
 attribute [-Werror=3Dsuggest-attribute=3Dformat]
>   433 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.=
bin_args);
>       |         ^~~
>
> kernel/trace/bpf_trace.c:475:9: error: function =E2=80=98____bpf_seq_prin=
tf=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format at=
tribute [-Werror=3Dsuggest-attribute=3Dformat]
>   475 |         seq_bprintf(m, fmt, data.bin_args);
>       |         ^~~~~~~~~~~
>
> Fix the compilation errors by adding __printf() attribute. For that
> we need to pass it down to the BPF_CALL_x() and wrap into PRINTF_BPF_CALL=
_*()
> to make code neater.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512061425.x0qTt9ww-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512081321.2h9ThWTg-lkp@i=
ntel.com/
> Fixes: 10aceb629e19 ("bpf: Add bpf_trace_vprintk helper")
> Fixes: 7b15523a989b ("bpf: Add a bpf_snprintf helper")
> Fixes: 492e639f0c22 ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")
> Fixes: f3694e001238 ("bpf: add BPF_CALL_x macros for declaring helpers")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> This is combined change and I think there is no need to split it, but if =
required
> I can do it in a four changes. Note, the culprits are older than 4 years =
and stable
> kernels anyway don't go that deep nowadays.

This is pointless churn to shut up a warning.
Teach syzbot to stop this spam instead.
At the end this patch doesn't make any visible difference,
since user declarations of these helpers are auto generated
from uapi/bpf.h file and __printf attribute is not there.

pw-bot: cr

