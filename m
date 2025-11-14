Return-Path: <bpf+bounces-74540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE71C5EDDD
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB8A84E6029
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2A3451AB;
	Fri, 14 Nov 2025 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNwVH3tU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BB33AD9B
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144547; cv=none; b=JPBXf+Cm0o4pLRfdirYeQRVODIZDIafFr8CDZQWdzL/IwIF0VitwSK6ykOFWe7Zg9CfVayN3G8mWdk4Y9BCFkqqkBySiUwxzJQRgQAnn3aEhnZbiZM7pxby7NoB8u/dw+vUEoOy71/aL3vyjTy4MGvmOee+FTGSB7gfdSzywPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144547; c=relaxed/simple;
	bh=imYTRsAu32nO2XrcQhwaL6kVBM++D7Oc6Tv7+2nAnvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0ZUUGazGdGyonJFhOJJo2p+BI4aIRieYEbrghsrS33m3IMMuPjyiDGd+/qhrm/SyFhMH3GFC3XbkNzgD8PxQH4kRcdVczyJO6GG1554OjxL7Ps0aVtEMo7S4m8fMpc49Ls1miJiVTUg1OprQ6EdEHuSob1DSdBhLwRiVLbGhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNwVH3tU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso1835866f8f.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 10:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763144544; x=1763749344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7zaNp4QyAISIfq+OL9vs0K83HTQEuuem1wMgjVe+n0=;
        b=FNwVH3tUyQZuBJa3KYAl6ke2veAHPF0jdbbHdP7Ov+IcogDA4uUVMnLqN33prXBKZ1
         0olT3Ywwmkqct94T527k87DWo/mXXo6GJxC3d70+5QsOkWzxSucTmcVQ0pFCd0r8okyI
         AUz9jynTZFkFFcjavxtkjlifAKVwO3C3knr626ltNhJ6A/GK48fkFpdn4d2oKJ3sSzVP
         iixWwCJ9lkaTy1K+duUjznLWhfsQc+lEU+//nGS6sWvq8HIll/ZVvHJUR+vza7lnhiVQ
         64xGFpWPOEYV3ikYqwZmL4Yv7+I1P9T72/ChdCtAIrzLfIDBEw0+t8LUaEhqGIb06SDT
         2NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144544; x=1763749344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7zaNp4QyAISIfq+OL9vs0K83HTQEuuem1wMgjVe+n0=;
        b=sk/3fKNMs+vDvZojeXslCZTgGwtxVcxAZ00lMq7wSK/H3VtZdI7A3QtO0QPej4FtdD
         +8dcIjvikQoF21WMnxpfCE5uPpZMWLCo+5etfA8nOMEmjHQuAFUuzR970iHEaF5TWBzw
         Wl7X/XhcmT1UJucjevdBwCGy6rv0/+4AjmPwYwNZwlYemk0DqXfJKS+QG9YSsV+HbWEO
         8HjSE+4uf3vKasIB/vX1USEGC8QbO6le0W6xgcEwx2gk8YdC9ml1Fjq3lxsGJxPyMg0w
         AbnvKuNvvO4IVliCnsr2LkWHeLwwqHJcYTkKp/T+3XlMBLGBHU2J0FTOf4xVq0mhZ60w
         3img==
X-Forwarded-Encrypted: i=1; AJvYcCUXmKTyotN19/rscVPDgGQE6e+rAisB2IbaNiJZyDnI3PVHqUSeFzoUqTM08zkyQyY4aeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjbwH/t4USvzrIgLFJgkYJ/hl1pkAHcUp4MqIh+QsYn5vu6wg
	8OgURJqwxABt4aGuOuavP+FsLjgzV40R9i1kEJYxVnDRYBE09wPxdT5yPuu2SN+H16vn0XbFHQo
	bhs5Ocme8UMps16125v3Kdt1+sf4mn5w=
X-Gm-Gg: ASbGncsNid5GZ9Q45H025jrdriLo/wMo46+F/5FO8YISPwe72OnpxryLdosHl8R/v96
	XQ5J0/nAdUgObqTiv25XV7dtjgQB42nQQ2zaEVatJvTBslDbsYNEOQunxn5aLGy3zHO/qObxfRZ
	5UNhyQIa67hPy2fhmgwOroFyHevxTTdOlFnHKj0TxPkNX1QI0FlDLr3qNnqN5K/y0AZznKMZWa6
	ksDPRbxxLHMzbEPnfIvb4AEhSoNRqsYuwtdmYCGfbmUNyeoIrOwWLL5+vG/xZVbg4V8yZ9DwCjf
	HiSfGwh86NCA/0HuWShk7kWzLHwG
X-Google-Smtp-Source: AGHT+IG0Kw2xcdPae4Ge3vqVJme3ODdIflBSBD1/EEBWrzi1ZyNc3vHqvBzBJwqZfm0LgITTQYw/AgEviQ37QECn7sA=
X-Received: by 2002:a05:6000:26c9:b0:42b:2a41:f3d with SMTP id
 ffacd0b85a97d-42b593495camr4010766f8f.19.1763144544159; Fri, 14 Nov 2025
 10:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn> <20251114092450.172024-5-dongml2@chinatelecom.cn>
In-Reply-To: <20251114092450.172024-5-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 10:22:13 -0800
X-Gm-Features: AWmQ_blhd5UV2QYJwXHHQL6Uwzr5xRWdWmTign3jpn0dkYPClv86ghdInOvoX4Y
Message-ID: <CAADnVQJU39q9amZMuVLzsg7CK5MLT_xFr0K4Bx9zp7P5C6MCRw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/7] bpf,x86: adjust the "jmp" mode for bpf trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> In the origin call case, if BPF_TRAMP_F_SKIP_FRAME is not set, it means
> that the trampoline is not called, but "jmp".
>
> Introduce the function bpf_trampoline_need_jmp() to check if the
> trampoline is in "jmp" mode.
>
> Do some adjustment on the "jmp" mode for the x86_64. The main adjustment
> that we make is for the stack parameter passing case, as the stack
> alignment logic changes in the "jmp" mode without the "rip". What's more,
> the location of the parameters on the stack also changes.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/x86/net/bpf_jit_comp.c | 15 ++++++++++-----
>  include/linux/bpf.h         | 12 ++++++++++++
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2d300ab37cdd..21ce2b8457ec 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2830,7 +2830,7 @@ static int get_nr_used_regs(const struct btf_func_m=
odel *m)
>  }
>
>  static void save_args(const struct btf_func_model *m, u8 **prog,
> -                     int stack_size, bool for_call_origin)
> +                     int stack_size, bool for_call_origin, bool jmp)

I have an allergy to bool args.

Please pass flags and do
boll jmp_based_tramp =3D bpf_trampoline_uses_jmp(flags);

I think bpf_trampoline_uses_jmp() is more descriptive than
bpf_trampoline_need_jmp().

The actual math lgtm.

