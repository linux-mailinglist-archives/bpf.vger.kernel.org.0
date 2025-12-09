Return-Path: <bpf+bounces-76353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D5CAF6AF
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 10:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9CD5300AC0F
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 09:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994812D3EFC;
	Tue,  9 Dec 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0aVijUE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D72D0C82
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271685; cv=none; b=G/f5Cko5xAobPiGxtKUtTE1CSOpRzB+bjJjYuk+ZNro7377pvPkzy141MdizRdLaCkpU/e+eTnAykPAWh1EvpRs6gDZvjmU+CwCayBS9tIlaWblbqSpOgNnUj4Z7ciWpkB3cCWrYHYPtMaTZ9P/lKHULeTet9Gsr9HlOB1PzJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271685; c=relaxed/simple;
	bh=N26qY+uaj6JNQM7VXezh/HJwNU3ab9OCLAQ4Y64q/r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCi/j2mEoEzURFcRby7xP8QURIrTZXz9n3s/nlpeaE5AFONeWgxgGEV7UGAMhhPov6Bi28WhEjq6suxKF67pZ0vOgKnLNJZI1OvGvZycw4u/Xn2VQr/TNl5AiiE79vBp59Hdx3VGPIVvVfRYA0CI90mPauGLtPI5P1fC5DQRSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0aVijUE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e40582eso3158066f8f.1
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 01:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765271680; x=1765876480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/RgdFlUmbmDluQPV51flDGluQw/fVTlEsLTCP8HYqg=;
        b=W0aVijUEIXhpz8p7676jnu8tsAZp4olN5qdfiYNySFjF5PRqx/2HVYB+vYSxzpisr3
         LqgHFVjf4xzQSSclX5glC/410bzEXlTLOxkwN8um+K22Lwd9mHFH4kvNcN96Rd5Dnz6m
         URzKzmEqVXdYTYYrcTwoNWtj4bVxUiB+G0FAlYpcv5VeFMi3CnfoG38MmFys374F1U0s
         TAgwj1H83One6I3R23TSD5CwBHgJm9Eddq4Jrq2Y1QanXArvo9lqo5OGaTXj82dv4WaT
         KBg/e048ihxBuH3VjAFfsUMOmJKQTsKSd0vFOTEwAfeuc6tXyE5lHs2LYHa7H0XxLfPy
         h5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765271680; x=1765876480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p/RgdFlUmbmDluQPV51flDGluQw/fVTlEsLTCP8HYqg=;
        b=FnBMuIdHlrQ7XjbbfG5rJTqvwvBDD7E6BpH8UJIKWzBxrPKY7Lwk8YS/zBWwYK6k62
         WI1+7LZzr9QMfe+WrHuyPgymZBeYzYulmWDXdpeCMiQTmG5M6ymtj6V3ww4YUFphxFBV
         bgyQUh4vpO5hMlYIoZen+3m7sdD2ii2qh0SoCVDhA/POiNHiMLe2uxO5EU/kFJ44oZkM
         07EC2+5ODVDWSuVaMWnLma8baE7LxQAmcs3/6SLhfEmjGFqC+TJHhQ2vv7YDc8iSfLlS
         XL5DPtemQtVcWUH532ddO9BgbLrIJAtpo4JN/cYqZkOayp64TBxw0ImkTt4oySxuQKPz
         qNxA==
X-Forwarded-Encrypted: i=1; AJvYcCUGHncBlp/3eWVKdyvYBl7WHoyai9QO8yYdXyTmHfGMNjLykUs8FJ1pUVJ7jGoHeQ2apBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5mWkX/0Ph7gg5SZBMP6oYw1MhsTL0gQqcKG2m2iLubRrDa87
	Hkmx6XcCnun/dTckunHIGSYoaPT6gDRUIaG6OndUgyN2hr9Rz540zxzjTWNrjdvkQPqJm3ymes7
	4I3QUHl9GkwU0/ywv/zPFAGEsjDGMJPo=
X-Gm-Gg: ASbGnctabf4TkSMqKozHprNiKLPu+AuGgvGdKxe3+9DWkfXhzQYCzuIx2480QNWbSvR
	HPhpoMjT9107AXyhtf9LfalBYFilDDRHfAU19Bb4mC9iB9DoGBCKXJGUmI8tGAuE22d6gKs+WjJ
	cejyOsjTMtg/oDOJuz7ojytIQbpZl1yLxf63zXn3S28zQ/yGbv/wth7q+uf1HEIrk3CPqFXW882
	5Kfqrlkb6FejTGBU45/zHZrLtwKctxq6U3fSigy2OWiK0XRgI+1ivvUpFRWSYzkvRf36XHU
X-Google-Smtp-Source: AGHT+IFVwRkZi1EgNcah6OfQ6cLKyEOV5qJpg6T37GuxvftOZhr0BlT40QYtuEQo47dvEFSAayWrv/1z05fjiNL1pjA=
X-Received: by 2002:a05:6000:2309:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-42f89f50c82mr9781471f8f.43.1765271680515; Tue, 09 Dec 2025
 01:14:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208154846.2901693-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251208154846.2901693-1-andriy.shevchenko@linux.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Dec 2025 18:14:29 +0900
X-Gm-Features: AQt7F2rTAPlYz2q7zZpT6VxcDFzJHkEBeS5k7XmGL3BRD4qYFd7conpkqgasR_I
Message-ID: <CAADnVQ+ZRw+B_=4UVKhecHuMS5-Y7gKWx6N=LYEPyRuAFg8qAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bpf: Mark bpf_stream_vprintk_impl() with
 __printf() attribute
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Mirsad Todorovac <mtodorovac69@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 12:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> bpf_stream_vprintk_impl() is using printf() type of format, and compiler
> is not happy about them as is:
>
> kernel/bpf/stream.c:241:9: error: function =E2=80=98bpf_stream_vprintk_im=
pl=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format at=
tribute [-Werror=3Dsuggest-attribute=3Dformat]
>   241 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, =
data.bin_args);
>       |         ^~~
>
> Fix the compilation errors by adding __printf() attribute.
>
> Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/bpf/stream.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 0b6bc3f30335..4bff72e3c16f 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -212,6 +212,7 @@ __bpf_kfunc_start_defs();
>   * Avoid using enum bpf_stream_id so that kfunc users don't have to pull=
 in the
>   * enum in headers.
>   */
> +__printf(2, 0)
>  __bpf_kfunc int bpf_stream_vprintk_impl(int stream_id, const char *fmt__=
str, const void *args,

same issue.
The addition of this attribute doesn't make any difference, since kfunc
protos are autogenerated from BTF and it's not there.

pw-bot: cr

