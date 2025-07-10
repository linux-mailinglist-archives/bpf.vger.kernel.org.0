Return-Path: <bpf+bounces-62986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 049ADB00F9E
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 01:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195C51C43C83
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C342FCE36;
	Thu, 10 Jul 2025 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw6XaIf0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B62FC3D3;
	Thu, 10 Jul 2025 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189916; cv=none; b=p/gZ3ifLPoOGxafS+jnWUanQm3ljCjOc1FpNSrFfCmQWwV9RmV8wDk4O4gTX+XQv69NDF/dAo/rB9OCPbPCM6tZqrAFSU/5NfOKds4SEvFIXvC3X5bXj94piqZy8wMu5ScCt3E3JZnDr+VxV3iv+05xZc3DO5X5Oi6a6qQs67Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189916; c=relaxed/simple;
	bh=slRevD8LfbP4w5Q0AhfUiGS00fOZe4bb8PYJ4yt9CZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIEC7WB/fjL0BTo1CNNOAlZFseRGZylZt+Qc4YQxtCPdcSVGg0+phQ6STXAitW8pFIQjRFA8GNohtQr4cpeFb7y4VjNTioEQrW41bCf4fUAVgLLucGLcCDSbl94TCB10DigO/mT5Pb6ZB5S9TPmIrFrjchBumEGCyclnfqUeO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw6XaIf0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747e41d5469so1664343b3a.3;
        Thu, 10 Jul 2025 16:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752189913; x=1752794713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9pse6W8keryYeEzjxOpW9abD7sxV45dg8IQWQ02T9I=;
        b=bw6XaIf0nB3SfWfJqWQMs2RstuEePbpsEh00qPBOEEY2X+VYcv504O8t/tZlyZ7Tkp
         qAxnAF46CRRD6P0AFHAs+LSba3Pgbj+h5BEMexJ3hv8Q0sEYPr7kkCpbz3Hrbb1aAxWu
         nkqryhzOKeimSCjCnHhvumzFXY6K9HaBS8+/FIaMFvGN/P3sEuyP/OrQ32QKQuqs4Y+W
         ssFA/31reNS6onVwC/VQFx43Ht0+jugnEGz0SpGiK3GJNO/gN2GwdpN35wooOq5ko+AC
         D3RDDEqqmLMl4uxO72QI4jWPtXMyFiNZs7PA4JqaN0xlYCayNZDa22LUoqHBYgwyaa1O
         SsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752189913; x=1752794713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9pse6W8keryYeEzjxOpW9abD7sxV45dg8IQWQ02T9I=;
        b=e1z7viUwJdIzuegGveIFvOWQNAo29IxLUTdWhGNwccE396T1SlyK2PfHChNqD1HKuC
         6urTo7+tMdUVZPrlHLzpB6DXWxNXzN2LjDsjMwOXX3/YvWHe8h1MeuOiVIotYk9cfKb1
         SuWs/G7JW9SaOqmNlD1igtqDsxuLsAT0TLg3In/hIjz+/Be+eWMWKpW224DoUz9mmQgA
         YLQxrSGiB+x0k1LFLn5QkmcWQM8EaxrTonuc44Lo7b5WqLVgN2Q/GjSFdDXzAl/QZUu5
         wr4zYgQ/SnsUmU7mVAG3TbGRxhhsMmyVVWIa76+vq6ib1Yzz+ZzoOo9pwXpGEM0PFj1H
         Sg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYhnkPwTZOjVcHg8kjILP7BBcYaGYtPSLvMJc7C544mdL99zClSm+Hs3pkR7G7krJxgdIbzxXDgl/7J4EV@vger.kernel.org, AJvYcCXPctZ+XRSf8Zt6DqaLzqTMxbhg8Zwzi7afM6A2nBkKYW+nUZ3oeiczYzkwYXPyrQjF+BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQVZ7zS9aC6cT6JrPNBoi8K0er0fVScoR2uWyMfc0aQB2fE+e
	h5SbGZh6Nz0RFAuD1alz8jeWced5Q0y6E2iKaDdSKrsJY7hZwXpMFuOCP35SqzgZrfL82rqywuz
	DxbjqH8iOZvDCpFTGPOaTKnO4WT5ub9M=
