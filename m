Return-Path: <bpf+bounces-48025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C280BA032B3
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A033A5381
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0787D1E1022;
	Mon,  6 Jan 2025 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0uTboH0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639C1DF984;
	Mon,  6 Jan 2025 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202394; cv=none; b=erYUs4ftb7sSdriB0ZHKh/q699In1dcwbB5Fznad4N9W18g40gbhXutwyU6LdBCKKlOZ2LR56dZio/sWqGU6FE41gbg/ZBEsMYsMCWLHPlCRb6Sv55mjX+pmTAhdkzDCpPi/LQy4MsFNYW7FAVOOpuXaeUHl71IyByA+kYLHWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202394; c=relaxed/simple;
	bh=TNuji7yGFIxkYDH32sB5KdcZZnGUOoRKnUcA/08kbTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sgp74uRL7K+vr7NQgDRTpYqw66TVTAL0k8NMmO9xRMVRi4hRrlFWsaKa1Pw8/ySIwYtESJG0Pm8jXTjNLBZabQzDiwTJMb5n4dKgLiavIe76q0XszydJ1Wjh81quC1dG6RPgojnqoYXpFRXWt3cwcz/BissNv8n6e9QNMi4m6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0uTboH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4561DC4CEE1;
	Mon,  6 Jan 2025 22:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736202394;
	bh=TNuji7yGFIxkYDH32sB5KdcZZnGUOoRKnUcA/08kbTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F0uTboH04I25jxIKikNozWCY1E6prwraszu5O0CRpz9zntw4rqj4QtK8J1rN+dSb3
	 rpt9ULukyDQebMMiJWwufOMo5mX7pl+X+v1S3LZN422oQP+zoXnU8GpBfqlI469LqV
	 h8DtuYzAZGaG8GVbaJ8/EhsOsw25IZfcKohoLdP0qzSPnYKjTSbM+iRP+OqQC5765V
	 g/Brxr5Be2J10Xxl0I+GdFXfTNWqjKT4kdm2TCmQmGIRq0KWAYwk6tA0ahx9CceVD1
	 LjmP34MYAQWhGtbgRkuNJsT2Pox5DEtp050ghuLtmjp1VDTDuoPJ5RdZxIg0xhsEuB
	 IGMjN6SSOMCmA==
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a7e108b491so131078085ab.3;
        Mon, 06 Jan 2025 14:26:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaWEp7mkDa+JK9qYl1jmJ7UlBI8Sx0SslTWHWDIrJBRsUFK6rqgwyyPwF8B1DjOuC4zzOXe3D38yx5RObcnJBMQA==@vger.kernel.org, AJvYcCX4j9xKvavPN7oXUCUl3vDNal4NHXHTyJfOY/bU8KGiZf70ZlDFVhEI8g8O+w8BMC1om+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxtbafMRKwk7jPHT9OsFs2zir3/mPSO0kmHy8QCO8o4sJPDPjV
	2LzHW2REK+/YGqye/JrM4ZUTmNi00xzfvxxUwxib6r19wWvarOzk57osUBobkgJxllZji7ZJcC+
	RJ0pKToRjxo0+zeUAAZsbfYgEi7E=
X-Google-Smtp-Source: AGHT+IFxM1xxftCjiLsBhkqGrxYkF+ornncsF7iKZN89joyHHvSK4AHqwX+iETGt/Ko6l0u5rSFFXqb25GuOlf+9IK4=
X-Received: by 2002:a05:6e02:b24:b0:3ab:1b7a:5932 with SMTP id
 e9e14a558f8ab-3c2d514f756mr498520015ab.18.1736202393670; Mon, 06 Jan 2025
 14:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106175048.1443905-1-jolsa@kernel.org>
In-Reply-To: <20250106175048.1443905-1-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 6 Jan 2025 14:26:22 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5p9C+0oLbec=bxZPvoEuPpAbDzbyPRD95ucBP=7HbO8A@mail.gmail.com>
X-Gm-Features: AbW1kvYm_Smfs6spVFSXtP1_BJRUrDwkckOkK8mi6e6n_XFNla-sxoAHJpdhEIM
Message-ID: <CAPhsuW5p9C+0oLbec=bxZPvoEuPpAbDzbyPRD95ucBP=7HbO8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Return error for missed kprobe multi
 bpf program execution
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:50=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> When kprobe multi bpf program can't be executed due to recursion check,
> we currently return 0 (success) to fprobe layer where it's ignored for
> standard kprobe multi probes.
>
> For kprobe session the success return value will make fprobe layer to
> install return probe and try to execute it as well.
>
> But the return session probe should not get executed, because the entry
> part did not run. FWIW the return probe bpf program most likely won't get
> executed, because its recursion check will likely fail as well, but we
> don't need to run it in the first place.. also we can make this clear
> and obvious.
>
> It also affects missed counts for kprobe session program execution, which
> are now doubled (extra count for not executed return probe).
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 48db147c6c7d..1f3d4b72a3f2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2797,7 +2797,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_=
link *link,
>
>         if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1)) {
>                 bpf_prog_inc_misses_counter(link->link.prog);
> -               err =3D 0;
> +               err =3D 1;

nit: Shall we return -EBUSY or some other error code?

>                 goto out;
>         }

>
> --
> 2.47.0
>
>

