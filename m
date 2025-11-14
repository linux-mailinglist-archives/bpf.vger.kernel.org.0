Return-Path: <bpf+bounces-74541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9BAC5EDCE
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A027348DC5
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C2326952;
	Fri, 14 Nov 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka82YbmJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A62D8375
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144615; cv=none; b=FLEXBfqhCAtqmUCzhb8koQdKNYCx211P0Kcmv57d/u4ioqUrgR2hW8Unv2vvJaft6yDvpK3oMm2QHg4tQVAQ8h00HvwkFIyH3b3H/jBDtTtYg6NcGNvVD296kRLJRHfX3XfHPeQmuWMH5EwS8ciZU5FhGDeFnTJ1B9R7O9j+2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144615; c=relaxed/simple;
	bh=DIZzU1eE++/7PwkaZuzWc2ZUYaJDG/bezcInk7fQNjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+vPOTH6j/ureWRsK4o7eGB5GdEtGPP4sc7foqR0ol0WYobnTKx4pFJVmxNXkWrtUNdXwT4WKxfHVXTId8U0FX4zrbDV81zLsBjbiCzb2EbhFxDtXEyhogYm4zpwPWnBK+nfy/cpJa+HqiA3ZhwtqcFrsJ9Oe1vATXPp9Etz9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka82YbmJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47796a837c7so396175e9.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763144613; x=1763749413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUY9Kr5oG1f+82DKYPpC4rF1anZeeoD4PDGJxv92Gao=;
        b=ka82YbmJFzMnDt/17RgDeAZc7VJjHKKVn0JSBGcobWbB4uBfXbIpKbYBkkNMFZPnJq
         UllIm3j4SDpfe+FsOUXTrIecboEFUgJlI6qvRQKqxilGsDC/Q3oduJAB74Id7aBRSM+Z
         84zHv7cmbZ/rdJTdtk7OTfA7Sl5wA0sE7Viu02SF0kpokHawA6gOi0Om1TLQrjGPbAqz
         PRlkdl5PkbMqz6kQ1f0FCvsa6UmtINQ+qvHhUwu+7whbc0JjKbBzHWbvyTRZmO3f5mfy
         BuTX18E71gc2kWttOuGJlj1nFz09fmvirM798V/gZ6qX6NFBAgO+q/OHi9IpVeMM05FY
         cKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144613; x=1763749413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUY9Kr5oG1f+82DKYPpC4rF1anZeeoD4PDGJxv92Gao=;
        b=dcKS4Td2MRynJd/PzURJkzOJrnOihDwV5nJ2Nw6TWxY2Bl/ovK1+3BQ+ttyfDqyrfp
         d58aCq4U95im9m4XhDeYb5rwJMWLZWM4bZMjV4vPKlL7oCKmzWJ1tM/r1ZSU7j87TAA/
         IKR3XvIUL09TvGJFNNY0R9idYW5l1CPBFcvMLSBjNf7at4Ey9Nz9cSFGTlAhDXp+bTzm
         tb055lH7WuAqjTJzJeCcTOoctN5Ay9HoeRvwTO659Psx3oXPOBj2dfWPCEToFXapMtDE
         QFHNHQkSZefqnoEdrc77F8o/nDtC6JWoliBdDgj/rRS3rcv6EqwwLyoIYEN4zJOmI0k8
         jqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMRuBIt/dholUceJE4/ap1iGbfznoz5bluuu4UOYCQdEQryoz+dtD0o4PtkKHIOYWcaWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5dge7R53yvlZV+CqkwqD956FMXgSq/YIXK6bxgXMyMzCqifd
	kglZ07124z9rSi4E10qG9kbugZmpPZp1/FO1eidS8epxvB8IFESr3OUm28GOgqa3sQZOYfTICyq
	cuOc5ZsNuhyDS612fKtgHTlz53FEMZwc=
X-Gm-Gg: ASbGncuvMDyRn+KoxnRxdrUwjb6gymotovLPD9Tf1CNsPdAN4jxjokm8T6TfDLj7KlL
	qpQPc5kYGORuiWpFfbEt0J4X6KeUyspnNvAlPP1Gj8DR24uABOeKMKTUru6unJ7A/S7IgMezON2
	nZKdRCYKHCgwvzn9BL8dqSSrud1hC9m28cTGMtw03lqk9Jb/KckcmC9fr1JArW0XK9zadvZOXEW
	r+kiYZ1fy6ntUwHkkXRS1DW44CJEsgpigWRojODBYUiKPf7Q3BrqFOD6qu9AidBBrLUaccWxlwN
	mVnMTlqVR/RfqIJLpoCGzozn9TCA
X-Google-Smtp-Source: AGHT+IGA5v7xTT5cxBDg3WAJeoMoGbD8RnJobS2PVJO9EoIz/7R/fUKzeMX8ZPKN0rXdHDCxHpeQkTybLa1Qi/A15xg=
X-Received: by 2002:a05:600c:3b12:b0:477:67ca:cdbb with SMTP id
 5b1f17b1804b1-4778febd327mr34647415e9.36.1763144612559; Fri, 14 Nov 2025
 10:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn> <20251114092450.172024-4-dongml2@chinatelecom.cn>
In-Reply-To: <20251114092450.172024-4-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 10:23:21 -0800
X-Gm-Features: AWmQ_blqnXnx7ZZA0_SChClQi1okSMY9gWERi2Y8RHoDySOIVasBUOEu9EtBa9U
Message-ID: <CAADnVQL9cOcQpPkE05p9m8oeZcKSVqMwvF8DnrzNrqT5HozV=g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/7] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
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
> Some places calculate the origin_call by checking if
> BPF_TRAMP_F_SKIP_FRAME is set. However, it should use
> BPF_TRAMP_F_ORIG_STACK for this propose. Just fix them.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 2 +-
>  arch/x86/net/bpf_jit_comp.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 45cbc7c6fe49..21c70ae3296b 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1131,7 +1131,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im,
>         store_args(nr_arg_slots, args_off, ctx);
>
>         /* skip to actual body of traced function */
> -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> +       if (flags & BPF_TRAMP_F_ORIG_STACK)
>                 orig_call +=3D RV_FENTRY_NINSNS * 4;
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de5083cb1d37..2d300ab37cdd 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3272,7 +3272,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>
>         arg_stack_off =3D stack_size;
>
> -       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> +       if (flags & BPF_TRAMP_F_CALL_ORIG) {

Good catch. Ack. Pls carry it in respin, so I don't
forget that I looked at it.