X-Gm-Gg: ASbGnctFm//PbopmNXC6trmhUQ0PcPcv9hMAJDYOLL08r+ujUopn7rU49pBQlYzuQ9V
	PfDmge4T39JR8h7EDXeBdOW5ezueTDl/ppm5nDky6jECenCK3PAKBpmvXJZBGVpYa1CFOvDpoGW
	+FAvsmogL5ZPhP1NWhh4/qP22tPQI6cJl4P8itFmDibr6an7Xb1ssq80a0d0zyEL4U3pqqPuksH
	MoM6RYzoUJ8stw2DXQ8/40=
X-Google-Smtp-Source: AGHT+IEoFipJTpc/Xo4Pu/qg7vkho8GyMuHg9/m+XmCHamqvbryQ6LC5kEsei8AQZs2+GirP3+ajKXpWMf3ii8P3r0Y=
X-Received: by 2002:a05:6a20:d50a:b0:220:1af3:d98f with SMTP id
 adf61e73a8af0-23137e8e31emr1087286637.26.1752189912989; Thu, 10 Jul 2025
 16:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250710070835.260831-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Jul 2025 16:24:58 -0700
X-Gm-Features: Ac12FXwag-h-QSgVd1M5EQUYajFbo2b5LFCWENZjNkwoFpteCRBdZ04uJctmcgQ
Message-ID: <CAEf4BzZZRk0Ko64wy5E34wAa3psk07UhGg9DENU-CQYfLwT1ig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:10=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> For now, we lookup the address of the attach target in
> bpf_check_attach_target() with find_kallsyms_symbol_value or
> kallsyms_lookup_name, which is not accurate in some cases.
>
> For example, we want to attach to the target "t_next", but there are
> multiple symbols with the name "t_next" exist in the kallsyms, which make=
s
> the attach target ambiguous, and the attach should fail.
>
> Introduce the function bpf_lookup_attach_addr() to do the address lookup,
> which will return -EADDRNOTAVAIL when the symbol is not unique.
>
> We can do the testing with following shell:
>
> for s in $(cat /proc/kallsyms | awk '{print $3}' | sort | uniq -d)
> do
>   if grep -q "^$s\$" /sys/kernel/debug/tracing/available_filter_functions
>   then
>     bpftrace -e "fentry:$s {printf(\"1\");}" -v
>   fi
> done
>
> The script will find all the duplicated symbols in /proc/kallsyms, which
> is also in /sys/kernel/debug/tracing/available_filter_functions, and
> attach them with bpftrace.
>
> After this patch, all the attaching fail with the error:
>
> The address of function xxx cannot be found
> or
> No BTF found for xxx
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - reject all the duplicated symbols
> v2:
> - Lookup both vmlinux and modules symbols when mod is NULL, just like
>   kallsyms_lookup_name().
>
>   If the btf is not a modules, shouldn't we lookup on the vmlinux only?
>   I'm not sure if we should keep the same logic with
>   kallsyms_lookup_name().
>
> - Return the kernel symbol that don't have ftrace location if the symbols
>   with ftrace location are not available
> ---
>  kernel/bpf/verifier.c | 71 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53007182b46b..bf4951154605 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23476,6 +23476,67 @@ static int check_non_sleepable_error_inject(u32 =
btf_id)
>         return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_i=
d);
>  }
>
> +struct symbol_lookup_ctx {
> +       const char *name;
> +       unsigned long addr;
> +};
> +
> +static int symbol_callback(void *data, unsigned long addr)
> +{
> +       struct symbol_lookup_ctx *ctx =3D data;
> +
> +       if (ctx->addr)
> +               return -EADDRNOTAVAIL;

#define ENOTUNIQ        76     /* Name not unique on network */

fits a bit better, no?

> +       ctx->addr =3D addr;
> +
> +       return 0;
> +}
> +

[...]

