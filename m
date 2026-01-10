Return-Path: <bpf+bounces-78441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B97D0CD97
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 03:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25EF3302AB88
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 02:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9B2737EE;
	Sat, 10 Jan 2026 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMZF1YLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44FC946A
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768013160; cv=none; b=cuf4vUkU6wEPSOKV0/Sl8d09Tzn1KxnQvegX39w5RDSueXRHwRxGYOX+LQNtaYWRD7Dm+eMt/7OJDHNZAxbkCcYDpuuU9IJ/u7QLfop8Ejisq7fmFzMZbA5bvPxpp6nOcKnKtcXC189SXPqCxFgsIxkiF0D2ZSsCRf5aKQaPF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768013160; c=relaxed/simple;
	bh=HGS5i/bwK9do9AbGu5Bk+XTcjGjLJ/j4a6YuSB6D8O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MulMm+rw/rUEEype0PZixNUCZyi9cck89LBNyHMd979tJoLQBQYvVN7M4c8vicIGZg6ZSDKBy0V9zDqdkjsQssMjY+imklQ5r7mtoOmV29I8oeYGohhOVaucDs/6VnMbYwc12GsCKQ8GzQqUxupTwJowQhAMV0LLLpmfjDTTPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMZF1YLn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so4170176f8f.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 18:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768013157; x=1768617957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwYbTxY+6sNh9pUQjEhDOwvA5XNTBh+AVIQ+84UfZos=;
        b=hMZF1YLnDNl3dZOGT0ySm6M7Auxlybo1bH23oOmHqpfzRHZPuXrNKBDmM48O2LbwCj
         c56BxfPW+Eep8ttYVCRz8gErGehU2YvGDbNSKBPqJjzG9anvm/QkGMXLr3HK1O04jmX1
         q39IaQ7uoqReWnP/ETz800p3kQhXU5rh/Ckl6w7jmkmvWPuBRkzoLGzOLw2r2ilZ/Nb5
         ecgGF3Gkut7wSJjXaAqGYNrVqNwjBqZuOb6Gi8AxWFjNiqmeeyQTCu3Zk+UB4jI9FY0R
         IXqbG6wSp7GN0BZAUPvWTqBvA0GkMdeaMX7s89FWZbgShFgJ04dXImi8hxpwAYdkUOdN
         XniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768013157; x=1768617957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwYbTxY+6sNh9pUQjEhDOwvA5XNTBh+AVIQ+84UfZos=;
        b=gxNhs/dLDYfpQhBCQ5wNKkFsfO6lQpYB3ZnBK89CWBZkZHf0tk0vGoEYUoBBSbRjCK
         4UFNDAOTUiELJDLb6pO1Y7HL7o3eG1fHvHmorC2cxin/Y5mVhOqnODQANUkANQQZ9ybk
         YNqnrADDV98NtJt42k4QBWYQ6HGiFqtEoSeup4025kzzhiGfSRoWkC+s4AnsnJuC4QuL
         GPJV6WWlc8vz0prYORYtZajaxhaewr/A1m1Rs+UTcynfPt8srbFvCbcA6t5cbUVOtCo7
         tz2BqI9vmvtOo9Ojrb4rSr+H9P/xrTuG0CCRt97Gpbo3ELsvwo+9rp/vTn/v5s12wJG9
         RYMA==
X-Forwarded-Encrypted: i=1; AJvYcCW/ipoh22BetLmQWL9X5CYSIluwdwj6MbAQBLFPM0RDTF1KpNAzKAEuQi3o+hvV6L/B5qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6fn2hmu58PHUb1K1PhTm/BSF3Ax25MkS/TArkj9gZARDGpN8B
	ABoE4cCSgDe2VyKEOx30ZB4rXStWMf8KItCSlNNRMIIxrEIT92JHOKXcvY9Dlj5AFyduJugRInD
	odklVrAkFhyEd7eDw9j7AvPFMmgCpcAg=
X-Gm-Gg: AY/fxX7ggOzp0hDjw2eaREaP2BUq2yvjBPxvhjoWTVHBUdJ/BnTxpskkZvvU6HLmeCF
	Kc1xq7y4KH1lXXmig8tm81B4rfWp4ZY2OTsm48laUz0cYnkVlbmEeZo3pwqQQuykHNagbuHyqb3
	CUgjkeEyhpRqINVCJRgu/Y3hyJDxSWJV+YdShTAXxqjVNKbRbI/nZAvjJdy181biZA/AA37+Oj+
	BhZJ6aYf14JmN5y8ITnH2mKeBZkDyhxrFeLLlYT7v/oL++ckGTqp9kXL14bgabUFvqQQ/sMrcbE
	Z77SzYnHZUKHkHR/Zdx9PQowQXH5
X-Google-Smtp-Source: AGHT+IFyKTbnI4lKo1y4Hh1ZjltMkH97jV1VSUbwqAlhtBFbyTcWPPuOKi4eRAH/l9vVlSh/4LeGMIaozvU/qmPAhC0=
X-Received: by 2002:a05:6000:2287:b0:427:23a:c339 with SMTP id
 ffacd0b85a97d-432c3790b85mr14055887f8f.14.1768013156844; Fri, 09 Jan 2026
 18:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022450.88086-1-dongml2@chinatelecom.cn> <20260108022450.88086-7-dongml2@chinatelecom.cn>
In-Reply-To: <20260108022450.88086-7-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 18:45:45 -0800
X-Gm-Features: AZwV_Qgh-6_3lbLhgq-yUgBHMGqryJkJT_EbPajilXClrF34_Lyzir343UkqXWM
Message-ID: <CAADnVQKUZsEvv64Y-U-hzCY-wc1iTfXTjhFhqG6Nq4fDsu_HsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 06/11] bpf,x86: introduce emit_st_r0_imm64()
 for trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:26=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> Introduce the helper emit_st_r0_imm64(), which is used to store a imm64 t=
o
> the stack with the help of r0.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e3b1c4b1d550..a87304161d45 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 =
dst_reg, int off, int imm)
>         emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
>  }
>
> +static void emit_st_r0_imm64(u8 **pprog, u64 value, int off)
> +{
> +       /* mov rax, value
> +        * mov QWORD PTR [rbp - off], rax
> +        */
> +       emit_mov_imm64(pprog, BPF_REG_0, value >> 32, (u32) value);
> +       emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -off);
> +}

The name is cryptic.
How about emit_store_stack_imm64(pprog, stack_off, imm64) ?
or emit_mov_stack_imm64.

